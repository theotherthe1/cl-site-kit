<#
.SYNOPSIS
    Checks a built CustomContent tree for the mistakes this codebase actually
    produces. There is no build and no test suite here - editing a file is
    deploying it - so this is the only thing between a build and the browser.

.DESCRIPTION
    Reads MANIFEST.md to learn which paths are FRAMEWORK, CLIENT and VERBATIM,
    and never scans VERBATIM paths. A lint with permanently-failing entries is a
    lint people stop reading.

.PARAMETER Path
    The CustomContent directory to check. Defaults to the kit's own copy.

.PARAMETER PreviousClient
    A name that must not appear in framework files, e.g. the client the tree was
    seeded from. Catches a reskin that left the last client's words behind.

.EXAMPLE
    ./tools/lint.ps1
    ./tools/lint.ps1 -Path \\dev-ecom-sofs\Websites\FOO.dev.citruslime.com\SiteSpecific\CustomContent -PreviousClient "Templeton"
#>
[CmdletBinding()]
param(
    [string] $Path,
    [string] $PreviousClient
)

$ErrorActionPreference = 'Stop'
$repo = Split-Path $PSScriptRoot -Parent
if (-not $Path) { $Path = Join-Path $repo 'kit\CustomContent' }
# ProviderPath, not Path: on a UNC target Resolve-Path returns a provider-
# prefixed string ("Microsoft.PowerShell.Core\FileSystem::\\server\share\...")
# which then breaks every relative-path calculation below. Linting a live site
# on the share is the main use of this script, so this matters.
$Path = (Resolve-Path -LiteralPath $Path).ProviderPath.TrimEnd('\')

$script:fails = 0
$script:warns = 0
function Fail($check, $msg) { Write-Host ("  FAIL  [{0}] {1}" -f $check, $msg) -ForegroundColor Red;    $script:fails++ }
function Warn($check, $msg) { Write-Host ("  WARN  [{0}] {1}" -f $check, $msg) -ForegroundColor Yellow; $script:warns++ }
function Note($msg)         { Write-Host ("        {0}" -f $msg) -ForegroundColor DarkGray }

Write-Host ""
Write-Host "cl-sitekit lint" -ForegroundColor Cyan
Write-Host "  target: $Path"

# ---------------------------------------------------------------- manifest ----
$manifestFile = Join-Path $repo 'MANIFEST.md'
if (-not (Test-Path $manifestFile)) { Write-Host "  cannot find MANIFEST.md" -ForegroundColor Red; exit 2 }
$inBlock = $false
$kinds = @{ FRAMEWORK = @(); CLIENT = @(); VERBATIM = @() }
foreach ($line in Get-Content $manifestFile) {
    if ($line -match '^```manifest')  { $inBlock = $true;  continue }
    if ($inBlock -and $line -match '^```') { $inBlock = $false; continue }
    if (-not $inBlock) { continue }
    if ($line -match '^\s*(FRAMEWORK|CLIENT|VERBATIM)\s+(\S+)\s*$') { $kinds[$Matches[1]] += $Matches[2] }
}
Note ("manifest: {0} framework, {1} client, {2} verbatim entries" -f $kinds.FRAMEWORK.Count, $kinds.CLIENT.Count, $kinds.VERBATIM.Count)

function Convert-GlobToRegex($g) {
    $r = [regex]::Escape(($g -replace '/', '\'))
    $r = $r -replace '\\\*\\\*', '.*'
    $r = $r -replace '\\\*', '[^\\]*'
    return '^' + $r + '$'
}
$verbatimRx = $kinds.VERBATIM | ForEach-Object { Convert-GlobToRegex $_ }
function Test-Verbatim($rel) { foreach ($rx in $verbatimRx) { if ($rel -match $rx) { return $true } }; return $false }

# ------------------------------------------------------------- file lists -----
$all = Get-ChildItem $Path -Recurse -File | ForEach-Object {
    [pscustomobject]@{
        Full = $_.FullName
        Rel  = $_.FullName.Substring($Path.Length + 1)
        Ext  = $_.Extension.ToLower()
    }
}
$scanned = $all | Where-Object { -not (Test-Verbatim $_.Rel) -and $_.Rel -notlike 'assets\splide\*' }
$skipped = $all.Count - $scanned.Count
Note ("scanning {0} files, skipping {1} (verbatim + vendored splide)" -f $scanned.Count, $skipped)

# Comments are not code. Blank them out but keep line numbering intact, or the
# checks below fire on their own documentation - which is how a lint gets
# ignored. Handles /* */, <%-- --%> and <!-- -->, including multi-line runs.
function Get-CodeLines($file) {
    $raw = Get-Content $file -Raw
    if ($null -eq $raw) { return @() }
    foreach ($pat in @('(?s)/\*.*?\*/', '(?s)<%--.*?--%>', '(?s)<!--.*?-->')) {
        $raw = [regex]::Replace($raw, $pat, {
            param($m)
            # keep the newlines so line numbers do not shift
            ($m.Value -replace '[^\r\n]', ' ')
        })
    }
    return ($raw -replace "`r`n", "`n") -split "`n"
}
$css   = $scanned | Where-Object { $_.Ext -eq '.css' }
$mark  = $scanned | Where-Object { $_.Ext -in '.aspx', '.ascx' }
$skin  = $css | Where-Object { $_.Rel -like '*99-CC-Custom.css' }
$fw    = $css | Where-Object { $_.Rel -notlike '*01-CC-Brand.css' -and $_.Rel -notlike '*99-CC-Custom.css' -and $_.Rel -notlike '*CC-Home.css' }

Write-Host ""
Write-Host "unfinished build" -ForegroundColor Cyan

# 1. placeholders left over from the template.
#    These are checked on RAW lines, not comment-stripped ones: "<<< SET THIS"
#    and the template prose live inside comments by design, so stripping
#    comments would hide exactly what we are looking for.
$n = 0
foreach ($f in $css + $mark) {
    $i = 0
    foreach ($l in Get-Content $f.Full) {
        $i++
        if ($l -match '<<<\s*SET THIS') { Fail 'placeholder' "$($f.Rel):$i still marked SET THIS"; $n++ }
        if ($l -match '<\s*(CLIENT NAME|one or two sentences|what the homepage)') { Fail 'placeholder' "$($f.Rel):$i template prose not filled in"; $n++ }
    }
}
# CMS ids are the opposite case: the real ones sit in attribute values, but the
# page template also NAMES the placeholders in an instructional comment. Strip.
foreach ($f in $css + $mark) {
    $i = 0
    foreach ($l in Get-CodeLines $f.Full) {
        $i++
        if ($l -match '__BANNER_ID__|__REPEATER_ID__') { Fail 'placeholder' "$($f.Rel):$i unreplaced CMS id - $($l.Trim())"; $n++ }
    }
}
if ($n -eq 0) { Write-Host "  ok    no placeholders left" -ForegroundColor Green }

Write-Host ""
Write-Host "assets that must exist" -ForegroundColor Cyan

# 2. url(...) targets inside our own tree
$missing = 0
foreach ($f in $css) {
    $i = 0
    foreach ($l in Get-CodeLines $f.Full) {
        $i++
        foreach ($m in [regex]::Matches($l, "url\(\s*['""]?([^'"")]+)['""]?\s*\)")) {
            $u = $m.Groups[1].Value.Trim()
            if ($u -match '^(data:|https?:|//)') { continue }
            # only paths we own: /sitespecific/customcontent/... and /layout/...
            $local = $null
            if ($u -match '(?i)^/sitespecific/customcontent/(.+)$') { $local = $Matches[1] }
            elseif ($u -match '(?i)^/layout/(.+)$')                 { $local = "layout/$($Matches[1])" }
            if (-not $local) { continue }
            $local = ($local -split '\?')[0]
            # /font/* is covered by the dedicated font checks below, which know that a
            # missing .woff2 beside a present .ttf is the intended progressive contract
            if ($local -match '(?i)^font/') { continue }
            if (-not (Test-Path (Join-Path $Path ($local -replace '/', '\')))) {
                Fail 'asset' "$($f.Rel):$i references missing file: $u"; $missing++
            }
        }
    }
}

# 3. src= / href= on our own paths, from markup
foreach ($f in $mark) {
    $i = 0
    foreach ($l in Get-CodeLines $f.Full) {
        $i++
        foreach ($m in [regex]::Matches($l, '(?i)(?:src|href)\s*=\s*"([^"]+)"')) {
            $u = $m.Groups[1].Value
            if ($u -notmatch '(?i)^/sitespecific/customcontent/') { continue }
            $local = (($u -replace '(?i)^/sitespecific/customcontent/', '') -split '\?')[0]
            if (-not (Test-Path (Join-Path $Path ($local -replace '/', '\')))) {
                Fail 'asset' "$($f.Rel):$i references missing file: $u"; $missing++
            }
        }
    }
}
if ($missing -eq 0) { Write-Host "  ok    every referenced asset in this tree exists" -ForegroundColor Green }

# 4. font slots
$fontDir = Join-Path $Path 'font'
foreach ($slot in @('body', 'bold')) {
    $has = @(Get-ChildItem $fontDir -Filter "$slot.*" -ErrorAction SilentlyContinue)
    if ($has.Count -eq 0) {
        Fail 'font' "font/$slot.* is missing. NOT optional - ~186 platform declarations outside this tree name citrfont$(if($slot -eq 'body'){'reg'}else{'bold'}) literally"
    }
}
foreach ($slot in @('body', 'bold', 'display', 'accent')) {
    $ttf = Test-Path (Join-Path $fontDir "$slot.ttf")
    $w2  = Test-Path (Join-Path $fontDir "$slot.woff2")
    if ($ttf -and -not $w2) { Warn 'font' "font/$slot.ttf has no .woff2 sibling - costs a 404 per cold load and ~40% extra bytes" }
}

Write-Host ""
Write-Host "token discipline" -ForegroundColor Cyan

# 5. every var() reference resolves somewhere
$declared = New-Object 'System.Collections.Generic.HashSet[string]'
foreach ($f in $css) {
    foreach ($m in [regex]::Matches(((Get-CodeLines $f.Full) -join "`n"), '(?m)^\s*(--[A-Za-z][\w-]*)\s*:')) { [void]$declared.Add($m.Groups[1].Value) }
}
$dangling = 0
foreach ($f in $css) {
    $i = 0
    foreach ($l in Get-CodeLines $f.Full) {
        $i++
        foreach ($m in [regex]::Matches($l, 'var\(\s*(--[A-Za-z][\w-]*)')) {
            $t = $m.Groups[1].Value
            if (-not $declared.Contains($t)) {
                Fail 'token' "$($f.Rel):$i var($t) is declared nowhere - the whole declaration is invalid and silently falls back"
                $dangling++
            }
        }
    }
}
if ($dangling -eq 0) { Write-Host "  ok    every var() reference has a declaration" -ForegroundColor Green }

# 6. hardcoded colours outside the reskin surface
$hex = 0
foreach ($f in $fw + ($css | Where-Object { $_.Rel -like '*CC-Home.css' })) {
    $i = 0
    foreach ($l in Get-CodeLines $f.Full) {
        $i++
        if ($l -match '--status-|--overlay-') { continue }   # functional, not brand
        if ($l -match '#[0-9a-fA-F]{3,8}\b') { Warn 'colour' "$($f.Rel):$i hardcoded colour outside 01 - $($l.Trim())"; $hex++ }
    }
}
if ($hex -eq 0) { Write-Host "  ok    no hardcoded colours outside the reskin surface" -ForegroundColor Green }

# 7. client-prefixed tokens in the skin layer
$badPrefix = 0
foreach ($f in $skin) {
    $i = 0
    foreach ($l in Get-CodeLines $f.Full) {
        $i++
        if ($l -match '^\s*(--[A-Za-z][\w-]*)\s*:' -and $Matches[1] -notmatch '^--(skin|copy)-') {
            Warn 'prefix' "$($f.Rel):$i token $($Matches[1]) should be --skin-* - a client-initialled vocabulary survives into the next build"
            $badPrefix++
        }
    }
}
if ($badPrefix -eq 0) { Write-Host "  ok    skin-layer tokens all use --skin-*" -ForegroundColor Green }

# 8. previous client's name in framework files
if ($PreviousClient) {
    $leak = 0
    # .js is included deliberately: a previous client's name in a script file is
    # just as much a leak, and this exact gap hid one in modules/JS/splide-config.js
    # while lint reported the tree clean.
    $js = $scanned | Where-Object { $_.Ext -eq '.js' }
    foreach ($f in $fw + $mark + $js) {
        $i = 0
        # RAW lines, not comment-stripped. A client name in a comment is exactly
        # the leak worth catching - it is how "Ardent Bicycles" survived in
        # modules/JS/splide-config.js while lint reported the tree clean. Reading
        # stripped lines here made this check silently useless.
        foreach ($l in Get-Content $f.Full) {
            $i++
            if ($l -match [regex]::Escape($PreviousClient)) { Fail 'leak' "$($f.Rel):$i framework file names '$PreviousClient'"; $leak++ }
        }
    }
    if ($leak -eq 0) { Write-Host "  ok    no '$PreviousClient' in framework files" -ForegroundColor Green }
}

Write-Host ""
Write-Host "homepage wiring" -ForegroundColor Cyan

# 9. carousels need their options JSON, and stripe order must agree
$page = $mark | Where-Object { $_.Rel -eq 'default.aspx' }
$homeCss = $css | Where-Object { $_.Rel -like '*home\CC-Home.css' }
if ($page -and $homeCss) {
    $pageText = Get-Content $page.Full -Raw
    $pageStripes = [regex]::Matches($pageText, 'class="col-1 (hp-[\w-]+)"?') | ForEach-Object { $_.Groups[1].Value }
    $cssText = Get-Content $homeCss.Full -Raw
    $cssStripes = [regex]::Matches($cssText, '(?m)^\s*/\* ==+ \d+\.\s+(hp-[\w-]+)') | ForEach-Object { $_.Groups[1].Value }
    if ($pageStripes.Count -eq 0) {
        Warn 'stripes' "default.aspx contains no stripes yet"
    } else {
        Note ("default.aspx stripes: {0}" -f ($pageStripes -join ', '))
        foreach ($s in $pageStripes) {
            if ($cssText -notmatch [regex]::Escape(".$s")) { Fail 'stripes' "$s is in default.aspx but has no rules in CC-Home.css" }
        }
        if ($cssStripes.Count -gt 0) {
            $a = ($pageStripes -join '>'); $b = ($cssStripes -join '>')
            if ($a -ne $b) { Warn 'stripes' "stripe order differs. page: $a | css: $b" }
            else { Write-Host "  ok    stripe order matches between default.aspx and CC-Home.css" -ForegroundColor Green }
        }
    }
    # a .splide with no options JSON gets base config only, usually not intended
    foreach ($m in [regex]::Matches($pageText, '(?s)<div class="col-1 (hp-[\w-]+)"(.{0,400}?)</div>')) {
        if ($m.Groups[2].Value -match 'Splide' -and $m.Groups[2].Value -notmatch 'data-splide-opts') {
            Warn 'splide' "$($m.Groups[1].Value) mounts a Splide control but has no data-splide-opts - it will use base config only"
        }
    }
    # data-animate drives the scroll reveal
    foreach ($s in $pageStripes) {
        if ($pageText -notmatch "class=`"col-1 $s`"[^>]*data-animate" -and $pageText -notmatch "(?s)col-1 $s.{0,300}?data-animate") {
            Warn 'animate' "$s has no data-animate, so it will not scroll-reveal"
        }
    }
}

Write-Host ""
if ($script:fails -gt 0) {
    Write-Host ("FAILED - {0} error(s), {1} warning(s)" -f $script:fails, $script:warns) -ForegroundColor Red
    Write-Host "Nothing here is stylistic. Each failure is something that renders wrong or not at all." -ForegroundColor DarkGray
    exit 1
}
Write-Host ("PASSED - 0 errors, {0} warning(s)" -f $script:warns) -ForegroundColor Green
Write-Host ""
Write-Host "Lint cannot see: whether it looks right, the 900s homepage output cache, whether" -ForegroundColor DarkGray
Write-Host "back-office collections are populated, or whether a ?v was bumped. See docs/QA-CHECKLIST.md." -ForegroundColor DarkGray
exit 0

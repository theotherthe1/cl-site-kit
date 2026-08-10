<#
.SYNOPSIS
    Push framework improvements from the kit into an already-built site.

.DESCRIPTION
    Copies every FRAMEWORK and VERBATIM entry in MANIFEST.md forward, and never
    touches a CLIENT entry. That is safe by construction: framework files contain
    no client's colours, words, assets or taste, which is the property lint.ps1
    exists to keep true.

    Always run with -DryRun first. On the share there is no undo: writing a file
    publishes it.

.PARAMETER Site
    Path to the site's CustomContent directory.

.PARAMETER DryRun
    Report what would change and write nothing. Do this first, every time.

.PARAMETER Backup
    Copy the site's CustomContent to a timestamped .bak before writing.
    Strongly recommended, and on by default.

.EXAMPLE
    ./tools/update-site.ps1 -Site \\dev-ecom-sofs\Websites\FOO...\CustomContent -DryRun
    ./tools/update-site.ps1 -Site \\dev-ecom-sofs\Websites\FOO...\CustomContent
#>
[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)][string] $Site,
    [switch] $DryRun,
    [bool]   $Backup = $true
)

$ErrorActionPreference = 'Stop'
$repo = Split-Path $PSScriptRoot -Parent
$kit  = Join-Path $repo 'kit\CustomContent'
$Site = (Resolve-Path -LiteralPath $Site).ProviderPath.TrimEnd('\')

Write-Host ""
Write-Host "cl-sitekit update-site" -ForegroundColor Cyan
Write-Host "  kit : $kit"
Write-Host "  site: $Site"
if ($DryRun) { Write-Host "  MODE: dry run, nothing will be written" -ForegroundColor Yellow }

# ------------------------------------------------------------------ manifest --
$inBlock = $false
$kinds = @{ FRAMEWORK = @(); CLIENT = @(); VERBATIM = @() }
foreach ($line in Get-Content (Join-Path $repo 'MANIFEST.md')) {
    if ($line -match '^```manifest') { $inBlock = $true; continue }
    if ($inBlock -and $line -match '^```') { break }
    if ($inBlock -and $line -match '^\s*(FRAMEWORK|CLIENT|VERBATIM)\s+(\S+)\s*$') { $kinds[$Matches[1]] += $Matches[2] }
}

function Convert-GlobToRegex($g) {
    $r = [regex]::Escape(($g -replace '/', '\'))
    $r = $r -replace '\\\*\\\*', '.*'
    $r = $r -replace '\\\*', '[^\\]*'
    return '^' + $r + '$'
}
$pushRx   = ($kinds.FRAMEWORK + $kinds.VERBATIM) | ForEach-Object { Convert-GlobToRegex $_ }
$clientRx = $kinds.CLIENT | ForEach-Object { Convert-GlobToRegex $_ }
function Test-Any($rel, $rxs) { foreach ($rx in $rxs) { if ($rel -match $rx) { return $true } }; return $false }

# --------------------------------------------------------------- kit version --
Push-Location $repo
$kitCommit = (git rev-parse --short HEAD).Trim()
$dirty     = [bool](git status --porcelain)
Pop-Location
Write-Host "  kit commit: $kitCommit$(if ($dirty) { '  (WARNING: kit has uncommitted changes)' })" -ForegroundColor $(if ($dirty) { 'Yellow' } else { 'Gray' })

$siteDoc = Join-Path $Site 'CLAUDE.md'
$siteCommit = $null
if (Test-Path $siteDoc) {
    $m = [regex]::Match((Get-Content $siteDoc -Raw), 'kit commit `([0-9a-f]{7,40})`')
    if ($m.Success) { $siteCommit = $m.Groups[1].Value }
}
if ($siteCommit) {
    Write-Host "  site is on : $siteCommit"
    if ($siteCommit -eq $kitCommit) { Write-Host "  site is already on this kit commit. Nothing to do unless the kit is dirty." -ForegroundColor Green }
} else {
    Write-Host "  site records no kit commit. It may predate the kit; review the diff carefully." -ForegroundColor Yellow
}

# ------------------------------------------------------------------ classify --
$changed = @(); $added = @(); $same = 0; $skippedClient = @(); $unclassified = @()
Get-ChildItem $kit -Recurse -File | ForEach-Object {
    $rel = $_.FullName.Substring($kit.Length + 1)
    if (Test-Any $rel $clientRx) { $skippedClient += $rel; return }
    if (-not (Test-Any $rel $pushRx)) { $unclassified += $rel; return }
    $dest = Join-Path $Site $rel
    if (-not (Test-Path $dest)) { $added += $rel }
    elseif ((Get-FileHash $_.FullName).Hash -ne (Get-FileHash $dest).Hash) { $changed += $rel }
    else { $same++ }
}

Write-Host ""
Write-Host "would update ($($changed.Count)):" -ForegroundColor Cyan
if ($changed) { $changed | ForEach-Object { Write-Host "  ~ $_" } } else { Write-Host "  (none)" -ForegroundColor DarkGray }
Write-Host "would add ($($added.Count)):" -ForegroundColor Cyan
if ($added) { $added | ForEach-Object { Write-Host "  + $_" -ForegroundColor Green } } else { Write-Host "  (none)" -ForegroundColor DarkGray }
Write-Host "already identical: $same" -ForegroundColor DarkGray
Write-Host "left alone because CLIENT ($($skippedClient.Count)):" -ForegroundColor DarkGray
$skippedClient | ForEach-Object { Write-Host "  . $_" -ForegroundColor DarkGray }

if ($unclassified.Count -gt 0) {
    Write-Host ""
    Write-Host "NOT IN THE MANIFEST ($($unclassified.Count)) - refusing to guess:" -ForegroundColor Red
    $unclassified | ForEach-Object { Write-Host "  ? $_" -ForegroundColor Red }
    Write-Host "  Add each to MANIFEST.md as FRAMEWORK, CLIENT or VERBATIM, then re-run." -ForegroundColor Red
    Write-Host "  A file with no declared kind cannot be updated safely: overwriting a client's"
    Write-Host "  file loses their work, and skipping a framework file leaves a stale bug behind."
    exit 2
}

if ($DryRun) {
    Write-Host ""
    Write-Host "Dry run complete. Nothing written." -ForegroundColor Yellow
    Write-Host "Re-run without -DryRun to apply, then lint the site and QA it in a browser."
    exit 0
}

if ($changed.Count -eq 0 -and $added.Count -eq 0) {
    Write-Host ""
    Write-Host "Nothing to do." -ForegroundColor Green
    exit 0
}

# ---------------------------------------------------------------------- apply --
if ($Backup) {
    $bak = "$Site.bak-" + (Get-Date -Format 'yyyyMMdd-HHmm')
    robocopy $Site $bak /E /NFL /NDL /NJH /NJS /NP | Out-Null
    if ($LASTEXITCODE -gt 7) { Write-Host "BACKUP FAILED - stopping" -ForegroundColor Red; exit 1 }
    $global:LASTEXITCODE = 0
    Write-Host ""
    Write-Host "backed up to $bak" -ForegroundColor Green
}

foreach ($rel in ($changed + $added)) {
    $dest = Join-Path $Site $rel
    $destDir = Split-Path $dest -Parent
    if (-not (Test-Path $destDir)) { New-Item -ItemType Directory -Force $destDir | Out-Null }
    Copy-Item (Join-Path $kit $rel) $dest -Force
}
Write-Host "copied $($changed.Count + $added.Count) file(s)" -ForegroundColor Green

# record the new kit commit in the site's own notes
if (Test-Path $siteDoc) {
    $doc = Get-Content $siteDoc -Raw
    if ($doc -match 'kit commit `[0-9a-f]{7,40}`') {
        $doc = [regex]::Replace($doc, 'kit commit `[0-9a-f]{7,40}`', "kit commit ``$kitCommit``")
        [IO.File]::WriteAllText($siteDoc, ($doc -replace "`r`n", "`n"), (New-Object Text.UTF8Encoding($false)))
        Write-Host "site CLAUDE.md now records kit commit $kitCommit" -ForegroundColor Green
    } else {
        Write-Host "could not find a 'kit commit' line in the site's CLAUDE.md - record $kitCommit by hand" -ForegroundColor Yellow
    }
} else {
    Write-Host "site has no CLAUDE.md - record kit commit $kitCommit somewhere it will be found" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "NEXT, and do not skip these:" -ForegroundColor Cyan
Write-Host "  1. tools\lint.ps1 -Path `"$Site`"     must exit 0"
Write-Host "  2. QA in a browser. Framework changes can move layout even when they are correct."
Write-Host "  3. Update the row for this site in SITES.md."
exit 0

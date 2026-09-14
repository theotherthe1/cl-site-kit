<#
.SYNOPSIS
    Make a machine ready to build sites with this kit.

.DESCRIPTION
    The kit is portable; the things around it are not. This script installs the
    parts that live outside the repo, so a fresh checkout on a build server
    behaves the same as the machine the kit was written on.

    It does three things:

      1. Sets CL_SITEKIT (user scope) to this checkout, so the /new-site skill
         and any script can find the kit without a path hardcoded in a doc.
      2. Installs the repo's skills into the user's skill directory, so
         /new-site works when Claude Code is started in a SITE folder rather
         than in the kit. Project-scoped skills only load inside the project.
      3. Checks the environment: git, PowerShell version, the manifest parses,
         and lint runs against the kit's own copy.

    Safe to re-run. Re-running is how you pick up a kit update: skills are
    copied fresh from the repo every time, so the installed copy cannot drift
    away from the version history.

.PARAMETER Check
    Report only. Writes nothing, sets no environment variable, installs no
    skill. Use this to find out why /new-site is not showing up.

.PARAMETER SkillRoot
    Where to install skills. Defaults to the user's Claude Code skill
    directory.

.EXAMPLE
    .\tools\bootstrap.ps1
    .\tools\bootstrap.ps1 -Check
#>
[CmdletBinding()]
param(
    [switch] $Check,
    [string] $SkillRoot
)

$ErrorActionPreference = 'Stop'
$repo = Split-Path $PSScriptRoot -Parent
if (-not $SkillRoot) { $SkillRoot = Join-Path $HOME '.claude\skills' }

$script:fails = 0
$script:warns = 0
function Fail($msg) { Write-Host "  FAIL  $msg" -ForegroundColor Red;    $script:fails++ }
function Warn($msg) { Write-Host "  WARN  $msg" -ForegroundColor Yellow; $script:warns++ }
function Ok($msg)   { Write-Host "  ok    $msg" -ForegroundColor DarkGray }
function Did($msg)  { Write-Host "  ->    $msg" -ForegroundColor Cyan }

Write-Host ""
Write-Host "cl-sitekit bootstrap" -ForegroundColor Cyan
Write-Host "  kit  : $repo"
Write-Host "  skill: $SkillRoot"
if ($Check) { Write-Host "  MODE : check only, nothing will be written" -ForegroundColor Yellow }
Write-Host ""

# --------------------------------------------------------------- environment --
Write-Host "Environment" -ForegroundColor White

if ($PSVersionTable.PSVersion.Major -lt 5) {
    Fail "PowerShell $($PSVersionTable.PSVersion) - lint.ps1 and update-site.ps1 want 5.1 or later"
} else {
    Ok "PowerShell $($PSVersionTable.PSVersion)"
}

$git = Get-Command git -ErrorAction SilentlyContinue
if (-not $git) {
    Fail "git not on PATH - the kit records site provenance by commit, and without git a build cannot stamp SITES.md or the site's CLAUDE.md"
} else {
    Ok "git $((& git --version) -replace '^git version ','')"
    $inRepo = (& git -C $repo rev-parse --is-inside-work-tree 2>$null)
    if ($inRepo -ne 'true') {
        Fail "$repo is not a git checkout - copy it with git clone, not robocopy, or you lose the only version history in the ecosystem"
    } else {
        $head = (& git -C $repo rev-parse --short HEAD).Trim()
        Ok "kit at commit $head"
        $remote = (& git -C $repo remote 2>$null)
        if (-not $remote) {
            Warn "no git remote configured - you cannot pull kit fixes or push what you learn here. See docs/PORTING.md"
        } else {
            Ok "remote: $((& git -C $repo remote -v | Select-Object -First 1))"
        }
    }
}

# ------------------------------------------------------------------ CL_SITEKIT --
Write-Host ""
Write-Host "CL_SITEKIT" -ForegroundColor White

$current = [Environment]::GetEnvironmentVariable('CL_SITEKIT', 'User')
if ($current -eq $repo) {
    Ok "already set to this checkout"
} elseif ($Check) {
    if ($current) { Warn "set to '$current', not '$repo'" }
    else          { Warn "not set - /new-site would have to guess where the kit is" }
} else {
    [Environment]::SetEnvironmentVariable('CL_SITEKIT', $repo, 'User')
    $env:CL_SITEKIT = $repo
    if ($current) { Did "changed from '$current' to '$repo'" }
    else          { Did "set to '$repo'" }
    Warn "user environment variables reach a process at start - restart the terminal, and Claude Code, before relying on it"
}

# ---------------------------------------------------------------------- skills --
Write-Host ""
Write-Host "Skills" -ForegroundColor White

$src = Join-Path $repo '.claude\skills'
if (-not (Test-Path $src)) {
    Fail "$src is missing - this checkout is incomplete"
} else {
    foreach ($skill in Get-ChildItem -Path $src -Directory) {
        $dest = Join-Path $SkillRoot $skill.Name
        $same = $false
        if (Test-Path $dest) {
            $a = Get-ChildItem -Path $skill.FullName -Recurse -File | Sort-Object Name
            $b = Get-ChildItem -Path $dest -Recurse -File | Sort-Object Name
            $same = ($a.Count -eq $b.Count) -and -not (Compare-Object `
                ($a | ForEach-Object { "$($_.Name):$((Get-FileHash $_.FullName).Hash)" }) `
                ($b | ForEach-Object { "$($_.Name):$((Get-FileHash $_.FullName).Hash)" }))
        }

        if ($same) {
            Ok "$($skill.Name) installed and matches the repo"
        } elseif ($Check) {
            if (Test-Path $dest) { Warn "$($skill.Name) installed but DIFFERS from the repo - re-run without -Check to overwrite it" }
            else                 { Warn "$($skill.Name) not installed - /new-site will not exist outside this folder" }
        } else {
            if (-not (Test-Path $SkillRoot)) { New-Item -ItemType Directory -Path $SkillRoot -Force | Out-Null }
            if (Test-Path $dest) { Remove-Item -Path $dest -Recurse -Force }
            Copy-Item -Path $skill.FullName -Destination $dest -Recurse -Force
            Did "installed $($skill.Name) -> $dest"
        }
    }
}

# ------------------------------------------------------------------- the kit --
Write-Host ""
Write-Host "Kit" -ForegroundColor White

$manifest = Join-Path $repo 'MANIFEST.md'
if (-not (Test-Path $manifest)) {
    Fail "MANIFEST.md missing"
} else {
    $entries = 0
    $inBlock = $false
    foreach ($line in Get-Content $manifest) {
        if ($line -match '^```manifest') { $inBlock = $true; continue }
        if ($inBlock -and $line -match '^```') { break }
        if ($inBlock -and $line -match '^\s*(FRAMEWORK|CLIENT|VERBATIM)\s+(\S+)\s*$') { $entries++ }
    }
    if ($entries -lt 1) { Fail "MANIFEST.md has no parseable entries - update-site.ps1 and lint.ps1 both read that block" }
    else                { Ok "MANIFEST.md parses, $entries entries" }
}

foreach ($p in 'kit\CustomContent', 'stripes', 'docs', 'briefs', 'tools\lint.ps1', 'tools\update-site.ps1', 'brand-brief.template.md') {
    if (Test-Path (Join-Path $repo $p)) { Ok $p } else { Fail "$p missing" }
}

# --------------------------------------------------------------------- lint --
Write-Host ""
Write-Host "Lint (kit's own copy)" -ForegroundColor White

# The kit's own CustomContent is an UNFILLED template: `<<< SET THIS`, the two
# prose placeholders and an empty default.aspx are all deliberate, so lint never
# exits 0 here and never should. What matters is that it runs, and that nothing
# fails for a reason other than those placeholders - a missing asset or an
# undeclared var() in a fresh checkout is a real broken clone.
try {
    # *>&1, not 2>&1: lint.ps1 reports through Write-Host, which goes to the
    # information stream. Merging only stderr captures an empty result and the
    # whole report lands on the console uncaptured.
    $out = & (Join-Path $repo 'tools\lint.ps1') *>&1
    $lines = $out | ForEach-Object { $_.ToString() }
    # '^\s*FAIL\s+\[' and not '^\s*FAIL': the summary line reads "FAILED - 7
    # error(s)", which is a count, not a finding, and matching it makes every
    # run report a phantom failure.
    $other = $lines | Where-Object { $_ -match '^\s*FAIL\s+\[' -and $_ -notmatch '\[placeholder\]' }

    if (-not ($lines | Where-Object { $_ -match 'cl-sitekit lint' })) {
        Fail "lint.ps1 produced no recognisable output"
    } elseif ($other) {
        Fail "lint.ps1 reports $($other.Count) failure(s) unrelated to the unfilled template - this checkout is broken, not just blank"
        $other | ForEach-Object { Write-Host "        $_" -ForegroundColor DarkGray }
    } else {
        $ph = @($lines | Where-Object { $_ -match '\[placeholder\]' }).Count
        Ok "lint.ps1 runs; only the $ph expected template placeholders fail"
    }
} catch {
    Fail "lint.ps1 did not run: $($_.Exception.Message)"
}

# -------------------------------------------------------------------- close --
Write-Host ""
if ($script:fails -gt 0) {
    Write-Host "BOOTSTRAP INCOMPLETE  $($script:fails) failed, $($script:warns) warnings" -ForegroundColor Red
    exit 1
}
Write-Host "BOOTSTRAP OK  $($script:warns) warnings" -ForegroundColor Green
Write-Host ""
Write-Host "Next: open Claude Code in the site folder you are building and run /new-site." -ForegroundColor DarkGray
Write-Host "It will interview you, one question at a time, and write the brief itself." -ForegroundColor DarkGray
exit 0

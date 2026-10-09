#requires -Version 7.0
<#
.SYNOPSIS
Create the local agent-host skill adapter for this repository.

.DESCRIPTION
`.agents/skills` must point at `.ai/skills`, because DSH discovers
project-scoped skills through `<project>/.agents/skills` (rank 200) and does not
read `.ai/skills` directly.

The adapter is a local deployment detail. Git cannot track a Windows junction as
a link: `git add` walks through it and indexes one real file per skill, which
would duplicate the canonical skill content into the repository. A committed
symlink is not an alternative either — on a Windows clone with
`core.symlinks=false` it materializes as a plain text file and the host skips the
root silently. The adapter is therefore gitignored and recreated here.

The script is idempotent. It never deletes a real directory, and it refuses to
replace an adapter it cannot prove is a link.

.PARAMETER RepositoryRoot
Repository root. Defaults to the repository that contains this script, falling
back to the git working tree root and then to the current directory.

.PARAMETER Force
Replace a conflicting adapter, but only when the existing entry is a link.
A real directory is always reported, never deleted.

.EXAMPLE
pwsh -File .ai/scripts/adapters/New-SkillAdapters.ps1

.EXAMPLE
pwsh -File .ai/scripts/adapters/New-SkillAdapters.ps1 -Force
#>
[CmdletBinding()]
param(
    [string]$RepositoryRoot,
    [switch]$Force
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Get-RepositoryRoot {
    param([string]$Explicit)

    if ($Explicit) {
        return (Resolve-Path -LiteralPath $Explicit).Path
    }

    # Prefer the repository that contains this script:
    # <root>/.ai/scripts/adapters/New-SkillAdapters.ps1
    # The script's own location is unambiguous; the working directory is not,
    # so resolving from cwd here would silently target whatever repository the
    # caller happened to be standing in.
    $candidate = Resolve-Path -LiteralPath (Join-Path $PSScriptRoot '..\..\..') -ErrorAction SilentlyContinue
    if ($null -ne $candidate -and (Test-Path -LiteralPath (Join-Path $candidate.Path '.ai\skills') -PathType Container)) {
        return $candidate.Path
    }

    $git = Get-Command git -ErrorAction SilentlyContinue
    if ($null -ne $git) {
        $top = & git rev-parse --show-toplevel 2>$null
        if ($LASTEXITCODE -eq 0 -and $top) {
            return (Resolve-Path -LiteralPath $top).Path
        }
    }

    return (Get-Location).Path
}

function Get-LinkInfo {
    param([string]$Path)

    $item = Get-Item -LiteralPath $Path -Force -ErrorAction SilentlyContinue
    if ($null -eq $item) { return $null }

    $linkType = $item.LinkType
    if ([string]::IsNullOrEmpty($linkType)) { $linkType = 'none' }

    $target = $null
    if ($null -ne $item.Target) {
        $target = @($item.Target)[0]
    }

    return [pscustomobject]@{
        Path     = $item.FullName
        LinkType = $linkType
        Target   = $target
        IsLink   = $linkType -ne 'none'
    }
}

function New-SkillAdapterLink {
    param([string]$LinkPath, [string]$TargetPath)

    $parent = Split-Path -Parent $LinkPath
    if (-not (Test-Path -LiteralPath $parent)) {
        New-Item -ItemType Directory -Path $parent -Force | Out-Null
    }

    if ($IsWindows) {
        New-Item -ItemType Junction -Path $LinkPath -Target $TargetPath | Out-Null
    }
    else {
        New-Item -ItemType SymbolicLink -Path $LinkPath -Target $TargetPath | Out-Null
    }
}

function Test-AdapterReadable {
    param([string]$LinkPath, [string[]]$ExpectedSkillNames)

    $found = @(
        Get-ChildItem -LiteralPath $LinkPath -Directory -ErrorAction Stop |
            Select-Object -ExpandProperty Name
    )

    $missing = @($ExpectedSkillNames | Where-Object { $found -notcontains $_ })
    $readable = $false
    if ($found.Count -gt 0) {
        $probe = Join-Path (Join-Path $LinkPath $found[0]) 'SKILL.md'
        $readable = Test-Path -LiteralPath $probe -PathType Leaf
    }

    return [pscustomobject]@{
        Skills   = $found
        Missing  = $missing
        Readable = $readable
    }
}

$root = Get-RepositoryRoot -Explicit $RepositoryRoot
$canonical = Join-Path $root '.ai\skills'
$adapter = Join-Path $root '.agents\skills'

Write-Host "repository : $root"
Write-Host "canonical  : $canonical"
Write-Host "adapter    : $adapter"

if (-not (Test-Path -LiteralPath $canonical -PathType Container)) {
    Write-Error ("canonical skill directory is missing: {0}" -f $canonical)
    exit 1
}

$expected = @(
    Get-ChildItem -LiteralPath $canonical -Directory |
        Select-Object -ExpandProperty Name |
        Sort-Object
)
if ($expected.Count -eq 0) {
    Write-Error ("canonical skill directory contains no skill directories: {0}" -f $canonical)
    exit 1
}
Write-Host "skills     : $($expected.Count) found in the canonical root"

$existing = Get-LinkInfo -Path $adapter

if ($null -ne $existing) {
    $resolvedTarget = $null
    if ($existing.Target) {
        # A link may be dangling: its target can be gone after the repository was
        # moved or renamed. Resolve-Path then yields nothing, and reading .Path
        # from nothing throws under Set-StrictMode -Version Latest.
        $resolved = Resolve-Path -LiteralPath $existing.Target -ErrorAction SilentlyContinue
        if ($null -ne $resolved) {
            $resolvedTarget = $resolved.Path
        }
    }

    if ($existing.IsLink -and $resolvedTarget -eq (Resolve-Path -LiteralPath $canonical).Path) {
        Write-Host "adapter    : already correct ($($existing.LinkType)), nothing to do"
    }
    elseif (-not $existing.IsLink) {
        Write-Error ("the adapter path exists and is NOT a link: {0}. Refusing to delete a real directory. Inspect it and remove it manually, then re-run." -f $adapter)
        exit 1
    }
    elseif (-not $Force) {
        Write-Error ("the adapter path is a {0} pointing somewhere else: current target = {1}; expected target = {2}. Re-run with -Force to replace it." -f $existing.LinkType, $existing.Target, $canonical)
        exit 1
    }
    else {
        Write-Host "adapter    : replacing $($existing.LinkType) -> $($existing.Target)"
        (Get-Item -LiteralPath $adapter -Force).Delete()
        New-SkillAdapterLink -LinkPath $adapter -TargetPath $canonical
    }
}
else {
    New-SkillAdapterLink -LinkPath $adapter -TargetPath $canonical
    Write-Host "adapter    : created"
}

$check = Get-LinkInfo -Path $adapter
if (-not $check.IsLink) {
    Write-Error ("adapter verification failed: {0} is not a link" -f $adapter)
    exit 1
}

$read = Test-AdapterReadable -LinkPath $adapter -ExpectedSkillNames $expected

Write-Host "link type  : $($check.LinkType)"
Write-Host "target     : $($check.Target)"
Write-Host "visible    : $($read.Skills.Count) skill directories through the adapter"
Write-Host "SKILL.md   : readable = $($read.Readable)"

$ok = $read.Readable -and $read.Missing.Count -eq 0
if (-not $ok) {
    Write-Error ("adapter verification failed: missing = [{0}], readable = {1}" -f ($read.Missing -join ', '), $read.Readable)
    exit 1
}

Write-Host 'OK'
exit 0

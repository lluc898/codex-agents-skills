[CmdletBinding()]
param()

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$repoRoot = Split-Path -Parent $PSScriptRoot
$userProfilePath = [System.IO.Path]::GetFullPath($env:USERPROFILE)
$profileForward = $userProfilePath.Replace('\', '/')

$agentSource = Join-Path $userProfilePath '.codex\agents'
$codexSkillSource = Join-Path $userProfilePath '.codex\skills'
$userSkillSource = Join-Path $userProfilePath '.agents\skills'

$agentDestination = Join-Path $repoRoot 'agents'
$codexSkillDestination = Join-Path $repoRoot 'skills\codex'
$userSkillDestination = Join-Path $repoRoot 'skills\user'

foreach ($directory in @($agentDestination, $codexSkillDestination, $userSkillDestination)) {
    if (-not (Test-Path -LiteralPath $directory)) {
        New-Item -ItemType Directory -Path $directory | Out-Null
    }
}

if (Test-Path -LiteralPath $agentSource) {
    foreach ($agent in Get-ChildItem -LiteralPath $agentSource -File -Filter '*.toml') {
        $content = Get-Content -Raw -LiteralPath $agent.FullName
        $content = $content.Replace($profileForward, '__USER_PROFILE__')
        $content = $content.Replace($userProfilePath, '__USER_PROFILE__')
        $target = Join-Path $agentDestination $agent.Name
        Set-Content -LiteralPath $target -Value $content -Encoding utf8
        Write-Output "Synced agent: $($agent.Name)"
    }
}

function Sync-SkillRoot {
    param(
        [Parameter(Mandatory = $true)][string]$Source,
        [Parameter(Mandatory = $true)][string]$Destination,
        [string[]]$Exclude = @()
    )

    if (-not (Test-Path -LiteralPath $Source)) {
        return
    }

    foreach ($skill in Get-ChildItem -LiteralPath $Source -Directory) {
        if ($Exclude -contains $skill.Name) {
            continue
        }

        Copy-Item -LiteralPath $skill.FullName -Destination $Destination -Recurse -Force
        Write-Output "Synced skill: $($skill.Name)"
    }
}

Sync-SkillRoot -Source $codexSkillSource -Destination $codexSkillDestination -Exclude @('.system')
Sync-SkillRoot -Source $userSkillSource -Destination $userSkillDestination

Write-Output 'Synchronization complete. Review git status before committing.'

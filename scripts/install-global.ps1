[CmdletBinding()]
param(
    [switch]$Force
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$repoRoot = Split-Path -Parent $PSScriptRoot
$userProfilePath = [System.IO.Path]::GetFullPath($env:USERPROFILE)
$profileForward = $userProfilePath.Replace('\', '/')

$agentSource = Join-Path $repoRoot 'agents'
$codexSkillSource = Join-Path $repoRoot 'skills\codex'
$userSkillSource = Join-Path $repoRoot 'skills\user'

$agentDestination = Join-Path $userProfilePath '.codex\agents'
$codexSkillDestination = Join-Path $userProfilePath '.codex\skills'
$userSkillDestination = Join-Path $userProfilePath '.agents\skills'

foreach ($directory in @($agentDestination, $codexSkillDestination, $userSkillDestination)) {
    if (-not (Test-Path -LiteralPath $directory)) {
        New-Item -ItemType Directory -Path $directory | Out-Null
    }
}

if (Test-Path -LiteralPath $agentSource) {
    foreach ($agent in Get-ChildItem -LiteralPath $agentSource -File -Filter '*.toml') {
        $target = Join-Path $agentDestination $agent.Name
        if ((Test-Path -LiteralPath $target) -and -not $Force) {
            Write-Warning "Skipped existing agent: $($agent.Name). Use -Force to overwrite."
            continue
        }

        $content = Get-Content -Raw -LiteralPath $agent.FullName
        $content = $content.Replace('__USER_PROFILE__', $profileForward)
        Set-Content -LiteralPath $target -Value $content -Encoding utf8
        Write-Output "Installed agent: $($agent.Name)"
    }
}

function Install-SkillRoot {
    param(
        [Parameter(Mandatory = $true)][string]$Source,
        [Parameter(Mandatory = $true)][string]$Destination,
        [switch]$Overwrite
    )

    if (-not (Test-Path -LiteralPath $Source)) {
        return
    }

    foreach ($skill in Get-ChildItem -LiteralPath $Source -Directory) {
        $target = Join-Path $Destination $skill.Name
        if ((Test-Path -LiteralPath $target) -and -not $Overwrite) {
            Write-Warning "Skipped existing skill: $($skill.Name). Use -Force to overwrite."
            continue
        }

        if (-not (Test-Path -LiteralPath $target)) {
            New-Item -ItemType Directory -Path $target | Out-Null
        }
        Copy-Item -Path (Join-Path $skill.FullName '*') -Destination $target -Recurse -Force
        Write-Output "Installed skill: $($skill.Name)"
    }
}

Install-SkillRoot -Source $codexSkillSource -Destination $codexSkillDestination -Overwrite:$Force
Install-SkillRoot -Source $userSkillSource -Destination $userSkillDestination -Overwrite:$Force

Write-Output 'Installation complete. Restart Codex or open a new session to reload agents and skills.'

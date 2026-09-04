#Requires -RunAsAdministrator
$ErrorActionPreference = "Stop"

# Paths
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$vscodeUserDir = Join-Path $env:APPDATA 'Code\User'
$zedConfigDir = Join-Path $env:APPDATA 'Zed'
$nvimConfigDir = Join-Path $env:LOCALAPPDATA 'nvim'
$powerShellProfile = $PROFILE
$claudeUserDir = Join-Path $env:USERPROFILE '.claude'
$codexUserDir = Join-Path $env:USERPROFILE '.codex'
$hermesUserDir = Join-Path $env:USERPROFILE '.hermes'
$agentsUserDir = Join-Path $env:USERPROFILE '.agents'

function Remove-Existing {
    param([string]$Path)

    if (Test-Path $Path) {
        $item = Get-Item -LiteralPath $Path -Force

        if ($item.Attributes -band [IO.FileAttributes]::ReparsePoint -and $item.LinkType -eq 'SymbolicLink') {
            Remove-Item -LiteralPath $Path -Force -Recurse
        } 
        else {
            Move-Item -LiteralPath $Path -Destination ($Path + '.old') -Force
        }
    }
}

function New-Symlink {
    param(
        [string]$Target,
        [string]$LinkPath
    )

    $parent = Split-Path $LinkPath -Parent
    if (-not (Test-Path $parent)) {
        New-Item -ItemType Directory -Path $parent -Force | Out-Null
    }

    New-Item -ItemType SymbolicLink -Path $LinkPath -Target $Target | Out-Null
}

function Set-Symlink {
    param([string]$Target, [string]$LinkPath)

    Remove-Existing $LinkPath
    New-Symlink $Target $LinkPath
}

# Shell
Set-Symlink "$scriptDir\shell\powershell\profile.ps1" $powerShellProfile

# Editors
Set-Symlink "$scriptDir\nvim" $nvimConfigDir
Set-Symlink "$scriptDir\vscode\settings.json" "$vscodeUserDir\settings.json"
Set-Symlink "$scriptDir\vscode\keybindings.json" "$vscodeUserDir\keybindings.json"
Set-Symlink "$scriptDir\zed\settings.json" "$zedConfigDir\settings.json"
Set-Symlink "$scriptDir\zed\keymap.json" "$zedConfigDir\keymap.json"
Set-Symlink "$scriptDir\zed\tasks.json" "$zedConfigDir\tasks.json"

# LLMs
foreach ($target in "$claudeUserDir\CLAUDE.md", "$codexUserDir\AGENTS.md", "$hermesUserDir\SOUL.md") {
    Set-Symlink "$scriptDir\llm\SOUL.md" $target
}

# Skills: ~/.agents/skills is read-only for its harnesses, so link the whole dir.
# Claude Code owns ~/.claude/skills and writes into it (synced/), so link per skill.
Set-Symlink "$scriptDir\llm\skills" "$agentsUserDir\skills"
foreach ($skill in Get-ChildItem "$scriptDir\llm\skills" -Directory) {
    Set-Symlink $skill.FullName "$claudeUserDir\skills\$($skill.Name)"
}

Write-Host "Done"

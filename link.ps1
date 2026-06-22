#Requires -RunAsAdministrator
$ErrorActionPreference = "Stop"

# Paths
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$vscodeUserDir = Join-Path $env:APPDATA 'Code\User'
$nvimConfigDir = Join-Path $env:LOCALAPPDATA 'nvim'
$powerShellProfile = $PROFILE
$claudeUserDir = Join-Path $env:USERPROFILE '.claude'
$codexUserDir = Join-Path $env:USERPROFILE '.codex'

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

# Shell
Remove-Existing $powerShellProfile
New-Symlink "$scriptDir\shell\powershell\profile.ps1" $powerShellProfile

# Editors
Remove-Existing $nvimConfigDir
New-Symlink "$scriptDir\nvim" $nvimConfigDir
Remove-Existing "$vscodeUserDir\settings.json"
New-Symlink "$scriptDir\vscode\settings.json" "$vscodeUserDir\settings.json"
Remove-Existing "$vscodeUserDir\keybindings.json"
New-Symlink "$scriptDir\vscode\keybindings.json" "$vscodeUserDir\keybindings.json"

# LLMs
Remove-Existing "$claudeUserDir\CLAUDE.md"
New-Symlink "$scriptDir\llm\instructions.md" "$claudeUserDir\CLAUDE.md"
Remove-Existing "$codexUserDir\AGENTS.md"
New-Symlink "$scriptDir\llm\instructions.md" "$codexUserDir\AGENTS.md"

Write-Host "Done"

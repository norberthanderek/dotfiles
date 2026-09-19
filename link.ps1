#Requires -RunAsAdministrator
#Requires -Version 7.0
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

    if ([string]::IsNullOrWhiteSpace($Path)) {
        return
    }

    # PS7 Test-Path/Get-Item inspect the reparse point itself, not its target,
    # so dangling symlinks and junctions are returned as items.
    $item = Get-Item -LiteralPath $Path -Force -ErrorAction SilentlyContinue
    if (-not $item) {
        return
    }

    if ($item.Attributes -band [IO.FileAttributes]::ReparsePoint) {
        # Remove-Item on a reparse point detaches the link only, never the target.
        Remove-Item -LiteralPath $Path -Force
    }
    else {
        $backup = $Path + '.old'
        if (Test-Path -LiteralPath $backup) {
            Remove-Item -LiteralPath $backup -Force -Recurse
        }
        Move-Item -LiteralPath $Path -Destination $backup -Force
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

# Keep the real ~/.config/opencode directory, detach links, and move aside only a plain file.
$openCodeUserDir = Join-Path $env:USERPROFILE '.config\opencode'
$openCodeItem = Get-Item -LiteralPath $openCodeUserDir -Force -ErrorAction SilentlyContinue
if ($openCodeItem -and ($openCodeItem.Attributes -band [IO.FileAttributes]::ReparsePoint)) {
    # Remove-Item on a reparse point detaches the link only, never the target.
    Remove-Item -LiteralPath $openCodeUserDir -Force
}
elseif ($openCodeItem -and -not $openCodeItem.PSIsContainer) {
    $backup = "$openCodeUserDir.old"
    if (Test-Path -LiteralPath $backup) {
        Remove-Item -LiteralPath $backup -Force -Recurse
    }
    Move-Item -LiteralPath $openCodeUserDir -Destination $backup -Force
}

# LLMs
foreach ($target in "$claudeUserDir\CLAUDE.md", "$codexUserDir\AGENTS.md", "$hermesUserDir\SOUL.md", "$openCodeUserDir\AGENTS.md") {
    Set-Symlink "$scriptDir\llm\SOUL.md" $target
}

# Skills: one link for the whole dir at ~/.agents/skills.
# Claude Code owns ~/.claude/skills and writes into it (synced/), so link per skill.
Set-Symlink "$scriptDir\llm\skills" "$agentsUserDir\skills"
foreach ($skill in Get-ChildItem "$scriptDir\llm\skills" -Directory) {
    Set-Symlink $skill.FullName "$claudeUserDir\skills\$($skill.Name)"
}

# OpenCode
Remove-Existing "$openCodeUserDir\opencode.jsonc"
Set-Symlink "$scriptDir\llm\opencode\opencode.json" "$openCodeUserDir\opencode.json"
Set-Symlink "$scriptDir\llm\opencode\agents" "$openCodeUserDir\agents"

Write-Host "Done"

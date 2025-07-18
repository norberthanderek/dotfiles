$ErrorActionPreference = "Stop"

# Paths
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$vscodeUserDir = Join-Path $env:APPDATA 'Code\User'
$nvimConfigDir = Join-Path $env:LOCALAPPDATA 'nvim'
$powerShellProfile = $PROFILE

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

function Create-Symlink {
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

Remove-Existing "$vscodeUserDir\settings.json"
Create-Symlink "$scriptDir\vscode\settings.json" "$vscodeUserDir\settings.json"

Remove-Existing "$vscodeUserDir\keybindings.json"
Create-Symlink "$scriptDir\vscode\keybindings.json" "$vscodeUserDir\keybindings.json"

Remove-Existing $nvimConfigDir
Create-Symlink "$scriptDir\nvim" $nvimConfigDir

Remove-Existing $powerShellProfile
Create-Symlink "$scriptDir\shell\powershell\profile.ps1" $powerShellProfile

Write-Host "Done"

$dotfiles = Join-Path $HOME '.dotfiles'

# Add individual extentions to shell
$extensionsPath = Join-Path $dotfiles 'shell\powershell\extensions'
Get-ChildItem -Path $extensionsPath -Filter '*.ps1' | ForEach-Object {
    . $_.FullName
}
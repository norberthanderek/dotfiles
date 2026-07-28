$dotfiles = Join-Path $HOME '.dotfiles'

# Source functions.ps1
. (Join-Path $dotfiles 'shell\powershell\functions.ps1')

# Add individual extentions to shell
$extensionsPath = Join-Path $dotfiles 'shell\powershell\extensions'
Get-ChildItem -Path $extensionsPath -Filter '*.ps1' | ForEach-Object {
    . $_.FullName
}

# Ctrl+D: delete char, or exit on an empty line (bash-style)
if (Get-Module PSReadLine) {
    Set-PSReadLineKeyHandler -Chord 'Ctrl+d' -Function DeleteCharOrExit
}

# Setup fzf: Ctrl+R history search, Ctrl+T file picker
if (Get-Module -ListAvailable PSFzf) {
    Import-Module PSFzf
    Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'
}

# Open next tab in the same directory
function prompt {
    $loc = $executionContext.SessionState.Path.CurrentLocation;
    $out = ""
    if ($loc.Provider.Name -eq "FileSystem") {
        $out += "$([char]27)]9;9;`"$($loc.ProviderPath)`"$([char]27)\"
    }
    $out += "PS $loc$('>' * ($nestedPromptLevel + 1)) ";
    return $out
}

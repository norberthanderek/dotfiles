$dotfiles = Join-Path $HOME '.dotfiles'

# Add individual extentions to shell
$extensionsPath = Join-Path $dotfiles 'shell\powershell\extensions'
Get-ChildItem -Path $extensionsPath -Filter '*.ps1' | ForEach-Object {
    . $_.FullName
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

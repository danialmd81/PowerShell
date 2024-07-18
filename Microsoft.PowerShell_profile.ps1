$themePath = Join-Path -Path $HOME -ChildPath "Documents\PowerShell\.posh_themes\iterm2.omp.json"
oh-my-posh init pwsh --config $themePath | Invoke-Expression

Import-Module -Name Microsoft.WinGet.CommandNotFound

# git completion
Import-Module posh-git

# New-Alias <alias> <aliased-command>
New-Alias open ii
New-Alias mkdir ni


Set-PSReadLineKeyHandler -Key Tab -Function TabCompleteNext
Set-PSReadLineOption -PredictionSource HistoryAndPlugin
Set-PSReadLineOption -PredictionViewStyle ListView

. "$HOME\Documents\PowerShell\zig-completion.ps1"

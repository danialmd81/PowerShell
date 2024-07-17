oh-my-posh init pwsh --config "C:\Users\Danial Mobini\Documents\PowerShell\.posh_themes\iterm2.omp.json" | Invoke-Expression

Import-Module -Name Microsoft.WinGet.CommandNotFound

# git completion
Import-Module posh-git

# New-Alias <alias> <aliased-command>
New-Alias open ii
New-Alias mkdir ni


Set-PSReadLineKeyHandler -Key Tab -Function TabCompleteNext
Set-PSReadLineOption -PredictionSource HistoryAndPlugin
Set-PSReadLineOption -PredictionViewStyle ListView


# zig completion
$scriptblock = {
    param(
        $wordToComplete,
        $commandAst,
        $cursorPosition
    )
    
    $filePath = Join-Path -Path $HOME -ChildPath "Documents\PowerShell\commands-list.json"
    $commandsJson = Get-Content -Path $filePath | ConvertFrom-Json

    $wordNumber = 0
    if (($commandAst.CommandElements[0].Value.Length + $commandAst.CommandElements[1].Value.Length) -lt $cursorPosition)
    {
        $wordNumber += 1
    }
    $context = if ($wordNumber -eq 1) { 'MainCommand' } elseif ($wordNumber -gt 1) { 'ChildCommand' }
    
    $partialCommand = $wordToComplete.Trim()
    
    switch ($context)
    {
        'MainCommand'
        {
            # Suggest main commands
            $commandsJson | Where-Object { $_.Command -like "$partialCommand*" } | ForEach-Object {
                [System.Management.Automation.CompletionResult]::new(
                    $_.Command, $_.Command, 'ParameterValue', $_.Command
                )
            }
        }
        'ChildCommand'
        {
            # The user has entered a main command; now suggest child commands
            $mainCommand = $commandAst.CommandElements[$wordNumber - 1].Value
            $matchingCommand = $commandsJson | Where-Object { $_.Command -eq $mainCommand }
            
            if ($matchingCommand)
            {
                $matchingCommand.ChildCommands | Where-Object { $_.Command -like "$partialCommand*" } | ForEach-Object {
                    [System.Management.Automation.CompletionResult]::new(
                        $_, $_, 'ParameterValue', $_
                    )
                }
            }
        }
    }
}
Register-ArgumentCompleter -Native -CommandName zig -ScriptBlock $scriptblock
Register-ArgumentCompleter -Native -CommandName zig.exe -ScriptBlock $scriptblock

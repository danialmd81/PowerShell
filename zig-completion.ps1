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
Register-ArgumentCompleter -Native -CommandName zig, zig.exe -ScriptBlock $scriptblock
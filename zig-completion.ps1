# zig completion
$scriptblock = {
    param(
        $wordToComplete,
        $commandAst,
        $cursorPosition
    )
    
    $filePath = Join-Path -Path $HOME -ChildPath "Documents\PowerShell\commands-list.json"
    $commandsJson = Get-Content -Path $filePath | ConvertFrom-Json
    $wordCount = $commandAst.CommandElements.Count
    $lineSum = $commandAst.extent.EndOffset
    $sum = 0
    foreach ($element in $commandAst.CommandElements)
    {
        $sum += $element.Value.Length
    }

    if ($lineSum -eq $sum)
    {
        $context = 'MainCommand'
    }
    else
    {
        if ($lineSum -eq $cursorPosition -and $wordCount -eq 2)
        {
            $context = 'MainCommand'
        }
        else
        {
            $context = 'ChildCommand'
        }
    }
        
    if ($context -eq 'MainCommand')
    {
        if ($wordToComplete -eq '')
        {
            # Suggest main commands
            $commandsJson | ForEach-Object {
                [System.Management.Automation.CompletionResult]::new(
                    $_.Command, $_.Command, 'ParameterValue', $_.Command
                )
            }
        }
        else
        {
            # Suggest main commands
            $commandsJson | Where-Object { $_.Command -like "$wordToComplete*" } | ForEach-Object {
                [System.Management.Automation.CompletionResult]::new(
                    $_.Command, $_.Command, 'ParameterValue', $_.Command
                )
            }
        }
           
    }
    elseif ($context -eq 'ChildCommand')
    {
        # The user has entered a main command; now suggest child commands
        $mainCommand = $commandAst.CommandElements[1].Value
        $matchingCommand = $commandsJson | Where-Object { $_.Command -eq $mainCommand }
        if ($matchingCommand)
        {
            if ($wordToComplete -eq '')
            {
                $matchingCommand.ChildCommands | ForEach-Object {
                    [System.Management.Automation.CompletionResult]::new(
                        $_, $_, 'ParameterValue', $_
                    )
                }
            }
            else
            {
                $matchingCommand.ChildCommands | Where-Object { $_ -like "$wordToComplete*" } | ForEach-Object {
                    [System.Management.Automation.CompletionResult]::new(
                        $_, $_, 'ParameterValue', $_
                    )
                }
            }
        }  
    }
}

Register-ArgumentCompleter -Native -CommandName zig, zig.exe -ScriptBlock $scriptblock
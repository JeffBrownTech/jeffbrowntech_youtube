# ValidateSet
# Provides values to use for each parameter
function New-Widget {
    param (
        [Parameter(Mandatory)]
        [ValidateSet('Red', 'Green', 'Yellow')]
        [string]
        $Color,

        [Parameter(Mandatory)]
        [ValidateSet('Small', 'Medium', 'Large')]
        [string]
        $Size
    )
    "Creating a $Size widget of color $Color."
}

# ValidateSet continues to validate variable value assignment
function New-Widget {
    param (
        [Parameter(Mandatory)]
        [ValidateSet('Red', 'Green', 'Yellow')]
        [string]
        $Color,

        [Parameter(Mandatory)]
        [ValidateSet('Small', 'Medium', 'Large')]
        [string]
        $Size
    )
    "Creating a $Size widget of color $Color."
    $Color = 'Blue' # This results in an error as 'Blue' is not in ValidateSet()
}



# ArgumentCompletions
# Similar to ValidateSet does not perform validation on the parameter value if it is not in the value list
# More of a suggestion of values rather than a hard rule
function New-Widget {
    param (
        [Parameter(Mandatory)]
        [ArgumentCompletions('Red', 'Green', 'Yellow')]
        [string]
        $Color,

        [Parameter(Mandatory)]
        [ArgumentCompletions('Small', 'Medium', 'Large')]
        [string]
        $Size
    )
    
    "Creating a $Size widget of color $Color."
}



# Using Classes
# Dynamically generate values for ValidateSet() at runtime using classes
Class LogFileName : System.Management.Automation.IValidateSetValuesGenerator {
    [string[]] GetValidValues() {
        $LogFilePaths = 'C:\logs', 'C:\temp\logs'
        $LogFileName = ForEach ($LogFilePath in $LogFilePaths) {
            If (Test-Path $LogFilePath) {
                (Get-ChildItem $LogFilePath -File).Name
            }
        }
        return [string[]] $LogFileName
    }
}

Get-ChildItem -Path 'C:\logs'
Get-ChildItem -Path 'C:\temp\logs'

# Add the Class name in the ValidateSet() attribute
function Get-LogFile {
    Param(
        [ValidateSet([LogFileName])]
        [string]$FileName
    )
    "Here is the LogFile file you chose: $FileName"
}



# ArgumentCompleter
# Not to be confused with ArgumentCompletions
# Adds tab completion values to a specific parameter
# Define an ArgumentCompleter attribute for each parameter that needs tab completion along with a script block that determines the parameter's possible values

# ArgumentCompleter syntax
function ArgumentCompleterExample {
    param(
        [Parameter(Mandatory)]
        [ArgumentCompleter( {
                param ( $commandName,
                    $parameterName,
                    $wordToComplete,
                    $commandAst,
                    $fakeBoundParameters )

                # Calculate tab completed values here
            } )]
        
        $ParamName
    )
}

<#
    $commandName (Position 0): The name of the PowerShell command the script block provides the tab completion values.
    $parameterName (Position 1): The parameter requiring tab completion values.
    $wordToComplete (Position 2): The parameter value or partial word the user has provided before pressing the Tab key. The script block uses this value to determine tab completion values.
    $commandAst (Position 3): The parameter is set to the Abstract Syntax Tree (AST) for the current input line.
    $fakeBoundParameters (Position 4): This parameter contains a hashtable with the cmdlet’s $PSBoundParameters value before the user presses Tab. Basically all the parameters specified so far.
#>

<#
    The if statement checks if the Fruit parameter has been provided ($fakeBoundParameters.ContainsKey('Fruit')).
        If Fruit is provided, it retrieves the list of varieties for the specified fruit and filters them using Where-Object to match the $wordToComplete pattern.
        If Fruit is not provided, it retrieves all possible values for all fruits, flattens the list using ForEach-Object.
#>

function VarietyArgumentCompleter {
    param ( $commandName,
        $parameterName,
        $wordToComplete,
        $commandAst,
        $fakeBoundParameters )
    
    $possibleValues = @{
        Apple  = @('Gala', 'Honeycrisp', 'GrannySmith')
        Banana = @('Cavendish', 'LadyFinger', 'Manzano')
        Orange = @('Mandarin', 'Navel', 'Blood')
    }

    if ($fakeBoundParameters.ContainsKey('Fruit')) {
        $possibleValues[$fakeBoundParameters.Fruit] | Where-Object {
            $_ -like "$wordToComplete*"
        }
    }
    else {
        $possibleValues.Values | ForEach-Object { $_ }
    }
}

function Get-FruitVariety {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [ValidateSet('Apple', 'Banana', 'Orange')]
        $Fruit,

        [Parameter(Mandatory)]
        [ArgumentCompleter({ VarietyArgumentCompleter @args })]
        $Variety
    )

    "You selected the $Variety $Fruit."
}

<#
    The above implementation has some issues. It does not prevent selecting a variety first, then autocompleting the correct fruit.
    You can easily run this and the command completes successfully:
    > Get-FruitVariety -Variety Mandarin -Fruit Apple 
    > You selected the Mandarin Apple.

    Also, if you start typing a Variety first, it does not auto complete to the correct value.
    To resolve this, update the VarietyArgumentCompleter with a Where-Object clause to find a match based on the $wordToComplete variable value.
#>

function VarietyArgumentCompleter {
    param ( $commandName,
        $parameterName,
        $wordToComplete,
        $commandAst,
        $fakeBoundParameters )
    $possibleValues = @{
        Apple  = @('Gala', 'Honeycrisp', 'GrannySmith')
        Banana = @('Cavendish', 'LadyFinger', 'Manzano')
        Orange = @('Mandarin', 'Navel', 'Blood')
    }
    if ($fakeBoundParameters.ContainsKey('Fruit')) {
        $possibleValues[$fakeBoundParameters.Fruit] | Where-Object {
            $_ -like "$wordToComplete*"
        }
    }
    else {
        $possibleValues.Values | ForEach-Object { $_ } | Where-Object { $_ -like "$wordToComplete*" } # Add Where-Object clause
    }
}

# Create a FruitArgumentCompleter that searches for a matching fruit if Variety parameter has a value and Fruit does not
function FruitArgumentCompleter {
    param ( $commandName,
        $parameterName,
        $wordToComplete,
        $commandAst,
        $fakeBoundParameters )

    $possibleValues = @{
        Apple  = @('Gala', 'Honeycrisp', 'GrannySmith')
        Banana = @('Cavendish', 'LadyFinger', 'Manzano')
        Orange = @('Mandarin', 'Navel', 'Blood')
    }

    if ($fakeBoundParameters.ContainsKey('Variety') -and [string]::IsNullOrEmpty($fakeBoundParameters['Fruit'])) {
        $fruitMatchesArray = [System.Collections.ArrayList]::new()
        foreach ($key in $possibleValues.Keys) {
            if ($possibleValues[$key] -contains $fakeBoundParameters['Variety']) {
                $fruitMatchesArray.Add($key) | Out-Null
            }
        }

        $fruitMatchesArray
    }
    else {
        $possibleValues.Keys | ForEach-Object { $_ } | Where-Object { $_ -like "$wordToComplete*" }
    }
}

# Update function to use both ArgumentCompleters
function Get-FruitVariety {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [ArgumentCompleter({ FruitArgumentCompleter @args })]
        $Fruit,
        
        [Parameter(Mandatory)]
        [ArgumentCompleter({ VarietyArgumentCompleter @args })]
        $Variety
    )

    "You selected the $Variety $Fruit."
}



# Register-ArgumentCompleter
# This version of ArgumentCompleter can be used for any command, not just functions you write.

# Write a custom ArgumentCompleter to use with Set-TimeZone and the -Id parameter
# You want the -Id parameter to only return time zones you are interested in

# Define a variable script block with the same default parameters as the previous ArgumentCompleter script block
# Include the logic to only return time zones with a DisplayName that includes "(US & Canada)"

$timeZoneIdScriptBlock = {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)
    Get-TimeZone -ListAvailable | Where-Object -Property DisplayName -like -Value "*(US & Canada)*" |
        Select-Object -ExpandProperty Id |
        ForEach-Object { "'$_'" }
}

Register-ArgumentCompleter -CommandName Set-TimeZone -ParameterName Id -ScriptBlock $timeZoneIdScriptBlock

<#
    Two things to note with this method:
        1. The user can still specify other values for the parameter. Registering the argument completer only provides the suggested values for using the parameter.
        2. The ArgumentCompleter script block is only valid for the current PowerShell session. If you want to use this all the time, you must include it in your PowerShell profile.
#>
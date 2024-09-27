# Start with fundamental task and determine how to accomplish it
# Get logic app resource
$logicApp = Get-AzLogicApp -Name jbt-video-to-social

# View definition
$logicApp.Definition

# Convert to string
$logicApp.Definition.ToString()

# Export to a file
$logicApp.Definition.ToString() | Out-File -FilePath .\mylogicappbackup.json

# Create advanced function definition
function Export-LogicAppDefinition {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]
        $Name,

        [Parameter()]
        [ValidateScript(
            {
                (Test-Path -Path $_) ? $true : $false
            },
            ErrorMessage = "'{0}' is not a valid path."
        )]
        [string]
        $FilePath = (Get-Location),

        [Parameter()]
        [ValidatePattern("\.json$", ErrorMessage="'{0}' should have a .json file extension.")]
        [string]
        $FileName = "$($Name)_$(Get-Date -Format FileDateTimeUniversal).json"
    )

    $logicApp = Get-AzLogicApp -Name $Name

    if ($logicApp) {
        try {
            $logicApp.Definition.ToString() | Out-File -FilePath "$FilePath\$FileName" -ErrorAction STOP
        }
        catch {
            $errorMessage = (Get-Error -Newest 1).Exception.Message
            Write-Warning -Message "There was an issue exporting the Logic App definition for $Name : $errorMessage"
        }        
    }
    else {
        Write-Warning -Message "No Logic Apps found named $Name. Double check your spelling or current subscription context using Get-AzContext."
    }
}
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
        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)] # ValueFromPipeline and ValueFromPipelineByPropertyName allow processing input objects through the pipeline
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
        [ValidatePattern("\.json$", ErrorMessage = "'{0}' should have a .json file extension.")]
        [string]
        $FileName
    )

    # Process blocks automatically loop through any input objects coming through the pipeline
    process {
        $logicApp = Get-AzLogicApp -Name $Name

        # Creating process-specific variable so it can be nulled out when executing across multiple pipeline inputs
        $processFileName = $FileName

        # If the LogicApp exists
        if ($logicApp) {
            # Using Write methods to output to console
            Write-Verbose -Message "Processing $Name"

            # Creating a process-loop specific variable
            if (-not $processFileName) {
                $processFileName = "$($Name)_$(Get-Date -Format FileDateTimeUniversal).json"
            }

            # try/catch/finally block for error handling
            try {
                Write-Verbose -Message "Exporting Logic App definition to $processFileName."
                $logicApp.Definition.ToString() | Out-File -FilePath "$FilePath\$processFileName" -ErrorAction STOP
                $file = Get-Item -Path "$FilePath\$processFileName"

                # Creating a custom object to output what the function did
                $output = [PSCustomObject]@{
                    LogicApp = $logicApp.Name
                    File     = $file.FullName
                }

                $output
            }
            catch {
                $errorMessage = (Get-Error -Newest 1).Exception.Message
                Write-Warning -Message "There was an issue exporting the Logic App definition for $Name : $errorMessage"
            }
            finally {
                # Finally blocks always execute whether or not an error occurred. In this case, nulling out a variable.
                $processFileName = $null
            }
        }
        # If the LogicApp does not exist
        else {
            Write-Warning -Message "No Logic Apps found named $Name. Double check your spelling or current subscription context using Get-AzContext."
        }
    } # End process lbock
}
[CmdletBinding(
    DefaultParameterSetName = 'DOB'
)]
param(
    [Parameter(Mandatory)]
    [ValidateLength(3, 35)]
    [string]
    $Name,

    [Parameter(Mandatory)]
    [ValidateSet("90001", "90002", "90003")]
    [string]
    $ZipCode,

    [Parameter(Mandatory)]
    [ValidateSet("Green", "Yellow", "Orange", "Red",
        ErrorMessage = "The item '{0}' is not part of the set '{1}' or does not match capitalization rules.",
        IgnoreCase = $false
    )]
    [string]
    $PartyAffiliation,

    [Parameter(Mandatory)]
    [ValidatePattern('^[\w\.-]+@[\w\.-]+\.\w+$',
        ErrorMessage = "{0} is not recognized as a valid email address."
    )]
    [string]
    $EmailAddress,

    [Parameter(Mandatory, ParameterSetName = 'DOB')]
    [ValidateScript({
            $today = Get-Date
            $dob = Get-Date -Date $_
            $age = $today.Year - $dob.Year
            if ($today.Month -lt $dob.Month -or ($today.Month -eq $dob.Month -and $today.Day -lt $dob.Day)) {
                $age--
            }
            if ($age -lt 18) {
                throw "You must be 18 to register to vote."
            }
            else {
                $true
            }
        })]
    [string]
    $DateOfBirth,
    
    [Parameter(Mandatory, ParameterSetName = 'Age')]
    [ValidateRange(18, 120)]
    [int]
    $Age
)

switch ($PSCmdlet.ParameterSetName) {
    'DOB' { 
        "Voter Registration"
        "------------------------------------------"
        "Name: $Name"
        "Location: $ZipCode"
        "Party Affiliation: $PartyAffiliation"
        "Email Address: $EmailAddress"
        "DOB: $DateOfBirth"
    }
    'Age' {
        "Voter Registration"
        "------------------------------------------"
        "Name: $Name"
        "Location: $ZipCode"
        "Party Affiliation: $PartyAffiliation"
        "Email Address: $EmailAddress"
        "Age: $Age"
    }
}

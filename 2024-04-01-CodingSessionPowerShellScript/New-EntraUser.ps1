param(
    [Parameter(Mandatory)]
    [string]
    $UserDataFile
)

$connection = Get-MgContext
if ($null -eq $connection) {
    Write-Warning -Message "You must run Connect-MgGraph before running this script."
    exit
}

$userData = Import-Csv -Path $UserDataFile

foreach ($user in $userData) {
    $randomNum = Get-Random -Minimum 100000000 -Maximum 999999999
    
    $passwordProfile = @{
        Password                      = "Changeme$randomNum"
        ForceChangePasswordNextSignIn = $true
    }
    
    $mailNickname = "$($user.FirstName).$($user.LastName)"
    $displayName = "$($user.FirstName) $($user.LastName)"
    
    $newUserParams = @{
        DisplayName       = $displayName
        GivenName         = $user.FirstName
        Surname           = $user.LastName
        MailNickname      = $mailNickname
        UserPrincipalName = "$mailNickname@<domain>"
        PasswordProfile   = $passwordProfile
        Department        = $user.Department
        AccountEnabled    = $true
    }
    
    try {
        New-MgUser @newUserParams -ErrorAction Stop    
    }
    catch {
        $errorMessage = (Get-Error -Newest 1).Exception.Message
        if ($errorMessage -ilike "*Another object with the same value for property userPrincipalName already exists*") {
            Write-Warning -Message "$mailNickname@<domain> already exists."
        }
        else {
            Write-Warning -Message $errorMessage
        }
        
    }    
}
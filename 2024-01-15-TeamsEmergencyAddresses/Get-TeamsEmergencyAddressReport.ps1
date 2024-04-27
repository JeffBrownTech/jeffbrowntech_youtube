$userPhoneNumbers = Get-CsPhoneNumberAssignment -CapabilitiesContain UserAssignment -Top ([int]::MaxValue)

foreach ($number in $userPhoneNumbers) {
    if ($null -ne $number.AssignedPstnTargetId) {
        $user = Get-CsOnlineUser -Identity $number.AssignedPstnTargetId
    }
    else {
        $user = [PSCustomObject]@{
            DisplayName       = "Not Assigned"
            UserPrincipalName = $null
        }
    }

    $location = Get-CsOnlineLisLocation -LocationId $number.LocationId

    $output = [PSCustomObject]@{
        TelephoneNumber   = $number.TelephoneNumber
        AssignedUser      = $user.DisplayName
        UserPrincipalName = $user.UserPrincipalName
        LocationId        = $location.LocationId
        Description       = $location.Description
        Place             = $location.Location
    }

    $output
}
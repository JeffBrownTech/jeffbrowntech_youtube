Connect-MgGraph -Scopes 'Directory.ReadWrite.All'

# Get managed identity object using principal ID
$managedIdentity = Get-MgServicePrincipal -ServicePrincipalId '<service principal id>'

# Get managed identity object based on managed identity display name
$managedIdentity = Get-MgServicePrincipal -Filter "DisplayName eq '<display name>'"

# Set Microsoft Graph enterprise app object
$graphSPN = Get-MgServicePrincipal -Filter "AppId eq '00000003-0000-0000-c000-000000000000'"

# Set permission scope
$permission = "User.ReadWrite.All"

# Find app role with those permissions
$appRole = $graphSPN.AppRoles |
    Where-Object Value -eq $permission |
    Where-Object AllowedMemberTypes -contains "Application"

$bodyParam = @{
    PrincipalId = $managedIdentity.Id
    ResourceId  = $graphSPN.Id
    AppRoleId   = $appRole.Id
}

New-MgServicePrincipalAppRoleAssignment -ServicePrincipalId $managedIdentity.Id -BodyParameter $bodyParam
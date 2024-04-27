# Build information for access token
# Reference: https://learn.microsoft.com/graph/auth-v2-service#token-request

$credential = Get-Credential
$tenantId = "<tenant guid>"
$oauthUri = "https://login.microsoftonline.com/$tenantId/oauth2/v2.0/token"

$tokenRequestBody = @{
    client_id     = $credential.UserName
    client_secret = $credential.GetNetworkCredential().Password
    scope         = "https://graph.microsoft.com/.default"    
    grant_type    = "client_credentials"
}

$tokenRequestResponse = Invoke-RestMethod -Uri $oauthUri -Method POST -ContentType "application/x-www-form-urlencoded" -Body $tokenRequestBody
$accessToken = ($tokenRequestResponse).access_token

$headers = @{
    "Authorization" = "Bearer $accessToken"
    "Content-type" = "application/json"
}

$UPN = "<User Principal Name>"

Invoke-RestMethod -Method GET -Uri "https://graph.microsoft.com/v1.0/users/$UPN" -Headers $headers

Invoke-RestMethod -Method GET `
    -Uri 'https://graph.microsoft.com/v1.0/users/$UPN?$select=userprincipalname,displayname,department' `
    -Headers $headers

$body = @{
    "department" = "Accounting"
}

$bodyJson = ConvertTo-Json -InputObject $body

Invoke-RestMethod -Method PATCH -Uri 'https://graph.microsoft.com/v1.0/users/$UPN' -Headers $headers -Body $bodyJson

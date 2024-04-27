# Get details on parameters
Get-Help -Name Copy-Item -Parameter Path,Destination
Get-Help Get-Help -Parameter Name

# Both of these commmands is valid because of parameter positions
Copy-Item -Path Add-TwoNumbers.ps1 -Destination Add-ThreeNumbers.ps1
Copy-Item Add-TwoNumbers.ps1 Add-ThreeNumbers.ps1
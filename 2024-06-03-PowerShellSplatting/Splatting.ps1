<#
Syntax

$argHashTable = @{
    <parameter> = <value>
    <parameter> = <value>
}
#>

# Create hash table for New-Item
$argHashTable = @{
    "Name" = "errors.log"
    "Path" = "C:\temp"
    "ItemType" = "File"
}
 
New-Item @argHashTable

# Can still add other parameter values
New-Item @argHashTable -Value "Error! The program did not install."

# Can Overwrite splatted parameter values
$argHashTable = @{
    "Name" = "errors.log"
    "Path" = "C:\temp"
    "ItemType" = "File"
}
 
New-Item @argHashTable -Name "warnings.log"


# Using arrays
# Using named parameters
Rename-Item -Path errors.log -NewName errors-archived.log
 
# Using positional parameters
Rename-Item errors.log errors-archived.log

# Define array with values in the correct positions
$argArray = "errors.log", "errors-archived.log"
 
# Call the command using the splatted value
Rename-Item @argArray


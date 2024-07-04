# Creating a hash table on a single line
$myHashTable = @{ "SERVER1" = "82736456"; "SERVER2" = "48329067" }

# Creating a hash table using multiple lines
$myHashTable = @{
    "SERVER1" = "82736456"
    "SERVER2" = "48329067"
    "SERVER3" = "88463981"
    "SERVER4" = "55398562"
}

# Create an empty hash table
$myHashTable = @{}

# Add a key/value pair
$myHashTable.Add("SERVER5", "74665362")

# Remove a key/value pair
$myHashTable.Remove("SERVER2")

# Cannot add a duplicate key value
$myHashTable.Add("SERVER1", "74629762")

# Hashtables by default are not ordered
$unorderedHashTable = @{
    "first"  = 1
    "second" = 2
    "third"  = 3
}

# Check output
$unorderedHashTable

# Turn into ordered dictionary using [ordered]
$orderedHashTable = [ordered]@{
    "first"  = 1
    "second" = 2
    "third"  = 3
}

$orderedHashTable

# Display only keys or values in hash table
$myHashTable.keys
$myHashTable.values

# Exporting hashtables can be tricky	
$myHashTable | Export-Csv demo1.csv -NoTypeInformation

# Export hash table correctly
$myHashTable.GetEnumerator() |
    Select-Object -Property Key,Value |
    Export-Csv .\demo2.csv -NoTypeInformation


<#
PSCustomObjects have greater flexibility in that they represent an entity.
The entity can contain many properties beyond what hashtables can represent.
PSCustomObjects are better for creating structured data.
#>

# Creating custom PowerShell object
$myCustomObject = [PSCustomObject]@{
    "Name"       = "SERVER1"
    "ServiceTag" = "51ABC84"
    "Vendor"     = "Dell"
    "Model"      = "PowerEdge"
}

# View object's members and methods using Get-Member
# Note that Name, Serial, Vendor, Model are listed as NoteProperty
$myCustomObject | Get-Member

# Add new property
$myCustomObject | Add-Member `
    -Name "Owner" `
    -Value "Jeff Brown" `
    -MemberType NoteProperty

# Remove a property	
$myCustomObject.PSObject.Properties.Remove("Owner")

# Output specific object properties
$myCustomObject
$myCustomObject | Select-Object Name, ServiceTag

# Access specific properties
$myCustomObject.Name
$myCustomObject.ServiceTag


# An array of objects
$servers = @(
    [PSCustomObject]@{
        Name = "SERVER1"
        ServiceTag = "34GBH83"
        Vendor = "Dell"
        Model = "PowerEdge"
        Owner = "Jeff Brown"
        Size = "2U"
    },
    [PSCustomObject]@{
        Name = "SERVER2"
        ServiceTag = "38FGV91"
        Vendor = "Dell"
        Model = "PowerEdge"
        Owner = "Alice Jones"
        Size = "2U"
    },
    [PSCustomObject]@{
        Name = "SERVER3"
        ServiceTag = "83WUG49"
        Vendor = "Dell"
        Model = "PowerEdge"
        Owner = "Jeff Brown"
        Size = "1U"
    }
)

$servers | Where-Object -Property Size -eq "2U"
$servers | Where-Object -Property Owner -eq "Alice Jones"


<#
PSCustomObjects have built-in methods.
You can add your own methods to perform actions on the object.
#>

# View methods
$servers | Get-Member

# Create script block variable with code for method
# This one converts a Dell service tag to the express service code
# Use $this to reference the current object
$convertScriptBlock = {
    $serviceTag = $this.ServiceTag
    $alphabet = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    $serviceTagCharArray = $serviceTag.ToUpper().ToCharArray()
    [System.Array]::Reverse($serviceTagCharArray)
    [System.Int64]$expressServiceCode = 0
    $count = 0
    foreach($char in $serviceTagCharArray){
        $expressServiceCode += $alphabet.IndexOf($char) * [System.Int64][System.Math]::Pow(36,$count)
        $count += 1
    }
    $expressServiceCode
}

# Use Add-Member to add $convertScriptBlock to the object
# The -Name parameter reflects the method name
Add-Member `
    -MemberType "ScriptMethod" `
    -InputObject $myCustomObject `
    -Name "ToExpressServiceCode" `
    -Value $convertScriptBlock

$myCustomObject | Get-Member


# Set custom PSTypeName
$myCustomObject = [PSCustomObject]@{
    "PSTypeName" = "DellServer"
    "Name"       = "SERVER1"
    "ServiceTag" = "51ABC84"
    "Vendor"     = "Dell"
    "Model"      = "PowerEdge"
}

$myCustomObject | Get-Member

# Export objects to CSV
$myCustomObject | Export-Csv .\demo3.csv
# Import and display CSV file contents
Import-Csv -Path C:\ps\example.csv



# Import CSV file without a header row
# Define headers and save to variable
$header = 'FirstName', 'LastName', 'Department'

Import-Csv -Path C:\ps\example_noheaders.csv -Header $header



# Import CSV assumes comma-separated values
# Can specify different delimiter
Import-Csv -Path C:\ps\example_delimiter.csv -Delimiter :



# Importing a CSV creates custom objects when importing CSV data
# Save the import to a variable and view its members
$userData = Import-Csv -Path C:\ps\example.csv
$userData
$userData | Get-Member

# View different properties of the entire collection
$userData.Department
$userData.FirstName

# Perform filtering on properties
$userData | Where-Object Department -eq "Accounting"

# Use indexes to view specific items
$userData[0]
$userData[0..1]
$userData[-1]



# foreach statements allow you to loop or iterate through a collection
# Basic syntax
foreach ($item in $collection) {
    # perform actions
}

foreach ($number in $allNumbers) {}
foreach ($user in $allUsers) {}

# Use current item variable to perform action on that item
$allNames = @('Ted', 'Rebecca', 'Patrick', 'June')
foreach ($name in $allNames) { "Current item: $name" }

foreach ($name in $names) {
    "$name has $($name.Length) letters in it."
}



# Access properties from imported CSV file
# To access object member properties in a string, use a subexpression $()
$userData = Import-Csv -Path C:\ps\example.csv
foreach ($user in $userData) {
    "$($user.FirstName) $($user.LastName) works in the $($user.Department) department."
}

# Alternatively, save each member to its own variable
foreach ($user in $userData) {
    $firstName = $user.FirstName
    $lastName = $user.LastName
    $department = $user.Department
    "$firstName $lastName works in the $department department."
}

# Use indexes to limit foreach scope
foreach ($user in $userData[0..1]) {
    "$($user.FirstName) $($user.LastName) works in the $($user.Department) department."
}
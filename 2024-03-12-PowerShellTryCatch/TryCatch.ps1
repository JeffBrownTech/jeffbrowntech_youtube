# Try Catch syntax
try {
    # Command(s) to try
}
catch {
    # What to do with terminating errors
}

# Generate an error
New-Item -Path C:\doesnotexist -Name test.txt -ItemType File

# Error handling
try {
    New-Item -Path C:\doesnotexist -Name test.txt -ItemType File
}
catch {
    Write-Warning -Message "Something went wrong!"
}

# Might need to add -ErrorAction Stop
try {
    New-Item -Path C:\doesnotexist -Name test.txt -ItemType File -ErrorAction STOP
}
catch {
    Write-Warning -Message "Something went wrong!"
}



# Use $Error automatic variable
try {
    New-Item -Path C:\doesnotexist -Name test.txt -ItemType File -ErrorAction STOP
}
catch {
    Write-Warning -Message $Error[0]
}



# Use object coming out of the try block using $_
try {
    New-Item -Path C:\doesnotexist -Name test.txt -ItemType File -ErrorAction STOP
}
catch {
    $message = $_
    Write-Warning -Message "$message"
}



# Use multiple catch blocks to handle specific errors
try {
    # Example 1
    #New-Item -Path C:\doesnotexist -Name test.txt -ItemType File -ErrorAction STOP

    # Example 2
    New-Item -Path C:\Users -Name "my*file.txt" -ItemType File -ErrorAction STOP
}
catch [System.NotSupportedException] {
    Write-Warning -Message "Warning: Illegal character used in the filename."
}
catch [System.IO.DirectoryNotFoundException] {
    Write-Warning -Message "Warning: The path is not valid."
}
catch [System.IO.IOException] {
    Write-Warning -Message "Warning: Illegal character used in the filename."
}
catch {
    Write-Warning -Message "Warning: An unexpected error occurred."
}



# Find exception message
# Generate error again
New-Item -Path C:\doesnotexist -Name test.txt -ItemType File

# Output last error exception
$Error[0].Exception.GetType().FullName

# PowerShell 7 way using Get-Error
Get-Error -Newest 1
(Get-Error -Newest 1).Exception.Type

# Saving last error message
$lastError = (Get-Error -Newest 1).Exception.Message
$lastError


# Using if/then logic in catch block
New-MgGroupMember -DirectoryObjectId '<user guid>' -GroupId '<group guid>'
$Error[0].Exception.GetType().FullName

try {
    New-MgGroupMember `
        -DirectoryObjectId '<user guid>' `
        -GroupId '<group guid>' `
        -ErrorAction Stop
}
catch {
    $message = $_
    if ($message -ilike "*One or more added object references already exist*") {
        "INFO: User is already a member of the group."
    }
    else {
        Write-Warning -Message $message
    }
}
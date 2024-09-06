# Use Get-Help to find out more about a command
Get-Help -Name Set-LocalUser

# If you get a message that the Help files for the cmdlet are not available, run Update-Help to download help files
Update-Help

# See detailed help information
Get-Help -Name Set-LocalUser -Detailed

# See full information
Get-Help -Name Set-LocalUser -Full

# View examples of how to use the cmdlet
Get-Help -Name Set-LocalUser -Examples

# View online help (if available)
Get-Help -Name Set-LocalUser -Online

# View help in separate window
Get-Help -Name Set-LocalUser -ShowWindow


# Build a PowerShell cmdlet with parameters and values
Show-Command Set-LocalUser


# View your previous commands
Get-History


# View approved verbs
Get-Verb


# Find version and source module of cmdlet
Get-Command -Name Set-LocalUser

# Search for commands
Get-Command -Name Set-*User*
Get-Command -Verb Invoke
Get-Command -Noun LocalUser
Get-Command -Noun *User
Get-Command -Module Az.Accounts



# View aliases
Get-Alias -Name select
Get-Alias -Name where
Get-Alias -Name foreach
Get-Alias -Name %
Get-Alias -Name fl
Get-Alias -Name gm
Get-Alias -Name history



# Limit number of returned results using Select-Object
$firstProcess = Get-Process | Select-Object -First 1
$firstProcess

$first10Process = Get-Process | Select-Object -First 10
$first10Process

$last5Process = Get-Process | Select-Object -Last 5
$last5Process


# The "power" of PowerShell is that everything is an object. This concept allows information and data to be manipulated very easily compared to other command-line interfaces.
# An object is an instance of a .NET class, meaning it has properties and methods that can be accessed and manipulated.
$string = "Hello, World!"
$string.GetType()
$string.Length
$string.ToUpper()


# View properties and methods of objects
Get-Process | Get-Member
Get-Process | gm  #alias

$firstProcess.Name
$firstProcess.CommandLine
$firstProcess.Id


$myString = "  here is my string  "
$myString | Get-Member
$myString.Trim()
$myString.Replace("my", "your")
$myString.Split(" ")


# Sort objects
Get-Process | Sort-Object -Descending CPU
Get-Process | Sort-Object -Descending CPU -Top 10


# Use pipe symbol | to pass results or objects to another command
# Chaining commands together enable complex operations in a readable, streamlined manner
# In the last example, Get-Process is retrieving every running process, then sending those results to Sort-Object for further processing

# Use Where-Object to filter results
Get-Process | Where-Object Name -Like "msedge*"
Get-Process | Where-Object Name -Like "msedge*" | Sort-Object -Descending CPU

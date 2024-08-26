# Search a file for a keyword
Get-Content -Path logfile.txt | Select-String -Pattern "^ERROR"


# Find matching email addresses matching a domain using -matches and $Matches variable
$emailAddresses = @(
    "jeff@contoso.com",
    "john@fabrikam.com",
    "phyllis@partsunlimited.com",
    "michael@fabrikam.com",
    "angela@contoso.com",
    "andy@partsunlimited.com"
)

# Pattern explanation
# ^ caret means start of the line
# (.*) is the first capture group (parentheses), period (.) means any character, asterisk (*) means zero to unlimited occurrences
# Literal @ sign
# (contoso.com) is the second capture group with literal string contoso.com
# $ means end of line
$pattern = "^(.*)@(contoso.com)$"

# Compare entire array against the pattern, outputs emails matching @contoso.com
$emailAddresses -match $pattern

# Iterate through a foreach and compare each array item to the pattern
# This action populates the $Matches variable into the groupings from the pattern (username)@(domain)
foreach ($email in $emailAddresses) {
    If ($email -match $pattern) {
        $output = [PSCustomObject]@{
            "Email"    = $Matches[0]
            "Username" = $Matches[1]
            "Domain"   = $Matches[2]
        }

        $output        
    }
}

# $Matches is a hashtable containing the results of the most recent successful regular expression match operation when using -match operator
# $Matches[0] contains the entire matched string
# $Matches[1], $Matches[2], etc., contains the strings matches by each capture group in the regular expression. The index corresponds to the order of the pattern capture group(s).
$emailAddresses[0] -match $pattern # Compare array first entry to regex pattern

$Matches    # Full hashtable
$Matches[0] # Entire string
$Matches[1] # First capture group
$Matches[2] # Second capture group


# Using -replace operator to replace string components
# For example, removing any non-digit characters from a phone number
# \D matches any non-digit characters (equivalent to [^0-9])
$phoneNumber = "(555) 456-7890"
$phoneNumber -replace "\D", ""


# Use ValidatePattern() on parameter values
function Send-Message {
    param(        
        [Parameter(Mandatory)]
        [ValidatePattern("^[\w\.-]+@[\w\.-]+\.\w+$")]
        [string]
        $EmailAddress
    )

    "Sending message to $EmailAddress."
}
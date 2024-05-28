# Copying strings
$string1 = 'This is my string.'
$string2 = $string1
$string1
$string2

# Modify $string2
$string2 = $string2 + "Appending to string2"
$string1
$string2


# Create a hashtable $person1 and copy it to $person2
$person1 = @{
    Name = 'Jeff'
    Profession = 'Cloud Wrangler'
}
 
$person2 = $person1
$person1
$person2


# Add a value to $person2
$person2.Add('State', 'Washington')
$person1
$person2

<#
Why did $person1 also get the 'State' property?

Hashtables are objects, and variables (like $person1 and $person2) only reference the object's place in memory.
Each variable is actually pointing to the hashtable, not separate ones.

Verify this using [System.Object]::ReferenceEquals()
#>

[System.Object]::ReferenceEquals($string1, $string2)
[System.Object]::ReferenceEquals($person1, $person2)

# Copy a hashtable using Clone()
$person3 = $person1.Clone()
$person3.Add('City', 'Seattle')
$person3
$person1

[System.Object]::ReferenceEquals($person1, $person3)

# Copy a hash table using foreach
$person4 = @{}

foreach($key in $person1.Keys) {
    $person4[$key] = $person1[$key]
}

$person4["County"] = "King"

[System.Object]::ReferenceEquals($person1, $person4)
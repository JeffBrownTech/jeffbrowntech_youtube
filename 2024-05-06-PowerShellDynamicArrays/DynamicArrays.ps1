# Multiple ways to create arrays
$animals = 'cat','dog','bird','horse','rabbit','goat','pig'
$animals = @('cat','dog','bird','horse','rabbit','goat','pig')

# Access array items using indexes
$animals[1]
$animals[2..4]
$animals[-1]



# Attempt to add to the array
$animals.Add('cow')

# Is the array of FixedSize?
$animals.IsFixedSize

# += operator to add to array
# Could lead to performance issues with large arrays
$animals += 'fox'

$animals = $animals -ne 'bird'
$animals



# Use .NET classes to create dynamic arrays

# ArrayList example
$animalsArrayList = [System.Collections.ArrayList]::new()
$animalsArrayList.Add('cat')
$animalsArrayList.Add('dog')
$animalsArrayList.Add('bird')
$animalsArrayList

# Suppress index output
$animalsArrayList = [System.Collections.ArrayList]::new()
[void]$animalsArrayList.Add('cat')
[void]$animalsArrayList.Add('dog')
$animalsArrayList.Add('bird') | Out-Null

# Remove elements by name
$animalsArrayList.Remove('dog')

# Convert existing FixedSize array to Dynamic
$fixedArray = @('cat','dog','bird','horse','rabbit')
[System.Collections.ArrayList]$arrayList = $fixedArray
$arrayList.Add('fox')

# Use Generic Lists
# Requires defining the data type used in the collection

# Define generic string list
$myStringList = [System.Collections.Generic.List[string]]::new()
# Define generic int list
$myIntList = [System.Collections.Generic.List[int]]::new()

# Add/remove elements to the list
$myStringList.Add('string1')
$myStringList.Add('string2')
[void]$myStringList.Remove('string1')
$myIntList.Add(1)
$myIntList.Add(3)
[void]$myIntList.Remove(1)

# Convert existing Fixed Array to Generic List
$fixedArray = @('cat','dog','bird','horse','rabbit')
[System.Collections.Generic.List[string]]$genericList = $fixedArray
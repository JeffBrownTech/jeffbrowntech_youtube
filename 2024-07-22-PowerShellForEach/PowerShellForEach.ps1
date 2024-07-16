# foreach statement
foreach ($item in $collection) {
    # loop statements go here
}

# Define the array
$namesArray = "Jeff","Mary","John","Heather"

# Create a foreach loop to iterate through each array item
foreach ($name in $namesArray) { $name }

# Create array or collection in the foreach statement
foreach ($process in Get-Process) {
    if ($process.ProcessName -like "A*") {
        $process.ProcessName
    }
}


# ForEach-Object
Get-Process | ForEach-Object # ...

# ForEach-Object does have an alias of "foreach" but this is not the same as the foreach from above!
Get-Process | foreach # ...


# ForEach-Object and Script Blocks
Get-Process | ForEach-Object {
    if ($_.ProcessName -like "A*") {
        $_.ProcessName
    }
}

# Use Begin/Process/End script blocks
1..5 | ForEach-Object -Begin {"Starting"} -Process {$_} -End {"Ending"}


# ForEach-Object and Operation statements
Get-Process | ForEach-Object ProcessName

# Perform methods on incoming object
"one,two,three,four" | ForEach-Object -MemberName Split -ArgumentList ","


# PowerShell 7 introduces parallel processing
1..12 | ForEach-Object -Parallel {
    "Processing $_"
    Start-Sleep -Seconds 3
} -ThrottleLimit 4


# ForEach Method
$namesArray = "Jeff","Mary","John","Heather"
$namesArray.ForEach( {$_} )
$namesArray.ForEach( {"My name is $_."} )


# ForEach Performance
# Each implementation is not created equally

# Define a large array
$nums = 1..9999999

# Test performance of each method

"foreach statement"
Measure-Command { foreach ($item in $nums) {$item} }

"ForEach method"
Measure-Command { $nums.ForEach( {$_} ) }

"ForEach-Object"
Measure-Command { $nums | ForEach-Object {$_} }
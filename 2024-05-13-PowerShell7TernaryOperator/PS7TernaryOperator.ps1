# Regular if/else statement
$valueA = 50
$valueB = 100
if ($valueA -gt $valueB) {
    "$valueA is greater than $valueB."
}
else {
    "$valueA is less than $valueB."
}

# Ternary syntax
# <condition> ? <if-true statement> : <if-false statement>

# Ternary operation
$valueA -gt $valueB ? "$valueA is greater than $valueB." : "$valueA less than $valueB."



(Test-Path -Path 'C:\logFiles') ? 'Directory already exists' : (New-Item -Path 'C:\logFiles' -ItemType Directory)



$IsWindows ? 'You are running Windows' : 'You are not running Windows'
$IsMacOS ? 'You are running MacOS' : 'You are not running MacOS'
$IsLinux ? 'You are running Linux' : 'You are not running Linux'

# Nested ternary operations
$IsMacOS ? 'You are running MacOS' : $IsLinux ? 'You are running Linux' : 'You are running Windows.'



# Multi-line example
(Test-Path -Path 'C:\logFiles') ?
  'Directory already exists' :
  (New-Item -Path 'C:\logFiles' -ItemType Directory)


# Calculating values
$widgetArray = @(
    [PSCustomObject]@{
        Name   = "widget001"
        Price  = 5.00
        OnSale = $true
    },
    [PSCustomObject]@{
        Name   = "widget002"
        Price  = 13.00
        OnSale = $true
    },
    [PSCustomObject]@{
        Name   = "widget003"
        Price  = 20.00
        OnSale = $false
    }
)

foreach ($widget in $widgetArray) {
    [PSCustomObject]@{
        "Name"          = $widget.Name
        "Over10Dollars" = ($widget.Price -gt 10) ? $true : $false
        "OnSale"        = ($widget.OnSale) ? 'On Sale' : 'Not on Sale'
        "SalePrice"     = ($widget.OnSale) ? $widget.Price * 0.85 : "---"
    }
}
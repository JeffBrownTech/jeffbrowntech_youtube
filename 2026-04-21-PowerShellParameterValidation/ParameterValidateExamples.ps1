# 🚫 Bad: Using throw to validate or make a parameter mandatory
function Get-GreetingBad {
    param(
        $Name
    )

    if (-not $Name) {
        throw "Name value not provided!"
    }

    Write-Output "Hi $Name!"
}


# ✅ Good: Using [Parameter(Mandatory)] to enforce parameter usage
function Get-GreetingGood {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Name
    )

    Write-Output "Hi $Name!"
}


# 🚫 Bad: Using throw as a default value to enforce mandatory parameter
function Get-SomethingBad {
    param(
        [string]$Name = $(throw "Name is mandatory, please provide a value.")
    )
    
    Write-Output "Parameter Value: $Name"
}


# ✅ Good: Using [Parameter(Mandatory)] to enforce parameter usage along with ValidateNotNullOrEmpty
function Get-SomethingGood {
    param(
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Name
    )

    Write-Output "Parameter Value: $Name"
}


# ✅ Can use throw in ValidateScript if you want a custom error message
function Get-ThingDefault {
    param(
        [Parameter(Mandatory)]
        [ValidateScript({
            Test-Path -Path $_
        })]
        [string]
        $Path
    )
}


# ✅ Customize error message
function Get-ThingCustom {
    param(
        [Parameter(Mandatory)]
        [ValidateScript({
            if (Test-Path -Path $_) { $true }
            else { throw "Path $_ is not valid or does not exist."}
        })]
        [string]
        $Path
    )
}

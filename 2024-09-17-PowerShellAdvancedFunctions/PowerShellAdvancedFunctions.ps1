# Basic function using 'function' keyword and function name
# While not required, I suggest using Verb-Noun for the name to match cmdlet-naming.
function New-Greeting {
    "Hello, World!"
}

# Advanced functions are enabled by including the CmdletBinding attribute.
# This enables the function to act like a cmdlet.
function New-Greeting {
    [CmdletBinding()]
    param()
    "Hello, World!"
}

<#
The CmdletBinding attribute contains several properties

-ConfirmImpact: Specifies if the function action should be confirmed using the ShouldProcess method and displays a confirmation prompt before continuing.
-DefaultParameterSetName: Specifies the name of the default parameter set when PowerShell cannot determine which parameter set to use.
-HelpURI: Defines the online version of the function help topic.
-SupportsPaging: Adds the First, Skip, and IncludeTotalCount parameters to the function.
-SupportShouldProcess: Add the Confirm and WhatIf parameters to the function.
-PositionalBinding: Determines whether or not the function parameters are positional by default. The default value is $True.
#>

# SupportShouldProcess or the -WhatIf parameter
function Set-Greeting {
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory)]
        [string]
        $Name
    )

    if ($PSCmdlet.ShouldProcess($Name)) {
        $greeting = "Hello, $Name!"
        $greeting
    }
}

# When ConfirmImpact is equal to or higher than the value in $ConfirmPreference, then the function asks for confirmation
# Possible values are Low, Medium, High
$ConfirmPreference = 'High'

function Set-Greeting {
    [CmdletBinding(ConfirmImpact='Low', SupportsShouldProcess)]
    param(
        [Parameter(Mandatory)]
        [string]
        $Name
    )
    
    if ($PSCmdlet.ShouldProcess($Name)) {
        $greeting = "Hello, $Name!"
        $greeting
    }
}

# Using WriteMethods like Write-Verbose
function New-Greeting {
    [CmdletBinding()]
    param(
        [Parameter()]
        [string]
        $Name = "World"
    )
    
    if ($Name -eq "World") {
        Write-Verbose -Message "You are using the default Name value."
    }
    else {
        Write-Verbose -Message "You are using a custom Name value."        
    }

    "Hello, $Name!"
}


<#
While the CmdletBinding attribute makes an advanced function action like a cmdlet,
there are several other "best practices" to follow when writing functions:

- Parameter validation
- Pipeline input
- Error handling
#>
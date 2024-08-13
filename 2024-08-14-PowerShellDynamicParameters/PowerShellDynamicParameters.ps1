<#
    PowerShell dynamic parameters are available when certain conditions are met.
    The example below outlines a custom function for creating a Microsoft Teams channel.
    Channels can be public or private within a team. When creating a private channel, you have to specify a channel owner.

    Here is the start of the function New-Channel. Next steps are to specify the channell owner when $ChannelType = 'Private'
#>

function New-Channel {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]
        $ChannelName,

        [Parameter(Mandatory)]
        [ValidateSet('Standard', 'Private')]
        [string]
        $ChannelType
    )
}



# Use the DynamicParam keyword with a script block to define the dynamic parameter

function New-Channel {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]
        $ChannelName,
        [Parameter(Mandatory)]
        [ValidateSet('Standard', 'Private')]
        [string]
        $ChannelType
    )
    DynamicParam {}
}


# Start writing the logic in the script block for the conditions when the parameter should appear
DynamicParam {
    if ($ChannelType -eq 'Private') {
        # Define parameter
    }
}


# Dynamic parameters are defined a little differently
# First, create a new ParameterAttribute object

DynamicParam {
    if ($ChannelType -eq 'Private') {
        $paramAttributes = New-Object -Type $System.Management.Automation.ParameterAttribute

        # Set parameter attributes
        $paramAttributes.Mandatory = $true

        # Create a collection of type System.Attribute and add $paramAttributes to it
        $paramAttributesCollect = New-Object -Type System.Collections.ObjectModel.Collection[System.Attribute]
        $paramAttributesCollect.Add($paramAttributes)

        # Create a RuntimeDefineParameter object with the parameter name ("PrivateChannelOwner"), the parameter type ("string"), and the attribute collection ($paramAttributecollect)
        $dynParam1 = New-Object -Type System.Management.Automation.RuntimeDefinedParameter("PrivateChannelOwner", [string], $paramAttributesCollect)

        # Create a RuntimeDefinedParameterDictionary and store the RuntimeDefinedParameter object in it, then return it
        $paramDictionary = New-Object -Type System.Management.Automation.RuntimeDefinedParameterDictionary
        $paramDictionary.Add("PrivateChannelOwner", $dynParam1)
        return $paramDictionary
    }
}



# The rest of the function must be contained in begin/process/end blocks
# To reference the dynamic parameter value, use the automatic variable $PSBoundParameters

<#
    begin {
        $PrivateChannelOwner = $PSBoundParameters['PrivateChannelOwner']
    }
    process {
        if ($PrivateChannelOwner) {
            # Code to create private channel with owner
        }
        else {
            # Code to create standard channel, no owner needed
        }
    }
#>



# Here is the entire function put together
function New-Channel {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]
        $ChannelName,

        [Parameter(Mandatory)]
        [ValidateSet('Standard', 'Private')]
        [string]
        $ChannelType
    )

    DynamicParam {
        if ($ChannelType -eq 'Private') {
            # Define parameter attributes
            $paramAttributes = New-Object -Type System.Management.Automation.ParameterAttribute
            $paramAttributes.Mandatory = $true
            
            $paramAttributesCollect = New-Object -Type System.Collections.ObjectModel.Collection[System.Attribute]
            $paramAttributesCollect.Add($paramAttributes)
            
            $dynParam1 = New-Object -Type System.Management.Automation.RuntimeDefinedParameter("PrivateChannelOwner", [string], $paramAttributesCollect)
            
            $paramDictionary = New-Object -Type System.Management.Automation.RuntimeDefinedParameterDictionary
            $paramDictionary.Add("PrivateChannelOwner", $dynParam1)
            return $paramDictionary
        }
    }
    begin {
        $PrivateChannelOwner = $PSBoundParameters['PrivateChannelOwner']
    }

    process {
        if ($PrivateChannelOwner) {
            "Channel Name: $ChannelName"
            "Channel Type: $ChannelType"
            "Private Channel Owner: $PrivateChannelOwner"
        }
        else {
            "Channel Name: $ChannelName"
            "Channel Type: $ChannelType"
        }
    }
}
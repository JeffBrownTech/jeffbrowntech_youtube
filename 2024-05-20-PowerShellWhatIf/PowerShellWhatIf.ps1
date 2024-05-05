function New-Widget {
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory)]
        [string]
        $Shape,

        [Parameter(Mandatory)]
        [string]
        $Color,

        [Parameter(Mandatory)]
        [Int32]
        $Quantity
    )

    $widgetObject = [PSCustomObject]@{
        Shape    = $Shape
        Color    = $Color
        Quantity = $Quantity
    }

    if ($PSCmdlet.ShouldProcess("Creating a brand new widget","widget.txt","Creating widget")) {
        Add-Content -Path widget.txt -Value $widgetObject
    }    
}
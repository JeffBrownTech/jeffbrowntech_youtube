[CmdletBinding(
    DefaultParameterSetName = 'Id'
)]
param(
    [Parameter(Mandatory, ParameterSetName = 'Name')]
    [string]
    $GroupName,
        
    [Parameter(Mandatory, ParameterSetName = 'Id')]
    [string]
    $GroupId,

    [Parameter(Mandatory)]
    [string]
    $UserName
)

switch ($PSCmdlet.ParameterSetName) {
    'Name' {
        'You used the Name parameter set.'
        "GroupName: $GroupName"
        "UserName: $UserName"
        break
    }
    'Id' {
        'You used the Id parameter set.'
        "GroupId: $GroupId"
        "UserName: $UserName"
        break
    }
}

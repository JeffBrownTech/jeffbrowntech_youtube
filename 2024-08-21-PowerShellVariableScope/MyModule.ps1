function Get-Greeting {
    if ($name) {
        $greeting = "Hello, $name!"
    }
    else {
        $greeting = "Hello, World!"
    }
     
    $greeting
}
     
function Set-GreetingName {
    param(
        [Parameter(Mandatory)]
        [string]
        $GreetingName
    )
     
    $name = $GreetingName
}

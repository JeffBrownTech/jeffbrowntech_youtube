# Adding script: modified makes the variable value available between the functions

function Get-Greeting {
    if ($script:name) {
        $greeting = "Hello, $script:name!"
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
     
    $script:name = $GreetingName
}

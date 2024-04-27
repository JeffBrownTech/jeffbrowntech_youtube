param(
    [Alias("Num1","FirstNum")]
    [Parameter(
        Mandatory,
        Position = 0
    )]
    [double]$FirstNumber = 0,

    [Alias("Num2","SecondNum")]
    [Parameter(
        Position = 1
    )]
    [double]$SecondNumber = 0
)

"$FirstNumber plus $SecondNumber equals $($FirstNumber + $SecondNumber)."
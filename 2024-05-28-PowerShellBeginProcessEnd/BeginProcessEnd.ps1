function Show-BeginProcessEnd {
    [CmdletBinding()]
    param(
        [Parameter(
            Mandatory,
            ValueFromPipeline
        )]
        [int[]]
        $Item
    )
    Begin { 
        $sum = 0
        $count = 0
    }
    Process {
        "Input: $Item"
        foreach ($i in $Item) {
            "Processing $i"
            $sum += $i
            $count++
        }
    }
    End { 
        "The sum of the items is $sum."
        "The total number of items is $count."
    }
}
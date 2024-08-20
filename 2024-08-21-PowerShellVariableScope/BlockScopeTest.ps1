# Testing Scope Block
# Variable defined inside foreach or if statements are available outside those definitions.
# This is not true in all programming languages.

foreach ($item in 1..5) {
    $insideArray = $item
}

$insideArray

if ($true) {
    $insideIf = "Inside If"
}

$insideIf

# Define fixation points
$script:FIXATION_POINTS = @(
    @(0, 4, 12, 17, 24, 29, 35, 42, 48),
    @(1, 2, 7, 10, 13, 14, 19, 22, 25, 28, 31, 34, 37, 40, 43, 46, 49),
    @(1, 2, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31, 33, 35, 37, 39, 41, 43, 45, 47, 49),
    @(0, 2, 4, 5, 6, 8, 9, 11, 14, 15, 17, 18, 20, 0, 21, 23, 24, 26, 27, 29, 30, 32, 33, 35, 36, 38, 39, 41, 42, 44, 45, 47, 48),
    @(0, 2, 3, 5, 6, 7, 8, 10, 11, 12, 14, 15, 17, 19, 20, 21, 23, 24, 25, 26, 28, 29, 30, 32, 33, 34, 35, 37, 38, 39, 41, 42, 43, 44, 46, 47, 48)
)

function Get-WordFixationLength {
    <#
    .SYNOPSIS
    Determines the fixation length of a word based on its size and the fixation size parameter.

    .DESCRIPTION
    This function calculates the fixation length of a word by comparing its size to predefined fixation points.
    It returns the index of the first fixation point that is greater than or equal to the word size.

    .PARAMETER Word
    The word for which to determine the fixation length.

    .PARAMETER FixationSize
    The fixation size to use for the calculation. This should be an integer value.

    .EXAMPLE
    Get-WordFixationLength -Word "example" -FixationSize 3

    This will return the index of the fixation point for the word "example" with a fixation size of 3.
    #>
    param (
        [string]$Word,
        [int]$FixationSize
    )
    $WordSize = $Word.Length
    $Points = $script:FIXATION_POINTS[$FixationSize]

    foreach ($Point in $Points) {
        if ($WordSize -le $Point) {
            return [array]::IndexOf($Points, $Point)
        }
    }
}

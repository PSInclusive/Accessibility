function Get-ContrastRatio {
    <#
    .SYNOPSIS
    Calculates the WCAG contrast ratio between two relative luminance values.

    .DESCRIPTION
    Implements the W3C WCAG 2.1 contrast ratio formula. Returns a ratio between 1:1
    (no contrast) and 21:1 (maximum contrast, black on white).

    .PARAMETER Luminance1
    Relative luminance of the first color (0.0 to 1.0).

    .PARAMETER Luminance2
    Relative luminance of the second color (0.0 to 1.0).

    .EXAMPLE
    Get-ContrastRatio -Luminance1 1.0 -Luminance2 0.0
    # Returns 21.0 (white on black)

    .NOTES
    https://www.w3.org/TR/WCAG21/#dfn-contrast-ratio
    #>
    param (
        [Parameter(Mandatory = $true)]
        [double]$Luminance1,
        [Parameter(Mandatory = $true)]
        [double]$Luminance2
    )

    $lighter = [Math]::Max($Luminance1, $Luminance2)
    $darker  = [Math]::Min($Luminance1, $Luminance2)

    return ($lighter + 0.05) / ($darker + 0.05)
}

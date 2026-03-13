function Get-RelativeLuminance {
    <#
    .SYNOPSIS
    Calculates the relative luminance of an RGB color per the W3C WCAG 2.1 formula.

    .DESCRIPTION
    Implements the W3C relative luminance formula required for WCAG contrast ratio
    calculations. Returns a value between 0 (black) and 1 (white).

    .PARAMETER R
    Red channel value (0-255).

    .PARAMETER G
    Green channel value (0-255).

    .PARAMETER B
    Blue channel value (0-255).

    .EXAMPLE
    Get-RelativeLuminance -R 0 -G 0 -B 0
    # Returns 0 (black)

    .EXAMPLE
    Get-RelativeLuminance -R 255 -G 255 -B 255
    # Returns 1 (white)

    .NOTES
    https://www.w3.org/TR/WCAG21/#dfn-relative-luminance
    #>
    param (
        [Parameter(Mandatory = $true)]
        [ValidateRange(0, 255)]
        [int]$R,
        [Parameter(Mandatory = $true)]
        [ValidateRange(0, 255)]
        [int]$G,
        [Parameter(Mandatory = $true)]
        [ValidateRange(0, 255)]
        [int]$B
    )

    $channels = @($R / 255.0, $G / 255.0, $B / 255.0)
    $linearized = $channels | ForEach-Object {
        if ($_ -le 0.04045) {
            $_ / 12.92
        } else {
            [Math]::Pow(($_ + 0.055) / 1.055, 2.4)
        }
    }

    return (0.2126 * $linearized[0]) + (0.7152 * $linearized[1]) + (0.0722 * $linearized[2])
}

function Test-ColorContrast {
    <#
    .SYNOPSIS
    Calculates the WCAG contrast ratio between two RGB colors and checks accessibility compliance.

    .DESCRIPTION
    Given foreground and background colors as RGB integer arrays, calculates the contrast
    ratio per WCAG 2.1 and returns a result object showing the ratio and whether it meets
    WCAG AA (4.5:1 normal text, 3:1 large text) and AAA (7:1 normal text, 4.5:1 large text)
    compliance thresholds.

    .PARAMETER Foreground
    The foreground (text) color as an array of three integers: R, G, B (each 0-255).

    .PARAMETER Background
    The background color as an array of three integers: R, G, B (each 0-255).

    .EXAMPLE
    Test-ColorContrast -Foreground 0,0,0 -Background 255,255,255

    Tests black text on white background. Returns a 21:1 ratio, passing both AA and AAA.

    .EXAMPLE
    Test-ColorContrast -Foreground 213,94,0 -Background 255,255,255

    Tests Okabe-Ito Vermillion on white. Returns contrast ratio and compliance result.

    .EXAMPLE
    Test-ColorContrast -Foreground 128,128,128 -Background 255,255,255

    Tests mid-gray on white to illustrate a failing AA contrast ratio.

    .NOTES
    https://www.w3.org/TR/WCAG21/#contrast-minimum
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateCount(3, 3)]
        [int[]]$Foreground,

        [Parameter(Mandatory = $true)]
        [ValidateCount(3, 3)]
        [int[]]$Background
    )

    $fgLuminance = Get-RelativeLuminance -R $Foreground[0] -G $Foreground[1] -B $Foreground[2]
    $bgLuminance = Get-RelativeLuminance -R $Background[0] -G $Background[1] -B $Background[2]
    $ratio       = Get-ContrastRatio -Luminance1 $fgLuminance -Luminance2 $bgLuminance
    $ratioRounded = [Math]::Round($ratio, 2)

    [PSCustomObject]@{
        Foreground       = "rgb($($Foreground[0]),$($Foreground[1]),$($Foreground[2]))"
        Background       = "rgb($($Background[0]),$($Background[1]),$($Background[2]))"
        ContrastRatio    = $ratioRounded
        PassesAA         = $ratio -ge 4.5
        PassesAA_Large   = $ratio -ge 3.0
        PassesAAA        = $ratio -ge 7.0
        PassesAAA_Large  = $ratio -ge 4.5
    }
}

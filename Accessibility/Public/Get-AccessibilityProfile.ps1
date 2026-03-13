function Get-AccessibilityProfile {
    <#
    .SYNOPSIS
    Returns all currently active accessibility settings for the module.

    .DESCRIPTION
    Returns a structured object summarizing every accessibility setting currently
    active in the session: color blind profile, screen reader mode, and output
    rendering mode. Useful for inspecting the current state before exporting or
    sharing a configuration.

    .EXAMPLE
    Get-AccessibilityProfile

    Returns a PSCustomObject with ColorBlindProfile, ScreenReaderMode, and
    OutputRendering properties.

    .EXAMPLE
    (Get-AccessibilityProfile).ScreenReaderMode

    Returns $true if screen reader mode is active, $false otherwise.

    .NOTES
    https://www.w3.org/WAI/WCAG21/Understanding/
    #>
    [CmdletBinding()]
    param ()

    [PSCustomObject]@{
        ColorBlindProfile = $script:ActiveColorProfile
        ScreenReaderMode  = [bool]$script:ScreenReaderMode
        OutputRendering   = $PSStyle.OutputRendering.ToString()
    }
}

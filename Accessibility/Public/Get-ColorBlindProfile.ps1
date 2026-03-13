function Get-ColorBlindProfile {
    <#
    .SYNOPSIS
    Displays the currently active color blind profile and its color table.

    .DESCRIPTION
    Returns a structured object showing the active color blind profile name and the
    RGB color values assigned to each semantic terminal role (Error, Warning, Success,
    Info, Highlight, Accent, Text, Muted). Returns $null if no profile has been set
    in the current session.

    .EXAMPLE
    Get-ColorBlindProfile

    Returns the active color blind profile object, or $null if none is set.

    .EXAMPLE
    (Get-ColorBlindProfile).ProfileType

    Returns just the name of the active profile (e.g. 'Deuteranopia').

    .NOTES
    https://jfly.uni-koeln.de/color/
    #>
    [CmdletBinding()]
    param ()

    if (-not $script:ActiveColorProfile) {
        Write-Verbose "No color blind profile is currently active."
        return $null
    }

    $palette = Get-ColorBlindPaletteData -ProfileType $script:ActiveColorProfile

    [PSCustomObject]@{
        ProfileType = $script:ActiveColorProfile
        Colors      = $palette
    }
}

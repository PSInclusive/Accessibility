function Get-ColorBlindPalette {
    <#
    .SYNOPSIS
    Returns the color table for a named color blindness profile.

    .DESCRIPTION
    Returns a PSCustomObject containing the RGB values for each semantic color role
    (Error, Warning, Success, Info, Highlight, Accent, Text, Muted) in the specified
    color blindness profile. Useful for scripts and tools that need to programmatically
    select accessible colors without applying them to the terminal directly.

    .PARAMETER ProfileType
    The color blindness profile whose palette to retrieve.

    .EXAMPLE
    Get-ColorBlindPalette -ProfileType Deuteranopia

    Returns the full Deuteranopia color table as a structured object.

    .EXAMPLE
    (Get-ColorBlindPalette -ProfileType AccessibleDefault).Warning

    Returns the R, G, B values for the Warning color in the AccessibleDefault palette.

    .EXAMPLE
    'Deuteranopia','Protanopia','Tritanopia' | ForEach-Object { Get-ColorBlindPalette -ProfileType $_ }

    Returns the color tables for multiple profiles.

    .NOTES
    https://jfly.uni-koeln.de/color/
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, Position = 0)]
        [ValidateSet('Deuteranopia', 'Protanopia', 'Tritanopia', 'Achromatopsia', 'AccessibleDefault')]
        [string]$ProfileType
    )

    $palette = Get-ColorBlindPaletteData -ProfileType $ProfileType

    [PSCustomObject]@{
        ProfileType = $ProfileType
        Error       = [PSCustomObject]$palette.Error
        Warning     = [PSCustomObject]$palette.Warning
        Success     = [PSCustomObject]$palette.Success
        Info        = [PSCustomObject]$palette.Info
        Highlight   = [PSCustomObject]$palette.Highlight
        Accent      = [PSCustomObject]$palette.Accent
        Text        = [PSCustomObject]$palette.Text
        Muted       = [PSCustomObject]$palette.Muted
    }
}

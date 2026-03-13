function Export-AccessibilityProfile {
    <#
    .SYNOPSIS
    Exports the current accessibility settings to a JSON file.

    .DESCRIPTION
    Serializes all active accessibility settings (color blind profile, screen reader mode,
    output rendering) to a JSON file at the specified path. The file can later be restored
    using Import-AccessibilityProfile, making it easy to share configurations or persist
    them outside of $PROFILE.

    .PARAMETER Path
    The file path where the JSON settings file should be written.

    .EXAMPLE
    Export-AccessibilityProfile -Path "$HOME\accessibility-settings.json"

    Exports the current settings to a JSON file in the user's home directory.

    .EXAMPLE
    Set-ColorBlindProfile -ProfileType Deuteranopia
    Export-AccessibilityProfile -Path ".\my-profile.json"

    Applies a color profile then exports it to a local file.

    .NOTES
    https://www.w3.org/WAI/WCAG21/Understanding/
    #>
    [CmdletBinding(SupportsShouldProcess)]
    param (
        [Parameter(Mandatory = $true, Position = 0)]
        [string]$Path
    )

    $profile = Get-AccessibilityProfile

    if ($PSCmdlet.ShouldProcess($Path, "Export accessibility settings")) {
        $profile | ConvertTo-Json -Depth 5 | Set-Content -Path $Path -Encoding UTF8
        Write-Verbose "Accessibility settings exported to: $Path"
    }
}

function Import-AccessibilityProfile {
    <#
    .SYNOPSIS
    Loads and applies accessibility settings from a JSON file.

    .DESCRIPTION
    Reads a JSON settings file previously created by Export-AccessibilityProfile and
    applies the contained settings to the current session. Supported settings include
    color blind profile and screen reader mode. Unknown properties in the file are
    silently ignored for forward compatibility.

    .PARAMETER Path
    The path to the JSON settings file to import.

    .EXAMPLE
    Import-AccessibilityProfile -Path "$HOME\accessibility-settings.json"

    Loads and applies settings from the specified file.

    .EXAMPLE
    Import-AccessibilityProfile -Path ".\team-accessibility.json"

    Applies a shared team accessibility configuration from a local file.

    .NOTES
    https://www.w3.org/WAI/WCAG21/Understanding/
    #>
    [CmdletBinding(SupportsShouldProcess)]
    param (
        [Parameter(Mandatory = $true, Position = 0)]
        [string]$Path
    )

    if (-not (Test-Path $Path)) {
        Write-Error "Settings file not found: $Path"
        return
    }

    $settings = Get-Content -Path $Path -Raw | ConvertFrom-Json

    if ($PSCmdlet.ShouldProcess($Path, "Import and apply accessibility settings")) {
        if ($settings.ColorBlindProfile) {
            Set-ColorBlindProfile -ProfileType $settings.ColorBlindProfile
        }

        if ($settings.ScreenReaderMode -eq $true) {
            Enable-ScreenReaderMode
        } elseif ($settings.ScreenReaderMode -eq $false) {
            Disable-ScreenReaderMode
        }

        Write-Verbose "Accessibility settings imported from: $Path"
    }
}

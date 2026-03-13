function Set-ColorBlindProfile {
    <#
    .SYNOPSIS
    Applies a color blind-friendly color scheme to the current terminal session.

    .DESCRIPTION
    Remaps PowerShell's $PSStyle formatting colors to an accessible palette based on the
    specified color blindness type. All profiles use colors derived from the peer-reviewed
    Okabe-Ito palette, which is safe across all common colorblindness conditions.

    Use -Persist to automatically apply the profile in every new PowerShell session by
    appending the invocation to your $PROFILE file. Use Reset-ColorProfile to undo.

    Supported profiles:
      Deuteranopia    - Red-green deficiency (most common). Blue/orange/yellow contrast.
      Protanopia      - Red-weak. Red-range hues shifted to orange/yellow.
      Tritanopia      - Blue-yellow deficiency. Red/green contrast with high-contrast cyan.
      Achromatopsia   - Full colorblindness. High-contrast grayscale ladder (WCAG AAA).
      AccessibleDefault - Okabe-Ito baseline. Good starting point if unsure of type.

    .PARAMETER ProfileType
    The color blindness profile to apply.

    .PARAMETER Persist
    If specified, appends the Set-ColorBlindProfile call to $PROFILE so the color scheme
    is automatically restored in every new PowerShell session.

    .EXAMPLE
    Set-ColorBlindProfile -ProfileType Deuteranopia

    Applies the Deuteranopia-optimized color scheme to the current session.

    .EXAMPLE
    Set-ColorBlindProfile -ProfileType AccessibleDefault -Persist

    Applies the general accessible color scheme and saves it to $PROFILE so it applies
    automatically in future sessions.

    .EXAMPLE
    Set-ColorBlindProfile -ProfileType Achromatopsia -WhatIf

    Shows what colors would be changed without applying them.

    .NOTES
    Okabe-Ito palette: https://jfly.uni-koeln.de/color/
    WCAG contrast guidelines: https://www.w3.org/TR/WCAG21/#contrast-minimum
    #>
    [CmdletBinding(SupportsShouldProcess)]
    param (
        [Parameter(Mandatory = $true, Position = 0)]
        [ValidateSet('Deuteranopia', 'Protanopia', 'Tritanopia', 'Achromatopsia', 'AccessibleDefault')]
        [string]$ProfileType,

        [Parameter(Mandatory = $false)]
        [switch]$Persist
    )

    $palette = Get-ColorBlindPaletteData -ProfileType $ProfileType

    if ($PSCmdlet.ShouldProcess("terminal color scheme", "Apply $ProfileType profile")) {
        $PSStyle.Formatting.Error          = $PSStyle.Foreground.FromRgb($palette.Error.R,     $palette.Error.G,     $palette.Error.B)
        $PSStyle.Formatting.Warning        = $PSStyle.Foreground.FromRgb($palette.Warning.R,   $palette.Warning.G,   $palette.Warning.B)
        $PSStyle.Formatting.Verbose        = $PSStyle.Foreground.FromRgb($palette.Info.R,      $palette.Info.G,      $palette.Info.B)
        $PSStyle.Formatting.Debug          = $PSStyle.Foreground.FromRgb($palette.Muted.R,     $palette.Muted.G,     $palette.Muted.B)
        $PSStyle.Formatting.TableHeader    = $PSStyle.Foreground.FromRgb($palette.Accent.R,    $palette.Accent.G,    $palette.Accent.B)
        $PSStyle.Formatting.CustomTableRow = $PSStyle.Foreground.FromRgb($palette.Text.R,      $palette.Text.G,      $palette.Text.B)

        $script:ActiveColorProfile = $ProfileType

        Write-Verbose "Applied $ProfileType color profile to current session."

        if ($Persist) {
            $invocation = "Set-ColorBlindProfile -ProfileType $ProfileType"
            $profileDir = Split-Path -Path $PROFILE -Parent
            if (-not (Test-Path -LiteralPath $profileDir)) {
                New-Item -Path $profileDir -ItemType Directory -Force | Out-Null
            }

            $profileContent = if (Test-Path -LiteralPath $PROFILE) { Get-Content -LiteralPath $PROFILE } else { @() }
            if ($profileContent -notcontains $invocation) {
                Add-Content -LiteralPath $PROFILE -Value "`n$invocation"
                Write-Verbose "Saved $ProfileType profile to `$PROFILE: $PROFILE"
            }
            else {
                Write-Verbose "Profile `$PROFILE already contains invocation for $ProfileType; skipping persist."
            }
        }
    }
}

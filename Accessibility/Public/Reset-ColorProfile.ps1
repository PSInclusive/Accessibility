function Reset-ColorProfile {
    <#
    .SYNOPSIS
    Restores terminal formatting colors to PowerShell's built-in defaults.

    .DESCRIPTION
    Clears any color blind profile applied by Set-ColorBlindProfile by resetting
    $PSStyle.Formatting properties back to their default values. Also clears the
    active profile name tracked by the module.

    This does not remove any Set-ColorBlindProfile entry from $PROFILE. To stop a
    persisted profile from loading in future sessions, edit $PROFILE manually and
    remove the Set-ColorBlindProfile line.

    .EXAMPLE
    Reset-ColorProfile

    Resets all terminal formatting colors to PowerShell defaults.

    .NOTES
    https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_ansi_terminals
    #>
    [CmdletBinding(SupportsShouldProcess)]
    param ()

    if ($PSCmdlet.ShouldProcess("terminal color scheme", "Reset to PowerShell defaults")) {
        $PSStyle.Formatting.Error        = $PSStyle.Foreground.Red
        $PSStyle.Formatting.Warning      = $PSStyle.Foreground.Yellow
        $PSStyle.Formatting.Verbose      = $PSStyle.Foreground.Cyan
        $PSStyle.Formatting.Debug        = $PSStyle.Foreground.Yellow
        $PSStyle.Formatting.TableHeader  = "$($PSStyle.Bold)$($PSStyle.Foreground.White)"
        $PSStyle.Formatting.FormatAccent = "$($PSStyle.Italic)$($PSStyle.Foreground.BrightCyan)"
        $PSStyle.Formatting.ErrorAccent  = "$($PSStyle.Italic)$($PSStyle.Foreground.Cyan)"

        $script:ActiveColorProfile = $null

        Write-Verbose "Terminal colors reset to PowerShell defaults."
    }
}

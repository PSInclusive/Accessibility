function Disable-ScreenReaderMode {
    <#
    .SYNOPSIS
    Restores normal ANSI-formatted terminal output after screen reader mode.

    .DESCRIPTION
    Clears the screen reader mode flag set by Enable-ScreenReaderMode, allowing
    Accessibility module commands to resume producing colored and styled terminal
    output using ANSI escape sequences.

    .EXAMPLE
    Disable-ScreenReaderMode

    Deactivates screen reader mode and restores ANSI-formatted output.

    .EXAMPLE
    Enable-ScreenReaderMode
    ConvertTo-Bionic "Example text"
    Disable-ScreenReaderMode

    Temporarily uses screen reader mode for one operation, then restores normal output.

    .NOTES
    https://www.w3.org/WAI/WCAG21/Understanding/non-text-contrast
    #>
    [CmdletBinding()]
    param ()

    $script:ScreenReaderMode = $false

    if ($script:PreviousOutputRendering) {
        $PSStyle.OutputRendering = $script:PreviousOutputRendering
        Write-Verbose "Screen reader mode disabled. Previous output rendering restored."
    }
    else {
        # Fallback if no previous output rendering mode was saved.
        $PSStyle.OutputRendering = [System.Management.Automation.OutputRendering]::Host
        Write-Verbose "Screen reader mode disabled. Output rendering set to Host."
    }
}

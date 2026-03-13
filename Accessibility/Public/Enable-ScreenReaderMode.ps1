function Enable-ScreenReaderMode {
    <#
    .SYNOPSIS
    Optimizes terminal output for screen reader assistive technology.

    .DESCRIPTION
    Sets a module-wide flag that signals all Accessibility module commands to produce
    output that is compatible with screen readers: no ANSI color codes, no box-drawing
    characters, simplified structure, and plain descriptive text only.

    Use Disable-ScreenReaderMode to return to normal output mode.

    .EXAMPLE
    Enable-ScreenReaderMode

    Activates screen reader-friendly output mode for all Accessibility module commands.

    .EXAMPLE
    Enable-ScreenReaderMode
    ConvertTo-Bionic "The quick brown fox jumped over the lazy dog."

    Enables screen reader mode then runs a bionic conversion. Output will contain no
    ANSI bold codes, just the plain text result.

    .NOTES
    https://www.w3.org/WAI/WCAG21/Understanding/non-text-contrast
    #>
    [CmdletBinding()]
    param ()

    $script:ScreenReaderMode = $true

    if (-not (Get-Variable -Name PreviousOutputRendering -Scope Script -ErrorAction SilentlyContinue)) {
        $script:PreviousOutputRendering = $PSStyle.OutputRendering
    }

    $PSStyle.OutputRendering = [System.Management.Automation.OutputRendering]::PlainText

    Write-Verbose "Screen reader mode enabled. ANSI output suppressed."
}

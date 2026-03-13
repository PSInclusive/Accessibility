function ConvertTo-PlainText {
    <#
    .SYNOPSIS
    Strips all ANSI escape codes and PSStyle formatting from a string.

    .DESCRIPTION
    Removes ANSI/VT100 escape sequences (colors, bold, italic, etc.) from text,
    returning clean plain text. Useful for preparing terminal output for screen
    readers, plain-text logging, or piping to tools that do not handle escape codes.

    Supports pipeline input.

    .PARAMETER InputText
    The text string to strip of ANSI escape codes.

    .EXAMPLE
    ConvertTo-PlainText -InputText "$($PSStyle.Bold)Hello$($PSStyle.BoldOff) World"

    Returns 'Hello World' with no formatting.

    .EXAMPLE
    ConvertTo-Bionic "The quick brown fox" | ConvertTo-PlainText

    Converts text to bionic format then strips all escape sequences for screen reader use.

    .EXAMPLE
    Get-Content .\log.txt -Raw | ConvertTo-PlainText

    Strips ANSI escape codes from a log file that may contain colored output.

    .NOTES
    https://www.w3.org/WAI/WCAG21/Techniques/general/G166
    #>
    [CmdletBinding()]
    param (
        [Parameter(
            Mandatory = $true,
            ValueFromPipeline = $true,
            Position = 0
        )]
        [string]$InputText
    )

    process {
        # Matches ESC (0x1B) followed by [ and any sequence of parameter/intermediate bytes and a final byte
        $InputText -replace '\x1B\[[0-9;]*[mABCDEFGHJKSTfhilmnprsu]', ''
    }
}

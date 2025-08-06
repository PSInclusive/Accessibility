function ConvertTo-Bionic {
    <#
    .SYNOPSIS
    Convert text input to Bionic text format.

    .DESCRIPTION
    Helps some users with dyslexia or ADHD to read text by converting it to a Bionic text format.

    .PARAMETER InputFilePath
    Path to the input file containing text to be converted.

    .PARAMETER InputText
    Text to be converted to Bionic text format.

    .PARAMETER FixationLength
    The length of the fixation point for the Bionic text conversion. Default is 3.

    .EXAMPLE
    ConvertTo-Bionic -InputFilePath "C:\path\to\input.txt"

    Converts the text in the specified file to Bionic text format and saves it to a new file.

    .EXAMPLE
    ConvertTo-Bionic "Lorem ipsum dolor sit."

    Converts the provided text to Bionic text format and outputs it to the console.

    .EXAMPLE
    Get-Content .\README.md -Raw | ConvertTo-Bionic

    Converts the content of the README.md file to Bionic text format and outputs it to the console.

    .NOTES
    https://www.oxfordlearning.com/what-is-bionic-reading-and-why-should-you-use-it/
    #>
    [CmdletBinding()]
    param (
        [Parameter(
            Mandatory = $true,
            ParameterSetName = 'Text',
            ValueFromPipeline = $true,
            Position = 0
        )]
        [string]$InputText,
        [Parameter(Mandatory = $true, ParameterSetName = 'File')]
        [string]$InputFilePath,
        [int]$FixationLength = 3

    )
    begin {
        if ($PSBoundParameters.ContainsKey('InputFilePath')) {
            if (-not (Test-Path $InputFilePath)) {
                Write-Error "Input file does not exist: $InputFilePath"
                return
            }
            $text = Get-Content -Path $InputFilePath -Raw
        } elseif ($PSBoundParameters.ContainsKey('InputText')) {
            $text = $InputText
        }
        $result = ""
    }
    process {
        if ($_ -is [string]) {
            $text = $_
        }
        $prev = 0

        # Match words using regex
        $words = [regex]::Matches($text, '\p{L}(\p{L}|\p{Nd})*', [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)

        foreach ($match in $words) {
            $start = $match.Index
            $end = $start + $match.Value.Length - (Get-WordFixationLength -Word $match.Value -FixationSize ($FixationLength - 1))
            $result += $text.Substring($prev, $start - $prev)
            if ($start -ne $end) {
                $result += "$($PSStyle.Bold)$($text.Substring($start, $end - $start))$($PSStyle.BoldOff)"
            }
            $prev = $end
        }
    }
    end {
        return $result + $text.Substring($prev)
    }
}

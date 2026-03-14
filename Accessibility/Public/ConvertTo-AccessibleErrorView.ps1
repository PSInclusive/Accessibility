function ConvertTo-AccessibleErrorView {
    <#
    .SYNOPSIS
    Formats an ErrorRecord using the active accessible color palette.

    .DESCRIPTION
    This function follows the PowerShell ErrorView convention: when $ErrorView is set to
    'Accessible', PowerShell calls ConvertTo-AccessibleErrorView for every error displayed
    in the session.

    The formatter uses the current $PSStyle.Formatting colors — which are set by
    Set-ColorBlindProfile — to render the error message and metadata. This ensures the
    error display respects the active color profile rather than relying on the terminal
    defaults that may conflict with a user's color blindness profile.

    The error message is rendered using $PSStyle.Formatting.Error. Error metadata
    (CategoryInfo and FullyQualifiedErrorId) is rendered using $PSStyle.Formatting.ErrorAccent.

    .PARAMETER InputObject
    The ErrorRecord to format. PowerShell pipes this automatically when $ErrorView is 'Accessible'.

    .EXAMPLE
    $ErrorView = 'Accessible'
    1/0

    Enables the accessible error formatter, then triggers a divide-by-zero error to demonstrate
    the formatted output.

    .EXAMPLE
    Enable-AccessibleErrorView
    Get-Item 'C:\does-not-exist'

    Activates accessible error view via the helper cmdlet before triggering an error.

    .NOTES
    ErrorView convention: https://github.com/PoshCode/ErrorView
    PSStyle.FormattingData: https://learn.microsoft.com/en-us/dotnet/api/system.management.automation.psstyle.formattingdata?view=powershellsdk-7.4.0
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [System.Management.Automation.ErrorRecord]$InputObject
    )

    process {
        $errorStyle  = $PSStyle.Formatting.Error
        $accentStyle = $PSStyle.Formatting.ErrorAccent
        $reset       = $PSStyle.Reset

        $message  = $InputObject.Exception.Message
        $category = $InputObject.CategoryInfo.ToString()
        $fqeid    = $InputObject.FullyQualifiedErrorId

        "${errorStyle}${message}${reset}"
        "${accentStyle}    + CategoryInfo          : ${category}${reset}"
        "${accentStyle}    + FullyQualifiedErrorId : ${fqeid}${reset}"
    }
}

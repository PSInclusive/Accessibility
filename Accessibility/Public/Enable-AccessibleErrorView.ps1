function Enable-AccessibleErrorView {
    <#
    .SYNOPSIS
    Activates the accessible error view for the current session.

    .DESCRIPTION
    Sets $ErrorView to 'Accessible', which causes PowerShell to call
    ConvertTo-AccessibleErrorView for every error displayed in the session.

    The accessible error view renders errors using $PSStyle.Formatting.Error and
    $PSStyle.Formatting.ErrorAccent, ensuring the error display respects whatever
    color profile is currently active via Set-ColorBlindProfile.

    The previous value of $ErrorView is saved and can be restored with
    Disable-AccessibleErrorView.

    .EXAMPLE
    Enable-AccessibleErrorView
    1/0

    Activates the accessible error formatter, then triggers a divide-by-zero error
    to show the formatted output.

    .EXAMPLE
    Set-ColorBlindProfile -ProfileType Deuteranopia
    Enable-AccessibleErrorView

    Applies a color-blind-friendly palette and enables the matching error view in one step.

    .NOTES
    PSStyle.FormattingData: https://learn.microsoft.com/en-us/dotnet/api/system.management.automation.psstyle.formattingdata?view=powershellsdk-7.4.0
    ErrorView convention: https://github.com/PoshCode/ErrorView
    #>
    [CmdletBinding(SupportsShouldProcess)]
    param ()

    if ($PSCmdlet.ShouldProcess('$ErrorView', "Set to 'Accessible'")) {
        $script:PreviousErrorView = $global:ErrorView
        $global:ErrorView = 'Accessible'
        Write-Verbose "ErrorView set to 'Accessible'. Previous value: '$script:PreviousErrorView'"
    }
}

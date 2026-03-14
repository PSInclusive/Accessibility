function Disable-AccessibleErrorView {
    <#
    .SYNOPSIS
    Restores the previous $ErrorView after Enable-AccessibleErrorView was called.

    .DESCRIPTION
    Restores $ErrorView to the value that was active before Enable-AccessibleErrorView
    was called. If no previous value was saved (e.g. if Enable-AccessibleErrorView was
    never called), $ErrorView is restored to the PowerShell default 'ConciseView'.

    .EXAMPLE
    Disable-AccessibleErrorView

    Restores $ErrorView to the value it had before Enable-AccessibleErrorView was called.

    .NOTES
    PSStyle.FormattingData: https://learn.microsoft.com/en-us/dotnet/api/system.management.automation.psstyle.formattingdata?view=powershellsdk-7.4.0
    ErrorView convention: https://github.com/PoshCode/ErrorView
    #>
    [CmdletBinding(SupportsShouldProcess)]
    param ()

    $restoreValue = if ($null -ne $script:PreviousErrorView) { $script:PreviousErrorView } else { 'ConciseView' }

    if ($PSCmdlet.ShouldProcess('$ErrorView', "Restore to '$restoreValue'")) {
        $global:ErrorView = $restoreValue
        $script:PreviousErrorView = $null
        Write-Verbose "ErrorView restored to '$restoreValue'."
    }
}

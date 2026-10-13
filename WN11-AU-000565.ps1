<#
.SYNOPSIS
    This PowerShell script enables Failure auditing for the Other Logon/Logoff Events subcategory to record failed logon and logoff-related security events.

.NOTES
    Author          : Ashok Bashyal
    LinkedIn        : linkedin.com/in/ashok-bashyal-46a870356
    GitHub          : github.com/Ashok-Bashyal
    Date Created    : 2026-10-13
    Last Modified   : 2026-10-13
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-AU-000565

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN11-AU-000565.ps1 
#>

# Windows 11 STIG - WN11-AU-000565
# Enable Failure Auditing for Other Logon/Logoff Events

# Define the audit policy subcategory and setting
$auditSubcategory = "Other Logon/Logoff Events"
$auditSetting = "Failure"

# Enable Failure auditing for Other Logon/Logoff Events
auditpol /set /subcategory:"$auditSubcategory" /failure:enable

# Verify the audit policy configuration
$auditResult = auditpol /get /subcategory:"$auditSubcategory"
$auditExitCode = $LASTEXITCODE

# Output the current audit policy
Write-Host "`nCurrent Audit Policy Configuration:"
$auditResult

# Check if Failure auditing is enabled
$auditEnabled = $auditResult | Where-Object {
    $_ -match "Other Logon/Logoff Events\s+(Success and Failure|Failure)"
}

if ($auditExitCode -eq 0 -and $auditEnabled) {
    Write-Host "STIG Compliant: Failure auditing is enabled for '$auditSubcategory'." -ForegroundColor Green
}
else {
    Write-Host "STIG Non-Compliant: Failure auditing is not enabled for '$auditSubcategory'." -ForegroundColor Red
}

<#
.SYNOPSIS
    This PowerShell script enables Success auditing for the Credential Validation subcategory to record successful account logon authentication events.

.NOTES
    Author          : Ashok Bashyal
    LinkedIn        : linkedin.com/in/ashok-bashyal-46a870356
    GitHub          : github.com/Ashok-Bashyal
    Date Created    : 2026-10-11
    Last Modified   : 2026-10-11
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-AU-000010

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN11-AU-000010.ps1 
#>

# Windows 11 STIG - WN11-AU-000010
# Enable Success Auditing for Credential Validation

# Define the audit policy subcategory and setting
$auditSubcategory = "Credential Validation"
$auditSetting = "Success"

# Enable Success auditing for Credential Validation
auditpol /set /subcategory:"$auditSubcategory" /success:enable

# Verify the audit policy configuration
$auditResult = auditpol /get /subcategory:"$auditSubcategory"

# Output the current audit policy
Write-Host "`nCurrent Audit Policy Configuration:"
$auditResult

# Check if Success auditing is enabled
if ($LASTEXITCODE -eq 0 -and ($auditResult -match "Success")) {
    Write-Host "STIG Compliant: Success auditing is enabled for '$auditSubcategory'." -ForegroundColor Green
}
else {
    Write-Host "STIG Non-Compliant: Success auditing is not enabled for '$auditSubcategory'." -ForegroundColor Red
}

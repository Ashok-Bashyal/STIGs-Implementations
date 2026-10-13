<#
.SYNOPSIS
    This PowerShell script configures the Windows 11 account lockout threshold to 3 invalid logon attempts to reduce the risk of brute-force attacks.

.NOTES
    Author          : Ashok Bashyal
    LinkedIn        : linkedin.com/in/ashok-bashyal-46a870356
    GitHub          : github.com/Ashok-Bashyal
    Date Created    : 2026-10-12
    Last Modified   : 2026-10-12
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-AC-000010

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN11-AC-000010.ps1 
#>


# Windows 11 STIG - WN11-AC-000010
# Configure Account Lockout Threshold

# Define the required account lockout threshold
$lockoutThreshold = 3

# Configure the account lockout threshold
net accounts /lockoutthreshold:$lockoutThreshold

# Verify the account lockout configuration
$lockoutResult = net accounts

# Output the current account policy
Write-Host "`nCurrent Account Lockout Configuration:"
$lockoutResult

# Check if the threshold meets the STIG requirement
$thresholdLine = $lockoutResult | Where-Object {
    $_ -match "Lockout threshold"
}

if ($thresholdLine -match ":\s*(\d+)") {
    $currentThreshold = [int]$Matches[1]

    if ($currentThreshold -ge 1 -and $currentThreshold -le 3) {
        Write-Host "STIG Compliant: Account lockout threshold is set to $currentThreshold attempts." -ForegroundColor Green
    }
    else {
        Write-Host "STIG Non-Compliant: Account lockout threshold must be between 1 and 3 attempts." -ForegroundColor Red
    }
}
else {
    Write-Host "Unable to verify account lockout threshold." -ForegroundColor Yellow
}

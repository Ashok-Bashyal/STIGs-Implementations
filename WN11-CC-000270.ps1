<#
.SYNOPSIS
    This PowerShell script disables third-party suggestions in Windows Spotlight by setting the DisableThirdPartySuggestions registry value to 1.

.NOTES
    Author          : Ashok Bashyal
    LinkedIn        : linkedin.com/in/ashok-bashyal-46a870356
    GitHub          : github.com/Ashok-Bashyal
    Date Created    : 2026-10-13
    Last Modified   : 2026-10-13
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000270

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN11-CC-000270.ps1 
#>

# Windows 11 STIG - WN11-CC-000270
# Disable Password Saving for Remote Desktop Connection

# Define the registry path and value
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services"
$valueName = "DisablePasswordSaving"
$valueData = 1

# Check if the registry path exists, if not create it
if (-not (Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force | Out-Null
}

# Set the DisablePasswordSaving value
New-ItemProperty -Path $registryPath -Name $valueName -Value $valueData -PropertyType DWord -Force -ErrorAction Stop | Out-Null

# Verify the registry value
$currentValue = (Get-ItemProperty -Path $registryPath -Name $valueName -ErrorAction Stop).DisablePasswordSaving

# Output success message
if ($currentValue -eq 1) {
    Write-Host "STIG Compliant: Registry value '$valueName' set to '$currentValue' at '$registryPath'." -ForegroundColor Green
}
else {
    Write-Host "STIG Non-Compliant: Registry value does not meet the requirement." -ForegroundColor Red
}

<#
.SYNOPSIS
    This PowerShell script disables Basic authentication for the Windows Remote Management (WinRM) service by setting the AllowBasic registry value to 0.

.NOTES
    Author          : Ashok Bashyal
    LinkedIn        : linkedin.com/in/ashok-bashyal-46a870356
    GitHub          : github.com/Ashok-Bashyal
    Date Created    : 2026-10-12
    Last Modified   : 2026-10-12
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000345

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN11-CC-000345.ps1 
#>

# Windows 11 STIG - WN11-CC-000345
# Disable WinRM Basic Authentication

# Define the registry path and value
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WinRM\Service"
$valueName = "AllowBasic"
$valueData = 0

# Check if the registry path exists, if not create it
if (-not (Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force | Out-Null
}

# Set the AllowBasic value
New-ItemProperty -Path $registryPath -Name $valueName -Value $valueData -PropertyType DWord -Force | Out-Null

# Verify the registry value
$currentValue = (Get-ItemProperty -Path $registryPath -Name $valueName).AllowBasic

# Output success message
if ($currentValue -eq 0) {
    Write-Host "STIG Compliant: Registry value '$valueName' set to '$currentValue' at '$registryPath'." -ForegroundColor Green
}
else {
    Write-Host "STIG Non-Compliant: Registry value does not meet the requirement." -ForegroundColor Red
}

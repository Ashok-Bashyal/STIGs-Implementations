<#
.SYNOPSIS
    This PowerShell script ensures that the maximum size of the Windows Application event log is at least 32768 KB (32 MB).

.NOTES
    Author          : Ashok Bashyal
    LinkedIn        : linkedin.com/in/ashok-bashyal-46a870356
    GitHub          : github.com/Ashok-Bashyal
    Date Created    : 2026-10-11
    Last Modified   : 2026-10-11
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-AU-000500

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN11-AU-000500.ps1 
#>

# Define the registry path and value
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\Application"
$valueName = "MaxSize"
$valueData = 32768  # 0x00008000 in decimal

# Check if the registry path exists, if not create it
if (-not (Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force | Out-Null
}

# Set the MaxSize value
New-ItemProperty -Path $registryPath -Name $valueName -Value $valueData -PropertyType DWord -Force | Out-Null

# Verify the registry value
$currentValue = (Get-ItemProperty -Path $registryPath -Name $valueName).MaxSize

# Output success message
if ($currentValue -ge 32768) {
    Write-Host "STIG Compliant: Registry value '$valueName' set to '$currentValue' at '$registryPath'." -ForegroundColor Green
}
else {
    Write-Host "STIG Non-Compliant: Registry value does not meet the requirement." -ForegroundColor Red
}

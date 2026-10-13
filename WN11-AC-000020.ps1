<#
.SYNOPSIS
    This PowerShell script configures Windows 11 to remember the previous 24 passwords to prevent password reuse and strengthen account security.

.NOTES
    Author          : Ashok Bashyal
    LinkedIn        : linkedin.com/in/ashok-bashyal-46a870356
    GitHub          : github.com/Ashok-Bashyal
    Date Created    : 2026-10-12
    Last Modified   : 2026-10-12
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-AC-000020

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN11-AC-000020.ps1 
#>


# Windows 11 STIG - WN11-AC-000020
# Configure Password History to Remember 24 Passwords

# Define the required password history value
$passwordHistory = 24

# Export the current local security policy
$securityFile = Join-Path $env:TEMP "STIG_PasswordHistory.inf"
$securityDatabase = Join-Path $env:TEMP "STIG_PasswordHistory.sdb"

try {
    secedit /export /cfg $securityFile /areas SECURITYPOLICY /quiet

    if ($LASTEXITCODE -ne 0) {
        throw "Failed to export the security policy."
    }

    # Read the current security configuration
    $securityConfig = Get-Content -Path $securityFile

    # Update the PasswordHistorySize value
    $securityConfig = $securityConfig -replace `
        'PasswordHistorySize\s*=\s*\d+', `
        "PasswordHistorySize = $passwordHistory"

    # Save the modified security configuration
    Set-Content -Path $securityFile -Value $securityConfig -Encoding Unicode

    # Apply the updated password policy
    secedit /configure /db $securityDatabase /cfg $securityFile /areas SECURITYPOLICY /quiet

    if ($LASTEXITCODE -ne 0) {
        throw "Failed to apply the password policy."
    }

    # Export the policy again to verify the configuration
    secedit /export /cfg $securityFile /areas SECURITYPOLICY /quiet

    if ($LASTEXITCODE -ne 0) {
        throw "Failed to verify the password policy."
    }

    # Verify the password history setting
    $currentSetting = Get-Content -Path $securityFile |
        Select-String '^\s*PasswordHistorySize\s*=\s*(\d+)'

    if ($currentSetting) {
        $currentValue = [int]$currentSetting.Matches[0].Groups[1].Value

        if ($currentValue -ge 24) {
            Write-Host "STIG Compliant: Password history is set to $currentValue passwords remembered." -ForegroundColor Green
        }
        else {
            Write-Host "STIG Non-Compliant: Password history must be at least 24." -ForegroundColor Red
        }
    }
    else {
        Write-Host "Unable to verify password history configuration." -ForegroundColor Yellow
    }
}
catch {
    Write-Host "STIG configuration failed: $_" -ForegroundColor Red
}
finally {
    Remove-Item -Path $securityFile, $securityDatabase -Force -ErrorAction SilentlyContinue
}

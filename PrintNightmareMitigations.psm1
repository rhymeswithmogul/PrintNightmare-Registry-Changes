Function Test-PrintNightmareMitigation {
    [CmdletBinding()]
    [OutputType([Boolean])]
    Param()

    $RegKey    = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Printers\PointAndPrint'
    $RegValues = Get-ItemProperty "$RegKey" -ErrorAction Ignore
    $Result    = $true

    If ($RegValues.NoWarningNoElevationOnInstall -eq 0) {
        Write-Output 'GOOD: User Account Control is required when creating new Point and Print connections.'
    }
    Else {
        Write-Error 'User Account Control is not required when creating new Point and Print connections.  Run Set-PrintNightmareMitigation to correct this.'
        $Result = $false
    }

    If ($RegValues -and $RegValues.UpdatePromptSettings -eq 0) {
        Write-Output 'GOOD: User Account Control is required when updating Point and Print connections.'
    }
    Else {
        Write-Error 'User Account Control is not required when updating Point and Print connections.  Run Set-PrintNightmareMitigation to correct this.'
        $Result = $false
    }

    If ($RegValues -and $RegValues.RestrictDriverInstallationToAdministrators -eq 1) {
        Write-Output 'GOOD: Only administrators may install print drivers.'
    }
    Else {
        Write-Warning 'Non-administrators may install print drivers.  Run Set-PrintNightmareMitigation -RestrictDriverInstallationToAdministrators to correct this, if desired.  (This is not a requirement for full PrintNightmare mitigation.)'
    }

    Return $Result
}

Function Set-PrintNightmareMitigation {
    #Require -RunAsAdministrator
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='High')]
    [OutputType([Void])]
    Param(
        [Switch] $RestrictDriverInstallationToAdministrators
    )

    If ($PSCmdlet.ShouldProcess($env:ComputerName, 'Apply registry changes needed to properly mitigate PrintNightmare')) {
        #.region Create registry key if needed
        $RegKey = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Printers\PointAndPrint'
        
        If (Test-Path -Path $RegKey -PathType Container) {
            Write-Verbose "The path $RegKey exists already."
        }
        Else {
            Write-Verbose "Creating the path $RegKey"    
            New-Item -ItemType Directory -Path "$RegKey" -Force -ErrorAction Stop
        }
        #.endregion

        # Fetch all of the properties we need.
        $RegValues = Get-ItemProperty "$RegKey" -ErrorAction Ignore
        
        #.region Set NoWarningNoElevationOnInstall
        #
        # By default, there may be no User Account Control prompt when installing printer drivers.
        # However, "[y]ou can configure Windows [7 and later] clients so that security warnings
        # and elevated command prompts do not appear when users Point and Print[.]"
        #
        # N.B.: patches for Windows 7 and Windows Server 2008 R2 require an ESU subscription.
        # Simply changing this registry value without the patch will have little mitigatory effect,
        # if any.
        #
        If ($RegValues.NoWarningNoElevationOnInstall -eq 0) {
            Write-Output 'NoWarningNoElevationOnInstall is already set properly.'
        }
        ElseIf (Test-Path -Path "$RegValues\NoWarningNoElevationOnInstall" -PathType Leaf) {
            Write-Verbose 'NoWarningNoElevationOnInstall is set improperly.'
            Set-ItemProperty -Path $RegKey -Name 'NoWarningNoElevationOnInstall' -Value 0 | Out-Null
            Write-Output 'NoWarningNoElevationOnInstall is now set properly.  Changes take effect immediately.'
        }
        Else {
            Write-Verbose 'NoWarningNoElevationOnInstall is not set.'
            New-ItemProperty -Path $RegKey -Name 'NoWarningNoElevationOnInstall' -Value 0 -Type DWORD | Out-Null
            Write-Output 'NoWarningNoElevationOnInstall is now set properly.  Changes take effect immediately.'
        }
        #.endregion

        #.region UpdatePromptSettings
        #
        # By default, there may be no User Account Control prompt when installing printer drivers.
        # However, "[y]ou can configure Windows [7 and later] clients so that security warnings
        # and elevated command prompts do not appear when [...] printer connection drivers need
        # to be updated."
        #
        # N.B.: patches for Windows 7 and Windows Server 2008 R2 require an ESU subscription.
        # Simply changing this registry value without the patch will have little mitigatory effect,
        # if any.
        #
        If ($RegValues.UpdatePromptSettings -eq 0) {
            Write-Output 'UpdatePromptSettings is already set properly.'
        }
        ElseIf (Test-Path -Path "$RegValues\UpdatePromptSettings" -PathType Leaf) {
            Write-Verbose 'UpdatePromptSettings is set improperly.'
            Set-ItemProperty -Path $RegKey -Name 'UpdatePromptSettings' -Value 0 | Out-Null
            Write-Output  'UpdatePromptSettings is now set properly.  Changes take effect immediately.'
        }
        Else {
            Write-Verbose 'UpdatePromptSettings is not set.'
            New-ItemProperty -Path $RegKey -Name 'UpdatePromptSettings' -Value 0 -Type DWORD | Out-Null
            Write-Output  'UpdatePromptSettings is now set properly.  Changes take effect immediately.'
        }
        #.endregion

        #.region RestrictDriverInstallationToAdministrators
        #
        # This Point and Print Restriction is not required to mitigate PrintNightmare, but Microsoft
        # did decide to point it out in their support article:
        #
        # "Optionally, to override all Point and Print Restrictions Group policy settings and ensure
        # that only administrators can install printer drivers on a print server, configure the
        # RestrictDriverInstallationToAdministrators registry value".
        #
        # No restart is necessary.
        # 
        # [Source: https://support.microsoft.com/en-us/topic/kb5005010-restricting-installation-of-new-printer-drivers-after-applying-the-july-6-2021-updates-31b91c02-05bc-4ada-a7ea-183b129578a7]
        
        If ($RestrictDriverInstallationToAdministrators) {
            If ($RegValues.RestrictDriverInstallationToAdministrators -eq 1) {
                Write-Output 'RestrictDriverInstallationToAdministrators is already set accordingly.'
            }
            ElseIf (Test-Path -Path "$RegValues\RestrictDriverInstallationToAdministrators" -PathType Leaf) {
                Write-Verbose 'RestrictDriverInstallationToAdministrators is not set to restrict.'
                Set-ItemProperty -Path $RegKey -Name 'RestrictDriverInstallationToAdministrators' -Value 1 | Out-Null
                Write-Output  'RestrictDriverInstallationToAdministrators is now set accordingly.  Changes take effect immediately.'
            }
            Else {
                Write-Verbose 'RestrictDriverInstallationToAdministrators is not defined.'
                New-ItemProperty -Path $RegKey -Name 'RestrictDriverInstallationToAdministrators' -Value 1 -Type DWORD | Out-Null
                Write-Output  'RestrictDriverInstallationToAdministrators is now set accordingly.  Changes take effect immediately.'
            }
        }
        Else {
            Write-Verbose 'Not setting RestrictDriverInstallationToAdministrators, at user request.'
        }
        #.endregion
    }
}

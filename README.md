# PrintNightmare Mitigations

Make sure your computer has the proper mitigations against PrintNightmare by using this PowerShell module.  [If you have the correct updates installed](https://msrc.microsoft.com/update-guide/en-US/vulnerability/CVE-2021-34527), you will need to add or edit registry settings for full protection.  This module will help.

## How to install this
Most users should grab it from PowerShell Gallery:
```powershell
Install-Module PrintNightmareMitigations
```

You may also download and install this manually.

## How to run this
Run `Set-PrintNightmareMitigations` to patch this computer.  Changes do not require a reboot.  The optional parameter, `-RestrictDriverInstallationToAdministrators`, provides optional extra protection.
```powershell
Set-PrintNightmareMitigations [-RestrictDriverInstallationToAdministrators]
```

To see if this computer has been patched, run:
```powershell
Test-PrintNightmareMitigations
```

## Use Group Policy if possible
While this module can test if the correct <abbr title="Group Policy Objects">GPO's</abbr> are being applied, you should use Group Policy in a domain environment.  That will make your life easier.  This module is better suited for standalone or workgroup computers.
0
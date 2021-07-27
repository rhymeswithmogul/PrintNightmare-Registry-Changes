# PrintNightmareMitigations
## about_PrintNightmareMitigations

# SHORT DESCRIPTION
Tests or applies PrintNightmare mitigations.

# LONG DESCRIPTION

This PowerShell module will test or apply PrintNightmare mitigations to the
current computer.

## Required Updates
In order for these mitigations to be effective, your computer must have one
of the following updates, or any later cumulative update:

- Windows 10 (2004+):      KB5004945
- Windows 10 (1909):       KB5004946
- Windows 10 (1809):       KB5004947
- Windows 10 (1607):       KB5004948
- Windows 10 (1507):       KB5004950
- Windows 8.1:             KB5004954 (rollup) or KB5004958 (security-only)
- Windows 7:               KB5004953 (rollup) or KB5004951 (security-only)*

- Windows Server 2019:     KB5004947
- Windows Server 2016:     KB5004948
- Windows Server 2012 R2:  KB5004954 (rollup) or KB5004958 (security-only)
- Windows Server 2012:     KB5004956 (rollup) or KB5004960 (security-only)
- Windows Server 2008 R2:  KB5004953 (rollup) or KB5004951 (security-only)*
- Windows Server 2008:     KB5004955 (rollup) or KB5004959 (security-only)*

\* Note that updates for Windows 7 and the Windows Server 2008 family require
a valid ESU license.

# EXAMPLES
## Checking Mitigations
PS C:\> Test-PrintNightmareMitigation

This example will determine whether or not the system is hardened to resist
PrintNightmare by checking the existence and values of the two required and
one optional registry values.

## Applying Required Mitigations
PS C:\> Set-PrintNightmareMitigation

This example will harden this system against PrintNightmare by setting both
of the required registry entries.  However, non-administrators may continue
to install printer drivers.

## Applying All Mitigations
PS C:\> Set-PrintNightmareMitigation -RestrictDriverInstallationToAdministrators

This example will harden this system against PrintNightmare by setting both
of the required registry entries.  In addition, non-administrators will now
be blocked from installing printer drivers.

# NOTE
As it writes to the registry, the cmdlet Set-PrintNightmareMitigation must
be run as an administrator.

# TROUBLESHOOTING NOTE
## Expected Outcome
Changing these registry values will result in a User Account Control prompt
when adding, changing, or receiving an update for Point and Print settings.

In addition, if you restrict printer driver installation to non-admins, the
obvious will happen.

## Goodbye, SQL Server 2005
On Windows 7, Windows Server 2008, and Windows Server 2008 R2, installing a
required update -- or a later update -- may cause connections to SQL Server
2005 to fail with error 40.   This is because of security hardening changes
introduced in this update, and is not related to any registry changes which
you or this module might make to your system.  Microsoft's resolution is to
upgrade to a supported version of SQL Server.  (Sorry.)
 
## ESU Required for Out-of-Support Platforms
The PrintNightmare patches for Windows 7, Windows Server 2008, and related
operating systems require a valid Extended Servicing Updates subscription.
If you have not installed a license key for ESU, this update will fail to
install.

# SEE ALSO
Test-PrintNightmareMitigations
Set-PrintNightmareMitigations
[https://msrc.microsoft.com/update-guide/en-US/vulnerability/CVE-2021-34527](Windows Print Spooler Remote Code Execution Vulnerability)

# KEYWORDS
PrintNightmare
CVE-2021-34527
Print Spooler
spoolsv.exe

---
external help file: PrintNightmareMitigations-help.xml
Module Name: PrintNightmareMitigations
online version: https://github.com/rhymeswithmogul/PrintNightmare-Registry-Changes/blob/main/man/en-US/Set-PrintNightmareMitigation.md
schema: 2.0.0
---

# Set-PrintNightmareMitigation

## SYNOPSIS
Applies PrintNightmare mitigations to this system.

## SYNTAX

```
Set-PrintNightmareMitigation [-RestrictDriverInstallationToAdministrators] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
This cmdlet will apply the PrintNightmare mitigations to this computer.  All Point and Print adds, changes, and updates will require confirmation with User Account Control.  In addition, you may further harden the system by disallowing standard users from installing printer drivers.

## EXAMPLES

### Example 1
```powershell
PS C:\> Set-PrintNightmareMitigations
```

This command will cause the system to require User Account Control elevation and warnings for all Point and Print additions, connections, changes, and updates.  However, non-administrators can still install printer drivers.

### Example 2
```powershell
PS C:\> Set-PrintNightmareMitigations -RestrictDriverInstallationToAdministrators
```

This command will cause the system to require User Account Control elevation and warnings for all Point and Print additions, connections, changes, and updates.  In addition, the system is further hardened; non-administrators can no longer install printer drivers.

## PARAMETERS

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RestrictDriverInstallationToAdministrators
While not required to mitigate PrintNightmare, the system can be further hardened by rejecting all driver installations and updates from non-administrators.  Specify this switch, and only administrators will be able to install printer drivers.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

This cmdlet does not accept pipeline input.

## OUTPUTS

### None

This cmdlet does not generate pipeline output.  All output is to the console.

## NOTES
As this writes to the registry, you must run this cmdlet as an administrator.  Changes take effect immediately and do not require a reboot.

While you may run this cmdlet to protect a single system against PrintNightmare, it is recommended to use Group Policy in a domain environment.

There is no cmdlet to undo these changes.  You must edit the registry manually.

## RELATED LINKS
[about_PrintNightmareMitigations]()
[Test-PrintNightmareMitigation]()

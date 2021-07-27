---
external help file: PrintNightmareMitigations-help.xml
Module Name: PrintNightmareMitigations
online version: https://github.com/rhymeswithmogul/PrintNightmare-Registry-Changes/blob/main/man/en-US/Test-PrintNightmareMitigation.md
schema: 2.0.0
---

# Test-PrintNightmareMitigation

## SYNOPSIS
Checks for PrintNightmare mitigations.

## SYNTAX

```
Test-PrintNightmareMitigation [<CommonParameters>]
```

## DESCRIPTION
This cmdlet will determine what PrintNightmare mitigations are presently enabled on this system, if any.

## EXAMPLES

### Example 1
```powershell
PS C:\> Test-PrintNightmareMitigations
```

This command will check the current system to see which PrintNightmare recommended mitigations are in place and presently enabled.

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

This cmdlet does not accept pipeline input.

## OUTPUTS

### System.Boolean

True if this system is protected against PrintNightmare;  false otherwise.

## NOTES
This cmdlet does not check to see if the appropriate updates are installed.  Windows updates are required for these mitigations to be effective.  For more information, read about_PrintNightmareMitigations.

## RELATED LINKS
[about_PrintNightmareMitigations]()
[Set-PrintNightmareMitigation]()

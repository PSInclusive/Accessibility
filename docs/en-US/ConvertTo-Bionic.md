---
external help file: Accessibility-help.xml
Module Name: Accessibility
online version:
schema: 2.0.0
---

# ConvertTo-Bionic

## SYNOPSIS
Convert text input to Bionic text format.

## SYNTAX

### Text
```
ConvertTo-Bionic [-InputText] <String> [-FixationLength <Int32>] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

### File
```
ConvertTo-Bionic -InputFilePath <String> [-FixationLength <Int32>] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
Helps some users with dyslexia or ADHD to read text by converting it to a Bionic text format.

## EXAMPLES

### EXAMPLE 1
```
ConvertTo-Bionic -InputFilePath "C:\path\to\input.txt"
```

Converts the text in the specified file to Bionic text format and saves it to a new file.

### EXAMPLE 2
```
ConvertTo-Bionic "Lorem ipsum dolor sit."
```

Converts the provided text to Bionic text format and outputs it to the console.

### EXAMPLE 3
```
Get-Content .\README.md -Raw | ConvertTo-Bionic
```

Converts the content of the README.md file to Bionic text format and outputs it to the console.

## PARAMETERS

### -InputText
Text to be converted to Bionic text format.

```yaml
Type: String
Parameter Sets: Text
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -InputFilePath
Path to the input file containing text to be converted.

```yaml
Type: String
Parameter Sets: File
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FixationLength
The length of the fixation point for the Bionic text conversion.
Default is 3.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 3
Accept pipeline input: False
Accept wildcard characters: False
```

### -ProgressAction
{{ Fill ProgressAction Description }}

```yaml
Type: ActionPreference
Parameter Sets: (All)
Aliases: proga

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
https://www.oxfordlearning.com/what-is-bionic-reading-and-why-should-you-use-it/

## RELATED LINKS

# Accessibility

A PowerShell module that enhances terminal accessibility for users with colorblindness, dyslexia, screen reader needs, and other assistive tech requirements.

## Overview

The **Accessibility** module provides a collection of PowerShell commands designed to make the terminal more usable for people with a range of accessibility needs:

- **Colorblindness support** – Apply scientifically-validated, peer-reviewed Okabe-Ito color palettes tuned for Deuteranopia, Protanopia, Tritanopia, Achromatopsia, or a general accessible default.
- **Dyslexia / ADHD support** – Convert text to Bionic reading format, which emphasizes the first letters of each word to reduce cognitive load.
- **Screen reader support** – Toggle a module-wide screen reader mode that strips ANSI escape codes and produces plain, descriptive output compatible with assistive technology.
- **Profile management** – Export and import accessibility settings as JSON files so you can share configurations across machines or with teammates.
- **WCAG compliance checking** – Validate that foreground/background color combinations meet WCAG 2.1 AA or AAA contrast requirements.

## Installation

Install the module from the PowerShell Gallery:

```powershell
Install-Module -Name Accessibility
```

Or import it directly from a local clone:

```powershell
Import-Module ./Accessibility/Accessibility.psd1 -Force
```

## Available Commands

| Command | Description |
|---|---|
| `ConvertTo-Bionic` | Converts text to Bionic reading format (bold fixation on first letters). |
| `ConvertTo-PlainText` | Strips ANSI/VT100 color and style escape codes from a string. |
| `Enable-ScreenReaderMode` | Switches all module output to plain text optimized for screen readers. |
| `Disable-ScreenReaderMode` | Restores normal ANSI-formatted output. |
| `Get-AccessibilityProfile` | Returns all currently active accessibility settings. |
| `Set-ColorBlindProfile` | Applies an accessible color palette to the current terminal session. |
| `Reset-ColorProfile` | Restores terminal colors to PowerShell's built-in defaults. |
| `Get-ColorBlindProfile` | Returns the active color blind profile and its color table. |
| `Get-ColorBlindPalette` | Returns the color table for a named color blindness profile. |
| `Export-AccessibilityProfile` | Exports current accessibility settings to a JSON file. |
| `Import-AccessibilityProfile` | Loads and applies accessibility settings from a JSON file. |
| `Test-ColorContrast` | Calculates WCAG contrast ratio between two colors and checks compliance. |

## Examples

### Apply a color blind-friendly palette

```powershell
# Apply a Deuteranopia-friendly color scheme
Set-ColorBlindProfile -ProfileType Deuteranopia

# Persist the profile so it loads automatically in every new session
Set-ColorBlindProfile -ProfileType AccessibleDefault -Persist

# Preview what would change without actually applying it
Set-ColorBlindProfile -ProfileType Achromatopsia -WhatIf
```

Available profile types: `Deuteranopia`, `Protanopia`, `Tritanopia`, `Achromatopsia`, `AccessibleDefault`.

### Convert text to Bionic reading format

```powershell
# Convert a string directly
ConvertTo-Bionic "The quick brown fox jumped over the lazy dog."

# Pipe file content through Bionic conversion
Get-Content .\README.md -Raw | ConvertTo-Bionic

# Convert a file and control fixation length
ConvertTo-Bionic -InputFilePath "C:\path\to\document.txt" -FixationLength 4
```

### Enable screen reader mode

```powershell
# Switch to plain-text output compatible with assistive technology
Enable-ScreenReaderMode

ConvertTo-Bionic "Example sentence."

# Restore normal ANSI-formatted output
Disable-ScreenReaderMode
```

### Export and share your accessibility settings

```powershell
# Save current settings to a file
Set-ColorBlindProfile -ProfileType Deuteranopia
Export-AccessibilityProfile -Path "$HOME\my-accessibility.json"

# Load settings on another machine or in another session
Import-AccessibilityProfile -Path "$HOME\my-accessibility.json"
```

### Check WCAG color contrast compliance

```powershell
# Perfect black-on-white (21:1 ratio)
Test-ColorContrast -Foreground 0,0,0 -Background 255,255,255

# Orange text on white – check if it passes WCAG AA
Test-ColorContrast -Foreground 213,94,0 -Background 255,255,255
```

### View or reset the current accessibility state

```powershell
# See all active settings at once
Get-AccessibilityProfile

# Check just the screen reader mode flag
(Get-AccessibilityProfile).ScreenReaderMode

# Restore default terminal colors
Reset-ColorProfile
```


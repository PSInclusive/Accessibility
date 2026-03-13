# Change Log

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/)
and this project adheres to [Semantic Versioning](http://semver.org/).

## [0.2.0] 2026-03-13

### Added

- Added comprehensive color blind accessibility command suite with 11 new
  commands covering Deuteranopia, Protanopia, Tritanopia, Achromatopsia,
  and AccessibleDefault profiles
- Added `Set-ColorBlindProfile` for applying Okabe-Ito color schemes with
  -Persist flag for session persistence
- Added `Get-ColorBlindProfile` to retrieve active profile and color table
- Added `Reset-ColorProfile` to restore PSStyle formatting colors to defaults
- Added `ConvertTo-PlainText` to strip ANSI escape codes for screen reader
  preparation
- Added `Enable-ScreenReaderMode` and `Disable-ScreenReaderMode` for
  screen reader compatibility
- Added `Test-ColorContrast` for WCAG 2.1 contrast ratio analysis with
  AA/AAA compliance reporting
- Added `Get-ColorBlindPalette` to retrieve full color table for profiles
- Added `Get-AccessibilityProfile` for accessibility settings snapshot
- Added `Export-AccessibilityProfile` and `Import-AccessibilityProfile`
  for JSON serialization
- Added private helpers: `Get-ColorBlindPaletteData`, `Get-RelativeLuminance`,
  and `Get-ContrastRatio` for WCAG compliance

### Changed

- Updated README with comprehensive Overview, Installation, Commands, and
  Examples sections

### Fixed

- Fixed Pester requirement version to 5.7.1

## [0.1.0] Initial

### Added

- Added new function ConvertTo-Bionic.

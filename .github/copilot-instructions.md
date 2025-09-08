# Accessibility PowerShell Module

A PowerShell module that enhances terminal accessibility for users with colorblindness, dyslexia, screen reader needs, and other assistive tech requirements. The main feature is the `ConvertTo-Bionic` function that converts text to Bionic reading format to help users with dyslexia or ADHD.

Always reference these instructions first and fallback to search or bash commands only when you encounter unexpected information that does not match the info here.

## Working Effectively

### Prerequisites and Setup
- PowerShell 7.4.11 is available in the environment
- **CRITICAL**: PowerShell Gallery registration fails in this environment - documented workaround required
- Module works directly without PowerShell Gallery dependencies

### Quick Start - Always Working Commands
```bash
# Import the module directly (works immediately)
pwsh -c "Import-Module ./Accessibility/Accessibility.psd1 -Force"

# Test basic functionality (~0.4 seconds)
pwsh -c "Import-Module ./Accessibility/Accessibility.psd1 -Force; 'Hello world test' | ConvertTo-Bionic"

# Run linting (~1 second) - ALWAYS run before committing
pwsh -c "Import-Module PSScriptAnalyzer; Invoke-ScriptAnalyzer -Path ./Accessibility/ -Recurse"

# Create test structure and run tests (~2.3 seconds total)
mkdir -p Output/Accessibility/0.1.0
cp -r Accessibility/* Output/Accessibility/0.1.0/
pwsh -c "$env:BHProjectPath = '$PWD'; $env:BHProjectName = 'Accessibility'; $env:BHPSModuleManifest = '$PWD/Accessibility/Accessibility.psd1'; Import-Module Pester; Invoke-Pester tests/ -Output Detailed"
```

### Build and Test Process

#### Intended Build Process (Dependencies Required)
The repository is designed to use psake with PowerShellBuild:
```bash
# Bootstrap (FAILS in current environment due to PowerShell Gallery issues)
pwsh -File build.ps1 -Bootstrap  # Expected: ~60 seconds with working PSGallery

# Build (would work with dependencies)
pwsh -File build.ps1  # Expected: ~30 seconds
```

#### Working Alternative Build Process
Since PowerShell Gallery is not available, use manual setup:
```bash
# 1. Create output structure for tests
mkdir -p Output/Accessibility/0.1.0
cp -r Accessibility/* Output/Accessibility/0.1.0/

# 2. Set environment variables and run tests
export BHProjectPath="$PWD"
export BHProjectName="Accessibility" 
export BHPSModuleManifest="$PWD/Accessibility/Accessibility.psd1"

# 3. Run tests (takes ~2.3 seconds - NEVER CANCEL, set timeout to 300+ seconds)
pwsh -c "Import-Module Pester; Invoke-Pester tests/ -Output Detailed"
```

#### Linting and Code Quality
```bash
# Run PSScriptAnalyzer (takes ~1 second)
pwsh -c "Import-Module PSScriptAnalyzer; Invoke-ScriptAnalyzer -Path ./Accessibility/ -Recurse"

# Check for specific issues
pwsh -c "Import-Module PSScriptAnalyzer; Invoke-ScriptAnalyzer -Path ./Accessibility/ -Recurse | Where-Object Severity -eq 'Error'"
```

## Validation Scenarios

ALWAYS run these validation scenarios after making changes to ensure functionality works correctly:

### 1. Basic Module Import and Function Test
```bash
pwsh -c "Import-Module ./Accessibility/Accessibility.psd1 -Force; Get-Command -Module Accessibility"
# Expected: Should show ConvertTo-Bionic function
```

### 2. Text Conversion Scenarios
```bash
# Test string input
pwsh -c "Import-Module ./Accessibility/Accessibility.psd1 -Force; 'Testing bionic text conversion functionality' | ConvertTo-Bionic"

# Test file input
echo "Sample text file for bionic conversion testing" > /tmp/test.txt
pwsh -c "Import-Module ./Accessibility/Accessibility.psd1 -Force; ConvertTo-Bionic -InputFilePath /tmp/test.txt"

# Test custom fixation length
pwsh -c "Import-Module ./Accessibility/Accessibility.psd1 -Force; 'Testing custom fixation' | ConvertTo-Bionic -FixationLength 2"
```

### 3. Help System Validation
```bash
# Test help documentation
pwsh -c "Import-Module ./Accessibility/Accessibility.psd1 -Force; Get-Help ConvertTo-Bionic -Full"
# Expected: Should show complete help with synopsis, parameters, examples
```

### 4. Complete Test Suite
```bash
# Run all tests (takes ~2.3 seconds - set timeout to 300+ seconds)
mkdir -p Output/Accessibility/0.1.0 && cp -r Accessibility/* Output/Accessibility/0.1.0/
pwsh -c "$env:BHProjectPath = '$PWD'; $env:BHProjectName = 'Accessibility'; $env:BHPSModuleManifest = '$PWD/Accessibility/Accessibility.psd1'; Import-Module Pester; Invoke-Pester tests/ -Output Detailed"
# Expected: 25 passed, 0 failed, 2 skipped (git tagging tests skip in development)
```

## Common Issues and Limitations

### PowerShell Gallery Issues
- `build.ps1 -Bootstrap` fails with "No repository with the name 'PSGallery' was found"
- Module dependencies (PSDepend, psake, BuildHelpers, PowerShellBuild) cannot be installed via PowerShell Gallery
- **Workaround**: Use direct module import and manual test setup as documented above

### Module Structure
```
Accessibility/
├── Accessibility.psd1          # Module manifest
├── Accessibility.psm1          # Module root
├── Public/
│   └── ConvertTo-Bionic.ps1   # Main accessibility function
└── Private/
    └── Get-WordFixationLength.ps1  # Helper function
```

### Expected Timings
- **Module import**: ~0.4 seconds
- **ConvertTo-Bionic execution**: ~0.4 seconds  
- **PSScriptAnalyzer linting**: ~1 second
- **Complete test suite**: ~2.3 seconds
- **Meta tests only**: ~0.5 seconds

## Key Validation Steps for Agents

1. **ALWAYS** import the module before testing: `Import-Module ./Accessibility/Accessibility.psd1 -Force`
2. **ALWAYS** run PSScriptAnalyzer before committing: `Invoke-ScriptAnalyzer -Path ./Accessibility/ -Recurse`
3. **ALWAYS** test ConvertTo-Bionic with multiple scenarios (string, file, custom fixation)
4. **ALWAYS** run the complete test suite with proper environment variable setup
5. **NEVER CANCEL** test runs - they complete in under 3 seconds
6. **Use timeouts of 300+ seconds** for test commands to ensure completion

## Repository Structure Quick Reference

### Key Files
- `Accessibility/Accessibility.psd1` - Module manifest (version 0.1.0)
- `Accessibility/Public/ConvertTo-Bionic.ps1` - Main function for bionic text conversion
- `tests/` - Pester test files (Help.tests.ps1, Manifest.tests.ps1, Meta.tests.ps1)
- `build.ps1` - Build script (requires PowerShell Gallery dependencies)
- `psakeFile.ps1` - Build task definitions
- `requirements.psd1` - Module dependencies list

### Available Commands
```powershell
# After importing module
Get-Command -Module Accessibility
# Returns: ConvertTo-Bionic function
```

### CI/CD Integration
- Uses shared workflows from PSInclusive/.github
- CI workflow: `.github/workflows/CI.yaml`
- Publish workflow: `.github/workflows/PublishModule.yml`
- Both depend on external shared workflows

Remember: Focus on what works (direct module import, testing, linting) rather than attempting to fix PowerShell Gallery registration issues in the environment.
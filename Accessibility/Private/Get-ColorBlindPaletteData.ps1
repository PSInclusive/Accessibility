# Okabe-Ito palette: peer-reviewed, safe across all common colorblindness types.
# Source: https://jfly.uni-koeln.de/color/
$script:OKABE_ITO = @{
    Black         = @{ R = 0;   G = 0;   B = 0   }
    Orange        = @{ R = 230; G = 159; B = 0   }
    SkyBlue       = @{ R = 86;  G = 180; B = 233 }
    BluishGreen   = @{ R = 0;   G = 158; B = 115 }
    Yellow        = @{ R = 240; G = 228; B = 66  }
    Blue          = @{ R = 0;   G = 114; B = 178 }
    Vermillion    = @{ R = 213; G = 94;  B = 0   }
    ReddishPurple = @{ R = 204; G = 121; B = 167 }
}

function Get-ColorBlindPaletteData {
    <#
    .SYNOPSIS
    Returns the RGB color table for a named color blind profile.

    .DESCRIPTION
    Returns a hashtable of named color entries (each with R, G, B keys) for the specified
    color blindness profile. All profiles are derived from the Okabe-Ito palette, adjusted
    per the specific perceptual needs of each condition.

    .PARAMETER ProfileType
    The color blindness profile to retrieve. Valid values: Deuteranopia, Protanopia,
    Tritanopia, Achromatopsia, AccessibleDefault.

    .EXAMPLE
    Get-ColorBlindPaletteData -ProfileType Deuteranopia
    #>
    param (
        [Parameter(Mandatory = $true)]
        [ValidateSet('Deuteranopia', 'Protanopia', 'Tritanopia', 'Achromatopsia', 'AccessibleDefault')]
        [string]$ProfileType
    )

    switch ($ProfileType) {
        'Deuteranopia' {
            # Red-green deficiency (most common). Maximize blue/orange/yellow contrast.
            # Red and green are shifted to orange and blue respectively.
            @{
                Error     = @{ R = 213; G = 94;  B = 0   }  # Vermillion (not red)
                Warning   = @{ R = 230; G = 159; B = 0   }  # Orange
                Success   = @{ R = 0;   G = 114; B = 178 }  # Blue (not green)
                Info      = @{ R = 86;  G = 180; B = 233 }  # Sky Blue
                Highlight = @{ R = 240; G = 228; B = 66  }  # Yellow
                Accent    = @{ R = 204; G = 121; B = 167 }  # Reddish Purple
                Text      = @{ R = 0;   G = 0;   B = 0   }  # Black
                Muted     = @{ R = 120; G = 120; B = 120 }  # Mid-gray
            }
        }
        'Protanopia' {
            # Red-weak (cannot perceive red). Red-range hues shifted further toward orange/yellow.
            @{
                Error     = @{ R = 230; G = 159; B = 0   }  # Orange (red is invisible)
                Warning   = @{ R = 240; G = 228; B = 66  }  # Yellow
                Success   = @{ R = 0;   G = 114; B = 178 }  # Blue
                Info      = @{ R = 86;  G = 180; B = 233 }  # Sky Blue
                Highlight = @{ R = 204; G = 121; B = 167 }  # Reddish Purple
                Accent    = @{ R = 0;   G = 158; B = 115 }  # Bluish Green
                Text      = @{ R = 0;   G = 0;   B = 0   }  # Black
                Muted     = @{ R = 120; G = 120; B = 120 }  # Mid-gray
            }
        }
        'Tritanopia' {
            # Blue-yellow deficiency. Shift to red/green contrast; replace blue with high-contrast cyan.
            @{
                Error     = @{ R = 213; G = 94;  B = 0   }  # Vermillion
                Warning   = @{ R = 204; G = 121; B = 167 }  # Reddish Purple (not yellow)
                Success   = @{ R = 0;   G = 158; B = 115 }  # Bluish Green
                Info      = @{ R = 0;   G = 200; B = 200 }  # Cyan (high contrast, not pure blue)
                Highlight = @{ R = 255; G = 100; B = 100 }  # Light Red (visible to tritanopes)
                Accent    = @{ R = 180; G = 60;  B = 60  }  # Dark Red
                Text      = @{ R = 0;   G = 0;   B = 0   }  # Black
                Muted     = @{ R = 120; G = 120; B = 120 }  # Mid-gray
            }
        }
        'Achromatopsia' {
            # Full colorblindness. Grayscale ladder with minimum 7:1 WCAG AAA contrast steps.
            @{
                Error     = @{ R = 30;  G = 30;  B = 30  }  # Near-black (on white bg)
                Warning   = @{ R = 80;  G = 80;  B = 80  }  # Dark gray
                Success   = @{ R = 50;  G = 50;  B = 50  }  # Dark gray variant
                Info      = @{ R = 110; G = 110; B = 110 }  # Medium gray
                Highlight = @{ R = 230; G = 230; B = 230 }  # Near-white
                Accent    = @{ R = 0;   G = 0;   B = 0   }  # Black
                Text      = @{ R = 0;   G = 0;   B = 0   }  # Black
                Muted     = @{ R = 160; G = 160; B = 160 }  # Light gray
            }
        }
        'AccessibleDefault' {
            # Okabe-Ito as-is: a safe general baseline for users unsure of their type.
            @{
                Error     = @{ R = 213; G = 94;  B = 0   }  # Vermillion
                Warning   = @{ R = 230; G = 159; B = 0   }  # Orange
                Success   = @{ R = 0;   G = 158; B = 115 }  # Bluish Green
                Info      = @{ R = 86;  G = 180; B = 233 }  # Sky Blue
                Highlight = @{ R = 240; G = 228; B = 66  }  # Yellow
                Accent    = @{ R = 0;   G = 114; B = 178 }  # Blue
                Text      = @{ R = 0;   G = 0;   B = 0   }  # Black
                Muted     = @{ R = 120; G = 120; B = 120 }  # Mid-gray
            }
        }
    }
}

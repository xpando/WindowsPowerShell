# Paths
Add-Path "$psscriptroot\scripts"

# Aliases
Set-Alias which Get-Command
if (test-path "C:\Program Files\Sublime Text 2\sublime_text.exe") { Set-Alias subl "C:\Program Files\Sublime Text 2\sublime_text.exe" }
if (test-path "C:\Program Files\Sublime Text 3\sublime_text.exe") { Set-Alias subl "C:\Program Files\Sublime Text 3\sublime_text.exe" }

# Remove problematic aliases
rm alias:curl
rm alias:wget

if (gcm pshazz -ea SilentlyContinue) {
    pshazz init 'xpando'
}

# Print out a fancy PowerShell Banner :)
Banner.ps1

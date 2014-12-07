![ScreenShot](https://raw.githubusercontent.com/xpando/screenshots/master/PowerShell/Powershell.png)

## Setup Instructions

Run a powershell prompt as admin and ensure you can run unsigned scripts

```Powershell
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope CurrentUser 
```

Install scoop

```PowerShell
  # https://github.com/lukesampson/scoop
  iex (new-object net.webclient).downloadstring('https://get.scoop.sh')
```

Use scoop to install common utilities

```PowerShell
  # if you don't already have git installed 
  scoop install git    

  # pshazz for nice themable prompt, dir colors and more
  # https://github.com/lukesampson/pshazz
  scoop install pshazz 
```

Configure PowerShell profile. You may want to fork my repo so you can track your own customizations.

``` PowerShell
  # remove existing profile if it exists. WARNING: this will delete your existing profile. Backup your existing profile first if you
  # want to keep any settings that you have already made there
  if (test-path $env:USERPROFILE\Documents\WindowsPowerShell) { rm -Recurse -Force $env:USERPROFILE\Documents\WindowsPowerShell } 

  # Clone into the standard PowerShell profile directory
  cd $env:USERPROFILE\Documents
  git clone https://github.com/xpando/WindowsPowerShell.git
```

##### IMPORTANT! Close your current PowerShell window and start a new one as admin so that the new profile settings will take effect

Setup ConEmu - Includes the color scheme you see in the screenshot.

```PowerShell
  # Clone repo with ConEmu configuration and installation script
  cd C:\
  git clone https://github.com/xpando/ConEmu.git
  cd ConEmu

  # Install fonts
  dir .\Fonts\*.ttf |% { add-font -path $_ }

  # download and unzip ConEmu binaries
  .\install.ps1
```

Now you can run **_ConEmu.exe_** or **_ConEmu64.exe_** if you are a 64bit OS and continue.

Customize pshazz theme

```PowerShell
  # download my pshazz theme shown in screenshot 
  $url = 'https://gist.githubusercontent.com/xpando/d42df2c0f014d710db42/raw/0b6f18bdf73eca05e5e3e0f4169249166d4af6c4/xpando.json'
  if (!(test-path $env:USERPROFILE\pshazz)) { md $env:USERPROFILE\pshazz}
  (new-object net.webclient).downloadstring($url) | out-file $env:USERPROFILE\pshazz\xpando.json
  pshazz use xpando
```

## Included Modules and Scripts

**PSReadline** - syntax highlighting and intellisense like completion for powershell commands
_https://github.com/lzybkr/PSReadLine_

**PSGet** - Search and install PowerShell modules easy.
_http://psget.net/_

**VisualStudio** - provides command for importing Visual Studio environment settings so you can run msbuild.exe and csc.exe etc.
Examples:

```PowerShell
Import-VSEnvironment # using default version of 12
vs 11 # using alias and specify Visual Studio version
```
**Clean-VSSolution.ps1** - Removes temp and output folders typically created by Visual Studio builds. Defaults to remove obj and bin folders

```PowerShell
# Remove all obj and bin folders from the current directory and any sub directories
Clean-VSSolution.ps1

# Remove all svn folders from the current directory and any sub directories
Clean-VSSolution.ps1 -dirNames '.svn', '_svn'
```

Several other useful scripts are included in the ~\Documents\WindowsPowerShell\Scripts folder.
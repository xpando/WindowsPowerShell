Write-Host "Getting system information..."

$computer    = gwmi Win32_ComputerSystem
$os          = gwmi Win32_OperatingSystem
$processor   = gwmi Win32_Processor
$display     = gwmi Win32_DisplayConfiguration
$network     = gwmi Win32_NetworkAdapterConfiguration
$uptime      = $os.ConvertToDateTime($os.LocalDateTime) - $os.ConvertToDateTime($os.LastBootUpTime)
$ipAddresses = ($network | where IPAddress |% { $_.IPAddress[0] }) -join ", "

$info = `
    "Computer: ", "$($env:computername) - $($computer.Model), $($computer.Manufacturer)",
    "Uptime:   ", "$($uptime.Days)d $($uptime.Hours)h $($uptime.Minutes)m $($uptime.Seconds)s",
    "OS:       ", "$($os.Caption) $($os.OSArchitecture)",
    "Kernel:   ", "$($os.Version)",
    "CPU:      ", "$($processor.Name)",
    "GPU:      ", "$($display.DeviceName)",
    "Memory:   ", "$([math]::Truncate($os.FreePhysicalMemory / 1KB)) MB / $([math]::Truncate($computer.TotalPhysicalMemory / 1MB)) MB",
    "Network:  ", "$ipAddresses",
    "Shell:    ", "PowerShell v$($Host.Version)"

clear

function WriteTo-Pos (
    [string] $str, 
    [int] $x = 0, 
    [int] $y = 0,
    [string] $bgc = [console]::BackgroundColor,
    [string] $fgc = [console]::ForegroundColor
)
{
      if($x -ge 0 -and $y -ge 0 -and $x -le [Console]::WindowWidth -and $y -le [Console]::WindowHeight)
      {
            $saveY = [console]::CursorTop
            $offY = [console]::WindowTop       
            [console]::setcursorposition($x,$offY+$y)
            Write-Host -Object $str -BackgroundColor $bgc -ForegroundColor $fgc -NoNewline
            [console]::setcursorposition(0,$saveY)
      }
}

# Print ASCII logo
if ($Host.UI.RawUI.MaxWindowSize.Width -ge 40) {
    $fgc = $Host.UI.RawUI.ForegroundColor
    $bgc = $Host.UI.RawUI.BackgroundColor
    # TODO: Print a different logo depending on the version of windows
    if ((test-path env:ConEmuANSI) -and ($env:ConEmuANSI -eq "ON")) {
        cat $psscriptroot\..\logos\flag2.ans
    } else {
        cat $psscriptroot\..\logos\flag2.txt
    }
    $Host.UI.RawUI.ForegroundColor = $fgc
    $Host.UI.RawUI.BackgroundColor = $bgc
}

# Print system information
if ($Host.UI.RawUI.MaxWindowSize.Width -ge 80) {
    $y = 3; $x = 45
    for ($i = 0; $i -lt $info.Length; $i+=2) {
        $label = $info[$i]
        $value = $info[$i+1]
        $maxW = $Host.UI.RawUI.MaxWindowSize.Width - $x - $label.Length
        if ($maxW -lt 0) { $maxW = 0 }
        if ($value.Length -gt $maxW) { $value = $value.Substring(0, $maxW) }
        WriteTo-Pos -str $label -x $x -y $y -fgc "gray"
        $x += $label.Length
        WriteTo-Pos -str $value -x $x -y $y -fgc "white"
        $x = 45
        $y++
    }
}

Write-Host
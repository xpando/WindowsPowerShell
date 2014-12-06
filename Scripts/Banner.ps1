$computer    = gwmi Win32_ComputerSystem
$os          = gwmi Win32_OperatingSystem
$processor   = gwmi Win32_Processor
$display     = gwmi Win32_DisplayConfiguration
$network     = gwmi Win32_NetworkAdapterConfiguration
$uptime      = $os.ConvertToDateTime($os.LocalDateTime) - $os.ConvertToDateTime($os.LastBootUpTime)
$ipAddresses = ($network | where IPAddress |% { $_.IPAddress[0] }) -join ", "

$info = `
    "Computer: ", "$($computer.Model), $($computer.Manufacturer)",
    "Uptime:   ", "$($uptime.Days)d $($uptime.Hours)h $($uptime.Minutes)m $($uptime.Seconds)s",
    "OS:       ", "$($os.Caption) $($os.OSArchitecture)",
    "Kernel:   ", "$($os.Version)",
    "CPU:      ", "$($processor.Name)",
    "GPU:      ", "$($display.DeviceName)",
    "Memory:   ", "$([math]::Truncate($os.FreePhysicalMemory / 1KB)) MB / $([math]::Truncate($computer.TotalPhysicalMemory / 1MB)) MB",
    "Network:  ", "$ipAddresses",
    "Shell:    ", "PowerShell v$($Host.Version)"

$logo = `
"          .:::..                        ", "red",                    "$($info[0])",  "gray", "$($info[1])`r`n",  "white",
"       ccccccccccc.                     ", "red",                    "$($info[2])",  "gray", "$($info[3])`r`n",  "white",
"      :ccccccccccc", "red", " :Cc.      :c         ", "green",       "$($info[4])",  "gray", "$($info[5])`r`n",  "white",
"      ccccccccccc.", "red", " ooooooooooo.         ", "green",       "$($info[6])",  "gray", "$($info[7])`r`n",  "white",
"     :cccccccccc:", "red", " cooooooooooc          ", "green",       "$($info[8])",  "gray", "$($info[9])`r`n",  "white",
"    .oc::'':cccc", "red", " .ooooooooooo.          ", "green",       "$($info[10])", "gray", "$($info[11])`r`n", "white",
"     .:ccocc.", "blue", "    oooooooooooc           ", "green",      "$($info[12])", "gray", "$($info[13])`r`n", "white",
"   :oooooooocoo", "blue", "   .coCoCooc.            ", "green",      "$($info[14])", "gray", "$($info[15])`r`n", "white",
"   oooooooooco.", "blue", " COo. ", "yellow", "''", "green", " .cCc            ", "yellow", "$($info[16])", "gray", "$($info[17])`r`n", "white",
"  :ooooooooooc", "blue", " cOCCCCCCCCCC:            `r`n", "yellow",
"  ooooooooooo.", "blue", " CCCCCCCCCCO:             `r`n", "yellow",
" cc:.   .:co:", "blue", " oOCCCCCCCCOo              `r`n", "yellow",
"             .OCCCCCCCCCO.              `r`n", "yellow",
"               .coCCCoc.                `r`n", "yellow"

clear
for ($i = 0; $i -lt $logo.Length; $i+=2) {
    $str = $logo[$i]
    $color = $logo[$i+1]
    Write-Host $str -f $color -nonewline
}

Write-Host
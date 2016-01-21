[CmdletBinding()]
param(
  [Parameter(ValueFromPipeline=$True)]
  [String[]] $ComputerName = "localhost"
)

process {
  foreach ($name in $ComputerName) {
      $memory = Get-WmiObject Win32_ComputerSystem -ComputerName $name -ea SilentlyContinue
      if ($memory) {
        $memory = "$([math]::Ceiling($memory.TotalPhysicalMemory / 1Gb)) GB"
      } else {
        $memory = ""
      }
    
    $cpus = Get-WmiObject Win32_Processor -ComputerName $name -ea SilentlyContinue
    if ($cpus) {
      $cpus = $cpus |% { "$($_.DeviceID):$($_.NumberOfCores):$($_.NumberOfLogicalProcessors)" }
      $cpus = $cpus -join "; "
    } else {
      $cpus = ""
    }
    
    $disks = Get-WmiObject Win32_logicaldisk -ComputerName $name -ea SilentlyContinue
    if ($disks) {
      $disks = $disks |? { $_.DeviceID -in "C:","D:" } | select DeviceID,FreeSpace,Size |% { "$($_.DeviceID) $([math]::Ceiling(($_.Size - $_.FreeSpace) / 1Gb))/$([math]::Ceiling($_.Size / 1Gb)) GB" }
      $disks = $disks -join "; "
    } else {
      $disks = ""
    }
    
    $nics = Get-WmiObject Win32_NetworkAdapterConfiguration -filter "ipenabled = 'true'" -ComputerName $name -ea SilentlyContinue
    $br = ""
    $fr = ""
    if ($nics) {
      foreach ($nic in $nics) {
        $adapter = $nic.GetRelated('win32_NetworkAdapter')
        switch -regex ($adapter.NetConnectionID) {
          "^Nic\d+-BR-" { $br = $nic.IPAddress }
          "^Nic\d+-FR-" { $fr = $nic.IPAddress }
        }
      }
    }
    
    Write-Output (New-Object -TypeName PSObject -Property @{ Name = $name; Memory = $memory; CPU = $cpus; Disk = $disks; FrontRail = $fr; BackRail = $br })
  }
}

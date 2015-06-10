param(
  [string[]]$ComputerNames
)

foreach ($name in $ComputerNames) {
  $computer = [ADSI]("WinNT://" + $name + ",computer")
  $group = $computer.psbase.children.find("Administrators")
  $members = $group.psbase.invoke("Members") |% { $_.GetType().InvokeMember("Adspath", "GetProperty", $null, $_, $null) }
  foreach ($member in $members) {
    Write-Output (New-Object psobject -property @{ ComputerName=$name; Member=$member })
  }
}

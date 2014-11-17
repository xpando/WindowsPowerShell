[cmdletbinding()]
param(
  [parameter(ValueFromPipeline=$true,ValueFromPipelineByPropertyName=$true)]
  [string]$path = ".",
  [string[]]$dirNames = @("obj", "bin")
)

foreach ($dirName in $dirNames) {
    $dirs = dir $path -Recurse -Directory $dirName | sort -Descending -Property FullName
    $dirs |% { Write-Host "Removing $($_.FullName)" }
    $dirs | del -Recurse -Force -ErrorAction SilentlyContinue
}

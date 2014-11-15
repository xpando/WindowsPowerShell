[cmdletbinding()]
param(
  [parameter(ValueFromPipeline=$true,ValueFromPipelineByPropertyName=$true)]
  [string]$path = "."
)

write-host $path
Push-Location $path
try {
  $dirs = Get-ChildItem -recurse |? { $_.GetType().Name.ToString() -eq "DirectoryInfo" -and $_.Name -eq "bin" -or $_.Name -eq "obj" }
  
  if ($dirs.Length -gt 0) {
    $dirs | %{ Write-Host "Removing " $_.FullName }
    $dirs | %{ Remove-Item -recurse -path $_.FullName -force }
  }
  else { 
    Write-Host "Solution is clean"
  }
}
finally {
  Pop-Location
}

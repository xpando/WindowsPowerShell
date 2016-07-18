function Import-VSEnvironment($version = "14") {
  function importEnvironment($file) {
    $cmd = "`"$file`" & set"
    cmd /c $cmd |% {
      $p, $v = $_.split('=')
      if ($p) {
        Set-Item -Path env:$p -Value $v -Force
      }
    }
  }

  $var = "VS$($version)0COMNTOOLS"
  if (test-path "env:$var") {
    $bat = (get-content "env:$var") + "vsvars32.bat"
    if (test-path $bat) {
      importEnvironment $bat
      [System.Console]::Title = "Visual Studio " + $version + " Windows Powershell"
    } else {
      Write-Error "$bat not found."
    }
  }
  else {
    Write-Error "Visual Studio $version is not installed."
  }
}

Set-Alias vs Import-VSEnvironment

Export-ModuleMember -Function * -Alias *
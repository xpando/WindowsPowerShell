function Add-Path($items) {
  $items = @() + $items
  $paths = $env:path -split ";"
  $items = @() + ($items |? { $paths -notcontains $_ })
  $paths = ($items + $paths) |? { ![string]::IsNullOrEmpty($_) -and (Test-Path $_ -PathType Container) } |% { (Resolve-Path $_).ProviderPath }
  $env:path = $paths -join ";"
}

function Remove-Path($items) {
  $items = @() + $items
  $paths = $env:path -split ";"
  $paths = $paths |? { $items -notcontains $_ }
  $env:path = $paths -join ";"
}

Export-ModuleMember -Function * -Alias *
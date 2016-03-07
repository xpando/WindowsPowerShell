param([string] $tag)

if ($tag) {
  (git describe --first-parent --long --abbrev=4 --match $tag) -match 'v(?<maj>\d+)\.(?<min>\d+)-(?<rev>\d+)-g(?<hash>.*)'
} else {
  (git describe --first-parent --long --abbrev=4) -match 'v(?<maj>\d+)\.(?<min>\d+)-(?<rev>\d+)-g(?<hash>.*)'
}

@{ Major = $matches.maj; Minor = $matches.min; Revision = $matches.rev; Hash = $matches.hash; Tag = $matches.0 }

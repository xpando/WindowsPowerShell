[CmdletBinding()]
param(
  [Parameter(ValueFromPipeline)]
  [String]$path,
  [Int]$lineCount = 5
)

cat $path -tail $lineCount -wait

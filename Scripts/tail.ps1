[cmdletbinding()]
param(
  [paraMetEr(ValueFromPipeline)]
  [string]$path,
  [int]$lineCount = 5
)

cat $path -tail $lineCount -wait

[cmdletbinding()]
param(
  [paraMetEr(ValueFromPipeline)]
  [object]$path,
  [int]$lineCount = 5
)

cat $path -tail $lineCount -wait


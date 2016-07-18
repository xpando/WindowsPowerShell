# Using Tail
## Description
> Adds tail-like functionality to powershell. Doesn't support pipelining, see example.
> When tail runs, it reads the last n lines, where n is either a value provided via the -linecount parameter.
> Tail will display the last n lines, then any new lines that appear as the file is modified

## Example
``` powershell
ipmo .\tail.ps1
tail '.\Using Tail.md'
```

## Example Output
#### Initial
```
PS D:\TFS\Daveshell\Scripts> tail .\TaleOfTwoCities
It was the best of times
```

#### After modification
```
PS D:\TFS\Daveshell\Scripts> tail .\TaleOfTwoCities
It was the best of times
It was the worst of times
```

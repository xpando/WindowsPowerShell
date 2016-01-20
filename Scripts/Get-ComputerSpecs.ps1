param(
  [string[]] $ComputerName
)

$ComputerName |% {
  @{
    System = Get-WmiObject Win32_ComputerSystem -ComputerName $_;
    Processor = Get-WmiObject Win32_Processor -ComputerName $_;
  } 
  
} |% { 
  @{ 
    Name = $_.System.Name;
    Cores = $_.Processor.NumberOfCores;
    LogicalProcessors = $_.Processor.NumberOfLogicalProcessors; 
    Memory = "$([math]::Ceiling($_.System.TotalPhysicalMemory / 1Gb)) GB" 
  } 
} |% { 
    New-Object -TypeName PSObject -Property $_ 
}

#PowerShell classes:Properties

Class Computer {
    [String]$Name
    [String]$Type
    [string]$Description
    [string]$owner
    [string]$Model
    [datetime]$CreationDate
    [int]$Reboots
   
   
}

$b = [computer]::new()



$b | gm




$b
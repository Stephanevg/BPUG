#PowerShell classes:Methods

Class Computer {
    [String]$Name
    [String]$Type
    [string]$Description
    [string]$owner
    [string]$Model
    [datetime]$CreationDate
    [int]$Reboots
    
    [void]Reboot(){
        $this.Reboots ++
    }

    
}



$c = [Computer]::new()

for($i=1; $i -le 10; $i++){
    $b.Reboot()
}

$c

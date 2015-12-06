#PowerShell classes:Methods

    #A method is an action that DOES something

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

#What is Void? --> Void is nothing!

$c = [Computer]::new()

$c

$c.Reboot() #Notice that it didn't returned anything

$c.Reboots

for($i=1; $i -le 10; $i++){
    $c.Reboot()
}

$c

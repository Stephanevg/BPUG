#PowerShell classes:Static Methods 

Class Computer {
    [String]$Name
    [String]$Type
    [string]$Description
    [string]$owner
    [string]$Model
    [datetime]$CreationDate
    [int]$Reboots
    
    #Non static can use 'this' (the current instance).
        [void]Reboot(){
            $this.Reboots ++
        
        }

    #static members cannot use 'this' (the current instance).
    static [string] ResetNumberOfReboots(){
        
        #$this.reboots = 0

        return "Nope, I am not going to do that!"
   }



}

#All methods are public (Can be seen / used from anywhere).

#A static method is not called using the .<Name>() but ::<Name>.()

#Calling static method
    [Math]::PI

#Calling our custom build Static method
    [Computer]::ResetNumberOfReboots()

    
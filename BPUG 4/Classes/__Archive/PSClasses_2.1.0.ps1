#PowerShell classes:Constructors Overloads

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

    
    static [string] ResetNumberOfReboots(){
        
        #$this.reboots = 0

        return "Nope, I am not going to do that!"
   }

    
    
    Computer (){
    
        $this.CreationDate = get-date

    }

    
    #Constructors have their own signatures based on parameters and types.
    Computer ([String]$Name,[String]$Description){
    
        $this.CreationDate = get-date
        $this.Name = $Name
        $This.Description = $Description

        
    }


}

#Show intelisense difference:

    $d = [computer]::new("BPUG","Description")

    $d
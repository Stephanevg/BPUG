##Advanced Methods

#Creating an object in Active Directory

#region Helper Functions
import-module "C:\System\Scripts\Classes\BPUG-Commands.psm1" -force

#endregion


Class Computer {
    [String]$Name
    [String]$Type
    [string]$Description
    [string]$owner
    [string]$Model
    [String]$Prefix
    [datetime]$CreationDate
    [int]$Reboots
    
    [void]Reboot(){
        $this.Reboots ++
        
    }
    
    [string] GetNextFreeName ([string]$Prefix) {

        $this.prefix = $prefix.toUpper()
        #$AllNames = Get-ADComputer -Filter {name -like "$prefix*"} | select name
        $AllNames = Get-ADSIComputer -ComputerName "$Prefix*" | select Name
        [int]$LastUsed = $AllNames | % {$_.name.trim("$prefix")} | select -Last 1
        Write-Verbose "Lastused number: $LastUsed"
        $Next = $LastUsed+1
        $nextNumber = $Next.tostring().padleft(2,'0')
        write-verbose "Prefix:$($Prefix) Number:$($nextNumber)"
        $this.Name = $prefix + $nextNumber

        write-verbose "Returning --> $($this.Name)"

        return $this.name
    }

    [Computer]Create($OU){
    
        if (!($This.Name)){
            
            throw "The name parameter cannot be empty"
        }else{
        

            New-ADSIComputer -ComputerName $this.Name -Description $this.Description -OUName $OU

            return $this

        }

        
    }

    Computer (){
    
        $this.CreationDate = get-date

    }

     Computer ([String]$Name,[String]$Description){
    
        $this.CreationDate = get-date
        $this.Name = $Name
        $This.Description = $Description

        
    }


}


#Show intelisense difference:

   
    $d = [computer]::new('NewName','ComputerAccountCreation')

    $d

    $d.GetNextFreeName('SRV')

    $d

    #Creating the Object in AD

    $d.Create('OU=Servers,OU=HQ')
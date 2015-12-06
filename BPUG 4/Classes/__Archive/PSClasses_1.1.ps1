#Region Modifying Existing Objects

$Properties = @{'Name'=$ComputerName;'Owner'=$ComputerOwner;'Type'=$ComputerType}
$Computer = new-object psobject -Property $Properties

##Creating Property Aliases
    $ComputerName = $ComputerName | Add-Member -MemberType AliasProperty -Name Size -Value Length -PassThru

##

#endregion

##Adding Methods to custom objects


    $ScriptBlock1 = {

             $Current = [char[]] $this.Name
             [array]::reverse($Current)
             -join $Current
        
    }
    Add-Member -InputObject $Computer -MemberType ScriptMethod -Name ReverseName -Value $ScriptBlock1 -Force

    $Computer | gm
    
    $Computer.ReverseName()



##Generating a New ComputerName
    $ScriptBlock2 = {
        
        [int]$Suffix = '0'
        Do {
            $Suffix++
            $Prefix = 'SRV'
            $Name = $Prefix + $Suffix
        }While(!($Name))
        return $Name
    }
    Add-Member -InputObject $Computer -MemberType ScriptMethod -Name GenerateComputerName -Value $ScriptBlock2 -Force

#Generating a New ComputerName AND Assigning it to the existing property

$ScriptBlock3 = {
        
        [int]$Suffix = '0'
        Do {
            $Suffix++
            $Prefix = 'SRV'
            $Name = $Prefix + $Suffix
        }While($this.Name -ne $this.Name)
        $This.Name = $Name
    }
    Add-Member -InputObject $Computer -MemberType ScriptMethod -Name GenerateStandardComputerName -Value $ScriptBlock3 -Force

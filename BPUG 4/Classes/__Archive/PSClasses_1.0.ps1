##A history of objects --> creating objects in Powershell prior to Classes.

#region Introduction

$ComputerName = 'Server01'
$ComputerOwner = 'Stephane van Gulick'
$ComputerType = 'Standard Server'

#what is an object?

    $ComputerName | gm

    #Fundamentally? Data (Properties)

        $ComputerName | gm -MemberType Property

        #Returns information
        $ComputerName.Length

    #Methods
        $ComputerName | gm -MemberType Methods

        #Does Something
        $ComputerName.ToUpper()

#endregion

#Creating synthetic objects

$Directories = dir C:\system\scripts | Select-Object -Property Name,Length

$Directories

$SelectedObjects = dir C:\system\scripts | Select-Object -Property Name,Length, @{Name="Folder";Expression={$_.PsIsContainer}}

$SelectedObjects

$SelectedObjects | gm #Folder is of type NoteProperty

#PowerShell Version 1:
$Comp = "Laptop1"

Add-Member -InputObject $Comp -Type NoteProperty -Name Name -Value $ComputerName
Add-Member -InputObject $Comp -Type NoteProperty -Name Owner -Value $ComputerOwner
Add-Member -InputObject $Comp -Type NoteProperty -Name Type -Value $ComputerType


#Everything is an object

$ComputerName | Get-Member -MemberType Property

#region PowerShell version 2:

$Properties = @{'Name'=$ComputerName;'Owner'=$ComputerOwner;'Type'=$ComputerType}
$Computer = new-object psobject -Property $Properties

#Shorter way:

$Props = @{}
$Props.Name = $ComputerName
$Props.Owner = $ComputerOwner
$Props.Type = $ComputerType

$Computer2 = new-object psobject -Property $Props

$Computer2

#endregion

#region PowerShell Version 3

    #Creating Objects using the PSCustomObject Accelerator
        $Computer3 = [PSCustomOBject] @{'Name'=$ComputerName;'Owner'=$ComputerOwner;'Type'=$ComputerType}

        $Computer3

    #Creating Objects had one draw back (sometimes): The order
        $Properties2 = @{'Name'=$ComputerName;'Owner'=$ComputerOwner;'Type'=$ComputerType;'Property1'='Woop';'Property2'='Plop';'Property3'='Woopidipoopi'}
        $Computer4 = [PSCustomOBject]$Properties2

    #Is resolved when using Accelerator [Ordered]
        $Properties3 = [Ordered]@{'Name'=$ComputerName;'Owner'=$ComputerOwner;'Type'=$ComputerType;'Property1'='Woop';'Property2'='Plop';'Property3'='Woopidipoopi'}
        $Computer5 = [PSCustomObject]$Properties3

#endregion

psedit \PSClasses_1.1
#PowerShell Version
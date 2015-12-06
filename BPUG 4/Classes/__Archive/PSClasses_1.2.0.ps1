#PowerShell classes: Properties


#There are no comas in between the parameters.

Class Computer {
    [String]$Name
    [String]$Type
    [string]$Description
    [string]$owner
    [string]$Model
    [datetime]$CreationDate
    [int]$Reboots
 

}

#To create an object, you need to 'Instanciate the class.'

#Class instanciation
    #New-Object is not 'yet' supported.
    $a = [computer]::new()

#Closer look on the type

$a.GetType()

$a.GetType().fullname

$a.name = 'BPUG'

$a
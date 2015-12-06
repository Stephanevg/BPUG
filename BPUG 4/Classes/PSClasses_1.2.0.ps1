#PowerShell classes: Properties

Class BPUG {
    
 

}

#There are no comas in between the parameters and they are typed.

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
    
    $BPUG = [BPUG]::new()
    $BPUG

    $a = [computer]::new()

#Closer look on the type
$a

$a.GetType() #BaseType System.Object

$a.GetType().fullname #is of type "Computer"


#Property assignements

$a.name = 'BPUG'

$a
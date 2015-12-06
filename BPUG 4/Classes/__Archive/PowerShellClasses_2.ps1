#Enums
#http://social.technet.microsoft.com/wiki/contents/articles/7804.powershell-creating-custom-objects.aspx
Enum ServerType {
    HyperV
    Sharepoint
    DSC
    Exchange
    Lync
    Web
    ConfigMgr
}

Enum WorkStationType{
    Laptop
    WorkStation
    NoteBook
    Tablet
}

#PowerShell classes
 
#Creat objects
Class Computer {
    [String]$Name
    [String]$Type
    [string]$Description
    [string]$owner
    [string]$Model
    [int]$Reboots
 
    [void]Reboot(){
        $this.Reboots ++
    }
    
    [string] GetNextFreeName () {

        $AllNames = Get-ADComputer -Filter {name -like "$this.prefix*"} | select name
        [int]$LastUsed = $AllNames | % {$_.name.trim("$prefix")} | select -Last 1
        $Next = $LastUsed+1
        $nextNumber = $Next.tostring().padleft(3,'0')
        write-verbose "Prefix:$($this.Prefix) Number:$($nextNumber)"
        $Return = $this.prefix + $nextNumber

        return $Return
    }

    Computer ([string]$Name){
        if ($comp = Get-ADComputer -filter "name -eq '$Name'" -Properties * -ErrorAction SilentlyContinue){
            $this.name =$Name
            $this.Description = $Comp.Description
 
            switch -wildcard ($comp.OperatingSystem){
                ('*Server*') {$this.Type = 'Server';Break}
                ('*workstation*') {$this.Type = 'Workstation'}
                ('*Laptop*') {$this.Type = 'Laptop';Break}
                default { $this.Type = 'N/A'}
             
            }
           $this.owner = $comp.ManagedBy.Split(',')[0].replace('CN=','')
        }else{
            write-warning "Could Not find $($this.name)"
        }
         
    }

    Computer ([string]$Name, [String]$type,[string]$Description,[string]$owner,[String]$Model){
        if (!($comp = Get-ADComputer -filter "name -eq '$Name'" -Properties name)){
 
             
            if ($user = Get-ADUser -Filter "name -eq '$owner'"){
             
                try{
                   New-ADComputer -Name $Name -Description $Description -ManagedBy $user -ErrorAction Stop
                    $this.Name = $Name
                    $this.Type = $type
                    $this.Description = $Description
                    $this.owner = $owner    
                }catch{
                    $_
                } 
            }else{
                write-warning "the user $($Owner) is not existing. Please verify and try again."
            }
        }
         
    }
 
}

Class Server : computer {
    [serverType]$Type
    [string]$Group
    [string]$Prefix = 'SRV'
    [string]$Name

    Server ([string]$Name) : Base ($Name) {
        $this.Name
    }


}

Class Client : computer {
    [serverType]$Type
    [string]$Group
    [string]$Prefix = 'CLT'
    [string]$Name

    Client ([string]$Name) : Base ($Name) {
        $this.Name
    }

    <#
    To call base class methods from overridden implementations, cast to the base class ([baseclass]$this) on invocation.

    class childClass2 : baseClass 
    {
        [int]foo() 
        {
            return 3 * ([baseClass]$this).foo() 
        }
    } 

    [childClass2]::new().foo() # return 301500 

    #>
}

#$ListName = 'Server Inventory'
#$Server02=Get-SPRestListItem -SiteCollectionUrl $urlConfig -ListName $ListName -ItemName 'Server02'

Function Get-SPRestSiteUser {

#http://sp.district.local:3000/sites/Config/_api/web/SiteUsers
Web/GetUserById(9)
}

Function New-SPRestListItem {


    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$true)]
        [String]
        $SiteCollectionUrl,
        
        [Parameter(Mandatory=$false)]
        [String]
        $ListName,

        [Parameter(Mandatory=$false)]
        [String]
        $ListID,

        #NotWorking yet
        [Parameter(Mandatory=$false)]
        [String]
        $ItemName,

        
        [Parameter(Mandatory=$false)]
        [object]
        $KeyValues,

        [Parameter(Mandatory=$true)]
        [String]
        $Digest,

        $fieldname,
        $fieldValue,
        $inputvalues,

        [Parameter(Mandatory=$false)]
        [switch]
        $JSON
    )
    
    Begin{

        $Header = @{'X-HTTP-Method'='post';'X-RequestDigest'="$digest";'content-type'='application/json;odata=verbose';'accept'='application/json'}
        #"application/json;odata=verbose"
    #content-length:length of post body
        if (!($SiteCollectionURL.EndsWith('/'))){
            $SiteCollectionURL = $SiteCollectionURL + '/'
        }
        if ($JSON){
            $Header = @{accept = 'application/json; odata=verbose'}
            
        }

        #SP.Data.Server_x0020_InventoryListItem
      #url: http://site url/_api/web/lists/GetByTitle(‘Test')/items
      $url = $SiteCollectionUrl + "_api/lists/GetByTitle('$ListName')/items"
      $Method = 'POST'


        #$Body = "{ '__metadata': { 'type': 'SP.Data.Server_x0020_InventoryListItem' }, '$FieldName': '$FieldValue'}"
        
        #GetSpREstListItem
        $Body = @()
        $Body = "{ '__metadata': { 'type': 'SP.Data.Server_x0020_InventoryListItem' },"
        Foreach ($item in $Inputvalues){
            $Body += "'$($item.FieldName)': '$($item.FieldValue)',"
        }
        $Body = $Body.Trim(',')
        $Body += '}'
        
        
        #body: { '__metadata': { 'type': 'SP.Data.TestListItem' }, 'Title': 'Test'}


        #$uri = $SiteCollectionUrl + $ResourceList + $ResourceItem
    }
    Process{
         $Return = Invoke-RestMethod -Method $Method -Body $Body -Uri $Url -Headers $Header -UseDefaultCredentials
    }End{
        

    return $Return
    }
}

$a = @()
$now =  get-date -Format s
[string]$chuck = 'i:0#.w|district\kung lao'  #"s-1-5-21-2823844026-2718810626-2006183789-2632"
$a += [pscustomobject]@{FieldName='Title';FieldValue='Server11'}
$a+= [pscustomobject]@{FieldName='Description';FieldValue='HyperV Host'}
$a+= [pscustomobject]@{FieldName='Size';FieldValue='Big'}
$a+= [pscustomobject]@{FieldName='InstallationDate';FieldValue="$now"}
$a+= [pscustomobject]@{FieldName='IsVirtual';FieldValue=$true}
$a+= [pscustomobject]@{FieldName='Owner';FieldValue=$chuck}

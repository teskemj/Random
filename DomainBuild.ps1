# Get-Credential and store info in $cred to use for elevated privileges.

$cred = get-credential

# Create a 1 to 1 remote session. Use Enter-PSSession with the appropriate -ID
New-PSSession -ComputerName YourServer-fs1
Enter-PSSession -Id 1

# Create the Company folder under the c:\shares folder
new-item -Path c:\shares -name Company -ItemType Directory


# Create folders and subfolders under $path. $path is literal path ie, c:\shares\company. It must exist. 
# example: create-dir -path c:\shares\company -folders acco,sale,info,exec -subfolders private,misc,docs
function create-dir {

    [cmdletbinding()]

    param(
        [string]$path,
        [string[]]$folders,
        [string[]]$subfolders
        
    )
    # Process all folders passed, one at a time, and create subfolders for each folder
    # Add test-path to see if $path or $folder or $sub exists.

    foreach ($folder in $folders){

        new-item -Path $path -name $folder -ItemType Directory -Verbose

        foreach ($sub in $subfolders){

            new-item -Path $path\$folder -name $sub -ItemType Directory -Verbose
    
        }

    }

}

# Remove folders and childitem *** Be careful as this will wipe all items ***
get-childitem -path C:\shares\company -Recurse | remove-item -recurse -Force

# Remove OUs and contents of OUS (-recurse)
Remove-ADOrganizationalUnit -Identity "ou=sales_ou,dc=automate,dc=local" -Recursive -force

# Create Company share. Everyone with -FullAccess a.k.a Full Control
New-SmbShare -Path C:\shares\Company -FullAccess "Everyone"

# Create OU Structure
function build-tree{
    [cmdletbinding()]
    param (
        [string[]] $OUS,
        [string] $searchbase
    )
    #$DistName=Get-ADDomain | select -ExpandProperty DistinguishedName

    foreach ($OU in $OUS){
    
        New-ADOrganizationalUnit -Name $OU -Path $searchbase -ProtectedFromAccidentalDeletion $false -Verbose
    }
}

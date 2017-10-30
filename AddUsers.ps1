# Import users.csv into powershell
$ent_users = Import-Csv 'D:\Enteprise.io AD Roster - Users.csv'

# Pull relevant groups for sorting
$domain_users = Get-ADGroup -Filter {SamAccountName -like "Domain Users"}
$ent_admin = Get-ADGroup -Filter {SamAccountName -like "Enterprise Admins"}
$domain_admin = Get-ADGroup -Filter {SamAccountName -like "Domain Admins"}
$bridge_squad = Get-ADGroup -Filter {SamAccountName -like "BridgeSquad"}
$disposable = Get-ADGroup -Filter {SamAccountName -like "DisposableUnits"}
$1way = Get-ADGroup -Filter {SamAccountName -like "1WayMission"}
$5year = Get-ADGroup -Filter {SamAccountName -like "5YearMission"}

# Pull relevant OUs for sorting
$red = Get-ADOrganizationalUnit -Filter {Name -eq "RED"}
$blue = Get-ADOrganizationalUnit -Filter {Name -eq "BLUE"}
$gold = Get-ADOrganizationalUnit -Filter {Name -eq "GOLD"}

# Create users from objects and sort into groups
$ent_users | ForEach-Object {
    $DisplayName = $_."First Name" + " " + $_."Last Name"
    # Create user
    If ($_.Manager -eq '') {
        New-ADUser -Name $_."Login Name" `
                   -SamAccountName $_."Login Name" `
                   -GivenName $_."First Name" `
                   -Surname $_."Last Name" `
                   -DisplayName $DisplayName `
                   -Title $_.'Job Title "Rank"' `
                   -Department $_.Department `
                   -Path "CN=Users,DC=enterprise,DC=io" `
                   -Enabled $true `
                   -AccountPassword (ConvertTo-SecureString -AsPlainText "Pa55w0rd" -Force)
    } Else {
        New-ADUser -Name $_."Login Name" `
                   -SamAccountName $_."Login Name" `
                   -GivenName $_."First Name" `
                   -Surname $_."Last Name" `
                   -DisplayName $DisplayName `
                   -Title $_.'Job Title "Rank"' `
                   -Manager $_.Manager `
                   -Department $_.Department `
                   -Path "CN=Users,DC=enterprise,DC=io" `
                   -Enabled $true `
                   -AccountPassword (ConvertTo-SecureString -AsPlainText "Pa55w0rd" -Force)
    }

    # Sort user into OU
    If ($_."Uniform Color OU" -eq "GOLD") {
        Get-ADUser $_."Login Name" | Move-ADObject -TargetPath $gold.DistinguishedName
        }
    If ($_."Uniform Color OU" -eq "BLUE") {
        Get-ADUser $_."Login Name" | Move-ADObject -TargetPath $blue.DistinguishedName
        }
    If ($_."Uniform Color OU" -eq "RED") {
        Get-ADUser $_."Login Name" | Move-ADObject -TargetPath $red.DistinguishedName
        }

    # Sort user into groups
    If ($_.DomainUsers -eq "YES") {
        Add-ADGroupMember $domain_users $_."Login Name"
        }
    If ($_.EnterpriseAdmin -eq "YES") {
        Add-ADGroupMember $ent_admin $_."Login Name"
        }
    If ($_.DomainAdmin -eq "YES") {
        Add-ADGroupMember $domain_admin $_."Login Name"
        }
    If ($_.BridgeSquad -eq "YES") {
        Add-ADGroupMember $bridge_squad $_."Login Name"
        }
    If ($_.DisposableUnits -eq "YES") {
        Add-ADGroupMember $disposable $_."Login Name"
        }
    If ($_."1WayMission" -eq "YES") {
        Add-ADGroupMember $1way $_."Login Name"
        }
    If ($_."5YearMission" -eq "YES") {
        Add-ADGroupMember $5year $_."Login Name"
        }
}
Import-Module ActiveDirectory

# Initialize domain path
$domain_cn = "dc=westeros,dc=net"

# Initialize organizational unit paths 
$sccm_ou = "OU=SCCM," + $domain_cn
$child_ous = "Users","Computers","Service Accounts","Security Groups"

# Create organizational units
New-ADOrganizationalUnit -Name "SCCM"
for ($item in $child_ous) {
    New-ADOrganizationalUnit -Name $item -Path $sccm_ou
}

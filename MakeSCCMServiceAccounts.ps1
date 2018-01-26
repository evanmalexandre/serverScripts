# Run as Domain Admin on SCCM site server

Import-Module ActiveDirectory

# Initialize domain name
$domain_name = "westeros.net"
$sql_service_path = "SQLService." + $domain_name
$network_access__path = "NetworkAccess." + $domain_name

# Add KDS root key
Add-KDSRootKey -EffectiveTime ((Get-Date).AddHours(-10))

# Create the new managed service accounts
New-ADServiceAccount SQLService -DnsHostName $sql_service_path -Enabled $True
New-ADServiceAccount NetworkAccess -DnsHostName $network_access_path -Enabled $True

# 

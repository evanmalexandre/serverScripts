# Set variables


# Set IP Address
New-NetIPAddress -InterfaceAlias "Ethernet" `
                 -IPAddress 10.0.0.1 `
                 -PrefixLength 24 `
                 -DefaultGateway 10.0.0.1
Set-DnsClientServerAddress -InterfaceAlias "Ethernet" -ServerAddresses 10.0.0.1

# Set Hostname
Rename-Computer NCC-1701-EMA -Restart

# Install Active Directory
Install-WindowsFeature -name AD-Domain-Services

# Install AD forest
Install-ADDSForest -DomainName enterprise.io

# Install and configure DHCP
Install-WindowsFeature -Name DHCP
netsh dhcp add securitygroups
Set-ItemProperty -Path registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\ServerManager\Roles\12 -Name ConfigurationState -Value 2
Set-DhcpServerv4DnsSetting -ComputerName "NCC-1701-EMA.enterprise.io" -DynamicUpdates "Always" -DeleteDnsRRonLeaseExpiry $True
$Cred = Get-Credential
Set-DhcpServerDnsCredential -Credential $Cred -ComputerName "NCC-1701-EMA.enterprise.io"
Set-DhcpServerv4Binding -BindingState $true `
                        -InterfaceAlias "Ethernet"
Add-DhcpServerInDC -DnsName "NCC-1701-EMA.enterprise.io"
Add-DhcpServerv4Scope -Name "Computer Scope" `
                      -StartRange 10.0.0.100 `
                      -EndRange 10.0.0.200 `
                      -SubnetMask 255.255.255.0 `
                      -State Active


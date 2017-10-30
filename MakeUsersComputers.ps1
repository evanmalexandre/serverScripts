#Import CSVs
$ent_users = Import-CSV 'D:\Enteprise.io AD Roster - Users.csv'
$ent_computers = Import-CSV 'D:\Enteprise.io AD Roster - Computers.csv'

# Establish top-level OUs
New-ADOrganizationalUnit -Name "01_COMPUTERS_BY_DECK"
New-ADOrganizationalUnit -Name "011_COMPUTER_SECURITY_GROUPS"
New-ADOrganizationalUnit -Name "02_USERS_BY_UNIFORM_COLOR"
New-ADOrganizationalUnit -Name "022_USER_SECURITY_GROUPS"

# Create Computer Deck OUs
New-ADOrganizationalUnit -Name "1_BRIDGE" -Path "OU=01_COMPUTERS_BY_DECK,dc=enterprise,dc=io"
New-ADOrganizationalUnit -Name "2_GUEST" -Path "OU=01_COMPUTERS_BY_DECK,dc=enterprise,dc=io"
New-ADOrganizationalUnit -Name "3_ENG" -Path "OU=01_COMPUTERS_BY_DECK,dc=enterprise,dc=io"
New-ADOrganizationalUnit -Name "4_TRANSPORTER" -Path "OU=01_COMPUTERS_BY_DECK,dc=enterprise,dc=io"
New-ADOrganizationalUnit -Name "5_CREW" -Path "OU=01_COMPUTERS_BY_DECK,dc=enterprise,dc=io"

# Create Color OUs
New-ADOrganizationalUnit -Name "GOLD" -Path "OU=02_USERS_BY_UNIFORM_COLOR,DC=enterprise,DC=io"
New-ADOrganizationalUnit -Name "BLUE" -Path "OU=02_USERS_BY_UNIFORM_COLOR,DC=enterprise,DC=io"
New-ADOrganizationalUnit -Name "RED" -Path "OU=02_USERS_BY_UNIFORM_COLOR,DC=enterprise,DC=io"

# Create User Security Groups
New-ADOrganizationalUnit -Name "BridgeSquad" -Path "OU=022_USER_SECURITY_GROUPS,DC=enterprise,DC=io"
New-ADOrganizationalUnit -Name "DisposableUnits" -Path "OU=022_USER_SECURITY_GROUPS,DC=enterprise,DC=io"
New-ADOrganizationalUnit -Name "1WayMission" -Path "OU=022_USER_SECURITY_GROUPS,DC=enterprise,DC=io"
New-ADOrganizationalUnit -Name "5YearMission" -Path "OU=022_USER_SECURITY_GROUPS,DC=enterprise,DC=io"
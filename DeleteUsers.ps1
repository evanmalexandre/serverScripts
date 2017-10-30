# Import users.csv into powershell
$ent_users = Import-Csv 'D:\Enteprise.io AD Roster - Users.csv'

$ent_users | ForEach-Object {
    Remove-ADUser -Identity $_."Login Name" -Force
}
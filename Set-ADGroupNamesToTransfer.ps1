$cred = Get-Credential
# Get the groups to modify from a CSV file
$groups = Get-Content "G:\My Drive\OAK\ADInfo\ADGroups\SecurityGroupsToTransfer.csv"

# Loop through the group list, save the new group name to $newName, get the group from AD, and rename
foreach ($group in $groups)
{
    $newName = "G_OAK_$group"
    $grp = Get-ADGroup -Server 10.1.6.20 -Credential $cred -Identity $group 
    Rename-ADObject -Server 10.1.6.20 -Credential $cred -Identity $grp.ObjectGUID -NewName $newName
}
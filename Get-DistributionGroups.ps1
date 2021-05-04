$cred = Get-Credential
$groups = Get-Content -Path "G:\My Drive\OAK\ADInfo\GroupsToTransfer.csv"
$secGroups = New-Object System.Collections.Generic.List[string]
$distGroups = New-Object System.Collections.Generic.List[string]

# Check the group type. Save security groups to one CSV file, distribution groups to another
foreach ($group in $groups)
{
    $gp = Get-ADGroup -Server 10.1.6.20 -Credential $cred -Identity $group
    
    if ($gp.GroupCategory -eq "Security")
    {
        $secGroups.Add($group)
    }
    elseif ($gp.GroupCategory -eq "Distribution") 
    {
        $distGroups.Add($group)    
    }
    else 
    {
        # This should never happen
        Write-Host "$group is unknown type " $gp.GroupCategory
    }

    $secGroups | Out-File -Path "G:\My Drive\OAK\ADInfo\SecurityGroupsToTransfer.csv"
    $distGroups | Out-File -Path "G:\My Drive\OAK\ADInfo\DistributionGroupsToTransfer.csv"
}

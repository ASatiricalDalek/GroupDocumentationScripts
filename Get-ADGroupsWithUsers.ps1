# Get all the AD Groups from Oak Park DC (10.1.6.20)
$names = Get-ADGroup -Filter * -Server 10.1.6.20 | Select-Object 'name'
$groups = New-Object System.Collections.Generic.List[string]
foreach($name in $names)
{

    try 
    {   
        # Get members of the group if there is at least one member in a group...
        if ((Get-ADGroupMember -Server 10.1.6.20 -Identity $name.Name).Length -ge 1)
        {
            # ...Add it to the list to be exported
            $groups.Add($name.Name)
        }
        else 
        {   
            #Otherwise, write to the console that this is an empty group (unecessary mostly for debug)
            Write-Host "Empty Group"
        }    
    }
    catch 
    {
        # Attempt to write out the group name along with error message if issues arise
        Write-Host $name + " " + $Error[0]
    }
    
}
# As written, this must be run from a computer on the domain you wish to query (IE, does not work across trust)
$reports = New-Object System.Collections.Generic.List[xml]
$linkedGPOs = New-Object System.Collections.Generic.List[string] 
$GPOs = Get-GPO -All 

foreach ($gpo in $GPOs)
{
    # Grab reports for all the GPOs and save them in XML format
    [xml]$placeholderReport = Get-GPOReport -Name $gpo.DisplayName -ReportType XML
    # Append reports to a list
    $reports.Add($placeholderReport)
}

foreach ($report in $reports)
{
    # Check the "LinksTo" field of the report to see if this GPO is actually in use...
    if ($report.GPO.LinksTo) 
    {
        #... If so, add it to the list
        $linkedGPOs.Add($report.GPO.Name)
    }
}

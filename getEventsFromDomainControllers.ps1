$eventLogID = Read-Host -Prompt 'Input the Event Log ID '
$firstNumber = Read-Host -Prompt 'Provide a # to limit the number of event logs returned '
$saveLocation = Read-Host -Prompt 'Provide a filename/path to save the results, it must be a CSV.  (Ex: C:\EventLogs.csv) '
$enterLogName = Read-Host -Prompt 'Enter a log name.  (Ex: directory service or application) '

$DCs=Get-ADDomainController -filter *

foreach ($DC in $DCs)
{
write-host $DC.hostname
get-winevent -computername $DC -logname $enterLogName | Where id -like $eventLogID | Sort TimeCreated -desc | Select MachineName,TimeCreated,ID,Message -First $firstNumber | Export-CSV $saveLocation -append
} 

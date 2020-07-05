$path = " sciezka do CSV domeny_s.csv"
$csv = Import-Csv -path $path -Delimiter ";" 

foreach($line in $csv)
{ 
    $properties = $line | Get-Member -MemberType Properties
    for($i=0; $i -lt $properties.Count-3;$i++)
    {
       $columnvalue = $line | Select-Object -ExpandProperty remote

       $domena = $columnvalue
       $nazwa = $columnvalue.Substring(0,$columnvalue.IndexOf("."))
              
       New-RemoteDomain -Name $nazwa -DomainName $domena
       Set-RemoteDomain -Identity $nazwa -CharacterSet iso-8859-1
       Set-RemoteDomain -Identity $nazwa -NonMimeCharacterSet iso-8859-1

       Set-RemoteDomain $nazwa -IsInternal $true
        
    }
} 
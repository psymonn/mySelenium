$Driver = Start-SeFirefox 
Enter-SeUrl https://www.poshud.com -Driver $Driver


$Driver = Start-SeFirefox 
Enter-SeUrl https://www.poshud.com -Driver $Driver
$Element = Find-SeElement -Driver $Driver -Id "myControl"


$Driver = Start-SeFirefox 
Enter-SeUrl https://www.poshud.com -Driver $Driver
$Element = Find-SeElement -Driver $Driver -Id "btnSend"
Invoke-SeClick -Element $Element



$Driver = Start-SeFirefox 
Enter-SeUrl https://www.poshud.com -Driver $Driver
$Element = Find-SeElement -Driver $Driver -Id "txtEmail"
Send-SeKeys -Element $Element -Keys "adam@poshtools.com"


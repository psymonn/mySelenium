[CmdletBinding()]
param (
    [Parameter(Mandatory=$true)]
    [String]$browser,
    [String]$source
 )
 
 Try {
 
     Write-verbose "Executing Pester tests"
                          
     Invoke-Pester -verbose -OutputFile ${browser}.xml  -OutputFormat NUnitXml -EnableExit -Script @{ Path = $source; Parameters = @{browser = $browser;};}
        
 }
 Catch {
    Exit 1
 }
 
[CmdletBinding()]
param (
    [Parameter(Mandatory=$true)]
    [String]$IISSite,
    [String]$source,
    [String]$outFile
 )
 
 Try {
 
     Write-verbose "Executing Pester tests"
                          
     Invoke-Pester -verbose -OutputFile $outFile -OutputFormat NUnitXml -EnableExit -Script @{ Path = $source; Parameters = @{IISSite = $IISSite;};}
        
 }
 Catch {
    Exit 1
 }
 
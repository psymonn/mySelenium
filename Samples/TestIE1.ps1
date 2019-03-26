# Load the Selenium .Net library
Add-Type -Path "C:\Data\Git\Selenium\lib\WebDriver.dll" # put your DLL on a local hard drive!
 
# Set the PATH to ensure IEDriverServer.exe can found
$env:PATH += ";C:\Data\Git\Selenium\lib"
 
# Instantiate Internet Explorer
$ie_object = New-Object OpenQA.Selenium.IE.InternetExplorerDriver
$ie_object.Navigate().GoToURL( "http://www.bbc.co.uk/languages" )
$link = $ie_object.FindElementByLinkText( "Spanish" )
$link.Click()
 
# display current URL
$ie_object.Url
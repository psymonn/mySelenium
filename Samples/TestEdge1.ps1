# Load the Selenium .Net library
Add-Type -Path "F:\Data\Git\Selenium\lib40\\WebDriver.dll" # put your DLL on a local hard drive!

# Set the PATH to ensure IEDriverServer.exe can found
$env:PATH += ";F:\Data\Git\Selenium\lib40\"

# Instantiate Internet Explorer
#$ie_object = New-Object OpenQA.Selenium.Edge.EdgeDriver("C:\Data\Git\Selenium\lib2\net40");
$ie_object = New-Object OpenQA.Selenium.Edge.EdgeDriver
$ie_object.Navigate().GoToURL( "http://www.bbc.co.uk/languages" )
$link = $ie_object.FindElementByLinkText( "Spanish" )
$link.Click()

# display current URL
$ie_object.Url

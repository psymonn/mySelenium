# Website and credential variables
$YourURL = "https://www.google.com" # Website we'll access

# Invoke Selenium into our script!
$env:PATH += ";C:\Data\Git\Selenium\lib" # Adds the path for ChromeDriver.exe to the environmental variable
Add-Type -Path "C:\Data\Git\Selenium\lib\WebDriver.dll" # Adding Selenium's .NET assembly (dll) to access it's classes in this PowerShell session
$ChromeDriver = New-Object OpenQA.Selenium.Chrome.ChromeDriver # Creates an instance of this class to control Selenium and stores it in an easy to handle variable

# Make use of Selenium's class methods to manage our browser at will
#$ChromeDriver.Navigate().GoToURL($YourURL) # Browse to the specified website
$ChromeDriver.Url ="file:\\\F:\Data\Git\Selenium\GoogleSearchResults.html"

$ChromeDriver.FindElementByName("q").SendKeys("mavericksevmont tech blog") # Methods to find the input textbox for google search and then to type something in it
$ChromeDriver.FindElementByName("btnK").Submit() # Method to submit request to the button
#$ChromeDriver.PageSource | Out-File "C:\Data\Git\Selenium\GoogleSearchResults.html" -Force

# Cleaning up after ourselves!
Pause
Function Stop-ChromeDriver {Get-Process -Name chromedriver -ErrorAction SilentlyContinue | Stop-Process -ErrorAction SilentlyContinue}
$ChromeDriver.Close() # Close selenium browser session method
$ChromeDriver.Quit() # End ChromeDriver process method
Stop-ChromeDriver # Function to make double sure the Chromedriver process is finito (double-tap!)

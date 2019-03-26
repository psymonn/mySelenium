# Website and credential variables
$YourURL = "https://www.linkedin.com/uas/login" # Website we'll log to
$PSCred = Get-Credential -Message 'Enter Username and Password' # Get credentials for login page

# Invoke Selenium into our script!
$env:PATH += ";C:\Data\Git\Selenium\lib" # Adds the path for ChromeDriver.exe to the environmental variable 
Add-Type -Path "C:\Data\Git\Selenium\lib\WebDriver.dll" # Adding Selenium's .NET assembly (dll) to access it's classes in this PowerShell session
$ChromeDriver = New-Object OpenQA.Selenium.Chrome.ChromeDriver # Creates an instance of this class to control Selenium and stores it in an easy to handle variable

# Make use of Selenium's class methods to manage our browser at will
$ChromeDriver.Navigate().GoToURL($YourURL) # Browse to the specified website
$ChromeDriver.FindElementByName("session_key").SendKeys($PSCred.Username) # Methods to find the input textbox for the username and type it into the textbox
$ChromeDriver.FindElementByName("session_password").SendKeys($PSCred.GetNetworkCredential().password) # Methods to find the input textbox for the password and type it into the textbox
$ChromeDriver.FindElementByName("session_password").Submit() # We are submitting this info to linkedin for login # From the same textbox, submit this information to Linkedin for logging in

# Cleaning up after ourselves!
Pause # Adding a stop, after pressing enter within the console the Selenium session will end everything will be closed
Remove-Variable -Name PSCred # This removes the stored user/password from within the $PSCred variable
Function Stop-ChromeDriver {Get-Process -Name chromedriver -ErrorAction SilentlyContinue | Stop-Process -ErrorAction SilentlyContinue}
$ChromeDriver.Close() # Close selenium browser session method
$ChromeDriver.Quit() # End ChromeDriver process method
Stop-ChromeDriver # Function to make sure Chromedriver process is ended (double-tap!)
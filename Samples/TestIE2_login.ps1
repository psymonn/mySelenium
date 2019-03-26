$WebDriverPath = Resolve-Path "$PSScriptRoot\lib\WebDriver.dll"
#I unblock it because when you download a DLL from a remote source it is often blocked by default
Unblock-File $WebDriverPath
Add-Type -Path $WebDriverPath

$WebDriverSupportPath = Resolve-Path "$PSScriptRoot\lib\WebDriver.Support.dll"
Unblock-File $WebDriverSupportPath
Add-Type -Path $WebDriverSupportPath

#before we start, we must ensure all zones are running either in protected mode, or not.  They need to all be the same.
#(we might be able to negate the requirement for some of these using InternetExplorerOptions.IntroduceInstabilityByIgnoringProtectedModeSettings)

#set protected
#local
New-ItemProperty "hkcu:\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\0" -Name "2500" -Value 0 -PropertyType DWORD -Force | Out-Null
#internet
New-ItemProperty "hkcu:\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1" -Name "2500" -Value 0 -PropertyType DWORD -Force | Out-Null
#intranet
New-ItemProperty "hkcu:\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" -Name "2500" -Value 0 -PropertyType DWORD -Force | Out-Null
#trusted
New-ItemProperty "hkcu:\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3" -Name "2500" -Value 0 -PropertyType DWORD -Force | Out-Null
#restricted
New-ItemProperty "hkcu:\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\4" -Name "2500" -Value 0 -PropertyType DWORD -Force | Out-Null

#fix to run in kiosk mode (to use ForceCreateProcessApi this must be 0. ForceCreateProcessApi is required to use BrowserCommandLineArguments)
New-ItemProperty "hkcu:\Software\Microsoft\Internet Explorer\Main" -Name "TabProcGrowth" -Value 0 -PropertyType DWORD -Force | Out-Null

#Set zoom 100%.  Again, we can probably use InternetExplorerOptions.IgnoreZoomSetting as an alternative
#New-ItemProperty "hkcu:\Software\Microsoft\Internet Explorer\Zoom" -Name "ZoomFactor" -Value 50000 -PropertyType DWORD -Force | Out-Null
New-ItemProperty "hkcu:\Software\Microsoft\Internet Explorer\Zoom" -Name "ZoomFactor" -Value 100000 -PropertyType DWORD -Force | Out-Null

#can pass this stuff in when we instantiate driver if needs be (if we want a chromeless browser for example)
$seleniumOptions = New-Object OpenQA.Selenium.IE.InternetExplorerOptions
#open this URL when Internet Explorer launches
$seleniumOptions.InitialBrowserUrl = "https://www.linkedin.com/uas/login";
#we require this option to run in kiosk mode
$seleniumOptions.ForceCreateProcessApi = $true
#open Internet Explorer in kiosk mode
#$seleniumOptions.BrowserCommandLineArguments = "-k"
#untested - ignore zoom options, negating the registry fix above
#$seleniumOptions.IgnoreZoomSetting = $true

#now we create a default service so we can run Selenium without the black debug command prompt appearing
#pre-PowerShell 5 we can do it like so
New-Variable -Name IEDS -Value ([OpenQA.Selenium.IE.InternetExplorerDriverService]) -Force
$defaultservice = $IEDS::CreateDefaultService()

#PowerShell 5 we can do it like so
#$defaultservice = [OpenQA.Selenium.IE.InternetExplorerDriverService]::CreateDefaultService()

#hide command prompt
$defaultservice.HideCommandPromptWindow = $true;

#provide our default service and selenium options to the Internett Explorer driver (calling this opens the IE session)
$seleniumDriver = New-Object OpenQA.Selenium.IE.InternetExplorerDriver -ArgumentList @($defaultservice, $seleniumOptions)

#now we start clicking elements on the web page.  We do this by finding the ID of the element we want to interact with.

#enter a username into login prompt
$seleniumWait = New-Object -TypeName OpenQA.Selenium.Support.UI.WebDriverWait($seleniumDriver, (New-TimeSpan -Seconds 10))
$seleniumWait.Until([OpenQA.Selenium.Support.UI.ExpectedConditions]::ElementIsVisible([OpenQA.Selenium.By]::Name("session_key")))
$seleniumDriver.FindElementByName("session_key").SendKeys("exampleusernname")

#enter a password into login prompt
$seleniumWait = New-Object -TypeName OpenQA.Selenium.Support.UI.WebDriverWait($seleniumDriver, (New-TimeSpan -Seconds 10))
$seleniumWait.Until([OpenQA.Selenium.Support.UI.ExpectedConditions]::ElementIsVisible([OpenQA.Selenium.By]::Name("session_password")))
$seleniumDriver.FindElementByName("session_password").SendKeys("examplepassword")

#click 'login' button
$seleniumWait = New-Object -TypeName OpenQA.Selenium.Support.UI.WebDriverWait($seleniumDriver, (New-TimeSpan -Seconds 10))
$seleniumWait.Until([OpenQA.Selenium.Support.UI.ExpectedConditions]::ElementIsVisible([OpenQA.Selenium.By]::Name("session_password")))
#$seleniumDriver.FindElementById("loginButton").Click()
$seleniumDriver.FindElementByName("session_password").Submit() # We are submitting this info to linkedin for login # From the same textbox, submit this information to Linkedin for logging in

#when logged in, click another button
#$seleniumWait = New-Object -TypeName OpenQA.Selenium.Support.UI.WebDriverWait($seleniumDriver, (New-TimeSpan -Seconds 10))
#$seleniumWait.Until([OpenQA.Selenium.Support.UI.ExpectedConditions]::ElementIsVisible([OpenQA.Selenium.By]::Id("button-1025")))
#$seleniumDriver.FindElementById("random_button").Click()

#we don't close it in this instance because we want to keep the browser open as a dashboard view
$seleniumDriver.Close()
$seleniumDriver.Dispose()
$seleniumDriver.Quit()

#Code Start Here :

# moving to the folder where Selenium DLL files are…
# You can also use Add-Type Cmdlet with -path option, it will do the same.

#cd "d:\NonOfficialPSModules\selenium-dotnet-2.46.0\net40"
#[System.Reflection.Assembly]::LoadFrom("$PSScriptRoot\lib2\net40\WebDriver.dll\Selenium.WebDriverBackedSelenium.dll")
#[System.Reflection.Assembly]::LoadFrom("$PSScriptRoot\lib2\net40\ThoughtWorks.Selenium.Core.dll")
[System.Reflection.Assembly]::LoadFrom("$PSScriptRoot\lib2\net40\WebDriver.dll")
[System.Reflection.Assembly]::LoadFrom("$PSScriptRoot\lib2\net40\WebDriver.Support.dll")


# calling the Browser Driver, in this case I am using FireFox
$dr = New-Object "OpenQA.Selenium.FireFox.FirefoxDriver"

$actions = New-Object  OpenQA.Selenium.Interactions.Actions($dr)
# Using Facebook as a test

$dr.url = "https://www.facebook.com/"

# Pausing for sometime to allow the browser to load all the elements inside
# The web Page.
Start-Sleep -Seconds 20

# I am using .NET's Windows Forms here to send two TABs (TAB clicks)
# because when the browser start, the cursor will point to the address bar,
# To move the cursor inside the browser itself I am pressing TAB two times to
# Make sure that the cursor is moved on one of the web elements this will make
# sure that the cursor will move to the correct element later.
[System.Windows.Forms.SendKeys]::SendWait("{TAB}") | out-null
[System.Windows.Forms.SendKeys]::SendWait("{TAB}") | out-null

#Looking for the element, in my case, it's the checkbox
# the one near the label : keep me logged in

#$MyElement = $dr.FindElementByXpath("//*[@class='uiInputLabelInput uiInputLabelCheckbox']")
$MyElement = $dr.FindElementByXpath('//*[@id="u_0_a"]')

# This "if" statement will check if the above variable is true (Means the object
# was found)
if ($MyElement){
Write-Host "found it.."
# This is just some information, you can comment this if you want
$actions.GetHashCode()
$actions.GetType()

# This is the main thing here, it will take the focus from any element in the
# page and move it to the checkbox than simply click the check box to check it.
$actions.MoveToElement($MyElement).Click().Perform()
# sleeping for sometime will allow you to see the changes
Start-Sleep -Seconds 10
#Close the browser and finish the code.
$dr.Close()
}

# in case the element was not found it will show a message and simply close the
# browser
if (! $MyElement){
Write-Host "Element Not found..Check your Reff Again.."
#Close the browser and finish the code.
Start-Sleep -Seconds 10
$dr.Close()

}
#Code End Here.

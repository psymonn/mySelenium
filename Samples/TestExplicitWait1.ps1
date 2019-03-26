#load the web driver dll
Add-Type -path $PSScriptRoot\lib\WebDriver.dll
#initiate a driver
$script:driver = New-Object OpenQA.Selenium.Chrome.ChromeDriver
#specify an implicit wait interval
$null = $driver.Manage().Timeouts().ImplicitlyWait((New-TimeSpan -Seconds 5))
#browse to a website
$driver.Url = 'https://www.google.com'
$driver.FindElementByName('q')
#potential error message if element hasn't been loaded yet
$driver.Close()
$driver.Dispose()
$driver.Quit()


function isElementPresent($locator,[switch]$byClass,[switch]$byName){
    try{
        if($byClass){
            $null=$script:driver.FindElementByClassName($locator)
        }
        elseif($byName){
            $null=$script:driver.FindElementByName($locator)
        }
        else{
            $null=$script:driver.FindElementById($locator)
        }
        return $true
    }
    catch{
        return $false
    }
}



function waitForElement($locator, $timeInSeconds,[switch]$byClass,[switch]$byName){
    #this requires the WebDriver.Support.dll in addition to the WebDriver.dll
    Add-Type -Path $PSScriptRoot\lib\WebDriver.Support.dll
    $webDriverWait = New-Object OpenQA.Selenium.Support.UI.WebDriverWait($script:driver, $timeInSeconds)
    try{
        if($byClass){
            $null = $webDriverWait.Until([OpenQA.Selenium.Support.UI.ExpectedConditions]::ElementIsVisible( [OpenQA.Selenium.by]::ClassName($locator)))
        }
        elseif($byName){
            $null = $webDriverWait.Until([OpenQA.Selenium.Support.UI.ExpectedConditions]::ElementIsVisible( [OpenQA.Selenium.by]::Name($locator)))
        }
        else{
            $null = $webDriverWait.Until([OpenQA.Selenium.Support.UI.ExpectedConditions]::ElementIsVisible( [OpenQA.Selenium.by]::Id($locator)))
        }
        return $true
    }
    catch{
        return "Wait for $locator timed out"
    }
}



while(!(isElementPresent 'q' -byName)){
    sleep 1
}
$driver.FindElementByName('q')

# or

waitForElement 'q' 10 -byName

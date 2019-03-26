#This causes the driver to wait up to 10 seconds (this can be adjusted at object creation as well as after) for the specified element to fulfill the condition to be fulfilled.
# By default it checks every 500 milliseconds (which I believe can also be changed). If the time limit goes and it doesn't find an element to fulfill it, 
#it throws a timeout error. There are a few different conditions and all the normal find element by options that you can use.

$driver = New-Object OpenQA.Selenium.Chrome.Chromedriver
$driverWait = New-Object -TypeName OpenQA.Selenium.Support.UI.WebDriverWait($driver, (New-TimeSpan -Seconds 10))
$driverWait.Until([OpenQA.Selenium.Support.UI.ExpectedConditions]::ElementIsVisible([OpenQA.Selenium.By]::CssSelector("body")))

#Another class that may be useful to use is the keys class that lets you send non-traditional characters like the shift key or the ctrl key.
$key = [OpenQa.Selenium.Keys]
$element.SendKeys($key::ENTER)

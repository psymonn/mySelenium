$WebDriverPath = Resolve-Path "$PSScriptRoot\lib\WebDriver.dll"
#I unblock it because when you download a DLL from a remote source it is often blocked by default
Unblock-File $WebDriverPath
Add-Type -Path $WebDriverPath
 
$WebDriverSupportPath = Resolve-Path "$PSScriptRoot\lib\WebDriver.Support.dll"
Unblock-File $WebDriverSupportPath
Add-Type -Path $WebDriverSupportPath

$Credential = Get-Credential -Message 'Enter Username and Password' # Get credentials for login page

$Selenium = New-Object OpenQA.Selenium.Chrome.ChromeDriver # Creates an instance of this class to control Selenium and stores it in an easy to handle variable

# TODO: See if it's enough to just go to login.live.com
$msdn = "https://login.live.com/login.srf?wa=wsignin1.0&wreply=https%3a%2f%2fmsdn.microsoft.com%2fen-us%2fsubscriptions%2fdownloads%2f"

$Selenium.Navigate().GoToUrl($msdn)

Start-Sleep 1
# Sometimes it remembers my name
if(($name = $Selenium.FindElementByCssSelector('input[type="email"]')) -and $name.Displayed) {
    Write-Verbose "Sending UserName"
    $name.SendKeys($Credential.UserName)
}

# But if the password box isn't there, we were probably already logged in
$pass = $Selenium.FindElementByCssSelector('input[type="password"]')
$pass.Clear() # sometimes it's pre-populated if your browser stores it...
$pass.SendKeys($Credential.GetNetworkCredential().Password) 

$send = $Selenium.FindElementByCssSelector('input[type="submit"]')
$send.Submit()

$count = 0
while($Selenium.Url -notmatch "^https://msdn.microsoft.com/.*/downloads/") {
    Start-Sleep -milli 500
    if(2 -lt $count++) {
        if($Selenium.Url.StartsWith("https://login.live.com/ppsecure/post.srf")) {
            if($otc = $Selenium.FindElementByCssSelector('input[name="otc"]')) {
                $code = Read-Host "We need your 2FA one-time code"
                $otc.SendKeys($code)
                $otc.Submit()
            }
            break
        } else {
            Write-Warning "We don't seem to have arrived at the downloads page. Current Url: $($Selenium.Url)"
            break
        } 
    }
}
if($Selenium.Url.StartsWith("https://login.live.com/ppsecure/post.srf")) {
    if($otc = $Selenium.FindElementByCssSelector('input[name="otc"]')) {
        $code = Read-Host "We need your 2FA one-time code"
        $otc.SendKeys($code)
        $otc.Submit()
    }
}

if($Selenium.Manage().Cookies.AllCookies.Count -eq 0) {
    throw "Couldn't get authentication cookie from $Browser"
}

# Precreate a session object
$response  = Invoke-WebRequest login.live.com -SessionVariable Jar
# Fill it with nice warm cookies (ignoring expiration dates)
$Selenium.Manage().Cookies.AllCookies | Select-Object Name, Value, Domain, Secure | % { $Jar.Cookies.Add([Net.Cookie]$_) }
# Trade it for the MSDN keys
[xml](Microsoft.PowerShell.Utility\Invoke-WebRequest https://msdn.microsoft.com/en-us/subscriptions/securejson/getallexportkeys?brand=msdn -WebSession $Jar).Content

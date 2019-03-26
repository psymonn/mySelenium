param(
  [string]$browser="chrome"
)

#$shared_assemblies = @(
#  'WebDriver.dll',
# 'WebDriver.Support.dll',
#  'Selenium.WebDriverBackedSelenium.dll',
#  'nunit.core.dll',
#  'nunit.framework.dll'
#)

$shared_assemblies = @(
  'WebDriver.dll',
  'WebDriver.Support.dll',
  'Selenium.WebDriverBackedSelenium.dll',
  'ThoughtWorks.Selenium.Core.dll'
  
)

$shared_assemblies_path = 'C:\Data\Git\Selenium\lib2\net40\'

if (($env:SHARED_ASSEMBLIES_PATH -ne $null) -and ($env:SHARED_ASSEMBLIES_PATH -ne '')) {
  $shared_assemblies_path = $env:SHARED_ASSEMBLIES_PATH
}

pushd $shared_assemblies_path
$shared_assemblies | ForEach-Object {

  if ($host.Version.Major -gt 2) {
    Unblock-File -Path $_;
  }
  Write-Debug $_
  Add-Type -Path $_
}
popd


$env:SHARED_ASSEMBLIES_PATH = 'C:\Data\Git\Selenium\lib2\net40\'

$shared_assemblies_path = $env:SHARED_ASSEMBLIES_PATH

pushd $shared_assemblies_path
$shared_assemblies | ForEach-Object { Unblock-File -Path $_; Add-Type -Path $_ }
popd

# Convertfrom-JSON applies To: Windows PowerShell 3.0 and above
[NUnit.Framework.Assert]::IsTrue($host.Version.Major -gt 2)


# http://stackoverflow.com/questions/15767066/get-session-id-for-a-selenium-remotewebdriver-in-c-sharp
Add-Type -TypeDefinition @"
using System;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;
using OpenQA.Selenium.Support.UI;
public class CustomeRemoteDriver : RemoteWebDriver
{
    // OpenQA.Selenium.WebDriver  ?
    public CustomeRemoteDriver(ICapabilities desiredCapabilities)
        : base(desiredCapabilities)
    {
    }
    public CustomeRemoteDriver(ICommandExecutor commandExecutor, ICapabilities desiredCapabilities)
        : base(commandExecutor, desiredCapabilities)
    {
    }
    public CustomeRemoteDriver(Uri remoteAddress, ICapabilities desiredCapabilities)
        : base(remoteAddress, desiredCapabilities)
    {
    }
    public CustomeRemoteDriver(Uri remoteAddress, ICapabilities desiredCapabilities, TimeSpan commandTimeout)
        : base(remoteAddress, desiredCapabilities, commandTimeout)
    {
    }
    public string GetSessionId()
    {
        return base.SessionId.ToString();
    }
} 
"@ -ReferencedAssemblies 'System.dll',"${shared_assemblies_path}\WebDriver.dll","${shared_assemblies_path}\WebDriver.Support.dll"



try {
  $connection = (New-Object Net.Sockets.TcpClient)
  $connection.Connect('127.0.0.1',4444)
  $connection.Close()
}
catch {
  $selemium_driver_folder = 'c:\java\selenium'
  Start-Process -FilePath 'C:\Windows\System32\cmd.exe' -ArgumentList "start cmd.exe /c ${selemium_driver_folder}\hub.cmd"
  Start-Process -FilePath 'C:\Windows\System32\cmd.exe' -ArgumentList "start cmd.exe /c ${selemium_driver_folder}\node.cmd"
  Start-Sleep 10
}


$hub_host = '127.0.0.1'
$hub_port = '4444'

$uri = [System.Uri](('http://{0}:{1}/wd/hub' -f $hub_host,$hub_port))

if ($browser -ne $null -and $browser -ne '') {
  try {
    $connection = (New-Object Net.Sockets.TcpClient)
    $connection.Connect($hub_host,[int]$hub_port)
    $connection.Close()
  } catch {
    Start-Process -FilePath "C:\Windows\System32\cmd.exe" -ArgumentList "start cmd.exe /c c:\java\selenium\hub.cmd"
    Start-Process -FilePath "C:\Windows\System32\cmd.exe" -ArgumentList "start cmd.exe /c c:\java\selenium\node.cmd"
    Start-Sleep -Seconds 10
  }
  Write-Host "Running on ${browser}"
  if ($browser -match 'firefox') {
    #$capability = [OpenQA.Selenium.Remote.DesiredCapabilities]::Firefox()
    $capability = new-Object OpenQA.Selenium.Remote.DesiredCapabilities -ArgumentList @("firefox","",[OpenQA.Selenium.Platform]::new("windows"))

  }
  elseif ($browser -match 'chrome') {
    #$capability = [OpenQA.Selenium.Remote.DesiredCapabilities]::Chrome()
    $capability = new-Object OpenQA.Selenium.Remote.DesiredCapabilities -ArgumentList @("chrome","",[OpenQA.Selenium.Platform]::new("windows"))
  }
  elseif ($browser -match 'ie') {
    $capability = [OpenQA.Selenium.Remote.DesiredCapabilities]::InternetExplorer()
  }
  elseif ($browser -match 'safari') {
    $capability = [OpenQA.Selenium.Remote.DesiredCapabilities]::Safari()
  }
  else {
    throw "unknown browser choice:${browser}"
  }
  $selenium = New-Object CustomeRemoteDriver ($uri,$capability)
} else {
  # this example 
  # will not work with phantomjs 
  $phantomjs_executable_folder = "c:\tools\phantomjs"
  Write-Host 'Running on phantomjs'
  $selenium = New-Object OpenQA.Selenium.PhantomJS.PhantomJSDriver ($phantomjs_executable_folder)
  $selenium.Capabilities.SetCapability("ssl-protocol","any")
  $selenium.Capabilities.SetCapability("ignore-ssl-errors",$true)
  $selenium.Capabilities.SetCapability("takesScreenshot",$true)
  $selenium.Capabilities.SetCapability("userAgent","Mozilla/5.0 (Windows NT 6.1) AppleWebKit/534.34 (KHTML, like Gecko) PhantomJS/1.9.7 Safari/534.34")
  $options = New-Object OpenQA.Selenium.PhantomJS.PhantomJSOptions
  $options.AddAdditionalCapability("phantomjs.executable.path",$phantomjs_executable_folder)
}


try {
  $sessionid = $selenium.GetSessionId()

} catch [exception]{
  # Method invocation failed because [OpenQA.Selenium.PhantomJS.PhantomJSDriver] doesn't contain a method named 'GetSessionId'.
  $selenium.Quit()
  return

}

[void]$selenium.manage().timeouts().ImplicitlyWait([System.TimeSpan]::FromSeconds(10))
[string]$base_url = $selenium.Url = 'http://www.google.com/';
$selenium.Navigate().GoToUrl($base_url)

[NUnit.Framework.Assert]::IsTrue($sessionid -ne $null)

# https://github.com/davglass/selenium-grid-status/blob/master/lib/index.js
# call TestSessionStatusServlet.java
$sessionURL = ("http://{0}:{1}/grid/api/testsession?session={2}" -f $hub_host,$hub_port,$sessionid)
$req = [System.Net.WebRequest]::Create($sessionURL)
$resp = $req.GetResponse()
$reqstream = $resp.GetResponseStream()
$sr = New-Object System.IO.StreamReader $reqstream
$result = $sr.ReadToEnd()
$session_json_object = ConvertFrom-Json -InputObject $result
$session_json_object | Format-List

$proxyId = $session_json_object.proxyId

# calls ProxyStatusServlet.java
$proxyinfoURL = ('http://{0}:{1}/grid/api/proxy?id={2}' -f $hub_host,$hub_port,$proxyId)

$req = [System.Net.WebRequest]::Create($proxyinfoURL)
$resp = $req.GetResponse()
$reqstream = $resp.GetResponseStream()
$sr = New-Object System.IO.StreamReader $reqstream
$result = $sr.ReadToEnd()

$proxyinfo_json_object = ConvertFrom-Json -InputObject $result
$proxyinfo_json_object | Format-List

$window_handle = $selenium.CurrentWindowHandle

Write-Output ("CurrentWindowHandle = {0}`n" -f $window_handle)

$selenium_capabilities = $selenium.Capabilities
$selenium_capabilities | Format-List

# Cleanup
cleanup ([ref]$selenium)

return
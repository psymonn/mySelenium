param(
  [switch]$browser
)

$shared_assemblies = @(
  'WebDriver.dll',
  'WebDriver.Support.dll',
  'ThoughtWorks.Selenium.Core.dll'
  # 'Selenium.WebDriverBackedSelenium.dll'
  # TODO - resolve dependencies
  #'nunit.core.dll',
  #'nunit.framework.dll'

)
<#
Add-Type : Could not load file or assembly 
'file:///c:\java\selenium\csharp\sharedassemblies\WebDriver.dll' 
or one of its dependencies. This assembly is built by a runtime newer than the currently loaded runtime and cannot be loaded.
Add-Type : Could not load file or assembly 
'file:///c:\java\selenium\csharp\sharedassemblies\nunit.framework.dll' or one of its dependencies. 
Operation is not supported. (Exception from HRESULT: 0x80131515) 
use fixw2k3.ps1
Add-Type : Unable to load one or more of the requested types. Retrieve the LoaderExceptions property for more information.
#>

$env:SHARED_ASSEMBLIES_PATH = "C:\Data\Git\Selenium\lib2\net40\"
#$env:SHARED_ASSEMBLIES_PATH = "C:\Data\Git\Selenium\lib\"

$shared_assemblies_path = $env:SHARED_ASSEMBLIES_PATH
pushd $shared_assemblies_path
$shared_assemblies | ForEach-Object { 
 if ($host.Version.Major -gt 2){
   Unblock-File -Path $_;
 }
 write-output $_
 Add-Type -Path $_ 
 }
popd

$verificationErrors = New-Object System.Text.StringBuilder
# use Default Web Site to host the page. Enable Directory Browsing.
# NOTE: http://stackoverflow.com/questions/25646639/firefox-webdriver-doesnt-work-with-firefox-32

#if ($PSBoundParameters["browser"]) {
  try {
    $connection = (New-Object Net.Sockets.TcpClient)
    $connection.Connect("127.0.0.1",4444)
    $connection.Close()
  } catch {
    Start-Process -FilePath "C:\Windows\System32\cmd.exe" -ArgumentList "start cmd.exe /c c:\java\selenium\hub.cmd"
    Start-Process -FilePath "C:\Windows\System32\cmd.exe" -ArgumentList "start cmd.exe /c c:\java\selenium\node.cmd"
    Start-Sleep -Seconds 10
  }
#  $capability = [OpenQA.Selenium.Remote.DesiredCapabilities]::Firefox()

    ##$ChromeOptions = New-Object OpenQA.Selenium.Chrome.ChromeDriver

        
    #$ChromeOptions = New-Object OpenQA.Selenium.Chrome.ChromeOptions
    #$ChromeOptions.addArguments('headless')
    #$ChromeDriver = New-Object OpenQA.Selenium.Chrome.ChromeDriver($ChromeOptions)

    ##$capability = New-Object OpenQA.Selenium.Remote.DesiredCapabilities
	#$capabilityValue = @("--ignore-certificate-errors; --allow-running-insecure-content; --disable-extensions")
    ##$capabilityValue = @("--ignore-certificate-errors")

	##$capability.SetCapability($ChromeOptions.Capability, $capabilityValue)
    
    #$capability = [OpenQA.Selenium.Remote.DesiredCapabilities]::new("chrome","","Windows");
    #$capability = [OpenQA.Selenium.Remote.DesiredCapabilities]::new()
    




    $capability = [OpenQA.Selenium.Remote.DesiredCapabilities]::Chrome()
  #[NUnit.Framework.Assert]::IsTrue($version_major -lt 32)

#  $capability = [OpenQA.Selenium.Remote.DesiredCapabilities]::InternetExplorer()




Add-Type -TypeDefinition @"
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
"@ -ReferencedAssemblies "${shared_assemblies_path}\WebDriver.dll","${shared_assemblies_path}\WebDriver.Support.dll"




 

#  $phantomjs_executable_folder = "c:\tools\phantomjs"
#  Write-Host 'Running on phantomjs'
  $selenium = New-Object OpenQA.Selenium.Chrome.ChromeDriver

  $selenium.Capabilities.SetCapability("ssl-protocol","any")
  $selenium.Capabilities.SetCapability("ignore-ssl-errors",$true)
  #$selenium.Capabilities.SetCapability("takesScreenshot",$true)
  #$selenium.Capabilities.SetCapability("userAgent","Mozilla/5.0 (Windows NT 6.1) AppleWebKit/534.34 (KHTML, like Gecko) PhantomJS/1.9.7 Safari/534.34")
 # $options = New-Object OpenQA.Selenium.PhantomJS.PhantomJSOptions
 # $options.AddAdditionalCapability("phantomjs.executable.path",$phantomjs_executable_folder)





  $uri = [System.Uri]("http://127.0.0.1:4444/wd/hub")
  #$selenium = New-Object OpenQA.Selenium.Remote.RemoteWebDriver ($uri, $capability)
   $selenium = New-Object CustomeRemoteDriver ($uri,$capability)
  [int] $version_major = [int][math]::Round([double]$selenium.Capabilities.Version ) 
  #  http://stackoverflow.com/questions/25646639/firefox-webdriver-doesnt-work-with-firefox-32
  #[NUnit.Framework.Assert]::IsTrue($version_major -lt 32)
#}

#$base_url = 'file:///C:/developer/sergueik/powershell_ui_samples/external/grid-console.html'
$base_url = 'http://www.google.com/'
$selenium.Navigate().GoToUrl($base_url)
$selenium.Navigate().Refresh()
$selenium.Manage().Window.Maximize()


$selenium.Navigate().Refresh()
$selenium.Manage().Window.Maximize()
[OpenQA.Selenium.Remote.RemoteWebElement]$proxy_id = $selenium.FindElement([OpenQA.Selenium.By]::CssSelector("p[class='proxyid']"))
write-host ( "<<<" + $proxy_id.Text )

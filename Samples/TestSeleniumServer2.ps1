param(
  [switch]$browser
)

$shared_assemblies = @(
  'WebDriver.dll',
  'WebDriver.Support.dll'
  #'ThoughtWorks.Selenium.Core.dll'
   #'Selenium.WebDriverBackedSelenium.dll'
  # TODO - resolve dependencies
  #'nunit.core.dll',
  #'nunit.framework.dll'

)

#>

$env:SHARED_ASSEMBLIES_PATH = "F:\Data\Git\Selenium\lib2\net40\"
#$env:SHARED_ASSEMBLIES_PATH = "F:\Data\Git\Selenium\lib\"
#$env:SHARED_ASSEMBLIES_PATH = "F:\Data\Git\Selenium\lib3\net45"

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

#$capabilities = New-Object OpenQA.Selenium.Remote.DesiredCapabilities -ArgumentList "Chrome", "", "Windows"

#$capabilities = new-Object OpenQA.Selenium.Remote.DesiredCapabilities -ArgumentList @("firefox","2.46.628402",[OpenQA.Selenium.Platform]::new("windows"))
#$capabilities = new-Object OpenQA.Selenium.Remote.DesiredCapabilities -ArgumentList @("ie","",[OpenQA.Selenium.Platform]::new("windows"))
#$capabilities = new-Object OpenQA.Selenium.Remote.DesiredCapabilities -ArgumentList @("chrome","2.46.628402",[OpenQA.Selenium.Platform]::new("Windows"))
#$capabilities = new-Object OpenQA.Selenium.Remote.DesiredCapabilities -ArgumentList @("edge","",[OpenQA.Selenium.Platform]::new("Windows"))
$capabilities = new-Object OpenQA.Selenium.Remote.DesiredCapabilities -ArgumentList @("internetexplorer","",[OpenQA.Selenium.Platform]::new("Windows"))



    #$capability = [OpenQA.Selenium.Remote.DesiredCapabilities]::new("chrome","","Windows");
    #$capabilities = [OpenQA.Selenium.Remote.DesiredCapabilities]::new()
    #$Capabilities.SetCapability([OpenQA.Selenium.PlatformType]::Windows)
    #$Capabilities.SetCapability([OpenQA.Selenium.Chrome.ChromeDriver]::AcceptUntrustedCertificates)
    #$Capabilities.SetCapability([OpenQA.Selenium.Chrome.ChromeDriver])
   # $capabilities.SetCapability("chrome")
   # $capabilities.SetCapability("Windows")


#$capabilities = New-Object OpenQA.Selenium.Remote.DesiredCapabilities


#$options = New-Object OpenQA.Selenium.Chrome.ChromeOptions
$options = New-Object OpenQA.Selenium.IE.InternetExplorerOptions
$options.AddArgument("--enable-extensions")
$options.addArgument("--start-maximized");
$options.addArgument("--disable-new-ntp");
$options.addArgument("--test-type");
#$options.BinaryLocation = "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"
$options.BinaryLocation = "C:\Program Files (x86)\Internet Explorer\iexplore.exe"



#$capabilityValue = @("--ignore-certificate-errors")
#$capability.SetCapability($options.Capability, $capabilityValue)

#$driver1 = New-Object OpenQA.Selenium.Chrome.ChromeDriver($options)
#$driver2 = New-Object OpenQA.Selenium.Chrome.ChromeDriver($chromeDriverDir, $options, 1000)


    #$capability = [OpenQA.Selenium.Remote.DesiredCapabilities]::new()





    #$capability = [OpenQA.Selenium.Remote.DesiredCapabilities]::Chrome()
  #[NUnit.Framework.Assert]::IsTrue($version_major -lt 32)

#  $capability = [OpenQA.Selenium.Remote.DesiredCapabilities]::InternetExplorer()



#  $phantomjs_executable_folder = "c:\tools\phantomjs"
#  Write-Host 'Running on phantomjs'
  #$selenium = New-Object OpenQA.Selenium.Chrome.ChromeDriver

  $Capabilities.SetCapability("ssl-protocol","any")
  $Capabilities.SetCapability("ignore-ssl-errors",$true)
  $Capabilities.SetCapability("takesScreenshot",$true)
 # $Capabilities.SetCapability("browser","Chrome")
 # $Capabilities.SetCapability("platform","Windows")
  #$selenium.Capabilities.SetCapability("userAgent","Mozilla/5.0 (Windows NT 6.1) AppleWebKit/534.34 (KHTML, like Gecko) PhantomJS/1.9.7 Safari/534.34")
 # $options = New-Object OpenQA.Selenium.PhantomJS.PhantomJSOptions
 # $options.AddAdditionalCapability("phantomjs.executable.path",$phantomjs_executable_folder)


 #$seleniumOptions = New-Object OpenQA.Selenium.IE.InternetExplorerOptions
 #$seleniumOptions.InitialBrowserUrl = "https://www.linkedin.com/uas/login";
 ##$seleniumOptions.ForceCreateProcessApi = $true
 #$seleniumDriver = New-Object OpenQA.Selenium.IE.InternetExplorerDriver -ArgumentList @($defaultservice, $seleniumOptions)


  #$uri = [System.Uri]("http://127.0.0.1:4444/wd/hub")
  #$uri = [System.Uri]("http://10.211.217.25:4444/wd/hub")


  $uri = [System.Uri]::new("http://192.168.0.7:4444/wd/hub")
  $selenium = New-Object OpenQA.Selenium.Remote.RemoteWebDriver ($uri, $Capabilities)










#   $selenium = New-Object CustomeRemoteDriver ($uri,$capability)
#  [int] $version_major = [int][math]::Round([double]$selenium2.Capabilities.Version )
  #$sessionid = $selenium2.GetSessionId()
  #  http://stackoverflow.com/questions/25646639/firefox-webdriver-doesnt-work-with-firefox-32
  #[NUnit.Framework.Assert]::IsTrue($version_major -lt 32)
#}

#$base_url = 'file:///C:/developer/sergueik/powershell_ui_samples/external/grid-console.html'
$base_url = 'http://www.google.com/'
$selenium.Navigate().GoToUrl($base_url)
$selenium.Navigate().Refresh()
$selenium.Manage().Window.Maximize()


#$selenium.Navigate().Refresh()
#$selenium.Manage().Window.Maximize()
#[OpenQA.Selenium.Remote.RemoteWebElement]$proxy_id = $selenium.FindElement([OpenQA.Selenium.By]::CssSelector("p[class='proxyid']"))
#write-host ( "<<<" + $proxy_id.Text )

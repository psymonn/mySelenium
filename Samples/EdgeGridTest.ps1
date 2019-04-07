$shared_assemblies = @(
  'WebDriver.dll',
  'WebDriver.Support.dll'
#  'Selenium.WebDriverBackedSelenium.dll',
 # 'ThoughtWorks.Selenium.Core.dll'
    # TODO - resolve dependencies
  #'nunit.core.dll',
  #'nunit.framework.dll'

)



$env:SHARED_ASSEMBLIES_PATH = "F:\Data\Git\Selenium\lib40\"
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


#$connection = (New-Object Net.Sockets.TcpClient)
#$connection.Connect("192.168.0.7",4444)
#$connection.Close()

#var edgeService = EdgeDriverService.CreateDefaultService();
#edgeService.UseVerboseLogging = true;
#var edgeOptions = new EdgeOptions();
#driver = new EdgeDriver(edgeService, edgeOptions);

    $selenium_grid_hub = New-Object System.Uri("http://172.0.0.1:4444/wd/hub")

    $capability = New-Object OpenQA.Selenium.Remote.DesiredCapabilities;
    $capability.SetCapability("browserName", "MicrosoftEdge");
    #$capability.setCapability("PAGE_LOAD_STRATEGY",“eager”);
    $capability.setCapability("SUPPORTS_FINDING_BY_CSS","true");
    $capability.setCapability("SUPPORTS_APPLICATION_CACHE","true");
    $capability.SetCapability("platform",    "WINDOWS");
    $capability.SetCapability("version",     "");
    $capability.SetCapability("ensureCleanSession","true");
    #$capability.SetCapability("ie.forceCreateProcessApi","true");
    $capability.SetCapability("ignoreProtectedModeSettings","true");
    $capability.SetCapability("nativeEvents","false");
    #$capability.SetCapability("ignoreZoomSetting", "true");
               # $capability.SetCapability("BinaryLocation","C:\Program Files (x86)\Internet Explorer\iexplore.exe");

    $driver = New-Object OpenQA.Selenium.Remote.RemoteWebDriver($selenium_grid_hub, $capability);
    #$driver.Manage().Window.Maximize();
    #[int] $version_major = [int][math]::Round([double]$driver.Capabilities.Version )

    $base_url = 'http://www.google.com/'
    $driver.Navigate().GoToUrl($base_url)
    $driver.Navigate().Refresh()
    #$driver.Manage().Window.Maximize()

    Start-Sleep -s 5

    $driver.Close();
    $driver.Dispose();

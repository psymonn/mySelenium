
# File Test.ps1:
Import-Module -Name .\Selenium.psm1
#import-module -name .\selenium_common.psm1 -force

$VerbosePreference = 'continue'

#Write-Host "Global VerbosePreference: $global:VerbosePreference"
#Write-Host "TestModules.ps1 Script VerbosePreference: $script:VerbosePreference"

#Launch_selenium "ie"

#.\booking_com_search.ps1 "ie"
.\PesterTest2.ps1

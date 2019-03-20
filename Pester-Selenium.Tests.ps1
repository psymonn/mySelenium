# https://gist.github.com/smaglio81/df4a7a5ed5bf8ebc3d859577536e4b27
# http://stackoverflow.com/questions/1183183/path-of-currently-executing-powershell-script
$root = Split-Path $MyInvocation.MyCommand.Path -Parent;

if(-not $global:RunningInvokePester) {
	Write-Host "Reloading Modules"
	
	$Environment = "dev"

	Import-Module SeleniumExtensions
	Import-Module Selenium
    Import-Module Pester
}

Describe -Tag "UI","Public" -Name "Home" {

	BeforeAll {
		if($Environment -ne "prod") {
		  $script:url = "https://somesite.{env}.subgroup.domain.com" -f $Environment
    } else {
      $script:url = "https://somesite.subgroup.domain.com"
    }

		#$script:driver = Start-SeChrome
		$script:driver = Start-SeChrome -Arguments "headless", "incognito"
	}
	
	It "Search - Returns Results" {
		Enter-SeUrl -Driver $script:driver -Url $script:url
		
		Wait-UntilElementLoaded -Driver $script:driver -ClassName "navbar-brand"

		$searchBar = Find-SeElement -Driver $script:driver -Id "search-terms"
		Send-SeKeys -Element $searchBar -Keys "lookups"

		$searchBtn = Find-SeElement -Driver $script:driver -Id "search-button"
		Invoke-SeClick -Element $searchBtn

		Wait-UntilElementLoaded -Driver $script:driver -XPath "//div[@id='service-small-info-1']/div[@class='highlights']/ul"
		
		$firstResult = Find-SeElement -Driver $script:driver -XPath "//div[@id='service-small-info-1']/div[@class='highlights']"

		$firstResult.Text | Should Match "/classifications \(Get\)"
	}
	
	AfterAll {
		Stop-SeDriver -Driver $script:driver
	}

}

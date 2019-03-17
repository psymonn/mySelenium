# mySelenium

C# & PowerShell
HTML report generator for NUnit3
Nure (NUnit Report) -> https://github.com/eger-geger/nunit-html-report.git
TestCaseSource Attribute (NUnit that you can use to read parameters from an XML file) -> https://github.com/nunit/docs/wiki/TestCaseSource-Attribute
Adapter Installation -> https://github.com/nunit/docs/wiki/Adapter-Installation
https://github.com/nunit/nunit3-vs-adapter/issues/215
https://www.myget.org/feed/nunit/package/nuget/NUnit3TestAdapter/3.13.0-dev-01072
Cross browser parallel test execution with SeleniumGrid or testing Cloud Providers:
https://github.com/ObjectivityLtd/Test.Automation/wiki/Cross-browser-parallel-test-execution-with-SeleniumGrid-or-testing-Cloud-Providers

video:
https://www.google.com/search?client=firefox-b-ab&q=passing+parameters+to+nunit+test#kpvalbx=1
https://www.youtube.com/watch?v=ZkMIO8111V0
https://www.youtube.com/watch?v=hRjkr0gw7rw


Java:
Generate Reports In Selenium Webdriver (TestNG)-> https://www.techbeamers.com/generate-reports-selenium-webdriver/
TestNG HTML and XML Reports Exampl -> https://examples.javacodegeeks.com/enterprise-java/testng/testng-html-xml-reports-example/
How to configure Selenium HTML Reports in Jenkins -> https://stackoverflow.com/questions/13082425/how-to-configure-selenium-html-reports-in-jenkins

Nunit vs TestNG:
Can NUnit stand up to TestNG -> https://stackoverflow.com/questions/5547216/can-nunit-stand-up-to-testng
Why do we use TestNG rather than JUnit and NUnit? -> https://www.quora.com/Why-do-we-use-TestNG-rather-than-JUnit-and-NUnit


Pipeline - Parallel execution of tasks:
https://support.cloudbees.com/hc/en-us/articles/230922168-Pipeline-Parallel-execution-of-tasks
https://github.com/jenkinsci/pipeline-examples/blob/master/docs/BEST_PRACTICES.md
https://jenkins.io/doc/pipeline/examples/
https://jenkins.io/doc/book/pipeline/syntax/#parallel-stages-example
https://stackoverflow.com/questions/46834998/scripted-jenkinsfile-parallel-stage
https://jenkins.io/blog/2017/09/25/declarative-1/
https://blog.clairvoyantsoft.com/selenium-grid-and-jenkins-integration-4a25a057604c

Capabilities:
https://firefox-source-docs.mozilla.org/testing/geckodriver/Capabilities.html
https://sites.google.com/a/chromium.org/chromedriver/capabilities
https://github.com/SeleniumHQ/selenium/wiki/DesiredCapabilities
https://github.com/SeleniumHQ/selenium/wiki/Grid2
https://wiki.jenkins.io/display/JENKINS/Selenium+Plugin
https://github.com/zalando/zalenium/issues/682



Json:
https://www.seleniumeasy.com/selenium-tutorials/configure-selenium-grid-using-json-config-file
https://github.com/SeleniumHQ/selenium/blob/master/java/server/src/org/openqa/grid/common/defaults/DefaultNodeWebDriver.json


Doco Distributed Testing with Selenium Grid:
https://www.packtpub.com/sites/default/files/downloads/Distributed_Testing_with_Selenium_Grid.pdf

Selenium Grid VS Jenkins:
https://stackoverflow.com/questions/27573634/selenium-grid-vs-jenkins
https://seleniumhq.github.io/docs/grid.html

Selenium Jenins Integration:
https://www.google.com.au/search?client=opera&hs=9rf&ei=Uax3XJx7lvv1A-ORhtgF&q=selenium+jenkins+setup&oq=selenium+jenkins+setup&gs_l=psy-ab.3.0.0j0i22i30l2.981961.986085..986797...0.0..0.239.3645.0j21j1......0....1..gws-wiz.......0i71j0i131j0i131i67j0i67.n1Bt1ws-kuE#kpvalbx=1


PowerShell code:
https://github.com/hirokundayon/koedo/blob/master/PowerShell/koedo.ps1
https://github.com/sergueik/powershell_selenium/blob/master/powershell/selenium_dirty_version.ps1
https://github.com/sergueik/powershell_selenium/blob/master/powershell/selenium_actions.ps1
https://github.com/sergueik/powershell_selenium/blob/master/powershell/chrome_preferences.ps1
https://github.com/sergueik/powershell_selenium/blob/master/powershell/selenium_console_addon.ps1
https://stackoverflow.com/questions/15767066/get-session-id-for-a-selenium-remotewebdriver-in-c-sharp
https://github.com/grock90/PSSelenium/edit/master/README.md
https://github.com/seleniumhq
https://gist.github.com/Jaykul/d16a390e36ec3ba54cd5e3f760cfb59e
https://www.powershellgallery.com/packages/Selenium/1.0/Content/Selenium.psm1
https://archive.codeplex.com/?p=sepsx
https://powershellone.wordpress.com/2015/02/12/waiting-for-elements-presence-with-selenium-web-driver/
https://newspaint.wordpress.com/2017/03/23/using-powershell-2-0-with-selenium-to-automate-internet-explorer-firefox-and-chrome/
http://ps1coding.blogspot.com/2015/07/using-selenium-webdriver-with.html
http://knowledgevault-sharing.blogspot.com/2017/05/selenium-webdriver-with-powershell.html
https://github.com/executeautomation/ExecuteAutomationReportingSystem
https://www.alkanesolutions.co.uk/blog/2018/12/06/powershell-selenium-and-browser-automation/
https://newspaint.wordpress.com/2017/03/23/using-powershell-2-0-with-selenium-to-automate-internet-explorer-firefox-and-chrome/
https://tech.mavericksevmont.com/blog/powershell-selenium-automate-web-browser-interactions-part-iii/
https://github.com/qawarrior/pswebdriver/blob/master/Tests/Start-WebDriver.Tests.ps1
https://github.com/adamdriscoll/selenium-powershell/blob/master/Selenium.tests.ps1
https://www.powershellgallery.com/packages/Selenium/1.1


PowerShell classes:
https://4sysops.com/archives/powershell-classes-part-4-constructors/
https://www.sapien.com/blog/2015/10/26/creating-objects-in-windows-powershell/
https://stackoverflow.com/questions/12870109/how-do-i-call-new-object-for-a-constructor-which-takes-a-single-array-parameter
https://stevenmurawski.com/2009/03/exploring-the-net-framework-with-powershell-constructors-part-3/


Jenkins:
every agent has its own executor:

e.g
Note rule of thumb, the number of executor is based on your cpu (logical cpu or physical?, I'll take physical :))

agent1 might have 3 executors 
agent2 might have 2 executors
master agent might have 4 exectors

Appium-jenkins demo src code:
https://github.com/vbanthia/appium-jenkins-demo
https://stackoverflow.com/questions/41829604/how-to-run-appium-test-scripts-through-jenkins

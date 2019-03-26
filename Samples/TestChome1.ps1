$Driver = Start-SeChrome
Enter-SeUrl https://www.google.com/ -Driver $Driver
#$Element = Find-SeElement -Driver $Driver -Id "myControl"
$Driver.Navigate().GoToURL($YourURL) # Browse to the sp
$Driver.FindElementByName("q").SendKeys("mavericksevmont tech blog") # Methods to find the input textbox for google search and then to type something in it
$Driver.FindElementByName("btnK").Submit() # Method to submit request to the button
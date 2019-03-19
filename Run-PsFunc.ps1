#Let try passing a parameter from Jenkins to the script

Function Run-PsFunc{
	param($VariableA,$VariableB)

	write-host "Well, did we get $VariableA and $VariableB passed in correctly?"

	# Now commit to GitHub!

	#Let make it a drop down box as well
}

#Run-PsFunc -VariableA a -VariableB b

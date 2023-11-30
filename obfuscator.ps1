## Take in a huge ass string, chop it into different chunked character arrays every 10 characters, and then re-combine at the end into a cohesive script with '+' to add them all together one by one

$Stringtest = 'gci "C:\Program Files"; gci "C:\Program Files (x86)"; hostname; whoami'


$Allstrings = $Stringtest.tochararray()

$Allvariables = @("a", "b", "c","d", "e", "f","g", "h", "j","k", "l", "m","n", "o", "p","q", "r", "s","t", "u", "v","w", "x", "y","z", "AB", "CD", "EF","GH", "IJ", "KL","MN", "OP", "QR","ST", "UV", "WX","YZ", "UV", "WX","YZ")

$Count = 0

$NewVarArray = @()

$Stringlength = $Stringtest.Length

## Add padding, hacky way to accomplish % 5 -eq 0 issues when people supply random strings
while ($Stringtest.Length % 5 -ne 0){

$Stringtest += " "

}








## Now we will try to create a separate array for every 5 characters
for ($i = 0; $i -lt $Stringtest.Length; $i += 1){

## Create random variable names
$Varname = $AllVariables | Get-Random -count 3 ## Create random variable names
$Newvarname = ($Varname -join '').Trim() ## join into one line and remove whitespaces

## This part is strictly for capturing the first few characters as well - Section 1
if ($Count -eq 0){
$Newvararray += $NewVarName
$newstring = $Stringtest.Substring($Count, 5)
$Fullarray += "$"
$Fullarray += "$Newvarname="
$Fullarray += "'"
$Fullarray += $newstring
$Fullarray += "'"
$Fullarray += ";"
}

$Count += 1
## Majority of script happens here - Section 2
if ($Count % 5 -eq 0 -and $Count -ne $Stringlength){

$Newvararray += $NewVarName

try {
$newstring = $Stringtest.Substring($Count, 5)
}
catch {continue} #write-error "String length is $Stringlength, we are at index $Count and we are trying to create a 5 character substring, which causes an error."}

$Fullarray += "$"
$Fullarray += "$Newvarname="
$Fullarray += "'"
$Fullarray += $newstring
$Fullarray += "'"
$Fullarray += ";"

} ## end section 2


} ## end for loop


## Essentially the END block of script
$newarray = $Fullarray -replace "\+$", "" ## replace the final '+' sign with nothing
$Count = 0
Invoke-Expression $newarray

$Allvars = $newvararray -replace "^", "$" ## Get all variables into one single array

$SecondAllVars = $Allvars -replace "$", "+" -join ""
$ThirdAllvars = $SecondallVars -replace "\+$", ""

## Combine all the text
$Finalvariable = Invoke-expression $Thirdallvars

## Actually call the command
Invoke-expression $Finalvariable


write-host -foregroundcolor yellow "String array: $newarray"
write-host -foregroundcolor Cyan "Combined string array: $Thirdallvars"
write-host -foregroundcolor Green "Executed command: $FinalVariable"



$newarray = $null
$Fullarray = $null
$Finalvariable = $null
$Thirdallvars = $null



## IDEAS:
## base64 encode final payload or even obfuscated strings before execution

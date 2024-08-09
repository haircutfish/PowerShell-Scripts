# Search the computer for the file indicated on the command line.  If found it will place the output containing the full path it to a text file in your current directory.  If no file is found, it will display on the terminal that no file was found.
# Created By: Dan Rearden
# 2024-08-09

# Allows to define on the command line what the file's name is
param(
    [Parameter(Mandatory=$true)]
    [string]$fileName
)

# Grab date and place in a variable
$date = Get-Date -Format "yyyy-MM-dd"

# create a variable for the naming of the output file
$outputfile = "fd-results-$date.txt"

# Searches the system for the string uztip6g, silences errors, and places it in a variable
$foundFiles = Get-ChildItem -path "C:\" -file -filter "*$fileName*" -recurse -errorAction SilentlyContinue

# If results are found, it will place them in a file
if ($foundFiles) {
    $foundFiles | Select-Object FullName | Out-File $outputfile
} 
# If no results are found, it will output the below string to the console
else {
    Write-Host "$fileName was not detected on this system"
}

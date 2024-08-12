# Gets a list of files recursively through a specified directory.  Then, it checks those files for a specific string.
# Created by Dan Rearden
# 2024-08-12

# Takes the parameters from the command line for the directory to search and string to find
param (
    [parameter(Mandatory=$true)]
    [string]$path,
    [parameter(Mandatory=$true)]
    [string]$string
)

# Getting list of files and place in a variable
Get-ChildItem -path $path -File -Recurse -ErrorAction SilentlyContinue | ForEach-Object {
    # Getting the content of each file and checking to see if it contains the string
    $foundString = Get-Content $_.FullName | Select-String -Pattern $string
    # If the string is found it will Output it to the screen along with the full path
    if ($foundString){    
    Write-Output "$foundString - $($_.FullName)"
}
}
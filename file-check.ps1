# Gets list of files recursivly through a specified directory.  Then checks those files for a specific string.
# Created by Dan Rearden
# 2024-08-12

# Takes the parameters from the command line for the directory to search and string to find
param (
    [parameter(Mandatory=$true)]
    [string]$path,
    [parameter(Mandatory=$true)]
    [string]$string
)

# Getting list of files 
Get-ChildItem -path $path -File -Recurse -ErrorAction SilentlyContinue | ForEach-Object {
    # Getting the content of each file, then searching it using the variable string
    Get-Content $_.FullName | Select-String -Pattern $string

}
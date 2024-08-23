# This Script is used to open a web broswer then navigate to the NIST CVE page using the format CVE-****-****
# Written by Dan R.
# 2024-08-05
# Updated 2024-08-23

# Declaring the $cveNumber parameter
param (
    [Parameter(Mandatory=$true)]
    [string]$cveNumber
)

# URL that the CVEnumber will be placed in 
$url = "https://nvd.nist.gov/vuln/detail/$cveNumber"


# Creating Function to check if a program exist
function Test-ProgramExists {
    param (
        [string]$programName
    )
    $exists = Get-Command $programName -ErrorAction SilentlyContinue
    return $exists -ne $null
}

# Varibles linked to the full path of the browsers
$chromePath = "C:\Program Files\Google\Chrome\Application\chrome.exe"
$firefoxPath = "C:\Program Files\Mozilla Firefox\firefox.exe"
$edgePath = "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"

# Test to see if Chrome is installed
if (Test-ProgramExists $chromePath){
    # Open the URL in Chrome
    Start-Process $chromePath $url
} # Test to see if Chrome is installed 
elseif (Test-ProgramExists $firefoxPath)  {
    # Open the URL in Firefox
    Start-Process $firefoxPath $url
} elseif (Test-ProgramExists $edgePath){
    # Open the URL in Edge
    Start-Process $edgePath $url
} else{
    Write-Host "No Supported browsers found.  Please install Chrome, Firefox, or Edge.  Thank you"
}

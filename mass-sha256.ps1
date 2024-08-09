# This script is used to mass retrieve the SHA256 hash of all the files in a folder recursively.
# Created by Dan Rearden
# 2024-08-08

# Setting the parameters to be used on the commandline -path and -outputfile
param(
    [Parameter(Mandatory=$true)]
    [string]$path,
    [Parameter(Mandatory=$true)]
    [string]$outputFile
)

# Creating the main function, setting the arg with path and outputfile
function Get-FileHashesRecursively($path, $outputFile) {
    # Variable to help concatenate the hash
    $output = New-Object System.Text.StringBuilder

    # Gets the files in each directory recursively, silencing any errors.  Then puts each through a for loop
    Get-ChildItem -Path $path -Recurse -File -ErrorAction SilentlyContinue | ForEach-Object {
        try {
            # Gets the hash of file and places it in a variable
            $hash = Get-FileHash $_.FullName -Algorithm SHA256
            # Adds the only the hash to the output variable
            $output.AppendLine("$($hash.Hash)")
        # Error handling, if a hash was not able to be retrieved
        } catch {
            Write-Warning "Error calculating hash for $($_.FullName): $($_.Exception.Message)"
        }
    }
    # Takes the hash, converts it to a string then places it at the end of the outputfile
    $output.ToString() | Out-File $outputFile -Append
}

# Runs the function with the path and outputfile variable
Get-FileHashesRecursively $path $outputFile
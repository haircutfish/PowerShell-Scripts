# This script is used to mass retrieve the SHA256 hash of all the files in a folder recursively.
# Created by Dan Rearden
# 2024-08-08

param(
    [Parameter(Mandatory=$true, Position=0)]
    [string]$path,
    [Parameter(Mandatory=$true, Position=1)]
    [string]$outputFile
)
function Get-FileHashesRecursively($path, $outputFile) {
    $output = New-Object System.Text.StringBuilder

    Get-ChildItem -Path $path -Recurse -File -ErrorAction SilentlyContinue | ForEach-Object {
        try {
            $hash = Get-FileHash $_.FullName -Algorithm SHA256
            $output.AppendLine("$($hash.Hash)")
        } catch {
            Write-Warning "Error calculating hash for $($_.FullName): $($_.Exception.Message)"
        }
    }
    $output.ToString() | Out-File $outputFile -Append
}

Get-FileHashesRecursively $path $outputFile
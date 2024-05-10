
param(
    [Parameter(Mandatory=$false)]
    [switch]$Json,

    [Parameter(Mandatory=$false)]
    [switch]$Url
)
Invoke-Expression "Clear-Host"
$Host.UI.RawUI.WindowTitle = "Script : Swagger to PDF Converter"
$displayMsg = Get-Content -Path "src/MBN.txt" -Raw
Write-Host $displayMsg
Write-Host ""
Write-Host ""

# Initial path configuration
$basePath = Get-Location
# Path to the module file
$modulePath = Join-Path -Path $basePath -ChildPath "src/ScriptModel.psm1"
# Path to the input directory
$jsonInputPath = Join-Path -Path $basePath -ChildPath "InputDirectory"

# Import the module file
Import-Module -Name $modulePath -Force

if ($Json) {
    Write-Host "JSON is enabled"
    Write-Host ""
    # Add your JSON processing logic here
    Invoke-JsonScript -basePath $basePath -jsonInputPath $jsonInputPath
    Exit-Program
}
if ($Url) {
    Write-Host "URL is enabled"
    Write-Host ""
    # Add your URL processing logic here
    Invoke-UrlScript -basePath $basePath
    Exit-Program
}
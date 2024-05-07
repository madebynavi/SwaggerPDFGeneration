
param(
    [Parameter(Mandatory=$false)]
    [switch]$json,

    [Parameter(Mandatory=$false)]
    [switch]$yaml,

    [Parameter(Mandatory=$false)]
    [switch]$url
)

# Initial path configuration
$basePath = Get-Location
# Path to the module file
$modulePath = Join-Path -Path $basePath -ChildPath "src/ScriptModel.psm1"
# Path to the input directories
$jsonInputPath = Join-Path -Path $basePath -ChildPath "InputDirectory/JSON"
$yamlInputPath = Join-Path -Path $basePath -ChildPath "InputDirectory/YAML"

# Import the module file
Import-Module -Name $modulePath -Force

if ($json) {
    Write-Host "JSON is enabled"
    Write-Host ""
    # Add your JSON processing logic here
    #Invoke-JsonScript
    Exit-Program
}
if ($yaml) {
    Write-Host "YAML is enabled"
    Write-Host ""
    # Add your YAML processing logic here
    Invoke-YamlScript
    Exit-Program
}
if ($url) {
    Write-Host "URL is enabled"
    Write-Host ""
    # Add your URL processing logic here
    Invoke-UrlScript
    Exit-Program
}
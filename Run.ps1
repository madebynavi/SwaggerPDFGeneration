
param(
    [Parameter(Mandatory=$false, HelpMessage = "Path to the local Swagger / OpenAPI JSON file.")]
    [string]$InPath,
    [Parameter(Mandatory=$false, HelpMessage = "Path to the output directory.")]
    [string]$OutPath,
    [Parameter(Mandatory=$false, HelpMessage = "Flag to get the help message.")]
    [switch]$Help
)

Invoke-Expression "Clear-Host"
$Host.UI.RawUI.WindowTitle = "Script : Swagger to PDF Converter"
$displayMsg = Get-Content -Path "src/MBN.txt" -Raw
Write-Host $displayMsg
Write-Host ""
Write-Host ""

Write-Host $Help

Read-Host "Press Enter to continue..."

if($Help){
    Write-Host "This script converts Swagger / OpenAPI JSON files to PDF files."
    Write-Host "Basic execution: .\Run.ps1"
    Write-Host "The script comes with the following parameters:"
    Write-Host "-InPath: Full path to the folder where the local Swagger / OpenAPI JSON files are."
    Write-Host "-OutPath: Full path to the output directory."
    Write-Host "Example: .\Run.ps1 -InPath 'C:\Users\user\Documents\swagger.json' -OutPath 'C:\Users\user\Documents\output'"
    Exit
}

# Initial path configuration
$basePath = Get-Location
# Path to the module file
$modulePath = Join-Path -Path $basePath -ChildPath "src/ScriptModel.psm1"
# Path to default input directory
$jsonInputPath = Join-Path -Path $basePath -ChildPath "InputDirectory"
# Path to default output directory
$outputPath = Join-Path -Path $basePath -ChildPath "OutputDirectory"

# Import the module file
Import-Module -Name $modulePath -Force

if(![string]::IsNullOrEmpty($InPath)){
    Write-Host "Your input path is: $InPath"
    Write-Host "Testing if the input path is a valid location..."
    if(Test-Path -Path $InPath){
        Write-Host "The input path is valid."
        Write-Host "Setting input path to: $InPath"
        $jsonInputPath = $InPath
    }
    else{
        Write-Warning "The input path is invalid, exiting program..."
        Exit-Program
    }
}
else{
    Write-Host "No input path provided, using default path: $jsonInputPath"
}
if(![string]::IsNullOrEmpty($OutPath)){
    Write-Host "Your output path is: $OutPath"
    Write-Host "Testing if the output path is a valid location..."
    if(Test-Path -Path $OutPath){
        Write-Host "The output path is valid."
        Write-Host "Setting output path to: $OutPath"
        $outputPath = $OutPath
    }
    else{
        Write-Warning "The output path is invalid."
        $title = "Output Diriectory Creation"
        $question = "Would you like to create the output directory?"
        $choices = [System.Management.Automation.Host.ChoiceDescription[]] @("&Yes", "&No")
        $decision = $Host.UI.PromptForChoice($title, $question, $choices, 1)
        if($decision -eq 0){
            Write-Host "Creating output directory..."
            New-Item -Path $OutPath -ItemType Directory -Force
            Write-Host "Output directory created."
            $outputPath = $OutPath
        }
        else{
            Write-Host "Exiting program..."
            Exit-Program
        }
    }
}
else{
    Write-Host "No output path provided, using default path"
}
Write-Host "Directory paths have been set..."
Write-Host "Proceeding with the conversion process..."
Invoke-JsonScript -InputPath $jsonInputPath -OutPath $outputPath
Exit-Program -Msg "Program has completed successfully."
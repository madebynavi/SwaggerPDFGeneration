param(
    [Parameter(Mandatory=$false, HelpMessage = "Path to the local Swagger / OpenAPI JSON file.")]
    [Alias("I", "Input")]
    [string]$In,
    [Parameter(Mandatory=$false, HelpMessage = "Path to the output directory.")]
    [Alias("O", "Output")]
    [string]$Out,
    [Parameter(Mandatory=$false, HelpMessage = "Bool-Flag to run the script with root folder as input.")]
    [Alias("R")]
    [switch]$Root,
    [Parameter(Mandatory=$false, HelpMessage = "Bool-Flag to get the help message.")]
    [Alias("H")]
    [switch]$Help,
    [Parameter(Mandatory=$false, HelpMessage = "Bool-Flag to compress the output PDF folder.")]
    [Alias("C", "Comp")]
    [switch]$Compress,
    [Parameter(Mandatory=$false, HelpMessage = "Bool-Flag to use the Git-Repo folder structure for execution.")]
    [Alias("B")]
    [switch]$Base
)
# Parameter Validation
# TODO : Add Parameter Validation
# End of Parameter Validation
# ----------------------------------
# Function Definitions
function Get-Hint{
    Write-Host "`nHint : [-Help / -H] for assistance." -ForegroundColor Green
}
function Get-HelpMessage {
    Write-Host ""
    $helpText = @"
=====================================
Swagger/OpenAPI to PDF Converter Help
=====================================

Description:
    This script converts Swagger / OpenAPI JSON files to PDF files.

Executions:
    .\Run.ps1 [-Help / -H]
    .\Run.ps1 [-Root / -R]
    .\Run.ps1 [-Base / -B]
    .\Run.ps1 [-In / -I / -Input] <Path>
    .\Run.ps1 [-Out / -O / -Output] <Path>
    .\Run.ps1 [-In / -I / -Input] <Path> [-Out / -O / -Output] <Path>
    .\Run.ps1 [-Root / -R] [-Compress / -C / -Comp]
    .\Run.ps1 [-Base / -B] [-Compress / -C / -Comp]
    .\Run.ps1 [-In / -I / -Input] <Path> [-Compress / -C / -Comp]
    .\Run.ps1 [-Out / -O / -Output] <Path> [-Compress / -C / -Comp]
    .\Run.ps1 [-In / -I / -Input] <Path> [-Out / -O / -Output] <Path> [-Compress / -C / -Comp]

Parameters:
    -Help / -H [boolean]
        Flag to get the help message.

    -Root / -R [boolean]
        Flag to run the script with root folder as input and also as output.

    -In / -I / -Input <Path> [string]
        Full path to the local Swagger / OpenAPI JSON file.
        If none provided, the script will asume "InputDirectory" exists in script root folder.

    -Out / -O / -Output <Path> [string]
        Full path to the output directory.
        If none provided, the script will asume "OutputDirectory" exists in script root folder or create if it does not exist.

    -Compress / -C / -Comp [boolean]
        Flag to ZIP/Compress the output PDF folder.
    
    -Base / -B [boolean]
        Flag to use the Git-Repo folder structure for execution.

Author:
    MadeByNavi
    Version 1.0
    Date: $(Get-Date -Format "yyyy-MM-dd")
"@
    Write-Host $helpText -ForegroundColor Green
    Write-Host ""
}
function Test-NPM{
    Write-Host "Checking NPM Package..." -ForegroundColor Yellow
    $npmPackage = "openapi2pdf-cli"
    $npmCheck = "npm list -g $npmPackage"
    $resultObject = Invoke-Expression $npmCheck
    $resultString = $resultObject -Join ""
    if($resultString.Contains("empty")){
        Write-Host "NOK - " -ForegroundColor Red -NoNewline
        Write-Host "The required NPM package is not installed, installing..."
        $npmCmd = "npm install -g $npmPackage"
        Invoke-Expression $npmCmd
        Write-Host "OK - " -ForegroundColor Green -NoNewline
        Write-Host "Install Suceessful."
    }
    else{
        Write-Host "OK - " -ForegroundColor Green -NoNewline
        Write-Host "The required NPM package is installed."
    }
}
function Get-Banner{
    Clear-Host
    $banner = @"                                                                        
{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}
{}                                                                                {}
{}  ______  ___      _________    ________        _____   __             _____    {}
{}  ___   |/  /_____ ______  /_______  __ )____  ____  | / /_____ ___   ____(_)   {}
{}  __  /|_/ /_  __  /  __  /_  _ \_  __  |_  / / /_   |/ /_  __  /_ | / /_  /    {}
{}  _  /  / / / /_/ // /_/ / /  __/  /_/ /_  /_/ /_  /|  / / /_/ /__ |/ /_  /     {}
{}  /_/  /_/  \__,_/ \__,_/  \___//_____/ _\__, / /_/ |_/  \__,_/ _____/ /_/      {}
{}                                        /____/                                  {}
{}                                                                                {}
{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}
                                                                               
Swagger/OpenAPI to PDF Converter Script
Version: 1.0
Author: MadeByNavi
Date: $(Get-Date -Format "yyyy-MM-dd")
"@
    Write-Host $banner -ForegroundColor Cyan
}
function Set-OutputDirectory{
    param(
        [Parameter(Mandatory=$true, HelpMessage = "The folder to be created for the output PDF files.")]
        [string]$Directory
    )
    if(-not (Test-Path -Path $Directory)){
        Write-Host "[INFO] - " -ForegroundColor Cyan -NoNewline
        Write-Host "Output Folder does not exist, creating..."
        Write-Host ""
        New-Item -Path $Directory -ItemType Directory
        Write-Host "[OK] - " -ForegroundColor Green -NoNewline
        Write-Host "Output Folder created successfully."
        Write-Host ""
    }
    else{
        Write-Host "[INFO] - " -ForegroundColor Cyan -NoNewline
        Write-Host "Output Folder already exists."
        Write-Host ""
    }
}
function Set-PDF{
    param(
        [Parameter(Mandatory=$true, HelpMessage = "The path to the Swagger / OpenAPI JSON file.")]
        [string]$InputFile,
        [Parameter(Mandatory=$true, HelpMessage = "The path to the output directory.")]
        [string]$OutputFile
    )
    Write-Host "[INFO] - " -ForegroundColor Cyan -NoNewline
    Write-Host "Converting JSON to PDF..."
    $pdfCmd = "npx openapi2pdf-cli -i $InputFile -o $OutputFile"
    Invoke-Expression $pdfCmd
    Write-Host "[OK] - " -ForegroundColor Green -NoNewline
    Write-Host "Conversion Successful."
    Write-Host ""
}
function Set-CompressFolder{
    param(
        [Parameter(Mandatory=$true, HelpMessage = "The path to the output directory.")]
        [string]$Directory
    )
    Write-Host "[INFO] - " -ForegroundColor Cyan -NoNewline
    Write-Host "Compressing the output folder..."
    $zipFile = Join-Path -Path $Directory -ChildPath "$outFolder.zip"
    Compress-Archive -Path $Directory -DestinationPath $zipFile
    Write-Host "[OK] - " -ForegroundColor Green -NoNewline
    Write-Host "Compression Successful."
    Write-Host ""

}
# End of Function Definitions
# ----------------------------------
# Variable Setting
$inputPath = Join-Path -Path $PSScriptRoot -ChildPath "InputDirectory"
$outFolder = Get-Date -Format "yyyy-MM-dd_HH-mm-ss"
$outputPath = Join-Path -Path $PSScriptRoot -ChildPath "OutputDirectory/$outFolder"
# End of Variable Setting
# ----------------------------------
# Main Logic Here
Get-Banner
Get-Hint

if($Help){
    Get-Banner
    Get-HelpMessage
    Exit
}
if($Root){
    $inputPath = $PSScriptRoot
    $outputPath = Join-Path -Path $PSScriptRoot -ChildPath $outFolder
    Set-OutputDirectory -Directory $outputPath
    Test-NPM
    Get-ChildItem -Path $inputPath -Filter "*.json" | ForEach-Object {
        $jsonFile = $_.FullName
        $pdfFile = $_.BaseName + ".pdf"
        $pdfOutput = Join-Path -Path $outputPath -ChildPath $pdfFile
        Set-PDF -InputFile $jsonFile -OutputFile $pdfOutput
    }
    if($Compress){
        Set-CompressFolder -Directory $outputPath
    }
    Write-Host "[INFO] - " -ForegroundColor Cyan -NoNewline
    Write-Host "Script Completed."
    Exit
}
if($Base){
    Set-OutputDirectory -Directory $outputPath
    Test-NPM
    Get-ChildItem -Path $inputPath -Filter "*.json" | ForEach-Object {
        $jsonFile = $_.FullName
        $pdfFile = $_.BaseName + ".pdf"
        $pdfOutput = Join-Path -Path $outputPath -ChildPath $pdfFile
        Set-PDF -InputFile $jsonFile -OutputFile $pdfOutput
    }
    if($Compress){
        Set-CompressFolder -Directory $outputPath
    }
    Write-Host "[INFO] - " -ForegroundColor Cyan -NoNewline
    Write-Host "Script Completed."
    Exit
}
if(![string]::IsNullOrEmpty($In)){
    if(Test-Path -Path $In){
        $inputPath = $In
        Write-Host "[OK] - " -ForegroundColor Green -NoNewline
        Write-Host "The input path is valid."
    }
    else{
        Write-Host "[ERROR] - " -ForegroundColor Red -NoNewline
        Write-Host "The input path is invalid, exiting program..."
        Exit
    }
    if(![string]::IsNullOrEmpty($Out)){
        if(Test-Path -Path $Out){
            $outputPath = $Out
            Write-Host "[OK] - " -ForegroundColor Green -NoNewline
        Write-Host "The output path is valid."
        }
        else{
            Write-Host "[ERROR] - " -ForegroundColor Red -NoNewline
            Write-Host "The output path is invalid, exiting program..."
            Exit
        }
    }
    Set-OutputDirectory -Directory $outputPath
    Test-NPM
    Get-ChildItem -Path $inputPath -Filter "*.json" | ForEach-Object {
        $jsonFile = $_.FullName
        $pdfFile = $_.BaseName + ".pdf"
        $pdfOutput = Join-Path -Path $outputPath -ChildPath $pdfFile
        Set-PDF -InputFile $jsonFile -OutputFile $pdfOutput
    }
    if($Compress){
        Set-CompressFolder -Directory $outputPath
    }
    Write-Host "[INFO] - " -ForegroundColor Cyan -NoNewline
    Write-Host "Script Completed."
    Exit
}
if(![string]::IsNullOrEmpty($Out)){
    if(Test-Path -Path $Out){
        $outputPath = $Out
        Write-Host "[OK] - " -ForegroundColor Green -NoNewline
        Write-Host "The input path is valid."
    }
    else{
        Write-Host "[ERROR] - " -ForegroundColor Red -NoNewline
        Write-Host "The outpuit path is invalid, exiting program..."
        Exit
    }
    if(![string]::IsNullOrEmpty($In)){
        if(Test-Path -Path $In){
            $inputPath = $In
            Write-Host "[OK] - " -ForegroundColor Green -NoNewline
        Write-Host "The input path is valid."
        }
        else{
            Write-Host "[ERROR] - " -ForegroundColor Red -NoNewline
            Write-Host "The input path is invalid, exiting program..."
            Exit
        }
    }
    Set-OutputDirectory -Directory $outputPath
    Test-NPM
    Get-ChildItem -Path $inputPath -Filter "*.json" | ForEach-Object {
        $jsonFile = $_.FullName
        $pdfFile = $_.BaseName + ".pdf"
        $pdfOutput = Join-Path -Path $outputPath -ChildPath $pdfFile
        Set-PDF -InputFile $jsonFile -OutputFile $pdfOutput
    }
    if($Compress){
        Set-CompressFolder -Directory $outputPath
    }
    Write-Host "[INFO] - " -ForegroundColor Cyan -NoNewline
    Write-Host "Script Completed."
    Exit
}
# End of Main Logic
# ----------------------------------
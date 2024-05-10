
function Invoke-JsonScript{
    param(
        [Parameter(Mandatory=$true, HelpMessage = "Base path of the execution script.")]
        [string]$basePath,

        [Parameter(Mandatory=$true, HelpMessage = "Path to the JSON input directory.")]
        [string]$jsonInputPath
    )
    Write-Host "Invoking JSON Script..."
    Write-Host ""

    Confirm-NpmPackage
    
    $output = Set-OutputDirectory -basePath $basePath
    $outputDirectory = $output[0].ToString()
    
    ConvertTo-PDF -inputPath $jsonInputPath -outputPath $outputDirectory
}

function Invoke-UrlScript{
    param(
        [Parameter(Mandatory=$true, HelpMessage = "Base path of the execution script.")]
        [string]$basePath
    )
    Write-Host "Invoking URL Script..."
}

function Exit-Program {
    Write-Host "Exiting program..."
    Exit
}

Export-ModuleMember -Function `
Invoke-JsonScript, `
Invoke-YamlScript, `
Invoke-UrlScript, `
Exit-Program


# Below this comment is internal method that are not exported from this module.
function Set-OutputDirectory{
    param(
        [Parameter(Mandatory=$true, HelpMessage = "Base path of the execution script.")]
        [string]$basePath
    )
    $outputDirectoryName = Get-Date -Format "yyyy-MM-dd_HH-mm-ss"

    $outputPath = Join-Path -Path $basePath -ChildPath "OutputDirectory/$outputDirectoryName"

    Write-Host "Output directory set to: $outputPath"
    New-Item -Path $outputPath -ItemType Directory -Force
    Write-Host "Output directory created successfully"
    Write-Host ""
    return [string]$outputPath
}

function Confirm-NpmPackage {
    $npmPackage = "openapi2pdf-cli"
    $npmCheck = "npm list -g $npmPackage"
    $resultObject = Invoke-Expression $npmCheck
    $resultString = $resultObject -Join ""

    if($resultString.Contains("empty")){
        Write-Host "The npm package $npmPackage is not installed."
        Write-Host "Installing $npmPackage..."
        $npmCmd = "npm install -g $npmPackage"
        Invoke-Expression $npmCmd
        Write-Host "The NPM package has been installted."
    }
    else{
        Write-Host "The required NPM package is aldready installed."
    }
}

function ConvertTo-PDF{
    param(
        [Parameter(Mandatory=$true, Position = 1, HelpMessage = "Path to the directory where the OpenAPI / Swagger files to be converted are located.")]
        [string]$inputPath,
        [Parameter(Mandatory=$true, Position = 2, HelpMessage = "Path to the directory where the PDF files will be saved.")]
        [string]$outputPath
    )
    Write-Host "This is the converted outputPath:" + $outputPath
  
    Write-Host "Converting JSON to PDF..."
    Get-ChildItem -Path $inputPath -Filter "*.json" | ForEach-Object {
        $jsonFilePath = $_.FullName
        $pdfFileName = $_.BaseName + ".pdf"
        $npmCmd = "openapi2pdf-cli -i $jsonFilePath -o $outputPath/$pdfFileName"
        Write-Host "Converting" + $_.Name + "to PDF..." + $pdfFileName
        Invoke-Expression $npmCmd
        Write-Host "Conversion completed successfully."
        Write-Host ""
    }
}


function Invoke-JsonScript{
    param(
        [Parameter(Mandatory=$true, HelpMessage = "Base path of the execution script.")]
        [string]$basePath,

        [Parameter(Mandatory=$true, HelpMessage = "Path to the JSON input directory.")]
        [string]$jsonInputPath
    )
    Write-Host "JSON Function Called"

    $OutputDirectory = Set-OutputDirectory -basePath $basePath
}

function Invoke-YamlScript{
    param(
        [Parameter(Mandatory=$true, HelpMessage = "Base path of the execution script.")]
        [string]$basePath,

        [Parameter(Mandatory=$true, HelpMessage = "Path to the YAML input directory.")]
        [string]$yamlInputPath
    )
    Write-Host "YAML Function Called"

    $OutputDirectory = Set-OutputDirectory -basePath $basePath
}

function Invoke-UrlScript{
    param(
        [Parameter(Mandatory=$true, HelpMessage = "Base path of the execution script.")]
        [string]$basePath
    )
    Write-Host "URL Function Called"
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
    $outputDirectoryName = Get-Datetime -Format "yyyy-MM-dd_HH-mm"

    $outputPath = Join-Path -Path $basePath -ChildPath "OutputDirectory/$outputDirectoryName"

    Write-Host "Output directory set to: $outputPath"
    New-Item -Path $outputPath -ItemType Directory -Force
    Write-Host "Output directory created successfully"
    Write-Host ""
    return $outputPath
}
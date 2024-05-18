# OpenAPI2PDF / RapiPDF - Extension
This is an extension of the work done by : https://github.com/iravikumar0403/openapi2pdf-cli and https://github.com/mrin9/RapiPdf

## About
This is a script with the purpose of automate PDF generation for documentation based on Swagger 2.0 / OpenAPI 3.0 standard.
It can be attached to an automated process or used as is for manual execution when needed.

This is for everyone to use, feel free to fork it, modify it for your usecases.

## Instructions
### Parameters
```powershell
[-Root / -R]
```
Executes the script with asumption that the "json" files are located in the root of script.
Will create an output folder in same folder where script is located.

```powershell
[-Base / -B]
```
Executes the script with asumption that the folder structure of repository has been downloaded and is in use.

```powershell
[-In / -I / -Input]
```
Executes the script with a custom path to where the "json" files are located.
If no "Out" param is provided, an output folder in script root will be created.

```powershell
[-Out / -O / -Output]
```
Executes the script with a custom path to where to store the "pdf" files.
If no "In" param is provided, asumes "InputDirectory" from repo or manually created as location of "json" files.

```powershell
[-C / -Compress]
```
Will ZIP/Compress the output folder. Can be conmbined with all other param except [-Help / -H]

```powershell
[-Help / -H]
```
Only executes the script to show the built-in help message.

### Examples
```powershell
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
```
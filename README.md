# OpenAPI2PDF / RapiPDF - Extension
This is an extension of the work done by : https://github.com/iravikumar0403/openapi2pdf-cli and https://github.com/mrin9/RapiPdf

## About
This is a script with the purpose of automate PDF generation for documentation based on Swagger 2.0 / OpenAPI 3.0 standard.
It can be attached to an automated process or used as is for manual execution when needed.

This is for everyone to use, feel free to fork it, modify it for your usecases. 

## Instructions
### Base Execution
To use it out of the box, Fork/Download this repo and place JSON files in the InputDirectory and run :
Run.ps1 = Main execution file/script.
```powershell
./Run.ps1 -Json
```
Will take the JSON files in "InputDirectory" and convert them to PDF files and store them in a subfolder of "OutputDirectory"

### Alternative Executions (Not Implemented)
This is an alternative execution where the "InputDirectory" and "OutputDirectory" are not needed and wanting to use ones own that already exist.
```powershell
./Run.ps1 -Json -InputPath <full-path-to-folder-where-jsonfiles-are> -OutPath <full-path-to-folder-where-to-store-pdf>

-Json = Bool-flag to indicate the use of local files
-InputPath = Full path to where the files are stored (Optional)
-OutPath = Full path to where the files should be stored after convertion (Optional)
```
If "InputPath" is not passed, it will asume that the files are located in the base location that comes with this repository.
If "OutPath" is not passed, it will asume and store the PDF files in base location that comes with this repository.
```powershell
./Run.ps1 -Url <path-to-url-of-json-definition> -OutPath <full-path-to-folder-where-to-store-pdf>

-Url = Full URL path to JSON-definition online.
-OutPath = Full path to where the files should be stored after convertion (Optional)
```
If "OutPath" is not passed, it will asume and store the PDF files in base location that comes with this repository.
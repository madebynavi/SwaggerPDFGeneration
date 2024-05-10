# OpenAPI2PDF / RapiPDF - Extension
This is an extension of the work done by : https://github.com/iravikumar0403/openapi2pdf-cli and https://github.com/mrin9/RapiPdf

## About
This is a script with the purpose of automate PDF generation for documentation based on Swagger 2.0 / OpenAPI 3.0 standard.
It can be attached to an automated process or used as is for manual execution when needed.

This is for everyone to use, feel free to fork it, modify it for your usecases. 

## Instructions
To use it out of the box, Fork/Download this repo and place JSON files in the InputDirectory and run :
Run.ps1 = Main execution file/script.
```powershell
./Run.ps1 -Json
```
Will take the JSON files in "InputDirectory" and convert them to PDF files and store them in a subfolder of "OutputDirectory"

```powershell
-/Run.ps1 -Url <url-to-json-definition>
```
You will need to enter the URL for the page where the swagger/openapi definition file is displayed. It will convert that and store it also in "OutputDirectory"

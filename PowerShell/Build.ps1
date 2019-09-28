
# source\powershell
$BuildFolder = $PSScriptRoot
# Full Path to powershell folder
$PSFolder = Resolve-Path -Path $PSScriptRoot
# Source folder path
$SourceFolder = Split-Path -Path $PSFolder -Parent

$platyPS = Import-Module platyPS  -PassThru -ErrorAction Ignore
if ($null -eq $platyPS) {
	Install-Module platyPS -Scope CurrentUser -Force
	Import-Module platyPS -Force
} 

$powerShellGet = Import-Module PowerShellGet  -PassThru -ErrorAction Ignore
if ($powerShellGet.Version -lt ([Version]'1.6.0')) {
    Install-Module PowerShellGet -Scope CurrentUser -Force -AllowClobber
    Import-Module PowerShellGet -Force
}

Set-Location $SourceFolder

$OutputPath = "$SourceFolder\Output"
Remove-Item -Path $OutputPath -Force -ErrorAction SilentlyContinue -Recurse 
New-Item -Path $SourceFolder -Name "Output"  -ItemType Directory -Force

New-Item -Path $OutputPath -Name "UniversalDashboard.MaterialUICarousel" -ItemType Directory
New-Item -Path $OutputPath\UniversalDashboard.MaterialUICarousel -Name Help -ItemType Directory

Remove-Item -Path "$PSFolder\index.*.bundle.js" -Force -ErrorAction SilentlyContinue
Remove-Item -Path "$PSFolder\index.*.bundle.js.map" -Force -ErrorAction SilentlyContinue

npm install
npm run build

Copy-Item $PSFolder\index.*.bundle.js $OutputPath\UniversalDashboard.MaterialUICarousel
Copy-Item $PSFolder\index.*.bundle.js.map $OutputPath\UniversalDashboard.MaterialUICarousel
Copy-Item $PSFolder\UniversalDashboard.MaterialUICarousel.psm1 $OutputPath\UniversalDashboard.MaterialUICarousel
Copy-Item $PSFolder\UniversalDashboard.MaterialUICarousel.psd1 $OutputPath\UniversalDashboard.MaterialUICarousel
# Copy-Item $PSFolder\New-UDMarkdown.md $OutputPath\UniversalDashboard.MaterialUICarousel\Help

Remove-Item -Path "$PSFolder\index.*.bundle.js" -Force -ErrorAction SilentlyContinue
Remove-Item -Path "$PSFolder\index.*.bundle.js.map" -Force -ErrorAction SilentlyContinue





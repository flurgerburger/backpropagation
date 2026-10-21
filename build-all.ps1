# PowerShell script to build all 3 neural network executables
$ErrorActionPreference = "Stop"

$scriptDir = $PSScriptRoot
$standaloneDir = Join-Path $scriptDir "executables\standalone"
$fwDir = Join-Path $scriptDir "executables\framework-dependent"
$tmpDir = Join-Path $scriptDir "obj\publish_temp"
$projectPath = Join-Path $scriptDir "BackPropagation.csproj"

New-Item -ItemType Directory -Force -Path $standaloneDir | Out-Null
New-Item -ItemType Directory -Force -Path $fwDir | Out-Null

$targets = @(
    @{ Name = "BackPropBase"; Startup = "CodingBackPropBase.BackPropBase" },
    @{ Name = "BackPropCrossEntropy"; Startup = "CodingBackPropCrossEntropy.BackPropCrossEntropy" },
    @{ Name = "BackPropWeightDecay"; Startup = "CodingBackPropWeightDecay.BackPropWeightDecay" }
)

Write-Host "========================================================" -ForegroundColor Cyan
Write-Host " Building All 3 Neural Network Executables" -ForegroundColor Cyan
Write-Host "========================================================" -ForegroundColor Cyan

foreach ($target in $targets) {
    $name = $target.Name
    $startup = $target.Startup

    # 1. Standalone (Self-contained single file)
    Write-Host "`n--> Publishing Standalone: $name.exe (Self-contained win-x64)..." -ForegroundColor Yellow
    $outDirStandalone = Join-Path $tmpDir "$($name)_Standalone"
    dotnet publish $projectPath -c Release -r win-x64 --self-contained true -p:PublishSingleFile=true -p:StartupObject=$startup -p:AssemblyName=$name -o $outDirStandalone
    Copy-Item (Join-Path $outDirStandalone "$name.exe") (Join-Path $standaloneDir "$name.exe") -Force

    # 2. Framework-dependent single file
    Write-Host "--> Publishing Framework-Dependent: $name.exe..." -ForegroundColor Yellow
    $outDirFw = Join-Path $tmpDir "$($name)_Fw"
    dotnet publish $projectPath -c Release -r win-x64 --self-contained false -p:PublishSingleFile=true -p:StartupObject=$startup -p:AssemblyName=$name -o $outDirFw
    Copy-Item (Join-Path $outDirFw "$name.exe") (Join-Path $fwDir "$name.exe") -Force
}

if (Test-Path $tmpDir) {
    Remove-Item -Recurse -Force $tmpDir
}

Write-Host "`n========================================================" -ForegroundColor Green
Write-Host " All 3 executables successfully generated!" -ForegroundColor Green
Write-Host "  Standalone (Runs anywhere on Windows x64): $standaloneDir" -ForegroundColor Green
Write-Host "  Framework-dependent (Lightweight):         $fwDir" -ForegroundColor Green
Write-Host "========================================================" -ForegroundColor Green

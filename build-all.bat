@echo off
setlocal
echo ========================================================
echo  Building and Publishing All 3 Neural Network Executables
echo ========================================================

set "STANDALONE_DIR=%~dp0executables\standalone"
set "FW_DIR=%~dp0executables\framework-dependent"
set "TMP_DIR=%~dp0obj\publish_temp"

if not exist "%STANDALONE_DIR%" mkdir "%STANDALONE_DIR%"
if not exist "%FW_DIR%" mkdir "%FW_DIR%"

echo.
echo [1/6] Building Standalone BackPropBase.exe...
dotnet publish "%~dp0BackPropagation.csproj" -c Release -r win-x64 --self-contained true -p:PublishSingleFile=true -p:StartupObject=CodingBackPropBase.BackPropBase -p:AssemblyName=BackPropBase -o "%TMP_DIR%\BaseStandalone"
if %ERRORLEVEL% neq 0 goto error
copy /y "%TMP_DIR%\BaseStandalone\BackPropBase.exe" "%STANDALONE_DIR%\BackPropBase.exe" >nul

echo [2/6] Building Standalone BackPropCrossEntropy.exe...
dotnet publish "%~dp0BackPropagation.csproj" -c Release -r win-x64 --self-contained true -p:PublishSingleFile=true -p:StartupObject=CodingBackPropCrossEntropy.BackPropCrossEntropy -p:AssemblyName=BackPropCrossEntropy -o "%TMP_DIR%\CrossEntropyStandalone"
if %ERRORLEVEL% neq 0 goto error
copy /y "%TMP_DIR%\CrossEntropyStandalone\BackPropCrossEntropy.exe" "%STANDALONE_DIR%\BackPropCrossEntropy.exe" >nul

echo [3/6] Building Standalone BackPropWeightDecay.exe...
dotnet publish "%~dp0BackPropagation.csproj" -c Release -r win-x64 --self-contained true -p:PublishSingleFile=true -p:StartupObject=CodingBackPropWeightDecay.BackPropWeightDecay -p:AssemblyName=BackPropWeightDecay -o "%TMP_DIR%\WeightDecayStandalone"
if %ERRORLEVEL% neq 0 goto error
copy /y "%TMP_DIR%\WeightDecayStandalone\BackPropWeightDecay.exe" "%STANDALONE_DIR%\BackPropWeightDecay.exe" >nul

echo [4/6] Building Framework-Dependent BackPropBase.exe...
dotnet publish "%~dp0BackPropagation.csproj" -c Release -r win-x64 --self-contained false -p:PublishSingleFile=true -p:StartupObject=CodingBackPropBase.BackPropBase -p:AssemblyName=BackPropBase -o "%TMP_DIR%\BaseFw"
if %ERRORLEVEL% neq 0 goto error
copy /y "%TMP_DIR%\BaseFw\BackPropBase.exe" "%FW_DIR%\BackPropBase.exe" >nul

echo [5/6] Building Framework-Dependent BackPropCrossEntropy.exe...
dotnet publish "%~dp0BackPropagation.csproj" -c Release -r win-x64 --self-contained false -p:PublishSingleFile=true -p:StartupObject=CodingBackPropCrossEntropy.BackPropCrossEntropy -p:AssemblyName=BackPropCrossEntropy -o "%TMP_DIR%\CrossEntropyFw"
if %ERRORLEVEL% neq 0 goto error
copy /y "%TMP_DIR%\CrossEntropyFw\BackPropCrossEntropy.exe" "%FW_DIR%\BackPropCrossEntropy.exe" >nul

echo [6/6] Building Framework-Dependent BackPropWeightDecay.exe...
dotnet publish "%~dp0BackPropagation.csproj" -c Release -r win-x64 --self-contained false -p:PublishSingleFile=true -p:StartupObject=CodingBackPropWeightDecay.BackPropWeightDecay -p:AssemblyName=BackPropWeightDecay -o "%TMP_DIR%\WeightDecayFw"
if %ERRORLEVEL% neq 0 goto error
copy /y "%TMP_DIR%\WeightDecayFw\BackPropWeightDecay.exe" "%FW_DIR%\BackPropWeightDecay.exe" >nul

rmdir /s /q "%TMP_DIR%" 2>nul

echo.
echo ========================================================
echo  All 3 executables successfully created!
echo  Standalone (no .NET needed): %STANDALONE_DIR%
echo  Framework-Dependent:        %FW_DIR%
echo ========================================================
goto end

:error
echo [ERROR] Build failed.
exit /b 1

:end
endlocal

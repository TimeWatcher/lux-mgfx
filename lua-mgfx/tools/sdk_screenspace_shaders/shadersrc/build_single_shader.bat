@echo off

REM Check if an argument was provided
if "%~1"=="" (
    echo Drag and drop a shader file onto this script
    pause
    exit /b
)

bin\ShaderCompile.exe /O 3 -ver 20b -shaderpath "%cd%" %1

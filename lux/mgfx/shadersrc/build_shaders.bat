@echo off
setlocal enabledelayedexpansion

set "ROOT=%~dp0"
if not defined MGFX_SHADERCOMPILE set "MGFX_SHADERCOMPILE="
set "COMPILER=%MGFX_SHADERCOMPILE%"
if "%COMPILER%"=="" set "COMPILER=%ROOT%..\..\..\tools\mgfx\sdk_screenspace_shaders\shadersrc\bin\ShaderCompile.exe"
set "SRC=%ROOT%src"
set "LIST=%ROOT%compile_shader_list.txt"

if not exist "%COMPILER%" (
  echo Missing ShaderCompile.exe. Restore repository-level tools\mgfx\sdk_screenspace_shaders or set MGFX_SHADERCOMPILE explicitly.
  exit /b 1
)

pushd "%ROOT%"

for /f "usebackq tokens=* delims=" %%A in ("%LIST%") do (
  set "line=%%A"
  echo !line! | findstr /r /c:"^\s*$" >nul
  if !errorlevel! equ 0 (
    rem skip
  ) else (
    echo !line! | findstr /r /c:"^\s*//" >nul
    if !errorlevel! equ 0 (
      rem skip
    ) else (
      set "cleaned=!line:-v-30=!"
      set "cleaned=!cleaned: =!"
      echo Compiling !cleaned!
      "%COMPILER%" /O 3 -ver 30 -shaderpath "%SRC%" !cleaned!
      if errorlevel 1 exit /b 1
    )
  )
)

popd
endlocal

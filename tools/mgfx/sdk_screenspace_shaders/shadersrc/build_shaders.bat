@echo off
setlocal

set ARG1=compile_shader_list
set ARG2=-game
set ARG3=%cd%\.\
set ARG4=-source
set ARG5=.\

set TTEXE=time /t

echo.
echo ==================== buildshaders %* ==================
%TTEXE% -cur-Q
set tt_start=%ERRORLEVEL%
set tt_chkpt=%tt_start%

REM ****************
REM usage: buildshaders <shaderProjectName>
REM ****************

setlocal
set arg_filename=%ARG1%
set shadercompilecommand=ShaderCompile.exe
set targetdir=shaders
set SrcDirBase=..\..
set shaderDir=shaders
set SDKArgs=-local

if "%ARG1%" == "" goto usage
set inputbase=%ARG1%

REM ignore -dx9_30
if /i "%ARG6%" == "-dx9_30" shift /6

if /i "%ARG6%" == "-force30" goto set_force30_arg
goto set_force_end
:set_force30_arg
			set IS30=1
			goto set_force_end
:set_force_end

if /i "%ARG2%" == "-game" goto set_mod_args
goto build_shaders

REM ****************
REM USAGE
REM ****************
:usage
echo.
echo "usage: buildshaders <shaderProjectName> [-game] [gameDir if -game was specified] [-source sourceDir]"
echo "       gameDir is where gameinfo.txt is (where it will store the compiled shaders)."
echo "       sourceDir is where the source code is (where it will find scripts and compilers)."
echo "ex   : buildshaders myshaders"
echo "ex   : buildshaders myshaders -game c:\steam\steamapps\sourcemods\mymod -source c:\mymod\src"
goto :end

REM ****************
REM MOD ARGS - look for -game or the vproject environment variable
REM ****************
:set_mod_args

if not exist "bin\ShaderCompile.exe" goto NoShaderCompile
set ChangeToDir=%SrcDirBase%\bin\

if /i "%ARG4%" NEQ "-source" goto NoSourceDirSpecified
set SrcDirBase=%~5

REM ** use the -game parameter to tell us where to put the files
set targetdir=%~3\shaders

if not exist "%inputbase%.txt" goto InvalidInputFile

goto build_shaders

REM ****************
REM ERRORS
REM ****************
:InvalidInputFile
echo Error: "%inputbase%.txt" is not a valid file.
goto end

:NoSourceDirSpecified
echo ERROR: If you specify -game on the command line, you must specify -source.
goto usage
goto end

:NoShaderCompile
echo - ERROR: ShaderCompile.exe doesn't exist in devtools\bin
goto end

REM ****************
REM BUILD SHADERS
REM ****************
:build_shaders

rem echo --------------------------------
rem echo %inputbase%
rem echo --------------------------------
REM make sure that target dirs exist
REM files will be built in these targets and copied to their final destination
if not exist %shaderDir% mkdir %shaderDir%
if not exist %shaderDir%\fxc mkdir %shaderDir%\fxc
REM Nuke some files that we will add to later.

set SHVER=20b
if defined IS30 (
	set SHVER=30
)

title %ARG1% %SHVER%

echo Building inc files and worklist for %inputbase%...

powershell -NoLogo -ExecutionPolicy Bypass -Command "bin\process_shaders.ps1 -Version %SHVER% '%inputbase%.txt'"

%TTEXE% -diff %tt_start%
echo Done!
echo.

REM ****************
REM END
REM ****************
:end

pause

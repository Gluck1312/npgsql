call "C:\Program Files (x86)\Microsoft Visual Studio\2019\Enterprise\Common7\Tools\VsDevCmd.bat"

set PACKAGES=..\Packages
set SRC=..\src\Npgsql\bin\Release

md %PACKAGES%
rmdir /S /Q %PACKAGES%\build
md %PACKAGES%\build

call :copyplatform netcoreapp3.0
call :copyplatform netstandard2.0
call :copyplatform netstandard2.1

rem copy %SRC%\netstandard2.0\Npgsql.deps.json NuGet\lib\netstandard2.0

rem copy Npgsql.nuspec %PACKAGES%
copy *.png %PACKAGES%\build\

cd %PACKAGES%
nuget pack -BasePath %PACKAGES%\build %~dp0\Npgsql.nuspec
cd %~dp0

rem copy Npgsql.*.nupkg C:\Nuget.Local

rem rmdir /S /Q %USERPROFILE%\.nuget\packages\npgsql

rem del %PACKAGES%\Npgsql.nuspec
rem del %PACKAGES%\*.png

rmdir /S /Q %PACKAGES%\build

rmdir /S /Q %USERPROFILE%\.nuget\packages\npgsql

exit /b
:copyplatform
md %PACKAGES%\build\lib\%1
copy %SRC%\%1\Npgsql.dll %PACKAGES%\build\lib\%1
copy %SRC%\%1\Npgsql.pdb %PACKAGES%\build\lib\%1
copy %SRC%\%1\Npgsql.xml %PACKAGES%\build\lib\%1

exit /b
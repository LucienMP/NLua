
rem set PATH=%PATH%;C:\Program Files (x86)\NUnit 2.6.3\bin

erase tests\*.dll
cd Core\KeraLua
call Makefile.Win64.bat
msbuild KeraLua.Net40.sln /p:Configuration=Release /p:PlatformTarget=x64 /t:Clean,Build
cd ..\..
xcopy Core\KeraLua\external\lua\win64\bin64\*.dll tests\*.dll
msbuild NLua.Net40.sln /p:Configuration=Release /p:PlatformTarget=x64 /t:Clean,Build
cd tests/

rem This JITS to 64bit on 64 CPU, 32bit on 32 CPU
nunit-console NLuaTest.dll /xml=$1
cd ..

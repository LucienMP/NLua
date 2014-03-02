
rem set PATH=%PATH%;C:\Program Files (x86)\NUnit 2.6.3\bin

erase tests\*.dll
cd Core\KeraLua
call Makefile.Win32.bat
msbuild KeraLua.Net40.sln /p:Configuration=Release /p:Platform="Any CPU" /p:PlatformTarget=x86 /t:Clean,Build
cd ..\..
xcopy Core\KeraLua\external\lua\win32\bin\*.dll tests\*.dll
msbuild NLua.Net40.sln /p:Configuration=Release /p:Platform="Any CPU" /p:PlatformTarget=x86 /t:Clean,Build
cd tests/

rem Force JITS to 32bit on 32/64 bit CPU
nunit-console-x86 NLuaTest.dll /xml=$1
cd ..


@echo off
rem Rebuild the debug APK using the toolchain installed at C:\Android.
set "JAVA_HOME=C:\Program Files\Eclipse Adoptium\jdk-17.0.21.10002-hotspot"
set "ANDROID_HOME=C:\Android\sdk"
set "ANDROID_SDK_ROOT=C:\Android\sdk"
set "GRADLE_USER_HOME=C:\Android\gradle-home"
set "PATH=%JAVA_HOME%\bin;C:\Android\sdk\platform-tools;%PATH%"
cd /d "%~dp0"
call "C:\Android\gradle\gradle-8.7\bin\gradle.bat" assembleDebug --no-daemon --console=plain
if errorlevel 1 (
    echo.
    echo BUILD FAILED
    exit /b 1
)
copy /y "app\build\outputs\apk\debug\app-debug.apk" "HelloApk-debug.apk" >nul
echo.
echo BUILD OK: %~dp0HelloApk-debug.apk

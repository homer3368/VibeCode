@echo off
setlocal
rem Build the APK, commit everything and push to GitHub in one step.
rem Usage: publish.cmd "commit message"   (message is optional)
set "JAVA_HOME=C:\Program Files\Eclipse Adoptium\jdk-17.0.21.10002-hotspot"
set "ANDROID_HOME=C:\Android\sdk"
set "ANDROID_SDK_ROOT=C:\Android\sdk"
set "GRADLE_USER_HOME=C:\Android\gradle-home"
set "GIT=C:\Program Files\Git\cmd\git.exe"
set "PATH=%JAVA_HOME%\bin;C:\Program Files\Git\cmd;C:\Android\sdk\platform-tools;%PATH%"
cd /d "%~dp0"

set "MSG=%~1"
if "%MSG%"=="" set "MSG=Update %DATE% %TIME%"

echo [1/4] Building APK...
call "C:\Android\gradle\gradle-8.7\bin\gradle.bat" assembleDebug --no-daemon --console=plain -q
if errorlevel 1 (
    echo.
    echo BUILD FAILED - nothing was committed.
    exit /b 1
)
copy /y "app\build\outputs\apk\debug\app-debug.apk" "HelloApk-debug.apk" >nul

echo [2/4] Staging changes...
"%GIT%" add -A

echo [3/4] Committing: %MSG%
"%GIT%" commit -m "%MSG%"
if errorlevel 1 echo Nothing to commit, pushing anyway.

echo [4/4] Pushing to origin/main...
"%GIT%" push origin main
if errorlevel 1 (
    echo.
    echo PUSH FAILED
    exit /b 1
)

echo.
echo Done: https://github.com/homer3368/VibeCode

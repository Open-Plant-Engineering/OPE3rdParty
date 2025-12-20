@echo off
setlocal

REM ============================
REM   FOLDER STRUCTURE
REM ============================
set ROOT_DIR=%CD%
set DOWNLOAD_DIR=%ROOT_DIR%\Download
set INSTALL_DIR=%ROOT_DIR%\Install\libgit2
set REPO_DIR=%DOWNLOAD_DIR%\libgit2
set BUILD_DIR=%DOWNLOAD_DIR%\build-mingw64
set MINGW_PATH=C:\msys64\mingw64\bin

REM ============================
REM   CHECK MINGW
REM ============================
if not exist "%MINGW_PATH%\gcc.exe" (
    echo MinGW-w64 not found at %MINGW_PATH%
    pause
    exit /b 1
)

set PATH=%MINGW_PATH%;%PATH%

REM ============================
REM   CREATE FOLDERS
REM ============================
mkdir "%DOWNLOAD_DIR%" 2>nul
mkdir "%INSTALL_DIR%" 2>nul

REM ============================
REM   CLONE OR UPDATE REPO
REM ============================
if not exist "%REPO_DIR%" (
    echo Cloning libgit2...
    git clone --recursive https://github.com/libgit2/libgit2.git "%REPO_DIR%"
) else (
    echo Updating libgit2...
    cd "%REPO_DIR%"
    git pull
    git submodule update --init --recursive
    cd "%ROOT_DIR%"
)

REM ============================
REM   CREATE BUILD DIR
REM ============================
mkdir "%BUILD_DIR%" 2>nul
cd "%BUILD_DIR%"

REM ============================
REM   CONFIGURE WITH CMAKE
REM ============================
cmake "%REPO_DIR%" ^
    -G "MinGW Makefiles" ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DCMAKE_INSTALL_PREFIX="%INSTALL_DIR%" ^
    -DBUILD_SHARED_LIBS=ON ^
    -DUSE_SSH=OFF ^
    -DUSE_HTTPS=ON

if errorlevel 1 (
    echo CMake configuration failed
    pause
    exit /b 1
)

REM ============================
REM   BUILD
REM ============================
mingw32-make -j4
if errorlevel 1 (
    echo Build failed
    pause
    exit /b 1
)

REM ============================
REM   INSTALL
REM ============================
mingw32-make install

echo.
echo ==========================================
echo libgit2 built and installed successfully!
echo Installed to:
echo   %INSTALL_DIR%
echo ==========================================
echo.
pause
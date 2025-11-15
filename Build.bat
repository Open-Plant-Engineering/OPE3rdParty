set OPE3rdParty_DIR=%cd%

rem setup by user
set OCC3RDPARTY_DIR=E:/SKGitRepo/OpenCascade/3rdParty
E:
rem setup by user

rem Automatic Download process for OCCT
echo Cloning OCCT repository...
git clone https://github.com/Open-Cascade-SAS/OCCT.git "%OPE3rdParty_DIR%/Download/OCCT"
cd "%OPE3rdParty_DIR%/Download/OCCT"
git pull
git checkout master

echo Configuring Debug build...
mkdir "%OPE3rdParty_DIR%/Download/OCCT/Build"
cmake -S "%OPE3rdParty_DIR%/Download/OCCT" -B "%OPE3rdParty_DIR%/Download/OCCT/Build" -D3RDPARTY_DIR=%OCC3RDPARTY_DIR% -DCMAKE_BUILD_TYPE=Debug -DINSTALL_DIR=%OPE3rdParty_DIR%/Install/OCCT -DUSE_FREETYPE=TRUE -DUSE_TK=TRUE -DUSE_VTK=TRUE -DINSTALL_FREETYPE=TRUE -DINSTALL_SAMPLES=TRUE -DINSTALL_TK=TRUE -DINSTALL_VTK=TRUE -DUSE_OPENGL=TRUE -DINSTALL_TCL=TRUE

rem set MSBuild_DIR=C:/Program Files/Microsoft Visual Studio/2022/Community/MSBuild/Current/Bin
rem If required generate using below script
rem "%MSBuild_DIR%/MSBuild.exe" OCCT.sln /p:Configuration=Debug /p:Platform="x64"
rem If required generate using below script
rem "%MSBuild_DIR%/MSBuild.exe" OCCT.sln /p:Configuration=Release /p:Platform="x64"

echo Building - Installing Debug and Release...
cmake --build "%OPE3rdParty_DIR%/Download/OCCT/Build" --target INSTALL --config Debug
cmake --build "%OPE3rdParty_DIR%/Download/OCCT/Build" --target INSTALL --config Release

cd "%OPE3rdParty_DIR%"

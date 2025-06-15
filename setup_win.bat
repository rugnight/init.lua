@echo off

REM ==================================================
REM 改行コードはCR+LFで保存しましょう
REM ==================================================
chcp 65001

set BAT_DIR=%~dp0

REM ==================================================
REM XDG Base Directory
REM ==================================================

if not exist %USERPROFILE%\.config      mkdir %USERPROFILE%\.config
if not exist %USERPROFILE%\.data        mkdir %USERPROFILE%\.data
if not exist %USERPROFILE%\.cache       mkdir %USERPROFILE%\.cache
if not exist %USERPROFILE%\.runtime     mkdir %USERPROFILE%\.runtime

setx XDG_CONFIG_HOME    %USERPROFILE%\.config
setx XDG_DATA_HOME      %USERPROFILE%\.data
setx XDG_CACHE_HOME     %USERPROFILE%\.cache
setx XDG_RUNTIME_DIR    %USERPROFILE%\.runtime

REM ==================================================
REM 標準の環境変数の確認
REM ==================================================

echo [環境変数]
echo APPDATA           %APPDATA%
echo LOCALAPPDATA      %LOCALAPPDATA%
echo USERPROFILE       %USERPROFILE%
echo HOMEDRIVE         %HOMEDRIVE%
echo XDG_CONFIG_HOME   %XDG_CONFIG_HOME%
echo XDG_DATA_HOME     %XDG_DATA_HOME%
echo XDG_CACHE_HOME    %XDG_CACHE_HOME%
echo XDG_RUNTIME_DIR   %XDG_RUNTIME_DIR%
echo .


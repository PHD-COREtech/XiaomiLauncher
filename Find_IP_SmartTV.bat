@echo off
setlocal
chcp 65001 >nul
title Quet Tim IP Smart TV (Port 5555 ADB)

if exist "%~dp0Find_IP_SmartTV.ps1" (
    powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0Find_IP_SmartTV.ps1"
) else (
    echo [!] Khong tim thay file Find_IP_SmartTV.ps1 cung thu muc!
)

pause

@echo off
setlocal
echo ================================================================
echo  SEFU HMIS - DISASTER RECOVERY BACKUP & VERIFICATION
echo  Kenya Digital Health Agency (DHA) Certification Tool
echo ================================================================
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0drp_backup_verify.ps1"
echo.
pause

@echo off
Powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "& '%~dpn0.ps1' '%*' "

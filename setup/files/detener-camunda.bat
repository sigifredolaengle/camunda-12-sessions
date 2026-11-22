@echo off
rem Detiene Camunda 8 Run. Curso "Camunda en 12 sesiones".
setlocal
set "C8DIR="
for /d %%D in ("C:\camunda\c8run*") do set "C8DIR=%%D"
if not defined C8DIR (
  echo No se encontro Camunda 8 Run en C:\camunda.
  pause
  exit /b 1
)
cd /d "%C8DIR%"
c8run.exe stop
echo Camunda detenido.
timeout /t 5 >nul

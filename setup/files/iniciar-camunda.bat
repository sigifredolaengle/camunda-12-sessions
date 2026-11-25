@echo off
rem Inicia Camunda 8 Run y abre Operate y Tasklist cuando esta listo.
rem Curso "Camunda en 12 sesiones". Camunda debe estar en C:\camunda\c8run-8.9...
setlocal
set "C8DIR="
for /d %%D in ("C:\camunda\c8run*") do set "C8DIR=%%D"
if not defined C8DIR (
  echo No se encontro Camunda 8 Run en C:\camunda.
  pause
  exit /b 1
)

curl.exe -s -o nul http://localhost:8080/v2/topology && goto abrir

echo Iniciando Camunda 8 Run desde %C8DIR% ...
start "Camunda 8 Run" /min /d "%C8DIR%" c8run.exe start

echo Esperando a que Camunda este listo (1 a 3 minutos). No cierre esta ventana.
set /a INTENTOS=0
:esperar
timeout /t 5 /nobreak >nul
set /a INTENTOS+=1
curl.exe -s -o nul http://localhost:8080/v2/topology && goto abrir
if %INTENTOS% geq 60 (
  echo Camunda no respondio en 5 minutos. Revise %C8DIR%\log\camunda.log
  echo Causa frecuente: poco espacio libre en el disco.
  pause
  exit /b 1
)
goto esperar

:abrir
echo.
echo Camunda esta listo. Usuario y clave de Operate y Tasklist: demo / demo
start "" "http://localhost:8080/operate"
start "" "http://127.0.0.1:8080/tasklist"
timeout /t 5 >nul
exit /b 0

@echo off
cd /d "%~dp0"
echo Iniciando Cine Nova...
mvn compile exec:java
pause

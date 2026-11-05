@echo off
rem ------------------------------------------------------------------
rem  Lanzador de Maven para Windows (no requiere instalar Maven).
rem  La primera vez descarga Maven 3.9.9 en %USERPROFILE%\.m2\wrapper
rem  Uso:  mvnw.cmd test      |   mvnw.cmd compile
rem ------------------------------------------------------------------
setlocal
set "MVN_VERSION=3.9.9"
set "WRAPPER_DIR=%USERPROFILE%\.m2\wrapper"
set "MVN_HOME=%WRAPPER_DIR%\apache-maven-%MVN_VERSION%"

if defined JAVA_HOME goto checkMaven
if exist "%USERPROFILE%\.jdks\jbr-21.0.11\bin\java.exe" (
  set "JAVA_HOME=%USERPROFILE%\.jdks\jbr-21.0.11"
  goto checkMaven
)
if exist "%USERPROFILE%\.jdks\jbr-17.0.14\bin\java.exe" (
  set "JAVA_HOME=%USERPROFILE%\.jdks\jbr-17.0.14"
  goto checkMaven
)

:checkMaven
if exist "%MVN_HOME%\bin\mvn.cmd" goto run
echo Descargando Maven %MVN_VERSION% (solo la primera vez)...
if not exist "%WRAPPER_DIR%" mkdir "%WRAPPER_DIR%"
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
  "$ProgressPreference='SilentlyContinue';" ^
  "[Net.ServicePointManager]::SecurityProtocol=[Net.SecurityProtocolType]::Tls12;" ^
  "Invoke-WebRequest -Uri 'https://repo.maven.apache.org/maven2/org/apache/maven/apache-maven/%MVN_VERSION%/apache-maven-%MVN_VERSION%-bin.zip' -OutFile '%WRAPPER_DIR%\maven.zip';" ^
  "Expand-Archive -Path '%WRAPPER_DIR%\maven.zip' -DestinationPath '%WRAPPER_DIR%' -Force;" ^
  "Remove-Item '%WRAPPER_DIR%\maven.zip'"
if not exist "%MVN_HOME%\bin\mvn.cmd" (
  echo No se pudo descargar Maven. Revisa tu conexion a internet.
  exit /b 1
)

:run
call "%MVN_HOME%\bin\mvn.cmd" %*
exit /b %ERRORLEVEL%

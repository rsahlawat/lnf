@echo off

echo     Program Name:           Temperature Converter >> DEPLOY.log
echo     Developer Name:         Neil Ahlawat          >> DEPLOY.log
echo     Purpose:                DEV                   >> DEPLOY.log
echo     Date:                   %date% %time%         >> DEPLOY.log
echo                                                   >> DEPLOY.log

set "_cd=%cd:\=" & set "_cd=%"

set CLS_DIR=%cd%\target\classes
set LIB_DIR=%cd%\lib
set APACHE_DIR=C:\Program Files\Apache Software Foundation\Tomcat 10.1
set APP_DIR=%APACHE_DIR%\webapps\%_cd%
set OUTPUT_CLS_DIR=%APP_DIR%\WEB-INF\classes
set OUTPUT_LIB_DIR=%APP_DIR%\WEB-INF\lib

echo %CLS_DIR%
echo %LIB_DIR%
echo %APACHE_DIR%
echo %APP_DIR%
echo %OUTPUT_CLS_DIR%
echo %OUTPUT_LIB_DIR%

if [%1] == [] (
        GOTO CLASSES
) else (
    if [%1] == [Full] (
        GOTO FULL
    ) else (
        GOTO USAGE
    )
)

:FULL
    echo FULL....
    if exist "%APP_DIR%" (rmdir /s /q "%APP_DIR%")
    if exist "%APACHE_DIR%/opennlp-models" (rmdir /s /q "%APACHE_DIR%/opennlp-models")
    ECHO %APP_DIR%
    mkdir "%APP_DIR%"
    mkdir "%APP_DIR%\WEB-INF"
    mkdir "%OUTPUT_LIB_DIR%"
    mkdir "%APACHE_DIR%/opennlp-models"
    call mvn dependency:copy-dependencies -DoutputDirectory="%OUTPUT_LIB_DIR%"
    xcopy "%LIB_DIR%" "%OUTPUT_LIB_DIR%" /E /H
    xcopy "%cd%/web" "%APP_DIR%" /E /H
    xcopy "%cd%/WEB-INF" "%APP_DIR%\WEB-INF" /E /H
    xcopy "%cd%/opennlp-models" "%APACHE_DIR%/opennlp-models" /E /H
GOTO CLASSES

:CLASSES
    echo CLASSES....
    echo DELETING THE CLASSESS FOLDER AT %OUTPUT_CLS_DIR%
    if exist "%OUTPUT_CLS_DIR%" (rmdir /s /q "%OUTPUT_CLS_DIR%") 
    mkdir "%OUTPUT_CLS_DIR%"
    xcopy "%CLS_DIR%" "%OUTPUT_CLS_DIR%" /E /H
GOTO EXIT0

:USAGE
    echo.
    echo DONT YOU KNOW HOW THIS WORKS
    echo.
GOTO EXIT0

:EXIT0
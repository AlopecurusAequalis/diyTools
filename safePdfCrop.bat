@echo off
for %%A in (*.pdf) do (
  call pdfcrop %%A
)

if %ERRORLEVEL% == 0 (
  for /f "delims=" %%a in ('dir /B *.pdf ^| find /V "-crop.pdf"') do del %%a
) else (
  echo なんかヤヴァくね?
  pause
)

for %%f in ( * ) do call :sub "%%f"

exit /b

:sub
set fname=%1
set fname=%fname:-crop.pdf=.pdf %
move /-y %1 %fname%
goto :EOF

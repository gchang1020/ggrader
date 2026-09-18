@echo off
set RARFILE=d:\temp\PresentationGrader.rar
set SRC=D:\workspace\PresentationGrader

if exist "%RARFILE%" del "%RARFILE%"

winrar a -r "%RARFILE%" "%SRC%\" ^
  -x"*.venv\" ^
  -x"*.git\" ^
  -x"*__pycache__\" ^
  -x"README.html" -x"*\README.html"

copy /Y %RARFILE% "D:\utd\2026-Fall\PSCI-3350-Ho"
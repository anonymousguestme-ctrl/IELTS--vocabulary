@echo off
setlocal
cd /d "%~dp0.."

set "PYTHON_CMD="
where py >nul 2>&1
if not errorlevel 1 set "PYTHON_CMD=py -3"
if not defined PYTHON_CMD (
  where python >nul 2>&1
  if not errorlevel 1 set "PYTHON_CMD=python"
)

if not defined PYTHON_CMD (
  echo 未找到 Python 3。请先从 https://www.python.org/downloads/windows/ 安装 Python 3。
  pause
  exit /b 1
)

set "APP_URL=http://127.0.0.1:8765/"
echo 正在启动本地雅思词汇本...
echo 服务地址：%APP_URL%

powershell -NoProfile -Command "try { Invoke-WebRequest -UseBasicParsing -TimeoutSec 1 '%APP_URL%' ^| Out-Null; exit 0 } catch { exit 1 }"
if not errorlevel 1 (
  echo 检测到已有服务，直接打开现有页面。
  start "" "%APP_URL%"
  exit /b 0
)

start "IELTS Vocabulary Server" /min cmd /c "%PYTHON_CMD% server.py"
for /l %%N in (1,1,40) do (
  powershell -NoProfile -Command "try { Invoke-WebRequest -UseBasicParsing -TimeoutSec 1 '%APP_URL%' ^| Out-Null; exit 0 } catch { exit 1 }"
  if not errorlevel 1 goto ready
  timeout /t 1 /nobreak >nul
)

echo 服务启动超时，请检查 Python 或服务器窗口中的错误。
pause
exit /b 1

:ready
start "" "%APP_URL%"
echo 已打开浏览器。服务器窗口可以保持运行，关闭它即可停止服务。
exit /b 0

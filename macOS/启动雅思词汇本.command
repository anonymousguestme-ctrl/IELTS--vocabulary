#!/bin/zsh

PROJECT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
cd "$PROJECT_DIR" || exit 1

if ! command -v python3 >/dev/null 2>&1; then
  echo "未找到 Python 3，请先安装 Python 3。"
  read -r "?按回车键退出："
  exit 1
fi

echo "正在启动本地雅思词汇本..."
echo "服务地址：http://127.0.0.1:8765/"

if curl --silent --output /dev/null --max-time 1 http://127.0.0.1:8765/; then
  echo "检测到 8765 端口已有服务，已直接打开现有页面，不重复启动。"
else
  python3 server.py &
  server_pid=$!
  trap 'kill $server_pid 2>/dev/null || true' EXIT
  until curl --silent --output /dev/null --max-time 1 http://127.0.0.1:8765/; do sleep 0.2; done
fi

if [ -d "/Applications/Google Chrome.app" ] || [ -d "${HOME}/Applications/Google Chrome.app" ]; then
  open -a "Google Chrome" "http://127.0.0.1:8765/"
else
  open "http://127.0.0.1:8765/"
fi
echo "关闭此窗口即可停止服务。"
wait $server_pid 2>/dev/null

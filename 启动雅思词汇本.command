#!/bin/zsh

PROJECT_DIR="/Users/adele/Desktop/IELTS- vocabulary"
cd "$PROJECT_DIR" || exit 1

if ! command -v python3 >/dev/null 2>&1; then
  echo "未找到 Python 3，请先安装 Python 3。"
  read -r "?按回车键退出："
  exit 1
fi

echo "正在启动本地雅思词汇本..."
open "http://127.0.0.1:8765/"
echo "服务地址：http://127.0.0.1:8765/"
echo "关闭此窗口即可停止服务。"

if curl --silent --output /dev/null --max-time 1 http://127.0.0.1:8765/; then
  echo "检测到 8765 端口已有服务，已直接打开现有页面，不重复启动。"
  exit 0
fi

python3 server.py

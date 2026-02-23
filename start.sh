#!/bin/bash

# WisHub MVP 启动脚本
# 用途：启动WisHub MVP的所有服务

set -e  # 遇到错误立即退出

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 项目根目录
PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$PROJECT_DIR"

# 检查虚拟环境
if [ ! -d "venv" ]; then
    echo -e "${RED}错误: 虚拟环境不存在${NC}"
    echo "请先运行: python3 -m venv venv"
    exit 1
fi

# 激活虚拟环境
echo -e "${GREEN}激活虚拟环境...${NC}"
source venv/bin/activate

# 检查.env文件
if [ ! -f ".env" ]; then
    echo -e "${YELLOW}警告: .env文件不存在，使用默认配置${NC}"
fi

# 加载环境变量
if [ -f ".env" ]; then
    export $(cat .env | grep -v '^#' | xargs)
fi

# 创建必要目录
echo -e "${GREEN}创建必要目录...${NC}"
mkdir -p data/faiss data/files data/redis logs

# 检查Redis配置
USE_REDIS=${USE_REDIS:-true}
echo -e "${YELLOW}使用Redis: $USE_REDIS${NC}"

# 启动Redis（如果配置）
if [ "$USE_REDIS" = "true" ]; then
    echo -e "${GREEN}启动Redis...${NC}"

    # 检查Redis是否已运行
    if pgrep -x "redis-server" > /dev/null; then
        echo -e "${YELLOW}Redis已经在运行${NC}"
    else
        redis-server --port 6379 --daemonize yes --dir ./data/redis --logfile ./logs/redis.log

        # 等待Redis启动
        sleep 2

        # 检查Redis是否启动成功
        if ! redis-cli ping > /dev/null 2>&1; then
            echo -e "${RED}Redis启动失败${NC}"
            echo "请查看日志: logs/redis.log"
            exit 1
        fi

        echo -e "${GREEN}Redis启动成功${NC}"
    fi
else
    echo -e "${YELLOW}不使用Redis，使用内存缓存${NC}"
fi

# 检查数据库是否初始化
if [ ! -f "data/wishub.db" ]; then
    echo -e "${YELLOW}数据库不存在，正在初始化...${NC}"
    python scripts/init_db.py
fi

# 检查API是否已运行
if [ -f "wishub-api.pid" ]; then
    PID=$(cat wishub-api.pid)
    if ps -p $PID > /dev/null; then
        echo -e "${YELLOW}WisHub API已经在运行 (PID: $PID)${NC}"
        echo "如需重启，请先运行: bash stop.sh"
        exit 0
    fi
fi

# 启动FastAPI应用
echo -e "${GREEN}启动WisHub API...${NC}"
nohup python -m uvicorn app.main:app --host 0.0.0.0 --port 8000 > logs/wishub-api.log 2>&1 &
API_PID=$!

# 保存PID
echo $API_PID > wishub-api.pid

# 等待API启动
sleep 3

# 检查API是否启动成功
if ! ps -p $API_PID > /dev/null; then
    echo -e "${RED}WisHub API启动失败${NC}"
    echo "请查看日志: logs/wishub-api.log"
    rm -f wishub-api.pid
    exit 1
fi

# 测试API健康检查
echo -e "${GREEN}检查API健康状态...${NC}"
sleep 2
if curl -s http://localhost:8000/api/v1/health > /dev/null; then
    echo -e "${GREEN}API健康检查通过${NC}"
else
    echo -e "${YELLOW}API健康检查失败，但服务可能仍在启动中${NC}"
fi

echo ""
echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}WisHub MVP 启动成功！${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""
echo -e "WisHub API PID: $API_PID"
echo -e "API地址: ${GREEN}http://localhost:8000${NC}"
echo -e "API文档: ${GREEN}http://localhost:8000/docs${NC}"
echo -e "Web UI: ${GREEN}http://localhost:8000${NC}"
echo ""
echo -e "查看日志: ${YELLOW}tail -f logs/wishub-api.log${NC}"
echo -e "停止服务: ${YELLOW}bash stop.sh${NC}"
echo -e "重启服务: ${YELLOW}bash restart.sh${NC}"
echo ""

#!/bin/bash

# WisHub MVP 停止脚本
# 用途：停止WisHub MVP的所有服务

set -e  # 遇到错误立即退出

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 项目根目录
PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$PROJECT_DIR"

# 加载环境变量
if [ -f ".env" ]; then
    export $(cat .env | grep -v '^#' | xargs)
fi

USE_REDIS=${USE_REDIS:-true}

echo -e "${GREEN}停止WisHub MVP...${NC}"
echo ""

# 停止FastAPI应用
if [ -f "wishub-api.pid" ]; then
    PID=$(cat wishub-api.pid)

    if ps -p $PID > /dev/null; then
        echo -e "${YELLOW}停止WisHub API (PID: $PID)...${NC}"
        kill $PID

        # 等待进程结束
        for i in {1..10}; do
            if ! ps -p $PID > /dev/null; then
                echo -e "${GREEN}WisHub API已停止${NC}"
                break
            fi
            sleep 1
        done

        # 强制杀死进程（如果还在运行）
        if ps -p $PID > /dev/null; then
            echo -e "${YELLOW}强制停止WisHub API...${NC}"
            kill -9 $PID
            echo -e "${GREEN}WisHub API已强制停止${NC}"
        fi
    else
        echo -e "${YELLOW}WisHub API进程不存在 (PID: $PID)${NC}"
    fi

    rm -f wishub-api.pid
else
    echo -e "${YELLOW}wishub-api.pid文件不存在${NC}"
fi

echo ""

# 停止Redis（如果配置）
if [ "$USE_REDIS" = "true" ]; then
    echo -e "${YELLOW}检查Redis进程...${NC}"

    # 查找Redis进程
    REDIS_PID=$(pgrep -x "redis-server" || true)

    if [ ! -z "$REDIS_PID" ]; then
        echo -e "${YELLOW}停止Redis (PID: $REDIS_PID)...${NC}"

        # 尝试优雅关闭
        redis-cli shutdown || true

        # 等待Redis关闭
        sleep 2

        # 检查是否还在运行
        if pgrep -x "redis-server" > /dev/null; then
            echo -e "${YELLOW}强制停止Redis...${NC}"
            pkill -9 redis-server
        fi

        echo -e "${GREEN}Redis已停止${NC}"
    else
        echo -e "${YELLOW}Redis未运行${NC}"
    fi
fi

echo ""
echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}WisHub MVP 已停止！${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""

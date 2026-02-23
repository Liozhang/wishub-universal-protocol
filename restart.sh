#!/bin/bash

# WisHub MVP 重启脚本
# 用途：重启WisHub MVP的所有服务

set -e  # 遇到错误立即退出

# 颜色定义
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 项目根目录
PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$PROJECT_DIR"

echo -e "${GREEN}重启WisHub MVP...${NC}"
echo ""

# 停止服务
echo -e "${YELLOW}停止服务...${NC}"
bash stop.sh

# 等待2秒
echo ""
echo -e "${YELLOW}等待2秒...${NC}"
sleep 2
echo ""

# 启动服务
echo -e "${YELLOW}启动服务...${NC}"
bash start.sh

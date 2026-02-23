# WisHub MVP - 最小实现版本

WisHub v5.1.0 最小可行产品（MVP），单机部署，无需Docker，无需sudo权限。

## 项目简介

WisHub MVP是WisHub项目的最小实现版本，旨在在单机环境上实现所有核心功能，为后续分布式部署提供基础验证和技术积累。

### 核心特性

- ✅ WisUnit三层架构（可执行层、结构层、自然语言层）
- ✅ WisUnit CRUD操作
- ✅ WisStore（多级存储和索引）
- ✅ WisVerify（四级验证系统）
- ✅ WisIncentive（信用+赏金+声誉）
- ✅ WisDedup（智能去重）
- ✅ 智核（Wisdom Core）
- ✅ AI自动生成
- ✅ Agent生态（2-3种Agent类型）
- ✅ L4.5验证（AI内容验证）
- ✅ 知识图谱（基本图数据库支持）
- ✅ 领域支持（医学、金融、法律、教育）
- ✅ **无需Docker**
- ✅ **无需sudo权限**

## 快速开始

### 系统要求

**硬件要求**：
- CPU: 4核心（推荐8核心）
- 内存: 8GB（推荐16GB）
- 存储: 200GB SSD（推荐512GB）

**软件要求**：
- Python 3.10+
- pip
- Redis 7+（可选）
- Git

### 5分钟快速启动

```bash
# 1. 克隆仓库
git clone https://github.com/wishub/wishub-mvp.git
cd wishub-mvp

# 2. 创建虚拟环境
python3 -m venv venv
source venv/bin/activate

# 3. 安装依赖
pip install -r requirements.txt

# 4. 配置环境变量
cp .env.example .env
vim .env  # 至少需要设置AI_API_KEY

# 5. 启动服务
chmod +x start.sh stop.sh restart.sh
bash start.sh

# 6. 验证安装
curl http://localhost:8000/api/v1/health
open http://localhost:8000/docs
```

### 停止服务

```bash
bash stop.sh
```

### 重启服务

```bash
bash restart.sh
```

## 使用指南

### Web UI

访问 http://localhost:8000

### CLI命令

```bash
# 激活虚拟环境
source venv/bin/activate

# 创建WisUnit
wishub-cli create-wisunit wisunit.json

# 搜索WisUnit
wishub-cli search "糖尿病诊断"

# 调用Agent
wishub-cli agent query --query "糖尿病诊断"
```

### REST API

#### 健康检查
```bash
curl http://localhost:8000/api/v1/health
```

#### 创建WisUnit
```bash
curl -X POST http://localhost:8000/api/v1/wisunits \
  -H "Content-Type: application/json" \
  -d @wisunit.json
```

#### 搜索WisUnit
```bash
curl "http://localhost:8000/api/v1/wisunits/search?query=糖尿病诊断"
```

#### 调用Agent
```bash
curl -X POST http://localhost:8000/api/v1/agents/query/execute \
  -H "Content-Type: application/json" \
  -d '{"task": {"query": "糖尿病诊断"}}'
```

## 服务管理

### 使用启动脚本

```bash
# 启动服务
bash start.sh

# 停止服务
bash stop.sh

# 重启服务
bash restart.sh

# 查看日志
tail -f logs/wishub-api.log
```

### 使用Supervisord（推荐，无需sudo）

```bash
# 安装Supervisord
pip install supervisor

# 启动所有服务
supervisord -c supervisord.conf

# 查看服务状态
supervisorctl -c supervisord.conf status

# 启动/停止/重启服务
supervisorctl -c supervisord.conf start wishub-api
supervisorctl -c supervisord.conf stop wishub-api
supervisorctl -c supervisord.conf restart wishub-api

# 查看日志
supervisorctl -c supervisord.conf tail -f wishub-api

# 停止所有服务
supervisorctl -c supervisord.conf shutdown
```

## 项目结构

```
wishub-mvp/
├── app/                    # FastAPI应用核心代码
│   ├── main.py            # 应用入口
│   ├── config.py          # 配置管理
│   ├── models/            # 数据模型
│   ├── api/               # API路由
│   ├── services/          # 业务逻辑
│   ├── agents/            # Agent实现
│   ├── storage/           # 存储层
│   ├── verification/      # 验证
│   ├── domains/           # 领域支持
│   └── utils/             # 工具函数
├── cli/                   # CLI工具
├── web/                   # Web UI
├── tests/                 # 测试
├── data/                  # 数据目录
├── scripts/               # 脚本
├── logs/                  # 日志目录
├── venv/                  # Python虚拟环境
├── .env.example           # 环境变量模板
├── start.sh               # 启动脚本
├── stop.sh                # 停止脚本
├── restart.sh             # 重启脚本
├── supervisord.conf       # Supervisord配置
├── requirements.txt       # Python依赖
└── README.md              # 项目说明
```

## 配置说明

### 环境变量

复制 `.env.example` 为 `.env` 并编辑：

```bash
cp .env.example .env
vim .env
```

**必需配置**：
- `AI_API_KEY`: AI API密钥（从OpenAI或其他AI服务商获取）

**可选配置**：
- `AI_MODEL`: AI模型名称（默认gpt-4）
- `USE_REDIS`: 是否使用Redis（默认true）
- `DATABASE_URL`: 数据库连接URL（默认sqlite:///data/wishub.db）
- `API_PORT`: API端口（默认8000）

## 测试

```bash
# 激活虚拟环境
source venv/bin/activate

# 运行单元测试
pytest

# 运行集成测试
pytest tests/integration/

# 生成覆盖率报告
pytest --cov=app --cov-report=html
```

## 故障排除

### 问题1：服务无法启动

```bash
# 检查虚拟环境
which python

# 检查端口占用
lsof -i :8000

# 查看日志
tail -f logs/wishub-api.log
```

### 问题2：AI API调用失败

```bash
# 检查API Key
cat .env | grep AI_API_KEY

# 测试API连接
curl -H "Authorization: Bearer $AI_API_KEY" \
  https://api.openai.com/v1/models
```

### 问题3：数据库错误

```bash
# 检查数据库文件
ls -l data/wishub.db

# 重新初始化数据库
python scripts/init_db.py
```

## 卸载

```bash
# 停止服务
bash stop.sh

# 删除虚拟环境
rm -rf venv

# 删除数据和日志
rm -rf data logs

# 删除配置
rm -f .env supervisord.conf wishub-api.pid
```

## 文档

- [最小实现方案](./wishub最小实现-更新版.md)
- [项目目录结构](./wishub-mvp-目录结构.md)

## 技术栈

- **Web框架**: FastAPI
- **数据库**: SQLite
- **向量搜索**: FAISS
- **缓存**: Redis（可选）
- **AI模型**: GPT-4 / GLM-5 / Llama 3
- **向量编码**: Sentence-Transformers

## 许可证

MIT License

## 贡献

欢迎提交Issue和Pull Request！

## 联系方式

- 项目主页: https://github.com/wishub/wishub-mvp
- 文档: https://docs.wishub.org

---

**版本**: 1.0.0
**最后更新**: 2026年2月23日

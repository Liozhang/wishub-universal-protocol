# WisHub MVP 项目目录结构

本文档详细描述WisHub MVP（最小实现版本）的完整项目目录结构。

## 完整目录结构

```
wishub-mvp/
├── app/                                      # FastAPI应用核心代码
│   ├── __init__.py                          # Python包初始化
│   ├── main.py                               # FastAPI应用入口
│   ├── config.py                             # 配置管理
│   ├── dependencies.py                       # 依赖注入
│   │
│   ├── models/                               # 数据模型（Pydantic + SQLAlchemy）
│   │   ├── __init__.py
│   │   ├── base.py                           # 基础模型
│   │   ├── wisunit.py                        # WisUnit数据模型
│   │   ├── wisdom_core.py                    # 智核数据模型
│   │   ├── agent.py                          # Agent数据模型
│   │   ├── user.py                           # 用户数据模型
│   │   ├── verification.py                   # 验证记录模型
│   │   └── incentive.py                      # 激励记录模型
│   │
│   ├── api/                                  # API路由（FastAPI路由器）
│   │   ├── __init__.py
│   │   ├── health.py                         # 健康检查API
│   │   ├── wisunits.py                       # WisUnit CRUD API
│   │   ├── wisdom_cores.py                   # 智核 CRUD API
│   │   ├── agents.py                         # Agent调用API
│   │   ├── search.py                         # 搜索API
│   │   ├── verification.py                   # 验证API
│   │   ├── incentive.py                      # 激励API
│   │   └── graph.py                          # 知识图谱API
│   │
│   ├── services/                             # 业务逻辑层
│   │   ├── __init__.py
│   │   ├── wisstore.py                       # WisStore：多级存储和索引
│   │   ├── wissync.py                        # WisSync：数据同步
│   │   ├── wisverify.py                      # WisVerify：四级验证系统
│   │   ├── wisincentive.py                   # WisIncentive：激励系统
│   │   ├── wisdedup.py                       # WisDedup：智能去重
│   │   ├── wisdom_core.py                    # 智核服务：AI生成和进化
│   │   ├── agent_manager.py                  # Agent管理服务
│   │   ├── knowledge_graph.py                # 知识图谱服务
│   │   └── search_service.py                 # 搜索服务
│   │
│   ├── agents/                               # Agent实现
│   │   ├── __init__.py
│   │   ├── base.py                           # Agent基类
│   │   ├── query_agent.py                    # 查询型Agent
│   │   ├── generation_agent.py               # 生成型Agent
│   │   ├── verification_agent.py             # 验证型Agent
│   │   └── agent_factory.py                  # Agent工厂
│   │
│   ├── storage/                              # 存储层（数据访问层）
│   │   ├── __init__.py
│   │   ├── sqlite_db.py                      # SQLite数据库封装
│   │   ├── faiss_index.py                    # FAISS向量索引封装
│   │   ├── redis_cache.py                    # Redis缓存封装
│   │   ├── file_storage.py                   # 文件存储封装
│   │   └── storage_factory.py                # 存储工厂
│   │
│   ├── verification/                         # 验证系统
│   │   ├── __init__.py
│   │   ├── l1_automated.py                   # L1自动化验证
│   │   ├── l2_community.py                   # L2社区验证（MVP简化）
│   │   ├── l4_5_ai.py                        # L4.5 AI验证
│   │   ├── l3_expert.py                      # L3专家验证（MVP可选）
│   │   └── verifier_factory.py               # 验证器工厂
│   │
│   ├── domains/                              # 领域支持
│   │   ├── __init__.py
│   │   ├── base.py                           # 领域基类
│   │   ├── medical.py                        # 医学领域
│   │   ├── financial.py                      # 金融领域
│   │   ├── legal.py                          # 法律领域
│   │   └── education.py                      # 教育领域
│   │
│   ├── middleware/                           # 中间件
│   │   ├── __init__.py
│   │   ├── auth.py                           # 认证中间件
│   │   ├── logging.py                        # 日志中间件
│   │   └── rate_limit.py                     # 限流中间件
│   │
│   ├── utils/                                # 工具函数
│   │   ├── __init__.py
│   │   ├── ai_client.py                      # AI客户端（GPT-4/GLM-5）
│   │   ├── encoder.py                        # 向量编码器（Sentence-Transformers）
│   │   ├── logger.py                         # 日志工具
│   │   ├── validators.py                     # 验证工具
│   │   ├── dedup.py                          # 去重工具
│   │   └── helpers.py                        # 辅助函数
│   │
│   └── db/                                   # 数据库相关
│       ├── __init__.py
│       ├── session.py                        # SQLAlchemy会话
│       ├── base.py                           # 基础模型
│       └── init_db.py                        # 数据库初始化
│
├── cli/                                      # CLI工具
│   ├── __init__.py
│   ├── main.py                               # CLI入口
│   ├── commands/                            # CLI命令
│   │   ├── __init__.py
│   │   ├── wisunit.py                        # WisUnit命令
│   │   ├── wisdom_core.py                    # 智核命令
│   │   ├── agent.py                          # Agent命令
│   │   ├── search.py                         # 搜索命令
│   │   └── user.py                           # 用户命令
│   └── utils/                                # CLI工具函数
│       ├── __init__.py
│       └── formatter.py                      # 输出格式化
│
├── web/                                      # Web UI
│   ├── index.html                            # 主页
│   ├── css/                                  # 样式文件
│   │   └── style.css                         # 主样式表
│   ├── js/                                   # JavaScript文件
│   │   ├── app.js                            # 主应用
│   │   ├── api.js                            # API客户端
│   │   ├── wisunit.js                        # WisUnit管理
│   │   ├── wisdom_core.js                    # 智核管理
│   │   ├── agent.js                          # Agent调用
│   │   └── search.js                         # 搜索功能
│   └── images/                               # 图片资源
│       └── logo.png
│
├── tests/                                    # 测试
│   ├── __init__.py
│   ├── conftest.py                           # Pytest配置
│   ├── unit/                                 # 单元测试
│   │   ├── __init__.py
│   │   ├── test_wisunit.py                   # WisUnit模型测试
│   │   ├── test_wisstore.py                  # WisStore服务测试
│   │   ├── test_wisverify.py                 # WisVerify服务测试
│   │   ├── test_wisdincentive.py              # WisIncentive服务测试
│   │   ├── test_wisdedup.py                  # WisDedup服务测试
│   │   ├── test_wisdom_core.py               # 智核服务测试
│   │   ├── test_agent.py                     # Agent测试
│   │   ├── test_knowledge_graph.py           # 知识图谱测试
│   │   ├── test_faiss_index.py               # FAISS索引测试
│   │   └── test_redis_cache.py               # Redis缓存测试
│   ├── integration/                          # 集成测试
│   │   ├── __init__.py
│   │   ├── test_wisunit_api.py               # WisUnit API测试
│   │   ├── test_wisdom_core_api.py           # 智核 API测试
│   │   ├── test_agent_api.py                 # Agent API测试
│   │   ├── test_search_api.py                # 搜索API测试
│   │   ├── test_verification_api.py          # 验证API测试
│   │   └── test_graph_api.py                 # 知识图谱API测试
│   └── performance/                          # 性能测试
│       ├── __init__.py
│       ├── locustfile.py                     # Locust性能测试配置
│       └── benchmark.py                      # 性能基准测试
│
├── data/                                     # 数据目录（运行时生成）
│   ├── wishub.db                             # SQLite数据库
│   ├── faiss/                                # FAISS索引
│   │   ├── wisunit.index                     # WisUnit向量索引
│   │   └── wisdom_core.index                 # 智核向量索引
│   └── files/                                # 文件存储
│       ├── models/                           # 模型文件
│       ├── code/                             # 代码文件
│       └── documents/                        # 文档文件
│
├── docker/                                   # Docker配置
│   ├── Dockerfile                            # FastAPI应用Dockerfile
│   ├── Dockerfile.cli                        # CLI工具Dockerfile
│   └── nginx.conf                            # Nginx配置（Web UI）
│
├── scripts/                                  # 脚本
│   ├── init_db.py                            # 初始化数据库
│   ├── migrate_data.py                       # 数据迁移脚本
│   ├── benchmark.py                          # 性能基准测试脚本
│   ├── seed_data.py                          # 种子数据加载脚本
│   └── backup.py                             # 备份脚本
│
├── docs/                                     # 文档
│   ├── api.md                                # API文档
│   ├── cli.md                                # CLI文档
│   ├── deployment.md                         # 部署文档
│   ├── architecture.md                       # 架构文档
│   ├── development.md                        # 开发文档
│   └── user_guide.md                         # 用户指南
│
├── examples/                                 # 示例代码
│   ├── wisunit_examples.py                   # WisUnit示例
│   ├── wisdom_core_examples.py               # 智核示例
│   ├── agent_examples.py                     # Agent示例
│   └── api_examples.py                      # API调用示例
│
├── .env.example                              # 环境变量模板
├── .env                                      # 环境变量（不提交到版本控制）
├── .gitignore                                # Git忽略文件
├── .dockerignore                             # Docker忽略文件
├── requirements.txt                          # Python依赖
├── requirements-dev.txt                      # 开发依赖
├── docker-compose.yml                        # Docker Compose配置
├── docker-compose.dev.yml                    # 开发环境Docker Compose
├── pyproject.toml                            # Python项目配置
├── setup.py                                  # 安装脚本
├── README.md                                 # 项目说明
├── LICENSE                                   # 许可证
└── CHANGELOG.md                              # 变更日志
```

## 关键文件说明

### app/ - FastAPI应用核心代码

#### main.py - 应用入口

```python
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from app.api import wisunits, wisdom_cores, agents, search
from app.db import init_db

app = FastAPI(
    title="WisHub MVP API",
    description="WisHub 最小实现版本 API",
    version="1.0.0"
)

# CORS配置
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# 注册路由
app.include_router(wisunits.router, prefix="/api/v1/wisunits", tags=["WisUnits"])
app.include_router(wisdom_cores.router, prefix="/api/v1/wisdom-cores", tags=["WisdomCores"])
app.include_router(agents.router, prefix="/api/v1/agents", tags=["Agents"])
app.include_router(search.router, prefix="/api/v1/search", tags=["Search"])

# 启动事件
@app.on_event("startup")
async def startup_event():
    await init_db()

# 健康检查
@app.get("/api/v1/health")
async def health_check():
    return {"status": "healthy"}
```

#### config.py - 配置管理

```python
from pydantic_settings import BaseSettings
from typing import Optional

class Settings(BaseSettings):
    # AI配置
    ai_api_key: str
    ai_model: str = "gpt-4"
    ai_base_url: str = "https://api.openai.com/v1"

    # 数据库配置
    database_url: str = "sqlite:///data/wishub.db"

    # Redis配置
    redis_url: str = "redis://localhost:6379"

    # FAISS配置
    faiss_index_path: str = "/data/faiss/"
    faiss_index_type: str = "IndexFlatL2"

    # 文件存储配置
    file_storage_path: str = "/data/files/"

    # 应用配置
    app_name: str = "WisHub MVP"
    app_version: str = "1.0.0"
    debug: bool = False

    class Config:
        env_file = ".env"

settings = Settings()
```

### app/models/ - 数据模型

#### wisunit.py - WisUnit数据模型

```python
from pydantic import BaseModel, Field
from typing import Optional, Dict, Any, List
from datetime import datetime

class WisUnitLayer1(BaseModel):
    """WisUnit可执行层"""
    type: str = "executable"
    code: Optional[Dict[str, Any]] = None
    model: Optional[Dict[str, Any]] = None
    workflow: Optional[Dict[str, Any]] = None
    agent_api: Optional[Dict[str, Any]] = None

class WisUnitLayer2(BaseModel):
    """WisUnit结构化层"""
    type: str = "structured"
    metadata: Dict[str, Any]
    schema: Dict[str, Any]
    relations: Optional[List[Dict[str, Any]]] = []

class WisUnitLayer3(BaseModel):
    """WisUnit自然语言层"""
    type: str = "natural_language"
    title: str
    description: str
    explanation: Optional[str] = None
    examples: Optional[List[Dict[str, Any]]] = []
    references: Optional[List[Dict[str, Any]]] = []

class WisUnit(BaseModel):
    """WisUnit知识单元"""
    id: str = Field(..., description="WisUnit唯一ID")
    version: str = "1.0.0"
    created_at: datetime = Field(default_factory=datetime.utcnow)
    updated_at: Optional[datetime] = None
    created_by: str
    domain: str
    tags: List[str] = []
    layer_1: WisUnitLayer1
    layer_2: WisUnitLayer2
    layer_3: WisUnitLayer3

    class Config:
        json_schema_extra = {
            "example": {
                "id": "ku_20260223_001",
                "version": "1.0.0",
                "created_by": "user_001",
                "domain": "medical",
                "tags": ["diabetes", "diagnosis"],
                "layer_1": {
                    "type": "executable",
                    "code": {
                        "language": "python",
                        "content": "def diagnose():\n    pass"
                    }
                },
                "layer_2": {
                    "type": "structured",
                    "metadata": {
                        "title": "糖尿病诊断算法",
                        "domain": "medical"
                    },
                    "schema": {
                        "version": "1.0.0",
                        "fields": []
                    }
                },
                "layer_3": {
                    "type": "natural_language",
                    "title": "糖尿病诊断算法",
                    "description": "基于血糖水平的糖尿病诊断算法"
                }
            }
        }
```

### app/services/ - 业务逻辑层

#### wisstore.py - WisStore服务

```python
from typing import Optional, List, Dict, Any
from app.models.wisunit import WisUnit
from app.storage.sqlite_db import SQLiteDB
from app.storage.faiss_index import FAISSIndex
from app.storage.redis_cache import RedisCache
from app.utils.encoder import TextEncoder

class WisStore:
    """WisStore - 多级存储和索引"""

    def __init__(self):
        # L1: SQLite数据库
        self.sqlite_db = SQLiteDB()

        # L2: FAISS向量索引
        self.faiss_index = FAISSIndex()

        # L3: Redis缓存
        self.redis_cache = RedisCache()

        # 文本编码器
        self.encoder = TextEncoder()

    async def create_wisunit(self, wisunit: WisUnit) -> WisUnit:
        """创建WisUnit"""
        # 1. 存储到SQLite
        await self.sqlite_db.insert_wisunit(wisunit)

        # 2. 编码为向量
        vector = self.encoder.encode_wisunit(wisunit)

        # 3. 添加到FAISS索引
        await self.faiss_index.add(wisunit.id, vector)

        # 4. 缓存到Redis
        await self.redis_cache.set(f"wisunit:{wisunit.id}", wisunit)

        return wisunit

    async def get_wisunit(self, wisunit_id: str) -> Optional[WisUnit]:
        """获取WisUnit"""
        # 1. 先从Redis缓存获取
        cached = await self.redis_cache.get(f"wisunit:{wisunit_id}")
        if cached:
            return cached

        # 2. 从SQLite获取
        wisunit = await self.sqlite_db.get_wisunit(wisunit_id)
        if wisunit:
            # 缓存到Redis
            await self.redis_cache.set(f"wisunit:{wisunit.id}", wisunit)

        return wisunit

    async def search_wisunits(
        self,
        query: str,
        domain: Optional[str] = None,
        limit: int = 10
    ) -> List[WisUnit]:
        """搜索WisUnit"""
        # 1. 编码查询向量
        query_vector = self.encoder.encode_text(query)

        # 2. FAISS向量搜索
        results = await self.faiss_index.search(query_vector, limit)

        # 3. 从Redis/SQLite获取完整WisUnit
        wisunits = []
        for result in results:
            wisunit = await self.get_wisunit(result["id"])
            if wisunit:
                # 过滤domain
                if domain is None or wisunit.domain == domain:
                    wisunits.append(wisunit)

        return wisunits
```

### app/agents/ - Agent实现

#### query_agent.py - 查询型Agent

```python
from app.agents.base import Agent
from app.services.wisstore import WisStore

class QueryAgent(Agent):
    """查询型Agent"""

    def __init__(self, agent_id: str):
        super().__init__(agent_id, "query")
        self.wisstore = WisStore()

    async def execute(self, task: Dict[str, Any]) -> Dict[str, Any]:
        """执行查询任务"""
        query = task.get("query")
        domain = task.get("domain")
        limit = task.get("limit", 10)

        # 调用WisStore搜索
        results = await self.wisstore.search_wisunits(
            query=query,
            domain=domain,
            limit=limit
        )

        return {
            "agent_id": self.agent_id,
            "agent_type": "query",
            "task": task,
            "results": results,
            "count": len(results)
        }
```

#### generation_agent.py - 生成型Agent

```python
from app.agents.base import Agent
from app.utils.ai_client import AIClient

class GenerationAgent(Agent):
    """生成型Agent"""

    def __init__(self, agent_id: str):
        super().__init__(agent_id, "generation")
        self.ai_client = AIClient()

    async def execute(self, task: Dict[str, Any]) -> Dict[str, Any]:
        """执行生成任务"""
        prompt = task.get("prompt")
        domain = task.get("domain")

        # 调用AI模型生成
        response = await self.ai_client.generate(
            prompt=prompt,
            domain=domain
        )

        return {
            "agent_id": self.agent_id,
            "agent_type": "generation",
            "task": task,
            "result": response
        }
```

### app/storage/ - 存储层

#### faiss_index.py - FAISS索引封装

```python
import faiss
import numpy as np
from typing import List, Dict, Any, Optional
import pickle
import os

class FAISSIndex:
    """FAISS向量索引封装"""

    def __init__(self, index_path: str = "/data/faiss/", dimension: int = 384):
        self.index_path = index_path
        self.dimension = dimension

        # 创建索引目录
        os.makedirs(index_path, exist_ok=True)

        # 加载或创建索引
        self.index = self._load_or_create_index()

        # ID映射
        self.id_map = self._load_id_map()

    def _load_or_create_index(self):
        """加载或创建索引"""
        index_file = os.path.join(self.index_path, "wisunit.index")

        if os.path.exists(index_file):
            # 加载现有索引
            index = faiss.read_index(index_file)
        else:
            # 创建新索引
            index = faiss.IndexFlatL2(self.dimension)
            faiss.write_index(index, index_file)

        return index

    def _load_id_map(self):
        """加载ID映射"""
        id_map_file = os.path.join(self.index_path, "id_map.pkl")

        if os.path.exists(id_map_file):
            with open(id_map_file, "rb") as f:
                return pickle.load(f)
        else:
            return {}

    async def add(self, wisunit_id: str, vector: np.ndarray):
        """添加向量到索引"""
        # 添加到FAISS索引
        self.index.add(vector.reshape(1, -1))

        # 更新ID映射
        idx = self.index.ntotal - 1
        self.id_map[idx] = wisunit_id

        # 保存
        self._save()

    async def search(self, query_vector: np.ndarray, k: int = 10) -> List[Dict[str, Any]]:
        """搜索向量"""
        # FAISS搜索
        distances, indices = self.index.search(query_vector.reshape(1, -1), k)

        # 转换为结果
        results = []
        for i in range(k):
            idx = indices[0][i]
            distance = distances[0][i]

            if idx in self.id_map:
                results.append({
                    "id": self.id_map[idx],
                    "distance": float(distance)
                })

        return results

    def _save(self):
        """保存索引和ID映射"""
        # 保存索引
        index_file = os.path.join(self.index_path, "wisunit.index")
        faiss.write_index(self.index, index_file)

        # 保存ID映射
        id_map_file = os.path.join(self.index_path, "id_map.pkl")
        with open(id_map_file, "wb") as f:
            pickle.dump(self.id_map, f)
```

### cli/ - CLI工具

#### main.py - CLI入口

```python
import click
from cli.commands.wisunit import wisunit_cmd
from cli.commands.wisdom_core import wisdom_core_cmd
from cli.commands.agent import agent_cmd
from cli.commands.search import search_cmd

@click.group()
def cli():
    """WisHub CLI - WisHub命令行工具"""
    pass

# 注册命令
cli.add_command(wisunit_cmd)
cli.add_command(wisdom_core_cmd)
cli.add_command(agent_cmd)
cli.add_command(search_cmd)

if __name__ == "__main__":
    cli()
```

### tests/ - 测试

#### unit/test_wisunit.py - WisUnit模型测试

```python
import pytest
from app.models.wisunit import WisUnit, WisUnitLayer1, WisUnitLayer2, WisUnitLayer3

def test_wisunit_creation():
    """测试创建WisUnit"""
    wisunit = WisUnit(
        id="ku_001",
        created_by="user_001",
        domain="medical",
        layer_1=WisUnitLayer1(),
        layer_2=WisUnitLayer2(
            metadata={"title": "Test"}
        ),
        layer_3=WisUnitLayer3(
            title="Test",
            description="Test"
        )
    )

    assert wisunit.id == "ku_001"
    assert wisunit.domain == "medical"
```

### docker/ - Docker配置

#### Dockerfile - FastAPI应用Dockerfile

```dockerfile
FROM python:3.10-slim

WORKDIR /app

# 安装系统依赖
RUN apt-get update && apt-get install -y \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# 安装Python依赖
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 复制应用代码
COPY . .

# 创建数据目录
RUN mkdir -p /data/faiss /data/files

# 暴露端口
EXPOSE 8000

# 启动命令
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
```

### docs/ - 文档

#### api.md - API文档

```markdown
# WisHub MVP API 文档

## 基础信息

- **Base URL**: `http://localhost:8000`
- **API版本**: v1
- **认证方式**: API Key（待实现）

## API端点

### 健康检查
- **GET** `/api/v1/health`
- **描述**: 检查API健康状态
- **响应**: `{"status": "healthy"}`

### WisUnit API
...
```

---

## 文件统计

| 类别 | 文件数 | 说明 |
|------|--------|------|
| app/ | ~80个 | FastAPI应用核心代码 |
| cli/ | ~15个 | CLI工具 |
| web/ | ~20个 | Web UI |
| tests/ | ~30个 | 测试代码 |
| docs/ | ~10个 | 文档 |
| docker/ | 3个 | Docker配置 |
| scripts/ | 5个 | 脚本 |
| examples/ | 5个 | 示例代码 |
| **总计** | **~168个文件** |  |

---

**文档版本**：v1.0.0
**最后更新**：2026年2月23日

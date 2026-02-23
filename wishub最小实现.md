# WisHub v5.1.0 最小实现方案（MVP）

**项目名称**：WisHub 最小可行产品
**版本**：MVP v1.0.0
**发布日期**：2026年2月23日
**文档类型**：技术设计方案
**目标部署**：单机（8核CPU、16GB内存、512GB SSD）

---

## 目录

1. [方案概述](#1-方案概述)
2. [架构设计](#2-架构设计)
3. [技术栈详细说明](#3-技术栈详细说明)
4. [核心功能实现清单](#4-核心功能实现清单)
5. [领域支持说明](#5-领域支持说明)
6. [部署方案](#6-部署方案)
7. [快速启动指南](#7-快速启动指南)
8. [测试方案](#8-测试方案)
9. [限制和说明](#9-限制和说明)
10. [后续扩展路线](#10-后续扩展路线)
11. [项目目录结构](#11-项目目录结构)

---

## 1. 方案概述

### 1.1 MVP目标

WisHub v5.1.0最小实现方案（MVP）旨在在**单机环境**（8核CPU、16GB内存、512GB SSD）上实现所有核心功能，为后续分布式部署提供基础验证和技术积累。

**核心目标**：
- ✅ 单机部署，一键启动
- ✅ 包含所有核心功能（可简化实现）
- ✅ 支持4个领域（医学、金融、法律、教育）
- ✅ 提供Web UI、CLI、REST API
- ✅ 完整的测试覆盖
- ✅ 清晰的文档

### 1.2 与v5.1.0亿级版本的差异

| 维度 | v5.1.0亿级版本 | MVP最小实现 | 差异说明 |
|------|---------------|------------|----------|
| **部署规模** | 全球4大区域、100+K8s节点 | 单机部署 | 简化部署 |
| **数据库** | CockroachDB分布式集群 | SQLite单文件 | 简化存储 |
| **向量数据库** | Milvus Cluster集群 | FAISS本地索引 | 简化向量搜索 |
| **缓存** | Redis Cluster集群 | Redis单机 | 简化缓存 |
| **消息队列** | Kafka Cluster | 内存队列 | 简化消息传递 |
| **AI模型** | GPT-4/GLM-5/Llama 3多模型 | 可选本地模型或API调用 | 灵活模型选择 |
| **Agent数量** | 1亿Agent | 2-3种Agent类型 | 简化Agent生态 |
| **用户规模** | 1亿用户 | 单用户测试 | 简化用户管理 |
| **P2P网络** | libp2p | 单机本地同步 | 延后P2P |
| **Service Mesh** | Istio | 简化HTTP通信 | 延后服务网格 |
| **监控** | Prometheus+Grafana+Jaeger | 简化日志 | 简化监控 |
| **CDN** | 全球200+城市CDN | 无 | 延后CDN |

### 1.3 MVP核心特性

**保留的核心功能**：
1. ✅ WisUnit三层架构（可执行层、结构层、自然语言层）
2. ✅ WisUnit CRUD操作
3. ✅ WisUnit基本验证
4. ✅ WisStore（多级存储和索引，简化版）
5. ✅ WisSync（单机本地同步）
6. ✅ WisVerify（四级验证系统，简化版）
7. ✅ WisIncentive（信用+赏金+声誉）
8. ✅ WisDedup（智能去重）
9. ✅ 智核（Wisdom Core，简化版）
10. ✅ AI自动生成（简化版）
11. ✅ 基本进化机制
12. ✅ Agent生态（2-3种Agent类型）
13. ✅ L4.5验证（AI内容验证，简化版）
14. ✅ 知识图谱（基本图数据库支持）
15. ✅ 领域支持（医学、金融、法律、教育）

**简化的功能**：
- 🔄 数据库：CockroachDB → SQLite
- 🔄 向量数据库：Milvus → FAISS
- 🔄 消息队列：Kafka → 内存队列
- 🔄 Agent数量：1亿 → 2-3种类型
- 🔄 P2P网络：libp2p → 单机本地同步
- 🔄 Service Mesh：Istio → 简化HTTP通信

---

## 2. 架构设计

### 2.1 最小化九层架构（单机版）

WisHub MVP采用简化版九层架构，所有组件部署在同一台机器上：

```
┌─────────────────────────────────────────────────────────────┐
│        Layer 9: 全球层（简化版）                              │
│  本地HTTP服务器（FastAPI）+ 静态文件服务                      │
└──────────────────────┬──────────────────────────────────────┘
                       │
┌──────────────────────┴──────────────────────────────────────┐
│       Layer 8: 接入层                                        │
│  Web UI (HTML+JS) | CLI Tool | REST API                     │
└──────────────────────┬──────────────────────────────────────┘
                       │
┌──────────────────────┴──────────────────────────────────────┐
│      Layer 7: API网关层（简化版）                            │
│  FastAPI中间件（认证授权+限流熔断）                           │
└──────────────────────┬──────────────────────────────────────┘
                       │
┌──────────────────────┴──────────────────────────────────────┐
│      Layer 6: 业务逻辑层                                      │
│  知识管理 | 搜索 | 排名 | 权限 | 审计 | 同步                    │
└──────────────────────┬──────────────────────────────────────┘
                       │
┌──────────────────────┴──────────────────────────────────────┐
│      Layer 5: 微服务层（简化版）                             │
│  12+ 核心服务（同一FastAPI应用）                              │
└──────────────────────┬──────────────────────────────────────┘
                       │
┌──────────────────────┴──────────────────────────────────────┐
│        Layer 4: Agent层（简化版）                             │
│  Agent Manager + 2-3种Agent类型                               │
└──────────────────────┬──────────────────────────────────────┘
                       │
┌──────────────────────┴──────────────────────────────────────┐
│      Layer 3: 数据访问层                                      │
│  ORM | 缓存 | FAISS向量索引 | 文件存储                        │
└──────────────────────┬──────────────────────────────────────┘
                       │
┌──────────────────────┴──────────────────────────────────────┐
│       Layer 2: 存储层                                        │
│  SQLite | FAISS索引文件 | Redis | 文件系统                    │
└──────────────────────┬──────────────────────────────────────┘
                       │
┌──────────────────────┴──────────────────────────────────────┐
│    Layer 1: 基础设施层                                        │
│  Docker容器 + 单机资源（8核CPU、16GB内存、512GB SSD）        │
└─────────────────────────────────────────────────────────────┘
```

### 2.2 单机架构优势

**优势**：
- ✅ **快速启动**：一键启动，无需复杂配置
- ✅ **资源高效**：充分利用单机资源
- ✅ **易于调试**：所有组件在同一机器上，便于排查问题
- ✅ **成本低廉**：无需昂贵的基础设施
- ✅ **易于迁移**：后续可平滑迁移到分布式架构

**劣势**：
- ❌ **单点故障**：无容灾能力
- ❌ **性能限制**：受限于单机资源
- ❌ **无法扩展**：无法横向扩展

### 2.3 核心组件说明

#### 2.3.1 数据层

**SQLite主数据库**：
- 路径：`/data/wishub.db`
- 用途：存储WisUnit、智核、用户、Agent等结构化数据
- 优点：轻量级、零配置、单文件

**FAISS向量索引**：
- 路径：`/data/faiss/`
- 用途：存储WisUnit的向量索引
- 优点：高性能向量搜索、支持GPU加速（可选）

**Redis缓存**：
- 用途：缓存热点数据、会话管理
- 优点：高性能、支持多种数据结构

**文件系统**：
- 路径：`/data/files/`
- 用途：存储模型文件、代码文件、文档等

#### 2.3.2 应用层

**FastAPI应用**：
- 路径：`/app/`
- 用途：提供REST API、业务逻辑
- 优点：高性能、异步支持、自动生成文档

**Web UI**：
- 路径：`/web/`
- 用途：提供图形化界面
- 技术：HTML + JavaScript + TailwindCSS

**CLI工具**：
- 路径：`/cli/`
- 用途：提供命令行界面
- 技术：Python + Click

#### 2.3.3 工具层

**AI模型支持**：
- 可选：本地模型（Llama 3）
- 可选：API调用（GPT-4、GLM-5）

**向量搜索**：
- 技术：FAISS
- 用途：WisUnit语义搜索

---

## 3. 技术栈详细说明

### 3.1 数据层技术栈

| 技术组件 | 选型 | 版本 | 用途 | 配置 |
|---------|------|------|------|------|
| **主数据库** | SQLite | 3.40+ | 存储结构化数据 | 单文件 `/data/wishub.db` |
| **向量数据库** | FAISS | 1.7+ | 向量搜索 | `/data/faiss/` |
| **缓存** | Redis | 7.0+ | 缓存和会话 | 内存模式 |
| **文件存储** | 本地文件系统 | - | 存储文件 | `/data/files/` |

### 3.2 应用层技术栈

| 技术组件 | 选型 | 版本 | 用途 | 说明 |
|---------|------|------|------|------|
| **Web框架** | FastAPI | 0.104+ | REST API | 高性能异步框架 |
| **ORM** | SQLAlchemy | 2.0+ | 数据库ORM | 支持异步 |
| **API文档** | FastAPI自动生成 | - | Swagger UI | 自动生成API文档 |
| **Web UI** | HTML + JS + TailwindCSS | - | 前端界面 | 轻量级前端 |
| **CLI工具** | Click | 8.0+ | 命令行工具 | Python CLI框架 |

### 3.3 AI/ML技术栈

| 技术组件 | 选型 | 版本 | 用途 | 说明 |
|---------|------|------|------|------|
| **AI模型** | GPT-4 / GLM-5 / Llama 3 | Latest | AI生成 | 可选API或本地 |
| **向量编码** | Sentence-Transformers | 2.2+ | 文本向量化 | 多语言支持 |
| **向量搜索** | FAISS | 1.7+ | 向量检索 | 支持GPU加速 |
| **模型存储** | Pickle / Safetensors | - | 模型序列化 | 安全存储 |

### 3.4 开发和测试技术栈

| 技术组件 | 选型 | 版本 | 用途 | 说明 |
|---------|------|------|------|------|
| **编程语言** | Python | 3.10+ | 主开发语言 | 丰富的生态 |
| **容器化** | Docker | 24+ | 容器部署 | 跨平台支持 |
| **编排** | Docker Compose | 2.20+ | 一键启动 | 多容器编排 |
| **测试框架** | pytest | 7.4+ | 单元测试 | 丰富的断言库 |
| **测试覆盖率** | pytest-cov | 4.1+ | 测试覆盖率 | HTML报告 |

### 3.5 部署技术栈

| 技术组件 | 选型 | 版本 | 用途 | 说明 |
|---------|------|------|------|------|
| **容器化** | Docker | 24+ | 容器部署 | 跨平台支持 |
| **编排** | Docker Compose | 2.20+ | 一键启动 | 多容器编排 |
| **日志** | Python logging | - | 日志记录 | 结构化日志 |
| **监控** | Prometheus + Grafana | Latest | 监控可视化 | 可选 |

---

## 4. 核心功能实现清单

### 4.1 WisUnit核心功能

#### 4.1.1 WisUnit三层架构（✅ 必须包含）

**可执行层（Layer 1）**：
```json
{
  "layer_1": {
    "type": "executable",
    "code": {
      "language": "python",
      "content": "def example_function():\n    pass"
    },
    "model": {
      "type": "sklearn",
      "path": "models/example_model.pkl",
      "version": "1.0.0"
    },
    "workflow": {
      "steps": [
        {"name": "step1", "service": "service1"},
        {"name": "step2", "service": "service2"}
      ]
    },
    "agent_api": {
      "endpoint": "/api/v1/agent/ku_001",
      "input_schema": {...},
      "output_schema": {...}
    }
  }
}
```

**结构化层（Layer 2）**：
```json
{
  "layer_2": {
    "type": "structured",
    "metadata": {
      "title": "示例知识单元",
      "description": "这是一个示例知识单元",
      "domain": "medical",
      "tags": ["example", "demo"]
    },
    "schema": {
      "version": "1.0.0",
      "fields": [
        {"name": "field1", "type": "string", "required": true},
        {"name": "field2", "type": "number", "required": false}
      ]
    },
    "relations": [
      {"type": "depends_on", "target": "ku_002"}
    ]
  }
}
```

**自然语言层（Layer 3）**：
```json
{
  "layer_3": {
    "type": "natural_language",
    "title": "示例知识单元",
    "description": "这是一个示例知识单元",
    "explanation": "示例知识单元的解释",
    "examples": [
      {"input": {...}, "output": "..."}
    ]
  }
}
```

#### 4.1.2 WisUnit CRUD操作（✅ 必须包含）

**创建WisUnit**：
```python
# API
POST /api/v1/wisunits

# 请求体
{
  "wisunit": {...}
}

# 响应
{
  "id": "ku_20260223_001",
  "status": "created",
  "message": "WisUnit创建成功"
}
```

**读取WisUnit**：
```python
# API
GET /api/v1/wisunits/{wisunit_id}

# 响应
{
  "wisunit": {...}
}
```

**更新WisUnit**：
```python
# API
PUT /api/v1/wisunits/{wisunit_id}

# 请求体
{
  "wisunit": {...}
}

# 响应
{
  "status": "updated",
  "message": "WisUnit更新成功"
}
```

**删除WisUnit**：
```python
# API
DELETE /api/v1/wisunits/{wisunit_id}

# 响应
{
  "status": "deleted",
  "message": "WisUnit删除成功"
}
```

#### 4.1.3 WisUnit验证（✅ 必须包含）

**L1自动化验证**：
```python
def l1_automated_verification(wisunit):
    """L1自动化验证（简化版）"""

    # 1. 格式验证
    if not validate_format(wisunit):
        return {"level": "L1", "status": "failed", "reason": "格式错误"}

    # 2. 必填字段验证
    if not validate_required_fields(wisunit):
        return {"level": "L1", "status": "failed", "reason": "缺少必填字段"}

    # 3. Schema验证
    if not validate_schema(wisunit):
        return {"level": "L1", "status": "failed", "reason": "Schema错误"}

    # 4. 代码语法验证
    if wisunit.get("layer_1", {}).get("code"):
        if not validate_code_syntax(wisunit["layer_1"]["code"]["content"]):
            return {"level": "L1", "status": "failed", "reason": "代码语法错误"}

    return {"level": "L1", "status": "passed"}
```

### 4.2 WISE协议核心功能

#### 4.2.1 WisStore（多级存储和索引，✅ 必须包含）

**多级存储策略**：
```python
class WisStore:
    """WisStore - 多级存储和索引（简化版）"""

    def __init__(self):
        # L1: SQLite（热数据）
        self.sqlite_db = SQLiteDB("/data/wishub.db")

        # L2: FAISS索引（向量搜索）
        self.faiss_index = FAISSIndex("/data/faiss/")

        # L3: Redis缓存（热点数据）
        self.redis_cache = RedisCache()

    def create_wisunit(self, wisunit):
        """创建WisUnit"""
        # 1. 存储到SQLite
        self.sqlite_db.insert(wisunit)

        # 2. 更新FAISS索引
        vector = self._encode_wisunit(wisunit)
        self.faiss_index.add(wisunit["id"], vector)

        # 3. 缓存到Redis
        self.redis_cache.set(f"wisunit:{wisunit['id']}", wisunit)

        return wisunit

    def get_wisunit(self, wisunit_id):
        """获取WisUnit"""
        # 1. 先从Redis缓存获取
        cached = self.redis_cache.get(f"wisunit:{wisunit_id}")
        if cached:
            return cached

        # 2. 从SQLite获取
        wisunit = self.sqlite_db.get(wisunit_id)
        if wisunit:
            # 缓存到Redis
            self.redis_cache.set(f"wisunit:{wisunit_id}", wisunit)

        return wisunit

    def search_wisunits(self, query, domain=None, limit=10):
        """搜索WisUnit"""
        # 1. 编码查询向量
        query_vector = self._encode_text(query)

        # 2. FAISS向量搜索
        results = self.faiss_index.search(query_vector, limit)

        # 3. 过滤domain（如果指定）
        if domain:
            results = [r for r in results if r.get("domain") == domain]

        return results

    def _encode_wisunit(self, wisunit):
        """编码WisUnit为向量"""
        text = self._wisunit_to_text(wisunit)
        return self._encode_text(text)

    def _encode_text(self, text):
        """编码文本为向量"""
        # 使用Sentence-Transformers
        from sentence_transformers import SentenceTransformer
        model = SentenceTransformer('paraphrase-multilingual-MiniLM-L12-v2')
        return model.encode(text)
```

#### 4.2.2 WisSync（单机本地同步，✅ 必须包含）

**单机本地同步**：
```python
class WisSync:
    """WisSync - 单机本地同步（简化版）"""

    def __init__(self):
        self.sync_log = SyncLog()

    def sync_wisunit(self, wisunit_id):
        """同步WisUnit（单机版本）"""
        # 单机版本：记录同步日志
        self.sync_log.append({
            "wisunit_id": wisunit_id,
            "action": "sync",
            "timestamp": datetime.now(),
            "status": "success"
        })

        return {"status": "synced", "message": "WisUnit同步成功"}

    def get_sync_status(self, wisunit_id):
        """获取同步状态"""
        return self.sync_log.get(wisunit_id)
```

#### 4.2.3 WisVerify（四级验证系统，✅ 必须包含）

**四级验证系统（简化版）**：
```python
class WisVerify:
    """WisVerify - 四级验证系统（简化版）"""

    def verify_wisunit(self, wisunit):
        """验证WisUnit"""

        # L1: 自动化验证
        l1_result = self.l1_automated_verification(wisunit)
        if l1_result["status"] == "failed":
            return l1_result

        # L2: 社区验证（MVP简化为管理员审核）
        l2_result = self.l2_community_verification(wisunit)
        if l2_result["status"] == "failed":
            return l2_result

        # L4.5: AI验证
        l4_5_result = self.l4_5_ai_verification(wisunit)

        # L3: 专家验证（MVP可选）
        l3_result = self.l3_expert_verification(wisunit)

        # L4: 仲裁（MVP简化）

        return {
            "level": "L1+L2+L4.5+L3",
            "status": "verified",
            "l1": l1_result,
            "l2": l2_result,
            "l4_5": l4_5_result,
            "l3": l3_result
        }

    def l4_5_ai_verification(self, wisunit):
        """L4.5 AI验证（简化版）"""
        # MVP: 使用单一AI模型（GPT-4或GLM-5）
        result = call_ai_model("gpt-4", wisunit)

        return {
            "level": "L4.5",
            "status": "passed" if result["confidence"] > 0.7 else "failed",
            "confidence": result["confidence"],
            "model": "gpt-4"
        }
```

#### 4.2.4 WisIncentive（信用+赏金+声誉，✅ 必须包含）

**经济模型（简化版）**：
```python
class WisIncentive:
    """WisIncentive - 信用+赏金+声誉（简化版）"""

    def __init__(self):
        self.user_credits = {}
        self.user_reputation = {}
        self.bounty_pool = 0

    def award_credit(self, user_id, amount, reason):
        """奖励信用"""
        if user_id not in self.user_credits:
            self.user_credits[user_id] = 0

        self.user_credits[user_id] += amount
        return {"user_id": user_id, "credits": self.user_credits[user_id]}

    def award_reputation(self, user_id, amount, reason):
        """奖励声誉"""
        if user_id not in self.user_reputation:
            self.user_reputation[user_id] = 0

        self.user_reputation[user_id] += amount
        return {"user_id": user_id, "reputation": self.user_reputation[user_id]}

    def claim_bounty(self, wisunit_id, user_id):
        """领取赏金"""
        # MVP: 简化赏金机制
        bounty = 100  # 固定赏金
        self.bounty_pool -= bounty
        self.award_credit(user_id, bounty, "bounty_claim")
        return {"user_id": user_id, "bounty": bounty}
```

#### 4.2.5 WisDedup（智能去重，✅ 必须包含）

**智能去重（简化版）**：
```python
class WisDedup:
    """WisDedup - 智能去重（简化版）"""

    def __init__(self):
        self.dedup_index = FAISSDedupIndex()

    def check_duplicate(self, wisunit):
        """检查重复"""
        # 1. 编码WisUnit为向量
        vector = self._encode_wisunit(wisunit)

        # 2. FAISS搜索相似WisUnit
        similar_wisunits = self.dedup_index.search(vector, threshold=0.95)

        if similar_wisunits:
            return {
                "is_duplicate": True,
                "similar_wisunits": similar_wisunits
            }

        return {
            "is_duplicate": False
        }

    def add_to_dedup_index(self, wisunit):
        """添加到去重索引"""
        vector = self._encode_wisunit(wisunit)
        self.dedup_index.add(wisunit["id"], vector)
```

### 4.3 智核（Wisdom Core，✅ 必须包含）

#### 4.3.1 智核定义

```json
{
  "wisdom_core": {
    "id": "wc_20260223_001",
    "version": "1.0.0",
    "title": "示例智核",
    "executable_layer": {...},
    "structured_layer": {...},
    "natural_language_layer": {...},
    "restriction_conditions": {...},
    "implementation_conditions": {...},
    "ai_generation": {
      "model": "gpt-4",
      "generation_time": "2026-02-23T10:30:00Z",
      "l4_5_verification": {
        "confidence": 0.90
      }
    },
    "evolution_metrics": {
      "usage_count": 100,
      "feedback_score": 4.5,
      "citation_count": 10
    }
  }
}
```

#### 4.3.2 AI自动生成（简化版）

```python
def ai_generate_wisdom_core(prompt, domain):
    """AI自动生成智核（简化版）"""

    # 调用AI模型生成
    response = call_ai_model("gpt-4", {
        "prompt": prompt,
        "domain": domain
    })

    # 解析生成结果
    wisdom_core = parse_ai_response(response)

    # L4.5验证
    l4_5_result = l4_5_ai_verification(wisdom_core)

    if l4_5_result["confidence"] < 0.7:
        return {"status": "failed", "reason": "AI生成验证未通过"}

    return {"status": "success", "wisdom_core": wisdom_core}
```

#### 4.3.3 基本进化机制

```python
def evolve_wisdom_core(wisdom_core_id):
    """进化智核（简化版）"""

    wisdom_core = get_wisdom_core(wisdom_core_id)

    # 1. 检查进化触发条件
    if wisdom_core["evolution_metrics"]["feedback_score"] < 3.0:
        # 触发进化
        pass

    if wisdom_core["evolution_metrics"]["usage_count"] > 1000:
        # 触发进化
        pass

    # 2. AI重新生成
    new_wisdom_core = ai_generate_wisdom_core(
        wisdom_core["natural_language_layer"]["description"],
        wisdom_core["structured_layer"]["metadata"]["domain"]
    )

    return new_wisdom_core
```

### 4.4 Agent生态（✅ 必须包含）

#### 4.4.1 基本Agent框架

```python
class Agent:
    """Agent基类"""

    def __init__(self, agent_id, agent_type):
        self.agent_id = agent_id
        self.agent_type = agent_type

    def execute(self, task):
        """执行任务"""
        raise NotImplementedError

class QueryAgent(Agent):
    """查询型Agent"""

    def execute(self, task):
        """执行查询任务"""
        query = task["query"]
        domain = task.get("domain")

        # 调用WisStore搜索
        results = wisstore.search_wisunits(query, domain)

        return results

class GenerationAgent(Agent):
    """生成型Agent"""

    def execute(self, task):
        """执行生成任务"""
        prompt = task["prompt"]
        domain = task.get("domain")

        # 调用AI模型生成
        response = call_ai_model("gpt-4", {
            "prompt": prompt,
            "domain": domain
        })

        return response
```

#### 4.4.2 Agent调用接口

```python
# API
POST /api/v1/agents/{agent_id}/execute

# 请求体
{
  "task": {
    "query": "糖尿病诊断"
  }
}

# 响应
{
  "agent_id": "agent_001",
  "agent_type": "query",
  "results": [...]
}
```

### 4.5 L4.5验证（✅ 必须包含）

#### 4.5.1 AI内容验证（简化版）

```python
def l4_5_ai_verification(wisunit):
    """L4.5 AI验证（简化版）"""

    # MVP: 使用单一AI模型
    result = call_ai_model("gpt-4", {
        "wisunit": wisunit,
        "task": "verify"
    })

    return {
        "level": "L4.5",
        "status": "passed" if result["confidence"] > 0.7 else "failed",
        "confidence": result["confidence"],
        "model": "gpt-4"
    }
```

#### 4.5.2 基本审核机制

```python
def human_review(wisunit_id, reviewer_id, approved, comments):
    """人工审核"""

    review = {
        "wisunit_id": wisunit_id,
        "reviewer_id": reviewer_id,
        "approved": approved,
        "comments": comments,
        "timestamp": datetime.now()
    }

    save_review(review)

    return review
```

### 4.6 知识图谱（✅ 必须包含）

#### 4.6.1 基本图数据库支持

```python
class KnowledgeGraph:
    """知识图谱（简化版）"""

    def __init__(self):
        self.nodes = {}  # 节点
        self.edges = {}  # 边

    def add_node(self, node_id, properties):
        """添加节点"""
        self.nodes[node_id] = properties

    def add_edge(self, from_id, to_id, relation):
        """添加边"""
        edge_id = f"{from_id}->{to_id}:{relation}"
        self.edges[edge_id] = {
            "from": from_id,
            "to": to_id,
            "relation": relation
        }

    def query_neighbors(self, node_id, relation=None):
        """查询邻居节点"""
        neighbors = []

        for edge_id, edge in self.edges.items():
            if edge["from"] == node_id:
                if relation is None or edge["relation"] == relation:
                    neighbors.append(self.nodes[edge["to"]])

        return neighbors
```

#### 4.6.2 知识关联和查询

```python
def build_knowledge_graph_from_wisunits(wisunits):
    """从WisUnit构建知识图谱"""
    kg = KnowledgeGraph()

    for wisunit in wisunits:
        # 添加节点
        kg.add_node(wisunit["id"], {
            "title": wisunit["layer_3"]["title"],
            "domain": wisunit["layer_2"]["metadata"]["domain"]
        })

        # 添加边
        for relation in wisunit["layer_2"].get("relations", []):
            kg.add_edge(
                wisunit["id"],
                relation["target"],
                relation["type"]
            )

    return kg
```

---

## 5. 领域支持说明

### 5.1 医学领域（简化版）

**数据结构**：
```json
{
  "medical_wisunit": {
    "layer_2": {
      "metadata": {
        "domain": "medical",
        "specialty": "endocrinology",
        "icd10": ["E11", "E12", "E13", "E14"],
        "guidelines": ["ADA", "WHO"],
        "clinical_trials": ["NCT123456"]
      },
      "schema": {
        "fields": [
          {"name": "patient_id", "type": "string", "required": true},
          {"name": "diagnosis", "type": "string", "required": true},
          {"name": "treatment", "type": "string", "required": true}
        ]
      }
    }
  }
}
```

**支持的功能**：
- ✅ 医学知识单元存储和检索
- ✅ 医学代码执行（诊断算法）
- ✅ 医学AI辅助生成
- ⚠️  MVP不提供临床决策支持

### 5.2 金融领域（简化版）

**数据结构**：
```json
{
  "financial_wisunit": {
    "layer_2": {
      "metadata": {
        "domain": "financial",
        "category": "investment",
        "risk_level": "medium",
        "regulations": ["SEC", "FINRA"]
      },
      "schema": {
        "fields": [
          {"name": "symbol", "type": "string", "required": true},
          {"name": "price", "type": "number", "required": true},
          {"name": "volume", "type": "number", "required": true}
        ]
      }
    }
  }
}
```

**支持的功能**：
- ✅ 金融知识单元存储和检索
- ✅ 金融数据分析和计算
- ⚠️  MVP不提供投资建议

### 5.3 法律领域（简化版）

**数据结构**：
```json
{
  "legal_wisunit": {
    "layer_2": {
      "metadata": {
        "domain": "legal",
        "jurisdiction": "CN",
        "law_type": "civil_law",
        "articles": ["Article 1", "Article 2"]
      },
      "schema": {
        "fields": [
          {"name": "law_title", "type": "string", "required": true},
          {"name": "article", "type": "string", "required": true},
          {"name": "content", "type": "text", "required": true}
        ]
      }
    }
  }
}
```

**支持的功能**：
- ✅ 法律知识单元存储和检索
- ✅ 法律条文搜索和引用
- ⚠️  MVP不提供法律咨询

### 5.4 教育领域（简化版）

**数据结构**：
```json
{
  "education_wisunit": {
    "layer_2": {
      "metadata": {
        "domain": "education",
        "level": "undergraduate",
        "subject": "computer_science",
        "credits": 3
      },
      "schema": {
        "fields": [
          {"name": "course_title", "type": "string", "required": true},
          {"name": "instructor", "type": "string", "required": true},
          {"name": "syllabus", "type": "text", "required": true}
        ]
      }
    }
  }
}
```

**支持的功能**：
- ✅ 教育知识单元存储和检索
- ✅ 课程和学习资源管理
- ✅ 学习路径推荐

---

## 6. 部署方案

### 6.1 硬件要求

**最低配置**：
- CPU: 4核心
- 内存: 8GB
- 存储: 200GB SSD

**推荐配置**：
- CPU: 8核心
- 内存: 16GB
- 存储: 512GB SSD

### 6.2 软件要求

**操作系统**：
- Linux (Ubuntu 22.04 LTS推荐)
- macOS 12+
- Windows 11 (WSL2)

**依赖软件**：
- Docker 24+
- Docker Compose 2.20+
- Python 3.10+ (用于开发)

### 6.3 Docker部署

#### 6.3.1 Docker镜像

```dockerfile
# Dockerfile
FROM python:3.10-slim

WORKDIR /app

# 安装依赖
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 复制应用代码
COPY . .

# 暴露端口
EXPOSE 8000

# 启动命令
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
```

#### 6.3.2 Docker Compose配置

```yaml
version: '3.8'

services:
  # FastAPI应用
  wishub-api:
    build: .
    ports:
      - "8000:8000"
    volumes:
      - ./data:/data
    depends_on:
      - redis
    environment:
      - REDIS_URL=redis://redis:6379
      - DATABASE_URL=sqlite:///data/wishub.db
      - AI_API_KEY=${AI_API_KEY}

  # Redis缓存
  redis:
    image: redis:7-alpine
    ports:
      - "6379:6379"
    volumes:
      - ./data/redis:/data

  # Web UI
  wishub-web:
    image: nginx:alpine
    ports:
      - "80:80"
    volumes:
      - ./web:/usr/share/nginx/html
      - ./nginx.conf:/etc/nginx/nginx.conf
    depends_on:
      - wishub-api
```

### 6.4 本地部署

#### 6.4.1 快速启动

```bash
# 克隆仓库
git clone https://github.com/wishub/wishub-mvp.git
cd wishub-mvp

# 启动所有服务
docker-compose up -d

# 查看日志
docker-compose logs -f

# 访问Web UI
open http://localhost

# 访问API文档
open http://localhost:8000/docs
```

#### 6.4.2 停止服务

```bash
# 停止所有服务
docker-compose down

# 停止并删除数据卷
docker-compose down -v
```

---

## 7. 快速启动指南

### 7.1 安装步骤

#### 步骤1：克隆仓库

```bash
git clone https://github.com/wishub/wishub-mvp.git
cd wishub-mvp
```

#### 步骤2：配置环境变量

```bash
# 复制环境变量模板
cp .env.example .env

# 编辑.env文件，设置AI API Key
vim .env
```

```bash
# .env文件内容
AI_API_KEY=your_openai_api_key_here
AI_MODEL=gpt-4
REDIS_URL=redis://localhost:6379
DATABASE_URL=sqlite:///data/wishub.db
```

#### 步骤3：启动服务

```bash
# 启动所有服务
docker-compose up -d

# 等待服务启动（约30秒）
sleep 30

# 检查服务状态
docker-compose ps
```

#### 步骤4：验证安装

```bash
# 测试API
curl http://localhost:8000/api/v1/health

# 访问Web UI
open http://localhost

# 访问API文档
open http://localhost:8000/docs
```

### 7.2 使用指南

#### 7.2.1 创建WisUnit

**Web UI**：
1. 访问 http://localhost
2. 点击"创建WisUnit"
3. 填写WisUnit信息
4. 点击"提交"

**CLI**：
```bash
# 创建WisUnit
wishub-cli create-wisunit wisunit.json

# 列出WisUnit
wishub-cli list-wisunits

# 查看WisUnit
wishub-cli get-wisunit ku_001
```

**API**：
```bash
# 创建WisUnit
curl -X POST http://localhost:8000/api/v1/wisunits \
  -H "Content-Type: application/json" \
  -d @wisunit.json

# 获取WisUnit
curl http://localhost:8000/api/v1/wisunits/ku_001
```

#### 7.2.2 搜索WisUnit

**Web UI**：
1. 访问 http://localhost
2. 在搜索框输入关键词
3. 点击"搜索"

**CLI**：
```bash
# 搜索WisUnit
wishub-cli search "糖尿病诊断"
```

**API**：
```bash
# 搜索WisUnit
curl "http://localhost:8000/api/v1/wisunits/search?query=糖尿病诊断"
```

#### 7.2.3 调用Agent

**Web UI**：
1. 访问 http://localhost
2. 选择Agent类型
3. 输入任务
4. 点击"执行"

**CLI**：
```bash
# 调用Query Agent
wishub-cli agent query --query "糖尿病诊断"

# 调用Generation Agent
wishub-cli agent generate --prompt "生成一个糖尿病诊断算法"
```

**API**：
```bash
# 调用Query Agent
curl -X POST http://localhost:8000/api/v1/agents/query/execute \
  -H "Content-Type: application/json" \
  -d '{"task": {"query": "糖尿病诊断"}}'
```

### 7.3 故障排除

#### 问题1：服务无法启动

**解决方案**：
```bash
# 检查Docker是否运行
docker ps

# 检查端口是否被占用
lsof -i :8000
lsof -i :6379

# 查看日志
docker-compose logs
```

#### 问题2：AI API调用失败

**解决方案**：
```bash
# 检查API Key是否正确
cat .env | grep AI_API_KEY

# 测试API连接
curl -H "Authorization: Bearer $AI_API_KEY" \
  https://api.openai.com/v1/models
```

#### 问题3：数据库错误

**解决方案**：
```bash
# 检查数据库文件权限
ls -l data/wishub.db

# 重新初始化数据库
docker-compose exec wishub-api python -m app.init_db
```

---

## 8. 测试方案

### 8.1 单元测试

**测试框架**：pytest

**测试覆盖率目标**：≥ 70%

**示例测试**：
```python
# tests/test_wisunit.py
import pytest
from app.models import WisUnit

def test_create_wisunit():
    """测试创建WisUnit"""
    wisunit = WisUnit(
        id="ku_001",
        layer_1={...},
        layer_2={...},
        layer_3={...}
    )
    assert wisunit.id == "ku_001"

def test_wisunit_validation():
    """测试WisUnit验证"""
    wisunit = WisUnit(...)
    result = wisunit.validate()
    assert result["status"] == "passed"
```

**运行测试**：
```bash
# 运行所有测试
pytest

# 运行特定测试
pytest tests/test_wisunit.py

# 生成覆盖率报告
pytest --cov=app --cov-report=html
```

### 8.2 集成测试

**测试场景**：
- WisUnit CRUD操作
- WisStore存储和检索
- Agent调用和执行
- API端点测试

**示例测试**：
```python
# tests/integration/test_api.py
import pytest
from fastapi.testclient import TestClient
from app.main import app

client = TestClient(app)

def test_create_wisunit_api():
    """测试创建WisUnit API"""
    response = client.post(
        "/api/v1/wisunits",
        json={"wisunit": {...}}
    )
    assert response.status_code == 200
    assert response.json()["status"] == "created"
```

### 8.3 性能测试（小规模）

**测试工具**：locust

**测试场景**：
- 10并发用户
- 持续10分钟
- 测试API响应时间

**示例配置**：
```python
# tests/performance/locustfile.py
from locust import HttpUser, task, between

class WisHubUser(HttpUser):
    wait_time = between(1, 3)

    @task
    def search_wisunits(self):
        self.client.get("/api/v1/wisunits/search?query=test")

    @task
    def get_wisunit(self):
        self.client.get("/api/v1/wisunits/ku_001")
```

**运行性能测试**：
```bash
# 启动Locust
locust -f tests/performance/locustfile.py --host=http://localhost:8000

# 打开浏览器
open http://localhost:8089
```

---

## 9. 限制和说明

### 9.1 MVP限制

**功能限制**：
- ❌ 不支持P2P网络（单机版本）
- ❌ 不支持分布式部署（单机版本）
- ❌ 不支持多用户并发（单用户测试）
- ❌ 不支持实时数据同步（单机版本）

**性能限制**：
- ❌ 查询性能受限于单机资源
- ❌ 无法横向扩展
- ❌ 高并发场景下性能下降

**安全限制**：
- ❌ 无高级安全措施（如零知识证明）
- ❌ 无抗DDoS防护
- ❌ 无专业的审计日志

**领域限制**：
- ⚠️  医学：不提供临床决策支持
- ⚠️  金融：不提供投资建议
- ⚠️  法律：不提供法律咨询

### 9.2 已知问题

1. **FAISS索引重建**：更新FAISS索引需要重新加载，性能较差
2. **Redis缓存一致性**：SQLite更新后缓存可能不一致
3. **AI模型依赖**：依赖外部AI API，可能出现网络问题
4. **内存限制**：大WisUnit可能导致内存不足

### 9.3 后续改进方向

**功能改进**：
- P2P网络支持
- 分布式部署
- 多用户并发
- 实时数据同步

**性能改进**：
- 向量索引优化
- 缓存策略优化
- 数据库查询优化

**安全改进**：
- 零知识证明
- DDoS防护
- 专业审计日志

---

## 10. 后续扩展路线

### 10.1 Phase 2: AI增强+安全增强（6-12个月）

**新增功能**：
- ✅ L4.5多模型交叉验证
- ✅ 图数据库（Neo4j）
- ✅ 全文搜索（Elasticsearch）
- ✅ P2P网络（libp2p）
- ✅ 零知识证明
- ✅ 沙箱隔离（gVisor）

**技术栈升级**：
- CockroachDB（主数据库）
- Milvus Cluster（向量数据库）
- Redis Cluster（缓存）
- Kafka Cluster（消息队列）

### 10.2 Phase 3: 生态建设+亿级用户（12-24个月）

**新增功能**：
- ✅ 全球分布式架构（九层架构）
- ✅ 1亿Agent支持
- ✅ 1亿用户支持
- ✅ 全球CDN网络
- ✅ 移动端原生应用
- ✅ 游戏知识支持

**技术栈升级**：
- Kubernetes（100+节点）
- GPU Pool（1万+核心）
- Service Mesh（Istio）
- 多云部署（AWS/GCP/Azure）

### 10.3 关键里程碑

| 阶段 | 时间 | 目标 |
|------|------|------|
| **MVP** | 3个月 | 单机部署，核心功能验证 |
| **Phase 2** | 6-12个月 | AI增强+安全增强，小规模分布式 |
| **Phase 3** | 12-24个月 | 生态建设+亿级用户，全球部署 |

---

## 11. 项目目录结构

```
wishub-mvp/
├── app/                          # FastAPI应用
│   ├── __init__.py
│   ├── main.py                   # 应用入口
│   ├── config.py                 # 配置管理
│   ├── models/                   # 数据模型
│   │   ├── __init__.py
│   │   ├── wisunit.py            # WisUnit模型
│   │   ├── wisdom_core.py        # 智核模型
│   │   ├── agent.py              # Agent模型
│   │   └── user.py               # 用户模型
│   ├── api/                      # API路由
│   │   ├── __init__.py
│   │   ├── wisunits.py           # WisUnit API
│   │   ├── wisdom_cores.py       # 智核 API
│   │   ├── agents.py             # Agent API
│   │   └── search.py             # 搜索 API
│   ├── services/                 # 业务逻辑
│   │   ├── __init__.py
│   │   ├── wisstore.py           # WisStore服务
│   │   ├── wissync.py            # WisSync服务
│   │   ├── wisverify.py          # WisVerify服务
│   │   ├── wisincentive.py       # WisIncentive服务
│   │   ├── wisdedup.py           # WisDedup服务
│   │   ├── wisdom_core.py        # 智核服务
│   │   ├── agent_manager.py      # Agent管理
│   │   └── knowledge_graph.py    # 知识图谱
│   ├── agents/                   # Agent实现
│   │   ├── __init__.py
│   │   ├── base.py               # Agent基类
│   │   ├── query_agent.py        # 查询型Agent
│   │   ├── generation_agent.py   # 生成型Agent
│   │   └── verification_agent.py # 验证型Agent
│   ├── storage/                  # 存储层
│   │   ├── __init__.py
│   │   ├── sqlite_db.py          # SQLite数据库
│   │   ├── faiss_index.py        # FAISS索引
│   │   ├── redis_cache.py        # Redis缓存
│   │   └── file_storage.py       # 文件存储
│   ├── verification/             # 验证
│   │   ├── __init__.py
│   │   ├── l1_automated.py       # L1自动化验证
│   │   ├── l2_community.py       # L2社区验证
│   │   ├── l4_5_ai.py            # L4.5 AI验证
│   │   └── l3_expert.py          # L3专家验证
│   ├── domains/                  # 领域支持
│   │   ├── __init__.py
│   │   ├── medical.py            # 医学领域
│   │   ├── financial.py          # 金融领域
│   │   ├── legal.py              # 法律领域
│   │   └── education.py          # 教育领域
│   └── utils/                    # 工具函数
│       ├── __init__.py
│       ├── ai_client.py          # AI客户端
│       ├── encoder.py            # 向量编码器
│       └── logger.py             # 日志工具
├── cli/                          # CLI工具
│   ├── __init__.py
│   ├── main.py                   # CLI入口
│   ├── wisunit.py                # WisUnit命令
│   ├── wisdom_core.py            # 智核命令
│   ├── agent.py                  # Agent命令
│   └── search.py                 # 搜索命令
├── web/                          # Web UI
│   ├── index.html
│   ├── css/
│   │   └── style.css
│   └── js/
│       └── app.js
├── tests/                        # 测试
│   ├── __init__.py
│   ├── unit/                     # 单元测试
│   │   ├── test_wisunit.py
│   │   ├── test_wisstore.py
│   │   └── test_agent.py
│   ├── integration/              # 集成测试
│   │   └── test_api.py
│   └── performance/              # 性能测试
│       └── locustfile.py
├── data/                         # 数据目录
│   ├── wishub.db                 # SQLite数据库
│   ├── faiss/                    # FAISS索引
│   │   ├── wisunit.index
│   │   └── wisdom_core.index
│   └── files/                    # 文件存储
│       └── models/               # 模型文件
├── docker/                       # Docker配置
│   ├── Dockerfile
│   └── nginx.conf
├── scripts/                      # 脚本
│   ├── init_db.py                # 初始化数据库
│   ├── migrate_data.py           # 数据迁移
│   └── benchmark.py              # 性能基准测试
├── docs/                         # 文档
│   ├── api.md                    # API文档
│   ├── cli.md                    # CLI文档
│   └── deployment.md             # 部署文档
├── .env.example                  # 环境变量模板
├── .env                          # 环境变量（不提交）
├── .gitignore
├── requirements.txt              # Python依赖
├── docker-compose.yml           # Docker Compose配置
└── README.md                     # 项目说明
```

---

## 附录A：快速参考

### A.1 API端点

| 方法 | 端点 | 说明 |
|------|------|------|
| GET | `/api/v1/health` | 健康检查 |
| POST | `/api/v1/wisunits` | 创建WisUnit |
| GET | `/api/v1/wisunits/{id}` | 获取WisUnit |
| PUT | `/api/v1/wisunits/{id}` | 更新WisUnit |
| DELETE | `/api/v1/wisunits/{id}` | 删除WisUnit |
| GET | `/api/v1/wisunits/search` | 搜索WisUnit |
| POST | `/api/v1/agents/{type}/execute` | 调用Agent |
| GET | `/api/v1/wisdom-cores` | 列出智核 |
| POST | `/api/v1/wisdom-cores/generate` | AI生成智核 |

### A.2 CLI命令

| 命令 | 说明 |
|------|------|
| `wishub-cli create-wisunit FILE` | 创建WisUnit |
| `wishub-cli get-wisunit ID` | 获取WisUnit |
| `wishub-cli list-wisunits` | 列出WisUnit |
| `wishub-cli search QUERY` | 搜索WisUnit |
| `wishub-cli agent query --query QUERY` | 调用查询Agent |
| `wishub-cli agent generate --prompt PROMPT` | 调用生成Agent |
| `wishub-cli wisdom-core generate --prompt PROMPT` | AI生成智核 |

### A.3 环境变量

| 变量名 | 说明 | 默认值 |
|--------|------|--------|
| `AI_API_KEY` | AI API密钥 | - |
| `AI_MODEL` | AI模型名称 | gpt-4 |
| `REDIS_URL` | Redis连接URL | redis://localhost:6379 |
| `DATABASE_URL` | 数据库连接URL | sqlite:///data/wishub.db |
| `FAISS_INDEX_PATH` | FAISS索引路径 | /data/faiss/ |
| `FILE_STORAGE_PATH` | 文件存储路径 | /data/files/ |

---

## 附录B：技术术语表

| 术语 | 说明 |
|------|------|
| **WisUnit** | 知识单元，WisHub的核心数据结构 |
| **Wisdom Core** | 智核，WisUnit的高级形式，具备AI自动生成能力 |
| **WISE协议** | WisHub的协议体系（WisStore/WisSync/WisVerify/WisIncentive/WisDedup） |
| **Agent** | 智能代理，可以执行特定任务的AI实体 |
| **L1验证** | 自动化验证 |
| **L2验证** | 社区验证 |
| **L3验证** | 专家验证 |
| **L4.5验证** | AI验证 |
| **L4验证** | 仲裁验证 |
| **FAISS** | Facebook AI Similarity Search，高效向量搜索库 |
| **SQLite** | 轻量级嵌入式数据库 |

---

## 结语

WisHub v5.1.0最小实现方案（MVP）是一个功能完整、易于部署的单机版本，包含了WisHub的所有核心功能。通过MVP，用户可以快速体验WisHub的核心功能，为后续分布式部署提供技术验证和经验积累。

MVP的设计原则是：
- ✅ **功能完整**：包含所有核心功能
- ✅ **易于部署**：一键启动，无需复杂配置
- ✅ **易于扩展**：后续可平滑迁移到分布式架构
- ✅ **易于调试**：所有组件在同一机器上

祝您使用WisHub MVP愉快！

---

**文档版本**：MVP v1.0.0
**最后更新**：2026年2月23日
**作者**：WisHub开发团队

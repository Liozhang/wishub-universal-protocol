# WisHub 通用协议文档

![Version](https://img.shields.io/badge/version-v3.0.0-blue.svg)
![License](https://img.shields.io/badge/license-GPL--3.0-blue.svg)
![GitHub Stars](https://img.shields.io/github/stars/Liozhang/wishub-universal-protocol?style=social)
![Build Status](https://img.shields.io/badge/build-passing-brightgreen.svg)

**项目名称**: WisHub 核心协议
**发布日期**: 2026年2月23日
**文档类型**: 通用协议规范
**版本**: v3.0.0

---

## 📖 项目简介

**构建智慧单元与智慧连接中心，加速全人类大成智慧的构建。**

WisHub 通用协议文档定义了 WisHub 生态系统的核心协议规范，包括数据模型、存储、验证、智能核心、Agent 管理等 12 大类协议。

WisHub 通过标准化的协议体系，实现：
- **智慧单元（WisUnit）**: 标准化的知识单元，包含可执行层、结构化层、自然语言层三层结构
- **智慧连接中心（Hub）**: 多级存储、智能检索、全局索引、质量验证
- **大成智慧**: 通过知识验证、共享、复用、进化，加速人类智慧的构建和传播

**快速导航**:
- [快速开始](#-快速开始) - 3分钟上手
- [协议架构](#-协议架构) - 了解系统设计
- [文档目录](#-文档目录) - 详细协议规范
- [常见问题](#-常见问题) - 常见问题解答

### 💡 核心理念

**WisHub = Wis（智慧） + Hub（连接中心）**

WisHub 的核心价值在于：
- **Wis（智慧）**: 质量验证、语义理解、逻辑推理、智能进化
- **Hub（连接中心）**: 集中存储、智能分发、全局索引、生态连接
- **大成智慧**: 让高质量智慧在AI生态中高效流转，一次验证，无限复用

### 🎨 设计原则

- **开放性**: 所有协议公开，鼓励社区参与
- **可扩展性**: 支持插件化扩展，适应不同领域需求
- **高性能**: 多级缓存、分布式存储、异步处理
- **安全性**: 零知识证明、端到端加密、细粒度权限控制
- **互操作性**: 标准化接口，支持多语言SDK

### 🛡️ 安全声明

- 所有数据传输均采用TLS 1.3加密
- 支持零知识证明，保护用户隐私
- 遵循OWASP安全最佳实践
- 支持GDPR、CCPA等隐私法规合规

---

## 📚 文档目录

### 核心协议文档

| 序号 | 文档名称 | 说明 | 文件大小 |
|------|----------|------|----------|
| 1 | [协议标准说明](docs/01-introduction.md) | JSON传输格式、多语言SDK支持 | 2.7KB |
| 2 | [WisUnit协议](docs/02-wisunit.md) | 数据模型、CRUD、验证、迁移 | 47KB |
| 3 | [WISE协议系统](docs/03-wise.md) | 存储、同步、验证、激励、去重、缓存 | 8.5KB |
| 4 | [智核协议](docs/04-core-intelligence.md) | 智核生成、进化、验证、反馈 | 5.2KB |
| 5 | [Agent协议](docs/05-agent.md) | 注册、调用、类型、调度、激励 | 5.8KB |
| 6 | [知识图谱协议](docs/06-knowledge-graph.md) | 图数据库接口、知识关联 | 2.4KB |
| 7 | [通信协议](docs/07-communication.md) | REST API、WebSocket、gRPC | 3.1KB |
| 8 | [安全协议](docs/08-security.md) | 认证、加密、权限、零知识证明 | 4.8KB |
| 9 | [领域扩展协议](docs/09-domain-extension.md) | 领域插件、验证规则、数据结构、配置 | 29KB |
| 10 | [经济模型协议](docs/10-economy.md) | 信用、赏金、汇率 | 3.6KB |
| 11 | [部署协议](docs/11-deployment.md) | 配置、监控、备份 | 5.3KB |
| 12 | [MCP/Skill协议](docs/12-mcp-skill.md) | MCP调用、Skill调用、注册、发现、编排 | 20KB |

---

## 🚀 快速开始

### 协议标准格式

所有协议的请求和响应均采用JSON格式：

```json
{
  "protocol": "协议名称",
  "version": "协议版本",
  "request_type": "请求类型",
  "request": { ... },
  "response_type": "响应类型",
  "status": "状态",
  "data": { ... },
  "message": "消息"
}
```

### Agent开发示例

```python
from wishub import Agent

# 创建Agent
agent = Agent(
    name="WeatherAgent",
    type="task_agent",
    capabilities=["weather_forecast", "weather_alert"]
)

# 注册Agent
agent.register()

# 调用Agent
result = agent.invoke({"location": "Beijing", "date": "2026-02-24"})
```

### 多语言SDK支持

WisHub提供以下语言的官方SDK：

| SDK语言 | 包管理器 | 优先级 | 开发时间 | 用途 |
|---------|---------|--------|---------|------|
| **Python** | pip | P0 | 2周 | AI/ML、原型开发 |
| **TypeScript** | npm | P0 | 2周 | 前端、Node.js |
| **Go** | go mod | P1 | 2周 | 高性能服务 |
| **Java** | Maven/Gradle | P1 | 2周 | 企业级应用 |
| **Rust** | Cargo | P2 | 2周 | 高性能关键路径 |
| **C#/.NET** | NuGet | P2 | 2周 | Windows生态 |
| **C++** | CMake/vcpkg | P3 | 3周 | 嵌入式系统 |
| **PHP** | Composer | P3 | 2周 | Web应用 |

---

## 📝 API使用示例

### REST API - WisUnit CRUD

<details>
<summary>📌 查看完整示例</summary>

```bash
# 创建WisUnit
curl -X POST https://api.wishub.org/v1/wisunits \
  -H "Authorization: Bearer YOUR_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "executable": {"code": "def hello(): return '\''Hello World'\''"},
    "structured": {"type": "function", "language": "python"},
    "natural": "一个返回Hello World的Python函数"
  }'

# 查询WisUnit
curl -X GET https://api.wishub.org/v1/wisunits/{wisunit_id} \
  -H "Authorization: Bearer YOUR_API_KEY"

# 更新WisUnit
curl -X PUT https://api.wishub.org/v1/wisunits/{wisunit_id} \
  -H "Authorization: Bearer YOUR_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"natural": "更新后的描述"}'

# 删除WisUnit
curl -X DELETE https://api.wishub.org/v1/wisunits/{wisunit_id} \
  -H "Authorization: Bearer YOUR_API_KEY"
```

</details>

### REST API - Agent注册与调用

```bash
# 注册Agent
curl -X POST https://api.wishub.org/v1/agents \
  -H "Authorization: Bearer YOUR_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "name": "WeatherAgent",
    "type": "task_agent",
    "capabilities": ["weather_forecast"],
    "description": "天气预报Agent"
  }'

# 调用Agent
curl -X POST https://api.wishub.org/v1/agents/{agent_id}/invoke \
  -H "Authorization: Bearer YOUR_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"parameters": {"location": "Beijing", "date": "2026-02-24"}}'
```

---

## 🧰 SDK使用示例

### Python SDK - WisUnit CRUD

<details>
<summary>📌 查看完整示例</summary>

```python
from wishub import Client

# 初始化客户端
client = Client(api_key="your-api-key", base_url="https://api.wishub.org")

# 创建WisUnit
wisunit = client.wisunits.create({
    "executable": {"code": "def hello(): return 'Hello World'"},
    "structured": {"type": "function", "language": "python"},
    "natural": "一个返回Hello World的Python函数"
})

# 查询WisUnit
wisunit = client.wisunits.get(wisunit.id)

# 更新WisUnit
wisunit.natural = "更新后的描述"
wisunit = wisunit.save()

# 删除WisUnit
wisunit.delete()
```

</details>

### TypeScript SDK - Agent开发

```typescript
import { Client, Agent } from '@wishub/sdk';

// 初始化客户端
const client = new Client({
  apiKey: 'your-api-key',
  baseURL: 'https://api.wishub.org'
});

// 创建Agent
const agent = await client.agents.create({
  name: 'WeatherAgent',
  type: 'task_agent',
  capabilities: ['weather_forecast']
});

// 调用Agent
const result = await agent.invoke({
  location: 'Beijing',
  date: '2026-02-24'
});
```

### Go SDK - 高性能场景

```go
package main

import (
    "github.com/wishub/sdk-go"
    "context"
)

func main() {
    client := wishub.NewClient("your-api-key")

    // 创建WisUnit
    wisunit := &wishub.WisUnit{
        Natural: "Go语言示例",
        Structured: map[string]interface{}{
            "language": "go",
        },
    }

    err := client.WisUnits.Create(context.Background(), wisunit)
    if err != nil {
        panic(err)
    }
}
```

---

## 🔗 MCP集成

### MCP Session管理

<details>
<summary>📌 查看完整示例</summary>

```python
from wishub import MCPClient

# 连接MCP服务
mcp = MCPClient(api_key="your-api-key")

# 创建Session
session = mcp.sessions.create()
print(f"Session ID: {session.id}")

# 查询知识
result = session.query_knowledge(
    query="WisHub三层架构",
    top_k=3,
    filters={"domain": "architecture"}
)

for unit in result.knowledge_units:
    print(f"- {unit.natural[:50]}...")

# 关闭Session
session.close()
```

</details>

### MCP与AI模型集成

```python
from wishub import MCPClient
from openai import OpenAI

# 初始化
mcp = MCPClient(api_key="your-api-key")
ai = OpenAI()

# 创建Session并获取知识上下文
session = mcp.sessions.create()
context = session.query_knowledge(
    query="WisHub的存储机制",
    top_k=5
)

# 构建带上下文的提示词
prompt = f"""
基于以下知识回答问题：

{chr(10).join([u.natural for u in context.knowledge_units])}

问题：解释WisHub的三级存储如何工作？
"""

# 调用AI模型
response = ai.chat.completions.create(
    model="gpt-4",
    messages=[{"role": "user", "content": prompt}]
)

print(response.choices[0].message.content)
```

---

## 🎯 Skill开发

### Skill注册

<details>
<summary>📌 查看完整示例</summary>

```python
from wishub import Skill

# 定义Skill
skill = Skill(
    name="data_analysis",
    description="数据分析Skill",
    version="1.0.0",
    input_schema={
        "type": "object",
        "properties": {
            "data": {"type": "array"},
            "operation": {"type": "string", "enum": ["sum", "avg", "max"]}
        },
        "required": ["data", "operation"]
    }
)

# 实现执行逻辑
@skill.execute
def execute(parameters):
    data = parameters["data"]
    operation = parameters["operation"]

    if operation == "sum":
        return sum(data)
    elif operation == "avg":
        return sum(data) / len(data)
    elif operation == "max":
        return max(data)

# 注册Skill
skill.register()
print(f"Skill registered: {skill.id}")
```

</details>

### Skill调用与编排

```python
from wishub import Agent, Workflow

# Agent调用单个Skill
agent = Agent(name="DataAgent")
result = agent.invoke_skill(
    skill_name="data_analysis",
    parameters={
        "data": [1, 2, 3, 4, 5],
        "operation": "avg"
    }
)
print(f"Average: {result}")  # Output: 3.0

# 多Skill编排
workflow = Workflow(name="report_generation")
workflow.add_skill("fetch_data", "data_fetch")
workflow.add_skill("analyze", "data_analysis", depends_on=["fetch_data"])
workflow.add_skill("generate_report", "report_writer", depends_on=["analyze"])

result = workflow.execute({"source": "database"})
print(result)
```

---

## 🏗️ 协议架构

### 三层架构

WisHub 采用三层架构设计：

```
┌─────────────────────────────────────────┐
│   Layer 3: 自然语言层                  │
│   (人类可理解的知识)                    │
└─────────────────────────────────────────┘
                    ↓
┌─────────────────────────────────────────┐
│   Layer 2: 结构化层                     │
│   (程序、系统可处理的知识)               │
└─────────────────────────────────────────┘
                    ↓
┌─────────────────────────────────────────┐
│   Layer 1: 可执行层                    │
│   (AI、机器、Agent可执行的知识)          │
└─────────────────────────────────────────┘
```

### 核心协议系统

- **[WisUnit协议](docs/02-wisunit.md)**: 知识单元的数据模型、CRUD操作、验证、迁移
- **[WISE协议系统](docs/03-wise.md)**: 多级存储（L1内存、L2分布式、L3持久化）
- **[智核协议](docs/04-core-intelligence.md)**: 智能核心的生成、进化、验证和反馈机制
- **[Agent协议](docs/05-agent.md)**: Agent的注册、调用、类型、调度和质量激励
- **[知识图谱协议](docs/06-knowledge-graph.md)**: 图数据库接口和知识关联协议
- **[通信协议](docs/07-communication.md)**: REST API、WebSocket、gRPC三种通信方式
- **[安全协议](docs/08-security.md)**: 认证、加密、权限、零知识证明
- **[领域扩展协议](docs/09-domain-extension.md)**: 领域插件注册、验证规则扩展、数据结构扩展
- **[经济模型协议](docs/10-economy.md)**: 信用、赏金、汇率协议
- **[部署协议](docs/11-deployment.md)**: 配置、监控、备份协议
- **[MCP/Skill协议](docs/12-mcp-skill.md)**: MCP调用、Skill调用、注册、发现、编排

### 💎 Token经济模型

- **WIS Token**: WisHub生态原生代币
- **用途**: 支付服务费、质押、治理
- **发行总量**: 10亿枚
- **分配**: 40% 生态激励、30% 团队、20% 投资者、10% 基金会

⚠️ **风险免责声明**: 加密货币和代币价值受市场波动影响。WisHub不对代币表现做出任何陈述或保证。参与代币相关活动前，请自行研究并了解风险。

---

## 📋 协议列表

### 1. [WisUnit协议](docs/02-wisunit.md)
- 1.1 WisUnit数据模型协议
- 1.2 WisUnit CRUD协议
- 1.3 WisUnit验证协议
- 1.4 WisUnit迁移协议

### 2. [WISE协议系统](docs/03-wise.md)
- 2.1 WisStore协议
- 2.2 WisSync协议
- 2.3 WisVerify协议
- 2.4 WisIncentive协议
- 2.5 WisDedup协议
- 2.6 WisCache协议

### 3. [智核协议](docs/04-core-intelligence.md)
- 3.1 智核生成协议
- 3.2 智核进化协议
- 3.3 智核验证协议
- 3.4 智核Agent反馈进化协议

### 4. [Agent协议](docs/05-agent.md)
- 4.1 Agent注册协议
- 4.2 Agent调用协议
- 4.3 Agent类型协议
- 4.4 Agent调度协议
- 4.5 Agent质量激励协议

### 5. [知识图谱协议](docs/06-knowledge-graph.md)
- 5.1 图数据库接口协议
- 5.2 知识关联协议

### 6. [通信协议](docs/07-communication.md)
- 6.1 REST API协议
- 6.2 WebSocket协议
- 6.3 gRPC协议

### 7. [安全协议](docs/08-security.md)
- 7.1 认证协议
- 7.2 加密协议
- 7.3 权限协议
- 7.4 零知识证明协议

### 8. [领域扩展协议](docs/09-domain-extension.md)
- 8.1 通用领域扩展协议
  - 8.1.1 领域插件注册协议
  - 8.1.2 领域验证规则扩展协议
  - 8.1.3 领域数据结构扩展协议
  - 8.1.4 通用领域配置协议

### 9. [经济模型协议](docs/10-economy.md)
- 9.1 信用协议
- 9.2 赏金协议
- 9.3 汇率协议

### 10. [部署协议](docs/11-deployment.md)
- 10.1 配置协议
- 10.2 监控协议
- 10.3 备份协议

### 11. [MCP/Skill协议](docs/12-mcp-skill.md)
- 11.1 MCP调用协议
- 11.2 Skill调用协议
- 11.3 Skill注册协议
- 11.4 Skill发现协议
- 11.5 Skill编排协议

---

## 🔌 协议选择指南

| 场景 | 推荐协议 | 理由 |
|------|----------|------|
| 简单查询 | REST API | 简单易用，广泛支持 |
| 实时通信 | WebSocket | 双向通信，低延迟 |
| 高性能服务 | gRPC | 二进制协议，高吞吐 |

---

## ❌ 错误码规范

| 错误码 | 说明 | HTTP状态码 |
|--------|------|-----------|
| `WU_001` | WisUnit不存在 | 404 |
| `WU_002` | WisUnit已存在 | 409 |
| `AG_001` | Agent注册失败 | 400 |
| `AG_002` | Agent不存在 | 404 |
| `VAL_001` | 验证失败 | 400 |
| `SEC_001` | 认证失败 | 401 |
| `SEC_002` | 权限不足 | 403 |
| `MIG_001` | 迁移失败 | 500 |
| `...` | ... | ... |


---

## ❓ 常见问题

### 通用问题

**Q: 什么是WisHub？**
A: WisHub是一个开放的知识共享生态系统，通过标准化协议实现AI代理间知识的验证、存储、检索和复用。

**Q: 如何开始使用？**
A: 查看[快速开始](#-快速开始)部分，然后探索[文档目录](#-文档目录)以获取详细的协议规范。

**Q: WisHub是开源的吗？**
A: 是的，WisHub采用[GPL-3.0许可证](LICENSE)。

### 技术问题

**Q: 支持哪些编程语言？**
A: 我们提供Python、TypeScript、Go、Java、Rust、C#/.NET、C++和PHP的官方SDK。详见[多语言SDK支持](#-多语言sdk支持)表格。

**Q: 三级存储如何工作？**
A: WisHub使用L1（内存，<1ms）、L2（分布式，<10ms）和L3（持久化，<100ms）存储以平衡性能和一致性。

**Q: 如何贡献？**
A: 查看[贡献指南](#-贡献指南)部分获取分步说明。

### 安全问题

**Q: 数据如何保护？**
A: WisHub使用TLS 1.3加密、零知识证明和细粒度访问控制。详见[安全最佳实践](#-安全最佳实践)部分。

**Q: 如何报告安全漏洞？**
A: 发送邮件至security@wishub.org或使用[GitHub安全建议](https://github.com/Liozhang/wishub-universal-protocol/security/advisories)。

### 代币与经济

**Q: WIS代币用于什么？**
A: WIS代币用于服务费用、质押、治理和质量激励。详见[Token经济模型](#-token经济模型)部分。

**Q: 参与代币经济有什么风险？**
A: 加密货币和代币价值受市场波动影响。详见Token经济模型部分的[风险免责声明](#-token经济模型)。

---

## 📖 术语表

| 术语 | 说明 |
|------|------|
| **WisUnit** | 知识单元，WisHub的数据基础 |
| **WISE** | WisStore/WisSync/WisVerify等协议的总称 |
| **智核** | 智能核心，AI决策的核心组件 |
| **Agent** | 智能代理，可独立执行任务的AI实体 |
| **MCP** | Model Context Protocol，模型上下文协议 |
| **Skill** | 技能，可被Agent调用的功能模块 |
| **L1/L2/L3** | 三级存储架构（内存/分布式/持久化）|
| **WIS Token** | WisHub生态原生代币 |

---

## 🌍 社区与支持

- **Discord**: [加入我们的Discord社区](https://discord.gg/wishub)
- **Twitter**: [@wishub](https://twitter.com/wishub)
- **GitHub Discussions**: [参与讨论](https://github.com/Liozhang/wishub-universal-protocol/discussions)
- **Reddit**: [r/WisHub](https://reddit.com/r/wishub)

---

## 🌐 多语言支持

- 🇨🇳 [中文](README_CN.md) (简体中文) - 完整版
- 🇺🇸 [English](README.md) (English) - 完整版
- 🇯🇵 [日本語](README_JA.md) (日本語) - 基础版
- 🇫🇷 [Français](README_FR.md) (法语) - 基础版

---

## 🤝 贡献指南

我们欢迎任何形式的贡献！请遵循以下步骤：

1. Fork 本仓库
2. 创建你的特性分支 (`git checkout -b feature/AmazingFeature`)
3. 提交你的更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 开启一个 Pull Request

### 👥 贡献者

- [@Liozhang](https://github.com/Liozhang) - 项目发起人

---

## 📝 许可证

本项目采用 [GPL-3.0 License](LICENSE) 开源。

---

## 📧 联系方式

- **项目地址**: https://github.com/Liozhang/wishub-universal-protocol
- **Issues**: https://github.com/Liozhang/wishub-universal-protocol/issues

---

## ⚠️ 安全最佳实践

- 始终使用最新版本的SDK
- 定期更新依赖库
- 遵循最小权限原则
- 启用TLS 1.3加密，使用AES-256-GCM加密套件
- 使用零知识证明保护隐私
- 验证所有传入和传出的请求与响应
- 使用环境变量存储敏感数据（API密钥、令牌）
- 启用速率限制以防止滥用
- 实现适当的错误处理，避免暴露敏感信息

### 🔒 安全漏洞披露

如果您发现安全漏洞，请负责任地报告：

- **邮箱**: security@wishub.org
- **GitHub安全**: [使用GitHub安全建议](https://github.com/Liozhang/wishub-universal-protocol/security/advisories)

请包含：
- 漏洞描述
- 重现步骤
- 受影响版本
- 建议修复方案（如有）

我们将在48小时内响应，并与您合作负责任地解决问题。

---

## 🎉 致谢

感谢所有为 WisHub 生态系统做出贡献的开发者和社区成员！

---

**WisHub 通用协议文档 v3.0.0** | 2026年2月23日

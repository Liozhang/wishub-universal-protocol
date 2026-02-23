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

- **WisUnit协议**: 知识单元的数据模型、CRUD操作、验证、迁移
- **WISE协议系统**: 多级存储（L1内存、L2分布式、L3持久化）
- **智核协议**: 智能核心的生成、进化、验证和反馈机制
- **Agent协议**: Agent的注册、调用、类型、调度和质量激励
- **知识图谱协议**: 图数据库接口和知识关联协议
- **通信协议**: REST API、WebSocket、gRPC三种通信方式
- **安全协议**: 认证、加密、权限、零知识证明
- **领域扩展协议**: 领域插件注册、验证规则扩展、数据结构扩展
- **经济模型协议**: 信用、赏金、汇率协议
- **部署协议**: 配置、监控、备份协议
- **MCP/Skill协议**: MCP调用、Skill调用、注册、发现、编排

### 💎 Token经济模型

- **WIS Token**: WisHub生态原生代币
- **用途**: 支付服务费、质押、治理
- **发行总量**: 10亿枚
- **分配**: 40% 生态激励、30% 团队、20% 投资者、10% 基金会

---

## ⚡ 性能指标

### 存储性能

| 存储层级 | 延迟 | 吞吐量 | 一致性 |
|---------|------|--------|--------|
| **L1 内存存储** | < 1ms | > 100K QPS | 最终一致性 |
| **L2 分布式存储** | < 10ms | > 10K QPS | 强一致性 (Raft) |
| **L3 持久化存储** | < 100ms | > 1K QPS | 强一致性 (ACID) |

### 通信性能

| 协议 | 吞吐量 | 延迟 | 适用场景 |
|------|--------|------|----------|
| **REST API** | 10K QPS | 10-50ms | 简单查询 |
| **WebSocket** | 1K QPS | 5-20ms | 实时通信 |
| **gRPC** | 50K QPS | 5-10ms | 高性能服务 |

---

## 📋 协议列表

### 1. WisUnit协议
- 1.1 WisUnit数据模型协议
- 1.2 WisUnit CRUD协议
- 1.3 WisUnit验证协议
- 1.4 WisUnit迁移协议

### 2. WISE协议系统
- 2.1 WisStore协议
- 2.2 WisSync协议
- 2.3 WisVerify协议
- 2.4 WisIncentive协议
- 2.5 WisDedup协议
- 2.6 WisCache协议

### 3. 智核协议
- 3.1 智核生成协议
- 3.2 智核进化协议
- 3.3 智核验证协议
- 3.4 智核Agent反馈进化协议

### 4. Agent协议
- 4.1 Agent注册协议
- 4.2 Agent调用协议
- 4.3 Agent类型协议
- 4.4 Agent调度协议
- 4.5 Agent质量激励协议

### 5. 知识图谱协议
- 5.1 图数据库接口协议
- 5.2 知识关联协议

### 6. 通信协议
- 6.1 REST API协议
- 6.2 WebSocket协议
- 6.3 gRPC协议

### 7. 安全协议
- 7.1 认证协议
- 7.2 加密协议
- 7.3 权限协议
- 7.4 零知识证明协议

### 8. 领域扩展协议
- 8.1 通用领域扩展协议
  - 8.1.1 领域插件注册协议
  - 8.1.2 领域验证规则扩展协议
  - 8.1.3 领域数据结构扩展协议
  - 8.1.4 通用领域配置协议

### 9. 经济模型协议
- 9.1 信用协议
- 9.2 赏金协议
- 9.3 汇率协议

### 10. 部署协议
- 10.1 配置协议
- 10.2 监控协议
- 10.3 备份协议

### 11. MCP/Skill协议
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

## 📅 版本历史

### v3.0.0 (2026-02-23)

**新增**:
- 新增领域扩展协议（8.1）
- 新增MCP/Skill协议（11）
- 新增智核Agent反馈进化协议（3.4）

**优化**:
- 重构WisUnit数据模型，支持领域扩展
- 优化验证协议，支持插件化验证规则
- 增强存储协议，支持三级存储架构

**修复**:
- 修复版本迁移中的兼容性问题
- 修复批量操作的事务回滚问题

**删除**:
- 移除v2.0过时的接口

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

- 🇨🇳 [中文](README.md) (简体中文) - 当前语言
- 🇺🇸 [English](README_EN.md) (English) - 即将推出
- 🇯🇵 [日本語](README_JA.md) (Japanese) - 计划中

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

## 📢 传播素材

### 社交媒体分享文案

**Twitter**:
```
🚀 Introducing WisHub Universal Protocol v3.0!

An open-source knowledge sharing ecosystem with 12 core protocols.

🔹 39 sub-protocols
🔹 Multi-language SDKs
🔹 AI-native architecture

Check it out: https://github.com/Liozhang/wishub-universal-protocol

#WisHub #OpenSource #AI #KnowledgeGraph
```

**LinkedIn**:
```
🎯 WisHub v3.0 Protocol is now available!

We're building future of knowledge sharing with:
- 12 Core Protocol Systems
- Multi-level Storage (L1/L2/L3)
- Agent Native Design
- Zero-Knowledge Privacy Protection

Read the docs: https://github.com/Liozhang/wishub-universal-protocol

#AI #KnowledgeSharing #OpenSource #Tech
```

---

## ⚠️ 安全最佳实践

- 始终使用最新版本的SDK
- 定期更新依赖库
- 遵循最小权限原则
- 启用TLS 1.3加密
- 使用零知识证明保护隐私

---

## 🎉 致谢

感谢所有为 WisHub 生态系统做出贡献的开发者和社区成员！

---

**WisHub 通用协议文档 v3.0.0** | 2026年2月23日

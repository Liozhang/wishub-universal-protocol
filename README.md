# WisHub 通用协议文档

**项目名称**: WisHub 核心协议
**发布日期**: 2026年2月23日
**文档类型**: 通用协议规范
**版本**: v3.0.0

---

## 📖 项目简介

WisHub 通用协议文档定义了 WisHub 生态系统的核心协议规范，包括数据模型、存储、验证、智能核心、Agent 管理等 12 大类协议。这些协议旨在构建一个开放、可扩展、高性能的知识共享和智能服务生态系统。

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

1. **可执行层 (Layer 1)**: AI、机器、Agent可执行的知识
2. **结构化层 (Layer 2)**: 程序、系统可处理的知识
3. **自然语言层 (Layer 3)**: 人类可理解的知识

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

## 🤝 贡献指南

我们欢迎任何形式的贡献！请遵循以下步骤：

1. Fork 本仓库
2. 创建你的特性分支 (`git checkout -b feature/AmazingFeature`)
3. 提交你的更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 开启一个 Pull Request

---

## 📝 许可证

本项目采用 [MIT License](LICENSE) 开源。

---

## 📧 联系方式

- **项目地址**: https://github.com/Liozhang/wishub-universal-protocol
- **Issues**: https://github.com/Liozhang/wishub-universal-protocol/issues

---

## 🎉 致谢

感谢所有为 WisHub 生态系统做出贡献的开发者和社区成员！

---

**WisHub 通用协议文档 v3.0.0** | 2026年2月23日

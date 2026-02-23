# WisHub Universal Protocol

![Version](https://img.shields.io/badge/version-v3.0.0-blue.svg)
![License](https://img.shields.io/badge/license-GPL--3.0-blue.svg)
![GitHub Stars](https://img.shields.io/github/stars/Liozhang/wishub-universal-protocol?style=social)
![Build Status](https://img.shields.io/badge/build-passing-brightgreen.svg)

**Project Name**: WisHub Core Protocol
**Release Date**: February 23, 2026
**Document Type**: Universal Protocol Specification
**Version**: v3.0.0

---

## 📖 Project Overview

**Build wisdom units and a wisdom connection hub to accelerate the construction of collective human wisdom.**

WisHub Universal Protocol defines the core protocol specifications for the WisHub ecosystem, covering 12 major categories including data models, storage, validation, intelligent cores, and Agent management. These protocols are designed to build an open, scalable, and high-performance knowledge sharing and intelligent service ecosystem.

WisHub enables:
- **Wisdom Units (WisUnit)**: Standardized knowledge units with three-layer structure (executable, structured, natural language)
- **Wisdom Connection Hub (Hub)**: Multi-level storage, intelligent retrieval, global indexing, quality validation
- **Collective Wisdom**: Efficient flow of high-quality wisdom in the AI ecosystem through validation, sharing, reuse, and evolution

### 💡 Core Philosophy

**WisHub = Wis (Wisdom) + Hub (Connection Center)**

The core value of WisHub lies in:
- **Wis (Wisdom)**: Quality validation, semantic understanding, logical reasoning, intelligent evolution
- **Hub (Connection Center)**: Centralized storage, intelligent distribution, global indexing, ecosystem connection
- **Collective Wisdom**: Let high-quality wisdom flow efficiently in the AI ecosystem — verified once, reused infinitely

---

## 📚 Documentation Directory

### Core Protocol Documents

| # | Document | Description | Size |
|---|-----------|-------------|-------|
| 1 | [Protocol Standards](docs/01-introduction.md) | JSON format, multi-language SDK support | 2.7KB |
| 2 | [WisUnit Protocol](docs/02-wisunit.md) | Data model, CRUD, validation, migration | 47KB |
| 3 | [WISE Protocol System](docs/03-wise.md) | Storage, sync, validation, incentive, dedup, cache | 8.5KB |
| 4 | [Core Intelligence Protocol](docs/04-core-intelligence.md) | Core generation, evolution, validation, feedback | 5.2KB |
| 5 | [Agent Protocol](docs/05-agent.md) | Registration, invocation, type, scheduling, incentive | 5.8KB |
| 6 | [Knowledge Graph Protocol](docs/06-knowledge-graph.md) | Graph database interface, knowledge association | 2.4KB |
| 7 | [Communication Protocol](docs/07-communication.md) | REST API, WebSocket, gRPC | 3.1KB |
| 8 | [Security Protocol](docs/08-security.md) | Authentication, encryption, permission, zero-knowledge proof | 4.8KB |
| 9 | [Domain Extension Protocol](docs/09-domain-extension.md) | Domain plugins, validation rules, data structure, configuration | 29KB |
| 10 | [Economy Protocol](docs/10-economy.md) | Credit, bounty, exchange rate | 3.6KB |
| 11 | [Deployment Protocol](docs/11-deployment.md) | Configuration, monitoring, backup | 5.3KB |
| 12 | [MCP/Skill Protocol](docs/12-mcp-skill.md) | MCP invocation, Skill invocation, registration, discovery, orchestration | 20KB |

---

## 🚀 Quick Start

### Protocol Standard Format

All protocol requests and responses use JSON format:

```json
{
  "protocol": "Protocol Name",
  "version": "Protocol Version",
  "request_type": "Request Type",
  "request": { ... },
  "response_type": "Response Type",
  "status": "Status",
  "data": { ... },
  "message": "Message"
}
```

### Agent Development Example

```python
from wishub import Agent

# Create Agent
agent = Agent(
    name="WeatherAgent",
    type="task_agent",
    capabilities=["weather_forecast", "weather_alert"]
)

# Register Agent
agent.register()

# Invoke Agent
result = agent.invoke({"location": "Beijing", "date": "2026-02-24"})
```

### Multi-Language SDK Support

WisHub provides official SDKs in the following languages:

| SDK Language | Package Manager | Priority | Dev Time | Use Case |
|-------------|-----------------|-----------|-----------|----------|
| **Python** | pip | P0 | 2 weeks | AI/ML, prototyping |
| **TypeScript** | npm | P0 | 2 weeks | Frontend, Node.js |
| **Go** | go mod | P1 | 2 weeks | High-performance services |
| **Java** | Maven/Gradle | P1 | 2 weeks | Enterprise applications |
| **Rust** | Cargo | P2 | 2 weeks | High-performance critical paths |
| **C#/.NET** | NuGet | P2 | 2 weeks | Windows ecosystem |
| **C++** | CMake/vcpkg | P3 | 3 weeks | Embedded systems |
| **PHP** | Composer | P3 | 2 weeks | Web applications |

---

## 🏗️ Protocol Architecture

### Three-Layer Architecture

WisHub adopts a three-layer architecture design:

```
┌─────────────────────────────────────────┐
│   Layer 3: Natural Language Layer      │
│   (Human-understandable knowledge)        │
└─────────────────────────────────────────┘
                    ↓
┌─────────────────────────────────────────┐
│   Layer 2: Structured Layer            │
│   (Program/system-processable knowledge)  │
└─────────────────────────────────────────┘
                    ↓
┌─────────────────────────────────────────┐
│   Layer 1: Executable Layer            │
│   (AI/machine/Agent-executable knowledge)│
└─────────────────────────────────────────┘
```

### Core Protocol Systems

- **WisUnit Protocol**: Data model, CRUD operations, validation, migration for knowledge units
- **WISE Protocol System**: Multi-level storage (L1 memory, L2 distributed, L3 persistent)
- **Core Intelligence Protocol**: Generation, evolution, validation, and feedback mechanisms for intelligent cores
- **Agent Protocol**: Registration, invocation, type, scheduling, and quality incentives for Agents
- **Knowledge Graph Protocol**: Graph database interface and knowledge association protocols
- **Communication Protocol**: Three communication methods: REST API, WebSocket, gRPC
- **Security Protocol**: Authentication, encryption, permissions, zero-knowledge proofs
- **Domain Extension Protocol**: Domain plugin registration, validation rule extension, data structure extension
- **Economy Protocol**: Credit, bounty, and exchange rate protocols
- **Deployment Protocol**: Configuration, monitoring, and backup protocols
- **MCP/Skill Protocol**: MCP invocation, Skill invocation, registration, discovery, orchestration

### 💎 Token Economic Model

- **WIS Token**: WisHub ecosystem native token
- **Usage**: Service fees, staking, governance
- **Total Supply**: 1 billion tokens
- **Distribution**: 40% ecosystem incentives, 30% team, 20% investors, 10% foundation

---

## ⚡ Performance Metrics

### Storage Performance

| Storage Level | Latency | Throughput | Consistency |
|----------------|----------|-------------|--------------|
| **L1 Memory Storage** | < 1ms | > 100K QPS | Eventual Consistency |
| **L2 Distributed Storage** | < 10ms | > 10K QPS | Strong Consistency (Raft) |
| **L3 Persistent Storage** | < 100ms | > 1K QPS | Strong Consistency (ACID) |

### Communication Performance

| Protocol | Throughput | Latency | Use Case |
|----------|-------------|----------|----------|
| **REST API** | 10K QPS | 10-50ms | Simple queries |
| **WebSocket** | 1K QPS | 5-20ms | Real-time communication |
| **gRPC** | 50K QPS | 5-10ms | High-performance services |

---

## 📋 Protocol List

### 1. WisUnit Protocol
- 1.1 WisUnit Data Model Protocol
- 1.2 WisUnit CRUD Protocol
- 1.3 WisUnit Validation Protocol
- 1.4 WisUnit Migration Protocol

### 2. WISE Protocol System
- 2.1 WisStore Protocol
- 2.2 WisSync Protocol
- 2.3 WisVerify Protocol
- 2.4 WisIncentive Protocol
- 2.5 WisDedup Protocol
- 2.6 WisCache Protocol

### 3. Core Intelligence Protocol
- 3.1 Core Generation Protocol
- 3.2 Core Evolution Protocol
- 3.3 Core Validation Protocol
- 3.4 Core Agent Feedback Evolution Protocol

### 4. Agent Protocol
- 4.1 Agent Registration Protocol
- 4.2 Agent Invocation Protocol
- 4.3 Agent Type Protocol
- 4.4 Agent Scheduling Protocol
- 4.5 Agent Quality Incentive Protocol

### 5. Knowledge Graph Protocol
- 5.1 Graph Database Interface Protocol
- 5.2 Knowledge Association Protocol

### 6. Communication Protocol
- 6.1 REST API Protocol
- 6.2 WebSocket Protocol
- 6.3 gRPC Protocol

### 7. Security Protocol
- 7.1 Authentication Protocol
- 7.2 Encryption Protocol
- 7.3 Permission Protocol
- 7.4 Zero-Knowledge Proof Protocol

### 8. Domain Extension Protocol
- 8.1 Universal Domain Extension Protocol
  - 8.1.1 Domain Plugin Registration Protocol
  - 8.1.2 Domain Validation Rule Extension Protocol
  - 8.1.3 Domain Data Structure Extension Protocol
  - 8.1.4 Universal Domain Configuration Protocol

### 9. Economy Protocol
- 9.1 Credit Protocol
- 9.2 Bounty Protocol
- 9.3 Exchange Rate Protocol

### 10. Deployment Protocol
- 10.1 Configuration Protocol
- 10.2 Monitoring Protocol
- 10.3 Backup Protocol

### 11. MCP/Skill Protocol
- 11.1 MCP Invocation Protocol
- 11.2 Skill Invocation Protocol
- 11.3 Skill Registration Protocol
- 11.4 Skill Discovery Protocol
- 11.5 Skill Orchestration Protocol

---

## 🔌 Protocol Selection Guide

| Scenario | Recommended Protocol | Reason |
|----------|-------------------|--------|
| Simple Queries | REST API | Simple and easy to use |
| Real-time Communication | WebSocket | Bidirectional communication, low latency |
| High-Performance Services | gRPC | Binary protocol, high throughput |

---

## ❌ Error Code Specification

| Error Code | Description | HTTP Status Code |
|-----------|-------------|-------------------|
| `WU_001` | WisUnit not found | 404 |
| `WU_002` | WisUnit already exists | 409 |
| `AG_001` | Agent registration failed | 400 |
| `AG_002` | Agent not found | 404 |
| `VAL_001` | Validation failed | 400 |
| `SEC_001` | Authentication failed | 401 |
| `SEC_002` | Permission denied | 403 |
| `MIG_001` | Migration failed | 500 |
| `...` | ... | ... |

---

## 📅 Version History

### v3.0.0 (2026-02-23)

**Added**:
- Domain Extension Protocol (8.1)
- MCP/Skill Protocol (11)
- Core Agent Feedback Evolution Protocol (3.4)

**Enhanced**:
- Refactored WisUnit data model to support domain extensions
- Optimized validation protocol to support plugin-based validation rules
- Enhanced storage protocol to support three-level storage architecture

**Fixed**:
- Fixed compatibility issues in version migration
- Fixed transaction rollback issues in batch operations

**Removed**:
- Removed v2.0 deprecated interfaces

---

## 📖 Glossary

| Term | Description |
|------|-------------|
| **WisUnit** | Knowledge Unit, the data foundation of WisHub |
| **WISE** | General term for WisStore/WisSync/WisVerify protocols |
| **Core Intelligence** | Intelligent Core, the core component for AI decision-making |
| **Agent** | Intelligent Agent, an AI entity capable of independent task execution |
| **MCP** | Model Context Protocol, protocol for model context |
| **Skill** | Skill, a functional module that can be invoked by Agents |
| **L1/L2/L3** | Three-level storage architecture (memory/distributed/persistent) |
| **WIS Token** | WisHub ecosystem native token |

---

## 🌍 Community & Support

- **Discord**: [Join our Discord community](https://discord.gg/wishub)
- **Twitter**: [@wishub](https://twitter.com/wishub)
- **GitHub Discussions**: [Join discussions](https://github.com/Liozhang/wishub-universal-protocol/discussions)
- **Reddit**: [r/WisHub](https://reddit.com/r/wishub)

---

## 🌐 Multi-Language Support

- 🇺🇸 **English** [README.md](README.md) - Complete version
- 🇨🇳 [中文](README_CN.md) - Complete version
- 🇯🇵 [日本語](README_JA.md) - Basic version
- 🇫🇷 [Français](README_FR.md) - Basic version

---

## 🤝 Contributing

We welcome any form of contribution! Please follow these steps:

1. Fork this repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

### 👥 Contributors

- [@Liozhang](https://github.com/Liozhang) - Project Founder

---

## 📝 License

This project is licensed under the [GPL-3.0 License](LICENSE).

---

## 📧 Contact

- **Project URL**: https://github.com/Liozhang/wishub-universal-protocol
- **Issues**: https://github.com/Liozhang/wishub-universal-protocol/issues

---

## ⚠️ Security Best Practices

- Always use the latest version of SDK
- Update dependencies regularly
- Follow the principle of least privilege
- Enable TLS 1.3 encryption
- Use zero-knowledge proofs to protect privacy

---

## 🎉 Acknowledgments

Thanks to all developers and community members who have contributed to the WisHub ecosystem!

---

**WisHub Universal Protocol v3.0.0** | February 23, 2026

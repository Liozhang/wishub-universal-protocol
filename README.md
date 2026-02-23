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

## 🎨 Logo & Branding

[![WisHub Logo](https://via.placeholder.com/200x200/4A90E2/ffffff?text=WisHub)](https://via.placeholder.com/200x200/4A90E2/ffffff?text=WisHub)

**Note**: Project logo and branding assets coming soon. For now, we're using a placeholder.

---

## 📖 Project Overview

**Build wisdom units and a wisdom connection hub to accelerate the construction of collective human wisdom.**

WisHub Universal Protocol defines the core protocol specifications for the WisHub ecosystem, covering 12 major categories including data models, storage, validation, intelligent cores, and Agent management. These protocols are designed to build an open, scalable, and high-performance knowledge sharing and intelligent service ecosystem.

**Quick Navigation**:
- [Quick Start](#-quick-start) - Get started in 3 minutes
- [Protocol Architecture](#-protocol-architecture) - Understand the system design
- [Documentation](#-documentation-directory) - Detailed protocol specifications
- [FAQ](#-faq) - Common questions and answers

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

# Create an Agent with specified name, type, and capabilities
agent = Agent(
    name="WeatherAgent",
    type="task_agent",
    capabilities=["weather_forecast", "weather_alert"]
)

# Register the Agent with WisHub Hub
agent.register()

# Invoke the Agent with parameters and get results
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

### Overall Protocol Architecture

```
┌─────────────────────────────────────────────────────────┐
│                 WisHub Ecosystem                       │
├─────────────────────────────────────────────────────────┤
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐ │
│  │ WisUnit     │  │ WISE        │  │ Core Intel  │ │
│  │ Protocol    │  │ Protocol    │  │ Protocol    │ │
│  └─────────────┘  └─────────────┘  └─────────────┘ │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐ │
│  │ Agent       │  │ Knowledge   │  │ Domain      │ │
│  │ Protocol    │  │ Graph       │  │ Extension   │ │
│  │             │  │ Protocol    │  │ Protocol    │ │
│  └─────────────┘  └─────────────┘  └─────────────┘ │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐ │
│  │ Commun-     │  │ Security    │  │ Economy     │ │
│  │ ication    │  │ Protocol    │  │ Protocol    │ │
│  │ Protocol    │  └─────────────┘  └─────────────┘ │
│  └─────────────┘                                    │
│  ┌─────────────┐  ┌─────────────┐                  │
│  │ Deploy-     │  │ MCP/        │                  │
│  │ ment        │  │ Skill       │                  │
│  │ Protocol    │  │ Protocol    │                  │
│  └─────────────┘  └─────────────┘                  │
└─────────────────────────────────────────────────────────┘
```

**Protocol Dependencies**: All protocols communicate through standardized JSON interfaces. WisUnit serves as the core data model, WISE handles storage, and Agents consume all services through defined APIs.

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

### 🔄 Data Migration & Backup

WisHub provides robust data migration and backup mechanisms:

- **WisUnit Migration**: Seamlessly migrate WisUnits between protocol versions with automatic schema conversion
- **Automatic Backup**: Scheduled backups to L3 persistent storage with configurable retention policies
- **Point-in-Time Recovery**: Restore data to any specific point in time for disaster recovery
- **Cross-Region Replication**: Optional multi-region deployment for business continuity

For detailed migration procedures, see [WisUnit Protocol](docs/02-wisunit.md) and [Deployment Protocol](docs/11-deployment.md).

### 💎 Token Economic Model

- **WIS Token**: WisHub ecosystem native token
- **Usage**: Service fees, staking, governance, quality incentives
- **Total Supply**: 1 billion tokens
- **Distribution**: 40% ecosystem incentives, 30% team, 20% investors, 10% foundation

**Key Mechanisms**:
- **Staking**: Lock WIS tokens to access premium services and earn rewards
- **Governance**: Token holders can vote on protocol upgrades and policy changes
- **Quality Incentives**: Rewards for high-quality WisUnits and Agent performance
- **Service Fees**: Fees for API calls and advanced features

⚠️ **Risk Disclaimer**: Cryptocurrency and token values are subject to market volatility. WisHub makes no representations or warranties about token performance. Always conduct your own research and understand the risks before participating in token-related activities.

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

**Agent Quality Assessment**: Agents are evaluated based on accuracy, response time, user feedback, and reliability. High-performing Agents receive WIS token rewards and priority scheduling.

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

### 📖 API Documentation

For detailed API specifications, endpoints, and examples, see:
- [Communication Protocol](docs/07-communication.md) - REST API, WebSocket, gRPC specifications
- [OpenAPI/Swagger](https://github.com/Liozhang/wishub-universal-protocol/blob/main/docs/07-communication.md) - Interactive API documentation (coming soon)

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

## ❓ FAQ

### General

**Q: What is WisHub?**
A: WisHub is an open knowledge sharing ecosystem that uses standardized protocols to enable efficient validation, storage, retrieval, and reuse of knowledge among AI agents.

**Q: How do I get started?**
A: Check out the [Quick Start](#-quick-start) section above, then explore the [Documentation Directory](#-documentation-directory) for detailed protocol specifications.

**Q: Is WisHub open source?**
A: Yes, WisHub is licensed under [GPL-3.0](LICENSE).

### Technical

**Q: What programming languages are supported?**
A: We provide official SDKs for Python, TypeScript, Go, Java, Rust, C#/.NET, C++, and PHP. See the [Multi-Language SDK Support](#-multi-language-sdk-support) table for details.

**Q: How does the three-layer storage work?**
A: WisHub uses L1 (memory, <1ms), L2 (distributed, <10ms), and L3 (persistent, <100ms) storage to balance performance and consistency. See the [Performance Metrics](#-performance-metrics) section for details.

**Q: How do I contribute?**
A: See the [Contributing](#-contributing) section for step-by-step instructions.

### Security

**Q: How is data secured?**
A: WisHub uses TLS 1.3 encryption, zero-knowledge proofs, and fine-grained access controls. See the [Security Best Practices](#-security-best-practices) section for more information.

**Q: How do I report a security vulnerability?**
A: Email us at security@wishub.org or use [GitHub Security Advisories](https://github.com/Liozhang/wishub-universal-protocol/security/advisories).

### Token & Economy

**Q: What is the WIS token used for?**
A: WIS tokens are used for service fees, staking, governance, and quality incentives. See the [Token Economic Model](#-token-economic-model) section for details.

**Q: What are the risks of participating in the token economy?**
A: Cryptocurrency and token values are subject to market volatility. See the [Risk Disclaimer](#-token-economic-model) in the Token Economic Model section.

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
- Enable TLS 1.3 encryption with AES-256-GCM cipher suite
- Use zero-knowledge proofs to protect privacy
- Validate all incoming requests and responses
- Use environment variables for sensitive data (API keys, tokens)
- Enable rate limiting to prevent abuse
- Implement proper error handling without exposing sensitive information

### 🔒 Security Disclosure

If you discover a security vulnerability, please report it responsibly:

- **Email**: security@wishub.org
- **GitHub Security**: [Use GitHub Security Advisories](https://github.com/Liozhang/wishub-universal-protocol/security/advisories)

Please include:
- Description of the vulnerability
- Steps to reproduce
- Affected versions
- Suggested fix (if available)

We will respond within 48 hours and work with you to address the issue responsibly.

---

## 🎉 Acknowledgments

Thanks to all developers and community members who have contributed to the WisHub ecosystem!

---

**WisHub Universal Protocol v3.0.0** | February 23, 2026

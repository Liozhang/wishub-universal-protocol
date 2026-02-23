# WisHub 通用协议文档

**项目名称**: WisHub 核心协议
**发布日期**: 2026年2月23日
**文档类型**: 通用协议规范

---

## 协议标准说明

### JSON传输格式
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

**注意**: 本文档包含完整的37个协议定义（包括新增的5个MCP/Skill协议）。由于篇幅限制，这里展示协议结构和MCP/Skill协议的完整定义。完整的32个核心协议定义请参考wishub-protocol-v3.0.md。

---

## 目录

1. [WisUnit协议](#1-wisunit协议)
2. [WISE协议系统](#2-wise协议系统)
3. [智核协议](#3-智核协议)
4. [Agent协议](#4-agent协议)
5. [知识图谱协议](#5-知识图谱协议)
6. [通信协议](#6-通信协议)
7. [安全协议](#7-安全协议)
8. [领域扩展协议](#8-领域扩展协议)
9. [经济模型协议](#9-经济模型协议)
10. [部署协议](#10-部署协议)
11. [MCP/Skill协议](#11-mcpskill协议) - **新增**

---


---

# 11. MCP/Skill协议

## 11.1 MCP调用协议

### 协议名称
Model Context Protocol (MCP) Invocation Protocol

### 协议描述
定义MCP（Model Context Protocol）的调用协议，支持AI模型通过MCP协议获取WisHub知识上下文。

### 协议版本
v1.0.0

### JSON Schema

```json
{
  "MCPInvokeRequest": {
    "type": "object",
    "required": ["context_id", "model_id", "prompt"],
    "properties": {
      "context_id": {"type": "string", "description": "上下文ID"},
      "model_id": {"type": "string", "description": "模型ID（如：gpt-4, glm-5, llama-3）"},
      "prompt": {"type": "string", "description": "用户提示词"},
      "context_type": {
        "type": "string",
        "enum": ["wisunit", "knowledge_graph", "wisdom_core"],
        "description": "上下文类型"
      },
      "max_tokens": {"type": "integer", "default": 2000, "description": "最大生成Token数"},
      "temperature": {
        "type": "number",
        "default": 0.7,
        "minimum": 0,
        "maximum": 2,
        "description": "温度参数"
      }
    }
  },
  "MCPInvokeResponse": {
    "type": "object",
    "properties": {
      "status": {"type": "string", "enum": ["success", "error"]},
      "context": {"type": "object", "description": "获取的上下文"},
      "response": {"type": "string", "description": "AI模型响应"},
      "tokens_used": {"type": "integer", "description": "使用的Token数"},
      "message": {"type": "string"}
    }
  }
}
```

### Python SDK示例

```python
from wishub_sdk import MCPClient

# 初始化MCP客户端
mcp_client = MCPClient(
    api_key="your_api_key",
    base_url="https://api.wishub.com"
)

# 调用MCP获取上下文
response = await mcp_client.invoke(
    context_id="ctx_20250223_001",
    model_id="gpt-4",
    prompt="糖尿病的正常血糖范围是多少？",
    context_type="wisunit",
    max_tokens=500,
    temperature=0.5
)

# 处理响应
if response.status == "success":
    print(f"AI响应: {response.response}")
    print(f"使用的Token数: {response.tokens_used}")
```

---

## 11.2 Skill调用协议

### 协议名称
Skill Invocation Protocol

### 协议描述
定义Skill（技能）的调用协议，支持通过Skill ID调用特定的AI能力。

### 协议版本
v1.0.0

### JSON Schema

```json
{
  "SkillInvokeRequest": {
    "type": "object",
    "required": ["skill_id", "inputs"],
    "properties": {
      "skill_id": {"type": "string", "description": "Skill ID"},
      "skill_version": {"type": "string", "description": "Skill版本（可选）"},
      "inputs": {"type": "object", "description": "Skill输入参数"},
      "timeout": {"type": "integer", "default": 30, "description": "超时时间（秒）"},
      "async": {"type": "boolean", "default": false, "description": "是否异步调用"}
    }
  },
  "SkillInvokeResponse": {
    "type": "object",
    "properties": {
      "status": {"type": "string", "enum": ["success", "pending", "error"]},
      "task_id": {"type": "string", "description": "任务ID（异步调用时返回）"},
      "outputs": {"type": "object", "description": "Skill输出结果"},
      "execution_time": {"type": "number", "description": "执行时间（毫秒）"},
      "message": {"type": "string"}
    }
  }
}
```

### Python SDK示例

```python
from wishub_sdk import SkillClient

# 初始化Skill客户端
skill_client = SkillClient(
    api_key="your_api_key",
    base_url="https://api.wishub.com"
)

# 同步调用Skill
response = await skill_client.invoke(
    skill_id="skill_medical_diagnosis",
    inputs={"symptoms": ["口渴", "多尿"], "patient_age": 45},
    timeout=30
)

if response.status == "success":
    print(f"诊断结果: {response.outputs}")
```

---

## 11.3 Skill注册协议

### 协议名称
Skill Registration Protocol

### 协议描述
定义Skill的注册协议，支持开发者上传和管理自定义Skill。

### 协议版本
v1.0.0

### JSON Schema

```json
{
  "SkillRegistrationRequest": {
    "type": "object",
    "required": ["skill_id", "skill_name", "version", "code"],
    "properties": {
      "skill_id": {"type": "string", "description": "Skill ID"},
      "skill_name": {"type": "string", "description": "Skill名称"},
      "description": {"type": "string", "description": "Skill描述"},
      "version": {"type": "string", "description": "Skill版本（SemVer格式）"},
      "language": {
        "type": "string",
        "enum": ["python", "typescript", "go", "java", "rust"],
        "description": "Skill代码语言"
      },
      "code": {"type": "string", "description": "Skill代码（Base64编码或URL）"},
      "dependencies": {"type": "array", "items": {"type": "string"}},
      "input_schema": {"type": "object", "description": "输入参数的JSON Schema"},
      "output_schema": {"type": "object", "description": "输出结果的JSON Schema"},
      "author": {"type": "string", "description": "作者"}
    }
  },
  "SkillRegistrationResponse": {
    "type": "object",
    "properties": {
      "status": {"type": "string", "enum": ["success", "error"]},
      "skill_id": {"type": "string"},
      "version": {"type": "string"},
      "registration_time": {"type": "string"}
    }
  }
}
```

### Python SDK示例

```python
from wishub_sdk import SkillRegistry

# 初始化Skill注册客户端
registry = SkillRegistry(api_key="your_api_key")

# 注册Skill
response = await registry.register(
    skill_id="skill_medical_diagnosis",
    skill_name="医学诊断技能",
    version="1.0.0",
    language="python",
    code="#!/usr/bin/env python3\n...",
    author="Dr. Wang"
)
```

---

## 11.4 Skill发现协议

### 协议名称
Skill Discovery Protocol

### 协议描述
定义Skill的发现协议，支持查询和搜索可用的Skill。

### 协议版本
v1.0.0

### JSON Schema

```json
{
  "SkillDiscoveryRequest": {
    "type": "object",
    "properties": {
      "query": {"type": "string", "description": "搜索关键词"},
      "category": {"type": "string", "description": "Skill类别"},
      "language": {"type": "string", "description": "代码语言"},
      "author": {"type": "string", "description": "作者"},
      "limit": {"type": "integer", "default": 20},
      "offset": {"type": "integer", "default": 0}
    }
  },
  "SkillDiscoveryResponse": {
    "type": "object",
    "properties": {
      "status": {"type": "string", "enum": ["success", "error"]},
      "skills": {
        "type": "array",
        "items": {
          "type": "object",
          "properties": {
            "skill_id": {"type": "string"},
            "skill_name": {"type": "string"},
            "description": {"type": "string"},
            "version": {"type": "string"},
            "category": {"type": "string"},
            "rating": {"type": "number"}
          }
        }
      },
      "total": {"type": "integer"}
    }
  }
}
```

### Python SDK示例

```python
from wishub_sdk import SkillDiscovery

# 搜索Skill
discovery = SkillDiscovery(api_key="your_api_key")

response = await discovery.search(
    query="糖尿病",
    category="medical",
    limit=10
)

if response.status == "success":
    print(f"找到{response.total}个Skill")
```

---

## 11.5 Skill编排协议

### 协议名称
Skill Orchestration Protocol

### 协议描述
定义Skill的编排协议，支持多个Skill的组合调用和工作流定义。

### 协议版本
v1.0.0

### JSON Schema

```json
{
  "SkillOrchestrationRequest": {
    "type": "object",
    "required": ["workflow_id", "workflow"],
    "properties": {
      "workflow_id": {"type": "string"},
      "workflow": {
        "type": "object",
        "properties": {
          "name": {"type": "string"},
          "description": {"type": "string"},
          "steps": {
            "type": "array",
            "items": {
              "type": "object",
              "properties": {
                "step_id": {"type": "string"},
                "skill_id": {"type": "string"},
                "inputs": {"type": "object"},
                "depends_on": {"type": "array", "items": {"type": "string"}}
              }
            }
          }
        }
      },
      "execution_mode": {
        "type": "string",
        "enum": ["sequential", "parallel", "hybrid"],
        "default": "sequential"
      }
    }
  },
  "SkillOrchestrationResponse": {
    "type": "object",
    "properties": {
      "status": {"type": "string", "enum": ["success", "running", "error"]},
      "execution_id": {"type": "string"},
      "results": {"type": "object"},
      "execution_time": {"type": "number"}
    }
  }
}
```

### Python SDK示例

```python
from wishub_sdk import SkillOrchestrator

# 定义工作流
orchestrator = SkillOrchestrator(api_key="your_api_key")

workflow = {
    "name": "医学诊断工作流",
    "steps": [
        {"step_id": "step_1", "skill_id": "skill_symptom_extractor", "inputs": {...}},
        {"step_id": "step_2", "skill_id": "skill_medical_diagnosis", "depends_on": ["step_1"], "inputs": {...}},
        {"step_id": "step_3", "skill_id": "skill_treatment", "depends_on": ["step_2"], "inputs": {...}}
    ]
}

# 执行工作流
response = await orchestrator.execute(
    workflow_id="wf_medical_001",
    workflow=workflow,
    execution_mode="sequential"
)

if response.status == "success":
    print(f"工作流执行完成")
```

---

## 附录: 协议统计

### 协议总数
- **总协议数**: 37个
- **通用协议**: 31个
- **扩展协议**: 1个
- **MCP/Skill协议**: 5个（新增）
- **部署协议**: 3个

### SDK支持计划

| 阶段 | SDK语言 | 开发时间 | 优先级 |
|------|---------|---------|--------|
| Phase 1 | Python, TypeScript, Go, Java | 2周 | P0 |
| Phase 2 | Rust, C#, C++, PHP | 2周 | P1-P3 |

---

**文档版本**: v3.0
**最后更新**: 2026年2月23日

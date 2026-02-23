# 11. MCP/Skill协议

## 11.1 MCP调用协议

### 协议名称
Model Context Protocol (MCP) Invocation Protocol

### 协议描述
定义MCP（Model Context Protocol）的调用协议，支持AI模型通过MCP协议获取WisHub知识上下文。

### 协议版本
v1.0.0

### 接口定义

```python
from typing import Dict, Any, Optional, List
from pydantic import BaseModel
from datetime import datetime
from enum import Enum

class ContextType(str, Enum):
    WISUNIT = "wisunit"
    KNOWLEDGE_GRAPH = "knowledge_graph"
    WISDOM_CORE = "wisdom_core"

class MCPInvokeRequest(BaseModel):
    """MCP调用请求"""
    context_id: str
    model_id: str  # 如：gpt-4, glm-5, llama-3
    prompt: str
    context_type: ContextType = ContextType.WISUNIT
    max_tokens: int = 2000
    temperature: float = 0.7

class MCPInvokeResponse(BaseModel):
    """MCP调用响应"""
    status: str
    context: Optional[Dict[str, Any]] = None
    response: Optional[str] = None
    tokens_used: Optional[int] = None
    message: Optional[str] = None
    error: Optional[Dict[str, Any]] = None
```

### JSON Schema (请求)

```json
{
  "MCPInvokeRequest": {
    "type": "object",
    "required": ["context_id", "model_id", "prompt"],
    "properties": {
      "context_id": {"type": "string"},
      "model_id": {"type": "string", "description": "如：gpt-4, glm-5, llama-3"},
      "prompt": {"type": "string"},
      "context_type": {"type": "string", "enum": ["wisunit", "knowledge_graph", "wisdom_core"]},
      "max_tokens": {"type": "integer", "default": 2000},
      "temperature": {"type": "number", "default": 0.7, "minimum": 0, "maximum": 2}
    }
  }
}
```

### JSON Schema (响应)

```json
{
  "MCPInvokeResponse": {
    "type": "object",
    "properties": {
      "status": {"type": "string", "enum": ["success", "error"]},
      "context": {"type": "object"},
      "response": {"type": "string"},
      "tokens_used": {"type": "integer"},
      "message": {"type": "string"},
      "error": {"type": "object"}
    }
  }
}
```

### 错误码定义

| 错误码 | 描述 | HTTP状态码 |
|--------|------|-----------|
| `MCP_001` | 上下文不存在 | 404 |
| `MCP_002` | 模型不支持 | 400 |
| `MCP_003` | Token超限 | 429 |
| `MCP_999` | 未知错误 | 500 |

### Python SDK示例

```python
from wishub_sdk import MCPClient

# 初始化MCP客户端
mcp_client = MCPClient(api_key="your_api_key", base_url="https://api.wishub.com")

# 调用MCP获取上下文
response = await mcp_client.invoke(
    context_id="ctx_20250223_001",
    model_id="gpt-4",
    prompt="糖尿病的正常血糖范围是多少？",
    context_type=ContextType.WISUNIT,
    max_tokens=500,
    temperature=0.5
)

# 处理响应
if response.status == "success":
    print(f"AI响应: {response.response}")
    print(f"使用的Token数: {response.tokens_used}")
else:
    print(f"错误: {response.message}")
```

### Go SDK示例

```go
package main

import (
    "context"
    "fmt"
    "github.com/wishub/sdk-go/mcp"
)

func main() {
    // 初始化MCP客户端
    client := mcp.NewClient("your_api_key", "https://api.wishub.com")

    // 调用MCP获取上下文
    response, err := client.Invoke(context.Background(), &mcp.InvokeRequest{
        ContextID:   "ctx_20250223_001",
        ModelID:     "gpt-4",
        Prompt:      "糖尿病的正常血糖范围是多少？",
        ContextType: mcp.ContextTypeWisunit,
        MaxTokens:   500,
        Temperature: 0.5,
    })

    if err != nil {
        panic(err)
    }

    // 处理响应
    if response.Status == "success" {
        fmt.Printf("AI响应: %s\n", response.Response)
        fmt.Printf("使用的Token数: %d\n", response.TokensUsed)
    }
}
```

---

## 11.2 Skill调用协议

### 协议名称
Skill Invocation Protocol

### 协议描述
定义Skill（技能）的调用协议，支持通过Skill ID调用特定的AI能力。

### 协议版本
v1.0.0

### 接口定义

```python
from typing import Dict, Any, Optional
from pydantic import BaseModel

class SkillInvokeRequest(BaseModel):
    """Skill调用请求"""
    skill_id: str
    skill_version: Optional[str] = None
    inputs: Dict[str, Any]
    timeout: int = 30
    async: bool = False

class SkillInvokeResponse(BaseModel):
    """Skill调用响应"""
    status: str  # success, pending, error
    task_id: Optional[str] = None
    outputs: Optional[Dict[str, Any]] = None
    execution_time: Optional[float] = None
    message: Optional[str] = None
    error: Optional[Dict[str, Any]] = None

class GetTaskRequest(BaseModel):
    """获取任务请求"""
    task_id: str

class GetTaskResponse(BaseModel):
    """获取任务响应"""
    status: str  # success, pending, error
    outputs: Optional[Dict[str, Any]] = None
    execution_time: Optional[float] = None
    message: Optional[str] = None
    error: Optional[Dict[str, Any]] = None
```

### JSON Schema (请求)

```json
{
  "SkillInvokeRequest": {
    "type": "object",
    "required": ["skill_id", "inputs"],
    "properties": {
      "skill_id": {"type": "string"},
      "skill_version": {"type": "string"},
      "inputs": {"type": "object"},
      "timeout": {"type": "integer", "default": 30},
      "async": {"type": "boolean", "default": false}
    }
  }
}
```

### JSON Schema (响应)

```json
{
  "SkillInvokeResponse": {
    "type": "object",
    "properties": {
      "status": {"type": "string", "enum": ["success", "pending", "error"]},
      "task_id": {"type": "string"},
      "outputs": {"type": "object"},
      "execution_time": {"type": "number"},
      "message": {"type": "string"},
      "error": {"type": "object"}
    }
  }
}
```

### 错误码定义

| 错误码 | 描述 | HTTP状态码 |
|--------|------|-----------|
| `SKILL_001` | Skill不存在 | 404 |
| `SKILL_002` | Skill执行失败 | 500 |
| `SKILL_003` | 输入参数无效 | 400 |
| `SKILL_004` | 超时 | 504 |
| `SKILL_999` | 未知错误 | 500 |

### Python SDK示例

```python
from wishub_sdk import SkillClient

# 初始化Skill客户端
skill_client = SkillClient(api_key="your_api_key", base_url="https://api.wishub.com")

# 同步调用Skill
response = await skill_client.invoke(
    skill_id="skill_medical_diagnosis",
    inputs={
        "symptoms": ["口渴", "多尿", "疲乏"],
        "patient_age": 45
    },
    timeout=30
)

# 处理响应
if response.status == "success":
    print(f"诊断结果: {response.outputs}")
    print(f"执行时间: {response.execution_time}ms")
else:
    print(f"错误: {response.message}")

# 异步调用Skill
response = await skill_client.invoke(
    skill_id="skill_medical_diagnosis",
    inputs={...},
    async=True
)

if response.status == "pending":
    print(f"任务ID: {response.task_id}")
    # 轮询任务状态
    result = await skill_client.get_task(response.task_id)
```

---

## 11.3 Skill注册协议

### 协议名称
Skill Registration Protocol

### 协议描述
定义Skill的注册协议，支持开发者上传和管理自定义Skill。

### 协议版本
v1.0.0

### 接口定义

```python
from typing import Dict, Any, Optional, List
from pydantic import BaseModel
from datetime import datetime

class SkillLanguage(str, enum.Enum):
    PYTHON = "python"
    TYPESCRIPT = "typescript"
    GO = "go"
    JAVA = "java"
    RUST = "rust"

class SkillRegistrationRequest(BaseModel):
    """Skill注册请求"""
    skill_id: str
    skill_name: str
    description: Optional[str] = None
    version: str  # SemVer格式
    language: SkillLanguage
    code: str  # Base64编码或URL
    dependencies: Optional[List[str]] = None
    input_schema: Optional[Dict[str, Any]] = None
    output_schema: Optional[Dict[str, Any]] = None
    timeout: int = 30
    author: Optional[str] = None
    license: Optional[str] = None

class SkillRegistrationResponse(BaseModel):
    """Skill注册响应"""
    status: str
    skill_id: Optional[str] = None
    version: Optional[str] = None
    registration_time: Optional[datetime] = None
    message: Optional[str] = None
    error: Optional[Dict[str, Any]] = None

class UpdateSkillRequest(BaseModel):
    """更新Skill请求"""
    skill_id: str
    version: str
    code: Optional[str] = None
    input_schema: Optional[Dict[str, Any]] = None
    output_schema: Optional[Dict[str, Any]] = None
    timeout: Optional[int] = None

class DeleteSkillRequest(BaseModel):
    """删除Skill请求"""
    skill_id: str
```

### JSON Schema (请求)

```json
{
  "SkillRegistrationRequest": {
    "type": "object",
    "required": ["skill_id", "skill_name", "version", "code", "language"],
    "properties": {
      "skill_id": {"type": "string"},
      "skill_name": {"type": "string"},
      "description": {"type": "string"},
      "version": {"type": "string", "pattern": "^[0-9]+\\.[0-9]+\\.[0-9]+$"},
      "language": {"type": "string", "enum": ["python", "typescript", "go", "java", "rust"]},
      "code": {"type": "string"},
      "dependencies": {"type": "array", "items": {"type": "string"}},
      "input_schema": {"type": "object"},
      "output_schema": {"type": "object"},
      "timeout": {"type": "integer", "default": 30},
      "author": {"type": "string"},
      "license": {"type": "string"}
    }
  }
}
```

### JSON Schema (响应)

```json
{
  "SkillRegistrationResponse": {
    "type": "object",
    "properties": {
      "status": {"type": "string", "enum": ["success", "error"]},
      "skill_id": {"type": "string"},
      "version": {"type": "string"},
      "registration_time": {"type": "string"},
      "message": {"type": "string"},
      "error": {"type": "object"}
    }
  }
}
```

### 错误码定义

| 错误码 | 描述 | HTTP状态码 |
|--------|------|-----------|
| `SKILL_REG_001` | Skill已存在 | 409 |
| `SKILL_REG_002` | Skill不存在 | 404 |
| `SKILL_REG_003` | 版本格式错误 | 400 |
| `SKILL_REG_004` | 语言不支持 | 400 |
| `SKILL_REG_999` | 未知错误 | 500 |

### Python SDK示例

```python
from wishub_sdk import SkillRegistry

# 初始化Skill注册客户端
registry = SkillRegistry(api_key="your_api_key", base_url="https://api.wishub.com")

# 注册Skill
response = await registry.register(
    skill_id="skill_medical_diagnosis",
    skill_name="医学诊断技能",
    description="基于症状的糖尿病诊断",
    version="1.0.0",
    language=SkillLanguage.PYTHON,
    code="#!/usr/bin/env python3\nimport sys\n\ndef diagnose(symptoms, patient_age):\n    # 诊断逻辑\n    return {\"diagnosis\": \"糖尿病\", \"confidence\": 0.85}\n\nif __name__ == \"__main__\":\n    symptoms = sys.argv[1].split(',')\n    patient_age = int(sys.argv[2])\n    result = diagnose(symptoms, patient_age)\n    print(result)",
    input_schema={
        "type": "object",
        "properties": {
            "symptoms": {"type": "array", "items": {"type": "string"}},
            "patient_age": {"type": "integer"}
        },
        "required": ["symptoms", "patient_age"]
    },
    output_schema={
        "type": "object",
        "properties": {
            "diagnosis": {"type": "string"},
            "confidence": {"type": "number"}
        }
    },
    timeout=30,
    author="Dr. Wang",
    license="MIT"
)

# 处理响应
if response.status == "success":
    print(f"Skill注册成功: {response.skill_id}")
    print(f"注册时间: {response.registration_time}")
else:
    print(f"错误: {response.message}")
```

---

## 11.4 Skill发现协议

### 协议名称
Skill Discovery Protocol

### 协议描述
定义Skill的发现协议，支持查询和搜索可用的Skill。

### 协议版本
v1.0.0

### 接口定义

```python
from typing import Dict, Any, Optional, List
from pydantic import BaseModel

class SkillDiscoveryRequest(BaseModel):
    """Skill发现请求"""
    query: Optional[str] = None
    category: Optional[str] = None
    language: Optional[str] = None
    author: Optional[str] = None
    limit: int = 20
    offset: int = 0

class SkillInfo(BaseModel):
    """Skill信息"""
    skill_id: str
    skill_name: str
    description: Optional[str] = None
    version: str
    category: Optional[str] = None
    language: str
    author: Optional[str] = None
    downloads: int = 0
    rating: float = 0.0

class SkillDiscoveryResponse(BaseModel):
    """Skill发现响应"""
    status: str
    skills: Optional[List[SkillInfo]] = None
    total: Optional[int] = None
    message: Optional[str] = None
    error: Optional[Dict[str, Any]] = None
```

### JSON Schema (请求)

```json
{
  "SkillDiscoveryRequest": {
    "type": "object",
    "properties": {
      "query": {"type": "string"},
      "category": {"type": "string"},
      "language": {"type": "string"},
      "author": {"type": "string"},
      "limit": {"type": "integer", "default": 20},
      "offset": {"type": "integer", "default": 0}
    }
  }
}
```

### JSON Schema (响应)

```json
{
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
            "language": {"type": "string"},
            "author": {"type": "string"},
            "downloads": {"type": "integer"},
            "rating": {"type": "number"}
          }
        }
      },
      "total": {"type": "integer"},
      "message": {"type": "string"},
      "error": {"type": "object"}
    }
  }
}
```

### Python SDK示例

```python
from wishub_sdk import SkillDiscovery

# 初始化Skill发现客户端
discovery = SkillDiscovery(api_key="your_api_key", base_url="https://api.wishub.com")

# 搜索Skill
response = await discovery.search(
    query="糖尿病",
    category="medical",
    limit=10
)

# 处理响应
if response.status == "success":
    print(f"找到{response.total}个Skill:")
    for skill in response.skills:
        print(f"- {skill.skill_name} ({skill.skill_id})")
        print(f"  描述: {skill.description}")
        print(f"  作者: {skill.author}")
        print(f"  评分: {skill.rating}")
```

---

## 11.5 Skill编排协议

### 协议名称
Skill Orchestration Protocol

### 协议描述
定义Skill的编排协议，支持多个Skill的组合调用和工作流定义。

### 协议版本
v1.0.0

### 接口定义

```python
from typing import Dict, Any, Optional, List
from pydantic import BaseModel
from datetime import datetime
from enum import Enum

class ExecutionMode(str, Enum):
    SEQUENTIAL = "sequential"
    PARALLEL = "parallel"
    HYBRID = "hybrid"

class WorkflowStep(BaseModel):
    """工作流步骤"""
    step_id: str
    skill_id: str
    inputs: Dict[str, Any]
    depends_on: Optional[List[str]] = None

class WorkflowDefinition(BaseModel):
    """工作流定义"""
    name: str
    description: Optional[str] = None
    steps: List[WorkflowStep]

class SkillOrchestrationRequest(BaseModel):
    """Skill编排请求"""
    workflow_id: str
    workflow: WorkflowDefinition
    execution_mode: ExecutionMode = ExecutionMode.SEQUENTIAL
    timeout: int = 300

class SkillOrchestrationResponse(BaseModel):
    """Skill编排响应"""
    status: str  # success, running, error
    execution_id: Optional[str] = None
    results: Optional[Dict[str, Any]] = None
    execution_time: Optional[float] = None
    message: Optional[str] = None
    error: Optional[Dict[str, Any]] = None

class GetExecutionRequest(BaseModel):
    """获取执行请求"""
    execution_id: str

class CancelExecutionRequest(BaseModel):
    """取消执行请求"""
    execution_id: str
```

### JSON Schema (请求)

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
      "execution_mode": {"type": "string", "enum": ["sequential", "parallel", "hybrid"], "default": "sequential"},
      "timeout": {"type": "integer", "default": 300}
    }
  }
}
```

### JSON Schema (响应)

```json
{
  "SkillOrchestrationResponse": {
    "type": "object",
    "properties": {
      "status": {"type": "string", "enum": ["success", "running", "error"]},
      "execution_id": {"type": "string"},
      "results": {"type": "object"},
      "execution_time": {"type": "number"},
      "message": {"type": "string"},
      "error": {"type": "object"}
    }
  }
}
```

### 错误码定义

| 错误码 | 描述 | HTTP状态码 |
|--------|------|-----------|
| `WORKFLOW_001` | 工作流定义无效 | 400 |
| `WORKFLOW_002` | 依赖循环 | 400 |
| `WORKFLOW_003` | 执行失败 | 500 |
| `WORKFLOW_004` | 执行不存在 | 404 |
| `WORKFLOW_005` | 超时 | 504 |
| `WORKFLOW_999` | 未知错误 | 500 |

### Python SDK示例

```python
from wishub_sdk import SkillOrchestrator

# 初始化Skill编排客户端
orchestrator = SkillOrchestrator(api_key="your_api_key", base_url="https://api.wishub.com")

# 定义工作流
workflow = WorkflowDefinition(
    name="医学诊断工作流",
    description="先获取症状，再诊断，最后给出建议",
    steps=[
        WorkflowStep(
            step_id="step_1",
            skill_id="skill_symptom_extractor",
            inputs={"text": "患者感到口渴、多尿、疲乏"}
        ),
        WorkflowStep(
            step_id="step_2",
            skill_id="skill_medical_diagnosis",
            depends_on=["step_1"],
            inputs={
                "symptoms": "{{step_1.symptoms}}",
                "patient_age": 45
            }
        ),
        WorkflowStep(
            step_id="step_3",
            skill_id="skill_treatment_recommendation",
            depends_on=["step_2"],
            inputs={"diagnosis": "{{step_2.diagnosis}}"}
        )
    ]
)

# 执行工作流（顺序执行）
response = await orchestrator.execute(
    workflow_id="wf_medical_diagnosis_001",
    workflow=workflow,
    execution_mode=ExecutionMode.SEQUENTIAL,
    timeout=300
)

# 处理响应
if response.status == "success":
    print(f"工作流执行完成: {response.execution_id}")
    print(f"执行时间: {response.execution_time}ms")
    print(f"各步骤结果:")
    for step_id, result in response.results.items():
        print(f"  {step_id}: {result}")
```

---

- **部署协议**: 3个

### 协议分类

| 类别 | 协议数 | 说明 |
|------|--------|------|
| **WisUnit协议** | 4个 | 数据模型、CRUD、验证、迁移 |
| **WISE协议系统** | 6个 | 存储、同步、验证、激励、去重、缓存 |
| **智核协议** | 4个 | 生成、进化、验证、Agent反馈 |
| **Agent协议** | 5个 | 注册、调用、类型、调度、激励 |
| **知识图谱协议** | 2个 | 图数据库接口、知识关联 |
| **通信协议** | 3个 | REST API、WebSocket、gRPC |
| **安全协议** | 4个 | 认证、加密、权限、零知识证明 |
| **领域扩展协议** | 1个 | 通用领域扩展（含4个子协议）|
| **经济模型协议** | 3个 | 信用、赏金、汇率 |
| **部署协议** | 3个 | 配置、监控、备份 |
| **MCP/Skill协议** | 5个 | **新增** |

---

| `WORKFLOW_003` | 执行失败 | 500 |
| `WORKFLOW_004` | 执行不存在 | 404 |
| `WORKFLOW_005` | 超时 | 504 |

---

**文档版本**: v3.0
**最后更新**: 2026年2月23日
**协议总数**: 37个
**标准格式**: JSON
**SDK支持**: 8种语言

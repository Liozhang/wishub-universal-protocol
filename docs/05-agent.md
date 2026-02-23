# 4. Agent协议

## 4.1 Agent注册协议

### 协议名称
Agent Registration Protocol

### 协议描述
定义Agent的注册协议，包括Agent类型、能力声明、生命周期管理。

### 协议版本
v3.0.0

### 协议变更
- 支持插件化的Agent类型
- 支持领域特定的能力声明

### 接口定义

```python
class AgentType(str, Enum):
    GENERIC = "generic"  # 通用Agent
    DOMAIN = "domain"  # 领域Agent
    PLUGIN = "plugin"  # 插件Agent

class RegisterAgentRequest(BaseModel):
    """注册Agent请求"""
    agent_id: str
    name: str
    type: AgentType
    capabilities: List[str] = []
    plugin_id: Optional[str] = None
    config: Dict[str, Any] = {}

class AgentRegistrationResponse(BaseModel):
    """Agent注册响应"""
    status: str
    data: Optional[Dict[str, Any]] = None
    message: Optional[str] = None
    error: Optional[Dict[str, Any]] = None
```

### 错误码定义

| 错误码 | 描述 | HTTP状态码 |
|--------|------|-----------|
| `AG_REG_001` | Agent已存在 | 409 |
| `AG_REG_002` | 注册失败 | 500 |
| `AG_REG_003` | 插件不存在 | 404 |
| `AG_REG_999` | 未知错误 | 500 |

---

## 4.2 Agent调用协议

### 协议名称
Agent Invocation Protocol

### 协议描述
定义Agent的调用协议，包括同步调用、异步调用、批量调用。

### 协议版本
v3.0.0

### 协议变更
- 支持插件化的调用策略
- 支持领域特定的调用参数

### 接口定义

```python
class InvocationMode(str, Enum):
    SYNC = "sync"  # 同步调用
    ASYNC = "async"  # 异步调用
    STREAM = "stream"  # 流式调用

class InvokeAgentRequest(BaseModel):
    """调用Agent请求"""
    agent_id: str
    mode: InvocationMode = InvocationMode.SYNC
    task_data: Dict[str, Any]
    timeout_seconds: Optional[int] = None
    plugin_id: Optional[str] = None

class AgentInvocationResponse(BaseModel):
    """Agent调用响应"""
    status: str
    data: Optional[Dict[str, Any]] = None
    message: Optional[str] = None
    error: Optional[Dict[str, Any]] = None
```

### 错误码定义

| 错误码 | 描述 | HTTP状态码 |
|--------|------|-----------|
| `AG_INV_001` | Agent不存在 | 404 |
| `AG_INV_002` | 调用失败 | 500 |
| `AG_INV_003` | 超时 | 504 |
| `AG_INV_004` | 插件不存在 | 404 |
| `AG_INV_999` | 未知错误 | 500 |

---

## 4.3 Agent类型协议

### 协议名称
Agent Type Protocol

### 协议描述
定义Agent类型的协议，包括类型定义、能力描述、兼容性检查。

### 协议版本
v3.0.0

### 协议变更
- 支持插件化的Agent类型
- 支持领域特定的类型定义

### 接口定义

```python
class DefineAgentTypeRequest(BaseModel):
    """定义Agent类型请求"""
    type_id: str
    name: str
    description: str
    capabilities: List[str] = []
    plugin_id: Optional[str] = None

class AgentTypeResponse(BaseModel):
    """Agent类型响应"""
    status: str
    data: Optional[Dict[str, Any]] = None
    message: Optional[str] = None
    error: Optional[Dict[str, Any]] = None
```

### 错误码定义

| 错误码 | 描述 | HTTP状态码 |
|--------|------|-----------|
| `AG_TYPE_001` | 类型已存在 | 409 |
| `AG_TYPE_002` | 定义失败 | 500 |
| `AG_TYPE_003` | 插件不存在 | 404 |
| `AG_TYPE_999` | 未知错误 | 500 |

---

## 4.4 Agent调度协议

### 协议名称
Agent Scheduling Protocol

### 协议描述
定义Agent的调度协议，包括任务队列管理、资源分配、负载均衡。

### 协议版本
v3.0.0

### 协议变更
- 支持插件化的调度策略
- 支持领域特定的调度规则

### 接口定义

```python
class TaskPriority(str, Enum):
    CRITICAL = "critical"  # 关键
    HIGH = "high"  # 高
    MEDIUM = "medium"  # 中
    LOW = "low"  # 低

class ScheduleTaskRequest(BaseModel):
    """调度任务请求"""
    task_id: str
    agent_type: str
    task_data: Dict[str, Any]
    priority: TaskPriority = TaskPriority.MEDIUM
    timeout_seconds: Optional[int] = None
    retry_on_failure: bool = True
    max_retries: int = 3
    plugin_id: Optional[str] = None

class AgentSchedulingResponse(BaseModel):
    """Agent调度响应"""
    status: str
    data: Optional[Dict[str, Any]] = None
    message: Optional[str] = None
    error: Optional[Dict[str, Any]] = None
```

### 错误码定义

| 错误码 | 描述 | HTTP状态码 |
|--------|------|-----------|
| `AG_SCH_001` | 任务不存在 | 404 |
| `AG_SCH_002` | Agent类型不支持 | 400 |
| `AG_SCH_003` | Agent池已满 | 503 |
| `AG_SCH_004` | 任务调度失败 | 500 |
| `AG_SCH_005` | 插件不存在 | 404 |
| `AG_SCH_999` | 未知错误 | 500 |

---

## 4.5 Agent质量激励协议

### 协议名称
Agent Quality Incentive Protocol

### 协议描述
定义Agent质量激励的协议，包括质量评估、奖励发放、排名系统。

### 协议版本
v3.0.0

### 协议变更
- 支持插件化的质量评估规则
- 支持领域特定的激励策略

### 接口定义

```python
class QualityMetric(str, Enum):
    SUCCESS_RATE = "success_rate"  # 成功率
    RESPONSE_TIME = "response_time"  # 响应时间
    ACCURACY = "accuracy"  # 准确率
    PLUGIN = "plugin"  # 插件指标

class EvaluateAgentQualityRequest(BaseModel):
    """评估Agent质量请求"""
    agent_id: str
    metrics: List[QualityMetric] = [QualityMetric.SUCCESS_RATE]
    plugin_id: Optional[str] = None

class AgentQualityResponse(BaseModel):
    """Agent质量响应"""
    status: str
    data: Optional[Dict[str, Any]] = None
    message: Optional[str] = None
    error: Optional[Dict[str, Any]] = None
```

### 错误码定义

| 错误码 | 描述 | HTTP状态码 |
|--------|------|-----------|
| `AG_QUAL_001` | Agent不存在 | 404 |
| `AG_QUAL_002` | 评估失败 | 500 |
| `AG_QUAL_003` | 插件不存在 | 404 |
| `AG_QUAL_999` | 未知错误 | 500 |

---


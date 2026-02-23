# 3. 智核协议

## 3.1 智核生成协议

### 协议名称
Wisdom Core Generation Protocol

### 协议描述
定义智核的生成协议，包括生成策略、质量评估、版本管理。

### 协议版本
v3.0.0

### 协议变更
- 支持插件化的生成策略
- 支持领域特定的质量评估规则

### 接口定义

```python
class GenerationStrategy(str, Enum):
    AI_GENERATED = "ai_generated"  # AI生成
    MANUAL = "manual"  # 手动创建
    HYBRID = "hybrid"  # 混合生成
    PLUGIN = "plugin"  # 插件生成

class GenerateWisdomCoreRequest(BaseModel):
    """生成智核请求"""
    title: str
    description: str
    strategy: GenerationStrategy = GenerationStrategy.AI_GENERATED
    plugin_id: Optional[str] = None
    config: Dict[str, Any] = {}

class WisdomCoreGenerationResponse(BaseModel):
    """智核生成响应"""
    status: str
    data: Optional[Dict[str, Any]] = None
    message: Optional[str] = None
    error: Optional[Dict[str, Any]] = None
```

### 错误码定义

| 错误码 | 描述 | HTTP状态码 |
|--------|------|-----------|
| `WC_GEN_001` | 生成失败 | 500 |
| `WC_GEN_002` | 质量评估失败 | 500 |
| `WC_GEN_003` | 插件不存在 | 404 |
| `WC_GEN_999` | 未知错误 | 500 |

---

## 3.2 智核进化协议

### 协议名称
Wisdom Core Evolution Protocol

### 协议描述
定义智核的进化协议，包括进化策略、触发条件、版本管理。

### 协议版本
v3.0.0

### 协议变更
- 支持插件化的进化策略
- 支持领域特定的进化触发条件

### 接口定义

```python
class EvolutionStrategy(str, Enum):
    AUTOMATIC = "automatic"  # 自动进化
    MANUAL = "manual"  # 手动进化
    SCHEDULED = "scheduled"  # 定时进化
    PLUGIN = "plugin"  # 插件进化

class TriggerEvolutionRequest(BaseModel):
    """触发进化请求"""
    wisdom_core_id: str
    strategy: EvolutionStrategy = EvolutionStrategy.AUTOMATIC
    plugin_id: Optional[str] = None
    reason: Optional[str] = None

class WisdomCoreEvolutionResponse(BaseModel):
    """智核进化响应"""
    status: str
    evolution_id: Optional[str] = None
    data: Optional[Dict[str, Any]] = None
    message: Optional[str] = None
    error: Optional[Dict[str, Any]] = None
```

### 错误码定义

| 错误码 | 描述 | HTTP状态码 |
|--------|------|-----------|
| `WC_EVL_001` | 智核不存在 | 404 |
| `WC_EVL_002` | 进化失败 | 500 |
| `WC_EVL_003` | 插件不存在 | 404 |
| `WC_EVL_999` | 未知错误 | 500 |

---

## 3.3 智核验证协议

### 协议名称
Wisdom Core Verification Protocol

### 协议描述
定义智核的验证协议，包括质量评估、一致性检查、性能评估。

### 协议版本
v3.0.0

### 协议变更
- 支持插件化的验证规则
- 支持领域特定的质量评估标准

### 接口定义

```python
class VerificationType(str, Enum):
    QUALITY = "quality"  # 质量验证
    CONSISTENCY = "consistency"  # 一致性验证
    PERFORMANCE = "performance"  # 性能验证
    PLUGIN = "plugin"  # 插件验证

class VerifyWisdomCoreRequest(BaseModel):
    """验证智核请求"""
    wisdom_core_id: str
    verification_types: List[VerificationType] = [VerificationType.QUALITY]
    plugin_id: Optional[str] = None

class WisdomCoreVerificationResponse(BaseModel):
    """智核验证响应"""
    status: str
    valid: bool
    details: Optional[Dict[str, Any]] = None
    message: Optional[str] = None
    error: Optional[Dict[str, Any]] = None
```

### 错误码定义

| 错误码 | 描述 | HTTP状态码 |
|--------|------|-----------|
| `WC_VER_001` | 智核不存在 | 404 |
| `WC_VER_002` | 验证失败 | 400 |
| `WC_VER_003` | 插件不存在 | 404 |
| `WC_VER_999` | 未知错误 | 500 |

---

## 3.4 智核Agent反馈进化协议

### 协议名称
Wisdom Core Agent Feedback Evolution Protocol

### 协议描述
定义智核基于Agent反馈的进化协议，支持Agent调用数据收集、反馈评分、自动触发进化。

### 协议版本
v3.0.0

### 协议变更
- 支持插件化的反馈规则
- 支持领域特定的反馈评分标准

### 接口定义

```python
class FeedbackScore(str, Enum):
    EXCELLENT = "excellent"  # 优秀（5分）
    GOOD = "good"  # 良好（4分）
    SATISFACTORY = "satisfactory"  # 满意（3分）
    POOR = "poor"  # 较差（2分）
    VERY_POOR = "very_poor"  # 很差（1分）

class RecordAgentCallRequest(BaseModel):
    """记录Agent调用请求"""
    wisdom_core_id: str
    agent_id: str
    call_success: bool
    execution_time_ms: int
    feedback_score: Optional[FeedbackScore] = None
    feedback_comment: Optional[str] = None
    plugin_id: Optional[str] = None

class WisdomCoreEvolutionResponse(BaseModel):
    """智核进化响应"""
    status: str
    evolution_id: Optional[str] = None
    data: Optional[Dict[str, Any]] = None
    message: Optional[str] = None
    error: Optional[Dict[str, Any]] = None
```

### 错误码定义

| 错误码 | 描述 | HTTP状态码 |
|--------|------|-----------|
| `WC_FB_001` | 智核不存在 | 404 |
| `WC_FB_002` | Agent不存在 | 404 |
| `WC_FB_003` | 进化触发条件不满足 | 400 |
| `WC_FB_004` | 进化失败 | 500 |
| `WC_FB_005` | 插件不存在 | 404 |
| `WC_FB_999` | 未知错误 | 500 |

---


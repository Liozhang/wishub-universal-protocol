# 9. 经济模型协议

## 9.1 信用协议

### 协议名称
Credit Protocol

### 协议描述
定义用户信用的协议，包括信用评估、信用等级、信用历史。

### 协议版本
v3.0.0

### 协议变更
- 支持插件化的信用评估规则
- 支持领域特定的信用策略

### 接口定义

```python
class CreditLevel(str, Enum):
    EXCELLENT = "excellent"  # 优秀
    GOOD = "good"  # 良好
    AVERAGE = "average"  # 一般
    POOR = "poor"  # 较差
    VERY_POOR = "very_poor"  # 很差

class EvaluateCreditRequest(BaseModel):
    """评估信用请求"""
    user_id: str
    plugin_id: Optional[str] = None

class UpdateCreditRequest(BaseModel):
    """更新信用请求"""
    user_id: str
    delta: float  # 信用变化值
    reason: Optional[str] = None

class CreditResponse(BaseModel):
    """信用响应"""
    status: str
    data: Optional[Dict[str, Any]] = None
    message: Optional[str] = None
    error: Optional[Dict[str, Any]] = None
```

### 错误码定义

| 错误码 | 描述 | HTTP状态码 |
|--------|------|-----------|
| `CRED_001` | 用户不存在 | 404 |
| `CRED_002` | 信用评估失败 | 500 |
| `CRED_003` | 插件不存在 | 404 |
| `CRED_999` | 未知错误 | 500 |

---

## 9.2 赏金协议

### 协议名称
Bounty Protocol

### 协议描述
定义赏金任务的协议，包括任务发布、任务完成、赏金发放。

### 协议版本
v3.0.0

### 协议变更
- 支持插件化的赏金规则
- 支持领域特定的赏金策略

### 接口定义

```python
class BountyStatus(str, Enum):
    OPEN = "open"  # 开放
    ASSIGNED = "assigned"  # 已分配
    COMPLETED = "completed"  # 已完成
    CANCELLED = "cancelled"  # 已取消

class CreateBountyRequest(BaseModel):
    """创建赏金请求"""
    bounty_id: str
    title: str
    description: str
    reward: float
    deadline: Optional[datetime] = None
    plugin_id: Optional[str] = None

class ClaimBountyRequest(BaseModel):
    """认领赏金请求"""
    bounty_id: str
    user_id: str

class BountyResponse(BaseModel):
    """赏金响应"""
    status: str
    data: Optional[Dict[str, Any]] = None
    message: Optional[str] = None
    error: Optional[Dict[str, Any]] = None
```

### 错误码定义

| 错误码 | 描述 | HTTP状态码 |
|--------|------|-----------|
| `BOU_001` | 赏金任务不存在 | 404 |
| `BOU_002` | 赏金已被认领 | 409 |
| `BOU_003` | 插件不存在 | 404 |
| `BOU_004` | 余额不足 | 402 |
| `BOU_999` | 未知错误 | 500 |

---

## 9.3 汇率协议

### 协议名称
Exchange Rate Protocol

### 协议描述
定义汇率换算的协议，包括汇率查询、汇率更新、货币换算。

### 协议版本
v3.0.0

### 协议变更
- 支持插件化的汇率规则
- 支持领域特定的汇率策略

### 接口定义

```python
class GetExchangeRateRequest(BaseModel):
    """获取汇率请求"""
    from_currency: str
    to_currency: str
    plugin_id: Optional[str] = None

class ConvertCurrencyRequest(BaseModel):
    """换算货币请求"""
    amount: float
    from_currency: str
    to_currency: str
    plugin_id: Optional[str] = None

class ExchangeRateResponse(BaseModel):
    """汇率响应"""
    status: str
    data: Optional[Dict[str, Any]] = None
    message: Optional[str] = None
    error: Optional[Dict[str, Any]] = None
```

### 错误码定义

| 错误码 | 描述 | HTTP状态码 |
|--------|------|-----------|
| `EXCH_001` | 货币不支持 | 400 |
| `EXCH_002` | 汇率查询失败 | 500 |
| `EXCH_003` | 插件不存在 | 404 |
| `EXCH_999` | 未知错误 | 500 |

---


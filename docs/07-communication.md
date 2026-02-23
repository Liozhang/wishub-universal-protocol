# 6. 通信协议

## 6.1 REST API协议

### 协议名称
REST API Protocol

### 协议描述
定义REST API的协议，包括请求格式、响应格式、错误处理。

### 协议版本
v3.0.0

### 协议变更
- 无重大变更，保持通用性

### 接口定义

```python
class HTTPMethod(str, Enum):
    GET = "GET"
    POST = "POST"
    PUT = "PUT"
    DELETE = "DELETE"
    PATCH = "PATCH"

class RESTRequest(BaseModel):
    """REST请求"""
    method: HTTPMethod
    path: str
    headers: Dict[str, str] = {}
    query_params: Dict[str, Any] = {}
    body: Optional[Dict[str, Any]] = None

class RESTResponse(BaseModel):
    """REST响应"""
    status: str
    status_code: int
    data: Optional[Dict[str, Any]] = None
    message: Optional[str] = None
    error: Optional[Dict[str, Any]] = None
```

### 错误码定义

| 错误码 | 描述 | HTTP状态码 |
|--------|------|-----------|
| `REST_001` | 请求无效 | 400 |
| `REST_002` | 未授权 | 401 |
| `REST_003` | 禁止访问 | 403 |
| `REST_004` | 资源不存在 | 404 |
| `REST_005` | 服务器错误 | 500 |
| `REST_999` | 未知错误 | 500 |

---

## 6.2 WebSocket协议

### 协议名称
WebSocket Protocol

### 协议描述
定义WebSocket的协议，包括连接管理、消息格式、事件处理。

### 协议版本
v3.0.0

### 协议变更
- 无重大变更，保持通用性

### 接口定义

```python
class WebSocketMessageType(str, Enum):
    REQUEST = "request"  # 请求消息
    RESPONSE = "response"  # 响应消息
    NOTIFICATION = "notification"  # 通知消息
    ERROR = "error"  # 错误消息

class WebSocketMessage(BaseModel):
    """WebSocket消息"""
    message_id: str
    type: WebSocketMessageType
    topic: Optional[str] = None
    payload: Optional[Dict[str, Any]] = None
    timestamp: datetime

class WebSocketResponse(BaseModel):
    """WebSocket响应"""
    status: str
    data: Optional[Dict[str, Any]] = None
    message: Optional[str] = None
    error: Optional[Dict[str, Any]] = None
```

### 错误码定义

| 错误码 | 描述 | HTTP状态码 |
|--------|------|-----------|
| `WS_001` | 连接失败 | 1011 |
| `WS_002` | 消息格式错误 | 1003 |
| `WS_003` | 未授权 | 1008 |
| `WS_999` | 未知错误 | 1011 |

---

## 6.3 gRPC协议

### 协议名称
gRPC Protocol

### 协议描述
定义gRPC的协议，包括服务定义、消息格式、流式处理。

### 协议版本
v3.0.0

### 协议变更
- 无重大变更，保持通用性

### 接口定义

```python
class gRPCRequest(BaseModel):
    """gRPC请求"""
    service: str
    method: str
    request_data: Dict[str, Any] = {}
    metadata: Dict[str, str] = {}

class gRPCResponse(BaseModel):
    """gRPC响应"""
    status: str
    response_data: Optional[Dict[str, Any]] = None
    message: Optional[str] = None
    error: Optional[Dict[str, Any]] = None
```

### 错误码定义

| 错误码 | 描述 | gRPC状态码 |
|--------|------|-----------|
| `GRPC_001` | 请求无效 | 3 |
| `GRPC_002` | 未授权 | 16 |
| `GRPC_003` | 资源不存在 | 5 |
| `GRPC_004` | 服务器错误 | 13 |
| `GRPC_999` | 未知错误 | 2 |

---


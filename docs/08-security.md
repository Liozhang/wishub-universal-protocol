# 7. 安全协议

## 7.1 认证协议

### 协议名称
Authentication Protocol

### 协议描述
定义用户认证的协议，支持多种认证方式（JWT、OAuth2、API Key）。

### 协议版本
v3.0.0

### 协议变更
- 支持插件化的认证方式
- 移除硬编码的合规要求

### 接口定义

```python
class AuthMethod(str, Enum):
    JWT = "jwt"  # JWT认证
    OAUTH2 = "oauth2"  # OAuth2认证
    API_KEY = "api_key"  # API Key认证
    PLUGIN = "plugin"  # 插件认证

class AuthRequest(BaseModel):
    """认证请求"""
    method: AuthMethod
    credentials: Dict[str, Any]
    plugin_id: Optional[str] = None

class AuthResponse(BaseModel):
    """认证响应"""
    status: str
    token: Optional[str] = None
    expires_at: Optional[datetime] = None
    message: Optional[str] = None
    error: Optional[Dict[str, Any]] = None
```

### 错误码定义

| 错误码 | 描述 | HTTP状态码 |
|--------|------|-----------|
| `AUTH_001` | 认证失败 | 401 |
| `AUTH_002` | 凭证无效 | 401 |
| `AUTH_003` | 插件不存在 | 404 |
| `AUTH_999` | 未知错误 | 500 |

---

## 7.2 加密协议

### 协议名称
Encryption Protocol

### 协议描述
定义数据加密的协议，包括对称加密、非对称加密、混合加密。

### 协议版本
v3.0.0

### 协议变更
- 支持插件化的加密算法
- 支持领域特定的加密策略

### 接口定义

```python
class EncryptionAlgorithm(str, Enum):
    AES256 = "aes256"  # AES-256
    RSA = "rsa"  # RSA
    HYBRID = "hybrid"  # 混合加密
    PLUGIN = "plugin"  # 插件加密

class EncryptRequest(BaseModel):
    """加密请求"""
    data: Dict[str, Any]
    algorithm: EncryptionAlgorithm = EncryptionAlgorithm.AES256
    plugin_id: Optional[str] = None

class DecryptRequest(BaseModel):
    """解密请求"""
    encrypted_data: str
    algorithm: EncryptionAlgorithm = EncryptionAlgorithm.AES256
    plugin_id: Optional[str] = None

class EncryptionResponse(BaseModel):
    """加密响应"""
    status: str
    data: Optional[Dict[str, Any]] = None
    encrypted_data: Optional[str] = None
    message: Optional[str] = None
    error: Optional[Dict[str, Any]] = None
```

### 错误码定义

| 错误码 | 描述 | HTTP状态码 |
|--------|------|-----------|
| `ENC_001` | 加密失败 | 500 |
| `ENC_002` | 解密失败 | 500 |
| `ENC_003` | 插件不存在 | 404 |
| `ENC_999` | 未知错误 | 500 |

---

## 7.3 权限协议

### 协议名称
Authorization Protocol

### 协议描述
定义权限管理的协议，包括角色定义、权限检查、访问控制。

### 协议版本
v3.0.0

### 协议变更
- 支持插件化的权限规则
- 支持领域特定的权限策略

### 接口定义

```python
class PermissionType(str, Enum):
    READ = "read"  # 读权限
    WRITE = "write"  # 写权限
    DELETE = "delete"  # 删除权限
    ADMIN = "admin"  # 管理权限
    PLUGIN = "plugin"  # 插件权限

class CheckPermissionRequest(BaseModel):
    """检查权限请求"""
    user_id: str
    resource: str
    permission: PermissionType
    plugin_id: Optional[str] = None

class AuthorizationResponse(BaseModel):
    """权限响应"""
    status: str
    granted: bool
    message: Optional[str] = None
    error: Optional[Dict[str, Any]] = None
```

### 错误码定义

| 错误码 | 描述 | HTTP状态码 |
|--------|------|-----------|
| `AUTHZ_001` | 权限不足 | 403 |
| `AUTHZ_002` | 角色不存在 | 404 |
| `AUTHZ_003` | 插件不存在 | 404 |
| `AUTHZ_999` | 未知错误 | 500 |

---

## 7.4 零知识证明协议

### 协议名称
Zero Knowledge Proof Protocol

### 协议描述
定义零知识证明的协议，用于隐私保护的身份验证和数据验证。

### 协议版本
v3.0.0

### 协议变更
- 支持插件化的ZKP算法
- 支持领域特定的ZKP策略

### 接口定义

```python
class ZKPType(str, Enum):
    IDENTITY = "identity"  # 身份验证
    MEMBERSHIP = "membership"  # 成员证明
    RANGE = "range"  # 范围证明
    PLUGIN = "plugin"  # 插件证明

class GenerateZKPRequest(BaseModel):
    """生成ZKP请求"""
    type: ZKPType
    secret: Dict[str, Any]
    public_input: Dict[str, Any]
    plugin_id: Optional[str] = None

class VerifyZKPRequest(BaseModel):
    """验证ZKP请求"""
    proof: str
    public_input: Dict[str, Any]
    plugin_id: Optional[str] = None

class ZKPResponse(BaseModel):
    """ZKP响应"""
    status: str
    proof: Optional[str] = None
    valid: Optional[bool] = None
    message: Optional[str] = None
    error: Optional[Dict[str, Any]] = None
```

### 错误码定义

| 错误码 | 描述 | HTTP状态码 |
|--------|------|-----------|
| `ZKP_001` | 证明生成失败 | 500 |
| `ZKP_002` | 证明验证失败 | 400 |
| `ZKP_003` | 插件不存在 | 404 |
| `ZKP_999` | 未知错误 | 500 |

---

**文档继续...** （继续生成第8-10章节）

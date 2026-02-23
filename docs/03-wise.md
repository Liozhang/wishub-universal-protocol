# 2. WISE协议系统

## 2.1 WisStore协议

### 协议名称
WisStore Protocol

### 协议描述
定义WisHub的多级存储协议，包括L1内存存储、L2分布式存储、L3持久化存储。支持领域特定的存储策略。

### 协议版本
v3.0.0

### 协议变更
- 支持插件化的存储策略
- 支持领域特定的存储配置
- 增强存储层级的灵活性

### 接口定义

```python
from typing import Dict, Any, Optional, List
from pydantic import BaseModel
from datetime import datetime
from enum import Enum

class StorageLevel(str, Enum):
    L1 = "L1"  # 内存存储
    L2 = "L2"  # 分布式存储
    L3 = "L3"  # 持久化存储

class StorageStrategy(str, Enum):
    IMMEDIATE = "immediate"  # 立即存储
    DELAYED = "delayed"  # 延迟存储
    BATCH = "batch"  # 批量存储

class StoreWisUnitRequest(BaseModel):
    """存储WisUnit请求"""
    wisunit_id: str
    data: Dict[str, Any]
    levels: List[StorageLevel] = [StorageLevel.L1, StorageLevel.L2, StorageLevel.L3]
    strategy: StorageStrategy = StorageStrategy.IMMEDIATE
    ttl: Optional[int] = None  # TTL（秒）
    # 支持插件存储策略
    plugin_id: Optional[str] = None

class GetWisUnitRequest(BaseModel):
    """获取WisUnit请求"""
    wisunit_id: str
    version: Optional[str] = None
    level: Optional[StorageLevel] = None

class DeleteWisUnitRequest(BaseModel):
    """删除WisUnit请求"""
    wisunit_id: str
    levels: Optional[List[StorageLevel]] = None

class WisStoreResponse(BaseModel):
    """WisStore响应"""
    status: str
    data: Optional[Dict[str, Any]] = None
    message: Optional[str] = None
    error: Optional[Dict[str, Any]] = None
```

### 错误码定义

| 错误码 | 描述 | HTTP状态码 |
|--------|------|-----------|
| `WS_001` | WisUnit不存在 | 404 |
| `WS_002` | 存储空间不足 | 507 |
| `WS_003` | 存储层级不支持 | 400 |
| `WS_004` | 存储失败 | 500 |
| `WS_005` | 插件不存在 | 404 |
| `WS_999` | 未知错误 | 500 |

---

## 2.2 WisSync协议

### 协议名称
WisSync Protocol

### 协议描述
定义WisHub的数据同步协议，包括跨节点同步、增量同步、冲突解决。

### 协议版本
v3.0.0

### 协议变更
- 支持插件化的同步策略
- 支持领域特定的冲突解决规则

### 接口定义

```python
class SyncMode(str, Enum):
    FULL = "full"  # 全量同步
    INCREMENTAL = "incremental"  # 增量同步
    ON_DEMAND = "on_demand"  # 按需同步

class ConflictResolution(str, Enum):
    LAST_WRITE_WINS = "last_write_wins"  # 最后写入优先
    FIRST_WRITE_WINS = "first_write_wins"  # 首次写入优先
    MANUAL = "manual"  # 手动解决
    PLUGIN = "plugin"  # 插件解决

class SyncRequest(BaseModel):
    """同步请求"""
    node_ids: List[str]
    mode: SyncMode = SyncMode.INCREMENTAL
    conflict_resolution: ConflictResolution = ConflictResolution.LAST_WRITE_WINS
    plugin_id: Optional[str] = None

class WisSyncResponse(BaseModel):
    """WisSync响应"""
    status: str
    data: Optional[Dict[str, Any]] = None
    message: Optional[str] = None
    error: Optional[Dict[str, Any]] = None
```

### 错误码定义

| 错误码 | 描述 | HTTP状态码 |
|--------|------|-----------|
| `SYNC_001` | 节点不可达 | 503 |
| `SYNC_002` | 同步冲突 | 409 |
| `SYNC_003` | 同步失败 | 500 |
| `SYNC_004` | 插件不存在 | 404 |
| `SYNC_999` | 未知错误 | 500 |

---

## 2.3 WisVerify协议

### 协议名称
WisVerify Protocol

### 协议描述
定义WisHub的数据验证协议，包括数据完整性验证、签名验证、区块链验证。

### 协议版本
v3.0.0

### 协议变更
- 支持插件化的验证规则
- 支持领域特定的验证策略

### 接口定义

```python
class VerifyType(str, Enum):
    INTEGRITY = "integrity"  # 完整性验证
    SIGNATURE = "signature"  # 签名验证
    BLOCKCHAIN = "blockchain"  # 区块链验证
    PLUGIN = "plugin"  # 插件验证

class VerifyRequest(BaseModel):
    """验证请求"""
    wisunit_id: str
    verify_types: List[VerifyType] = [VerifyType.INTEGRITY]
    plugin_id: Optional[str] = None

class WisVerifyResponse(BaseModel):
    """WisVerify响应"""
    status: str
    valid: bool
    details: Optional[Dict[str, Any]] = None
    message: Optional[str] = None
    error: Optional[Dict[str, Any]] = None
```

### 错误码定义

| 错误码 | 描述 | HTTP状态码 |
|--------|------|-----------|
| `VER_001` | WisUnit不存在 | 404 |
| `VER_002` | 验证失败 | 400 |
| `VER_003` | 签名无效 | 401 |
| `VER_004` | 区块链验证失败 | 403 |
| `VER_005` | 插件不存在 | 404 |
| `VER_999` | 未知错误 | 500 |

---

## 2.4 WisIncentive协议

### 协议名称
WisIncentive Protocol

### 协议描述
定义WisHub的激励机制，包括贡献奖励、质量激励、参与激励。

### 协议版本
v3.0.0

### 协议变更
- 支持插件化的激励规则
- 支持领域特定的激励策略

### 接口定义

```python
class IncentiveType(str, Enum):
    CONTRIBUTION = "contribution"  # 贡献奖励
    QUALITY = "quality"  # 质量激励
    PARTICIPATION = "participation"  # 参与激励

class AwardIncentiveRequest(BaseModel):
    """奖励激励请求"""
    user_id: str
    wisunit_id: str
    incentive_type: IncentiveType
    amount: float
    plugin_id: Optional[str] = None

class WisIncentiveResponse(BaseModel):
    """WisIncentive响应"""
    status: str
    data: Optional[Dict[str, Any]] = None
    message: Optional[str] = None
    error: Optional[Dict[str, Any]] = None
```

### 错误码定义

| 错误码 | 描述 | HTTP状态码 |
|--------|------|-----------|
| `INC_001` | 用户不存在 | 404 |
| `INC_002` | 余额不足 | 402 |
| `INC_003` | 奖励失败 | 500 |
| `INC_004` | 插件不存在 | 404 |
| `INC_999` | 未知错误 | 500 |

---

## 2.5 WisDedup协议

### 协议名称
WisDedup Protocol

### 协议描述
定义WisHub的去重协议，包括内容去重、相似度检测、合并策略。

### 协议版本
v3.0.0

### 协议变更
- 支持插件化的去重策略
- 支持领域特定的相似度算法

### 接口定义

```python
class DedupStrategy(str, Enum):
    EXACT = "exact"  # 精确匹配
    SIMILARITY = "similarity"  # 相似度匹配
    SEMANTIC = "semantic"  # 语义匹配
    PLUGIN = "plugin"  # 插件匹配

class DedupRequest(BaseModel):
    """去重请求"""
    wisunit_id: str
    strategy: DedupStrategy = DedupStrategy.EXACT
    threshold: Optional[float] = None  # 相似度阈值
    plugin_id: Optional[str] = None

class WisDedupResponse(BaseModel):
    """WisDedup响应"""
    status: str
    duplicates: List[Dict[str, Any]] = []
    message: Optional[str] = None
    error: Optional[Dict[str, Any]] = None
```

### 错误码定义

| 错误码 | 描述 | HTTP状态码 |
|--------|------|-----------|
| `DED_001` | WisUnit不存在 | 404 |
| `DED_002` | 去重失败 | 500 |
| `DED_003` | 插件不存在 | 404 |
| `DED_999` | 未知错误 | 500 |

---

## 2.6 WisCache协议

### 协议名称
WisCache Protocol

### 协议描述
定义WisHub的多级缓存协议，包括L1本地缓存、L2分布式缓存、跨层缓存。

### 协议版本
v3.0.0

### 协议变更
- 支持插件化的缓存策略
- 支持领域特定的缓存规则

### 接口定义

```python
class CacheLevel(str, Enum):
    L1 = "L1"  # API网关层本地缓存
    L2 = "L2"  # 跨层缓存（Redis Cluster）
    L3 = "L3"  # 数据访问层缓存（Redis Cluster）

class CacheStrategy(str, Enum):
    WRITE_THROUGH = "write_through"  # 写穿透
    WRITE_BACK = "write_back"  # 写回
    REFRESH_AHEAD = "refresh_ahead"  # 预刷新
    INVALIDATE = "invalidate"  # 失效

class SetCacheRequest(BaseModel):
    """设置缓存请求"""
    key: str
    value: Dict[str, Any]
    level: CacheLevel
    ttl: Optional[int] = None  # TTL（秒）
    strategy: Optional[CacheStrategy] = None
    plugin_id: Optional[str] = None

class GetCacheRequest(BaseModel):
    """获取缓存请求"""
    key: str
    level: Optional[CacheLevel] = None

class WisCacheResponse(BaseModel):
    """WisCache响应"""
    status: str
    data: Optional[Dict[str, Any]] = None
    message: Optional[str] = None
    error: Optional[Dict[str, Any]] = None
```

### 错误码定义

| 错误码 | 描述 | HTTP状态码 |
|--------|------|-----------|
| `CACHE_001` | 缓存键不存在 | 404 |
| `CACHE_002` | 缓存层级不支持 | 400 |
| `CACHE_003` | TTL值无效 | 400 |
| `CACHE_004` | 缓存空间不足 | 507 |
| `CACHE_005` | 插件不存在 | 404 |
| `CACHE_999` | 未知错误 | 500 |

---


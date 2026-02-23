# WisHub 核心协议文档 v2.0

**项目名称**：WisHub 核心协议
**版本**：v2.0.0
**发布日期**：2026年2月23日
**文档类型**：协议规范（修订版）

---

## 版本历史

| 版本 | 日期 | 变更说明 |
|------|------|---------|
| v1.0.0 | 2026-02-23 | 初始版本，32个核心协议 |
| v2.0.0 | 2026-02-23 | 根据18位专家审查意见修订，新增8个P0级协议，修改3个P0级协议 |

---

## 目录

1. [WisUnit协议](#1-wisunit协议)
   - 1.1 WisUnit数据模型协议
   - 1.2 WisUnit CRUD协议
   - 1.3 WisUnit验证协议
   - 1.4 **[新增] WisUnit迁移协议**
2. [WISE协议系统](#2-wise协议系统)
   - 2.1 WisStore协议
   - 2.2 WisSync协议
   - 2.3 WisVerify协议
   - 2.4 WisIncentive协议
   - 2.5 WisDedup协议
   - 2.6 **[新增] WisCache协议**
3. [智核协议](#3-智核协议)
   - 3.1 智核生成协议
   - 3.2 智核进化协议
   - 3.3 智核验证协议
   - 3.4 **[新增] 智核Agent反馈进化协议**
4. [Agent协议](#4-agent协议)
   - 4.1 Agent注册协议
   - 4.2 Agent调用协议
   - 4.3 Agent类型协议
   - 4.4 **[新增] Agent调度协议**
   - 4.5 **[新增] Agent质量激励协议**
5. [知识图谱协议](#5-知识图谱协议)
   - 5.1 图数据库接口协议
   - 5.2 知识关联协议
6. [通信协议](#6-通信协议)
   - 6.1 REST API协议
   - 6.2 WebSocket协议
   - 6.3 gRPC协议
7. [安全协议](#7-安全协议)
   - 7.1 认证协议
   - 7.2 加密协议
   - 7.3 权限协议
   - 7.4 **[新增] 零知识证明协议**
8. [领域协议](#8-领域协议)
   - 8.1 医学领域协议
   - 8.2 金融领域协议
   - 8.3 法律领域协议
   - 8.4 教育领域协议
   - 8.5 **[新增] 医学合规性协议**
   - 8.6 **[新增] 金融合规性协议**
9. [经济模型协议](#9-经济模型协议)
   - 9.1 信用协议
   - 9.2 赏金协议
   - 9.3 汇率协议
10. [部署协议](#10-部署协议)
    - 10.1 配置协议
    - 10.2 监控协议
    - 10.3 备份协议

---

## 1.4 WisUnit迁移协议

### 协议名称
WisUnit Migration Protocol

### 协议描述
定义WisUnit的版本迁移、数据迁移协议，支持SemVer版本控制和向后兼容性检查。

### 协议版本
v1.0.0

### 接口定义

```python
from typing import Dict, Any, Optional, List
from pydantic import BaseModel
from datetime import datetime
from enum import Enum

class MigrationType(str, Enum):
    """迁移类型"""
    VERSION = "version"  # 版本迁移
    DATA = "data"  # 数据迁移
    SCHEMA = "schema"  # Schema迁移

class MigrationDirection(str, Enum):
    """迁移方向"""
    UPGRADE = "upgrade"  # 升级
    DOWNGRADE = "downgrade"  # 降级

class Compatibility(str, Enum):
    """兼容性"""
    BACKWARD_COMPATIBLE = "backward_compatible"  # 向后兼容
    FORWARD_COMPATIBLE = "forward_compatible"  # 向前兼容
    INCOMPATIBLE = "incompatible"  # 不兼容

class MigrateWisUnitRequest(BaseModel):
    """迁移WisUnit请求"""
    wisunit_id: str
    migration_type: MigrationType
    direction: MigrationDirection
    target_version: Optional[str] = None
    dry_run: bool = False
    backup: bool = True

class CheckCompatibilityRequest(BaseModel):
    """检查兼容性请求"""
    source_version: str
    target_version: str

class RollbackMigrationRequest(BaseModel):
    """回滚迁移请求"""
    wisunit_id: str
    migration_id: str

class WisUnitMigrationResponse(BaseModel):
    """WisUnit迁移响应"""
    status: str
    migration_id: Optional[str] = None
    data: Optional[Dict[str, Any]] = None
    message: Optional[str] = None
    error: Optional[Dict[str, Any]] = None
```

### 请求格式（JSON Schema）

```json
{
  "MigrateWisUnitRequest": {
    "type": "object",
    "required": ["wisunit_id", "migration_type", "direction"],
    "properties": {
      "wisunit_id": {"type": "string"},
      "migration_type": {"type": "string", "enum": ["version", "data", "schema"]},
      "direction": {"type": "string", "enum": ["upgrade", "downgrade"]},
      "target_version": {"type": "string"},
      "dry_run": {"type": "boolean"},
      "backup": {"type": "boolean"}
    }
  },
  "CheckCompatibilityRequest": {
    "type": "object",
    "required": ["source_version", "target_version"],
    "properties": {
      "source_version": {"type": "string"},
      "target_version": {"type": "string"}
    }
  }
}
```

### 响应格式（JSON Schema）

```json
{
  "WisUnitMigrationResponse": {
    "type": "object",
    "properties": {
      "status": {"type": "string", "enum": ["success", "error"]},
      "migration_id": {"type": "string"},
      "data": {"type": "object"},
      "message": {"type": "string"},
      "error": {"type": "object"}
    }
  }
}
```

### 错误码定义

| 错误码 | 描述 | HTTP状态码 |
|--------|------|-----------|
| `MIG_001` | WisUnit不存在 | 404 |
| `MIG_002` | 版本格式错误 | 400 |
| `MIG_003` | 版本不兼容 | 400 |
| `MIG_004` | 迁移失败 | 500 |
| `MIG_005` | 回滚失败 | 500 |
| `MIG_999` | 未知错误 | 500 |

### 示例代码（Python）

```python
import uuid
import re
from datetime import datetime

class WisUnitMigration:
    """WisUnit迁移系统"""

    def __init__(self, db_client):
        self.db = db_client

    async def check_compatibility(self, request: CheckCompatibilityRequest) -> Dict[str, Any]:
        """检查版本兼容性"""
        # 解析SemVer版本
        source = self._parse_semver(request.source_version)
        target = self._parse_semver(request.target_version)

        # 判断兼容性
        if source["major"] == target["major"]:
            # 主版本号相同，向后兼容
            compatibility = Compatibility.BACKWARD_COMPATIBLE
        elif source["major"] < target["major"]:
            # 主版本号增加，可能不兼容
            compatibility = Compatibility.INCOMPATIBLE
        else:
            # 主版本号减少，可能不兼容
            compatibility = Compatibility.INCOMPATIBLE

        return {
            "source_version": request.source_version,
            "target_version": request.target_version,
            "compatibility": compatibility.value,
            "migration_safe": compatibility != Compatibility.INCOMPATIBLE
        }

    async def migrate(self, request: MigrateWisUnitRequest) -> WisUnitMigrationResponse:
        """迁移WisUnit"""
        migration_id = str(uuid.uuid4())

        # 获取WisUnit
        wisunit = await self._get_wisunit(request.wisunit_id)
        if not wisunit:
            return WisUnitMigrationResponse(
                status="error",
                error={"code": "MIG_001", "message": "WisUnit不存在"}
            )

        # 检查兼容性
        if request.migration_type == MigrationType.VERSION and request.target_version:
            compat_result = await self.check_compatibility(
                CheckCompatibilityRequest(
                    source_version=wisunit["version"],
                    target_version=request.target_version
                )
            )

            if not compat_result["migration_safe"]:
                return WisUnitMigrationResponse(
                    status="error",
                    error={"code": "MIG_003", "message": "版本不兼容"}
                )

        # 备份（如果启用）
        if request.backup and not request.dry_run:
            await self._backup_wisunit(request.wisunit_id, migration_id)

        # 执行迁移
        try:
            if request.migration_type == MigrationType.VERSION:
                result = await self._version_migration(wisunit, request.target_version, request.direction)
            elif request.migration_type == MigrationType.DATA:
                result = await self._data_migration(wisunit, request.direction)
            elif request.migration_type == MigrationType.SCHEMA:
                result = await self._schema_migration(wisunit, request.direction)
            else:
                return WisUnitMigrationResponse(
                    status="error",
                    error={"code": "MIG_002", "message": "不支持的迁移类型"}
                )

            # 如果是dry run，返回结果但不保存
            if request.dry_run:
                return WisUnitMigrationResponse(
                    status="success",
                    migration_id=migration_id,
                    data={
                        "dry_run": True,
                        "migration_plan": result
                    },
                    message="迁移计划生成成功（Dry Run）"
                )

            # 保存迁移记录
            await self._save_migration({
                "migration_id": migration_id,
                "wisunit_id": request.wisunit_id,
                "migration_type": request.migration_type.value,
                "direction": request.direction.value,
                "target_version": request.target_version,
                "result": result,
                "migrated_at": datetime.now()
            })

            # 更新WisUnit
            await self._update_wisunit(request.wisunit_id, result)

            return WisUnitMigrationResponse(
                status="success",
                migration_id=migration_id,
                data=result,
                message="迁移成功"
            )

        except Exception as e:
            # 回滚（如果失败）
            if request.backup and not request.dry_run:
                await self._rollback_wisunit(request.wisunit_id, migration_id)

            return WisUnitMigrationResponse(
                status="error",
                error={"code": "MIG_004", "message": f"迁移失败: {str(e)}"}
            )

    async def rollback(self, request: RollbackMigrationRequest) -> WisUnitMigrationResponse:
        """回滚迁移"""
        # 获取迁移记录
        migration = await self._get_migration(request.migration_id)
        if not migration:
            return WisUnitMigrationResponse(
                status="error",
                error={"code": "MIG_005", "message": "迁移记录不存在"}
            )

        # 执行回滚
        await self._rollback_wisunit(request.wisunit_id, request.migration_id)

        return WisUnitMigrationResponse(
            status="success",
            message="回滚成功"
        )

    def _parse_semver(self, version: str) -> Dict[str, int]:
        """解析SemVer版本"""
        match = re.match(r'^(\d+)\.(\d+)\.(\d+)', version)
        if match:
            return {
                "major": int(match.group(1)),
                "minor": int(match.group(2)),
                "patch": int(match.group(3))
            }
        else:
            raise ValueError("无效的SemVer版本")

    async def _version_migration(self, wisunit: Dict[str, Any],
                                target_version: str, direction: MigrationDirection) -> Dict[str, Any]:
        """版本迁移"""
        # 实现版本迁移逻辑
        return {"new_version": target_version, "changes": []}

    async def _data_migration(self, wisunit: Dict[str, Any], direction: MigrationDirection) -> Dict[str, Any]:
        """数据迁移"""
        # 实现数据迁移逻辑
        return {"data_migrated": True}

    async def _schema_migration(self, wisunit: Dict[str, Any], direction: MigrationDirection) -> Dict[str, Any]:
        """Schema迁移"""
        # 实现Schema迁移逻辑
        return {"schema_migrated": True}

    async def _backup_wisunit(self, wisunit_id: str, migration_id: str):
        """备份WisUnit"""
        # 实现备份逻辑
        pass

    async def _rollback_wisunit(self, wisunit_id: str, migration_id: str):
        """回滚WisUnit"""
        # 实现回滚逻辑
        pass

    async def _get_wisunit(self, wisunit_id: str) -> Optional[Dict[str, Any]]:
        """获取WisUnit"""
        # 实现数据库查询
        pass

    async def _update_wisunit(self, wisunit_id: str, data: Dict[str, Any]):
        """更新WisUnit"""
        # 实现数据库更新
        pass

    async def _save_migration(self, migration: Dict[str, Any]):
        """保存迁移记录"""
        # 实现数据库保存
        pass

    async def _get_migration(self, migration_id: str) -> Optional[Dict[str, Any]]:
        """获取迁移记录"""
        # 实现数据库查询
        pass
```

---

## 2.6 WisCache协议

### 协议名称
WisCache Protocol

### 协议描述
定义WisHub的多级缓存协议，包括L1本地缓存、L2分布式缓存、跨层缓存，支持缓存预热、缓存更新、缓存失效。

### 协议版本
v1.0.0

### 接口定义

```python
from typing import Dict, Any, Optional, List
from pydantic import BaseModel
from datetime import datetime
from enum import Enum

class CacheLevel(str, Enum):
    """缓存层级"""
    L1 = "L1"  # API网关层本地缓存
    L2 = "L2"  # 跨层缓存（Redis Cluster）
    L3 = "L3"  # 数据访问层缓存（Redis Cluster）

class CacheStrategy(str, Enum):
    """缓存策略"""
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

class GetCacheRequest(BaseModel):
    """获取缓存请求"""
    key: str
    level: Optional[CacheLevel] = None

class InvalidateCacheRequest(BaseModel):
    """失效缓存请求"""
    key: str
    level: Optional[CacheLevel] = None

class PreWarmCacheRequest(BaseModel):
    """预热缓存请求"""
    keys: List[str]
    level: CacheLevel

class WisCacheResponse(BaseModel):
    """WisCache响应"""
    status: str
    data: Optional[Dict[str, Any]] = None
    message: Optional[str] = None
    error: Optional[Dict[str, Any]] = None
```

### 请求格式（JSON Schema）

```json
{
  "SetCacheRequest": {
    "type": "object",
    "required": ["key", "value", "level"],
    "properties": {
      "key": {"type": "string"},
      "value": {"type": "object"},
      "level": {"type": "string", "enum": ["L1", "L2", "L3"]},
      "ttl": {"type": "integer"},
      "strategy": {"type": "string", "enum": ["write_through", "write_back", "refresh_ahead", "invalidate"]}
    }
  },
  "GetCacheRequest": {
    "type": "object",
    "required": ["key"],
    "properties": {
      "key": {"type": "string"},
      "level": {"type": "string", "enum": ["L1", "L2", "L3"]}
    }
  },
  "InvalidateCacheRequest": {
    "type": "object",
    "required": ["key"],
    "properties": {
      "key": {"type": "string"},
      "level": {"type": "string", "enum": ["L1", "L2", "L3"]}
    }
  }
}
```

### 响应格式（JSON Schema）

```json
{
  "WisCacheResponse": {
    "type": "object",
    "properties": {
      "status": {"type": "string", "enum": ["success", "error"]},
      "data": {"type": "object"},
      "message": {"type": "string"},
      "error": {"type": "object"}
    }
  }
}
```

### 错误码定义

| 错误码 | 描述 | HTTP状态码 |
|--------|------|-----------|
| `CACHE_001` | 缓存键不存在 | 404 |
| `CACHE_002` | 缓存层级不支持 | 400 |
| `CACHE_003` | TTL值无效 | 400 |
| `CACHE_004` | 缓存空间不足 | 507 |
| `CACHE_999` | 未知错误 | 500 |

### 示例代码（Python）

```python
import json
import time
from typing import Optional, Dict, Any, List

class WisCache:
    """WisHub缓存系统"""

    def __init__(self, redis_client, local_cache=None):
        self.redis = redis_client
        self.local_cache = local_cache or {}  # L1本地缓存

    async def get(self, request: GetCacheRequest) -> WisCacheResponse:
        """获取缓存（多级查询）"""
        # 指定层级查询
        if request.level:
            if request.level == CacheLevel.L1:
                value = await self._get_l1(request.key)
            elif request.level == CacheLevel.L2:
                value = await self._get_l2(request.key)
            elif request.level == CacheLevel.L3:
                value = await self._get_l3(request.key)
            else:
                return WisCacheResponse(
                    status="error",
                    error={"code": "CACHE_002", "message": "缓存层级不支持"}
                )

            if value is None:
                return WisCacheResponse(
                    status="error",
                    error={"code": "CACHE_001", "message": "缓存键不存在"}
                )

            return WisCacheResponse(
                status="success",
                data={"key": request.key, "value": value, "level": request.level.value}
            )

        # 多级查询（L1 -> L2 -> L3）
        # L1本地缓存
        value = await self._get_l1(request.key)
        if value is not None:
            return WisCacheResponse(
                status="success",
                data={"key": request.key, "value": value, "level": "L1"}
            )

        # L2跨层缓存
        value = await self._get_l2(request.key)
        if value is not None:
            # 回填L1缓存
            await self._set_l1(request.key, value)
            return WisCacheResponse(
                status="success",
                data={"key": request.key, "value": value, "level": "L2"}
            )

        # L3数据访问层缓存
        value = await self._get_l3(request.key)
        if value is not None:
            # 回填L2和L1缓存
            await self._set_l2(request.key, value)
            await self._set_l1(request.key, value)
            return WisCacheResponse(
                status="success",
                data={"key": request.key, "value": value, "level": "L3"}
            )

        return WisCacheResponse(
            status="error",
            error={"code": "CACHE_001", "message": "缓存键不存在"}
        )

    async def set(self, request: SetCacheRequest) -> WisCacheResponse:
        """设置缓存"""
        # 根据策略设置缓存
        if request.strategy == CacheStrategy.WRITE_THROUGH:
            # 写穿透：同步更新所有层级
            await self._set_l1(request.key, request.value, request.ttl)
            await self._set_l2(request.key, request.value, request.ttl)
            await self._set_l3(request.key, request.value, request.ttl)
        elif request.strategy == CacheStrategy.WRITE_BACK:
            # 写回：先更新L1，异步更新其他层级
            await self._set_l1(request.key, request.value, request.ttl)
            # 异步更新L2和L3（此处简化）
        elif request.strategy == CacheStrategy.REFRESH_AHEAD:
            # 预刷新：提前刷新缓存
            await self._set_l2(request.key, request.value, request.ttl)
        elif request.strategy == CacheStrategy.INVALIDATE:
            # 失效：删除所有层级缓存
            await self._invalidate_all(request.key)
            return WisCacheResponse(
                status="success",
                data={"key": request.key, "action": "invalidate"},
                message="缓存已失效"
            )

        return WisCacheResponse(
            status="success",
            data={"key": request.key, "level": request.level.value},
            message="缓存设置成功"
        )

    async def invalidate(self, request: InvalidateCacheRequest) -> WisCacheResponse:
        """失效缓存"""
        if request.level:
            if request.level == CacheLevel.L1:
                await self._invalidate_l1(request.key)
            elif request.level == CacheLevel.L2:
                await self._invalidate_l2(request.key)
            elif request.level == CacheLevel.L3:
                await self._invalidate_l3(request.key)
        else:
            await self._invalidate_all(request.key)

        return WisCacheResponse(
            status="success",
            data={"key": request.key},
            message="缓存已失效"
        )

    async def pre_warm(self, request: PreWarmCacheRequest) -> WisCacheResponse:
        """预热缓存"""
        warmed_keys = []

        for key in request.keys:
            # 从数据库加载数据
            value = await self._load_from_db(key)

            if value:
                # 设置到指定层级
                if request.level == CacheLevel.L1:
                    await self._set_l1(key, value)
                elif request.level == CacheLevel.L2:
                    await self._set_l2(key, value)
                elif request.level == CacheLevel.L3:
                    await self._set_l3(key, value)

                warmed_keys.append(key)

        return WisCacheResponse(
            status="success",
            data={"warmed_keys": warmed_keys, "count": len(warmed_keys)},
            message=f"预热成功，共{len(warmed_keys)}个键"
        )

    async def _get_l1(self, key: str) -> Optional[Dict[str, Any]]:
        """获取L1缓存"""
        # L1使用本地字典（简化实现）
        entry = self.local_cache.get(key)
        if entry:
            if time.time() < entry["expire_time"]:
                return entry["value"]
            else:
                del self.local_cache[key]
        return None

    async def _set_l1(self, key: str, value: Dict[str, Any], ttl: Optional[int] = None):
        """设置L1缓存"""
        expire_time = time.time() + (ttl or 300)  # 默认5分钟
        self.local_cache[key] = {
            "value": value,
            "expire_time": expire_time
        }

    async def _get_l2(self, key: str) -> Optional[Dict[str, Any]]:
        """获取L2缓存"""
        # L2使用Redis
        data = await self.redis.get(f"cache:L2:{key}")
        if data:
            return json.loads(data)
        return None

    async def _set_l2(self, key: str, value: Dict[str, Any], ttl: Optional[int] = None):
        """设置L2缓存"""
        await self.redis.setex(
            f"cache:L2:{key}",
            ttl or 1800,  # 默认30分钟
            json.dumps(value)
        )

    async def _get_l3(self, key: str) -> Optional[Dict[str, Any]]:
        """获取L3缓存"""
        # L3使用Redis
        data = await self.redis.get(f"cache:L3:{key}")
        if data:
            return json.loads(data)
        return None

    async def _set_l3(self, key: str, value: Dict[str, Any], ttl: Optional[int] = None):
        """设置L3缓存"""
        await self.redis.setex(
            f"cache:L3:{key}",
            ttl or 3600,  # 默认1小时
            json.dumps(value)
        )

    async def _invalidate_l1(self, key: str):
        """失效L1缓存"""
        if key in self.local_cache:
            del self.local_cache[key]

    async def _invalidate_l2(self, key: str):
        """失效L2缓存"""
        await self.redis.delete(f"cache:L2:{key}")

    async def _invalidate_l3(self, key: str):
        """失效L3缓存"""
        await self.redis.delete(f"cache:L3:{key}")

    async def _invalidate_all(self, key: str):
        """失效所有层级缓存"""
        await self._invalidate_l1(key)
        await self._invalidate_l2(key)
        await self._invalidate_l3(key)

    async def _load_from_db(self, key: str) -> Optional[Dict[str, Any]]:
        """从数据库加载数据"""
        # 实现数据库加载
        pass
```

---

## 3.4 智核Agent反馈进化协议

### 协议名称
Wisdom Core Agent Feedback Evolution Protocol

### 协议描述
定义智核基于Agent反馈的进化协议，支持Agent调用数据收集、反馈评分、自动触发进化。

### 协议版本
v1.0.0

### 接口定义

```python
from typing import Dict, Any, Optional, List
from pydantic import BaseModel
from datetime import datetime
from enum import Enum

class FeedbackScore(str, Enum):
    """反馈评分"""
    EXCELLENT = "excellent"  # 优秀（5分）
    GOOD = "good"  # 良好（4分）
    SATISFACTORY = "satisfactory"  # 满意（3分）
    POOR = "poor"  # 较差（2分）
    VERY_POOR = "very_poor"  # 很差（1分）

class EvolutionTrigger(str, Enum):
    """进化触发条件"""
    FEEDBACK_LOW = "feedback_low"  # 反馈分数低
    SUCCESS_RATE_LOW = "success_rate_low"  # 成功率低
    USAGE_HIGH = "usage_high"  # 使用频率高
    MANUAL = "manual"  # 手动触发

class RecordAgentCallRequest(BaseModel):
    """记录Agent调用请求"""
    wisdom_core_id: str
    agent_id: str
    call_success: bool
    execution_time_ms: int
    feedback_score: Optional[FeedbackScore] = None
    feedback_comment: Optional[str] = None

class CheckEvolutionTriggerRequest(BaseModel):
    """检查进化触发请求"""
    wisdom_core_id: str
    time_window: str = "7d"  # 时间窗口

class TriggerEvolutionRequest(BaseModel):
    """触发进化请求"""
    wisdom_core_id: str
    trigger_type: EvolutionTrigger
    reason: Optional[str] = None

class WisdomCoreEvolutionResponse(BaseModel):
    """智核进化响应"""
    status: str
    evolution_id: Optional[str] = None
    data: Optional[Dict[str, Any]] = None
    message: Optional[str] = None
    error: Optional[Dict[str, Any]] = None
```

### 请求格式（JSON Schema）

```json
{
  "RecordAgentCallRequest": {
    "type": "object",
    "required": ["wisdom_core_id", "agent_id", "call_success", "execution_time_ms"],
    "properties": {
      "wisdom_core_id": {"type": "string"},
      "agent_id": {"type": "string"},
      "call_success": {"type": "boolean"},
      "execution_time_ms": {"type": "integer"},
      "feedback_score": {"type": "string", "enum": ["excellent", "good", "satisfactory", "poor", "very_poor"]},
      "feedback_comment": {"type": "string"}
    }
  },
  "CheckEvolutionTriggerRequest": {
    "type": "object",
    "required": ["wisdom_core_id"],
    "properties": {
      "wisdom_core_id": {"type": "string"},
      "time_window": {"type": "string"}
    }
  },
  "TriggerEvolutionRequest": {
    "type": "object",
    "required": ["wisdom_core_id", "trigger_type"],
    "properties": {
      "wisdom_core_id": {"type": "string"},
      "trigger_type": {"type": "string", "enum": ["feedback_low", "success_rate_low", "usage_high", "manual"]},
      "reason": {"type": "string"}
    }
  }
}
```

### 响应格式（JSON Schema）

```json
{
  "WisdomCoreEvolutionResponse": {
    "type": "object",
    "properties": {
      "status": {"type": "string", "enum": ["success", "error"]},
      "evolution_id": {"type": "string"},
      "data": {"type": "object"},
      "message": {"type": "string"},
      "error": {"type": "object"}
    }
  }
}
```

### 错误码定义

| 错误码 | 描述 | HTTP状态码 |
|--------|------|-----------|
| `EVL_001` | 智核不存在 | 404 |
| `EVL_002` | Agent不存在 | 404 |
| `EVL_003` | 进化触发条件不满足 | 400 |
| `EVL_004` | 进化失败 | 500 |
| `EVL_999` | 未知错误 | 500 |

### 示例代码（Python）

```python
import uuid
from datetime import datetime, timedelta
from typing import Optional, Dict, Any, List
from collections import defaultdict

class WisdomCoreEvolution:
    """智核Agent反馈进化系统"""

    def __init__(self, db_client, ai_client):
        self.db = db_client
        self.ai = ai_client

    async def record_agent_call(self, request: RecordAgentCallRequest) -> WisdomCoreEvolutionResponse:
        """记录Agent调用"""
        # 验证智核存在
        wisdom_core = await self._get_wisdom_core(request.wisdom_core_id)
        if not wisdom_core:
            return WisdomCoreEvolutionResponse(
                status="error",
                error={"code": "EVL_001", "message": "智核不存在"}
            )

        # 记录调用数据
        call_record = {
            "call_id": str(uuid.uuid4()),
            "wisdom_core_id": request.wisdom_core_id,
            "agent_id": request.agent_id,
            "call_success": request.call_success,
            "execution_time_ms": request.execution_time_ms,
            "feedback_score": request.feedback_score.value if request.feedback_score else None,
            "feedback_comment": request.feedback_comment,
            "call_time": datetime.now()
        }

        await self._save_call_record(call_record)

        # 更新智核指标
        await self._update_wisdom_core_metrics(request.wisdom_core_id)

        # 检查是否需要触发进化
        trigger_check = await self._check_evolution_trigger(
            CheckEvolutionTriggerRequest(wisdom_core_id=request.wisdom_core_id)
        )

        if trigger_check["should_trigger"]:
            # 自动触发进化
            evolution_trigger = TriggerEvolutionRequest(
                wisdom_core_id=request.wisdom_core_id,
                trigger_type=EvolutionTrigger(trigger_check["trigger_type"]),
                reason=f"自动触发: {trigger_check['reason']}"
            )

            evolution_result = await self.trigger_evolution(evolution_trigger)

            if evolution_result.status == "success":
                return WisdomCoreEvolutionResponse(
                    status="success",
                    evolution_id=evolution_result.evolution_id,
                    data={
                        "call_recorded": True,
                        "evolution_triggered": True,
                        "evolution_id": evolution_result.evolution_id
                    },
                    message="调用记录成功，已触发进化"
                )

        return WisdomCoreEvolutionResponse(
            status="success",
            data={"call_recorded": True, "evolution_triggered": False},
            message="调用记录成功"
        )

    async def check_evolution_trigger(self, request: CheckEvolutionTriggerRequest) -> Dict[str, Any]:
        """检查进化触发条件"""
        # 获取智核
        wisdom_core = await self._get_wisdom_core(request.wisdom_core_id)
        if not wisdom_core:
            return {"should_trigger": False, "reason": "智核不存在"}

        # 获取时间窗口内的调用数据
        time_delta = self._parse_time_window(request.time_window)
        start_time = datetime.now() - time_delta

        call_records = await self._get_call_records(
            request.wisdom_core_id,
            start_time=start_time
        )

        if not call_records:
            return {"should_trigger": False, "reason": "无调用数据"}

        # 计算指标
        total_calls = len(call_records)
        success_count = sum(1 for r in call_records if r["call_success"])
        success_rate = success_count / total_calls if total_calls > 0 else 0

        # 计算反馈评分
        feedback_scores = [
            self._feedback_score_to_numeric(r["feedback_score"])
            for r in call_records if r["feedback_score"]
        ]
        avg_feedback_score = sum(feedback_scores) / len(feedback_scores) if feedback_scores else 0

        # 检查触发条件
        evolution_triggers = wisdom_core.get("agent_feedback", {}).get("evolution_triggers", [])

        for trigger in evolution_triggers:
            if trigger["type"] == "feedback_low":
                low_feedback_count = sum(
                    1 for r in call_records
                    if r["feedback_score"] and
                    self._feedback_score_to_numeric(r["feedback_score"]) < 3.0
                )
                if low_feedback_count >= trigger.get("threshold", 10):
                    return {
                        "should_trigger": True,
                        "trigger_type": "feedback_low",
                        "reason": f"低反馈评分次数: {low_feedback_count}/{trigger.get('threshold', 10)}"
                    }

            elif trigger["type"] == "success_rate_low":
                if success_rate < trigger.get("threshold", 0.8):
                    return {
                        "should_trigger": True,
                        "trigger_type": "success_rate_low",
                        "reason": f"成功率: {success_rate:.2%} < {trigger.get('threshold', 0.8):.2%}"
                    }

            elif trigger["type"] == "usage_high":
                if total_calls >= trigger.get("threshold", 10000):
                    return {
                        "should_trigger": True,
                        "trigger_type": "usage_high",
                        "reason": f"调用次数: {total_calls} >= {trigger.get('threshold', 10000)}"
                    }

        return {"should_trigger": False, "reason": "触发条件不满足"}

    async def trigger_evolution(self, request: TriggerEvolutionRequest) -> WisdomCoreEvolutionResponse:
        """触发进化"""
        evolution_id = str(uuid.uuid4())

        # 获取智核
        wisdom_core = await self._get_wisdom_core(request.wisdom_core_id)
        if not wisdom_core:
            return WisdomCoreEvolutionResponse(
                status="error",
                error={"code": "EVL_001", "message": "智核不存在"}
            )

        # 检查是否已经有进行中的进化
        ongoing_evolution = await self._get_ongoing_evolution(request.wisdom_core_id)
        if ongoing_evolution:
            return WisdomCoreEvolutionResponse(
                status="error",
                error={"code": "EVL_003", "message": "已有进行中的进化"}
            )

        # 创建进化任务
        evolution_task = {
            "evolution_id": evolution_id,
            "wisdom_core_id": request.wisdom_core_id,
            "trigger_type": request.trigger_type.value,
            "reason": request.reason,
            "status": "in_progress",
            "created_at": datetime.now()
        }

        await self._save_evolution_task(evolution_task)

        # 执行进化
        try:
            # 调用AI进行进化
            evolved_wisdom_core = await self._evolve_with_ai(wisdom_core, request.trigger_type)

            # 保存进化后的智核
            await self._save_evolved_wisdom_core(request.wisdom_core_id, evolved_wisdom_core)

            # 更新进化任务状态
            await self._update_evolution_task_status(evolution_id, "completed")

            return WisdomCoreEvolutionResponse(
                status="success",
                evolution_id=evolution_id,
                data={
                    "wisdom_core_id": request.wisdom_core_id,
                    "trigger_type": request.trigger_type.value,
                    "evolution_version": evolved_wisdom_core.get("version")
                },
                message="进化成功"
            )

        except Exception as e:
            # 更新进化任务状态
            await self._update_evolution_task_status(evolution_id, "failed", str(e))

            return WisdomCoreEvolutionResponse(
                status="error",
                evolution_id=evolution_id,
                error={"code": "EVL_004", "message": f"进化失败: {str(e)}"}
            )

    def _feedback_score_to_numeric(self, score: str) -> float:
        """反馈评分转换为数值"""
        mapping = {
            "excellent": 5.0,
            "good": 4.0,
            "satisfactory": 3.0,
            "poor": 2.0,
            "very_poor": 1.0
        }
        return mapping.get(score, 0.0)

    def _parse_time_window(self, time_window: str) -> timedelta:
        """解析时间窗口"""
        if time_window.endswith("d"):
            return timedelta(days=int(time_window[:-1]))
        elif time_window.endswith("h"):
            return timedelta(hours=int(time_window[:-1]))
        elif time_window.endswith("m"):
            return timedelta(minutes=int(time_window[:-1]))
        else:
            return timedelta(days=7)  # 默认7天

    async def _evolve_with_ai(self, wisdom_core: Dict[str, Any],
                            trigger_type: EvolutionTrigger) -> Dict[str, Any]:
        """使用AI进化智核"""
        # 构建进化提示
        prompt = f"""
        作为WisHub的智核进化系统，请根据以下信息进化智核：

        智核ID: {wisdom_core['id']}
        智核标题: {wisdom_core['title']}
        当前版本: {wisdom_core['version']}

        触发类型: {trigger_type.value}
        触发原因: {wisdom_core.get('evolution_metrics', {})}

        请生成进化后的智核，要求：
        1. 改进可执行层的代码
        2. 优化结构化层的元数据
        3. 完善自然语言层的说明
        4. 确保三层内容一致性
        5. 解决触发类型对应的问题
        """

        # 调用AI模型
        result = await self.ai.generate(prompt)

        # 解析AI结果
        evolved_wisdom_core = self._parse_ai_result(result)

        # 更新版本号
        version_parts = wisdom_core["version"].split(".")
        version_parts[1] = str(int(version_parts[1]) + 1)
        evolved_wisdom_core["version"] = ".".join(version_parts)

        # 记录进化历史
        evolved_wisdom_core["evolution_history"] = wisdom_core.get("evolution_history", []) + [{
            "trigger_type": trigger_type.value,
            "evolved_at": datetime.now().isoformat(),
            "previous_version": wisdom_core["version"]
        }]

        return evolved_wisdom_core

    async def _get_wisdom_core(self, wisdom_core_id: str) -> Optional[Dict[str, Any]]:
        """获取智核"""
        # 实现数据库查询
        pass

    async def _save_call_record(self, call_record: Dict[str, Any]):
        """保存调用记录"""
        # 实现数据库保存
        pass

    async def _get_call_records(self, wisdom_core_id: str,
                               start_time: datetime = None) -> List[Dict[str, Any]]:
        """获取调用记录"""
        # 实现数据库查询
        pass

    async def _update_wisdom_core_metrics(self, wisdom_core_id: str):
        """更新智核指标"""
        # 实现指标更新
        pass

    async def _save_evolution_task(self, task: Dict[str, Any]):
        """保存进化任务"""
        # 实现数据库保存
        pass

    async def _get_ongoing_evolution(self, wisdom_core_id: str) -> Optional[Dict[str, Any]]:
        """获取进行中的进化"""
        # 实现数据库查询
        pass

    async def _update_evolution_task_status(self, evolution_id: str,
                                           status: str, error_message: str = None):
        """更新进化任务状态"""
        # 实现数据库更新
        pass

    async def _save_evolved_wisdom_core(self, wisdom_core_id: str,
                                        evolved_wisdom_core: Dict[str, Any]):
        """保存进化后的智核"""
        # 实现数据库保存
        pass

    def _parse_ai_result(self, result: str) -> Dict[str, Any]:
        """解析AI结果"""
        # 实现AI结果解析
        pass
```

---

## 4.4 Agent调度协议

### 协议名称
Agent Scheduling Protocol

### 协议描述
定义Agent的调度协议，包括任务队列管理、资源分配、负载均衡、优先级管理。

### 协议版本
v1.0.0

### 接口定义

```python
from typing import Dict, Any, Optional, List
from pydantic import BaseModel
from datetime import datetime
from enum import Enum

class TaskPriority(str, Enum):
    """任务优先级"""
    CRITICAL = "critical"  # 关键
    HIGH = "high"  # 高
    MEDIUM = "medium"  # 中
    LOW = "low"  # 低

class TaskStatus(str, Enum):
    """任务状态"""
    PENDING = "pending"  # 等待
    QUEUED = "queued"  # 队列中
    RUNNING = "running"  # 运行中
    COMPLETED = "completed"  # 完成
    FAILED = "failed"  # 失败
    CANCELLED = "cancelled"  # 已取消

class ScheduleTaskRequest(BaseModel):
    """调度任务请求"""
    task_id: str
    agent_type: str
    task_data: Dict[str, Any]
    priority: TaskPriority = TaskPriority.MEDIUM
    timeout_seconds: Optional[int] = None
    retry_on_failure: bool = True
    max_retries: int = 3

class GetTaskStatusRequest(BaseModel):
    """获取任务状态请求"""
    task_id: str

class CancelTaskRequest(BaseModel):
    """取消任务请求"""
    task_id: str
    reason: Optional[str] = None

class GetAgentPoolStatusRequest(BaseModel):
    """获取Agent池状态请求"""
    agent_type: Optional[str] = None

class AgentSchedulingResponse(BaseModel):
    """Agent调度响应"""
    status: str
    data: Optional[Dict[str, Any]] = None
    message: Optional[str] = None
    error: Optional[Dict[str, Any]] = None
```

### 请求格式（JSON Schema）

```json
{
  "ScheduleTaskRequest": {
    "type": "object",
    "required": ["task_id", "agent_type", "task_data"],
    "properties": {
      "task_id": {"type": "string"},
      "agent_type": {"type": "string"},
      "task_data": {"type": "object"},
      "priority": {"type": "string", "enum": ["critical", "high", "medium", "low"]},
      "timeout_seconds": {"type": "integer"},
      "retry_on_failure": {"type": "boolean"},
      "max_retries": {"type": "integer"}
    }
  },
  "GetTaskStatusRequest": {
    "type": "object",
    "required": ["task_id"],
    "properties": {
      "task_id": {"type": "string"}
    }
  },
  "CancelTaskRequest": {
    "type": "object",
    "required": ["task_id"],
    "properties": {
      "task_id": {"type": "string"},
      "reason": {"type": "string"}
    }
  }
}
```

### 响应格式（JSON Schema）

```json
{
  "AgentSchedulingResponse": {
    "type": "object",
    "properties": {
      "status": {"type": "string", "enum": ["success", "error"]},
      "data": {"type": "object"},
      "message": {"type": "string"},
      "error": {"type": "object"}
    }
  }
}
```

### 错误码定义

| 错误码 | 描述 | HTTP状态码 |
|--------|------|-----------|
| `SCH_001` | 任务不存在 | 404 |
| `SCH_002` | Agent类型不支持 | 400 |
| `SCH_003` | Agent池已满 | 503 |
| `SCH_004` | 任务调度失败 | 500 |
| `SCH_005` | 任务取消失败 | 500 |
| `SCH_999` | 未知错误 | 500 |

### 示例代码（Python）

```python
import uuid
import heapq
from typing import Dict, Any, Optional, List
from datetime import datetime, timedelta

class AgentScheduler:
    """Agent调度器"""

    def __init__(self, db_client, agent_pool_client):
        self.db = db_client
        self.agent_pool = agent_pool_client
        self.task_queues = {
            "critical": [],  # 优先级队列
            "high": [],
            "medium": [],
            "low": []
        }
        self.running_tasks = {}
        self.task_status = {}

    async def schedule_task(self, request: ScheduleTaskRequest) -> AgentSchedulingResponse:
        """调度任务"""
        # 检查任务是否已存在
        if request.task_id in self.task_status:
            return AgentSchedulingResponse(
                status="error",
                error={"code": "SCH_004", "message": "任务已存在"}
            )

        # 检查Agent类型是否支持
        available_agents = await self.agent_pool.get_available_agents(request.agent_type)
        if not available_agents:
            # 将任务加入队列
            await self._enqueue_task(request)
            return AgentSchedulingResponse(
                status="success",
                data={
                    "task_id": request.task_id,
                    "status": TaskStatus.QUEUED.value,
                    "position": len(self.task_queues[request.priority.value])
                },
                message="任务已加入队列"
            )

        # 分配Agent执行任务
        agent = await self._select_agent(available_agents, request.priority)
        if not agent:
            # 将任务加入队列
            await self._enqueue_task(request)
            return AgentSchedulingResponse(
                status="success",
                data={
                    "task_id": request.task_id,
                    "status": TaskStatus.QUEUED.value
                },
                message="任务已加入队列（无可用Agent）"
            )

        # 启动任务
        await self._start_task(request, agent)

        return AgentSchedulingResponse(
            status="success",
            data={
                "task_id": request.task_id,
                "status": TaskStatus.RUNNING.value,
                "agent_id": agent["agent_id"]
            },
            message="任务已启动"
        )

    async def get_task_status(self, request: GetTaskStatusRequest) -> AgentSchedulingResponse:
        """获取任务状态"""
        status = self.task_status.get(request.task_id)
        if not status:
            return AgentSchedulingResponse(
                status="error",
                error={"code": "SCH_001", "message": "任务不存在"}
            )

        return AgentSchedulingResponse(
            status="success",
            data=status
        )

    async def cancel_task(self, request: CancelTaskRequest) -> AgentSchedulingResponse:
        """取消任务"""
        status = self.task_status.get(request.task_id)
        if not status:
            return AgentSchedulingResponse(
                status="error",
                error={"code": "SCH_001", "message": "任务不存在"}
            )

        if status["status"] == TaskStatus.RUNNING.value:
            # 取消正在运行的任务
            await self._cancel_running_task(request.task_id, request.reason)
        else:
            # 从队列中移除
            await self._dequeue_task(request.task_id)

        return AgentSchedulingResponse(
            status="success",
            data={"task_id": request.task_id},
            message="任务已取消"
        )

    async def get_agent_pool_status(self, request: GetAgentPoolStatusRequest) -> AgentSchedulingResponse:
        """获取Agent池状态"""
        if request.agent_type:
            # 获取特定类型的Agent池状态
            pool_status = await self.agent_pool.get_pool_status(request.agent_type)
        else:
            # 获取所有Agent池状态
            pool_status = await self.agent_pool.get_all_pool_status()

        return AgentSchedulingResponse(
            status="success",
            data=pool_status
        )

    async def _enqueue_task(self, request: ScheduleTaskRequest):
        """将任务加入队列"""
        priority_queue = self.task_queues[request.priority.value]

        # 使用优先级队列
        heapq.heappush(priority_queue, (
            self._priority_to_value(request.priority),
            datetime.now(),
            request
        ))

        # 更新任务状态
        self.task_status[request.task_id] = {
            "task_id": request.task_id,
            "status": TaskStatus.QUEUED.value,
            "priority": request.priority.value,
            "queued_at": datetime.now().isoformat()
        }

        # 保存到数据库
        await self._save_task_status(request.task_id, self.task_status[request.task_id])

    async def _dequeue_task(self, task_id: str):
        """从队列中移除任务"""
        # 从所有队列中查找并移除
        for priority, queue in self.task_queues.items():
            for i, (_, _, task) in enumerate(queue):
                if task.task_id == task_id:
                    queue.pop(i)
                    heapq.heapify(queue)
                    break

        # 更新任务状态
        self.task_status[task_id]["status"] = TaskStatus.CANCELLED.value
        self.task_status[task_id]["cancelled_at"] = datetime.now().isoformat()

        # 保存到数据库
        await self._save_task_status(task_id, self.task_status[task_id])

    async def _start_task(self, request: ScheduleTaskRequest, agent: Dict[str, Any]):
        """启动任务"""
        # 更新任务状态
        self.task_status[request.task_id] = {
            "task_id": request.task_id,
            "status": TaskStatus.RUNNING.value,
            "agent_id": agent["agent_id"],
            "started_at": datetime.now().isoformat()
        }

        # 保存到数据库
        await self._save_task_status(request.task_id, self.task_status[request.task_id])

        # 调用Agent执行任务
        await self.agent_pool.execute_task(agent["agent_id"], request)

    async def _cancel_running_task(self, task_id: str, reason: Optional[str]):
        """取消正在运行的任务"""
        status = self.task_status[task_id]

        # 通知Agent取消任务
        await self.agent_pool.cancel_task(status["agent_id"], task_id, reason)

        # 更新任务状态
        self.task_status[task_id]["status"] = TaskStatus.CANCELLED.value
        self.task_status[task_id]["cancelled_at"] = datetime.now().isoformat()
        if reason:
            self.task_status[task_id]["cancellation_reason"] = reason

        # 保存到数据库
        await self._save_task_status(task_id, self.task_status[task_id])

    def _select_agent(self, available_agents: List[Dict[str, Any]],
                     priority: TaskPriority) -> Optional[Dict[str, Any]]:
        """选择Agent"""
        if not available_agents:
            return None

        # 简单的负载均衡：选择负载最低的Agent
        return min(available_agents, key=lambda a: a.get("current_tasks", 0))

    def _priority_to_value(self, priority: TaskPriority) -> int:
        """优先级转换为数值（数值越小优先级越高）"""
        mapping = {
            TaskPriority.CRITICAL: 0,
            TaskPriority.HIGH: 1,
            TaskPriority.MEDIUM: 2,
            TaskPriority.LOW: 3
        }
        return mapping[priority]

    async def _save_task_status(self, task_id: str, status: Dict[str, Any]):
        """保存任务状态"""
        # 实现数据库保存
        pass
```

---

由于篇幅限制，v2.0文档的其他新增协议将在后续补充。当前已新增：
- 1.4 WisUnit迁移协议
- 2.6 WisCache协议
- 3.4 智核Agent反馈进化协议
- 4.4 Agent调度协议

剩余P0级新增协议：
- 4.5 Agent质量激励协议
- 7.4 零知识证明协议
- 8.5 医学合规性协议
- 8.6 金融合规性协议

---

**文档版本**: v2.0.0
**新增协议**: 4个
**总计协议**: 36个
**最后更新**: 2026-02-23

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

   - 1.2 WisUnit CRUD协议
   - 1.3 WisUnit验证协议
   - 1.4 WisUnit迁移协议

2. [WISE协议系统](#2-wise协议系统)
   - 2.1 WisStore协议
   - 2.2 WisSync协议
   - 2.3 WisVerify协议
   - 2.4 WisIncentive协议
   - 2.5 WisDedup协议
   - 2.6 WisCache协议

3. [智核协议](#3-智核协议)
   - 3.1 智核生成协议
   - 3.2 智核进化协议
   - 3.3 智核验证协议
   - 3.4 智核Agent反馈进化协议

4. [Agent协议](#4-agent协议)
   - 4.1 Agent注册协议
   - 4.2 Agent调用协议
   - 4.3 Agent类型协议
   - 4.4 Agent调度协议
   - 4.5 Agent质量激励协议

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
   - 7.4 零知识证明协议

8. [领域扩展协议](#8-领域扩展协议)
   - **[新增] 8.1 通用领域扩展协议**
     - 8.1.1 领域插件注册协议
     - 8.1.2 领域验证规则扩展协议
     - 8.1.3 领域数据结构扩展协议
     - 8.1.4 通用领域配置协议

9. [经济模型协议](#9-经济模型协议)
   - 9.1 信用协议
   - 9.2 赏金协议
   - 9.3 汇率协议

10. [部署协议](#10-部署协议)
11. [MCP/Skill协议](#11-mcpskill协议)
    - 11.1 MCP调用协议
    - 11.2 Skill调用协议
    - 11.3 Skill注册协议
    - 11.4 Skill发现协议
    - 11.5 Skill编排协议
    - 10.1 配置协议
    - 10.2 监控协议
    - 10.3 备份协议

---

# 1. WisUnit协议

## 1.1 WisUnit数据模型协议

### 协议名称
WisUnit Data Model Protocol

### 协议描述
定义WisUnit（知识单元）的三层架构数据模型，包括可执行层、结构化层和自然语言层。支持领域扩展的数据结构和验证规则。

### 协议版本
v3.0.0

### 协议变更
- 移除domain字段的硬编码限制
- 支持通过插件扩展自定义数据类型
- 增强数据结构的灵活性

### 接口定义

```python
from typing import Dict, Any, List, Optional, Union
from pydantic import BaseModel, Field
from datetime import datetime
from enum import Enum

class LayerType(str, Enum):
    EXECUTABLE = "executable"
    STRUCTURED = "structured"
    NATURAL_LANGUAGE = "natural_language"

class WisUnitLayer1(BaseModel):
    """可执行层：AI、机器、Agent可执行的知识"""
    type: LayerType = LayerType.EXECUTABLE
    code: Optional[Dict[str, Any]] = None
    model: Optional[Dict[str, Any]] = None
    workflow: Optional[Dict[str, Any]] = None
    agent_api: Optional[Dict[str, Any]] = None
    # 支持领域扩展的执行接口
    custom_interfaces: Dict[str, Any] = Field(default_factory=dict)

class WisUnitLayer2(BaseModel):
    """结构化层：程序、系统可处理的知识"""
    type: LayerType = LayerType.STRUCTURED
    metadata: Dict[str, Any]
    schema: Dict[str, Any]
    relations: List[Dict[str, Any]] = []
    dependencies: List[str] = []
    # 支持领域扩展的元数据
    custom_metadata: Dict[str, Any] = Field(default_factory=dict)

class WisUnitLayer3(BaseModel):
    """自然语言层：人类可理解的知识"""
    type: LayerType = LayerType.NATURAL_LANGUAGE
    title: str
    description: str
    explanation: Optional[str] = None
    examples: List[Dict[str, Any]] = []
    references: List[Dict[str, Any]] = []
    # 支持领域扩展的自然语言内容
    custom_content: Dict[str, Any] = Field(default_factory=dict)

class PartitionKey(BaseModel):
    """分区键"""
    geo: str
    user: int
    domain: Optional[str] = None  # 可选，不再强制要求
    data_type: str

class AuditLog(BaseModel):
    """审计日志"""
    created_at: datetime
    created_by: str
    signature: Optional[str] = None
    blockchain_tx: Optional[str] = None
    plugin_signatures: Dict[str, str] = Field(default_factory=dict)  # 插件签名

class WisUnit(BaseModel):
    """WisUnit完整数据模型"""
    id: str
    version: str
    created_at: datetime
    updated_at: datetime
    created_by: str
    domain: Optional[str] = None  # 可选，不再强制要求
    tags: List[str] = []
    layer_1: WisUnitLayer1
    layer_2: WisUnitLayer2
    layer_3: WisUnitLayer3
    partition_key: Optional[PartitionKey] = None
    audit_log: Optional[AuditLog] = None
    # 支持领域扩展的自定义字段
    custom_fields: Dict[str, Any] = Field(default_factory=dict)

class CreateWisUnitRequest(BaseModel):
    """创建WisUnit请求"""
    id: str
    version: str
    created_by: str
    domain: Optional[str] = None
    tags: List[str] = []
    layer_1: WisUnitLayer1
    layer_2: WisUnitLayer2
    layer_3: WisUnitLayer3
    custom_fields: Dict[str, Any] = Field(default_factory=dict)

class UpdateWisUnitRequest(BaseModel):
    """更新WisUnit请求"""
    id: str
    version: Optional[str] = None
    tags: Optional[List[str]] = None
    layer_1: Optional[WisUnitLayer1] = None
    layer_2: Optional[WisUnitLayer2] = None
    layer_3: Optional[WisUnitLayer3] = None
    custom_fields: Optional[Dict[str, Any]] = None

class WisUnitResponse(BaseModel):
    """WisUnit响应"""
    status: str
    data: Optional[Dict[str, Any]] = None
    message: Optional[str] = None
    error: Optional[Dict[str, Any]] = None
```

### 请求格式（JSON Schema）

```json
{
  "CreateWisUnitRequest": {
    "type": "object",
    "required": ["id", "version", "created_by", "layer_1", "layer_2", "layer_3"],
    "properties": {
      "id": {
        "type": "string",
        "pattern": "^ku_[0-9]{8}_[0-9]{3}$"
      },
      "version": {
        "type": "string",
        "pattern": "^[0-9]+\\.[0-9]+\\.[0-9]+$"
      },
      "created_by": {
        "type": "string"
      },
      "domain": {
        "type": "string"
      },
      "tags": {
        "type": "array",
        "items": {
          "type": "string"
        }
      },
      "layer_1": {
        "$ref": "#/definitions/Layer1"
      },
      "layer_2": {
        "$ref": "#/definitions/Layer2"
      },
      "layer_3": {
        "$ref": "#/definitions/Layer3"
      },
      "custom_fields": {
        "type": "object"
      }
    }
  }
}
```

### 响应格式（JSON Schema）

```json
{
  "WisUnitResponse": {
    "type": "object",
    "properties": {
      "status": {
        "type": "string",
        "enum": ["success", "error"]
      },
      "data": {
        "type": "object"
      },
      "message": {
        "type": "string"
      },
      "error": {
        "type": "object"
      }
    }
  }
}
```

### 错误码定义

| 错误码 | 描述 | HTTP状态码 |
|--------|------|-----------|
| `WU_001` | WisUnit已存在 | 409 |
| `WU_002` | WisUnit不存在 | 404 |
| `WU_003` | 版本格式错误 | 400 |
| `WU_004` | 层结构不完整 | 400 |
| `WU_005` | 自定义字段验证失败 | 400 |
| `WU_999` | 未知错误 | 500 |

### 示例代码（Python）

```python
from typing import Dict, Any, Optional
import uuid

class WisUnitManager:
    """WisUnit管理器"""

    def __init__(self, db_client, plugin_manager):
        self.db = db_client
        self.plugin_manager = plugin_manager

    async def create_wisunit(self, request: CreateWisUnitRequest) -> WisUnitResponse:
        """创建WisUnit"""
        # 检查WisUnit是否已存在
        existing = await self._get_wisunit(request.id)
        if existing:
            return WisUnitResponse(
                status="error",
                error={"code": "WU_001", "message": "WisUnit已存在"}
            )

        # 验证自定义字段（通过插件）
        validation_result = await self._validate_custom_fields(request.custom_fields)
        if not validation_result["valid"]:
            return WisUnitResponse(
                status="error",
                error={"code": "WU_005", "message": "自定义字段验证失败", "details": validation_result["errors"]}
            )

        # 创建WisUnit
        wisunit = WisUnit(
            id=request.id,
            version=request.version,
            created_at=datetime.now(),
            updated_at=datetime.now(),
            created_by=request.created_by,
            domain=request.domain,
            tags=request.tags,
            layer_1=request.layer_1,
            layer_2=request.layer_2,
            layer_3=request.layer_3,
            custom_fields=request.custom_fields,
            audit_log=AuditLog(
                created_at=datetime.now(),
                created_by=request.created_by
            )
        )

        # 保存到数据库
        await self._save_wisunit(wisunit)

        return WisUnitResponse(
            status="success",
            data={"wisunit_id": wisunit.id, "version": wisunit.version},
            message="WisUnit创建成功"
        )

    async def update_wisunit(self, request: UpdateWisUnitRequest) -> WisUnitResponse:
        """更新WisUnit"""
        # 获取WisUnit
        wisunit = await self._get_wisunit(request.id)
        if not wisunit:
            return WisUnitResponse(
                status="error",
                error={"code": "WU_002", "message": "WisUnit不存在"}
            )

        # 验证自定义字段（通过插件）
        if request.custom_fields:
            validation_result = await self._validate_custom_fields(request.custom_fields)
            if not validation_result["valid"]:
                return WisUnitResponse(
                    status="error",
                    error={"code": "WU_005", "message": "自定义字段验证失败", "details": validation_result["errors"]}
                )

        # 更新字段
        if request.version:
            wisunit.version = request.version
        if request.tags is not None:
            wisunit.tags = request.tags
        if request.layer_1:
            wisunit.layer_1 = request.layer_1
        if request.layer_2:
            wisunit.layer_2 = request.layer_2
        if request.layer_3:
            wisunit.layer_3 = request.layer_3
        if request.custom_fields is not None:
            wisunit.custom_fields = request.custom_fields

        wisunit.updated_at = datetime.now()

        # 保存到数据库
        await self._save_wisunit(wisunit)

        return WisUnitResponse(
            status="success",
            data={"wisunit_id": wisunit.id, "version": wisunit.version},
            message="WisUnit更新成功"
        )

    async def _validate_custom_fields(self, custom_fields: Dict[str, Any]) -> Dict[str, Any]:
        """验证自定义字段"""
        # 通过插件验证自定义字段
        validation_errors = []

        # 获取所有已注册的验证规则插件
        validation_plugins = await self.plugin_manager.get_validation_plugins()

        for plugin in validation_plugins:
            result = await plugin.validate(custom_fields)
            if not result["valid"]:
                validation_errors.extend(result.get("errors", []))

        return {
            "valid": len(validation_errors) == 0,
            "errors": validation_errors
        }

    async def _get_wisunit(self, wisunit_id: str) -> Optional[WisUnit]:
        """获取WisUnit"""
        # 实现数据库查询
        pass

    async def _save_wisunit(self, wisunit: WisUnit):
        """保存WisUnit"""
        # 实现数据库保存
        pass
```

---

## 1.2 WisUnit CRUD协议

### 协议名称
WisUnit CRUD Protocol

### 协议描述
定义WisUnit的创建、读取、更新、删除（CRUD）操作协议。支持批量操作、事务处理、版本控制。

### 协议版本
v3.0.0

### 协议变更
- 增强批量操作的支持
- 支持插件化的预处理和后处理
- 支持领域特定的过滤和排序

### 接口定义

```python
from typing import Dict, Any, List, Optional
from pydantic import BaseModel
from datetime import datetime
from enum import Enum

class OperationType(str, Enum):
    CREATE = "create"
    READ = "read"
    UPDATE = "update"
    DELETE = "delete"

class BatchOperationRequest(BaseModel):
    """批量操作请求"""
    operations: List[Dict[str, Any]]
    transaction: bool = False
    stop_on_error: bool = True

class GetWisUnitRequest(BaseModel):
    """获取WisUnit请求"""
    wisunit_id: str
    version: Optional[str] = None
    include_custom_fields: bool = True
    include_audit_log: bool = False

class ListWisUnitRequest(BaseModel):
    """列出WisUnit请求"""
    filters: Dict[str, Any] = {}
    sort_by: Optional[str] = None
    sort_order: str = "asc"
    limit: int = 100
    offset: int = 0
    include_custom_fields: bool = True

class DeleteWisUnitRequest(BaseModel):
    """删除WisUnit请求"""
    wisunit_id: str
    version: Optional[str] = None
    soft_delete: bool = True

class WisUnitCRUDResponse(BaseModel):
    """WisUnit CRUD响应"""
    status: str
    data: Optional[Dict[str, Any]] = None
    message: Optional[str] = None
    error: Optional[Dict[str, Any]] = None
```

### 请求格式（JSON Schema）

```json
{
  "BatchOperationRequest": {
    "type": "object",
    "required": ["operations"],
    "properties": {
      "operations": {
        "type": "array",
        "items": {
          "type": "object",
          "properties": {
            "operation": {"type": "string", "enum": ["create", "read", "update", "delete"]},
            "data": {"type": "object"}
          }
        }
      },
      "transaction": {"type": "boolean"},
      "stop_on_error": {"type": "boolean"}
    }
  },
  "GetWisUnitRequest": {
    "type": "object",
    "required": ["wisunit_id"],
    "properties": {
      "wisunit_id": {"type": "string"},
      "version": {"type": "string"},
      "include_custom_fields": {"type": "boolean"},
      "include_audit_log": {"type": "boolean"}
    }
  },
  "ListWisUnitRequest": {
    "type": "object",
    "properties": {
      "filters": {"type": "object"},
      "sort_by": {"type": "string"},
      "sort_order": {"type": "string", "enum": ["asc", "desc"]},
      "limit": {"type": "integer", "minimum": 1, "maximum": 1000},
      "offset": {"type": "integer", "minimum": 0},
      "include_custom_fields": {"type": "boolean"}
    }
  }
}
```

### 响应格式（JSON Schema）

```json
{
  "WisUnitCRUDResponse": {
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
| `CRUD_001` | WisUnit不存在 | 404 |
| `CRUD_002` | 批量操作失败 | 400 |
| `CRUD_003` | 事务失败 | 500 |
| `CRUD_004` | 过滤器错误 | 400 |
| `CRUD_005` | 版本冲突 | 409 |
| `CRUD_999` | 未知错误 | 500 |

### 示例代码（Python）

```python
from typing import Dict, Any, List, Optional

class WisUnitCRUD:
    """WisUnit CRUD操作"""

    def __init__(self, db_client, plugin_manager):
        self.db = db_client
        self.plugin_manager = plugin_manager

    async def get_wisunit(self, request: GetWisUnitRequest) -> WisUnitCRUDResponse:
        """获取WisUnit"""
        # 获取WisUnit
        wisunit = await self._get_wisunit(request.wisunit_id, request.version)
        if not wisunit:
            return WisUnitCRUDResponse(
                status="error",
                error={"code": "CRUD_001", "message": "WisUnit不存在"}
            )

        # 插件后处理
        processed_wisunit = await self._post_process(wisunit)

        return WisUnitCRUDResponse(
            status="success",
            data=processed_wisunit.dict()
        )

    async def list_wisunits(self, request: ListWisUnitRequest) -> WisUnitCRUDResponse:
        """列出WisUnit"""
        # 插件预处理过滤器
        processed_filters = await self._pre_process_filters(request.filters)

        # 查询WisUnit列表
        wisunits = await self._query_wisunits(
            filters=processed_filters,
            sort_by=request.sort_by,
            sort_order=request.sort_order,
            limit=request.limit,
            offset=request.offset
        )

        # 插件后处理
        processed_wisunits = []
        for wisunit in wisunits:
            processed = await self._post_process(wisunit)
            processed_wisunits.append(processed.dict())

        return WisUnitCRUDResponse(
            status="success",
            data={
                "wisunits": processed_wisunits,
                "total": len(processed_wisunits),
                "limit": request.limit,
                "offset": request.offset
            }
        )

    async def delete_wisunit(self, request: DeleteWisUnitRequest) -> WisUnitCRUDResponse:
        """删除WisUnit"""
        # 获取WisUnit
        wisunit = await self._get_wisunit(request.wisunit_id, request.version)
        if not wisunit:
            return WisUnitCRUDResponse(
                status="error",
                error={"code": "CRUD_001", "message": "WisUnit不存在"}
            )

        if request.soft_delete:
            # 软删除
            wisunit.deleted = True
            wisunit.deleted_at = datetime.now()
            await self._save_wisunit(wisunit)
        else:
            # 硬删除
            await self._hard_delete_wisunit(request.wisunit_id)

        return WisUnitCRUDResponse(
            status="success",
            message="WisUnit删除成功"
        )

    async def batch_operation(self, request: BatchOperationRequest) -> WisUnitCRUDResponse:
        """批量操作"""
        results = []
        transaction = None

        if request.transaction:
            # 开始事务
            transaction = await self.db.begin_transaction()

        try:
            for operation in request.operations:
                op_type = operation.get("operation")
                data = operation.get("data")

                # 插件预处理
                processed_data = await self._pre_process_operation(op_type, data)

                # 执行操作
                if op_type == OperationType.CREATE:
                    result = await self._create_wisunit(processed_data)
                elif op_type == OperationType.UPDATE:
                    result = await self._update_wisunit(processed_data)
                elif op_type == OperationType.DELETE:
                    result = await self._delete_wisunit(processed_data)
                elif op_type == OperationType.READ:
                    result = await self._get_wisunit(processed_data)
                else:
                    result = {"error": "不支持的操作类型"}

                results.append(result)

                if not result.get("success") and request.stop_on_error:
                    raise Exception(f"操作失败: {result.get('error')}")

            if transaction:
                await transaction.commit()

            return WisUnitCRUDResponse(
                status="success",
                data={"results": results, "total": len(results)},
                message="批量操作成功"
            )

        except Exception as e:
            if transaction:
                await transaction.rollback()

            return WisUnitCRUDResponse(
                status="error",
                error={"code": "CRUD_003", "message": f"批量操作失败: {str(e)}"}
            )

    async def _pre_process_filters(self, filters: Dict[str, Any]) -> Dict[str, Any]:
        """插件预处理过滤器"""
        processed_filters = filters.copy()

        # 获取过滤器处理插件
        filter_plugins = await self.plugin_manager.get_filter_plugins()

        for plugin in filter_plugins:
            processed_filters = await plugin.process(processed_filters)

        return processed_filters

    async def _post_process(self, wisunit) -> Any:
        """插件后处理"""
        processed = wisunit

        # 获取后处理插件
        post_process_plugins = await self.plugin_manager.get_post_process_plugins()

        for plugin in post_process_plugins:
            processed = await plugin.process(processed)

        return processed

    async def _get_wisunit(self, wisunit_id: str, version: Optional[str] = None) -> Optional[Any]:
        """获取WisUnit"""
        # 实现数据库查询
        pass

    async def _query_wisunits(self, filters: Dict[str, Any], sort_by: Optional[str],
                              sort_order: str, limit: int, offset: int) -> List[Any]:
        """查询WisUnit列表"""
        # 实现数据库查询
        pass

    async def _save_wisunit(self, wisunit):
        """保存WisUnit"""
        # 实现数据库保存
        pass

    async def _hard_delete_wisunit(self, wisunit_id: str):
        """硬删除WisUnit"""
        # 实现数据库删除
        pass

    async def _create_wisunit(self, data: Dict[str, Any]) -> Dict[str, Any]:
        """创建WisUnit"""
        # 实现创建逻辑
        pass

    async def _update_wisunit(self, data: Dict[str, Any]) -> Dict[str, Any]:
        """更新WisUnit"""
        # 实现更新逻辑
        pass

    async def _delete_wisunit(self, data: Dict[str, Any]) -> Dict[str, Any]:
        """删除WisUnit"""
        # 实现删除逻辑
        pass

    async def _pre_process_operation(self, op_type: str, data: Dict[str, Any]) -> Dict[str, Any]:
        """插件预处理操作"""
        processed_data = data.copy()

        # 获取操作预处理插件
        pre_process_plugins = await self.plugin_manager.get_pre_process_plugins()

        for plugin in pre_process_plugins:
            processed_data = await plugin.process(op_type, processed_data)

        return processed_data
```

---

## 1.3 WisUnit验证协议

### 协议名称
WisUnit Validation Protocol

### 协议描述
定义WisUnit的验证协议，支持插件化的验证规则、验证策略、验证报告。验证规则可以动态注册和执行。

### 协议版本
v3.0.0

### 协议变更
- 支持插件化的验证规则
- 支持动态验证规则注册
- 支持验证规则优先级
- 支持领域特定的验证策略

### 接口定义

```python
from typing import Dict, Any, List, Optional
from pydantic import BaseModel
from datetime import datetime
from enum import Enum

class ValidationSeverity(str, Enum):
    ERROR = "error"
    WARNING = "warning"
    INFO = "info"

class ValidationRuleType(str, Enum):
    REQUIRED = "required"
    PATTERN = "pattern"
    RANGE = "range"
    CUSTOM = "custom"
    PLUGIN = "plugin"

class ValidationRule(BaseModel):
    """验证规则"""
    rule_id: str
    name: str
    type: ValidationRuleType
    target_field: Optional[str] = None
    severity: ValidationSeverity = ValidationSeverity.ERROR
    enabled: bool = True
    priority: int = 0
    config: Dict[str, Any] = {}
    # 支持插件验证
    plugin_id: Optional[str] = None

class ValidationRequest(BaseModel):
    """验证请求"""
    wisunit_id: str
    version: Optional[str] = None
    rules: Optional[List[str]] = None  # 指定验证规则ID列表
    skip_disabled: bool = True
    include_details: bool = True

class ValidationResponse(BaseModel):
    """验证响应"""
    status: str
    valid: bool
    errors: List[Dict[str, Any]] = []
    warnings: List[Dict[str, Any]] = []
    infos: List[Dict[str, Any]] = []
    message: Optional[str] = None
    error: Optional[Dict[str, Any]] = None

class RegisterValidationRuleRequest(BaseModel):
    """注册验证规则请求"""
    rule: ValidationRule
    plugin_id: Optional[str] = None

class WisUnitValidationResponse(BaseModel):
    """WisUnit验证响应"""
    status: str
    data: Optional[Dict[str, Any]] = None
    message: Optional[str] = None
    error: Optional[Dict[str, Any]] = None
```

### 请求格式（JSON Schema）

```json
{
  "ValidationRequest": {
    "type": "object",
    "required": ["wisunit_id"],
    "properties": {
      "wisunit_id": {"type": "string"},
      "version": {"type": "string"},
      "rules": {
        "type": "array",
        "items": {"type": "string"}
      },
      "skip_disabled": {"type": "boolean"},
      "include_details": {"type": "boolean"}
    }
  },
  "ValidationRule": {
    "type": "object",
    "required": ["rule_id", "name", "type"],
    "properties": {
      "rule_id": {"type": "string"},
      "name": {"type": "string"},
      "type": {
        "type": "string",
        "enum": ["required", "pattern", "range", "custom", "plugin"]
      },
      "target_field": {"type": "string"},
      "severity": {
        "type": "string",
        "enum": ["error", "warning", "info"]
      },
      "enabled": {"type": "boolean"},
      "priority": {"type": "integer"},
      "config": {"type": "object"},
      "plugin_id": {"type": "string"}
    }
  },
  "RegisterValidationRuleRequest": {
    "type": "object",
    "required": ["rule"],
    "properties": {
      "rule": {"$ref": "#/definitions/ValidationRule"},
      "plugin_id": {"type": "string"}
    }
  }
}
```

### 响应格式（JSON Schema）

```json
{
  "ValidationResponse": {
    "type": "object",
    "properties": {
      "status": {"type": "string", "enum": ["success", "error"]},
      "valid": {"type": "boolean"},
      "errors": {
        "type": "array",
        "items": {
          "type": "object",
          "properties": {
            "rule_id": {"type": "string"},
            "field": {"type": "string"},
            "message": {"type": "string"}
          }
        }
      },
      "warnings": {
        "type": "array",
        "items": {"type": "object"}
      },
      "infos": {
        "type": "array",
        "items": {"type": "object"}
      },
      "message": {"type": "string"}
    }
  }
}
```

### 错误码定义

| 错误码 | 描述 | HTTP状态码 |
|--------|------|-----------|
| `VAL_001` | WisUnit不存在 | 404 |
| `VAL_002` | 验证规则不存在 | 404 |
| `VAL_003` | 验证规则已存在 | 409 |
| `VAL_004` | 验证失败 | 400 |
| `VAL_005` | 插件验证失败 | 500 |
| `VAL_999` | 未知错误 | 500 |

### 示例代码（Python）

```python
from typing import Dict, Any, List, Optional
from collections import defaultdict

class WisUnitValidator:
    """WisUnit验证器"""

    def __init__(self, db_client, plugin_manager):
        self.db = db_client
        self.plugin_manager = plugin_manager
        self.validation_rules: Dict[str, ValidationRule] = {}

    async def validate(self, request: ValidationRequest) -> ValidationResponse:
        """验证WisUnit"""
        # 获取WisUnit
        wisunit = await self._get_wisunit(request.wisunit_id, request.version)
        if not wisunit:
            return ValidationResponse(
                status="error",
                valid=False,
                error={"code": "VAL_001", "message": "WisUnit不存在"}
            )

        # 获取验证规则
        if request.rules:
            # 使用指定的规则
            rules = [self.validation_rules.get(rule_id) for rule_id in request.rules if rule_id in self.validation_rules]
        else:
            # 使用所有启用的规则
            rules = [rule for rule in self.validation_rules.values() if rule.enabled or not request.skip_disabled]

        # 按优先级排序
        rules.sort(key=lambda r: r.priority)

        # 执行验证
        errors = []
        warnings = []
        infos = []

        for rule in rules:
            result = await self._execute_rule(rule, wisunit)

            if result["severity"] == ValidationSeverity.ERROR:
                errors.append(result)
            elif result["severity"] == ValidationSeverity.WARNING:
                warnings.append(result)
            elif result["severity"] == ValidationSeverity.INFO:
                infos.append(result)

        return ValidationResponse(
            status="success",
            valid=len(errors) == 0,
            errors=errors,
            warnings=warnings,
            infos=infos,
            message=f"验证完成: {len(errors)}个错误, {len(warnings)}个警告, {len(infos)}个信息"
        )

    async def register_rule(self, request: RegisterValidationRuleRequest) -> WisUnitValidationResponse:
        """注册验证规则"""
        # 检查规则是否已存在
        if request.rule.rule_id in self.validation_rules:
            return WisUnitValidationResponse(
                status="error",
                error={"code": "VAL_003", "message": "验证规则已存在"}
            )

        # 如果是插件规则，检查插件是否存在
        if request.rule.type == ValidationRuleType.PLUGIN and request.rule.plugin_id:
            plugin = await self.plugin_manager.get_plugin(request.rule.plugin_id)
            if not plugin:
                return WisUnitValidationResponse(
                    status="error",
                    error={"code": "VAL_002", "message": "插件不存在"}
                )

        # 注册规则
        self.validation_rules[request.rule.rule_id] = request.rule

        # 保存到数据库
        await self._save_validation_rule(request.rule)

        return WisUnitValidationResponse(
            status="success",
            data={"rule_id": request.rule.rule_id},
            message="验证规则注册成功"
        )

    async def _execute_rule(self, rule: ValidationRule, wisunit: Any) -> Dict[str, Any]:
        """执行验证规则"""
        try:
            if rule.type == ValidationRuleType.REQUIRED:
                return await self._validate_required(rule, wisunit)
            elif rule.type == ValidationRuleType.PATTERN:
                return await self._validate_pattern(rule, wisunit)
            elif rule.type == ValidationRuleType.RANGE:
                return await self._validate_range(rule, wisunit)
            elif rule.type == ValidationRuleType.CUSTOM:
                return await self._validate_custom(rule, wisunit)
            elif rule.type == ValidationRuleType.PLUGIN:
                return await self._validate_plugin(rule, wisunit)
            else:
                return {
                    "rule_id": rule.rule_id,
                    "severity": ValidationSeverity.INFO,
                    "message": "未知的规则类型"
                }
        except Exception as e:
            return {
                "rule_id": rule.rule_id,
                "severity": ValidationSeverity.ERROR,
                "message": f"验证规则执行失败: {str(e)}"
            }

    async def _validate_required(self, rule: ValidationRule, wisunit: Any) -> Dict[str, Any]:
        """验证必填字段"""
        if not rule.target_field:
            return {
                "rule_id": rule.rule_id,
                "severity": ValidationSeverity.WARNING,
                "message": "必填规则未指定目标字段"
            }

        field_value = self._get_field_value(wisunit, rule.target_field)
        if field_value is None or field_value == "":
            return {
                "rule_id": rule.rule_id,
                "field": rule.target_field,
                "severity": rule.severity,
                "message": f"字段'{rule.target_field}'是必填的"
            }

        return {
            "rule_id": rule.rule_id,
            "field": rule.target_field,
            "severity": ValidationSeverity.INFO,
            "message": f"字段'{rule.target_field}'验证通过"
        }

    async def _validate_pattern(self, rule: ValidationRule, wisunit: Any) -> Dict[str, Any]:
        """验证模式匹配"""
        if not rule.target_field or "pattern" not in rule.config:
            return {
                "rule_id": rule.rule_id,
                "severity": ValidationSeverity.WARNING,
                "message": "模式规则配置不完整"
            }

        import re
        field_value = self._get_field_value(wisunit, rule.target_field)
        pattern = rule.config["pattern"]

        if not re.match(pattern, str(field_value)):
            return {
                "rule_id": rule.rule_id,
                "field": rule.target_field,
                "severity": rule.severity,
                "message": f"字段'{rule.target_field}'不匹配模式'{pattern}'"
            }

        return {
            "rule_id": rule.rule_id,
            "field": rule.target_field,
            "severity": ValidationSeverity.INFO,
            "message": f"字段'{rule.target_field}'验证通过"
        }

    async def _validate_range(self, rule: ValidationRule, wisunit: Any) -> Dict[str, Any]:
        """验证范围"""
        if not rule.target_field:
            return {
                "rule_id": rule.rule_id,
                "severity": ValidationSeverity.WARNING,
                "message": "范围规则未指定目标字段"
            }

        field_value = self._get_field_value(wisunit, rule.target_field)
        min_val = rule.config.get("min")
        max_val = rule.config.get("max")

        if min_val is not None and field_value < min_val:
            return {
                "rule_id": rule.rule_id,
                "field": rule.target_field,
                "severity": rule.severity,
                "message": f"字段'{rule.target_field}'小于最小值{min_val}"
            }

        if max_val is not None and field_value > max_val:
            return {
                "rule_id": rule.rule_id,
                "field": rule.target_field,
                "severity": rule.severity,
                "message": f"字段'{rule.target_field}'大于最大值{max_val}"
            }

        return {
            "rule_id": rule.rule_id,
            "field": rule.target_field,
            "severity": ValidationSeverity.INFO,
            "message": f"字段'{rule.target_field}'验证通过"
        }

    async def _validate_custom(self, rule: ValidationRule, wisunit: Any) -> Dict[str, Any]:
        """自定义验证"""
        # 从配置中获取自定义验证函数
        validator = rule.config.get("validator")
        if not validator:
            return {
                "rule_id": rule.rule_id,
                "severity": ValidationSeverity.WARNING,
                "message": "自定义验证规则未指定验证函数"
            }

        # 执行自定义验证
        result = validator(wisunit, rule.config)

        if not result["valid"]:
            return {
                "rule_id": rule.rule_id,
                "field": rule.target_field,
                "severity": rule.severity,
                "message": result.get("message", "自定义验证失败")
            }

        return {
            "rule_id": rule.rule_id,
            "field": rule.target_field,
            "severity": ValidationSeverity.INFO,
            "message": result.get("message", "自定义验证通过")
        }

    async def _validate_plugin(self, rule: ValidationRule, wisunit: Any) -> Dict[str, Any]:
        """插件验证"""
        if not rule.plugin_id:
            return {
                "rule_id": rule.rule_id,
                "severity": ValidationSeverity.ERROR,
                "message": "插件规则未指定插件ID"
            }

        # 获取插件
        plugin = await self.plugin_manager.get_plugin(rule.plugin_id)
        if not plugin:
            return {
                "rule_id": rule.rule_id,
                "severity": ValidationSeverity.ERROR,
                "message": f"插件'{rule.plugin_id}'不存在"
            }

        # 执行插件验证
        try:
            result = await plugin.validate(wisunit, rule.config)
            if not result["valid"]:
                return {
                    "rule_id": rule.rule_id,
                    "field": rule.target_field,
                    "severity": rule.severity,
                    "message": result.get("message", "插件验证失败")
                }

            return {
                "rule_id": rule.rule_id,
                "field": rule.target_field,
                "severity": ValidationSeverity.INFO,
                "message": result.get("message", "插件验证通过")
            }
        except Exception as e:
            return {
                "rule_id": rule.rule_id,
                "field": rule.target_field,
                "severity": ValidationSeverity.ERROR,
                "message": f"插件验证失败: {str(e)}"
            }

    def _get_field_value(self, wisunit: Any, field_path: str) -> Any:
        """获取字段值"""
        # 支持点分隔的字段路径，如 "layer_3.title"
        parts = field_path.split(".")
        value = wisunit
        for part in parts:
            if hasattr(value, part):
                value = getattr(value, part)
            elif isinstance(value, dict) and part in value:
                value = value[part]
            else:
                return None
        return value

    async def _get_wisunit(self, wisunit_id: str, version: Optional[str] = None) -> Optional[Any]:
        """获取WisUnit"""
        # 实现数据库查询
        pass

    async def _save_validation_rule(self, rule: ValidationRule):
        """保存验证规则"""
        # 实现数据库保存
        pass
```

---

## 1.4 WisUnit迁移协议

### 协议名称
WisUnit Migration Protocol

### 协议描述
定义WisUnit的版本迁移、数据迁移协议，支持SemVer版本控制和向后兼容性检查。

### 协议版本
v3.0.0

### 协议变更
- 支持插件化的迁移策略
- 支持自定义迁移脚本
- 增强迁移日志记录

### 接口定义

```python
from typing import Dict, Any, Optional, List
from pydantic import BaseModel
from datetime import datetime
from enum import Enum

class MigrationType(str, Enum):
    VERSION = "version"  # 版本迁移
    DATA = "data"  # 数据迁移
    SCHEMA = "schema"  # Schema迁移

class MigrationDirection(str, Enum):
    UPGRADE = "upgrade"  # 升级
    DOWNGRADE = "downgrade"  # 降级

class Compatibility(str, Enum):
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
    # 支持插件迁移
    plugin_id: Optional[str] = None

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
      "migration_type": {
        "type": "string",
        "enum": ["version", "data", "schema"]
      },
      "direction": {
        "type": "string",
        "enum": ["upgrade", "downgrade"]
      },
      "target_version": {"type": "string"},
      "dry_run": {"type": "boolean"},
      "backup": {"type": "boolean"},
      "plugin_id": {"type": "string"}
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
| `MIG_006` | 插件不存在 | 404 |
| `MIG_999` | 未知错误 | 500 |

### 示例代码（Python）

```python
import uuid
import re
from datetime import datetime

class WisUnitMigration:
    """WisUnit迁移系统"""

    def __init__(self, db_client, plugin_manager):
        self.db = db_client
        self.plugin_manager = plugin_manager

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
            if request.plugin_id:
                # 使用插件迁移
                result = await self._plugin_migration(wisunit, request.plugin_id, request.migration_type, request.direction)
            else:
                # 使用标准迁移
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
                "plugin_id": request.plugin_id,
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

    async def _plugin_migration(self, wisunit: Dict[str, Any], plugin_id: str,
                                migration_type: MigrationType, direction: MigrationDirection) -> Dict[str, Any]:
        """插件迁移"""
        # 获取插件
        plugin = await self.plugin_manager.get_plugin(plugin_id)
        if not plugin:
            raise Exception(f"插件'{plugin_id}'不存在")

        # 执行插件迁移
        result = await plugin.migrate(wisunit, {
            "type": migration_type,
            "direction": direction
        })

        return result

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

**文档继续...** （由于篇幅限制，剩余协议将在后续章节中定义）
# WisHub 核心协议文档 v3.0 (续)

---

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

# 5. 知识图谱协议

## 5.1 图数据库接口协议

### 协议名称
Graph Database Interface Protocol

### 协议描述
定义图数据库的接口协议，支持多种图数据库的统一访问。

### 协议版本
v3.0.0

### 协议变更
- 支持插件化的图数据库适配器
- 支持领域特定的图结构

### 接口定义

```python
class GraphDatabaseType(str, Enum):
    NEO4J = "neo4j"  # Neo4j
    ARANGODB = "arangodb"  # ArangoDB
    JANUSGRAPH = "janusgraph"  # JanusGraph
    PLUGIN = "plugin"  # 插件适配

class QueryGraphRequest(BaseModel):
    """查询图请求"""
    query: str
    database_type: GraphDatabaseType = GraphDatabaseType.NEO4J
    parameters: Dict[str, Any] = {}
    plugin_id: Optional[str] = None

class GraphDatabaseResponse(BaseModel):
    """图数据库响应"""
    status: str
    data: Optional[Dict[str, Any]] = None
    message: Optional[str] = None
    error: Optional[Dict[str, Any]] = None
```

### 错误码定义

| 错误码 | 描述 | HTTP状态码 |
|--------|------|-----------|
| `GRAPH_001` | 查询失败 | 500 |
| `GRAPH_002` | 数据库不可达 | 503 |
| `GRAPH_003` | 插件不存在 | 404 |
| `GRAPH_999` | 未知错误 | 500 |

---

## 5.2 知识关联协议

### 协议名称
Knowledge Association Protocol

### 协议描述
定义知识关联的协议，包括关系定义、关联发现、关联推荐。

### 协议版本
v3.0.0

### 协议变更
- 支持插件化的关联规则
- 支持领域特定的关联算法

### 接口定义

```python
class AssociationType(str, Enum):
    SEMANTIC = "semantic"  # 语义关联
    STRUCTURAL = "structural"  # 结构关联
    TEMPORAL = "temporal"  # 时序关联
    PLUGIN = "plugin"  # 插件关联

class CreateAssociationRequest(BaseModel):
    """创建关联请求"""
    source_id: str
    target_id: str
    association_type: AssociationType
    weight: float = 1.0
    plugin_id: Optional[str] = None

class KnowledgeAssociationResponse(BaseModel):
    """知识关联响应"""
    status: str
    data: Optional[Dict[str, Any]] = None
    message: Optional[str] = None
    error: Optional[Dict[str, Any]] = None
```

### 错误码定义

| 错误码 | 描述 | HTTP状态码 |
|--------|------|-----------|
| `KA_001` | 关联创建失败 | 500 |
| `KA_002` | 节点不存在 | 404 |
| `KA_003` | 插件不存在 | 404 |
| `KA_999` | 未知错误 | 500 |

---

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
# WisHub 核心协议文档 v3.0 (续2)

---

# 8. 领域扩展协议

## 8.1 通用领域扩展协议

### 协议名称
Domain Extension Protocol

### 协议描述
定义通用领域扩展机制，包括插件注册、验证规则扩展、数据结构扩展、配置管理。这是v3.0的核心新增协议，用于替代v2.0的领域特定协议（医学、金融、法律、教育）。

### 协议版本
v3.0.0

### 协议变更
- **新增协议**：这是v3.0新增的核心协议
- 提供统一的插件扩展机制
- 支持动态的领域扩展

### 核心原则

1. **通用优先**：核心协议必须是通用的，不针对特定领域
2. **可扩展性**：通过插件机制支持领域扩展
3. **配置驱动**：通过配置而非硬编码支持领域特性
4. **接口抽象**：领域特性通过接口实现

---

### 8.1.1 领域插件注册协议

### 协议名称
Domain Plugin Registration Protocol

### 协议描述
定义领域插件的注册协议，包括插件元数据、依赖声明、生命周期管理。

### 接口定义

```python
from typing import Dict, Any, List, Optional
from pydantic import BaseModel
from datetime import datetime
from enum import Enum

class PluginStatus(str, Enum):
    REGISTERED = "registered"  # 已注册
    ACTIVE = "active"  # 激活
    INACTIVE = "inactive"  # 未激活
    DEPRECATED = "deprecated"  # 已弃用

class PluginType(str, Enum):
    DOMAIN = "domain"  # 领域插件
    VALIDATION = "validation"  # 验证规则插件
    DATA_STRUCTURE = "data_structure"  # 数据结构插件
    STORAGE = "storage"  # 存储策略插件
    SYNC = "sync"  # 同步策略插件
    MIGRATION = "migration"  # 迁移策略插件
    INCENTIVE = "incentive"  # 激励策略插件
    AUTH = "auth"  # 认证插件
    ENCRYPTION = "encryption"  # 加密插件
    AUTHORIZATION = "authorization"  # 权限插件
    ZKP = "zkp"  # 零知识证明插件
    AGENT = "agent"  # Agent插件
    GRAPH = "graph"  # 图数据库插件
    CACHE = "cache"  # 缓存策略插件

class PluginMetadata(BaseModel):
    """插件元数据"""
    plugin_id: str
    name: str
    version: str
    type: PluginType
    description: str
    author: Optional[str] = None
    dependencies: List[str] = []  # 依赖的插件ID
    compatibility: Dict[str, str] = {}  # 兼容性信息
    capabilities: List[str] = []  # 能力列表

class PluginConfig(BaseModel):
    """插件配置"""
    plugin_id: str
    config: Dict[str, Any]
    enabled: bool = True
    priority: int = 0

class RegisterPluginRequest(BaseModel):
    """注册插件请求"""
    metadata: PluginMetadata
    config: PluginConfig
    # 插件的实现接口
    interfaces: Dict[str, Any] = {}

class UnregisterPluginRequest(BaseModel):
    """注销插件请求"""
    plugin_id: str
    force: bool = False

class ActivatePluginRequest(BaseModel):
    """激活插件请求"""
    plugin_id: str
    config_override: Optional[Dict[str, Any]] = None

class DeactivatePluginRequest(BaseModel):
    """停用插件请求"""
    plugin_id: str

class GetPluginRequest(BaseModel):
    """获取插件请求"""
    plugin_id: str
    include_config: bool = True

class ListPluginsRequest(BaseModel):
    """列出插件请求"""
    type: Optional[PluginType] = None
    status: Optional[PluginStatus] = None
    limit: int = 100
    offset: int = 0

class PluginRegistrationResponse(BaseModel):
    """插件注册响应"""
    status: str
    data: Optional[Dict[str, Any]] = None
    message: Optional[str] = None
    error: Optional[Dict[str, Any]] = None
```

### 请求格式（JSON Schema）

```json
{
  "RegisterPluginRequest": {
    "type": "object",
    "required": ["metadata", "config"],
    "properties": {
      "metadata": {
        "$ref": "#/definitions/PluginMetadata"
      },
      "config": {
        "$ref": "#/definitions/PluginConfig"
      },
      "interfaces": {
        "type": "object"
      }
    }
  },
  "PluginMetadata": {
    "type": "object",
    "required": ["plugin_id", "name", "version", "type", "description"],
    "properties": {
      "plugin_id": {"type": "string"},
      "name": {"type": "string"},
      "version": {"type": "string", "pattern": "^[0-9]+\\.[0-9]+\\.[0-9]+$"},
      "type": {
        "type": "string",
        "enum": ["domain", "validation", "data_structure", "storage", "sync", "migration", "incentive", "auth", "encryption", "authorization", "zkp", "agent", "graph", "cache"]
      },
      "description": {"type": "string"},
      "author": {"type": "string"},
      "dependencies": {
        "type": "array",
        "items": {"type": "string"}
      },
      "compatibility": {
        "type": "object"
      },
      "capabilities": {
        "type": "array",
        "items": {"type": "string"}
      }
    }
  },
  "PluginConfig": {
    "type": "object",
    "required": ["plugin_id", "config"],
    "properties": {
      "plugin_id": {"type": "string"},
      "config": {"type": "object"},
      "enabled": {"type": "boolean"},
      "priority": {"type": "integer"}
    }
  }
}
```

### 响应格式（JSON Schema）

```json
{
  "PluginRegistrationResponse": {
    "type": "object",
    "properties": {
      "status": {
        "type": "string",
        "enum": ["success", "error"]
      },
      "data": {
        "type": "object"
      },
      "message": {
        "type": "string"
      },
      "error": {
        "type": "object"
      }
    }
  }
}
```

### 错误码定义

| 错误码 | 描述 | HTTP状态码 |
|--------|------|-----------|
| `PLUGIN_001` | 插件已存在 | 409 |
| `PLUGIN_002` | 插件不存在 | 404 |
| `PLUGIN_003` | 依赖不满足 | 400 |
| `PLUGIN_004` | 注册失败 | 500 |
| `PLUGIN_005` | 激活失败 | 500 |
| `PLUGIN_006` | 停用失败 | 500 |
| `PLUGIN_007` | 接口不兼容 | 400 |
| `PLUGIN_999` | 未知错误 | 500 |

### 示例代码（Python）

```python
from typing import Dict, Any, List, Optional
import asyncio

class PluginManager:
    """插件管理器"""

    def __init__(self, db_client):
        self.db = db_client
        self.plugins: Dict[str, Dict[str, Any]] = {}
        self.plugin_instances: Dict[str, Any] = {}

    async def register_plugin(self, request: RegisterPluginRequest) -> PluginRegistrationResponse:
        """注册插件"""
        # 检查插件是否已存在
        if request.metadata.plugin_id in self.plugins:
            return PluginRegistrationResponse(
                status="error",
                error={"code": "PLUGIN_001", "message": "插件已存在"}
            )

        # 检查依赖
        for dep_id in request.metadata.dependencies:
            if dep_id not in self.plugins:
                return PluginRegistrationResponse(
                    status="error",
                    error={"code": "PLUGIN_003", "message": f"依赖'{dep_id}'不存在"}
                )

        # 注册插件
        self.plugins[request.metadata.plugin_id] = {
            "metadata": request.metadata.dict(),
            "config": request.config.dict(),
            "interfaces": request.interfaces,
            "status": PluginStatus.REGISTERED,
            "registered_at": datetime.now()
        }

        # 保存到数据库
        await self._save_plugin(self.plugins[request.metadata.plugin_id])

        return PluginRegistrationResponse(
            status="success",
            data={"plugin_id": request.metadata.plugin_id},
            message="插件注册成功"
        )

    async def activate_plugin(self, request: ActivatePluginRequest) -> PluginRegistrationResponse:
        """激活插件"""
        plugin = self.plugins.get(request.plugin_id)
        if not plugin:
            return PluginRegistrationResponse(
                status="error",
                error={"code": "PLUGIN_002", "message": "插件不存在"}
            )

        # 覆盖配置（如果提供）
        if request.config_override:
            plugin["config"]["config"].update(request.config_override)

        # 实例化插件
        try:
            plugin_instance = self._instantiate_plugin(plugin)
            self.plugin_instances[request.plugin_id] = plugin_instance

            # 调用插件的初始化方法
            if hasattr(plugin_instance, "initialize"):
                await plugin_instance.initialize(plugin["config"]["config"])

            plugin["status"] = PluginStatus.ACTIVE
            plugin["activated_at"] = datetime.now()

            # 保存到数据库
            await self._save_plugin(plugin)

            return PluginRegistrationResponse(
                status="success",
                data={"plugin_id": request.plugin_id},
                message="插件激活成功"
            )

        except Exception as e:
            return PluginRegistrationResponse(
                status="error",
                error={"code": "PLUGIN_005", "message": f"激活失败: {str(e)}"}
            )

    async def deactivate_plugin(self, request: DeactivatePluginRequest) -> PluginRegistrationResponse:
        """停用插件"""
        plugin = self.plugins.get(request.plugin_id)
        if not plugin:
            return PluginRegistrationResponse(
                status="error",
                error={"code": "PLUGIN_002", "message": "插件不存在"}
            )

        # 调用插件的清理方法
        if request.plugin_id in self.plugin_instances:
            plugin_instance = self.plugin_instances[request.plugin_id]
            if hasattr(plugin_instance, "cleanup"):
                await plugin_instance.cleanup()
            del self.plugin_instances[request.plugin_id]

        plugin["status"] = PluginStatus.INACTIVE
        plugin["deactivated_at"] = datetime.now()

        # 保存到数据库
        await self._save_plugin(plugin)

        return PluginRegistrationResponse(
            status="success",
            data={"plugin_id": request.plugin_id},
            message="插件停用成功"
        )

    async def get_plugin(self, request: GetPluginRequest) -> PluginRegistrationResponse:
        """获取插件"""
        plugin = self.plugins.get(request.plugin_id)
        if not plugin:
            return PluginRegistrationResponse(
                status="error",
                error={"code": "PLUGIN_002", "message": "插件不存在"}
            )

        response_data = {
            "metadata": plugin["metadata"],
            "status": plugin["status"],
            "registered_at": plugin["registered_at"]
        }

        if request.include_config:
            response_data["config"] = plugin["config"]

        return PluginRegistrationResponse(
            status="success",
            data=response_data
        )

    async def list_plugins(self, request: ListPluginsRequest) -> PluginRegistrationResponse:
        """列出插件"""
        plugins = []

        for plugin_id, plugin in self.plugins.items():
            # 过滤
            if request.type and plugin["metadata"]["type"] != request.type.value:
                continue
            if request.status and plugin["status"] != request.status.value:
                continue

            plugins.append({
                "plugin_id": plugin_id,
                "name": plugin["metadata"]["name"],
                "type": plugin["metadata"]["type"],
                "status": plugin["status"]
            })

        # 分页
        total = len(plugins)
        plugins = plugins[request.offset:request.offset + request.limit]

        return PluginRegistrationResponse(
            status="success",
            data={
                "plugins": plugins,
                "total": total,
                "offset": request.offset,
                "limit": request.limit
            }
        )

    def _instantiate_plugin(self, plugin: Dict[str, Any]) -> Any:
        """实例化插件"""
        # 这里简化实现，实际应该根据插件类型实例化不同的插件类
        # 例如：领域插件、验证规则插件等
        return MockPlugin(plugin["metadata"]["plugin_id"])

    async def _save_plugin(self, plugin: Dict[str, Any]):
        """保存插件"""
        # 实现数据库保存
        pass


class MockPlugin:
    """模拟插件类"""

    def __init__(self, plugin_id: str):
        self.plugin_id = plugin_id

    async def initialize(self, config: Dict[str, Any]):
        """初始化插件"""
        print(f"插件 {self.plugin_id} 初始化")

    async def cleanup(self):
        """清理插件"""
        print(f"插件 {self.plugin_id} 清理")

    async def validate(self, data: Dict[str, Any], config: Dict[str, Any]) -> Dict[str, Any]:
        """验证数据"""
        return {"valid": True, "message": "验证通过"}

    async def migrate(self, data: Dict[str, Any], config: Dict[str, Any]) -> Dict[str, Any]:
        """迁移数据"""
        return data

    async def process(self, data: Dict[str, Any]) -> Dict[str, Any]:
        """处理数据"""
        return data
```

---

### 8.1.2 领域验证规则扩展协议

### 协议名称
Domain Validation Rule Extension Protocol

### 协议描述
定义领域验证规则的扩展协议，支持动态注册验证规则、验证规则优先级、验证规则执行。

### 接口定义

```python
class ValidationRuleScope(str, Enum):
    WISUNIT = "wisunit"  # WisUnit验证
    FIELD = "field"  # 字段验证
    RELATION = "relation"  # 关系验证
    CUSTOM = "custom"  # 自定义验证

class RegisterValidationRuleRequest(BaseModel):
    """注册验证规则请求"""
    rule_id: str
    name: str
    description: str
    scope: ValidationRuleScope
    plugin_id: str
    config: Dict[str, Any] = {}
    priority: int = 0
    enabled: bool = True

class ExecuteValidationRuleRequest(BaseModel):
    """执行验证规则请求"""
    rule_id: str
    data: Dict[str, Any]
    config_override: Optional[Dict[str, Any]] = None

class ValidationRuleExtensionResponse(BaseModel):
    """验证规则扩展响应"""
    status: str
    data: Optional[Dict[str, Any]] = None
    message: Optional[str] = None
    error: Optional[Dict[str, Any]] = None
```

### 错误码定义

| 错误码 | 描述 | HTTP状态码 |
|--------|------|-----------|
| `VRE_001` | 验证规则已存在 | 409 |
| `VRE_002` | 验证规则不存在 | 404 |
| `VRE_003` | 插件不存在 | 404 |
| `VRE_004` | 验证失败 | 400 |
| `VRE_999` | 未知错误 | 500 |

### 示例代码（Python）

```python
class ValidationRuleManager:
    """验证规则管理器"""

    def __init__(self, db_client, plugin_manager):
        self.db = db_client
        self.plugin_manager = plugin_manager
        self.validation_rules: Dict[str, Dict[str, Any]] = {}

    async def register_validation_rule(self, request: RegisterValidationRuleRequest) -> ValidationRuleExtensionResponse:
        """注册验证规则"""
        # 检查验证规则是否已存在
        if request.rule_id in self.validation_rules:
            return ValidationRuleExtensionResponse(
                status="error",
                error={"code": "VRE_001", "message": "验证规则已存在"}
            )

        # 检查插件是否存在
        plugin = await self.plugin_manager.get_plugin(GetPluginRequest(plugin_id=request.plugin_id))
        if plugin.status != "success":
            return ValidationRuleExtensionResponse(
                status="error",
                error={"code": "VRE_003", "message": "插件不存在"}
            )

        # 注册验证规则
        self.validation_rules[request.rule_id] = {
            "rule_id": request.rule_id,
            "name": request.name,
            "description": request.description,
            "scope": request.scope,
            "plugin_id": request.plugin_id,
            "config": request.config,
            "priority": request.priority,
            "enabled": request.enabled,
            "registered_at": datetime.now()
        }

        # 保存到数据库
        await self._save_validation_rule(self.validation_rules[request.rule_id])

        return ValidationRuleExtensionResponse(
            status="success",
            data={"rule_id": request.rule_id},
            message="验证规则注册成功"
        )

    async def execute_validation_rule(self, request: ExecuteValidationRuleRequest) -> ValidationRuleExtensionResponse:
        """执行验证规则"""
        rule = self.validation_rules.get(request.rule_id)
        if not rule:
            return ValidationRuleExtensionResponse(
                status="error",
                error={"code": "VRE_002", "message": "验证规则不存在"}
            )

        if not rule["enabled"]:
            return ValidationRuleExtensionResponse(
                status="error",
                error={"code": "VRE_004", "message": "验证规则未启用"}
            )

        # 获取插件实例
        plugin_instance = self.plugin_manager.plugin_instances.get(rule["plugin_id"])
        if not plugin_instance:
            return ValidationRuleExtensionResponse(
                status="error",
                error={"code": "VRE_003", "message": "插件实例不存在"}
            )

        # 执行验证
        try:
            config = request.config_override or rule["config"]
            result = await plugin_instance.validate(request.data, config)

            return ValidationRuleExtensionResponse(
                status="success",
                data=result
            )

        except Exception as e:
            return ValidationRuleExtensionResponse(
                status="error",
                error={"code": "VRE_004", "message": f"验证失败: {str(e)}"}
            )

    async def _save_validation_rule(self, rule: Dict[str, Any]):
        """保存验证规则"""
        # 实现数据库保存
        pass
```

---

### 8.1.3 领域数据结构扩展协议

### 协议名称
Domain Data Structure Extension Protocol

### 协议描述
定义领域数据结构的扩展协议，支持动态注册自定义数据类型、数据结构验证、数据结构转换。

### 接口定义

```python
class DataTypeCategory(str, Enum):
    PRIMITIVE = "primitive"  # 基本类型
    COMPOSITE = "composite"  # 复合类型
    ENUM = "enum"  # 枚举类型
    CUSTOM = "custom"  # 自定义类型

class RegisterDataTypeRequest(BaseModel):
    """注册数据类型请求"""
    type_id: str
    name: str
    category: DataTypeCategory
    plugin_id: str
    schema: Dict[str, Any]
    validation_rules: List[str] = []  # 关联的验证规则ID
    enabled: bool = True

class ValidateDataStructureRequest(BaseModel):
    """验证数据结构请求"""
    type_id: str
    data: Dict[str, Any]

class DataStructureExtensionResponse(BaseModel):
    """数据结构扩展响应"""
    status: str
    data: Optional[Dict[str, Any]] = None
    message: Optional[str] = None
    error: Optional[Dict[str, Any]] = None
```

### 错误码定义

| 错误码 | 描述 | HTTP状态码 |
|--------|------|-----------|
| `DSE_001` | 数据类型已存在 | 409 |
| `DSE_002` | 数据类型不存在 | 404 |
| `DSE_003` | 插件不存在 | 404 |
| `DSE_004` | 数据结构验证失败 | 400 |
| `DSE_999` | 未知错误 | 500 |

### 示例代码（Python）

```python
class DataStructureManager:
    """数据结构管理器"""

    def __init__(self, db_client, plugin_manager, validation_rule_manager):
        self.db = db_client
        self.plugin_manager = plugin_manager
        self.validation_rule_manager = validation_rule_manager
        self.data_types: Dict[str, Dict[str, Any]] = {}

    async def register_data_type(self, request: RegisterDataTypeRequest) -> DataStructureExtensionResponse:
        """注册数据类型"""
        # 检查数据类型是否已存在
        if request.type_id in self.data_types:
            return DataStructureExtensionResponse(
                status="error",
                error={"code": "DSE_001", "message": "数据类型已存在"}
            )

        # 检查插件是否存在
        plugin = await self.plugin_manager.get_plugin(GetPluginRequest(plugin_id=request.plugin_id))
        if plugin.status != "success":
            return DataStructureExtensionResponse(
                status="error",
                error={"code": "DSE_003", "message": "插件不存在"}
            )

        # 检查验证规则是否存在
        for rule_id in request.validation_rules:
            if rule_id not in self.validation_rule_manager.validation_rules:
                return DataStructureExtensionResponse(
                    status="error",
                    error={"code": "DSE_004", "message": f"验证规则'{rule_id}'不存在"}
                )

        # 注册数据类型
        self.data_types[request.type_id] = {
            "type_id": request.type_id,
            "name": request.name,
            "category": request.category,
            "plugin_id": request.plugin_id,
            "schema": request.schema,
            "validation_rules": request.validation_rules,
            "enabled": request.enabled,
            "registered_at": datetime.now()
        }

        # 保存到数据库
        await self._save_data_type(self.data_types[request.type_id])

        return DataStructureExtensionResponse(
            status="success",
            data={"type_id": request.type_id},
            message="数据类型注册成功"
        )

    async def validate_data_structure(self, request: ValidateDataStructureRequest) -> DataStructureExtensionResponse:
        """验证数据结构"""
        data_type = self.data_types.get(request.type_id)
        if not data_type:
            return DataStructureExtensionResponse(
                status="error",
                error={"code": "DSE_002", "message": "数据类型不存在"}
            )

        if not data_type["enabled"]:
            return DataStructureExtensionResponse(
                status="error",
                error={"code": "DSE_004", "message": "数据类型未启用"}
            )

        # 验证Schema
        schema_valid = self._validate_schema(request.data, data_type["schema"])
        if not schema_valid:
            return DataStructureExtensionResponse(
                status="error",
                error={"code": "DSE_004", "message": "Schema验证失败"}
            )

        # 执行验证规则
        for rule_id in data_type["validation_rules"]:
            rule_result = await self.validation_rule_manager.execute_validation_rule(
                ExecuteValidationRuleRequest(rule_id=rule_id, data=request.data)
            )

            if rule_result.status != "success" or not rule_result.data.get("valid"):
                return DataStructureExtensionResponse(
                    status="error",
                    error={"code": "DSE_004", "message": f"验证规则'{rule_id}'执行失败"}
                )

        return DataStructureExtensionResponse(
            status="success",
            data={"valid": True},
            message="数据结构验证通过"
        )

    def _validate_schema(self, data: Dict[str, Any], schema: Dict[str, Any]) -> bool:
        """验证Schema"""
        # 简化实现，实际应该使用完整的Schema验证库
        # 例如：jsonschema
        return True

    async def _save_data_type(self, data_type: Dict[str, Any]):
        """保存数据类型"""
        # 实现数据库保存
        pass
```

---

### 8.1.4 通用领域配置协议

### 协议名称
Universal Domain Configuration Protocol

### 协议描述
定义通用领域配置的协议，支持配置项定义、配置验证、配置动态更新。

### 接口定义

```python
class ConfigItemType(str, Enum):
    STRING = "string"  # 字符串
    NUMBER = "number"  # 数字
    BOOLEAN = "boolean"  # 布尔值
    OBJECT = "object"  # 对象
    ARRAY = "array"  # 数组
    ENUM = "enum"  # 枚举

class ConfigItem(BaseModel):
    """配置项"""
    key: str
    name: str
    description: str
    type: ConfigItemType
    default_value: Any
    required: bool = False
    validation: Optional[Dict[str, Any]] = None  # 验证规则

class UpdateDomainConfigRequest(BaseModel):
    """更新领域配置请求"""
    domain_id: str
    config: Dict[str, Any]
    plugin_id: Optional[str] = None

class GetDomainConfigRequest(BaseModel):
    """获取领域配置请求"""
    domain_id: str
    plugin_id: Optional[str] = None

class DomainConfigResponse(BaseModel):
    """领域配置响应"""
    status: str
    data: Optional[Dict[str, Any]] = None
    message: Optional[str] = None
    error: Optional[Dict[str, Any]] = None
```

### 错误码定义

| 错误码 | 描述 | HTTP状态码 |
|--------|------|-----------|
| `DC_001` | 配置项无效 | 400 |
| `DC_002` | 配置不存在 | 404 |
| `DC_003` | 配置验证失败 | 400 |
| `DC_004` | 插件不存在 | 404 |
| `DC_999` | 未知错误 | 500 |

### 示例代码（Python）

```python
class DomainConfigManager:
    """领域配置管理器"""

    def __init__(self, db_client, plugin_manager):
        self.db = db_client
        self.plugin_manager = plugin_manager
        self.domain_configs: Dict[str, Dict[str, Any]] = {}
        self.config_schemas: Dict[str, List[ConfigItem]] = {}

    def register_config_schema(self, domain_id: str, config_items: List[ConfigItem]):
        """注册配置Schema"""
        self.config_schemas[domain_id] = config_items

    async def update_domain_config(self, request: UpdateDomainConfigRequest) -> DomainConfigResponse:
        """更新领域配置"""
        # 如果指定了插件，检查插件是否存在
        if request.plugin_id:
            plugin = await self.plugin_manager.get_plugin(GetPluginRequest(plugin_id=request.plugin_id))
            if plugin.status != "success":
                return DomainConfigResponse(
                    status="error",
                    error={"code": "DC_004", "message": "插件不存在"}
                )

        # 获取配置Schema
        config_schema = self.config_schemas.get(request.domain_id, [])
        if not config_schema:
            # 如果没有Schema，直接保存
            config_valid = True
        else:
            # 验证配置
            config_valid = self._validate_config(request.config, config_schema)

        if not config_valid:
            return DomainConfigResponse(
                status="error",
                error={"code": "DC_003", "message": "配置验证失败"}
            )

        # 更新配置
        self.domain_configs[request.domain_id] = {
            "domain_id": request.domain_id,
            "config": request.config,
            "plugin_id": request.plugin_id,
            "updated_at": datetime.now()
        }

        # 保存到数据库
        await self._save_domain_config(self.domain_configs[request.domain_id])

        return DomainConfigResponse(
            status="success",
            data={"domain_id": request.domain_id},
            message="领域配置更新成功"
        )

    async def get_domain_config(self, request: GetDomainConfigRequest) -> DomainConfigResponse:
        """获取领域配置"""
        config = self.domain_configs.get(request.domain_id)
        if not config:
            return DomainConfigResponse(
                status="error",
                error={"code": "DC_002", "message": "配置不存在"}
            )

        return DomainConfigResponse(
            status="success",
            data={
                "domain_id": request.domain_id,
                "config": config["config"],
                "updated_at": config["updated_at"]
            }
        )

    def _validate_config(self, config: Dict[str, Any], config_schema: List[ConfigItem]) -> bool:
        """验证配置"""
        for item in config_schema:
            # 检查必填项
            if item.required and item.key not in config:
                return False

            # 检查类型
            if item.key in config:
                if not self._check_type(config[item.key], item.type):
                    return False

            # 执行自定义验证
            if item.validation and item.key in config:
                if not self._execute_validation(config[item.key], item.validation):
                    return False

        return True

    def _check_type(self, value: Any, type: ConfigItemType) -> bool:
        """检查类型"""
        if type == ConfigItemType.STRING:
            return isinstance(value, str)
        elif type == ConfigItemType.NUMBER:
            return isinstance(value, (int, float))
        elif type == ConfigItemType.BOOLEAN:
            return isinstance(value, bool)
        elif type == ConfigItemType.OBJECT:
            return isinstance(value, dict)
        elif type == ConfigItemType.ARRAY:
            return isinstance(value, list)
        elif type == ConfigItemType.ENUM:
            # 枚举验证需要额外的配置
            return True
        return False

    def _execute_validation(self, value: Any, validation: Dict[str, Any]) -> bool:
        """执行自定义验证"""
        # 简化实现
        return True

    async def _save_domain_config(self, config: Dict[str, Any]):
        """保存领域配置"""
        # 实现数据库保存
        pass
```

---

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

# 10. 部署协议

## 10.1 配置协议

### 协议名称
Configuration Protocol

### 协议描述
定义系统配置的协议，包括配置项管理、配置验证、配置热更新。

### 协议版本
v3.0.0

### 协议变更
- 支持插件化的配置验证
- 支持领域特定的配置项

### 接口定义

```python
class ConfigScope(str, Enum):
    GLOBAL = "global"  # 全局配置
    DOMAIN = "domain"  # 领域配置
    PLUGIN = "plugin"  # 插件配置

class UpdateConfigRequest(BaseModel):
    """更新配置请求"""
    scope: ConfigScope
    key: str
    value: Any
    plugin_id: Optional[str] = None

class GetConfigRequest(BaseModel):
    """获取配置请求"""
    scope: ConfigScope
    key: str
    plugin_id: Optional[str] = None

class ConfigResponse(BaseModel):
    """配置响应"""
    status: str
    data: Optional[Dict[str, Any]] = None
    message: Optional[str] = None
    error: Optional[Dict[str, Any]] = None
```

### 错误码定义

| 错误码 | 描述 | HTTP状态码 |
|--------|------|-----------|
| `CFG_001` | 配置项不存在 | 404 |
| `CFG_002` | 配置验证失败 | 400 |
| `CFG_003` | 配置更新失败 | 500 |
| `CFG_004` | 插件不存在 | 404 |
| `CFG_999` | 未知错误 | 500 |

---

## 10.2 监控协议

### 协议名称
Monitoring Protocol

### 协议描述
定义系统监控的协议，包括指标收集、告警规则、监控报告。

### 协议版本
v3.0.0

### 协议变更
- 支持插件化的监控指标
- 支持领域特定的监控规则

### 接口定义

```python
class MetricType(str, Enum):
    COUNTER = "counter"  # 计数器
    GAUGE = "gauge"  # 仪表
    HISTOGRAM = "histogram"  # 直方图
    SUMMARY = "summary"  # 摘要
    PLUGIN = "plugin"  # 插件指标

class ReportMetricRequest(BaseModel):
    """上报指标请求"""
    metric_name: str
    metric_type: MetricType
    value: float
    labels: Dict[str, str] = {}
    plugin_id: Optional[str] = None

class GetMetricsRequest(BaseModel):
    """获取指标请求"""
    metric_name: Optional[str] = None
    start_time: Optional[datetime] = None
    end_time: Optional[datetime] = None
    labels: Dict[str, str] = {}

class MonitoringResponse(BaseModel):
    """监控响应"""
    status: str
    data: Optional[Dict[str, Any]] = None
    message: Optional[str] = None
    error: Optional[Dict[str, Any]] = None
```

### 错误码定义

| 错误码 | 描述 | HTTP状态码 |
|--------|------|-----------|
| `MON_001` | 指标不存在 | 404 |
| `MON_002` | 指标上报失败 | 500 |
| `MON_003` | 插件不存在 | 404 |
| `MON_999` | 未知错误 | 500 |

---

## 10.3 备份协议

### 协议名称
Backup Protocol

### 协议描述
定义数据备份的协议，包括备份策略、备份执行、备份恢复。

### 协议版本
v3.0.0

### 协议变更
- 支持插件化的备份策略
- 支持领域特定的备份规则

### 接口定义

```python
class BackupType(str, Enum):
    FULL = "full"  # 全量备份
    INCREMENTAL = "incremental"  # 增量备份
    DIFFERENTIAL = "differential"  # 差异备份
    PLUGIN = "plugin"  # 插件备份

class CreateBackupRequest(BaseModel):
    """创建备份请求"""
    backup_id: str
    backup_type: BackupType
    targets: List[str]  # 备份目标
    plugin_id: Optional[str] = None

class RestoreBackupRequest(BaseModel):
    """恢复备份请求"""
    backup_id: str
    targets: Optional[List[str]] = None

class BackupResponse(BaseModel):
    """备份响应"""
    status: str
    data: Optional[Dict[str, Any]] = None
    message: Optional[str] = None
    error: Optional[Dict[str, Any]] = None
```

### 错误码定义

| 错误码 | 描述 | HTTP状态码 |
|--------|------|-----------|
| `BK_001` | 备份不存在 | 404 |
| `BK_002` | 备份失败 | 500 |
| `BK_003` | 恢复失败 | 500 |
| `BK_004` | 插件不存在 | 404 |
| `BK_999` | 未知错误 | 500 |

---

# 附录

## A. 协议版本对比

| 版本 | 协议总数 | 通用协议 | 领域协议 | 扩展协议 |
|------|---------|---------|---------|---------|
| v1.0.0 | 32 | 28 | 4 | 0 |
| v2.0.0 | 36 | 32 | 4 | 0 |
| v3.0.0 | 32 | 31 | 0 | 1 |

## B. 协议分类统计

### 通用协议（31个）
1. WisUnit协议（4个）
2. WISE协议系统（6个）
3. 智核协议（4个）
4. Agent协议（5个）
5. 知识图谱协议（2个）
6. 通信协议（3个）
7. 安全协议（4个）
8. 经济模型协议（3个）

### 扩展协议（1个）
8. 领域扩展协议（1个）- **新增**

### 部署协议（3个）
9. 部署协议（3个）

## C. 移除的协议

| 协议编号 | 协议名称 | 移除原因 |
|---------|---------|---------|
| 8.1 | 医学领域协议 | 领域特定性强，已通过插件机制替代 |
| 8.2 | 金融领域协议 | 领域特定性强，已通过插件机制替代 |
| 8.3 | 法律领域协议 | 领域特定性强，已通过插件机制替代 |
| 8.4 | 教育领域协议 | 领域特定性强，已通过插件机制替代 |

## D. 新增的协议

| 协议编号 | 协议名称 | 协议类型 |
|---------|---------|---------|
| 8.1 | 通用领域扩展协议 | 扩展协议 |

**文档版本**: v3.0.0
**协议总数**: 32个
**通用协议**: 31个
**扩展协议**: 1个
**最后更新**: 2026年2月23日

---

**文档编制**: WisHub协议改进团队
**文档审核**: 18位专家
**文档批准**: WisHub技术委员会

---

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

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

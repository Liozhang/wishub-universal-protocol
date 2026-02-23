# WisHub 核心协议文档

**项目名称**：WisHub 核心协议
**版本**：v1.0.0
**发布日期**：2026年2月23日
**文档类型**：协议规范

---

## 目录

1. [WisUnit协议](#1-wisunit协议)
   - 1.1 WisUnit数据模型协议
   - 1.2 WisUnit CRUD协议
   - 1.3 WisUnit验证协议
2. [WISE协议系统](#2-wise协议系统)
   - 2.1 WisStore协议
   - 2.2 WisSync协议
   - 2.3 WisVerify协议
   - 2.4 WisIncentive协议
   - 2.5 WisDedup协议
3. [智核协议](#3-智核协议)
   - 3.1 智核生成协议
   - 3.2 智核进化协议
   - 3.3 智核验证协议
4. [Agent协议](#4-agent协议)
   - 4.1 Agent注册协议
   - 4.2 Agent调用协议
   - 4.3 Agent类型协议
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
8. [领域协议](#8-领域协议)
   - 8.1 医学领域协议
   - 8.2 金融领域协议
   - 8.3 法律领域协议
   - 8.4 教育领域协议
9. [经济模型协议](#9-经济模型协议)
   - 9.1 信用协议
   - 9.2 赏金协议
   - 9.3 汇率协议
10. [部署协议](#10-部署协议)
    - 10.1 配置协议
    - 10.2 监控协议
    - 10.3 备份协议

---

# 1. WisUnit协议

## 1.1 WisUnit数据模型协议

### 协议名称
WisUnit Data Model Protocol

### 协议描述
定义WisUnit（知识单元）的三层架构数据模型，包括可执行层、结构化层和自然语言层。

### 协议版本
v1.0.0

### 接口定义

```python
from typing import Dict, Any, List, Optional
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

class WisUnitLayer2(BaseModel):
    """结构化层：程序、系统可处理的知识"""
    type: LayerType = LayerType.STRUCTURED
    metadata: Dict[str, Any]
    schema: Dict[str, Any]
    relations: List[Dict[str, Any]] = []
    dependencies: List[str] = []

class WisUnitLayer3(BaseModel):
    """自然语言层：人类可理解的知识"""
    type: LayerType = LayerType.NATURAL_LANGUAGE
    title: str
    description: str
    explanation: Optional[str] = None
    examples: List[Dict[str, Any]] = []
    references: List[Dict[str, Any]] = []

class PartitionKey(BaseModel):
    """分区键"""
    geo: str
    user: int
    domain: str
    data_type: str

class AuditLog(BaseModel):
    """审计日志"""
    created_at: datetime
    created_by: str
    signature: Optional[str] = None
    blockchain_tx: Optional[str] = None

class WisUnit(BaseModel):
    """WisUnit完整数据模型"""
    id: str
    version: str
    created_at: datetime
    updated_at: datetime
    created_by: str
    domain: str
    tags: List[str] = []
    layer_1: WisUnitLayer1
    layer_2: WisUnitLayer2
    layer_3: WisUnitLayer3
    partition_key: Optional[PartitionKey] = None
    audit_log: Optional[AuditLog] = None
```

### 请求格式（JSON Schema）

```json
{
  "$schema": "http://json-schema.org/draft-07/schema#",
  "title": "WisUnitCreateRequest",
  "type": "object",
  "required": ["id", "version", "created_by", "domain", "layer_1", "layer_2", "layer_3"],
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
      "type": "string",
      "enum": ["medical", "education", "research", "engineering", "legal", "finance", "game"]
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
    }
  },
  "definitions": {
    "Layer1": {
      "type": "object",
      "properties": {
        "type": {
          "type": "string",
          "enum": ["executable"]
        },
        "code": {
          "type": "object",
          "properties": {
            "language": {"type": "string"},
            "content": {"type": "string"}
          }
        },
        "model": {
          "type": "object",
          "properties": {
            "type": {"type": "string"},
            "path": {"type": "string"},
            "version": {"type": "string"}
          }
        },
        "agent_api": {
          "type": "object",
          "properties": {
            "endpoint": {"type": "string"},
            "input_schema": {"type": "object"},
            "output_schema": {"type": "object"}
          }
        }
      }
    },
    "Layer2": {
      "type": "object",
      "properties": {
        "type": {"type": "string", "enum": ["structured"]},
        "metadata": {"type": "object"},
        "schema": {"type": "object"},
        "relations": {"type": "array"},
        "dependencies": {"type": "array", "items": {"type": "string"}}
      }
    },
    "Layer3": {
      "type": "object",
      "properties": {
        "type": {"type": "string", "enum": ["natural_language"]},
        "title": {"type": "string"},
        "description": {"type": "string"},
        "explanation": {"type": "string"},
        "examples": {"type": "array"},
        "references": {"type": "array"}
      }
    }
  }
}
```

### 响应格式（JSON Schema）

```json
{
  "$schema": "http://json-schema.org/draft-07/schema#",
  "title": "WisUnitCreateResponse",
  "type": "object",
  "properties": {
    "status": {
      "type": "string",
      "enum": ["created", "error"]
    },
    "wisunit_id": {
      "type": "string"
    },
    "version": {
      "type": "string"
    },
    "created_at": {
      "type": "string",
      "format": "date-time"
    },
    "message": {
      "type": "string"
    },
    "error": {
      "type": "object",
      "properties": {
        "code": {"type": "string"},
        "message": {"type": "string"}
      }
    }
  }
}
```

### 错误码定义

| 错误码 | 描述 | HTTP状态码 |
|--------|------|-----------|
| `WU_001` | WisUnit ID格式错误 | 400 |
| `WU_002` | Version格式错误 | 400 |
| `WU_003` | Domain不支持的领域 | 400 |
| `WU_004` | Layer1验证失败 | 400 |
| `WU_005` | Layer2验证失败 | 400 |
| `WU_006` | Layer3验证失败 | 400 |
| `WU_007` | 循环依赖检测 | 400 |
| `WU_008` | WisUnit已存在 | 409 |
| `WU_999` | 未知错误 | 500 |

### 示例代码（Python）

```python
from app.models import WisUnit, WisUnitLayer1, WisUnitLayer2, WisUnitLayer3
from datetime import datetime
import json

# 创建WisUnit示例
def create_wisunit_example():
    wisunit = WisUnit(
        id="ku_20260223_001",
        version="1.0.0",
        created_at=datetime.now(),
        updated_at=datetime.now(),
        created_by="user_001",
        domain="medical",
        tags=["diabetes", "endocrinology", "diagnosis"],
        layer_1=WisUnitLayer1(
            type="executable",
            code={
                "language": "python",
                "content": "def diagnose_diabetes(patient_data):\n    return diagnosis"
            },
            model={
                "type": "sklearn",
                "path": "models/diabetes_model_v2.pkl",
                "version": "2.0.0"
            },
            agent_api={
                "endpoint": "/api/v1/agent/ku_20260223_001",
                "input_schema": {
                    "type": "object",
                    "properties": {
                        "patient_data": {"type": "object"}
                    }
                },
                "output_schema": {
                    "type": "object",
                    "properties": {
                        "diagnosis": {"type": "string"},
                        "confidence": {"type": "number"}
                    }
                }
            }
        ),
        layer_2=WisUnitLayer2(
            type="structured",
            metadata={
                "title": "糖尿病诊断算法",
                "description": "基于血糖水平和HbA1c的糖尿病诊断算法",
                "specialty": "endocrinology",
                "accuracy": 0.92,
                "recall": 0.88,
                "precision": 0.90
            },
            schema={
                "version": "1.0.0",
                "fields": [
                    {"name": "patient_id", "type": "string", "required": True},
                    {"name": "fasting_blood_glucose", "type": "float", "unit": "mmol/L"},
                    {"name": "hba1c", "type": "float", "unit": "%"}
                ]
            },
            relations=[
                {"type": "depends_on", "target": "ku_20260101_blood_glucose"},
                {"type": "cites", "target": "ku_20260101_diabetes_guidelines"}
            ],
            dependencies=["ku_20260101_blood_glucose", "ku_20260101_hba1c"]
        ),
        layer_3=WisUnitLayer3(
            type="natural_language",
            title="2型糖尿病诊断算法",
            description="基于血糖水平和HbA1c的糖尿病诊断算法，用于辅助临床决策。",
            explanation="诊断标准：空腹血糖≥7.0 mmol/L 或 HbA1c≥6.5% 确诊为糖尿病。",
            examples=[
                {
                    "input": {"fasting_blood_glucose": 7.5, "hba1c": 6.8},
                    "output": "diabetes",
                    "confidence": 0.95
                }
            ],
            references=[
                {"type": "guideline", "title": "ADA糖尿病诊疗指南", "year": 2023},
                {"type": "paper", "title": "Diabetes mellitus diagnosis", "journal": "Lancet", "year": 2022}
            ]
        )
    )
    return wisunit

# 验证WisUnit
def validate_wisunit(wisunit: WisUnit) -> dict:
    """验证WisUnit"""
    try:
        # 验证ID格式
        if not wisunit.id.startswith("ku_"):
            return {"status": "error", "code": "WU_001", "message": "WisUnit ID格式错误"}

        # 验证版本格式
        version_parts = wisunit.version.split(".")
        if len(version_parts) != 3:
            return {"status": "error", "code": "WU_002", "message": "Version格式错误"}

        # 验证domain
        valid_domains = ["medical", "education", "research", "engineering", "legal", "finance", "game"]
        if wisunit.domain not in valid_domains:
            return {"status": "error", "code": "WU_003", "message": "Domain不支持的领域"}

        # 验证三层完整性
        if wisunit.layer_1.type != "executable":
            return {"status": "error", "code": "WU_004", "message": "Layer1类型错误"}

        if wisunit.layer_2.type != "structured":
            return {"status": "error", "code": "WU_005", "message": "Layer2类型错误"}

        if wisunit.layer_3.type != "natural_language":
            return {"status": "error", "code": "WU_006", "message": "Layer3类型错误"}

        return {"status": "success", "message": "验证通过"}

    except Exception as e:
        return {"status": "error", "code": "WU_999", "message": str(e)}

# 使用示例
if __name__ == "__main__":
    wisunit = create_wisunit_example()
    validation_result = validate_wisunit(wisunit)
    print(json.dumps(validation_result, indent=2, ensure_ascii=False))
```

---

## 1.2 WisUnit CRUD协议

### 协议名称
WisUnit CRUD Protocol

### 协议描述
定义WisUnit的创建、读取、更新、删除（CRUD）操作协议。

### 协议版本
v1.0.0

### 接口定义

```python
from typing import List, Optional, Dict, Any
from pydantic import BaseModel

class CreateWisUnitRequest(BaseModel):
    """创建WisUnit请求"""
    wisunit: Dict[str, Any]
    auto_verify: bool = False

class GetWisUnitRequest(BaseModel):
    """获取WisUnit请求"""
    wisunit_id: str
    include_audit_log: bool = False
    include_dependencies: bool = False

class UpdateWisUnitRequest(BaseModel):
    """更新WisUnit请求"""
    wisunit_id: str
    updates: Dict[str, Any]
    version_note: Optional[str] = None

class DeleteWisUnitRequest(BaseModel):
    """删除WisUnit请求"""
    wisunit_id: str
    soft_delete: bool = True

class ListWisUnitsRequest(BaseModel):
    """列出WisUnit请求"""
    domain: Optional[str] = None
    tags: Optional[List[str]] = None
    created_by: Optional[str] = None
    limit: int = 50
    offset: int = 0
    sort_by: str = "created_at"
    sort_order: str = "desc"

class WisUnitCRUDResponse(BaseModel):
    """CRUD响应"""
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
    "required": ["wisunit"],
    "properties": {
      "wisunit": {"type": "object"},
      "auto_verify": {"type": "boolean"}
    }
  },
  "GetWisUnitRequest": {
    "type": "object",
    "required": ["wisunit_id"],
    "properties": {
      "wisunit_id": {"type": "string"},
      "include_audit_log": {"type": "boolean"},
      "include_dependencies": {"type": "boolean"}
    }
  },
  "UpdateWisUnitRequest": {
    "type": "object",
    "required": ["wisunit_id", "updates"],
    "properties": {
      "wisunit_id": {"type": "string"},
      "updates": {"type": "object"},
      "version_note": {"type": "string"}
    }
  },
  "DeleteWisUnitRequest": {
    "type": "object",
    "required": ["wisunit_id"],
    "properties": {
      "wisunit_id": {"type": "string"},
      "soft_delete": {"type": "boolean"}
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
      "error": {
        "type": "object",
        "properties": {
          "code": {"type": "string"},
          "message": {"type": "string"}
        }
      }
    }
  }
}
```

### 错误码定义

| 错误码 | 描述 | HTTP状态码 |
|--------|------|-----------|
| `CRUD_001` | WisUnit不存在 | 404 |
| `CRUD_002` | 权限不足 | 403 |
| `CRUD_003` | 更新冲突（版本不匹配） | 409 |
| `CRUD_004` | 软删除已删除的WisUnit | 400 |
| `CRUD_005` | 无法删除，存在依赖 | 400 |
| `CRUD_999` | 未知错误 | 500 |

### 示例代码（Python）

```python
from typing import Dict, Any, List, Optional
from datetime import datetime
from app.models import WisUnit

class WisUnitCRUD:
    """WisUnit CRUD操作"""

    def __init__(self, db_client):
        self.db = db_client

    async def create(self, request: CreateWisUnitRequest) -> Dict[str, Any]:
        """创建WisUnit"""
        wisunit_data = request.wisunit

        # 创建WisUnit对象
        wisunit = WisUnit(**wisunit_data)

        # 检查是否已存在
        existing = await self._get_by_id(wisunit.id)
        if existing:
            return {
                "status": "error",
                "error": {"code": "WU_008", "message": "WisUnit已存在"}
            }

        # 保存到数据库
        await self._save(wisunit)

        # 自动验证（如果启用）
        if request.auto_verify:
            verify_result = await self._auto_verify(wisunit.id)
            if verify_result["status"] == "error":
                # 回滚
                await self._delete(wisunit.id, soft_delete=False)
                return verify_result

        return {
            "status": "success",
            "data": {
                "wisunit_id": wisunit.id,
                "version": wisunit.version,
                "created_at": wisunit.created_at.isoformat()
            },
            "message": "WisUnit创建成功"
        }

    async def get(self, request: GetWisUnitRequest) -> Dict[str, Any]:
        """获取WisUnit"""
        wisunit = await self._get_by_id(request.wisunit_id)

        if not wisunit:
            return {
                "status": "error",
                "error": {"code": "CRUD_001", "message": "WisUnit不存在"}
            }

        # 转换为字典
        data = wisunit.model_dump()

        # 包含审计日志
        if request.include_audit_log:
            audit_log = await self._get_audit_log(request.wisunit_id)
            data["audit_log"] = audit_log

        # 包含依赖
        if request.include_dependencies:
            dependencies = await self._get_dependencies(request.wisunit_id)
            data["dependencies"] = dependencies

        return {
            "status": "success",
            "data": data
        }

    async def update(self, request: UpdateWisUnitRequest) -> Dict[str, Any]:
        """更新WisUnit"""
        # 获取当前版本
        current = await self._get_by_id(request.wisunit_id)

        if not current:
            return {
                "status": "error",
                "error": {"code": "CRUD_001", "message": "WisUnit不存在"}
            }

        # 应用更新
        updates = request.updates
        for key, value in updates.items():
            setattr(current, key, value)

        # 更新时间戳
        current.updated_at = datetime.now()

        # 更新版本
        version_parts = current.version.split(".")
        version_parts[2] = str(int(version_parts[2]) + 1)
        current.version = ".".join(version_parts)

        # 保存更新
        await self._save(current)

        return {
            "status": "success",
            "data": {
                "wisunit_id": current.id,
                "version": current.version,
                "updated_at": current.updated_at.isoformat()
            },
            "message": "WisUnit更新成功"
        }

    async def delete(self, request: DeleteWisUnitRequest) -> Dict[str, Any]:
        """删除WisUnit"""
        wisunit = await self._get_by_id(request.wisunit_id)

        if not wisunit:
            return {
                "status": "error",
                "error": {"code": "CRUD_001", "message": "WisUnit不存在"}
            }

        # 检查是否存在依赖
        if request.soft_delete:
            dependents = await self._get_dependents(request.wisunit_id)
            if dependents:
                return {
                    "status": "error",
                    "error": {"code": "CRUD_005", "message": "无法删除，存在依赖"}
                }

        # 删除
        await self._delete(request.wisunit_id, soft_delete=request.soft_delete)

        return {
            "status": "success",
            "message": "WisUnit删除成功"
        }

    async def list(self, request: ListWisUnitsRequest) -> Dict[str, Any]:
        """列出WisUnit"""
        # 构建查询条件
        filters = {}

        if request.domain:
            filters["domain"] = request.domain

        if request.tags:
            filters["tags"] = {"$in": request.tags}

        if request.created_by:
            filters["created_by"] = request.created_by

        # 查询数据库
        wisunits = await self._query(filters, request.limit, request.offset,
                                    request.sort_by, request.sort_order)

        # 统计总数
        total = await self._count(filters)

        return {
            "status": "success",
            "data": {
                "wisunits": wisunits,
                "total": total,
                "limit": request.limit,
                "offset": request.offset
            }
        }

    async def _get_by_id(self, wisunit_id: str) -> Optional[WisUnit]:
        """根据ID获取WisUnit"""
        # 实现数据库查询
        pass

    async def _save(self, wisunit: WisUnit):
        """保存WisUnit到数据库"""
        # 实现数据库保存
        pass

    async def _delete(self, wisunit_id: str, soft_delete: bool = True):
        """删除WisUnit"""
        # 实现数据库删除
        pass

    async def _get_audit_log(self, wisunit_id: str) -> Dict[str, Any]:
        """获取审计日志"""
        # 实现审计日志查询
        pass

    async def _get_dependencies(self, wisunit_id: str) -> List[Dict[str, Any]]:
        """获取依赖关系"""
        # 实现依赖关系查询
        pass

    async def _get_dependents(self, wisunit_id: str) -> List[str]:
        """获取依赖此WisUnit的其他WisUnit"""
        # 实现反向依赖查询
        pass

    async def _auto_verify(self, wisunit_id: str) -> Dict[str, Any]:
        """自动验证WisUnit"""
        # 实现自动验证
        pass

    async def _query(self, filters: Dict, limit: int, offset: int,
                    sort_by: str, sort_order: str) -> List[Dict]:
        """查询WisUnit列表"""
        # 实现数据库查询
        pass

    async def _count(self, filters: Dict) -> int:
        """统计数量"""
        # 实现计数查询
        pass


# 使用示例
async def example_usage():
    db_client = None  # 初始化数据库客户端
    crud = WisUnitCRUD(db_client)

    # 创建WisUnit
    create_request = CreateWisUnitRequest(
        wisunit={
            "id": "ku_20260223_001",
            "version": "1.0.0",
            "created_at": "2026-02-23T10:30:00Z",
            "updated_at": "2026-02-23T10:30:00Z",
            "created_by": "user_001",
            "domain": "medical",
            "layer_1": {...},
            "layer_2": {...},
            "layer_3": {...}
        },
        auto_verify=True
    )
    create_result = await crud.create(create_request)
    print("创建结果:", create_result)

    # 获取WisUnit
    get_request = GetWisUnitRequest(
        wisunit_id="ku_20260223_001",
        include_dependencies=True
    )
    get_result = await crud.get(get_request)
    print("获取结果:", get_result)

    # 更新WisUnit
    update_request = UpdateWisUnitRequest(
        wisunit_id="ku_20260223_001",
        updates={"tags": ["diabetes", "endocrinology", "diagnosis", "updated"]},
        version_note="添加updated标签"
    )
    update_result = await crud.update(update_request)
    print("更新结果:", update_result)

    # 列出WisUnit
    list_request = ListWisUnitsRequest(
        domain="medical",
        limit=10,
        offset=0
    )
    list_result = await crud.list(list_request)
    print("列表结果:", list_result)
```

---

## 1.3 WisUnit验证协议

### 协议名称
WisUnit Verification Protocol

### 协议描述
定义WisUnit的四级验证体系：L1自动化验证、L2社区验证、L4.5 AI验证、L3专家验证、L4仲裁验证。

### 协议版本
v1.0.0

### 接口定义

```python
from typing import Dict, Any, List, Optional
from pydantic import BaseModel
from datetime import datetime
from enum import Enum

class VerificationLevel(str, Enum):
    """验证级别"""
    L1_AUTO = "L1"  # 自动化验证
    L2_COMMUNITY = "L2"  # 社区验证
    L3_EXPERT = "L3"  # 专家验证
    L4_ARBITRATION = "L4"  # 仲裁验证
    L4_5_AI = "L4.5"  # AI验证

class VerificationStatus(str, Enum):
    """验证状态"""
    PENDING = "pending"
    IN_PROGRESS = "in_progress"
    PASSED = "passed"
    FAILED = "failed"
    REJECTED = "rejected"

class L1VerificationRequest(BaseModel):
    """L1自动化验证请求"""
    wisunit_id: str
    checks: List[str] = [
        "schema_validation",
        "dependency_check",
        "format_check",
        "security_scan"
    ]

class L2CommunityVerificationRequest(BaseModel):
    """L2社区验证请求"""
    wisunit_id: str
    min_reviews: int = 5
    threshold_score: float = 0.7

class L4_5AIVerificationRequest(BaseModel):
    """L4.5 AI验证请求"""
    wisunit_id: str
    models: List[str] = ["gpt-4", "glm-5", "llama-3"]
    confidence_threshold: float = 0.7

class L3ExpertVerificationRequest(BaseModel):
    """L3专家验证请求"""
    wisunit_id: str
    expert_ids: List[str]
    domain: str

class L4ArbitrationRequest(BaseModel):
    """L4仲裁验证请求"""
    wisunit_id: str
    reason: str
    evidence: List[str] = []

class VerificationResponse(BaseModel):
    """验证响应"""
    verification_id: str
    wisunit_id: str
    level: VerificationLevel
    status: VerificationStatus
    score: Optional[float] = None
    result: Optional[Dict[str, Any]] = None
    verified_by: Optional[str] = None
    verified_at: Optional[datetime] = None
    error: Optional[Dict[str, Any]] = None
```

### 请求格式（JSON Schema）

```json
{
  "L1VerificationRequest": {
    "type": "object",
    "required": ["wisunit_id"],
    "properties": {
      "wisunit_id": {"type": "string"},
      "checks": {
        "type": "array",
        "items": {"type": "string"},
        "default": ["schema_validation", "dependency_check", "format_check", "security_scan"]
      }
    }
  },
  "L2CommunityVerificationRequest": {
    "type": "object",
    "required": ["wisunit_id"],
    "properties": {
      "wisunit_id": {"type": "string"},
      "min_reviews": {"type": "integer", "default": 5},
      "threshold_score": {"type": "number", "default": 0.7}
    }
  },
  "L4_5AIVerificationRequest": {
    "type": "object",
    "required": ["wisunit_id"],
    "properties": {
      "wisunit_id": {"type": "string"},
      "models": {
        "type": "array",
        "items": {"type": "string"},
        "default": ["gpt-4", "glm-5", "llama-3"]
      },
      "confidence_threshold": {"type": "number", "default": 0.7}
    }
  },
  "L3ExpertVerificationRequest": {
    "type": "object",
    "required": ["wisunit_id", "expert_ids", "domain"],
    "properties": {
      "wisunit_id": {"type": "string"},
      "expert_ids": {"type": "array", "items": {"type": "string"}},
      "domain": {"type": "string"}
    }
  },
  "L4ArbitrationRequest": {
    "type": "object",
    "required": ["wisunit_id", "reason"],
    "properties": {
      "wisunit_id": {"type": "string"},
      "reason": {"type": "string"},
      "evidence": {"type": "array", "items": {"type": "string"}}
    }
  }
}
```

### 响应格式（JSON Schema）

```json
{
  "VerificationResponse": {
    "type": "object",
    "required": ["verification_id", "wisunit_id", "level", "status"],
    "properties": {
      "verification_id": {"type": "string"},
      "wisunit_id": {"type": "string"},
      "level": {"type": "string", "enum": ["L1", "L2", "L3", "L4", "L4.5"]},
      "status": {"type": "string", "enum": ["pending", "in_progress", "passed", "failed", "rejected"]},
      "score": {"type": "number"},
      "result": {"type": "object"},
      "verified_by": {"type": "string"},
      "verified_at": {"type": "string", "format": "date-time"},
      "error": {"type": "object"}
    }
  }
}
```

### 错误码定义

| 错误码 | 描述 | HTTP状态码 |
|--------|------|-----------|
| `VER_001` | WisUnit不存在 | 404 |
| `VER_002` | 验证级别不支持的检查项 | 400 |
| `VER_003` | 验证状态不允许此操作 | 400 |
| `VER_004` | 专家不存在或权限不足 | 403 |
| `VER_005` | AI模型调用失败 | 500 |
| `VER_006` | 仲裁条件不满足 | 400 |
| `VER_999` | 未知错误 | 500 |

### 示例代码（Python）

```python
from typing import Dict, Any, List
from datetime import datetime
import uuid

class WisUnitVerification:
    """WisUnit验证系统"""

    def __init__(self, db_client, ai_client):
        self.db = db_client
        self.ai = ai_client

    async def l1_verify(self, request: L1VerificationRequest) -> VerificationResponse:
        """L1自动化验证"""
        verification_id = str(uuid.uuid4())

        # 获取WisUnit
        wisunit = await self._get_wisunit(request.wisunit_id)
        if not wisunit:
            return VerificationResponse(
                verification_id=verification_id,
                wisunit_id=request.wisunit_id,
                level=VerificationLevel.L1_AUTO,
                status=VerificationStatus.FAILED,
                error={"code": "VER_001", "message": "WisUnit不存在"}
            )

        results = {}
        total_score = 0.0
        checks_count = len(request.checks)

        # 执行各项检查
        for check in request.checks:
            check_result = await self._execute_check(wisunit, check)
            results[check] = check_result
            total_score += check_result["score"]

        # 计算平均分数
        avg_score = total_score / checks_count if checks_count > 0 else 0.0

        # 判定结果
        status = VerificationStatus.PASSED if avg_score >= 0.8 else VerificationStatus.FAILED

        # 保存验证记录
        await self._save_verification({
            "verification_id": verification_id,
            "wisunit_id": request.wisunit_id,
            "level": "L1",
            "status": status.value,
            "score": avg_score,
            "result": results,
            "verified_by": "system",
            "verified_at": datetime.now()
        })

        return VerificationResponse(
            verification_id=verification_id,
            wisunit_id=request.wisunit_id,
            level=VerificationLevel.L1_AUTO,
            status=status,
            score=avg_score,
            result=results,
            verified_by="system",
            verified_at=datetime.now()
        )

    async def l4_5_verify(self, request: L4_5AIVerificationRequest) -> VerificationResponse:
        """L4.5 AI验证（多模型交叉验证）"""
        verification_id = str(uuid.uuid4())

        # 获取WisUnit
        wisunit = await self._get_wisunit(request.wisunit_id)
        if not wisunit:
            return VerificationResponse(
                verification_id=verification_id,
                wisunit_id=request.wisunit_id,
                level=VerificationLevel.L4_5_AI,
                status=VerificationStatus.FAILED,
                error={"code": "VER_001", "message": "WisUnit不存在"}
            )

        results = []
        confidence_scores = []

        # 使用多个AI模型验证
        for model in request.models:
            try:
                # 调用AI模型
                model_result = await self._call_ai_model(model, wisunit)
                results.append({
                    "model": model,
                    "result": model_result
                })
                confidence_scores.append(model_result.get("confidence", 0.0))
            except Exception as e:
                results.append({
                    "model": model,
                    "error": str(e)
                })

        # 计算最终置信度
        avg_confidence = sum(confidence_scores) / len(confidence_scores) if confidence_scores else 0.0

        # 计算一致性
        consistency = self._calculate_consistency(results)

        # 判断是否需要人工审核
        human_review_required = (
            avg_confidence < request.confidence_threshold or
            consistency < 0.8 or
            max(confidence_scores) - min(confidence_scores) > 0.2
        )

        # 保存验证记录
        await self._save_verification({
            "verification_id": verification_id,
            "wisunit_id": request.wisunit_id,
            "level": "L4.5",
            "status": "passed" if avg_confidence >= request.confidence_threshold else "failed",
            "score": avg_confidence,
            "result": {
                "model_results": results,
                "consistency": consistency,
                "human_review_required": human_review_required
            },
            "verified_by": "ai_system",
            "verified_at": datetime.now()
        })

        return VerificationResponse(
            verification_id=verification_id,
            wisunit_id=request.wisunit_id,
            level=VerificationLevel.L4_5_AI,
            status=VerificationStatus.PASSED if avg_confidence >= request.confidence_threshold
                else VerificationStatus.FAILED,
            score=avg_confidence,
            result={
                "model_results": results,
                "consistency": consistency,
                "human_review_required": human_review_required
            },
            verified_by="ai_system",
            verified_at=datetime.now()
        )

    async def l2_verify(self, request: L2CommunityVerificationRequest) -> VerificationResponse:
        """L2社区验证"""
        verification_id = str(uuid.uuid4())

        # 创建验证任务
        await self._create_verification_task({
            "verification_id": verification_id,
            "wisunit_id": request.wisunit_id,
            "level": "L2",
            "status": "in_progress",
            "min_reviews": request.min_reviews,
            "threshold_score": request.threshold_score,
            "created_at": datetime.now()
        })

        # 返回任务信息
        return VerificationResponse(
            verification_id=verification_id,
            wisunit_id=request.wisunit_id,
            level=VerificationLevel.L2_COMMUNITY,
            status=VerificationStatus.IN_PROGRESS,
            verified_by="community",
            result={
                "min_reviews": request.min_reviews,
                "threshold_score": request.threshold_score,
                "message": "社区验证任务已创建，等待社区审核"
            },
            verified_at=datetime.now()
        )

    async def l3_verify(self, request: L3ExpertVerificationRequest) -> VerificationResponse:
        """L3专家验证"""
        verification_id = str(uuid.uuid4())

        # 验证专家权限
        for expert_id in request.expert_ids:
            expert = await self._get_expert(expert_id)
            if not expert:
                return VerificationResponse(
                    verification_id=verification_id,
                    wisunit_id=request.wisunit_id,
                    level=VerificationLevel.L3_EXPERT,
                    status=VerificationStatus.FAILED,
                    error={"code": "VER_004", "message": f"专家不存在: {expert_id}"}
                )

            # 检查领域匹配
            if request.domain not in expert.get("domains", []):
                return VerificationResponse(
                    verification_id=verification_id,
                    wisunit_id=request.wisunit_id,
                    level=VerificationLevel.L3_EXPERT,
                    status=VerificationStatus.FAILED,
                    error={"code": "VER_004", "message": f"专家领域不匹配: {expert_id}"}
                )

        # 创建验证任务
        await self._create_verification_task({
            "verification_id": verification_id,
            "wisunit_id": request.wisunit_id,
            "level": "L3",
            "status": "in_progress",
            "expert_ids": request.expert_ids,
            "domain": request.domain,
            "created_at": datetime.now()
        })

        # 通知专家
        await self._notify_experts(request.expert_ids, verification_id)

        return VerificationResponse(
            verification_id=verification_id,
            wisunit_id=request.wisunit_id,
            level=VerificationLevel.L3_EXPERT,
            status=VerificationStatus.IN_PROGRESS,
            verified_by="experts",
            result={
                "expert_ids": request.expert_ids,
                "message": "专家验证任务已创建，已通知相关专家"
            },
            verified_at=datetime.now()
        )

    async def l4_arbitrate(self, request: L4ArbitrationRequest) -> VerificationResponse:
        """L4仲裁验证"""
        verification_id = str(uuid.uuid4())

        # 获取WisUnit
        wisunit = await self._get_wisunit(request.wisunit_id)
        if not wisunit:
            return VerificationResponse(
                verification_id=verification_id,
                wisunit_id=request.wisunit_id,
                level=VerificationLevel.L4_ARBITRATION,
                status=VerificationStatus.FAILED,
                error={"code": "VER_001", "message": "WisUnit不存在"}
            )

        # 检查仲裁条件
        previous_verifications = await self._get_verifications(request.wisunit_id)
        if len(previous_verifications) < 2:
            return VerificationResponse(
                verification_id=verification_id,
                wisunit_id=request.wisunit_id,
                level=VerificationLevel.L4_ARBITRATION,
                status=VerificationStatus.FAILED,
                error={"code": "VER_006", "message": "仲裁条件不满足，至少需要2个前置验证"}
            )

        # 创建仲裁任务
        await self._create_verification_task({
            "verification_id": verification_id,
            "wisunit_id": request.wisunit_id,
            "level": "L4",
            "status": "in_progress",
            "reason": request.reason,
            "evidence": request.evidence,
            "created_at": datetime.now()
        })

        return VerificationResponse(
            verification_id=verification_id,
            wisunit_id=request.wisunit_id,
            level=VerificationLevel.L4_ARBITRATION,
            status=VerificationStatus.IN_PROGRESS,
            verified_by="arbitrator",
            result={
                "reason": request.reason,
                "message": "仲裁任务已创建，等待仲裁员审核"
            },
            verified_at=datetime.now()
        )

    async def _execute_check(self, wisunit: Dict[str, Any], check: str) -> Dict[str, Any]:
        """执行单个检查项"""
        # 实现各项检查逻辑
        checks = {
            "schema_validation": self._check_schema_validation,
            "dependency_check": self._check_dependency,
            "format_check": self._check_format,
            "security_scan": self._check_security
        }

        check_func = checks.get(check)
        if check_func:
            return await check_func(wisunit)
        else:
            return {"score": 0.0, "message": "不支持的检查项"}

    async def _check_schema_validation(self, wisunit: Dict[str, Any]) -> Dict[str, Any]:
        """Schema验证"""
        # 实现Schema验证逻辑
        return {"score": 0.9, "message": "Schema验证通过"}

    async def _check_dependency(self, wisunit: Dict[str, Any]) -> Dict[str, Any]:
        """依赖检查"""
        # 实现依赖检查逻辑
        return {"score": 0.85, "message": "依赖检查通过"}

    async def _check_format(self, wisunit: Dict[str, Any]) -> Dict[str, Any]:
        """格式检查"""
        # 实现格式检查逻辑
        return {"score": 0.95, "message": "格式检查通过"}

    async def _check_security(self, wisunit: Dict[str, Any]) -> Dict[str, Any]:
        """安全扫描"""
        # 实现安全扫描逻辑
        return {"score": 0.88, "message": "安全扫描通过"}

    async def _call_ai_model(self, model: str, wisunit: Dict[str, Any]) -> Dict[str, Any]:
        """调用AI模型验证"""
        # 实现AI模型调用
        return {
            "confidence": 0.92,
            "assessment": "内容质量良好",
            "suggestions": []
        }

    def _calculate_consistency(self, results: List[Dict[str, Any]]) -> float:
        """计算AI模型一致性"""
        # 实现一致性计算
        return 0.85

    async def _get_wisunit(self, wisunit_id: str) -> Optional[Dict[str, Any]]:
        """获取WisUnit"""
        # 实现数据库查询
        pass

    async def _save_verification(self, verification: Dict[str, Any]):
        """保存验证记录"""
        # 实现数据库保存
        pass

    async def _create_verification_task(self, task: Dict[str, Any]):
        """创建验证任务"""
        # 实现任务创建
        pass

    async def _get_expert(self, expert_id: str) -> Optional[Dict[str, Any]]:
        """获取专家信息"""
        # 实现专家查询
        pass

    async def _notify_experts(self, expert_ids: List[str], verification_id: str):
        """通知专家"""
        # 实现专家通知
        pass

    async def _get_verifications(self, wisunit_id: str) -> List[Dict[str, Any]]:
        """获取验证历史"""
        # 实现验证历史查询
        pass


# 使用示例
async def example_usage():
    db_client = None  # 初始化数据库客户端
    ai_client = None  # 初始化AI客户端
    verification = WisUnitVerification(db_client, ai_client)

    # L1自动化验证
    l1_request = L1VerificationRequest(
        wisunit_id="ku_20260223_001",
        checks=["schema_validation", "dependency_check", "format_check"]
    )
    l1_result = await verification.l1_verify(l1_request)
    print("L1验证结果:", l1_result)

    # L4.5 AI验证
    l4_5_request = L4_5AIVerificationRequest(
        wisunit_id="ku_20260223_001",
        models=["gpt-4", "glm-5", "llama-3"]
    )
    l4_5_result = await verification.l4_5_verify(l4_5_request)
    print("L4.5验证结果:", l4_5_result)

    # L2社区验证
    l2_request = L2CommunityVerificationRequest(
        wisunit_id="ku_20260223_001",
        min_reviews=5,
        threshold_score=0.7
    )
    l2_result = await verification.l2_verify(l2_request)
    print("L2验证结果:", l2_result)

    # L3专家验证
    l3_request = L3ExpertVerificationRequest(
        wisunit_id="ku_20260223_001",
        expert_ids=["expert_001", "expert_002", "expert_003"],
        domain="medical"
    )
    l3_result = await verification.l3_verify(l3_request)
    print("L3验证结果:", l3_result)

    # L4仲裁验证
    l4_request = L4ArbitrationRequest(
        wisunit_id="ku_20260223_001",
        reason="L2和L3验证结果不一致，需要仲裁",
        evidence=["L2验证通过", "L3验证失败"]
    )
    l4_result = await verification.l4_arbitrate(l4_request)
    print("L4验证结果:", l4_result)
```

---

# 2. WISE协议系统

## 2.1 WisStore协议

### 协议名称
WisStore Protocol

### 协议描述
定义WisUnit的存储、索引和检索协议，支持多级存储和高效检索。

### 协议版本
v1.0.0

### 接口定义

```python
from typing import Dict, Any, List, Optional
from pydantic import BaseModel
from datetime import datetime
from enum import Enum

class StorageTier(str, Enum):
    """存储层级"""
    HOT = "hot"
    WARM = "warm"
    COLD = "cold"

class IndexType(str, Enum):
    """索引类型"""
    VECTOR = "vector"
    FULLTEXT = "fulltext"
    STRUCTURED = "structured"
    GRAPH = "graph"

class StoreWisUnitRequest(BaseModel):
    """存储WisUnit请求"""
    wisunit_id: str
    wisunit_data: Dict[str, Any]
    tier: StorageTier = StorageTier.HOT
    create_indexes: List[IndexType] = []

class RetrieveWisUnitRequest(BaseModel):
    """检索WisUnit请求"""
    wisunit_id: str
    include_metadata: bool = True
    include_audit_log: bool = False

class SearchWisUnitRequest(BaseModel):
    """搜索WisUnit请求"""
    query: str
    index_type: IndexType
    domain: Optional[str] = None
    tags: Optional[List[str]] = None
    limit: int = 50
    offset: int = 0
    filters: Optional[Dict[str, Any]] = None

class UpdateIndexRequest(BaseModel):
    """更新索引请求"""
    wisunit_id: str
    index_type: IndexType

class WisStoreResponse(BaseModel):
    """WisStore响应"""
    status: str
    data: Optional[Dict[str, Any]] = None
    message: Optional[str] = None
    error: Optional[Dict[str, Any]] = None
```

### 请求格式（JSON Schema）

```json
{
  "StoreWisUnitRequest": {
    "type": "object",
    "required": ["wisunit_id", "wisunit_data"],
    "properties": {
      "wisunit_id": {"type": "string"},
      "wisunit_data": {"type": "object"},
      "tier": {"type": "string", "enum": ["hot", "warm", "cold"]},
      "create_indexes": {
        "type": "array",
        "items": {"type": "string", "enum": ["vector", "fulltext", "structured", "graph"]}
      }
    }
  },
  "RetrieveWisUnitRequest": {
    "type": "object",
    "required": ["wisunit_id"],
    "properties": {
      "wisunit_id": {"type": "string"},
      "include_metadata": {"type": "boolean"},
      "include_audit_log": {"type": "boolean"}
    }
  },
  "SearchWisUnitRequest": {
    "type": "object",
    "required": ["query", "index_type"],
    "properties": {
      "query": {"type": "string"},
      "index_type": {"type": "string", "enum": ["vector", "fulltext", "structured", "graph"]},
      "domain": {"type": "string"},
      "tags": {"type": "array", "items": {"type": "string"}},
      "limit": {"type": "integer"},
      "offset": {"type": "integer"},
      "filters": {"type": "object"}
    }
  }
}
```

### 响应格式（JSON Schema）

```json
{
  "WisStoreResponse": {
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
| `WS_001` | WisUnit不存在 | 404 |
| `WS_002` | 存储空间不足 | 507 |
| `WS_003` | 索引创建失败 | 500 |
| `WS_004` | 搜索参数错误 | 400 |
| `WS_005` | 存储层级不支持的操作 | 400 |
| `WS_999` | 未知错误 | 500 |

### 示例代码（Python）

```python
from typing import Dict, Any, List, Optional
from datetime import datetime

class WisStore:
    """WisUnit存储系统"""

    def __init__(self, db_client, vector_db, search_engine, graph_db):
        self.db = db_client
        self.vector_db = vector_db
        self.search_engine = search_engine
        self.graph_db = graph_db

    async def store(self, request: StoreWisUnitRequest) -> WisStoreResponse:
        """存储WisUnit"""
        # 确定存储层级
        tier = self._determine_tier(request.wisunit_data)

        # 存储到数据库
        await self._store_to_db(request.wisunit_id, request.wisunit_data, tier)

        # 创建索引
        for index_type in request.create_indexes:
            await self._create_index(request.wisunit_id, request.wisunit_data, index_type)

        return WisStoreResponse(
            status="success",
            data={
                "wisunit_id": request.wisunit_id,
                "tier": tier,
                "indexes_created": request.create_indexes
            },
            message="WisUnit存储成功"
        )

    async def retrieve(self, request: RetrieveWisUnitRequest) -> WisStoreResponse:
        """检索WisUnit"""
        # 从数据库检索
        wisunit = await self._retrieve_from_db(request.wisunit_id)

        if not wisunit:
            return WisStoreResponse(
                status="error",
                error={"code": "WS_001", "message": "WisUnit不存在"}
            )

        # 包含元数据
        data = {"wisunit": wisunit}

        if request.include_metadata:
            metadata = await self._get_metadata(request.wisunit_id)
            data["metadata"] = metadata

        if request.include_audit_log:
            audit_log = await self._get_audit_log(request.wisunit_id)
            data["audit_log"] = audit_log

        return WisStoreResponse(
            status="success",
            data=data
        )

    async def search(self, request: SearchWisUnitRequest) -> WisStoreResponse:
        """搜索WisUnit"""
        results = []

        if request.index_type == IndexType.VECTOR:
            # 向量搜索
            results = await self._vector_search(
                request.query,
                request.domain,
                request.tags,
                request.limit,
                request.filters
            )
        elif request.index_type == IndexType.FULLTEXT:
            # 全文搜索
            results = await self._fulltext_search(
                request.query,
                request.domain,
                request.tags,
                request.limit,
                request.offset,
                request.filters
            )
        elif request.index_type == IndexType.STRUCTURED:
            # 结构化搜索
            results = await self._structured_search(
                request.domain,
                request.tags,
                request.limit,
                request.offset,
                request.filters
            )
        elif request.index_type == IndexType.GRAPH:
            # 图搜索
            results = await self._graph_search(
                request.query,
                request.limit,
                request.filters
            )

        return WisStoreResponse(
            status="success",
            data={
                "results": results,
                "total": len(results),
                "query": request.query,
                "index_type": request.index_type.value
            }
        )

    async def update_index(self, request: UpdateIndexRequest) -> WisStoreResponse:
        """更新索引"""
        # 获取WisUnit数据
        wisunit = await self._retrieve_from_db(request.wisunit_id)

        if not wisunit:
            return WisStoreResponse(
                status="error",
                error={"code": "WS_001", "message": "WisUnit不存在"}
            )

        # 更新索引
        await self._update_index(request.wisunit_id, wisunit, request.index_type)

        return WisStoreResponse(
            status="success",
            data={
                "wisunit_id": request.wisunit_id,
                "index_type": request.index_type.value
            },
            message="索引更新成功"
        )

    def _determine_tier(self, wisunit_data: Dict[str, Any]) -> StorageTier:
        """确定存储层级"""
        # 根据WisUnit的创建时间和访问频率确定存储层级
        created_at = wisunit_data.get("created_at")
        age_days = (datetime.now() - created_at).days

        if age_days < 90:
            return StorageTier.HOT
        elif age_days < 365:
            return StorageTier.WARM
        else:
            return StorageTier.COLD

    async def _store_to_db(self, wisunit_id: str, wisunit_data: Dict[str, Any], tier: StorageTier):
        """存储到数据库"""
        # 实现数据库存储
        pass

    async def _retrieve_from_db(self, wisunit_id: str) -> Optional[Dict[str, Any]]:
        """从数据库检索"""
        # 实现数据库检索
        pass

    async def _create_index(self, wisunit_id: str, wisunit_data: Dict[str, Any], index_type: IndexType):
        """创建索引"""
        if index_type == IndexType.VECTOR:
            # 创建向量索引
            text = wisunit_data.get("layer_3", {}).get("description", "")
            vector = self._encode_text(text)
            await self.vector_db.add(wisunit_id, vector)
        elif index_type == IndexType.FULLTEXT:
            # 创建全文索引
            await self.search_engine.index(wisunit_id, wisunit_data)
        elif index_type == IndexType.STRUCTURED:
            # 创建结构化索引
            await self.db.create_index(wisunit_id, wisunit_data)
        elif index_type == IndexType.GRAPH:
            # 创建图索引
            await self.graph_db.add_node(wisunit_id, wisunit_data)

    async def _update_index(self, wisunit_id: str, wisunit_data: Dict[str, Any], index_type: IndexType):
        """更新索引"""
        # 实现索引更新
        pass

    async def _vector_search(self, query: str, domain: Optional[str],
                            tags: Optional[List[str]], limit: int,
                            filters: Optional[Dict[str, Any]]) -> List[Dict[str, Any]]:
        """向量搜索"""
        # 编码查询文本
        query_vector = self._encode_text(query)

        # 执行向量搜索
        results = await self.vector_db.search(query_vector, limit)

        # 过滤结果
        if domain or tags or filters:
            results = await self._filter_results(results, domain, tags, filters)

        return results

    async def _fulltext_search(self, query: str, domain: Optional[str],
                              tags: Optional[List[str]], limit: int, offset: int,
                              filters: Optional[Dict[str, Any]]) -> List[Dict[str, Any]]:
        """全文搜索"""
        # 执行全文搜索
        results = await self.search_engine.search(query, limit, offset)

        # 过滤结果
        if domain or tags or filters:
            results = await self._filter_results(results, domain, tags, filters)

        return results

    async def _structured_search(self, domain: Optional[str],
                                tags: Optional[List[str]], limit: int, offset: int,
                                filters: Optional[Dict[str, Any]]) -> List[Dict[str, Any]]:
        """结构化搜索"""
        # 构建查询条件
        query = {}
        if domain:
            query["domain"] = domain
        if tags:
            query["tags"] = {"$in": tags}
        if filters:
            query.update(filters)

        # 执行结构化搜索
        results = await self.db.search(query, limit, offset)

        return results

    async def _graph_search(self, query: str, limit: int,
                           filters: Optional[Dict[str, Any]]) -> List[Dict[str, Any]]:
        """图搜索"""
        # 执行图搜索
        results = await self.graph_db.search(query, limit)

        return results

    async def _filter_results(self, results: List[Dict[str, Any]],
                             domain: Optional[str], tags: Optional[List[str]],
                             filters: Optional[Dict[str, Any]]) -> List[Dict[str, Any]]:
        """过滤搜索结果"""
        filtered = results

        if domain:
            filtered = [r for r in filtered if r.get("domain") == domain]

        if tags:
            filtered = [r for r in filtered if any(tag in r.get("tags", []) for tag in tags)]

        if filters:
            filtered = [r for r in filtered if self._match_filters(r, filters)]

        return filtered

    def _encode_text(self, text: str) -> List[float]:
        """编码文本为向量"""
        # 使用Sentence-Transformers编码文本
        # 这里简化实现
        return [0.0] * 768

    def _match_filters(self, item: Dict[str, Any], filters: Dict[str, Any]) -> bool:
        """匹配过滤条件"""
        # 实现过滤条件匹配
        return True

    async def _get_metadata(self, wisunit_id: str) -> Dict[str, Any]:
        """获取元数据"""
        # 实现元数据查询
        pass

    async def _get_audit_log(self, wisunit_id: str) -> List[Dict[str, Any]]:
        """获取审计日志"""
        # 实现审计日志查询
        pass


# 使用示例
async def example_usage():
    db_client = None  # 初始化数据库客户端
    vector_db = None  # 初始化向量数据库
    search_engine = None  # 初始化搜索引擎
    graph_db = None  # 初始化图数据库
    store = WisStore(db_client, vector_db, search_engine, graph_db)

    # 存储WisUnit
    store_request = StoreWisUnitRequest(
        wisunit_id="ku_20260223_001",
        wisunit_data={
            "id": "ku_20260223_001",
            "version": "1.0.0",
            "domain": "medical",
            "layer_1": {...},
            "layer_2": {...},
            "layer_3": {...}
        },
        tier=StorageTier.HOT,
        create_indexes=[IndexType.VECTOR, IndexType.FULLTEXT]
    )
    store_result = await store.store(store_request)
    print("存储结果:", store_result)

    # 检索WisUnit
    retrieve_request = RetrieveWisUnitRequest(
        wisunit_id="ku_20260223_001",
        include_metadata=True
    )
    retrieve_result = await store.retrieve(retrieve_request)
    print("检索结果:", retrieve_result)

    # 向量搜索
    search_request = SearchWisUnitRequest(
        query="糖尿病诊断算法",
        index_type=IndexType.VECTOR,
        domain="medical",
        limit=10
    )
    search_result = await store.search(search_request)
    print("搜索结果:", search_result)
```

---

由于篇幅限制，我将继续在后续补充完整协议文档。让我先创建Phase 1的基础文档，然后进行Phase 2的专家审查。

（文档将在后续继续补充...）

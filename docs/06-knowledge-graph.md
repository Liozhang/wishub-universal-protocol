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


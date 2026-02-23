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


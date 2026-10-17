# dataobject 一等数据实体

> 对应架构 §4.2 | Sprint：S0.3

## 职责

一等数据实体与元结构，是算子操作的统一对象。

| 实体 | 位置 | 说明 |
|------|------|------|
| `DataObject` | dataobject 根 | 内容 + Schema + 模态 + 元数据 + 血缘指针 |
| `Modality` | dataobject 根 | Text/Image/Audio/Video/Table/Code/Multi |
| `Lineage` | dataobject 根 | 算子图 + 输入输出指纹 + 参数 + 环境 |
| `QualityCard` | dataobject 根 | 指标集合 + 阈值 + 判定结果 |
| `Schema` | dataobject/schema | 字段、类型、嵌套结构、约束 |
| `Chunk` | dataobject/chunk | 切片文本/图像区域/表格块，带稳定 ID |
| `Embedding` | dataobject/embedding | 模型标识 + 向量 + 归一化信息 |
| `Record` | dataobject/record_dataset | 单条样本：多字段聚合 |
| `Dataset` | dataobject/record_dataset | Record 集合 + 版本 + 配比 |

## 子包结构

```
dataobject/
├── schema          # Schema + Field + FieldType
├── chunk           # Chunk + ChunkType
├── embedding       # Embedding
└── record_dataset  # Record + Dataset
```

## 依赖方向

- dataobject 根 → dataobject/schema（DataObject 引用 Schema）
- chunk/embedding/record_dataset 独立（避免循环）

## 与 opcore 双向交互

数据实体为算子提供输入契约，算子为数据实体产生派生实体与血缘（S0.4 填充）。

## 当前状态（S0.3）

8 实体结构定义 + 构造函数 + 退化安全空构造。

---

> dataobject | DataVerse | 2026-10-17
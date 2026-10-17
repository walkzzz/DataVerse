# dataobject 一等数据实体

> 对应架构 §4.2 | Sprint：S0.3

## 职责

一等数据实体与元结构，是算子操作的统一对象。

| 实体 | 说明 |
|------|------|
| `DataObject` | 数据一等实体：内容 + Schema + 模态 + 元数据 + 血缘指针 |
| `Schema` | 模式描述：字段、类型、模态、嵌套结构、约束 |
| `Chunk` | 分块单元：切片文本/图像区域/表格块，带稳定 ID |
| `Embedding` | 向量表示：模型标识 + 向量 + 归一化信息 |
| `Record` | 单条样本：多字段聚合，最小处理单元 |
| `Dataset` | 数据集：Record 集合 + 版本 + 配比 + 质量档案 |
| `Lineage` | 血缘：算子图 + 输入输出指纹 + 参数 + 环境 |
| `QualityCard` | 质量档案：指标集合 + 阈值 + 判定结果 |

## 子包规划（S0.3）

```
dataobject/
├── schema          # 模式描述与校验
├── chunk           # 分块单元
├── embedding       # 向量表示
└── record_dataset  # 记录与数据集
```

## 与 opcore 双向交互

数据实体为算子提供输入契约，算子为数据实体产生派生实体与血缘。

## 当前状态

S0.1 骨架占位。`dataobject_id` 为占位标识，供根包重导出验证。

---

> dataobject | DataVerse | 2026-10-17
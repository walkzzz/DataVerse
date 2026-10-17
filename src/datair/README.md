# datair 全域数据中间表示

> 对应架构 §4.6 | Sprint：S0.6

## 职责

统一表达三类对象：数据实体、算子、流水线。

| IR 类型 | 内容 |
|---------|------|
| **实体 IR** | DataObject / Chunk / Embedding / Dataset 的结构与元数据 |
| **算子 IR** | 原子算子节点：名称、参数、模态、确定性、代价模型 |
| **流水线 IR** | 算子图（DAG）：依赖边、融合标记、并行分支、条件路由 |

## 能力

- 算子**序列化**（跨语言、跨进程传输）
- **JIT 编译**到具体后端（Python / GPU kernel / SQL / 流式算子）
- **GPU 向量化**执行
- **分布式任务分发**
- **优化器**：算子融合、重排、缓存复用、增量计算

## 子包规划（S0.6+）

```
datair/
├── ir_core       # 基础节点
├── ir_entity     # 实体 IR
├── ir_operator   # 算子 IR
├── ir_pipeline   # 流水线 IR（DAG）
└── ir_optimizer  # 融合/重排/缓存优化
```

## 当前状态

S0.1 骨架占位。`datair_id` 为占位标识，供根包重导出验证。

---

> datair | DataVerse | 2026-10-17
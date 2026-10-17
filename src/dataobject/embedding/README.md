# dataobject/embedding

向量表示 / Embedding representation.

## 定位

模型标识 + 向量 + 归一化信息。架构 §4.2。

## 当前状态（S0.3）

- `Embedding` 结构（model_id + vector + normalized）+ 构造函数 `make` / `make_normalized` / `zero` / `dim`

## 后续填充

- Phase 1：嵌入算子（opcore annotate）
- Phase 2：DL 嵌入模型、跨模态嵌入
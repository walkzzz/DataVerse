# opcore/dedup

去重算子 / Dedup operators.

## 定位

精确去重、近似去重、语义去重。架构 §4.3.2 ④。

## 当前状态（S0.4）

- `exact_dedup`：按 content 精确去重（保留首次出现）
- `dedup_count`：去重数量差

## 后续填充

- S0.4+：ID 去重
- Phase 1：MinHash/SimHash 近似去重、嵌入向量语义去重
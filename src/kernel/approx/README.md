# kernel/approx

近似概率模式 / Approximate probabilistic mode.

## 定位

MinHash/SimHash 去重、概率采样、近似分位的执行模式基座。
一致性保证：**固定种子 + 误差界声明**（seeded-bound）。

## 当前状态（S0.2）

- 种子管理 `default_seed` / `valid_seed`
- 模式标识 `approx_id` / `mode_tag` / `consistency_guarantee`
- 误差界占位 `default_error_bound`

## 后续填充

- S0.4：MinHash / SimHash / LSH 近似去重算子
- Phase 1：概率采样、近似分位算子
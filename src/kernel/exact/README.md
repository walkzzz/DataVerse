# kernel/exact

确定性精确模式 / Deterministic exact mode.

## 定位

精确哈希去重、精确统计、Schema 校验的执行模式基座。
一致性保证：**逐字节等价**（byte-exact）。

## 当前状态（S0.2）

- 模式标识 `exact_id` / `mode_tag` / `consistency_guarantee`
- 退化声明 `handles_empty`

## 后续填充

- S0.4：SHA-256 内容哈希、精确统计算子
- Phase 1：Schema 校验器、精确去重算子
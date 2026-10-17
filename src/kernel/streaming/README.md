# kernel/streaming

流式模式 / Streaming mode.

## 定位

无界数据、在线清洗、实时过滤的执行模式基座。
一致性保证：**窗口内等价**（window-equiv）。

## 当前状态（S0.2）

- 窗口抽象 `WindowConfig` / `default_window` / `sliding_window` / `valid_window`
- 模式标识 `streaming_id` / `mode_tag` / `consistency_guarantee`

## 后续填充

- Phase 1：在线清洗流式算子、实时过滤算子
- Phase 2：分布式流式执行
# datatemporal/replay

回放与回溯 / Replay and backtracking.

## 定位

回放与回溯。架构 §4.4。

## 当前状态（S0.5）

- `ReplayTrace` 结构（trace_id + steps + result_fingerprint）
- `make_trace` / `empty_trace` 构造函数
- `step_count` 步数
# parallel 执行调度 & 并行分布式

> 对应架构 §3 二层 | Sprint：Phase 2+

## 职责

执行调度 & 并行分布式层：CPU / GPU / 流式 / Ray / 分布式。

## 与 kernel 协同

kernel 四模式（exact/approx/streaming/cache）的执行由本层调度到具体后端。

## 当前状态

S0.1 骨架占位。`parallel_id` 为占位标识，供根包重导出验证。

---

> parallel | DataVerse | 2026-10-17
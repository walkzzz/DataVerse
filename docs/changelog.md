# DataVerse Changelog

所有显著变更记录于此。格式参考 [Keep a Changelog](https://keepachangelog.com/)。

## [0.1.0-dev] - 2026-10-17

### S0.1 - 项目骨架 + Roadmap + 根包重导出空骨架

**新增 / Added**
- `moon.mod`：模块定义 `dataverse`
- 根包 `moon.pkg` + `dataverse.mbt`：重导出 12 个一级子包占位标识，对外入口 `@dataverse`
- 12 个一级子包骨架：`kernel` / `dataobject` / `opcore` / `datatemporal` / `recipe` / `datair` / `dosi` / `agent_kit` / `self_evolve` / `parallel` / `io` / `governance`，各含 `moon.pkg` + 占位 `<pkg>.mbt` + `README.md`
- `src/tests`：跨包测试包骨架
- `docs/roadmap.md`：Phase 0 Sprint 分解
- `docs/rules.md`：开发规则全集（适配 DataVerse）
- 根 `README.md`：中英文项目说明

**文档纠错 / Fixed**
- `rules.md` 与架构 §9 的 GeoVerse 命名残留 → DataVerse 对应（geoverse→dataverse、GeoIR→DataIR、AOCI→DOSI）
- 进度表清空 GeoVerse 历史（S0.1-S0.7 几何相关），重写为 DataVerse Phase 0 Sprint 分解

**验证 / Verified**
- `moon check`：0 error
- `moon test`：1 passed
- commit：`6ded33c`

### S0.2 - kernel 四模式执行内核框架 + 一致性契约

**新增 / Added**
- `src/kernel/kernel.mbt`：`pub(all) enum ExecMode`（Exact/Approx(Int)/Streaming/Cache）+ `pub(all) enum Consistency`（ByteExact/SeededBound/WindowEquiv/CacheHitEquiv）+ 契约函数 `mode_consistency` / `mode_name` / `mode_from_tag` / `all_mode_tags`
- `src/kernel/exact`：精确模式标识 + 退化声明 `handles_empty`
- `src/kernel/approx`：种子管理 `default_seed` / `valid_seed` + 误差界占位
- `src/kernel/streaming`：窗口抽象 `WindowConfig` / `default_window` / `sliding_window` / `valid_window`
- `src/kernel/cache`：缓存键 `CacheKey` / `make_key` / `is_hit`
- `src/tests`：12 个一致性回归测试（四模式契约 + 退化数据 + 子包聚合）

**技术发现 / Discoveries**（MoonBit 0.1.20260920）
- 同 module 子包引用：非根包需完整 module 前缀 `"dataverse/kernel/exact"`
- enum 构造器跨包构造需 `pub(all) enum`（`pub enum` 是 readonly）
- `derive(Show)` 弃用 → `derive(Debug)`；`assert_eq` 需 `Debug` trait
- `derive(Debug, Eq)` 需显式 `pub extend T with Trait::{method}` 消除 `implicit_impl_as_method` warning

**验证 / Verified**
- `moon check`：0 error 0 warning
- `moon test`：12 passed 0 failed
- commit：`c53d213`

---

> DataVerse Changelog | 2026-10-17
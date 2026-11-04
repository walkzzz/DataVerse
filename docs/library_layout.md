# DataVerse 库布局 / Library Layout

> 对照 OCaml janestreet/core 的「单 opam 包多模块」哲学，DataVerse 在单一 `moon.mod` 内按领域拆分为 10 个逻辑库。

## 依赖拓扑

```
                    lib-extcore ──────────┐
                    lib-datair ───────────┼───┐
                    lib-kernel ───────────┤   │
                                          │   │
                    lib-dataobject ───────┤   │   (dataobject, datatemporal, io)
                          │               │   │
                    lib-dosi ─────────────┤   │   (dosi, parallel)
                          │               │   │
                    lib-opcore ───────────┤   │   (opcore)
                          │               │   │
                    lib-agent ────────────┤   │   (agent_kit)
                          │               │   │
                    lib-learn ────────────┤   │   (learncore, recipe)
                          │               │   │
                    lib-qa ───────────────┤   │   (proof, testing)
                          │               │   │
                    lib-meta ─────────────┘   │   (spec, tests)
```

## 10 个逻辑库

| # | 库名 | 包含包组 | 层 | 依赖 | 说明 |
|---|------|---------|-----|------|------|
| 1 | `lib-extcore` | `extcore` | L0 | — | 826→20 领域 92 子包，纯数学/统计算法 |
| 2 | `lib-datair` | `datair` | L0 | — | 数据 IR（管道/优化器/算子/变换/融合） |
| 3 | `lib-kernel` | `kernel`, `governance`, `self_evolve` | L0 | — | 内核工具 + 治理 + 自演化 |
| 4 | `lib-dataobject` | `dataobject`, `datatemporal`, `io` | L1 | extcore | 数据对象 + 时态数据 + IO |
| 5 | `lib-dosi` | `dosi`, `parallel` | L2 | datair, dataobject | 数据操作 + 并行 |
| 6 | `lib-opcore` | `opcore` | L2 | dataobject, extcore, kernel | 121→12 子包，操作符引擎 |
| 7 | `lib-agent` | `agent_kit` | L2 | dosi, extcore | AI 代理工具包（LLM/检索/记忆/工具/对话） |
| 8 | `lib-learn` | `learncore`, `recipe` | L3 | extcore, opcore, dataobject | 89→11 子包，学习算法 + 数据处理流水线 |
| 9 | `lib-qa` | `proof`, `testing` | L4 | dataobject, learn, opcore, agent | 形式化证明 + MOCK/FAKE 测试框架 |
| 10 | `lib-meta` | `spec`, `tests` | L4 | 几乎所有 | 130 属性测试 + 1432 集成测试 |

## 依赖闭包

每个库的依赖是自洽的（无循环依赖，严格 DAG）：

```
lib-extcore:     []
lib-datair:      []
lib-kernel:      []
lib-dataobject:  [lib-extcore]
lib-dosi:        [lib-datair, lib-dataobject]
lib-opcore:      [lib-dataobject, lib-extcore, lib-kernel]
lib-agent:       [lib-dosi, lib-extcore]
lib-learn:       [lib-extcore, lib-opcore, lib-dataobject]
lib-qa:          [lib-dataobject, lib-learn, lib-opcore, lib-agent]
lib-meta:        [lib-agent, lib-datair, lib-dataobject, lib-dosi,
                  lib-kernel, lib-learn, lib-opcore, lib-parallel]
```

## 包结构统计

| 层 | 原始包数 | 重构后子包数 | 压缩率 |
|---|---------|------------|--------|
| extcore | 826 | ~92 | -89% |
| opcore | 121 | 12 | -90% |
| learncore | 89 | 11 | -88% |
| **合计** | **1036** | **~115** | **-89%** |

## 独立发布路径

当 MoonBit workspace 支持本地模块间依赖时，可按以下顺序独立发布：

1. **Phase 1**（L0 无依赖）：`lib-extcore`, `lib-datair`, `lib-kernel`
2. **Phase 2**（L1 依赖 L0）：`lib-dataobject`
3. **Phase 3**（L2 依赖 L0-L1）：`lib-dosi`, `lib-opcore`, `lib-agent`
4. **Phase 4**（L3 依赖 L0-L2）：`lib-learn`
5. **Phase 5**（L4 依赖 L0-L3）：`lib-qa`, `lib-meta`

## 对照 OCaml 生态

| OCaml 做法 | DataVerse 对应 |
|-----------|--------------|
| 一个 opam 包内含多模块（janestreet/core） | 单一 `moon.mod` 内 10 逻辑库 |
| `Core_kernel` → `Core` → `Core_unix` 分层 | L0 → L1 → L2 → L3 → L4 分层 |
| `open Core` 聚合导入 | `dataverse.mbt` 根包重导出 |
| dune `public` 模块可见性 | MoonBit `pub fn` / `pub(all) struct` |
| opam 依赖声明 | `moon.pkg` import 声明 |
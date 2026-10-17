# DataVerse 开发规则全集 / Development Rules

> **用途**：本文件是 DataVerse 项目所有开发规则的权威汇总，供 agent 与人类协作者复用。  
> **维护**：每次新增规则时回写本文件。  
> **优先级**：防跑偏规则 > 项目规则 > 个人偏好。

---

## 一、项目规则 / Project Rules

### R1 — 源码目录
全部源代码放在 `src/` 目录下。

### R2 — 多手段测试
MoonBit 形式化证明 + AI/FAKE/MOCK/E2E 多手段测试，确保无 bug。每个 Sprint 交付前 `moon check` 0 error、`moon test` 全通过。

### R3 — 代码文档注释
代码三级文档注释中英文（包级、类型级、方法级）。

### R4 — README 规范
README 中英文，美化，默认中文；每个子包也要 README.md。

### R5 — 迭代路线
先制定 `docs/roadmap.md` 迭代路线，按 Sprint 推进。

### R6 — 提交查证
提交历史有迹可循——每个 Sprint 完成回写 `roadmap.md` 状态 + commit hash。

### R7 — 自动迭代触发
没有任务迭代时，自动触发新的路线迭代计划（定时任务 `090586a2`，每日 9 点）。

### R8 — 文档治理
每次迭代后进行开源项目文档治理：更新根 README、roadmap、CHANGELOG、子包 README。

### R9 — 经验沉淀
开发经验教训沉淀复用：更新 memory（`C:\Users\Administrator\.codeartsdoer\memory\...`）。

### R10 — 一级子包重导出
一级子包（如 `src/kernel`、`src/dataobject`）也要 README.md 并重导出子包 API。

### R11 — 防跑偏规则（记/锁/回）
每一步做三件事：
1. **记**：把已确认的"规则/负责人/截止时间"写进固定区块；
2. **锁**：遇到与前序约定冲突的新要求，先停下，标注冲突来源，问"谁有权改"；
3. **回**：每完成一环，回写一句"已交付 x，下环依赖 Y"。
禁止在没确认的情况下，把群聊里的某句话当成最终决定。

### R12 — 根包重导出
项目根包（`dataverse/dataverse`，根目录 `moon.pkg` + `dataverse.mbt`）重导出所有一级子包公共 API，对外提供统一入口 `@dataverse`。

### R13 — Warning 治理 ⭐ 新增
每次迭代完成后都要进行 **warning 治理**：运行 `moon check` / `moon test`，对所有 warning 逐一处理（修复或显式抑制），目标 0 warning。

**已知可接受噪声**（trait extend 系统）：`extend T with Trait::{method}` 声明的方法若通过 `Trait::method(t, ...)` 调用而非 `t.method(...)`，会报 "Unused function"。这是 MoonBit trait 系统固有噪声，记录但不阻塞。

### R14 — 占位 todo 检查 ⭐ 新增
所有的占位 todo 项，每次迭代后都要检查是否具备条件完成。若依赖已满足且资源就绪，立即推进；否则标注阻塞原因。

### R15 — 规则输出复用 ⭐ 新增
所有规则输出到本文件 `docs/rules.md`，供 agent 与人类协作者复用。每次新增规则回写。

### R16 — 阶段门禁自动化 ⭐ 新增
每个 Sprint 交付前必须通过**五手段验证**：AI 辅助审查 + FAKE（假数据/退化数据）+ MOCK（模拟依赖）+ E2E（端到端跨包）+ 形式化证明（spec.mbt / proof_assert）。**全部通过则自动进入下一阶段**，不停顿等待确认。任一手段发现问题则停下修复，修复后重新验证。

**验证矩阵**：
| 手段 | 当前实现 | 目标 |
|------|----------|------|
| AI | moonbit-development-expert skill 辅助审查 | 每个 Sprint 代码审查 |
| FAKE | 退化数据测试（空/超长/乱码/模态缺失） | 每个 Sprint 补充退化用例 |
| MOCK | 后续 learncore/recipe 需 mock 外部依赖 | 按需补充 |
| E2E | tests.mbt 跨包集成测试 | 每个 Sprint 补充跨包用例 |
| 形式化证明 | spec.mbt / proof_assert（MoonBit 原生支持） | 关键算子补契约 |

---

## 二、MoonBit 技术要点 / Technical Notes

| 要点 | 说明 |
| --- | --- |
| 工具链版本 | MoonBit v0.1.20260920 |
| 配置文件 | `moon.mod`（TOML，键 `name`/`source`/`version` 等）/ `moon.pkg`（DSL，`import {}` 声明依赖，`//` 注释） |
| 科学计数法 | 不支持 `1e-13` 字面量，用 `0.000000000001` |
| pub enum 跨包 | 构造子跨包不可构造，需提供 `pub fn` 构造函数 |
| 字符串插值 | `{}` 不生效，用 `+` 拼接 |
| 关键字 | `var` 是关键字，不能做函数名 |
| 白盒测试 | `_wbtest.mbt` 后缀（避免 `@pkg` 前缀要求） |
| 布尔取反 | 用 `!expr`，`not(x)` 已 deprecated |
| 闭包调用 | record field 调用需 `(self.func)(x, y)` 而非 `self.func(x, y)` |
| trait 方法调用 | 跨包用 `Trait::method(obj, args)`，隐式提升已 deprecated |
| range 循环 | `for i in 0..<n`（字面量 OK）；表达式边界加括号 `0..<(n-1)`；返回值函数内用 C 风格 `for i = 0; i < n; i = i + 1` |
| Double sqrt | `value.sqrt()` 方法（非 `@math.sqrt`） |

### 重导出语法
```
pub using @pkg { type T, name1, trait Trait1 }
```
- 必须带 `{}`；`pub using @pkg` 不带花括号报错 "expect `{`"。
- 只能列类型/trait/顶层标识符，不能列方法 `Type::method`。
- 重导出类型后，其 pub 方法自动随类型可见。
- `moon.pkg` 不支持 `export` 段；`pub use` 非有效语法，应为 `pub using`。

### 根包
项目根目录加 `moon.pkg` + `<name>.mbt` 即为模块根包，可重导出一级子包对外统一入口。

---

## 三、迭代流程 / Iteration Workflow

每个 Sprint 执行步骤：

1. **查架构**：读 `DataVerse-数据算子库-ARCHITECTURE.md` 对应章节，明确范围。
2. **实现**：写源码 + 白盒测试（`_wbtest.mbt`）。
3. **验证**：`moon check` 0 error + `moon test` 全通过。
4. **Warning 治理**（R13）：逐一处理 warning，目标 0 warning。
5. **重导出**（R10/R12）：一级子包聚合 + 根包重导出。
6. **文档治理**（R8）：更新 README / roadmap / CHANGELOG / 子包 README。
7. **经验沉淀**（R9）：更新 memory。
8. **占位检查**（R14）：检查占位 todo 是否可推进。
9. **提交**（R6）：git commit + 回写 roadmap commit hash。
10. **回写**（R11 回）：回写"已交付 x，下环依赖 Y"。

---

## 四、进度查证 / Progress Audit

> DataVerse 全新项目，Phase 0 地基固化期 Sprint 分解（对应架构 §6 Phase 0）。

| Sprint | 内容 | 状态 | commit |
|--------|------|------|--------|
| S0.1 | 项目骨架 + Roadmap + 根包重导出空骨架 | ✅ | 6ded33c |
| S0.2 | kernel 四模式执行内核（exact/approx/streaming/cache） | ✅ | c53d213 |
| S0.3 | 基础数据层（DataObject/Schema/Chunk/Embedding/Record/Dataset/Lineage/QualityCard） | ✅ | d50dee2 |
| S0.4 | opcore 框架 + 清洗/去重/过滤三类核心算子 | ✅ | deb2c4f |
| S0.5 | datatemporal 数据结构定型（version/lineage/drift/replay） | ✅ | e3ace5a |
| S0.6 | DataIR 基础语法定义（实体 IR + 算子 IR） | ✅ | 5f4bb15 |
| S0.7 | DOSI 基础设施原型（Builder + Router 初始版本） | ✅ | 4aa3fbf |
| S1.1 | opcore 补齐 14 类算子（ingest/normalize/quality/transform/annotate/select/mix/pack/eval/lineage_op/safety 11 子包） | ✅ | 2c9e030 |
| S1.2 | learncore 基礎（regression/classify/cluster/feature/metrics 6 子包） | ✅ | c2c9eca |
| S1.3 | recipe 复合线（cleaning_line/dedup_line/quality_line/balance_line 4 子包） | ✅ | aee56c3 |
| S1.4 | DataIR 流水线 IR（DAG）+ 基礎优化器（ir_pipeline/ir_optimizer 2 子包） | ✅ | a589beb |
| S1.5 | datatemporal 深化（version/lineage/replay/drift 4 子包扩展） | ✅ | 9e083cc |
| S1.6 | 执行后端 CPU 串行（parallel/cpu_serial 1 子包） | ✅ | 24b67d2 |
| S1.7 | DOSI 完善（context_budget + verifier 2 子包） | ✅ | ec8f631 |

**当前测试**：134 · **当前 API**：260（pub fn）+ 50（pub type）

---

> **文件结束** | DataVerse Rules v1.0 | 2026-10-17
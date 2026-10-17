# agent_kit 自然语言数据编排

> 对应架构 §4.8 | Sprint：Phase 2

## 职责

自然语言转 DataIR 编排。把"把这份语料清洗去重并配比成训练集"转为引擎原生算子图。**Data-Juicer Agent 即此层的一种前端范式**（多智能体：规划者 / 算子选择者 / 执行者 / 质检者）。

## 编排范式

- Planner-Executor
- ReAct
- Data-Juicer Agent 多智能体

## 与 DOSI 联动

所有自然语言数据编排，全部经过 DOSI 检索路由，按 Token 预算召回相关算子。

## 当前状态

S0.1 骨架占位。`agent_kit_id` 为占位标识，供根包重导出验证。

---

> agent_kit | DataVerse | 2026-10-17
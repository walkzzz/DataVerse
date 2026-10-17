# dosi 符号语义索引基础设施

> 对应架构 §4.7 | Sprint：S0.7

## 职责

对标 GeoVerse 的 AOCI，面向 AI 的数据符号语义索引。**不是向量检索 RAG**，是**符号坐标 + 语义摘要的双层结构化索引**。

## 核心设计

为每个算子、Schema、recipe 生成**符号坐标**（分类位置、模态、依赖、契约）+ **语义摘要**（核心职责、参数要点、输入输出契约）。完整文档与实现保留在外部存储；模型只读索引条目，按需拉取。

> **Token 缩减原理**：先读 DOSI 索引建立算子全景认知，仅在需要细节时按需加载，可降低 70%~90% 无效 Token 开销。

## 四大核心子组件

```
dosi/
├── builder         # 索引构建器
├── router          # 检索路由
├── context_budget  # 上下文预算管理
└── verifier        # 索引校验器
```

- **DOSI-Builder**：解析源码/算子注册表/Schema/recipe/DataIR，生成符号坐标 + 依赖图 + 契约摘要
- **DOSI-Router**：自然语言需求 → 定位涉及算子/Schema，评估 Token 预算，按需召回
- **DOSI-ContextBudget**：全局 Token 配额分区，超预算自动压缩降级
- **DOSI-Verifier**：校验索引依赖图与真实代码一致，检测过期与漂移

## 非目标

- ❌ 不是向量 RAG 知识库
- ❌ 不做数据计算，不替代 opcore 与执行内核
- ❌ 不替代 datatemporal

## 当前状态

S0.1 骨架占位。`dosi_id` 为占位标识，供根包重导出验证。

---

> dosi | DataVerse | 2026-10-17
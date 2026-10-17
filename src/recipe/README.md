# recipe 复合数据流水线

> 对应架构 §4.5 | Sprint：Phase 1（依赖 S0.4 opcore）

## 职责

对标 GeoVerse 的 spatial_analysis——把原子算子编排为面向任务的高阶复合算子。

## 六条复合线

```
recipe/
├── cleaning_line   # 标准清洗线（解析→规范化→去boilerplate→脱敏）
├── dedup_line      # 多级去重线（精确→近似→语义）
├── quality_line    # 质量线（过滤→评分→选择）
├── balance_line    # 配比线（配比→混合→采样）
├── packing_line    # 打包线（分块→tokenize→序列化）
└── eval_line       # 评估线（质量评估→污染检测→漂移检测）
```

每个复合算子本身可被 DataIR 表达、可被 Agent 编排、可被血缘追踪。

## 当前状态

S0.1 骨架占位。`recipe_id` 为占位标识，供根包重导出验证。

---

> recipe | DataVerse | 2026-10-17
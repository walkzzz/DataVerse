# self_evolve 自演化层

> 对应架构 §4.8 | Sprint：Phase 4（前沿预研）

## 职责

分**两类规划**协同——**自省类**（向内：发现与修复已知问题）与**探索类**（向外：主动搜索未知高价值空间）。

## 子包规划

```
self_evolve/
├── introspect    # 自省类：规则发现、算子调优、反例生成、recipe 优化
└── explore       # 探索类：数据/算子/配方/参数/协同探索引擎
    ├── space     # 探索空间定义
    ├── policy    # 探索策略（贝叶斯/进化/RL/主动学习/bandit）
    ├── proposer  # 假设与候选生成
    ├── evaluator # 奖励信号评估
    └── memory    # 探索记忆与预算管控
```

## 自省类（Introspection）

- 数据规则发现、算子自动调优、反例生成、recipe 自动优化

## 探索类（Exploration）

四大探索空间：数据空间 / 算子配方空间 / 参数空间 / 数据-模型协同空间。

探索边界：预算受限、候选配方不直接上线（经 eval_line + 门禁）、全程可回放可举证。

## 当前状态

S0.1 骨架占位。`self_evolve_id` 为占位标识，供根包重导出验证。

---

> self_evolve | DataVerse | 2026-10-17
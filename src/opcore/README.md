# opcore 全域算子库

> 对应架构 §4.3 | Sprint：S0.4（框架 + 清洗/去重/过滤三类）

## 职责

数据算子 + 模型/学习算子的一等集合。所有算子遵循统一签名 `Operator(Input) -> Output + Lineage + Metrics`，分原子算子与复合算子两级。**14 类数据算子 + 6 类模型/学习算子（ML/DL），共 20 类**。

## 算子统一契约

```
Operator {
  name            # 算子名（全局唯一）
  category        # 14 类之一
  modality        # text / image / audio / video / table / code / multi
  signature       # 输入 Schema → 输出 Schema
  params          # 参数（带默认值、范围、类型）
  determinism     # exact / approx(seed) / stochastic
  cost_model      # 复杂度、预期 Token、预期耗时
  metrics         # 产出指标
  reversible      # 是否可逆
  ir_form         # 对应的 DataIR 节点类型
}
```

## 14 类数据算子

① 摄入解析 ② 格式化 ③ 清洗 ④ 去重 ⑤ 过滤 ⑥ 质量评分 ⑦ 变换增强 ⑧ 标注推理 ⑨ 选择采样 ⑩ 配比混合 ⑪ 打包序列化 ⑫ 评估验证 ⑬ 血缘版本 ⑭ 安全合规

## 6 类模型/学习算子

⑮ 传统 ML ⑯ 深度学习 ⑰ 表示学习/自监督 ⑱ 模型评估与选择 ⑲ 模型适配与压缩 ⑳ 训练与优化

## 子包规划

```
opcore/
├── ingest/normalize/clean/dedup/filter    # S0.4 优先
├── quality/transform/annotate/select/mix  # Phase 1
├── pack/eval/lineage/safety               # Phase 1
├── ml/dl/ssl/model_eval/adapt/optim       # learncore，Phase 1+
└── registry                               # 算子注册表 + 契约校验
```

## 当前状态

S0.1 骨架占位。`opcore_id` 为占位标识，供根包重导出验证。

---

> opcore | DataVerse | 2026-10-17
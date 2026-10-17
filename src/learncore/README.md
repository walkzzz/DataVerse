# learncore / 学习核心

模型/学习算子层。架构 §4.3.2 ⑥。包含传统 ML + DL + 模型评估。

## 子包 / Subpackages

| 子包 | 内容 | Sprint |
|------|------|--------|
| `regression` | 线性/多项式回归 | S1.2 |
| `classify` | 分类器（KNN/朴素贝叶斯） | S1.2 |
| `cluster` | 聚类（K-Means） | S1.2 |
| `feature` | 特征工程（标准化/归一化/one-hot） | S1.2 |
| `metrics` | 评估指标（accuracy/precision/recall/F1/MSE） | S1.2 |
| `dl_layers` | DL 层（Linear + Activation + Conv2d + MaxPool + Dropout + BatchNorm） | S2.3 + S2.9 |
| `dl_losses` | DL 损失（MSE + CrossEntropy + Hinge） | S2.3 |
| `dl_optimizers` | DL 优化器（SGD + Adam） | S2.3 |
| `cross_validation` | 交叉验证（k-fold） | S2.4 |
| `hyperparam_search` | 超参搜索（网格搜索） | S2.4 |

## 公共 API / Public API

通过 `@dataverse` 重导出，或直接 `@learncore` 引用。

## 设计说明 / Design Notes

- MoonBit 无真实张量库，DL 算子采用**契约 + 前向传播模拟**策略
- 元数据驱动：操作结构体（如 Conv2dMeta），不操作真实张量
- 退化安全：所有算子对空输入/零维度有安全退化
# extcore — 扩展核心算法库 / Extended Core Algorithms

> lib-extcore | 层 L0 | 无依赖 | 826→92 子包（-89%）

## 定位

纯数学/统计算法库，是 DataVerse 的最底层依赖。所有函数无副作用，可独立使用。

## 19 个领域

| 领域 | 子包数 | 说明 |
|------|--------|------|
| math | 11 | 线性代数/微积分/特殊函数/优化/插值 |
| stats | 8 | 描述统计/推断统计/分布/假设检验 |
| ds | 7 | 树/图/堆/队列/哈希表 |
| graph | 5 | 搜索/路径/流/匹配/着色 |
| ml | 6 | 聚类/降维/核方法/贝叶斯 |
| signal | 8 | 滤波/频谱/小波/自适应 |
| image | 6 | 滤波/几何/形态学/特征 |
| audio | 5 | 频谱/效果/分析/合成 |
| video | 4 | 运动/跟踪/分割/编码 |
| text | 6 | 分词/嵌入/相似度/主题 |
| chem | 4 | 分子/反应/描述符/SMILES |
| geo | 5 | 坐标/距离/缓冲/叠加/投影 |
| physics | 5 | 力学/电磁/热力学/量子 |
| bio | 4 | 序列/比对/结构/进化 |
| econ | 4 | 定价/风险/时间序列/博弈 |
| crypto | 4 | 哈希/对称/非对称/签名 |
| string | 4 | 匹配/编辑距离/压缩/正则 |
| numeric | 3 | ODE/PDE/稀疏矩阵 |
| optim | 3 | 凸优化/组合优化/元启发式 |

## 使用

```moonbit
import { "dataverse/extcore/math/linear" }
import { "dataverse/extcore/stats/dist" }
```
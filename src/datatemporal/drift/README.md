# datatemporal/drift

漂移检测、数据衰老 / Drift detection, data aging.

## 定位

漂移检测、数据衰老。架构 §4.4。

## 当前状态（S0.5）

- `DriftReport` 结构（metric + baseline + current + drift_score）
- `make_drift_report` 构造函数
- `is_significant` 阈值判定
# datatemporal/version

版本塔、快照 / Version tower, snapshots.

## 定位

数据版本塔与快照。架构 §4.4.1。

## 当前状态（S0.5）

- `Version` 结构（version_id + parent + timestamp + snapshot_ref）
- `VersionTower` 结构 + `empty_tower` / `append` / `height`
- `make_version` / `root_version` 构造函数
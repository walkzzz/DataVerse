# dataobject/record_dataset

记录与数据集 / Record and dataset.

## 定位

单条样本（Record）与数据集（Dataset）。架构 §4.2。

## 当前状态（S0.3）

- `Record` 结构（id + fields）+ 构造函数 `make_record` / `empty_record` / `record_field_count`
- `Dataset` 结构（records + version + mix_ratio）+ 构造函数 `make_dataset` / `make_dataset_with_ratio` / `empty_dataset` / `size`

## 后续填充

- S0.5：版本/血缘关联（datatemporal）
- S0.4：质量档案关联（QualityCard）
- Phase 1：配比算子（opcore mix）
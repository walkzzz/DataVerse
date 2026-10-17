# datatemporal/lineage

双向/字段级血缘 / Bidirectional, field-level lineage.

## 定位

双向血缘 + 字段级血缘。架构 §4.4.2。

## 当前状态（S0.5）

- `BiLineage` 结构（operator + inputs + outputs + params）
- `FieldLineage` 结构（field_name + source_fields + operator）
- `make_bi_lineage` / `make_field_lineage` 构造函数
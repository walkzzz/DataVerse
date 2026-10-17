# opcore/filter

过滤算子 / Filter operators.

## 定位

规则过滤、统计过滤、质量模型过滤、安全合规过滤、模态过滤。架构 §4.3.2 ⑤。

## 当前状态（S0.4）

- `length_filter`：长度过滤
- `non_empty_filter`：非空过滤
- `filter_all`：批量过滤（谓词）

## 后续填充

- Phase 1：困惑度/重复率/熵统计过滤、安全合规过滤、模态过滤
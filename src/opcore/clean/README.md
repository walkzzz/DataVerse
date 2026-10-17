# opcore/clean

清洗算子 / Clean operators.

## 定位

去 boilerplate、标签清理、隐私脱敏、空记录过滤。架构 §4.3.2 ③。

## 当前状态（S0.4）

- `remove_empty`：空记录过滤
- `strip_whitespace`：首尾空白清理
- `content_len`：内容长度

## 后续填充

- Phase 1：HTML/Markdown 标签清理、PII 脱敏、boilerplate 去除
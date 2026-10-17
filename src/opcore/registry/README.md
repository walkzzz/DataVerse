# opcore/registry

算子注册表 / Operator registry.

## 定位

算子注册表 + 契约校验。架构 §4.3。

## 当前状态（S0.4）

- `Registry` 结构 + `empty` / `register` / `lookup` / `size`
- `valid_operator`：契约校验（名称非空）

## 后续填充

- Phase 1：完整契约校验（signature/params/cost_model）、算子依赖图
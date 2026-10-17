# dataobject/schema

模式描述与校验 / Schema description and validation.

## 定位

字段、类型、嵌套结构、约束的基础结构。架构 §4.2。

## 当前状态（S0.3）

- `FieldType` 枚举（Text/Integer/Float/Boolean/Nested）
- `Field` 结构（name + field_type）
- `Schema` 结构（fields）+ 构造函数 `field` / `make` / `empty` / `size`

## 后续填充

- S0.4：Schema 校验逻辑（opcore normalize）
- Phase 1：嵌套结构、约束系统
---
topics: [sop, workflow]
doc_kind: note
created: 2026-10-16
updated: 2026-11-04
---

# DataVerse — MoonBit 标准操作规程 (SOP)

> 本文档定义 DataVerse 项目的 MoonBit 开发工作流。

## 1. 环境准备

```bash
moon version  # 应为 v0.1.20260920+
moon clean    # 切换版本后必须 clean
```

## 2. 开发流程

### 2.1 新增包

1. 在 `src/` 下创建目录
2. 创建 `moon.pkg`，声明 `import`
3. 创建 `.mbt` 源文件（文件名不能含 `_test`）
4. 在根 `moon.pkg` 中添加导入
5. 在 `dataverse.mbt` 中添加重导出
6. 运行 `moon check` 验证

### 2.2 新增 trait 实现

1. 确认 trait 定义在 `src/core/traits/traits.mbt`
2. 在目标类型的包中创建 `traits_impl.mbt`
3. 在包的 `moon.pkg` 中添加 `"dataverse/core/traits"` 导入
4. 实现 trait 并运行 `moon check` 验证

### 2.3 新增安全 API

1. 在 `src/extcore/_common/safe.mbt` 中添加函数
2. 返回 `Result[T, @error.DataVerseError]`
3. 在 `safe_test.mbt` 中添加测试
4. 运行 `moon test` 验证

### 2.4 新增测试

1. 创建 `*_test.mbt` 文件（文件名必须含 `_test`）
2. 引用同包 API 用 `@包名.` 前缀
3. 构造 enum 变体用 `@包.EnumType::Variant(...)`

## 3. 验证流程

```bash
moon check   # 目标: 0 errors, 0 warnings
moon test    # 目标: all passed
moon fmt
moon info
```

## 4. 常见问题

| 问题 | 修复 |
|------|------|
| 循环依赖 | 子包不能导入父包；core 是最底层 |
| unused_package | 从 moon.pkg 删除未使用的导入 |
| unused_value | 用 `_` 替换未使用的参数 |
| test_unqualified_package | 添加 `@包名.` 前缀 |
| 源文件名含 `_test` | 改名（会被视为测试文件）|

## 5. 提交规范

```bash
moon check && moon test && moon fmt
git add -A && git commit -m "feat: 简短描述"
```

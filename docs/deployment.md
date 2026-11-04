# DataVerse 部署运维文档

> **版本**：0.1.0-dev | **日期**：2026-11-04

## 1. 构建与发布

### 1.1 构建步骤

```bash
# 1. 清理缓存
moon clean

# 2. 类型检查（必须 0 errors）
moon check

# 3. 运行测试（必须全通过）
moon test

# 4. 格式化
moon fmt

# 5. 生成 API 信息
moon info
```

### 1.2 发布检查清单

- [ ] `moon check` 0 errors
- [ ] `moon test` 全通过
- [ ] 所有 `pub fn` 有 `///` 注释
- [ ] changelog.md 已更新
- [ ] roadmap.md 状态已回写
- [ ] 无未使用的导入（warning 治理）

### 1.3 可执行入口

| 入口 | 路径 | 用途 |
|------|------|------|
| CLI | `apps/cli/cmd/main` | 命令行工具 |
| Bench | `apps/bench` | 基准测试 |
| Demo | `apps/demo` | 功能展示 |
| Proof | `apps/proof` | 证明验证 |
| Stats | `apps/stats` | 统计分析 |
| Extcore | `apps/extcore` | 语义包探索 |
| Info | `apps/info` | 项目信息 |

## 2. 监控与可观测性

### 2.1 日志

CLI 工具使用 `println` 输出结果和错误信息。错误信息格式：`Error[E001]: message`

### 2.2 测试监控

```bash
# 运行全量测试并查看统计
moon test

# 输出示例：
# Total tests: 2006, passed: 2006, failed: 0. [wasm]
```

### 2.3 覆盖率分析

```bash
moon coverage analyze
```

## 3. 回滚方案

### 3.1 版本回滚

```bash
# 查看历史版本
git log --oneline -20

# 回滚到指定版本
git checkout <commit-hash>
moon clean && moon check && moon test
```

### 3.2 安全 API 回滚

安全 API 返回 `Result` 类型，调用方可选择回退行为：

```moonbit
match @_common.safe_mean(data) {
  Ok(v) => use_value(v)
  Err(e) => {
    // 回退到默认值或日志记录
    log_error(e)
    default_value()
  }
}
```

## 4. 应急预案

| 场景 | 症状 | 处理 |
|------|------|------|
| 编译失败 | `moon check` 报错 | 检查 MoonBit 版本，`moon clean` 后重试 |
| 测试失败 | `moon test` 报错 | 查看失败测试名，定位到具体 test 块 |
| 性能退化 | 执行时间增加 | 用 `apps/bench` 基准测试对比 |
| API 变更 | `moon info` 报告变更 | 检查 .mbti 文件差异 |

## 5. 依赖管理

### 5.1 工具链依赖

- MoonBit v0.1.20261020（唯一外部依赖）

### 5.2 内部包依赖

核心包无循环依赖，依赖方向：
```
core/traits ← core/error ← extcore/_common ← opcore/learncore ← ...
```

## 6. 性能基准

| 操作 | 数据规模 | 预期时间 |
|------|---------|---------|
| safe_mean | 1,000 元素 | < 1ms |
| safe_std | 1,000 元素 | < 1ms |
| safe_sort | 1,000 元素 | < 5ms |
| safe_normalize | 1,000 元素 | < 1ms |
| trait name() | 任意类型 | < 0.01ms |
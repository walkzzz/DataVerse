# testing — 多手段测试框架

R16 阶段门禁测试框架，提供 MOCK 和 FAKE 测试手段。

## 子包

| 包 | 说明 |
|----|------|
| `testing/mock` | MOCK 框架：5 个 `pub(open) trait` + mock 实现 |
| `testing/fake` | FAKE 退化测试：五类退化数据生成器 |

## mock trait

- `LLMClient` — 大语言模型调用
- `Embedder` — 文本向量化
- `ToolExecutor` — 工具执行
- `MemoryPersistence` — 记忆持久化
- `IntentClassifier` — LLM 意图分类
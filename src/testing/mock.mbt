///|
/// # testing/mock — MOCK 测试框架 / Mock Test Framework
///
/// R16 阶段门禁第 3 手段：MOCK（模拟依赖）。
///
/// 为 agent_kit 的 5 个外部依赖缺口提供 `pub(open) trait` 抽象 + mock 实现：
/// 1. `LLMClient` — 大语言模型调用（call_llm）
/// 2. `Embedder` — 文本向量化（embed）
/// 3. `ToolExecutor` — 工具执行（execute_tool）
/// 4. `MemoryPersistence` — 记忆持久化（save/load）
/// 5. `IntentClassifier` — LLM 意图分类（llm_classify）
///
/// 每个 trait 提供 MockXxx 实现，返回预设/固定响应，用于隔离测试。

///|
/// ============================================================================
/// 1. LLMClient — 大语言模型调用
/// ============================================================================

///|
/// LLM 客户端 trait / LLM client trait.
pub(open) trait LLMClient {
  call(Self, @llm.LLMRequest) -> @llm.LLMResponse
}

///|
/// Mock LLM 客户端 / Mock LLM client.
pub struct MockLLMClient {
  response_content : String
  should_succeed : Bool
  error_message : String
}

///|
/// 构造 Mock LLM 客户端（成功模式）/ Create mock LLM client (success mode).
pub fn make_mock_llm_success(content : String) -> MockLLMClient {
  { response_content: content, should_succeed: true, error_message: "" }
}

///|
/// 构造 Mock LLM 客户端（失败模式）/ Create mock LLM client (failure mode).
pub fn make_mock_llm_error(error : String) -> MockLLMClient {
  { response_content: "", should_succeed: false, error_message: error }
}

///|
/// 实现 LLMClient for MockLLMClient
pub impl LLMClient for MockLLMClient with call(self, req) {
  let prompt_tokens = @llm.estimate_message_tokens(req.messages)
  if self.should_succeed {
    let completion_tokens = @llm.estimate_tokens(self.response_content)
    @llm.make_response(
      self.response_content,
      "stop",
      prompt_tokens,
      completion_tokens,
      true,
      "",
    )
  } else {
    @llm.make_response(
      "",
      "error",
      prompt_tokens,
      0,
      false,
      self.error_message,
    )
  }
}

pub extend MockLLMClient with LLMClient::{call}

///|
/// ============================================================================
/// 2. Embedder — 文本向量化
/// ============================================================================

///|
/// Embedding 模型 trait / Embedding model trait.
pub(open) trait Embedder {
  embed(Self, String) -> Array[Double]
}

///|
/// Mock Embedder / Mock embedder.
pub struct MockEmbedder {
  dim : Int32
}

///|
/// 构造 Mock Embedder / Create mock embedder.
pub fn make_mock_embedder(dim : Int32) -> MockEmbedder {
  { dim, }
}

///|
/// 实现 Embedder for MockEmbedder
pub impl Embedder for MockEmbedder with embed(self, text) {
  let result : Array[Double] = []
  let mut hash = 0
  for c in text.to_array() {
    hash = (hash * 31 + c.to_int()) % 1000000
  }
  for i in 0..<self.dim {
    let val = ((hash * (i + 1) * 2147483647) % 10000).to_double() / 10000.0
    result.push(val * 2.0 - 1.0)
  }
  result
}

pub extend MockEmbedder with Embedder::{embed}

///|
/// ============================================================================
/// 3. ToolExecutor — 工具执行
/// ============================================================================

///|
/// 工具执行器 trait / Tool executor trait.
pub(open) trait ToolExecutor {
  execute(Self, @tool.ToolCall) -> @tool.ToolResult
}

///|
/// Mock 工具执行器 / Mock tool executor.
pub struct MockToolExecutor {
  output : String
  should_succeed : Bool
  error_message : String
}

///|
/// 构造 Mock 工具执行器（成功模式）/ Create mock tool executor (success mode).
pub fn make_mock_executor_success(output : String) -> MockToolExecutor {
  { output, should_succeed: true, error_message: "" }
}

///|
/// 构造 Mock 工具执行器（失败模式）/ Create mock tool executor (failure mode).
pub fn make_mock_executor_error(error : String) -> MockToolExecutor {
  { output: "", should_succeed: false, error_message: error }
}

///|
/// 实现 ToolExecutor for MockToolExecutor
pub impl ToolExecutor for MockToolExecutor with execute(self, call) {
  if self.should_succeed {
    @tool.make_tool_result(call.id, true, self.output, "", 0.0)
  } else {
    @tool.make_tool_result(call.id, false, "", self.error_message, 0.0)
  }
}

pub extend MockToolExecutor with ToolExecutor::{execute}

///|
/// ============================================================================
/// 4. MemoryPersistence — 记忆持久化
/// ============================================================================

///|
/// 记忆持久化 trait / Memory persistence trait.
pub(open) trait MemoryPersistence {
  save(Self, @memory.MemoryStore) -> Bool
  load(Self, String) -> @memory.MemoryStore
}

///|
/// Mock 记忆持久化 / Mock memory persistence.
pub struct MockMemoryPersistence {
  storage : Array[@memory.MemoryStore]
}

///|
/// 构造 Mock 记忆持久化 / Create mock memory persistence.
pub fn make_mock_persistence() -> MockMemoryPersistence {
  { storage: [] }
}

///|
/// 实现 MemoryPersistence for MockMemoryPersistence
pub impl MemoryPersistence for MockMemoryPersistence with save(self, store) {
  self.storage.push(store)
  true
}

///|
pub impl MemoryPersistence for MockMemoryPersistence with load(self, _id) {
  if self.storage.length() > 0 {
    self.storage[self.storage.length() - 1]
  } else {
    @memory.make_memory_store(100, 1000)
  }
}

pub extend MockMemoryPersistence with MemoryPersistence::{save, load}

///|
/// ============================================================================
/// 5. IntentClassifier — LLM 意图分类
/// ============================================================================

///|
/// LLM 意图分类器 trait / LLM intent classifier trait.
pub(open) trait IntentClassifier {
  classify(Self, String) -> String
}

///|
/// Mock 意图分类器 / Mock intent classifier.
pub struct MockIntentClassifier {
  intent : String
}

///|
/// 构造 Mock 意图分类器 / Create mock intent classifier.
pub fn make_mock_classifier(intent : String) -> MockIntentClassifier {
  { intent, }
}

///|
/// 实现 IntentClassifier for MockIntentClassifier
pub impl IntentClassifier for MockIntentClassifier with classify(self, _text) {
  self.intent
}
pub extend MockIntentClassifier with IntentClassifier::{classify}
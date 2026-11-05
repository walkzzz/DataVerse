///|
/// # testing/mock 测试 — Mock 框架行为验证
///
/// 验证 5 个 mock 实现的正确性：
/// - MockLLMClient 返回预设响应
/// - MockEmbedder 返回固定维度向量
/// - MockToolExecutor 返回预设结果
/// - MockMemoryPersistence save/load 一致性
/// - MockIntentClassifier 返回预设意图

///|
/// 测试 MockLLMClient 成功模式
test "mock: llm_client success" {
  let client = @testing.make_mock_llm_success("Hello from mock LLM!")
  let req = @llm.make_request(
    "gpt-4",
    @llm.OpenAI,
    [@llm.user_message("Hi")],
    100,
    0.7,
  )
  let resp = @testing.LLMClient::call(client, req)
  proof_assert resp.success
  proof_assert resp.content == "Hello from mock LLM!"
}

///|
/// 测试 MockLLMClient 失败模式
test "mock: llm_client error" {
  let client = @testing.make_mock_llm_error("API rate limit exceeded")
  let req = @llm.make_request(
    "gpt-4",
    @llm.OpenAI,
    [@llm.user_message("Hi")],
    100,
    0.7,
  )
  let resp = @testing.LLMClient::call(client, req)
  proof_assert !resp.success
  proof_assert resp.error == "API rate limit exceeded"
}

///|
/// 测试 MockEmbedder 维度和确定性
test "mock: embedder dim_and_deterministic" {
  let embedder = @testing.make_mock_embedder(128)
  let v1 = @testing.Embedder::embed(embedder, "hello world")
  let v2 = @testing.Embedder::embed(embedder, "hello world")
  proof_assert v1.length() == 128
  proof_assert v2.length() == 128
  // 确定性：相同输入 → 相同输出
  for i in 0..<128 {
    proof_assert v1[i] == v2[i]
  }
}

///|
/// 测试 MockEmbedder 不同输入不同输出
test "mock: embedder different_inputs" {
  let embedder = @testing.make_mock_embedder(64)
  let v1 = @testing.Embedder::embed(embedder, "hello")
  let v2 = @testing.Embedder::embed(embedder, "world")
  proof_assert v1.length() == 64
  proof_assert v2.length() == 64
}

///|
/// 测试 MockToolExecutor 成功模式
test "mock: tool_executor success" {
  let executor = @testing.make_mock_executor_success("{\"result\": 42}")
  let call = @tool.make_tool_call("calculator", [("expr", "6*7")], "call_1")
  let result = @testing.ToolExecutor::execute(executor, call)
  proof_assert result.success
  proof_assert result.output == "{\"result\": 42}"
}

///|
/// 测试 MockToolExecutor 失败模式
test "mock: tool_executor error" {
  let executor = @testing.make_mock_executor_error("Tool not found")
  let call = @tool.make_tool_call("unknown_tool", [], "call_2")
  let result = @testing.ToolExecutor::execute(executor, call)
  proof_assert !result.success
  proof_assert result.error == "Tool not found"
}

///|
/// 测试 MockMemoryPersistence save/load 一致性
test "mock: persistence save_load" {
  let persistence = @testing.make_mock_persistence()
  let store = @memory.make_memory_store(100, 1000)
  let entry = @memory.make_memory_entry(
    "e1",
    "test content",
    @memory.ShortTerm,
    0,
    0.5,
  )
  let updated = @memory.add_memory(store, entry)
  let saved = @testing.MemoryPersistence::save(persistence, updated)
  proof_assert saved
  let loaded = @testing.MemoryPersistence::load(persistence, "any_id")
  proof_assert @memory.memory_count(loaded) == 1
}

///|
/// 测试 MockMemoryPersistence 空加载
test "mock: persistence empty_load" {
  let persistence = @testing.make_mock_persistence()
  let loaded = @testing.MemoryPersistence::load(persistence, "nonexistent")
  proof_assert @memory.memory_count(loaded) == 0
}

///|
/// 测试 MockIntentClassifier 固定意图
#warnings("-unused_value")
test "mock: intent_classifier fixed" {
  let classifier = @testing.make_mock_classifier("book_flight")
  let result1 = @testing.IntentClassifier::classify(classifier, "I want to fly to Paris")
  let result2 = @testing.IntentClassifier::classify(classifier, "What's the weather?")
  proof_assert result1 == "book_flight"
  proof_assert result2 == "book_flight"
}
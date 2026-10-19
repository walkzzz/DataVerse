///|
/// # agent_kit/llm LLM 集成 / LLM Integration
///
/// LLM 模型调用、响应解析、token 计数、流式处理。
/// S11.1 新建。
///
/// # LLM integration operators

/// LLM 提供商 / LLM provider.
pub(all) enum LLMProvider {
  OpenAI
  Anthropic
  Local
  Custom
}

/// LLM 角色 / LLM role.
pub(all) enum LLMRole {
  System
  User
  Assistant
}

/// 聊天消息 / Chat message.
pub struct ChatMessage {
  role : LLMRole
  content : String
  tokens : Int
}

/// LLM 请求 / LLM request.
pub struct LLMRequest {
  model : String
  provider : LLMProvider
  messages : Array[ChatMessage]
  max_tokens : Int
  temperature : Double
  top_p : Double
  stream : Bool
}

/// LLM 响应 / LLM response.
pub struct LLMResponse {
  content : String
  finish_reason : String
  prompt_tokens : Int
  completion_tokens : Int
  total_tokens : Int
  success : Bool
  error : String
}

/// 构造聊天消息 / Create chat message.
pub fn make_message(role : LLMRole, content : String) -> ChatMessage {
  { role: role, content: content, tokens: estimate_tokens(content) }
}

/// 构造 LLM 请求 / Create LLM request.
pub fn make_request(
  model : String,
  provider : LLMProvider,
  messages : Array[ChatMessage],
  max_tokens : Int,
  temperature : Double,
) -> LLMRequest {
  { model: model, provider: provider, messages: messages, max_tokens: max_tokens, temperature: temperature, top_p: 1.0, stream: false }
}

/// 构造 LLM 响应 / Create LLM response.
pub fn make_response(
  content : String,
  finish_reason : String,
  prompt_tokens : Int,
  completion_tokens : Int,
  success : Bool,
  error : String,
) -> LLMResponse {
  { content: content, finish_reason: finish_reason, prompt_tokens: prompt_tokens, completion_tokens: completion_tokens, total_tokens: prompt_tokens + completion_tokens, success: success, error: error }
}

///===
/// Token 估计 / Token estimation

/// 估计 token 数 / Estimate token count (rough: 1 token per 4 chars).
pub fn estimate_tokens(text : String) -> Int {
  (text.length() + 3) / 4
}

/// 估计消息 token / Estimate message tokens.
pub fn estimate_message_tokens(messages : Array[ChatMessage]) -> Int {
  let mut total = 0
  for i in 0..<messages.length() {
    total = total + messages[i].tokens + 4
  }
  total + 2
}

///===
/// 消息构建 / Message building

/// 构建 system 消息 / Build system message.
pub fn system_message(content : String) -> ChatMessage {
  make_message(System, content)
}

/// 构建 user 消息 / Build user message.
pub fn user_message(content : String) -> ChatMessage {
  make_message(User, content)
}

/// 构建 assistant 消息 / Build assistant message.
pub fn assistant_message(content : String) -> ChatMessage {
  make_message(Assistant, content)
}

/// 追加消息 / Append message to request.
pub fn append_message(req : LLMRequest, msg : ChatMessage) -> LLMRequest {
  let new_messages = req.messages.copy()
  new_messages.push(msg)
  { ..req, messages: new_messages }
}

///===
/// 请求参数 / Request parameters

/// 设置 temperature / Set temperature.
pub fn with_temperature(req : LLMRequest, temp : Double) -> LLMRequest {
  { ..req, temperature: temp }
}

/// 设置 max_tokens / Set max tokens.
pub fn with_max_tokens(req : LLMRequest, max_tok : Int) -> LLMRequest {
  { ..req, max_tokens: max_tok }
}

/// 设置 top_p / Set top_p.
pub fn with_top_p(req : LLMRequest, p : Double) -> LLMRequest {
  { ..req, top_p: p }
}

/// 启用流式 / Enable streaming.
pub fn with_stream(req : LLMRequest) -> LLMRequest {
  { ..req, stream: true }
}

///===
/// 响应处理 / Response processing

/// 响应成功检查 / Check if response is successful.
pub fn response_ok(resp : LLMResponse) -> Bool {
  resp.success && resp.error.length() == 0
}

/// 响应成本估计 / Estimate response cost.
pub fn estimate_cost(resp : LLMResponse, input_price : Double, output_price : Double) -> Double {
  resp.prompt_tokens.to_double() * input_price / 1000.0 + resp.completion_tokens.to_double() * output_price / 1000.0
}

/// 提取响应文本 / Extract response text.
pub fn response_text(resp : LLMResponse) -> String {
  if resp.success { resp.content } else { "" }
}

///===
/// 流式处理 / Streaming

/// 流式块 / Stream chunk.
pub struct StreamChunk {
  content : String
  is_final : Bool
  index : Int
}

/// 构造流式块 / Create stream chunk.
pub fn make_chunk(content : String, is_final : Bool, index : Int) -> StreamChunk {
  { content: content, is_final: is_final, index: index }
}

/// 合并流式块 / Merge stream chunks.
pub fn merge_chunks(chunks : Array[StreamChunk]) -> String {
  let mut result = ""
  for i in 0..<chunks.length() {
    result = result + chunks[i].content
  }
  result
}

///===
/// 提供商名称 / Provider name

pub fn provider_name(provider : LLMProvider) -> String {
  match provider {
    OpenAI => "openai"
    Anthropic => "anthropic"
    Local => "local"
    Custom => "custom"
  }
}

/// 角色名称 / Role name.
pub fn role_name(role : LLMRole) -> String {
  match role {
    System => "system"
    User => "user"
    Assistant => "assistant"
  }
}

///===
/// ID

pub fn llm_id() -> String {
  "agent_kit/llm"
}
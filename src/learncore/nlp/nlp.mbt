///|
/// # learncore/nlp 自然语言处理算子 / NLP Operators
///
/// NLP 算子契约 + 简化实现。架构 §4.3.5 learncore 扩展。
/// S7.4 新建：Tokenizer/Embedding/BERT/GPT 简化实现。
/// MoonBit 无真实 NLP 后端，仅模拟前向推理。
///
/// # NLP operators
///
/// NLP contracts + simplified implementation. See architecture §4.3.5.

///===
/// Tokenizer

///|
/// 分词器类型 / Tokenizer kind.
pub(all) enum TokenizerKind {
  Whitespace
  Char
  Word
} derive(Debug, Eq)

///|
pub extend TokenizerKind with Eq::{equal, not_equal}

///|
pub extend TokenizerKind with Debug::{to_repr}

///|
/// 空白分词 / Whitespace tokenization.
pub fn tokenize_whitespace(text : String) -> Array[String] {
  text.split(" ").to_array().map(fn(s) { s.to_owned() })
}

///|
/// 字符分词 / Character tokenization.
pub fn tokenize_char(text : String) -> Array[String] {
  let result : Array[String] = []
  for i in 0..<text.length() {
    result.push(text[i:i + 1].to_owned())
  }
  result
}

///|
/// 单词分词（小写化）/ Word tokenization (lowercased).
pub fn tokenize_word(text : String) -> Array[String] {
  let parts = text.split(" ").to_array()
  let result : Array[String] = []
  for i in 0..<parts.length() {
    let w = parts[i].to_owned().to_lower()
    if w.length() > 0 {
      result.push(w)
    }
  }
  result
}

///|
/// 分词器统一接口 / Tokenizer unified interface.
pub fn tokenize(kind : TokenizerKind, text : String) -> Array[String] {
  match kind {
    Whitespace => tokenize_whitespace(text)
    Char => tokenize_char(text)
    Word => tokenize_word(text)
  }
}

///|
/// 词表构建 / Build vocabulary from tokens.
pub fn build_vocab(tokens : Array[String]) -> Array[String] {
  let vocab : Array[String] = []
  for i in 0..<tokens.length() {
    let w = tokens[i]
    let mut found = false
    for j in 0..<vocab.length() {
      if vocab[j] == w {
        found = true
      }
    }
    if !found {
      vocab.push(w)
    }
  }
  vocab
}

///|
/// 文本编码为 ID / Encode text to token IDs.
pub fn encode_tokens(
  tokens : Array[String],
  vocab : Array[String],
) -> Array[Int32] {
  let result : Array[Int32] = []
  for i in 0..<tokens.length() {
    let w = tokens[i]
    let mut id = -1
    for j in 0..<vocab.length() {
      if vocab[j] == w {
        id = j
      }
    }
    result.push(id)
  }
  result
}

///|
/// ID 解码为文本 / Decode token IDs to text.
pub fn decode_ids(ids : Array[Int32], vocab : Array[String]) -> Array[String] {
  let result : Array[String] = []
  for i in 0..<ids.length() {
    let id = ids[i]
    if id >= 0 && id < vocab.length() {
      result.push(vocab[id])
    } else {
      result.push("<unk>")
    }
  }
  result
}

///===
/// Embedding

///|
/// 词嵌入查找 / Word embedding lookup.
pub fn embedding_lookup(
  token_ids : Array[Int32],
  embedding_matrix : Array[Array[Double]],
) -> Array[Array[Double]] {
  let result : Array[Array[Double]] = []
  for i in 0..<token_ids.length() {
    let id = token_ids[i]
    if id >= 0 && id < embedding_matrix.length() {
      result.push(embedding_matrix[id])
    } else {
      result.push([])
    }
  }
  result
}

///|
/// 位置编码 / Positional encoding (sinusoidal).
/// PE(pos, 2i) = sin(pos / 10000^(2i/d))
/// PE(pos, 2i+1) = cos(pos / 10000^(2i/d))
pub fn positional_encoding(
  seq_len : Int32,
  d_model : Int32,
) -> Array[Array[Double]] {
  let result : Array[Array[Double]] = []
  for pos in 0..<seq_len {
    let row : Array[Double] = []
    for i in 0..<d_model {
      let angle = pos.to_double() / pow10(2 * i / d_model)
      if i % 2 == 0 {
        row.push(sin_approx(angle))
      } else {
        row.push(cos_approx(angle))
      }
    }
    result.push(row)
  }
  result
}

///===
/// BERT 简化

///|
/// BERT 配置 / BERT configuration.
pub struct BertConfig {
  vocab_size : Int32
  hidden_size : Int32
  num_layers : Int32
  num_heads : Int32
}

///|
/// 构造 BERT 配置 / Create BERT config.
pub fn make_bert_config(
  vocab_size : Int32,
  hidden_size : Int32,
  num_layers : Int32,
  num_heads : Int32,
) -> BertConfig {
  { vocab_size, hidden_size, num_layers, num_heads, }
}

///|
/// BERT 嵌入层 / BERT embedding layer (token + position + segment).
pub fn bert_embeddings(
  token_ids : Array[Int32],
  embedding_matrix : Array[Array[Double]],
  config : BertConfig,
) -> Array[Array[Double]] {
  let token_emb = embedding_lookup(token_ids, embedding_matrix)
  let pos_emb = positional_encoding(token_ids.length(), config.hidden_size)
  let result : Array[Array[Double]] = []
  for i in 0..<token_emb.length() {
    let combined : Array[Double] = []
    let t = token_emb[i]
    let p = if i < pos_emb.length() { pos_emb[i] } else { [] }
    let d = if t.length() < p.length() { t.length() } else { p.length() }
    for j in 0..<d {
      combined.push(t[j] + p[j])
    }
    result.push(combined)
  }
  result
}

///|
/// BERT 池化输出 / BERT pooled output (take [CLS] token).
pub fn bert_pooled_output(
  hidden_states : Array[Array[Double]],
) -> Array[Double] {
  if hidden_states.length() == 0 {
    []
  } else {
    hidden_states[0]
  }
}

///|
/// BERT 前向（简化）/ BERT forward (simplified).
pub fn bert_forward(
  token_ids : Array[Int32],
  embedding_matrix : Array[Array[Double]],
  config : BertConfig,
) -> (Array[Array[Double]], Array[Double]) {
  let hidden = bert_embeddings(token_ids, embedding_matrix, config)
  let pooled = bert_pooled_output(hidden)
  (hidden, pooled)
}

///===
/// GPT 简化

///|
/// GPT 配置 / GPT configuration.
pub struct GptConfig {
  vocab_size : Int32
  hidden_size : Int32
  num_layers : Int32
  num_heads : Int32
}

///|
/// 构造 GPT 配置 / Create GPT config.
pub fn make_gpt_config(
  vocab_size : Int32,
  hidden_size : Int32,
  num_layers : Int32,
  num_heads : Int32,
) -> GptConfig {
  { vocab_size, hidden_size, num_layers, num_heads, }
}

///|
/// GPT 嵌入层 / GPT embedding layer (token + position).
pub fn gpt_embeddings(
  token_ids : Array[Int32],
  embedding_matrix : Array[Array[Double]],
  config : GptConfig,
) -> Array[Array[Double]] {
  let token_emb = embedding_lookup(token_ids, embedding_matrix)
  let pos_emb = positional_encoding(token_ids.length(), config.hidden_size)
  let result : Array[Array[Double]] = []
  for i in 0..<token_emb.length() {
    let combined : Array[Double] = []
    let t = token_emb[i]
    let p = if i < pos_emb.length() { pos_emb[i] } else { [] }
    let d = if t.length() < p.length() { t.length() } else { p.length() }
    for j in 0..<d {
      combined.push(t[j] + p[j])
    }
    result.push(combined)
  }
  result
}

///|
/// GPT 前向（简化）/ GPT forward (simplified).
pub fn gpt_forward(
  token_ids : Array[Int32],
  embedding_matrix : Array[Array[Double]],
  config : GptConfig,
) -> Array[Array[Double]] {
  gpt_embeddings(token_ids, embedding_matrix, config)
}

///|
/// GPT 生成（简化）/ GPT generate (simplified, returns next token id).
pub fn gpt_generate_next(
  token_ids : Array[Int32],
  embedding_matrix : Array[Array[Double]],
  config : GptConfig,
) -> Int32 {
  let hidden = gpt_forward(token_ids, embedding_matrix, config)
  if hidden.length() == 0 || hidden[0].length() == 0 {
    0
  } else {
    let mut max_val = hidden[0][0]
    let mut max_idx = 0
    let h = hidden[0]
    for i in 1..<h.length() {
      if h[i] > max_val {
        max_val = h[i]
        max_idx = i
      }
    }
    max_idx
  }
}

///===
/// 文本工具

///|
/// n-gram 生成 / Generate n-grams.
pub fn ngrams(tokens : Array[String], n : Int32) -> Array[Array[String]] {
  let result : Array[Array[String]] = []
  if n <= 0 || n > tokens.length() {
    return result
  }
  for i in 0..<(tokens.length() - n + 1) {
    let gram : Array[String] = []
    for j in 0..<n {
      gram.push(tokens[i + j])
    }
    result.push(gram)
  }
  result
}

///|
/// 词频统计 / Term frequency.
pub fn term_frequency(tokens : Array[String]) -> Array[(String, Int32)] {
  let result : Array[(String, Int32)] = []
  for i in 0..<tokens.length() {
    let w = tokens[i]
    let mut found = false
    for idx in 0..<result.length() {
      if result[idx].0 == w {
        result[idx] = (w, result[idx].1 + 1)
        found = true
      }
    }
    if !found {
      result.push((w, 1))
    }
  }
  result
}

///|
/// 文本长度 / Text length (character count).
pub fn text_length(text : String) -> Int32 {
  text.length()
}

///|
/// 拼接文本 / Join text with delimiter.
pub fn text_join(parts : Array[String], delimiter : String) -> String {
  if parts.length() == 0 {
    ""
  } else {
    let mut result = parts[0]
    for i in 1..<parts.length() {
      result = result + delimiter + parts[i]
    }
    result
  }
}

///|
/// 文本截断 / Truncate text to max length.
pub fn text_truncate(text : String, max_len : Int32) -> String {
  if text.length() <= max_len {
    text
  } else {
    text[0:max_len].to_owned()
  }
}

///===
/// 辅助函数

///|
/// 10 的幂 / Power of 10.
fn pow10(exp : Int32) -> Double {
  let mut result = 1.0
  for _i in 0..<exp {
    result = result * 10.0
  }
  result
}

///|
/// 正弦近似 / Sine approximation (Taylor series).
fn sin_approx(x : Double) -> Double {
  let mut x = x
  let two_pi = 6.283185307179586
  let pi = 3.141592653589793
  while x > pi {
    x = x - two_pi
  }
  while x < -pi {
    x = x + two_pi
  }
  let mut result = x
  let mut term = x
  let x2 = x * x
  for i in 1..<10 {
    term = term * x2 / ((2 * i).to_double() * (2 * i + 1).to_double()) * -1.0
    result = result + term
  }
  result
}

///|
/// 余弦近似 / Cosine approximation.
fn cos_approx(x : Double) -> Double {
  sin_approx(x + 1.5707963267948966)
}

///|
///===
/// ID
pub fn nlp_id() -> String {
  "learncore/nlp"
}

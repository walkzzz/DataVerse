///|
/// # opcore/nlp_advanced 高级 NLP / Advanced NLP
///
/// Tokenizer / Vocab / POS / NER / Dependency / Constituency / Coref / Sentiment /
/// Summarizer / Translator / QA / Embedding / LM / Classifier / Intent / Dialog /
/// EntityLink / Relation / Event / BERT。
/// 对标 HuggingFace Transformers + spaCy + Stanford CoreNLP。
/// S4.8 填充：契约 + 模拟实现（无外部 NLP 引擎）。
///
/// # Advanced NLP
///
/// Full NLP pipeline. Aligned with HuggingFace + spaCy + CoreNLP.

// ============================================================
// 常量 / Constants
// ============================================================

const NLP_ADVANCED_NLP_PI : Double = 3.141592653589793

///|

///|

// ============================================================
// 辅助数学函数 / Helper math functions (private)
// ============================================================

// ============================================================
// 类型定义 / Type definitions
// ============================================================

///|
/// 分词方法 / Tokenization method_.
pub(all) enum TokenizeMethod {
  BpeMethod
  WordpieceMethod
  SentencepieceMethod
  WhitespaceMethod
} derive(Debug, Eq)

///|
pub extend TokenizeMethod with Eq::{equal, not_equal}

///|
pub extend TokenizeMethod with Debug::{to_repr}

///|
/// 分词器 / Tokenizer.
pub struct Tokenizer {
  method_ : TokenizeMethod
  vocab_size : Int32
  unk_token : String
} derive(Debug, Eq)

///|
pub extend Tokenizer with Eq::{equal, not_equal}

///|
pub extend Tokenizer with Debug::{to_repr}

///|
/// 词表 / Vocabulary.
pub struct Vocab {
  tokens : Array[String]
  token_to_id : Array[(String, Int32)]
} derive(Debug, Eq)

///|
pub extend Vocab with Eq::{equal, not_equal}

///|
pub extend Vocab with Debug::{to_repr}

///|
/// 词性标注器 / POS tagger.
pub struct POSTagger {
  tags : Array[String]
} derive(Debug, Eq)

///|
pub extend POSTagger with Eq::{equal, not_equal}

///|
pub extend POSTagger with Debug::{to_repr}

///|
/// 命名实体识别 / NER recognizer.
pub struct NER {
  entity_types : Array[String]
} derive(Debug, Eq)

///|
pub extend NER with Eq::{equal, not_equal}

///|
pub extend NER with Debug::{to_repr}

///|
/// 依存句法分析器 / Dependency parser.
pub struct DependencyParser {
  labels : Array[String]
} derive(Debug, Eq)

///|
pub extend DependencyParser with Eq::{equal, not_equal}

///|
pub extend DependencyParser with Debug::{to_repr}

///|
/// 成分句法分析器 / Constituency parser.
pub struct ConstituencyParser {
  grammar : Array[String]
} derive(Debug, Eq)

///|
pub extend ConstituencyParser with Eq::{equal, not_equal}

///|
pub extend ConstituencyParser with Debug::{to_repr}

///|
/// 共指消解 / Coreference resolver.
pub struct Coref {
  max_distance : Int32
} derive(Debug, Eq)

///|
pub extend Coref with Eq::{equal, not_equal}

///|
pub extend Coref with Debug::{to_repr}

///|
/// 情感分析 / Sentiment analyzer.
pub struct Sentiment {
  positive_words : Array[String]
  negative_words : Array[String]
} derive(Debug, Eq)

///|
pub extend Sentiment with Eq::{equal, not_equal}

///|
pub extend Sentiment with Debug::{to_repr}

///|
/// 摘要器 / Summarizer.
pub struct Summarizer {
  max_sentences : Int32
} derive(Debug, Eq)

///|
pub extend Summarizer with Eq::{equal, not_equal}

///|
pub extend Summarizer with Debug::{to_repr}

///|
/// 翻译器 / Translator.
pub struct Translator {
  source_lang : String
  target_lang : String
} derive(Debug, Eq)

///|
pub extend Translator with Eq::{equal, not_equal}

///|
pub extend Translator with Debug::{to_repr}

///|
/// 问答 / QA system.
pub struct QA {
  context : String
} derive(Debug, Eq)

///|
pub extend QA with Eq::{equal, not_equal}

///|
pub extend QA with Debug::{to_repr}

///|
/// 嵌入模型 / Embedding model.
pub struct EmbeddingModel {
  dim : Int32
  weights : Array[Array[Double]]
} derive(Debug, Eq)

///|
pub extend EmbeddingModel with Eq::{equal, not_equal}

///|
pub extend EmbeddingModel with Debug::{to_repr}

///|
/// 语言模型 / Language model.
pub struct NlpAdvancedLanguageModel {
  vocab_size : Int32
  context_len : Int32
} derive(Debug, Eq)

///|
pub extend NlpAdvancedLanguageModel with Eq::{equal, not_equal}

///|
pub extend NlpAdvancedLanguageModel with Debug::{to_repr}

///|
/// 文本分类器 / Text classifier.
pub struct TextClassifier {
  labels : Array[String]
} derive(Debug, Eq)

///|
pub extend TextClassifier with Eq::{equal, not_equal}

///|
pub extend TextClassifier with Debug::{to_repr}

///|
/// 意图识别 / Intent recognizer.
pub struct IntentRecognizer {
  intents : Array[String]
} derive(Debug, Eq)

///|
pub extend IntentRecognizer with Eq::{equal, not_equal}

///|
pub extend IntentRecognizer with Debug::{to_repr}

///|
/// 对话管理 / Dialog manager.
pub struct DialogManager {
  state : String
  history : Array[String]
} derive(Debug, Eq)

///|
pub extend DialogManager with Eq::{equal, not_equal}

///|
pub extend DialogManager with Debug::{to_repr}

///|
/// 实体链接 / Entity linker.
pub struct EntityLinker {
  kb_size : Int32
} derive(Debug, Eq)

///|
pub extend EntityLinker with Eq::{equal, not_equal}

///|
pub extend EntityLinker with Debug::{to_repr}

///|
/// 关系抽取 / Relation extractor.
pub struct RelationExtractor {
  relation_types : Array[String]
} derive(Debug, Eq)

///|
pub extend RelationExtractor with Eq::{equal, not_equal}

///|
pub extend RelationExtractor with Debug::{to_repr}

///|
/// 事件抽取 / Event extractor.
pub struct EventExtractor {
  event_types : Array[String]
} derive(Debug, Eq)

///|
pub extend EventExtractor with Eq::{equal, not_equal}

///|
pub extend EventExtractor with Debug::{to_repr}

///|
/// NLP 标注结果 / NLP annotation span.
pub struct NLPSpan {
  start : Int32
  end : Int32
  label : String
  text : String
} derive(Debug, Eq)

///|
pub extend NLPSpan with Eq::{equal, not_equal}

///|
pub extend NLPSpan with Debug::{to_repr}

///|
/// 情感结果 / Sentiment result.
pub struct SentimentResult {
  label : String
  score : Double
  positive : Double
  negative : Double
  neutral : Double
} derive(Debug, Eq)

///|
pub extend SentimentResult with Eq::{equal, not_equal}

///|
pub extend SentimentResult with Debug::{to_repr}

// ============================================================
// 分词 / Tokenization
// ============================================================

///|
/// 构造分词器 / Build tokenizer.
pub fn nlp_advanced_make_tokenizer(
  method_ : TokenizeMethod,
  vocab_size : Int32,
) -> Tokenizer {
  let vs = if vocab_size <= 0 { 30000 } else { vocab_size }
  { method_, vocab_size: vs, unk_token: "[UNK]", }
}

///|
/// BPE 分词 / BPE tokenize.
pub fn nlp_advanced_tokenize_bpe(tok : Tokenizer, text : String) -> Array[String] {
  let tokens : Array[String] = []
  let mut current = ""
  for i in 0..<text.length() {
    let c = text[i]
    if c == ' ' || c == '\t' || c == '\n' || c == '\r' {
      if current.length() > 0 {
        tokens.push(current)
        current = ""
      }
    } else {
      current = current + c.to_string()
      if current.length() >= 4 {
        tokens.push(current)
        current = ""
      }
    }
  }
  if current.length() > 0 {
    tokens.push(current)
  }
  if tokens.length() == 0 {
    [tok.unk_token]
  } else {
    tokens
  }
}

///|
/// WordPiece 分词 / WordPiece tokenize.
pub fn nlp_advanced_tokenize_wordpiece(tok : Tokenizer, text : String) -> Array[String] {
  let tokens : Array[String] = []
  let mut current = ""
  for i in 0..<text.length() {
    let c = text[i]
    if c == ' ' || c == '\t' || c == '\n' {
      if current.length() > 0 {
        tokens.push("##" + current)
        current = ""
      }
    } else {
      current = current + c.to_string()
    }
  }
  if current.length() > 0 {
    tokens.push(current)
  }
  if tokens.length() == 0 {
    [tok.unk_token]
  } else {
    tokens
  }
}

///|
/// SentencePiece 分词 / SentencePiece tokenize.
pub fn nlp_advanced_tokenize_sentencepiece(tok : Tokenizer, text : String) -> Array[String] {
  let tokens : Array[String] = []
  let mut current = ""
  for i in 0..<text.length() {
    let c = text[i]
    if c == ' ' {
      if current.length() > 0 {
        tokens.push(current)
        current = ""
      }
      tokens.push("▁")
    } else {
      current = current + c.to_string()
    }
  }
  if current.length() > 0 {
    tokens.push(current)
  }
  if tokens.length() == 0 {
    [tok.unk_token]
  } else {
    tokens
  }
}

// ============================================================
// 词表 / Vocabulary
// ============================================================

///|
/// 构造词表 / Build vocabulary.
pub fn nlp_advanced_make_vocab(tokens : Array[String]) -> Vocab {
  let token_to_id : Array[(String, Int32)] = []
  let seen : Array[String] = []
  for i in 0..<tokens.length() {
    let t = tokens[i]
    let mut found = false
    for s in seen {
      if s == t {
        found = true
        break
      }
    }
    if !found {
      seen.push(t)
      token_to_id.push((t, seen.length() - 1))
    }
  }
  { tokens: seen, token_to_id, }
}

///|
/// 词表编码 / Encode token to id.
pub fn nlp_advanced_vocab_encode(v : Vocab, token : String) -> Int32 {
  for i in 0..<v.token_to_id.length() {
    let (t, id) = v.token_to_id[i]
    if t == token {
      return id
    }
  }
  -1
}

///|
/// 词表解码 / Decode id to token.
pub fn nlp_advanced_vocab_decode(v : Vocab, id : Int32) -> String {
  if id < 0 || id >= v.tokens.length() {
    "[UNK]"
  } else {
    v.tokens[id]
  }
}

///|
/// 词表大小 / Vocabulary size.
pub fn nlp_advanced_vocab_size(v : Vocab) -> Int32 {
  v.tokens.length()
}

// ============================================================
// 词性标注 / POS tagging
// ============================================================

///|
/// 构造 POS 标注器 / Build POS tagger.
pub fn nlp_advanced_make_pos_tagger(tags : Array[String]) -> POSTagger {
  { tags: tags.copy(), }
}

///|
/// POS 标注 / POS tag a single token.
pub fn nlp_advanced_pos_tag(tagger : POSTagger, token : String) -> String {
  let n = tagger.tags.length()
  if n == 0 {
    return "UNK"
  }
  let mut hash = 0
  for i in 0..<token.length() {
    hash = hash + token[i].to_int()
  }
  tagger.tags[hash % n]
}

///|
/// POS 标注序列 / POS tag multiple tokens.
pub fn nlp_advanced_pos_tags(
  tagger : POSTagger,
  tokens : Array[String],
) -> Array[(String, String)] {
  let result : Array[(String, String)] = []
  for t in tokens {
    result.push((t, nlp_advanced_pos_tag(tagger, t)))
  }
  result
}

// ============================================================
// 命名实体识别 / NER
// ============================================================

///|
/// 构造 NER / Build NER recognizer.
pub fn nlp_advanced_make_ner(entity_types : Array[String]) -> NER {
  { entity_types: entity_types.copy(), }
}

///|
/// NER 抽取 / Extract entities from tokens.
pub fn nlp_advanced_ner_extract(ner : NER, tokens : Array[String]) -> Array[NLPSpan] {
  let result : Array[NLPSpan] = []
  let n = ner.entity_types.length()
  if n == 0 {
    return result
  }
  let mut i = 0
  while i < tokens.length() {
    let t = tokens[i]
    let mut hash = 0
    for j in 0..<t.length() {
      hash = hash + t[j].to_int()
    }
    if hash % 5 == 0 {
      let et = ner.entity_types[hash % n]
      result.push({ start: i, end: i + 1, label: et, text: t, })
    }
    i = i + 1
  }
  result
}

///|
/// NER 实体列表 / Get entity list.
pub fn nlp_advanced_ner_entities(ner : NER, tokens : Array[String]) -> Array[String] {
  let spans = nlp_advanced_ner_extract(ner, tokens)
  let result : Array[String] = []
  for s in spans {
    result.push(s.text)
  }
  result
}

// ============================================================
// 依存句法 / Dependency parsing
// ============================================================

///|
/// 构造依存分析器 / Build dependency parser.
pub fn nlp_advanced_make_dependency_parser(labels : Array[String]) -> DependencyParser {
  { labels: labels.copy(), }
}

///|
/// 依存分析 / Parse dependency.
pub fn nlp_advanced_parse_dependency(
  parser : DependencyParser,
  tokens : Array[String],
) -> Array[(Int32, Int32, String)] {
  let result : Array[(Int32, Int32, String)] = []
  let n = tokens.length()
  if n == 0 {
    return result
  }
  let label_n = parser.labels.length()
  for i in 1..<n {
    let head = i / 2
    let label = if label_n > 0 { parser.labels[i % label_n] } else { "dep" }
    result.push((i, head, label))
  }
  result
}

///|
/// 依存树 / Build dependency tree string.
pub fn nlp_advanced_dependency_tree(
  parser : DependencyParser,
  tokens : Array[String],
) -> String {
  let deps = nlp_advanced_parse_dependency(parser, tokens)
  let mut result = ""
  for i in 0..<deps.length() {
    let (idx, head, label) = deps[i]
    if i > 0 {
      result = result + "\n"
    }
    result = result + idx.to_string() + "->" + head.to_string() + ":" + label
  }
  result
}

// ============================================================
// 成分句法 / Constituency parsing
// ============================================================

///|
/// 构造成分分析器 / Build constituency parser.
pub fn nlp_advanced_make_constituency_parser(grammar : Array[String]) -> ConstituencyParser {
  { grammar: grammar.copy(), }
}

///|
/// 成分分析 / Parse constituency.
pub fn nlp_advanced_parse_constituency(
  parser : ConstituencyParser,
  tokens : Array[String],
) -> String {
  let mut result = "(S"
  let mut i = 0
  while i < tokens.length() {
    let t = tokens[i]
    let g = if parser.grammar.length() > 0 {
      parser.grammar[i % parser.grammar.length()]
    } else {
      "NP"
    }
    result = result + " (" + g + " " + t + ")"
    i = i + 1
  }
  result + ")"
}

///|
/// 分析树 / Parse tree string.
pub fn nlp_advanced_parse_tree(
  parser : ConstituencyParser,
  tokens : Array[String],
) -> String {
  nlp_advanced_parse_constituency(parser, tokens)
}

// ============================================================
// 共指消解 / Coreference
// ============================================================

///|
/// 构造共指 / Build coreference resolver.
pub fn nlp_advanced_make_coref(max_distance : Int32) -> Coref {
  let md = if max_distance <= 0 { 3 } else { max_distance }
  { max_distance: md, }
}

///|
/// 共指消解 / Resolve coreferences.
pub fn nlp_advanced_coref_resolve(c : Coref, tokens : Array[String]) -> Array[Array[Int32]] {
  let clusters : Array[Array[Int32]] = []
  let pronouns = [
    "he", "she", "it", "they", "him", "her", "them", "his", "her", "their",
  ]
  let mut current_cluster : Array[Int32] = []
  let mut last_noun = -1
  for i in 0..<tokens.length() {
    let t = tokens[i]
    let mut is_pronoun = false
    for p in pronouns {
      if p == t {
        is_pronoun = true
        break
      }
    }
    if is_pronoun {
      if last_noun >= 0 && i - last_noun <= c.max_distance {
        current_cluster.push(i)
      }
    } else {
      if current_cluster.length() > 1 {
        clusters.push(current_cluster)
        current_cluster = []
      }
      current_cluster = [i]
      last_noun = i
    }
  }
  if current_cluster.length() > 1 {
    clusters.push(current_cluster)
  }
  clusters
}

///|
/// 共指簇 / Get coreference clusters.
pub fn nlp_advanced_coref_clusters(c : Coref, tokens : Array[String]) -> Array[Array[Int32]] {
  nlp_advanced_coref_resolve(c, tokens)
}

// ============================================================
// 情感分析 / Sentiment
// ============================================================

///|
/// 构造情感分析 / Build sentiment analyzer.
pub fn nlp_advanced_make_sentiment(
  positive_words : Array[String],
  negative_words : Array[String],
) -> Sentiment {
  {
    positive_words: positive_words.copy(),
    negative_words: negative_words.copy(),
  }
}

///|
/// 情感分析 / Analyze sentiment.
pub fn nlp_advanced_sentiment_analyze(s : Sentiment, text : String) -> SentimentResult {
  let tokens = text.split(" ").to_array().map(fn(s) { s.to_owned() })
  let mut pos = 0
  let mut neg = 0
  for t in tokens {
    for pw in s.positive_words {
      if pw == t {
        pos = pos + 1
        break
      }
    }
    for nw in s.negative_words {
      if nw == t {
        neg = neg + 1
        break
      }
    }
  }
  let total = tokens.length()
  let pos_d = pos.to_double() / total.to_double()
  let neg_d = neg.to_double() / total.to_double()
  let neu_d = 1.0 - pos_d - neg_d
  let score = pos_d - neg_d
  let label = if score > 0.1 {
    "positive"
  } else if score < -0.1 {
    "negative"
  } else {
    "neutral"
  }
  { label, score, positive: pos_d, negative: neg_d, neutral: neu_d, }
}

///|
/// 情感分数 / Sentiment score only.
pub fn nlp_advanced_sentiment_score(s : Sentiment, text : String) -> Double {
  nlp_advanced_sentiment_analyze(s, text).score
}

// ============================================================
// 摘要 / Summarization
// ============================================================

///|
/// 构造摘要器 / Build summarizer.
pub fn nlp_advanced_make_summarizer(max_sentences : Int32) -> Summarizer {
  let ms = if max_sentences <= 0 { 3 } else { max_sentences }
  { max_sentences: ms, }
}

///|
/// 抽取式摘要 / Extractive summarization.
pub fn nlp_advanced_summarize_extractive(s : Summarizer, text : String) -> String {
  let sentences = nlp_advanced_split_sentences(text)
  if sentences.length() == 0 {
    return ""
  }
  let k = if s.max_sentences <= sentences.length() {
    s.max_sentences
  } else {
    sentences.length()
  }
  let scored : Array[(Int32, Double)] = []
  for i in 0..<sentences.length() {
    let sent = sentences[i]
    let score = sent.length().to_double()
    scored.push((i, score))
  }
  scored.sort_by(fn(a, b) {
    if a.1 > b.1 {
      -1
    } else if a.1 < b.1 {
      1
    } else {
      0
    }
  })
  let idxs : Array[Int32] = []
  for i in 0..<k {
    idxs.push(scored[i].0)
  }
  idxs.sort_by(fn(a, b) { if a < b { -1 } else if a > b { 1 } else { 0 } })
  let mut result = ""
  for i in 0..<idxs.length() {
    if i > 0 {
      result = result + " "
    }
    result = result + sentences[idxs[i]]
  }
  result
}

///|
/// 生成式摘要 / Abstractive summarization.
pub fn nlp_advanced_summarize_abstractive(s : Summarizer, text : String) -> String {
  let sentences = nlp_advanced_split_sentences(text)
  if sentences.length() == 0 {
    return ""
  }
  let k = if s.max_sentences <= sentences.length() {
    s.max_sentences
  } else {
    sentences.length()
  }
  let mut result = ""
  for i in 0..<k {
    let sent = sentences[i]
    let words = sent.split(" ").to_array().map(fn(s) { s.to_owned() })
    let wc = if words.length() > 5 { 5 } else { words.length() }
    if i > 0 {
      result = result + " "
    }
    for j in 0..<wc {
      if j > 0 {
        result = result + " "
      }
      result = result + words[j]
    }
  }
  result
}

///|
fn nlp_advanced_split_sentences(text : String) -> Array[String] {
  let sentences : Array[String] = []
  let mut current = ""
  for i in 0..<text.length() {
    let c = text[i]
    current = current + c.to_string()
    if c == '.' || c == '!' || c == '?' {
      sentences.push(current)
      current = ""
    }
  }
  if current.length() > 0 {
    sentences.push(current)
  }
  sentences
}

// ============================================================
// 翻译 / Translation
// ============================================================

///|
/// 构造翻译器 / Build translator.
pub fn nlp_advanced_make_translator(
  source_lang : String,
  target_lang : String,
) -> Translator {
  { source_lang, target_lang, }
}

///|
/// 翻译 / Translate text.
pub fn nlp_advanced_translate(t : Translator, text : String) -> String {
  let prefix = "[" + t.source_lang + "->" + t.target_lang + "] "
  prefix + text
}

///|
/// 批量翻译 / Translate batch.
pub fn nlp_advanced_translate_batch(t : Translator, texts : Array[String]) -> Array[String] {
  let result : Array[String] = []
  for text in texts {
    result.push(nlp_advanced_translate(t, text))
  }
  result
}

// ============================================================
// 问答 / QA
// ============================================================

///|
/// 构造 QA / Build QA system.
pub fn nlp_advanced_make_qa(context : String) -> QA {
  { context, }
}

///|
/// QA 回答 / Answer question.
pub fn nlp_advanced_qa_answer(qa : QA, question : String) -> String {
  let context_words = qa.context
    .split(" ")
    .to_array()
    .map(fn(s) { s.to_owned() })
  let question_words = question
    .split(" ")
    .to_array()
    .map(fn(s) { s.to_owned() })
  let mut best_idx = 0
  let mut best_score = 0
  for i in 0..<context_words.length() {
    let mut score = 0
    for qw in question_words {
      for j in 0..<context_words.length() {
        if context_words[j] == qw && i <= j && j < i + 5 {
          score = score + 1
        }
      }
    }
    if score > best_score {
      best_score = score
      best_idx = i
    }
  }
  let end_idx = if best_idx + 5 <= context_words.length() {
    best_idx + 5
  } else {
    context_words.length()
  }
  let mut result = ""
  for i in best_idx..<end_idx {
    if i > best_idx {
      result = result + " "
    }
    result = result + context_words[i]
  }
  result
}

///|
/// QA 上下文 / Get context.
pub fn nlp_advanced_qa_context(qa : QA) -> String {
  qa.context
}

// ============================================================
// 嵌入 / Embedding
// ============================================================

///|
/// 构造嵌入模型 / Build embedding model.
pub fn nlp_advanced_make_embedding_model(dim : Int32) -> EmbeddingModel {
  let d = if dim <= 0 { 128 } else { dim }
  let weights : Array[Array[Double]] = []
  for i in 0..<1000 {
    let row : Array[Double] = []
    for j in 0..<d {
      let v = nlp_advanced_nlp_sin_double(i.to_double() * 0.1 + j.to_double() * 0.01)
      row.push(v)
    }
    weights.push(row)
  }
  { dim: d, weights, }
}

///|
fn nlp_advanced_nlp_sin_double(x : Double) -> Double {
  let mut x = x
  let two_pi = 6.283185307179586
  while x > NLP_ADVANCED_NLP_PI {
    x = x - two_pi
  }
  while x < -NLP_ADVANCED_NLP_PI {
    x = x + two_pi
  }
  let mut result = x
  let mut term = x
  let x2 = x * x
  for i in 1..<15 {
    term = term * x2 / ((2 * i).to_double() * (2 * i + 1).to_double()) * -1.0
    result = result + term
  }
  result
}

///|
/// 文本嵌入 / Embed text.
pub fn nlp_advanced_embed_text(model : EmbeddingModel, text : String) -> Array[Double] {
  let mut hash = 0
  for i in 0..<text.length() {
    hash = hash + text[i].to_int()
  }
  let idx = if model.weights.length() == 0 {
    0
  } else {
    hash % model.weights.length()
  }
  model.weights[idx].copy()
}

///|
/// Token 嵌入 / Embed tokens.
pub fn nlp_advanced_embed_tokens(
  model : EmbeddingModel,
  tokens : Array[String],
) -> Array[Array[Double]] {
  let result : Array[Array[Double]] = []
  for t in tokens {
    result.push(nlp_advanced_embed_text(model, t))
  }
  result
}

///|
/// 批量嵌入 / Embed batch.
pub fn nlp_advanced_embed_batch(
  model : EmbeddingModel,
  texts : Array[String],
) -> Array[Array[Double]] {
  let result : Array[Array[Double]] = []
  for text in texts {
    result.push(nlp_advanced_embed_text(model, text))
  }
  result
}

// ============================================================
// 语言模型 / Language model
// ============================================================

///|
/// 构造语言模型 / Build language model.
pub fn nlp_advanced_make_language_model(
  vocab_size : Int32,
  context_len : Int32,
) -> NlpAdvancedLanguageModel {
  let vs = if vocab_size <= 0 { 30000 } else { vocab_size }
  let cl = if context_len <= 0 { 512 } else { context_len }
  { vocab_size: vs, context_len: cl, }
}

///|
/// LM 预测 / Predict next token id.
pub fn nlp_advanced_lm_predict(lm : NlpAdvancedLanguageModel, tokens : Array[Int32]) -> Int32 {
  let n = tokens.length()
  if n == 0 {
    return 0
  }
  let mut sum = 0
  for t in tokens {
    sum = sum + t
  }
  sum % lm.vocab_size
}

///|
/// LM 评分 / Score a sequence (log probability).
pub fn nlp_advanced_lm_score(lm : NlpAdvancedLanguageModel, tokens : Array[Int32]) -> Double {
  let n = tokens.length()
  if n == 0 {
    return 0.0
  }
  let mut score = 0.0
  for i in 0..<n {
    let _t = tokens[i]
    let p = 1.0 / lm.vocab_size.to_double()
    score = score + @math.ln(p)
  }
  score
}

///|
/// LM 困惑度 / Perplexity.
pub fn nlp_advanced_lm_perplexity(lm : NlpAdvancedLanguageModel, tokens : Array[Int32]) -> Double {
  let n = tokens.length()
  if n == 0 {
    return 1.0
  }
  let score = nlp_advanced_lm_score(lm, tokens)
  let avg = score / n.to_double()
  @math.exp(-avg)
}

// ============================================================
// 文本分类 / Text classification
// ============================================================

///|
/// 构造分类器 / Build text classifier.
pub fn nlp_advanced_make_text_classifier(labels : Array[String]) -> TextClassifier {
  { labels: labels.copy(), }
}

///|
/// 文本分类 / Classify text.
pub fn nlp_advanced_classify_text(cls : TextClassifier, text : String) -> String {
  let n = cls.labels.length()
  if n == 0 {
    return "UNK"
  }
  let mut hash = 0
  for i in 0..<text.length() {
    hash = hash + text[i].to_int()
  }
  cls.labels[hash % n]
}

///|
/// 批量分类 / Classify batch.
pub fn nlp_advanced_classify_batch(
  cls : TextClassifier,
  texts : Array[String],
) -> Array[String] {
  let result : Array[String] = []
  for text in texts {
    result.push(nlp_advanced_classify_text(cls, text))
  }
  result
}

// ============================================================
// 意图识别 / Intent recognition
// ============================================================

///|
/// 构造意图识别 / Build intent recognizer.
pub fn nlp_advanced_make_intent_recognizer(intents : Array[String]) -> IntentRecognizer {
  { intents: intents.copy(), }
}

///|
/// 识别意图 / Recognize intent.
pub fn nlp_advanced_recognize_intent(ir : IntentRecognizer, text : String) -> String {
  let n = ir.intents.length()
  if n == 0 {
    return "UNK"
  }
  let mut hash = 0
  for i in 0..<text.length() {
    hash = hash + text[i].to_int() * (i + 1)
  }
  ir.intents[hash % n]
}

///|
/// 意图槽位 / Extract intent slots.
pub fn nlp_advanced_intent_slots(_ : IntentRecognizer, text : String) -> Array[NLPSpan] {
  let tokens = text.split(" ").to_array().map(fn(s) { s.to_owned() })
  let result : Array[NLPSpan] = []
  for i in 0..<tokens.length() {
    let t = tokens[i]
    if t.length() > 0 {
      let c = t[0]
      if c == '$' {
        result.push({ start: i, end: i + 1, label: "slot", text: t, })
      }
    }
  }
  result
}

// ============================================================
// 对话管理 / Dialog management
// ============================================================

///|
/// 构造对话管理 / Build dialog manager.
pub fn nlp_advanced_make_dialog_manager() -> DialogManager {
  { state: "init", history: [], }
}

///|
/// 对话行为 / Get dialog act.
pub fn nlp_advanced_dialog_act(_ : DialogManager, utterance : String) -> String {
  let u = utterance.to_lower()
  if nlp_advanced_contains_str(u, "hello") || nlp_advanced_contains_str(u, "hi") {
    "greeting"
  } else if nlp_advanced_contains_str(u, "bye") {
    "farewell"
  } else if nlp_advanced_contains_str(u, "what") ||
    nlp_advanced_contains_str(u, "how") ||
    nlp_advanced_contains_str(u, "why") {
    "question"
  } else if nlp_advanced_contains_str(u, "please") {
    "request"
  } else {
    "statement"
  }
}

///|
/// 对话状态 / Get dialog state.
pub fn nlp_advanced_dialog_state(dm : DialogManager) -> String {
  dm.state
}

///|
fn nlp_advanced_contains_str(haystack : String, needle : String) -> Bool {
  let hl = haystack.length()
  let nl = needle.length()
  if nl == 0 || nl > hl {
    return false
  }
  for i in 0..<=(hl - nl) {
    let mut matched = true
    for j in 0..<nl {
      if haystack[i + j] != needle[j] {
        matched = false
        break
      }
    }
    if matched {
      return true
    }
  }
  false
}

// ============================================================
// 实体链接 / Entity linking
// ============================================================

///|
/// 构造实体链接 / Build entity linker.
pub fn nlp_advanced_make_entity_linker(kb_size : Int32) -> EntityLinker {
  let ks = if kb_size <= 0 { 1000 } else { kb_size }
  { kb_size: ks, }
}

///|
/// 链接实体 / Link entities to KB.
pub fn nlp_advanced_link_entities(
  el : EntityLinker,
  entities : Array[String],
) -> Array[(String, Int32)] {
  let result : Array[(String, Int32)] = []
  for e in entities {
    let mut hash = 0
    for i in 0..<e.length() {
      hash = hash + e[i].to_int()
    }
    let kb_id = hash % el.kb_size
    result.push((e, kb_id))
  }
  result
}

///|
/// 实体知识库 / Get entity KB id.
pub fn nlp_advanced_entity_kb(el : EntityLinker, entity : String) -> Int32 {
  let mut hash = 0
  for i in 0..<entity.length() {
    hash = hash + entity[i].to_int()
  }
  hash % el.kb_size
}

// ============================================================
// 关系抽取 / Relation extraction
// ============================================================

///|
/// 构造关系抽取 / Build relation extractor.
pub fn nlp_advanced_make_relation_extractor(
  relation_types : Array[String],
) -> RelationExtractor {
  { relation_types: relation_types.copy(), }
}

///|
/// 抽取关系 / Extract relations.
pub fn nlp_advanced_extract_relations(
  re : RelationExtractor,
  entities : Array[NLPSpan],
) -> Array[(String, String, String)] {
  let result : Array[(String, String, String)] = []
  let n = entities.length()
  if n < 2 {
    return result
  }
  let rt_n = re.relation_types.length()
  for i in 0..<(n - 1) {
    let e1 = entities[i]
    let e2 = entities[i + 1]
    let rt = if rt_n > 0 { re.relation_types[i % rt_n] } else { "related_to" }
    result.push((e1.text, rt, e2.text))
  }
  result
}

///|
/// 关系三元组 / Get relation triples.
pub fn nlp_advanced_relation_triples(
  re : RelationExtractor,
  entities : Array[NLPSpan],
) -> Array[(String, String, String)] {
  nlp_advanced_extract_relations(re, entities)
}

// ============================================================
// 事件抽取 / Event extraction
// ============================================================

///|
/// 构造事件抽取 / Build event extractor.
pub fn nlp_advanced_make_event_extractor(event_types : Array[String]) -> EventExtractor {
  { event_types: event_types.copy(), }
}

///|
/// 抽取事件 / Extract events.
pub fn nlp_advanced_extract_events(
  ee : EventExtractor,
  tokens : Array[String],
) -> Array[NLPSpan] {
  let result : Array[NLPSpan] = []
  let et_n = ee.event_types.length()
  if et_n == 0 {
    return result
  }
  let triggers = [
    "buy", "sell", "go", "eat", "visit", "meet", "send", "receive",
  ]
  for i in 0..<tokens.length() {
    let t = tokens[i]
    for trig in triggers {
      if trig == t {
        let et = ee.event_types[i % et_n]
        result.push({ start: i, end: i + 1, label: et, text: t, })
        break
      }
    }
  }
  result
}

///|
/// 事件参数 / Get event arguments.
pub fn nlp_advanced_event_arguments(
  _ : EventExtractor,
  event : NLPSpan,
  tokens : Array[String],
) -> Array[String] {
  let result : Array[String] = []
  let start = event.start
  let end = event.end
  for i in 0..<tokens.length() {
    if i < start || i >= end {
      result.push(tokens[i])
    }
  }
  result
}

// ============================================================
// BERT 接口 / BERT interface
// ============================================================

///|
/// BERT 分词 / BERT tokenize.
pub fn nlp_advanced_bert_tokenize(text : String) -> Array[String] {
  let tokens : Array[String] = ["[CLS]"]
  let mut current = ""
  for i in 0..<text.length() {
    let c = text[i]
    if c == ' ' || c == '\t' || c == '\n' {
      if current.length() > 0 {
        tokens.push(current)
        current = ""
      }
    } else {
      current = current + c.to_string()
    }
  }
  if current.length() > 0 {
    tokens.push(current)
  }
  tokens.push("[SEP]")
  tokens
}

///|
/// BERT 编码 / BERT encode to ids.
pub fn nlp_advanced_bert_encode(text : String, vocab : Vocab) -> Array[Int32] {
  let tokens = nlp_advanced_bert_tokenize(text)
  let result : Array[Int32] = []
  for t in tokens {
    let id = nlp_advanced_vocab_encode(vocab, t)
    if id >= 0 {
      result.push(id)
    } else {
      result.push(0)
    }
  }
  result
}

///|
/// BERT 解码 / BERT decode ids to text.
pub fn nlp_advanced_bert_decode(ids : Array[Int32], vocab : Vocab) -> String {
  let mut result = ""
  for i in 0..<ids.length() {
    let t = nlp_advanced_vocab_decode(vocab, ids[i])
    if t == "[CLS]" || t == "[SEP]" {
      continue
    }
    if result.length() > 0 {
      result = result + " "
    }
    result = result + t
  }
  result
}

// ============================================================
// 标识 / Identity
// ============================================================

///|
/// 模块标识 / Module identity string.
pub fn nlp_advanced_nlp_advanced_id() -> String {
  "dataverse/opcore/nlp_advanced@0.1.0-dev"
}

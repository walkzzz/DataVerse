///|
/// # opcore/semantic 语义算子 / Semantic Operators
///
/// 语义质量评分 + 改写算子 + 合成算子。架构 §4.3.2 ⑥⑦⑧ 语义层。
/// S2.2 填充：MoonBit 无 LLM 调用能力，采用**契约 + 规则模拟**策略。
/// 对标 DJ quality_classifier / text_rewrite / synthetic_data_generator。
///
/// # Semantic operators
///
/// Quality scoring + rewrite + synthesis. See architecture §4.3.2 ⑥⑦⑧.

///|
/// 改写模式 / Rewrite mode.
pub(all) enum RewriteMode {
  Simplify // 简化：去多余空格、截断长文本
  Formalize // 正式化：首字母大写
  Casual // 口语化：模拟（规则占位）
  Expand // 扩写：重复核心内容
} derive(Debug, Eq)

///|
pub extend RewriteMode with Eq::{equal, not_equal}

///|
pub extend RewriteMode with Debug::{to_repr}

///|
/// 合成模式 / Synthesis mode.
pub(all) enum SynthesisMode {
  Paraphrase // 改写复述：简单变换
  Augment // 增强：拼接重复
  Interpolate // 插值：混合两段文本
} derive(Debug, Eq)

///|
pub extend SynthesisMode with Eq::{equal, not_equal}

///|
pub extend SynthesisMode with Debug::{to_repr}

// ============================================================
// 语义质量评分 / Semantic quality scoring
// ============================================================

///|
/// 语义质量分 / Semantic quality score.
///
/// 综合长度分 + 词汇丰富度分 + 非空分。
/// 公式：`length_score * 0.4 + diversity_score * 0.4 + nonempty_score * 0.2`。
/// 退化安全：空内容返回 0.0。
pub fn semantic_semantic_quality_score(input : @dataobject.DataObject) -> Double {
  let len = input.content.length()
  if len == 0 {
    0.0
  } else {
    let length_score = if len >= 100 { 1.0 } else { len.to_double() / 100.0 }
    let diversity = semantic_content_diversity_score(input)
    let nonempty = 1.0
    length_score * 0.4 + diversity * 0.4 + nonempty * 0.2
  }
}

///|
/// 词汇丰富度分 / Content diversity score.
///
/// 基于唯一字符数 / 总字符数。全相同字符返回接近 0.0，全不同返回 1.0。
/// 退化安全：空内容返回 0.0。
pub fn semantic_content_diversity_score(input : @dataobject.DataObject) -> Double {
  let chars = input.content.to_array()
  let len = chars.length()
  if len == 0 {
    0.0
  } else {
    let seen : Array[Char] = []
    for i in 0..<len {
      let c = chars[i]
      let mut found = false
      for j in 0..<seen.length() {
        if seen[j] == c {
          found = true
        }
      }
      if !found {
        seen.push(c)
      }
    }
    seen.length().to_double() / len.to_double()
  }
}

// ============================================================
// 改写算子 / Rewrite operators
// ============================================================

///|
/// 文本改写 / Rewrite text.
///
/// 按模式进行规则改写（模拟 LLM 改写）。
pub fn semantic_rewrite_text(
  input : @dataobject.DataObject,
  mode : RewriteMode,
) -> @dataobject.DataObject {
  let new_content = match mode {
    Simplify => semantic_simplify_content(input.content)
    Formalize => semantic_formalize_content(input.content)
    Casual => semantic_casual_content(input.content)
    Expand => semantic_expand_content(input.content)
  }
  @dataobject.make_dataobject(new_content, input.modality, input.schema)
}

///|
/// 简化内容 / Simplify content: trim + truncate to 200.
fn semantic_simplify_content(s : String) -> String {
  let trimmed = s.trim().to_owned()
  let chars = trimmed.to_array()
  let len = chars.length()
  if len <= 200 {
    trimmed
  } else {
    String::from_array(chars[0:200])
  }
}

///|
/// 正式化内容 / Formalize content: capitalize first letter.
fn semantic_formalize_content(s : String) -> String {
  let chars = s.to_array()
  let len = chars.length()
  if len == 0 {
    ""
  } else {
    let arr : Array[Char] = [chars[0].to_ascii_uppercase()]
    for i in 1..<len {
      arr.push(chars[i])
    }
    String::from_array(arr)
  }
}

///|
/// 口语化内容 / Casual content: 模拟（规则占位，原样返回）.
fn semantic_casual_content(s : String) -> String {
  s
}

///|
/// 扩写内容 / Expand content: repeat core content.
fn semantic_expand_content(s : String) -> String {
  let trimmed = s.trim().to_owned()
  if trimmed.length() == 0 {
    ""
  } else {
    trimmed + " " + trimmed
  }
}

// ============================================================
// 合成算子 / Synthesis operators
// ============================================================

///|
/// 文本合成 / Synthesize text.
///
/// 按模式进行规则合成（模拟 LLM 合成新样本）。
pub fn semantic_synthesize_text(
  input : @dataobject.DataObject,
  mode : SynthesisMode,
) -> @dataobject.DataObject {
  let new_content = match mode {
    Paraphrase => semantic_paraphrase_content(input.content)
    Augment => semantic_augment_content(input.content)
    Interpolate => semantic_interpolate_content(input.content)
  }
  @dataobject.make_dataobject(new_content, input.modality, input.schema)
}

///|
/// 改写复述 / Paraphrase: 简单变换（首尾加标记）.
fn semantic_paraphrase_content(s : String) -> String {
  if s.length() == 0 {
    ""
  } else {
    "[paraphrase] " + s + " [/paraphrase]"
  }
}

///|
/// 增强 / Augment: 拼接重复.
fn semantic_augment_content(s : String) -> String {
  if s.length() == 0 {
    ""
  } else {
    s + " | " + s
  }
}

///|
/// 插值 / Interpolate: 混合变换（模拟）.
fn semantic_interpolate_content(s : String) -> String {
  if s.length() == 0 {
    ""
  } else {
    "[interp] " + s
  }
}

///|
/// 改写模式名称 / Rewrite mode name.
pub fn semantic_rewrite_mode_name(mode : RewriteMode) -> String {
  match mode {
    Simplify => "simplify"
    Formalize => "formalize"
    Casual => "casual"
    Expand => "expand"
  }
}

///|
/// 合成模式名称 / Synthesis mode name.
pub fn semantic_synthesis_mode_name(mode : SynthesisMode) -> String {
  match mode {
    Paraphrase => "paraphrase"
    Augment => "augment"
    Interpolate => "interpolate"
  }
}

///|
pub fn semantic_semantic_id() -> String {
  "opcore/semantic"
}
// ============================================================
// S2.11 停用词过滤 / Stopword filtering
// ============================================================

///|
/// 默认英文停用词 / Default English stopwords.
pub fn semantic_default_stopwords() -> Array[String] {
  [
    "a", "an", "the", "is", "are", "was", "were", "be", "been", "being", "have",
    "has", "had", "do", "does", "did", "will", "would", "could", "should", "may",
    "might", "must", "can", "of", "in", "on", "at", "to", "for", "with", "by", "from",
    "as", "and", "or", "not", "but", "if", "then", "else", "this", "that", "these",
    "those", "i", "you", "he", "she", "it", "we", "they", "me", "him", "her", "us",
    "them",
  ]
}

///|
/// 按空格分词 / Split text into words by whitespace.
fn semantic_split_words(s : String) -> Array[String] {
  let chars = s.to_array()
  let len = chars.length()
  let result : Array[String] = []
  let current : Array[Char] = []
  for i in 0..<len {
    let c = chars[i]
    if c == ' ' || c == '\t' || c == '\n' || c == '\r' {
      if current.length() > 0 {
        result.push(String::from_array(current))
        current.clear()
      }
    } else {
      current.push(c)
    }
  }
  if current.length() > 0 {
    result.push(String::from_array(current))
  }
  result
}

///|
/// 判断单词是否在停用词表 / Check if word is a stopword.
fn semantic_is_stopword(word : String, stopwords : Array[String]) -> Bool {
  let lower = word.to_lower()
  let mut found = false
  for i in 0..<stopwords.length() {
    if stopwords[i] == lower {
      found = true
    }
  }
  found
}

///|
/// 停用词过滤（默认词表）/ Remove stopwords (default list).
pub fn semantic_remove_stopwords(
  input : @dataobject.DataObject,
) -> @dataobject.DataObject {
  semantic_remove_stopwords_custom(input, semantic_default_stopwords())
}

///|
/// 停用词过滤（自定义词表）/ Remove stopwords (custom list).
pub fn semantic_remove_stopwords_custom(
  input : @dataobject.DataObject,
  stopwords : Array[String],
) -> @dataobject.DataObject {
  let words = semantic_split_words(input.content)
  let kept : Array[String] = []
  for i in 0..<words.length() {
    if !semantic_is_stopword(words[i], stopwords) {
      kept.push(words[i])
    }
  }
  let new_content = semantic_join_strings(kept, " ")
  @dataobject.make_dataobject(new_content, input.modality, input.schema)
}

///|
/// 用分隔符拼接字符串数组 / Join string array with separator.
fn semantic_join_strings(arr : Array[String], sep : String) -> String {
  if arr.length() == 0 {
    ""
  } else {
    let mut result = arr[0]
    for i in 1..<arr.length() {
      result = result + sep + arr[i]
    }
    result
  }
}

// ============================================================
// S2.11 更多改写函数 / Additional rewrite functions
// ============================================================

///|
/// 去除首尾空白 / Trim whitespace.
pub fn semantic_rewrite_trim(input : @dataobject.DataObject) -> @dataobject.DataObject {
  let new_content = input.content.trim().to_owned()
  @dataobject.make_dataobject(new_content, input.modality, input.schema)
}

///|
/// 转小写 / Convert to lowercase.
pub fn semantic_rewrite_lowercase(
  input : @dataobject.DataObject,
) -> @dataobject.DataObject {
  let new_content = input.content.to_lower()
  @dataobject.make_dataobject(new_content, input.modality, input.schema)
}

///|
/// 转大写 / Convert to uppercase.
pub fn semantic_rewrite_uppercase(
  input : @dataobject.DataObject,
) -> @dataobject.DataObject {
  let new_content = input.content.to_upper()
  @dataobject.make_dataobject(new_content, input.modality, input.schema)
}

// ============================================================
// S2.11 更多合成函数 / Additional synthesis functions
// ============================================================

///|
/// 拼接两段文本 / Concatenate two DataObjects.
pub fn semantic_synthesize_concat(
  a : @dataobject.DataObject,
  b : @dataobject.DataObject,
) -> @dataobject.DataObject {
  let new_content = a.content + " " + b.content
  @dataobject.make_dataobject(new_content, a.modality, a.schema)
}

///|
/// 模板填充 / Template fill.
///
/// 将 template 中的 `{}` 替换为 input.content。
pub fn semantic_synthesize_template(
  input : @dataobject.DataObject,
  template : String,
) -> @dataobject.DataObject {
  let result = semantic_replace_all(template, "{}", input.content)
  @dataobject.make_dataobject(result, input.modality, input.schema)
}

///|
/// 手动字符串替换 / Manual string replace (replace all occurrences of old_str with new_str).
fn semantic_replace_all(s : String, old_str : String, new_str : String) -> String {
  if old_str.length() == 0 {
    s
  } else {
    let chars = s.to_array()
    let old_chars = old_str.to_array()
    let new_chars = new_str.to_array()
    let old_len = old_chars.length()
    let new_len = new_chars.length()
    let result : Array[Char] = []
    let n = chars.length()
    let mut idx = 0
    while idx < n {
      if idx + old_len <= n {
        let mut is_match = true
        for j in 0..<old_len {
          if chars[idx + j] != old_chars[j] {
            is_match = false
          }
        }
        if is_match {
          for j in 0..<new_len {
            result.push(new_chars[j])
          }
          idx = idx + old_len
        } else {
          result.push(chars[idx])
          idx = idx + 1
        }
      } else {
        result.push(chars[idx])
        idx = idx + 1
      }
    }
    String::from_array(result)
  }
}

// ============================================================
// S2.11 词频统计 / Word frequency
// ============================================================

///|
/// 词频统计 / Word frequency count.
///
/// 返回 (word, count) 数组，按词频降序排列。
/// 退化安全：空内容返回空数组。
pub fn semantic_word_frequency(input : @dataobject.DataObject) -> Array[(String, Int32)] {
  let words = semantic_split_words(input.content)
  if words.length() == 0 {
    []
  } else {
    let result : Array[(String, Int32)] = []
    let counted : Array[String] = []
    for i in 0..<words.length() {
      let w = words[i]
      let mut already = false
      for j in 0..<counted.length() {
        if counted[j] == w {
          already = true
        }
      }
      if !already {
        let mut cnt = 0
        for k in 0..<words.length() {
          if words[k] == w {
            cnt = cnt + 1
          }
        }
        result.push((w, cnt))
        counted.push(w)
      }
    }
    result.sort_by(fn(a, b) {
      let (_, cnt_a) = a
      let (_, cnt_b) = b
      cnt_b - cnt_a
    })
    result
  }
}

// ============================================================
// S2.11 文本相似度 / Text similarity
// ============================================================

///|
/// Jaccard 词集相似度 / Jaccard word-set similarity.
///
/// 公式：`|A ∩ B| / |A ∪ B|`。
/// 退化安全：两者皆空返回 0.0。
pub fn semantic_text_similarity(
  a : @dataobject.DataObject,
  b : @dataobject.DataObject,
) -> Double {
  let words_a = semantic_split_words(a.content)
  let words_b = semantic_split_words(b.content)
  let set_a : Array[String] = []
  for i in 0..<words_a.length() {
    let mut found = false
    for j in 0..<set_a.length() {
      if set_a[j] == words_a[i] {
        found = true
      }
    }
    if !found {
      set_a.push(words_a[i])
    }
  }
  let set_b : Array[String] = []
  for i in 0..<words_b.length() {
    let mut found = false
    for j in 0..<set_b.length() {
      if set_b[j] == words_b[i] {
        found = true
      }
    }
    if !found {
      set_b.push(words_b[i])
    }
  }
  let union : Array[String] = []
  for i in 0..<set_a.length() {
    union.push(set_a[i])
  }
  for i in 0..<set_b.length() {
    let mut found = false
    for j in 0..<union.length() {
      if union[j] == set_b[i] {
        found = true
      }
    }
    if !found {
      union.push(set_b[i])
    }
  }
  let intersection : Array[String] = []
  for i in 0..<set_a.length() {
    let mut found = false
    for j in 0..<set_b.length() {
      if set_b[j] == set_a[i] {
        found = true
      }
    }
    if found {
      intersection.push(set_a[i])
    }
  }
  if union.length() == 0 {
    0.0
  } else {
    intersection.length().to_double() / union.length().to_double()
  }
}

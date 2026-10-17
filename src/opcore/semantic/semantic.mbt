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

/// 改写模式 / Rewrite mode.
pub(all) enum RewriteMode {
  Simplify    // 简化：去多余空格、截断长文本
  Formalize   // 正式化：首字母大写
  Casual      // 口语化：模拟（规则占位）
  Expand      // 扩写：重复核心内容
} derive(Debug, Eq)

pub extend RewriteMode with Eq::{equal, not_equal}
pub extend RewriteMode with Debug::{to_repr}

/// 合成模式 / Synthesis mode.
pub(all) enum SynthesisMode {
  Paraphrase   // 改写复述：简单变换
  Augment      // 增强：拼接重复
  Interpolate  // 插值：混合两段文本
} derive(Debug, Eq)

pub extend SynthesisMode with Eq::{equal, not_equal}
pub extend SynthesisMode with Debug::{to_repr}

// ============================================================
// 语义质量评分 / Semantic quality scoring
// ============================================================

/// 语义质量分 / Semantic quality score.
///
/// 综合长度分 + 词汇丰富度分 + 非空分。
/// 公式：`length_score * 0.4 + diversity_score * 0.4 + nonempty_score * 0.2`。
/// 退化安全：空内容返回 0.0。
pub fn semantic_quality_score(input : @dataobject.DataObject) -> Double {
  let len = input.content.length()
  if len == 0 {
    0.0
  } else {
    let length_score = if len >= 100 { 1.0 } else { len.to_double() / 100.0 }
    let diversity = content_diversity_score(input)
    let nonempty = 1.0
    length_score * 0.4 + diversity * 0.4 + nonempty * 0.2
  }
}

/// 词汇丰富度分 / Content diversity score.
///
/// 基于唯一字符数 / 总字符数。全相同字符返回接近 0.0，全不同返回 1.0。
/// 退化安全：空内容返回 0.0。
pub fn content_diversity_score(input : @dataobject.DataObject) -> Double {
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

/// 文本改写 / Rewrite text.
///
/// 按模式进行规则改写（模拟 LLM 改写）。
pub fn rewrite_text(input : @dataobject.DataObject, mode : RewriteMode) -> @dataobject.DataObject {
  let new_content = match mode {
    Simplify => simplify_content(input.content)
    Formalize => formalize_content(input.content)
    Casual => casual_content(input.content)
    Expand => expand_content(input.content)
  }
  @dataobject.make_dataobject(new_content, input.modality, input.schema)
}

/// 简化内容 / Simplify content: trim + truncate to 200.
fn simplify_content(s : String) -> String {
  let trimmed = s.trim().to_owned()
  let chars = trimmed.to_array()
  let len = chars.length()
  if len <= 200 {
    trimmed
  } else {
    String::from_array(chars[0:200])
  }
}

/// 正式化内容 / Formalize content: capitalize first letter.
fn formalize_content(s : String) -> String {
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

/// 口语化内容 / Casual content: 模拟（规则占位，原样返回）.
fn casual_content(s : String) -> String {
  s
}

/// 扩写内容 / Expand content: repeat core content.
fn expand_content(s : String) -> String {
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

/// 文本合成 / Synthesize text.
///
/// 按模式进行规则合成（模拟 LLM 合成新样本）。
pub fn synthesize_text(input : @dataobject.DataObject, mode : SynthesisMode) -> @dataobject.DataObject {
  let new_content = match mode {
    Paraphrase => paraphrase_content(input.content)
    Augment => augment_content(input.content)
    Interpolate => interpolate_content(input.content)
  }
  @dataobject.make_dataobject(new_content, input.modality, input.schema)
}

/// 改写复述 / Paraphrase: 简单变换（首尾加标记）.
fn paraphrase_content(s : String) -> String {
  if s.length() == 0 {
    ""
  } else {
    "[paraphrase] " + s + " [/paraphrase]"
  }
}

/// 增强 / Augment: 拼接重复.
fn augment_content(s : String) -> String {
  if s.length() == 0 {
    ""
  } else {
    s + " | " + s
  }
}

/// 插值 / Interpolate: 混合变换（模拟）.
fn interpolate_content(s : String) -> String {
  if s.length() == 0 {
    ""
  } else {
    "[interp] " + s
  }
}

/// 改写模式名称 / Rewrite mode name.
pub fn rewrite_mode_name(mode : RewriteMode) -> String {
  match mode {
    Simplify => "simplify"
    Formalize => "formalize"
    Casual => "casual"
    Expand => "expand"
  }
}

/// 合成模式名称 / Synthesis mode name.
pub fn synthesis_mode_name(mode : SynthesisMode) -> String {
  match mode {
    Paraphrase => "paraphrase"
    Augment => "augment"
    Interpolate => "interpolate"
  }
}

pub fn semantic_id() -> String {
  "opcore/semantic"
}
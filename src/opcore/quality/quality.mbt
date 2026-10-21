///|
/// # opcore/quality 质量评分算子 / Quality Scoring Operators
///
/// 质量模型打分、分类器阈值。架构 §4.3.2 ⑥。
/// S1.1 填充：length_quality_score（基于长度的归一化打分）。
///
/// # Quality operators
///
/// Quality model scoring. See architecture §4.3.2 ⑥.

///|
/// 长度质量分：基于内容长度的归一化打分 / Length-based quality score.
///
/// 打分公式：`min(length / 100, 1.0)`。空内容 0.0，≥100 字符 1.0。
pub fn length_quality_score(input : @dataobject.DataObject) -> Double {
  let len = input.content.length()
  if len == 0 {
    0.0
  } else if len >= 100 {
    1.0
  } else {
    len.to_double() / 100.0
  }
}

///|
/// 文本质量分：综合长度与非空比 / Text quality score.
///
/// S1.1 基础版：长度分 × 0.7 + 非空分 × 0.3。
pub fn text_quality_score(input : @dataobject.DataObject) -> Double {
  let len_score = length_quality_score(input)
  let nonempty_score = if input.content.length() > 0 { 1.0 } else { 0.0 }
  len_score * 0.7 + nonempty_score * 0.3
}

///|
pub fn quality_id() -> String {
  "opcore/quality"
}

///|
/// # opcore/annotate 标注与推理算子 / Annotate & Inference Operators
///
/// LLM 标注、意图识别、情感分析、主题分类。架构 §4.3.2 ⑧。
/// S1.1 填充：tag_by_length（按长度标注 short/medium/long）。
///
/// # Annotate operators
///
/// LLM annotation, intent/sentiment/topic. See architecture §4.3.2 ⑧.

///|
/// 按长度标注：加 metadata 标签 short/medium/long / Tag by length.
///
/// - short: < 50 字符
/// - medium: 50-200 字符
/// - long: > 200 字符
pub fn tag_by_length(input : @dataobject.DataObject) -> @dataobject.DataObject {
  let len = input.content.length()
  let tag = if len < 50 {
    "short"
  } else if len <= 200 {
    "medium"
  } else {
    "long"
  }
  let new_metadata = input.metadata + [("length_tag", tag)]
  @dataobject.make_dataobject_with_metadata(
    input.content,
    input.modality,
    input.schema,
    new_metadata,
  )
}

///|
/// 标注模态：加 metadata 记录模态 / Tag modality.
pub fn tag_modality(input : @dataobject.DataObject) -> @dataobject.DataObject {
  let modality_str = match input.modality {
    @dataobject.Text => "text"
    @dataobject.Image => "image"
    @dataobject.Audio => "audio"
    @dataobject.Video => "video"
    @dataobject.Table => "table"
    @dataobject.Code => "code"
    @dataobject.Multi => "multi"
  }
  let new_metadata = input.metadata + [("modality_tag", modality_str)]
  @dataobject.make_dataobject_with_metadata(
    input.content,
    input.modality,
    input.schema,
    new_metadata,
  )
}

///|
pub fn annotate_id() -> String {
  "opcore/annotate"
}

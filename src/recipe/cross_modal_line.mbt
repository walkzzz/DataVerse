///|
/// # recipe/cross_modal_line 跨模态一致性线 / Cross-Modal Consistency Pipeline
///
/// 编排：modality_count → consistency_score → missing_check。架构 §4.5 ④。
/// 检查跨模态数据一致性。
///
/// # Cross-modal consistency pipeline
///
/// modality_count → consistency_score → missing_check. See architecture §4.5 ④.

///|
/// 跨模态报告 / Cross-modal report.
pub struct CrossModalReport {
  total_count : Int32
  text_count : Int32
  image_count : Int32
  audio_count : Int32
  video_count : Int32
  multi_count : Int32
  consistency_score : Double
  missing_modalities : Array[String]
} derive(Debug, Eq)

///|
pub extend CrossModalReport with Eq::{equal, not_equal}

///|
pub extend CrossModalReport with Debug::{to_repr}

///|
/// 跨模态一致性线 / Cross-modal consistency line.
///
/// 统计各模态数量，计算一致性分数（非空模态种类数 / 4），找出缺失模态。
/// 退化安全：空数组返回全 0 报告。
pub fn cross_modal_line(
  arr : Array[@dataobject.DataObject],
) -> CrossModalReport {
  let total = arr.length()
  let mut text_c = 0
  let mut image_c = 0
  let mut audio_c = 0
  let mut video_c = 0
  let mut multi_c = 0
  for i in 0..<total {
    match arr[i].modality {
      @dataobject.Text => text_c = text_c + 1
      @dataobject.Image => image_c = image_c + 1
      @dataobject.Audio => audio_c = audio_c + 1
      @dataobject.Video => video_c = video_c + 1
      @dataobject.Multi => multi_c = multi_c + 1
      _ => ()
    }
  }
  let present = Array::make(4, false)
  if text_c > 0 {
    present[0] = true
  }
  if image_c > 0 {
    present[1] = true
  }
  if audio_c > 0 {
    present[2] = true
  }
  if video_c > 0 {
    present[3] = true
  }
  let mut present_count = 0
  for i in 0..<4 {
    if present[i] {
      present_count = present_count + 1
    }
  }
  let consistency = if total == 0 {
    0.0
  } else {
    present_count.to_double() / 4.0
  }
  let missing : Array[String] = []
  if text_c == 0 {
    missing.push("text")
  }
  if image_c == 0 {
    missing.push("image")
  }
  if audio_c == 0 {
    missing.push("audio")
  }
  if video_c == 0 {
    missing.push("video")
  }
  {
    total_count: total,
    text_count: text_c,
    image_count: image_c,
    audio_count: audio_c,
    video_count: video_c,
    multi_count: multi_c,
    consistency_score: consistency,
    missing_modalities: missing,
  }
}

///|
pub fn cross_modal_line_id() -> String {
  "recipe/cross_modal_line"
}

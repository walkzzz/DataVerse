///|
/// # recipe/eval_line 评估流水线 / Evaluation Pipeline
///
/// 编排：quality_score → statistics → report。架构 §4.5 ③。
/// 对标 DJ eval 流水线。
///
/// # Evaluation pipeline
///
/// quality_score → statistics → report. See architecture §4.5 ③.

///|
/// 评估报告 / Evaluation report.
pub struct EvalReport {
  total_count : Int32
  avg_quality : Double
  min_quality : Double
  max_quality : Double
  text_count : Int32
  image_count : Int32
  audio_count : Int32
  video_count : Int32
  other_count : Int32
} derive(Debug, Eq)

///|
pub extend EvalReport with Eq::{equal, not_equal}

///|
pub extend EvalReport with Debug::{to_repr}

///|
/// 空评估报告（退化安全）/ Empty eval report (degenerate-safe).
pub fn empty_eval_report() -> EvalReport {
  {
    total_count: 0,
    avg_quality: 0.0,
    min_quality: 0.0,
    max_quality: 0.0,
    text_count: 0,
    image_count: 0,
    audio_count: 0,
    video_count: 0,
    other_count: 0,
  }
}

///|
/// 评估流水线 / Evaluation line.
///
/// 对每个 DataObject 计算 text_quality_score，聚合为 EvalReport。
/// 退化安全：空数组返回 empty_eval_report。
pub fn eval_line(arr : Array[@dataobject.DataObject]) -> EvalReport {
  let total = arr.length()
  if total == 0 {
    empty_eval_report()
  } else {
    let mut sum_q = 0.0
    let mut min_q = 1.0
    let mut max_q = 0.0
    let mut text_c = 0
    let mut image_c = 0
    let mut audio_c = 0
    let mut video_c = 0
    let mut other_c = 0
    for i in 0..<total {
      let d = arr[i]
      let q = @quality.text_quality_score(d)
      sum_q = sum_q + q
      if q < min_q {
        min_q = q
      }
      if q > max_q {
        max_q = q
      }
      match d.modality {
        @dataobject.Text => text_c = text_c + 1
        @dataobject.Image => image_c = image_c + 1
        @dataobject.Audio => audio_c = audio_c + 1
        @dataobject.Video => video_c = video_c + 1
        _ => other_c = other_c + 1
      }
    }
    {
      total_count: total,
      avg_quality: sum_q / total.to_double(),
      min_quality: min_q,
      max_quality: max_q,
      text_count: text_c,
      image_count: image_c,
      audio_count: audio_c,
      video_count: video_c,
      other_count: other_c,
    }
  }
}

///|
pub fn eval_line_id() -> String {
  "recipe/eval_line"
}

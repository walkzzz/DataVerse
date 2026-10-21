///|
/// S9.3 视频处理深化 / Video Processing Deepening

///|
/// 视频帧序列 / Video frame sequence.
pub struct FrameSequence {
  frames : Array[@image.GrayImage]
  fps : Int32
}

///|
/// 构造帧序列 / Create frame sequence.
pub fn make_frame_sequence(
  frames : Array[@image.GrayImage],
  fps : Int32,
) -> FrameSequence {
  { frames, fps, }
}

///|
/// 帧数 / Frame count.
pub fn frame_count_seq(seq : FrameSequence) -> Int32 {
  seq.frames.length()
}

///|
/// 视频时长（秒）/ Video duration (seconds).
pub fn video_duration_sec(seq : FrameSequence) -> Double {
  seq.frames.length().to_double() / seq.fps.to_double()
}

///|
/// 帧差分 / Frame difference (returns difference image between consecutive frames).
pub fn frame_difference(seq : FrameSequence) -> Array[@image.GrayImage] {
  let result : Array[@image.GrayImage] = []
  if seq.frames.length() <= 1 {
    return result
  }
  for i in 1..<seq.frames.length() {
    let prev = seq.frames[i - 1]
    let curr = seq.frames[i]
    let diff_pixels : Array[Double] = []
    for j in 0..<curr.pixels.length() {
      let d = curr.pixels[j] - prev.pixels[j]
      let abs_d = if d < 0.0 { -d } else { d }
      diff_pixels.push(abs_d)
    }
    result.push(@image.make_gray_image(curr.width, curr.height, diff_pixels))
  }
  result
}

///|
/// 运动强度 / Motion intensity (mean of frame differences).
pub fn motion_intensity(seq : FrameSequence) -> Double {
  let diffs = frame_difference(seq)
  if diffs.length() == 0 {
    return 0.0
  }
  let mut total = 0.0
  let mut count = 0
  for i in 0..<diffs.length() {
    for j in 0..<diffs[i].pixels.length() {
      total = total + diffs[i].pixels[j]
      count = count + 1
    }
  }
  if count == 0 {
    return 0.0
  }
  total / count.to_double()
}

///|
/// 关键帧提取 / Keyframe extraction (select frames with highest motion).
pub fn extract_keyframes(
  seq : FrameSequence,
  n_keyframes : Int32,
) -> Array[Int32] {
  let diffs = frame_difference(seq)
  let scores : Array[(Int32, Double)] = []
  for i in 0..<diffs.length() {
    let mut sum = 0.0
    for j in 0..<diffs[i].pixels.length() {
      sum = sum + diffs[i].pixels[j]
    }
    scores.push((i + 1, sum))
  }
  scores.sort_by(fn(a, b) {
    if a.1 > b.1 {
      -1
    } else if a.1 < b.1 {
      1
    } else {
      0
    }
  })
  let result : Array[Int32] = []
  let n = if n_keyframes < scores.length() {
    n_keyframes
  } else {
    scores.length()
  }
  for i in 0..<n {
    result.push(scores[i].0)
  }
  result.sort_by(fn(a, b) { if a < b { -1 } else if a > b { 1 } else { 0 } })
  result
}

///|
/// 帧均值 / Frame average (temporal average).
pub fn frame_average(seq : FrameSequence) -> @image.GrayImage {
  if seq.frames.length() == 0 {
    return @image.make_gray_image(0, 0, [])
  }
  let w = seq.frames[0].width
  let h = seq.frames[0].height
  let result : Array[Double] = Array::make(w * h, 0.0)
  for i in 0..<seq.frames.length() {
    for j in 0..<seq.frames[i].pixels.length() {
      if j < result.length() {
        result[j] = result[j] + seq.frames[i].pixels[j]
      }
    }
  }
  let n = seq.frames.length().to_double()
  for j in 0..<result.length() {
    result[j] = result[j] / n
  }
  @image.make_gray_image(w, h, result)
}

///|
/// 视频稳定度 / Video stability (inverse of motion intensity).
pub fn video_stability(seq : FrameSequence) -> Double {
  let motion = motion_intensity(seq)
  if motion == 0.0 {
    return 1.0
  }
  1.0 / (1.0 + motion)
}

///|
///===
/// opcore/tone_map
/// S13.51 new
pub struct Tone_mapPoint {
  x : Double
  y : Double
  label : Int32
}

///|
pub fn tone_map_tone_map_make_point(x : Double, y : Double) -> Tone_mapPoint {
  { x, y, label: 0, }
}

///|
pub fn tone_map_tone_map_make_labeled_point(
  x : Double,
  y : Double,
  label : Int32,
) -> Tone_mapPoint {
  { x, y, label, }
}

///|
pub fn tone_map_tone_map_point_x(p : Tone_mapPoint) -> Double {
  p.x
}

///|
pub fn tone_map_tone_map_point_y(p : Tone_mapPoint) -> Double {
  p.y
}

///|
pub fn tone_map_tone_map_point_label(p : Tone_mapPoint) -> Int32 {
  p.label
}

///|
pub fn tone_map_tone_map_point_dist(a : Tone_mapPoint, b : Tone_mapPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  @_common.sqrt(dx * dx + dy * dy)
}

///|
pub fn tone_map_tone_map_point_add(
  a : Tone_mapPoint,
  b : Tone_mapPoint,
) -> Tone_mapPoint {
  { x: a.x + b.x, y: a.y + b.y, label: a.label, }
}

///|
pub fn tone_map_tone_map_point_sub(
  a : Tone_mapPoint,
  b : Tone_mapPoint,
) -> Tone_mapPoint {
  { x: a.x - b.x, y: a.y - b.y, label: a.label, }
}

///|
pub fn tone_map_tone_map_point_scale(pt : Tone_mapPoint, s : Double) -> Tone_mapPoint {
  { x: pt.x * s, y: pt.y * s, label: pt.label, }
}

///|
pub fn tone_map_tone_map_point_dot(a : Tone_mapPoint, b : Tone_mapPoint) -> Double {
  a.x * b.x + a.y * b.y
}

///|
pub fn tone_map_tone_map_point_norm(pt : Tone_mapPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y)
}

///|
pub fn tone_map_tone_map_point_to_string(pt : Tone_mapPoint) -> String {
  "(" +
  tone_map_tone_map_dbl(pt.x) +
  ", " +
  tone_map_tone_map_dbl(pt.y) +
  ")[" +
  pt.label.to_string() +
  "]"
}

///|
pub struct Tone_mapSeries {
  vals : Array[Double]
  name : String
}

///|
pub fn tone_map_tone_map_make_series(
  vals : Array[Double],
  name : String,
) -> Tone_mapSeries {
  { vals, name, }
}

///|
pub fn tone_map_tone_map_series_len(s : Tone_mapSeries) -> Int32 {
  s.vals.length()
}

///|
pub fn tone_map_tone_map_series_sum(s : Tone_mapSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() {
    total = total + s.vals[i]
  }
  total
}

///|
pub fn tone_map_tone_map_series_mean(s : Tone_mapSeries) -> Double {
  let n = tone_map_tone_map_series_len(s)
  if n == 0 {
    0.0
  } else {
    tone_map_tone_map_series_sum(s) / n.to_double()
  }
}

///|
pub fn tone_map_tone_map_series_min(s : Tone_mapSeries) -> Double {
  let n = tone_map_tone_map_series_len(s)
  if n == 0 {
    0.0
  } else {
    let mut m = s.vals[0]
    for i in 1..<n {
      if s.vals[i] < m {
        m = s.vals[i]
      }
    }
    m
  }
}

///|
pub fn tone_map_tone_map_series_max(s : Tone_mapSeries) -> Double {
  let n = tone_map_tone_map_series_len(s)
  if n == 0 {
    0.0
  } else {
    let mut m = s.vals[0]
    for i in 1..<n {
      if s.vals[i] > m {
        m = s.vals[i]
      }
    }
    m
  }
}

///|
pub fn tone_map_tone_map_series_var(s : Tone_mapSeries) -> Double {
  let n = tone_map_tone_map_series_len(s)
  if n == 0 {
    0.0
  } else {
    let m = tone_map_tone_map_series_mean(s)
    let mut total = 0.0
    for i in 0..<n {
      let d = s.vals[i] - m
      total = total + d * d
    }
    total / n.to_double()
  }
}

///|
pub fn tone_map_tone_map_series_std(s : Tone_mapSeries) -> Double {
  @_common.sqrt(tone_map_tone_map_series_var(s))
}

///|
pub fn tone_map_tone_map_series_scale(s : Tone_mapSeries, f : Double) -> Tone_mapSeries {
  let mut result = []
  for i in 0..<s.vals.length() {
    result = tone_map_tone_map_push(result, s.vals[i] * f)
  }
  { vals: result, name: s.name, }
}

///|
pub fn tone_map_tone_map_series_add(
  a : Tone_mapSeries,
  b : Tone_mapSeries,
) -> Tone_mapSeries {
  let n = if a.vals.length() < b.vals.length() {
    a.vals.length()
  } else {
    b.vals.length()
  }
  let mut result = []
  for i in 0..<n {
    result = tone_map_tone_map_push(result, a.vals[i] + b.vals[i])
  }
  { vals: result, name: a.name + "+" + b.name, }
}

///|
pub fn tone_map_tone_map_series_to_string(s : Tone_mapSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim {
    if i > 0 {
      result = result + ", "
    }
    result = result + tone_map_tone_map_dbl(s.vals[i])
  }
  if n > 10 {
    result + "...]"
  } else {
    result + "]"
  }
}

///|
pub struct Tone_mapMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn tone_map_tone_map_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> Tone_mapMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows {
    data[i] = Array::make(cols, val)
  }
  { data, rows, cols, }
}

///|
pub fn tone_map_tone_map_matrix_identity(n : Int32) -> Tone_mapMatrix {
  let m = tone_map_tone_map_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn tone_map_tone_map_matrix_get(m : Tone_mapMatrix, i : Int32, j : Int32) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols {
    0.0
  } else {
    m.data[i][j]
  }
}

///|
pub fn tone_map_tone_map_matrix_transpose(m : Tone_mapMatrix) -> Tone_mapMatrix {
  let result = tone_map_tone_map_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows {
    for j in 0..<m.cols {
      result.data[j][i] = m.data[i][j]
    }
  }
  result
}

///|
pub fn tone_map_tone_map_matrix_add(
  a : Tone_mapMatrix,
  b : Tone_mapMatrix,
) -> Tone_mapMatrix {
  if a.rows != b.rows || a.cols != b.cols {
    return a
  }
  let result = tone_map_tone_map_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<a.cols {
      result.data[i][j] = a.data[i][j] + b.data[i][j]
    }
  }
  result
}

///|
pub fn tone_map_tone_map_matrix_scale(m : Tone_mapMatrix, s : Double) -> Tone_mapMatrix {
  let result = tone_map_tone_map_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows {
    for j in 0..<m.cols {
      result.data[i][j] = m.data[i][j] * s
    }
  }
  result
}

///|
pub fn tone_map_tone_map_matrix_multiply(
  a : Tone_mapMatrix,
  b : Tone_mapMatrix,
) -> Tone_mapMatrix {
  if a.cols != b.rows {
    return tone_map_tone_map_make_matrix(a.rows, b.cols, 0.0)
  }
  let result = tone_map_tone_map_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols {
        sum = sum + a.data[i][k] * b.data[k][j]
      }
      result.data[i][j] = sum
    }
  }
  result
}

///|
pub fn tone_map_tone_map_matrix_trace(m : Tone_mapMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + m.data[i][i]
  }
  sum
}

///|
pub fn tone_map_tone_map_matrix_norm(m : Tone_mapMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows {
    for j in 0..<m.cols {
      sum = sum + m.data[i][j] * m.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn tone_map_tone_map_matrix_to_string(m : Tone_mapMatrix) -> String {
  let mut result = "Mat(" +
    m.rows.to_string() +
    "x" +
    m.cols.to_string() +
    ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl {
      if j > 0 {
        result = result + ", "
      }
      result = result + tone_map_tone_map_dbl(m.data[i][j])
    }
    result = result + "]\n"
  }
  result
}

///|
pub struct Tone_mapVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn tone_map_tone_map_make_vector(comps : Array[Double]) -> Tone_mapVector {
  { comps, dim: comps.length(), }
}

///|
pub fn tone_map_tone_map_vector_zero(dim : Int32) -> Tone_mapVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn tone_map_tone_map_vector_add(
  a : Tone_mapVector,
  b : Tone_mapVector,
) -> Tone_mapVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n {
    result = tone_map_tone_map_push(result, a.comps[i] + b.comps[i])
  }
  { comps: result, dim: n, }
}

///|
pub fn tone_map_tone_map_vector_sub(
  a : Tone_mapVector,
  b : Tone_mapVector,
) -> Tone_mapVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n {
    result = tone_map_tone_map_push(result, a.comps[i] - b.comps[i])
  }
  { comps: result, dim: n, }
}

///|
pub fn tone_map_tone_map_vector_scale(v : Tone_mapVector, s : Double) -> Tone_mapVector {
  let mut result = []
  for i in 0..<v.dim {
    result = tone_map_tone_map_push(result, v.comps[i] * s)
  }
  { comps: result, dim: v.dim, }
}

///|
pub fn tone_map_tone_map_vector_dot(a : Tone_mapVector, b : Tone_mapVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + a.comps[i] * b.comps[i]
  }
  sum
}

///|
pub fn tone_map_tone_map_vector_norm(v : Tone_mapVector) -> Double {
  @_common.sqrt(tone_map_tone_map_vector_dot(v, v))
}

///|
pub fn tone_map_tone_map_vector_normalize(v : Tone_mapVector) -> Tone_mapVector {
  let n = tone_map_tone_map_vector_norm(v)
  if n < 0.0000001 {
    v
  } else {
    tone_map_tone_map_vector_scale(v, 1.0 / n)
  }
}

///|
pub fn tone_map_tone_map_vector_dist(a : Tone_mapVector, b : Tone_mapVector) -> Double {
  tone_map_tone_map_vector_norm(tone_map_tone_map_vector_sub(a, b))
}

///|
pub fn tone_map_tone_map_vector_to_string(v : Tone_mapVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim {
    if i > 0 {
      result = result + ", "
    }
    result = result + tone_map_tone_map_dbl(v.comps[i])
  }
  if v.dim > 10 {
    result + "...]"
  } else {
    result + "]"
  }
}

///|
pub fn tone_map_tone_map_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 {
    0.0
  } else {
    let m = @_common.mean(data)
    let mut sum = 0.0
    for i in 0..<n {
      let d = data[i] - m
      sum = sum + d * d
    }
    sum / n.to_double()
  }
}

///|
pub fn tone_map_tone_map_std(data : Array[Double]) -> Double {
  @_common.sqrt(tone_map_tone_map_var(data))
}

///|
pub fn tone_map_tone_map_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 {
    0.0
  } else {
    let ma = @_common.mean(a)
    let mb = @_common.mean(b)
    let mut sum = 0.0
    for i in 0..<n {
      sum = sum + (a[i] - ma) * (b[i] - mb)
    }
    sum / n.to_double()
  }
}

///|
pub fn tone_map_tone_map_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = tone_map_tone_map_std(a)
  let sb = tone_map_tone_map_std(b)
  if sa < 0.0000001 || sb < 0.0000001 {
    0.0
  } else {
    tone_map_tone_map_cov(a, b) / (sa * sb)
  }
}

///|
pub fn tone_map_tone_map_accuracy(pred : Array[Int32], labels : Array[Int32]) -> Double {
  let n = if pred.length() < labels.length() {
    pred.length()
  } else {
    labels.length()
  }
  if n == 0 {
    0.0
  } else {
    let mut correct = 0
    for i in 0..<n {
      if pred[i] == labels[i] {
        correct = correct + 1
      }
    }
    correct.to_double() / n.to_double()
  }
}

///|
pub fn tone_map_tone_map_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() {
    pred.length()
  } else {
    labels.length()
  }
  if n == 0 {
    0.0
  } else {
    let mut sum = 0.0
    for i in 0..<n {
      let d = pred[i] - labels[i]
      sum = sum + d * d
    }
    sum / n.to_double()
  }
}

///|
pub fn tone_map_tone_map_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() {
    pred.length()
  } else {
    labels.length()
  }
  if n == 0 {
    0.0
  } else {
    let mut sum = 0.0
    for i in 0..<n {
      sum = sum + @_common.abs(pred[i] - labels[i])
    }
    sum / n.to_double()
  }
}

///|
pub fn tone_map_tone_map_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() {
    pred.length()
  } else {
    labels.length()
  }
  if n == 0 {
    0.0
  } else {
    let lm = @_common.mean(labels)
    let mut ss_res = 0.0
    let mut ss_tot = 0.0
    for i in 0..<n {
      let r = labels[i] - pred[i]
      ss_res = ss_res + r * r
      let t = labels[i] - lm
      ss_tot = ss_tot + t * t
    }
    if ss_tot < 0.0000001 {
      0.0
    } else {
      1.0 - ss_res / ss_tot
    }
  }
}

///|
pub fn tone_map_tone_map_precision(
  pred : Array[Int32],
  labels : Array[Int32],
  pos : Int32,
) -> Double {
  let n = if pred.length() < labels.length() {
    pred.length()
  } else {
    labels.length()
  }
  let mut tp = 0
  let mut fp = 0
  for i in 0..<n {
    if pred[i] == pos {
      if labels[i] == pos {
        tp = tp + 1
      } else {
        fp = fp + 1
      }
    }
  }
  if tp + fp == 0 {
    0.0
  } else {
    tp.to_double() / (tp + fp).to_double()
  }
}

///|
pub fn tone_map_tone_map_recall(
  pred : Array[Int32],
  labels : Array[Int32],
  pos : Int32,
) -> Double {
  let n = if pred.length() < labels.length() {
    pred.length()
  } else {
    labels.length()
  }
  let mut tp = 0
  let mut fn_ = 0
  for i in 0..<n {
    if labels[i] == pos {
      if pred[i] == pos {
        tp = tp + 1
      } else {
        fn_ = fn_ + 1
      }
    }
  }
  if tp + fn_ == 0 {
    0.0
  } else {
    tp.to_double() / (tp + fn_).to_double()
  }
}

///|
pub fn tone_map_tone_map_f1(
  pred : Array[Int32],
  labels : Array[Int32],
  pos : Int32,
) -> Double {
  let p_ = tone_map_tone_map_precision(pred, labels, pos)
  let r = tone_map_tone_map_recall(pred, labels, pos)
  if p_ + r < 0.0000001 {
    0.0
  } else {
    2.0 * p_ * r / (p_ + r)
  }
}

///|
fn tone_map_tone_map_dbl(x : Double) -> String {
  let i = if x >= 0.0 { tone_map_tone_map_int(x) } else { -tone_map_tone_map_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 {
    tone_map_tone_map_int(f * 1000000.0)
  } else {
    tone_map_tone_map_int(-f * 1000000.0)
  }
  i.to_string() + "." + fi.to_string()
}

///|
fn tone_map_tone_map_int(x : Double) -> Int32 {
  let mut n = 0
  let mut d = x
  while d >= 1.0 {
    n = n + 1
    d = d - 1.0
  }
  n
}

///|
fn tone_map_tone_map_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n {
    result[i] = arr[i]
  }
  result[n] = v
  result
}

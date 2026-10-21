///|
///===
/// opcore/image_stitch
/// S13.48 new
pub struct Image_stitchPoint {
  x : Double
  y : Double
  label : Int32
}

///|
pub fn image_stitch_make_point(x : Double, y : Double) -> Image_stitchPoint {
  { x, y, label: 0, }
}

///|
pub fn image_stitch_make_labeled_point(
  x : Double,
  y : Double,
  label : Int32,
) -> Image_stitchPoint {
  { x, y, label, }
}

///|
pub fn image_stitch_point_x(p : Image_stitchPoint) -> Double {
  p.x
}

///|
pub fn image_stitch_point_y(p : Image_stitchPoint) -> Double {
  p.y
}

///|
pub fn image_stitch_point_label(p : Image_stitchPoint) -> Int32 {
  p.label
}

///|
pub fn image_stitch_point_dist(
  a : Image_stitchPoint,
  b : Image_stitchPoint,
) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  @_common.sqrt(dx * dx + dy * dy)
}

///|
pub fn image_stitch_point_add(
  a : Image_stitchPoint,
  b : Image_stitchPoint,
) -> Image_stitchPoint {
  { x: a.x + b.x, y: a.y + b.y, label: a.label, }
}

///|
pub fn image_stitch_point_sub(
  a : Image_stitchPoint,
  b : Image_stitchPoint,
) -> Image_stitchPoint {
  { x: a.x - b.x, y: a.y - b.y, label: a.label, }
}

///|
pub fn image_stitch_point_scale(
  pt : Image_stitchPoint,
  s : Double,
) -> Image_stitchPoint {
  { x: pt.x * s, y: pt.y * s, label: pt.label, }
}

///|
pub fn image_stitch_point_dot(
  a : Image_stitchPoint,
  b : Image_stitchPoint,
) -> Double {
  a.x * b.x + a.y * b.y
}

///|
pub fn image_stitch_point_norm(pt : Image_stitchPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y)
}

///|
pub fn image_stitch_point_to_string(pt : Image_stitchPoint) -> String {
  "(" +
  image_stitch_dbl(pt.x) +
  ", " +
  image_stitch_dbl(pt.y) +
  ")[" +
  pt.label.to_string() +
  "]"
}

///|
pub struct Image_stitchSeries {
  vals : Array[Double]
  name : String
}

///|
pub fn image_stitch_make_series(
  vals : Array[Double],
  name : String,
) -> Image_stitchSeries {
  { vals, name, }
}

///|
pub fn image_stitch_series_len(s : Image_stitchSeries) -> Int32 {
  s.vals.length()
}

///|
pub fn image_stitch_series_sum(s : Image_stitchSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() {
    total = total + s.vals[i]
  }
  total
}

///|
pub fn image_stitch_series_mean(s : Image_stitchSeries) -> Double {
  let n = image_stitch_series_len(s)
  if n == 0 {
    0.0
  } else {
    image_stitch_series_sum(s) / n.to_double()
  }
}

///|
pub fn image_stitch_series_min(s : Image_stitchSeries) -> Double {
  let n = image_stitch_series_len(s)
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
pub fn image_stitch_series_max(s : Image_stitchSeries) -> Double {
  let n = image_stitch_series_len(s)
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
pub fn image_stitch_series_var(s : Image_stitchSeries) -> Double {
  let n = image_stitch_series_len(s)
  if n == 0 {
    0.0
  } else {
    let m = image_stitch_series_mean(s)
    let mut total = 0.0
    for i in 0..<n {
      let d = s.vals[i] - m
      total = total + d * d
    }
    total / n.to_double()
  }
}

///|
pub fn image_stitch_series_std(s : Image_stitchSeries) -> Double {
  @_common.sqrt(image_stitch_series_var(s))
}

///|
pub fn image_stitch_series_scale(
  s : Image_stitchSeries,
  f : Double,
) -> Image_stitchSeries {
  let mut result = []
  for i in 0..<s.vals.length() {
    result = image_stitch_push(result, s.vals[i] * f)
  }
  { vals: result, name: s.name, }
}

///|
pub fn image_stitch_series_add(
  a : Image_stitchSeries,
  b : Image_stitchSeries,
) -> Image_stitchSeries {
  let n = if a.vals.length() < b.vals.length() {
    a.vals.length()
  } else {
    b.vals.length()
  }
  let mut result = []
  for i in 0..<n {
    result = image_stitch_push(result, a.vals[i] + b.vals[i])
  }
  { vals: result, name: a.name + "+" + b.name, }
}

///|
pub fn image_stitch_series_to_string(s : Image_stitchSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim {
    if i > 0 {
      result = result + ", "
    }
    result = result + image_stitch_dbl(s.vals[i])
  }
  if n > 10 {
    result + "...]"
  } else {
    result + "]"
  }
}

///|
pub struct Image_stitchMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn image_stitch_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> Image_stitchMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows {
    data[i] = Array::make(cols, val)
  }
  { data, rows, cols, }
}

///|
pub fn image_stitch_matrix_identity(n : Int32) -> Image_stitchMatrix {
  let m = image_stitch_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn image_stitch_matrix_get(
  m : Image_stitchMatrix,
  i : Int32,
  j : Int32,
) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols {
    0.0
  } else {
    m.data[i][j]
  }
}

///|
pub fn image_stitch_matrix_transpose(
  m : Image_stitchMatrix,
) -> Image_stitchMatrix {
  let result = image_stitch_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows {
    for j in 0..<m.cols {
      result.data[j][i] = m.data[i][j]
    }
  }
  result
}

///|
pub fn image_stitch_matrix_add(
  a : Image_stitchMatrix,
  b : Image_stitchMatrix,
) -> Image_stitchMatrix {
  if a.rows != b.rows || a.cols != b.cols {
    return a
  }
  let result = image_stitch_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<a.cols {
      result.data[i][j] = a.data[i][j] + b.data[i][j]
    }
  }
  result
}

///|
pub fn image_stitch_matrix_scale(
  m : Image_stitchMatrix,
  s : Double,
) -> Image_stitchMatrix {
  let result = image_stitch_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows {
    for j in 0..<m.cols {
      result.data[i][j] = m.data[i][j] * s
    }
  }
  result
}

///|
pub fn image_stitch_matrix_multiply(
  a : Image_stitchMatrix,
  b : Image_stitchMatrix,
) -> Image_stitchMatrix {
  if a.cols != b.rows {
    return image_stitch_make_matrix(a.rows, b.cols, 0.0)
  }
  let result = image_stitch_make_matrix(a.rows, b.cols, 0.0)
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
pub fn image_stitch_matrix_trace(m : Image_stitchMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + m.data[i][i]
  }
  sum
}

///|
pub fn image_stitch_matrix_norm(m : Image_stitchMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows {
    for j in 0..<m.cols {
      sum = sum + m.data[i][j] * m.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn image_stitch_matrix_to_string(m : Image_stitchMatrix) -> String {
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
      result = result + image_stitch_dbl(m.data[i][j])
    }
    result = result + "]\n"
  }
  result
}

///|
pub struct Image_stitchVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn image_stitch_make_vector(comps : Array[Double]) -> Image_stitchVector {
  { comps, dim: comps.length(), }
}

///|
pub fn image_stitch_vector_zero(dim : Int32) -> Image_stitchVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn image_stitch_vector_add(
  a : Image_stitchVector,
  b : Image_stitchVector,
) -> Image_stitchVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n {
    result = image_stitch_push(result, a.comps[i] + b.comps[i])
  }
  { comps: result, dim: n, }
}

///|
pub fn image_stitch_vector_sub(
  a : Image_stitchVector,
  b : Image_stitchVector,
) -> Image_stitchVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n {
    result = image_stitch_push(result, a.comps[i] - b.comps[i])
  }
  { comps: result, dim: n, }
}

///|
pub fn image_stitch_vector_scale(
  v : Image_stitchVector,
  s : Double,
) -> Image_stitchVector {
  let mut result = []
  for i in 0..<v.dim {
    result = image_stitch_push(result, v.comps[i] * s)
  }
  { comps: result, dim: v.dim, }
}

///|
pub fn image_stitch_vector_dot(
  a : Image_stitchVector,
  b : Image_stitchVector,
) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + a.comps[i] * b.comps[i]
  }
  sum
}

///|
pub fn image_stitch_vector_norm(v : Image_stitchVector) -> Double {
  @_common.sqrt(image_stitch_vector_dot(v, v))
}

///|
pub fn image_stitch_vector_normalize(
  v : Image_stitchVector,
) -> Image_stitchVector {
  let n = image_stitch_vector_norm(v)
  if n < 0.0000001 {
    v
  } else {
    image_stitch_vector_scale(v, 1.0 / n)
  }
}

///|
pub fn image_stitch_vector_dist(
  a : Image_stitchVector,
  b : Image_stitchVector,
) -> Double {
  image_stitch_vector_norm(image_stitch_vector_sub(a, b))
}

///|
pub fn image_stitch_vector_to_string(v : Image_stitchVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim {
    if i > 0 {
      result = result + ", "
    }
    result = result + image_stitch_dbl(v.comps[i])
  }
  if v.dim > 10 {
    result + "...]"
  } else {
    result + "]"
  }
}

///|
pub fn image_stitch_var(data : Array[Double]) -> Double {
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
pub fn image_stitch_std(data : Array[Double]) -> Double {
  @_common.sqrt(image_stitch_var(data))
}

///|
pub fn image_stitch_cov(a : Array[Double], b : Array[Double]) -> Double {
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
pub fn image_stitch_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = image_stitch_std(a)
  let sb = image_stitch_std(b)
  if sa < 0.0000001 || sb < 0.0000001 {
    0.0
  } else {
    image_stitch_cov(a, b) / (sa * sb)
  }
}

///|
pub fn image_stitch_accuracy(
  pred : Array[Int32],
  labels : Array[Int32],
) -> Double {
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
pub fn image_stitch_mse(pred : Array[Double], labels : Array[Double]) -> Double {
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
pub fn image_stitch_mae(pred : Array[Double], labels : Array[Double]) -> Double {
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
pub fn image_stitch_r2(pred : Array[Double], labels : Array[Double]) -> Double {
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
pub fn image_stitch_precision(
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
pub fn image_stitch_recall(
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
pub fn image_stitch_f1(
  pred : Array[Int32],
  labels : Array[Int32],
  pos : Int32,
) -> Double {
  let p_ = image_stitch_precision(pred, labels, pos)
  let r = image_stitch_recall(pred, labels, pos)
  if p_ + r < 0.0000001 {
    0.0
  } else {
    2.0 * p_ * r / (p_ + r)
  }
}

///|
fn image_stitch_dbl(x : Double) -> String {
  let i = if x >= 0.0 { image_stitch_int(x) } else { -image_stitch_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 {
    image_stitch_int(f * 1000000.0)
  } else {
    image_stitch_int(-f * 1000000.0)
  }
  i.to_string() + "." + fi.to_string()
}

///|
fn image_stitch_int(x : Double) -> Int32 {
  let mut n = 0
  let mut d = x
  while d >= 1.0 {
    n = n + 1
    d = d - 1.0
  }
  n
}

///|
fn image_stitch_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n {
    result[i] = arr[i]
  }
  result[n] = v
  result
}

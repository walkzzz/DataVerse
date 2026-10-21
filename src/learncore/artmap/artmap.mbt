///|
///===
/// learncore/artmap
/// S13.103 new
pub struct ArtmapPoint {
  x : Double
  y : Double
  label : Int32
}

///|
pub fn artmap_make_point(x : Double, y : Double) -> ArtmapPoint {
  { x, y, label: 0, }
}

///|
pub fn artmap_make_labeled_point(
  x : Double,
  y : Double,
  label : Int32,
) -> ArtmapPoint {
  { x, y, label, }
}

///|
pub fn artmap_point_x(p : ArtmapPoint) -> Double {
  p.x
}

///|
pub fn artmap_point_y(p : ArtmapPoint) -> Double {
  p.y
}

///|
pub fn artmap_point_label(p : ArtmapPoint) -> Int32 {
  p.label
}

///|
pub fn artmap_point_dist(a : ArtmapPoint, b : ArtmapPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  @_common.sqrt(dx * dx + dy * dy)
}

///|
pub fn artmap_point_add(a : ArtmapPoint, b : ArtmapPoint) -> ArtmapPoint {
  { x: a.x + b.x, y: a.y + b.y, label: a.label, }
}

///|
pub fn artmap_point_sub(a : ArtmapPoint, b : ArtmapPoint) -> ArtmapPoint {
  { x: a.x - b.x, y: a.y - b.y, label: a.label, }
}

///|
pub fn artmap_point_scale(pt : ArtmapPoint, s : Double) -> ArtmapPoint {
  { x: pt.x * s, y: pt.y * s, label: pt.label, }
}

///|
pub fn artmap_point_dot(a : ArtmapPoint, b : ArtmapPoint) -> Double {
  a.x * b.x + a.y * b.y
}

///|
pub fn artmap_point_norm(pt : ArtmapPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y)
}

///|
pub fn artmap_point_to_string(pt : ArtmapPoint) -> String {
  "(" +
  artmap_dbl(pt.x) +
  ", " +
  artmap_dbl(pt.y) +
  ")[" +
  pt.label.to_string() +
  "]"
}

///|
pub struct ArtmapSeries {
  vals : Array[Double]
  name : String
}

///|
pub fn artmap_make_series(vals : Array[Double], name : String) -> ArtmapSeries {
  { vals, name, }
}

///|
pub fn artmap_series_len(s : ArtmapSeries) -> Int32 {
  s.vals.length()
}

///|
pub fn artmap_series_sum(s : ArtmapSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() {
    total = total + s.vals[i]
  }
  total
}

///|
pub fn artmap_series_mean(s : ArtmapSeries) -> Double {
  let n = artmap_series_len(s)
  if n == 0 {
    0.0
  } else {
    artmap_series_sum(s) / n.to_double()
  }
}

///|
pub fn artmap_series_min(s : ArtmapSeries) -> Double {
  let n = artmap_series_len(s)
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
pub fn artmap_series_max(s : ArtmapSeries) -> Double {
  let n = artmap_series_len(s)
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
pub fn artmap_series_var(s : ArtmapSeries) -> Double {
  let n = artmap_series_len(s)
  if n == 0 {
    0.0
  } else {
    let m = artmap_series_mean(s)
    let mut total = 0.0
    for i in 0..<n {
      let d = s.vals[i] - m
      total = total + d * d
    }
    total / n.to_double()
  }
}

///|
pub fn artmap_series_std(s : ArtmapSeries) -> Double {
  @_common.sqrt(artmap_series_var(s))
}

///|
pub fn artmap_series_scale(s : ArtmapSeries, f : Double) -> ArtmapSeries {
  let mut result = []
  for i in 0..<s.vals.length() {
    result = artmap_push(result, s.vals[i] * f)
  }
  { vals: result, name: s.name, }
}

///|
pub fn artmap_series_add(a : ArtmapSeries, b : ArtmapSeries) -> ArtmapSeries {
  let n = if a.vals.length() < b.vals.length() {
    a.vals.length()
  } else {
    b.vals.length()
  }
  let mut result = []
  for i in 0..<n {
    result = artmap_push(result, a.vals[i] + b.vals[i])
  }
  { vals: result, name: a.name + "+" + b.name, }
}

///|
pub fn artmap_series_to_string(s : ArtmapSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim {
    if i > 0 {
      result = result + ", "
    }
    result = result + artmap_dbl(s.vals[i])
  }
  if n > 10 {
    result + "...]"
  } else {
    result + "]"
  }
}

///|
pub struct ArtmapMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn artmap_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> ArtmapMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows {
    data[i] = Array::make(cols, val)
  }
  { data, rows, cols, }
}

///|
pub fn artmap_matrix_identity(n : Int32) -> ArtmapMatrix {
  let m = artmap_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn artmap_matrix_get(m : ArtmapMatrix, i : Int32, j : Int32) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols {
    0.0
  } else {
    m.data[i][j]
  }
}

///|
pub fn artmap_matrix_transpose(m : ArtmapMatrix) -> ArtmapMatrix {
  let result = artmap_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows {
    for j in 0..<m.cols {
      result.data[j][i] = m.data[i][j]
    }
  }
  result
}

///|
pub fn artmap_matrix_add(a : ArtmapMatrix, b : ArtmapMatrix) -> ArtmapMatrix {
  if a.rows != b.rows || a.cols != b.cols {
    return a
  }
  let result = artmap_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<a.cols {
      result.data[i][j] = a.data[i][j] + b.data[i][j]
    }
  }
  result
}

///|
pub fn artmap_matrix_scale(m : ArtmapMatrix, s : Double) -> ArtmapMatrix {
  let result = artmap_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows {
    for j in 0..<m.cols {
      result.data[i][j] = m.data[i][j] * s
    }
  }
  result
}

///|
pub fn artmap_matrix_multiply(
  a : ArtmapMatrix,
  b : ArtmapMatrix,
) -> ArtmapMatrix {
  if a.cols != b.rows {
    return artmap_make_matrix(a.rows, b.cols, 0.0)
  }
  let result = artmap_make_matrix(a.rows, b.cols, 0.0)
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
pub fn artmap_matrix_trace(m : ArtmapMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + m.data[i][i]
  }
  sum
}

///|
pub fn artmap_matrix_norm(m : ArtmapMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows {
    for j in 0..<m.cols {
      sum = sum + m.data[i][j] * m.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn artmap_matrix_to_string(m : ArtmapMatrix) -> String {
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
      result = result + artmap_dbl(m.data[i][j])
    }
    result = result + "]\n"
  }
  result
}

///|
pub struct ArtmapVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn artmap_make_vector(comps : Array[Double]) -> ArtmapVector {
  { comps, dim: comps.length(), }
}

///|
pub fn artmap_vector_zero(dim : Int32) -> ArtmapVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn artmap_vector_add(a : ArtmapVector, b : ArtmapVector) -> ArtmapVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n {
    result = artmap_push(result, a.comps[i] + b.comps[i])
  }
  { comps: result, dim: n, }
}

///|
pub fn artmap_vector_sub(a : ArtmapVector, b : ArtmapVector) -> ArtmapVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n {
    result = artmap_push(result, a.comps[i] - b.comps[i])
  }
  { comps: result, dim: n, }
}

///|
pub fn artmap_vector_scale(v : ArtmapVector, s : Double) -> ArtmapVector {
  let mut result = []
  for i in 0..<v.dim {
    result = artmap_push(result, v.comps[i] * s)
  }
  { comps: result, dim: v.dim, }
}

///|
pub fn artmap_vector_dot(a : ArtmapVector, b : ArtmapVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + a.comps[i] * b.comps[i]
  }
  sum
}

///|
pub fn artmap_vector_norm(v : ArtmapVector) -> Double {
  @_common.sqrt(artmap_vector_dot(v, v))
}

///|
pub fn artmap_vector_normalize(v : ArtmapVector) -> ArtmapVector {
  let n = artmap_vector_norm(v)
  if n < 0.0000001 {
    v
  } else {
    artmap_vector_scale(v, 1.0 / n)
  }
}

///|
pub fn artmap_vector_dist(a : ArtmapVector, b : ArtmapVector) -> Double {
  artmap_vector_norm(artmap_vector_sub(a, b))
}

///|
pub fn artmap_vector_to_string(v : ArtmapVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim {
    if i > 0 {
      result = result + ", "
    }
    result = result + artmap_dbl(v.comps[i])
  }
  if v.dim > 10 {
    result + "...]"
  } else {
    result + "]"
  }
}

///|
pub fn artmap_var(data : Array[Double]) -> Double {
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
pub fn artmap_std(data : Array[Double]) -> Double {
  @_common.sqrt(artmap_var(data))
}

///|
pub fn artmap_cov(a : Array[Double], b : Array[Double]) -> Double {
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
pub fn artmap_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = artmap_std(a)
  let sb = artmap_std(b)
  if sa < 0.0000001 || sb < 0.0000001 {
    0.0
  } else {
    artmap_cov(a, b) / (sa * sb)
  }
}

///|
pub fn artmap_accuracy(pred : Array[Int32], labels : Array[Int32]) -> Double {
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
pub fn artmap_mse(pred : Array[Double], labels : Array[Double]) -> Double {
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
pub fn artmap_mae(pred : Array[Double], labels : Array[Double]) -> Double {
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
pub fn artmap_r2(pred : Array[Double], labels : Array[Double]) -> Double {
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
pub fn artmap_precision(
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
pub fn artmap_recall(
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
pub fn artmap_f1(
  pred : Array[Int32],
  labels : Array[Int32],
  pos : Int32,
) -> Double {
  let p_ = artmap_precision(pred, labels, pos)
  let r = artmap_recall(pred, labels, pos)
  if p_ + r < 0.0000001 {
    0.0
  } else {
    2.0 * p_ * r / (p_ + r)
  }
}

///|
fn artmap_dbl(x : Double) -> String {
  let i = if x >= 0.0 { artmap_int(x) } else { -artmap_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 {
    artmap_int(f * 1000000.0)
  } else {
    artmap_int(-f * 1000000.0)
  }
  i.to_string() + "." + fi.to_string()
}

///|
fn artmap_int(x : Double) -> Int32 {
  let mut n = 0
  let mut d = x
  while d >= 1.0 {
    n = n + 1
    d = d - 1.0
  }
  n
}

///|
fn artmap_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n {
    result[i] = arr[i]
  }
  result[n] = v
  result
}

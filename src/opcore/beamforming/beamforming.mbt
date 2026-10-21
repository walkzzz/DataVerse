///===
/// opcore/beamforming
/// S13.40 new

pub struct BeamformingPoint {
  x : Double
  y : Double
  label : Int
}

pub fn beamforming_make_point(x : Double, y : Double) -> BeamformingPoint {
  { x, y, label: 0 }
}

pub fn beamforming_make_labeled_point(x : Double, y : Double, label : Int) -> BeamformingPoint {
  { x, y, label }
}

pub fn beamforming_point_x(p : BeamformingPoint) -> Double { p.x }

pub fn beamforming_point_y(p : BeamformingPoint) -> Double { p.y }

pub fn beamforming_point_label(p : BeamformingPoint) -> Int { p.label }

pub fn beamforming_point_dist(a : BeamformingPoint, b : BeamformingPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  @_common.sqrt(dx * dx + dy * dy)
}

pub fn beamforming_point_add(a : BeamformingPoint, b : BeamformingPoint) -> BeamformingPoint {
  { x: a.x + b.x, y: a.y + b.y, label: a.label }
}

pub fn beamforming_point_sub(a : BeamformingPoint, b : BeamformingPoint) -> BeamformingPoint {
  { x: a.x - b.x, y: a.y - b.y, label: a.label }
}

pub fn beamforming_point_scale(pt : BeamformingPoint, s : Double) -> BeamformingPoint {
  { x: pt.x * s, y: pt.y * s, label: pt.label }
}

pub fn beamforming_point_dot(a : BeamformingPoint, b : BeamformingPoint) -> Double {
  a.x * b.x + a.y * b.y
}

pub fn beamforming_point_norm(pt : BeamformingPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y)
}

pub fn beamforming_point_to_string(pt : BeamformingPoint) -> String {
  "(" + beamforming_dbl(pt.x) + ", " + beamforming_dbl(pt.y) + ")[" + pt.label.to_string() + "]"
}

pub struct BeamformingSeries {
  vals : Array[Double]
  name : String
}

pub fn beamforming_make_series(vals : Array[Double], name : String) -> BeamformingSeries {
  { vals, name }
}

pub fn beamforming_series_len(s : BeamformingSeries) -> Int { s.vals.length() }

pub fn beamforming_series_sum(s : BeamformingSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn beamforming_series_mean(s : BeamformingSeries) -> Double {
  let n = beamforming_series_len(s)
  if n == 0 { 0.0 } else { beamforming_series_sum(s) / n.to_double() }
}

pub fn beamforming_series_min(s : BeamformingSeries) -> Double {
  let n = beamforming_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn beamforming_series_max(s : BeamformingSeries) -> Double {
  let n = beamforming_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn beamforming_series_var(s : BeamformingSeries) -> Double {
  let n = beamforming_series_len(s)
  if n == 0 { 0.0 } else {
    let m = beamforming_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn beamforming_series_std(s : BeamformingSeries) -> Double { @_common.sqrt(beamforming_series_var(s)) }

pub fn beamforming_series_scale(s : BeamformingSeries, f : Double) -> BeamformingSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = beamforming_push(result, s.vals[i] * f) }
  { vals: result, name: s.name }
}

pub fn beamforming_series_add(a : BeamformingSeries, b : BeamformingSeries) -> BeamformingSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = beamforming_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name }
}

pub fn beamforming_series_to_string(s : BeamformingSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + beamforming_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub struct BeamformingMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn beamforming_make_matrix(rows : Int, cols : Int, val : Double) -> BeamformingMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn beamforming_matrix_identity(n : Int) -> BeamformingMatrix {
  let m = beamforming_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn beamforming_matrix_get(m : BeamformingMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn beamforming_matrix_transpose(m : BeamformingMatrix) -> BeamformingMatrix {
  let result = beamforming_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn beamforming_matrix_add(a : BeamformingMatrix, b : BeamformingMatrix) -> BeamformingMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = beamforming_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn beamforming_matrix_scale(m : BeamformingMatrix, s : Double) -> BeamformingMatrix {
  let result = beamforming_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn beamforming_matrix_multiply(a : BeamformingMatrix, b : BeamformingMatrix) -> BeamformingMatrix {
  if a.cols != b.rows { return beamforming_make_matrix(a.rows, b.cols, 0.0) }
  let result = beamforming_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn beamforming_matrix_trace(m : BeamformingMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn beamforming_matrix_norm(m : BeamformingMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn beamforming_matrix_to_string(m : BeamformingMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + beamforming_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub struct BeamformingVector {
  comps : Array[Double]
  dim : Int
}

pub fn beamforming_make_vector(comps : Array[Double]) -> BeamformingVector {
  { comps, dim: comps.length() }
}

pub fn beamforming_vector_zero(dim : Int) -> BeamformingVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn beamforming_vector_add(a : BeamformingVector, b : BeamformingVector) -> BeamformingVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = beamforming_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn beamforming_vector_sub(a : BeamformingVector, b : BeamformingVector) -> BeamformingVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = beamforming_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn beamforming_vector_scale(v : BeamformingVector, s : Double) -> BeamformingVector {
  let mut result = []
  for i in 0..<v.dim { result = beamforming_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn beamforming_vector_dot(a : BeamformingVector, b : BeamformingVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn beamforming_vector_norm(v : BeamformingVector) -> Double { @_common.sqrt(beamforming_vector_dot(v, v)) }

pub fn beamforming_vector_normalize(v : BeamformingVector) -> BeamformingVector {
  let n = beamforming_vector_norm(v)
  if n < 0.0000001 { v } else { beamforming_vector_scale(v, 1.0 / n) }
}

pub fn beamforming_vector_dist(a : BeamformingVector, b : BeamformingVector) -> Double {
  beamforming_vector_norm(beamforming_vector_sub(a, b))
}

pub fn beamforming_vector_to_string(v : BeamformingVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + beamforming_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn beamforming_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = @_common.mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn beamforming_std(data : Array[Double]) -> Double { @_common.sqrt(beamforming_var(data)) }

pub fn beamforming_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = @_common.mean(a); let mb = @_common.mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn beamforming_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = beamforming_std(a); let sb = beamforming_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { beamforming_cov(a, b) / (sa * sb) }
}

pub fn beamforming_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn beamforming_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn beamforming_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn beamforming_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = @_common.mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn beamforming_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn beamforming_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn beamforming_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = beamforming_precision(pred, labels, pos); let r = beamforming_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

fn beamforming_dbl(x : Double) -> String {
  let i = if x >= 0.0 { beamforming_int(x) } else { -beamforming_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { beamforming_int(f * 1000000.0) } else { beamforming_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn beamforming_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn beamforming_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

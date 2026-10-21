///===
/// agent_kit/auto_drive
/// S13.145 new

pub struct Auto_drivePoint {
  x : Double
  y : Double
  label : Int
}

pub fn auto_drive_make_point(x : Double, y : Double) -> Auto_drivePoint {
  { x, y, label: 0 }
}

pub fn auto_drive_make_labeled_point(x : Double, y : Double, label : Int) -> Auto_drivePoint {
  { x, y, label }
}

pub fn auto_drive_point_x(p : Auto_drivePoint) -> Double { p.x }

pub fn auto_drive_point_y(p : Auto_drivePoint) -> Double { p.y }

pub fn auto_drive_point_label(p : Auto_drivePoint) -> Int { p.label }

pub fn auto_drive_point_dist(a : Auto_drivePoint, b : Auto_drivePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  @_common.sqrt(dx * dx + dy * dy)
}

pub fn auto_drive_point_add(a : Auto_drivePoint, b : Auto_drivePoint) -> Auto_drivePoint {
  { x: a.x + b.x, y: a.y + b.y, label: a.label }
}

pub fn auto_drive_point_sub(a : Auto_drivePoint, b : Auto_drivePoint) -> Auto_drivePoint {
  { x: a.x - b.x, y: a.y - b.y, label: a.label }
}

pub fn auto_drive_point_scale(pt : Auto_drivePoint, s : Double) -> Auto_drivePoint {
  { x: pt.x * s, y: pt.y * s, label: pt.label }
}

pub fn auto_drive_point_dot(a : Auto_drivePoint, b : Auto_drivePoint) -> Double {
  a.x * b.x + a.y * b.y
}

pub fn auto_drive_point_norm(pt : Auto_drivePoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y)
}

pub fn auto_drive_point_to_string(pt : Auto_drivePoint) -> String {
  "(" + auto_drive_dbl(pt.x) + ", " + auto_drive_dbl(pt.y) + ")[" + pt.label.to_string() + "]"
}

pub struct Auto_driveSeries {
  vals : Array[Double]
  name : String
}

pub fn auto_drive_make_series(vals : Array[Double], name : String) -> Auto_driveSeries {
  { vals, name }
}

pub fn auto_drive_series_len(s : Auto_driveSeries) -> Int { s.vals.length() }

pub fn auto_drive_series_sum(s : Auto_driveSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn auto_drive_series_mean(s : Auto_driveSeries) -> Double {
  let n = auto_drive_series_len(s)
  if n == 0 { 0.0 } else { auto_drive_series_sum(s) / n.to_double() }
}

pub fn auto_drive_series_min(s : Auto_driveSeries) -> Double {
  let n = auto_drive_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn auto_drive_series_max(s : Auto_driveSeries) -> Double {
  let n = auto_drive_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn auto_drive_series_var(s : Auto_driveSeries) -> Double {
  let n = auto_drive_series_len(s)
  if n == 0 { 0.0 } else {
    let m = auto_drive_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn auto_drive_series_std(s : Auto_driveSeries) -> Double { @_common.sqrt(auto_drive_series_var(s)) }

pub fn auto_drive_series_scale(s : Auto_driveSeries, f : Double) -> Auto_driveSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = auto_drive_push(result, s.vals[i] * f) }
  { vals: result, name: s.name }
}

pub fn auto_drive_series_add(a : Auto_driveSeries, b : Auto_driveSeries) -> Auto_driveSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = auto_drive_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name }
}

pub fn auto_drive_series_to_string(s : Auto_driveSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + auto_drive_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub struct Auto_driveMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn auto_drive_make_matrix(rows : Int, cols : Int, val : Double) -> Auto_driveMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn auto_drive_matrix_identity(n : Int) -> Auto_driveMatrix {
  let m = auto_drive_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn auto_drive_matrix_get(m : Auto_driveMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn auto_drive_matrix_transpose(m : Auto_driveMatrix) -> Auto_driveMatrix {
  let result = auto_drive_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn auto_drive_matrix_add(a : Auto_driveMatrix, b : Auto_driveMatrix) -> Auto_driveMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = auto_drive_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn auto_drive_matrix_scale(m : Auto_driveMatrix, s : Double) -> Auto_driveMatrix {
  let result = auto_drive_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn auto_drive_matrix_multiply(a : Auto_driveMatrix, b : Auto_driveMatrix) -> Auto_driveMatrix {
  if a.cols != b.rows { return auto_drive_make_matrix(a.rows, b.cols, 0.0) }
  let result = auto_drive_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn auto_drive_matrix_trace(m : Auto_driveMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn auto_drive_matrix_norm(m : Auto_driveMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn auto_drive_matrix_to_string(m : Auto_driveMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + auto_drive_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub struct Auto_driveVector {
  comps : Array[Double]
  dim : Int
}

pub fn auto_drive_make_vector(comps : Array[Double]) -> Auto_driveVector {
  { comps, dim: comps.length() }
}

pub fn auto_drive_vector_zero(dim : Int) -> Auto_driveVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn auto_drive_vector_add(a : Auto_driveVector, b : Auto_driveVector) -> Auto_driveVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = auto_drive_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn auto_drive_vector_sub(a : Auto_driveVector, b : Auto_driveVector) -> Auto_driveVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = auto_drive_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn auto_drive_vector_scale(v : Auto_driveVector, s : Double) -> Auto_driveVector {
  let mut result = []
  for i in 0..<v.dim { result = auto_drive_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn auto_drive_vector_dot(a : Auto_driveVector, b : Auto_driveVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn auto_drive_vector_norm(v : Auto_driveVector) -> Double { @_common.sqrt(auto_drive_vector_dot(v, v)) }

pub fn auto_drive_vector_normalize(v : Auto_driveVector) -> Auto_driveVector {
  let n = auto_drive_vector_norm(v)
  if n < 0.0000001 { v } else { auto_drive_vector_scale(v, 1.0 / n) }
}

pub fn auto_drive_vector_dist(a : Auto_driveVector, b : Auto_driveVector) -> Double {
  auto_drive_vector_norm(auto_drive_vector_sub(a, b))
}

pub fn auto_drive_vector_to_string(v : Auto_driveVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + auto_drive_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn auto_drive_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = @_common.mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn auto_drive_std(data : Array[Double]) -> Double { @_common.sqrt(auto_drive_var(data)) }

pub fn auto_drive_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = @_common.mean(a); let mb = @_common.mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn auto_drive_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = auto_drive_std(a); let sb = auto_drive_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { auto_drive_cov(a, b) / (sa * sb) }
}

pub fn auto_drive_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn auto_drive_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn auto_drive_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn auto_drive_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = @_common.mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn auto_drive_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn auto_drive_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn auto_drive_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = auto_drive_precision(pred, labels, pos); let r = auto_drive_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

fn auto_drive_dbl(x : Double) -> String {
  let i = if x >= 0.0 { auto_drive_int(x) } else { -auto_drive_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { auto_drive_int(f * 1000000.0) } else { auto_drive_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn auto_drive_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn auto_drive_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

///===
/// agent_kit/path_follow
/// S13.146 new

pub struct Path_followPoint {
  x : Double
  y : Double
  label : Int
}

pub fn path_follow_make_point(x : Double, y : Double) -> Path_followPoint {
  { x, y, label: 0 }
}

pub fn path_follow_make_labeled_point(x : Double, y : Double, label : Int) -> Path_followPoint {
  { x, y, label }
}

pub fn path_follow_point_x(p : Path_followPoint) -> Double { p.x }

pub fn path_follow_point_y(p : Path_followPoint) -> Double { p.y }

pub fn path_follow_point_label(p : Path_followPoint) -> Int { p.label }

pub fn path_follow_point_dist(a : Path_followPoint, b : Path_followPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  @_common.sqrt(dx * dx + dy * dy)
}

pub fn path_follow_point_add(a : Path_followPoint, b : Path_followPoint) -> Path_followPoint {
  { x: a.x + b.x, y: a.y + b.y, label: a.label }
}

pub fn path_follow_point_sub(a : Path_followPoint, b : Path_followPoint) -> Path_followPoint {
  { x: a.x - b.x, y: a.y - b.y, label: a.label }
}

pub fn path_follow_point_scale(pt : Path_followPoint, s : Double) -> Path_followPoint {
  { x: pt.x * s, y: pt.y * s, label: pt.label }
}

pub fn path_follow_point_dot(a : Path_followPoint, b : Path_followPoint) -> Double {
  a.x * b.x + a.y * b.y
}

pub fn path_follow_point_norm(pt : Path_followPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y)
}

pub fn path_follow_point_to_string(pt : Path_followPoint) -> String {
  "(" + path_follow_dbl(pt.x) + ", " + path_follow_dbl(pt.y) + ")[" + pt.label.to_string() + "]"
}

pub struct Path_followSeries {
  vals : Array[Double]
  name : String
}

pub fn path_follow_make_series(vals : Array[Double], name : String) -> Path_followSeries {
  { vals, name }
}

pub fn path_follow_series_len(s : Path_followSeries) -> Int { s.vals.length() }

pub fn path_follow_series_sum(s : Path_followSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn path_follow_series_mean(s : Path_followSeries) -> Double {
  let n = path_follow_series_len(s)
  if n == 0 { 0.0 } else { path_follow_series_sum(s) / n.to_double() }
}

pub fn path_follow_series_min(s : Path_followSeries) -> Double {
  let n = path_follow_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn path_follow_series_max(s : Path_followSeries) -> Double {
  let n = path_follow_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn path_follow_series_var(s : Path_followSeries) -> Double {
  let n = path_follow_series_len(s)
  if n == 0 { 0.0 } else {
    let m = path_follow_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn path_follow_series_std(s : Path_followSeries) -> Double { @_common.sqrt(path_follow_series_var(s)) }

pub fn path_follow_series_scale(s : Path_followSeries, f : Double) -> Path_followSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = path_follow_push(result, s.vals[i] * f) }
  { vals: result, name: s.name }
}

pub fn path_follow_series_add(a : Path_followSeries, b : Path_followSeries) -> Path_followSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = path_follow_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name }
}

pub fn path_follow_series_to_string(s : Path_followSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + path_follow_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub struct Path_followMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn path_follow_make_matrix(rows : Int, cols : Int, val : Double) -> Path_followMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn path_follow_matrix_identity(n : Int) -> Path_followMatrix {
  let m = path_follow_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn path_follow_matrix_get(m : Path_followMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn path_follow_matrix_transpose(m : Path_followMatrix) -> Path_followMatrix {
  let result = path_follow_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn path_follow_matrix_add(a : Path_followMatrix, b : Path_followMatrix) -> Path_followMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = path_follow_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn path_follow_matrix_scale(m : Path_followMatrix, s : Double) -> Path_followMatrix {
  let result = path_follow_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn path_follow_matrix_multiply(a : Path_followMatrix, b : Path_followMatrix) -> Path_followMatrix {
  if a.cols != b.rows { return path_follow_make_matrix(a.rows, b.cols, 0.0) }
  let result = path_follow_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn path_follow_matrix_trace(m : Path_followMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn path_follow_matrix_norm(m : Path_followMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn path_follow_matrix_to_string(m : Path_followMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + path_follow_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub struct Path_followVector {
  comps : Array[Double]
  dim : Int
}

pub fn path_follow_make_vector(comps : Array[Double]) -> Path_followVector {
  { comps, dim: comps.length() }
}

pub fn path_follow_vector_zero(dim : Int) -> Path_followVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn path_follow_vector_add(a : Path_followVector, b : Path_followVector) -> Path_followVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = path_follow_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn path_follow_vector_sub(a : Path_followVector, b : Path_followVector) -> Path_followVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = path_follow_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn path_follow_vector_scale(v : Path_followVector, s : Double) -> Path_followVector {
  let mut result = []
  for i in 0..<v.dim { result = path_follow_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn path_follow_vector_dot(a : Path_followVector, b : Path_followVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn path_follow_vector_norm(v : Path_followVector) -> Double { @_common.sqrt(path_follow_vector_dot(v, v)) }

pub fn path_follow_vector_normalize(v : Path_followVector) -> Path_followVector {
  let n = path_follow_vector_norm(v)
  if n < 0.0000001 { v } else { path_follow_vector_scale(v, 1.0 / n) }
}

pub fn path_follow_vector_dist(a : Path_followVector, b : Path_followVector) -> Double {
  path_follow_vector_norm(path_follow_vector_sub(a, b))
}

pub fn path_follow_vector_to_string(v : Path_followVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + path_follow_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn path_follow_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = @_common.mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn path_follow_std(data : Array[Double]) -> Double { @_common.sqrt(path_follow_var(data)) }

pub fn path_follow_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = @_common.mean(a); let mb = @_common.mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn path_follow_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = path_follow_std(a); let sb = path_follow_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { path_follow_cov(a, b) / (sa * sb) }
}

pub fn path_follow_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn path_follow_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn path_follow_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn path_follow_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = @_common.mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn path_follow_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn path_follow_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn path_follow_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = path_follow_precision(pred, labels, pos); let r = path_follow_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

fn path_follow_dbl(x : Double) -> String {
  let i = if x >= 0.0 { path_follow_int(x) } else { -path_follow_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { path_follow_int(f * 1000000.0) } else { path_follow_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn path_follow_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn path_follow_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

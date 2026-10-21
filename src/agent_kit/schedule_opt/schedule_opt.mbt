///===
/// agent_kit/schedule_opt
/// S13.154 new

pub struct Schedule_optPoint {
  x : Double
  y : Double
  label : Int
}

pub fn schedule_opt_make_point(x : Double, y : Double) -> Schedule_optPoint {
  { x, y, label: 0 }
}

pub fn schedule_opt_make_labeled_point(x : Double, y : Double, label : Int) -> Schedule_optPoint {
  { x, y, label }
}

pub fn schedule_opt_point_x(p : Schedule_optPoint) -> Double { p.x }

pub fn schedule_opt_point_y(p : Schedule_optPoint) -> Double { p.y }

pub fn schedule_opt_point_label(p : Schedule_optPoint) -> Int { p.label }

pub fn schedule_opt_point_dist(a : Schedule_optPoint, b : Schedule_optPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  @_common.sqrt(dx * dx + dy * dy)
}

pub fn schedule_opt_point_add(a : Schedule_optPoint, b : Schedule_optPoint) -> Schedule_optPoint {
  { x: a.x + b.x, y: a.y + b.y, label: a.label }
}

pub fn schedule_opt_point_sub(a : Schedule_optPoint, b : Schedule_optPoint) -> Schedule_optPoint {
  { x: a.x - b.x, y: a.y - b.y, label: a.label }
}

pub fn schedule_opt_point_scale(pt : Schedule_optPoint, s : Double) -> Schedule_optPoint {
  { x: pt.x * s, y: pt.y * s, label: pt.label }
}

pub fn schedule_opt_point_dot(a : Schedule_optPoint, b : Schedule_optPoint) -> Double {
  a.x * b.x + a.y * b.y
}

pub fn schedule_opt_point_norm(pt : Schedule_optPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y)
}

pub fn schedule_opt_point_to_string(pt : Schedule_optPoint) -> String {
  "(" + schedule_opt_dbl(pt.x) + ", " + schedule_opt_dbl(pt.y) + ")[" + pt.label.to_string() + "]"
}

pub struct Schedule_optSeries {
  vals : Array[Double]
  name : String
}

pub fn schedule_opt_make_series(vals : Array[Double], name : String) -> Schedule_optSeries {
  { vals, name }
}

pub fn schedule_opt_series_len(s : Schedule_optSeries) -> Int { s.vals.length() }

pub fn schedule_opt_series_sum(s : Schedule_optSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn schedule_opt_series_mean(s : Schedule_optSeries) -> Double {
  let n = schedule_opt_series_len(s)
  if n == 0 { 0.0 } else { schedule_opt_series_sum(s) / n.to_double() }
}

pub fn schedule_opt_series_min(s : Schedule_optSeries) -> Double {
  let n = schedule_opt_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn schedule_opt_series_max(s : Schedule_optSeries) -> Double {
  let n = schedule_opt_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn schedule_opt_series_var(s : Schedule_optSeries) -> Double {
  let n = schedule_opt_series_len(s)
  if n == 0 { 0.0 } else {
    let m = schedule_opt_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn schedule_opt_series_std(s : Schedule_optSeries) -> Double { @_common.sqrt(schedule_opt_series_var(s)) }

pub fn schedule_opt_series_scale(s : Schedule_optSeries, f : Double) -> Schedule_optSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = schedule_opt_push(result, s.vals[i] * f) }
  { vals: result, name: s.name }
}

pub fn schedule_opt_series_add(a : Schedule_optSeries, b : Schedule_optSeries) -> Schedule_optSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = schedule_opt_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name }
}

pub fn schedule_opt_series_to_string(s : Schedule_optSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + schedule_opt_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub struct Schedule_optMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn schedule_opt_make_matrix(rows : Int, cols : Int, val : Double) -> Schedule_optMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn schedule_opt_matrix_identity(n : Int) -> Schedule_optMatrix {
  let m = schedule_opt_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn schedule_opt_matrix_get(m : Schedule_optMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn schedule_opt_matrix_transpose(m : Schedule_optMatrix) -> Schedule_optMatrix {
  let result = schedule_opt_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn schedule_opt_matrix_add(a : Schedule_optMatrix, b : Schedule_optMatrix) -> Schedule_optMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = schedule_opt_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn schedule_opt_matrix_scale(m : Schedule_optMatrix, s : Double) -> Schedule_optMatrix {
  let result = schedule_opt_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn schedule_opt_matrix_multiply(a : Schedule_optMatrix, b : Schedule_optMatrix) -> Schedule_optMatrix {
  if a.cols != b.rows { return schedule_opt_make_matrix(a.rows, b.cols, 0.0) }
  let result = schedule_opt_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn schedule_opt_matrix_trace(m : Schedule_optMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn schedule_opt_matrix_norm(m : Schedule_optMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn schedule_opt_matrix_to_string(m : Schedule_optMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + schedule_opt_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub struct Schedule_optVector {
  comps : Array[Double]
  dim : Int
}

pub fn schedule_opt_make_vector(comps : Array[Double]) -> Schedule_optVector {
  { comps, dim: comps.length() }
}

pub fn schedule_opt_vector_zero(dim : Int) -> Schedule_optVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn schedule_opt_vector_add(a : Schedule_optVector, b : Schedule_optVector) -> Schedule_optVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = schedule_opt_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn schedule_opt_vector_sub(a : Schedule_optVector, b : Schedule_optVector) -> Schedule_optVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = schedule_opt_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn schedule_opt_vector_scale(v : Schedule_optVector, s : Double) -> Schedule_optVector {
  let mut result = []
  for i in 0..<v.dim { result = schedule_opt_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn schedule_opt_vector_dot(a : Schedule_optVector, b : Schedule_optVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn schedule_opt_vector_norm(v : Schedule_optVector) -> Double { @_common.sqrt(schedule_opt_vector_dot(v, v)) }

pub fn schedule_opt_vector_normalize(v : Schedule_optVector) -> Schedule_optVector {
  let n = schedule_opt_vector_norm(v)
  if n < 0.0000001 { v } else { schedule_opt_vector_scale(v, 1.0 / n) }
}

pub fn schedule_opt_vector_dist(a : Schedule_optVector, b : Schedule_optVector) -> Double {
  schedule_opt_vector_norm(schedule_opt_vector_sub(a, b))
}

pub fn schedule_opt_vector_to_string(v : Schedule_optVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + schedule_opt_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn schedule_opt_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn schedule_opt_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = schedule_opt_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn schedule_opt_std(data : Array[Double]) -> Double { @_common.sqrt(schedule_opt_var(data)) }

pub fn schedule_opt_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = schedule_opt_mean(a); let mb = schedule_opt_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn schedule_opt_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = schedule_opt_std(a); let sb = schedule_opt_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { schedule_opt_cov(a, b) / (sa * sb) }
}

pub fn schedule_opt_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn schedule_opt_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn schedule_opt_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn schedule_opt_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = schedule_opt_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn schedule_opt_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn schedule_opt_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn schedule_opt_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = schedule_opt_precision(pred, labels, pos); let r = schedule_opt_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

fn schedule_opt_dbl(x : Double) -> String {
  let i = if x >= 0.0 { schedule_opt_int(x) } else { -schedule_opt_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { schedule_opt_int(f * 1000000.0) } else { schedule_opt_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn schedule_opt_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn schedule_opt_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

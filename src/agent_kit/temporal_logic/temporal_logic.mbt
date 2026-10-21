///===
/// agent_kit/temporal_logic
/// S13.158 new

pub struct Temporal_logicPoint {
  x : Double
  y : Double
  label : Int
}

pub fn temporal_logic_make_point(x : Double, y : Double) -> Temporal_logicPoint {
  { x, y, label: 0 }
}

pub fn temporal_logic_make_labeled_point(x : Double, y : Double, label : Int) -> Temporal_logicPoint {
  { x, y, label }
}

pub fn temporal_logic_point_x(p : Temporal_logicPoint) -> Double { p.x }

pub fn temporal_logic_point_y(p : Temporal_logicPoint) -> Double { p.y }

pub fn temporal_logic_point_label(p : Temporal_logicPoint) -> Int { p.label }

pub fn temporal_logic_point_dist(a : Temporal_logicPoint, b : Temporal_logicPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  @_common.sqrt(dx * dx + dy * dy)
}

pub fn temporal_logic_point_add(a : Temporal_logicPoint, b : Temporal_logicPoint) -> Temporal_logicPoint {
  { x: a.x + b.x, y: a.y + b.y, label: a.label }
}

pub fn temporal_logic_point_sub(a : Temporal_logicPoint, b : Temporal_logicPoint) -> Temporal_logicPoint {
  { x: a.x - b.x, y: a.y - b.y, label: a.label }
}

pub fn temporal_logic_point_scale(pt : Temporal_logicPoint, s : Double) -> Temporal_logicPoint {
  { x: pt.x * s, y: pt.y * s, label: pt.label }
}

pub fn temporal_logic_point_dot(a : Temporal_logicPoint, b : Temporal_logicPoint) -> Double {
  a.x * b.x + a.y * b.y
}

pub fn temporal_logic_point_norm(pt : Temporal_logicPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y)
}

pub fn temporal_logic_point_to_string(pt : Temporal_logicPoint) -> String {
  "(" + temporal_logic_dbl(pt.x) + ", " + temporal_logic_dbl(pt.y) + ")[" + pt.label.to_string() + "]"
}

pub struct Temporal_logicSeries {
  vals : Array[Double]
  name : String
}

pub fn temporal_logic_make_series(vals : Array[Double], name : String) -> Temporal_logicSeries {
  { vals, name }
}

pub fn temporal_logic_series_len(s : Temporal_logicSeries) -> Int { s.vals.length() }

pub fn temporal_logic_series_sum(s : Temporal_logicSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn temporal_logic_series_mean(s : Temporal_logicSeries) -> Double {
  let n = temporal_logic_series_len(s)
  if n == 0 { 0.0 } else { temporal_logic_series_sum(s) / n.to_double() }
}

pub fn temporal_logic_series_min(s : Temporal_logicSeries) -> Double {
  let n = temporal_logic_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn temporal_logic_series_max(s : Temporal_logicSeries) -> Double {
  let n = temporal_logic_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn temporal_logic_series_var(s : Temporal_logicSeries) -> Double {
  let n = temporal_logic_series_len(s)
  if n == 0 { 0.0 } else {
    let m = temporal_logic_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn temporal_logic_series_std(s : Temporal_logicSeries) -> Double { @_common.sqrt(temporal_logic_series_var(s)) }

pub fn temporal_logic_series_scale(s : Temporal_logicSeries, f : Double) -> Temporal_logicSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = temporal_logic_push(result, s.vals[i] * f) }
  { vals: result, name: s.name }
}

pub fn temporal_logic_series_add(a : Temporal_logicSeries, b : Temporal_logicSeries) -> Temporal_logicSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = temporal_logic_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name }
}

pub fn temporal_logic_series_to_string(s : Temporal_logicSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + temporal_logic_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub struct Temporal_logicMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn temporal_logic_make_matrix(rows : Int, cols : Int, val : Double) -> Temporal_logicMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn temporal_logic_matrix_identity(n : Int) -> Temporal_logicMatrix {
  let m = temporal_logic_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn temporal_logic_matrix_get(m : Temporal_logicMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn temporal_logic_matrix_transpose(m : Temporal_logicMatrix) -> Temporal_logicMatrix {
  let result = temporal_logic_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn temporal_logic_matrix_add(a : Temporal_logicMatrix, b : Temporal_logicMatrix) -> Temporal_logicMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = temporal_logic_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn temporal_logic_matrix_scale(m : Temporal_logicMatrix, s : Double) -> Temporal_logicMatrix {
  let result = temporal_logic_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn temporal_logic_matrix_multiply(a : Temporal_logicMatrix, b : Temporal_logicMatrix) -> Temporal_logicMatrix {
  if a.cols != b.rows { return temporal_logic_make_matrix(a.rows, b.cols, 0.0) }
  let result = temporal_logic_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn temporal_logic_matrix_trace(m : Temporal_logicMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn temporal_logic_matrix_norm(m : Temporal_logicMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn temporal_logic_matrix_to_string(m : Temporal_logicMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + temporal_logic_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub struct Temporal_logicVector {
  comps : Array[Double]
  dim : Int
}

pub fn temporal_logic_make_vector(comps : Array[Double]) -> Temporal_logicVector {
  { comps, dim: comps.length() }
}

pub fn temporal_logic_vector_zero(dim : Int) -> Temporal_logicVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn temporal_logic_vector_add(a : Temporal_logicVector, b : Temporal_logicVector) -> Temporal_logicVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = temporal_logic_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn temporal_logic_vector_sub(a : Temporal_logicVector, b : Temporal_logicVector) -> Temporal_logicVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = temporal_logic_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn temporal_logic_vector_scale(v : Temporal_logicVector, s : Double) -> Temporal_logicVector {
  let mut result = []
  for i in 0..<v.dim { result = temporal_logic_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn temporal_logic_vector_dot(a : Temporal_logicVector, b : Temporal_logicVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn temporal_logic_vector_norm(v : Temporal_logicVector) -> Double { @_common.sqrt(temporal_logic_vector_dot(v, v)) }

pub fn temporal_logic_vector_normalize(v : Temporal_logicVector) -> Temporal_logicVector {
  let n = temporal_logic_vector_norm(v)
  if n < 0.0000001 { v } else { temporal_logic_vector_scale(v, 1.0 / n) }
}

pub fn temporal_logic_vector_dist(a : Temporal_logicVector, b : Temporal_logicVector) -> Double {
  temporal_logic_vector_norm(temporal_logic_vector_sub(a, b))
}

pub fn temporal_logic_vector_to_string(v : Temporal_logicVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + temporal_logic_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn temporal_logic_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn temporal_logic_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = temporal_logic_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn temporal_logic_std(data : Array[Double]) -> Double { @_common.sqrt(temporal_logic_var(data)) }

pub fn temporal_logic_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = temporal_logic_mean(a); let mb = temporal_logic_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn temporal_logic_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = temporal_logic_std(a); let sb = temporal_logic_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { temporal_logic_cov(a, b) / (sa * sb) }
}

pub fn temporal_logic_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn temporal_logic_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn temporal_logic_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn temporal_logic_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = temporal_logic_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn temporal_logic_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn temporal_logic_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn temporal_logic_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = temporal_logic_precision(pred, labels, pos); let r = temporal_logic_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

fn temporal_logic_dbl(x : Double) -> String {
  let i = if x >= 0.0 { temporal_logic_int(x) } else { -temporal_logic_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { temporal_logic_int(f * 1000000.0) } else { temporal_logic_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn temporal_logic_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn temporal_logic_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

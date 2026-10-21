///===
/// opcore/filter_fir
/// S13.14 new

pub struct Filter_firPoint {
  x : Double
  y : Double
  label : Int
}

pub fn filter_fir_make_point(x : Double, y : Double) -> Filter_firPoint {
  { x, y, label: 0 }
}

pub fn filter_fir_make_labeled_point(x : Double, y : Double, label : Int) -> Filter_firPoint {
  { x, y, label }
}

pub fn filter_fir_point_x(p : Filter_firPoint) -> Double { p.x }

pub fn filter_fir_point_y(p : Filter_firPoint) -> Double { p.y }

pub fn filter_fir_point_label(p : Filter_firPoint) -> Int { p.label }

pub fn filter_fir_point_dist(a : Filter_firPoint, b : Filter_firPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  @_common.sqrt(dx * dx + dy * dy)
}

pub fn filter_fir_point_add(a : Filter_firPoint, b : Filter_firPoint) -> Filter_firPoint {
  { x: a.x + b.x, y: a.y + b.y, label: a.label }
}

pub fn filter_fir_point_sub(a : Filter_firPoint, b : Filter_firPoint) -> Filter_firPoint {
  { x: a.x - b.x, y: a.y - b.y, label: a.label }
}

pub fn filter_fir_point_scale(pt : Filter_firPoint, s : Double) -> Filter_firPoint {
  { x: pt.x * s, y: pt.y * s, label: pt.label }
}

pub fn filter_fir_point_dot(a : Filter_firPoint, b : Filter_firPoint) -> Double {
  a.x * b.x + a.y * b.y
}

pub fn filter_fir_point_norm(pt : Filter_firPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y)
}

pub fn filter_fir_point_to_string(pt : Filter_firPoint) -> String {
  "(" + filter_fir_dbl(pt.x) + ", " + filter_fir_dbl(pt.y) + ")[" + pt.label.to_string() + "]"
}

pub struct Filter_firSeries {
  vals : Array[Double]
  name : String
}

pub fn filter_fir_make_series(vals : Array[Double], name : String) -> Filter_firSeries {
  { vals, name }
}

pub fn filter_fir_series_len(s : Filter_firSeries) -> Int { s.vals.length() }

pub fn filter_fir_series_sum(s : Filter_firSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn filter_fir_series_mean(s : Filter_firSeries) -> Double {
  let n = filter_fir_series_len(s)
  if n == 0 { 0.0 } else { filter_fir_series_sum(s) / n.to_double() }
}

pub fn filter_fir_series_min(s : Filter_firSeries) -> Double {
  let n = filter_fir_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn filter_fir_series_max(s : Filter_firSeries) -> Double {
  let n = filter_fir_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn filter_fir_series_var(s : Filter_firSeries) -> Double {
  let n = filter_fir_series_len(s)
  if n == 0 { 0.0 } else {
    let m = filter_fir_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn filter_fir_series_std(s : Filter_firSeries) -> Double { @_common.sqrt(filter_fir_series_var(s)) }

pub fn filter_fir_series_scale(s : Filter_firSeries, f : Double) -> Filter_firSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = filter_fir_push(result, s.vals[i] * f) }
  { vals: result, name: s.name }
}

pub fn filter_fir_series_add(a : Filter_firSeries, b : Filter_firSeries) -> Filter_firSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = filter_fir_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name }
}

pub fn filter_fir_series_to_string(s : Filter_firSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + filter_fir_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub struct Filter_firMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn filter_fir_make_matrix(rows : Int, cols : Int, val : Double) -> Filter_firMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn filter_fir_matrix_identity(n : Int) -> Filter_firMatrix {
  let m = filter_fir_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn filter_fir_matrix_get(m : Filter_firMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn filter_fir_matrix_transpose(m : Filter_firMatrix) -> Filter_firMatrix {
  let result = filter_fir_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn filter_fir_matrix_add(a : Filter_firMatrix, b : Filter_firMatrix) -> Filter_firMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = filter_fir_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn filter_fir_matrix_scale(m : Filter_firMatrix, s : Double) -> Filter_firMatrix {
  let result = filter_fir_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn filter_fir_matrix_multiply(a : Filter_firMatrix, b : Filter_firMatrix) -> Filter_firMatrix {
  if a.cols != b.rows { return filter_fir_make_matrix(a.rows, b.cols, 0.0) }
  let result = filter_fir_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn filter_fir_matrix_trace(m : Filter_firMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn filter_fir_matrix_norm(m : Filter_firMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn filter_fir_matrix_to_string(m : Filter_firMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + filter_fir_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub struct Filter_firVector {
  comps : Array[Double]
  dim : Int
}

pub fn filter_fir_make_vector(comps : Array[Double]) -> Filter_firVector {
  { comps, dim: comps.length() }
}

pub fn filter_fir_vector_zero(dim : Int) -> Filter_firVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn filter_fir_vector_add(a : Filter_firVector, b : Filter_firVector) -> Filter_firVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = filter_fir_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn filter_fir_vector_sub(a : Filter_firVector, b : Filter_firVector) -> Filter_firVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = filter_fir_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn filter_fir_vector_scale(v : Filter_firVector, s : Double) -> Filter_firVector {
  let mut result = []
  for i in 0..<v.dim { result = filter_fir_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn filter_fir_vector_dot(a : Filter_firVector, b : Filter_firVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn filter_fir_vector_norm(v : Filter_firVector) -> Double { @_common.sqrt(filter_fir_vector_dot(v, v)) }

pub fn filter_fir_vector_normalize(v : Filter_firVector) -> Filter_firVector {
  let n = filter_fir_vector_norm(v)
  if n < 0.0000001 { v } else { filter_fir_vector_scale(v, 1.0 / n) }
}

pub fn filter_fir_vector_dist(a : Filter_firVector, b : Filter_firVector) -> Double {
  filter_fir_vector_norm(filter_fir_vector_sub(a, b))
}

pub fn filter_fir_vector_to_string(v : Filter_firVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + filter_fir_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn filter_fir_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = @_common.mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn filter_fir_std(data : Array[Double]) -> Double { @_common.sqrt(filter_fir_var(data)) }

pub fn filter_fir_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = @_common.mean(a); let mb = @_common.mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn filter_fir_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = filter_fir_std(a); let sb = filter_fir_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { filter_fir_cov(a, b) / (sa * sb) }
}

pub fn filter_fir_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn filter_fir_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn filter_fir_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn filter_fir_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = @_common.mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn filter_fir_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn filter_fir_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn filter_fir_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = filter_fir_precision(pred, labels, pos); let r = filter_fir_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

fn filter_fir_dbl(x : Double) -> String {
  let i = if x >= 0.0 { filter_fir_int(x) } else { -filter_fir_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { filter_fir_int(f * 1000000.0) } else { filter_fir_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn filter_fir_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn filter_fir_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

///===
/// opcore/fourier_analysis
/// S13.9 new

pub struct Fourier_analysisPoint {
  x : Double
  y : Double
  label : Int
}

pub fn fourier_analysis_make_point(x : Double, y : Double) -> Fourier_analysisPoint {
  { x, y, label: 0 }
}

pub fn fourier_analysis_make_labeled_point(x : Double, y : Double, label : Int) -> Fourier_analysisPoint {
  { x, y, label }
}

pub fn fourier_analysis_point_x(p : Fourier_analysisPoint) -> Double { p.x }

pub fn fourier_analysis_point_y(p : Fourier_analysisPoint) -> Double { p.y }

pub fn fourier_analysis_point_label(p : Fourier_analysisPoint) -> Int { p.label }

pub fn fourier_analysis_point_dist(a : Fourier_analysisPoint, b : Fourier_analysisPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  fourier_analysis_sqrt(dx * dx + dy * dy)
}

pub fn fourier_analysis_point_add(a : Fourier_analysisPoint, b : Fourier_analysisPoint) -> Fourier_analysisPoint {
  { x: a.x + b.x, y: a.y + b.y, label: a.label }
}

pub fn fourier_analysis_point_sub(a : Fourier_analysisPoint, b : Fourier_analysisPoint) -> Fourier_analysisPoint {
  { x: a.x - b.x, y: a.y - b.y, label: a.label }
}

pub fn fourier_analysis_point_scale(pt : Fourier_analysisPoint, s : Double) -> Fourier_analysisPoint {
  { x: pt.x * s, y: pt.y * s, label: pt.label }
}

pub fn fourier_analysis_point_dot(a : Fourier_analysisPoint, b : Fourier_analysisPoint) -> Double {
  a.x * b.x + a.y * b.y
}

pub fn fourier_analysis_point_norm(pt : Fourier_analysisPoint) -> Double {
  fourier_analysis_sqrt(pt.x * pt.x + pt.y * pt.y)
}

pub fn fourier_analysis_point_to_string(pt : Fourier_analysisPoint) -> String {
  "(" + fourier_analysis_dbl(pt.x) + ", " + fourier_analysis_dbl(pt.y) + ")[" + pt.label.to_string() + "]"
}

pub struct Fourier_analysisSeries {
  vals : Array[Double]
  name : String
}

pub fn fourier_analysis_make_series(vals : Array[Double], name : String) -> Fourier_analysisSeries {
  { vals, name }
}

pub fn fourier_analysis_series_len(s : Fourier_analysisSeries) -> Int { s.vals.length() }

pub fn fourier_analysis_series_sum(s : Fourier_analysisSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn fourier_analysis_series_mean(s : Fourier_analysisSeries) -> Double {
  let n = fourier_analysis_series_len(s)
  if n == 0 { 0.0 } else { fourier_analysis_series_sum(s) / n.to_double() }
}

pub fn fourier_analysis_series_min(s : Fourier_analysisSeries) -> Double {
  let n = fourier_analysis_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn fourier_analysis_series_max(s : Fourier_analysisSeries) -> Double {
  let n = fourier_analysis_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn fourier_analysis_series_var(s : Fourier_analysisSeries) -> Double {
  let n = fourier_analysis_series_len(s)
  if n == 0 { 0.0 } else {
    let m = fourier_analysis_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn fourier_analysis_series_std(s : Fourier_analysisSeries) -> Double { fourier_analysis_sqrt(fourier_analysis_series_var(s)) }

pub fn fourier_analysis_series_scale(s : Fourier_analysisSeries, f : Double) -> Fourier_analysisSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = fourier_analysis_push(result, s.vals[i] * f) }
  { vals: result, name: s.name }
}

pub fn fourier_analysis_series_add(a : Fourier_analysisSeries, b : Fourier_analysisSeries) -> Fourier_analysisSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = fourier_analysis_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name }
}

pub fn fourier_analysis_series_to_string(s : Fourier_analysisSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + fourier_analysis_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub struct Fourier_analysisMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn fourier_analysis_make_matrix(rows : Int, cols : Int, val : Double) -> Fourier_analysisMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn fourier_analysis_matrix_identity(n : Int) -> Fourier_analysisMatrix {
  let m = fourier_analysis_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn fourier_analysis_matrix_get(m : Fourier_analysisMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn fourier_analysis_matrix_transpose(m : Fourier_analysisMatrix) -> Fourier_analysisMatrix {
  let result = fourier_analysis_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn fourier_analysis_matrix_add(a : Fourier_analysisMatrix, b : Fourier_analysisMatrix) -> Fourier_analysisMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = fourier_analysis_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn fourier_analysis_matrix_scale(m : Fourier_analysisMatrix, s : Double) -> Fourier_analysisMatrix {
  let result = fourier_analysis_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn fourier_analysis_matrix_multiply(a : Fourier_analysisMatrix, b : Fourier_analysisMatrix) -> Fourier_analysisMatrix {
  if a.cols != b.rows { return fourier_analysis_make_matrix(a.rows, b.cols, 0.0) }
  let result = fourier_analysis_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn fourier_analysis_matrix_trace(m : Fourier_analysisMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn fourier_analysis_matrix_norm(m : Fourier_analysisMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  fourier_analysis_sqrt(sum)
}

pub fn fourier_analysis_matrix_to_string(m : Fourier_analysisMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + fourier_analysis_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub struct Fourier_analysisVector {
  comps : Array[Double]
  dim : Int
}

pub fn fourier_analysis_make_vector(comps : Array[Double]) -> Fourier_analysisVector {
  { comps, dim: comps.length() }
}

pub fn fourier_analysis_vector_zero(dim : Int) -> Fourier_analysisVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn fourier_analysis_vector_add(a : Fourier_analysisVector, b : Fourier_analysisVector) -> Fourier_analysisVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = fourier_analysis_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn fourier_analysis_vector_sub(a : Fourier_analysisVector, b : Fourier_analysisVector) -> Fourier_analysisVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = fourier_analysis_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn fourier_analysis_vector_scale(v : Fourier_analysisVector, s : Double) -> Fourier_analysisVector {
  let mut result = []
  for i in 0..<v.dim { result = fourier_analysis_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn fourier_analysis_vector_dot(a : Fourier_analysisVector, b : Fourier_analysisVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn fourier_analysis_vector_norm(v : Fourier_analysisVector) -> Double { fourier_analysis_sqrt(fourier_analysis_vector_dot(v, v)) }

pub fn fourier_analysis_vector_normalize(v : Fourier_analysisVector) -> Fourier_analysisVector {
  let n = fourier_analysis_vector_norm(v)
  if n < 0.0000001 { v } else { fourier_analysis_vector_scale(v, 1.0 / n) }
}

pub fn fourier_analysis_vector_dist(a : Fourier_analysisVector, b : Fourier_analysisVector) -> Double {
  fourier_analysis_vector_norm(fourier_analysis_vector_sub(a, b))
}

pub fn fourier_analysis_vector_to_string(v : Fourier_analysisVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + fourier_analysis_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn fourier_analysis_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn fourier_analysis_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = fourier_analysis_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn fourier_analysis_std(data : Array[Double]) -> Double { fourier_analysis_sqrt(fourier_analysis_var(data)) }

pub fn fourier_analysis_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = fourier_analysis_mean(a); let mb = fourier_analysis_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn fourier_analysis_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = fourier_analysis_std(a); let sb = fourier_analysis_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { fourier_analysis_cov(a, b) / (sa * sb) }
}

pub fn fourier_analysis_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn fourier_analysis_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn fourier_analysis_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + fourier_analysis_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn fourier_analysis_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = fourier_analysis_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn fourier_analysis_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn fourier_analysis_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn fourier_analysis_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = fourier_analysis_precision(pred, labels, pos); let r = fourier_analysis_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

fn fourier_analysis_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn fourier_analysis_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn fourier_analysis_dbl(x : Double) -> String {
  let i = if x >= 0.0 { fourier_analysis_int(x) } else { -fourier_analysis_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { fourier_analysis_int(f * 1000000.0) } else { fourier_analysis_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn fourier_analysis_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn fourier_analysis_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

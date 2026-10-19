///===
/// learncore/fuzzy_art
/// S13.104 new

pub struct Fuzzy_artPoint {
  x : Double
  y : Double
  label : Int
}

pub fn fuzzy_art_make_point(x : Double, y : Double) -> Fuzzy_artPoint {
  { x, y, label: 0 }
}

pub fn fuzzy_art_make_labeled_point(x : Double, y : Double, label : Int) -> Fuzzy_artPoint {
  { x, y, label }
}

pub fn fuzzy_art_point_x(p : Fuzzy_artPoint) -> Double { p.x }

pub fn fuzzy_art_point_y(p : Fuzzy_artPoint) -> Double { p.y }

pub fn fuzzy_art_point_label(p : Fuzzy_artPoint) -> Int { p.label }

pub fn fuzzy_art_point_dist(a : Fuzzy_artPoint, b : Fuzzy_artPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  fuzzy_art_sqrt(dx * dx + dy * dy)
}

pub fn fuzzy_art_point_add(a : Fuzzy_artPoint, b : Fuzzy_artPoint) -> Fuzzy_artPoint {
  { x: a.x + b.x, y: a.y + b.y, label: a.label }
}

pub fn fuzzy_art_point_sub(a : Fuzzy_artPoint, b : Fuzzy_artPoint) -> Fuzzy_artPoint {
  { x: a.x - b.x, y: a.y - b.y, label: a.label }
}

pub fn fuzzy_art_point_scale(pt : Fuzzy_artPoint, s : Double) -> Fuzzy_artPoint {
  { x: pt.x * s, y: pt.y * s, label: pt.label }
}

pub fn fuzzy_art_point_dot(a : Fuzzy_artPoint, b : Fuzzy_artPoint) -> Double {
  a.x * b.x + a.y * b.y
}

pub fn fuzzy_art_point_norm(pt : Fuzzy_artPoint) -> Double {
  fuzzy_art_sqrt(pt.x * pt.x + pt.y * pt.y)
}

pub fn fuzzy_art_point_to_string(pt : Fuzzy_artPoint) -> String {
  "(" + fuzzy_art_dbl(pt.x) + ", " + fuzzy_art_dbl(pt.y) + ")[" + pt.label.to_string() + "]"
}

pub struct Fuzzy_artSeries {
  vals : Array[Double]
  name : String
}

pub fn fuzzy_art_make_series(vals : Array[Double], name : String) -> Fuzzy_artSeries {
  { vals, name }
}

pub fn fuzzy_art_series_len(s : Fuzzy_artSeries) -> Int { s.vals.length() }

pub fn fuzzy_art_series_sum(s : Fuzzy_artSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn fuzzy_art_series_mean(s : Fuzzy_artSeries) -> Double {
  let n = fuzzy_art_series_len(s)
  if n == 0 { 0.0 } else { fuzzy_art_series_sum(s) / n.to_double() }
}

pub fn fuzzy_art_series_min(s : Fuzzy_artSeries) -> Double {
  let n = fuzzy_art_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn fuzzy_art_series_max(s : Fuzzy_artSeries) -> Double {
  let n = fuzzy_art_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn fuzzy_art_series_var(s : Fuzzy_artSeries) -> Double {
  let n = fuzzy_art_series_len(s)
  if n == 0 { 0.0 } else {
    let m = fuzzy_art_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn fuzzy_art_series_std(s : Fuzzy_artSeries) -> Double { fuzzy_art_sqrt(fuzzy_art_series_var(s)) }

pub fn fuzzy_art_series_scale(s : Fuzzy_artSeries, f : Double) -> Fuzzy_artSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = fuzzy_art_push(result, s.vals[i] * f) }
  { vals: result, name: s.name }
}

pub fn fuzzy_art_series_add(a : Fuzzy_artSeries, b : Fuzzy_artSeries) -> Fuzzy_artSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = fuzzy_art_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name }
}

pub fn fuzzy_art_series_to_string(s : Fuzzy_artSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + fuzzy_art_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub struct Fuzzy_artMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn fuzzy_art_make_matrix(rows : Int, cols : Int, val : Double) -> Fuzzy_artMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn fuzzy_art_matrix_identity(n : Int) -> Fuzzy_artMatrix {
  let m = fuzzy_art_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn fuzzy_art_matrix_get(m : Fuzzy_artMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn fuzzy_art_matrix_transpose(m : Fuzzy_artMatrix) -> Fuzzy_artMatrix {
  let result = fuzzy_art_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn fuzzy_art_matrix_add(a : Fuzzy_artMatrix, b : Fuzzy_artMatrix) -> Fuzzy_artMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = fuzzy_art_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn fuzzy_art_matrix_scale(m : Fuzzy_artMatrix, s : Double) -> Fuzzy_artMatrix {
  let result = fuzzy_art_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn fuzzy_art_matrix_multiply(a : Fuzzy_artMatrix, b : Fuzzy_artMatrix) -> Fuzzy_artMatrix {
  if a.cols != b.rows { return fuzzy_art_make_matrix(a.rows, b.cols, 0.0) }
  let result = fuzzy_art_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn fuzzy_art_matrix_trace(m : Fuzzy_artMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn fuzzy_art_matrix_norm(m : Fuzzy_artMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  fuzzy_art_sqrt(sum)
}

pub fn fuzzy_art_matrix_to_string(m : Fuzzy_artMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + fuzzy_art_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub struct Fuzzy_artVector {
  comps : Array[Double]
  dim : Int
}

pub fn fuzzy_art_make_vector(comps : Array[Double]) -> Fuzzy_artVector {
  { comps, dim: comps.length() }
}

pub fn fuzzy_art_vector_zero(dim : Int) -> Fuzzy_artVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn fuzzy_art_vector_add(a : Fuzzy_artVector, b : Fuzzy_artVector) -> Fuzzy_artVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = fuzzy_art_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn fuzzy_art_vector_sub(a : Fuzzy_artVector, b : Fuzzy_artVector) -> Fuzzy_artVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = fuzzy_art_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn fuzzy_art_vector_scale(v : Fuzzy_artVector, s : Double) -> Fuzzy_artVector {
  let mut result = []
  for i in 0..<v.dim { result = fuzzy_art_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn fuzzy_art_vector_dot(a : Fuzzy_artVector, b : Fuzzy_artVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn fuzzy_art_vector_norm(v : Fuzzy_artVector) -> Double { fuzzy_art_sqrt(fuzzy_art_vector_dot(v, v)) }

pub fn fuzzy_art_vector_normalize(v : Fuzzy_artVector) -> Fuzzy_artVector {
  let n = fuzzy_art_vector_norm(v)
  if n < 0.0000001 { v } else { fuzzy_art_vector_scale(v, 1.0 / n) }
}

pub fn fuzzy_art_vector_dist(a : Fuzzy_artVector, b : Fuzzy_artVector) -> Double {
  fuzzy_art_vector_norm(fuzzy_art_vector_sub(a, b))
}

pub fn fuzzy_art_vector_to_string(v : Fuzzy_artVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + fuzzy_art_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn fuzzy_art_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn fuzzy_art_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = fuzzy_art_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn fuzzy_art_std(data : Array[Double]) -> Double { fuzzy_art_sqrt(fuzzy_art_var(data)) }

pub fn fuzzy_art_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = fuzzy_art_mean(a); let mb = fuzzy_art_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn fuzzy_art_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = fuzzy_art_std(a); let sb = fuzzy_art_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { fuzzy_art_cov(a, b) / (sa * sb) }
}

pub fn fuzzy_art_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn fuzzy_art_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn fuzzy_art_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + fuzzy_art_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn fuzzy_art_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = fuzzy_art_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn fuzzy_art_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn fuzzy_art_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn fuzzy_art_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = fuzzy_art_precision(pred, labels, pos); let r = fuzzy_art_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

fn fuzzy_art_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn fuzzy_art_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn fuzzy_art_dbl(x : Double) -> String {
  let i = if x >= 0.0 { fuzzy_art_int(x) } else { -fuzzy_art_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { fuzzy_art_int(f * 1000000.0) } else { fuzzy_art_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn fuzzy_art_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn fuzzy_art_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

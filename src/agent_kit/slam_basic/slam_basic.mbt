///===
/// agent_kit/slam_basic
/// S13.148 new

pub struct Slam_basicPoint {
  x : Double
  y : Double
  label : Int
}

pub fn slam_basic_make_point(x : Double, y : Double) -> Slam_basicPoint {
  { x, y, label: 0 }
}

pub fn slam_basic_make_labeled_point(x : Double, y : Double, label : Int) -> Slam_basicPoint {
  { x, y, label }
}

pub fn slam_basic_point_x(p : Slam_basicPoint) -> Double { p.x }

pub fn slam_basic_point_y(p : Slam_basicPoint) -> Double { p.y }

pub fn slam_basic_point_label(p : Slam_basicPoint) -> Int { p.label }

pub fn slam_basic_point_dist(a : Slam_basicPoint, b : Slam_basicPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  slam_basic_sqrt(dx * dx + dy * dy)
}

pub fn slam_basic_point_add(a : Slam_basicPoint, b : Slam_basicPoint) -> Slam_basicPoint {
  { x: a.x + b.x, y: a.y + b.y, label: a.label }
}

pub fn slam_basic_point_sub(a : Slam_basicPoint, b : Slam_basicPoint) -> Slam_basicPoint {
  { x: a.x - b.x, y: a.y - b.y, label: a.label }
}

pub fn slam_basic_point_scale(pt : Slam_basicPoint, s : Double) -> Slam_basicPoint {
  { x: pt.x * s, y: pt.y * s, label: pt.label }
}

pub fn slam_basic_point_dot(a : Slam_basicPoint, b : Slam_basicPoint) -> Double {
  a.x * b.x + a.y * b.y
}

pub fn slam_basic_point_norm(pt : Slam_basicPoint) -> Double {
  slam_basic_sqrt(pt.x * pt.x + pt.y * pt.y)
}

pub fn slam_basic_point_to_string(pt : Slam_basicPoint) -> String {
  "(" + slam_basic_dbl(pt.x) + ", " + slam_basic_dbl(pt.y) + ")[" + pt.label.to_string() + "]"
}

pub struct Slam_basicSeries {
  vals : Array[Double]
  name : String
}

pub fn slam_basic_make_series(vals : Array[Double], name : String) -> Slam_basicSeries {
  { vals, name }
}

pub fn slam_basic_series_len(s : Slam_basicSeries) -> Int { s.vals.length() }

pub fn slam_basic_series_sum(s : Slam_basicSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn slam_basic_series_mean(s : Slam_basicSeries) -> Double {
  let n = slam_basic_series_len(s)
  if n == 0 { 0.0 } else { slam_basic_series_sum(s) / n.to_double() }
}

pub fn slam_basic_series_min(s : Slam_basicSeries) -> Double {
  let n = slam_basic_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn slam_basic_series_max(s : Slam_basicSeries) -> Double {
  let n = slam_basic_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn slam_basic_series_var(s : Slam_basicSeries) -> Double {
  let n = slam_basic_series_len(s)
  if n == 0 { 0.0 } else {
    let m = slam_basic_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn slam_basic_series_std(s : Slam_basicSeries) -> Double { slam_basic_sqrt(slam_basic_series_var(s)) }

pub fn slam_basic_series_scale(s : Slam_basicSeries, f : Double) -> Slam_basicSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = slam_basic_push(result, s.vals[i] * f) }
  { vals: result, name: s.name }
}

pub fn slam_basic_series_add(a : Slam_basicSeries, b : Slam_basicSeries) -> Slam_basicSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = slam_basic_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name }
}

pub fn slam_basic_series_to_string(s : Slam_basicSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + slam_basic_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub struct Slam_basicMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn slam_basic_make_matrix(rows : Int, cols : Int, val : Double) -> Slam_basicMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn slam_basic_matrix_identity(n : Int) -> Slam_basicMatrix {
  let m = slam_basic_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn slam_basic_matrix_get(m : Slam_basicMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn slam_basic_matrix_transpose(m : Slam_basicMatrix) -> Slam_basicMatrix {
  let result = slam_basic_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn slam_basic_matrix_add(a : Slam_basicMatrix, b : Slam_basicMatrix) -> Slam_basicMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = slam_basic_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn slam_basic_matrix_scale(m : Slam_basicMatrix, s : Double) -> Slam_basicMatrix {
  let result = slam_basic_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn slam_basic_matrix_multiply(a : Slam_basicMatrix, b : Slam_basicMatrix) -> Slam_basicMatrix {
  if a.cols != b.rows { return slam_basic_make_matrix(a.rows, b.cols, 0.0) }
  let result = slam_basic_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn slam_basic_matrix_trace(m : Slam_basicMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn slam_basic_matrix_norm(m : Slam_basicMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  slam_basic_sqrt(sum)
}

pub fn slam_basic_matrix_to_string(m : Slam_basicMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + slam_basic_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub struct Slam_basicVector {
  comps : Array[Double]
  dim : Int
}

pub fn slam_basic_make_vector(comps : Array[Double]) -> Slam_basicVector {
  { comps, dim: comps.length() }
}

pub fn slam_basic_vector_zero(dim : Int) -> Slam_basicVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn slam_basic_vector_add(a : Slam_basicVector, b : Slam_basicVector) -> Slam_basicVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = slam_basic_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn slam_basic_vector_sub(a : Slam_basicVector, b : Slam_basicVector) -> Slam_basicVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = slam_basic_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn slam_basic_vector_scale(v : Slam_basicVector, s : Double) -> Slam_basicVector {
  let mut result = []
  for i in 0..<v.dim { result = slam_basic_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn slam_basic_vector_dot(a : Slam_basicVector, b : Slam_basicVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn slam_basic_vector_norm(v : Slam_basicVector) -> Double { slam_basic_sqrt(slam_basic_vector_dot(v, v)) }

pub fn slam_basic_vector_normalize(v : Slam_basicVector) -> Slam_basicVector {
  let n = slam_basic_vector_norm(v)
  if n < 0.0000001 { v } else { slam_basic_vector_scale(v, 1.0 / n) }
}

pub fn slam_basic_vector_dist(a : Slam_basicVector, b : Slam_basicVector) -> Double {
  slam_basic_vector_norm(slam_basic_vector_sub(a, b))
}

pub fn slam_basic_vector_to_string(v : Slam_basicVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + slam_basic_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn slam_basic_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn slam_basic_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = slam_basic_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn slam_basic_std(data : Array[Double]) -> Double { slam_basic_sqrt(slam_basic_var(data)) }

pub fn slam_basic_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = slam_basic_mean(a); let mb = slam_basic_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn slam_basic_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = slam_basic_std(a); let sb = slam_basic_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { slam_basic_cov(a, b) / (sa * sb) }
}

pub fn slam_basic_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn slam_basic_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn slam_basic_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + slam_basic_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn slam_basic_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = slam_basic_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn slam_basic_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn slam_basic_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn slam_basic_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = slam_basic_precision(pred, labels, pos); let r = slam_basic_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

fn slam_basic_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn slam_basic_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn slam_basic_dbl(x : Double) -> String {
  let i = if x >= 0.0 { slam_basic_int(x) } else { -slam_basic_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { slam_basic_int(f * 1000000.0) } else { slam_basic_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn slam_basic_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn slam_basic_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

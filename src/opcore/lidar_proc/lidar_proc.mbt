///===
/// opcore/lidar_proc
/// S13.45 new

pub struct Lidar_procPoint {
  x : Double
  y : Double
  label : Int
}

pub fn lidar_proc_make_point(x : Double, y : Double) -> Lidar_procPoint {
  { x, y, label: 0 }
}

pub fn lidar_proc_make_labeled_point(x : Double, y : Double, label : Int) -> Lidar_procPoint {
  { x, y, label }
}

pub fn lidar_proc_point_x(p : Lidar_procPoint) -> Double { p.x }

pub fn lidar_proc_point_y(p : Lidar_procPoint) -> Double { p.y }

pub fn lidar_proc_point_label(p : Lidar_procPoint) -> Int { p.label }

pub fn lidar_proc_point_dist(a : Lidar_procPoint, b : Lidar_procPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  lidar_proc_sqrt(dx * dx + dy * dy)
}

pub fn lidar_proc_point_add(a : Lidar_procPoint, b : Lidar_procPoint) -> Lidar_procPoint {
  { x: a.x + b.x, y: a.y + b.y, label: a.label }
}

pub fn lidar_proc_point_sub(a : Lidar_procPoint, b : Lidar_procPoint) -> Lidar_procPoint {
  { x: a.x - b.x, y: a.y - b.y, label: a.label }
}

pub fn lidar_proc_point_scale(pt : Lidar_procPoint, s : Double) -> Lidar_procPoint {
  { x: pt.x * s, y: pt.y * s, label: pt.label }
}

pub fn lidar_proc_point_dot(a : Lidar_procPoint, b : Lidar_procPoint) -> Double {
  a.x * b.x + a.y * b.y
}

pub fn lidar_proc_point_norm(pt : Lidar_procPoint) -> Double {
  lidar_proc_sqrt(pt.x * pt.x + pt.y * pt.y)
}

pub fn lidar_proc_point_to_string(pt : Lidar_procPoint) -> String {
  "(" + lidar_proc_dbl(pt.x) + ", " + lidar_proc_dbl(pt.y) + ")[" + pt.label.to_string() + "]"
}

pub struct Lidar_procSeries {
  vals : Array[Double]
  name : String
}

pub fn lidar_proc_make_series(vals : Array[Double], name : String) -> Lidar_procSeries {
  { vals, name }
}

pub fn lidar_proc_series_len(s : Lidar_procSeries) -> Int { s.vals.length() }

pub fn lidar_proc_series_sum(s : Lidar_procSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn lidar_proc_series_mean(s : Lidar_procSeries) -> Double {
  let n = lidar_proc_series_len(s)
  if n == 0 { 0.0 } else { lidar_proc_series_sum(s) / n.to_double() }
}

pub fn lidar_proc_series_min(s : Lidar_procSeries) -> Double {
  let n = lidar_proc_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn lidar_proc_series_max(s : Lidar_procSeries) -> Double {
  let n = lidar_proc_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn lidar_proc_series_var(s : Lidar_procSeries) -> Double {
  let n = lidar_proc_series_len(s)
  if n == 0 { 0.0 } else {
    let m = lidar_proc_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn lidar_proc_series_std(s : Lidar_procSeries) -> Double { lidar_proc_sqrt(lidar_proc_series_var(s)) }

pub fn lidar_proc_series_scale(s : Lidar_procSeries, f : Double) -> Lidar_procSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = lidar_proc_push(result, s.vals[i] * f) }
  { vals: result, name: s.name }
}

pub fn lidar_proc_series_add(a : Lidar_procSeries, b : Lidar_procSeries) -> Lidar_procSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = lidar_proc_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name }
}

pub fn lidar_proc_series_to_string(s : Lidar_procSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + lidar_proc_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub struct Lidar_procMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn lidar_proc_make_matrix(rows : Int, cols : Int, val : Double) -> Lidar_procMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn lidar_proc_matrix_identity(n : Int) -> Lidar_procMatrix {
  let m = lidar_proc_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn lidar_proc_matrix_get(m : Lidar_procMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn lidar_proc_matrix_transpose(m : Lidar_procMatrix) -> Lidar_procMatrix {
  let result = lidar_proc_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn lidar_proc_matrix_add(a : Lidar_procMatrix, b : Lidar_procMatrix) -> Lidar_procMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = lidar_proc_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn lidar_proc_matrix_scale(m : Lidar_procMatrix, s : Double) -> Lidar_procMatrix {
  let result = lidar_proc_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn lidar_proc_matrix_multiply(a : Lidar_procMatrix, b : Lidar_procMatrix) -> Lidar_procMatrix {
  if a.cols != b.rows { return lidar_proc_make_matrix(a.rows, b.cols, 0.0) }
  let result = lidar_proc_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn lidar_proc_matrix_trace(m : Lidar_procMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn lidar_proc_matrix_norm(m : Lidar_procMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  lidar_proc_sqrt(sum)
}

pub fn lidar_proc_matrix_to_string(m : Lidar_procMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + lidar_proc_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub struct Lidar_procVector {
  comps : Array[Double]
  dim : Int
}

pub fn lidar_proc_make_vector(comps : Array[Double]) -> Lidar_procVector {
  { comps, dim: comps.length() }
}

pub fn lidar_proc_vector_zero(dim : Int) -> Lidar_procVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn lidar_proc_vector_add(a : Lidar_procVector, b : Lidar_procVector) -> Lidar_procVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = lidar_proc_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn lidar_proc_vector_sub(a : Lidar_procVector, b : Lidar_procVector) -> Lidar_procVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = lidar_proc_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn lidar_proc_vector_scale(v : Lidar_procVector, s : Double) -> Lidar_procVector {
  let mut result = []
  for i in 0..<v.dim { result = lidar_proc_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn lidar_proc_vector_dot(a : Lidar_procVector, b : Lidar_procVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn lidar_proc_vector_norm(v : Lidar_procVector) -> Double { lidar_proc_sqrt(lidar_proc_vector_dot(v, v)) }

pub fn lidar_proc_vector_normalize(v : Lidar_procVector) -> Lidar_procVector {
  let n = lidar_proc_vector_norm(v)
  if n < 0.0000001 { v } else { lidar_proc_vector_scale(v, 1.0 / n) }
}

pub fn lidar_proc_vector_dist(a : Lidar_procVector, b : Lidar_procVector) -> Double {
  lidar_proc_vector_norm(lidar_proc_vector_sub(a, b))
}

pub fn lidar_proc_vector_to_string(v : Lidar_procVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + lidar_proc_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn lidar_proc_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn lidar_proc_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = lidar_proc_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn lidar_proc_std(data : Array[Double]) -> Double { lidar_proc_sqrt(lidar_proc_var(data)) }

pub fn lidar_proc_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = lidar_proc_mean(a); let mb = lidar_proc_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn lidar_proc_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = lidar_proc_std(a); let sb = lidar_proc_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { lidar_proc_cov(a, b) / (sa * sb) }
}

pub fn lidar_proc_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn lidar_proc_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn lidar_proc_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + lidar_proc_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn lidar_proc_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = lidar_proc_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn lidar_proc_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn lidar_proc_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn lidar_proc_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = lidar_proc_precision(pred, labels, pos); let r = lidar_proc_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

fn lidar_proc_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn lidar_proc_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn lidar_proc_dbl(x : Double) -> String {
  let i = if x >= 0.0 { lidar_proc_int(x) } else { -lidar_proc_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { lidar_proc_int(f * 1000000.0) } else { lidar_proc_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn lidar_proc_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn lidar_proc_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

///===
/// datatemporal/checkpoint_sync
/// S13.220 new

pub struct Checkpoint_syncPoint {
  x : Double
  y : Double
  label : Int
}

pub fn checkpoint_sync_make_point(x : Double, y : Double) -> Checkpoint_syncPoint {
  { x, y, label: 0 }
}

pub fn checkpoint_sync_make_labeled_point(x : Double, y : Double, label : Int) -> Checkpoint_syncPoint {
  { x, y, label }
}

pub fn checkpoint_sync_point_x(p : Checkpoint_syncPoint) -> Double { p.x }

pub fn checkpoint_sync_point_y(p : Checkpoint_syncPoint) -> Double { p.y }

pub fn checkpoint_sync_point_label(p : Checkpoint_syncPoint) -> Int { p.label }

pub fn checkpoint_sync_point_dist(a : Checkpoint_syncPoint, b : Checkpoint_syncPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  checkpoint_sync_sqrt(dx * dx + dy * dy)
}

pub fn checkpoint_sync_point_add(a : Checkpoint_syncPoint, b : Checkpoint_syncPoint) -> Checkpoint_syncPoint {
  { x: a.x + b.x, y: a.y + b.y, label: a.label }
}

pub fn checkpoint_sync_point_sub(a : Checkpoint_syncPoint, b : Checkpoint_syncPoint) -> Checkpoint_syncPoint {
  { x: a.x - b.x, y: a.y - b.y, label: a.label }
}

pub fn checkpoint_sync_point_scale(pt : Checkpoint_syncPoint, s : Double) -> Checkpoint_syncPoint {
  { x: pt.x * s, y: pt.y * s, label: pt.label }
}

pub fn checkpoint_sync_point_dot(a : Checkpoint_syncPoint, b : Checkpoint_syncPoint) -> Double {
  a.x * b.x + a.y * b.y
}

pub fn checkpoint_sync_point_norm(pt : Checkpoint_syncPoint) -> Double {
  checkpoint_sync_sqrt(pt.x * pt.x + pt.y * pt.y)
}

pub fn checkpoint_sync_point_to_string(pt : Checkpoint_syncPoint) -> String {
  "(" + checkpoint_sync_dbl(pt.x) + ", " + checkpoint_sync_dbl(pt.y) + ")[" + pt.label.to_string() + "]"
}

pub struct Checkpoint_syncSeries {
  vals : Array[Double]
  name : String
}

pub fn checkpoint_sync_make_series(vals : Array[Double], name : String) -> Checkpoint_syncSeries {
  { vals, name }
}

pub fn checkpoint_sync_series_len(s : Checkpoint_syncSeries) -> Int { s.vals.length() }

pub fn checkpoint_sync_series_sum(s : Checkpoint_syncSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn checkpoint_sync_series_mean(s : Checkpoint_syncSeries) -> Double {
  let n = checkpoint_sync_series_len(s)
  if n == 0 { 0.0 } else { checkpoint_sync_series_sum(s) / n.to_double() }
}

pub fn checkpoint_sync_series_min(s : Checkpoint_syncSeries) -> Double {
  let n = checkpoint_sync_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn checkpoint_sync_series_max(s : Checkpoint_syncSeries) -> Double {
  let n = checkpoint_sync_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn checkpoint_sync_series_var(s : Checkpoint_syncSeries) -> Double {
  let n = checkpoint_sync_series_len(s)
  if n == 0 { 0.0 } else {
    let m = checkpoint_sync_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn checkpoint_sync_series_std(s : Checkpoint_syncSeries) -> Double { checkpoint_sync_sqrt(checkpoint_sync_series_var(s)) }

pub fn checkpoint_sync_series_scale(s : Checkpoint_syncSeries, f : Double) -> Checkpoint_syncSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = checkpoint_sync_push(result, s.vals[i] * f) }
  { vals: result, name: s.name }
}

pub fn checkpoint_sync_series_add(a : Checkpoint_syncSeries, b : Checkpoint_syncSeries) -> Checkpoint_syncSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = checkpoint_sync_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name }
}

pub fn checkpoint_sync_series_to_string(s : Checkpoint_syncSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + checkpoint_sync_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub struct Checkpoint_syncMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn checkpoint_sync_make_matrix(rows : Int, cols : Int, val : Double) -> Checkpoint_syncMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn checkpoint_sync_matrix_identity(n : Int) -> Checkpoint_syncMatrix {
  let m = checkpoint_sync_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn checkpoint_sync_matrix_get(m : Checkpoint_syncMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn checkpoint_sync_matrix_transpose(m : Checkpoint_syncMatrix) -> Checkpoint_syncMatrix {
  let result = checkpoint_sync_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn checkpoint_sync_matrix_add(a : Checkpoint_syncMatrix, b : Checkpoint_syncMatrix) -> Checkpoint_syncMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = checkpoint_sync_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn checkpoint_sync_matrix_scale(m : Checkpoint_syncMatrix, s : Double) -> Checkpoint_syncMatrix {
  let result = checkpoint_sync_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn checkpoint_sync_matrix_multiply(a : Checkpoint_syncMatrix, b : Checkpoint_syncMatrix) -> Checkpoint_syncMatrix {
  if a.cols != b.rows { return checkpoint_sync_make_matrix(a.rows, b.cols, 0.0) }
  let result = checkpoint_sync_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn checkpoint_sync_matrix_trace(m : Checkpoint_syncMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn checkpoint_sync_matrix_norm(m : Checkpoint_syncMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  checkpoint_sync_sqrt(sum)
}

pub fn checkpoint_sync_matrix_to_string(m : Checkpoint_syncMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + checkpoint_sync_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub struct Checkpoint_syncVector {
  comps : Array[Double]
  dim : Int
}

pub fn checkpoint_sync_make_vector(comps : Array[Double]) -> Checkpoint_syncVector {
  { comps, dim: comps.length() }
}

pub fn checkpoint_sync_vector_zero(dim : Int) -> Checkpoint_syncVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn checkpoint_sync_vector_add(a : Checkpoint_syncVector, b : Checkpoint_syncVector) -> Checkpoint_syncVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = checkpoint_sync_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn checkpoint_sync_vector_sub(a : Checkpoint_syncVector, b : Checkpoint_syncVector) -> Checkpoint_syncVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = checkpoint_sync_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn checkpoint_sync_vector_scale(v : Checkpoint_syncVector, s : Double) -> Checkpoint_syncVector {
  let mut result = []
  for i in 0..<v.dim { result = checkpoint_sync_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn checkpoint_sync_vector_dot(a : Checkpoint_syncVector, b : Checkpoint_syncVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn checkpoint_sync_vector_norm(v : Checkpoint_syncVector) -> Double { checkpoint_sync_sqrt(checkpoint_sync_vector_dot(v, v)) }

pub fn checkpoint_sync_vector_normalize(v : Checkpoint_syncVector) -> Checkpoint_syncVector {
  let n = checkpoint_sync_vector_norm(v)
  if n < 0.0000001 { v } else { checkpoint_sync_vector_scale(v, 1.0 / n) }
}

pub fn checkpoint_sync_vector_dist(a : Checkpoint_syncVector, b : Checkpoint_syncVector) -> Double {
  checkpoint_sync_vector_norm(checkpoint_sync_vector_sub(a, b))
}

pub fn checkpoint_sync_vector_to_string(v : Checkpoint_syncVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + checkpoint_sync_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn checkpoint_sync_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn checkpoint_sync_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = checkpoint_sync_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn checkpoint_sync_std(data : Array[Double]) -> Double { checkpoint_sync_sqrt(checkpoint_sync_var(data)) }

pub fn checkpoint_sync_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = checkpoint_sync_mean(a); let mb = checkpoint_sync_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn checkpoint_sync_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = checkpoint_sync_std(a); let sb = checkpoint_sync_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { checkpoint_sync_cov(a, b) / (sa * sb) }
}

pub fn checkpoint_sync_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn checkpoint_sync_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn checkpoint_sync_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + checkpoint_sync_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn checkpoint_sync_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = checkpoint_sync_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn checkpoint_sync_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn checkpoint_sync_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn checkpoint_sync_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = checkpoint_sync_precision(pred, labels, pos); let r = checkpoint_sync_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

fn checkpoint_sync_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn checkpoint_sync_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn checkpoint_sync_dbl(x : Double) -> String {
  let i = if x >= 0.0 { checkpoint_sync_int(x) } else { -checkpoint_sync_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { checkpoint_sync_int(f * 1000000.0) } else { checkpoint_sync_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn checkpoint_sync_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn checkpoint_sync_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

///===
/// agent_kit/task_alloc
/// S13.152 new

pub struct Task_allocPoint {
  x : Double
  y : Double
  label : Int
}

pub fn task_alloc_make_point(x : Double, y : Double) -> Task_allocPoint {
  { x, y, label: 0 }
}

pub fn task_alloc_make_labeled_point(x : Double, y : Double, label : Int) -> Task_allocPoint {
  { x, y, label }
}

pub fn task_alloc_point_x(p : Task_allocPoint) -> Double { p.x }

pub fn task_alloc_point_y(p : Task_allocPoint) -> Double { p.y }

pub fn task_alloc_point_label(p : Task_allocPoint) -> Int { p.label }

pub fn task_alloc_point_dist(a : Task_allocPoint, b : Task_allocPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  @_common.sqrt(dx * dx + dy * dy)
}

pub fn task_alloc_point_add(a : Task_allocPoint, b : Task_allocPoint) -> Task_allocPoint {
  { x: a.x + b.x, y: a.y + b.y, label: a.label }
}

pub fn task_alloc_point_sub(a : Task_allocPoint, b : Task_allocPoint) -> Task_allocPoint {
  { x: a.x - b.x, y: a.y - b.y, label: a.label }
}

pub fn task_alloc_point_scale(pt : Task_allocPoint, s : Double) -> Task_allocPoint {
  { x: pt.x * s, y: pt.y * s, label: pt.label }
}

pub fn task_alloc_point_dot(a : Task_allocPoint, b : Task_allocPoint) -> Double {
  a.x * b.x + a.y * b.y
}

pub fn task_alloc_point_norm(pt : Task_allocPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y)
}

pub fn task_alloc_point_to_string(pt : Task_allocPoint) -> String {
  "(" + task_alloc_dbl(pt.x) + ", " + task_alloc_dbl(pt.y) + ")[" + pt.label.to_string() + "]"
}

pub struct Task_allocSeries {
  vals : Array[Double]
  name : String
}

pub fn task_alloc_make_series(vals : Array[Double], name : String) -> Task_allocSeries {
  { vals, name }
}

pub fn task_alloc_series_len(s : Task_allocSeries) -> Int { s.vals.length() }

pub fn task_alloc_series_sum(s : Task_allocSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn task_alloc_series_mean(s : Task_allocSeries) -> Double {
  let n = task_alloc_series_len(s)
  if n == 0 { 0.0 } else { task_alloc_series_sum(s) / n.to_double() }
}

pub fn task_alloc_series_min(s : Task_allocSeries) -> Double {
  let n = task_alloc_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn task_alloc_series_max(s : Task_allocSeries) -> Double {
  let n = task_alloc_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn task_alloc_series_var(s : Task_allocSeries) -> Double {
  let n = task_alloc_series_len(s)
  if n == 0 { 0.0 } else {
    let m = task_alloc_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn task_alloc_series_std(s : Task_allocSeries) -> Double { @_common.sqrt(task_alloc_series_var(s)) }

pub fn task_alloc_series_scale(s : Task_allocSeries, f : Double) -> Task_allocSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = task_alloc_push(result, s.vals[i] * f) }
  { vals: result, name: s.name }
}

pub fn task_alloc_series_add(a : Task_allocSeries, b : Task_allocSeries) -> Task_allocSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = task_alloc_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name }
}

pub fn task_alloc_series_to_string(s : Task_allocSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + task_alloc_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub struct Task_allocMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn task_alloc_make_matrix(rows : Int, cols : Int, val : Double) -> Task_allocMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn task_alloc_matrix_identity(n : Int) -> Task_allocMatrix {
  let m = task_alloc_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn task_alloc_matrix_get(m : Task_allocMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn task_alloc_matrix_transpose(m : Task_allocMatrix) -> Task_allocMatrix {
  let result = task_alloc_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn task_alloc_matrix_add(a : Task_allocMatrix, b : Task_allocMatrix) -> Task_allocMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = task_alloc_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn task_alloc_matrix_scale(m : Task_allocMatrix, s : Double) -> Task_allocMatrix {
  let result = task_alloc_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn task_alloc_matrix_multiply(a : Task_allocMatrix, b : Task_allocMatrix) -> Task_allocMatrix {
  if a.cols != b.rows { return task_alloc_make_matrix(a.rows, b.cols, 0.0) }
  let result = task_alloc_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn task_alloc_matrix_trace(m : Task_allocMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn task_alloc_matrix_norm(m : Task_allocMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn task_alloc_matrix_to_string(m : Task_allocMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + task_alloc_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub struct Task_allocVector {
  comps : Array[Double]
  dim : Int
}

pub fn task_alloc_make_vector(comps : Array[Double]) -> Task_allocVector {
  { comps, dim: comps.length() }
}

pub fn task_alloc_vector_zero(dim : Int) -> Task_allocVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn task_alloc_vector_add(a : Task_allocVector, b : Task_allocVector) -> Task_allocVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = task_alloc_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn task_alloc_vector_sub(a : Task_allocVector, b : Task_allocVector) -> Task_allocVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = task_alloc_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn task_alloc_vector_scale(v : Task_allocVector, s : Double) -> Task_allocVector {
  let mut result = []
  for i in 0..<v.dim { result = task_alloc_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn task_alloc_vector_dot(a : Task_allocVector, b : Task_allocVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn task_alloc_vector_norm(v : Task_allocVector) -> Double { @_common.sqrt(task_alloc_vector_dot(v, v)) }

pub fn task_alloc_vector_normalize(v : Task_allocVector) -> Task_allocVector {
  let n = task_alloc_vector_norm(v)
  if n < 0.0000001 { v } else { task_alloc_vector_scale(v, 1.0 / n) }
}

pub fn task_alloc_vector_dist(a : Task_allocVector, b : Task_allocVector) -> Double {
  task_alloc_vector_norm(task_alloc_vector_sub(a, b))
}

pub fn task_alloc_vector_to_string(v : Task_allocVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + task_alloc_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn task_alloc_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = @_common.mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn task_alloc_std(data : Array[Double]) -> Double { @_common.sqrt(task_alloc_var(data)) }

pub fn task_alloc_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = @_common.mean(a); let mb = @_common.mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn task_alloc_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = task_alloc_std(a); let sb = task_alloc_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { task_alloc_cov(a, b) / (sa * sb) }
}

pub fn task_alloc_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn task_alloc_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn task_alloc_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn task_alloc_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = @_common.mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn task_alloc_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn task_alloc_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn task_alloc_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = task_alloc_precision(pred, labels, pos); let r = task_alloc_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

fn task_alloc_dbl(x : Double) -> String {
  let i = if x >= 0.0 { task_alloc_int(x) } else { -task_alloc_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { task_alloc_int(f * 1000000.0) } else { task_alloc_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn task_alloc_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn task_alloc_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

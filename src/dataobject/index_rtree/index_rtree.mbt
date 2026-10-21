///===
/// dataobject/index_rtree
/// S13.186 new

pub struct Index_rtreePoint {
  x : Double
  y : Double
  label : Int
}

pub fn index_rtree_make_point(x : Double, y : Double) -> Index_rtreePoint {
  { x, y, label: 0 }
}

pub fn index_rtree_make_labeled_point(x : Double, y : Double, label : Int) -> Index_rtreePoint {
  { x, y, label }
}

pub fn index_rtree_point_x(p : Index_rtreePoint) -> Double { p.x }

pub fn index_rtree_point_y(p : Index_rtreePoint) -> Double { p.y }

pub fn index_rtree_point_label(p : Index_rtreePoint) -> Int { p.label }

pub fn index_rtree_point_dist(a : Index_rtreePoint, b : Index_rtreePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  @_common.sqrt(dx * dx + dy * dy)
}

pub fn index_rtree_point_add(a : Index_rtreePoint, b : Index_rtreePoint) -> Index_rtreePoint {
  { x: a.x + b.x, y: a.y + b.y, label: a.label }
}

pub fn index_rtree_point_sub(a : Index_rtreePoint, b : Index_rtreePoint) -> Index_rtreePoint {
  { x: a.x - b.x, y: a.y - b.y, label: a.label }
}

pub fn index_rtree_point_scale(pt : Index_rtreePoint, s : Double) -> Index_rtreePoint {
  { x: pt.x * s, y: pt.y * s, label: pt.label }
}

pub fn index_rtree_point_dot(a : Index_rtreePoint, b : Index_rtreePoint) -> Double {
  a.x * b.x + a.y * b.y
}

pub fn index_rtree_point_norm(pt : Index_rtreePoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y)
}

pub fn index_rtree_point_to_string(pt : Index_rtreePoint) -> String {
  "(" + index_rtree_dbl(pt.x) + ", " + index_rtree_dbl(pt.y) + ")[" + pt.label.to_string() + "]"
}

pub struct Index_rtreeSeries {
  vals : Array[Double]
  name : String
}

pub fn index_rtree_make_series(vals : Array[Double], name : String) -> Index_rtreeSeries {
  { vals, name }
}

pub fn index_rtree_series_len(s : Index_rtreeSeries) -> Int { s.vals.length() }

pub fn index_rtree_series_sum(s : Index_rtreeSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn index_rtree_series_mean(s : Index_rtreeSeries) -> Double {
  let n = index_rtree_series_len(s)
  if n == 0 { 0.0 } else { index_rtree_series_sum(s) / n.to_double() }
}

pub fn index_rtree_series_min(s : Index_rtreeSeries) -> Double {
  let n = index_rtree_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn index_rtree_series_max(s : Index_rtreeSeries) -> Double {
  let n = index_rtree_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn index_rtree_series_var(s : Index_rtreeSeries) -> Double {
  let n = index_rtree_series_len(s)
  if n == 0 { 0.0 } else {
    let m = index_rtree_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn index_rtree_series_std(s : Index_rtreeSeries) -> Double { @_common.sqrt(index_rtree_series_var(s)) }

pub fn index_rtree_series_scale(s : Index_rtreeSeries, f : Double) -> Index_rtreeSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = index_rtree_push(result, s.vals[i] * f) }
  { vals: result, name: s.name }
}

pub fn index_rtree_series_add(a : Index_rtreeSeries, b : Index_rtreeSeries) -> Index_rtreeSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = index_rtree_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name }
}

pub fn index_rtree_series_to_string(s : Index_rtreeSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + index_rtree_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub struct Index_rtreeMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn index_rtree_make_matrix(rows : Int, cols : Int, val : Double) -> Index_rtreeMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn index_rtree_matrix_identity(n : Int) -> Index_rtreeMatrix {
  let m = index_rtree_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn index_rtree_matrix_get(m : Index_rtreeMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn index_rtree_matrix_transpose(m : Index_rtreeMatrix) -> Index_rtreeMatrix {
  let result = index_rtree_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn index_rtree_matrix_add(a : Index_rtreeMatrix, b : Index_rtreeMatrix) -> Index_rtreeMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = index_rtree_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn index_rtree_matrix_scale(m : Index_rtreeMatrix, s : Double) -> Index_rtreeMatrix {
  let result = index_rtree_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn index_rtree_matrix_multiply(a : Index_rtreeMatrix, b : Index_rtreeMatrix) -> Index_rtreeMatrix {
  if a.cols != b.rows { return index_rtree_make_matrix(a.rows, b.cols, 0.0) }
  let result = index_rtree_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn index_rtree_matrix_trace(m : Index_rtreeMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn index_rtree_matrix_norm(m : Index_rtreeMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn index_rtree_matrix_to_string(m : Index_rtreeMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + index_rtree_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub struct Index_rtreeVector {
  comps : Array[Double]
  dim : Int
}

pub fn index_rtree_make_vector(comps : Array[Double]) -> Index_rtreeVector {
  { comps, dim: comps.length() }
}

pub fn index_rtree_vector_zero(dim : Int) -> Index_rtreeVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn index_rtree_vector_add(a : Index_rtreeVector, b : Index_rtreeVector) -> Index_rtreeVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = index_rtree_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn index_rtree_vector_sub(a : Index_rtreeVector, b : Index_rtreeVector) -> Index_rtreeVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = index_rtree_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn index_rtree_vector_scale(v : Index_rtreeVector, s : Double) -> Index_rtreeVector {
  let mut result = []
  for i in 0..<v.dim { result = index_rtree_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn index_rtree_vector_dot(a : Index_rtreeVector, b : Index_rtreeVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn index_rtree_vector_norm(v : Index_rtreeVector) -> Double { @_common.sqrt(index_rtree_vector_dot(v, v)) }

pub fn index_rtree_vector_normalize(v : Index_rtreeVector) -> Index_rtreeVector {
  let n = index_rtree_vector_norm(v)
  if n < 0.0000001 { v } else { index_rtree_vector_scale(v, 1.0 / n) }
}

pub fn index_rtree_vector_dist(a : Index_rtreeVector, b : Index_rtreeVector) -> Double {
  index_rtree_vector_norm(index_rtree_vector_sub(a, b))
}

pub fn index_rtree_vector_to_string(v : Index_rtreeVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + index_rtree_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn index_rtree_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = @_common.mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn index_rtree_std(data : Array[Double]) -> Double { @_common.sqrt(index_rtree_var(data)) }

pub fn index_rtree_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = @_common.mean(a); let mb = @_common.mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn index_rtree_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = index_rtree_std(a); let sb = index_rtree_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { index_rtree_cov(a, b) / (sa * sb) }
}

pub fn index_rtree_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn index_rtree_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn index_rtree_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn index_rtree_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = @_common.mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn index_rtree_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn index_rtree_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn index_rtree_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = index_rtree_precision(pred, labels, pos); let r = index_rtree_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

fn index_rtree_dbl(x : Double) -> String {
  let i = if x >= 0.0 { index_rtree_int(x) } else { -index_rtree_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { index_rtree_int(f * 1000000.0) } else { index_rtree_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn index_rtree_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn index_rtree_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

///===
/// opcore/orthogonal_poly
/// S13.7 new

pub struct Orthogonal_polyPoint {
  x : Double
  y : Double
  label : Int
}

pub fn orthogonal_poly_make_point(x : Double, y : Double) -> Orthogonal_polyPoint {
  { x, y, label: 0 }
}

pub fn orthogonal_poly_make_labeled_point(x : Double, y : Double, label : Int) -> Orthogonal_polyPoint {
  { x, y, label }
}

pub fn orthogonal_poly_point_x(p : Orthogonal_polyPoint) -> Double { p.x }

pub fn orthogonal_poly_point_y(p : Orthogonal_polyPoint) -> Double { p.y }

pub fn orthogonal_poly_point_label(p : Orthogonal_polyPoint) -> Int { p.label }

pub fn orthogonal_poly_point_dist(a : Orthogonal_polyPoint, b : Orthogonal_polyPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  @_common.sqrt(dx * dx + dy * dy)
}

pub fn orthogonal_poly_point_add(a : Orthogonal_polyPoint, b : Orthogonal_polyPoint) -> Orthogonal_polyPoint {
  { x: a.x + b.x, y: a.y + b.y, label: a.label }
}

pub fn orthogonal_poly_point_sub(a : Orthogonal_polyPoint, b : Orthogonal_polyPoint) -> Orthogonal_polyPoint {
  { x: a.x - b.x, y: a.y - b.y, label: a.label }
}

pub fn orthogonal_poly_point_scale(pt : Orthogonal_polyPoint, s : Double) -> Orthogonal_polyPoint {
  { x: pt.x * s, y: pt.y * s, label: pt.label }
}

pub fn orthogonal_poly_point_dot(a : Orthogonal_polyPoint, b : Orthogonal_polyPoint) -> Double {
  a.x * b.x + a.y * b.y
}

pub fn orthogonal_poly_point_norm(pt : Orthogonal_polyPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y)
}

pub fn orthogonal_poly_point_to_string(pt : Orthogonal_polyPoint) -> String {
  "(" + orthogonal_poly_dbl(pt.x) + ", " + orthogonal_poly_dbl(pt.y) + ")[" + pt.label.to_string() + "]"
}

pub struct Orthogonal_polySeries {
  vals : Array[Double]
  name : String
}

pub fn orthogonal_poly_make_series(vals : Array[Double], name : String) -> Orthogonal_polySeries {
  { vals, name }
}

pub fn orthogonal_poly_series_len(s : Orthogonal_polySeries) -> Int { s.vals.length() }

pub fn orthogonal_poly_series_sum(s : Orthogonal_polySeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn orthogonal_poly_series_mean(s : Orthogonal_polySeries) -> Double {
  let n = orthogonal_poly_series_len(s)
  if n == 0 { 0.0 } else { orthogonal_poly_series_sum(s) / n.to_double() }
}

pub fn orthogonal_poly_series_min(s : Orthogonal_polySeries) -> Double {
  let n = orthogonal_poly_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn orthogonal_poly_series_max(s : Orthogonal_polySeries) -> Double {
  let n = orthogonal_poly_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn orthogonal_poly_series_var(s : Orthogonal_polySeries) -> Double {
  let n = orthogonal_poly_series_len(s)
  if n == 0 { 0.0 } else {
    let m = orthogonal_poly_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn orthogonal_poly_series_std(s : Orthogonal_polySeries) -> Double { @_common.sqrt(orthogonal_poly_series_var(s)) }

pub fn orthogonal_poly_series_scale(s : Orthogonal_polySeries, f : Double) -> Orthogonal_polySeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = orthogonal_poly_push(result, s.vals[i] * f) }
  { vals: result, name: s.name }
}

pub fn orthogonal_poly_series_add(a : Orthogonal_polySeries, b : Orthogonal_polySeries) -> Orthogonal_polySeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = orthogonal_poly_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name }
}

pub fn orthogonal_poly_series_to_string(s : Orthogonal_polySeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + orthogonal_poly_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub struct Orthogonal_polyMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn orthogonal_poly_make_matrix(rows : Int, cols : Int, val : Double) -> Orthogonal_polyMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn orthogonal_poly_matrix_identity(n : Int) -> Orthogonal_polyMatrix {
  let m = orthogonal_poly_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn orthogonal_poly_matrix_get(m : Orthogonal_polyMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn orthogonal_poly_matrix_transpose(m : Orthogonal_polyMatrix) -> Orthogonal_polyMatrix {
  let result = orthogonal_poly_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn orthogonal_poly_matrix_add(a : Orthogonal_polyMatrix, b : Orthogonal_polyMatrix) -> Orthogonal_polyMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = orthogonal_poly_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn orthogonal_poly_matrix_scale(m : Orthogonal_polyMatrix, s : Double) -> Orthogonal_polyMatrix {
  let result = orthogonal_poly_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn orthogonal_poly_matrix_multiply(a : Orthogonal_polyMatrix, b : Orthogonal_polyMatrix) -> Orthogonal_polyMatrix {
  if a.cols != b.rows { return orthogonal_poly_make_matrix(a.rows, b.cols, 0.0) }
  let result = orthogonal_poly_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn orthogonal_poly_matrix_trace(m : Orthogonal_polyMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn orthogonal_poly_matrix_norm(m : Orthogonal_polyMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn orthogonal_poly_matrix_to_string(m : Orthogonal_polyMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + orthogonal_poly_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub struct Orthogonal_polyVector {
  comps : Array[Double]
  dim : Int
}

pub fn orthogonal_poly_make_vector(comps : Array[Double]) -> Orthogonal_polyVector {
  { comps, dim: comps.length() }
}

pub fn orthogonal_poly_vector_zero(dim : Int) -> Orthogonal_polyVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn orthogonal_poly_vector_add(a : Orthogonal_polyVector, b : Orthogonal_polyVector) -> Orthogonal_polyVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = orthogonal_poly_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn orthogonal_poly_vector_sub(a : Orthogonal_polyVector, b : Orthogonal_polyVector) -> Orthogonal_polyVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = orthogonal_poly_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn orthogonal_poly_vector_scale(v : Orthogonal_polyVector, s : Double) -> Orthogonal_polyVector {
  let mut result = []
  for i in 0..<v.dim { result = orthogonal_poly_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn orthogonal_poly_vector_dot(a : Orthogonal_polyVector, b : Orthogonal_polyVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn orthogonal_poly_vector_norm(v : Orthogonal_polyVector) -> Double { @_common.sqrt(orthogonal_poly_vector_dot(v, v)) }

pub fn orthogonal_poly_vector_normalize(v : Orthogonal_polyVector) -> Orthogonal_polyVector {
  let n = orthogonal_poly_vector_norm(v)
  if n < 0.0000001 { v } else { orthogonal_poly_vector_scale(v, 1.0 / n) }
}

pub fn orthogonal_poly_vector_dist(a : Orthogonal_polyVector, b : Orthogonal_polyVector) -> Double {
  orthogonal_poly_vector_norm(orthogonal_poly_vector_sub(a, b))
}

pub fn orthogonal_poly_vector_to_string(v : Orthogonal_polyVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + orthogonal_poly_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn orthogonal_poly_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = @_common.mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn orthogonal_poly_std(data : Array[Double]) -> Double { @_common.sqrt(orthogonal_poly_var(data)) }

pub fn orthogonal_poly_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = @_common.mean(a); let mb = @_common.mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn orthogonal_poly_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = orthogonal_poly_std(a); let sb = orthogonal_poly_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { orthogonal_poly_cov(a, b) / (sa * sb) }
}

pub fn orthogonal_poly_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn orthogonal_poly_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn orthogonal_poly_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn orthogonal_poly_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = @_common.mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn orthogonal_poly_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn orthogonal_poly_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn orthogonal_poly_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = orthogonal_poly_precision(pred, labels, pos); let r = orthogonal_poly_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

fn orthogonal_poly_dbl(x : Double) -> String {
  let i = if x >= 0.0 { orthogonal_poly_int(x) } else { -orthogonal_poly_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { orthogonal_poly_int(f * 1000000.0) } else { orthogonal_poly_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn orthogonal_poly_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn orthogonal_poly_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

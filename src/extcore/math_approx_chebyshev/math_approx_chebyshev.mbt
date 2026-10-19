///===
/// extcore/math_approx_chebyshev

pub(all) struct MathapproxchebyshevPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_approx_chebyshev_make_point(x : Double, y : Double) -> MathapproxchebyshevPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_approx_chebyshev_make_point3(x : Double, y : Double, z : Double) -> MathapproxchebyshevPoint {
  { x, y, z, label: 0 }
}

pub fn math_approx_chebyshev_point_x(pt : MathapproxchebyshevPoint) -> Double { pt.x }

pub fn math_approx_chebyshev_point_y(pt : MathapproxchebyshevPoint) -> Double { pt.y }

pub fn math_approx_chebyshev_point_z(pt : MathapproxchebyshevPoint) -> Double { pt.z }

pub fn math_approx_chebyshev_point_label(pt : MathapproxchebyshevPoint) -> Int { pt.label }

pub fn math_approx_chebyshev_point_dist(a : MathapproxchebyshevPoint, b : MathapproxchebyshevPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn math_approx_chebyshev_point_add(a : MathapproxchebyshevPoint, b : MathapproxchebyshevPoint) -> MathapproxchebyshevPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn math_approx_chebyshev_point_sub(a : MathapproxchebyshevPoint, b : MathapproxchebyshevPoint) -> MathapproxchebyshevPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn math_approx_chebyshev_point_scale(pt : MathapproxchebyshevPoint, s : Double) -> MathapproxchebyshevPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn math_approx_chebyshev_point_dot(a : MathapproxchebyshevPoint, b : MathapproxchebyshevPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn math_approx_chebyshev_point_cross(a : MathapproxchebyshevPoint, b : MathapproxchebyshevPoint) -> MathapproxchebyshevPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn math_approx_chebyshev_point_norm(pt : MathapproxchebyshevPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn math_approx_chebyshev_point_normalize(pt : MathapproxchebyshevPoint) -> MathapproxchebyshevPoint {
  let n = math_approx_chebyshev_point_norm(pt)
  if n < 0.0000001 { pt } else { math_approx_chebyshev_point_scale(pt, 1.0 / n) }
}

pub fn math_approx_chebyshev_point_negate(pt : MathapproxchebyshevPoint) -> MathapproxchebyshevPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn math_approx_chebyshev_point_mid(a : MathapproxchebyshevPoint, b : MathapproxchebyshevPoint) -> MathapproxchebyshevPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn math_approx_chebyshev_point_lerp(a : MathapproxchebyshevPoint, b : MathapproxchebyshevPoint, t : Double) -> MathapproxchebyshevPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn math_approx_chebyshev_point_to_string(pt : MathapproxchebyshevPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MathapproxchebyshevSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_approx_chebyshev_make_series(vals : Array[Double], name : String) -> MathapproxchebyshevSeries {
  { vals, name, meta: 0 }
}

pub fn math_approx_chebyshev_series_len(s : MathapproxchebyshevSeries) -> Int { s.vals.length() }

pub fn math_approx_chebyshev_series_sum(s : MathapproxchebyshevSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn math_approx_chebyshev_series_mean(s : MathapproxchebyshevSeries) -> Double {
  let n = math_approx_chebyshev_series_len(s)
  if n == 0 { 0.0 } else { math_approx_chebyshev_series_sum(s) / n.to_double() }
}

pub fn math_approx_chebyshev_series_min(s : MathapproxchebyshevSeries) -> Double {
  let n = math_approx_chebyshev_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn math_approx_chebyshev_series_max(s : MathapproxchebyshevSeries) -> Double {
  let n = math_approx_chebyshev_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn math_approx_chebyshev_series_range(s : MathapproxchebyshevSeries) -> Double {
  math_approx_chebyshev_series_max(s) - math_approx_chebyshev_series_min(s)
}

pub fn math_approx_chebyshev_series_var(s : MathapproxchebyshevSeries) -> Double {
  let n = math_approx_chebyshev_series_len(s)
  if n == 0 { 0.0 } else {
    let m = math_approx_chebyshev_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn math_approx_chebyshev_series_std(s : MathapproxchebyshevSeries) -> Double { @_common.sqrt(math_approx_chebyshev_series_var(s)) }

pub fn math_approx_chebyshev_series_median(s : MathapproxchebyshevSeries) -> Double {
  let n = math_approx_chebyshev_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = math_approx_chebyshev_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn math_approx_chebyshev_series_scale(s : MathapproxchebyshevSeries, f : Double) -> MathapproxchebyshevSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn math_approx_chebyshev_series_add(a : MathapproxchebyshevSeries, b : MathapproxchebyshevSeries) -> MathapproxchebyshevSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn math_approx_chebyshev_series_sub(a : MathapproxchebyshevSeries, b : MathapproxchebyshevSeries) -> MathapproxchebyshevSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn math_approx_chebyshev_series_normalize(s : MathapproxchebyshevSeries) -> MathapproxchebyshevSeries {
  let mn = math_approx_chebyshev_series_min(s)
  let mx = math_approx_chebyshev_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn math_approx_chebyshev_series_cumsum(s : MathapproxchebyshevSeries) -> MathapproxchebyshevSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn math_approx_chebyshev_series_to_string(s : MathapproxchebyshevSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathapproxchebyshevMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_approx_chebyshev_make_matrix(rows : Int, cols : Int, val : Double) -> MathapproxchebyshevMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_approx_chebyshev_matrix_identity(n : Int) -> MathapproxchebyshevMatrix {
  let m = math_approx_chebyshev_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn math_approx_chebyshev_matrix_get(m : MathapproxchebyshevMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn math_approx_chebyshev_matrix_transpose(m : MathapproxchebyshevMatrix) -> MathapproxchebyshevMatrix {
  let result = math_approx_chebyshev_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn math_approx_chebyshev_matrix_add(a : MathapproxchebyshevMatrix, b : MathapproxchebyshevMatrix) -> MathapproxchebyshevMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = math_approx_chebyshev_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn math_approx_chebyshev_matrix_scale(m : MathapproxchebyshevMatrix, s : Double) -> MathapproxchebyshevMatrix {
  let result = math_approx_chebyshev_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn math_approx_chebyshev_matrix_multiply(a : MathapproxchebyshevMatrix, b : MathapproxchebyshevMatrix) -> MathapproxchebyshevMatrix {
  if a.cols != b.rows { return math_approx_chebyshev_make_matrix(a.rows, b.cols, 0.0) }
  let result = math_approx_chebyshev_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn math_approx_chebyshev_matrix_trace(m : MathapproxchebyshevMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn math_approx_chebyshev_matrix_det(m : MathapproxchebyshevMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn math_approx_chebyshev_matrix_norm(m : MathapproxchebyshevMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn math_approx_chebyshev_matrix_to_string(m : MathapproxchebyshevMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + @_common.dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct MathapproxchebyshevVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_approx_chebyshev_make_vector(comps : Array[Double]) -> MathapproxchebyshevVector {
  { comps, dim: comps.length() }
}

pub fn math_approx_chebyshev_vector_zero(dim : Int) -> MathapproxchebyshevVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn math_approx_chebyshev_vector_add(a : MathapproxchebyshevVector, b : MathapproxchebyshevVector) -> MathapproxchebyshevVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn math_approx_chebyshev_vector_sub(a : MathapproxchebyshevVector, b : MathapproxchebyshevVector) -> MathapproxchebyshevVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn math_approx_chebyshev_vector_scale(v : MathapproxchebyshevVector, s : Double) -> MathapproxchebyshevVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn math_approx_chebyshev_vector_dot(a : MathapproxchebyshevVector, b : MathapproxchebyshevVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn math_approx_chebyshev_vector_norm(v : MathapproxchebyshevVector) -> Double { @_common.sqrt(math_approx_chebyshev_vector_dot(v, v)) }

pub fn math_approx_chebyshev_vector_normalize(v : MathapproxchebyshevVector) -> MathapproxchebyshevVector {
  let n = math_approx_chebyshev_vector_norm(v)
  if n < 0.0000001 { v } else { math_approx_chebyshev_vector_scale(v, 1.0 / n) }
}

pub fn math_approx_chebyshev_vector_dist(a : MathapproxchebyshevVector, b : MathapproxchebyshevVector) -> Double {
  math_approx_chebyshev_vector_norm(math_approx_chebyshev_vector_sub(a, b))
}

pub fn math_approx_chebyshev_vector_to_string(v : MathapproxchebyshevVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_approx_chebyshev_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn math_approx_chebyshev_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = math_approx_chebyshev_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn math_approx_chebyshev_std(data : Array[Double]) -> Double { @_common.sqrt(math_approx_chebyshev_var(data)) }

pub fn math_approx_chebyshev_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = math_approx_chebyshev_mean(a); let mb = math_approx_chebyshev_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn math_approx_chebyshev_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = math_approx_chebyshev_std(a); let sb = math_approx_chebyshev_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { math_approx_chebyshev_cov(a, b) / (sa * sb) }
}

pub fn math_approx_chebyshev_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = math_approx_chebyshev_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn math_approx_chebyshev_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn math_approx_chebyshev_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn math_approx_chebyshev_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(math_approx_chebyshev_mse(pred, labels))
}

pub fn math_approx_chebyshev_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn math_approx_chebyshev_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = math_approx_chebyshev_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn math_approx_chebyshev_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn math_approx_chebyshev_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn math_approx_chebyshev_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = math_approx_chebyshev_precision(pred, labels, pos); let r = math_approx_chebyshev_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn math_approx_chebyshev_sort(arr : Array[Double]) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  for i in 0..<n {
    let mut min_idx = i
    let start = i + 1
    for j in start..<n { if result[j] < result[min_idx] { min_idx = j } }
    let tmp = result[i]; result[i] = result[min_idx]; result[min_idx] = tmp
  }
  result
}

pub fn math_approx_chebyshev_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = math_approx_chebyshev_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn math_approx_chebyshev_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn math_approx_chebyshev_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn math_approx_chebyshev_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = math_approx_chebyshev_gcd(a, b)
    (a / g) * b
  }
}

pub fn math_approx_chebyshev_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn math_approx_chebyshev_fibonacci(n : Int) -> Int {
  if n < 2 {
    n
  } else {
    let mut a = 0
    let mut b = 1
    let end = n + 1
    for _ in 2..<end {
      let c = a + b
      a = b
      b = c
    }
    b
  }
}

pub fn math_approx_chebyshev_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = math_approx_chebyshev_min(data); let mx = math_approx_chebyshev_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn math_approx_chebyshev_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = math_approx_chebyshev_mean(data); let sd = math_approx_chebyshev_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn math_approx_chebyshev_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn math_approx_chebyshev_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn math_approx_chebyshev_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn math_approx_chebyshev_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn math_approx_chebyshev_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn math_approx_chebyshev_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct MathapproxchebyshevFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_chebyshev_frame_make(size : Int) -> MathapproxchebyshevFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_chebyshev_frame_len(s : MathapproxchebyshevFrame) -> Int { s.size }

pub fn math_approx_chebyshev_frame_get(s : MathapproxchebyshevFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_chebyshev_frame_set(s : MathapproxchebyshevFrame, i : Int, v : Double) -> MathapproxchebyshevFrame {
  let result = math_approx_chebyshev_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_chebyshev_frame_sum(s : MathapproxchebyshevFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_chebyshev_frame_mean(s : MathapproxchebyshevFrame) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_chebyshev_frame_sum(s) / s.size.to_double() }
}

pub fn math_approx_chebyshev_frame_scale(s : MathapproxchebyshevFrame, f : Double) -> MathapproxchebyshevFrame {
  let result = math_approx_chebyshev_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_chebyshev_frame_add(a : MathapproxchebyshevFrame, b : MathapproxchebyshevFrame) -> MathapproxchebyshevFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_chebyshev_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_chebyshev_frame_copy(s : MathapproxchebyshevFrame) -> MathapproxchebyshevFrame {
  let result = math_approx_chebyshev_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_chebyshev_frame_fill(s : MathapproxchebyshevFrame, v : Double) -> MathapproxchebyshevFrame {
  let result = math_approx_chebyshev_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_chebyshev_frame_min(s : MathapproxchebyshevFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_chebyshev_frame_max(s : MathapproxchebyshevFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_chebyshev_frame_to_string(s : MathapproxchebyshevFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxchebyshevTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_chebyshev_table_make(size : Int) -> MathapproxchebyshevTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_chebyshev_table_len(s : MathapproxchebyshevTable) -> Int { s.size }

pub fn math_approx_chebyshev_table_get(s : MathapproxchebyshevTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_chebyshev_table_set(s : MathapproxchebyshevTable, i : Int, v : Double) -> MathapproxchebyshevTable {
  let result = math_approx_chebyshev_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_chebyshev_table_sum(s : MathapproxchebyshevTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_chebyshev_table_mean(s : MathapproxchebyshevTable) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_chebyshev_table_sum(s) / s.size.to_double() }
}

pub fn math_approx_chebyshev_table_scale(s : MathapproxchebyshevTable, f : Double) -> MathapproxchebyshevTable {
  let result = math_approx_chebyshev_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_chebyshev_table_add(a : MathapproxchebyshevTable, b : MathapproxchebyshevTable) -> MathapproxchebyshevTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_chebyshev_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_chebyshev_table_copy(s : MathapproxchebyshevTable) -> MathapproxchebyshevTable {
  let result = math_approx_chebyshev_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_chebyshev_table_fill(s : MathapproxchebyshevTable, v : Double) -> MathapproxchebyshevTable {
  let result = math_approx_chebyshev_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_chebyshev_table_min(s : MathapproxchebyshevTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_chebyshev_table_max(s : MathapproxchebyshevTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_chebyshev_table_to_string(s : MathapproxchebyshevTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxchebyshevGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_chebyshev_graphn_make(size : Int) -> MathapproxchebyshevGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_chebyshev_graphn_len(s : MathapproxchebyshevGraphN) -> Int { s.size }

pub fn math_approx_chebyshev_graphn_get(s : MathapproxchebyshevGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_chebyshev_graphn_set(s : MathapproxchebyshevGraphN, i : Int, v : Double) -> MathapproxchebyshevGraphN {
  let result = math_approx_chebyshev_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_chebyshev_graphn_sum(s : MathapproxchebyshevGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_chebyshev_graphn_mean(s : MathapproxchebyshevGraphN) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_chebyshev_graphn_sum(s) / s.size.to_double() }
}

pub fn math_approx_chebyshev_graphn_scale(s : MathapproxchebyshevGraphN, f : Double) -> MathapproxchebyshevGraphN {
  let result = math_approx_chebyshev_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_chebyshev_graphn_add(a : MathapproxchebyshevGraphN, b : MathapproxchebyshevGraphN) -> MathapproxchebyshevGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_chebyshev_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_chebyshev_graphn_copy(s : MathapproxchebyshevGraphN) -> MathapproxchebyshevGraphN {
  let result = math_approx_chebyshev_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_chebyshev_graphn_fill(s : MathapproxchebyshevGraphN, v : Double) -> MathapproxchebyshevGraphN {
  let result = math_approx_chebyshev_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_chebyshev_graphn_min(s : MathapproxchebyshevGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_chebyshev_graphn_max(s : MathapproxchebyshevGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_chebyshev_graphn_to_string(s : MathapproxchebyshevGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxchebyshevNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_chebyshev_node_make(size : Int) -> MathapproxchebyshevNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_chebyshev_node_len(s : MathapproxchebyshevNode) -> Int { s.size }

pub fn math_approx_chebyshev_node_get(s : MathapproxchebyshevNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_chebyshev_node_set(s : MathapproxchebyshevNode, i : Int, v : Double) -> MathapproxchebyshevNode {
  let result = math_approx_chebyshev_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_chebyshev_node_sum(s : MathapproxchebyshevNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_chebyshev_node_mean(s : MathapproxchebyshevNode) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_chebyshev_node_sum(s) / s.size.to_double() }
}

pub fn math_approx_chebyshev_node_scale(s : MathapproxchebyshevNode, f : Double) -> MathapproxchebyshevNode {
  let result = math_approx_chebyshev_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_chebyshev_node_add(a : MathapproxchebyshevNode, b : MathapproxchebyshevNode) -> MathapproxchebyshevNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_chebyshev_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_chebyshev_node_copy(s : MathapproxchebyshevNode) -> MathapproxchebyshevNode {
  let result = math_approx_chebyshev_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_chebyshev_node_fill(s : MathapproxchebyshevNode, v : Double) -> MathapproxchebyshevNode {
  let result = math_approx_chebyshev_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_chebyshev_node_min(s : MathapproxchebyshevNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_chebyshev_node_max(s : MathapproxchebyshevNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_chebyshev_node_to_string(s : MathapproxchebyshevNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxchebyshevEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_chebyshev_edge_make(size : Int) -> MathapproxchebyshevEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_chebyshev_edge_len(s : MathapproxchebyshevEdge) -> Int { s.size }

pub fn math_approx_chebyshev_edge_get(s : MathapproxchebyshevEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_chebyshev_edge_set(s : MathapproxchebyshevEdge, i : Int, v : Double) -> MathapproxchebyshevEdge {
  let result = math_approx_chebyshev_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_chebyshev_edge_sum(s : MathapproxchebyshevEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_chebyshev_edge_mean(s : MathapproxchebyshevEdge) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_chebyshev_edge_sum(s) / s.size.to_double() }
}

pub fn math_approx_chebyshev_edge_scale(s : MathapproxchebyshevEdge, f : Double) -> MathapproxchebyshevEdge {
  let result = math_approx_chebyshev_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_chebyshev_edge_add(a : MathapproxchebyshevEdge, b : MathapproxchebyshevEdge) -> MathapproxchebyshevEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_chebyshev_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_chebyshev_edge_copy(s : MathapproxchebyshevEdge) -> MathapproxchebyshevEdge {
  let result = math_approx_chebyshev_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_chebyshev_edge_fill(s : MathapproxchebyshevEdge, v : Double) -> MathapproxchebyshevEdge {
  let result = math_approx_chebyshev_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_chebyshev_edge_min(s : MathapproxchebyshevEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_chebyshev_edge_max(s : MathapproxchebyshevEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_chebyshev_edge_to_string(s : MathapproxchebyshevEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxchebyshevPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_chebyshev_path_make(size : Int) -> MathapproxchebyshevPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_chebyshev_path_len(s : MathapproxchebyshevPath) -> Int { s.size }

pub fn math_approx_chebyshev_path_get(s : MathapproxchebyshevPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_chebyshev_path_set(s : MathapproxchebyshevPath, i : Int, v : Double) -> MathapproxchebyshevPath {
  let result = math_approx_chebyshev_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_chebyshev_path_sum(s : MathapproxchebyshevPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_chebyshev_path_mean(s : MathapproxchebyshevPath) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_chebyshev_path_sum(s) / s.size.to_double() }
}

pub fn math_approx_chebyshev_path_scale(s : MathapproxchebyshevPath, f : Double) -> MathapproxchebyshevPath {
  let result = math_approx_chebyshev_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_chebyshev_path_add(a : MathapproxchebyshevPath, b : MathapproxchebyshevPath) -> MathapproxchebyshevPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_chebyshev_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_chebyshev_path_copy(s : MathapproxchebyshevPath) -> MathapproxchebyshevPath {
  let result = math_approx_chebyshev_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_chebyshev_path_fill(s : MathapproxchebyshevPath, v : Double) -> MathapproxchebyshevPath {
  let result = math_approx_chebyshev_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_chebyshev_path_min(s : MathapproxchebyshevPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_chebyshev_path_max(s : MathapproxchebyshevPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_chebyshev_path_to_string(s : MathapproxchebyshevPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxchebyshevCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_chebyshev_cluster_make(size : Int) -> MathapproxchebyshevCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_chebyshev_cluster_len(s : MathapproxchebyshevCluster) -> Int { s.size }

pub fn math_approx_chebyshev_cluster_get(s : MathapproxchebyshevCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_chebyshev_cluster_set(s : MathapproxchebyshevCluster, i : Int, v : Double) -> MathapproxchebyshevCluster {
  let result = math_approx_chebyshev_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_chebyshev_cluster_sum(s : MathapproxchebyshevCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_chebyshev_cluster_mean(s : MathapproxchebyshevCluster) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_chebyshev_cluster_sum(s) / s.size.to_double() }
}

pub fn math_approx_chebyshev_cluster_scale(s : MathapproxchebyshevCluster, f : Double) -> MathapproxchebyshevCluster {
  let result = math_approx_chebyshev_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_chebyshev_cluster_add(a : MathapproxchebyshevCluster, b : MathapproxchebyshevCluster) -> MathapproxchebyshevCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_chebyshev_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_chebyshev_cluster_copy(s : MathapproxchebyshevCluster) -> MathapproxchebyshevCluster {
  let result = math_approx_chebyshev_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_chebyshev_cluster_fill(s : MathapproxchebyshevCluster, v : Double) -> MathapproxchebyshevCluster {
  let result = math_approx_chebyshev_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_chebyshev_cluster_min(s : MathapproxchebyshevCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_chebyshev_cluster_max(s : MathapproxchebyshevCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_chebyshev_cluster_to_string(s : MathapproxchebyshevCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxchebyshevModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_chebyshev_model_make(size : Int) -> MathapproxchebyshevModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_chebyshev_model_len(s : MathapproxchebyshevModel) -> Int { s.size }

pub fn math_approx_chebyshev_model_get(s : MathapproxchebyshevModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_chebyshev_model_set(s : MathapproxchebyshevModel, i : Int, v : Double) -> MathapproxchebyshevModel {
  let result = math_approx_chebyshev_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_chebyshev_model_sum(s : MathapproxchebyshevModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_chebyshev_model_mean(s : MathapproxchebyshevModel) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_chebyshev_model_sum(s) / s.size.to_double() }
}

pub fn math_approx_chebyshev_model_scale(s : MathapproxchebyshevModel, f : Double) -> MathapproxchebyshevModel {
  let result = math_approx_chebyshev_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_chebyshev_model_add(a : MathapproxchebyshevModel, b : MathapproxchebyshevModel) -> MathapproxchebyshevModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_chebyshev_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_chebyshev_model_copy(s : MathapproxchebyshevModel) -> MathapproxchebyshevModel {
  let result = math_approx_chebyshev_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_chebyshev_model_fill(s : MathapproxchebyshevModel, v : Double) -> MathapproxchebyshevModel {
  let result = math_approx_chebyshev_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_chebyshev_model_min(s : MathapproxchebyshevModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_chebyshev_model_max(s : MathapproxchebyshevModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_chebyshev_model_to_string(s : MathapproxchebyshevModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxchebyshevLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_chebyshev_layer_make(size : Int) -> MathapproxchebyshevLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_chebyshev_layer_len(s : MathapproxchebyshevLayer) -> Int { s.size }

pub fn math_approx_chebyshev_layer_get(s : MathapproxchebyshevLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_chebyshev_layer_set(s : MathapproxchebyshevLayer, i : Int, v : Double) -> MathapproxchebyshevLayer {
  let result = math_approx_chebyshev_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_chebyshev_layer_sum(s : MathapproxchebyshevLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_chebyshev_layer_mean(s : MathapproxchebyshevLayer) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_chebyshev_layer_sum(s) / s.size.to_double() }
}

pub fn math_approx_chebyshev_layer_scale(s : MathapproxchebyshevLayer, f : Double) -> MathapproxchebyshevLayer {
  let result = math_approx_chebyshev_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_chebyshev_layer_add(a : MathapproxchebyshevLayer, b : MathapproxchebyshevLayer) -> MathapproxchebyshevLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_chebyshev_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_chebyshev_layer_copy(s : MathapproxchebyshevLayer) -> MathapproxchebyshevLayer {
  let result = math_approx_chebyshev_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_chebyshev_layer_fill(s : MathapproxchebyshevLayer, v : Double) -> MathapproxchebyshevLayer {
  let result = math_approx_chebyshev_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_chebyshev_layer_min(s : MathapproxchebyshevLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_chebyshev_layer_max(s : MathapproxchebyshevLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_chebyshev_layer_to_string(s : MathapproxchebyshevLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxchebyshevBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_chebyshev_buffer_make(size : Int) -> MathapproxchebyshevBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_chebyshev_buffer_len(s : MathapproxchebyshevBuffer) -> Int { s.size }

pub fn math_approx_chebyshev_buffer_get(s : MathapproxchebyshevBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_chebyshev_buffer_set(s : MathapproxchebyshevBuffer, i : Int, v : Double) -> MathapproxchebyshevBuffer {
  let result = math_approx_chebyshev_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_chebyshev_buffer_sum(s : MathapproxchebyshevBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_chebyshev_buffer_mean(s : MathapproxchebyshevBuffer) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_chebyshev_buffer_sum(s) / s.size.to_double() }
}

pub fn math_approx_chebyshev_buffer_scale(s : MathapproxchebyshevBuffer, f : Double) -> MathapproxchebyshevBuffer {
  let result = math_approx_chebyshev_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_chebyshev_buffer_add(a : MathapproxchebyshevBuffer, b : MathapproxchebyshevBuffer) -> MathapproxchebyshevBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_chebyshev_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_chebyshev_buffer_copy(s : MathapproxchebyshevBuffer) -> MathapproxchebyshevBuffer {
  let result = math_approx_chebyshev_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_chebyshev_buffer_fill(s : MathapproxchebyshevBuffer, v : Double) -> MathapproxchebyshevBuffer {
  let result = math_approx_chebyshev_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_chebyshev_buffer_min(s : MathapproxchebyshevBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_chebyshev_buffer_max(s : MathapproxchebyshevBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_chebyshev_buffer_to_string(s : MathapproxchebyshevBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxchebyshevCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_chebyshev_cursor_make(size : Int) -> MathapproxchebyshevCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_chebyshev_cursor_len(s : MathapproxchebyshevCursor) -> Int { s.size }

pub fn math_approx_chebyshev_cursor_get(s : MathapproxchebyshevCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_chebyshev_cursor_set(s : MathapproxchebyshevCursor, i : Int, v : Double) -> MathapproxchebyshevCursor {
  let result = math_approx_chebyshev_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_chebyshev_cursor_sum(s : MathapproxchebyshevCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_chebyshev_cursor_mean(s : MathapproxchebyshevCursor) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_chebyshev_cursor_sum(s) / s.size.to_double() }
}

pub fn math_approx_chebyshev_cursor_scale(s : MathapproxchebyshevCursor, f : Double) -> MathapproxchebyshevCursor {
  let result = math_approx_chebyshev_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_chebyshev_cursor_add(a : MathapproxchebyshevCursor, b : MathapproxchebyshevCursor) -> MathapproxchebyshevCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_chebyshev_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_chebyshev_cursor_copy(s : MathapproxchebyshevCursor) -> MathapproxchebyshevCursor {
  let result = math_approx_chebyshev_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_chebyshev_cursor_fill(s : MathapproxchebyshevCursor, v : Double) -> MathapproxchebyshevCursor {
  let result = math_approx_chebyshev_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_chebyshev_cursor_min(s : MathapproxchebyshevCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_chebyshev_cursor_max(s : MathapproxchebyshevCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_chebyshev_cursor_to_string(s : MathapproxchebyshevCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxchebyshevView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_chebyshev_view_make(size : Int) -> MathapproxchebyshevView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_chebyshev_view_len(s : MathapproxchebyshevView) -> Int { s.size }

pub fn math_approx_chebyshev_view_get(s : MathapproxchebyshevView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_chebyshev_view_set(s : MathapproxchebyshevView, i : Int, v : Double) -> MathapproxchebyshevView {
  let result = math_approx_chebyshev_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_chebyshev_view_sum(s : MathapproxchebyshevView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_chebyshev_view_mean(s : MathapproxchebyshevView) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_chebyshev_view_sum(s) / s.size.to_double() }
}

pub fn math_approx_chebyshev_view_scale(s : MathapproxchebyshevView, f : Double) -> MathapproxchebyshevView {
  let result = math_approx_chebyshev_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_chebyshev_view_add(a : MathapproxchebyshevView, b : MathapproxchebyshevView) -> MathapproxchebyshevView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_chebyshev_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_chebyshev_view_copy(s : MathapproxchebyshevView) -> MathapproxchebyshevView {
  let result = math_approx_chebyshev_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_chebyshev_view_fill(s : MathapproxchebyshevView, v : Double) -> MathapproxchebyshevView {
  let result = math_approx_chebyshev_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_chebyshev_view_min(s : MathapproxchebyshevView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_chebyshev_view_max(s : MathapproxchebyshevView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_chebyshev_view_to_string(s : MathapproxchebyshevView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxchebyshevRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_chebyshev_range_make(size : Int) -> MathapproxchebyshevRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_chebyshev_range_len(s : MathapproxchebyshevRange) -> Int { s.size }

pub fn math_approx_chebyshev_range_get(s : MathapproxchebyshevRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_chebyshev_range_set(s : MathapproxchebyshevRange, i : Int, v : Double) -> MathapproxchebyshevRange {
  let result = math_approx_chebyshev_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_chebyshev_range_sum(s : MathapproxchebyshevRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_chebyshev_range_mean(s : MathapproxchebyshevRange) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_chebyshev_range_sum(s) / s.size.to_double() }
}

pub fn math_approx_chebyshev_range_scale(s : MathapproxchebyshevRange, f : Double) -> MathapproxchebyshevRange {
  let result = math_approx_chebyshev_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_chebyshev_range_add(a : MathapproxchebyshevRange, b : MathapproxchebyshevRange) -> MathapproxchebyshevRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_chebyshev_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_chebyshev_range_copy(s : MathapproxchebyshevRange) -> MathapproxchebyshevRange {
  let result = math_approx_chebyshev_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_chebyshev_range_fill(s : MathapproxchebyshevRange, v : Double) -> MathapproxchebyshevRange {
  let result = math_approx_chebyshev_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_chebyshev_range_min(s : MathapproxchebyshevRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_chebyshev_range_max(s : MathapproxchebyshevRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_chebyshev_range_to_string(s : MathapproxchebyshevRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxchebyshevSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_chebyshev_slice_make(size : Int) -> MathapproxchebyshevSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_chebyshev_slice_len(s : MathapproxchebyshevSlice) -> Int { s.size }

pub fn math_approx_chebyshev_slice_get(s : MathapproxchebyshevSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_chebyshev_slice_set(s : MathapproxchebyshevSlice, i : Int, v : Double) -> MathapproxchebyshevSlice {
  let result = math_approx_chebyshev_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_chebyshev_slice_sum(s : MathapproxchebyshevSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_chebyshev_slice_mean(s : MathapproxchebyshevSlice) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_chebyshev_slice_sum(s) / s.size.to_double() }
}

pub fn math_approx_chebyshev_slice_scale(s : MathapproxchebyshevSlice, f : Double) -> MathapproxchebyshevSlice {
  let result = math_approx_chebyshev_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_chebyshev_slice_add(a : MathapproxchebyshevSlice, b : MathapproxchebyshevSlice) -> MathapproxchebyshevSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_chebyshev_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_chebyshev_slice_copy(s : MathapproxchebyshevSlice) -> MathapproxchebyshevSlice {
  let result = math_approx_chebyshev_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_chebyshev_slice_fill(s : MathapproxchebyshevSlice, v : Double) -> MathapproxchebyshevSlice {
  let result = math_approx_chebyshev_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_chebyshev_slice_min(s : MathapproxchebyshevSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_chebyshev_slice_max(s : MathapproxchebyshevSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_chebyshev_slice_to_string(s : MathapproxchebyshevSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


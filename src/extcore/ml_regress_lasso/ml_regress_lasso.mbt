///===
/// extcore/ml_regress_lasso

pub(all) struct MlregresslassoPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_regress_lasso_make_point(x : Double, y : Double) -> MlregresslassoPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_regress_lasso_make_point3(x : Double, y : Double, z : Double) -> MlregresslassoPoint {
  { x, y, z, label: 0 }
}

pub fn ml_regress_lasso_point_x(pt : MlregresslassoPoint) -> Double { pt.x }

pub fn ml_regress_lasso_point_y(pt : MlregresslassoPoint) -> Double { pt.y }

pub fn ml_regress_lasso_point_z(pt : MlregresslassoPoint) -> Double { pt.z }

pub fn ml_regress_lasso_point_label(pt : MlregresslassoPoint) -> Int { pt.label }

pub fn ml_regress_lasso_point_dist(a : MlregresslassoPoint, b : MlregresslassoPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ml_regress_lasso_point_add(a : MlregresslassoPoint, b : MlregresslassoPoint) -> MlregresslassoPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ml_regress_lasso_point_sub(a : MlregresslassoPoint, b : MlregresslassoPoint) -> MlregresslassoPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ml_regress_lasso_point_scale(pt : MlregresslassoPoint, s : Double) -> MlregresslassoPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ml_regress_lasso_point_dot(a : MlregresslassoPoint, b : MlregresslassoPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ml_regress_lasso_point_cross(a : MlregresslassoPoint, b : MlregresslassoPoint) -> MlregresslassoPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ml_regress_lasso_point_norm(pt : MlregresslassoPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ml_regress_lasso_point_normalize(pt : MlregresslassoPoint) -> MlregresslassoPoint {
  let n = ml_regress_lasso_point_norm(pt)
  if n < 0.0000001 { pt } else { ml_regress_lasso_point_scale(pt, 1.0 / n) }
}

pub fn ml_regress_lasso_point_negate(pt : MlregresslassoPoint) -> MlregresslassoPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ml_regress_lasso_point_mid(a : MlregresslassoPoint, b : MlregresslassoPoint) -> MlregresslassoPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ml_regress_lasso_point_lerp(a : MlregresslassoPoint, b : MlregresslassoPoint, t : Double) -> MlregresslassoPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ml_regress_lasso_point_to_string(pt : MlregresslassoPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MlregresslassoSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_regress_lasso_make_series(vals : Array[Double], name : String) -> MlregresslassoSeries {
  { vals, name, meta: 0 }
}

pub fn ml_regress_lasso_series_len(s : MlregresslassoSeries) -> Int { s.vals.length() }

pub fn ml_regress_lasso_series_sum(s : MlregresslassoSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn ml_regress_lasso_series_mean(s : MlregresslassoSeries) -> Double {
  let n = ml_regress_lasso_series_len(s)
  if n == 0 { 0.0 } else { ml_regress_lasso_series_sum(s) / n.to_double() }
}

pub fn ml_regress_lasso_series_min(s : MlregresslassoSeries) -> Double {
  let n = ml_regress_lasso_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn ml_regress_lasso_series_max(s : MlregresslassoSeries) -> Double {
  let n = ml_regress_lasso_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn ml_regress_lasso_series_range(s : MlregresslassoSeries) -> Double {
  ml_regress_lasso_series_max(s) - ml_regress_lasso_series_min(s)
}

pub fn ml_regress_lasso_series_var(s : MlregresslassoSeries) -> Double {
  let n = ml_regress_lasso_series_len(s)
  if n == 0 { 0.0 } else {
    let m = ml_regress_lasso_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn ml_regress_lasso_series_std(s : MlregresslassoSeries) -> Double { @_common.sqrt(ml_regress_lasso_series_var(s)) }

pub fn ml_regress_lasso_series_median(s : MlregresslassoSeries) -> Double {
  let n = ml_regress_lasso_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = ml_regress_lasso_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ml_regress_lasso_series_scale(s : MlregresslassoSeries, f : Double) -> MlregresslassoSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ml_regress_lasso_series_add(a : MlregresslassoSeries, b : MlregresslassoSeries) -> MlregresslassoSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ml_regress_lasso_series_sub(a : MlregresslassoSeries, b : MlregresslassoSeries) -> MlregresslassoSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ml_regress_lasso_series_normalize(s : MlregresslassoSeries) -> MlregresslassoSeries {
  let mn = ml_regress_lasso_series_min(s)
  let mx = ml_regress_lasso_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ml_regress_lasso_series_cumsum(s : MlregresslassoSeries) -> MlregresslassoSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn ml_regress_lasso_series_to_string(s : MlregresslassoSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlregresslassoMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_regress_lasso_make_matrix(rows : Int, cols : Int, val : Double) -> MlregresslassoMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_regress_lasso_matrix_identity(n : Int) -> MlregresslassoMatrix {
  let m = ml_regress_lasso_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ml_regress_lasso_matrix_get(m : MlregresslassoMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ml_regress_lasso_matrix_transpose(m : MlregresslassoMatrix) -> MlregresslassoMatrix {
  let result = ml_regress_lasso_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ml_regress_lasso_matrix_add(a : MlregresslassoMatrix, b : MlregresslassoMatrix) -> MlregresslassoMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ml_regress_lasso_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ml_regress_lasso_matrix_scale(m : MlregresslassoMatrix, s : Double) -> MlregresslassoMatrix {
  let result = ml_regress_lasso_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ml_regress_lasso_matrix_multiply(a : MlregresslassoMatrix, b : MlregresslassoMatrix) -> MlregresslassoMatrix {
  if a.cols != b.rows { return ml_regress_lasso_make_matrix(a.rows, b.cols, 0.0) }
  let result = ml_regress_lasso_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ml_regress_lasso_matrix_trace(m : MlregresslassoMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ml_regress_lasso_matrix_det(m : MlregresslassoMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ml_regress_lasso_matrix_norm(m : MlregresslassoMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ml_regress_lasso_matrix_to_string(m : MlregresslassoMatrix) -> String {
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

pub(all) struct MlregresslassoVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_regress_lasso_make_vector(comps : Array[Double]) -> MlregresslassoVector {
  { comps, dim: comps.length() }
}

pub fn ml_regress_lasso_vector_zero(dim : Int) -> MlregresslassoVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ml_regress_lasso_vector_add(a : MlregresslassoVector, b : MlregresslassoVector) -> MlregresslassoVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_regress_lasso_vector_sub(a : MlregresslassoVector, b : MlregresslassoVector) -> MlregresslassoVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_regress_lasso_vector_scale(v : MlregresslassoVector, s : Double) -> MlregresslassoVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ml_regress_lasso_vector_dot(a : MlregresslassoVector, b : MlregresslassoVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ml_regress_lasso_vector_norm(v : MlregresslassoVector) -> Double { @_common.sqrt(ml_regress_lasso_vector_dot(v, v)) }

pub fn ml_regress_lasso_vector_normalize(v : MlregresslassoVector) -> MlregresslassoVector {
  let n = ml_regress_lasso_vector_norm(v)
  if n < 0.0000001 { v } else { ml_regress_lasso_vector_scale(v, 1.0 / n) }
}

pub fn ml_regress_lasso_vector_dist(a : MlregresslassoVector, b : MlregresslassoVector) -> Double {
  ml_regress_lasso_vector_norm(ml_regress_lasso_vector_sub(a, b))
}

pub fn ml_regress_lasso_vector_to_string(v : MlregresslassoVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_regress_lasso_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn ml_regress_lasso_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = ml_regress_lasso_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ml_regress_lasso_std(data : Array[Double]) -> Double { @_common.sqrt(ml_regress_lasso_var(data)) }

pub fn ml_regress_lasso_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = ml_regress_lasso_mean(a); let mb = ml_regress_lasso_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn ml_regress_lasso_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = ml_regress_lasso_std(a); let sb = ml_regress_lasso_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { ml_regress_lasso_cov(a, b) / (sa * sb) }
}

pub fn ml_regress_lasso_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = ml_regress_lasso_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ml_regress_lasso_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn ml_regress_lasso_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ml_regress_lasso_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(ml_regress_lasso_mse(pred, labels))
}

pub fn ml_regress_lasso_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn ml_regress_lasso_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = ml_regress_lasso_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn ml_regress_lasso_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn ml_regress_lasso_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn ml_regress_lasso_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = ml_regress_lasso_precision(pred, labels, pos); let r = ml_regress_lasso_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn ml_regress_lasso_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn ml_regress_lasso_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = ml_regress_lasso_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn ml_regress_lasso_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn ml_regress_lasso_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn ml_regress_lasso_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = ml_regress_lasso_gcd(a, b)
    (a / g) * b
  }
}

pub fn ml_regress_lasso_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn ml_regress_lasso_fibonacci(n : Int) -> Int {
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

pub fn ml_regress_lasso_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = ml_regress_lasso_min(data); let mx = ml_regress_lasso_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn ml_regress_lasso_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = ml_regress_lasso_mean(data); let sd = ml_regress_lasso_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn ml_regress_lasso_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn ml_regress_lasso_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn ml_regress_lasso_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn ml_regress_lasso_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn ml_regress_lasso_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn ml_regress_lasso_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct MlregresslassoFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_lasso_frame_make(size : Int) -> MlregresslassoFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_lasso_frame_len(s : MlregresslassoFrame) -> Int { s.size }

pub fn ml_regress_lasso_frame_get(s : MlregresslassoFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_lasso_frame_set(s : MlregresslassoFrame, i : Int, v : Double) -> MlregresslassoFrame {
  let result = ml_regress_lasso_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_lasso_frame_sum(s : MlregresslassoFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_regress_lasso_frame_mean(s : MlregresslassoFrame) -> Double {
  if s.size == 0 { 0.0 } else { ml_regress_lasso_frame_sum(s) / s.size.to_double() }
}

pub fn ml_regress_lasso_frame_scale(s : MlregresslassoFrame, f : Double) -> MlregresslassoFrame {
  let result = ml_regress_lasso_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_regress_lasso_frame_add(a : MlregresslassoFrame, b : MlregresslassoFrame) -> MlregresslassoFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_regress_lasso_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_regress_lasso_frame_copy(s : MlregresslassoFrame) -> MlregresslassoFrame {
  let result = ml_regress_lasso_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_regress_lasso_frame_fill(s : MlregresslassoFrame, v : Double) -> MlregresslassoFrame {
  let result = ml_regress_lasso_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_regress_lasso_frame_min(s : MlregresslassoFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_lasso_frame_max(s : MlregresslassoFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_lasso_frame_to_string(s : MlregresslassoFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresslassoTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_lasso_table_make(size : Int) -> MlregresslassoTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_lasso_table_len(s : MlregresslassoTable) -> Int { s.size }

pub fn ml_regress_lasso_table_get(s : MlregresslassoTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_lasso_table_set(s : MlregresslassoTable, i : Int, v : Double) -> MlregresslassoTable {
  let result = ml_regress_lasso_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_lasso_table_sum(s : MlregresslassoTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_regress_lasso_table_mean(s : MlregresslassoTable) -> Double {
  if s.size == 0 { 0.0 } else { ml_regress_lasso_table_sum(s) / s.size.to_double() }
}

pub fn ml_regress_lasso_table_scale(s : MlregresslassoTable, f : Double) -> MlregresslassoTable {
  let result = ml_regress_lasso_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_regress_lasso_table_add(a : MlregresslassoTable, b : MlregresslassoTable) -> MlregresslassoTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_regress_lasso_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_regress_lasso_table_copy(s : MlregresslassoTable) -> MlregresslassoTable {
  let result = ml_regress_lasso_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_regress_lasso_table_fill(s : MlregresslassoTable, v : Double) -> MlregresslassoTable {
  let result = ml_regress_lasso_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_regress_lasso_table_min(s : MlregresslassoTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_lasso_table_max(s : MlregresslassoTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_lasso_table_to_string(s : MlregresslassoTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresslassoGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_lasso_graphn_make(size : Int) -> MlregresslassoGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_lasso_graphn_len(s : MlregresslassoGraphN) -> Int { s.size }

pub fn ml_regress_lasso_graphn_get(s : MlregresslassoGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_lasso_graphn_set(s : MlregresslassoGraphN, i : Int, v : Double) -> MlregresslassoGraphN {
  let result = ml_regress_lasso_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_lasso_graphn_sum(s : MlregresslassoGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_regress_lasso_graphn_mean(s : MlregresslassoGraphN) -> Double {
  if s.size == 0 { 0.0 } else { ml_regress_lasso_graphn_sum(s) / s.size.to_double() }
}

pub fn ml_regress_lasso_graphn_scale(s : MlregresslassoGraphN, f : Double) -> MlregresslassoGraphN {
  let result = ml_regress_lasso_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_regress_lasso_graphn_add(a : MlregresslassoGraphN, b : MlregresslassoGraphN) -> MlregresslassoGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_regress_lasso_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_regress_lasso_graphn_copy(s : MlregresslassoGraphN) -> MlregresslassoGraphN {
  let result = ml_regress_lasso_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_regress_lasso_graphn_fill(s : MlregresslassoGraphN, v : Double) -> MlregresslassoGraphN {
  let result = ml_regress_lasso_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_regress_lasso_graphn_min(s : MlregresslassoGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_lasso_graphn_max(s : MlregresslassoGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_lasso_graphn_to_string(s : MlregresslassoGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresslassoNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_lasso_node_make(size : Int) -> MlregresslassoNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_lasso_node_len(s : MlregresslassoNode) -> Int { s.size }

pub fn ml_regress_lasso_node_get(s : MlregresslassoNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_lasso_node_set(s : MlregresslassoNode, i : Int, v : Double) -> MlregresslassoNode {
  let result = ml_regress_lasso_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_lasso_node_sum(s : MlregresslassoNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_regress_lasso_node_mean(s : MlregresslassoNode) -> Double {
  if s.size == 0 { 0.0 } else { ml_regress_lasso_node_sum(s) / s.size.to_double() }
}

pub fn ml_regress_lasso_node_scale(s : MlregresslassoNode, f : Double) -> MlregresslassoNode {
  let result = ml_regress_lasso_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_regress_lasso_node_add(a : MlregresslassoNode, b : MlregresslassoNode) -> MlregresslassoNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_regress_lasso_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_regress_lasso_node_copy(s : MlregresslassoNode) -> MlregresslassoNode {
  let result = ml_regress_lasso_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_regress_lasso_node_fill(s : MlregresslassoNode, v : Double) -> MlregresslassoNode {
  let result = ml_regress_lasso_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_regress_lasso_node_min(s : MlregresslassoNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_lasso_node_max(s : MlregresslassoNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_lasso_node_to_string(s : MlregresslassoNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresslassoEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_lasso_edge_make(size : Int) -> MlregresslassoEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_lasso_edge_len(s : MlregresslassoEdge) -> Int { s.size }

pub fn ml_regress_lasso_edge_get(s : MlregresslassoEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_lasso_edge_set(s : MlregresslassoEdge, i : Int, v : Double) -> MlregresslassoEdge {
  let result = ml_regress_lasso_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_lasso_edge_sum(s : MlregresslassoEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_regress_lasso_edge_mean(s : MlregresslassoEdge) -> Double {
  if s.size == 0 { 0.0 } else { ml_regress_lasso_edge_sum(s) / s.size.to_double() }
}

pub fn ml_regress_lasso_edge_scale(s : MlregresslassoEdge, f : Double) -> MlregresslassoEdge {
  let result = ml_regress_lasso_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_regress_lasso_edge_add(a : MlregresslassoEdge, b : MlregresslassoEdge) -> MlregresslassoEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_regress_lasso_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_regress_lasso_edge_copy(s : MlregresslassoEdge) -> MlregresslassoEdge {
  let result = ml_regress_lasso_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_regress_lasso_edge_fill(s : MlregresslassoEdge, v : Double) -> MlregresslassoEdge {
  let result = ml_regress_lasso_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_regress_lasso_edge_min(s : MlregresslassoEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_lasso_edge_max(s : MlregresslassoEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_lasso_edge_to_string(s : MlregresslassoEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresslassoPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_lasso_path_make(size : Int) -> MlregresslassoPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_lasso_path_len(s : MlregresslassoPath) -> Int { s.size }

pub fn ml_regress_lasso_path_get(s : MlregresslassoPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_lasso_path_set(s : MlregresslassoPath, i : Int, v : Double) -> MlregresslassoPath {
  let result = ml_regress_lasso_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_lasso_path_sum(s : MlregresslassoPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_regress_lasso_path_mean(s : MlregresslassoPath) -> Double {
  if s.size == 0 { 0.0 } else { ml_regress_lasso_path_sum(s) / s.size.to_double() }
}

pub fn ml_regress_lasso_path_scale(s : MlregresslassoPath, f : Double) -> MlregresslassoPath {
  let result = ml_regress_lasso_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_regress_lasso_path_add(a : MlregresslassoPath, b : MlregresslassoPath) -> MlregresslassoPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_regress_lasso_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_regress_lasso_path_copy(s : MlregresslassoPath) -> MlregresslassoPath {
  let result = ml_regress_lasso_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_regress_lasso_path_fill(s : MlregresslassoPath, v : Double) -> MlregresslassoPath {
  let result = ml_regress_lasso_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_regress_lasso_path_min(s : MlregresslassoPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_lasso_path_max(s : MlregresslassoPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_lasso_path_to_string(s : MlregresslassoPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresslassoCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_lasso_cluster_make(size : Int) -> MlregresslassoCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_lasso_cluster_len(s : MlregresslassoCluster) -> Int { s.size }

pub fn ml_regress_lasso_cluster_get(s : MlregresslassoCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_lasso_cluster_set(s : MlregresslassoCluster, i : Int, v : Double) -> MlregresslassoCluster {
  let result = ml_regress_lasso_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_lasso_cluster_sum(s : MlregresslassoCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_regress_lasso_cluster_mean(s : MlregresslassoCluster) -> Double {
  if s.size == 0 { 0.0 } else { ml_regress_lasso_cluster_sum(s) / s.size.to_double() }
}

pub fn ml_regress_lasso_cluster_scale(s : MlregresslassoCluster, f : Double) -> MlregresslassoCluster {
  let result = ml_regress_lasso_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_regress_lasso_cluster_add(a : MlregresslassoCluster, b : MlregresslassoCluster) -> MlregresslassoCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_regress_lasso_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_regress_lasso_cluster_copy(s : MlregresslassoCluster) -> MlregresslassoCluster {
  let result = ml_regress_lasso_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_regress_lasso_cluster_fill(s : MlregresslassoCluster, v : Double) -> MlregresslassoCluster {
  let result = ml_regress_lasso_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_regress_lasso_cluster_min(s : MlregresslassoCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_lasso_cluster_max(s : MlregresslassoCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_lasso_cluster_to_string(s : MlregresslassoCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresslassoModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_lasso_model_make(size : Int) -> MlregresslassoModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_lasso_model_len(s : MlregresslassoModel) -> Int { s.size }

pub fn ml_regress_lasso_model_get(s : MlregresslassoModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_lasso_model_set(s : MlregresslassoModel, i : Int, v : Double) -> MlregresslassoModel {
  let result = ml_regress_lasso_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_lasso_model_sum(s : MlregresslassoModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_regress_lasso_model_mean(s : MlregresslassoModel) -> Double {
  if s.size == 0 { 0.0 } else { ml_regress_lasso_model_sum(s) / s.size.to_double() }
}

pub fn ml_regress_lasso_model_scale(s : MlregresslassoModel, f : Double) -> MlregresslassoModel {
  let result = ml_regress_lasso_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_regress_lasso_model_add(a : MlregresslassoModel, b : MlregresslassoModel) -> MlregresslassoModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_regress_lasso_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_regress_lasso_model_copy(s : MlregresslassoModel) -> MlregresslassoModel {
  let result = ml_regress_lasso_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_regress_lasso_model_fill(s : MlregresslassoModel, v : Double) -> MlregresslassoModel {
  let result = ml_regress_lasso_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_regress_lasso_model_min(s : MlregresslassoModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_lasso_model_max(s : MlregresslassoModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_lasso_model_to_string(s : MlregresslassoModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresslassoLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_lasso_layer_make(size : Int) -> MlregresslassoLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_lasso_layer_len(s : MlregresslassoLayer) -> Int { s.size }

pub fn ml_regress_lasso_layer_get(s : MlregresslassoLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_lasso_layer_set(s : MlregresslassoLayer, i : Int, v : Double) -> MlregresslassoLayer {
  let result = ml_regress_lasso_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_lasso_layer_sum(s : MlregresslassoLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_regress_lasso_layer_mean(s : MlregresslassoLayer) -> Double {
  if s.size == 0 { 0.0 } else { ml_regress_lasso_layer_sum(s) / s.size.to_double() }
}

pub fn ml_regress_lasso_layer_scale(s : MlregresslassoLayer, f : Double) -> MlregresslassoLayer {
  let result = ml_regress_lasso_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_regress_lasso_layer_add(a : MlregresslassoLayer, b : MlregresslassoLayer) -> MlregresslassoLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_regress_lasso_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_regress_lasso_layer_copy(s : MlregresslassoLayer) -> MlregresslassoLayer {
  let result = ml_regress_lasso_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_regress_lasso_layer_fill(s : MlregresslassoLayer, v : Double) -> MlregresslassoLayer {
  let result = ml_regress_lasso_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_regress_lasso_layer_min(s : MlregresslassoLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_lasso_layer_max(s : MlregresslassoLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_lasso_layer_to_string(s : MlregresslassoLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresslassoBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_lasso_buffer_make(size : Int) -> MlregresslassoBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_lasso_buffer_len(s : MlregresslassoBuffer) -> Int { s.size }

pub fn ml_regress_lasso_buffer_get(s : MlregresslassoBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_lasso_buffer_set(s : MlregresslassoBuffer, i : Int, v : Double) -> MlregresslassoBuffer {
  let result = ml_regress_lasso_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_lasso_buffer_sum(s : MlregresslassoBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_regress_lasso_buffer_mean(s : MlregresslassoBuffer) -> Double {
  if s.size == 0 { 0.0 } else { ml_regress_lasso_buffer_sum(s) / s.size.to_double() }
}

pub fn ml_regress_lasso_buffer_scale(s : MlregresslassoBuffer, f : Double) -> MlregresslassoBuffer {
  let result = ml_regress_lasso_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_regress_lasso_buffer_add(a : MlregresslassoBuffer, b : MlregresslassoBuffer) -> MlregresslassoBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_regress_lasso_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_regress_lasso_buffer_copy(s : MlregresslassoBuffer) -> MlregresslassoBuffer {
  let result = ml_regress_lasso_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_regress_lasso_buffer_fill(s : MlregresslassoBuffer, v : Double) -> MlregresslassoBuffer {
  let result = ml_regress_lasso_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_regress_lasso_buffer_min(s : MlregresslassoBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_lasso_buffer_max(s : MlregresslassoBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_lasso_buffer_to_string(s : MlregresslassoBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresslassoCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_lasso_cursor_make(size : Int) -> MlregresslassoCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_lasso_cursor_len(s : MlregresslassoCursor) -> Int { s.size }

pub fn ml_regress_lasso_cursor_get(s : MlregresslassoCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_lasso_cursor_set(s : MlregresslassoCursor, i : Int, v : Double) -> MlregresslassoCursor {
  let result = ml_regress_lasso_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_lasso_cursor_sum(s : MlregresslassoCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_regress_lasso_cursor_mean(s : MlregresslassoCursor) -> Double {
  if s.size == 0 { 0.0 } else { ml_regress_lasso_cursor_sum(s) / s.size.to_double() }
}

pub fn ml_regress_lasso_cursor_scale(s : MlregresslassoCursor, f : Double) -> MlregresslassoCursor {
  let result = ml_regress_lasso_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_regress_lasso_cursor_add(a : MlregresslassoCursor, b : MlregresslassoCursor) -> MlregresslassoCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_regress_lasso_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_regress_lasso_cursor_copy(s : MlregresslassoCursor) -> MlregresslassoCursor {
  let result = ml_regress_lasso_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_regress_lasso_cursor_fill(s : MlregresslassoCursor, v : Double) -> MlregresslassoCursor {
  let result = ml_regress_lasso_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_regress_lasso_cursor_min(s : MlregresslassoCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_lasso_cursor_max(s : MlregresslassoCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_lasso_cursor_to_string(s : MlregresslassoCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresslassoView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_lasso_view_make(size : Int) -> MlregresslassoView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_lasso_view_len(s : MlregresslassoView) -> Int { s.size }

pub fn ml_regress_lasso_view_get(s : MlregresslassoView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_lasso_view_set(s : MlregresslassoView, i : Int, v : Double) -> MlregresslassoView {
  let result = ml_regress_lasso_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_lasso_view_sum(s : MlregresslassoView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_regress_lasso_view_mean(s : MlregresslassoView) -> Double {
  if s.size == 0 { 0.0 } else { ml_regress_lasso_view_sum(s) / s.size.to_double() }
}

pub fn ml_regress_lasso_view_scale(s : MlregresslassoView, f : Double) -> MlregresslassoView {
  let result = ml_regress_lasso_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_regress_lasso_view_add(a : MlregresslassoView, b : MlregresslassoView) -> MlregresslassoView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_regress_lasso_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_regress_lasso_view_copy(s : MlregresslassoView) -> MlregresslassoView {
  let result = ml_regress_lasso_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_regress_lasso_view_fill(s : MlregresslassoView, v : Double) -> MlregresslassoView {
  let result = ml_regress_lasso_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_regress_lasso_view_min(s : MlregresslassoView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_lasso_view_max(s : MlregresslassoView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_lasso_view_to_string(s : MlregresslassoView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresslassoRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_lasso_range_make(size : Int) -> MlregresslassoRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_lasso_range_len(s : MlregresslassoRange) -> Int { s.size }

pub fn ml_regress_lasso_range_get(s : MlregresslassoRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_lasso_range_set(s : MlregresslassoRange, i : Int, v : Double) -> MlregresslassoRange {
  let result = ml_regress_lasso_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_lasso_range_sum(s : MlregresslassoRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_regress_lasso_range_mean(s : MlregresslassoRange) -> Double {
  if s.size == 0 { 0.0 } else { ml_regress_lasso_range_sum(s) / s.size.to_double() }
}

pub fn ml_regress_lasso_range_scale(s : MlregresslassoRange, f : Double) -> MlregresslassoRange {
  let result = ml_regress_lasso_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_regress_lasso_range_add(a : MlregresslassoRange, b : MlregresslassoRange) -> MlregresslassoRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_regress_lasso_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_regress_lasso_range_copy(s : MlregresslassoRange) -> MlregresslassoRange {
  let result = ml_regress_lasso_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_regress_lasso_range_fill(s : MlregresslassoRange, v : Double) -> MlregresslassoRange {
  let result = ml_regress_lasso_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_regress_lasso_range_min(s : MlregresslassoRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_lasso_range_max(s : MlregresslassoRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_lasso_range_to_string(s : MlregresslassoRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresslassoSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_lasso_slice_make(size : Int) -> MlregresslassoSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_lasso_slice_len(s : MlregresslassoSlice) -> Int { s.size }

pub fn ml_regress_lasso_slice_get(s : MlregresslassoSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_lasso_slice_set(s : MlregresslassoSlice, i : Int, v : Double) -> MlregresslassoSlice {
  let result = ml_regress_lasso_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_lasso_slice_sum(s : MlregresslassoSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_regress_lasso_slice_mean(s : MlregresslassoSlice) -> Double {
  if s.size == 0 { 0.0 } else { ml_regress_lasso_slice_sum(s) / s.size.to_double() }
}

pub fn ml_regress_lasso_slice_scale(s : MlregresslassoSlice, f : Double) -> MlregresslassoSlice {
  let result = ml_regress_lasso_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_regress_lasso_slice_add(a : MlregresslassoSlice, b : MlregresslassoSlice) -> MlregresslassoSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_regress_lasso_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_regress_lasso_slice_copy(s : MlregresslassoSlice) -> MlregresslassoSlice {
  let result = ml_regress_lasso_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_regress_lasso_slice_fill(s : MlregresslassoSlice, v : Double) -> MlregresslassoSlice {
  let result = ml_regress_lasso_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_regress_lasso_slice_min(s : MlregresslassoSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_lasso_slice_max(s : MlregresslassoSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_lasso_slice_to_string(s : MlregresslassoSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


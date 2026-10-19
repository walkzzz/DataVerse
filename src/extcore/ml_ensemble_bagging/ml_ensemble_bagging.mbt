///===
/// extcore/ml_ensemble_bagging

pub(all) struct MlensemblebaggingPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_ensemble_bagging_make_point(x : Double, y : Double) -> MlensemblebaggingPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_ensemble_bagging_make_point3(x : Double, y : Double, z : Double) -> MlensemblebaggingPoint {
  { x, y, z, label: 0 }
}

pub fn ml_ensemble_bagging_point_x(pt : MlensemblebaggingPoint) -> Double { pt.x }

pub fn ml_ensemble_bagging_point_y(pt : MlensemblebaggingPoint) -> Double { pt.y }

pub fn ml_ensemble_bagging_point_z(pt : MlensemblebaggingPoint) -> Double { pt.z }

pub fn ml_ensemble_bagging_point_label(pt : MlensemblebaggingPoint) -> Int { pt.label }

pub fn ml_ensemble_bagging_point_dist(a : MlensemblebaggingPoint, b : MlensemblebaggingPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ml_ensemble_bagging_point_add(a : MlensemblebaggingPoint, b : MlensemblebaggingPoint) -> MlensemblebaggingPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ml_ensemble_bagging_point_sub(a : MlensemblebaggingPoint, b : MlensemblebaggingPoint) -> MlensemblebaggingPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ml_ensemble_bagging_point_scale(pt : MlensemblebaggingPoint, s : Double) -> MlensemblebaggingPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ml_ensemble_bagging_point_dot(a : MlensemblebaggingPoint, b : MlensemblebaggingPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ml_ensemble_bagging_point_cross(a : MlensemblebaggingPoint, b : MlensemblebaggingPoint) -> MlensemblebaggingPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ml_ensemble_bagging_point_norm(pt : MlensemblebaggingPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ml_ensemble_bagging_point_normalize(pt : MlensemblebaggingPoint) -> MlensemblebaggingPoint {
  let n = ml_ensemble_bagging_point_norm(pt)
  if n < 0.0000001 { pt } else { ml_ensemble_bagging_point_scale(pt, 1.0 / n) }
}

pub fn ml_ensemble_bagging_point_negate(pt : MlensemblebaggingPoint) -> MlensemblebaggingPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ml_ensemble_bagging_point_mid(a : MlensemblebaggingPoint, b : MlensemblebaggingPoint) -> MlensemblebaggingPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ml_ensemble_bagging_point_lerp(a : MlensemblebaggingPoint, b : MlensemblebaggingPoint, t : Double) -> MlensemblebaggingPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ml_ensemble_bagging_point_to_string(pt : MlensemblebaggingPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MlensemblebaggingSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_ensemble_bagging_make_series(vals : Array[Double], name : String) -> MlensemblebaggingSeries {
  { vals, name, meta: 0 }
}

pub fn ml_ensemble_bagging_series_len(s : MlensemblebaggingSeries) -> Int { s.vals.length() }

pub fn ml_ensemble_bagging_series_sum(s : MlensemblebaggingSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn ml_ensemble_bagging_series_mean(s : MlensemblebaggingSeries) -> Double {
  let n = ml_ensemble_bagging_series_len(s)
  if n == 0 { 0.0 } else { ml_ensemble_bagging_series_sum(s) / n.to_double() }
}

pub fn ml_ensemble_bagging_series_min(s : MlensemblebaggingSeries) -> Double {
  let n = ml_ensemble_bagging_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn ml_ensemble_bagging_series_max(s : MlensemblebaggingSeries) -> Double {
  let n = ml_ensemble_bagging_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn ml_ensemble_bagging_series_range(s : MlensemblebaggingSeries) -> Double {
  ml_ensemble_bagging_series_max(s) - ml_ensemble_bagging_series_min(s)
}

pub fn ml_ensemble_bagging_series_var(s : MlensemblebaggingSeries) -> Double {
  let n = ml_ensemble_bagging_series_len(s)
  if n == 0 { 0.0 } else {
    let m = ml_ensemble_bagging_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn ml_ensemble_bagging_series_std(s : MlensemblebaggingSeries) -> Double { @_common.sqrt(ml_ensemble_bagging_series_var(s)) }

pub fn ml_ensemble_bagging_series_median(s : MlensemblebaggingSeries) -> Double {
  let n = ml_ensemble_bagging_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = ml_ensemble_bagging_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ml_ensemble_bagging_series_scale(s : MlensemblebaggingSeries, f : Double) -> MlensemblebaggingSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ml_ensemble_bagging_series_add(a : MlensemblebaggingSeries, b : MlensemblebaggingSeries) -> MlensemblebaggingSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ml_ensemble_bagging_series_sub(a : MlensemblebaggingSeries, b : MlensemblebaggingSeries) -> MlensemblebaggingSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ml_ensemble_bagging_series_normalize(s : MlensemblebaggingSeries) -> MlensemblebaggingSeries {
  let mn = ml_ensemble_bagging_series_min(s)
  let mx = ml_ensemble_bagging_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ml_ensemble_bagging_series_cumsum(s : MlensemblebaggingSeries) -> MlensemblebaggingSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn ml_ensemble_bagging_series_to_string(s : MlensemblebaggingSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlensemblebaggingMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_ensemble_bagging_make_matrix(rows : Int, cols : Int, val : Double) -> MlensemblebaggingMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_ensemble_bagging_matrix_identity(n : Int) -> MlensemblebaggingMatrix {
  let m = ml_ensemble_bagging_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ml_ensemble_bagging_matrix_get(m : MlensemblebaggingMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ml_ensemble_bagging_matrix_transpose(m : MlensemblebaggingMatrix) -> MlensemblebaggingMatrix {
  let result = ml_ensemble_bagging_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ml_ensemble_bagging_matrix_add(a : MlensemblebaggingMatrix, b : MlensemblebaggingMatrix) -> MlensemblebaggingMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ml_ensemble_bagging_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ml_ensemble_bagging_matrix_scale(m : MlensemblebaggingMatrix, s : Double) -> MlensemblebaggingMatrix {
  let result = ml_ensemble_bagging_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ml_ensemble_bagging_matrix_multiply(a : MlensemblebaggingMatrix, b : MlensemblebaggingMatrix) -> MlensemblebaggingMatrix {
  if a.cols != b.rows { return ml_ensemble_bagging_make_matrix(a.rows, b.cols, 0.0) }
  let result = ml_ensemble_bagging_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ml_ensemble_bagging_matrix_trace(m : MlensemblebaggingMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ml_ensemble_bagging_matrix_det(m : MlensemblebaggingMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ml_ensemble_bagging_matrix_norm(m : MlensemblebaggingMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ml_ensemble_bagging_matrix_to_string(m : MlensemblebaggingMatrix) -> String {
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

pub(all) struct MlensemblebaggingVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_ensemble_bagging_make_vector(comps : Array[Double]) -> MlensemblebaggingVector {
  { comps, dim: comps.length() }
}

pub fn ml_ensemble_bagging_vector_zero(dim : Int) -> MlensemblebaggingVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ml_ensemble_bagging_vector_add(a : MlensemblebaggingVector, b : MlensemblebaggingVector) -> MlensemblebaggingVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_ensemble_bagging_vector_sub(a : MlensemblebaggingVector, b : MlensemblebaggingVector) -> MlensemblebaggingVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_ensemble_bagging_vector_scale(v : MlensemblebaggingVector, s : Double) -> MlensemblebaggingVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ml_ensemble_bagging_vector_dot(a : MlensemblebaggingVector, b : MlensemblebaggingVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ml_ensemble_bagging_vector_norm(v : MlensemblebaggingVector) -> Double { @_common.sqrt(ml_ensemble_bagging_vector_dot(v, v)) }

pub fn ml_ensemble_bagging_vector_normalize(v : MlensemblebaggingVector) -> MlensemblebaggingVector {
  let n = ml_ensemble_bagging_vector_norm(v)
  if n < 0.0000001 { v } else { ml_ensemble_bagging_vector_scale(v, 1.0 / n) }
}

pub fn ml_ensemble_bagging_vector_dist(a : MlensemblebaggingVector, b : MlensemblebaggingVector) -> Double {
  ml_ensemble_bagging_vector_norm(ml_ensemble_bagging_vector_sub(a, b))
}

pub fn ml_ensemble_bagging_vector_to_string(v : MlensemblebaggingVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_ensemble_bagging_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn ml_ensemble_bagging_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = ml_ensemble_bagging_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ml_ensemble_bagging_std(data : Array[Double]) -> Double { @_common.sqrt(ml_ensemble_bagging_var(data)) }

pub fn ml_ensemble_bagging_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = ml_ensemble_bagging_mean(a); let mb = ml_ensemble_bagging_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn ml_ensemble_bagging_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = ml_ensemble_bagging_std(a); let sb = ml_ensemble_bagging_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { ml_ensemble_bagging_cov(a, b) / (sa * sb) }
}

pub fn ml_ensemble_bagging_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = ml_ensemble_bagging_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ml_ensemble_bagging_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn ml_ensemble_bagging_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ml_ensemble_bagging_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(ml_ensemble_bagging_mse(pred, labels))
}

pub fn ml_ensemble_bagging_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn ml_ensemble_bagging_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = ml_ensemble_bagging_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn ml_ensemble_bagging_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn ml_ensemble_bagging_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn ml_ensemble_bagging_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = ml_ensemble_bagging_precision(pred, labels, pos); let r = ml_ensemble_bagging_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn ml_ensemble_bagging_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn ml_ensemble_bagging_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = ml_ensemble_bagging_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn ml_ensemble_bagging_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn ml_ensemble_bagging_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn ml_ensemble_bagging_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = ml_ensemble_bagging_gcd(a, b)
    (a / g) * b
  }
}

pub fn ml_ensemble_bagging_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn ml_ensemble_bagging_fibonacci(n : Int) -> Int {
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

pub fn ml_ensemble_bagging_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = ml_ensemble_bagging_min(data); let mx = ml_ensemble_bagging_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn ml_ensemble_bagging_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = ml_ensemble_bagging_mean(data); let sd = ml_ensemble_bagging_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn ml_ensemble_bagging_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn ml_ensemble_bagging_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn ml_ensemble_bagging_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn ml_ensemble_bagging_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn ml_ensemble_bagging_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn ml_ensemble_bagging_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct MlensemblebaggingFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_bagging_frame_make(size : Int) -> MlensemblebaggingFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_bagging_frame_len(s : MlensemblebaggingFrame) -> Int { s.size }

pub fn ml_ensemble_bagging_frame_get(s : MlensemblebaggingFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_bagging_frame_set(s : MlensemblebaggingFrame, i : Int, v : Double) -> MlensemblebaggingFrame {
  let result = ml_ensemble_bagging_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_bagging_frame_sum(s : MlensemblebaggingFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_bagging_frame_mean(s : MlensemblebaggingFrame) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_bagging_frame_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_bagging_frame_scale(s : MlensemblebaggingFrame, f : Double) -> MlensemblebaggingFrame {
  let result = ml_ensemble_bagging_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_bagging_frame_add(a : MlensemblebaggingFrame, b : MlensemblebaggingFrame) -> MlensemblebaggingFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_bagging_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_bagging_frame_copy(s : MlensemblebaggingFrame) -> MlensemblebaggingFrame {
  let result = ml_ensemble_bagging_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_bagging_frame_fill(s : MlensemblebaggingFrame, v : Double) -> MlensemblebaggingFrame {
  let result = ml_ensemble_bagging_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_bagging_frame_min(s : MlensemblebaggingFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_bagging_frame_max(s : MlensemblebaggingFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_bagging_frame_to_string(s : MlensemblebaggingFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblebaggingTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_bagging_table_make(size : Int) -> MlensemblebaggingTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_bagging_table_len(s : MlensemblebaggingTable) -> Int { s.size }

pub fn ml_ensemble_bagging_table_get(s : MlensemblebaggingTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_bagging_table_set(s : MlensemblebaggingTable, i : Int, v : Double) -> MlensemblebaggingTable {
  let result = ml_ensemble_bagging_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_bagging_table_sum(s : MlensemblebaggingTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_bagging_table_mean(s : MlensemblebaggingTable) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_bagging_table_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_bagging_table_scale(s : MlensemblebaggingTable, f : Double) -> MlensemblebaggingTable {
  let result = ml_ensemble_bagging_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_bagging_table_add(a : MlensemblebaggingTable, b : MlensemblebaggingTable) -> MlensemblebaggingTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_bagging_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_bagging_table_copy(s : MlensemblebaggingTable) -> MlensemblebaggingTable {
  let result = ml_ensemble_bagging_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_bagging_table_fill(s : MlensemblebaggingTable, v : Double) -> MlensemblebaggingTable {
  let result = ml_ensemble_bagging_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_bagging_table_min(s : MlensemblebaggingTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_bagging_table_max(s : MlensemblebaggingTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_bagging_table_to_string(s : MlensemblebaggingTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblebaggingGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_bagging_graphn_make(size : Int) -> MlensemblebaggingGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_bagging_graphn_len(s : MlensemblebaggingGraphN) -> Int { s.size }

pub fn ml_ensemble_bagging_graphn_get(s : MlensemblebaggingGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_bagging_graphn_set(s : MlensemblebaggingGraphN, i : Int, v : Double) -> MlensemblebaggingGraphN {
  let result = ml_ensemble_bagging_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_bagging_graphn_sum(s : MlensemblebaggingGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_bagging_graphn_mean(s : MlensemblebaggingGraphN) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_bagging_graphn_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_bagging_graphn_scale(s : MlensemblebaggingGraphN, f : Double) -> MlensemblebaggingGraphN {
  let result = ml_ensemble_bagging_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_bagging_graphn_add(a : MlensemblebaggingGraphN, b : MlensemblebaggingGraphN) -> MlensemblebaggingGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_bagging_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_bagging_graphn_copy(s : MlensemblebaggingGraphN) -> MlensemblebaggingGraphN {
  let result = ml_ensemble_bagging_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_bagging_graphn_fill(s : MlensemblebaggingGraphN, v : Double) -> MlensemblebaggingGraphN {
  let result = ml_ensemble_bagging_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_bagging_graphn_min(s : MlensemblebaggingGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_bagging_graphn_max(s : MlensemblebaggingGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_bagging_graphn_to_string(s : MlensemblebaggingGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblebaggingNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_bagging_node_make(size : Int) -> MlensemblebaggingNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_bagging_node_len(s : MlensemblebaggingNode) -> Int { s.size }

pub fn ml_ensemble_bagging_node_get(s : MlensemblebaggingNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_bagging_node_set(s : MlensemblebaggingNode, i : Int, v : Double) -> MlensemblebaggingNode {
  let result = ml_ensemble_bagging_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_bagging_node_sum(s : MlensemblebaggingNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_bagging_node_mean(s : MlensemblebaggingNode) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_bagging_node_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_bagging_node_scale(s : MlensemblebaggingNode, f : Double) -> MlensemblebaggingNode {
  let result = ml_ensemble_bagging_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_bagging_node_add(a : MlensemblebaggingNode, b : MlensemblebaggingNode) -> MlensemblebaggingNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_bagging_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_bagging_node_copy(s : MlensemblebaggingNode) -> MlensemblebaggingNode {
  let result = ml_ensemble_bagging_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_bagging_node_fill(s : MlensemblebaggingNode, v : Double) -> MlensemblebaggingNode {
  let result = ml_ensemble_bagging_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_bagging_node_min(s : MlensemblebaggingNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_bagging_node_max(s : MlensemblebaggingNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_bagging_node_to_string(s : MlensemblebaggingNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblebaggingEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_bagging_edge_make(size : Int) -> MlensemblebaggingEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_bagging_edge_len(s : MlensemblebaggingEdge) -> Int { s.size }

pub fn ml_ensemble_bagging_edge_get(s : MlensemblebaggingEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_bagging_edge_set(s : MlensemblebaggingEdge, i : Int, v : Double) -> MlensemblebaggingEdge {
  let result = ml_ensemble_bagging_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_bagging_edge_sum(s : MlensemblebaggingEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_bagging_edge_mean(s : MlensemblebaggingEdge) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_bagging_edge_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_bagging_edge_scale(s : MlensemblebaggingEdge, f : Double) -> MlensemblebaggingEdge {
  let result = ml_ensemble_bagging_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_bagging_edge_add(a : MlensemblebaggingEdge, b : MlensemblebaggingEdge) -> MlensemblebaggingEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_bagging_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_bagging_edge_copy(s : MlensemblebaggingEdge) -> MlensemblebaggingEdge {
  let result = ml_ensemble_bagging_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_bagging_edge_fill(s : MlensemblebaggingEdge, v : Double) -> MlensemblebaggingEdge {
  let result = ml_ensemble_bagging_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_bagging_edge_min(s : MlensemblebaggingEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_bagging_edge_max(s : MlensemblebaggingEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_bagging_edge_to_string(s : MlensemblebaggingEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblebaggingPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_bagging_path_make(size : Int) -> MlensemblebaggingPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_bagging_path_len(s : MlensemblebaggingPath) -> Int { s.size }

pub fn ml_ensemble_bagging_path_get(s : MlensemblebaggingPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_bagging_path_set(s : MlensemblebaggingPath, i : Int, v : Double) -> MlensemblebaggingPath {
  let result = ml_ensemble_bagging_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_bagging_path_sum(s : MlensemblebaggingPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_bagging_path_mean(s : MlensemblebaggingPath) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_bagging_path_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_bagging_path_scale(s : MlensemblebaggingPath, f : Double) -> MlensemblebaggingPath {
  let result = ml_ensemble_bagging_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_bagging_path_add(a : MlensemblebaggingPath, b : MlensemblebaggingPath) -> MlensemblebaggingPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_bagging_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_bagging_path_copy(s : MlensemblebaggingPath) -> MlensemblebaggingPath {
  let result = ml_ensemble_bagging_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_bagging_path_fill(s : MlensemblebaggingPath, v : Double) -> MlensemblebaggingPath {
  let result = ml_ensemble_bagging_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_bagging_path_min(s : MlensemblebaggingPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_bagging_path_max(s : MlensemblebaggingPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_bagging_path_to_string(s : MlensemblebaggingPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblebaggingCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_bagging_cluster_make(size : Int) -> MlensemblebaggingCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_bagging_cluster_len(s : MlensemblebaggingCluster) -> Int { s.size }

pub fn ml_ensemble_bagging_cluster_get(s : MlensemblebaggingCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_bagging_cluster_set(s : MlensemblebaggingCluster, i : Int, v : Double) -> MlensemblebaggingCluster {
  let result = ml_ensemble_bagging_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_bagging_cluster_sum(s : MlensemblebaggingCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_bagging_cluster_mean(s : MlensemblebaggingCluster) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_bagging_cluster_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_bagging_cluster_scale(s : MlensemblebaggingCluster, f : Double) -> MlensemblebaggingCluster {
  let result = ml_ensemble_bagging_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_bagging_cluster_add(a : MlensemblebaggingCluster, b : MlensemblebaggingCluster) -> MlensemblebaggingCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_bagging_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_bagging_cluster_copy(s : MlensemblebaggingCluster) -> MlensemblebaggingCluster {
  let result = ml_ensemble_bagging_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_bagging_cluster_fill(s : MlensemblebaggingCluster, v : Double) -> MlensemblebaggingCluster {
  let result = ml_ensemble_bagging_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_bagging_cluster_min(s : MlensemblebaggingCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_bagging_cluster_max(s : MlensemblebaggingCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_bagging_cluster_to_string(s : MlensemblebaggingCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblebaggingModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_bagging_model_make(size : Int) -> MlensemblebaggingModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_bagging_model_len(s : MlensemblebaggingModel) -> Int { s.size }

pub fn ml_ensemble_bagging_model_get(s : MlensemblebaggingModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_bagging_model_set(s : MlensemblebaggingModel, i : Int, v : Double) -> MlensemblebaggingModel {
  let result = ml_ensemble_bagging_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_bagging_model_sum(s : MlensemblebaggingModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_bagging_model_mean(s : MlensemblebaggingModel) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_bagging_model_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_bagging_model_scale(s : MlensemblebaggingModel, f : Double) -> MlensemblebaggingModel {
  let result = ml_ensemble_bagging_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_bagging_model_add(a : MlensemblebaggingModel, b : MlensemblebaggingModel) -> MlensemblebaggingModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_bagging_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_bagging_model_copy(s : MlensemblebaggingModel) -> MlensemblebaggingModel {
  let result = ml_ensemble_bagging_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_bagging_model_fill(s : MlensemblebaggingModel, v : Double) -> MlensemblebaggingModel {
  let result = ml_ensemble_bagging_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_bagging_model_min(s : MlensemblebaggingModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_bagging_model_max(s : MlensemblebaggingModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_bagging_model_to_string(s : MlensemblebaggingModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblebaggingLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_bagging_layer_make(size : Int) -> MlensemblebaggingLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_bagging_layer_len(s : MlensemblebaggingLayer) -> Int { s.size }

pub fn ml_ensemble_bagging_layer_get(s : MlensemblebaggingLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_bagging_layer_set(s : MlensemblebaggingLayer, i : Int, v : Double) -> MlensemblebaggingLayer {
  let result = ml_ensemble_bagging_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_bagging_layer_sum(s : MlensemblebaggingLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_bagging_layer_mean(s : MlensemblebaggingLayer) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_bagging_layer_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_bagging_layer_scale(s : MlensemblebaggingLayer, f : Double) -> MlensemblebaggingLayer {
  let result = ml_ensemble_bagging_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_bagging_layer_add(a : MlensemblebaggingLayer, b : MlensemblebaggingLayer) -> MlensemblebaggingLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_bagging_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_bagging_layer_copy(s : MlensemblebaggingLayer) -> MlensemblebaggingLayer {
  let result = ml_ensemble_bagging_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_bagging_layer_fill(s : MlensemblebaggingLayer, v : Double) -> MlensemblebaggingLayer {
  let result = ml_ensemble_bagging_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_bagging_layer_min(s : MlensemblebaggingLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_bagging_layer_max(s : MlensemblebaggingLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_bagging_layer_to_string(s : MlensemblebaggingLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblebaggingBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_bagging_buffer_make(size : Int) -> MlensemblebaggingBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_bagging_buffer_len(s : MlensemblebaggingBuffer) -> Int { s.size }

pub fn ml_ensemble_bagging_buffer_get(s : MlensemblebaggingBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_bagging_buffer_set(s : MlensemblebaggingBuffer, i : Int, v : Double) -> MlensemblebaggingBuffer {
  let result = ml_ensemble_bagging_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_bagging_buffer_sum(s : MlensemblebaggingBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_bagging_buffer_mean(s : MlensemblebaggingBuffer) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_bagging_buffer_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_bagging_buffer_scale(s : MlensemblebaggingBuffer, f : Double) -> MlensemblebaggingBuffer {
  let result = ml_ensemble_bagging_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_bagging_buffer_add(a : MlensemblebaggingBuffer, b : MlensemblebaggingBuffer) -> MlensemblebaggingBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_bagging_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_bagging_buffer_copy(s : MlensemblebaggingBuffer) -> MlensemblebaggingBuffer {
  let result = ml_ensemble_bagging_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_bagging_buffer_fill(s : MlensemblebaggingBuffer, v : Double) -> MlensemblebaggingBuffer {
  let result = ml_ensemble_bagging_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_bagging_buffer_min(s : MlensemblebaggingBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_bagging_buffer_max(s : MlensemblebaggingBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_bagging_buffer_to_string(s : MlensemblebaggingBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblebaggingCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_bagging_cursor_make(size : Int) -> MlensemblebaggingCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_bagging_cursor_len(s : MlensemblebaggingCursor) -> Int { s.size }

pub fn ml_ensemble_bagging_cursor_get(s : MlensemblebaggingCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_bagging_cursor_set(s : MlensemblebaggingCursor, i : Int, v : Double) -> MlensemblebaggingCursor {
  let result = ml_ensemble_bagging_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_bagging_cursor_sum(s : MlensemblebaggingCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_bagging_cursor_mean(s : MlensemblebaggingCursor) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_bagging_cursor_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_bagging_cursor_scale(s : MlensemblebaggingCursor, f : Double) -> MlensemblebaggingCursor {
  let result = ml_ensemble_bagging_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_bagging_cursor_add(a : MlensemblebaggingCursor, b : MlensemblebaggingCursor) -> MlensemblebaggingCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_bagging_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_bagging_cursor_copy(s : MlensemblebaggingCursor) -> MlensemblebaggingCursor {
  let result = ml_ensemble_bagging_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_bagging_cursor_fill(s : MlensemblebaggingCursor, v : Double) -> MlensemblebaggingCursor {
  let result = ml_ensemble_bagging_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_bagging_cursor_min(s : MlensemblebaggingCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_bagging_cursor_max(s : MlensemblebaggingCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_bagging_cursor_to_string(s : MlensemblebaggingCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblebaggingView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_bagging_view_make(size : Int) -> MlensemblebaggingView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_bagging_view_len(s : MlensemblebaggingView) -> Int { s.size }

pub fn ml_ensemble_bagging_view_get(s : MlensemblebaggingView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_bagging_view_set(s : MlensemblebaggingView, i : Int, v : Double) -> MlensemblebaggingView {
  let result = ml_ensemble_bagging_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_bagging_view_sum(s : MlensemblebaggingView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_bagging_view_mean(s : MlensemblebaggingView) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_bagging_view_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_bagging_view_scale(s : MlensemblebaggingView, f : Double) -> MlensemblebaggingView {
  let result = ml_ensemble_bagging_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_bagging_view_add(a : MlensemblebaggingView, b : MlensemblebaggingView) -> MlensemblebaggingView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_bagging_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_bagging_view_copy(s : MlensemblebaggingView) -> MlensemblebaggingView {
  let result = ml_ensemble_bagging_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_bagging_view_fill(s : MlensemblebaggingView, v : Double) -> MlensemblebaggingView {
  let result = ml_ensemble_bagging_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_bagging_view_min(s : MlensemblebaggingView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_bagging_view_max(s : MlensemblebaggingView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_bagging_view_to_string(s : MlensemblebaggingView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblebaggingRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_bagging_range_make(size : Int) -> MlensemblebaggingRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_bagging_range_len(s : MlensemblebaggingRange) -> Int { s.size }

pub fn ml_ensemble_bagging_range_get(s : MlensemblebaggingRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_bagging_range_set(s : MlensemblebaggingRange, i : Int, v : Double) -> MlensemblebaggingRange {
  let result = ml_ensemble_bagging_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_bagging_range_sum(s : MlensemblebaggingRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_bagging_range_mean(s : MlensemblebaggingRange) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_bagging_range_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_bagging_range_scale(s : MlensemblebaggingRange, f : Double) -> MlensemblebaggingRange {
  let result = ml_ensemble_bagging_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_bagging_range_add(a : MlensemblebaggingRange, b : MlensemblebaggingRange) -> MlensemblebaggingRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_bagging_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_bagging_range_copy(s : MlensemblebaggingRange) -> MlensemblebaggingRange {
  let result = ml_ensemble_bagging_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_bagging_range_fill(s : MlensemblebaggingRange, v : Double) -> MlensemblebaggingRange {
  let result = ml_ensemble_bagging_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_bagging_range_min(s : MlensemblebaggingRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_bagging_range_max(s : MlensemblebaggingRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_bagging_range_to_string(s : MlensemblebaggingRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblebaggingSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_bagging_slice_make(size : Int) -> MlensemblebaggingSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_bagging_slice_len(s : MlensemblebaggingSlice) -> Int { s.size }

pub fn ml_ensemble_bagging_slice_get(s : MlensemblebaggingSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_bagging_slice_set(s : MlensemblebaggingSlice, i : Int, v : Double) -> MlensemblebaggingSlice {
  let result = ml_ensemble_bagging_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_bagging_slice_sum(s : MlensemblebaggingSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_bagging_slice_mean(s : MlensemblebaggingSlice) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_bagging_slice_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_bagging_slice_scale(s : MlensemblebaggingSlice, f : Double) -> MlensemblebaggingSlice {
  let result = ml_ensemble_bagging_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_bagging_slice_add(a : MlensemblebaggingSlice, b : MlensemblebaggingSlice) -> MlensemblebaggingSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_bagging_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_bagging_slice_copy(s : MlensemblebaggingSlice) -> MlensemblebaggingSlice {
  let result = ml_ensemble_bagging_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_bagging_slice_fill(s : MlensemblebaggingSlice, v : Double) -> MlensemblebaggingSlice {
  let result = ml_ensemble_bagging_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_bagging_slice_min(s : MlensemblebaggingSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_bagging_slice_max(s : MlensemblebaggingSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_bagging_slice_to_string(s : MlensemblebaggingSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


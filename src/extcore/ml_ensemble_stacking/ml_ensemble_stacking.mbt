///===
/// extcore/ml_ensemble_stacking

pub(all) struct MlensemblestackingPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_ensemble_stacking_make_point(x : Double, y : Double) -> MlensemblestackingPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_ensemble_stacking_make_point3(x : Double, y : Double, z : Double) -> MlensemblestackingPoint {
  { x, y, z, label: 0 }
}

pub fn ml_ensemble_stacking_point_x(pt : MlensemblestackingPoint) -> Double { pt.x }

pub fn ml_ensemble_stacking_point_y(pt : MlensemblestackingPoint) -> Double { pt.y }

pub fn ml_ensemble_stacking_point_z(pt : MlensemblestackingPoint) -> Double { pt.z }

pub fn ml_ensemble_stacking_point_label(pt : MlensemblestackingPoint) -> Int { pt.label }

pub fn ml_ensemble_stacking_point_dist(a : MlensemblestackingPoint, b : MlensemblestackingPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  ml_ensemble_stacking_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ml_ensemble_stacking_point_add(a : MlensemblestackingPoint, b : MlensemblestackingPoint) -> MlensemblestackingPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ml_ensemble_stacking_point_sub(a : MlensemblestackingPoint, b : MlensemblestackingPoint) -> MlensemblestackingPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ml_ensemble_stacking_point_scale(pt : MlensemblestackingPoint, s : Double) -> MlensemblestackingPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ml_ensemble_stacking_point_dot(a : MlensemblestackingPoint, b : MlensemblestackingPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ml_ensemble_stacking_point_cross(a : MlensemblestackingPoint, b : MlensemblestackingPoint) -> MlensemblestackingPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ml_ensemble_stacking_point_norm(pt : MlensemblestackingPoint) -> Double {
  ml_ensemble_stacking_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ml_ensemble_stacking_point_normalize(pt : MlensemblestackingPoint) -> MlensemblestackingPoint {
  let n = ml_ensemble_stacking_point_norm(pt)
  if n < 0.0000001 { pt } else { ml_ensemble_stacking_point_scale(pt, 1.0 / n) }
}

pub fn ml_ensemble_stacking_point_negate(pt : MlensemblestackingPoint) -> MlensemblestackingPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ml_ensemble_stacking_point_mid(a : MlensemblestackingPoint, b : MlensemblestackingPoint) -> MlensemblestackingPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ml_ensemble_stacking_point_lerp(a : MlensemblestackingPoint, b : MlensemblestackingPoint, t : Double) -> MlensemblestackingPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ml_ensemble_stacking_point_to_string(pt : MlensemblestackingPoint) -> String {
  "(" + ml_ensemble_stacking_dbl(pt.x) + ", " + ml_ensemble_stacking_dbl(pt.y) + ", " + ml_ensemble_stacking_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MlensemblestackingSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_ensemble_stacking_make_series(vals : Array[Double], name : String) -> MlensemblestackingSeries {
  { vals, name, meta: 0 }
}

pub fn ml_ensemble_stacking_series_len(s : MlensemblestackingSeries) -> Int { s.vals.length() }

pub fn ml_ensemble_stacking_series_sum(s : MlensemblestackingSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn ml_ensemble_stacking_series_mean(s : MlensemblestackingSeries) -> Double {
  let n = ml_ensemble_stacking_series_len(s)
  if n == 0 { 0.0 } else { ml_ensemble_stacking_series_sum(s) / n.to_double() }
}

pub fn ml_ensemble_stacking_series_min(s : MlensemblestackingSeries) -> Double {
  let n = ml_ensemble_stacking_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn ml_ensemble_stacking_series_max(s : MlensemblestackingSeries) -> Double {
  let n = ml_ensemble_stacking_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn ml_ensemble_stacking_series_range(s : MlensemblestackingSeries) -> Double {
  ml_ensemble_stacking_series_max(s) - ml_ensemble_stacking_series_min(s)
}

pub fn ml_ensemble_stacking_series_var(s : MlensemblestackingSeries) -> Double {
  let n = ml_ensemble_stacking_series_len(s)
  if n == 0 { 0.0 } else {
    let m = ml_ensemble_stacking_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn ml_ensemble_stacking_series_std(s : MlensemblestackingSeries) -> Double { ml_ensemble_stacking_sqrt(ml_ensemble_stacking_series_var(s)) }

pub fn ml_ensemble_stacking_series_median(s : MlensemblestackingSeries) -> Double {
  let n = ml_ensemble_stacking_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = ml_ensemble_stacking_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ml_ensemble_stacking_series_scale(s : MlensemblestackingSeries, f : Double) -> MlensemblestackingSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = ml_ensemble_stacking_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ml_ensemble_stacking_series_add(a : MlensemblestackingSeries, b : MlensemblestackingSeries) -> MlensemblestackingSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = ml_ensemble_stacking_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ml_ensemble_stacking_series_sub(a : MlensemblestackingSeries, b : MlensemblestackingSeries) -> MlensemblestackingSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = ml_ensemble_stacking_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ml_ensemble_stacking_series_normalize(s : MlensemblestackingSeries) -> MlensemblestackingSeries {
  let mn = ml_ensemble_stacking_series_min(s)
  let mx = ml_ensemble_stacking_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = ml_ensemble_stacking_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ml_ensemble_stacking_series_cumsum(s : MlensemblestackingSeries) -> MlensemblestackingSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = ml_ensemble_stacking_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn ml_ensemble_stacking_series_to_string(s : MlensemblestackingSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + ml_ensemble_stacking_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlensemblestackingMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_ensemble_stacking_make_matrix(rows : Int, cols : Int, val : Double) -> MlensemblestackingMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_ensemble_stacking_matrix_identity(n : Int) -> MlensemblestackingMatrix {
  let m = ml_ensemble_stacking_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ml_ensemble_stacking_matrix_get(m : MlensemblestackingMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ml_ensemble_stacking_matrix_transpose(m : MlensemblestackingMatrix) -> MlensemblestackingMatrix {
  let result = ml_ensemble_stacking_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ml_ensemble_stacking_matrix_add(a : MlensemblestackingMatrix, b : MlensemblestackingMatrix) -> MlensemblestackingMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ml_ensemble_stacking_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ml_ensemble_stacking_matrix_scale(m : MlensemblestackingMatrix, s : Double) -> MlensemblestackingMatrix {
  let result = ml_ensemble_stacking_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ml_ensemble_stacking_matrix_multiply(a : MlensemblestackingMatrix, b : MlensemblestackingMatrix) -> MlensemblestackingMatrix {
  if a.cols != b.rows { return ml_ensemble_stacking_make_matrix(a.rows, b.cols, 0.0) }
  let result = ml_ensemble_stacking_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ml_ensemble_stacking_matrix_trace(m : MlensemblestackingMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ml_ensemble_stacking_matrix_det(m : MlensemblestackingMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ml_ensemble_stacking_matrix_norm(m : MlensemblestackingMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  ml_ensemble_stacking_sqrt(sum)
}

pub fn ml_ensemble_stacking_matrix_to_string(m : MlensemblestackingMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + ml_ensemble_stacking_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct MlensemblestackingVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_ensemble_stacking_make_vector(comps : Array[Double]) -> MlensemblestackingVector {
  { comps, dim: comps.length() }
}

pub fn ml_ensemble_stacking_vector_zero(dim : Int) -> MlensemblestackingVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ml_ensemble_stacking_vector_add(a : MlensemblestackingVector, b : MlensemblestackingVector) -> MlensemblestackingVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = ml_ensemble_stacking_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_ensemble_stacking_vector_sub(a : MlensemblestackingVector, b : MlensemblestackingVector) -> MlensemblestackingVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = ml_ensemble_stacking_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_ensemble_stacking_vector_scale(v : MlensemblestackingVector, s : Double) -> MlensemblestackingVector {
  let mut result = []
  for i in 0..<v.dim { result = ml_ensemble_stacking_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ml_ensemble_stacking_vector_dot(a : MlensemblestackingVector, b : MlensemblestackingVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ml_ensemble_stacking_vector_norm(v : MlensemblestackingVector) -> Double { ml_ensemble_stacking_sqrt(ml_ensemble_stacking_vector_dot(v, v)) }

pub fn ml_ensemble_stacking_vector_normalize(v : MlensemblestackingVector) -> MlensemblestackingVector {
  let n = ml_ensemble_stacking_vector_norm(v)
  if n < 0.0000001 { v } else { ml_ensemble_stacking_vector_scale(v, 1.0 / n) }
}

pub fn ml_ensemble_stacking_vector_dist(a : MlensemblestackingVector, b : MlensemblestackingVector) -> Double {
  ml_ensemble_stacking_vector_norm(ml_ensemble_stacking_vector_sub(a, b))
}

pub fn ml_ensemble_stacking_vector_to_string(v : MlensemblestackingVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + ml_ensemble_stacking_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_ensemble_stacking_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn ml_ensemble_stacking_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = ml_ensemble_stacking_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ml_ensemble_stacking_std(data : Array[Double]) -> Double { ml_ensemble_stacking_sqrt(ml_ensemble_stacking_var(data)) }

pub fn ml_ensemble_stacking_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = ml_ensemble_stacking_mean(a); let mb = ml_ensemble_stacking_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn ml_ensemble_stacking_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = ml_ensemble_stacking_std(a); let sb = ml_ensemble_stacking_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { ml_ensemble_stacking_cov(a, b) / (sa * sb) }
}

pub fn ml_ensemble_stacking_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = ml_ensemble_stacking_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ml_ensemble_stacking_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn ml_ensemble_stacking_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ml_ensemble_stacking_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  ml_ensemble_stacking_sqrt(ml_ensemble_stacking_mse(pred, labels))
}

pub fn ml_ensemble_stacking_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + ml_ensemble_stacking_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn ml_ensemble_stacking_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = ml_ensemble_stacking_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn ml_ensemble_stacking_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn ml_ensemble_stacking_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn ml_ensemble_stacking_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = ml_ensemble_stacking_precision(pred, labels, pos); let r = ml_ensemble_stacking_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn ml_ensemble_stacking_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn ml_ensemble_stacking_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = ml_ensemble_stacking_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn ml_ensemble_stacking_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn ml_ensemble_stacking_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn ml_ensemble_stacking_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = ml_ensemble_stacking_gcd(a, b)
    (a / g) * b
  }
}

pub fn ml_ensemble_stacking_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn ml_ensemble_stacking_fibonacci(n : Int) -> Int {
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

pub fn ml_ensemble_stacking_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = ml_ensemble_stacking_min(data); let mx = ml_ensemble_stacking_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn ml_ensemble_stacking_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = ml_ensemble_stacking_mean(data); let sd = ml_ensemble_stacking_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn ml_ensemble_stacking_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn ml_ensemble_stacking_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn ml_ensemble_stacking_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn ml_ensemble_stacking_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn ml_ensemble_stacking_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn ml_ensemble_stacking_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn ml_ensemble_stacking_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn ml_ensemble_stacking_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn ml_ensemble_stacking_dbl(x : Double) -> String {
  let i = if x >= 0.0 { ml_ensemble_stacking_int(x) } else { -ml_ensemble_stacking_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { ml_ensemble_stacking_int(f * 1000000.0) } else { ml_ensemble_stacking_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn ml_ensemble_stacking_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn ml_ensemble_stacking_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct MlensemblestackingFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_stacking_frame_make(size : Int) -> MlensemblestackingFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_stacking_frame_len(s : MlensemblestackingFrame) -> Int { s.size }

pub fn ml_ensemble_stacking_frame_get(s : MlensemblestackingFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_stacking_frame_set(s : MlensemblestackingFrame, i : Int, v : Double) -> MlensemblestackingFrame {
  let result = ml_ensemble_stacking_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_stacking_frame_sum(s : MlensemblestackingFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_stacking_frame_mean(s : MlensemblestackingFrame) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_stacking_frame_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_stacking_frame_scale(s : MlensemblestackingFrame, f : Double) -> MlensemblestackingFrame {
  let result = ml_ensemble_stacking_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_stacking_frame_add(a : MlensemblestackingFrame, b : MlensemblestackingFrame) -> MlensemblestackingFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_stacking_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_stacking_frame_copy(s : MlensemblestackingFrame) -> MlensemblestackingFrame {
  let result = ml_ensemble_stacking_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_stacking_frame_fill(s : MlensemblestackingFrame, v : Double) -> MlensemblestackingFrame {
  let result = ml_ensemble_stacking_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_stacking_frame_min(s : MlensemblestackingFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_stacking_frame_max(s : MlensemblestackingFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_stacking_frame_to_string(s : MlensemblestackingFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblestackingTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_stacking_table_make(size : Int) -> MlensemblestackingTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_stacking_table_len(s : MlensemblestackingTable) -> Int { s.size }

pub fn ml_ensemble_stacking_table_get(s : MlensemblestackingTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_stacking_table_set(s : MlensemblestackingTable, i : Int, v : Double) -> MlensemblestackingTable {
  let result = ml_ensemble_stacking_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_stacking_table_sum(s : MlensemblestackingTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_stacking_table_mean(s : MlensemblestackingTable) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_stacking_table_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_stacking_table_scale(s : MlensemblestackingTable, f : Double) -> MlensemblestackingTable {
  let result = ml_ensemble_stacking_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_stacking_table_add(a : MlensemblestackingTable, b : MlensemblestackingTable) -> MlensemblestackingTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_stacking_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_stacking_table_copy(s : MlensemblestackingTable) -> MlensemblestackingTable {
  let result = ml_ensemble_stacking_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_stacking_table_fill(s : MlensemblestackingTable, v : Double) -> MlensemblestackingTable {
  let result = ml_ensemble_stacking_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_stacking_table_min(s : MlensemblestackingTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_stacking_table_max(s : MlensemblestackingTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_stacking_table_to_string(s : MlensemblestackingTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblestackingGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_stacking_graphn_make(size : Int) -> MlensemblestackingGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_stacking_graphn_len(s : MlensemblestackingGraphN) -> Int { s.size }

pub fn ml_ensemble_stacking_graphn_get(s : MlensemblestackingGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_stacking_graphn_set(s : MlensemblestackingGraphN, i : Int, v : Double) -> MlensemblestackingGraphN {
  let result = ml_ensemble_stacking_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_stacking_graphn_sum(s : MlensemblestackingGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_stacking_graphn_mean(s : MlensemblestackingGraphN) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_stacking_graphn_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_stacking_graphn_scale(s : MlensemblestackingGraphN, f : Double) -> MlensemblestackingGraphN {
  let result = ml_ensemble_stacking_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_stacking_graphn_add(a : MlensemblestackingGraphN, b : MlensemblestackingGraphN) -> MlensemblestackingGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_stacking_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_stacking_graphn_copy(s : MlensemblestackingGraphN) -> MlensemblestackingGraphN {
  let result = ml_ensemble_stacking_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_stacking_graphn_fill(s : MlensemblestackingGraphN, v : Double) -> MlensemblestackingGraphN {
  let result = ml_ensemble_stacking_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_stacking_graphn_min(s : MlensemblestackingGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_stacking_graphn_max(s : MlensemblestackingGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_stacking_graphn_to_string(s : MlensemblestackingGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblestackingNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_stacking_node_make(size : Int) -> MlensemblestackingNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_stacking_node_len(s : MlensemblestackingNode) -> Int { s.size }

pub fn ml_ensemble_stacking_node_get(s : MlensemblestackingNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_stacking_node_set(s : MlensemblestackingNode, i : Int, v : Double) -> MlensemblestackingNode {
  let result = ml_ensemble_stacking_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_stacking_node_sum(s : MlensemblestackingNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_stacking_node_mean(s : MlensemblestackingNode) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_stacking_node_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_stacking_node_scale(s : MlensemblestackingNode, f : Double) -> MlensemblestackingNode {
  let result = ml_ensemble_stacking_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_stacking_node_add(a : MlensemblestackingNode, b : MlensemblestackingNode) -> MlensemblestackingNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_stacking_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_stacking_node_copy(s : MlensemblestackingNode) -> MlensemblestackingNode {
  let result = ml_ensemble_stacking_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_stacking_node_fill(s : MlensemblestackingNode, v : Double) -> MlensemblestackingNode {
  let result = ml_ensemble_stacking_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_stacking_node_min(s : MlensemblestackingNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_stacking_node_max(s : MlensemblestackingNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_stacking_node_to_string(s : MlensemblestackingNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblestackingEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_stacking_edge_make(size : Int) -> MlensemblestackingEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_stacking_edge_len(s : MlensemblestackingEdge) -> Int { s.size }

pub fn ml_ensemble_stacking_edge_get(s : MlensemblestackingEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_stacking_edge_set(s : MlensemblestackingEdge, i : Int, v : Double) -> MlensemblestackingEdge {
  let result = ml_ensemble_stacking_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_stacking_edge_sum(s : MlensemblestackingEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_stacking_edge_mean(s : MlensemblestackingEdge) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_stacking_edge_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_stacking_edge_scale(s : MlensemblestackingEdge, f : Double) -> MlensemblestackingEdge {
  let result = ml_ensemble_stacking_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_stacking_edge_add(a : MlensemblestackingEdge, b : MlensemblestackingEdge) -> MlensemblestackingEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_stacking_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_stacking_edge_copy(s : MlensemblestackingEdge) -> MlensemblestackingEdge {
  let result = ml_ensemble_stacking_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_stacking_edge_fill(s : MlensemblestackingEdge, v : Double) -> MlensemblestackingEdge {
  let result = ml_ensemble_stacking_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_stacking_edge_min(s : MlensemblestackingEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_stacking_edge_max(s : MlensemblestackingEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_stacking_edge_to_string(s : MlensemblestackingEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblestackingPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_stacking_path_make(size : Int) -> MlensemblestackingPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_stacking_path_len(s : MlensemblestackingPath) -> Int { s.size }

pub fn ml_ensemble_stacking_path_get(s : MlensemblestackingPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_stacking_path_set(s : MlensemblestackingPath, i : Int, v : Double) -> MlensemblestackingPath {
  let result = ml_ensemble_stacking_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_stacking_path_sum(s : MlensemblestackingPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_stacking_path_mean(s : MlensemblestackingPath) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_stacking_path_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_stacking_path_scale(s : MlensemblestackingPath, f : Double) -> MlensemblestackingPath {
  let result = ml_ensemble_stacking_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_stacking_path_add(a : MlensemblestackingPath, b : MlensemblestackingPath) -> MlensemblestackingPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_stacking_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_stacking_path_copy(s : MlensemblestackingPath) -> MlensemblestackingPath {
  let result = ml_ensemble_stacking_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_stacking_path_fill(s : MlensemblestackingPath, v : Double) -> MlensemblestackingPath {
  let result = ml_ensemble_stacking_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_stacking_path_min(s : MlensemblestackingPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_stacking_path_max(s : MlensemblestackingPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_stacking_path_to_string(s : MlensemblestackingPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblestackingCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_stacking_cluster_make(size : Int) -> MlensemblestackingCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_stacking_cluster_len(s : MlensemblestackingCluster) -> Int { s.size }

pub fn ml_ensemble_stacking_cluster_get(s : MlensemblestackingCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_stacking_cluster_set(s : MlensemblestackingCluster, i : Int, v : Double) -> MlensemblestackingCluster {
  let result = ml_ensemble_stacking_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_stacking_cluster_sum(s : MlensemblestackingCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_stacking_cluster_mean(s : MlensemblestackingCluster) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_stacking_cluster_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_stacking_cluster_scale(s : MlensemblestackingCluster, f : Double) -> MlensemblestackingCluster {
  let result = ml_ensemble_stacking_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_stacking_cluster_add(a : MlensemblestackingCluster, b : MlensemblestackingCluster) -> MlensemblestackingCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_stacking_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_stacking_cluster_copy(s : MlensemblestackingCluster) -> MlensemblestackingCluster {
  let result = ml_ensemble_stacking_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_stacking_cluster_fill(s : MlensemblestackingCluster, v : Double) -> MlensemblestackingCluster {
  let result = ml_ensemble_stacking_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_stacking_cluster_min(s : MlensemblestackingCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_stacking_cluster_max(s : MlensemblestackingCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_stacking_cluster_to_string(s : MlensemblestackingCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblestackingModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_stacking_model_make(size : Int) -> MlensemblestackingModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_stacking_model_len(s : MlensemblestackingModel) -> Int { s.size }

pub fn ml_ensemble_stacking_model_get(s : MlensemblestackingModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_stacking_model_set(s : MlensemblestackingModel, i : Int, v : Double) -> MlensemblestackingModel {
  let result = ml_ensemble_stacking_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_stacking_model_sum(s : MlensemblestackingModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_stacking_model_mean(s : MlensemblestackingModel) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_stacking_model_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_stacking_model_scale(s : MlensemblestackingModel, f : Double) -> MlensemblestackingModel {
  let result = ml_ensemble_stacking_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_stacking_model_add(a : MlensemblestackingModel, b : MlensemblestackingModel) -> MlensemblestackingModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_stacking_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_stacking_model_copy(s : MlensemblestackingModel) -> MlensemblestackingModel {
  let result = ml_ensemble_stacking_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_stacking_model_fill(s : MlensemblestackingModel, v : Double) -> MlensemblestackingModel {
  let result = ml_ensemble_stacking_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_stacking_model_min(s : MlensemblestackingModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_stacking_model_max(s : MlensemblestackingModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_stacking_model_to_string(s : MlensemblestackingModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblestackingLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_stacking_layer_make(size : Int) -> MlensemblestackingLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_stacking_layer_len(s : MlensemblestackingLayer) -> Int { s.size }

pub fn ml_ensemble_stacking_layer_get(s : MlensemblestackingLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_stacking_layer_set(s : MlensemblestackingLayer, i : Int, v : Double) -> MlensemblestackingLayer {
  let result = ml_ensemble_stacking_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_stacking_layer_sum(s : MlensemblestackingLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_stacking_layer_mean(s : MlensemblestackingLayer) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_stacking_layer_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_stacking_layer_scale(s : MlensemblestackingLayer, f : Double) -> MlensemblestackingLayer {
  let result = ml_ensemble_stacking_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_stacking_layer_add(a : MlensemblestackingLayer, b : MlensemblestackingLayer) -> MlensemblestackingLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_stacking_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_stacking_layer_copy(s : MlensemblestackingLayer) -> MlensemblestackingLayer {
  let result = ml_ensemble_stacking_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_stacking_layer_fill(s : MlensemblestackingLayer, v : Double) -> MlensemblestackingLayer {
  let result = ml_ensemble_stacking_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_stacking_layer_min(s : MlensemblestackingLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_stacking_layer_max(s : MlensemblestackingLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_stacking_layer_to_string(s : MlensemblestackingLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblestackingBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_stacking_buffer_make(size : Int) -> MlensemblestackingBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_stacking_buffer_len(s : MlensemblestackingBuffer) -> Int { s.size }

pub fn ml_ensemble_stacking_buffer_get(s : MlensemblestackingBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_stacking_buffer_set(s : MlensemblestackingBuffer, i : Int, v : Double) -> MlensemblestackingBuffer {
  let result = ml_ensemble_stacking_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_stacking_buffer_sum(s : MlensemblestackingBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_stacking_buffer_mean(s : MlensemblestackingBuffer) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_stacking_buffer_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_stacking_buffer_scale(s : MlensemblestackingBuffer, f : Double) -> MlensemblestackingBuffer {
  let result = ml_ensemble_stacking_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_stacking_buffer_add(a : MlensemblestackingBuffer, b : MlensemblestackingBuffer) -> MlensemblestackingBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_stacking_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_stacking_buffer_copy(s : MlensemblestackingBuffer) -> MlensemblestackingBuffer {
  let result = ml_ensemble_stacking_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_stacking_buffer_fill(s : MlensemblestackingBuffer, v : Double) -> MlensemblestackingBuffer {
  let result = ml_ensemble_stacking_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_stacking_buffer_min(s : MlensemblestackingBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_stacking_buffer_max(s : MlensemblestackingBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_stacking_buffer_to_string(s : MlensemblestackingBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblestackingCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_stacking_cursor_make(size : Int) -> MlensemblestackingCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_stacking_cursor_len(s : MlensemblestackingCursor) -> Int { s.size }

pub fn ml_ensemble_stacking_cursor_get(s : MlensemblestackingCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_stacking_cursor_set(s : MlensemblestackingCursor, i : Int, v : Double) -> MlensemblestackingCursor {
  let result = ml_ensemble_stacking_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_stacking_cursor_sum(s : MlensemblestackingCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_stacking_cursor_mean(s : MlensemblestackingCursor) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_stacking_cursor_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_stacking_cursor_scale(s : MlensemblestackingCursor, f : Double) -> MlensemblestackingCursor {
  let result = ml_ensemble_stacking_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_stacking_cursor_add(a : MlensemblestackingCursor, b : MlensemblestackingCursor) -> MlensemblestackingCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_stacking_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_stacking_cursor_copy(s : MlensemblestackingCursor) -> MlensemblestackingCursor {
  let result = ml_ensemble_stacking_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_stacking_cursor_fill(s : MlensemblestackingCursor, v : Double) -> MlensemblestackingCursor {
  let result = ml_ensemble_stacking_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_stacking_cursor_min(s : MlensemblestackingCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_stacking_cursor_max(s : MlensemblestackingCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_stacking_cursor_to_string(s : MlensemblestackingCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblestackingView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_stacking_view_make(size : Int) -> MlensemblestackingView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_stacking_view_len(s : MlensemblestackingView) -> Int { s.size }

pub fn ml_ensemble_stacking_view_get(s : MlensemblestackingView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_stacking_view_set(s : MlensemblestackingView, i : Int, v : Double) -> MlensemblestackingView {
  let result = ml_ensemble_stacking_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_stacking_view_sum(s : MlensemblestackingView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_stacking_view_mean(s : MlensemblestackingView) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_stacking_view_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_stacking_view_scale(s : MlensemblestackingView, f : Double) -> MlensemblestackingView {
  let result = ml_ensemble_stacking_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_stacking_view_add(a : MlensemblestackingView, b : MlensemblestackingView) -> MlensemblestackingView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_stacking_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_stacking_view_copy(s : MlensemblestackingView) -> MlensemblestackingView {
  let result = ml_ensemble_stacking_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_stacking_view_fill(s : MlensemblestackingView, v : Double) -> MlensemblestackingView {
  let result = ml_ensemble_stacking_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_stacking_view_min(s : MlensemblestackingView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_stacking_view_max(s : MlensemblestackingView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_stacking_view_to_string(s : MlensemblestackingView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblestackingRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_stacking_range_make(size : Int) -> MlensemblestackingRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_stacking_range_len(s : MlensemblestackingRange) -> Int { s.size }

pub fn ml_ensemble_stacking_range_get(s : MlensemblestackingRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_stacking_range_set(s : MlensemblestackingRange, i : Int, v : Double) -> MlensemblestackingRange {
  let result = ml_ensemble_stacking_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_stacking_range_sum(s : MlensemblestackingRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_stacking_range_mean(s : MlensemblestackingRange) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_stacking_range_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_stacking_range_scale(s : MlensemblestackingRange, f : Double) -> MlensemblestackingRange {
  let result = ml_ensemble_stacking_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_stacking_range_add(a : MlensemblestackingRange, b : MlensemblestackingRange) -> MlensemblestackingRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_stacking_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_stacking_range_copy(s : MlensemblestackingRange) -> MlensemblestackingRange {
  let result = ml_ensemble_stacking_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_stacking_range_fill(s : MlensemblestackingRange, v : Double) -> MlensemblestackingRange {
  let result = ml_ensemble_stacking_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_stacking_range_min(s : MlensemblestackingRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_stacking_range_max(s : MlensemblestackingRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_stacking_range_to_string(s : MlensemblestackingRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblestackingSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_stacking_slice_make(size : Int) -> MlensemblestackingSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_stacking_slice_len(s : MlensemblestackingSlice) -> Int { s.size }

pub fn ml_ensemble_stacking_slice_get(s : MlensemblestackingSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_stacking_slice_set(s : MlensemblestackingSlice, i : Int, v : Double) -> MlensemblestackingSlice {
  let result = ml_ensemble_stacking_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_stacking_slice_sum(s : MlensemblestackingSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_stacking_slice_mean(s : MlensemblestackingSlice) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_stacking_slice_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_stacking_slice_scale(s : MlensemblestackingSlice, f : Double) -> MlensemblestackingSlice {
  let result = ml_ensemble_stacking_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_stacking_slice_add(a : MlensemblestackingSlice, b : MlensemblestackingSlice) -> MlensemblestackingSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_stacking_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_stacking_slice_copy(s : MlensemblestackingSlice) -> MlensemblestackingSlice {
  let result = ml_ensemble_stacking_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_stacking_slice_fill(s : MlensemblestackingSlice, v : Double) -> MlensemblestackingSlice {
  let result = ml_ensemble_stacking_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_stacking_slice_min(s : MlensemblestackingSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_stacking_slice_max(s : MlensemblestackingSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_stacking_slice_to_string(s : MlensemblestackingSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn ml_ensemble_stacking_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_ensemble_stacking_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_ensemble_stacking_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_ensemble_stacking_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_ensemble_stacking_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_ensemble_stacking_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_ensemble_stacking_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_ensemble_stacking_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_ensemble_stacking_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_ensemble_stacking_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_ensemble_stacking_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_ensemble_stacking_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_ensemble_stacking_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_ensemble_stacking_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_ensemble_stacking_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_ensemble_stacking_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_ensemble_stacking_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_ensemble_stacking_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_ensemble_stacking_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_ensemble_stacking_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_ensemble_stacking_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_ensemble_stacking_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_ensemble_stacking_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_ensemble_stacking_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_ensemble_stacking_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}


///===
/// extcore/ml_classify_svm

pub(all) struct MlclassifysvmPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_classify_svm_make_point(x : Double, y : Double) -> MlclassifysvmPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_classify_svm_make_point3(x : Double, y : Double, z : Double) -> MlclassifysvmPoint {
  { x, y, z, label: 0 }
}

pub fn ml_classify_svm_point_x(pt : MlclassifysvmPoint) -> Double { pt.x }

pub fn ml_classify_svm_point_y(pt : MlclassifysvmPoint) -> Double { pt.y }

pub fn ml_classify_svm_point_z(pt : MlclassifysvmPoint) -> Double { pt.z }

pub fn ml_classify_svm_point_label(pt : MlclassifysvmPoint) -> Int { pt.label }

pub fn ml_classify_svm_point_dist(a : MlclassifysvmPoint, b : MlclassifysvmPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  ml_classify_svm_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ml_classify_svm_point_add(a : MlclassifysvmPoint, b : MlclassifysvmPoint) -> MlclassifysvmPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ml_classify_svm_point_sub(a : MlclassifysvmPoint, b : MlclassifysvmPoint) -> MlclassifysvmPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ml_classify_svm_point_scale(pt : MlclassifysvmPoint, s : Double) -> MlclassifysvmPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ml_classify_svm_point_dot(a : MlclassifysvmPoint, b : MlclassifysvmPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ml_classify_svm_point_cross(a : MlclassifysvmPoint, b : MlclassifysvmPoint) -> MlclassifysvmPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ml_classify_svm_point_norm(pt : MlclassifysvmPoint) -> Double {
  ml_classify_svm_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ml_classify_svm_point_normalize(pt : MlclassifysvmPoint) -> MlclassifysvmPoint {
  let n = ml_classify_svm_point_norm(pt)
  if n < 0.0000001 { pt } else { ml_classify_svm_point_scale(pt, 1.0 / n) }
}

pub fn ml_classify_svm_point_negate(pt : MlclassifysvmPoint) -> MlclassifysvmPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ml_classify_svm_point_mid(a : MlclassifysvmPoint, b : MlclassifysvmPoint) -> MlclassifysvmPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ml_classify_svm_point_lerp(a : MlclassifysvmPoint, b : MlclassifysvmPoint, t : Double) -> MlclassifysvmPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ml_classify_svm_point_to_string(pt : MlclassifysvmPoint) -> String {
  "(" + ml_classify_svm_dbl(pt.x) + ", " + ml_classify_svm_dbl(pt.y) + ", " + ml_classify_svm_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MlclassifysvmSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_classify_svm_make_series(vals : Array[Double], name : String) -> MlclassifysvmSeries {
  { vals, name, meta: 0 }
}

pub fn ml_classify_svm_series_len(s : MlclassifysvmSeries) -> Int { s.vals.length() }

pub fn ml_classify_svm_series_sum(s : MlclassifysvmSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn ml_classify_svm_series_mean(s : MlclassifysvmSeries) -> Double {
  let n = ml_classify_svm_series_len(s)
  if n == 0 { 0.0 } else { ml_classify_svm_series_sum(s) / n.to_double() }
}

pub fn ml_classify_svm_series_min(s : MlclassifysvmSeries) -> Double {
  let n = ml_classify_svm_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn ml_classify_svm_series_max(s : MlclassifysvmSeries) -> Double {
  let n = ml_classify_svm_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn ml_classify_svm_series_range(s : MlclassifysvmSeries) -> Double {
  ml_classify_svm_series_max(s) - ml_classify_svm_series_min(s)
}

pub fn ml_classify_svm_series_var(s : MlclassifysvmSeries) -> Double {
  let n = ml_classify_svm_series_len(s)
  if n == 0 { 0.0 } else {
    let m = ml_classify_svm_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn ml_classify_svm_series_std(s : MlclassifysvmSeries) -> Double { ml_classify_svm_sqrt(ml_classify_svm_series_var(s)) }

pub fn ml_classify_svm_series_median(s : MlclassifysvmSeries) -> Double {
  let n = ml_classify_svm_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = ml_classify_svm_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ml_classify_svm_series_scale(s : MlclassifysvmSeries, f : Double) -> MlclassifysvmSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = ml_classify_svm_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ml_classify_svm_series_add(a : MlclassifysvmSeries, b : MlclassifysvmSeries) -> MlclassifysvmSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = ml_classify_svm_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ml_classify_svm_series_sub(a : MlclassifysvmSeries, b : MlclassifysvmSeries) -> MlclassifysvmSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = ml_classify_svm_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ml_classify_svm_series_normalize(s : MlclassifysvmSeries) -> MlclassifysvmSeries {
  let mn = ml_classify_svm_series_min(s)
  let mx = ml_classify_svm_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = ml_classify_svm_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ml_classify_svm_series_cumsum(s : MlclassifysvmSeries) -> MlclassifysvmSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = ml_classify_svm_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn ml_classify_svm_series_to_string(s : MlclassifysvmSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + ml_classify_svm_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlclassifysvmMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_classify_svm_make_matrix(rows : Int, cols : Int, val : Double) -> MlclassifysvmMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_classify_svm_matrix_identity(n : Int) -> MlclassifysvmMatrix {
  let m = ml_classify_svm_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ml_classify_svm_matrix_get(m : MlclassifysvmMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ml_classify_svm_matrix_transpose(m : MlclassifysvmMatrix) -> MlclassifysvmMatrix {
  let result = ml_classify_svm_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ml_classify_svm_matrix_add(a : MlclassifysvmMatrix, b : MlclassifysvmMatrix) -> MlclassifysvmMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ml_classify_svm_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ml_classify_svm_matrix_scale(m : MlclassifysvmMatrix, s : Double) -> MlclassifysvmMatrix {
  let result = ml_classify_svm_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ml_classify_svm_matrix_multiply(a : MlclassifysvmMatrix, b : MlclassifysvmMatrix) -> MlclassifysvmMatrix {
  if a.cols != b.rows { return ml_classify_svm_make_matrix(a.rows, b.cols, 0.0) }
  let result = ml_classify_svm_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ml_classify_svm_matrix_trace(m : MlclassifysvmMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ml_classify_svm_matrix_det(m : MlclassifysvmMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ml_classify_svm_matrix_norm(m : MlclassifysvmMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  ml_classify_svm_sqrt(sum)
}

pub fn ml_classify_svm_matrix_to_string(m : MlclassifysvmMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + ml_classify_svm_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct MlclassifysvmVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_classify_svm_make_vector(comps : Array[Double]) -> MlclassifysvmVector {
  { comps, dim: comps.length() }
}

pub fn ml_classify_svm_vector_zero(dim : Int) -> MlclassifysvmVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ml_classify_svm_vector_add(a : MlclassifysvmVector, b : MlclassifysvmVector) -> MlclassifysvmVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = ml_classify_svm_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_classify_svm_vector_sub(a : MlclassifysvmVector, b : MlclassifysvmVector) -> MlclassifysvmVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = ml_classify_svm_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_classify_svm_vector_scale(v : MlclassifysvmVector, s : Double) -> MlclassifysvmVector {
  let mut result = []
  for i in 0..<v.dim { result = ml_classify_svm_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ml_classify_svm_vector_dot(a : MlclassifysvmVector, b : MlclassifysvmVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ml_classify_svm_vector_norm(v : MlclassifysvmVector) -> Double { ml_classify_svm_sqrt(ml_classify_svm_vector_dot(v, v)) }

pub fn ml_classify_svm_vector_normalize(v : MlclassifysvmVector) -> MlclassifysvmVector {
  let n = ml_classify_svm_vector_norm(v)
  if n < 0.0000001 { v } else { ml_classify_svm_vector_scale(v, 1.0 / n) }
}

pub fn ml_classify_svm_vector_dist(a : MlclassifysvmVector, b : MlclassifysvmVector) -> Double {
  ml_classify_svm_vector_norm(ml_classify_svm_vector_sub(a, b))
}

pub fn ml_classify_svm_vector_to_string(v : MlclassifysvmVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + ml_classify_svm_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_classify_svm_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn ml_classify_svm_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = ml_classify_svm_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ml_classify_svm_std(data : Array[Double]) -> Double { ml_classify_svm_sqrt(ml_classify_svm_var(data)) }

pub fn ml_classify_svm_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = ml_classify_svm_mean(a); let mb = ml_classify_svm_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn ml_classify_svm_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = ml_classify_svm_std(a); let sb = ml_classify_svm_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { ml_classify_svm_cov(a, b) / (sa * sb) }
}

pub fn ml_classify_svm_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = ml_classify_svm_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ml_classify_svm_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn ml_classify_svm_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ml_classify_svm_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  ml_classify_svm_sqrt(ml_classify_svm_mse(pred, labels))
}

pub fn ml_classify_svm_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + ml_classify_svm_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn ml_classify_svm_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = ml_classify_svm_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn ml_classify_svm_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn ml_classify_svm_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn ml_classify_svm_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = ml_classify_svm_precision(pred, labels, pos); let r = ml_classify_svm_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn ml_classify_svm_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn ml_classify_svm_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = ml_classify_svm_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn ml_classify_svm_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn ml_classify_svm_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn ml_classify_svm_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = ml_classify_svm_gcd(a, b)
    (a / g) * b
  }
}

pub fn ml_classify_svm_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn ml_classify_svm_fibonacci(n : Int) -> Int {
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

pub fn ml_classify_svm_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = ml_classify_svm_min(data); let mx = ml_classify_svm_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn ml_classify_svm_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = ml_classify_svm_mean(data); let sd = ml_classify_svm_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn ml_classify_svm_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn ml_classify_svm_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn ml_classify_svm_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn ml_classify_svm_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn ml_classify_svm_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn ml_classify_svm_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn ml_classify_svm_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn ml_classify_svm_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn ml_classify_svm_dbl(x : Double) -> String {
  let i = if x >= 0.0 { ml_classify_svm_int(x) } else { -ml_classify_svm_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { ml_classify_svm_int(f * 1000000.0) } else { ml_classify_svm_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn ml_classify_svm_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn ml_classify_svm_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct MlclassifysvmFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_svm_frame_make(size : Int) -> MlclassifysvmFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_svm_frame_len(s : MlclassifysvmFrame) -> Int { s.size }

pub fn ml_classify_svm_frame_get(s : MlclassifysvmFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_svm_frame_set(s : MlclassifysvmFrame, i : Int, v : Double) -> MlclassifysvmFrame {
  let result = ml_classify_svm_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_svm_frame_sum(s : MlclassifysvmFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_svm_frame_mean(s : MlclassifysvmFrame) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_svm_frame_sum(s) / s.size.to_double() }
}

pub fn ml_classify_svm_frame_scale(s : MlclassifysvmFrame, f : Double) -> MlclassifysvmFrame {
  let result = ml_classify_svm_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_svm_frame_add(a : MlclassifysvmFrame, b : MlclassifysvmFrame) -> MlclassifysvmFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_svm_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_svm_frame_copy(s : MlclassifysvmFrame) -> MlclassifysvmFrame {
  let result = ml_classify_svm_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_svm_frame_fill(s : MlclassifysvmFrame, v : Double) -> MlclassifysvmFrame {
  let result = ml_classify_svm_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_svm_frame_min(s : MlclassifysvmFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_svm_frame_max(s : MlclassifysvmFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_svm_frame_to_string(s : MlclassifysvmFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifysvmTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_svm_table_make(size : Int) -> MlclassifysvmTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_svm_table_len(s : MlclassifysvmTable) -> Int { s.size }

pub fn ml_classify_svm_table_get(s : MlclassifysvmTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_svm_table_set(s : MlclassifysvmTable, i : Int, v : Double) -> MlclassifysvmTable {
  let result = ml_classify_svm_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_svm_table_sum(s : MlclassifysvmTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_svm_table_mean(s : MlclassifysvmTable) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_svm_table_sum(s) / s.size.to_double() }
}

pub fn ml_classify_svm_table_scale(s : MlclassifysvmTable, f : Double) -> MlclassifysvmTable {
  let result = ml_classify_svm_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_svm_table_add(a : MlclassifysvmTable, b : MlclassifysvmTable) -> MlclassifysvmTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_svm_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_svm_table_copy(s : MlclassifysvmTable) -> MlclassifysvmTable {
  let result = ml_classify_svm_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_svm_table_fill(s : MlclassifysvmTable, v : Double) -> MlclassifysvmTable {
  let result = ml_classify_svm_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_svm_table_min(s : MlclassifysvmTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_svm_table_max(s : MlclassifysvmTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_svm_table_to_string(s : MlclassifysvmTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifysvmGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_svm_graphn_make(size : Int) -> MlclassifysvmGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_svm_graphn_len(s : MlclassifysvmGraphN) -> Int { s.size }

pub fn ml_classify_svm_graphn_get(s : MlclassifysvmGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_svm_graphn_set(s : MlclassifysvmGraphN, i : Int, v : Double) -> MlclassifysvmGraphN {
  let result = ml_classify_svm_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_svm_graphn_sum(s : MlclassifysvmGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_svm_graphn_mean(s : MlclassifysvmGraphN) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_svm_graphn_sum(s) / s.size.to_double() }
}

pub fn ml_classify_svm_graphn_scale(s : MlclassifysvmGraphN, f : Double) -> MlclassifysvmGraphN {
  let result = ml_classify_svm_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_svm_graphn_add(a : MlclassifysvmGraphN, b : MlclassifysvmGraphN) -> MlclassifysvmGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_svm_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_svm_graphn_copy(s : MlclassifysvmGraphN) -> MlclassifysvmGraphN {
  let result = ml_classify_svm_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_svm_graphn_fill(s : MlclassifysvmGraphN, v : Double) -> MlclassifysvmGraphN {
  let result = ml_classify_svm_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_svm_graphn_min(s : MlclassifysvmGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_svm_graphn_max(s : MlclassifysvmGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_svm_graphn_to_string(s : MlclassifysvmGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifysvmNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_svm_node_make(size : Int) -> MlclassifysvmNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_svm_node_len(s : MlclassifysvmNode) -> Int { s.size }

pub fn ml_classify_svm_node_get(s : MlclassifysvmNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_svm_node_set(s : MlclassifysvmNode, i : Int, v : Double) -> MlclassifysvmNode {
  let result = ml_classify_svm_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_svm_node_sum(s : MlclassifysvmNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_svm_node_mean(s : MlclassifysvmNode) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_svm_node_sum(s) / s.size.to_double() }
}

pub fn ml_classify_svm_node_scale(s : MlclassifysvmNode, f : Double) -> MlclassifysvmNode {
  let result = ml_classify_svm_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_svm_node_add(a : MlclassifysvmNode, b : MlclassifysvmNode) -> MlclassifysvmNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_svm_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_svm_node_copy(s : MlclassifysvmNode) -> MlclassifysvmNode {
  let result = ml_classify_svm_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_svm_node_fill(s : MlclassifysvmNode, v : Double) -> MlclassifysvmNode {
  let result = ml_classify_svm_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_svm_node_min(s : MlclassifysvmNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_svm_node_max(s : MlclassifysvmNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_svm_node_to_string(s : MlclassifysvmNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifysvmEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_svm_edge_make(size : Int) -> MlclassifysvmEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_svm_edge_len(s : MlclassifysvmEdge) -> Int { s.size }

pub fn ml_classify_svm_edge_get(s : MlclassifysvmEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_svm_edge_set(s : MlclassifysvmEdge, i : Int, v : Double) -> MlclassifysvmEdge {
  let result = ml_classify_svm_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_svm_edge_sum(s : MlclassifysvmEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_svm_edge_mean(s : MlclassifysvmEdge) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_svm_edge_sum(s) / s.size.to_double() }
}

pub fn ml_classify_svm_edge_scale(s : MlclassifysvmEdge, f : Double) -> MlclassifysvmEdge {
  let result = ml_classify_svm_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_svm_edge_add(a : MlclassifysvmEdge, b : MlclassifysvmEdge) -> MlclassifysvmEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_svm_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_svm_edge_copy(s : MlclassifysvmEdge) -> MlclassifysvmEdge {
  let result = ml_classify_svm_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_svm_edge_fill(s : MlclassifysvmEdge, v : Double) -> MlclassifysvmEdge {
  let result = ml_classify_svm_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_svm_edge_min(s : MlclassifysvmEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_svm_edge_max(s : MlclassifysvmEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_svm_edge_to_string(s : MlclassifysvmEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifysvmPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_svm_path_make(size : Int) -> MlclassifysvmPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_svm_path_len(s : MlclassifysvmPath) -> Int { s.size }

pub fn ml_classify_svm_path_get(s : MlclassifysvmPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_svm_path_set(s : MlclassifysvmPath, i : Int, v : Double) -> MlclassifysvmPath {
  let result = ml_classify_svm_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_svm_path_sum(s : MlclassifysvmPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_svm_path_mean(s : MlclassifysvmPath) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_svm_path_sum(s) / s.size.to_double() }
}

pub fn ml_classify_svm_path_scale(s : MlclassifysvmPath, f : Double) -> MlclassifysvmPath {
  let result = ml_classify_svm_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_svm_path_add(a : MlclassifysvmPath, b : MlclassifysvmPath) -> MlclassifysvmPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_svm_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_svm_path_copy(s : MlclassifysvmPath) -> MlclassifysvmPath {
  let result = ml_classify_svm_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_svm_path_fill(s : MlclassifysvmPath, v : Double) -> MlclassifysvmPath {
  let result = ml_classify_svm_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_svm_path_min(s : MlclassifysvmPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_svm_path_max(s : MlclassifysvmPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_svm_path_to_string(s : MlclassifysvmPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifysvmCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_svm_cluster_make(size : Int) -> MlclassifysvmCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_svm_cluster_len(s : MlclassifysvmCluster) -> Int { s.size }

pub fn ml_classify_svm_cluster_get(s : MlclassifysvmCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_svm_cluster_set(s : MlclassifysvmCluster, i : Int, v : Double) -> MlclassifysvmCluster {
  let result = ml_classify_svm_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_svm_cluster_sum(s : MlclassifysvmCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_svm_cluster_mean(s : MlclassifysvmCluster) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_svm_cluster_sum(s) / s.size.to_double() }
}

pub fn ml_classify_svm_cluster_scale(s : MlclassifysvmCluster, f : Double) -> MlclassifysvmCluster {
  let result = ml_classify_svm_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_svm_cluster_add(a : MlclassifysvmCluster, b : MlclassifysvmCluster) -> MlclassifysvmCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_svm_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_svm_cluster_copy(s : MlclassifysvmCluster) -> MlclassifysvmCluster {
  let result = ml_classify_svm_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_svm_cluster_fill(s : MlclassifysvmCluster, v : Double) -> MlclassifysvmCluster {
  let result = ml_classify_svm_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_svm_cluster_min(s : MlclassifysvmCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_svm_cluster_max(s : MlclassifysvmCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_svm_cluster_to_string(s : MlclassifysvmCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifysvmModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_svm_model_make(size : Int) -> MlclassifysvmModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_svm_model_len(s : MlclassifysvmModel) -> Int { s.size }

pub fn ml_classify_svm_model_get(s : MlclassifysvmModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_svm_model_set(s : MlclassifysvmModel, i : Int, v : Double) -> MlclassifysvmModel {
  let result = ml_classify_svm_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_svm_model_sum(s : MlclassifysvmModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_svm_model_mean(s : MlclassifysvmModel) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_svm_model_sum(s) / s.size.to_double() }
}

pub fn ml_classify_svm_model_scale(s : MlclassifysvmModel, f : Double) -> MlclassifysvmModel {
  let result = ml_classify_svm_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_svm_model_add(a : MlclassifysvmModel, b : MlclassifysvmModel) -> MlclassifysvmModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_svm_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_svm_model_copy(s : MlclassifysvmModel) -> MlclassifysvmModel {
  let result = ml_classify_svm_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_svm_model_fill(s : MlclassifysvmModel, v : Double) -> MlclassifysvmModel {
  let result = ml_classify_svm_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_svm_model_min(s : MlclassifysvmModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_svm_model_max(s : MlclassifysvmModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_svm_model_to_string(s : MlclassifysvmModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifysvmLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_svm_layer_make(size : Int) -> MlclassifysvmLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_svm_layer_len(s : MlclassifysvmLayer) -> Int { s.size }

pub fn ml_classify_svm_layer_get(s : MlclassifysvmLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_svm_layer_set(s : MlclassifysvmLayer, i : Int, v : Double) -> MlclassifysvmLayer {
  let result = ml_classify_svm_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_svm_layer_sum(s : MlclassifysvmLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_svm_layer_mean(s : MlclassifysvmLayer) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_svm_layer_sum(s) / s.size.to_double() }
}

pub fn ml_classify_svm_layer_scale(s : MlclassifysvmLayer, f : Double) -> MlclassifysvmLayer {
  let result = ml_classify_svm_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_svm_layer_add(a : MlclassifysvmLayer, b : MlclassifysvmLayer) -> MlclassifysvmLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_svm_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_svm_layer_copy(s : MlclassifysvmLayer) -> MlclassifysvmLayer {
  let result = ml_classify_svm_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_svm_layer_fill(s : MlclassifysvmLayer, v : Double) -> MlclassifysvmLayer {
  let result = ml_classify_svm_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_svm_layer_min(s : MlclassifysvmLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_svm_layer_max(s : MlclassifysvmLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_svm_layer_to_string(s : MlclassifysvmLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifysvmBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_svm_buffer_make(size : Int) -> MlclassifysvmBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_svm_buffer_len(s : MlclassifysvmBuffer) -> Int { s.size }

pub fn ml_classify_svm_buffer_get(s : MlclassifysvmBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_svm_buffer_set(s : MlclassifysvmBuffer, i : Int, v : Double) -> MlclassifysvmBuffer {
  let result = ml_classify_svm_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_svm_buffer_sum(s : MlclassifysvmBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_svm_buffer_mean(s : MlclassifysvmBuffer) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_svm_buffer_sum(s) / s.size.to_double() }
}

pub fn ml_classify_svm_buffer_scale(s : MlclassifysvmBuffer, f : Double) -> MlclassifysvmBuffer {
  let result = ml_classify_svm_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_svm_buffer_add(a : MlclassifysvmBuffer, b : MlclassifysvmBuffer) -> MlclassifysvmBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_svm_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_svm_buffer_copy(s : MlclassifysvmBuffer) -> MlclassifysvmBuffer {
  let result = ml_classify_svm_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_svm_buffer_fill(s : MlclassifysvmBuffer, v : Double) -> MlclassifysvmBuffer {
  let result = ml_classify_svm_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_svm_buffer_min(s : MlclassifysvmBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_svm_buffer_max(s : MlclassifysvmBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_svm_buffer_to_string(s : MlclassifysvmBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifysvmCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_svm_cursor_make(size : Int) -> MlclassifysvmCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_svm_cursor_len(s : MlclassifysvmCursor) -> Int { s.size }

pub fn ml_classify_svm_cursor_get(s : MlclassifysvmCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_svm_cursor_set(s : MlclassifysvmCursor, i : Int, v : Double) -> MlclassifysvmCursor {
  let result = ml_classify_svm_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_svm_cursor_sum(s : MlclassifysvmCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_svm_cursor_mean(s : MlclassifysvmCursor) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_svm_cursor_sum(s) / s.size.to_double() }
}

pub fn ml_classify_svm_cursor_scale(s : MlclassifysvmCursor, f : Double) -> MlclassifysvmCursor {
  let result = ml_classify_svm_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_svm_cursor_add(a : MlclassifysvmCursor, b : MlclassifysvmCursor) -> MlclassifysvmCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_svm_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_svm_cursor_copy(s : MlclassifysvmCursor) -> MlclassifysvmCursor {
  let result = ml_classify_svm_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_svm_cursor_fill(s : MlclassifysvmCursor, v : Double) -> MlclassifysvmCursor {
  let result = ml_classify_svm_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_svm_cursor_min(s : MlclassifysvmCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_svm_cursor_max(s : MlclassifysvmCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_svm_cursor_to_string(s : MlclassifysvmCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifysvmView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_svm_view_make(size : Int) -> MlclassifysvmView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_svm_view_len(s : MlclassifysvmView) -> Int { s.size }

pub fn ml_classify_svm_view_get(s : MlclassifysvmView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_svm_view_set(s : MlclassifysvmView, i : Int, v : Double) -> MlclassifysvmView {
  let result = ml_classify_svm_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_svm_view_sum(s : MlclassifysvmView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_svm_view_mean(s : MlclassifysvmView) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_svm_view_sum(s) / s.size.to_double() }
}

pub fn ml_classify_svm_view_scale(s : MlclassifysvmView, f : Double) -> MlclassifysvmView {
  let result = ml_classify_svm_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_svm_view_add(a : MlclassifysvmView, b : MlclassifysvmView) -> MlclassifysvmView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_svm_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_svm_view_copy(s : MlclassifysvmView) -> MlclassifysvmView {
  let result = ml_classify_svm_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_svm_view_fill(s : MlclassifysvmView, v : Double) -> MlclassifysvmView {
  let result = ml_classify_svm_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_svm_view_min(s : MlclassifysvmView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_svm_view_max(s : MlclassifysvmView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_svm_view_to_string(s : MlclassifysvmView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifysvmRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_svm_range_make(size : Int) -> MlclassifysvmRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_svm_range_len(s : MlclassifysvmRange) -> Int { s.size }

pub fn ml_classify_svm_range_get(s : MlclassifysvmRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_svm_range_set(s : MlclassifysvmRange, i : Int, v : Double) -> MlclassifysvmRange {
  let result = ml_classify_svm_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_svm_range_sum(s : MlclassifysvmRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_svm_range_mean(s : MlclassifysvmRange) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_svm_range_sum(s) / s.size.to_double() }
}

pub fn ml_classify_svm_range_scale(s : MlclassifysvmRange, f : Double) -> MlclassifysvmRange {
  let result = ml_classify_svm_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_svm_range_add(a : MlclassifysvmRange, b : MlclassifysvmRange) -> MlclassifysvmRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_svm_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_svm_range_copy(s : MlclassifysvmRange) -> MlclassifysvmRange {
  let result = ml_classify_svm_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_svm_range_fill(s : MlclassifysvmRange, v : Double) -> MlclassifysvmRange {
  let result = ml_classify_svm_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_svm_range_min(s : MlclassifysvmRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_svm_range_max(s : MlclassifysvmRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_svm_range_to_string(s : MlclassifysvmRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifysvmSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_svm_slice_make(size : Int) -> MlclassifysvmSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_svm_slice_len(s : MlclassifysvmSlice) -> Int { s.size }

pub fn ml_classify_svm_slice_get(s : MlclassifysvmSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_svm_slice_set(s : MlclassifysvmSlice, i : Int, v : Double) -> MlclassifysvmSlice {
  let result = ml_classify_svm_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_svm_slice_sum(s : MlclassifysvmSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_svm_slice_mean(s : MlclassifysvmSlice) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_svm_slice_sum(s) / s.size.to_double() }
}

pub fn ml_classify_svm_slice_scale(s : MlclassifysvmSlice, f : Double) -> MlclassifysvmSlice {
  let result = ml_classify_svm_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_svm_slice_add(a : MlclassifysvmSlice, b : MlclassifysvmSlice) -> MlclassifysvmSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_svm_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_svm_slice_copy(s : MlclassifysvmSlice) -> MlclassifysvmSlice {
  let result = ml_classify_svm_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_svm_slice_fill(s : MlclassifysvmSlice, v : Double) -> MlclassifysvmSlice {
  let result = ml_classify_svm_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_svm_slice_min(s : MlclassifysvmSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_svm_slice_max(s : MlclassifysvmSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_svm_slice_to_string(s : MlclassifysvmSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn ml_classify_svm_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_classify_svm_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_classify_svm_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_classify_svm_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_classify_svm_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_classify_svm_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_classify_svm_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_classify_svm_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_classify_svm_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_classify_svm_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_classify_svm_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_classify_svm_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_classify_svm_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_classify_svm_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_classify_svm_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_classify_svm_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_classify_svm_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_classify_svm_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_classify_svm_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_classify_svm_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_classify_svm_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_classify_svm_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_classify_svm_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_classify_svm_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_classify_svm_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}


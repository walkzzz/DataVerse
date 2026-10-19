///===
/// extcore/ml_classify_qda

pub(all) struct MlclassifyqdaPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_classify_qda_make_point(x : Double, y : Double) -> MlclassifyqdaPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_classify_qda_make_point3(x : Double, y : Double, z : Double) -> MlclassifyqdaPoint {
  { x, y, z, label: 0 }
}

pub fn ml_classify_qda_point_x(pt : MlclassifyqdaPoint) -> Double { pt.x }

pub fn ml_classify_qda_point_y(pt : MlclassifyqdaPoint) -> Double { pt.y }

pub fn ml_classify_qda_point_z(pt : MlclassifyqdaPoint) -> Double { pt.z }

pub fn ml_classify_qda_point_label(pt : MlclassifyqdaPoint) -> Int { pt.label }

pub fn ml_classify_qda_point_dist(a : MlclassifyqdaPoint, b : MlclassifyqdaPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  ml_classify_qda_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ml_classify_qda_point_add(a : MlclassifyqdaPoint, b : MlclassifyqdaPoint) -> MlclassifyqdaPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ml_classify_qda_point_sub(a : MlclassifyqdaPoint, b : MlclassifyqdaPoint) -> MlclassifyqdaPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ml_classify_qda_point_scale(pt : MlclassifyqdaPoint, s : Double) -> MlclassifyqdaPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ml_classify_qda_point_dot(a : MlclassifyqdaPoint, b : MlclassifyqdaPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ml_classify_qda_point_cross(a : MlclassifyqdaPoint, b : MlclassifyqdaPoint) -> MlclassifyqdaPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ml_classify_qda_point_norm(pt : MlclassifyqdaPoint) -> Double {
  ml_classify_qda_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ml_classify_qda_point_normalize(pt : MlclassifyqdaPoint) -> MlclassifyqdaPoint {
  let n = ml_classify_qda_point_norm(pt)
  if n < 0.0000001 { pt } else { ml_classify_qda_point_scale(pt, 1.0 / n) }
}

pub fn ml_classify_qda_point_negate(pt : MlclassifyqdaPoint) -> MlclassifyqdaPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ml_classify_qda_point_mid(a : MlclassifyqdaPoint, b : MlclassifyqdaPoint) -> MlclassifyqdaPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ml_classify_qda_point_lerp(a : MlclassifyqdaPoint, b : MlclassifyqdaPoint, t : Double) -> MlclassifyqdaPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ml_classify_qda_point_to_string(pt : MlclassifyqdaPoint) -> String {
  "(" + ml_classify_qda_dbl(pt.x) + ", " + ml_classify_qda_dbl(pt.y) + ", " + ml_classify_qda_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MlclassifyqdaSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_classify_qda_make_series(vals : Array[Double], name : String) -> MlclassifyqdaSeries {
  { vals, name, meta: 0 }
}

pub fn ml_classify_qda_series_len(s : MlclassifyqdaSeries) -> Int { s.vals.length() }

pub fn ml_classify_qda_series_sum(s : MlclassifyqdaSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn ml_classify_qda_series_mean(s : MlclassifyqdaSeries) -> Double {
  let n = ml_classify_qda_series_len(s)
  if n == 0 { 0.0 } else { ml_classify_qda_series_sum(s) / n.to_double() }
}

pub fn ml_classify_qda_series_min(s : MlclassifyqdaSeries) -> Double {
  let n = ml_classify_qda_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn ml_classify_qda_series_max(s : MlclassifyqdaSeries) -> Double {
  let n = ml_classify_qda_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn ml_classify_qda_series_range(s : MlclassifyqdaSeries) -> Double {
  ml_classify_qda_series_max(s) - ml_classify_qda_series_min(s)
}

pub fn ml_classify_qda_series_var(s : MlclassifyqdaSeries) -> Double {
  let n = ml_classify_qda_series_len(s)
  if n == 0 { 0.0 } else {
    let m = ml_classify_qda_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn ml_classify_qda_series_std(s : MlclassifyqdaSeries) -> Double { ml_classify_qda_sqrt(ml_classify_qda_series_var(s)) }

pub fn ml_classify_qda_series_median(s : MlclassifyqdaSeries) -> Double {
  let n = ml_classify_qda_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = ml_classify_qda_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ml_classify_qda_series_scale(s : MlclassifyqdaSeries, f : Double) -> MlclassifyqdaSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = ml_classify_qda_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ml_classify_qda_series_add(a : MlclassifyqdaSeries, b : MlclassifyqdaSeries) -> MlclassifyqdaSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = ml_classify_qda_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ml_classify_qda_series_sub(a : MlclassifyqdaSeries, b : MlclassifyqdaSeries) -> MlclassifyqdaSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = ml_classify_qda_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ml_classify_qda_series_normalize(s : MlclassifyqdaSeries) -> MlclassifyqdaSeries {
  let mn = ml_classify_qda_series_min(s)
  let mx = ml_classify_qda_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = ml_classify_qda_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ml_classify_qda_series_cumsum(s : MlclassifyqdaSeries) -> MlclassifyqdaSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = ml_classify_qda_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn ml_classify_qda_series_to_string(s : MlclassifyqdaSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + ml_classify_qda_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlclassifyqdaMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_classify_qda_make_matrix(rows : Int, cols : Int, val : Double) -> MlclassifyqdaMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_classify_qda_matrix_identity(n : Int) -> MlclassifyqdaMatrix {
  let m = ml_classify_qda_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ml_classify_qda_matrix_get(m : MlclassifyqdaMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ml_classify_qda_matrix_transpose(m : MlclassifyqdaMatrix) -> MlclassifyqdaMatrix {
  let result = ml_classify_qda_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ml_classify_qda_matrix_add(a : MlclassifyqdaMatrix, b : MlclassifyqdaMatrix) -> MlclassifyqdaMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ml_classify_qda_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ml_classify_qda_matrix_scale(m : MlclassifyqdaMatrix, s : Double) -> MlclassifyqdaMatrix {
  let result = ml_classify_qda_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ml_classify_qda_matrix_multiply(a : MlclassifyqdaMatrix, b : MlclassifyqdaMatrix) -> MlclassifyqdaMatrix {
  if a.cols != b.rows { return ml_classify_qda_make_matrix(a.rows, b.cols, 0.0) }
  let result = ml_classify_qda_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ml_classify_qda_matrix_trace(m : MlclassifyqdaMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ml_classify_qda_matrix_det(m : MlclassifyqdaMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ml_classify_qda_matrix_norm(m : MlclassifyqdaMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  ml_classify_qda_sqrt(sum)
}

pub fn ml_classify_qda_matrix_to_string(m : MlclassifyqdaMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + ml_classify_qda_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct MlclassifyqdaVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_classify_qda_make_vector(comps : Array[Double]) -> MlclassifyqdaVector {
  { comps, dim: comps.length() }
}

pub fn ml_classify_qda_vector_zero(dim : Int) -> MlclassifyqdaVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ml_classify_qda_vector_add(a : MlclassifyqdaVector, b : MlclassifyqdaVector) -> MlclassifyqdaVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = ml_classify_qda_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_classify_qda_vector_sub(a : MlclassifyqdaVector, b : MlclassifyqdaVector) -> MlclassifyqdaVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = ml_classify_qda_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_classify_qda_vector_scale(v : MlclassifyqdaVector, s : Double) -> MlclassifyqdaVector {
  let mut result = []
  for i in 0..<v.dim { result = ml_classify_qda_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ml_classify_qda_vector_dot(a : MlclassifyqdaVector, b : MlclassifyqdaVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ml_classify_qda_vector_norm(v : MlclassifyqdaVector) -> Double { ml_classify_qda_sqrt(ml_classify_qda_vector_dot(v, v)) }

pub fn ml_classify_qda_vector_normalize(v : MlclassifyqdaVector) -> MlclassifyqdaVector {
  let n = ml_classify_qda_vector_norm(v)
  if n < 0.0000001 { v } else { ml_classify_qda_vector_scale(v, 1.0 / n) }
}

pub fn ml_classify_qda_vector_dist(a : MlclassifyqdaVector, b : MlclassifyqdaVector) -> Double {
  ml_classify_qda_vector_norm(ml_classify_qda_vector_sub(a, b))
}

pub fn ml_classify_qda_vector_to_string(v : MlclassifyqdaVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + ml_classify_qda_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_classify_qda_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn ml_classify_qda_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = ml_classify_qda_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ml_classify_qda_std(data : Array[Double]) -> Double { ml_classify_qda_sqrt(ml_classify_qda_var(data)) }

pub fn ml_classify_qda_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = ml_classify_qda_mean(a); let mb = ml_classify_qda_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn ml_classify_qda_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = ml_classify_qda_std(a); let sb = ml_classify_qda_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { ml_classify_qda_cov(a, b) / (sa * sb) }
}

pub fn ml_classify_qda_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = ml_classify_qda_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ml_classify_qda_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn ml_classify_qda_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ml_classify_qda_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  ml_classify_qda_sqrt(ml_classify_qda_mse(pred, labels))
}

pub fn ml_classify_qda_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + ml_classify_qda_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn ml_classify_qda_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = ml_classify_qda_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn ml_classify_qda_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn ml_classify_qda_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn ml_classify_qda_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = ml_classify_qda_precision(pred, labels, pos); let r = ml_classify_qda_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn ml_classify_qda_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn ml_classify_qda_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = ml_classify_qda_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn ml_classify_qda_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn ml_classify_qda_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn ml_classify_qda_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = ml_classify_qda_gcd(a, b)
    (a / g) * b
  }
}

pub fn ml_classify_qda_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn ml_classify_qda_fibonacci(n : Int) -> Int {
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

pub fn ml_classify_qda_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = ml_classify_qda_min(data); let mx = ml_classify_qda_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn ml_classify_qda_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = ml_classify_qda_mean(data); let sd = ml_classify_qda_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn ml_classify_qda_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn ml_classify_qda_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn ml_classify_qda_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn ml_classify_qda_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn ml_classify_qda_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn ml_classify_qda_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn ml_classify_qda_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn ml_classify_qda_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn ml_classify_qda_dbl(x : Double) -> String {
  let i = if x >= 0.0 { ml_classify_qda_int(x) } else { -ml_classify_qda_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { ml_classify_qda_int(f * 1000000.0) } else { ml_classify_qda_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn ml_classify_qda_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn ml_classify_qda_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct MlclassifyqdaFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_qda_frame_make(size : Int) -> MlclassifyqdaFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_qda_frame_len(s : MlclassifyqdaFrame) -> Int { s.size }

pub fn ml_classify_qda_frame_get(s : MlclassifyqdaFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_qda_frame_set(s : MlclassifyqdaFrame, i : Int, v : Double) -> MlclassifyqdaFrame {
  let result = ml_classify_qda_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_qda_frame_sum(s : MlclassifyqdaFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_qda_frame_mean(s : MlclassifyqdaFrame) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_qda_frame_sum(s) / s.size.to_double() }
}

pub fn ml_classify_qda_frame_scale(s : MlclassifyqdaFrame, f : Double) -> MlclassifyqdaFrame {
  let result = ml_classify_qda_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_qda_frame_add(a : MlclassifyqdaFrame, b : MlclassifyqdaFrame) -> MlclassifyqdaFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_qda_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_qda_frame_copy(s : MlclassifyqdaFrame) -> MlclassifyqdaFrame {
  let result = ml_classify_qda_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_qda_frame_fill(s : MlclassifyqdaFrame, v : Double) -> MlclassifyqdaFrame {
  let result = ml_classify_qda_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_qda_frame_min(s : MlclassifyqdaFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_qda_frame_max(s : MlclassifyqdaFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_qda_frame_to_string(s : MlclassifyqdaFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyqdaTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_qda_table_make(size : Int) -> MlclassifyqdaTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_qda_table_len(s : MlclassifyqdaTable) -> Int { s.size }

pub fn ml_classify_qda_table_get(s : MlclassifyqdaTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_qda_table_set(s : MlclassifyqdaTable, i : Int, v : Double) -> MlclassifyqdaTable {
  let result = ml_classify_qda_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_qda_table_sum(s : MlclassifyqdaTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_qda_table_mean(s : MlclassifyqdaTable) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_qda_table_sum(s) / s.size.to_double() }
}

pub fn ml_classify_qda_table_scale(s : MlclassifyqdaTable, f : Double) -> MlclassifyqdaTable {
  let result = ml_classify_qda_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_qda_table_add(a : MlclassifyqdaTable, b : MlclassifyqdaTable) -> MlclassifyqdaTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_qda_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_qda_table_copy(s : MlclassifyqdaTable) -> MlclassifyqdaTable {
  let result = ml_classify_qda_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_qda_table_fill(s : MlclassifyqdaTable, v : Double) -> MlclassifyqdaTable {
  let result = ml_classify_qda_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_qda_table_min(s : MlclassifyqdaTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_qda_table_max(s : MlclassifyqdaTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_qda_table_to_string(s : MlclassifyqdaTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyqdaGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_qda_graphn_make(size : Int) -> MlclassifyqdaGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_qda_graphn_len(s : MlclassifyqdaGraphN) -> Int { s.size }

pub fn ml_classify_qda_graphn_get(s : MlclassifyqdaGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_qda_graphn_set(s : MlclassifyqdaGraphN, i : Int, v : Double) -> MlclassifyqdaGraphN {
  let result = ml_classify_qda_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_qda_graphn_sum(s : MlclassifyqdaGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_qda_graphn_mean(s : MlclassifyqdaGraphN) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_qda_graphn_sum(s) / s.size.to_double() }
}

pub fn ml_classify_qda_graphn_scale(s : MlclassifyqdaGraphN, f : Double) -> MlclassifyqdaGraphN {
  let result = ml_classify_qda_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_qda_graphn_add(a : MlclassifyqdaGraphN, b : MlclassifyqdaGraphN) -> MlclassifyqdaGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_qda_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_qda_graphn_copy(s : MlclassifyqdaGraphN) -> MlclassifyqdaGraphN {
  let result = ml_classify_qda_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_qda_graphn_fill(s : MlclassifyqdaGraphN, v : Double) -> MlclassifyqdaGraphN {
  let result = ml_classify_qda_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_qda_graphn_min(s : MlclassifyqdaGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_qda_graphn_max(s : MlclassifyqdaGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_qda_graphn_to_string(s : MlclassifyqdaGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyqdaNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_qda_node_make(size : Int) -> MlclassifyqdaNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_qda_node_len(s : MlclassifyqdaNode) -> Int { s.size }

pub fn ml_classify_qda_node_get(s : MlclassifyqdaNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_qda_node_set(s : MlclassifyqdaNode, i : Int, v : Double) -> MlclassifyqdaNode {
  let result = ml_classify_qda_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_qda_node_sum(s : MlclassifyqdaNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_qda_node_mean(s : MlclassifyqdaNode) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_qda_node_sum(s) / s.size.to_double() }
}

pub fn ml_classify_qda_node_scale(s : MlclassifyqdaNode, f : Double) -> MlclassifyqdaNode {
  let result = ml_classify_qda_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_qda_node_add(a : MlclassifyqdaNode, b : MlclassifyqdaNode) -> MlclassifyqdaNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_qda_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_qda_node_copy(s : MlclassifyqdaNode) -> MlclassifyqdaNode {
  let result = ml_classify_qda_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_qda_node_fill(s : MlclassifyqdaNode, v : Double) -> MlclassifyqdaNode {
  let result = ml_classify_qda_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_qda_node_min(s : MlclassifyqdaNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_qda_node_max(s : MlclassifyqdaNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_qda_node_to_string(s : MlclassifyqdaNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyqdaEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_qda_edge_make(size : Int) -> MlclassifyqdaEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_qda_edge_len(s : MlclassifyqdaEdge) -> Int { s.size }

pub fn ml_classify_qda_edge_get(s : MlclassifyqdaEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_qda_edge_set(s : MlclassifyqdaEdge, i : Int, v : Double) -> MlclassifyqdaEdge {
  let result = ml_classify_qda_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_qda_edge_sum(s : MlclassifyqdaEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_qda_edge_mean(s : MlclassifyqdaEdge) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_qda_edge_sum(s) / s.size.to_double() }
}

pub fn ml_classify_qda_edge_scale(s : MlclassifyqdaEdge, f : Double) -> MlclassifyqdaEdge {
  let result = ml_classify_qda_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_qda_edge_add(a : MlclassifyqdaEdge, b : MlclassifyqdaEdge) -> MlclassifyqdaEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_qda_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_qda_edge_copy(s : MlclassifyqdaEdge) -> MlclassifyqdaEdge {
  let result = ml_classify_qda_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_qda_edge_fill(s : MlclassifyqdaEdge, v : Double) -> MlclassifyqdaEdge {
  let result = ml_classify_qda_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_qda_edge_min(s : MlclassifyqdaEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_qda_edge_max(s : MlclassifyqdaEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_qda_edge_to_string(s : MlclassifyqdaEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyqdaPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_qda_path_make(size : Int) -> MlclassifyqdaPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_qda_path_len(s : MlclassifyqdaPath) -> Int { s.size }

pub fn ml_classify_qda_path_get(s : MlclassifyqdaPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_qda_path_set(s : MlclassifyqdaPath, i : Int, v : Double) -> MlclassifyqdaPath {
  let result = ml_classify_qda_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_qda_path_sum(s : MlclassifyqdaPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_qda_path_mean(s : MlclassifyqdaPath) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_qda_path_sum(s) / s.size.to_double() }
}

pub fn ml_classify_qda_path_scale(s : MlclassifyqdaPath, f : Double) -> MlclassifyqdaPath {
  let result = ml_classify_qda_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_qda_path_add(a : MlclassifyqdaPath, b : MlclassifyqdaPath) -> MlclassifyqdaPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_qda_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_qda_path_copy(s : MlclassifyqdaPath) -> MlclassifyqdaPath {
  let result = ml_classify_qda_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_qda_path_fill(s : MlclassifyqdaPath, v : Double) -> MlclassifyqdaPath {
  let result = ml_classify_qda_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_qda_path_min(s : MlclassifyqdaPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_qda_path_max(s : MlclassifyqdaPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_qda_path_to_string(s : MlclassifyqdaPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyqdaCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_qda_cluster_make(size : Int) -> MlclassifyqdaCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_qda_cluster_len(s : MlclassifyqdaCluster) -> Int { s.size }

pub fn ml_classify_qda_cluster_get(s : MlclassifyqdaCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_qda_cluster_set(s : MlclassifyqdaCluster, i : Int, v : Double) -> MlclassifyqdaCluster {
  let result = ml_classify_qda_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_qda_cluster_sum(s : MlclassifyqdaCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_qda_cluster_mean(s : MlclassifyqdaCluster) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_qda_cluster_sum(s) / s.size.to_double() }
}

pub fn ml_classify_qda_cluster_scale(s : MlclassifyqdaCluster, f : Double) -> MlclassifyqdaCluster {
  let result = ml_classify_qda_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_qda_cluster_add(a : MlclassifyqdaCluster, b : MlclassifyqdaCluster) -> MlclassifyqdaCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_qda_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_qda_cluster_copy(s : MlclassifyqdaCluster) -> MlclassifyqdaCluster {
  let result = ml_classify_qda_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_qda_cluster_fill(s : MlclassifyqdaCluster, v : Double) -> MlclassifyqdaCluster {
  let result = ml_classify_qda_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_qda_cluster_min(s : MlclassifyqdaCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_qda_cluster_max(s : MlclassifyqdaCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_qda_cluster_to_string(s : MlclassifyqdaCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyqdaModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_qda_model_make(size : Int) -> MlclassifyqdaModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_qda_model_len(s : MlclassifyqdaModel) -> Int { s.size }

pub fn ml_classify_qda_model_get(s : MlclassifyqdaModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_qda_model_set(s : MlclassifyqdaModel, i : Int, v : Double) -> MlclassifyqdaModel {
  let result = ml_classify_qda_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_qda_model_sum(s : MlclassifyqdaModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_qda_model_mean(s : MlclassifyqdaModel) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_qda_model_sum(s) / s.size.to_double() }
}

pub fn ml_classify_qda_model_scale(s : MlclassifyqdaModel, f : Double) -> MlclassifyqdaModel {
  let result = ml_classify_qda_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_qda_model_add(a : MlclassifyqdaModel, b : MlclassifyqdaModel) -> MlclassifyqdaModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_qda_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_qda_model_copy(s : MlclassifyqdaModel) -> MlclassifyqdaModel {
  let result = ml_classify_qda_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_qda_model_fill(s : MlclassifyqdaModel, v : Double) -> MlclassifyqdaModel {
  let result = ml_classify_qda_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_qda_model_min(s : MlclassifyqdaModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_qda_model_max(s : MlclassifyqdaModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_qda_model_to_string(s : MlclassifyqdaModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyqdaLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_qda_layer_make(size : Int) -> MlclassifyqdaLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_qda_layer_len(s : MlclassifyqdaLayer) -> Int { s.size }

pub fn ml_classify_qda_layer_get(s : MlclassifyqdaLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_qda_layer_set(s : MlclassifyqdaLayer, i : Int, v : Double) -> MlclassifyqdaLayer {
  let result = ml_classify_qda_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_qda_layer_sum(s : MlclassifyqdaLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_qda_layer_mean(s : MlclassifyqdaLayer) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_qda_layer_sum(s) / s.size.to_double() }
}

pub fn ml_classify_qda_layer_scale(s : MlclassifyqdaLayer, f : Double) -> MlclassifyqdaLayer {
  let result = ml_classify_qda_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_qda_layer_add(a : MlclassifyqdaLayer, b : MlclassifyqdaLayer) -> MlclassifyqdaLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_qda_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_qda_layer_copy(s : MlclassifyqdaLayer) -> MlclassifyqdaLayer {
  let result = ml_classify_qda_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_qda_layer_fill(s : MlclassifyqdaLayer, v : Double) -> MlclassifyqdaLayer {
  let result = ml_classify_qda_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_qda_layer_min(s : MlclassifyqdaLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_qda_layer_max(s : MlclassifyqdaLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_qda_layer_to_string(s : MlclassifyqdaLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyqdaBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_qda_buffer_make(size : Int) -> MlclassifyqdaBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_qda_buffer_len(s : MlclassifyqdaBuffer) -> Int { s.size }

pub fn ml_classify_qda_buffer_get(s : MlclassifyqdaBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_qda_buffer_set(s : MlclassifyqdaBuffer, i : Int, v : Double) -> MlclassifyqdaBuffer {
  let result = ml_classify_qda_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_qda_buffer_sum(s : MlclassifyqdaBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_qda_buffer_mean(s : MlclassifyqdaBuffer) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_qda_buffer_sum(s) / s.size.to_double() }
}

pub fn ml_classify_qda_buffer_scale(s : MlclassifyqdaBuffer, f : Double) -> MlclassifyqdaBuffer {
  let result = ml_classify_qda_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_qda_buffer_add(a : MlclassifyqdaBuffer, b : MlclassifyqdaBuffer) -> MlclassifyqdaBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_qda_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_qda_buffer_copy(s : MlclassifyqdaBuffer) -> MlclassifyqdaBuffer {
  let result = ml_classify_qda_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_qda_buffer_fill(s : MlclassifyqdaBuffer, v : Double) -> MlclassifyqdaBuffer {
  let result = ml_classify_qda_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_qda_buffer_min(s : MlclassifyqdaBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_qda_buffer_max(s : MlclassifyqdaBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_qda_buffer_to_string(s : MlclassifyqdaBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyqdaCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_qda_cursor_make(size : Int) -> MlclassifyqdaCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_qda_cursor_len(s : MlclassifyqdaCursor) -> Int { s.size }

pub fn ml_classify_qda_cursor_get(s : MlclassifyqdaCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_qda_cursor_set(s : MlclassifyqdaCursor, i : Int, v : Double) -> MlclassifyqdaCursor {
  let result = ml_classify_qda_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_qda_cursor_sum(s : MlclassifyqdaCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_qda_cursor_mean(s : MlclassifyqdaCursor) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_qda_cursor_sum(s) / s.size.to_double() }
}

pub fn ml_classify_qda_cursor_scale(s : MlclassifyqdaCursor, f : Double) -> MlclassifyqdaCursor {
  let result = ml_classify_qda_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_qda_cursor_add(a : MlclassifyqdaCursor, b : MlclassifyqdaCursor) -> MlclassifyqdaCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_qda_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_qda_cursor_copy(s : MlclassifyqdaCursor) -> MlclassifyqdaCursor {
  let result = ml_classify_qda_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_qda_cursor_fill(s : MlclassifyqdaCursor, v : Double) -> MlclassifyqdaCursor {
  let result = ml_classify_qda_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_qda_cursor_min(s : MlclassifyqdaCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_qda_cursor_max(s : MlclassifyqdaCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_qda_cursor_to_string(s : MlclassifyqdaCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyqdaView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_qda_view_make(size : Int) -> MlclassifyqdaView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_qda_view_len(s : MlclassifyqdaView) -> Int { s.size }

pub fn ml_classify_qda_view_get(s : MlclassifyqdaView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_qda_view_set(s : MlclassifyqdaView, i : Int, v : Double) -> MlclassifyqdaView {
  let result = ml_classify_qda_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_qda_view_sum(s : MlclassifyqdaView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_qda_view_mean(s : MlclassifyqdaView) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_qda_view_sum(s) / s.size.to_double() }
}

pub fn ml_classify_qda_view_scale(s : MlclassifyqdaView, f : Double) -> MlclassifyqdaView {
  let result = ml_classify_qda_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_qda_view_add(a : MlclassifyqdaView, b : MlclassifyqdaView) -> MlclassifyqdaView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_qda_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_qda_view_copy(s : MlclassifyqdaView) -> MlclassifyqdaView {
  let result = ml_classify_qda_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_qda_view_fill(s : MlclassifyqdaView, v : Double) -> MlclassifyqdaView {
  let result = ml_classify_qda_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_qda_view_min(s : MlclassifyqdaView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_qda_view_max(s : MlclassifyqdaView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_qda_view_to_string(s : MlclassifyqdaView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyqdaRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_qda_range_make(size : Int) -> MlclassifyqdaRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_qda_range_len(s : MlclassifyqdaRange) -> Int { s.size }

pub fn ml_classify_qda_range_get(s : MlclassifyqdaRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_qda_range_set(s : MlclassifyqdaRange, i : Int, v : Double) -> MlclassifyqdaRange {
  let result = ml_classify_qda_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_qda_range_sum(s : MlclassifyqdaRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_qda_range_mean(s : MlclassifyqdaRange) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_qda_range_sum(s) / s.size.to_double() }
}

pub fn ml_classify_qda_range_scale(s : MlclassifyqdaRange, f : Double) -> MlclassifyqdaRange {
  let result = ml_classify_qda_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_qda_range_add(a : MlclassifyqdaRange, b : MlclassifyqdaRange) -> MlclassifyqdaRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_qda_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_qda_range_copy(s : MlclassifyqdaRange) -> MlclassifyqdaRange {
  let result = ml_classify_qda_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_qda_range_fill(s : MlclassifyqdaRange, v : Double) -> MlclassifyqdaRange {
  let result = ml_classify_qda_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_qda_range_min(s : MlclassifyqdaRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_qda_range_max(s : MlclassifyqdaRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_qda_range_to_string(s : MlclassifyqdaRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyqdaSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_qda_slice_make(size : Int) -> MlclassifyqdaSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_qda_slice_len(s : MlclassifyqdaSlice) -> Int { s.size }

pub fn ml_classify_qda_slice_get(s : MlclassifyqdaSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_qda_slice_set(s : MlclassifyqdaSlice, i : Int, v : Double) -> MlclassifyqdaSlice {
  let result = ml_classify_qda_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_qda_slice_sum(s : MlclassifyqdaSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_qda_slice_mean(s : MlclassifyqdaSlice) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_qda_slice_sum(s) / s.size.to_double() }
}

pub fn ml_classify_qda_slice_scale(s : MlclassifyqdaSlice, f : Double) -> MlclassifyqdaSlice {
  let result = ml_classify_qda_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_qda_slice_add(a : MlclassifyqdaSlice, b : MlclassifyqdaSlice) -> MlclassifyqdaSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_qda_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_qda_slice_copy(s : MlclassifyqdaSlice) -> MlclassifyqdaSlice {
  let result = ml_classify_qda_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_qda_slice_fill(s : MlclassifyqdaSlice, v : Double) -> MlclassifyqdaSlice {
  let result = ml_classify_qda_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_qda_slice_min(s : MlclassifyqdaSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_qda_slice_max(s : MlclassifyqdaSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_qda_slice_to_string(s : MlclassifyqdaSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn ml_classify_qda_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_classify_qda_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_classify_qda_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_classify_qda_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_classify_qda_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_classify_qda_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_classify_qda_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_classify_qda_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_classify_qda_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_classify_qda_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_classify_qda_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_classify_qda_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_classify_qda_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_classify_qda_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_classify_qda_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_classify_qda_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_classify_qda_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_classify_qda_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_classify_qda_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_classify_qda_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_classify_qda_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_classify_qda_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_classify_qda_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_classify_qda_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_classify_qda_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}


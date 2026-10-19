///===
/// extcore/ml_classify_lda

pub(all) struct MlclassifyldaPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_classify_lda_make_point(x : Double, y : Double) -> MlclassifyldaPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_classify_lda_make_point3(x : Double, y : Double, z : Double) -> MlclassifyldaPoint {
  { x, y, z, label: 0 }
}

pub fn ml_classify_lda_point_x(pt : MlclassifyldaPoint) -> Double { pt.x }

pub fn ml_classify_lda_point_y(pt : MlclassifyldaPoint) -> Double { pt.y }

pub fn ml_classify_lda_point_z(pt : MlclassifyldaPoint) -> Double { pt.z }

pub fn ml_classify_lda_point_label(pt : MlclassifyldaPoint) -> Int { pt.label }

pub fn ml_classify_lda_point_dist(a : MlclassifyldaPoint, b : MlclassifyldaPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  ml_classify_lda_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ml_classify_lda_point_add(a : MlclassifyldaPoint, b : MlclassifyldaPoint) -> MlclassifyldaPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ml_classify_lda_point_sub(a : MlclassifyldaPoint, b : MlclassifyldaPoint) -> MlclassifyldaPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ml_classify_lda_point_scale(pt : MlclassifyldaPoint, s : Double) -> MlclassifyldaPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ml_classify_lda_point_dot(a : MlclassifyldaPoint, b : MlclassifyldaPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ml_classify_lda_point_cross(a : MlclassifyldaPoint, b : MlclassifyldaPoint) -> MlclassifyldaPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ml_classify_lda_point_norm(pt : MlclassifyldaPoint) -> Double {
  ml_classify_lda_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ml_classify_lda_point_normalize(pt : MlclassifyldaPoint) -> MlclassifyldaPoint {
  let n = ml_classify_lda_point_norm(pt)
  if n < 0.0000001 { pt } else { ml_classify_lda_point_scale(pt, 1.0 / n) }
}

pub fn ml_classify_lda_point_negate(pt : MlclassifyldaPoint) -> MlclassifyldaPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ml_classify_lda_point_mid(a : MlclassifyldaPoint, b : MlclassifyldaPoint) -> MlclassifyldaPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ml_classify_lda_point_lerp(a : MlclassifyldaPoint, b : MlclassifyldaPoint, t : Double) -> MlclassifyldaPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ml_classify_lda_point_to_string(pt : MlclassifyldaPoint) -> String {
  "(" + ml_classify_lda_dbl(pt.x) + ", " + ml_classify_lda_dbl(pt.y) + ", " + ml_classify_lda_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MlclassifyldaSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_classify_lda_make_series(vals : Array[Double], name : String) -> MlclassifyldaSeries {
  { vals, name, meta: 0 }
}

pub fn ml_classify_lda_series_len(s : MlclassifyldaSeries) -> Int { s.vals.length() }

pub fn ml_classify_lda_series_sum(s : MlclassifyldaSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn ml_classify_lda_series_mean(s : MlclassifyldaSeries) -> Double {
  let n = ml_classify_lda_series_len(s)
  if n == 0 { 0.0 } else { ml_classify_lda_series_sum(s) / n.to_double() }
}

pub fn ml_classify_lda_series_min(s : MlclassifyldaSeries) -> Double {
  let n = ml_classify_lda_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn ml_classify_lda_series_max(s : MlclassifyldaSeries) -> Double {
  let n = ml_classify_lda_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn ml_classify_lda_series_range(s : MlclassifyldaSeries) -> Double {
  ml_classify_lda_series_max(s) - ml_classify_lda_series_min(s)
}

pub fn ml_classify_lda_series_var(s : MlclassifyldaSeries) -> Double {
  let n = ml_classify_lda_series_len(s)
  if n == 0 { 0.0 } else {
    let m = ml_classify_lda_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn ml_classify_lda_series_std(s : MlclassifyldaSeries) -> Double { ml_classify_lda_sqrt(ml_classify_lda_series_var(s)) }

pub fn ml_classify_lda_series_median(s : MlclassifyldaSeries) -> Double {
  let n = ml_classify_lda_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = ml_classify_lda_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ml_classify_lda_series_scale(s : MlclassifyldaSeries, f : Double) -> MlclassifyldaSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = ml_classify_lda_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ml_classify_lda_series_add(a : MlclassifyldaSeries, b : MlclassifyldaSeries) -> MlclassifyldaSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = ml_classify_lda_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ml_classify_lda_series_sub(a : MlclassifyldaSeries, b : MlclassifyldaSeries) -> MlclassifyldaSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = ml_classify_lda_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ml_classify_lda_series_normalize(s : MlclassifyldaSeries) -> MlclassifyldaSeries {
  let mn = ml_classify_lda_series_min(s)
  let mx = ml_classify_lda_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = ml_classify_lda_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ml_classify_lda_series_cumsum(s : MlclassifyldaSeries) -> MlclassifyldaSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = ml_classify_lda_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn ml_classify_lda_series_to_string(s : MlclassifyldaSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + ml_classify_lda_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlclassifyldaMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_classify_lda_make_matrix(rows : Int, cols : Int, val : Double) -> MlclassifyldaMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_classify_lda_matrix_identity(n : Int) -> MlclassifyldaMatrix {
  let m = ml_classify_lda_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ml_classify_lda_matrix_get(m : MlclassifyldaMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ml_classify_lda_matrix_transpose(m : MlclassifyldaMatrix) -> MlclassifyldaMatrix {
  let result = ml_classify_lda_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ml_classify_lda_matrix_add(a : MlclassifyldaMatrix, b : MlclassifyldaMatrix) -> MlclassifyldaMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ml_classify_lda_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ml_classify_lda_matrix_scale(m : MlclassifyldaMatrix, s : Double) -> MlclassifyldaMatrix {
  let result = ml_classify_lda_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ml_classify_lda_matrix_multiply(a : MlclassifyldaMatrix, b : MlclassifyldaMatrix) -> MlclassifyldaMatrix {
  if a.cols != b.rows { return ml_classify_lda_make_matrix(a.rows, b.cols, 0.0) }
  let result = ml_classify_lda_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ml_classify_lda_matrix_trace(m : MlclassifyldaMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ml_classify_lda_matrix_det(m : MlclassifyldaMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ml_classify_lda_matrix_norm(m : MlclassifyldaMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  ml_classify_lda_sqrt(sum)
}

pub fn ml_classify_lda_matrix_to_string(m : MlclassifyldaMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + ml_classify_lda_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct MlclassifyldaVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_classify_lda_make_vector(comps : Array[Double]) -> MlclassifyldaVector {
  { comps, dim: comps.length() }
}

pub fn ml_classify_lda_vector_zero(dim : Int) -> MlclassifyldaVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ml_classify_lda_vector_add(a : MlclassifyldaVector, b : MlclassifyldaVector) -> MlclassifyldaVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = ml_classify_lda_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_classify_lda_vector_sub(a : MlclassifyldaVector, b : MlclassifyldaVector) -> MlclassifyldaVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = ml_classify_lda_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_classify_lda_vector_scale(v : MlclassifyldaVector, s : Double) -> MlclassifyldaVector {
  let mut result = []
  for i in 0..<v.dim { result = ml_classify_lda_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ml_classify_lda_vector_dot(a : MlclassifyldaVector, b : MlclassifyldaVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ml_classify_lda_vector_norm(v : MlclassifyldaVector) -> Double { ml_classify_lda_sqrt(ml_classify_lda_vector_dot(v, v)) }

pub fn ml_classify_lda_vector_normalize(v : MlclassifyldaVector) -> MlclassifyldaVector {
  let n = ml_classify_lda_vector_norm(v)
  if n < 0.0000001 { v } else { ml_classify_lda_vector_scale(v, 1.0 / n) }
}

pub fn ml_classify_lda_vector_dist(a : MlclassifyldaVector, b : MlclassifyldaVector) -> Double {
  ml_classify_lda_vector_norm(ml_classify_lda_vector_sub(a, b))
}

pub fn ml_classify_lda_vector_to_string(v : MlclassifyldaVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + ml_classify_lda_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_classify_lda_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn ml_classify_lda_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = ml_classify_lda_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ml_classify_lda_std(data : Array[Double]) -> Double { ml_classify_lda_sqrt(ml_classify_lda_var(data)) }

pub fn ml_classify_lda_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = ml_classify_lda_mean(a); let mb = ml_classify_lda_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn ml_classify_lda_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = ml_classify_lda_std(a); let sb = ml_classify_lda_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { ml_classify_lda_cov(a, b) / (sa * sb) }
}

pub fn ml_classify_lda_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = ml_classify_lda_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ml_classify_lda_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn ml_classify_lda_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ml_classify_lda_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  ml_classify_lda_sqrt(ml_classify_lda_mse(pred, labels))
}

pub fn ml_classify_lda_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + ml_classify_lda_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn ml_classify_lda_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = ml_classify_lda_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn ml_classify_lda_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn ml_classify_lda_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn ml_classify_lda_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = ml_classify_lda_precision(pred, labels, pos); let r = ml_classify_lda_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn ml_classify_lda_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn ml_classify_lda_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = ml_classify_lda_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn ml_classify_lda_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn ml_classify_lda_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn ml_classify_lda_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = ml_classify_lda_gcd(a, b)
    (a / g) * b
  }
}

pub fn ml_classify_lda_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn ml_classify_lda_fibonacci(n : Int) -> Int {
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

pub fn ml_classify_lda_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = ml_classify_lda_min(data); let mx = ml_classify_lda_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn ml_classify_lda_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = ml_classify_lda_mean(data); let sd = ml_classify_lda_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn ml_classify_lda_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn ml_classify_lda_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn ml_classify_lda_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn ml_classify_lda_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn ml_classify_lda_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn ml_classify_lda_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn ml_classify_lda_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn ml_classify_lda_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn ml_classify_lda_dbl(x : Double) -> String {
  let i = if x >= 0.0 { ml_classify_lda_int(x) } else { -ml_classify_lda_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { ml_classify_lda_int(f * 1000000.0) } else { ml_classify_lda_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn ml_classify_lda_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn ml_classify_lda_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct MlclassifyldaFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_lda_frame_make(size : Int) -> MlclassifyldaFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_lda_frame_len(s : MlclassifyldaFrame) -> Int { s.size }

pub fn ml_classify_lda_frame_get(s : MlclassifyldaFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_lda_frame_set(s : MlclassifyldaFrame, i : Int, v : Double) -> MlclassifyldaFrame {
  let result = ml_classify_lda_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_lda_frame_sum(s : MlclassifyldaFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_lda_frame_mean(s : MlclassifyldaFrame) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_lda_frame_sum(s) / s.size.to_double() }
}

pub fn ml_classify_lda_frame_scale(s : MlclassifyldaFrame, f : Double) -> MlclassifyldaFrame {
  let result = ml_classify_lda_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_lda_frame_add(a : MlclassifyldaFrame, b : MlclassifyldaFrame) -> MlclassifyldaFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_lda_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_lda_frame_copy(s : MlclassifyldaFrame) -> MlclassifyldaFrame {
  let result = ml_classify_lda_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_lda_frame_fill(s : MlclassifyldaFrame, v : Double) -> MlclassifyldaFrame {
  let result = ml_classify_lda_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_lda_frame_min(s : MlclassifyldaFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_lda_frame_max(s : MlclassifyldaFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_lda_frame_to_string(s : MlclassifyldaFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyldaTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_lda_table_make(size : Int) -> MlclassifyldaTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_lda_table_len(s : MlclassifyldaTable) -> Int { s.size }

pub fn ml_classify_lda_table_get(s : MlclassifyldaTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_lda_table_set(s : MlclassifyldaTable, i : Int, v : Double) -> MlclassifyldaTable {
  let result = ml_classify_lda_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_lda_table_sum(s : MlclassifyldaTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_lda_table_mean(s : MlclassifyldaTable) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_lda_table_sum(s) / s.size.to_double() }
}

pub fn ml_classify_lda_table_scale(s : MlclassifyldaTable, f : Double) -> MlclassifyldaTable {
  let result = ml_classify_lda_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_lda_table_add(a : MlclassifyldaTable, b : MlclassifyldaTable) -> MlclassifyldaTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_lda_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_lda_table_copy(s : MlclassifyldaTable) -> MlclassifyldaTable {
  let result = ml_classify_lda_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_lda_table_fill(s : MlclassifyldaTable, v : Double) -> MlclassifyldaTable {
  let result = ml_classify_lda_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_lda_table_min(s : MlclassifyldaTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_lda_table_max(s : MlclassifyldaTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_lda_table_to_string(s : MlclassifyldaTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyldaGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_lda_graphn_make(size : Int) -> MlclassifyldaGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_lda_graphn_len(s : MlclassifyldaGraphN) -> Int { s.size }

pub fn ml_classify_lda_graphn_get(s : MlclassifyldaGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_lda_graphn_set(s : MlclassifyldaGraphN, i : Int, v : Double) -> MlclassifyldaGraphN {
  let result = ml_classify_lda_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_lda_graphn_sum(s : MlclassifyldaGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_lda_graphn_mean(s : MlclassifyldaGraphN) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_lda_graphn_sum(s) / s.size.to_double() }
}

pub fn ml_classify_lda_graphn_scale(s : MlclassifyldaGraphN, f : Double) -> MlclassifyldaGraphN {
  let result = ml_classify_lda_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_lda_graphn_add(a : MlclassifyldaGraphN, b : MlclassifyldaGraphN) -> MlclassifyldaGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_lda_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_lda_graphn_copy(s : MlclassifyldaGraphN) -> MlclassifyldaGraphN {
  let result = ml_classify_lda_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_lda_graphn_fill(s : MlclassifyldaGraphN, v : Double) -> MlclassifyldaGraphN {
  let result = ml_classify_lda_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_lda_graphn_min(s : MlclassifyldaGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_lda_graphn_max(s : MlclassifyldaGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_lda_graphn_to_string(s : MlclassifyldaGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyldaNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_lda_node_make(size : Int) -> MlclassifyldaNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_lda_node_len(s : MlclassifyldaNode) -> Int { s.size }

pub fn ml_classify_lda_node_get(s : MlclassifyldaNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_lda_node_set(s : MlclassifyldaNode, i : Int, v : Double) -> MlclassifyldaNode {
  let result = ml_classify_lda_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_lda_node_sum(s : MlclassifyldaNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_lda_node_mean(s : MlclassifyldaNode) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_lda_node_sum(s) / s.size.to_double() }
}

pub fn ml_classify_lda_node_scale(s : MlclassifyldaNode, f : Double) -> MlclassifyldaNode {
  let result = ml_classify_lda_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_lda_node_add(a : MlclassifyldaNode, b : MlclassifyldaNode) -> MlclassifyldaNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_lda_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_lda_node_copy(s : MlclassifyldaNode) -> MlclassifyldaNode {
  let result = ml_classify_lda_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_lda_node_fill(s : MlclassifyldaNode, v : Double) -> MlclassifyldaNode {
  let result = ml_classify_lda_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_lda_node_min(s : MlclassifyldaNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_lda_node_max(s : MlclassifyldaNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_lda_node_to_string(s : MlclassifyldaNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyldaEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_lda_edge_make(size : Int) -> MlclassifyldaEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_lda_edge_len(s : MlclassifyldaEdge) -> Int { s.size }

pub fn ml_classify_lda_edge_get(s : MlclassifyldaEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_lda_edge_set(s : MlclassifyldaEdge, i : Int, v : Double) -> MlclassifyldaEdge {
  let result = ml_classify_lda_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_lda_edge_sum(s : MlclassifyldaEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_lda_edge_mean(s : MlclassifyldaEdge) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_lda_edge_sum(s) / s.size.to_double() }
}

pub fn ml_classify_lda_edge_scale(s : MlclassifyldaEdge, f : Double) -> MlclassifyldaEdge {
  let result = ml_classify_lda_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_lda_edge_add(a : MlclassifyldaEdge, b : MlclassifyldaEdge) -> MlclassifyldaEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_lda_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_lda_edge_copy(s : MlclassifyldaEdge) -> MlclassifyldaEdge {
  let result = ml_classify_lda_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_lda_edge_fill(s : MlclassifyldaEdge, v : Double) -> MlclassifyldaEdge {
  let result = ml_classify_lda_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_lda_edge_min(s : MlclassifyldaEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_lda_edge_max(s : MlclassifyldaEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_lda_edge_to_string(s : MlclassifyldaEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyldaPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_lda_path_make(size : Int) -> MlclassifyldaPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_lda_path_len(s : MlclassifyldaPath) -> Int { s.size }

pub fn ml_classify_lda_path_get(s : MlclassifyldaPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_lda_path_set(s : MlclassifyldaPath, i : Int, v : Double) -> MlclassifyldaPath {
  let result = ml_classify_lda_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_lda_path_sum(s : MlclassifyldaPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_lda_path_mean(s : MlclassifyldaPath) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_lda_path_sum(s) / s.size.to_double() }
}

pub fn ml_classify_lda_path_scale(s : MlclassifyldaPath, f : Double) -> MlclassifyldaPath {
  let result = ml_classify_lda_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_lda_path_add(a : MlclassifyldaPath, b : MlclassifyldaPath) -> MlclassifyldaPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_lda_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_lda_path_copy(s : MlclassifyldaPath) -> MlclassifyldaPath {
  let result = ml_classify_lda_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_lda_path_fill(s : MlclassifyldaPath, v : Double) -> MlclassifyldaPath {
  let result = ml_classify_lda_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_lda_path_min(s : MlclassifyldaPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_lda_path_max(s : MlclassifyldaPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_lda_path_to_string(s : MlclassifyldaPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyldaCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_lda_cluster_make(size : Int) -> MlclassifyldaCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_lda_cluster_len(s : MlclassifyldaCluster) -> Int { s.size }

pub fn ml_classify_lda_cluster_get(s : MlclassifyldaCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_lda_cluster_set(s : MlclassifyldaCluster, i : Int, v : Double) -> MlclassifyldaCluster {
  let result = ml_classify_lda_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_lda_cluster_sum(s : MlclassifyldaCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_lda_cluster_mean(s : MlclassifyldaCluster) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_lda_cluster_sum(s) / s.size.to_double() }
}

pub fn ml_classify_lda_cluster_scale(s : MlclassifyldaCluster, f : Double) -> MlclassifyldaCluster {
  let result = ml_classify_lda_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_lda_cluster_add(a : MlclassifyldaCluster, b : MlclassifyldaCluster) -> MlclassifyldaCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_lda_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_lda_cluster_copy(s : MlclassifyldaCluster) -> MlclassifyldaCluster {
  let result = ml_classify_lda_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_lda_cluster_fill(s : MlclassifyldaCluster, v : Double) -> MlclassifyldaCluster {
  let result = ml_classify_lda_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_lda_cluster_min(s : MlclassifyldaCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_lda_cluster_max(s : MlclassifyldaCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_lda_cluster_to_string(s : MlclassifyldaCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyldaModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_lda_model_make(size : Int) -> MlclassifyldaModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_lda_model_len(s : MlclassifyldaModel) -> Int { s.size }

pub fn ml_classify_lda_model_get(s : MlclassifyldaModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_lda_model_set(s : MlclassifyldaModel, i : Int, v : Double) -> MlclassifyldaModel {
  let result = ml_classify_lda_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_lda_model_sum(s : MlclassifyldaModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_lda_model_mean(s : MlclassifyldaModel) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_lda_model_sum(s) / s.size.to_double() }
}

pub fn ml_classify_lda_model_scale(s : MlclassifyldaModel, f : Double) -> MlclassifyldaModel {
  let result = ml_classify_lda_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_lda_model_add(a : MlclassifyldaModel, b : MlclassifyldaModel) -> MlclassifyldaModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_lda_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_lda_model_copy(s : MlclassifyldaModel) -> MlclassifyldaModel {
  let result = ml_classify_lda_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_lda_model_fill(s : MlclassifyldaModel, v : Double) -> MlclassifyldaModel {
  let result = ml_classify_lda_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_lda_model_min(s : MlclassifyldaModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_lda_model_max(s : MlclassifyldaModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_lda_model_to_string(s : MlclassifyldaModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyldaLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_lda_layer_make(size : Int) -> MlclassifyldaLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_lda_layer_len(s : MlclassifyldaLayer) -> Int { s.size }

pub fn ml_classify_lda_layer_get(s : MlclassifyldaLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_lda_layer_set(s : MlclassifyldaLayer, i : Int, v : Double) -> MlclassifyldaLayer {
  let result = ml_classify_lda_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_lda_layer_sum(s : MlclassifyldaLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_lda_layer_mean(s : MlclassifyldaLayer) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_lda_layer_sum(s) / s.size.to_double() }
}

pub fn ml_classify_lda_layer_scale(s : MlclassifyldaLayer, f : Double) -> MlclassifyldaLayer {
  let result = ml_classify_lda_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_lda_layer_add(a : MlclassifyldaLayer, b : MlclassifyldaLayer) -> MlclassifyldaLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_lda_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_lda_layer_copy(s : MlclassifyldaLayer) -> MlclassifyldaLayer {
  let result = ml_classify_lda_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_lda_layer_fill(s : MlclassifyldaLayer, v : Double) -> MlclassifyldaLayer {
  let result = ml_classify_lda_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_lda_layer_min(s : MlclassifyldaLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_lda_layer_max(s : MlclassifyldaLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_lda_layer_to_string(s : MlclassifyldaLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyldaBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_lda_buffer_make(size : Int) -> MlclassifyldaBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_lda_buffer_len(s : MlclassifyldaBuffer) -> Int { s.size }

pub fn ml_classify_lda_buffer_get(s : MlclassifyldaBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_lda_buffer_set(s : MlclassifyldaBuffer, i : Int, v : Double) -> MlclassifyldaBuffer {
  let result = ml_classify_lda_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_lda_buffer_sum(s : MlclassifyldaBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_lda_buffer_mean(s : MlclassifyldaBuffer) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_lda_buffer_sum(s) / s.size.to_double() }
}

pub fn ml_classify_lda_buffer_scale(s : MlclassifyldaBuffer, f : Double) -> MlclassifyldaBuffer {
  let result = ml_classify_lda_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_lda_buffer_add(a : MlclassifyldaBuffer, b : MlclassifyldaBuffer) -> MlclassifyldaBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_lda_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_lda_buffer_copy(s : MlclassifyldaBuffer) -> MlclassifyldaBuffer {
  let result = ml_classify_lda_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_lda_buffer_fill(s : MlclassifyldaBuffer, v : Double) -> MlclassifyldaBuffer {
  let result = ml_classify_lda_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_lda_buffer_min(s : MlclassifyldaBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_lda_buffer_max(s : MlclassifyldaBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_lda_buffer_to_string(s : MlclassifyldaBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyldaCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_lda_cursor_make(size : Int) -> MlclassifyldaCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_lda_cursor_len(s : MlclassifyldaCursor) -> Int { s.size }

pub fn ml_classify_lda_cursor_get(s : MlclassifyldaCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_lda_cursor_set(s : MlclassifyldaCursor, i : Int, v : Double) -> MlclassifyldaCursor {
  let result = ml_classify_lda_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_lda_cursor_sum(s : MlclassifyldaCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_lda_cursor_mean(s : MlclassifyldaCursor) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_lda_cursor_sum(s) / s.size.to_double() }
}

pub fn ml_classify_lda_cursor_scale(s : MlclassifyldaCursor, f : Double) -> MlclassifyldaCursor {
  let result = ml_classify_lda_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_lda_cursor_add(a : MlclassifyldaCursor, b : MlclassifyldaCursor) -> MlclassifyldaCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_lda_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_lda_cursor_copy(s : MlclassifyldaCursor) -> MlclassifyldaCursor {
  let result = ml_classify_lda_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_lda_cursor_fill(s : MlclassifyldaCursor, v : Double) -> MlclassifyldaCursor {
  let result = ml_classify_lda_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_lda_cursor_min(s : MlclassifyldaCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_lda_cursor_max(s : MlclassifyldaCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_lda_cursor_to_string(s : MlclassifyldaCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyldaView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_lda_view_make(size : Int) -> MlclassifyldaView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_lda_view_len(s : MlclassifyldaView) -> Int { s.size }

pub fn ml_classify_lda_view_get(s : MlclassifyldaView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_lda_view_set(s : MlclassifyldaView, i : Int, v : Double) -> MlclassifyldaView {
  let result = ml_classify_lda_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_lda_view_sum(s : MlclassifyldaView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_lda_view_mean(s : MlclassifyldaView) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_lda_view_sum(s) / s.size.to_double() }
}

pub fn ml_classify_lda_view_scale(s : MlclassifyldaView, f : Double) -> MlclassifyldaView {
  let result = ml_classify_lda_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_lda_view_add(a : MlclassifyldaView, b : MlclassifyldaView) -> MlclassifyldaView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_lda_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_lda_view_copy(s : MlclassifyldaView) -> MlclassifyldaView {
  let result = ml_classify_lda_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_lda_view_fill(s : MlclassifyldaView, v : Double) -> MlclassifyldaView {
  let result = ml_classify_lda_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_lda_view_min(s : MlclassifyldaView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_lda_view_max(s : MlclassifyldaView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_lda_view_to_string(s : MlclassifyldaView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyldaRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_lda_range_make(size : Int) -> MlclassifyldaRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_lda_range_len(s : MlclassifyldaRange) -> Int { s.size }

pub fn ml_classify_lda_range_get(s : MlclassifyldaRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_lda_range_set(s : MlclassifyldaRange, i : Int, v : Double) -> MlclassifyldaRange {
  let result = ml_classify_lda_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_lda_range_sum(s : MlclassifyldaRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_lda_range_mean(s : MlclassifyldaRange) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_lda_range_sum(s) / s.size.to_double() }
}

pub fn ml_classify_lda_range_scale(s : MlclassifyldaRange, f : Double) -> MlclassifyldaRange {
  let result = ml_classify_lda_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_lda_range_add(a : MlclassifyldaRange, b : MlclassifyldaRange) -> MlclassifyldaRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_lda_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_lda_range_copy(s : MlclassifyldaRange) -> MlclassifyldaRange {
  let result = ml_classify_lda_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_lda_range_fill(s : MlclassifyldaRange, v : Double) -> MlclassifyldaRange {
  let result = ml_classify_lda_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_lda_range_min(s : MlclassifyldaRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_lda_range_max(s : MlclassifyldaRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_lda_range_to_string(s : MlclassifyldaRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyldaSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_lda_slice_make(size : Int) -> MlclassifyldaSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_lda_slice_len(s : MlclassifyldaSlice) -> Int { s.size }

pub fn ml_classify_lda_slice_get(s : MlclassifyldaSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_lda_slice_set(s : MlclassifyldaSlice, i : Int, v : Double) -> MlclassifyldaSlice {
  let result = ml_classify_lda_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_lda_slice_sum(s : MlclassifyldaSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_lda_slice_mean(s : MlclassifyldaSlice) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_lda_slice_sum(s) / s.size.to_double() }
}

pub fn ml_classify_lda_slice_scale(s : MlclassifyldaSlice, f : Double) -> MlclassifyldaSlice {
  let result = ml_classify_lda_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_lda_slice_add(a : MlclassifyldaSlice, b : MlclassifyldaSlice) -> MlclassifyldaSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_lda_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_lda_slice_copy(s : MlclassifyldaSlice) -> MlclassifyldaSlice {
  let result = ml_classify_lda_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_lda_slice_fill(s : MlclassifyldaSlice, v : Double) -> MlclassifyldaSlice {
  let result = ml_classify_lda_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_lda_slice_min(s : MlclassifyldaSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_lda_slice_max(s : MlclassifyldaSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_lda_slice_to_string(s : MlclassifyldaSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn ml_classify_lda_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_classify_lda_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_classify_lda_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_classify_lda_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_classify_lda_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_classify_lda_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_classify_lda_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_classify_lda_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_classify_lda_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_classify_lda_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_classify_lda_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_classify_lda_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_classify_lda_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_classify_lda_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_classify_lda_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_classify_lda_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_classify_lda_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_classify_lda_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_classify_lda_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_classify_lda_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_classify_lda_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_classify_lda_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_classify_lda_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_classify_lda_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_classify_lda_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}


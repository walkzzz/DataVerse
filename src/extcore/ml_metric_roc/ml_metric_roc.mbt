///===
/// extcore/ml_metric_roc

pub(all) struct MlmetricrocPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_metric_roc_make_point(x : Double, y : Double) -> MlmetricrocPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_metric_roc_make_point3(x : Double, y : Double, z : Double) -> MlmetricrocPoint {
  { x, y, z, label: 0 }
}

pub fn ml_metric_roc_point_x(pt : MlmetricrocPoint) -> Double { pt.x }

pub fn ml_metric_roc_point_y(pt : MlmetricrocPoint) -> Double { pt.y }

pub fn ml_metric_roc_point_z(pt : MlmetricrocPoint) -> Double { pt.z }

pub fn ml_metric_roc_point_label(pt : MlmetricrocPoint) -> Int { pt.label }

pub fn ml_metric_roc_point_dist(a : MlmetricrocPoint, b : MlmetricrocPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  ml_metric_roc_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ml_metric_roc_point_add(a : MlmetricrocPoint, b : MlmetricrocPoint) -> MlmetricrocPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ml_metric_roc_point_sub(a : MlmetricrocPoint, b : MlmetricrocPoint) -> MlmetricrocPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ml_metric_roc_point_scale(pt : MlmetricrocPoint, s : Double) -> MlmetricrocPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ml_metric_roc_point_dot(a : MlmetricrocPoint, b : MlmetricrocPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ml_metric_roc_point_cross(a : MlmetricrocPoint, b : MlmetricrocPoint) -> MlmetricrocPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ml_metric_roc_point_norm(pt : MlmetricrocPoint) -> Double {
  ml_metric_roc_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ml_metric_roc_point_normalize(pt : MlmetricrocPoint) -> MlmetricrocPoint {
  let n = ml_metric_roc_point_norm(pt)
  if n < 0.0000001 { pt } else { ml_metric_roc_point_scale(pt, 1.0 / n) }
}

pub fn ml_metric_roc_point_negate(pt : MlmetricrocPoint) -> MlmetricrocPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ml_metric_roc_point_mid(a : MlmetricrocPoint, b : MlmetricrocPoint) -> MlmetricrocPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ml_metric_roc_point_lerp(a : MlmetricrocPoint, b : MlmetricrocPoint, t : Double) -> MlmetricrocPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ml_metric_roc_point_to_string(pt : MlmetricrocPoint) -> String {
  "(" + ml_metric_roc_dbl(pt.x) + ", " + ml_metric_roc_dbl(pt.y) + ", " + ml_metric_roc_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MlmetricrocSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_metric_roc_make_series(vals : Array[Double], name : String) -> MlmetricrocSeries {
  { vals, name, meta: 0 }
}

pub fn ml_metric_roc_series_len(s : MlmetricrocSeries) -> Int { s.vals.length() }

pub fn ml_metric_roc_series_sum(s : MlmetricrocSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn ml_metric_roc_series_mean(s : MlmetricrocSeries) -> Double {
  let n = ml_metric_roc_series_len(s)
  if n == 0 { 0.0 } else { ml_metric_roc_series_sum(s) / n.to_double() }
}

pub fn ml_metric_roc_series_min(s : MlmetricrocSeries) -> Double {
  let n = ml_metric_roc_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn ml_metric_roc_series_max(s : MlmetricrocSeries) -> Double {
  let n = ml_metric_roc_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn ml_metric_roc_series_range(s : MlmetricrocSeries) -> Double {
  ml_metric_roc_series_max(s) - ml_metric_roc_series_min(s)
}

pub fn ml_metric_roc_series_var(s : MlmetricrocSeries) -> Double {
  let n = ml_metric_roc_series_len(s)
  if n == 0 { 0.0 } else {
    let m = ml_metric_roc_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn ml_metric_roc_series_std(s : MlmetricrocSeries) -> Double { ml_metric_roc_sqrt(ml_metric_roc_series_var(s)) }

pub fn ml_metric_roc_series_median(s : MlmetricrocSeries) -> Double {
  let n = ml_metric_roc_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = ml_metric_roc_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ml_metric_roc_series_scale(s : MlmetricrocSeries, f : Double) -> MlmetricrocSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = ml_metric_roc_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ml_metric_roc_series_add(a : MlmetricrocSeries, b : MlmetricrocSeries) -> MlmetricrocSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = ml_metric_roc_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ml_metric_roc_series_sub(a : MlmetricrocSeries, b : MlmetricrocSeries) -> MlmetricrocSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = ml_metric_roc_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ml_metric_roc_series_normalize(s : MlmetricrocSeries) -> MlmetricrocSeries {
  let mn = ml_metric_roc_series_min(s)
  let mx = ml_metric_roc_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = ml_metric_roc_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ml_metric_roc_series_cumsum(s : MlmetricrocSeries) -> MlmetricrocSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = ml_metric_roc_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn ml_metric_roc_series_to_string(s : MlmetricrocSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + ml_metric_roc_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlmetricrocMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_metric_roc_make_matrix(rows : Int, cols : Int, val : Double) -> MlmetricrocMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_metric_roc_matrix_identity(n : Int) -> MlmetricrocMatrix {
  let m = ml_metric_roc_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ml_metric_roc_matrix_get(m : MlmetricrocMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ml_metric_roc_matrix_transpose(m : MlmetricrocMatrix) -> MlmetricrocMatrix {
  let result = ml_metric_roc_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ml_metric_roc_matrix_add(a : MlmetricrocMatrix, b : MlmetricrocMatrix) -> MlmetricrocMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ml_metric_roc_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ml_metric_roc_matrix_scale(m : MlmetricrocMatrix, s : Double) -> MlmetricrocMatrix {
  let result = ml_metric_roc_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ml_metric_roc_matrix_multiply(a : MlmetricrocMatrix, b : MlmetricrocMatrix) -> MlmetricrocMatrix {
  if a.cols != b.rows { return ml_metric_roc_make_matrix(a.rows, b.cols, 0.0) }
  let result = ml_metric_roc_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ml_metric_roc_matrix_trace(m : MlmetricrocMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ml_metric_roc_matrix_det(m : MlmetricrocMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ml_metric_roc_matrix_norm(m : MlmetricrocMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  ml_metric_roc_sqrt(sum)
}

pub fn ml_metric_roc_matrix_to_string(m : MlmetricrocMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + ml_metric_roc_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct MlmetricrocVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_metric_roc_make_vector(comps : Array[Double]) -> MlmetricrocVector {
  { comps, dim: comps.length() }
}

pub fn ml_metric_roc_vector_zero(dim : Int) -> MlmetricrocVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ml_metric_roc_vector_add(a : MlmetricrocVector, b : MlmetricrocVector) -> MlmetricrocVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = ml_metric_roc_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_metric_roc_vector_sub(a : MlmetricrocVector, b : MlmetricrocVector) -> MlmetricrocVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = ml_metric_roc_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_metric_roc_vector_scale(v : MlmetricrocVector, s : Double) -> MlmetricrocVector {
  let mut result = []
  for i in 0..<v.dim { result = ml_metric_roc_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ml_metric_roc_vector_dot(a : MlmetricrocVector, b : MlmetricrocVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ml_metric_roc_vector_norm(v : MlmetricrocVector) -> Double { ml_metric_roc_sqrt(ml_metric_roc_vector_dot(v, v)) }

pub fn ml_metric_roc_vector_normalize(v : MlmetricrocVector) -> MlmetricrocVector {
  let n = ml_metric_roc_vector_norm(v)
  if n < 0.0000001 { v } else { ml_metric_roc_vector_scale(v, 1.0 / n) }
}

pub fn ml_metric_roc_vector_dist(a : MlmetricrocVector, b : MlmetricrocVector) -> Double {
  ml_metric_roc_vector_norm(ml_metric_roc_vector_sub(a, b))
}

pub fn ml_metric_roc_vector_to_string(v : MlmetricrocVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + ml_metric_roc_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_metric_roc_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn ml_metric_roc_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = ml_metric_roc_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ml_metric_roc_std(data : Array[Double]) -> Double { ml_metric_roc_sqrt(ml_metric_roc_var(data)) }

pub fn ml_metric_roc_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = ml_metric_roc_mean(a); let mb = ml_metric_roc_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn ml_metric_roc_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = ml_metric_roc_std(a); let sb = ml_metric_roc_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { ml_metric_roc_cov(a, b) / (sa * sb) }
}

pub fn ml_metric_roc_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = ml_metric_roc_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ml_metric_roc_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn ml_metric_roc_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ml_metric_roc_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  ml_metric_roc_sqrt(ml_metric_roc_mse(pred, labels))
}

pub fn ml_metric_roc_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + ml_metric_roc_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn ml_metric_roc_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = ml_metric_roc_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn ml_metric_roc_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn ml_metric_roc_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn ml_metric_roc_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = ml_metric_roc_precision(pred, labels, pos); let r = ml_metric_roc_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn ml_metric_roc_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn ml_metric_roc_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = ml_metric_roc_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn ml_metric_roc_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn ml_metric_roc_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn ml_metric_roc_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = ml_metric_roc_gcd(a, b)
    (a / g) * b
  }
}

pub fn ml_metric_roc_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn ml_metric_roc_fibonacci(n : Int) -> Int {
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

pub fn ml_metric_roc_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = ml_metric_roc_min(data); let mx = ml_metric_roc_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn ml_metric_roc_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = ml_metric_roc_mean(data); let sd = ml_metric_roc_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn ml_metric_roc_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn ml_metric_roc_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn ml_metric_roc_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn ml_metric_roc_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn ml_metric_roc_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn ml_metric_roc_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn ml_metric_roc_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn ml_metric_roc_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn ml_metric_roc_dbl(x : Double) -> String {
  let i = if x >= 0.0 { ml_metric_roc_int(x) } else { -ml_metric_roc_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { ml_metric_roc_int(f * 1000000.0) } else { ml_metric_roc_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn ml_metric_roc_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn ml_metric_roc_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct MlmetricrocFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_roc_frame_make(size : Int) -> MlmetricrocFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_roc_frame_len(s : MlmetricrocFrame) -> Int { s.size }

pub fn ml_metric_roc_frame_get(s : MlmetricrocFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_roc_frame_set(s : MlmetricrocFrame, i : Int, v : Double) -> MlmetricrocFrame {
  let result = ml_metric_roc_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_roc_frame_sum(s : MlmetricrocFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_metric_roc_frame_mean(s : MlmetricrocFrame) -> Double {
  if s.size == 0 { 0.0 } else { ml_metric_roc_frame_sum(s) / s.size.to_double() }
}

pub fn ml_metric_roc_frame_scale(s : MlmetricrocFrame, f : Double) -> MlmetricrocFrame {
  let result = ml_metric_roc_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_metric_roc_frame_add(a : MlmetricrocFrame, b : MlmetricrocFrame) -> MlmetricrocFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_metric_roc_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_metric_roc_frame_copy(s : MlmetricrocFrame) -> MlmetricrocFrame {
  let result = ml_metric_roc_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_metric_roc_frame_fill(s : MlmetricrocFrame, v : Double) -> MlmetricrocFrame {
  let result = ml_metric_roc_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_metric_roc_frame_min(s : MlmetricrocFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_roc_frame_max(s : MlmetricrocFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_roc_frame_to_string(s : MlmetricrocFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricrocTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_roc_table_make(size : Int) -> MlmetricrocTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_roc_table_len(s : MlmetricrocTable) -> Int { s.size }

pub fn ml_metric_roc_table_get(s : MlmetricrocTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_roc_table_set(s : MlmetricrocTable, i : Int, v : Double) -> MlmetricrocTable {
  let result = ml_metric_roc_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_roc_table_sum(s : MlmetricrocTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_metric_roc_table_mean(s : MlmetricrocTable) -> Double {
  if s.size == 0 { 0.0 } else { ml_metric_roc_table_sum(s) / s.size.to_double() }
}

pub fn ml_metric_roc_table_scale(s : MlmetricrocTable, f : Double) -> MlmetricrocTable {
  let result = ml_metric_roc_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_metric_roc_table_add(a : MlmetricrocTable, b : MlmetricrocTable) -> MlmetricrocTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_metric_roc_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_metric_roc_table_copy(s : MlmetricrocTable) -> MlmetricrocTable {
  let result = ml_metric_roc_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_metric_roc_table_fill(s : MlmetricrocTable, v : Double) -> MlmetricrocTable {
  let result = ml_metric_roc_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_metric_roc_table_min(s : MlmetricrocTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_roc_table_max(s : MlmetricrocTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_roc_table_to_string(s : MlmetricrocTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricrocGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_roc_graphn_make(size : Int) -> MlmetricrocGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_roc_graphn_len(s : MlmetricrocGraphN) -> Int { s.size }

pub fn ml_metric_roc_graphn_get(s : MlmetricrocGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_roc_graphn_set(s : MlmetricrocGraphN, i : Int, v : Double) -> MlmetricrocGraphN {
  let result = ml_metric_roc_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_roc_graphn_sum(s : MlmetricrocGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_metric_roc_graphn_mean(s : MlmetricrocGraphN) -> Double {
  if s.size == 0 { 0.0 } else { ml_metric_roc_graphn_sum(s) / s.size.to_double() }
}

pub fn ml_metric_roc_graphn_scale(s : MlmetricrocGraphN, f : Double) -> MlmetricrocGraphN {
  let result = ml_metric_roc_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_metric_roc_graphn_add(a : MlmetricrocGraphN, b : MlmetricrocGraphN) -> MlmetricrocGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_metric_roc_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_metric_roc_graphn_copy(s : MlmetricrocGraphN) -> MlmetricrocGraphN {
  let result = ml_metric_roc_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_metric_roc_graphn_fill(s : MlmetricrocGraphN, v : Double) -> MlmetricrocGraphN {
  let result = ml_metric_roc_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_metric_roc_graphn_min(s : MlmetricrocGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_roc_graphn_max(s : MlmetricrocGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_roc_graphn_to_string(s : MlmetricrocGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricrocNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_roc_node_make(size : Int) -> MlmetricrocNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_roc_node_len(s : MlmetricrocNode) -> Int { s.size }

pub fn ml_metric_roc_node_get(s : MlmetricrocNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_roc_node_set(s : MlmetricrocNode, i : Int, v : Double) -> MlmetricrocNode {
  let result = ml_metric_roc_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_roc_node_sum(s : MlmetricrocNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_metric_roc_node_mean(s : MlmetricrocNode) -> Double {
  if s.size == 0 { 0.0 } else { ml_metric_roc_node_sum(s) / s.size.to_double() }
}

pub fn ml_metric_roc_node_scale(s : MlmetricrocNode, f : Double) -> MlmetricrocNode {
  let result = ml_metric_roc_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_metric_roc_node_add(a : MlmetricrocNode, b : MlmetricrocNode) -> MlmetricrocNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_metric_roc_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_metric_roc_node_copy(s : MlmetricrocNode) -> MlmetricrocNode {
  let result = ml_metric_roc_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_metric_roc_node_fill(s : MlmetricrocNode, v : Double) -> MlmetricrocNode {
  let result = ml_metric_roc_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_metric_roc_node_min(s : MlmetricrocNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_roc_node_max(s : MlmetricrocNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_roc_node_to_string(s : MlmetricrocNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricrocEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_roc_edge_make(size : Int) -> MlmetricrocEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_roc_edge_len(s : MlmetricrocEdge) -> Int { s.size }

pub fn ml_metric_roc_edge_get(s : MlmetricrocEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_roc_edge_set(s : MlmetricrocEdge, i : Int, v : Double) -> MlmetricrocEdge {
  let result = ml_metric_roc_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_roc_edge_sum(s : MlmetricrocEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_metric_roc_edge_mean(s : MlmetricrocEdge) -> Double {
  if s.size == 0 { 0.0 } else { ml_metric_roc_edge_sum(s) / s.size.to_double() }
}

pub fn ml_metric_roc_edge_scale(s : MlmetricrocEdge, f : Double) -> MlmetricrocEdge {
  let result = ml_metric_roc_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_metric_roc_edge_add(a : MlmetricrocEdge, b : MlmetricrocEdge) -> MlmetricrocEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_metric_roc_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_metric_roc_edge_copy(s : MlmetricrocEdge) -> MlmetricrocEdge {
  let result = ml_metric_roc_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_metric_roc_edge_fill(s : MlmetricrocEdge, v : Double) -> MlmetricrocEdge {
  let result = ml_metric_roc_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_metric_roc_edge_min(s : MlmetricrocEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_roc_edge_max(s : MlmetricrocEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_roc_edge_to_string(s : MlmetricrocEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricrocPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_roc_path_make(size : Int) -> MlmetricrocPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_roc_path_len(s : MlmetricrocPath) -> Int { s.size }

pub fn ml_metric_roc_path_get(s : MlmetricrocPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_roc_path_set(s : MlmetricrocPath, i : Int, v : Double) -> MlmetricrocPath {
  let result = ml_metric_roc_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_roc_path_sum(s : MlmetricrocPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_metric_roc_path_mean(s : MlmetricrocPath) -> Double {
  if s.size == 0 { 0.0 } else { ml_metric_roc_path_sum(s) / s.size.to_double() }
}

pub fn ml_metric_roc_path_scale(s : MlmetricrocPath, f : Double) -> MlmetricrocPath {
  let result = ml_metric_roc_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_metric_roc_path_add(a : MlmetricrocPath, b : MlmetricrocPath) -> MlmetricrocPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_metric_roc_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_metric_roc_path_copy(s : MlmetricrocPath) -> MlmetricrocPath {
  let result = ml_metric_roc_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_metric_roc_path_fill(s : MlmetricrocPath, v : Double) -> MlmetricrocPath {
  let result = ml_metric_roc_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_metric_roc_path_min(s : MlmetricrocPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_roc_path_max(s : MlmetricrocPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_roc_path_to_string(s : MlmetricrocPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricrocCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_roc_cluster_make(size : Int) -> MlmetricrocCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_roc_cluster_len(s : MlmetricrocCluster) -> Int { s.size }

pub fn ml_metric_roc_cluster_get(s : MlmetricrocCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_roc_cluster_set(s : MlmetricrocCluster, i : Int, v : Double) -> MlmetricrocCluster {
  let result = ml_metric_roc_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_roc_cluster_sum(s : MlmetricrocCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_metric_roc_cluster_mean(s : MlmetricrocCluster) -> Double {
  if s.size == 0 { 0.0 } else { ml_metric_roc_cluster_sum(s) / s.size.to_double() }
}

pub fn ml_metric_roc_cluster_scale(s : MlmetricrocCluster, f : Double) -> MlmetricrocCluster {
  let result = ml_metric_roc_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_metric_roc_cluster_add(a : MlmetricrocCluster, b : MlmetricrocCluster) -> MlmetricrocCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_metric_roc_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_metric_roc_cluster_copy(s : MlmetricrocCluster) -> MlmetricrocCluster {
  let result = ml_metric_roc_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_metric_roc_cluster_fill(s : MlmetricrocCluster, v : Double) -> MlmetricrocCluster {
  let result = ml_metric_roc_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_metric_roc_cluster_min(s : MlmetricrocCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_roc_cluster_max(s : MlmetricrocCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_roc_cluster_to_string(s : MlmetricrocCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricrocModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_roc_model_make(size : Int) -> MlmetricrocModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_roc_model_len(s : MlmetricrocModel) -> Int { s.size }

pub fn ml_metric_roc_model_get(s : MlmetricrocModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_roc_model_set(s : MlmetricrocModel, i : Int, v : Double) -> MlmetricrocModel {
  let result = ml_metric_roc_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_roc_model_sum(s : MlmetricrocModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_metric_roc_model_mean(s : MlmetricrocModel) -> Double {
  if s.size == 0 { 0.0 } else { ml_metric_roc_model_sum(s) / s.size.to_double() }
}

pub fn ml_metric_roc_model_scale(s : MlmetricrocModel, f : Double) -> MlmetricrocModel {
  let result = ml_metric_roc_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_metric_roc_model_add(a : MlmetricrocModel, b : MlmetricrocModel) -> MlmetricrocModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_metric_roc_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_metric_roc_model_copy(s : MlmetricrocModel) -> MlmetricrocModel {
  let result = ml_metric_roc_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_metric_roc_model_fill(s : MlmetricrocModel, v : Double) -> MlmetricrocModel {
  let result = ml_metric_roc_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_metric_roc_model_min(s : MlmetricrocModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_roc_model_max(s : MlmetricrocModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_roc_model_to_string(s : MlmetricrocModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricrocLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_roc_layer_make(size : Int) -> MlmetricrocLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_roc_layer_len(s : MlmetricrocLayer) -> Int { s.size }

pub fn ml_metric_roc_layer_get(s : MlmetricrocLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_roc_layer_set(s : MlmetricrocLayer, i : Int, v : Double) -> MlmetricrocLayer {
  let result = ml_metric_roc_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_roc_layer_sum(s : MlmetricrocLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_metric_roc_layer_mean(s : MlmetricrocLayer) -> Double {
  if s.size == 0 { 0.0 } else { ml_metric_roc_layer_sum(s) / s.size.to_double() }
}

pub fn ml_metric_roc_layer_scale(s : MlmetricrocLayer, f : Double) -> MlmetricrocLayer {
  let result = ml_metric_roc_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_metric_roc_layer_add(a : MlmetricrocLayer, b : MlmetricrocLayer) -> MlmetricrocLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_metric_roc_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_metric_roc_layer_copy(s : MlmetricrocLayer) -> MlmetricrocLayer {
  let result = ml_metric_roc_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_metric_roc_layer_fill(s : MlmetricrocLayer, v : Double) -> MlmetricrocLayer {
  let result = ml_metric_roc_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_metric_roc_layer_min(s : MlmetricrocLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_roc_layer_max(s : MlmetricrocLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_roc_layer_to_string(s : MlmetricrocLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricrocBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_roc_buffer_make(size : Int) -> MlmetricrocBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_roc_buffer_len(s : MlmetricrocBuffer) -> Int { s.size }

pub fn ml_metric_roc_buffer_get(s : MlmetricrocBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_roc_buffer_set(s : MlmetricrocBuffer, i : Int, v : Double) -> MlmetricrocBuffer {
  let result = ml_metric_roc_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_roc_buffer_sum(s : MlmetricrocBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_metric_roc_buffer_mean(s : MlmetricrocBuffer) -> Double {
  if s.size == 0 { 0.0 } else { ml_metric_roc_buffer_sum(s) / s.size.to_double() }
}

pub fn ml_metric_roc_buffer_scale(s : MlmetricrocBuffer, f : Double) -> MlmetricrocBuffer {
  let result = ml_metric_roc_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_metric_roc_buffer_add(a : MlmetricrocBuffer, b : MlmetricrocBuffer) -> MlmetricrocBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_metric_roc_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_metric_roc_buffer_copy(s : MlmetricrocBuffer) -> MlmetricrocBuffer {
  let result = ml_metric_roc_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_metric_roc_buffer_fill(s : MlmetricrocBuffer, v : Double) -> MlmetricrocBuffer {
  let result = ml_metric_roc_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_metric_roc_buffer_min(s : MlmetricrocBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_roc_buffer_max(s : MlmetricrocBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_roc_buffer_to_string(s : MlmetricrocBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricrocCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_roc_cursor_make(size : Int) -> MlmetricrocCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_roc_cursor_len(s : MlmetricrocCursor) -> Int { s.size }

pub fn ml_metric_roc_cursor_get(s : MlmetricrocCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_roc_cursor_set(s : MlmetricrocCursor, i : Int, v : Double) -> MlmetricrocCursor {
  let result = ml_metric_roc_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_roc_cursor_sum(s : MlmetricrocCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_metric_roc_cursor_mean(s : MlmetricrocCursor) -> Double {
  if s.size == 0 { 0.0 } else { ml_metric_roc_cursor_sum(s) / s.size.to_double() }
}

pub fn ml_metric_roc_cursor_scale(s : MlmetricrocCursor, f : Double) -> MlmetricrocCursor {
  let result = ml_metric_roc_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_metric_roc_cursor_add(a : MlmetricrocCursor, b : MlmetricrocCursor) -> MlmetricrocCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_metric_roc_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_metric_roc_cursor_copy(s : MlmetricrocCursor) -> MlmetricrocCursor {
  let result = ml_metric_roc_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_metric_roc_cursor_fill(s : MlmetricrocCursor, v : Double) -> MlmetricrocCursor {
  let result = ml_metric_roc_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_metric_roc_cursor_min(s : MlmetricrocCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_roc_cursor_max(s : MlmetricrocCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_roc_cursor_to_string(s : MlmetricrocCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricrocView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_roc_view_make(size : Int) -> MlmetricrocView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_roc_view_len(s : MlmetricrocView) -> Int { s.size }

pub fn ml_metric_roc_view_get(s : MlmetricrocView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_roc_view_set(s : MlmetricrocView, i : Int, v : Double) -> MlmetricrocView {
  let result = ml_metric_roc_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_roc_view_sum(s : MlmetricrocView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_metric_roc_view_mean(s : MlmetricrocView) -> Double {
  if s.size == 0 { 0.0 } else { ml_metric_roc_view_sum(s) / s.size.to_double() }
}

pub fn ml_metric_roc_view_scale(s : MlmetricrocView, f : Double) -> MlmetricrocView {
  let result = ml_metric_roc_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_metric_roc_view_add(a : MlmetricrocView, b : MlmetricrocView) -> MlmetricrocView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_metric_roc_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_metric_roc_view_copy(s : MlmetricrocView) -> MlmetricrocView {
  let result = ml_metric_roc_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_metric_roc_view_fill(s : MlmetricrocView, v : Double) -> MlmetricrocView {
  let result = ml_metric_roc_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_metric_roc_view_min(s : MlmetricrocView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_roc_view_max(s : MlmetricrocView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_roc_view_to_string(s : MlmetricrocView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricrocRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_roc_range_make(size : Int) -> MlmetricrocRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_roc_range_len(s : MlmetricrocRange) -> Int { s.size }

pub fn ml_metric_roc_range_get(s : MlmetricrocRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_roc_range_set(s : MlmetricrocRange, i : Int, v : Double) -> MlmetricrocRange {
  let result = ml_metric_roc_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_roc_range_sum(s : MlmetricrocRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_metric_roc_range_mean(s : MlmetricrocRange) -> Double {
  if s.size == 0 { 0.0 } else { ml_metric_roc_range_sum(s) / s.size.to_double() }
}

pub fn ml_metric_roc_range_scale(s : MlmetricrocRange, f : Double) -> MlmetricrocRange {
  let result = ml_metric_roc_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_metric_roc_range_add(a : MlmetricrocRange, b : MlmetricrocRange) -> MlmetricrocRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_metric_roc_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_metric_roc_range_copy(s : MlmetricrocRange) -> MlmetricrocRange {
  let result = ml_metric_roc_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_metric_roc_range_fill(s : MlmetricrocRange, v : Double) -> MlmetricrocRange {
  let result = ml_metric_roc_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_metric_roc_range_min(s : MlmetricrocRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_roc_range_max(s : MlmetricrocRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_roc_range_to_string(s : MlmetricrocRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricrocSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_roc_slice_make(size : Int) -> MlmetricrocSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_roc_slice_len(s : MlmetricrocSlice) -> Int { s.size }

pub fn ml_metric_roc_slice_get(s : MlmetricrocSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_roc_slice_set(s : MlmetricrocSlice, i : Int, v : Double) -> MlmetricrocSlice {
  let result = ml_metric_roc_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_roc_slice_sum(s : MlmetricrocSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_metric_roc_slice_mean(s : MlmetricrocSlice) -> Double {
  if s.size == 0 { 0.0 } else { ml_metric_roc_slice_sum(s) / s.size.to_double() }
}

pub fn ml_metric_roc_slice_scale(s : MlmetricrocSlice, f : Double) -> MlmetricrocSlice {
  let result = ml_metric_roc_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_metric_roc_slice_add(a : MlmetricrocSlice, b : MlmetricrocSlice) -> MlmetricrocSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_metric_roc_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_metric_roc_slice_copy(s : MlmetricrocSlice) -> MlmetricrocSlice {
  let result = ml_metric_roc_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_metric_roc_slice_fill(s : MlmetricrocSlice, v : Double) -> MlmetricrocSlice {
  let result = ml_metric_roc_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_metric_roc_slice_min(s : MlmetricrocSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_roc_slice_max(s : MlmetricrocSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_roc_slice_to_string(s : MlmetricrocSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn ml_metric_roc_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_metric_roc_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_metric_roc_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_metric_roc_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_metric_roc_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_metric_roc_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_metric_roc_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_metric_roc_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_metric_roc_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_metric_roc_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_metric_roc_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_metric_roc_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_metric_roc_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_metric_roc_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_metric_roc_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_metric_roc_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_metric_roc_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_metric_roc_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_metric_roc_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_metric_roc_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_metric_roc_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_metric_roc_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_metric_roc_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_metric_roc_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_metric_roc_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}


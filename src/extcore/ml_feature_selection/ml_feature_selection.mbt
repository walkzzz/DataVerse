///===
/// extcore/ml_feature_selection

pub(all) struct MlfeatureselectionPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_feature_selection_make_point(x : Double, y : Double) -> MlfeatureselectionPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_feature_selection_make_point3(x : Double, y : Double, z : Double) -> MlfeatureselectionPoint {
  { x, y, z, label: 0 }
}

pub fn ml_feature_selection_point_x(pt : MlfeatureselectionPoint) -> Double { pt.x }

pub fn ml_feature_selection_point_y(pt : MlfeatureselectionPoint) -> Double { pt.y }

pub fn ml_feature_selection_point_z(pt : MlfeatureselectionPoint) -> Double { pt.z }

pub fn ml_feature_selection_point_label(pt : MlfeatureselectionPoint) -> Int { pt.label }

pub fn ml_feature_selection_point_dist(a : MlfeatureselectionPoint, b : MlfeatureselectionPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  ml_feature_selection_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ml_feature_selection_point_add(a : MlfeatureselectionPoint, b : MlfeatureselectionPoint) -> MlfeatureselectionPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ml_feature_selection_point_sub(a : MlfeatureselectionPoint, b : MlfeatureselectionPoint) -> MlfeatureselectionPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ml_feature_selection_point_scale(pt : MlfeatureselectionPoint, s : Double) -> MlfeatureselectionPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ml_feature_selection_point_dot(a : MlfeatureselectionPoint, b : MlfeatureselectionPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ml_feature_selection_point_cross(a : MlfeatureselectionPoint, b : MlfeatureselectionPoint) -> MlfeatureselectionPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ml_feature_selection_point_norm(pt : MlfeatureselectionPoint) -> Double {
  ml_feature_selection_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ml_feature_selection_point_normalize(pt : MlfeatureselectionPoint) -> MlfeatureselectionPoint {
  let n = ml_feature_selection_point_norm(pt)
  if n < 0.0000001 { pt } else { ml_feature_selection_point_scale(pt, 1.0 / n) }
}

pub fn ml_feature_selection_point_negate(pt : MlfeatureselectionPoint) -> MlfeatureselectionPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ml_feature_selection_point_mid(a : MlfeatureselectionPoint, b : MlfeatureselectionPoint) -> MlfeatureselectionPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ml_feature_selection_point_lerp(a : MlfeatureselectionPoint, b : MlfeatureselectionPoint, t : Double) -> MlfeatureselectionPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ml_feature_selection_point_to_string(pt : MlfeatureselectionPoint) -> String {
  "(" + ml_feature_selection_dbl(pt.x) + ", " + ml_feature_selection_dbl(pt.y) + ", " + ml_feature_selection_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MlfeatureselectionSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_feature_selection_make_series(vals : Array[Double], name : String) -> MlfeatureselectionSeries {
  { vals, name, meta: 0 }
}

pub fn ml_feature_selection_series_len(s : MlfeatureselectionSeries) -> Int { s.vals.length() }

pub fn ml_feature_selection_series_sum(s : MlfeatureselectionSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn ml_feature_selection_series_mean(s : MlfeatureselectionSeries) -> Double {
  let n = ml_feature_selection_series_len(s)
  if n == 0 { 0.0 } else { ml_feature_selection_series_sum(s) / n.to_double() }
}

pub fn ml_feature_selection_series_min(s : MlfeatureselectionSeries) -> Double {
  let n = ml_feature_selection_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn ml_feature_selection_series_max(s : MlfeatureselectionSeries) -> Double {
  let n = ml_feature_selection_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn ml_feature_selection_series_range(s : MlfeatureselectionSeries) -> Double {
  ml_feature_selection_series_max(s) - ml_feature_selection_series_min(s)
}

pub fn ml_feature_selection_series_var(s : MlfeatureselectionSeries) -> Double {
  let n = ml_feature_selection_series_len(s)
  if n == 0 { 0.0 } else {
    let m = ml_feature_selection_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn ml_feature_selection_series_std(s : MlfeatureselectionSeries) -> Double { ml_feature_selection_sqrt(ml_feature_selection_series_var(s)) }

pub fn ml_feature_selection_series_median(s : MlfeatureselectionSeries) -> Double {
  let n = ml_feature_selection_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = ml_feature_selection_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ml_feature_selection_series_scale(s : MlfeatureselectionSeries, f : Double) -> MlfeatureselectionSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = ml_feature_selection_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ml_feature_selection_series_add(a : MlfeatureselectionSeries, b : MlfeatureselectionSeries) -> MlfeatureselectionSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = ml_feature_selection_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ml_feature_selection_series_sub(a : MlfeatureselectionSeries, b : MlfeatureselectionSeries) -> MlfeatureselectionSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = ml_feature_selection_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ml_feature_selection_series_normalize(s : MlfeatureselectionSeries) -> MlfeatureselectionSeries {
  let mn = ml_feature_selection_series_min(s)
  let mx = ml_feature_selection_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = ml_feature_selection_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ml_feature_selection_series_cumsum(s : MlfeatureselectionSeries) -> MlfeatureselectionSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = ml_feature_selection_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn ml_feature_selection_series_to_string(s : MlfeatureselectionSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + ml_feature_selection_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlfeatureselectionMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_feature_selection_make_matrix(rows : Int, cols : Int, val : Double) -> MlfeatureselectionMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_feature_selection_matrix_identity(n : Int) -> MlfeatureselectionMatrix {
  let m = ml_feature_selection_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ml_feature_selection_matrix_get(m : MlfeatureselectionMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ml_feature_selection_matrix_transpose(m : MlfeatureselectionMatrix) -> MlfeatureselectionMatrix {
  let result = ml_feature_selection_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ml_feature_selection_matrix_add(a : MlfeatureselectionMatrix, b : MlfeatureselectionMatrix) -> MlfeatureselectionMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ml_feature_selection_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ml_feature_selection_matrix_scale(m : MlfeatureselectionMatrix, s : Double) -> MlfeatureselectionMatrix {
  let result = ml_feature_selection_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ml_feature_selection_matrix_multiply(a : MlfeatureselectionMatrix, b : MlfeatureselectionMatrix) -> MlfeatureselectionMatrix {
  if a.cols != b.rows { return ml_feature_selection_make_matrix(a.rows, b.cols, 0.0) }
  let result = ml_feature_selection_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ml_feature_selection_matrix_trace(m : MlfeatureselectionMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ml_feature_selection_matrix_det(m : MlfeatureselectionMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ml_feature_selection_matrix_norm(m : MlfeatureselectionMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  ml_feature_selection_sqrt(sum)
}

pub fn ml_feature_selection_matrix_to_string(m : MlfeatureselectionMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + ml_feature_selection_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct MlfeatureselectionVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_feature_selection_make_vector(comps : Array[Double]) -> MlfeatureselectionVector {
  { comps, dim: comps.length() }
}

pub fn ml_feature_selection_vector_zero(dim : Int) -> MlfeatureselectionVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ml_feature_selection_vector_add(a : MlfeatureselectionVector, b : MlfeatureselectionVector) -> MlfeatureselectionVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = ml_feature_selection_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_feature_selection_vector_sub(a : MlfeatureselectionVector, b : MlfeatureselectionVector) -> MlfeatureselectionVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = ml_feature_selection_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_feature_selection_vector_scale(v : MlfeatureselectionVector, s : Double) -> MlfeatureselectionVector {
  let mut result = []
  for i in 0..<v.dim { result = ml_feature_selection_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ml_feature_selection_vector_dot(a : MlfeatureselectionVector, b : MlfeatureselectionVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ml_feature_selection_vector_norm(v : MlfeatureselectionVector) -> Double { ml_feature_selection_sqrt(ml_feature_selection_vector_dot(v, v)) }

pub fn ml_feature_selection_vector_normalize(v : MlfeatureselectionVector) -> MlfeatureselectionVector {
  let n = ml_feature_selection_vector_norm(v)
  if n < 0.0000001 { v } else { ml_feature_selection_vector_scale(v, 1.0 / n) }
}

pub fn ml_feature_selection_vector_dist(a : MlfeatureselectionVector, b : MlfeatureselectionVector) -> Double {
  ml_feature_selection_vector_norm(ml_feature_selection_vector_sub(a, b))
}

pub fn ml_feature_selection_vector_to_string(v : MlfeatureselectionVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + ml_feature_selection_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_feature_selection_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn ml_feature_selection_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = ml_feature_selection_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ml_feature_selection_std(data : Array[Double]) -> Double { ml_feature_selection_sqrt(ml_feature_selection_var(data)) }

pub fn ml_feature_selection_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = ml_feature_selection_mean(a); let mb = ml_feature_selection_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn ml_feature_selection_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = ml_feature_selection_std(a); let sb = ml_feature_selection_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { ml_feature_selection_cov(a, b) / (sa * sb) }
}

pub fn ml_feature_selection_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = ml_feature_selection_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ml_feature_selection_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn ml_feature_selection_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ml_feature_selection_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  ml_feature_selection_sqrt(ml_feature_selection_mse(pred, labels))
}

pub fn ml_feature_selection_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + ml_feature_selection_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn ml_feature_selection_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = ml_feature_selection_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn ml_feature_selection_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn ml_feature_selection_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn ml_feature_selection_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = ml_feature_selection_precision(pred, labels, pos); let r = ml_feature_selection_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn ml_feature_selection_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn ml_feature_selection_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = ml_feature_selection_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn ml_feature_selection_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn ml_feature_selection_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn ml_feature_selection_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = ml_feature_selection_gcd(a, b)
    (a / g) * b
  }
}

pub fn ml_feature_selection_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn ml_feature_selection_fibonacci(n : Int) -> Int {
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

pub fn ml_feature_selection_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = ml_feature_selection_min(data); let mx = ml_feature_selection_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn ml_feature_selection_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = ml_feature_selection_mean(data); let sd = ml_feature_selection_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn ml_feature_selection_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn ml_feature_selection_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn ml_feature_selection_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn ml_feature_selection_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn ml_feature_selection_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn ml_feature_selection_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn ml_feature_selection_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn ml_feature_selection_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn ml_feature_selection_dbl(x : Double) -> String {
  let i = if x >= 0.0 { ml_feature_selection_int(x) } else { -ml_feature_selection_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { ml_feature_selection_int(f * 1000000.0) } else { ml_feature_selection_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn ml_feature_selection_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn ml_feature_selection_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct MlfeatureselectionFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_selection_frame_make(size : Int) -> MlfeatureselectionFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_selection_frame_len(s : MlfeatureselectionFrame) -> Int { s.size }

pub fn ml_feature_selection_frame_get(s : MlfeatureselectionFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_selection_frame_set(s : MlfeatureselectionFrame, i : Int, v : Double) -> MlfeatureselectionFrame {
  let result = ml_feature_selection_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_selection_frame_sum(s : MlfeatureselectionFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_feature_selection_frame_mean(s : MlfeatureselectionFrame) -> Double {
  if s.size == 0 { 0.0 } else { ml_feature_selection_frame_sum(s) / s.size.to_double() }
}

pub fn ml_feature_selection_frame_scale(s : MlfeatureselectionFrame, f : Double) -> MlfeatureselectionFrame {
  let result = ml_feature_selection_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_feature_selection_frame_add(a : MlfeatureselectionFrame, b : MlfeatureselectionFrame) -> MlfeatureselectionFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_feature_selection_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_feature_selection_frame_copy(s : MlfeatureselectionFrame) -> MlfeatureselectionFrame {
  let result = ml_feature_selection_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_feature_selection_frame_fill(s : MlfeatureselectionFrame, v : Double) -> MlfeatureselectionFrame {
  let result = ml_feature_selection_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_feature_selection_frame_min(s : MlfeatureselectionFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_selection_frame_max(s : MlfeatureselectionFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_selection_frame_to_string(s : MlfeatureselectionFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureselectionTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_selection_table_make(size : Int) -> MlfeatureselectionTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_selection_table_len(s : MlfeatureselectionTable) -> Int { s.size }

pub fn ml_feature_selection_table_get(s : MlfeatureselectionTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_selection_table_set(s : MlfeatureselectionTable, i : Int, v : Double) -> MlfeatureselectionTable {
  let result = ml_feature_selection_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_selection_table_sum(s : MlfeatureselectionTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_feature_selection_table_mean(s : MlfeatureselectionTable) -> Double {
  if s.size == 0 { 0.0 } else { ml_feature_selection_table_sum(s) / s.size.to_double() }
}

pub fn ml_feature_selection_table_scale(s : MlfeatureselectionTable, f : Double) -> MlfeatureselectionTable {
  let result = ml_feature_selection_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_feature_selection_table_add(a : MlfeatureselectionTable, b : MlfeatureselectionTable) -> MlfeatureselectionTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_feature_selection_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_feature_selection_table_copy(s : MlfeatureselectionTable) -> MlfeatureselectionTable {
  let result = ml_feature_selection_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_feature_selection_table_fill(s : MlfeatureselectionTable, v : Double) -> MlfeatureselectionTable {
  let result = ml_feature_selection_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_feature_selection_table_min(s : MlfeatureselectionTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_selection_table_max(s : MlfeatureselectionTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_selection_table_to_string(s : MlfeatureselectionTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureselectionGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_selection_graphn_make(size : Int) -> MlfeatureselectionGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_selection_graphn_len(s : MlfeatureselectionGraphN) -> Int { s.size }

pub fn ml_feature_selection_graphn_get(s : MlfeatureselectionGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_selection_graphn_set(s : MlfeatureselectionGraphN, i : Int, v : Double) -> MlfeatureselectionGraphN {
  let result = ml_feature_selection_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_selection_graphn_sum(s : MlfeatureselectionGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_feature_selection_graphn_mean(s : MlfeatureselectionGraphN) -> Double {
  if s.size == 0 { 0.0 } else { ml_feature_selection_graphn_sum(s) / s.size.to_double() }
}

pub fn ml_feature_selection_graphn_scale(s : MlfeatureselectionGraphN, f : Double) -> MlfeatureselectionGraphN {
  let result = ml_feature_selection_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_feature_selection_graphn_add(a : MlfeatureselectionGraphN, b : MlfeatureselectionGraphN) -> MlfeatureselectionGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_feature_selection_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_feature_selection_graphn_copy(s : MlfeatureselectionGraphN) -> MlfeatureselectionGraphN {
  let result = ml_feature_selection_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_feature_selection_graphn_fill(s : MlfeatureselectionGraphN, v : Double) -> MlfeatureselectionGraphN {
  let result = ml_feature_selection_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_feature_selection_graphn_min(s : MlfeatureselectionGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_selection_graphn_max(s : MlfeatureselectionGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_selection_graphn_to_string(s : MlfeatureselectionGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureselectionNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_selection_node_make(size : Int) -> MlfeatureselectionNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_selection_node_len(s : MlfeatureselectionNode) -> Int { s.size }

pub fn ml_feature_selection_node_get(s : MlfeatureselectionNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_selection_node_set(s : MlfeatureselectionNode, i : Int, v : Double) -> MlfeatureselectionNode {
  let result = ml_feature_selection_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_selection_node_sum(s : MlfeatureselectionNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_feature_selection_node_mean(s : MlfeatureselectionNode) -> Double {
  if s.size == 0 { 0.0 } else { ml_feature_selection_node_sum(s) / s.size.to_double() }
}

pub fn ml_feature_selection_node_scale(s : MlfeatureselectionNode, f : Double) -> MlfeatureselectionNode {
  let result = ml_feature_selection_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_feature_selection_node_add(a : MlfeatureselectionNode, b : MlfeatureselectionNode) -> MlfeatureselectionNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_feature_selection_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_feature_selection_node_copy(s : MlfeatureselectionNode) -> MlfeatureselectionNode {
  let result = ml_feature_selection_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_feature_selection_node_fill(s : MlfeatureselectionNode, v : Double) -> MlfeatureselectionNode {
  let result = ml_feature_selection_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_feature_selection_node_min(s : MlfeatureselectionNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_selection_node_max(s : MlfeatureselectionNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_selection_node_to_string(s : MlfeatureselectionNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureselectionEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_selection_edge_make(size : Int) -> MlfeatureselectionEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_selection_edge_len(s : MlfeatureselectionEdge) -> Int { s.size }

pub fn ml_feature_selection_edge_get(s : MlfeatureselectionEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_selection_edge_set(s : MlfeatureselectionEdge, i : Int, v : Double) -> MlfeatureselectionEdge {
  let result = ml_feature_selection_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_selection_edge_sum(s : MlfeatureselectionEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_feature_selection_edge_mean(s : MlfeatureselectionEdge) -> Double {
  if s.size == 0 { 0.0 } else { ml_feature_selection_edge_sum(s) / s.size.to_double() }
}

pub fn ml_feature_selection_edge_scale(s : MlfeatureselectionEdge, f : Double) -> MlfeatureselectionEdge {
  let result = ml_feature_selection_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_feature_selection_edge_add(a : MlfeatureselectionEdge, b : MlfeatureselectionEdge) -> MlfeatureselectionEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_feature_selection_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_feature_selection_edge_copy(s : MlfeatureselectionEdge) -> MlfeatureselectionEdge {
  let result = ml_feature_selection_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_feature_selection_edge_fill(s : MlfeatureselectionEdge, v : Double) -> MlfeatureselectionEdge {
  let result = ml_feature_selection_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_feature_selection_edge_min(s : MlfeatureselectionEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_selection_edge_max(s : MlfeatureselectionEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_selection_edge_to_string(s : MlfeatureselectionEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureselectionPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_selection_path_make(size : Int) -> MlfeatureselectionPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_selection_path_len(s : MlfeatureselectionPath) -> Int { s.size }

pub fn ml_feature_selection_path_get(s : MlfeatureselectionPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_selection_path_set(s : MlfeatureselectionPath, i : Int, v : Double) -> MlfeatureselectionPath {
  let result = ml_feature_selection_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_selection_path_sum(s : MlfeatureselectionPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_feature_selection_path_mean(s : MlfeatureselectionPath) -> Double {
  if s.size == 0 { 0.0 } else { ml_feature_selection_path_sum(s) / s.size.to_double() }
}

pub fn ml_feature_selection_path_scale(s : MlfeatureselectionPath, f : Double) -> MlfeatureselectionPath {
  let result = ml_feature_selection_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_feature_selection_path_add(a : MlfeatureselectionPath, b : MlfeatureselectionPath) -> MlfeatureselectionPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_feature_selection_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_feature_selection_path_copy(s : MlfeatureselectionPath) -> MlfeatureselectionPath {
  let result = ml_feature_selection_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_feature_selection_path_fill(s : MlfeatureselectionPath, v : Double) -> MlfeatureselectionPath {
  let result = ml_feature_selection_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_feature_selection_path_min(s : MlfeatureselectionPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_selection_path_max(s : MlfeatureselectionPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_selection_path_to_string(s : MlfeatureselectionPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureselectionCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_selection_cluster_make(size : Int) -> MlfeatureselectionCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_selection_cluster_len(s : MlfeatureselectionCluster) -> Int { s.size }

pub fn ml_feature_selection_cluster_get(s : MlfeatureselectionCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_selection_cluster_set(s : MlfeatureselectionCluster, i : Int, v : Double) -> MlfeatureselectionCluster {
  let result = ml_feature_selection_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_selection_cluster_sum(s : MlfeatureselectionCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_feature_selection_cluster_mean(s : MlfeatureselectionCluster) -> Double {
  if s.size == 0 { 0.0 } else { ml_feature_selection_cluster_sum(s) / s.size.to_double() }
}

pub fn ml_feature_selection_cluster_scale(s : MlfeatureselectionCluster, f : Double) -> MlfeatureselectionCluster {
  let result = ml_feature_selection_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_feature_selection_cluster_add(a : MlfeatureselectionCluster, b : MlfeatureselectionCluster) -> MlfeatureselectionCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_feature_selection_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_feature_selection_cluster_copy(s : MlfeatureselectionCluster) -> MlfeatureselectionCluster {
  let result = ml_feature_selection_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_feature_selection_cluster_fill(s : MlfeatureselectionCluster, v : Double) -> MlfeatureselectionCluster {
  let result = ml_feature_selection_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_feature_selection_cluster_min(s : MlfeatureselectionCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_selection_cluster_max(s : MlfeatureselectionCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_selection_cluster_to_string(s : MlfeatureselectionCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureselectionModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_selection_model_make(size : Int) -> MlfeatureselectionModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_selection_model_len(s : MlfeatureselectionModel) -> Int { s.size }

pub fn ml_feature_selection_model_get(s : MlfeatureselectionModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_selection_model_set(s : MlfeatureselectionModel, i : Int, v : Double) -> MlfeatureselectionModel {
  let result = ml_feature_selection_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_selection_model_sum(s : MlfeatureselectionModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_feature_selection_model_mean(s : MlfeatureselectionModel) -> Double {
  if s.size == 0 { 0.0 } else { ml_feature_selection_model_sum(s) / s.size.to_double() }
}

pub fn ml_feature_selection_model_scale(s : MlfeatureselectionModel, f : Double) -> MlfeatureselectionModel {
  let result = ml_feature_selection_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_feature_selection_model_add(a : MlfeatureselectionModel, b : MlfeatureselectionModel) -> MlfeatureselectionModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_feature_selection_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_feature_selection_model_copy(s : MlfeatureselectionModel) -> MlfeatureselectionModel {
  let result = ml_feature_selection_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_feature_selection_model_fill(s : MlfeatureselectionModel, v : Double) -> MlfeatureselectionModel {
  let result = ml_feature_selection_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_feature_selection_model_min(s : MlfeatureselectionModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_selection_model_max(s : MlfeatureselectionModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_selection_model_to_string(s : MlfeatureselectionModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureselectionLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_selection_layer_make(size : Int) -> MlfeatureselectionLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_selection_layer_len(s : MlfeatureselectionLayer) -> Int { s.size }

pub fn ml_feature_selection_layer_get(s : MlfeatureselectionLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_selection_layer_set(s : MlfeatureselectionLayer, i : Int, v : Double) -> MlfeatureselectionLayer {
  let result = ml_feature_selection_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_selection_layer_sum(s : MlfeatureselectionLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_feature_selection_layer_mean(s : MlfeatureselectionLayer) -> Double {
  if s.size == 0 { 0.0 } else { ml_feature_selection_layer_sum(s) / s.size.to_double() }
}

pub fn ml_feature_selection_layer_scale(s : MlfeatureselectionLayer, f : Double) -> MlfeatureselectionLayer {
  let result = ml_feature_selection_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_feature_selection_layer_add(a : MlfeatureselectionLayer, b : MlfeatureselectionLayer) -> MlfeatureselectionLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_feature_selection_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_feature_selection_layer_copy(s : MlfeatureselectionLayer) -> MlfeatureselectionLayer {
  let result = ml_feature_selection_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_feature_selection_layer_fill(s : MlfeatureselectionLayer, v : Double) -> MlfeatureselectionLayer {
  let result = ml_feature_selection_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_feature_selection_layer_min(s : MlfeatureselectionLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_selection_layer_max(s : MlfeatureselectionLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_selection_layer_to_string(s : MlfeatureselectionLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureselectionBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_selection_buffer_make(size : Int) -> MlfeatureselectionBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_selection_buffer_len(s : MlfeatureselectionBuffer) -> Int { s.size }

pub fn ml_feature_selection_buffer_get(s : MlfeatureselectionBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_selection_buffer_set(s : MlfeatureselectionBuffer, i : Int, v : Double) -> MlfeatureselectionBuffer {
  let result = ml_feature_selection_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_selection_buffer_sum(s : MlfeatureselectionBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_feature_selection_buffer_mean(s : MlfeatureselectionBuffer) -> Double {
  if s.size == 0 { 0.0 } else { ml_feature_selection_buffer_sum(s) / s.size.to_double() }
}

pub fn ml_feature_selection_buffer_scale(s : MlfeatureselectionBuffer, f : Double) -> MlfeatureselectionBuffer {
  let result = ml_feature_selection_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_feature_selection_buffer_add(a : MlfeatureselectionBuffer, b : MlfeatureselectionBuffer) -> MlfeatureselectionBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_feature_selection_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_feature_selection_buffer_copy(s : MlfeatureselectionBuffer) -> MlfeatureselectionBuffer {
  let result = ml_feature_selection_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_feature_selection_buffer_fill(s : MlfeatureselectionBuffer, v : Double) -> MlfeatureselectionBuffer {
  let result = ml_feature_selection_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_feature_selection_buffer_min(s : MlfeatureselectionBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_selection_buffer_max(s : MlfeatureselectionBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_selection_buffer_to_string(s : MlfeatureselectionBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureselectionCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_selection_cursor_make(size : Int) -> MlfeatureselectionCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_selection_cursor_len(s : MlfeatureselectionCursor) -> Int { s.size }

pub fn ml_feature_selection_cursor_get(s : MlfeatureselectionCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_selection_cursor_set(s : MlfeatureselectionCursor, i : Int, v : Double) -> MlfeatureselectionCursor {
  let result = ml_feature_selection_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_selection_cursor_sum(s : MlfeatureselectionCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_feature_selection_cursor_mean(s : MlfeatureselectionCursor) -> Double {
  if s.size == 0 { 0.0 } else { ml_feature_selection_cursor_sum(s) / s.size.to_double() }
}

pub fn ml_feature_selection_cursor_scale(s : MlfeatureselectionCursor, f : Double) -> MlfeatureselectionCursor {
  let result = ml_feature_selection_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_feature_selection_cursor_add(a : MlfeatureselectionCursor, b : MlfeatureselectionCursor) -> MlfeatureselectionCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_feature_selection_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_feature_selection_cursor_copy(s : MlfeatureselectionCursor) -> MlfeatureselectionCursor {
  let result = ml_feature_selection_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_feature_selection_cursor_fill(s : MlfeatureselectionCursor, v : Double) -> MlfeatureselectionCursor {
  let result = ml_feature_selection_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_feature_selection_cursor_min(s : MlfeatureselectionCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_selection_cursor_max(s : MlfeatureselectionCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_selection_cursor_to_string(s : MlfeatureselectionCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureselectionView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_selection_view_make(size : Int) -> MlfeatureselectionView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_selection_view_len(s : MlfeatureselectionView) -> Int { s.size }

pub fn ml_feature_selection_view_get(s : MlfeatureselectionView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_selection_view_set(s : MlfeatureselectionView, i : Int, v : Double) -> MlfeatureselectionView {
  let result = ml_feature_selection_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_selection_view_sum(s : MlfeatureselectionView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_feature_selection_view_mean(s : MlfeatureselectionView) -> Double {
  if s.size == 0 { 0.0 } else { ml_feature_selection_view_sum(s) / s.size.to_double() }
}

pub fn ml_feature_selection_view_scale(s : MlfeatureselectionView, f : Double) -> MlfeatureselectionView {
  let result = ml_feature_selection_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_feature_selection_view_add(a : MlfeatureselectionView, b : MlfeatureselectionView) -> MlfeatureselectionView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_feature_selection_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_feature_selection_view_copy(s : MlfeatureselectionView) -> MlfeatureselectionView {
  let result = ml_feature_selection_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_feature_selection_view_fill(s : MlfeatureselectionView, v : Double) -> MlfeatureselectionView {
  let result = ml_feature_selection_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_feature_selection_view_min(s : MlfeatureselectionView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_selection_view_max(s : MlfeatureselectionView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_selection_view_to_string(s : MlfeatureselectionView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureselectionRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_selection_range_make(size : Int) -> MlfeatureselectionRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_selection_range_len(s : MlfeatureselectionRange) -> Int { s.size }

pub fn ml_feature_selection_range_get(s : MlfeatureselectionRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_selection_range_set(s : MlfeatureselectionRange, i : Int, v : Double) -> MlfeatureselectionRange {
  let result = ml_feature_selection_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_selection_range_sum(s : MlfeatureselectionRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_feature_selection_range_mean(s : MlfeatureselectionRange) -> Double {
  if s.size == 0 { 0.0 } else { ml_feature_selection_range_sum(s) / s.size.to_double() }
}

pub fn ml_feature_selection_range_scale(s : MlfeatureselectionRange, f : Double) -> MlfeatureselectionRange {
  let result = ml_feature_selection_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_feature_selection_range_add(a : MlfeatureselectionRange, b : MlfeatureselectionRange) -> MlfeatureselectionRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_feature_selection_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_feature_selection_range_copy(s : MlfeatureselectionRange) -> MlfeatureselectionRange {
  let result = ml_feature_selection_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_feature_selection_range_fill(s : MlfeatureselectionRange, v : Double) -> MlfeatureselectionRange {
  let result = ml_feature_selection_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_feature_selection_range_min(s : MlfeatureselectionRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_selection_range_max(s : MlfeatureselectionRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_selection_range_to_string(s : MlfeatureselectionRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureselectionSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_selection_slice_make(size : Int) -> MlfeatureselectionSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_selection_slice_len(s : MlfeatureselectionSlice) -> Int { s.size }

pub fn ml_feature_selection_slice_get(s : MlfeatureselectionSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_selection_slice_set(s : MlfeatureselectionSlice, i : Int, v : Double) -> MlfeatureselectionSlice {
  let result = ml_feature_selection_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_selection_slice_sum(s : MlfeatureselectionSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_feature_selection_slice_mean(s : MlfeatureselectionSlice) -> Double {
  if s.size == 0 { 0.0 } else { ml_feature_selection_slice_sum(s) / s.size.to_double() }
}

pub fn ml_feature_selection_slice_scale(s : MlfeatureselectionSlice, f : Double) -> MlfeatureselectionSlice {
  let result = ml_feature_selection_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_feature_selection_slice_add(a : MlfeatureselectionSlice, b : MlfeatureselectionSlice) -> MlfeatureselectionSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_feature_selection_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_feature_selection_slice_copy(s : MlfeatureselectionSlice) -> MlfeatureselectionSlice {
  let result = ml_feature_selection_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_feature_selection_slice_fill(s : MlfeatureselectionSlice, v : Double) -> MlfeatureselectionSlice {
  let result = ml_feature_selection_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_feature_selection_slice_min(s : MlfeatureselectionSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_selection_slice_max(s : MlfeatureselectionSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_selection_slice_to_string(s : MlfeatureselectionSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn ml_feature_selection_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_feature_selection_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_feature_selection_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_feature_selection_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_feature_selection_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_feature_selection_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_feature_selection_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_feature_selection_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_feature_selection_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_feature_selection_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_feature_selection_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_feature_selection_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_feature_selection_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_feature_selection_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_feature_selection_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_feature_selection_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_feature_selection_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_feature_selection_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_feature_selection_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_feature_selection_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_feature_selection_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_feature_selection_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_feature_selection_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_feature_selection_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_feature_selection_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}


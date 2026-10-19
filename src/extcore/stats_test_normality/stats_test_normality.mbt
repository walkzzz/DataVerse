///===
/// extcore/stats_test_normality

pub(all) struct StatstestnormalityPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_test_normality_make_point(x : Double, y : Double) -> StatstestnormalityPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_test_normality_make_point3(x : Double, y : Double, z : Double) -> StatstestnormalityPoint {
  { x, y, z, label: 0 }
}

pub fn stats_test_normality_point_x(pt : StatstestnormalityPoint) -> Double { pt.x }

pub fn stats_test_normality_point_y(pt : StatstestnormalityPoint) -> Double { pt.y }

pub fn stats_test_normality_point_z(pt : StatstestnormalityPoint) -> Double { pt.z }

pub fn stats_test_normality_point_label(pt : StatstestnormalityPoint) -> Int { pt.label }

pub fn stats_test_normality_point_dist(a : StatstestnormalityPoint, b : StatstestnormalityPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn stats_test_normality_point_add(a : StatstestnormalityPoint, b : StatstestnormalityPoint) -> StatstestnormalityPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn stats_test_normality_point_sub(a : StatstestnormalityPoint, b : StatstestnormalityPoint) -> StatstestnormalityPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn stats_test_normality_point_scale(pt : StatstestnormalityPoint, s : Double) -> StatstestnormalityPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn stats_test_normality_point_dot(a : StatstestnormalityPoint, b : StatstestnormalityPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn stats_test_normality_point_cross(a : StatstestnormalityPoint, b : StatstestnormalityPoint) -> StatstestnormalityPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn stats_test_normality_point_norm(pt : StatstestnormalityPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn stats_test_normality_point_normalize(pt : StatstestnormalityPoint) -> StatstestnormalityPoint {
  let n = stats_test_normality_point_norm(pt)
  if n < 0.0000001 { pt } else { stats_test_normality_point_scale(pt, 1.0 / n) }
}

pub fn stats_test_normality_point_negate(pt : StatstestnormalityPoint) -> StatstestnormalityPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn stats_test_normality_point_mid(a : StatstestnormalityPoint, b : StatstestnormalityPoint) -> StatstestnormalityPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn stats_test_normality_point_lerp(a : StatstestnormalityPoint, b : StatstestnormalityPoint, t : Double) -> StatstestnormalityPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn stats_test_normality_point_to_string(pt : StatstestnormalityPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct StatstestnormalitySeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_test_normality_make_series(vals : Array[Double], name : String) -> StatstestnormalitySeries {
  { vals, name, meta: 0 }
}

pub fn stats_test_normality_series_len(s : StatstestnormalitySeries) -> Int { s.vals.length() }

pub fn stats_test_normality_series_sum(s : StatstestnormalitySeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn stats_test_normality_series_mean(s : StatstestnormalitySeries) -> Double {
  let n = stats_test_normality_series_len(s)
  if n == 0 { 0.0 } else { stats_test_normality_series_sum(s) / n.to_double() }
}

pub fn stats_test_normality_series_min(s : StatstestnormalitySeries) -> Double {
  let n = stats_test_normality_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn stats_test_normality_series_max(s : StatstestnormalitySeries) -> Double {
  let n = stats_test_normality_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn stats_test_normality_series_range(s : StatstestnormalitySeries) -> Double {
  stats_test_normality_series_max(s) - stats_test_normality_series_min(s)
}

pub fn stats_test_normality_series_var(s : StatstestnormalitySeries) -> Double {
  let n = stats_test_normality_series_len(s)
  if n == 0 { 0.0 } else {
    let m = stats_test_normality_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn stats_test_normality_series_std(s : StatstestnormalitySeries) -> Double { @_common.sqrt(stats_test_normality_series_var(s)) }

pub fn stats_test_normality_series_median(s : StatstestnormalitySeries) -> Double {
  let n = stats_test_normality_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = stats_test_normality_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn stats_test_normality_series_scale(s : StatstestnormalitySeries, f : Double) -> StatstestnormalitySeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn stats_test_normality_series_add(a : StatstestnormalitySeries, b : StatstestnormalitySeries) -> StatstestnormalitySeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn stats_test_normality_series_sub(a : StatstestnormalitySeries, b : StatstestnormalitySeries) -> StatstestnormalitySeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn stats_test_normality_series_normalize(s : StatstestnormalitySeries) -> StatstestnormalitySeries {
  let mn = stats_test_normality_series_min(s)
  let mx = stats_test_normality_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn stats_test_normality_series_cumsum(s : StatstestnormalitySeries) -> StatstestnormalitySeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn stats_test_normality_series_to_string(s : StatstestnormalitySeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatstestnormalityMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_test_normality_make_matrix(rows : Int, cols : Int, val : Double) -> StatstestnormalityMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_test_normality_matrix_identity(n : Int) -> StatstestnormalityMatrix {
  let m = stats_test_normality_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn stats_test_normality_matrix_get(m : StatstestnormalityMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn stats_test_normality_matrix_transpose(m : StatstestnormalityMatrix) -> StatstestnormalityMatrix {
  let result = stats_test_normality_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn stats_test_normality_matrix_add(a : StatstestnormalityMatrix, b : StatstestnormalityMatrix) -> StatstestnormalityMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = stats_test_normality_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn stats_test_normality_matrix_scale(m : StatstestnormalityMatrix, s : Double) -> StatstestnormalityMatrix {
  let result = stats_test_normality_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn stats_test_normality_matrix_multiply(a : StatstestnormalityMatrix, b : StatstestnormalityMatrix) -> StatstestnormalityMatrix {
  if a.cols != b.rows { return stats_test_normality_make_matrix(a.rows, b.cols, 0.0) }
  let result = stats_test_normality_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn stats_test_normality_matrix_trace(m : StatstestnormalityMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn stats_test_normality_matrix_det(m : StatstestnormalityMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn stats_test_normality_matrix_norm(m : StatstestnormalityMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn stats_test_normality_matrix_to_string(m : StatstestnormalityMatrix) -> String {
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

pub(all) struct StatstestnormalityVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_test_normality_make_vector(comps : Array[Double]) -> StatstestnormalityVector {
  { comps, dim: comps.length() }
}

pub fn stats_test_normality_vector_zero(dim : Int) -> StatstestnormalityVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn stats_test_normality_vector_add(a : StatstestnormalityVector, b : StatstestnormalityVector) -> StatstestnormalityVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_test_normality_vector_sub(a : StatstestnormalityVector, b : StatstestnormalityVector) -> StatstestnormalityVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_test_normality_vector_scale(v : StatstestnormalityVector, s : Double) -> StatstestnormalityVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn stats_test_normality_vector_dot(a : StatstestnormalityVector, b : StatstestnormalityVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn stats_test_normality_vector_norm(v : StatstestnormalityVector) -> Double { @_common.sqrt(stats_test_normality_vector_dot(v, v)) }

pub fn stats_test_normality_vector_normalize(v : StatstestnormalityVector) -> StatstestnormalityVector {
  let n = stats_test_normality_vector_norm(v)
  if n < 0.0000001 { v } else { stats_test_normality_vector_scale(v, 1.0 / n) }
}

pub fn stats_test_normality_vector_dist(a : StatstestnormalityVector, b : StatstestnormalityVector) -> Double {
  stats_test_normality_vector_norm(stats_test_normality_vector_sub(a, b))
}

pub fn stats_test_normality_vector_to_string(v : StatstestnormalityVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn stats_test_normality_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn stats_test_normality_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = stats_test_normality_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn stats_test_normality_std(data : Array[Double]) -> Double { @_common.sqrt(stats_test_normality_var(data)) }

pub fn stats_test_normality_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = stats_test_normality_mean(a); let mb = stats_test_normality_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn stats_test_normality_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = stats_test_normality_std(a); let sb = stats_test_normality_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { stats_test_normality_cov(a, b) / (sa * sb) }
}

pub fn stats_test_normality_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = stats_test_normality_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn stats_test_normality_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn stats_test_normality_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn stats_test_normality_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(stats_test_normality_mse(pred, labels))
}

pub fn stats_test_normality_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn stats_test_normality_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = stats_test_normality_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn stats_test_normality_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn stats_test_normality_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn stats_test_normality_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = stats_test_normality_precision(pred, labels, pos); let r = stats_test_normality_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn stats_test_normality_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn stats_test_normality_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = stats_test_normality_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn stats_test_normality_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn stats_test_normality_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn stats_test_normality_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = stats_test_normality_gcd(a, b)
    (a / g) * b
  }
}

pub fn stats_test_normality_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn stats_test_normality_fibonacci(n : Int) -> Int {
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

pub fn stats_test_normality_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = stats_test_normality_min(data); let mx = stats_test_normality_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn stats_test_normality_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = stats_test_normality_mean(data); let sd = stats_test_normality_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn stats_test_normality_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn stats_test_normality_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn stats_test_normality_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn stats_test_normality_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn stats_test_normality_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn stats_test_normality_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct StatstestnormalityFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_normality_frame_make(size : Int) -> StatstestnormalityFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_normality_frame_len(s : StatstestnormalityFrame) -> Int { s.size }

pub fn stats_test_normality_frame_get(s : StatstestnormalityFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_normality_frame_set(s : StatstestnormalityFrame, i : Int, v : Double) -> StatstestnormalityFrame {
  let result = stats_test_normality_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_normality_frame_sum(s : StatstestnormalityFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_normality_frame_mean(s : StatstestnormalityFrame) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_normality_frame_sum(s) / s.size.to_double() }
}

pub fn stats_test_normality_frame_scale(s : StatstestnormalityFrame, f : Double) -> StatstestnormalityFrame {
  let result = stats_test_normality_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_normality_frame_add(a : StatstestnormalityFrame, b : StatstestnormalityFrame) -> StatstestnormalityFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_normality_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_normality_frame_copy(s : StatstestnormalityFrame) -> StatstestnormalityFrame {
  let result = stats_test_normality_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_normality_frame_fill(s : StatstestnormalityFrame, v : Double) -> StatstestnormalityFrame {
  let result = stats_test_normality_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_normality_frame_min(s : StatstestnormalityFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_normality_frame_max(s : StatstestnormalityFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_normality_frame_to_string(s : StatstestnormalityFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestnormalityTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_normality_table_make(size : Int) -> StatstestnormalityTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_normality_table_len(s : StatstestnormalityTable) -> Int { s.size }

pub fn stats_test_normality_table_get(s : StatstestnormalityTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_normality_table_set(s : StatstestnormalityTable, i : Int, v : Double) -> StatstestnormalityTable {
  let result = stats_test_normality_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_normality_table_sum(s : StatstestnormalityTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_normality_table_mean(s : StatstestnormalityTable) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_normality_table_sum(s) / s.size.to_double() }
}

pub fn stats_test_normality_table_scale(s : StatstestnormalityTable, f : Double) -> StatstestnormalityTable {
  let result = stats_test_normality_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_normality_table_add(a : StatstestnormalityTable, b : StatstestnormalityTable) -> StatstestnormalityTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_normality_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_normality_table_copy(s : StatstestnormalityTable) -> StatstestnormalityTable {
  let result = stats_test_normality_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_normality_table_fill(s : StatstestnormalityTable, v : Double) -> StatstestnormalityTable {
  let result = stats_test_normality_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_normality_table_min(s : StatstestnormalityTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_normality_table_max(s : StatstestnormalityTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_normality_table_to_string(s : StatstestnormalityTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestnormalityGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_normality_graphn_make(size : Int) -> StatstestnormalityGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_normality_graphn_len(s : StatstestnormalityGraphN) -> Int { s.size }

pub fn stats_test_normality_graphn_get(s : StatstestnormalityGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_normality_graphn_set(s : StatstestnormalityGraphN, i : Int, v : Double) -> StatstestnormalityGraphN {
  let result = stats_test_normality_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_normality_graphn_sum(s : StatstestnormalityGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_normality_graphn_mean(s : StatstestnormalityGraphN) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_normality_graphn_sum(s) / s.size.to_double() }
}

pub fn stats_test_normality_graphn_scale(s : StatstestnormalityGraphN, f : Double) -> StatstestnormalityGraphN {
  let result = stats_test_normality_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_normality_graphn_add(a : StatstestnormalityGraphN, b : StatstestnormalityGraphN) -> StatstestnormalityGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_normality_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_normality_graphn_copy(s : StatstestnormalityGraphN) -> StatstestnormalityGraphN {
  let result = stats_test_normality_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_normality_graphn_fill(s : StatstestnormalityGraphN, v : Double) -> StatstestnormalityGraphN {
  let result = stats_test_normality_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_normality_graphn_min(s : StatstestnormalityGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_normality_graphn_max(s : StatstestnormalityGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_normality_graphn_to_string(s : StatstestnormalityGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestnormalityNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_normality_node_make(size : Int) -> StatstestnormalityNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_normality_node_len(s : StatstestnormalityNode) -> Int { s.size }

pub fn stats_test_normality_node_get(s : StatstestnormalityNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_normality_node_set(s : StatstestnormalityNode, i : Int, v : Double) -> StatstestnormalityNode {
  let result = stats_test_normality_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_normality_node_sum(s : StatstestnormalityNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_normality_node_mean(s : StatstestnormalityNode) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_normality_node_sum(s) / s.size.to_double() }
}

pub fn stats_test_normality_node_scale(s : StatstestnormalityNode, f : Double) -> StatstestnormalityNode {
  let result = stats_test_normality_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_normality_node_add(a : StatstestnormalityNode, b : StatstestnormalityNode) -> StatstestnormalityNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_normality_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_normality_node_copy(s : StatstestnormalityNode) -> StatstestnormalityNode {
  let result = stats_test_normality_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_normality_node_fill(s : StatstestnormalityNode, v : Double) -> StatstestnormalityNode {
  let result = stats_test_normality_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_normality_node_min(s : StatstestnormalityNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_normality_node_max(s : StatstestnormalityNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_normality_node_to_string(s : StatstestnormalityNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestnormalityEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_normality_edge_make(size : Int) -> StatstestnormalityEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_normality_edge_len(s : StatstestnormalityEdge) -> Int { s.size }

pub fn stats_test_normality_edge_get(s : StatstestnormalityEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_normality_edge_set(s : StatstestnormalityEdge, i : Int, v : Double) -> StatstestnormalityEdge {
  let result = stats_test_normality_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_normality_edge_sum(s : StatstestnormalityEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_normality_edge_mean(s : StatstestnormalityEdge) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_normality_edge_sum(s) / s.size.to_double() }
}

pub fn stats_test_normality_edge_scale(s : StatstestnormalityEdge, f : Double) -> StatstestnormalityEdge {
  let result = stats_test_normality_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_normality_edge_add(a : StatstestnormalityEdge, b : StatstestnormalityEdge) -> StatstestnormalityEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_normality_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_normality_edge_copy(s : StatstestnormalityEdge) -> StatstestnormalityEdge {
  let result = stats_test_normality_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_normality_edge_fill(s : StatstestnormalityEdge, v : Double) -> StatstestnormalityEdge {
  let result = stats_test_normality_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_normality_edge_min(s : StatstestnormalityEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_normality_edge_max(s : StatstestnormalityEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_normality_edge_to_string(s : StatstestnormalityEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestnormalityPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_normality_path_make(size : Int) -> StatstestnormalityPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_normality_path_len(s : StatstestnormalityPath) -> Int { s.size }

pub fn stats_test_normality_path_get(s : StatstestnormalityPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_normality_path_set(s : StatstestnormalityPath, i : Int, v : Double) -> StatstestnormalityPath {
  let result = stats_test_normality_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_normality_path_sum(s : StatstestnormalityPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_normality_path_mean(s : StatstestnormalityPath) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_normality_path_sum(s) / s.size.to_double() }
}

pub fn stats_test_normality_path_scale(s : StatstestnormalityPath, f : Double) -> StatstestnormalityPath {
  let result = stats_test_normality_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_normality_path_add(a : StatstestnormalityPath, b : StatstestnormalityPath) -> StatstestnormalityPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_normality_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_normality_path_copy(s : StatstestnormalityPath) -> StatstestnormalityPath {
  let result = stats_test_normality_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_normality_path_fill(s : StatstestnormalityPath, v : Double) -> StatstestnormalityPath {
  let result = stats_test_normality_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_normality_path_min(s : StatstestnormalityPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_normality_path_max(s : StatstestnormalityPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_normality_path_to_string(s : StatstestnormalityPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestnormalityCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_normality_cluster_make(size : Int) -> StatstestnormalityCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_normality_cluster_len(s : StatstestnormalityCluster) -> Int { s.size }

pub fn stats_test_normality_cluster_get(s : StatstestnormalityCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_normality_cluster_set(s : StatstestnormalityCluster, i : Int, v : Double) -> StatstestnormalityCluster {
  let result = stats_test_normality_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_normality_cluster_sum(s : StatstestnormalityCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_normality_cluster_mean(s : StatstestnormalityCluster) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_normality_cluster_sum(s) / s.size.to_double() }
}

pub fn stats_test_normality_cluster_scale(s : StatstestnormalityCluster, f : Double) -> StatstestnormalityCluster {
  let result = stats_test_normality_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_normality_cluster_add(a : StatstestnormalityCluster, b : StatstestnormalityCluster) -> StatstestnormalityCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_normality_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_normality_cluster_copy(s : StatstestnormalityCluster) -> StatstestnormalityCluster {
  let result = stats_test_normality_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_normality_cluster_fill(s : StatstestnormalityCluster, v : Double) -> StatstestnormalityCluster {
  let result = stats_test_normality_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_normality_cluster_min(s : StatstestnormalityCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_normality_cluster_max(s : StatstestnormalityCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_normality_cluster_to_string(s : StatstestnormalityCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestnormalityModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_normality_model_make(size : Int) -> StatstestnormalityModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_normality_model_len(s : StatstestnormalityModel) -> Int { s.size }

pub fn stats_test_normality_model_get(s : StatstestnormalityModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_normality_model_set(s : StatstestnormalityModel, i : Int, v : Double) -> StatstestnormalityModel {
  let result = stats_test_normality_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_normality_model_sum(s : StatstestnormalityModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_normality_model_mean(s : StatstestnormalityModel) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_normality_model_sum(s) / s.size.to_double() }
}

pub fn stats_test_normality_model_scale(s : StatstestnormalityModel, f : Double) -> StatstestnormalityModel {
  let result = stats_test_normality_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_normality_model_add(a : StatstestnormalityModel, b : StatstestnormalityModel) -> StatstestnormalityModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_normality_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_normality_model_copy(s : StatstestnormalityModel) -> StatstestnormalityModel {
  let result = stats_test_normality_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_normality_model_fill(s : StatstestnormalityModel, v : Double) -> StatstestnormalityModel {
  let result = stats_test_normality_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_normality_model_min(s : StatstestnormalityModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_normality_model_max(s : StatstestnormalityModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_normality_model_to_string(s : StatstestnormalityModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestnormalityLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_normality_layer_make(size : Int) -> StatstestnormalityLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_normality_layer_len(s : StatstestnormalityLayer) -> Int { s.size }

pub fn stats_test_normality_layer_get(s : StatstestnormalityLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_normality_layer_set(s : StatstestnormalityLayer, i : Int, v : Double) -> StatstestnormalityLayer {
  let result = stats_test_normality_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_normality_layer_sum(s : StatstestnormalityLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_normality_layer_mean(s : StatstestnormalityLayer) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_normality_layer_sum(s) / s.size.to_double() }
}

pub fn stats_test_normality_layer_scale(s : StatstestnormalityLayer, f : Double) -> StatstestnormalityLayer {
  let result = stats_test_normality_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_normality_layer_add(a : StatstestnormalityLayer, b : StatstestnormalityLayer) -> StatstestnormalityLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_normality_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_normality_layer_copy(s : StatstestnormalityLayer) -> StatstestnormalityLayer {
  let result = stats_test_normality_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_normality_layer_fill(s : StatstestnormalityLayer, v : Double) -> StatstestnormalityLayer {
  let result = stats_test_normality_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_normality_layer_min(s : StatstestnormalityLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_normality_layer_max(s : StatstestnormalityLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_normality_layer_to_string(s : StatstestnormalityLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestnormalityBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_normality_buffer_make(size : Int) -> StatstestnormalityBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_normality_buffer_len(s : StatstestnormalityBuffer) -> Int { s.size }

pub fn stats_test_normality_buffer_get(s : StatstestnormalityBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_normality_buffer_set(s : StatstestnormalityBuffer, i : Int, v : Double) -> StatstestnormalityBuffer {
  let result = stats_test_normality_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_normality_buffer_sum(s : StatstestnormalityBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_normality_buffer_mean(s : StatstestnormalityBuffer) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_normality_buffer_sum(s) / s.size.to_double() }
}

pub fn stats_test_normality_buffer_scale(s : StatstestnormalityBuffer, f : Double) -> StatstestnormalityBuffer {
  let result = stats_test_normality_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_normality_buffer_add(a : StatstestnormalityBuffer, b : StatstestnormalityBuffer) -> StatstestnormalityBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_normality_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_normality_buffer_copy(s : StatstestnormalityBuffer) -> StatstestnormalityBuffer {
  let result = stats_test_normality_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_normality_buffer_fill(s : StatstestnormalityBuffer, v : Double) -> StatstestnormalityBuffer {
  let result = stats_test_normality_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_normality_buffer_min(s : StatstestnormalityBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_normality_buffer_max(s : StatstestnormalityBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_normality_buffer_to_string(s : StatstestnormalityBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestnormalityCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_normality_cursor_make(size : Int) -> StatstestnormalityCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_normality_cursor_len(s : StatstestnormalityCursor) -> Int { s.size }

pub fn stats_test_normality_cursor_get(s : StatstestnormalityCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_normality_cursor_set(s : StatstestnormalityCursor, i : Int, v : Double) -> StatstestnormalityCursor {
  let result = stats_test_normality_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_normality_cursor_sum(s : StatstestnormalityCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_normality_cursor_mean(s : StatstestnormalityCursor) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_normality_cursor_sum(s) / s.size.to_double() }
}

pub fn stats_test_normality_cursor_scale(s : StatstestnormalityCursor, f : Double) -> StatstestnormalityCursor {
  let result = stats_test_normality_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_normality_cursor_add(a : StatstestnormalityCursor, b : StatstestnormalityCursor) -> StatstestnormalityCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_normality_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_normality_cursor_copy(s : StatstestnormalityCursor) -> StatstestnormalityCursor {
  let result = stats_test_normality_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_normality_cursor_fill(s : StatstestnormalityCursor, v : Double) -> StatstestnormalityCursor {
  let result = stats_test_normality_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_normality_cursor_min(s : StatstestnormalityCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_normality_cursor_max(s : StatstestnormalityCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_normality_cursor_to_string(s : StatstestnormalityCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestnormalityView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_normality_view_make(size : Int) -> StatstestnormalityView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_normality_view_len(s : StatstestnormalityView) -> Int { s.size }

pub fn stats_test_normality_view_get(s : StatstestnormalityView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_normality_view_set(s : StatstestnormalityView, i : Int, v : Double) -> StatstestnormalityView {
  let result = stats_test_normality_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_normality_view_sum(s : StatstestnormalityView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_normality_view_mean(s : StatstestnormalityView) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_normality_view_sum(s) / s.size.to_double() }
}

pub fn stats_test_normality_view_scale(s : StatstestnormalityView, f : Double) -> StatstestnormalityView {
  let result = stats_test_normality_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_normality_view_add(a : StatstestnormalityView, b : StatstestnormalityView) -> StatstestnormalityView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_normality_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_normality_view_copy(s : StatstestnormalityView) -> StatstestnormalityView {
  let result = stats_test_normality_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_normality_view_fill(s : StatstestnormalityView, v : Double) -> StatstestnormalityView {
  let result = stats_test_normality_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_normality_view_min(s : StatstestnormalityView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_normality_view_max(s : StatstestnormalityView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_normality_view_to_string(s : StatstestnormalityView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestnormalityRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_normality_range_make(size : Int) -> StatstestnormalityRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_normality_range_len(s : StatstestnormalityRange) -> Int { s.size }

pub fn stats_test_normality_range_get(s : StatstestnormalityRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_normality_range_set(s : StatstestnormalityRange, i : Int, v : Double) -> StatstestnormalityRange {
  let result = stats_test_normality_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_normality_range_sum(s : StatstestnormalityRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_normality_range_mean(s : StatstestnormalityRange) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_normality_range_sum(s) / s.size.to_double() }
}

pub fn stats_test_normality_range_scale(s : StatstestnormalityRange, f : Double) -> StatstestnormalityRange {
  let result = stats_test_normality_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_normality_range_add(a : StatstestnormalityRange, b : StatstestnormalityRange) -> StatstestnormalityRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_normality_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_normality_range_copy(s : StatstestnormalityRange) -> StatstestnormalityRange {
  let result = stats_test_normality_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_normality_range_fill(s : StatstestnormalityRange, v : Double) -> StatstestnormalityRange {
  let result = stats_test_normality_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_normality_range_min(s : StatstestnormalityRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_normality_range_max(s : StatstestnormalityRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_normality_range_to_string(s : StatstestnormalityRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestnormalitySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_normality_slice_make(size : Int) -> StatstestnormalitySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_normality_slice_len(s : StatstestnormalitySlice) -> Int { s.size }

pub fn stats_test_normality_slice_get(s : StatstestnormalitySlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_normality_slice_set(s : StatstestnormalitySlice, i : Int, v : Double) -> StatstestnormalitySlice {
  let result = stats_test_normality_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_normality_slice_sum(s : StatstestnormalitySlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_normality_slice_mean(s : StatstestnormalitySlice) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_normality_slice_sum(s) / s.size.to_double() }
}

pub fn stats_test_normality_slice_scale(s : StatstestnormalitySlice, f : Double) -> StatstestnormalitySlice {
  let result = stats_test_normality_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_normality_slice_add(a : StatstestnormalitySlice, b : StatstestnormalitySlice) -> StatstestnormalitySlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_normality_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_normality_slice_copy(s : StatstestnormalitySlice) -> StatstestnormalitySlice {
  let result = stats_test_normality_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_normality_slice_fill(s : StatstestnormalitySlice, v : Double) -> StatstestnormalitySlice {
  let result = stats_test_normality_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_normality_slice_min(s : StatstestnormalitySlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_normality_slice_max(s : StatstestnormalitySlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_normality_slice_to_string(s : StatstestnormalitySlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


///===
/// extcore/stats_test_independence

pub(all) struct StatstestindependencePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_test_independence_make_point(x : Double, y : Double) -> StatstestindependencePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_test_independence_make_point3(x : Double, y : Double, z : Double) -> StatstestindependencePoint {
  { x, y, z, label: 0 }
}

pub fn stats_test_independence_point_x(pt : StatstestindependencePoint) -> Double { pt.x }

pub fn stats_test_independence_point_y(pt : StatstestindependencePoint) -> Double { pt.y }

pub fn stats_test_independence_point_z(pt : StatstestindependencePoint) -> Double { pt.z }

pub fn stats_test_independence_point_label(pt : StatstestindependencePoint) -> Int { pt.label }

pub fn stats_test_independence_point_dist(a : StatstestindependencePoint, b : StatstestindependencePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn stats_test_independence_point_add(a : StatstestindependencePoint, b : StatstestindependencePoint) -> StatstestindependencePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn stats_test_independence_point_sub(a : StatstestindependencePoint, b : StatstestindependencePoint) -> StatstestindependencePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn stats_test_independence_point_scale(pt : StatstestindependencePoint, s : Double) -> StatstestindependencePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn stats_test_independence_point_dot(a : StatstestindependencePoint, b : StatstestindependencePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn stats_test_independence_point_cross(a : StatstestindependencePoint, b : StatstestindependencePoint) -> StatstestindependencePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn stats_test_independence_point_norm(pt : StatstestindependencePoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn stats_test_independence_point_normalize(pt : StatstestindependencePoint) -> StatstestindependencePoint {
  let n = stats_test_independence_point_norm(pt)
  if n < 0.0000001 { pt } else { stats_test_independence_point_scale(pt, 1.0 / n) }
}

pub fn stats_test_independence_point_negate(pt : StatstestindependencePoint) -> StatstestindependencePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn stats_test_independence_point_mid(a : StatstestindependencePoint, b : StatstestindependencePoint) -> StatstestindependencePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn stats_test_independence_point_lerp(a : StatstestindependencePoint, b : StatstestindependencePoint, t : Double) -> StatstestindependencePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn stats_test_independence_point_to_string(pt : StatstestindependencePoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct StatstestindependenceSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_test_independence_make_series(vals : Array[Double], name : String) -> StatstestindependenceSeries {
  { vals, name, meta: 0 }
}

pub fn stats_test_independence_series_len(s : StatstestindependenceSeries) -> Int { s.vals.length() }

pub fn stats_test_independence_series_sum(s : StatstestindependenceSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn stats_test_independence_series_mean(s : StatstestindependenceSeries) -> Double {
  let n = stats_test_independence_series_len(s)
  if n == 0 { 0.0 } else { stats_test_independence_series_sum(s) / n.to_double() }
}

pub fn stats_test_independence_series_min(s : StatstestindependenceSeries) -> Double {
  let n = stats_test_independence_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn stats_test_independence_series_max(s : StatstestindependenceSeries) -> Double {
  let n = stats_test_independence_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn stats_test_independence_series_range(s : StatstestindependenceSeries) -> Double {
  stats_test_independence_series_max(s) - stats_test_independence_series_min(s)
}

pub fn stats_test_independence_series_var(s : StatstestindependenceSeries) -> Double {
  let n = stats_test_independence_series_len(s)
  if n == 0 { 0.0 } else {
    let m = stats_test_independence_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn stats_test_independence_series_std(s : StatstestindependenceSeries) -> Double { @_common.sqrt(stats_test_independence_series_var(s)) }

pub fn stats_test_independence_series_median(s : StatstestindependenceSeries) -> Double {
  let n = stats_test_independence_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = stats_test_independence_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn stats_test_independence_series_scale(s : StatstestindependenceSeries, f : Double) -> StatstestindependenceSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn stats_test_independence_series_add(a : StatstestindependenceSeries, b : StatstestindependenceSeries) -> StatstestindependenceSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn stats_test_independence_series_sub(a : StatstestindependenceSeries, b : StatstestindependenceSeries) -> StatstestindependenceSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn stats_test_independence_series_normalize(s : StatstestindependenceSeries) -> StatstestindependenceSeries {
  let mn = stats_test_independence_series_min(s)
  let mx = stats_test_independence_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn stats_test_independence_series_cumsum(s : StatstestindependenceSeries) -> StatstestindependenceSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn stats_test_independence_series_to_string(s : StatstestindependenceSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatstestindependenceMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_test_independence_make_matrix(rows : Int, cols : Int, val : Double) -> StatstestindependenceMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_test_independence_matrix_identity(n : Int) -> StatstestindependenceMatrix {
  let m = stats_test_independence_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn stats_test_independence_matrix_get(m : StatstestindependenceMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn stats_test_independence_matrix_transpose(m : StatstestindependenceMatrix) -> StatstestindependenceMatrix {
  let result = stats_test_independence_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn stats_test_independence_matrix_add(a : StatstestindependenceMatrix, b : StatstestindependenceMatrix) -> StatstestindependenceMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = stats_test_independence_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn stats_test_independence_matrix_scale(m : StatstestindependenceMatrix, s : Double) -> StatstestindependenceMatrix {
  let result = stats_test_independence_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn stats_test_independence_matrix_multiply(a : StatstestindependenceMatrix, b : StatstestindependenceMatrix) -> StatstestindependenceMatrix {
  if a.cols != b.rows { return stats_test_independence_make_matrix(a.rows, b.cols, 0.0) }
  let result = stats_test_independence_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn stats_test_independence_matrix_trace(m : StatstestindependenceMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn stats_test_independence_matrix_det(m : StatstestindependenceMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn stats_test_independence_matrix_norm(m : StatstestindependenceMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn stats_test_independence_matrix_to_string(m : StatstestindependenceMatrix) -> String {
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

pub(all) struct StatstestindependenceVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_test_independence_make_vector(comps : Array[Double]) -> StatstestindependenceVector {
  { comps, dim: comps.length() }
}

pub fn stats_test_independence_vector_zero(dim : Int) -> StatstestindependenceVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn stats_test_independence_vector_add(a : StatstestindependenceVector, b : StatstestindependenceVector) -> StatstestindependenceVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_test_independence_vector_sub(a : StatstestindependenceVector, b : StatstestindependenceVector) -> StatstestindependenceVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_test_independence_vector_scale(v : StatstestindependenceVector, s : Double) -> StatstestindependenceVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn stats_test_independence_vector_dot(a : StatstestindependenceVector, b : StatstestindependenceVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn stats_test_independence_vector_norm(v : StatstestindependenceVector) -> Double { @_common.sqrt(stats_test_independence_vector_dot(v, v)) }

pub fn stats_test_independence_vector_normalize(v : StatstestindependenceVector) -> StatstestindependenceVector {
  let n = stats_test_independence_vector_norm(v)
  if n < 0.0000001 { v } else { stats_test_independence_vector_scale(v, 1.0 / n) }
}

pub fn stats_test_independence_vector_dist(a : StatstestindependenceVector, b : StatstestindependenceVector) -> Double {
  stats_test_independence_vector_norm(stats_test_independence_vector_sub(a, b))
}

pub fn stats_test_independence_vector_to_string(v : StatstestindependenceVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn stats_test_independence_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn stats_test_independence_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = stats_test_independence_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn stats_test_independence_std(data : Array[Double]) -> Double { @_common.sqrt(stats_test_independence_var(data)) }

pub fn stats_test_independence_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = stats_test_independence_mean(a); let mb = stats_test_independence_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn stats_test_independence_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = stats_test_independence_std(a); let sb = stats_test_independence_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { stats_test_independence_cov(a, b) / (sa * sb) }
}

pub fn stats_test_independence_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = stats_test_independence_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn stats_test_independence_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn stats_test_independence_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn stats_test_independence_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(stats_test_independence_mse(pred, labels))
}

pub fn stats_test_independence_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn stats_test_independence_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = stats_test_independence_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn stats_test_independence_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn stats_test_independence_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn stats_test_independence_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = stats_test_independence_precision(pred, labels, pos); let r = stats_test_independence_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn stats_test_independence_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn stats_test_independence_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = stats_test_independence_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn stats_test_independence_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn stats_test_independence_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn stats_test_independence_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = stats_test_independence_gcd(a, b)
    (a / g) * b
  }
}

pub fn stats_test_independence_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn stats_test_independence_fibonacci(n : Int) -> Int {
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

pub fn stats_test_independence_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = stats_test_independence_min(data); let mx = stats_test_independence_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn stats_test_independence_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = stats_test_independence_mean(data); let sd = stats_test_independence_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn stats_test_independence_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn stats_test_independence_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn stats_test_independence_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn stats_test_independence_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn stats_test_independence_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn stats_test_independence_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct StatstestindependenceFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_independence_frame_make(size : Int) -> StatstestindependenceFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_independence_frame_len(s : StatstestindependenceFrame) -> Int { s.size }

pub fn stats_test_independence_frame_get(s : StatstestindependenceFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_independence_frame_set(s : StatstestindependenceFrame, i : Int, v : Double) -> StatstestindependenceFrame {
  let result = stats_test_independence_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_independence_frame_sum(s : StatstestindependenceFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_independence_frame_mean(s : StatstestindependenceFrame) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_independence_frame_sum(s) / s.size.to_double() }
}

pub fn stats_test_independence_frame_scale(s : StatstestindependenceFrame, f : Double) -> StatstestindependenceFrame {
  let result = stats_test_independence_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_independence_frame_add(a : StatstestindependenceFrame, b : StatstestindependenceFrame) -> StatstestindependenceFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_independence_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_independence_frame_copy(s : StatstestindependenceFrame) -> StatstestindependenceFrame {
  let result = stats_test_independence_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_independence_frame_fill(s : StatstestindependenceFrame, v : Double) -> StatstestindependenceFrame {
  let result = stats_test_independence_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_independence_frame_min(s : StatstestindependenceFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_independence_frame_max(s : StatstestindependenceFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_independence_frame_to_string(s : StatstestindependenceFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestindependenceTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_independence_table_make(size : Int) -> StatstestindependenceTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_independence_table_len(s : StatstestindependenceTable) -> Int { s.size }

pub fn stats_test_independence_table_get(s : StatstestindependenceTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_independence_table_set(s : StatstestindependenceTable, i : Int, v : Double) -> StatstestindependenceTable {
  let result = stats_test_independence_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_independence_table_sum(s : StatstestindependenceTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_independence_table_mean(s : StatstestindependenceTable) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_independence_table_sum(s) / s.size.to_double() }
}

pub fn stats_test_independence_table_scale(s : StatstestindependenceTable, f : Double) -> StatstestindependenceTable {
  let result = stats_test_independence_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_independence_table_add(a : StatstestindependenceTable, b : StatstestindependenceTable) -> StatstestindependenceTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_independence_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_independence_table_copy(s : StatstestindependenceTable) -> StatstestindependenceTable {
  let result = stats_test_independence_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_independence_table_fill(s : StatstestindependenceTable, v : Double) -> StatstestindependenceTable {
  let result = stats_test_independence_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_independence_table_min(s : StatstestindependenceTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_independence_table_max(s : StatstestindependenceTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_independence_table_to_string(s : StatstestindependenceTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestindependenceGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_independence_graphn_make(size : Int) -> StatstestindependenceGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_independence_graphn_len(s : StatstestindependenceGraphN) -> Int { s.size }

pub fn stats_test_independence_graphn_get(s : StatstestindependenceGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_independence_graphn_set(s : StatstestindependenceGraphN, i : Int, v : Double) -> StatstestindependenceGraphN {
  let result = stats_test_independence_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_independence_graphn_sum(s : StatstestindependenceGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_independence_graphn_mean(s : StatstestindependenceGraphN) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_independence_graphn_sum(s) / s.size.to_double() }
}

pub fn stats_test_independence_graphn_scale(s : StatstestindependenceGraphN, f : Double) -> StatstestindependenceGraphN {
  let result = stats_test_independence_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_independence_graphn_add(a : StatstestindependenceGraphN, b : StatstestindependenceGraphN) -> StatstestindependenceGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_independence_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_independence_graphn_copy(s : StatstestindependenceGraphN) -> StatstestindependenceGraphN {
  let result = stats_test_independence_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_independence_graphn_fill(s : StatstestindependenceGraphN, v : Double) -> StatstestindependenceGraphN {
  let result = stats_test_independence_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_independence_graphn_min(s : StatstestindependenceGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_independence_graphn_max(s : StatstestindependenceGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_independence_graphn_to_string(s : StatstestindependenceGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestindependenceNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_independence_node_make(size : Int) -> StatstestindependenceNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_independence_node_len(s : StatstestindependenceNode) -> Int { s.size }

pub fn stats_test_independence_node_get(s : StatstestindependenceNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_independence_node_set(s : StatstestindependenceNode, i : Int, v : Double) -> StatstestindependenceNode {
  let result = stats_test_independence_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_independence_node_sum(s : StatstestindependenceNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_independence_node_mean(s : StatstestindependenceNode) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_independence_node_sum(s) / s.size.to_double() }
}

pub fn stats_test_independence_node_scale(s : StatstestindependenceNode, f : Double) -> StatstestindependenceNode {
  let result = stats_test_independence_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_independence_node_add(a : StatstestindependenceNode, b : StatstestindependenceNode) -> StatstestindependenceNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_independence_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_independence_node_copy(s : StatstestindependenceNode) -> StatstestindependenceNode {
  let result = stats_test_independence_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_independence_node_fill(s : StatstestindependenceNode, v : Double) -> StatstestindependenceNode {
  let result = stats_test_independence_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_independence_node_min(s : StatstestindependenceNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_independence_node_max(s : StatstestindependenceNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_independence_node_to_string(s : StatstestindependenceNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestindependenceEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_independence_edge_make(size : Int) -> StatstestindependenceEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_independence_edge_len(s : StatstestindependenceEdge) -> Int { s.size }

pub fn stats_test_independence_edge_get(s : StatstestindependenceEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_independence_edge_set(s : StatstestindependenceEdge, i : Int, v : Double) -> StatstestindependenceEdge {
  let result = stats_test_independence_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_independence_edge_sum(s : StatstestindependenceEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_independence_edge_mean(s : StatstestindependenceEdge) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_independence_edge_sum(s) / s.size.to_double() }
}

pub fn stats_test_independence_edge_scale(s : StatstestindependenceEdge, f : Double) -> StatstestindependenceEdge {
  let result = stats_test_independence_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_independence_edge_add(a : StatstestindependenceEdge, b : StatstestindependenceEdge) -> StatstestindependenceEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_independence_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_independence_edge_copy(s : StatstestindependenceEdge) -> StatstestindependenceEdge {
  let result = stats_test_independence_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_independence_edge_fill(s : StatstestindependenceEdge, v : Double) -> StatstestindependenceEdge {
  let result = stats_test_independence_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_independence_edge_min(s : StatstestindependenceEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_independence_edge_max(s : StatstestindependenceEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_independence_edge_to_string(s : StatstestindependenceEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestindependencePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_independence_path_make(size : Int) -> StatstestindependencePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_independence_path_len(s : StatstestindependencePath) -> Int { s.size }

pub fn stats_test_independence_path_get(s : StatstestindependencePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_independence_path_set(s : StatstestindependencePath, i : Int, v : Double) -> StatstestindependencePath {
  let result = stats_test_independence_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_independence_path_sum(s : StatstestindependencePath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_independence_path_mean(s : StatstestindependencePath) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_independence_path_sum(s) / s.size.to_double() }
}

pub fn stats_test_independence_path_scale(s : StatstestindependencePath, f : Double) -> StatstestindependencePath {
  let result = stats_test_independence_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_independence_path_add(a : StatstestindependencePath, b : StatstestindependencePath) -> StatstestindependencePath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_independence_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_independence_path_copy(s : StatstestindependencePath) -> StatstestindependencePath {
  let result = stats_test_independence_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_independence_path_fill(s : StatstestindependencePath, v : Double) -> StatstestindependencePath {
  let result = stats_test_independence_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_independence_path_min(s : StatstestindependencePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_independence_path_max(s : StatstestindependencePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_independence_path_to_string(s : StatstestindependencePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestindependenceCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_independence_cluster_make(size : Int) -> StatstestindependenceCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_independence_cluster_len(s : StatstestindependenceCluster) -> Int { s.size }

pub fn stats_test_independence_cluster_get(s : StatstestindependenceCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_independence_cluster_set(s : StatstestindependenceCluster, i : Int, v : Double) -> StatstestindependenceCluster {
  let result = stats_test_independence_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_independence_cluster_sum(s : StatstestindependenceCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_independence_cluster_mean(s : StatstestindependenceCluster) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_independence_cluster_sum(s) / s.size.to_double() }
}

pub fn stats_test_independence_cluster_scale(s : StatstestindependenceCluster, f : Double) -> StatstestindependenceCluster {
  let result = stats_test_independence_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_independence_cluster_add(a : StatstestindependenceCluster, b : StatstestindependenceCluster) -> StatstestindependenceCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_independence_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_independence_cluster_copy(s : StatstestindependenceCluster) -> StatstestindependenceCluster {
  let result = stats_test_independence_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_independence_cluster_fill(s : StatstestindependenceCluster, v : Double) -> StatstestindependenceCluster {
  let result = stats_test_independence_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_independence_cluster_min(s : StatstestindependenceCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_independence_cluster_max(s : StatstestindependenceCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_independence_cluster_to_string(s : StatstestindependenceCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestindependenceModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_independence_model_make(size : Int) -> StatstestindependenceModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_independence_model_len(s : StatstestindependenceModel) -> Int { s.size }

pub fn stats_test_independence_model_get(s : StatstestindependenceModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_independence_model_set(s : StatstestindependenceModel, i : Int, v : Double) -> StatstestindependenceModel {
  let result = stats_test_independence_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_independence_model_sum(s : StatstestindependenceModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_independence_model_mean(s : StatstestindependenceModel) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_independence_model_sum(s) / s.size.to_double() }
}

pub fn stats_test_independence_model_scale(s : StatstestindependenceModel, f : Double) -> StatstestindependenceModel {
  let result = stats_test_independence_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_independence_model_add(a : StatstestindependenceModel, b : StatstestindependenceModel) -> StatstestindependenceModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_independence_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_independence_model_copy(s : StatstestindependenceModel) -> StatstestindependenceModel {
  let result = stats_test_independence_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_independence_model_fill(s : StatstestindependenceModel, v : Double) -> StatstestindependenceModel {
  let result = stats_test_independence_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_independence_model_min(s : StatstestindependenceModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_independence_model_max(s : StatstestindependenceModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_independence_model_to_string(s : StatstestindependenceModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestindependenceLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_independence_layer_make(size : Int) -> StatstestindependenceLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_independence_layer_len(s : StatstestindependenceLayer) -> Int { s.size }

pub fn stats_test_independence_layer_get(s : StatstestindependenceLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_independence_layer_set(s : StatstestindependenceLayer, i : Int, v : Double) -> StatstestindependenceLayer {
  let result = stats_test_independence_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_independence_layer_sum(s : StatstestindependenceLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_independence_layer_mean(s : StatstestindependenceLayer) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_independence_layer_sum(s) / s.size.to_double() }
}

pub fn stats_test_independence_layer_scale(s : StatstestindependenceLayer, f : Double) -> StatstestindependenceLayer {
  let result = stats_test_independence_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_independence_layer_add(a : StatstestindependenceLayer, b : StatstestindependenceLayer) -> StatstestindependenceLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_independence_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_independence_layer_copy(s : StatstestindependenceLayer) -> StatstestindependenceLayer {
  let result = stats_test_independence_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_independence_layer_fill(s : StatstestindependenceLayer, v : Double) -> StatstestindependenceLayer {
  let result = stats_test_independence_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_independence_layer_min(s : StatstestindependenceLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_independence_layer_max(s : StatstestindependenceLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_independence_layer_to_string(s : StatstestindependenceLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestindependenceBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_independence_buffer_make(size : Int) -> StatstestindependenceBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_independence_buffer_len(s : StatstestindependenceBuffer) -> Int { s.size }

pub fn stats_test_independence_buffer_get(s : StatstestindependenceBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_independence_buffer_set(s : StatstestindependenceBuffer, i : Int, v : Double) -> StatstestindependenceBuffer {
  let result = stats_test_independence_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_independence_buffer_sum(s : StatstestindependenceBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_independence_buffer_mean(s : StatstestindependenceBuffer) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_independence_buffer_sum(s) / s.size.to_double() }
}

pub fn stats_test_independence_buffer_scale(s : StatstestindependenceBuffer, f : Double) -> StatstestindependenceBuffer {
  let result = stats_test_independence_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_independence_buffer_add(a : StatstestindependenceBuffer, b : StatstestindependenceBuffer) -> StatstestindependenceBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_independence_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_independence_buffer_copy(s : StatstestindependenceBuffer) -> StatstestindependenceBuffer {
  let result = stats_test_independence_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_independence_buffer_fill(s : StatstestindependenceBuffer, v : Double) -> StatstestindependenceBuffer {
  let result = stats_test_independence_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_independence_buffer_min(s : StatstestindependenceBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_independence_buffer_max(s : StatstestindependenceBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_independence_buffer_to_string(s : StatstestindependenceBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestindependenceCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_independence_cursor_make(size : Int) -> StatstestindependenceCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_independence_cursor_len(s : StatstestindependenceCursor) -> Int { s.size }

pub fn stats_test_independence_cursor_get(s : StatstestindependenceCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_independence_cursor_set(s : StatstestindependenceCursor, i : Int, v : Double) -> StatstestindependenceCursor {
  let result = stats_test_independence_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_independence_cursor_sum(s : StatstestindependenceCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_independence_cursor_mean(s : StatstestindependenceCursor) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_independence_cursor_sum(s) / s.size.to_double() }
}

pub fn stats_test_independence_cursor_scale(s : StatstestindependenceCursor, f : Double) -> StatstestindependenceCursor {
  let result = stats_test_independence_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_independence_cursor_add(a : StatstestindependenceCursor, b : StatstestindependenceCursor) -> StatstestindependenceCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_independence_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_independence_cursor_copy(s : StatstestindependenceCursor) -> StatstestindependenceCursor {
  let result = stats_test_independence_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_independence_cursor_fill(s : StatstestindependenceCursor, v : Double) -> StatstestindependenceCursor {
  let result = stats_test_independence_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_independence_cursor_min(s : StatstestindependenceCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_independence_cursor_max(s : StatstestindependenceCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_independence_cursor_to_string(s : StatstestindependenceCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestindependenceView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_independence_view_make(size : Int) -> StatstestindependenceView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_independence_view_len(s : StatstestindependenceView) -> Int { s.size }

pub fn stats_test_independence_view_get(s : StatstestindependenceView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_independence_view_set(s : StatstestindependenceView, i : Int, v : Double) -> StatstestindependenceView {
  let result = stats_test_independence_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_independence_view_sum(s : StatstestindependenceView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_independence_view_mean(s : StatstestindependenceView) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_independence_view_sum(s) / s.size.to_double() }
}

pub fn stats_test_independence_view_scale(s : StatstestindependenceView, f : Double) -> StatstestindependenceView {
  let result = stats_test_independence_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_independence_view_add(a : StatstestindependenceView, b : StatstestindependenceView) -> StatstestindependenceView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_independence_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_independence_view_copy(s : StatstestindependenceView) -> StatstestindependenceView {
  let result = stats_test_independence_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_independence_view_fill(s : StatstestindependenceView, v : Double) -> StatstestindependenceView {
  let result = stats_test_independence_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_independence_view_min(s : StatstestindependenceView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_independence_view_max(s : StatstestindependenceView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_independence_view_to_string(s : StatstestindependenceView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestindependenceRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_independence_range_make(size : Int) -> StatstestindependenceRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_independence_range_len(s : StatstestindependenceRange) -> Int { s.size }

pub fn stats_test_independence_range_get(s : StatstestindependenceRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_independence_range_set(s : StatstestindependenceRange, i : Int, v : Double) -> StatstestindependenceRange {
  let result = stats_test_independence_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_independence_range_sum(s : StatstestindependenceRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_independence_range_mean(s : StatstestindependenceRange) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_independence_range_sum(s) / s.size.to_double() }
}

pub fn stats_test_independence_range_scale(s : StatstestindependenceRange, f : Double) -> StatstestindependenceRange {
  let result = stats_test_independence_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_independence_range_add(a : StatstestindependenceRange, b : StatstestindependenceRange) -> StatstestindependenceRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_independence_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_independence_range_copy(s : StatstestindependenceRange) -> StatstestindependenceRange {
  let result = stats_test_independence_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_independence_range_fill(s : StatstestindependenceRange, v : Double) -> StatstestindependenceRange {
  let result = stats_test_independence_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_independence_range_min(s : StatstestindependenceRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_independence_range_max(s : StatstestindependenceRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_independence_range_to_string(s : StatstestindependenceRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestindependenceSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_independence_slice_make(size : Int) -> StatstestindependenceSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_independence_slice_len(s : StatstestindependenceSlice) -> Int { s.size }

pub fn stats_test_independence_slice_get(s : StatstestindependenceSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_independence_slice_set(s : StatstestindependenceSlice, i : Int, v : Double) -> StatstestindependenceSlice {
  let result = stats_test_independence_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_independence_slice_sum(s : StatstestindependenceSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_independence_slice_mean(s : StatstestindependenceSlice) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_independence_slice_sum(s) / s.size.to_double() }
}

pub fn stats_test_independence_slice_scale(s : StatstestindependenceSlice, f : Double) -> StatstestindependenceSlice {
  let result = stats_test_independence_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_independence_slice_add(a : StatstestindependenceSlice, b : StatstestindependenceSlice) -> StatstestindependenceSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_independence_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_independence_slice_copy(s : StatstestindependenceSlice) -> StatstestindependenceSlice {
  let result = stats_test_independence_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_independence_slice_fill(s : StatstestindependenceSlice, v : Double) -> StatstestindependenceSlice {
  let result = stats_test_independence_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_independence_slice_min(s : StatstestindependenceSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_independence_slice_max(s : StatstestindependenceSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_independence_slice_to_string(s : StatstestindependenceSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


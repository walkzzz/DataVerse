///===
/// extcore/stats_model_glm

pub(all) struct StatsmodelglmPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_model_glm_make_point(x : Double, y : Double) -> StatsmodelglmPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_model_glm_make_point3(x : Double, y : Double, z : Double) -> StatsmodelglmPoint {
  { x, y, z, label: 0 }
}

pub fn stats_model_glm_point_x(pt : StatsmodelglmPoint) -> Double { pt.x }

pub fn stats_model_glm_point_y(pt : StatsmodelglmPoint) -> Double { pt.y }

pub fn stats_model_glm_point_z(pt : StatsmodelglmPoint) -> Double { pt.z }

pub fn stats_model_glm_point_label(pt : StatsmodelglmPoint) -> Int { pt.label }

pub fn stats_model_glm_point_dist(a : StatsmodelglmPoint, b : StatsmodelglmPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  stats_model_glm_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn stats_model_glm_point_add(a : StatsmodelglmPoint, b : StatsmodelglmPoint) -> StatsmodelglmPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn stats_model_glm_point_sub(a : StatsmodelglmPoint, b : StatsmodelglmPoint) -> StatsmodelglmPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn stats_model_glm_point_scale(pt : StatsmodelglmPoint, s : Double) -> StatsmodelglmPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn stats_model_glm_point_dot(a : StatsmodelglmPoint, b : StatsmodelglmPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn stats_model_glm_point_cross(a : StatsmodelglmPoint, b : StatsmodelglmPoint) -> StatsmodelglmPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn stats_model_glm_point_norm(pt : StatsmodelglmPoint) -> Double {
  stats_model_glm_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn stats_model_glm_point_normalize(pt : StatsmodelglmPoint) -> StatsmodelglmPoint {
  let n = stats_model_glm_point_norm(pt)
  if n < 0.0000001 { pt } else { stats_model_glm_point_scale(pt, 1.0 / n) }
}

pub fn stats_model_glm_point_negate(pt : StatsmodelglmPoint) -> StatsmodelglmPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn stats_model_glm_point_mid(a : StatsmodelglmPoint, b : StatsmodelglmPoint) -> StatsmodelglmPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn stats_model_glm_point_lerp(a : StatsmodelglmPoint, b : StatsmodelglmPoint, t : Double) -> StatsmodelglmPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn stats_model_glm_point_to_string(pt : StatsmodelglmPoint) -> String {
  "(" + stats_model_glm_dbl(pt.x) + ", " + stats_model_glm_dbl(pt.y) + ", " + stats_model_glm_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct StatsmodelglmSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_model_glm_make_series(vals : Array[Double], name : String) -> StatsmodelglmSeries {
  { vals, name, meta: 0 }
}

pub fn stats_model_glm_series_len(s : StatsmodelglmSeries) -> Int { s.vals.length() }

pub fn stats_model_glm_series_sum(s : StatsmodelglmSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn stats_model_glm_series_mean(s : StatsmodelglmSeries) -> Double {
  let n = stats_model_glm_series_len(s)
  if n == 0 { 0.0 } else { stats_model_glm_series_sum(s) / n.to_double() }
}

pub fn stats_model_glm_series_min(s : StatsmodelglmSeries) -> Double {
  let n = stats_model_glm_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn stats_model_glm_series_max(s : StatsmodelglmSeries) -> Double {
  let n = stats_model_glm_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn stats_model_glm_series_range(s : StatsmodelglmSeries) -> Double {
  stats_model_glm_series_max(s) - stats_model_glm_series_min(s)
}

pub fn stats_model_glm_series_var(s : StatsmodelglmSeries) -> Double {
  let n = stats_model_glm_series_len(s)
  if n == 0 { 0.0 } else {
    let m = stats_model_glm_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn stats_model_glm_series_std(s : StatsmodelglmSeries) -> Double { stats_model_glm_sqrt(stats_model_glm_series_var(s)) }

pub fn stats_model_glm_series_median(s : StatsmodelglmSeries) -> Double {
  let n = stats_model_glm_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = stats_model_glm_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn stats_model_glm_series_scale(s : StatsmodelglmSeries, f : Double) -> StatsmodelglmSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = stats_model_glm_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn stats_model_glm_series_add(a : StatsmodelglmSeries, b : StatsmodelglmSeries) -> StatsmodelglmSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = stats_model_glm_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn stats_model_glm_series_sub(a : StatsmodelglmSeries, b : StatsmodelglmSeries) -> StatsmodelglmSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = stats_model_glm_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn stats_model_glm_series_normalize(s : StatsmodelglmSeries) -> StatsmodelglmSeries {
  let mn = stats_model_glm_series_min(s)
  let mx = stats_model_glm_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = stats_model_glm_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn stats_model_glm_series_cumsum(s : StatsmodelglmSeries) -> StatsmodelglmSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = stats_model_glm_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn stats_model_glm_series_to_string(s : StatsmodelglmSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + stats_model_glm_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsmodelglmMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_model_glm_make_matrix(rows : Int, cols : Int, val : Double) -> StatsmodelglmMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_model_glm_matrix_identity(n : Int) -> StatsmodelglmMatrix {
  let m = stats_model_glm_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn stats_model_glm_matrix_get(m : StatsmodelglmMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn stats_model_glm_matrix_transpose(m : StatsmodelglmMatrix) -> StatsmodelglmMatrix {
  let result = stats_model_glm_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn stats_model_glm_matrix_add(a : StatsmodelglmMatrix, b : StatsmodelglmMatrix) -> StatsmodelglmMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = stats_model_glm_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn stats_model_glm_matrix_scale(m : StatsmodelglmMatrix, s : Double) -> StatsmodelglmMatrix {
  let result = stats_model_glm_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn stats_model_glm_matrix_multiply(a : StatsmodelglmMatrix, b : StatsmodelglmMatrix) -> StatsmodelglmMatrix {
  if a.cols != b.rows { return stats_model_glm_make_matrix(a.rows, b.cols, 0.0) }
  let result = stats_model_glm_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn stats_model_glm_matrix_trace(m : StatsmodelglmMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn stats_model_glm_matrix_det(m : StatsmodelglmMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn stats_model_glm_matrix_norm(m : StatsmodelglmMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  stats_model_glm_sqrt(sum)
}

pub fn stats_model_glm_matrix_to_string(m : StatsmodelglmMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + stats_model_glm_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct StatsmodelglmVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_model_glm_make_vector(comps : Array[Double]) -> StatsmodelglmVector {
  { comps, dim: comps.length() }
}

pub fn stats_model_glm_vector_zero(dim : Int) -> StatsmodelglmVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn stats_model_glm_vector_add(a : StatsmodelglmVector, b : StatsmodelglmVector) -> StatsmodelglmVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = stats_model_glm_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_model_glm_vector_sub(a : StatsmodelglmVector, b : StatsmodelglmVector) -> StatsmodelglmVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = stats_model_glm_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_model_glm_vector_scale(v : StatsmodelglmVector, s : Double) -> StatsmodelglmVector {
  let mut result = []
  for i in 0..<v.dim { result = stats_model_glm_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn stats_model_glm_vector_dot(a : StatsmodelglmVector, b : StatsmodelglmVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn stats_model_glm_vector_norm(v : StatsmodelglmVector) -> Double { stats_model_glm_sqrt(stats_model_glm_vector_dot(v, v)) }

pub fn stats_model_glm_vector_normalize(v : StatsmodelglmVector) -> StatsmodelglmVector {
  let n = stats_model_glm_vector_norm(v)
  if n < 0.0000001 { v } else { stats_model_glm_vector_scale(v, 1.0 / n) }
}

pub fn stats_model_glm_vector_dist(a : StatsmodelglmVector, b : StatsmodelglmVector) -> Double {
  stats_model_glm_vector_norm(stats_model_glm_vector_sub(a, b))
}

pub fn stats_model_glm_vector_to_string(v : StatsmodelglmVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + stats_model_glm_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn stats_model_glm_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn stats_model_glm_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = stats_model_glm_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn stats_model_glm_std(data : Array[Double]) -> Double { stats_model_glm_sqrt(stats_model_glm_var(data)) }

pub fn stats_model_glm_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = stats_model_glm_mean(a); let mb = stats_model_glm_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn stats_model_glm_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = stats_model_glm_std(a); let sb = stats_model_glm_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { stats_model_glm_cov(a, b) / (sa * sb) }
}

pub fn stats_model_glm_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = stats_model_glm_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn stats_model_glm_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn stats_model_glm_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn stats_model_glm_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  stats_model_glm_sqrt(stats_model_glm_mse(pred, labels))
}

pub fn stats_model_glm_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + stats_model_glm_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn stats_model_glm_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = stats_model_glm_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn stats_model_glm_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn stats_model_glm_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn stats_model_glm_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = stats_model_glm_precision(pred, labels, pos); let r = stats_model_glm_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn stats_model_glm_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn stats_model_glm_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = stats_model_glm_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn stats_model_glm_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn stats_model_glm_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn stats_model_glm_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = stats_model_glm_gcd(a, b)
    (a / g) * b
  }
}

pub fn stats_model_glm_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn stats_model_glm_fibonacci(n : Int) -> Int {
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

pub fn stats_model_glm_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = stats_model_glm_min(data); let mx = stats_model_glm_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn stats_model_glm_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = stats_model_glm_mean(data); let sd = stats_model_glm_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn stats_model_glm_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn stats_model_glm_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn stats_model_glm_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn stats_model_glm_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn stats_model_glm_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn stats_model_glm_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn stats_model_glm_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn stats_model_glm_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn stats_model_glm_dbl(x : Double) -> String {
  let i = if x >= 0.0 { stats_model_glm_int(x) } else { -stats_model_glm_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { stats_model_glm_int(f * 1000000.0) } else { stats_model_glm_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn stats_model_glm_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn stats_model_glm_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct StatsmodelglmFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_glm_frame_make(size : Int) -> StatsmodelglmFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_glm_frame_len(s : StatsmodelglmFrame) -> Int { s.size }

pub fn stats_model_glm_frame_get(s : StatsmodelglmFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_glm_frame_set(s : StatsmodelglmFrame, i : Int, v : Double) -> StatsmodelglmFrame {
  let result = stats_model_glm_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_model_glm_frame_sum(s : StatsmodelglmFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_model_glm_frame_mean(s : StatsmodelglmFrame) -> Double {
  if s.size == 0 { 0.0 } else { stats_model_glm_frame_sum(s) / s.size.to_double() }
}

pub fn stats_model_glm_frame_scale(s : StatsmodelglmFrame, f : Double) -> StatsmodelglmFrame {
  let result = stats_model_glm_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_model_glm_frame_add(a : StatsmodelglmFrame, b : StatsmodelglmFrame) -> StatsmodelglmFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_model_glm_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_model_glm_frame_copy(s : StatsmodelglmFrame) -> StatsmodelglmFrame {
  let result = stats_model_glm_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_model_glm_frame_fill(s : StatsmodelglmFrame, v : Double) -> StatsmodelglmFrame {
  let result = stats_model_glm_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_model_glm_frame_min(s : StatsmodelglmFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_glm_frame_max(s : StatsmodelglmFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_glm_frame_to_string(s : StatsmodelglmFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodelglmTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_glm_table_make(size : Int) -> StatsmodelglmTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_glm_table_len(s : StatsmodelglmTable) -> Int { s.size }

pub fn stats_model_glm_table_get(s : StatsmodelglmTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_glm_table_set(s : StatsmodelglmTable, i : Int, v : Double) -> StatsmodelglmTable {
  let result = stats_model_glm_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_model_glm_table_sum(s : StatsmodelglmTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_model_glm_table_mean(s : StatsmodelglmTable) -> Double {
  if s.size == 0 { 0.0 } else { stats_model_glm_table_sum(s) / s.size.to_double() }
}

pub fn stats_model_glm_table_scale(s : StatsmodelglmTable, f : Double) -> StatsmodelglmTable {
  let result = stats_model_glm_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_model_glm_table_add(a : StatsmodelglmTable, b : StatsmodelglmTable) -> StatsmodelglmTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_model_glm_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_model_glm_table_copy(s : StatsmodelglmTable) -> StatsmodelglmTable {
  let result = stats_model_glm_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_model_glm_table_fill(s : StatsmodelglmTable, v : Double) -> StatsmodelglmTable {
  let result = stats_model_glm_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_model_glm_table_min(s : StatsmodelglmTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_glm_table_max(s : StatsmodelglmTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_glm_table_to_string(s : StatsmodelglmTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodelglmGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_glm_graphn_make(size : Int) -> StatsmodelglmGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_glm_graphn_len(s : StatsmodelglmGraphN) -> Int { s.size }

pub fn stats_model_glm_graphn_get(s : StatsmodelglmGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_glm_graphn_set(s : StatsmodelglmGraphN, i : Int, v : Double) -> StatsmodelglmGraphN {
  let result = stats_model_glm_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_model_glm_graphn_sum(s : StatsmodelglmGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_model_glm_graphn_mean(s : StatsmodelglmGraphN) -> Double {
  if s.size == 0 { 0.0 } else { stats_model_glm_graphn_sum(s) / s.size.to_double() }
}

pub fn stats_model_glm_graphn_scale(s : StatsmodelglmGraphN, f : Double) -> StatsmodelglmGraphN {
  let result = stats_model_glm_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_model_glm_graphn_add(a : StatsmodelglmGraphN, b : StatsmodelglmGraphN) -> StatsmodelglmGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_model_glm_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_model_glm_graphn_copy(s : StatsmodelglmGraphN) -> StatsmodelglmGraphN {
  let result = stats_model_glm_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_model_glm_graphn_fill(s : StatsmodelglmGraphN, v : Double) -> StatsmodelglmGraphN {
  let result = stats_model_glm_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_model_glm_graphn_min(s : StatsmodelglmGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_glm_graphn_max(s : StatsmodelglmGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_glm_graphn_to_string(s : StatsmodelglmGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodelglmNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_glm_node_make(size : Int) -> StatsmodelglmNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_glm_node_len(s : StatsmodelglmNode) -> Int { s.size }

pub fn stats_model_glm_node_get(s : StatsmodelglmNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_glm_node_set(s : StatsmodelglmNode, i : Int, v : Double) -> StatsmodelglmNode {
  let result = stats_model_glm_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_model_glm_node_sum(s : StatsmodelglmNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_model_glm_node_mean(s : StatsmodelglmNode) -> Double {
  if s.size == 0 { 0.0 } else { stats_model_glm_node_sum(s) / s.size.to_double() }
}

pub fn stats_model_glm_node_scale(s : StatsmodelglmNode, f : Double) -> StatsmodelglmNode {
  let result = stats_model_glm_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_model_glm_node_add(a : StatsmodelglmNode, b : StatsmodelglmNode) -> StatsmodelglmNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_model_glm_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_model_glm_node_copy(s : StatsmodelglmNode) -> StatsmodelglmNode {
  let result = stats_model_glm_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_model_glm_node_fill(s : StatsmodelglmNode, v : Double) -> StatsmodelglmNode {
  let result = stats_model_glm_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_model_glm_node_min(s : StatsmodelglmNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_glm_node_max(s : StatsmodelglmNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_glm_node_to_string(s : StatsmodelglmNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodelglmEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_glm_edge_make(size : Int) -> StatsmodelglmEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_glm_edge_len(s : StatsmodelglmEdge) -> Int { s.size }

pub fn stats_model_glm_edge_get(s : StatsmodelglmEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_glm_edge_set(s : StatsmodelglmEdge, i : Int, v : Double) -> StatsmodelglmEdge {
  let result = stats_model_glm_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_model_glm_edge_sum(s : StatsmodelglmEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_model_glm_edge_mean(s : StatsmodelglmEdge) -> Double {
  if s.size == 0 { 0.0 } else { stats_model_glm_edge_sum(s) / s.size.to_double() }
}

pub fn stats_model_glm_edge_scale(s : StatsmodelglmEdge, f : Double) -> StatsmodelglmEdge {
  let result = stats_model_glm_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_model_glm_edge_add(a : StatsmodelglmEdge, b : StatsmodelglmEdge) -> StatsmodelglmEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_model_glm_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_model_glm_edge_copy(s : StatsmodelglmEdge) -> StatsmodelglmEdge {
  let result = stats_model_glm_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_model_glm_edge_fill(s : StatsmodelglmEdge, v : Double) -> StatsmodelglmEdge {
  let result = stats_model_glm_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_model_glm_edge_min(s : StatsmodelglmEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_glm_edge_max(s : StatsmodelglmEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_glm_edge_to_string(s : StatsmodelglmEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodelglmPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_glm_path_make(size : Int) -> StatsmodelglmPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_glm_path_len(s : StatsmodelglmPath) -> Int { s.size }

pub fn stats_model_glm_path_get(s : StatsmodelglmPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_glm_path_set(s : StatsmodelglmPath, i : Int, v : Double) -> StatsmodelglmPath {
  let result = stats_model_glm_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_model_glm_path_sum(s : StatsmodelglmPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_model_glm_path_mean(s : StatsmodelglmPath) -> Double {
  if s.size == 0 { 0.0 } else { stats_model_glm_path_sum(s) / s.size.to_double() }
}

pub fn stats_model_glm_path_scale(s : StatsmodelglmPath, f : Double) -> StatsmodelglmPath {
  let result = stats_model_glm_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_model_glm_path_add(a : StatsmodelglmPath, b : StatsmodelglmPath) -> StatsmodelglmPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_model_glm_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_model_glm_path_copy(s : StatsmodelglmPath) -> StatsmodelglmPath {
  let result = stats_model_glm_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_model_glm_path_fill(s : StatsmodelglmPath, v : Double) -> StatsmodelglmPath {
  let result = stats_model_glm_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_model_glm_path_min(s : StatsmodelglmPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_glm_path_max(s : StatsmodelglmPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_glm_path_to_string(s : StatsmodelglmPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodelglmCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_glm_cluster_make(size : Int) -> StatsmodelglmCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_glm_cluster_len(s : StatsmodelglmCluster) -> Int { s.size }

pub fn stats_model_glm_cluster_get(s : StatsmodelglmCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_glm_cluster_set(s : StatsmodelglmCluster, i : Int, v : Double) -> StatsmodelglmCluster {
  let result = stats_model_glm_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_model_glm_cluster_sum(s : StatsmodelglmCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_model_glm_cluster_mean(s : StatsmodelglmCluster) -> Double {
  if s.size == 0 { 0.0 } else { stats_model_glm_cluster_sum(s) / s.size.to_double() }
}

pub fn stats_model_glm_cluster_scale(s : StatsmodelglmCluster, f : Double) -> StatsmodelglmCluster {
  let result = stats_model_glm_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_model_glm_cluster_add(a : StatsmodelglmCluster, b : StatsmodelglmCluster) -> StatsmodelglmCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_model_glm_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_model_glm_cluster_copy(s : StatsmodelglmCluster) -> StatsmodelglmCluster {
  let result = stats_model_glm_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_model_glm_cluster_fill(s : StatsmodelglmCluster, v : Double) -> StatsmodelglmCluster {
  let result = stats_model_glm_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_model_glm_cluster_min(s : StatsmodelglmCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_glm_cluster_max(s : StatsmodelglmCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_glm_cluster_to_string(s : StatsmodelglmCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodelglmModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_glm_model_make(size : Int) -> StatsmodelglmModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_glm_model_len(s : StatsmodelglmModel) -> Int { s.size }

pub fn stats_model_glm_model_get(s : StatsmodelglmModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_glm_model_set(s : StatsmodelglmModel, i : Int, v : Double) -> StatsmodelglmModel {
  let result = stats_model_glm_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_model_glm_model_sum(s : StatsmodelglmModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_model_glm_model_mean(s : StatsmodelglmModel) -> Double {
  if s.size == 0 { 0.0 } else { stats_model_glm_model_sum(s) / s.size.to_double() }
}

pub fn stats_model_glm_model_scale(s : StatsmodelglmModel, f : Double) -> StatsmodelglmModel {
  let result = stats_model_glm_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_model_glm_model_add(a : StatsmodelglmModel, b : StatsmodelglmModel) -> StatsmodelglmModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_model_glm_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_model_glm_model_copy(s : StatsmodelglmModel) -> StatsmodelglmModel {
  let result = stats_model_glm_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_model_glm_model_fill(s : StatsmodelglmModel, v : Double) -> StatsmodelglmModel {
  let result = stats_model_glm_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_model_glm_model_min(s : StatsmodelglmModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_glm_model_max(s : StatsmodelglmModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_glm_model_to_string(s : StatsmodelglmModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodelglmLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_glm_layer_make(size : Int) -> StatsmodelglmLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_glm_layer_len(s : StatsmodelglmLayer) -> Int { s.size }

pub fn stats_model_glm_layer_get(s : StatsmodelglmLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_glm_layer_set(s : StatsmodelglmLayer, i : Int, v : Double) -> StatsmodelglmLayer {
  let result = stats_model_glm_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_model_glm_layer_sum(s : StatsmodelglmLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_model_glm_layer_mean(s : StatsmodelglmLayer) -> Double {
  if s.size == 0 { 0.0 } else { stats_model_glm_layer_sum(s) / s.size.to_double() }
}

pub fn stats_model_glm_layer_scale(s : StatsmodelglmLayer, f : Double) -> StatsmodelglmLayer {
  let result = stats_model_glm_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_model_glm_layer_add(a : StatsmodelglmLayer, b : StatsmodelglmLayer) -> StatsmodelglmLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_model_glm_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_model_glm_layer_copy(s : StatsmodelglmLayer) -> StatsmodelglmLayer {
  let result = stats_model_glm_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_model_glm_layer_fill(s : StatsmodelglmLayer, v : Double) -> StatsmodelglmLayer {
  let result = stats_model_glm_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_model_glm_layer_min(s : StatsmodelglmLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_glm_layer_max(s : StatsmodelglmLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_glm_layer_to_string(s : StatsmodelglmLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodelglmBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_glm_buffer_make(size : Int) -> StatsmodelglmBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_glm_buffer_len(s : StatsmodelglmBuffer) -> Int { s.size }

pub fn stats_model_glm_buffer_get(s : StatsmodelglmBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_glm_buffer_set(s : StatsmodelglmBuffer, i : Int, v : Double) -> StatsmodelglmBuffer {
  let result = stats_model_glm_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_model_glm_buffer_sum(s : StatsmodelglmBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_model_glm_buffer_mean(s : StatsmodelglmBuffer) -> Double {
  if s.size == 0 { 0.0 } else { stats_model_glm_buffer_sum(s) / s.size.to_double() }
}

pub fn stats_model_glm_buffer_scale(s : StatsmodelglmBuffer, f : Double) -> StatsmodelglmBuffer {
  let result = stats_model_glm_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_model_glm_buffer_add(a : StatsmodelglmBuffer, b : StatsmodelglmBuffer) -> StatsmodelglmBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_model_glm_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_model_glm_buffer_copy(s : StatsmodelglmBuffer) -> StatsmodelglmBuffer {
  let result = stats_model_glm_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_model_glm_buffer_fill(s : StatsmodelglmBuffer, v : Double) -> StatsmodelglmBuffer {
  let result = stats_model_glm_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_model_glm_buffer_min(s : StatsmodelglmBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_glm_buffer_max(s : StatsmodelglmBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_glm_buffer_to_string(s : StatsmodelglmBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodelglmCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_glm_cursor_make(size : Int) -> StatsmodelglmCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_glm_cursor_len(s : StatsmodelglmCursor) -> Int { s.size }

pub fn stats_model_glm_cursor_get(s : StatsmodelglmCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_glm_cursor_set(s : StatsmodelglmCursor, i : Int, v : Double) -> StatsmodelglmCursor {
  let result = stats_model_glm_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_model_glm_cursor_sum(s : StatsmodelglmCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_model_glm_cursor_mean(s : StatsmodelglmCursor) -> Double {
  if s.size == 0 { 0.0 } else { stats_model_glm_cursor_sum(s) / s.size.to_double() }
}

pub fn stats_model_glm_cursor_scale(s : StatsmodelglmCursor, f : Double) -> StatsmodelglmCursor {
  let result = stats_model_glm_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_model_glm_cursor_add(a : StatsmodelglmCursor, b : StatsmodelglmCursor) -> StatsmodelglmCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_model_glm_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_model_glm_cursor_copy(s : StatsmodelglmCursor) -> StatsmodelglmCursor {
  let result = stats_model_glm_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_model_glm_cursor_fill(s : StatsmodelglmCursor, v : Double) -> StatsmodelglmCursor {
  let result = stats_model_glm_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_model_glm_cursor_min(s : StatsmodelglmCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_glm_cursor_max(s : StatsmodelglmCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_glm_cursor_to_string(s : StatsmodelglmCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodelglmView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_glm_view_make(size : Int) -> StatsmodelglmView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_glm_view_len(s : StatsmodelglmView) -> Int { s.size }

pub fn stats_model_glm_view_get(s : StatsmodelglmView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_glm_view_set(s : StatsmodelglmView, i : Int, v : Double) -> StatsmodelglmView {
  let result = stats_model_glm_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_model_glm_view_sum(s : StatsmodelglmView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_model_glm_view_mean(s : StatsmodelglmView) -> Double {
  if s.size == 0 { 0.0 } else { stats_model_glm_view_sum(s) / s.size.to_double() }
}

pub fn stats_model_glm_view_scale(s : StatsmodelglmView, f : Double) -> StatsmodelglmView {
  let result = stats_model_glm_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_model_glm_view_add(a : StatsmodelglmView, b : StatsmodelglmView) -> StatsmodelglmView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_model_glm_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_model_glm_view_copy(s : StatsmodelglmView) -> StatsmodelglmView {
  let result = stats_model_glm_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_model_glm_view_fill(s : StatsmodelglmView, v : Double) -> StatsmodelglmView {
  let result = stats_model_glm_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_model_glm_view_min(s : StatsmodelglmView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_glm_view_max(s : StatsmodelglmView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_glm_view_to_string(s : StatsmodelglmView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodelglmRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_glm_range_make(size : Int) -> StatsmodelglmRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_glm_range_len(s : StatsmodelglmRange) -> Int { s.size }

pub fn stats_model_glm_range_get(s : StatsmodelglmRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_glm_range_set(s : StatsmodelglmRange, i : Int, v : Double) -> StatsmodelglmRange {
  let result = stats_model_glm_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_model_glm_range_sum(s : StatsmodelglmRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_model_glm_range_mean(s : StatsmodelglmRange) -> Double {
  if s.size == 0 { 0.0 } else { stats_model_glm_range_sum(s) / s.size.to_double() }
}

pub fn stats_model_glm_range_scale(s : StatsmodelglmRange, f : Double) -> StatsmodelglmRange {
  let result = stats_model_glm_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_model_glm_range_add(a : StatsmodelglmRange, b : StatsmodelglmRange) -> StatsmodelglmRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_model_glm_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_model_glm_range_copy(s : StatsmodelglmRange) -> StatsmodelglmRange {
  let result = stats_model_glm_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_model_glm_range_fill(s : StatsmodelglmRange, v : Double) -> StatsmodelglmRange {
  let result = stats_model_glm_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_model_glm_range_min(s : StatsmodelglmRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_glm_range_max(s : StatsmodelglmRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_glm_range_to_string(s : StatsmodelglmRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodelglmSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_glm_slice_make(size : Int) -> StatsmodelglmSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_glm_slice_len(s : StatsmodelglmSlice) -> Int { s.size }

pub fn stats_model_glm_slice_get(s : StatsmodelglmSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_glm_slice_set(s : StatsmodelglmSlice, i : Int, v : Double) -> StatsmodelglmSlice {
  let result = stats_model_glm_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_model_glm_slice_sum(s : StatsmodelglmSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_model_glm_slice_mean(s : StatsmodelglmSlice) -> Double {
  if s.size == 0 { 0.0 } else { stats_model_glm_slice_sum(s) / s.size.to_double() }
}

pub fn stats_model_glm_slice_scale(s : StatsmodelglmSlice, f : Double) -> StatsmodelglmSlice {
  let result = stats_model_glm_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_model_glm_slice_add(a : StatsmodelglmSlice, b : StatsmodelglmSlice) -> StatsmodelglmSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_model_glm_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_model_glm_slice_copy(s : StatsmodelglmSlice) -> StatsmodelglmSlice {
  let result = stats_model_glm_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_model_glm_slice_fill(s : StatsmodelglmSlice, v : Double) -> StatsmodelglmSlice {
  let result = stats_model_glm_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_model_glm_slice_min(s : StatsmodelglmSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_glm_slice_max(s : StatsmodelglmSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_glm_slice_to_string(s : StatsmodelglmSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn stats_model_glm_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_model_glm_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_model_glm_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_model_glm_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_model_glm_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_model_glm_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_model_glm_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_model_glm_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_model_glm_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_model_glm_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_model_glm_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_model_glm_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_model_glm_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_model_glm_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_model_glm_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_model_glm_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_model_glm_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_model_glm_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_model_glm_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_model_glm_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_model_glm_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_model_glm_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_model_glm_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_model_glm_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_model_glm_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}


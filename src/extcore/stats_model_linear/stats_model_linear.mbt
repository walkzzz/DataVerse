///===
/// extcore/stats_model_linear

pub(all) struct StatsmodellinearPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_model_linear_make_point(x : Double, y : Double) -> StatsmodellinearPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_model_linear_make_point3(x : Double, y : Double, z : Double) -> StatsmodellinearPoint {
  { x, y, z, label: 0 }
}

pub fn stats_model_linear_point_x(pt : StatsmodellinearPoint) -> Double { pt.x }

pub fn stats_model_linear_point_y(pt : StatsmodellinearPoint) -> Double { pt.y }

pub fn stats_model_linear_point_z(pt : StatsmodellinearPoint) -> Double { pt.z }

pub fn stats_model_linear_point_label(pt : StatsmodellinearPoint) -> Int { pt.label }

pub fn stats_model_linear_point_dist(a : StatsmodellinearPoint, b : StatsmodellinearPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  stats_model_linear_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn stats_model_linear_point_add(a : StatsmodellinearPoint, b : StatsmodellinearPoint) -> StatsmodellinearPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn stats_model_linear_point_sub(a : StatsmodellinearPoint, b : StatsmodellinearPoint) -> StatsmodellinearPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn stats_model_linear_point_scale(pt : StatsmodellinearPoint, s : Double) -> StatsmodellinearPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn stats_model_linear_point_dot(a : StatsmodellinearPoint, b : StatsmodellinearPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn stats_model_linear_point_cross(a : StatsmodellinearPoint, b : StatsmodellinearPoint) -> StatsmodellinearPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn stats_model_linear_point_norm(pt : StatsmodellinearPoint) -> Double {
  stats_model_linear_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn stats_model_linear_point_normalize(pt : StatsmodellinearPoint) -> StatsmodellinearPoint {
  let n = stats_model_linear_point_norm(pt)
  if n < 0.0000001 { pt } else { stats_model_linear_point_scale(pt, 1.0 / n) }
}

pub fn stats_model_linear_point_negate(pt : StatsmodellinearPoint) -> StatsmodellinearPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn stats_model_linear_point_mid(a : StatsmodellinearPoint, b : StatsmodellinearPoint) -> StatsmodellinearPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn stats_model_linear_point_lerp(a : StatsmodellinearPoint, b : StatsmodellinearPoint, t : Double) -> StatsmodellinearPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn stats_model_linear_point_to_string(pt : StatsmodellinearPoint) -> String {
  "(" + stats_model_linear_dbl(pt.x) + ", " + stats_model_linear_dbl(pt.y) + ", " + stats_model_linear_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct StatsmodellinearSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_model_linear_make_series(vals : Array[Double], name : String) -> StatsmodellinearSeries {
  { vals, name, meta: 0 }
}

pub fn stats_model_linear_series_len(s : StatsmodellinearSeries) -> Int { s.vals.length() }

pub fn stats_model_linear_series_sum(s : StatsmodellinearSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn stats_model_linear_series_mean(s : StatsmodellinearSeries) -> Double {
  let n = stats_model_linear_series_len(s)
  if n == 0 { 0.0 } else { stats_model_linear_series_sum(s) / n.to_double() }
}

pub fn stats_model_linear_series_min(s : StatsmodellinearSeries) -> Double {
  let n = stats_model_linear_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn stats_model_linear_series_max(s : StatsmodellinearSeries) -> Double {
  let n = stats_model_linear_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn stats_model_linear_series_range(s : StatsmodellinearSeries) -> Double {
  stats_model_linear_series_max(s) - stats_model_linear_series_min(s)
}

pub fn stats_model_linear_series_var(s : StatsmodellinearSeries) -> Double {
  let n = stats_model_linear_series_len(s)
  if n == 0 { 0.0 } else {
    let m = stats_model_linear_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn stats_model_linear_series_std(s : StatsmodellinearSeries) -> Double { stats_model_linear_sqrt(stats_model_linear_series_var(s)) }

pub fn stats_model_linear_series_median(s : StatsmodellinearSeries) -> Double {
  let n = stats_model_linear_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = stats_model_linear_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn stats_model_linear_series_scale(s : StatsmodellinearSeries, f : Double) -> StatsmodellinearSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = stats_model_linear_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn stats_model_linear_series_add(a : StatsmodellinearSeries, b : StatsmodellinearSeries) -> StatsmodellinearSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = stats_model_linear_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn stats_model_linear_series_sub(a : StatsmodellinearSeries, b : StatsmodellinearSeries) -> StatsmodellinearSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = stats_model_linear_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn stats_model_linear_series_normalize(s : StatsmodellinearSeries) -> StatsmodellinearSeries {
  let mn = stats_model_linear_series_min(s)
  let mx = stats_model_linear_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = stats_model_linear_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn stats_model_linear_series_cumsum(s : StatsmodellinearSeries) -> StatsmodellinearSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = stats_model_linear_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn stats_model_linear_series_to_string(s : StatsmodellinearSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + stats_model_linear_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsmodellinearMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_model_linear_make_matrix(rows : Int, cols : Int, val : Double) -> StatsmodellinearMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_model_linear_matrix_identity(n : Int) -> StatsmodellinearMatrix {
  let m = stats_model_linear_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn stats_model_linear_matrix_get(m : StatsmodellinearMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn stats_model_linear_matrix_transpose(m : StatsmodellinearMatrix) -> StatsmodellinearMatrix {
  let result = stats_model_linear_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn stats_model_linear_matrix_add(a : StatsmodellinearMatrix, b : StatsmodellinearMatrix) -> StatsmodellinearMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = stats_model_linear_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn stats_model_linear_matrix_scale(m : StatsmodellinearMatrix, s : Double) -> StatsmodellinearMatrix {
  let result = stats_model_linear_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn stats_model_linear_matrix_multiply(a : StatsmodellinearMatrix, b : StatsmodellinearMatrix) -> StatsmodellinearMatrix {
  if a.cols != b.rows { return stats_model_linear_make_matrix(a.rows, b.cols, 0.0) }
  let result = stats_model_linear_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn stats_model_linear_matrix_trace(m : StatsmodellinearMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn stats_model_linear_matrix_det(m : StatsmodellinearMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn stats_model_linear_matrix_norm(m : StatsmodellinearMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  stats_model_linear_sqrt(sum)
}

pub fn stats_model_linear_matrix_to_string(m : StatsmodellinearMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + stats_model_linear_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct StatsmodellinearVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_model_linear_make_vector(comps : Array[Double]) -> StatsmodellinearVector {
  { comps, dim: comps.length() }
}

pub fn stats_model_linear_vector_zero(dim : Int) -> StatsmodellinearVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn stats_model_linear_vector_add(a : StatsmodellinearVector, b : StatsmodellinearVector) -> StatsmodellinearVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = stats_model_linear_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_model_linear_vector_sub(a : StatsmodellinearVector, b : StatsmodellinearVector) -> StatsmodellinearVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = stats_model_linear_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_model_linear_vector_scale(v : StatsmodellinearVector, s : Double) -> StatsmodellinearVector {
  let mut result = []
  for i in 0..<v.dim { result = stats_model_linear_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn stats_model_linear_vector_dot(a : StatsmodellinearVector, b : StatsmodellinearVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn stats_model_linear_vector_norm(v : StatsmodellinearVector) -> Double { stats_model_linear_sqrt(stats_model_linear_vector_dot(v, v)) }

pub fn stats_model_linear_vector_normalize(v : StatsmodellinearVector) -> StatsmodellinearVector {
  let n = stats_model_linear_vector_norm(v)
  if n < 0.0000001 { v } else { stats_model_linear_vector_scale(v, 1.0 / n) }
}

pub fn stats_model_linear_vector_dist(a : StatsmodellinearVector, b : StatsmodellinearVector) -> Double {
  stats_model_linear_vector_norm(stats_model_linear_vector_sub(a, b))
}

pub fn stats_model_linear_vector_to_string(v : StatsmodellinearVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + stats_model_linear_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn stats_model_linear_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn stats_model_linear_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = stats_model_linear_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn stats_model_linear_std(data : Array[Double]) -> Double { stats_model_linear_sqrt(stats_model_linear_var(data)) }

pub fn stats_model_linear_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = stats_model_linear_mean(a); let mb = stats_model_linear_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn stats_model_linear_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = stats_model_linear_std(a); let sb = stats_model_linear_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { stats_model_linear_cov(a, b) / (sa * sb) }
}

pub fn stats_model_linear_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = stats_model_linear_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn stats_model_linear_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn stats_model_linear_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn stats_model_linear_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  stats_model_linear_sqrt(stats_model_linear_mse(pred, labels))
}

pub fn stats_model_linear_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + stats_model_linear_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn stats_model_linear_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = stats_model_linear_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn stats_model_linear_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn stats_model_linear_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn stats_model_linear_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = stats_model_linear_precision(pred, labels, pos); let r = stats_model_linear_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn stats_model_linear_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn stats_model_linear_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = stats_model_linear_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn stats_model_linear_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn stats_model_linear_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn stats_model_linear_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = stats_model_linear_gcd(a, b)
    (a / g) * b
  }
}

pub fn stats_model_linear_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn stats_model_linear_fibonacci(n : Int) -> Int {
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

pub fn stats_model_linear_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = stats_model_linear_min(data); let mx = stats_model_linear_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn stats_model_linear_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = stats_model_linear_mean(data); let sd = stats_model_linear_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn stats_model_linear_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn stats_model_linear_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn stats_model_linear_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn stats_model_linear_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn stats_model_linear_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn stats_model_linear_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn stats_model_linear_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn stats_model_linear_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn stats_model_linear_dbl(x : Double) -> String {
  let i = if x >= 0.0 { stats_model_linear_int(x) } else { -stats_model_linear_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { stats_model_linear_int(f * 1000000.0) } else { stats_model_linear_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn stats_model_linear_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn stats_model_linear_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct StatsmodellinearFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_linear_frame_make(size : Int) -> StatsmodellinearFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_linear_frame_len(s : StatsmodellinearFrame) -> Int { s.size }

pub fn stats_model_linear_frame_get(s : StatsmodellinearFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_linear_frame_set(s : StatsmodellinearFrame, i : Int, v : Double) -> StatsmodellinearFrame {
  let result = stats_model_linear_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_model_linear_frame_sum(s : StatsmodellinearFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_model_linear_frame_mean(s : StatsmodellinearFrame) -> Double {
  if s.size == 0 { 0.0 } else { stats_model_linear_frame_sum(s) / s.size.to_double() }
}

pub fn stats_model_linear_frame_scale(s : StatsmodellinearFrame, f : Double) -> StatsmodellinearFrame {
  let result = stats_model_linear_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_model_linear_frame_add(a : StatsmodellinearFrame, b : StatsmodellinearFrame) -> StatsmodellinearFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_model_linear_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_model_linear_frame_copy(s : StatsmodellinearFrame) -> StatsmodellinearFrame {
  let result = stats_model_linear_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_model_linear_frame_fill(s : StatsmodellinearFrame, v : Double) -> StatsmodellinearFrame {
  let result = stats_model_linear_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_model_linear_frame_min(s : StatsmodellinearFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_linear_frame_max(s : StatsmodellinearFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_linear_frame_to_string(s : StatsmodellinearFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodellinearTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_linear_table_make(size : Int) -> StatsmodellinearTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_linear_table_len(s : StatsmodellinearTable) -> Int { s.size }

pub fn stats_model_linear_table_get(s : StatsmodellinearTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_linear_table_set(s : StatsmodellinearTable, i : Int, v : Double) -> StatsmodellinearTable {
  let result = stats_model_linear_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_model_linear_table_sum(s : StatsmodellinearTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_model_linear_table_mean(s : StatsmodellinearTable) -> Double {
  if s.size == 0 { 0.0 } else { stats_model_linear_table_sum(s) / s.size.to_double() }
}

pub fn stats_model_linear_table_scale(s : StatsmodellinearTable, f : Double) -> StatsmodellinearTable {
  let result = stats_model_linear_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_model_linear_table_add(a : StatsmodellinearTable, b : StatsmodellinearTable) -> StatsmodellinearTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_model_linear_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_model_linear_table_copy(s : StatsmodellinearTable) -> StatsmodellinearTable {
  let result = stats_model_linear_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_model_linear_table_fill(s : StatsmodellinearTable, v : Double) -> StatsmodellinearTable {
  let result = stats_model_linear_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_model_linear_table_min(s : StatsmodellinearTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_linear_table_max(s : StatsmodellinearTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_linear_table_to_string(s : StatsmodellinearTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodellinearGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_linear_graphn_make(size : Int) -> StatsmodellinearGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_linear_graphn_len(s : StatsmodellinearGraphN) -> Int { s.size }

pub fn stats_model_linear_graphn_get(s : StatsmodellinearGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_linear_graphn_set(s : StatsmodellinearGraphN, i : Int, v : Double) -> StatsmodellinearGraphN {
  let result = stats_model_linear_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_model_linear_graphn_sum(s : StatsmodellinearGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_model_linear_graphn_mean(s : StatsmodellinearGraphN) -> Double {
  if s.size == 0 { 0.0 } else { stats_model_linear_graphn_sum(s) / s.size.to_double() }
}

pub fn stats_model_linear_graphn_scale(s : StatsmodellinearGraphN, f : Double) -> StatsmodellinearGraphN {
  let result = stats_model_linear_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_model_linear_graphn_add(a : StatsmodellinearGraphN, b : StatsmodellinearGraphN) -> StatsmodellinearGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_model_linear_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_model_linear_graphn_copy(s : StatsmodellinearGraphN) -> StatsmodellinearGraphN {
  let result = stats_model_linear_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_model_linear_graphn_fill(s : StatsmodellinearGraphN, v : Double) -> StatsmodellinearGraphN {
  let result = stats_model_linear_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_model_linear_graphn_min(s : StatsmodellinearGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_linear_graphn_max(s : StatsmodellinearGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_linear_graphn_to_string(s : StatsmodellinearGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodellinearNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_linear_node_make(size : Int) -> StatsmodellinearNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_linear_node_len(s : StatsmodellinearNode) -> Int { s.size }

pub fn stats_model_linear_node_get(s : StatsmodellinearNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_linear_node_set(s : StatsmodellinearNode, i : Int, v : Double) -> StatsmodellinearNode {
  let result = stats_model_linear_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_model_linear_node_sum(s : StatsmodellinearNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_model_linear_node_mean(s : StatsmodellinearNode) -> Double {
  if s.size == 0 { 0.0 } else { stats_model_linear_node_sum(s) / s.size.to_double() }
}

pub fn stats_model_linear_node_scale(s : StatsmodellinearNode, f : Double) -> StatsmodellinearNode {
  let result = stats_model_linear_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_model_linear_node_add(a : StatsmodellinearNode, b : StatsmodellinearNode) -> StatsmodellinearNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_model_linear_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_model_linear_node_copy(s : StatsmodellinearNode) -> StatsmodellinearNode {
  let result = stats_model_linear_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_model_linear_node_fill(s : StatsmodellinearNode, v : Double) -> StatsmodellinearNode {
  let result = stats_model_linear_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_model_linear_node_min(s : StatsmodellinearNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_linear_node_max(s : StatsmodellinearNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_linear_node_to_string(s : StatsmodellinearNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodellinearEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_linear_edge_make(size : Int) -> StatsmodellinearEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_linear_edge_len(s : StatsmodellinearEdge) -> Int { s.size }

pub fn stats_model_linear_edge_get(s : StatsmodellinearEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_linear_edge_set(s : StatsmodellinearEdge, i : Int, v : Double) -> StatsmodellinearEdge {
  let result = stats_model_linear_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_model_linear_edge_sum(s : StatsmodellinearEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_model_linear_edge_mean(s : StatsmodellinearEdge) -> Double {
  if s.size == 0 { 0.0 } else { stats_model_linear_edge_sum(s) / s.size.to_double() }
}

pub fn stats_model_linear_edge_scale(s : StatsmodellinearEdge, f : Double) -> StatsmodellinearEdge {
  let result = stats_model_linear_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_model_linear_edge_add(a : StatsmodellinearEdge, b : StatsmodellinearEdge) -> StatsmodellinearEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_model_linear_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_model_linear_edge_copy(s : StatsmodellinearEdge) -> StatsmodellinearEdge {
  let result = stats_model_linear_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_model_linear_edge_fill(s : StatsmodellinearEdge, v : Double) -> StatsmodellinearEdge {
  let result = stats_model_linear_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_model_linear_edge_min(s : StatsmodellinearEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_linear_edge_max(s : StatsmodellinearEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_linear_edge_to_string(s : StatsmodellinearEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodellinearPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_linear_path_make(size : Int) -> StatsmodellinearPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_linear_path_len(s : StatsmodellinearPath) -> Int { s.size }

pub fn stats_model_linear_path_get(s : StatsmodellinearPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_linear_path_set(s : StatsmodellinearPath, i : Int, v : Double) -> StatsmodellinearPath {
  let result = stats_model_linear_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_model_linear_path_sum(s : StatsmodellinearPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_model_linear_path_mean(s : StatsmodellinearPath) -> Double {
  if s.size == 0 { 0.0 } else { stats_model_linear_path_sum(s) / s.size.to_double() }
}

pub fn stats_model_linear_path_scale(s : StatsmodellinearPath, f : Double) -> StatsmodellinearPath {
  let result = stats_model_linear_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_model_linear_path_add(a : StatsmodellinearPath, b : StatsmodellinearPath) -> StatsmodellinearPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_model_linear_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_model_linear_path_copy(s : StatsmodellinearPath) -> StatsmodellinearPath {
  let result = stats_model_linear_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_model_linear_path_fill(s : StatsmodellinearPath, v : Double) -> StatsmodellinearPath {
  let result = stats_model_linear_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_model_linear_path_min(s : StatsmodellinearPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_linear_path_max(s : StatsmodellinearPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_linear_path_to_string(s : StatsmodellinearPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodellinearCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_linear_cluster_make(size : Int) -> StatsmodellinearCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_linear_cluster_len(s : StatsmodellinearCluster) -> Int { s.size }

pub fn stats_model_linear_cluster_get(s : StatsmodellinearCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_linear_cluster_set(s : StatsmodellinearCluster, i : Int, v : Double) -> StatsmodellinearCluster {
  let result = stats_model_linear_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_model_linear_cluster_sum(s : StatsmodellinearCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_model_linear_cluster_mean(s : StatsmodellinearCluster) -> Double {
  if s.size == 0 { 0.0 } else { stats_model_linear_cluster_sum(s) / s.size.to_double() }
}

pub fn stats_model_linear_cluster_scale(s : StatsmodellinearCluster, f : Double) -> StatsmodellinearCluster {
  let result = stats_model_linear_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_model_linear_cluster_add(a : StatsmodellinearCluster, b : StatsmodellinearCluster) -> StatsmodellinearCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_model_linear_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_model_linear_cluster_copy(s : StatsmodellinearCluster) -> StatsmodellinearCluster {
  let result = stats_model_linear_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_model_linear_cluster_fill(s : StatsmodellinearCluster, v : Double) -> StatsmodellinearCluster {
  let result = stats_model_linear_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_model_linear_cluster_min(s : StatsmodellinearCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_linear_cluster_max(s : StatsmodellinearCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_linear_cluster_to_string(s : StatsmodellinearCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodellinearModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_linear_model_make(size : Int) -> StatsmodellinearModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_linear_model_len(s : StatsmodellinearModel) -> Int { s.size }

pub fn stats_model_linear_model_get(s : StatsmodellinearModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_linear_model_set(s : StatsmodellinearModel, i : Int, v : Double) -> StatsmodellinearModel {
  let result = stats_model_linear_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_model_linear_model_sum(s : StatsmodellinearModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_model_linear_model_mean(s : StatsmodellinearModel) -> Double {
  if s.size == 0 { 0.0 } else { stats_model_linear_model_sum(s) / s.size.to_double() }
}

pub fn stats_model_linear_model_scale(s : StatsmodellinearModel, f : Double) -> StatsmodellinearModel {
  let result = stats_model_linear_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_model_linear_model_add(a : StatsmodellinearModel, b : StatsmodellinearModel) -> StatsmodellinearModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_model_linear_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_model_linear_model_copy(s : StatsmodellinearModel) -> StatsmodellinearModel {
  let result = stats_model_linear_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_model_linear_model_fill(s : StatsmodellinearModel, v : Double) -> StatsmodellinearModel {
  let result = stats_model_linear_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_model_linear_model_min(s : StatsmodellinearModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_linear_model_max(s : StatsmodellinearModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_linear_model_to_string(s : StatsmodellinearModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodellinearLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_linear_layer_make(size : Int) -> StatsmodellinearLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_linear_layer_len(s : StatsmodellinearLayer) -> Int { s.size }

pub fn stats_model_linear_layer_get(s : StatsmodellinearLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_linear_layer_set(s : StatsmodellinearLayer, i : Int, v : Double) -> StatsmodellinearLayer {
  let result = stats_model_linear_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_model_linear_layer_sum(s : StatsmodellinearLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_model_linear_layer_mean(s : StatsmodellinearLayer) -> Double {
  if s.size == 0 { 0.0 } else { stats_model_linear_layer_sum(s) / s.size.to_double() }
}

pub fn stats_model_linear_layer_scale(s : StatsmodellinearLayer, f : Double) -> StatsmodellinearLayer {
  let result = stats_model_linear_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_model_linear_layer_add(a : StatsmodellinearLayer, b : StatsmodellinearLayer) -> StatsmodellinearLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_model_linear_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_model_linear_layer_copy(s : StatsmodellinearLayer) -> StatsmodellinearLayer {
  let result = stats_model_linear_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_model_linear_layer_fill(s : StatsmodellinearLayer, v : Double) -> StatsmodellinearLayer {
  let result = stats_model_linear_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_model_linear_layer_min(s : StatsmodellinearLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_linear_layer_max(s : StatsmodellinearLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_linear_layer_to_string(s : StatsmodellinearLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodellinearBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_linear_buffer_make(size : Int) -> StatsmodellinearBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_linear_buffer_len(s : StatsmodellinearBuffer) -> Int { s.size }

pub fn stats_model_linear_buffer_get(s : StatsmodellinearBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_linear_buffer_set(s : StatsmodellinearBuffer, i : Int, v : Double) -> StatsmodellinearBuffer {
  let result = stats_model_linear_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_model_linear_buffer_sum(s : StatsmodellinearBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_model_linear_buffer_mean(s : StatsmodellinearBuffer) -> Double {
  if s.size == 0 { 0.0 } else { stats_model_linear_buffer_sum(s) / s.size.to_double() }
}

pub fn stats_model_linear_buffer_scale(s : StatsmodellinearBuffer, f : Double) -> StatsmodellinearBuffer {
  let result = stats_model_linear_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_model_linear_buffer_add(a : StatsmodellinearBuffer, b : StatsmodellinearBuffer) -> StatsmodellinearBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_model_linear_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_model_linear_buffer_copy(s : StatsmodellinearBuffer) -> StatsmodellinearBuffer {
  let result = stats_model_linear_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_model_linear_buffer_fill(s : StatsmodellinearBuffer, v : Double) -> StatsmodellinearBuffer {
  let result = stats_model_linear_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_model_linear_buffer_min(s : StatsmodellinearBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_linear_buffer_max(s : StatsmodellinearBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_linear_buffer_to_string(s : StatsmodellinearBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodellinearCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_linear_cursor_make(size : Int) -> StatsmodellinearCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_linear_cursor_len(s : StatsmodellinearCursor) -> Int { s.size }

pub fn stats_model_linear_cursor_get(s : StatsmodellinearCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_linear_cursor_set(s : StatsmodellinearCursor, i : Int, v : Double) -> StatsmodellinearCursor {
  let result = stats_model_linear_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_model_linear_cursor_sum(s : StatsmodellinearCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_model_linear_cursor_mean(s : StatsmodellinearCursor) -> Double {
  if s.size == 0 { 0.0 } else { stats_model_linear_cursor_sum(s) / s.size.to_double() }
}

pub fn stats_model_linear_cursor_scale(s : StatsmodellinearCursor, f : Double) -> StatsmodellinearCursor {
  let result = stats_model_linear_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_model_linear_cursor_add(a : StatsmodellinearCursor, b : StatsmodellinearCursor) -> StatsmodellinearCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_model_linear_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_model_linear_cursor_copy(s : StatsmodellinearCursor) -> StatsmodellinearCursor {
  let result = stats_model_linear_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_model_linear_cursor_fill(s : StatsmodellinearCursor, v : Double) -> StatsmodellinearCursor {
  let result = stats_model_linear_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_model_linear_cursor_min(s : StatsmodellinearCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_linear_cursor_max(s : StatsmodellinearCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_linear_cursor_to_string(s : StatsmodellinearCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodellinearView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_linear_view_make(size : Int) -> StatsmodellinearView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_linear_view_len(s : StatsmodellinearView) -> Int { s.size }

pub fn stats_model_linear_view_get(s : StatsmodellinearView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_linear_view_set(s : StatsmodellinearView, i : Int, v : Double) -> StatsmodellinearView {
  let result = stats_model_linear_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_model_linear_view_sum(s : StatsmodellinearView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_model_linear_view_mean(s : StatsmodellinearView) -> Double {
  if s.size == 0 { 0.0 } else { stats_model_linear_view_sum(s) / s.size.to_double() }
}

pub fn stats_model_linear_view_scale(s : StatsmodellinearView, f : Double) -> StatsmodellinearView {
  let result = stats_model_linear_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_model_linear_view_add(a : StatsmodellinearView, b : StatsmodellinearView) -> StatsmodellinearView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_model_linear_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_model_linear_view_copy(s : StatsmodellinearView) -> StatsmodellinearView {
  let result = stats_model_linear_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_model_linear_view_fill(s : StatsmodellinearView, v : Double) -> StatsmodellinearView {
  let result = stats_model_linear_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_model_linear_view_min(s : StatsmodellinearView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_linear_view_max(s : StatsmodellinearView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_linear_view_to_string(s : StatsmodellinearView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodellinearRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_linear_range_make(size : Int) -> StatsmodellinearRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_linear_range_len(s : StatsmodellinearRange) -> Int { s.size }

pub fn stats_model_linear_range_get(s : StatsmodellinearRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_linear_range_set(s : StatsmodellinearRange, i : Int, v : Double) -> StatsmodellinearRange {
  let result = stats_model_linear_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_model_linear_range_sum(s : StatsmodellinearRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_model_linear_range_mean(s : StatsmodellinearRange) -> Double {
  if s.size == 0 { 0.0 } else { stats_model_linear_range_sum(s) / s.size.to_double() }
}

pub fn stats_model_linear_range_scale(s : StatsmodellinearRange, f : Double) -> StatsmodellinearRange {
  let result = stats_model_linear_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_model_linear_range_add(a : StatsmodellinearRange, b : StatsmodellinearRange) -> StatsmodellinearRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_model_linear_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_model_linear_range_copy(s : StatsmodellinearRange) -> StatsmodellinearRange {
  let result = stats_model_linear_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_model_linear_range_fill(s : StatsmodellinearRange, v : Double) -> StatsmodellinearRange {
  let result = stats_model_linear_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_model_linear_range_min(s : StatsmodellinearRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_linear_range_max(s : StatsmodellinearRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_linear_range_to_string(s : StatsmodellinearRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodellinearSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_linear_slice_make(size : Int) -> StatsmodellinearSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_linear_slice_len(s : StatsmodellinearSlice) -> Int { s.size }

pub fn stats_model_linear_slice_get(s : StatsmodellinearSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_linear_slice_set(s : StatsmodellinearSlice, i : Int, v : Double) -> StatsmodellinearSlice {
  let result = stats_model_linear_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_model_linear_slice_sum(s : StatsmodellinearSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_model_linear_slice_mean(s : StatsmodellinearSlice) -> Double {
  if s.size == 0 { 0.0 } else { stats_model_linear_slice_sum(s) / s.size.to_double() }
}

pub fn stats_model_linear_slice_scale(s : StatsmodellinearSlice, f : Double) -> StatsmodellinearSlice {
  let result = stats_model_linear_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_model_linear_slice_add(a : StatsmodellinearSlice, b : StatsmodellinearSlice) -> StatsmodellinearSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_model_linear_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_model_linear_slice_copy(s : StatsmodellinearSlice) -> StatsmodellinearSlice {
  let result = stats_model_linear_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_model_linear_slice_fill(s : StatsmodellinearSlice, v : Double) -> StatsmodellinearSlice {
  let result = stats_model_linear_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_model_linear_slice_min(s : StatsmodellinearSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_linear_slice_max(s : StatsmodellinearSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_linear_slice_to_string(s : StatsmodellinearSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn stats_model_linear_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_model_linear_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_model_linear_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_model_linear_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_model_linear_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_model_linear_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_model_linear_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_model_linear_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_model_linear_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_model_linear_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_model_linear_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_model_linear_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_model_linear_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_model_linear_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_model_linear_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_model_linear_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_model_linear_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_model_linear_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_model_linear_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_model_linear_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_model_linear_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_model_linear_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_model_linear_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_model_linear_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_model_linear_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}


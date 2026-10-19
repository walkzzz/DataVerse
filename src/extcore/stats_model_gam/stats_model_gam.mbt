///===
/// extcore/stats_model_gam

pub(all) struct StatsmodelgamPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_model_gam_make_point(x : Double, y : Double) -> StatsmodelgamPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_model_gam_make_point3(x : Double, y : Double, z : Double) -> StatsmodelgamPoint {
  { x, y, z, label: 0 }
}

pub fn stats_model_gam_point_x(pt : StatsmodelgamPoint) -> Double { pt.x }

pub fn stats_model_gam_point_y(pt : StatsmodelgamPoint) -> Double { pt.y }

pub fn stats_model_gam_point_z(pt : StatsmodelgamPoint) -> Double { pt.z }

pub fn stats_model_gam_point_label(pt : StatsmodelgamPoint) -> Int { pt.label }

pub fn stats_model_gam_point_dist(a : StatsmodelgamPoint, b : StatsmodelgamPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn stats_model_gam_point_add(a : StatsmodelgamPoint, b : StatsmodelgamPoint) -> StatsmodelgamPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn stats_model_gam_point_sub(a : StatsmodelgamPoint, b : StatsmodelgamPoint) -> StatsmodelgamPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn stats_model_gam_point_scale(pt : StatsmodelgamPoint, s : Double) -> StatsmodelgamPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn stats_model_gam_point_dot(a : StatsmodelgamPoint, b : StatsmodelgamPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn stats_model_gam_point_cross(a : StatsmodelgamPoint, b : StatsmodelgamPoint) -> StatsmodelgamPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn stats_model_gam_point_norm(pt : StatsmodelgamPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn stats_model_gam_point_normalize(pt : StatsmodelgamPoint) -> StatsmodelgamPoint {
  let n = stats_model_gam_point_norm(pt)
  if n < 0.0000001 { pt } else { stats_model_gam_point_scale(pt, 1.0 / n) }
}

pub fn stats_model_gam_point_negate(pt : StatsmodelgamPoint) -> StatsmodelgamPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn stats_model_gam_point_mid(a : StatsmodelgamPoint, b : StatsmodelgamPoint) -> StatsmodelgamPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn stats_model_gam_point_lerp(a : StatsmodelgamPoint, b : StatsmodelgamPoint, t : Double) -> StatsmodelgamPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn stats_model_gam_point_to_string(pt : StatsmodelgamPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct StatsmodelgamSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_model_gam_make_series(vals : Array[Double], name : String) -> StatsmodelgamSeries {
  { vals, name, meta: 0 }
}

pub fn stats_model_gam_series_len(s : StatsmodelgamSeries) -> Int { s.vals.length() }

pub fn stats_model_gam_series_sum(s : StatsmodelgamSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn stats_model_gam_series_mean(s : StatsmodelgamSeries) -> Double {
  let n = stats_model_gam_series_len(s)
  if n == 0 { 0.0 } else { stats_model_gam_series_sum(s) / n.to_double() }
}

pub fn stats_model_gam_series_min(s : StatsmodelgamSeries) -> Double {
  let n = stats_model_gam_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn stats_model_gam_series_max(s : StatsmodelgamSeries) -> Double {
  let n = stats_model_gam_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn stats_model_gam_series_range(s : StatsmodelgamSeries) -> Double {
  stats_model_gam_series_max(s) - stats_model_gam_series_min(s)
}

pub fn stats_model_gam_series_var(s : StatsmodelgamSeries) -> Double {
  let n = stats_model_gam_series_len(s)
  if n == 0 { 0.0 } else {
    let m = stats_model_gam_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn stats_model_gam_series_std(s : StatsmodelgamSeries) -> Double { @_common.sqrt(stats_model_gam_series_var(s)) }

pub fn stats_model_gam_series_median(s : StatsmodelgamSeries) -> Double {
  let n = stats_model_gam_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = stats_model_gam_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn stats_model_gam_series_scale(s : StatsmodelgamSeries, f : Double) -> StatsmodelgamSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn stats_model_gam_series_add(a : StatsmodelgamSeries, b : StatsmodelgamSeries) -> StatsmodelgamSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn stats_model_gam_series_sub(a : StatsmodelgamSeries, b : StatsmodelgamSeries) -> StatsmodelgamSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn stats_model_gam_series_normalize(s : StatsmodelgamSeries) -> StatsmodelgamSeries {
  let mn = stats_model_gam_series_min(s)
  let mx = stats_model_gam_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn stats_model_gam_series_cumsum(s : StatsmodelgamSeries) -> StatsmodelgamSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn stats_model_gam_series_to_string(s : StatsmodelgamSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsmodelgamMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_model_gam_make_matrix(rows : Int, cols : Int, val : Double) -> StatsmodelgamMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_model_gam_matrix_identity(n : Int) -> StatsmodelgamMatrix {
  let m = stats_model_gam_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn stats_model_gam_matrix_get(m : StatsmodelgamMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn stats_model_gam_matrix_transpose(m : StatsmodelgamMatrix) -> StatsmodelgamMatrix {
  let result = stats_model_gam_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn stats_model_gam_matrix_add(a : StatsmodelgamMatrix, b : StatsmodelgamMatrix) -> StatsmodelgamMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = stats_model_gam_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn stats_model_gam_matrix_scale(m : StatsmodelgamMatrix, s : Double) -> StatsmodelgamMatrix {
  let result = stats_model_gam_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn stats_model_gam_matrix_multiply(a : StatsmodelgamMatrix, b : StatsmodelgamMatrix) -> StatsmodelgamMatrix {
  if a.cols != b.rows { return stats_model_gam_make_matrix(a.rows, b.cols, 0.0) }
  let result = stats_model_gam_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn stats_model_gam_matrix_trace(m : StatsmodelgamMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn stats_model_gam_matrix_det(m : StatsmodelgamMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn stats_model_gam_matrix_norm(m : StatsmodelgamMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn stats_model_gam_matrix_to_string(m : StatsmodelgamMatrix) -> String {
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

pub(all) struct StatsmodelgamVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_model_gam_make_vector(comps : Array[Double]) -> StatsmodelgamVector {
  { comps, dim: comps.length() }
}

pub fn stats_model_gam_vector_zero(dim : Int) -> StatsmodelgamVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn stats_model_gam_vector_add(a : StatsmodelgamVector, b : StatsmodelgamVector) -> StatsmodelgamVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_model_gam_vector_sub(a : StatsmodelgamVector, b : StatsmodelgamVector) -> StatsmodelgamVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_model_gam_vector_scale(v : StatsmodelgamVector, s : Double) -> StatsmodelgamVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn stats_model_gam_vector_dot(a : StatsmodelgamVector, b : StatsmodelgamVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn stats_model_gam_vector_norm(v : StatsmodelgamVector) -> Double { @_common.sqrt(stats_model_gam_vector_dot(v, v)) }

pub fn stats_model_gam_vector_normalize(v : StatsmodelgamVector) -> StatsmodelgamVector {
  let n = stats_model_gam_vector_norm(v)
  if n < 0.0000001 { v } else { stats_model_gam_vector_scale(v, 1.0 / n) }
}

pub fn stats_model_gam_vector_dist(a : StatsmodelgamVector, b : StatsmodelgamVector) -> Double {
  stats_model_gam_vector_norm(stats_model_gam_vector_sub(a, b))
}

pub fn stats_model_gam_vector_to_string(v : StatsmodelgamVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn stats_model_gam_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn stats_model_gam_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = stats_model_gam_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn stats_model_gam_std(data : Array[Double]) -> Double { @_common.sqrt(stats_model_gam_var(data)) }

pub fn stats_model_gam_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = stats_model_gam_mean(a); let mb = stats_model_gam_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn stats_model_gam_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = stats_model_gam_std(a); let sb = stats_model_gam_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { stats_model_gam_cov(a, b) / (sa * sb) }
}

pub fn stats_model_gam_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = stats_model_gam_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn stats_model_gam_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn stats_model_gam_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn stats_model_gam_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(stats_model_gam_mse(pred, labels))
}

pub fn stats_model_gam_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn stats_model_gam_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = stats_model_gam_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn stats_model_gam_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn stats_model_gam_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn stats_model_gam_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = stats_model_gam_precision(pred, labels, pos); let r = stats_model_gam_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn stats_model_gam_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn stats_model_gam_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = stats_model_gam_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn stats_model_gam_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn stats_model_gam_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn stats_model_gam_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = stats_model_gam_gcd(a, b)
    (a / g) * b
  }
}

pub fn stats_model_gam_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn stats_model_gam_fibonacci(n : Int) -> Int {
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

pub fn stats_model_gam_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = stats_model_gam_min(data); let mx = stats_model_gam_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn stats_model_gam_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = stats_model_gam_mean(data); let sd = stats_model_gam_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn stats_model_gam_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn stats_model_gam_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn stats_model_gam_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn stats_model_gam_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn stats_model_gam_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn stats_model_gam_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct StatsmodelgamFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_gam_frame_make(size : Int) -> StatsmodelgamFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_gam_frame_len(s : StatsmodelgamFrame) -> Int { s.size }

pub fn stats_model_gam_frame_get(s : StatsmodelgamFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_gam_frame_set(s : StatsmodelgamFrame, i : Int, v : Double) -> StatsmodelgamFrame {
  let result = stats_model_gam_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_model_gam_frame_sum(s : StatsmodelgamFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_model_gam_frame_mean(s : StatsmodelgamFrame) -> Double {
  if s.size == 0 { 0.0 } else { stats_model_gam_frame_sum(s) / s.size.to_double() }
}

pub fn stats_model_gam_frame_scale(s : StatsmodelgamFrame, f : Double) -> StatsmodelgamFrame {
  let result = stats_model_gam_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_model_gam_frame_add(a : StatsmodelgamFrame, b : StatsmodelgamFrame) -> StatsmodelgamFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_model_gam_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_model_gam_frame_copy(s : StatsmodelgamFrame) -> StatsmodelgamFrame {
  let result = stats_model_gam_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_model_gam_frame_fill(s : StatsmodelgamFrame, v : Double) -> StatsmodelgamFrame {
  let result = stats_model_gam_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_model_gam_frame_min(s : StatsmodelgamFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_gam_frame_max(s : StatsmodelgamFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_gam_frame_to_string(s : StatsmodelgamFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodelgamTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_gam_table_make(size : Int) -> StatsmodelgamTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_gam_table_len(s : StatsmodelgamTable) -> Int { s.size }

pub fn stats_model_gam_table_get(s : StatsmodelgamTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_gam_table_set(s : StatsmodelgamTable, i : Int, v : Double) -> StatsmodelgamTable {
  let result = stats_model_gam_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_model_gam_table_sum(s : StatsmodelgamTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_model_gam_table_mean(s : StatsmodelgamTable) -> Double {
  if s.size == 0 { 0.0 } else { stats_model_gam_table_sum(s) / s.size.to_double() }
}

pub fn stats_model_gam_table_scale(s : StatsmodelgamTable, f : Double) -> StatsmodelgamTable {
  let result = stats_model_gam_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_model_gam_table_add(a : StatsmodelgamTable, b : StatsmodelgamTable) -> StatsmodelgamTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_model_gam_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_model_gam_table_copy(s : StatsmodelgamTable) -> StatsmodelgamTable {
  let result = stats_model_gam_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_model_gam_table_fill(s : StatsmodelgamTable, v : Double) -> StatsmodelgamTable {
  let result = stats_model_gam_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_model_gam_table_min(s : StatsmodelgamTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_gam_table_max(s : StatsmodelgamTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_gam_table_to_string(s : StatsmodelgamTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodelgamGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_gam_graphn_make(size : Int) -> StatsmodelgamGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_gam_graphn_len(s : StatsmodelgamGraphN) -> Int { s.size }

pub fn stats_model_gam_graphn_get(s : StatsmodelgamGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_gam_graphn_set(s : StatsmodelgamGraphN, i : Int, v : Double) -> StatsmodelgamGraphN {
  let result = stats_model_gam_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_model_gam_graphn_sum(s : StatsmodelgamGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_model_gam_graphn_mean(s : StatsmodelgamGraphN) -> Double {
  if s.size == 0 { 0.0 } else { stats_model_gam_graphn_sum(s) / s.size.to_double() }
}

pub fn stats_model_gam_graphn_scale(s : StatsmodelgamGraphN, f : Double) -> StatsmodelgamGraphN {
  let result = stats_model_gam_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_model_gam_graphn_add(a : StatsmodelgamGraphN, b : StatsmodelgamGraphN) -> StatsmodelgamGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_model_gam_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_model_gam_graphn_copy(s : StatsmodelgamGraphN) -> StatsmodelgamGraphN {
  let result = stats_model_gam_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_model_gam_graphn_fill(s : StatsmodelgamGraphN, v : Double) -> StatsmodelgamGraphN {
  let result = stats_model_gam_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_model_gam_graphn_min(s : StatsmodelgamGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_gam_graphn_max(s : StatsmodelgamGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_gam_graphn_to_string(s : StatsmodelgamGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodelgamNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_gam_node_make(size : Int) -> StatsmodelgamNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_gam_node_len(s : StatsmodelgamNode) -> Int { s.size }

pub fn stats_model_gam_node_get(s : StatsmodelgamNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_gam_node_set(s : StatsmodelgamNode, i : Int, v : Double) -> StatsmodelgamNode {
  let result = stats_model_gam_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_model_gam_node_sum(s : StatsmodelgamNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_model_gam_node_mean(s : StatsmodelgamNode) -> Double {
  if s.size == 0 { 0.0 } else { stats_model_gam_node_sum(s) / s.size.to_double() }
}

pub fn stats_model_gam_node_scale(s : StatsmodelgamNode, f : Double) -> StatsmodelgamNode {
  let result = stats_model_gam_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_model_gam_node_add(a : StatsmodelgamNode, b : StatsmodelgamNode) -> StatsmodelgamNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_model_gam_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_model_gam_node_copy(s : StatsmodelgamNode) -> StatsmodelgamNode {
  let result = stats_model_gam_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_model_gam_node_fill(s : StatsmodelgamNode, v : Double) -> StatsmodelgamNode {
  let result = stats_model_gam_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_model_gam_node_min(s : StatsmodelgamNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_gam_node_max(s : StatsmodelgamNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_gam_node_to_string(s : StatsmodelgamNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodelgamEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_gam_edge_make(size : Int) -> StatsmodelgamEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_gam_edge_len(s : StatsmodelgamEdge) -> Int { s.size }

pub fn stats_model_gam_edge_get(s : StatsmodelgamEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_gam_edge_set(s : StatsmodelgamEdge, i : Int, v : Double) -> StatsmodelgamEdge {
  let result = stats_model_gam_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_model_gam_edge_sum(s : StatsmodelgamEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_model_gam_edge_mean(s : StatsmodelgamEdge) -> Double {
  if s.size == 0 { 0.0 } else { stats_model_gam_edge_sum(s) / s.size.to_double() }
}

pub fn stats_model_gam_edge_scale(s : StatsmodelgamEdge, f : Double) -> StatsmodelgamEdge {
  let result = stats_model_gam_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_model_gam_edge_add(a : StatsmodelgamEdge, b : StatsmodelgamEdge) -> StatsmodelgamEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_model_gam_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_model_gam_edge_copy(s : StatsmodelgamEdge) -> StatsmodelgamEdge {
  let result = stats_model_gam_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_model_gam_edge_fill(s : StatsmodelgamEdge, v : Double) -> StatsmodelgamEdge {
  let result = stats_model_gam_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_model_gam_edge_min(s : StatsmodelgamEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_gam_edge_max(s : StatsmodelgamEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_gam_edge_to_string(s : StatsmodelgamEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodelgamPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_gam_path_make(size : Int) -> StatsmodelgamPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_gam_path_len(s : StatsmodelgamPath) -> Int { s.size }

pub fn stats_model_gam_path_get(s : StatsmodelgamPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_gam_path_set(s : StatsmodelgamPath, i : Int, v : Double) -> StatsmodelgamPath {
  let result = stats_model_gam_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_model_gam_path_sum(s : StatsmodelgamPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_model_gam_path_mean(s : StatsmodelgamPath) -> Double {
  if s.size == 0 { 0.0 } else { stats_model_gam_path_sum(s) / s.size.to_double() }
}

pub fn stats_model_gam_path_scale(s : StatsmodelgamPath, f : Double) -> StatsmodelgamPath {
  let result = stats_model_gam_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_model_gam_path_add(a : StatsmodelgamPath, b : StatsmodelgamPath) -> StatsmodelgamPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_model_gam_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_model_gam_path_copy(s : StatsmodelgamPath) -> StatsmodelgamPath {
  let result = stats_model_gam_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_model_gam_path_fill(s : StatsmodelgamPath, v : Double) -> StatsmodelgamPath {
  let result = stats_model_gam_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_model_gam_path_min(s : StatsmodelgamPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_gam_path_max(s : StatsmodelgamPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_gam_path_to_string(s : StatsmodelgamPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodelgamCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_gam_cluster_make(size : Int) -> StatsmodelgamCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_gam_cluster_len(s : StatsmodelgamCluster) -> Int { s.size }

pub fn stats_model_gam_cluster_get(s : StatsmodelgamCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_gam_cluster_set(s : StatsmodelgamCluster, i : Int, v : Double) -> StatsmodelgamCluster {
  let result = stats_model_gam_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_model_gam_cluster_sum(s : StatsmodelgamCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_model_gam_cluster_mean(s : StatsmodelgamCluster) -> Double {
  if s.size == 0 { 0.0 } else { stats_model_gam_cluster_sum(s) / s.size.to_double() }
}

pub fn stats_model_gam_cluster_scale(s : StatsmodelgamCluster, f : Double) -> StatsmodelgamCluster {
  let result = stats_model_gam_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_model_gam_cluster_add(a : StatsmodelgamCluster, b : StatsmodelgamCluster) -> StatsmodelgamCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_model_gam_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_model_gam_cluster_copy(s : StatsmodelgamCluster) -> StatsmodelgamCluster {
  let result = stats_model_gam_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_model_gam_cluster_fill(s : StatsmodelgamCluster, v : Double) -> StatsmodelgamCluster {
  let result = stats_model_gam_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_model_gam_cluster_min(s : StatsmodelgamCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_gam_cluster_max(s : StatsmodelgamCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_gam_cluster_to_string(s : StatsmodelgamCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodelgamModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_gam_model_make(size : Int) -> StatsmodelgamModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_gam_model_len(s : StatsmodelgamModel) -> Int { s.size }

pub fn stats_model_gam_model_get(s : StatsmodelgamModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_gam_model_set(s : StatsmodelgamModel, i : Int, v : Double) -> StatsmodelgamModel {
  let result = stats_model_gam_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_model_gam_model_sum(s : StatsmodelgamModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_model_gam_model_mean(s : StatsmodelgamModel) -> Double {
  if s.size == 0 { 0.0 } else { stats_model_gam_model_sum(s) / s.size.to_double() }
}

pub fn stats_model_gam_model_scale(s : StatsmodelgamModel, f : Double) -> StatsmodelgamModel {
  let result = stats_model_gam_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_model_gam_model_add(a : StatsmodelgamModel, b : StatsmodelgamModel) -> StatsmodelgamModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_model_gam_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_model_gam_model_copy(s : StatsmodelgamModel) -> StatsmodelgamModel {
  let result = stats_model_gam_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_model_gam_model_fill(s : StatsmodelgamModel, v : Double) -> StatsmodelgamModel {
  let result = stats_model_gam_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_model_gam_model_min(s : StatsmodelgamModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_gam_model_max(s : StatsmodelgamModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_gam_model_to_string(s : StatsmodelgamModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodelgamLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_gam_layer_make(size : Int) -> StatsmodelgamLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_gam_layer_len(s : StatsmodelgamLayer) -> Int { s.size }

pub fn stats_model_gam_layer_get(s : StatsmodelgamLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_gam_layer_set(s : StatsmodelgamLayer, i : Int, v : Double) -> StatsmodelgamLayer {
  let result = stats_model_gam_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_model_gam_layer_sum(s : StatsmodelgamLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_model_gam_layer_mean(s : StatsmodelgamLayer) -> Double {
  if s.size == 0 { 0.0 } else { stats_model_gam_layer_sum(s) / s.size.to_double() }
}

pub fn stats_model_gam_layer_scale(s : StatsmodelgamLayer, f : Double) -> StatsmodelgamLayer {
  let result = stats_model_gam_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_model_gam_layer_add(a : StatsmodelgamLayer, b : StatsmodelgamLayer) -> StatsmodelgamLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_model_gam_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_model_gam_layer_copy(s : StatsmodelgamLayer) -> StatsmodelgamLayer {
  let result = stats_model_gam_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_model_gam_layer_fill(s : StatsmodelgamLayer, v : Double) -> StatsmodelgamLayer {
  let result = stats_model_gam_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_model_gam_layer_min(s : StatsmodelgamLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_gam_layer_max(s : StatsmodelgamLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_gam_layer_to_string(s : StatsmodelgamLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodelgamBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_gam_buffer_make(size : Int) -> StatsmodelgamBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_gam_buffer_len(s : StatsmodelgamBuffer) -> Int { s.size }

pub fn stats_model_gam_buffer_get(s : StatsmodelgamBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_gam_buffer_set(s : StatsmodelgamBuffer, i : Int, v : Double) -> StatsmodelgamBuffer {
  let result = stats_model_gam_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_model_gam_buffer_sum(s : StatsmodelgamBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_model_gam_buffer_mean(s : StatsmodelgamBuffer) -> Double {
  if s.size == 0 { 0.0 } else { stats_model_gam_buffer_sum(s) / s.size.to_double() }
}

pub fn stats_model_gam_buffer_scale(s : StatsmodelgamBuffer, f : Double) -> StatsmodelgamBuffer {
  let result = stats_model_gam_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_model_gam_buffer_add(a : StatsmodelgamBuffer, b : StatsmodelgamBuffer) -> StatsmodelgamBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_model_gam_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_model_gam_buffer_copy(s : StatsmodelgamBuffer) -> StatsmodelgamBuffer {
  let result = stats_model_gam_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_model_gam_buffer_fill(s : StatsmodelgamBuffer, v : Double) -> StatsmodelgamBuffer {
  let result = stats_model_gam_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_model_gam_buffer_min(s : StatsmodelgamBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_gam_buffer_max(s : StatsmodelgamBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_gam_buffer_to_string(s : StatsmodelgamBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodelgamCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_gam_cursor_make(size : Int) -> StatsmodelgamCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_gam_cursor_len(s : StatsmodelgamCursor) -> Int { s.size }

pub fn stats_model_gam_cursor_get(s : StatsmodelgamCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_gam_cursor_set(s : StatsmodelgamCursor, i : Int, v : Double) -> StatsmodelgamCursor {
  let result = stats_model_gam_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_model_gam_cursor_sum(s : StatsmodelgamCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_model_gam_cursor_mean(s : StatsmodelgamCursor) -> Double {
  if s.size == 0 { 0.0 } else { stats_model_gam_cursor_sum(s) / s.size.to_double() }
}

pub fn stats_model_gam_cursor_scale(s : StatsmodelgamCursor, f : Double) -> StatsmodelgamCursor {
  let result = stats_model_gam_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_model_gam_cursor_add(a : StatsmodelgamCursor, b : StatsmodelgamCursor) -> StatsmodelgamCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_model_gam_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_model_gam_cursor_copy(s : StatsmodelgamCursor) -> StatsmodelgamCursor {
  let result = stats_model_gam_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_model_gam_cursor_fill(s : StatsmodelgamCursor, v : Double) -> StatsmodelgamCursor {
  let result = stats_model_gam_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_model_gam_cursor_min(s : StatsmodelgamCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_gam_cursor_max(s : StatsmodelgamCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_gam_cursor_to_string(s : StatsmodelgamCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodelgamView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_gam_view_make(size : Int) -> StatsmodelgamView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_gam_view_len(s : StatsmodelgamView) -> Int { s.size }

pub fn stats_model_gam_view_get(s : StatsmodelgamView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_gam_view_set(s : StatsmodelgamView, i : Int, v : Double) -> StatsmodelgamView {
  let result = stats_model_gam_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_model_gam_view_sum(s : StatsmodelgamView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_model_gam_view_mean(s : StatsmodelgamView) -> Double {
  if s.size == 0 { 0.0 } else { stats_model_gam_view_sum(s) / s.size.to_double() }
}

pub fn stats_model_gam_view_scale(s : StatsmodelgamView, f : Double) -> StatsmodelgamView {
  let result = stats_model_gam_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_model_gam_view_add(a : StatsmodelgamView, b : StatsmodelgamView) -> StatsmodelgamView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_model_gam_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_model_gam_view_copy(s : StatsmodelgamView) -> StatsmodelgamView {
  let result = stats_model_gam_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_model_gam_view_fill(s : StatsmodelgamView, v : Double) -> StatsmodelgamView {
  let result = stats_model_gam_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_model_gam_view_min(s : StatsmodelgamView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_gam_view_max(s : StatsmodelgamView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_gam_view_to_string(s : StatsmodelgamView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodelgamRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_gam_range_make(size : Int) -> StatsmodelgamRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_gam_range_len(s : StatsmodelgamRange) -> Int { s.size }

pub fn stats_model_gam_range_get(s : StatsmodelgamRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_gam_range_set(s : StatsmodelgamRange, i : Int, v : Double) -> StatsmodelgamRange {
  let result = stats_model_gam_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_model_gam_range_sum(s : StatsmodelgamRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_model_gam_range_mean(s : StatsmodelgamRange) -> Double {
  if s.size == 0 { 0.0 } else { stats_model_gam_range_sum(s) / s.size.to_double() }
}

pub fn stats_model_gam_range_scale(s : StatsmodelgamRange, f : Double) -> StatsmodelgamRange {
  let result = stats_model_gam_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_model_gam_range_add(a : StatsmodelgamRange, b : StatsmodelgamRange) -> StatsmodelgamRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_model_gam_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_model_gam_range_copy(s : StatsmodelgamRange) -> StatsmodelgamRange {
  let result = stats_model_gam_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_model_gam_range_fill(s : StatsmodelgamRange, v : Double) -> StatsmodelgamRange {
  let result = stats_model_gam_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_model_gam_range_min(s : StatsmodelgamRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_gam_range_max(s : StatsmodelgamRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_gam_range_to_string(s : StatsmodelgamRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodelgamSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_gam_slice_make(size : Int) -> StatsmodelgamSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_gam_slice_len(s : StatsmodelgamSlice) -> Int { s.size }

pub fn stats_model_gam_slice_get(s : StatsmodelgamSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_gam_slice_set(s : StatsmodelgamSlice, i : Int, v : Double) -> StatsmodelgamSlice {
  let result = stats_model_gam_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_model_gam_slice_sum(s : StatsmodelgamSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_model_gam_slice_mean(s : StatsmodelgamSlice) -> Double {
  if s.size == 0 { 0.0 } else { stats_model_gam_slice_sum(s) / s.size.to_double() }
}

pub fn stats_model_gam_slice_scale(s : StatsmodelgamSlice, f : Double) -> StatsmodelgamSlice {
  let result = stats_model_gam_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_model_gam_slice_add(a : StatsmodelgamSlice, b : StatsmodelgamSlice) -> StatsmodelgamSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_model_gam_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_model_gam_slice_copy(s : StatsmodelgamSlice) -> StatsmodelgamSlice {
  let result = stats_model_gam_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_model_gam_slice_fill(s : StatsmodelgamSlice, v : Double) -> StatsmodelgamSlice {
  let result = stats_model_gam_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_model_gam_slice_min(s : StatsmodelgamSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_gam_slice_max(s : StatsmodelgamSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_gam_slice_to_string(s : StatsmodelgamSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


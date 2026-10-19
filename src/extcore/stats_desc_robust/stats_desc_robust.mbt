///===
/// extcore/stats_desc_robust

pub(all) struct StatsdescrobustPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_desc_robust_make_point(x : Double, y : Double) -> StatsdescrobustPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_desc_robust_make_point3(x : Double, y : Double, z : Double) -> StatsdescrobustPoint {
  { x, y, z, label: 0 }
}

pub fn stats_desc_robust_point_x(pt : StatsdescrobustPoint) -> Double { pt.x }

pub fn stats_desc_robust_point_y(pt : StatsdescrobustPoint) -> Double { pt.y }

pub fn stats_desc_robust_point_z(pt : StatsdescrobustPoint) -> Double { pt.z }

pub fn stats_desc_robust_point_label(pt : StatsdescrobustPoint) -> Int { pt.label }

pub fn stats_desc_robust_point_dist(a : StatsdescrobustPoint, b : StatsdescrobustPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  stats_desc_robust_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn stats_desc_robust_point_add(a : StatsdescrobustPoint, b : StatsdescrobustPoint) -> StatsdescrobustPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn stats_desc_robust_point_sub(a : StatsdescrobustPoint, b : StatsdescrobustPoint) -> StatsdescrobustPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn stats_desc_robust_point_scale(pt : StatsdescrobustPoint, s : Double) -> StatsdescrobustPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn stats_desc_robust_point_dot(a : StatsdescrobustPoint, b : StatsdescrobustPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn stats_desc_robust_point_cross(a : StatsdescrobustPoint, b : StatsdescrobustPoint) -> StatsdescrobustPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn stats_desc_robust_point_norm(pt : StatsdescrobustPoint) -> Double {
  stats_desc_robust_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn stats_desc_robust_point_normalize(pt : StatsdescrobustPoint) -> StatsdescrobustPoint {
  let n = stats_desc_robust_point_norm(pt)
  if n < 0.0000001 { pt } else { stats_desc_robust_point_scale(pt, 1.0 / n) }
}

pub fn stats_desc_robust_point_negate(pt : StatsdescrobustPoint) -> StatsdescrobustPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn stats_desc_robust_point_mid(a : StatsdescrobustPoint, b : StatsdescrobustPoint) -> StatsdescrobustPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn stats_desc_robust_point_lerp(a : StatsdescrobustPoint, b : StatsdescrobustPoint, t : Double) -> StatsdescrobustPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn stats_desc_robust_point_to_string(pt : StatsdescrobustPoint) -> String {
  "(" + stats_desc_robust_dbl(pt.x) + ", " + stats_desc_robust_dbl(pt.y) + ", " + stats_desc_robust_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct StatsdescrobustSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_desc_robust_make_series(vals : Array[Double], name : String) -> StatsdescrobustSeries {
  { vals, name, meta: 0 }
}

pub fn stats_desc_robust_series_len(s : StatsdescrobustSeries) -> Int { s.vals.length() }

pub fn stats_desc_robust_series_sum(s : StatsdescrobustSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn stats_desc_robust_series_mean(s : StatsdescrobustSeries) -> Double {
  let n = stats_desc_robust_series_len(s)
  if n == 0 { 0.0 } else { stats_desc_robust_series_sum(s) / n.to_double() }
}

pub fn stats_desc_robust_series_min(s : StatsdescrobustSeries) -> Double {
  let n = stats_desc_robust_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn stats_desc_robust_series_max(s : StatsdescrobustSeries) -> Double {
  let n = stats_desc_robust_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn stats_desc_robust_series_range(s : StatsdescrobustSeries) -> Double {
  stats_desc_robust_series_max(s) - stats_desc_robust_series_min(s)
}

pub fn stats_desc_robust_series_var(s : StatsdescrobustSeries) -> Double {
  let n = stats_desc_robust_series_len(s)
  if n == 0 { 0.0 } else {
    let m = stats_desc_robust_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn stats_desc_robust_series_std(s : StatsdescrobustSeries) -> Double { stats_desc_robust_sqrt(stats_desc_robust_series_var(s)) }

pub fn stats_desc_robust_series_median(s : StatsdescrobustSeries) -> Double {
  let n = stats_desc_robust_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = stats_desc_robust_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn stats_desc_robust_series_scale(s : StatsdescrobustSeries, f : Double) -> StatsdescrobustSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = stats_desc_robust_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn stats_desc_robust_series_add(a : StatsdescrobustSeries, b : StatsdescrobustSeries) -> StatsdescrobustSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = stats_desc_robust_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn stats_desc_robust_series_sub(a : StatsdescrobustSeries, b : StatsdescrobustSeries) -> StatsdescrobustSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = stats_desc_robust_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn stats_desc_robust_series_normalize(s : StatsdescrobustSeries) -> StatsdescrobustSeries {
  let mn = stats_desc_robust_series_min(s)
  let mx = stats_desc_robust_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = stats_desc_robust_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn stats_desc_robust_series_cumsum(s : StatsdescrobustSeries) -> StatsdescrobustSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = stats_desc_robust_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn stats_desc_robust_series_to_string(s : StatsdescrobustSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + stats_desc_robust_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsdescrobustMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_desc_robust_make_matrix(rows : Int, cols : Int, val : Double) -> StatsdescrobustMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_desc_robust_matrix_identity(n : Int) -> StatsdescrobustMatrix {
  let m = stats_desc_robust_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn stats_desc_robust_matrix_get(m : StatsdescrobustMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn stats_desc_robust_matrix_transpose(m : StatsdescrobustMatrix) -> StatsdescrobustMatrix {
  let result = stats_desc_robust_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn stats_desc_robust_matrix_add(a : StatsdescrobustMatrix, b : StatsdescrobustMatrix) -> StatsdescrobustMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = stats_desc_robust_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn stats_desc_robust_matrix_scale(m : StatsdescrobustMatrix, s : Double) -> StatsdescrobustMatrix {
  let result = stats_desc_robust_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn stats_desc_robust_matrix_multiply(a : StatsdescrobustMatrix, b : StatsdescrobustMatrix) -> StatsdescrobustMatrix {
  if a.cols != b.rows { return stats_desc_robust_make_matrix(a.rows, b.cols, 0.0) }
  let result = stats_desc_robust_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn stats_desc_robust_matrix_trace(m : StatsdescrobustMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn stats_desc_robust_matrix_det(m : StatsdescrobustMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn stats_desc_robust_matrix_norm(m : StatsdescrobustMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  stats_desc_robust_sqrt(sum)
}

pub fn stats_desc_robust_matrix_to_string(m : StatsdescrobustMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + stats_desc_robust_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct StatsdescrobustVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_desc_robust_make_vector(comps : Array[Double]) -> StatsdescrobustVector {
  { comps, dim: comps.length() }
}

pub fn stats_desc_robust_vector_zero(dim : Int) -> StatsdescrobustVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn stats_desc_robust_vector_add(a : StatsdescrobustVector, b : StatsdescrobustVector) -> StatsdescrobustVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = stats_desc_robust_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_desc_robust_vector_sub(a : StatsdescrobustVector, b : StatsdescrobustVector) -> StatsdescrobustVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = stats_desc_robust_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_desc_robust_vector_scale(v : StatsdescrobustVector, s : Double) -> StatsdescrobustVector {
  let mut result = []
  for i in 0..<v.dim { result = stats_desc_robust_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn stats_desc_robust_vector_dot(a : StatsdescrobustVector, b : StatsdescrobustVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn stats_desc_robust_vector_norm(v : StatsdescrobustVector) -> Double { stats_desc_robust_sqrt(stats_desc_robust_vector_dot(v, v)) }

pub fn stats_desc_robust_vector_normalize(v : StatsdescrobustVector) -> StatsdescrobustVector {
  let n = stats_desc_robust_vector_norm(v)
  if n < 0.0000001 { v } else { stats_desc_robust_vector_scale(v, 1.0 / n) }
}

pub fn stats_desc_robust_vector_dist(a : StatsdescrobustVector, b : StatsdescrobustVector) -> Double {
  stats_desc_robust_vector_norm(stats_desc_robust_vector_sub(a, b))
}

pub fn stats_desc_robust_vector_to_string(v : StatsdescrobustVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + stats_desc_robust_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn stats_desc_robust_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn stats_desc_robust_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = stats_desc_robust_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn stats_desc_robust_std(data : Array[Double]) -> Double { stats_desc_robust_sqrt(stats_desc_robust_var(data)) }

pub fn stats_desc_robust_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = stats_desc_robust_mean(a); let mb = stats_desc_robust_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn stats_desc_robust_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = stats_desc_robust_std(a); let sb = stats_desc_robust_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { stats_desc_robust_cov(a, b) / (sa * sb) }
}

pub fn stats_desc_robust_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = stats_desc_robust_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn stats_desc_robust_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn stats_desc_robust_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn stats_desc_robust_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  stats_desc_robust_sqrt(stats_desc_robust_mse(pred, labels))
}

pub fn stats_desc_robust_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + stats_desc_robust_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn stats_desc_robust_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = stats_desc_robust_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn stats_desc_robust_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn stats_desc_robust_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn stats_desc_robust_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = stats_desc_robust_precision(pred, labels, pos); let r = stats_desc_robust_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn stats_desc_robust_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn stats_desc_robust_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = stats_desc_robust_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn stats_desc_robust_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn stats_desc_robust_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn stats_desc_robust_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = stats_desc_robust_gcd(a, b)
    (a / g) * b
  }
}

pub fn stats_desc_robust_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn stats_desc_robust_fibonacci(n : Int) -> Int {
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

pub fn stats_desc_robust_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = stats_desc_robust_min(data); let mx = stats_desc_robust_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn stats_desc_robust_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = stats_desc_robust_mean(data); let sd = stats_desc_robust_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn stats_desc_robust_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn stats_desc_robust_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn stats_desc_robust_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn stats_desc_robust_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn stats_desc_robust_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn stats_desc_robust_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn stats_desc_robust_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn stats_desc_robust_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn stats_desc_robust_dbl(x : Double) -> String {
  let i = if x >= 0.0 { stats_desc_robust_int(x) } else { -stats_desc_robust_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { stats_desc_robust_int(f * 1000000.0) } else { stats_desc_robust_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn stats_desc_robust_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn stats_desc_robust_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct StatsdescrobustFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_robust_frame_make(size : Int) -> StatsdescrobustFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_robust_frame_len(s : StatsdescrobustFrame) -> Int { s.size }

pub fn stats_desc_robust_frame_get(s : StatsdescrobustFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_robust_frame_set(s : StatsdescrobustFrame, i : Int, v : Double) -> StatsdescrobustFrame {
  let result = stats_desc_robust_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_desc_robust_frame_sum(s : StatsdescrobustFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_desc_robust_frame_mean(s : StatsdescrobustFrame) -> Double {
  if s.size == 0 { 0.0 } else { stats_desc_robust_frame_sum(s) / s.size.to_double() }
}

pub fn stats_desc_robust_frame_scale(s : StatsdescrobustFrame, f : Double) -> StatsdescrobustFrame {
  let result = stats_desc_robust_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_desc_robust_frame_add(a : StatsdescrobustFrame, b : StatsdescrobustFrame) -> StatsdescrobustFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_desc_robust_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_desc_robust_frame_copy(s : StatsdescrobustFrame) -> StatsdescrobustFrame {
  let result = stats_desc_robust_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_desc_robust_frame_fill(s : StatsdescrobustFrame, v : Double) -> StatsdescrobustFrame {
  let result = stats_desc_robust_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_desc_robust_frame_min(s : StatsdescrobustFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_robust_frame_max(s : StatsdescrobustFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_robust_frame_to_string(s : StatsdescrobustFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescrobustTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_robust_table_make(size : Int) -> StatsdescrobustTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_robust_table_len(s : StatsdescrobustTable) -> Int { s.size }

pub fn stats_desc_robust_table_get(s : StatsdescrobustTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_robust_table_set(s : StatsdescrobustTable, i : Int, v : Double) -> StatsdescrobustTable {
  let result = stats_desc_robust_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_desc_robust_table_sum(s : StatsdescrobustTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_desc_robust_table_mean(s : StatsdescrobustTable) -> Double {
  if s.size == 0 { 0.0 } else { stats_desc_robust_table_sum(s) / s.size.to_double() }
}

pub fn stats_desc_robust_table_scale(s : StatsdescrobustTable, f : Double) -> StatsdescrobustTable {
  let result = stats_desc_robust_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_desc_robust_table_add(a : StatsdescrobustTable, b : StatsdescrobustTable) -> StatsdescrobustTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_desc_robust_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_desc_robust_table_copy(s : StatsdescrobustTable) -> StatsdescrobustTable {
  let result = stats_desc_robust_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_desc_robust_table_fill(s : StatsdescrobustTable, v : Double) -> StatsdescrobustTable {
  let result = stats_desc_robust_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_desc_robust_table_min(s : StatsdescrobustTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_robust_table_max(s : StatsdescrobustTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_robust_table_to_string(s : StatsdescrobustTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescrobustGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_robust_graphn_make(size : Int) -> StatsdescrobustGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_robust_graphn_len(s : StatsdescrobustGraphN) -> Int { s.size }

pub fn stats_desc_robust_graphn_get(s : StatsdescrobustGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_robust_graphn_set(s : StatsdescrobustGraphN, i : Int, v : Double) -> StatsdescrobustGraphN {
  let result = stats_desc_robust_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_desc_robust_graphn_sum(s : StatsdescrobustGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_desc_robust_graphn_mean(s : StatsdescrobustGraphN) -> Double {
  if s.size == 0 { 0.0 } else { stats_desc_robust_graphn_sum(s) / s.size.to_double() }
}

pub fn stats_desc_robust_graphn_scale(s : StatsdescrobustGraphN, f : Double) -> StatsdescrobustGraphN {
  let result = stats_desc_robust_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_desc_robust_graphn_add(a : StatsdescrobustGraphN, b : StatsdescrobustGraphN) -> StatsdescrobustGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_desc_robust_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_desc_robust_graphn_copy(s : StatsdescrobustGraphN) -> StatsdescrobustGraphN {
  let result = stats_desc_robust_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_desc_robust_graphn_fill(s : StatsdescrobustGraphN, v : Double) -> StatsdescrobustGraphN {
  let result = stats_desc_robust_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_desc_robust_graphn_min(s : StatsdescrobustGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_robust_graphn_max(s : StatsdescrobustGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_robust_graphn_to_string(s : StatsdescrobustGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescrobustNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_robust_node_make(size : Int) -> StatsdescrobustNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_robust_node_len(s : StatsdescrobustNode) -> Int { s.size }

pub fn stats_desc_robust_node_get(s : StatsdescrobustNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_robust_node_set(s : StatsdescrobustNode, i : Int, v : Double) -> StatsdescrobustNode {
  let result = stats_desc_robust_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_desc_robust_node_sum(s : StatsdescrobustNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_desc_robust_node_mean(s : StatsdescrobustNode) -> Double {
  if s.size == 0 { 0.0 } else { stats_desc_robust_node_sum(s) / s.size.to_double() }
}

pub fn stats_desc_robust_node_scale(s : StatsdescrobustNode, f : Double) -> StatsdescrobustNode {
  let result = stats_desc_robust_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_desc_robust_node_add(a : StatsdescrobustNode, b : StatsdescrobustNode) -> StatsdescrobustNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_desc_robust_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_desc_robust_node_copy(s : StatsdescrobustNode) -> StatsdescrobustNode {
  let result = stats_desc_robust_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_desc_robust_node_fill(s : StatsdescrobustNode, v : Double) -> StatsdescrobustNode {
  let result = stats_desc_robust_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_desc_robust_node_min(s : StatsdescrobustNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_robust_node_max(s : StatsdescrobustNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_robust_node_to_string(s : StatsdescrobustNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescrobustEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_robust_edge_make(size : Int) -> StatsdescrobustEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_robust_edge_len(s : StatsdescrobustEdge) -> Int { s.size }

pub fn stats_desc_robust_edge_get(s : StatsdescrobustEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_robust_edge_set(s : StatsdescrobustEdge, i : Int, v : Double) -> StatsdescrobustEdge {
  let result = stats_desc_robust_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_desc_robust_edge_sum(s : StatsdescrobustEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_desc_robust_edge_mean(s : StatsdescrobustEdge) -> Double {
  if s.size == 0 { 0.0 } else { stats_desc_robust_edge_sum(s) / s.size.to_double() }
}

pub fn stats_desc_robust_edge_scale(s : StatsdescrobustEdge, f : Double) -> StatsdescrobustEdge {
  let result = stats_desc_robust_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_desc_robust_edge_add(a : StatsdescrobustEdge, b : StatsdescrobustEdge) -> StatsdescrobustEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_desc_robust_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_desc_robust_edge_copy(s : StatsdescrobustEdge) -> StatsdescrobustEdge {
  let result = stats_desc_robust_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_desc_robust_edge_fill(s : StatsdescrobustEdge, v : Double) -> StatsdescrobustEdge {
  let result = stats_desc_robust_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_desc_robust_edge_min(s : StatsdescrobustEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_robust_edge_max(s : StatsdescrobustEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_robust_edge_to_string(s : StatsdescrobustEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescrobustPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_robust_path_make(size : Int) -> StatsdescrobustPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_robust_path_len(s : StatsdescrobustPath) -> Int { s.size }

pub fn stats_desc_robust_path_get(s : StatsdescrobustPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_robust_path_set(s : StatsdescrobustPath, i : Int, v : Double) -> StatsdescrobustPath {
  let result = stats_desc_robust_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_desc_robust_path_sum(s : StatsdescrobustPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_desc_robust_path_mean(s : StatsdescrobustPath) -> Double {
  if s.size == 0 { 0.0 } else { stats_desc_robust_path_sum(s) / s.size.to_double() }
}

pub fn stats_desc_robust_path_scale(s : StatsdescrobustPath, f : Double) -> StatsdescrobustPath {
  let result = stats_desc_robust_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_desc_robust_path_add(a : StatsdescrobustPath, b : StatsdescrobustPath) -> StatsdescrobustPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_desc_robust_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_desc_robust_path_copy(s : StatsdescrobustPath) -> StatsdescrobustPath {
  let result = stats_desc_robust_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_desc_robust_path_fill(s : StatsdescrobustPath, v : Double) -> StatsdescrobustPath {
  let result = stats_desc_robust_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_desc_robust_path_min(s : StatsdescrobustPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_robust_path_max(s : StatsdescrobustPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_robust_path_to_string(s : StatsdescrobustPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescrobustCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_robust_cluster_make(size : Int) -> StatsdescrobustCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_robust_cluster_len(s : StatsdescrobustCluster) -> Int { s.size }

pub fn stats_desc_robust_cluster_get(s : StatsdescrobustCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_robust_cluster_set(s : StatsdescrobustCluster, i : Int, v : Double) -> StatsdescrobustCluster {
  let result = stats_desc_robust_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_desc_robust_cluster_sum(s : StatsdescrobustCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_desc_robust_cluster_mean(s : StatsdescrobustCluster) -> Double {
  if s.size == 0 { 0.0 } else { stats_desc_robust_cluster_sum(s) / s.size.to_double() }
}

pub fn stats_desc_robust_cluster_scale(s : StatsdescrobustCluster, f : Double) -> StatsdescrobustCluster {
  let result = stats_desc_robust_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_desc_robust_cluster_add(a : StatsdescrobustCluster, b : StatsdescrobustCluster) -> StatsdescrobustCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_desc_robust_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_desc_robust_cluster_copy(s : StatsdescrobustCluster) -> StatsdescrobustCluster {
  let result = stats_desc_robust_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_desc_robust_cluster_fill(s : StatsdescrobustCluster, v : Double) -> StatsdescrobustCluster {
  let result = stats_desc_robust_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_desc_robust_cluster_min(s : StatsdescrobustCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_robust_cluster_max(s : StatsdescrobustCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_robust_cluster_to_string(s : StatsdescrobustCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescrobustModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_robust_model_make(size : Int) -> StatsdescrobustModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_robust_model_len(s : StatsdescrobustModel) -> Int { s.size }

pub fn stats_desc_robust_model_get(s : StatsdescrobustModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_robust_model_set(s : StatsdescrobustModel, i : Int, v : Double) -> StatsdescrobustModel {
  let result = stats_desc_robust_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_desc_robust_model_sum(s : StatsdescrobustModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_desc_robust_model_mean(s : StatsdescrobustModel) -> Double {
  if s.size == 0 { 0.0 } else { stats_desc_robust_model_sum(s) / s.size.to_double() }
}

pub fn stats_desc_robust_model_scale(s : StatsdescrobustModel, f : Double) -> StatsdescrobustModel {
  let result = stats_desc_robust_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_desc_robust_model_add(a : StatsdescrobustModel, b : StatsdescrobustModel) -> StatsdescrobustModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_desc_robust_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_desc_robust_model_copy(s : StatsdescrobustModel) -> StatsdescrobustModel {
  let result = stats_desc_robust_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_desc_robust_model_fill(s : StatsdescrobustModel, v : Double) -> StatsdescrobustModel {
  let result = stats_desc_robust_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_desc_robust_model_min(s : StatsdescrobustModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_robust_model_max(s : StatsdescrobustModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_robust_model_to_string(s : StatsdescrobustModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescrobustLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_robust_layer_make(size : Int) -> StatsdescrobustLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_robust_layer_len(s : StatsdescrobustLayer) -> Int { s.size }

pub fn stats_desc_robust_layer_get(s : StatsdescrobustLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_robust_layer_set(s : StatsdescrobustLayer, i : Int, v : Double) -> StatsdescrobustLayer {
  let result = stats_desc_robust_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_desc_robust_layer_sum(s : StatsdescrobustLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_desc_robust_layer_mean(s : StatsdescrobustLayer) -> Double {
  if s.size == 0 { 0.0 } else { stats_desc_robust_layer_sum(s) / s.size.to_double() }
}

pub fn stats_desc_robust_layer_scale(s : StatsdescrobustLayer, f : Double) -> StatsdescrobustLayer {
  let result = stats_desc_robust_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_desc_robust_layer_add(a : StatsdescrobustLayer, b : StatsdescrobustLayer) -> StatsdescrobustLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_desc_robust_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_desc_robust_layer_copy(s : StatsdescrobustLayer) -> StatsdescrobustLayer {
  let result = stats_desc_robust_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_desc_robust_layer_fill(s : StatsdescrobustLayer, v : Double) -> StatsdescrobustLayer {
  let result = stats_desc_robust_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_desc_robust_layer_min(s : StatsdescrobustLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_robust_layer_max(s : StatsdescrobustLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_robust_layer_to_string(s : StatsdescrobustLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescrobustBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_robust_buffer_make(size : Int) -> StatsdescrobustBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_robust_buffer_len(s : StatsdescrobustBuffer) -> Int { s.size }

pub fn stats_desc_robust_buffer_get(s : StatsdescrobustBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_robust_buffer_set(s : StatsdescrobustBuffer, i : Int, v : Double) -> StatsdescrobustBuffer {
  let result = stats_desc_robust_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_desc_robust_buffer_sum(s : StatsdescrobustBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_desc_robust_buffer_mean(s : StatsdescrobustBuffer) -> Double {
  if s.size == 0 { 0.0 } else { stats_desc_robust_buffer_sum(s) / s.size.to_double() }
}

pub fn stats_desc_robust_buffer_scale(s : StatsdescrobustBuffer, f : Double) -> StatsdescrobustBuffer {
  let result = stats_desc_robust_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_desc_robust_buffer_add(a : StatsdescrobustBuffer, b : StatsdescrobustBuffer) -> StatsdescrobustBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_desc_robust_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_desc_robust_buffer_copy(s : StatsdescrobustBuffer) -> StatsdescrobustBuffer {
  let result = stats_desc_robust_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_desc_robust_buffer_fill(s : StatsdescrobustBuffer, v : Double) -> StatsdescrobustBuffer {
  let result = stats_desc_robust_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_desc_robust_buffer_min(s : StatsdescrobustBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_robust_buffer_max(s : StatsdescrobustBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_robust_buffer_to_string(s : StatsdescrobustBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescrobustCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_robust_cursor_make(size : Int) -> StatsdescrobustCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_robust_cursor_len(s : StatsdescrobustCursor) -> Int { s.size }

pub fn stats_desc_robust_cursor_get(s : StatsdescrobustCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_robust_cursor_set(s : StatsdescrobustCursor, i : Int, v : Double) -> StatsdescrobustCursor {
  let result = stats_desc_robust_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_desc_robust_cursor_sum(s : StatsdescrobustCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_desc_robust_cursor_mean(s : StatsdescrobustCursor) -> Double {
  if s.size == 0 { 0.0 } else { stats_desc_robust_cursor_sum(s) / s.size.to_double() }
}

pub fn stats_desc_robust_cursor_scale(s : StatsdescrobustCursor, f : Double) -> StatsdescrobustCursor {
  let result = stats_desc_robust_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_desc_robust_cursor_add(a : StatsdescrobustCursor, b : StatsdescrobustCursor) -> StatsdescrobustCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_desc_robust_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_desc_robust_cursor_copy(s : StatsdescrobustCursor) -> StatsdescrobustCursor {
  let result = stats_desc_robust_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_desc_robust_cursor_fill(s : StatsdescrobustCursor, v : Double) -> StatsdescrobustCursor {
  let result = stats_desc_robust_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_desc_robust_cursor_min(s : StatsdescrobustCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_robust_cursor_max(s : StatsdescrobustCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_robust_cursor_to_string(s : StatsdescrobustCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescrobustView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_robust_view_make(size : Int) -> StatsdescrobustView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_robust_view_len(s : StatsdescrobustView) -> Int { s.size }

pub fn stats_desc_robust_view_get(s : StatsdescrobustView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_robust_view_set(s : StatsdescrobustView, i : Int, v : Double) -> StatsdescrobustView {
  let result = stats_desc_robust_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_desc_robust_view_sum(s : StatsdescrobustView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_desc_robust_view_mean(s : StatsdescrobustView) -> Double {
  if s.size == 0 { 0.0 } else { stats_desc_robust_view_sum(s) / s.size.to_double() }
}

pub fn stats_desc_robust_view_scale(s : StatsdescrobustView, f : Double) -> StatsdescrobustView {
  let result = stats_desc_robust_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_desc_robust_view_add(a : StatsdescrobustView, b : StatsdescrobustView) -> StatsdescrobustView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_desc_robust_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_desc_robust_view_copy(s : StatsdescrobustView) -> StatsdescrobustView {
  let result = stats_desc_robust_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_desc_robust_view_fill(s : StatsdescrobustView, v : Double) -> StatsdescrobustView {
  let result = stats_desc_robust_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_desc_robust_view_min(s : StatsdescrobustView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_robust_view_max(s : StatsdescrobustView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_robust_view_to_string(s : StatsdescrobustView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescrobustRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_robust_range_make(size : Int) -> StatsdescrobustRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_robust_range_len(s : StatsdescrobustRange) -> Int { s.size }

pub fn stats_desc_robust_range_get(s : StatsdescrobustRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_robust_range_set(s : StatsdescrobustRange, i : Int, v : Double) -> StatsdescrobustRange {
  let result = stats_desc_robust_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_desc_robust_range_sum(s : StatsdescrobustRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_desc_robust_range_mean(s : StatsdescrobustRange) -> Double {
  if s.size == 0 { 0.0 } else { stats_desc_robust_range_sum(s) / s.size.to_double() }
}

pub fn stats_desc_robust_range_scale(s : StatsdescrobustRange, f : Double) -> StatsdescrobustRange {
  let result = stats_desc_robust_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_desc_robust_range_add(a : StatsdescrobustRange, b : StatsdescrobustRange) -> StatsdescrobustRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_desc_robust_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_desc_robust_range_copy(s : StatsdescrobustRange) -> StatsdescrobustRange {
  let result = stats_desc_robust_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_desc_robust_range_fill(s : StatsdescrobustRange, v : Double) -> StatsdescrobustRange {
  let result = stats_desc_robust_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_desc_robust_range_min(s : StatsdescrobustRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_robust_range_max(s : StatsdescrobustRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_robust_range_to_string(s : StatsdescrobustRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescrobustSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_robust_slice_make(size : Int) -> StatsdescrobustSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_robust_slice_len(s : StatsdescrobustSlice) -> Int { s.size }

pub fn stats_desc_robust_slice_get(s : StatsdescrobustSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_robust_slice_set(s : StatsdescrobustSlice, i : Int, v : Double) -> StatsdescrobustSlice {
  let result = stats_desc_robust_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_desc_robust_slice_sum(s : StatsdescrobustSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_desc_robust_slice_mean(s : StatsdescrobustSlice) -> Double {
  if s.size == 0 { 0.0 } else { stats_desc_robust_slice_sum(s) / s.size.to_double() }
}

pub fn stats_desc_robust_slice_scale(s : StatsdescrobustSlice, f : Double) -> StatsdescrobustSlice {
  let result = stats_desc_robust_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_desc_robust_slice_add(a : StatsdescrobustSlice, b : StatsdescrobustSlice) -> StatsdescrobustSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_desc_robust_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_desc_robust_slice_copy(s : StatsdescrobustSlice) -> StatsdescrobustSlice {
  let result = stats_desc_robust_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_desc_robust_slice_fill(s : StatsdescrobustSlice, v : Double) -> StatsdescrobustSlice {
  let result = stats_desc_robust_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_desc_robust_slice_min(s : StatsdescrobustSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_robust_slice_max(s : StatsdescrobustSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_robust_slice_to_string(s : StatsdescrobustSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn stats_desc_robust_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_desc_robust_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_desc_robust_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_desc_robust_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_desc_robust_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_desc_robust_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_desc_robust_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_desc_robust_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_desc_robust_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_desc_robust_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_desc_robust_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_desc_robust_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_desc_robust_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_desc_robust_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_desc_robust_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_desc_robust_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_desc_robust_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_desc_robust_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_desc_robust_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_desc_robust_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_desc_robust_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_desc_robust_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_desc_robust_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_desc_robust_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_desc_robust_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}


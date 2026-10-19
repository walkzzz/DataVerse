///===
/// extcore/stats_infer_param

pub(all) struct StatsinferparamPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_infer_param_make_point(x : Double, y : Double) -> StatsinferparamPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_infer_param_make_point3(x : Double, y : Double, z : Double) -> StatsinferparamPoint {
  { x, y, z, label: 0 }
}

pub fn stats_infer_param_point_x(pt : StatsinferparamPoint) -> Double { pt.x }

pub fn stats_infer_param_point_y(pt : StatsinferparamPoint) -> Double { pt.y }

pub fn stats_infer_param_point_z(pt : StatsinferparamPoint) -> Double { pt.z }

pub fn stats_infer_param_point_label(pt : StatsinferparamPoint) -> Int { pt.label }

pub fn stats_infer_param_point_dist(a : StatsinferparamPoint, b : StatsinferparamPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  stats_infer_param_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn stats_infer_param_point_add(a : StatsinferparamPoint, b : StatsinferparamPoint) -> StatsinferparamPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn stats_infer_param_point_sub(a : StatsinferparamPoint, b : StatsinferparamPoint) -> StatsinferparamPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn stats_infer_param_point_scale(pt : StatsinferparamPoint, s : Double) -> StatsinferparamPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn stats_infer_param_point_dot(a : StatsinferparamPoint, b : StatsinferparamPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn stats_infer_param_point_cross(a : StatsinferparamPoint, b : StatsinferparamPoint) -> StatsinferparamPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn stats_infer_param_point_norm(pt : StatsinferparamPoint) -> Double {
  stats_infer_param_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn stats_infer_param_point_normalize(pt : StatsinferparamPoint) -> StatsinferparamPoint {
  let n = stats_infer_param_point_norm(pt)
  if n < 0.0000001 { pt } else { stats_infer_param_point_scale(pt, 1.0 / n) }
}

pub fn stats_infer_param_point_negate(pt : StatsinferparamPoint) -> StatsinferparamPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn stats_infer_param_point_mid(a : StatsinferparamPoint, b : StatsinferparamPoint) -> StatsinferparamPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn stats_infer_param_point_lerp(a : StatsinferparamPoint, b : StatsinferparamPoint, t : Double) -> StatsinferparamPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn stats_infer_param_point_to_string(pt : StatsinferparamPoint) -> String {
  "(" + stats_infer_param_dbl(pt.x) + ", " + stats_infer_param_dbl(pt.y) + ", " + stats_infer_param_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct StatsinferparamSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_infer_param_make_series(vals : Array[Double], name : String) -> StatsinferparamSeries {
  { vals, name, meta: 0 }
}

pub fn stats_infer_param_series_len(s : StatsinferparamSeries) -> Int { s.vals.length() }

pub fn stats_infer_param_series_sum(s : StatsinferparamSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn stats_infer_param_series_mean(s : StatsinferparamSeries) -> Double {
  let n = stats_infer_param_series_len(s)
  if n == 0 { 0.0 } else { stats_infer_param_series_sum(s) / n.to_double() }
}

pub fn stats_infer_param_series_min(s : StatsinferparamSeries) -> Double {
  let n = stats_infer_param_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn stats_infer_param_series_max(s : StatsinferparamSeries) -> Double {
  let n = stats_infer_param_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn stats_infer_param_series_range(s : StatsinferparamSeries) -> Double {
  stats_infer_param_series_max(s) - stats_infer_param_series_min(s)
}

pub fn stats_infer_param_series_var(s : StatsinferparamSeries) -> Double {
  let n = stats_infer_param_series_len(s)
  if n == 0 { 0.0 } else {
    let m = stats_infer_param_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn stats_infer_param_series_std(s : StatsinferparamSeries) -> Double { stats_infer_param_sqrt(stats_infer_param_series_var(s)) }

pub fn stats_infer_param_series_median(s : StatsinferparamSeries) -> Double {
  let n = stats_infer_param_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = stats_infer_param_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn stats_infer_param_series_scale(s : StatsinferparamSeries, f : Double) -> StatsinferparamSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = stats_infer_param_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn stats_infer_param_series_add(a : StatsinferparamSeries, b : StatsinferparamSeries) -> StatsinferparamSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = stats_infer_param_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn stats_infer_param_series_sub(a : StatsinferparamSeries, b : StatsinferparamSeries) -> StatsinferparamSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = stats_infer_param_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn stats_infer_param_series_normalize(s : StatsinferparamSeries) -> StatsinferparamSeries {
  let mn = stats_infer_param_series_min(s)
  let mx = stats_infer_param_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = stats_infer_param_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn stats_infer_param_series_cumsum(s : StatsinferparamSeries) -> StatsinferparamSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = stats_infer_param_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn stats_infer_param_series_to_string(s : StatsinferparamSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + stats_infer_param_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsinferparamMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_infer_param_make_matrix(rows : Int, cols : Int, val : Double) -> StatsinferparamMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_infer_param_matrix_identity(n : Int) -> StatsinferparamMatrix {
  let m = stats_infer_param_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn stats_infer_param_matrix_get(m : StatsinferparamMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn stats_infer_param_matrix_transpose(m : StatsinferparamMatrix) -> StatsinferparamMatrix {
  let result = stats_infer_param_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn stats_infer_param_matrix_add(a : StatsinferparamMatrix, b : StatsinferparamMatrix) -> StatsinferparamMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = stats_infer_param_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn stats_infer_param_matrix_scale(m : StatsinferparamMatrix, s : Double) -> StatsinferparamMatrix {
  let result = stats_infer_param_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn stats_infer_param_matrix_multiply(a : StatsinferparamMatrix, b : StatsinferparamMatrix) -> StatsinferparamMatrix {
  if a.cols != b.rows { return stats_infer_param_make_matrix(a.rows, b.cols, 0.0) }
  let result = stats_infer_param_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn stats_infer_param_matrix_trace(m : StatsinferparamMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn stats_infer_param_matrix_det(m : StatsinferparamMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn stats_infer_param_matrix_norm(m : StatsinferparamMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  stats_infer_param_sqrt(sum)
}

pub fn stats_infer_param_matrix_to_string(m : StatsinferparamMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + stats_infer_param_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct StatsinferparamVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_infer_param_make_vector(comps : Array[Double]) -> StatsinferparamVector {
  { comps, dim: comps.length() }
}

pub fn stats_infer_param_vector_zero(dim : Int) -> StatsinferparamVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn stats_infer_param_vector_add(a : StatsinferparamVector, b : StatsinferparamVector) -> StatsinferparamVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = stats_infer_param_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_infer_param_vector_sub(a : StatsinferparamVector, b : StatsinferparamVector) -> StatsinferparamVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = stats_infer_param_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_infer_param_vector_scale(v : StatsinferparamVector, s : Double) -> StatsinferparamVector {
  let mut result = []
  for i in 0..<v.dim { result = stats_infer_param_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn stats_infer_param_vector_dot(a : StatsinferparamVector, b : StatsinferparamVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn stats_infer_param_vector_norm(v : StatsinferparamVector) -> Double { stats_infer_param_sqrt(stats_infer_param_vector_dot(v, v)) }

pub fn stats_infer_param_vector_normalize(v : StatsinferparamVector) -> StatsinferparamVector {
  let n = stats_infer_param_vector_norm(v)
  if n < 0.0000001 { v } else { stats_infer_param_vector_scale(v, 1.0 / n) }
}

pub fn stats_infer_param_vector_dist(a : StatsinferparamVector, b : StatsinferparamVector) -> Double {
  stats_infer_param_vector_norm(stats_infer_param_vector_sub(a, b))
}

pub fn stats_infer_param_vector_to_string(v : StatsinferparamVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + stats_infer_param_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn stats_infer_param_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn stats_infer_param_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = stats_infer_param_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn stats_infer_param_std(data : Array[Double]) -> Double { stats_infer_param_sqrt(stats_infer_param_var(data)) }

pub fn stats_infer_param_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = stats_infer_param_mean(a); let mb = stats_infer_param_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn stats_infer_param_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = stats_infer_param_std(a); let sb = stats_infer_param_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { stats_infer_param_cov(a, b) / (sa * sb) }
}

pub fn stats_infer_param_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = stats_infer_param_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn stats_infer_param_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn stats_infer_param_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn stats_infer_param_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  stats_infer_param_sqrt(stats_infer_param_mse(pred, labels))
}

pub fn stats_infer_param_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + stats_infer_param_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn stats_infer_param_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = stats_infer_param_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn stats_infer_param_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn stats_infer_param_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn stats_infer_param_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = stats_infer_param_precision(pred, labels, pos); let r = stats_infer_param_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn stats_infer_param_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn stats_infer_param_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = stats_infer_param_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn stats_infer_param_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn stats_infer_param_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn stats_infer_param_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = stats_infer_param_gcd(a, b)
    (a / g) * b
  }
}

pub fn stats_infer_param_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn stats_infer_param_fibonacci(n : Int) -> Int {
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

pub fn stats_infer_param_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = stats_infer_param_min(data); let mx = stats_infer_param_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn stats_infer_param_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = stats_infer_param_mean(data); let sd = stats_infer_param_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn stats_infer_param_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn stats_infer_param_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn stats_infer_param_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn stats_infer_param_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn stats_infer_param_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn stats_infer_param_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn stats_infer_param_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn stats_infer_param_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn stats_infer_param_dbl(x : Double) -> String {
  let i = if x >= 0.0 { stats_infer_param_int(x) } else { -stats_infer_param_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { stats_infer_param_int(f * 1000000.0) } else { stats_infer_param_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn stats_infer_param_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn stats_infer_param_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct StatsinferparamFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_param_frame_make(size : Int) -> StatsinferparamFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_param_frame_len(s : StatsinferparamFrame) -> Int { s.size }

pub fn stats_infer_param_frame_get(s : StatsinferparamFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_param_frame_set(s : StatsinferparamFrame, i : Int, v : Double) -> StatsinferparamFrame {
  let result = stats_infer_param_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_infer_param_frame_sum(s : StatsinferparamFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_infer_param_frame_mean(s : StatsinferparamFrame) -> Double {
  if s.size == 0 { 0.0 } else { stats_infer_param_frame_sum(s) / s.size.to_double() }
}

pub fn stats_infer_param_frame_scale(s : StatsinferparamFrame, f : Double) -> StatsinferparamFrame {
  let result = stats_infer_param_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_infer_param_frame_add(a : StatsinferparamFrame, b : StatsinferparamFrame) -> StatsinferparamFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_infer_param_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_infer_param_frame_copy(s : StatsinferparamFrame) -> StatsinferparamFrame {
  let result = stats_infer_param_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_infer_param_frame_fill(s : StatsinferparamFrame, v : Double) -> StatsinferparamFrame {
  let result = stats_infer_param_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_infer_param_frame_min(s : StatsinferparamFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_infer_param_frame_max(s : StatsinferparamFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_infer_param_frame_to_string(s : StatsinferparamFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferparamTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_param_table_make(size : Int) -> StatsinferparamTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_param_table_len(s : StatsinferparamTable) -> Int { s.size }

pub fn stats_infer_param_table_get(s : StatsinferparamTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_param_table_set(s : StatsinferparamTable, i : Int, v : Double) -> StatsinferparamTable {
  let result = stats_infer_param_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_infer_param_table_sum(s : StatsinferparamTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_infer_param_table_mean(s : StatsinferparamTable) -> Double {
  if s.size == 0 { 0.0 } else { stats_infer_param_table_sum(s) / s.size.to_double() }
}

pub fn stats_infer_param_table_scale(s : StatsinferparamTable, f : Double) -> StatsinferparamTable {
  let result = stats_infer_param_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_infer_param_table_add(a : StatsinferparamTable, b : StatsinferparamTable) -> StatsinferparamTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_infer_param_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_infer_param_table_copy(s : StatsinferparamTable) -> StatsinferparamTable {
  let result = stats_infer_param_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_infer_param_table_fill(s : StatsinferparamTable, v : Double) -> StatsinferparamTable {
  let result = stats_infer_param_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_infer_param_table_min(s : StatsinferparamTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_infer_param_table_max(s : StatsinferparamTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_infer_param_table_to_string(s : StatsinferparamTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferparamGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_param_graphn_make(size : Int) -> StatsinferparamGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_param_graphn_len(s : StatsinferparamGraphN) -> Int { s.size }

pub fn stats_infer_param_graphn_get(s : StatsinferparamGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_param_graphn_set(s : StatsinferparamGraphN, i : Int, v : Double) -> StatsinferparamGraphN {
  let result = stats_infer_param_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_infer_param_graphn_sum(s : StatsinferparamGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_infer_param_graphn_mean(s : StatsinferparamGraphN) -> Double {
  if s.size == 0 { 0.0 } else { stats_infer_param_graphn_sum(s) / s.size.to_double() }
}

pub fn stats_infer_param_graphn_scale(s : StatsinferparamGraphN, f : Double) -> StatsinferparamGraphN {
  let result = stats_infer_param_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_infer_param_graphn_add(a : StatsinferparamGraphN, b : StatsinferparamGraphN) -> StatsinferparamGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_infer_param_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_infer_param_graphn_copy(s : StatsinferparamGraphN) -> StatsinferparamGraphN {
  let result = stats_infer_param_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_infer_param_graphn_fill(s : StatsinferparamGraphN, v : Double) -> StatsinferparamGraphN {
  let result = stats_infer_param_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_infer_param_graphn_min(s : StatsinferparamGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_infer_param_graphn_max(s : StatsinferparamGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_infer_param_graphn_to_string(s : StatsinferparamGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferparamNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_param_node_make(size : Int) -> StatsinferparamNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_param_node_len(s : StatsinferparamNode) -> Int { s.size }

pub fn stats_infer_param_node_get(s : StatsinferparamNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_param_node_set(s : StatsinferparamNode, i : Int, v : Double) -> StatsinferparamNode {
  let result = stats_infer_param_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_infer_param_node_sum(s : StatsinferparamNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_infer_param_node_mean(s : StatsinferparamNode) -> Double {
  if s.size == 0 { 0.0 } else { stats_infer_param_node_sum(s) / s.size.to_double() }
}

pub fn stats_infer_param_node_scale(s : StatsinferparamNode, f : Double) -> StatsinferparamNode {
  let result = stats_infer_param_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_infer_param_node_add(a : StatsinferparamNode, b : StatsinferparamNode) -> StatsinferparamNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_infer_param_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_infer_param_node_copy(s : StatsinferparamNode) -> StatsinferparamNode {
  let result = stats_infer_param_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_infer_param_node_fill(s : StatsinferparamNode, v : Double) -> StatsinferparamNode {
  let result = stats_infer_param_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_infer_param_node_min(s : StatsinferparamNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_infer_param_node_max(s : StatsinferparamNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_infer_param_node_to_string(s : StatsinferparamNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferparamEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_param_edge_make(size : Int) -> StatsinferparamEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_param_edge_len(s : StatsinferparamEdge) -> Int { s.size }

pub fn stats_infer_param_edge_get(s : StatsinferparamEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_param_edge_set(s : StatsinferparamEdge, i : Int, v : Double) -> StatsinferparamEdge {
  let result = stats_infer_param_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_infer_param_edge_sum(s : StatsinferparamEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_infer_param_edge_mean(s : StatsinferparamEdge) -> Double {
  if s.size == 0 { 0.0 } else { stats_infer_param_edge_sum(s) / s.size.to_double() }
}

pub fn stats_infer_param_edge_scale(s : StatsinferparamEdge, f : Double) -> StatsinferparamEdge {
  let result = stats_infer_param_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_infer_param_edge_add(a : StatsinferparamEdge, b : StatsinferparamEdge) -> StatsinferparamEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_infer_param_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_infer_param_edge_copy(s : StatsinferparamEdge) -> StatsinferparamEdge {
  let result = stats_infer_param_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_infer_param_edge_fill(s : StatsinferparamEdge, v : Double) -> StatsinferparamEdge {
  let result = stats_infer_param_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_infer_param_edge_min(s : StatsinferparamEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_infer_param_edge_max(s : StatsinferparamEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_infer_param_edge_to_string(s : StatsinferparamEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferparamPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_param_path_make(size : Int) -> StatsinferparamPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_param_path_len(s : StatsinferparamPath) -> Int { s.size }

pub fn stats_infer_param_path_get(s : StatsinferparamPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_param_path_set(s : StatsinferparamPath, i : Int, v : Double) -> StatsinferparamPath {
  let result = stats_infer_param_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_infer_param_path_sum(s : StatsinferparamPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_infer_param_path_mean(s : StatsinferparamPath) -> Double {
  if s.size == 0 { 0.0 } else { stats_infer_param_path_sum(s) / s.size.to_double() }
}

pub fn stats_infer_param_path_scale(s : StatsinferparamPath, f : Double) -> StatsinferparamPath {
  let result = stats_infer_param_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_infer_param_path_add(a : StatsinferparamPath, b : StatsinferparamPath) -> StatsinferparamPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_infer_param_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_infer_param_path_copy(s : StatsinferparamPath) -> StatsinferparamPath {
  let result = stats_infer_param_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_infer_param_path_fill(s : StatsinferparamPath, v : Double) -> StatsinferparamPath {
  let result = stats_infer_param_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_infer_param_path_min(s : StatsinferparamPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_infer_param_path_max(s : StatsinferparamPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_infer_param_path_to_string(s : StatsinferparamPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferparamCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_param_cluster_make(size : Int) -> StatsinferparamCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_param_cluster_len(s : StatsinferparamCluster) -> Int { s.size }

pub fn stats_infer_param_cluster_get(s : StatsinferparamCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_param_cluster_set(s : StatsinferparamCluster, i : Int, v : Double) -> StatsinferparamCluster {
  let result = stats_infer_param_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_infer_param_cluster_sum(s : StatsinferparamCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_infer_param_cluster_mean(s : StatsinferparamCluster) -> Double {
  if s.size == 0 { 0.0 } else { stats_infer_param_cluster_sum(s) / s.size.to_double() }
}

pub fn stats_infer_param_cluster_scale(s : StatsinferparamCluster, f : Double) -> StatsinferparamCluster {
  let result = stats_infer_param_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_infer_param_cluster_add(a : StatsinferparamCluster, b : StatsinferparamCluster) -> StatsinferparamCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_infer_param_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_infer_param_cluster_copy(s : StatsinferparamCluster) -> StatsinferparamCluster {
  let result = stats_infer_param_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_infer_param_cluster_fill(s : StatsinferparamCluster, v : Double) -> StatsinferparamCluster {
  let result = stats_infer_param_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_infer_param_cluster_min(s : StatsinferparamCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_infer_param_cluster_max(s : StatsinferparamCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_infer_param_cluster_to_string(s : StatsinferparamCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferparamModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_param_model_make(size : Int) -> StatsinferparamModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_param_model_len(s : StatsinferparamModel) -> Int { s.size }

pub fn stats_infer_param_model_get(s : StatsinferparamModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_param_model_set(s : StatsinferparamModel, i : Int, v : Double) -> StatsinferparamModel {
  let result = stats_infer_param_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_infer_param_model_sum(s : StatsinferparamModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_infer_param_model_mean(s : StatsinferparamModel) -> Double {
  if s.size == 0 { 0.0 } else { stats_infer_param_model_sum(s) / s.size.to_double() }
}

pub fn stats_infer_param_model_scale(s : StatsinferparamModel, f : Double) -> StatsinferparamModel {
  let result = stats_infer_param_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_infer_param_model_add(a : StatsinferparamModel, b : StatsinferparamModel) -> StatsinferparamModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_infer_param_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_infer_param_model_copy(s : StatsinferparamModel) -> StatsinferparamModel {
  let result = stats_infer_param_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_infer_param_model_fill(s : StatsinferparamModel, v : Double) -> StatsinferparamModel {
  let result = stats_infer_param_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_infer_param_model_min(s : StatsinferparamModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_infer_param_model_max(s : StatsinferparamModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_infer_param_model_to_string(s : StatsinferparamModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferparamLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_param_layer_make(size : Int) -> StatsinferparamLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_param_layer_len(s : StatsinferparamLayer) -> Int { s.size }

pub fn stats_infer_param_layer_get(s : StatsinferparamLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_param_layer_set(s : StatsinferparamLayer, i : Int, v : Double) -> StatsinferparamLayer {
  let result = stats_infer_param_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_infer_param_layer_sum(s : StatsinferparamLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_infer_param_layer_mean(s : StatsinferparamLayer) -> Double {
  if s.size == 0 { 0.0 } else { stats_infer_param_layer_sum(s) / s.size.to_double() }
}

pub fn stats_infer_param_layer_scale(s : StatsinferparamLayer, f : Double) -> StatsinferparamLayer {
  let result = stats_infer_param_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_infer_param_layer_add(a : StatsinferparamLayer, b : StatsinferparamLayer) -> StatsinferparamLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_infer_param_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_infer_param_layer_copy(s : StatsinferparamLayer) -> StatsinferparamLayer {
  let result = stats_infer_param_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_infer_param_layer_fill(s : StatsinferparamLayer, v : Double) -> StatsinferparamLayer {
  let result = stats_infer_param_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_infer_param_layer_min(s : StatsinferparamLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_infer_param_layer_max(s : StatsinferparamLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_infer_param_layer_to_string(s : StatsinferparamLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferparamBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_param_buffer_make(size : Int) -> StatsinferparamBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_param_buffer_len(s : StatsinferparamBuffer) -> Int { s.size }

pub fn stats_infer_param_buffer_get(s : StatsinferparamBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_param_buffer_set(s : StatsinferparamBuffer, i : Int, v : Double) -> StatsinferparamBuffer {
  let result = stats_infer_param_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_infer_param_buffer_sum(s : StatsinferparamBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_infer_param_buffer_mean(s : StatsinferparamBuffer) -> Double {
  if s.size == 0 { 0.0 } else { stats_infer_param_buffer_sum(s) / s.size.to_double() }
}

pub fn stats_infer_param_buffer_scale(s : StatsinferparamBuffer, f : Double) -> StatsinferparamBuffer {
  let result = stats_infer_param_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_infer_param_buffer_add(a : StatsinferparamBuffer, b : StatsinferparamBuffer) -> StatsinferparamBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_infer_param_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_infer_param_buffer_copy(s : StatsinferparamBuffer) -> StatsinferparamBuffer {
  let result = stats_infer_param_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_infer_param_buffer_fill(s : StatsinferparamBuffer, v : Double) -> StatsinferparamBuffer {
  let result = stats_infer_param_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_infer_param_buffer_min(s : StatsinferparamBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_infer_param_buffer_max(s : StatsinferparamBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_infer_param_buffer_to_string(s : StatsinferparamBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferparamCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_param_cursor_make(size : Int) -> StatsinferparamCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_param_cursor_len(s : StatsinferparamCursor) -> Int { s.size }

pub fn stats_infer_param_cursor_get(s : StatsinferparamCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_param_cursor_set(s : StatsinferparamCursor, i : Int, v : Double) -> StatsinferparamCursor {
  let result = stats_infer_param_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_infer_param_cursor_sum(s : StatsinferparamCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_infer_param_cursor_mean(s : StatsinferparamCursor) -> Double {
  if s.size == 0 { 0.0 } else { stats_infer_param_cursor_sum(s) / s.size.to_double() }
}

pub fn stats_infer_param_cursor_scale(s : StatsinferparamCursor, f : Double) -> StatsinferparamCursor {
  let result = stats_infer_param_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_infer_param_cursor_add(a : StatsinferparamCursor, b : StatsinferparamCursor) -> StatsinferparamCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_infer_param_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_infer_param_cursor_copy(s : StatsinferparamCursor) -> StatsinferparamCursor {
  let result = stats_infer_param_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_infer_param_cursor_fill(s : StatsinferparamCursor, v : Double) -> StatsinferparamCursor {
  let result = stats_infer_param_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_infer_param_cursor_min(s : StatsinferparamCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_infer_param_cursor_max(s : StatsinferparamCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_infer_param_cursor_to_string(s : StatsinferparamCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferparamView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_param_view_make(size : Int) -> StatsinferparamView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_param_view_len(s : StatsinferparamView) -> Int { s.size }

pub fn stats_infer_param_view_get(s : StatsinferparamView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_param_view_set(s : StatsinferparamView, i : Int, v : Double) -> StatsinferparamView {
  let result = stats_infer_param_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_infer_param_view_sum(s : StatsinferparamView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_infer_param_view_mean(s : StatsinferparamView) -> Double {
  if s.size == 0 { 0.0 } else { stats_infer_param_view_sum(s) / s.size.to_double() }
}

pub fn stats_infer_param_view_scale(s : StatsinferparamView, f : Double) -> StatsinferparamView {
  let result = stats_infer_param_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_infer_param_view_add(a : StatsinferparamView, b : StatsinferparamView) -> StatsinferparamView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_infer_param_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_infer_param_view_copy(s : StatsinferparamView) -> StatsinferparamView {
  let result = stats_infer_param_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_infer_param_view_fill(s : StatsinferparamView, v : Double) -> StatsinferparamView {
  let result = stats_infer_param_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_infer_param_view_min(s : StatsinferparamView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_infer_param_view_max(s : StatsinferparamView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_infer_param_view_to_string(s : StatsinferparamView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferparamRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_param_range_make(size : Int) -> StatsinferparamRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_param_range_len(s : StatsinferparamRange) -> Int { s.size }

pub fn stats_infer_param_range_get(s : StatsinferparamRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_param_range_set(s : StatsinferparamRange, i : Int, v : Double) -> StatsinferparamRange {
  let result = stats_infer_param_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_infer_param_range_sum(s : StatsinferparamRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_infer_param_range_mean(s : StatsinferparamRange) -> Double {
  if s.size == 0 { 0.0 } else { stats_infer_param_range_sum(s) / s.size.to_double() }
}

pub fn stats_infer_param_range_scale(s : StatsinferparamRange, f : Double) -> StatsinferparamRange {
  let result = stats_infer_param_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_infer_param_range_add(a : StatsinferparamRange, b : StatsinferparamRange) -> StatsinferparamRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_infer_param_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_infer_param_range_copy(s : StatsinferparamRange) -> StatsinferparamRange {
  let result = stats_infer_param_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_infer_param_range_fill(s : StatsinferparamRange, v : Double) -> StatsinferparamRange {
  let result = stats_infer_param_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_infer_param_range_min(s : StatsinferparamRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_infer_param_range_max(s : StatsinferparamRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_infer_param_range_to_string(s : StatsinferparamRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferparamSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_param_slice_make(size : Int) -> StatsinferparamSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_param_slice_len(s : StatsinferparamSlice) -> Int { s.size }

pub fn stats_infer_param_slice_get(s : StatsinferparamSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_param_slice_set(s : StatsinferparamSlice, i : Int, v : Double) -> StatsinferparamSlice {
  let result = stats_infer_param_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_infer_param_slice_sum(s : StatsinferparamSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_infer_param_slice_mean(s : StatsinferparamSlice) -> Double {
  if s.size == 0 { 0.0 } else { stats_infer_param_slice_sum(s) / s.size.to_double() }
}

pub fn stats_infer_param_slice_scale(s : StatsinferparamSlice, f : Double) -> StatsinferparamSlice {
  let result = stats_infer_param_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_infer_param_slice_add(a : StatsinferparamSlice, b : StatsinferparamSlice) -> StatsinferparamSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_infer_param_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_infer_param_slice_copy(s : StatsinferparamSlice) -> StatsinferparamSlice {
  let result = stats_infer_param_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_infer_param_slice_fill(s : StatsinferparamSlice, v : Double) -> StatsinferparamSlice {
  let result = stats_infer_param_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_infer_param_slice_min(s : StatsinferparamSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_infer_param_slice_max(s : StatsinferparamSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_infer_param_slice_to_string(s : StatsinferparamSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn stats_infer_param_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_infer_param_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_infer_param_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_infer_param_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_infer_param_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_infer_param_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_infer_param_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_infer_param_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_infer_param_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_infer_param_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_infer_param_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_infer_param_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_infer_param_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_infer_param_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_infer_param_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_infer_param_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_infer_param_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_infer_param_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_infer_param_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_infer_param_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_infer_param_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_infer_param_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_infer_param_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_infer_param_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn stats_infer_param_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}


///===
/// extcore/opt_meta_evolution

pub(all) struct OptmetaevolutionPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn opt_meta_evolution_make_point(x : Double, y : Double) -> OptmetaevolutionPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn opt_meta_evolution_make_point3(x : Double, y : Double, z : Double) -> OptmetaevolutionPoint {
  { x, y, z, label: 0 }
}

pub fn opt_meta_evolution_point_x(pt : OptmetaevolutionPoint) -> Double { pt.x }

pub fn opt_meta_evolution_point_y(pt : OptmetaevolutionPoint) -> Double { pt.y }

pub fn opt_meta_evolution_point_z(pt : OptmetaevolutionPoint) -> Double { pt.z }

pub fn opt_meta_evolution_point_label(pt : OptmetaevolutionPoint) -> Int { pt.label }

pub fn opt_meta_evolution_point_dist(a : OptmetaevolutionPoint, b : OptmetaevolutionPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  opt_meta_evolution_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn opt_meta_evolution_point_add(a : OptmetaevolutionPoint, b : OptmetaevolutionPoint) -> OptmetaevolutionPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn opt_meta_evolution_point_sub(a : OptmetaevolutionPoint, b : OptmetaevolutionPoint) -> OptmetaevolutionPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn opt_meta_evolution_point_scale(pt : OptmetaevolutionPoint, s : Double) -> OptmetaevolutionPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn opt_meta_evolution_point_dot(a : OptmetaevolutionPoint, b : OptmetaevolutionPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn opt_meta_evolution_point_cross(a : OptmetaevolutionPoint, b : OptmetaevolutionPoint) -> OptmetaevolutionPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn opt_meta_evolution_point_norm(pt : OptmetaevolutionPoint) -> Double {
  opt_meta_evolution_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn opt_meta_evolution_point_normalize(pt : OptmetaevolutionPoint) -> OptmetaevolutionPoint {
  let n = opt_meta_evolution_point_norm(pt)
  if n < 0.0000001 { pt } else { opt_meta_evolution_point_scale(pt, 1.0 / n) }
}

pub fn opt_meta_evolution_point_negate(pt : OptmetaevolutionPoint) -> OptmetaevolutionPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn opt_meta_evolution_point_mid(a : OptmetaevolutionPoint, b : OptmetaevolutionPoint) -> OptmetaevolutionPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn opt_meta_evolution_point_lerp(a : OptmetaevolutionPoint, b : OptmetaevolutionPoint, t : Double) -> OptmetaevolutionPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn opt_meta_evolution_point_to_string(pt : OptmetaevolutionPoint) -> String {
  "(" + opt_meta_evolution_dbl(pt.x) + ", " + opt_meta_evolution_dbl(pt.y) + ", " + opt_meta_evolution_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct OptmetaevolutionSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn opt_meta_evolution_make_series(vals : Array[Double], name : String) -> OptmetaevolutionSeries {
  { vals, name, meta: 0 }
}

pub fn opt_meta_evolution_series_len(s : OptmetaevolutionSeries) -> Int { s.vals.length() }

pub fn opt_meta_evolution_series_sum(s : OptmetaevolutionSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn opt_meta_evolution_series_mean(s : OptmetaevolutionSeries) -> Double {
  let n = opt_meta_evolution_series_len(s)
  if n == 0 { 0.0 } else { opt_meta_evolution_series_sum(s) / n.to_double() }
}

pub fn opt_meta_evolution_series_min(s : OptmetaevolutionSeries) -> Double {
  let n = opt_meta_evolution_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn opt_meta_evolution_series_max(s : OptmetaevolutionSeries) -> Double {
  let n = opt_meta_evolution_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn opt_meta_evolution_series_range(s : OptmetaevolutionSeries) -> Double {
  opt_meta_evolution_series_max(s) - opt_meta_evolution_series_min(s)
}

pub fn opt_meta_evolution_series_var(s : OptmetaevolutionSeries) -> Double {
  let n = opt_meta_evolution_series_len(s)
  if n == 0 { 0.0 } else {
    let m = opt_meta_evolution_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn opt_meta_evolution_series_std(s : OptmetaevolutionSeries) -> Double { opt_meta_evolution_sqrt(opt_meta_evolution_series_var(s)) }

pub fn opt_meta_evolution_series_median(s : OptmetaevolutionSeries) -> Double {
  let n = opt_meta_evolution_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = opt_meta_evolution_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn opt_meta_evolution_series_scale(s : OptmetaevolutionSeries, f : Double) -> OptmetaevolutionSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = opt_meta_evolution_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn opt_meta_evolution_series_add(a : OptmetaevolutionSeries, b : OptmetaevolutionSeries) -> OptmetaevolutionSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = opt_meta_evolution_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn opt_meta_evolution_series_sub(a : OptmetaevolutionSeries, b : OptmetaevolutionSeries) -> OptmetaevolutionSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = opt_meta_evolution_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn opt_meta_evolution_series_normalize(s : OptmetaevolutionSeries) -> OptmetaevolutionSeries {
  let mn = opt_meta_evolution_series_min(s)
  let mx = opt_meta_evolution_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = opt_meta_evolution_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn opt_meta_evolution_series_cumsum(s : OptmetaevolutionSeries) -> OptmetaevolutionSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = opt_meta_evolution_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn opt_meta_evolution_series_to_string(s : OptmetaevolutionSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + opt_meta_evolution_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct OptmetaevolutionMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn opt_meta_evolution_make_matrix(rows : Int, cols : Int, val : Double) -> OptmetaevolutionMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn opt_meta_evolution_matrix_identity(n : Int) -> OptmetaevolutionMatrix {
  let m = opt_meta_evolution_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn opt_meta_evolution_matrix_get(m : OptmetaevolutionMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn opt_meta_evolution_matrix_transpose(m : OptmetaevolutionMatrix) -> OptmetaevolutionMatrix {
  let result = opt_meta_evolution_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn opt_meta_evolution_matrix_add(a : OptmetaevolutionMatrix, b : OptmetaevolutionMatrix) -> OptmetaevolutionMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = opt_meta_evolution_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn opt_meta_evolution_matrix_scale(m : OptmetaevolutionMatrix, s : Double) -> OptmetaevolutionMatrix {
  let result = opt_meta_evolution_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn opt_meta_evolution_matrix_multiply(a : OptmetaevolutionMatrix, b : OptmetaevolutionMatrix) -> OptmetaevolutionMatrix {
  if a.cols != b.rows { return opt_meta_evolution_make_matrix(a.rows, b.cols, 0.0) }
  let result = opt_meta_evolution_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn opt_meta_evolution_matrix_trace(m : OptmetaevolutionMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn opt_meta_evolution_matrix_det(m : OptmetaevolutionMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn opt_meta_evolution_matrix_norm(m : OptmetaevolutionMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  opt_meta_evolution_sqrt(sum)
}

pub fn opt_meta_evolution_matrix_to_string(m : OptmetaevolutionMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + opt_meta_evolution_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct OptmetaevolutionVector {
  comps : Array[Double]
  dim : Int
}

pub fn opt_meta_evolution_make_vector(comps : Array[Double]) -> OptmetaevolutionVector {
  { comps, dim: comps.length() }
}

pub fn opt_meta_evolution_vector_zero(dim : Int) -> OptmetaevolutionVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn opt_meta_evolution_vector_add(a : OptmetaevolutionVector, b : OptmetaevolutionVector) -> OptmetaevolutionVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = opt_meta_evolution_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn opt_meta_evolution_vector_sub(a : OptmetaevolutionVector, b : OptmetaevolutionVector) -> OptmetaevolutionVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = opt_meta_evolution_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn opt_meta_evolution_vector_scale(v : OptmetaevolutionVector, s : Double) -> OptmetaevolutionVector {
  let mut result = []
  for i in 0..<v.dim { result = opt_meta_evolution_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn opt_meta_evolution_vector_dot(a : OptmetaevolutionVector, b : OptmetaevolutionVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn opt_meta_evolution_vector_norm(v : OptmetaevolutionVector) -> Double { opt_meta_evolution_sqrt(opt_meta_evolution_vector_dot(v, v)) }

pub fn opt_meta_evolution_vector_normalize(v : OptmetaevolutionVector) -> OptmetaevolutionVector {
  let n = opt_meta_evolution_vector_norm(v)
  if n < 0.0000001 { v } else { opt_meta_evolution_vector_scale(v, 1.0 / n) }
}

pub fn opt_meta_evolution_vector_dist(a : OptmetaevolutionVector, b : OptmetaevolutionVector) -> Double {
  opt_meta_evolution_vector_norm(opt_meta_evolution_vector_sub(a, b))
}

pub fn opt_meta_evolution_vector_to_string(v : OptmetaevolutionVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + opt_meta_evolution_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn opt_meta_evolution_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn opt_meta_evolution_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = opt_meta_evolution_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn opt_meta_evolution_std(data : Array[Double]) -> Double { opt_meta_evolution_sqrt(opt_meta_evolution_var(data)) }

pub fn opt_meta_evolution_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = opt_meta_evolution_mean(a); let mb = opt_meta_evolution_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn opt_meta_evolution_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = opt_meta_evolution_std(a); let sb = opt_meta_evolution_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { opt_meta_evolution_cov(a, b) / (sa * sb) }
}

pub fn opt_meta_evolution_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = opt_meta_evolution_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn opt_meta_evolution_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn opt_meta_evolution_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn opt_meta_evolution_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  opt_meta_evolution_sqrt(opt_meta_evolution_mse(pred, labels))
}

pub fn opt_meta_evolution_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + opt_meta_evolution_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn opt_meta_evolution_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = opt_meta_evolution_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn opt_meta_evolution_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn opt_meta_evolution_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn opt_meta_evolution_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = opt_meta_evolution_precision(pred, labels, pos); let r = opt_meta_evolution_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn opt_meta_evolution_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn opt_meta_evolution_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = opt_meta_evolution_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn opt_meta_evolution_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn opt_meta_evolution_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn opt_meta_evolution_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = opt_meta_evolution_gcd(a, b)
    (a / g) * b
  }
}

pub fn opt_meta_evolution_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn opt_meta_evolution_fibonacci(n : Int) -> Int {
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

pub fn opt_meta_evolution_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = opt_meta_evolution_min(data); let mx = opt_meta_evolution_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn opt_meta_evolution_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = opt_meta_evolution_mean(data); let sd = opt_meta_evolution_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn opt_meta_evolution_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn opt_meta_evolution_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn opt_meta_evolution_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn opt_meta_evolution_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn opt_meta_evolution_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn opt_meta_evolution_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn opt_meta_evolution_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn opt_meta_evolution_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn opt_meta_evolution_dbl(x : Double) -> String {
  let i = if x >= 0.0 { opt_meta_evolution_int(x) } else { -opt_meta_evolution_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { opt_meta_evolution_int(f * 1000000.0) } else { opt_meta_evolution_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn opt_meta_evolution_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn opt_meta_evolution_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct OptmetaevolutionFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_evolution_frame_make(size : Int) -> OptmetaevolutionFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_evolution_frame_len(s : OptmetaevolutionFrame) -> Int { s.size }

pub fn opt_meta_evolution_frame_get(s : OptmetaevolutionFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_evolution_frame_set(s : OptmetaevolutionFrame, i : Int, v : Double) -> OptmetaevolutionFrame {
  let result = opt_meta_evolution_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_evolution_frame_sum(s : OptmetaevolutionFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_evolution_frame_mean(s : OptmetaevolutionFrame) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_evolution_frame_sum(s) / s.size.to_double() }
}

pub fn opt_meta_evolution_frame_scale(s : OptmetaevolutionFrame, f : Double) -> OptmetaevolutionFrame {
  let result = opt_meta_evolution_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_evolution_frame_add(a : OptmetaevolutionFrame, b : OptmetaevolutionFrame) -> OptmetaevolutionFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_evolution_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_evolution_frame_copy(s : OptmetaevolutionFrame) -> OptmetaevolutionFrame {
  let result = opt_meta_evolution_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_evolution_frame_fill(s : OptmetaevolutionFrame, v : Double) -> OptmetaevolutionFrame {
  let result = opt_meta_evolution_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_evolution_frame_min(s : OptmetaevolutionFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_evolution_frame_max(s : OptmetaevolutionFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_evolution_frame_to_string(s : OptmetaevolutionFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetaevolutionTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_evolution_table_make(size : Int) -> OptmetaevolutionTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_evolution_table_len(s : OptmetaevolutionTable) -> Int { s.size }

pub fn opt_meta_evolution_table_get(s : OptmetaevolutionTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_evolution_table_set(s : OptmetaevolutionTable, i : Int, v : Double) -> OptmetaevolutionTable {
  let result = opt_meta_evolution_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_evolution_table_sum(s : OptmetaevolutionTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_evolution_table_mean(s : OptmetaevolutionTable) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_evolution_table_sum(s) / s.size.to_double() }
}

pub fn opt_meta_evolution_table_scale(s : OptmetaevolutionTable, f : Double) -> OptmetaevolutionTable {
  let result = opt_meta_evolution_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_evolution_table_add(a : OptmetaevolutionTable, b : OptmetaevolutionTable) -> OptmetaevolutionTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_evolution_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_evolution_table_copy(s : OptmetaevolutionTable) -> OptmetaevolutionTable {
  let result = opt_meta_evolution_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_evolution_table_fill(s : OptmetaevolutionTable, v : Double) -> OptmetaevolutionTable {
  let result = opt_meta_evolution_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_evolution_table_min(s : OptmetaevolutionTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_evolution_table_max(s : OptmetaevolutionTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_evolution_table_to_string(s : OptmetaevolutionTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetaevolutionGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_evolution_graphn_make(size : Int) -> OptmetaevolutionGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_evolution_graphn_len(s : OptmetaevolutionGraphN) -> Int { s.size }

pub fn opt_meta_evolution_graphn_get(s : OptmetaevolutionGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_evolution_graphn_set(s : OptmetaevolutionGraphN, i : Int, v : Double) -> OptmetaevolutionGraphN {
  let result = opt_meta_evolution_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_evolution_graphn_sum(s : OptmetaevolutionGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_evolution_graphn_mean(s : OptmetaevolutionGraphN) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_evolution_graphn_sum(s) / s.size.to_double() }
}

pub fn opt_meta_evolution_graphn_scale(s : OptmetaevolutionGraphN, f : Double) -> OptmetaevolutionGraphN {
  let result = opt_meta_evolution_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_evolution_graphn_add(a : OptmetaevolutionGraphN, b : OptmetaevolutionGraphN) -> OptmetaevolutionGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_evolution_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_evolution_graphn_copy(s : OptmetaevolutionGraphN) -> OptmetaevolutionGraphN {
  let result = opt_meta_evolution_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_evolution_graphn_fill(s : OptmetaevolutionGraphN, v : Double) -> OptmetaevolutionGraphN {
  let result = opt_meta_evolution_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_evolution_graphn_min(s : OptmetaevolutionGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_evolution_graphn_max(s : OptmetaevolutionGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_evolution_graphn_to_string(s : OptmetaevolutionGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetaevolutionNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_evolution_node_make(size : Int) -> OptmetaevolutionNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_evolution_node_len(s : OptmetaevolutionNode) -> Int { s.size }

pub fn opt_meta_evolution_node_get(s : OptmetaevolutionNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_evolution_node_set(s : OptmetaevolutionNode, i : Int, v : Double) -> OptmetaevolutionNode {
  let result = opt_meta_evolution_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_evolution_node_sum(s : OptmetaevolutionNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_evolution_node_mean(s : OptmetaevolutionNode) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_evolution_node_sum(s) / s.size.to_double() }
}

pub fn opt_meta_evolution_node_scale(s : OptmetaevolutionNode, f : Double) -> OptmetaevolutionNode {
  let result = opt_meta_evolution_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_evolution_node_add(a : OptmetaevolutionNode, b : OptmetaevolutionNode) -> OptmetaevolutionNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_evolution_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_evolution_node_copy(s : OptmetaevolutionNode) -> OptmetaevolutionNode {
  let result = opt_meta_evolution_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_evolution_node_fill(s : OptmetaevolutionNode, v : Double) -> OptmetaevolutionNode {
  let result = opt_meta_evolution_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_evolution_node_min(s : OptmetaevolutionNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_evolution_node_max(s : OptmetaevolutionNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_evolution_node_to_string(s : OptmetaevolutionNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetaevolutionEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_evolution_edge_make(size : Int) -> OptmetaevolutionEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_evolution_edge_len(s : OptmetaevolutionEdge) -> Int { s.size }

pub fn opt_meta_evolution_edge_get(s : OptmetaevolutionEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_evolution_edge_set(s : OptmetaevolutionEdge, i : Int, v : Double) -> OptmetaevolutionEdge {
  let result = opt_meta_evolution_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_evolution_edge_sum(s : OptmetaevolutionEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_evolution_edge_mean(s : OptmetaevolutionEdge) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_evolution_edge_sum(s) / s.size.to_double() }
}

pub fn opt_meta_evolution_edge_scale(s : OptmetaevolutionEdge, f : Double) -> OptmetaevolutionEdge {
  let result = opt_meta_evolution_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_evolution_edge_add(a : OptmetaevolutionEdge, b : OptmetaevolutionEdge) -> OptmetaevolutionEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_evolution_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_evolution_edge_copy(s : OptmetaevolutionEdge) -> OptmetaevolutionEdge {
  let result = opt_meta_evolution_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_evolution_edge_fill(s : OptmetaevolutionEdge, v : Double) -> OptmetaevolutionEdge {
  let result = opt_meta_evolution_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_evolution_edge_min(s : OptmetaevolutionEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_evolution_edge_max(s : OptmetaevolutionEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_evolution_edge_to_string(s : OptmetaevolutionEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetaevolutionPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_evolution_path_make(size : Int) -> OptmetaevolutionPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_evolution_path_len(s : OptmetaevolutionPath) -> Int { s.size }

pub fn opt_meta_evolution_path_get(s : OptmetaevolutionPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_evolution_path_set(s : OptmetaevolutionPath, i : Int, v : Double) -> OptmetaevolutionPath {
  let result = opt_meta_evolution_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_evolution_path_sum(s : OptmetaevolutionPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_evolution_path_mean(s : OptmetaevolutionPath) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_evolution_path_sum(s) / s.size.to_double() }
}

pub fn opt_meta_evolution_path_scale(s : OptmetaevolutionPath, f : Double) -> OptmetaevolutionPath {
  let result = opt_meta_evolution_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_evolution_path_add(a : OptmetaevolutionPath, b : OptmetaevolutionPath) -> OptmetaevolutionPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_evolution_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_evolution_path_copy(s : OptmetaevolutionPath) -> OptmetaevolutionPath {
  let result = opt_meta_evolution_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_evolution_path_fill(s : OptmetaevolutionPath, v : Double) -> OptmetaevolutionPath {
  let result = opt_meta_evolution_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_evolution_path_min(s : OptmetaevolutionPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_evolution_path_max(s : OptmetaevolutionPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_evolution_path_to_string(s : OptmetaevolutionPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetaevolutionCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_evolution_cluster_make(size : Int) -> OptmetaevolutionCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_evolution_cluster_len(s : OptmetaevolutionCluster) -> Int { s.size }

pub fn opt_meta_evolution_cluster_get(s : OptmetaevolutionCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_evolution_cluster_set(s : OptmetaevolutionCluster, i : Int, v : Double) -> OptmetaevolutionCluster {
  let result = opt_meta_evolution_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_evolution_cluster_sum(s : OptmetaevolutionCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_evolution_cluster_mean(s : OptmetaevolutionCluster) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_evolution_cluster_sum(s) / s.size.to_double() }
}

pub fn opt_meta_evolution_cluster_scale(s : OptmetaevolutionCluster, f : Double) -> OptmetaevolutionCluster {
  let result = opt_meta_evolution_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_evolution_cluster_add(a : OptmetaevolutionCluster, b : OptmetaevolutionCluster) -> OptmetaevolutionCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_evolution_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_evolution_cluster_copy(s : OptmetaevolutionCluster) -> OptmetaevolutionCluster {
  let result = opt_meta_evolution_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_evolution_cluster_fill(s : OptmetaevolutionCluster, v : Double) -> OptmetaevolutionCluster {
  let result = opt_meta_evolution_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_evolution_cluster_min(s : OptmetaevolutionCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_evolution_cluster_max(s : OptmetaevolutionCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_evolution_cluster_to_string(s : OptmetaevolutionCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetaevolutionModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_evolution_model_make(size : Int) -> OptmetaevolutionModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_evolution_model_len(s : OptmetaevolutionModel) -> Int { s.size }

pub fn opt_meta_evolution_model_get(s : OptmetaevolutionModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_evolution_model_set(s : OptmetaevolutionModel, i : Int, v : Double) -> OptmetaevolutionModel {
  let result = opt_meta_evolution_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_evolution_model_sum(s : OptmetaevolutionModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_evolution_model_mean(s : OptmetaevolutionModel) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_evolution_model_sum(s) / s.size.to_double() }
}

pub fn opt_meta_evolution_model_scale(s : OptmetaevolutionModel, f : Double) -> OptmetaevolutionModel {
  let result = opt_meta_evolution_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_evolution_model_add(a : OptmetaevolutionModel, b : OptmetaevolutionModel) -> OptmetaevolutionModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_evolution_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_evolution_model_copy(s : OptmetaevolutionModel) -> OptmetaevolutionModel {
  let result = opt_meta_evolution_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_evolution_model_fill(s : OptmetaevolutionModel, v : Double) -> OptmetaevolutionModel {
  let result = opt_meta_evolution_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_evolution_model_min(s : OptmetaevolutionModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_evolution_model_max(s : OptmetaevolutionModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_evolution_model_to_string(s : OptmetaevolutionModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetaevolutionLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_evolution_layer_make(size : Int) -> OptmetaevolutionLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_evolution_layer_len(s : OptmetaevolutionLayer) -> Int { s.size }

pub fn opt_meta_evolution_layer_get(s : OptmetaevolutionLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_evolution_layer_set(s : OptmetaevolutionLayer, i : Int, v : Double) -> OptmetaevolutionLayer {
  let result = opt_meta_evolution_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_evolution_layer_sum(s : OptmetaevolutionLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_evolution_layer_mean(s : OptmetaevolutionLayer) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_evolution_layer_sum(s) / s.size.to_double() }
}

pub fn opt_meta_evolution_layer_scale(s : OptmetaevolutionLayer, f : Double) -> OptmetaevolutionLayer {
  let result = opt_meta_evolution_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_evolution_layer_add(a : OptmetaevolutionLayer, b : OptmetaevolutionLayer) -> OptmetaevolutionLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_evolution_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_evolution_layer_copy(s : OptmetaevolutionLayer) -> OptmetaevolutionLayer {
  let result = opt_meta_evolution_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_evolution_layer_fill(s : OptmetaevolutionLayer, v : Double) -> OptmetaevolutionLayer {
  let result = opt_meta_evolution_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_evolution_layer_min(s : OptmetaevolutionLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_evolution_layer_max(s : OptmetaevolutionLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_evolution_layer_to_string(s : OptmetaevolutionLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetaevolutionBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_evolution_buffer_make(size : Int) -> OptmetaevolutionBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_evolution_buffer_len(s : OptmetaevolutionBuffer) -> Int { s.size }

pub fn opt_meta_evolution_buffer_get(s : OptmetaevolutionBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_evolution_buffer_set(s : OptmetaevolutionBuffer, i : Int, v : Double) -> OptmetaevolutionBuffer {
  let result = opt_meta_evolution_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_evolution_buffer_sum(s : OptmetaevolutionBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_evolution_buffer_mean(s : OptmetaevolutionBuffer) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_evolution_buffer_sum(s) / s.size.to_double() }
}

pub fn opt_meta_evolution_buffer_scale(s : OptmetaevolutionBuffer, f : Double) -> OptmetaevolutionBuffer {
  let result = opt_meta_evolution_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_evolution_buffer_add(a : OptmetaevolutionBuffer, b : OptmetaevolutionBuffer) -> OptmetaevolutionBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_evolution_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_evolution_buffer_copy(s : OptmetaevolutionBuffer) -> OptmetaevolutionBuffer {
  let result = opt_meta_evolution_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_evolution_buffer_fill(s : OptmetaevolutionBuffer, v : Double) -> OptmetaevolutionBuffer {
  let result = opt_meta_evolution_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_evolution_buffer_min(s : OptmetaevolutionBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_evolution_buffer_max(s : OptmetaevolutionBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_evolution_buffer_to_string(s : OptmetaevolutionBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetaevolutionCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_evolution_cursor_make(size : Int) -> OptmetaevolutionCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_evolution_cursor_len(s : OptmetaevolutionCursor) -> Int { s.size }

pub fn opt_meta_evolution_cursor_get(s : OptmetaevolutionCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_evolution_cursor_set(s : OptmetaevolutionCursor, i : Int, v : Double) -> OptmetaevolutionCursor {
  let result = opt_meta_evolution_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_evolution_cursor_sum(s : OptmetaevolutionCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_evolution_cursor_mean(s : OptmetaevolutionCursor) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_evolution_cursor_sum(s) / s.size.to_double() }
}

pub fn opt_meta_evolution_cursor_scale(s : OptmetaevolutionCursor, f : Double) -> OptmetaevolutionCursor {
  let result = opt_meta_evolution_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_evolution_cursor_add(a : OptmetaevolutionCursor, b : OptmetaevolutionCursor) -> OptmetaevolutionCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_evolution_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_evolution_cursor_copy(s : OptmetaevolutionCursor) -> OptmetaevolutionCursor {
  let result = opt_meta_evolution_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_evolution_cursor_fill(s : OptmetaevolutionCursor, v : Double) -> OptmetaevolutionCursor {
  let result = opt_meta_evolution_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_evolution_cursor_min(s : OptmetaevolutionCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_evolution_cursor_max(s : OptmetaevolutionCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_evolution_cursor_to_string(s : OptmetaevolutionCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetaevolutionView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_evolution_view_make(size : Int) -> OptmetaevolutionView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_evolution_view_len(s : OptmetaevolutionView) -> Int { s.size }

pub fn opt_meta_evolution_view_get(s : OptmetaevolutionView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_evolution_view_set(s : OptmetaevolutionView, i : Int, v : Double) -> OptmetaevolutionView {
  let result = opt_meta_evolution_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_evolution_view_sum(s : OptmetaevolutionView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_evolution_view_mean(s : OptmetaevolutionView) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_evolution_view_sum(s) / s.size.to_double() }
}

pub fn opt_meta_evolution_view_scale(s : OptmetaevolutionView, f : Double) -> OptmetaevolutionView {
  let result = opt_meta_evolution_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_evolution_view_add(a : OptmetaevolutionView, b : OptmetaevolutionView) -> OptmetaevolutionView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_evolution_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_evolution_view_copy(s : OptmetaevolutionView) -> OptmetaevolutionView {
  let result = opt_meta_evolution_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_evolution_view_fill(s : OptmetaevolutionView, v : Double) -> OptmetaevolutionView {
  let result = opt_meta_evolution_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_evolution_view_min(s : OptmetaevolutionView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_evolution_view_max(s : OptmetaevolutionView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_evolution_view_to_string(s : OptmetaevolutionView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetaevolutionRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_evolution_range_make(size : Int) -> OptmetaevolutionRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_evolution_range_len(s : OptmetaevolutionRange) -> Int { s.size }

pub fn opt_meta_evolution_range_get(s : OptmetaevolutionRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_evolution_range_set(s : OptmetaevolutionRange, i : Int, v : Double) -> OptmetaevolutionRange {
  let result = opt_meta_evolution_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_evolution_range_sum(s : OptmetaevolutionRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_evolution_range_mean(s : OptmetaevolutionRange) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_evolution_range_sum(s) / s.size.to_double() }
}

pub fn opt_meta_evolution_range_scale(s : OptmetaevolutionRange, f : Double) -> OptmetaevolutionRange {
  let result = opt_meta_evolution_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_evolution_range_add(a : OptmetaevolutionRange, b : OptmetaevolutionRange) -> OptmetaevolutionRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_evolution_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_evolution_range_copy(s : OptmetaevolutionRange) -> OptmetaevolutionRange {
  let result = opt_meta_evolution_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_evolution_range_fill(s : OptmetaevolutionRange, v : Double) -> OptmetaevolutionRange {
  let result = opt_meta_evolution_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_evolution_range_min(s : OptmetaevolutionRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_evolution_range_max(s : OptmetaevolutionRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_evolution_range_to_string(s : OptmetaevolutionRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetaevolutionSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_evolution_slice_make(size : Int) -> OptmetaevolutionSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_evolution_slice_len(s : OptmetaevolutionSlice) -> Int { s.size }

pub fn opt_meta_evolution_slice_get(s : OptmetaevolutionSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_evolution_slice_set(s : OptmetaevolutionSlice, i : Int, v : Double) -> OptmetaevolutionSlice {
  let result = opt_meta_evolution_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_evolution_slice_sum(s : OptmetaevolutionSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_evolution_slice_mean(s : OptmetaevolutionSlice) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_evolution_slice_sum(s) / s.size.to_double() }
}

pub fn opt_meta_evolution_slice_scale(s : OptmetaevolutionSlice, f : Double) -> OptmetaevolutionSlice {
  let result = opt_meta_evolution_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_evolution_slice_add(a : OptmetaevolutionSlice, b : OptmetaevolutionSlice) -> OptmetaevolutionSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_evolution_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_evolution_slice_copy(s : OptmetaevolutionSlice) -> OptmetaevolutionSlice {
  let result = opt_meta_evolution_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_evolution_slice_fill(s : OptmetaevolutionSlice, v : Double) -> OptmetaevolutionSlice {
  let result = opt_meta_evolution_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_evolution_slice_min(s : OptmetaevolutionSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_evolution_slice_max(s : OptmetaevolutionSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_evolution_slice_to_string(s : OptmetaevolutionSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn opt_meta_evolution_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_evolution_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_evolution_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_evolution_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_evolution_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_evolution_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_evolution_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_evolution_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_evolution_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_evolution_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_evolution_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_evolution_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_evolution_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_evolution_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_evolution_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_evolution_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_evolution_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_evolution_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_evolution_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_evolution_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_evolution_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_evolution_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_evolution_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_evolution_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_evolution_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}


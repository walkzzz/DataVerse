///===
/// extcore/opt_meta_differential

pub(all) struct OptmetadifferentialPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn opt_meta_differential_make_point(x : Double, y : Double) -> OptmetadifferentialPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn opt_meta_differential_make_point3(x : Double, y : Double, z : Double) -> OptmetadifferentialPoint {
  { x, y, z, label: 0 }
}

pub fn opt_meta_differential_point_x(pt : OptmetadifferentialPoint) -> Double { pt.x }

pub fn opt_meta_differential_point_y(pt : OptmetadifferentialPoint) -> Double { pt.y }

pub fn opt_meta_differential_point_z(pt : OptmetadifferentialPoint) -> Double { pt.z }

pub fn opt_meta_differential_point_label(pt : OptmetadifferentialPoint) -> Int { pt.label }

pub fn opt_meta_differential_point_dist(a : OptmetadifferentialPoint, b : OptmetadifferentialPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  opt_meta_differential_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn opt_meta_differential_point_add(a : OptmetadifferentialPoint, b : OptmetadifferentialPoint) -> OptmetadifferentialPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn opt_meta_differential_point_sub(a : OptmetadifferentialPoint, b : OptmetadifferentialPoint) -> OptmetadifferentialPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn opt_meta_differential_point_scale(pt : OptmetadifferentialPoint, s : Double) -> OptmetadifferentialPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn opt_meta_differential_point_dot(a : OptmetadifferentialPoint, b : OptmetadifferentialPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn opt_meta_differential_point_cross(a : OptmetadifferentialPoint, b : OptmetadifferentialPoint) -> OptmetadifferentialPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn opt_meta_differential_point_norm(pt : OptmetadifferentialPoint) -> Double {
  opt_meta_differential_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn opt_meta_differential_point_normalize(pt : OptmetadifferentialPoint) -> OptmetadifferentialPoint {
  let n = opt_meta_differential_point_norm(pt)
  if n < 0.0000001 { pt } else { opt_meta_differential_point_scale(pt, 1.0 / n) }
}

pub fn opt_meta_differential_point_negate(pt : OptmetadifferentialPoint) -> OptmetadifferentialPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn opt_meta_differential_point_mid(a : OptmetadifferentialPoint, b : OptmetadifferentialPoint) -> OptmetadifferentialPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn opt_meta_differential_point_lerp(a : OptmetadifferentialPoint, b : OptmetadifferentialPoint, t : Double) -> OptmetadifferentialPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn opt_meta_differential_point_to_string(pt : OptmetadifferentialPoint) -> String {
  "(" + opt_meta_differential_dbl(pt.x) + ", " + opt_meta_differential_dbl(pt.y) + ", " + opt_meta_differential_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct OptmetadifferentialSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn opt_meta_differential_make_series(vals : Array[Double], name : String) -> OptmetadifferentialSeries {
  { vals, name, meta: 0 }
}

pub fn opt_meta_differential_series_len(s : OptmetadifferentialSeries) -> Int { s.vals.length() }

pub fn opt_meta_differential_series_sum(s : OptmetadifferentialSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn opt_meta_differential_series_mean(s : OptmetadifferentialSeries) -> Double {
  let n = opt_meta_differential_series_len(s)
  if n == 0 { 0.0 } else { opt_meta_differential_series_sum(s) / n.to_double() }
}

pub fn opt_meta_differential_series_min(s : OptmetadifferentialSeries) -> Double {
  let n = opt_meta_differential_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn opt_meta_differential_series_max(s : OptmetadifferentialSeries) -> Double {
  let n = opt_meta_differential_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn opt_meta_differential_series_range(s : OptmetadifferentialSeries) -> Double {
  opt_meta_differential_series_max(s) - opt_meta_differential_series_min(s)
}

pub fn opt_meta_differential_series_var(s : OptmetadifferentialSeries) -> Double {
  let n = opt_meta_differential_series_len(s)
  if n == 0 { 0.0 } else {
    let m = opt_meta_differential_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn opt_meta_differential_series_std(s : OptmetadifferentialSeries) -> Double { opt_meta_differential_sqrt(opt_meta_differential_series_var(s)) }

pub fn opt_meta_differential_series_median(s : OptmetadifferentialSeries) -> Double {
  let n = opt_meta_differential_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = opt_meta_differential_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn opt_meta_differential_series_scale(s : OptmetadifferentialSeries, f : Double) -> OptmetadifferentialSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = opt_meta_differential_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn opt_meta_differential_series_add(a : OptmetadifferentialSeries, b : OptmetadifferentialSeries) -> OptmetadifferentialSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = opt_meta_differential_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn opt_meta_differential_series_sub(a : OptmetadifferentialSeries, b : OptmetadifferentialSeries) -> OptmetadifferentialSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = opt_meta_differential_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn opt_meta_differential_series_normalize(s : OptmetadifferentialSeries) -> OptmetadifferentialSeries {
  let mn = opt_meta_differential_series_min(s)
  let mx = opt_meta_differential_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = opt_meta_differential_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn opt_meta_differential_series_cumsum(s : OptmetadifferentialSeries) -> OptmetadifferentialSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = opt_meta_differential_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn opt_meta_differential_series_to_string(s : OptmetadifferentialSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + opt_meta_differential_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct OptmetadifferentialMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn opt_meta_differential_make_matrix(rows : Int, cols : Int, val : Double) -> OptmetadifferentialMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn opt_meta_differential_matrix_identity(n : Int) -> OptmetadifferentialMatrix {
  let m = opt_meta_differential_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn opt_meta_differential_matrix_get(m : OptmetadifferentialMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn opt_meta_differential_matrix_transpose(m : OptmetadifferentialMatrix) -> OptmetadifferentialMatrix {
  let result = opt_meta_differential_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn opt_meta_differential_matrix_add(a : OptmetadifferentialMatrix, b : OptmetadifferentialMatrix) -> OptmetadifferentialMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = opt_meta_differential_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn opt_meta_differential_matrix_scale(m : OptmetadifferentialMatrix, s : Double) -> OptmetadifferentialMatrix {
  let result = opt_meta_differential_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn opt_meta_differential_matrix_multiply(a : OptmetadifferentialMatrix, b : OptmetadifferentialMatrix) -> OptmetadifferentialMatrix {
  if a.cols != b.rows { return opt_meta_differential_make_matrix(a.rows, b.cols, 0.0) }
  let result = opt_meta_differential_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn opt_meta_differential_matrix_trace(m : OptmetadifferentialMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn opt_meta_differential_matrix_det(m : OptmetadifferentialMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn opt_meta_differential_matrix_norm(m : OptmetadifferentialMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  opt_meta_differential_sqrt(sum)
}

pub fn opt_meta_differential_matrix_to_string(m : OptmetadifferentialMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + opt_meta_differential_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct OptmetadifferentialVector {
  comps : Array[Double]
  dim : Int
}

pub fn opt_meta_differential_make_vector(comps : Array[Double]) -> OptmetadifferentialVector {
  { comps, dim: comps.length() }
}

pub fn opt_meta_differential_vector_zero(dim : Int) -> OptmetadifferentialVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn opt_meta_differential_vector_add(a : OptmetadifferentialVector, b : OptmetadifferentialVector) -> OptmetadifferentialVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = opt_meta_differential_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn opt_meta_differential_vector_sub(a : OptmetadifferentialVector, b : OptmetadifferentialVector) -> OptmetadifferentialVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = opt_meta_differential_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn opt_meta_differential_vector_scale(v : OptmetadifferentialVector, s : Double) -> OptmetadifferentialVector {
  let mut result = []
  for i in 0..<v.dim { result = opt_meta_differential_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn opt_meta_differential_vector_dot(a : OptmetadifferentialVector, b : OptmetadifferentialVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn opt_meta_differential_vector_norm(v : OptmetadifferentialVector) -> Double { opt_meta_differential_sqrt(opt_meta_differential_vector_dot(v, v)) }

pub fn opt_meta_differential_vector_normalize(v : OptmetadifferentialVector) -> OptmetadifferentialVector {
  let n = opt_meta_differential_vector_norm(v)
  if n < 0.0000001 { v } else { opt_meta_differential_vector_scale(v, 1.0 / n) }
}

pub fn opt_meta_differential_vector_dist(a : OptmetadifferentialVector, b : OptmetadifferentialVector) -> Double {
  opt_meta_differential_vector_norm(opt_meta_differential_vector_sub(a, b))
}

pub fn opt_meta_differential_vector_to_string(v : OptmetadifferentialVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + opt_meta_differential_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn opt_meta_differential_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn opt_meta_differential_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = opt_meta_differential_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn opt_meta_differential_std(data : Array[Double]) -> Double { opt_meta_differential_sqrt(opt_meta_differential_var(data)) }

pub fn opt_meta_differential_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = opt_meta_differential_mean(a); let mb = opt_meta_differential_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn opt_meta_differential_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = opt_meta_differential_std(a); let sb = opt_meta_differential_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { opt_meta_differential_cov(a, b) / (sa * sb) }
}

pub fn opt_meta_differential_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = opt_meta_differential_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn opt_meta_differential_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn opt_meta_differential_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn opt_meta_differential_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  opt_meta_differential_sqrt(opt_meta_differential_mse(pred, labels))
}

pub fn opt_meta_differential_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + opt_meta_differential_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn opt_meta_differential_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = opt_meta_differential_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn opt_meta_differential_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn opt_meta_differential_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn opt_meta_differential_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = opt_meta_differential_precision(pred, labels, pos); let r = opt_meta_differential_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn opt_meta_differential_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn opt_meta_differential_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = opt_meta_differential_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn opt_meta_differential_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn opt_meta_differential_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn opt_meta_differential_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = opt_meta_differential_gcd(a, b)
    (a / g) * b
  }
}

pub fn opt_meta_differential_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn opt_meta_differential_fibonacci(n : Int) -> Int {
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

pub fn opt_meta_differential_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = opt_meta_differential_min(data); let mx = opt_meta_differential_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn opt_meta_differential_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = opt_meta_differential_mean(data); let sd = opt_meta_differential_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn opt_meta_differential_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn opt_meta_differential_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn opt_meta_differential_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn opt_meta_differential_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn opt_meta_differential_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn opt_meta_differential_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn opt_meta_differential_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn opt_meta_differential_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn opt_meta_differential_dbl(x : Double) -> String {
  let i = if x >= 0.0 { opt_meta_differential_int(x) } else { -opt_meta_differential_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { opt_meta_differential_int(f * 1000000.0) } else { opt_meta_differential_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn opt_meta_differential_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn opt_meta_differential_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct OptmetadifferentialFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_differential_frame_make(size : Int) -> OptmetadifferentialFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_differential_frame_len(s : OptmetadifferentialFrame) -> Int { s.size }

pub fn opt_meta_differential_frame_get(s : OptmetadifferentialFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_differential_frame_set(s : OptmetadifferentialFrame, i : Int, v : Double) -> OptmetadifferentialFrame {
  let result = opt_meta_differential_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_differential_frame_sum(s : OptmetadifferentialFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_differential_frame_mean(s : OptmetadifferentialFrame) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_differential_frame_sum(s) / s.size.to_double() }
}

pub fn opt_meta_differential_frame_scale(s : OptmetadifferentialFrame, f : Double) -> OptmetadifferentialFrame {
  let result = opt_meta_differential_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_differential_frame_add(a : OptmetadifferentialFrame, b : OptmetadifferentialFrame) -> OptmetadifferentialFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_differential_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_differential_frame_copy(s : OptmetadifferentialFrame) -> OptmetadifferentialFrame {
  let result = opt_meta_differential_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_differential_frame_fill(s : OptmetadifferentialFrame, v : Double) -> OptmetadifferentialFrame {
  let result = opt_meta_differential_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_differential_frame_min(s : OptmetadifferentialFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_differential_frame_max(s : OptmetadifferentialFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_differential_frame_to_string(s : OptmetadifferentialFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetadifferentialTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_differential_table_make(size : Int) -> OptmetadifferentialTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_differential_table_len(s : OptmetadifferentialTable) -> Int { s.size }

pub fn opt_meta_differential_table_get(s : OptmetadifferentialTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_differential_table_set(s : OptmetadifferentialTable, i : Int, v : Double) -> OptmetadifferentialTable {
  let result = opt_meta_differential_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_differential_table_sum(s : OptmetadifferentialTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_differential_table_mean(s : OptmetadifferentialTable) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_differential_table_sum(s) / s.size.to_double() }
}

pub fn opt_meta_differential_table_scale(s : OptmetadifferentialTable, f : Double) -> OptmetadifferentialTable {
  let result = opt_meta_differential_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_differential_table_add(a : OptmetadifferentialTable, b : OptmetadifferentialTable) -> OptmetadifferentialTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_differential_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_differential_table_copy(s : OptmetadifferentialTable) -> OptmetadifferentialTable {
  let result = opt_meta_differential_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_differential_table_fill(s : OptmetadifferentialTable, v : Double) -> OptmetadifferentialTable {
  let result = opt_meta_differential_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_differential_table_min(s : OptmetadifferentialTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_differential_table_max(s : OptmetadifferentialTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_differential_table_to_string(s : OptmetadifferentialTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetadifferentialGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_differential_graphn_make(size : Int) -> OptmetadifferentialGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_differential_graphn_len(s : OptmetadifferentialGraphN) -> Int { s.size }

pub fn opt_meta_differential_graphn_get(s : OptmetadifferentialGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_differential_graphn_set(s : OptmetadifferentialGraphN, i : Int, v : Double) -> OptmetadifferentialGraphN {
  let result = opt_meta_differential_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_differential_graphn_sum(s : OptmetadifferentialGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_differential_graphn_mean(s : OptmetadifferentialGraphN) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_differential_graphn_sum(s) / s.size.to_double() }
}

pub fn opt_meta_differential_graphn_scale(s : OptmetadifferentialGraphN, f : Double) -> OptmetadifferentialGraphN {
  let result = opt_meta_differential_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_differential_graphn_add(a : OptmetadifferentialGraphN, b : OptmetadifferentialGraphN) -> OptmetadifferentialGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_differential_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_differential_graphn_copy(s : OptmetadifferentialGraphN) -> OptmetadifferentialGraphN {
  let result = opt_meta_differential_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_differential_graphn_fill(s : OptmetadifferentialGraphN, v : Double) -> OptmetadifferentialGraphN {
  let result = opt_meta_differential_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_differential_graphn_min(s : OptmetadifferentialGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_differential_graphn_max(s : OptmetadifferentialGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_differential_graphn_to_string(s : OptmetadifferentialGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetadifferentialNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_differential_node_make(size : Int) -> OptmetadifferentialNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_differential_node_len(s : OptmetadifferentialNode) -> Int { s.size }

pub fn opt_meta_differential_node_get(s : OptmetadifferentialNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_differential_node_set(s : OptmetadifferentialNode, i : Int, v : Double) -> OptmetadifferentialNode {
  let result = opt_meta_differential_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_differential_node_sum(s : OptmetadifferentialNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_differential_node_mean(s : OptmetadifferentialNode) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_differential_node_sum(s) / s.size.to_double() }
}

pub fn opt_meta_differential_node_scale(s : OptmetadifferentialNode, f : Double) -> OptmetadifferentialNode {
  let result = opt_meta_differential_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_differential_node_add(a : OptmetadifferentialNode, b : OptmetadifferentialNode) -> OptmetadifferentialNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_differential_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_differential_node_copy(s : OptmetadifferentialNode) -> OptmetadifferentialNode {
  let result = opt_meta_differential_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_differential_node_fill(s : OptmetadifferentialNode, v : Double) -> OptmetadifferentialNode {
  let result = opt_meta_differential_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_differential_node_min(s : OptmetadifferentialNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_differential_node_max(s : OptmetadifferentialNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_differential_node_to_string(s : OptmetadifferentialNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetadifferentialEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_differential_edge_make(size : Int) -> OptmetadifferentialEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_differential_edge_len(s : OptmetadifferentialEdge) -> Int { s.size }

pub fn opt_meta_differential_edge_get(s : OptmetadifferentialEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_differential_edge_set(s : OptmetadifferentialEdge, i : Int, v : Double) -> OptmetadifferentialEdge {
  let result = opt_meta_differential_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_differential_edge_sum(s : OptmetadifferentialEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_differential_edge_mean(s : OptmetadifferentialEdge) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_differential_edge_sum(s) / s.size.to_double() }
}

pub fn opt_meta_differential_edge_scale(s : OptmetadifferentialEdge, f : Double) -> OptmetadifferentialEdge {
  let result = opt_meta_differential_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_differential_edge_add(a : OptmetadifferentialEdge, b : OptmetadifferentialEdge) -> OptmetadifferentialEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_differential_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_differential_edge_copy(s : OptmetadifferentialEdge) -> OptmetadifferentialEdge {
  let result = opt_meta_differential_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_differential_edge_fill(s : OptmetadifferentialEdge, v : Double) -> OptmetadifferentialEdge {
  let result = opt_meta_differential_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_differential_edge_min(s : OptmetadifferentialEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_differential_edge_max(s : OptmetadifferentialEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_differential_edge_to_string(s : OptmetadifferentialEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetadifferentialPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_differential_path_make(size : Int) -> OptmetadifferentialPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_differential_path_len(s : OptmetadifferentialPath) -> Int { s.size }

pub fn opt_meta_differential_path_get(s : OptmetadifferentialPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_differential_path_set(s : OptmetadifferentialPath, i : Int, v : Double) -> OptmetadifferentialPath {
  let result = opt_meta_differential_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_differential_path_sum(s : OptmetadifferentialPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_differential_path_mean(s : OptmetadifferentialPath) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_differential_path_sum(s) / s.size.to_double() }
}

pub fn opt_meta_differential_path_scale(s : OptmetadifferentialPath, f : Double) -> OptmetadifferentialPath {
  let result = opt_meta_differential_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_differential_path_add(a : OptmetadifferentialPath, b : OptmetadifferentialPath) -> OptmetadifferentialPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_differential_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_differential_path_copy(s : OptmetadifferentialPath) -> OptmetadifferentialPath {
  let result = opt_meta_differential_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_differential_path_fill(s : OptmetadifferentialPath, v : Double) -> OptmetadifferentialPath {
  let result = opt_meta_differential_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_differential_path_min(s : OptmetadifferentialPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_differential_path_max(s : OptmetadifferentialPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_differential_path_to_string(s : OptmetadifferentialPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetadifferentialCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_differential_cluster_make(size : Int) -> OptmetadifferentialCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_differential_cluster_len(s : OptmetadifferentialCluster) -> Int { s.size }

pub fn opt_meta_differential_cluster_get(s : OptmetadifferentialCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_differential_cluster_set(s : OptmetadifferentialCluster, i : Int, v : Double) -> OptmetadifferentialCluster {
  let result = opt_meta_differential_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_differential_cluster_sum(s : OptmetadifferentialCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_differential_cluster_mean(s : OptmetadifferentialCluster) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_differential_cluster_sum(s) / s.size.to_double() }
}

pub fn opt_meta_differential_cluster_scale(s : OptmetadifferentialCluster, f : Double) -> OptmetadifferentialCluster {
  let result = opt_meta_differential_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_differential_cluster_add(a : OptmetadifferentialCluster, b : OptmetadifferentialCluster) -> OptmetadifferentialCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_differential_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_differential_cluster_copy(s : OptmetadifferentialCluster) -> OptmetadifferentialCluster {
  let result = opt_meta_differential_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_differential_cluster_fill(s : OptmetadifferentialCluster, v : Double) -> OptmetadifferentialCluster {
  let result = opt_meta_differential_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_differential_cluster_min(s : OptmetadifferentialCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_differential_cluster_max(s : OptmetadifferentialCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_differential_cluster_to_string(s : OptmetadifferentialCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetadifferentialModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_differential_model_make(size : Int) -> OptmetadifferentialModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_differential_model_len(s : OptmetadifferentialModel) -> Int { s.size }

pub fn opt_meta_differential_model_get(s : OptmetadifferentialModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_differential_model_set(s : OptmetadifferentialModel, i : Int, v : Double) -> OptmetadifferentialModel {
  let result = opt_meta_differential_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_differential_model_sum(s : OptmetadifferentialModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_differential_model_mean(s : OptmetadifferentialModel) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_differential_model_sum(s) / s.size.to_double() }
}

pub fn opt_meta_differential_model_scale(s : OptmetadifferentialModel, f : Double) -> OptmetadifferentialModel {
  let result = opt_meta_differential_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_differential_model_add(a : OptmetadifferentialModel, b : OptmetadifferentialModel) -> OptmetadifferentialModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_differential_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_differential_model_copy(s : OptmetadifferentialModel) -> OptmetadifferentialModel {
  let result = opt_meta_differential_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_differential_model_fill(s : OptmetadifferentialModel, v : Double) -> OptmetadifferentialModel {
  let result = opt_meta_differential_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_differential_model_min(s : OptmetadifferentialModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_differential_model_max(s : OptmetadifferentialModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_differential_model_to_string(s : OptmetadifferentialModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetadifferentialLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_differential_layer_make(size : Int) -> OptmetadifferentialLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_differential_layer_len(s : OptmetadifferentialLayer) -> Int { s.size }

pub fn opt_meta_differential_layer_get(s : OptmetadifferentialLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_differential_layer_set(s : OptmetadifferentialLayer, i : Int, v : Double) -> OptmetadifferentialLayer {
  let result = opt_meta_differential_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_differential_layer_sum(s : OptmetadifferentialLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_differential_layer_mean(s : OptmetadifferentialLayer) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_differential_layer_sum(s) / s.size.to_double() }
}

pub fn opt_meta_differential_layer_scale(s : OptmetadifferentialLayer, f : Double) -> OptmetadifferentialLayer {
  let result = opt_meta_differential_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_differential_layer_add(a : OptmetadifferentialLayer, b : OptmetadifferentialLayer) -> OptmetadifferentialLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_differential_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_differential_layer_copy(s : OptmetadifferentialLayer) -> OptmetadifferentialLayer {
  let result = opt_meta_differential_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_differential_layer_fill(s : OptmetadifferentialLayer, v : Double) -> OptmetadifferentialLayer {
  let result = opt_meta_differential_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_differential_layer_min(s : OptmetadifferentialLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_differential_layer_max(s : OptmetadifferentialLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_differential_layer_to_string(s : OptmetadifferentialLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetadifferentialBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_differential_buffer_make(size : Int) -> OptmetadifferentialBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_differential_buffer_len(s : OptmetadifferentialBuffer) -> Int { s.size }

pub fn opt_meta_differential_buffer_get(s : OptmetadifferentialBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_differential_buffer_set(s : OptmetadifferentialBuffer, i : Int, v : Double) -> OptmetadifferentialBuffer {
  let result = opt_meta_differential_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_differential_buffer_sum(s : OptmetadifferentialBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_differential_buffer_mean(s : OptmetadifferentialBuffer) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_differential_buffer_sum(s) / s.size.to_double() }
}

pub fn opt_meta_differential_buffer_scale(s : OptmetadifferentialBuffer, f : Double) -> OptmetadifferentialBuffer {
  let result = opt_meta_differential_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_differential_buffer_add(a : OptmetadifferentialBuffer, b : OptmetadifferentialBuffer) -> OptmetadifferentialBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_differential_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_differential_buffer_copy(s : OptmetadifferentialBuffer) -> OptmetadifferentialBuffer {
  let result = opt_meta_differential_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_differential_buffer_fill(s : OptmetadifferentialBuffer, v : Double) -> OptmetadifferentialBuffer {
  let result = opt_meta_differential_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_differential_buffer_min(s : OptmetadifferentialBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_differential_buffer_max(s : OptmetadifferentialBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_differential_buffer_to_string(s : OptmetadifferentialBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetadifferentialCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_differential_cursor_make(size : Int) -> OptmetadifferentialCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_differential_cursor_len(s : OptmetadifferentialCursor) -> Int { s.size }

pub fn opt_meta_differential_cursor_get(s : OptmetadifferentialCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_differential_cursor_set(s : OptmetadifferentialCursor, i : Int, v : Double) -> OptmetadifferentialCursor {
  let result = opt_meta_differential_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_differential_cursor_sum(s : OptmetadifferentialCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_differential_cursor_mean(s : OptmetadifferentialCursor) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_differential_cursor_sum(s) / s.size.to_double() }
}

pub fn opt_meta_differential_cursor_scale(s : OptmetadifferentialCursor, f : Double) -> OptmetadifferentialCursor {
  let result = opt_meta_differential_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_differential_cursor_add(a : OptmetadifferentialCursor, b : OptmetadifferentialCursor) -> OptmetadifferentialCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_differential_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_differential_cursor_copy(s : OptmetadifferentialCursor) -> OptmetadifferentialCursor {
  let result = opt_meta_differential_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_differential_cursor_fill(s : OptmetadifferentialCursor, v : Double) -> OptmetadifferentialCursor {
  let result = opt_meta_differential_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_differential_cursor_min(s : OptmetadifferentialCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_differential_cursor_max(s : OptmetadifferentialCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_differential_cursor_to_string(s : OptmetadifferentialCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetadifferentialView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_differential_view_make(size : Int) -> OptmetadifferentialView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_differential_view_len(s : OptmetadifferentialView) -> Int { s.size }

pub fn opt_meta_differential_view_get(s : OptmetadifferentialView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_differential_view_set(s : OptmetadifferentialView, i : Int, v : Double) -> OptmetadifferentialView {
  let result = opt_meta_differential_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_differential_view_sum(s : OptmetadifferentialView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_differential_view_mean(s : OptmetadifferentialView) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_differential_view_sum(s) / s.size.to_double() }
}

pub fn opt_meta_differential_view_scale(s : OptmetadifferentialView, f : Double) -> OptmetadifferentialView {
  let result = opt_meta_differential_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_differential_view_add(a : OptmetadifferentialView, b : OptmetadifferentialView) -> OptmetadifferentialView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_differential_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_differential_view_copy(s : OptmetadifferentialView) -> OptmetadifferentialView {
  let result = opt_meta_differential_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_differential_view_fill(s : OptmetadifferentialView, v : Double) -> OptmetadifferentialView {
  let result = opt_meta_differential_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_differential_view_min(s : OptmetadifferentialView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_differential_view_max(s : OptmetadifferentialView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_differential_view_to_string(s : OptmetadifferentialView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetadifferentialRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_differential_range_make(size : Int) -> OptmetadifferentialRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_differential_range_len(s : OptmetadifferentialRange) -> Int { s.size }

pub fn opt_meta_differential_range_get(s : OptmetadifferentialRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_differential_range_set(s : OptmetadifferentialRange, i : Int, v : Double) -> OptmetadifferentialRange {
  let result = opt_meta_differential_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_differential_range_sum(s : OptmetadifferentialRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_differential_range_mean(s : OptmetadifferentialRange) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_differential_range_sum(s) / s.size.to_double() }
}

pub fn opt_meta_differential_range_scale(s : OptmetadifferentialRange, f : Double) -> OptmetadifferentialRange {
  let result = opt_meta_differential_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_differential_range_add(a : OptmetadifferentialRange, b : OptmetadifferentialRange) -> OptmetadifferentialRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_differential_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_differential_range_copy(s : OptmetadifferentialRange) -> OptmetadifferentialRange {
  let result = opt_meta_differential_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_differential_range_fill(s : OptmetadifferentialRange, v : Double) -> OptmetadifferentialRange {
  let result = opt_meta_differential_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_differential_range_min(s : OptmetadifferentialRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_differential_range_max(s : OptmetadifferentialRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_differential_range_to_string(s : OptmetadifferentialRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetadifferentialSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_differential_slice_make(size : Int) -> OptmetadifferentialSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_differential_slice_len(s : OptmetadifferentialSlice) -> Int { s.size }

pub fn opt_meta_differential_slice_get(s : OptmetadifferentialSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_differential_slice_set(s : OptmetadifferentialSlice, i : Int, v : Double) -> OptmetadifferentialSlice {
  let result = opt_meta_differential_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_differential_slice_sum(s : OptmetadifferentialSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_differential_slice_mean(s : OptmetadifferentialSlice) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_differential_slice_sum(s) / s.size.to_double() }
}

pub fn opt_meta_differential_slice_scale(s : OptmetadifferentialSlice, f : Double) -> OptmetadifferentialSlice {
  let result = opt_meta_differential_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_differential_slice_add(a : OptmetadifferentialSlice, b : OptmetadifferentialSlice) -> OptmetadifferentialSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_differential_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_differential_slice_copy(s : OptmetadifferentialSlice) -> OptmetadifferentialSlice {
  let result = opt_meta_differential_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_differential_slice_fill(s : OptmetadifferentialSlice, v : Double) -> OptmetadifferentialSlice {
  let result = opt_meta_differential_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_differential_slice_min(s : OptmetadifferentialSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_differential_slice_max(s : OptmetadifferentialSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_differential_slice_to_string(s : OptmetadifferentialSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn opt_meta_differential_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_differential_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_differential_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_differential_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_differential_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_differential_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_differential_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_differential_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_differential_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_differential_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_differential_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_differential_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_differential_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_differential_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_differential_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_differential_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_differential_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_differential_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_differential_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_differential_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_differential_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_differential_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_differential_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_differential_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_differential_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}


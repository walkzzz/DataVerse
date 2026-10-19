///===
/// extcore/opt_meta_sa

pub(all) struct OptmetasaPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn opt_meta_sa_make_point(x : Double, y : Double) -> OptmetasaPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn opt_meta_sa_make_point3(x : Double, y : Double, z : Double) -> OptmetasaPoint {
  { x, y, z, label: 0 }
}

pub fn opt_meta_sa_point_x(pt : OptmetasaPoint) -> Double { pt.x }

pub fn opt_meta_sa_point_y(pt : OptmetasaPoint) -> Double { pt.y }

pub fn opt_meta_sa_point_z(pt : OptmetasaPoint) -> Double { pt.z }

pub fn opt_meta_sa_point_label(pt : OptmetasaPoint) -> Int { pt.label }

pub fn opt_meta_sa_point_dist(a : OptmetasaPoint, b : OptmetasaPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  opt_meta_sa_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn opt_meta_sa_point_add(a : OptmetasaPoint, b : OptmetasaPoint) -> OptmetasaPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn opt_meta_sa_point_sub(a : OptmetasaPoint, b : OptmetasaPoint) -> OptmetasaPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn opt_meta_sa_point_scale(pt : OptmetasaPoint, s : Double) -> OptmetasaPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn opt_meta_sa_point_dot(a : OptmetasaPoint, b : OptmetasaPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn opt_meta_sa_point_cross(a : OptmetasaPoint, b : OptmetasaPoint) -> OptmetasaPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn opt_meta_sa_point_norm(pt : OptmetasaPoint) -> Double {
  opt_meta_sa_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn opt_meta_sa_point_normalize(pt : OptmetasaPoint) -> OptmetasaPoint {
  let n = opt_meta_sa_point_norm(pt)
  if n < 0.0000001 { pt } else { opt_meta_sa_point_scale(pt, 1.0 / n) }
}

pub fn opt_meta_sa_point_negate(pt : OptmetasaPoint) -> OptmetasaPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn opt_meta_sa_point_mid(a : OptmetasaPoint, b : OptmetasaPoint) -> OptmetasaPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn opt_meta_sa_point_lerp(a : OptmetasaPoint, b : OptmetasaPoint, t : Double) -> OptmetasaPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn opt_meta_sa_point_to_string(pt : OptmetasaPoint) -> String {
  "(" + opt_meta_sa_dbl(pt.x) + ", " + opt_meta_sa_dbl(pt.y) + ", " + opt_meta_sa_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct OptmetasaSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn opt_meta_sa_make_series(vals : Array[Double], name : String) -> OptmetasaSeries {
  { vals, name, meta: 0 }
}

pub fn opt_meta_sa_series_len(s : OptmetasaSeries) -> Int { s.vals.length() }

pub fn opt_meta_sa_series_sum(s : OptmetasaSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn opt_meta_sa_series_mean(s : OptmetasaSeries) -> Double {
  let n = opt_meta_sa_series_len(s)
  if n == 0 { 0.0 } else { opt_meta_sa_series_sum(s) / n.to_double() }
}

pub fn opt_meta_sa_series_min(s : OptmetasaSeries) -> Double {
  let n = opt_meta_sa_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn opt_meta_sa_series_max(s : OptmetasaSeries) -> Double {
  let n = opt_meta_sa_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn opt_meta_sa_series_range(s : OptmetasaSeries) -> Double {
  opt_meta_sa_series_max(s) - opt_meta_sa_series_min(s)
}

pub fn opt_meta_sa_series_var(s : OptmetasaSeries) -> Double {
  let n = opt_meta_sa_series_len(s)
  if n == 0 { 0.0 } else {
    let m = opt_meta_sa_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn opt_meta_sa_series_std(s : OptmetasaSeries) -> Double { opt_meta_sa_sqrt(opt_meta_sa_series_var(s)) }

pub fn opt_meta_sa_series_median(s : OptmetasaSeries) -> Double {
  let n = opt_meta_sa_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = opt_meta_sa_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn opt_meta_sa_series_scale(s : OptmetasaSeries, f : Double) -> OptmetasaSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = opt_meta_sa_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn opt_meta_sa_series_add(a : OptmetasaSeries, b : OptmetasaSeries) -> OptmetasaSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = opt_meta_sa_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn opt_meta_sa_series_sub(a : OptmetasaSeries, b : OptmetasaSeries) -> OptmetasaSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = opt_meta_sa_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn opt_meta_sa_series_normalize(s : OptmetasaSeries) -> OptmetasaSeries {
  let mn = opt_meta_sa_series_min(s)
  let mx = opt_meta_sa_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = opt_meta_sa_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn opt_meta_sa_series_cumsum(s : OptmetasaSeries) -> OptmetasaSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = opt_meta_sa_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn opt_meta_sa_series_to_string(s : OptmetasaSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + opt_meta_sa_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct OptmetasaMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn opt_meta_sa_make_matrix(rows : Int, cols : Int, val : Double) -> OptmetasaMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn opt_meta_sa_matrix_identity(n : Int) -> OptmetasaMatrix {
  let m = opt_meta_sa_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn opt_meta_sa_matrix_get(m : OptmetasaMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn opt_meta_sa_matrix_transpose(m : OptmetasaMatrix) -> OptmetasaMatrix {
  let result = opt_meta_sa_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn opt_meta_sa_matrix_add(a : OptmetasaMatrix, b : OptmetasaMatrix) -> OptmetasaMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = opt_meta_sa_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn opt_meta_sa_matrix_scale(m : OptmetasaMatrix, s : Double) -> OptmetasaMatrix {
  let result = opt_meta_sa_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn opt_meta_sa_matrix_multiply(a : OptmetasaMatrix, b : OptmetasaMatrix) -> OptmetasaMatrix {
  if a.cols != b.rows { return opt_meta_sa_make_matrix(a.rows, b.cols, 0.0) }
  let result = opt_meta_sa_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn opt_meta_sa_matrix_trace(m : OptmetasaMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn opt_meta_sa_matrix_det(m : OptmetasaMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn opt_meta_sa_matrix_norm(m : OptmetasaMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  opt_meta_sa_sqrt(sum)
}

pub fn opt_meta_sa_matrix_to_string(m : OptmetasaMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + opt_meta_sa_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct OptmetasaVector {
  comps : Array[Double]
  dim : Int
}

pub fn opt_meta_sa_make_vector(comps : Array[Double]) -> OptmetasaVector {
  { comps, dim: comps.length() }
}

pub fn opt_meta_sa_vector_zero(dim : Int) -> OptmetasaVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn opt_meta_sa_vector_add(a : OptmetasaVector, b : OptmetasaVector) -> OptmetasaVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = opt_meta_sa_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn opt_meta_sa_vector_sub(a : OptmetasaVector, b : OptmetasaVector) -> OptmetasaVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = opt_meta_sa_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn opt_meta_sa_vector_scale(v : OptmetasaVector, s : Double) -> OptmetasaVector {
  let mut result = []
  for i in 0..<v.dim { result = opt_meta_sa_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn opt_meta_sa_vector_dot(a : OptmetasaVector, b : OptmetasaVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn opt_meta_sa_vector_norm(v : OptmetasaVector) -> Double { opt_meta_sa_sqrt(opt_meta_sa_vector_dot(v, v)) }

pub fn opt_meta_sa_vector_normalize(v : OptmetasaVector) -> OptmetasaVector {
  let n = opt_meta_sa_vector_norm(v)
  if n < 0.0000001 { v } else { opt_meta_sa_vector_scale(v, 1.0 / n) }
}

pub fn opt_meta_sa_vector_dist(a : OptmetasaVector, b : OptmetasaVector) -> Double {
  opt_meta_sa_vector_norm(opt_meta_sa_vector_sub(a, b))
}

pub fn opt_meta_sa_vector_to_string(v : OptmetasaVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + opt_meta_sa_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn opt_meta_sa_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn opt_meta_sa_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = opt_meta_sa_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn opt_meta_sa_std(data : Array[Double]) -> Double { opt_meta_sa_sqrt(opt_meta_sa_var(data)) }

pub fn opt_meta_sa_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = opt_meta_sa_mean(a); let mb = opt_meta_sa_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn opt_meta_sa_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = opt_meta_sa_std(a); let sb = opt_meta_sa_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { opt_meta_sa_cov(a, b) / (sa * sb) }
}

pub fn opt_meta_sa_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = opt_meta_sa_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn opt_meta_sa_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn opt_meta_sa_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn opt_meta_sa_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  opt_meta_sa_sqrt(opt_meta_sa_mse(pred, labels))
}

pub fn opt_meta_sa_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + opt_meta_sa_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn opt_meta_sa_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = opt_meta_sa_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn opt_meta_sa_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn opt_meta_sa_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn opt_meta_sa_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = opt_meta_sa_precision(pred, labels, pos); let r = opt_meta_sa_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn opt_meta_sa_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn opt_meta_sa_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = opt_meta_sa_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn opt_meta_sa_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn opt_meta_sa_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn opt_meta_sa_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = opt_meta_sa_gcd(a, b)
    (a / g) * b
  }
}

pub fn opt_meta_sa_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn opt_meta_sa_fibonacci(n : Int) -> Int {
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

pub fn opt_meta_sa_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = opt_meta_sa_min(data); let mx = opt_meta_sa_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn opt_meta_sa_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = opt_meta_sa_mean(data); let sd = opt_meta_sa_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn opt_meta_sa_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn opt_meta_sa_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn opt_meta_sa_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn opt_meta_sa_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn opt_meta_sa_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn opt_meta_sa_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn opt_meta_sa_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn opt_meta_sa_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn opt_meta_sa_dbl(x : Double) -> String {
  let i = if x >= 0.0 { opt_meta_sa_int(x) } else { -opt_meta_sa_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { opt_meta_sa_int(f * 1000000.0) } else { opt_meta_sa_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn opt_meta_sa_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn opt_meta_sa_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct OptmetasaFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_sa_frame_make(size : Int) -> OptmetasaFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_sa_frame_len(s : OptmetasaFrame) -> Int { s.size }

pub fn opt_meta_sa_frame_get(s : OptmetasaFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_sa_frame_set(s : OptmetasaFrame, i : Int, v : Double) -> OptmetasaFrame {
  let result = opt_meta_sa_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_sa_frame_sum(s : OptmetasaFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_sa_frame_mean(s : OptmetasaFrame) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_sa_frame_sum(s) / s.size.to_double() }
}

pub fn opt_meta_sa_frame_scale(s : OptmetasaFrame, f : Double) -> OptmetasaFrame {
  let result = opt_meta_sa_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_sa_frame_add(a : OptmetasaFrame, b : OptmetasaFrame) -> OptmetasaFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_sa_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_sa_frame_copy(s : OptmetasaFrame) -> OptmetasaFrame {
  let result = opt_meta_sa_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_sa_frame_fill(s : OptmetasaFrame, v : Double) -> OptmetasaFrame {
  let result = opt_meta_sa_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_sa_frame_min(s : OptmetasaFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_sa_frame_max(s : OptmetasaFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_sa_frame_to_string(s : OptmetasaFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetasaTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_sa_table_make(size : Int) -> OptmetasaTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_sa_table_len(s : OptmetasaTable) -> Int { s.size }

pub fn opt_meta_sa_table_get(s : OptmetasaTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_sa_table_set(s : OptmetasaTable, i : Int, v : Double) -> OptmetasaTable {
  let result = opt_meta_sa_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_sa_table_sum(s : OptmetasaTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_sa_table_mean(s : OptmetasaTable) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_sa_table_sum(s) / s.size.to_double() }
}

pub fn opt_meta_sa_table_scale(s : OptmetasaTable, f : Double) -> OptmetasaTable {
  let result = opt_meta_sa_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_sa_table_add(a : OptmetasaTable, b : OptmetasaTable) -> OptmetasaTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_sa_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_sa_table_copy(s : OptmetasaTable) -> OptmetasaTable {
  let result = opt_meta_sa_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_sa_table_fill(s : OptmetasaTable, v : Double) -> OptmetasaTable {
  let result = opt_meta_sa_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_sa_table_min(s : OptmetasaTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_sa_table_max(s : OptmetasaTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_sa_table_to_string(s : OptmetasaTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetasaGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_sa_graphn_make(size : Int) -> OptmetasaGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_sa_graphn_len(s : OptmetasaGraphN) -> Int { s.size }

pub fn opt_meta_sa_graphn_get(s : OptmetasaGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_sa_graphn_set(s : OptmetasaGraphN, i : Int, v : Double) -> OptmetasaGraphN {
  let result = opt_meta_sa_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_sa_graphn_sum(s : OptmetasaGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_sa_graphn_mean(s : OptmetasaGraphN) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_sa_graphn_sum(s) / s.size.to_double() }
}

pub fn opt_meta_sa_graphn_scale(s : OptmetasaGraphN, f : Double) -> OptmetasaGraphN {
  let result = opt_meta_sa_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_sa_graphn_add(a : OptmetasaGraphN, b : OptmetasaGraphN) -> OptmetasaGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_sa_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_sa_graphn_copy(s : OptmetasaGraphN) -> OptmetasaGraphN {
  let result = opt_meta_sa_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_sa_graphn_fill(s : OptmetasaGraphN, v : Double) -> OptmetasaGraphN {
  let result = opt_meta_sa_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_sa_graphn_min(s : OptmetasaGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_sa_graphn_max(s : OptmetasaGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_sa_graphn_to_string(s : OptmetasaGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetasaNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_sa_node_make(size : Int) -> OptmetasaNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_sa_node_len(s : OptmetasaNode) -> Int { s.size }

pub fn opt_meta_sa_node_get(s : OptmetasaNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_sa_node_set(s : OptmetasaNode, i : Int, v : Double) -> OptmetasaNode {
  let result = opt_meta_sa_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_sa_node_sum(s : OptmetasaNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_sa_node_mean(s : OptmetasaNode) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_sa_node_sum(s) / s.size.to_double() }
}

pub fn opt_meta_sa_node_scale(s : OptmetasaNode, f : Double) -> OptmetasaNode {
  let result = opt_meta_sa_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_sa_node_add(a : OptmetasaNode, b : OptmetasaNode) -> OptmetasaNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_sa_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_sa_node_copy(s : OptmetasaNode) -> OptmetasaNode {
  let result = opt_meta_sa_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_sa_node_fill(s : OptmetasaNode, v : Double) -> OptmetasaNode {
  let result = opt_meta_sa_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_sa_node_min(s : OptmetasaNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_sa_node_max(s : OptmetasaNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_sa_node_to_string(s : OptmetasaNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetasaEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_sa_edge_make(size : Int) -> OptmetasaEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_sa_edge_len(s : OptmetasaEdge) -> Int { s.size }

pub fn opt_meta_sa_edge_get(s : OptmetasaEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_sa_edge_set(s : OptmetasaEdge, i : Int, v : Double) -> OptmetasaEdge {
  let result = opt_meta_sa_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_sa_edge_sum(s : OptmetasaEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_sa_edge_mean(s : OptmetasaEdge) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_sa_edge_sum(s) / s.size.to_double() }
}

pub fn opt_meta_sa_edge_scale(s : OptmetasaEdge, f : Double) -> OptmetasaEdge {
  let result = opt_meta_sa_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_sa_edge_add(a : OptmetasaEdge, b : OptmetasaEdge) -> OptmetasaEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_sa_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_sa_edge_copy(s : OptmetasaEdge) -> OptmetasaEdge {
  let result = opt_meta_sa_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_sa_edge_fill(s : OptmetasaEdge, v : Double) -> OptmetasaEdge {
  let result = opt_meta_sa_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_sa_edge_min(s : OptmetasaEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_sa_edge_max(s : OptmetasaEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_sa_edge_to_string(s : OptmetasaEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetasaPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_sa_path_make(size : Int) -> OptmetasaPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_sa_path_len(s : OptmetasaPath) -> Int { s.size }

pub fn opt_meta_sa_path_get(s : OptmetasaPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_sa_path_set(s : OptmetasaPath, i : Int, v : Double) -> OptmetasaPath {
  let result = opt_meta_sa_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_sa_path_sum(s : OptmetasaPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_sa_path_mean(s : OptmetasaPath) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_sa_path_sum(s) / s.size.to_double() }
}

pub fn opt_meta_sa_path_scale(s : OptmetasaPath, f : Double) -> OptmetasaPath {
  let result = opt_meta_sa_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_sa_path_add(a : OptmetasaPath, b : OptmetasaPath) -> OptmetasaPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_sa_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_sa_path_copy(s : OptmetasaPath) -> OptmetasaPath {
  let result = opt_meta_sa_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_sa_path_fill(s : OptmetasaPath, v : Double) -> OptmetasaPath {
  let result = opt_meta_sa_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_sa_path_min(s : OptmetasaPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_sa_path_max(s : OptmetasaPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_sa_path_to_string(s : OptmetasaPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetasaCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_sa_cluster_make(size : Int) -> OptmetasaCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_sa_cluster_len(s : OptmetasaCluster) -> Int { s.size }

pub fn opt_meta_sa_cluster_get(s : OptmetasaCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_sa_cluster_set(s : OptmetasaCluster, i : Int, v : Double) -> OptmetasaCluster {
  let result = opt_meta_sa_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_sa_cluster_sum(s : OptmetasaCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_sa_cluster_mean(s : OptmetasaCluster) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_sa_cluster_sum(s) / s.size.to_double() }
}

pub fn opt_meta_sa_cluster_scale(s : OptmetasaCluster, f : Double) -> OptmetasaCluster {
  let result = opt_meta_sa_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_sa_cluster_add(a : OptmetasaCluster, b : OptmetasaCluster) -> OptmetasaCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_sa_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_sa_cluster_copy(s : OptmetasaCluster) -> OptmetasaCluster {
  let result = opt_meta_sa_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_sa_cluster_fill(s : OptmetasaCluster, v : Double) -> OptmetasaCluster {
  let result = opt_meta_sa_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_sa_cluster_min(s : OptmetasaCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_sa_cluster_max(s : OptmetasaCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_sa_cluster_to_string(s : OptmetasaCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetasaModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_sa_model_make(size : Int) -> OptmetasaModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_sa_model_len(s : OptmetasaModel) -> Int { s.size }

pub fn opt_meta_sa_model_get(s : OptmetasaModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_sa_model_set(s : OptmetasaModel, i : Int, v : Double) -> OptmetasaModel {
  let result = opt_meta_sa_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_sa_model_sum(s : OptmetasaModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_sa_model_mean(s : OptmetasaModel) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_sa_model_sum(s) / s.size.to_double() }
}

pub fn opt_meta_sa_model_scale(s : OptmetasaModel, f : Double) -> OptmetasaModel {
  let result = opt_meta_sa_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_sa_model_add(a : OptmetasaModel, b : OptmetasaModel) -> OptmetasaModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_sa_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_sa_model_copy(s : OptmetasaModel) -> OptmetasaModel {
  let result = opt_meta_sa_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_sa_model_fill(s : OptmetasaModel, v : Double) -> OptmetasaModel {
  let result = opt_meta_sa_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_sa_model_min(s : OptmetasaModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_sa_model_max(s : OptmetasaModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_sa_model_to_string(s : OptmetasaModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetasaLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_sa_layer_make(size : Int) -> OptmetasaLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_sa_layer_len(s : OptmetasaLayer) -> Int { s.size }

pub fn opt_meta_sa_layer_get(s : OptmetasaLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_sa_layer_set(s : OptmetasaLayer, i : Int, v : Double) -> OptmetasaLayer {
  let result = opt_meta_sa_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_sa_layer_sum(s : OptmetasaLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_sa_layer_mean(s : OptmetasaLayer) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_sa_layer_sum(s) / s.size.to_double() }
}

pub fn opt_meta_sa_layer_scale(s : OptmetasaLayer, f : Double) -> OptmetasaLayer {
  let result = opt_meta_sa_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_sa_layer_add(a : OptmetasaLayer, b : OptmetasaLayer) -> OptmetasaLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_sa_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_sa_layer_copy(s : OptmetasaLayer) -> OptmetasaLayer {
  let result = opt_meta_sa_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_sa_layer_fill(s : OptmetasaLayer, v : Double) -> OptmetasaLayer {
  let result = opt_meta_sa_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_sa_layer_min(s : OptmetasaLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_sa_layer_max(s : OptmetasaLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_sa_layer_to_string(s : OptmetasaLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetasaBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_sa_buffer_make(size : Int) -> OptmetasaBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_sa_buffer_len(s : OptmetasaBuffer) -> Int { s.size }

pub fn opt_meta_sa_buffer_get(s : OptmetasaBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_sa_buffer_set(s : OptmetasaBuffer, i : Int, v : Double) -> OptmetasaBuffer {
  let result = opt_meta_sa_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_sa_buffer_sum(s : OptmetasaBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_sa_buffer_mean(s : OptmetasaBuffer) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_sa_buffer_sum(s) / s.size.to_double() }
}

pub fn opt_meta_sa_buffer_scale(s : OptmetasaBuffer, f : Double) -> OptmetasaBuffer {
  let result = opt_meta_sa_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_sa_buffer_add(a : OptmetasaBuffer, b : OptmetasaBuffer) -> OptmetasaBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_sa_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_sa_buffer_copy(s : OptmetasaBuffer) -> OptmetasaBuffer {
  let result = opt_meta_sa_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_sa_buffer_fill(s : OptmetasaBuffer, v : Double) -> OptmetasaBuffer {
  let result = opt_meta_sa_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_sa_buffer_min(s : OptmetasaBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_sa_buffer_max(s : OptmetasaBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_sa_buffer_to_string(s : OptmetasaBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetasaCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_sa_cursor_make(size : Int) -> OptmetasaCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_sa_cursor_len(s : OptmetasaCursor) -> Int { s.size }

pub fn opt_meta_sa_cursor_get(s : OptmetasaCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_sa_cursor_set(s : OptmetasaCursor, i : Int, v : Double) -> OptmetasaCursor {
  let result = opt_meta_sa_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_sa_cursor_sum(s : OptmetasaCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_sa_cursor_mean(s : OptmetasaCursor) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_sa_cursor_sum(s) / s.size.to_double() }
}

pub fn opt_meta_sa_cursor_scale(s : OptmetasaCursor, f : Double) -> OptmetasaCursor {
  let result = opt_meta_sa_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_sa_cursor_add(a : OptmetasaCursor, b : OptmetasaCursor) -> OptmetasaCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_sa_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_sa_cursor_copy(s : OptmetasaCursor) -> OptmetasaCursor {
  let result = opt_meta_sa_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_sa_cursor_fill(s : OptmetasaCursor, v : Double) -> OptmetasaCursor {
  let result = opt_meta_sa_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_sa_cursor_min(s : OptmetasaCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_sa_cursor_max(s : OptmetasaCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_sa_cursor_to_string(s : OptmetasaCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetasaView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_sa_view_make(size : Int) -> OptmetasaView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_sa_view_len(s : OptmetasaView) -> Int { s.size }

pub fn opt_meta_sa_view_get(s : OptmetasaView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_sa_view_set(s : OptmetasaView, i : Int, v : Double) -> OptmetasaView {
  let result = opt_meta_sa_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_sa_view_sum(s : OptmetasaView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_sa_view_mean(s : OptmetasaView) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_sa_view_sum(s) / s.size.to_double() }
}

pub fn opt_meta_sa_view_scale(s : OptmetasaView, f : Double) -> OptmetasaView {
  let result = opt_meta_sa_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_sa_view_add(a : OptmetasaView, b : OptmetasaView) -> OptmetasaView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_sa_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_sa_view_copy(s : OptmetasaView) -> OptmetasaView {
  let result = opt_meta_sa_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_sa_view_fill(s : OptmetasaView, v : Double) -> OptmetasaView {
  let result = opt_meta_sa_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_sa_view_min(s : OptmetasaView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_sa_view_max(s : OptmetasaView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_sa_view_to_string(s : OptmetasaView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetasaRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_sa_range_make(size : Int) -> OptmetasaRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_sa_range_len(s : OptmetasaRange) -> Int { s.size }

pub fn opt_meta_sa_range_get(s : OptmetasaRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_sa_range_set(s : OptmetasaRange, i : Int, v : Double) -> OptmetasaRange {
  let result = opt_meta_sa_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_sa_range_sum(s : OptmetasaRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_sa_range_mean(s : OptmetasaRange) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_sa_range_sum(s) / s.size.to_double() }
}

pub fn opt_meta_sa_range_scale(s : OptmetasaRange, f : Double) -> OptmetasaRange {
  let result = opt_meta_sa_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_sa_range_add(a : OptmetasaRange, b : OptmetasaRange) -> OptmetasaRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_sa_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_sa_range_copy(s : OptmetasaRange) -> OptmetasaRange {
  let result = opt_meta_sa_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_sa_range_fill(s : OptmetasaRange, v : Double) -> OptmetasaRange {
  let result = opt_meta_sa_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_sa_range_min(s : OptmetasaRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_sa_range_max(s : OptmetasaRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_sa_range_to_string(s : OptmetasaRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetasaSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_sa_slice_make(size : Int) -> OptmetasaSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_sa_slice_len(s : OptmetasaSlice) -> Int { s.size }

pub fn opt_meta_sa_slice_get(s : OptmetasaSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_sa_slice_set(s : OptmetasaSlice, i : Int, v : Double) -> OptmetasaSlice {
  let result = opt_meta_sa_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_sa_slice_sum(s : OptmetasaSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_sa_slice_mean(s : OptmetasaSlice) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_sa_slice_sum(s) / s.size.to_double() }
}

pub fn opt_meta_sa_slice_scale(s : OptmetasaSlice, f : Double) -> OptmetasaSlice {
  let result = opt_meta_sa_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_sa_slice_add(a : OptmetasaSlice, b : OptmetasaSlice) -> OptmetasaSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_sa_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_sa_slice_copy(s : OptmetasaSlice) -> OptmetasaSlice {
  let result = opt_meta_sa_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_sa_slice_fill(s : OptmetasaSlice, v : Double) -> OptmetasaSlice {
  let result = opt_meta_sa_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_sa_slice_min(s : OptmetasaSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_sa_slice_max(s : OptmetasaSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_sa_slice_to_string(s : OptmetasaSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn opt_meta_sa_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_sa_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_sa_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_sa_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_sa_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_sa_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_sa_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_sa_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_sa_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_sa_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_sa_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_sa_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_sa_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_sa_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_sa_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_sa_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_sa_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_sa_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_sa_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_sa_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_sa_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_sa_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_sa_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_sa_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_sa_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}


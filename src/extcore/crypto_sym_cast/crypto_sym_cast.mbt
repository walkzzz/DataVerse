///===
/// extcore/crypto_sym_cast

pub(all) struct CryptosymcastPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn crypto_sym_cast_make_point(x : Double, y : Double) -> CryptosymcastPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn crypto_sym_cast_make_point3(x : Double, y : Double, z : Double) -> CryptosymcastPoint {
  { x, y, z, label: 0 }
}

pub fn crypto_sym_cast_point_x(pt : CryptosymcastPoint) -> Double { pt.x }

pub fn crypto_sym_cast_point_y(pt : CryptosymcastPoint) -> Double { pt.y }

pub fn crypto_sym_cast_point_z(pt : CryptosymcastPoint) -> Double { pt.z }

pub fn crypto_sym_cast_point_label(pt : CryptosymcastPoint) -> Int { pt.label }

pub fn crypto_sym_cast_point_dist(a : CryptosymcastPoint, b : CryptosymcastPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn crypto_sym_cast_point_add(a : CryptosymcastPoint, b : CryptosymcastPoint) -> CryptosymcastPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn crypto_sym_cast_point_sub(a : CryptosymcastPoint, b : CryptosymcastPoint) -> CryptosymcastPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn crypto_sym_cast_point_scale(pt : CryptosymcastPoint, s : Double) -> CryptosymcastPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn crypto_sym_cast_point_dot(a : CryptosymcastPoint, b : CryptosymcastPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn crypto_sym_cast_point_cross(a : CryptosymcastPoint, b : CryptosymcastPoint) -> CryptosymcastPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn crypto_sym_cast_point_norm(pt : CryptosymcastPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn crypto_sym_cast_point_normalize(pt : CryptosymcastPoint) -> CryptosymcastPoint {
  let n = crypto_sym_cast_point_norm(pt)
  if n < 0.0000001 { pt } else { crypto_sym_cast_point_scale(pt, 1.0 / n) }
}

pub fn crypto_sym_cast_point_negate(pt : CryptosymcastPoint) -> CryptosymcastPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn crypto_sym_cast_point_mid(a : CryptosymcastPoint, b : CryptosymcastPoint) -> CryptosymcastPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn crypto_sym_cast_point_lerp(a : CryptosymcastPoint, b : CryptosymcastPoint, t : Double) -> CryptosymcastPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn crypto_sym_cast_point_to_string(pt : CryptosymcastPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct CryptosymcastSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn crypto_sym_cast_make_series(vals : Array[Double], name : String) -> CryptosymcastSeries {
  { vals, name, meta: 0 }
}

pub fn crypto_sym_cast_series_len(s : CryptosymcastSeries) -> Int { s.vals.length() }

pub fn crypto_sym_cast_series_sum(s : CryptosymcastSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn crypto_sym_cast_series_mean(s : CryptosymcastSeries) -> Double {
  let n = crypto_sym_cast_series_len(s)
  if n == 0 { 0.0 } else { crypto_sym_cast_series_sum(s) / n.to_double() }
}

pub fn crypto_sym_cast_series_min(s : CryptosymcastSeries) -> Double {
  let n = crypto_sym_cast_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn crypto_sym_cast_series_max(s : CryptosymcastSeries) -> Double {
  let n = crypto_sym_cast_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn crypto_sym_cast_series_range(s : CryptosymcastSeries) -> Double {
  crypto_sym_cast_series_max(s) - crypto_sym_cast_series_min(s)
}

pub fn crypto_sym_cast_series_var(s : CryptosymcastSeries) -> Double {
  let n = crypto_sym_cast_series_len(s)
  if n == 0 { 0.0 } else {
    let m = crypto_sym_cast_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn crypto_sym_cast_series_std(s : CryptosymcastSeries) -> Double { @_common.sqrt(crypto_sym_cast_series_var(s)) }

pub fn crypto_sym_cast_series_median(s : CryptosymcastSeries) -> Double {
  let n = crypto_sym_cast_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = crypto_sym_cast_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn crypto_sym_cast_series_scale(s : CryptosymcastSeries, f : Double) -> CryptosymcastSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn crypto_sym_cast_series_add(a : CryptosymcastSeries, b : CryptosymcastSeries) -> CryptosymcastSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn crypto_sym_cast_series_sub(a : CryptosymcastSeries, b : CryptosymcastSeries) -> CryptosymcastSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn crypto_sym_cast_series_normalize(s : CryptosymcastSeries) -> CryptosymcastSeries {
  let mn = crypto_sym_cast_series_min(s)
  let mx = crypto_sym_cast_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn crypto_sym_cast_series_cumsum(s : CryptosymcastSeries) -> CryptosymcastSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn crypto_sym_cast_series_to_string(s : CryptosymcastSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct CryptosymcastMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn crypto_sym_cast_make_matrix(rows : Int, cols : Int, val : Double) -> CryptosymcastMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn crypto_sym_cast_matrix_identity(n : Int) -> CryptosymcastMatrix {
  let m = crypto_sym_cast_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn crypto_sym_cast_matrix_get(m : CryptosymcastMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn crypto_sym_cast_matrix_transpose(m : CryptosymcastMatrix) -> CryptosymcastMatrix {
  let result = crypto_sym_cast_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn crypto_sym_cast_matrix_add(a : CryptosymcastMatrix, b : CryptosymcastMatrix) -> CryptosymcastMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = crypto_sym_cast_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn crypto_sym_cast_matrix_scale(m : CryptosymcastMatrix, s : Double) -> CryptosymcastMatrix {
  let result = crypto_sym_cast_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn crypto_sym_cast_matrix_multiply(a : CryptosymcastMatrix, b : CryptosymcastMatrix) -> CryptosymcastMatrix {
  if a.cols != b.rows { return crypto_sym_cast_make_matrix(a.rows, b.cols, 0.0) }
  let result = crypto_sym_cast_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn crypto_sym_cast_matrix_trace(m : CryptosymcastMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn crypto_sym_cast_matrix_det(m : CryptosymcastMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn crypto_sym_cast_matrix_norm(m : CryptosymcastMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn crypto_sym_cast_matrix_to_string(m : CryptosymcastMatrix) -> String {
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

pub(all) struct CryptosymcastVector {
  comps : Array[Double]
  dim : Int
}

pub fn crypto_sym_cast_make_vector(comps : Array[Double]) -> CryptosymcastVector {
  { comps, dim: comps.length() }
}

pub fn crypto_sym_cast_vector_zero(dim : Int) -> CryptosymcastVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn crypto_sym_cast_vector_add(a : CryptosymcastVector, b : CryptosymcastVector) -> CryptosymcastVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn crypto_sym_cast_vector_sub(a : CryptosymcastVector, b : CryptosymcastVector) -> CryptosymcastVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn crypto_sym_cast_vector_scale(v : CryptosymcastVector, s : Double) -> CryptosymcastVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn crypto_sym_cast_vector_dot(a : CryptosymcastVector, b : CryptosymcastVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn crypto_sym_cast_vector_norm(v : CryptosymcastVector) -> Double { @_common.sqrt(crypto_sym_cast_vector_dot(v, v)) }

pub fn crypto_sym_cast_vector_normalize(v : CryptosymcastVector) -> CryptosymcastVector {
  let n = crypto_sym_cast_vector_norm(v)
  if n < 0.0000001 { v } else { crypto_sym_cast_vector_scale(v, 1.0 / n) }
}

pub fn crypto_sym_cast_vector_dist(a : CryptosymcastVector, b : CryptosymcastVector) -> Double {
  crypto_sym_cast_vector_norm(crypto_sym_cast_vector_sub(a, b))
}

pub fn crypto_sym_cast_vector_to_string(v : CryptosymcastVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn crypto_sym_cast_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn crypto_sym_cast_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = crypto_sym_cast_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn crypto_sym_cast_std(data : Array[Double]) -> Double { @_common.sqrt(crypto_sym_cast_var(data)) }

pub fn crypto_sym_cast_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = crypto_sym_cast_mean(a); let mb = crypto_sym_cast_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn crypto_sym_cast_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = crypto_sym_cast_std(a); let sb = crypto_sym_cast_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { crypto_sym_cast_cov(a, b) / (sa * sb) }
}

pub fn crypto_sym_cast_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = crypto_sym_cast_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn crypto_sym_cast_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn crypto_sym_cast_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn crypto_sym_cast_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(crypto_sym_cast_mse(pred, labels))
}

pub fn crypto_sym_cast_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn crypto_sym_cast_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = crypto_sym_cast_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn crypto_sym_cast_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn crypto_sym_cast_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn crypto_sym_cast_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = crypto_sym_cast_precision(pred, labels, pos); let r = crypto_sym_cast_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn crypto_sym_cast_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn crypto_sym_cast_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = crypto_sym_cast_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn crypto_sym_cast_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn crypto_sym_cast_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn crypto_sym_cast_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = crypto_sym_cast_gcd(a, b)
    (a / g) * b
  }
}

pub fn crypto_sym_cast_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn crypto_sym_cast_fibonacci(n : Int) -> Int {
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

pub fn crypto_sym_cast_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = crypto_sym_cast_min(data); let mx = crypto_sym_cast_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn crypto_sym_cast_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = crypto_sym_cast_mean(data); let sd = crypto_sym_cast_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn crypto_sym_cast_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn crypto_sym_cast_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn crypto_sym_cast_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn crypto_sym_cast_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn crypto_sym_cast_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn crypto_sym_cast_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct CryptosymcastFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_cast_frame_make(size : Int) -> CryptosymcastFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_cast_frame_len(s : CryptosymcastFrame) -> Int { s.size }

pub fn crypto_sym_cast_frame_get(s : CryptosymcastFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_cast_frame_set(s : CryptosymcastFrame, i : Int, v : Double) -> CryptosymcastFrame {
  let result = crypto_sym_cast_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_cast_frame_sum(s : CryptosymcastFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_cast_frame_mean(s : CryptosymcastFrame) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_cast_frame_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_cast_frame_scale(s : CryptosymcastFrame, f : Double) -> CryptosymcastFrame {
  let result = crypto_sym_cast_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_cast_frame_add(a : CryptosymcastFrame, b : CryptosymcastFrame) -> CryptosymcastFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_cast_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_cast_frame_copy(s : CryptosymcastFrame) -> CryptosymcastFrame {
  let result = crypto_sym_cast_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_cast_frame_fill(s : CryptosymcastFrame, v : Double) -> CryptosymcastFrame {
  let result = crypto_sym_cast_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_cast_frame_min(s : CryptosymcastFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_cast_frame_max(s : CryptosymcastFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_cast_frame_to_string(s : CryptosymcastFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymcastTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_cast_table_make(size : Int) -> CryptosymcastTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_cast_table_len(s : CryptosymcastTable) -> Int { s.size }

pub fn crypto_sym_cast_table_get(s : CryptosymcastTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_cast_table_set(s : CryptosymcastTable, i : Int, v : Double) -> CryptosymcastTable {
  let result = crypto_sym_cast_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_cast_table_sum(s : CryptosymcastTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_cast_table_mean(s : CryptosymcastTable) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_cast_table_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_cast_table_scale(s : CryptosymcastTable, f : Double) -> CryptosymcastTable {
  let result = crypto_sym_cast_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_cast_table_add(a : CryptosymcastTable, b : CryptosymcastTable) -> CryptosymcastTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_cast_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_cast_table_copy(s : CryptosymcastTable) -> CryptosymcastTable {
  let result = crypto_sym_cast_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_cast_table_fill(s : CryptosymcastTable, v : Double) -> CryptosymcastTable {
  let result = crypto_sym_cast_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_cast_table_min(s : CryptosymcastTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_cast_table_max(s : CryptosymcastTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_cast_table_to_string(s : CryptosymcastTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymcastGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_cast_graphn_make(size : Int) -> CryptosymcastGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_cast_graphn_len(s : CryptosymcastGraphN) -> Int { s.size }

pub fn crypto_sym_cast_graphn_get(s : CryptosymcastGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_cast_graphn_set(s : CryptosymcastGraphN, i : Int, v : Double) -> CryptosymcastGraphN {
  let result = crypto_sym_cast_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_cast_graphn_sum(s : CryptosymcastGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_cast_graphn_mean(s : CryptosymcastGraphN) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_cast_graphn_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_cast_graphn_scale(s : CryptosymcastGraphN, f : Double) -> CryptosymcastGraphN {
  let result = crypto_sym_cast_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_cast_graphn_add(a : CryptosymcastGraphN, b : CryptosymcastGraphN) -> CryptosymcastGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_cast_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_cast_graphn_copy(s : CryptosymcastGraphN) -> CryptosymcastGraphN {
  let result = crypto_sym_cast_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_cast_graphn_fill(s : CryptosymcastGraphN, v : Double) -> CryptosymcastGraphN {
  let result = crypto_sym_cast_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_cast_graphn_min(s : CryptosymcastGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_cast_graphn_max(s : CryptosymcastGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_cast_graphn_to_string(s : CryptosymcastGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymcastNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_cast_node_make(size : Int) -> CryptosymcastNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_cast_node_len(s : CryptosymcastNode) -> Int { s.size }

pub fn crypto_sym_cast_node_get(s : CryptosymcastNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_cast_node_set(s : CryptosymcastNode, i : Int, v : Double) -> CryptosymcastNode {
  let result = crypto_sym_cast_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_cast_node_sum(s : CryptosymcastNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_cast_node_mean(s : CryptosymcastNode) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_cast_node_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_cast_node_scale(s : CryptosymcastNode, f : Double) -> CryptosymcastNode {
  let result = crypto_sym_cast_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_cast_node_add(a : CryptosymcastNode, b : CryptosymcastNode) -> CryptosymcastNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_cast_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_cast_node_copy(s : CryptosymcastNode) -> CryptosymcastNode {
  let result = crypto_sym_cast_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_cast_node_fill(s : CryptosymcastNode, v : Double) -> CryptosymcastNode {
  let result = crypto_sym_cast_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_cast_node_min(s : CryptosymcastNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_cast_node_max(s : CryptosymcastNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_cast_node_to_string(s : CryptosymcastNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymcastEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_cast_edge_make(size : Int) -> CryptosymcastEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_cast_edge_len(s : CryptosymcastEdge) -> Int { s.size }

pub fn crypto_sym_cast_edge_get(s : CryptosymcastEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_cast_edge_set(s : CryptosymcastEdge, i : Int, v : Double) -> CryptosymcastEdge {
  let result = crypto_sym_cast_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_cast_edge_sum(s : CryptosymcastEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_cast_edge_mean(s : CryptosymcastEdge) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_cast_edge_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_cast_edge_scale(s : CryptosymcastEdge, f : Double) -> CryptosymcastEdge {
  let result = crypto_sym_cast_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_cast_edge_add(a : CryptosymcastEdge, b : CryptosymcastEdge) -> CryptosymcastEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_cast_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_cast_edge_copy(s : CryptosymcastEdge) -> CryptosymcastEdge {
  let result = crypto_sym_cast_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_cast_edge_fill(s : CryptosymcastEdge, v : Double) -> CryptosymcastEdge {
  let result = crypto_sym_cast_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_cast_edge_min(s : CryptosymcastEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_cast_edge_max(s : CryptosymcastEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_cast_edge_to_string(s : CryptosymcastEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymcastPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_cast_path_make(size : Int) -> CryptosymcastPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_cast_path_len(s : CryptosymcastPath) -> Int { s.size }

pub fn crypto_sym_cast_path_get(s : CryptosymcastPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_cast_path_set(s : CryptosymcastPath, i : Int, v : Double) -> CryptosymcastPath {
  let result = crypto_sym_cast_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_cast_path_sum(s : CryptosymcastPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_cast_path_mean(s : CryptosymcastPath) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_cast_path_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_cast_path_scale(s : CryptosymcastPath, f : Double) -> CryptosymcastPath {
  let result = crypto_sym_cast_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_cast_path_add(a : CryptosymcastPath, b : CryptosymcastPath) -> CryptosymcastPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_cast_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_cast_path_copy(s : CryptosymcastPath) -> CryptosymcastPath {
  let result = crypto_sym_cast_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_cast_path_fill(s : CryptosymcastPath, v : Double) -> CryptosymcastPath {
  let result = crypto_sym_cast_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_cast_path_min(s : CryptosymcastPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_cast_path_max(s : CryptosymcastPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_cast_path_to_string(s : CryptosymcastPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymcastCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_cast_cluster_make(size : Int) -> CryptosymcastCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_cast_cluster_len(s : CryptosymcastCluster) -> Int { s.size }

pub fn crypto_sym_cast_cluster_get(s : CryptosymcastCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_cast_cluster_set(s : CryptosymcastCluster, i : Int, v : Double) -> CryptosymcastCluster {
  let result = crypto_sym_cast_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_cast_cluster_sum(s : CryptosymcastCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_cast_cluster_mean(s : CryptosymcastCluster) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_cast_cluster_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_cast_cluster_scale(s : CryptosymcastCluster, f : Double) -> CryptosymcastCluster {
  let result = crypto_sym_cast_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_cast_cluster_add(a : CryptosymcastCluster, b : CryptosymcastCluster) -> CryptosymcastCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_cast_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_cast_cluster_copy(s : CryptosymcastCluster) -> CryptosymcastCluster {
  let result = crypto_sym_cast_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_cast_cluster_fill(s : CryptosymcastCluster, v : Double) -> CryptosymcastCluster {
  let result = crypto_sym_cast_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_cast_cluster_min(s : CryptosymcastCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_cast_cluster_max(s : CryptosymcastCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_cast_cluster_to_string(s : CryptosymcastCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymcastModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_cast_model_make(size : Int) -> CryptosymcastModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_cast_model_len(s : CryptosymcastModel) -> Int { s.size }

pub fn crypto_sym_cast_model_get(s : CryptosymcastModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_cast_model_set(s : CryptosymcastModel, i : Int, v : Double) -> CryptosymcastModel {
  let result = crypto_sym_cast_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_cast_model_sum(s : CryptosymcastModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_cast_model_mean(s : CryptosymcastModel) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_cast_model_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_cast_model_scale(s : CryptosymcastModel, f : Double) -> CryptosymcastModel {
  let result = crypto_sym_cast_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_cast_model_add(a : CryptosymcastModel, b : CryptosymcastModel) -> CryptosymcastModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_cast_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_cast_model_copy(s : CryptosymcastModel) -> CryptosymcastModel {
  let result = crypto_sym_cast_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_cast_model_fill(s : CryptosymcastModel, v : Double) -> CryptosymcastModel {
  let result = crypto_sym_cast_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_cast_model_min(s : CryptosymcastModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_cast_model_max(s : CryptosymcastModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_cast_model_to_string(s : CryptosymcastModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymcastLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_cast_layer_make(size : Int) -> CryptosymcastLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_cast_layer_len(s : CryptosymcastLayer) -> Int { s.size }

pub fn crypto_sym_cast_layer_get(s : CryptosymcastLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_cast_layer_set(s : CryptosymcastLayer, i : Int, v : Double) -> CryptosymcastLayer {
  let result = crypto_sym_cast_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_cast_layer_sum(s : CryptosymcastLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_cast_layer_mean(s : CryptosymcastLayer) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_cast_layer_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_cast_layer_scale(s : CryptosymcastLayer, f : Double) -> CryptosymcastLayer {
  let result = crypto_sym_cast_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_cast_layer_add(a : CryptosymcastLayer, b : CryptosymcastLayer) -> CryptosymcastLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_cast_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_cast_layer_copy(s : CryptosymcastLayer) -> CryptosymcastLayer {
  let result = crypto_sym_cast_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_cast_layer_fill(s : CryptosymcastLayer, v : Double) -> CryptosymcastLayer {
  let result = crypto_sym_cast_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_cast_layer_min(s : CryptosymcastLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_cast_layer_max(s : CryptosymcastLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_cast_layer_to_string(s : CryptosymcastLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymcastBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_cast_buffer_make(size : Int) -> CryptosymcastBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_cast_buffer_len(s : CryptosymcastBuffer) -> Int { s.size }

pub fn crypto_sym_cast_buffer_get(s : CryptosymcastBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_cast_buffer_set(s : CryptosymcastBuffer, i : Int, v : Double) -> CryptosymcastBuffer {
  let result = crypto_sym_cast_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_cast_buffer_sum(s : CryptosymcastBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_cast_buffer_mean(s : CryptosymcastBuffer) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_cast_buffer_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_cast_buffer_scale(s : CryptosymcastBuffer, f : Double) -> CryptosymcastBuffer {
  let result = crypto_sym_cast_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_cast_buffer_add(a : CryptosymcastBuffer, b : CryptosymcastBuffer) -> CryptosymcastBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_cast_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_cast_buffer_copy(s : CryptosymcastBuffer) -> CryptosymcastBuffer {
  let result = crypto_sym_cast_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_cast_buffer_fill(s : CryptosymcastBuffer, v : Double) -> CryptosymcastBuffer {
  let result = crypto_sym_cast_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_cast_buffer_min(s : CryptosymcastBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_cast_buffer_max(s : CryptosymcastBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_cast_buffer_to_string(s : CryptosymcastBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymcastCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_cast_cursor_make(size : Int) -> CryptosymcastCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_cast_cursor_len(s : CryptosymcastCursor) -> Int { s.size }

pub fn crypto_sym_cast_cursor_get(s : CryptosymcastCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_cast_cursor_set(s : CryptosymcastCursor, i : Int, v : Double) -> CryptosymcastCursor {
  let result = crypto_sym_cast_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_cast_cursor_sum(s : CryptosymcastCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_cast_cursor_mean(s : CryptosymcastCursor) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_cast_cursor_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_cast_cursor_scale(s : CryptosymcastCursor, f : Double) -> CryptosymcastCursor {
  let result = crypto_sym_cast_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_cast_cursor_add(a : CryptosymcastCursor, b : CryptosymcastCursor) -> CryptosymcastCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_cast_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_cast_cursor_copy(s : CryptosymcastCursor) -> CryptosymcastCursor {
  let result = crypto_sym_cast_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_cast_cursor_fill(s : CryptosymcastCursor, v : Double) -> CryptosymcastCursor {
  let result = crypto_sym_cast_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_cast_cursor_min(s : CryptosymcastCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_cast_cursor_max(s : CryptosymcastCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_cast_cursor_to_string(s : CryptosymcastCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymcastView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_cast_view_make(size : Int) -> CryptosymcastView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_cast_view_len(s : CryptosymcastView) -> Int { s.size }

pub fn crypto_sym_cast_view_get(s : CryptosymcastView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_cast_view_set(s : CryptosymcastView, i : Int, v : Double) -> CryptosymcastView {
  let result = crypto_sym_cast_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_cast_view_sum(s : CryptosymcastView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_cast_view_mean(s : CryptosymcastView) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_cast_view_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_cast_view_scale(s : CryptosymcastView, f : Double) -> CryptosymcastView {
  let result = crypto_sym_cast_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_cast_view_add(a : CryptosymcastView, b : CryptosymcastView) -> CryptosymcastView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_cast_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_cast_view_copy(s : CryptosymcastView) -> CryptosymcastView {
  let result = crypto_sym_cast_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_cast_view_fill(s : CryptosymcastView, v : Double) -> CryptosymcastView {
  let result = crypto_sym_cast_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_cast_view_min(s : CryptosymcastView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_cast_view_max(s : CryptosymcastView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_cast_view_to_string(s : CryptosymcastView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymcastRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_cast_range_make(size : Int) -> CryptosymcastRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_cast_range_len(s : CryptosymcastRange) -> Int { s.size }

pub fn crypto_sym_cast_range_get(s : CryptosymcastRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_cast_range_set(s : CryptosymcastRange, i : Int, v : Double) -> CryptosymcastRange {
  let result = crypto_sym_cast_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_cast_range_sum(s : CryptosymcastRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_cast_range_mean(s : CryptosymcastRange) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_cast_range_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_cast_range_scale(s : CryptosymcastRange, f : Double) -> CryptosymcastRange {
  let result = crypto_sym_cast_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_cast_range_add(a : CryptosymcastRange, b : CryptosymcastRange) -> CryptosymcastRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_cast_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_cast_range_copy(s : CryptosymcastRange) -> CryptosymcastRange {
  let result = crypto_sym_cast_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_cast_range_fill(s : CryptosymcastRange, v : Double) -> CryptosymcastRange {
  let result = crypto_sym_cast_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_cast_range_min(s : CryptosymcastRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_cast_range_max(s : CryptosymcastRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_cast_range_to_string(s : CryptosymcastRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymcastSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_cast_slice_make(size : Int) -> CryptosymcastSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_cast_slice_len(s : CryptosymcastSlice) -> Int { s.size }

pub fn crypto_sym_cast_slice_get(s : CryptosymcastSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_cast_slice_set(s : CryptosymcastSlice, i : Int, v : Double) -> CryptosymcastSlice {
  let result = crypto_sym_cast_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_cast_slice_sum(s : CryptosymcastSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_cast_slice_mean(s : CryptosymcastSlice) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_cast_slice_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_cast_slice_scale(s : CryptosymcastSlice, f : Double) -> CryptosymcastSlice {
  let result = crypto_sym_cast_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_cast_slice_add(a : CryptosymcastSlice, b : CryptosymcastSlice) -> CryptosymcastSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_cast_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_cast_slice_copy(s : CryptosymcastSlice) -> CryptosymcastSlice {
  let result = crypto_sym_cast_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_cast_slice_fill(s : CryptosymcastSlice, v : Double) -> CryptosymcastSlice {
  let result = crypto_sym_cast_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_cast_slice_min(s : CryptosymcastSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_cast_slice_max(s : CryptosymcastSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_cast_slice_to_string(s : CryptosymcastSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


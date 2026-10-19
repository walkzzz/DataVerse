///===
/// extcore/geo_buffer_multi

pub(all) struct GeobuffermultiPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_buffer_multi_make_point(x : Double, y : Double) -> GeobuffermultiPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_buffer_multi_make_point3(x : Double, y : Double, z : Double) -> GeobuffermultiPoint {
  { x, y, z, label: 0 }
}

pub fn geo_buffer_multi_point_x(pt : GeobuffermultiPoint) -> Double { pt.x }

pub fn geo_buffer_multi_point_y(pt : GeobuffermultiPoint) -> Double { pt.y }

pub fn geo_buffer_multi_point_z(pt : GeobuffermultiPoint) -> Double { pt.z }

pub fn geo_buffer_multi_point_label(pt : GeobuffermultiPoint) -> Int { pt.label }

pub fn geo_buffer_multi_point_dist(a : GeobuffermultiPoint, b : GeobuffermultiPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn geo_buffer_multi_point_add(a : GeobuffermultiPoint, b : GeobuffermultiPoint) -> GeobuffermultiPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn geo_buffer_multi_point_sub(a : GeobuffermultiPoint, b : GeobuffermultiPoint) -> GeobuffermultiPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn geo_buffer_multi_point_scale(pt : GeobuffermultiPoint, s : Double) -> GeobuffermultiPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn geo_buffer_multi_point_dot(a : GeobuffermultiPoint, b : GeobuffermultiPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn geo_buffer_multi_point_cross(a : GeobuffermultiPoint, b : GeobuffermultiPoint) -> GeobuffermultiPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn geo_buffer_multi_point_norm(pt : GeobuffermultiPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn geo_buffer_multi_point_normalize(pt : GeobuffermultiPoint) -> GeobuffermultiPoint {
  let n = geo_buffer_multi_point_norm(pt)
  if n < 0.0000001 { pt } else { geo_buffer_multi_point_scale(pt, 1.0 / n) }
}

pub fn geo_buffer_multi_point_negate(pt : GeobuffermultiPoint) -> GeobuffermultiPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn geo_buffer_multi_point_mid(a : GeobuffermultiPoint, b : GeobuffermultiPoint) -> GeobuffermultiPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn geo_buffer_multi_point_lerp(a : GeobuffermultiPoint, b : GeobuffermultiPoint, t : Double) -> GeobuffermultiPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn geo_buffer_multi_point_to_string(pt : GeobuffermultiPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct GeobuffermultiSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_buffer_multi_make_series(vals : Array[Double], name : String) -> GeobuffermultiSeries {
  { vals, name, meta: 0 }
}

pub fn geo_buffer_multi_series_len(s : GeobuffermultiSeries) -> Int { s.vals.length() }

pub fn geo_buffer_multi_series_sum(s : GeobuffermultiSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn geo_buffer_multi_series_mean(s : GeobuffermultiSeries) -> Double {
  let n = geo_buffer_multi_series_len(s)
  if n == 0 { 0.0 } else { geo_buffer_multi_series_sum(s) / n.to_double() }
}

pub fn geo_buffer_multi_series_min(s : GeobuffermultiSeries) -> Double {
  let n = geo_buffer_multi_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn geo_buffer_multi_series_max(s : GeobuffermultiSeries) -> Double {
  let n = geo_buffer_multi_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn geo_buffer_multi_series_range(s : GeobuffermultiSeries) -> Double {
  geo_buffer_multi_series_max(s) - geo_buffer_multi_series_min(s)
}

pub fn geo_buffer_multi_series_var(s : GeobuffermultiSeries) -> Double {
  let n = geo_buffer_multi_series_len(s)
  if n == 0 { 0.0 } else {
    let m = geo_buffer_multi_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn geo_buffer_multi_series_std(s : GeobuffermultiSeries) -> Double { @_common.sqrt(geo_buffer_multi_series_var(s)) }

pub fn geo_buffer_multi_series_median(s : GeobuffermultiSeries) -> Double {
  let n = geo_buffer_multi_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = geo_buffer_multi_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn geo_buffer_multi_series_scale(s : GeobuffermultiSeries, f : Double) -> GeobuffermultiSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn geo_buffer_multi_series_add(a : GeobuffermultiSeries, b : GeobuffermultiSeries) -> GeobuffermultiSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn geo_buffer_multi_series_sub(a : GeobuffermultiSeries, b : GeobuffermultiSeries) -> GeobuffermultiSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn geo_buffer_multi_series_normalize(s : GeobuffermultiSeries) -> GeobuffermultiSeries {
  let mn = geo_buffer_multi_series_min(s)
  let mx = geo_buffer_multi_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn geo_buffer_multi_series_cumsum(s : GeobuffermultiSeries) -> GeobuffermultiSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn geo_buffer_multi_series_to_string(s : GeobuffermultiSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeobuffermultiMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_buffer_multi_make_matrix(rows : Int, cols : Int, val : Double) -> GeobuffermultiMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn geo_buffer_multi_matrix_identity(n : Int) -> GeobuffermultiMatrix {
  let m = geo_buffer_multi_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn geo_buffer_multi_matrix_get(m : GeobuffermultiMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn geo_buffer_multi_matrix_transpose(m : GeobuffermultiMatrix) -> GeobuffermultiMatrix {
  let result = geo_buffer_multi_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn geo_buffer_multi_matrix_add(a : GeobuffermultiMatrix, b : GeobuffermultiMatrix) -> GeobuffermultiMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = geo_buffer_multi_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn geo_buffer_multi_matrix_scale(m : GeobuffermultiMatrix, s : Double) -> GeobuffermultiMatrix {
  let result = geo_buffer_multi_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn geo_buffer_multi_matrix_multiply(a : GeobuffermultiMatrix, b : GeobuffermultiMatrix) -> GeobuffermultiMatrix {
  if a.cols != b.rows { return geo_buffer_multi_make_matrix(a.rows, b.cols, 0.0) }
  let result = geo_buffer_multi_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn geo_buffer_multi_matrix_trace(m : GeobuffermultiMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn geo_buffer_multi_matrix_det(m : GeobuffermultiMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn geo_buffer_multi_matrix_norm(m : GeobuffermultiMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn geo_buffer_multi_matrix_to_string(m : GeobuffermultiMatrix) -> String {
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

pub(all) struct GeobuffermultiVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_buffer_multi_make_vector(comps : Array[Double]) -> GeobuffermultiVector {
  { comps, dim: comps.length() }
}

pub fn geo_buffer_multi_vector_zero(dim : Int) -> GeobuffermultiVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn geo_buffer_multi_vector_add(a : GeobuffermultiVector, b : GeobuffermultiVector) -> GeobuffermultiVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn geo_buffer_multi_vector_sub(a : GeobuffermultiVector, b : GeobuffermultiVector) -> GeobuffermultiVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn geo_buffer_multi_vector_scale(v : GeobuffermultiVector, s : Double) -> GeobuffermultiVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn geo_buffer_multi_vector_dot(a : GeobuffermultiVector, b : GeobuffermultiVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn geo_buffer_multi_vector_norm(v : GeobuffermultiVector) -> Double { @_common.sqrt(geo_buffer_multi_vector_dot(v, v)) }

pub fn geo_buffer_multi_vector_normalize(v : GeobuffermultiVector) -> GeobuffermultiVector {
  let n = geo_buffer_multi_vector_norm(v)
  if n < 0.0000001 { v } else { geo_buffer_multi_vector_scale(v, 1.0 / n) }
}

pub fn geo_buffer_multi_vector_dist(a : GeobuffermultiVector, b : GeobuffermultiVector) -> Double {
  geo_buffer_multi_vector_norm(geo_buffer_multi_vector_sub(a, b))
}

pub fn geo_buffer_multi_vector_to_string(v : GeobuffermultiVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn geo_buffer_multi_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn geo_buffer_multi_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = geo_buffer_multi_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn geo_buffer_multi_std(data : Array[Double]) -> Double { @_common.sqrt(geo_buffer_multi_var(data)) }

pub fn geo_buffer_multi_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = geo_buffer_multi_mean(a); let mb = geo_buffer_multi_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn geo_buffer_multi_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = geo_buffer_multi_std(a); let sb = geo_buffer_multi_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { geo_buffer_multi_cov(a, b) / (sa * sb) }
}

pub fn geo_buffer_multi_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = geo_buffer_multi_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn geo_buffer_multi_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn geo_buffer_multi_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn geo_buffer_multi_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(geo_buffer_multi_mse(pred, labels))
}

pub fn geo_buffer_multi_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn geo_buffer_multi_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = geo_buffer_multi_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn geo_buffer_multi_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn geo_buffer_multi_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn geo_buffer_multi_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = geo_buffer_multi_precision(pred, labels, pos); let r = geo_buffer_multi_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn geo_buffer_multi_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn geo_buffer_multi_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = geo_buffer_multi_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn geo_buffer_multi_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn geo_buffer_multi_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn geo_buffer_multi_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = geo_buffer_multi_gcd(a, b)
    (a / g) * b
  }
}

pub fn geo_buffer_multi_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn geo_buffer_multi_fibonacci(n : Int) -> Int {
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

pub fn geo_buffer_multi_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = geo_buffer_multi_min(data); let mx = geo_buffer_multi_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn geo_buffer_multi_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = geo_buffer_multi_mean(data); let sd = geo_buffer_multi_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn geo_buffer_multi_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn geo_buffer_multi_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn geo_buffer_multi_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn geo_buffer_multi_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn geo_buffer_multi_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn geo_buffer_multi_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct GeobuffermultiFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_multi_frame_make(size : Int) -> GeobuffermultiFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_multi_frame_len(s : GeobuffermultiFrame) -> Int { s.size }

pub fn geo_buffer_multi_frame_get(s : GeobuffermultiFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_multi_frame_set(s : GeobuffermultiFrame, i : Int, v : Double) -> GeobuffermultiFrame {
  let result = geo_buffer_multi_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_multi_frame_sum(s : GeobuffermultiFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_buffer_multi_frame_mean(s : GeobuffermultiFrame) -> Double {
  if s.size == 0 { 0.0 } else { geo_buffer_multi_frame_sum(s) / s.size.to_double() }
}

pub fn geo_buffer_multi_frame_scale(s : GeobuffermultiFrame, f : Double) -> GeobuffermultiFrame {
  let result = geo_buffer_multi_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_buffer_multi_frame_add(a : GeobuffermultiFrame, b : GeobuffermultiFrame) -> GeobuffermultiFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_buffer_multi_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_buffer_multi_frame_copy(s : GeobuffermultiFrame) -> GeobuffermultiFrame {
  let result = geo_buffer_multi_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_buffer_multi_frame_fill(s : GeobuffermultiFrame, v : Double) -> GeobuffermultiFrame {
  let result = geo_buffer_multi_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_multi_frame_min(s : GeobuffermultiFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_multi_frame_max(s : GeobuffermultiFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_multi_frame_to_string(s : GeobuffermultiFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobuffermultiTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_multi_table_make(size : Int) -> GeobuffermultiTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_multi_table_len(s : GeobuffermultiTable) -> Int { s.size }

pub fn geo_buffer_multi_table_get(s : GeobuffermultiTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_multi_table_set(s : GeobuffermultiTable, i : Int, v : Double) -> GeobuffermultiTable {
  let result = geo_buffer_multi_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_multi_table_sum(s : GeobuffermultiTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_buffer_multi_table_mean(s : GeobuffermultiTable) -> Double {
  if s.size == 0 { 0.0 } else { geo_buffer_multi_table_sum(s) / s.size.to_double() }
}

pub fn geo_buffer_multi_table_scale(s : GeobuffermultiTable, f : Double) -> GeobuffermultiTable {
  let result = geo_buffer_multi_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_buffer_multi_table_add(a : GeobuffermultiTable, b : GeobuffermultiTable) -> GeobuffermultiTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_buffer_multi_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_buffer_multi_table_copy(s : GeobuffermultiTable) -> GeobuffermultiTable {
  let result = geo_buffer_multi_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_buffer_multi_table_fill(s : GeobuffermultiTable, v : Double) -> GeobuffermultiTable {
  let result = geo_buffer_multi_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_multi_table_min(s : GeobuffermultiTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_multi_table_max(s : GeobuffermultiTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_multi_table_to_string(s : GeobuffermultiTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobuffermultiGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_multi_graphn_make(size : Int) -> GeobuffermultiGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_multi_graphn_len(s : GeobuffermultiGraphN) -> Int { s.size }

pub fn geo_buffer_multi_graphn_get(s : GeobuffermultiGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_multi_graphn_set(s : GeobuffermultiGraphN, i : Int, v : Double) -> GeobuffermultiGraphN {
  let result = geo_buffer_multi_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_multi_graphn_sum(s : GeobuffermultiGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_buffer_multi_graphn_mean(s : GeobuffermultiGraphN) -> Double {
  if s.size == 0 { 0.0 } else { geo_buffer_multi_graphn_sum(s) / s.size.to_double() }
}

pub fn geo_buffer_multi_graphn_scale(s : GeobuffermultiGraphN, f : Double) -> GeobuffermultiGraphN {
  let result = geo_buffer_multi_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_buffer_multi_graphn_add(a : GeobuffermultiGraphN, b : GeobuffermultiGraphN) -> GeobuffermultiGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_buffer_multi_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_buffer_multi_graphn_copy(s : GeobuffermultiGraphN) -> GeobuffermultiGraphN {
  let result = geo_buffer_multi_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_buffer_multi_graphn_fill(s : GeobuffermultiGraphN, v : Double) -> GeobuffermultiGraphN {
  let result = geo_buffer_multi_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_multi_graphn_min(s : GeobuffermultiGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_multi_graphn_max(s : GeobuffermultiGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_multi_graphn_to_string(s : GeobuffermultiGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobuffermultiNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_multi_node_make(size : Int) -> GeobuffermultiNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_multi_node_len(s : GeobuffermultiNode) -> Int { s.size }

pub fn geo_buffer_multi_node_get(s : GeobuffermultiNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_multi_node_set(s : GeobuffermultiNode, i : Int, v : Double) -> GeobuffermultiNode {
  let result = geo_buffer_multi_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_multi_node_sum(s : GeobuffermultiNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_buffer_multi_node_mean(s : GeobuffermultiNode) -> Double {
  if s.size == 0 { 0.0 } else { geo_buffer_multi_node_sum(s) / s.size.to_double() }
}

pub fn geo_buffer_multi_node_scale(s : GeobuffermultiNode, f : Double) -> GeobuffermultiNode {
  let result = geo_buffer_multi_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_buffer_multi_node_add(a : GeobuffermultiNode, b : GeobuffermultiNode) -> GeobuffermultiNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_buffer_multi_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_buffer_multi_node_copy(s : GeobuffermultiNode) -> GeobuffermultiNode {
  let result = geo_buffer_multi_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_buffer_multi_node_fill(s : GeobuffermultiNode, v : Double) -> GeobuffermultiNode {
  let result = geo_buffer_multi_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_multi_node_min(s : GeobuffermultiNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_multi_node_max(s : GeobuffermultiNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_multi_node_to_string(s : GeobuffermultiNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobuffermultiEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_multi_edge_make(size : Int) -> GeobuffermultiEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_multi_edge_len(s : GeobuffermultiEdge) -> Int { s.size }

pub fn geo_buffer_multi_edge_get(s : GeobuffermultiEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_multi_edge_set(s : GeobuffermultiEdge, i : Int, v : Double) -> GeobuffermultiEdge {
  let result = geo_buffer_multi_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_multi_edge_sum(s : GeobuffermultiEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_buffer_multi_edge_mean(s : GeobuffermultiEdge) -> Double {
  if s.size == 0 { 0.0 } else { geo_buffer_multi_edge_sum(s) / s.size.to_double() }
}

pub fn geo_buffer_multi_edge_scale(s : GeobuffermultiEdge, f : Double) -> GeobuffermultiEdge {
  let result = geo_buffer_multi_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_buffer_multi_edge_add(a : GeobuffermultiEdge, b : GeobuffermultiEdge) -> GeobuffermultiEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_buffer_multi_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_buffer_multi_edge_copy(s : GeobuffermultiEdge) -> GeobuffermultiEdge {
  let result = geo_buffer_multi_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_buffer_multi_edge_fill(s : GeobuffermultiEdge, v : Double) -> GeobuffermultiEdge {
  let result = geo_buffer_multi_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_multi_edge_min(s : GeobuffermultiEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_multi_edge_max(s : GeobuffermultiEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_multi_edge_to_string(s : GeobuffermultiEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobuffermultiPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_multi_path_make(size : Int) -> GeobuffermultiPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_multi_path_len(s : GeobuffermultiPath) -> Int { s.size }

pub fn geo_buffer_multi_path_get(s : GeobuffermultiPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_multi_path_set(s : GeobuffermultiPath, i : Int, v : Double) -> GeobuffermultiPath {
  let result = geo_buffer_multi_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_multi_path_sum(s : GeobuffermultiPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_buffer_multi_path_mean(s : GeobuffermultiPath) -> Double {
  if s.size == 0 { 0.0 } else { geo_buffer_multi_path_sum(s) / s.size.to_double() }
}

pub fn geo_buffer_multi_path_scale(s : GeobuffermultiPath, f : Double) -> GeobuffermultiPath {
  let result = geo_buffer_multi_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_buffer_multi_path_add(a : GeobuffermultiPath, b : GeobuffermultiPath) -> GeobuffermultiPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_buffer_multi_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_buffer_multi_path_copy(s : GeobuffermultiPath) -> GeobuffermultiPath {
  let result = geo_buffer_multi_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_buffer_multi_path_fill(s : GeobuffermultiPath, v : Double) -> GeobuffermultiPath {
  let result = geo_buffer_multi_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_multi_path_min(s : GeobuffermultiPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_multi_path_max(s : GeobuffermultiPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_multi_path_to_string(s : GeobuffermultiPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobuffermultiCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_multi_cluster_make(size : Int) -> GeobuffermultiCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_multi_cluster_len(s : GeobuffermultiCluster) -> Int { s.size }

pub fn geo_buffer_multi_cluster_get(s : GeobuffermultiCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_multi_cluster_set(s : GeobuffermultiCluster, i : Int, v : Double) -> GeobuffermultiCluster {
  let result = geo_buffer_multi_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_multi_cluster_sum(s : GeobuffermultiCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_buffer_multi_cluster_mean(s : GeobuffermultiCluster) -> Double {
  if s.size == 0 { 0.0 } else { geo_buffer_multi_cluster_sum(s) / s.size.to_double() }
}

pub fn geo_buffer_multi_cluster_scale(s : GeobuffermultiCluster, f : Double) -> GeobuffermultiCluster {
  let result = geo_buffer_multi_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_buffer_multi_cluster_add(a : GeobuffermultiCluster, b : GeobuffermultiCluster) -> GeobuffermultiCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_buffer_multi_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_buffer_multi_cluster_copy(s : GeobuffermultiCluster) -> GeobuffermultiCluster {
  let result = geo_buffer_multi_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_buffer_multi_cluster_fill(s : GeobuffermultiCluster, v : Double) -> GeobuffermultiCluster {
  let result = geo_buffer_multi_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_multi_cluster_min(s : GeobuffermultiCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_multi_cluster_max(s : GeobuffermultiCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_multi_cluster_to_string(s : GeobuffermultiCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobuffermultiModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_multi_model_make(size : Int) -> GeobuffermultiModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_multi_model_len(s : GeobuffermultiModel) -> Int { s.size }

pub fn geo_buffer_multi_model_get(s : GeobuffermultiModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_multi_model_set(s : GeobuffermultiModel, i : Int, v : Double) -> GeobuffermultiModel {
  let result = geo_buffer_multi_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_multi_model_sum(s : GeobuffermultiModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_buffer_multi_model_mean(s : GeobuffermultiModel) -> Double {
  if s.size == 0 { 0.0 } else { geo_buffer_multi_model_sum(s) / s.size.to_double() }
}

pub fn geo_buffer_multi_model_scale(s : GeobuffermultiModel, f : Double) -> GeobuffermultiModel {
  let result = geo_buffer_multi_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_buffer_multi_model_add(a : GeobuffermultiModel, b : GeobuffermultiModel) -> GeobuffermultiModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_buffer_multi_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_buffer_multi_model_copy(s : GeobuffermultiModel) -> GeobuffermultiModel {
  let result = geo_buffer_multi_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_buffer_multi_model_fill(s : GeobuffermultiModel, v : Double) -> GeobuffermultiModel {
  let result = geo_buffer_multi_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_multi_model_min(s : GeobuffermultiModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_multi_model_max(s : GeobuffermultiModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_multi_model_to_string(s : GeobuffermultiModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobuffermultiLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_multi_layer_make(size : Int) -> GeobuffermultiLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_multi_layer_len(s : GeobuffermultiLayer) -> Int { s.size }

pub fn geo_buffer_multi_layer_get(s : GeobuffermultiLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_multi_layer_set(s : GeobuffermultiLayer, i : Int, v : Double) -> GeobuffermultiLayer {
  let result = geo_buffer_multi_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_multi_layer_sum(s : GeobuffermultiLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_buffer_multi_layer_mean(s : GeobuffermultiLayer) -> Double {
  if s.size == 0 { 0.0 } else { geo_buffer_multi_layer_sum(s) / s.size.to_double() }
}

pub fn geo_buffer_multi_layer_scale(s : GeobuffermultiLayer, f : Double) -> GeobuffermultiLayer {
  let result = geo_buffer_multi_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_buffer_multi_layer_add(a : GeobuffermultiLayer, b : GeobuffermultiLayer) -> GeobuffermultiLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_buffer_multi_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_buffer_multi_layer_copy(s : GeobuffermultiLayer) -> GeobuffermultiLayer {
  let result = geo_buffer_multi_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_buffer_multi_layer_fill(s : GeobuffermultiLayer, v : Double) -> GeobuffermultiLayer {
  let result = geo_buffer_multi_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_multi_layer_min(s : GeobuffermultiLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_multi_layer_max(s : GeobuffermultiLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_multi_layer_to_string(s : GeobuffermultiLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobuffermultiBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_multi_buffer_make(size : Int) -> GeobuffermultiBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_multi_buffer_len(s : GeobuffermultiBuffer) -> Int { s.size }

pub fn geo_buffer_multi_buffer_get(s : GeobuffermultiBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_multi_buffer_set(s : GeobuffermultiBuffer, i : Int, v : Double) -> GeobuffermultiBuffer {
  let result = geo_buffer_multi_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_multi_buffer_sum(s : GeobuffermultiBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_buffer_multi_buffer_mean(s : GeobuffermultiBuffer) -> Double {
  if s.size == 0 { 0.0 } else { geo_buffer_multi_buffer_sum(s) / s.size.to_double() }
}

pub fn geo_buffer_multi_buffer_scale(s : GeobuffermultiBuffer, f : Double) -> GeobuffermultiBuffer {
  let result = geo_buffer_multi_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_buffer_multi_buffer_add(a : GeobuffermultiBuffer, b : GeobuffermultiBuffer) -> GeobuffermultiBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_buffer_multi_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_buffer_multi_buffer_copy(s : GeobuffermultiBuffer) -> GeobuffermultiBuffer {
  let result = geo_buffer_multi_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_buffer_multi_buffer_fill(s : GeobuffermultiBuffer, v : Double) -> GeobuffermultiBuffer {
  let result = geo_buffer_multi_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_multi_buffer_min(s : GeobuffermultiBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_multi_buffer_max(s : GeobuffermultiBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_multi_buffer_to_string(s : GeobuffermultiBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobuffermultiCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_multi_cursor_make(size : Int) -> GeobuffermultiCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_multi_cursor_len(s : GeobuffermultiCursor) -> Int { s.size }

pub fn geo_buffer_multi_cursor_get(s : GeobuffermultiCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_multi_cursor_set(s : GeobuffermultiCursor, i : Int, v : Double) -> GeobuffermultiCursor {
  let result = geo_buffer_multi_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_multi_cursor_sum(s : GeobuffermultiCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_buffer_multi_cursor_mean(s : GeobuffermultiCursor) -> Double {
  if s.size == 0 { 0.0 } else { geo_buffer_multi_cursor_sum(s) / s.size.to_double() }
}

pub fn geo_buffer_multi_cursor_scale(s : GeobuffermultiCursor, f : Double) -> GeobuffermultiCursor {
  let result = geo_buffer_multi_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_buffer_multi_cursor_add(a : GeobuffermultiCursor, b : GeobuffermultiCursor) -> GeobuffermultiCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_buffer_multi_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_buffer_multi_cursor_copy(s : GeobuffermultiCursor) -> GeobuffermultiCursor {
  let result = geo_buffer_multi_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_buffer_multi_cursor_fill(s : GeobuffermultiCursor, v : Double) -> GeobuffermultiCursor {
  let result = geo_buffer_multi_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_multi_cursor_min(s : GeobuffermultiCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_multi_cursor_max(s : GeobuffermultiCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_multi_cursor_to_string(s : GeobuffermultiCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobuffermultiView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_multi_view_make(size : Int) -> GeobuffermultiView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_multi_view_len(s : GeobuffermultiView) -> Int { s.size }

pub fn geo_buffer_multi_view_get(s : GeobuffermultiView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_multi_view_set(s : GeobuffermultiView, i : Int, v : Double) -> GeobuffermultiView {
  let result = geo_buffer_multi_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_multi_view_sum(s : GeobuffermultiView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_buffer_multi_view_mean(s : GeobuffermultiView) -> Double {
  if s.size == 0 { 0.0 } else { geo_buffer_multi_view_sum(s) / s.size.to_double() }
}

pub fn geo_buffer_multi_view_scale(s : GeobuffermultiView, f : Double) -> GeobuffermultiView {
  let result = geo_buffer_multi_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_buffer_multi_view_add(a : GeobuffermultiView, b : GeobuffermultiView) -> GeobuffermultiView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_buffer_multi_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_buffer_multi_view_copy(s : GeobuffermultiView) -> GeobuffermultiView {
  let result = geo_buffer_multi_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_buffer_multi_view_fill(s : GeobuffermultiView, v : Double) -> GeobuffermultiView {
  let result = geo_buffer_multi_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_multi_view_min(s : GeobuffermultiView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_multi_view_max(s : GeobuffermultiView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_multi_view_to_string(s : GeobuffermultiView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobuffermultiRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_multi_range_make(size : Int) -> GeobuffermultiRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_multi_range_len(s : GeobuffermultiRange) -> Int { s.size }

pub fn geo_buffer_multi_range_get(s : GeobuffermultiRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_multi_range_set(s : GeobuffermultiRange, i : Int, v : Double) -> GeobuffermultiRange {
  let result = geo_buffer_multi_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_multi_range_sum(s : GeobuffermultiRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_buffer_multi_range_mean(s : GeobuffermultiRange) -> Double {
  if s.size == 0 { 0.0 } else { geo_buffer_multi_range_sum(s) / s.size.to_double() }
}

pub fn geo_buffer_multi_range_scale(s : GeobuffermultiRange, f : Double) -> GeobuffermultiRange {
  let result = geo_buffer_multi_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_buffer_multi_range_add(a : GeobuffermultiRange, b : GeobuffermultiRange) -> GeobuffermultiRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_buffer_multi_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_buffer_multi_range_copy(s : GeobuffermultiRange) -> GeobuffermultiRange {
  let result = geo_buffer_multi_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_buffer_multi_range_fill(s : GeobuffermultiRange, v : Double) -> GeobuffermultiRange {
  let result = geo_buffer_multi_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_multi_range_min(s : GeobuffermultiRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_multi_range_max(s : GeobuffermultiRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_multi_range_to_string(s : GeobuffermultiRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobuffermultiSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_multi_slice_make(size : Int) -> GeobuffermultiSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_multi_slice_len(s : GeobuffermultiSlice) -> Int { s.size }

pub fn geo_buffer_multi_slice_get(s : GeobuffermultiSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_multi_slice_set(s : GeobuffermultiSlice, i : Int, v : Double) -> GeobuffermultiSlice {
  let result = geo_buffer_multi_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_multi_slice_sum(s : GeobuffermultiSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_buffer_multi_slice_mean(s : GeobuffermultiSlice) -> Double {
  if s.size == 0 { 0.0 } else { geo_buffer_multi_slice_sum(s) / s.size.to_double() }
}

pub fn geo_buffer_multi_slice_scale(s : GeobuffermultiSlice, f : Double) -> GeobuffermultiSlice {
  let result = geo_buffer_multi_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_buffer_multi_slice_add(a : GeobuffermultiSlice, b : GeobuffermultiSlice) -> GeobuffermultiSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_buffer_multi_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_buffer_multi_slice_copy(s : GeobuffermultiSlice) -> GeobuffermultiSlice {
  let result = geo_buffer_multi_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_buffer_multi_slice_fill(s : GeobuffermultiSlice, v : Double) -> GeobuffermultiSlice {
  let result = geo_buffer_multi_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_multi_slice_min(s : GeobuffermultiSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_multi_slice_max(s : GeobuffermultiSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_multi_slice_to_string(s : GeobuffermultiSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


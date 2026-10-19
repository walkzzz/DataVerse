///===
/// extcore/signal_transform_dct

pub(all) struct SignaltransformdctPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_transform_dct_make_point(x : Double, y : Double) -> SignaltransformdctPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_transform_dct_make_point3(x : Double, y : Double, z : Double) -> SignaltransformdctPoint {
  { x, y, z, label: 0 }
}

pub fn signal_transform_dct_point_x(pt : SignaltransformdctPoint) -> Double { pt.x }

pub fn signal_transform_dct_point_y(pt : SignaltransformdctPoint) -> Double { pt.y }

pub fn signal_transform_dct_point_z(pt : SignaltransformdctPoint) -> Double { pt.z }

pub fn signal_transform_dct_point_label(pt : SignaltransformdctPoint) -> Int { pt.label }

pub fn signal_transform_dct_point_dist(a : SignaltransformdctPoint, b : SignaltransformdctPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn signal_transform_dct_point_add(a : SignaltransformdctPoint, b : SignaltransformdctPoint) -> SignaltransformdctPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn signal_transform_dct_point_sub(a : SignaltransformdctPoint, b : SignaltransformdctPoint) -> SignaltransformdctPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn signal_transform_dct_point_scale(pt : SignaltransformdctPoint, s : Double) -> SignaltransformdctPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn signal_transform_dct_point_dot(a : SignaltransformdctPoint, b : SignaltransformdctPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn signal_transform_dct_point_cross(a : SignaltransformdctPoint, b : SignaltransformdctPoint) -> SignaltransformdctPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn signal_transform_dct_point_norm(pt : SignaltransformdctPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn signal_transform_dct_point_normalize(pt : SignaltransformdctPoint) -> SignaltransformdctPoint {
  let n = signal_transform_dct_point_norm(pt)
  if n < 0.0000001 { pt } else { signal_transform_dct_point_scale(pt, 1.0 / n) }
}

pub fn signal_transform_dct_point_negate(pt : SignaltransformdctPoint) -> SignaltransformdctPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn signal_transform_dct_point_mid(a : SignaltransformdctPoint, b : SignaltransformdctPoint) -> SignaltransformdctPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn signal_transform_dct_point_lerp(a : SignaltransformdctPoint, b : SignaltransformdctPoint, t : Double) -> SignaltransformdctPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn signal_transform_dct_point_to_string(pt : SignaltransformdctPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct SignaltransformdctSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_transform_dct_make_series(vals : Array[Double], name : String) -> SignaltransformdctSeries {
  { vals, name, meta: 0 }
}

pub fn signal_transform_dct_series_len(s : SignaltransformdctSeries) -> Int { s.vals.length() }

pub fn signal_transform_dct_series_sum(s : SignaltransformdctSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn signal_transform_dct_series_mean(s : SignaltransformdctSeries) -> Double {
  let n = signal_transform_dct_series_len(s)
  if n == 0 { 0.0 } else { signal_transform_dct_series_sum(s) / n.to_double() }
}

pub fn signal_transform_dct_series_min(s : SignaltransformdctSeries) -> Double {
  let n = signal_transform_dct_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn signal_transform_dct_series_max(s : SignaltransformdctSeries) -> Double {
  let n = signal_transform_dct_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn signal_transform_dct_series_range(s : SignaltransformdctSeries) -> Double {
  signal_transform_dct_series_max(s) - signal_transform_dct_series_min(s)
}

pub fn signal_transform_dct_series_var(s : SignaltransformdctSeries) -> Double {
  let n = signal_transform_dct_series_len(s)
  if n == 0 { 0.0 } else {
    let m = signal_transform_dct_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn signal_transform_dct_series_std(s : SignaltransformdctSeries) -> Double { @_common.sqrt(signal_transform_dct_series_var(s)) }

pub fn signal_transform_dct_series_median(s : SignaltransformdctSeries) -> Double {
  let n = signal_transform_dct_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = signal_transform_dct_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn signal_transform_dct_series_scale(s : SignaltransformdctSeries, f : Double) -> SignaltransformdctSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn signal_transform_dct_series_add(a : SignaltransformdctSeries, b : SignaltransformdctSeries) -> SignaltransformdctSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn signal_transform_dct_series_sub(a : SignaltransformdctSeries, b : SignaltransformdctSeries) -> SignaltransformdctSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn signal_transform_dct_series_normalize(s : SignaltransformdctSeries) -> SignaltransformdctSeries {
  let mn = signal_transform_dct_series_min(s)
  let mx = signal_transform_dct_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn signal_transform_dct_series_cumsum(s : SignaltransformdctSeries) -> SignaltransformdctSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn signal_transform_dct_series_to_string(s : SignaltransformdctSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignaltransformdctMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_transform_dct_make_matrix(rows : Int, cols : Int, val : Double) -> SignaltransformdctMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn signal_transform_dct_matrix_identity(n : Int) -> SignaltransformdctMatrix {
  let m = signal_transform_dct_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn signal_transform_dct_matrix_get(m : SignaltransformdctMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn signal_transform_dct_matrix_transpose(m : SignaltransformdctMatrix) -> SignaltransformdctMatrix {
  let result = signal_transform_dct_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn signal_transform_dct_matrix_add(a : SignaltransformdctMatrix, b : SignaltransformdctMatrix) -> SignaltransformdctMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = signal_transform_dct_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn signal_transform_dct_matrix_scale(m : SignaltransformdctMatrix, s : Double) -> SignaltransformdctMatrix {
  let result = signal_transform_dct_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn signal_transform_dct_matrix_multiply(a : SignaltransformdctMatrix, b : SignaltransformdctMatrix) -> SignaltransformdctMatrix {
  if a.cols != b.rows { return signal_transform_dct_make_matrix(a.rows, b.cols, 0.0) }
  let result = signal_transform_dct_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn signal_transform_dct_matrix_trace(m : SignaltransformdctMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn signal_transform_dct_matrix_det(m : SignaltransformdctMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn signal_transform_dct_matrix_norm(m : SignaltransformdctMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn signal_transform_dct_matrix_to_string(m : SignaltransformdctMatrix) -> String {
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

pub(all) struct SignaltransformdctVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_transform_dct_make_vector(comps : Array[Double]) -> SignaltransformdctVector {
  { comps, dim: comps.length() }
}

pub fn signal_transform_dct_vector_zero(dim : Int) -> SignaltransformdctVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn signal_transform_dct_vector_add(a : SignaltransformdctVector, b : SignaltransformdctVector) -> SignaltransformdctVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn signal_transform_dct_vector_sub(a : SignaltransformdctVector, b : SignaltransformdctVector) -> SignaltransformdctVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn signal_transform_dct_vector_scale(v : SignaltransformdctVector, s : Double) -> SignaltransformdctVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn signal_transform_dct_vector_dot(a : SignaltransformdctVector, b : SignaltransformdctVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn signal_transform_dct_vector_norm(v : SignaltransformdctVector) -> Double { @_common.sqrt(signal_transform_dct_vector_dot(v, v)) }

pub fn signal_transform_dct_vector_normalize(v : SignaltransformdctVector) -> SignaltransformdctVector {
  let n = signal_transform_dct_vector_norm(v)
  if n < 0.0000001 { v } else { signal_transform_dct_vector_scale(v, 1.0 / n) }
}

pub fn signal_transform_dct_vector_dist(a : SignaltransformdctVector, b : SignaltransformdctVector) -> Double {
  signal_transform_dct_vector_norm(signal_transform_dct_vector_sub(a, b))
}

pub fn signal_transform_dct_vector_to_string(v : SignaltransformdctVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn signal_transform_dct_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn signal_transform_dct_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = signal_transform_dct_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn signal_transform_dct_std(data : Array[Double]) -> Double { @_common.sqrt(signal_transform_dct_var(data)) }

pub fn signal_transform_dct_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = signal_transform_dct_mean(a); let mb = signal_transform_dct_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn signal_transform_dct_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = signal_transform_dct_std(a); let sb = signal_transform_dct_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { signal_transform_dct_cov(a, b) / (sa * sb) }
}

pub fn signal_transform_dct_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = signal_transform_dct_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn signal_transform_dct_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn signal_transform_dct_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn signal_transform_dct_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(signal_transform_dct_mse(pred, labels))
}

pub fn signal_transform_dct_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn signal_transform_dct_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = signal_transform_dct_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn signal_transform_dct_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn signal_transform_dct_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn signal_transform_dct_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = signal_transform_dct_precision(pred, labels, pos); let r = signal_transform_dct_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn signal_transform_dct_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn signal_transform_dct_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = signal_transform_dct_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn signal_transform_dct_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn signal_transform_dct_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn signal_transform_dct_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = signal_transform_dct_gcd(a, b)
    (a / g) * b
  }
}

pub fn signal_transform_dct_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn signal_transform_dct_fibonacci(n : Int) -> Int {
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

pub fn signal_transform_dct_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = signal_transform_dct_min(data); let mx = signal_transform_dct_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn signal_transform_dct_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = signal_transform_dct_mean(data); let sd = signal_transform_dct_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn signal_transform_dct_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn signal_transform_dct_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn signal_transform_dct_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn signal_transform_dct_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn signal_transform_dct_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn signal_transform_dct_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct SignaltransformdctFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dct_frame_make(size : Int) -> SignaltransformdctFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_dct_frame_len(s : SignaltransformdctFrame) -> Int { s.size }

pub fn signal_transform_dct_frame_get(s : SignaltransformdctFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_dct_frame_set(s : SignaltransformdctFrame, i : Int, v : Double) -> SignaltransformdctFrame {
  let result = signal_transform_dct_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_dct_frame_sum(s : SignaltransformdctFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_transform_dct_frame_mean(s : SignaltransformdctFrame) -> Double {
  if s.size == 0 { 0.0 } else { signal_transform_dct_frame_sum(s) / s.size.to_double() }
}

pub fn signal_transform_dct_frame_scale(s : SignaltransformdctFrame, f : Double) -> SignaltransformdctFrame {
  let result = signal_transform_dct_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_transform_dct_frame_add(a : SignaltransformdctFrame, b : SignaltransformdctFrame) -> SignaltransformdctFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_transform_dct_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_transform_dct_frame_copy(s : SignaltransformdctFrame) -> SignaltransformdctFrame {
  let result = signal_transform_dct_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_transform_dct_frame_fill(s : SignaltransformdctFrame, v : Double) -> SignaltransformdctFrame {
  let result = signal_transform_dct_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_transform_dct_frame_min(s : SignaltransformdctFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_dct_frame_max(s : SignaltransformdctFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_dct_frame_to_string(s : SignaltransformdctFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformdctTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dct_table_make(size : Int) -> SignaltransformdctTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_dct_table_len(s : SignaltransformdctTable) -> Int { s.size }

pub fn signal_transform_dct_table_get(s : SignaltransformdctTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_dct_table_set(s : SignaltransformdctTable, i : Int, v : Double) -> SignaltransformdctTable {
  let result = signal_transform_dct_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_dct_table_sum(s : SignaltransformdctTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_transform_dct_table_mean(s : SignaltransformdctTable) -> Double {
  if s.size == 0 { 0.0 } else { signal_transform_dct_table_sum(s) / s.size.to_double() }
}

pub fn signal_transform_dct_table_scale(s : SignaltransformdctTable, f : Double) -> SignaltransformdctTable {
  let result = signal_transform_dct_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_transform_dct_table_add(a : SignaltransformdctTable, b : SignaltransformdctTable) -> SignaltransformdctTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_transform_dct_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_transform_dct_table_copy(s : SignaltransformdctTable) -> SignaltransformdctTable {
  let result = signal_transform_dct_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_transform_dct_table_fill(s : SignaltransformdctTable, v : Double) -> SignaltransformdctTable {
  let result = signal_transform_dct_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_transform_dct_table_min(s : SignaltransformdctTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_dct_table_max(s : SignaltransformdctTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_dct_table_to_string(s : SignaltransformdctTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformdctGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dct_graphn_make(size : Int) -> SignaltransformdctGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_dct_graphn_len(s : SignaltransformdctGraphN) -> Int { s.size }

pub fn signal_transform_dct_graphn_get(s : SignaltransformdctGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_dct_graphn_set(s : SignaltransformdctGraphN, i : Int, v : Double) -> SignaltransformdctGraphN {
  let result = signal_transform_dct_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_dct_graphn_sum(s : SignaltransformdctGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_transform_dct_graphn_mean(s : SignaltransformdctGraphN) -> Double {
  if s.size == 0 { 0.0 } else { signal_transform_dct_graphn_sum(s) / s.size.to_double() }
}

pub fn signal_transform_dct_graphn_scale(s : SignaltransformdctGraphN, f : Double) -> SignaltransformdctGraphN {
  let result = signal_transform_dct_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_transform_dct_graphn_add(a : SignaltransformdctGraphN, b : SignaltransformdctGraphN) -> SignaltransformdctGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_transform_dct_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_transform_dct_graphn_copy(s : SignaltransformdctGraphN) -> SignaltransformdctGraphN {
  let result = signal_transform_dct_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_transform_dct_graphn_fill(s : SignaltransformdctGraphN, v : Double) -> SignaltransformdctGraphN {
  let result = signal_transform_dct_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_transform_dct_graphn_min(s : SignaltransformdctGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_dct_graphn_max(s : SignaltransformdctGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_dct_graphn_to_string(s : SignaltransformdctGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformdctNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dct_node_make(size : Int) -> SignaltransformdctNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_dct_node_len(s : SignaltransformdctNode) -> Int { s.size }

pub fn signal_transform_dct_node_get(s : SignaltransformdctNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_dct_node_set(s : SignaltransformdctNode, i : Int, v : Double) -> SignaltransformdctNode {
  let result = signal_transform_dct_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_dct_node_sum(s : SignaltransformdctNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_transform_dct_node_mean(s : SignaltransformdctNode) -> Double {
  if s.size == 0 { 0.0 } else { signal_transform_dct_node_sum(s) / s.size.to_double() }
}

pub fn signal_transform_dct_node_scale(s : SignaltransformdctNode, f : Double) -> SignaltransformdctNode {
  let result = signal_transform_dct_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_transform_dct_node_add(a : SignaltransformdctNode, b : SignaltransformdctNode) -> SignaltransformdctNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_transform_dct_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_transform_dct_node_copy(s : SignaltransformdctNode) -> SignaltransformdctNode {
  let result = signal_transform_dct_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_transform_dct_node_fill(s : SignaltransformdctNode, v : Double) -> SignaltransformdctNode {
  let result = signal_transform_dct_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_transform_dct_node_min(s : SignaltransformdctNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_dct_node_max(s : SignaltransformdctNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_dct_node_to_string(s : SignaltransformdctNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformdctEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dct_edge_make(size : Int) -> SignaltransformdctEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_dct_edge_len(s : SignaltransformdctEdge) -> Int { s.size }

pub fn signal_transform_dct_edge_get(s : SignaltransformdctEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_dct_edge_set(s : SignaltransformdctEdge, i : Int, v : Double) -> SignaltransformdctEdge {
  let result = signal_transform_dct_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_dct_edge_sum(s : SignaltransformdctEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_transform_dct_edge_mean(s : SignaltransformdctEdge) -> Double {
  if s.size == 0 { 0.0 } else { signal_transform_dct_edge_sum(s) / s.size.to_double() }
}

pub fn signal_transform_dct_edge_scale(s : SignaltransformdctEdge, f : Double) -> SignaltransformdctEdge {
  let result = signal_transform_dct_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_transform_dct_edge_add(a : SignaltransformdctEdge, b : SignaltransformdctEdge) -> SignaltransformdctEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_transform_dct_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_transform_dct_edge_copy(s : SignaltransformdctEdge) -> SignaltransformdctEdge {
  let result = signal_transform_dct_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_transform_dct_edge_fill(s : SignaltransformdctEdge, v : Double) -> SignaltransformdctEdge {
  let result = signal_transform_dct_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_transform_dct_edge_min(s : SignaltransformdctEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_dct_edge_max(s : SignaltransformdctEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_dct_edge_to_string(s : SignaltransformdctEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformdctPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dct_path_make(size : Int) -> SignaltransformdctPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_dct_path_len(s : SignaltransformdctPath) -> Int { s.size }

pub fn signal_transform_dct_path_get(s : SignaltransformdctPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_dct_path_set(s : SignaltransformdctPath, i : Int, v : Double) -> SignaltransformdctPath {
  let result = signal_transform_dct_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_dct_path_sum(s : SignaltransformdctPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_transform_dct_path_mean(s : SignaltransformdctPath) -> Double {
  if s.size == 0 { 0.0 } else { signal_transform_dct_path_sum(s) / s.size.to_double() }
}

pub fn signal_transform_dct_path_scale(s : SignaltransformdctPath, f : Double) -> SignaltransformdctPath {
  let result = signal_transform_dct_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_transform_dct_path_add(a : SignaltransformdctPath, b : SignaltransformdctPath) -> SignaltransformdctPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_transform_dct_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_transform_dct_path_copy(s : SignaltransformdctPath) -> SignaltransformdctPath {
  let result = signal_transform_dct_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_transform_dct_path_fill(s : SignaltransformdctPath, v : Double) -> SignaltransformdctPath {
  let result = signal_transform_dct_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_transform_dct_path_min(s : SignaltransformdctPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_dct_path_max(s : SignaltransformdctPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_dct_path_to_string(s : SignaltransformdctPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformdctCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dct_cluster_make(size : Int) -> SignaltransformdctCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_dct_cluster_len(s : SignaltransformdctCluster) -> Int { s.size }

pub fn signal_transform_dct_cluster_get(s : SignaltransformdctCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_dct_cluster_set(s : SignaltransformdctCluster, i : Int, v : Double) -> SignaltransformdctCluster {
  let result = signal_transform_dct_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_dct_cluster_sum(s : SignaltransformdctCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_transform_dct_cluster_mean(s : SignaltransformdctCluster) -> Double {
  if s.size == 0 { 0.0 } else { signal_transform_dct_cluster_sum(s) / s.size.to_double() }
}

pub fn signal_transform_dct_cluster_scale(s : SignaltransformdctCluster, f : Double) -> SignaltransformdctCluster {
  let result = signal_transform_dct_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_transform_dct_cluster_add(a : SignaltransformdctCluster, b : SignaltransformdctCluster) -> SignaltransformdctCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_transform_dct_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_transform_dct_cluster_copy(s : SignaltransformdctCluster) -> SignaltransformdctCluster {
  let result = signal_transform_dct_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_transform_dct_cluster_fill(s : SignaltransformdctCluster, v : Double) -> SignaltransformdctCluster {
  let result = signal_transform_dct_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_transform_dct_cluster_min(s : SignaltransformdctCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_dct_cluster_max(s : SignaltransformdctCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_dct_cluster_to_string(s : SignaltransformdctCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformdctModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dct_model_make(size : Int) -> SignaltransformdctModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_dct_model_len(s : SignaltransformdctModel) -> Int { s.size }

pub fn signal_transform_dct_model_get(s : SignaltransformdctModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_dct_model_set(s : SignaltransformdctModel, i : Int, v : Double) -> SignaltransformdctModel {
  let result = signal_transform_dct_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_dct_model_sum(s : SignaltransformdctModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_transform_dct_model_mean(s : SignaltransformdctModel) -> Double {
  if s.size == 0 { 0.0 } else { signal_transform_dct_model_sum(s) / s.size.to_double() }
}

pub fn signal_transform_dct_model_scale(s : SignaltransformdctModel, f : Double) -> SignaltransformdctModel {
  let result = signal_transform_dct_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_transform_dct_model_add(a : SignaltransformdctModel, b : SignaltransformdctModel) -> SignaltransformdctModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_transform_dct_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_transform_dct_model_copy(s : SignaltransformdctModel) -> SignaltransformdctModel {
  let result = signal_transform_dct_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_transform_dct_model_fill(s : SignaltransformdctModel, v : Double) -> SignaltransformdctModel {
  let result = signal_transform_dct_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_transform_dct_model_min(s : SignaltransformdctModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_dct_model_max(s : SignaltransformdctModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_dct_model_to_string(s : SignaltransformdctModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformdctLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dct_layer_make(size : Int) -> SignaltransformdctLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_dct_layer_len(s : SignaltransformdctLayer) -> Int { s.size }

pub fn signal_transform_dct_layer_get(s : SignaltransformdctLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_dct_layer_set(s : SignaltransformdctLayer, i : Int, v : Double) -> SignaltransformdctLayer {
  let result = signal_transform_dct_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_dct_layer_sum(s : SignaltransformdctLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_transform_dct_layer_mean(s : SignaltransformdctLayer) -> Double {
  if s.size == 0 { 0.0 } else { signal_transform_dct_layer_sum(s) / s.size.to_double() }
}

pub fn signal_transform_dct_layer_scale(s : SignaltransformdctLayer, f : Double) -> SignaltransformdctLayer {
  let result = signal_transform_dct_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_transform_dct_layer_add(a : SignaltransformdctLayer, b : SignaltransformdctLayer) -> SignaltransformdctLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_transform_dct_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_transform_dct_layer_copy(s : SignaltransformdctLayer) -> SignaltransformdctLayer {
  let result = signal_transform_dct_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_transform_dct_layer_fill(s : SignaltransformdctLayer, v : Double) -> SignaltransformdctLayer {
  let result = signal_transform_dct_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_transform_dct_layer_min(s : SignaltransformdctLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_dct_layer_max(s : SignaltransformdctLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_dct_layer_to_string(s : SignaltransformdctLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformdctBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dct_buffer_make(size : Int) -> SignaltransformdctBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_dct_buffer_len(s : SignaltransformdctBuffer) -> Int { s.size }

pub fn signal_transform_dct_buffer_get(s : SignaltransformdctBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_dct_buffer_set(s : SignaltransformdctBuffer, i : Int, v : Double) -> SignaltransformdctBuffer {
  let result = signal_transform_dct_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_dct_buffer_sum(s : SignaltransformdctBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_transform_dct_buffer_mean(s : SignaltransformdctBuffer) -> Double {
  if s.size == 0 { 0.0 } else { signal_transform_dct_buffer_sum(s) / s.size.to_double() }
}

pub fn signal_transform_dct_buffer_scale(s : SignaltransformdctBuffer, f : Double) -> SignaltransformdctBuffer {
  let result = signal_transform_dct_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_transform_dct_buffer_add(a : SignaltransformdctBuffer, b : SignaltransformdctBuffer) -> SignaltransformdctBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_transform_dct_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_transform_dct_buffer_copy(s : SignaltransformdctBuffer) -> SignaltransformdctBuffer {
  let result = signal_transform_dct_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_transform_dct_buffer_fill(s : SignaltransformdctBuffer, v : Double) -> SignaltransformdctBuffer {
  let result = signal_transform_dct_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_transform_dct_buffer_min(s : SignaltransformdctBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_dct_buffer_max(s : SignaltransformdctBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_dct_buffer_to_string(s : SignaltransformdctBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformdctCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dct_cursor_make(size : Int) -> SignaltransformdctCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_dct_cursor_len(s : SignaltransformdctCursor) -> Int { s.size }

pub fn signal_transform_dct_cursor_get(s : SignaltransformdctCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_dct_cursor_set(s : SignaltransformdctCursor, i : Int, v : Double) -> SignaltransformdctCursor {
  let result = signal_transform_dct_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_dct_cursor_sum(s : SignaltransformdctCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_transform_dct_cursor_mean(s : SignaltransformdctCursor) -> Double {
  if s.size == 0 { 0.0 } else { signal_transform_dct_cursor_sum(s) / s.size.to_double() }
}

pub fn signal_transform_dct_cursor_scale(s : SignaltransformdctCursor, f : Double) -> SignaltransformdctCursor {
  let result = signal_transform_dct_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_transform_dct_cursor_add(a : SignaltransformdctCursor, b : SignaltransformdctCursor) -> SignaltransformdctCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_transform_dct_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_transform_dct_cursor_copy(s : SignaltransformdctCursor) -> SignaltransformdctCursor {
  let result = signal_transform_dct_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_transform_dct_cursor_fill(s : SignaltransformdctCursor, v : Double) -> SignaltransformdctCursor {
  let result = signal_transform_dct_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_transform_dct_cursor_min(s : SignaltransformdctCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_dct_cursor_max(s : SignaltransformdctCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_dct_cursor_to_string(s : SignaltransformdctCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformdctView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dct_view_make(size : Int) -> SignaltransformdctView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_dct_view_len(s : SignaltransformdctView) -> Int { s.size }

pub fn signal_transform_dct_view_get(s : SignaltransformdctView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_dct_view_set(s : SignaltransformdctView, i : Int, v : Double) -> SignaltransformdctView {
  let result = signal_transform_dct_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_dct_view_sum(s : SignaltransformdctView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_transform_dct_view_mean(s : SignaltransformdctView) -> Double {
  if s.size == 0 { 0.0 } else { signal_transform_dct_view_sum(s) / s.size.to_double() }
}

pub fn signal_transform_dct_view_scale(s : SignaltransformdctView, f : Double) -> SignaltransformdctView {
  let result = signal_transform_dct_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_transform_dct_view_add(a : SignaltransformdctView, b : SignaltransformdctView) -> SignaltransformdctView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_transform_dct_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_transform_dct_view_copy(s : SignaltransformdctView) -> SignaltransformdctView {
  let result = signal_transform_dct_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_transform_dct_view_fill(s : SignaltransformdctView, v : Double) -> SignaltransformdctView {
  let result = signal_transform_dct_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_transform_dct_view_min(s : SignaltransformdctView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_dct_view_max(s : SignaltransformdctView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_dct_view_to_string(s : SignaltransformdctView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformdctRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dct_range_make(size : Int) -> SignaltransformdctRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_dct_range_len(s : SignaltransformdctRange) -> Int { s.size }

pub fn signal_transform_dct_range_get(s : SignaltransformdctRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_dct_range_set(s : SignaltransformdctRange, i : Int, v : Double) -> SignaltransformdctRange {
  let result = signal_transform_dct_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_dct_range_sum(s : SignaltransformdctRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_transform_dct_range_mean(s : SignaltransformdctRange) -> Double {
  if s.size == 0 { 0.0 } else { signal_transform_dct_range_sum(s) / s.size.to_double() }
}

pub fn signal_transform_dct_range_scale(s : SignaltransformdctRange, f : Double) -> SignaltransformdctRange {
  let result = signal_transform_dct_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_transform_dct_range_add(a : SignaltransformdctRange, b : SignaltransformdctRange) -> SignaltransformdctRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_transform_dct_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_transform_dct_range_copy(s : SignaltransformdctRange) -> SignaltransformdctRange {
  let result = signal_transform_dct_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_transform_dct_range_fill(s : SignaltransformdctRange, v : Double) -> SignaltransformdctRange {
  let result = signal_transform_dct_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_transform_dct_range_min(s : SignaltransformdctRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_dct_range_max(s : SignaltransformdctRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_dct_range_to_string(s : SignaltransformdctRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformdctSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dct_slice_make(size : Int) -> SignaltransformdctSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_dct_slice_len(s : SignaltransformdctSlice) -> Int { s.size }

pub fn signal_transform_dct_slice_get(s : SignaltransformdctSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_dct_slice_set(s : SignaltransformdctSlice, i : Int, v : Double) -> SignaltransformdctSlice {
  let result = signal_transform_dct_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_dct_slice_sum(s : SignaltransformdctSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_transform_dct_slice_mean(s : SignaltransformdctSlice) -> Double {
  if s.size == 0 { 0.0 } else { signal_transform_dct_slice_sum(s) / s.size.to_double() }
}

pub fn signal_transform_dct_slice_scale(s : SignaltransformdctSlice, f : Double) -> SignaltransformdctSlice {
  let result = signal_transform_dct_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_transform_dct_slice_add(a : SignaltransformdctSlice, b : SignaltransformdctSlice) -> SignaltransformdctSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_transform_dct_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_transform_dct_slice_copy(s : SignaltransformdctSlice) -> SignaltransformdctSlice {
  let result = signal_transform_dct_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_transform_dct_slice_fill(s : SignaltransformdctSlice, v : Double) -> SignaltransformdctSlice {
  let result = signal_transform_dct_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_transform_dct_slice_min(s : SignaltransformdctSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_dct_slice_max(s : SignaltransformdctSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_dct_slice_to_string(s : SignaltransformdctSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


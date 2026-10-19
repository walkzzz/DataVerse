///===
/// extcore/signal_transform_wigner

pub(all) struct SignaltransformwignerPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_transform_wigner_make_point(x : Double, y : Double) -> SignaltransformwignerPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_transform_wigner_make_point3(x : Double, y : Double, z : Double) -> SignaltransformwignerPoint {
  { x, y, z, label: 0 }
}

pub fn signal_transform_wigner_point_x(pt : SignaltransformwignerPoint) -> Double { pt.x }

pub fn signal_transform_wigner_point_y(pt : SignaltransformwignerPoint) -> Double { pt.y }

pub fn signal_transform_wigner_point_z(pt : SignaltransformwignerPoint) -> Double { pt.z }

pub fn signal_transform_wigner_point_label(pt : SignaltransformwignerPoint) -> Int { pt.label }

pub fn signal_transform_wigner_point_dist(a : SignaltransformwignerPoint, b : SignaltransformwignerPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn signal_transform_wigner_point_add(a : SignaltransformwignerPoint, b : SignaltransformwignerPoint) -> SignaltransformwignerPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn signal_transform_wigner_point_sub(a : SignaltransformwignerPoint, b : SignaltransformwignerPoint) -> SignaltransformwignerPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn signal_transform_wigner_point_scale(pt : SignaltransformwignerPoint, s : Double) -> SignaltransformwignerPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn signal_transform_wigner_point_dot(a : SignaltransformwignerPoint, b : SignaltransformwignerPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn signal_transform_wigner_point_cross(a : SignaltransformwignerPoint, b : SignaltransformwignerPoint) -> SignaltransformwignerPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn signal_transform_wigner_point_norm(pt : SignaltransformwignerPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn signal_transform_wigner_point_normalize(pt : SignaltransformwignerPoint) -> SignaltransformwignerPoint {
  let n = signal_transform_wigner_point_norm(pt)
  if n < 0.0000001 { pt } else { signal_transform_wigner_point_scale(pt, 1.0 / n) }
}

pub fn signal_transform_wigner_point_negate(pt : SignaltransformwignerPoint) -> SignaltransformwignerPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn signal_transform_wigner_point_mid(a : SignaltransformwignerPoint, b : SignaltransformwignerPoint) -> SignaltransformwignerPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn signal_transform_wigner_point_lerp(a : SignaltransformwignerPoint, b : SignaltransformwignerPoint, t : Double) -> SignaltransformwignerPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn signal_transform_wigner_point_to_string(pt : SignaltransformwignerPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct SignaltransformwignerSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_transform_wigner_make_series(vals : Array[Double], name : String) -> SignaltransformwignerSeries {
  { vals, name, meta: 0 }
}

pub fn signal_transform_wigner_series_len(s : SignaltransformwignerSeries) -> Int { s.vals.length() }

pub fn signal_transform_wigner_series_sum(s : SignaltransformwignerSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn signal_transform_wigner_series_mean(s : SignaltransformwignerSeries) -> Double {
  let n = signal_transform_wigner_series_len(s)
  if n == 0 { 0.0 } else { signal_transform_wigner_series_sum(s) / n.to_double() }
}

pub fn signal_transform_wigner_series_min(s : SignaltransformwignerSeries) -> Double {
  let n = signal_transform_wigner_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn signal_transform_wigner_series_max(s : SignaltransformwignerSeries) -> Double {
  let n = signal_transform_wigner_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn signal_transform_wigner_series_range(s : SignaltransformwignerSeries) -> Double {
  signal_transform_wigner_series_max(s) - signal_transform_wigner_series_min(s)
}

pub fn signal_transform_wigner_series_var(s : SignaltransformwignerSeries) -> Double {
  let n = signal_transform_wigner_series_len(s)
  if n == 0 { 0.0 } else {
    let m = signal_transform_wigner_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn signal_transform_wigner_series_std(s : SignaltransformwignerSeries) -> Double { @_common.sqrt(signal_transform_wigner_series_var(s)) }

pub fn signal_transform_wigner_series_median(s : SignaltransformwignerSeries) -> Double {
  let n = signal_transform_wigner_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = signal_transform_wigner_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn signal_transform_wigner_series_scale(s : SignaltransformwignerSeries, f : Double) -> SignaltransformwignerSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn signal_transform_wigner_series_add(a : SignaltransformwignerSeries, b : SignaltransformwignerSeries) -> SignaltransformwignerSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn signal_transform_wigner_series_sub(a : SignaltransformwignerSeries, b : SignaltransformwignerSeries) -> SignaltransformwignerSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn signal_transform_wigner_series_normalize(s : SignaltransformwignerSeries) -> SignaltransformwignerSeries {
  let mn = signal_transform_wigner_series_min(s)
  let mx = signal_transform_wigner_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn signal_transform_wigner_series_cumsum(s : SignaltransformwignerSeries) -> SignaltransformwignerSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn signal_transform_wigner_series_to_string(s : SignaltransformwignerSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignaltransformwignerMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_transform_wigner_make_matrix(rows : Int, cols : Int, val : Double) -> SignaltransformwignerMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn signal_transform_wigner_matrix_identity(n : Int) -> SignaltransformwignerMatrix {
  let m = signal_transform_wigner_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn signal_transform_wigner_matrix_get(m : SignaltransformwignerMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn signal_transform_wigner_matrix_transpose(m : SignaltransformwignerMatrix) -> SignaltransformwignerMatrix {
  let result = signal_transform_wigner_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn signal_transform_wigner_matrix_add(a : SignaltransformwignerMatrix, b : SignaltransformwignerMatrix) -> SignaltransformwignerMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = signal_transform_wigner_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn signal_transform_wigner_matrix_scale(m : SignaltransformwignerMatrix, s : Double) -> SignaltransformwignerMatrix {
  let result = signal_transform_wigner_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn signal_transform_wigner_matrix_multiply(a : SignaltransformwignerMatrix, b : SignaltransformwignerMatrix) -> SignaltransformwignerMatrix {
  if a.cols != b.rows { return signal_transform_wigner_make_matrix(a.rows, b.cols, 0.0) }
  let result = signal_transform_wigner_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn signal_transform_wigner_matrix_trace(m : SignaltransformwignerMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn signal_transform_wigner_matrix_det(m : SignaltransformwignerMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn signal_transform_wigner_matrix_norm(m : SignaltransformwignerMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn signal_transform_wigner_matrix_to_string(m : SignaltransformwignerMatrix) -> String {
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

pub(all) struct SignaltransformwignerVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_transform_wigner_make_vector(comps : Array[Double]) -> SignaltransformwignerVector {
  { comps, dim: comps.length() }
}

pub fn signal_transform_wigner_vector_zero(dim : Int) -> SignaltransformwignerVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn signal_transform_wigner_vector_add(a : SignaltransformwignerVector, b : SignaltransformwignerVector) -> SignaltransformwignerVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn signal_transform_wigner_vector_sub(a : SignaltransformwignerVector, b : SignaltransformwignerVector) -> SignaltransformwignerVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn signal_transform_wigner_vector_scale(v : SignaltransformwignerVector, s : Double) -> SignaltransformwignerVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn signal_transform_wigner_vector_dot(a : SignaltransformwignerVector, b : SignaltransformwignerVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn signal_transform_wigner_vector_norm(v : SignaltransformwignerVector) -> Double { @_common.sqrt(signal_transform_wigner_vector_dot(v, v)) }

pub fn signal_transform_wigner_vector_normalize(v : SignaltransformwignerVector) -> SignaltransformwignerVector {
  let n = signal_transform_wigner_vector_norm(v)
  if n < 0.0000001 { v } else { signal_transform_wigner_vector_scale(v, 1.0 / n) }
}

pub fn signal_transform_wigner_vector_dist(a : SignaltransformwignerVector, b : SignaltransformwignerVector) -> Double {
  signal_transform_wigner_vector_norm(signal_transform_wigner_vector_sub(a, b))
}

pub fn signal_transform_wigner_vector_to_string(v : SignaltransformwignerVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn signal_transform_wigner_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn signal_transform_wigner_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = signal_transform_wigner_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn signal_transform_wigner_std(data : Array[Double]) -> Double { @_common.sqrt(signal_transform_wigner_var(data)) }

pub fn signal_transform_wigner_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = signal_transform_wigner_mean(a); let mb = signal_transform_wigner_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn signal_transform_wigner_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = signal_transform_wigner_std(a); let sb = signal_transform_wigner_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { signal_transform_wigner_cov(a, b) / (sa * sb) }
}

pub fn signal_transform_wigner_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = signal_transform_wigner_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn signal_transform_wigner_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn signal_transform_wigner_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn signal_transform_wigner_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(signal_transform_wigner_mse(pred, labels))
}

pub fn signal_transform_wigner_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn signal_transform_wigner_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = signal_transform_wigner_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn signal_transform_wigner_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn signal_transform_wigner_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn signal_transform_wigner_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = signal_transform_wigner_precision(pred, labels, pos); let r = signal_transform_wigner_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn signal_transform_wigner_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn signal_transform_wigner_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = signal_transform_wigner_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn signal_transform_wigner_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn signal_transform_wigner_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn signal_transform_wigner_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = signal_transform_wigner_gcd(a, b)
    (a / g) * b
  }
}

pub fn signal_transform_wigner_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn signal_transform_wigner_fibonacci(n : Int) -> Int {
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

pub fn signal_transform_wigner_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = signal_transform_wigner_min(data); let mx = signal_transform_wigner_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn signal_transform_wigner_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = signal_transform_wigner_mean(data); let sd = signal_transform_wigner_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn signal_transform_wigner_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn signal_transform_wigner_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn signal_transform_wigner_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn signal_transform_wigner_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn signal_transform_wigner_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn signal_transform_wigner_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct SignaltransformwignerFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_wigner_frame_make(size : Int) -> SignaltransformwignerFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_wigner_frame_len(s : SignaltransformwignerFrame) -> Int { s.size }

pub fn signal_transform_wigner_frame_get(s : SignaltransformwignerFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_wigner_frame_set(s : SignaltransformwignerFrame, i : Int, v : Double) -> SignaltransformwignerFrame {
  let result = signal_transform_wigner_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_wigner_frame_sum(s : SignaltransformwignerFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_transform_wigner_frame_mean(s : SignaltransformwignerFrame) -> Double {
  if s.size == 0 { 0.0 } else { signal_transform_wigner_frame_sum(s) / s.size.to_double() }
}

pub fn signal_transform_wigner_frame_scale(s : SignaltransformwignerFrame, f : Double) -> SignaltransformwignerFrame {
  let result = signal_transform_wigner_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_transform_wigner_frame_add(a : SignaltransformwignerFrame, b : SignaltransformwignerFrame) -> SignaltransformwignerFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_transform_wigner_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_transform_wigner_frame_copy(s : SignaltransformwignerFrame) -> SignaltransformwignerFrame {
  let result = signal_transform_wigner_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_transform_wigner_frame_fill(s : SignaltransformwignerFrame, v : Double) -> SignaltransformwignerFrame {
  let result = signal_transform_wigner_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_transform_wigner_frame_min(s : SignaltransformwignerFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_wigner_frame_max(s : SignaltransformwignerFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_wigner_frame_to_string(s : SignaltransformwignerFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformwignerTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_wigner_table_make(size : Int) -> SignaltransformwignerTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_wigner_table_len(s : SignaltransformwignerTable) -> Int { s.size }

pub fn signal_transform_wigner_table_get(s : SignaltransformwignerTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_wigner_table_set(s : SignaltransformwignerTable, i : Int, v : Double) -> SignaltransformwignerTable {
  let result = signal_transform_wigner_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_wigner_table_sum(s : SignaltransformwignerTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_transform_wigner_table_mean(s : SignaltransformwignerTable) -> Double {
  if s.size == 0 { 0.0 } else { signal_transform_wigner_table_sum(s) / s.size.to_double() }
}

pub fn signal_transform_wigner_table_scale(s : SignaltransformwignerTable, f : Double) -> SignaltransformwignerTable {
  let result = signal_transform_wigner_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_transform_wigner_table_add(a : SignaltransformwignerTable, b : SignaltransformwignerTable) -> SignaltransformwignerTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_transform_wigner_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_transform_wigner_table_copy(s : SignaltransformwignerTable) -> SignaltransformwignerTable {
  let result = signal_transform_wigner_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_transform_wigner_table_fill(s : SignaltransformwignerTable, v : Double) -> SignaltransformwignerTable {
  let result = signal_transform_wigner_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_transform_wigner_table_min(s : SignaltransformwignerTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_wigner_table_max(s : SignaltransformwignerTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_wigner_table_to_string(s : SignaltransformwignerTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformwignerGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_wigner_graphn_make(size : Int) -> SignaltransformwignerGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_wigner_graphn_len(s : SignaltransformwignerGraphN) -> Int { s.size }

pub fn signal_transform_wigner_graphn_get(s : SignaltransformwignerGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_wigner_graphn_set(s : SignaltransformwignerGraphN, i : Int, v : Double) -> SignaltransformwignerGraphN {
  let result = signal_transform_wigner_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_wigner_graphn_sum(s : SignaltransformwignerGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_transform_wigner_graphn_mean(s : SignaltransformwignerGraphN) -> Double {
  if s.size == 0 { 0.0 } else { signal_transform_wigner_graphn_sum(s) / s.size.to_double() }
}

pub fn signal_transform_wigner_graphn_scale(s : SignaltransformwignerGraphN, f : Double) -> SignaltransformwignerGraphN {
  let result = signal_transform_wigner_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_transform_wigner_graphn_add(a : SignaltransformwignerGraphN, b : SignaltransformwignerGraphN) -> SignaltransformwignerGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_transform_wigner_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_transform_wigner_graphn_copy(s : SignaltransformwignerGraphN) -> SignaltransformwignerGraphN {
  let result = signal_transform_wigner_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_transform_wigner_graphn_fill(s : SignaltransformwignerGraphN, v : Double) -> SignaltransformwignerGraphN {
  let result = signal_transform_wigner_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_transform_wigner_graphn_min(s : SignaltransformwignerGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_wigner_graphn_max(s : SignaltransformwignerGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_wigner_graphn_to_string(s : SignaltransformwignerGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformwignerNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_wigner_node_make(size : Int) -> SignaltransformwignerNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_wigner_node_len(s : SignaltransformwignerNode) -> Int { s.size }

pub fn signal_transform_wigner_node_get(s : SignaltransformwignerNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_wigner_node_set(s : SignaltransformwignerNode, i : Int, v : Double) -> SignaltransformwignerNode {
  let result = signal_transform_wigner_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_wigner_node_sum(s : SignaltransformwignerNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_transform_wigner_node_mean(s : SignaltransformwignerNode) -> Double {
  if s.size == 0 { 0.0 } else { signal_transform_wigner_node_sum(s) / s.size.to_double() }
}

pub fn signal_transform_wigner_node_scale(s : SignaltransformwignerNode, f : Double) -> SignaltransformwignerNode {
  let result = signal_transform_wigner_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_transform_wigner_node_add(a : SignaltransformwignerNode, b : SignaltransformwignerNode) -> SignaltransformwignerNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_transform_wigner_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_transform_wigner_node_copy(s : SignaltransformwignerNode) -> SignaltransformwignerNode {
  let result = signal_transform_wigner_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_transform_wigner_node_fill(s : SignaltransformwignerNode, v : Double) -> SignaltransformwignerNode {
  let result = signal_transform_wigner_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_transform_wigner_node_min(s : SignaltransformwignerNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_wigner_node_max(s : SignaltransformwignerNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_wigner_node_to_string(s : SignaltransformwignerNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformwignerEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_wigner_edge_make(size : Int) -> SignaltransformwignerEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_wigner_edge_len(s : SignaltransformwignerEdge) -> Int { s.size }

pub fn signal_transform_wigner_edge_get(s : SignaltransformwignerEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_wigner_edge_set(s : SignaltransformwignerEdge, i : Int, v : Double) -> SignaltransformwignerEdge {
  let result = signal_transform_wigner_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_wigner_edge_sum(s : SignaltransformwignerEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_transform_wigner_edge_mean(s : SignaltransformwignerEdge) -> Double {
  if s.size == 0 { 0.0 } else { signal_transform_wigner_edge_sum(s) / s.size.to_double() }
}

pub fn signal_transform_wigner_edge_scale(s : SignaltransformwignerEdge, f : Double) -> SignaltransformwignerEdge {
  let result = signal_transform_wigner_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_transform_wigner_edge_add(a : SignaltransformwignerEdge, b : SignaltransformwignerEdge) -> SignaltransformwignerEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_transform_wigner_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_transform_wigner_edge_copy(s : SignaltransformwignerEdge) -> SignaltransformwignerEdge {
  let result = signal_transform_wigner_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_transform_wigner_edge_fill(s : SignaltransformwignerEdge, v : Double) -> SignaltransformwignerEdge {
  let result = signal_transform_wigner_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_transform_wigner_edge_min(s : SignaltransformwignerEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_wigner_edge_max(s : SignaltransformwignerEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_wigner_edge_to_string(s : SignaltransformwignerEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformwignerPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_wigner_path_make(size : Int) -> SignaltransformwignerPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_wigner_path_len(s : SignaltransformwignerPath) -> Int { s.size }

pub fn signal_transform_wigner_path_get(s : SignaltransformwignerPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_wigner_path_set(s : SignaltransformwignerPath, i : Int, v : Double) -> SignaltransformwignerPath {
  let result = signal_transform_wigner_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_wigner_path_sum(s : SignaltransformwignerPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_transform_wigner_path_mean(s : SignaltransformwignerPath) -> Double {
  if s.size == 0 { 0.0 } else { signal_transform_wigner_path_sum(s) / s.size.to_double() }
}

pub fn signal_transform_wigner_path_scale(s : SignaltransformwignerPath, f : Double) -> SignaltransformwignerPath {
  let result = signal_transform_wigner_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_transform_wigner_path_add(a : SignaltransformwignerPath, b : SignaltransformwignerPath) -> SignaltransformwignerPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_transform_wigner_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_transform_wigner_path_copy(s : SignaltransformwignerPath) -> SignaltransformwignerPath {
  let result = signal_transform_wigner_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_transform_wigner_path_fill(s : SignaltransformwignerPath, v : Double) -> SignaltransformwignerPath {
  let result = signal_transform_wigner_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_transform_wigner_path_min(s : SignaltransformwignerPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_wigner_path_max(s : SignaltransformwignerPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_wigner_path_to_string(s : SignaltransformwignerPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformwignerCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_wigner_cluster_make(size : Int) -> SignaltransformwignerCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_wigner_cluster_len(s : SignaltransformwignerCluster) -> Int { s.size }

pub fn signal_transform_wigner_cluster_get(s : SignaltransformwignerCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_wigner_cluster_set(s : SignaltransformwignerCluster, i : Int, v : Double) -> SignaltransformwignerCluster {
  let result = signal_transform_wigner_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_wigner_cluster_sum(s : SignaltransformwignerCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_transform_wigner_cluster_mean(s : SignaltransformwignerCluster) -> Double {
  if s.size == 0 { 0.0 } else { signal_transform_wigner_cluster_sum(s) / s.size.to_double() }
}

pub fn signal_transform_wigner_cluster_scale(s : SignaltransformwignerCluster, f : Double) -> SignaltransformwignerCluster {
  let result = signal_transform_wigner_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_transform_wigner_cluster_add(a : SignaltransformwignerCluster, b : SignaltransformwignerCluster) -> SignaltransformwignerCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_transform_wigner_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_transform_wigner_cluster_copy(s : SignaltransformwignerCluster) -> SignaltransformwignerCluster {
  let result = signal_transform_wigner_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_transform_wigner_cluster_fill(s : SignaltransformwignerCluster, v : Double) -> SignaltransformwignerCluster {
  let result = signal_transform_wigner_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_transform_wigner_cluster_min(s : SignaltransformwignerCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_wigner_cluster_max(s : SignaltransformwignerCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_wigner_cluster_to_string(s : SignaltransformwignerCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformwignerModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_wigner_model_make(size : Int) -> SignaltransformwignerModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_wigner_model_len(s : SignaltransformwignerModel) -> Int { s.size }

pub fn signal_transform_wigner_model_get(s : SignaltransformwignerModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_wigner_model_set(s : SignaltransformwignerModel, i : Int, v : Double) -> SignaltransformwignerModel {
  let result = signal_transform_wigner_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_wigner_model_sum(s : SignaltransformwignerModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_transform_wigner_model_mean(s : SignaltransformwignerModel) -> Double {
  if s.size == 0 { 0.0 } else { signal_transform_wigner_model_sum(s) / s.size.to_double() }
}

pub fn signal_transform_wigner_model_scale(s : SignaltransformwignerModel, f : Double) -> SignaltransformwignerModel {
  let result = signal_transform_wigner_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_transform_wigner_model_add(a : SignaltransformwignerModel, b : SignaltransformwignerModel) -> SignaltransformwignerModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_transform_wigner_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_transform_wigner_model_copy(s : SignaltransformwignerModel) -> SignaltransformwignerModel {
  let result = signal_transform_wigner_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_transform_wigner_model_fill(s : SignaltransformwignerModel, v : Double) -> SignaltransformwignerModel {
  let result = signal_transform_wigner_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_transform_wigner_model_min(s : SignaltransformwignerModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_wigner_model_max(s : SignaltransformwignerModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_wigner_model_to_string(s : SignaltransformwignerModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformwignerLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_wigner_layer_make(size : Int) -> SignaltransformwignerLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_wigner_layer_len(s : SignaltransformwignerLayer) -> Int { s.size }

pub fn signal_transform_wigner_layer_get(s : SignaltransformwignerLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_wigner_layer_set(s : SignaltransformwignerLayer, i : Int, v : Double) -> SignaltransformwignerLayer {
  let result = signal_transform_wigner_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_wigner_layer_sum(s : SignaltransformwignerLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_transform_wigner_layer_mean(s : SignaltransformwignerLayer) -> Double {
  if s.size == 0 { 0.0 } else { signal_transform_wigner_layer_sum(s) / s.size.to_double() }
}

pub fn signal_transform_wigner_layer_scale(s : SignaltransformwignerLayer, f : Double) -> SignaltransformwignerLayer {
  let result = signal_transform_wigner_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_transform_wigner_layer_add(a : SignaltransformwignerLayer, b : SignaltransformwignerLayer) -> SignaltransformwignerLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_transform_wigner_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_transform_wigner_layer_copy(s : SignaltransformwignerLayer) -> SignaltransformwignerLayer {
  let result = signal_transform_wigner_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_transform_wigner_layer_fill(s : SignaltransformwignerLayer, v : Double) -> SignaltransformwignerLayer {
  let result = signal_transform_wigner_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_transform_wigner_layer_min(s : SignaltransformwignerLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_wigner_layer_max(s : SignaltransformwignerLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_wigner_layer_to_string(s : SignaltransformwignerLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformwignerBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_wigner_buffer_make(size : Int) -> SignaltransformwignerBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_wigner_buffer_len(s : SignaltransformwignerBuffer) -> Int { s.size }

pub fn signal_transform_wigner_buffer_get(s : SignaltransformwignerBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_wigner_buffer_set(s : SignaltransformwignerBuffer, i : Int, v : Double) -> SignaltransformwignerBuffer {
  let result = signal_transform_wigner_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_wigner_buffer_sum(s : SignaltransformwignerBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_transform_wigner_buffer_mean(s : SignaltransformwignerBuffer) -> Double {
  if s.size == 0 { 0.0 } else { signal_transform_wigner_buffer_sum(s) / s.size.to_double() }
}

pub fn signal_transform_wigner_buffer_scale(s : SignaltransformwignerBuffer, f : Double) -> SignaltransformwignerBuffer {
  let result = signal_transform_wigner_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_transform_wigner_buffer_add(a : SignaltransformwignerBuffer, b : SignaltransformwignerBuffer) -> SignaltransformwignerBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_transform_wigner_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_transform_wigner_buffer_copy(s : SignaltransformwignerBuffer) -> SignaltransformwignerBuffer {
  let result = signal_transform_wigner_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_transform_wigner_buffer_fill(s : SignaltransformwignerBuffer, v : Double) -> SignaltransformwignerBuffer {
  let result = signal_transform_wigner_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_transform_wigner_buffer_min(s : SignaltransformwignerBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_wigner_buffer_max(s : SignaltransformwignerBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_wigner_buffer_to_string(s : SignaltransformwignerBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformwignerCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_wigner_cursor_make(size : Int) -> SignaltransformwignerCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_wigner_cursor_len(s : SignaltransformwignerCursor) -> Int { s.size }

pub fn signal_transform_wigner_cursor_get(s : SignaltransformwignerCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_wigner_cursor_set(s : SignaltransformwignerCursor, i : Int, v : Double) -> SignaltransformwignerCursor {
  let result = signal_transform_wigner_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_wigner_cursor_sum(s : SignaltransformwignerCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_transform_wigner_cursor_mean(s : SignaltransformwignerCursor) -> Double {
  if s.size == 0 { 0.0 } else { signal_transform_wigner_cursor_sum(s) / s.size.to_double() }
}

pub fn signal_transform_wigner_cursor_scale(s : SignaltransformwignerCursor, f : Double) -> SignaltransformwignerCursor {
  let result = signal_transform_wigner_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_transform_wigner_cursor_add(a : SignaltransformwignerCursor, b : SignaltransformwignerCursor) -> SignaltransformwignerCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_transform_wigner_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_transform_wigner_cursor_copy(s : SignaltransformwignerCursor) -> SignaltransformwignerCursor {
  let result = signal_transform_wigner_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_transform_wigner_cursor_fill(s : SignaltransformwignerCursor, v : Double) -> SignaltransformwignerCursor {
  let result = signal_transform_wigner_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_transform_wigner_cursor_min(s : SignaltransformwignerCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_wigner_cursor_max(s : SignaltransformwignerCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_wigner_cursor_to_string(s : SignaltransformwignerCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformwignerView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_wigner_view_make(size : Int) -> SignaltransformwignerView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_wigner_view_len(s : SignaltransformwignerView) -> Int { s.size }

pub fn signal_transform_wigner_view_get(s : SignaltransformwignerView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_wigner_view_set(s : SignaltransformwignerView, i : Int, v : Double) -> SignaltransformwignerView {
  let result = signal_transform_wigner_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_wigner_view_sum(s : SignaltransformwignerView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_transform_wigner_view_mean(s : SignaltransformwignerView) -> Double {
  if s.size == 0 { 0.0 } else { signal_transform_wigner_view_sum(s) / s.size.to_double() }
}

pub fn signal_transform_wigner_view_scale(s : SignaltransformwignerView, f : Double) -> SignaltransformwignerView {
  let result = signal_transform_wigner_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_transform_wigner_view_add(a : SignaltransformwignerView, b : SignaltransformwignerView) -> SignaltransformwignerView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_transform_wigner_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_transform_wigner_view_copy(s : SignaltransformwignerView) -> SignaltransformwignerView {
  let result = signal_transform_wigner_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_transform_wigner_view_fill(s : SignaltransformwignerView, v : Double) -> SignaltransformwignerView {
  let result = signal_transform_wigner_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_transform_wigner_view_min(s : SignaltransformwignerView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_wigner_view_max(s : SignaltransformwignerView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_wigner_view_to_string(s : SignaltransformwignerView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformwignerRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_wigner_range_make(size : Int) -> SignaltransformwignerRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_wigner_range_len(s : SignaltransformwignerRange) -> Int { s.size }

pub fn signal_transform_wigner_range_get(s : SignaltransformwignerRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_wigner_range_set(s : SignaltransformwignerRange, i : Int, v : Double) -> SignaltransformwignerRange {
  let result = signal_transform_wigner_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_wigner_range_sum(s : SignaltransformwignerRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_transform_wigner_range_mean(s : SignaltransformwignerRange) -> Double {
  if s.size == 0 { 0.0 } else { signal_transform_wigner_range_sum(s) / s.size.to_double() }
}

pub fn signal_transform_wigner_range_scale(s : SignaltransformwignerRange, f : Double) -> SignaltransformwignerRange {
  let result = signal_transform_wigner_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_transform_wigner_range_add(a : SignaltransformwignerRange, b : SignaltransformwignerRange) -> SignaltransformwignerRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_transform_wigner_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_transform_wigner_range_copy(s : SignaltransformwignerRange) -> SignaltransformwignerRange {
  let result = signal_transform_wigner_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_transform_wigner_range_fill(s : SignaltransformwignerRange, v : Double) -> SignaltransformwignerRange {
  let result = signal_transform_wigner_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_transform_wigner_range_min(s : SignaltransformwignerRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_wigner_range_max(s : SignaltransformwignerRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_wigner_range_to_string(s : SignaltransformwignerRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformwignerSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_wigner_slice_make(size : Int) -> SignaltransformwignerSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_wigner_slice_len(s : SignaltransformwignerSlice) -> Int { s.size }

pub fn signal_transform_wigner_slice_get(s : SignaltransformwignerSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_wigner_slice_set(s : SignaltransformwignerSlice, i : Int, v : Double) -> SignaltransformwignerSlice {
  let result = signal_transform_wigner_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_wigner_slice_sum(s : SignaltransformwignerSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_transform_wigner_slice_mean(s : SignaltransformwignerSlice) -> Double {
  if s.size == 0 { 0.0 } else { signal_transform_wigner_slice_sum(s) / s.size.to_double() }
}

pub fn signal_transform_wigner_slice_scale(s : SignaltransformwignerSlice, f : Double) -> SignaltransformwignerSlice {
  let result = signal_transform_wigner_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_transform_wigner_slice_add(a : SignaltransformwignerSlice, b : SignaltransformwignerSlice) -> SignaltransformwignerSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_transform_wigner_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_transform_wigner_slice_copy(s : SignaltransformwignerSlice) -> SignaltransformwignerSlice {
  let result = signal_transform_wigner_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_transform_wigner_slice_fill(s : SignaltransformwignerSlice, v : Double) -> SignaltransformwignerSlice {
  let result = signal_transform_wigner_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_transform_wigner_slice_min(s : SignaltransformwignerSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_wigner_slice_max(s : SignaltransformwignerSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_transform_wigner_slice_to_string(s : SignaltransformwignerSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


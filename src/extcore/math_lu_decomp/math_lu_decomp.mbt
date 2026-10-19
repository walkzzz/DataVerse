///===
/// extcore/math_lu_decomp

pub(all) struct MathludecompPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_lu_decomp_make_point(x : Double, y : Double) -> MathludecompPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_lu_decomp_make_point3(x : Double, y : Double, z : Double) -> MathludecompPoint {
  { x, y, z, label: 0 }
}

pub fn math_lu_decomp_point_x(pt : MathludecompPoint) -> Double { pt.x }

pub fn math_lu_decomp_point_y(pt : MathludecompPoint) -> Double { pt.y }

pub fn math_lu_decomp_point_z(pt : MathludecompPoint) -> Double { pt.z }

pub fn math_lu_decomp_point_label(pt : MathludecompPoint) -> Int { pt.label }

pub fn math_lu_decomp_point_dist(a : MathludecompPoint, b : MathludecompPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn math_lu_decomp_point_add(a : MathludecompPoint, b : MathludecompPoint) -> MathludecompPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn math_lu_decomp_point_sub(a : MathludecompPoint, b : MathludecompPoint) -> MathludecompPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn math_lu_decomp_point_scale(pt : MathludecompPoint, s : Double) -> MathludecompPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn math_lu_decomp_point_dot(a : MathludecompPoint, b : MathludecompPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn math_lu_decomp_point_cross(a : MathludecompPoint, b : MathludecompPoint) -> MathludecompPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn math_lu_decomp_point_norm(pt : MathludecompPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn math_lu_decomp_point_normalize(pt : MathludecompPoint) -> MathludecompPoint {
  let n = math_lu_decomp_point_norm(pt)
  if n < 0.0000001 { pt } else { math_lu_decomp_point_scale(pt, 1.0 / n) }
}

pub fn math_lu_decomp_point_negate(pt : MathludecompPoint) -> MathludecompPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn math_lu_decomp_point_mid(a : MathludecompPoint, b : MathludecompPoint) -> MathludecompPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn math_lu_decomp_point_lerp(a : MathludecompPoint, b : MathludecompPoint, t : Double) -> MathludecompPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn math_lu_decomp_point_to_string(pt : MathludecompPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MathludecompSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_lu_decomp_make_series(vals : Array[Double], name : String) -> MathludecompSeries {
  { vals, name, meta: 0 }
}

pub fn math_lu_decomp_series_len(s : MathludecompSeries) -> Int { s.vals.length() }

pub fn math_lu_decomp_series_sum(s : MathludecompSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn math_lu_decomp_series_mean(s : MathludecompSeries) -> Double {
  let n = math_lu_decomp_series_len(s)
  if n == 0 { 0.0 } else { math_lu_decomp_series_sum(s) / n.to_double() }
}

pub fn math_lu_decomp_series_min(s : MathludecompSeries) -> Double {
  let n = math_lu_decomp_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn math_lu_decomp_series_max(s : MathludecompSeries) -> Double {
  let n = math_lu_decomp_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn math_lu_decomp_series_range(s : MathludecompSeries) -> Double {
  math_lu_decomp_series_max(s) - math_lu_decomp_series_min(s)
}

pub fn math_lu_decomp_series_var(s : MathludecompSeries) -> Double {
  let n = math_lu_decomp_series_len(s)
  if n == 0 { 0.0 } else {
    let m = math_lu_decomp_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn math_lu_decomp_series_std(s : MathludecompSeries) -> Double { @_common.sqrt(math_lu_decomp_series_var(s)) }

pub fn math_lu_decomp_series_median(s : MathludecompSeries) -> Double {
  let n = math_lu_decomp_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = math_lu_decomp_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn math_lu_decomp_series_scale(s : MathludecompSeries, f : Double) -> MathludecompSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn math_lu_decomp_series_add(a : MathludecompSeries, b : MathludecompSeries) -> MathludecompSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn math_lu_decomp_series_sub(a : MathludecompSeries, b : MathludecompSeries) -> MathludecompSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn math_lu_decomp_series_normalize(s : MathludecompSeries) -> MathludecompSeries {
  let mn = math_lu_decomp_series_min(s)
  let mx = math_lu_decomp_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn math_lu_decomp_series_cumsum(s : MathludecompSeries) -> MathludecompSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn math_lu_decomp_series_to_string(s : MathludecompSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathludecompMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_lu_decomp_make_matrix(rows : Int, cols : Int, val : Double) -> MathludecompMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_lu_decomp_matrix_identity(n : Int) -> MathludecompMatrix {
  let m = math_lu_decomp_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn math_lu_decomp_matrix_get(m : MathludecompMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn math_lu_decomp_matrix_transpose(m : MathludecompMatrix) -> MathludecompMatrix {
  let result = math_lu_decomp_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn math_lu_decomp_matrix_add(a : MathludecompMatrix, b : MathludecompMatrix) -> MathludecompMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = math_lu_decomp_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn math_lu_decomp_matrix_scale(m : MathludecompMatrix, s : Double) -> MathludecompMatrix {
  let result = math_lu_decomp_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn math_lu_decomp_matrix_multiply(a : MathludecompMatrix, b : MathludecompMatrix) -> MathludecompMatrix {
  if a.cols != b.rows { return math_lu_decomp_make_matrix(a.rows, b.cols, 0.0) }
  let result = math_lu_decomp_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn math_lu_decomp_matrix_trace(m : MathludecompMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn math_lu_decomp_matrix_det(m : MathludecompMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn math_lu_decomp_matrix_norm(m : MathludecompMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn math_lu_decomp_matrix_to_string(m : MathludecompMatrix) -> String {
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

pub(all) struct MathludecompVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_lu_decomp_make_vector(comps : Array[Double]) -> MathludecompVector {
  { comps, dim: comps.length() }
}

pub fn math_lu_decomp_vector_zero(dim : Int) -> MathludecompVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn math_lu_decomp_vector_add(a : MathludecompVector, b : MathludecompVector) -> MathludecompVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn math_lu_decomp_vector_sub(a : MathludecompVector, b : MathludecompVector) -> MathludecompVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn math_lu_decomp_vector_scale(v : MathludecompVector, s : Double) -> MathludecompVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn math_lu_decomp_vector_dot(a : MathludecompVector, b : MathludecompVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn math_lu_decomp_vector_norm(v : MathludecompVector) -> Double { @_common.sqrt(math_lu_decomp_vector_dot(v, v)) }

pub fn math_lu_decomp_vector_normalize(v : MathludecompVector) -> MathludecompVector {
  let n = math_lu_decomp_vector_norm(v)
  if n < 0.0000001 { v } else { math_lu_decomp_vector_scale(v, 1.0 / n) }
}

pub fn math_lu_decomp_vector_dist(a : MathludecompVector, b : MathludecompVector) -> Double {
  math_lu_decomp_vector_norm(math_lu_decomp_vector_sub(a, b))
}

pub fn math_lu_decomp_vector_to_string(v : MathludecompVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_lu_decomp_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn math_lu_decomp_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = math_lu_decomp_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn math_lu_decomp_std(data : Array[Double]) -> Double { @_common.sqrt(math_lu_decomp_var(data)) }

pub fn math_lu_decomp_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = math_lu_decomp_mean(a); let mb = math_lu_decomp_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn math_lu_decomp_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = math_lu_decomp_std(a); let sb = math_lu_decomp_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { math_lu_decomp_cov(a, b) / (sa * sb) }
}

pub fn math_lu_decomp_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = math_lu_decomp_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn math_lu_decomp_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn math_lu_decomp_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn math_lu_decomp_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(math_lu_decomp_mse(pred, labels))
}

pub fn math_lu_decomp_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn math_lu_decomp_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = math_lu_decomp_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn math_lu_decomp_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn math_lu_decomp_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn math_lu_decomp_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = math_lu_decomp_precision(pred, labels, pos); let r = math_lu_decomp_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn math_lu_decomp_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn math_lu_decomp_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = math_lu_decomp_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn math_lu_decomp_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn math_lu_decomp_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn math_lu_decomp_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = math_lu_decomp_gcd(a, b)
    (a / g) * b
  }
}

pub fn math_lu_decomp_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn math_lu_decomp_fibonacci(n : Int) -> Int {
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

pub fn math_lu_decomp_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = math_lu_decomp_min(data); let mx = math_lu_decomp_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn math_lu_decomp_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = math_lu_decomp_mean(data); let sd = math_lu_decomp_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn math_lu_decomp_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn math_lu_decomp_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn math_lu_decomp_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn math_lu_decomp_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn math_lu_decomp_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn math_lu_decomp_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct MathludecompFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_lu_decomp_frame_make(size : Int) -> MathludecompFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_lu_decomp_frame_len(s : MathludecompFrame) -> Int { s.size }

pub fn math_lu_decomp_frame_get(s : MathludecompFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_lu_decomp_frame_set(s : MathludecompFrame, i : Int, v : Double) -> MathludecompFrame {
  let result = math_lu_decomp_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_lu_decomp_frame_sum(s : MathludecompFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_lu_decomp_frame_mean(s : MathludecompFrame) -> Double {
  if s.size == 0 { 0.0 } else { math_lu_decomp_frame_sum(s) / s.size.to_double() }
}

pub fn math_lu_decomp_frame_scale(s : MathludecompFrame, f : Double) -> MathludecompFrame {
  let result = math_lu_decomp_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_lu_decomp_frame_add(a : MathludecompFrame, b : MathludecompFrame) -> MathludecompFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_lu_decomp_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_lu_decomp_frame_copy(s : MathludecompFrame) -> MathludecompFrame {
  let result = math_lu_decomp_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_lu_decomp_frame_fill(s : MathludecompFrame, v : Double) -> MathludecompFrame {
  let result = math_lu_decomp_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_lu_decomp_frame_min(s : MathludecompFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_lu_decomp_frame_max(s : MathludecompFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_lu_decomp_frame_to_string(s : MathludecompFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathludecompTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_lu_decomp_table_make(size : Int) -> MathludecompTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_lu_decomp_table_len(s : MathludecompTable) -> Int { s.size }

pub fn math_lu_decomp_table_get(s : MathludecompTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_lu_decomp_table_set(s : MathludecompTable, i : Int, v : Double) -> MathludecompTable {
  let result = math_lu_decomp_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_lu_decomp_table_sum(s : MathludecompTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_lu_decomp_table_mean(s : MathludecompTable) -> Double {
  if s.size == 0 { 0.0 } else { math_lu_decomp_table_sum(s) / s.size.to_double() }
}

pub fn math_lu_decomp_table_scale(s : MathludecompTable, f : Double) -> MathludecompTable {
  let result = math_lu_decomp_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_lu_decomp_table_add(a : MathludecompTable, b : MathludecompTable) -> MathludecompTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_lu_decomp_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_lu_decomp_table_copy(s : MathludecompTable) -> MathludecompTable {
  let result = math_lu_decomp_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_lu_decomp_table_fill(s : MathludecompTable, v : Double) -> MathludecompTable {
  let result = math_lu_decomp_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_lu_decomp_table_min(s : MathludecompTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_lu_decomp_table_max(s : MathludecompTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_lu_decomp_table_to_string(s : MathludecompTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathludecompGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_lu_decomp_graphn_make(size : Int) -> MathludecompGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_lu_decomp_graphn_len(s : MathludecompGraphN) -> Int { s.size }

pub fn math_lu_decomp_graphn_get(s : MathludecompGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_lu_decomp_graphn_set(s : MathludecompGraphN, i : Int, v : Double) -> MathludecompGraphN {
  let result = math_lu_decomp_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_lu_decomp_graphn_sum(s : MathludecompGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_lu_decomp_graphn_mean(s : MathludecompGraphN) -> Double {
  if s.size == 0 { 0.0 } else { math_lu_decomp_graphn_sum(s) / s.size.to_double() }
}

pub fn math_lu_decomp_graphn_scale(s : MathludecompGraphN, f : Double) -> MathludecompGraphN {
  let result = math_lu_decomp_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_lu_decomp_graphn_add(a : MathludecompGraphN, b : MathludecompGraphN) -> MathludecompGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_lu_decomp_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_lu_decomp_graphn_copy(s : MathludecompGraphN) -> MathludecompGraphN {
  let result = math_lu_decomp_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_lu_decomp_graphn_fill(s : MathludecompGraphN, v : Double) -> MathludecompGraphN {
  let result = math_lu_decomp_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_lu_decomp_graphn_min(s : MathludecompGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_lu_decomp_graphn_max(s : MathludecompGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_lu_decomp_graphn_to_string(s : MathludecompGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathludecompNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_lu_decomp_node_make(size : Int) -> MathludecompNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_lu_decomp_node_len(s : MathludecompNode) -> Int { s.size }

pub fn math_lu_decomp_node_get(s : MathludecompNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_lu_decomp_node_set(s : MathludecompNode, i : Int, v : Double) -> MathludecompNode {
  let result = math_lu_decomp_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_lu_decomp_node_sum(s : MathludecompNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_lu_decomp_node_mean(s : MathludecompNode) -> Double {
  if s.size == 0 { 0.0 } else { math_lu_decomp_node_sum(s) / s.size.to_double() }
}

pub fn math_lu_decomp_node_scale(s : MathludecompNode, f : Double) -> MathludecompNode {
  let result = math_lu_decomp_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_lu_decomp_node_add(a : MathludecompNode, b : MathludecompNode) -> MathludecompNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_lu_decomp_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_lu_decomp_node_copy(s : MathludecompNode) -> MathludecompNode {
  let result = math_lu_decomp_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_lu_decomp_node_fill(s : MathludecompNode, v : Double) -> MathludecompNode {
  let result = math_lu_decomp_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_lu_decomp_node_min(s : MathludecompNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_lu_decomp_node_max(s : MathludecompNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_lu_decomp_node_to_string(s : MathludecompNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathludecompEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_lu_decomp_edge_make(size : Int) -> MathludecompEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_lu_decomp_edge_len(s : MathludecompEdge) -> Int { s.size }

pub fn math_lu_decomp_edge_get(s : MathludecompEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_lu_decomp_edge_set(s : MathludecompEdge, i : Int, v : Double) -> MathludecompEdge {
  let result = math_lu_decomp_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_lu_decomp_edge_sum(s : MathludecompEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_lu_decomp_edge_mean(s : MathludecompEdge) -> Double {
  if s.size == 0 { 0.0 } else { math_lu_decomp_edge_sum(s) / s.size.to_double() }
}

pub fn math_lu_decomp_edge_scale(s : MathludecompEdge, f : Double) -> MathludecompEdge {
  let result = math_lu_decomp_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_lu_decomp_edge_add(a : MathludecompEdge, b : MathludecompEdge) -> MathludecompEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_lu_decomp_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_lu_decomp_edge_copy(s : MathludecompEdge) -> MathludecompEdge {
  let result = math_lu_decomp_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_lu_decomp_edge_fill(s : MathludecompEdge, v : Double) -> MathludecompEdge {
  let result = math_lu_decomp_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_lu_decomp_edge_min(s : MathludecompEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_lu_decomp_edge_max(s : MathludecompEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_lu_decomp_edge_to_string(s : MathludecompEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathludecompPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_lu_decomp_path_make(size : Int) -> MathludecompPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_lu_decomp_path_len(s : MathludecompPath) -> Int { s.size }

pub fn math_lu_decomp_path_get(s : MathludecompPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_lu_decomp_path_set(s : MathludecompPath, i : Int, v : Double) -> MathludecompPath {
  let result = math_lu_decomp_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_lu_decomp_path_sum(s : MathludecompPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_lu_decomp_path_mean(s : MathludecompPath) -> Double {
  if s.size == 0 { 0.0 } else { math_lu_decomp_path_sum(s) / s.size.to_double() }
}

pub fn math_lu_decomp_path_scale(s : MathludecompPath, f : Double) -> MathludecompPath {
  let result = math_lu_decomp_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_lu_decomp_path_add(a : MathludecompPath, b : MathludecompPath) -> MathludecompPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_lu_decomp_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_lu_decomp_path_copy(s : MathludecompPath) -> MathludecompPath {
  let result = math_lu_decomp_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_lu_decomp_path_fill(s : MathludecompPath, v : Double) -> MathludecompPath {
  let result = math_lu_decomp_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_lu_decomp_path_min(s : MathludecompPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_lu_decomp_path_max(s : MathludecompPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_lu_decomp_path_to_string(s : MathludecompPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathludecompCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_lu_decomp_cluster_make(size : Int) -> MathludecompCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_lu_decomp_cluster_len(s : MathludecompCluster) -> Int { s.size }

pub fn math_lu_decomp_cluster_get(s : MathludecompCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_lu_decomp_cluster_set(s : MathludecompCluster, i : Int, v : Double) -> MathludecompCluster {
  let result = math_lu_decomp_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_lu_decomp_cluster_sum(s : MathludecompCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_lu_decomp_cluster_mean(s : MathludecompCluster) -> Double {
  if s.size == 0 { 0.0 } else { math_lu_decomp_cluster_sum(s) / s.size.to_double() }
}

pub fn math_lu_decomp_cluster_scale(s : MathludecompCluster, f : Double) -> MathludecompCluster {
  let result = math_lu_decomp_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_lu_decomp_cluster_add(a : MathludecompCluster, b : MathludecompCluster) -> MathludecompCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_lu_decomp_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_lu_decomp_cluster_copy(s : MathludecompCluster) -> MathludecompCluster {
  let result = math_lu_decomp_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_lu_decomp_cluster_fill(s : MathludecompCluster, v : Double) -> MathludecompCluster {
  let result = math_lu_decomp_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_lu_decomp_cluster_min(s : MathludecompCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_lu_decomp_cluster_max(s : MathludecompCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_lu_decomp_cluster_to_string(s : MathludecompCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathludecompModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_lu_decomp_model_make(size : Int) -> MathludecompModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_lu_decomp_model_len(s : MathludecompModel) -> Int { s.size }

pub fn math_lu_decomp_model_get(s : MathludecompModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_lu_decomp_model_set(s : MathludecompModel, i : Int, v : Double) -> MathludecompModel {
  let result = math_lu_decomp_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_lu_decomp_model_sum(s : MathludecompModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_lu_decomp_model_mean(s : MathludecompModel) -> Double {
  if s.size == 0 { 0.0 } else { math_lu_decomp_model_sum(s) / s.size.to_double() }
}

pub fn math_lu_decomp_model_scale(s : MathludecompModel, f : Double) -> MathludecompModel {
  let result = math_lu_decomp_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_lu_decomp_model_add(a : MathludecompModel, b : MathludecompModel) -> MathludecompModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_lu_decomp_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_lu_decomp_model_copy(s : MathludecompModel) -> MathludecompModel {
  let result = math_lu_decomp_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_lu_decomp_model_fill(s : MathludecompModel, v : Double) -> MathludecompModel {
  let result = math_lu_decomp_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_lu_decomp_model_min(s : MathludecompModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_lu_decomp_model_max(s : MathludecompModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_lu_decomp_model_to_string(s : MathludecompModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathludecompLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_lu_decomp_layer_make(size : Int) -> MathludecompLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_lu_decomp_layer_len(s : MathludecompLayer) -> Int { s.size }

pub fn math_lu_decomp_layer_get(s : MathludecompLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_lu_decomp_layer_set(s : MathludecompLayer, i : Int, v : Double) -> MathludecompLayer {
  let result = math_lu_decomp_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_lu_decomp_layer_sum(s : MathludecompLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_lu_decomp_layer_mean(s : MathludecompLayer) -> Double {
  if s.size == 0 { 0.0 } else { math_lu_decomp_layer_sum(s) / s.size.to_double() }
}

pub fn math_lu_decomp_layer_scale(s : MathludecompLayer, f : Double) -> MathludecompLayer {
  let result = math_lu_decomp_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_lu_decomp_layer_add(a : MathludecompLayer, b : MathludecompLayer) -> MathludecompLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_lu_decomp_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_lu_decomp_layer_copy(s : MathludecompLayer) -> MathludecompLayer {
  let result = math_lu_decomp_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_lu_decomp_layer_fill(s : MathludecompLayer, v : Double) -> MathludecompLayer {
  let result = math_lu_decomp_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_lu_decomp_layer_min(s : MathludecompLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_lu_decomp_layer_max(s : MathludecompLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_lu_decomp_layer_to_string(s : MathludecompLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathludecompBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_lu_decomp_buffer_make(size : Int) -> MathludecompBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_lu_decomp_buffer_len(s : MathludecompBuffer) -> Int { s.size }

pub fn math_lu_decomp_buffer_get(s : MathludecompBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_lu_decomp_buffer_set(s : MathludecompBuffer, i : Int, v : Double) -> MathludecompBuffer {
  let result = math_lu_decomp_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_lu_decomp_buffer_sum(s : MathludecompBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_lu_decomp_buffer_mean(s : MathludecompBuffer) -> Double {
  if s.size == 0 { 0.0 } else { math_lu_decomp_buffer_sum(s) / s.size.to_double() }
}

pub fn math_lu_decomp_buffer_scale(s : MathludecompBuffer, f : Double) -> MathludecompBuffer {
  let result = math_lu_decomp_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_lu_decomp_buffer_add(a : MathludecompBuffer, b : MathludecompBuffer) -> MathludecompBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_lu_decomp_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_lu_decomp_buffer_copy(s : MathludecompBuffer) -> MathludecompBuffer {
  let result = math_lu_decomp_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_lu_decomp_buffer_fill(s : MathludecompBuffer, v : Double) -> MathludecompBuffer {
  let result = math_lu_decomp_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_lu_decomp_buffer_min(s : MathludecompBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_lu_decomp_buffer_max(s : MathludecompBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_lu_decomp_buffer_to_string(s : MathludecompBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathludecompCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_lu_decomp_cursor_make(size : Int) -> MathludecompCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_lu_decomp_cursor_len(s : MathludecompCursor) -> Int { s.size }

pub fn math_lu_decomp_cursor_get(s : MathludecompCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_lu_decomp_cursor_set(s : MathludecompCursor, i : Int, v : Double) -> MathludecompCursor {
  let result = math_lu_decomp_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_lu_decomp_cursor_sum(s : MathludecompCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_lu_decomp_cursor_mean(s : MathludecompCursor) -> Double {
  if s.size == 0 { 0.0 } else { math_lu_decomp_cursor_sum(s) / s.size.to_double() }
}

pub fn math_lu_decomp_cursor_scale(s : MathludecompCursor, f : Double) -> MathludecompCursor {
  let result = math_lu_decomp_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_lu_decomp_cursor_add(a : MathludecompCursor, b : MathludecompCursor) -> MathludecompCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_lu_decomp_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_lu_decomp_cursor_copy(s : MathludecompCursor) -> MathludecompCursor {
  let result = math_lu_decomp_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_lu_decomp_cursor_fill(s : MathludecompCursor, v : Double) -> MathludecompCursor {
  let result = math_lu_decomp_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_lu_decomp_cursor_min(s : MathludecompCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_lu_decomp_cursor_max(s : MathludecompCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_lu_decomp_cursor_to_string(s : MathludecompCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathludecompView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_lu_decomp_view_make(size : Int) -> MathludecompView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_lu_decomp_view_len(s : MathludecompView) -> Int { s.size }

pub fn math_lu_decomp_view_get(s : MathludecompView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_lu_decomp_view_set(s : MathludecompView, i : Int, v : Double) -> MathludecompView {
  let result = math_lu_decomp_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_lu_decomp_view_sum(s : MathludecompView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_lu_decomp_view_mean(s : MathludecompView) -> Double {
  if s.size == 0 { 0.0 } else { math_lu_decomp_view_sum(s) / s.size.to_double() }
}

pub fn math_lu_decomp_view_scale(s : MathludecompView, f : Double) -> MathludecompView {
  let result = math_lu_decomp_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_lu_decomp_view_add(a : MathludecompView, b : MathludecompView) -> MathludecompView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_lu_decomp_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_lu_decomp_view_copy(s : MathludecompView) -> MathludecompView {
  let result = math_lu_decomp_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_lu_decomp_view_fill(s : MathludecompView, v : Double) -> MathludecompView {
  let result = math_lu_decomp_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_lu_decomp_view_min(s : MathludecompView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_lu_decomp_view_max(s : MathludecompView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_lu_decomp_view_to_string(s : MathludecompView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathludecompRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_lu_decomp_range_make(size : Int) -> MathludecompRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_lu_decomp_range_len(s : MathludecompRange) -> Int { s.size }

pub fn math_lu_decomp_range_get(s : MathludecompRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_lu_decomp_range_set(s : MathludecompRange, i : Int, v : Double) -> MathludecompRange {
  let result = math_lu_decomp_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_lu_decomp_range_sum(s : MathludecompRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_lu_decomp_range_mean(s : MathludecompRange) -> Double {
  if s.size == 0 { 0.0 } else { math_lu_decomp_range_sum(s) / s.size.to_double() }
}

pub fn math_lu_decomp_range_scale(s : MathludecompRange, f : Double) -> MathludecompRange {
  let result = math_lu_decomp_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_lu_decomp_range_add(a : MathludecompRange, b : MathludecompRange) -> MathludecompRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_lu_decomp_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_lu_decomp_range_copy(s : MathludecompRange) -> MathludecompRange {
  let result = math_lu_decomp_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_lu_decomp_range_fill(s : MathludecompRange, v : Double) -> MathludecompRange {
  let result = math_lu_decomp_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_lu_decomp_range_min(s : MathludecompRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_lu_decomp_range_max(s : MathludecompRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_lu_decomp_range_to_string(s : MathludecompRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathludecompSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_lu_decomp_slice_make(size : Int) -> MathludecompSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_lu_decomp_slice_len(s : MathludecompSlice) -> Int { s.size }

pub fn math_lu_decomp_slice_get(s : MathludecompSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_lu_decomp_slice_set(s : MathludecompSlice, i : Int, v : Double) -> MathludecompSlice {
  let result = math_lu_decomp_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_lu_decomp_slice_sum(s : MathludecompSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_lu_decomp_slice_mean(s : MathludecompSlice) -> Double {
  if s.size == 0 { 0.0 } else { math_lu_decomp_slice_sum(s) / s.size.to_double() }
}

pub fn math_lu_decomp_slice_scale(s : MathludecompSlice, f : Double) -> MathludecompSlice {
  let result = math_lu_decomp_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_lu_decomp_slice_add(a : MathludecompSlice, b : MathludecompSlice) -> MathludecompSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_lu_decomp_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_lu_decomp_slice_copy(s : MathludecompSlice) -> MathludecompSlice {
  let result = math_lu_decomp_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_lu_decomp_slice_fill(s : MathludecompSlice, v : Double) -> MathludecompSlice {
  let result = math_lu_decomp_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_lu_decomp_slice_min(s : MathludecompSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_lu_decomp_slice_max(s : MathludecompSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_lu_decomp_slice_to_string(s : MathludecompSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


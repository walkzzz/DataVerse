///===
/// extcore/opt_grad_adamax

pub(all) struct OptgradadamaxPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn opt_grad_adamax_make_point(x : Double, y : Double) -> OptgradadamaxPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn opt_grad_adamax_make_point3(x : Double, y : Double, z : Double) -> OptgradadamaxPoint {
  { x, y, z, label: 0 }
}

pub fn opt_grad_adamax_point_x(pt : OptgradadamaxPoint) -> Double { pt.x }

pub fn opt_grad_adamax_point_y(pt : OptgradadamaxPoint) -> Double { pt.y }

pub fn opt_grad_adamax_point_z(pt : OptgradadamaxPoint) -> Double { pt.z }

pub fn opt_grad_adamax_point_label(pt : OptgradadamaxPoint) -> Int { pt.label }

pub fn opt_grad_adamax_point_dist(a : OptgradadamaxPoint, b : OptgradadamaxPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn opt_grad_adamax_point_add(a : OptgradadamaxPoint, b : OptgradadamaxPoint) -> OptgradadamaxPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn opt_grad_adamax_point_sub(a : OptgradadamaxPoint, b : OptgradadamaxPoint) -> OptgradadamaxPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn opt_grad_adamax_point_scale(pt : OptgradadamaxPoint, s : Double) -> OptgradadamaxPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn opt_grad_adamax_point_dot(a : OptgradadamaxPoint, b : OptgradadamaxPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn opt_grad_adamax_point_cross(a : OptgradadamaxPoint, b : OptgradadamaxPoint) -> OptgradadamaxPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn opt_grad_adamax_point_norm(pt : OptgradadamaxPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn opt_grad_adamax_point_normalize(pt : OptgradadamaxPoint) -> OptgradadamaxPoint {
  let n = opt_grad_adamax_point_norm(pt)
  if n < 0.0000001 { pt } else { opt_grad_adamax_point_scale(pt, 1.0 / n) }
}

pub fn opt_grad_adamax_point_negate(pt : OptgradadamaxPoint) -> OptgradadamaxPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn opt_grad_adamax_point_mid(a : OptgradadamaxPoint, b : OptgradadamaxPoint) -> OptgradadamaxPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn opt_grad_adamax_point_lerp(a : OptgradadamaxPoint, b : OptgradadamaxPoint, t : Double) -> OptgradadamaxPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn opt_grad_adamax_point_to_string(pt : OptgradadamaxPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct OptgradadamaxSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn opt_grad_adamax_make_series(vals : Array[Double], name : String) -> OptgradadamaxSeries {
  { vals, name, meta: 0 }
}

pub fn opt_grad_adamax_series_len(s : OptgradadamaxSeries) -> Int { s.vals.length() }

pub fn opt_grad_adamax_series_sum(s : OptgradadamaxSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn opt_grad_adamax_series_mean(s : OptgradadamaxSeries) -> Double {
  let n = opt_grad_adamax_series_len(s)
  if n == 0 { 0.0 } else { opt_grad_adamax_series_sum(s) / n.to_double() }
}

pub fn opt_grad_adamax_series_min(s : OptgradadamaxSeries) -> Double {
  let n = opt_grad_adamax_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn opt_grad_adamax_series_max(s : OptgradadamaxSeries) -> Double {
  let n = opt_grad_adamax_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn opt_grad_adamax_series_range(s : OptgradadamaxSeries) -> Double {
  opt_grad_adamax_series_max(s) - opt_grad_adamax_series_min(s)
}

pub fn opt_grad_adamax_series_var(s : OptgradadamaxSeries) -> Double {
  let n = opt_grad_adamax_series_len(s)
  if n == 0 { 0.0 } else {
    let m = opt_grad_adamax_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn opt_grad_adamax_series_std(s : OptgradadamaxSeries) -> Double { @_common.sqrt(opt_grad_adamax_series_var(s)) }

pub fn opt_grad_adamax_series_median(s : OptgradadamaxSeries) -> Double {
  let n = opt_grad_adamax_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = opt_grad_adamax_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn opt_grad_adamax_series_scale(s : OptgradadamaxSeries, f : Double) -> OptgradadamaxSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn opt_grad_adamax_series_add(a : OptgradadamaxSeries, b : OptgradadamaxSeries) -> OptgradadamaxSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn opt_grad_adamax_series_sub(a : OptgradadamaxSeries, b : OptgradadamaxSeries) -> OptgradadamaxSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn opt_grad_adamax_series_normalize(s : OptgradadamaxSeries) -> OptgradadamaxSeries {
  let mn = opt_grad_adamax_series_min(s)
  let mx = opt_grad_adamax_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn opt_grad_adamax_series_cumsum(s : OptgradadamaxSeries) -> OptgradadamaxSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn opt_grad_adamax_series_to_string(s : OptgradadamaxSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct OptgradadamaxMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn opt_grad_adamax_make_matrix(rows : Int, cols : Int, val : Double) -> OptgradadamaxMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn opt_grad_adamax_matrix_identity(n : Int) -> OptgradadamaxMatrix {
  let m = opt_grad_adamax_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn opt_grad_adamax_matrix_get(m : OptgradadamaxMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn opt_grad_adamax_matrix_transpose(m : OptgradadamaxMatrix) -> OptgradadamaxMatrix {
  let result = opt_grad_adamax_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn opt_grad_adamax_matrix_add(a : OptgradadamaxMatrix, b : OptgradadamaxMatrix) -> OptgradadamaxMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = opt_grad_adamax_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn opt_grad_adamax_matrix_scale(m : OptgradadamaxMatrix, s : Double) -> OptgradadamaxMatrix {
  let result = opt_grad_adamax_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn opt_grad_adamax_matrix_multiply(a : OptgradadamaxMatrix, b : OptgradadamaxMatrix) -> OptgradadamaxMatrix {
  if a.cols != b.rows { return opt_grad_adamax_make_matrix(a.rows, b.cols, 0.0) }
  let result = opt_grad_adamax_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn opt_grad_adamax_matrix_trace(m : OptgradadamaxMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn opt_grad_adamax_matrix_det(m : OptgradadamaxMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn opt_grad_adamax_matrix_norm(m : OptgradadamaxMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn opt_grad_adamax_matrix_to_string(m : OptgradadamaxMatrix) -> String {
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

pub(all) struct OptgradadamaxVector {
  comps : Array[Double]
  dim : Int
}

pub fn opt_grad_adamax_make_vector(comps : Array[Double]) -> OptgradadamaxVector {
  { comps, dim: comps.length() }
}

pub fn opt_grad_adamax_vector_zero(dim : Int) -> OptgradadamaxVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn opt_grad_adamax_vector_add(a : OptgradadamaxVector, b : OptgradadamaxVector) -> OptgradadamaxVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn opt_grad_adamax_vector_sub(a : OptgradadamaxVector, b : OptgradadamaxVector) -> OptgradadamaxVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn opt_grad_adamax_vector_scale(v : OptgradadamaxVector, s : Double) -> OptgradadamaxVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn opt_grad_adamax_vector_dot(a : OptgradadamaxVector, b : OptgradadamaxVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn opt_grad_adamax_vector_norm(v : OptgradadamaxVector) -> Double { @_common.sqrt(opt_grad_adamax_vector_dot(v, v)) }

pub fn opt_grad_adamax_vector_normalize(v : OptgradadamaxVector) -> OptgradadamaxVector {
  let n = opt_grad_adamax_vector_norm(v)
  if n < 0.0000001 { v } else { opt_grad_adamax_vector_scale(v, 1.0 / n) }
}

pub fn opt_grad_adamax_vector_dist(a : OptgradadamaxVector, b : OptgradadamaxVector) -> Double {
  opt_grad_adamax_vector_norm(opt_grad_adamax_vector_sub(a, b))
}

pub fn opt_grad_adamax_vector_to_string(v : OptgradadamaxVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn opt_grad_adamax_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn opt_grad_adamax_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = opt_grad_adamax_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn opt_grad_adamax_std(data : Array[Double]) -> Double { @_common.sqrt(opt_grad_adamax_var(data)) }

pub fn opt_grad_adamax_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = opt_grad_adamax_mean(a); let mb = opt_grad_adamax_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn opt_grad_adamax_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = opt_grad_adamax_std(a); let sb = opt_grad_adamax_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { opt_grad_adamax_cov(a, b) / (sa * sb) }
}

pub fn opt_grad_adamax_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = opt_grad_adamax_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn opt_grad_adamax_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn opt_grad_adamax_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn opt_grad_adamax_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(opt_grad_adamax_mse(pred, labels))
}

pub fn opt_grad_adamax_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn opt_grad_adamax_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = opt_grad_adamax_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn opt_grad_adamax_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn opt_grad_adamax_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn opt_grad_adamax_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = opt_grad_adamax_precision(pred, labels, pos); let r = opt_grad_adamax_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn opt_grad_adamax_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn opt_grad_adamax_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = opt_grad_adamax_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn opt_grad_adamax_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn opt_grad_adamax_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn opt_grad_adamax_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = opt_grad_adamax_gcd(a, b)
    (a / g) * b
  }
}

pub fn opt_grad_adamax_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn opt_grad_adamax_fibonacci(n : Int) -> Int {
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

pub fn opt_grad_adamax_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = opt_grad_adamax_min(data); let mx = opt_grad_adamax_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn opt_grad_adamax_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = opt_grad_adamax_mean(data); let sd = opt_grad_adamax_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn opt_grad_adamax_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn opt_grad_adamax_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn opt_grad_adamax_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn opt_grad_adamax_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn opt_grad_adamax_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn opt_grad_adamax_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct OptgradadamaxFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adamax_frame_make(size : Int) -> OptgradadamaxFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adamax_frame_len(s : OptgradadamaxFrame) -> Int { s.size }

pub fn opt_grad_adamax_frame_get(s : OptgradadamaxFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adamax_frame_set(s : OptgradadamaxFrame, i : Int, v : Double) -> OptgradadamaxFrame {
  let result = opt_grad_adamax_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_adamax_frame_sum(s : OptgradadamaxFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_adamax_frame_mean(s : OptgradadamaxFrame) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_adamax_frame_sum(s) / s.size.to_double() }
}

pub fn opt_grad_adamax_frame_scale(s : OptgradadamaxFrame, f : Double) -> OptgradadamaxFrame {
  let result = opt_grad_adamax_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_adamax_frame_add(a : OptgradadamaxFrame, b : OptgradadamaxFrame) -> OptgradadamaxFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_adamax_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_adamax_frame_copy(s : OptgradadamaxFrame) -> OptgradadamaxFrame {
  let result = opt_grad_adamax_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_adamax_frame_fill(s : OptgradadamaxFrame, v : Double) -> OptgradadamaxFrame {
  let result = opt_grad_adamax_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_adamax_frame_min(s : OptgradadamaxFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_adamax_frame_max(s : OptgradadamaxFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_adamax_frame_to_string(s : OptgradadamaxFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradadamaxTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adamax_table_make(size : Int) -> OptgradadamaxTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adamax_table_len(s : OptgradadamaxTable) -> Int { s.size }

pub fn opt_grad_adamax_table_get(s : OptgradadamaxTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adamax_table_set(s : OptgradadamaxTable, i : Int, v : Double) -> OptgradadamaxTable {
  let result = opt_grad_adamax_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_adamax_table_sum(s : OptgradadamaxTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_adamax_table_mean(s : OptgradadamaxTable) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_adamax_table_sum(s) / s.size.to_double() }
}

pub fn opt_grad_adamax_table_scale(s : OptgradadamaxTable, f : Double) -> OptgradadamaxTable {
  let result = opt_grad_adamax_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_adamax_table_add(a : OptgradadamaxTable, b : OptgradadamaxTable) -> OptgradadamaxTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_adamax_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_adamax_table_copy(s : OptgradadamaxTable) -> OptgradadamaxTable {
  let result = opt_grad_adamax_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_adamax_table_fill(s : OptgradadamaxTable, v : Double) -> OptgradadamaxTable {
  let result = opt_grad_adamax_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_adamax_table_min(s : OptgradadamaxTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_adamax_table_max(s : OptgradadamaxTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_adamax_table_to_string(s : OptgradadamaxTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradadamaxGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adamax_graphn_make(size : Int) -> OptgradadamaxGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adamax_graphn_len(s : OptgradadamaxGraphN) -> Int { s.size }

pub fn opt_grad_adamax_graphn_get(s : OptgradadamaxGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adamax_graphn_set(s : OptgradadamaxGraphN, i : Int, v : Double) -> OptgradadamaxGraphN {
  let result = opt_grad_adamax_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_adamax_graphn_sum(s : OptgradadamaxGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_adamax_graphn_mean(s : OptgradadamaxGraphN) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_adamax_graphn_sum(s) / s.size.to_double() }
}

pub fn opt_grad_adamax_graphn_scale(s : OptgradadamaxGraphN, f : Double) -> OptgradadamaxGraphN {
  let result = opt_grad_adamax_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_adamax_graphn_add(a : OptgradadamaxGraphN, b : OptgradadamaxGraphN) -> OptgradadamaxGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_adamax_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_adamax_graphn_copy(s : OptgradadamaxGraphN) -> OptgradadamaxGraphN {
  let result = opt_grad_adamax_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_adamax_graphn_fill(s : OptgradadamaxGraphN, v : Double) -> OptgradadamaxGraphN {
  let result = opt_grad_adamax_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_adamax_graphn_min(s : OptgradadamaxGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_adamax_graphn_max(s : OptgradadamaxGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_adamax_graphn_to_string(s : OptgradadamaxGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradadamaxNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adamax_node_make(size : Int) -> OptgradadamaxNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adamax_node_len(s : OptgradadamaxNode) -> Int { s.size }

pub fn opt_grad_adamax_node_get(s : OptgradadamaxNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adamax_node_set(s : OptgradadamaxNode, i : Int, v : Double) -> OptgradadamaxNode {
  let result = opt_grad_adamax_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_adamax_node_sum(s : OptgradadamaxNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_adamax_node_mean(s : OptgradadamaxNode) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_adamax_node_sum(s) / s.size.to_double() }
}

pub fn opt_grad_adamax_node_scale(s : OptgradadamaxNode, f : Double) -> OptgradadamaxNode {
  let result = opt_grad_adamax_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_adamax_node_add(a : OptgradadamaxNode, b : OptgradadamaxNode) -> OptgradadamaxNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_adamax_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_adamax_node_copy(s : OptgradadamaxNode) -> OptgradadamaxNode {
  let result = opt_grad_adamax_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_adamax_node_fill(s : OptgradadamaxNode, v : Double) -> OptgradadamaxNode {
  let result = opt_grad_adamax_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_adamax_node_min(s : OptgradadamaxNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_adamax_node_max(s : OptgradadamaxNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_adamax_node_to_string(s : OptgradadamaxNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradadamaxEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adamax_edge_make(size : Int) -> OptgradadamaxEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adamax_edge_len(s : OptgradadamaxEdge) -> Int { s.size }

pub fn opt_grad_adamax_edge_get(s : OptgradadamaxEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adamax_edge_set(s : OptgradadamaxEdge, i : Int, v : Double) -> OptgradadamaxEdge {
  let result = opt_grad_adamax_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_adamax_edge_sum(s : OptgradadamaxEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_adamax_edge_mean(s : OptgradadamaxEdge) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_adamax_edge_sum(s) / s.size.to_double() }
}

pub fn opt_grad_adamax_edge_scale(s : OptgradadamaxEdge, f : Double) -> OptgradadamaxEdge {
  let result = opt_grad_adamax_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_adamax_edge_add(a : OptgradadamaxEdge, b : OptgradadamaxEdge) -> OptgradadamaxEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_adamax_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_adamax_edge_copy(s : OptgradadamaxEdge) -> OptgradadamaxEdge {
  let result = opt_grad_adamax_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_adamax_edge_fill(s : OptgradadamaxEdge, v : Double) -> OptgradadamaxEdge {
  let result = opt_grad_adamax_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_adamax_edge_min(s : OptgradadamaxEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_adamax_edge_max(s : OptgradadamaxEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_adamax_edge_to_string(s : OptgradadamaxEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradadamaxPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adamax_path_make(size : Int) -> OptgradadamaxPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adamax_path_len(s : OptgradadamaxPath) -> Int { s.size }

pub fn opt_grad_adamax_path_get(s : OptgradadamaxPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adamax_path_set(s : OptgradadamaxPath, i : Int, v : Double) -> OptgradadamaxPath {
  let result = opt_grad_adamax_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_adamax_path_sum(s : OptgradadamaxPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_adamax_path_mean(s : OptgradadamaxPath) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_adamax_path_sum(s) / s.size.to_double() }
}

pub fn opt_grad_adamax_path_scale(s : OptgradadamaxPath, f : Double) -> OptgradadamaxPath {
  let result = opt_grad_adamax_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_adamax_path_add(a : OptgradadamaxPath, b : OptgradadamaxPath) -> OptgradadamaxPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_adamax_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_adamax_path_copy(s : OptgradadamaxPath) -> OptgradadamaxPath {
  let result = opt_grad_adamax_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_adamax_path_fill(s : OptgradadamaxPath, v : Double) -> OptgradadamaxPath {
  let result = opt_grad_adamax_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_adamax_path_min(s : OptgradadamaxPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_adamax_path_max(s : OptgradadamaxPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_adamax_path_to_string(s : OptgradadamaxPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradadamaxCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adamax_cluster_make(size : Int) -> OptgradadamaxCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adamax_cluster_len(s : OptgradadamaxCluster) -> Int { s.size }

pub fn opt_grad_adamax_cluster_get(s : OptgradadamaxCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adamax_cluster_set(s : OptgradadamaxCluster, i : Int, v : Double) -> OptgradadamaxCluster {
  let result = opt_grad_adamax_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_adamax_cluster_sum(s : OptgradadamaxCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_adamax_cluster_mean(s : OptgradadamaxCluster) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_adamax_cluster_sum(s) / s.size.to_double() }
}

pub fn opt_grad_adamax_cluster_scale(s : OptgradadamaxCluster, f : Double) -> OptgradadamaxCluster {
  let result = opt_grad_adamax_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_adamax_cluster_add(a : OptgradadamaxCluster, b : OptgradadamaxCluster) -> OptgradadamaxCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_adamax_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_adamax_cluster_copy(s : OptgradadamaxCluster) -> OptgradadamaxCluster {
  let result = opt_grad_adamax_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_adamax_cluster_fill(s : OptgradadamaxCluster, v : Double) -> OptgradadamaxCluster {
  let result = opt_grad_adamax_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_adamax_cluster_min(s : OptgradadamaxCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_adamax_cluster_max(s : OptgradadamaxCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_adamax_cluster_to_string(s : OptgradadamaxCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradadamaxModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adamax_model_make(size : Int) -> OptgradadamaxModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adamax_model_len(s : OptgradadamaxModel) -> Int { s.size }

pub fn opt_grad_adamax_model_get(s : OptgradadamaxModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adamax_model_set(s : OptgradadamaxModel, i : Int, v : Double) -> OptgradadamaxModel {
  let result = opt_grad_adamax_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_adamax_model_sum(s : OptgradadamaxModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_adamax_model_mean(s : OptgradadamaxModel) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_adamax_model_sum(s) / s.size.to_double() }
}

pub fn opt_grad_adamax_model_scale(s : OptgradadamaxModel, f : Double) -> OptgradadamaxModel {
  let result = opt_grad_adamax_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_adamax_model_add(a : OptgradadamaxModel, b : OptgradadamaxModel) -> OptgradadamaxModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_adamax_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_adamax_model_copy(s : OptgradadamaxModel) -> OptgradadamaxModel {
  let result = opt_grad_adamax_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_adamax_model_fill(s : OptgradadamaxModel, v : Double) -> OptgradadamaxModel {
  let result = opt_grad_adamax_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_adamax_model_min(s : OptgradadamaxModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_adamax_model_max(s : OptgradadamaxModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_adamax_model_to_string(s : OptgradadamaxModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradadamaxLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adamax_layer_make(size : Int) -> OptgradadamaxLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adamax_layer_len(s : OptgradadamaxLayer) -> Int { s.size }

pub fn opt_grad_adamax_layer_get(s : OptgradadamaxLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adamax_layer_set(s : OptgradadamaxLayer, i : Int, v : Double) -> OptgradadamaxLayer {
  let result = opt_grad_adamax_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_adamax_layer_sum(s : OptgradadamaxLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_adamax_layer_mean(s : OptgradadamaxLayer) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_adamax_layer_sum(s) / s.size.to_double() }
}

pub fn opt_grad_adamax_layer_scale(s : OptgradadamaxLayer, f : Double) -> OptgradadamaxLayer {
  let result = opt_grad_adamax_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_adamax_layer_add(a : OptgradadamaxLayer, b : OptgradadamaxLayer) -> OptgradadamaxLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_adamax_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_adamax_layer_copy(s : OptgradadamaxLayer) -> OptgradadamaxLayer {
  let result = opt_grad_adamax_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_adamax_layer_fill(s : OptgradadamaxLayer, v : Double) -> OptgradadamaxLayer {
  let result = opt_grad_adamax_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_adamax_layer_min(s : OptgradadamaxLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_adamax_layer_max(s : OptgradadamaxLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_adamax_layer_to_string(s : OptgradadamaxLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradadamaxBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adamax_buffer_make(size : Int) -> OptgradadamaxBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adamax_buffer_len(s : OptgradadamaxBuffer) -> Int { s.size }

pub fn opt_grad_adamax_buffer_get(s : OptgradadamaxBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adamax_buffer_set(s : OptgradadamaxBuffer, i : Int, v : Double) -> OptgradadamaxBuffer {
  let result = opt_grad_adamax_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_adamax_buffer_sum(s : OptgradadamaxBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_adamax_buffer_mean(s : OptgradadamaxBuffer) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_adamax_buffer_sum(s) / s.size.to_double() }
}

pub fn opt_grad_adamax_buffer_scale(s : OptgradadamaxBuffer, f : Double) -> OptgradadamaxBuffer {
  let result = opt_grad_adamax_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_adamax_buffer_add(a : OptgradadamaxBuffer, b : OptgradadamaxBuffer) -> OptgradadamaxBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_adamax_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_adamax_buffer_copy(s : OptgradadamaxBuffer) -> OptgradadamaxBuffer {
  let result = opt_grad_adamax_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_adamax_buffer_fill(s : OptgradadamaxBuffer, v : Double) -> OptgradadamaxBuffer {
  let result = opt_grad_adamax_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_adamax_buffer_min(s : OptgradadamaxBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_adamax_buffer_max(s : OptgradadamaxBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_adamax_buffer_to_string(s : OptgradadamaxBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradadamaxCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adamax_cursor_make(size : Int) -> OptgradadamaxCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adamax_cursor_len(s : OptgradadamaxCursor) -> Int { s.size }

pub fn opt_grad_adamax_cursor_get(s : OptgradadamaxCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adamax_cursor_set(s : OptgradadamaxCursor, i : Int, v : Double) -> OptgradadamaxCursor {
  let result = opt_grad_adamax_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_adamax_cursor_sum(s : OptgradadamaxCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_adamax_cursor_mean(s : OptgradadamaxCursor) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_adamax_cursor_sum(s) / s.size.to_double() }
}

pub fn opt_grad_adamax_cursor_scale(s : OptgradadamaxCursor, f : Double) -> OptgradadamaxCursor {
  let result = opt_grad_adamax_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_adamax_cursor_add(a : OptgradadamaxCursor, b : OptgradadamaxCursor) -> OptgradadamaxCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_adamax_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_adamax_cursor_copy(s : OptgradadamaxCursor) -> OptgradadamaxCursor {
  let result = opt_grad_adamax_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_adamax_cursor_fill(s : OptgradadamaxCursor, v : Double) -> OptgradadamaxCursor {
  let result = opt_grad_adamax_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_adamax_cursor_min(s : OptgradadamaxCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_adamax_cursor_max(s : OptgradadamaxCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_adamax_cursor_to_string(s : OptgradadamaxCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradadamaxView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adamax_view_make(size : Int) -> OptgradadamaxView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adamax_view_len(s : OptgradadamaxView) -> Int { s.size }

pub fn opt_grad_adamax_view_get(s : OptgradadamaxView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adamax_view_set(s : OptgradadamaxView, i : Int, v : Double) -> OptgradadamaxView {
  let result = opt_grad_adamax_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_adamax_view_sum(s : OptgradadamaxView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_adamax_view_mean(s : OptgradadamaxView) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_adamax_view_sum(s) / s.size.to_double() }
}

pub fn opt_grad_adamax_view_scale(s : OptgradadamaxView, f : Double) -> OptgradadamaxView {
  let result = opt_grad_adamax_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_adamax_view_add(a : OptgradadamaxView, b : OptgradadamaxView) -> OptgradadamaxView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_adamax_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_adamax_view_copy(s : OptgradadamaxView) -> OptgradadamaxView {
  let result = opt_grad_adamax_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_adamax_view_fill(s : OptgradadamaxView, v : Double) -> OptgradadamaxView {
  let result = opt_grad_adamax_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_adamax_view_min(s : OptgradadamaxView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_adamax_view_max(s : OptgradadamaxView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_adamax_view_to_string(s : OptgradadamaxView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradadamaxRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adamax_range_make(size : Int) -> OptgradadamaxRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adamax_range_len(s : OptgradadamaxRange) -> Int { s.size }

pub fn opt_grad_adamax_range_get(s : OptgradadamaxRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adamax_range_set(s : OptgradadamaxRange, i : Int, v : Double) -> OptgradadamaxRange {
  let result = opt_grad_adamax_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_adamax_range_sum(s : OptgradadamaxRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_adamax_range_mean(s : OptgradadamaxRange) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_adamax_range_sum(s) / s.size.to_double() }
}

pub fn opt_grad_adamax_range_scale(s : OptgradadamaxRange, f : Double) -> OptgradadamaxRange {
  let result = opt_grad_adamax_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_adamax_range_add(a : OptgradadamaxRange, b : OptgradadamaxRange) -> OptgradadamaxRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_adamax_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_adamax_range_copy(s : OptgradadamaxRange) -> OptgradadamaxRange {
  let result = opt_grad_adamax_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_adamax_range_fill(s : OptgradadamaxRange, v : Double) -> OptgradadamaxRange {
  let result = opt_grad_adamax_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_adamax_range_min(s : OptgradadamaxRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_adamax_range_max(s : OptgradadamaxRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_adamax_range_to_string(s : OptgradadamaxRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradadamaxSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adamax_slice_make(size : Int) -> OptgradadamaxSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adamax_slice_len(s : OptgradadamaxSlice) -> Int { s.size }

pub fn opt_grad_adamax_slice_get(s : OptgradadamaxSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adamax_slice_set(s : OptgradadamaxSlice, i : Int, v : Double) -> OptgradadamaxSlice {
  let result = opt_grad_adamax_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_adamax_slice_sum(s : OptgradadamaxSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_adamax_slice_mean(s : OptgradadamaxSlice) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_adamax_slice_sum(s) / s.size.to_double() }
}

pub fn opt_grad_adamax_slice_scale(s : OptgradadamaxSlice, f : Double) -> OptgradadamaxSlice {
  let result = opt_grad_adamax_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_adamax_slice_add(a : OptgradadamaxSlice, b : OptgradadamaxSlice) -> OptgradadamaxSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_adamax_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_adamax_slice_copy(s : OptgradadamaxSlice) -> OptgradadamaxSlice {
  let result = opt_grad_adamax_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_adamax_slice_fill(s : OptgradadamaxSlice, v : Double) -> OptgradadamaxSlice {
  let result = opt_grad_adamax_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_adamax_slice_min(s : OptgradadamaxSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_adamax_slice_max(s : OptgradadamaxSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_adamax_slice_to_string(s : OptgradadamaxSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


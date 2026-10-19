///===
/// extcore/opt_grad_adagrad

pub(all) struct OptgradadagradPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn opt_grad_adagrad_make_point(x : Double, y : Double) -> OptgradadagradPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn opt_grad_adagrad_make_point3(x : Double, y : Double, z : Double) -> OptgradadagradPoint {
  { x, y, z, label: 0 }
}

pub fn opt_grad_adagrad_point_x(pt : OptgradadagradPoint) -> Double { pt.x }

pub fn opt_grad_adagrad_point_y(pt : OptgradadagradPoint) -> Double { pt.y }

pub fn opt_grad_adagrad_point_z(pt : OptgradadagradPoint) -> Double { pt.z }

pub fn opt_grad_adagrad_point_label(pt : OptgradadagradPoint) -> Int { pt.label }

pub fn opt_grad_adagrad_point_dist(a : OptgradadagradPoint, b : OptgradadagradPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn opt_grad_adagrad_point_add(a : OptgradadagradPoint, b : OptgradadagradPoint) -> OptgradadagradPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn opt_grad_adagrad_point_sub(a : OptgradadagradPoint, b : OptgradadagradPoint) -> OptgradadagradPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn opt_grad_adagrad_point_scale(pt : OptgradadagradPoint, s : Double) -> OptgradadagradPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn opt_grad_adagrad_point_dot(a : OptgradadagradPoint, b : OptgradadagradPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn opt_grad_adagrad_point_cross(a : OptgradadagradPoint, b : OptgradadagradPoint) -> OptgradadagradPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn opt_grad_adagrad_point_norm(pt : OptgradadagradPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn opt_grad_adagrad_point_normalize(pt : OptgradadagradPoint) -> OptgradadagradPoint {
  let n = opt_grad_adagrad_point_norm(pt)
  if n < 0.0000001 { pt } else { opt_grad_adagrad_point_scale(pt, 1.0 / n) }
}

pub fn opt_grad_adagrad_point_negate(pt : OptgradadagradPoint) -> OptgradadagradPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn opt_grad_adagrad_point_mid(a : OptgradadagradPoint, b : OptgradadagradPoint) -> OptgradadagradPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn opt_grad_adagrad_point_lerp(a : OptgradadagradPoint, b : OptgradadagradPoint, t : Double) -> OptgradadagradPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn opt_grad_adagrad_point_to_string(pt : OptgradadagradPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct OptgradadagradSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn opt_grad_adagrad_make_series(vals : Array[Double], name : String) -> OptgradadagradSeries {
  { vals, name, meta: 0 }
}

pub fn opt_grad_adagrad_series_len(s : OptgradadagradSeries) -> Int { s.vals.length() }

pub fn opt_grad_adagrad_series_sum(s : OptgradadagradSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn opt_grad_adagrad_series_mean(s : OptgradadagradSeries) -> Double {
  let n = opt_grad_adagrad_series_len(s)
  if n == 0 { 0.0 } else { opt_grad_adagrad_series_sum(s) / n.to_double() }
}

pub fn opt_grad_adagrad_series_min(s : OptgradadagradSeries) -> Double {
  let n = opt_grad_adagrad_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn opt_grad_adagrad_series_max(s : OptgradadagradSeries) -> Double {
  let n = opt_grad_adagrad_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn opt_grad_adagrad_series_range(s : OptgradadagradSeries) -> Double {
  opt_grad_adagrad_series_max(s) - opt_grad_adagrad_series_min(s)
}

pub fn opt_grad_adagrad_series_var(s : OptgradadagradSeries) -> Double {
  let n = opt_grad_adagrad_series_len(s)
  if n == 0 { 0.0 } else {
    let m = opt_grad_adagrad_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn opt_grad_adagrad_series_std(s : OptgradadagradSeries) -> Double { @_common.sqrt(opt_grad_adagrad_series_var(s)) }

pub fn opt_grad_adagrad_series_median(s : OptgradadagradSeries) -> Double {
  let n = opt_grad_adagrad_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = opt_grad_adagrad_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn opt_grad_adagrad_series_scale(s : OptgradadagradSeries, f : Double) -> OptgradadagradSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn opt_grad_adagrad_series_add(a : OptgradadagradSeries, b : OptgradadagradSeries) -> OptgradadagradSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn opt_grad_adagrad_series_sub(a : OptgradadagradSeries, b : OptgradadagradSeries) -> OptgradadagradSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn opt_grad_adagrad_series_normalize(s : OptgradadagradSeries) -> OptgradadagradSeries {
  let mn = opt_grad_adagrad_series_min(s)
  let mx = opt_grad_adagrad_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn opt_grad_adagrad_series_cumsum(s : OptgradadagradSeries) -> OptgradadagradSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn opt_grad_adagrad_series_to_string(s : OptgradadagradSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct OptgradadagradMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn opt_grad_adagrad_make_matrix(rows : Int, cols : Int, val : Double) -> OptgradadagradMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn opt_grad_adagrad_matrix_identity(n : Int) -> OptgradadagradMatrix {
  let m = opt_grad_adagrad_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn opt_grad_adagrad_matrix_get(m : OptgradadagradMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn opt_grad_adagrad_matrix_transpose(m : OptgradadagradMatrix) -> OptgradadagradMatrix {
  let result = opt_grad_adagrad_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn opt_grad_adagrad_matrix_add(a : OptgradadagradMatrix, b : OptgradadagradMatrix) -> OptgradadagradMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = opt_grad_adagrad_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn opt_grad_adagrad_matrix_scale(m : OptgradadagradMatrix, s : Double) -> OptgradadagradMatrix {
  let result = opt_grad_adagrad_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn opt_grad_adagrad_matrix_multiply(a : OptgradadagradMatrix, b : OptgradadagradMatrix) -> OptgradadagradMatrix {
  if a.cols != b.rows { return opt_grad_adagrad_make_matrix(a.rows, b.cols, 0.0) }
  let result = opt_grad_adagrad_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn opt_grad_adagrad_matrix_trace(m : OptgradadagradMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn opt_grad_adagrad_matrix_det(m : OptgradadagradMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn opt_grad_adagrad_matrix_norm(m : OptgradadagradMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn opt_grad_adagrad_matrix_to_string(m : OptgradadagradMatrix) -> String {
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

pub(all) struct OptgradadagradVector {
  comps : Array[Double]
  dim : Int
}

pub fn opt_grad_adagrad_make_vector(comps : Array[Double]) -> OptgradadagradVector {
  { comps, dim: comps.length() }
}

pub fn opt_grad_adagrad_vector_zero(dim : Int) -> OptgradadagradVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn opt_grad_adagrad_vector_add(a : OptgradadagradVector, b : OptgradadagradVector) -> OptgradadagradVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn opt_grad_adagrad_vector_sub(a : OptgradadagradVector, b : OptgradadagradVector) -> OptgradadagradVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn opt_grad_adagrad_vector_scale(v : OptgradadagradVector, s : Double) -> OptgradadagradVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn opt_grad_adagrad_vector_dot(a : OptgradadagradVector, b : OptgradadagradVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn opt_grad_adagrad_vector_norm(v : OptgradadagradVector) -> Double { @_common.sqrt(opt_grad_adagrad_vector_dot(v, v)) }

pub fn opt_grad_adagrad_vector_normalize(v : OptgradadagradVector) -> OptgradadagradVector {
  let n = opt_grad_adagrad_vector_norm(v)
  if n < 0.0000001 { v } else { opt_grad_adagrad_vector_scale(v, 1.0 / n) }
}

pub fn opt_grad_adagrad_vector_dist(a : OptgradadagradVector, b : OptgradadagradVector) -> Double {
  opt_grad_adagrad_vector_norm(opt_grad_adagrad_vector_sub(a, b))
}

pub fn opt_grad_adagrad_vector_to_string(v : OptgradadagradVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn opt_grad_adagrad_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn opt_grad_adagrad_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = opt_grad_adagrad_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn opt_grad_adagrad_std(data : Array[Double]) -> Double { @_common.sqrt(opt_grad_adagrad_var(data)) }

pub fn opt_grad_adagrad_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = opt_grad_adagrad_mean(a); let mb = opt_grad_adagrad_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn opt_grad_adagrad_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = opt_grad_adagrad_std(a); let sb = opt_grad_adagrad_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { opt_grad_adagrad_cov(a, b) / (sa * sb) }
}

pub fn opt_grad_adagrad_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = opt_grad_adagrad_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn opt_grad_adagrad_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn opt_grad_adagrad_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn opt_grad_adagrad_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(opt_grad_adagrad_mse(pred, labels))
}

pub fn opt_grad_adagrad_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn opt_grad_adagrad_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = opt_grad_adagrad_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn opt_grad_adagrad_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn opt_grad_adagrad_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn opt_grad_adagrad_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = opt_grad_adagrad_precision(pred, labels, pos); let r = opt_grad_adagrad_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn opt_grad_adagrad_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn opt_grad_adagrad_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = opt_grad_adagrad_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn opt_grad_adagrad_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn opt_grad_adagrad_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn opt_grad_adagrad_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = opt_grad_adagrad_gcd(a, b)
    (a / g) * b
  }
}

pub fn opt_grad_adagrad_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn opt_grad_adagrad_fibonacci(n : Int) -> Int {
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

pub fn opt_grad_adagrad_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = opt_grad_adagrad_min(data); let mx = opt_grad_adagrad_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn opt_grad_adagrad_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = opt_grad_adagrad_mean(data); let sd = opt_grad_adagrad_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn opt_grad_adagrad_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn opt_grad_adagrad_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn opt_grad_adagrad_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn opt_grad_adagrad_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn opt_grad_adagrad_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn opt_grad_adagrad_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct OptgradadagradFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adagrad_frame_make(size : Int) -> OptgradadagradFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adagrad_frame_len(s : OptgradadagradFrame) -> Int { s.size }

pub fn opt_grad_adagrad_frame_get(s : OptgradadagradFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adagrad_frame_set(s : OptgradadagradFrame, i : Int, v : Double) -> OptgradadagradFrame {
  let result = opt_grad_adagrad_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_adagrad_frame_sum(s : OptgradadagradFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_adagrad_frame_mean(s : OptgradadagradFrame) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_adagrad_frame_sum(s) / s.size.to_double() }
}

pub fn opt_grad_adagrad_frame_scale(s : OptgradadagradFrame, f : Double) -> OptgradadagradFrame {
  let result = opt_grad_adagrad_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_adagrad_frame_add(a : OptgradadagradFrame, b : OptgradadagradFrame) -> OptgradadagradFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_adagrad_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_adagrad_frame_copy(s : OptgradadagradFrame) -> OptgradadagradFrame {
  let result = opt_grad_adagrad_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_adagrad_frame_fill(s : OptgradadagradFrame, v : Double) -> OptgradadagradFrame {
  let result = opt_grad_adagrad_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_adagrad_frame_min(s : OptgradadagradFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_adagrad_frame_max(s : OptgradadagradFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_adagrad_frame_to_string(s : OptgradadagradFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradadagradTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adagrad_table_make(size : Int) -> OptgradadagradTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adagrad_table_len(s : OptgradadagradTable) -> Int { s.size }

pub fn opt_grad_adagrad_table_get(s : OptgradadagradTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adagrad_table_set(s : OptgradadagradTable, i : Int, v : Double) -> OptgradadagradTable {
  let result = opt_grad_adagrad_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_adagrad_table_sum(s : OptgradadagradTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_adagrad_table_mean(s : OptgradadagradTable) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_adagrad_table_sum(s) / s.size.to_double() }
}

pub fn opt_grad_adagrad_table_scale(s : OptgradadagradTable, f : Double) -> OptgradadagradTable {
  let result = opt_grad_adagrad_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_adagrad_table_add(a : OptgradadagradTable, b : OptgradadagradTable) -> OptgradadagradTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_adagrad_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_adagrad_table_copy(s : OptgradadagradTable) -> OptgradadagradTable {
  let result = opt_grad_adagrad_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_adagrad_table_fill(s : OptgradadagradTable, v : Double) -> OptgradadagradTable {
  let result = opt_grad_adagrad_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_adagrad_table_min(s : OptgradadagradTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_adagrad_table_max(s : OptgradadagradTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_adagrad_table_to_string(s : OptgradadagradTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradadagradGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adagrad_graphn_make(size : Int) -> OptgradadagradGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adagrad_graphn_len(s : OptgradadagradGraphN) -> Int { s.size }

pub fn opt_grad_adagrad_graphn_get(s : OptgradadagradGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adagrad_graphn_set(s : OptgradadagradGraphN, i : Int, v : Double) -> OptgradadagradGraphN {
  let result = opt_grad_adagrad_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_adagrad_graphn_sum(s : OptgradadagradGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_adagrad_graphn_mean(s : OptgradadagradGraphN) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_adagrad_graphn_sum(s) / s.size.to_double() }
}

pub fn opt_grad_adagrad_graphn_scale(s : OptgradadagradGraphN, f : Double) -> OptgradadagradGraphN {
  let result = opt_grad_adagrad_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_adagrad_graphn_add(a : OptgradadagradGraphN, b : OptgradadagradGraphN) -> OptgradadagradGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_adagrad_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_adagrad_graphn_copy(s : OptgradadagradGraphN) -> OptgradadagradGraphN {
  let result = opt_grad_adagrad_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_adagrad_graphn_fill(s : OptgradadagradGraphN, v : Double) -> OptgradadagradGraphN {
  let result = opt_grad_adagrad_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_adagrad_graphn_min(s : OptgradadagradGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_adagrad_graphn_max(s : OptgradadagradGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_adagrad_graphn_to_string(s : OptgradadagradGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradadagradNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adagrad_node_make(size : Int) -> OptgradadagradNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adagrad_node_len(s : OptgradadagradNode) -> Int { s.size }

pub fn opt_grad_adagrad_node_get(s : OptgradadagradNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adagrad_node_set(s : OptgradadagradNode, i : Int, v : Double) -> OptgradadagradNode {
  let result = opt_grad_adagrad_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_adagrad_node_sum(s : OptgradadagradNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_adagrad_node_mean(s : OptgradadagradNode) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_adagrad_node_sum(s) / s.size.to_double() }
}

pub fn opt_grad_adagrad_node_scale(s : OptgradadagradNode, f : Double) -> OptgradadagradNode {
  let result = opt_grad_adagrad_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_adagrad_node_add(a : OptgradadagradNode, b : OptgradadagradNode) -> OptgradadagradNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_adagrad_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_adagrad_node_copy(s : OptgradadagradNode) -> OptgradadagradNode {
  let result = opt_grad_adagrad_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_adagrad_node_fill(s : OptgradadagradNode, v : Double) -> OptgradadagradNode {
  let result = opt_grad_adagrad_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_adagrad_node_min(s : OptgradadagradNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_adagrad_node_max(s : OptgradadagradNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_adagrad_node_to_string(s : OptgradadagradNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradadagradEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adagrad_edge_make(size : Int) -> OptgradadagradEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adagrad_edge_len(s : OptgradadagradEdge) -> Int { s.size }

pub fn opt_grad_adagrad_edge_get(s : OptgradadagradEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adagrad_edge_set(s : OptgradadagradEdge, i : Int, v : Double) -> OptgradadagradEdge {
  let result = opt_grad_adagrad_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_adagrad_edge_sum(s : OptgradadagradEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_adagrad_edge_mean(s : OptgradadagradEdge) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_adagrad_edge_sum(s) / s.size.to_double() }
}

pub fn opt_grad_adagrad_edge_scale(s : OptgradadagradEdge, f : Double) -> OptgradadagradEdge {
  let result = opt_grad_adagrad_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_adagrad_edge_add(a : OptgradadagradEdge, b : OptgradadagradEdge) -> OptgradadagradEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_adagrad_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_adagrad_edge_copy(s : OptgradadagradEdge) -> OptgradadagradEdge {
  let result = opt_grad_adagrad_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_adagrad_edge_fill(s : OptgradadagradEdge, v : Double) -> OptgradadagradEdge {
  let result = opt_grad_adagrad_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_adagrad_edge_min(s : OptgradadagradEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_adagrad_edge_max(s : OptgradadagradEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_adagrad_edge_to_string(s : OptgradadagradEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradadagradPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adagrad_path_make(size : Int) -> OptgradadagradPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adagrad_path_len(s : OptgradadagradPath) -> Int { s.size }

pub fn opt_grad_adagrad_path_get(s : OptgradadagradPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adagrad_path_set(s : OptgradadagradPath, i : Int, v : Double) -> OptgradadagradPath {
  let result = opt_grad_adagrad_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_adagrad_path_sum(s : OptgradadagradPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_adagrad_path_mean(s : OptgradadagradPath) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_adagrad_path_sum(s) / s.size.to_double() }
}

pub fn opt_grad_adagrad_path_scale(s : OptgradadagradPath, f : Double) -> OptgradadagradPath {
  let result = opt_grad_adagrad_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_adagrad_path_add(a : OptgradadagradPath, b : OptgradadagradPath) -> OptgradadagradPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_adagrad_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_adagrad_path_copy(s : OptgradadagradPath) -> OptgradadagradPath {
  let result = opt_grad_adagrad_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_adagrad_path_fill(s : OptgradadagradPath, v : Double) -> OptgradadagradPath {
  let result = opt_grad_adagrad_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_adagrad_path_min(s : OptgradadagradPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_adagrad_path_max(s : OptgradadagradPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_adagrad_path_to_string(s : OptgradadagradPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradadagradCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adagrad_cluster_make(size : Int) -> OptgradadagradCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adagrad_cluster_len(s : OptgradadagradCluster) -> Int { s.size }

pub fn opt_grad_adagrad_cluster_get(s : OptgradadagradCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adagrad_cluster_set(s : OptgradadagradCluster, i : Int, v : Double) -> OptgradadagradCluster {
  let result = opt_grad_adagrad_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_adagrad_cluster_sum(s : OptgradadagradCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_adagrad_cluster_mean(s : OptgradadagradCluster) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_adagrad_cluster_sum(s) / s.size.to_double() }
}

pub fn opt_grad_adagrad_cluster_scale(s : OptgradadagradCluster, f : Double) -> OptgradadagradCluster {
  let result = opt_grad_adagrad_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_adagrad_cluster_add(a : OptgradadagradCluster, b : OptgradadagradCluster) -> OptgradadagradCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_adagrad_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_adagrad_cluster_copy(s : OptgradadagradCluster) -> OptgradadagradCluster {
  let result = opt_grad_adagrad_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_adagrad_cluster_fill(s : OptgradadagradCluster, v : Double) -> OptgradadagradCluster {
  let result = opt_grad_adagrad_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_adagrad_cluster_min(s : OptgradadagradCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_adagrad_cluster_max(s : OptgradadagradCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_adagrad_cluster_to_string(s : OptgradadagradCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradadagradModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adagrad_model_make(size : Int) -> OptgradadagradModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adagrad_model_len(s : OptgradadagradModel) -> Int { s.size }

pub fn opt_grad_adagrad_model_get(s : OptgradadagradModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adagrad_model_set(s : OptgradadagradModel, i : Int, v : Double) -> OptgradadagradModel {
  let result = opt_grad_adagrad_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_adagrad_model_sum(s : OptgradadagradModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_adagrad_model_mean(s : OptgradadagradModel) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_adagrad_model_sum(s) / s.size.to_double() }
}

pub fn opt_grad_adagrad_model_scale(s : OptgradadagradModel, f : Double) -> OptgradadagradModel {
  let result = opt_grad_adagrad_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_adagrad_model_add(a : OptgradadagradModel, b : OptgradadagradModel) -> OptgradadagradModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_adagrad_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_adagrad_model_copy(s : OptgradadagradModel) -> OptgradadagradModel {
  let result = opt_grad_adagrad_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_adagrad_model_fill(s : OptgradadagradModel, v : Double) -> OptgradadagradModel {
  let result = opt_grad_adagrad_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_adagrad_model_min(s : OptgradadagradModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_adagrad_model_max(s : OptgradadagradModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_adagrad_model_to_string(s : OptgradadagradModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradadagradLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adagrad_layer_make(size : Int) -> OptgradadagradLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adagrad_layer_len(s : OptgradadagradLayer) -> Int { s.size }

pub fn opt_grad_adagrad_layer_get(s : OptgradadagradLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adagrad_layer_set(s : OptgradadagradLayer, i : Int, v : Double) -> OptgradadagradLayer {
  let result = opt_grad_adagrad_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_adagrad_layer_sum(s : OptgradadagradLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_adagrad_layer_mean(s : OptgradadagradLayer) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_adagrad_layer_sum(s) / s.size.to_double() }
}

pub fn opt_grad_adagrad_layer_scale(s : OptgradadagradLayer, f : Double) -> OptgradadagradLayer {
  let result = opt_grad_adagrad_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_adagrad_layer_add(a : OptgradadagradLayer, b : OptgradadagradLayer) -> OptgradadagradLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_adagrad_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_adagrad_layer_copy(s : OptgradadagradLayer) -> OptgradadagradLayer {
  let result = opt_grad_adagrad_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_adagrad_layer_fill(s : OptgradadagradLayer, v : Double) -> OptgradadagradLayer {
  let result = opt_grad_adagrad_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_adagrad_layer_min(s : OptgradadagradLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_adagrad_layer_max(s : OptgradadagradLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_adagrad_layer_to_string(s : OptgradadagradLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradadagradBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adagrad_buffer_make(size : Int) -> OptgradadagradBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adagrad_buffer_len(s : OptgradadagradBuffer) -> Int { s.size }

pub fn opt_grad_adagrad_buffer_get(s : OptgradadagradBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adagrad_buffer_set(s : OptgradadagradBuffer, i : Int, v : Double) -> OptgradadagradBuffer {
  let result = opt_grad_adagrad_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_adagrad_buffer_sum(s : OptgradadagradBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_adagrad_buffer_mean(s : OptgradadagradBuffer) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_adagrad_buffer_sum(s) / s.size.to_double() }
}

pub fn opt_grad_adagrad_buffer_scale(s : OptgradadagradBuffer, f : Double) -> OptgradadagradBuffer {
  let result = opt_grad_adagrad_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_adagrad_buffer_add(a : OptgradadagradBuffer, b : OptgradadagradBuffer) -> OptgradadagradBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_adagrad_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_adagrad_buffer_copy(s : OptgradadagradBuffer) -> OptgradadagradBuffer {
  let result = opt_grad_adagrad_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_adagrad_buffer_fill(s : OptgradadagradBuffer, v : Double) -> OptgradadagradBuffer {
  let result = opt_grad_adagrad_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_adagrad_buffer_min(s : OptgradadagradBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_adagrad_buffer_max(s : OptgradadagradBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_adagrad_buffer_to_string(s : OptgradadagradBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradadagradCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adagrad_cursor_make(size : Int) -> OptgradadagradCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adagrad_cursor_len(s : OptgradadagradCursor) -> Int { s.size }

pub fn opt_grad_adagrad_cursor_get(s : OptgradadagradCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adagrad_cursor_set(s : OptgradadagradCursor, i : Int, v : Double) -> OptgradadagradCursor {
  let result = opt_grad_adagrad_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_adagrad_cursor_sum(s : OptgradadagradCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_adagrad_cursor_mean(s : OptgradadagradCursor) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_adagrad_cursor_sum(s) / s.size.to_double() }
}

pub fn opt_grad_adagrad_cursor_scale(s : OptgradadagradCursor, f : Double) -> OptgradadagradCursor {
  let result = opt_grad_adagrad_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_adagrad_cursor_add(a : OptgradadagradCursor, b : OptgradadagradCursor) -> OptgradadagradCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_adagrad_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_adagrad_cursor_copy(s : OptgradadagradCursor) -> OptgradadagradCursor {
  let result = opt_grad_adagrad_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_adagrad_cursor_fill(s : OptgradadagradCursor, v : Double) -> OptgradadagradCursor {
  let result = opt_grad_adagrad_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_adagrad_cursor_min(s : OptgradadagradCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_adagrad_cursor_max(s : OptgradadagradCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_adagrad_cursor_to_string(s : OptgradadagradCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradadagradView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adagrad_view_make(size : Int) -> OptgradadagradView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adagrad_view_len(s : OptgradadagradView) -> Int { s.size }

pub fn opt_grad_adagrad_view_get(s : OptgradadagradView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adagrad_view_set(s : OptgradadagradView, i : Int, v : Double) -> OptgradadagradView {
  let result = opt_grad_adagrad_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_adagrad_view_sum(s : OptgradadagradView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_adagrad_view_mean(s : OptgradadagradView) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_adagrad_view_sum(s) / s.size.to_double() }
}

pub fn opt_grad_adagrad_view_scale(s : OptgradadagradView, f : Double) -> OptgradadagradView {
  let result = opt_grad_adagrad_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_adagrad_view_add(a : OptgradadagradView, b : OptgradadagradView) -> OptgradadagradView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_adagrad_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_adagrad_view_copy(s : OptgradadagradView) -> OptgradadagradView {
  let result = opt_grad_adagrad_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_adagrad_view_fill(s : OptgradadagradView, v : Double) -> OptgradadagradView {
  let result = opt_grad_adagrad_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_adagrad_view_min(s : OptgradadagradView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_adagrad_view_max(s : OptgradadagradView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_adagrad_view_to_string(s : OptgradadagradView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradadagradRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adagrad_range_make(size : Int) -> OptgradadagradRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adagrad_range_len(s : OptgradadagradRange) -> Int { s.size }

pub fn opt_grad_adagrad_range_get(s : OptgradadagradRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adagrad_range_set(s : OptgradadagradRange, i : Int, v : Double) -> OptgradadagradRange {
  let result = opt_grad_adagrad_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_adagrad_range_sum(s : OptgradadagradRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_adagrad_range_mean(s : OptgradadagradRange) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_adagrad_range_sum(s) / s.size.to_double() }
}

pub fn opt_grad_adagrad_range_scale(s : OptgradadagradRange, f : Double) -> OptgradadagradRange {
  let result = opt_grad_adagrad_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_adagrad_range_add(a : OptgradadagradRange, b : OptgradadagradRange) -> OptgradadagradRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_adagrad_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_adagrad_range_copy(s : OptgradadagradRange) -> OptgradadagradRange {
  let result = opt_grad_adagrad_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_adagrad_range_fill(s : OptgradadagradRange, v : Double) -> OptgradadagradRange {
  let result = opt_grad_adagrad_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_adagrad_range_min(s : OptgradadagradRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_adagrad_range_max(s : OptgradadagradRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_adagrad_range_to_string(s : OptgradadagradRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradadagradSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adagrad_slice_make(size : Int) -> OptgradadagradSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adagrad_slice_len(s : OptgradadagradSlice) -> Int { s.size }

pub fn opt_grad_adagrad_slice_get(s : OptgradadagradSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adagrad_slice_set(s : OptgradadagradSlice, i : Int, v : Double) -> OptgradadagradSlice {
  let result = opt_grad_adagrad_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_adagrad_slice_sum(s : OptgradadagradSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_adagrad_slice_mean(s : OptgradadagradSlice) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_adagrad_slice_sum(s) / s.size.to_double() }
}

pub fn opt_grad_adagrad_slice_scale(s : OptgradadagradSlice, f : Double) -> OptgradadagradSlice {
  let result = opt_grad_adagrad_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_adagrad_slice_add(a : OptgradadagradSlice, b : OptgradadagradSlice) -> OptgradadagradSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_adagrad_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_adagrad_slice_copy(s : OptgradadagradSlice) -> OptgradadagradSlice {
  let result = opt_grad_adagrad_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_adagrad_slice_fill(s : OptgradadagradSlice, v : Double) -> OptgradadagradSlice {
  let result = opt_grad_adagrad_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_adagrad_slice_min(s : OptgradadagradSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_adagrad_slice_max(s : OptgradadagradSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_adagrad_slice_to_string(s : OptgradadagradSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


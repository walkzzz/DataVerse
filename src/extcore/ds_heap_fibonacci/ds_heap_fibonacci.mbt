///===
/// extcore/ds_heap_fibonacci

pub(all) struct DsheapfibonacciPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_heap_fibonacci_make_point(x : Double, y : Double) -> DsheapfibonacciPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_heap_fibonacci_make_point3(x : Double, y : Double, z : Double) -> DsheapfibonacciPoint {
  { x, y, z, label: 0 }
}

pub fn ds_heap_fibonacci_point_x(pt : DsheapfibonacciPoint) -> Double { pt.x }

pub fn ds_heap_fibonacci_point_y(pt : DsheapfibonacciPoint) -> Double { pt.y }

pub fn ds_heap_fibonacci_point_z(pt : DsheapfibonacciPoint) -> Double { pt.z }

pub fn ds_heap_fibonacci_point_label(pt : DsheapfibonacciPoint) -> Int { pt.label }

pub fn ds_heap_fibonacci_point_dist(a : DsheapfibonacciPoint, b : DsheapfibonacciPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  ds_heap_fibonacci_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ds_heap_fibonacci_point_add(a : DsheapfibonacciPoint, b : DsheapfibonacciPoint) -> DsheapfibonacciPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ds_heap_fibonacci_point_sub(a : DsheapfibonacciPoint, b : DsheapfibonacciPoint) -> DsheapfibonacciPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ds_heap_fibonacci_point_scale(pt : DsheapfibonacciPoint, s : Double) -> DsheapfibonacciPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ds_heap_fibonacci_point_dot(a : DsheapfibonacciPoint, b : DsheapfibonacciPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ds_heap_fibonacci_point_cross(a : DsheapfibonacciPoint, b : DsheapfibonacciPoint) -> DsheapfibonacciPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ds_heap_fibonacci_point_norm(pt : DsheapfibonacciPoint) -> Double {
  ds_heap_fibonacci_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ds_heap_fibonacci_point_normalize(pt : DsheapfibonacciPoint) -> DsheapfibonacciPoint {
  let n = ds_heap_fibonacci_point_norm(pt)
  if n < 0.0000001 { pt } else { ds_heap_fibonacci_point_scale(pt, 1.0 / n) }
}

pub fn ds_heap_fibonacci_point_negate(pt : DsheapfibonacciPoint) -> DsheapfibonacciPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ds_heap_fibonacci_point_mid(a : DsheapfibonacciPoint, b : DsheapfibonacciPoint) -> DsheapfibonacciPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ds_heap_fibonacci_point_lerp(a : DsheapfibonacciPoint, b : DsheapfibonacciPoint, t : Double) -> DsheapfibonacciPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ds_heap_fibonacci_point_to_string(pt : DsheapfibonacciPoint) -> String {
  "(" + ds_heap_fibonacci_dbl(pt.x) + ", " + ds_heap_fibonacci_dbl(pt.y) + ", " + ds_heap_fibonacci_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DsheapfibonacciSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_heap_fibonacci_make_series(vals : Array[Double], name : String) -> DsheapfibonacciSeries {
  { vals, name, meta: 0 }
}

pub fn ds_heap_fibonacci_series_len(s : DsheapfibonacciSeries) -> Int { s.vals.length() }

pub fn ds_heap_fibonacci_series_sum(s : DsheapfibonacciSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn ds_heap_fibonacci_series_mean(s : DsheapfibonacciSeries) -> Double {
  let n = ds_heap_fibonacci_series_len(s)
  if n == 0 { 0.0 } else { ds_heap_fibonacci_series_sum(s) / n.to_double() }
}

pub fn ds_heap_fibonacci_series_min(s : DsheapfibonacciSeries) -> Double {
  let n = ds_heap_fibonacci_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn ds_heap_fibonacci_series_max(s : DsheapfibonacciSeries) -> Double {
  let n = ds_heap_fibonacci_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn ds_heap_fibonacci_series_range(s : DsheapfibonacciSeries) -> Double {
  ds_heap_fibonacci_series_max(s) - ds_heap_fibonacci_series_min(s)
}

pub fn ds_heap_fibonacci_series_var(s : DsheapfibonacciSeries) -> Double {
  let n = ds_heap_fibonacci_series_len(s)
  if n == 0 { 0.0 } else {
    let m = ds_heap_fibonacci_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn ds_heap_fibonacci_series_std(s : DsheapfibonacciSeries) -> Double { ds_heap_fibonacci_sqrt(ds_heap_fibonacci_series_var(s)) }

pub fn ds_heap_fibonacci_series_median(s : DsheapfibonacciSeries) -> Double {
  let n = ds_heap_fibonacci_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = ds_heap_fibonacci_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ds_heap_fibonacci_series_scale(s : DsheapfibonacciSeries, f : Double) -> DsheapfibonacciSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = ds_heap_fibonacci_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ds_heap_fibonacci_series_add(a : DsheapfibonacciSeries, b : DsheapfibonacciSeries) -> DsheapfibonacciSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = ds_heap_fibonacci_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ds_heap_fibonacci_series_sub(a : DsheapfibonacciSeries, b : DsheapfibonacciSeries) -> DsheapfibonacciSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = ds_heap_fibonacci_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ds_heap_fibonacci_series_normalize(s : DsheapfibonacciSeries) -> DsheapfibonacciSeries {
  let mn = ds_heap_fibonacci_series_min(s)
  let mx = ds_heap_fibonacci_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = ds_heap_fibonacci_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ds_heap_fibonacci_series_cumsum(s : DsheapfibonacciSeries) -> DsheapfibonacciSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = ds_heap_fibonacci_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn ds_heap_fibonacci_series_to_string(s : DsheapfibonacciSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + ds_heap_fibonacci_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DsheapfibonacciMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_heap_fibonacci_make_matrix(rows : Int, cols : Int, val : Double) -> DsheapfibonacciMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_heap_fibonacci_matrix_identity(n : Int) -> DsheapfibonacciMatrix {
  let m = ds_heap_fibonacci_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ds_heap_fibonacci_matrix_get(m : DsheapfibonacciMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ds_heap_fibonacci_matrix_transpose(m : DsheapfibonacciMatrix) -> DsheapfibonacciMatrix {
  let result = ds_heap_fibonacci_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ds_heap_fibonacci_matrix_add(a : DsheapfibonacciMatrix, b : DsheapfibonacciMatrix) -> DsheapfibonacciMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ds_heap_fibonacci_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ds_heap_fibonacci_matrix_scale(m : DsheapfibonacciMatrix, s : Double) -> DsheapfibonacciMatrix {
  let result = ds_heap_fibonacci_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ds_heap_fibonacci_matrix_multiply(a : DsheapfibonacciMatrix, b : DsheapfibonacciMatrix) -> DsheapfibonacciMatrix {
  if a.cols != b.rows { return ds_heap_fibonacci_make_matrix(a.rows, b.cols, 0.0) }
  let result = ds_heap_fibonacci_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ds_heap_fibonacci_matrix_trace(m : DsheapfibonacciMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ds_heap_fibonacci_matrix_det(m : DsheapfibonacciMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ds_heap_fibonacci_matrix_norm(m : DsheapfibonacciMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  ds_heap_fibonacci_sqrt(sum)
}

pub fn ds_heap_fibonacci_matrix_to_string(m : DsheapfibonacciMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + ds_heap_fibonacci_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct DsheapfibonacciVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_heap_fibonacci_make_vector(comps : Array[Double]) -> DsheapfibonacciVector {
  { comps, dim: comps.length() }
}

pub fn ds_heap_fibonacci_vector_zero(dim : Int) -> DsheapfibonacciVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ds_heap_fibonacci_vector_add(a : DsheapfibonacciVector, b : DsheapfibonacciVector) -> DsheapfibonacciVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = ds_heap_fibonacci_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_heap_fibonacci_vector_sub(a : DsheapfibonacciVector, b : DsheapfibonacciVector) -> DsheapfibonacciVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = ds_heap_fibonacci_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_heap_fibonacci_vector_scale(v : DsheapfibonacciVector, s : Double) -> DsheapfibonacciVector {
  let mut result = []
  for i in 0..<v.dim { result = ds_heap_fibonacci_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ds_heap_fibonacci_vector_dot(a : DsheapfibonacciVector, b : DsheapfibonacciVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ds_heap_fibonacci_vector_norm(v : DsheapfibonacciVector) -> Double { ds_heap_fibonacci_sqrt(ds_heap_fibonacci_vector_dot(v, v)) }

pub fn ds_heap_fibonacci_vector_normalize(v : DsheapfibonacciVector) -> DsheapfibonacciVector {
  let n = ds_heap_fibonacci_vector_norm(v)
  if n < 0.0000001 { v } else { ds_heap_fibonacci_vector_scale(v, 1.0 / n) }
}

pub fn ds_heap_fibonacci_vector_dist(a : DsheapfibonacciVector, b : DsheapfibonacciVector) -> Double {
  ds_heap_fibonacci_vector_norm(ds_heap_fibonacci_vector_sub(a, b))
}

pub fn ds_heap_fibonacci_vector_to_string(v : DsheapfibonacciVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + ds_heap_fibonacci_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_heap_fibonacci_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn ds_heap_fibonacci_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = ds_heap_fibonacci_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ds_heap_fibonacci_std(data : Array[Double]) -> Double { ds_heap_fibonacci_sqrt(ds_heap_fibonacci_var(data)) }

pub fn ds_heap_fibonacci_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = ds_heap_fibonacci_mean(a); let mb = ds_heap_fibonacci_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn ds_heap_fibonacci_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = ds_heap_fibonacci_std(a); let sb = ds_heap_fibonacci_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { ds_heap_fibonacci_cov(a, b) / (sa * sb) }
}

pub fn ds_heap_fibonacci_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = ds_heap_fibonacci_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ds_heap_fibonacci_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn ds_heap_fibonacci_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ds_heap_fibonacci_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  ds_heap_fibonacci_sqrt(ds_heap_fibonacci_mse(pred, labels))
}

pub fn ds_heap_fibonacci_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + ds_heap_fibonacci_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn ds_heap_fibonacci_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = ds_heap_fibonacci_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn ds_heap_fibonacci_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn ds_heap_fibonacci_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn ds_heap_fibonacci_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = ds_heap_fibonacci_precision(pred, labels, pos); let r = ds_heap_fibonacci_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn ds_heap_fibonacci_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn ds_heap_fibonacci_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = ds_heap_fibonacci_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn ds_heap_fibonacci_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn ds_heap_fibonacci_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn ds_heap_fibonacci_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = ds_heap_fibonacci_gcd(a, b)
    (a / g) * b
  }
}

pub fn ds_heap_fibonacci_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn ds_heap_fibonacci_fibonacci(n : Int) -> Int {
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

pub fn ds_heap_fibonacci_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = ds_heap_fibonacci_min(data); let mx = ds_heap_fibonacci_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn ds_heap_fibonacci_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = ds_heap_fibonacci_mean(data); let sd = ds_heap_fibonacci_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn ds_heap_fibonacci_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn ds_heap_fibonacci_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn ds_heap_fibonacci_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn ds_heap_fibonacci_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn ds_heap_fibonacci_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn ds_heap_fibonacci_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn ds_heap_fibonacci_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn ds_heap_fibonacci_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn ds_heap_fibonacci_dbl(x : Double) -> String {
  let i = if x >= 0.0 { ds_heap_fibonacci_int(x) } else { -ds_heap_fibonacci_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { ds_heap_fibonacci_int(f * 1000000.0) } else { ds_heap_fibonacci_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn ds_heap_fibonacci_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn ds_heap_fibonacci_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct DsheapfibonacciFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_fibonacci_frame_make(size : Int) -> DsheapfibonacciFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_fibonacci_frame_len(s : DsheapfibonacciFrame) -> Int { s.size }

pub fn ds_heap_fibonacci_frame_get(s : DsheapfibonacciFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_fibonacci_frame_set(s : DsheapfibonacciFrame, i : Int, v : Double) -> DsheapfibonacciFrame {
  let result = ds_heap_fibonacci_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_fibonacci_frame_sum(s : DsheapfibonacciFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_heap_fibonacci_frame_mean(s : DsheapfibonacciFrame) -> Double {
  if s.size == 0 { 0.0 } else { ds_heap_fibonacci_frame_sum(s) / s.size.to_double() }
}

pub fn ds_heap_fibonacci_frame_scale(s : DsheapfibonacciFrame, f : Double) -> DsheapfibonacciFrame {
  let result = ds_heap_fibonacci_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_fibonacci_frame_add(a : DsheapfibonacciFrame, b : DsheapfibonacciFrame) -> DsheapfibonacciFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_fibonacci_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_fibonacci_frame_copy(s : DsheapfibonacciFrame) -> DsheapfibonacciFrame {
  let result = ds_heap_fibonacci_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_fibonacci_frame_fill(s : DsheapfibonacciFrame, v : Double) -> DsheapfibonacciFrame {
  let result = ds_heap_fibonacci_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_fibonacci_frame_min(s : DsheapfibonacciFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_fibonacci_frame_max(s : DsheapfibonacciFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_fibonacci_frame_to_string(s : DsheapfibonacciFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapfibonacciTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_fibonacci_table_make(size : Int) -> DsheapfibonacciTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_fibonacci_table_len(s : DsheapfibonacciTable) -> Int { s.size }

pub fn ds_heap_fibonacci_table_get(s : DsheapfibonacciTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_fibonacci_table_set(s : DsheapfibonacciTable, i : Int, v : Double) -> DsheapfibonacciTable {
  let result = ds_heap_fibonacci_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_fibonacci_table_sum(s : DsheapfibonacciTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_heap_fibonacci_table_mean(s : DsheapfibonacciTable) -> Double {
  if s.size == 0 { 0.0 } else { ds_heap_fibonacci_table_sum(s) / s.size.to_double() }
}

pub fn ds_heap_fibonacci_table_scale(s : DsheapfibonacciTable, f : Double) -> DsheapfibonacciTable {
  let result = ds_heap_fibonacci_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_fibonacci_table_add(a : DsheapfibonacciTable, b : DsheapfibonacciTable) -> DsheapfibonacciTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_fibonacci_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_fibonacci_table_copy(s : DsheapfibonacciTable) -> DsheapfibonacciTable {
  let result = ds_heap_fibonacci_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_fibonacci_table_fill(s : DsheapfibonacciTable, v : Double) -> DsheapfibonacciTable {
  let result = ds_heap_fibonacci_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_fibonacci_table_min(s : DsheapfibonacciTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_fibonacci_table_max(s : DsheapfibonacciTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_fibonacci_table_to_string(s : DsheapfibonacciTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapfibonacciGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_fibonacci_graphn_make(size : Int) -> DsheapfibonacciGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_fibonacci_graphn_len(s : DsheapfibonacciGraphN) -> Int { s.size }

pub fn ds_heap_fibonacci_graphn_get(s : DsheapfibonacciGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_fibonacci_graphn_set(s : DsheapfibonacciGraphN, i : Int, v : Double) -> DsheapfibonacciGraphN {
  let result = ds_heap_fibonacci_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_fibonacci_graphn_sum(s : DsheapfibonacciGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_heap_fibonacci_graphn_mean(s : DsheapfibonacciGraphN) -> Double {
  if s.size == 0 { 0.0 } else { ds_heap_fibonacci_graphn_sum(s) / s.size.to_double() }
}

pub fn ds_heap_fibonacci_graphn_scale(s : DsheapfibonacciGraphN, f : Double) -> DsheapfibonacciGraphN {
  let result = ds_heap_fibonacci_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_fibonacci_graphn_add(a : DsheapfibonacciGraphN, b : DsheapfibonacciGraphN) -> DsheapfibonacciGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_fibonacci_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_fibonacci_graphn_copy(s : DsheapfibonacciGraphN) -> DsheapfibonacciGraphN {
  let result = ds_heap_fibonacci_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_fibonacci_graphn_fill(s : DsheapfibonacciGraphN, v : Double) -> DsheapfibonacciGraphN {
  let result = ds_heap_fibonacci_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_fibonacci_graphn_min(s : DsheapfibonacciGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_fibonacci_graphn_max(s : DsheapfibonacciGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_fibonacci_graphn_to_string(s : DsheapfibonacciGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapfibonacciNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_fibonacci_node_make(size : Int) -> DsheapfibonacciNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_fibonacci_node_len(s : DsheapfibonacciNode) -> Int { s.size }

pub fn ds_heap_fibonacci_node_get(s : DsheapfibonacciNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_fibonacci_node_set(s : DsheapfibonacciNode, i : Int, v : Double) -> DsheapfibonacciNode {
  let result = ds_heap_fibonacci_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_fibonacci_node_sum(s : DsheapfibonacciNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_heap_fibonacci_node_mean(s : DsheapfibonacciNode) -> Double {
  if s.size == 0 { 0.0 } else { ds_heap_fibonacci_node_sum(s) / s.size.to_double() }
}

pub fn ds_heap_fibonacci_node_scale(s : DsheapfibonacciNode, f : Double) -> DsheapfibonacciNode {
  let result = ds_heap_fibonacci_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_fibonacci_node_add(a : DsheapfibonacciNode, b : DsheapfibonacciNode) -> DsheapfibonacciNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_fibonacci_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_fibonacci_node_copy(s : DsheapfibonacciNode) -> DsheapfibonacciNode {
  let result = ds_heap_fibonacci_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_fibonacci_node_fill(s : DsheapfibonacciNode, v : Double) -> DsheapfibonacciNode {
  let result = ds_heap_fibonacci_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_fibonacci_node_min(s : DsheapfibonacciNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_fibonacci_node_max(s : DsheapfibonacciNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_fibonacci_node_to_string(s : DsheapfibonacciNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapfibonacciEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_fibonacci_edge_make(size : Int) -> DsheapfibonacciEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_fibonacci_edge_len(s : DsheapfibonacciEdge) -> Int { s.size }

pub fn ds_heap_fibonacci_edge_get(s : DsheapfibonacciEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_fibonacci_edge_set(s : DsheapfibonacciEdge, i : Int, v : Double) -> DsheapfibonacciEdge {
  let result = ds_heap_fibonacci_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_fibonacci_edge_sum(s : DsheapfibonacciEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_heap_fibonacci_edge_mean(s : DsheapfibonacciEdge) -> Double {
  if s.size == 0 { 0.0 } else { ds_heap_fibonacci_edge_sum(s) / s.size.to_double() }
}

pub fn ds_heap_fibonacci_edge_scale(s : DsheapfibonacciEdge, f : Double) -> DsheapfibonacciEdge {
  let result = ds_heap_fibonacci_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_fibonacci_edge_add(a : DsheapfibonacciEdge, b : DsheapfibonacciEdge) -> DsheapfibonacciEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_fibonacci_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_fibonacci_edge_copy(s : DsheapfibonacciEdge) -> DsheapfibonacciEdge {
  let result = ds_heap_fibonacci_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_fibonacci_edge_fill(s : DsheapfibonacciEdge, v : Double) -> DsheapfibonacciEdge {
  let result = ds_heap_fibonacci_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_fibonacci_edge_min(s : DsheapfibonacciEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_fibonacci_edge_max(s : DsheapfibonacciEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_fibonacci_edge_to_string(s : DsheapfibonacciEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapfibonacciPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_fibonacci_path_make(size : Int) -> DsheapfibonacciPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_fibonacci_path_len(s : DsheapfibonacciPath) -> Int { s.size }

pub fn ds_heap_fibonacci_path_get(s : DsheapfibonacciPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_fibonacci_path_set(s : DsheapfibonacciPath, i : Int, v : Double) -> DsheapfibonacciPath {
  let result = ds_heap_fibonacci_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_fibonacci_path_sum(s : DsheapfibonacciPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_heap_fibonacci_path_mean(s : DsheapfibonacciPath) -> Double {
  if s.size == 0 { 0.0 } else { ds_heap_fibonacci_path_sum(s) / s.size.to_double() }
}

pub fn ds_heap_fibonacci_path_scale(s : DsheapfibonacciPath, f : Double) -> DsheapfibonacciPath {
  let result = ds_heap_fibonacci_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_fibonacci_path_add(a : DsheapfibonacciPath, b : DsheapfibonacciPath) -> DsheapfibonacciPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_fibonacci_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_fibonacci_path_copy(s : DsheapfibonacciPath) -> DsheapfibonacciPath {
  let result = ds_heap_fibonacci_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_fibonacci_path_fill(s : DsheapfibonacciPath, v : Double) -> DsheapfibonacciPath {
  let result = ds_heap_fibonacci_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_fibonacci_path_min(s : DsheapfibonacciPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_fibonacci_path_max(s : DsheapfibonacciPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_fibonacci_path_to_string(s : DsheapfibonacciPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapfibonacciCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_fibonacci_cluster_make(size : Int) -> DsheapfibonacciCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_fibonacci_cluster_len(s : DsheapfibonacciCluster) -> Int { s.size }

pub fn ds_heap_fibonacci_cluster_get(s : DsheapfibonacciCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_fibonacci_cluster_set(s : DsheapfibonacciCluster, i : Int, v : Double) -> DsheapfibonacciCluster {
  let result = ds_heap_fibonacci_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_fibonacci_cluster_sum(s : DsheapfibonacciCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_heap_fibonacci_cluster_mean(s : DsheapfibonacciCluster) -> Double {
  if s.size == 0 { 0.0 } else { ds_heap_fibonacci_cluster_sum(s) / s.size.to_double() }
}

pub fn ds_heap_fibonacci_cluster_scale(s : DsheapfibonacciCluster, f : Double) -> DsheapfibonacciCluster {
  let result = ds_heap_fibonacci_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_fibonacci_cluster_add(a : DsheapfibonacciCluster, b : DsheapfibonacciCluster) -> DsheapfibonacciCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_fibonacci_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_fibonacci_cluster_copy(s : DsheapfibonacciCluster) -> DsheapfibonacciCluster {
  let result = ds_heap_fibonacci_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_fibonacci_cluster_fill(s : DsheapfibonacciCluster, v : Double) -> DsheapfibonacciCluster {
  let result = ds_heap_fibonacci_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_fibonacci_cluster_min(s : DsheapfibonacciCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_fibonacci_cluster_max(s : DsheapfibonacciCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_fibonacci_cluster_to_string(s : DsheapfibonacciCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapfibonacciModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_fibonacci_model_make(size : Int) -> DsheapfibonacciModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_fibonacci_model_len(s : DsheapfibonacciModel) -> Int { s.size }

pub fn ds_heap_fibonacci_model_get(s : DsheapfibonacciModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_fibonacci_model_set(s : DsheapfibonacciModel, i : Int, v : Double) -> DsheapfibonacciModel {
  let result = ds_heap_fibonacci_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_fibonacci_model_sum(s : DsheapfibonacciModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_heap_fibonacci_model_mean(s : DsheapfibonacciModel) -> Double {
  if s.size == 0 { 0.0 } else { ds_heap_fibonacci_model_sum(s) / s.size.to_double() }
}

pub fn ds_heap_fibonacci_model_scale(s : DsheapfibonacciModel, f : Double) -> DsheapfibonacciModel {
  let result = ds_heap_fibonacci_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_fibonacci_model_add(a : DsheapfibonacciModel, b : DsheapfibonacciModel) -> DsheapfibonacciModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_fibonacci_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_fibonacci_model_copy(s : DsheapfibonacciModel) -> DsheapfibonacciModel {
  let result = ds_heap_fibonacci_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_fibonacci_model_fill(s : DsheapfibonacciModel, v : Double) -> DsheapfibonacciModel {
  let result = ds_heap_fibonacci_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_fibonacci_model_min(s : DsheapfibonacciModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_fibonacci_model_max(s : DsheapfibonacciModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_fibonacci_model_to_string(s : DsheapfibonacciModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapfibonacciLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_fibonacci_layer_make(size : Int) -> DsheapfibonacciLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_fibonacci_layer_len(s : DsheapfibonacciLayer) -> Int { s.size }

pub fn ds_heap_fibonacci_layer_get(s : DsheapfibonacciLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_fibonacci_layer_set(s : DsheapfibonacciLayer, i : Int, v : Double) -> DsheapfibonacciLayer {
  let result = ds_heap_fibonacci_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_fibonacci_layer_sum(s : DsheapfibonacciLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_heap_fibonacci_layer_mean(s : DsheapfibonacciLayer) -> Double {
  if s.size == 0 { 0.0 } else { ds_heap_fibonacci_layer_sum(s) / s.size.to_double() }
}

pub fn ds_heap_fibonacci_layer_scale(s : DsheapfibonacciLayer, f : Double) -> DsheapfibonacciLayer {
  let result = ds_heap_fibonacci_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_fibonacci_layer_add(a : DsheapfibonacciLayer, b : DsheapfibonacciLayer) -> DsheapfibonacciLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_fibonacci_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_fibonacci_layer_copy(s : DsheapfibonacciLayer) -> DsheapfibonacciLayer {
  let result = ds_heap_fibonacci_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_fibonacci_layer_fill(s : DsheapfibonacciLayer, v : Double) -> DsheapfibonacciLayer {
  let result = ds_heap_fibonacci_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_fibonacci_layer_min(s : DsheapfibonacciLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_fibonacci_layer_max(s : DsheapfibonacciLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_fibonacci_layer_to_string(s : DsheapfibonacciLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapfibonacciBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_fibonacci_buffer_make(size : Int) -> DsheapfibonacciBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_fibonacci_buffer_len(s : DsheapfibonacciBuffer) -> Int { s.size }

pub fn ds_heap_fibonacci_buffer_get(s : DsheapfibonacciBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_fibonacci_buffer_set(s : DsheapfibonacciBuffer, i : Int, v : Double) -> DsheapfibonacciBuffer {
  let result = ds_heap_fibonacci_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_fibonacci_buffer_sum(s : DsheapfibonacciBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_heap_fibonacci_buffer_mean(s : DsheapfibonacciBuffer) -> Double {
  if s.size == 0 { 0.0 } else { ds_heap_fibonacci_buffer_sum(s) / s.size.to_double() }
}

pub fn ds_heap_fibonacci_buffer_scale(s : DsheapfibonacciBuffer, f : Double) -> DsheapfibonacciBuffer {
  let result = ds_heap_fibonacci_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_fibonacci_buffer_add(a : DsheapfibonacciBuffer, b : DsheapfibonacciBuffer) -> DsheapfibonacciBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_fibonacci_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_fibonacci_buffer_copy(s : DsheapfibonacciBuffer) -> DsheapfibonacciBuffer {
  let result = ds_heap_fibonacci_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_fibonacci_buffer_fill(s : DsheapfibonacciBuffer, v : Double) -> DsheapfibonacciBuffer {
  let result = ds_heap_fibonacci_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_fibonacci_buffer_min(s : DsheapfibonacciBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_fibonacci_buffer_max(s : DsheapfibonacciBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_fibonacci_buffer_to_string(s : DsheapfibonacciBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapfibonacciCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_fibonacci_cursor_make(size : Int) -> DsheapfibonacciCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_fibonacci_cursor_len(s : DsheapfibonacciCursor) -> Int { s.size }

pub fn ds_heap_fibonacci_cursor_get(s : DsheapfibonacciCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_fibonacci_cursor_set(s : DsheapfibonacciCursor, i : Int, v : Double) -> DsheapfibonacciCursor {
  let result = ds_heap_fibonacci_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_fibonacci_cursor_sum(s : DsheapfibonacciCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_heap_fibonacci_cursor_mean(s : DsheapfibonacciCursor) -> Double {
  if s.size == 0 { 0.0 } else { ds_heap_fibonacci_cursor_sum(s) / s.size.to_double() }
}

pub fn ds_heap_fibonacci_cursor_scale(s : DsheapfibonacciCursor, f : Double) -> DsheapfibonacciCursor {
  let result = ds_heap_fibonacci_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_fibonacci_cursor_add(a : DsheapfibonacciCursor, b : DsheapfibonacciCursor) -> DsheapfibonacciCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_fibonacci_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_fibonacci_cursor_copy(s : DsheapfibonacciCursor) -> DsheapfibonacciCursor {
  let result = ds_heap_fibonacci_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_fibonacci_cursor_fill(s : DsheapfibonacciCursor, v : Double) -> DsheapfibonacciCursor {
  let result = ds_heap_fibonacci_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_fibonacci_cursor_min(s : DsheapfibonacciCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_fibonacci_cursor_max(s : DsheapfibonacciCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_fibonacci_cursor_to_string(s : DsheapfibonacciCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapfibonacciView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_fibonacci_view_make(size : Int) -> DsheapfibonacciView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_fibonacci_view_len(s : DsheapfibonacciView) -> Int { s.size }

pub fn ds_heap_fibonacci_view_get(s : DsheapfibonacciView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_fibonacci_view_set(s : DsheapfibonacciView, i : Int, v : Double) -> DsheapfibonacciView {
  let result = ds_heap_fibonacci_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_fibonacci_view_sum(s : DsheapfibonacciView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_heap_fibonacci_view_mean(s : DsheapfibonacciView) -> Double {
  if s.size == 0 { 0.0 } else { ds_heap_fibonacci_view_sum(s) / s.size.to_double() }
}

pub fn ds_heap_fibonacci_view_scale(s : DsheapfibonacciView, f : Double) -> DsheapfibonacciView {
  let result = ds_heap_fibonacci_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_fibonacci_view_add(a : DsheapfibonacciView, b : DsheapfibonacciView) -> DsheapfibonacciView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_fibonacci_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_fibonacci_view_copy(s : DsheapfibonacciView) -> DsheapfibonacciView {
  let result = ds_heap_fibonacci_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_fibonacci_view_fill(s : DsheapfibonacciView, v : Double) -> DsheapfibonacciView {
  let result = ds_heap_fibonacci_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_fibonacci_view_min(s : DsheapfibonacciView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_fibonacci_view_max(s : DsheapfibonacciView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_fibonacci_view_to_string(s : DsheapfibonacciView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapfibonacciRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_fibonacci_range_make(size : Int) -> DsheapfibonacciRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_fibonacci_range_len(s : DsheapfibonacciRange) -> Int { s.size }

pub fn ds_heap_fibonacci_range_get(s : DsheapfibonacciRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_fibonacci_range_set(s : DsheapfibonacciRange, i : Int, v : Double) -> DsheapfibonacciRange {
  let result = ds_heap_fibonacci_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_fibonacci_range_sum(s : DsheapfibonacciRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_heap_fibonacci_range_mean(s : DsheapfibonacciRange) -> Double {
  if s.size == 0 { 0.0 } else { ds_heap_fibonacci_range_sum(s) / s.size.to_double() }
}

pub fn ds_heap_fibonacci_range_scale(s : DsheapfibonacciRange, f : Double) -> DsheapfibonacciRange {
  let result = ds_heap_fibonacci_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_fibonacci_range_add(a : DsheapfibonacciRange, b : DsheapfibonacciRange) -> DsheapfibonacciRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_fibonacci_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_fibonacci_range_copy(s : DsheapfibonacciRange) -> DsheapfibonacciRange {
  let result = ds_heap_fibonacci_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_fibonacci_range_fill(s : DsheapfibonacciRange, v : Double) -> DsheapfibonacciRange {
  let result = ds_heap_fibonacci_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_fibonacci_range_min(s : DsheapfibonacciRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_fibonacci_range_max(s : DsheapfibonacciRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_fibonacci_range_to_string(s : DsheapfibonacciRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapfibonacciSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_fibonacci_slice_make(size : Int) -> DsheapfibonacciSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_fibonacci_slice_len(s : DsheapfibonacciSlice) -> Int { s.size }

pub fn ds_heap_fibonacci_slice_get(s : DsheapfibonacciSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_fibonacci_slice_set(s : DsheapfibonacciSlice, i : Int, v : Double) -> DsheapfibonacciSlice {
  let result = ds_heap_fibonacci_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_fibonacci_slice_sum(s : DsheapfibonacciSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_heap_fibonacci_slice_mean(s : DsheapfibonacciSlice) -> Double {
  if s.size == 0 { 0.0 } else { ds_heap_fibonacci_slice_sum(s) / s.size.to_double() }
}

pub fn ds_heap_fibonacci_slice_scale(s : DsheapfibonacciSlice, f : Double) -> DsheapfibonacciSlice {
  let result = ds_heap_fibonacci_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_fibonacci_slice_add(a : DsheapfibonacciSlice, b : DsheapfibonacciSlice) -> DsheapfibonacciSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_fibonacci_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_fibonacci_slice_copy(s : DsheapfibonacciSlice) -> DsheapfibonacciSlice {
  let result = ds_heap_fibonacci_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_fibonacci_slice_fill(s : DsheapfibonacciSlice, v : Double) -> DsheapfibonacciSlice {
  let result = ds_heap_fibonacci_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_fibonacci_slice_min(s : DsheapfibonacciSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_fibonacci_slice_max(s : DsheapfibonacciSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_fibonacci_slice_to_string(s : DsheapfibonacciSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn ds_heap_fibonacci_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_heap_fibonacci_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_heap_fibonacci_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_heap_fibonacci_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_heap_fibonacci_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_heap_fibonacci_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_heap_fibonacci_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_heap_fibonacci_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_heap_fibonacci_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_heap_fibonacci_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_heap_fibonacci_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_heap_fibonacci_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_heap_fibonacci_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_heap_fibonacci_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_heap_fibonacci_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_heap_fibonacci_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_heap_fibonacci_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_heap_fibonacci_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_heap_fibonacci_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_heap_fibonacci_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_heap_fibonacci_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_heap_fibonacci_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_heap_fibonacci_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_heap_fibonacci_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_heap_fibonacci_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}


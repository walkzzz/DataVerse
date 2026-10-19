///===
/// extcore/ds_heap_binary

pub(all) struct DsheapbinaryPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_heap_binary_make_point(x : Double, y : Double) -> DsheapbinaryPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_heap_binary_make_point3(x : Double, y : Double, z : Double) -> DsheapbinaryPoint {
  { x, y, z, label: 0 }
}

pub fn ds_heap_binary_point_x(pt : DsheapbinaryPoint) -> Double { pt.x }

pub fn ds_heap_binary_point_y(pt : DsheapbinaryPoint) -> Double { pt.y }

pub fn ds_heap_binary_point_z(pt : DsheapbinaryPoint) -> Double { pt.z }

pub fn ds_heap_binary_point_label(pt : DsheapbinaryPoint) -> Int { pt.label }

pub fn ds_heap_binary_point_dist(a : DsheapbinaryPoint, b : DsheapbinaryPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  ds_heap_binary_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ds_heap_binary_point_add(a : DsheapbinaryPoint, b : DsheapbinaryPoint) -> DsheapbinaryPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ds_heap_binary_point_sub(a : DsheapbinaryPoint, b : DsheapbinaryPoint) -> DsheapbinaryPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ds_heap_binary_point_scale(pt : DsheapbinaryPoint, s : Double) -> DsheapbinaryPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ds_heap_binary_point_dot(a : DsheapbinaryPoint, b : DsheapbinaryPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ds_heap_binary_point_cross(a : DsheapbinaryPoint, b : DsheapbinaryPoint) -> DsheapbinaryPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ds_heap_binary_point_norm(pt : DsheapbinaryPoint) -> Double {
  ds_heap_binary_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ds_heap_binary_point_normalize(pt : DsheapbinaryPoint) -> DsheapbinaryPoint {
  let n = ds_heap_binary_point_norm(pt)
  if n < 0.0000001 { pt } else { ds_heap_binary_point_scale(pt, 1.0 / n) }
}

pub fn ds_heap_binary_point_negate(pt : DsheapbinaryPoint) -> DsheapbinaryPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ds_heap_binary_point_mid(a : DsheapbinaryPoint, b : DsheapbinaryPoint) -> DsheapbinaryPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ds_heap_binary_point_lerp(a : DsheapbinaryPoint, b : DsheapbinaryPoint, t : Double) -> DsheapbinaryPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ds_heap_binary_point_to_string(pt : DsheapbinaryPoint) -> String {
  "(" + ds_heap_binary_dbl(pt.x) + ", " + ds_heap_binary_dbl(pt.y) + ", " + ds_heap_binary_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DsheapbinarySeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_heap_binary_make_series(vals : Array[Double], name : String) -> DsheapbinarySeries {
  { vals, name, meta: 0 }
}

pub fn ds_heap_binary_series_len(s : DsheapbinarySeries) -> Int { s.vals.length() }

pub fn ds_heap_binary_series_sum(s : DsheapbinarySeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn ds_heap_binary_series_mean(s : DsheapbinarySeries) -> Double {
  let n = ds_heap_binary_series_len(s)
  if n == 0 { 0.0 } else { ds_heap_binary_series_sum(s) / n.to_double() }
}

pub fn ds_heap_binary_series_min(s : DsheapbinarySeries) -> Double {
  let n = ds_heap_binary_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn ds_heap_binary_series_max(s : DsheapbinarySeries) -> Double {
  let n = ds_heap_binary_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn ds_heap_binary_series_range(s : DsheapbinarySeries) -> Double {
  ds_heap_binary_series_max(s) - ds_heap_binary_series_min(s)
}

pub fn ds_heap_binary_series_var(s : DsheapbinarySeries) -> Double {
  let n = ds_heap_binary_series_len(s)
  if n == 0 { 0.0 } else {
    let m = ds_heap_binary_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn ds_heap_binary_series_std(s : DsheapbinarySeries) -> Double { ds_heap_binary_sqrt(ds_heap_binary_series_var(s)) }

pub fn ds_heap_binary_series_median(s : DsheapbinarySeries) -> Double {
  let n = ds_heap_binary_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = ds_heap_binary_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ds_heap_binary_series_scale(s : DsheapbinarySeries, f : Double) -> DsheapbinarySeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = ds_heap_binary_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ds_heap_binary_series_add(a : DsheapbinarySeries, b : DsheapbinarySeries) -> DsheapbinarySeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = ds_heap_binary_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ds_heap_binary_series_sub(a : DsheapbinarySeries, b : DsheapbinarySeries) -> DsheapbinarySeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = ds_heap_binary_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ds_heap_binary_series_normalize(s : DsheapbinarySeries) -> DsheapbinarySeries {
  let mn = ds_heap_binary_series_min(s)
  let mx = ds_heap_binary_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = ds_heap_binary_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ds_heap_binary_series_cumsum(s : DsheapbinarySeries) -> DsheapbinarySeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = ds_heap_binary_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn ds_heap_binary_series_to_string(s : DsheapbinarySeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + ds_heap_binary_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DsheapbinaryMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_heap_binary_make_matrix(rows : Int, cols : Int, val : Double) -> DsheapbinaryMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_heap_binary_matrix_identity(n : Int) -> DsheapbinaryMatrix {
  let m = ds_heap_binary_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ds_heap_binary_matrix_get(m : DsheapbinaryMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ds_heap_binary_matrix_transpose(m : DsheapbinaryMatrix) -> DsheapbinaryMatrix {
  let result = ds_heap_binary_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ds_heap_binary_matrix_add(a : DsheapbinaryMatrix, b : DsheapbinaryMatrix) -> DsheapbinaryMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ds_heap_binary_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ds_heap_binary_matrix_scale(m : DsheapbinaryMatrix, s : Double) -> DsheapbinaryMatrix {
  let result = ds_heap_binary_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ds_heap_binary_matrix_multiply(a : DsheapbinaryMatrix, b : DsheapbinaryMatrix) -> DsheapbinaryMatrix {
  if a.cols != b.rows { return ds_heap_binary_make_matrix(a.rows, b.cols, 0.0) }
  let result = ds_heap_binary_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ds_heap_binary_matrix_trace(m : DsheapbinaryMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ds_heap_binary_matrix_det(m : DsheapbinaryMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ds_heap_binary_matrix_norm(m : DsheapbinaryMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  ds_heap_binary_sqrt(sum)
}

pub fn ds_heap_binary_matrix_to_string(m : DsheapbinaryMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + ds_heap_binary_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct DsheapbinaryVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_heap_binary_make_vector(comps : Array[Double]) -> DsheapbinaryVector {
  { comps, dim: comps.length() }
}

pub fn ds_heap_binary_vector_zero(dim : Int) -> DsheapbinaryVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ds_heap_binary_vector_add(a : DsheapbinaryVector, b : DsheapbinaryVector) -> DsheapbinaryVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = ds_heap_binary_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_heap_binary_vector_sub(a : DsheapbinaryVector, b : DsheapbinaryVector) -> DsheapbinaryVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = ds_heap_binary_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_heap_binary_vector_scale(v : DsheapbinaryVector, s : Double) -> DsheapbinaryVector {
  let mut result = []
  for i in 0..<v.dim { result = ds_heap_binary_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ds_heap_binary_vector_dot(a : DsheapbinaryVector, b : DsheapbinaryVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ds_heap_binary_vector_norm(v : DsheapbinaryVector) -> Double { ds_heap_binary_sqrt(ds_heap_binary_vector_dot(v, v)) }

pub fn ds_heap_binary_vector_normalize(v : DsheapbinaryVector) -> DsheapbinaryVector {
  let n = ds_heap_binary_vector_norm(v)
  if n < 0.0000001 { v } else { ds_heap_binary_vector_scale(v, 1.0 / n) }
}

pub fn ds_heap_binary_vector_dist(a : DsheapbinaryVector, b : DsheapbinaryVector) -> Double {
  ds_heap_binary_vector_norm(ds_heap_binary_vector_sub(a, b))
}

pub fn ds_heap_binary_vector_to_string(v : DsheapbinaryVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + ds_heap_binary_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_heap_binary_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn ds_heap_binary_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = ds_heap_binary_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ds_heap_binary_std(data : Array[Double]) -> Double { ds_heap_binary_sqrt(ds_heap_binary_var(data)) }

pub fn ds_heap_binary_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = ds_heap_binary_mean(a); let mb = ds_heap_binary_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn ds_heap_binary_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = ds_heap_binary_std(a); let sb = ds_heap_binary_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { ds_heap_binary_cov(a, b) / (sa * sb) }
}

pub fn ds_heap_binary_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = ds_heap_binary_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ds_heap_binary_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn ds_heap_binary_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ds_heap_binary_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  ds_heap_binary_sqrt(ds_heap_binary_mse(pred, labels))
}

pub fn ds_heap_binary_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + ds_heap_binary_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn ds_heap_binary_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = ds_heap_binary_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn ds_heap_binary_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn ds_heap_binary_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn ds_heap_binary_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = ds_heap_binary_precision(pred, labels, pos); let r = ds_heap_binary_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn ds_heap_binary_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn ds_heap_binary_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = ds_heap_binary_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn ds_heap_binary_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn ds_heap_binary_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn ds_heap_binary_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = ds_heap_binary_gcd(a, b)
    (a / g) * b
  }
}

pub fn ds_heap_binary_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn ds_heap_binary_fibonacci(n : Int) -> Int {
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

pub fn ds_heap_binary_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = ds_heap_binary_min(data); let mx = ds_heap_binary_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn ds_heap_binary_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = ds_heap_binary_mean(data); let sd = ds_heap_binary_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn ds_heap_binary_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn ds_heap_binary_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn ds_heap_binary_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn ds_heap_binary_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn ds_heap_binary_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn ds_heap_binary_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn ds_heap_binary_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn ds_heap_binary_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn ds_heap_binary_dbl(x : Double) -> String {
  let i = if x >= 0.0 { ds_heap_binary_int(x) } else { -ds_heap_binary_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { ds_heap_binary_int(f * 1000000.0) } else { ds_heap_binary_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn ds_heap_binary_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn ds_heap_binary_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct DsheapbinaryFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_binary_frame_make(size : Int) -> DsheapbinaryFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_binary_frame_len(s : DsheapbinaryFrame) -> Int { s.size }

pub fn ds_heap_binary_frame_get(s : DsheapbinaryFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_binary_frame_set(s : DsheapbinaryFrame, i : Int, v : Double) -> DsheapbinaryFrame {
  let result = ds_heap_binary_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_binary_frame_sum(s : DsheapbinaryFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_heap_binary_frame_mean(s : DsheapbinaryFrame) -> Double {
  if s.size == 0 { 0.0 } else { ds_heap_binary_frame_sum(s) / s.size.to_double() }
}

pub fn ds_heap_binary_frame_scale(s : DsheapbinaryFrame, f : Double) -> DsheapbinaryFrame {
  let result = ds_heap_binary_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_binary_frame_add(a : DsheapbinaryFrame, b : DsheapbinaryFrame) -> DsheapbinaryFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_binary_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_binary_frame_copy(s : DsheapbinaryFrame) -> DsheapbinaryFrame {
  let result = ds_heap_binary_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_binary_frame_fill(s : DsheapbinaryFrame, v : Double) -> DsheapbinaryFrame {
  let result = ds_heap_binary_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_binary_frame_min(s : DsheapbinaryFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_binary_frame_max(s : DsheapbinaryFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_binary_frame_to_string(s : DsheapbinaryFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapbinaryTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_binary_table_make(size : Int) -> DsheapbinaryTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_binary_table_len(s : DsheapbinaryTable) -> Int { s.size }

pub fn ds_heap_binary_table_get(s : DsheapbinaryTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_binary_table_set(s : DsheapbinaryTable, i : Int, v : Double) -> DsheapbinaryTable {
  let result = ds_heap_binary_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_binary_table_sum(s : DsheapbinaryTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_heap_binary_table_mean(s : DsheapbinaryTable) -> Double {
  if s.size == 0 { 0.0 } else { ds_heap_binary_table_sum(s) / s.size.to_double() }
}

pub fn ds_heap_binary_table_scale(s : DsheapbinaryTable, f : Double) -> DsheapbinaryTable {
  let result = ds_heap_binary_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_binary_table_add(a : DsheapbinaryTable, b : DsheapbinaryTable) -> DsheapbinaryTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_binary_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_binary_table_copy(s : DsheapbinaryTable) -> DsheapbinaryTable {
  let result = ds_heap_binary_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_binary_table_fill(s : DsheapbinaryTable, v : Double) -> DsheapbinaryTable {
  let result = ds_heap_binary_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_binary_table_min(s : DsheapbinaryTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_binary_table_max(s : DsheapbinaryTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_binary_table_to_string(s : DsheapbinaryTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapbinaryGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_binary_graphn_make(size : Int) -> DsheapbinaryGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_binary_graphn_len(s : DsheapbinaryGraphN) -> Int { s.size }

pub fn ds_heap_binary_graphn_get(s : DsheapbinaryGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_binary_graphn_set(s : DsheapbinaryGraphN, i : Int, v : Double) -> DsheapbinaryGraphN {
  let result = ds_heap_binary_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_binary_graphn_sum(s : DsheapbinaryGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_heap_binary_graphn_mean(s : DsheapbinaryGraphN) -> Double {
  if s.size == 0 { 0.0 } else { ds_heap_binary_graphn_sum(s) / s.size.to_double() }
}

pub fn ds_heap_binary_graphn_scale(s : DsheapbinaryGraphN, f : Double) -> DsheapbinaryGraphN {
  let result = ds_heap_binary_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_binary_graphn_add(a : DsheapbinaryGraphN, b : DsheapbinaryGraphN) -> DsheapbinaryGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_binary_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_binary_graphn_copy(s : DsheapbinaryGraphN) -> DsheapbinaryGraphN {
  let result = ds_heap_binary_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_binary_graphn_fill(s : DsheapbinaryGraphN, v : Double) -> DsheapbinaryGraphN {
  let result = ds_heap_binary_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_binary_graphn_min(s : DsheapbinaryGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_binary_graphn_max(s : DsheapbinaryGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_binary_graphn_to_string(s : DsheapbinaryGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapbinaryNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_binary_node_make(size : Int) -> DsheapbinaryNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_binary_node_len(s : DsheapbinaryNode) -> Int { s.size }

pub fn ds_heap_binary_node_get(s : DsheapbinaryNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_binary_node_set(s : DsheapbinaryNode, i : Int, v : Double) -> DsheapbinaryNode {
  let result = ds_heap_binary_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_binary_node_sum(s : DsheapbinaryNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_heap_binary_node_mean(s : DsheapbinaryNode) -> Double {
  if s.size == 0 { 0.0 } else { ds_heap_binary_node_sum(s) / s.size.to_double() }
}

pub fn ds_heap_binary_node_scale(s : DsheapbinaryNode, f : Double) -> DsheapbinaryNode {
  let result = ds_heap_binary_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_binary_node_add(a : DsheapbinaryNode, b : DsheapbinaryNode) -> DsheapbinaryNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_binary_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_binary_node_copy(s : DsheapbinaryNode) -> DsheapbinaryNode {
  let result = ds_heap_binary_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_binary_node_fill(s : DsheapbinaryNode, v : Double) -> DsheapbinaryNode {
  let result = ds_heap_binary_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_binary_node_min(s : DsheapbinaryNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_binary_node_max(s : DsheapbinaryNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_binary_node_to_string(s : DsheapbinaryNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapbinaryEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_binary_edge_make(size : Int) -> DsheapbinaryEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_binary_edge_len(s : DsheapbinaryEdge) -> Int { s.size }

pub fn ds_heap_binary_edge_get(s : DsheapbinaryEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_binary_edge_set(s : DsheapbinaryEdge, i : Int, v : Double) -> DsheapbinaryEdge {
  let result = ds_heap_binary_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_binary_edge_sum(s : DsheapbinaryEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_heap_binary_edge_mean(s : DsheapbinaryEdge) -> Double {
  if s.size == 0 { 0.0 } else { ds_heap_binary_edge_sum(s) / s.size.to_double() }
}

pub fn ds_heap_binary_edge_scale(s : DsheapbinaryEdge, f : Double) -> DsheapbinaryEdge {
  let result = ds_heap_binary_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_binary_edge_add(a : DsheapbinaryEdge, b : DsheapbinaryEdge) -> DsheapbinaryEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_binary_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_binary_edge_copy(s : DsheapbinaryEdge) -> DsheapbinaryEdge {
  let result = ds_heap_binary_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_binary_edge_fill(s : DsheapbinaryEdge, v : Double) -> DsheapbinaryEdge {
  let result = ds_heap_binary_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_binary_edge_min(s : DsheapbinaryEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_binary_edge_max(s : DsheapbinaryEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_binary_edge_to_string(s : DsheapbinaryEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapbinaryPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_binary_path_make(size : Int) -> DsheapbinaryPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_binary_path_len(s : DsheapbinaryPath) -> Int { s.size }

pub fn ds_heap_binary_path_get(s : DsheapbinaryPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_binary_path_set(s : DsheapbinaryPath, i : Int, v : Double) -> DsheapbinaryPath {
  let result = ds_heap_binary_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_binary_path_sum(s : DsheapbinaryPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_heap_binary_path_mean(s : DsheapbinaryPath) -> Double {
  if s.size == 0 { 0.0 } else { ds_heap_binary_path_sum(s) / s.size.to_double() }
}

pub fn ds_heap_binary_path_scale(s : DsheapbinaryPath, f : Double) -> DsheapbinaryPath {
  let result = ds_heap_binary_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_binary_path_add(a : DsheapbinaryPath, b : DsheapbinaryPath) -> DsheapbinaryPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_binary_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_binary_path_copy(s : DsheapbinaryPath) -> DsheapbinaryPath {
  let result = ds_heap_binary_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_binary_path_fill(s : DsheapbinaryPath, v : Double) -> DsheapbinaryPath {
  let result = ds_heap_binary_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_binary_path_min(s : DsheapbinaryPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_binary_path_max(s : DsheapbinaryPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_binary_path_to_string(s : DsheapbinaryPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapbinaryCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_binary_cluster_make(size : Int) -> DsheapbinaryCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_binary_cluster_len(s : DsheapbinaryCluster) -> Int { s.size }

pub fn ds_heap_binary_cluster_get(s : DsheapbinaryCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_binary_cluster_set(s : DsheapbinaryCluster, i : Int, v : Double) -> DsheapbinaryCluster {
  let result = ds_heap_binary_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_binary_cluster_sum(s : DsheapbinaryCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_heap_binary_cluster_mean(s : DsheapbinaryCluster) -> Double {
  if s.size == 0 { 0.0 } else { ds_heap_binary_cluster_sum(s) / s.size.to_double() }
}

pub fn ds_heap_binary_cluster_scale(s : DsheapbinaryCluster, f : Double) -> DsheapbinaryCluster {
  let result = ds_heap_binary_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_binary_cluster_add(a : DsheapbinaryCluster, b : DsheapbinaryCluster) -> DsheapbinaryCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_binary_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_binary_cluster_copy(s : DsheapbinaryCluster) -> DsheapbinaryCluster {
  let result = ds_heap_binary_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_binary_cluster_fill(s : DsheapbinaryCluster, v : Double) -> DsheapbinaryCluster {
  let result = ds_heap_binary_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_binary_cluster_min(s : DsheapbinaryCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_binary_cluster_max(s : DsheapbinaryCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_binary_cluster_to_string(s : DsheapbinaryCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapbinaryModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_binary_model_make(size : Int) -> DsheapbinaryModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_binary_model_len(s : DsheapbinaryModel) -> Int { s.size }

pub fn ds_heap_binary_model_get(s : DsheapbinaryModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_binary_model_set(s : DsheapbinaryModel, i : Int, v : Double) -> DsheapbinaryModel {
  let result = ds_heap_binary_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_binary_model_sum(s : DsheapbinaryModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_heap_binary_model_mean(s : DsheapbinaryModel) -> Double {
  if s.size == 0 { 0.0 } else { ds_heap_binary_model_sum(s) / s.size.to_double() }
}

pub fn ds_heap_binary_model_scale(s : DsheapbinaryModel, f : Double) -> DsheapbinaryModel {
  let result = ds_heap_binary_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_binary_model_add(a : DsheapbinaryModel, b : DsheapbinaryModel) -> DsheapbinaryModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_binary_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_binary_model_copy(s : DsheapbinaryModel) -> DsheapbinaryModel {
  let result = ds_heap_binary_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_binary_model_fill(s : DsheapbinaryModel, v : Double) -> DsheapbinaryModel {
  let result = ds_heap_binary_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_binary_model_min(s : DsheapbinaryModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_binary_model_max(s : DsheapbinaryModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_binary_model_to_string(s : DsheapbinaryModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapbinaryLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_binary_layer_make(size : Int) -> DsheapbinaryLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_binary_layer_len(s : DsheapbinaryLayer) -> Int { s.size }

pub fn ds_heap_binary_layer_get(s : DsheapbinaryLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_binary_layer_set(s : DsheapbinaryLayer, i : Int, v : Double) -> DsheapbinaryLayer {
  let result = ds_heap_binary_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_binary_layer_sum(s : DsheapbinaryLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_heap_binary_layer_mean(s : DsheapbinaryLayer) -> Double {
  if s.size == 0 { 0.0 } else { ds_heap_binary_layer_sum(s) / s.size.to_double() }
}

pub fn ds_heap_binary_layer_scale(s : DsheapbinaryLayer, f : Double) -> DsheapbinaryLayer {
  let result = ds_heap_binary_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_binary_layer_add(a : DsheapbinaryLayer, b : DsheapbinaryLayer) -> DsheapbinaryLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_binary_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_binary_layer_copy(s : DsheapbinaryLayer) -> DsheapbinaryLayer {
  let result = ds_heap_binary_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_binary_layer_fill(s : DsheapbinaryLayer, v : Double) -> DsheapbinaryLayer {
  let result = ds_heap_binary_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_binary_layer_min(s : DsheapbinaryLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_binary_layer_max(s : DsheapbinaryLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_binary_layer_to_string(s : DsheapbinaryLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapbinaryBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_binary_buffer_make(size : Int) -> DsheapbinaryBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_binary_buffer_len(s : DsheapbinaryBuffer) -> Int { s.size }

pub fn ds_heap_binary_buffer_get(s : DsheapbinaryBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_binary_buffer_set(s : DsheapbinaryBuffer, i : Int, v : Double) -> DsheapbinaryBuffer {
  let result = ds_heap_binary_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_binary_buffer_sum(s : DsheapbinaryBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_heap_binary_buffer_mean(s : DsheapbinaryBuffer) -> Double {
  if s.size == 0 { 0.0 } else { ds_heap_binary_buffer_sum(s) / s.size.to_double() }
}

pub fn ds_heap_binary_buffer_scale(s : DsheapbinaryBuffer, f : Double) -> DsheapbinaryBuffer {
  let result = ds_heap_binary_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_binary_buffer_add(a : DsheapbinaryBuffer, b : DsheapbinaryBuffer) -> DsheapbinaryBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_binary_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_binary_buffer_copy(s : DsheapbinaryBuffer) -> DsheapbinaryBuffer {
  let result = ds_heap_binary_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_binary_buffer_fill(s : DsheapbinaryBuffer, v : Double) -> DsheapbinaryBuffer {
  let result = ds_heap_binary_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_binary_buffer_min(s : DsheapbinaryBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_binary_buffer_max(s : DsheapbinaryBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_binary_buffer_to_string(s : DsheapbinaryBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapbinaryCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_binary_cursor_make(size : Int) -> DsheapbinaryCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_binary_cursor_len(s : DsheapbinaryCursor) -> Int { s.size }

pub fn ds_heap_binary_cursor_get(s : DsheapbinaryCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_binary_cursor_set(s : DsheapbinaryCursor, i : Int, v : Double) -> DsheapbinaryCursor {
  let result = ds_heap_binary_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_binary_cursor_sum(s : DsheapbinaryCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_heap_binary_cursor_mean(s : DsheapbinaryCursor) -> Double {
  if s.size == 0 { 0.0 } else { ds_heap_binary_cursor_sum(s) / s.size.to_double() }
}

pub fn ds_heap_binary_cursor_scale(s : DsheapbinaryCursor, f : Double) -> DsheapbinaryCursor {
  let result = ds_heap_binary_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_binary_cursor_add(a : DsheapbinaryCursor, b : DsheapbinaryCursor) -> DsheapbinaryCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_binary_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_binary_cursor_copy(s : DsheapbinaryCursor) -> DsheapbinaryCursor {
  let result = ds_heap_binary_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_binary_cursor_fill(s : DsheapbinaryCursor, v : Double) -> DsheapbinaryCursor {
  let result = ds_heap_binary_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_binary_cursor_min(s : DsheapbinaryCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_binary_cursor_max(s : DsheapbinaryCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_binary_cursor_to_string(s : DsheapbinaryCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapbinaryView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_binary_view_make(size : Int) -> DsheapbinaryView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_binary_view_len(s : DsheapbinaryView) -> Int { s.size }

pub fn ds_heap_binary_view_get(s : DsheapbinaryView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_binary_view_set(s : DsheapbinaryView, i : Int, v : Double) -> DsheapbinaryView {
  let result = ds_heap_binary_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_binary_view_sum(s : DsheapbinaryView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_heap_binary_view_mean(s : DsheapbinaryView) -> Double {
  if s.size == 0 { 0.0 } else { ds_heap_binary_view_sum(s) / s.size.to_double() }
}

pub fn ds_heap_binary_view_scale(s : DsheapbinaryView, f : Double) -> DsheapbinaryView {
  let result = ds_heap_binary_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_binary_view_add(a : DsheapbinaryView, b : DsheapbinaryView) -> DsheapbinaryView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_binary_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_binary_view_copy(s : DsheapbinaryView) -> DsheapbinaryView {
  let result = ds_heap_binary_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_binary_view_fill(s : DsheapbinaryView, v : Double) -> DsheapbinaryView {
  let result = ds_heap_binary_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_binary_view_min(s : DsheapbinaryView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_binary_view_max(s : DsheapbinaryView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_binary_view_to_string(s : DsheapbinaryView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapbinaryRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_binary_range_make(size : Int) -> DsheapbinaryRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_binary_range_len(s : DsheapbinaryRange) -> Int { s.size }

pub fn ds_heap_binary_range_get(s : DsheapbinaryRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_binary_range_set(s : DsheapbinaryRange, i : Int, v : Double) -> DsheapbinaryRange {
  let result = ds_heap_binary_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_binary_range_sum(s : DsheapbinaryRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_heap_binary_range_mean(s : DsheapbinaryRange) -> Double {
  if s.size == 0 { 0.0 } else { ds_heap_binary_range_sum(s) / s.size.to_double() }
}

pub fn ds_heap_binary_range_scale(s : DsheapbinaryRange, f : Double) -> DsheapbinaryRange {
  let result = ds_heap_binary_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_binary_range_add(a : DsheapbinaryRange, b : DsheapbinaryRange) -> DsheapbinaryRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_binary_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_binary_range_copy(s : DsheapbinaryRange) -> DsheapbinaryRange {
  let result = ds_heap_binary_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_binary_range_fill(s : DsheapbinaryRange, v : Double) -> DsheapbinaryRange {
  let result = ds_heap_binary_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_binary_range_min(s : DsheapbinaryRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_binary_range_max(s : DsheapbinaryRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_binary_range_to_string(s : DsheapbinaryRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapbinarySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_binary_slice_make(size : Int) -> DsheapbinarySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_binary_slice_len(s : DsheapbinarySlice) -> Int { s.size }

pub fn ds_heap_binary_slice_get(s : DsheapbinarySlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_binary_slice_set(s : DsheapbinarySlice, i : Int, v : Double) -> DsheapbinarySlice {
  let result = ds_heap_binary_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_binary_slice_sum(s : DsheapbinarySlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_heap_binary_slice_mean(s : DsheapbinarySlice) -> Double {
  if s.size == 0 { 0.0 } else { ds_heap_binary_slice_sum(s) / s.size.to_double() }
}

pub fn ds_heap_binary_slice_scale(s : DsheapbinarySlice, f : Double) -> DsheapbinarySlice {
  let result = ds_heap_binary_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_binary_slice_add(a : DsheapbinarySlice, b : DsheapbinarySlice) -> DsheapbinarySlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_binary_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_binary_slice_copy(s : DsheapbinarySlice) -> DsheapbinarySlice {
  let result = ds_heap_binary_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_binary_slice_fill(s : DsheapbinarySlice, v : Double) -> DsheapbinarySlice {
  let result = ds_heap_binary_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_binary_slice_min(s : DsheapbinarySlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_binary_slice_max(s : DsheapbinarySlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_binary_slice_to_string(s : DsheapbinarySlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn ds_heap_binary_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_heap_binary_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_heap_binary_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_heap_binary_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_heap_binary_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_heap_binary_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_heap_binary_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_heap_binary_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_heap_binary_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_heap_binary_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_heap_binary_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_heap_binary_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_heap_binary_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_heap_binary_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_heap_binary_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_heap_binary_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_heap_binary_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_heap_binary_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_heap_binary_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_heap_binary_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_heap_binary_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_heap_binary_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_heap_binary_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_heap_binary_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_heap_binary_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}


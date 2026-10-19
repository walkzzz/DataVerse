///===
/// extcore/ds_heap_d_ary

pub(all) struct DsheapdaryPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_heap_d_ary_make_point(x : Double, y : Double) -> DsheapdaryPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_heap_d_ary_make_point3(x : Double, y : Double, z : Double) -> DsheapdaryPoint {
  { x, y, z, label: 0 }
}

pub fn ds_heap_d_ary_point_x(pt : DsheapdaryPoint) -> Double { pt.x }

pub fn ds_heap_d_ary_point_y(pt : DsheapdaryPoint) -> Double { pt.y }

pub fn ds_heap_d_ary_point_z(pt : DsheapdaryPoint) -> Double { pt.z }

pub fn ds_heap_d_ary_point_label(pt : DsheapdaryPoint) -> Int { pt.label }

pub fn ds_heap_d_ary_point_dist(a : DsheapdaryPoint, b : DsheapdaryPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  ds_heap_d_ary_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ds_heap_d_ary_point_add(a : DsheapdaryPoint, b : DsheapdaryPoint) -> DsheapdaryPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ds_heap_d_ary_point_sub(a : DsheapdaryPoint, b : DsheapdaryPoint) -> DsheapdaryPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ds_heap_d_ary_point_scale(pt : DsheapdaryPoint, s : Double) -> DsheapdaryPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ds_heap_d_ary_point_dot(a : DsheapdaryPoint, b : DsheapdaryPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ds_heap_d_ary_point_cross(a : DsheapdaryPoint, b : DsheapdaryPoint) -> DsheapdaryPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ds_heap_d_ary_point_norm(pt : DsheapdaryPoint) -> Double {
  ds_heap_d_ary_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ds_heap_d_ary_point_normalize(pt : DsheapdaryPoint) -> DsheapdaryPoint {
  let n = ds_heap_d_ary_point_norm(pt)
  if n < 0.0000001 { pt } else { ds_heap_d_ary_point_scale(pt, 1.0 / n) }
}

pub fn ds_heap_d_ary_point_negate(pt : DsheapdaryPoint) -> DsheapdaryPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ds_heap_d_ary_point_mid(a : DsheapdaryPoint, b : DsheapdaryPoint) -> DsheapdaryPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ds_heap_d_ary_point_lerp(a : DsheapdaryPoint, b : DsheapdaryPoint, t : Double) -> DsheapdaryPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ds_heap_d_ary_point_to_string(pt : DsheapdaryPoint) -> String {
  "(" + ds_heap_d_ary_dbl(pt.x) + ", " + ds_heap_d_ary_dbl(pt.y) + ", " + ds_heap_d_ary_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DsheapdarySeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_heap_d_ary_make_series(vals : Array[Double], name : String) -> DsheapdarySeries {
  { vals, name, meta: 0 }
}

pub fn ds_heap_d_ary_series_len(s : DsheapdarySeries) -> Int { s.vals.length() }

pub fn ds_heap_d_ary_series_sum(s : DsheapdarySeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn ds_heap_d_ary_series_mean(s : DsheapdarySeries) -> Double {
  let n = ds_heap_d_ary_series_len(s)
  if n == 0 { 0.0 } else { ds_heap_d_ary_series_sum(s) / n.to_double() }
}

pub fn ds_heap_d_ary_series_min(s : DsheapdarySeries) -> Double {
  let n = ds_heap_d_ary_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn ds_heap_d_ary_series_max(s : DsheapdarySeries) -> Double {
  let n = ds_heap_d_ary_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn ds_heap_d_ary_series_range(s : DsheapdarySeries) -> Double {
  ds_heap_d_ary_series_max(s) - ds_heap_d_ary_series_min(s)
}

pub fn ds_heap_d_ary_series_var(s : DsheapdarySeries) -> Double {
  let n = ds_heap_d_ary_series_len(s)
  if n == 0 { 0.0 } else {
    let m = ds_heap_d_ary_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn ds_heap_d_ary_series_std(s : DsheapdarySeries) -> Double { ds_heap_d_ary_sqrt(ds_heap_d_ary_series_var(s)) }

pub fn ds_heap_d_ary_series_median(s : DsheapdarySeries) -> Double {
  let n = ds_heap_d_ary_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = ds_heap_d_ary_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ds_heap_d_ary_series_scale(s : DsheapdarySeries, f : Double) -> DsheapdarySeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = ds_heap_d_ary_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ds_heap_d_ary_series_add(a : DsheapdarySeries, b : DsheapdarySeries) -> DsheapdarySeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = ds_heap_d_ary_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ds_heap_d_ary_series_sub(a : DsheapdarySeries, b : DsheapdarySeries) -> DsheapdarySeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = ds_heap_d_ary_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ds_heap_d_ary_series_normalize(s : DsheapdarySeries) -> DsheapdarySeries {
  let mn = ds_heap_d_ary_series_min(s)
  let mx = ds_heap_d_ary_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = ds_heap_d_ary_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ds_heap_d_ary_series_cumsum(s : DsheapdarySeries) -> DsheapdarySeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = ds_heap_d_ary_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn ds_heap_d_ary_series_to_string(s : DsheapdarySeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + ds_heap_d_ary_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DsheapdaryMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_heap_d_ary_make_matrix(rows : Int, cols : Int, val : Double) -> DsheapdaryMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_heap_d_ary_matrix_identity(n : Int) -> DsheapdaryMatrix {
  let m = ds_heap_d_ary_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ds_heap_d_ary_matrix_get(m : DsheapdaryMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ds_heap_d_ary_matrix_transpose(m : DsheapdaryMatrix) -> DsheapdaryMatrix {
  let result = ds_heap_d_ary_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ds_heap_d_ary_matrix_add(a : DsheapdaryMatrix, b : DsheapdaryMatrix) -> DsheapdaryMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ds_heap_d_ary_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ds_heap_d_ary_matrix_scale(m : DsheapdaryMatrix, s : Double) -> DsheapdaryMatrix {
  let result = ds_heap_d_ary_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ds_heap_d_ary_matrix_multiply(a : DsheapdaryMatrix, b : DsheapdaryMatrix) -> DsheapdaryMatrix {
  if a.cols != b.rows { return ds_heap_d_ary_make_matrix(a.rows, b.cols, 0.0) }
  let result = ds_heap_d_ary_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ds_heap_d_ary_matrix_trace(m : DsheapdaryMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ds_heap_d_ary_matrix_det(m : DsheapdaryMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ds_heap_d_ary_matrix_norm(m : DsheapdaryMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  ds_heap_d_ary_sqrt(sum)
}

pub fn ds_heap_d_ary_matrix_to_string(m : DsheapdaryMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + ds_heap_d_ary_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct DsheapdaryVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_heap_d_ary_make_vector(comps : Array[Double]) -> DsheapdaryVector {
  { comps, dim: comps.length() }
}

pub fn ds_heap_d_ary_vector_zero(dim : Int) -> DsheapdaryVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ds_heap_d_ary_vector_add(a : DsheapdaryVector, b : DsheapdaryVector) -> DsheapdaryVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = ds_heap_d_ary_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_heap_d_ary_vector_sub(a : DsheapdaryVector, b : DsheapdaryVector) -> DsheapdaryVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = ds_heap_d_ary_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_heap_d_ary_vector_scale(v : DsheapdaryVector, s : Double) -> DsheapdaryVector {
  let mut result = []
  for i in 0..<v.dim { result = ds_heap_d_ary_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ds_heap_d_ary_vector_dot(a : DsheapdaryVector, b : DsheapdaryVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ds_heap_d_ary_vector_norm(v : DsheapdaryVector) -> Double { ds_heap_d_ary_sqrt(ds_heap_d_ary_vector_dot(v, v)) }

pub fn ds_heap_d_ary_vector_normalize(v : DsheapdaryVector) -> DsheapdaryVector {
  let n = ds_heap_d_ary_vector_norm(v)
  if n < 0.0000001 { v } else { ds_heap_d_ary_vector_scale(v, 1.0 / n) }
}

pub fn ds_heap_d_ary_vector_dist(a : DsheapdaryVector, b : DsheapdaryVector) -> Double {
  ds_heap_d_ary_vector_norm(ds_heap_d_ary_vector_sub(a, b))
}

pub fn ds_heap_d_ary_vector_to_string(v : DsheapdaryVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + ds_heap_d_ary_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_heap_d_ary_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn ds_heap_d_ary_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = ds_heap_d_ary_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ds_heap_d_ary_std(data : Array[Double]) -> Double { ds_heap_d_ary_sqrt(ds_heap_d_ary_var(data)) }

pub fn ds_heap_d_ary_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = ds_heap_d_ary_mean(a); let mb = ds_heap_d_ary_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn ds_heap_d_ary_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = ds_heap_d_ary_std(a); let sb = ds_heap_d_ary_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { ds_heap_d_ary_cov(a, b) / (sa * sb) }
}

pub fn ds_heap_d_ary_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = ds_heap_d_ary_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ds_heap_d_ary_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn ds_heap_d_ary_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ds_heap_d_ary_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  ds_heap_d_ary_sqrt(ds_heap_d_ary_mse(pred, labels))
}

pub fn ds_heap_d_ary_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + ds_heap_d_ary_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn ds_heap_d_ary_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = ds_heap_d_ary_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn ds_heap_d_ary_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn ds_heap_d_ary_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn ds_heap_d_ary_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = ds_heap_d_ary_precision(pred, labels, pos); let r = ds_heap_d_ary_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn ds_heap_d_ary_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn ds_heap_d_ary_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = ds_heap_d_ary_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn ds_heap_d_ary_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn ds_heap_d_ary_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn ds_heap_d_ary_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = ds_heap_d_ary_gcd(a, b)
    (a / g) * b
  }
}

pub fn ds_heap_d_ary_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn ds_heap_d_ary_fibonacci(n : Int) -> Int {
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

pub fn ds_heap_d_ary_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = ds_heap_d_ary_min(data); let mx = ds_heap_d_ary_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn ds_heap_d_ary_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = ds_heap_d_ary_mean(data); let sd = ds_heap_d_ary_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn ds_heap_d_ary_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn ds_heap_d_ary_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn ds_heap_d_ary_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn ds_heap_d_ary_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn ds_heap_d_ary_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn ds_heap_d_ary_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn ds_heap_d_ary_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn ds_heap_d_ary_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn ds_heap_d_ary_dbl(x : Double) -> String {
  let i = if x >= 0.0 { ds_heap_d_ary_int(x) } else { -ds_heap_d_ary_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { ds_heap_d_ary_int(f * 1000000.0) } else { ds_heap_d_ary_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn ds_heap_d_ary_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn ds_heap_d_ary_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct DsheapdaryFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_d_ary_frame_make(size : Int) -> DsheapdaryFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_d_ary_frame_len(s : DsheapdaryFrame) -> Int { s.size }

pub fn ds_heap_d_ary_frame_get(s : DsheapdaryFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_d_ary_frame_set(s : DsheapdaryFrame, i : Int, v : Double) -> DsheapdaryFrame {
  let result = ds_heap_d_ary_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_d_ary_frame_sum(s : DsheapdaryFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_heap_d_ary_frame_mean(s : DsheapdaryFrame) -> Double {
  if s.size == 0 { 0.0 } else { ds_heap_d_ary_frame_sum(s) / s.size.to_double() }
}

pub fn ds_heap_d_ary_frame_scale(s : DsheapdaryFrame, f : Double) -> DsheapdaryFrame {
  let result = ds_heap_d_ary_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_d_ary_frame_add(a : DsheapdaryFrame, b : DsheapdaryFrame) -> DsheapdaryFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_d_ary_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_d_ary_frame_copy(s : DsheapdaryFrame) -> DsheapdaryFrame {
  let result = ds_heap_d_ary_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_d_ary_frame_fill(s : DsheapdaryFrame, v : Double) -> DsheapdaryFrame {
  let result = ds_heap_d_ary_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_d_ary_frame_min(s : DsheapdaryFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_d_ary_frame_max(s : DsheapdaryFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_d_ary_frame_to_string(s : DsheapdaryFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapdaryTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_d_ary_table_make(size : Int) -> DsheapdaryTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_d_ary_table_len(s : DsheapdaryTable) -> Int { s.size }

pub fn ds_heap_d_ary_table_get(s : DsheapdaryTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_d_ary_table_set(s : DsheapdaryTable, i : Int, v : Double) -> DsheapdaryTable {
  let result = ds_heap_d_ary_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_d_ary_table_sum(s : DsheapdaryTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_heap_d_ary_table_mean(s : DsheapdaryTable) -> Double {
  if s.size == 0 { 0.0 } else { ds_heap_d_ary_table_sum(s) / s.size.to_double() }
}

pub fn ds_heap_d_ary_table_scale(s : DsheapdaryTable, f : Double) -> DsheapdaryTable {
  let result = ds_heap_d_ary_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_d_ary_table_add(a : DsheapdaryTable, b : DsheapdaryTable) -> DsheapdaryTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_d_ary_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_d_ary_table_copy(s : DsheapdaryTable) -> DsheapdaryTable {
  let result = ds_heap_d_ary_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_d_ary_table_fill(s : DsheapdaryTable, v : Double) -> DsheapdaryTable {
  let result = ds_heap_d_ary_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_d_ary_table_min(s : DsheapdaryTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_d_ary_table_max(s : DsheapdaryTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_d_ary_table_to_string(s : DsheapdaryTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapdaryGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_d_ary_graphn_make(size : Int) -> DsheapdaryGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_d_ary_graphn_len(s : DsheapdaryGraphN) -> Int { s.size }

pub fn ds_heap_d_ary_graphn_get(s : DsheapdaryGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_d_ary_graphn_set(s : DsheapdaryGraphN, i : Int, v : Double) -> DsheapdaryGraphN {
  let result = ds_heap_d_ary_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_d_ary_graphn_sum(s : DsheapdaryGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_heap_d_ary_graphn_mean(s : DsheapdaryGraphN) -> Double {
  if s.size == 0 { 0.0 } else { ds_heap_d_ary_graphn_sum(s) / s.size.to_double() }
}

pub fn ds_heap_d_ary_graphn_scale(s : DsheapdaryGraphN, f : Double) -> DsheapdaryGraphN {
  let result = ds_heap_d_ary_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_d_ary_graphn_add(a : DsheapdaryGraphN, b : DsheapdaryGraphN) -> DsheapdaryGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_d_ary_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_d_ary_graphn_copy(s : DsheapdaryGraphN) -> DsheapdaryGraphN {
  let result = ds_heap_d_ary_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_d_ary_graphn_fill(s : DsheapdaryGraphN, v : Double) -> DsheapdaryGraphN {
  let result = ds_heap_d_ary_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_d_ary_graphn_min(s : DsheapdaryGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_d_ary_graphn_max(s : DsheapdaryGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_d_ary_graphn_to_string(s : DsheapdaryGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapdaryNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_d_ary_node_make(size : Int) -> DsheapdaryNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_d_ary_node_len(s : DsheapdaryNode) -> Int { s.size }

pub fn ds_heap_d_ary_node_get(s : DsheapdaryNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_d_ary_node_set(s : DsheapdaryNode, i : Int, v : Double) -> DsheapdaryNode {
  let result = ds_heap_d_ary_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_d_ary_node_sum(s : DsheapdaryNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_heap_d_ary_node_mean(s : DsheapdaryNode) -> Double {
  if s.size == 0 { 0.0 } else { ds_heap_d_ary_node_sum(s) / s.size.to_double() }
}

pub fn ds_heap_d_ary_node_scale(s : DsheapdaryNode, f : Double) -> DsheapdaryNode {
  let result = ds_heap_d_ary_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_d_ary_node_add(a : DsheapdaryNode, b : DsheapdaryNode) -> DsheapdaryNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_d_ary_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_d_ary_node_copy(s : DsheapdaryNode) -> DsheapdaryNode {
  let result = ds_heap_d_ary_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_d_ary_node_fill(s : DsheapdaryNode, v : Double) -> DsheapdaryNode {
  let result = ds_heap_d_ary_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_d_ary_node_min(s : DsheapdaryNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_d_ary_node_max(s : DsheapdaryNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_d_ary_node_to_string(s : DsheapdaryNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapdaryEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_d_ary_edge_make(size : Int) -> DsheapdaryEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_d_ary_edge_len(s : DsheapdaryEdge) -> Int { s.size }

pub fn ds_heap_d_ary_edge_get(s : DsheapdaryEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_d_ary_edge_set(s : DsheapdaryEdge, i : Int, v : Double) -> DsheapdaryEdge {
  let result = ds_heap_d_ary_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_d_ary_edge_sum(s : DsheapdaryEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_heap_d_ary_edge_mean(s : DsheapdaryEdge) -> Double {
  if s.size == 0 { 0.0 } else { ds_heap_d_ary_edge_sum(s) / s.size.to_double() }
}

pub fn ds_heap_d_ary_edge_scale(s : DsheapdaryEdge, f : Double) -> DsheapdaryEdge {
  let result = ds_heap_d_ary_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_d_ary_edge_add(a : DsheapdaryEdge, b : DsheapdaryEdge) -> DsheapdaryEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_d_ary_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_d_ary_edge_copy(s : DsheapdaryEdge) -> DsheapdaryEdge {
  let result = ds_heap_d_ary_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_d_ary_edge_fill(s : DsheapdaryEdge, v : Double) -> DsheapdaryEdge {
  let result = ds_heap_d_ary_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_d_ary_edge_min(s : DsheapdaryEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_d_ary_edge_max(s : DsheapdaryEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_d_ary_edge_to_string(s : DsheapdaryEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapdaryPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_d_ary_path_make(size : Int) -> DsheapdaryPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_d_ary_path_len(s : DsheapdaryPath) -> Int { s.size }

pub fn ds_heap_d_ary_path_get(s : DsheapdaryPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_d_ary_path_set(s : DsheapdaryPath, i : Int, v : Double) -> DsheapdaryPath {
  let result = ds_heap_d_ary_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_d_ary_path_sum(s : DsheapdaryPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_heap_d_ary_path_mean(s : DsheapdaryPath) -> Double {
  if s.size == 0 { 0.0 } else { ds_heap_d_ary_path_sum(s) / s.size.to_double() }
}

pub fn ds_heap_d_ary_path_scale(s : DsheapdaryPath, f : Double) -> DsheapdaryPath {
  let result = ds_heap_d_ary_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_d_ary_path_add(a : DsheapdaryPath, b : DsheapdaryPath) -> DsheapdaryPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_d_ary_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_d_ary_path_copy(s : DsheapdaryPath) -> DsheapdaryPath {
  let result = ds_heap_d_ary_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_d_ary_path_fill(s : DsheapdaryPath, v : Double) -> DsheapdaryPath {
  let result = ds_heap_d_ary_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_d_ary_path_min(s : DsheapdaryPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_d_ary_path_max(s : DsheapdaryPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_d_ary_path_to_string(s : DsheapdaryPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapdaryCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_d_ary_cluster_make(size : Int) -> DsheapdaryCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_d_ary_cluster_len(s : DsheapdaryCluster) -> Int { s.size }

pub fn ds_heap_d_ary_cluster_get(s : DsheapdaryCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_d_ary_cluster_set(s : DsheapdaryCluster, i : Int, v : Double) -> DsheapdaryCluster {
  let result = ds_heap_d_ary_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_d_ary_cluster_sum(s : DsheapdaryCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_heap_d_ary_cluster_mean(s : DsheapdaryCluster) -> Double {
  if s.size == 0 { 0.0 } else { ds_heap_d_ary_cluster_sum(s) / s.size.to_double() }
}

pub fn ds_heap_d_ary_cluster_scale(s : DsheapdaryCluster, f : Double) -> DsheapdaryCluster {
  let result = ds_heap_d_ary_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_d_ary_cluster_add(a : DsheapdaryCluster, b : DsheapdaryCluster) -> DsheapdaryCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_d_ary_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_d_ary_cluster_copy(s : DsheapdaryCluster) -> DsheapdaryCluster {
  let result = ds_heap_d_ary_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_d_ary_cluster_fill(s : DsheapdaryCluster, v : Double) -> DsheapdaryCluster {
  let result = ds_heap_d_ary_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_d_ary_cluster_min(s : DsheapdaryCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_d_ary_cluster_max(s : DsheapdaryCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_d_ary_cluster_to_string(s : DsheapdaryCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapdaryModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_d_ary_model_make(size : Int) -> DsheapdaryModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_d_ary_model_len(s : DsheapdaryModel) -> Int { s.size }

pub fn ds_heap_d_ary_model_get(s : DsheapdaryModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_d_ary_model_set(s : DsheapdaryModel, i : Int, v : Double) -> DsheapdaryModel {
  let result = ds_heap_d_ary_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_d_ary_model_sum(s : DsheapdaryModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_heap_d_ary_model_mean(s : DsheapdaryModel) -> Double {
  if s.size == 0 { 0.0 } else { ds_heap_d_ary_model_sum(s) / s.size.to_double() }
}

pub fn ds_heap_d_ary_model_scale(s : DsheapdaryModel, f : Double) -> DsheapdaryModel {
  let result = ds_heap_d_ary_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_d_ary_model_add(a : DsheapdaryModel, b : DsheapdaryModel) -> DsheapdaryModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_d_ary_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_d_ary_model_copy(s : DsheapdaryModel) -> DsheapdaryModel {
  let result = ds_heap_d_ary_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_d_ary_model_fill(s : DsheapdaryModel, v : Double) -> DsheapdaryModel {
  let result = ds_heap_d_ary_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_d_ary_model_min(s : DsheapdaryModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_d_ary_model_max(s : DsheapdaryModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_d_ary_model_to_string(s : DsheapdaryModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapdaryLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_d_ary_layer_make(size : Int) -> DsheapdaryLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_d_ary_layer_len(s : DsheapdaryLayer) -> Int { s.size }

pub fn ds_heap_d_ary_layer_get(s : DsheapdaryLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_d_ary_layer_set(s : DsheapdaryLayer, i : Int, v : Double) -> DsheapdaryLayer {
  let result = ds_heap_d_ary_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_d_ary_layer_sum(s : DsheapdaryLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_heap_d_ary_layer_mean(s : DsheapdaryLayer) -> Double {
  if s.size == 0 { 0.0 } else { ds_heap_d_ary_layer_sum(s) / s.size.to_double() }
}

pub fn ds_heap_d_ary_layer_scale(s : DsheapdaryLayer, f : Double) -> DsheapdaryLayer {
  let result = ds_heap_d_ary_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_d_ary_layer_add(a : DsheapdaryLayer, b : DsheapdaryLayer) -> DsheapdaryLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_d_ary_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_d_ary_layer_copy(s : DsheapdaryLayer) -> DsheapdaryLayer {
  let result = ds_heap_d_ary_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_d_ary_layer_fill(s : DsheapdaryLayer, v : Double) -> DsheapdaryLayer {
  let result = ds_heap_d_ary_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_d_ary_layer_min(s : DsheapdaryLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_d_ary_layer_max(s : DsheapdaryLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_d_ary_layer_to_string(s : DsheapdaryLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapdaryBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_d_ary_buffer_make(size : Int) -> DsheapdaryBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_d_ary_buffer_len(s : DsheapdaryBuffer) -> Int { s.size }

pub fn ds_heap_d_ary_buffer_get(s : DsheapdaryBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_d_ary_buffer_set(s : DsheapdaryBuffer, i : Int, v : Double) -> DsheapdaryBuffer {
  let result = ds_heap_d_ary_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_d_ary_buffer_sum(s : DsheapdaryBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_heap_d_ary_buffer_mean(s : DsheapdaryBuffer) -> Double {
  if s.size == 0 { 0.0 } else { ds_heap_d_ary_buffer_sum(s) / s.size.to_double() }
}

pub fn ds_heap_d_ary_buffer_scale(s : DsheapdaryBuffer, f : Double) -> DsheapdaryBuffer {
  let result = ds_heap_d_ary_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_d_ary_buffer_add(a : DsheapdaryBuffer, b : DsheapdaryBuffer) -> DsheapdaryBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_d_ary_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_d_ary_buffer_copy(s : DsheapdaryBuffer) -> DsheapdaryBuffer {
  let result = ds_heap_d_ary_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_d_ary_buffer_fill(s : DsheapdaryBuffer, v : Double) -> DsheapdaryBuffer {
  let result = ds_heap_d_ary_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_d_ary_buffer_min(s : DsheapdaryBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_d_ary_buffer_max(s : DsheapdaryBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_d_ary_buffer_to_string(s : DsheapdaryBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapdaryCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_d_ary_cursor_make(size : Int) -> DsheapdaryCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_d_ary_cursor_len(s : DsheapdaryCursor) -> Int { s.size }

pub fn ds_heap_d_ary_cursor_get(s : DsheapdaryCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_d_ary_cursor_set(s : DsheapdaryCursor, i : Int, v : Double) -> DsheapdaryCursor {
  let result = ds_heap_d_ary_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_d_ary_cursor_sum(s : DsheapdaryCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_heap_d_ary_cursor_mean(s : DsheapdaryCursor) -> Double {
  if s.size == 0 { 0.0 } else { ds_heap_d_ary_cursor_sum(s) / s.size.to_double() }
}

pub fn ds_heap_d_ary_cursor_scale(s : DsheapdaryCursor, f : Double) -> DsheapdaryCursor {
  let result = ds_heap_d_ary_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_d_ary_cursor_add(a : DsheapdaryCursor, b : DsheapdaryCursor) -> DsheapdaryCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_d_ary_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_d_ary_cursor_copy(s : DsheapdaryCursor) -> DsheapdaryCursor {
  let result = ds_heap_d_ary_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_d_ary_cursor_fill(s : DsheapdaryCursor, v : Double) -> DsheapdaryCursor {
  let result = ds_heap_d_ary_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_d_ary_cursor_min(s : DsheapdaryCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_d_ary_cursor_max(s : DsheapdaryCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_d_ary_cursor_to_string(s : DsheapdaryCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapdaryView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_d_ary_view_make(size : Int) -> DsheapdaryView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_d_ary_view_len(s : DsheapdaryView) -> Int { s.size }

pub fn ds_heap_d_ary_view_get(s : DsheapdaryView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_d_ary_view_set(s : DsheapdaryView, i : Int, v : Double) -> DsheapdaryView {
  let result = ds_heap_d_ary_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_d_ary_view_sum(s : DsheapdaryView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_heap_d_ary_view_mean(s : DsheapdaryView) -> Double {
  if s.size == 0 { 0.0 } else { ds_heap_d_ary_view_sum(s) / s.size.to_double() }
}

pub fn ds_heap_d_ary_view_scale(s : DsheapdaryView, f : Double) -> DsheapdaryView {
  let result = ds_heap_d_ary_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_d_ary_view_add(a : DsheapdaryView, b : DsheapdaryView) -> DsheapdaryView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_d_ary_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_d_ary_view_copy(s : DsheapdaryView) -> DsheapdaryView {
  let result = ds_heap_d_ary_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_d_ary_view_fill(s : DsheapdaryView, v : Double) -> DsheapdaryView {
  let result = ds_heap_d_ary_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_d_ary_view_min(s : DsheapdaryView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_d_ary_view_max(s : DsheapdaryView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_d_ary_view_to_string(s : DsheapdaryView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapdaryRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_d_ary_range_make(size : Int) -> DsheapdaryRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_d_ary_range_len(s : DsheapdaryRange) -> Int { s.size }

pub fn ds_heap_d_ary_range_get(s : DsheapdaryRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_d_ary_range_set(s : DsheapdaryRange, i : Int, v : Double) -> DsheapdaryRange {
  let result = ds_heap_d_ary_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_d_ary_range_sum(s : DsheapdaryRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_heap_d_ary_range_mean(s : DsheapdaryRange) -> Double {
  if s.size == 0 { 0.0 } else { ds_heap_d_ary_range_sum(s) / s.size.to_double() }
}

pub fn ds_heap_d_ary_range_scale(s : DsheapdaryRange, f : Double) -> DsheapdaryRange {
  let result = ds_heap_d_ary_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_d_ary_range_add(a : DsheapdaryRange, b : DsheapdaryRange) -> DsheapdaryRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_d_ary_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_d_ary_range_copy(s : DsheapdaryRange) -> DsheapdaryRange {
  let result = ds_heap_d_ary_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_d_ary_range_fill(s : DsheapdaryRange, v : Double) -> DsheapdaryRange {
  let result = ds_heap_d_ary_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_d_ary_range_min(s : DsheapdaryRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_d_ary_range_max(s : DsheapdaryRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_d_ary_range_to_string(s : DsheapdaryRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapdarySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_d_ary_slice_make(size : Int) -> DsheapdarySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_d_ary_slice_len(s : DsheapdarySlice) -> Int { s.size }

pub fn ds_heap_d_ary_slice_get(s : DsheapdarySlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_d_ary_slice_set(s : DsheapdarySlice, i : Int, v : Double) -> DsheapdarySlice {
  let result = ds_heap_d_ary_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_d_ary_slice_sum(s : DsheapdarySlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_heap_d_ary_slice_mean(s : DsheapdarySlice) -> Double {
  if s.size == 0 { 0.0 } else { ds_heap_d_ary_slice_sum(s) / s.size.to_double() }
}

pub fn ds_heap_d_ary_slice_scale(s : DsheapdarySlice, f : Double) -> DsheapdarySlice {
  let result = ds_heap_d_ary_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_d_ary_slice_add(a : DsheapdarySlice, b : DsheapdarySlice) -> DsheapdarySlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_d_ary_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_d_ary_slice_copy(s : DsheapdarySlice) -> DsheapdarySlice {
  let result = ds_heap_d_ary_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_d_ary_slice_fill(s : DsheapdarySlice, v : Double) -> DsheapdarySlice {
  let result = ds_heap_d_ary_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_d_ary_slice_min(s : DsheapdarySlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_d_ary_slice_max(s : DsheapdarySlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_d_ary_slice_to_string(s : DsheapdarySlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn ds_heap_d_ary_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_heap_d_ary_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_heap_d_ary_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_heap_d_ary_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_heap_d_ary_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_heap_d_ary_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_heap_d_ary_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_heap_d_ary_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_heap_d_ary_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_heap_d_ary_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_heap_d_ary_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_heap_d_ary_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_heap_d_ary_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_heap_d_ary_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_heap_d_ary_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_heap_d_ary_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_heap_d_ary_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_heap_d_ary_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_heap_d_ary_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_heap_d_ary_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_heap_d_ary_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_heap_d_ary_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_heap_d_ary_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_heap_d_ary_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_heap_d_ary_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}


///===
/// extcore/ds_list_unrolled

pub(all) struct DslistunrolledPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_list_unrolled_make_point(x : Double, y : Double) -> DslistunrolledPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_list_unrolled_make_point3(x : Double, y : Double, z : Double) -> DslistunrolledPoint {
  { x, y, z, label: 0 }
}

pub fn ds_list_unrolled_point_x(pt : DslistunrolledPoint) -> Double { pt.x }

pub fn ds_list_unrolled_point_y(pt : DslistunrolledPoint) -> Double { pt.y }

pub fn ds_list_unrolled_point_z(pt : DslistunrolledPoint) -> Double { pt.z }

pub fn ds_list_unrolled_point_label(pt : DslistunrolledPoint) -> Int { pt.label }

pub fn ds_list_unrolled_point_dist(a : DslistunrolledPoint, b : DslistunrolledPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  ds_list_unrolled_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ds_list_unrolled_point_add(a : DslistunrolledPoint, b : DslistunrolledPoint) -> DslistunrolledPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ds_list_unrolled_point_sub(a : DslistunrolledPoint, b : DslistunrolledPoint) -> DslistunrolledPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ds_list_unrolled_point_scale(pt : DslistunrolledPoint, s : Double) -> DslistunrolledPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ds_list_unrolled_point_dot(a : DslistunrolledPoint, b : DslistunrolledPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ds_list_unrolled_point_cross(a : DslistunrolledPoint, b : DslistunrolledPoint) -> DslistunrolledPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ds_list_unrolled_point_norm(pt : DslistunrolledPoint) -> Double {
  ds_list_unrolled_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ds_list_unrolled_point_normalize(pt : DslistunrolledPoint) -> DslistunrolledPoint {
  let n = ds_list_unrolled_point_norm(pt)
  if n < 0.0000001 { pt } else { ds_list_unrolled_point_scale(pt, 1.0 / n) }
}

pub fn ds_list_unrolled_point_negate(pt : DslistunrolledPoint) -> DslistunrolledPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ds_list_unrolled_point_mid(a : DslistunrolledPoint, b : DslistunrolledPoint) -> DslistunrolledPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ds_list_unrolled_point_lerp(a : DslistunrolledPoint, b : DslistunrolledPoint, t : Double) -> DslistunrolledPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ds_list_unrolled_point_to_string(pt : DslistunrolledPoint) -> String {
  "(" + ds_list_unrolled_dbl(pt.x) + ", " + ds_list_unrolled_dbl(pt.y) + ", " + ds_list_unrolled_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DslistunrolledSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_list_unrolled_make_series(vals : Array[Double], name : String) -> DslistunrolledSeries {
  { vals, name, meta: 0 }
}

pub fn ds_list_unrolled_series_len(s : DslistunrolledSeries) -> Int { s.vals.length() }

pub fn ds_list_unrolled_series_sum(s : DslistunrolledSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn ds_list_unrolled_series_mean(s : DslistunrolledSeries) -> Double {
  let n = ds_list_unrolled_series_len(s)
  if n == 0 { 0.0 } else { ds_list_unrolled_series_sum(s) / n.to_double() }
}

pub fn ds_list_unrolled_series_min(s : DslistunrolledSeries) -> Double {
  let n = ds_list_unrolled_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn ds_list_unrolled_series_max(s : DslistunrolledSeries) -> Double {
  let n = ds_list_unrolled_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn ds_list_unrolled_series_range(s : DslistunrolledSeries) -> Double {
  ds_list_unrolled_series_max(s) - ds_list_unrolled_series_min(s)
}

pub fn ds_list_unrolled_series_var(s : DslistunrolledSeries) -> Double {
  let n = ds_list_unrolled_series_len(s)
  if n == 0 { 0.0 } else {
    let m = ds_list_unrolled_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn ds_list_unrolled_series_std(s : DslistunrolledSeries) -> Double { ds_list_unrolled_sqrt(ds_list_unrolled_series_var(s)) }

pub fn ds_list_unrolled_series_median(s : DslistunrolledSeries) -> Double {
  let n = ds_list_unrolled_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = ds_list_unrolled_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ds_list_unrolled_series_scale(s : DslistunrolledSeries, f : Double) -> DslistunrolledSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = ds_list_unrolled_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ds_list_unrolled_series_add(a : DslistunrolledSeries, b : DslistunrolledSeries) -> DslistunrolledSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = ds_list_unrolled_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ds_list_unrolled_series_sub(a : DslistunrolledSeries, b : DslistunrolledSeries) -> DslistunrolledSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = ds_list_unrolled_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ds_list_unrolled_series_normalize(s : DslistunrolledSeries) -> DslistunrolledSeries {
  let mn = ds_list_unrolled_series_min(s)
  let mx = ds_list_unrolled_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = ds_list_unrolled_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ds_list_unrolled_series_cumsum(s : DslistunrolledSeries) -> DslistunrolledSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = ds_list_unrolled_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn ds_list_unrolled_series_to_string(s : DslistunrolledSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + ds_list_unrolled_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DslistunrolledMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_list_unrolled_make_matrix(rows : Int, cols : Int, val : Double) -> DslistunrolledMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_list_unrolled_matrix_identity(n : Int) -> DslistunrolledMatrix {
  let m = ds_list_unrolled_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ds_list_unrolled_matrix_get(m : DslistunrolledMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ds_list_unrolled_matrix_transpose(m : DslistunrolledMatrix) -> DslistunrolledMatrix {
  let result = ds_list_unrolled_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ds_list_unrolled_matrix_add(a : DslistunrolledMatrix, b : DslistunrolledMatrix) -> DslistunrolledMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ds_list_unrolled_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ds_list_unrolled_matrix_scale(m : DslistunrolledMatrix, s : Double) -> DslistunrolledMatrix {
  let result = ds_list_unrolled_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ds_list_unrolled_matrix_multiply(a : DslistunrolledMatrix, b : DslistunrolledMatrix) -> DslistunrolledMatrix {
  if a.cols != b.rows { return ds_list_unrolled_make_matrix(a.rows, b.cols, 0.0) }
  let result = ds_list_unrolled_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ds_list_unrolled_matrix_trace(m : DslistunrolledMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ds_list_unrolled_matrix_det(m : DslistunrolledMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ds_list_unrolled_matrix_norm(m : DslistunrolledMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  ds_list_unrolled_sqrt(sum)
}

pub fn ds_list_unrolled_matrix_to_string(m : DslistunrolledMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + ds_list_unrolled_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct DslistunrolledVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_list_unrolled_make_vector(comps : Array[Double]) -> DslistunrolledVector {
  { comps, dim: comps.length() }
}

pub fn ds_list_unrolled_vector_zero(dim : Int) -> DslistunrolledVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ds_list_unrolled_vector_add(a : DslistunrolledVector, b : DslistunrolledVector) -> DslistunrolledVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = ds_list_unrolled_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_list_unrolled_vector_sub(a : DslistunrolledVector, b : DslistunrolledVector) -> DslistunrolledVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = ds_list_unrolled_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_list_unrolled_vector_scale(v : DslistunrolledVector, s : Double) -> DslistunrolledVector {
  let mut result = []
  for i in 0..<v.dim { result = ds_list_unrolled_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ds_list_unrolled_vector_dot(a : DslistunrolledVector, b : DslistunrolledVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ds_list_unrolled_vector_norm(v : DslistunrolledVector) -> Double { ds_list_unrolled_sqrt(ds_list_unrolled_vector_dot(v, v)) }

pub fn ds_list_unrolled_vector_normalize(v : DslistunrolledVector) -> DslistunrolledVector {
  let n = ds_list_unrolled_vector_norm(v)
  if n < 0.0000001 { v } else { ds_list_unrolled_vector_scale(v, 1.0 / n) }
}

pub fn ds_list_unrolled_vector_dist(a : DslistunrolledVector, b : DslistunrolledVector) -> Double {
  ds_list_unrolled_vector_norm(ds_list_unrolled_vector_sub(a, b))
}

pub fn ds_list_unrolled_vector_to_string(v : DslistunrolledVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + ds_list_unrolled_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_list_unrolled_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn ds_list_unrolled_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = ds_list_unrolled_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ds_list_unrolled_std(data : Array[Double]) -> Double { ds_list_unrolled_sqrt(ds_list_unrolled_var(data)) }

pub fn ds_list_unrolled_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = ds_list_unrolled_mean(a); let mb = ds_list_unrolled_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn ds_list_unrolled_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = ds_list_unrolled_std(a); let sb = ds_list_unrolled_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { ds_list_unrolled_cov(a, b) / (sa * sb) }
}

pub fn ds_list_unrolled_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = ds_list_unrolled_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ds_list_unrolled_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn ds_list_unrolled_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ds_list_unrolled_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  ds_list_unrolled_sqrt(ds_list_unrolled_mse(pred, labels))
}

pub fn ds_list_unrolled_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + ds_list_unrolled_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn ds_list_unrolled_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = ds_list_unrolled_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn ds_list_unrolled_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn ds_list_unrolled_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn ds_list_unrolled_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = ds_list_unrolled_precision(pred, labels, pos); let r = ds_list_unrolled_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn ds_list_unrolled_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn ds_list_unrolled_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = ds_list_unrolled_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn ds_list_unrolled_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn ds_list_unrolled_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn ds_list_unrolled_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = ds_list_unrolled_gcd(a, b)
    (a / g) * b
  }
}

pub fn ds_list_unrolled_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn ds_list_unrolled_fibonacci(n : Int) -> Int {
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

pub fn ds_list_unrolled_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = ds_list_unrolled_min(data); let mx = ds_list_unrolled_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn ds_list_unrolled_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = ds_list_unrolled_mean(data); let sd = ds_list_unrolled_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn ds_list_unrolled_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn ds_list_unrolled_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn ds_list_unrolled_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn ds_list_unrolled_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn ds_list_unrolled_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn ds_list_unrolled_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn ds_list_unrolled_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn ds_list_unrolled_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn ds_list_unrolled_dbl(x : Double) -> String {
  let i = if x >= 0.0 { ds_list_unrolled_int(x) } else { -ds_list_unrolled_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { ds_list_unrolled_int(f * 1000000.0) } else { ds_list_unrolled_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn ds_list_unrolled_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn ds_list_unrolled_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct DslistunrolledFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_unrolled_frame_make(size : Int) -> DslistunrolledFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_unrolled_frame_len(s : DslistunrolledFrame) -> Int { s.size }

pub fn ds_list_unrolled_frame_get(s : DslistunrolledFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_unrolled_frame_set(s : DslistunrolledFrame, i : Int, v : Double) -> DslistunrolledFrame {
  let result = ds_list_unrolled_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_unrolled_frame_sum(s : DslistunrolledFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_unrolled_frame_mean(s : DslistunrolledFrame) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_unrolled_frame_sum(s) / s.size.to_double() }
}

pub fn ds_list_unrolled_frame_scale(s : DslistunrolledFrame, f : Double) -> DslistunrolledFrame {
  let result = ds_list_unrolled_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_unrolled_frame_add(a : DslistunrolledFrame, b : DslistunrolledFrame) -> DslistunrolledFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_unrolled_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_unrolled_frame_copy(s : DslistunrolledFrame) -> DslistunrolledFrame {
  let result = ds_list_unrolled_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_unrolled_frame_fill(s : DslistunrolledFrame, v : Double) -> DslistunrolledFrame {
  let result = ds_list_unrolled_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_unrolled_frame_min(s : DslistunrolledFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_unrolled_frame_max(s : DslistunrolledFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_unrolled_frame_to_string(s : DslistunrolledFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistunrolledTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_unrolled_table_make(size : Int) -> DslistunrolledTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_unrolled_table_len(s : DslistunrolledTable) -> Int { s.size }

pub fn ds_list_unrolled_table_get(s : DslistunrolledTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_unrolled_table_set(s : DslistunrolledTable, i : Int, v : Double) -> DslistunrolledTable {
  let result = ds_list_unrolled_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_unrolled_table_sum(s : DslistunrolledTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_unrolled_table_mean(s : DslistunrolledTable) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_unrolled_table_sum(s) / s.size.to_double() }
}

pub fn ds_list_unrolled_table_scale(s : DslistunrolledTable, f : Double) -> DslistunrolledTable {
  let result = ds_list_unrolled_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_unrolled_table_add(a : DslistunrolledTable, b : DslistunrolledTable) -> DslistunrolledTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_unrolled_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_unrolled_table_copy(s : DslistunrolledTable) -> DslistunrolledTable {
  let result = ds_list_unrolled_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_unrolled_table_fill(s : DslistunrolledTable, v : Double) -> DslistunrolledTable {
  let result = ds_list_unrolled_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_unrolled_table_min(s : DslistunrolledTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_unrolled_table_max(s : DslistunrolledTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_unrolled_table_to_string(s : DslistunrolledTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistunrolledGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_unrolled_graphn_make(size : Int) -> DslistunrolledGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_unrolled_graphn_len(s : DslistunrolledGraphN) -> Int { s.size }

pub fn ds_list_unrolled_graphn_get(s : DslistunrolledGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_unrolled_graphn_set(s : DslistunrolledGraphN, i : Int, v : Double) -> DslistunrolledGraphN {
  let result = ds_list_unrolled_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_unrolled_graphn_sum(s : DslistunrolledGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_unrolled_graphn_mean(s : DslistunrolledGraphN) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_unrolled_graphn_sum(s) / s.size.to_double() }
}

pub fn ds_list_unrolled_graphn_scale(s : DslistunrolledGraphN, f : Double) -> DslistunrolledGraphN {
  let result = ds_list_unrolled_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_unrolled_graphn_add(a : DslistunrolledGraphN, b : DslistunrolledGraphN) -> DslistunrolledGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_unrolled_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_unrolled_graphn_copy(s : DslistunrolledGraphN) -> DslistunrolledGraphN {
  let result = ds_list_unrolled_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_unrolled_graphn_fill(s : DslistunrolledGraphN, v : Double) -> DslistunrolledGraphN {
  let result = ds_list_unrolled_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_unrolled_graphn_min(s : DslistunrolledGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_unrolled_graphn_max(s : DslistunrolledGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_unrolled_graphn_to_string(s : DslistunrolledGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistunrolledNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_unrolled_node_make(size : Int) -> DslistunrolledNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_unrolled_node_len(s : DslistunrolledNode) -> Int { s.size }

pub fn ds_list_unrolled_node_get(s : DslistunrolledNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_unrolled_node_set(s : DslistunrolledNode, i : Int, v : Double) -> DslistunrolledNode {
  let result = ds_list_unrolled_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_unrolled_node_sum(s : DslistunrolledNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_unrolled_node_mean(s : DslistunrolledNode) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_unrolled_node_sum(s) / s.size.to_double() }
}

pub fn ds_list_unrolled_node_scale(s : DslistunrolledNode, f : Double) -> DslistunrolledNode {
  let result = ds_list_unrolled_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_unrolled_node_add(a : DslistunrolledNode, b : DslistunrolledNode) -> DslistunrolledNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_unrolled_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_unrolled_node_copy(s : DslistunrolledNode) -> DslistunrolledNode {
  let result = ds_list_unrolled_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_unrolled_node_fill(s : DslistunrolledNode, v : Double) -> DslistunrolledNode {
  let result = ds_list_unrolled_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_unrolled_node_min(s : DslistunrolledNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_unrolled_node_max(s : DslistunrolledNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_unrolled_node_to_string(s : DslistunrolledNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistunrolledEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_unrolled_edge_make(size : Int) -> DslistunrolledEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_unrolled_edge_len(s : DslistunrolledEdge) -> Int { s.size }

pub fn ds_list_unrolled_edge_get(s : DslistunrolledEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_unrolled_edge_set(s : DslistunrolledEdge, i : Int, v : Double) -> DslistunrolledEdge {
  let result = ds_list_unrolled_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_unrolled_edge_sum(s : DslistunrolledEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_unrolled_edge_mean(s : DslistunrolledEdge) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_unrolled_edge_sum(s) / s.size.to_double() }
}

pub fn ds_list_unrolled_edge_scale(s : DslistunrolledEdge, f : Double) -> DslistunrolledEdge {
  let result = ds_list_unrolled_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_unrolled_edge_add(a : DslistunrolledEdge, b : DslistunrolledEdge) -> DslistunrolledEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_unrolled_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_unrolled_edge_copy(s : DslistunrolledEdge) -> DslistunrolledEdge {
  let result = ds_list_unrolled_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_unrolled_edge_fill(s : DslistunrolledEdge, v : Double) -> DslistunrolledEdge {
  let result = ds_list_unrolled_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_unrolled_edge_min(s : DslistunrolledEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_unrolled_edge_max(s : DslistunrolledEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_unrolled_edge_to_string(s : DslistunrolledEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistunrolledPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_unrolled_path_make(size : Int) -> DslistunrolledPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_unrolled_path_len(s : DslistunrolledPath) -> Int { s.size }

pub fn ds_list_unrolled_path_get(s : DslistunrolledPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_unrolled_path_set(s : DslistunrolledPath, i : Int, v : Double) -> DslistunrolledPath {
  let result = ds_list_unrolled_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_unrolled_path_sum(s : DslistunrolledPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_unrolled_path_mean(s : DslistunrolledPath) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_unrolled_path_sum(s) / s.size.to_double() }
}

pub fn ds_list_unrolled_path_scale(s : DslistunrolledPath, f : Double) -> DslistunrolledPath {
  let result = ds_list_unrolled_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_unrolled_path_add(a : DslistunrolledPath, b : DslistunrolledPath) -> DslistunrolledPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_unrolled_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_unrolled_path_copy(s : DslistunrolledPath) -> DslistunrolledPath {
  let result = ds_list_unrolled_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_unrolled_path_fill(s : DslistunrolledPath, v : Double) -> DslistunrolledPath {
  let result = ds_list_unrolled_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_unrolled_path_min(s : DslistunrolledPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_unrolled_path_max(s : DslistunrolledPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_unrolled_path_to_string(s : DslistunrolledPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistunrolledCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_unrolled_cluster_make(size : Int) -> DslistunrolledCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_unrolled_cluster_len(s : DslistunrolledCluster) -> Int { s.size }

pub fn ds_list_unrolled_cluster_get(s : DslistunrolledCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_unrolled_cluster_set(s : DslistunrolledCluster, i : Int, v : Double) -> DslistunrolledCluster {
  let result = ds_list_unrolled_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_unrolled_cluster_sum(s : DslistunrolledCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_unrolled_cluster_mean(s : DslistunrolledCluster) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_unrolled_cluster_sum(s) / s.size.to_double() }
}

pub fn ds_list_unrolled_cluster_scale(s : DslistunrolledCluster, f : Double) -> DslistunrolledCluster {
  let result = ds_list_unrolled_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_unrolled_cluster_add(a : DslistunrolledCluster, b : DslistunrolledCluster) -> DslistunrolledCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_unrolled_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_unrolled_cluster_copy(s : DslistunrolledCluster) -> DslistunrolledCluster {
  let result = ds_list_unrolled_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_unrolled_cluster_fill(s : DslistunrolledCluster, v : Double) -> DslistunrolledCluster {
  let result = ds_list_unrolled_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_unrolled_cluster_min(s : DslistunrolledCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_unrolled_cluster_max(s : DslistunrolledCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_unrolled_cluster_to_string(s : DslistunrolledCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistunrolledModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_unrolled_model_make(size : Int) -> DslistunrolledModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_unrolled_model_len(s : DslistunrolledModel) -> Int { s.size }

pub fn ds_list_unrolled_model_get(s : DslistunrolledModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_unrolled_model_set(s : DslistunrolledModel, i : Int, v : Double) -> DslistunrolledModel {
  let result = ds_list_unrolled_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_unrolled_model_sum(s : DslistunrolledModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_unrolled_model_mean(s : DslistunrolledModel) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_unrolled_model_sum(s) / s.size.to_double() }
}

pub fn ds_list_unrolled_model_scale(s : DslistunrolledModel, f : Double) -> DslistunrolledModel {
  let result = ds_list_unrolled_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_unrolled_model_add(a : DslistunrolledModel, b : DslistunrolledModel) -> DslistunrolledModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_unrolled_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_unrolled_model_copy(s : DslistunrolledModel) -> DslistunrolledModel {
  let result = ds_list_unrolled_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_unrolled_model_fill(s : DslistunrolledModel, v : Double) -> DslistunrolledModel {
  let result = ds_list_unrolled_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_unrolled_model_min(s : DslistunrolledModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_unrolled_model_max(s : DslistunrolledModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_unrolled_model_to_string(s : DslistunrolledModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistunrolledLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_unrolled_layer_make(size : Int) -> DslistunrolledLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_unrolled_layer_len(s : DslistunrolledLayer) -> Int { s.size }

pub fn ds_list_unrolled_layer_get(s : DslistunrolledLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_unrolled_layer_set(s : DslistunrolledLayer, i : Int, v : Double) -> DslistunrolledLayer {
  let result = ds_list_unrolled_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_unrolled_layer_sum(s : DslistunrolledLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_unrolled_layer_mean(s : DslistunrolledLayer) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_unrolled_layer_sum(s) / s.size.to_double() }
}

pub fn ds_list_unrolled_layer_scale(s : DslistunrolledLayer, f : Double) -> DslistunrolledLayer {
  let result = ds_list_unrolled_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_unrolled_layer_add(a : DslistunrolledLayer, b : DslistunrolledLayer) -> DslistunrolledLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_unrolled_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_unrolled_layer_copy(s : DslistunrolledLayer) -> DslistunrolledLayer {
  let result = ds_list_unrolled_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_unrolled_layer_fill(s : DslistunrolledLayer, v : Double) -> DslistunrolledLayer {
  let result = ds_list_unrolled_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_unrolled_layer_min(s : DslistunrolledLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_unrolled_layer_max(s : DslistunrolledLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_unrolled_layer_to_string(s : DslistunrolledLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistunrolledBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_unrolled_buffer_make(size : Int) -> DslistunrolledBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_unrolled_buffer_len(s : DslistunrolledBuffer) -> Int { s.size }

pub fn ds_list_unrolled_buffer_get(s : DslistunrolledBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_unrolled_buffer_set(s : DslistunrolledBuffer, i : Int, v : Double) -> DslistunrolledBuffer {
  let result = ds_list_unrolled_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_unrolled_buffer_sum(s : DslistunrolledBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_unrolled_buffer_mean(s : DslistunrolledBuffer) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_unrolled_buffer_sum(s) / s.size.to_double() }
}

pub fn ds_list_unrolled_buffer_scale(s : DslistunrolledBuffer, f : Double) -> DslistunrolledBuffer {
  let result = ds_list_unrolled_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_unrolled_buffer_add(a : DslistunrolledBuffer, b : DslistunrolledBuffer) -> DslistunrolledBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_unrolled_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_unrolled_buffer_copy(s : DslistunrolledBuffer) -> DslistunrolledBuffer {
  let result = ds_list_unrolled_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_unrolled_buffer_fill(s : DslistunrolledBuffer, v : Double) -> DslistunrolledBuffer {
  let result = ds_list_unrolled_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_unrolled_buffer_min(s : DslistunrolledBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_unrolled_buffer_max(s : DslistunrolledBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_unrolled_buffer_to_string(s : DslistunrolledBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistunrolledCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_unrolled_cursor_make(size : Int) -> DslistunrolledCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_unrolled_cursor_len(s : DslistunrolledCursor) -> Int { s.size }

pub fn ds_list_unrolled_cursor_get(s : DslistunrolledCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_unrolled_cursor_set(s : DslistunrolledCursor, i : Int, v : Double) -> DslistunrolledCursor {
  let result = ds_list_unrolled_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_unrolled_cursor_sum(s : DslistunrolledCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_unrolled_cursor_mean(s : DslistunrolledCursor) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_unrolled_cursor_sum(s) / s.size.to_double() }
}

pub fn ds_list_unrolled_cursor_scale(s : DslistunrolledCursor, f : Double) -> DslistunrolledCursor {
  let result = ds_list_unrolled_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_unrolled_cursor_add(a : DslistunrolledCursor, b : DslistunrolledCursor) -> DslistunrolledCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_unrolled_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_unrolled_cursor_copy(s : DslistunrolledCursor) -> DslistunrolledCursor {
  let result = ds_list_unrolled_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_unrolled_cursor_fill(s : DslistunrolledCursor, v : Double) -> DslistunrolledCursor {
  let result = ds_list_unrolled_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_unrolled_cursor_min(s : DslistunrolledCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_unrolled_cursor_max(s : DslistunrolledCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_unrolled_cursor_to_string(s : DslistunrolledCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistunrolledView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_unrolled_view_make(size : Int) -> DslistunrolledView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_unrolled_view_len(s : DslistunrolledView) -> Int { s.size }

pub fn ds_list_unrolled_view_get(s : DslistunrolledView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_unrolled_view_set(s : DslistunrolledView, i : Int, v : Double) -> DslistunrolledView {
  let result = ds_list_unrolled_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_unrolled_view_sum(s : DslistunrolledView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_unrolled_view_mean(s : DslistunrolledView) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_unrolled_view_sum(s) / s.size.to_double() }
}

pub fn ds_list_unrolled_view_scale(s : DslistunrolledView, f : Double) -> DslistunrolledView {
  let result = ds_list_unrolled_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_unrolled_view_add(a : DslistunrolledView, b : DslistunrolledView) -> DslistunrolledView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_unrolled_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_unrolled_view_copy(s : DslistunrolledView) -> DslistunrolledView {
  let result = ds_list_unrolled_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_unrolled_view_fill(s : DslistunrolledView, v : Double) -> DslistunrolledView {
  let result = ds_list_unrolled_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_unrolled_view_min(s : DslistunrolledView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_unrolled_view_max(s : DslistunrolledView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_unrolled_view_to_string(s : DslistunrolledView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistunrolledRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_unrolled_range_make(size : Int) -> DslistunrolledRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_unrolled_range_len(s : DslistunrolledRange) -> Int { s.size }

pub fn ds_list_unrolled_range_get(s : DslistunrolledRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_unrolled_range_set(s : DslistunrolledRange, i : Int, v : Double) -> DslistunrolledRange {
  let result = ds_list_unrolled_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_unrolled_range_sum(s : DslistunrolledRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_unrolled_range_mean(s : DslistunrolledRange) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_unrolled_range_sum(s) / s.size.to_double() }
}

pub fn ds_list_unrolled_range_scale(s : DslistunrolledRange, f : Double) -> DslistunrolledRange {
  let result = ds_list_unrolled_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_unrolled_range_add(a : DslistunrolledRange, b : DslistunrolledRange) -> DslistunrolledRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_unrolled_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_unrolled_range_copy(s : DslistunrolledRange) -> DslistunrolledRange {
  let result = ds_list_unrolled_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_unrolled_range_fill(s : DslistunrolledRange, v : Double) -> DslistunrolledRange {
  let result = ds_list_unrolled_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_unrolled_range_min(s : DslistunrolledRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_unrolled_range_max(s : DslistunrolledRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_unrolled_range_to_string(s : DslistunrolledRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistunrolledSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_unrolled_slice_make(size : Int) -> DslistunrolledSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_unrolled_slice_len(s : DslistunrolledSlice) -> Int { s.size }

pub fn ds_list_unrolled_slice_get(s : DslistunrolledSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_unrolled_slice_set(s : DslistunrolledSlice, i : Int, v : Double) -> DslistunrolledSlice {
  let result = ds_list_unrolled_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_unrolled_slice_sum(s : DslistunrolledSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_unrolled_slice_mean(s : DslistunrolledSlice) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_unrolled_slice_sum(s) / s.size.to_double() }
}

pub fn ds_list_unrolled_slice_scale(s : DslistunrolledSlice, f : Double) -> DslistunrolledSlice {
  let result = ds_list_unrolled_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_unrolled_slice_add(a : DslistunrolledSlice, b : DslistunrolledSlice) -> DslistunrolledSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_unrolled_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_unrolled_slice_copy(s : DslistunrolledSlice) -> DslistunrolledSlice {
  let result = ds_list_unrolled_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_unrolled_slice_fill(s : DslistunrolledSlice, v : Double) -> DslistunrolledSlice {
  let result = ds_list_unrolled_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_unrolled_slice_min(s : DslistunrolledSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_unrolled_slice_max(s : DslistunrolledSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_unrolled_slice_to_string(s : DslistunrolledSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn ds_list_unrolled_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_list_unrolled_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_list_unrolled_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_list_unrolled_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_list_unrolled_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_list_unrolled_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_list_unrolled_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_list_unrolled_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_list_unrolled_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_list_unrolled_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_list_unrolled_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_list_unrolled_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_list_unrolled_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_list_unrolled_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_list_unrolled_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_list_unrolled_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_list_unrolled_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_list_unrolled_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_list_unrolled_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_list_unrolled_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_list_unrolled_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_list_unrolled_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_list_unrolled_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_list_unrolled_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_list_unrolled_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}


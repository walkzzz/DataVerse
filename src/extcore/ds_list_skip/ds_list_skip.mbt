///===
/// extcore/ds_list_skip

pub(all) struct DslistskipPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_list_skip_make_point(x : Double, y : Double) -> DslistskipPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_list_skip_make_point3(x : Double, y : Double, z : Double) -> DslistskipPoint {
  { x, y, z, label: 0 }
}

pub fn ds_list_skip_point_x(pt : DslistskipPoint) -> Double { pt.x }

pub fn ds_list_skip_point_y(pt : DslistskipPoint) -> Double { pt.y }

pub fn ds_list_skip_point_z(pt : DslistskipPoint) -> Double { pt.z }

pub fn ds_list_skip_point_label(pt : DslistskipPoint) -> Int { pt.label }

pub fn ds_list_skip_point_dist(a : DslistskipPoint, b : DslistskipPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  ds_list_skip_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ds_list_skip_point_add(a : DslistskipPoint, b : DslistskipPoint) -> DslistskipPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ds_list_skip_point_sub(a : DslistskipPoint, b : DslistskipPoint) -> DslistskipPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ds_list_skip_point_scale(pt : DslistskipPoint, s : Double) -> DslistskipPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ds_list_skip_point_dot(a : DslistskipPoint, b : DslistskipPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ds_list_skip_point_cross(a : DslistskipPoint, b : DslistskipPoint) -> DslistskipPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ds_list_skip_point_norm(pt : DslistskipPoint) -> Double {
  ds_list_skip_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ds_list_skip_point_normalize(pt : DslistskipPoint) -> DslistskipPoint {
  let n = ds_list_skip_point_norm(pt)
  if n < 0.0000001 { pt } else { ds_list_skip_point_scale(pt, 1.0 / n) }
}

pub fn ds_list_skip_point_negate(pt : DslistskipPoint) -> DslistskipPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ds_list_skip_point_mid(a : DslistskipPoint, b : DslistskipPoint) -> DslistskipPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ds_list_skip_point_lerp(a : DslistskipPoint, b : DslistskipPoint, t : Double) -> DslistskipPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ds_list_skip_point_to_string(pt : DslistskipPoint) -> String {
  "(" + ds_list_skip_dbl(pt.x) + ", " + ds_list_skip_dbl(pt.y) + ", " + ds_list_skip_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DslistskipSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_list_skip_make_series(vals : Array[Double], name : String) -> DslistskipSeries {
  { vals, name, meta: 0 }
}

pub fn ds_list_skip_series_len(s : DslistskipSeries) -> Int { s.vals.length() }

pub fn ds_list_skip_series_sum(s : DslistskipSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn ds_list_skip_series_mean(s : DslistskipSeries) -> Double {
  let n = ds_list_skip_series_len(s)
  if n == 0 { 0.0 } else { ds_list_skip_series_sum(s) / n.to_double() }
}

pub fn ds_list_skip_series_min(s : DslistskipSeries) -> Double {
  let n = ds_list_skip_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn ds_list_skip_series_max(s : DslistskipSeries) -> Double {
  let n = ds_list_skip_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn ds_list_skip_series_range(s : DslistskipSeries) -> Double {
  ds_list_skip_series_max(s) - ds_list_skip_series_min(s)
}

pub fn ds_list_skip_series_var(s : DslistskipSeries) -> Double {
  let n = ds_list_skip_series_len(s)
  if n == 0 { 0.0 } else {
    let m = ds_list_skip_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn ds_list_skip_series_std(s : DslistskipSeries) -> Double { ds_list_skip_sqrt(ds_list_skip_series_var(s)) }

pub fn ds_list_skip_series_median(s : DslistskipSeries) -> Double {
  let n = ds_list_skip_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = ds_list_skip_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ds_list_skip_series_scale(s : DslistskipSeries, f : Double) -> DslistskipSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = ds_list_skip_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ds_list_skip_series_add(a : DslistskipSeries, b : DslistskipSeries) -> DslistskipSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = ds_list_skip_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ds_list_skip_series_sub(a : DslistskipSeries, b : DslistskipSeries) -> DslistskipSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = ds_list_skip_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ds_list_skip_series_normalize(s : DslistskipSeries) -> DslistskipSeries {
  let mn = ds_list_skip_series_min(s)
  let mx = ds_list_skip_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = ds_list_skip_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ds_list_skip_series_cumsum(s : DslistskipSeries) -> DslistskipSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = ds_list_skip_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn ds_list_skip_series_to_string(s : DslistskipSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + ds_list_skip_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DslistskipMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_list_skip_make_matrix(rows : Int, cols : Int, val : Double) -> DslistskipMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_list_skip_matrix_identity(n : Int) -> DslistskipMatrix {
  let m = ds_list_skip_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ds_list_skip_matrix_get(m : DslistskipMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ds_list_skip_matrix_transpose(m : DslistskipMatrix) -> DslistskipMatrix {
  let result = ds_list_skip_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ds_list_skip_matrix_add(a : DslistskipMatrix, b : DslistskipMatrix) -> DslistskipMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ds_list_skip_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ds_list_skip_matrix_scale(m : DslistskipMatrix, s : Double) -> DslistskipMatrix {
  let result = ds_list_skip_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ds_list_skip_matrix_multiply(a : DslistskipMatrix, b : DslistskipMatrix) -> DslistskipMatrix {
  if a.cols != b.rows { return ds_list_skip_make_matrix(a.rows, b.cols, 0.0) }
  let result = ds_list_skip_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ds_list_skip_matrix_trace(m : DslistskipMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ds_list_skip_matrix_det(m : DslistskipMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ds_list_skip_matrix_norm(m : DslistskipMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  ds_list_skip_sqrt(sum)
}

pub fn ds_list_skip_matrix_to_string(m : DslistskipMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + ds_list_skip_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct DslistskipVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_list_skip_make_vector(comps : Array[Double]) -> DslistskipVector {
  { comps, dim: comps.length() }
}

pub fn ds_list_skip_vector_zero(dim : Int) -> DslistskipVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ds_list_skip_vector_add(a : DslistskipVector, b : DslistskipVector) -> DslistskipVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = ds_list_skip_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_list_skip_vector_sub(a : DslistskipVector, b : DslistskipVector) -> DslistskipVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = ds_list_skip_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_list_skip_vector_scale(v : DslistskipVector, s : Double) -> DslistskipVector {
  let mut result = []
  for i in 0..<v.dim { result = ds_list_skip_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ds_list_skip_vector_dot(a : DslistskipVector, b : DslistskipVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ds_list_skip_vector_norm(v : DslistskipVector) -> Double { ds_list_skip_sqrt(ds_list_skip_vector_dot(v, v)) }

pub fn ds_list_skip_vector_normalize(v : DslistskipVector) -> DslistskipVector {
  let n = ds_list_skip_vector_norm(v)
  if n < 0.0000001 { v } else { ds_list_skip_vector_scale(v, 1.0 / n) }
}

pub fn ds_list_skip_vector_dist(a : DslistskipVector, b : DslistskipVector) -> Double {
  ds_list_skip_vector_norm(ds_list_skip_vector_sub(a, b))
}

pub fn ds_list_skip_vector_to_string(v : DslistskipVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + ds_list_skip_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_list_skip_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn ds_list_skip_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = ds_list_skip_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ds_list_skip_std(data : Array[Double]) -> Double { ds_list_skip_sqrt(ds_list_skip_var(data)) }

pub fn ds_list_skip_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = ds_list_skip_mean(a); let mb = ds_list_skip_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn ds_list_skip_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = ds_list_skip_std(a); let sb = ds_list_skip_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { ds_list_skip_cov(a, b) / (sa * sb) }
}

pub fn ds_list_skip_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = ds_list_skip_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ds_list_skip_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn ds_list_skip_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ds_list_skip_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  ds_list_skip_sqrt(ds_list_skip_mse(pred, labels))
}

pub fn ds_list_skip_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + ds_list_skip_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn ds_list_skip_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = ds_list_skip_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn ds_list_skip_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn ds_list_skip_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn ds_list_skip_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = ds_list_skip_precision(pred, labels, pos); let r = ds_list_skip_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn ds_list_skip_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn ds_list_skip_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = ds_list_skip_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn ds_list_skip_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn ds_list_skip_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn ds_list_skip_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = ds_list_skip_gcd(a, b)
    (a / g) * b
  }
}

pub fn ds_list_skip_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn ds_list_skip_fibonacci(n : Int) -> Int {
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

pub fn ds_list_skip_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = ds_list_skip_min(data); let mx = ds_list_skip_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn ds_list_skip_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = ds_list_skip_mean(data); let sd = ds_list_skip_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn ds_list_skip_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn ds_list_skip_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn ds_list_skip_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn ds_list_skip_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn ds_list_skip_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn ds_list_skip_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn ds_list_skip_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn ds_list_skip_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn ds_list_skip_dbl(x : Double) -> String {
  let i = if x >= 0.0 { ds_list_skip_int(x) } else { -ds_list_skip_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { ds_list_skip_int(f * 1000000.0) } else { ds_list_skip_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn ds_list_skip_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn ds_list_skip_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct DslistskipFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_skip_frame_make(size : Int) -> DslistskipFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_skip_frame_len(s : DslistskipFrame) -> Int { s.size }

pub fn ds_list_skip_frame_get(s : DslistskipFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_skip_frame_set(s : DslistskipFrame, i : Int, v : Double) -> DslistskipFrame {
  let result = ds_list_skip_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_skip_frame_sum(s : DslistskipFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_skip_frame_mean(s : DslistskipFrame) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_skip_frame_sum(s) / s.size.to_double() }
}

pub fn ds_list_skip_frame_scale(s : DslistskipFrame, f : Double) -> DslistskipFrame {
  let result = ds_list_skip_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_skip_frame_add(a : DslistskipFrame, b : DslistskipFrame) -> DslistskipFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_skip_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_skip_frame_copy(s : DslistskipFrame) -> DslistskipFrame {
  let result = ds_list_skip_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_skip_frame_fill(s : DslistskipFrame, v : Double) -> DslistskipFrame {
  let result = ds_list_skip_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_skip_frame_min(s : DslistskipFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_skip_frame_max(s : DslistskipFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_skip_frame_to_string(s : DslistskipFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistskipTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_skip_table_make(size : Int) -> DslistskipTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_skip_table_len(s : DslistskipTable) -> Int { s.size }

pub fn ds_list_skip_table_get(s : DslistskipTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_skip_table_set(s : DslistskipTable, i : Int, v : Double) -> DslistskipTable {
  let result = ds_list_skip_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_skip_table_sum(s : DslistskipTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_skip_table_mean(s : DslistskipTable) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_skip_table_sum(s) / s.size.to_double() }
}

pub fn ds_list_skip_table_scale(s : DslistskipTable, f : Double) -> DslistskipTable {
  let result = ds_list_skip_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_skip_table_add(a : DslistskipTable, b : DslistskipTable) -> DslistskipTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_skip_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_skip_table_copy(s : DslistskipTable) -> DslistskipTable {
  let result = ds_list_skip_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_skip_table_fill(s : DslistskipTable, v : Double) -> DslistskipTable {
  let result = ds_list_skip_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_skip_table_min(s : DslistskipTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_skip_table_max(s : DslistskipTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_skip_table_to_string(s : DslistskipTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistskipGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_skip_graphn_make(size : Int) -> DslistskipGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_skip_graphn_len(s : DslistskipGraphN) -> Int { s.size }

pub fn ds_list_skip_graphn_get(s : DslistskipGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_skip_graphn_set(s : DslistskipGraphN, i : Int, v : Double) -> DslistskipGraphN {
  let result = ds_list_skip_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_skip_graphn_sum(s : DslistskipGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_skip_graphn_mean(s : DslistskipGraphN) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_skip_graphn_sum(s) / s.size.to_double() }
}

pub fn ds_list_skip_graphn_scale(s : DslistskipGraphN, f : Double) -> DslistskipGraphN {
  let result = ds_list_skip_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_skip_graphn_add(a : DslistskipGraphN, b : DslistskipGraphN) -> DslistskipGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_skip_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_skip_graphn_copy(s : DslistskipGraphN) -> DslistskipGraphN {
  let result = ds_list_skip_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_skip_graphn_fill(s : DslistskipGraphN, v : Double) -> DslistskipGraphN {
  let result = ds_list_skip_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_skip_graphn_min(s : DslistskipGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_skip_graphn_max(s : DslistskipGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_skip_graphn_to_string(s : DslistskipGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistskipNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_skip_node_make(size : Int) -> DslistskipNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_skip_node_len(s : DslistskipNode) -> Int { s.size }

pub fn ds_list_skip_node_get(s : DslistskipNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_skip_node_set(s : DslistskipNode, i : Int, v : Double) -> DslistskipNode {
  let result = ds_list_skip_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_skip_node_sum(s : DslistskipNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_skip_node_mean(s : DslistskipNode) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_skip_node_sum(s) / s.size.to_double() }
}

pub fn ds_list_skip_node_scale(s : DslistskipNode, f : Double) -> DslistskipNode {
  let result = ds_list_skip_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_skip_node_add(a : DslistskipNode, b : DslistskipNode) -> DslistskipNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_skip_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_skip_node_copy(s : DslistskipNode) -> DslistskipNode {
  let result = ds_list_skip_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_skip_node_fill(s : DslistskipNode, v : Double) -> DslistskipNode {
  let result = ds_list_skip_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_skip_node_min(s : DslistskipNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_skip_node_max(s : DslistskipNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_skip_node_to_string(s : DslistskipNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistskipEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_skip_edge_make(size : Int) -> DslistskipEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_skip_edge_len(s : DslistskipEdge) -> Int { s.size }

pub fn ds_list_skip_edge_get(s : DslistskipEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_skip_edge_set(s : DslistskipEdge, i : Int, v : Double) -> DslistskipEdge {
  let result = ds_list_skip_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_skip_edge_sum(s : DslistskipEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_skip_edge_mean(s : DslistskipEdge) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_skip_edge_sum(s) / s.size.to_double() }
}

pub fn ds_list_skip_edge_scale(s : DslistskipEdge, f : Double) -> DslistskipEdge {
  let result = ds_list_skip_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_skip_edge_add(a : DslistskipEdge, b : DslistskipEdge) -> DslistskipEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_skip_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_skip_edge_copy(s : DslistskipEdge) -> DslistskipEdge {
  let result = ds_list_skip_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_skip_edge_fill(s : DslistskipEdge, v : Double) -> DslistskipEdge {
  let result = ds_list_skip_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_skip_edge_min(s : DslistskipEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_skip_edge_max(s : DslistskipEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_skip_edge_to_string(s : DslistskipEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistskipPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_skip_path_make(size : Int) -> DslistskipPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_skip_path_len(s : DslistskipPath) -> Int { s.size }

pub fn ds_list_skip_path_get(s : DslistskipPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_skip_path_set(s : DslistskipPath, i : Int, v : Double) -> DslistskipPath {
  let result = ds_list_skip_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_skip_path_sum(s : DslistskipPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_skip_path_mean(s : DslistskipPath) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_skip_path_sum(s) / s.size.to_double() }
}

pub fn ds_list_skip_path_scale(s : DslistskipPath, f : Double) -> DslistskipPath {
  let result = ds_list_skip_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_skip_path_add(a : DslistskipPath, b : DslistskipPath) -> DslistskipPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_skip_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_skip_path_copy(s : DslistskipPath) -> DslistskipPath {
  let result = ds_list_skip_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_skip_path_fill(s : DslistskipPath, v : Double) -> DslistskipPath {
  let result = ds_list_skip_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_skip_path_min(s : DslistskipPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_skip_path_max(s : DslistskipPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_skip_path_to_string(s : DslistskipPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistskipCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_skip_cluster_make(size : Int) -> DslistskipCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_skip_cluster_len(s : DslistskipCluster) -> Int { s.size }

pub fn ds_list_skip_cluster_get(s : DslistskipCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_skip_cluster_set(s : DslistskipCluster, i : Int, v : Double) -> DslistskipCluster {
  let result = ds_list_skip_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_skip_cluster_sum(s : DslistskipCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_skip_cluster_mean(s : DslistskipCluster) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_skip_cluster_sum(s) / s.size.to_double() }
}

pub fn ds_list_skip_cluster_scale(s : DslistskipCluster, f : Double) -> DslistskipCluster {
  let result = ds_list_skip_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_skip_cluster_add(a : DslistskipCluster, b : DslistskipCluster) -> DslistskipCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_skip_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_skip_cluster_copy(s : DslistskipCluster) -> DslistskipCluster {
  let result = ds_list_skip_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_skip_cluster_fill(s : DslistskipCluster, v : Double) -> DslistskipCluster {
  let result = ds_list_skip_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_skip_cluster_min(s : DslistskipCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_skip_cluster_max(s : DslistskipCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_skip_cluster_to_string(s : DslistskipCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistskipModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_skip_model_make(size : Int) -> DslistskipModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_skip_model_len(s : DslistskipModel) -> Int { s.size }

pub fn ds_list_skip_model_get(s : DslistskipModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_skip_model_set(s : DslistskipModel, i : Int, v : Double) -> DslistskipModel {
  let result = ds_list_skip_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_skip_model_sum(s : DslistskipModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_skip_model_mean(s : DslistskipModel) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_skip_model_sum(s) / s.size.to_double() }
}

pub fn ds_list_skip_model_scale(s : DslistskipModel, f : Double) -> DslistskipModel {
  let result = ds_list_skip_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_skip_model_add(a : DslistskipModel, b : DslistskipModel) -> DslistskipModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_skip_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_skip_model_copy(s : DslistskipModel) -> DslistskipModel {
  let result = ds_list_skip_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_skip_model_fill(s : DslistskipModel, v : Double) -> DslistskipModel {
  let result = ds_list_skip_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_skip_model_min(s : DslistskipModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_skip_model_max(s : DslistskipModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_skip_model_to_string(s : DslistskipModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistskipLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_skip_layer_make(size : Int) -> DslistskipLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_skip_layer_len(s : DslistskipLayer) -> Int { s.size }

pub fn ds_list_skip_layer_get(s : DslistskipLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_skip_layer_set(s : DslistskipLayer, i : Int, v : Double) -> DslistskipLayer {
  let result = ds_list_skip_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_skip_layer_sum(s : DslistskipLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_skip_layer_mean(s : DslistskipLayer) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_skip_layer_sum(s) / s.size.to_double() }
}

pub fn ds_list_skip_layer_scale(s : DslistskipLayer, f : Double) -> DslistskipLayer {
  let result = ds_list_skip_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_skip_layer_add(a : DslistskipLayer, b : DslistskipLayer) -> DslistskipLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_skip_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_skip_layer_copy(s : DslistskipLayer) -> DslistskipLayer {
  let result = ds_list_skip_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_skip_layer_fill(s : DslistskipLayer, v : Double) -> DslistskipLayer {
  let result = ds_list_skip_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_skip_layer_min(s : DslistskipLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_skip_layer_max(s : DslistskipLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_skip_layer_to_string(s : DslistskipLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistskipBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_skip_buffer_make(size : Int) -> DslistskipBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_skip_buffer_len(s : DslistskipBuffer) -> Int { s.size }

pub fn ds_list_skip_buffer_get(s : DslistskipBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_skip_buffer_set(s : DslistskipBuffer, i : Int, v : Double) -> DslistskipBuffer {
  let result = ds_list_skip_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_skip_buffer_sum(s : DslistskipBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_skip_buffer_mean(s : DslistskipBuffer) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_skip_buffer_sum(s) / s.size.to_double() }
}

pub fn ds_list_skip_buffer_scale(s : DslistskipBuffer, f : Double) -> DslistskipBuffer {
  let result = ds_list_skip_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_skip_buffer_add(a : DslistskipBuffer, b : DslistskipBuffer) -> DslistskipBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_skip_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_skip_buffer_copy(s : DslistskipBuffer) -> DslistskipBuffer {
  let result = ds_list_skip_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_skip_buffer_fill(s : DslistskipBuffer, v : Double) -> DslistskipBuffer {
  let result = ds_list_skip_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_skip_buffer_min(s : DslistskipBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_skip_buffer_max(s : DslistskipBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_skip_buffer_to_string(s : DslistskipBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistskipCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_skip_cursor_make(size : Int) -> DslistskipCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_skip_cursor_len(s : DslistskipCursor) -> Int { s.size }

pub fn ds_list_skip_cursor_get(s : DslistskipCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_skip_cursor_set(s : DslistskipCursor, i : Int, v : Double) -> DslistskipCursor {
  let result = ds_list_skip_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_skip_cursor_sum(s : DslistskipCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_skip_cursor_mean(s : DslistskipCursor) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_skip_cursor_sum(s) / s.size.to_double() }
}

pub fn ds_list_skip_cursor_scale(s : DslistskipCursor, f : Double) -> DslistskipCursor {
  let result = ds_list_skip_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_skip_cursor_add(a : DslistskipCursor, b : DslistskipCursor) -> DslistskipCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_skip_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_skip_cursor_copy(s : DslistskipCursor) -> DslistskipCursor {
  let result = ds_list_skip_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_skip_cursor_fill(s : DslistskipCursor, v : Double) -> DslistskipCursor {
  let result = ds_list_skip_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_skip_cursor_min(s : DslistskipCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_skip_cursor_max(s : DslistskipCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_skip_cursor_to_string(s : DslistskipCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistskipView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_skip_view_make(size : Int) -> DslistskipView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_skip_view_len(s : DslistskipView) -> Int { s.size }

pub fn ds_list_skip_view_get(s : DslistskipView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_skip_view_set(s : DslistskipView, i : Int, v : Double) -> DslistskipView {
  let result = ds_list_skip_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_skip_view_sum(s : DslistskipView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_skip_view_mean(s : DslistskipView) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_skip_view_sum(s) / s.size.to_double() }
}

pub fn ds_list_skip_view_scale(s : DslistskipView, f : Double) -> DslistskipView {
  let result = ds_list_skip_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_skip_view_add(a : DslistskipView, b : DslistskipView) -> DslistskipView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_skip_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_skip_view_copy(s : DslistskipView) -> DslistskipView {
  let result = ds_list_skip_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_skip_view_fill(s : DslistskipView, v : Double) -> DslistskipView {
  let result = ds_list_skip_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_skip_view_min(s : DslistskipView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_skip_view_max(s : DslistskipView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_skip_view_to_string(s : DslistskipView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistskipRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_skip_range_make(size : Int) -> DslistskipRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_skip_range_len(s : DslistskipRange) -> Int { s.size }

pub fn ds_list_skip_range_get(s : DslistskipRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_skip_range_set(s : DslistskipRange, i : Int, v : Double) -> DslistskipRange {
  let result = ds_list_skip_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_skip_range_sum(s : DslistskipRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_skip_range_mean(s : DslistskipRange) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_skip_range_sum(s) / s.size.to_double() }
}

pub fn ds_list_skip_range_scale(s : DslistskipRange, f : Double) -> DslistskipRange {
  let result = ds_list_skip_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_skip_range_add(a : DslistskipRange, b : DslistskipRange) -> DslistskipRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_skip_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_skip_range_copy(s : DslistskipRange) -> DslistskipRange {
  let result = ds_list_skip_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_skip_range_fill(s : DslistskipRange, v : Double) -> DslistskipRange {
  let result = ds_list_skip_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_skip_range_min(s : DslistskipRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_skip_range_max(s : DslistskipRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_skip_range_to_string(s : DslistskipRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistskipSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_skip_slice_make(size : Int) -> DslistskipSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_skip_slice_len(s : DslistskipSlice) -> Int { s.size }

pub fn ds_list_skip_slice_get(s : DslistskipSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_skip_slice_set(s : DslistskipSlice, i : Int, v : Double) -> DslistskipSlice {
  let result = ds_list_skip_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_skip_slice_sum(s : DslistskipSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_skip_slice_mean(s : DslistskipSlice) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_skip_slice_sum(s) / s.size.to_double() }
}

pub fn ds_list_skip_slice_scale(s : DslistskipSlice, f : Double) -> DslistskipSlice {
  let result = ds_list_skip_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_skip_slice_add(a : DslistskipSlice, b : DslistskipSlice) -> DslistskipSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_skip_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_skip_slice_copy(s : DslistskipSlice) -> DslistskipSlice {
  let result = ds_list_skip_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_skip_slice_fill(s : DslistskipSlice, v : Double) -> DslistskipSlice {
  let result = ds_list_skip_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_skip_slice_min(s : DslistskipSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_skip_slice_max(s : DslistskipSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_skip_slice_to_string(s : DslistskipSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn ds_list_skip_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_list_skip_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_list_skip_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_list_skip_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_list_skip_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_list_skip_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_list_skip_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_list_skip_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_list_skip_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_list_skip_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_list_skip_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_list_skip_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_list_skip_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_list_skip_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_list_skip_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_list_skip_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_list_skip_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_list_skip_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_list_skip_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_list_skip_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_list_skip_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_list_skip_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_list_skip_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_list_skip_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_list_skip_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}


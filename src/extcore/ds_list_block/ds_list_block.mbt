///===
/// extcore/ds_list_block

pub(all) struct DslistblockPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_list_block_make_point(x : Double, y : Double) -> DslistblockPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_list_block_make_point3(x : Double, y : Double, z : Double) -> DslistblockPoint {
  { x, y, z, label: 0 }
}

pub fn ds_list_block_point_x(pt : DslistblockPoint) -> Double { pt.x }

pub fn ds_list_block_point_y(pt : DslistblockPoint) -> Double { pt.y }

pub fn ds_list_block_point_z(pt : DslistblockPoint) -> Double { pt.z }

pub fn ds_list_block_point_label(pt : DslistblockPoint) -> Int { pt.label }

pub fn ds_list_block_point_dist(a : DslistblockPoint, b : DslistblockPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  ds_list_block_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ds_list_block_point_add(a : DslistblockPoint, b : DslistblockPoint) -> DslistblockPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ds_list_block_point_sub(a : DslistblockPoint, b : DslistblockPoint) -> DslistblockPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ds_list_block_point_scale(pt : DslistblockPoint, s : Double) -> DslistblockPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ds_list_block_point_dot(a : DslistblockPoint, b : DslistblockPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ds_list_block_point_cross(a : DslistblockPoint, b : DslistblockPoint) -> DslistblockPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ds_list_block_point_norm(pt : DslistblockPoint) -> Double {
  ds_list_block_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ds_list_block_point_normalize(pt : DslistblockPoint) -> DslistblockPoint {
  let n = ds_list_block_point_norm(pt)
  if n < 0.0000001 { pt } else { ds_list_block_point_scale(pt, 1.0 / n) }
}

pub fn ds_list_block_point_negate(pt : DslistblockPoint) -> DslistblockPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ds_list_block_point_mid(a : DslistblockPoint, b : DslistblockPoint) -> DslistblockPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ds_list_block_point_lerp(a : DslistblockPoint, b : DslistblockPoint, t : Double) -> DslistblockPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ds_list_block_point_to_string(pt : DslistblockPoint) -> String {
  "(" + ds_list_block_dbl(pt.x) + ", " + ds_list_block_dbl(pt.y) + ", " + ds_list_block_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DslistblockSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_list_block_make_series(vals : Array[Double], name : String) -> DslistblockSeries {
  { vals, name, meta: 0 }
}

pub fn ds_list_block_series_len(s : DslistblockSeries) -> Int { s.vals.length() }

pub fn ds_list_block_series_sum(s : DslistblockSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn ds_list_block_series_mean(s : DslistblockSeries) -> Double {
  let n = ds_list_block_series_len(s)
  if n == 0 { 0.0 } else { ds_list_block_series_sum(s) / n.to_double() }
}

pub fn ds_list_block_series_min(s : DslistblockSeries) -> Double {
  let n = ds_list_block_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn ds_list_block_series_max(s : DslistblockSeries) -> Double {
  let n = ds_list_block_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn ds_list_block_series_range(s : DslistblockSeries) -> Double {
  ds_list_block_series_max(s) - ds_list_block_series_min(s)
}

pub fn ds_list_block_series_var(s : DslistblockSeries) -> Double {
  let n = ds_list_block_series_len(s)
  if n == 0 { 0.0 } else {
    let m = ds_list_block_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn ds_list_block_series_std(s : DslistblockSeries) -> Double { ds_list_block_sqrt(ds_list_block_series_var(s)) }

pub fn ds_list_block_series_median(s : DslistblockSeries) -> Double {
  let n = ds_list_block_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = ds_list_block_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ds_list_block_series_scale(s : DslistblockSeries, f : Double) -> DslistblockSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = ds_list_block_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ds_list_block_series_add(a : DslistblockSeries, b : DslistblockSeries) -> DslistblockSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = ds_list_block_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ds_list_block_series_sub(a : DslistblockSeries, b : DslistblockSeries) -> DslistblockSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = ds_list_block_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ds_list_block_series_normalize(s : DslistblockSeries) -> DslistblockSeries {
  let mn = ds_list_block_series_min(s)
  let mx = ds_list_block_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = ds_list_block_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ds_list_block_series_cumsum(s : DslistblockSeries) -> DslistblockSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = ds_list_block_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn ds_list_block_series_to_string(s : DslistblockSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + ds_list_block_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DslistblockMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_list_block_make_matrix(rows : Int, cols : Int, val : Double) -> DslistblockMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_list_block_matrix_identity(n : Int) -> DslistblockMatrix {
  let m = ds_list_block_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ds_list_block_matrix_get(m : DslistblockMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ds_list_block_matrix_transpose(m : DslistblockMatrix) -> DslistblockMatrix {
  let result = ds_list_block_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ds_list_block_matrix_add(a : DslistblockMatrix, b : DslistblockMatrix) -> DslistblockMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ds_list_block_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ds_list_block_matrix_scale(m : DslistblockMatrix, s : Double) -> DslistblockMatrix {
  let result = ds_list_block_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ds_list_block_matrix_multiply(a : DslistblockMatrix, b : DslistblockMatrix) -> DslistblockMatrix {
  if a.cols != b.rows { return ds_list_block_make_matrix(a.rows, b.cols, 0.0) }
  let result = ds_list_block_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ds_list_block_matrix_trace(m : DslistblockMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ds_list_block_matrix_det(m : DslistblockMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ds_list_block_matrix_norm(m : DslistblockMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  ds_list_block_sqrt(sum)
}

pub fn ds_list_block_matrix_to_string(m : DslistblockMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + ds_list_block_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct DslistblockVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_list_block_make_vector(comps : Array[Double]) -> DslistblockVector {
  { comps, dim: comps.length() }
}

pub fn ds_list_block_vector_zero(dim : Int) -> DslistblockVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ds_list_block_vector_add(a : DslistblockVector, b : DslistblockVector) -> DslistblockVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = ds_list_block_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_list_block_vector_sub(a : DslistblockVector, b : DslistblockVector) -> DslistblockVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = ds_list_block_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_list_block_vector_scale(v : DslistblockVector, s : Double) -> DslistblockVector {
  let mut result = []
  for i in 0..<v.dim { result = ds_list_block_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ds_list_block_vector_dot(a : DslistblockVector, b : DslistblockVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ds_list_block_vector_norm(v : DslistblockVector) -> Double { ds_list_block_sqrt(ds_list_block_vector_dot(v, v)) }

pub fn ds_list_block_vector_normalize(v : DslistblockVector) -> DslistblockVector {
  let n = ds_list_block_vector_norm(v)
  if n < 0.0000001 { v } else { ds_list_block_vector_scale(v, 1.0 / n) }
}

pub fn ds_list_block_vector_dist(a : DslistblockVector, b : DslistblockVector) -> Double {
  ds_list_block_vector_norm(ds_list_block_vector_sub(a, b))
}

pub fn ds_list_block_vector_to_string(v : DslistblockVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + ds_list_block_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_list_block_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn ds_list_block_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = ds_list_block_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ds_list_block_std(data : Array[Double]) -> Double { ds_list_block_sqrt(ds_list_block_var(data)) }

pub fn ds_list_block_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = ds_list_block_mean(a); let mb = ds_list_block_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn ds_list_block_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = ds_list_block_std(a); let sb = ds_list_block_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { ds_list_block_cov(a, b) / (sa * sb) }
}

pub fn ds_list_block_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = ds_list_block_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ds_list_block_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn ds_list_block_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ds_list_block_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  ds_list_block_sqrt(ds_list_block_mse(pred, labels))
}

pub fn ds_list_block_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + ds_list_block_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn ds_list_block_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = ds_list_block_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn ds_list_block_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn ds_list_block_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn ds_list_block_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = ds_list_block_precision(pred, labels, pos); let r = ds_list_block_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn ds_list_block_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn ds_list_block_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = ds_list_block_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn ds_list_block_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn ds_list_block_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn ds_list_block_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = ds_list_block_gcd(a, b)
    (a / g) * b
  }
}

pub fn ds_list_block_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn ds_list_block_fibonacci(n : Int) -> Int {
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

pub fn ds_list_block_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = ds_list_block_min(data); let mx = ds_list_block_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn ds_list_block_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = ds_list_block_mean(data); let sd = ds_list_block_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn ds_list_block_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn ds_list_block_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn ds_list_block_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn ds_list_block_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn ds_list_block_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn ds_list_block_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn ds_list_block_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn ds_list_block_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn ds_list_block_dbl(x : Double) -> String {
  let i = if x >= 0.0 { ds_list_block_int(x) } else { -ds_list_block_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { ds_list_block_int(f * 1000000.0) } else { ds_list_block_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn ds_list_block_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn ds_list_block_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct DslistblockFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_block_frame_make(size : Int) -> DslistblockFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_block_frame_len(s : DslistblockFrame) -> Int { s.size }

pub fn ds_list_block_frame_get(s : DslistblockFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_block_frame_set(s : DslistblockFrame, i : Int, v : Double) -> DslistblockFrame {
  let result = ds_list_block_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_block_frame_sum(s : DslistblockFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_block_frame_mean(s : DslistblockFrame) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_block_frame_sum(s) / s.size.to_double() }
}

pub fn ds_list_block_frame_scale(s : DslistblockFrame, f : Double) -> DslistblockFrame {
  let result = ds_list_block_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_block_frame_add(a : DslistblockFrame, b : DslistblockFrame) -> DslistblockFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_block_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_block_frame_copy(s : DslistblockFrame) -> DslistblockFrame {
  let result = ds_list_block_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_block_frame_fill(s : DslistblockFrame, v : Double) -> DslistblockFrame {
  let result = ds_list_block_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_block_frame_min(s : DslistblockFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_block_frame_max(s : DslistblockFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_block_frame_to_string(s : DslistblockFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistblockTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_block_table_make(size : Int) -> DslistblockTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_block_table_len(s : DslistblockTable) -> Int { s.size }

pub fn ds_list_block_table_get(s : DslistblockTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_block_table_set(s : DslistblockTable, i : Int, v : Double) -> DslistblockTable {
  let result = ds_list_block_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_block_table_sum(s : DslistblockTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_block_table_mean(s : DslistblockTable) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_block_table_sum(s) / s.size.to_double() }
}

pub fn ds_list_block_table_scale(s : DslistblockTable, f : Double) -> DslistblockTable {
  let result = ds_list_block_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_block_table_add(a : DslistblockTable, b : DslistblockTable) -> DslistblockTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_block_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_block_table_copy(s : DslistblockTable) -> DslistblockTable {
  let result = ds_list_block_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_block_table_fill(s : DslistblockTable, v : Double) -> DslistblockTable {
  let result = ds_list_block_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_block_table_min(s : DslistblockTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_block_table_max(s : DslistblockTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_block_table_to_string(s : DslistblockTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistblockGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_block_graphn_make(size : Int) -> DslistblockGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_block_graphn_len(s : DslistblockGraphN) -> Int { s.size }

pub fn ds_list_block_graphn_get(s : DslistblockGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_block_graphn_set(s : DslistblockGraphN, i : Int, v : Double) -> DslistblockGraphN {
  let result = ds_list_block_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_block_graphn_sum(s : DslistblockGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_block_graphn_mean(s : DslistblockGraphN) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_block_graphn_sum(s) / s.size.to_double() }
}

pub fn ds_list_block_graphn_scale(s : DslistblockGraphN, f : Double) -> DslistblockGraphN {
  let result = ds_list_block_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_block_graphn_add(a : DslistblockGraphN, b : DslistblockGraphN) -> DslistblockGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_block_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_block_graphn_copy(s : DslistblockGraphN) -> DslistblockGraphN {
  let result = ds_list_block_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_block_graphn_fill(s : DslistblockGraphN, v : Double) -> DslistblockGraphN {
  let result = ds_list_block_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_block_graphn_min(s : DslistblockGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_block_graphn_max(s : DslistblockGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_block_graphn_to_string(s : DslistblockGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistblockNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_block_node_make(size : Int) -> DslistblockNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_block_node_len(s : DslistblockNode) -> Int { s.size }

pub fn ds_list_block_node_get(s : DslistblockNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_block_node_set(s : DslistblockNode, i : Int, v : Double) -> DslistblockNode {
  let result = ds_list_block_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_block_node_sum(s : DslistblockNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_block_node_mean(s : DslistblockNode) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_block_node_sum(s) / s.size.to_double() }
}

pub fn ds_list_block_node_scale(s : DslistblockNode, f : Double) -> DslistblockNode {
  let result = ds_list_block_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_block_node_add(a : DslistblockNode, b : DslistblockNode) -> DslistblockNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_block_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_block_node_copy(s : DslistblockNode) -> DslistblockNode {
  let result = ds_list_block_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_block_node_fill(s : DslistblockNode, v : Double) -> DslistblockNode {
  let result = ds_list_block_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_block_node_min(s : DslistblockNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_block_node_max(s : DslistblockNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_block_node_to_string(s : DslistblockNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistblockEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_block_edge_make(size : Int) -> DslistblockEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_block_edge_len(s : DslistblockEdge) -> Int { s.size }

pub fn ds_list_block_edge_get(s : DslistblockEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_block_edge_set(s : DslistblockEdge, i : Int, v : Double) -> DslistblockEdge {
  let result = ds_list_block_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_block_edge_sum(s : DslistblockEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_block_edge_mean(s : DslistblockEdge) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_block_edge_sum(s) / s.size.to_double() }
}

pub fn ds_list_block_edge_scale(s : DslistblockEdge, f : Double) -> DslistblockEdge {
  let result = ds_list_block_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_block_edge_add(a : DslistblockEdge, b : DslistblockEdge) -> DslistblockEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_block_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_block_edge_copy(s : DslistblockEdge) -> DslistblockEdge {
  let result = ds_list_block_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_block_edge_fill(s : DslistblockEdge, v : Double) -> DslistblockEdge {
  let result = ds_list_block_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_block_edge_min(s : DslistblockEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_block_edge_max(s : DslistblockEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_block_edge_to_string(s : DslistblockEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistblockPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_block_path_make(size : Int) -> DslistblockPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_block_path_len(s : DslistblockPath) -> Int { s.size }

pub fn ds_list_block_path_get(s : DslistblockPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_block_path_set(s : DslistblockPath, i : Int, v : Double) -> DslistblockPath {
  let result = ds_list_block_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_block_path_sum(s : DslistblockPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_block_path_mean(s : DslistblockPath) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_block_path_sum(s) / s.size.to_double() }
}

pub fn ds_list_block_path_scale(s : DslistblockPath, f : Double) -> DslistblockPath {
  let result = ds_list_block_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_block_path_add(a : DslistblockPath, b : DslistblockPath) -> DslistblockPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_block_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_block_path_copy(s : DslistblockPath) -> DslistblockPath {
  let result = ds_list_block_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_block_path_fill(s : DslistblockPath, v : Double) -> DslistblockPath {
  let result = ds_list_block_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_block_path_min(s : DslistblockPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_block_path_max(s : DslistblockPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_block_path_to_string(s : DslistblockPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistblockCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_block_cluster_make(size : Int) -> DslistblockCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_block_cluster_len(s : DslistblockCluster) -> Int { s.size }

pub fn ds_list_block_cluster_get(s : DslistblockCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_block_cluster_set(s : DslistblockCluster, i : Int, v : Double) -> DslistblockCluster {
  let result = ds_list_block_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_block_cluster_sum(s : DslistblockCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_block_cluster_mean(s : DslistblockCluster) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_block_cluster_sum(s) / s.size.to_double() }
}

pub fn ds_list_block_cluster_scale(s : DslistblockCluster, f : Double) -> DslistblockCluster {
  let result = ds_list_block_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_block_cluster_add(a : DslistblockCluster, b : DslistblockCluster) -> DslistblockCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_block_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_block_cluster_copy(s : DslistblockCluster) -> DslistblockCluster {
  let result = ds_list_block_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_block_cluster_fill(s : DslistblockCluster, v : Double) -> DslistblockCluster {
  let result = ds_list_block_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_block_cluster_min(s : DslistblockCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_block_cluster_max(s : DslistblockCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_block_cluster_to_string(s : DslistblockCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistblockModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_block_model_make(size : Int) -> DslistblockModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_block_model_len(s : DslistblockModel) -> Int { s.size }

pub fn ds_list_block_model_get(s : DslistblockModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_block_model_set(s : DslistblockModel, i : Int, v : Double) -> DslistblockModel {
  let result = ds_list_block_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_block_model_sum(s : DslistblockModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_block_model_mean(s : DslistblockModel) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_block_model_sum(s) / s.size.to_double() }
}

pub fn ds_list_block_model_scale(s : DslistblockModel, f : Double) -> DslistblockModel {
  let result = ds_list_block_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_block_model_add(a : DslistblockModel, b : DslistblockModel) -> DslistblockModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_block_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_block_model_copy(s : DslistblockModel) -> DslistblockModel {
  let result = ds_list_block_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_block_model_fill(s : DslistblockModel, v : Double) -> DslistblockModel {
  let result = ds_list_block_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_block_model_min(s : DslistblockModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_block_model_max(s : DslistblockModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_block_model_to_string(s : DslistblockModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistblockLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_block_layer_make(size : Int) -> DslistblockLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_block_layer_len(s : DslistblockLayer) -> Int { s.size }

pub fn ds_list_block_layer_get(s : DslistblockLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_block_layer_set(s : DslistblockLayer, i : Int, v : Double) -> DslistblockLayer {
  let result = ds_list_block_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_block_layer_sum(s : DslistblockLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_block_layer_mean(s : DslistblockLayer) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_block_layer_sum(s) / s.size.to_double() }
}

pub fn ds_list_block_layer_scale(s : DslistblockLayer, f : Double) -> DslistblockLayer {
  let result = ds_list_block_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_block_layer_add(a : DslistblockLayer, b : DslistblockLayer) -> DslistblockLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_block_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_block_layer_copy(s : DslistblockLayer) -> DslistblockLayer {
  let result = ds_list_block_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_block_layer_fill(s : DslistblockLayer, v : Double) -> DslistblockLayer {
  let result = ds_list_block_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_block_layer_min(s : DslistblockLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_block_layer_max(s : DslistblockLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_block_layer_to_string(s : DslistblockLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistblockBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_block_buffer_make(size : Int) -> DslistblockBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_block_buffer_len(s : DslistblockBuffer) -> Int { s.size }

pub fn ds_list_block_buffer_get(s : DslistblockBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_block_buffer_set(s : DslistblockBuffer, i : Int, v : Double) -> DslistblockBuffer {
  let result = ds_list_block_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_block_buffer_sum(s : DslistblockBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_block_buffer_mean(s : DslistblockBuffer) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_block_buffer_sum(s) / s.size.to_double() }
}

pub fn ds_list_block_buffer_scale(s : DslistblockBuffer, f : Double) -> DslistblockBuffer {
  let result = ds_list_block_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_block_buffer_add(a : DslistblockBuffer, b : DslistblockBuffer) -> DslistblockBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_block_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_block_buffer_copy(s : DslistblockBuffer) -> DslistblockBuffer {
  let result = ds_list_block_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_block_buffer_fill(s : DslistblockBuffer, v : Double) -> DslistblockBuffer {
  let result = ds_list_block_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_block_buffer_min(s : DslistblockBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_block_buffer_max(s : DslistblockBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_block_buffer_to_string(s : DslistblockBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistblockCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_block_cursor_make(size : Int) -> DslistblockCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_block_cursor_len(s : DslistblockCursor) -> Int { s.size }

pub fn ds_list_block_cursor_get(s : DslistblockCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_block_cursor_set(s : DslistblockCursor, i : Int, v : Double) -> DslistblockCursor {
  let result = ds_list_block_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_block_cursor_sum(s : DslistblockCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_block_cursor_mean(s : DslistblockCursor) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_block_cursor_sum(s) / s.size.to_double() }
}

pub fn ds_list_block_cursor_scale(s : DslistblockCursor, f : Double) -> DslistblockCursor {
  let result = ds_list_block_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_block_cursor_add(a : DslistblockCursor, b : DslistblockCursor) -> DslistblockCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_block_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_block_cursor_copy(s : DslistblockCursor) -> DslistblockCursor {
  let result = ds_list_block_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_block_cursor_fill(s : DslistblockCursor, v : Double) -> DslistblockCursor {
  let result = ds_list_block_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_block_cursor_min(s : DslistblockCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_block_cursor_max(s : DslistblockCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_block_cursor_to_string(s : DslistblockCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistblockView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_block_view_make(size : Int) -> DslistblockView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_block_view_len(s : DslistblockView) -> Int { s.size }

pub fn ds_list_block_view_get(s : DslistblockView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_block_view_set(s : DslistblockView, i : Int, v : Double) -> DslistblockView {
  let result = ds_list_block_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_block_view_sum(s : DslistblockView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_block_view_mean(s : DslistblockView) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_block_view_sum(s) / s.size.to_double() }
}

pub fn ds_list_block_view_scale(s : DslistblockView, f : Double) -> DslistblockView {
  let result = ds_list_block_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_block_view_add(a : DslistblockView, b : DslistblockView) -> DslistblockView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_block_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_block_view_copy(s : DslistblockView) -> DslistblockView {
  let result = ds_list_block_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_block_view_fill(s : DslistblockView, v : Double) -> DslistblockView {
  let result = ds_list_block_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_block_view_min(s : DslistblockView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_block_view_max(s : DslistblockView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_block_view_to_string(s : DslistblockView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistblockRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_block_range_make(size : Int) -> DslistblockRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_block_range_len(s : DslistblockRange) -> Int { s.size }

pub fn ds_list_block_range_get(s : DslistblockRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_block_range_set(s : DslistblockRange, i : Int, v : Double) -> DslistblockRange {
  let result = ds_list_block_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_block_range_sum(s : DslistblockRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_block_range_mean(s : DslistblockRange) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_block_range_sum(s) / s.size.to_double() }
}

pub fn ds_list_block_range_scale(s : DslistblockRange, f : Double) -> DslistblockRange {
  let result = ds_list_block_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_block_range_add(a : DslistblockRange, b : DslistblockRange) -> DslistblockRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_block_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_block_range_copy(s : DslistblockRange) -> DslistblockRange {
  let result = ds_list_block_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_block_range_fill(s : DslistblockRange, v : Double) -> DslistblockRange {
  let result = ds_list_block_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_block_range_min(s : DslistblockRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_block_range_max(s : DslistblockRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_block_range_to_string(s : DslistblockRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistblockSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_block_slice_make(size : Int) -> DslistblockSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_block_slice_len(s : DslistblockSlice) -> Int { s.size }

pub fn ds_list_block_slice_get(s : DslistblockSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_block_slice_set(s : DslistblockSlice, i : Int, v : Double) -> DslistblockSlice {
  let result = ds_list_block_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_block_slice_sum(s : DslistblockSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_block_slice_mean(s : DslistblockSlice) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_block_slice_sum(s) / s.size.to_double() }
}

pub fn ds_list_block_slice_scale(s : DslistblockSlice, f : Double) -> DslistblockSlice {
  let result = ds_list_block_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_block_slice_add(a : DslistblockSlice, b : DslistblockSlice) -> DslistblockSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_block_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_block_slice_copy(s : DslistblockSlice) -> DslistblockSlice {
  let result = ds_list_block_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_block_slice_fill(s : DslistblockSlice, v : Double) -> DslistblockSlice {
  let result = ds_list_block_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_block_slice_min(s : DslistblockSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_block_slice_max(s : DslistblockSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_block_slice_to_string(s : DslistblockSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn ds_list_block_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_list_block_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_list_block_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_list_block_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_list_block_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_list_block_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_list_block_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_list_block_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_list_block_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_list_block_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_list_block_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_list_block_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_list_block_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_list_block_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_list_block_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_list_block_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_list_block_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_list_block_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_list_block_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_list_block_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_list_block_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_list_block_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_list_block_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_list_block_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_list_block_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}


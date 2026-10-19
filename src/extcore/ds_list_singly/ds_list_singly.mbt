///===
/// extcore/ds_list_singly

pub(all) struct DslistsinglyPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_list_singly_make_point(x : Double, y : Double) -> DslistsinglyPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_list_singly_make_point3(x : Double, y : Double, z : Double) -> DslistsinglyPoint {
  { x, y, z, label: 0 }
}

pub fn ds_list_singly_point_x(pt : DslistsinglyPoint) -> Double { pt.x }

pub fn ds_list_singly_point_y(pt : DslistsinglyPoint) -> Double { pt.y }

pub fn ds_list_singly_point_z(pt : DslistsinglyPoint) -> Double { pt.z }

pub fn ds_list_singly_point_label(pt : DslistsinglyPoint) -> Int { pt.label }

pub fn ds_list_singly_point_dist(a : DslistsinglyPoint, b : DslistsinglyPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ds_list_singly_point_add(a : DslistsinglyPoint, b : DslistsinglyPoint) -> DslistsinglyPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ds_list_singly_point_sub(a : DslistsinglyPoint, b : DslistsinglyPoint) -> DslistsinglyPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ds_list_singly_point_scale(pt : DslistsinglyPoint, s : Double) -> DslistsinglyPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ds_list_singly_point_dot(a : DslistsinglyPoint, b : DslistsinglyPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ds_list_singly_point_cross(a : DslistsinglyPoint, b : DslistsinglyPoint) -> DslistsinglyPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ds_list_singly_point_norm(pt : DslistsinglyPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ds_list_singly_point_normalize(pt : DslistsinglyPoint) -> DslistsinglyPoint {
  let n = ds_list_singly_point_norm(pt)
  if n < 0.0000001 { pt } else { ds_list_singly_point_scale(pt, 1.0 / n) }
}

pub fn ds_list_singly_point_negate(pt : DslistsinglyPoint) -> DslistsinglyPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ds_list_singly_point_mid(a : DslistsinglyPoint, b : DslistsinglyPoint) -> DslistsinglyPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ds_list_singly_point_lerp(a : DslistsinglyPoint, b : DslistsinglyPoint, t : Double) -> DslistsinglyPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ds_list_singly_point_to_string(pt : DslistsinglyPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DslistsinglySeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_list_singly_make_series(vals : Array[Double], name : String) -> DslistsinglySeries {
  { vals, name, meta: 0 }
}

pub fn ds_list_singly_series_len(s : DslistsinglySeries) -> Int { s.vals.length() }

pub fn ds_list_singly_series_sum(s : DslistsinglySeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn ds_list_singly_series_mean(s : DslistsinglySeries) -> Double {
  let n = ds_list_singly_series_len(s)
  if n == 0 { 0.0 } else { ds_list_singly_series_sum(s) / n.to_double() }
}

pub fn ds_list_singly_series_min(s : DslistsinglySeries) -> Double {
  let n = ds_list_singly_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn ds_list_singly_series_max(s : DslistsinglySeries) -> Double {
  let n = ds_list_singly_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn ds_list_singly_series_range(s : DslistsinglySeries) -> Double {
  ds_list_singly_series_max(s) - ds_list_singly_series_min(s)
}

pub fn ds_list_singly_series_var(s : DslistsinglySeries) -> Double {
  let n = ds_list_singly_series_len(s)
  if n == 0 { 0.0 } else {
    let m = ds_list_singly_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn ds_list_singly_series_std(s : DslistsinglySeries) -> Double { @_common.sqrt(ds_list_singly_series_var(s)) }

pub fn ds_list_singly_series_median(s : DslistsinglySeries) -> Double {
  let n = ds_list_singly_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = ds_list_singly_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ds_list_singly_series_scale(s : DslistsinglySeries, f : Double) -> DslistsinglySeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ds_list_singly_series_add(a : DslistsinglySeries, b : DslistsinglySeries) -> DslistsinglySeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ds_list_singly_series_sub(a : DslistsinglySeries, b : DslistsinglySeries) -> DslistsinglySeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ds_list_singly_series_normalize(s : DslistsinglySeries) -> DslistsinglySeries {
  let mn = ds_list_singly_series_min(s)
  let mx = ds_list_singly_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ds_list_singly_series_cumsum(s : DslistsinglySeries) -> DslistsinglySeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn ds_list_singly_series_to_string(s : DslistsinglySeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DslistsinglyMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_list_singly_make_matrix(rows : Int, cols : Int, val : Double) -> DslistsinglyMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_list_singly_matrix_identity(n : Int) -> DslistsinglyMatrix {
  let m = ds_list_singly_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ds_list_singly_matrix_get(m : DslistsinglyMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ds_list_singly_matrix_transpose(m : DslistsinglyMatrix) -> DslistsinglyMatrix {
  let result = ds_list_singly_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ds_list_singly_matrix_add(a : DslistsinglyMatrix, b : DslistsinglyMatrix) -> DslistsinglyMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ds_list_singly_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ds_list_singly_matrix_scale(m : DslistsinglyMatrix, s : Double) -> DslistsinglyMatrix {
  let result = ds_list_singly_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ds_list_singly_matrix_multiply(a : DslistsinglyMatrix, b : DslistsinglyMatrix) -> DslistsinglyMatrix {
  if a.cols != b.rows { return ds_list_singly_make_matrix(a.rows, b.cols, 0.0) }
  let result = ds_list_singly_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ds_list_singly_matrix_trace(m : DslistsinglyMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ds_list_singly_matrix_det(m : DslistsinglyMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ds_list_singly_matrix_norm(m : DslistsinglyMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ds_list_singly_matrix_to_string(m : DslistsinglyMatrix) -> String {
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

pub(all) struct DslistsinglyVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_list_singly_make_vector(comps : Array[Double]) -> DslistsinglyVector {
  { comps, dim: comps.length() }
}

pub fn ds_list_singly_vector_zero(dim : Int) -> DslistsinglyVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ds_list_singly_vector_add(a : DslistsinglyVector, b : DslistsinglyVector) -> DslistsinglyVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_list_singly_vector_sub(a : DslistsinglyVector, b : DslistsinglyVector) -> DslistsinglyVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_list_singly_vector_scale(v : DslistsinglyVector, s : Double) -> DslistsinglyVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ds_list_singly_vector_dot(a : DslistsinglyVector, b : DslistsinglyVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ds_list_singly_vector_norm(v : DslistsinglyVector) -> Double { @_common.sqrt(ds_list_singly_vector_dot(v, v)) }

pub fn ds_list_singly_vector_normalize(v : DslistsinglyVector) -> DslistsinglyVector {
  let n = ds_list_singly_vector_norm(v)
  if n < 0.0000001 { v } else { ds_list_singly_vector_scale(v, 1.0 / n) }
}

pub fn ds_list_singly_vector_dist(a : DslistsinglyVector, b : DslistsinglyVector) -> Double {
  ds_list_singly_vector_norm(ds_list_singly_vector_sub(a, b))
}

pub fn ds_list_singly_vector_to_string(v : DslistsinglyVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_list_singly_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn ds_list_singly_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = ds_list_singly_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ds_list_singly_std(data : Array[Double]) -> Double { @_common.sqrt(ds_list_singly_var(data)) }

pub fn ds_list_singly_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = ds_list_singly_mean(a); let mb = ds_list_singly_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn ds_list_singly_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = ds_list_singly_std(a); let sb = ds_list_singly_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { ds_list_singly_cov(a, b) / (sa * sb) }
}

pub fn ds_list_singly_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = ds_list_singly_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ds_list_singly_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn ds_list_singly_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ds_list_singly_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(ds_list_singly_mse(pred, labels))
}

pub fn ds_list_singly_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn ds_list_singly_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = ds_list_singly_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn ds_list_singly_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn ds_list_singly_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn ds_list_singly_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = ds_list_singly_precision(pred, labels, pos); let r = ds_list_singly_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn ds_list_singly_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn ds_list_singly_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = ds_list_singly_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn ds_list_singly_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn ds_list_singly_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn ds_list_singly_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = ds_list_singly_gcd(a, b)
    (a / g) * b
  }
}

pub fn ds_list_singly_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn ds_list_singly_fibonacci(n : Int) -> Int {
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

pub fn ds_list_singly_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = ds_list_singly_min(data); let mx = ds_list_singly_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn ds_list_singly_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = ds_list_singly_mean(data); let sd = ds_list_singly_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn ds_list_singly_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn ds_list_singly_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn ds_list_singly_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn ds_list_singly_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn ds_list_singly_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn ds_list_singly_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct DslistsinglyFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_singly_frame_make(size : Int) -> DslistsinglyFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_singly_frame_len(s : DslistsinglyFrame) -> Int { s.size }

pub fn ds_list_singly_frame_get(s : DslistsinglyFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_singly_frame_set(s : DslistsinglyFrame, i : Int, v : Double) -> DslistsinglyFrame {
  let result = ds_list_singly_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_singly_frame_sum(s : DslistsinglyFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_singly_frame_mean(s : DslistsinglyFrame) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_singly_frame_sum(s) / s.size.to_double() }
}

pub fn ds_list_singly_frame_scale(s : DslistsinglyFrame, f : Double) -> DslistsinglyFrame {
  let result = ds_list_singly_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_singly_frame_add(a : DslistsinglyFrame, b : DslistsinglyFrame) -> DslistsinglyFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_singly_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_singly_frame_copy(s : DslistsinglyFrame) -> DslistsinglyFrame {
  let result = ds_list_singly_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_singly_frame_fill(s : DslistsinglyFrame, v : Double) -> DslistsinglyFrame {
  let result = ds_list_singly_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_singly_frame_min(s : DslistsinglyFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_singly_frame_max(s : DslistsinglyFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_singly_frame_to_string(s : DslistsinglyFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistsinglyTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_singly_table_make(size : Int) -> DslistsinglyTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_singly_table_len(s : DslistsinglyTable) -> Int { s.size }

pub fn ds_list_singly_table_get(s : DslistsinglyTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_singly_table_set(s : DslistsinglyTable, i : Int, v : Double) -> DslistsinglyTable {
  let result = ds_list_singly_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_singly_table_sum(s : DslistsinglyTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_singly_table_mean(s : DslistsinglyTable) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_singly_table_sum(s) / s.size.to_double() }
}

pub fn ds_list_singly_table_scale(s : DslistsinglyTable, f : Double) -> DslistsinglyTable {
  let result = ds_list_singly_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_singly_table_add(a : DslistsinglyTable, b : DslistsinglyTable) -> DslistsinglyTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_singly_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_singly_table_copy(s : DslistsinglyTable) -> DslistsinglyTable {
  let result = ds_list_singly_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_singly_table_fill(s : DslistsinglyTable, v : Double) -> DslistsinglyTable {
  let result = ds_list_singly_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_singly_table_min(s : DslistsinglyTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_singly_table_max(s : DslistsinglyTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_singly_table_to_string(s : DslistsinglyTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistsinglyGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_singly_graphn_make(size : Int) -> DslistsinglyGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_singly_graphn_len(s : DslistsinglyGraphN) -> Int { s.size }

pub fn ds_list_singly_graphn_get(s : DslistsinglyGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_singly_graphn_set(s : DslistsinglyGraphN, i : Int, v : Double) -> DslistsinglyGraphN {
  let result = ds_list_singly_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_singly_graphn_sum(s : DslistsinglyGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_singly_graphn_mean(s : DslistsinglyGraphN) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_singly_graphn_sum(s) / s.size.to_double() }
}

pub fn ds_list_singly_graphn_scale(s : DslistsinglyGraphN, f : Double) -> DslistsinglyGraphN {
  let result = ds_list_singly_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_singly_graphn_add(a : DslistsinglyGraphN, b : DslistsinglyGraphN) -> DslistsinglyGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_singly_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_singly_graphn_copy(s : DslistsinglyGraphN) -> DslistsinglyGraphN {
  let result = ds_list_singly_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_singly_graphn_fill(s : DslistsinglyGraphN, v : Double) -> DslistsinglyGraphN {
  let result = ds_list_singly_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_singly_graphn_min(s : DslistsinglyGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_singly_graphn_max(s : DslistsinglyGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_singly_graphn_to_string(s : DslistsinglyGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistsinglyNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_singly_node_make(size : Int) -> DslistsinglyNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_singly_node_len(s : DslistsinglyNode) -> Int { s.size }

pub fn ds_list_singly_node_get(s : DslistsinglyNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_singly_node_set(s : DslistsinglyNode, i : Int, v : Double) -> DslistsinglyNode {
  let result = ds_list_singly_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_singly_node_sum(s : DslistsinglyNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_singly_node_mean(s : DslistsinglyNode) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_singly_node_sum(s) / s.size.to_double() }
}

pub fn ds_list_singly_node_scale(s : DslistsinglyNode, f : Double) -> DslistsinglyNode {
  let result = ds_list_singly_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_singly_node_add(a : DslistsinglyNode, b : DslistsinglyNode) -> DslistsinglyNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_singly_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_singly_node_copy(s : DslistsinglyNode) -> DslistsinglyNode {
  let result = ds_list_singly_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_singly_node_fill(s : DslistsinglyNode, v : Double) -> DslistsinglyNode {
  let result = ds_list_singly_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_singly_node_min(s : DslistsinglyNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_singly_node_max(s : DslistsinglyNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_singly_node_to_string(s : DslistsinglyNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistsinglyEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_singly_edge_make(size : Int) -> DslistsinglyEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_singly_edge_len(s : DslistsinglyEdge) -> Int { s.size }

pub fn ds_list_singly_edge_get(s : DslistsinglyEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_singly_edge_set(s : DslistsinglyEdge, i : Int, v : Double) -> DslistsinglyEdge {
  let result = ds_list_singly_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_singly_edge_sum(s : DslistsinglyEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_singly_edge_mean(s : DslistsinglyEdge) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_singly_edge_sum(s) / s.size.to_double() }
}

pub fn ds_list_singly_edge_scale(s : DslistsinglyEdge, f : Double) -> DslistsinglyEdge {
  let result = ds_list_singly_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_singly_edge_add(a : DslistsinglyEdge, b : DslistsinglyEdge) -> DslistsinglyEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_singly_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_singly_edge_copy(s : DslistsinglyEdge) -> DslistsinglyEdge {
  let result = ds_list_singly_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_singly_edge_fill(s : DslistsinglyEdge, v : Double) -> DslistsinglyEdge {
  let result = ds_list_singly_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_singly_edge_min(s : DslistsinglyEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_singly_edge_max(s : DslistsinglyEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_singly_edge_to_string(s : DslistsinglyEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistsinglyPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_singly_path_make(size : Int) -> DslistsinglyPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_singly_path_len(s : DslistsinglyPath) -> Int { s.size }

pub fn ds_list_singly_path_get(s : DslistsinglyPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_singly_path_set(s : DslistsinglyPath, i : Int, v : Double) -> DslistsinglyPath {
  let result = ds_list_singly_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_singly_path_sum(s : DslistsinglyPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_singly_path_mean(s : DslistsinglyPath) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_singly_path_sum(s) / s.size.to_double() }
}

pub fn ds_list_singly_path_scale(s : DslistsinglyPath, f : Double) -> DslistsinglyPath {
  let result = ds_list_singly_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_singly_path_add(a : DslistsinglyPath, b : DslistsinglyPath) -> DslistsinglyPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_singly_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_singly_path_copy(s : DslistsinglyPath) -> DslistsinglyPath {
  let result = ds_list_singly_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_singly_path_fill(s : DslistsinglyPath, v : Double) -> DslistsinglyPath {
  let result = ds_list_singly_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_singly_path_min(s : DslistsinglyPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_singly_path_max(s : DslistsinglyPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_singly_path_to_string(s : DslistsinglyPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistsinglyCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_singly_cluster_make(size : Int) -> DslistsinglyCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_singly_cluster_len(s : DslistsinglyCluster) -> Int { s.size }

pub fn ds_list_singly_cluster_get(s : DslistsinglyCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_singly_cluster_set(s : DslistsinglyCluster, i : Int, v : Double) -> DslistsinglyCluster {
  let result = ds_list_singly_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_singly_cluster_sum(s : DslistsinglyCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_singly_cluster_mean(s : DslistsinglyCluster) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_singly_cluster_sum(s) / s.size.to_double() }
}

pub fn ds_list_singly_cluster_scale(s : DslistsinglyCluster, f : Double) -> DslistsinglyCluster {
  let result = ds_list_singly_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_singly_cluster_add(a : DslistsinglyCluster, b : DslistsinglyCluster) -> DslistsinglyCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_singly_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_singly_cluster_copy(s : DslistsinglyCluster) -> DslistsinglyCluster {
  let result = ds_list_singly_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_singly_cluster_fill(s : DslistsinglyCluster, v : Double) -> DslistsinglyCluster {
  let result = ds_list_singly_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_singly_cluster_min(s : DslistsinglyCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_singly_cluster_max(s : DslistsinglyCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_singly_cluster_to_string(s : DslistsinglyCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistsinglyModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_singly_model_make(size : Int) -> DslistsinglyModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_singly_model_len(s : DslistsinglyModel) -> Int { s.size }

pub fn ds_list_singly_model_get(s : DslistsinglyModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_singly_model_set(s : DslistsinglyModel, i : Int, v : Double) -> DslistsinglyModel {
  let result = ds_list_singly_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_singly_model_sum(s : DslistsinglyModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_singly_model_mean(s : DslistsinglyModel) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_singly_model_sum(s) / s.size.to_double() }
}

pub fn ds_list_singly_model_scale(s : DslistsinglyModel, f : Double) -> DslistsinglyModel {
  let result = ds_list_singly_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_singly_model_add(a : DslistsinglyModel, b : DslistsinglyModel) -> DslistsinglyModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_singly_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_singly_model_copy(s : DslistsinglyModel) -> DslistsinglyModel {
  let result = ds_list_singly_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_singly_model_fill(s : DslistsinglyModel, v : Double) -> DslistsinglyModel {
  let result = ds_list_singly_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_singly_model_min(s : DslistsinglyModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_singly_model_max(s : DslistsinglyModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_singly_model_to_string(s : DslistsinglyModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistsinglyLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_singly_layer_make(size : Int) -> DslistsinglyLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_singly_layer_len(s : DslistsinglyLayer) -> Int { s.size }

pub fn ds_list_singly_layer_get(s : DslistsinglyLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_singly_layer_set(s : DslistsinglyLayer, i : Int, v : Double) -> DslistsinglyLayer {
  let result = ds_list_singly_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_singly_layer_sum(s : DslistsinglyLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_singly_layer_mean(s : DslistsinglyLayer) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_singly_layer_sum(s) / s.size.to_double() }
}

pub fn ds_list_singly_layer_scale(s : DslistsinglyLayer, f : Double) -> DslistsinglyLayer {
  let result = ds_list_singly_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_singly_layer_add(a : DslistsinglyLayer, b : DslistsinglyLayer) -> DslistsinglyLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_singly_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_singly_layer_copy(s : DslistsinglyLayer) -> DslistsinglyLayer {
  let result = ds_list_singly_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_singly_layer_fill(s : DslistsinglyLayer, v : Double) -> DslistsinglyLayer {
  let result = ds_list_singly_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_singly_layer_min(s : DslistsinglyLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_singly_layer_max(s : DslistsinglyLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_singly_layer_to_string(s : DslistsinglyLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistsinglyBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_singly_buffer_make(size : Int) -> DslistsinglyBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_singly_buffer_len(s : DslistsinglyBuffer) -> Int { s.size }

pub fn ds_list_singly_buffer_get(s : DslistsinglyBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_singly_buffer_set(s : DslistsinglyBuffer, i : Int, v : Double) -> DslistsinglyBuffer {
  let result = ds_list_singly_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_singly_buffer_sum(s : DslistsinglyBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_singly_buffer_mean(s : DslistsinglyBuffer) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_singly_buffer_sum(s) / s.size.to_double() }
}

pub fn ds_list_singly_buffer_scale(s : DslistsinglyBuffer, f : Double) -> DslistsinglyBuffer {
  let result = ds_list_singly_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_singly_buffer_add(a : DslistsinglyBuffer, b : DslistsinglyBuffer) -> DslistsinglyBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_singly_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_singly_buffer_copy(s : DslistsinglyBuffer) -> DslistsinglyBuffer {
  let result = ds_list_singly_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_singly_buffer_fill(s : DslistsinglyBuffer, v : Double) -> DslistsinglyBuffer {
  let result = ds_list_singly_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_singly_buffer_min(s : DslistsinglyBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_singly_buffer_max(s : DslistsinglyBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_singly_buffer_to_string(s : DslistsinglyBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistsinglyCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_singly_cursor_make(size : Int) -> DslistsinglyCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_singly_cursor_len(s : DslistsinglyCursor) -> Int { s.size }

pub fn ds_list_singly_cursor_get(s : DslistsinglyCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_singly_cursor_set(s : DslistsinglyCursor, i : Int, v : Double) -> DslistsinglyCursor {
  let result = ds_list_singly_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_singly_cursor_sum(s : DslistsinglyCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_singly_cursor_mean(s : DslistsinglyCursor) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_singly_cursor_sum(s) / s.size.to_double() }
}

pub fn ds_list_singly_cursor_scale(s : DslistsinglyCursor, f : Double) -> DslistsinglyCursor {
  let result = ds_list_singly_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_singly_cursor_add(a : DslistsinglyCursor, b : DslistsinglyCursor) -> DslistsinglyCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_singly_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_singly_cursor_copy(s : DslistsinglyCursor) -> DslistsinglyCursor {
  let result = ds_list_singly_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_singly_cursor_fill(s : DslistsinglyCursor, v : Double) -> DslistsinglyCursor {
  let result = ds_list_singly_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_singly_cursor_min(s : DslistsinglyCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_singly_cursor_max(s : DslistsinglyCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_singly_cursor_to_string(s : DslistsinglyCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistsinglyView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_singly_view_make(size : Int) -> DslistsinglyView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_singly_view_len(s : DslistsinglyView) -> Int { s.size }

pub fn ds_list_singly_view_get(s : DslistsinglyView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_singly_view_set(s : DslistsinglyView, i : Int, v : Double) -> DslistsinglyView {
  let result = ds_list_singly_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_singly_view_sum(s : DslistsinglyView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_singly_view_mean(s : DslistsinglyView) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_singly_view_sum(s) / s.size.to_double() }
}

pub fn ds_list_singly_view_scale(s : DslistsinglyView, f : Double) -> DslistsinglyView {
  let result = ds_list_singly_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_singly_view_add(a : DslistsinglyView, b : DslistsinglyView) -> DslistsinglyView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_singly_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_singly_view_copy(s : DslistsinglyView) -> DslistsinglyView {
  let result = ds_list_singly_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_singly_view_fill(s : DslistsinglyView, v : Double) -> DslistsinglyView {
  let result = ds_list_singly_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_singly_view_min(s : DslistsinglyView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_singly_view_max(s : DslistsinglyView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_singly_view_to_string(s : DslistsinglyView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistsinglyRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_singly_range_make(size : Int) -> DslistsinglyRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_singly_range_len(s : DslistsinglyRange) -> Int { s.size }

pub fn ds_list_singly_range_get(s : DslistsinglyRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_singly_range_set(s : DslistsinglyRange, i : Int, v : Double) -> DslistsinglyRange {
  let result = ds_list_singly_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_singly_range_sum(s : DslistsinglyRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_singly_range_mean(s : DslistsinglyRange) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_singly_range_sum(s) / s.size.to_double() }
}

pub fn ds_list_singly_range_scale(s : DslistsinglyRange, f : Double) -> DslistsinglyRange {
  let result = ds_list_singly_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_singly_range_add(a : DslistsinglyRange, b : DslistsinglyRange) -> DslistsinglyRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_singly_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_singly_range_copy(s : DslistsinglyRange) -> DslistsinglyRange {
  let result = ds_list_singly_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_singly_range_fill(s : DslistsinglyRange, v : Double) -> DslistsinglyRange {
  let result = ds_list_singly_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_singly_range_min(s : DslistsinglyRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_singly_range_max(s : DslistsinglyRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_singly_range_to_string(s : DslistsinglyRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistsinglySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_singly_slice_make(size : Int) -> DslistsinglySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_singly_slice_len(s : DslistsinglySlice) -> Int { s.size }

pub fn ds_list_singly_slice_get(s : DslistsinglySlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_singly_slice_set(s : DslistsinglySlice, i : Int, v : Double) -> DslistsinglySlice {
  let result = ds_list_singly_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_singly_slice_sum(s : DslistsinglySlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_singly_slice_mean(s : DslistsinglySlice) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_singly_slice_sum(s) / s.size.to_double() }
}

pub fn ds_list_singly_slice_scale(s : DslistsinglySlice, f : Double) -> DslistsinglySlice {
  let result = ds_list_singly_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_singly_slice_add(a : DslistsinglySlice, b : DslistsinglySlice) -> DslistsinglySlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_singly_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_singly_slice_copy(s : DslistsinglySlice) -> DslistsinglySlice {
  let result = ds_list_singly_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_singly_slice_fill(s : DslistsinglySlice, v : Double) -> DslistsinglySlice {
  let result = ds_list_singly_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_singly_slice_min(s : DslistsinglySlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_singly_slice_max(s : DslistsinglySlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_singly_slice_to_string(s : DslistsinglySlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


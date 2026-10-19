///===
/// extcore/ds_heap_pairing

pub(all) struct DsheappairingPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_heap_pairing_make_point(x : Double, y : Double) -> DsheappairingPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_heap_pairing_make_point3(x : Double, y : Double, z : Double) -> DsheappairingPoint {
  { x, y, z, label: 0 }
}

pub fn ds_heap_pairing_point_x(pt : DsheappairingPoint) -> Double { pt.x }

pub fn ds_heap_pairing_point_y(pt : DsheappairingPoint) -> Double { pt.y }

pub fn ds_heap_pairing_point_z(pt : DsheappairingPoint) -> Double { pt.z }

pub fn ds_heap_pairing_point_label(pt : DsheappairingPoint) -> Int { pt.label }

pub fn ds_heap_pairing_point_dist(a : DsheappairingPoint, b : DsheappairingPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ds_heap_pairing_point_add(a : DsheappairingPoint, b : DsheappairingPoint) -> DsheappairingPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ds_heap_pairing_point_sub(a : DsheappairingPoint, b : DsheappairingPoint) -> DsheappairingPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ds_heap_pairing_point_scale(pt : DsheappairingPoint, s : Double) -> DsheappairingPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ds_heap_pairing_point_dot(a : DsheappairingPoint, b : DsheappairingPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ds_heap_pairing_point_cross(a : DsheappairingPoint, b : DsheappairingPoint) -> DsheappairingPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ds_heap_pairing_point_norm(pt : DsheappairingPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ds_heap_pairing_point_normalize(pt : DsheappairingPoint) -> DsheappairingPoint {
  let n = ds_heap_pairing_point_norm(pt)
  if n < 0.0000001 { pt } else { ds_heap_pairing_point_scale(pt, 1.0 / n) }
}

pub fn ds_heap_pairing_point_negate(pt : DsheappairingPoint) -> DsheappairingPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ds_heap_pairing_point_mid(a : DsheappairingPoint, b : DsheappairingPoint) -> DsheappairingPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ds_heap_pairing_point_lerp(a : DsheappairingPoint, b : DsheappairingPoint, t : Double) -> DsheappairingPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ds_heap_pairing_point_to_string(pt : DsheappairingPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DsheappairingSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_heap_pairing_make_series(vals : Array[Double], name : String) -> DsheappairingSeries {
  { vals, name, meta: 0 }
}

pub fn ds_heap_pairing_series_len(s : DsheappairingSeries) -> Int { s.vals.length() }

pub fn ds_heap_pairing_series_sum(s : DsheappairingSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn ds_heap_pairing_series_mean(s : DsheappairingSeries) -> Double {
  let n = ds_heap_pairing_series_len(s)
  if n == 0 { 0.0 } else { ds_heap_pairing_series_sum(s) / n.to_double() }
}

pub fn ds_heap_pairing_series_min(s : DsheappairingSeries) -> Double {
  let n = ds_heap_pairing_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn ds_heap_pairing_series_max(s : DsheappairingSeries) -> Double {
  let n = ds_heap_pairing_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn ds_heap_pairing_series_range(s : DsheappairingSeries) -> Double {
  ds_heap_pairing_series_max(s) - ds_heap_pairing_series_min(s)
}

pub fn ds_heap_pairing_series_var(s : DsheappairingSeries) -> Double {
  let n = ds_heap_pairing_series_len(s)
  if n == 0 { 0.0 } else {
    let m = ds_heap_pairing_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn ds_heap_pairing_series_std(s : DsheappairingSeries) -> Double { @_common.sqrt(ds_heap_pairing_series_var(s)) }

pub fn ds_heap_pairing_series_median(s : DsheappairingSeries) -> Double {
  let n = ds_heap_pairing_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = ds_heap_pairing_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ds_heap_pairing_series_scale(s : DsheappairingSeries, f : Double) -> DsheappairingSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ds_heap_pairing_series_add(a : DsheappairingSeries, b : DsheappairingSeries) -> DsheappairingSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ds_heap_pairing_series_sub(a : DsheappairingSeries, b : DsheappairingSeries) -> DsheappairingSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ds_heap_pairing_series_normalize(s : DsheappairingSeries) -> DsheappairingSeries {
  let mn = ds_heap_pairing_series_min(s)
  let mx = ds_heap_pairing_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ds_heap_pairing_series_cumsum(s : DsheappairingSeries) -> DsheappairingSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn ds_heap_pairing_series_to_string(s : DsheappairingSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DsheappairingMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_heap_pairing_make_matrix(rows : Int, cols : Int, val : Double) -> DsheappairingMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_heap_pairing_matrix_identity(n : Int) -> DsheappairingMatrix {
  let m = ds_heap_pairing_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ds_heap_pairing_matrix_get(m : DsheappairingMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ds_heap_pairing_matrix_transpose(m : DsheappairingMatrix) -> DsheappairingMatrix {
  let result = ds_heap_pairing_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ds_heap_pairing_matrix_add(a : DsheappairingMatrix, b : DsheappairingMatrix) -> DsheappairingMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ds_heap_pairing_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ds_heap_pairing_matrix_scale(m : DsheappairingMatrix, s : Double) -> DsheappairingMatrix {
  let result = ds_heap_pairing_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ds_heap_pairing_matrix_multiply(a : DsheappairingMatrix, b : DsheappairingMatrix) -> DsheappairingMatrix {
  if a.cols != b.rows { return ds_heap_pairing_make_matrix(a.rows, b.cols, 0.0) }
  let result = ds_heap_pairing_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ds_heap_pairing_matrix_trace(m : DsheappairingMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ds_heap_pairing_matrix_det(m : DsheappairingMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ds_heap_pairing_matrix_norm(m : DsheappairingMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ds_heap_pairing_matrix_to_string(m : DsheappairingMatrix) -> String {
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

pub(all) struct DsheappairingVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_heap_pairing_make_vector(comps : Array[Double]) -> DsheappairingVector {
  { comps, dim: comps.length() }
}

pub fn ds_heap_pairing_vector_zero(dim : Int) -> DsheappairingVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ds_heap_pairing_vector_add(a : DsheappairingVector, b : DsheappairingVector) -> DsheappairingVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_heap_pairing_vector_sub(a : DsheappairingVector, b : DsheappairingVector) -> DsheappairingVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_heap_pairing_vector_scale(v : DsheappairingVector, s : Double) -> DsheappairingVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ds_heap_pairing_vector_dot(a : DsheappairingVector, b : DsheappairingVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ds_heap_pairing_vector_norm(v : DsheappairingVector) -> Double { @_common.sqrt(ds_heap_pairing_vector_dot(v, v)) }

pub fn ds_heap_pairing_vector_normalize(v : DsheappairingVector) -> DsheappairingVector {
  let n = ds_heap_pairing_vector_norm(v)
  if n < 0.0000001 { v } else { ds_heap_pairing_vector_scale(v, 1.0 / n) }
}

pub fn ds_heap_pairing_vector_dist(a : DsheappairingVector, b : DsheappairingVector) -> Double {
  ds_heap_pairing_vector_norm(ds_heap_pairing_vector_sub(a, b))
}

pub fn ds_heap_pairing_vector_to_string(v : DsheappairingVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_heap_pairing_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn ds_heap_pairing_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = ds_heap_pairing_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ds_heap_pairing_std(data : Array[Double]) -> Double { @_common.sqrt(ds_heap_pairing_var(data)) }

pub fn ds_heap_pairing_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = ds_heap_pairing_mean(a); let mb = ds_heap_pairing_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn ds_heap_pairing_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = ds_heap_pairing_std(a); let sb = ds_heap_pairing_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { ds_heap_pairing_cov(a, b) / (sa * sb) }
}

pub fn ds_heap_pairing_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = ds_heap_pairing_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ds_heap_pairing_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn ds_heap_pairing_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ds_heap_pairing_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(ds_heap_pairing_mse(pred, labels))
}

pub fn ds_heap_pairing_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn ds_heap_pairing_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = ds_heap_pairing_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn ds_heap_pairing_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn ds_heap_pairing_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn ds_heap_pairing_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = ds_heap_pairing_precision(pred, labels, pos); let r = ds_heap_pairing_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn ds_heap_pairing_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn ds_heap_pairing_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = ds_heap_pairing_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn ds_heap_pairing_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn ds_heap_pairing_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn ds_heap_pairing_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = ds_heap_pairing_gcd(a, b)
    (a / g) * b
  }
}

pub fn ds_heap_pairing_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn ds_heap_pairing_fibonacci(n : Int) -> Int {
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

pub fn ds_heap_pairing_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = ds_heap_pairing_min(data); let mx = ds_heap_pairing_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn ds_heap_pairing_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = ds_heap_pairing_mean(data); let sd = ds_heap_pairing_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn ds_heap_pairing_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn ds_heap_pairing_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn ds_heap_pairing_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn ds_heap_pairing_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn ds_heap_pairing_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn ds_heap_pairing_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct DsheappairingFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_pairing_frame_make(size : Int) -> DsheappairingFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_pairing_frame_len(s : DsheappairingFrame) -> Int { s.size }

pub fn ds_heap_pairing_frame_get(s : DsheappairingFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_pairing_frame_set(s : DsheappairingFrame, i : Int, v : Double) -> DsheappairingFrame {
  let result = ds_heap_pairing_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_pairing_frame_sum(s : DsheappairingFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_heap_pairing_frame_mean(s : DsheappairingFrame) -> Double {
  if s.size == 0 { 0.0 } else { ds_heap_pairing_frame_sum(s) / s.size.to_double() }
}

pub fn ds_heap_pairing_frame_scale(s : DsheappairingFrame, f : Double) -> DsheappairingFrame {
  let result = ds_heap_pairing_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_pairing_frame_add(a : DsheappairingFrame, b : DsheappairingFrame) -> DsheappairingFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_pairing_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_pairing_frame_copy(s : DsheappairingFrame) -> DsheappairingFrame {
  let result = ds_heap_pairing_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_pairing_frame_fill(s : DsheappairingFrame, v : Double) -> DsheappairingFrame {
  let result = ds_heap_pairing_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_pairing_frame_min(s : DsheappairingFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_pairing_frame_max(s : DsheappairingFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_pairing_frame_to_string(s : DsheappairingFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheappairingTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_pairing_table_make(size : Int) -> DsheappairingTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_pairing_table_len(s : DsheappairingTable) -> Int { s.size }

pub fn ds_heap_pairing_table_get(s : DsheappairingTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_pairing_table_set(s : DsheappairingTable, i : Int, v : Double) -> DsheappairingTable {
  let result = ds_heap_pairing_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_pairing_table_sum(s : DsheappairingTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_heap_pairing_table_mean(s : DsheappairingTable) -> Double {
  if s.size == 0 { 0.0 } else { ds_heap_pairing_table_sum(s) / s.size.to_double() }
}

pub fn ds_heap_pairing_table_scale(s : DsheappairingTable, f : Double) -> DsheappairingTable {
  let result = ds_heap_pairing_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_pairing_table_add(a : DsheappairingTable, b : DsheappairingTable) -> DsheappairingTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_pairing_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_pairing_table_copy(s : DsheappairingTable) -> DsheappairingTable {
  let result = ds_heap_pairing_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_pairing_table_fill(s : DsheappairingTable, v : Double) -> DsheappairingTable {
  let result = ds_heap_pairing_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_pairing_table_min(s : DsheappairingTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_pairing_table_max(s : DsheappairingTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_pairing_table_to_string(s : DsheappairingTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheappairingGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_pairing_graphn_make(size : Int) -> DsheappairingGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_pairing_graphn_len(s : DsheappairingGraphN) -> Int { s.size }

pub fn ds_heap_pairing_graphn_get(s : DsheappairingGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_pairing_graphn_set(s : DsheappairingGraphN, i : Int, v : Double) -> DsheappairingGraphN {
  let result = ds_heap_pairing_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_pairing_graphn_sum(s : DsheappairingGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_heap_pairing_graphn_mean(s : DsheappairingGraphN) -> Double {
  if s.size == 0 { 0.0 } else { ds_heap_pairing_graphn_sum(s) / s.size.to_double() }
}

pub fn ds_heap_pairing_graphn_scale(s : DsheappairingGraphN, f : Double) -> DsheappairingGraphN {
  let result = ds_heap_pairing_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_pairing_graphn_add(a : DsheappairingGraphN, b : DsheappairingGraphN) -> DsheappairingGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_pairing_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_pairing_graphn_copy(s : DsheappairingGraphN) -> DsheappairingGraphN {
  let result = ds_heap_pairing_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_pairing_graphn_fill(s : DsheappairingGraphN, v : Double) -> DsheappairingGraphN {
  let result = ds_heap_pairing_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_pairing_graphn_min(s : DsheappairingGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_pairing_graphn_max(s : DsheappairingGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_pairing_graphn_to_string(s : DsheappairingGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheappairingNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_pairing_node_make(size : Int) -> DsheappairingNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_pairing_node_len(s : DsheappairingNode) -> Int { s.size }

pub fn ds_heap_pairing_node_get(s : DsheappairingNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_pairing_node_set(s : DsheappairingNode, i : Int, v : Double) -> DsheappairingNode {
  let result = ds_heap_pairing_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_pairing_node_sum(s : DsheappairingNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_heap_pairing_node_mean(s : DsheappairingNode) -> Double {
  if s.size == 0 { 0.0 } else { ds_heap_pairing_node_sum(s) / s.size.to_double() }
}

pub fn ds_heap_pairing_node_scale(s : DsheappairingNode, f : Double) -> DsheappairingNode {
  let result = ds_heap_pairing_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_pairing_node_add(a : DsheappairingNode, b : DsheappairingNode) -> DsheappairingNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_pairing_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_pairing_node_copy(s : DsheappairingNode) -> DsheappairingNode {
  let result = ds_heap_pairing_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_pairing_node_fill(s : DsheappairingNode, v : Double) -> DsheappairingNode {
  let result = ds_heap_pairing_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_pairing_node_min(s : DsheappairingNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_pairing_node_max(s : DsheappairingNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_pairing_node_to_string(s : DsheappairingNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheappairingEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_pairing_edge_make(size : Int) -> DsheappairingEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_pairing_edge_len(s : DsheappairingEdge) -> Int { s.size }

pub fn ds_heap_pairing_edge_get(s : DsheappairingEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_pairing_edge_set(s : DsheappairingEdge, i : Int, v : Double) -> DsheappairingEdge {
  let result = ds_heap_pairing_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_pairing_edge_sum(s : DsheappairingEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_heap_pairing_edge_mean(s : DsheappairingEdge) -> Double {
  if s.size == 0 { 0.0 } else { ds_heap_pairing_edge_sum(s) / s.size.to_double() }
}

pub fn ds_heap_pairing_edge_scale(s : DsheappairingEdge, f : Double) -> DsheappairingEdge {
  let result = ds_heap_pairing_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_pairing_edge_add(a : DsheappairingEdge, b : DsheappairingEdge) -> DsheappairingEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_pairing_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_pairing_edge_copy(s : DsheappairingEdge) -> DsheappairingEdge {
  let result = ds_heap_pairing_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_pairing_edge_fill(s : DsheappairingEdge, v : Double) -> DsheappairingEdge {
  let result = ds_heap_pairing_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_pairing_edge_min(s : DsheappairingEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_pairing_edge_max(s : DsheappairingEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_pairing_edge_to_string(s : DsheappairingEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheappairingPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_pairing_path_make(size : Int) -> DsheappairingPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_pairing_path_len(s : DsheappairingPath) -> Int { s.size }

pub fn ds_heap_pairing_path_get(s : DsheappairingPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_pairing_path_set(s : DsheappairingPath, i : Int, v : Double) -> DsheappairingPath {
  let result = ds_heap_pairing_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_pairing_path_sum(s : DsheappairingPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_heap_pairing_path_mean(s : DsheappairingPath) -> Double {
  if s.size == 0 { 0.0 } else { ds_heap_pairing_path_sum(s) / s.size.to_double() }
}

pub fn ds_heap_pairing_path_scale(s : DsheappairingPath, f : Double) -> DsheappairingPath {
  let result = ds_heap_pairing_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_pairing_path_add(a : DsheappairingPath, b : DsheappairingPath) -> DsheappairingPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_pairing_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_pairing_path_copy(s : DsheappairingPath) -> DsheappairingPath {
  let result = ds_heap_pairing_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_pairing_path_fill(s : DsheappairingPath, v : Double) -> DsheappairingPath {
  let result = ds_heap_pairing_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_pairing_path_min(s : DsheappairingPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_pairing_path_max(s : DsheappairingPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_pairing_path_to_string(s : DsheappairingPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheappairingCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_pairing_cluster_make(size : Int) -> DsheappairingCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_pairing_cluster_len(s : DsheappairingCluster) -> Int { s.size }

pub fn ds_heap_pairing_cluster_get(s : DsheappairingCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_pairing_cluster_set(s : DsheappairingCluster, i : Int, v : Double) -> DsheappairingCluster {
  let result = ds_heap_pairing_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_pairing_cluster_sum(s : DsheappairingCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_heap_pairing_cluster_mean(s : DsheappairingCluster) -> Double {
  if s.size == 0 { 0.0 } else { ds_heap_pairing_cluster_sum(s) / s.size.to_double() }
}

pub fn ds_heap_pairing_cluster_scale(s : DsheappairingCluster, f : Double) -> DsheappairingCluster {
  let result = ds_heap_pairing_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_pairing_cluster_add(a : DsheappairingCluster, b : DsheappairingCluster) -> DsheappairingCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_pairing_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_pairing_cluster_copy(s : DsheappairingCluster) -> DsheappairingCluster {
  let result = ds_heap_pairing_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_pairing_cluster_fill(s : DsheappairingCluster, v : Double) -> DsheappairingCluster {
  let result = ds_heap_pairing_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_pairing_cluster_min(s : DsheappairingCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_pairing_cluster_max(s : DsheappairingCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_pairing_cluster_to_string(s : DsheappairingCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheappairingModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_pairing_model_make(size : Int) -> DsheappairingModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_pairing_model_len(s : DsheappairingModel) -> Int { s.size }

pub fn ds_heap_pairing_model_get(s : DsheappairingModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_pairing_model_set(s : DsheappairingModel, i : Int, v : Double) -> DsheappairingModel {
  let result = ds_heap_pairing_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_pairing_model_sum(s : DsheappairingModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_heap_pairing_model_mean(s : DsheappairingModel) -> Double {
  if s.size == 0 { 0.0 } else { ds_heap_pairing_model_sum(s) / s.size.to_double() }
}

pub fn ds_heap_pairing_model_scale(s : DsheappairingModel, f : Double) -> DsheappairingModel {
  let result = ds_heap_pairing_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_pairing_model_add(a : DsheappairingModel, b : DsheappairingModel) -> DsheappairingModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_pairing_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_pairing_model_copy(s : DsheappairingModel) -> DsheappairingModel {
  let result = ds_heap_pairing_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_pairing_model_fill(s : DsheappairingModel, v : Double) -> DsheappairingModel {
  let result = ds_heap_pairing_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_pairing_model_min(s : DsheappairingModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_pairing_model_max(s : DsheappairingModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_pairing_model_to_string(s : DsheappairingModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheappairingLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_pairing_layer_make(size : Int) -> DsheappairingLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_pairing_layer_len(s : DsheappairingLayer) -> Int { s.size }

pub fn ds_heap_pairing_layer_get(s : DsheappairingLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_pairing_layer_set(s : DsheappairingLayer, i : Int, v : Double) -> DsheappairingLayer {
  let result = ds_heap_pairing_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_pairing_layer_sum(s : DsheappairingLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_heap_pairing_layer_mean(s : DsheappairingLayer) -> Double {
  if s.size == 0 { 0.0 } else { ds_heap_pairing_layer_sum(s) / s.size.to_double() }
}

pub fn ds_heap_pairing_layer_scale(s : DsheappairingLayer, f : Double) -> DsheappairingLayer {
  let result = ds_heap_pairing_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_pairing_layer_add(a : DsheappairingLayer, b : DsheappairingLayer) -> DsheappairingLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_pairing_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_pairing_layer_copy(s : DsheappairingLayer) -> DsheappairingLayer {
  let result = ds_heap_pairing_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_pairing_layer_fill(s : DsheappairingLayer, v : Double) -> DsheappairingLayer {
  let result = ds_heap_pairing_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_pairing_layer_min(s : DsheappairingLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_pairing_layer_max(s : DsheappairingLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_pairing_layer_to_string(s : DsheappairingLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheappairingBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_pairing_buffer_make(size : Int) -> DsheappairingBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_pairing_buffer_len(s : DsheappairingBuffer) -> Int { s.size }

pub fn ds_heap_pairing_buffer_get(s : DsheappairingBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_pairing_buffer_set(s : DsheappairingBuffer, i : Int, v : Double) -> DsheappairingBuffer {
  let result = ds_heap_pairing_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_pairing_buffer_sum(s : DsheappairingBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_heap_pairing_buffer_mean(s : DsheappairingBuffer) -> Double {
  if s.size == 0 { 0.0 } else { ds_heap_pairing_buffer_sum(s) / s.size.to_double() }
}

pub fn ds_heap_pairing_buffer_scale(s : DsheappairingBuffer, f : Double) -> DsheappairingBuffer {
  let result = ds_heap_pairing_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_pairing_buffer_add(a : DsheappairingBuffer, b : DsheappairingBuffer) -> DsheappairingBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_pairing_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_pairing_buffer_copy(s : DsheappairingBuffer) -> DsheappairingBuffer {
  let result = ds_heap_pairing_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_pairing_buffer_fill(s : DsheappairingBuffer, v : Double) -> DsheappairingBuffer {
  let result = ds_heap_pairing_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_pairing_buffer_min(s : DsheappairingBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_pairing_buffer_max(s : DsheappairingBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_pairing_buffer_to_string(s : DsheappairingBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheappairingCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_pairing_cursor_make(size : Int) -> DsheappairingCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_pairing_cursor_len(s : DsheappairingCursor) -> Int { s.size }

pub fn ds_heap_pairing_cursor_get(s : DsheappairingCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_pairing_cursor_set(s : DsheappairingCursor, i : Int, v : Double) -> DsheappairingCursor {
  let result = ds_heap_pairing_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_pairing_cursor_sum(s : DsheappairingCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_heap_pairing_cursor_mean(s : DsheappairingCursor) -> Double {
  if s.size == 0 { 0.0 } else { ds_heap_pairing_cursor_sum(s) / s.size.to_double() }
}

pub fn ds_heap_pairing_cursor_scale(s : DsheappairingCursor, f : Double) -> DsheappairingCursor {
  let result = ds_heap_pairing_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_pairing_cursor_add(a : DsheappairingCursor, b : DsheappairingCursor) -> DsheappairingCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_pairing_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_pairing_cursor_copy(s : DsheappairingCursor) -> DsheappairingCursor {
  let result = ds_heap_pairing_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_pairing_cursor_fill(s : DsheappairingCursor, v : Double) -> DsheappairingCursor {
  let result = ds_heap_pairing_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_pairing_cursor_min(s : DsheappairingCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_pairing_cursor_max(s : DsheappairingCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_pairing_cursor_to_string(s : DsheappairingCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheappairingView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_pairing_view_make(size : Int) -> DsheappairingView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_pairing_view_len(s : DsheappairingView) -> Int { s.size }

pub fn ds_heap_pairing_view_get(s : DsheappairingView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_pairing_view_set(s : DsheappairingView, i : Int, v : Double) -> DsheappairingView {
  let result = ds_heap_pairing_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_pairing_view_sum(s : DsheappairingView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_heap_pairing_view_mean(s : DsheappairingView) -> Double {
  if s.size == 0 { 0.0 } else { ds_heap_pairing_view_sum(s) / s.size.to_double() }
}

pub fn ds_heap_pairing_view_scale(s : DsheappairingView, f : Double) -> DsheappairingView {
  let result = ds_heap_pairing_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_pairing_view_add(a : DsheappairingView, b : DsheappairingView) -> DsheappairingView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_pairing_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_pairing_view_copy(s : DsheappairingView) -> DsheappairingView {
  let result = ds_heap_pairing_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_pairing_view_fill(s : DsheappairingView, v : Double) -> DsheappairingView {
  let result = ds_heap_pairing_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_pairing_view_min(s : DsheappairingView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_pairing_view_max(s : DsheappairingView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_pairing_view_to_string(s : DsheappairingView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheappairingRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_pairing_range_make(size : Int) -> DsheappairingRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_pairing_range_len(s : DsheappairingRange) -> Int { s.size }

pub fn ds_heap_pairing_range_get(s : DsheappairingRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_pairing_range_set(s : DsheappairingRange, i : Int, v : Double) -> DsheappairingRange {
  let result = ds_heap_pairing_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_pairing_range_sum(s : DsheappairingRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_heap_pairing_range_mean(s : DsheappairingRange) -> Double {
  if s.size == 0 { 0.0 } else { ds_heap_pairing_range_sum(s) / s.size.to_double() }
}

pub fn ds_heap_pairing_range_scale(s : DsheappairingRange, f : Double) -> DsheappairingRange {
  let result = ds_heap_pairing_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_pairing_range_add(a : DsheappairingRange, b : DsheappairingRange) -> DsheappairingRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_pairing_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_pairing_range_copy(s : DsheappairingRange) -> DsheappairingRange {
  let result = ds_heap_pairing_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_pairing_range_fill(s : DsheappairingRange, v : Double) -> DsheappairingRange {
  let result = ds_heap_pairing_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_pairing_range_min(s : DsheappairingRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_pairing_range_max(s : DsheappairingRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_pairing_range_to_string(s : DsheappairingRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheappairingSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_pairing_slice_make(size : Int) -> DsheappairingSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_pairing_slice_len(s : DsheappairingSlice) -> Int { s.size }

pub fn ds_heap_pairing_slice_get(s : DsheappairingSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_pairing_slice_set(s : DsheappairingSlice, i : Int, v : Double) -> DsheappairingSlice {
  let result = ds_heap_pairing_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_heap_pairing_slice_sum(s : DsheappairingSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_heap_pairing_slice_mean(s : DsheappairingSlice) -> Double {
  if s.size == 0 { 0.0 } else { ds_heap_pairing_slice_sum(s) / s.size.to_double() }
}

pub fn ds_heap_pairing_slice_scale(s : DsheappairingSlice, f : Double) -> DsheappairingSlice {
  let result = ds_heap_pairing_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_heap_pairing_slice_add(a : DsheappairingSlice, b : DsheappairingSlice) -> DsheappairingSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_heap_pairing_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_heap_pairing_slice_copy(s : DsheappairingSlice) -> DsheappairingSlice {
  let result = ds_heap_pairing_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_heap_pairing_slice_fill(s : DsheappairingSlice, v : Double) -> DsheappairingSlice {
  let result = ds_heap_pairing_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_heap_pairing_slice_min(s : DsheappairingSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_pairing_slice_max(s : DsheappairingSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_heap_pairing_slice_to_string(s : DsheappairingSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


///===
/// extcore/ds_list_xor

pub(all) struct DslistxorPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_list_xor_make_point(x : Double, y : Double) -> DslistxorPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_list_xor_make_point3(x : Double, y : Double, z : Double) -> DslistxorPoint {
  { x, y, z, label: 0 }
}

pub fn ds_list_xor_point_x(pt : DslistxorPoint) -> Double { pt.x }

pub fn ds_list_xor_point_y(pt : DslistxorPoint) -> Double { pt.y }

pub fn ds_list_xor_point_z(pt : DslistxorPoint) -> Double { pt.z }

pub fn ds_list_xor_point_label(pt : DslistxorPoint) -> Int { pt.label }

pub fn ds_list_xor_point_dist(a : DslistxorPoint, b : DslistxorPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ds_list_xor_point_add(a : DslistxorPoint, b : DslistxorPoint) -> DslistxorPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ds_list_xor_point_sub(a : DslistxorPoint, b : DslistxorPoint) -> DslistxorPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ds_list_xor_point_scale(pt : DslistxorPoint, s : Double) -> DslistxorPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ds_list_xor_point_dot(a : DslistxorPoint, b : DslistxorPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ds_list_xor_point_cross(a : DslistxorPoint, b : DslistxorPoint) -> DslistxorPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ds_list_xor_point_norm(pt : DslistxorPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ds_list_xor_point_normalize(pt : DslistxorPoint) -> DslistxorPoint {
  let n = ds_list_xor_point_norm(pt)
  if n < 0.0000001 { pt } else { ds_list_xor_point_scale(pt, 1.0 / n) }
}

pub fn ds_list_xor_point_negate(pt : DslistxorPoint) -> DslistxorPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ds_list_xor_point_mid(a : DslistxorPoint, b : DslistxorPoint) -> DslistxorPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ds_list_xor_point_lerp(a : DslistxorPoint, b : DslistxorPoint, t : Double) -> DslistxorPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ds_list_xor_point_to_string(pt : DslistxorPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DslistxorSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_list_xor_make_series(vals : Array[Double], name : String) -> DslistxorSeries {
  { vals, name, meta: 0 }
}

pub fn ds_list_xor_series_len(s : DslistxorSeries) -> Int { s.vals.length() }

pub fn ds_list_xor_series_sum(s : DslistxorSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn ds_list_xor_series_mean(s : DslistxorSeries) -> Double {
  let n = ds_list_xor_series_len(s)
  if n == 0 { 0.0 } else { ds_list_xor_series_sum(s) / n.to_double() }
}

pub fn ds_list_xor_series_min(s : DslistxorSeries) -> Double {
  let n = ds_list_xor_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn ds_list_xor_series_max(s : DslistxorSeries) -> Double {
  let n = ds_list_xor_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn ds_list_xor_series_range(s : DslistxorSeries) -> Double {
  ds_list_xor_series_max(s) - ds_list_xor_series_min(s)
}

pub fn ds_list_xor_series_var(s : DslistxorSeries) -> Double {
  let n = ds_list_xor_series_len(s)
  if n == 0 { 0.0 } else {
    let m = ds_list_xor_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn ds_list_xor_series_std(s : DslistxorSeries) -> Double { @_common.sqrt(ds_list_xor_series_var(s)) }

pub fn ds_list_xor_series_median(s : DslistxorSeries) -> Double {
  let n = ds_list_xor_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = ds_list_xor_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ds_list_xor_series_scale(s : DslistxorSeries, f : Double) -> DslistxorSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ds_list_xor_series_add(a : DslistxorSeries, b : DslistxorSeries) -> DslistxorSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ds_list_xor_series_sub(a : DslistxorSeries, b : DslistxorSeries) -> DslistxorSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ds_list_xor_series_normalize(s : DslistxorSeries) -> DslistxorSeries {
  let mn = ds_list_xor_series_min(s)
  let mx = ds_list_xor_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ds_list_xor_series_cumsum(s : DslistxorSeries) -> DslistxorSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn ds_list_xor_series_to_string(s : DslistxorSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DslistxorMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_list_xor_make_matrix(rows : Int, cols : Int, val : Double) -> DslistxorMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_list_xor_matrix_identity(n : Int) -> DslistxorMatrix {
  let m = ds_list_xor_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ds_list_xor_matrix_get(m : DslistxorMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ds_list_xor_matrix_transpose(m : DslistxorMatrix) -> DslistxorMatrix {
  let result = ds_list_xor_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ds_list_xor_matrix_add(a : DslistxorMatrix, b : DslistxorMatrix) -> DslistxorMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ds_list_xor_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ds_list_xor_matrix_scale(m : DslistxorMatrix, s : Double) -> DslistxorMatrix {
  let result = ds_list_xor_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ds_list_xor_matrix_multiply(a : DslistxorMatrix, b : DslistxorMatrix) -> DslistxorMatrix {
  if a.cols != b.rows { return ds_list_xor_make_matrix(a.rows, b.cols, 0.0) }
  let result = ds_list_xor_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ds_list_xor_matrix_trace(m : DslistxorMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ds_list_xor_matrix_det(m : DslistxorMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ds_list_xor_matrix_norm(m : DslistxorMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ds_list_xor_matrix_to_string(m : DslistxorMatrix) -> String {
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

pub(all) struct DslistxorVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_list_xor_make_vector(comps : Array[Double]) -> DslistxorVector {
  { comps, dim: comps.length() }
}

pub fn ds_list_xor_vector_zero(dim : Int) -> DslistxorVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ds_list_xor_vector_add(a : DslistxorVector, b : DslistxorVector) -> DslistxorVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_list_xor_vector_sub(a : DslistxorVector, b : DslistxorVector) -> DslistxorVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_list_xor_vector_scale(v : DslistxorVector, s : Double) -> DslistxorVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ds_list_xor_vector_dot(a : DslistxorVector, b : DslistxorVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ds_list_xor_vector_norm(v : DslistxorVector) -> Double { @_common.sqrt(ds_list_xor_vector_dot(v, v)) }

pub fn ds_list_xor_vector_normalize(v : DslistxorVector) -> DslistxorVector {
  let n = ds_list_xor_vector_norm(v)
  if n < 0.0000001 { v } else { ds_list_xor_vector_scale(v, 1.0 / n) }
}

pub fn ds_list_xor_vector_dist(a : DslistxorVector, b : DslistxorVector) -> Double {
  ds_list_xor_vector_norm(ds_list_xor_vector_sub(a, b))
}

pub fn ds_list_xor_vector_to_string(v : DslistxorVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_list_xor_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn ds_list_xor_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = ds_list_xor_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ds_list_xor_std(data : Array[Double]) -> Double { @_common.sqrt(ds_list_xor_var(data)) }

pub fn ds_list_xor_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = ds_list_xor_mean(a); let mb = ds_list_xor_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn ds_list_xor_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = ds_list_xor_std(a); let sb = ds_list_xor_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { ds_list_xor_cov(a, b) / (sa * sb) }
}

pub fn ds_list_xor_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = ds_list_xor_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ds_list_xor_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn ds_list_xor_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ds_list_xor_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(ds_list_xor_mse(pred, labels))
}

pub fn ds_list_xor_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn ds_list_xor_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = ds_list_xor_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn ds_list_xor_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn ds_list_xor_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn ds_list_xor_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = ds_list_xor_precision(pred, labels, pos); let r = ds_list_xor_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn ds_list_xor_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn ds_list_xor_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = ds_list_xor_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn ds_list_xor_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn ds_list_xor_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn ds_list_xor_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = ds_list_xor_gcd(a, b)
    (a / g) * b
  }
}

pub fn ds_list_xor_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn ds_list_xor_fibonacci(n : Int) -> Int {
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

pub fn ds_list_xor_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = ds_list_xor_min(data); let mx = ds_list_xor_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn ds_list_xor_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = ds_list_xor_mean(data); let sd = ds_list_xor_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn ds_list_xor_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn ds_list_xor_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn ds_list_xor_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn ds_list_xor_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn ds_list_xor_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn ds_list_xor_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct DslistxorFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_xor_frame_make(size : Int) -> DslistxorFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_xor_frame_len(s : DslistxorFrame) -> Int { s.size }

pub fn ds_list_xor_frame_get(s : DslistxorFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_xor_frame_set(s : DslistxorFrame, i : Int, v : Double) -> DslistxorFrame {
  let result = ds_list_xor_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_xor_frame_sum(s : DslistxorFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_xor_frame_mean(s : DslistxorFrame) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_xor_frame_sum(s) / s.size.to_double() }
}

pub fn ds_list_xor_frame_scale(s : DslistxorFrame, f : Double) -> DslistxorFrame {
  let result = ds_list_xor_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_xor_frame_add(a : DslistxorFrame, b : DslistxorFrame) -> DslistxorFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_xor_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_xor_frame_copy(s : DslistxorFrame) -> DslistxorFrame {
  let result = ds_list_xor_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_xor_frame_fill(s : DslistxorFrame, v : Double) -> DslistxorFrame {
  let result = ds_list_xor_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_xor_frame_min(s : DslistxorFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_xor_frame_max(s : DslistxorFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_xor_frame_to_string(s : DslistxorFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistxorTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_xor_table_make(size : Int) -> DslistxorTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_xor_table_len(s : DslistxorTable) -> Int { s.size }

pub fn ds_list_xor_table_get(s : DslistxorTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_xor_table_set(s : DslistxorTable, i : Int, v : Double) -> DslistxorTable {
  let result = ds_list_xor_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_xor_table_sum(s : DslistxorTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_xor_table_mean(s : DslistxorTable) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_xor_table_sum(s) / s.size.to_double() }
}

pub fn ds_list_xor_table_scale(s : DslistxorTable, f : Double) -> DslistxorTable {
  let result = ds_list_xor_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_xor_table_add(a : DslistxorTable, b : DslistxorTable) -> DslistxorTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_xor_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_xor_table_copy(s : DslistxorTable) -> DslistxorTable {
  let result = ds_list_xor_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_xor_table_fill(s : DslistxorTable, v : Double) -> DslistxorTable {
  let result = ds_list_xor_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_xor_table_min(s : DslistxorTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_xor_table_max(s : DslistxorTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_xor_table_to_string(s : DslistxorTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistxorGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_xor_graphn_make(size : Int) -> DslistxorGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_xor_graphn_len(s : DslistxorGraphN) -> Int { s.size }

pub fn ds_list_xor_graphn_get(s : DslistxorGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_xor_graphn_set(s : DslistxorGraphN, i : Int, v : Double) -> DslistxorGraphN {
  let result = ds_list_xor_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_xor_graphn_sum(s : DslistxorGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_xor_graphn_mean(s : DslistxorGraphN) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_xor_graphn_sum(s) / s.size.to_double() }
}

pub fn ds_list_xor_graphn_scale(s : DslistxorGraphN, f : Double) -> DslistxorGraphN {
  let result = ds_list_xor_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_xor_graphn_add(a : DslistxorGraphN, b : DslistxorGraphN) -> DslistxorGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_xor_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_xor_graphn_copy(s : DslistxorGraphN) -> DslistxorGraphN {
  let result = ds_list_xor_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_xor_graphn_fill(s : DslistxorGraphN, v : Double) -> DslistxorGraphN {
  let result = ds_list_xor_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_xor_graphn_min(s : DslistxorGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_xor_graphn_max(s : DslistxorGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_xor_graphn_to_string(s : DslistxorGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistxorNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_xor_node_make(size : Int) -> DslistxorNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_xor_node_len(s : DslistxorNode) -> Int { s.size }

pub fn ds_list_xor_node_get(s : DslistxorNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_xor_node_set(s : DslistxorNode, i : Int, v : Double) -> DslistxorNode {
  let result = ds_list_xor_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_xor_node_sum(s : DslistxorNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_xor_node_mean(s : DslistxorNode) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_xor_node_sum(s) / s.size.to_double() }
}

pub fn ds_list_xor_node_scale(s : DslistxorNode, f : Double) -> DslistxorNode {
  let result = ds_list_xor_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_xor_node_add(a : DslistxorNode, b : DslistxorNode) -> DslistxorNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_xor_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_xor_node_copy(s : DslistxorNode) -> DslistxorNode {
  let result = ds_list_xor_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_xor_node_fill(s : DslistxorNode, v : Double) -> DslistxorNode {
  let result = ds_list_xor_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_xor_node_min(s : DslistxorNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_xor_node_max(s : DslistxorNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_xor_node_to_string(s : DslistxorNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistxorEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_xor_edge_make(size : Int) -> DslistxorEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_xor_edge_len(s : DslistxorEdge) -> Int { s.size }

pub fn ds_list_xor_edge_get(s : DslistxorEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_xor_edge_set(s : DslistxorEdge, i : Int, v : Double) -> DslistxorEdge {
  let result = ds_list_xor_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_xor_edge_sum(s : DslistxorEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_xor_edge_mean(s : DslistxorEdge) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_xor_edge_sum(s) / s.size.to_double() }
}

pub fn ds_list_xor_edge_scale(s : DslistxorEdge, f : Double) -> DslistxorEdge {
  let result = ds_list_xor_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_xor_edge_add(a : DslistxorEdge, b : DslistxorEdge) -> DslistxorEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_xor_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_xor_edge_copy(s : DslistxorEdge) -> DslistxorEdge {
  let result = ds_list_xor_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_xor_edge_fill(s : DslistxorEdge, v : Double) -> DslistxorEdge {
  let result = ds_list_xor_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_xor_edge_min(s : DslistxorEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_xor_edge_max(s : DslistxorEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_xor_edge_to_string(s : DslistxorEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistxorPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_xor_path_make(size : Int) -> DslistxorPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_xor_path_len(s : DslistxorPath) -> Int { s.size }

pub fn ds_list_xor_path_get(s : DslistxorPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_xor_path_set(s : DslistxorPath, i : Int, v : Double) -> DslistxorPath {
  let result = ds_list_xor_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_xor_path_sum(s : DslistxorPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_xor_path_mean(s : DslistxorPath) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_xor_path_sum(s) / s.size.to_double() }
}

pub fn ds_list_xor_path_scale(s : DslistxorPath, f : Double) -> DslistxorPath {
  let result = ds_list_xor_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_xor_path_add(a : DslistxorPath, b : DslistxorPath) -> DslistxorPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_xor_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_xor_path_copy(s : DslistxorPath) -> DslistxorPath {
  let result = ds_list_xor_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_xor_path_fill(s : DslistxorPath, v : Double) -> DslistxorPath {
  let result = ds_list_xor_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_xor_path_min(s : DslistxorPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_xor_path_max(s : DslistxorPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_xor_path_to_string(s : DslistxorPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistxorCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_xor_cluster_make(size : Int) -> DslistxorCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_xor_cluster_len(s : DslistxorCluster) -> Int { s.size }

pub fn ds_list_xor_cluster_get(s : DslistxorCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_xor_cluster_set(s : DslistxorCluster, i : Int, v : Double) -> DslistxorCluster {
  let result = ds_list_xor_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_xor_cluster_sum(s : DslistxorCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_xor_cluster_mean(s : DslistxorCluster) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_xor_cluster_sum(s) / s.size.to_double() }
}

pub fn ds_list_xor_cluster_scale(s : DslistxorCluster, f : Double) -> DslistxorCluster {
  let result = ds_list_xor_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_xor_cluster_add(a : DslistxorCluster, b : DslistxorCluster) -> DslistxorCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_xor_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_xor_cluster_copy(s : DslistxorCluster) -> DslistxorCluster {
  let result = ds_list_xor_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_xor_cluster_fill(s : DslistxorCluster, v : Double) -> DslistxorCluster {
  let result = ds_list_xor_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_xor_cluster_min(s : DslistxorCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_xor_cluster_max(s : DslistxorCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_xor_cluster_to_string(s : DslistxorCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistxorModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_xor_model_make(size : Int) -> DslistxorModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_xor_model_len(s : DslistxorModel) -> Int { s.size }

pub fn ds_list_xor_model_get(s : DslistxorModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_xor_model_set(s : DslistxorModel, i : Int, v : Double) -> DslistxorModel {
  let result = ds_list_xor_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_xor_model_sum(s : DslistxorModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_xor_model_mean(s : DslistxorModel) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_xor_model_sum(s) / s.size.to_double() }
}

pub fn ds_list_xor_model_scale(s : DslistxorModel, f : Double) -> DslistxorModel {
  let result = ds_list_xor_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_xor_model_add(a : DslistxorModel, b : DslistxorModel) -> DslistxorModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_xor_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_xor_model_copy(s : DslistxorModel) -> DslistxorModel {
  let result = ds_list_xor_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_xor_model_fill(s : DslistxorModel, v : Double) -> DslistxorModel {
  let result = ds_list_xor_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_xor_model_min(s : DslistxorModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_xor_model_max(s : DslistxorModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_xor_model_to_string(s : DslistxorModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistxorLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_xor_layer_make(size : Int) -> DslistxorLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_xor_layer_len(s : DslistxorLayer) -> Int { s.size }

pub fn ds_list_xor_layer_get(s : DslistxorLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_xor_layer_set(s : DslistxorLayer, i : Int, v : Double) -> DslistxorLayer {
  let result = ds_list_xor_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_xor_layer_sum(s : DslistxorLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_xor_layer_mean(s : DslistxorLayer) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_xor_layer_sum(s) / s.size.to_double() }
}

pub fn ds_list_xor_layer_scale(s : DslistxorLayer, f : Double) -> DslistxorLayer {
  let result = ds_list_xor_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_xor_layer_add(a : DslistxorLayer, b : DslistxorLayer) -> DslistxorLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_xor_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_xor_layer_copy(s : DslistxorLayer) -> DslistxorLayer {
  let result = ds_list_xor_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_xor_layer_fill(s : DslistxorLayer, v : Double) -> DslistxorLayer {
  let result = ds_list_xor_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_xor_layer_min(s : DslistxorLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_xor_layer_max(s : DslistxorLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_xor_layer_to_string(s : DslistxorLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistxorBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_xor_buffer_make(size : Int) -> DslistxorBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_xor_buffer_len(s : DslistxorBuffer) -> Int { s.size }

pub fn ds_list_xor_buffer_get(s : DslistxorBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_xor_buffer_set(s : DslistxorBuffer, i : Int, v : Double) -> DslistxorBuffer {
  let result = ds_list_xor_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_xor_buffer_sum(s : DslistxorBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_xor_buffer_mean(s : DslistxorBuffer) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_xor_buffer_sum(s) / s.size.to_double() }
}

pub fn ds_list_xor_buffer_scale(s : DslistxorBuffer, f : Double) -> DslistxorBuffer {
  let result = ds_list_xor_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_xor_buffer_add(a : DslistxorBuffer, b : DslistxorBuffer) -> DslistxorBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_xor_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_xor_buffer_copy(s : DslistxorBuffer) -> DslistxorBuffer {
  let result = ds_list_xor_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_xor_buffer_fill(s : DslistxorBuffer, v : Double) -> DslistxorBuffer {
  let result = ds_list_xor_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_xor_buffer_min(s : DslistxorBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_xor_buffer_max(s : DslistxorBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_xor_buffer_to_string(s : DslistxorBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistxorCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_xor_cursor_make(size : Int) -> DslistxorCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_xor_cursor_len(s : DslistxorCursor) -> Int { s.size }

pub fn ds_list_xor_cursor_get(s : DslistxorCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_xor_cursor_set(s : DslistxorCursor, i : Int, v : Double) -> DslistxorCursor {
  let result = ds_list_xor_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_xor_cursor_sum(s : DslistxorCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_xor_cursor_mean(s : DslistxorCursor) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_xor_cursor_sum(s) / s.size.to_double() }
}

pub fn ds_list_xor_cursor_scale(s : DslistxorCursor, f : Double) -> DslistxorCursor {
  let result = ds_list_xor_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_xor_cursor_add(a : DslistxorCursor, b : DslistxorCursor) -> DslistxorCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_xor_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_xor_cursor_copy(s : DslistxorCursor) -> DslistxorCursor {
  let result = ds_list_xor_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_xor_cursor_fill(s : DslistxorCursor, v : Double) -> DslistxorCursor {
  let result = ds_list_xor_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_xor_cursor_min(s : DslistxorCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_xor_cursor_max(s : DslistxorCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_xor_cursor_to_string(s : DslistxorCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistxorView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_xor_view_make(size : Int) -> DslistxorView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_xor_view_len(s : DslistxorView) -> Int { s.size }

pub fn ds_list_xor_view_get(s : DslistxorView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_xor_view_set(s : DslistxorView, i : Int, v : Double) -> DslistxorView {
  let result = ds_list_xor_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_xor_view_sum(s : DslistxorView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_xor_view_mean(s : DslistxorView) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_xor_view_sum(s) / s.size.to_double() }
}

pub fn ds_list_xor_view_scale(s : DslistxorView, f : Double) -> DslistxorView {
  let result = ds_list_xor_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_xor_view_add(a : DslistxorView, b : DslistxorView) -> DslistxorView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_xor_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_xor_view_copy(s : DslistxorView) -> DslistxorView {
  let result = ds_list_xor_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_xor_view_fill(s : DslistxorView, v : Double) -> DslistxorView {
  let result = ds_list_xor_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_xor_view_min(s : DslistxorView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_xor_view_max(s : DslistxorView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_xor_view_to_string(s : DslistxorView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistxorRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_xor_range_make(size : Int) -> DslistxorRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_xor_range_len(s : DslistxorRange) -> Int { s.size }

pub fn ds_list_xor_range_get(s : DslistxorRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_xor_range_set(s : DslistxorRange, i : Int, v : Double) -> DslistxorRange {
  let result = ds_list_xor_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_xor_range_sum(s : DslistxorRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_xor_range_mean(s : DslistxorRange) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_xor_range_sum(s) / s.size.to_double() }
}

pub fn ds_list_xor_range_scale(s : DslistxorRange, f : Double) -> DslistxorRange {
  let result = ds_list_xor_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_xor_range_add(a : DslistxorRange, b : DslistxorRange) -> DslistxorRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_xor_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_xor_range_copy(s : DslistxorRange) -> DslistxorRange {
  let result = ds_list_xor_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_xor_range_fill(s : DslistxorRange, v : Double) -> DslistxorRange {
  let result = ds_list_xor_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_xor_range_min(s : DslistxorRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_xor_range_max(s : DslistxorRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_xor_range_to_string(s : DslistxorRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistxorSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_xor_slice_make(size : Int) -> DslistxorSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_xor_slice_len(s : DslistxorSlice) -> Int { s.size }

pub fn ds_list_xor_slice_get(s : DslistxorSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_xor_slice_set(s : DslistxorSlice, i : Int, v : Double) -> DslistxorSlice {
  let result = ds_list_xor_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_xor_slice_sum(s : DslistxorSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_xor_slice_mean(s : DslistxorSlice) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_xor_slice_sum(s) / s.size.to_double() }
}

pub fn ds_list_xor_slice_scale(s : DslistxorSlice, f : Double) -> DslistxorSlice {
  let result = ds_list_xor_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_xor_slice_add(a : DslistxorSlice, b : DslistxorSlice) -> DslistxorSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_xor_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_xor_slice_copy(s : DslistxorSlice) -> DslistxorSlice {
  let result = ds_list_xor_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_xor_slice_fill(s : DslistxorSlice, v : Double) -> DslistxorSlice {
  let result = ds_list_xor_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_xor_slice_min(s : DslistxorSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_xor_slice_max(s : DslistxorSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_xor_slice_to_string(s : DslistxorSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


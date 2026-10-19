///===
/// extcore/bio_struct_volume

pub(all) struct BiostructvolumePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn bio_struct_volume_make_point(x : Double, y : Double) -> BiostructvolumePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn bio_struct_volume_make_point3(x : Double, y : Double, z : Double) -> BiostructvolumePoint {
  { x, y, z, label: 0 }
}

pub fn bio_struct_volume_point_x(pt : BiostructvolumePoint) -> Double { pt.x }

pub fn bio_struct_volume_point_y(pt : BiostructvolumePoint) -> Double { pt.y }

pub fn bio_struct_volume_point_z(pt : BiostructvolumePoint) -> Double { pt.z }

pub fn bio_struct_volume_point_label(pt : BiostructvolumePoint) -> Int { pt.label }

pub fn bio_struct_volume_point_dist(a : BiostructvolumePoint, b : BiostructvolumePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn bio_struct_volume_point_add(a : BiostructvolumePoint, b : BiostructvolumePoint) -> BiostructvolumePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn bio_struct_volume_point_sub(a : BiostructvolumePoint, b : BiostructvolumePoint) -> BiostructvolumePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn bio_struct_volume_point_scale(pt : BiostructvolumePoint, s : Double) -> BiostructvolumePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn bio_struct_volume_point_dot(a : BiostructvolumePoint, b : BiostructvolumePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn bio_struct_volume_point_cross(a : BiostructvolumePoint, b : BiostructvolumePoint) -> BiostructvolumePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn bio_struct_volume_point_norm(pt : BiostructvolumePoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn bio_struct_volume_point_normalize(pt : BiostructvolumePoint) -> BiostructvolumePoint {
  let n = bio_struct_volume_point_norm(pt)
  if n < 0.0000001 { pt } else { bio_struct_volume_point_scale(pt, 1.0 / n) }
}

pub fn bio_struct_volume_point_negate(pt : BiostructvolumePoint) -> BiostructvolumePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn bio_struct_volume_point_mid(a : BiostructvolumePoint, b : BiostructvolumePoint) -> BiostructvolumePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn bio_struct_volume_point_lerp(a : BiostructvolumePoint, b : BiostructvolumePoint, t : Double) -> BiostructvolumePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn bio_struct_volume_point_to_string(pt : BiostructvolumePoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct BiostructvolumeSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn bio_struct_volume_make_series(vals : Array[Double], name : String) -> BiostructvolumeSeries {
  { vals, name, meta: 0 }
}

pub fn bio_struct_volume_series_len(s : BiostructvolumeSeries) -> Int { s.vals.length() }

pub fn bio_struct_volume_series_sum(s : BiostructvolumeSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn bio_struct_volume_series_mean(s : BiostructvolumeSeries) -> Double {
  let n = bio_struct_volume_series_len(s)
  if n == 0 { 0.0 } else { bio_struct_volume_series_sum(s) / n.to_double() }
}

pub fn bio_struct_volume_series_min(s : BiostructvolumeSeries) -> Double {
  let n = bio_struct_volume_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn bio_struct_volume_series_max(s : BiostructvolumeSeries) -> Double {
  let n = bio_struct_volume_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn bio_struct_volume_series_range(s : BiostructvolumeSeries) -> Double {
  bio_struct_volume_series_max(s) - bio_struct_volume_series_min(s)
}

pub fn bio_struct_volume_series_var(s : BiostructvolumeSeries) -> Double {
  let n = bio_struct_volume_series_len(s)
  if n == 0 { 0.0 } else {
    let m = bio_struct_volume_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn bio_struct_volume_series_std(s : BiostructvolumeSeries) -> Double { @_common.sqrt(bio_struct_volume_series_var(s)) }

pub fn bio_struct_volume_series_median(s : BiostructvolumeSeries) -> Double {
  let n = bio_struct_volume_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = bio_struct_volume_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn bio_struct_volume_series_scale(s : BiostructvolumeSeries, f : Double) -> BiostructvolumeSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn bio_struct_volume_series_add(a : BiostructvolumeSeries, b : BiostructvolumeSeries) -> BiostructvolumeSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn bio_struct_volume_series_sub(a : BiostructvolumeSeries, b : BiostructvolumeSeries) -> BiostructvolumeSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn bio_struct_volume_series_normalize(s : BiostructvolumeSeries) -> BiostructvolumeSeries {
  let mn = bio_struct_volume_series_min(s)
  let mx = bio_struct_volume_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn bio_struct_volume_series_cumsum(s : BiostructvolumeSeries) -> BiostructvolumeSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn bio_struct_volume_series_to_string(s : BiostructvolumeSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BiostructvolumeMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn bio_struct_volume_make_matrix(rows : Int, cols : Int, val : Double) -> BiostructvolumeMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn bio_struct_volume_matrix_identity(n : Int) -> BiostructvolumeMatrix {
  let m = bio_struct_volume_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn bio_struct_volume_matrix_get(m : BiostructvolumeMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn bio_struct_volume_matrix_transpose(m : BiostructvolumeMatrix) -> BiostructvolumeMatrix {
  let result = bio_struct_volume_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn bio_struct_volume_matrix_add(a : BiostructvolumeMatrix, b : BiostructvolumeMatrix) -> BiostructvolumeMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = bio_struct_volume_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn bio_struct_volume_matrix_scale(m : BiostructvolumeMatrix, s : Double) -> BiostructvolumeMatrix {
  let result = bio_struct_volume_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn bio_struct_volume_matrix_multiply(a : BiostructvolumeMatrix, b : BiostructvolumeMatrix) -> BiostructvolumeMatrix {
  if a.cols != b.rows { return bio_struct_volume_make_matrix(a.rows, b.cols, 0.0) }
  let result = bio_struct_volume_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn bio_struct_volume_matrix_trace(m : BiostructvolumeMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn bio_struct_volume_matrix_det(m : BiostructvolumeMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn bio_struct_volume_matrix_norm(m : BiostructvolumeMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn bio_struct_volume_matrix_to_string(m : BiostructvolumeMatrix) -> String {
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

pub(all) struct BiostructvolumeVector {
  comps : Array[Double]
  dim : Int
}

pub fn bio_struct_volume_make_vector(comps : Array[Double]) -> BiostructvolumeVector {
  { comps, dim: comps.length() }
}

pub fn bio_struct_volume_vector_zero(dim : Int) -> BiostructvolumeVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn bio_struct_volume_vector_add(a : BiostructvolumeVector, b : BiostructvolumeVector) -> BiostructvolumeVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn bio_struct_volume_vector_sub(a : BiostructvolumeVector, b : BiostructvolumeVector) -> BiostructvolumeVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn bio_struct_volume_vector_scale(v : BiostructvolumeVector, s : Double) -> BiostructvolumeVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn bio_struct_volume_vector_dot(a : BiostructvolumeVector, b : BiostructvolumeVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn bio_struct_volume_vector_norm(v : BiostructvolumeVector) -> Double { @_common.sqrt(bio_struct_volume_vector_dot(v, v)) }

pub fn bio_struct_volume_vector_normalize(v : BiostructvolumeVector) -> BiostructvolumeVector {
  let n = bio_struct_volume_vector_norm(v)
  if n < 0.0000001 { v } else { bio_struct_volume_vector_scale(v, 1.0 / n) }
}

pub fn bio_struct_volume_vector_dist(a : BiostructvolumeVector, b : BiostructvolumeVector) -> Double {
  bio_struct_volume_vector_norm(bio_struct_volume_vector_sub(a, b))
}

pub fn bio_struct_volume_vector_to_string(v : BiostructvolumeVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn bio_struct_volume_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn bio_struct_volume_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = bio_struct_volume_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn bio_struct_volume_std(data : Array[Double]) -> Double { @_common.sqrt(bio_struct_volume_var(data)) }

pub fn bio_struct_volume_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = bio_struct_volume_mean(a); let mb = bio_struct_volume_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn bio_struct_volume_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = bio_struct_volume_std(a); let sb = bio_struct_volume_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { bio_struct_volume_cov(a, b) / (sa * sb) }
}

pub fn bio_struct_volume_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = bio_struct_volume_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn bio_struct_volume_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn bio_struct_volume_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn bio_struct_volume_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(bio_struct_volume_mse(pred, labels))
}

pub fn bio_struct_volume_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn bio_struct_volume_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = bio_struct_volume_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn bio_struct_volume_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn bio_struct_volume_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn bio_struct_volume_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = bio_struct_volume_precision(pred, labels, pos); let r = bio_struct_volume_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn bio_struct_volume_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn bio_struct_volume_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = bio_struct_volume_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn bio_struct_volume_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn bio_struct_volume_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn bio_struct_volume_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = bio_struct_volume_gcd(a, b)
    (a / g) * b
  }
}

pub fn bio_struct_volume_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn bio_struct_volume_fibonacci(n : Int) -> Int {
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

pub fn bio_struct_volume_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = bio_struct_volume_min(data); let mx = bio_struct_volume_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn bio_struct_volume_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = bio_struct_volume_mean(data); let sd = bio_struct_volume_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn bio_struct_volume_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn bio_struct_volume_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn bio_struct_volume_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn bio_struct_volume_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn bio_struct_volume_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn bio_struct_volume_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct BiostructvolumeFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_volume_frame_make(size : Int) -> BiostructvolumeFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_volume_frame_len(s : BiostructvolumeFrame) -> Int { s.size }

pub fn bio_struct_volume_frame_get(s : BiostructvolumeFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_volume_frame_set(s : BiostructvolumeFrame, i : Int, v : Double) -> BiostructvolumeFrame {
  let result = bio_struct_volume_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_volume_frame_sum(s : BiostructvolumeFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_struct_volume_frame_mean(s : BiostructvolumeFrame) -> Double {
  if s.size == 0 { 0.0 } else { bio_struct_volume_frame_sum(s) / s.size.to_double() }
}

pub fn bio_struct_volume_frame_scale(s : BiostructvolumeFrame, f : Double) -> BiostructvolumeFrame {
  let result = bio_struct_volume_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_struct_volume_frame_add(a : BiostructvolumeFrame, b : BiostructvolumeFrame) -> BiostructvolumeFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_struct_volume_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_struct_volume_frame_copy(s : BiostructvolumeFrame) -> BiostructvolumeFrame {
  let result = bio_struct_volume_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_struct_volume_frame_fill(s : BiostructvolumeFrame, v : Double) -> BiostructvolumeFrame {
  let result = bio_struct_volume_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_struct_volume_frame_min(s : BiostructvolumeFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_volume_frame_max(s : BiostructvolumeFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_volume_frame_to_string(s : BiostructvolumeFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructvolumeTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_volume_table_make(size : Int) -> BiostructvolumeTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_volume_table_len(s : BiostructvolumeTable) -> Int { s.size }

pub fn bio_struct_volume_table_get(s : BiostructvolumeTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_volume_table_set(s : BiostructvolumeTable, i : Int, v : Double) -> BiostructvolumeTable {
  let result = bio_struct_volume_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_volume_table_sum(s : BiostructvolumeTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_struct_volume_table_mean(s : BiostructvolumeTable) -> Double {
  if s.size == 0 { 0.0 } else { bio_struct_volume_table_sum(s) / s.size.to_double() }
}

pub fn bio_struct_volume_table_scale(s : BiostructvolumeTable, f : Double) -> BiostructvolumeTable {
  let result = bio_struct_volume_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_struct_volume_table_add(a : BiostructvolumeTable, b : BiostructvolumeTable) -> BiostructvolumeTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_struct_volume_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_struct_volume_table_copy(s : BiostructvolumeTable) -> BiostructvolumeTable {
  let result = bio_struct_volume_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_struct_volume_table_fill(s : BiostructvolumeTable, v : Double) -> BiostructvolumeTable {
  let result = bio_struct_volume_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_struct_volume_table_min(s : BiostructvolumeTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_volume_table_max(s : BiostructvolumeTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_volume_table_to_string(s : BiostructvolumeTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructvolumeGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_volume_graphn_make(size : Int) -> BiostructvolumeGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_volume_graphn_len(s : BiostructvolumeGraphN) -> Int { s.size }

pub fn bio_struct_volume_graphn_get(s : BiostructvolumeGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_volume_graphn_set(s : BiostructvolumeGraphN, i : Int, v : Double) -> BiostructvolumeGraphN {
  let result = bio_struct_volume_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_volume_graphn_sum(s : BiostructvolumeGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_struct_volume_graphn_mean(s : BiostructvolumeGraphN) -> Double {
  if s.size == 0 { 0.0 } else { bio_struct_volume_graphn_sum(s) / s.size.to_double() }
}

pub fn bio_struct_volume_graphn_scale(s : BiostructvolumeGraphN, f : Double) -> BiostructvolumeGraphN {
  let result = bio_struct_volume_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_struct_volume_graphn_add(a : BiostructvolumeGraphN, b : BiostructvolumeGraphN) -> BiostructvolumeGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_struct_volume_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_struct_volume_graphn_copy(s : BiostructvolumeGraphN) -> BiostructvolumeGraphN {
  let result = bio_struct_volume_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_struct_volume_graphn_fill(s : BiostructvolumeGraphN, v : Double) -> BiostructvolumeGraphN {
  let result = bio_struct_volume_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_struct_volume_graphn_min(s : BiostructvolumeGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_volume_graphn_max(s : BiostructvolumeGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_volume_graphn_to_string(s : BiostructvolumeGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructvolumeNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_volume_node_make(size : Int) -> BiostructvolumeNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_volume_node_len(s : BiostructvolumeNode) -> Int { s.size }

pub fn bio_struct_volume_node_get(s : BiostructvolumeNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_volume_node_set(s : BiostructvolumeNode, i : Int, v : Double) -> BiostructvolumeNode {
  let result = bio_struct_volume_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_volume_node_sum(s : BiostructvolumeNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_struct_volume_node_mean(s : BiostructvolumeNode) -> Double {
  if s.size == 0 { 0.0 } else { bio_struct_volume_node_sum(s) / s.size.to_double() }
}

pub fn bio_struct_volume_node_scale(s : BiostructvolumeNode, f : Double) -> BiostructvolumeNode {
  let result = bio_struct_volume_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_struct_volume_node_add(a : BiostructvolumeNode, b : BiostructvolumeNode) -> BiostructvolumeNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_struct_volume_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_struct_volume_node_copy(s : BiostructvolumeNode) -> BiostructvolumeNode {
  let result = bio_struct_volume_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_struct_volume_node_fill(s : BiostructvolumeNode, v : Double) -> BiostructvolumeNode {
  let result = bio_struct_volume_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_struct_volume_node_min(s : BiostructvolumeNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_volume_node_max(s : BiostructvolumeNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_volume_node_to_string(s : BiostructvolumeNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructvolumeEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_volume_edge_make(size : Int) -> BiostructvolumeEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_volume_edge_len(s : BiostructvolumeEdge) -> Int { s.size }

pub fn bio_struct_volume_edge_get(s : BiostructvolumeEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_volume_edge_set(s : BiostructvolumeEdge, i : Int, v : Double) -> BiostructvolumeEdge {
  let result = bio_struct_volume_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_volume_edge_sum(s : BiostructvolumeEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_struct_volume_edge_mean(s : BiostructvolumeEdge) -> Double {
  if s.size == 0 { 0.0 } else { bio_struct_volume_edge_sum(s) / s.size.to_double() }
}

pub fn bio_struct_volume_edge_scale(s : BiostructvolumeEdge, f : Double) -> BiostructvolumeEdge {
  let result = bio_struct_volume_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_struct_volume_edge_add(a : BiostructvolumeEdge, b : BiostructvolumeEdge) -> BiostructvolumeEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_struct_volume_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_struct_volume_edge_copy(s : BiostructvolumeEdge) -> BiostructvolumeEdge {
  let result = bio_struct_volume_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_struct_volume_edge_fill(s : BiostructvolumeEdge, v : Double) -> BiostructvolumeEdge {
  let result = bio_struct_volume_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_struct_volume_edge_min(s : BiostructvolumeEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_volume_edge_max(s : BiostructvolumeEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_volume_edge_to_string(s : BiostructvolumeEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructvolumePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_volume_path_make(size : Int) -> BiostructvolumePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_volume_path_len(s : BiostructvolumePath) -> Int { s.size }

pub fn bio_struct_volume_path_get(s : BiostructvolumePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_volume_path_set(s : BiostructvolumePath, i : Int, v : Double) -> BiostructvolumePath {
  let result = bio_struct_volume_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_volume_path_sum(s : BiostructvolumePath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_struct_volume_path_mean(s : BiostructvolumePath) -> Double {
  if s.size == 0 { 0.0 } else { bio_struct_volume_path_sum(s) / s.size.to_double() }
}

pub fn bio_struct_volume_path_scale(s : BiostructvolumePath, f : Double) -> BiostructvolumePath {
  let result = bio_struct_volume_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_struct_volume_path_add(a : BiostructvolumePath, b : BiostructvolumePath) -> BiostructvolumePath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_struct_volume_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_struct_volume_path_copy(s : BiostructvolumePath) -> BiostructvolumePath {
  let result = bio_struct_volume_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_struct_volume_path_fill(s : BiostructvolumePath, v : Double) -> BiostructvolumePath {
  let result = bio_struct_volume_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_struct_volume_path_min(s : BiostructvolumePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_volume_path_max(s : BiostructvolumePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_volume_path_to_string(s : BiostructvolumePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructvolumeCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_volume_cluster_make(size : Int) -> BiostructvolumeCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_volume_cluster_len(s : BiostructvolumeCluster) -> Int { s.size }

pub fn bio_struct_volume_cluster_get(s : BiostructvolumeCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_volume_cluster_set(s : BiostructvolumeCluster, i : Int, v : Double) -> BiostructvolumeCluster {
  let result = bio_struct_volume_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_volume_cluster_sum(s : BiostructvolumeCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_struct_volume_cluster_mean(s : BiostructvolumeCluster) -> Double {
  if s.size == 0 { 0.0 } else { bio_struct_volume_cluster_sum(s) / s.size.to_double() }
}

pub fn bio_struct_volume_cluster_scale(s : BiostructvolumeCluster, f : Double) -> BiostructvolumeCluster {
  let result = bio_struct_volume_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_struct_volume_cluster_add(a : BiostructvolumeCluster, b : BiostructvolumeCluster) -> BiostructvolumeCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_struct_volume_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_struct_volume_cluster_copy(s : BiostructvolumeCluster) -> BiostructvolumeCluster {
  let result = bio_struct_volume_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_struct_volume_cluster_fill(s : BiostructvolumeCluster, v : Double) -> BiostructvolumeCluster {
  let result = bio_struct_volume_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_struct_volume_cluster_min(s : BiostructvolumeCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_volume_cluster_max(s : BiostructvolumeCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_volume_cluster_to_string(s : BiostructvolumeCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructvolumeModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_volume_model_make(size : Int) -> BiostructvolumeModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_volume_model_len(s : BiostructvolumeModel) -> Int { s.size }

pub fn bio_struct_volume_model_get(s : BiostructvolumeModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_volume_model_set(s : BiostructvolumeModel, i : Int, v : Double) -> BiostructvolumeModel {
  let result = bio_struct_volume_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_volume_model_sum(s : BiostructvolumeModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_struct_volume_model_mean(s : BiostructvolumeModel) -> Double {
  if s.size == 0 { 0.0 } else { bio_struct_volume_model_sum(s) / s.size.to_double() }
}

pub fn bio_struct_volume_model_scale(s : BiostructvolumeModel, f : Double) -> BiostructvolumeModel {
  let result = bio_struct_volume_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_struct_volume_model_add(a : BiostructvolumeModel, b : BiostructvolumeModel) -> BiostructvolumeModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_struct_volume_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_struct_volume_model_copy(s : BiostructvolumeModel) -> BiostructvolumeModel {
  let result = bio_struct_volume_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_struct_volume_model_fill(s : BiostructvolumeModel, v : Double) -> BiostructvolumeModel {
  let result = bio_struct_volume_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_struct_volume_model_min(s : BiostructvolumeModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_volume_model_max(s : BiostructvolumeModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_volume_model_to_string(s : BiostructvolumeModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructvolumeLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_volume_layer_make(size : Int) -> BiostructvolumeLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_volume_layer_len(s : BiostructvolumeLayer) -> Int { s.size }

pub fn bio_struct_volume_layer_get(s : BiostructvolumeLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_volume_layer_set(s : BiostructvolumeLayer, i : Int, v : Double) -> BiostructvolumeLayer {
  let result = bio_struct_volume_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_volume_layer_sum(s : BiostructvolumeLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_struct_volume_layer_mean(s : BiostructvolumeLayer) -> Double {
  if s.size == 0 { 0.0 } else { bio_struct_volume_layer_sum(s) / s.size.to_double() }
}

pub fn bio_struct_volume_layer_scale(s : BiostructvolumeLayer, f : Double) -> BiostructvolumeLayer {
  let result = bio_struct_volume_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_struct_volume_layer_add(a : BiostructvolumeLayer, b : BiostructvolumeLayer) -> BiostructvolumeLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_struct_volume_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_struct_volume_layer_copy(s : BiostructvolumeLayer) -> BiostructvolumeLayer {
  let result = bio_struct_volume_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_struct_volume_layer_fill(s : BiostructvolumeLayer, v : Double) -> BiostructvolumeLayer {
  let result = bio_struct_volume_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_struct_volume_layer_min(s : BiostructvolumeLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_volume_layer_max(s : BiostructvolumeLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_volume_layer_to_string(s : BiostructvolumeLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructvolumeBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_volume_buffer_make(size : Int) -> BiostructvolumeBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_volume_buffer_len(s : BiostructvolumeBuffer) -> Int { s.size }

pub fn bio_struct_volume_buffer_get(s : BiostructvolumeBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_volume_buffer_set(s : BiostructvolumeBuffer, i : Int, v : Double) -> BiostructvolumeBuffer {
  let result = bio_struct_volume_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_volume_buffer_sum(s : BiostructvolumeBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_struct_volume_buffer_mean(s : BiostructvolumeBuffer) -> Double {
  if s.size == 0 { 0.0 } else { bio_struct_volume_buffer_sum(s) / s.size.to_double() }
}

pub fn bio_struct_volume_buffer_scale(s : BiostructvolumeBuffer, f : Double) -> BiostructvolumeBuffer {
  let result = bio_struct_volume_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_struct_volume_buffer_add(a : BiostructvolumeBuffer, b : BiostructvolumeBuffer) -> BiostructvolumeBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_struct_volume_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_struct_volume_buffer_copy(s : BiostructvolumeBuffer) -> BiostructvolumeBuffer {
  let result = bio_struct_volume_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_struct_volume_buffer_fill(s : BiostructvolumeBuffer, v : Double) -> BiostructvolumeBuffer {
  let result = bio_struct_volume_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_struct_volume_buffer_min(s : BiostructvolumeBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_volume_buffer_max(s : BiostructvolumeBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_volume_buffer_to_string(s : BiostructvolumeBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructvolumeCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_volume_cursor_make(size : Int) -> BiostructvolumeCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_volume_cursor_len(s : BiostructvolumeCursor) -> Int { s.size }

pub fn bio_struct_volume_cursor_get(s : BiostructvolumeCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_volume_cursor_set(s : BiostructvolumeCursor, i : Int, v : Double) -> BiostructvolumeCursor {
  let result = bio_struct_volume_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_volume_cursor_sum(s : BiostructvolumeCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_struct_volume_cursor_mean(s : BiostructvolumeCursor) -> Double {
  if s.size == 0 { 0.0 } else { bio_struct_volume_cursor_sum(s) / s.size.to_double() }
}

pub fn bio_struct_volume_cursor_scale(s : BiostructvolumeCursor, f : Double) -> BiostructvolumeCursor {
  let result = bio_struct_volume_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_struct_volume_cursor_add(a : BiostructvolumeCursor, b : BiostructvolumeCursor) -> BiostructvolumeCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_struct_volume_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_struct_volume_cursor_copy(s : BiostructvolumeCursor) -> BiostructvolumeCursor {
  let result = bio_struct_volume_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_struct_volume_cursor_fill(s : BiostructvolumeCursor, v : Double) -> BiostructvolumeCursor {
  let result = bio_struct_volume_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_struct_volume_cursor_min(s : BiostructvolumeCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_volume_cursor_max(s : BiostructvolumeCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_volume_cursor_to_string(s : BiostructvolumeCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructvolumeView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_volume_view_make(size : Int) -> BiostructvolumeView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_volume_view_len(s : BiostructvolumeView) -> Int { s.size }

pub fn bio_struct_volume_view_get(s : BiostructvolumeView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_volume_view_set(s : BiostructvolumeView, i : Int, v : Double) -> BiostructvolumeView {
  let result = bio_struct_volume_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_volume_view_sum(s : BiostructvolumeView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_struct_volume_view_mean(s : BiostructvolumeView) -> Double {
  if s.size == 0 { 0.0 } else { bio_struct_volume_view_sum(s) / s.size.to_double() }
}

pub fn bio_struct_volume_view_scale(s : BiostructvolumeView, f : Double) -> BiostructvolumeView {
  let result = bio_struct_volume_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_struct_volume_view_add(a : BiostructvolumeView, b : BiostructvolumeView) -> BiostructvolumeView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_struct_volume_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_struct_volume_view_copy(s : BiostructvolumeView) -> BiostructvolumeView {
  let result = bio_struct_volume_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_struct_volume_view_fill(s : BiostructvolumeView, v : Double) -> BiostructvolumeView {
  let result = bio_struct_volume_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_struct_volume_view_min(s : BiostructvolumeView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_volume_view_max(s : BiostructvolumeView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_volume_view_to_string(s : BiostructvolumeView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructvolumeRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_volume_range_make(size : Int) -> BiostructvolumeRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_volume_range_len(s : BiostructvolumeRange) -> Int { s.size }

pub fn bio_struct_volume_range_get(s : BiostructvolumeRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_volume_range_set(s : BiostructvolumeRange, i : Int, v : Double) -> BiostructvolumeRange {
  let result = bio_struct_volume_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_volume_range_sum(s : BiostructvolumeRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_struct_volume_range_mean(s : BiostructvolumeRange) -> Double {
  if s.size == 0 { 0.0 } else { bio_struct_volume_range_sum(s) / s.size.to_double() }
}

pub fn bio_struct_volume_range_scale(s : BiostructvolumeRange, f : Double) -> BiostructvolumeRange {
  let result = bio_struct_volume_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_struct_volume_range_add(a : BiostructvolumeRange, b : BiostructvolumeRange) -> BiostructvolumeRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_struct_volume_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_struct_volume_range_copy(s : BiostructvolumeRange) -> BiostructvolumeRange {
  let result = bio_struct_volume_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_struct_volume_range_fill(s : BiostructvolumeRange, v : Double) -> BiostructvolumeRange {
  let result = bio_struct_volume_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_struct_volume_range_min(s : BiostructvolumeRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_volume_range_max(s : BiostructvolumeRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_volume_range_to_string(s : BiostructvolumeRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructvolumeSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_volume_slice_make(size : Int) -> BiostructvolumeSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_volume_slice_len(s : BiostructvolumeSlice) -> Int { s.size }

pub fn bio_struct_volume_slice_get(s : BiostructvolumeSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_volume_slice_set(s : BiostructvolumeSlice, i : Int, v : Double) -> BiostructvolumeSlice {
  let result = bio_struct_volume_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_volume_slice_sum(s : BiostructvolumeSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_struct_volume_slice_mean(s : BiostructvolumeSlice) -> Double {
  if s.size == 0 { 0.0 } else { bio_struct_volume_slice_sum(s) / s.size.to_double() }
}

pub fn bio_struct_volume_slice_scale(s : BiostructvolumeSlice, f : Double) -> BiostructvolumeSlice {
  let result = bio_struct_volume_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_struct_volume_slice_add(a : BiostructvolumeSlice, b : BiostructvolumeSlice) -> BiostructvolumeSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_struct_volume_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_struct_volume_slice_copy(s : BiostructvolumeSlice) -> BiostructvolumeSlice {
  let result = bio_struct_volume_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_struct_volume_slice_fill(s : BiostructvolumeSlice, v : Double) -> BiostructvolumeSlice {
  let result = bio_struct_volume_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_struct_volume_slice_min(s : BiostructvolumeSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_volume_slice_max(s : BiostructvolumeSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_volume_slice_to_string(s : BiostructvolumeSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


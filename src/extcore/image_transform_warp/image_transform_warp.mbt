///===
/// extcore/image_transform_warp

pub(all) struct ImagetransformwarpPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_transform_warp_make_point(x : Double, y : Double) -> ImagetransformwarpPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_transform_warp_make_point3(x : Double, y : Double, z : Double) -> ImagetransformwarpPoint {
  { x, y, z, label: 0 }
}

pub fn image_transform_warp_point_x(pt : ImagetransformwarpPoint) -> Double { pt.x }

pub fn image_transform_warp_point_y(pt : ImagetransformwarpPoint) -> Double { pt.y }

pub fn image_transform_warp_point_z(pt : ImagetransformwarpPoint) -> Double { pt.z }

pub fn image_transform_warp_point_label(pt : ImagetransformwarpPoint) -> Int { pt.label }

pub fn image_transform_warp_point_dist(a : ImagetransformwarpPoint, b : ImagetransformwarpPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn image_transform_warp_point_add(a : ImagetransformwarpPoint, b : ImagetransformwarpPoint) -> ImagetransformwarpPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn image_transform_warp_point_sub(a : ImagetransformwarpPoint, b : ImagetransformwarpPoint) -> ImagetransformwarpPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn image_transform_warp_point_scale(pt : ImagetransformwarpPoint, s : Double) -> ImagetransformwarpPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn image_transform_warp_point_dot(a : ImagetransformwarpPoint, b : ImagetransformwarpPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn image_transform_warp_point_cross(a : ImagetransformwarpPoint, b : ImagetransformwarpPoint) -> ImagetransformwarpPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn image_transform_warp_point_norm(pt : ImagetransformwarpPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn image_transform_warp_point_normalize(pt : ImagetransformwarpPoint) -> ImagetransformwarpPoint {
  let n = image_transform_warp_point_norm(pt)
  if n < 0.0000001 { pt } else { image_transform_warp_point_scale(pt, 1.0 / n) }
}

pub fn image_transform_warp_point_negate(pt : ImagetransformwarpPoint) -> ImagetransformwarpPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn image_transform_warp_point_mid(a : ImagetransformwarpPoint, b : ImagetransformwarpPoint) -> ImagetransformwarpPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn image_transform_warp_point_lerp(a : ImagetransformwarpPoint, b : ImagetransformwarpPoint, t : Double) -> ImagetransformwarpPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn image_transform_warp_point_to_string(pt : ImagetransformwarpPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct ImagetransformwarpSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_transform_warp_make_series(vals : Array[Double], name : String) -> ImagetransformwarpSeries {
  { vals, name, meta: 0 }
}

pub fn image_transform_warp_series_len(s : ImagetransformwarpSeries) -> Int { s.vals.length() }

pub fn image_transform_warp_series_sum(s : ImagetransformwarpSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn image_transform_warp_series_mean(s : ImagetransformwarpSeries) -> Double {
  let n = image_transform_warp_series_len(s)
  if n == 0 { 0.0 } else { image_transform_warp_series_sum(s) / n.to_double() }
}

pub fn image_transform_warp_series_min(s : ImagetransformwarpSeries) -> Double {
  let n = image_transform_warp_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn image_transform_warp_series_max(s : ImagetransformwarpSeries) -> Double {
  let n = image_transform_warp_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn image_transform_warp_series_range(s : ImagetransformwarpSeries) -> Double {
  image_transform_warp_series_max(s) - image_transform_warp_series_min(s)
}

pub fn image_transform_warp_series_var(s : ImagetransformwarpSeries) -> Double {
  let n = image_transform_warp_series_len(s)
  if n == 0 { 0.0 } else {
    let m = image_transform_warp_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn image_transform_warp_series_std(s : ImagetransformwarpSeries) -> Double { @_common.sqrt(image_transform_warp_series_var(s)) }

pub fn image_transform_warp_series_median(s : ImagetransformwarpSeries) -> Double {
  let n = image_transform_warp_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = image_transform_warp_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn image_transform_warp_series_scale(s : ImagetransformwarpSeries, f : Double) -> ImagetransformwarpSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn image_transform_warp_series_add(a : ImagetransformwarpSeries, b : ImagetransformwarpSeries) -> ImagetransformwarpSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn image_transform_warp_series_sub(a : ImagetransformwarpSeries, b : ImagetransformwarpSeries) -> ImagetransformwarpSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn image_transform_warp_series_normalize(s : ImagetransformwarpSeries) -> ImagetransformwarpSeries {
  let mn = image_transform_warp_series_min(s)
  let mx = image_transform_warp_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn image_transform_warp_series_cumsum(s : ImagetransformwarpSeries) -> ImagetransformwarpSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn image_transform_warp_series_to_string(s : ImagetransformwarpSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagetransformwarpMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_transform_warp_make_matrix(rows : Int, cols : Int, val : Double) -> ImagetransformwarpMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn image_transform_warp_matrix_identity(n : Int) -> ImagetransformwarpMatrix {
  let m = image_transform_warp_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn image_transform_warp_matrix_get(m : ImagetransformwarpMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn image_transform_warp_matrix_transpose(m : ImagetransformwarpMatrix) -> ImagetransformwarpMatrix {
  let result = image_transform_warp_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn image_transform_warp_matrix_add(a : ImagetransformwarpMatrix, b : ImagetransformwarpMatrix) -> ImagetransformwarpMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = image_transform_warp_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn image_transform_warp_matrix_scale(m : ImagetransformwarpMatrix, s : Double) -> ImagetransformwarpMatrix {
  let result = image_transform_warp_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn image_transform_warp_matrix_multiply(a : ImagetransformwarpMatrix, b : ImagetransformwarpMatrix) -> ImagetransformwarpMatrix {
  if a.cols != b.rows { return image_transform_warp_make_matrix(a.rows, b.cols, 0.0) }
  let result = image_transform_warp_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn image_transform_warp_matrix_trace(m : ImagetransformwarpMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn image_transform_warp_matrix_det(m : ImagetransformwarpMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn image_transform_warp_matrix_norm(m : ImagetransformwarpMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn image_transform_warp_matrix_to_string(m : ImagetransformwarpMatrix) -> String {
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

pub(all) struct ImagetransformwarpVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_transform_warp_make_vector(comps : Array[Double]) -> ImagetransformwarpVector {
  { comps, dim: comps.length() }
}

pub fn image_transform_warp_vector_zero(dim : Int) -> ImagetransformwarpVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn image_transform_warp_vector_add(a : ImagetransformwarpVector, b : ImagetransformwarpVector) -> ImagetransformwarpVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn image_transform_warp_vector_sub(a : ImagetransformwarpVector, b : ImagetransformwarpVector) -> ImagetransformwarpVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn image_transform_warp_vector_scale(v : ImagetransformwarpVector, s : Double) -> ImagetransformwarpVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn image_transform_warp_vector_dot(a : ImagetransformwarpVector, b : ImagetransformwarpVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn image_transform_warp_vector_norm(v : ImagetransformwarpVector) -> Double { @_common.sqrt(image_transform_warp_vector_dot(v, v)) }

pub fn image_transform_warp_vector_normalize(v : ImagetransformwarpVector) -> ImagetransformwarpVector {
  let n = image_transform_warp_vector_norm(v)
  if n < 0.0000001 { v } else { image_transform_warp_vector_scale(v, 1.0 / n) }
}

pub fn image_transform_warp_vector_dist(a : ImagetransformwarpVector, b : ImagetransformwarpVector) -> Double {
  image_transform_warp_vector_norm(image_transform_warp_vector_sub(a, b))
}

pub fn image_transform_warp_vector_to_string(v : ImagetransformwarpVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn image_transform_warp_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn image_transform_warp_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = image_transform_warp_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn image_transform_warp_std(data : Array[Double]) -> Double { @_common.sqrt(image_transform_warp_var(data)) }

pub fn image_transform_warp_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = image_transform_warp_mean(a); let mb = image_transform_warp_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn image_transform_warp_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = image_transform_warp_std(a); let sb = image_transform_warp_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { image_transform_warp_cov(a, b) / (sa * sb) }
}

pub fn image_transform_warp_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = image_transform_warp_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn image_transform_warp_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn image_transform_warp_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn image_transform_warp_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(image_transform_warp_mse(pred, labels))
}

pub fn image_transform_warp_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn image_transform_warp_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = image_transform_warp_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn image_transform_warp_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn image_transform_warp_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn image_transform_warp_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = image_transform_warp_precision(pred, labels, pos); let r = image_transform_warp_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn image_transform_warp_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn image_transform_warp_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = image_transform_warp_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn image_transform_warp_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn image_transform_warp_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn image_transform_warp_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = image_transform_warp_gcd(a, b)
    (a / g) * b
  }
}

pub fn image_transform_warp_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn image_transform_warp_fibonacci(n : Int) -> Int {
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

pub fn image_transform_warp_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = image_transform_warp_min(data); let mx = image_transform_warp_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn image_transform_warp_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = image_transform_warp_mean(data); let sd = image_transform_warp_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn image_transform_warp_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn image_transform_warp_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn image_transform_warp_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn image_transform_warp_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn image_transform_warp_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn image_transform_warp_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct ImagetransformwarpFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_warp_frame_make(size : Int) -> ImagetransformwarpFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_warp_frame_len(s : ImagetransformwarpFrame) -> Int { s.size }

pub fn image_transform_warp_frame_get(s : ImagetransformwarpFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_warp_frame_set(s : ImagetransformwarpFrame, i : Int, v : Double) -> ImagetransformwarpFrame {
  let result = image_transform_warp_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_warp_frame_sum(s : ImagetransformwarpFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_transform_warp_frame_mean(s : ImagetransformwarpFrame) -> Double {
  if s.size == 0 { 0.0 } else { image_transform_warp_frame_sum(s) / s.size.to_double() }
}

pub fn image_transform_warp_frame_scale(s : ImagetransformwarpFrame, f : Double) -> ImagetransformwarpFrame {
  let result = image_transform_warp_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_warp_frame_add(a : ImagetransformwarpFrame, b : ImagetransformwarpFrame) -> ImagetransformwarpFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_warp_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_warp_frame_copy(s : ImagetransformwarpFrame) -> ImagetransformwarpFrame {
  let result = image_transform_warp_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_warp_frame_fill(s : ImagetransformwarpFrame, v : Double) -> ImagetransformwarpFrame {
  let result = image_transform_warp_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_warp_frame_min(s : ImagetransformwarpFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_warp_frame_max(s : ImagetransformwarpFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_warp_frame_to_string(s : ImagetransformwarpFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformwarpTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_warp_table_make(size : Int) -> ImagetransformwarpTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_warp_table_len(s : ImagetransformwarpTable) -> Int { s.size }

pub fn image_transform_warp_table_get(s : ImagetransformwarpTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_warp_table_set(s : ImagetransformwarpTable, i : Int, v : Double) -> ImagetransformwarpTable {
  let result = image_transform_warp_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_warp_table_sum(s : ImagetransformwarpTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_transform_warp_table_mean(s : ImagetransformwarpTable) -> Double {
  if s.size == 0 { 0.0 } else { image_transform_warp_table_sum(s) / s.size.to_double() }
}

pub fn image_transform_warp_table_scale(s : ImagetransformwarpTable, f : Double) -> ImagetransformwarpTable {
  let result = image_transform_warp_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_warp_table_add(a : ImagetransformwarpTable, b : ImagetransformwarpTable) -> ImagetransformwarpTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_warp_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_warp_table_copy(s : ImagetransformwarpTable) -> ImagetransformwarpTable {
  let result = image_transform_warp_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_warp_table_fill(s : ImagetransformwarpTable, v : Double) -> ImagetransformwarpTable {
  let result = image_transform_warp_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_warp_table_min(s : ImagetransformwarpTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_warp_table_max(s : ImagetransformwarpTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_warp_table_to_string(s : ImagetransformwarpTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformwarpGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_warp_graphn_make(size : Int) -> ImagetransformwarpGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_warp_graphn_len(s : ImagetransformwarpGraphN) -> Int { s.size }

pub fn image_transform_warp_graphn_get(s : ImagetransformwarpGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_warp_graphn_set(s : ImagetransformwarpGraphN, i : Int, v : Double) -> ImagetransformwarpGraphN {
  let result = image_transform_warp_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_warp_graphn_sum(s : ImagetransformwarpGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_transform_warp_graphn_mean(s : ImagetransformwarpGraphN) -> Double {
  if s.size == 0 { 0.0 } else { image_transform_warp_graphn_sum(s) / s.size.to_double() }
}

pub fn image_transform_warp_graphn_scale(s : ImagetransformwarpGraphN, f : Double) -> ImagetransformwarpGraphN {
  let result = image_transform_warp_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_warp_graphn_add(a : ImagetransformwarpGraphN, b : ImagetransformwarpGraphN) -> ImagetransformwarpGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_warp_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_warp_graphn_copy(s : ImagetransformwarpGraphN) -> ImagetransformwarpGraphN {
  let result = image_transform_warp_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_warp_graphn_fill(s : ImagetransformwarpGraphN, v : Double) -> ImagetransformwarpGraphN {
  let result = image_transform_warp_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_warp_graphn_min(s : ImagetransformwarpGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_warp_graphn_max(s : ImagetransformwarpGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_warp_graphn_to_string(s : ImagetransformwarpGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformwarpNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_warp_node_make(size : Int) -> ImagetransformwarpNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_warp_node_len(s : ImagetransformwarpNode) -> Int { s.size }

pub fn image_transform_warp_node_get(s : ImagetransformwarpNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_warp_node_set(s : ImagetransformwarpNode, i : Int, v : Double) -> ImagetransformwarpNode {
  let result = image_transform_warp_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_warp_node_sum(s : ImagetransformwarpNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_transform_warp_node_mean(s : ImagetransformwarpNode) -> Double {
  if s.size == 0 { 0.0 } else { image_transform_warp_node_sum(s) / s.size.to_double() }
}

pub fn image_transform_warp_node_scale(s : ImagetransformwarpNode, f : Double) -> ImagetransformwarpNode {
  let result = image_transform_warp_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_warp_node_add(a : ImagetransformwarpNode, b : ImagetransformwarpNode) -> ImagetransformwarpNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_warp_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_warp_node_copy(s : ImagetransformwarpNode) -> ImagetransformwarpNode {
  let result = image_transform_warp_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_warp_node_fill(s : ImagetransformwarpNode, v : Double) -> ImagetransformwarpNode {
  let result = image_transform_warp_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_warp_node_min(s : ImagetransformwarpNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_warp_node_max(s : ImagetransformwarpNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_warp_node_to_string(s : ImagetransformwarpNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformwarpEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_warp_edge_make(size : Int) -> ImagetransformwarpEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_warp_edge_len(s : ImagetransformwarpEdge) -> Int { s.size }

pub fn image_transform_warp_edge_get(s : ImagetransformwarpEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_warp_edge_set(s : ImagetransformwarpEdge, i : Int, v : Double) -> ImagetransformwarpEdge {
  let result = image_transform_warp_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_warp_edge_sum(s : ImagetransformwarpEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_transform_warp_edge_mean(s : ImagetransformwarpEdge) -> Double {
  if s.size == 0 { 0.0 } else { image_transform_warp_edge_sum(s) / s.size.to_double() }
}

pub fn image_transform_warp_edge_scale(s : ImagetransformwarpEdge, f : Double) -> ImagetransformwarpEdge {
  let result = image_transform_warp_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_warp_edge_add(a : ImagetransformwarpEdge, b : ImagetransformwarpEdge) -> ImagetransformwarpEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_warp_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_warp_edge_copy(s : ImagetransformwarpEdge) -> ImagetransformwarpEdge {
  let result = image_transform_warp_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_warp_edge_fill(s : ImagetransformwarpEdge, v : Double) -> ImagetransformwarpEdge {
  let result = image_transform_warp_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_warp_edge_min(s : ImagetransformwarpEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_warp_edge_max(s : ImagetransformwarpEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_warp_edge_to_string(s : ImagetransformwarpEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformwarpPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_warp_path_make(size : Int) -> ImagetransformwarpPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_warp_path_len(s : ImagetransformwarpPath) -> Int { s.size }

pub fn image_transform_warp_path_get(s : ImagetransformwarpPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_warp_path_set(s : ImagetransformwarpPath, i : Int, v : Double) -> ImagetransformwarpPath {
  let result = image_transform_warp_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_warp_path_sum(s : ImagetransformwarpPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_transform_warp_path_mean(s : ImagetransformwarpPath) -> Double {
  if s.size == 0 { 0.0 } else { image_transform_warp_path_sum(s) / s.size.to_double() }
}

pub fn image_transform_warp_path_scale(s : ImagetransformwarpPath, f : Double) -> ImagetransformwarpPath {
  let result = image_transform_warp_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_warp_path_add(a : ImagetransformwarpPath, b : ImagetransformwarpPath) -> ImagetransformwarpPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_warp_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_warp_path_copy(s : ImagetransformwarpPath) -> ImagetransformwarpPath {
  let result = image_transform_warp_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_warp_path_fill(s : ImagetransformwarpPath, v : Double) -> ImagetransformwarpPath {
  let result = image_transform_warp_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_warp_path_min(s : ImagetransformwarpPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_warp_path_max(s : ImagetransformwarpPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_warp_path_to_string(s : ImagetransformwarpPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformwarpCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_warp_cluster_make(size : Int) -> ImagetransformwarpCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_warp_cluster_len(s : ImagetransformwarpCluster) -> Int { s.size }

pub fn image_transform_warp_cluster_get(s : ImagetransformwarpCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_warp_cluster_set(s : ImagetransformwarpCluster, i : Int, v : Double) -> ImagetransformwarpCluster {
  let result = image_transform_warp_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_warp_cluster_sum(s : ImagetransformwarpCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_transform_warp_cluster_mean(s : ImagetransformwarpCluster) -> Double {
  if s.size == 0 { 0.0 } else { image_transform_warp_cluster_sum(s) / s.size.to_double() }
}

pub fn image_transform_warp_cluster_scale(s : ImagetransformwarpCluster, f : Double) -> ImagetransformwarpCluster {
  let result = image_transform_warp_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_warp_cluster_add(a : ImagetransformwarpCluster, b : ImagetransformwarpCluster) -> ImagetransformwarpCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_warp_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_warp_cluster_copy(s : ImagetransformwarpCluster) -> ImagetransformwarpCluster {
  let result = image_transform_warp_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_warp_cluster_fill(s : ImagetransformwarpCluster, v : Double) -> ImagetransformwarpCluster {
  let result = image_transform_warp_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_warp_cluster_min(s : ImagetransformwarpCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_warp_cluster_max(s : ImagetransformwarpCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_warp_cluster_to_string(s : ImagetransformwarpCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformwarpModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_warp_model_make(size : Int) -> ImagetransformwarpModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_warp_model_len(s : ImagetransformwarpModel) -> Int { s.size }

pub fn image_transform_warp_model_get(s : ImagetransformwarpModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_warp_model_set(s : ImagetransformwarpModel, i : Int, v : Double) -> ImagetransformwarpModel {
  let result = image_transform_warp_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_warp_model_sum(s : ImagetransformwarpModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_transform_warp_model_mean(s : ImagetransformwarpModel) -> Double {
  if s.size == 0 { 0.0 } else { image_transform_warp_model_sum(s) / s.size.to_double() }
}

pub fn image_transform_warp_model_scale(s : ImagetransformwarpModel, f : Double) -> ImagetransformwarpModel {
  let result = image_transform_warp_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_warp_model_add(a : ImagetransformwarpModel, b : ImagetransformwarpModel) -> ImagetransformwarpModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_warp_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_warp_model_copy(s : ImagetransformwarpModel) -> ImagetransformwarpModel {
  let result = image_transform_warp_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_warp_model_fill(s : ImagetransformwarpModel, v : Double) -> ImagetransformwarpModel {
  let result = image_transform_warp_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_warp_model_min(s : ImagetransformwarpModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_warp_model_max(s : ImagetransformwarpModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_warp_model_to_string(s : ImagetransformwarpModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformwarpLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_warp_layer_make(size : Int) -> ImagetransformwarpLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_warp_layer_len(s : ImagetransformwarpLayer) -> Int { s.size }

pub fn image_transform_warp_layer_get(s : ImagetransformwarpLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_warp_layer_set(s : ImagetransformwarpLayer, i : Int, v : Double) -> ImagetransformwarpLayer {
  let result = image_transform_warp_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_warp_layer_sum(s : ImagetransformwarpLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_transform_warp_layer_mean(s : ImagetransformwarpLayer) -> Double {
  if s.size == 0 { 0.0 } else { image_transform_warp_layer_sum(s) / s.size.to_double() }
}

pub fn image_transform_warp_layer_scale(s : ImagetransformwarpLayer, f : Double) -> ImagetransformwarpLayer {
  let result = image_transform_warp_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_warp_layer_add(a : ImagetransformwarpLayer, b : ImagetransformwarpLayer) -> ImagetransformwarpLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_warp_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_warp_layer_copy(s : ImagetransformwarpLayer) -> ImagetransformwarpLayer {
  let result = image_transform_warp_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_warp_layer_fill(s : ImagetransformwarpLayer, v : Double) -> ImagetransformwarpLayer {
  let result = image_transform_warp_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_warp_layer_min(s : ImagetransformwarpLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_warp_layer_max(s : ImagetransformwarpLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_warp_layer_to_string(s : ImagetransformwarpLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformwarpBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_warp_buffer_make(size : Int) -> ImagetransformwarpBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_warp_buffer_len(s : ImagetransformwarpBuffer) -> Int { s.size }

pub fn image_transform_warp_buffer_get(s : ImagetransformwarpBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_warp_buffer_set(s : ImagetransformwarpBuffer, i : Int, v : Double) -> ImagetransformwarpBuffer {
  let result = image_transform_warp_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_warp_buffer_sum(s : ImagetransformwarpBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_transform_warp_buffer_mean(s : ImagetransformwarpBuffer) -> Double {
  if s.size == 0 { 0.0 } else { image_transform_warp_buffer_sum(s) / s.size.to_double() }
}

pub fn image_transform_warp_buffer_scale(s : ImagetransformwarpBuffer, f : Double) -> ImagetransformwarpBuffer {
  let result = image_transform_warp_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_warp_buffer_add(a : ImagetransformwarpBuffer, b : ImagetransformwarpBuffer) -> ImagetransformwarpBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_warp_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_warp_buffer_copy(s : ImagetransformwarpBuffer) -> ImagetransformwarpBuffer {
  let result = image_transform_warp_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_warp_buffer_fill(s : ImagetransformwarpBuffer, v : Double) -> ImagetransformwarpBuffer {
  let result = image_transform_warp_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_warp_buffer_min(s : ImagetransformwarpBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_warp_buffer_max(s : ImagetransformwarpBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_warp_buffer_to_string(s : ImagetransformwarpBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformwarpCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_warp_cursor_make(size : Int) -> ImagetransformwarpCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_warp_cursor_len(s : ImagetransformwarpCursor) -> Int { s.size }

pub fn image_transform_warp_cursor_get(s : ImagetransformwarpCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_warp_cursor_set(s : ImagetransformwarpCursor, i : Int, v : Double) -> ImagetransformwarpCursor {
  let result = image_transform_warp_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_warp_cursor_sum(s : ImagetransformwarpCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_transform_warp_cursor_mean(s : ImagetransformwarpCursor) -> Double {
  if s.size == 0 { 0.0 } else { image_transform_warp_cursor_sum(s) / s.size.to_double() }
}

pub fn image_transform_warp_cursor_scale(s : ImagetransformwarpCursor, f : Double) -> ImagetransformwarpCursor {
  let result = image_transform_warp_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_warp_cursor_add(a : ImagetransformwarpCursor, b : ImagetransformwarpCursor) -> ImagetransformwarpCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_warp_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_warp_cursor_copy(s : ImagetransformwarpCursor) -> ImagetransformwarpCursor {
  let result = image_transform_warp_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_warp_cursor_fill(s : ImagetransformwarpCursor, v : Double) -> ImagetransformwarpCursor {
  let result = image_transform_warp_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_warp_cursor_min(s : ImagetransformwarpCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_warp_cursor_max(s : ImagetransformwarpCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_warp_cursor_to_string(s : ImagetransformwarpCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformwarpView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_warp_view_make(size : Int) -> ImagetransformwarpView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_warp_view_len(s : ImagetransformwarpView) -> Int { s.size }

pub fn image_transform_warp_view_get(s : ImagetransformwarpView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_warp_view_set(s : ImagetransformwarpView, i : Int, v : Double) -> ImagetransformwarpView {
  let result = image_transform_warp_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_warp_view_sum(s : ImagetransformwarpView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_transform_warp_view_mean(s : ImagetransformwarpView) -> Double {
  if s.size == 0 { 0.0 } else { image_transform_warp_view_sum(s) / s.size.to_double() }
}

pub fn image_transform_warp_view_scale(s : ImagetransformwarpView, f : Double) -> ImagetransformwarpView {
  let result = image_transform_warp_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_warp_view_add(a : ImagetransformwarpView, b : ImagetransformwarpView) -> ImagetransformwarpView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_warp_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_warp_view_copy(s : ImagetransformwarpView) -> ImagetransformwarpView {
  let result = image_transform_warp_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_warp_view_fill(s : ImagetransformwarpView, v : Double) -> ImagetransformwarpView {
  let result = image_transform_warp_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_warp_view_min(s : ImagetransformwarpView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_warp_view_max(s : ImagetransformwarpView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_warp_view_to_string(s : ImagetransformwarpView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformwarpRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_warp_range_make(size : Int) -> ImagetransformwarpRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_warp_range_len(s : ImagetransformwarpRange) -> Int { s.size }

pub fn image_transform_warp_range_get(s : ImagetransformwarpRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_warp_range_set(s : ImagetransformwarpRange, i : Int, v : Double) -> ImagetransformwarpRange {
  let result = image_transform_warp_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_warp_range_sum(s : ImagetransformwarpRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_transform_warp_range_mean(s : ImagetransformwarpRange) -> Double {
  if s.size == 0 { 0.0 } else { image_transform_warp_range_sum(s) / s.size.to_double() }
}

pub fn image_transform_warp_range_scale(s : ImagetransformwarpRange, f : Double) -> ImagetransformwarpRange {
  let result = image_transform_warp_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_warp_range_add(a : ImagetransformwarpRange, b : ImagetransformwarpRange) -> ImagetransformwarpRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_warp_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_warp_range_copy(s : ImagetransformwarpRange) -> ImagetransformwarpRange {
  let result = image_transform_warp_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_warp_range_fill(s : ImagetransformwarpRange, v : Double) -> ImagetransformwarpRange {
  let result = image_transform_warp_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_warp_range_min(s : ImagetransformwarpRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_warp_range_max(s : ImagetransformwarpRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_warp_range_to_string(s : ImagetransformwarpRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformwarpSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_warp_slice_make(size : Int) -> ImagetransformwarpSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_warp_slice_len(s : ImagetransformwarpSlice) -> Int { s.size }

pub fn image_transform_warp_slice_get(s : ImagetransformwarpSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_warp_slice_set(s : ImagetransformwarpSlice, i : Int, v : Double) -> ImagetransformwarpSlice {
  let result = image_transform_warp_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_warp_slice_sum(s : ImagetransformwarpSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_transform_warp_slice_mean(s : ImagetransformwarpSlice) -> Double {
  if s.size == 0 { 0.0 } else { image_transform_warp_slice_sum(s) / s.size.to_double() }
}

pub fn image_transform_warp_slice_scale(s : ImagetransformwarpSlice, f : Double) -> ImagetransformwarpSlice {
  let result = image_transform_warp_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_warp_slice_add(a : ImagetransformwarpSlice, b : ImagetransformwarpSlice) -> ImagetransformwarpSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_warp_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_warp_slice_copy(s : ImagetransformwarpSlice) -> ImagetransformwarpSlice {
  let result = image_transform_warp_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_warp_slice_fill(s : ImagetransformwarpSlice, v : Double) -> ImagetransformwarpSlice {
  let result = image_transform_warp_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_warp_slice_min(s : ImagetransformwarpSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_warp_slice_max(s : ImagetransformwarpSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_warp_slice_to_string(s : ImagetransformwarpSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


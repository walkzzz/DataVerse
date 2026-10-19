///===
/// extcore/image_transform_transpose

pub(all) struct ImagetransformtransposePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_transform_transpose_make_point(x : Double, y : Double) -> ImagetransformtransposePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_transform_transpose_make_point3(x : Double, y : Double, z : Double) -> ImagetransformtransposePoint {
  { x, y, z, label: 0 }
}

pub fn image_transform_transpose_point_x(pt : ImagetransformtransposePoint) -> Double { pt.x }

pub fn image_transform_transpose_point_y(pt : ImagetransformtransposePoint) -> Double { pt.y }

pub fn image_transform_transpose_point_z(pt : ImagetransformtransposePoint) -> Double { pt.z }

pub fn image_transform_transpose_point_label(pt : ImagetransformtransposePoint) -> Int { pt.label }

pub fn image_transform_transpose_point_dist(a : ImagetransformtransposePoint, b : ImagetransformtransposePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn image_transform_transpose_point_add(a : ImagetransformtransposePoint, b : ImagetransformtransposePoint) -> ImagetransformtransposePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn image_transform_transpose_point_sub(a : ImagetransformtransposePoint, b : ImagetransformtransposePoint) -> ImagetransformtransposePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn image_transform_transpose_point_scale(pt : ImagetransformtransposePoint, s : Double) -> ImagetransformtransposePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn image_transform_transpose_point_dot(a : ImagetransformtransposePoint, b : ImagetransformtransposePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn image_transform_transpose_point_cross(a : ImagetransformtransposePoint, b : ImagetransformtransposePoint) -> ImagetransformtransposePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn image_transform_transpose_point_norm(pt : ImagetransformtransposePoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn image_transform_transpose_point_normalize(pt : ImagetransformtransposePoint) -> ImagetransformtransposePoint {
  let n = image_transform_transpose_point_norm(pt)
  if n < 0.0000001 { pt } else { image_transform_transpose_point_scale(pt, 1.0 / n) }
}

pub fn image_transform_transpose_point_negate(pt : ImagetransformtransposePoint) -> ImagetransformtransposePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn image_transform_transpose_point_mid(a : ImagetransformtransposePoint, b : ImagetransformtransposePoint) -> ImagetransformtransposePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn image_transform_transpose_point_lerp(a : ImagetransformtransposePoint, b : ImagetransformtransposePoint, t : Double) -> ImagetransformtransposePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn image_transform_transpose_point_to_string(pt : ImagetransformtransposePoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct ImagetransformtransposeSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_transform_transpose_make_series(vals : Array[Double], name : String) -> ImagetransformtransposeSeries {
  { vals, name, meta: 0 }
}

pub fn image_transform_transpose_series_len(s : ImagetransformtransposeSeries) -> Int { s.vals.length() }

pub fn image_transform_transpose_series_sum(s : ImagetransformtransposeSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn image_transform_transpose_series_mean(s : ImagetransformtransposeSeries) -> Double {
  let n = image_transform_transpose_series_len(s)
  if n == 0 { 0.0 } else { image_transform_transpose_series_sum(s) / n.to_double() }
}

pub fn image_transform_transpose_series_min(s : ImagetransformtransposeSeries) -> Double {
  let n = image_transform_transpose_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn image_transform_transpose_series_max(s : ImagetransformtransposeSeries) -> Double {
  let n = image_transform_transpose_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn image_transform_transpose_series_range(s : ImagetransformtransposeSeries) -> Double {
  image_transform_transpose_series_max(s) - image_transform_transpose_series_min(s)
}

pub fn image_transform_transpose_series_var(s : ImagetransformtransposeSeries) -> Double {
  let n = image_transform_transpose_series_len(s)
  if n == 0 { 0.0 } else {
    let m = image_transform_transpose_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn image_transform_transpose_series_std(s : ImagetransformtransposeSeries) -> Double { @_common.sqrt(image_transform_transpose_series_var(s)) }

pub fn image_transform_transpose_series_median(s : ImagetransformtransposeSeries) -> Double {
  let n = image_transform_transpose_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = image_transform_transpose_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn image_transform_transpose_series_scale(s : ImagetransformtransposeSeries, f : Double) -> ImagetransformtransposeSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn image_transform_transpose_series_add(a : ImagetransformtransposeSeries, b : ImagetransformtransposeSeries) -> ImagetransformtransposeSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn image_transform_transpose_series_sub(a : ImagetransformtransposeSeries, b : ImagetransformtransposeSeries) -> ImagetransformtransposeSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn image_transform_transpose_series_normalize(s : ImagetransformtransposeSeries) -> ImagetransformtransposeSeries {
  let mn = image_transform_transpose_series_min(s)
  let mx = image_transform_transpose_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn image_transform_transpose_series_cumsum(s : ImagetransformtransposeSeries) -> ImagetransformtransposeSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn image_transform_transpose_series_to_string(s : ImagetransformtransposeSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagetransformtransposeMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_transform_transpose_make_matrix(rows : Int, cols : Int, val : Double) -> ImagetransformtransposeMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn image_transform_transpose_matrix_identity(n : Int) -> ImagetransformtransposeMatrix {
  let m = image_transform_transpose_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn image_transform_transpose_matrix_get(m : ImagetransformtransposeMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn image_transform_transpose_matrix_transpose(m : ImagetransformtransposeMatrix) -> ImagetransformtransposeMatrix {
  let result = image_transform_transpose_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn image_transform_transpose_matrix_add(a : ImagetransformtransposeMatrix, b : ImagetransformtransposeMatrix) -> ImagetransformtransposeMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = image_transform_transpose_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn image_transform_transpose_matrix_scale(m : ImagetransformtransposeMatrix, s : Double) -> ImagetransformtransposeMatrix {
  let result = image_transform_transpose_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn image_transform_transpose_matrix_multiply(a : ImagetransformtransposeMatrix, b : ImagetransformtransposeMatrix) -> ImagetransformtransposeMatrix {
  if a.cols != b.rows { return image_transform_transpose_make_matrix(a.rows, b.cols, 0.0) }
  let result = image_transform_transpose_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn image_transform_transpose_matrix_trace(m : ImagetransformtransposeMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn image_transform_transpose_matrix_det(m : ImagetransformtransposeMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn image_transform_transpose_matrix_norm(m : ImagetransformtransposeMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn image_transform_transpose_matrix_to_string(m : ImagetransformtransposeMatrix) -> String {
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

pub(all) struct ImagetransformtransposeVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_transform_transpose_make_vector(comps : Array[Double]) -> ImagetransformtransposeVector {
  { comps, dim: comps.length() }
}

pub fn image_transform_transpose_vector_zero(dim : Int) -> ImagetransformtransposeVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn image_transform_transpose_vector_add(a : ImagetransformtransposeVector, b : ImagetransformtransposeVector) -> ImagetransformtransposeVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn image_transform_transpose_vector_sub(a : ImagetransformtransposeVector, b : ImagetransformtransposeVector) -> ImagetransformtransposeVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn image_transform_transpose_vector_scale(v : ImagetransformtransposeVector, s : Double) -> ImagetransformtransposeVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn image_transform_transpose_vector_dot(a : ImagetransformtransposeVector, b : ImagetransformtransposeVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn image_transform_transpose_vector_norm(v : ImagetransformtransposeVector) -> Double { @_common.sqrt(image_transform_transpose_vector_dot(v, v)) }

pub fn image_transform_transpose_vector_normalize(v : ImagetransformtransposeVector) -> ImagetransformtransposeVector {
  let n = image_transform_transpose_vector_norm(v)
  if n < 0.0000001 { v } else { image_transform_transpose_vector_scale(v, 1.0 / n) }
}

pub fn image_transform_transpose_vector_dist(a : ImagetransformtransposeVector, b : ImagetransformtransposeVector) -> Double {
  image_transform_transpose_vector_norm(image_transform_transpose_vector_sub(a, b))
}

pub fn image_transform_transpose_vector_to_string(v : ImagetransformtransposeVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn image_transform_transpose_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn image_transform_transpose_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = image_transform_transpose_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn image_transform_transpose_std(data : Array[Double]) -> Double { @_common.sqrt(image_transform_transpose_var(data)) }

pub fn image_transform_transpose_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = image_transform_transpose_mean(a); let mb = image_transform_transpose_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn image_transform_transpose_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = image_transform_transpose_std(a); let sb = image_transform_transpose_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { image_transform_transpose_cov(a, b) / (sa * sb) }
}

pub fn image_transform_transpose_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = image_transform_transpose_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn image_transform_transpose_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn image_transform_transpose_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn image_transform_transpose_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(image_transform_transpose_mse(pred, labels))
}

pub fn image_transform_transpose_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn image_transform_transpose_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = image_transform_transpose_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn image_transform_transpose_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn image_transform_transpose_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn image_transform_transpose_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = image_transform_transpose_precision(pred, labels, pos); let r = image_transform_transpose_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn image_transform_transpose_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn image_transform_transpose_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = image_transform_transpose_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn image_transform_transpose_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn image_transform_transpose_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn image_transform_transpose_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = image_transform_transpose_gcd(a, b)
    (a / g) * b
  }
}

pub fn image_transform_transpose_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn image_transform_transpose_fibonacci(n : Int) -> Int {
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

pub fn image_transform_transpose_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = image_transform_transpose_min(data); let mx = image_transform_transpose_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn image_transform_transpose_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = image_transform_transpose_mean(data); let sd = image_transform_transpose_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn image_transform_transpose_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn image_transform_transpose_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn image_transform_transpose_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn image_transform_transpose_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn image_transform_transpose_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn image_transform_transpose_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct ImagetransformtransposeFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_transpose_frame_make(size : Int) -> ImagetransformtransposeFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_transpose_frame_len(s : ImagetransformtransposeFrame) -> Int { s.size }

pub fn image_transform_transpose_frame_get(s : ImagetransformtransposeFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_transpose_frame_set(s : ImagetransformtransposeFrame, i : Int, v : Double) -> ImagetransformtransposeFrame {
  let result = image_transform_transpose_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_transpose_frame_sum(s : ImagetransformtransposeFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_transform_transpose_frame_mean(s : ImagetransformtransposeFrame) -> Double {
  if s.size == 0 { 0.0 } else { image_transform_transpose_frame_sum(s) / s.size.to_double() }
}

pub fn image_transform_transpose_frame_scale(s : ImagetransformtransposeFrame, f : Double) -> ImagetransformtransposeFrame {
  let result = image_transform_transpose_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_transpose_frame_add(a : ImagetransformtransposeFrame, b : ImagetransformtransposeFrame) -> ImagetransformtransposeFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_transpose_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_transpose_frame_copy(s : ImagetransformtransposeFrame) -> ImagetransformtransposeFrame {
  let result = image_transform_transpose_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_transpose_frame_fill(s : ImagetransformtransposeFrame, v : Double) -> ImagetransformtransposeFrame {
  let result = image_transform_transpose_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_transpose_frame_min(s : ImagetransformtransposeFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_transpose_frame_max(s : ImagetransformtransposeFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_transpose_frame_to_string(s : ImagetransformtransposeFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformtransposeTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_transpose_table_make(size : Int) -> ImagetransformtransposeTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_transpose_table_len(s : ImagetransformtransposeTable) -> Int { s.size }

pub fn image_transform_transpose_table_get(s : ImagetransformtransposeTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_transpose_table_set(s : ImagetransformtransposeTable, i : Int, v : Double) -> ImagetransformtransposeTable {
  let result = image_transform_transpose_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_transpose_table_sum(s : ImagetransformtransposeTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_transform_transpose_table_mean(s : ImagetransformtransposeTable) -> Double {
  if s.size == 0 { 0.0 } else { image_transform_transpose_table_sum(s) / s.size.to_double() }
}

pub fn image_transform_transpose_table_scale(s : ImagetransformtransposeTable, f : Double) -> ImagetransformtransposeTable {
  let result = image_transform_transpose_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_transpose_table_add(a : ImagetransformtransposeTable, b : ImagetransformtransposeTable) -> ImagetransformtransposeTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_transpose_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_transpose_table_copy(s : ImagetransformtransposeTable) -> ImagetransformtransposeTable {
  let result = image_transform_transpose_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_transpose_table_fill(s : ImagetransformtransposeTable, v : Double) -> ImagetransformtransposeTable {
  let result = image_transform_transpose_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_transpose_table_min(s : ImagetransformtransposeTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_transpose_table_max(s : ImagetransformtransposeTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_transpose_table_to_string(s : ImagetransformtransposeTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformtransposeGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_transpose_graphn_make(size : Int) -> ImagetransformtransposeGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_transpose_graphn_len(s : ImagetransformtransposeGraphN) -> Int { s.size }

pub fn image_transform_transpose_graphn_get(s : ImagetransformtransposeGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_transpose_graphn_set(s : ImagetransformtransposeGraphN, i : Int, v : Double) -> ImagetransformtransposeGraphN {
  let result = image_transform_transpose_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_transpose_graphn_sum(s : ImagetransformtransposeGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_transform_transpose_graphn_mean(s : ImagetransformtransposeGraphN) -> Double {
  if s.size == 0 { 0.0 } else { image_transform_transpose_graphn_sum(s) / s.size.to_double() }
}

pub fn image_transform_transpose_graphn_scale(s : ImagetransformtransposeGraphN, f : Double) -> ImagetransformtransposeGraphN {
  let result = image_transform_transpose_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_transpose_graphn_add(a : ImagetransformtransposeGraphN, b : ImagetransformtransposeGraphN) -> ImagetransformtransposeGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_transpose_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_transpose_graphn_copy(s : ImagetransformtransposeGraphN) -> ImagetransformtransposeGraphN {
  let result = image_transform_transpose_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_transpose_graphn_fill(s : ImagetransformtransposeGraphN, v : Double) -> ImagetransformtransposeGraphN {
  let result = image_transform_transpose_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_transpose_graphn_min(s : ImagetransformtransposeGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_transpose_graphn_max(s : ImagetransformtransposeGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_transpose_graphn_to_string(s : ImagetransformtransposeGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformtransposeNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_transpose_node_make(size : Int) -> ImagetransformtransposeNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_transpose_node_len(s : ImagetransformtransposeNode) -> Int { s.size }

pub fn image_transform_transpose_node_get(s : ImagetransformtransposeNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_transpose_node_set(s : ImagetransformtransposeNode, i : Int, v : Double) -> ImagetransformtransposeNode {
  let result = image_transform_transpose_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_transpose_node_sum(s : ImagetransformtransposeNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_transform_transpose_node_mean(s : ImagetransformtransposeNode) -> Double {
  if s.size == 0 { 0.0 } else { image_transform_transpose_node_sum(s) / s.size.to_double() }
}

pub fn image_transform_transpose_node_scale(s : ImagetransformtransposeNode, f : Double) -> ImagetransformtransposeNode {
  let result = image_transform_transpose_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_transpose_node_add(a : ImagetransformtransposeNode, b : ImagetransformtransposeNode) -> ImagetransformtransposeNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_transpose_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_transpose_node_copy(s : ImagetransformtransposeNode) -> ImagetransformtransposeNode {
  let result = image_transform_transpose_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_transpose_node_fill(s : ImagetransformtransposeNode, v : Double) -> ImagetransformtransposeNode {
  let result = image_transform_transpose_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_transpose_node_min(s : ImagetransformtransposeNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_transpose_node_max(s : ImagetransformtransposeNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_transpose_node_to_string(s : ImagetransformtransposeNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformtransposeEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_transpose_edge_make(size : Int) -> ImagetransformtransposeEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_transpose_edge_len(s : ImagetransformtransposeEdge) -> Int { s.size }

pub fn image_transform_transpose_edge_get(s : ImagetransformtransposeEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_transpose_edge_set(s : ImagetransformtransposeEdge, i : Int, v : Double) -> ImagetransformtransposeEdge {
  let result = image_transform_transpose_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_transpose_edge_sum(s : ImagetransformtransposeEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_transform_transpose_edge_mean(s : ImagetransformtransposeEdge) -> Double {
  if s.size == 0 { 0.0 } else { image_transform_transpose_edge_sum(s) / s.size.to_double() }
}

pub fn image_transform_transpose_edge_scale(s : ImagetransformtransposeEdge, f : Double) -> ImagetransformtransposeEdge {
  let result = image_transform_transpose_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_transpose_edge_add(a : ImagetransformtransposeEdge, b : ImagetransformtransposeEdge) -> ImagetransformtransposeEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_transpose_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_transpose_edge_copy(s : ImagetransformtransposeEdge) -> ImagetransformtransposeEdge {
  let result = image_transform_transpose_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_transpose_edge_fill(s : ImagetransformtransposeEdge, v : Double) -> ImagetransformtransposeEdge {
  let result = image_transform_transpose_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_transpose_edge_min(s : ImagetransformtransposeEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_transpose_edge_max(s : ImagetransformtransposeEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_transpose_edge_to_string(s : ImagetransformtransposeEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformtransposePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_transpose_path_make(size : Int) -> ImagetransformtransposePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_transpose_path_len(s : ImagetransformtransposePath) -> Int { s.size }

pub fn image_transform_transpose_path_get(s : ImagetransformtransposePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_transpose_path_set(s : ImagetransformtransposePath, i : Int, v : Double) -> ImagetransformtransposePath {
  let result = image_transform_transpose_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_transpose_path_sum(s : ImagetransformtransposePath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_transform_transpose_path_mean(s : ImagetransformtransposePath) -> Double {
  if s.size == 0 { 0.0 } else { image_transform_transpose_path_sum(s) / s.size.to_double() }
}

pub fn image_transform_transpose_path_scale(s : ImagetransformtransposePath, f : Double) -> ImagetransformtransposePath {
  let result = image_transform_transpose_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_transpose_path_add(a : ImagetransformtransposePath, b : ImagetransformtransposePath) -> ImagetransformtransposePath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_transpose_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_transpose_path_copy(s : ImagetransformtransposePath) -> ImagetransformtransposePath {
  let result = image_transform_transpose_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_transpose_path_fill(s : ImagetransformtransposePath, v : Double) -> ImagetransformtransposePath {
  let result = image_transform_transpose_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_transpose_path_min(s : ImagetransformtransposePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_transpose_path_max(s : ImagetransformtransposePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_transpose_path_to_string(s : ImagetransformtransposePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformtransposeCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_transpose_cluster_make(size : Int) -> ImagetransformtransposeCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_transpose_cluster_len(s : ImagetransformtransposeCluster) -> Int { s.size }

pub fn image_transform_transpose_cluster_get(s : ImagetransformtransposeCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_transpose_cluster_set(s : ImagetransformtransposeCluster, i : Int, v : Double) -> ImagetransformtransposeCluster {
  let result = image_transform_transpose_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_transpose_cluster_sum(s : ImagetransformtransposeCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_transform_transpose_cluster_mean(s : ImagetransformtransposeCluster) -> Double {
  if s.size == 0 { 0.0 } else { image_transform_transpose_cluster_sum(s) / s.size.to_double() }
}

pub fn image_transform_transpose_cluster_scale(s : ImagetransformtransposeCluster, f : Double) -> ImagetransformtransposeCluster {
  let result = image_transform_transpose_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_transpose_cluster_add(a : ImagetransformtransposeCluster, b : ImagetransformtransposeCluster) -> ImagetransformtransposeCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_transpose_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_transpose_cluster_copy(s : ImagetransformtransposeCluster) -> ImagetransformtransposeCluster {
  let result = image_transform_transpose_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_transpose_cluster_fill(s : ImagetransformtransposeCluster, v : Double) -> ImagetransformtransposeCluster {
  let result = image_transform_transpose_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_transpose_cluster_min(s : ImagetransformtransposeCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_transpose_cluster_max(s : ImagetransformtransposeCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_transpose_cluster_to_string(s : ImagetransformtransposeCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformtransposeModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_transpose_model_make(size : Int) -> ImagetransformtransposeModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_transpose_model_len(s : ImagetransformtransposeModel) -> Int { s.size }

pub fn image_transform_transpose_model_get(s : ImagetransformtransposeModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_transpose_model_set(s : ImagetransformtransposeModel, i : Int, v : Double) -> ImagetransformtransposeModel {
  let result = image_transform_transpose_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_transpose_model_sum(s : ImagetransformtransposeModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_transform_transpose_model_mean(s : ImagetransformtransposeModel) -> Double {
  if s.size == 0 { 0.0 } else { image_transform_transpose_model_sum(s) / s.size.to_double() }
}

pub fn image_transform_transpose_model_scale(s : ImagetransformtransposeModel, f : Double) -> ImagetransformtransposeModel {
  let result = image_transform_transpose_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_transpose_model_add(a : ImagetransformtransposeModel, b : ImagetransformtransposeModel) -> ImagetransformtransposeModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_transpose_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_transpose_model_copy(s : ImagetransformtransposeModel) -> ImagetransformtransposeModel {
  let result = image_transform_transpose_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_transpose_model_fill(s : ImagetransformtransposeModel, v : Double) -> ImagetransformtransposeModel {
  let result = image_transform_transpose_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_transpose_model_min(s : ImagetransformtransposeModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_transpose_model_max(s : ImagetransformtransposeModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_transpose_model_to_string(s : ImagetransformtransposeModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformtransposeLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_transpose_layer_make(size : Int) -> ImagetransformtransposeLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_transpose_layer_len(s : ImagetransformtransposeLayer) -> Int { s.size }

pub fn image_transform_transpose_layer_get(s : ImagetransformtransposeLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_transpose_layer_set(s : ImagetransformtransposeLayer, i : Int, v : Double) -> ImagetransformtransposeLayer {
  let result = image_transform_transpose_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_transpose_layer_sum(s : ImagetransformtransposeLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_transform_transpose_layer_mean(s : ImagetransformtransposeLayer) -> Double {
  if s.size == 0 { 0.0 } else { image_transform_transpose_layer_sum(s) / s.size.to_double() }
}

pub fn image_transform_transpose_layer_scale(s : ImagetransformtransposeLayer, f : Double) -> ImagetransformtransposeLayer {
  let result = image_transform_transpose_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_transpose_layer_add(a : ImagetransformtransposeLayer, b : ImagetransformtransposeLayer) -> ImagetransformtransposeLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_transpose_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_transpose_layer_copy(s : ImagetransformtransposeLayer) -> ImagetransformtransposeLayer {
  let result = image_transform_transpose_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_transpose_layer_fill(s : ImagetransformtransposeLayer, v : Double) -> ImagetransformtransposeLayer {
  let result = image_transform_transpose_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_transpose_layer_min(s : ImagetransformtransposeLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_transpose_layer_max(s : ImagetransformtransposeLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_transpose_layer_to_string(s : ImagetransformtransposeLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformtransposeBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_transpose_buffer_make(size : Int) -> ImagetransformtransposeBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_transpose_buffer_len(s : ImagetransformtransposeBuffer) -> Int { s.size }

pub fn image_transform_transpose_buffer_get(s : ImagetransformtransposeBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_transpose_buffer_set(s : ImagetransformtransposeBuffer, i : Int, v : Double) -> ImagetransformtransposeBuffer {
  let result = image_transform_transpose_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_transpose_buffer_sum(s : ImagetransformtransposeBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_transform_transpose_buffer_mean(s : ImagetransformtransposeBuffer) -> Double {
  if s.size == 0 { 0.0 } else { image_transform_transpose_buffer_sum(s) / s.size.to_double() }
}

pub fn image_transform_transpose_buffer_scale(s : ImagetransformtransposeBuffer, f : Double) -> ImagetransformtransposeBuffer {
  let result = image_transform_transpose_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_transpose_buffer_add(a : ImagetransformtransposeBuffer, b : ImagetransformtransposeBuffer) -> ImagetransformtransposeBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_transpose_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_transpose_buffer_copy(s : ImagetransformtransposeBuffer) -> ImagetransformtransposeBuffer {
  let result = image_transform_transpose_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_transpose_buffer_fill(s : ImagetransformtransposeBuffer, v : Double) -> ImagetransformtransposeBuffer {
  let result = image_transform_transpose_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_transpose_buffer_min(s : ImagetransformtransposeBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_transpose_buffer_max(s : ImagetransformtransposeBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_transpose_buffer_to_string(s : ImagetransformtransposeBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformtransposeCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_transpose_cursor_make(size : Int) -> ImagetransformtransposeCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_transpose_cursor_len(s : ImagetransformtransposeCursor) -> Int { s.size }

pub fn image_transform_transpose_cursor_get(s : ImagetransformtransposeCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_transpose_cursor_set(s : ImagetransformtransposeCursor, i : Int, v : Double) -> ImagetransformtransposeCursor {
  let result = image_transform_transpose_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_transpose_cursor_sum(s : ImagetransformtransposeCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_transform_transpose_cursor_mean(s : ImagetransformtransposeCursor) -> Double {
  if s.size == 0 { 0.0 } else { image_transform_transpose_cursor_sum(s) / s.size.to_double() }
}

pub fn image_transform_transpose_cursor_scale(s : ImagetransformtransposeCursor, f : Double) -> ImagetransformtransposeCursor {
  let result = image_transform_transpose_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_transpose_cursor_add(a : ImagetransformtransposeCursor, b : ImagetransformtransposeCursor) -> ImagetransformtransposeCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_transpose_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_transpose_cursor_copy(s : ImagetransformtransposeCursor) -> ImagetransformtransposeCursor {
  let result = image_transform_transpose_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_transpose_cursor_fill(s : ImagetransformtransposeCursor, v : Double) -> ImagetransformtransposeCursor {
  let result = image_transform_transpose_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_transpose_cursor_min(s : ImagetransformtransposeCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_transpose_cursor_max(s : ImagetransformtransposeCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_transpose_cursor_to_string(s : ImagetransformtransposeCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformtransposeView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_transpose_view_make(size : Int) -> ImagetransformtransposeView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_transpose_view_len(s : ImagetransformtransposeView) -> Int { s.size }

pub fn image_transform_transpose_view_get(s : ImagetransformtransposeView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_transpose_view_set(s : ImagetransformtransposeView, i : Int, v : Double) -> ImagetransformtransposeView {
  let result = image_transform_transpose_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_transpose_view_sum(s : ImagetransformtransposeView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_transform_transpose_view_mean(s : ImagetransformtransposeView) -> Double {
  if s.size == 0 { 0.0 } else { image_transform_transpose_view_sum(s) / s.size.to_double() }
}

pub fn image_transform_transpose_view_scale(s : ImagetransformtransposeView, f : Double) -> ImagetransformtransposeView {
  let result = image_transform_transpose_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_transpose_view_add(a : ImagetransformtransposeView, b : ImagetransformtransposeView) -> ImagetransformtransposeView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_transpose_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_transpose_view_copy(s : ImagetransformtransposeView) -> ImagetransformtransposeView {
  let result = image_transform_transpose_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_transpose_view_fill(s : ImagetransformtransposeView, v : Double) -> ImagetransformtransposeView {
  let result = image_transform_transpose_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_transpose_view_min(s : ImagetransformtransposeView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_transpose_view_max(s : ImagetransformtransposeView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_transpose_view_to_string(s : ImagetransformtransposeView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformtransposeRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_transpose_range_make(size : Int) -> ImagetransformtransposeRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_transpose_range_len(s : ImagetransformtransposeRange) -> Int { s.size }

pub fn image_transform_transpose_range_get(s : ImagetransformtransposeRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_transpose_range_set(s : ImagetransformtransposeRange, i : Int, v : Double) -> ImagetransformtransposeRange {
  let result = image_transform_transpose_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_transpose_range_sum(s : ImagetransformtransposeRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_transform_transpose_range_mean(s : ImagetransformtransposeRange) -> Double {
  if s.size == 0 { 0.0 } else { image_transform_transpose_range_sum(s) / s.size.to_double() }
}

pub fn image_transform_transpose_range_scale(s : ImagetransformtransposeRange, f : Double) -> ImagetransformtransposeRange {
  let result = image_transform_transpose_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_transpose_range_add(a : ImagetransformtransposeRange, b : ImagetransformtransposeRange) -> ImagetransformtransposeRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_transpose_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_transpose_range_copy(s : ImagetransformtransposeRange) -> ImagetransformtransposeRange {
  let result = image_transform_transpose_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_transpose_range_fill(s : ImagetransformtransposeRange, v : Double) -> ImagetransformtransposeRange {
  let result = image_transform_transpose_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_transpose_range_min(s : ImagetransformtransposeRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_transpose_range_max(s : ImagetransformtransposeRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_transpose_range_to_string(s : ImagetransformtransposeRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformtransposeSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_transpose_slice_make(size : Int) -> ImagetransformtransposeSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_transpose_slice_len(s : ImagetransformtransposeSlice) -> Int { s.size }

pub fn image_transform_transpose_slice_get(s : ImagetransformtransposeSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_transpose_slice_set(s : ImagetransformtransposeSlice, i : Int, v : Double) -> ImagetransformtransposeSlice {
  let result = image_transform_transpose_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_transpose_slice_sum(s : ImagetransformtransposeSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_transform_transpose_slice_mean(s : ImagetransformtransposeSlice) -> Double {
  if s.size == 0 { 0.0 } else { image_transform_transpose_slice_sum(s) / s.size.to_double() }
}

pub fn image_transform_transpose_slice_scale(s : ImagetransformtransposeSlice, f : Double) -> ImagetransformtransposeSlice {
  let result = image_transform_transpose_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_transpose_slice_add(a : ImagetransformtransposeSlice, b : ImagetransformtransposeSlice) -> ImagetransformtransposeSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_transpose_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_transpose_slice_copy(s : ImagetransformtransposeSlice) -> ImagetransformtransposeSlice {
  let result = image_transform_transpose_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_transpose_slice_fill(s : ImagetransformtransposeSlice, v : Double) -> ImagetransformtransposeSlice {
  let result = image_transform_transpose_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_transpose_slice_min(s : ImagetransformtransposeSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_transpose_slice_max(s : ImagetransformtransposeSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_transpose_slice_to_string(s : ImagetransformtransposeSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


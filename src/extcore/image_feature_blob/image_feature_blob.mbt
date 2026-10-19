///===
/// extcore/image_feature_blob

pub(all) struct ImagefeatureblobPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_feature_blob_make_point(x : Double, y : Double) -> ImagefeatureblobPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_feature_blob_make_point3(x : Double, y : Double, z : Double) -> ImagefeatureblobPoint {
  { x, y, z, label: 0 }
}

pub fn image_feature_blob_point_x(pt : ImagefeatureblobPoint) -> Double { pt.x }

pub fn image_feature_blob_point_y(pt : ImagefeatureblobPoint) -> Double { pt.y }

pub fn image_feature_blob_point_z(pt : ImagefeatureblobPoint) -> Double { pt.z }

pub fn image_feature_blob_point_label(pt : ImagefeatureblobPoint) -> Int { pt.label }

pub fn image_feature_blob_point_dist(a : ImagefeatureblobPoint, b : ImagefeatureblobPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn image_feature_blob_point_add(a : ImagefeatureblobPoint, b : ImagefeatureblobPoint) -> ImagefeatureblobPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn image_feature_blob_point_sub(a : ImagefeatureblobPoint, b : ImagefeatureblobPoint) -> ImagefeatureblobPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn image_feature_blob_point_scale(pt : ImagefeatureblobPoint, s : Double) -> ImagefeatureblobPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn image_feature_blob_point_dot(a : ImagefeatureblobPoint, b : ImagefeatureblobPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn image_feature_blob_point_cross(a : ImagefeatureblobPoint, b : ImagefeatureblobPoint) -> ImagefeatureblobPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn image_feature_blob_point_norm(pt : ImagefeatureblobPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn image_feature_blob_point_normalize(pt : ImagefeatureblobPoint) -> ImagefeatureblobPoint {
  let n = image_feature_blob_point_norm(pt)
  if n < 0.0000001 { pt } else { image_feature_blob_point_scale(pt, 1.0 / n) }
}

pub fn image_feature_blob_point_negate(pt : ImagefeatureblobPoint) -> ImagefeatureblobPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn image_feature_blob_point_mid(a : ImagefeatureblobPoint, b : ImagefeatureblobPoint) -> ImagefeatureblobPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn image_feature_blob_point_lerp(a : ImagefeatureblobPoint, b : ImagefeatureblobPoint, t : Double) -> ImagefeatureblobPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn image_feature_blob_point_to_string(pt : ImagefeatureblobPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct ImagefeatureblobSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_feature_blob_make_series(vals : Array[Double], name : String) -> ImagefeatureblobSeries {
  { vals, name, meta: 0 }
}

pub fn image_feature_blob_series_len(s : ImagefeatureblobSeries) -> Int { s.vals.length() }

pub fn image_feature_blob_series_sum(s : ImagefeatureblobSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn image_feature_blob_series_mean(s : ImagefeatureblobSeries) -> Double {
  let n = image_feature_blob_series_len(s)
  if n == 0 { 0.0 } else { image_feature_blob_series_sum(s) / n.to_double() }
}

pub fn image_feature_blob_series_min(s : ImagefeatureblobSeries) -> Double {
  let n = image_feature_blob_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn image_feature_blob_series_max(s : ImagefeatureblobSeries) -> Double {
  let n = image_feature_blob_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn image_feature_blob_series_range(s : ImagefeatureblobSeries) -> Double {
  image_feature_blob_series_max(s) - image_feature_blob_series_min(s)
}

pub fn image_feature_blob_series_var(s : ImagefeatureblobSeries) -> Double {
  let n = image_feature_blob_series_len(s)
  if n == 0 { 0.0 } else {
    let m = image_feature_blob_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn image_feature_blob_series_std(s : ImagefeatureblobSeries) -> Double { @_common.sqrt(image_feature_blob_series_var(s)) }

pub fn image_feature_blob_series_median(s : ImagefeatureblobSeries) -> Double {
  let n = image_feature_blob_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = image_feature_blob_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn image_feature_blob_series_scale(s : ImagefeatureblobSeries, f : Double) -> ImagefeatureblobSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn image_feature_blob_series_add(a : ImagefeatureblobSeries, b : ImagefeatureblobSeries) -> ImagefeatureblobSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn image_feature_blob_series_sub(a : ImagefeatureblobSeries, b : ImagefeatureblobSeries) -> ImagefeatureblobSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn image_feature_blob_series_normalize(s : ImagefeatureblobSeries) -> ImagefeatureblobSeries {
  let mn = image_feature_blob_series_min(s)
  let mx = image_feature_blob_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn image_feature_blob_series_cumsum(s : ImagefeatureblobSeries) -> ImagefeatureblobSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn image_feature_blob_series_to_string(s : ImagefeatureblobSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagefeatureblobMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_feature_blob_make_matrix(rows : Int, cols : Int, val : Double) -> ImagefeatureblobMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn image_feature_blob_matrix_identity(n : Int) -> ImagefeatureblobMatrix {
  let m = image_feature_blob_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn image_feature_blob_matrix_get(m : ImagefeatureblobMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn image_feature_blob_matrix_transpose(m : ImagefeatureblobMatrix) -> ImagefeatureblobMatrix {
  let result = image_feature_blob_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn image_feature_blob_matrix_add(a : ImagefeatureblobMatrix, b : ImagefeatureblobMatrix) -> ImagefeatureblobMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = image_feature_blob_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn image_feature_blob_matrix_scale(m : ImagefeatureblobMatrix, s : Double) -> ImagefeatureblobMatrix {
  let result = image_feature_blob_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn image_feature_blob_matrix_multiply(a : ImagefeatureblobMatrix, b : ImagefeatureblobMatrix) -> ImagefeatureblobMatrix {
  if a.cols != b.rows { return image_feature_blob_make_matrix(a.rows, b.cols, 0.0) }
  let result = image_feature_blob_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn image_feature_blob_matrix_trace(m : ImagefeatureblobMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn image_feature_blob_matrix_det(m : ImagefeatureblobMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn image_feature_blob_matrix_norm(m : ImagefeatureblobMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn image_feature_blob_matrix_to_string(m : ImagefeatureblobMatrix) -> String {
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

pub(all) struct ImagefeatureblobVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_feature_blob_make_vector(comps : Array[Double]) -> ImagefeatureblobVector {
  { comps, dim: comps.length() }
}

pub fn image_feature_blob_vector_zero(dim : Int) -> ImagefeatureblobVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn image_feature_blob_vector_add(a : ImagefeatureblobVector, b : ImagefeatureblobVector) -> ImagefeatureblobVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn image_feature_blob_vector_sub(a : ImagefeatureblobVector, b : ImagefeatureblobVector) -> ImagefeatureblobVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn image_feature_blob_vector_scale(v : ImagefeatureblobVector, s : Double) -> ImagefeatureblobVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn image_feature_blob_vector_dot(a : ImagefeatureblobVector, b : ImagefeatureblobVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn image_feature_blob_vector_norm(v : ImagefeatureblobVector) -> Double { @_common.sqrt(image_feature_blob_vector_dot(v, v)) }

pub fn image_feature_blob_vector_normalize(v : ImagefeatureblobVector) -> ImagefeatureblobVector {
  let n = image_feature_blob_vector_norm(v)
  if n < 0.0000001 { v } else { image_feature_blob_vector_scale(v, 1.0 / n) }
}

pub fn image_feature_blob_vector_dist(a : ImagefeatureblobVector, b : ImagefeatureblobVector) -> Double {
  image_feature_blob_vector_norm(image_feature_blob_vector_sub(a, b))
}

pub fn image_feature_blob_vector_to_string(v : ImagefeatureblobVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn image_feature_blob_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn image_feature_blob_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = image_feature_blob_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn image_feature_blob_std(data : Array[Double]) -> Double { @_common.sqrt(image_feature_blob_var(data)) }

pub fn image_feature_blob_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = image_feature_blob_mean(a); let mb = image_feature_blob_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn image_feature_blob_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = image_feature_blob_std(a); let sb = image_feature_blob_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { image_feature_blob_cov(a, b) / (sa * sb) }
}

pub fn image_feature_blob_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = image_feature_blob_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn image_feature_blob_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn image_feature_blob_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn image_feature_blob_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(image_feature_blob_mse(pred, labels))
}

pub fn image_feature_blob_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn image_feature_blob_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = image_feature_blob_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn image_feature_blob_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn image_feature_blob_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn image_feature_blob_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = image_feature_blob_precision(pred, labels, pos); let r = image_feature_blob_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn image_feature_blob_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn image_feature_blob_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = image_feature_blob_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn image_feature_blob_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn image_feature_blob_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn image_feature_blob_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = image_feature_blob_gcd(a, b)
    (a / g) * b
  }
}

pub fn image_feature_blob_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn image_feature_blob_fibonacci(n : Int) -> Int {
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

pub fn image_feature_blob_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = image_feature_blob_min(data); let mx = image_feature_blob_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn image_feature_blob_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = image_feature_blob_mean(data); let sd = image_feature_blob_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn image_feature_blob_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn image_feature_blob_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn image_feature_blob_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn image_feature_blob_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn image_feature_blob_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn image_feature_blob_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct ImagefeatureblobFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_blob_frame_make(size : Int) -> ImagefeatureblobFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_blob_frame_len(s : ImagefeatureblobFrame) -> Int { s.size }

pub fn image_feature_blob_frame_get(s : ImagefeatureblobFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_blob_frame_set(s : ImagefeatureblobFrame, i : Int, v : Double) -> ImagefeatureblobFrame {
  let result = image_feature_blob_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_blob_frame_sum(s : ImagefeatureblobFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_blob_frame_mean(s : ImagefeatureblobFrame) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_blob_frame_sum(s) / s.size.to_double() }
}

pub fn image_feature_blob_frame_scale(s : ImagefeatureblobFrame, f : Double) -> ImagefeatureblobFrame {
  let result = image_feature_blob_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_blob_frame_add(a : ImagefeatureblobFrame, b : ImagefeatureblobFrame) -> ImagefeatureblobFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_blob_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_blob_frame_copy(s : ImagefeatureblobFrame) -> ImagefeatureblobFrame {
  let result = image_feature_blob_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_blob_frame_fill(s : ImagefeatureblobFrame, v : Double) -> ImagefeatureblobFrame {
  let result = image_feature_blob_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_blob_frame_min(s : ImagefeatureblobFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_blob_frame_max(s : ImagefeatureblobFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_blob_frame_to_string(s : ImagefeatureblobFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeatureblobTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_blob_table_make(size : Int) -> ImagefeatureblobTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_blob_table_len(s : ImagefeatureblobTable) -> Int { s.size }

pub fn image_feature_blob_table_get(s : ImagefeatureblobTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_blob_table_set(s : ImagefeatureblobTable, i : Int, v : Double) -> ImagefeatureblobTable {
  let result = image_feature_blob_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_blob_table_sum(s : ImagefeatureblobTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_blob_table_mean(s : ImagefeatureblobTable) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_blob_table_sum(s) / s.size.to_double() }
}

pub fn image_feature_blob_table_scale(s : ImagefeatureblobTable, f : Double) -> ImagefeatureblobTable {
  let result = image_feature_blob_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_blob_table_add(a : ImagefeatureblobTable, b : ImagefeatureblobTable) -> ImagefeatureblobTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_blob_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_blob_table_copy(s : ImagefeatureblobTable) -> ImagefeatureblobTable {
  let result = image_feature_blob_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_blob_table_fill(s : ImagefeatureblobTable, v : Double) -> ImagefeatureblobTable {
  let result = image_feature_blob_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_blob_table_min(s : ImagefeatureblobTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_blob_table_max(s : ImagefeatureblobTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_blob_table_to_string(s : ImagefeatureblobTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeatureblobGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_blob_graphn_make(size : Int) -> ImagefeatureblobGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_blob_graphn_len(s : ImagefeatureblobGraphN) -> Int { s.size }

pub fn image_feature_blob_graphn_get(s : ImagefeatureblobGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_blob_graphn_set(s : ImagefeatureblobGraphN, i : Int, v : Double) -> ImagefeatureblobGraphN {
  let result = image_feature_blob_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_blob_graphn_sum(s : ImagefeatureblobGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_blob_graphn_mean(s : ImagefeatureblobGraphN) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_blob_graphn_sum(s) / s.size.to_double() }
}

pub fn image_feature_blob_graphn_scale(s : ImagefeatureblobGraphN, f : Double) -> ImagefeatureblobGraphN {
  let result = image_feature_blob_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_blob_graphn_add(a : ImagefeatureblobGraphN, b : ImagefeatureblobGraphN) -> ImagefeatureblobGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_blob_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_blob_graphn_copy(s : ImagefeatureblobGraphN) -> ImagefeatureblobGraphN {
  let result = image_feature_blob_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_blob_graphn_fill(s : ImagefeatureblobGraphN, v : Double) -> ImagefeatureblobGraphN {
  let result = image_feature_blob_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_blob_graphn_min(s : ImagefeatureblobGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_blob_graphn_max(s : ImagefeatureblobGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_blob_graphn_to_string(s : ImagefeatureblobGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeatureblobNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_blob_node_make(size : Int) -> ImagefeatureblobNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_blob_node_len(s : ImagefeatureblobNode) -> Int { s.size }

pub fn image_feature_blob_node_get(s : ImagefeatureblobNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_blob_node_set(s : ImagefeatureblobNode, i : Int, v : Double) -> ImagefeatureblobNode {
  let result = image_feature_blob_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_blob_node_sum(s : ImagefeatureblobNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_blob_node_mean(s : ImagefeatureblobNode) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_blob_node_sum(s) / s.size.to_double() }
}

pub fn image_feature_blob_node_scale(s : ImagefeatureblobNode, f : Double) -> ImagefeatureblobNode {
  let result = image_feature_blob_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_blob_node_add(a : ImagefeatureblobNode, b : ImagefeatureblobNode) -> ImagefeatureblobNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_blob_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_blob_node_copy(s : ImagefeatureblobNode) -> ImagefeatureblobNode {
  let result = image_feature_blob_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_blob_node_fill(s : ImagefeatureblobNode, v : Double) -> ImagefeatureblobNode {
  let result = image_feature_blob_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_blob_node_min(s : ImagefeatureblobNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_blob_node_max(s : ImagefeatureblobNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_blob_node_to_string(s : ImagefeatureblobNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeatureblobEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_blob_edge_make(size : Int) -> ImagefeatureblobEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_blob_edge_len(s : ImagefeatureblobEdge) -> Int { s.size }

pub fn image_feature_blob_edge_get(s : ImagefeatureblobEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_blob_edge_set(s : ImagefeatureblobEdge, i : Int, v : Double) -> ImagefeatureblobEdge {
  let result = image_feature_blob_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_blob_edge_sum(s : ImagefeatureblobEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_blob_edge_mean(s : ImagefeatureblobEdge) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_blob_edge_sum(s) / s.size.to_double() }
}

pub fn image_feature_blob_edge_scale(s : ImagefeatureblobEdge, f : Double) -> ImagefeatureblobEdge {
  let result = image_feature_blob_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_blob_edge_add(a : ImagefeatureblobEdge, b : ImagefeatureblobEdge) -> ImagefeatureblobEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_blob_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_blob_edge_copy(s : ImagefeatureblobEdge) -> ImagefeatureblobEdge {
  let result = image_feature_blob_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_blob_edge_fill(s : ImagefeatureblobEdge, v : Double) -> ImagefeatureblobEdge {
  let result = image_feature_blob_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_blob_edge_min(s : ImagefeatureblobEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_blob_edge_max(s : ImagefeatureblobEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_blob_edge_to_string(s : ImagefeatureblobEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeatureblobPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_blob_path_make(size : Int) -> ImagefeatureblobPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_blob_path_len(s : ImagefeatureblobPath) -> Int { s.size }

pub fn image_feature_blob_path_get(s : ImagefeatureblobPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_blob_path_set(s : ImagefeatureblobPath, i : Int, v : Double) -> ImagefeatureblobPath {
  let result = image_feature_blob_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_blob_path_sum(s : ImagefeatureblobPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_blob_path_mean(s : ImagefeatureblobPath) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_blob_path_sum(s) / s.size.to_double() }
}

pub fn image_feature_blob_path_scale(s : ImagefeatureblobPath, f : Double) -> ImagefeatureblobPath {
  let result = image_feature_blob_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_blob_path_add(a : ImagefeatureblobPath, b : ImagefeatureblobPath) -> ImagefeatureblobPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_blob_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_blob_path_copy(s : ImagefeatureblobPath) -> ImagefeatureblobPath {
  let result = image_feature_blob_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_blob_path_fill(s : ImagefeatureblobPath, v : Double) -> ImagefeatureblobPath {
  let result = image_feature_blob_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_blob_path_min(s : ImagefeatureblobPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_blob_path_max(s : ImagefeatureblobPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_blob_path_to_string(s : ImagefeatureblobPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeatureblobCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_blob_cluster_make(size : Int) -> ImagefeatureblobCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_blob_cluster_len(s : ImagefeatureblobCluster) -> Int { s.size }

pub fn image_feature_blob_cluster_get(s : ImagefeatureblobCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_blob_cluster_set(s : ImagefeatureblobCluster, i : Int, v : Double) -> ImagefeatureblobCluster {
  let result = image_feature_blob_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_blob_cluster_sum(s : ImagefeatureblobCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_blob_cluster_mean(s : ImagefeatureblobCluster) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_blob_cluster_sum(s) / s.size.to_double() }
}

pub fn image_feature_blob_cluster_scale(s : ImagefeatureblobCluster, f : Double) -> ImagefeatureblobCluster {
  let result = image_feature_blob_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_blob_cluster_add(a : ImagefeatureblobCluster, b : ImagefeatureblobCluster) -> ImagefeatureblobCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_blob_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_blob_cluster_copy(s : ImagefeatureblobCluster) -> ImagefeatureblobCluster {
  let result = image_feature_blob_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_blob_cluster_fill(s : ImagefeatureblobCluster, v : Double) -> ImagefeatureblobCluster {
  let result = image_feature_blob_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_blob_cluster_min(s : ImagefeatureblobCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_blob_cluster_max(s : ImagefeatureblobCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_blob_cluster_to_string(s : ImagefeatureblobCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeatureblobModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_blob_model_make(size : Int) -> ImagefeatureblobModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_blob_model_len(s : ImagefeatureblobModel) -> Int { s.size }

pub fn image_feature_blob_model_get(s : ImagefeatureblobModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_blob_model_set(s : ImagefeatureblobModel, i : Int, v : Double) -> ImagefeatureblobModel {
  let result = image_feature_blob_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_blob_model_sum(s : ImagefeatureblobModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_blob_model_mean(s : ImagefeatureblobModel) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_blob_model_sum(s) / s.size.to_double() }
}

pub fn image_feature_blob_model_scale(s : ImagefeatureblobModel, f : Double) -> ImagefeatureblobModel {
  let result = image_feature_blob_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_blob_model_add(a : ImagefeatureblobModel, b : ImagefeatureblobModel) -> ImagefeatureblobModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_blob_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_blob_model_copy(s : ImagefeatureblobModel) -> ImagefeatureblobModel {
  let result = image_feature_blob_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_blob_model_fill(s : ImagefeatureblobModel, v : Double) -> ImagefeatureblobModel {
  let result = image_feature_blob_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_blob_model_min(s : ImagefeatureblobModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_blob_model_max(s : ImagefeatureblobModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_blob_model_to_string(s : ImagefeatureblobModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeatureblobLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_blob_layer_make(size : Int) -> ImagefeatureblobLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_blob_layer_len(s : ImagefeatureblobLayer) -> Int { s.size }

pub fn image_feature_blob_layer_get(s : ImagefeatureblobLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_blob_layer_set(s : ImagefeatureblobLayer, i : Int, v : Double) -> ImagefeatureblobLayer {
  let result = image_feature_blob_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_blob_layer_sum(s : ImagefeatureblobLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_blob_layer_mean(s : ImagefeatureblobLayer) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_blob_layer_sum(s) / s.size.to_double() }
}

pub fn image_feature_blob_layer_scale(s : ImagefeatureblobLayer, f : Double) -> ImagefeatureblobLayer {
  let result = image_feature_blob_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_blob_layer_add(a : ImagefeatureblobLayer, b : ImagefeatureblobLayer) -> ImagefeatureblobLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_blob_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_blob_layer_copy(s : ImagefeatureblobLayer) -> ImagefeatureblobLayer {
  let result = image_feature_blob_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_blob_layer_fill(s : ImagefeatureblobLayer, v : Double) -> ImagefeatureblobLayer {
  let result = image_feature_blob_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_blob_layer_min(s : ImagefeatureblobLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_blob_layer_max(s : ImagefeatureblobLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_blob_layer_to_string(s : ImagefeatureblobLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeatureblobBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_blob_buffer_make(size : Int) -> ImagefeatureblobBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_blob_buffer_len(s : ImagefeatureblobBuffer) -> Int { s.size }

pub fn image_feature_blob_buffer_get(s : ImagefeatureblobBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_blob_buffer_set(s : ImagefeatureblobBuffer, i : Int, v : Double) -> ImagefeatureblobBuffer {
  let result = image_feature_blob_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_blob_buffer_sum(s : ImagefeatureblobBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_blob_buffer_mean(s : ImagefeatureblobBuffer) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_blob_buffer_sum(s) / s.size.to_double() }
}

pub fn image_feature_blob_buffer_scale(s : ImagefeatureblobBuffer, f : Double) -> ImagefeatureblobBuffer {
  let result = image_feature_blob_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_blob_buffer_add(a : ImagefeatureblobBuffer, b : ImagefeatureblobBuffer) -> ImagefeatureblobBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_blob_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_blob_buffer_copy(s : ImagefeatureblobBuffer) -> ImagefeatureblobBuffer {
  let result = image_feature_blob_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_blob_buffer_fill(s : ImagefeatureblobBuffer, v : Double) -> ImagefeatureblobBuffer {
  let result = image_feature_blob_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_blob_buffer_min(s : ImagefeatureblobBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_blob_buffer_max(s : ImagefeatureblobBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_blob_buffer_to_string(s : ImagefeatureblobBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeatureblobCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_blob_cursor_make(size : Int) -> ImagefeatureblobCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_blob_cursor_len(s : ImagefeatureblobCursor) -> Int { s.size }

pub fn image_feature_blob_cursor_get(s : ImagefeatureblobCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_blob_cursor_set(s : ImagefeatureblobCursor, i : Int, v : Double) -> ImagefeatureblobCursor {
  let result = image_feature_blob_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_blob_cursor_sum(s : ImagefeatureblobCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_blob_cursor_mean(s : ImagefeatureblobCursor) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_blob_cursor_sum(s) / s.size.to_double() }
}

pub fn image_feature_blob_cursor_scale(s : ImagefeatureblobCursor, f : Double) -> ImagefeatureblobCursor {
  let result = image_feature_blob_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_blob_cursor_add(a : ImagefeatureblobCursor, b : ImagefeatureblobCursor) -> ImagefeatureblobCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_blob_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_blob_cursor_copy(s : ImagefeatureblobCursor) -> ImagefeatureblobCursor {
  let result = image_feature_blob_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_blob_cursor_fill(s : ImagefeatureblobCursor, v : Double) -> ImagefeatureblobCursor {
  let result = image_feature_blob_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_blob_cursor_min(s : ImagefeatureblobCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_blob_cursor_max(s : ImagefeatureblobCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_blob_cursor_to_string(s : ImagefeatureblobCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeatureblobView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_blob_view_make(size : Int) -> ImagefeatureblobView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_blob_view_len(s : ImagefeatureblobView) -> Int { s.size }

pub fn image_feature_blob_view_get(s : ImagefeatureblobView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_blob_view_set(s : ImagefeatureblobView, i : Int, v : Double) -> ImagefeatureblobView {
  let result = image_feature_blob_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_blob_view_sum(s : ImagefeatureblobView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_blob_view_mean(s : ImagefeatureblobView) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_blob_view_sum(s) / s.size.to_double() }
}

pub fn image_feature_blob_view_scale(s : ImagefeatureblobView, f : Double) -> ImagefeatureblobView {
  let result = image_feature_blob_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_blob_view_add(a : ImagefeatureblobView, b : ImagefeatureblobView) -> ImagefeatureblobView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_blob_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_blob_view_copy(s : ImagefeatureblobView) -> ImagefeatureblobView {
  let result = image_feature_blob_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_blob_view_fill(s : ImagefeatureblobView, v : Double) -> ImagefeatureblobView {
  let result = image_feature_blob_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_blob_view_min(s : ImagefeatureblobView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_blob_view_max(s : ImagefeatureblobView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_blob_view_to_string(s : ImagefeatureblobView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeatureblobRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_blob_range_make(size : Int) -> ImagefeatureblobRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_blob_range_len(s : ImagefeatureblobRange) -> Int { s.size }

pub fn image_feature_blob_range_get(s : ImagefeatureblobRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_blob_range_set(s : ImagefeatureblobRange, i : Int, v : Double) -> ImagefeatureblobRange {
  let result = image_feature_blob_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_blob_range_sum(s : ImagefeatureblobRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_blob_range_mean(s : ImagefeatureblobRange) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_blob_range_sum(s) / s.size.to_double() }
}

pub fn image_feature_blob_range_scale(s : ImagefeatureblobRange, f : Double) -> ImagefeatureblobRange {
  let result = image_feature_blob_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_blob_range_add(a : ImagefeatureblobRange, b : ImagefeatureblobRange) -> ImagefeatureblobRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_blob_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_blob_range_copy(s : ImagefeatureblobRange) -> ImagefeatureblobRange {
  let result = image_feature_blob_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_blob_range_fill(s : ImagefeatureblobRange, v : Double) -> ImagefeatureblobRange {
  let result = image_feature_blob_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_blob_range_min(s : ImagefeatureblobRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_blob_range_max(s : ImagefeatureblobRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_blob_range_to_string(s : ImagefeatureblobRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeatureblobSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_blob_slice_make(size : Int) -> ImagefeatureblobSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_blob_slice_len(s : ImagefeatureblobSlice) -> Int { s.size }

pub fn image_feature_blob_slice_get(s : ImagefeatureblobSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_blob_slice_set(s : ImagefeatureblobSlice, i : Int, v : Double) -> ImagefeatureblobSlice {
  let result = image_feature_blob_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_blob_slice_sum(s : ImagefeatureblobSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_blob_slice_mean(s : ImagefeatureblobSlice) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_blob_slice_sum(s) / s.size.to_double() }
}

pub fn image_feature_blob_slice_scale(s : ImagefeatureblobSlice, f : Double) -> ImagefeatureblobSlice {
  let result = image_feature_blob_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_blob_slice_add(a : ImagefeatureblobSlice, b : ImagefeatureblobSlice) -> ImagefeatureblobSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_blob_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_blob_slice_copy(s : ImagefeatureblobSlice) -> ImagefeatureblobSlice {
  let result = image_feature_blob_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_blob_slice_fill(s : ImagefeatureblobSlice, v : Double) -> ImagefeatureblobSlice {
  let result = image_feature_blob_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_blob_slice_min(s : ImagefeatureblobSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_blob_slice_max(s : ImagefeatureblobSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_blob_slice_to_string(s : ImagefeatureblobSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


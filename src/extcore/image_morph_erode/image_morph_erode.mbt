///===
/// extcore/image_morph_erode

pub(all) struct ImagemorpherodePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_morph_erode_make_point(x : Double, y : Double) -> ImagemorpherodePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_morph_erode_make_point3(x : Double, y : Double, z : Double) -> ImagemorpherodePoint {
  { x, y, z, label: 0 }
}

pub fn image_morph_erode_point_x(pt : ImagemorpherodePoint) -> Double { pt.x }

pub fn image_morph_erode_point_y(pt : ImagemorpherodePoint) -> Double { pt.y }

pub fn image_morph_erode_point_z(pt : ImagemorpherodePoint) -> Double { pt.z }

pub fn image_morph_erode_point_label(pt : ImagemorpherodePoint) -> Int { pt.label }

pub fn image_morph_erode_point_dist(a : ImagemorpherodePoint, b : ImagemorpherodePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn image_morph_erode_point_add(a : ImagemorpherodePoint, b : ImagemorpherodePoint) -> ImagemorpherodePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn image_morph_erode_point_sub(a : ImagemorpherodePoint, b : ImagemorpherodePoint) -> ImagemorpherodePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn image_morph_erode_point_scale(pt : ImagemorpherodePoint, s : Double) -> ImagemorpherodePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn image_morph_erode_point_dot(a : ImagemorpherodePoint, b : ImagemorpherodePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn image_morph_erode_point_cross(a : ImagemorpherodePoint, b : ImagemorpherodePoint) -> ImagemorpherodePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn image_morph_erode_point_norm(pt : ImagemorpherodePoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn image_morph_erode_point_normalize(pt : ImagemorpherodePoint) -> ImagemorpherodePoint {
  let n = image_morph_erode_point_norm(pt)
  if n < 0.0000001 { pt } else { image_morph_erode_point_scale(pt, 1.0 / n) }
}

pub fn image_morph_erode_point_negate(pt : ImagemorpherodePoint) -> ImagemorpherodePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn image_morph_erode_point_mid(a : ImagemorpherodePoint, b : ImagemorpherodePoint) -> ImagemorpherodePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn image_morph_erode_point_lerp(a : ImagemorpherodePoint, b : ImagemorpherodePoint, t : Double) -> ImagemorpherodePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn image_morph_erode_point_to_string(pt : ImagemorpherodePoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct ImagemorpherodeSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_morph_erode_make_series(vals : Array[Double], name : String) -> ImagemorpherodeSeries {
  { vals, name, meta: 0 }
}

pub fn image_morph_erode_series_len(s : ImagemorpherodeSeries) -> Int { s.vals.length() }

pub fn image_morph_erode_series_sum(s : ImagemorpherodeSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn image_morph_erode_series_mean(s : ImagemorpherodeSeries) -> Double {
  let n = image_morph_erode_series_len(s)
  if n == 0 { 0.0 } else { image_morph_erode_series_sum(s) / n.to_double() }
}

pub fn image_morph_erode_series_min(s : ImagemorpherodeSeries) -> Double {
  let n = image_morph_erode_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn image_morph_erode_series_max(s : ImagemorpherodeSeries) -> Double {
  let n = image_morph_erode_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn image_morph_erode_series_range(s : ImagemorpherodeSeries) -> Double {
  image_morph_erode_series_max(s) - image_morph_erode_series_min(s)
}

pub fn image_morph_erode_series_var(s : ImagemorpherodeSeries) -> Double {
  let n = image_morph_erode_series_len(s)
  if n == 0 { 0.0 } else {
    let m = image_morph_erode_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn image_morph_erode_series_std(s : ImagemorpherodeSeries) -> Double { @_common.sqrt(image_morph_erode_series_var(s)) }

pub fn image_morph_erode_series_median(s : ImagemorpherodeSeries) -> Double {
  let n = image_morph_erode_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = image_morph_erode_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn image_morph_erode_series_scale(s : ImagemorpherodeSeries, f : Double) -> ImagemorpherodeSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn image_morph_erode_series_add(a : ImagemorpherodeSeries, b : ImagemorpherodeSeries) -> ImagemorpherodeSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn image_morph_erode_series_sub(a : ImagemorpherodeSeries, b : ImagemorpherodeSeries) -> ImagemorpherodeSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn image_morph_erode_series_normalize(s : ImagemorpherodeSeries) -> ImagemorpherodeSeries {
  let mn = image_morph_erode_series_min(s)
  let mx = image_morph_erode_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn image_morph_erode_series_cumsum(s : ImagemorpherodeSeries) -> ImagemorpherodeSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn image_morph_erode_series_to_string(s : ImagemorpherodeSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagemorpherodeMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_morph_erode_make_matrix(rows : Int, cols : Int, val : Double) -> ImagemorpherodeMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn image_morph_erode_matrix_identity(n : Int) -> ImagemorpherodeMatrix {
  let m = image_morph_erode_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn image_morph_erode_matrix_get(m : ImagemorpherodeMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn image_morph_erode_matrix_transpose(m : ImagemorpherodeMatrix) -> ImagemorpherodeMatrix {
  let result = image_morph_erode_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn image_morph_erode_matrix_add(a : ImagemorpherodeMatrix, b : ImagemorpherodeMatrix) -> ImagemorpherodeMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = image_morph_erode_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn image_morph_erode_matrix_scale(m : ImagemorpherodeMatrix, s : Double) -> ImagemorpherodeMatrix {
  let result = image_morph_erode_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn image_morph_erode_matrix_multiply(a : ImagemorpherodeMatrix, b : ImagemorpherodeMatrix) -> ImagemorpherodeMatrix {
  if a.cols != b.rows { return image_morph_erode_make_matrix(a.rows, b.cols, 0.0) }
  let result = image_morph_erode_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn image_morph_erode_matrix_trace(m : ImagemorpherodeMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn image_morph_erode_matrix_det(m : ImagemorpherodeMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn image_morph_erode_matrix_norm(m : ImagemorpherodeMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn image_morph_erode_matrix_to_string(m : ImagemorpherodeMatrix) -> String {
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

pub(all) struct ImagemorpherodeVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_morph_erode_make_vector(comps : Array[Double]) -> ImagemorpherodeVector {
  { comps, dim: comps.length() }
}

pub fn image_morph_erode_vector_zero(dim : Int) -> ImagemorpherodeVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn image_morph_erode_vector_add(a : ImagemorpherodeVector, b : ImagemorpherodeVector) -> ImagemorpherodeVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn image_morph_erode_vector_sub(a : ImagemorpherodeVector, b : ImagemorpherodeVector) -> ImagemorpherodeVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn image_morph_erode_vector_scale(v : ImagemorpherodeVector, s : Double) -> ImagemorpherodeVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn image_morph_erode_vector_dot(a : ImagemorpherodeVector, b : ImagemorpherodeVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn image_morph_erode_vector_norm(v : ImagemorpherodeVector) -> Double { @_common.sqrt(image_morph_erode_vector_dot(v, v)) }

pub fn image_morph_erode_vector_normalize(v : ImagemorpherodeVector) -> ImagemorpherodeVector {
  let n = image_morph_erode_vector_norm(v)
  if n < 0.0000001 { v } else { image_morph_erode_vector_scale(v, 1.0 / n) }
}

pub fn image_morph_erode_vector_dist(a : ImagemorpherodeVector, b : ImagemorpherodeVector) -> Double {
  image_morph_erode_vector_norm(image_morph_erode_vector_sub(a, b))
}

pub fn image_morph_erode_vector_to_string(v : ImagemorpherodeVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn image_morph_erode_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn image_morph_erode_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = image_morph_erode_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn image_morph_erode_std(data : Array[Double]) -> Double { @_common.sqrt(image_morph_erode_var(data)) }

pub fn image_morph_erode_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = image_morph_erode_mean(a); let mb = image_morph_erode_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn image_morph_erode_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = image_morph_erode_std(a); let sb = image_morph_erode_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { image_morph_erode_cov(a, b) / (sa * sb) }
}

pub fn image_morph_erode_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = image_morph_erode_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn image_morph_erode_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn image_morph_erode_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn image_morph_erode_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(image_morph_erode_mse(pred, labels))
}

pub fn image_morph_erode_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn image_morph_erode_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = image_morph_erode_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn image_morph_erode_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn image_morph_erode_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn image_morph_erode_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = image_morph_erode_precision(pred, labels, pos); let r = image_morph_erode_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn image_morph_erode_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn image_morph_erode_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = image_morph_erode_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn image_morph_erode_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn image_morph_erode_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn image_morph_erode_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = image_morph_erode_gcd(a, b)
    (a / g) * b
  }
}

pub fn image_morph_erode_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn image_morph_erode_fibonacci(n : Int) -> Int {
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

pub fn image_morph_erode_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = image_morph_erode_min(data); let mx = image_morph_erode_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn image_morph_erode_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = image_morph_erode_mean(data); let sd = image_morph_erode_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn image_morph_erode_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn image_morph_erode_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn image_morph_erode_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn image_morph_erode_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn image_morph_erode_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn image_morph_erode_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct ImagemorpherodeFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_erode_frame_make(size : Int) -> ImagemorpherodeFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_erode_frame_len(s : ImagemorpherodeFrame) -> Int { s.size }

pub fn image_morph_erode_frame_get(s : ImagemorpherodeFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_erode_frame_set(s : ImagemorpherodeFrame, i : Int, v : Double) -> ImagemorpherodeFrame {
  let result = image_morph_erode_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_erode_frame_sum(s : ImagemorpherodeFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_morph_erode_frame_mean(s : ImagemorpherodeFrame) -> Double {
  if s.size == 0 { 0.0 } else { image_morph_erode_frame_sum(s) / s.size.to_double() }
}

pub fn image_morph_erode_frame_scale(s : ImagemorpherodeFrame, f : Double) -> ImagemorpherodeFrame {
  let result = image_morph_erode_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_erode_frame_add(a : ImagemorpherodeFrame, b : ImagemorpherodeFrame) -> ImagemorpherodeFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_erode_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_erode_frame_copy(s : ImagemorpherodeFrame) -> ImagemorpherodeFrame {
  let result = image_morph_erode_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_erode_frame_fill(s : ImagemorpherodeFrame, v : Double) -> ImagemorpherodeFrame {
  let result = image_morph_erode_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_erode_frame_min(s : ImagemorpherodeFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_erode_frame_max(s : ImagemorpherodeFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_erode_frame_to_string(s : ImagemorpherodeFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorpherodeTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_erode_table_make(size : Int) -> ImagemorpherodeTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_erode_table_len(s : ImagemorpherodeTable) -> Int { s.size }

pub fn image_morph_erode_table_get(s : ImagemorpherodeTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_erode_table_set(s : ImagemorpherodeTable, i : Int, v : Double) -> ImagemorpherodeTable {
  let result = image_morph_erode_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_erode_table_sum(s : ImagemorpherodeTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_morph_erode_table_mean(s : ImagemorpherodeTable) -> Double {
  if s.size == 0 { 0.0 } else { image_morph_erode_table_sum(s) / s.size.to_double() }
}

pub fn image_morph_erode_table_scale(s : ImagemorpherodeTable, f : Double) -> ImagemorpherodeTable {
  let result = image_morph_erode_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_erode_table_add(a : ImagemorpherodeTable, b : ImagemorpherodeTable) -> ImagemorpherodeTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_erode_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_erode_table_copy(s : ImagemorpherodeTable) -> ImagemorpherodeTable {
  let result = image_morph_erode_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_erode_table_fill(s : ImagemorpherodeTable, v : Double) -> ImagemorpherodeTable {
  let result = image_morph_erode_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_erode_table_min(s : ImagemorpherodeTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_erode_table_max(s : ImagemorpherodeTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_erode_table_to_string(s : ImagemorpherodeTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorpherodeGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_erode_graphn_make(size : Int) -> ImagemorpherodeGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_erode_graphn_len(s : ImagemorpherodeGraphN) -> Int { s.size }

pub fn image_morph_erode_graphn_get(s : ImagemorpherodeGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_erode_graphn_set(s : ImagemorpherodeGraphN, i : Int, v : Double) -> ImagemorpherodeGraphN {
  let result = image_morph_erode_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_erode_graphn_sum(s : ImagemorpherodeGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_morph_erode_graphn_mean(s : ImagemorpherodeGraphN) -> Double {
  if s.size == 0 { 0.0 } else { image_morph_erode_graphn_sum(s) / s.size.to_double() }
}

pub fn image_morph_erode_graphn_scale(s : ImagemorpherodeGraphN, f : Double) -> ImagemorpherodeGraphN {
  let result = image_morph_erode_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_erode_graphn_add(a : ImagemorpherodeGraphN, b : ImagemorpherodeGraphN) -> ImagemorpherodeGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_erode_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_erode_graphn_copy(s : ImagemorpherodeGraphN) -> ImagemorpherodeGraphN {
  let result = image_morph_erode_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_erode_graphn_fill(s : ImagemorpherodeGraphN, v : Double) -> ImagemorpherodeGraphN {
  let result = image_morph_erode_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_erode_graphn_min(s : ImagemorpherodeGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_erode_graphn_max(s : ImagemorpherodeGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_erode_graphn_to_string(s : ImagemorpherodeGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorpherodeNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_erode_node_make(size : Int) -> ImagemorpherodeNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_erode_node_len(s : ImagemorpherodeNode) -> Int { s.size }

pub fn image_morph_erode_node_get(s : ImagemorpherodeNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_erode_node_set(s : ImagemorpherodeNode, i : Int, v : Double) -> ImagemorpherodeNode {
  let result = image_morph_erode_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_erode_node_sum(s : ImagemorpherodeNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_morph_erode_node_mean(s : ImagemorpherodeNode) -> Double {
  if s.size == 0 { 0.0 } else { image_morph_erode_node_sum(s) / s.size.to_double() }
}

pub fn image_morph_erode_node_scale(s : ImagemorpherodeNode, f : Double) -> ImagemorpherodeNode {
  let result = image_morph_erode_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_erode_node_add(a : ImagemorpherodeNode, b : ImagemorpherodeNode) -> ImagemorpherodeNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_erode_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_erode_node_copy(s : ImagemorpherodeNode) -> ImagemorpherodeNode {
  let result = image_morph_erode_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_erode_node_fill(s : ImagemorpherodeNode, v : Double) -> ImagemorpherodeNode {
  let result = image_morph_erode_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_erode_node_min(s : ImagemorpherodeNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_erode_node_max(s : ImagemorpherodeNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_erode_node_to_string(s : ImagemorpherodeNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorpherodeEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_erode_edge_make(size : Int) -> ImagemorpherodeEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_erode_edge_len(s : ImagemorpherodeEdge) -> Int { s.size }

pub fn image_morph_erode_edge_get(s : ImagemorpherodeEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_erode_edge_set(s : ImagemorpherodeEdge, i : Int, v : Double) -> ImagemorpherodeEdge {
  let result = image_morph_erode_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_erode_edge_sum(s : ImagemorpherodeEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_morph_erode_edge_mean(s : ImagemorpherodeEdge) -> Double {
  if s.size == 0 { 0.0 } else { image_morph_erode_edge_sum(s) / s.size.to_double() }
}

pub fn image_morph_erode_edge_scale(s : ImagemorpherodeEdge, f : Double) -> ImagemorpherodeEdge {
  let result = image_morph_erode_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_erode_edge_add(a : ImagemorpherodeEdge, b : ImagemorpherodeEdge) -> ImagemorpherodeEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_erode_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_erode_edge_copy(s : ImagemorpherodeEdge) -> ImagemorpherodeEdge {
  let result = image_morph_erode_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_erode_edge_fill(s : ImagemorpherodeEdge, v : Double) -> ImagemorpherodeEdge {
  let result = image_morph_erode_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_erode_edge_min(s : ImagemorpherodeEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_erode_edge_max(s : ImagemorpherodeEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_erode_edge_to_string(s : ImagemorpherodeEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorpherodePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_erode_path_make(size : Int) -> ImagemorpherodePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_erode_path_len(s : ImagemorpherodePath) -> Int { s.size }

pub fn image_morph_erode_path_get(s : ImagemorpherodePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_erode_path_set(s : ImagemorpherodePath, i : Int, v : Double) -> ImagemorpherodePath {
  let result = image_morph_erode_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_erode_path_sum(s : ImagemorpherodePath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_morph_erode_path_mean(s : ImagemorpherodePath) -> Double {
  if s.size == 0 { 0.0 } else { image_morph_erode_path_sum(s) / s.size.to_double() }
}

pub fn image_morph_erode_path_scale(s : ImagemorpherodePath, f : Double) -> ImagemorpherodePath {
  let result = image_morph_erode_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_erode_path_add(a : ImagemorpherodePath, b : ImagemorpherodePath) -> ImagemorpherodePath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_erode_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_erode_path_copy(s : ImagemorpherodePath) -> ImagemorpherodePath {
  let result = image_morph_erode_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_erode_path_fill(s : ImagemorpherodePath, v : Double) -> ImagemorpherodePath {
  let result = image_morph_erode_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_erode_path_min(s : ImagemorpherodePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_erode_path_max(s : ImagemorpherodePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_erode_path_to_string(s : ImagemorpherodePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorpherodeCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_erode_cluster_make(size : Int) -> ImagemorpherodeCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_erode_cluster_len(s : ImagemorpherodeCluster) -> Int { s.size }

pub fn image_morph_erode_cluster_get(s : ImagemorpherodeCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_erode_cluster_set(s : ImagemorpherodeCluster, i : Int, v : Double) -> ImagemorpherodeCluster {
  let result = image_morph_erode_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_erode_cluster_sum(s : ImagemorpherodeCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_morph_erode_cluster_mean(s : ImagemorpherodeCluster) -> Double {
  if s.size == 0 { 0.0 } else { image_morph_erode_cluster_sum(s) / s.size.to_double() }
}

pub fn image_morph_erode_cluster_scale(s : ImagemorpherodeCluster, f : Double) -> ImagemorpherodeCluster {
  let result = image_morph_erode_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_erode_cluster_add(a : ImagemorpherodeCluster, b : ImagemorpherodeCluster) -> ImagemorpherodeCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_erode_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_erode_cluster_copy(s : ImagemorpherodeCluster) -> ImagemorpherodeCluster {
  let result = image_morph_erode_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_erode_cluster_fill(s : ImagemorpherodeCluster, v : Double) -> ImagemorpherodeCluster {
  let result = image_morph_erode_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_erode_cluster_min(s : ImagemorpherodeCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_erode_cluster_max(s : ImagemorpherodeCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_erode_cluster_to_string(s : ImagemorpherodeCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorpherodeModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_erode_model_make(size : Int) -> ImagemorpherodeModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_erode_model_len(s : ImagemorpherodeModel) -> Int { s.size }

pub fn image_morph_erode_model_get(s : ImagemorpherodeModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_erode_model_set(s : ImagemorpherodeModel, i : Int, v : Double) -> ImagemorpherodeModel {
  let result = image_morph_erode_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_erode_model_sum(s : ImagemorpherodeModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_morph_erode_model_mean(s : ImagemorpherodeModel) -> Double {
  if s.size == 0 { 0.0 } else { image_morph_erode_model_sum(s) / s.size.to_double() }
}

pub fn image_morph_erode_model_scale(s : ImagemorpherodeModel, f : Double) -> ImagemorpherodeModel {
  let result = image_morph_erode_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_erode_model_add(a : ImagemorpherodeModel, b : ImagemorpherodeModel) -> ImagemorpherodeModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_erode_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_erode_model_copy(s : ImagemorpherodeModel) -> ImagemorpherodeModel {
  let result = image_morph_erode_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_erode_model_fill(s : ImagemorpherodeModel, v : Double) -> ImagemorpherodeModel {
  let result = image_morph_erode_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_erode_model_min(s : ImagemorpherodeModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_erode_model_max(s : ImagemorpherodeModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_erode_model_to_string(s : ImagemorpherodeModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorpherodeLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_erode_layer_make(size : Int) -> ImagemorpherodeLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_erode_layer_len(s : ImagemorpherodeLayer) -> Int { s.size }

pub fn image_morph_erode_layer_get(s : ImagemorpherodeLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_erode_layer_set(s : ImagemorpherodeLayer, i : Int, v : Double) -> ImagemorpherodeLayer {
  let result = image_morph_erode_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_erode_layer_sum(s : ImagemorpherodeLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_morph_erode_layer_mean(s : ImagemorpherodeLayer) -> Double {
  if s.size == 0 { 0.0 } else { image_morph_erode_layer_sum(s) / s.size.to_double() }
}

pub fn image_morph_erode_layer_scale(s : ImagemorpherodeLayer, f : Double) -> ImagemorpherodeLayer {
  let result = image_morph_erode_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_erode_layer_add(a : ImagemorpherodeLayer, b : ImagemorpherodeLayer) -> ImagemorpherodeLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_erode_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_erode_layer_copy(s : ImagemorpherodeLayer) -> ImagemorpherodeLayer {
  let result = image_morph_erode_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_erode_layer_fill(s : ImagemorpherodeLayer, v : Double) -> ImagemorpherodeLayer {
  let result = image_morph_erode_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_erode_layer_min(s : ImagemorpherodeLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_erode_layer_max(s : ImagemorpherodeLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_erode_layer_to_string(s : ImagemorpherodeLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorpherodeBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_erode_buffer_make(size : Int) -> ImagemorpherodeBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_erode_buffer_len(s : ImagemorpherodeBuffer) -> Int { s.size }

pub fn image_morph_erode_buffer_get(s : ImagemorpherodeBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_erode_buffer_set(s : ImagemorpherodeBuffer, i : Int, v : Double) -> ImagemorpherodeBuffer {
  let result = image_morph_erode_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_erode_buffer_sum(s : ImagemorpherodeBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_morph_erode_buffer_mean(s : ImagemorpherodeBuffer) -> Double {
  if s.size == 0 { 0.0 } else { image_morph_erode_buffer_sum(s) / s.size.to_double() }
}

pub fn image_morph_erode_buffer_scale(s : ImagemorpherodeBuffer, f : Double) -> ImagemorpherodeBuffer {
  let result = image_morph_erode_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_erode_buffer_add(a : ImagemorpherodeBuffer, b : ImagemorpherodeBuffer) -> ImagemorpherodeBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_erode_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_erode_buffer_copy(s : ImagemorpherodeBuffer) -> ImagemorpherodeBuffer {
  let result = image_morph_erode_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_erode_buffer_fill(s : ImagemorpherodeBuffer, v : Double) -> ImagemorpherodeBuffer {
  let result = image_morph_erode_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_erode_buffer_min(s : ImagemorpherodeBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_erode_buffer_max(s : ImagemorpherodeBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_erode_buffer_to_string(s : ImagemorpherodeBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorpherodeCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_erode_cursor_make(size : Int) -> ImagemorpherodeCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_erode_cursor_len(s : ImagemorpherodeCursor) -> Int { s.size }

pub fn image_morph_erode_cursor_get(s : ImagemorpherodeCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_erode_cursor_set(s : ImagemorpherodeCursor, i : Int, v : Double) -> ImagemorpherodeCursor {
  let result = image_morph_erode_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_erode_cursor_sum(s : ImagemorpherodeCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_morph_erode_cursor_mean(s : ImagemorpherodeCursor) -> Double {
  if s.size == 0 { 0.0 } else { image_morph_erode_cursor_sum(s) / s.size.to_double() }
}

pub fn image_morph_erode_cursor_scale(s : ImagemorpherodeCursor, f : Double) -> ImagemorpherodeCursor {
  let result = image_morph_erode_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_erode_cursor_add(a : ImagemorpherodeCursor, b : ImagemorpherodeCursor) -> ImagemorpherodeCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_erode_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_erode_cursor_copy(s : ImagemorpherodeCursor) -> ImagemorpherodeCursor {
  let result = image_morph_erode_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_erode_cursor_fill(s : ImagemorpherodeCursor, v : Double) -> ImagemorpherodeCursor {
  let result = image_morph_erode_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_erode_cursor_min(s : ImagemorpherodeCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_erode_cursor_max(s : ImagemorpherodeCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_erode_cursor_to_string(s : ImagemorpherodeCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorpherodeView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_erode_view_make(size : Int) -> ImagemorpherodeView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_erode_view_len(s : ImagemorpherodeView) -> Int { s.size }

pub fn image_morph_erode_view_get(s : ImagemorpherodeView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_erode_view_set(s : ImagemorpherodeView, i : Int, v : Double) -> ImagemorpherodeView {
  let result = image_morph_erode_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_erode_view_sum(s : ImagemorpherodeView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_morph_erode_view_mean(s : ImagemorpherodeView) -> Double {
  if s.size == 0 { 0.0 } else { image_morph_erode_view_sum(s) / s.size.to_double() }
}

pub fn image_morph_erode_view_scale(s : ImagemorpherodeView, f : Double) -> ImagemorpherodeView {
  let result = image_morph_erode_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_erode_view_add(a : ImagemorpherodeView, b : ImagemorpherodeView) -> ImagemorpherodeView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_erode_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_erode_view_copy(s : ImagemorpherodeView) -> ImagemorpherodeView {
  let result = image_morph_erode_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_erode_view_fill(s : ImagemorpherodeView, v : Double) -> ImagemorpherodeView {
  let result = image_morph_erode_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_erode_view_min(s : ImagemorpherodeView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_erode_view_max(s : ImagemorpherodeView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_erode_view_to_string(s : ImagemorpherodeView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorpherodeRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_erode_range_make(size : Int) -> ImagemorpherodeRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_erode_range_len(s : ImagemorpherodeRange) -> Int { s.size }

pub fn image_morph_erode_range_get(s : ImagemorpherodeRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_erode_range_set(s : ImagemorpherodeRange, i : Int, v : Double) -> ImagemorpherodeRange {
  let result = image_morph_erode_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_erode_range_sum(s : ImagemorpherodeRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_morph_erode_range_mean(s : ImagemorpherodeRange) -> Double {
  if s.size == 0 { 0.0 } else { image_morph_erode_range_sum(s) / s.size.to_double() }
}

pub fn image_morph_erode_range_scale(s : ImagemorpherodeRange, f : Double) -> ImagemorpherodeRange {
  let result = image_morph_erode_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_erode_range_add(a : ImagemorpherodeRange, b : ImagemorpherodeRange) -> ImagemorpherodeRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_erode_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_erode_range_copy(s : ImagemorpherodeRange) -> ImagemorpherodeRange {
  let result = image_morph_erode_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_erode_range_fill(s : ImagemorpherodeRange, v : Double) -> ImagemorpherodeRange {
  let result = image_morph_erode_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_erode_range_min(s : ImagemorpherodeRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_erode_range_max(s : ImagemorpherodeRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_erode_range_to_string(s : ImagemorpherodeRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorpherodeSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_erode_slice_make(size : Int) -> ImagemorpherodeSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_erode_slice_len(s : ImagemorpherodeSlice) -> Int { s.size }

pub fn image_morph_erode_slice_get(s : ImagemorpherodeSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_erode_slice_set(s : ImagemorpherodeSlice, i : Int, v : Double) -> ImagemorpherodeSlice {
  let result = image_morph_erode_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_erode_slice_sum(s : ImagemorpherodeSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_morph_erode_slice_mean(s : ImagemorpherodeSlice) -> Double {
  if s.size == 0 { 0.0 } else { image_morph_erode_slice_sum(s) / s.size.to_double() }
}

pub fn image_morph_erode_slice_scale(s : ImagemorpherodeSlice, f : Double) -> ImagemorpherodeSlice {
  let result = image_morph_erode_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_erode_slice_add(a : ImagemorpherodeSlice, b : ImagemorpherodeSlice) -> ImagemorpherodeSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_erode_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_erode_slice_copy(s : ImagemorpherodeSlice) -> ImagemorpherodeSlice {
  let result = image_morph_erode_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_erode_slice_fill(s : ImagemorpherodeSlice, v : Double) -> ImagemorpherodeSlice {
  let result = image_morph_erode_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_erode_slice_min(s : ImagemorpherodeSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_erode_slice_max(s : ImagemorpherodeSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_erode_slice_to_string(s : ImagemorpherodeSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


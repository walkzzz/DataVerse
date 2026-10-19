///===
/// extcore/image_filter_gabor

pub(all) struct ImagefiltergaborPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_filter_gabor_make_point(x : Double, y : Double) -> ImagefiltergaborPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_filter_gabor_make_point3(x : Double, y : Double, z : Double) -> ImagefiltergaborPoint {
  { x, y, z, label: 0 }
}

pub fn image_filter_gabor_point_x(pt : ImagefiltergaborPoint) -> Double { pt.x }

pub fn image_filter_gabor_point_y(pt : ImagefiltergaborPoint) -> Double { pt.y }

pub fn image_filter_gabor_point_z(pt : ImagefiltergaborPoint) -> Double { pt.z }

pub fn image_filter_gabor_point_label(pt : ImagefiltergaborPoint) -> Int { pt.label }

pub fn image_filter_gabor_point_dist(a : ImagefiltergaborPoint, b : ImagefiltergaborPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  image_filter_gabor_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn image_filter_gabor_point_add(a : ImagefiltergaborPoint, b : ImagefiltergaborPoint) -> ImagefiltergaborPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn image_filter_gabor_point_sub(a : ImagefiltergaborPoint, b : ImagefiltergaborPoint) -> ImagefiltergaborPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn image_filter_gabor_point_scale(pt : ImagefiltergaborPoint, s : Double) -> ImagefiltergaborPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn image_filter_gabor_point_dot(a : ImagefiltergaborPoint, b : ImagefiltergaborPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn image_filter_gabor_point_cross(a : ImagefiltergaborPoint, b : ImagefiltergaborPoint) -> ImagefiltergaborPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn image_filter_gabor_point_norm(pt : ImagefiltergaborPoint) -> Double {
  image_filter_gabor_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn image_filter_gabor_point_normalize(pt : ImagefiltergaborPoint) -> ImagefiltergaborPoint {
  let n = image_filter_gabor_point_norm(pt)
  if n < 0.0000001 { pt } else { image_filter_gabor_point_scale(pt, 1.0 / n) }
}

pub fn image_filter_gabor_point_negate(pt : ImagefiltergaborPoint) -> ImagefiltergaborPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn image_filter_gabor_point_mid(a : ImagefiltergaborPoint, b : ImagefiltergaborPoint) -> ImagefiltergaborPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn image_filter_gabor_point_lerp(a : ImagefiltergaborPoint, b : ImagefiltergaborPoint, t : Double) -> ImagefiltergaborPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn image_filter_gabor_point_to_string(pt : ImagefiltergaborPoint) -> String {
  "(" + image_filter_gabor_dbl(pt.x) + ", " + image_filter_gabor_dbl(pt.y) + ", " + image_filter_gabor_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct ImagefiltergaborSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_filter_gabor_make_series(vals : Array[Double], name : String) -> ImagefiltergaborSeries {
  { vals, name, meta: 0 }
}

pub fn image_filter_gabor_series_len(s : ImagefiltergaborSeries) -> Int { s.vals.length() }

pub fn image_filter_gabor_series_sum(s : ImagefiltergaborSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn image_filter_gabor_series_mean(s : ImagefiltergaborSeries) -> Double {
  let n = image_filter_gabor_series_len(s)
  if n == 0 { 0.0 } else { image_filter_gabor_series_sum(s) / n.to_double() }
}

pub fn image_filter_gabor_series_min(s : ImagefiltergaborSeries) -> Double {
  let n = image_filter_gabor_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn image_filter_gabor_series_max(s : ImagefiltergaborSeries) -> Double {
  let n = image_filter_gabor_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn image_filter_gabor_series_range(s : ImagefiltergaborSeries) -> Double {
  image_filter_gabor_series_max(s) - image_filter_gabor_series_min(s)
}

pub fn image_filter_gabor_series_var(s : ImagefiltergaborSeries) -> Double {
  let n = image_filter_gabor_series_len(s)
  if n == 0 { 0.0 } else {
    let m = image_filter_gabor_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn image_filter_gabor_series_std(s : ImagefiltergaborSeries) -> Double { image_filter_gabor_sqrt(image_filter_gabor_series_var(s)) }

pub fn image_filter_gabor_series_median(s : ImagefiltergaborSeries) -> Double {
  let n = image_filter_gabor_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = image_filter_gabor_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn image_filter_gabor_series_scale(s : ImagefiltergaborSeries, f : Double) -> ImagefiltergaborSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = image_filter_gabor_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn image_filter_gabor_series_add(a : ImagefiltergaborSeries, b : ImagefiltergaborSeries) -> ImagefiltergaborSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = image_filter_gabor_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn image_filter_gabor_series_sub(a : ImagefiltergaborSeries, b : ImagefiltergaborSeries) -> ImagefiltergaborSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = image_filter_gabor_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn image_filter_gabor_series_normalize(s : ImagefiltergaborSeries) -> ImagefiltergaborSeries {
  let mn = image_filter_gabor_series_min(s)
  let mx = image_filter_gabor_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = image_filter_gabor_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn image_filter_gabor_series_cumsum(s : ImagefiltergaborSeries) -> ImagefiltergaborSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = image_filter_gabor_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn image_filter_gabor_series_to_string(s : ImagefiltergaborSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + image_filter_gabor_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagefiltergaborMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_filter_gabor_make_matrix(rows : Int, cols : Int, val : Double) -> ImagefiltergaborMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn image_filter_gabor_matrix_identity(n : Int) -> ImagefiltergaborMatrix {
  let m = image_filter_gabor_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn image_filter_gabor_matrix_get(m : ImagefiltergaborMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn image_filter_gabor_matrix_transpose(m : ImagefiltergaborMatrix) -> ImagefiltergaborMatrix {
  let result = image_filter_gabor_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn image_filter_gabor_matrix_add(a : ImagefiltergaborMatrix, b : ImagefiltergaborMatrix) -> ImagefiltergaborMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = image_filter_gabor_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn image_filter_gabor_matrix_scale(m : ImagefiltergaborMatrix, s : Double) -> ImagefiltergaborMatrix {
  let result = image_filter_gabor_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn image_filter_gabor_matrix_multiply(a : ImagefiltergaborMatrix, b : ImagefiltergaborMatrix) -> ImagefiltergaborMatrix {
  if a.cols != b.rows { return image_filter_gabor_make_matrix(a.rows, b.cols, 0.0) }
  let result = image_filter_gabor_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn image_filter_gabor_matrix_trace(m : ImagefiltergaborMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn image_filter_gabor_matrix_det(m : ImagefiltergaborMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn image_filter_gabor_matrix_norm(m : ImagefiltergaborMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  image_filter_gabor_sqrt(sum)
}

pub fn image_filter_gabor_matrix_to_string(m : ImagefiltergaborMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + image_filter_gabor_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct ImagefiltergaborVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_filter_gabor_make_vector(comps : Array[Double]) -> ImagefiltergaborVector {
  { comps, dim: comps.length() }
}

pub fn image_filter_gabor_vector_zero(dim : Int) -> ImagefiltergaborVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn image_filter_gabor_vector_add(a : ImagefiltergaborVector, b : ImagefiltergaborVector) -> ImagefiltergaborVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = image_filter_gabor_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn image_filter_gabor_vector_sub(a : ImagefiltergaborVector, b : ImagefiltergaborVector) -> ImagefiltergaborVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = image_filter_gabor_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn image_filter_gabor_vector_scale(v : ImagefiltergaborVector, s : Double) -> ImagefiltergaborVector {
  let mut result = []
  for i in 0..<v.dim { result = image_filter_gabor_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn image_filter_gabor_vector_dot(a : ImagefiltergaborVector, b : ImagefiltergaborVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn image_filter_gabor_vector_norm(v : ImagefiltergaborVector) -> Double { image_filter_gabor_sqrt(image_filter_gabor_vector_dot(v, v)) }

pub fn image_filter_gabor_vector_normalize(v : ImagefiltergaborVector) -> ImagefiltergaborVector {
  let n = image_filter_gabor_vector_norm(v)
  if n < 0.0000001 { v } else { image_filter_gabor_vector_scale(v, 1.0 / n) }
}

pub fn image_filter_gabor_vector_dist(a : ImagefiltergaborVector, b : ImagefiltergaborVector) -> Double {
  image_filter_gabor_vector_norm(image_filter_gabor_vector_sub(a, b))
}

pub fn image_filter_gabor_vector_to_string(v : ImagefiltergaborVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + image_filter_gabor_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn image_filter_gabor_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn image_filter_gabor_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = image_filter_gabor_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn image_filter_gabor_std(data : Array[Double]) -> Double { image_filter_gabor_sqrt(image_filter_gabor_var(data)) }

pub fn image_filter_gabor_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = image_filter_gabor_mean(a); let mb = image_filter_gabor_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn image_filter_gabor_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = image_filter_gabor_std(a); let sb = image_filter_gabor_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { image_filter_gabor_cov(a, b) / (sa * sb) }
}

pub fn image_filter_gabor_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = image_filter_gabor_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn image_filter_gabor_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn image_filter_gabor_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn image_filter_gabor_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  image_filter_gabor_sqrt(image_filter_gabor_mse(pred, labels))
}

pub fn image_filter_gabor_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + image_filter_gabor_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn image_filter_gabor_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = image_filter_gabor_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn image_filter_gabor_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn image_filter_gabor_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn image_filter_gabor_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = image_filter_gabor_precision(pred, labels, pos); let r = image_filter_gabor_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn image_filter_gabor_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn image_filter_gabor_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = image_filter_gabor_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn image_filter_gabor_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn image_filter_gabor_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn image_filter_gabor_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = image_filter_gabor_gcd(a, b)
    (a / g) * b
  }
}

pub fn image_filter_gabor_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn image_filter_gabor_fibonacci(n : Int) -> Int {
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

pub fn image_filter_gabor_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = image_filter_gabor_min(data); let mx = image_filter_gabor_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn image_filter_gabor_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = image_filter_gabor_mean(data); let sd = image_filter_gabor_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn image_filter_gabor_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn image_filter_gabor_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn image_filter_gabor_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn image_filter_gabor_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn image_filter_gabor_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn image_filter_gabor_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn image_filter_gabor_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn image_filter_gabor_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn image_filter_gabor_dbl(x : Double) -> String {
  let i = if x >= 0.0 { image_filter_gabor_int(x) } else { -image_filter_gabor_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { image_filter_gabor_int(f * 1000000.0) } else { image_filter_gabor_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn image_filter_gabor_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn image_filter_gabor_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct ImagefiltergaborFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_gabor_frame_make(size : Int) -> ImagefiltergaborFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_gabor_frame_len(s : ImagefiltergaborFrame) -> Int { s.size }

pub fn image_filter_gabor_frame_get(s : ImagefiltergaborFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_gabor_frame_set(s : ImagefiltergaborFrame, i : Int, v : Double) -> ImagefiltergaborFrame {
  let result = image_filter_gabor_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_gabor_frame_sum(s : ImagefiltergaborFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_filter_gabor_frame_mean(s : ImagefiltergaborFrame) -> Double {
  if s.size == 0 { 0.0 } else { image_filter_gabor_frame_sum(s) / s.size.to_double() }
}

pub fn image_filter_gabor_frame_scale(s : ImagefiltergaborFrame, f : Double) -> ImagefiltergaborFrame {
  let result = image_filter_gabor_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_gabor_frame_add(a : ImagefiltergaborFrame, b : ImagefiltergaborFrame) -> ImagefiltergaborFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_gabor_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_gabor_frame_copy(s : ImagefiltergaborFrame) -> ImagefiltergaborFrame {
  let result = image_filter_gabor_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_gabor_frame_fill(s : ImagefiltergaborFrame, v : Double) -> ImagefiltergaborFrame {
  let result = image_filter_gabor_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_gabor_frame_min(s : ImagefiltergaborFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_gabor_frame_max(s : ImagefiltergaborFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_gabor_frame_to_string(s : ImagefiltergaborFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltergaborTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_gabor_table_make(size : Int) -> ImagefiltergaborTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_gabor_table_len(s : ImagefiltergaborTable) -> Int { s.size }

pub fn image_filter_gabor_table_get(s : ImagefiltergaborTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_gabor_table_set(s : ImagefiltergaborTable, i : Int, v : Double) -> ImagefiltergaborTable {
  let result = image_filter_gabor_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_gabor_table_sum(s : ImagefiltergaborTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_filter_gabor_table_mean(s : ImagefiltergaborTable) -> Double {
  if s.size == 0 { 0.0 } else { image_filter_gabor_table_sum(s) / s.size.to_double() }
}

pub fn image_filter_gabor_table_scale(s : ImagefiltergaborTable, f : Double) -> ImagefiltergaborTable {
  let result = image_filter_gabor_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_gabor_table_add(a : ImagefiltergaborTable, b : ImagefiltergaborTable) -> ImagefiltergaborTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_gabor_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_gabor_table_copy(s : ImagefiltergaborTable) -> ImagefiltergaborTable {
  let result = image_filter_gabor_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_gabor_table_fill(s : ImagefiltergaborTable, v : Double) -> ImagefiltergaborTable {
  let result = image_filter_gabor_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_gabor_table_min(s : ImagefiltergaborTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_gabor_table_max(s : ImagefiltergaborTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_gabor_table_to_string(s : ImagefiltergaborTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltergaborGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_gabor_graphn_make(size : Int) -> ImagefiltergaborGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_gabor_graphn_len(s : ImagefiltergaborGraphN) -> Int { s.size }

pub fn image_filter_gabor_graphn_get(s : ImagefiltergaborGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_gabor_graphn_set(s : ImagefiltergaborGraphN, i : Int, v : Double) -> ImagefiltergaborGraphN {
  let result = image_filter_gabor_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_gabor_graphn_sum(s : ImagefiltergaborGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_filter_gabor_graphn_mean(s : ImagefiltergaborGraphN) -> Double {
  if s.size == 0 { 0.0 } else { image_filter_gabor_graphn_sum(s) / s.size.to_double() }
}

pub fn image_filter_gabor_graphn_scale(s : ImagefiltergaborGraphN, f : Double) -> ImagefiltergaborGraphN {
  let result = image_filter_gabor_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_gabor_graphn_add(a : ImagefiltergaborGraphN, b : ImagefiltergaborGraphN) -> ImagefiltergaborGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_gabor_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_gabor_graphn_copy(s : ImagefiltergaborGraphN) -> ImagefiltergaborGraphN {
  let result = image_filter_gabor_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_gabor_graphn_fill(s : ImagefiltergaborGraphN, v : Double) -> ImagefiltergaborGraphN {
  let result = image_filter_gabor_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_gabor_graphn_min(s : ImagefiltergaborGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_gabor_graphn_max(s : ImagefiltergaborGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_gabor_graphn_to_string(s : ImagefiltergaborGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltergaborNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_gabor_node_make(size : Int) -> ImagefiltergaborNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_gabor_node_len(s : ImagefiltergaborNode) -> Int { s.size }

pub fn image_filter_gabor_node_get(s : ImagefiltergaborNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_gabor_node_set(s : ImagefiltergaborNode, i : Int, v : Double) -> ImagefiltergaborNode {
  let result = image_filter_gabor_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_gabor_node_sum(s : ImagefiltergaborNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_filter_gabor_node_mean(s : ImagefiltergaborNode) -> Double {
  if s.size == 0 { 0.0 } else { image_filter_gabor_node_sum(s) / s.size.to_double() }
}

pub fn image_filter_gabor_node_scale(s : ImagefiltergaborNode, f : Double) -> ImagefiltergaborNode {
  let result = image_filter_gabor_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_gabor_node_add(a : ImagefiltergaborNode, b : ImagefiltergaborNode) -> ImagefiltergaborNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_gabor_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_gabor_node_copy(s : ImagefiltergaborNode) -> ImagefiltergaborNode {
  let result = image_filter_gabor_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_gabor_node_fill(s : ImagefiltergaborNode, v : Double) -> ImagefiltergaborNode {
  let result = image_filter_gabor_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_gabor_node_min(s : ImagefiltergaborNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_gabor_node_max(s : ImagefiltergaborNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_gabor_node_to_string(s : ImagefiltergaborNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltergaborEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_gabor_edge_make(size : Int) -> ImagefiltergaborEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_gabor_edge_len(s : ImagefiltergaborEdge) -> Int { s.size }

pub fn image_filter_gabor_edge_get(s : ImagefiltergaborEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_gabor_edge_set(s : ImagefiltergaborEdge, i : Int, v : Double) -> ImagefiltergaborEdge {
  let result = image_filter_gabor_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_gabor_edge_sum(s : ImagefiltergaborEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_filter_gabor_edge_mean(s : ImagefiltergaborEdge) -> Double {
  if s.size == 0 { 0.0 } else { image_filter_gabor_edge_sum(s) / s.size.to_double() }
}

pub fn image_filter_gabor_edge_scale(s : ImagefiltergaborEdge, f : Double) -> ImagefiltergaborEdge {
  let result = image_filter_gabor_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_gabor_edge_add(a : ImagefiltergaborEdge, b : ImagefiltergaborEdge) -> ImagefiltergaborEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_gabor_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_gabor_edge_copy(s : ImagefiltergaborEdge) -> ImagefiltergaborEdge {
  let result = image_filter_gabor_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_gabor_edge_fill(s : ImagefiltergaborEdge, v : Double) -> ImagefiltergaborEdge {
  let result = image_filter_gabor_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_gabor_edge_min(s : ImagefiltergaborEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_gabor_edge_max(s : ImagefiltergaborEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_gabor_edge_to_string(s : ImagefiltergaborEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltergaborPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_gabor_path_make(size : Int) -> ImagefiltergaborPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_gabor_path_len(s : ImagefiltergaborPath) -> Int { s.size }

pub fn image_filter_gabor_path_get(s : ImagefiltergaborPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_gabor_path_set(s : ImagefiltergaborPath, i : Int, v : Double) -> ImagefiltergaborPath {
  let result = image_filter_gabor_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_gabor_path_sum(s : ImagefiltergaborPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_filter_gabor_path_mean(s : ImagefiltergaborPath) -> Double {
  if s.size == 0 { 0.0 } else { image_filter_gabor_path_sum(s) / s.size.to_double() }
}

pub fn image_filter_gabor_path_scale(s : ImagefiltergaborPath, f : Double) -> ImagefiltergaborPath {
  let result = image_filter_gabor_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_gabor_path_add(a : ImagefiltergaborPath, b : ImagefiltergaborPath) -> ImagefiltergaborPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_gabor_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_gabor_path_copy(s : ImagefiltergaborPath) -> ImagefiltergaborPath {
  let result = image_filter_gabor_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_gabor_path_fill(s : ImagefiltergaborPath, v : Double) -> ImagefiltergaborPath {
  let result = image_filter_gabor_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_gabor_path_min(s : ImagefiltergaborPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_gabor_path_max(s : ImagefiltergaborPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_gabor_path_to_string(s : ImagefiltergaborPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltergaborCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_gabor_cluster_make(size : Int) -> ImagefiltergaborCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_gabor_cluster_len(s : ImagefiltergaborCluster) -> Int { s.size }

pub fn image_filter_gabor_cluster_get(s : ImagefiltergaborCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_gabor_cluster_set(s : ImagefiltergaborCluster, i : Int, v : Double) -> ImagefiltergaborCluster {
  let result = image_filter_gabor_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_gabor_cluster_sum(s : ImagefiltergaborCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_filter_gabor_cluster_mean(s : ImagefiltergaborCluster) -> Double {
  if s.size == 0 { 0.0 } else { image_filter_gabor_cluster_sum(s) / s.size.to_double() }
}

pub fn image_filter_gabor_cluster_scale(s : ImagefiltergaborCluster, f : Double) -> ImagefiltergaborCluster {
  let result = image_filter_gabor_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_gabor_cluster_add(a : ImagefiltergaborCluster, b : ImagefiltergaborCluster) -> ImagefiltergaborCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_gabor_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_gabor_cluster_copy(s : ImagefiltergaborCluster) -> ImagefiltergaborCluster {
  let result = image_filter_gabor_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_gabor_cluster_fill(s : ImagefiltergaborCluster, v : Double) -> ImagefiltergaborCluster {
  let result = image_filter_gabor_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_gabor_cluster_min(s : ImagefiltergaborCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_gabor_cluster_max(s : ImagefiltergaborCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_gabor_cluster_to_string(s : ImagefiltergaborCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltergaborModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_gabor_model_make(size : Int) -> ImagefiltergaborModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_gabor_model_len(s : ImagefiltergaborModel) -> Int { s.size }

pub fn image_filter_gabor_model_get(s : ImagefiltergaborModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_gabor_model_set(s : ImagefiltergaborModel, i : Int, v : Double) -> ImagefiltergaborModel {
  let result = image_filter_gabor_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_gabor_model_sum(s : ImagefiltergaborModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_filter_gabor_model_mean(s : ImagefiltergaborModel) -> Double {
  if s.size == 0 { 0.0 } else { image_filter_gabor_model_sum(s) / s.size.to_double() }
}

pub fn image_filter_gabor_model_scale(s : ImagefiltergaborModel, f : Double) -> ImagefiltergaborModel {
  let result = image_filter_gabor_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_gabor_model_add(a : ImagefiltergaborModel, b : ImagefiltergaborModel) -> ImagefiltergaborModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_gabor_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_gabor_model_copy(s : ImagefiltergaborModel) -> ImagefiltergaborModel {
  let result = image_filter_gabor_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_gabor_model_fill(s : ImagefiltergaborModel, v : Double) -> ImagefiltergaborModel {
  let result = image_filter_gabor_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_gabor_model_min(s : ImagefiltergaborModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_gabor_model_max(s : ImagefiltergaborModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_gabor_model_to_string(s : ImagefiltergaborModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltergaborLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_gabor_layer_make(size : Int) -> ImagefiltergaborLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_gabor_layer_len(s : ImagefiltergaborLayer) -> Int { s.size }

pub fn image_filter_gabor_layer_get(s : ImagefiltergaborLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_gabor_layer_set(s : ImagefiltergaborLayer, i : Int, v : Double) -> ImagefiltergaborLayer {
  let result = image_filter_gabor_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_gabor_layer_sum(s : ImagefiltergaborLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_filter_gabor_layer_mean(s : ImagefiltergaborLayer) -> Double {
  if s.size == 0 { 0.0 } else { image_filter_gabor_layer_sum(s) / s.size.to_double() }
}

pub fn image_filter_gabor_layer_scale(s : ImagefiltergaborLayer, f : Double) -> ImagefiltergaborLayer {
  let result = image_filter_gabor_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_gabor_layer_add(a : ImagefiltergaborLayer, b : ImagefiltergaborLayer) -> ImagefiltergaborLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_gabor_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_gabor_layer_copy(s : ImagefiltergaborLayer) -> ImagefiltergaborLayer {
  let result = image_filter_gabor_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_gabor_layer_fill(s : ImagefiltergaborLayer, v : Double) -> ImagefiltergaborLayer {
  let result = image_filter_gabor_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_gabor_layer_min(s : ImagefiltergaborLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_gabor_layer_max(s : ImagefiltergaborLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_gabor_layer_to_string(s : ImagefiltergaborLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltergaborBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_gabor_buffer_make(size : Int) -> ImagefiltergaborBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_gabor_buffer_len(s : ImagefiltergaborBuffer) -> Int { s.size }

pub fn image_filter_gabor_buffer_get(s : ImagefiltergaborBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_gabor_buffer_set(s : ImagefiltergaborBuffer, i : Int, v : Double) -> ImagefiltergaborBuffer {
  let result = image_filter_gabor_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_gabor_buffer_sum(s : ImagefiltergaborBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_filter_gabor_buffer_mean(s : ImagefiltergaborBuffer) -> Double {
  if s.size == 0 { 0.0 } else { image_filter_gabor_buffer_sum(s) / s.size.to_double() }
}

pub fn image_filter_gabor_buffer_scale(s : ImagefiltergaborBuffer, f : Double) -> ImagefiltergaborBuffer {
  let result = image_filter_gabor_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_gabor_buffer_add(a : ImagefiltergaborBuffer, b : ImagefiltergaborBuffer) -> ImagefiltergaborBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_gabor_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_gabor_buffer_copy(s : ImagefiltergaborBuffer) -> ImagefiltergaborBuffer {
  let result = image_filter_gabor_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_gabor_buffer_fill(s : ImagefiltergaborBuffer, v : Double) -> ImagefiltergaborBuffer {
  let result = image_filter_gabor_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_gabor_buffer_min(s : ImagefiltergaborBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_gabor_buffer_max(s : ImagefiltergaborBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_gabor_buffer_to_string(s : ImagefiltergaborBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltergaborCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_gabor_cursor_make(size : Int) -> ImagefiltergaborCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_gabor_cursor_len(s : ImagefiltergaborCursor) -> Int { s.size }

pub fn image_filter_gabor_cursor_get(s : ImagefiltergaborCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_gabor_cursor_set(s : ImagefiltergaborCursor, i : Int, v : Double) -> ImagefiltergaborCursor {
  let result = image_filter_gabor_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_gabor_cursor_sum(s : ImagefiltergaborCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_filter_gabor_cursor_mean(s : ImagefiltergaborCursor) -> Double {
  if s.size == 0 { 0.0 } else { image_filter_gabor_cursor_sum(s) / s.size.to_double() }
}

pub fn image_filter_gabor_cursor_scale(s : ImagefiltergaborCursor, f : Double) -> ImagefiltergaborCursor {
  let result = image_filter_gabor_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_gabor_cursor_add(a : ImagefiltergaborCursor, b : ImagefiltergaborCursor) -> ImagefiltergaborCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_gabor_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_gabor_cursor_copy(s : ImagefiltergaborCursor) -> ImagefiltergaborCursor {
  let result = image_filter_gabor_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_gabor_cursor_fill(s : ImagefiltergaborCursor, v : Double) -> ImagefiltergaborCursor {
  let result = image_filter_gabor_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_gabor_cursor_min(s : ImagefiltergaborCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_gabor_cursor_max(s : ImagefiltergaborCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_gabor_cursor_to_string(s : ImagefiltergaborCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltergaborView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_gabor_view_make(size : Int) -> ImagefiltergaborView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_gabor_view_len(s : ImagefiltergaborView) -> Int { s.size }

pub fn image_filter_gabor_view_get(s : ImagefiltergaborView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_gabor_view_set(s : ImagefiltergaborView, i : Int, v : Double) -> ImagefiltergaborView {
  let result = image_filter_gabor_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_gabor_view_sum(s : ImagefiltergaborView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_filter_gabor_view_mean(s : ImagefiltergaborView) -> Double {
  if s.size == 0 { 0.0 } else { image_filter_gabor_view_sum(s) / s.size.to_double() }
}

pub fn image_filter_gabor_view_scale(s : ImagefiltergaborView, f : Double) -> ImagefiltergaborView {
  let result = image_filter_gabor_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_gabor_view_add(a : ImagefiltergaborView, b : ImagefiltergaborView) -> ImagefiltergaborView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_gabor_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_gabor_view_copy(s : ImagefiltergaborView) -> ImagefiltergaborView {
  let result = image_filter_gabor_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_gabor_view_fill(s : ImagefiltergaborView, v : Double) -> ImagefiltergaborView {
  let result = image_filter_gabor_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_gabor_view_min(s : ImagefiltergaborView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_gabor_view_max(s : ImagefiltergaborView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_gabor_view_to_string(s : ImagefiltergaborView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltergaborRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_gabor_range_make(size : Int) -> ImagefiltergaborRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_gabor_range_len(s : ImagefiltergaborRange) -> Int { s.size }

pub fn image_filter_gabor_range_get(s : ImagefiltergaborRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_gabor_range_set(s : ImagefiltergaborRange, i : Int, v : Double) -> ImagefiltergaborRange {
  let result = image_filter_gabor_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_gabor_range_sum(s : ImagefiltergaborRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_filter_gabor_range_mean(s : ImagefiltergaborRange) -> Double {
  if s.size == 0 { 0.0 } else { image_filter_gabor_range_sum(s) / s.size.to_double() }
}

pub fn image_filter_gabor_range_scale(s : ImagefiltergaborRange, f : Double) -> ImagefiltergaborRange {
  let result = image_filter_gabor_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_gabor_range_add(a : ImagefiltergaborRange, b : ImagefiltergaborRange) -> ImagefiltergaborRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_gabor_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_gabor_range_copy(s : ImagefiltergaborRange) -> ImagefiltergaborRange {
  let result = image_filter_gabor_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_gabor_range_fill(s : ImagefiltergaborRange, v : Double) -> ImagefiltergaborRange {
  let result = image_filter_gabor_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_gabor_range_min(s : ImagefiltergaborRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_gabor_range_max(s : ImagefiltergaborRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_gabor_range_to_string(s : ImagefiltergaborRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltergaborSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_gabor_slice_make(size : Int) -> ImagefiltergaborSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_gabor_slice_len(s : ImagefiltergaborSlice) -> Int { s.size }

pub fn image_filter_gabor_slice_get(s : ImagefiltergaborSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_gabor_slice_set(s : ImagefiltergaborSlice, i : Int, v : Double) -> ImagefiltergaborSlice {
  let result = image_filter_gabor_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_gabor_slice_sum(s : ImagefiltergaborSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_filter_gabor_slice_mean(s : ImagefiltergaborSlice) -> Double {
  if s.size == 0 { 0.0 } else { image_filter_gabor_slice_sum(s) / s.size.to_double() }
}

pub fn image_filter_gabor_slice_scale(s : ImagefiltergaborSlice, f : Double) -> ImagefiltergaborSlice {
  let result = image_filter_gabor_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_gabor_slice_add(a : ImagefiltergaborSlice, b : ImagefiltergaborSlice) -> ImagefiltergaborSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_gabor_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_gabor_slice_copy(s : ImagefiltergaborSlice) -> ImagefiltergaborSlice {
  let result = image_filter_gabor_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_gabor_slice_fill(s : ImagefiltergaborSlice, v : Double) -> ImagefiltergaborSlice {
  let result = image_filter_gabor_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_gabor_slice_min(s : ImagefiltergaborSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_gabor_slice_max(s : ImagefiltergaborSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_gabor_slice_to_string(s : ImagefiltergaborSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn image_filter_gabor_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_filter_gabor_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_filter_gabor_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_filter_gabor_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_filter_gabor_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_filter_gabor_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_filter_gabor_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_filter_gabor_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_filter_gabor_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_filter_gabor_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_filter_gabor_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_filter_gabor_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_filter_gabor_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_filter_gabor_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_filter_gabor_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_filter_gabor_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_filter_gabor_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_filter_gabor_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_filter_gabor_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_filter_gabor_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_filter_gabor_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_filter_gabor_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_filter_gabor_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_filter_gabor_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_filter_gabor_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}


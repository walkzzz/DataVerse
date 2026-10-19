///===
/// extcore/image_feature_brief

pub(all) struct ImagefeaturebriefPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_feature_brief_make_point(x : Double, y : Double) -> ImagefeaturebriefPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_feature_brief_make_point3(x : Double, y : Double, z : Double) -> ImagefeaturebriefPoint {
  { x, y, z, label: 0 }
}

pub fn image_feature_brief_point_x(pt : ImagefeaturebriefPoint) -> Double { pt.x }

pub fn image_feature_brief_point_y(pt : ImagefeaturebriefPoint) -> Double { pt.y }

pub fn image_feature_brief_point_z(pt : ImagefeaturebriefPoint) -> Double { pt.z }

pub fn image_feature_brief_point_label(pt : ImagefeaturebriefPoint) -> Int { pt.label }

pub fn image_feature_brief_point_dist(a : ImagefeaturebriefPoint, b : ImagefeaturebriefPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  image_feature_brief_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn image_feature_brief_point_add(a : ImagefeaturebriefPoint, b : ImagefeaturebriefPoint) -> ImagefeaturebriefPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn image_feature_brief_point_sub(a : ImagefeaturebriefPoint, b : ImagefeaturebriefPoint) -> ImagefeaturebriefPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn image_feature_brief_point_scale(pt : ImagefeaturebriefPoint, s : Double) -> ImagefeaturebriefPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn image_feature_brief_point_dot(a : ImagefeaturebriefPoint, b : ImagefeaturebriefPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn image_feature_brief_point_cross(a : ImagefeaturebriefPoint, b : ImagefeaturebriefPoint) -> ImagefeaturebriefPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn image_feature_brief_point_norm(pt : ImagefeaturebriefPoint) -> Double {
  image_feature_brief_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn image_feature_brief_point_normalize(pt : ImagefeaturebriefPoint) -> ImagefeaturebriefPoint {
  let n = image_feature_brief_point_norm(pt)
  if n < 0.0000001 { pt } else { image_feature_brief_point_scale(pt, 1.0 / n) }
}

pub fn image_feature_brief_point_negate(pt : ImagefeaturebriefPoint) -> ImagefeaturebriefPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn image_feature_brief_point_mid(a : ImagefeaturebriefPoint, b : ImagefeaturebriefPoint) -> ImagefeaturebriefPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn image_feature_brief_point_lerp(a : ImagefeaturebriefPoint, b : ImagefeaturebriefPoint, t : Double) -> ImagefeaturebriefPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn image_feature_brief_point_to_string(pt : ImagefeaturebriefPoint) -> String {
  "(" + image_feature_brief_dbl(pt.x) + ", " + image_feature_brief_dbl(pt.y) + ", " + image_feature_brief_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct ImagefeaturebriefSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_feature_brief_make_series(vals : Array[Double], name : String) -> ImagefeaturebriefSeries {
  { vals, name, meta: 0 }
}

pub fn image_feature_brief_series_len(s : ImagefeaturebriefSeries) -> Int { s.vals.length() }

pub fn image_feature_brief_series_sum(s : ImagefeaturebriefSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn image_feature_brief_series_mean(s : ImagefeaturebriefSeries) -> Double {
  let n = image_feature_brief_series_len(s)
  if n == 0 { 0.0 } else { image_feature_brief_series_sum(s) / n.to_double() }
}

pub fn image_feature_brief_series_min(s : ImagefeaturebriefSeries) -> Double {
  let n = image_feature_brief_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn image_feature_brief_series_max(s : ImagefeaturebriefSeries) -> Double {
  let n = image_feature_brief_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn image_feature_brief_series_range(s : ImagefeaturebriefSeries) -> Double {
  image_feature_brief_series_max(s) - image_feature_brief_series_min(s)
}

pub fn image_feature_brief_series_var(s : ImagefeaturebriefSeries) -> Double {
  let n = image_feature_brief_series_len(s)
  if n == 0 { 0.0 } else {
    let m = image_feature_brief_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn image_feature_brief_series_std(s : ImagefeaturebriefSeries) -> Double { image_feature_brief_sqrt(image_feature_brief_series_var(s)) }

pub fn image_feature_brief_series_median(s : ImagefeaturebriefSeries) -> Double {
  let n = image_feature_brief_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = image_feature_brief_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn image_feature_brief_series_scale(s : ImagefeaturebriefSeries, f : Double) -> ImagefeaturebriefSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = image_feature_brief_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn image_feature_brief_series_add(a : ImagefeaturebriefSeries, b : ImagefeaturebriefSeries) -> ImagefeaturebriefSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = image_feature_brief_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn image_feature_brief_series_sub(a : ImagefeaturebriefSeries, b : ImagefeaturebriefSeries) -> ImagefeaturebriefSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = image_feature_brief_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn image_feature_brief_series_normalize(s : ImagefeaturebriefSeries) -> ImagefeaturebriefSeries {
  let mn = image_feature_brief_series_min(s)
  let mx = image_feature_brief_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = image_feature_brief_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn image_feature_brief_series_cumsum(s : ImagefeaturebriefSeries) -> ImagefeaturebriefSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = image_feature_brief_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn image_feature_brief_series_to_string(s : ImagefeaturebriefSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + image_feature_brief_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagefeaturebriefMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_feature_brief_make_matrix(rows : Int, cols : Int, val : Double) -> ImagefeaturebriefMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn image_feature_brief_matrix_identity(n : Int) -> ImagefeaturebriefMatrix {
  let m = image_feature_brief_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn image_feature_brief_matrix_get(m : ImagefeaturebriefMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn image_feature_brief_matrix_transpose(m : ImagefeaturebriefMatrix) -> ImagefeaturebriefMatrix {
  let result = image_feature_brief_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn image_feature_brief_matrix_add(a : ImagefeaturebriefMatrix, b : ImagefeaturebriefMatrix) -> ImagefeaturebriefMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = image_feature_brief_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn image_feature_brief_matrix_scale(m : ImagefeaturebriefMatrix, s : Double) -> ImagefeaturebriefMatrix {
  let result = image_feature_brief_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn image_feature_brief_matrix_multiply(a : ImagefeaturebriefMatrix, b : ImagefeaturebriefMatrix) -> ImagefeaturebriefMatrix {
  if a.cols != b.rows { return image_feature_brief_make_matrix(a.rows, b.cols, 0.0) }
  let result = image_feature_brief_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn image_feature_brief_matrix_trace(m : ImagefeaturebriefMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn image_feature_brief_matrix_det(m : ImagefeaturebriefMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn image_feature_brief_matrix_norm(m : ImagefeaturebriefMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  image_feature_brief_sqrt(sum)
}

pub fn image_feature_brief_matrix_to_string(m : ImagefeaturebriefMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + image_feature_brief_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct ImagefeaturebriefVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_feature_brief_make_vector(comps : Array[Double]) -> ImagefeaturebriefVector {
  { comps, dim: comps.length() }
}

pub fn image_feature_brief_vector_zero(dim : Int) -> ImagefeaturebriefVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn image_feature_brief_vector_add(a : ImagefeaturebriefVector, b : ImagefeaturebriefVector) -> ImagefeaturebriefVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = image_feature_brief_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn image_feature_brief_vector_sub(a : ImagefeaturebriefVector, b : ImagefeaturebriefVector) -> ImagefeaturebriefVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = image_feature_brief_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn image_feature_brief_vector_scale(v : ImagefeaturebriefVector, s : Double) -> ImagefeaturebriefVector {
  let mut result = []
  for i in 0..<v.dim { result = image_feature_brief_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn image_feature_brief_vector_dot(a : ImagefeaturebriefVector, b : ImagefeaturebriefVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn image_feature_brief_vector_norm(v : ImagefeaturebriefVector) -> Double { image_feature_brief_sqrt(image_feature_brief_vector_dot(v, v)) }

pub fn image_feature_brief_vector_normalize(v : ImagefeaturebriefVector) -> ImagefeaturebriefVector {
  let n = image_feature_brief_vector_norm(v)
  if n < 0.0000001 { v } else { image_feature_brief_vector_scale(v, 1.0 / n) }
}

pub fn image_feature_brief_vector_dist(a : ImagefeaturebriefVector, b : ImagefeaturebriefVector) -> Double {
  image_feature_brief_vector_norm(image_feature_brief_vector_sub(a, b))
}

pub fn image_feature_brief_vector_to_string(v : ImagefeaturebriefVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + image_feature_brief_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn image_feature_brief_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn image_feature_brief_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = image_feature_brief_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn image_feature_brief_std(data : Array[Double]) -> Double { image_feature_brief_sqrt(image_feature_brief_var(data)) }

pub fn image_feature_brief_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = image_feature_brief_mean(a); let mb = image_feature_brief_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn image_feature_brief_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = image_feature_brief_std(a); let sb = image_feature_brief_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { image_feature_brief_cov(a, b) / (sa * sb) }
}

pub fn image_feature_brief_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = image_feature_brief_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn image_feature_brief_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn image_feature_brief_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn image_feature_brief_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  image_feature_brief_sqrt(image_feature_brief_mse(pred, labels))
}

pub fn image_feature_brief_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + image_feature_brief_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn image_feature_brief_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = image_feature_brief_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn image_feature_brief_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn image_feature_brief_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn image_feature_brief_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = image_feature_brief_precision(pred, labels, pos); let r = image_feature_brief_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn image_feature_brief_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn image_feature_brief_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = image_feature_brief_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn image_feature_brief_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn image_feature_brief_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn image_feature_brief_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = image_feature_brief_gcd(a, b)
    (a / g) * b
  }
}

pub fn image_feature_brief_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn image_feature_brief_fibonacci(n : Int) -> Int {
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

pub fn image_feature_brief_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = image_feature_brief_min(data); let mx = image_feature_brief_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn image_feature_brief_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = image_feature_brief_mean(data); let sd = image_feature_brief_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn image_feature_brief_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn image_feature_brief_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn image_feature_brief_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn image_feature_brief_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn image_feature_brief_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn image_feature_brief_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn image_feature_brief_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn image_feature_brief_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn image_feature_brief_dbl(x : Double) -> String {
  let i = if x >= 0.0 { image_feature_brief_int(x) } else { -image_feature_brief_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { image_feature_brief_int(f * 1000000.0) } else { image_feature_brief_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn image_feature_brief_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn image_feature_brief_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct ImagefeaturebriefFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_brief_frame_make(size : Int) -> ImagefeaturebriefFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_brief_frame_len(s : ImagefeaturebriefFrame) -> Int { s.size }

pub fn image_feature_brief_frame_get(s : ImagefeaturebriefFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_brief_frame_set(s : ImagefeaturebriefFrame, i : Int, v : Double) -> ImagefeaturebriefFrame {
  let result = image_feature_brief_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_brief_frame_sum(s : ImagefeaturebriefFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_brief_frame_mean(s : ImagefeaturebriefFrame) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_brief_frame_sum(s) / s.size.to_double() }
}

pub fn image_feature_brief_frame_scale(s : ImagefeaturebriefFrame, f : Double) -> ImagefeaturebriefFrame {
  let result = image_feature_brief_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_brief_frame_add(a : ImagefeaturebriefFrame, b : ImagefeaturebriefFrame) -> ImagefeaturebriefFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_brief_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_brief_frame_copy(s : ImagefeaturebriefFrame) -> ImagefeaturebriefFrame {
  let result = image_feature_brief_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_brief_frame_fill(s : ImagefeaturebriefFrame, v : Double) -> ImagefeaturebriefFrame {
  let result = image_feature_brief_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_brief_frame_min(s : ImagefeaturebriefFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_brief_frame_max(s : ImagefeaturebriefFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_brief_frame_to_string(s : ImagefeaturebriefFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturebriefTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_brief_table_make(size : Int) -> ImagefeaturebriefTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_brief_table_len(s : ImagefeaturebriefTable) -> Int { s.size }

pub fn image_feature_brief_table_get(s : ImagefeaturebriefTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_brief_table_set(s : ImagefeaturebriefTable, i : Int, v : Double) -> ImagefeaturebriefTable {
  let result = image_feature_brief_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_brief_table_sum(s : ImagefeaturebriefTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_brief_table_mean(s : ImagefeaturebriefTable) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_brief_table_sum(s) / s.size.to_double() }
}

pub fn image_feature_brief_table_scale(s : ImagefeaturebriefTable, f : Double) -> ImagefeaturebriefTable {
  let result = image_feature_brief_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_brief_table_add(a : ImagefeaturebriefTable, b : ImagefeaturebriefTable) -> ImagefeaturebriefTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_brief_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_brief_table_copy(s : ImagefeaturebriefTable) -> ImagefeaturebriefTable {
  let result = image_feature_brief_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_brief_table_fill(s : ImagefeaturebriefTable, v : Double) -> ImagefeaturebriefTable {
  let result = image_feature_brief_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_brief_table_min(s : ImagefeaturebriefTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_brief_table_max(s : ImagefeaturebriefTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_brief_table_to_string(s : ImagefeaturebriefTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturebriefGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_brief_graphn_make(size : Int) -> ImagefeaturebriefGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_brief_graphn_len(s : ImagefeaturebriefGraphN) -> Int { s.size }

pub fn image_feature_brief_graphn_get(s : ImagefeaturebriefGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_brief_graphn_set(s : ImagefeaturebriefGraphN, i : Int, v : Double) -> ImagefeaturebriefGraphN {
  let result = image_feature_brief_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_brief_graphn_sum(s : ImagefeaturebriefGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_brief_graphn_mean(s : ImagefeaturebriefGraphN) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_brief_graphn_sum(s) / s.size.to_double() }
}

pub fn image_feature_brief_graphn_scale(s : ImagefeaturebriefGraphN, f : Double) -> ImagefeaturebriefGraphN {
  let result = image_feature_brief_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_brief_graphn_add(a : ImagefeaturebriefGraphN, b : ImagefeaturebriefGraphN) -> ImagefeaturebriefGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_brief_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_brief_graphn_copy(s : ImagefeaturebriefGraphN) -> ImagefeaturebriefGraphN {
  let result = image_feature_brief_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_brief_graphn_fill(s : ImagefeaturebriefGraphN, v : Double) -> ImagefeaturebriefGraphN {
  let result = image_feature_brief_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_brief_graphn_min(s : ImagefeaturebriefGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_brief_graphn_max(s : ImagefeaturebriefGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_brief_graphn_to_string(s : ImagefeaturebriefGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturebriefNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_brief_node_make(size : Int) -> ImagefeaturebriefNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_brief_node_len(s : ImagefeaturebriefNode) -> Int { s.size }

pub fn image_feature_brief_node_get(s : ImagefeaturebriefNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_brief_node_set(s : ImagefeaturebriefNode, i : Int, v : Double) -> ImagefeaturebriefNode {
  let result = image_feature_brief_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_brief_node_sum(s : ImagefeaturebriefNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_brief_node_mean(s : ImagefeaturebriefNode) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_brief_node_sum(s) / s.size.to_double() }
}

pub fn image_feature_brief_node_scale(s : ImagefeaturebriefNode, f : Double) -> ImagefeaturebriefNode {
  let result = image_feature_brief_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_brief_node_add(a : ImagefeaturebriefNode, b : ImagefeaturebriefNode) -> ImagefeaturebriefNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_brief_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_brief_node_copy(s : ImagefeaturebriefNode) -> ImagefeaturebriefNode {
  let result = image_feature_brief_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_brief_node_fill(s : ImagefeaturebriefNode, v : Double) -> ImagefeaturebriefNode {
  let result = image_feature_brief_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_brief_node_min(s : ImagefeaturebriefNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_brief_node_max(s : ImagefeaturebriefNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_brief_node_to_string(s : ImagefeaturebriefNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturebriefEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_brief_edge_make(size : Int) -> ImagefeaturebriefEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_brief_edge_len(s : ImagefeaturebriefEdge) -> Int { s.size }

pub fn image_feature_brief_edge_get(s : ImagefeaturebriefEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_brief_edge_set(s : ImagefeaturebriefEdge, i : Int, v : Double) -> ImagefeaturebriefEdge {
  let result = image_feature_brief_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_brief_edge_sum(s : ImagefeaturebriefEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_brief_edge_mean(s : ImagefeaturebriefEdge) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_brief_edge_sum(s) / s.size.to_double() }
}

pub fn image_feature_brief_edge_scale(s : ImagefeaturebriefEdge, f : Double) -> ImagefeaturebriefEdge {
  let result = image_feature_brief_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_brief_edge_add(a : ImagefeaturebriefEdge, b : ImagefeaturebriefEdge) -> ImagefeaturebriefEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_brief_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_brief_edge_copy(s : ImagefeaturebriefEdge) -> ImagefeaturebriefEdge {
  let result = image_feature_brief_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_brief_edge_fill(s : ImagefeaturebriefEdge, v : Double) -> ImagefeaturebriefEdge {
  let result = image_feature_brief_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_brief_edge_min(s : ImagefeaturebriefEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_brief_edge_max(s : ImagefeaturebriefEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_brief_edge_to_string(s : ImagefeaturebriefEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturebriefPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_brief_path_make(size : Int) -> ImagefeaturebriefPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_brief_path_len(s : ImagefeaturebriefPath) -> Int { s.size }

pub fn image_feature_brief_path_get(s : ImagefeaturebriefPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_brief_path_set(s : ImagefeaturebriefPath, i : Int, v : Double) -> ImagefeaturebriefPath {
  let result = image_feature_brief_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_brief_path_sum(s : ImagefeaturebriefPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_brief_path_mean(s : ImagefeaturebriefPath) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_brief_path_sum(s) / s.size.to_double() }
}

pub fn image_feature_brief_path_scale(s : ImagefeaturebriefPath, f : Double) -> ImagefeaturebriefPath {
  let result = image_feature_brief_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_brief_path_add(a : ImagefeaturebriefPath, b : ImagefeaturebriefPath) -> ImagefeaturebriefPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_brief_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_brief_path_copy(s : ImagefeaturebriefPath) -> ImagefeaturebriefPath {
  let result = image_feature_brief_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_brief_path_fill(s : ImagefeaturebriefPath, v : Double) -> ImagefeaturebriefPath {
  let result = image_feature_brief_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_brief_path_min(s : ImagefeaturebriefPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_brief_path_max(s : ImagefeaturebriefPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_brief_path_to_string(s : ImagefeaturebriefPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturebriefCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_brief_cluster_make(size : Int) -> ImagefeaturebriefCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_brief_cluster_len(s : ImagefeaturebriefCluster) -> Int { s.size }

pub fn image_feature_brief_cluster_get(s : ImagefeaturebriefCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_brief_cluster_set(s : ImagefeaturebriefCluster, i : Int, v : Double) -> ImagefeaturebriefCluster {
  let result = image_feature_brief_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_brief_cluster_sum(s : ImagefeaturebriefCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_brief_cluster_mean(s : ImagefeaturebriefCluster) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_brief_cluster_sum(s) / s.size.to_double() }
}

pub fn image_feature_brief_cluster_scale(s : ImagefeaturebriefCluster, f : Double) -> ImagefeaturebriefCluster {
  let result = image_feature_brief_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_brief_cluster_add(a : ImagefeaturebriefCluster, b : ImagefeaturebriefCluster) -> ImagefeaturebriefCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_brief_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_brief_cluster_copy(s : ImagefeaturebriefCluster) -> ImagefeaturebriefCluster {
  let result = image_feature_brief_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_brief_cluster_fill(s : ImagefeaturebriefCluster, v : Double) -> ImagefeaturebriefCluster {
  let result = image_feature_brief_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_brief_cluster_min(s : ImagefeaturebriefCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_brief_cluster_max(s : ImagefeaturebriefCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_brief_cluster_to_string(s : ImagefeaturebriefCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturebriefModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_brief_model_make(size : Int) -> ImagefeaturebriefModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_brief_model_len(s : ImagefeaturebriefModel) -> Int { s.size }

pub fn image_feature_brief_model_get(s : ImagefeaturebriefModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_brief_model_set(s : ImagefeaturebriefModel, i : Int, v : Double) -> ImagefeaturebriefModel {
  let result = image_feature_brief_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_brief_model_sum(s : ImagefeaturebriefModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_brief_model_mean(s : ImagefeaturebriefModel) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_brief_model_sum(s) / s.size.to_double() }
}

pub fn image_feature_brief_model_scale(s : ImagefeaturebriefModel, f : Double) -> ImagefeaturebriefModel {
  let result = image_feature_brief_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_brief_model_add(a : ImagefeaturebriefModel, b : ImagefeaturebriefModel) -> ImagefeaturebriefModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_brief_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_brief_model_copy(s : ImagefeaturebriefModel) -> ImagefeaturebriefModel {
  let result = image_feature_brief_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_brief_model_fill(s : ImagefeaturebriefModel, v : Double) -> ImagefeaturebriefModel {
  let result = image_feature_brief_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_brief_model_min(s : ImagefeaturebriefModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_brief_model_max(s : ImagefeaturebriefModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_brief_model_to_string(s : ImagefeaturebriefModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturebriefLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_brief_layer_make(size : Int) -> ImagefeaturebriefLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_brief_layer_len(s : ImagefeaturebriefLayer) -> Int { s.size }

pub fn image_feature_brief_layer_get(s : ImagefeaturebriefLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_brief_layer_set(s : ImagefeaturebriefLayer, i : Int, v : Double) -> ImagefeaturebriefLayer {
  let result = image_feature_brief_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_brief_layer_sum(s : ImagefeaturebriefLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_brief_layer_mean(s : ImagefeaturebriefLayer) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_brief_layer_sum(s) / s.size.to_double() }
}

pub fn image_feature_brief_layer_scale(s : ImagefeaturebriefLayer, f : Double) -> ImagefeaturebriefLayer {
  let result = image_feature_brief_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_brief_layer_add(a : ImagefeaturebriefLayer, b : ImagefeaturebriefLayer) -> ImagefeaturebriefLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_brief_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_brief_layer_copy(s : ImagefeaturebriefLayer) -> ImagefeaturebriefLayer {
  let result = image_feature_brief_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_brief_layer_fill(s : ImagefeaturebriefLayer, v : Double) -> ImagefeaturebriefLayer {
  let result = image_feature_brief_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_brief_layer_min(s : ImagefeaturebriefLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_brief_layer_max(s : ImagefeaturebriefLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_brief_layer_to_string(s : ImagefeaturebriefLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturebriefBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_brief_buffer_make(size : Int) -> ImagefeaturebriefBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_brief_buffer_len(s : ImagefeaturebriefBuffer) -> Int { s.size }

pub fn image_feature_brief_buffer_get(s : ImagefeaturebriefBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_brief_buffer_set(s : ImagefeaturebriefBuffer, i : Int, v : Double) -> ImagefeaturebriefBuffer {
  let result = image_feature_brief_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_brief_buffer_sum(s : ImagefeaturebriefBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_brief_buffer_mean(s : ImagefeaturebriefBuffer) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_brief_buffer_sum(s) / s.size.to_double() }
}

pub fn image_feature_brief_buffer_scale(s : ImagefeaturebriefBuffer, f : Double) -> ImagefeaturebriefBuffer {
  let result = image_feature_brief_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_brief_buffer_add(a : ImagefeaturebriefBuffer, b : ImagefeaturebriefBuffer) -> ImagefeaturebriefBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_brief_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_brief_buffer_copy(s : ImagefeaturebriefBuffer) -> ImagefeaturebriefBuffer {
  let result = image_feature_brief_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_brief_buffer_fill(s : ImagefeaturebriefBuffer, v : Double) -> ImagefeaturebriefBuffer {
  let result = image_feature_brief_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_brief_buffer_min(s : ImagefeaturebriefBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_brief_buffer_max(s : ImagefeaturebriefBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_brief_buffer_to_string(s : ImagefeaturebriefBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturebriefCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_brief_cursor_make(size : Int) -> ImagefeaturebriefCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_brief_cursor_len(s : ImagefeaturebriefCursor) -> Int { s.size }

pub fn image_feature_brief_cursor_get(s : ImagefeaturebriefCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_brief_cursor_set(s : ImagefeaturebriefCursor, i : Int, v : Double) -> ImagefeaturebriefCursor {
  let result = image_feature_brief_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_brief_cursor_sum(s : ImagefeaturebriefCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_brief_cursor_mean(s : ImagefeaturebriefCursor) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_brief_cursor_sum(s) / s.size.to_double() }
}

pub fn image_feature_brief_cursor_scale(s : ImagefeaturebriefCursor, f : Double) -> ImagefeaturebriefCursor {
  let result = image_feature_brief_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_brief_cursor_add(a : ImagefeaturebriefCursor, b : ImagefeaturebriefCursor) -> ImagefeaturebriefCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_brief_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_brief_cursor_copy(s : ImagefeaturebriefCursor) -> ImagefeaturebriefCursor {
  let result = image_feature_brief_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_brief_cursor_fill(s : ImagefeaturebriefCursor, v : Double) -> ImagefeaturebriefCursor {
  let result = image_feature_brief_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_brief_cursor_min(s : ImagefeaturebriefCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_brief_cursor_max(s : ImagefeaturebriefCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_brief_cursor_to_string(s : ImagefeaturebriefCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturebriefView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_brief_view_make(size : Int) -> ImagefeaturebriefView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_brief_view_len(s : ImagefeaturebriefView) -> Int { s.size }

pub fn image_feature_brief_view_get(s : ImagefeaturebriefView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_brief_view_set(s : ImagefeaturebriefView, i : Int, v : Double) -> ImagefeaturebriefView {
  let result = image_feature_brief_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_brief_view_sum(s : ImagefeaturebriefView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_brief_view_mean(s : ImagefeaturebriefView) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_brief_view_sum(s) / s.size.to_double() }
}

pub fn image_feature_brief_view_scale(s : ImagefeaturebriefView, f : Double) -> ImagefeaturebriefView {
  let result = image_feature_brief_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_brief_view_add(a : ImagefeaturebriefView, b : ImagefeaturebriefView) -> ImagefeaturebriefView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_brief_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_brief_view_copy(s : ImagefeaturebriefView) -> ImagefeaturebriefView {
  let result = image_feature_brief_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_brief_view_fill(s : ImagefeaturebriefView, v : Double) -> ImagefeaturebriefView {
  let result = image_feature_brief_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_brief_view_min(s : ImagefeaturebriefView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_brief_view_max(s : ImagefeaturebriefView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_brief_view_to_string(s : ImagefeaturebriefView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturebriefRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_brief_range_make(size : Int) -> ImagefeaturebriefRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_brief_range_len(s : ImagefeaturebriefRange) -> Int { s.size }

pub fn image_feature_brief_range_get(s : ImagefeaturebriefRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_brief_range_set(s : ImagefeaturebriefRange, i : Int, v : Double) -> ImagefeaturebriefRange {
  let result = image_feature_brief_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_brief_range_sum(s : ImagefeaturebriefRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_brief_range_mean(s : ImagefeaturebriefRange) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_brief_range_sum(s) / s.size.to_double() }
}

pub fn image_feature_brief_range_scale(s : ImagefeaturebriefRange, f : Double) -> ImagefeaturebriefRange {
  let result = image_feature_brief_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_brief_range_add(a : ImagefeaturebriefRange, b : ImagefeaturebriefRange) -> ImagefeaturebriefRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_brief_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_brief_range_copy(s : ImagefeaturebriefRange) -> ImagefeaturebriefRange {
  let result = image_feature_brief_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_brief_range_fill(s : ImagefeaturebriefRange, v : Double) -> ImagefeaturebriefRange {
  let result = image_feature_brief_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_brief_range_min(s : ImagefeaturebriefRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_brief_range_max(s : ImagefeaturebriefRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_brief_range_to_string(s : ImagefeaturebriefRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturebriefSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_brief_slice_make(size : Int) -> ImagefeaturebriefSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_brief_slice_len(s : ImagefeaturebriefSlice) -> Int { s.size }

pub fn image_feature_brief_slice_get(s : ImagefeaturebriefSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_brief_slice_set(s : ImagefeaturebriefSlice, i : Int, v : Double) -> ImagefeaturebriefSlice {
  let result = image_feature_brief_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_brief_slice_sum(s : ImagefeaturebriefSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_brief_slice_mean(s : ImagefeaturebriefSlice) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_brief_slice_sum(s) / s.size.to_double() }
}

pub fn image_feature_brief_slice_scale(s : ImagefeaturebriefSlice, f : Double) -> ImagefeaturebriefSlice {
  let result = image_feature_brief_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_brief_slice_add(a : ImagefeaturebriefSlice, b : ImagefeaturebriefSlice) -> ImagefeaturebriefSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_brief_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_brief_slice_copy(s : ImagefeaturebriefSlice) -> ImagefeaturebriefSlice {
  let result = image_feature_brief_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_brief_slice_fill(s : ImagefeaturebriefSlice, v : Double) -> ImagefeaturebriefSlice {
  let result = image_feature_brief_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_brief_slice_min(s : ImagefeaturebriefSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_brief_slice_max(s : ImagefeaturebriefSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_brief_slice_to_string(s : ImagefeaturebriefSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn image_feature_brief_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_feature_brief_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_feature_brief_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_feature_brief_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_feature_brief_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_feature_brief_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_feature_brief_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_feature_brief_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_feature_brief_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_feature_brief_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_feature_brief_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_feature_brief_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_feature_brief_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_feature_brief_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_feature_brief_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_feature_brief_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_feature_brief_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_feature_brief_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_feature_brief_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_feature_brief_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_feature_brief_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_feature_brief_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_feature_brief_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_feature_brief_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_feature_brief_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}


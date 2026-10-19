///===
/// extcore/image_morph_dilate

pub(all) struct ImagemorphdilatePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_morph_dilate_make_point(x : Double, y : Double) -> ImagemorphdilatePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_morph_dilate_make_point3(x : Double, y : Double, z : Double) -> ImagemorphdilatePoint {
  { x, y, z, label: 0 }
}

pub fn image_morph_dilate_point_x(pt : ImagemorphdilatePoint) -> Double { pt.x }

pub fn image_morph_dilate_point_y(pt : ImagemorphdilatePoint) -> Double { pt.y }

pub fn image_morph_dilate_point_z(pt : ImagemorphdilatePoint) -> Double { pt.z }

pub fn image_morph_dilate_point_label(pt : ImagemorphdilatePoint) -> Int { pt.label }

pub fn image_morph_dilate_point_dist(a : ImagemorphdilatePoint, b : ImagemorphdilatePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  image_morph_dilate_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn image_morph_dilate_point_add(a : ImagemorphdilatePoint, b : ImagemorphdilatePoint) -> ImagemorphdilatePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn image_morph_dilate_point_sub(a : ImagemorphdilatePoint, b : ImagemorphdilatePoint) -> ImagemorphdilatePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn image_morph_dilate_point_scale(pt : ImagemorphdilatePoint, s : Double) -> ImagemorphdilatePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn image_morph_dilate_point_dot(a : ImagemorphdilatePoint, b : ImagemorphdilatePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn image_morph_dilate_point_cross(a : ImagemorphdilatePoint, b : ImagemorphdilatePoint) -> ImagemorphdilatePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn image_morph_dilate_point_norm(pt : ImagemorphdilatePoint) -> Double {
  image_morph_dilate_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn image_morph_dilate_point_normalize(pt : ImagemorphdilatePoint) -> ImagemorphdilatePoint {
  let n = image_morph_dilate_point_norm(pt)
  if n < 0.0000001 { pt } else { image_morph_dilate_point_scale(pt, 1.0 / n) }
}

pub fn image_morph_dilate_point_negate(pt : ImagemorphdilatePoint) -> ImagemorphdilatePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn image_morph_dilate_point_mid(a : ImagemorphdilatePoint, b : ImagemorphdilatePoint) -> ImagemorphdilatePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn image_morph_dilate_point_lerp(a : ImagemorphdilatePoint, b : ImagemorphdilatePoint, t : Double) -> ImagemorphdilatePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn image_morph_dilate_point_to_string(pt : ImagemorphdilatePoint) -> String {
  "(" + image_morph_dilate_dbl(pt.x) + ", " + image_morph_dilate_dbl(pt.y) + ", " + image_morph_dilate_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct ImagemorphdilateSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_morph_dilate_make_series(vals : Array[Double], name : String) -> ImagemorphdilateSeries {
  { vals, name, meta: 0 }
}

pub fn image_morph_dilate_series_len(s : ImagemorphdilateSeries) -> Int { s.vals.length() }

pub fn image_morph_dilate_series_sum(s : ImagemorphdilateSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn image_morph_dilate_series_mean(s : ImagemorphdilateSeries) -> Double {
  let n = image_morph_dilate_series_len(s)
  if n == 0 { 0.0 } else { image_morph_dilate_series_sum(s) / n.to_double() }
}

pub fn image_morph_dilate_series_min(s : ImagemorphdilateSeries) -> Double {
  let n = image_morph_dilate_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn image_morph_dilate_series_max(s : ImagemorphdilateSeries) -> Double {
  let n = image_morph_dilate_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn image_morph_dilate_series_range(s : ImagemorphdilateSeries) -> Double {
  image_morph_dilate_series_max(s) - image_morph_dilate_series_min(s)
}

pub fn image_morph_dilate_series_var(s : ImagemorphdilateSeries) -> Double {
  let n = image_morph_dilate_series_len(s)
  if n == 0 { 0.0 } else {
    let m = image_morph_dilate_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn image_morph_dilate_series_std(s : ImagemorphdilateSeries) -> Double { image_morph_dilate_sqrt(image_morph_dilate_series_var(s)) }

pub fn image_morph_dilate_series_median(s : ImagemorphdilateSeries) -> Double {
  let n = image_morph_dilate_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = image_morph_dilate_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn image_morph_dilate_series_scale(s : ImagemorphdilateSeries, f : Double) -> ImagemorphdilateSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = image_morph_dilate_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn image_morph_dilate_series_add(a : ImagemorphdilateSeries, b : ImagemorphdilateSeries) -> ImagemorphdilateSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = image_morph_dilate_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn image_morph_dilate_series_sub(a : ImagemorphdilateSeries, b : ImagemorphdilateSeries) -> ImagemorphdilateSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = image_morph_dilate_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn image_morph_dilate_series_normalize(s : ImagemorphdilateSeries) -> ImagemorphdilateSeries {
  let mn = image_morph_dilate_series_min(s)
  let mx = image_morph_dilate_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = image_morph_dilate_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn image_morph_dilate_series_cumsum(s : ImagemorphdilateSeries) -> ImagemorphdilateSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = image_morph_dilate_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn image_morph_dilate_series_to_string(s : ImagemorphdilateSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + image_morph_dilate_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagemorphdilateMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_morph_dilate_make_matrix(rows : Int, cols : Int, val : Double) -> ImagemorphdilateMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn image_morph_dilate_matrix_identity(n : Int) -> ImagemorphdilateMatrix {
  let m = image_morph_dilate_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn image_morph_dilate_matrix_get(m : ImagemorphdilateMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn image_morph_dilate_matrix_transpose(m : ImagemorphdilateMatrix) -> ImagemorphdilateMatrix {
  let result = image_morph_dilate_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn image_morph_dilate_matrix_add(a : ImagemorphdilateMatrix, b : ImagemorphdilateMatrix) -> ImagemorphdilateMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = image_morph_dilate_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn image_morph_dilate_matrix_scale(m : ImagemorphdilateMatrix, s : Double) -> ImagemorphdilateMatrix {
  let result = image_morph_dilate_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn image_morph_dilate_matrix_multiply(a : ImagemorphdilateMatrix, b : ImagemorphdilateMatrix) -> ImagemorphdilateMatrix {
  if a.cols != b.rows { return image_morph_dilate_make_matrix(a.rows, b.cols, 0.0) }
  let result = image_morph_dilate_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn image_morph_dilate_matrix_trace(m : ImagemorphdilateMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn image_morph_dilate_matrix_det(m : ImagemorphdilateMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn image_morph_dilate_matrix_norm(m : ImagemorphdilateMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  image_morph_dilate_sqrt(sum)
}

pub fn image_morph_dilate_matrix_to_string(m : ImagemorphdilateMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + image_morph_dilate_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct ImagemorphdilateVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_morph_dilate_make_vector(comps : Array[Double]) -> ImagemorphdilateVector {
  { comps, dim: comps.length() }
}

pub fn image_morph_dilate_vector_zero(dim : Int) -> ImagemorphdilateVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn image_morph_dilate_vector_add(a : ImagemorphdilateVector, b : ImagemorphdilateVector) -> ImagemorphdilateVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = image_morph_dilate_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn image_morph_dilate_vector_sub(a : ImagemorphdilateVector, b : ImagemorphdilateVector) -> ImagemorphdilateVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = image_morph_dilate_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn image_morph_dilate_vector_scale(v : ImagemorphdilateVector, s : Double) -> ImagemorphdilateVector {
  let mut result = []
  for i in 0..<v.dim { result = image_morph_dilate_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn image_morph_dilate_vector_dot(a : ImagemorphdilateVector, b : ImagemorphdilateVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn image_morph_dilate_vector_norm(v : ImagemorphdilateVector) -> Double { image_morph_dilate_sqrt(image_morph_dilate_vector_dot(v, v)) }

pub fn image_morph_dilate_vector_normalize(v : ImagemorphdilateVector) -> ImagemorphdilateVector {
  let n = image_morph_dilate_vector_norm(v)
  if n < 0.0000001 { v } else { image_morph_dilate_vector_scale(v, 1.0 / n) }
}

pub fn image_morph_dilate_vector_dist(a : ImagemorphdilateVector, b : ImagemorphdilateVector) -> Double {
  image_morph_dilate_vector_norm(image_morph_dilate_vector_sub(a, b))
}

pub fn image_morph_dilate_vector_to_string(v : ImagemorphdilateVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + image_morph_dilate_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn image_morph_dilate_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn image_morph_dilate_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = image_morph_dilate_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn image_morph_dilate_std(data : Array[Double]) -> Double { image_morph_dilate_sqrt(image_morph_dilate_var(data)) }

pub fn image_morph_dilate_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = image_morph_dilate_mean(a); let mb = image_morph_dilate_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn image_morph_dilate_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = image_morph_dilate_std(a); let sb = image_morph_dilate_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { image_morph_dilate_cov(a, b) / (sa * sb) }
}

pub fn image_morph_dilate_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = image_morph_dilate_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn image_morph_dilate_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn image_morph_dilate_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn image_morph_dilate_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  image_morph_dilate_sqrt(image_morph_dilate_mse(pred, labels))
}

pub fn image_morph_dilate_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + image_morph_dilate_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn image_morph_dilate_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = image_morph_dilate_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn image_morph_dilate_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn image_morph_dilate_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn image_morph_dilate_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = image_morph_dilate_precision(pred, labels, pos); let r = image_morph_dilate_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn image_morph_dilate_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn image_morph_dilate_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = image_morph_dilate_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn image_morph_dilate_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn image_morph_dilate_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn image_morph_dilate_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = image_morph_dilate_gcd(a, b)
    (a / g) * b
  }
}

pub fn image_morph_dilate_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn image_morph_dilate_fibonacci(n : Int) -> Int {
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

pub fn image_morph_dilate_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = image_morph_dilate_min(data); let mx = image_morph_dilate_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn image_morph_dilate_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = image_morph_dilate_mean(data); let sd = image_morph_dilate_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn image_morph_dilate_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn image_morph_dilate_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn image_morph_dilate_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn image_morph_dilate_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn image_morph_dilate_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn image_morph_dilate_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn image_morph_dilate_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn image_morph_dilate_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn image_morph_dilate_dbl(x : Double) -> String {
  let i = if x >= 0.0 { image_morph_dilate_int(x) } else { -image_morph_dilate_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { image_morph_dilate_int(f * 1000000.0) } else { image_morph_dilate_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn image_morph_dilate_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn image_morph_dilate_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct ImagemorphdilateFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_dilate_frame_make(size : Int) -> ImagemorphdilateFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_dilate_frame_len(s : ImagemorphdilateFrame) -> Int { s.size }

pub fn image_morph_dilate_frame_get(s : ImagemorphdilateFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_dilate_frame_set(s : ImagemorphdilateFrame, i : Int, v : Double) -> ImagemorphdilateFrame {
  let result = image_morph_dilate_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_dilate_frame_sum(s : ImagemorphdilateFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_morph_dilate_frame_mean(s : ImagemorphdilateFrame) -> Double {
  if s.size == 0 { 0.0 } else { image_morph_dilate_frame_sum(s) / s.size.to_double() }
}

pub fn image_morph_dilate_frame_scale(s : ImagemorphdilateFrame, f : Double) -> ImagemorphdilateFrame {
  let result = image_morph_dilate_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_dilate_frame_add(a : ImagemorphdilateFrame, b : ImagemorphdilateFrame) -> ImagemorphdilateFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_dilate_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_dilate_frame_copy(s : ImagemorphdilateFrame) -> ImagemorphdilateFrame {
  let result = image_morph_dilate_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_dilate_frame_fill(s : ImagemorphdilateFrame, v : Double) -> ImagemorphdilateFrame {
  let result = image_morph_dilate_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_dilate_frame_min(s : ImagemorphdilateFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_dilate_frame_max(s : ImagemorphdilateFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_dilate_frame_to_string(s : ImagemorphdilateFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphdilateTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_dilate_table_make(size : Int) -> ImagemorphdilateTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_dilate_table_len(s : ImagemorphdilateTable) -> Int { s.size }

pub fn image_morph_dilate_table_get(s : ImagemorphdilateTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_dilate_table_set(s : ImagemorphdilateTable, i : Int, v : Double) -> ImagemorphdilateTable {
  let result = image_morph_dilate_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_dilate_table_sum(s : ImagemorphdilateTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_morph_dilate_table_mean(s : ImagemorphdilateTable) -> Double {
  if s.size == 0 { 0.0 } else { image_morph_dilate_table_sum(s) / s.size.to_double() }
}

pub fn image_morph_dilate_table_scale(s : ImagemorphdilateTable, f : Double) -> ImagemorphdilateTable {
  let result = image_morph_dilate_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_dilate_table_add(a : ImagemorphdilateTable, b : ImagemorphdilateTable) -> ImagemorphdilateTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_dilate_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_dilate_table_copy(s : ImagemorphdilateTable) -> ImagemorphdilateTable {
  let result = image_morph_dilate_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_dilate_table_fill(s : ImagemorphdilateTable, v : Double) -> ImagemorphdilateTable {
  let result = image_morph_dilate_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_dilate_table_min(s : ImagemorphdilateTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_dilate_table_max(s : ImagemorphdilateTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_dilate_table_to_string(s : ImagemorphdilateTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphdilateGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_dilate_graphn_make(size : Int) -> ImagemorphdilateGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_dilate_graphn_len(s : ImagemorphdilateGraphN) -> Int { s.size }

pub fn image_morph_dilate_graphn_get(s : ImagemorphdilateGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_dilate_graphn_set(s : ImagemorphdilateGraphN, i : Int, v : Double) -> ImagemorphdilateGraphN {
  let result = image_morph_dilate_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_dilate_graphn_sum(s : ImagemorphdilateGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_morph_dilate_graphn_mean(s : ImagemorphdilateGraphN) -> Double {
  if s.size == 0 { 0.0 } else { image_morph_dilate_graphn_sum(s) / s.size.to_double() }
}

pub fn image_morph_dilate_graphn_scale(s : ImagemorphdilateGraphN, f : Double) -> ImagemorphdilateGraphN {
  let result = image_morph_dilate_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_dilate_graphn_add(a : ImagemorphdilateGraphN, b : ImagemorphdilateGraphN) -> ImagemorphdilateGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_dilate_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_dilate_graphn_copy(s : ImagemorphdilateGraphN) -> ImagemorphdilateGraphN {
  let result = image_morph_dilate_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_dilate_graphn_fill(s : ImagemorphdilateGraphN, v : Double) -> ImagemorphdilateGraphN {
  let result = image_morph_dilate_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_dilate_graphn_min(s : ImagemorphdilateGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_dilate_graphn_max(s : ImagemorphdilateGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_dilate_graphn_to_string(s : ImagemorphdilateGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphdilateNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_dilate_node_make(size : Int) -> ImagemorphdilateNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_dilate_node_len(s : ImagemorphdilateNode) -> Int { s.size }

pub fn image_morph_dilate_node_get(s : ImagemorphdilateNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_dilate_node_set(s : ImagemorphdilateNode, i : Int, v : Double) -> ImagemorphdilateNode {
  let result = image_morph_dilate_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_dilate_node_sum(s : ImagemorphdilateNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_morph_dilate_node_mean(s : ImagemorphdilateNode) -> Double {
  if s.size == 0 { 0.0 } else { image_morph_dilate_node_sum(s) / s.size.to_double() }
}

pub fn image_morph_dilate_node_scale(s : ImagemorphdilateNode, f : Double) -> ImagemorphdilateNode {
  let result = image_morph_dilate_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_dilate_node_add(a : ImagemorphdilateNode, b : ImagemorphdilateNode) -> ImagemorphdilateNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_dilate_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_dilate_node_copy(s : ImagemorphdilateNode) -> ImagemorphdilateNode {
  let result = image_morph_dilate_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_dilate_node_fill(s : ImagemorphdilateNode, v : Double) -> ImagemorphdilateNode {
  let result = image_morph_dilate_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_dilate_node_min(s : ImagemorphdilateNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_dilate_node_max(s : ImagemorphdilateNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_dilate_node_to_string(s : ImagemorphdilateNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphdilateEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_dilate_edge_make(size : Int) -> ImagemorphdilateEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_dilate_edge_len(s : ImagemorphdilateEdge) -> Int { s.size }

pub fn image_morph_dilate_edge_get(s : ImagemorphdilateEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_dilate_edge_set(s : ImagemorphdilateEdge, i : Int, v : Double) -> ImagemorphdilateEdge {
  let result = image_morph_dilate_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_dilate_edge_sum(s : ImagemorphdilateEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_morph_dilate_edge_mean(s : ImagemorphdilateEdge) -> Double {
  if s.size == 0 { 0.0 } else { image_morph_dilate_edge_sum(s) / s.size.to_double() }
}

pub fn image_morph_dilate_edge_scale(s : ImagemorphdilateEdge, f : Double) -> ImagemorphdilateEdge {
  let result = image_morph_dilate_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_dilate_edge_add(a : ImagemorphdilateEdge, b : ImagemorphdilateEdge) -> ImagemorphdilateEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_dilate_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_dilate_edge_copy(s : ImagemorphdilateEdge) -> ImagemorphdilateEdge {
  let result = image_morph_dilate_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_dilate_edge_fill(s : ImagemorphdilateEdge, v : Double) -> ImagemorphdilateEdge {
  let result = image_morph_dilate_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_dilate_edge_min(s : ImagemorphdilateEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_dilate_edge_max(s : ImagemorphdilateEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_dilate_edge_to_string(s : ImagemorphdilateEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphdilatePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_dilate_path_make(size : Int) -> ImagemorphdilatePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_dilate_path_len(s : ImagemorphdilatePath) -> Int { s.size }

pub fn image_morph_dilate_path_get(s : ImagemorphdilatePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_dilate_path_set(s : ImagemorphdilatePath, i : Int, v : Double) -> ImagemorphdilatePath {
  let result = image_morph_dilate_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_dilate_path_sum(s : ImagemorphdilatePath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_morph_dilate_path_mean(s : ImagemorphdilatePath) -> Double {
  if s.size == 0 { 0.0 } else { image_morph_dilate_path_sum(s) / s.size.to_double() }
}

pub fn image_morph_dilate_path_scale(s : ImagemorphdilatePath, f : Double) -> ImagemorphdilatePath {
  let result = image_morph_dilate_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_dilate_path_add(a : ImagemorphdilatePath, b : ImagemorphdilatePath) -> ImagemorphdilatePath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_dilate_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_dilate_path_copy(s : ImagemorphdilatePath) -> ImagemorphdilatePath {
  let result = image_morph_dilate_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_dilate_path_fill(s : ImagemorphdilatePath, v : Double) -> ImagemorphdilatePath {
  let result = image_morph_dilate_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_dilate_path_min(s : ImagemorphdilatePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_dilate_path_max(s : ImagemorphdilatePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_dilate_path_to_string(s : ImagemorphdilatePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphdilateCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_dilate_cluster_make(size : Int) -> ImagemorphdilateCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_dilate_cluster_len(s : ImagemorphdilateCluster) -> Int { s.size }

pub fn image_morph_dilate_cluster_get(s : ImagemorphdilateCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_dilate_cluster_set(s : ImagemorphdilateCluster, i : Int, v : Double) -> ImagemorphdilateCluster {
  let result = image_morph_dilate_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_dilate_cluster_sum(s : ImagemorphdilateCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_morph_dilate_cluster_mean(s : ImagemorphdilateCluster) -> Double {
  if s.size == 0 { 0.0 } else { image_morph_dilate_cluster_sum(s) / s.size.to_double() }
}

pub fn image_morph_dilate_cluster_scale(s : ImagemorphdilateCluster, f : Double) -> ImagemorphdilateCluster {
  let result = image_morph_dilate_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_dilate_cluster_add(a : ImagemorphdilateCluster, b : ImagemorphdilateCluster) -> ImagemorphdilateCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_dilate_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_dilate_cluster_copy(s : ImagemorphdilateCluster) -> ImagemorphdilateCluster {
  let result = image_morph_dilate_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_dilate_cluster_fill(s : ImagemorphdilateCluster, v : Double) -> ImagemorphdilateCluster {
  let result = image_morph_dilate_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_dilate_cluster_min(s : ImagemorphdilateCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_dilate_cluster_max(s : ImagemorphdilateCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_dilate_cluster_to_string(s : ImagemorphdilateCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphdilateModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_dilate_model_make(size : Int) -> ImagemorphdilateModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_dilate_model_len(s : ImagemorphdilateModel) -> Int { s.size }

pub fn image_morph_dilate_model_get(s : ImagemorphdilateModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_dilate_model_set(s : ImagemorphdilateModel, i : Int, v : Double) -> ImagemorphdilateModel {
  let result = image_morph_dilate_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_dilate_model_sum(s : ImagemorphdilateModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_morph_dilate_model_mean(s : ImagemorphdilateModel) -> Double {
  if s.size == 0 { 0.0 } else { image_morph_dilate_model_sum(s) / s.size.to_double() }
}

pub fn image_morph_dilate_model_scale(s : ImagemorphdilateModel, f : Double) -> ImagemorphdilateModel {
  let result = image_morph_dilate_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_dilate_model_add(a : ImagemorphdilateModel, b : ImagemorphdilateModel) -> ImagemorphdilateModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_dilate_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_dilate_model_copy(s : ImagemorphdilateModel) -> ImagemorphdilateModel {
  let result = image_morph_dilate_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_dilate_model_fill(s : ImagemorphdilateModel, v : Double) -> ImagemorphdilateModel {
  let result = image_morph_dilate_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_dilate_model_min(s : ImagemorphdilateModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_dilate_model_max(s : ImagemorphdilateModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_dilate_model_to_string(s : ImagemorphdilateModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphdilateLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_dilate_layer_make(size : Int) -> ImagemorphdilateLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_dilate_layer_len(s : ImagemorphdilateLayer) -> Int { s.size }

pub fn image_morph_dilate_layer_get(s : ImagemorphdilateLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_dilate_layer_set(s : ImagemorphdilateLayer, i : Int, v : Double) -> ImagemorphdilateLayer {
  let result = image_morph_dilate_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_dilate_layer_sum(s : ImagemorphdilateLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_morph_dilate_layer_mean(s : ImagemorphdilateLayer) -> Double {
  if s.size == 0 { 0.0 } else { image_morph_dilate_layer_sum(s) / s.size.to_double() }
}

pub fn image_morph_dilate_layer_scale(s : ImagemorphdilateLayer, f : Double) -> ImagemorphdilateLayer {
  let result = image_morph_dilate_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_dilate_layer_add(a : ImagemorphdilateLayer, b : ImagemorphdilateLayer) -> ImagemorphdilateLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_dilate_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_dilate_layer_copy(s : ImagemorphdilateLayer) -> ImagemorphdilateLayer {
  let result = image_morph_dilate_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_dilate_layer_fill(s : ImagemorphdilateLayer, v : Double) -> ImagemorphdilateLayer {
  let result = image_morph_dilate_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_dilate_layer_min(s : ImagemorphdilateLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_dilate_layer_max(s : ImagemorphdilateLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_dilate_layer_to_string(s : ImagemorphdilateLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphdilateBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_dilate_buffer_make(size : Int) -> ImagemorphdilateBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_dilate_buffer_len(s : ImagemorphdilateBuffer) -> Int { s.size }

pub fn image_morph_dilate_buffer_get(s : ImagemorphdilateBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_dilate_buffer_set(s : ImagemorphdilateBuffer, i : Int, v : Double) -> ImagemorphdilateBuffer {
  let result = image_morph_dilate_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_dilate_buffer_sum(s : ImagemorphdilateBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_morph_dilate_buffer_mean(s : ImagemorphdilateBuffer) -> Double {
  if s.size == 0 { 0.0 } else { image_morph_dilate_buffer_sum(s) / s.size.to_double() }
}

pub fn image_morph_dilate_buffer_scale(s : ImagemorphdilateBuffer, f : Double) -> ImagemorphdilateBuffer {
  let result = image_morph_dilate_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_dilate_buffer_add(a : ImagemorphdilateBuffer, b : ImagemorphdilateBuffer) -> ImagemorphdilateBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_dilate_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_dilate_buffer_copy(s : ImagemorphdilateBuffer) -> ImagemorphdilateBuffer {
  let result = image_morph_dilate_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_dilate_buffer_fill(s : ImagemorphdilateBuffer, v : Double) -> ImagemorphdilateBuffer {
  let result = image_morph_dilate_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_dilate_buffer_min(s : ImagemorphdilateBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_dilate_buffer_max(s : ImagemorphdilateBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_dilate_buffer_to_string(s : ImagemorphdilateBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphdilateCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_dilate_cursor_make(size : Int) -> ImagemorphdilateCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_dilate_cursor_len(s : ImagemorphdilateCursor) -> Int { s.size }

pub fn image_morph_dilate_cursor_get(s : ImagemorphdilateCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_dilate_cursor_set(s : ImagemorphdilateCursor, i : Int, v : Double) -> ImagemorphdilateCursor {
  let result = image_morph_dilate_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_dilate_cursor_sum(s : ImagemorphdilateCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_morph_dilate_cursor_mean(s : ImagemorphdilateCursor) -> Double {
  if s.size == 0 { 0.0 } else { image_morph_dilate_cursor_sum(s) / s.size.to_double() }
}

pub fn image_morph_dilate_cursor_scale(s : ImagemorphdilateCursor, f : Double) -> ImagemorphdilateCursor {
  let result = image_morph_dilate_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_dilate_cursor_add(a : ImagemorphdilateCursor, b : ImagemorphdilateCursor) -> ImagemorphdilateCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_dilate_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_dilate_cursor_copy(s : ImagemorphdilateCursor) -> ImagemorphdilateCursor {
  let result = image_morph_dilate_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_dilate_cursor_fill(s : ImagemorphdilateCursor, v : Double) -> ImagemorphdilateCursor {
  let result = image_morph_dilate_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_dilate_cursor_min(s : ImagemorphdilateCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_dilate_cursor_max(s : ImagemorphdilateCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_dilate_cursor_to_string(s : ImagemorphdilateCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphdilateView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_dilate_view_make(size : Int) -> ImagemorphdilateView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_dilate_view_len(s : ImagemorphdilateView) -> Int { s.size }

pub fn image_morph_dilate_view_get(s : ImagemorphdilateView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_dilate_view_set(s : ImagemorphdilateView, i : Int, v : Double) -> ImagemorphdilateView {
  let result = image_morph_dilate_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_dilate_view_sum(s : ImagemorphdilateView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_morph_dilate_view_mean(s : ImagemorphdilateView) -> Double {
  if s.size == 0 { 0.0 } else { image_morph_dilate_view_sum(s) / s.size.to_double() }
}

pub fn image_morph_dilate_view_scale(s : ImagemorphdilateView, f : Double) -> ImagemorphdilateView {
  let result = image_morph_dilate_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_dilate_view_add(a : ImagemorphdilateView, b : ImagemorphdilateView) -> ImagemorphdilateView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_dilate_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_dilate_view_copy(s : ImagemorphdilateView) -> ImagemorphdilateView {
  let result = image_morph_dilate_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_dilate_view_fill(s : ImagemorphdilateView, v : Double) -> ImagemorphdilateView {
  let result = image_morph_dilate_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_dilate_view_min(s : ImagemorphdilateView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_dilate_view_max(s : ImagemorphdilateView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_dilate_view_to_string(s : ImagemorphdilateView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphdilateRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_dilate_range_make(size : Int) -> ImagemorphdilateRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_dilate_range_len(s : ImagemorphdilateRange) -> Int { s.size }

pub fn image_morph_dilate_range_get(s : ImagemorphdilateRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_dilate_range_set(s : ImagemorphdilateRange, i : Int, v : Double) -> ImagemorphdilateRange {
  let result = image_morph_dilate_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_dilate_range_sum(s : ImagemorphdilateRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_morph_dilate_range_mean(s : ImagemorphdilateRange) -> Double {
  if s.size == 0 { 0.0 } else { image_morph_dilate_range_sum(s) / s.size.to_double() }
}

pub fn image_morph_dilate_range_scale(s : ImagemorphdilateRange, f : Double) -> ImagemorphdilateRange {
  let result = image_morph_dilate_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_dilate_range_add(a : ImagemorphdilateRange, b : ImagemorphdilateRange) -> ImagemorphdilateRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_dilate_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_dilate_range_copy(s : ImagemorphdilateRange) -> ImagemorphdilateRange {
  let result = image_morph_dilate_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_dilate_range_fill(s : ImagemorphdilateRange, v : Double) -> ImagemorphdilateRange {
  let result = image_morph_dilate_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_dilate_range_min(s : ImagemorphdilateRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_dilate_range_max(s : ImagemorphdilateRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_dilate_range_to_string(s : ImagemorphdilateRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphdilateSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_dilate_slice_make(size : Int) -> ImagemorphdilateSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_dilate_slice_len(s : ImagemorphdilateSlice) -> Int { s.size }

pub fn image_morph_dilate_slice_get(s : ImagemorphdilateSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_dilate_slice_set(s : ImagemorphdilateSlice, i : Int, v : Double) -> ImagemorphdilateSlice {
  let result = image_morph_dilate_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_dilate_slice_sum(s : ImagemorphdilateSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_morph_dilate_slice_mean(s : ImagemorphdilateSlice) -> Double {
  if s.size == 0 { 0.0 } else { image_morph_dilate_slice_sum(s) / s.size.to_double() }
}

pub fn image_morph_dilate_slice_scale(s : ImagemorphdilateSlice, f : Double) -> ImagemorphdilateSlice {
  let result = image_morph_dilate_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_dilate_slice_add(a : ImagemorphdilateSlice, b : ImagemorphdilateSlice) -> ImagemorphdilateSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_dilate_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_dilate_slice_copy(s : ImagemorphdilateSlice) -> ImagemorphdilateSlice {
  let result = image_morph_dilate_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_dilate_slice_fill(s : ImagemorphdilateSlice, v : Double) -> ImagemorphdilateSlice {
  let result = image_morph_dilate_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_dilate_slice_min(s : ImagemorphdilateSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_dilate_slice_max(s : ImagemorphdilateSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_dilate_slice_to_string(s : ImagemorphdilateSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn image_morph_dilate_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_morph_dilate_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_morph_dilate_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_morph_dilate_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_morph_dilate_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_morph_dilate_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_morph_dilate_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_morph_dilate_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_morph_dilate_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_morph_dilate_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_morph_dilate_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_morph_dilate_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_morph_dilate_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_morph_dilate_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_morph_dilate_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_morph_dilate_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_morph_dilate_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_morph_dilate_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_morph_dilate_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_morph_dilate_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_morph_dilate_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_morph_dilate_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_morph_dilate_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_morph_dilate_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_morph_dilate_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}


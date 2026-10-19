///===
/// extcore/image_morph_tophat

pub(all) struct ImagemorphtophatPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_morph_tophat_make_point(x : Double, y : Double) -> ImagemorphtophatPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_morph_tophat_make_point3(x : Double, y : Double, z : Double) -> ImagemorphtophatPoint {
  { x, y, z, label: 0 }
}

pub fn image_morph_tophat_point_x(pt : ImagemorphtophatPoint) -> Double { pt.x }

pub fn image_morph_tophat_point_y(pt : ImagemorphtophatPoint) -> Double { pt.y }

pub fn image_morph_tophat_point_z(pt : ImagemorphtophatPoint) -> Double { pt.z }

pub fn image_morph_tophat_point_label(pt : ImagemorphtophatPoint) -> Int { pt.label }

pub fn image_morph_tophat_point_dist(a : ImagemorphtophatPoint, b : ImagemorphtophatPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  image_morph_tophat_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn image_morph_tophat_point_add(a : ImagemorphtophatPoint, b : ImagemorphtophatPoint) -> ImagemorphtophatPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn image_morph_tophat_point_sub(a : ImagemorphtophatPoint, b : ImagemorphtophatPoint) -> ImagemorphtophatPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn image_morph_tophat_point_scale(pt : ImagemorphtophatPoint, s : Double) -> ImagemorphtophatPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn image_morph_tophat_point_dot(a : ImagemorphtophatPoint, b : ImagemorphtophatPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn image_morph_tophat_point_cross(a : ImagemorphtophatPoint, b : ImagemorphtophatPoint) -> ImagemorphtophatPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn image_morph_tophat_point_norm(pt : ImagemorphtophatPoint) -> Double {
  image_morph_tophat_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn image_morph_tophat_point_normalize(pt : ImagemorphtophatPoint) -> ImagemorphtophatPoint {
  let n = image_morph_tophat_point_norm(pt)
  if n < 0.0000001 { pt } else { image_morph_tophat_point_scale(pt, 1.0 / n) }
}

pub fn image_morph_tophat_point_negate(pt : ImagemorphtophatPoint) -> ImagemorphtophatPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn image_morph_tophat_point_mid(a : ImagemorphtophatPoint, b : ImagemorphtophatPoint) -> ImagemorphtophatPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn image_morph_tophat_point_lerp(a : ImagemorphtophatPoint, b : ImagemorphtophatPoint, t : Double) -> ImagemorphtophatPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn image_morph_tophat_point_to_string(pt : ImagemorphtophatPoint) -> String {
  "(" + image_morph_tophat_dbl(pt.x) + ", " + image_morph_tophat_dbl(pt.y) + ", " + image_morph_tophat_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct ImagemorphtophatSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_morph_tophat_make_series(vals : Array[Double], name : String) -> ImagemorphtophatSeries {
  { vals, name, meta: 0 }
}

pub fn image_morph_tophat_series_len(s : ImagemorphtophatSeries) -> Int { s.vals.length() }

pub fn image_morph_tophat_series_sum(s : ImagemorphtophatSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn image_morph_tophat_series_mean(s : ImagemorphtophatSeries) -> Double {
  let n = image_morph_tophat_series_len(s)
  if n == 0 { 0.0 } else { image_morph_tophat_series_sum(s) / n.to_double() }
}

pub fn image_morph_tophat_series_min(s : ImagemorphtophatSeries) -> Double {
  let n = image_morph_tophat_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn image_morph_tophat_series_max(s : ImagemorphtophatSeries) -> Double {
  let n = image_morph_tophat_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn image_morph_tophat_series_range(s : ImagemorphtophatSeries) -> Double {
  image_morph_tophat_series_max(s) - image_morph_tophat_series_min(s)
}

pub fn image_morph_tophat_series_var(s : ImagemorphtophatSeries) -> Double {
  let n = image_morph_tophat_series_len(s)
  if n == 0 { 0.0 } else {
    let m = image_morph_tophat_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn image_morph_tophat_series_std(s : ImagemorphtophatSeries) -> Double { image_morph_tophat_sqrt(image_morph_tophat_series_var(s)) }

pub fn image_morph_tophat_series_median(s : ImagemorphtophatSeries) -> Double {
  let n = image_morph_tophat_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = image_morph_tophat_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn image_morph_tophat_series_scale(s : ImagemorphtophatSeries, f : Double) -> ImagemorphtophatSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = image_morph_tophat_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn image_morph_tophat_series_add(a : ImagemorphtophatSeries, b : ImagemorphtophatSeries) -> ImagemorphtophatSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = image_morph_tophat_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn image_morph_tophat_series_sub(a : ImagemorphtophatSeries, b : ImagemorphtophatSeries) -> ImagemorphtophatSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = image_morph_tophat_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn image_morph_tophat_series_normalize(s : ImagemorphtophatSeries) -> ImagemorphtophatSeries {
  let mn = image_morph_tophat_series_min(s)
  let mx = image_morph_tophat_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = image_morph_tophat_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn image_morph_tophat_series_cumsum(s : ImagemorphtophatSeries) -> ImagemorphtophatSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = image_morph_tophat_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn image_morph_tophat_series_to_string(s : ImagemorphtophatSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + image_morph_tophat_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagemorphtophatMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_morph_tophat_make_matrix(rows : Int, cols : Int, val : Double) -> ImagemorphtophatMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn image_morph_tophat_matrix_identity(n : Int) -> ImagemorphtophatMatrix {
  let m = image_morph_tophat_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn image_morph_tophat_matrix_get(m : ImagemorphtophatMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn image_morph_tophat_matrix_transpose(m : ImagemorphtophatMatrix) -> ImagemorphtophatMatrix {
  let result = image_morph_tophat_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn image_morph_tophat_matrix_add(a : ImagemorphtophatMatrix, b : ImagemorphtophatMatrix) -> ImagemorphtophatMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = image_morph_tophat_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn image_morph_tophat_matrix_scale(m : ImagemorphtophatMatrix, s : Double) -> ImagemorphtophatMatrix {
  let result = image_morph_tophat_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn image_morph_tophat_matrix_multiply(a : ImagemorphtophatMatrix, b : ImagemorphtophatMatrix) -> ImagemorphtophatMatrix {
  if a.cols != b.rows { return image_morph_tophat_make_matrix(a.rows, b.cols, 0.0) }
  let result = image_morph_tophat_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn image_morph_tophat_matrix_trace(m : ImagemorphtophatMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn image_morph_tophat_matrix_det(m : ImagemorphtophatMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn image_morph_tophat_matrix_norm(m : ImagemorphtophatMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  image_morph_tophat_sqrt(sum)
}

pub fn image_morph_tophat_matrix_to_string(m : ImagemorphtophatMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + image_morph_tophat_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct ImagemorphtophatVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_morph_tophat_make_vector(comps : Array[Double]) -> ImagemorphtophatVector {
  { comps, dim: comps.length() }
}

pub fn image_morph_tophat_vector_zero(dim : Int) -> ImagemorphtophatVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn image_morph_tophat_vector_add(a : ImagemorphtophatVector, b : ImagemorphtophatVector) -> ImagemorphtophatVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = image_morph_tophat_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn image_morph_tophat_vector_sub(a : ImagemorphtophatVector, b : ImagemorphtophatVector) -> ImagemorphtophatVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = image_morph_tophat_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn image_morph_tophat_vector_scale(v : ImagemorphtophatVector, s : Double) -> ImagemorphtophatVector {
  let mut result = []
  for i in 0..<v.dim { result = image_morph_tophat_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn image_morph_tophat_vector_dot(a : ImagemorphtophatVector, b : ImagemorphtophatVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn image_morph_tophat_vector_norm(v : ImagemorphtophatVector) -> Double { image_morph_tophat_sqrt(image_morph_tophat_vector_dot(v, v)) }

pub fn image_morph_tophat_vector_normalize(v : ImagemorphtophatVector) -> ImagemorphtophatVector {
  let n = image_morph_tophat_vector_norm(v)
  if n < 0.0000001 { v } else { image_morph_tophat_vector_scale(v, 1.0 / n) }
}

pub fn image_morph_tophat_vector_dist(a : ImagemorphtophatVector, b : ImagemorphtophatVector) -> Double {
  image_morph_tophat_vector_norm(image_morph_tophat_vector_sub(a, b))
}

pub fn image_morph_tophat_vector_to_string(v : ImagemorphtophatVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + image_morph_tophat_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn image_morph_tophat_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn image_morph_tophat_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = image_morph_tophat_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn image_morph_tophat_std(data : Array[Double]) -> Double { image_morph_tophat_sqrt(image_morph_tophat_var(data)) }

pub fn image_morph_tophat_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = image_morph_tophat_mean(a); let mb = image_morph_tophat_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn image_morph_tophat_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = image_morph_tophat_std(a); let sb = image_morph_tophat_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { image_morph_tophat_cov(a, b) / (sa * sb) }
}

pub fn image_morph_tophat_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = image_morph_tophat_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn image_morph_tophat_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn image_morph_tophat_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn image_morph_tophat_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  image_morph_tophat_sqrt(image_morph_tophat_mse(pred, labels))
}

pub fn image_morph_tophat_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + image_morph_tophat_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn image_morph_tophat_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = image_morph_tophat_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn image_morph_tophat_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn image_morph_tophat_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn image_morph_tophat_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = image_morph_tophat_precision(pred, labels, pos); let r = image_morph_tophat_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn image_morph_tophat_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn image_morph_tophat_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = image_morph_tophat_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn image_morph_tophat_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn image_morph_tophat_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn image_morph_tophat_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = image_morph_tophat_gcd(a, b)
    (a / g) * b
  }
}

pub fn image_morph_tophat_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn image_morph_tophat_fibonacci(n : Int) -> Int {
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

pub fn image_morph_tophat_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = image_morph_tophat_min(data); let mx = image_morph_tophat_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn image_morph_tophat_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = image_morph_tophat_mean(data); let sd = image_morph_tophat_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn image_morph_tophat_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn image_morph_tophat_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn image_morph_tophat_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn image_morph_tophat_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn image_morph_tophat_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn image_morph_tophat_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn image_morph_tophat_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn image_morph_tophat_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn image_morph_tophat_dbl(x : Double) -> String {
  let i = if x >= 0.0 { image_morph_tophat_int(x) } else { -image_morph_tophat_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { image_morph_tophat_int(f * 1000000.0) } else { image_morph_tophat_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn image_morph_tophat_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn image_morph_tophat_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct ImagemorphtophatFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_tophat_frame_make(size : Int) -> ImagemorphtophatFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_tophat_frame_len(s : ImagemorphtophatFrame) -> Int { s.size }

pub fn image_morph_tophat_frame_get(s : ImagemorphtophatFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_tophat_frame_set(s : ImagemorphtophatFrame, i : Int, v : Double) -> ImagemorphtophatFrame {
  let result = image_morph_tophat_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_tophat_frame_sum(s : ImagemorphtophatFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_morph_tophat_frame_mean(s : ImagemorphtophatFrame) -> Double {
  if s.size == 0 { 0.0 } else { image_morph_tophat_frame_sum(s) / s.size.to_double() }
}

pub fn image_morph_tophat_frame_scale(s : ImagemorphtophatFrame, f : Double) -> ImagemorphtophatFrame {
  let result = image_morph_tophat_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_tophat_frame_add(a : ImagemorphtophatFrame, b : ImagemorphtophatFrame) -> ImagemorphtophatFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_tophat_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_tophat_frame_copy(s : ImagemorphtophatFrame) -> ImagemorphtophatFrame {
  let result = image_morph_tophat_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_tophat_frame_fill(s : ImagemorphtophatFrame, v : Double) -> ImagemorphtophatFrame {
  let result = image_morph_tophat_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_tophat_frame_min(s : ImagemorphtophatFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_tophat_frame_max(s : ImagemorphtophatFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_tophat_frame_to_string(s : ImagemorphtophatFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphtophatTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_tophat_table_make(size : Int) -> ImagemorphtophatTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_tophat_table_len(s : ImagemorphtophatTable) -> Int { s.size }

pub fn image_morph_tophat_table_get(s : ImagemorphtophatTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_tophat_table_set(s : ImagemorphtophatTable, i : Int, v : Double) -> ImagemorphtophatTable {
  let result = image_morph_tophat_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_tophat_table_sum(s : ImagemorphtophatTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_morph_tophat_table_mean(s : ImagemorphtophatTable) -> Double {
  if s.size == 0 { 0.0 } else { image_morph_tophat_table_sum(s) / s.size.to_double() }
}

pub fn image_morph_tophat_table_scale(s : ImagemorphtophatTable, f : Double) -> ImagemorphtophatTable {
  let result = image_morph_tophat_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_tophat_table_add(a : ImagemorphtophatTable, b : ImagemorphtophatTable) -> ImagemorphtophatTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_tophat_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_tophat_table_copy(s : ImagemorphtophatTable) -> ImagemorphtophatTable {
  let result = image_morph_tophat_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_tophat_table_fill(s : ImagemorphtophatTable, v : Double) -> ImagemorphtophatTable {
  let result = image_morph_tophat_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_tophat_table_min(s : ImagemorphtophatTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_tophat_table_max(s : ImagemorphtophatTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_tophat_table_to_string(s : ImagemorphtophatTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphtophatGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_tophat_graphn_make(size : Int) -> ImagemorphtophatGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_tophat_graphn_len(s : ImagemorphtophatGraphN) -> Int { s.size }

pub fn image_morph_tophat_graphn_get(s : ImagemorphtophatGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_tophat_graphn_set(s : ImagemorphtophatGraphN, i : Int, v : Double) -> ImagemorphtophatGraphN {
  let result = image_morph_tophat_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_tophat_graphn_sum(s : ImagemorphtophatGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_morph_tophat_graphn_mean(s : ImagemorphtophatGraphN) -> Double {
  if s.size == 0 { 0.0 } else { image_morph_tophat_graphn_sum(s) / s.size.to_double() }
}

pub fn image_morph_tophat_graphn_scale(s : ImagemorphtophatGraphN, f : Double) -> ImagemorphtophatGraphN {
  let result = image_morph_tophat_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_tophat_graphn_add(a : ImagemorphtophatGraphN, b : ImagemorphtophatGraphN) -> ImagemorphtophatGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_tophat_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_tophat_graphn_copy(s : ImagemorphtophatGraphN) -> ImagemorphtophatGraphN {
  let result = image_morph_tophat_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_tophat_graphn_fill(s : ImagemorphtophatGraphN, v : Double) -> ImagemorphtophatGraphN {
  let result = image_morph_tophat_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_tophat_graphn_min(s : ImagemorphtophatGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_tophat_graphn_max(s : ImagemorphtophatGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_tophat_graphn_to_string(s : ImagemorphtophatGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphtophatNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_tophat_node_make(size : Int) -> ImagemorphtophatNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_tophat_node_len(s : ImagemorphtophatNode) -> Int { s.size }

pub fn image_morph_tophat_node_get(s : ImagemorphtophatNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_tophat_node_set(s : ImagemorphtophatNode, i : Int, v : Double) -> ImagemorphtophatNode {
  let result = image_morph_tophat_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_tophat_node_sum(s : ImagemorphtophatNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_morph_tophat_node_mean(s : ImagemorphtophatNode) -> Double {
  if s.size == 0 { 0.0 } else { image_morph_tophat_node_sum(s) / s.size.to_double() }
}

pub fn image_morph_tophat_node_scale(s : ImagemorphtophatNode, f : Double) -> ImagemorphtophatNode {
  let result = image_morph_tophat_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_tophat_node_add(a : ImagemorphtophatNode, b : ImagemorphtophatNode) -> ImagemorphtophatNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_tophat_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_tophat_node_copy(s : ImagemorphtophatNode) -> ImagemorphtophatNode {
  let result = image_morph_tophat_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_tophat_node_fill(s : ImagemorphtophatNode, v : Double) -> ImagemorphtophatNode {
  let result = image_morph_tophat_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_tophat_node_min(s : ImagemorphtophatNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_tophat_node_max(s : ImagemorphtophatNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_tophat_node_to_string(s : ImagemorphtophatNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphtophatEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_tophat_edge_make(size : Int) -> ImagemorphtophatEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_tophat_edge_len(s : ImagemorphtophatEdge) -> Int { s.size }

pub fn image_morph_tophat_edge_get(s : ImagemorphtophatEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_tophat_edge_set(s : ImagemorphtophatEdge, i : Int, v : Double) -> ImagemorphtophatEdge {
  let result = image_morph_tophat_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_tophat_edge_sum(s : ImagemorphtophatEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_morph_tophat_edge_mean(s : ImagemorphtophatEdge) -> Double {
  if s.size == 0 { 0.0 } else { image_morph_tophat_edge_sum(s) / s.size.to_double() }
}

pub fn image_morph_tophat_edge_scale(s : ImagemorphtophatEdge, f : Double) -> ImagemorphtophatEdge {
  let result = image_morph_tophat_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_tophat_edge_add(a : ImagemorphtophatEdge, b : ImagemorphtophatEdge) -> ImagemorphtophatEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_tophat_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_tophat_edge_copy(s : ImagemorphtophatEdge) -> ImagemorphtophatEdge {
  let result = image_morph_tophat_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_tophat_edge_fill(s : ImagemorphtophatEdge, v : Double) -> ImagemorphtophatEdge {
  let result = image_morph_tophat_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_tophat_edge_min(s : ImagemorphtophatEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_tophat_edge_max(s : ImagemorphtophatEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_tophat_edge_to_string(s : ImagemorphtophatEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphtophatPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_tophat_path_make(size : Int) -> ImagemorphtophatPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_tophat_path_len(s : ImagemorphtophatPath) -> Int { s.size }

pub fn image_morph_tophat_path_get(s : ImagemorphtophatPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_tophat_path_set(s : ImagemorphtophatPath, i : Int, v : Double) -> ImagemorphtophatPath {
  let result = image_morph_tophat_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_tophat_path_sum(s : ImagemorphtophatPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_morph_tophat_path_mean(s : ImagemorphtophatPath) -> Double {
  if s.size == 0 { 0.0 } else { image_morph_tophat_path_sum(s) / s.size.to_double() }
}

pub fn image_morph_tophat_path_scale(s : ImagemorphtophatPath, f : Double) -> ImagemorphtophatPath {
  let result = image_morph_tophat_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_tophat_path_add(a : ImagemorphtophatPath, b : ImagemorphtophatPath) -> ImagemorphtophatPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_tophat_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_tophat_path_copy(s : ImagemorphtophatPath) -> ImagemorphtophatPath {
  let result = image_morph_tophat_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_tophat_path_fill(s : ImagemorphtophatPath, v : Double) -> ImagemorphtophatPath {
  let result = image_morph_tophat_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_tophat_path_min(s : ImagemorphtophatPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_tophat_path_max(s : ImagemorphtophatPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_tophat_path_to_string(s : ImagemorphtophatPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphtophatCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_tophat_cluster_make(size : Int) -> ImagemorphtophatCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_tophat_cluster_len(s : ImagemorphtophatCluster) -> Int { s.size }

pub fn image_morph_tophat_cluster_get(s : ImagemorphtophatCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_tophat_cluster_set(s : ImagemorphtophatCluster, i : Int, v : Double) -> ImagemorphtophatCluster {
  let result = image_morph_tophat_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_tophat_cluster_sum(s : ImagemorphtophatCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_morph_tophat_cluster_mean(s : ImagemorphtophatCluster) -> Double {
  if s.size == 0 { 0.0 } else { image_morph_tophat_cluster_sum(s) / s.size.to_double() }
}

pub fn image_morph_tophat_cluster_scale(s : ImagemorphtophatCluster, f : Double) -> ImagemorphtophatCluster {
  let result = image_morph_tophat_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_tophat_cluster_add(a : ImagemorphtophatCluster, b : ImagemorphtophatCluster) -> ImagemorphtophatCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_tophat_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_tophat_cluster_copy(s : ImagemorphtophatCluster) -> ImagemorphtophatCluster {
  let result = image_morph_tophat_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_tophat_cluster_fill(s : ImagemorphtophatCluster, v : Double) -> ImagemorphtophatCluster {
  let result = image_morph_tophat_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_tophat_cluster_min(s : ImagemorphtophatCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_tophat_cluster_max(s : ImagemorphtophatCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_tophat_cluster_to_string(s : ImagemorphtophatCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphtophatModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_tophat_model_make(size : Int) -> ImagemorphtophatModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_tophat_model_len(s : ImagemorphtophatModel) -> Int { s.size }

pub fn image_morph_tophat_model_get(s : ImagemorphtophatModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_tophat_model_set(s : ImagemorphtophatModel, i : Int, v : Double) -> ImagemorphtophatModel {
  let result = image_morph_tophat_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_tophat_model_sum(s : ImagemorphtophatModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_morph_tophat_model_mean(s : ImagemorphtophatModel) -> Double {
  if s.size == 0 { 0.0 } else { image_morph_tophat_model_sum(s) / s.size.to_double() }
}

pub fn image_morph_tophat_model_scale(s : ImagemorphtophatModel, f : Double) -> ImagemorphtophatModel {
  let result = image_morph_tophat_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_tophat_model_add(a : ImagemorphtophatModel, b : ImagemorphtophatModel) -> ImagemorphtophatModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_tophat_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_tophat_model_copy(s : ImagemorphtophatModel) -> ImagemorphtophatModel {
  let result = image_morph_tophat_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_tophat_model_fill(s : ImagemorphtophatModel, v : Double) -> ImagemorphtophatModel {
  let result = image_morph_tophat_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_tophat_model_min(s : ImagemorphtophatModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_tophat_model_max(s : ImagemorphtophatModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_tophat_model_to_string(s : ImagemorphtophatModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphtophatLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_tophat_layer_make(size : Int) -> ImagemorphtophatLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_tophat_layer_len(s : ImagemorphtophatLayer) -> Int { s.size }

pub fn image_morph_tophat_layer_get(s : ImagemorphtophatLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_tophat_layer_set(s : ImagemorphtophatLayer, i : Int, v : Double) -> ImagemorphtophatLayer {
  let result = image_morph_tophat_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_tophat_layer_sum(s : ImagemorphtophatLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_morph_tophat_layer_mean(s : ImagemorphtophatLayer) -> Double {
  if s.size == 0 { 0.0 } else { image_morph_tophat_layer_sum(s) / s.size.to_double() }
}

pub fn image_morph_tophat_layer_scale(s : ImagemorphtophatLayer, f : Double) -> ImagemorphtophatLayer {
  let result = image_morph_tophat_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_tophat_layer_add(a : ImagemorphtophatLayer, b : ImagemorphtophatLayer) -> ImagemorphtophatLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_tophat_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_tophat_layer_copy(s : ImagemorphtophatLayer) -> ImagemorphtophatLayer {
  let result = image_morph_tophat_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_tophat_layer_fill(s : ImagemorphtophatLayer, v : Double) -> ImagemorphtophatLayer {
  let result = image_morph_tophat_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_tophat_layer_min(s : ImagemorphtophatLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_tophat_layer_max(s : ImagemorphtophatLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_tophat_layer_to_string(s : ImagemorphtophatLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphtophatBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_tophat_buffer_make(size : Int) -> ImagemorphtophatBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_tophat_buffer_len(s : ImagemorphtophatBuffer) -> Int { s.size }

pub fn image_morph_tophat_buffer_get(s : ImagemorphtophatBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_tophat_buffer_set(s : ImagemorphtophatBuffer, i : Int, v : Double) -> ImagemorphtophatBuffer {
  let result = image_morph_tophat_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_tophat_buffer_sum(s : ImagemorphtophatBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_morph_tophat_buffer_mean(s : ImagemorphtophatBuffer) -> Double {
  if s.size == 0 { 0.0 } else { image_morph_tophat_buffer_sum(s) / s.size.to_double() }
}

pub fn image_morph_tophat_buffer_scale(s : ImagemorphtophatBuffer, f : Double) -> ImagemorphtophatBuffer {
  let result = image_morph_tophat_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_tophat_buffer_add(a : ImagemorphtophatBuffer, b : ImagemorphtophatBuffer) -> ImagemorphtophatBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_tophat_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_tophat_buffer_copy(s : ImagemorphtophatBuffer) -> ImagemorphtophatBuffer {
  let result = image_morph_tophat_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_tophat_buffer_fill(s : ImagemorphtophatBuffer, v : Double) -> ImagemorphtophatBuffer {
  let result = image_morph_tophat_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_tophat_buffer_min(s : ImagemorphtophatBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_tophat_buffer_max(s : ImagemorphtophatBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_tophat_buffer_to_string(s : ImagemorphtophatBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphtophatCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_tophat_cursor_make(size : Int) -> ImagemorphtophatCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_tophat_cursor_len(s : ImagemorphtophatCursor) -> Int { s.size }

pub fn image_morph_tophat_cursor_get(s : ImagemorphtophatCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_tophat_cursor_set(s : ImagemorphtophatCursor, i : Int, v : Double) -> ImagemorphtophatCursor {
  let result = image_morph_tophat_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_tophat_cursor_sum(s : ImagemorphtophatCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_morph_tophat_cursor_mean(s : ImagemorphtophatCursor) -> Double {
  if s.size == 0 { 0.0 } else { image_morph_tophat_cursor_sum(s) / s.size.to_double() }
}

pub fn image_morph_tophat_cursor_scale(s : ImagemorphtophatCursor, f : Double) -> ImagemorphtophatCursor {
  let result = image_morph_tophat_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_tophat_cursor_add(a : ImagemorphtophatCursor, b : ImagemorphtophatCursor) -> ImagemorphtophatCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_tophat_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_tophat_cursor_copy(s : ImagemorphtophatCursor) -> ImagemorphtophatCursor {
  let result = image_morph_tophat_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_tophat_cursor_fill(s : ImagemorphtophatCursor, v : Double) -> ImagemorphtophatCursor {
  let result = image_morph_tophat_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_tophat_cursor_min(s : ImagemorphtophatCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_tophat_cursor_max(s : ImagemorphtophatCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_tophat_cursor_to_string(s : ImagemorphtophatCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphtophatView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_tophat_view_make(size : Int) -> ImagemorphtophatView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_tophat_view_len(s : ImagemorphtophatView) -> Int { s.size }

pub fn image_morph_tophat_view_get(s : ImagemorphtophatView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_tophat_view_set(s : ImagemorphtophatView, i : Int, v : Double) -> ImagemorphtophatView {
  let result = image_morph_tophat_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_tophat_view_sum(s : ImagemorphtophatView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_morph_tophat_view_mean(s : ImagemorphtophatView) -> Double {
  if s.size == 0 { 0.0 } else { image_morph_tophat_view_sum(s) / s.size.to_double() }
}

pub fn image_morph_tophat_view_scale(s : ImagemorphtophatView, f : Double) -> ImagemorphtophatView {
  let result = image_morph_tophat_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_tophat_view_add(a : ImagemorphtophatView, b : ImagemorphtophatView) -> ImagemorphtophatView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_tophat_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_tophat_view_copy(s : ImagemorphtophatView) -> ImagemorphtophatView {
  let result = image_morph_tophat_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_tophat_view_fill(s : ImagemorphtophatView, v : Double) -> ImagemorphtophatView {
  let result = image_morph_tophat_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_tophat_view_min(s : ImagemorphtophatView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_tophat_view_max(s : ImagemorphtophatView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_tophat_view_to_string(s : ImagemorphtophatView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphtophatRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_tophat_range_make(size : Int) -> ImagemorphtophatRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_tophat_range_len(s : ImagemorphtophatRange) -> Int { s.size }

pub fn image_morph_tophat_range_get(s : ImagemorphtophatRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_tophat_range_set(s : ImagemorphtophatRange, i : Int, v : Double) -> ImagemorphtophatRange {
  let result = image_morph_tophat_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_tophat_range_sum(s : ImagemorphtophatRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_morph_tophat_range_mean(s : ImagemorphtophatRange) -> Double {
  if s.size == 0 { 0.0 } else { image_morph_tophat_range_sum(s) / s.size.to_double() }
}

pub fn image_morph_tophat_range_scale(s : ImagemorphtophatRange, f : Double) -> ImagemorphtophatRange {
  let result = image_morph_tophat_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_tophat_range_add(a : ImagemorphtophatRange, b : ImagemorphtophatRange) -> ImagemorphtophatRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_tophat_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_tophat_range_copy(s : ImagemorphtophatRange) -> ImagemorphtophatRange {
  let result = image_morph_tophat_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_tophat_range_fill(s : ImagemorphtophatRange, v : Double) -> ImagemorphtophatRange {
  let result = image_morph_tophat_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_tophat_range_min(s : ImagemorphtophatRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_tophat_range_max(s : ImagemorphtophatRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_tophat_range_to_string(s : ImagemorphtophatRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphtophatSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_tophat_slice_make(size : Int) -> ImagemorphtophatSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_tophat_slice_len(s : ImagemorphtophatSlice) -> Int { s.size }

pub fn image_morph_tophat_slice_get(s : ImagemorphtophatSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_tophat_slice_set(s : ImagemorphtophatSlice, i : Int, v : Double) -> ImagemorphtophatSlice {
  let result = image_morph_tophat_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_tophat_slice_sum(s : ImagemorphtophatSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_morph_tophat_slice_mean(s : ImagemorphtophatSlice) -> Double {
  if s.size == 0 { 0.0 } else { image_morph_tophat_slice_sum(s) / s.size.to_double() }
}

pub fn image_morph_tophat_slice_scale(s : ImagemorphtophatSlice, f : Double) -> ImagemorphtophatSlice {
  let result = image_morph_tophat_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_tophat_slice_add(a : ImagemorphtophatSlice, b : ImagemorphtophatSlice) -> ImagemorphtophatSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_tophat_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_tophat_slice_copy(s : ImagemorphtophatSlice) -> ImagemorphtophatSlice {
  let result = image_morph_tophat_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_tophat_slice_fill(s : ImagemorphtophatSlice, v : Double) -> ImagemorphtophatSlice {
  let result = image_morph_tophat_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_tophat_slice_min(s : ImagemorphtophatSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_tophat_slice_max(s : ImagemorphtophatSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_tophat_slice_to_string(s : ImagemorphtophatSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn image_morph_tophat_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_morph_tophat_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_morph_tophat_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_morph_tophat_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_morph_tophat_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_morph_tophat_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_morph_tophat_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_morph_tophat_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_morph_tophat_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_morph_tophat_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_morph_tophat_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_morph_tophat_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_morph_tophat_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_morph_tophat_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_morph_tophat_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_morph_tophat_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_morph_tophat_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_morph_tophat_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_morph_tophat_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_morph_tophat_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_morph_tophat_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_morph_tophat_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_morph_tophat_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_morph_tophat_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_morph_tophat_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}


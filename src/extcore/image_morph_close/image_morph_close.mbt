///===
/// extcore/image_morph_close

pub(all) struct ImagemorphclosePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_morph_close_make_point(x : Double, y : Double) -> ImagemorphclosePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_morph_close_make_point3(x : Double, y : Double, z : Double) -> ImagemorphclosePoint {
  { x, y, z, label: 0 }
}

pub fn image_morph_close_point_x(pt : ImagemorphclosePoint) -> Double { pt.x }

pub fn image_morph_close_point_y(pt : ImagemorphclosePoint) -> Double { pt.y }

pub fn image_morph_close_point_z(pt : ImagemorphclosePoint) -> Double { pt.z }

pub fn image_morph_close_point_label(pt : ImagemorphclosePoint) -> Int { pt.label }

pub fn image_morph_close_point_dist(a : ImagemorphclosePoint, b : ImagemorphclosePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  image_morph_close_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn image_morph_close_point_add(a : ImagemorphclosePoint, b : ImagemorphclosePoint) -> ImagemorphclosePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn image_morph_close_point_sub(a : ImagemorphclosePoint, b : ImagemorphclosePoint) -> ImagemorphclosePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn image_morph_close_point_scale(pt : ImagemorphclosePoint, s : Double) -> ImagemorphclosePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn image_morph_close_point_dot(a : ImagemorphclosePoint, b : ImagemorphclosePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn image_morph_close_point_cross(a : ImagemorphclosePoint, b : ImagemorphclosePoint) -> ImagemorphclosePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn image_morph_close_point_norm(pt : ImagemorphclosePoint) -> Double {
  image_morph_close_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn image_morph_close_point_normalize(pt : ImagemorphclosePoint) -> ImagemorphclosePoint {
  let n = image_morph_close_point_norm(pt)
  if n < 0.0000001 { pt } else { image_morph_close_point_scale(pt, 1.0 / n) }
}

pub fn image_morph_close_point_negate(pt : ImagemorphclosePoint) -> ImagemorphclosePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn image_morph_close_point_mid(a : ImagemorphclosePoint, b : ImagemorphclosePoint) -> ImagemorphclosePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn image_morph_close_point_lerp(a : ImagemorphclosePoint, b : ImagemorphclosePoint, t : Double) -> ImagemorphclosePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn image_morph_close_point_to_string(pt : ImagemorphclosePoint) -> String {
  "(" + image_morph_close_dbl(pt.x) + ", " + image_morph_close_dbl(pt.y) + ", " + image_morph_close_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct ImagemorphcloseSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_morph_close_make_series(vals : Array[Double], name : String) -> ImagemorphcloseSeries {
  { vals, name, meta: 0 }
}

pub fn image_morph_close_series_len(s : ImagemorphcloseSeries) -> Int { s.vals.length() }

pub fn image_morph_close_series_sum(s : ImagemorphcloseSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn image_morph_close_series_mean(s : ImagemorphcloseSeries) -> Double {
  let n = image_morph_close_series_len(s)
  if n == 0 { 0.0 } else { image_morph_close_series_sum(s) / n.to_double() }
}

pub fn image_morph_close_series_min(s : ImagemorphcloseSeries) -> Double {
  let n = image_morph_close_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn image_morph_close_series_max(s : ImagemorphcloseSeries) -> Double {
  let n = image_morph_close_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn image_morph_close_series_range(s : ImagemorphcloseSeries) -> Double {
  image_morph_close_series_max(s) - image_morph_close_series_min(s)
}

pub fn image_morph_close_series_var(s : ImagemorphcloseSeries) -> Double {
  let n = image_morph_close_series_len(s)
  if n == 0 { 0.0 } else {
    let m = image_morph_close_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn image_morph_close_series_std(s : ImagemorphcloseSeries) -> Double { image_morph_close_sqrt(image_morph_close_series_var(s)) }

pub fn image_morph_close_series_median(s : ImagemorphcloseSeries) -> Double {
  let n = image_morph_close_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = image_morph_close_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn image_morph_close_series_scale(s : ImagemorphcloseSeries, f : Double) -> ImagemorphcloseSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = image_morph_close_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn image_morph_close_series_add(a : ImagemorphcloseSeries, b : ImagemorphcloseSeries) -> ImagemorphcloseSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = image_morph_close_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn image_morph_close_series_sub(a : ImagemorphcloseSeries, b : ImagemorphcloseSeries) -> ImagemorphcloseSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = image_morph_close_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn image_morph_close_series_normalize(s : ImagemorphcloseSeries) -> ImagemorphcloseSeries {
  let mn = image_morph_close_series_min(s)
  let mx = image_morph_close_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = image_morph_close_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn image_morph_close_series_cumsum(s : ImagemorphcloseSeries) -> ImagemorphcloseSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = image_morph_close_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn image_morph_close_series_to_string(s : ImagemorphcloseSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + image_morph_close_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagemorphcloseMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_morph_close_make_matrix(rows : Int, cols : Int, val : Double) -> ImagemorphcloseMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn image_morph_close_matrix_identity(n : Int) -> ImagemorphcloseMatrix {
  let m = image_morph_close_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn image_morph_close_matrix_get(m : ImagemorphcloseMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn image_morph_close_matrix_transpose(m : ImagemorphcloseMatrix) -> ImagemorphcloseMatrix {
  let result = image_morph_close_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn image_morph_close_matrix_add(a : ImagemorphcloseMatrix, b : ImagemorphcloseMatrix) -> ImagemorphcloseMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = image_morph_close_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn image_morph_close_matrix_scale(m : ImagemorphcloseMatrix, s : Double) -> ImagemorphcloseMatrix {
  let result = image_morph_close_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn image_morph_close_matrix_multiply(a : ImagemorphcloseMatrix, b : ImagemorphcloseMatrix) -> ImagemorphcloseMatrix {
  if a.cols != b.rows { return image_morph_close_make_matrix(a.rows, b.cols, 0.0) }
  let result = image_morph_close_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn image_morph_close_matrix_trace(m : ImagemorphcloseMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn image_morph_close_matrix_det(m : ImagemorphcloseMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn image_morph_close_matrix_norm(m : ImagemorphcloseMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  image_morph_close_sqrt(sum)
}

pub fn image_morph_close_matrix_to_string(m : ImagemorphcloseMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + image_morph_close_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct ImagemorphcloseVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_morph_close_make_vector(comps : Array[Double]) -> ImagemorphcloseVector {
  { comps, dim: comps.length() }
}

pub fn image_morph_close_vector_zero(dim : Int) -> ImagemorphcloseVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn image_morph_close_vector_add(a : ImagemorphcloseVector, b : ImagemorphcloseVector) -> ImagemorphcloseVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = image_morph_close_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn image_morph_close_vector_sub(a : ImagemorphcloseVector, b : ImagemorphcloseVector) -> ImagemorphcloseVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = image_morph_close_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn image_morph_close_vector_scale(v : ImagemorphcloseVector, s : Double) -> ImagemorphcloseVector {
  let mut result = []
  for i in 0..<v.dim { result = image_morph_close_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn image_morph_close_vector_dot(a : ImagemorphcloseVector, b : ImagemorphcloseVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn image_morph_close_vector_norm(v : ImagemorphcloseVector) -> Double { image_morph_close_sqrt(image_morph_close_vector_dot(v, v)) }

pub fn image_morph_close_vector_normalize(v : ImagemorphcloseVector) -> ImagemorphcloseVector {
  let n = image_morph_close_vector_norm(v)
  if n < 0.0000001 { v } else { image_morph_close_vector_scale(v, 1.0 / n) }
}

pub fn image_morph_close_vector_dist(a : ImagemorphcloseVector, b : ImagemorphcloseVector) -> Double {
  image_morph_close_vector_norm(image_morph_close_vector_sub(a, b))
}

pub fn image_morph_close_vector_to_string(v : ImagemorphcloseVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + image_morph_close_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn image_morph_close_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn image_morph_close_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = image_morph_close_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn image_morph_close_std(data : Array[Double]) -> Double { image_morph_close_sqrt(image_morph_close_var(data)) }

pub fn image_morph_close_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = image_morph_close_mean(a); let mb = image_morph_close_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn image_morph_close_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = image_morph_close_std(a); let sb = image_morph_close_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { image_morph_close_cov(a, b) / (sa * sb) }
}

pub fn image_morph_close_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = image_morph_close_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn image_morph_close_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn image_morph_close_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn image_morph_close_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  image_morph_close_sqrt(image_morph_close_mse(pred, labels))
}

pub fn image_morph_close_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + image_morph_close_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn image_morph_close_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = image_morph_close_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn image_morph_close_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn image_morph_close_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn image_morph_close_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = image_morph_close_precision(pred, labels, pos); let r = image_morph_close_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn image_morph_close_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn image_morph_close_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = image_morph_close_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn image_morph_close_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn image_morph_close_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn image_morph_close_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = image_morph_close_gcd(a, b)
    (a / g) * b
  }
}

pub fn image_morph_close_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn image_morph_close_fibonacci(n : Int) -> Int {
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

pub fn image_morph_close_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = image_morph_close_min(data); let mx = image_morph_close_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn image_morph_close_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = image_morph_close_mean(data); let sd = image_morph_close_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn image_morph_close_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn image_morph_close_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn image_morph_close_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn image_morph_close_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn image_morph_close_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn image_morph_close_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn image_morph_close_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn image_morph_close_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn image_morph_close_dbl(x : Double) -> String {
  let i = if x >= 0.0 { image_morph_close_int(x) } else { -image_morph_close_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { image_morph_close_int(f * 1000000.0) } else { image_morph_close_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn image_morph_close_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn image_morph_close_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct ImagemorphcloseFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_close_frame_make(size : Int) -> ImagemorphcloseFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_close_frame_len(s : ImagemorphcloseFrame) -> Int { s.size }

pub fn image_morph_close_frame_get(s : ImagemorphcloseFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_close_frame_set(s : ImagemorphcloseFrame, i : Int, v : Double) -> ImagemorphcloseFrame {
  let result = image_morph_close_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_close_frame_sum(s : ImagemorphcloseFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_morph_close_frame_mean(s : ImagemorphcloseFrame) -> Double {
  if s.size == 0 { 0.0 } else { image_morph_close_frame_sum(s) / s.size.to_double() }
}

pub fn image_morph_close_frame_scale(s : ImagemorphcloseFrame, f : Double) -> ImagemorphcloseFrame {
  let result = image_morph_close_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_close_frame_add(a : ImagemorphcloseFrame, b : ImagemorphcloseFrame) -> ImagemorphcloseFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_close_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_close_frame_copy(s : ImagemorphcloseFrame) -> ImagemorphcloseFrame {
  let result = image_morph_close_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_close_frame_fill(s : ImagemorphcloseFrame, v : Double) -> ImagemorphcloseFrame {
  let result = image_morph_close_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_close_frame_min(s : ImagemorphcloseFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_close_frame_max(s : ImagemorphcloseFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_close_frame_to_string(s : ImagemorphcloseFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphcloseTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_close_table_make(size : Int) -> ImagemorphcloseTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_close_table_len(s : ImagemorphcloseTable) -> Int { s.size }

pub fn image_morph_close_table_get(s : ImagemorphcloseTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_close_table_set(s : ImagemorphcloseTable, i : Int, v : Double) -> ImagemorphcloseTable {
  let result = image_morph_close_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_close_table_sum(s : ImagemorphcloseTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_morph_close_table_mean(s : ImagemorphcloseTable) -> Double {
  if s.size == 0 { 0.0 } else { image_morph_close_table_sum(s) / s.size.to_double() }
}

pub fn image_morph_close_table_scale(s : ImagemorphcloseTable, f : Double) -> ImagemorphcloseTable {
  let result = image_morph_close_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_close_table_add(a : ImagemorphcloseTable, b : ImagemorphcloseTable) -> ImagemorphcloseTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_close_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_close_table_copy(s : ImagemorphcloseTable) -> ImagemorphcloseTable {
  let result = image_morph_close_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_close_table_fill(s : ImagemorphcloseTable, v : Double) -> ImagemorphcloseTable {
  let result = image_morph_close_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_close_table_min(s : ImagemorphcloseTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_close_table_max(s : ImagemorphcloseTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_close_table_to_string(s : ImagemorphcloseTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphcloseGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_close_graphn_make(size : Int) -> ImagemorphcloseGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_close_graphn_len(s : ImagemorphcloseGraphN) -> Int { s.size }

pub fn image_morph_close_graphn_get(s : ImagemorphcloseGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_close_graphn_set(s : ImagemorphcloseGraphN, i : Int, v : Double) -> ImagemorphcloseGraphN {
  let result = image_morph_close_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_close_graphn_sum(s : ImagemorphcloseGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_morph_close_graphn_mean(s : ImagemorphcloseGraphN) -> Double {
  if s.size == 0 { 0.0 } else { image_morph_close_graphn_sum(s) / s.size.to_double() }
}

pub fn image_morph_close_graphn_scale(s : ImagemorphcloseGraphN, f : Double) -> ImagemorphcloseGraphN {
  let result = image_morph_close_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_close_graphn_add(a : ImagemorphcloseGraphN, b : ImagemorphcloseGraphN) -> ImagemorphcloseGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_close_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_close_graphn_copy(s : ImagemorphcloseGraphN) -> ImagemorphcloseGraphN {
  let result = image_morph_close_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_close_graphn_fill(s : ImagemorphcloseGraphN, v : Double) -> ImagemorphcloseGraphN {
  let result = image_morph_close_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_close_graphn_min(s : ImagemorphcloseGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_close_graphn_max(s : ImagemorphcloseGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_close_graphn_to_string(s : ImagemorphcloseGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphcloseNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_close_node_make(size : Int) -> ImagemorphcloseNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_close_node_len(s : ImagemorphcloseNode) -> Int { s.size }

pub fn image_morph_close_node_get(s : ImagemorphcloseNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_close_node_set(s : ImagemorphcloseNode, i : Int, v : Double) -> ImagemorphcloseNode {
  let result = image_morph_close_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_close_node_sum(s : ImagemorphcloseNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_morph_close_node_mean(s : ImagemorphcloseNode) -> Double {
  if s.size == 0 { 0.0 } else { image_morph_close_node_sum(s) / s.size.to_double() }
}

pub fn image_morph_close_node_scale(s : ImagemorphcloseNode, f : Double) -> ImagemorphcloseNode {
  let result = image_morph_close_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_close_node_add(a : ImagemorphcloseNode, b : ImagemorphcloseNode) -> ImagemorphcloseNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_close_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_close_node_copy(s : ImagemorphcloseNode) -> ImagemorphcloseNode {
  let result = image_morph_close_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_close_node_fill(s : ImagemorphcloseNode, v : Double) -> ImagemorphcloseNode {
  let result = image_morph_close_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_close_node_min(s : ImagemorphcloseNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_close_node_max(s : ImagemorphcloseNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_close_node_to_string(s : ImagemorphcloseNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphcloseEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_close_edge_make(size : Int) -> ImagemorphcloseEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_close_edge_len(s : ImagemorphcloseEdge) -> Int { s.size }

pub fn image_morph_close_edge_get(s : ImagemorphcloseEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_close_edge_set(s : ImagemorphcloseEdge, i : Int, v : Double) -> ImagemorphcloseEdge {
  let result = image_morph_close_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_close_edge_sum(s : ImagemorphcloseEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_morph_close_edge_mean(s : ImagemorphcloseEdge) -> Double {
  if s.size == 0 { 0.0 } else { image_morph_close_edge_sum(s) / s.size.to_double() }
}

pub fn image_morph_close_edge_scale(s : ImagemorphcloseEdge, f : Double) -> ImagemorphcloseEdge {
  let result = image_morph_close_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_close_edge_add(a : ImagemorphcloseEdge, b : ImagemorphcloseEdge) -> ImagemorphcloseEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_close_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_close_edge_copy(s : ImagemorphcloseEdge) -> ImagemorphcloseEdge {
  let result = image_morph_close_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_close_edge_fill(s : ImagemorphcloseEdge, v : Double) -> ImagemorphcloseEdge {
  let result = image_morph_close_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_close_edge_min(s : ImagemorphcloseEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_close_edge_max(s : ImagemorphcloseEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_close_edge_to_string(s : ImagemorphcloseEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphclosePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_close_path_make(size : Int) -> ImagemorphclosePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_close_path_len(s : ImagemorphclosePath) -> Int { s.size }

pub fn image_morph_close_path_get(s : ImagemorphclosePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_close_path_set(s : ImagemorphclosePath, i : Int, v : Double) -> ImagemorphclosePath {
  let result = image_morph_close_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_close_path_sum(s : ImagemorphclosePath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_morph_close_path_mean(s : ImagemorphclosePath) -> Double {
  if s.size == 0 { 0.0 } else { image_morph_close_path_sum(s) / s.size.to_double() }
}

pub fn image_morph_close_path_scale(s : ImagemorphclosePath, f : Double) -> ImagemorphclosePath {
  let result = image_morph_close_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_close_path_add(a : ImagemorphclosePath, b : ImagemorphclosePath) -> ImagemorphclosePath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_close_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_close_path_copy(s : ImagemorphclosePath) -> ImagemorphclosePath {
  let result = image_morph_close_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_close_path_fill(s : ImagemorphclosePath, v : Double) -> ImagemorphclosePath {
  let result = image_morph_close_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_close_path_min(s : ImagemorphclosePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_close_path_max(s : ImagemorphclosePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_close_path_to_string(s : ImagemorphclosePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphcloseCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_close_cluster_make(size : Int) -> ImagemorphcloseCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_close_cluster_len(s : ImagemorphcloseCluster) -> Int { s.size }

pub fn image_morph_close_cluster_get(s : ImagemorphcloseCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_close_cluster_set(s : ImagemorphcloseCluster, i : Int, v : Double) -> ImagemorphcloseCluster {
  let result = image_morph_close_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_close_cluster_sum(s : ImagemorphcloseCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_morph_close_cluster_mean(s : ImagemorphcloseCluster) -> Double {
  if s.size == 0 { 0.0 } else { image_morph_close_cluster_sum(s) / s.size.to_double() }
}

pub fn image_morph_close_cluster_scale(s : ImagemorphcloseCluster, f : Double) -> ImagemorphcloseCluster {
  let result = image_morph_close_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_close_cluster_add(a : ImagemorphcloseCluster, b : ImagemorphcloseCluster) -> ImagemorphcloseCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_close_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_close_cluster_copy(s : ImagemorphcloseCluster) -> ImagemorphcloseCluster {
  let result = image_morph_close_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_close_cluster_fill(s : ImagemorphcloseCluster, v : Double) -> ImagemorphcloseCluster {
  let result = image_morph_close_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_close_cluster_min(s : ImagemorphcloseCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_close_cluster_max(s : ImagemorphcloseCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_close_cluster_to_string(s : ImagemorphcloseCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphcloseModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_close_model_make(size : Int) -> ImagemorphcloseModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_close_model_len(s : ImagemorphcloseModel) -> Int { s.size }

pub fn image_morph_close_model_get(s : ImagemorphcloseModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_close_model_set(s : ImagemorphcloseModel, i : Int, v : Double) -> ImagemorphcloseModel {
  let result = image_morph_close_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_close_model_sum(s : ImagemorphcloseModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_morph_close_model_mean(s : ImagemorphcloseModel) -> Double {
  if s.size == 0 { 0.0 } else { image_morph_close_model_sum(s) / s.size.to_double() }
}

pub fn image_morph_close_model_scale(s : ImagemorphcloseModel, f : Double) -> ImagemorphcloseModel {
  let result = image_morph_close_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_close_model_add(a : ImagemorphcloseModel, b : ImagemorphcloseModel) -> ImagemorphcloseModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_close_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_close_model_copy(s : ImagemorphcloseModel) -> ImagemorphcloseModel {
  let result = image_morph_close_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_close_model_fill(s : ImagemorphcloseModel, v : Double) -> ImagemorphcloseModel {
  let result = image_morph_close_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_close_model_min(s : ImagemorphcloseModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_close_model_max(s : ImagemorphcloseModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_close_model_to_string(s : ImagemorphcloseModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphcloseLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_close_layer_make(size : Int) -> ImagemorphcloseLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_close_layer_len(s : ImagemorphcloseLayer) -> Int { s.size }

pub fn image_morph_close_layer_get(s : ImagemorphcloseLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_close_layer_set(s : ImagemorphcloseLayer, i : Int, v : Double) -> ImagemorphcloseLayer {
  let result = image_morph_close_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_close_layer_sum(s : ImagemorphcloseLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_morph_close_layer_mean(s : ImagemorphcloseLayer) -> Double {
  if s.size == 0 { 0.0 } else { image_morph_close_layer_sum(s) / s.size.to_double() }
}

pub fn image_morph_close_layer_scale(s : ImagemorphcloseLayer, f : Double) -> ImagemorphcloseLayer {
  let result = image_morph_close_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_close_layer_add(a : ImagemorphcloseLayer, b : ImagemorphcloseLayer) -> ImagemorphcloseLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_close_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_close_layer_copy(s : ImagemorphcloseLayer) -> ImagemorphcloseLayer {
  let result = image_morph_close_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_close_layer_fill(s : ImagemorphcloseLayer, v : Double) -> ImagemorphcloseLayer {
  let result = image_morph_close_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_close_layer_min(s : ImagemorphcloseLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_close_layer_max(s : ImagemorphcloseLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_close_layer_to_string(s : ImagemorphcloseLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphcloseBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_close_buffer_make(size : Int) -> ImagemorphcloseBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_close_buffer_len(s : ImagemorphcloseBuffer) -> Int { s.size }

pub fn image_morph_close_buffer_get(s : ImagemorphcloseBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_close_buffer_set(s : ImagemorphcloseBuffer, i : Int, v : Double) -> ImagemorphcloseBuffer {
  let result = image_morph_close_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_close_buffer_sum(s : ImagemorphcloseBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_morph_close_buffer_mean(s : ImagemorphcloseBuffer) -> Double {
  if s.size == 0 { 0.0 } else { image_morph_close_buffer_sum(s) / s.size.to_double() }
}

pub fn image_morph_close_buffer_scale(s : ImagemorphcloseBuffer, f : Double) -> ImagemorphcloseBuffer {
  let result = image_morph_close_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_close_buffer_add(a : ImagemorphcloseBuffer, b : ImagemorphcloseBuffer) -> ImagemorphcloseBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_close_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_close_buffer_copy(s : ImagemorphcloseBuffer) -> ImagemorphcloseBuffer {
  let result = image_morph_close_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_close_buffer_fill(s : ImagemorphcloseBuffer, v : Double) -> ImagemorphcloseBuffer {
  let result = image_morph_close_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_close_buffer_min(s : ImagemorphcloseBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_close_buffer_max(s : ImagemorphcloseBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_close_buffer_to_string(s : ImagemorphcloseBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphcloseCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_close_cursor_make(size : Int) -> ImagemorphcloseCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_close_cursor_len(s : ImagemorphcloseCursor) -> Int { s.size }

pub fn image_morph_close_cursor_get(s : ImagemorphcloseCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_close_cursor_set(s : ImagemorphcloseCursor, i : Int, v : Double) -> ImagemorphcloseCursor {
  let result = image_morph_close_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_close_cursor_sum(s : ImagemorphcloseCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_morph_close_cursor_mean(s : ImagemorphcloseCursor) -> Double {
  if s.size == 0 { 0.0 } else { image_morph_close_cursor_sum(s) / s.size.to_double() }
}

pub fn image_morph_close_cursor_scale(s : ImagemorphcloseCursor, f : Double) -> ImagemorphcloseCursor {
  let result = image_morph_close_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_close_cursor_add(a : ImagemorphcloseCursor, b : ImagemorphcloseCursor) -> ImagemorphcloseCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_close_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_close_cursor_copy(s : ImagemorphcloseCursor) -> ImagemorphcloseCursor {
  let result = image_morph_close_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_close_cursor_fill(s : ImagemorphcloseCursor, v : Double) -> ImagemorphcloseCursor {
  let result = image_morph_close_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_close_cursor_min(s : ImagemorphcloseCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_close_cursor_max(s : ImagemorphcloseCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_close_cursor_to_string(s : ImagemorphcloseCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphcloseView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_close_view_make(size : Int) -> ImagemorphcloseView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_close_view_len(s : ImagemorphcloseView) -> Int { s.size }

pub fn image_morph_close_view_get(s : ImagemorphcloseView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_close_view_set(s : ImagemorphcloseView, i : Int, v : Double) -> ImagemorphcloseView {
  let result = image_morph_close_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_close_view_sum(s : ImagemorphcloseView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_morph_close_view_mean(s : ImagemorphcloseView) -> Double {
  if s.size == 0 { 0.0 } else { image_morph_close_view_sum(s) / s.size.to_double() }
}

pub fn image_morph_close_view_scale(s : ImagemorphcloseView, f : Double) -> ImagemorphcloseView {
  let result = image_morph_close_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_close_view_add(a : ImagemorphcloseView, b : ImagemorphcloseView) -> ImagemorphcloseView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_close_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_close_view_copy(s : ImagemorphcloseView) -> ImagemorphcloseView {
  let result = image_morph_close_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_close_view_fill(s : ImagemorphcloseView, v : Double) -> ImagemorphcloseView {
  let result = image_morph_close_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_close_view_min(s : ImagemorphcloseView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_close_view_max(s : ImagemorphcloseView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_close_view_to_string(s : ImagemorphcloseView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphcloseRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_close_range_make(size : Int) -> ImagemorphcloseRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_close_range_len(s : ImagemorphcloseRange) -> Int { s.size }

pub fn image_morph_close_range_get(s : ImagemorphcloseRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_close_range_set(s : ImagemorphcloseRange, i : Int, v : Double) -> ImagemorphcloseRange {
  let result = image_morph_close_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_close_range_sum(s : ImagemorphcloseRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_morph_close_range_mean(s : ImagemorphcloseRange) -> Double {
  if s.size == 0 { 0.0 } else { image_morph_close_range_sum(s) / s.size.to_double() }
}

pub fn image_morph_close_range_scale(s : ImagemorphcloseRange, f : Double) -> ImagemorphcloseRange {
  let result = image_morph_close_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_close_range_add(a : ImagemorphcloseRange, b : ImagemorphcloseRange) -> ImagemorphcloseRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_close_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_close_range_copy(s : ImagemorphcloseRange) -> ImagemorphcloseRange {
  let result = image_morph_close_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_close_range_fill(s : ImagemorphcloseRange, v : Double) -> ImagemorphcloseRange {
  let result = image_morph_close_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_close_range_min(s : ImagemorphcloseRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_close_range_max(s : ImagemorphcloseRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_close_range_to_string(s : ImagemorphcloseRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphcloseSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_close_slice_make(size : Int) -> ImagemorphcloseSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_close_slice_len(s : ImagemorphcloseSlice) -> Int { s.size }

pub fn image_morph_close_slice_get(s : ImagemorphcloseSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_close_slice_set(s : ImagemorphcloseSlice, i : Int, v : Double) -> ImagemorphcloseSlice {
  let result = image_morph_close_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_close_slice_sum(s : ImagemorphcloseSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_morph_close_slice_mean(s : ImagemorphcloseSlice) -> Double {
  if s.size == 0 { 0.0 } else { image_morph_close_slice_sum(s) / s.size.to_double() }
}

pub fn image_morph_close_slice_scale(s : ImagemorphcloseSlice, f : Double) -> ImagemorphcloseSlice {
  let result = image_morph_close_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_close_slice_add(a : ImagemorphcloseSlice, b : ImagemorphcloseSlice) -> ImagemorphcloseSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_close_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_close_slice_copy(s : ImagemorphcloseSlice) -> ImagemorphcloseSlice {
  let result = image_morph_close_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_close_slice_fill(s : ImagemorphcloseSlice, v : Double) -> ImagemorphcloseSlice {
  let result = image_morph_close_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_close_slice_min(s : ImagemorphcloseSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_close_slice_max(s : ImagemorphcloseSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_close_slice_to_string(s : ImagemorphcloseSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn image_morph_close_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_morph_close_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_morph_close_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_morph_close_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_morph_close_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_morph_close_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_morph_close_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_morph_close_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_morph_close_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_morph_close_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_morph_close_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_morph_close_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_morph_close_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_morph_close_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_morph_close_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_morph_close_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_morph_close_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_morph_close_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_morph_close_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_morph_close_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_morph_close_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_morph_close_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_morph_close_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_morph_close_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_morph_close_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}


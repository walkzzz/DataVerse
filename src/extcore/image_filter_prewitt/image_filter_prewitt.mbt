///===
/// extcore/image_filter_prewitt

pub(all) struct ImagefilterprewittPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_filter_prewitt_make_point(x : Double, y : Double) -> ImagefilterprewittPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_filter_prewitt_make_point3(x : Double, y : Double, z : Double) -> ImagefilterprewittPoint {
  { x, y, z, label: 0 }
}

pub fn image_filter_prewitt_point_x(pt : ImagefilterprewittPoint) -> Double { pt.x }

pub fn image_filter_prewitt_point_y(pt : ImagefilterprewittPoint) -> Double { pt.y }

pub fn image_filter_prewitt_point_z(pt : ImagefilterprewittPoint) -> Double { pt.z }

pub fn image_filter_prewitt_point_label(pt : ImagefilterprewittPoint) -> Int { pt.label }

pub fn image_filter_prewitt_point_dist(a : ImagefilterprewittPoint, b : ImagefilterprewittPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  image_filter_prewitt_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn image_filter_prewitt_point_add(a : ImagefilterprewittPoint, b : ImagefilterprewittPoint) -> ImagefilterprewittPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn image_filter_prewitt_point_sub(a : ImagefilterprewittPoint, b : ImagefilterprewittPoint) -> ImagefilterprewittPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn image_filter_prewitt_point_scale(pt : ImagefilterprewittPoint, s : Double) -> ImagefilterprewittPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn image_filter_prewitt_point_dot(a : ImagefilterprewittPoint, b : ImagefilterprewittPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn image_filter_prewitt_point_cross(a : ImagefilterprewittPoint, b : ImagefilterprewittPoint) -> ImagefilterprewittPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn image_filter_prewitt_point_norm(pt : ImagefilterprewittPoint) -> Double {
  image_filter_prewitt_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn image_filter_prewitt_point_normalize(pt : ImagefilterprewittPoint) -> ImagefilterprewittPoint {
  let n = image_filter_prewitt_point_norm(pt)
  if n < 0.0000001 { pt } else { image_filter_prewitt_point_scale(pt, 1.0 / n) }
}

pub fn image_filter_prewitt_point_negate(pt : ImagefilterprewittPoint) -> ImagefilterprewittPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn image_filter_prewitt_point_mid(a : ImagefilterprewittPoint, b : ImagefilterprewittPoint) -> ImagefilterprewittPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn image_filter_prewitt_point_lerp(a : ImagefilterprewittPoint, b : ImagefilterprewittPoint, t : Double) -> ImagefilterprewittPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn image_filter_prewitt_point_to_string(pt : ImagefilterprewittPoint) -> String {
  "(" + image_filter_prewitt_dbl(pt.x) + ", " + image_filter_prewitt_dbl(pt.y) + ", " + image_filter_prewitt_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct ImagefilterprewittSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_filter_prewitt_make_series(vals : Array[Double], name : String) -> ImagefilterprewittSeries {
  { vals, name, meta: 0 }
}

pub fn image_filter_prewitt_series_len(s : ImagefilterprewittSeries) -> Int { s.vals.length() }

pub fn image_filter_prewitt_series_sum(s : ImagefilterprewittSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn image_filter_prewitt_series_mean(s : ImagefilterprewittSeries) -> Double {
  let n = image_filter_prewitt_series_len(s)
  if n == 0 { 0.0 } else { image_filter_prewitt_series_sum(s) / n.to_double() }
}

pub fn image_filter_prewitt_series_min(s : ImagefilterprewittSeries) -> Double {
  let n = image_filter_prewitt_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn image_filter_prewitt_series_max(s : ImagefilterprewittSeries) -> Double {
  let n = image_filter_prewitt_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn image_filter_prewitt_series_range(s : ImagefilterprewittSeries) -> Double {
  image_filter_prewitt_series_max(s) - image_filter_prewitt_series_min(s)
}

pub fn image_filter_prewitt_series_var(s : ImagefilterprewittSeries) -> Double {
  let n = image_filter_prewitt_series_len(s)
  if n == 0 { 0.0 } else {
    let m = image_filter_prewitt_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn image_filter_prewitt_series_std(s : ImagefilterprewittSeries) -> Double { image_filter_prewitt_sqrt(image_filter_prewitt_series_var(s)) }

pub fn image_filter_prewitt_series_median(s : ImagefilterprewittSeries) -> Double {
  let n = image_filter_prewitt_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = image_filter_prewitt_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn image_filter_prewitt_series_scale(s : ImagefilterprewittSeries, f : Double) -> ImagefilterprewittSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = image_filter_prewitt_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn image_filter_prewitt_series_add(a : ImagefilterprewittSeries, b : ImagefilterprewittSeries) -> ImagefilterprewittSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = image_filter_prewitt_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn image_filter_prewitt_series_sub(a : ImagefilterprewittSeries, b : ImagefilterprewittSeries) -> ImagefilterprewittSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = image_filter_prewitt_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn image_filter_prewitt_series_normalize(s : ImagefilterprewittSeries) -> ImagefilterprewittSeries {
  let mn = image_filter_prewitt_series_min(s)
  let mx = image_filter_prewitt_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = image_filter_prewitt_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn image_filter_prewitt_series_cumsum(s : ImagefilterprewittSeries) -> ImagefilterprewittSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = image_filter_prewitt_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn image_filter_prewitt_series_to_string(s : ImagefilterprewittSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + image_filter_prewitt_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagefilterprewittMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_filter_prewitt_make_matrix(rows : Int, cols : Int, val : Double) -> ImagefilterprewittMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn image_filter_prewitt_matrix_identity(n : Int) -> ImagefilterprewittMatrix {
  let m = image_filter_prewitt_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn image_filter_prewitt_matrix_get(m : ImagefilterprewittMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn image_filter_prewitt_matrix_transpose(m : ImagefilterprewittMatrix) -> ImagefilterprewittMatrix {
  let result = image_filter_prewitt_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn image_filter_prewitt_matrix_add(a : ImagefilterprewittMatrix, b : ImagefilterprewittMatrix) -> ImagefilterprewittMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = image_filter_prewitt_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn image_filter_prewitt_matrix_scale(m : ImagefilterprewittMatrix, s : Double) -> ImagefilterprewittMatrix {
  let result = image_filter_prewitt_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn image_filter_prewitt_matrix_multiply(a : ImagefilterprewittMatrix, b : ImagefilterprewittMatrix) -> ImagefilterprewittMatrix {
  if a.cols != b.rows { return image_filter_prewitt_make_matrix(a.rows, b.cols, 0.0) }
  let result = image_filter_prewitt_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn image_filter_prewitt_matrix_trace(m : ImagefilterprewittMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn image_filter_prewitt_matrix_det(m : ImagefilterprewittMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn image_filter_prewitt_matrix_norm(m : ImagefilterprewittMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  image_filter_prewitt_sqrt(sum)
}

pub fn image_filter_prewitt_matrix_to_string(m : ImagefilterprewittMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + image_filter_prewitt_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct ImagefilterprewittVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_filter_prewitt_make_vector(comps : Array[Double]) -> ImagefilterprewittVector {
  { comps, dim: comps.length() }
}

pub fn image_filter_prewitt_vector_zero(dim : Int) -> ImagefilterprewittVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn image_filter_prewitt_vector_add(a : ImagefilterprewittVector, b : ImagefilterprewittVector) -> ImagefilterprewittVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = image_filter_prewitt_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn image_filter_prewitt_vector_sub(a : ImagefilterprewittVector, b : ImagefilterprewittVector) -> ImagefilterprewittVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = image_filter_prewitt_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn image_filter_prewitt_vector_scale(v : ImagefilterprewittVector, s : Double) -> ImagefilterprewittVector {
  let mut result = []
  for i in 0..<v.dim { result = image_filter_prewitt_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn image_filter_prewitt_vector_dot(a : ImagefilterprewittVector, b : ImagefilterprewittVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn image_filter_prewitt_vector_norm(v : ImagefilterprewittVector) -> Double { image_filter_prewitt_sqrt(image_filter_prewitt_vector_dot(v, v)) }

pub fn image_filter_prewitt_vector_normalize(v : ImagefilterprewittVector) -> ImagefilterprewittVector {
  let n = image_filter_prewitt_vector_norm(v)
  if n < 0.0000001 { v } else { image_filter_prewitt_vector_scale(v, 1.0 / n) }
}

pub fn image_filter_prewitt_vector_dist(a : ImagefilterprewittVector, b : ImagefilterprewittVector) -> Double {
  image_filter_prewitt_vector_norm(image_filter_prewitt_vector_sub(a, b))
}

pub fn image_filter_prewitt_vector_to_string(v : ImagefilterprewittVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + image_filter_prewitt_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn image_filter_prewitt_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn image_filter_prewitt_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = image_filter_prewitt_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn image_filter_prewitt_std(data : Array[Double]) -> Double { image_filter_prewitt_sqrt(image_filter_prewitt_var(data)) }

pub fn image_filter_prewitt_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = image_filter_prewitt_mean(a); let mb = image_filter_prewitt_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn image_filter_prewitt_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = image_filter_prewitt_std(a); let sb = image_filter_prewitt_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { image_filter_prewitt_cov(a, b) / (sa * sb) }
}

pub fn image_filter_prewitt_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = image_filter_prewitt_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn image_filter_prewitt_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn image_filter_prewitt_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn image_filter_prewitt_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  image_filter_prewitt_sqrt(image_filter_prewitt_mse(pred, labels))
}

pub fn image_filter_prewitt_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + image_filter_prewitt_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn image_filter_prewitt_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = image_filter_prewitt_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn image_filter_prewitt_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn image_filter_prewitt_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn image_filter_prewitt_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = image_filter_prewitt_precision(pred, labels, pos); let r = image_filter_prewitt_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn image_filter_prewitt_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn image_filter_prewitt_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = image_filter_prewitt_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn image_filter_prewitt_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn image_filter_prewitt_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn image_filter_prewitt_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = image_filter_prewitt_gcd(a, b)
    (a / g) * b
  }
}

pub fn image_filter_prewitt_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn image_filter_prewitt_fibonacci(n : Int) -> Int {
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

pub fn image_filter_prewitt_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = image_filter_prewitt_min(data); let mx = image_filter_prewitt_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn image_filter_prewitt_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = image_filter_prewitt_mean(data); let sd = image_filter_prewitt_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn image_filter_prewitt_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn image_filter_prewitt_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn image_filter_prewitt_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn image_filter_prewitt_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn image_filter_prewitt_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn image_filter_prewitt_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn image_filter_prewitt_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn image_filter_prewitt_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn image_filter_prewitt_dbl(x : Double) -> String {
  let i = if x >= 0.0 { image_filter_prewitt_int(x) } else { -image_filter_prewitt_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { image_filter_prewitt_int(f * 1000000.0) } else { image_filter_prewitt_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn image_filter_prewitt_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn image_filter_prewitt_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct ImagefilterprewittFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_prewitt_frame_make(size : Int) -> ImagefilterprewittFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_prewitt_frame_len(s : ImagefilterprewittFrame) -> Int { s.size }

pub fn image_filter_prewitt_frame_get(s : ImagefilterprewittFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_prewitt_frame_set(s : ImagefilterprewittFrame, i : Int, v : Double) -> ImagefilterprewittFrame {
  let result = image_filter_prewitt_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_prewitt_frame_sum(s : ImagefilterprewittFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_filter_prewitt_frame_mean(s : ImagefilterprewittFrame) -> Double {
  if s.size == 0 { 0.0 } else { image_filter_prewitt_frame_sum(s) / s.size.to_double() }
}

pub fn image_filter_prewitt_frame_scale(s : ImagefilterprewittFrame, f : Double) -> ImagefilterprewittFrame {
  let result = image_filter_prewitt_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_prewitt_frame_add(a : ImagefilterprewittFrame, b : ImagefilterprewittFrame) -> ImagefilterprewittFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_prewitt_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_prewitt_frame_copy(s : ImagefilterprewittFrame) -> ImagefilterprewittFrame {
  let result = image_filter_prewitt_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_prewitt_frame_fill(s : ImagefilterprewittFrame, v : Double) -> ImagefilterprewittFrame {
  let result = image_filter_prewitt_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_prewitt_frame_min(s : ImagefilterprewittFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_prewitt_frame_max(s : ImagefilterprewittFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_prewitt_frame_to_string(s : ImagefilterprewittFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefilterprewittTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_prewitt_table_make(size : Int) -> ImagefilterprewittTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_prewitt_table_len(s : ImagefilterprewittTable) -> Int { s.size }

pub fn image_filter_prewitt_table_get(s : ImagefilterprewittTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_prewitt_table_set(s : ImagefilterprewittTable, i : Int, v : Double) -> ImagefilterprewittTable {
  let result = image_filter_prewitt_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_prewitt_table_sum(s : ImagefilterprewittTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_filter_prewitt_table_mean(s : ImagefilterprewittTable) -> Double {
  if s.size == 0 { 0.0 } else { image_filter_prewitt_table_sum(s) / s.size.to_double() }
}

pub fn image_filter_prewitt_table_scale(s : ImagefilterprewittTable, f : Double) -> ImagefilterprewittTable {
  let result = image_filter_prewitt_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_prewitt_table_add(a : ImagefilterprewittTable, b : ImagefilterprewittTable) -> ImagefilterprewittTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_prewitt_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_prewitt_table_copy(s : ImagefilterprewittTable) -> ImagefilterprewittTable {
  let result = image_filter_prewitt_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_prewitt_table_fill(s : ImagefilterprewittTable, v : Double) -> ImagefilterprewittTable {
  let result = image_filter_prewitt_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_prewitt_table_min(s : ImagefilterprewittTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_prewitt_table_max(s : ImagefilterprewittTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_prewitt_table_to_string(s : ImagefilterprewittTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefilterprewittGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_prewitt_graphn_make(size : Int) -> ImagefilterprewittGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_prewitt_graphn_len(s : ImagefilterprewittGraphN) -> Int { s.size }

pub fn image_filter_prewitt_graphn_get(s : ImagefilterprewittGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_prewitt_graphn_set(s : ImagefilterprewittGraphN, i : Int, v : Double) -> ImagefilterprewittGraphN {
  let result = image_filter_prewitt_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_prewitt_graphn_sum(s : ImagefilterprewittGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_filter_prewitt_graphn_mean(s : ImagefilterprewittGraphN) -> Double {
  if s.size == 0 { 0.0 } else { image_filter_prewitt_graphn_sum(s) / s.size.to_double() }
}

pub fn image_filter_prewitt_graphn_scale(s : ImagefilterprewittGraphN, f : Double) -> ImagefilterprewittGraphN {
  let result = image_filter_prewitt_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_prewitt_graphn_add(a : ImagefilterprewittGraphN, b : ImagefilterprewittGraphN) -> ImagefilterprewittGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_prewitt_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_prewitt_graphn_copy(s : ImagefilterprewittGraphN) -> ImagefilterprewittGraphN {
  let result = image_filter_prewitt_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_prewitt_graphn_fill(s : ImagefilterprewittGraphN, v : Double) -> ImagefilterprewittGraphN {
  let result = image_filter_prewitt_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_prewitt_graphn_min(s : ImagefilterprewittGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_prewitt_graphn_max(s : ImagefilterprewittGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_prewitt_graphn_to_string(s : ImagefilterprewittGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefilterprewittNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_prewitt_node_make(size : Int) -> ImagefilterprewittNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_prewitt_node_len(s : ImagefilterprewittNode) -> Int { s.size }

pub fn image_filter_prewitt_node_get(s : ImagefilterprewittNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_prewitt_node_set(s : ImagefilterprewittNode, i : Int, v : Double) -> ImagefilterprewittNode {
  let result = image_filter_prewitt_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_prewitt_node_sum(s : ImagefilterprewittNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_filter_prewitt_node_mean(s : ImagefilterprewittNode) -> Double {
  if s.size == 0 { 0.0 } else { image_filter_prewitt_node_sum(s) / s.size.to_double() }
}

pub fn image_filter_prewitt_node_scale(s : ImagefilterprewittNode, f : Double) -> ImagefilterprewittNode {
  let result = image_filter_prewitt_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_prewitt_node_add(a : ImagefilterprewittNode, b : ImagefilterprewittNode) -> ImagefilterprewittNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_prewitt_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_prewitt_node_copy(s : ImagefilterprewittNode) -> ImagefilterprewittNode {
  let result = image_filter_prewitt_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_prewitt_node_fill(s : ImagefilterprewittNode, v : Double) -> ImagefilterprewittNode {
  let result = image_filter_prewitt_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_prewitt_node_min(s : ImagefilterprewittNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_prewitt_node_max(s : ImagefilterprewittNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_prewitt_node_to_string(s : ImagefilterprewittNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefilterprewittEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_prewitt_edge_make(size : Int) -> ImagefilterprewittEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_prewitt_edge_len(s : ImagefilterprewittEdge) -> Int { s.size }

pub fn image_filter_prewitt_edge_get(s : ImagefilterprewittEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_prewitt_edge_set(s : ImagefilterprewittEdge, i : Int, v : Double) -> ImagefilterprewittEdge {
  let result = image_filter_prewitt_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_prewitt_edge_sum(s : ImagefilterprewittEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_filter_prewitt_edge_mean(s : ImagefilterprewittEdge) -> Double {
  if s.size == 0 { 0.0 } else { image_filter_prewitt_edge_sum(s) / s.size.to_double() }
}

pub fn image_filter_prewitt_edge_scale(s : ImagefilterprewittEdge, f : Double) -> ImagefilterprewittEdge {
  let result = image_filter_prewitt_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_prewitt_edge_add(a : ImagefilterprewittEdge, b : ImagefilterprewittEdge) -> ImagefilterprewittEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_prewitt_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_prewitt_edge_copy(s : ImagefilterprewittEdge) -> ImagefilterprewittEdge {
  let result = image_filter_prewitt_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_prewitt_edge_fill(s : ImagefilterprewittEdge, v : Double) -> ImagefilterprewittEdge {
  let result = image_filter_prewitt_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_prewitt_edge_min(s : ImagefilterprewittEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_prewitt_edge_max(s : ImagefilterprewittEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_prewitt_edge_to_string(s : ImagefilterprewittEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefilterprewittPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_prewitt_path_make(size : Int) -> ImagefilterprewittPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_prewitt_path_len(s : ImagefilterprewittPath) -> Int { s.size }

pub fn image_filter_prewitt_path_get(s : ImagefilterprewittPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_prewitt_path_set(s : ImagefilterprewittPath, i : Int, v : Double) -> ImagefilterprewittPath {
  let result = image_filter_prewitt_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_prewitt_path_sum(s : ImagefilterprewittPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_filter_prewitt_path_mean(s : ImagefilterprewittPath) -> Double {
  if s.size == 0 { 0.0 } else { image_filter_prewitt_path_sum(s) / s.size.to_double() }
}

pub fn image_filter_prewitt_path_scale(s : ImagefilterprewittPath, f : Double) -> ImagefilterprewittPath {
  let result = image_filter_prewitt_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_prewitt_path_add(a : ImagefilterprewittPath, b : ImagefilterprewittPath) -> ImagefilterprewittPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_prewitt_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_prewitt_path_copy(s : ImagefilterprewittPath) -> ImagefilterprewittPath {
  let result = image_filter_prewitt_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_prewitt_path_fill(s : ImagefilterprewittPath, v : Double) -> ImagefilterprewittPath {
  let result = image_filter_prewitt_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_prewitt_path_min(s : ImagefilterprewittPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_prewitt_path_max(s : ImagefilterprewittPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_prewitt_path_to_string(s : ImagefilterprewittPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefilterprewittCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_prewitt_cluster_make(size : Int) -> ImagefilterprewittCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_prewitt_cluster_len(s : ImagefilterprewittCluster) -> Int { s.size }

pub fn image_filter_prewitt_cluster_get(s : ImagefilterprewittCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_prewitt_cluster_set(s : ImagefilterprewittCluster, i : Int, v : Double) -> ImagefilterprewittCluster {
  let result = image_filter_prewitt_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_prewitt_cluster_sum(s : ImagefilterprewittCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_filter_prewitt_cluster_mean(s : ImagefilterprewittCluster) -> Double {
  if s.size == 0 { 0.0 } else { image_filter_prewitt_cluster_sum(s) / s.size.to_double() }
}

pub fn image_filter_prewitt_cluster_scale(s : ImagefilterprewittCluster, f : Double) -> ImagefilterprewittCluster {
  let result = image_filter_prewitt_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_prewitt_cluster_add(a : ImagefilterprewittCluster, b : ImagefilterprewittCluster) -> ImagefilterprewittCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_prewitt_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_prewitt_cluster_copy(s : ImagefilterprewittCluster) -> ImagefilterprewittCluster {
  let result = image_filter_prewitt_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_prewitt_cluster_fill(s : ImagefilterprewittCluster, v : Double) -> ImagefilterprewittCluster {
  let result = image_filter_prewitt_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_prewitt_cluster_min(s : ImagefilterprewittCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_prewitt_cluster_max(s : ImagefilterprewittCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_prewitt_cluster_to_string(s : ImagefilterprewittCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefilterprewittModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_prewitt_model_make(size : Int) -> ImagefilterprewittModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_prewitt_model_len(s : ImagefilterprewittModel) -> Int { s.size }

pub fn image_filter_prewitt_model_get(s : ImagefilterprewittModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_prewitt_model_set(s : ImagefilterprewittModel, i : Int, v : Double) -> ImagefilterprewittModel {
  let result = image_filter_prewitt_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_prewitt_model_sum(s : ImagefilterprewittModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_filter_prewitt_model_mean(s : ImagefilterprewittModel) -> Double {
  if s.size == 0 { 0.0 } else { image_filter_prewitt_model_sum(s) / s.size.to_double() }
}

pub fn image_filter_prewitt_model_scale(s : ImagefilterprewittModel, f : Double) -> ImagefilterprewittModel {
  let result = image_filter_prewitt_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_prewitt_model_add(a : ImagefilterprewittModel, b : ImagefilterprewittModel) -> ImagefilterprewittModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_prewitt_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_prewitt_model_copy(s : ImagefilterprewittModel) -> ImagefilterprewittModel {
  let result = image_filter_prewitt_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_prewitt_model_fill(s : ImagefilterprewittModel, v : Double) -> ImagefilterprewittModel {
  let result = image_filter_prewitt_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_prewitt_model_min(s : ImagefilterprewittModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_prewitt_model_max(s : ImagefilterprewittModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_prewitt_model_to_string(s : ImagefilterprewittModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefilterprewittLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_prewitt_layer_make(size : Int) -> ImagefilterprewittLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_prewitt_layer_len(s : ImagefilterprewittLayer) -> Int { s.size }

pub fn image_filter_prewitt_layer_get(s : ImagefilterprewittLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_prewitt_layer_set(s : ImagefilterprewittLayer, i : Int, v : Double) -> ImagefilterprewittLayer {
  let result = image_filter_prewitt_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_prewitt_layer_sum(s : ImagefilterprewittLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_filter_prewitt_layer_mean(s : ImagefilterprewittLayer) -> Double {
  if s.size == 0 { 0.0 } else { image_filter_prewitt_layer_sum(s) / s.size.to_double() }
}

pub fn image_filter_prewitt_layer_scale(s : ImagefilterprewittLayer, f : Double) -> ImagefilterprewittLayer {
  let result = image_filter_prewitt_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_prewitt_layer_add(a : ImagefilterprewittLayer, b : ImagefilterprewittLayer) -> ImagefilterprewittLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_prewitt_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_prewitt_layer_copy(s : ImagefilterprewittLayer) -> ImagefilterprewittLayer {
  let result = image_filter_prewitt_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_prewitt_layer_fill(s : ImagefilterprewittLayer, v : Double) -> ImagefilterprewittLayer {
  let result = image_filter_prewitt_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_prewitt_layer_min(s : ImagefilterprewittLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_prewitt_layer_max(s : ImagefilterprewittLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_prewitt_layer_to_string(s : ImagefilterprewittLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefilterprewittBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_prewitt_buffer_make(size : Int) -> ImagefilterprewittBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_prewitt_buffer_len(s : ImagefilterprewittBuffer) -> Int { s.size }

pub fn image_filter_prewitt_buffer_get(s : ImagefilterprewittBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_prewitt_buffer_set(s : ImagefilterprewittBuffer, i : Int, v : Double) -> ImagefilterprewittBuffer {
  let result = image_filter_prewitt_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_prewitt_buffer_sum(s : ImagefilterprewittBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_filter_prewitt_buffer_mean(s : ImagefilterprewittBuffer) -> Double {
  if s.size == 0 { 0.0 } else { image_filter_prewitt_buffer_sum(s) / s.size.to_double() }
}

pub fn image_filter_prewitt_buffer_scale(s : ImagefilterprewittBuffer, f : Double) -> ImagefilterprewittBuffer {
  let result = image_filter_prewitt_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_prewitt_buffer_add(a : ImagefilterprewittBuffer, b : ImagefilterprewittBuffer) -> ImagefilterprewittBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_prewitt_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_prewitt_buffer_copy(s : ImagefilterprewittBuffer) -> ImagefilterprewittBuffer {
  let result = image_filter_prewitt_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_prewitt_buffer_fill(s : ImagefilterprewittBuffer, v : Double) -> ImagefilterprewittBuffer {
  let result = image_filter_prewitt_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_prewitt_buffer_min(s : ImagefilterprewittBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_prewitt_buffer_max(s : ImagefilterprewittBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_prewitt_buffer_to_string(s : ImagefilterprewittBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefilterprewittCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_prewitt_cursor_make(size : Int) -> ImagefilterprewittCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_prewitt_cursor_len(s : ImagefilterprewittCursor) -> Int { s.size }

pub fn image_filter_prewitt_cursor_get(s : ImagefilterprewittCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_prewitt_cursor_set(s : ImagefilterprewittCursor, i : Int, v : Double) -> ImagefilterprewittCursor {
  let result = image_filter_prewitt_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_prewitt_cursor_sum(s : ImagefilterprewittCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_filter_prewitt_cursor_mean(s : ImagefilterprewittCursor) -> Double {
  if s.size == 0 { 0.0 } else { image_filter_prewitt_cursor_sum(s) / s.size.to_double() }
}

pub fn image_filter_prewitt_cursor_scale(s : ImagefilterprewittCursor, f : Double) -> ImagefilterprewittCursor {
  let result = image_filter_prewitt_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_prewitt_cursor_add(a : ImagefilterprewittCursor, b : ImagefilterprewittCursor) -> ImagefilterprewittCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_prewitt_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_prewitt_cursor_copy(s : ImagefilterprewittCursor) -> ImagefilterprewittCursor {
  let result = image_filter_prewitt_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_prewitt_cursor_fill(s : ImagefilterprewittCursor, v : Double) -> ImagefilterprewittCursor {
  let result = image_filter_prewitt_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_prewitt_cursor_min(s : ImagefilterprewittCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_prewitt_cursor_max(s : ImagefilterprewittCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_prewitt_cursor_to_string(s : ImagefilterprewittCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefilterprewittView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_prewitt_view_make(size : Int) -> ImagefilterprewittView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_prewitt_view_len(s : ImagefilterprewittView) -> Int { s.size }

pub fn image_filter_prewitt_view_get(s : ImagefilterprewittView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_prewitt_view_set(s : ImagefilterprewittView, i : Int, v : Double) -> ImagefilterprewittView {
  let result = image_filter_prewitt_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_prewitt_view_sum(s : ImagefilterprewittView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_filter_prewitt_view_mean(s : ImagefilterprewittView) -> Double {
  if s.size == 0 { 0.0 } else { image_filter_prewitt_view_sum(s) / s.size.to_double() }
}

pub fn image_filter_prewitt_view_scale(s : ImagefilterprewittView, f : Double) -> ImagefilterprewittView {
  let result = image_filter_prewitt_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_prewitt_view_add(a : ImagefilterprewittView, b : ImagefilterprewittView) -> ImagefilterprewittView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_prewitt_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_prewitt_view_copy(s : ImagefilterprewittView) -> ImagefilterprewittView {
  let result = image_filter_prewitt_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_prewitt_view_fill(s : ImagefilterprewittView, v : Double) -> ImagefilterprewittView {
  let result = image_filter_prewitt_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_prewitt_view_min(s : ImagefilterprewittView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_prewitt_view_max(s : ImagefilterprewittView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_prewitt_view_to_string(s : ImagefilterprewittView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefilterprewittRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_prewitt_range_make(size : Int) -> ImagefilterprewittRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_prewitt_range_len(s : ImagefilterprewittRange) -> Int { s.size }

pub fn image_filter_prewitt_range_get(s : ImagefilterprewittRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_prewitt_range_set(s : ImagefilterprewittRange, i : Int, v : Double) -> ImagefilterprewittRange {
  let result = image_filter_prewitt_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_prewitt_range_sum(s : ImagefilterprewittRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_filter_prewitt_range_mean(s : ImagefilterprewittRange) -> Double {
  if s.size == 0 { 0.0 } else { image_filter_prewitt_range_sum(s) / s.size.to_double() }
}

pub fn image_filter_prewitt_range_scale(s : ImagefilterprewittRange, f : Double) -> ImagefilterprewittRange {
  let result = image_filter_prewitt_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_prewitt_range_add(a : ImagefilterprewittRange, b : ImagefilterprewittRange) -> ImagefilterprewittRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_prewitt_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_prewitt_range_copy(s : ImagefilterprewittRange) -> ImagefilterprewittRange {
  let result = image_filter_prewitt_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_prewitt_range_fill(s : ImagefilterprewittRange, v : Double) -> ImagefilterprewittRange {
  let result = image_filter_prewitt_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_prewitt_range_min(s : ImagefilterprewittRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_prewitt_range_max(s : ImagefilterprewittRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_prewitt_range_to_string(s : ImagefilterprewittRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefilterprewittSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_prewitt_slice_make(size : Int) -> ImagefilterprewittSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_prewitt_slice_len(s : ImagefilterprewittSlice) -> Int { s.size }

pub fn image_filter_prewitt_slice_get(s : ImagefilterprewittSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_prewitt_slice_set(s : ImagefilterprewittSlice, i : Int, v : Double) -> ImagefilterprewittSlice {
  let result = image_filter_prewitt_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_prewitt_slice_sum(s : ImagefilterprewittSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_filter_prewitt_slice_mean(s : ImagefilterprewittSlice) -> Double {
  if s.size == 0 { 0.0 } else { image_filter_prewitt_slice_sum(s) / s.size.to_double() }
}

pub fn image_filter_prewitt_slice_scale(s : ImagefilterprewittSlice, f : Double) -> ImagefilterprewittSlice {
  let result = image_filter_prewitt_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_prewitt_slice_add(a : ImagefilterprewittSlice, b : ImagefilterprewittSlice) -> ImagefilterprewittSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_prewitt_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_prewitt_slice_copy(s : ImagefilterprewittSlice) -> ImagefilterprewittSlice {
  let result = image_filter_prewitt_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_prewitt_slice_fill(s : ImagefilterprewittSlice, v : Double) -> ImagefilterprewittSlice {
  let result = image_filter_prewitt_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_prewitt_slice_min(s : ImagefilterprewittSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_prewitt_slice_max(s : ImagefilterprewittSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_prewitt_slice_to_string(s : ImagefilterprewittSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn image_filter_prewitt_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_filter_prewitt_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_filter_prewitt_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_filter_prewitt_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_filter_prewitt_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_filter_prewitt_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_filter_prewitt_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_filter_prewitt_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_filter_prewitt_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_filter_prewitt_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_filter_prewitt_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_filter_prewitt_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_filter_prewitt_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_filter_prewitt_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_filter_prewitt_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_filter_prewitt_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_filter_prewitt_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_filter_prewitt_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_filter_prewitt_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_filter_prewitt_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_filter_prewitt_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_filter_prewitt_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_filter_prewitt_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_filter_prewitt_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_filter_prewitt_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}


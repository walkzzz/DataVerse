///===
/// extcore/image_feature_kaze

pub(all) struct ImagefeaturekazePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_feature_kaze_make_point(x : Double, y : Double) -> ImagefeaturekazePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_feature_kaze_make_point3(x : Double, y : Double, z : Double) -> ImagefeaturekazePoint {
  { x, y, z, label: 0 }
}

pub fn image_feature_kaze_point_x(pt : ImagefeaturekazePoint) -> Double { pt.x }

pub fn image_feature_kaze_point_y(pt : ImagefeaturekazePoint) -> Double { pt.y }

pub fn image_feature_kaze_point_z(pt : ImagefeaturekazePoint) -> Double { pt.z }

pub fn image_feature_kaze_point_label(pt : ImagefeaturekazePoint) -> Int { pt.label }

pub fn image_feature_kaze_point_dist(a : ImagefeaturekazePoint, b : ImagefeaturekazePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  image_feature_kaze_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn image_feature_kaze_point_add(a : ImagefeaturekazePoint, b : ImagefeaturekazePoint) -> ImagefeaturekazePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn image_feature_kaze_point_sub(a : ImagefeaturekazePoint, b : ImagefeaturekazePoint) -> ImagefeaturekazePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn image_feature_kaze_point_scale(pt : ImagefeaturekazePoint, s : Double) -> ImagefeaturekazePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn image_feature_kaze_point_dot(a : ImagefeaturekazePoint, b : ImagefeaturekazePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn image_feature_kaze_point_cross(a : ImagefeaturekazePoint, b : ImagefeaturekazePoint) -> ImagefeaturekazePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn image_feature_kaze_point_norm(pt : ImagefeaturekazePoint) -> Double {
  image_feature_kaze_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn image_feature_kaze_point_normalize(pt : ImagefeaturekazePoint) -> ImagefeaturekazePoint {
  let n = image_feature_kaze_point_norm(pt)
  if n < 0.0000001 { pt } else { image_feature_kaze_point_scale(pt, 1.0 / n) }
}

pub fn image_feature_kaze_point_negate(pt : ImagefeaturekazePoint) -> ImagefeaturekazePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn image_feature_kaze_point_mid(a : ImagefeaturekazePoint, b : ImagefeaturekazePoint) -> ImagefeaturekazePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn image_feature_kaze_point_lerp(a : ImagefeaturekazePoint, b : ImagefeaturekazePoint, t : Double) -> ImagefeaturekazePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn image_feature_kaze_point_to_string(pt : ImagefeaturekazePoint) -> String {
  "(" + image_feature_kaze_dbl(pt.x) + ", " + image_feature_kaze_dbl(pt.y) + ", " + image_feature_kaze_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct ImagefeaturekazeSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_feature_kaze_make_series(vals : Array[Double], name : String) -> ImagefeaturekazeSeries {
  { vals, name, meta: 0 }
}

pub fn image_feature_kaze_series_len(s : ImagefeaturekazeSeries) -> Int { s.vals.length() }

pub fn image_feature_kaze_series_sum(s : ImagefeaturekazeSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn image_feature_kaze_series_mean(s : ImagefeaturekazeSeries) -> Double {
  let n = image_feature_kaze_series_len(s)
  if n == 0 { 0.0 } else { image_feature_kaze_series_sum(s) / n.to_double() }
}

pub fn image_feature_kaze_series_min(s : ImagefeaturekazeSeries) -> Double {
  let n = image_feature_kaze_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn image_feature_kaze_series_max(s : ImagefeaturekazeSeries) -> Double {
  let n = image_feature_kaze_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn image_feature_kaze_series_range(s : ImagefeaturekazeSeries) -> Double {
  image_feature_kaze_series_max(s) - image_feature_kaze_series_min(s)
}

pub fn image_feature_kaze_series_var(s : ImagefeaturekazeSeries) -> Double {
  let n = image_feature_kaze_series_len(s)
  if n == 0 { 0.0 } else {
    let m = image_feature_kaze_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn image_feature_kaze_series_std(s : ImagefeaturekazeSeries) -> Double { image_feature_kaze_sqrt(image_feature_kaze_series_var(s)) }

pub fn image_feature_kaze_series_median(s : ImagefeaturekazeSeries) -> Double {
  let n = image_feature_kaze_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = image_feature_kaze_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn image_feature_kaze_series_scale(s : ImagefeaturekazeSeries, f : Double) -> ImagefeaturekazeSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = image_feature_kaze_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn image_feature_kaze_series_add(a : ImagefeaturekazeSeries, b : ImagefeaturekazeSeries) -> ImagefeaturekazeSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = image_feature_kaze_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn image_feature_kaze_series_sub(a : ImagefeaturekazeSeries, b : ImagefeaturekazeSeries) -> ImagefeaturekazeSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = image_feature_kaze_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn image_feature_kaze_series_normalize(s : ImagefeaturekazeSeries) -> ImagefeaturekazeSeries {
  let mn = image_feature_kaze_series_min(s)
  let mx = image_feature_kaze_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = image_feature_kaze_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn image_feature_kaze_series_cumsum(s : ImagefeaturekazeSeries) -> ImagefeaturekazeSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = image_feature_kaze_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn image_feature_kaze_series_to_string(s : ImagefeaturekazeSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + image_feature_kaze_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagefeaturekazeMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_feature_kaze_make_matrix(rows : Int, cols : Int, val : Double) -> ImagefeaturekazeMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn image_feature_kaze_matrix_identity(n : Int) -> ImagefeaturekazeMatrix {
  let m = image_feature_kaze_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn image_feature_kaze_matrix_get(m : ImagefeaturekazeMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn image_feature_kaze_matrix_transpose(m : ImagefeaturekazeMatrix) -> ImagefeaturekazeMatrix {
  let result = image_feature_kaze_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn image_feature_kaze_matrix_add(a : ImagefeaturekazeMatrix, b : ImagefeaturekazeMatrix) -> ImagefeaturekazeMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = image_feature_kaze_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn image_feature_kaze_matrix_scale(m : ImagefeaturekazeMatrix, s : Double) -> ImagefeaturekazeMatrix {
  let result = image_feature_kaze_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn image_feature_kaze_matrix_multiply(a : ImagefeaturekazeMatrix, b : ImagefeaturekazeMatrix) -> ImagefeaturekazeMatrix {
  if a.cols != b.rows { return image_feature_kaze_make_matrix(a.rows, b.cols, 0.0) }
  let result = image_feature_kaze_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn image_feature_kaze_matrix_trace(m : ImagefeaturekazeMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn image_feature_kaze_matrix_det(m : ImagefeaturekazeMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn image_feature_kaze_matrix_norm(m : ImagefeaturekazeMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  image_feature_kaze_sqrt(sum)
}

pub fn image_feature_kaze_matrix_to_string(m : ImagefeaturekazeMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + image_feature_kaze_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct ImagefeaturekazeVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_feature_kaze_make_vector(comps : Array[Double]) -> ImagefeaturekazeVector {
  { comps, dim: comps.length() }
}

pub fn image_feature_kaze_vector_zero(dim : Int) -> ImagefeaturekazeVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn image_feature_kaze_vector_add(a : ImagefeaturekazeVector, b : ImagefeaturekazeVector) -> ImagefeaturekazeVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = image_feature_kaze_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn image_feature_kaze_vector_sub(a : ImagefeaturekazeVector, b : ImagefeaturekazeVector) -> ImagefeaturekazeVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = image_feature_kaze_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn image_feature_kaze_vector_scale(v : ImagefeaturekazeVector, s : Double) -> ImagefeaturekazeVector {
  let mut result = []
  for i in 0..<v.dim { result = image_feature_kaze_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn image_feature_kaze_vector_dot(a : ImagefeaturekazeVector, b : ImagefeaturekazeVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn image_feature_kaze_vector_norm(v : ImagefeaturekazeVector) -> Double { image_feature_kaze_sqrt(image_feature_kaze_vector_dot(v, v)) }

pub fn image_feature_kaze_vector_normalize(v : ImagefeaturekazeVector) -> ImagefeaturekazeVector {
  let n = image_feature_kaze_vector_norm(v)
  if n < 0.0000001 { v } else { image_feature_kaze_vector_scale(v, 1.0 / n) }
}

pub fn image_feature_kaze_vector_dist(a : ImagefeaturekazeVector, b : ImagefeaturekazeVector) -> Double {
  image_feature_kaze_vector_norm(image_feature_kaze_vector_sub(a, b))
}

pub fn image_feature_kaze_vector_to_string(v : ImagefeaturekazeVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + image_feature_kaze_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn image_feature_kaze_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn image_feature_kaze_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = image_feature_kaze_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn image_feature_kaze_std(data : Array[Double]) -> Double { image_feature_kaze_sqrt(image_feature_kaze_var(data)) }

pub fn image_feature_kaze_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = image_feature_kaze_mean(a); let mb = image_feature_kaze_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn image_feature_kaze_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = image_feature_kaze_std(a); let sb = image_feature_kaze_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { image_feature_kaze_cov(a, b) / (sa * sb) }
}

pub fn image_feature_kaze_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = image_feature_kaze_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn image_feature_kaze_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn image_feature_kaze_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn image_feature_kaze_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  image_feature_kaze_sqrt(image_feature_kaze_mse(pred, labels))
}

pub fn image_feature_kaze_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + image_feature_kaze_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn image_feature_kaze_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = image_feature_kaze_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn image_feature_kaze_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn image_feature_kaze_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn image_feature_kaze_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = image_feature_kaze_precision(pred, labels, pos); let r = image_feature_kaze_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn image_feature_kaze_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn image_feature_kaze_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = image_feature_kaze_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn image_feature_kaze_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn image_feature_kaze_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn image_feature_kaze_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = image_feature_kaze_gcd(a, b)
    (a / g) * b
  }
}

pub fn image_feature_kaze_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn image_feature_kaze_fibonacci(n : Int) -> Int {
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

pub fn image_feature_kaze_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = image_feature_kaze_min(data); let mx = image_feature_kaze_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn image_feature_kaze_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = image_feature_kaze_mean(data); let sd = image_feature_kaze_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn image_feature_kaze_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn image_feature_kaze_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn image_feature_kaze_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn image_feature_kaze_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn image_feature_kaze_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn image_feature_kaze_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn image_feature_kaze_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn image_feature_kaze_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn image_feature_kaze_dbl(x : Double) -> String {
  let i = if x >= 0.0 { image_feature_kaze_int(x) } else { -image_feature_kaze_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { image_feature_kaze_int(f * 1000000.0) } else { image_feature_kaze_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn image_feature_kaze_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn image_feature_kaze_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct ImagefeaturekazeFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_kaze_frame_make(size : Int) -> ImagefeaturekazeFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_kaze_frame_len(s : ImagefeaturekazeFrame) -> Int { s.size }

pub fn image_feature_kaze_frame_get(s : ImagefeaturekazeFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_kaze_frame_set(s : ImagefeaturekazeFrame, i : Int, v : Double) -> ImagefeaturekazeFrame {
  let result = image_feature_kaze_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_kaze_frame_sum(s : ImagefeaturekazeFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_kaze_frame_mean(s : ImagefeaturekazeFrame) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_kaze_frame_sum(s) / s.size.to_double() }
}

pub fn image_feature_kaze_frame_scale(s : ImagefeaturekazeFrame, f : Double) -> ImagefeaturekazeFrame {
  let result = image_feature_kaze_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_kaze_frame_add(a : ImagefeaturekazeFrame, b : ImagefeaturekazeFrame) -> ImagefeaturekazeFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_kaze_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_kaze_frame_copy(s : ImagefeaturekazeFrame) -> ImagefeaturekazeFrame {
  let result = image_feature_kaze_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_kaze_frame_fill(s : ImagefeaturekazeFrame, v : Double) -> ImagefeaturekazeFrame {
  let result = image_feature_kaze_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_kaze_frame_min(s : ImagefeaturekazeFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_kaze_frame_max(s : ImagefeaturekazeFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_kaze_frame_to_string(s : ImagefeaturekazeFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturekazeTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_kaze_table_make(size : Int) -> ImagefeaturekazeTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_kaze_table_len(s : ImagefeaturekazeTable) -> Int { s.size }

pub fn image_feature_kaze_table_get(s : ImagefeaturekazeTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_kaze_table_set(s : ImagefeaturekazeTable, i : Int, v : Double) -> ImagefeaturekazeTable {
  let result = image_feature_kaze_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_kaze_table_sum(s : ImagefeaturekazeTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_kaze_table_mean(s : ImagefeaturekazeTable) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_kaze_table_sum(s) / s.size.to_double() }
}

pub fn image_feature_kaze_table_scale(s : ImagefeaturekazeTable, f : Double) -> ImagefeaturekazeTable {
  let result = image_feature_kaze_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_kaze_table_add(a : ImagefeaturekazeTable, b : ImagefeaturekazeTable) -> ImagefeaturekazeTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_kaze_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_kaze_table_copy(s : ImagefeaturekazeTable) -> ImagefeaturekazeTable {
  let result = image_feature_kaze_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_kaze_table_fill(s : ImagefeaturekazeTable, v : Double) -> ImagefeaturekazeTable {
  let result = image_feature_kaze_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_kaze_table_min(s : ImagefeaturekazeTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_kaze_table_max(s : ImagefeaturekazeTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_kaze_table_to_string(s : ImagefeaturekazeTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturekazeGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_kaze_graphn_make(size : Int) -> ImagefeaturekazeGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_kaze_graphn_len(s : ImagefeaturekazeGraphN) -> Int { s.size }

pub fn image_feature_kaze_graphn_get(s : ImagefeaturekazeGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_kaze_graphn_set(s : ImagefeaturekazeGraphN, i : Int, v : Double) -> ImagefeaturekazeGraphN {
  let result = image_feature_kaze_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_kaze_graphn_sum(s : ImagefeaturekazeGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_kaze_graphn_mean(s : ImagefeaturekazeGraphN) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_kaze_graphn_sum(s) / s.size.to_double() }
}

pub fn image_feature_kaze_graphn_scale(s : ImagefeaturekazeGraphN, f : Double) -> ImagefeaturekazeGraphN {
  let result = image_feature_kaze_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_kaze_graphn_add(a : ImagefeaturekazeGraphN, b : ImagefeaturekazeGraphN) -> ImagefeaturekazeGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_kaze_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_kaze_graphn_copy(s : ImagefeaturekazeGraphN) -> ImagefeaturekazeGraphN {
  let result = image_feature_kaze_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_kaze_graphn_fill(s : ImagefeaturekazeGraphN, v : Double) -> ImagefeaturekazeGraphN {
  let result = image_feature_kaze_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_kaze_graphn_min(s : ImagefeaturekazeGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_kaze_graphn_max(s : ImagefeaturekazeGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_kaze_graphn_to_string(s : ImagefeaturekazeGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturekazeNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_kaze_node_make(size : Int) -> ImagefeaturekazeNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_kaze_node_len(s : ImagefeaturekazeNode) -> Int { s.size }

pub fn image_feature_kaze_node_get(s : ImagefeaturekazeNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_kaze_node_set(s : ImagefeaturekazeNode, i : Int, v : Double) -> ImagefeaturekazeNode {
  let result = image_feature_kaze_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_kaze_node_sum(s : ImagefeaturekazeNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_kaze_node_mean(s : ImagefeaturekazeNode) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_kaze_node_sum(s) / s.size.to_double() }
}

pub fn image_feature_kaze_node_scale(s : ImagefeaturekazeNode, f : Double) -> ImagefeaturekazeNode {
  let result = image_feature_kaze_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_kaze_node_add(a : ImagefeaturekazeNode, b : ImagefeaturekazeNode) -> ImagefeaturekazeNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_kaze_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_kaze_node_copy(s : ImagefeaturekazeNode) -> ImagefeaturekazeNode {
  let result = image_feature_kaze_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_kaze_node_fill(s : ImagefeaturekazeNode, v : Double) -> ImagefeaturekazeNode {
  let result = image_feature_kaze_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_kaze_node_min(s : ImagefeaturekazeNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_kaze_node_max(s : ImagefeaturekazeNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_kaze_node_to_string(s : ImagefeaturekazeNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturekazeEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_kaze_edge_make(size : Int) -> ImagefeaturekazeEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_kaze_edge_len(s : ImagefeaturekazeEdge) -> Int { s.size }

pub fn image_feature_kaze_edge_get(s : ImagefeaturekazeEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_kaze_edge_set(s : ImagefeaturekazeEdge, i : Int, v : Double) -> ImagefeaturekazeEdge {
  let result = image_feature_kaze_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_kaze_edge_sum(s : ImagefeaturekazeEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_kaze_edge_mean(s : ImagefeaturekazeEdge) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_kaze_edge_sum(s) / s.size.to_double() }
}

pub fn image_feature_kaze_edge_scale(s : ImagefeaturekazeEdge, f : Double) -> ImagefeaturekazeEdge {
  let result = image_feature_kaze_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_kaze_edge_add(a : ImagefeaturekazeEdge, b : ImagefeaturekazeEdge) -> ImagefeaturekazeEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_kaze_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_kaze_edge_copy(s : ImagefeaturekazeEdge) -> ImagefeaturekazeEdge {
  let result = image_feature_kaze_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_kaze_edge_fill(s : ImagefeaturekazeEdge, v : Double) -> ImagefeaturekazeEdge {
  let result = image_feature_kaze_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_kaze_edge_min(s : ImagefeaturekazeEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_kaze_edge_max(s : ImagefeaturekazeEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_kaze_edge_to_string(s : ImagefeaturekazeEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturekazePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_kaze_path_make(size : Int) -> ImagefeaturekazePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_kaze_path_len(s : ImagefeaturekazePath) -> Int { s.size }

pub fn image_feature_kaze_path_get(s : ImagefeaturekazePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_kaze_path_set(s : ImagefeaturekazePath, i : Int, v : Double) -> ImagefeaturekazePath {
  let result = image_feature_kaze_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_kaze_path_sum(s : ImagefeaturekazePath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_kaze_path_mean(s : ImagefeaturekazePath) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_kaze_path_sum(s) / s.size.to_double() }
}

pub fn image_feature_kaze_path_scale(s : ImagefeaturekazePath, f : Double) -> ImagefeaturekazePath {
  let result = image_feature_kaze_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_kaze_path_add(a : ImagefeaturekazePath, b : ImagefeaturekazePath) -> ImagefeaturekazePath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_kaze_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_kaze_path_copy(s : ImagefeaturekazePath) -> ImagefeaturekazePath {
  let result = image_feature_kaze_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_kaze_path_fill(s : ImagefeaturekazePath, v : Double) -> ImagefeaturekazePath {
  let result = image_feature_kaze_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_kaze_path_min(s : ImagefeaturekazePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_kaze_path_max(s : ImagefeaturekazePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_kaze_path_to_string(s : ImagefeaturekazePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturekazeCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_kaze_cluster_make(size : Int) -> ImagefeaturekazeCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_kaze_cluster_len(s : ImagefeaturekazeCluster) -> Int { s.size }

pub fn image_feature_kaze_cluster_get(s : ImagefeaturekazeCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_kaze_cluster_set(s : ImagefeaturekazeCluster, i : Int, v : Double) -> ImagefeaturekazeCluster {
  let result = image_feature_kaze_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_kaze_cluster_sum(s : ImagefeaturekazeCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_kaze_cluster_mean(s : ImagefeaturekazeCluster) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_kaze_cluster_sum(s) / s.size.to_double() }
}

pub fn image_feature_kaze_cluster_scale(s : ImagefeaturekazeCluster, f : Double) -> ImagefeaturekazeCluster {
  let result = image_feature_kaze_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_kaze_cluster_add(a : ImagefeaturekazeCluster, b : ImagefeaturekazeCluster) -> ImagefeaturekazeCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_kaze_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_kaze_cluster_copy(s : ImagefeaturekazeCluster) -> ImagefeaturekazeCluster {
  let result = image_feature_kaze_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_kaze_cluster_fill(s : ImagefeaturekazeCluster, v : Double) -> ImagefeaturekazeCluster {
  let result = image_feature_kaze_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_kaze_cluster_min(s : ImagefeaturekazeCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_kaze_cluster_max(s : ImagefeaturekazeCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_kaze_cluster_to_string(s : ImagefeaturekazeCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturekazeModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_kaze_model_make(size : Int) -> ImagefeaturekazeModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_kaze_model_len(s : ImagefeaturekazeModel) -> Int { s.size }

pub fn image_feature_kaze_model_get(s : ImagefeaturekazeModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_kaze_model_set(s : ImagefeaturekazeModel, i : Int, v : Double) -> ImagefeaturekazeModel {
  let result = image_feature_kaze_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_kaze_model_sum(s : ImagefeaturekazeModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_kaze_model_mean(s : ImagefeaturekazeModel) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_kaze_model_sum(s) / s.size.to_double() }
}

pub fn image_feature_kaze_model_scale(s : ImagefeaturekazeModel, f : Double) -> ImagefeaturekazeModel {
  let result = image_feature_kaze_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_kaze_model_add(a : ImagefeaturekazeModel, b : ImagefeaturekazeModel) -> ImagefeaturekazeModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_kaze_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_kaze_model_copy(s : ImagefeaturekazeModel) -> ImagefeaturekazeModel {
  let result = image_feature_kaze_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_kaze_model_fill(s : ImagefeaturekazeModel, v : Double) -> ImagefeaturekazeModel {
  let result = image_feature_kaze_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_kaze_model_min(s : ImagefeaturekazeModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_kaze_model_max(s : ImagefeaturekazeModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_kaze_model_to_string(s : ImagefeaturekazeModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturekazeLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_kaze_layer_make(size : Int) -> ImagefeaturekazeLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_kaze_layer_len(s : ImagefeaturekazeLayer) -> Int { s.size }

pub fn image_feature_kaze_layer_get(s : ImagefeaturekazeLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_kaze_layer_set(s : ImagefeaturekazeLayer, i : Int, v : Double) -> ImagefeaturekazeLayer {
  let result = image_feature_kaze_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_kaze_layer_sum(s : ImagefeaturekazeLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_kaze_layer_mean(s : ImagefeaturekazeLayer) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_kaze_layer_sum(s) / s.size.to_double() }
}

pub fn image_feature_kaze_layer_scale(s : ImagefeaturekazeLayer, f : Double) -> ImagefeaturekazeLayer {
  let result = image_feature_kaze_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_kaze_layer_add(a : ImagefeaturekazeLayer, b : ImagefeaturekazeLayer) -> ImagefeaturekazeLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_kaze_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_kaze_layer_copy(s : ImagefeaturekazeLayer) -> ImagefeaturekazeLayer {
  let result = image_feature_kaze_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_kaze_layer_fill(s : ImagefeaturekazeLayer, v : Double) -> ImagefeaturekazeLayer {
  let result = image_feature_kaze_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_kaze_layer_min(s : ImagefeaturekazeLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_kaze_layer_max(s : ImagefeaturekazeLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_kaze_layer_to_string(s : ImagefeaturekazeLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturekazeBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_kaze_buffer_make(size : Int) -> ImagefeaturekazeBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_kaze_buffer_len(s : ImagefeaturekazeBuffer) -> Int { s.size }

pub fn image_feature_kaze_buffer_get(s : ImagefeaturekazeBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_kaze_buffer_set(s : ImagefeaturekazeBuffer, i : Int, v : Double) -> ImagefeaturekazeBuffer {
  let result = image_feature_kaze_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_kaze_buffer_sum(s : ImagefeaturekazeBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_kaze_buffer_mean(s : ImagefeaturekazeBuffer) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_kaze_buffer_sum(s) / s.size.to_double() }
}

pub fn image_feature_kaze_buffer_scale(s : ImagefeaturekazeBuffer, f : Double) -> ImagefeaturekazeBuffer {
  let result = image_feature_kaze_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_kaze_buffer_add(a : ImagefeaturekazeBuffer, b : ImagefeaturekazeBuffer) -> ImagefeaturekazeBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_kaze_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_kaze_buffer_copy(s : ImagefeaturekazeBuffer) -> ImagefeaturekazeBuffer {
  let result = image_feature_kaze_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_kaze_buffer_fill(s : ImagefeaturekazeBuffer, v : Double) -> ImagefeaturekazeBuffer {
  let result = image_feature_kaze_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_kaze_buffer_min(s : ImagefeaturekazeBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_kaze_buffer_max(s : ImagefeaturekazeBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_kaze_buffer_to_string(s : ImagefeaturekazeBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturekazeCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_kaze_cursor_make(size : Int) -> ImagefeaturekazeCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_kaze_cursor_len(s : ImagefeaturekazeCursor) -> Int { s.size }

pub fn image_feature_kaze_cursor_get(s : ImagefeaturekazeCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_kaze_cursor_set(s : ImagefeaturekazeCursor, i : Int, v : Double) -> ImagefeaturekazeCursor {
  let result = image_feature_kaze_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_kaze_cursor_sum(s : ImagefeaturekazeCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_kaze_cursor_mean(s : ImagefeaturekazeCursor) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_kaze_cursor_sum(s) / s.size.to_double() }
}

pub fn image_feature_kaze_cursor_scale(s : ImagefeaturekazeCursor, f : Double) -> ImagefeaturekazeCursor {
  let result = image_feature_kaze_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_kaze_cursor_add(a : ImagefeaturekazeCursor, b : ImagefeaturekazeCursor) -> ImagefeaturekazeCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_kaze_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_kaze_cursor_copy(s : ImagefeaturekazeCursor) -> ImagefeaturekazeCursor {
  let result = image_feature_kaze_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_kaze_cursor_fill(s : ImagefeaturekazeCursor, v : Double) -> ImagefeaturekazeCursor {
  let result = image_feature_kaze_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_kaze_cursor_min(s : ImagefeaturekazeCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_kaze_cursor_max(s : ImagefeaturekazeCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_kaze_cursor_to_string(s : ImagefeaturekazeCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturekazeView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_kaze_view_make(size : Int) -> ImagefeaturekazeView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_kaze_view_len(s : ImagefeaturekazeView) -> Int { s.size }

pub fn image_feature_kaze_view_get(s : ImagefeaturekazeView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_kaze_view_set(s : ImagefeaturekazeView, i : Int, v : Double) -> ImagefeaturekazeView {
  let result = image_feature_kaze_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_kaze_view_sum(s : ImagefeaturekazeView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_kaze_view_mean(s : ImagefeaturekazeView) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_kaze_view_sum(s) / s.size.to_double() }
}

pub fn image_feature_kaze_view_scale(s : ImagefeaturekazeView, f : Double) -> ImagefeaturekazeView {
  let result = image_feature_kaze_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_kaze_view_add(a : ImagefeaturekazeView, b : ImagefeaturekazeView) -> ImagefeaturekazeView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_kaze_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_kaze_view_copy(s : ImagefeaturekazeView) -> ImagefeaturekazeView {
  let result = image_feature_kaze_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_kaze_view_fill(s : ImagefeaturekazeView, v : Double) -> ImagefeaturekazeView {
  let result = image_feature_kaze_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_kaze_view_min(s : ImagefeaturekazeView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_kaze_view_max(s : ImagefeaturekazeView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_kaze_view_to_string(s : ImagefeaturekazeView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturekazeRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_kaze_range_make(size : Int) -> ImagefeaturekazeRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_kaze_range_len(s : ImagefeaturekazeRange) -> Int { s.size }

pub fn image_feature_kaze_range_get(s : ImagefeaturekazeRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_kaze_range_set(s : ImagefeaturekazeRange, i : Int, v : Double) -> ImagefeaturekazeRange {
  let result = image_feature_kaze_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_kaze_range_sum(s : ImagefeaturekazeRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_kaze_range_mean(s : ImagefeaturekazeRange) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_kaze_range_sum(s) / s.size.to_double() }
}

pub fn image_feature_kaze_range_scale(s : ImagefeaturekazeRange, f : Double) -> ImagefeaturekazeRange {
  let result = image_feature_kaze_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_kaze_range_add(a : ImagefeaturekazeRange, b : ImagefeaturekazeRange) -> ImagefeaturekazeRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_kaze_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_kaze_range_copy(s : ImagefeaturekazeRange) -> ImagefeaturekazeRange {
  let result = image_feature_kaze_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_kaze_range_fill(s : ImagefeaturekazeRange, v : Double) -> ImagefeaturekazeRange {
  let result = image_feature_kaze_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_kaze_range_min(s : ImagefeaturekazeRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_kaze_range_max(s : ImagefeaturekazeRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_kaze_range_to_string(s : ImagefeaturekazeRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturekazeSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_kaze_slice_make(size : Int) -> ImagefeaturekazeSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_kaze_slice_len(s : ImagefeaturekazeSlice) -> Int { s.size }

pub fn image_feature_kaze_slice_get(s : ImagefeaturekazeSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_kaze_slice_set(s : ImagefeaturekazeSlice, i : Int, v : Double) -> ImagefeaturekazeSlice {
  let result = image_feature_kaze_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_kaze_slice_sum(s : ImagefeaturekazeSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_kaze_slice_mean(s : ImagefeaturekazeSlice) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_kaze_slice_sum(s) / s.size.to_double() }
}

pub fn image_feature_kaze_slice_scale(s : ImagefeaturekazeSlice, f : Double) -> ImagefeaturekazeSlice {
  let result = image_feature_kaze_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_kaze_slice_add(a : ImagefeaturekazeSlice, b : ImagefeaturekazeSlice) -> ImagefeaturekazeSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_kaze_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_kaze_slice_copy(s : ImagefeaturekazeSlice) -> ImagefeaturekazeSlice {
  let result = image_feature_kaze_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_kaze_slice_fill(s : ImagefeaturekazeSlice, v : Double) -> ImagefeaturekazeSlice {
  let result = image_feature_kaze_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_kaze_slice_min(s : ImagefeaturekazeSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_kaze_slice_max(s : ImagefeaturekazeSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_kaze_slice_to_string(s : ImagefeaturekazeSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn image_feature_kaze_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_feature_kaze_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_feature_kaze_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_feature_kaze_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_feature_kaze_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_feature_kaze_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_feature_kaze_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_feature_kaze_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_feature_kaze_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_feature_kaze_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_feature_kaze_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_feature_kaze_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_feature_kaze_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_feature_kaze_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_feature_kaze_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_feature_kaze_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_feature_kaze_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_feature_kaze_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_feature_kaze_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_feature_kaze_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_feature_kaze_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_feature_kaze_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_feature_kaze_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_feature_kaze_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_feature_kaze_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}


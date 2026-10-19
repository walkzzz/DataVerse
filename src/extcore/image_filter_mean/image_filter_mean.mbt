///===
/// extcore/image_filter_mean

pub(all) struct ImagefiltermeanPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_filter_mean_make_point(x : Double, y : Double) -> ImagefiltermeanPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_filter_mean_make_point3(x : Double, y : Double, z : Double) -> ImagefiltermeanPoint {
  { x, y, z, label: 0 }
}

pub fn image_filter_mean_point_x(pt : ImagefiltermeanPoint) -> Double { pt.x }

pub fn image_filter_mean_point_y(pt : ImagefiltermeanPoint) -> Double { pt.y }

pub fn image_filter_mean_point_z(pt : ImagefiltermeanPoint) -> Double { pt.z }

pub fn image_filter_mean_point_label(pt : ImagefiltermeanPoint) -> Int { pt.label }

pub fn image_filter_mean_point_dist(a : ImagefiltermeanPoint, b : ImagefiltermeanPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  image_filter_mean_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn image_filter_mean_point_add(a : ImagefiltermeanPoint, b : ImagefiltermeanPoint) -> ImagefiltermeanPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn image_filter_mean_point_sub(a : ImagefiltermeanPoint, b : ImagefiltermeanPoint) -> ImagefiltermeanPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn image_filter_mean_point_scale(pt : ImagefiltermeanPoint, s : Double) -> ImagefiltermeanPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn image_filter_mean_point_dot(a : ImagefiltermeanPoint, b : ImagefiltermeanPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn image_filter_mean_point_cross(a : ImagefiltermeanPoint, b : ImagefiltermeanPoint) -> ImagefiltermeanPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn image_filter_mean_point_norm(pt : ImagefiltermeanPoint) -> Double {
  image_filter_mean_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn image_filter_mean_point_normalize(pt : ImagefiltermeanPoint) -> ImagefiltermeanPoint {
  let n = image_filter_mean_point_norm(pt)
  if n < 0.0000001 { pt } else { image_filter_mean_point_scale(pt, 1.0 / n) }
}

pub fn image_filter_mean_point_negate(pt : ImagefiltermeanPoint) -> ImagefiltermeanPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn image_filter_mean_point_mid(a : ImagefiltermeanPoint, b : ImagefiltermeanPoint) -> ImagefiltermeanPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn image_filter_mean_point_lerp(a : ImagefiltermeanPoint, b : ImagefiltermeanPoint, t : Double) -> ImagefiltermeanPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn image_filter_mean_point_to_string(pt : ImagefiltermeanPoint) -> String {
  "(" + image_filter_mean_dbl(pt.x) + ", " + image_filter_mean_dbl(pt.y) + ", " + image_filter_mean_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct ImagefiltermeanSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_filter_mean_make_series(vals : Array[Double], name : String) -> ImagefiltermeanSeries {
  { vals, name, meta: 0 }
}

pub fn image_filter_mean_series_len(s : ImagefiltermeanSeries) -> Int { s.vals.length() }

pub fn image_filter_mean_series_sum(s : ImagefiltermeanSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn image_filter_mean_series_mean(s : ImagefiltermeanSeries) -> Double {
  let n = image_filter_mean_series_len(s)
  if n == 0 { 0.0 } else { image_filter_mean_series_sum(s) / n.to_double() }
}

pub fn image_filter_mean_series_min(s : ImagefiltermeanSeries) -> Double {
  let n = image_filter_mean_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn image_filter_mean_series_max(s : ImagefiltermeanSeries) -> Double {
  let n = image_filter_mean_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn image_filter_mean_series_range(s : ImagefiltermeanSeries) -> Double {
  image_filter_mean_series_max(s) - image_filter_mean_series_min(s)
}

pub fn image_filter_mean_series_var(s : ImagefiltermeanSeries) -> Double {
  let n = image_filter_mean_series_len(s)
  if n == 0 { 0.0 } else {
    let m = image_filter_mean_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn image_filter_mean_series_std(s : ImagefiltermeanSeries) -> Double { image_filter_mean_sqrt(image_filter_mean_series_var(s)) }

pub fn image_filter_mean_series_median(s : ImagefiltermeanSeries) -> Double {
  let n = image_filter_mean_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = image_filter_mean_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn image_filter_mean_series_scale(s : ImagefiltermeanSeries, f : Double) -> ImagefiltermeanSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = image_filter_mean_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn image_filter_mean_series_add(a : ImagefiltermeanSeries, b : ImagefiltermeanSeries) -> ImagefiltermeanSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = image_filter_mean_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn image_filter_mean_series_sub(a : ImagefiltermeanSeries, b : ImagefiltermeanSeries) -> ImagefiltermeanSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = image_filter_mean_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn image_filter_mean_series_normalize(s : ImagefiltermeanSeries) -> ImagefiltermeanSeries {
  let mn = image_filter_mean_series_min(s)
  let mx = image_filter_mean_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = image_filter_mean_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn image_filter_mean_series_cumsum(s : ImagefiltermeanSeries) -> ImagefiltermeanSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = image_filter_mean_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn image_filter_mean_series_to_string(s : ImagefiltermeanSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + image_filter_mean_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagefiltermeanMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_filter_mean_make_matrix(rows : Int, cols : Int, val : Double) -> ImagefiltermeanMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn image_filter_mean_matrix_identity(n : Int) -> ImagefiltermeanMatrix {
  let m = image_filter_mean_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn image_filter_mean_matrix_get(m : ImagefiltermeanMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn image_filter_mean_matrix_transpose(m : ImagefiltermeanMatrix) -> ImagefiltermeanMatrix {
  let result = image_filter_mean_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn image_filter_mean_matrix_add(a : ImagefiltermeanMatrix, b : ImagefiltermeanMatrix) -> ImagefiltermeanMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = image_filter_mean_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn image_filter_mean_matrix_scale(m : ImagefiltermeanMatrix, s : Double) -> ImagefiltermeanMatrix {
  let result = image_filter_mean_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn image_filter_mean_matrix_multiply(a : ImagefiltermeanMatrix, b : ImagefiltermeanMatrix) -> ImagefiltermeanMatrix {
  if a.cols != b.rows { return image_filter_mean_make_matrix(a.rows, b.cols, 0.0) }
  let result = image_filter_mean_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn image_filter_mean_matrix_trace(m : ImagefiltermeanMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn image_filter_mean_matrix_det(m : ImagefiltermeanMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn image_filter_mean_matrix_norm(m : ImagefiltermeanMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  image_filter_mean_sqrt(sum)
}

pub fn image_filter_mean_matrix_to_string(m : ImagefiltermeanMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + image_filter_mean_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct ImagefiltermeanVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_filter_mean_make_vector(comps : Array[Double]) -> ImagefiltermeanVector {
  { comps, dim: comps.length() }
}

pub fn image_filter_mean_vector_zero(dim : Int) -> ImagefiltermeanVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn image_filter_mean_vector_add(a : ImagefiltermeanVector, b : ImagefiltermeanVector) -> ImagefiltermeanVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = image_filter_mean_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn image_filter_mean_vector_sub(a : ImagefiltermeanVector, b : ImagefiltermeanVector) -> ImagefiltermeanVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = image_filter_mean_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn image_filter_mean_vector_scale(v : ImagefiltermeanVector, s : Double) -> ImagefiltermeanVector {
  let mut result = []
  for i in 0..<v.dim { result = image_filter_mean_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn image_filter_mean_vector_dot(a : ImagefiltermeanVector, b : ImagefiltermeanVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn image_filter_mean_vector_norm(v : ImagefiltermeanVector) -> Double { image_filter_mean_sqrt(image_filter_mean_vector_dot(v, v)) }

pub fn image_filter_mean_vector_normalize(v : ImagefiltermeanVector) -> ImagefiltermeanVector {
  let n = image_filter_mean_vector_norm(v)
  if n < 0.0000001 { v } else { image_filter_mean_vector_scale(v, 1.0 / n) }
}

pub fn image_filter_mean_vector_dist(a : ImagefiltermeanVector, b : ImagefiltermeanVector) -> Double {
  image_filter_mean_vector_norm(image_filter_mean_vector_sub(a, b))
}

pub fn image_filter_mean_vector_to_string(v : ImagefiltermeanVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + image_filter_mean_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn image_filter_mean_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn image_filter_mean_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = image_filter_mean_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn image_filter_mean_std(data : Array[Double]) -> Double { image_filter_mean_sqrt(image_filter_mean_var(data)) }

pub fn image_filter_mean_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = image_filter_mean_mean(a); let mb = image_filter_mean_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn image_filter_mean_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = image_filter_mean_std(a); let sb = image_filter_mean_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { image_filter_mean_cov(a, b) / (sa * sb) }
}

pub fn image_filter_mean_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = image_filter_mean_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn image_filter_mean_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn image_filter_mean_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn image_filter_mean_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  image_filter_mean_sqrt(image_filter_mean_mse(pred, labels))
}

pub fn image_filter_mean_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + image_filter_mean_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn image_filter_mean_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = image_filter_mean_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn image_filter_mean_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn image_filter_mean_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn image_filter_mean_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = image_filter_mean_precision(pred, labels, pos); let r = image_filter_mean_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn image_filter_mean_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn image_filter_mean_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = image_filter_mean_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn image_filter_mean_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn image_filter_mean_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn image_filter_mean_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = image_filter_mean_gcd(a, b)
    (a / g) * b
  }
}

pub fn image_filter_mean_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn image_filter_mean_fibonacci(n : Int) -> Int {
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

pub fn image_filter_mean_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = image_filter_mean_min(data); let mx = image_filter_mean_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn image_filter_mean_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = image_filter_mean_mean(data); let sd = image_filter_mean_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn image_filter_mean_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn image_filter_mean_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn image_filter_mean_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn image_filter_mean_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn image_filter_mean_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn image_filter_mean_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn image_filter_mean_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn image_filter_mean_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn image_filter_mean_dbl(x : Double) -> String {
  let i = if x >= 0.0 { image_filter_mean_int(x) } else { -image_filter_mean_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { image_filter_mean_int(f * 1000000.0) } else { image_filter_mean_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn image_filter_mean_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn image_filter_mean_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct ImagefiltermeanFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_mean_frame_make(size : Int) -> ImagefiltermeanFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_mean_frame_len(s : ImagefiltermeanFrame) -> Int { s.size }

pub fn image_filter_mean_frame_get(s : ImagefiltermeanFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_mean_frame_set(s : ImagefiltermeanFrame, i : Int, v : Double) -> ImagefiltermeanFrame {
  let result = image_filter_mean_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_mean_frame_sum(s : ImagefiltermeanFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_filter_mean_frame_mean(s : ImagefiltermeanFrame) -> Double {
  if s.size == 0 { 0.0 } else { image_filter_mean_frame_sum(s) / s.size.to_double() }
}

pub fn image_filter_mean_frame_scale(s : ImagefiltermeanFrame, f : Double) -> ImagefiltermeanFrame {
  let result = image_filter_mean_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_mean_frame_add(a : ImagefiltermeanFrame, b : ImagefiltermeanFrame) -> ImagefiltermeanFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_mean_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_mean_frame_copy(s : ImagefiltermeanFrame) -> ImagefiltermeanFrame {
  let result = image_filter_mean_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_mean_frame_fill(s : ImagefiltermeanFrame, v : Double) -> ImagefiltermeanFrame {
  let result = image_filter_mean_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_mean_frame_min(s : ImagefiltermeanFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_mean_frame_max(s : ImagefiltermeanFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_mean_frame_to_string(s : ImagefiltermeanFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltermeanTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_mean_table_make(size : Int) -> ImagefiltermeanTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_mean_table_len(s : ImagefiltermeanTable) -> Int { s.size }

pub fn image_filter_mean_table_get(s : ImagefiltermeanTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_mean_table_set(s : ImagefiltermeanTable, i : Int, v : Double) -> ImagefiltermeanTable {
  let result = image_filter_mean_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_mean_table_sum(s : ImagefiltermeanTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_filter_mean_table_mean(s : ImagefiltermeanTable) -> Double {
  if s.size == 0 { 0.0 } else { image_filter_mean_table_sum(s) / s.size.to_double() }
}

pub fn image_filter_mean_table_scale(s : ImagefiltermeanTable, f : Double) -> ImagefiltermeanTable {
  let result = image_filter_mean_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_mean_table_add(a : ImagefiltermeanTable, b : ImagefiltermeanTable) -> ImagefiltermeanTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_mean_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_mean_table_copy(s : ImagefiltermeanTable) -> ImagefiltermeanTable {
  let result = image_filter_mean_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_mean_table_fill(s : ImagefiltermeanTable, v : Double) -> ImagefiltermeanTable {
  let result = image_filter_mean_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_mean_table_min(s : ImagefiltermeanTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_mean_table_max(s : ImagefiltermeanTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_mean_table_to_string(s : ImagefiltermeanTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltermeanGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_mean_graphn_make(size : Int) -> ImagefiltermeanGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_mean_graphn_len(s : ImagefiltermeanGraphN) -> Int { s.size }

pub fn image_filter_mean_graphn_get(s : ImagefiltermeanGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_mean_graphn_set(s : ImagefiltermeanGraphN, i : Int, v : Double) -> ImagefiltermeanGraphN {
  let result = image_filter_mean_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_mean_graphn_sum(s : ImagefiltermeanGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_filter_mean_graphn_mean(s : ImagefiltermeanGraphN) -> Double {
  if s.size == 0 { 0.0 } else { image_filter_mean_graphn_sum(s) / s.size.to_double() }
}

pub fn image_filter_mean_graphn_scale(s : ImagefiltermeanGraphN, f : Double) -> ImagefiltermeanGraphN {
  let result = image_filter_mean_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_mean_graphn_add(a : ImagefiltermeanGraphN, b : ImagefiltermeanGraphN) -> ImagefiltermeanGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_mean_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_mean_graphn_copy(s : ImagefiltermeanGraphN) -> ImagefiltermeanGraphN {
  let result = image_filter_mean_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_mean_graphn_fill(s : ImagefiltermeanGraphN, v : Double) -> ImagefiltermeanGraphN {
  let result = image_filter_mean_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_mean_graphn_min(s : ImagefiltermeanGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_mean_graphn_max(s : ImagefiltermeanGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_mean_graphn_to_string(s : ImagefiltermeanGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltermeanNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_mean_node_make(size : Int) -> ImagefiltermeanNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_mean_node_len(s : ImagefiltermeanNode) -> Int { s.size }

pub fn image_filter_mean_node_get(s : ImagefiltermeanNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_mean_node_set(s : ImagefiltermeanNode, i : Int, v : Double) -> ImagefiltermeanNode {
  let result = image_filter_mean_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_mean_node_sum(s : ImagefiltermeanNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_filter_mean_node_mean(s : ImagefiltermeanNode) -> Double {
  if s.size == 0 { 0.0 } else { image_filter_mean_node_sum(s) / s.size.to_double() }
}

pub fn image_filter_mean_node_scale(s : ImagefiltermeanNode, f : Double) -> ImagefiltermeanNode {
  let result = image_filter_mean_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_mean_node_add(a : ImagefiltermeanNode, b : ImagefiltermeanNode) -> ImagefiltermeanNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_mean_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_mean_node_copy(s : ImagefiltermeanNode) -> ImagefiltermeanNode {
  let result = image_filter_mean_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_mean_node_fill(s : ImagefiltermeanNode, v : Double) -> ImagefiltermeanNode {
  let result = image_filter_mean_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_mean_node_min(s : ImagefiltermeanNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_mean_node_max(s : ImagefiltermeanNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_mean_node_to_string(s : ImagefiltermeanNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltermeanEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_mean_edge_make(size : Int) -> ImagefiltermeanEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_mean_edge_len(s : ImagefiltermeanEdge) -> Int { s.size }

pub fn image_filter_mean_edge_get(s : ImagefiltermeanEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_mean_edge_set(s : ImagefiltermeanEdge, i : Int, v : Double) -> ImagefiltermeanEdge {
  let result = image_filter_mean_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_mean_edge_sum(s : ImagefiltermeanEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_filter_mean_edge_mean(s : ImagefiltermeanEdge) -> Double {
  if s.size == 0 { 0.0 } else { image_filter_mean_edge_sum(s) / s.size.to_double() }
}

pub fn image_filter_mean_edge_scale(s : ImagefiltermeanEdge, f : Double) -> ImagefiltermeanEdge {
  let result = image_filter_mean_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_mean_edge_add(a : ImagefiltermeanEdge, b : ImagefiltermeanEdge) -> ImagefiltermeanEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_mean_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_mean_edge_copy(s : ImagefiltermeanEdge) -> ImagefiltermeanEdge {
  let result = image_filter_mean_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_mean_edge_fill(s : ImagefiltermeanEdge, v : Double) -> ImagefiltermeanEdge {
  let result = image_filter_mean_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_mean_edge_min(s : ImagefiltermeanEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_mean_edge_max(s : ImagefiltermeanEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_mean_edge_to_string(s : ImagefiltermeanEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltermeanPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_mean_path_make(size : Int) -> ImagefiltermeanPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_mean_path_len(s : ImagefiltermeanPath) -> Int { s.size }

pub fn image_filter_mean_path_get(s : ImagefiltermeanPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_mean_path_set(s : ImagefiltermeanPath, i : Int, v : Double) -> ImagefiltermeanPath {
  let result = image_filter_mean_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_mean_path_sum(s : ImagefiltermeanPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_filter_mean_path_mean(s : ImagefiltermeanPath) -> Double {
  if s.size == 0 { 0.0 } else { image_filter_mean_path_sum(s) / s.size.to_double() }
}

pub fn image_filter_mean_path_scale(s : ImagefiltermeanPath, f : Double) -> ImagefiltermeanPath {
  let result = image_filter_mean_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_mean_path_add(a : ImagefiltermeanPath, b : ImagefiltermeanPath) -> ImagefiltermeanPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_mean_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_mean_path_copy(s : ImagefiltermeanPath) -> ImagefiltermeanPath {
  let result = image_filter_mean_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_mean_path_fill(s : ImagefiltermeanPath, v : Double) -> ImagefiltermeanPath {
  let result = image_filter_mean_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_mean_path_min(s : ImagefiltermeanPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_mean_path_max(s : ImagefiltermeanPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_mean_path_to_string(s : ImagefiltermeanPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltermeanCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_mean_cluster_make(size : Int) -> ImagefiltermeanCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_mean_cluster_len(s : ImagefiltermeanCluster) -> Int { s.size }

pub fn image_filter_mean_cluster_get(s : ImagefiltermeanCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_mean_cluster_set(s : ImagefiltermeanCluster, i : Int, v : Double) -> ImagefiltermeanCluster {
  let result = image_filter_mean_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_mean_cluster_sum(s : ImagefiltermeanCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_filter_mean_cluster_mean(s : ImagefiltermeanCluster) -> Double {
  if s.size == 0 { 0.0 } else { image_filter_mean_cluster_sum(s) / s.size.to_double() }
}

pub fn image_filter_mean_cluster_scale(s : ImagefiltermeanCluster, f : Double) -> ImagefiltermeanCluster {
  let result = image_filter_mean_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_mean_cluster_add(a : ImagefiltermeanCluster, b : ImagefiltermeanCluster) -> ImagefiltermeanCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_mean_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_mean_cluster_copy(s : ImagefiltermeanCluster) -> ImagefiltermeanCluster {
  let result = image_filter_mean_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_mean_cluster_fill(s : ImagefiltermeanCluster, v : Double) -> ImagefiltermeanCluster {
  let result = image_filter_mean_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_mean_cluster_min(s : ImagefiltermeanCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_mean_cluster_max(s : ImagefiltermeanCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_mean_cluster_to_string(s : ImagefiltermeanCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltermeanModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_mean_model_make(size : Int) -> ImagefiltermeanModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_mean_model_len(s : ImagefiltermeanModel) -> Int { s.size }

pub fn image_filter_mean_model_get(s : ImagefiltermeanModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_mean_model_set(s : ImagefiltermeanModel, i : Int, v : Double) -> ImagefiltermeanModel {
  let result = image_filter_mean_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_mean_model_sum(s : ImagefiltermeanModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_filter_mean_model_mean(s : ImagefiltermeanModel) -> Double {
  if s.size == 0 { 0.0 } else { image_filter_mean_model_sum(s) / s.size.to_double() }
}

pub fn image_filter_mean_model_scale(s : ImagefiltermeanModel, f : Double) -> ImagefiltermeanModel {
  let result = image_filter_mean_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_mean_model_add(a : ImagefiltermeanModel, b : ImagefiltermeanModel) -> ImagefiltermeanModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_mean_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_mean_model_copy(s : ImagefiltermeanModel) -> ImagefiltermeanModel {
  let result = image_filter_mean_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_mean_model_fill(s : ImagefiltermeanModel, v : Double) -> ImagefiltermeanModel {
  let result = image_filter_mean_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_mean_model_min(s : ImagefiltermeanModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_mean_model_max(s : ImagefiltermeanModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_mean_model_to_string(s : ImagefiltermeanModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltermeanLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_mean_layer_make(size : Int) -> ImagefiltermeanLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_mean_layer_len(s : ImagefiltermeanLayer) -> Int { s.size }

pub fn image_filter_mean_layer_get(s : ImagefiltermeanLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_mean_layer_set(s : ImagefiltermeanLayer, i : Int, v : Double) -> ImagefiltermeanLayer {
  let result = image_filter_mean_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_mean_layer_sum(s : ImagefiltermeanLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_filter_mean_layer_mean(s : ImagefiltermeanLayer) -> Double {
  if s.size == 0 { 0.0 } else { image_filter_mean_layer_sum(s) / s.size.to_double() }
}

pub fn image_filter_mean_layer_scale(s : ImagefiltermeanLayer, f : Double) -> ImagefiltermeanLayer {
  let result = image_filter_mean_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_mean_layer_add(a : ImagefiltermeanLayer, b : ImagefiltermeanLayer) -> ImagefiltermeanLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_mean_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_mean_layer_copy(s : ImagefiltermeanLayer) -> ImagefiltermeanLayer {
  let result = image_filter_mean_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_mean_layer_fill(s : ImagefiltermeanLayer, v : Double) -> ImagefiltermeanLayer {
  let result = image_filter_mean_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_mean_layer_min(s : ImagefiltermeanLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_mean_layer_max(s : ImagefiltermeanLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_mean_layer_to_string(s : ImagefiltermeanLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltermeanBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_mean_buffer_make(size : Int) -> ImagefiltermeanBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_mean_buffer_len(s : ImagefiltermeanBuffer) -> Int { s.size }

pub fn image_filter_mean_buffer_get(s : ImagefiltermeanBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_mean_buffer_set(s : ImagefiltermeanBuffer, i : Int, v : Double) -> ImagefiltermeanBuffer {
  let result = image_filter_mean_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_mean_buffer_sum(s : ImagefiltermeanBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_filter_mean_buffer_mean(s : ImagefiltermeanBuffer) -> Double {
  if s.size == 0 { 0.0 } else { image_filter_mean_buffer_sum(s) / s.size.to_double() }
}

pub fn image_filter_mean_buffer_scale(s : ImagefiltermeanBuffer, f : Double) -> ImagefiltermeanBuffer {
  let result = image_filter_mean_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_mean_buffer_add(a : ImagefiltermeanBuffer, b : ImagefiltermeanBuffer) -> ImagefiltermeanBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_mean_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_mean_buffer_copy(s : ImagefiltermeanBuffer) -> ImagefiltermeanBuffer {
  let result = image_filter_mean_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_mean_buffer_fill(s : ImagefiltermeanBuffer, v : Double) -> ImagefiltermeanBuffer {
  let result = image_filter_mean_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_mean_buffer_min(s : ImagefiltermeanBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_mean_buffer_max(s : ImagefiltermeanBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_mean_buffer_to_string(s : ImagefiltermeanBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltermeanCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_mean_cursor_make(size : Int) -> ImagefiltermeanCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_mean_cursor_len(s : ImagefiltermeanCursor) -> Int { s.size }

pub fn image_filter_mean_cursor_get(s : ImagefiltermeanCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_mean_cursor_set(s : ImagefiltermeanCursor, i : Int, v : Double) -> ImagefiltermeanCursor {
  let result = image_filter_mean_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_mean_cursor_sum(s : ImagefiltermeanCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_filter_mean_cursor_mean(s : ImagefiltermeanCursor) -> Double {
  if s.size == 0 { 0.0 } else { image_filter_mean_cursor_sum(s) / s.size.to_double() }
}

pub fn image_filter_mean_cursor_scale(s : ImagefiltermeanCursor, f : Double) -> ImagefiltermeanCursor {
  let result = image_filter_mean_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_mean_cursor_add(a : ImagefiltermeanCursor, b : ImagefiltermeanCursor) -> ImagefiltermeanCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_mean_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_mean_cursor_copy(s : ImagefiltermeanCursor) -> ImagefiltermeanCursor {
  let result = image_filter_mean_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_mean_cursor_fill(s : ImagefiltermeanCursor, v : Double) -> ImagefiltermeanCursor {
  let result = image_filter_mean_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_mean_cursor_min(s : ImagefiltermeanCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_mean_cursor_max(s : ImagefiltermeanCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_mean_cursor_to_string(s : ImagefiltermeanCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltermeanView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_mean_view_make(size : Int) -> ImagefiltermeanView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_mean_view_len(s : ImagefiltermeanView) -> Int { s.size }

pub fn image_filter_mean_view_get(s : ImagefiltermeanView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_mean_view_set(s : ImagefiltermeanView, i : Int, v : Double) -> ImagefiltermeanView {
  let result = image_filter_mean_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_mean_view_sum(s : ImagefiltermeanView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_filter_mean_view_mean(s : ImagefiltermeanView) -> Double {
  if s.size == 0 { 0.0 } else { image_filter_mean_view_sum(s) / s.size.to_double() }
}

pub fn image_filter_mean_view_scale(s : ImagefiltermeanView, f : Double) -> ImagefiltermeanView {
  let result = image_filter_mean_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_mean_view_add(a : ImagefiltermeanView, b : ImagefiltermeanView) -> ImagefiltermeanView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_mean_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_mean_view_copy(s : ImagefiltermeanView) -> ImagefiltermeanView {
  let result = image_filter_mean_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_mean_view_fill(s : ImagefiltermeanView, v : Double) -> ImagefiltermeanView {
  let result = image_filter_mean_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_mean_view_min(s : ImagefiltermeanView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_mean_view_max(s : ImagefiltermeanView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_mean_view_to_string(s : ImagefiltermeanView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltermeanRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_mean_range_make(size : Int) -> ImagefiltermeanRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_mean_range_len(s : ImagefiltermeanRange) -> Int { s.size }

pub fn image_filter_mean_range_get(s : ImagefiltermeanRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_mean_range_set(s : ImagefiltermeanRange, i : Int, v : Double) -> ImagefiltermeanRange {
  let result = image_filter_mean_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_mean_range_sum(s : ImagefiltermeanRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_filter_mean_range_mean(s : ImagefiltermeanRange) -> Double {
  if s.size == 0 { 0.0 } else { image_filter_mean_range_sum(s) / s.size.to_double() }
}

pub fn image_filter_mean_range_scale(s : ImagefiltermeanRange, f : Double) -> ImagefiltermeanRange {
  let result = image_filter_mean_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_mean_range_add(a : ImagefiltermeanRange, b : ImagefiltermeanRange) -> ImagefiltermeanRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_mean_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_mean_range_copy(s : ImagefiltermeanRange) -> ImagefiltermeanRange {
  let result = image_filter_mean_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_mean_range_fill(s : ImagefiltermeanRange, v : Double) -> ImagefiltermeanRange {
  let result = image_filter_mean_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_mean_range_min(s : ImagefiltermeanRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_mean_range_max(s : ImagefiltermeanRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_mean_range_to_string(s : ImagefiltermeanRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltermeanSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_mean_slice_make(size : Int) -> ImagefiltermeanSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_mean_slice_len(s : ImagefiltermeanSlice) -> Int { s.size }

pub fn image_filter_mean_slice_get(s : ImagefiltermeanSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_mean_slice_set(s : ImagefiltermeanSlice, i : Int, v : Double) -> ImagefiltermeanSlice {
  let result = image_filter_mean_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_mean_slice_sum(s : ImagefiltermeanSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_filter_mean_slice_mean(s : ImagefiltermeanSlice) -> Double {
  if s.size == 0 { 0.0 } else { image_filter_mean_slice_sum(s) / s.size.to_double() }
}

pub fn image_filter_mean_slice_scale(s : ImagefiltermeanSlice, f : Double) -> ImagefiltermeanSlice {
  let result = image_filter_mean_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_mean_slice_add(a : ImagefiltermeanSlice, b : ImagefiltermeanSlice) -> ImagefiltermeanSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_mean_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_mean_slice_copy(s : ImagefiltermeanSlice) -> ImagefiltermeanSlice {
  let result = image_filter_mean_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_mean_slice_fill(s : ImagefiltermeanSlice, v : Double) -> ImagefiltermeanSlice {
  let result = image_filter_mean_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_mean_slice_min(s : ImagefiltermeanSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_mean_slice_max(s : ImagefiltermeanSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_mean_slice_to_string(s : ImagefiltermeanSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn image_filter_mean_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_filter_mean_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_filter_mean_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_filter_mean_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_filter_mean_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_filter_mean_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_filter_mean_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_filter_mean_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_filter_mean_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_filter_mean_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_filter_mean_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_filter_mean_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_filter_mean_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_filter_mean_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_filter_mean_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_filter_mean_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_filter_mean_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_filter_mean_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_filter_mean_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_filter_mean_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_filter_mean_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_filter_mean_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_filter_mean_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_filter_mean_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_filter_mean_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}


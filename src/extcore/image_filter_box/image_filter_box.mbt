///===
/// extcore/image_filter_box

pub(all) struct ImagefilterboxPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_filter_box_make_point(x : Double, y : Double) -> ImagefilterboxPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_filter_box_make_point3(x : Double, y : Double, z : Double) -> ImagefilterboxPoint {
  { x, y, z, label: 0 }
}

pub fn image_filter_box_point_x(pt : ImagefilterboxPoint) -> Double { pt.x }

pub fn image_filter_box_point_y(pt : ImagefilterboxPoint) -> Double { pt.y }

pub fn image_filter_box_point_z(pt : ImagefilterboxPoint) -> Double { pt.z }

pub fn image_filter_box_point_label(pt : ImagefilterboxPoint) -> Int { pt.label }

pub fn image_filter_box_point_dist(a : ImagefilterboxPoint, b : ImagefilterboxPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  image_filter_box_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn image_filter_box_point_add(a : ImagefilterboxPoint, b : ImagefilterboxPoint) -> ImagefilterboxPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn image_filter_box_point_sub(a : ImagefilterboxPoint, b : ImagefilterboxPoint) -> ImagefilterboxPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn image_filter_box_point_scale(pt : ImagefilterboxPoint, s : Double) -> ImagefilterboxPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn image_filter_box_point_dot(a : ImagefilterboxPoint, b : ImagefilterboxPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn image_filter_box_point_cross(a : ImagefilterboxPoint, b : ImagefilterboxPoint) -> ImagefilterboxPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn image_filter_box_point_norm(pt : ImagefilterboxPoint) -> Double {
  image_filter_box_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn image_filter_box_point_normalize(pt : ImagefilterboxPoint) -> ImagefilterboxPoint {
  let n = image_filter_box_point_norm(pt)
  if n < 0.0000001 { pt } else { image_filter_box_point_scale(pt, 1.0 / n) }
}

pub fn image_filter_box_point_negate(pt : ImagefilterboxPoint) -> ImagefilterboxPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn image_filter_box_point_mid(a : ImagefilterboxPoint, b : ImagefilterboxPoint) -> ImagefilterboxPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn image_filter_box_point_lerp(a : ImagefilterboxPoint, b : ImagefilterboxPoint, t : Double) -> ImagefilterboxPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn image_filter_box_point_to_string(pt : ImagefilterboxPoint) -> String {
  "(" + image_filter_box_dbl(pt.x) + ", " + image_filter_box_dbl(pt.y) + ", " + image_filter_box_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct ImagefilterboxSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_filter_box_make_series(vals : Array[Double], name : String) -> ImagefilterboxSeries {
  { vals, name, meta: 0 }
}

pub fn image_filter_box_series_len(s : ImagefilterboxSeries) -> Int { s.vals.length() }

pub fn image_filter_box_series_sum(s : ImagefilterboxSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn image_filter_box_series_mean(s : ImagefilterboxSeries) -> Double {
  let n = image_filter_box_series_len(s)
  if n == 0 { 0.0 } else { image_filter_box_series_sum(s) / n.to_double() }
}

pub fn image_filter_box_series_min(s : ImagefilterboxSeries) -> Double {
  let n = image_filter_box_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn image_filter_box_series_max(s : ImagefilterboxSeries) -> Double {
  let n = image_filter_box_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn image_filter_box_series_range(s : ImagefilterboxSeries) -> Double {
  image_filter_box_series_max(s) - image_filter_box_series_min(s)
}

pub fn image_filter_box_series_var(s : ImagefilterboxSeries) -> Double {
  let n = image_filter_box_series_len(s)
  if n == 0 { 0.0 } else {
    let m = image_filter_box_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn image_filter_box_series_std(s : ImagefilterboxSeries) -> Double { image_filter_box_sqrt(image_filter_box_series_var(s)) }

pub fn image_filter_box_series_median(s : ImagefilterboxSeries) -> Double {
  let n = image_filter_box_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = image_filter_box_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn image_filter_box_series_scale(s : ImagefilterboxSeries, f : Double) -> ImagefilterboxSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = image_filter_box_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn image_filter_box_series_add(a : ImagefilterboxSeries, b : ImagefilterboxSeries) -> ImagefilterboxSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = image_filter_box_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn image_filter_box_series_sub(a : ImagefilterboxSeries, b : ImagefilterboxSeries) -> ImagefilterboxSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = image_filter_box_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn image_filter_box_series_normalize(s : ImagefilterboxSeries) -> ImagefilterboxSeries {
  let mn = image_filter_box_series_min(s)
  let mx = image_filter_box_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = image_filter_box_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn image_filter_box_series_cumsum(s : ImagefilterboxSeries) -> ImagefilterboxSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = image_filter_box_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn image_filter_box_series_to_string(s : ImagefilterboxSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + image_filter_box_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagefilterboxMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_filter_box_make_matrix(rows : Int, cols : Int, val : Double) -> ImagefilterboxMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn image_filter_box_matrix_identity(n : Int) -> ImagefilterboxMatrix {
  let m = image_filter_box_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn image_filter_box_matrix_get(m : ImagefilterboxMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn image_filter_box_matrix_transpose(m : ImagefilterboxMatrix) -> ImagefilterboxMatrix {
  let result = image_filter_box_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn image_filter_box_matrix_add(a : ImagefilterboxMatrix, b : ImagefilterboxMatrix) -> ImagefilterboxMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = image_filter_box_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn image_filter_box_matrix_scale(m : ImagefilterboxMatrix, s : Double) -> ImagefilterboxMatrix {
  let result = image_filter_box_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn image_filter_box_matrix_multiply(a : ImagefilterboxMatrix, b : ImagefilterboxMatrix) -> ImagefilterboxMatrix {
  if a.cols != b.rows { return image_filter_box_make_matrix(a.rows, b.cols, 0.0) }
  let result = image_filter_box_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn image_filter_box_matrix_trace(m : ImagefilterboxMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn image_filter_box_matrix_det(m : ImagefilterboxMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn image_filter_box_matrix_norm(m : ImagefilterboxMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  image_filter_box_sqrt(sum)
}

pub fn image_filter_box_matrix_to_string(m : ImagefilterboxMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + image_filter_box_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct ImagefilterboxVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_filter_box_make_vector(comps : Array[Double]) -> ImagefilterboxVector {
  { comps, dim: comps.length() }
}

pub fn image_filter_box_vector_zero(dim : Int) -> ImagefilterboxVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn image_filter_box_vector_add(a : ImagefilterboxVector, b : ImagefilterboxVector) -> ImagefilterboxVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = image_filter_box_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn image_filter_box_vector_sub(a : ImagefilterboxVector, b : ImagefilterboxVector) -> ImagefilterboxVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = image_filter_box_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn image_filter_box_vector_scale(v : ImagefilterboxVector, s : Double) -> ImagefilterboxVector {
  let mut result = []
  for i in 0..<v.dim { result = image_filter_box_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn image_filter_box_vector_dot(a : ImagefilterboxVector, b : ImagefilterboxVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn image_filter_box_vector_norm(v : ImagefilterboxVector) -> Double { image_filter_box_sqrt(image_filter_box_vector_dot(v, v)) }

pub fn image_filter_box_vector_normalize(v : ImagefilterboxVector) -> ImagefilterboxVector {
  let n = image_filter_box_vector_norm(v)
  if n < 0.0000001 { v } else { image_filter_box_vector_scale(v, 1.0 / n) }
}

pub fn image_filter_box_vector_dist(a : ImagefilterboxVector, b : ImagefilterboxVector) -> Double {
  image_filter_box_vector_norm(image_filter_box_vector_sub(a, b))
}

pub fn image_filter_box_vector_to_string(v : ImagefilterboxVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + image_filter_box_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn image_filter_box_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn image_filter_box_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = image_filter_box_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn image_filter_box_std(data : Array[Double]) -> Double { image_filter_box_sqrt(image_filter_box_var(data)) }

pub fn image_filter_box_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = image_filter_box_mean(a); let mb = image_filter_box_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn image_filter_box_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = image_filter_box_std(a); let sb = image_filter_box_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { image_filter_box_cov(a, b) / (sa * sb) }
}

pub fn image_filter_box_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = image_filter_box_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn image_filter_box_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn image_filter_box_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn image_filter_box_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  image_filter_box_sqrt(image_filter_box_mse(pred, labels))
}

pub fn image_filter_box_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + image_filter_box_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn image_filter_box_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = image_filter_box_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn image_filter_box_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn image_filter_box_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn image_filter_box_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = image_filter_box_precision(pred, labels, pos); let r = image_filter_box_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn image_filter_box_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn image_filter_box_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = image_filter_box_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn image_filter_box_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn image_filter_box_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn image_filter_box_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = image_filter_box_gcd(a, b)
    (a / g) * b
  }
}

pub fn image_filter_box_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn image_filter_box_fibonacci(n : Int) -> Int {
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

pub fn image_filter_box_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = image_filter_box_min(data); let mx = image_filter_box_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn image_filter_box_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = image_filter_box_mean(data); let sd = image_filter_box_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn image_filter_box_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn image_filter_box_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn image_filter_box_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn image_filter_box_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn image_filter_box_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn image_filter_box_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn image_filter_box_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn image_filter_box_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn image_filter_box_dbl(x : Double) -> String {
  let i = if x >= 0.0 { image_filter_box_int(x) } else { -image_filter_box_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { image_filter_box_int(f * 1000000.0) } else { image_filter_box_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn image_filter_box_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn image_filter_box_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct ImagefilterboxFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_box_frame_make(size : Int) -> ImagefilterboxFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_box_frame_len(s : ImagefilterboxFrame) -> Int { s.size }

pub fn image_filter_box_frame_get(s : ImagefilterboxFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_box_frame_set(s : ImagefilterboxFrame, i : Int, v : Double) -> ImagefilterboxFrame {
  let result = image_filter_box_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_box_frame_sum(s : ImagefilterboxFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_filter_box_frame_mean(s : ImagefilterboxFrame) -> Double {
  if s.size == 0 { 0.0 } else { image_filter_box_frame_sum(s) / s.size.to_double() }
}

pub fn image_filter_box_frame_scale(s : ImagefilterboxFrame, f : Double) -> ImagefilterboxFrame {
  let result = image_filter_box_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_box_frame_add(a : ImagefilterboxFrame, b : ImagefilterboxFrame) -> ImagefilterboxFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_box_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_box_frame_copy(s : ImagefilterboxFrame) -> ImagefilterboxFrame {
  let result = image_filter_box_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_box_frame_fill(s : ImagefilterboxFrame, v : Double) -> ImagefilterboxFrame {
  let result = image_filter_box_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_box_frame_min(s : ImagefilterboxFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_box_frame_max(s : ImagefilterboxFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_box_frame_to_string(s : ImagefilterboxFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefilterboxTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_box_table_make(size : Int) -> ImagefilterboxTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_box_table_len(s : ImagefilterboxTable) -> Int { s.size }

pub fn image_filter_box_table_get(s : ImagefilterboxTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_box_table_set(s : ImagefilterboxTable, i : Int, v : Double) -> ImagefilterboxTable {
  let result = image_filter_box_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_box_table_sum(s : ImagefilterboxTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_filter_box_table_mean(s : ImagefilterboxTable) -> Double {
  if s.size == 0 { 0.0 } else { image_filter_box_table_sum(s) / s.size.to_double() }
}

pub fn image_filter_box_table_scale(s : ImagefilterboxTable, f : Double) -> ImagefilterboxTable {
  let result = image_filter_box_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_box_table_add(a : ImagefilterboxTable, b : ImagefilterboxTable) -> ImagefilterboxTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_box_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_box_table_copy(s : ImagefilterboxTable) -> ImagefilterboxTable {
  let result = image_filter_box_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_box_table_fill(s : ImagefilterboxTable, v : Double) -> ImagefilterboxTable {
  let result = image_filter_box_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_box_table_min(s : ImagefilterboxTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_box_table_max(s : ImagefilterboxTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_box_table_to_string(s : ImagefilterboxTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefilterboxGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_box_graphn_make(size : Int) -> ImagefilterboxGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_box_graphn_len(s : ImagefilterboxGraphN) -> Int { s.size }

pub fn image_filter_box_graphn_get(s : ImagefilterboxGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_box_graphn_set(s : ImagefilterboxGraphN, i : Int, v : Double) -> ImagefilterboxGraphN {
  let result = image_filter_box_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_box_graphn_sum(s : ImagefilterboxGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_filter_box_graphn_mean(s : ImagefilterboxGraphN) -> Double {
  if s.size == 0 { 0.0 } else { image_filter_box_graphn_sum(s) / s.size.to_double() }
}

pub fn image_filter_box_graphn_scale(s : ImagefilterboxGraphN, f : Double) -> ImagefilterboxGraphN {
  let result = image_filter_box_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_box_graphn_add(a : ImagefilterboxGraphN, b : ImagefilterboxGraphN) -> ImagefilterboxGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_box_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_box_graphn_copy(s : ImagefilterboxGraphN) -> ImagefilterboxGraphN {
  let result = image_filter_box_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_box_graphn_fill(s : ImagefilterboxGraphN, v : Double) -> ImagefilterboxGraphN {
  let result = image_filter_box_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_box_graphn_min(s : ImagefilterboxGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_box_graphn_max(s : ImagefilterboxGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_box_graphn_to_string(s : ImagefilterboxGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefilterboxNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_box_node_make(size : Int) -> ImagefilterboxNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_box_node_len(s : ImagefilterboxNode) -> Int { s.size }

pub fn image_filter_box_node_get(s : ImagefilterboxNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_box_node_set(s : ImagefilterboxNode, i : Int, v : Double) -> ImagefilterboxNode {
  let result = image_filter_box_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_box_node_sum(s : ImagefilterboxNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_filter_box_node_mean(s : ImagefilterboxNode) -> Double {
  if s.size == 0 { 0.0 } else { image_filter_box_node_sum(s) / s.size.to_double() }
}

pub fn image_filter_box_node_scale(s : ImagefilterboxNode, f : Double) -> ImagefilterboxNode {
  let result = image_filter_box_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_box_node_add(a : ImagefilterboxNode, b : ImagefilterboxNode) -> ImagefilterboxNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_box_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_box_node_copy(s : ImagefilterboxNode) -> ImagefilterboxNode {
  let result = image_filter_box_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_box_node_fill(s : ImagefilterboxNode, v : Double) -> ImagefilterboxNode {
  let result = image_filter_box_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_box_node_min(s : ImagefilterboxNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_box_node_max(s : ImagefilterboxNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_box_node_to_string(s : ImagefilterboxNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefilterboxEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_box_edge_make(size : Int) -> ImagefilterboxEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_box_edge_len(s : ImagefilterboxEdge) -> Int { s.size }

pub fn image_filter_box_edge_get(s : ImagefilterboxEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_box_edge_set(s : ImagefilterboxEdge, i : Int, v : Double) -> ImagefilterboxEdge {
  let result = image_filter_box_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_box_edge_sum(s : ImagefilterboxEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_filter_box_edge_mean(s : ImagefilterboxEdge) -> Double {
  if s.size == 0 { 0.0 } else { image_filter_box_edge_sum(s) / s.size.to_double() }
}

pub fn image_filter_box_edge_scale(s : ImagefilterboxEdge, f : Double) -> ImagefilterboxEdge {
  let result = image_filter_box_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_box_edge_add(a : ImagefilterboxEdge, b : ImagefilterboxEdge) -> ImagefilterboxEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_box_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_box_edge_copy(s : ImagefilterboxEdge) -> ImagefilterboxEdge {
  let result = image_filter_box_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_box_edge_fill(s : ImagefilterboxEdge, v : Double) -> ImagefilterboxEdge {
  let result = image_filter_box_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_box_edge_min(s : ImagefilterboxEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_box_edge_max(s : ImagefilterboxEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_box_edge_to_string(s : ImagefilterboxEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefilterboxPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_box_path_make(size : Int) -> ImagefilterboxPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_box_path_len(s : ImagefilterboxPath) -> Int { s.size }

pub fn image_filter_box_path_get(s : ImagefilterboxPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_box_path_set(s : ImagefilterboxPath, i : Int, v : Double) -> ImagefilterboxPath {
  let result = image_filter_box_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_box_path_sum(s : ImagefilterboxPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_filter_box_path_mean(s : ImagefilterboxPath) -> Double {
  if s.size == 0 { 0.0 } else { image_filter_box_path_sum(s) / s.size.to_double() }
}

pub fn image_filter_box_path_scale(s : ImagefilterboxPath, f : Double) -> ImagefilterboxPath {
  let result = image_filter_box_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_box_path_add(a : ImagefilterboxPath, b : ImagefilterboxPath) -> ImagefilterboxPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_box_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_box_path_copy(s : ImagefilterboxPath) -> ImagefilterboxPath {
  let result = image_filter_box_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_box_path_fill(s : ImagefilterboxPath, v : Double) -> ImagefilterboxPath {
  let result = image_filter_box_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_box_path_min(s : ImagefilterboxPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_box_path_max(s : ImagefilterboxPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_box_path_to_string(s : ImagefilterboxPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefilterboxCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_box_cluster_make(size : Int) -> ImagefilterboxCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_box_cluster_len(s : ImagefilterboxCluster) -> Int { s.size }

pub fn image_filter_box_cluster_get(s : ImagefilterboxCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_box_cluster_set(s : ImagefilterboxCluster, i : Int, v : Double) -> ImagefilterboxCluster {
  let result = image_filter_box_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_box_cluster_sum(s : ImagefilterboxCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_filter_box_cluster_mean(s : ImagefilterboxCluster) -> Double {
  if s.size == 0 { 0.0 } else { image_filter_box_cluster_sum(s) / s.size.to_double() }
}

pub fn image_filter_box_cluster_scale(s : ImagefilterboxCluster, f : Double) -> ImagefilterboxCluster {
  let result = image_filter_box_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_box_cluster_add(a : ImagefilterboxCluster, b : ImagefilterboxCluster) -> ImagefilterboxCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_box_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_box_cluster_copy(s : ImagefilterboxCluster) -> ImagefilterboxCluster {
  let result = image_filter_box_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_box_cluster_fill(s : ImagefilterboxCluster, v : Double) -> ImagefilterboxCluster {
  let result = image_filter_box_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_box_cluster_min(s : ImagefilterboxCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_box_cluster_max(s : ImagefilterboxCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_box_cluster_to_string(s : ImagefilterboxCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefilterboxModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_box_model_make(size : Int) -> ImagefilterboxModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_box_model_len(s : ImagefilterboxModel) -> Int { s.size }

pub fn image_filter_box_model_get(s : ImagefilterboxModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_box_model_set(s : ImagefilterboxModel, i : Int, v : Double) -> ImagefilterboxModel {
  let result = image_filter_box_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_box_model_sum(s : ImagefilterboxModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_filter_box_model_mean(s : ImagefilterboxModel) -> Double {
  if s.size == 0 { 0.0 } else { image_filter_box_model_sum(s) / s.size.to_double() }
}

pub fn image_filter_box_model_scale(s : ImagefilterboxModel, f : Double) -> ImagefilterboxModel {
  let result = image_filter_box_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_box_model_add(a : ImagefilterboxModel, b : ImagefilterboxModel) -> ImagefilterboxModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_box_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_box_model_copy(s : ImagefilterboxModel) -> ImagefilterboxModel {
  let result = image_filter_box_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_box_model_fill(s : ImagefilterboxModel, v : Double) -> ImagefilterboxModel {
  let result = image_filter_box_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_box_model_min(s : ImagefilterboxModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_box_model_max(s : ImagefilterboxModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_box_model_to_string(s : ImagefilterboxModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefilterboxLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_box_layer_make(size : Int) -> ImagefilterboxLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_box_layer_len(s : ImagefilterboxLayer) -> Int { s.size }

pub fn image_filter_box_layer_get(s : ImagefilterboxLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_box_layer_set(s : ImagefilterboxLayer, i : Int, v : Double) -> ImagefilterboxLayer {
  let result = image_filter_box_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_box_layer_sum(s : ImagefilterboxLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_filter_box_layer_mean(s : ImagefilterboxLayer) -> Double {
  if s.size == 0 { 0.0 } else { image_filter_box_layer_sum(s) / s.size.to_double() }
}

pub fn image_filter_box_layer_scale(s : ImagefilterboxLayer, f : Double) -> ImagefilterboxLayer {
  let result = image_filter_box_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_box_layer_add(a : ImagefilterboxLayer, b : ImagefilterboxLayer) -> ImagefilterboxLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_box_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_box_layer_copy(s : ImagefilterboxLayer) -> ImagefilterboxLayer {
  let result = image_filter_box_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_box_layer_fill(s : ImagefilterboxLayer, v : Double) -> ImagefilterboxLayer {
  let result = image_filter_box_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_box_layer_min(s : ImagefilterboxLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_box_layer_max(s : ImagefilterboxLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_box_layer_to_string(s : ImagefilterboxLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefilterboxBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_box_buffer_make(size : Int) -> ImagefilterboxBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_box_buffer_len(s : ImagefilterboxBuffer) -> Int { s.size }

pub fn image_filter_box_buffer_get(s : ImagefilterboxBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_box_buffer_set(s : ImagefilterboxBuffer, i : Int, v : Double) -> ImagefilterboxBuffer {
  let result = image_filter_box_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_box_buffer_sum(s : ImagefilterboxBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_filter_box_buffer_mean(s : ImagefilterboxBuffer) -> Double {
  if s.size == 0 { 0.0 } else { image_filter_box_buffer_sum(s) / s.size.to_double() }
}

pub fn image_filter_box_buffer_scale(s : ImagefilterboxBuffer, f : Double) -> ImagefilterboxBuffer {
  let result = image_filter_box_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_box_buffer_add(a : ImagefilterboxBuffer, b : ImagefilterboxBuffer) -> ImagefilterboxBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_box_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_box_buffer_copy(s : ImagefilterboxBuffer) -> ImagefilterboxBuffer {
  let result = image_filter_box_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_box_buffer_fill(s : ImagefilterboxBuffer, v : Double) -> ImagefilterboxBuffer {
  let result = image_filter_box_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_box_buffer_min(s : ImagefilterboxBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_box_buffer_max(s : ImagefilterboxBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_box_buffer_to_string(s : ImagefilterboxBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefilterboxCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_box_cursor_make(size : Int) -> ImagefilterboxCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_box_cursor_len(s : ImagefilterboxCursor) -> Int { s.size }

pub fn image_filter_box_cursor_get(s : ImagefilterboxCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_box_cursor_set(s : ImagefilterboxCursor, i : Int, v : Double) -> ImagefilterboxCursor {
  let result = image_filter_box_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_box_cursor_sum(s : ImagefilterboxCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_filter_box_cursor_mean(s : ImagefilterboxCursor) -> Double {
  if s.size == 0 { 0.0 } else { image_filter_box_cursor_sum(s) / s.size.to_double() }
}

pub fn image_filter_box_cursor_scale(s : ImagefilterboxCursor, f : Double) -> ImagefilterboxCursor {
  let result = image_filter_box_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_box_cursor_add(a : ImagefilterboxCursor, b : ImagefilterboxCursor) -> ImagefilterboxCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_box_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_box_cursor_copy(s : ImagefilterboxCursor) -> ImagefilterboxCursor {
  let result = image_filter_box_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_box_cursor_fill(s : ImagefilterboxCursor, v : Double) -> ImagefilterboxCursor {
  let result = image_filter_box_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_box_cursor_min(s : ImagefilterboxCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_box_cursor_max(s : ImagefilterboxCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_box_cursor_to_string(s : ImagefilterboxCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefilterboxView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_box_view_make(size : Int) -> ImagefilterboxView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_box_view_len(s : ImagefilterboxView) -> Int { s.size }

pub fn image_filter_box_view_get(s : ImagefilterboxView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_box_view_set(s : ImagefilterboxView, i : Int, v : Double) -> ImagefilterboxView {
  let result = image_filter_box_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_box_view_sum(s : ImagefilterboxView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_filter_box_view_mean(s : ImagefilterboxView) -> Double {
  if s.size == 0 { 0.0 } else { image_filter_box_view_sum(s) / s.size.to_double() }
}

pub fn image_filter_box_view_scale(s : ImagefilterboxView, f : Double) -> ImagefilterboxView {
  let result = image_filter_box_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_box_view_add(a : ImagefilterboxView, b : ImagefilterboxView) -> ImagefilterboxView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_box_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_box_view_copy(s : ImagefilterboxView) -> ImagefilterboxView {
  let result = image_filter_box_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_box_view_fill(s : ImagefilterboxView, v : Double) -> ImagefilterboxView {
  let result = image_filter_box_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_box_view_min(s : ImagefilterboxView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_box_view_max(s : ImagefilterboxView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_box_view_to_string(s : ImagefilterboxView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefilterboxRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_box_range_make(size : Int) -> ImagefilterboxRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_box_range_len(s : ImagefilterboxRange) -> Int { s.size }

pub fn image_filter_box_range_get(s : ImagefilterboxRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_box_range_set(s : ImagefilterboxRange, i : Int, v : Double) -> ImagefilterboxRange {
  let result = image_filter_box_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_box_range_sum(s : ImagefilterboxRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_filter_box_range_mean(s : ImagefilterboxRange) -> Double {
  if s.size == 0 { 0.0 } else { image_filter_box_range_sum(s) / s.size.to_double() }
}

pub fn image_filter_box_range_scale(s : ImagefilterboxRange, f : Double) -> ImagefilterboxRange {
  let result = image_filter_box_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_box_range_add(a : ImagefilterboxRange, b : ImagefilterboxRange) -> ImagefilterboxRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_box_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_box_range_copy(s : ImagefilterboxRange) -> ImagefilterboxRange {
  let result = image_filter_box_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_box_range_fill(s : ImagefilterboxRange, v : Double) -> ImagefilterboxRange {
  let result = image_filter_box_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_box_range_min(s : ImagefilterboxRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_box_range_max(s : ImagefilterboxRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_box_range_to_string(s : ImagefilterboxRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefilterboxSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_box_slice_make(size : Int) -> ImagefilterboxSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_box_slice_len(s : ImagefilterboxSlice) -> Int { s.size }

pub fn image_filter_box_slice_get(s : ImagefilterboxSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_box_slice_set(s : ImagefilterboxSlice, i : Int, v : Double) -> ImagefilterboxSlice {
  let result = image_filter_box_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_box_slice_sum(s : ImagefilterboxSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_filter_box_slice_mean(s : ImagefilterboxSlice) -> Double {
  if s.size == 0 { 0.0 } else { image_filter_box_slice_sum(s) / s.size.to_double() }
}

pub fn image_filter_box_slice_scale(s : ImagefilterboxSlice, f : Double) -> ImagefilterboxSlice {
  let result = image_filter_box_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_box_slice_add(a : ImagefilterboxSlice, b : ImagefilterboxSlice) -> ImagefilterboxSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_box_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_box_slice_copy(s : ImagefilterboxSlice) -> ImagefilterboxSlice {
  let result = image_filter_box_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_box_slice_fill(s : ImagefilterboxSlice, v : Double) -> ImagefilterboxSlice {
  let result = image_filter_box_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_box_slice_min(s : ImagefilterboxSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_box_slice_max(s : ImagefilterboxSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_box_slice_to_string(s : ImagefilterboxSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn image_filter_box_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_filter_box_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_filter_box_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_filter_box_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_filter_box_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_filter_box_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_filter_box_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_filter_box_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_filter_box_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_filter_box_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_filter_box_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_filter_box_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_filter_box_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_filter_box_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_filter_box_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_filter_box_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_filter_box_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_filter_box_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_filter_box_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_filter_box_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_filter_box_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_filter_box_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_filter_box_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_filter_box_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_filter_box_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}


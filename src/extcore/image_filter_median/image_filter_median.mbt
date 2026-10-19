///===
/// extcore/image_filter_median

pub(all) struct ImagefiltermedianPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_filter_median_make_point(x : Double, y : Double) -> ImagefiltermedianPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_filter_median_make_point3(x : Double, y : Double, z : Double) -> ImagefiltermedianPoint {
  { x, y, z, label: 0 }
}

pub fn image_filter_median_point_x(pt : ImagefiltermedianPoint) -> Double { pt.x }

pub fn image_filter_median_point_y(pt : ImagefiltermedianPoint) -> Double { pt.y }

pub fn image_filter_median_point_z(pt : ImagefiltermedianPoint) -> Double { pt.z }

pub fn image_filter_median_point_label(pt : ImagefiltermedianPoint) -> Int { pt.label }

pub fn image_filter_median_point_dist(a : ImagefiltermedianPoint, b : ImagefiltermedianPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn image_filter_median_point_add(a : ImagefiltermedianPoint, b : ImagefiltermedianPoint) -> ImagefiltermedianPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn image_filter_median_point_sub(a : ImagefiltermedianPoint, b : ImagefiltermedianPoint) -> ImagefiltermedianPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn image_filter_median_point_scale(pt : ImagefiltermedianPoint, s : Double) -> ImagefiltermedianPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn image_filter_median_point_dot(a : ImagefiltermedianPoint, b : ImagefiltermedianPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn image_filter_median_point_cross(a : ImagefiltermedianPoint, b : ImagefiltermedianPoint) -> ImagefiltermedianPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn image_filter_median_point_norm(pt : ImagefiltermedianPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn image_filter_median_point_normalize(pt : ImagefiltermedianPoint) -> ImagefiltermedianPoint {
  let n = image_filter_median_point_norm(pt)
  if n < 0.0000001 { pt } else { image_filter_median_point_scale(pt, 1.0 / n) }
}

pub fn image_filter_median_point_negate(pt : ImagefiltermedianPoint) -> ImagefiltermedianPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn image_filter_median_point_mid(a : ImagefiltermedianPoint, b : ImagefiltermedianPoint) -> ImagefiltermedianPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn image_filter_median_point_lerp(a : ImagefiltermedianPoint, b : ImagefiltermedianPoint, t : Double) -> ImagefiltermedianPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn image_filter_median_point_to_string(pt : ImagefiltermedianPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct ImagefiltermedianSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_filter_median_make_series(vals : Array[Double], name : String) -> ImagefiltermedianSeries {
  { vals, name, meta: 0 }
}

pub fn image_filter_median_series_len(s : ImagefiltermedianSeries) -> Int { s.vals.length() }

pub fn image_filter_median_series_sum(s : ImagefiltermedianSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn image_filter_median_series_mean(s : ImagefiltermedianSeries) -> Double {
  let n = image_filter_median_series_len(s)
  if n == 0 { 0.0 } else { image_filter_median_series_sum(s) / n.to_double() }
}

pub fn image_filter_median_series_min(s : ImagefiltermedianSeries) -> Double {
  let n = image_filter_median_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn image_filter_median_series_max(s : ImagefiltermedianSeries) -> Double {
  let n = image_filter_median_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn image_filter_median_series_range(s : ImagefiltermedianSeries) -> Double {
  image_filter_median_series_max(s) - image_filter_median_series_min(s)
}

pub fn image_filter_median_series_var(s : ImagefiltermedianSeries) -> Double {
  let n = image_filter_median_series_len(s)
  if n == 0 { 0.0 } else {
    let m = image_filter_median_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn image_filter_median_series_std(s : ImagefiltermedianSeries) -> Double { @_common.sqrt(image_filter_median_series_var(s)) }

pub fn image_filter_median_series_median(s : ImagefiltermedianSeries) -> Double {
  let n = image_filter_median_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = image_filter_median_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn image_filter_median_series_scale(s : ImagefiltermedianSeries, f : Double) -> ImagefiltermedianSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn image_filter_median_series_add(a : ImagefiltermedianSeries, b : ImagefiltermedianSeries) -> ImagefiltermedianSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn image_filter_median_series_sub(a : ImagefiltermedianSeries, b : ImagefiltermedianSeries) -> ImagefiltermedianSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn image_filter_median_series_normalize(s : ImagefiltermedianSeries) -> ImagefiltermedianSeries {
  let mn = image_filter_median_series_min(s)
  let mx = image_filter_median_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn image_filter_median_series_cumsum(s : ImagefiltermedianSeries) -> ImagefiltermedianSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn image_filter_median_series_to_string(s : ImagefiltermedianSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagefiltermedianMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_filter_median_make_matrix(rows : Int, cols : Int, val : Double) -> ImagefiltermedianMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn image_filter_median_matrix_identity(n : Int) -> ImagefiltermedianMatrix {
  let m = image_filter_median_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn image_filter_median_matrix_get(m : ImagefiltermedianMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn image_filter_median_matrix_transpose(m : ImagefiltermedianMatrix) -> ImagefiltermedianMatrix {
  let result = image_filter_median_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn image_filter_median_matrix_add(a : ImagefiltermedianMatrix, b : ImagefiltermedianMatrix) -> ImagefiltermedianMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = image_filter_median_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn image_filter_median_matrix_scale(m : ImagefiltermedianMatrix, s : Double) -> ImagefiltermedianMatrix {
  let result = image_filter_median_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn image_filter_median_matrix_multiply(a : ImagefiltermedianMatrix, b : ImagefiltermedianMatrix) -> ImagefiltermedianMatrix {
  if a.cols != b.rows { return image_filter_median_make_matrix(a.rows, b.cols, 0.0) }
  let result = image_filter_median_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn image_filter_median_matrix_trace(m : ImagefiltermedianMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn image_filter_median_matrix_det(m : ImagefiltermedianMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn image_filter_median_matrix_norm(m : ImagefiltermedianMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn image_filter_median_matrix_to_string(m : ImagefiltermedianMatrix) -> String {
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

pub(all) struct ImagefiltermedianVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_filter_median_make_vector(comps : Array[Double]) -> ImagefiltermedianVector {
  { comps, dim: comps.length() }
}

pub fn image_filter_median_vector_zero(dim : Int) -> ImagefiltermedianVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn image_filter_median_vector_add(a : ImagefiltermedianVector, b : ImagefiltermedianVector) -> ImagefiltermedianVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn image_filter_median_vector_sub(a : ImagefiltermedianVector, b : ImagefiltermedianVector) -> ImagefiltermedianVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn image_filter_median_vector_scale(v : ImagefiltermedianVector, s : Double) -> ImagefiltermedianVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn image_filter_median_vector_dot(a : ImagefiltermedianVector, b : ImagefiltermedianVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn image_filter_median_vector_norm(v : ImagefiltermedianVector) -> Double { @_common.sqrt(image_filter_median_vector_dot(v, v)) }

pub fn image_filter_median_vector_normalize(v : ImagefiltermedianVector) -> ImagefiltermedianVector {
  let n = image_filter_median_vector_norm(v)
  if n < 0.0000001 { v } else { image_filter_median_vector_scale(v, 1.0 / n) }
}

pub fn image_filter_median_vector_dist(a : ImagefiltermedianVector, b : ImagefiltermedianVector) -> Double {
  image_filter_median_vector_norm(image_filter_median_vector_sub(a, b))
}

pub fn image_filter_median_vector_to_string(v : ImagefiltermedianVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn image_filter_median_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn image_filter_median_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = image_filter_median_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn image_filter_median_std(data : Array[Double]) -> Double { @_common.sqrt(image_filter_median_var(data)) }

pub fn image_filter_median_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = image_filter_median_mean(a); let mb = image_filter_median_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn image_filter_median_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = image_filter_median_std(a); let sb = image_filter_median_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { image_filter_median_cov(a, b) / (sa * sb) }
}

pub fn image_filter_median_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = image_filter_median_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn image_filter_median_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn image_filter_median_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn image_filter_median_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(image_filter_median_mse(pred, labels))
}

pub fn image_filter_median_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn image_filter_median_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = image_filter_median_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn image_filter_median_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn image_filter_median_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn image_filter_median_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = image_filter_median_precision(pred, labels, pos); let r = image_filter_median_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn image_filter_median_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn image_filter_median_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = image_filter_median_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn image_filter_median_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn image_filter_median_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn image_filter_median_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = image_filter_median_gcd(a, b)
    (a / g) * b
  }
}

pub fn image_filter_median_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn image_filter_median_fibonacci(n : Int) -> Int {
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

pub fn image_filter_median_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = image_filter_median_min(data); let mx = image_filter_median_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn image_filter_median_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = image_filter_median_mean(data); let sd = image_filter_median_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn image_filter_median_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn image_filter_median_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn image_filter_median_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn image_filter_median_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn image_filter_median_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn image_filter_median_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct ImagefiltermedianFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_median_frame_make(size : Int) -> ImagefiltermedianFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_median_frame_len(s : ImagefiltermedianFrame) -> Int { s.size }

pub fn image_filter_median_frame_get(s : ImagefiltermedianFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_median_frame_set(s : ImagefiltermedianFrame, i : Int, v : Double) -> ImagefiltermedianFrame {
  let result = image_filter_median_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_median_frame_sum(s : ImagefiltermedianFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_filter_median_frame_mean(s : ImagefiltermedianFrame) -> Double {
  if s.size == 0 { 0.0 } else { image_filter_median_frame_sum(s) / s.size.to_double() }
}

pub fn image_filter_median_frame_scale(s : ImagefiltermedianFrame, f : Double) -> ImagefiltermedianFrame {
  let result = image_filter_median_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_median_frame_add(a : ImagefiltermedianFrame, b : ImagefiltermedianFrame) -> ImagefiltermedianFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_median_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_median_frame_copy(s : ImagefiltermedianFrame) -> ImagefiltermedianFrame {
  let result = image_filter_median_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_median_frame_fill(s : ImagefiltermedianFrame, v : Double) -> ImagefiltermedianFrame {
  let result = image_filter_median_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_median_frame_min(s : ImagefiltermedianFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_median_frame_max(s : ImagefiltermedianFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_median_frame_to_string(s : ImagefiltermedianFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltermedianTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_median_table_make(size : Int) -> ImagefiltermedianTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_median_table_len(s : ImagefiltermedianTable) -> Int { s.size }

pub fn image_filter_median_table_get(s : ImagefiltermedianTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_median_table_set(s : ImagefiltermedianTable, i : Int, v : Double) -> ImagefiltermedianTable {
  let result = image_filter_median_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_median_table_sum(s : ImagefiltermedianTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_filter_median_table_mean(s : ImagefiltermedianTable) -> Double {
  if s.size == 0 { 0.0 } else { image_filter_median_table_sum(s) / s.size.to_double() }
}

pub fn image_filter_median_table_scale(s : ImagefiltermedianTable, f : Double) -> ImagefiltermedianTable {
  let result = image_filter_median_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_median_table_add(a : ImagefiltermedianTable, b : ImagefiltermedianTable) -> ImagefiltermedianTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_median_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_median_table_copy(s : ImagefiltermedianTable) -> ImagefiltermedianTable {
  let result = image_filter_median_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_median_table_fill(s : ImagefiltermedianTable, v : Double) -> ImagefiltermedianTable {
  let result = image_filter_median_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_median_table_min(s : ImagefiltermedianTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_median_table_max(s : ImagefiltermedianTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_median_table_to_string(s : ImagefiltermedianTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltermedianGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_median_graphn_make(size : Int) -> ImagefiltermedianGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_median_graphn_len(s : ImagefiltermedianGraphN) -> Int { s.size }

pub fn image_filter_median_graphn_get(s : ImagefiltermedianGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_median_graphn_set(s : ImagefiltermedianGraphN, i : Int, v : Double) -> ImagefiltermedianGraphN {
  let result = image_filter_median_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_median_graphn_sum(s : ImagefiltermedianGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_filter_median_graphn_mean(s : ImagefiltermedianGraphN) -> Double {
  if s.size == 0 { 0.0 } else { image_filter_median_graphn_sum(s) / s.size.to_double() }
}

pub fn image_filter_median_graphn_scale(s : ImagefiltermedianGraphN, f : Double) -> ImagefiltermedianGraphN {
  let result = image_filter_median_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_median_graphn_add(a : ImagefiltermedianGraphN, b : ImagefiltermedianGraphN) -> ImagefiltermedianGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_median_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_median_graphn_copy(s : ImagefiltermedianGraphN) -> ImagefiltermedianGraphN {
  let result = image_filter_median_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_median_graphn_fill(s : ImagefiltermedianGraphN, v : Double) -> ImagefiltermedianGraphN {
  let result = image_filter_median_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_median_graphn_min(s : ImagefiltermedianGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_median_graphn_max(s : ImagefiltermedianGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_median_graphn_to_string(s : ImagefiltermedianGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltermedianNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_median_node_make(size : Int) -> ImagefiltermedianNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_median_node_len(s : ImagefiltermedianNode) -> Int { s.size }

pub fn image_filter_median_node_get(s : ImagefiltermedianNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_median_node_set(s : ImagefiltermedianNode, i : Int, v : Double) -> ImagefiltermedianNode {
  let result = image_filter_median_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_median_node_sum(s : ImagefiltermedianNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_filter_median_node_mean(s : ImagefiltermedianNode) -> Double {
  if s.size == 0 { 0.0 } else { image_filter_median_node_sum(s) / s.size.to_double() }
}

pub fn image_filter_median_node_scale(s : ImagefiltermedianNode, f : Double) -> ImagefiltermedianNode {
  let result = image_filter_median_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_median_node_add(a : ImagefiltermedianNode, b : ImagefiltermedianNode) -> ImagefiltermedianNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_median_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_median_node_copy(s : ImagefiltermedianNode) -> ImagefiltermedianNode {
  let result = image_filter_median_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_median_node_fill(s : ImagefiltermedianNode, v : Double) -> ImagefiltermedianNode {
  let result = image_filter_median_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_median_node_min(s : ImagefiltermedianNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_median_node_max(s : ImagefiltermedianNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_median_node_to_string(s : ImagefiltermedianNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltermedianEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_median_edge_make(size : Int) -> ImagefiltermedianEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_median_edge_len(s : ImagefiltermedianEdge) -> Int { s.size }

pub fn image_filter_median_edge_get(s : ImagefiltermedianEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_median_edge_set(s : ImagefiltermedianEdge, i : Int, v : Double) -> ImagefiltermedianEdge {
  let result = image_filter_median_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_median_edge_sum(s : ImagefiltermedianEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_filter_median_edge_mean(s : ImagefiltermedianEdge) -> Double {
  if s.size == 0 { 0.0 } else { image_filter_median_edge_sum(s) / s.size.to_double() }
}

pub fn image_filter_median_edge_scale(s : ImagefiltermedianEdge, f : Double) -> ImagefiltermedianEdge {
  let result = image_filter_median_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_median_edge_add(a : ImagefiltermedianEdge, b : ImagefiltermedianEdge) -> ImagefiltermedianEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_median_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_median_edge_copy(s : ImagefiltermedianEdge) -> ImagefiltermedianEdge {
  let result = image_filter_median_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_median_edge_fill(s : ImagefiltermedianEdge, v : Double) -> ImagefiltermedianEdge {
  let result = image_filter_median_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_median_edge_min(s : ImagefiltermedianEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_median_edge_max(s : ImagefiltermedianEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_median_edge_to_string(s : ImagefiltermedianEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltermedianPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_median_path_make(size : Int) -> ImagefiltermedianPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_median_path_len(s : ImagefiltermedianPath) -> Int { s.size }

pub fn image_filter_median_path_get(s : ImagefiltermedianPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_median_path_set(s : ImagefiltermedianPath, i : Int, v : Double) -> ImagefiltermedianPath {
  let result = image_filter_median_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_median_path_sum(s : ImagefiltermedianPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_filter_median_path_mean(s : ImagefiltermedianPath) -> Double {
  if s.size == 0 { 0.0 } else { image_filter_median_path_sum(s) / s.size.to_double() }
}

pub fn image_filter_median_path_scale(s : ImagefiltermedianPath, f : Double) -> ImagefiltermedianPath {
  let result = image_filter_median_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_median_path_add(a : ImagefiltermedianPath, b : ImagefiltermedianPath) -> ImagefiltermedianPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_median_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_median_path_copy(s : ImagefiltermedianPath) -> ImagefiltermedianPath {
  let result = image_filter_median_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_median_path_fill(s : ImagefiltermedianPath, v : Double) -> ImagefiltermedianPath {
  let result = image_filter_median_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_median_path_min(s : ImagefiltermedianPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_median_path_max(s : ImagefiltermedianPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_median_path_to_string(s : ImagefiltermedianPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltermedianCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_median_cluster_make(size : Int) -> ImagefiltermedianCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_median_cluster_len(s : ImagefiltermedianCluster) -> Int { s.size }

pub fn image_filter_median_cluster_get(s : ImagefiltermedianCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_median_cluster_set(s : ImagefiltermedianCluster, i : Int, v : Double) -> ImagefiltermedianCluster {
  let result = image_filter_median_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_median_cluster_sum(s : ImagefiltermedianCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_filter_median_cluster_mean(s : ImagefiltermedianCluster) -> Double {
  if s.size == 0 { 0.0 } else { image_filter_median_cluster_sum(s) / s.size.to_double() }
}

pub fn image_filter_median_cluster_scale(s : ImagefiltermedianCluster, f : Double) -> ImagefiltermedianCluster {
  let result = image_filter_median_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_median_cluster_add(a : ImagefiltermedianCluster, b : ImagefiltermedianCluster) -> ImagefiltermedianCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_median_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_median_cluster_copy(s : ImagefiltermedianCluster) -> ImagefiltermedianCluster {
  let result = image_filter_median_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_median_cluster_fill(s : ImagefiltermedianCluster, v : Double) -> ImagefiltermedianCluster {
  let result = image_filter_median_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_median_cluster_min(s : ImagefiltermedianCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_median_cluster_max(s : ImagefiltermedianCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_median_cluster_to_string(s : ImagefiltermedianCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltermedianModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_median_model_make(size : Int) -> ImagefiltermedianModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_median_model_len(s : ImagefiltermedianModel) -> Int { s.size }

pub fn image_filter_median_model_get(s : ImagefiltermedianModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_median_model_set(s : ImagefiltermedianModel, i : Int, v : Double) -> ImagefiltermedianModel {
  let result = image_filter_median_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_median_model_sum(s : ImagefiltermedianModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_filter_median_model_mean(s : ImagefiltermedianModel) -> Double {
  if s.size == 0 { 0.0 } else { image_filter_median_model_sum(s) / s.size.to_double() }
}

pub fn image_filter_median_model_scale(s : ImagefiltermedianModel, f : Double) -> ImagefiltermedianModel {
  let result = image_filter_median_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_median_model_add(a : ImagefiltermedianModel, b : ImagefiltermedianModel) -> ImagefiltermedianModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_median_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_median_model_copy(s : ImagefiltermedianModel) -> ImagefiltermedianModel {
  let result = image_filter_median_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_median_model_fill(s : ImagefiltermedianModel, v : Double) -> ImagefiltermedianModel {
  let result = image_filter_median_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_median_model_min(s : ImagefiltermedianModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_median_model_max(s : ImagefiltermedianModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_median_model_to_string(s : ImagefiltermedianModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltermedianLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_median_layer_make(size : Int) -> ImagefiltermedianLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_median_layer_len(s : ImagefiltermedianLayer) -> Int { s.size }

pub fn image_filter_median_layer_get(s : ImagefiltermedianLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_median_layer_set(s : ImagefiltermedianLayer, i : Int, v : Double) -> ImagefiltermedianLayer {
  let result = image_filter_median_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_median_layer_sum(s : ImagefiltermedianLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_filter_median_layer_mean(s : ImagefiltermedianLayer) -> Double {
  if s.size == 0 { 0.0 } else { image_filter_median_layer_sum(s) / s.size.to_double() }
}

pub fn image_filter_median_layer_scale(s : ImagefiltermedianLayer, f : Double) -> ImagefiltermedianLayer {
  let result = image_filter_median_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_median_layer_add(a : ImagefiltermedianLayer, b : ImagefiltermedianLayer) -> ImagefiltermedianLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_median_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_median_layer_copy(s : ImagefiltermedianLayer) -> ImagefiltermedianLayer {
  let result = image_filter_median_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_median_layer_fill(s : ImagefiltermedianLayer, v : Double) -> ImagefiltermedianLayer {
  let result = image_filter_median_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_median_layer_min(s : ImagefiltermedianLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_median_layer_max(s : ImagefiltermedianLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_median_layer_to_string(s : ImagefiltermedianLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltermedianBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_median_buffer_make(size : Int) -> ImagefiltermedianBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_median_buffer_len(s : ImagefiltermedianBuffer) -> Int { s.size }

pub fn image_filter_median_buffer_get(s : ImagefiltermedianBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_median_buffer_set(s : ImagefiltermedianBuffer, i : Int, v : Double) -> ImagefiltermedianBuffer {
  let result = image_filter_median_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_median_buffer_sum(s : ImagefiltermedianBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_filter_median_buffer_mean(s : ImagefiltermedianBuffer) -> Double {
  if s.size == 0 { 0.0 } else { image_filter_median_buffer_sum(s) / s.size.to_double() }
}

pub fn image_filter_median_buffer_scale(s : ImagefiltermedianBuffer, f : Double) -> ImagefiltermedianBuffer {
  let result = image_filter_median_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_median_buffer_add(a : ImagefiltermedianBuffer, b : ImagefiltermedianBuffer) -> ImagefiltermedianBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_median_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_median_buffer_copy(s : ImagefiltermedianBuffer) -> ImagefiltermedianBuffer {
  let result = image_filter_median_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_median_buffer_fill(s : ImagefiltermedianBuffer, v : Double) -> ImagefiltermedianBuffer {
  let result = image_filter_median_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_median_buffer_min(s : ImagefiltermedianBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_median_buffer_max(s : ImagefiltermedianBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_median_buffer_to_string(s : ImagefiltermedianBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltermedianCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_median_cursor_make(size : Int) -> ImagefiltermedianCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_median_cursor_len(s : ImagefiltermedianCursor) -> Int { s.size }

pub fn image_filter_median_cursor_get(s : ImagefiltermedianCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_median_cursor_set(s : ImagefiltermedianCursor, i : Int, v : Double) -> ImagefiltermedianCursor {
  let result = image_filter_median_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_median_cursor_sum(s : ImagefiltermedianCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_filter_median_cursor_mean(s : ImagefiltermedianCursor) -> Double {
  if s.size == 0 { 0.0 } else { image_filter_median_cursor_sum(s) / s.size.to_double() }
}

pub fn image_filter_median_cursor_scale(s : ImagefiltermedianCursor, f : Double) -> ImagefiltermedianCursor {
  let result = image_filter_median_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_median_cursor_add(a : ImagefiltermedianCursor, b : ImagefiltermedianCursor) -> ImagefiltermedianCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_median_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_median_cursor_copy(s : ImagefiltermedianCursor) -> ImagefiltermedianCursor {
  let result = image_filter_median_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_median_cursor_fill(s : ImagefiltermedianCursor, v : Double) -> ImagefiltermedianCursor {
  let result = image_filter_median_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_median_cursor_min(s : ImagefiltermedianCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_median_cursor_max(s : ImagefiltermedianCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_median_cursor_to_string(s : ImagefiltermedianCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltermedianView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_median_view_make(size : Int) -> ImagefiltermedianView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_median_view_len(s : ImagefiltermedianView) -> Int { s.size }

pub fn image_filter_median_view_get(s : ImagefiltermedianView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_median_view_set(s : ImagefiltermedianView, i : Int, v : Double) -> ImagefiltermedianView {
  let result = image_filter_median_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_median_view_sum(s : ImagefiltermedianView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_filter_median_view_mean(s : ImagefiltermedianView) -> Double {
  if s.size == 0 { 0.0 } else { image_filter_median_view_sum(s) / s.size.to_double() }
}

pub fn image_filter_median_view_scale(s : ImagefiltermedianView, f : Double) -> ImagefiltermedianView {
  let result = image_filter_median_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_median_view_add(a : ImagefiltermedianView, b : ImagefiltermedianView) -> ImagefiltermedianView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_median_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_median_view_copy(s : ImagefiltermedianView) -> ImagefiltermedianView {
  let result = image_filter_median_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_median_view_fill(s : ImagefiltermedianView, v : Double) -> ImagefiltermedianView {
  let result = image_filter_median_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_median_view_min(s : ImagefiltermedianView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_median_view_max(s : ImagefiltermedianView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_median_view_to_string(s : ImagefiltermedianView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltermedianRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_median_range_make(size : Int) -> ImagefiltermedianRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_median_range_len(s : ImagefiltermedianRange) -> Int { s.size }

pub fn image_filter_median_range_get(s : ImagefiltermedianRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_median_range_set(s : ImagefiltermedianRange, i : Int, v : Double) -> ImagefiltermedianRange {
  let result = image_filter_median_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_median_range_sum(s : ImagefiltermedianRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_filter_median_range_mean(s : ImagefiltermedianRange) -> Double {
  if s.size == 0 { 0.0 } else { image_filter_median_range_sum(s) / s.size.to_double() }
}

pub fn image_filter_median_range_scale(s : ImagefiltermedianRange, f : Double) -> ImagefiltermedianRange {
  let result = image_filter_median_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_median_range_add(a : ImagefiltermedianRange, b : ImagefiltermedianRange) -> ImagefiltermedianRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_median_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_median_range_copy(s : ImagefiltermedianRange) -> ImagefiltermedianRange {
  let result = image_filter_median_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_median_range_fill(s : ImagefiltermedianRange, v : Double) -> ImagefiltermedianRange {
  let result = image_filter_median_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_median_range_min(s : ImagefiltermedianRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_median_range_max(s : ImagefiltermedianRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_median_range_to_string(s : ImagefiltermedianRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltermedianSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_median_slice_make(size : Int) -> ImagefiltermedianSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_median_slice_len(s : ImagefiltermedianSlice) -> Int { s.size }

pub fn image_filter_median_slice_get(s : ImagefiltermedianSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_median_slice_set(s : ImagefiltermedianSlice, i : Int, v : Double) -> ImagefiltermedianSlice {
  let result = image_filter_median_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_median_slice_sum(s : ImagefiltermedianSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_filter_median_slice_mean(s : ImagefiltermedianSlice) -> Double {
  if s.size == 0 { 0.0 } else { image_filter_median_slice_sum(s) / s.size.to_double() }
}

pub fn image_filter_median_slice_scale(s : ImagefiltermedianSlice, f : Double) -> ImagefiltermedianSlice {
  let result = image_filter_median_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_median_slice_add(a : ImagefiltermedianSlice, b : ImagefiltermedianSlice) -> ImagefiltermedianSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_median_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_median_slice_copy(s : ImagefiltermedianSlice) -> ImagefiltermedianSlice {
  let result = image_filter_median_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_median_slice_fill(s : ImagefiltermedianSlice, v : Double) -> ImagefiltermedianSlice {
  let result = image_filter_median_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_median_slice_min(s : ImagefiltermedianSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_median_slice_max(s : ImagefiltermedianSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_median_slice_to_string(s : ImagefiltermedianSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


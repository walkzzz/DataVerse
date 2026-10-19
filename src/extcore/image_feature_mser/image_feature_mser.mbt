///===
/// extcore/image_feature_mser

pub(all) struct ImagefeaturemserPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_feature_mser_make_point(x : Double, y : Double) -> ImagefeaturemserPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_feature_mser_make_point3(x : Double, y : Double, z : Double) -> ImagefeaturemserPoint {
  { x, y, z, label: 0 }
}

pub fn image_feature_mser_point_x(pt : ImagefeaturemserPoint) -> Double { pt.x }

pub fn image_feature_mser_point_y(pt : ImagefeaturemserPoint) -> Double { pt.y }

pub fn image_feature_mser_point_z(pt : ImagefeaturemserPoint) -> Double { pt.z }

pub fn image_feature_mser_point_label(pt : ImagefeaturemserPoint) -> Int { pt.label }

pub fn image_feature_mser_point_dist(a : ImagefeaturemserPoint, b : ImagefeaturemserPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn image_feature_mser_point_add(a : ImagefeaturemserPoint, b : ImagefeaturemserPoint) -> ImagefeaturemserPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn image_feature_mser_point_sub(a : ImagefeaturemserPoint, b : ImagefeaturemserPoint) -> ImagefeaturemserPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn image_feature_mser_point_scale(pt : ImagefeaturemserPoint, s : Double) -> ImagefeaturemserPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn image_feature_mser_point_dot(a : ImagefeaturemserPoint, b : ImagefeaturemserPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn image_feature_mser_point_cross(a : ImagefeaturemserPoint, b : ImagefeaturemserPoint) -> ImagefeaturemserPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn image_feature_mser_point_norm(pt : ImagefeaturemserPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn image_feature_mser_point_normalize(pt : ImagefeaturemserPoint) -> ImagefeaturemserPoint {
  let n = image_feature_mser_point_norm(pt)
  if n < 0.0000001 { pt } else { image_feature_mser_point_scale(pt, 1.0 / n) }
}

pub fn image_feature_mser_point_negate(pt : ImagefeaturemserPoint) -> ImagefeaturemserPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn image_feature_mser_point_mid(a : ImagefeaturemserPoint, b : ImagefeaturemserPoint) -> ImagefeaturemserPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn image_feature_mser_point_lerp(a : ImagefeaturemserPoint, b : ImagefeaturemserPoint, t : Double) -> ImagefeaturemserPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn image_feature_mser_point_to_string(pt : ImagefeaturemserPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct ImagefeaturemserSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_feature_mser_make_series(vals : Array[Double], name : String) -> ImagefeaturemserSeries {
  { vals, name, meta: 0 }
}

pub fn image_feature_mser_series_len(s : ImagefeaturemserSeries) -> Int { s.vals.length() }

pub fn image_feature_mser_series_sum(s : ImagefeaturemserSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn image_feature_mser_series_mean(s : ImagefeaturemserSeries) -> Double {
  let n = image_feature_mser_series_len(s)
  if n == 0 { 0.0 } else { image_feature_mser_series_sum(s) / n.to_double() }
}

pub fn image_feature_mser_series_min(s : ImagefeaturemserSeries) -> Double {
  let n = image_feature_mser_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn image_feature_mser_series_max(s : ImagefeaturemserSeries) -> Double {
  let n = image_feature_mser_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn image_feature_mser_series_range(s : ImagefeaturemserSeries) -> Double {
  image_feature_mser_series_max(s) - image_feature_mser_series_min(s)
}

pub fn image_feature_mser_series_var(s : ImagefeaturemserSeries) -> Double {
  let n = image_feature_mser_series_len(s)
  if n == 0 { 0.0 } else {
    let m = image_feature_mser_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn image_feature_mser_series_std(s : ImagefeaturemserSeries) -> Double { @_common.sqrt(image_feature_mser_series_var(s)) }

pub fn image_feature_mser_series_median(s : ImagefeaturemserSeries) -> Double {
  let n = image_feature_mser_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = image_feature_mser_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn image_feature_mser_series_scale(s : ImagefeaturemserSeries, f : Double) -> ImagefeaturemserSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn image_feature_mser_series_add(a : ImagefeaturemserSeries, b : ImagefeaturemserSeries) -> ImagefeaturemserSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn image_feature_mser_series_sub(a : ImagefeaturemserSeries, b : ImagefeaturemserSeries) -> ImagefeaturemserSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn image_feature_mser_series_normalize(s : ImagefeaturemserSeries) -> ImagefeaturemserSeries {
  let mn = image_feature_mser_series_min(s)
  let mx = image_feature_mser_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn image_feature_mser_series_cumsum(s : ImagefeaturemserSeries) -> ImagefeaturemserSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn image_feature_mser_series_to_string(s : ImagefeaturemserSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagefeaturemserMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_feature_mser_make_matrix(rows : Int, cols : Int, val : Double) -> ImagefeaturemserMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn image_feature_mser_matrix_identity(n : Int) -> ImagefeaturemserMatrix {
  let m = image_feature_mser_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn image_feature_mser_matrix_get(m : ImagefeaturemserMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn image_feature_mser_matrix_transpose(m : ImagefeaturemserMatrix) -> ImagefeaturemserMatrix {
  let result = image_feature_mser_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn image_feature_mser_matrix_add(a : ImagefeaturemserMatrix, b : ImagefeaturemserMatrix) -> ImagefeaturemserMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = image_feature_mser_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn image_feature_mser_matrix_scale(m : ImagefeaturemserMatrix, s : Double) -> ImagefeaturemserMatrix {
  let result = image_feature_mser_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn image_feature_mser_matrix_multiply(a : ImagefeaturemserMatrix, b : ImagefeaturemserMatrix) -> ImagefeaturemserMatrix {
  if a.cols != b.rows { return image_feature_mser_make_matrix(a.rows, b.cols, 0.0) }
  let result = image_feature_mser_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn image_feature_mser_matrix_trace(m : ImagefeaturemserMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn image_feature_mser_matrix_det(m : ImagefeaturemserMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn image_feature_mser_matrix_norm(m : ImagefeaturemserMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn image_feature_mser_matrix_to_string(m : ImagefeaturemserMatrix) -> String {
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

pub(all) struct ImagefeaturemserVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_feature_mser_make_vector(comps : Array[Double]) -> ImagefeaturemserVector {
  { comps, dim: comps.length() }
}

pub fn image_feature_mser_vector_zero(dim : Int) -> ImagefeaturemserVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn image_feature_mser_vector_add(a : ImagefeaturemserVector, b : ImagefeaturemserVector) -> ImagefeaturemserVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn image_feature_mser_vector_sub(a : ImagefeaturemserVector, b : ImagefeaturemserVector) -> ImagefeaturemserVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn image_feature_mser_vector_scale(v : ImagefeaturemserVector, s : Double) -> ImagefeaturemserVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn image_feature_mser_vector_dot(a : ImagefeaturemserVector, b : ImagefeaturemserVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn image_feature_mser_vector_norm(v : ImagefeaturemserVector) -> Double { @_common.sqrt(image_feature_mser_vector_dot(v, v)) }

pub fn image_feature_mser_vector_normalize(v : ImagefeaturemserVector) -> ImagefeaturemserVector {
  let n = image_feature_mser_vector_norm(v)
  if n < 0.0000001 { v } else { image_feature_mser_vector_scale(v, 1.0 / n) }
}

pub fn image_feature_mser_vector_dist(a : ImagefeaturemserVector, b : ImagefeaturemserVector) -> Double {
  image_feature_mser_vector_norm(image_feature_mser_vector_sub(a, b))
}

pub fn image_feature_mser_vector_to_string(v : ImagefeaturemserVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn image_feature_mser_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn image_feature_mser_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = image_feature_mser_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn image_feature_mser_std(data : Array[Double]) -> Double { @_common.sqrt(image_feature_mser_var(data)) }

pub fn image_feature_mser_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = image_feature_mser_mean(a); let mb = image_feature_mser_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn image_feature_mser_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = image_feature_mser_std(a); let sb = image_feature_mser_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { image_feature_mser_cov(a, b) / (sa * sb) }
}

pub fn image_feature_mser_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = image_feature_mser_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn image_feature_mser_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn image_feature_mser_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn image_feature_mser_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(image_feature_mser_mse(pred, labels))
}

pub fn image_feature_mser_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn image_feature_mser_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = image_feature_mser_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn image_feature_mser_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn image_feature_mser_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn image_feature_mser_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = image_feature_mser_precision(pred, labels, pos); let r = image_feature_mser_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn image_feature_mser_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn image_feature_mser_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = image_feature_mser_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn image_feature_mser_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn image_feature_mser_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn image_feature_mser_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = image_feature_mser_gcd(a, b)
    (a / g) * b
  }
}

pub fn image_feature_mser_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn image_feature_mser_fibonacci(n : Int) -> Int {
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

pub fn image_feature_mser_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = image_feature_mser_min(data); let mx = image_feature_mser_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn image_feature_mser_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = image_feature_mser_mean(data); let sd = image_feature_mser_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn image_feature_mser_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn image_feature_mser_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn image_feature_mser_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn image_feature_mser_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn image_feature_mser_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn image_feature_mser_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct ImagefeaturemserFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_mser_frame_make(size : Int) -> ImagefeaturemserFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_mser_frame_len(s : ImagefeaturemserFrame) -> Int { s.size }

pub fn image_feature_mser_frame_get(s : ImagefeaturemserFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_mser_frame_set(s : ImagefeaturemserFrame, i : Int, v : Double) -> ImagefeaturemserFrame {
  let result = image_feature_mser_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_mser_frame_sum(s : ImagefeaturemserFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_mser_frame_mean(s : ImagefeaturemserFrame) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_mser_frame_sum(s) / s.size.to_double() }
}

pub fn image_feature_mser_frame_scale(s : ImagefeaturemserFrame, f : Double) -> ImagefeaturemserFrame {
  let result = image_feature_mser_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_mser_frame_add(a : ImagefeaturemserFrame, b : ImagefeaturemserFrame) -> ImagefeaturemserFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_mser_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_mser_frame_copy(s : ImagefeaturemserFrame) -> ImagefeaturemserFrame {
  let result = image_feature_mser_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_mser_frame_fill(s : ImagefeaturemserFrame, v : Double) -> ImagefeaturemserFrame {
  let result = image_feature_mser_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_mser_frame_min(s : ImagefeaturemserFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_mser_frame_max(s : ImagefeaturemserFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_mser_frame_to_string(s : ImagefeaturemserFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturemserTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_mser_table_make(size : Int) -> ImagefeaturemserTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_mser_table_len(s : ImagefeaturemserTable) -> Int { s.size }

pub fn image_feature_mser_table_get(s : ImagefeaturemserTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_mser_table_set(s : ImagefeaturemserTable, i : Int, v : Double) -> ImagefeaturemserTable {
  let result = image_feature_mser_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_mser_table_sum(s : ImagefeaturemserTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_mser_table_mean(s : ImagefeaturemserTable) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_mser_table_sum(s) / s.size.to_double() }
}

pub fn image_feature_mser_table_scale(s : ImagefeaturemserTable, f : Double) -> ImagefeaturemserTable {
  let result = image_feature_mser_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_mser_table_add(a : ImagefeaturemserTable, b : ImagefeaturemserTable) -> ImagefeaturemserTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_mser_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_mser_table_copy(s : ImagefeaturemserTable) -> ImagefeaturemserTable {
  let result = image_feature_mser_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_mser_table_fill(s : ImagefeaturemserTable, v : Double) -> ImagefeaturemserTable {
  let result = image_feature_mser_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_mser_table_min(s : ImagefeaturemserTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_mser_table_max(s : ImagefeaturemserTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_mser_table_to_string(s : ImagefeaturemserTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturemserGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_mser_graphn_make(size : Int) -> ImagefeaturemserGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_mser_graphn_len(s : ImagefeaturemserGraphN) -> Int { s.size }

pub fn image_feature_mser_graphn_get(s : ImagefeaturemserGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_mser_graphn_set(s : ImagefeaturemserGraphN, i : Int, v : Double) -> ImagefeaturemserGraphN {
  let result = image_feature_mser_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_mser_graphn_sum(s : ImagefeaturemserGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_mser_graphn_mean(s : ImagefeaturemserGraphN) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_mser_graphn_sum(s) / s.size.to_double() }
}

pub fn image_feature_mser_graphn_scale(s : ImagefeaturemserGraphN, f : Double) -> ImagefeaturemserGraphN {
  let result = image_feature_mser_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_mser_graphn_add(a : ImagefeaturemserGraphN, b : ImagefeaturemserGraphN) -> ImagefeaturemserGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_mser_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_mser_graphn_copy(s : ImagefeaturemserGraphN) -> ImagefeaturemserGraphN {
  let result = image_feature_mser_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_mser_graphn_fill(s : ImagefeaturemserGraphN, v : Double) -> ImagefeaturemserGraphN {
  let result = image_feature_mser_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_mser_graphn_min(s : ImagefeaturemserGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_mser_graphn_max(s : ImagefeaturemserGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_mser_graphn_to_string(s : ImagefeaturemserGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturemserNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_mser_node_make(size : Int) -> ImagefeaturemserNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_mser_node_len(s : ImagefeaturemserNode) -> Int { s.size }

pub fn image_feature_mser_node_get(s : ImagefeaturemserNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_mser_node_set(s : ImagefeaturemserNode, i : Int, v : Double) -> ImagefeaturemserNode {
  let result = image_feature_mser_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_mser_node_sum(s : ImagefeaturemserNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_mser_node_mean(s : ImagefeaturemserNode) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_mser_node_sum(s) / s.size.to_double() }
}

pub fn image_feature_mser_node_scale(s : ImagefeaturemserNode, f : Double) -> ImagefeaturemserNode {
  let result = image_feature_mser_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_mser_node_add(a : ImagefeaturemserNode, b : ImagefeaturemserNode) -> ImagefeaturemserNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_mser_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_mser_node_copy(s : ImagefeaturemserNode) -> ImagefeaturemserNode {
  let result = image_feature_mser_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_mser_node_fill(s : ImagefeaturemserNode, v : Double) -> ImagefeaturemserNode {
  let result = image_feature_mser_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_mser_node_min(s : ImagefeaturemserNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_mser_node_max(s : ImagefeaturemserNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_mser_node_to_string(s : ImagefeaturemserNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturemserEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_mser_edge_make(size : Int) -> ImagefeaturemserEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_mser_edge_len(s : ImagefeaturemserEdge) -> Int { s.size }

pub fn image_feature_mser_edge_get(s : ImagefeaturemserEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_mser_edge_set(s : ImagefeaturemserEdge, i : Int, v : Double) -> ImagefeaturemserEdge {
  let result = image_feature_mser_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_mser_edge_sum(s : ImagefeaturemserEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_mser_edge_mean(s : ImagefeaturemserEdge) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_mser_edge_sum(s) / s.size.to_double() }
}

pub fn image_feature_mser_edge_scale(s : ImagefeaturemserEdge, f : Double) -> ImagefeaturemserEdge {
  let result = image_feature_mser_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_mser_edge_add(a : ImagefeaturemserEdge, b : ImagefeaturemserEdge) -> ImagefeaturemserEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_mser_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_mser_edge_copy(s : ImagefeaturemserEdge) -> ImagefeaturemserEdge {
  let result = image_feature_mser_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_mser_edge_fill(s : ImagefeaturemserEdge, v : Double) -> ImagefeaturemserEdge {
  let result = image_feature_mser_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_mser_edge_min(s : ImagefeaturemserEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_mser_edge_max(s : ImagefeaturemserEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_mser_edge_to_string(s : ImagefeaturemserEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturemserPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_mser_path_make(size : Int) -> ImagefeaturemserPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_mser_path_len(s : ImagefeaturemserPath) -> Int { s.size }

pub fn image_feature_mser_path_get(s : ImagefeaturemserPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_mser_path_set(s : ImagefeaturemserPath, i : Int, v : Double) -> ImagefeaturemserPath {
  let result = image_feature_mser_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_mser_path_sum(s : ImagefeaturemserPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_mser_path_mean(s : ImagefeaturemserPath) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_mser_path_sum(s) / s.size.to_double() }
}

pub fn image_feature_mser_path_scale(s : ImagefeaturemserPath, f : Double) -> ImagefeaturemserPath {
  let result = image_feature_mser_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_mser_path_add(a : ImagefeaturemserPath, b : ImagefeaturemserPath) -> ImagefeaturemserPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_mser_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_mser_path_copy(s : ImagefeaturemserPath) -> ImagefeaturemserPath {
  let result = image_feature_mser_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_mser_path_fill(s : ImagefeaturemserPath, v : Double) -> ImagefeaturemserPath {
  let result = image_feature_mser_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_mser_path_min(s : ImagefeaturemserPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_mser_path_max(s : ImagefeaturemserPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_mser_path_to_string(s : ImagefeaturemserPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturemserCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_mser_cluster_make(size : Int) -> ImagefeaturemserCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_mser_cluster_len(s : ImagefeaturemserCluster) -> Int { s.size }

pub fn image_feature_mser_cluster_get(s : ImagefeaturemserCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_mser_cluster_set(s : ImagefeaturemserCluster, i : Int, v : Double) -> ImagefeaturemserCluster {
  let result = image_feature_mser_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_mser_cluster_sum(s : ImagefeaturemserCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_mser_cluster_mean(s : ImagefeaturemserCluster) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_mser_cluster_sum(s) / s.size.to_double() }
}

pub fn image_feature_mser_cluster_scale(s : ImagefeaturemserCluster, f : Double) -> ImagefeaturemserCluster {
  let result = image_feature_mser_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_mser_cluster_add(a : ImagefeaturemserCluster, b : ImagefeaturemserCluster) -> ImagefeaturemserCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_mser_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_mser_cluster_copy(s : ImagefeaturemserCluster) -> ImagefeaturemserCluster {
  let result = image_feature_mser_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_mser_cluster_fill(s : ImagefeaturemserCluster, v : Double) -> ImagefeaturemserCluster {
  let result = image_feature_mser_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_mser_cluster_min(s : ImagefeaturemserCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_mser_cluster_max(s : ImagefeaturemserCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_mser_cluster_to_string(s : ImagefeaturemserCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturemserModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_mser_model_make(size : Int) -> ImagefeaturemserModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_mser_model_len(s : ImagefeaturemserModel) -> Int { s.size }

pub fn image_feature_mser_model_get(s : ImagefeaturemserModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_mser_model_set(s : ImagefeaturemserModel, i : Int, v : Double) -> ImagefeaturemserModel {
  let result = image_feature_mser_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_mser_model_sum(s : ImagefeaturemserModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_mser_model_mean(s : ImagefeaturemserModel) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_mser_model_sum(s) / s.size.to_double() }
}

pub fn image_feature_mser_model_scale(s : ImagefeaturemserModel, f : Double) -> ImagefeaturemserModel {
  let result = image_feature_mser_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_mser_model_add(a : ImagefeaturemserModel, b : ImagefeaturemserModel) -> ImagefeaturemserModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_mser_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_mser_model_copy(s : ImagefeaturemserModel) -> ImagefeaturemserModel {
  let result = image_feature_mser_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_mser_model_fill(s : ImagefeaturemserModel, v : Double) -> ImagefeaturemserModel {
  let result = image_feature_mser_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_mser_model_min(s : ImagefeaturemserModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_mser_model_max(s : ImagefeaturemserModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_mser_model_to_string(s : ImagefeaturemserModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturemserLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_mser_layer_make(size : Int) -> ImagefeaturemserLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_mser_layer_len(s : ImagefeaturemserLayer) -> Int { s.size }

pub fn image_feature_mser_layer_get(s : ImagefeaturemserLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_mser_layer_set(s : ImagefeaturemserLayer, i : Int, v : Double) -> ImagefeaturemserLayer {
  let result = image_feature_mser_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_mser_layer_sum(s : ImagefeaturemserLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_mser_layer_mean(s : ImagefeaturemserLayer) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_mser_layer_sum(s) / s.size.to_double() }
}

pub fn image_feature_mser_layer_scale(s : ImagefeaturemserLayer, f : Double) -> ImagefeaturemserLayer {
  let result = image_feature_mser_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_mser_layer_add(a : ImagefeaturemserLayer, b : ImagefeaturemserLayer) -> ImagefeaturemserLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_mser_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_mser_layer_copy(s : ImagefeaturemserLayer) -> ImagefeaturemserLayer {
  let result = image_feature_mser_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_mser_layer_fill(s : ImagefeaturemserLayer, v : Double) -> ImagefeaturemserLayer {
  let result = image_feature_mser_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_mser_layer_min(s : ImagefeaturemserLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_mser_layer_max(s : ImagefeaturemserLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_mser_layer_to_string(s : ImagefeaturemserLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturemserBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_mser_buffer_make(size : Int) -> ImagefeaturemserBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_mser_buffer_len(s : ImagefeaturemserBuffer) -> Int { s.size }

pub fn image_feature_mser_buffer_get(s : ImagefeaturemserBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_mser_buffer_set(s : ImagefeaturemserBuffer, i : Int, v : Double) -> ImagefeaturemserBuffer {
  let result = image_feature_mser_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_mser_buffer_sum(s : ImagefeaturemserBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_mser_buffer_mean(s : ImagefeaturemserBuffer) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_mser_buffer_sum(s) / s.size.to_double() }
}

pub fn image_feature_mser_buffer_scale(s : ImagefeaturemserBuffer, f : Double) -> ImagefeaturemserBuffer {
  let result = image_feature_mser_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_mser_buffer_add(a : ImagefeaturemserBuffer, b : ImagefeaturemserBuffer) -> ImagefeaturemserBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_mser_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_mser_buffer_copy(s : ImagefeaturemserBuffer) -> ImagefeaturemserBuffer {
  let result = image_feature_mser_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_mser_buffer_fill(s : ImagefeaturemserBuffer, v : Double) -> ImagefeaturemserBuffer {
  let result = image_feature_mser_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_mser_buffer_min(s : ImagefeaturemserBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_mser_buffer_max(s : ImagefeaturemserBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_mser_buffer_to_string(s : ImagefeaturemserBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturemserCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_mser_cursor_make(size : Int) -> ImagefeaturemserCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_mser_cursor_len(s : ImagefeaturemserCursor) -> Int { s.size }

pub fn image_feature_mser_cursor_get(s : ImagefeaturemserCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_mser_cursor_set(s : ImagefeaturemserCursor, i : Int, v : Double) -> ImagefeaturemserCursor {
  let result = image_feature_mser_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_mser_cursor_sum(s : ImagefeaturemserCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_mser_cursor_mean(s : ImagefeaturemserCursor) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_mser_cursor_sum(s) / s.size.to_double() }
}

pub fn image_feature_mser_cursor_scale(s : ImagefeaturemserCursor, f : Double) -> ImagefeaturemserCursor {
  let result = image_feature_mser_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_mser_cursor_add(a : ImagefeaturemserCursor, b : ImagefeaturemserCursor) -> ImagefeaturemserCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_mser_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_mser_cursor_copy(s : ImagefeaturemserCursor) -> ImagefeaturemserCursor {
  let result = image_feature_mser_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_mser_cursor_fill(s : ImagefeaturemserCursor, v : Double) -> ImagefeaturemserCursor {
  let result = image_feature_mser_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_mser_cursor_min(s : ImagefeaturemserCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_mser_cursor_max(s : ImagefeaturemserCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_mser_cursor_to_string(s : ImagefeaturemserCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturemserView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_mser_view_make(size : Int) -> ImagefeaturemserView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_mser_view_len(s : ImagefeaturemserView) -> Int { s.size }

pub fn image_feature_mser_view_get(s : ImagefeaturemserView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_mser_view_set(s : ImagefeaturemserView, i : Int, v : Double) -> ImagefeaturemserView {
  let result = image_feature_mser_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_mser_view_sum(s : ImagefeaturemserView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_mser_view_mean(s : ImagefeaturemserView) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_mser_view_sum(s) / s.size.to_double() }
}

pub fn image_feature_mser_view_scale(s : ImagefeaturemserView, f : Double) -> ImagefeaturemserView {
  let result = image_feature_mser_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_mser_view_add(a : ImagefeaturemserView, b : ImagefeaturemserView) -> ImagefeaturemserView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_mser_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_mser_view_copy(s : ImagefeaturemserView) -> ImagefeaturemserView {
  let result = image_feature_mser_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_mser_view_fill(s : ImagefeaturemserView, v : Double) -> ImagefeaturemserView {
  let result = image_feature_mser_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_mser_view_min(s : ImagefeaturemserView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_mser_view_max(s : ImagefeaturemserView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_mser_view_to_string(s : ImagefeaturemserView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturemserRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_mser_range_make(size : Int) -> ImagefeaturemserRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_mser_range_len(s : ImagefeaturemserRange) -> Int { s.size }

pub fn image_feature_mser_range_get(s : ImagefeaturemserRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_mser_range_set(s : ImagefeaturemserRange, i : Int, v : Double) -> ImagefeaturemserRange {
  let result = image_feature_mser_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_mser_range_sum(s : ImagefeaturemserRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_mser_range_mean(s : ImagefeaturemserRange) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_mser_range_sum(s) / s.size.to_double() }
}

pub fn image_feature_mser_range_scale(s : ImagefeaturemserRange, f : Double) -> ImagefeaturemserRange {
  let result = image_feature_mser_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_mser_range_add(a : ImagefeaturemserRange, b : ImagefeaturemserRange) -> ImagefeaturemserRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_mser_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_mser_range_copy(s : ImagefeaturemserRange) -> ImagefeaturemserRange {
  let result = image_feature_mser_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_mser_range_fill(s : ImagefeaturemserRange, v : Double) -> ImagefeaturemserRange {
  let result = image_feature_mser_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_mser_range_min(s : ImagefeaturemserRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_mser_range_max(s : ImagefeaturemserRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_mser_range_to_string(s : ImagefeaturemserRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturemserSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_mser_slice_make(size : Int) -> ImagefeaturemserSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_mser_slice_len(s : ImagefeaturemserSlice) -> Int { s.size }

pub fn image_feature_mser_slice_get(s : ImagefeaturemserSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_mser_slice_set(s : ImagefeaturemserSlice, i : Int, v : Double) -> ImagefeaturemserSlice {
  let result = image_feature_mser_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_mser_slice_sum(s : ImagefeaturemserSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_mser_slice_mean(s : ImagefeaturemserSlice) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_mser_slice_sum(s) / s.size.to_double() }
}

pub fn image_feature_mser_slice_scale(s : ImagefeaturemserSlice, f : Double) -> ImagefeaturemserSlice {
  let result = image_feature_mser_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_mser_slice_add(a : ImagefeaturemserSlice, b : ImagefeaturemserSlice) -> ImagefeaturemserSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_mser_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_mser_slice_copy(s : ImagefeaturemserSlice) -> ImagefeaturemserSlice {
  let result = image_feature_mser_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_mser_slice_fill(s : ImagefeaturemserSlice, v : Double) -> ImagefeaturemserSlice {
  let result = image_feature_mser_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_mser_slice_min(s : ImagefeaturemserSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_mser_slice_max(s : ImagefeaturemserSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_mser_slice_to_string(s : ImagefeaturemserSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


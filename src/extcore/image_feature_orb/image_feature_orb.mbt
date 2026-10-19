///===
/// extcore/image_feature_orb

pub(all) struct ImagefeatureorbPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_feature_orb_make_point(x : Double, y : Double) -> ImagefeatureorbPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_feature_orb_make_point3(x : Double, y : Double, z : Double) -> ImagefeatureorbPoint {
  { x, y, z, label: 0 }
}

pub fn image_feature_orb_point_x(pt : ImagefeatureorbPoint) -> Double { pt.x }

pub fn image_feature_orb_point_y(pt : ImagefeatureorbPoint) -> Double { pt.y }

pub fn image_feature_orb_point_z(pt : ImagefeatureorbPoint) -> Double { pt.z }

pub fn image_feature_orb_point_label(pt : ImagefeatureorbPoint) -> Int { pt.label }

pub fn image_feature_orb_point_dist(a : ImagefeatureorbPoint, b : ImagefeatureorbPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn image_feature_orb_point_add(a : ImagefeatureorbPoint, b : ImagefeatureorbPoint) -> ImagefeatureorbPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn image_feature_orb_point_sub(a : ImagefeatureorbPoint, b : ImagefeatureorbPoint) -> ImagefeatureorbPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn image_feature_orb_point_scale(pt : ImagefeatureorbPoint, s : Double) -> ImagefeatureorbPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn image_feature_orb_point_dot(a : ImagefeatureorbPoint, b : ImagefeatureorbPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn image_feature_orb_point_cross(a : ImagefeatureorbPoint, b : ImagefeatureorbPoint) -> ImagefeatureorbPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn image_feature_orb_point_norm(pt : ImagefeatureorbPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn image_feature_orb_point_normalize(pt : ImagefeatureorbPoint) -> ImagefeatureorbPoint {
  let n = image_feature_orb_point_norm(pt)
  if n < 0.0000001 { pt } else { image_feature_orb_point_scale(pt, 1.0 / n) }
}

pub fn image_feature_orb_point_negate(pt : ImagefeatureorbPoint) -> ImagefeatureorbPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn image_feature_orb_point_mid(a : ImagefeatureorbPoint, b : ImagefeatureorbPoint) -> ImagefeatureorbPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn image_feature_orb_point_lerp(a : ImagefeatureorbPoint, b : ImagefeatureorbPoint, t : Double) -> ImagefeatureorbPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn image_feature_orb_point_to_string(pt : ImagefeatureorbPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct ImagefeatureorbSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_feature_orb_make_series(vals : Array[Double], name : String) -> ImagefeatureorbSeries {
  { vals, name, meta: 0 }
}

pub fn image_feature_orb_series_len(s : ImagefeatureorbSeries) -> Int { s.vals.length() }

pub fn image_feature_orb_series_sum(s : ImagefeatureorbSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn image_feature_orb_series_mean(s : ImagefeatureorbSeries) -> Double {
  let n = image_feature_orb_series_len(s)
  if n == 0 { 0.0 } else { image_feature_orb_series_sum(s) / n.to_double() }
}

pub fn image_feature_orb_series_min(s : ImagefeatureorbSeries) -> Double {
  let n = image_feature_orb_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn image_feature_orb_series_max(s : ImagefeatureorbSeries) -> Double {
  let n = image_feature_orb_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn image_feature_orb_series_range(s : ImagefeatureorbSeries) -> Double {
  image_feature_orb_series_max(s) - image_feature_orb_series_min(s)
}

pub fn image_feature_orb_series_var(s : ImagefeatureorbSeries) -> Double {
  let n = image_feature_orb_series_len(s)
  if n == 0 { 0.0 } else {
    let m = image_feature_orb_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn image_feature_orb_series_std(s : ImagefeatureorbSeries) -> Double { @_common.sqrt(image_feature_orb_series_var(s)) }

pub fn image_feature_orb_series_median(s : ImagefeatureorbSeries) -> Double {
  let n = image_feature_orb_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = image_feature_orb_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn image_feature_orb_series_scale(s : ImagefeatureorbSeries, f : Double) -> ImagefeatureorbSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn image_feature_orb_series_add(a : ImagefeatureorbSeries, b : ImagefeatureorbSeries) -> ImagefeatureorbSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn image_feature_orb_series_sub(a : ImagefeatureorbSeries, b : ImagefeatureorbSeries) -> ImagefeatureorbSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn image_feature_orb_series_normalize(s : ImagefeatureorbSeries) -> ImagefeatureorbSeries {
  let mn = image_feature_orb_series_min(s)
  let mx = image_feature_orb_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn image_feature_orb_series_cumsum(s : ImagefeatureorbSeries) -> ImagefeatureorbSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn image_feature_orb_series_to_string(s : ImagefeatureorbSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagefeatureorbMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_feature_orb_make_matrix(rows : Int, cols : Int, val : Double) -> ImagefeatureorbMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn image_feature_orb_matrix_identity(n : Int) -> ImagefeatureorbMatrix {
  let m = image_feature_orb_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn image_feature_orb_matrix_get(m : ImagefeatureorbMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn image_feature_orb_matrix_transpose(m : ImagefeatureorbMatrix) -> ImagefeatureorbMatrix {
  let result = image_feature_orb_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn image_feature_orb_matrix_add(a : ImagefeatureorbMatrix, b : ImagefeatureorbMatrix) -> ImagefeatureorbMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = image_feature_orb_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn image_feature_orb_matrix_scale(m : ImagefeatureorbMatrix, s : Double) -> ImagefeatureorbMatrix {
  let result = image_feature_orb_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn image_feature_orb_matrix_multiply(a : ImagefeatureorbMatrix, b : ImagefeatureorbMatrix) -> ImagefeatureorbMatrix {
  if a.cols != b.rows { return image_feature_orb_make_matrix(a.rows, b.cols, 0.0) }
  let result = image_feature_orb_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn image_feature_orb_matrix_trace(m : ImagefeatureorbMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn image_feature_orb_matrix_det(m : ImagefeatureorbMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn image_feature_orb_matrix_norm(m : ImagefeatureorbMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn image_feature_orb_matrix_to_string(m : ImagefeatureorbMatrix) -> String {
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

pub(all) struct ImagefeatureorbVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_feature_orb_make_vector(comps : Array[Double]) -> ImagefeatureorbVector {
  { comps, dim: comps.length() }
}

pub fn image_feature_orb_vector_zero(dim : Int) -> ImagefeatureorbVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn image_feature_orb_vector_add(a : ImagefeatureorbVector, b : ImagefeatureorbVector) -> ImagefeatureorbVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn image_feature_orb_vector_sub(a : ImagefeatureorbVector, b : ImagefeatureorbVector) -> ImagefeatureorbVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn image_feature_orb_vector_scale(v : ImagefeatureorbVector, s : Double) -> ImagefeatureorbVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn image_feature_orb_vector_dot(a : ImagefeatureorbVector, b : ImagefeatureorbVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn image_feature_orb_vector_norm(v : ImagefeatureorbVector) -> Double { @_common.sqrt(image_feature_orb_vector_dot(v, v)) }

pub fn image_feature_orb_vector_normalize(v : ImagefeatureorbVector) -> ImagefeatureorbVector {
  let n = image_feature_orb_vector_norm(v)
  if n < 0.0000001 { v } else { image_feature_orb_vector_scale(v, 1.0 / n) }
}

pub fn image_feature_orb_vector_dist(a : ImagefeatureorbVector, b : ImagefeatureorbVector) -> Double {
  image_feature_orb_vector_norm(image_feature_orb_vector_sub(a, b))
}

pub fn image_feature_orb_vector_to_string(v : ImagefeatureorbVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn image_feature_orb_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn image_feature_orb_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = image_feature_orb_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn image_feature_orb_std(data : Array[Double]) -> Double { @_common.sqrt(image_feature_orb_var(data)) }

pub fn image_feature_orb_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = image_feature_orb_mean(a); let mb = image_feature_orb_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn image_feature_orb_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = image_feature_orb_std(a); let sb = image_feature_orb_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { image_feature_orb_cov(a, b) / (sa * sb) }
}

pub fn image_feature_orb_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = image_feature_orb_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn image_feature_orb_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn image_feature_orb_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn image_feature_orb_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(image_feature_orb_mse(pred, labels))
}

pub fn image_feature_orb_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn image_feature_orb_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = image_feature_orb_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn image_feature_orb_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn image_feature_orb_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn image_feature_orb_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = image_feature_orb_precision(pred, labels, pos); let r = image_feature_orb_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn image_feature_orb_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn image_feature_orb_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = image_feature_orb_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn image_feature_orb_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn image_feature_orb_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn image_feature_orb_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = image_feature_orb_gcd(a, b)
    (a / g) * b
  }
}

pub fn image_feature_orb_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn image_feature_orb_fibonacci(n : Int) -> Int {
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

pub fn image_feature_orb_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = image_feature_orb_min(data); let mx = image_feature_orb_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn image_feature_orb_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = image_feature_orb_mean(data); let sd = image_feature_orb_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn image_feature_orb_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn image_feature_orb_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn image_feature_orb_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn image_feature_orb_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn image_feature_orb_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn image_feature_orb_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct ImagefeatureorbFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_orb_frame_make(size : Int) -> ImagefeatureorbFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_orb_frame_len(s : ImagefeatureorbFrame) -> Int { s.size }

pub fn image_feature_orb_frame_get(s : ImagefeatureorbFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_orb_frame_set(s : ImagefeatureorbFrame, i : Int, v : Double) -> ImagefeatureorbFrame {
  let result = image_feature_orb_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_orb_frame_sum(s : ImagefeatureorbFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_orb_frame_mean(s : ImagefeatureorbFrame) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_orb_frame_sum(s) / s.size.to_double() }
}

pub fn image_feature_orb_frame_scale(s : ImagefeatureorbFrame, f : Double) -> ImagefeatureorbFrame {
  let result = image_feature_orb_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_orb_frame_add(a : ImagefeatureorbFrame, b : ImagefeatureorbFrame) -> ImagefeatureorbFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_orb_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_orb_frame_copy(s : ImagefeatureorbFrame) -> ImagefeatureorbFrame {
  let result = image_feature_orb_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_orb_frame_fill(s : ImagefeatureorbFrame, v : Double) -> ImagefeatureorbFrame {
  let result = image_feature_orb_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_orb_frame_min(s : ImagefeatureorbFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_orb_frame_max(s : ImagefeatureorbFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_orb_frame_to_string(s : ImagefeatureorbFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeatureorbTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_orb_table_make(size : Int) -> ImagefeatureorbTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_orb_table_len(s : ImagefeatureorbTable) -> Int { s.size }

pub fn image_feature_orb_table_get(s : ImagefeatureorbTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_orb_table_set(s : ImagefeatureorbTable, i : Int, v : Double) -> ImagefeatureorbTable {
  let result = image_feature_orb_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_orb_table_sum(s : ImagefeatureorbTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_orb_table_mean(s : ImagefeatureorbTable) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_orb_table_sum(s) / s.size.to_double() }
}

pub fn image_feature_orb_table_scale(s : ImagefeatureorbTable, f : Double) -> ImagefeatureorbTable {
  let result = image_feature_orb_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_orb_table_add(a : ImagefeatureorbTable, b : ImagefeatureorbTable) -> ImagefeatureorbTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_orb_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_orb_table_copy(s : ImagefeatureorbTable) -> ImagefeatureorbTable {
  let result = image_feature_orb_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_orb_table_fill(s : ImagefeatureorbTable, v : Double) -> ImagefeatureorbTable {
  let result = image_feature_orb_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_orb_table_min(s : ImagefeatureorbTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_orb_table_max(s : ImagefeatureorbTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_orb_table_to_string(s : ImagefeatureorbTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeatureorbGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_orb_graphn_make(size : Int) -> ImagefeatureorbGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_orb_graphn_len(s : ImagefeatureorbGraphN) -> Int { s.size }

pub fn image_feature_orb_graphn_get(s : ImagefeatureorbGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_orb_graphn_set(s : ImagefeatureorbGraphN, i : Int, v : Double) -> ImagefeatureorbGraphN {
  let result = image_feature_orb_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_orb_graphn_sum(s : ImagefeatureorbGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_orb_graphn_mean(s : ImagefeatureorbGraphN) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_orb_graphn_sum(s) / s.size.to_double() }
}

pub fn image_feature_orb_graphn_scale(s : ImagefeatureorbGraphN, f : Double) -> ImagefeatureorbGraphN {
  let result = image_feature_orb_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_orb_graphn_add(a : ImagefeatureorbGraphN, b : ImagefeatureorbGraphN) -> ImagefeatureorbGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_orb_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_orb_graphn_copy(s : ImagefeatureorbGraphN) -> ImagefeatureorbGraphN {
  let result = image_feature_orb_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_orb_graphn_fill(s : ImagefeatureorbGraphN, v : Double) -> ImagefeatureorbGraphN {
  let result = image_feature_orb_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_orb_graphn_min(s : ImagefeatureorbGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_orb_graphn_max(s : ImagefeatureorbGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_orb_graphn_to_string(s : ImagefeatureorbGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeatureorbNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_orb_node_make(size : Int) -> ImagefeatureorbNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_orb_node_len(s : ImagefeatureorbNode) -> Int { s.size }

pub fn image_feature_orb_node_get(s : ImagefeatureorbNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_orb_node_set(s : ImagefeatureorbNode, i : Int, v : Double) -> ImagefeatureorbNode {
  let result = image_feature_orb_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_orb_node_sum(s : ImagefeatureorbNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_orb_node_mean(s : ImagefeatureorbNode) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_orb_node_sum(s) / s.size.to_double() }
}

pub fn image_feature_orb_node_scale(s : ImagefeatureorbNode, f : Double) -> ImagefeatureorbNode {
  let result = image_feature_orb_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_orb_node_add(a : ImagefeatureorbNode, b : ImagefeatureorbNode) -> ImagefeatureorbNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_orb_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_orb_node_copy(s : ImagefeatureorbNode) -> ImagefeatureorbNode {
  let result = image_feature_orb_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_orb_node_fill(s : ImagefeatureorbNode, v : Double) -> ImagefeatureorbNode {
  let result = image_feature_orb_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_orb_node_min(s : ImagefeatureorbNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_orb_node_max(s : ImagefeatureorbNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_orb_node_to_string(s : ImagefeatureorbNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeatureorbEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_orb_edge_make(size : Int) -> ImagefeatureorbEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_orb_edge_len(s : ImagefeatureorbEdge) -> Int { s.size }

pub fn image_feature_orb_edge_get(s : ImagefeatureorbEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_orb_edge_set(s : ImagefeatureorbEdge, i : Int, v : Double) -> ImagefeatureorbEdge {
  let result = image_feature_orb_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_orb_edge_sum(s : ImagefeatureorbEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_orb_edge_mean(s : ImagefeatureorbEdge) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_orb_edge_sum(s) / s.size.to_double() }
}

pub fn image_feature_orb_edge_scale(s : ImagefeatureorbEdge, f : Double) -> ImagefeatureorbEdge {
  let result = image_feature_orb_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_orb_edge_add(a : ImagefeatureorbEdge, b : ImagefeatureorbEdge) -> ImagefeatureorbEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_orb_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_orb_edge_copy(s : ImagefeatureorbEdge) -> ImagefeatureorbEdge {
  let result = image_feature_orb_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_orb_edge_fill(s : ImagefeatureorbEdge, v : Double) -> ImagefeatureorbEdge {
  let result = image_feature_orb_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_orb_edge_min(s : ImagefeatureorbEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_orb_edge_max(s : ImagefeatureorbEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_orb_edge_to_string(s : ImagefeatureorbEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeatureorbPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_orb_path_make(size : Int) -> ImagefeatureorbPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_orb_path_len(s : ImagefeatureorbPath) -> Int { s.size }

pub fn image_feature_orb_path_get(s : ImagefeatureorbPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_orb_path_set(s : ImagefeatureorbPath, i : Int, v : Double) -> ImagefeatureorbPath {
  let result = image_feature_orb_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_orb_path_sum(s : ImagefeatureorbPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_orb_path_mean(s : ImagefeatureorbPath) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_orb_path_sum(s) / s.size.to_double() }
}

pub fn image_feature_orb_path_scale(s : ImagefeatureorbPath, f : Double) -> ImagefeatureorbPath {
  let result = image_feature_orb_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_orb_path_add(a : ImagefeatureorbPath, b : ImagefeatureorbPath) -> ImagefeatureorbPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_orb_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_orb_path_copy(s : ImagefeatureorbPath) -> ImagefeatureorbPath {
  let result = image_feature_orb_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_orb_path_fill(s : ImagefeatureorbPath, v : Double) -> ImagefeatureorbPath {
  let result = image_feature_orb_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_orb_path_min(s : ImagefeatureorbPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_orb_path_max(s : ImagefeatureorbPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_orb_path_to_string(s : ImagefeatureorbPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeatureorbCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_orb_cluster_make(size : Int) -> ImagefeatureorbCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_orb_cluster_len(s : ImagefeatureorbCluster) -> Int { s.size }

pub fn image_feature_orb_cluster_get(s : ImagefeatureorbCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_orb_cluster_set(s : ImagefeatureorbCluster, i : Int, v : Double) -> ImagefeatureorbCluster {
  let result = image_feature_orb_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_orb_cluster_sum(s : ImagefeatureorbCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_orb_cluster_mean(s : ImagefeatureorbCluster) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_orb_cluster_sum(s) / s.size.to_double() }
}

pub fn image_feature_orb_cluster_scale(s : ImagefeatureorbCluster, f : Double) -> ImagefeatureorbCluster {
  let result = image_feature_orb_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_orb_cluster_add(a : ImagefeatureorbCluster, b : ImagefeatureorbCluster) -> ImagefeatureorbCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_orb_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_orb_cluster_copy(s : ImagefeatureorbCluster) -> ImagefeatureorbCluster {
  let result = image_feature_orb_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_orb_cluster_fill(s : ImagefeatureorbCluster, v : Double) -> ImagefeatureorbCluster {
  let result = image_feature_orb_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_orb_cluster_min(s : ImagefeatureorbCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_orb_cluster_max(s : ImagefeatureorbCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_orb_cluster_to_string(s : ImagefeatureorbCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeatureorbModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_orb_model_make(size : Int) -> ImagefeatureorbModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_orb_model_len(s : ImagefeatureorbModel) -> Int { s.size }

pub fn image_feature_orb_model_get(s : ImagefeatureorbModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_orb_model_set(s : ImagefeatureorbModel, i : Int, v : Double) -> ImagefeatureorbModel {
  let result = image_feature_orb_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_orb_model_sum(s : ImagefeatureorbModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_orb_model_mean(s : ImagefeatureorbModel) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_orb_model_sum(s) / s.size.to_double() }
}

pub fn image_feature_orb_model_scale(s : ImagefeatureorbModel, f : Double) -> ImagefeatureorbModel {
  let result = image_feature_orb_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_orb_model_add(a : ImagefeatureorbModel, b : ImagefeatureorbModel) -> ImagefeatureorbModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_orb_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_orb_model_copy(s : ImagefeatureorbModel) -> ImagefeatureorbModel {
  let result = image_feature_orb_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_orb_model_fill(s : ImagefeatureorbModel, v : Double) -> ImagefeatureorbModel {
  let result = image_feature_orb_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_orb_model_min(s : ImagefeatureorbModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_orb_model_max(s : ImagefeatureorbModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_orb_model_to_string(s : ImagefeatureorbModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeatureorbLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_orb_layer_make(size : Int) -> ImagefeatureorbLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_orb_layer_len(s : ImagefeatureorbLayer) -> Int { s.size }

pub fn image_feature_orb_layer_get(s : ImagefeatureorbLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_orb_layer_set(s : ImagefeatureorbLayer, i : Int, v : Double) -> ImagefeatureorbLayer {
  let result = image_feature_orb_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_orb_layer_sum(s : ImagefeatureorbLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_orb_layer_mean(s : ImagefeatureorbLayer) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_orb_layer_sum(s) / s.size.to_double() }
}

pub fn image_feature_orb_layer_scale(s : ImagefeatureorbLayer, f : Double) -> ImagefeatureorbLayer {
  let result = image_feature_orb_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_orb_layer_add(a : ImagefeatureorbLayer, b : ImagefeatureorbLayer) -> ImagefeatureorbLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_orb_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_orb_layer_copy(s : ImagefeatureorbLayer) -> ImagefeatureorbLayer {
  let result = image_feature_orb_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_orb_layer_fill(s : ImagefeatureorbLayer, v : Double) -> ImagefeatureorbLayer {
  let result = image_feature_orb_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_orb_layer_min(s : ImagefeatureorbLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_orb_layer_max(s : ImagefeatureorbLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_orb_layer_to_string(s : ImagefeatureorbLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeatureorbBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_orb_buffer_make(size : Int) -> ImagefeatureorbBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_orb_buffer_len(s : ImagefeatureorbBuffer) -> Int { s.size }

pub fn image_feature_orb_buffer_get(s : ImagefeatureorbBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_orb_buffer_set(s : ImagefeatureorbBuffer, i : Int, v : Double) -> ImagefeatureorbBuffer {
  let result = image_feature_orb_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_orb_buffer_sum(s : ImagefeatureorbBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_orb_buffer_mean(s : ImagefeatureorbBuffer) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_orb_buffer_sum(s) / s.size.to_double() }
}

pub fn image_feature_orb_buffer_scale(s : ImagefeatureorbBuffer, f : Double) -> ImagefeatureorbBuffer {
  let result = image_feature_orb_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_orb_buffer_add(a : ImagefeatureorbBuffer, b : ImagefeatureorbBuffer) -> ImagefeatureorbBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_orb_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_orb_buffer_copy(s : ImagefeatureorbBuffer) -> ImagefeatureorbBuffer {
  let result = image_feature_orb_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_orb_buffer_fill(s : ImagefeatureorbBuffer, v : Double) -> ImagefeatureorbBuffer {
  let result = image_feature_orb_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_orb_buffer_min(s : ImagefeatureorbBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_orb_buffer_max(s : ImagefeatureorbBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_orb_buffer_to_string(s : ImagefeatureorbBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeatureorbCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_orb_cursor_make(size : Int) -> ImagefeatureorbCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_orb_cursor_len(s : ImagefeatureorbCursor) -> Int { s.size }

pub fn image_feature_orb_cursor_get(s : ImagefeatureorbCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_orb_cursor_set(s : ImagefeatureorbCursor, i : Int, v : Double) -> ImagefeatureorbCursor {
  let result = image_feature_orb_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_orb_cursor_sum(s : ImagefeatureorbCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_orb_cursor_mean(s : ImagefeatureorbCursor) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_orb_cursor_sum(s) / s.size.to_double() }
}

pub fn image_feature_orb_cursor_scale(s : ImagefeatureorbCursor, f : Double) -> ImagefeatureorbCursor {
  let result = image_feature_orb_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_orb_cursor_add(a : ImagefeatureorbCursor, b : ImagefeatureorbCursor) -> ImagefeatureorbCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_orb_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_orb_cursor_copy(s : ImagefeatureorbCursor) -> ImagefeatureorbCursor {
  let result = image_feature_orb_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_orb_cursor_fill(s : ImagefeatureorbCursor, v : Double) -> ImagefeatureorbCursor {
  let result = image_feature_orb_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_orb_cursor_min(s : ImagefeatureorbCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_orb_cursor_max(s : ImagefeatureorbCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_orb_cursor_to_string(s : ImagefeatureorbCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeatureorbView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_orb_view_make(size : Int) -> ImagefeatureorbView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_orb_view_len(s : ImagefeatureorbView) -> Int { s.size }

pub fn image_feature_orb_view_get(s : ImagefeatureorbView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_orb_view_set(s : ImagefeatureorbView, i : Int, v : Double) -> ImagefeatureorbView {
  let result = image_feature_orb_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_orb_view_sum(s : ImagefeatureorbView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_orb_view_mean(s : ImagefeatureorbView) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_orb_view_sum(s) / s.size.to_double() }
}

pub fn image_feature_orb_view_scale(s : ImagefeatureorbView, f : Double) -> ImagefeatureorbView {
  let result = image_feature_orb_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_orb_view_add(a : ImagefeatureorbView, b : ImagefeatureorbView) -> ImagefeatureorbView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_orb_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_orb_view_copy(s : ImagefeatureorbView) -> ImagefeatureorbView {
  let result = image_feature_orb_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_orb_view_fill(s : ImagefeatureorbView, v : Double) -> ImagefeatureorbView {
  let result = image_feature_orb_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_orb_view_min(s : ImagefeatureorbView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_orb_view_max(s : ImagefeatureorbView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_orb_view_to_string(s : ImagefeatureorbView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeatureorbRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_orb_range_make(size : Int) -> ImagefeatureorbRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_orb_range_len(s : ImagefeatureorbRange) -> Int { s.size }

pub fn image_feature_orb_range_get(s : ImagefeatureorbRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_orb_range_set(s : ImagefeatureorbRange, i : Int, v : Double) -> ImagefeatureorbRange {
  let result = image_feature_orb_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_orb_range_sum(s : ImagefeatureorbRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_orb_range_mean(s : ImagefeatureorbRange) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_orb_range_sum(s) / s.size.to_double() }
}

pub fn image_feature_orb_range_scale(s : ImagefeatureorbRange, f : Double) -> ImagefeatureorbRange {
  let result = image_feature_orb_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_orb_range_add(a : ImagefeatureorbRange, b : ImagefeatureorbRange) -> ImagefeatureorbRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_orb_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_orb_range_copy(s : ImagefeatureorbRange) -> ImagefeatureorbRange {
  let result = image_feature_orb_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_orb_range_fill(s : ImagefeatureorbRange, v : Double) -> ImagefeatureorbRange {
  let result = image_feature_orb_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_orb_range_min(s : ImagefeatureorbRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_orb_range_max(s : ImagefeatureorbRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_orb_range_to_string(s : ImagefeatureorbRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeatureorbSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_orb_slice_make(size : Int) -> ImagefeatureorbSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_orb_slice_len(s : ImagefeatureorbSlice) -> Int { s.size }

pub fn image_feature_orb_slice_get(s : ImagefeatureorbSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_orb_slice_set(s : ImagefeatureorbSlice, i : Int, v : Double) -> ImagefeatureorbSlice {
  let result = image_feature_orb_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_orb_slice_sum(s : ImagefeatureorbSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_orb_slice_mean(s : ImagefeatureorbSlice) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_orb_slice_sum(s) / s.size.to_double() }
}

pub fn image_feature_orb_slice_scale(s : ImagefeatureorbSlice, f : Double) -> ImagefeatureorbSlice {
  let result = image_feature_orb_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_orb_slice_add(a : ImagefeatureorbSlice, b : ImagefeatureorbSlice) -> ImagefeatureorbSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_orb_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_orb_slice_copy(s : ImagefeatureorbSlice) -> ImagefeatureorbSlice {
  let result = image_feature_orb_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_orb_slice_fill(s : ImagefeatureorbSlice, v : Double) -> ImagefeatureorbSlice {
  let result = image_feature_orb_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_orb_slice_min(s : ImagefeatureorbSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_orb_slice_max(s : ImagefeatureorbSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_orb_slice_to_string(s : ImagefeatureorbSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


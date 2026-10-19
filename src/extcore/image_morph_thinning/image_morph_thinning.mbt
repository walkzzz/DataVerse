///===
/// extcore/image_morph_thinning

pub(all) struct ImagemorphthinningPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_morph_thinning_make_point(x : Double, y : Double) -> ImagemorphthinningPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_morph_thinning_make_point3(x : Double, y : Double, z : Double) -> ImagemorphthinningPoint {
  { x, y, z, label: 0 }
}

pub fn image_morph_thinning_point_x(pt : ImagemorphthinningPoint) -> Double { pt.x }

pub fn image_morph_thinning_point_y(pt : ImagemorphthinningPoint) -> Double { pt.y }

pub fn image_morph_thinning_point_z(pt : ImagemorphthinningPoint) -> Double { pt.z }

pub fn image_morph_thinning_point_label(pt : ImagemorphthinningPoint) -> Int { pt.label }

pub fn image_morph_thinning_point_dist(a : ImagemorphthinningPoint, b : ImagemorphthinningPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn image_morph_thinning_point_add(a : ImagemorphthinningPoint, b : ImagemorphthinningPoint) -> ImagemorphthinningPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn image_morph_thinning_point_sub(a : ImagemorphthinningPoint, b : ImagemorphthinningPoint) -> ImagemorphthinningPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn image_morph_thinning_point_scale(pt : ImagemorphthinningPoint, s : Double) -> ImagemorphthinningPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn image_morph_thinning_point_dot(a : ImagemorphthinningPoint, b : ImagemorphthinningPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn image_morph_thinning_point_cross(a : ImagemorphthinningPoint, b : ImagemorphthinningPoint) -> ImagemorphthinningPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn image_morph_thinning_point_norm(pt : ImagemorphthinningPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn image_morph_thinning_point_normalize(pt : ImagemorphthinningPoint) -> ImagemorphthinningPoint {
  let n = image_morph_thinning_point_norm(pt)
  if n < 0.0000001 { pt } else { image_morph_thinning_point_scale(pt, 1.0 / n) }
}

pub fn image_morph_thinning_point_negate(pt : ImagemorphthinningPoint) -> ImagemorphthinningPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn image_morph_thinning_point_mid(a : ImagemorphthinningPoint, b : ImagemorphthinningPoint) -> ImagemorphthinningPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn image_morph_thinning_point_lerp(a : ImagemorphthinningPoint, b : ImagemorphthinningPoint, t : Double) -> ImagemorphthinningPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn image_morph_thinning_point_to_string(pt : ImagemorphthinningPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct ImagemorphthinningSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_morph_thinning_make_series(vals : Array[Double], name : String) -> ImagemorphthinningSeries {
  { vals, name, meta: 0 }
}

pub fn image_morph_thinning_series_len(s : ImagemorphthinningSeries) -> Int { s.vals.length() }

pub fn image_morph_thinning_series_sum(s : ImagemorphthinningSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn image_morph_thinning_series_mean(s : ImagemorphthinningSeries) -> Double {
  let n = image_morph_thinning_series_len(s)
  if n == 0 { 0.0 } else { image_morph_thinning_series_sum(s) / n.to_double() }
}

pub fn image_morph_thinning_series_min(s : ImagemorphthinningSeries) -> Double {
  let n = image_morph_thinning_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn image_morph_thinning_series_max(s : ImagemorphthinningSeries) -> Double {
  let n = image_morph_thinning_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn image_morph_thinning_series_range(s : ImagemorphthinningSeries) -> Double {
  image_morph_thinning_series_max(s) - image_morph_thinning_series_min(s)
}

pub fn image_morph_thinning_series_var(s : ImagemorphthinningSeries) -> Double {
  let n = image_morph_thinning_series_len(s)
  if n == 0 { 0.0 } else {
    let m = image_morph_thinning_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn image_morph_thinning_series_std(s : ImagemorphthinningSeries) -> Double { @_common.sqrt(image_morph_thinning_series_var(s)) }

pub fn image_morph_thinning_series_median(s : ImagemorphthinningSeries) -> Double {
  let n = image_morph_thinning_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = image_morph_thinning_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn image_morph_thinning_series_scale(s : ImagemorphthinningSeries, f : Double) -> ImagemorphthinningSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn image_morph_thinning_series_add(a : ImagemorphthinningSeries, b : ImagemorphthinningSeries) -> ImagemorphthinningSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn image_morph_thinning_series_sub(a : ImagemorphthinningSeries, b : ImagemorphthinningSeries) -> ImagemorphthinningSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn image_morph_thinning_series_normalize(s : ImagemorphthinningSeries) -> ImagemorphthinningSeries {
  let mn = image_morph_thinning_series_min(s)
  let mx = image_morph_thinning_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn image_morph_thinning_series_cumsum(s : ImagemorphthinningSeries) -> ImagemorphthinningSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn image_morph_thinning_series_to_string(s : ImagemorphthinningSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagemorphthinningMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_morph_thinning_make_matrix(rows : Int, cols : Int, val : Double) -> ImagemorphthinningMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn image_morph_thinning_matrix_identity(n : Int) -> ImagemorphthinningMatrix {
  let m = image_morph_thinning_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn image_morph_thinning_matrix_get(m : ImagemorphthinningMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn image_morph_thinning_matrix_transpose(m : ImagemorphthinningMatrix) -> ImagemorphthinningMatrix {
  let result = image_morph_thinning_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn image_morph_thinning_matrix_add(a : ImagemorphthinningMatrix, b : ImagemorphthinningMatrix) -> ImagemorphthinningMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = image_morph_thinning_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn image_morph_thinning_matrix_scale(m : ImagemorphthinningMatrix, s : Double) -> ImagemorphthinningMatrix {
  let result = image_morph_thinning_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn image_morph_thinning_matrix_multiply(a : ImagemorphthinningMatrix, b : ImagemorphthinningMatrix) -> ImagemorphthinningMatrix {
  if a.cols != b.rows { return image_morph_thinning_make_matrix(a.rows, b.cols, 0.0) }
  let result = image_morph_thinning_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn image_morph_thinning_matrix_trace(m : ImagemorphthinningMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn image_morph_thinning_matrix_det(m : ImagemorphthinningMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn image_morph_thinning_matrix_norm(m : ImagemorphthinningMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn image_morph_thinning_matrix_to_string(m : ImagemorphthinningMatrix) -> String {
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

pub(all) struct ImagemorphthinningVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_morph_thinning_make_vector(comps : Array[Double]) -> ImagemorphthinningVector {
  { comps, dim: comps.length() }
}

pub fn image_morph_thinning_vector_zero(dim : Int) -> ImagemorphthinningVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn image_morph_thinning_vector_add(a : ImagemorphthinningVector, b : ImagemorphthinningVector) -> ImagemorphthinningVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn image_morph_thinning_vector_sub(a : ImagemorphthinningVector, b : ImagemorphthinningVector) -> ImagemorphthinningVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn image_morph_thinning_vector_scale(v : ImagemorphthinningVector, s : Double) -> ImagemorphthinningVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn image_morph_thinning_vector_dot(a : ImagemorphthinningVector, b : ImagemorphthinningVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn image_morph_thinning_vector_norm(v : ImagemorphthinningVector) -> Double { @_common.sqrt(image_morph_thinning_vector_dot(v, v)) }

pub fn image_morph_thinning_vector_normalize(v : ImagemorphthinningVector) -> ImagemorphthinningVector {
  let n = image_morph_thinning_vector_norm(v)
  if n < 0.0000001 { v } else { image_morph_thinning_vector_scale(v, 1.0 / n) }
}

pub fn image_morph_thinning_vector_dist(a : ImagemorphthinningVector, b : ImagemorphthinningVector) -> Double {
  image_morph_thinning_vector_norm(image_morph_thinning_vector_sub(a, b))
}

pub fn image_morph_thinning_vector_to_string(v : ImagemorphthinningVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn image_morph_thinning_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn image_morph_thinning_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = image_morph_thinning_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn image_morph_thinning_std(data : Array[Double]) -> Double { @_common.sqrt(image_morph_thinning_var(data)) }

pub fn image_morph_thinning_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = image_morph_thinning_mean(a); let mb = image_morph_thinning_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn image_morph_thinning_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = image_morph_thinning_std(a); let sb = image_morph_thinning_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { image_morph_thinning_cov(a, b) / (sa * sb) }
}

pub fn image_morph_thinning_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = image_morph_thinning_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn image_morph_thinning_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn image_morph_thinning_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn image_morph_thinning_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(image_morph_thinning_mse(pred, labels))
}

pub fn image_morph_thinning_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn image_morph_thinning_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = image_morph_thinning_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn image_morph_thinning_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn image_morph_thinning_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn image_morph_thinning_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = image_morph_thinning_precision(pred, labels, pos); let r = image_morph_thinning_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn image_morph_thinning_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn image_morph_thinning_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = image_morph_thinning_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn image_morph_thinning_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn image_morph_thinning_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn image_morph_thinning_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = image_morph_thinning_gcd(a, b)
    (a / g) * b
  }
}

pub fn image_morph_thinning_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn image_morph_thinning_fibonacci(n : Int) -> Int {
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

pub fn image_morph_thinning_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = image_morph_thinning_min(data); let mx = image_morph_thinning_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn image_morph_thinning_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = image_morph_thinning_mean(data); let sd = image_morph_thinning_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn image_morph_thinning_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn image_morph_thinning_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn image_morph_thinning_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn image_morph_thinning_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn image_morph_thinning_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn image_morph_thinning_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct ImagemorphthinningFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_thinning_frame_make(size : Int) -> ImagemorphthinningFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_thinning_frame_len(s : ImagemorphthinningFrame) -> Int { s.size }

pub fn image_morph_thinning_frame_get(s : ImagemorphthinningFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_thinning_frame_set(s : ImagemorphthinningFrame, i : Int, v : Double) -> ImagemorphthinningFrame {
  let result = image_morph_thinning_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_thinning_frame_sum(s : ImagemorphthinningFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_morph_thinning_frame_mean(s : ImagemorphthinningFrame) -> Double {
  if s.size == 0 { 0.0 } else { image_morph_thinning_frame_sum(s) / s.size.to_double() }
}

pub fn image_morph_thinning_frame_scale(s : ImagemorphthinningFrame, f : Double) -> ImagemorphthinningFrame {
  let result = image_morph_thinning_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_thinning_frame_add(a : ImagemorphthinningFrame, b : ImagemorphthinningFrame) -> ImagemorphthinningFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_thinning_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_thinning_frame_copy(s : ImagemorphthinningFrame) -> ImagemorphthinningFrame {
  let result = image_morph_thinning_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_thinning_frame_fill(s : ImagemorphthinningFrame, v : Double) -> ImagemorphthinningFrame {
  let result = image_morph_thinning_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_thinning_frame_min(s : ImagemorphthinningFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_thinning_frame_max(s : ImagemorphthinningFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_thinning_frame_to_string(s : ImagemorphthinningFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphthinningTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_thinning_table_make(size : Int) -> ImagemorphthinningTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_thinning_table_len(s : ImagemorphthinningTable) -> Int { s.size }

pub fn image_morph_thinning_table_get(s : ImagemorphthinningTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_thinning_table_set(s : ImagemorphthinningTable, i : Int, v : Double) -> ImagemorphthinningTable {
  let result = image_morph_thinning_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_thinning_table_sum(s : ImagemorphthinningTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_morph_thinning_table_mean(s : ImagemorphthinningTable) -> Double {
  if s.size == 0 { 0.0 } else { image_morph_thinning_table_sum(s) / s.size.to_double() }
}

pub fn image_morph_thinning_table_scale(s : ImagemorphthinningTable, f : Double) -> ImagemorphthinningTable {
  let result = image_morph_thinning_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_thinning_table_add(a : ImagemorphthinningTable, b : ImagemorphthinningTable) -> ImagemorphthinningTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_thinning_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_thinning_table_copy(s : ImagemorphthinningTable) -> ImagemorphthinningTable {
  let result = image_morph_thinning_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_thinning_table_fill(s : ImagemorphthinningTable, v : Double) -> ImagemorphthinningTable {
  let result = image_morph_thinning_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_thinning_table_min(s : ImagemorphthinningTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_thinning_table_max(s : ImagemorphthinningTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_thinning_table_to_string(s : ImagemorphthinningTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphthinningGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_thinning_graphn_make(size : Int) -> ImagemorphthinningGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_thinning_graphn_len(s : ImagemorphthinningGraphN) -> Int { s.size }

pub fn image_morph_thinning_graphn_get(s : ImagemorphthinningGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_thinning_graphn_set(s : ImagemorphthinningGraphN, i : Int, v : Double) -> ImagemorphthinningGraphN {
  let result = image_morph_thinning_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_thinning_graphn_sum(s : ImagemorphthinningGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_morph_thinning_graphn_mean(s : ImagemorphthinningGraphN) -> Double {
  if s.size == 0 { 0.0 } else { image_morph_thinning_graphn_sum(s) / s.size.to_double() }
}

pub fn image_morph_thinning_graphn_scale(s : ImagemorphthinningGraphN, f : Double) -> ImagemorphthinningGraphN {
  let result = image_morph_thinning_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_thinning_graphn_add(a : ImagemorphthinningGraphN, b : ImagemorphthinningGraphN) -> ImagemorphthinningGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_thinning_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_thinning_graphn_copy(s : ImagemorphthinningGraphN) -> ImagemorphthinningGraphN {
  let result = image_morph_thinning_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_thinning_graphn_fill(s : ImagemorphthinningGraphN, v : Double) -> ImagemorphthinningGraphN {
  let result = image_morph_thinning_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_thinning_graphn_min(s : ImagemorphthinningGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_thinning_graphn_max(s : ImagemorphthinningGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_thinning_graphn_to_string(s : ImagemorphthinningGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphthinningNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_thinning_node_make(size : Int) -> ImagemorphthinningNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_thinning_node_len(s : ImagemorphthinningNode) -> Int { s.size }

pub fn image_morph_thinning_node_get(s : ImagemorphthinningNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_thinning_node_set(s : ImagemorphthinningNode, i : Int, v : Double) -> ImagemorphthinningNode {
  let result = image_morph_thinning_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_thinning_node_sum(s : ImagemorphthinningNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_morph_thinning_node_mean(s : ImagemorphthinningNode) -> Double {
  if s.size == 0 { 0.0 } else { image_morph_thinning_node_sum(s) / s.size.to_double() }
}

pub fn image_morph_thinning_node_scale(s : ImagemorphthinningNode, f : Double) -> ImagemorphthinningNode {
  let result = image_morph_thinning_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_thinning_node_add(a : ImagemorphthinningNode, b : ImagemorphthinningNode) -> ImagemorphthinningNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_thinning_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_thinning_node_copy(s : ImagemorphthinningNode) -> ImagemorphthinningNode {
  let result = image_morph_thinning_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_thinning_node_fill(s : ImagemorphthinningNode, v : Double) -> ImagemorphthinningNode {
  let result = image_morph_thinning_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_thinning_node_min(s : ImagemorphthinningNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_thinning_node_max(s : ImagemorphthinningNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_thinning_node_to_string(s : ImagemorphthinningNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphthinningEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_thinning_edge_make(size : Int) -> ImagemorphthinningEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_thinning_edge_len(s : ImagemorphthinningEdge) -> Int { s.size }

pub fn image_morph_thinning_edge_get(s : ImagemorphthinningEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_thinning_edge_set(s : ImagemorphthinningEdge, i : Int, v : Double) -> ImagemorphthinningEdge {
  let result = image_morph_thinning_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_thinning_edge_sum(s : ImagemorphthinningEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_morph_thinning_edge_mean(s : ImagemorphthinningEdge) -> Double {
  if s.size == 0 { 0.0 } else { image_morph_thinning_edge_sum(s) / s.size.to_double() }
}

pub fn image_morph_thinning_edge_scale(s : ImagemorphthinningEdge, f : Double) -> ImagemorphthinningEdge {
  let result = image_morph_thinning_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_thinning_edge_add(a : ImagemorphthinningEdge, b : ImagemorphthinningEdge) -> ImagemorphthinningEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_thinning_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_thinning_edge_copy(s : ImagemorphthinningEdge) -> ImagemorphthinningEdge {
  let result = image_morph_thinning_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_thinning_edge_fill(s : ImagemorphthinningEdge, v : Double) -> ImagemorphthinningEdge {
  let result = image_morph_thinning_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_thinning_edge_min(s : ImagemorphthinningEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_thinning_edge_max(s : ImagemorphthinningEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_thinning_edge_to_string(s : ImagemorphthinningEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphthinningPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_thinning_path_make(size : Int) -> ImagemorphthinningPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_thinning_path_len(s : ImagemorphthinningPath) -> Int { s.size }

pub fn image_morph_thinning_path_get(s : ImagemorphthinningPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_thinning_path_set(s : ImagemorphthinningPath, i : Int, v : Double) -> ImagemorphthinningPath {
  let result = image_morph_thinning_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_thinning_path_sum(s : ImagemorphthinningPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_morph_thinning_path_mean(s : ImagemorphthinningPath) -> Double {
  if s.size == 0 { 0.0 } else { image_morph_thinning_path_sum(s) / s.size.to_double() }
}

pub fn image_morph_thinning_path_scale(s : ImagemorphthinningPath, f : Double) -> ImagemorphthinningPath {
  let result = image_morph_thinning_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_thinning_path_add(a : ImagemorphthinningPath, b : ImagemorphthinningPath) -> ImagemorphthinningPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_thinning_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_thinning_path_copy(s : ImagemorphthinningPath) -> ImagemorphthinningPath {
  let result = image_morph_thinning_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_thinning_path_fill(s : ImagemorphthinningPath, v : Double) -> ImagemorphthinningPath {
  let result = image_morph_thinning_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_thinning_path_min(s : ImagemorphthinningPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_thinning_path_max(s : ImagemorphthinningPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_thinning_path_to_string(s : ImagemorphthinningPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphthinningCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_thinning_cluster_make(size : Int) -> ImagemorphthinningCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_thinning_cluster_len(s : ImagemorphthinningCluster) -> Int { s.size }

pub fn image_morph_thinning_cluster_get(s : ImagemorphthinningCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_thinning_cluster_set(s : ImagemorphthinningCluster, i : Int, v : Double) -> ImagemorphthinningCluster {
  let result = image_morph_thinning_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_thinning_cluster_sum(s : ImagemorphthinningCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_morph_thinning_cluster_mean(s : ImagemorphthinningCluster) -> Double {
  if s.size == 0 { 0.0 } else { image_morph_thinning_cluster_sum(s) / s.size.to_double() }
}

pub fn image_morph_thinning_cluster_scale(s : ImagemorphthinningCluster, f : Double) -> ImagemorphthinningCluster {
  let result = image_morph_thinning_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_thinning_cluster_add(a : ImagemorphthinningCluster, b : ImagemorphthinningCluster) -> ImagemorphthinningCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_thinning_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_thinning_cluster_copy(s : ImagemorphthinningCluster) -> ImagemorphthinningCluster {
  let result = image_morph_thinning_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_thinning_cluster_fill(s : ImagemorphthinningCluster, v : Double) -> ImagemorphthinningCluster {
  let result = image_morph_thinning_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_thinning_cluster_min(s : ImagemorphthinningCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_thinning_cluster_max(s : ImagemorphthinningCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_thinning_cluster_to_string(s : ImagemorphthinningCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphthinningModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_thinning_model_make(size : Int) -> ImagemorphthinningModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_thinning_model_len(s : ImagemorphthinningModel) -> Int { s.size }

pub fn image_morph_thinning_model_get(s : ImagemorphthinningModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_thinning_model_set(s : ImagemorphthinningModel, i : Int, v : Double) -> ImagemorphthinningModel {
  let result = image_morph_thinning_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_thinning_model_sum(s : ImagemorphthinningModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_morph_thinning_model_mean(s : ImagemorphthinningModel) -> Double {
  if s.size == 0 { 0.0 } else { image_morph_thinning_model_sum(s) / s.size.to_double() }
}

pub fn image_morph_thinning_model_scale(s : ImagemorphthinningModel, f : Double) -> ImagemorphthinningModel {
  let result = image_morph_thinning_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_thinning_model_add(a : ImagemorphthinningModel, b : ImagemorphthinningModel) -> ImagemorphthinningModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_thinning_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_thinning_model_copy(s : ImagemorphthinningModel) -> ImagemorphthinningModel {
  let result = image_morph_thinning_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_thinning_model_fill(s : ImagemorphthinningModel, v : Double) -> ImagemorphthinningModel {
  let result = image_morph_thinning_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_thinning_model_min(s : ImagemorphthinningModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_thinning_model_max(s : ImagemorphthinningModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_thinning_model_to_string(s : ImagemorphthinningModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphthinningLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_thinning_layer_make(size : Int) -> ImagemorphthinningLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_thinning_layer_len(s : ImagemorphthinningLayer) -> Int { s.size }

pub fn image_morph_thinning_layer_get(s : ImagemorphthinningLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_thinning_layer_set(s : ImagemorphthinningLayer, i : Int, v : Double) -> ImagemorphthinningLayer {
  let result = image_morph_thinning_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_thinning_layer_sum(s : ImagemorphthinningLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_morph_thinning_layer_mean(s : ImagemorphthinningLayer) -> Double {
  if s.size == 0 { 0.0 } else { image_morph_thinning_layer_sum(s) / s.size.to_double() }
}

pub fn image_morph_thinning_layer_scale(s : ImagemorphthinningLayer, f : Double) -> ImagemorphthinningLayer {
  let result = image_morph_thinning_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_thinning_layer_add(a : ImagemorphthinningLayer, b : ImagemorphthinningLayer) -> ImagemorphthinningLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_thinning_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_thinning_layer_copy(s : ImagemorphthinningLayer) -> ImagemorphthinningLayer {
  let result = image_morph_thinning_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_thinning_layer_fill(s : ImagemorphthinningLayer, v : Double) -> ImagemorphthinningLayer {
  let result = image_morph_thinning_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_thinning_layer_min(s : ImagemorphthinningLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_thinning_layer_max(s : ImagemorphthinningLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_thinning_layer_to_string(s : ImagemorphthinningLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphthinningBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_thinning_buffer_make(size : Int) -> ImagemorphthinningBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_thinning_buffer_len(s : ImagemorphthinningBuffer) -> Int { s.size }

pub fn image_morph_thinning_buffer_get(s : ImagemorphthinningBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_thinning_buffer_set(s : ImagemorphthinningBuffer, i : Int, v : Double) -> ImagemorphthinningBuffer {
  let result = image_morph_thinning_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_thinning_buffer_sum(s : ImagemorphthinningBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_morph_thinning_buffer_mean(s : ImagemorphthinningBuffer) -> Double {
  if s.size == 0 { 0.0 } else { image_morph_thinning_buffer_sum(s) / s.size.to_double() }
}

pub fn image_morph_thinning_buffer_scale(s : ImagemorphthinningBuffer, f : Double) -> ImagemorphthinningBuffer {
  let result = image_morph_thinning_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_thinning_buffer_add(a : ImagemorphthinningBuffer, b : ImagemorphthinningBuffer) -> ImagemorphthinningBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_thinning_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_thinning_buffer_copy(s : ImagemorphthinningBuffer) -> ImagemorphthinningBuffer {
  let result = image_morph_thinning_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_thinning_buffer_fill(s : ImagemorphthinningBuffer, v : Double) -> ImagemorphthinningBuffer {
  let result = image_morph_thinning_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_thinning_buffer_min(s : ImagemorphthinningBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_thinning_buffer_max(s : ImagemorphthinningBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_thinning_buffer_to_string(s : ImagemorphthinningBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphthinningCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_thinning_cursor_make(size : Int) -> ImagemorphthinningCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_thinning_cursor_len(s : ImagemorphthinningCursor) -> Int { s.size }

pub fn image_morph_thinning_cursor_get(s : ImagemorphthinningCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_thinning_cursor_set(s : ImagemorphthinningCursor, i : Int, v : Double) -> ImagemorphthinningCursor {
  let result = image_morph_thinning_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_thinning_cursor_sum(s : ImagemorphthinningCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_morph_thinning_cursor_mean(s : ImagemorphthinningCursor) -> Double {
  if s.size == 0 { 0.0 } else { image_morph_thinning_cursor_sum(s) / s.size.to_double() }
}

pub fn image_morph_thinning_cursor_scale(s : ImagemorphthinningCursor, f : Double) -> ImagemorphthinningCursor {
  let result = image_morph_thinning_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_thinning_cursor_add(a : ImagemorphthinningCursor, b : ImagemorphthinningCursor) -> ImagemorphthinningCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_thinning_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_thinning_cursor_copy(s : ImagemorphthinningCursor) -> ImagemorphthinningCursor {
  let result = image_morph_thinning_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_thinning_cursor_fill(s : ImagemorphthinningCursor, v : Double) -> ImagemorphthinningCursor {
  let result = image_morph_thinning_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_thinning_cursor_min(s : ImagemorphthinningCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_thinning_cursor_max(s : ImagemorphthinningCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_thinning_cursor_to_string(s : ImagemorphthinningCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphthinningView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_thinning_view_make(size : Int) -> ImagemorphthinningView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_thinning_view_len(s : ImagemorphthinningView) -> Int { s.size }

pub fn image_morph_thinning_view_get(s : ImagemorphthinningView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_thinning_view_set(s : ImagemorphthinningView, i : Int, v : Double) -> ImagemorphthinningView {
  let result = image_morph_thinning_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_thinning_view_sum(s : ImagemorphthinningView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_morph_thinning_view_mean(s : ImagemorphthinningView) -> Double {
  if s.size == 0 { 0.0 } else { image_morph_thinning_view_sum(s) / s.size.to_double() }
}

pub fn image_morph_thinning_view_scale(s : ImagemorphthinningView, f : Double) -> ImagemorphthinningView {
  let result = image_morph_thinning_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_thinning_view_add(a : ImagemorphthinningView, b : ImagemorphthinningView) -> ImagemorphthinningView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_thinning_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_thinning_view_copy(s : ImagemorphthinningView) -> ImagemorphthinningView {
  let result = image_morph_thinning_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_thinning_view_fill(s : ImagemorphthinningView, v : Double) -> ImagemorphthinningView {
  let result = image_morph_thinning_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_thinning_view_min(s : ImagemorphthinningView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_thinning_view_max(s : ImagemorphthinningView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_thinning_view_to_string(s : ImagemorphthinningView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphthinningRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_thinning_range_make(size : Int) -> ImagemorphthinningRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_thinning_range_len(s : ImagemorphthinningRange) -> Int { s.size }

pub fn image_morph_thinning_range_get(s : ImagemorphthinningRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_thinning_range_set(s : ImagemorphthinningRange, i : Int, v : Double) -> ImagemorphthinningRange {
  let result = image_morph_thinning_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_thinning_range_sum(s : ImagemorphthinningRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_morph_thinning_range_mean(s : ImagemorphthinningRange) -> Double {
  if s.size == 0 { 0.0 } else { image_morph_thinning_range_sum(s) / s.size.to_double() }
}

pub fn image_morph_thinning_range_scale(s : ImagemorphthinningRange, f : Double) -> ImagemorphthinningRange {
  let result = image_morph_thinning_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_thinning_range_add(a : ImagemorphthinningRange, b : ImagemorphthinningRange) -> ImagemorphthinningRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_thinning_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_thinning_range_copy(s : ImagemorphthinningRange) -> ImagemorphthinningRange {
  let result = image_morph_thinning_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_thinning_range_fill(s : ImagemorphthinningRange, v : Double) -> ImagemorphthinningRange {
  let result = image_morph_thinning_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_thinning_range_min(s : ImagemorphthinningRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_thinning_range_max(s : ImagemorphthinningRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_thinning_range_to_string(s : ImagemorphthinningRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphthinningSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_thinning_slice_make(size : Int) -> ImagemorphthinningSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_thinning_slice_len(s : ImagemorphthinningSlice) -> Int { s.size }

pub fn image_morph_thinning_slice_get(s : ImagemorphthinningSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_thinning_slice_set(s : ImagemorphthinningSlice, i : Int, v : Double) -> ImagemorphthinningSlice {
  let result = image_morph_thinning_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_thinning_slice_sum(s : ImagemorphthinningSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_morph_thinning_slice_mean(s : ImagemorphthinningSlice) -> Double {
  if s.size == 0 { 0.0 } else { image_morph_thinning_slice_sum(s) / s.size.to_double() }
}

pub fn image_morph_thinning_slice_scale(s : ImagemorphthinningSlice, f : Double) -> ImagemorphthinningSlice {
  let result = image_morph_thinning_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_thinning_slice_add(a : ImagemorphthinningSlice, b : ImagemorphthinningSlice) -> ImagemorphthinningSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_thinning_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_thinning_slice_copy(s : ImagemorphthinningSlice) -> ImagemorphthinningSlice {
  let result = image_morph_thinning_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_thinning_slice_fill(s : ImagemorphthinningSlice, v : Double) -> ImagemorphthinningSlice {
  let result = image_morph_thinning_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_thinning_slice_min(s : ImagemorphthinningSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_thinning_slice_max(s : ImagemorphthinningSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_thinning_slice_to_string(s : ImagemorphthinningSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


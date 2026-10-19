///===
/// extcore/image_morph_hit_miss

pub(all) struct ImagemorphhitmissPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_morph_hit_miss_make_point(x : Double, y : Double) -> ImagemorphhitmissPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_morph_hit_miss_make_point3(x : Double, y : Double, z : Double) -> ImagemorphhitmissPoint {
  { x, y, z, label: 0 }
}

pub fn image_morph_hit_miss_point_x(pt : ImagemorphhitmissPoint) -> Double { pt.x }

pub fn image_morph_hit_miss_point_y(pt : ImagemorphhitmissPoint) -> Double { pt.y }

pub fn image_morph_hit_miss_point_z(pt : ImagemorphhitmissPoint) -> Double { pt.z }

pub fn image_morph_hit_miss_point_label(pt : ImagemorphhitmissPoint) -> Int { pt.label }

pub fn image_morph_hit_miss_point_dist(a : ImagemorphhitmissPoint, b : ImagemorphhitmissPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  image_morph_hit_miss_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn image_morph_hit_miss_point_add(a : ImagemorphhitmissPoint, b : ImagemorphhitmissPoint) -> ImagemorphhitmissPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn image_morph_hit_miss_point_sub(a : ImagemorphhitmissPoint, b : ImagemorphhitmissPoint) -> ImagemorphhitmissPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn image_morph_hit_miss_point_scale(pt : ImagemorphhitmissPoint, s : Double) -> ImagemorphhitmissPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn image_morph_hit_miss_point_dot(a : ImagemorphhitmissPoint, b : ImagemorphhitmissPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn image_morph_hit_miss_point_cross(a : ImagemorphhitmissPoint, b : ImagemorphhitmissPoint) -> ImagemorphhitmissPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn image_morph_hit_miss_point_norm(pt : ImagemorphhitmissPoint) -> Double {
  image_morph_hit_miss_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn image_morph_hit_miss_point_normalize(pt : ImagemorphhitmissPoint) -> ImagemorphhitmissPoint {
  let n = image_morph_hit_miss_point_norm(pt)
  if n < 0.0000001 { pt } else { image_morph_hit_miss_point_scale(pt, 1.0 / n) }
}

pub fn image_morph_hit_miss_point_negate(pt : ImagemorphhitmissPoint) -> ImagemorphhitmissPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn image_morph_hit_miss_point_mid(a : ImagemorphhitmissPoint, b : ImagemorphhitmissPoint) -> ImagemorphhitmissPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn image_morph_hit_miss_point_lerp(a : ImagemorphhitmissPoint, b : ImagemorphhitmissPoint, t : Double) -> ImagemorphhitmissPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn image_morph_hit_miss_point_to_string(pt : ImagemorphhitmissPoint) -> String {
  "(" + image_morph_hit_miss_dbl(pt.x) + ", " + image_morph_hit_miss_dbl(pt.y) + ", " + image_morph_hit_miss_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct ImagemorphhitmissSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_morph_hit_miss_make_series(vals : Array[Double], name : String) -> ImagemorphhitmissSeries {
  { vals, name, meta: 0 }
}

pub fn image_morph_hit_miss_series_len(s : ImagemorphhitmissSeries) -> Int { s.vals.length() }

pub fn image_morph_hit_miss_series_sum(s : ImagemorphhitmissSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn image_morph_hit_miss_series_mean(s : ImagemorphhitmissSeries) -> Double {
  let n = image_morph_hit_miss_series_len(s)
  if n == 0 { 0.0 } else { image_morph_hit_miss_series_sum(s) / n.to_double() }
}

pub fn image_morph_hit_miss_series_min(s : ImagemorphhitmissSeries) -> Double {
  let n = image_morph_hit_miss_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn image_morph_hit_miss_series_max(s : ImagemorphhitmissSeries) -> Double {
  let n = image_morph_hit_miss_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn image_morph_hit_miss_series_range(s : ImagemorphhitmissSeries) -> Double {
  image_morph_hit_miss_series_max(s) - image_morph_hit_miss_series_min(s)
}

pub fn image_morph_hit_miss_series_var(s : ImagemorphhitmissSeries) -> Double {
  let n = image_morph_hit_miss_series_len(s)
  if n == 0 { 0.0 } else {
    let m = image_morph_hit_miss_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn image_morph_hit_miss_series_std(s : ImagemorphhitmissSeries) -> Double { image_morph_hit_miss_sqrt(image_morph_hit_miss_series_var(s)) }

pub fn image_morph_hit_miss_series_median(s : ImagemorphhitmissSeries) -> Double {
  let n = image_morph_hit_miss_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = image_morph_hit_miss_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn image_morph_hit_miss_series_scale(s : ImagemorphhitmissSeries, f : Double) -> ImagemorphhitmissSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = image_morph_hit_miss_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn image_morph_hit_miss_series_add(a : ImagemorphhitmissSeries, b : ImagemorphhitmissSeries) -> ImagemorphhitmissSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = image_morph_hit_miss_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn image_morph_hit_miss_series_sub(a : ImagemorphhitmissSeries, b : ImagemorphhitmissSeries) -> ImagemorphhitmissSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = image_morph_hit_miss_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn image_morph_hit_miss_series_normalize(s : ImagemorphhitmissSeries) -> ImagemorphhitmissSeries {
  let mn = image_morph_hit_miss_series_min(s)
  let mx = image_morph_hit_miss_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = image_morph_hit_miss_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn image_morph_hit_miss_series_cumsum(s : ImagemorphhitmissSeries) -> ImagemorphhitmissSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = image_morph_hit_miss_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn image_morph_hit_miss_series_to_string(s : ImagemorphhitmissSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + image_morph_hit_miss_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagemorphhitmissMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_morph_hit_miss_make_matrix(rows : Int, cols : Int, val : Double) -> ImagemorphhitmissMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn image_morph_hit_miss_matrix_identity(n : Int) -> ImagemorphhitmissMatrix {
  let m = image_morph_hit_miss_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn image_morph_hit_miss_matrix_get(m : ImagemorphhitmissMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn image_morph_hit_miss_matrix_transpose(m : ImagemorphhitmissMatrix) -> ImagemorphhitmissMatrix {
  let result = image_morph_hit_miss_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn image_morph_hit_miss_matrix_add(a : ImagemorphhitmissMatrix, b : ImagemorphhitmissMatrix) -> ImagemorphhitmissMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = image_morph_hit_miss_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn image_morph_hit_miss_matrix_scale(m : ImagemorphhitmissMatrix, s : Double) -> ImagemorphhitmissMatrix {
  let result = image_morph_hit_miss_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn image_morph_hit_miss_matrix_multiply(a : ImagemorphhitmissMatrix, b : ImagemorphhitmissMatrix) -> ImagemorphhitmissMatrix {
  if a.cols != b.rows { return image_morph_hit_miss_make_matrix(a.rows, b.cols, 0.0) }
  let result = image_morph_hit_miss_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn image_morph_hit_miss_matrix_trace(m : ImagemorphhitmissMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn image_morph_hit_miss_matrix_det(m : ImagemorphhitmissMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn image_morph_hit_miss_matrix_norm(m : ImagemorphhitmissMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  image_morph_hit_miss_sqrt(sum)
}

pub fn image_morph_hit_miss_matrix_to_string(m : ImagemorphhitmissMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + image_morph_hit_miss_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct ImagemorphhitmissVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_morph_hit_miss_make_vector(comps : Array[Double]) -> ImagemorphhitmissVector {
  { comps, dim: comps.length() }
}

pub fn image_morph_hit_miss_vector_zero(dim : Int) -> ImagemorphhitmissVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn image_morph_hit_miss_vector_add(a : ImagemorphhitmissVector, b : ImagemorphhitmissVector) -> ImagemorphhitmissVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = image_morph_hit_miss_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn image_morph_hit_miss_vector_sub(a : ImagemorphhitmissVector, b : ImagemorphhitmissVector) -> ImagemorphhitmissVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = image_morph_hit_miss_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn image_morph_hit_miss_vector_scale(v : ImagemorphhitmissVector, s : Double) -> ImagemorphhitmissVector {
  let mut result = []
  for i in 0..<v.dim { result = image_morph_hit_miss_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn image_morph_hit_miss_vector_dot(a : ImagemorphhitmissVector, b : ImagemorphhitmissVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn image_morph_hit_miss_vector_norm(v : ImagemorphhitmissVector) -> Double { image_morph_hit_miss_sqrt(image_morph_hit_miss_vector_dot(v, v)) }

pub fn image_morph_hit_miss_vector_normalize(v : ImagemorphhitmissVector) -> ImagemorphhitmissVector {
  let n = image_morph_hit_miss_vector_norm(v)
  if n < 0.0000001 { v } else { image_morph_hit_miss_vector_scale(v, 1.0 / n) }
}

pub fn image_morph_hit_miss_vector_dist(a : ImagemorphhitmissVector, b : ImagemorphhitmissVector) -> Double {
  image_morph_hit_miss_vector_norm(image_morph_hit_miss_vector_sub(a, b))
}

pub fn image_morph_hit_miss_vector_to_string(v : ImagemorphhitmissVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + image_morph_hit_miss_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn image_morph_hit_miss_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn image_morph_hit_miss_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = image_morph_hit_miss_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn image_morph_hit_miss_std(data : Array[Double]) -> Double { image_morph_hit_miss_sqrt(image_morph_hit_miss_var(data)) }

pub fn image_morph_hit_miss_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = image_morph_hit_miss_mean(a); let mb = image_morph_hit_miss_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn image_morph_hit_miss_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = image_morph_hit_miss_std(a); let sb = image_morph_hit_miss_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { image_morph_hit_miss_cov(a, b) / (sa * sb) }
}

pub fn image_morph_hit_miss_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = image_morph_hit_miss_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn image_morph_hit_miss_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn image_morph_hit_miss_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn image_morph_hit_miss_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  image_morph_hit_miss_sqrt(image_morph_hit_miss_mse(pred, labels))
}

pub fn image_morph_hit_miss_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + image_morph_hit_miss_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn image_morph_hit_miss_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = image_morph_hit_miss_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn image_morph_hit_miss_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn image_morph_hit_miss_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn image_morph_hit_miss_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = image_morph_hit_miss_precision(pred, labels, pos); let r = image_morph_hit_miss_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn image_morph_hit_miss_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn image_morph_hit_miss_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = image_morph_hit_miss_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn image_morph_hit_miss_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn image_morph_hit_miss_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn image_morph_hit_miss_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = image_morph_hit_miss_gcd(a, b)
    (a / g) * b
  }
}

pub fn image_morph_hit_miss_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn image_morph_hit_miss_fibonacci(n : Int) -> Int {
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

pub fn image_morph_hit_miss_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = image_morph_hit_miss_min(data); let mx = image_morph_hit_miss_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn image_morph_hit_miss_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = image_morph_hit_miss_mean(data); let sd = image_morph_hit_miss_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn image_morph_hit_miss_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn image_morph_hit_miss_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn image_morph_hit_miss_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn image_morph_hit_miss_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn image_morph_hit_miss_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn image_morph_hit_miss_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn image_morph_hit_miss_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn image_morph_hit_miss_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn image_morph_hit_miss_dbl(x : Double) -> String {
  let i = if x >= 0.0 { image_morph_hit_miss_int(x) } else { -image_morph_hit_miss_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { image_morph_hit_miss_int(f * 1000000.0) } else { image_morph_hit_miss_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn image_morph_hit_miss_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn image_morph_hit_miss_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct ImagemorphhitmissFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_hit_miss_frame_make(size : Int) -> ImagemorphhitmissFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_hit_miss_frame_len(s : ImagemorphhitmissFrame) -> Int { s.size }

pub fn image_morph_hit_miss_frame_get(s : ImagemorphhitmissFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_hit_miss_frame_set(s : ImagemorphhitmissFrame, i : Int, v : Double) -> ImagemorphhitmissFrame {
  let result = image_morph_hit_miss_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_hit_miss_frame_sum(s : ImagemorphhitmissFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_morph_hit_miss_frame_mean(s : ImagemorphhitmissFrame) -> Double {
  if s.size == 0 { 0.0 } else { image_morph_hit_miss_frame_sum(s) / s.size.to_double() }
}

pub fn image_morph_hit_miss_frame_scale(s : ImagemorphhitmissFrame, f : Double) -> ImagemorphhitmissFrame {
  let result = image_morph_hit_miss_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_hit_miss_frame_add(a : ImagemorphhitmissFrame, b : ImagemorphhitmissFrame) -> ImagemorphhitmissFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_hit_miss_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_hit_miss_frame_copy(s : ImagemorphhitmissFrame) -> ImagemorphhitmissFrame {
  let result = image_morph_hit_miss_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_hit_miss_frame_fill(s : ImagemorphhitmissFrame, v : Double) -> ImagemorphhitmissFrame {
  let result = image_morph_hit_miss_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_hit_miss_frame_min(s : ImagemorphhitmissFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_hit_miss_frame_max(s : ImagemorphhitmissFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_hit_miss_frame_to_string(s : ImagemorphhitmissFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphhitmissTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_hit_miss_table_make(size : Int) -> ImagemorphhitmissTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_hit_miss_table_len(s : ImagemorphhitmissTable) -> Int { s.size }

pub fn image_morph_hit_miss_table_get(s : ImagemorphhitmissTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_hit_miss_table_set(s : ImagemorphhitmissTable, i : Int, v : Double) -> ImagemorphhitmissTable {
  let result = image_morph_hit_miss_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_hit_miss_table_sum(s : ImagemorphhitmissTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_morph_hit_miss_table_mean(s : ImagemorphhitmissTable) -> Double {
  if s.size == 0 { 0.0 } else { image_morph_hit_miss_table_sum(s) / s.size.to_double() }
}

pub fn image_morph_hit_miss_table_scale(s : ImagemorphhitmissTable, f : Double) -> ImagemorphhitmissTable {
  let result = image_morph_hit_miss_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_hit_miss_table_add(a : ImagemorphhitmissTable, b : ImagemorphhitmissTable) -> ImagemorphhitmissTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_hit_miss_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_hit_miss_table_copy(s : ImagemorphhitmissTable) -> ImagemorphhitmissTable {
  let result = image_morph_hit_miss_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_hit_miss_table_fill(s : ImagemorphhitmissTable, v : Double) -> ImagemorphhitmissTable {
  let result = image_morph_hit_miss_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_hit_miss_table_min(s : ImagemorphhitmissTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_hit_miss_table_max(s : ImagemorphhitmissTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_hit_miss_table_to_string(s : ImagemorphhitmissTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphhitmissGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_hit_miss_graphn_make(size : Int) -> ImagemorphhitmissGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_hit_miss_graphn_len(s : ImagemorphhitmissGraphN) -> Int { s.size }

pub fn image_morph_hit_miss_graphn_get(s : ImagemorphhitmissGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_hit_miss_graphn_set(s : ImagemorphhitmissGraphN, i : Int, v : Double) -> ImagemorphhitmissGraphN {
  let result = image_morph_hit_miss_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_hit_miss_graphn_sum(s : ImagemorphhitmissGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_morph_hit_miss_graphn_mean(s : ImagemorphhitmissGraphN) -> Double {
  if s.size == 0 { 0.0 } else { image_morph_hit_miss_graphn_sum(s) / s.size.to_double() }
}

pub fn image_morph_hit_miss_graphn_scale(s : ImagemorphhitmissGraphN, f : Double) -> ImagemorphhitmissGraphN {
  let result = image_morph_hit_miss_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_hit_miss_graphn_add(a : ImagemorphhitmissGraphN, b : ImagemorphhitmissGraphN) -> ImagemorphhitmissGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_hit_miss_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_hit_miss_graphn_copy(s : ImagemorphhitmissGraphN) -> ImagemorphhitmissGraphN {
  let result = image_morph_hit_miss_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_hit_miss_graphn_fill(s : ImagemorphhitmissGraphN, v : Double) -> ImagemorphhitmissGraphN {
  let result = image_morph_hit_miss_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_hit_miss_graphn_min(s : ImagemorphhitmissGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_hit_miss_graphn_max(s : ImagemorphhitmissGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_hit_miss_graphn_to_string(s : ImagemorphhitmissGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphhitmissNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_hit_miss_node_make(size : Int) -> ImagemorphhitmissNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_hit_miss_node_len(s : ImagemorphhitmissNode) -> Int { s.size }

pub fn image_morph_hit_miss_node_get(s : ImagemorphhitmissNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_hit_miss_node_set(s : ImagemorphhitmissNode, i : Int, v : Double) -> ImagemorphhitmissNode {
  let result = image_morph_hit_miss_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_hit_miss_node_sum(s : ImagemorphhitmissNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_morph_hit_miss_node_mean(s : ImagemorphhitmissNode) -> Double {
  if s.size == 0 { 0.0 } else { image_morph_hit_miss_node_sum(s) / s.size.to_double() }
}

pub fn image_morph_hit_miss_node_scale(s : ImagemorphhitmissNode, f : Double) -> ImagemorphhitmissNode {
  let result = image_morph_hit_miss_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_hit_miss_node_add(a : ImagemorphhitmissNode, b : ImagemorphhitmissNode) -> ImagemorphhitmissNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_hit_miss_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_hit_miss_node_copy(s : ImagemorphhitmissNode) -> ImagemorphhitmissNode {
  let result = image_morph_hit_miss_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_hit_miss_node_fill(s : ImagemorphhitmissNode, v : Double) -> ImagemorphhitmissNode {
  let result = image_morph_hit_miss_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_hit_miss_node_min(s : ImagemorphhitmissNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_hit_miss_node_max(s : ImagemorphhitmissNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_hit_miss_node_to_string(s : ImagemorphhitmissNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphhitmissEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_hit_miss_edge_make(size : Int) -> ImagemorphhitmissEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_hit_miss_edge_len(s : ImagemorphhitmissEdge) -> Int { s.size }

pub fn image_morph_hit_miss_edge_get(s : ImagemorphhitmissEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_hit_miss_edge_set(s : ImagemorphhitmissEdge, i : Int, v : Double) -> ImagemorphhitmissEdge {
  let result = image_morph_hit_miss_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_hit_miss_edge_sum(s : ImagemorphhitmissEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_morph_hit_miss_edge_mean(s : ImagemorphhitmissEdge) -> Double {
  if s.size == 0 { 0.0 } else { image_morph_hit_miss_edge_sum(s) / s.size.to_double() }
}

pub fn image_morph_hit_miss_edge_scale(s : ImagemorphhitmissEdge, f : Double) -> ImagemorphhitmissEdge {
  let result = image_morph_hit_miss_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_hit_miss_edge_add(a : ImagemorphhitmissEdge, b : ImagemorphhitmissEdge) -> ImagemorphhitmissEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_hit_miss_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_hit_miss_edge_copy(s : ImagemorphhitmissEdge) -> ImagemorphhitmissEdge {
  let result = image_morph_hit_miss_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_hit_miss_edge_fill(s : ImagemorphhitmissEdge, v : Double) -> ImagemorphhitmissEdge {
  let result = image_morph_hit_miss_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_hit_miss_edge_min(s : ImagemorphhitmissEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_hit_miss_edge_max(s : ImagemorphhitmissEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_hit_miss_edge_to_string(s : ImagemorphhitmissEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphhitmissPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_hit_miss_path_make(size : Int) -> ImagemorphhitmissPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_hit_miss_path_len(s : ImagemorphhitmissPath) -> Int { s.size }

pub fn image_morph_hit_miss_path_get(s : ImagemorphhitmissPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_hit_miss_path_set(s : ImagemorphhitmissPath, i : Int, v : Double) -> ImagemorphhitmissPath {
  let result = image_morph_hit_miss_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_hit_miss_path_sum(s : ImagemorphhitmissPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_morph_hit_miss_path_mean(s : ImagemorphhitmissPath) -> Double {
  if s.size == 0 { 0.0 } else { image_morph_hit_miss_path_sum(s) / s.size.to_double() }
}

pub fn image_morph_hit_miss_path_scale(s : ImagemorphhitmissPath, f : Double) -> ImagemorphhitmissPath {
  let result = image_morph_hit_miss_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_hit_miss_path_add(a : ImagemorphhitmissPath, b : ImagemorphhitmissPath) -> ImagemorphhitmissPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_hit_miss_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_hit_miss_path_copy(s : ImagemorphhitmissPath) -> ImagemorphhitmissPath {
  let result = image_morph_hit_miss_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_hit_miss_path_fill(s : ImagemorphhitmissPath, v : Double) -> ImagemorphhitmissPath {
  let result = image_morph_hit_miss_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_hit_miss_path_min(s : ImagemorphhitmissPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_hit_miss_path_max(s : ImagemorphhitmissPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_hit_miss_path_to_string(s : ImagemorphhitmissPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphhitmissCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_hit_miss_cluster_make(size : Int) -> ImagemorphhitmissCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_hit_miss_cluster_len(s : ImagemorphhitmissCluster) -> Int { s.size }

pub fn image_morph_hit_miss_cluster_get(s : ImagemorphhitmissCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_hit_miss_cluster_set(s : ImagemorphhitmissCluster, i : Int, v : Double) -> ImagemorphhitmissCluster {
  let result = image_morph_hit_miss_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_hit_miss_cluster_sum(s : ImagemorphhitmissCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_morph_hit_miss_cluster_mean(s : ImagemorphhitmissCluster) -> Double {
  if s.size == 0 { 0.0 } else { image_morph_hit_miss_cluster_sum(s) / s.size.to_double() }
}

pub fn image_morph_hit_miss_cluster_scale(s : ImagemorphhitmissCluster, f : Double) -> ImagemorphhitmissCluster {
  let result = image_morph_hit_miss_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_hit_miss_cluster_add(a : ImagemorphhitmissCluster, b : ImagemorphhitmissCluster) -> ImagemorphhitmissCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_hit_miss_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_hit_miss_cluster_copy(s : ImagemorphhitmissCluster) -> ImagemorphhitmissCluster {
  let result = image_morph_hit_miss_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_hit_miss_cluster_fill(s : ImagemorphhitmissCluster, v : Double) -> ImagemorphhitmissCluster {
  let result = image_morph_hit_miss_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_hit_miss_cluster_min(s : ImagemorphhitmissCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_hit_miss_cluster_max(s : ImagemorphhitmissCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_hit_miss_cluster_to_string(s : ImagemorphhitmissCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphhitmissModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_hit_miss_model_make(size : Int) -> ImagemorphhitmissModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_hit_miss_model_len(s : ImagemorphhitmissModel) -> Int { s.size }

pub fn image_morph_hit_miss_model_get(s : ImagemorphhitmissModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_hit_miss_model_set(s : ImagemorphhitmissModel, i : Int, v : Double) -> ImagemorphhitmissModel {
  let result = image_morph_hit_miss_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_hit_miss_model_sum(s : ImagemorphhitmissModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_morph_hit_miss_model_mean(s : ImagemorphhitmissModel) -> Double {
  if s.size == 0 { 0.0 } else { image_morph_hit_miss_model_sum(s) / s.size.to_double() }
}

pub fn image_morph_hit_miss_model_scale(s : ImagemorphhitmissModel, f : Double) -> ImagemorphhitmissModel {
  let result = image_morph_hit_miss_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_hit_miss_model_add(a : ImagemorphhitmissModel, b : ImagemorphhitmissModel) -> ImagemorphhitmissModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_hit_miss_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_hit_miss_model_copy(s : ImagemorphhitmissModel) -> ImagemorphhitmissModel {
  let result = image_morph_hit_miss_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_hit_miss_model_fill(s : ImagemorphhitmissModel, v : Double) -> ImagemorphhitmissModel {
  let result = image_morph_hit_miss_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_hit_miss_model_min(s : ImagemorphhitmissModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_hit_miss_model_max(s : ImagemorphhitmissModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_hit_miss_model_to_string(s : ImagemorphhitmissModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphhitmissLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_hit_miss_layer_make(size : Int) -> ImagemorphhitmissLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_hit_miss_layer_len(s : ImagemorphhitmissLayer) -> Int { s.size }

pub fn image_morph_hit_miss_layer_get(s : ImagemorphhitmissLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_hit_miss_layer_set(s : ImagemorphhitmissLayer, i : Int, v : Double) -> ImagemorphhitmissLayer {
  let result = image_morph_hit_miss_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_hit_miss_layer_sum(s : ImagemorphhitmissLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_morph_hit_miss_layer_mean(s : ImagemorphhitmissLayer) -> Double {
  if s.size == 0 { 0.0 } else { image_morph_hit_miss_layer_sum(s) / s.size.to_double() }
}

pub fn image_morph_hit_miss_layer_scale(s : ImagemorphhitmissLayer, f : Double) -> ImagemorphhitmissLayer {
  let result = image_morph_hit_miss_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_hit_miss_layer_add(a : ImagemorphhitmissLayer, b : ImagemorphhitmissLayer) -> ImagemorphhitmissLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_hit_miss_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_hit_miss_layer_copy(s : ImagemorphhitmissLayer) -> ImagemorphhitmissLayer {
  let result = image_morph_hit_miss_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_hit_miss_layer_fill(s : ImagemorphhitmissLayer, v : Double) -> ImagemorphhitmissLayer {
  let result = image_morph_hit_miss_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_hit_miss_layer_min(s : ImagemorphhitmissLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_hit_miss_layer_max(s : ImagemorphhitmissLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_hit_miss_layer_to_string(s : ImagemorphhitmissLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphhitmissBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_hit_miss_buffer_make(size : Int) -> ImagemorphhitmissBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_hit_miss_buffer_len(s : ImagemorphhitmissBuffer) -> Int { s.size }

pub fn image_morph_hit_miss_buffer_get(s : ImagemorphhitmissBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_hit_miss_buffer_set(s : ImagemorphhitmissBuffer, i : Int, v : Double) -> ImagemorphhitmissBuffer {
  let result = image_morph_hit_miss_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_hit_miss_buffer_sum(s : ImagemorphhitmissBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_morph_hit_miss_buffer_mean(s : ImagemorphhitmissBuffer) -> Double {
  if s.size == 0 { 0.0 } else { image_morph_hit_miss_buffer_sum(s) / s.size.to_double() }
}

pub fn image_morph_hit_miss_buffer_scale(s : ImagemorphhitmissBuffer, f : Double) -> ImagemorphhitmissBuffer {
  let result = image_morph_hit_miss_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_hit_miss_buffer_add(a : ImagemorphhitmissBuffer, b : ImagemorphhitmissBuffer) -> ImagemorphhitmissBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_hit_miss_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_hit_miss_buffer_copy(s : ImagemorphhitmissBuffer) -> ImagemorphhitmissBuffer {
  let result = image_morph_hit_miss_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_hit_miss_buffer_fill(s : ImagemorphhitmissBuffer, v : Double) -> ImagemorphhitmissBuffer {
  let result = image_morph_hit_miss_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_hit_miss_buffer_min(s : ImagemorphhitmissBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_hit_miss_buffer_max(s : ImagemorphhitmissBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_hit_miss_buffer_to_string(s : ImagemorphhitmissBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphhitmissCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_hit_miss_cursor_make(size : Int) -> ImagemorphhitmissCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_hit_miss_cursor_len(s : ImagemorphhitmissCursor) -> Int { s.size }

pub fn image_morph_hit_miss_cursor_get(s : ImagemorphhitmissCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_hit_miss_cursor_set(s : ImagemorphhitmissCursor, i : Int, v : Double) -> ImagemorphhitmissCursor {
  let result = image_morph_hit_miss_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_hit_miss_cursor_sum(s : ImagemorphhitmissCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_morph_hit_miss_cursor_mean(s : ImagemorphhitmissCursor) -> Double {
  if s.size == 0 { 0.0 } else { image_morph_hit_miss_cursor_sum(s) / s.size.to_double() }
}

pub fn image_morph_hit_miss_cursor_scale(s : ImagemorphhitmissCursor, f : Double) -> ImagemorphhitmissCursor {
  let result = image_morph_hit_miss_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_hit_miss_cursor_add(a : ImagemorphhitmissCursor, b : ImagemorphhitmissCursor) -> ImagemorphhitmissCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_hit_miss_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_hit_miss_cursor_copy(s : ImagemorphhitmissCursor) -> ImagemorphhitmissCursor {
  let result = image_morph_hit_miss_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_hit_miss_cursor_fill(s : ImagemorphhitmissCursor, v : Double) -> ImagemorphhitmissCursor {
  let result = image_morph_hit_miss_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_hit_miss_cursor_min(s : ImagemorphhitmissCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_hit_miss_cursor_max(s : ImagemorphhitmissCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_hit_miss_cursor_to_string(s : ImagemorphhitmissCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphhitmissView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_hit_miss_view_make(size : Int) -> ImagemorphhitmissView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_hit_miss_view_len(s : ImagemorphhitmissView) -> Int { s.size }

pub fn image_morph_hit_miss_view_get(s : ImagemorphhitmissView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_hit_miss_view_set(s : ImagemorphhitmissView, i : Int, v : Double) -> ImagemorphhitmissView {
  let result = image_morph_hit_miss_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_hit_miss_view_sum(s : ImagemorphhitmissView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_morph_hit_miss_view_mean(s : ImagemorphhitmissView) -> Double {
  if s.size == 0 { 0.0 } else { image_morph_hit_miss_view_sum(s) / s.size.to_double() }
}

pub fn image_morph_hit_miss_view_scale(s : ImagemorphhitmissView, f : Double) -> ImagemorphhitmissView {
  let result = image_morph_hit_miss_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_hit_miss_view_add(a : ImagemorphhitmissView, b : ImagemorphhitmissView) -> ImagemorphhitmissView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_hit_miss_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_hit_miss_view_copy(s : ImagemorphhitmissView) -> ImagemorphhitmissView {
  let result = image_morph_hit_miss_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_hit_miss_view_fill(s : ImagemorphhitmissView, v : Double) -> ImagemorphhitmissView {
  let result = image_morph_hit_miss_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_hit_miss_view_min(s : ImagemorphhitmissView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_hit_miss_view_max(s : ImagemorphhitmissView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_hit_miss_view_to_string(s : ImagemorphhitmissView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphhitmissRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_hit_miss_range_make(size : Int) -> ImagemorphhitmissRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_hit_miss_range_len(s : ImagemorphhitmissRange) -> Int { s.size }

pub fn image_morph_hit_miss_range_get(s : ImagemorphhitmissRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_hit_miss_range_set(s : ImagemorphhitmissRange, i : Int, v : Double) -> ImagemorphhitmissRange {
  let result = image_morph_hit_miss_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_hit_miss_range_sum(s : ImagemorphhitmissRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_morph_hit_miss_range_mean(s : ImagemorphhitmissRange) -> Double {
  if s.size == 0 { 0.0 } else { image_morph_hit_miss_range_sum(s) / s.size.to_double() }
}

pub fn image_morph_hit_miss_range_scale(s : ImagemorphhitmissRange, f : Double) -> ImagemorphhitmissRange {
  let result = image_morph_hit_miss_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_hit_miss_range_add(a : ImagemorphhitmissRange, b : ImagemorphhitmissRange) -> ImagemorphhitmissRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_hit_miss_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_hit_miss_range_copy(s : ImagemorphhitmissRange) -> ImagemorphhitmissRange {
  let result = image_morph_hit_miss_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_hit_miss_range_fill(s : ImagemorphhitmissRange, v : Double) -> ImagemorphhitmissRange {
  let result = image_morph_hit_miss_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_hit_miss_range_min(s : ImagemorphhitmissRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_hit_miss_range_max(s : ImagemorphhitmissRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_hit_miss_range_to_string(s : ImagemorphhitmissRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphhitmissSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_hit_miss_slice_make(size : Int) -> ImagemorphhitmissSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_hit_miss_slice_len(s : ImagemorphhitmissSlice) -> Int { s.size }

pub fn image_morph_hit_miss_slice_get(s : ImagemorphhitmissSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_hit_miss_slice_set(s : ImagemorphhitmissSlice, i : Int, v : Double) -> ImagemorphhitmissSlice {
  let result = image_morph_hit_miss_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_hit_miss_slice_sum(s : ImagemorphhitmissSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_morph_hit_miss_slice_mean(s : ImagemorphhitmissSlice) -> Double {
  if s.size == 0 { 0.0 } else { image_morph_hit_miss_slice_sum(s) / s.size.to_double() }
}

pub fn image_morph_hit_miss_slice_scale(s : ImagemorphhitmissSlice, f : Double) -> ImagemorphhitmissSlice {
  let result = image_morph_hit_miss_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_hit_miss_slice_add(a : ImagemorphhitmissSlice, b : ImagemorphhitmissSlice) -> ImagemorphhitmissSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_hit_miss_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_hit_miss_slice_copy(s : ImagemorphhitmissSlice) -> ImagemorphhitmissSlice {
  let result = image_morph_hit_miss_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_hit_miss_slice_fill(s : ImagemorphhitmissSlice, v : Double) -> ImagemorphhitmissSlice {
  let result = image_morph_hit_miss_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_hit_miss_slice_min(s : ImagemorphhitmissSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_hit_miss_slice_max(s : ImagemorphhitmissSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_hit_miss_slice_to_string(s : ImagemorphhitmissSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn image_morph_hit_miss_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_morph_hit_miss_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_morph_hit_miss_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_morph_hit_miss_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_morph_hit_miss_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_morph_hit_miss_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_morph_hit_miss_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_morph_hit_miss_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_morph_hit_miss_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_morph_hit_miss_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_morph_hit_miss_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_morph_hit_miss_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_morph_hit_miss_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_morph_hit_miss_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_morph_hit_miss_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_morph_hit_miss_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_morph_hit_miss_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_morph_hit_miss_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_morph_hit_miss_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_morph_hit_miss_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_morph_hit_miss_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_morph_hit_miss_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_morph_hit_miss_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_morph_hit_miss_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn image_morph_hit_miss_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}


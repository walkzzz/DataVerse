///===
/// extcore/geo_proj_albers

pub(all) struct GeoprojalbersPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_proj_albers_make_point(x : Double, y : Double) -> GeoprojalbersPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_proj_albers_make_point3(x : Double, y : Double, z : Double) -> GeoprojalbersPoint {
  { x, y, z, label: 0 }
}

pub fn geo_proj_albers_point_x(pt : GeoprojalbersPoint) -> Double { pt.x }

pub fn geo_proj_albers_point_y(pt : GeoprojalbersPoint) -> Double { pt.y }

pub fn geo_proj_albers_point_z(pt : GeoprojalbersPoint) -> Double { pt.z }

pub fn geo_proj_albers_point_label(pt : GeoprojalbersPoint) -> Int { pt.label }

pub fn geo_proj_albers_point_dist(a : GeoprojalbersPoint, b : GeoprojalbersPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  geo_proj_albers_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn geo_proj_albers_point_add(a : GeoprojalbersPoint, b : GeoprojalbersPoint) -> GeoprojalbersPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn geo_proj_albers_point_sub(a : GeoprojalbersPoint, b : GeoprojalbersPoint) -> GeoprojalbersPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn geo_proj_albers_point_scale(pt : GeoprojalbersPoint, s : Double) -> GeoprojalbersPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn geo_proj_albers_point_dot(a : GeoprojalbersPoint, b : GeoprojalbersPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn geo_proj_albers_point_cross(a : GeoprojalbersPoint, b : GeoprojalbersPoint) -> GeoprojalbersPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn geo_proj_albers_point_norm(pt : GeoprojalbersPoint) -> Double {
  geo_proj_albers_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn geo_proj_albers_point_normalize(pt : GeoprojalbersPoint) -> GeoprojalbersPoint {
  let n = geo_proj_albers_point_norm(pt)
  if n < 0.0000001 { pt } else { geo_proj_albers_point_scale(pt, 1.0 / n) }
}

pub fn geo_proj_albers_point_negate(pt : GeoprojalbersPoint) -> GeoprojalbersPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn geo_proj_albers_point_mid(a : GeoprojalbersPoint, b : GeoprojalbersPoint) -> GeoprojalbersPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn geo_proj_albers_point_lerp(a : GeoprojalbersPoint, b : GeoprojalbersPoint, t : Double) -> GeoprojalbersPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn geo_proj_albers_point_to_string(pt : GeoprojalbersPoint) -> String {
  "(" + geo_proj_albers_dbl(pt.x) + ", " + geo_proj_albers_dbl(pt.y) + ", " + geo_proj_albers_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct GeoprojalbersSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_proj_albers_make_series(vals : Array[Double], name : String) -> GeoprojalbersSeries {
  { vals, name, meta: 0 }
}

pub fn geo_proj_albers_series_len(s : GeoprojalbersSeries) -> Int { s.vals.length() }

pub fn geo_proj_albers_series_sum(s : GeoprojalbersSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn geo_proj_albers_series_mean(s : GeoprojalbersSeries) -> Double {
  let n = geo_proj_albers_series_len(s)
  if n == 0 { 0.0 } else { geo_proj_albers_series_sum(s) / n.to_double() }
}

pub fn geo_proj_albers_series_min(s : GeoprojalbersSeries) -> Double {
  let n = geo_proj_albers_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn geo_proj_albers_series_max(s : GeoprojalbersSeries) -> Double {
  let n = geo_proj_albers_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn geo_proj_albers_series_range(s : GeoprojalbersSeries) -> Double {
  geo_proj_albers_series_max(s) - geo_proj_albers_series_min(s)
}

pub fn geo_proj_albers_series_var(s : GeoprojalbersSeries) -> Double {
  let n = geo_proj_albers_series_len(s)
  if n == 0 { 0.0 } else {
    let m = geo_proj_albers_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn geo_proj_albers_series_std(s : GeoprojalbersSeries) -> Double { geo_proj_albers_sqrt(geo_proj_albers_series_var(s)) }

pub fn geo_proj_albers_series_median(s : GeoprojalbersSeries) -> Double {
  let n = geo_proj_albers_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = geo_proj_albers_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn geo_proj_albers_series_scale(s : GeoprojalbersSeries, f : Double) -> GeoprojalbersSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = geo_proj_albers_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn geo_proj_albers_series_add(a : GeoprojalbersSeries, b : GeoprojalbersSeries) -> GeoprojalbersSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = geo_proj_albers_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn geo_proj_albers_series_sub(a : GeoprojalbersSeries, b : GeoprojalbersSeries) -> GeoprojalbersSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = geo_proj_albers_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn geo_proj_albers_series_normalize(s : GeoprojalbersSeries) -> GeoprojalbersSeries {
  let mn = geo_proj_albers_series_min(s)
  let mx = geo_proj_albers_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = geo_proj_albers_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn geo_proj_albers_series_cumsum(s : GeoprojalbersSeries) -> GeoprojalbersSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = geo_proj_albers_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn geo_proj_albers_series_to_string(s : GeoprojalbersSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + geo_proj_albers_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeoprojalbersMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_proj_albers_make_matrix(rows : Int, cols : Int, val : Double) -> GeoprojalbersMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn geo_proj_albers_matrix_identity(n : Int) -> GeoprojalbersMatrix {
  let m = geo_proj_albers_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn geo_proj_albers_matrix_get(m : GeoprojalbersMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn geo_proj_albers_matrix_transpose(m : GeoprojalbersMatrix) -> GeoprojalbersMatrix {
  let result = geo_proj_albers_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn geo_proj_albers_matrix_add(a : GeoprojalbersMatrix, b : GeoprojalbersMatrix) -> GeoprojalbersMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = geo_proj_albers_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn geo_proj_albers_matrix_scale(m : GeoprojalbersMatrix, s : Double) -> GeoprojalbersMatrix {
  let result = geo_proj_albers_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn geo_proj_albers_matrix_multiply(a : GeoprojalbersMatrix, b : GeoprojalbersMatrix) -> GeoprojalbersMatrix {
  if a.cols != b.rows { return geo_proj_albers_make_matrix(a.rows, b.cols, 0.0) }
  let result = geo_proj_albers_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn geo_proj_albers_matrix_trace(m : GeoprojalbersMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn geo_proj_albers_matrix_det(m : GeoprojalbersMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn geo_proj_albers_matrix_norm(m : GeoprojalbersMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  geo_proj_albers_sqrt(sum)
}

pub fn geo_proj_albers_matrix_to_string(m : GeoprojalbersMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + geo_proj_albers_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct GeoprojalbersVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_proj_albers_make_vector(comps : Array[Double]) -> GeoprojalbersVector {
  { comps, dim: comps.length() }
}

pub fn geo_proj_albers_vector_zero(dim : Int) -> GeoprojalbersVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn geo_proj_albers_vector_add(a : GeoprojalbersVector, b : GeoprojalbersVector) -> GeoprojalbersVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = geo_proj_albers_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn geo_proj_albers_vector_sub(a : GeoprojalbersVector, b : GeoprojalbersVector) -> GeoprojalbersVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = geo_proj_albers_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn geo_proj_albers_vector_scale(v : GeoprojalbersVector, s : Double) -> GeoprojalbersVector {
  let mut result = []
  for i in 0..<v.dim { result = geo_proj_albers_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn geo_proj_albers_vector_dot(a : GeoprojalbersVector, b : GeoprojalbersVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn geo_proj_albers_vector_norm(v : GeoprojalbersVector) -> Double { geo_proj_albers_sqrt(geo_proj_albers_vector_dot(v, v)) }

pub fn geo_proj_albers_vector_normalize(v : GeoprojalbersVector) -> GeoprojalbersVector {
  let n = geo_proj_albers_vector_norm(v)
  if n < 0.0000001 { v } else { geo_proj_albers_vector_scale(v, 1.0 / n) }
}

pub fn geo_proj_albers_vector_dist(a : GeoprojalbersVector, b : GeoprojalbersVector) -> Double {
  geo_proj_albers_vector_norm(geo_proj_albers_vector_sub(a, b))
}

pub fn geo_proj_albers_vector_to_string(v : GeoprojalbersVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + geo_proj_albers_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn geo_proj_albers_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn geo_proj_albers_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = geo_proj_albers_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn geo_proj_albers_std(data : Array[Double]) -> Double { geo_proj_albers_sqrt(geo_proj_albers_var(data)) }

pub fn geo_proj_albers_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = geo_proj_albers_mean(a); let mb = geo_proj_albers_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn geo_proj_albers_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = geo_proj_albers_std(a); let sb = geo_proj_albers_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { geo_proj_albers_cov(a, b) / (sa * sb) }
}

pub fn geo_proj_albers_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = geo_proj_albers_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn geo_proj_albers_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn geo_proj_albers_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn geo_proj_albers_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  geo_proj_albers_sqrt(geo_proj_albers_mse(pred, labels))
}

pub fn geo_proj_albers_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + geo_proj_albers_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn geo_proj_albers_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = geo_proj_albers_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn geo_proj_albers_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn geo_proj_albers_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn geo_proj_albers_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = geo_proj_albers_precision(pred, labels, pos); let r = geo_proj_albers_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn geo_proj_albers_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn geo_proj_albers_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = geo_proj_albers_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn geo_proj_albers_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn geo_proj_albers_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn geo_proj_albers_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = geo_proj_albers_gcd(a, b)
    (a / g) * b
  }
}

pub fn geo_proj_albers_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn geo_proj_albers_fibonacci(n : Int) -> Int {
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

pub fn geo_proj_albers_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = geo_proj_albers_min(data); let mx = geo_proj_albers_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn geo_proj_albers_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = geo_proj_albers_mean(data); let sd = geo_proj_albers_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn geo_proj_albers_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn geo_proj_albers_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn geo_proj_albers_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn geo_proj_albers_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn geo_proj_albers_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn geo_proj_albers_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn geo_proj_albers_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn geo_proj_albers_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn geo_proj_albers_dbl(x : Double) -> String {
  let i = if x >= 0.0 { geo_proj_albers_int(x) } else { -geo_proj_albers_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { geo_proj_albers_int(f * 1000000.0) } else { geo_proj_albers_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn geo_proj_albers_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn geo_proj_albers_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct GeoprojalbersFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_albers_frame_make(size : Int) -> GeoprojalbersFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_albers_frame_len(s : GeoprojalbersFrame) -> Int { s.size }

pub fn geo_proj_albers_frame_get(s : GeoprojalbersFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_albers_frame_set(s : GeoprojalbersFrame, i : Int, v : Double) -> GeoprojalbersFrame {
  let result = geo_proj_albers_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_albers_frame_sum(s : GeoprojalbersFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_proj_albers_frame_mean(s : GeoprojalbersFrame) -> Double {
  if s.size == 0 { 0.0 } else { geo_proj_albers_frame_sum(s) / s.size.to_double() }
}

pub fn geo_proj_albers_frame_scale(s : GeoprojalbersFrame, f : Double) -> GeoprojalbersFrame {
  let result = geo_proj_albers_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_proj_albers_frame_add(a : GeoprojalbersFrame, b : GeoprojalbersFrame) -> GeoprojalbersFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_proj_albers_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_proj_albers_frame_copy(s : GeoprojalbersFrame) -> GeoprojalbersFrame {
  let result = geo_proj_albers_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_proj_albers_frame_fill(s : GeoprojalbersFrame, v : Double) -> GeoprojalbersFrame {
  let result = geo_proj_albers_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_proj_albers_frame_min(s : GeoprojalbersFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_albers_frame_max(s : GeoprojalbersFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_albers_frame_to_string(s : GeoprojalbersFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojalbersTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_albers_table_make(size : Int) -> GeoprojalbersTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_albers_table_len(s : GeoprojalbersTable) -> Int { s.size }

pub fn geo_proj_albers_table_get(s : GeoprojalbersTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_albers_table_set(s : GeoprojalbersTable, i : Int, v : Double) -> GeoprojalbersTable {
  let result = geo_proj_albers_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_albers_table_sum(s : GeoprojalbersTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_proj_albers_table_mean(s : GeoprojalbersTable) -> Double {
  if s.size == 0 { 0.0 } else { geo_proj_albers_table_sum(s) / s.size.to_double() }
}

pub fn geo_proj_albers_table_scale(s : GeoprojalbersTable, f : Double) -> GeoprojalbersTable {
  let result = geo_proj_albers_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_proj_albers_table_add(a : GeoprojalbersTable, b : GeoprojalbersTable) -> GeoprojalbersTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_proj_albers_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_proj_albers_table_copy(s : GeoprojalbersTable) -> GeoprojalbersTable {
  let result = geo_proj_albers_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_proj_albers_table_fill(s : GeoprojalbersTable, v : Double) -> GeoprojalbersTable {
  let result = geo_proj_albers_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_proj_albers_table_min(s : GeoprojalbersTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_albers_table_max(s : GeoprojalbersTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_albers_table_to_string(s : GeoprojalbersTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojalbersGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_albers_graphn_make(size : Int) -> GeoprojalbersGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_albers_graphn_len(s : GeoprojalbersGraphN) -> Int { s.size }

pub fn geo_proj_albers_graphn_get(s : GeoprojalbersGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_albers_graphn_set(s : GeoprojalbersGraphN, i : Int, v : Double) -> GeoprojalbersGraphN {
  let result = geo_proj_albers_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_albers_graphn_sum(s : GeoprojalbersGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_proj_albers_graphn_mean(s : GeoprojalbersGraphN) -> Double {
  if s.size == 0 { 0.0 } else { geo_proj_albers_graphn_sum(s) / s.size.to_double() }
}

pub fn geo_proj_albers_graphn_scale(s : GeoprojalbersGraphN, f : Double) -> GeoprojalbersGraphN {
  let result = geo_proj_albers_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_proj_albers_graphn_add(a : GeoprojalbersGraphN, b : GeoprojalbersGraphN) -> GeoprojalbersGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_proj_albers_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_proj_albers_graphn_copy(s : GeoprojalbersGraphN) -> GeoprojalbersGraphN {
  let result = geo_proj_albers_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_proj_albers_graphn_fill(s : GeoprojalbersGraphN, v : Double) -> GeoprojalbersGraphN {
  let result = geo_proj_albers_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_proj_albers_graphn_min(s : GeoprojalbersGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_albers_graphn_max(s : GeoprojalbersGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_albers_graphn_to_string(s : GeoprojalbersGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojalbersNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_albers_node_make(size : Int) -> GeoprojalbersNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_albers_node_len(s : GeoprojalbersNode) -> Int { s.size }

pub fn geo_proj_albers_node_get(s : GeoprojalbersNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_albers_node_set(s : GeoprojalbersNode, i : Int, v : Double) -> GeoprojalbersNode {
  let result = geo_proj_albers_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_albers_node_sum(s : GeoprojalbersNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_proj_albers_node_mean(s : GeoprojalbersNode) -> Double {
  if s.size == 0 { 0.0 } else { geo_proj_albers_node_sum(s) / s.size.to_double() }
}

pub fn geo_proj_albers_node_scale(s : GeoprojalbersNode, f : Double) -> GeoprojalbersNode {
  let result = geo_proj_albers_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_proj_albers_node_add(a : GeoprojalbersNode, b : GeoprojalbersNode) -> GeoprojalbersNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_proj_albers_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_proj_albers_node_copy(s : GeoprojalbersNode) -> GeoprojalbersNode {
  let result = geo_proj_albers_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_proj_albers_node_fill(s : GeoprojalbersNode, v : Double) -> GeoprojalbersNode {
  let result = geo_proj_albers_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_proj_albers_node_min(s : GeoprojalbersNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_albers_node_max(s : GeoprojalbersNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_albers_node_to_string(s : GeoprojalbersNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojalbersEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_albers_edge_make(size : Int) -> GeoprojalbersEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_albers_edge_len(s : GeoprojalbersEdge) -> Int { s.size }

pub fn geo_proj_albers_edge_get(s : GeoprojalbersEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_albers_edge_set(s : GeoprojalbersEdge, i : Int, v : Double) -> GeoprojalbersEdge {
  let result = geo_proj_albers_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_albers_edge_sum(s : GeoprojalbersEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_proj_albers_edge_mean(s : GeoprojalbersEdge) -> Double {
  if s.size == 0 { 0.0 } else { geo_proj_albers_edge_sum(s) / s.size.to_double() }
}

pub fn geo_proj_albers_edge_scale(s : GeoprojalbersEdge, f : Double) -> GeoprojalbersEdge {
  let result = geo_proj_albers_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_proj_albers_edge_add(a : GeoprojalbersEdge, b : GeoprojalbersEdge) -> GeoprojalbersEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_proj_albers_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_proj_albers_edge_copy(s : GeoprojalbersEdge) -> GeoprojalbersEdge {
  let result = geo_proj_albers_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_proj_albers_edge_fill(s : GeoprojalbersEdge, v : Double) -> GeoprojalbersEdge {
  let result = geo_proj_albers_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_proj_albers_edge_min(s : GeoprojalbersEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_albers_edge_max(s : GeoprojalbersEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_albers_edge_to_string(s : GeoprojalbersEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojalbersPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_albers_path_make(size : Int) -> GeoprojalbersPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_albers_path_len(s : GeoprojalbersPath) -> Int { s.size }

pub fn geo_proj_albers_path_get(s : GeoprojalbersPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_albers_path_set(s : GeoprojalbersPath, i : Int, v : Double) -> GeoprojalbersPath {
  let result = geo_proj_albers_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_albers_path_sum(s : GeoprojalbersPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_proj_albers_path_mean(s : GeoprojalbersPath) -> Double {
  if s.size == 0 { 0.0 } else { geo_proj_albers_path_sum(s) / s.size.to_double() }
}

pub fn geo_proj_albers_path_scale(s : GeoprojalbersPath, f : Double) -> GeoprojalbersPath {
  let result = geo_proj_albers_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_proj_albers_path_add(a : GeoprojalbersPath, b : GeoprojalbersPath) -> GeoprojalbersPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_proj_albers_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_proj_albers_path_copy(s : GeoprojalbersPath) -> GeoprojalbersPath {
  let result = geo_proj_albers_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_proj_albers_path_fill(s : GeoprojalbersPath, v : Double) -> GeoprojalbersPath {
  let result = geo_proj_albers_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_proj_albers_path_min(s : GeoprojalbersPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_albers_path_max(s : GeoprojalbersPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_albers_path_to_string(s : GeoprojalbersPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojalbersCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_albers_cluster_make(size : Int) -> GeoprojalbersCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_albers_cluster_len(s : GeoprojalbersCluster) -> Int { s.size }

pub fn geo_proj_albers_cluster_get(s : GeoprojalbersCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_albers_cluster_set(s : GeoprojalbersCluster, i : Int, v : Double) -> GeoprojalbersCluster {
  let result = geo_proj_albers_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_albers_cluster_sum(s : GeoprojalbersCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_proj_albers_cluster_mean(s : GeoprojalbersCluster) -> Double {
  if s.size == 0 { 0.0 } else { geo_proj_albers_cluster_sum(s) / s.size.to_double() }
}

pub fn geo_proj_albers_cluster_scale(s : GeoprojalbersCluster, f : Double) -> GeoprojalbersCluster {
  let result = geo_proj_albers_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_proj_albers_cluster_add(a : GeoprojalbersCluster, b : GeoprojalbersCluster) -> GeoprojalbersCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_proj_albers_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_proj_albers_cluster_copy(s : GeoprojalbersCluster) -> GeoprojalbersCluster {
  let result = geo_proj_albers_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_proj_albers_cluster_fill(s : GeoprojalbersCluster, v : Double) -> GeoprojalbersCluster {
  let result = geo_proj_albers_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_proj_albers_cluster_min(s : GeoprojalbersCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_albers_cluster_max(s : GeoprojalbersCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_albers_cluster_to_string(s : GeoprojalbersCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojalbersModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_albers_model_make(size : Int) -> GeoprojalbersModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_albers_model_len(s : GeoprojalbersModel) -> Int { s.size }

pub fn geo_proj_albers_model_get(s : GeoprojalbersModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_albers_model_set(s : GeoprojalbersModel, i : Int, v : Double) -> GeoprojalbersModel {
  let result = geo_proj_albers_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_albers_model_sum(s : GeoprojalbersModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_proj_albers_model_mean(s : GeoprojalbersModel) -> Double {
  if s.size == 0 { 0.0 } else { geo_proj_albers_model_sum(s) / s.size.to_double() }
}

pub fn geo_proj_albers_model_scale(s : GeoprojalbersModel, f : Double) -> GeoprojalbersModel {
  let result = geo_proj_albers_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_proj_albers_model_add(a : GeoprojalbersModel, b : GeoprojalbersModel) -> GeoprojalbersModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_proj_albers_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_proj_albers_model_copy(s : GeoprojalbersModel) -> GeoprojalbersModel {
  let result = geo_proj_albers_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_proj_albers_model_fill(s : GeoprojalbersModel, v : Double) -> GeoprojalbersModel {
  let result = geo_proj_albers_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_proj_albers_model_min(s : GeoprojalbersModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_albers_model_max(s : GeoprojalbersModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_albers_model_to_string(s : GeoprojalbersModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojalbersLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_albers_layer_make(size : Int) -> GeoprojalbersLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_albers_layer_len(s : GeoprojalbersLayer) -> Int { s.size }

pub fn geo_proj_albers_layer_get(s : GeoprojalbersLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_albers_layer_set(s : GeoprojalbersLayer, i : Int, v : Double) -> GeoprojalbersLayer {
  let result = geo_proj_albers_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_albers_layer_sum(s : GeoprojalbersLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_proj_albers_layer_mean(s : GeoprojalbersLayer) -> Double {
  if s.size == 0 { 0.0 } else { geo_proj_albers_layer_sum(s) / s.size.to_double() }
}

pub fn geo_proj_albers_layer_scale(s : GeoprojalbersLayer, f : Double) -> GeoprojalbersLayer {
  let result = geo_proj_albers_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_proj_albers_layer_add(a : GeoprojalbersLayer, b : GeoprojalbersLayer) -> GeoprojalbersLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_proj_albers_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_proj_albers_layer_copy(s : GeoprojalbersLayer) -> GeoprojalbersLayer {
  let result = geo_proj_albers_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_proj_albers_layer_fill(s : GeoprojalbersLayer, v : Double) -> GeoprojalbersLayer {
  let result = geo_proj_albers_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_proj_albers_layer_min(s : GeoprojalbersLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_albers_layer_max(s : GeoprojalbersLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_albers_layer_to_string(s : GeoprojalbersLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojalbersBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_albers_buffer_make(size : Int) -> GeoprojalbersBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_albers_buffer_len(s : GeoprojalbersBuffer) -> Int { s.size }

pub fn geo_proj_albers_buffer_get(s : GeoprojalbersBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_albers_buffer_set(s : GeoprojalbersBuffer, i : Int, v : Double) -> GeoprojalbersBuffer {
  let result = geo_proj_albers_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_albers_buffer_sum(s : GeoprojalbersBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_proj_albers_buffer_mean(s : GeoprojalbersBuffer) -> Double {
  if s.size == 0 { 0.0 } else { geo_proj_albers_buffer_sum(s) / s.size.to_double() }
}

pub fn geo_proj_albers_buffer_scale(s : GeoprojalbersBuffer, f : Double) -> GeoprojalbersBuffer {
  let result = geo_proj_albers_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_proj_albers_buffer_add(a : GeoprojalbersBuffer, b : GeoprojalbersBuffer) -> GeoprojalbersBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_proj_albers_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_proj_albers_buffer_copy(s : GeoprojalbersBuffer) -> GeoprojalbersBuffer {
  let result = geo_proj_albers_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_proj_albers_buffer_fill(s : GeoprojalbersBuffer, v : Double) -> GeoprojalbersBuffer {
  let result = geo_proj_albers_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_proj_albers_buffer_min(s : GeoprojalbersBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_albers_buffer_max(s : GeoprojalbersBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_albers_buffer_to_string(s : GeoprojalbersBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojalbersCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_albers_cursor_make(size : Int) -> GeoprojalbersCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_albers_cursor_len(s : GeoprojalbersCursor) -> Int { s.size }

pub fn geo_proj_albers_cursor_get(s : GeoprojalbersCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_albers_cursor_set(s : GeoprojalbersCursor, i : Int, v : Double) -> GeoprojalbersCursor {
  let result = geo_proj_albers_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_albers_cursor_sum(s : GeoprojalbersCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_proj_albers_cursor_mean(s : GeoprojalbersCursor) -> Double {
  if s.size == 0 { 0.0 } else { geo_proj_albers_cursor_sum(s) / s.size.to_double() }
}

pub fn geo_proj_albers_cursor_scale(s : GeoprojalbersCursor, f : Double) -> GeoprojalbersCursor {
  let result = geo_proj_albers_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_proj_albers_cursor_add(a : GeoprojalbersCursor, b : GeoprojalbersCursor) -> GeoprojalbersCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_proj_albers_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_proj_albers_cursor_copy(s : GeoprojalbersCursor) -> GeoprojalbersCursor {
  let result = geo_proj_albers_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_proj_albers_cursor_fill(s : GeoprojalbersCursor, v : Double) -> GeoprojalbersCursor {
  let result = geo_proj_albers_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_proj_albers_cursor_min(s : GeoprojalbersCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_albers_cursor_max(s : GeoprojalbersCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_albers_cursor_to_string(s : GeoprojalbersCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojalbersView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_albers_view_make(size : Int) -> GeoprojalbersView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_albers_view_len(s : GeoprojalbersView) -> Int { s.size }

pub fn geo_proj_albers_view_get(s : GeoprojalbersView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_albers_view_set(s : GeoprojalbersView, i : Int, v : Double) -> GeoprojalbersView {
  let result = geo_proj_albers_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_albers_view_sum(s : GeoprojalbersView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_proj_albers_view_mean(s : GeoprojalbersView) -> Double {
  if s.size == 0 { 0.0 } else { geo_proj_albers_view_sum(s) / s.size.to_double() }
}

pub fn geo_proj_albers_view_scale(s : GeoprojalbersView, f : Double) -> GeoprojalbersView {
  let result = geo_proj_albers_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_proj_albers_view_add(a : GeoprojalbersView, b : GeoprojalbersView) -> GeoprojalbersView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_proj_albers_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_proj_albers_view_copy(s : GeoprojalbersView) -> GeoprojalbersView {
  let result = geo_proj_albers_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_proj_albers_view_fill(s : GeoprojalbersView, v : Double) -> GeoprojalbersView {
  let result = geo_proj_albers_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_proj_albers_view_min(s : GeoprojalbersView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_albers_view_max(s : GeoprojalbersView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_albers_view_to_string(s : GeoprojalbersView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojalbersRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_albers_range_make(size : Int) -> GeoprojalbersRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_albers_range_len(s : GeoprojalbersRange) -> Int { s.size }

pub fn geo_proj_albers_range_get(s : GeoprojalbersRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_albers_range_set(s : GeoprojalbersRange, i : Int, v : Double) -> GeoprojalbersRange {
  let result = geo_proj_albers_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_albers_range_sum(s : GeoprojalbersRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_proj_albers_range_mean(s : GeoprojalbersRange) -> Double {
  if s.size == 0 { 0.0 } else { geo_proj_albers_range_sum(s) / s.size.to_double() }
}

pub fn geo_proj_albers_range_scale(s : GeoprojalbersRange, f : Double) -> GeoprojalbersRange {
  let result = geo_proj_albers_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_proj_albers_range_add(a : GeoprojalbersRange, b : GeoprojalbersRange) -> GeoprojalbersRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_proj_albers_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_proj_albers_range_copy(s : GeoprojalbersRange) -> GeoprojalbersRange {
  let result = geo_proj_albers_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_proj_albers_range_fill(s : GeoprojalbersRange, v : Double) -> GeoprojalbersRange {
  let result = geo_proj_albers_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_proj_albers_range_min(s : GeoprojalbersRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_albers_range_max(s : GeoprojalbersRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_albers_range_to_string(s : GeoprojalbersRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojalbersSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_albers_slice_make(size : Int) -> GeoprojalbersSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_albers_slice_len(s : GeoprojalbersSlice) -> Int { s.size }

pub fn geo_proj_albers_slice_get(s : GeoprojalbersSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_albers_slice_set(s : GeoprojalbersSlice, i : Int, v : Double) -> GeoprojalbersSlice {
  let result = geo_proj_albers_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_albers_slice_sum(s : GeoprojalbersSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_proj_albers_slice_mean(s : GeoprojalbersSlice) -> Double {
  if s.size == 0 { 0.0 } else { geo_proj_albers_slice_sum(s) / s.size.to_double() }
}

pub fn geo_proj_albers_slice_scale(s : GeoprojalbersSlice, f : Double) -> GeoprojalbersSlice {
  let result = geo_proj_albers_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_proj_albers_slice_add(a : GeoprojalbersSlice, b : GeoprojalbersSlice) -> GeoprojalbersSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_proj_albers_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_proj_albers_slice_copy(s : GeoprojalbersSlice) -> GeoprojalbersSlice {
  let result = geo_proj_albers_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_proj_albers_slice_fill(s : GeoprojalbersSlice, v : Double) -> GeoprojalbersSlice {
  let result = geo_proj_albers_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_proj_albers_slice_min(s : GeoprojalbersSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_albers_slice_max(s : GeoprojalbersSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_albers_slice_to_string(s : GeoprojalbersSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn geo_proj_albers_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_proj_albers_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_proj_albers_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_proj_albers_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_proj_albers_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_proj_albers_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_proj_albers_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_proj_albers_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_proj_albers_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_proj_albers_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_proj_albers_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_proj_albers_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_proj_albers_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_proj_albers_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_proj_albers_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_proj_albers_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_proj_albers_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_proj_albers_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_proj_albers_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_proj_albers_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_proj_albers_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_proj_albers_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_proj_albers_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_proj_albers_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn geo_proj_albers_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}


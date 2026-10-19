///===
/// extcore/ds_hash_perfect

pub(all) struct DshashperfectPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_hash_perfect_make_point(x : Double, y : Double) -> DshashperfectPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_hash_perfect_make_point3(x : Double, y : Double, z : Double) -> DshashperfectPoint {
  { x, y, z, label: 0 }
}

pub fn ds_hash_perfect_point_x(pt : DshashperfectPoint) -> Double { pt.x }

pub fn ds_hash_perfect_point_y(pt : DshashperfectPoint) -> Double { pt.y }

pub fn ds_hash_perfect_point_z(pt : DshashperfectPoint) -> Double { pt.z }

pub fn ds_hash_perfect_point_label(pt : DshashperfectPoint) -> Int { pt.label }

pub fn ds_hash_perfect_point_dist(a : DshashperfectPoint, b : DshashperfectPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  ds_hash_perfect_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ds_hash_perfect_point_add(a : DshashperfectPoint, b : DshashperfectPoint) -> DshashperfectPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ds_hash_perfect_point_sub(a : DshashperfectPoint, b : DshashperfectPoint) -> DshashperfectPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ds_hash_perfect_point_scale(pt : DshashperfectPoint, s : Double) -> DshashperfectPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ds_hash_perfect_point_dot(a : DshashperfectPoint, b : DshashperfectPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ds_hash_perfect_point_cross(a : DshashperfectPoint, b : DshashperfectPoint) -> DshashperfectPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ds_hash_perfect_point_norm(pt : DshashperfectPoint) -> Double {
  ds_hash_perfect_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ds_hash_perfect_point_normalize(pt : DshashperfectPoint) -> DshashperfectPoint {
  let n = ds_hash_perfect_point_norm(pt)
  if n < 0.0000001 { pt } else { ds_hash_perfect_point_scale(pt, 1.0 / n) }
}

pub fn ds_hash_perfect_point_negate(pt : DshashperfectPoint) -> DshashperfectPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ds_hash_perfect_point_mid(a : DshashperfectPoint, b : DshashperfectPoint) -> DshashperfectPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ds_hash_perfect_point_lerp(a : DshashperfectPoint, b : DshashperfectPoint, t : Double) -> DshashperfectPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ds_hash_perfect_point_to_string(pt : DshashperfectPoint) -> String {
  "(" + ds_hash_perfect_dbl(pt.x) + ", " + ds_hash_perfect_dbl(pt.y) + ", " + ds_hash_perfect_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DshashperfectSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_hash_perfect_make_series(vals : Array[Double], name : String) -> DshashperfectSeries {
  { vals, name, meta: 0 }
}

pub fn ds_hash_perfect_series_len(s : DshashperfectSeries) -> Int { s.vals.length() }

pub fn ds_hash_perfect_series_sum(s : DshashperfectSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn ds_hash_perfect_series_mean(s : DshashperfectSeries) -> Double {
  let n = ds_hash_perfect_series_len(s)
  if n == 0 { 0.0 } else { ds_hash_perfect_series_sum(s) / n.to_double() }
}

pub fn ds_hash_perfect_series_min(s : DshashperfectSeries) -> Double {
  let n = ds_hash_perfect_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn ds_hash_perfect_series_max(s : DshashperfectSeries) -> Double {
  let n = ds_hash_perfect_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn ds_hash_perfect_series_range(s : DshashperfectSeries) -> Double {
  ds_hash_perfect_series_max(s) - ds_hash_perfect_series_min(s)
}

pub fn ds_hash_perfect_series_var(s : DshashperfectSeries) -> Double {
  let n = ds_hash_perfect_series_len(s)
  if n == 0 { 0.0 } else {
    let m = ds_hash_perfect_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn ds_hash_perfect_series_std(s : DshashperfectSeries) -> Double { ds_hash_perfect_sqrt(ds_hash_perfect_series_var(s)) }

pub fn ds_hash_perfect_series_median(s : DshashperfectSeries) -> Double {
  let n = ds_hash_perfect_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = ds_hash_perfect_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ds_hash_perfect_series_scale(s : DshashperfectSeries, f : Double) -> DshashperfectSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = ds_hash_perfect_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ds_hash_perfect_series_add(a : DshashperfectSeries, b : DshashperfectSeries) -> DshashperfectSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = ds_hash_perfect_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ds_hash_perfect_series_sub(a : DshashperfectSeries, b : DshashperfectSeries) -> DshashperfectSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = ds_hash_perfect_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ds_hash_perfect_series_normalize(s : DshashperfectSeries) -> DshashperfectSeries {
  let mn = ds_hash_perfect_series_min(s)
  let mx = ds_hash_perfect_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = ds_hash_perfect_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ds_hash_perfect_series_cumsum(s : DshashperfectSeries) -> DshashperfectSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = ds_hash_perfect_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn ds_hash_perfect_series_to_string(s : DshashperfectSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + ds_hash_perfect_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DshashperfectMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_hash_perfect_make_matrix(rows : Int, cols : Int, val : Double) -> DshashperfectMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_hash_perfect_matrix_identity(n : Int) -> DshashperfectMatrix {
  let m = ds_hash_perfect_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ds_hash_perfect_matrix_get(m : DshashperfectMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ds_hash_perfect_matrix_transpose(m : DshashperfectMatrix) -> DshashperfectMatrix {
  let result = ds_hash_perfect_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ds_hash_perfect_matrix_add(a : DshashperfectMatrix, b : DshashperfectMatrix) -> DshashperfectMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ds_hash_perfect_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ds_hash_perfect_matrix_scale(m : DshashperfectMatrix, s : Double) -> DshashperfectMatrix {
  let result = ds_hash_perfect_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ds_hash_perfect_matrix_multiply(a : DshashperfectMatrix, b : DshashperfectMatrix) -> DshashperfectMatrix {
  if a.cols != b.rows { return ds_hash_perfect_make_matrix(a.rows, b.cols, 0.0) }
  let result = ds_hash_perfect_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ds_hash_perfect_matrix_trace(m : DshashperfectMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ds_hash_perfect_matrix_det(m : DshashperfectMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ds_hash_perfect_matrix_norm(m : DshashperfectMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  ds_hash_perfect_sqrt(sum)
}

pub fn ds_hash_perfect_matrix_to_string(m : DshashperfectMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + ds_hash_perfect_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct DshashperfectVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_hash_perfect_make_vector(comps : Array[Double]) -> DshashperfectVector {
  { comps, dim: comps.length() }
}

pub fn ds_hash_perfect_vector_zero(dim : Int) -> DshashperfectVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ds_hash_perfect_vector_add(a : DshashperfectVector, b : DshashperfectVector) -> DshashperfectVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = ds_hash_perfect_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_hash_perfect_vector_sub(a : DshashperfectVector, b : DshashperfectVector) -> DshashperfectVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = ds_hash_perfect_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_hash_perfect_vector_scale(v : DshashperfectVector, s : Double) -> DshashperfectVector {
  let mut result = []
  for i in 0..<v.dim { result = ds_hash_perfect_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ds_hash_perfect_vector_dot(a : DshashperfectVector, b : DshashperfectVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ds_hash_perfect_vector_norm(v : DshashperfectVector) -> Double { ds_hash_perfect_sqrt(ds_hash_perfect_vector_dot(v, v)) }

pub fn ds_hash_perfect_vector_normalize(v : DshashperfectVector) -> DshashperfectVector {
  let n = ds_hash_perfect_vector_norm(v)
  if n < 0.0000001 { v } else { ds_hash_perfect_vector_scale(v, 1.0 / n) }
}

pub fn ds_hash_perfect_vector_dist(a : DshashperfectVector, b : DshashperfectVector) -> Double {
  ds_hash_perfect_vector_norm(ds_hash_perfect_vector_sub(a, b))
}

pub fn ds_hash_perfect_vector_to_string(v : DshashperfectVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + ds_hash_perfect_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_hash_perfect_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn ds_hash_perfect_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = ds_hash_perfect_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ds_hash_perfect_std(data : Array[Double]) -> Double { ds_hash_perfect_sqrt(ds_hash_perfect_var(data)) }

pub fn ds_hash_perfect_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = ds_hash_perfect_mean(a); let mb = ds_hash_perfect_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn ds_hash_perfect_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = ds_hash_perfect_std(a); let sb = ds_hash_perfect_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { ds_hash_perfect_cov(a, b) / (sa * sb) }
}

pub fn ds_hash_perfect_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = ds_hash_perfect_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ds_hash_perfect_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn ds_hash_perfect_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ds_hash_perfect_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  ds_hash_perfect_sqrt(ds_hash_perfect_mse(pred, labels))
}

pub fn ds_hash_perfect_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + ds_hash_perfect_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn ds_hash_perfect_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = ds_hash_perfect_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn ds_hash_perfect_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn ds_hash_perfect_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn ds_hash_perfect_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = ds_hash_perfect_precision(pred, labels, pos); let r = ds_hash_perfect_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn ds_hash_perfect_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn ds_hash_perfect_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = ds_hash_perfect_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn ds_hash_perfect_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn ds_hash_perfect_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn ds_hash_perfect_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = ds_hash_perfect_gcd(a, b)
    (a / g) * b
  }
}

pub fn ds_hash_perfect_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn ds_hash_perfect_fibonacci(n : Int) -> Int {
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

pub fn ds_hash_perfect_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = ds_hash_perfect_min(data); let mx = ds_hash_perfect_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn ds_hash_perfect_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = ds_hash_perfect_mean(data); let sd = ds_hash_perfect_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn ds_hash_perfect_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn ds_hash_perfect_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn ds_hash_perfect_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn ds_hash_perfect_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn ds_hash_perfect_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn ds_hash_perfect_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn ds_hash_perfect_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn ds_hash_perfect_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn ds_hash_perfect_dbl(x : Double) -> String {
  let i = if x >= 0.0 { ds_hash_perfect_int(x) } else { -ds_hash_perfect_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { ds_hash_perfect_int(f * 1000000.0) } else { ds_hash_perfect_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn ds_hash_perfect_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn ds_hash_perfect_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct DshashperfectFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_perfect_frame_make(size : Int) -> DshashperfectFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_perfect_frame_len(s : DshashperfectFrame) -> Int { s.size }

pub fn ds_hash_perfect_frame_get(s : DshashperfectFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_perfect_frame_set(s : DshashperfectFrame, i : Int, v : Double) -> DshashperfectFrame {
  let result = ds_hash_perfect_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_perfect_frame_sum(s : DshashperfectFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_perfect_frame_mean(s : DshashperfectFrame) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_perfect_frame_sum(s) / s.size.to_double() }
}

pub fn ds_hash_perfect_frame_scale(s : DshashperfectFrame, f : Double) -> DshashperfectFrame {
  let result = ds_hash_perfect_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_perfect_frame_add(a : DshashperfectFrame, b : DshashperfectFrame) -> DshashperfectFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_perfect_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_perfect_frame_copy(s : DshashperfectFrame) -> DshashperfectFrame {
  let result = ds_hash_perfect_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_perfect_frame_fill(s : DshashperfectFrame, v : Double) -> DshashperfectFrame {
  let result = ds_hash_perfect_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_perfect_frame_min(s : DshashperfectFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_perfect_frame_max(s : DshashperfectFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_perfect_frame_to_string(s : DshashperfectFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashperfectTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_perfect_table_make(size : Int) -> DshashperfectTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_perfect_table_len(s : DshashperfectTable) -> Int { s.size }

pub fn ds_hash_perfect_table_get(s : DshashperfectTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_perfect_table_set(s : DshashperfectTable, i : Int, v : Double) -> DshashperfectTable {
  let result = ds_hash_perfect_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_perfect_table_sum(s : DshashperfectTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_perfect_table_mean(s : DshashperfectTable) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_perfect_table_sum(s) / s.size.to_double() }
}

pub fn ds_hash_perfect_table_scale(s : DshashperfectTable, f : Double) -> DshashperfectTable {
  let result = ds_hash_perfect_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_perfect_table_add(a : DshashperfectTable, b : DshashperfectTable) -> DshashperfectTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_perfect_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_perfect_table_copy(s : DshashperfectTable) -> DshashperfectTable {
  let result = ds_hash_perfect_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_perfect_table_fill(s : DshashperfectTable, v : Double) -> DshashperfectTable {
  let result = ds_hash_perfect_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_perfect_table_min(s : DshashperfectTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_perfect_table_max(s : DshashperfectTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_perfect_table_to_string(s : DshashperfectTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashperfectGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_perfect_graphn_make(size : Int) -> DshashperfectGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_perfect_graphn_len(s : DshashperfectGraphN) -> Int { s.size }

pub fn ds_hash_perfect_graphn_get(s : DshashperfectGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_perfect_graphn_set(s : DshashperfectGraphN, i : Int, v : Double) -> DshashperfectGraphN {
  let result = ds_hash_perfect_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_perfect_graphn_sum(s : DshashperfectGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_perfect_graphn_mean(s : DshashperfectGraphN) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_perfect_graphn_sum(s) / s.size.to_double() }
}

pub fn ds_hash_perfect_graphn_scale(s : DshashperfectGraphN, f : Double) -> DshashperfectGraphN {
  let result = ds_hash_perfect_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_perfect_graphn_add(a : DshashperfectGraphN, b : DshashperfectGraphN) -> DshashperfectGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_perfect_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_perfect_graphn_copy(s : DshashperfectGraphN) -> DshashperfectGraphN {
  let result = ds_hash_perfect_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_perfect_graphn_fill(s : DshashperfectGraphN, v : Double) -> DshashperfectGraphN {
  let result = ds_hash_perfect_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_perfect_graphn_min(s : DshashperfectGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_perfect_graphn_max(s : DshashperfectGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_perfect_graphn_to_string(s : DshashperfectGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashperfectNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_perfect_node_make(size : Int) -> DshashperfectNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_perfect_node_len(s : DshashperfectNode) -> Int { s.size }

pub fn ds_hash_perfect_node_get(s : DshashperfectNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_perfect_node_set(s : DshashperfectNode, i : Int, v : Double) -> DshashperfectNode {
  let result = ds_hash_perfect_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_perfect_node_sum(s : DshashperfectNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_perfect_node_mean(s : DshashperfectNode) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_perfect_node_sum(s) / s.size.to_double() }
}

pub fn ds_hash_perfect_node_scale(s : DshashperfectNode, f : Double) -> DshashperfectNode {
  let result = ds_hash_perfect_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_perfect_node_add(a : DshashperfectNode, b : DshashperfectNode) -> DshashperfectNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_perfect_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_perfect_node_copy(s : DshashperfectNode) -> DshashperfectNode {
  let result = ds_hash_perfect_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_perfect_node_fill(s : DshashperfectNode, v : Double) -> DshashperfectNode {
  let result = ds_hash_perfect_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_perfect_node_min(s : DshashperfectNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_perfect_node_max(s : DshashperfectNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_perfect_node_to_string(s : DshashperfectNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashperfectEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_perfect_edge_make(size : Int) -> DshashperfectEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_perfect_edge_len(s : DshashperfectEdge) -> Int { s.size }

pub fn ds_hash_perfect_edge_get(s : DshashperfectEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_perfect_edge_set(s : DshashperfectEdge, i : Int, v : Double) -> DshashperfectEdge {
  let result = ds_hash_perfect_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_perfect_edge_sum(s : DshashperfectEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_perfect_edge_mean(s : DshashperfectEdge) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_perfect_edge_sum(s) / s.size.to_double() }
}

pub fn ds_hash_perfect_edge_scale(s : DshashperfectEdge, f : Double) -> DshashperfectEdge {
  let result = ds_hash_perfect_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_perfect_edge_add(a : DshashperfectEdge, b : DshashperfectEdge) -> DshashperfectEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_perfect_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_perfect_edge_copy(s : DshashperfectEdge) -> DshashperfectEdge {
  let result = ds_hash_perfect_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_perfect_edge_fill(s : DshashperfectEdge, v : Double) -> DshashperfectEdge {
  let result = ds_hash_perfect_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_perfect_edge_min(s : DshashperfectEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_perfect_edge_max(s : DshashperfectEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_perfect_edge_to_string(s : DshashperfectEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashperfectPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_perfect_path_make(size : Int) -> DshashperfectPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_perfect_path_len(s : DshashperfectPath) -> Int { s.size }

pub fn ds_hash_perfect_path_get(s : DshashperfectPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_perfect_path_set(s : DshashperfectPath, i : Int, v : Double) -> DshashperfectPath {
  let result = ds_hash_perfect_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_perfect_path_sum(s : DshashperfectPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_perfect_path_mean(s : DshashperfectPath) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_perfect_path_sum(s) / s.size.to_double() }
}

pub fn ds_hash_perfect_path_scale(s : DshashperfectPath, f : Double) -> DshashperfectPath {
  let result = ds_hash_perfect_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_perfect_path_add(a : DshashperfectPath, b : DshashperfectPath) -> DshashperfectPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_perfect_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_perfect_path_copy(s : DshashperfectPath) -> DshashperfectPath {
  let result = ds_hash_perfect_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_perfect_path_fill(s : DshashperfectPath, v : Double) -> DshashperfectPath {
  let result = ds_hash_perfect_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_perfect_path_min(s : DshashperfectPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_perfect_path_max(s : DshashperfectPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_perfect_path_to_string(s : DshashperfectPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashperfectCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_perfect_cluster_make(size : Int) -> DshashperfectCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_perfect_cluster_len(s : DshashperfectCluster) -> Int { s.size }

pub fn ds_hash_perfect_cluster_get(s : DshashperfectCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_perfect_cluster_set(s : DshashperfectCluster, i : Int, v : Double) -> DshashperfectCluster {
  let result = ds_hash_perfect_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_perfect_cluster_sum(s : DshashperfectCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_perfect_cluster_mean(s : DshashperfectCluster) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_perfect_cluster_sum(s) / s.size.to_double() }
}

pub fn ds_hash_perfect_cluster_scale(s : DshashperfectCluster, f : Double) -> DshashperfectCluster {
  let result = ds_hash_perfect_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_perfect_cluster_add(a : DshashperfectCluster, b : DshashperfectCluster) -> DshashperfectCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_perfect_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_perfect_cluster_copy(s : DshashperfectCluster) -> DshashperfectCluster {
  let result = ds_hash_perfect_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_perfect_cluster_fill(s : DshashperfectCluster, v : Double) -> DshashperfectCluster {
  let result = ds_hash_perfect_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_perfect_cluster_min(s : DshashperfectCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_perfect_cluster_max(s : DshashperfectCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_perfect_cluster_to_string(s : DshashperfectCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashperfectModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_perfect_model_make(size : Int) -> DshashperfectModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_perfect_model_len(s : DshashperfectModel) -> Int { s.size }

pub fn ds_hash_perfect_model_get(s : DshashperfectModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_perfect_model_set(s : DshashperfectModel, i : Int, v : Double) -> DshashperfectModel {
  let result = ds_hash_perfect_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_perfect_model_sum(s : DshashperfectModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_perfect_model_mean(s : DshashperfectModel) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_perfect_model_sum(s) / s.size.to_double() }
}

pub fn ds_hash_perfect_model_scale(s : DshashperfectModel, f : Double) -> DshashperfectModel {
  let result = ds_hash_perfect_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_perfect_model_add(a : DshashperfectModel, b : DshashperfectModel) -> DshashperfectModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_perfect_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_perfect_model_copy(s : DshashperfectModel) -> DshashperfectModel {
  let result = ds_hash_perfect_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_perfect_model_fill(s : DshashperfectModel, v : Double) -> DshashperfectModel {
  let result = ds_hash_perfect_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_perfect_model_min(s : DshashperfectModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_perfect_model_max(s : DshashperfectModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_perfect_model_to_string(s : DshashperfectModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashperfectLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_perfect_layer_make(size : Int) -> DshashperfectLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_perfect_layer_len(s : DshashperfectLayer) -> Int { s.size }

pub fn ds_hash_perfect_layer_get(s : DshashperfectLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_perfect_layer_set(s : DshashperfectLayer, i : Int, v : Double) -> DshashperfectLayer {
  let result = ds_hash_perfect_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_perfect_layer_sum(s : DshashperfectLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_perfect_layer_mean(s : DshashperfectLayer) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_perfect_layer_sum(s) / s.size.to_double() }
}

pub fn ds_hash_perfect_layer_scale(s : DshashperfectLayer, f : Double) -> DshashperfectLayer {
  let result = ds_hash_perfect_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_perfect_layer_add(a : DshashperfectLayer, b : DshashperfectLayer) -> DshashperfectLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_perfect_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_perfect_layer_copy(s : DshashperfectLayer) -> DshashperfectLayer {
  let result = ds_hash_perfect_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_perfect_layer_fill(s : DshashperfectLayer, v : Double) -> DshashperfectLayer {
  let result = ds_hash_perfect_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_perfect_layer_min(s : DshashperfectLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_perfect_layer_max(s : DshashperfectLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_perfect_layer_to_string(s : DshashperfectLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashperfectBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_perfect_buffer_make(size : Int) -> DshashperfectBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_perfect_buffer_len(s : DshashperfectBuffer) -> Int { s.size }

pub fn ds_hash_perfect_buffer_get(s : DshashperfectBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_perfect_buffer_set(s : DshashperfectBuffer, i : Int, v : Double) -> DshashperfectBuffer {
  let result = ds_hash_perfect_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_perfect_buffer_sum(s : DshashperfectBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_perfect_buffer_mean(s : DshashperfectBuffer) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_perfect_buffer_sum(s) / s.size.to_double() }
}

pub fn ds_hash_perfect_buffer_scale(s : DshashperfectBuffer, f : Double) -> DshashperfectBuffer {
  let result = ds_hash_perfect_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_perfect_buffer_add(a : DshashperfectBuffer, b : DshashperfectBuffer) -> DshashperfectBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_perfect_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_perfect_buffer_copy(s : DshashperfectBuffer) -> DshashperfectBuffer {
  let result = ds_hash_perfect_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_perfect_buffer_fill(s : DshashperfectBuffer, v : Double) -> DshashperfectBuffer {
  let result = ds_hash_perfect_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_perfect_buffer_min(s : DshashperfectBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_perfect_buffer_max(s : DshashperfectBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_perfect_buffer_to_string(s : DshashperfectBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashperfectCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_perfect_cursor_make(size : Int) -> DshashperfectCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_perfect_cursor_len(s : DshashperfectCursor) -> Int { s.size }

pub fn ds_hash_perfect_cursor_get(s : DshashperfectCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_perfect_cursor_set(s : DshashperfectCursor, i : Int, v : Double) -> DshashperfectCursor {
  let result = ds_hash_perfect_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_perfect_cursor_sum(s : DshashperfectCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_perfect_cursor_mean(s : DshashperfectCursor) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_perfect_cursor_sum(s) / s.size.to_double() }
}

pub fn ds_hash_perfect_cursor_scale(s : DshashperfectCursor, f : Double) -> DshashperfectCursor {
  let result = ds_hash_perfect_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_perfect_cursor_add(a : DshashperfectCursor, b : DshashperfectCursor) -> DshashperfectCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_perfect_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_perfect_cursor_copy(s : DshashperfectCursor) -> DshashperfectCursor {
  let result = ds_hash_perfect_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_perfect_cursor_fill(s : DshashperfectCursor, v : Double) -> DshashperfectCursor {
  let result = ds_hash_perfect_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_perfect_cursor_min(s : DshashperfectCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_perfect_cursor_max(s : DshashperfectCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_perfect_cursor_to_string(s : DshashperfectCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashperfectView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_perfect_view_make(size : Int) -> DshashperfectView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_perfect_view_len(s : DshashperfectView) -> Int { s.size }

pub fn ds_hash_perfect_view_get(s : DshashperfectView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_perfect_view_set(s : DshashperfectView, i : Int, v : Double) -> DshashperfectView {
  let result = ds_hash_perfect_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_perfect_view_sum(s : DshashperfectView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_perfect_view_mean(s : DshashperfectView) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_perfect_view_sum(s) / s.size.to_double() }
}

pub fn ds_hash_perfect_view_scale(s : DshashperfectView, f : Double) -> DshashperfectView {
  let result = ds_hash_perfect_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_perfect_view_add(a : DshashperfectView, b : DshashperfectView) -> DshashperfectView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_perfect_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_perfect_view_copy(s : DshashperfectView) -> DshashperfectView {
  let result = ds_hash_perfect_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_perfect_view_fill(s : DshashperfectView, v : Double) -> DshashperfectView {
  let result = ds_hash_perfect_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_perfect_view_min(s : DshashperfectView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_perfect_view_max(s : DshashperfectView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_perfect_view_to_string(s : DshashperfectView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashperfectRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_perfect_range_make(size : Int) -> DshashperfectRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_perfect_range_len(s : DshashperfectRange) -> Int { s.size }

pub fn ds_hash_perfect_range_get(s : DshashperfectRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_perfect_range_set(s : DshashperfectRange, i : Int, v : Double) -> DshashperfectRange {
  let result = ds_hash_perfect_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_perfect_range_sum(s : DshashperfectRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_perfect_range_mean(s : DshashperfectRange) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_perfect_range_sum(s) / s.size.to_double() }
}

pub fn ds_hash_perfect_range_scale(s : DshashperfectRange, f : Double) -> DshashperfectRange {
  let result = ds_hash_perfect_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_perfect_range_add(a : DshashperfectRange, b : DshashperfectRange) -> DshashperfectRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_perfect_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_perfect_range_copy(s : DshashperfectRange) -> DshashperfectRange {
  let result = ds_hash_perfect_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_perfect_range_fill(s : DshashperfectRange, v : Double) -> DshashperfectRange {
  let result = ds_hash_perfect_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_perfect_range_min(s : DshashperfectRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_perfect_range_max(s : DshashperfectRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_perfect_range_to_string(s : DshashperfectRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashperfectSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_perfect_slice_make(size : Int) -> DshashperfectSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_perfect_slice_len(s : DshashperfectSlice) -> Int { s.size }

pub fn ds_hash_perfect_slice_get(s : DshashperfectSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_perfect_slice_set(s : DshashperfectSlice, i : Int, v : Double) -> DshashperfectSlice {
  let result = ds_hash_perfect_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_perfect_slice_sum(s : DshashperfectSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_perfect_slice_mean(s : DshashperfectSlice) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_perfect_slice_sum(s) / s.size.to_double() }
}

pub fn ds_hash_perfect_slice_scale(s : DshashperfectSlice, f : Double) -> DshashperfectSlice {
  let result = ds_hash_perfect_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_perfect_slice_add(a : DshashperfectSlice, b : DshashperfectSlice) -> DshashperfectSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_perfect_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_perfect_slice_copy(s : DshashperfectSlice) -> DshashperfectSlice {
  let result = ds_hash_perfect_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_perfect_slice_fill(s : DshashperfectSlice, v : Double) -> DshashperfectSlice {
  let result = ds_hash_perfect_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_perfect_slice_min(s : DshashperfectSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_perfect_slice_max(s : DshashperfectSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_perfect_slice_to_string(s : DshashperfectSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn ds_hash_perfect_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_hash_perfect_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_hash_perfect_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_hash_perfect_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_hash_perfect_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_hash_perfect_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_hash_perfect_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_hash_perfect_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_hash_perfect_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_hash_perfect_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_hash_perfect_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_hash_perfect_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_hash_perfect_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_hash_perfect_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_hash_perfect_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_hash_perfect_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_hash_perfect_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_hash_perfect_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_hash_perfect_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_hash_perfect_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_hash_perfect_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_hash_perfect_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_hash_perfect_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_hash_perfect_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_hash_perfect_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}


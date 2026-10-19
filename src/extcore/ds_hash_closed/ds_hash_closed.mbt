///===
/// extcore/ds_hash_closed

pub(all) struct DshashclosedPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_hash_closed_make_point(x : Double, y : Double) -> DshashclosedPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_hash_closed_make_point3(x : Double, y : Double, z : Double) -> DshashclosedPoint {
  { x, y, z, label: 0 }
}

pub fn ds_hash_closed_point_x(pt : DshashclosedPoint) -> Double { pt.x }

pub fn ds_hash_closed_point_y(pt : DshashclosedPoint) -> Double { pt.y }

pub fn ds_hash_closed_point_z(pt : DshashclosedPoint) -> Double { pt.z }

pub fn ds_hash_closed_point_label(pt : DshashclosedPoint) -> Int { pt.label }

pub fn ds_hash_closed_point_dist(a : DshashclosedPoint, b : DshashclosedPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  ds_hash_closed_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ds_hash_closed_point_add(a : DshashclosedPoint, b : DshashclosedPoint) -> DshashclosedPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ds_hash_closed_point_sub(a : DshashclosedPoint, b : DshashclosedPoint) -> DshashclosedPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ds_hash_closed_point_scale(pt : DshashclosedPoint, s : Double) -> DshashclosedPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ds_hash_closed_point_dot(a : DshashclosedPoint, b : DshashclosedPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ds_hash_closed_point_cross(a : DshashclosedPoint, b : DshashclosedPoint) -> DshashclosedPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ds_hash_closed_point_norm(pt : DshashclosedPoint) -> Double {
  ds_hash_closed_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ds_hash_closed_point_normalize(pt : DshashclosedPoint) -> DshashclosedPoint {
  let n = ds_hash_closed_point_norm(pt)
  if n < 0.0000001 { pt } else { ds_hash_closed_point_scale(pt, 1.0 / n) }
}

pub fn ds_hash_closed_point_negate(pt : DshashclosedPoint) -> DshashclosedPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ds_hash_closed_point_mid(a : DshashclosedPoint, b : DshashclosedPoint) -> DshashclosedPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ds_hash_closed_point_lerp(a : DshashclosedPoint, b : DshashclosedPoint, t : Double) -> DshashclosedPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ds_hash_closed_point_to_string(pt : DshashclosedPoint) -> String {
  "(" + ds_hash_closed_dbl(pt.x) + ", " + ds_hash_closed_dbl(pt.y) + ", " + ds_hash_closed_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DshashclosedSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_hash_closed_make_series(vals : Array[Double], name : String) -> DshashclosedSeries {
  { vals, name, meta: 0 }
}

pub fn ds_hash_closed_series_len(s : DshashclosedSeries) -> Int { s.vals.length() }

pub fn ds_hash_closed_series_sum(s : DshashclosedSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn ds_hash_closed_series_mean(s : DshashclosedSeries) -> Double {
  let n = ds_hash_closed_series_len(s)
  if n == 0 { 0.0 } else { ds_hash_closed_series_sum(s) / n.to_double() }
}

pub fn ds_hash_closed_series_min(s : DshashclosedSeries) -> Double {
  let n = ds_hash_closed_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn ds_hash_closed_series_max(s : DshashclosedSeries) -> Double {
  let n = ds_hash_closed_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn ds_hash_closed_series_range(s : DshashclosedSeries) -> Double {
  ds_hash_closed_series_max(s) - ds_hash_closed_series_min(s)
}

pub fn ds_hash_closed_series_var(s : DshashclosedSeries) -> Double {
  let n = ds_hash_closed_series_len(s)
  if n == 0 { 0.0 } else {
    let m = ds_hash_closed_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn ds_hash_closed_series_std(s : DshashclosedSeries) -> Double { ds_hash_closed_sqrt(ds_hash_closed_series_var(s)) }

pub fn ds_hash_closed_series_median(s : DshashclosedSeries) -> Double {
  let n = ds_hash_closed_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = ds_hash_closed_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ds_hash_closed_series_scale(s : DshashclosedSeries, f : Double) -> DshashclosedSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = ds_hash_closed_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ds_hash_closed_series_add(a : DshashclosedSeries, b : DshashclosedSeries) -> DshashclosedSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = ds_hash_closed_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ds_hash_closed_series_sub(a : DshashclosedSeries, b : DshashclosedSeries) -> DshashclosedSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = ds_hash_closed_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ds_hash_closed_series_normalize(s : DshashclosedSeries) -> DshashclosedSeries {
  let mn = ds_hash_closed_series_min(s)
  let mx = ds_hash_closed_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = ds_hash_closed_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ds_hash_closed_series_cumsum(s : DshashclosedSeries) -> DshashclosedSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = ds_hash_closed_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn ds_hash_closed_series_to_string(s : DshashclosedSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + ds_hash_closed_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DshashclosedMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_hash_closed_make_matrix(rows : Int, cols : Int, val : Double) -> DshashclosedMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_hash_closed_matrix_identity(n : Int) -> DshashclosedMatrix {
  let m = ds_hash_closed_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ds_hash_closed_matrix_get(m : DshashclosedMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ds_hash_closed_matrix_transpose(m : DshashclosedMatrix) -> DshashclosedMatrix {
  let result = ds_hash_closed_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ds_hash_closed_matrix_add(a : DshashclosedMatrix, b : DshashclosedMatrix) -> DshashclosedMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ds_hash_closed_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ds_hash_closed_matrix_scale(m : DshashclosedMatrix, s : Double) -> DshashclosedMatrix {
  let result = ds_hash_closed_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ds_hash_closed_matrix_multiply(a : DshashclosedMatrix, b : DshashclosedMatrix) -> DshashclosedMatrix {
  if a.cols != b.rows { return ds_hash_closed_make_matrix(a.rows, b.cols, 0.0) }
  let result = ds_hash_closed_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ds_hash_closed_matrix_trace(m : DshashclosedMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ds_hash_closed_matrix_det(m : DshashclosedMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ds_hash_closed_matrix_norm(m : DshashclosedMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  ds_hash_closed_sqrt(sum)
}

pub fn ds_hash_closed_matrix_to_string(m : DshashclosedMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + ds_hash_closed_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct DshashclosedVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_hash_closed_make_vector(comps : Array[Double]) -> DshashclosedVector {
  { comps, dim: comps.length() }
}

pub fn ds_hash_closed_vector_zero(dim : Int) -> DshashclosedVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ds_hash_closed_vector_add(a : DshashclosedVector, b : DshashclosedVector) -> DshashclosedVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = ds_hash_closed_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_hash_closed_vector_sub(a : DshashclosedVector, b : DshashclosedVector) -> DshashclosedVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = ds_hash_closed_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_hash_closed_vector_scale(v : DshashclosedVector, s : Double) -> DshashclosedVector {
  let mut result = []
  for i in 0..<v.dim { result = ds_hash_closed_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ds_hash_closed_vector_dot(a : DshashclosedVector, b : DshashclosedVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ds_hash_closed_vector_norm(v : DshashclosedVector) -> Double { ds_hash_closed_sqrt(ds_hash_closed_vector_dot(v, v)) }

pub fn ds_hash_closed_vector_normalize(v : DshashclosedVector) -> DshashclosedVector {
  let n = ds_hash_closed_vector_norm(v)
  if n < 0.0000001 { v } else { ds_hash_closed_vector_scale(v, 1.0 / n) }
}

pub fn ds_hash_closed_vector_dist(a : DshashclosedVector, b : DshashclosedVector) -> Double {
  ds_hash_closed_vector_norm(ds_hash_closed_vector_sub(a, b))
}

pub fn ds_hash_closed_vector_to_string(v : DshashclosedVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + ds_hash_closed_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_hash_closed_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn ds_hash_closed_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = ds_hash_closed_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ds_hash_closed_std(data : Array[Double]) -> Double { ds_hash_closed_sqrt(ds_hash_closed_var(data)) }

pub fn ds_hash_closed_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = ds_hash_closed_mean(a); let mb = ds_hash_closed_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn ds_hash_closed_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = ds_hash_closed_std(a); let sb = ds_hash_closed_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { ds_hash_closed_cov(a, b) / (sa * sb) }
}

pub fn ds_hash_closed_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = ds_hash_closed_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ds_hash_closed_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn ds_hash_closed_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ds_hash_closed_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  ds_hash_closed_sqrt(ds_hash_closed_mse(pred, labels))
}

pub fn ds_hash_closed_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + ds_hash_closed_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn ds_hash_closed_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = ds_hash_closed_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn ds_hash_closed_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn ds_hash_closed_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn ds_hash_closed_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = ds_hash_closed_precision(pred, labels, pos); let r = ds_hash_closed_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn ds_hash_closed_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn ds_hash_closed_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = ds_hash_closed_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn ds_hash_closed_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn ds_hash_closed_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn ds_hash_closed_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = ds_hash_closed_gcd(a, b)
    (a / g) * b
  }
}

pub fn ds_hash_closed_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn ds_hash_closed_fibonacci(n : Int) -> Int {
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

pub fn ds_hash_closed_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = ds_hash_closed_min(data); let mx = ds_hash_closed_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn ds_hash_closed_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = ds_hash_closed_mean(data); let sd = ds_hash_closed_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn ds_hash_closed_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn ds_hash_closed_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn ds_hash_closed_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn ds_hash_closed_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn ds_hash_closed_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn ds_hash_closed_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn ds_hash_closed_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn ds_hash_closed_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn ds_hash_closed_dbl(x : Double) -> String {
  let i = if x >= 0.0 { ds_hash_closed_int(x) } else { -ds_hash_closed_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { ds_hash_closed_int(f * 1000000.0) } else { ds_hash_closed_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn ds_hash_closed_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn ds_hash_closed_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct DshashclosedFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_closed_frame_make(size : Int) -> DshashclosedFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_closed_frame_len(s : DshashclosedFrame) -> Int { s.size }

pub fn ds_hash_closed_frame_get(s : DshashclosedFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_closed_frame_set(s : DshashclosedFrame, i : Int, v : Double) -> DshashclosedFrame {
  let result = ds_hash_closed_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_closed_frame_sum(s : DshashclosedFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_closed_frame_mean(s : DshashclosedFrame) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_closed_frame_sum(s) / s.size.to_double() }
}

pub fn ds_hash_closed_frame_scale(s : DshashclosedFrame, f : Double) -> DshashclosedFrame {
  let result = ds_hash_closed_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_closed_frame_add(a : DshashclosedFrame, b : DshashclosedFrame) -> DshashclosedFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_closed_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_closed_frame_copy(s : DshashclosedFrame) -> DshashclosedFrame {
  let result = ds_hash_closed_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_closed_frame_fill(s : DshashclosedFrame, v : Double) -> DshashclosedFrame {
  let result = ds_hash_closed_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_closed_frame_min(s : DshashclosedFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_closed_frame_max(s : DshashclosedFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_closed_frame_to_string(s : DshashclosedFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashclosedTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_closed_table_make(size : Int) -> DshashclosedTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_closed_table_len(s : DshashclosedTable) -> Int { s.size }

pub fn ds_hash_closed_table_get(s : DshashclosedTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_closed_table_set(s : DshashclosedTable, i : Int, v : Double) -> DshashclosedTable {
  let result = ds_hash_closed_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_closed_table_sum(s : DshashclosedTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_closed_table_mean(s : DshashclosedTable) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_closed_table_sum(s) / s.size.to_double() }
}

pub fn ds_hash_closed_table_scale(s : DshashclosedTable, f : Double) -> DshashclosedTable {
  let result = ds_hash_closed_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_closed_table_add(a : DshashclosedTable, b : DshashclosedTable) -> DshashclosedTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_closed_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_closed_table_copy(s : DshashclosedTable) -> DshashclosedTable {
  let result = ds_hash_closed_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_closed_table_fill(s : DshashclosedTable, v : Double) -> DshashclosedTable {
  let result = ds_hash_closed_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_closed_table_min(s : DshashclosedTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_closed_table_max(s : DshashclosedTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_closed_table_to_string(s : DshashclosedTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashclosedGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_closed_graphn_make(size : Int) -> DshashclosedGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_closed_graphn_len(s : DshashclosedGraphN) -> Int { s.size }

pub fn ds_hash_closed_graphn_get(s : DshashclosedGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_closed_graphn_set(s : DshashclosedGraphN, i : Int, v : Double) -> DshashclosedGraphN {
  let result = ds_hash_closed_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_closed_graphn_sum(s : DshashclosedGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_closed_graphn_mean(s : DshashclosedGraphN) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_closed_graphn_sum(s) / s.size.to_double() }
}

pub fn ds_hash_closed_graphn_scale(s : DshashclosedGraphN, f : Double) -> DshashclosedGraphN {
  let result = ds_hash_closed_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_closed_graphn_add(a : DshashclosedGraphN, b : DshashclosedGraphN) -> DshashclosedGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_closed_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_closed_graphn_copy(s : DshashclosedGraphN) -> DshashclosedGraphN {
  let result = ds_hash_closed_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_closed_graphn_fill(s : DshashclosedGraphN, v : Double) -> DshashclosedGraphN {
  let result = ds_hash_closed_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_closed_graphn_min(s : DshashclosedGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_closed_graphn_max(s : DshashclosedGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_closed_graphn_to_string(s : DshashclosedGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashclosedNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_closed_node_make(size : Int) -> DshashclosedNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_closed_node_len(s : DshashclosedNode) -> Int { s.size }

pub fn ds_hash_closed_node_get(s : DshashclosedNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_closed_node_set(s : DshashclosedNode, i : Int, v : Double) -> DshashclosedNode {
  let result = ds_hash_closed_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_closed_node_sum(s : DshashclosedNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_closed_node_mean(s : DshashclosedNode) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_closed_node_sum(s) / s.size.to_double() }
}

pub fn ds_hash_closed_node_scale(s : DshashclosedNode, f : Double) -> DshashclosedNode {
  let result = ds_hash_closed_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_closed_node_add(a : DshashclosedNode, b : DshashclosedNode) -> DshashclosedNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_closed_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_closed_node_copy(s : DshashclosedNode) -> DshashclosedNode {
  let result = ds_hash_closed_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_closed_node_fill(s : DshashclosedNode, v : Double) -> DshashclosedNode {
  let result = ds_hash_closed_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_closed_node_min(s : DshashclosedNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_closed_node_max(s : DshashclosedNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_closed_node_to_string(s : DshashclosedNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashclosedEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_closed_edge_make(size : Int) -> DshashclosedEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_closed_edge_len(s : DshashclosedEdge) -> Int { s.size }

pub fn ds_hash_closed_edge_get(s : DshashclosedEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_closed_edge_set(s : DshashclosedEdge, i : Int, v : Double) -> DshashclosedEdge {
  let result = ds_hash_closed_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_closed_edge_sum(s : DshashclosedEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_closed_edge_mean(s : DshashclosedEdge) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_closed_edge_sum(s) / s.size.to_double() }
}

pub fn ds_hash_closed_edge_scale(s : DshashclosedEdge, f : Double) -> DshashclosedEdge {
  let result = ds_hash_closed_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_closed_edge_add(a : DshashclosedEdge, b : DshashclosedEdge) -> DshashclosedEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_closed_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_closed_edge_copy(s : DshashclosedEdge) -> DshashclosedEdge {
  let result = ds_hash_closed_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_closed_edge_fill(s : DshashclosedEdge, v : Double) -> DshashclosedEdge {
  let result = ds_hash_closed_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_closed_edge_min(s : DshashclosedEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_closed_edge_max(s : DshashclosedEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_closed_edge_to_string(s : DshashclosedEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashclosedPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_closed_path_make(size : Int) -> DshashclosedPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_closed_path_len(s : DshashclosedPath) -> Int { s.size }

pub fn ds_hash_closed_path_get(s : DshashclosedPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_closed_path_set(s : DshashclosedPath, i : Int, v : Double) -> DshashclosedPath {
  let result = ds_hash_closed_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_closed_path_sum(s : DshashclosedPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_closed_path_mean(s : DshashclosedPath) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_closed_path_sum(s) / s.size.to_double() }
}

pub fn ds_hash_closed_path_scale(s : DshashclosedPath, f : Double) -> DshashclosedPath {
  let result = ds_hash_closed_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_closed_path_add(a : DshashclosedPath, b : DshashclosedPath) -> DshashclosedPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_closed_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_closed_path_copy(s : DshashclosedPath) -> DshashclosedPath {
  let result = ds_hash_closed_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_closed_path_fill(s : DshashclosedPath, v : Double) -> DshashclosedPath {
  let result = ds_hash_closed_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_closed_path_min(s : DshashclosedPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_closed_path_max(s : DshashclosedPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_closed_path_to_string(s : DshashclosedPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashclosedCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_closed_cluster_make(size : Int) -> DshashclosedCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_closed_cluster_len(s : DshashclosedCluster) -> Int { s.size }

pub fn ds_hash_closed_cluster_get(s : DshashclosedCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_closed_cluster_set(s : DshashclosedCluster, i : Int, v : Double) -> DshashclosedCluster {
  let result = ds_hash_closed_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_closed_cluster_sum(s : DshashclosedCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_closed_cluster_mean(s : DshashclosedCluster) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_closed_cluster_sum(s) / s.size.to_double() }
}

pub fn ds_hash_closed_cluster_scale(s : DshashclosedCluster, f : Double) -> DshashclosedCluster {
  let result = ds_hash_closed_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_closed_cluster_add(a : DshashclosedCluster, b : DshashclosedCluster) -> DshashclosedCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_closed_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_closed_cluster_copy(s : DshashclosedCluster) -> DshashclosedCluster {
  let result = ds_hash_closed_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_closed_cluster_fill(s : DshashclosedCluster, v : Double) -> DshashclosedCluster {
  let result = ds_hash_closed_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_closed_cluster_min(s : DshashclosedCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_closed_cluster_max(s : DshashclosedCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_closed_cluster_to_string(s : DshashclosedCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashclosedModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_closed_model_make(size : Int) -> DshashclosedModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_closed_model_len(s : DshashclosedModel) -> Int { s.size }

pub fn ds_hash_closed_model_get(s : DshashclosedModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_closed_model_set(s : DshashclosedModel, i : Int, v : Double) -> DshashclosedModel {
  let result = ds_hash_closed_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_closed_model_sum(s : DshashclosedModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_closed_model_mean(s : DshashclosedModel) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_closed_model_sum(s) / s.size.to_double() }
}

pub fn ds_hash_closed_model_scale(s : DshashclosedModel, f : Double) -> DshashclosedModel {
  let result = ds_hash_closed_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_closed_model_add(a : DshashclosedModel, b : DshashclosedModel) -> DshashclosedModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_closed_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_closed_model_copy(s : DshashclosedModel) -> DshashclosedModel {
  let result = ds_hash_closed_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_closed_model_fill(s : DshashclosedModel, v : Double) -> DshashclosedModel {
  let result = ds_hash_closed_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_closed_model_min(s : DshashclosedModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_closed_model_max(s : DshashclosedModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_closed_model_to_string(s : DshashclosedModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashclosedLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_closed_layer_make(size : Int) -> DshashclosedLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_closed_layer_len(s : DshashclosedLayer) -> Int { s.size }

pub fn ds_hash_closed_layer_get(s : DshashclosedLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_closed_layer_set(s : DshashclosedLayer, i : Int, v : Double) -> DshashclosedLayer {
  let result = ds_hash_closed_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_closed_layer_sum(s : DshashclosedLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_closed_layer_mean(s : DshashclosedLayer) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_closed_layer_sum(s) / s.size.to_double() }
}

pub fn ds_hash_closed_layer_scale(s : DshashclosedLayer, f : Double) -> DshashclosedLayer {
  let result = ds_hash_closed_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_closed_layer_add(a : DshashclosedLayer, b : DshashclosedLayer) -> DshashclosedLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_closed_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_closed_layer_copy(s : DshashclosedLayer) -> DshashclosedLayer {
  let result = ds_hash_closed_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_closed_layer_fill(s : DshashclosedLayer, v : Double) -> DshashclosedLayer {
  let result = ds_hash_closed_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_closed_layer_min(s : DshashclosedLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_closed_layer_max(s : DshashclosedLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_closed_layer_to_string(s : DshashclosedLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashclosedBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_closed_buffer_make(size : Int) -> DshashclosedBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_closed_buffer_len(s : DshashclosedBuffer) -> Int { s.size }

pub fn ds_hash_closed_buffer_get(s : DshashclosedBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_closed_buffer_set(s : DshashclosedBuffer, i : Int, v : Double) -> DshashclosedBuffer {
  let result = ds_hash_closed_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_closed_buffer_sum(s : DshashclosedBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_closed_buffer_mean(s : DshashclosedBuffer) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_closed_buffer_sum(s) / s.size.to_double() }
}

pub fn ds_hash_closed_buffer_scale(s : DshashclosedBuffer, f : Double) -> DshashclosedBuffer {
  let result = ds_hash_closed_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_closed_buffer_add(a : DshashclosedBuffer, b : DshashclosedBuffer) -> DshashclosedBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_closed_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_closed_buffer_copy(s : DshashclosedBuffer) -> DshashclosedBuffer {
  let result = ds_hash_closed_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_closed_buffer_fill(s : DshashclosedBuffer, v : Double) -> DshashclosedBuffer {
  let result = ds_hash_closed_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_closed_buffer_min(s : DshashclosedBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_closed_buffer_max(s : DshashclosedBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_closed_buffer_to_string(s : DshashclosedBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashclosedCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_closed_cursor_make(size : Int) -> DshashclosedCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_closed_cursor_len(s : DshashclosedCursor) -> Int { s.size }

pub fn ds_hash_closed_cursor_get(s : DshashclosedCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_closed_cursor_set(s : DshashclosedCursor, i : Int, v : Double) -> DshashclosedCursor {
  let result = ds_hash_closed_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_closed_cursor_sum(s : DshashclosedCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_closed_cursor_mean(s : DshashclosedCursor) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_closed_cursor_sum(s) / s.size.to_double() }
}

pub fn ds_hash_closed_cursor_scale(s : DshashclosedCursor, f : Double) -> DshashclosedCursor {
  let result = ds_hash_closed_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_closed_cursor_add(a : DshashclosedCursor, b : DshashclosedCursor) -> DshashclosedCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_closed_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_closed_cursor_copy(s : DshashclosedCursor) -> DshashclosedCursor {
  let result = ds_hash_closed_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_closed_cursor_fill(s : DshashclosedCursor, v : Double) -> DshashclosedCursor {
  let result = ds_hash_closed_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_closed_cursor_min(s : DshashclosedCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_closed_cursor_max(s : DshashclosedCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_closed_cursor_to_string(s : DshashclosedCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashclosedView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_closed_view_make(size : Int) -> DshashclosedView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_closed_view_len(s : DshashclosedView) -> Int { s.size }

pub fn ds_hash_closed_view_get(s : DshashclosedView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_closed_view_set(s : DshashclosedView, i : Int, v : Double) -> DshashclosedView {
  let result = ds_hash_closed_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_closed_view_sum(s : DshashclosedView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_closed_view_mean(s : DshashclosedView) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_closed_view_sum(s) / s.size.to_double() }
}

pub fn ds_hash_closed_view_scale(s : DshashclosedView, f : Double) -> DshashclosedView {
  let result = ds_hash_closed_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_closed_view_add(a : DshashclosedView, b : DshashclosedView) -> DshashclosedView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_closed_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_closed_view_copy(s : DshashclosedView) -> DshashclosedView {
  let result = ds_hash_closed_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_closed_view_fill(s : DshashclosedView, v : Double) -> DshashclosedView {
  let result = ds_hash_closed_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_closed_view_min(s : DshashclosedView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_closed_view_max(s : DshashclosedView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_closed_view_to_string(s : DshashclosedView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashclosedRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_closed_range_make(size : Int) -> DshashclosedRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_closed_range_len(s : DshashclosedRange) -> Int { s.size }

pub fn ds_hash_closed_range_get(s : DshashclosedRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_closed_range_set(s : DshashclosedRange, i : Int, v : Double) -> DshashclosedRange {
  let result = ds_hash_closed_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_closed_range_sum(s : DshashclosedRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_closed_range_mean(s : DshashclosedRange) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_closed_range_sum(s) / s.size.to_double() }
}

pub fn ds_hash_closed_range_scale(s : DshashclosedRange, f : Double) -> DshashclosedRange {
  let result = ds_hash_closed_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_closed_range_add(a : DshashclosedRange, b : DshashclosedRange) -> DshashclosedRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_closed_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_closed_range_copy(s : DshashclosedRange) -> DshashclosedRange {
  let result = ds_hash_closed_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_closed_range_fill(s : DshashclosedRange, v : Double) -> DshashclosedRange {
  let result = ds_hash_closed_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_closed_range_min(s : DshashclosedRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_closed_range_max(s : DshashclosedRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_closed_range_to_string(s : DshashclosedRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashclosedSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_closed_slice_make(size : Int) -> DshashclosedSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_closed_slice_len(s : DshashclosedSlice) -> Int { s.size }

pub fn ds_hash_closed_slice_get(s : DshashclosedSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_closed_slice_set(s : DshashclosedSlice, i : Int, v : Double) -> DshashclosedSlice {
  let result = ds_hash_closed_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_closed_slice_sum(s : DshashclosedSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_closed_slice_mean(s : DshashclosedSlice) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_closed_slice_sum(s) / s.size.to_double() }
}

pub fn ds_hash_closed_slice_scale(s : DshashclosedSlice, f : Double) -> DshashclosedSlice {
  let result = ds_hash_closed_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_closed_slice_add(a : DshashclosedSlice, b : DshashclosedSlice) -> DshashclosedSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_closed_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_closed_slice_copy(s : DshashclosedSlice) -> DshashclosedSlice {
  let result = ds_hash_closed_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_closed_slice_fill(s : DshashclosedSlice, v : Double) -> DshashclosedSlice {
  let result = ds_hash_closed_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_closed_slice_min(s : DshashclosedSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_closed_slice_max(s : DshashclosedSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_closed_slice_to_string(s : DshashclosedSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn ds_hash_closed_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_hash_closed_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_hash_closed_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_hash_closed_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_hash_closed_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_hash_closed_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_hash_closed_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_hash_closed_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_hash_closed_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_hash_closed_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_hash_closed_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_hash_closed_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_hash_closed_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_hash_closed_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_hash_closed_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_hash_closed_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_hash_closed_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_hash_closed_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_hash_closed_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_hash_closed_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_hash_closed_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_hash_closed_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_hash_closed_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_hash_closed_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_hash_closed_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}


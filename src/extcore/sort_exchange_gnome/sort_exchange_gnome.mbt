///===
/// extcore/sort_exchange_gnome

pub(all) struct SortexchangegnomePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn sort_exchange_gnome_make_point(x : Double, y : Double) -> SortexchangegnomePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn sort_exchange_gnome_make_point3(x : Double, y : Double, z : Double) -> SortexchangegnomePoint {
  { x, y, z, label: 0 }
}

pub fn sort_exchange_gnome_point_x(pt : SortexchangegnomePoint) -> Double { pt.x }

pub fn sort_exchange_gnome_point_y(pt : SortexchangegnomePoint) -> Double { pt.y }

pub fn sort_exchange_gnome_point_z(pt : SortexchangegnomePoint) -> Double { pt.z }

pub fn sort_exchange_gnome_point_label(pt : SortexchangegnomePoint) -> Int { pt.label }

pub fn sort_exchange_gnome_point_dist(a : SortexchangegnomePoint, b : SortexchangegnomePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  sort_exchange_gnome_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn sort_exchange_gnome_point_add(a : SortexchangegnomePoint, b : SortexchangegnomePoint) -> SortexchangegnomePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn sort_exchange_gnome_point_sub(a : SortexchangegnomePoint, b : SortexchangegnomePoint) -> SortexchangegnomePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn sort_exchange_gnome_point_scale(pt : SortexchangegnomePoint, s : Double) -> SortexchangegnomePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn sort_exchange_gnome_point_dot(a : SortexchangegnomePoint, b : SortexchangegnomePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn sort_exchange_gnome_point_cross(a : SortexchangegnomePoint, b : SortexchangegnomePoint) -> SortexchangegnomePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn sort_exchange_gnome_point_norm(pt : SortexchangegnomePoint) -> Double {
  sort_exchange_gnome_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn sort_exchange_gnome_point_normalize(pt : SortexchangegnomePoint) -> SortexchangegnomePoint {
  let n = sort_exchange_gnome_point_norm(pt)
  if n < 0.0000001 { pt } else { sort_exchange_gnome_point_scale(pt, 1.0 / n) }
}

pub fn sort_exchange_gnome_point_negate(pt : SortexchangegnomePoint) -> SortexchangegnomePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn sort_exchange_gnome_point_mid(a : SortexchangegnomePoint, b : SortexchangegnomePoint) -> SortexchangegnomePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn sort_exchange_gnome_point_lerp(a : SortexchangegnomePoint, b : SortexchangegnomePoint, t : Double) -> SortexchangegnomePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn sort_exchange_gnome_point_to_string(pt : SortexchangegnomePoint) -> String {
  "(" + sort_exchange_gnome_dbl(pt.x) + ", " + sort_exchange_gnome_dbl(pt.y) + ", " + sort_exchange_gnome_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct SortexchangegnomeSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn sort_exchange_gnome_make_series(vals : Array[Double], name : String) -> SortexchangegnomeSeries {
  { vals, name, meta: 0 }
}

pub fn sort_exchange_gnome_series_len(s : SortexchangegnomeSeries) -> Int { s.vals.length() }

pub fn sort_exchange_gnome_series_sum(s : SortexchangegnomeSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn sort_exchange_gnome_series_mean(s : SortexchangegnomeSeries) -> Double {
  let n = sort_exchange_gnome_series_len(s)
  if n == 0 { 0.0 } else { sort_exchange_gnome_series_sum(s) / n.to_double() }
}

pub fn sort_exchange_gnome_series_min(s : SortexchangegnomeSeries) -> Double {
  let n = sort_exchange_gnome_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn sort_exchange_gnome_series_max(s : SortexchangegnomeSeries) -> Double {
  let n = sort_exchange_gnome_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn sort_exchange_gnome_series_range(s : SortexchangegnomeSeries) -> Double {
  sort_exchange_gnome_series_max(s) - sort_exchange_gnome_series_min(s)
}

pub fn sort_exchange_gnome_series_var(s : SortexchangegnomeSeries) -> Double {
  let n = sort_exchange_gnome_series_len(s)
  if n == 0 { 0.0 } else {
    let m = sort_exchange_gnome_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn sort_exchange_gnome_series_std(s : SortexchangegnomeSeries) -> Double { sort_exchange_gnome_sqrt(sort_exchange_gnome_series_var(s)) }

pub fn sort_exchange_gnome_series_median(s : SortexchangegnomeSeries) -> Double {
  let n = sort_exchange_gnome_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = sort_exchange_gnome_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn sort_exchange_gnome_series_scale(s : SortexchangegnomeSeries, f : Double) -> SortexchangegnomeSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = sort_exchange_gnome_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn sort_exchange_gnome_series_add(a : SortexchangegnomeSeries, b : SortexchangegnomeSeries) -> SortexchangegnomeSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = sort_exchange_gnome_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn sort_exchange_gnome_series_sub(a : SortexchangegnomeSeries, b : SortexchangegnomeSeries) -> SortexchangegnomeSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = sort_exchange_gnome_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn sort_exchange_gnome_series_normalize(s : SortexchangegnomeSeries) -> SortexchangegnomeSeries {
  let mn = sort_exchange_gnome_series_min(s)
  let mx = sort_exchange_gnome_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = sort_exchange_gnome_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn sort_exchange_gnome_series_cumsum(s : SortexchangegnomeSeries) -> SortexchangegnomeSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = sort_exchange_gnome_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn sort_exchange_gnome_series_to_string(s : SortexchangegnomeSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + sort_exchange_gnome_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SortexchangegnomeMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn sort_exchange_gnome_make_matrix(rows : Int, cols : Int, val : Double) -> SortexchangegnomeMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn sort_exchange_gnome_matrix_identity(n : Int) -> SortexchangegnomeMatrix {
  let m = sort_exchange_gnome_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn sort_exchange_gnome_matrix_get(m : SortexchangegnomeMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn sort_exchange_gnome_matrix_transpose(m : SortexchangegnomeMatrix) -> SortexchangegnomeMatrix {
  let result = sort_exchange_gnome_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn sort_exchange_gnome_matrix_add(a : SortexchangegnomeMatrix, b : SortexchangegnomeMatrix) -> SortexchangegnomeMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = sort_exchange_gnome_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn sort_exchange_gnome_matrix_scale(m : SortexchangegnomeMatrix, s : Double) -> SortexchangegnomeMatrix {
  let result = sort_exchange_gnome_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn sort_exchange_gnome_matrix_multiply(a : SortexchangegnomeMatrix, b : SortexchangegnomeMatrix) -> SortexchangegnomeMatrix {
  if a.cols != b.rows { return sort_exchange_gnome_make_matrix(a.rows, b.cols, 0.0) }
  let result = sort_exchange_gnome_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn sort_exchange_gnome_matrix_trace(m : SortexchangegnomeMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn sort_exchange_gnome_matrix_det(m : SortexchangegnomeMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn sort_exchange_gnome_matrix_norm(m : SortexchangegnomeMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  sort_exchange_gnome_sqrt(sum)
}

pub fn sort_exchange_gnome_matrix_to_string(m : SortexchangegnomeMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + sort_exchange_gnome_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct SortexchangegnomeVector {
  comps : Array[Double]
  dim : Int
}

pub fn sort_exchange_gnome_make_vector(comps : Array[Double]) -> SortexchangegnomeVector {
  { comps, dim: comps.length() }
}

pub fn sort_exchange_gnome_vector_zero(dim : Int) -> SortexchangegnomeVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn sort_exchange_gnome_vector_add(a : SortexchangegnomeVector, b : SortexchangegnomeVector) -> SortexchangegnomeVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = sort_exchange_gnome_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn sort_exchange_gnome_vector_sub(a : SortexchangegnomeVector, b : SortexchangegnomeVector) -> SortexchangegnomeVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = sort_exchange_gnome_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn sort_exchange_gnome_vector_scale(v : SortexchangegnomeVector, s : Double) -> SortexchangegnomeVector {
  let mut result = []
  for i in 0..<v.dim { result = sort_exchange_gnome_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn sort_exchange_gnome_vector_dot(a : SortexchangegnomeVector, b : SortexchangegnomeVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn sort_exchange_gnome_vector_norm(v : SortexchangegnomeVector) -> Double { sort_exchange_gnome_sqrt(sort_exchange_gnome_vector_dot(v, v)) }

pub fn sort_exchange_gnome_vector_normalize(v : SortexchangegnomeVector) -> SortexchangegnomeVector {
  let n = sort_exchange_gnome_vector_norm(v)
  if n < 0.0000001 { v } else { sort_exchange_gnome_vector_scale(v, 1.0 / n) }
}

pub fn sort_exchange_gnome_vector_dist(a : SortexchangegnomeVector, b : SortexchangegnomeVector) -> Double {
  sort_exchange_gnome_vector_norm(sort_exchange_gnome_vector_sub(a, b))
}

pub fn sort_exchange_gnome_vector_to_string(v : SortexchangegnomeVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + sort_exchange_gnome_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn sort_exchange_gnome_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn sort_exchange_gnome_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = sort_exchange_gnome_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn sort_exchange_gnome_std(data : Array[Double]) -> Double { sort_exchange_gnome_sqrt(sort_exchange_gnome_var(data)) }

pub fn sort_exchange_gnome_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = sort_exchange_gnome_mean(a); let mb = sort_exchange_gnome_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn sort_exchange_gnome_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = sort_exchange_gnome_std(a); let sb = sort_exchange_gnome_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { sort_exchange_gnome_cov(a, b) / (sa * sb) }
}

pub fn sort_exchange_gnome_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = sort_exchange_gnome_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn sort_exchange_gnome_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn sort_exchange_gnome_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn sort_exchange_gnome_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  sort_exchange_gnome_sqrt(sort_exchange_gnome_mse(pred, labels))
}

pub fn sort_exchange_gnome_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + sort_exchange_gnome_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn sort_exchange_gnome_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = sort_exchange_gnome_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn sort_exchange_gnome_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn sort_exchange_gnome_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn sort_exchange_gnome_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = sort_exchange_gnome_precision(pred, labels, pos); let r = sort_exchange_gnome_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn sort_exchange_gnome_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn sort_exchange_gnome_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = sort_exchange_gnome_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn sort_exchange_gnome_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn sort_exchange_gnome_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn sort_exchange_gnome_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = sort_exchange_gnome_gcd(a, b)
    (a / g) * b
  }
}

pub fn sort_exchange_gnome_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn sort_exchange_gnome_fibonacci(n : Int) -> Int {
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

pub fn sort_exchange_gnome_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = sort_exchange_gnome_min(data); let mx = sort_exchange_gnome_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn sort_exchange_gnome_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = sort_exchange_gnome_mean(data); let sd = sort_exchange_gnome_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn sort_exchange_gnome_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn sort_exchange_gnome_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn sort_exchange_gnome_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn sort_exchange_gnome_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn sort_exchange_gnome_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn sort_exchange_gnome_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn sort_exchange_gnome_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn sort_exchange_gnome_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn sort_exchange_gnome_dbl(x : Double) -> String {
  let i = if x >= 0.0 { sort_exchange_gnome_int(x) } else { -sort_exchange_gnome_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { sort_exchange_gnome_int(f * 1000000.0) } else { sort_exchange_gnome_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn sort_exchange_gnome_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn sort_exchange_gnome_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct SortexchangegnomeFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_gnome_frame_make(size : Int) -> SortexchangegnomeFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_gnome_frame_len(s : SortexchangegnomeFrame) -> Int { s.size }

pub fn sort_exchange_gnome_frame_get(s : SortexchangegnomeFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_gnome_frame_set(s : SortexchangegnomeFrame, i : Int, v : Double) -> SortexchangegnomeFrame {
  let result = sort_exchange_gnome_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_gnome_frame_sum(s : SortexchangegnomeFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_gnome_frame_mean(s : SortexchangegnomeFrame) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_gnome_frame_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_gnome_frame_scale(s : SortexchangegnomeFrame, f : Double) -> SortexchangegnomeFrame {
  let result = sort_exchange_gnome_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_gnome_frame_add(a : SortexchangegnomeFrame, b : SortexchangegnomeFrame) -> SortexchangegnomeFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_gnome_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_gnome_frame_copy(s : SortexchangegnomeFrame) -> SortexchangegnomeFrame {
  let result = sort_exchange_gnome_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_gnome_frame_fill(s : SortexchangegnomeFrame, v : Double) -> SortexchangegnomeFrame {
  let result = sort_exchange_gnome_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_gnome_frame_min(s : SortexchangegnomeFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_gnome_frame_max(s : SortexchangegnomeFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_gnome_frame_to_string(s : SortexchangegnomeFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangegnomeTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_gnome_table_make(size : Int) -> SortexchangegnomeTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_gnome_table_len(s : SortexchangegnomeTable) -> Int { s.size }

pub fn sort_exchange_gnome_table_get(s : SortexchangegnomeTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_gnome_table_set(s : SortexchangegnomeTable, i : Int, v : Double) -> SortexchangegnomeTable {
  let result = sort_exchange_gnome_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_gnome_table_sum(s : SortexchangegnomeTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_gnome_table_mean(s : SortexchangegnomeTable) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_gnome_table_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_gnome_table_scale(s : SortexchangegnomeTable, f : Double) -> SortexchangegnomeTable {
  let result = sort_exchange_gnome_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_gnome_table_add(a : SortexchangegnomeTable, b : SortexchangegnomeTable) -> SortexchangegnomeTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_gnome_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_gnome_table_copy(s : SortexchangegnomeTable) -> SortexchangegnomeTable {
  let result = sort_exchange_gnome_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_gnome_table_fill(s : SortexchangegnomeTable, v : Double) -> SortexchangegnomeTable {
  let result = sort_exchange_gnome_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_gnome_table_min(s : SortexchangegnomeTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_gnome_table_max(s : SortexchangegnomeTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_gnome_table_to_string(s : SortexchangegnomeTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangegnomeGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_gnome_graphn_make(size : Int) -> SortexchangegnomeGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_gnome_graphn_len(s : SortexchangegnomeGraphN) -> Int { s.size }

pub fn sort_exchange_gnome_graphn_get(s : SortexchangegnomeGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_gnome_graphn_set(s : SortexchangegnomeGraphN, i : Int, v : Double) -> SortexchangegnomeGraphN {
  let result = sort_exchange_gnome_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_gnome_graphn_sum(s : SortexchangegnomeGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_gnome_graphn_mean(s : SortexchangegnomeGraphN) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_gnome_graphn_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_gnome_graphn_scale(s : SortexchangegnomeGraphN, f : Double) -> SortexchangegnomeGraphN {
  let result = sort_exchange_gnome_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_gnome_graphn_add(a : SortexchangegnomeGraphN, b : SortexchangegnomeGraphN) -> SortexchangegnomeGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_gnome_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_gnome_graphn_copy(s : SortexchangegnomeGraphN) -> SortexchangegnomeGraphN {
  let result = sort_exchange_gnome_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_gnome_graphn_fill(s : SortexchangegnomeGraphN, v : Double) -> SortexchangegnomeGraphN {
  let result = sort_exchange_gnome_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_gnome_graphn_min(s : SortexchangegnomeGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_gnome_graphn_max(s : SortexchangegnomeGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_gnome_graphn_to_string(s : SortexchangegnomeGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangegnomeNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_gnome_node_make(size : Int) -> SortexchangegnomeNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_gnome_node_len(s : SortexchangegnomeNode) -> Int { s.size }

pub fn sort_exchange_gnome_node_get(s : SortexchangegnomeNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_gnome_node_set(s : SortexchangegnomeNode, i : Int, v : Double) -> SortexchangegnomeNode {
  let result = sort_exchange_gnome_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_gnome_node_sum(s : SortexchangegnomeNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_gnome_node_mean(s : SortexchangegnomeNode) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_gnome_node_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_gnome_node_scale(s : SortexchangegnomeNode, f : Double) -> SortexchangegnomeNode {
  let result = sort_exchange_gnome_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_gnome_node_add(a : SortexchangegnomeNode, b : SortexchangegnomeNode) -> SortexchangegnomeNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_gnome_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_gnome_node_copy(s : SortexchangegnomeNode) -> SortexchangegnomeNode {
  let result = sort_exchange_gnome_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_gnome_node_fill(s : SortexchangegnomeNode, v : Double) -> SortexchangegnomeNode {
  let result = sort_exchange_gnome_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_gnome_node_min(s : SortexchangegnomeNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_gnome_node_max(s : SortexchangegnomeNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_gnome_node_to_string(s : SortexchangegnomeNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangegnomeEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_gnome_edge_make(size : Int) -> SortexchangegnomeEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_gnome_edge_len(s : SortexchangegnomeEdge) -> Int { s.size }

pub fn sort_exchange_gnome_edge_get(s : SortexchangegnomeEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_gnome_edge_set(s : SortexchangegnomeEdge, i : Int, v : Double) -> SortexchangegnomeEdge {
  let result = sort_exchange_gnome_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_gnome_edge_sum(s : SortexchangegnomeEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_gnome_edge_mean(s : SortexchangegnomeEdge) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_gnome_edge_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_gnome_edge_scale(s : SortexchangegnomeEdge, f : Double) -> SortexchangegnomeEdge {
  let result = sort_exchange_gnome_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_gnome_edge_add(a : SortexchangegnomeEdge, b : SortexchangegnomeEdge) -> SortexchangegnomeEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_gnome_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_gnome_edge_copy(s : SortexchangegnomeEdge) -> SortexchangegnomeEdge {
  let result = sort_exchange_gnome_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_gnome_edge_fill(s : SortexchangegnomeEdge, v : Double) -> SortexchangegnomeEdge {
  let result = sort_exchange_gnome_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_gnome_edge_min(s : SortexchangegnomeEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_gnome_edge_max(s : SortexchangegnomeEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_gnome_edge_to_string(s : SortexchangegnomeEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangegnomePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_gnome_path_make(size : Int) -> SortexchangegnomePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_gnome_path_len(s : SortexchangegnomePath) -> Int { s.size }

pub fn sort_exchange_gnome_path_get(s : SortexchangegnomePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_gnome_path_set(s : SortexchangegnomePath, i : Int, v : Double) -> SortexchangegnomePath {
  let result = sort_exchange_gnome_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_gnome_path_sum(s : SortexchangegnomePath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_gnome_path_mean(s : SortexchangegnomePath) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_gnome_path_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_gnome_path_scale(s : SortexchangegnomePath, f : Double) -> SortexchangegnomePath {
  let result = sort_exchange_gnome_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_gnome_path_add(a : SortexchangegnomePath, b : SortexchangegnomePath) -> SortexchangegnomePath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_gnome_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_gnome_path_copy(s : SortexchangegnomePath) -> SortexchangegnomePath {
  let result = sort_exchange_gnome_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_gnome_path_fill(s : SortexchangegnomePath, v : Double) -> SortexchangegnomePath {
  let result = sort_exchange_gnome_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_gnome_path_min(s : SortexchangegnomePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_gnome_path_max(s : SortexchangegnomePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_gnome_path_to_string(s : SortexchangegnomePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangegnomeCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_gnome_cluster_make(size : Int) -> SortexchangegnomeCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_gnome_cluster_len(s : SortexchangegnomeCluster) -> Int { s.size }

pub fn sort_exchange_gnome_cluster_get(s : SortexchangegnomeCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_gnome_cluster_set(s : SortexchangegnomeCluster, i : Int, v : Double) -> SortexchangegnomeCluster {
  let result = sort_exchange_gnome_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_gnome_cluster_sum(s : SortexchangegnomeCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_gnome_cluster_mean(s : SortexchangegnomeCluster) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_gnome_cluster_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_gnome_cluster_scale(s : SortexchangegnomeCluster, f : Double) -> SortexchangegnomeCluster {
  let result = sort_exchange_gnome_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_gnome_cluster_add(a : SortexchangegnomeCluster, b : SortexchangegnomeCluster) -> SortexchangegnomeCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_gnome_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_gnome_cluster_copy(s : SortexchangegnomeCluster) -> SortexchangegnomeCluster {
  let result = sort_exchange_gnome_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_gnome_cluster_fill(s : SortexchangegnomeCluster, v : Double) -> SortexchangegnomeCluster {
  let result = sort_exchange_gnome_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_gnome_cluster_min(s : SortexchangegnomeCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_gnome_cluster_max(s : SortexchangegnomeCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_gnome_cluster_to_string(s : SortexchangegnomeCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangegnomeModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_gnome_model_make(size : Int) -> SortexchangegnomeModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_gnome_model_len(s : SortexchangegnomeModel) -> Int { s.size }

pub fn sort_exchange_gnome_model_get(s : SortexchangegnomeModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_gnome_model_set(s : SortexchangegnomeModel, i : Int, v : Double) -> SortexchangegnomeModel {
  let result = sort_exchange_gnome_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_gnome_model_sum(s : SortexchangegnomeModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_gnome_model_mean(s : SortexchangegnomeModel) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_gnome_model_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_gnome_model_scale(s : SortexchangegnomeModel, f : Double) -> SortexchangegnomeModel {
  let result = sort_exchange_gnome_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_gnome_model_add(a : SortexchangegnomeModel, b : SortexchangegnomeModel) -> SortexchangegnomeModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_gnome_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_gnome_model_copy(s : SortexchangegnomeModel) -> SortexchangegnomeModel {
  let result = sort_exchange_gnome_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_gnome_model_fill(s : SortexchangegnomeModel, v : Double) -> SortexchangegnomeModel {
  let result = sort_exchange_gnome_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_gnome_model_min(s : SortexchangegnomeModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_gnome_model_max(s : SortexchangegnomeModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_gnome_model_to_string(s : SortexchangegnomeModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangegnomeLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_gnome_layer_make(size : Int) -> SortexchangegnomeLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_gnome_layer_len(s : SortexchangegnomeLayer) -> Int { s.size }

pub fn sort_exchange_gnome_layer_get(s : SortexchangegnomeLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_gnome_layer_set(s : SortexchangegnomeLayer, i : Int, v : Double) -> SortexchangegnomeLayer {
  let result = sort_exchange_gnome_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_gnome_layer_sum(s : SortexchangegnomeLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_gnome_layer_mean(s : SortexchangegnomeLayer) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_gnome_layer_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_gnome_layer_scale(s : SortexchangegnomeLayer, f : Double) -> SortexchangegnomeLayer {
  let result = sort_exchange_gnome_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_gnome_layer_add(a : SortexchangegnomeLayer, b : SortexchangegnomeLayer) -> SortexchangegnomeLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_gnome_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_gnome_layer_copy(s : SortexchangegnomeLayer) -> SortexchangegnomeLayer {
  let result = sort_exchange_gnome_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_gnome_layer_fill(s : SortexchangegnomeLayer, v : Double) -> SortexchangegnomeLayer {
  let result = sort_exchange_gnome_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_gnome_layer_min(s : SortexchangegnomeLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_gnome_layer_max(s : SortexchangegnomeLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_gnome_layer_to_string(s : SortexchangegnomeLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangegnomeBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_gnome_buffer_make(size : Int) -> SortexchangegnomeBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_gnome_buffer_len(s : SortexchangegnomeBuffer) -> Int { s.size }

pub fn sort_exchange_gnome_buffer_get(s : SortexchangegnomeBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_gnome_buffer_set(s : SortexchangegnomeBuffer, i : Int, v : Double) -> SortexchangegnomeBuffer {
  let result = sort_exchange_gnome_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_gnome_buffer_sum(s : SortexchangegnomeBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_gnome_buffer_mean(s : SortexchangegnomeBuffer) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_gnome_buffer_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_gnome_buffer_scale(s : SortexchangegnomeBuffer, f : Double) -> SortexchangegnomeBuffer {
  let result = sort_exchange_gnome_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_gnome_buffer_add(a : SortexchangegnomeBuffer, b : SortexchangegnomeBuffer) -> SortexchangegnomeBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_gnome_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_gnome_buffer_copy(s : SortexchangegnomeBuffer) -> SortexchangegnomeBuffer {
  let result = sort_exchange_gnome_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_gnome_buffer_fill(s : SortexchangegnomeBuffer, v : Double) -> SortexchangegnomeBuffer {
  let result = sort_exchange_gnome_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_gnome_buffer_min(s : SortexchangegnomeBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_gnome_buffer_max(s : SortexchangegnomeBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_gnome_buffer_to_string(s : SortexchangegnomeBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangegnomeCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_gnome_cursor_make(size : Int) -> SortexchangegnomeCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_gnome_cursor_len(s : SortexchangegnomeCursor) -> Int { s.size }

pub fn sort_exchange_gnome_cursor_get(s : SortexchangegnomeCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_gnome_cursor_set(s : SortexchangegnomeCursor, i : Int, v : Double) -> SortexchangegnomeCursor {
  let result = sort_exchange_gnome_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_gnome_cursor_sum(s : SortexchangegnomeCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_gnome_cursor_mean(s : SortexchangegnomeCursor) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_gnome_cursor_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_gnome_cursor_scale(s : SortexchangegnomeCursor, f : Double) -> SortexchangegnomeCursor {
  let result = sort_exchange_gnome_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_gnome_cursor_add(a : SortexchangegnomeCursor, b : SortexchangegnomeCursor) -> SortexchangegnomeCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_gnome_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_gnome_cursor_copy(s : SortexchangegnomeCursor) -> SortexchangegnomeCursor {
  let result = sort_exchange_gnome_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_gnome_cursor_fill(s : SortexchangegnomeCursor, v : Double) -> SortexchangegnomeCursor {
  let result = sort_exchange_gnome_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_gnome_cursor_min(s : SortexchangegnomeCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_gnome_cursor_max(s : SortexchangegnomeCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_gnome_cursor_to_string(s : SortexchangegnomeCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangegnomeView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_gnome_view_make(size : Int) -> SortexchangegnomeView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_gnome_view_len(s : SortexchangegnomeView) -> Int { s.size }

pub fn sort_exchange_gnome_view_get(s : SortexchangegnomeView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_gnome_view_set(s : SortexchangegnomeView, i : Int, v : Double) -> SortexchangegnomeView {
  let result = sort_exchange_gnome_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_gnome_view_sum(s : SortexchangegnomeView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_gnome_view_mean(s : SortexchangegnomeView) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_gnome_view_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_gnome_view_scale(s : SortexchangegnomeView, f : Double) -> SortexchangegnomeView {
  let result = sort_exchange_gnome_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_gnome_view_add(a : SortexchangegnomeView, b : SortexchangegnomeView) -> SortexchangegnomeView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_gnome_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_gnome_view_copy(s : SortexchangegnomeView) -> SortexchangegnomeView {
  let result = sort_exchange_gnome_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_gnome_view_fill(s : SortexchangegnomeView, v : Double) -> SortexchangegnomeView {
  let result = sort_exchange_gnome_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_gnome_view_min(s : SortexchangegnomeView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_gnome_view_max(s : SortexchangegnomeView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_gnome_view_to_string(s : SortexchangegnomeView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangegnomeRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_gnome_range_make(size : Int) -> SortexchangegnomeRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_gnome_range_len(s : SortexchangegnomeRange) -> Int { s.size }

pub fn sort_exchange_gnome_range_get(s : SortexchangegnomeRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_gnome_range_set(s : SortexchangegnomeRange, i : Int, v : Double) -> SortexchangegnomeRange {
  let result = sort_exchange_gnome_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_gnome_range_sum(s : SortexchangegnomeRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_gnome_range_mean(s : SortexchangegnomeRange) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_gnome_range_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_gnome_range_scale(s : SortexchangegnomeRange, f : Double) -> SortexchangegnomeRange {
  let result = sort_exchange_gnome_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_gnome_range_add(a : SortexchangegnomeRange, b : SortexchangegnomeRange) -> SortexchangegnomeRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_gnome_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_gnome_range_copy(s : SortexchangegnomeRange) -> SortexchangegnomeRange {
  let result = sort_exchange_gnome_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_gnome_range_fill(s : SortexchangegnomeRange, v : Double) -> SortexchangegnomeRange {
  let result = sort_exchange_gnome_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_gnome_range_min(s : SortexchangegnomeRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_gnome_range_max(s : SortexchangegnomeRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_gnome_range_to_string(s : SortexchangegnomeRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangegnomeSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_gnome_slice_make(size : Int) -> SortexchangegnomeSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_gnome_slice_len(s : SortexchangegnomeSlice) -> Int { s.size }

pub fn sort_exchange_gnome_slice_get(s : SortexchangegnomeSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_gnome_slice_set(s : SortexchangegnomeSlice, i : Int, v : Double) -> SortexchangegnomeSlice {
  let result = sort_exchange_gnome_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_gnome_slice_sum(s : SortexchangegnomeSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_gnome_slice_mean(s : SortexchangegnomeSlice) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_gnome_slice_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_gnome_slice_scale(s : SortexchangegnomeSlice, f : Double) -> SortexchangegnomeSlice {
  let result = sort_exchange_gnome_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_gnome_slice_add(a : SortexchangegnomeSlice, b : SortexchangegnomeSlice) -> SortexchangegnomeSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_gnome_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_gnome_slice_copy(s : SortexchangegnomeSlice) -> SortexchangegnomeSlice {
  let result = sort_exchange_gnome_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_gnome_slice_fill(s : SortexchangegnomeSlice, v : Double) -> SortexchangegnomeSlice {
  let result = sort_exchange_gnome_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_gnome_slice_min(s : SortexchangegnomeSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_gnome_slice_max(s : SortexchangegnomeSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_gnome_slice_to_string(s : SortexchangegnomeSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn sort_exchange_gnome_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_exchange_gnome_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_exchange_gnome_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_exchange_gnome_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_exchange_gnome_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_exchange_gnome_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_exchange_gnome_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_exchange_gnome_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_exchange_gnome_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_exchange_gnome_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_exchange_gnome_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_exchange_gnome_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_exchange_gnome_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_exchange_gnome_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_exchange_gnome_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_exchange_gnome_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_exchange_gnome_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_exchange_gnome_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_exchange_gnome_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_exchange_gnome_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_exchange_gnome_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_exchange_gnome_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_exchange_gnome_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_exchange_gnome_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_exchange_gnome_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}


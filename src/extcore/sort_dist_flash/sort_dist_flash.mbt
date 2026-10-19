///===
/// extcore/sort_dist_flash

pub(all) struct SortdistflashPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn sort_dist_flash_make_point(x : Double, y : Double) -> SortdistflashPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn sort_dist_flash_make_point3(x : Double, y : Double, z : Double) -> SortdistflashPoint {
  { x, y, z, label: 0 }
}

pub fn sort_dist_flash_point_x(pt : SortdistflashPoint) -> Double { pt.x }

pub fn sort_dist_flash_point_y(pt : SortdistflashPoint) -> Double { pt.y }

pub fn sort_dist_flash_point_z(pt : SortdistflashPoint) -> Double { pt.z }

pub fn sort_dist_flash_point_label(pt : SortdistflashPoint) -> Int { pt.label }

pub fn sort_dist_flash_point_dist(a : SortdistflashPoint, b : SortdistflashPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  sort_dist_flash_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn sort_dist_flash_point_add(a : SortdistflashPoint, b : SortdistflashPoint) -> SortdistflashPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn sort_dist_flash_point_sub(a : SortdistflashPoint, b : SortdistflashPoint) -> SortdistflashPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn sort_dist_flash_point_scale(pt : SortdistflashPoint, s : Double) -> SortdistflashPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn sort_dist_flash_point_dot(a : SortdistflashPoint, b : SortdistflashPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn sort_dist_flash_point_cross(a : SortdistflashPoint, b : SortdistflashPoint) -> SortdistflashPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn sort_dist_flash_point_norm(pt : SortdistflashPoint) -> Double {
  sort_dist_flash_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn sort_dist_flash_point_normalize(pt : SortdistflashPoint) -> SortdistflashPoint {
  let n = sort_dist_flash_point_norm(pt)
  if n < 0.0000001 { pt } else { sort_dist_flash_point_scale(pt, 1.0 / n) }
}

pub fn sort_dist_flash_point_negate(pt : SortdistflashPoint) -> SortdistflashPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn sort_dist_flash_point_mid(a : SortdistflashPoint, b : SortdistflashPoint) -> SortdistflashPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn sort_dist_flash_point_lerp(a : SortdistflashPoint, b : SortdistflashPoint, t : Double) -> SortdistflashPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn sort_dist_flash_point_to_string(pt : SortdistflashPoint) -> String {
  "(" + sort_dist_flash_dbl(pt.x) + ", " + sort_dist_flash_dbl(pt.y) + ", " + sort_dist_flash_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct SortdistflashSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn sort_dist_flash_make_series(vals : Array[Double], name : String) -> SortdistflashSeries {
  { vals, name, meta: 0 }
}

pub fn sort_dist_flash_series_len(s : SortdistflashSeries) -> Int { s.vals.length() }

pub fn sort_dist_flash_series_sum(s : SortdistflashSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn sort_dist_flash_series_mean(s : SortdistflashSeries) -> Double {
  let n = sort_dist_flash_series_len(s)
  if n == 0 { 0.0 } else { sort_dist_flash_series_sum(s) / n.to_double() }
}

pub fn sort_dist_flash_series_min(s : SortdistflashSeries) -> Double {
  let n = sort_dist_flash_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn sort_dist_flash_series_max(s : SortdistflashSeries) -> Double {
  let n = sort_dist_flash_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn sort_dist_flash_series_range(s : SortdistflashSeries) -> Double {
  sort_dist_flash_series_max(s) - sort_dist_flash_series_min(s)
}

pub fn sort_dist_flash_series_var(s : SortdistflashSeries) -> Double {
  let n = sort_dist_flash_series_len(s)
  if n == 0 { 0.0 } else {
    let m = sort_dist_flash_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn sort_dist_flash_series_std(s : SortdistflashSeries) -> Double { sort_dist_flash_sqrt(sort_dist_flash_series_var(s)) }

pub fn sort_dist_flash_series_median(s : SortdistflashSeries) -> Double {
  let n = sort_dist_flash_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = sort_dist_flash_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn sort_dist_flash_series_scale(s : SortdistflashSeries, f : Double) -> SortdistflashSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = sort_dist_flash_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn sort_dist_flash_series_add(a : SortdistflashSeries, b : SortdistflashSeries) -> SortdistflashSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = sort_dist_flash_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn sort_dist_flash_series_sub(a : SortdistflashSeries, b : SortdistflashSeries) -> SortdistflashSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = sort_dist_flash_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn sort_dist_flash_series_normalize(s : SortdistflashSeries) -> SortdistflashSeries {
  let mn = sort_dist_flash_series_min(s)
  let mx = sort_dist_flash_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = sort_dist_flash_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn sort_dist_flash_series_cumsum(s : SortdistflashSeries) -> SortdistflashSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = sort_dist_flash_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn sort_dist_flash_series_to_string(s : SortdistflashSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + sort_dist_flash_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SortdistflashMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn sort_dist_flash_make_matrix(rows : Int, cols : Int, val : Double) -> SortdistflashMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn sort_dist_flash_matrix_identity(n : Int) -> SortdistflashMatrix {
  let m = sort_dist_flash_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn sort_dist_flash_matrix_get(m : SortdistflashMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn sort_dist_flash_matrix_transpose(m : SortdistflashMatrix) -> SortdistflashMatrix {
  let result = sort_dist_flash_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn sort_dist_flash_matrix_add(a : SortdistflashMatrix, b : SortdistflashMatrix) -> SortdistflashMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = sort_dist_flash_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn sort_dist_flash_matrix_scale(m : SortdistflashMatrix, s : Double) -> SortdistflashMatrix {
  let result = sort_dist_flash_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn sort_dist_flash_matrix_multiply(a : SortdistflashMatrix, b : SortdistflashMatrix) -> SortdistflashMatrix {
  if a.cols != b.rows { return sort_dist_flash_make_matrix(a.rows, b.cols, 0.0) }
  let result = sort_dist_flash_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn sort_dist_flash_matrix_trace(m : SortdistflashMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn sort_dist_flash_matrix_det(m : SortdistflashMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn sort_dist_flash_matrix_norm(m : SortdistflashMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  sort_dist_flash_sqrt(sum)
}

pub fn sort_dist_flash_matrix_to_string(m : SortdistflashMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + sort_dist_flash_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct SortdistflashVector {
  comps : Array[Double]
  dim : Int
}

pub fn sort_dist_flash_make_vector(comps : Array[Double]) -> SortdistflashVector {
  { comps, dim: comps.length() }
}

pub fn sort_dist_flash_vector_zero(dim : Int) -> SortdistflashVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn sort_dist_flash_vector_add(a : SortdistflashVector, b : SortdistflashVector) -> SortdistflashVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = sort_dist_flash_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn sort_dist_flash_vector_sub(a : SortdistflashVector, b : SortdistflashVector) -> SortdistflashVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = sort_dist_flash_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn sort_dist_flash_vector_scale(v : SortdistflashVector, s : Double) -> SortdistflashVector {
  let mut result = []
  for i in 0..<v.dim { result = sort_dist_flash_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn sort_dist_flash_vector_dot(a : SortdistflashVector, b : SortdistflashVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn sort_dist_flash_vector_norm(v : SortdistflashVector) -> Double { sort_dist_flash_sqrt(sort_dist_flash_vector_dot(v, v)) }

pub fn sort_dist_flash_vector_normalize(v : SortdistflashVector) -> SortdistflashVector {
  let n = sort_dist_flash_vector_norm(v)
  if n < 0.0000001 { v } else { sort_dist_flash_vector_scale(v, 1.0 / n) }
}

pub fn sort_dist_flash_vector_dist(a : SortdistflashVector, b : SortdistflashVector) -> Double {
  sort_dist_flash_vector_norm(sort_dist_flash_vector_sub(a, b))
}

pub fn sort_dist_flash_vector_to_string(v : SortdistflashVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + sort_dist_flash_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn sort_dist_flash_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn sort_dist_flash_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = sort_dist_flash_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn sort_dist_flash_std(data : Array[Double]) -> Double { sort_dist_flash_sqrt(sort_dist_flash_var(data)) }

pub fn sort_dist_flash_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = sort_dist_flash_mean(a); let mb = sort_dist_flash_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn sort_dist_flash_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = sort_dist_flash_std(a); let sb = sort_dist_flash_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { sort_dist_flash_cov(a, b) / (sa * sb) }
}

pub fn sort_dist_flash_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = sort_dist_flash_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn sort_dist_flash_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn sort_dist_flash_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn sort_dist_flash_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  sort_dist_flash_sqrt(sort_dist_flash_mse(pred, labels))
}

pub fn sort_dist_flash_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + sort_dist_flash_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn sort_dist_flash_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = sort_dist_flash_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn sort_dist_flash_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn sort_dist_flash_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn sort_dist_flash_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = sort_dist_flash_precision(pred, labels, pos); let r = sort_dist_flash_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn sort_dist_flash_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn sort_dist_flash_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = sort_dist_flash_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn sort_dist_flash_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn sort_dist_flash_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn sort_dist_flash_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = sort_dist_flash_gcd(a, b)
    (a / g) * b
  }
}

pub fn sort_dist_flash_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn sort_dist_flash_fibonacci(n : Int) -> Int {
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

pub fn sort_dist_flash_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = sort_dist_flash_min(data); let mx = sort_dist_flash_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn sort_dist_flash_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = sort_dist_flash_mean(data); let sd = sort_dist_flash_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn sort_dist_flash_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn sort_dist_flash_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn sort_dist_flash_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn sort_dist_flash_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn sort_dist_flash_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn sort_dist_flash_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn sort_dist_flash_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn sort_dist_flash_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn sort_dist_flash_dbl(x : Double) -> String {
  let i = if x >= 0.0 { sort_dist_flash_int(x) } else { -sort_dist_flash_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { sort_dist_flash_int(f * 1000000.0) } else { sort_dist_flash_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn sort_dist_flash_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn sort_dist_flash_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct SortdistflashFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_flash_frame_make(size : Int) -> SortdistflashFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_flash_frame_len(s : SortdistflashFrame) -> Int { s.size }

pub fn sort_dist_flash_frame_get(s : SortdistflashFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_flash_frame_set(s : SortdistflashFrame, i : Int, v : Double) -> SortdistflashFrame {
  let result = sort_dist_flash_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_dist_flash_frame_sum(s : SortdistflashFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_dist_flash_frame_mean(s : SortdistflashFrame) -> Double {
  if s.size == 0 { 0.0 } else { sort_dist_flash_frame_sum(s) / s.size.to_double() }
}

pub fn sort_dist_flash_frame_scale(s : SortdistflashFrame, f : Double) -> SortdistflashFrame {
  let result = sort_dist_flash_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_dist_flash_frame_add(a : SortdistflashFrame, b : SortdistflashFrame) -> SortdistflashFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_dist_flash_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_dist_flash_frame_copy(s : SortdistflashFrame) -> SortdistflashFrame {
  let result = sort_dist_flash_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_dist_flash_frame_fill(s : SortdistflashFrame, v : Double) -> SortdistflashFrame {
  let result = sort_dist_flash_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_dist_flash_frame_min(s : SortdistflashFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_flash_frame_max(s : SortdistflashFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_flash_frame_to_string(s : SortdistflashFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistflashTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_flash_table_make(size : Int) -> SortdistflashTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_flash_table_len(s : SortdistflashTable) -> Int { s.size }

pub fn sort_dist_flash_table_get(s : SortdistflashTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_flash_table_set(s : SortdistflashTable, i : Int, v : Double) -> SortdistflashTable {
  let result = sort_dist_flash_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_dist_flash_table_sum(s : SortdistflashTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_dist_flash_table_mean(s : SortdistflashTable) -> Double {
  if s.size == 0 { 0.0 } else { sort_dist_flash_table_sum(s) / s.size.to_double() }
}

pub fn sort_dist_flash_table_scale(s : SortdistflashTable, f : Double) -> SortdistflashTable {
  let result = sort_dist_flash_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_dist_flash_table_add(a : SortdistflashTable, b : SortdistflashTable) -> SortdistflashTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_dist_flash_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_dist_flash_table_copy(s : SortdistflashTable) -> SortdistflashTable {
  let result = sort_dist_flash_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_dist_flash_table_fill(s : SortdistflashTable, v : Double) -> SortdistflashTable {
  let result = sort_dist_flash_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_dist_flash_table_min(s : SortdistflashTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_flash_table_max(s : SortdistflashTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_flash_table_to_string(s : SortdistflashTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistflashGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_flash_graphn_make(size : Int) -> SortdistflashGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_flash_graphn_len(s : SortdistflashGraphN) -> Int { s.size }

pub fn sort_dist_flash_graphn_get(s : SortdistflashGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_flash_graphn_set(s : SortdistflashGraphN, i : Int, v : Double) -> SortdistflashGraphN {
  let result = sort_dist_flash_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_dist_flash_graphn_sum(s : SortdistflashGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_dist_flash_graphn_mean(s : SortdistflashGraphN) -> Double {
  if s.size == 0 { 0.0 } else { sort_dist_flash_graphn_sum(s) / s.size.to_double() }
}

pub fn sort_dist_flash_graphn_scale(s : SortdistflashGraphN, f : Double) -> SortdistflashGraphN {
  let result = sort_dist_flash_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_dist_flash_graphn_add(a : SortdistflashGraphN, b : SortdistflashGraphN) -> SortdistflashGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_dist_flash_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_dist_flash_graphn_copy(s : SortdistflashGraphN) -> SortdistflashGraphN {
  let result = sort_dist_flash_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_dist_flash_graphn_fill(s : SortdistflashGraphN, v : Double) -> SortdistflashGraphN {
  let result = sort_dist_flash_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_dist_flash_graphn_min(s : SortdistflashGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_flash_graphn_max(s : SortdistflashGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_flash_graphn_to_string(s : SortdistflashGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistflashNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_flash_node_make(size : Int) -> SortdistflashNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_flash_node_len(s : SortdistflashNode) -> Int { s.size }

pub fn sort_dist_flash_node_get(s : SortdistflashNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_flash_node_set(s : SortdistflashNode, i : Int, v : Double) -> SortdistflashNode {
  let result = sort_dist_flash_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_dist_flash_node_sum(s : SortdistflashNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_dist_flash_node_mean(s : SortdistflashNode) -> Double {
  if s.size == 0 { 0.0 } else { sort_dist_flash_node_sum(s) / s.size.to_double() }
}

pub fn sort_dist_flash_node_scale(s : SortdistflashNode, f : Double) -> SortdistflashNode {
  let result = sort_dist_flash_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_dist_flash_node_add(a : SortdistflashNode, b : SortdistflashNode) -> SortdistflashNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_dist_flash_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_dist_flash_node_copy(s : SortdistflashNode) -> SortdistflashNode {
  let result = sort_dist_flash_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_dist_flash_node_fill(s : SortdistflashNode, v : Double) -> SortdistflashNode {
  let result = sort_dist_flash_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_dist_flash_node_min(s : SortdistflashNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_flash_node_max(s : SortdistflashNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_flash_node_to_string(s : SortdistflashNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistflashEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_flash_edge_make(size : Int) -> SortdistflashEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_flash_edge_len(s : SortdistflashEdge) -> Int { s.size }

pub fn sort_dist_flash_edge_get(s : SortdistflashEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_flash_edge_set(s : SortdistflashEdge, i : Int, v : Double) -> SortdistflashEdge {
  let result = sort_dist_flash_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_dist_flash_edge_sum(s : SortdistflashEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_dist_flash_edge_mean(s : SortdistflashEdge) -> Double {
  if s.size == 0 { 0.0 } else { sort_dist_flash_edge_sum(s) / s.size.to_double() }
}

pub fn sort_dist_flash_edge_scale(s : SortdistflashEdge, f : Double) -> SortdistflashEdge {
  let result = sort_dist_flash_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_dist_flash_edge_add(a : SortdistflashEdge, b : SortdistflashEdge) -> SortdistflashEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_dist_flash_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_dist_flash_edge_copy(s : SortdistflashEdge) -> SortdistflashEdge {
  let result = sort_dist_flash_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_dist_flash_edge_fill(s : SortdistflashEdge, v : Double) -> SortdistflashEdge {
  let result = sort_dist_flash_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_dist_flash_edge_min(s : SortdistflashEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_flash_edge_max(s : SortdistflashEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_flash_edge_to_string(s : SortdistflashEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistflashPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_flash_path_make(size : Int) -> SortdistflashPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_flash_path_len(s : SortdistflashPath) -> Int { s.size }

pub fn sort_dist_flash_path_get(s : SortdistflashPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_flash_path_set(s : SortdistflashPath, i : Int, v : Double) -> SortdistflashPath {
  let result = sort_dist_flash_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_dist_flash_path_sum(s : SortdistflashPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_dist_flash_path_mean(s : SortdistflashPath) -> Double {
  if s.size == 0 { 0.0 } else { sort_dist_flash_path_sum(s) / s.size.to_double() }
}

pub fn sort_dist_flash_path_scale(s : SortdistflashPath, f : Double) -> SortdistflashPath {
  let result = sort_dist_flash_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_dist_flash_path_add(a : SortdistflashPath, b : SortdistflashPath) -> SortdistflashPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_dist_flash_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_dist_flash_path_copy(s : SortdistflashPath) -> SortdistflashPath {
  let result = sort_dist_flash_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_dist_flash_path_fill(s : SortdistflashPath, v : Double) -> SortdistflashPath {
  let result = sort_dist_flash_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_dist_flash_path_min(s : SortdistflashPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_flash_path_max(s : SortdistflashPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_flash_path_to_string(s : SortdistflashPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistflashCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_flash_cluster_make(size : Int) -> SortdistflashCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_flash_cluster_len(s : SortdistflashCluster) -> Int { s.size }

pub fn sort_dist_flash_cluster_get(s : SortdistflashCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_flash_cluster_set(s : SortdistflashCluster, i : Int, v : Double) -> SortdistflashCluster {
  let result = sort_dist_flash_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_dist_flash_cluster_sum(s : SortdistflashCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_dist_flash_cluster_mean(s : SortdistflashCluster) -> Double {
  if s.size == 0 { 0.0 } else { sort_dist_flash_cluster_sum(s) / s.size.to_double() }
}

pub fn sort_dist_flash_cluster_scale(s : SortdistflashCluster, f : Double) -> SortdistflashCluster {
  let result = sort_dist_flash_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_dist_flash_cluster_add(a : SortdistflashCluster, b : SortdistflashCluster) -> SortdistflashCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_dist_flash_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_dist_flash_cluster_copy(s : SortdistflashCluster) -> SortdistflashCluster {
  let result = sort_dist_flash_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_dist_flash_cluster_fill(s : SortdistflashCluster, v : Double) -> SortdistflashCluster {
  let result = sort_dist_flash_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_dist_flash_cluster_min(s : SortdistflashCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_flash_cluster_max(s : SortdistflashCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_flash_cluster_to_string(s : SortdistflashCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistflashModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_flash_model_make(size : Int) -> SortdistflashModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_flash_model_len(s : SortdistflashModel) -> Int { s.size }

pub fn sort_dist_flash_model_get(s : SortdistflashModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_flash_model_set(s : SortdistflashModel, i : Int, v : Double) -> SortdistflashModel {
  let result = sort_dist_flash_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_dist_flash_model_sum(s : SortdistflashModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_dist_flash_model_mean(s : SortdistflashModel) -> Double {
  if s.size == 0 { 0.0 } else { sort_dist_flash_model_sum(s) / s.size.to_double() }
}

pub fn sort_dist_flash_model_scale(s : SortdistflashModel, f : Double) -> SortdistflashModel {
  let result = sort_dist_flash_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_dist_flash_model_add(a : SortdistflashModel, b : SortdistflashModel) -> SortdistflashModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_dist_flash_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_dist_flash_model_copy(s : SortdistflashModel) -> SortdistflashModel {
  let result = sort_dist_flash_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_dist_flash_model_fill(s : SortdistflashModel, v : Double) -> SortdistflashModel {
  let result = sort_dist_flash_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_dist_flash_model_min(s : SortdistflashModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_flash_model_max(s : SortdistflashModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_flash_model_to_string(s : SortdistflashModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistflashLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_flash_layer_make(size : Int) -> SortdistflashLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_flash_layer_len(s : SortdistflashLayer) -> Int { s.size }

pub fn sort_dist_flash_layer_get(s : SortdistflashLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_flash_layer_set(s : SortdistflashLayer, i : Int, v : Double) -> SortdistflashLayer {
  let result = sort_dist_flash_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_dist_flash_layer_sum(s : SortdistflashLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_dist_flash_layer_mean(s : SortdistflashLayer) -> Double {
  if s.size == 0 { 0.0 } else { sort_dist_flash_layer_sum(s) / s.size.to_double() }
}

pub fn sort_dist_flash_layer_scale(s : SortdistflashLayer, f : Double) -> SortdistflashLayer {
  let result = sort_dist_flash_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_dist_flash_layer_add(a : SortdistflashLayer, b : SortdistflashLayer) -> SortdistflashLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_dist_flash_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_dist_flash_layer_copy(s : SortdistflashLayer) -> SortdistflashLayer {
  let result = sort_dist_flash_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_dist_flash_layer_fill(s : SortdistflashLayer, v : Double) -> SortdistflashLayer {
  let result = sort_dist_flash_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_dist_flash_layer_min(s : SortdistflashLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_flash_layer_max(s : SortdistflashLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_flash_layer_to_string(s : SortdistflashLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistflashBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_flash_buffer_make(size : Int) -> SortdistflashBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_flash_buffer_len(s : SortdistflashBuffer) -> Int { s.size }

pub fn sort_dist_flash_buffer_get(s : SortdistflashBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_flash_buffer_set(s : SortdistflashBuffer, i : Int, v : Double) -> SortdistflashBuffer {
  let result = sort_dist_flash_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_dist_flash_buffer_sum(s : SortdistflashBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_dist_flash_buffer_mean(s : SortdistflashBuffer) -> Double {
  if s.size == 0 { 0.0 } else { sort_dist_flash_buffer_sum(s) / s.size.to_double() }
}

pub fn sort_dist_flash_buffer_scale(s : SortdistflashBuffer, f : Double) -> SortdistflashBuffer {
  let result = sort_dist_flash_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_dist_flash_buffer_add(a : SortdistflashBuffer, b : SortdistflashBuffer) -> SortdistflashBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_dist_flash_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_dist_flash_buffer_copy(s : SortdistflashBuffer) -> SortdistflashBuffer {
  let result = sort_dist_flash_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_dist_flash_buffer_fill(s : SortdistflashBuffer, v : Double) -> SortdistflashBuffer {
  let result = sort_dist_flash_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_dist_flash_buffer_min(s : SortdistflashBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_flash_buffer_max(s : SortdistflashBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_flash_buffer_to_string(s : SortdistflashBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistflashCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_flash_cursor_make(size : Int) -> SortdistflashCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_flash_cursor_len(s : SortdistflashCursor) -> Int { s.size }

pub fn sort_dist_flash_cursor_get(s : SortdistflashCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_flash_cursor_set(s : SortdistflashCursor, i : Int, v : Double) -> SortdistflashCursor {
  let result = sort_dist_flash_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_dist_flash_cursor_sum(s : SortdistflashCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_dist_flash_cursor_mean(s : SortdistflashCursor) -> Double {
  if s.size == 0 { 0.0 } else { sort_dist_flash_cursor_sum(s) / s.size.to_double() }
}

pub fn sort_dist_flash_cursor_scale(s : SortdistflashCursor, f : Double) -> SortdistflashCursor {
  let result = sort_dist_flash_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_dist_flash_cursor_add(a : SortdistflashCursor, b : SortdistflashCursor) -> SortdistflashCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_dist_flash_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_dist_flash_cursor_copy(s : SortdistflashCursor) -> SortdistflashCursor {
  let result = sort_dist_flash_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_dist_flash_cursor_fill(s : SortdistflashCursor, v : Double) -> SortdistflashCursor {
  let result = sort_dist_flash_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_dist_flash_cursor_min(s : SortdistflashCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_flash_cursor_max(s : SortdistflashCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_flash_cursor_to_string(s : SortdistflashCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistflashView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_flash_view_make(size : Int) -> SortdistflashView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_flash_view_len(s : SortdistflashView) -> Int { s.size }

pub fn sort_dist_flash_view_get(s : SortdistflashView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_flash_view_set(s : SortdistflashView, i : Int, v : Double) -> SortdistflashView {
  let result = sort_dist_flash_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_dist_flash_view_sum(s : SortdistflashView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_dist_flash_view_mean(s : SortdistflashView) -> Double {
  if s.size == 0 { 0.0 } else { sort_dist_flash_view_sum(s) / s.size.to_double() }
}

pub fn sort_dist_flash_view_scale(s : SortdistflashView, f : Double) -> SortdistflashView {
  let result = sort_dist_flash_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_dist_flash_view_add(a : SortdistflashView, b : SortdistflashView) -> SortdistflashView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_dist_flash_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_dist_flash_view_copy(s : SortdistflashView) -> SortdistflashView {
  let result = sort_dist_flash_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_dist_flash_view_fill(s : SortdistflashView, v : Double) -> SortdistflashView {
  let result = sort_dist_flash_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_dist_flash_view_min(s : SortdistflashView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_flash_view_max(s : SortdistflashView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_flash_view_to_string(s : SortdistflashView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistflashRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_flash_range_make(size : Int) -> SortdistflashRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_flash_range_len(s : SortdistflashRange) -> Int { s.size }

pub fn sort_dist_flash_range_get(s : SortdistflashRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_flash_range_set(s : SortdistflashRange, i : Int, v : Double) -> SortdistflashRange {
  let result = sort_dist_flash_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_dist_flash_range_sum(s : SortdistflashRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_dist_flash_range_mean(s : SortdistflashRange) -> Double {
  if s.size == 0 { 0.0 } else { sort_dist_flash_range_sum(s) / s.size.to_double() }
}

pub fn sort_dist_flash_range_scale(s : SortdistflashRange, f : Double) -> SortdistflashRange {
  let result = sort_dist_flash_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_dist_flash_range_add(a : SortdistflashRange, b : SortdistflashRange) -> SortdistflashRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_dist_flash_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_dist_flash_range_copy(s : SortdistflashRange) -> SortdistflashRange {
  let result = sort_dist_flash_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_dist_flash_range_fill(s : SortdistflashRange, v : Double) -> SortdistflashRange {
  let result = sort_dist_flash_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_dist_flash_range_min(s : SortdistflashRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_flash_range_max(s : SortdistflashRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_flash_range_to_string(s : SortdistflashRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistflashSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_flash_slice_make(size : Int) -> SortdistflashSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_flash_slice_len(s : SortdistflashSlice) -> Int { s.size }

pub fn sort_dist_flash_slice_get(s : SortdistflashSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_flash_slice_set(s : SortdistflashSlice, i : Int, v : Double) -> SortdistflashSlice {
  let result = sort_dist_flash_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_dist_flash_slice_sum(s : SortdistflashSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_dist_flash_slice_mean(s : SortdistflashSlice) -> Double {
  if s.size == 0 { 0.0 } else { sort_dist_flash_slice_sum(s) / s.size.to_double() }
}

pub fn sort_dist_flash_slice_scale(s : SortdistflashSlice, f : Double) -> SortdistflashSlice {
  let result = sort_dist_flash_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_dist_flash_slice_add(a : SortdistflashSlice, b : SortdistflashSlice) -> SortdistflashSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_dist_flash_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_dist_flash_slice_copy(s : SortdistflashSlice) -> SortdistflashSlice {
  let result = sort_dist_flash_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_dist_flash_slice_fill(s : SortdistflashSlice, v : Double) -> SortdistflashSlice {
  let result = sort_dist_flash_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_dist_flash_slice_min(s : SortdistflashSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_flash_slice_max(s : SortdistflashSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_flash_slice_to_string(s : SortdistflashSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn sort_dist_flash_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_dist_flash_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_dist_flash_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_dist_flash_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_dist_flash_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_dist_flash_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_dist_flash_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_dist_flash_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_dist_flash_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_dist_flash_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_dist_flash_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_dist_flash_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_dist_flash_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_dist_flash_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_dist_flash_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_dist_flash_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_dist_flash_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_dist_flash_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_dist_flash_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_dist_flash_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_dist_flash_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_dist_flash_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_dist_flash_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_dist_flash_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_dist_flash_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}


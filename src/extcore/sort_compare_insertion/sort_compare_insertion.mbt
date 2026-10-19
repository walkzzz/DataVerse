///===
/// extcore/sort_compare_insertion

pub(all) struct SortcompareinsertionPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn sort_compare_insertion_make_point(x : Double, y : Double) -> SortcompareinsertionPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn sort_compare_insertion_make_point3(x : Double, y : Double, z : Double) -> SortcompareinsertionPoint {
  { x, y, z, label: 0 }
}

pub fn sort_compare_insertion_point_x(pt : SortcompareinsertionPoint) -> Double { pt.x }

pub fn sort_compare_insertion_point_y(pt : SortcompareinsertionPoint) -> Double { pt.y }

pub fn sort_compare_insertion_point_z(pt : SortcompareinsertionPoint) -> Double { pt.z }

pub fn sort_compare_insertion_point_label(pt : SortcompareinsertionPoint) -> Int { pt.label }

pub fn sort_compare_insertion_point_dist(a : SortcompareinsertionPoint, b : SortcompareinsertionPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  sort_compare_insertion_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn sort_compare_insertion_point_add(a : SortcompareinsertionPoint, b : SortcompareinsertionPoint) -> SortcompareinsertionPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn sort_compare_insertion_point_sub(a : SortcompareinsertionPoint, b : SortcompareinsertionPoint) -> SortcompareinsertionPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn sort_compare_insertion_point_scale(pt : SortcompareinsertionPoint, s : Double) -> SortcompareinsertionPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn sort_compare_insertion_point_dot(a : SortcompareinsertionPoint, b : SortcompareinsertionPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn sort_compare_insertion_point_cross(a : SortcompareinsertionPoint, b : SortcompareinsertionPoint) -> SortcompareinsertionPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn sort_compare_insertion_point_norm(pt : SortcompareinsertionPoint) -> Double {
  sort_compare_insertion_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn sort_compare_insertion_point_normalize(pt : SortcompareinsertionPoint) -> SortcompareinsertionPoint {
  let n = sort_compare_insertion_point_norm(pt)
  if n < 0.0000001 { pt } else { sort_compare_insertion_point_scale(pt, 1.0 / n) }
}

pub fn sort_compare_insertion_point_negate(pt : SortcompareinsertionPoint) -> SortcompareinsertionPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn sort_compare_insertion_point_mid(a : SortcompareinsertionPoint, b : SortcompareinsertionPoint) -> SortcompareinsertionPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn sort_compare_insertion_point_lerp(a : SortcompareinsertionPoint, b : SortcompareinsertionPoint, t : Double) -> SortcompareinsertionPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn sort_compare_insertion_point_to_string(pt : SortcompareinsertionPoint) -> String {
  "(" + sort_compare_insertion_dbl(pt.x) + ", " + sort_compare_insertion_dbl(pt.y) + ", " + sort_compare_insertion_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct SortcompareinsertionSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn sort_compare_insertion_make_series(vals : Array[Double], name : String) -> SortcompareinsertionSeries {
  { vals, name, meta: 0 }
}

pub fn sort_compare_insertion_series_len(s : SortcompareinsertionSeries) -> Int { s.vals.length() }

pub fn sort_compare_insertion_series_sum(s : SortcompareinsertionSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn sort_compare_insertion_series_mean(s : SortcompareinsertionSeries) -> Double {
  let n = sort_compare_insertion_series_len(s)
  if n == 0 { 0.0 } else { sort_compare_insertion_series_sum(s) / n.to_double() }
}

pub fn sort_compare_insertion_series_min(s : SortcompareinsertionSeries) -> Double {
  let n = sort_compare_insertion_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn sort_compare_insertion_series_max(s : SortcompareinsertionSeries) -> Double {
  let n = sort_compare_insertion_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn sort_compare_insertion_series_range(s : SortcompareinsertionSeries) -> Double {
  sort_compare_insertion_series_max(s) - sort_compare_insertion_series_min(s)
}

pub fn sort_compare_insertion_series_var(s : SortcompareinsertionSeries) -> Double {
  let n = sort_compare_insertion_series_len(s)
  if n == 0 { 0.0 } else {
    let m = sort_compare_insertion_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn sort_compare_insertion_series_std(s : SortcompareinsertionSeries) -> Double { sort_compare_insertion_sqrt(sort_compare_insertion_series_var(s)) }

pub fn sort_compare_insertion_series_median(s : SortcompareinsertionSeries) -> Double {
  let n = sort_compare_insertion_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = sort_compare_insertion_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn sort_compare_insertion_series_scale(s : SortcompareinsertionSeries, f : Double) -> SortcompareinsertionSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = sort_compare_insertion_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn sort_compare_insertion_series_add(a : SortcompareinsertionSeries, b : SortcompareinsertionSeries) -> SortcompareinsertionSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = sort_compare_insertion_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn sort_compare_insertion_series_sub(a : SortcompareinsertionSeries, b : SortcompareinsertionSeries) -> SortcompareinsertionSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = sort_compare_insertion_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn sort_compare_insertion_series_normalize(s : SortcompareinsertionSeries) -> SortcompareinsertionSeries {
  let mn = sort_compare_insertion_series_min(s)
  let mx = sort_compare_insertion_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = sort_compare_insertion_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn sort_compare_insertion_series_cumsum(s : SortcompareinsertionSeries) -> SortcompareinsertionSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = sort_compare_insertion_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn sort_compare_insertion_series_to_string(s : SortcompareinsertionSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + sort_compare_insertion_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SortcompareinsertionMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn sort_compare_insertion_make_matrix(rows : Int, cols : Int, val : Double) -> SortcompareinsertionMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn sort_compare_insertion_matrix_identity(n : Int) -> SortcompareinsertionMatrix {
  let m = sort_compare_insertion_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn sort_compare_insertion_matrix_get(m : SortcompareinsertionMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn sort_compare_insertion_matrix_transpose(m : SortcompareinsertionMatrix) -> SortcompareinsertionMatrix {
  let result = sort_compare_insertion_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn sort_compare_insertion_matrix_add(a : SortcompareinsertionMatrix, b : SortcompareinsertionMatrix) -> SortcompareinsertionMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = sort_compare_insertion_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn sort_compare_insertion_matrix_scale(m : SortcompareinsertionMatrix, s : Double) -> SortcompareinsertionMatrix {
  let result = sort_compare_insertion_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn sort_compare_insertion_matrix_multiply(a : SortcompareinsertionMatrix, b : SortcompareinsertionMatrix) -> SortcompareinsertionMatrix {
  if a.cols != b.rows { return sort_compare_insertion_make_matrix(a.rows, b.cols, 0.0) }
  let result = sort_compare_insertion_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn sort_compare_insertion_matrix_trace(m : SortcompareinsertionMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn sort_compare_insertion_matrix_det(m : SortcompareinsertionMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn sort_compare_insertion_matrix_norm(m : SortcompareinsertionMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  sort_compare_insertion_sqrt(sum)
}

pub fn sort_compare_insertion_matrix_to_string(m : SortcompareinsertionMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + sort_compare_insertion_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct SortcompareinsertionVector {
  comps : Array[Double]
  dim : Int
}

pub fn sort_compare_insertion_make_vector(comps : Array[Double]) -> SortcompareinsertionVector {
  { comps, dim: comps.length() }
}

pub fn sort_compare_insertion_vector_zero(dim : Int) -> SortcompareinsertionVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn sort_compare_insertion_vector_add(a : SortcompareinsertionVector, b : SortcompareinsertionVector) -> SortcompareinsertionVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = sort_compare_insertion_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn sort_compare_insertion_vector_sub(a : SortcompareinsertionVector, b : SortcompareinsertionVector) -> SortcompareinsertionVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = sort_compare_insertion_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn sort_compare_insertion_vector_scale(v : SortcompareinsertionVector, s : Double) -> SortcompareinsertionVector {
  let mut result = []
  for i in 0..<v.dim { result = sort_compare_insertion_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn sort_compare_insertion_vector_dot(a : SortcompareinsertionVector, b : SortcompareinsertionVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn sort_compare_insertion_vector_norm(v : SortcompareinsertionVector) -> Double { sort_compare_insertion_sqrt(sort_compare_insertion_vector_dot(v, v)) }

pub fn sort_compare_insertion_vector_normalize(v : SortcompareinsertionVector) -> SortcompareinsertionVector {
  let n = sort_compare_insertion_vector_norm(v)
  if n < 0.0000001 { v } else { sort_compare_insertion_vector_scale(v, 1.0 / n) }
}

pub fn sort_compare_insertion_vector_dist(a : SortcompareinsertionVector, b : SortcompareinsertionVector) -> Double {
  sort_compare_insertion_vector_norm(sort_compare_insertion_vector_sub(a, b))
}

pub fn sort_compare_insertion_vector_to_string(v : SortcompareinsertionVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + sort_compare_insertion_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn sort_compare_insertion_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn sort_compare_insertion_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = sort_compare_insertion_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn sort_compare_insertion_std(data : Array[Double]) -> Double { sort_compare_insertion_sqrt(sort_compare_insertion_var(data)) }

pub fn sort_compare_insertion_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = sort_compare_insertion_mean(a); let mb = sort_compare_insertion_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn sort_compare_insertion_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = sort_compare_insertion_std(a); let sb = sort_compare_insertion_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { sort_compare_insertion_cov(a, b) / (sa * sb) }
}

pub fn sort_compare_insertion_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = sort_compare_insertion_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn sort_compare_insertion_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn sort_compare_insertion_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn sort_compare_insertion_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  sort_compare_insertion_sqrt(sort_compare_insertion_mse(pred, labels))
}

pub fn sort_compare_insertion_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + sort_compare_insertion_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn sort_compare_insertion_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = sort_compare_insertion_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn sort_compare_insertion_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn sort_compare_insertion_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn sort_compare_insertion_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = sort_compare_insertion_precision(pred, labels, pos); let r = sort_compare_insertion_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn sort_compare_insertion_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn sort_compare_insertion_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = sort_compare_insertion_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn sort_compare_insertion_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn sort_compare_insertion_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn sort_compare_insertion_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = sort_compare_insertion_gcd(a, b)
    (a / g) * b
  }
}

pub fn sort_compare_insertion_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn sort_compare_insertion_fibonacci(n : Int) -> Int {
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

pub fn sort_compare_insertion_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = sort_compare_insertion_min(data); let mx = sort_compare_insertion_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn sort_compare_insertion_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = sort_compare_insertion_mean(data); let sd = sort_compare_insertion_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn sort_compare_insertion_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn sort_compare_insertion_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn sort_compare_insertion_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn sort_compare_insertion_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn sort_compare_insertion_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn sort_compare_insertion_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn sort_compare_insertion_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn sort_compare_insertion_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn sort_compare_insertion_dbl(x : Double) -> String {
  let i = if x >= 0.0 { sort_compare_insertion_int(x) } else { -sort_compare_insertion_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { sort_compare_insertion_int(f * 1000000.0) } else { sort_compare_insertion_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn sort_compare_insertion_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn sort_compare_insertion_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct SortcompareinsertionFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_insertion_frame_make(size : Int) -> SortcompareinsertionFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_insertion_frame_len(s : SortcompareinsertionFrame) -> Int { s.size }

pub fn sort_compare_insertion_frame_get(s : SortcompareinsertionFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_insertion_frame_set(s : SortcompareinsertionFrame, i : Int, v : Double) -> SortcompareinsertionFrame {
  let result = sort_compare_insertion_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_insertion_frame_sum(s : SortcompareinsertionFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_insertion_frame_mean(s : SortcompareinsertionFrame) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_insertion_frame_sum(s) / s.size.to_double() }
}

pub fn sort_compare_insertion_frame_scale(s : SortcompareinsertionFrame, f : Double) -> SortcompareinsertionFrame {
  let result = sort_compare_insertion_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_insertion_frame_add(a : SortcompareinsertionFrame, b : SortcompareinsertionFrame) -> SortcompareinsertionFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_insertion_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_insertion_frame_copy(s : SortcompareinsertionFrame) -> SortcompareinsertionFrame {
  let result = sort_compare_insertion_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_insertion_frame_fill(s : SortcompareinsertionFrame, v : Double) -> SortcompareinsertionFrame {
  let result = sort_compare_insertion_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_insertion_frame_min(s : SortcompareinsertionFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_insertion_frame_max(s : SortcompareinsertionFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_insertion_frame_to_string(s : SortcompareinsertionFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareinsertionTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_insertion_table_make(size : Int) -> SortcompareinsertionTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_insertion_table_len(s : SortcompareinsertionTable) -> Int { s.size }

pub fn sort_compare_insertion_table_get(s : SortcompareinsertionTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_insertion_table_set(s : SortcompareinsertionTable, i : Int, v : Double) -> SortcompareinsertionTable {
  let result = sort_compare_insertion_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_insertion_table_sum(s : SortcompareinsertionTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_insertion_table_mean(s : SortcompareinsertionTable) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_insertion_table_sum(s) / s.size.to_double() }
}

pub fn sort_compare_insertion_table_scale(s : SortcompareinsertionTable, f : Double) -> SortcompareinsertionTable {
  let result = sort_compare_insertion_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_insertion_table_add(a : SortcompareinsertionTable, b : SortcompareinsertionTable) -> SortcompareinsertionTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_insertion_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_insertion_table_copy(s : SortcompareinsertionTable) -> SortcompareinsertionTable {
  let result = sort_compare_insertion_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_insertion_table_fill(s : SortcompareinsertionTable, v : Double) -> SortcompareinsertionTable {
  let result = sort_compare_insertion_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_insertion_table_min(s : SortcompareinsertionTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_insertion_table_max(s : SortcompareinsertionTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_insertion_table_to_string(s : SortcompareinsertionTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareinsertionGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_insertion_graphn_make(size : Int) -> SortcompareinsertionGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_insertion_graphn_len(s : SortcompareinsertionGraphN) -> Int { s.size }

pub fn sort_compare_insertion_graphn_get(s : SortcompareinsertionGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_insertion_graphn_set(s : SortcompareinsertionGraphN, i : Int, v : Double) -> SortcompareinsertionGraphN {
  let result = sort_compare_insertion_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_insertion_graphn_sum(s : SortcompareinsertionGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_insertion_graphn_mean(s : SortcompareinsertionGraphN) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_insertion_graphn_sum(s) / s.size.to_double() }
}

pub fn sort_compare_insertion_graphn_scale(s : SortcompareinsertionGraphN, f : Double) -> SortcompareinsertionGraphN {
  let result = sort_compare_insertion_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_insertion_graphn_add(a : SortcompareinsertionGraphN, b : SortcompareinsertionGraphN) -> SortcompareinsertionGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_insertion_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_insertion_graphn_copy(s : SortcompareinsertionGraphN) -> SortcompareinsertionGraphN {
  let result = sort_compare_insertion_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_insertion_graphn_fill(s : SortcompareinsertionGraphN, v : Double) -> SortcompareinsertionGraphN {
  let result = sort_compare_insertion_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_insertion_graphn_min(s : SortcompareinsertionGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_insertion_graphn_max(s : SortcompareinsertionGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_insertion_graphn_to_string(s : SortcompareinsertionGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareinsertionNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_insertion_node_make(size : Int) -> SortcompareinsertionNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_insertion_node_len(s : SortcompareinsertionNode) -> Int { s.size }

pub fn sort_compare_insertion_node_get(s : SortcompareinsertionNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_insertion_node_set(s : SortcompareinsertionNode, i : Int, v : Double) -> SortcompareinsertionNode {
  let result = sort_compare_insertion_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_insertion_node_sum(s : SortcompareinsertionNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_insertion_node_mean(s : SortcompareinsertionNode) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_insertion_node_sum(s) / s.size.to_double() }
}

pub fn sort_compare_insertion_node_scale(s : SortcompareinsertionNode, f : Double) -> SortcompareinsertionNode {
  let result = sort_compare_insertion_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_insertion_node_add(a : SortcompareinsertionNode, b : SortcompareinsertionNode) -> SortcompareinsertionNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_insertion_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_insertion_node_copy(s : SortcompareinsertionNode) -> SortcompareinsertionNode {
  let result = sort_compare_insertion_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_insertion_node_fill(s : SortcompareinsertionNode, v : Double) -> SortcompareinsertionNode {
  let result = sort_compare_insertion_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_insertion_node_min(s : SortcompareinsertionNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_insertion_node_max(s : SortcompareinsertionNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_insertion_node_to_string(s : SortcompareinsertionNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareinsertionEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_insertion_edge_make(size : Int) -> SortcompareinsertionEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_insertion_edge_len(s : SortcompareinsertionEdge) -> Int { s.size }

pub fn sort_compare_insertion_edge_get(s : SortcompareinsertionEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_insertion_edge_set(s : SortcompareinsertionEdge, i : Int, v : Double) -> SortcompareinsertionEdge {
  let result = sort_compare_insertion_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_insertion_edge_sum(s : SortcompareinsertionEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_insertion_edge_mean(s : SortcompareinsertionEdge) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_insertion_edge_sum(s) / s.size.to_double() }
}

pub fn sort_compare_insertion_edge_scale(s : SortcompareinsertionEdge, f : Double) -> SortcompareinsertionEdge {
  let result = sort_compare_insertion_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_insertion_edge_add(a : SortcompareinsertionEdge, b : SortcompareinsertionEdge) -> SortcompareinsertionEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_insertion_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_insertion_edge_copy(s : SortcompareinsertionEdge) -> SortcompareinsertionEdge {
  let result = sort_compare_insertion_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_insertion_edge_fill(s : SortcompareinsertionEdge, v : Double) -> SortcompareinsertionEdge {
  let result = sort_compare_insertion_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_insertion_edge_min(s : SortcompareinsertionEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_insertion_edge_max(s : SortcompareinsertionEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_insertion_edge_to_string(s : SortcompareinsertionEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareinsertionPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_insertion_path_make(size : Int) -> SortcompareinsertionPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_insertion_path_len(s : SortcompareinsertionPath) -> Int { s.size }

pub fn sort_compare_insertion_path_get(s : SortcompareinsertionPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_insertion_path_set(s : SortcompareinsertionPath, i : Int, v : Double) -> SortcompareinsertionPath {
  let result = sort_compare_insertion_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_insertion_path_sum(s : SortcompareinsertionPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_insertion_path_mean(s : SortcompareinsertionPath) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_insertion_path_sum(s) / s.size.to_double() }
}

pub fn sort_compare_insertion_path_scale(s : SortcompareinsertionPath, f : Double) -> SortcompareinsertionPath {
  let result = sort_compare_insertion_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_insertion_path_add(a : SortcompareinsertionPath, b : SortcompareinsertionPath) -> SortcompareinsertionPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_insertion_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_insertion_path_copy(s : SortcompareinsertionPath) -> SortcompareinsertionPath {
  let result = sort_compare_insertion_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_insertion_path_fill(s : SortcompareinsertionPath, v : Double) -> SortcompareinsertionPath {
  let result = sort_compare_insertion_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_insertion_path_min(s : SortcompareinsertionPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_insertion_path_max(s : SortcompareinsertionPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_insertion_path_to_string(s : SortcompareinsertionPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareinsertionCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_insertion_cluster_make(size : Int) -> SortcompareinsertionCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_insertion_cluster_len(s : SortcompareinsertionCluster) -> Int { s.size }

pub fn sort_compare_insertion_cluster_get(s : SortcompareinsertionCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_insertion_cluster_set(s : SortcompareinsertionCluster, i : Int, v : Double) -> SortcompareinsertionCluster {
  let result = sort_compare_insertion_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_insertion_cluster_sum(s : SortcompareinsertionCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_insertion_cluster_mean(s : SortcompareinsertionCluster) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_insertion_cluster_sum(s) / s.size.to_double() }
}

pub fn sort_compare_insertion_cluster_scale(s : SortcompareinsertionCluster, f : Double) -> SortcompareinsertionCluster {
  let result = sort_compare_insertion_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_insertion_cluster_add(a : SortcompareinsertionCluster, b : SortcompareinsertionCluster) -> SortcompareinsertionCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_insertion_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_insertion_cluster_copy(s : SortcompareinsertionCluster) -> SortcompareinsertionCluster {
  let result = sort_compare_insertion_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_insertion_cluster_fill(s : SortcompareinsertionCluster, v : Double) -> SortcompareinsertionCluster {
  let result = sort_compare_insertion_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_insertion_cluster_min(s : SortcompareinsertionCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_insertion_cluster_max(s : SortcompareinsertionCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_insertion_cluster_to_string(s : SortcompareinsertionCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareinsertionModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_insertion_model_make(size : Int) -> SortcompareinsertionModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_insertion_model_len(s : SortcompareinsertionModel) -> Int { s.size }

pub fn sort_compare_insertion_model_get(s : SortcompareinsertionModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_insertion_model_set(s : SortcompareinsertionModel, i : Int, v : Double) -> SortcompareinsertionModel {
  let result = sort_compare_insertion_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_insertion_model_sum(s : SortcompareinsertionModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_insertion_model_mean(s : SortcompareinsertionModel) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_insertion_model_sum(s) / s.size.to_double() }
}

pub fn sort_compare_insertion_model_scale(s : SortcompareinsertionModel, f : Double) -> SortcompareinsertionModel {
  let result = sort_compare_insertion_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_insertion_model_add(a : SortcompareinsertionModel, b : SortcompareinsertionModel) -> SortcompareinsertionModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_insertion_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_insertion_model_copy(s : SortcompareinsertionModel) -> SortcompareinsertionModel {
  let result = sort_compare_insertion_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_insertion_model_fill(s : SortcompareinsertionModel, v : Double) -> SortcompareinsertionModel {
  let result = sort_compare_insertion_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_insertion_model_min(s : SortcompareinsertionModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_insertion_model_max(s : SortcompareinsertionModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_insertion_model_to_string(s : SortcompareinsertionModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareinsertionLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_insertion_layer_make(size : Int) -> SortcompareinsertionLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_insertion_layer_len(s : SortcompareinsertionLayer) -> Int { s.size }

pub fn sort_compare_insertion_layer_get(s : SortcompareinsertionLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_insertion_layer_set(s : SortcompareinsertionLayer, i : Int, v : Double) -> SortcompareinsertionLayer {
  let result = sort_compare_insertion_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_insertion_layer_sum(s : SortcompareinsertionLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_insertion_layer_mean(s : SortcompareinsertionLayer) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_insertion_layer_sum(s) / s.size.to_double() }
}

pub fn sort_compare_insertion_layer_scale(s : SortcompareinsertionLayer, f : Double) -> SortcompareinsertionLayer {
  let result = sort_compare_insertion_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_insertion_layer_add(a : SortcompareinsertionLayer, b : SortcompareinsertionLayer) -> SortcompareinsertionLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_insertion_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_insertion_layer_copy(s : SortcompareinsertionLayer) -> SortcompareinsertionLayer {
  let result = sort_compare_insertion_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_insertion_layer_fill(s : SortcompareinsertionLayer, v : Double) -> SortcompareinsertionLayer {
  let result = sort_compare_insertion_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_insertion_layer_min(s : SortcompareinsertionLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_insertion_layer_max(s : SortcompareinsertionLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_insertion_layer_to_string(s : SortcompareinsertionLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareinsertionBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_insertion_buffer_make(size : Int) -> SortcompareinsertionBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_insertion_buffer_len(s : SortcompareinsertionBuffer) -> Int { s.size }

pub fn sort_compare_insertion_buffer_get(s : SortcompareinsertionBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_insertion_buffer_set(s : SortcompareinsertionBuffer, i : Int, v : Double) -> SortcompareinsertionBuffer {
  let result = sort_compare_insertion_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_insertion_buffer_sum(s : SortcompareinsertionBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_insertion_buffer_mean(s : SortcompareinsertionBuffer) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_insertion_buffer_sum(s) / s.size.to_double() }
}

pub fn sort_compare_insertion_buffer_scale(s : SortcompareinsertionBuffer, f : Double) -> SortcompareinsertionBuffer {
  let result = sort_compare_insertion_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_insertion_buffer_add(a : SortcompareinsertionBuffer, b : SortcompareinsertionBuffer) -> SortcompareinsertionBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_insertion_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_insertion_buffer_copy(s : SortcompareinsertionBuffer) -> SortcompareinsertionBuffer {
  let result = sort_compare_insertion_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_insertion_buffer_fill(s : SortcompareinsertionBuffer, v : Double) -> SortcompareinsertionBuffer {
  let result = sort_compare_insertion_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_insertion_buffer_min(s : SortcompareinsertionBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_insertion_buffer_max(s : SortcompareinsertionBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_insertion_buffer_to_string(s : SortcompareinsertionBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareinsertionCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_insertion_cursor_make(size : Int) -> SortcompareinsertionCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_insertion_cursor_len(s : SortcompareinsertionCursor) -> Int { s.size }

pub fn sort_compare_insertion_cursor_get(s : SortcompareinsertionCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_insertion_cursor_set(s : SortcompareinsertionCursor, i : Int, v : Double) -> SortcompareinsertionCursor {
  let result = sort_compare_insertion_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_insertion_cursor_sum(s : SortcompareinsertionCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_insertion_cursor_mean(s : SortcompareinsertionCursor) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_insertion_cursor_sum(s) / s.size.to_double() }
}

pub fn sort_compare_insertion_cursor_scale(s : SortcompareinsertionCursor, f : Double) -> SortcompareinsertionCursor {
  let result = sort_compare_insertion_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_insertion_cursor_add(a : SortcompareinsertionCursor, b : SortcompareinsertionCursor) -> SortcompareinsertionCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_insertion_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_insertion_cursor_copy(s : SortcompareinsertionCursor) -> SortcompareinsertionCursor {
  let result = sort_compare_insertion_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_insertion_cursor_fill(s : SortcompareinsertionCursor, v : Double) -> SortcompareinsertionCursor {
  let result = sort_compare_insertion_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_insertion_cursor_min(s : SortcompareinsertionCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_insertion_cursor_max(s : SortcompareinsertionCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_insertion_cursor_to_string(s : SortcompareinsertionCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareinsertionView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_insertion_view_make(size : Int) -> SortcompareinsertionView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_insertion_view_len(s : SortcompareinsertionView) -> Int { s.size }

pub fn sort_compare_insertion_view_get(s : SortcompareinsertionView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_insertion_view_set(s : SortcompareinsertionView, i : Int, v : Double) -> SortcompareinsertionView {
  let result = sort_compare_insertion_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_insertion_view_sum(s : SortcompareinsertionView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_insertion_view_mean(s : SortcompareinsertionView) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_insertion_view_sum(s) / s.size.to_double() }
}

pub fn sort_compare_insertion_view_scale(s : SortcompareinsertionView, f : Double) -> SortcompareinsertionView {
  let result = sort_compare_insertion_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_insertion_view_add(a : SortcompareinsertionView, b : SortcompareinsertionView) -> SortcompareinsertionView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_insertion_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_insertion_view_copy(s : SortcompareinsertionView) -> SortcompareinsertionView {
  let result = sort_compare_insertion_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_insertion_view_fill(s : SortcompareinsertionView, v : Double) -> SortcompareinsertionView {
  let result = sort_compare_insertion_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_insertion_view_min(s : SortcompareinsertionView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_insertion_view_max(s : SortcompareinsertionView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_insertion_view_to_string(s : SortcompareinsertionView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareinsertionRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_insertion_range_make(size : Int) -> SortcompareinsertionRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_insertion_range_len(s : SortcompareinsertionRange) -> Int { s.size }

pub fn sort_compare_insertion_range_get(s : SortcompareinsertionRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_insertion_range_set(s : SortcompareinsertionRange, i : Int, v : Double) -> SortcompareinsertionRange {
  let result = sort_compare_insertion_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_insertion_range_sum(s : SortcompareinsertionRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_insertion_range_mean(s : SortcompareinsertionRange) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_insertion_range_sum(s) / s.size.to_double() }
}

pub fn sort_compare_insertion_range_scale(s : SortcompareinsertionRange, f : Double) -> SortcompareinsertionRange {
  let result = sort_compare_insertion_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_insertion_range_add(a : SortcompareinsertionRange, b : SortcompareinsertionRange) -> SortcompareinsertionRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_insertion_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_insertion_range_copy(s : SortcompareinsertionRange) -> SortcompareinsertionRange {
  let result = sort_compare_insertion_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_insertion_range_fill(s : SortcompareinsertionRange, v : Double) -> SortcompareinsertionRange {
  let result = sort_compare_insertion_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_insertion_range_min(s : SortcompareinsertionRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_insertion_range_max(s : SortcompareinsertionRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_insertion_range_to_string(s : SortcompareinsertionRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareinsertionSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_insertion_slice_make(size : Int) -> SortcompareinsertionSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_insertion_slice_len(s : SortcompareinsertionSlice) -> Int { s.size }

pub fn sort_compare_insertion_slice_get(s : SortcompareinsertionSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_insertion_slice_set(s : SortcompareinsertionSlice, i : Int, v : Double) -> SortcompareinsertionSlice {
  let result = sort_compare_insertion_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_insertion_slice_sum(s : SortcompareinsertionSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_insertion_slice_mean(s : SortcompareinsertionSlice) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_insertion_slice_sum(s) / s.size.to_double() }
}

pub fn sort_compare_insertion_slice_scale(s : SortcompareinsertionSlice, f : Double) -> SortcompareinsertionSlice {
  let result = sort_compare_insertion_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_insertion_slice_add(a : SortcompareinsertionSlice, b : SortcompareinsertionSlice) -> SortcompareinsertionSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_insertion_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_insertion_slice_copy(s : SortcompareinsertionSlice) -> SortcompareinsertionSlice {
  let result = sort_compare_insertion_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_insertion_slice_fill(s : SortcompareinsertionSlice, v : Double) -> SortcompareinsertionSlice {
  let result = sort_compare_insertion_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_insertion_slice_min(s : SortcompareinsertionSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_insertion_slice_max(s : SortcompareinsertionSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_insertion_slice_to_string(s : SortcompareinsertionSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn sort_compare_insertion_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_insertion_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_insertion_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_insertion_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_insertion_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_insertion_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_insertion_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_insertion_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_insertion_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_insertion_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_insertion_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_insertion_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_insertion_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_insertion_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_insertion_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_insertion_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_insertion_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_insertion_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_insertion_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_insertion_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_insertion_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_insertion_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_insertion_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_insertion_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_insertion_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}


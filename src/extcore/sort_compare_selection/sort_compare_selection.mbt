///===
/// extcore/sort_compare_selection

pub(all) struct SortcompareselectionPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn sort_compare_selection_make_point(x : Double, y : Double) -> SortcompareselectionPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn sort_compare_selection_make_point3(x : Double, y : Double, z : Double) -> SortcompareselectionPoint {
  { x, y, z, label: 0 }
}

pub fn sort_compare_selection_point_x(pt : SortcompareselectionPoint) -> Double { pt.x }

pub fn sort_compare_selection_point_y(pt : SortcompareselectionPoint) -> Double { pt.y }

pub fn sort_compare_selection_point_z(pt : SortcompareselectionPoint) -> Double { pt.z }

pub fn sort_compare_selection_point_label(pt : SortcompareselectionPoint) -> Int { pt.label }

pub fn sort_compare_selection_point_dist(a : SortcompareselectionPoint, b : SortcompareselectionPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  sort_compare_selection_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn sort_compare_selection_point_add(a : SortcompareselectionPoint, b : SortcompareselectionPoint) -> SortcompareselectionPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn sort_compare_selection_point_sub(a : SortcompareselectionPoint, b : SortcompareselectionPoint) -> SortcompareselectionPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn sort_compare_selection_point_scale(pt : SortcompareselectionPoint, s : Double) -> SortcompareselectionPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn sort_compare_selection_point_dot(a : SortcompareselectionPoint, b : SortcompareselectionPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn sort_compare_selection_point_cross(a : SortcompareselectionPoint, b : SortcompareselectionPoint) -> SortcompareselectionPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn sort_compare_selection_point_norm(pt : SortcompareselectionPoint) -> Double {
  sort_compare_selection_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn sort_compare_selection_point_normalize(pt : SortcompareselectionPoint) -> SortcompareselectionPoint {
  let n = sort_compare_selection_point_norm(pt)
  if n < 0.0000001 { pt } else { sort_compare_selection_point_scale(pt, 1.0 / n) }
}

pub fn sort_compare_selection_point_negate(pt : SortcompareselectionPoint) -> SortcompareselectionPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn sort_compare_selection_point_mid(a : SortcompareselectionPoint, b : SortcompareselectionPoint) -> SortcompareselectionPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn sort_compare_selection_point_lerp(a : SortcompareselectionPoint, b : SortcompareselectionPoint, t : Double) -> SortcompareselectionPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn sort_compare_selection_point_to_string(pt : SortcompareselectionPoint) -> String {
  "(" + sort_compare_selection_dbl(pt.x) + ", " + sort_compare_selection_dbl(pt.y) + ", " + sort_compare_selection_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct SortcompareselectionSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn sort_compare_selection_make_series(vals : Array[Double], name : String) -> SortcompareselectionSeries {
  { vals, name, meta: 0 }
}

pub fn sort_compare_selection_series_len(s : SortcompareselectionSeries) -> Int { s.vals.length() }

pub fn sort_compare_selection_series_sum(s : SortcompareselectionSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn sort_compare_selection_series_mean(s : SortcompareselectionSeries) -> Double {
  let n = sort_compare_selection_series_len(s)
  if n == 0 { 0.0 } else { sort_compare_selection_series_sum(s) / n.to_double() }
}

pub fn sort_compare_selection_series_min(s : SortcompareselectionSeries) -> Double {
  let n = sort_compare_selection_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn sort_compare_selection_series_max(s : SortcompareselectionSeries) -> Double {
  let n = sort_compare_selection_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn sort_compare_selection_series_range(s : SortcompareselectionSeries) -> Double {
  sort_compare_selection_series_max(s) - sort_compare_selection_series_min(s)
}

pub fn sort_compare_selection_series_var(s : SortcompareselectionSeries) -> Double {
  let n = sort_compare_selection_series_len(s)
  if n == 0 { 0.0 } else {
    let m = sort_compare_selection_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn sort_compare_selection_series_std(s : SortcompareselectionSeries) -> Double { sort_compare_selection_sqrt(sort_compare_selection_series_var(s)) }

pub fn sort_compare_selection_series_median(s : SortcompareselectionSeries) -> Double {
  let n = sort_compare_selection_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = sort_compare_selection_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn sort_compare_selection_series_scale(s : SortcompareselectionSeries, f : Double) -> SortcompareselectionSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = sort_compare_selection_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn sort_compare_selection_series_add(a : SortcompareselectionSeries, b : SortcompareselectionSeries) -> SortcompareselectionSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = sort_compare_selection_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn sort_compare_selection_series_sub(a : SortcompareselectionSeries, b : SortcompareselectionSeries) -> SortcompareselectionSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = sort_compare_selection_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn sort_compare_selection_series_normalize(s : SortcompareselectionSeries) -> SortcompareselectionSeries {
  let mn = sort_compare_selection_series_min(s)
  let mx = sort_compare_selection_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = sort_compare_selection_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn sort_compare_selection_series_cumsum(s : SortcompareselectionSeries) -> SortcompareselectionSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = sort_compare_selection_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn sort_compare_selection_series_to_string(s : SortcompareselectionSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + sort_compare_selection_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SortcompareselectionMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn sort_compare_selection_make_matrix(rows : Int, cols : Int, val : Double) -> SortcompareselectionMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn sort_compare_selection_matrix_identity(n : Int) -> SortcompareselectionMatrix {
  let m = sort_compare_selection_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn sort_compare_selection_matrix_get(m : SortcompareselectionMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn sort_compare_selection_matrix_transpose(m : SortcompareselectionMatrix) -> SortcompareselectionMatrix {
  let result = sort_compare_selection_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn sort_compare_selection_matrix_add(a : SortcompareselectionMatrix, b : SortcompareselectionMatrix) -> SortcompareselectionMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = sort_compare_selection_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn sort_compare_selection_matrix_scale(m : SortcompareselectionMatrix, s : Double) -> SortcompareselectionMatrix {
  let result = sort_compare_selection_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn sort_compare_selection_matrix_multiply(a : SortcompareselectionMatrix, b : SortcompareselectionMatrix) -> SortcompareselectionMatrix {
  if a.cols != b.rows { return sort_compare_selection_make_matrix(a.rows, b.cols, 0.0) }
  let result = sort_compare_selection_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn sort_compare_selection_matrix_trace(m : SortcompareselectionMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn sort_compare_selection_matrix_det(m : SortcompareselectionMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn sort_compare_selection_matrix_norm(m : SortcompareselectionMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  sort_compare_selection_sqrt(sum)
}

pub fn sort_compare_selection_matrix_to_string(m : SortcompareselectionMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + sort_compare_selection_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct SortcompareselectionVector {
  comps : Array[Double]
  dim : Int
}

pub fn sort_compare_selection_make_vector(comps : Array[Double]) -> SortcompareselectionVector {
  { comps, dim: comps.length() }
}

pub fn sort_compare_selection_vector_zero(dim : Int) -> SortcompareselectionVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn sort_compare_selection_vector_add(a : SortcompareselectionVector, b : SortcompareselectionVector) -> SortcompareselectionVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = sort_compare_selection_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn sort_compare_selection_vector_sub(a : SortcompareselectionVector, b : SortcompareselectionVector) -> SortcompareselectionVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = sort_compare_selection_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn sort_compare_selection_vector_scale(v : SortcompareselectionVector, s : Double) -> SortcompareselectionVector {
  let mut result = []
  for i in 0..<v.dim { result = sort_compare_selection_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn sort_compare_selection_vector_dot(a : SortcompareselectionVector, b : SortcompareselectionVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn sort_compare_selection_vector_norm(v : SortcompareselectionVector) -> Double { sort_compare_selection_sqrt(sort_compare_selection_vector_dot(v, v)) }

pub fn sort_compare_selection_vector_normalize(v : SortcompareselectionVector) -> SortcompareselectionVector {
  let n = sort_compare_selection_vector_norm(v)
  if n < 0.0000001 { v } else { sort_compare_selection_vector_scale(v, 1.0 / n) }
}

pub fn sort_compare_selection_vector_dist(a : SortcompareselectionVector, b : SortcompareselectionVector) -> Double {
  sort_compare_selection_vector_norm(sort_compare_selection_vector_sub(a, b))
}

pub fn sort_compare_selection_vector_to_string(v : SortcompareselectionVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + sort_compare_selection_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn sort_compare_selection_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn sort_compare_selection_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = sort_compare_selection_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn sort_compare_selection_std(data : Array[Double]) -> Double { sort_compare_selection_sqrt(sort_compare_selection_var(data)) }

pub fn sort_compare_selection_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = sort_compare_selection_mean(a); let mb = sort_compare_selection_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn sort_compare_selection_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = sort_compare_selection_std(a); let sb = sort_compare_selection_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { sort_compare_selection_cov(a, b) / (sa * sb) }
}

pub fn sort_compare_selection_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = sort_compare_selection_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn sort_compare_selection_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn sort_compare_selection_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn sort_compare_selection_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  sort_compare_selection_sqrt(sort_compare_selection_mse(pred, labels))
}

pub fn sort_compare_selection_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + sort_compare_selection_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn sort_compare_selection_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = sort_compare_selection_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn sort_compare_selection_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn sort_compare_selection_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn sort_compare_selection_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = sort_compare_selection_precision(pred, labels, pos); let r = sort_compare_selection_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn sort_compare_selection_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn sort_compare_selection_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = sort_compare_selection_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn sort_compare_selection_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn sort_compare_selection_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn sort_compare_selection_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = sort_compare_selection_gcd(a, b)
    (a / g) * b
  }
}

pub fn sort_compare_selection_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn sort_compare_selection_fibonacci(n : Int) -> Int {
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

pub fn sort_compare_selection_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = sort_compare_selection_min(data); let mx = sort_compare_selection_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn sort_compare_selection_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = sort_compare_selection_mean(data); let sd = sort_compare_selection_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn sort_compare_selection_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn sort_compare_selection_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn sort_compare_selection_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn sort_compare_selection_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn sort_compare_selection_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn sort_compare_selection_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn sort_compare_selection_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn sort_compare_selection_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn sort_compare_selection_dbl(x : Double) -> String {
  let i = if x >= 0.0 { sort_compare_selection_int(x) } else { -sort_compare_selection_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { sort_compare_selection_int(f * 1000000.0) } else { sort_compare_selection_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn sort_compare_selection_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn sort_compare_selection_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct SortcompareselectionFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_selection_frame_make(size : Int) -> SortcompareselectionFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_selection_frame_len(s : SortcompareselectionFrame) -> Int { s.size }

pub fn sort_compare_selection_frame_get(s : SortcompareselectionFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_selection_frame_set(s : SortcompareselectionFrame, i : Int, v : Double) -> SortcompareselectionFrame {
  let result = sort_compare_selection_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_selection_frame_sum(s : SortcompareselectionFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_selection_frame_mean(s : SortcompareselectionFrame) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_selection_frame_sum(s) / s.size.to_double() }
}

pub fn sort_compare_selection_frame_scale(s : SortcompareselectionFrame, f : Double) -> SortcompareselectionFrame {
  let result = sort_compare_selection_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_selection_frame_add(a : SortcompareselectionFrame, b : SortcompareselectionFrame) -> SortcompareselectionFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_selection_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_selection_frame_copy(s : SortcompareselectionFrame) -> SortcompareselectionFrame {
  let result = sort_compare_selection_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_selection_frame_fill(s : SortcompareselectionFrame, v : Double) -> SortcompareselectionFrame {
  let result = sort_compare_selection_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_selection_frame_min(s : SortcompareselectionFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_selection_frame_max(s : SortcompareselectionFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_selection_frame_to_string(s : SortcompareselectionFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareselectionTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_selection_table_make(size : Int) -> SortcompareselectionTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_selection_table_len(s : SortcompareselectionTable) -> Int { s.size }

pub fn sort_compare_selection_table_get(s : SortcompareselectionTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_selection_table_set(s : SortcompareselectionTable, i : Int, v : Double) -> SortcompareselectionTable {
  let result = sort_compare_selection_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_selection_table_sum(s : SortcompareselectionTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_selection_table_mean(s : SortcompareselectionTable) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_selection_table_sum(s) / s.size.to_double() }
}

pub fn sort_compare_selection_table_scale(s : SortcompareselectionTable, f : Double) -> SortcompareselectionTable {
  let result = sort_compare_selection_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_selection_table_add(a : SortcompareselectionTable, b : SortcompareselectionTable) -> SortcompareselectionTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_selection_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_selection_table_copy(s : SortcompareselectionTable) -> SortcompareselectionTable {
  let result = sort_compare_selection_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_selection_table_fill(s : SortcompareselectionTable, v : Double) -> SortcompareselectionTable {
  let result = sort_compare_selection_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_selection_table_min(s : SortcompareselectionTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_selection_table_max(s : SortcompareselectionTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_selection_table_to_string(s : SortcompareselectionTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareselectionGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_selection_graphn_make(size : Int) -> SortcompareselectionGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_selection_graphn_len(s : SortcompareselectionGraphN) -> Int { s.size }

pub fn sort_compare_selection_graphn_get(s : SortcompareselectionGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_selection_graphn_set(s : SortcompareselectionGraphN, i : Int, v : Double) -> SortcompareselectionGraphN {
  let result = sort_compare_selection_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_selection_graphn_sum(s : SortcompareselectionGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_selection_graphn_mean(s : SortcompareselectionGraphN) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_selection_graphn_sum(s) / s.size.to_double() }
}

pub fn sort_compare_selection_graphn_scale(s : SortcompareselectionGraphN, f : Double) -> SortcompareselectionGraphN {
  let result = sort_compare_selection_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_selection_graphn_add(a : SortcompareselectionGraphN, b : SortcompareselectionGraphN) -> SortcompareselectionGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_selection_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_selection_graphn_copy(s : SortcompareselectionGraphN) -> SortcompareselectionGraphN {
  let result = sort_compare_selection_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_selection_graphn_fill(s : SortcompareselectionGraphN, v : Double) -> SortcompareselectionGraphN {
  let result = sort_compare_selection_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_selection_graphn_min(s : SortcompareselectionGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_selection_graphn_max(s : SortcompareselectionGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_selection_graphn_to_string(s : SortcompareselectionGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareselectionNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_selection_node_make(size : Int) -> SortcompareselectionNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_selection_node_len(s : SortcompareselectionNode) -> Int { s.size }

pub fn sort_compare_selection_node_get(s : SortcompareselectionNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_selection_node_set(s : SortcompareselectionNode, i : Int, v : Double) -> SortcompareselectionNode {
  let result = sort_compare_selection_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_selection_node_sum(s : SortcompareselectionNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_selection_node_mean(s : SortcompareselectionNode) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_selection_node_sum(s) / s.size.to_double() }
}

pub fn sort_compare_selection_node_scale(s : SortcompareselectionNode, f : Double) -> SortcompareselectionNode {
  let result = sort_compare_selection_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_selection_node_add(a : SortcompareselectionNode, b : SortcompareselectionNode) -> SortcompareselectionNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_selection_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_selection_node_copy(s : SortcompareselectionNode) -> SortcompareselectionNode {
  let result = sort_compare_selection_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_selection_node_fill(s : SortcompareselectionNode, v : Double) -> SortcompareselectionNode {
  let result = sort_compare_selection_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_selection_node_min(s : SortcompareselectionNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_selection_node_max(s : SortcompareselectionNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_selection_node_to_string(s : SortcompareselectionNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareselectionEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_selection_edge_make(size : Int) -> SortcompareselectionEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_selection_edge_len(s : SortcompareselectionEdge) -> Int { s.size }

pub fn sort_compare_selection_edge_get(s : SortcompareselectionEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_selection_edge_set(s : SortcompareselectionEdge, i : Int, v : Double) -> SortcompareselectionEdge {
  let result = sort_compare_selection_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_selection_edge_sum(s : SortcompareselectionEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_selection_edge_mean(s : SortcompareselectionEdge) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_selection_edge_sum(s) / s.size.to_double() }
}

pub fn sort_compare_selection_edge_scale(s : SortcompareselectionEdge, f : Double) -> SortcompareselectionEdge {
  let result = sort_compare_selection_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_selection_edge_add(a : SortcompareselectionEdge, b : SortcompareselectionEdge) -> SortcompareselectionEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_selection_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_selection_edge_copy(s : SortcompareselectionEdge) -> SortcompareselectionEdge {
  let result = sort_compare_selection_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_selection_edge_fill(s : SortcompareselectionEdge, v : Double) -> SortcompareselectionEdge {
  let result = sort_compare_selection_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_selection_edge_min(s : SortcompareselectionEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_selection_edge_max(s : SortcompareselectionEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_selection_edge_to_string(s : SortcompareselectionEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareselectionPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_selection_path_make(size : Int) -> SortcompareselectionPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_selection_path_len(s : SortcompareselectionPath) -> Int { s.size }

pub fn sort_compare_selection_path_get(s : SortcompareselectionPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_selection_path_set(s : SortcompareselectionPath, i : Int, v : Double) -> SortcompareselectionPath {
  let result = sort_compare_selection_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_selection_path_sum(s : SortcompareselectionPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_selection_path_mean(s : SortcompareselectionPath) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_selection_path_sum(s) / s.size.to_double() }
}

pub fn sort_compare_selection_path_scale(s : SortcompareselectionPath, f : Double) -> SortcompareselectionPath {
  let result = sort_compare_selection_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_selection_path_add(a : SortcompareselectionPath, b : SortcompareselectionPath) -> SortcompareselectionPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_selection_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_selection_path_copy(s : SortcompareselectionPath) -> SortcompareselectionPath {
  let result = sort_compare_selection_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_selection_path_fill(s : SortcompareselectionPath, v : Double) -> SortcompareselectionPath {
  let result = sort_compare_selection_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_selection_path_min(s : SortcompareselectionPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_selection_path_max(s : SortcompareselectionPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_selection_path_to_string(s : SortcompareselectionPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareselectionCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_selection_cluster_make(size : Int) -> SortcompareselectionCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_selection_cluster_len(s : SortcompareselectionCluster) -> Int { s.size }

pub fn sort_compare_selection_cluster_get(s : SortcompareselectionCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_selection_cluster_set(s : SortcompareselectionCluster, i : Int, v : Double) -> SortcompareselectionCluster {
  let result = sort_compare_selection_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_selection_cluster_sum(s : SortcompareselectionCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_selection_cluster_mean(s : SortcompareselectionCluster) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_selection_cluster_sum(s) / s.size.to_double() }
}

pub fn sort_compare_selection_cluster_scale(s : SortcompareselectionCluster, f : Double) -> SortcompareselectionCluster {
  let result = sort_compare_selection_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_selection_cluster_add(a : SortcompareselectionCluster, b : SortcompareselectionCluster) -> SortcompareselectionCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_selection_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_selection_cluster_copy(s : SortcompareselectionCluster) -> SortcompareselectionCluster {
  let result = sort_compare_selection_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_selection_cluster_fill(s : SortcompareselectionCluster, v : Double) -> SortcompareselectionCluster {
  let result = sort_compare_selection_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_selection_cluster_min(s : SortcompareselectionCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_selection_cluster_max(s : SortcompareselectionCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_selection_cluster_to_string(s : SortcompareselectionCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareselectionModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_selection_model_make(size : Int) -> SortcompareselectionModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_selection_model_len(s : SortcompareselectionModel) -> Int { s.size }

pub fn sort_compare_selection_model_get(s : SortcompareselectionModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_selection_model_set(s : SortcompareselectionModel, i : Int, v : Double) -> SortcompareselectionModel {
  let result = sort_compare_selection_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_selection_model_sum(s : SortcompareselectionModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_selection_model_mean(s : SortcompareselectionModel) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_selection_model_sum(s) / s.size.to_double() }
}

pub fn sort_compare_selection_model_scale(s : SortcompareselectionModel, f : Double) -> SortcompareselectionModel {
  let result = sort_compare_selection_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_selection_model_add(a : SortcompareselectionModel, b : SortcompareselectionModel) -> SortcompareselectionModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_selection_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_selection_model_copy(s : SortcompareselectionModel) -> SortcompareselectionModel {
  let result = sort_compare_selection_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_selection_model_fill(s : SortcompareselectionModel, v : Double) -> SortcompareselectionModel {
  let result = sort_compare_selection_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_selection_model_min(s : SortcompareselectionModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_selection_model_max(s : SortcompareselectionModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_selection_model_to_string(s : SortcompareselectionModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareselectionLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_selection_layer_make(size : Int) -> SortcompareselectionLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_selection_layer_len(s : SortcompareselectionLayer) -> Int { s.size }

pub fn sort_compare_selection_layer_get(s : SortcompareselectionLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_selection_layer_set(s : SortcompareselectionLayer, i : Int, v : Double) -> SortcompareselectionLayer {
  let result = sort_compare_selection_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_selection_layer_sum(s : SortcompareselectionLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_selection_layer_mean(s : SortcompareselectionLayer) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_selection_layer_sum(s) / s.size.to_double() }
}

pub fn sort_compare_selection_layer_scale(s : SortcompareselectionLayer, f : Double) -> SortcompareselectionLayer {
  let result = sort_compare_selection_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_selection_layer_add(a : SortcompareselectionLayer, b : SortcompareselectionLayer) -> SortcompareselectionLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_selection_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_selection_layer_copy(s : SortcompareselectionLayer) -> SortcompareselectionLayer {
  let result = sort_compare_selection_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_selection_layer_fill(s : SortcompareselectionLayer, v : Double) -> SortcompareselectionLayer {
  let result = sort_compare_selection_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_selection_layer_min(s : SortcompareselectionLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_selection_layer_max(s : SortcompareselectionLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_selection_layer_to_string(s : SortcompareselectionLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareselectionBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_selection_buffer_make(size : Int) -> SortcompareselectionBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_selection_buffer_len(s : SortcompareselectionBuffer) -> Int { s.size }

pub fn sort_compare_selection_buffer_get(s : SortcompareselectionBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_selection_buffer_set(s : SortcompareselectionBuffer, i : Int, v : Double) -> SortcompareselectionBuffer {
  let result = sort_compare_selection_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_selection_buffer_sum(s : SortcompareselectionBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_selection_buffer_mean(s : SortcompareselectionBuffer) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_selection_buffer_sum(s) / s.size.to_double() }
}

pub fn sort_compare_selection_buffer_scale(s : SortcompareselectionBuffer, f : Double) -> SortcompareselectionBuffer {
  let result = sort_compare_selection_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_selection_buffer_add(a : SortcompareselectionBuffer, b : SortcompareselectionBuffer) -> SortcompareselectionBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_selection_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_selection_buffer_copy(s : SortcompareselectionBuffer) -> SortcompareselectionBuffer {
  let result = sort_compare_selection_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_selection_buffer_fill(s : SortcompareselectionBuffer, v : Double) -> SortcompareselectionBuffer {
  let result = sort_compare_selection_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_selection_buffer_min(s : SortcompareselectionBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_selection_buffer_max(s : SortcompareselectionBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_selection_buffer_to_string(s : SortcompareselectionBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareselectionCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_selection_cursor_make(size : Int) -> SortcompareselectionCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_selection_cursor_len(s : SortcompareselectionCursor) -> Int { s.size }

pub fn sort_compare_selection_cursor_get(s : SortcompareselectionCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_selection_cursor_set(s : SortcompareselectionCursor, i : Int, v : Double) -> SortcompareselectionCursor {
  let result = sort_compare_selection_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_selection_cursor_sum(s : SortcompareselectionCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_selection_cursor_mean(s : SortcompareselectionCursor) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_selection_cursor_sum(s) / s.size.to_double() }
}

pub fn sort_compare_selection_cursor_scale(s : SortcompareselectionCursor, f : Double) -> SortcompareselectionCursor {
  let result = sort_compare_selection_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_selection_cursor_add(a : SortcompareselectionCursor, b : SortcompareselectionCursor) -> SortcompareselectionCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_selection_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_selection_cursor_copy(s : SortcompareselectionCursor) -> SortcompareselectionCursor {
  let result = sort_compare_selection_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_selection_cursor_fill(s : SortcompareselectionCursor, v : Double) -> SortcompareselectionCursor {
  let result = sort_compare_selection_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_selection_cursor_min(s : SortcompareselectionCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_selection_cursor_max(s : SortcompareselectionCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_selection_cursor_to_string(s : SortcompareselectionCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareselectionView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_selection_view_make(size : Int) -> SortcompareselectionView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_selection_view_len(s : SortcompareselectionView) -> Int { s.size }

pub fn sort_compare_selection_view_get(s : SortcompareselectionView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_selection_view_set(s : SortcompareselectionView, i : Int, v : Double) -> SortcompareselectionView {
  let result = sort_compare_selection_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_selection_view_sum(s : SortcompareselectionView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_selection_view_mean(s : SortcompareselectionView) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_selection_view_sum(s) / s.size.to_double() }
}

pub fn sort_compare_selection_view_scale(s : SortcompareselectionView, f : Double) -> SortcompareselectionView {
  let result = sort_compare_selection_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_selection_view_add(a : SortcompareselectionView, b : SortcompareselectionView) -> SortcompareselectionView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_selection_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_selection_view_copy(s : SortcompareselectionView) -> SortcompareselectionView {
  let result = sort_compare_selection_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_selection_view_fill(s : SortcompareselectionView, v : Double) -> SortcompareselectionView {
  let result = sort_compare_selection_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_selection_view_min(s : SortcompareselectionView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_selection_view_max(s : SortcompareselectionView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_selection_view_to_string(s : SortcompareselectionView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareselectionRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_selection_range_make(size : Int) -> SortcompareselectionRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_selection_range_len(s : SortcompareselectionRange) -> Int { s.size }

pub fn sort_compare_selection_range_get(s : SortcompareselectionRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_selection_range_set(s : SortcompareselectionRange, i : Int, v : Double) -> SortcompareselectionRange {
  let result = sort_compare_selection_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_selection_range_sum(s : SortcompareselectionRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_selection_range_mean(s : SortcompareselectionRange) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_selection_range_sum(s) / s.size.to_double() }
}

pub fn sort_compare_selection_range_scale(s : SortcompareselectionRange, f : Double) -> SortcompareselectionRange {
  let result = sort_compare_selection_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_selection_range_add(a : SortcompareselectionRange, b : SortcompareselectionRange) -> SortcompareselectionRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_selection_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_selection_range_copy(s : SortcompareselectionRange) -> SortcompareselectionRange {
  let result = sort_compare_selection_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_selection_range_fill(s : SortcompareselectionRange, v : Double) -> SortcompareselectionRange {
  let result = sort_compare_selection_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_selection_range_min(s : SortcompareselectionRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_selection_range_max(s : SortcompareselectionRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_selection_range_to_string(s : SortcompareselectionRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareselectionSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_selection_slice_make(size : Int) -> SortcompareselectionSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_selection_slice_len(s : SortcompareselectionSlice) -> Int { s.size }

pub fn sort_compare_selection_slice_get(s : SortcompareselectionSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_selection_slice_set(s : SortcompareselectionSlice, i : Int, v : Double) -> SortcompareselectionSlice {
  let result = sort_compare_selection_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_selection_slice_sum(s : SortcompareselectionSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_selection_slice_mean(s : SortcompareselectionSlice) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_selection_slice_sum(s) / s.size.to_double() }
}

pub fn sort_compare_selection_slice_scale(s : SortcompareselectionSlice, f : Double) -> SortcompareselectionSlice {
  let result = sort_compare_selection_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_selection_slice_add(a : SortcompareselectionSlice, b : SortcompareselectionSlice) -> SortcompareselectionSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_selection_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_selection_slice_copy(s : SortcompareselectionSlice) -> SortcompareselectionSlice {
  let result = sort_compare_selection_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_selection_slice_fill(s : SortcompareselectionSlice, v : Double) -> SortcompareselectionSlice {
  let result = sort_compare_selection_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_selection_slice_min(s : SortcompareselectionSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_selection_slice_max(s : SortcompareselectionSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_selection_slice_to_string(s : SortcompareselectionSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn sort_compare_selection_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_selection_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_selection_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_selection_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_selection_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_selection_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_selection_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_selection_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_selection_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_selection_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_selection_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_selection_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_selection_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_selection_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_selection_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_selection_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_selection_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_selection_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_selection_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_selection_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_selection_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_selection_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_selection_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_selection_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_selection_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}


///===
/// extcore/sort_compare_cycle

pub(all) struct SortcomparecyclePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn sort_compare_cycle_make_point(x : Double, y : Double) -> SortcomparecyclePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn sort_compare_cycle_make_point3(x : Double, y : Double, z : Double) -> SortcomparecyclePoint {
  { x, y, z, label: 0 }
}

pub fn sort_compare_cycle_point_x(pt : SortcomparecyclePoint) -> Double { pt.x }

pub fn sort_compare_cycle_point_y(pt : SortcomparecyclePoint) -> Double { pt.y }

pub fn sort_compare_cycle_point_z(pt : SortcomparecyclePoint) -> Double { pt.z }

pub fn sort_compare_cycle_point_label(pt : SortcomparecyclePoint) -> Int { pt.label }

pub fn sort_compare_cycle_point_dist(a : SortcomparecyclePoint, b : SortcomparecyclePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  sort_compare_cycle_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn sort_compare_cycle_point_add(a : SortcomparecyclePoint, b : SortcomparecyclePoint) -> SortcomparecyclePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn sort_compare_cycle_point_sub(a : SortcomparecyclePoint, b : SortcomparecyclePoint) -> SortcomparecyclePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn sort_compare_cycle_point_scale(pt : SortcomparecyclePoint, s : Double) -> SortcomparecyclePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn sort_compare_cycle_point_dot(a : SortcomparecyclePoint, b : SortcomparecyclePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn sort_compare_cycle_point_cross(a : SortcomparecyclePoint, b : SortcomparecyclePoint) -> SortcomparecyclePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn sort_compare_cycle_point_norm(pt : SortcomparecyclePoint) -> Double {
  sort_compare_cycle_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn sort_compare_cycle_point_normalize(pt : SortcomparecyclePoint) -> SortcomparecyclePoint {
  let n = sort_compare_cycle_point_norm(pt)
  if n < 0.0000001 { pt } else { sort_compare_cycle_point_scale(pt, 1.0 / n) }
}

pub fn sort_compare_cycle_point_negate(pt : SortcomparecyclePoint) -> SortcomparecyclePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn sort_compare_cycle_point_mid(a : SortcomparecyclePoint, b : SortcomparecyclePoint) -> SortcomparecyclePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn sort_compare_cycle_point_lerp(a : SortcomparecyclePoint, b : SortcomparecyclePoint, t : Double) -> SortcomparecyclePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn sort_compare_cycle_point_to_string(pt : SortcomparecyclePoint) -> String {
  "(" + sort_compare_cycle_dbl(pt.x) + ", " + sort_compare_cycle_dbl(pt.y) + ", " + sort_compare_cycle_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct SortcomparecycleSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn sort_compare_cycle_make_series(vals : Array[Double], name : String) -> SortcomparecycleSeries {
  { vals, name, meta: 0 }
}

pub fn sort_compare_cycle_series_len(s : SortcomparecycleSeries) -> Int { s.vals.length() }

pub fn sort_compare_cycle_series_sum(s : SortcomparecycleSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn sort_compare_cycle_series_mean(s : SortcomparecycleSeries) -> Double {
  let n = sort_compare_cycle_series_len(s)
  if n == 0 { 0.0 } else { sort_compare_cycle_series_sum(s) / n.to_double() }
}

pub fn sort_compare_cycle_series_min(s : SortcomparecycleSeries) -> Double {
  let n = sort_compare_cycle_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn sort_compare_cycle_series_max(s : SortcomparecycleSeries) -> Double {
  let n = sort_compare_cycle_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn sort_compare_cycle_series_range(s : SortcomparecycleSeries) -> Double {
  sort_compare_cycle_series_max(s) - sort_compare_cycle_series_min(s)
}

pub fn sort_compare_cycle_series_var(s : SortcomparecycleSeries) -> Double {
  let n = sort_compare_cycle_series_len(s)
  if n == 0 { 0.0 } else {
    let m = sort_compare_cycle_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn sort_compare_cycle_series_std(s : SortcomparecycleSeries) -> Double { sort_compare_cycle_sqrt(sort_compare_cycle_series_var(s)) }

pub fn sort_compare_cycle_series_median(s : SortcomparecycleSeries) -> Double {
  let n = sort_compare_cycle_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = sort_compare_cycle_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn sort_compare_cycle_series_scale(s : SortcomparecycleSeries, f : Double) -> SortcomparecycleSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = sort_compare_cycle_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn sort_compare_cycle_series_add(a : SortcomparecycleSeries, b : SortcomparecycleSeries) -> SortcomparecycleSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = sort_compare_cycle_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn sort_compare_cycle_series_sub(a : SortcomparecycleSeries, b : SortcomparecycleSeries) -> SortcomparecycleSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = sort_compare_cycle_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn sort_compare_cycle_series_normalize(s : SortcomparecycleSeries) -> SortcomparecycleSeries {
  let mn = sort_compare_cycle_series_min(s)
  let mx = sort_compare_cycle_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = sort_compare_cycle_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn sort_compare_cycle_series_cumsum(s : SortcomparecycleSeries) -> SortcomparecycleSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = sort_compare_cycle_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn sort_compare_cycle_series_to_string(s : SortcomparecycleSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + sort_compare_cycle_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SortcomparecycleMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn sort_compare_cycle_make_matrix(rows : Int, cols : Int, val : Double) -> SortcomparecycleMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn sort_compare_cycle_matrix_identity(n : Int) -> SortcomparecycleMatrix {
  let m = sort_compare_cycle_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn sort_compare_cycle_matrix_get(m : SortcomparecycleMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn sort_compare_cycle_matrix_transpose(m : SortcomparecycleMatrix) -> SortcomparecycleMatrix {
  let result = sort_compare_cycle_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn sort_compare_cycle_matrix_add(a : SortcomparecycleMatrix, b : SortcomparecycleMatrix) -> SortcomparecycleMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = sort_compare_cycle_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn sort_compare_cycle_matrix_scale(m : SortcomparecycleMatrix, s : Double) -> SortcomparecycleMatrix {
  let result = sort_compare_cycle_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn sort_compare_cycle_matrix_multiply(a : SortcomparecycleMatrix, b : SortcomparecycleMatrix) -> SortcomparecycleMatrix {
  if a.cols != b.rows { return sort_compare_cycle_make_matrix(a.rows, b.cols, 0.0) }
  let result = sort_compare_cycle_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn sort_compare_cycle_matrix_trace(m : SortcomparecycleMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn sort_compare_cycle_matrix_det(m : SortcomparecycleMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn sort_compare_cycle_matrix_norm(m : SortcomparecycleMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  sort_compare_cycle_sqrt(sum)
}

pub fn sort_compare_cycle_matrix_to_string(m : SortcomparecycleMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + sort_compare_cycle_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct SortcomparecycleVector {
  comps : Array[Double]
  dim : Int
}

pub fn sort_compare_cycle_make_vector(comps : Array[Double]) -> SortcomparecycleVector {
  { comps, dim: comps.length() }
}

pub fn sort_compare_cycle_vector_zero(dim : Int) -> SortcomparecycleVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn sort_compare_cycle_vector_add(a : SortcomparecycleVector, b : SortcomparecycleVector) -> SortcomparecycleVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = sort_compare_cycle_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn sort_compare_cycle_vector_sub(a : SortcomparecycleVector, b : SortcomparecycleVector) -> SortcomparecycleVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = sort_compare_cycle_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn sort_compare_cycle_vector_scale(v : SortcomparecycleVector, s : Double) -> SortcomparecycleVector {
  let mut result = []
  for i in 0..<v.dim { result = sort_compare_cycle_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn sort_compare_cycle_vector_dot(a : SortcomparecycleVector, b : SortcomparecycleVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn sort_compare_cycle_vector_norm(v : SortcomparecycleVector) -> Double { sort_compare_cycle_sqrt(sort_compare_cycle_vector_dot(v, v)) }

pub fn sort_compare_cycle_vector_normalize(v : SortcomparecycleVector) -> SortcomparecycleVector {
  let n = sort_compare_cycle_vector_norm(v)
  if n < 0.0000001 { v } else { sort_compare_cycle_vector_scale(v, 1.0 / n) }
}

pub fn sort_compare_cycle_vector_dist(a : SortcomparecycleVector, b : SortcomparecycleVector) -> Double {
  sort_compare_cycle_vector_norm(sort_compare_cycle_vector_sub(a, b))
}

pub fn sort_compare_cycle_vector_to_string(v : SortcomparecycleVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + sort_compare_cycle_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn sort_compare_cycle_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn sort_compare_cycle_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = sort_compare_cycle_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn sort_compare_cycle_std(data : Array[Double]) -> Double { sort_compare_cycle_sqrt(sort_compare_cycle_var(data)) }

pub fn sort_compare_cycle_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = sort_compare_cycle_mean(a); let mb = sort_compare_cycle_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn sort_compare_cycle_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = sort_compare_cycle_std(a); let sb = sort_compare_cycle_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { sort_compare_cycle_cov(a, b) / (sa * sb) }
}

pub fn sort_compare_cycle_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = sort_compare_cycle_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn sort_compare_cycle_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn sort_compare_cycle_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn sort_compare_cycle_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  sort_compare_cycle_sqrt(sort_compare_cycle_mse(pred, labels))
}

pub fn sort_compare_cycle_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + sort_compare_cycle_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn sort_compare_cycle_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = sort_compare_cycle_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn sort_compare_cycle_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn sort_compare_cycle_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn sort_compare_cycle_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = sort_compare_cycle_precision(pred, labels, pos); let r = sort_compare_cycle_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn sort_compare_cycle_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn sort_compare_cycle_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = sort_compare_cycle_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn sort_compare_cycle_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn sort_compare_cycle_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn sort_compare_cycle_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = sort_compare_cycle_gcd(a, b)
    (a / g) * b
  }
}

pub fn sort_compare_cycle_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn sort_compare_cycle_fibonacci(n : Int) -> Int {
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

pub fn sort_compare_cycle_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = sort_compare_cycle_min(data); let mx = sort_compare_cycle_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn sort_compare_cycle_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = sort_compare_cycle_mean(data); let sd = sort_compare_cycle_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn sort_compare_cycle_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn sort_compare_cycle_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn sort_compare_cycle_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn sort_compare_cycle_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn sort_compare_cycle_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn sort_compare_cycle_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn sort_compare_cycle_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn sort_compare_cycle_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn sort_compare_cycle_dbl(x : Double) -> String {
  let i = if x >= 0.0 { sort_compare_cycle_int(x) } else { -sort_compare_cycle_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { sort_compare_cycle_int(f * 1000000.0) } else { sort_compare_cycle_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn sort_compare_cycle_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn sort_compare_cycle_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct SortcomparecycleFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_cycle_frame_make(size : Int) -> SortcomparecycleFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_cycle_frame_len(s : SortcomparecycleFrame) -> Int { s.size }

pub fn sort_compare_cycle_frame_get(s : SortcomparecycleFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_cycle_frame_set(s : SortcomparecycleFrame, i : Int, v : Double) -> SortcomparecycleFrame {
  let result = sort_compare_cycle_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_cycle_frame_sum(s : SortcomparecycleFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_cycle_frame_mean(s : SortcomparecycleFrame) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_cycle_frame_sum(s) / s.size.to_double() }
}

pub fn sort_compare_cycle_frame_scale(s : SortcomparecycleFrame, f : Double) -> SortcomparecycleFrame {
  let result = sort_compare_cycle_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_cycle_frame_add(a : SortcomparecycleFrame, b : SortcomparecycleFrame) -> SortcomparecycleFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_cycle_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_cycle_frame_copy(s : SortcomparecycleFrame) -> SortcomparecycleFrame {
  let result = sort_compare_cycle_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_cycle_frame_fill(s : SortcomparecycleFrame, v : Double) -> SortcomparecycleFrame {
  let result = sort_compare_cycle_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_cycle_frame_min(s : SortcomparecycleFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_cycle_frame_max(s : SortcomparecycleFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_cycle_frame_to_string(s : SortcomparecycleFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparecycleTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_cycle_table_make(size : Int) -> SortcomparecycleTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_cycle_table_len(s : SortcomparecycleTable) -> Int { s.size }

pub fn sort_compare_cycle_table_get(s : SortcomparecycleTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_cycle_table_set(s : SortcomparecycleTable, i : Int, v : Double) -> SortcomparecycleTable {
  let result = sort_compare_cycle_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_cycle_table_sum(s : SortcomparecycleTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_cycle_table_mean(s : SortcomparecycleTable) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_cycle_table_sum(s) / s.size.to_double() }
}

pub fn sort_compare_cycle_table_scale(s : SortcomparecycleTable, f : Double) -> SortcomparecycleTable {
  let result = sort_compare_cycle_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_cycle_table_add(a : SortcomparecycleTable, b : SortcomparecycleTable) -> SortcomparecycleTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_cycle_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_cycle_table_copy(s : SortcomparecycleTable) -> SortcomparecycleTable {
  let result = sort_compare_cycle_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_cycle_table_fill(s : SortcomparecycleTable, v : Double) -> SortcomparecycleTable {
  let result = sort_compare_cycle_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_cycle_table_min(s : SortcomparecycleTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_cycle_table_max(s : SortcomparecycleTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_cycle_table_to_string(s : SortcomparecycleTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparecycleGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_cycle_graphn_make(size : Int) -> SortcomparecycleGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_cycle_graphn_len(s : SortcomparecycleGraphN) -> Int { s.size }

pub fn sort_compare_cycle_graphn_get(s : SortcomparecycleGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_cycle_graphn_set(s : SortcomparecycleGraphN, i : Int, v : Double) -> SortcomparecycleGraphN {
  let result = sort_compare_cycle_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_cycle_graphn_sum(s : SortcomparecycleGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_cycle_graphn_mean(s : SortcomparecycleGraphN) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_cycle_graphn_sum(s) / s.size.to_double() }
}

pub fn sort_compare_cycle_graphn_scale(s : SortcomparecycleGraphN, f : Double) -> SortcomparecycleGraphN {
  let result = sort_compare_cycle_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_cycle_graphn_add(a : SortcomparecycleGraphN, b : SortcomparecycleGraphN) -> SortcomparecycleGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_cycle_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_cycle_graphn_copy(s : SortcomparecycleGraphN) -> SortcomparecycleGraphN {
  let result = sort_compare_cycle_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_cycle_graphn_fill(s : SortcomparecycleGraphN, v : Double) -> SortcomparecycleGraphN {
  let result = sort_compare_cycle_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_cycle_graphn_min(s : SortcomparecycleGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_cycle_graphn_max(s : SortcomparecycleGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_cycle_graphn_to_string(s : SortcomparecycleGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparecycleNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_cycle_node_make(size : Int) -> SortcomparecycleNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_cycle_node_len(s : SortcomparecycleNode) -> Int { s.size }

pub fn sort_compare_cycle_node_get(s : SortcomparecycleNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_cycle_node_set(s : SortcomparecycleNode, i : Int, v : Double) -> SortcomparecycleNode {
  let result = sort_compare_cycle_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_cycle_node_sum(s : SortcomparecycleNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_cycle_node_mean(s : SortcomparecycleNode) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_cycle_node_sum(s) / s.size.to_double() }
}

pub fn sort_compare_cycle_node_scale(s : SortcomparecycleNode, f : Double) -> SortcomparecycleNode {
  let result = sort_compare_cycle_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_cycle_node_add(a : SortcomparecycleNode, b : SortcomparecycleNode) -> SortcomparecycleNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_cycle_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_cycle_node_copy(s : SortcomparecycleNode) -> SortcomparecycleNode {
  let result = sort_compare_cycle_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_cycle_node_fill(s : SortcomparecycleNode, v : Double) -> SortcomparecycleNode {
  let result = sort_compare_cycle_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_cycle_node_min(s : SortcomparecycleNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_cycle_node_max(s : SortcomparecycleNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_cycle_node_to_string(s : SortcomparecycleNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparecycleEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_cycle_edge_make(size : Int) -> SortcomparecycleEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_cycle_edge_len(s : SortcomparecycleEdge) -> Int { s.size }

pub fn sort_compare_cycle_edge_get(s : SortcomparecycleEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_cycle_edge_set(s : SortcomparecycleEdge, i : Int, v : Double) -> SortcomparecycleEdge {
  let result = sort_compare_cycle_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_cycle_edge_sum(s : SortcomparecycleEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_cycle_edge_mean(s : SortcomparecycleEdge) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_cycle_edge_sum(s) / s.size.to_double() }
}

pub fn sort_compare_cycle_edge_scale(s : SortcomparecycleEdge, f : Double) -> SortcomparecycleEdge {
  let result = sort_compare_cycle_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_cycle_edge_add(a : SortcomparecycleEdge, b : SortcomparecycleEdge) -> SortcomparecycleEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_cycle_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_cycle_edge_copy(s : SortcomparecycleEdge) -> SortcomparecycleEdge {
  let result = sort_compare_cycle_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_cycle_edge_fill(s : SortcomparecycleEdge, v : Double) -> SortcomparecycleEdge {
  let result = sort_compare_cycle_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_cycle_edge_min(s : SortcomparecycleEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_cycle_edge_max(s : SortcomparecycleEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_cycle_edge_to_string(s : SortcomparecycleEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparecyclePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_cycle_path_make(size : Int) -> SortcomparecyclePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_cycle_path_len(s : SortcomparecyclePath) -> Int { s.size }

pub fn sort_compare_cycle_path_get(s : SortcomparecyclePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_cycle_path_set(s : SortcomparecyclePath, i : Int, v : Double) -> SortcomparecyclePath {
  let result = sort_compare_cycle_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_cycle_path_sum(s : SortcomparecyclePath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_cycle_path_mean(s : SortcomparecyclePath) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_cycle_path_sum(s) / s.size.to_double() }
}

pub fn sort_compare_cycle_path_scale(s : SortcomparecyclePath, f : Double) -> SortcomparecyclePath {
  let result = sort_compare_cycle_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_cycle_path_add(a : SortcomparecyclePath, b : SortcomparecyclePath) -> SortcomparecyclePath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_cycle_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_cycle_path_copy(s : SortcomparecyclePath) -> SortcomparecyclePath {
  let result = sort_compare_cycle_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_cycle_path_fill(s : SortcomparecyclePath, v : Double) -> SortcomparecyclePath {
  let result = sort_compare_cycle_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_cycle_path_min(s : SortcomparecyclePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_cycle_path_max(s : SortcomparecyclePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_cycle_path_to_string(s : SortcomparecyclePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparecycleCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_cycle_cluster_make(size : Int) -> SortcomparecycleCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_cycle_cluster_len(s : SortcomparecycleCluster) -> Int { s.size }

pub fn sort_compare_cycle_cluster_get(s : SortcomparecycleCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_cycle_cluster_set(s : SortcomparecycleCluster, i : Int, v : Double) -> SortcomparecycleCluster {
  let result = sort_compare_cycle_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_cycle_cluster_sum(s : SortcomparecycleCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_cycle_cluster_mean(s : SortcomparecycleCluster) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_cycle_cluster_sum(s) / s.size.to_double() }
}

pub fn sort_compare_cycle_cluster_scale(s : SortcomparecycleCluster, f : Double) -> SortcomparecycleCluster {
  let result = sort_compare_cycle_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_cycle_cluster_add(a : SortcomparecycleCluster, b : SortcomparecycleCluster) -> SortcomparecycleCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_cycle_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_cycle_cluster_copy(s : SortcomparecycleCluster) -> SortcomparecycleCluster {
  let result = sort_compare_cycle_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_cycle_cluster_fill(s : SortcomparecycleCluster, v : Double) -> SortcomparecycleCluster {
  let result = sort_compare_cycle_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_cycle_cluster_min(s : SortcomparecycleCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_cycle_cluster_max(s : SortcomparecycleCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_cycle_cluster_to_string(s : SortcomparecycleCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparecycleModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_cycle_model_make(size : Int) -> SortcomparecycleModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_cycle_model_len(s : SortcomparecycleModel) -> Int { s.size }

pub fn sort_compare_cycle_model_get(s : SortcomparecycleModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_cycle_model_set(s : SortcomparecycleModel, i : Int, v : Double) -> SortcomparecycleModel {
  let result = sort_compare_cycle_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_cycle_model_sum(s : SortcomparecycleModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_cycle_model_mean(s : SortcomparecycleModel) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_cycle_model_sum(s) / s.size.to_double() }
}

pub fn sort_compare_cycle_model_scale(s : SortcomparecycleModel, f : Double) -> SortcomparecycleModel {
  let result = sort_compare_cycle_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_cycle_model_add(a : SortcomparecycleModel, b : SortcomparecycleModel) -> SortcomparecycleModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_cycle_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_cycle_model_copy(s : SortcomparecycleModel) -> SortcomparecycleModel {
  let result = sort_compare_cycle_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_cycle_model_fill(s : SortcomparecycleModel, v : Double) -> SortcomparecycleModel {
  let result = sort_compare_cycle_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_cycle_model_min(s : SortcomparecycleModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_cycle_model_max(s : SortcomparecycleModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_cycle_model_to_string(s : SortcomparecycleModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparecycleLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_cycle_layer_make(size : Int) -> SortcomparecycleLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_cycle_layer_len(s : SortcomparecycleLayer) -> Int { s.size }

pub fn sort_compare_cycle_layer_get(s : SortcomparecycleLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_cycle_layer_set(s : SortcomparecycleLayer, i : Int, v : Double) -> SortcomparecycleLayer {
  let result = sort_compare_cycle_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_cycle_layer_sum(s : SortcomparecycleLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_cycle_layer_mean(s : SortcomparecycleLayer) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_cycle_layer_sum(s) / s.size.to_double() }
}

pub fn sort_compare_cycle_layer_scale(s : SortcomparecycleLayer, f : Double) -> SortcomparecycleLayer {
  let result = sort_compare_cycle_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_cycle_layer_add(a : SortcomparecycleLayer, b : SortcomparecycleLayer) -> SortcomparecycleLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_cycle_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_cycle_layer_copy(s : SortcomparecycleLayer) -> SortcomparecycleLayer {
  let result = sort_compare_cycle_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_cycle_layer_fill(s : SortcomparecycleLayer, v : Double) -> SortcomparecycleLayer {
  let result = sort_compare_cycle_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_cycle_layer_min(s : SortcomparecycleLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_cycle_layer_max(s : SortcomparecycleLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_cycle_layer_to_string(s : SortcomparecycleLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparecycleBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_cycle_buffer_make(size : Int) -> SortcomparecycleBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_cycle_buffer_len(s : SortcomparecycleBuffer) -> Int { s.size }

pub fn sort_compare_cycle_buffer_get(s : SortcomparecycleBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_cycle_buffer_set(s : SortcomparecycleBuffer, i : Int, v : Double) -> SortcomparecycleBuffer {
  let result = sort_compare_cycle_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_cycle_buffer_sum(s : SortcomparecycleBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_cycle_buffer_mean(s : SortcomparecycleBuffer) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_cycle_buffer_sum(s) / s.size.to_double() }
}

pub fn sort_compare_cycle_buffer_scale(s : SortcomparecycleBuffer, f : Double) -> SortcomparecycleBuffer {
  let result = sort_compare_cycle_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_cycle_buffer_add(a : SortcomparecycleBuffer, b : SortcomparecycleBuffer) -> SortcomparecycleBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_cycle_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_cycle_buffer_copy(s : SortcomparecycleBuffer) -> SortcomparecycleBuffer {
  let result = sort_compare_cycle_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_cycle_buffer_fill(s : SortcomparecycleBuffer, v : Double) -> SortcomparecycleBuffer {
  let result = sort_compare_cycle_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_cycle_buffer_min(s : SortcomparecycleBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_cycle_buffer_max(s : SortcomparecycleBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_cycle_buffer_to_string(s : SortcomparecycleBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparecycleCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_cycle_cursor_make(size : Int) -> SortcomparecycleCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_cycle_cursor_len(s : SortcomparecycleCursor) -> Int { s.size }

pub fn sort_compare_cycle_cursor_get(s : SortcomparecycleCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_cycle_cursor_set(s : SortcomparecycleCursor, i : Int, v : Double) -> SortcomparecycleCursor {
  let result = sort_compare_cycle_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_cycle_cursor_sum(s : SortcomparecycleCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_cycle_cursor_mean(s : SortcomparecycleCursor) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_cycle_cursor_sum(s) / s.size.to_double() }
}

pub fn sort_compare_cycle_cursor_scale(s : SortcomparecycleCursor, f : Double) -> SortcomparecycleCursor {
  let result = sort_compare_cycle_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_cycle_cursor_add(a : SortcomparecycleCursor, b : SortcomparecycleCursor) -> SortcomparecycleCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_cycle_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_cycle_cursor_copy(s : SortcomparecycleCursor) -> SortcomparecycleCursor {
  let result = sort_compare_cycle_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_cycle_cursor_fill(s : SortcomparecycleCursor, v : Double) -> SortcomparecycleCursor {
  let result = sort_compare_cycle_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_cycle_cursor_min(s : SortcomparecycleCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_cycle_cursor_max(s : SortcomparecycleCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_cycle_cursor_to_string(s : SortcomparecycleCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparecycleView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_cycle_view_make(size : Int) -> SortcomparecycleView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_cycle_view_len(s : SortcomparecycleView) -> Int { s.size }

pub fn sort_compare_cycle_view_get(s : SortcomparecycleView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_cycle_view_set(s : SortcomparecycleView, i : Int, v : Double) -> SortcomparecycleView {
  let result = sort_compare_cycle_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_cycle_view_sum(s : SortcomparecycleView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_cycle_view_mean(s : SortcomparecycleView) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_cycle_view_sum(s) / s.size.to_double() }
}

pub fn sort_compare_cycle_view_scale(s : SortcomparecycleView, f : Double) -> SortcomparecycleView {
  let result = sort_compare_cycle_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_cycle_view_add(a : SortcomparecycleView, b : SortcomparecycleView) -> SortcomparecycleView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_cycle_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_cycle_view_copy(s : SortcomparecycleView) -> SortcomparecycleView {
  let result = sort_compare_cycle_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_cycle_view_fill(s : SortcomparecycleView, v : Double) -> SortcomparecycleView {
  let result = sort_compare_cycle_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_cycle_view_min(s : SortcomparecycleView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_cycle_view_max(s : SortcomparecycleView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_cycle_view_to_string(s : SortcomparecycleView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparecycleRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_cycle_range_make(size : Int) -> SortcomparecycleRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_cycle_range_len(s : SortcomparecycleRange) -> Int { s.size }

pub fn sort_compare_cycle_range_get(s : SortcomparecycleRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_cycle_range_set(s : SortcomparecycleRange, i : Int, v : Double) -> SortcomparecycleRange {
  let result = sort_compare_cycle_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_cycle_range_sum(s : SortcomparecycleRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_cycle_range_mean(s : SortcomparecycleRange) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_cycle_range_sum(s) / s.size.to_double() }
}

pub fn sort_compare_cycle_range_scale(s : SortcomparecycleRange, f : Double) -> SortcomparecycleRange {
  let result = sort_compare_cycle_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_cycle_range_add(a : SortcomparecycleRange, b : SortcomparecycleRange) -> SortcomparecycleRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_cycle_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_cycle_range_copy(s : SortcomparecycleRange) -> SortcomparecycleRange {
  let result = sort_compare_cycle_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_cycle_range_fill(s : SortcomparecycleRange, v : Double) -> SortcomparecycleRange {
  let result = sort_compare_cycle_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_cycle_range_min(s : SortcomparecycleRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_cycle_range_max(s : SortcomparecycleRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_cycle_range_to_string(s : SortcomparecycleRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparecycleSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_cycle_slice_make(size : Int) -> SortcomparecycleSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_cycle_slice_len(s : SortcomparecycleSlice) -> Int { s.size }

pub fn sort_compare_cycle_slice_get(s : SortcomparecycleSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_cycle_slice_set(s : SortcomparecycleSlice, i : Int, v : Double) -> SortcomparecycleSlice {
  let result = sort_compare_cycle_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_cycle_slice_sum(s : SortcomparecycleSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_cycle_slice_mean(s : SortcomparecycleSlice) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_cycle_slice_sum(s) / s.size.to_double() }
}

pub fn sort_compare_cycle_slice_scale(s : SortcomparecycleSlice, f : Double) -> SortcomparecycleSlice {
  let result = sort_compare_cycle_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_cycle_slice_add(a : SortcomparecycleSlice, b : SortcomparecycleSlice) -> SortcomparecycleSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_cycle_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_cycle_slice_copy(s : SortcomparecycleSlice) -> SortcomparecycleSlice {
  let result = sort_compare_cycle_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_cycle_slice_fill(s : SortcomparecycleSlice, v : Double) -> SortcomparecycleSlice {
  let result = sort_compare_cycle_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_cycle_slice_min(s : SortcomparecycleSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_cycle_slice_max(s : SortcomparecycleSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_cycle_slice_to_string(s : SortcomparecycleSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn sort_compare_cycle_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_cycle_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_cycle_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_cycle_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_cycle_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_cycle_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_cycle_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_cycle_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_cycle_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_cycle_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_cycle_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_cycle_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_cycle_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_cycle_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_cycle_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_cycle_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_cycle_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_cycle_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_cycle_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_cycle_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_cycle_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_cycle_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_cycle_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_cycle_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_cycle_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}


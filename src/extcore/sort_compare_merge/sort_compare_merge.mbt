///===
/// extcore/sort_compare_merge

pub(all) struct SortcomparemergePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn sort_compare_merge_make_point(x : Double, y : Double) -> SortcomparemergePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn sort_compare_merge_make_point3(x : Double, y : Double, z : Double) -> SortcomparemergePoint {
  { x, y, z, label: 0 }
}

pub fn sort_compare_merge_point_x(pt : SortcomparemergePoint) -> Double { pt.x }

pub fn sort_compare_merge_point_y(pt : SortcomparemergePoint) -> Double { pt.y }

pub fn sort_compare_merge_point_z(pt : SortcomparemergePoint) -> Double { pt.z }

pub fn sort_compare_merge_point_label(pt : SortcomparemergePoint) -> Int { pt.label }

pub fn sort_compare_merge_point_dist(a : SortcomparemergePoint, b : SortcomparemergePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  sort_compare_merge_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn sort_compare_merge_point_add(a : SortcomparemergePoint, b : SortcomparemergePoint) -> SortcomparemergePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn sort_compare_merge_point_sub(a : SortcomparemergePoint, b : SortcomparemergePoint) -> SortcomparemergePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn sort_compare_merge_point_scale(pt : SortcomparemergePoint, s : Double) -> SortcomparemergePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn sort_compare_merge_point_dot(a : SortcomparemergePoint, b : SortcomparemergePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn sort_compare_merge_point_cross(a : SortcomparemergePoint, b : SortcomparemergePoint) -> SortcomparemergePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn sort_compare_merge_point_norm(pt : SortcomparemergePoint) -> Double {
  sort_compare_merge_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn sort_compare_merge_point_normalize(pt : SortcomparemergePoint) -> SortcomparemergePoint {
  let n = sort_compare_merge_point_norm(pt)
  if n < 0.0000001 { pt } else { sort_compare_merge_point_scale(pt, 1.0 / n) }
}

pub fn sort_compare_merge_point_negate(pt : SortcomparemergePoint) -> SortcomparemergePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn sort_compare_merge_point_mid(a : SortcomparemergePoint, b : SortcomparemergePoint) -> SortcomparemergePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn sort_compare_merge_point_lerp(a : SortcomparemergePoint, b : SortcomparemergePoint, t : Double) -> SortcomparemergePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn sort_compare_merge_point_to_string(pt : SortcomparemergePoint) -> String {
  "(" + sort_compare_merge_dbl(pt.x) + ", " + sort_compare_merge_dbl(pt.y) + ", " + sort_compare_merge_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct SortcomparemergeSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn sort_compare_merge_make_series(vals : Array[Double], name : String) -> SortcomparemergeSeries {
  { vals, name, meta: 0 }
}

pub fn sort_compare_merge_series_len(s : SortcomparemergeSeries) -> Int { s.vals.length() }

pub fn sort_compare_merge_series_sum(s : SortcomparemergeSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn sort_compare_merge_series_mean(s : SortcomparemergeSeries) -> Double {
  let n = sort_compare_merge_series_len(s)
  if n == 0 { 0.0 } else { sort_compare_merge_series_sum(s) / n.to_double() }
}

pub fn sort_compare_merge_series_min(s : SortcomparemergeSeries) -> Double {
  let n = sort_compare_merge_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn sort_compare_merge_series_max(s : SortcomparemergeSeries) -> Double {
  let n = sort_compare_merge_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn sort_compare_merge_series_range(s : SortcomparemergeSeries) -> Double {
  sort_compare_merge_series_max(s) - sort_compare_merge_series_min(s)
}

pub fn sort_compare_merge_series_var(s : SortcomparemergeSeries) -> Double {
  let n = sort_compare_merge_series_len(s)
  if n == 0 { 0.0 } else {
    let m = sort_compare_merge_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn sort_compare_merge_series_std(s : SortcomparemergeSeries) -> Double { sort_compare_merge_sqrt(sort_compare_merge_series_var(s)) }

pub fn sort_compare_merge_series_median(s : SortcomparemergeSeries) -> Double {
  let n = sort_compare_merge_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = sort_compare_merge_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn sort_compare_merge_series_scale(s : SortcomparemergeSeries, f : Double) -> SortcomparemergeSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = sort_compare_merge_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn sort_compare_merge_series_add(a : SortcomparemergeSeries, b : SortcomparemergeSeries) -> SortcomparemergeSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = sort_compare_merge_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn sort_compare_merge_series_sub(a : SortcomparemergeSeries, b : SortcomparemergeSeries) -> SortcomparemergeSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = sort_compare_merge_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn sort_compare_merge_series_normalize(s : SortcomparemergeSeries) -> SortcomparemergeSeries {
  let mn = sort_compare_merge_series_min(s)
  let mx = sort_compare_merge_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = sort_compare_merge_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn sort_compare_merge_series_cumsum(s : SortcomparemergeSeries) -> SortcomparemergeSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = sort_compare_merge_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn sort_compare_merge_series_to_string(s : SortcomparemergeSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + sort_compare_merge_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SortcomparemergeMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn sort_compare_merge_make_matrix(rows : Int, cols : Int, val : Double) -> SortcomparemergeMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn sort_compare_merge_matrix_identity(n : Int) -> SortcomparemergeMatrix {
  let m = sort_compare_merge_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn sort_compare_merge_matrix_get(m : SortcomparemergeMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn sort_compare_merge_matrix_transpose(m : SortcomparemergeMatrix) -> SortcomparemergeMatrix {
  let result = sort_compare_merge_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn sort_compare_merge_matrix_add(a : SortcomparemergeMatrix, b : SortcomparemergeMatrix) -> SortcomparemergeMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = sort_compare_merge_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn sort_compare_merge_matrix_scale(m : SortcomparemergeMatrix, s : Double) -> SortcomparemergeMatrix {
  let result = sort_compare_merge_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn sort_compare_merge_matrix_multiply(a : SortcomparemergeMatrix, b : SortcomparemergeMatrix) -> SortcomparemergeMatrix {
  if a.cols != b.rows { return sort_compare_merge_make_matrix(a.rows, b.cols, 0.0) }
  let result = sort_compare_merge_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn sort_compare_merge_matrix_trace(m : SortcomparemergeMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn sort_compare_merge_matrix_det(m : SortcomparemergeMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn sort_compare_merge_matrix_norm(m : SortcomparemergeMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  sort_compare_merge_sqrt(sum)
}

pub fn sort_compare_merge_matrix_to_string(m : SortcomparemergeMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + sort_compare_merge_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct SortcomparemergeVector {
  comps : Array[Double]
  dim : Int
}

pub fn sort_compare_merge_make_vector(comps : Array[Double]) -> SortcomparemergeVector {
  { comps, dim: comps.length() }
}

pub fn sort_compare_merge_vector_zero(dim : Int) -> SortcomparemergeVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn sort_compare_merge_vector_add(a : SortcomparemergeVector, b : SortcomparemergeVector) -> SortcomparemergeVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = sort_compare_merge_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn sort_compare_merge_vector_sub(a : SortcomparemergeVector, b : SortcomparemergeVector) -> SortcomparemergeVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = sort_compare_merge_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn sort_compare_merge_vector_scale(v : SortcomparemergeVector, s : Double) -> SortcomparemergeVector {
  let mut result = []
  for i in 0..<v.dim { result = sort_compare_merge_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn sort_compare_merge_vector_dot(a : SortcomparemergeVector, b : SortcomparemergeVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn sort_compare_merge_vector_norm(v : SortcomparemergeVector) -> Double { sort_compare_merge_sqrt(sort_compare_merge_vector_dot(v, v)) }

pub fn sort_compare_merge_vector_normalize(v : SortcomparemergeVector) -> SortcomparemergeVector {
  let n = sort_compare_merge_vector_norm(v)
  if n < 0.0000001 { v } else { sort_compare_merge_vector_scale(v, 1.0 / n) }
}

pub fn sort_compare_merge_vector_dist(a : SortcomparemergeVector, b : SortcomparemergeVector) -> Double {
  sort_compare_merge_vector_norm(sort_compare_merge_vector_sub(a, b))
}

pub fn sort_compare_merge_vector_to_string(v : SortcomparemergeVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + sort_compare_merge_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn sort_compare_merge_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn sort_compare_merge_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = sort_compare_merge_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn sort_compare_merge_std(data : Array[Double]) -> Double { sort_compare_merge_sqrt(sort_compare_merge_var(data)) }

pub fn sort_compare_merge_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = sort_compare_merge_mean(a); let mb = sort_compare_merge_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn sort_compare_merge_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = sort_compare_merge_std(a); let sb = sort_compare_merge_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { sort_compare_merge_cov(a, b) / (sa * sb) }
}

pub fn sort_compare_merge_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = sort_compare_merge_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn sort_compare_merge_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn sort_compare_merge_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn sort_compare_merge_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  sort_compare_merge_sqrt(sort_compare_merge_mse(pred, labels))
}

pub fn sort_compare_merge_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + sort_compare_merge_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn sort_compare_merge_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = sort_compare_merge_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn sort_compare_merge_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn sort_compare_merge_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn sort_compare_merge_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = sort_compare_merge_precision(pred, labels, pos); let r = sort_compare_merge_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn sort_compare_merge_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn sort_compare_merge_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = sort_compare_merge_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn sort_compare_merge_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn sort_compare_merge_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn sort_compare_merge_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = sort_compare_merge_gcd(a, b)
    (a / g) * b
  }
}

pub fn sort_compare_merge_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn sort_compare_merge_fibonacci(n : Int) -> Int {
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

pub fn sort_compare_merge_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = sort_compare_merge_min(data); let mx = sort_compare_merge_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn sort_compare_merge_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = sort_compare_merge_mean(data); let sd = sort_compare_merge_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn sort_compare_merge_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn sort_compare_merge_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn sort_compare_merge_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn sort_compare_merge_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn sort_compare_merge_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn sort_compare_merge_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn sort_compare_merge_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn sort_compare_merge_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn sort_compare_merge_dbl(x : Double) -> String {
  let i = if x >= 0.0 { sort_compare_merge_int(x) } else { -sort_compare_merge_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { sort_compare_merge_int(f * 1000000.0) } else { sort_compare_merge_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn sort_compare_merge_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn sort_compare_merge_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct SortcomparemergeFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_merge_frame_make(size : Int) -> SortcomparemergeFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_merge_frame_len(s : SortcomparemergeFrame) -> Int { s.size }

pub fn sort_compare_merge_frame_get(s : SortcomparemergeFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_merge_frame_set(s : SortcomparemergeFrame, i : Int, v : Double) -> SortcomparemergeFrame {
  let result = sort_compare_merge_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_merge_frame_sum(s : SortcomparemergeFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_merge_frame_mean(s : SortcomparemergeFrame) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_merge_frame_sum(s) / s.size.to_double() }
}

pub fn sort_compare_merge_frame_scale(s : SortcomparemergeFrame, f : Double) -> SortcomparemergeFrame {
  let result = sort_compare_merge_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_merge_frame_add(a : SortcomparemergeFrame, b : SortcomparemergeFrame) -> SortcomparemergeFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_merge_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_merge_frame_copy(s : SortcomparemergeFrame) -> SortcomparemergeFrame {
  let result = sort_compare_merge_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_merge_frame_fill(s : SortcomparemergeFrame, v : Double) -> SortcomparemergeFrame {
  let result = sort_compare_merge_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_merge_frame_min(s : SortcomparemergeFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_merge_frame_max(s : SortcomparemergeFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_merge_frame_to_string(s : SortcomparemergeFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparemergeTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_merge_table_make(size : Int) -> SortcomparemergeTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_merge_table_len(s : SortcomparemergeTable) -> Int { s.size }

pub fn sort_compare_merge_table_get(s : SortcomparemergeTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_merge_table_set(s : SortcomparemergeTable, i : Int, v : Double) -> SortcomparemergeTable {
  let result = sort_compare_merge_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_merge_table_sum(s : SortcomparemergeTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_merge_table_mean(s : SortcomparemergeTable) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_merge_table_sum(s) / s.size.to_double() }
}

pub fn sort_compare_merge_table_scale(s : SortcomparemergeTable, f : Double) -> SortcomparemergeTable {
  let result = sort_compare_merge_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_merge_table_add(a : SortcomparemergeTable, b : SortcomparemergeTable) -> SortcomparemergeTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_merge_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_merge_table_copy(s : SortcomparemergeTable) -> SortcomparemergeTable {
  let result = sort_compare_merge_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_merge_table_fill(s : SortcomparemergeTable, v : Double) -> SortcomparemergeTable {
  let result = sort_compare_merge_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_merge_table_min(s : SortcomparemergeTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_merge_table_max(s : SortcomparemergeTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_merge_table_to_string(s : SortcomparemergeTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparemergeGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_merge_graphn_make(size : Int) -> SortcomparemergeGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_merge_graphn_len(s : SortcomparemergeGraphN) -> Int { s.size }

pub fn sort_compare_merge_graphn_get(s : SortcomparemergeGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_merge_graphn_set(s : SortcomparemergeGraphN, i : Int, v : Double) -> SortcomparemergeGraphN {
  let result = sort_compare_merge_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_merge_graphn_sum(s : SortcomparemergeGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_merge_graphn_mean(s : SortcomparemergeGraphN) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_merge_graphn_sum(s) / s.size.to_double() }
}

pub fn sort_compare_merge_graphn_scale(s : SortcomparemergeGraphN, f : Double) -> SortcomparemergeGraphN {
  let result = sort_compare_merge_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_merge_graphn_add(a : SortcomparemergeGraphN, b : SortcomparemergeGraphN) -> SortcomparemergeGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_merge_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_merge_graphn_copy(s : SortcomparemergeGraphN) -> SortcomparemergeGraphN {
  let result = sort_compare_merge_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_merge_graphn_fill(s : SortcomparemergeGraphN, v : Double) -> SortcomparemergeGraphN {
  let result = sort_compare_merge_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_merge_graphn_min(s : SortcomparemergeGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_merge_graphn_max(s : SortcomparemergeGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_merge_graphn_to_string(s : SortcomparemergeGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparemergeNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_merge_node_make(size : Int) -> SortcomparemergeNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_merge_node_len(s : SortcomparemergeNode) -> Int { s.size }

pub fn sort_compare_merge_node_get(s : SortcomparemergeNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_merge_node_set(s : SortcomparemergeNode, i : Int, v : Double) -> SortcomparemergeNode {
  let result = sort_compare_merge_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_merge_node_sum(s : SortcomparemergeNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_merge_node_mean(s : SortcomparemergeNode) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_merge_node_sum(s) / s.size.to_double() }
}

pub fn sort_compare_merge_node_scale(s : SortcomparemergeNode, f : Double) -> SortcomparemergeNode {
  let result = sort_compare_merge_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_merge_node_add(a : SortcomparemergeNode, b : SortcomparemergeNode) -> SortcomparemergeNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_merge_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_merge_node_copy(s : SortcomparemergeNode) -> SortcomparemergeNode {
  let result = sort_compare_merge_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_merge_node_fill(s : SortcomparemergeNode, v : Double) -> SortcomparemergeNode {
  let result = sort_compare_merge_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_merge_node_min(s : SortcomparemergeNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_merge_node_max(s : SortcomparemergeNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_merge_node_to_string(s : SortcomparemergeNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparemergeEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_merge_edge_make(size : Int) -> SortcomparemergeEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_merge_edge_len(s : SortcomparemergeEdge) -> Int { s.size }

pub fn sort_compare_merge_edge_get(s : SortcomparemergeEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_merge_edge_set(s : SortcomparemergeEdge, i : Int, v : Double) -> SortcomparemergeEdge {
  let result = sort_compare_merge_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_merge_edge_sum(s : SortcomparemergeEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_merge_edge_mean(s : SortcomparemergeEdge) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_merge_edge_sum(s) / s.size.to_double() }
}

pub fn sort_compare_merge_edge_scale(s : SortcomparemergeEdge, f : Double) -> SortcomparemergeEdge {
  let result = sort_compare_merge_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_merge_edge_add(a : SortcomparemergeEdge, b : SortcomparemergeEdge) -> SortcomparemergeEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_merge_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_merge_edge_copy(s : SortcomparemergeEdge) -> SortcomparemergeEdge {
  let result = sort_compare_merge_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_merge_edge_fill(s : SortcomparemergeEdge, v : Double) -> SortcomparemergeEdge {
  let result = sort_compare_merge_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_merge_edge_min(s : SortcomparemergeEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_merge_edge_max(s : SortcomparemergeEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_merge_edge_to_string(s : SortcomparemergeEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparemergePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_merge_path_make(size : Int) -> SortcomparemergePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_merge_path_len(s : SortcomparemergePath) -> Int { s.size }

pub fn sort_compare_merge_path_get(s : SortcomparemergePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_merge_path_set(s : SortcomparemergePath, i : Int, v : Double) -> SortcomparemergePath {
  let result = sort_compare_merge_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_merge_path_sum(s : SortcomparemergePath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_merge_path_mean(s : SortcomparemergePath) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_merge_path_sum(s) / s.size.to_double() }
}

pub fn sort_compare_merge_path_scale(s : SortcomparemergePath, f : Double) -> SortcomparemergePath {
  let result = sort_compare_merge_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_merge_path_add(a : SortcomparemergePath, b : SortcomparemergePath) -> SortcomparemergePath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_merge_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_merge_path_copy(s : SortcomparemergePath) -> SortcomparemergePath {
  let result = sort_compare_merge_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_merge_path_fill(s : SortcomparemergePath, v : Double) -> SortcomparemergePath {
  let result = sort_compare_merge_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_merge_path_min(s : SortcomparemergePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_merge_path_max(s : SortcomparemergePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_merge_path_to_string(s : SortcomparemergePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparemergeCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_merge_cluster_make(size : Int) -> SortcomparemergeCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_merge_cluster_len(s : SortcomparemergeCluster) -> Int { s.size }

pub fn sort_compare_merge_cluster_get(s : SortcomparemergeCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_merge_cluster_set(s : SortcomparemergeCluster, i : Int, v : Double) -> SortcomparemergeCluster {
  let result = sort_compare_merge_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_merge_cluster_sum(s : SortcomparemergeCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_merge_cluster_mean(s : SortcomparemergeCluster) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_merge_cluster_sum(s) / s.size.to_double() }
}

pub fn sort_compare_merge_cluster_scale(s : SortcomparemergeCluster, f : Double) -> SortcomparemergeCluster {
  let result = sort_compare_merge_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_merge_cluster_add(a : SortcomparemergeCluster, b : SortcomparemergeCluster) -> SortcomparemergeCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_merge_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_merge_cluster_copy(s : SortcomparemergeCluster) -> SortcomparemergeCluster {
  let result = sort_compare_merge_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_merge_cluster_fill(s : SortcomparemergeCluster, v : Double) -> SortcomparemergeCluster {
  let result = sort_compare_merge_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_merge_cluster_min(s : SortcomparemergeCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_merge_cluster_max(s : SortcomparemergeCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_merge_cluster_to_string(s : SortcomparemergeCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparemergeModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_merge_model_make(size : Int) -> SortcomparemergeModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_merge_model_len(s : SortcomparemergeModel) -> Int { s.size }

pub fn sort_compare_merge_model_get(s : SortcomparemergeModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_merge_model_set(s : SortcomparemergeModel, i : Int, v : Double) -> SortcomparemergeModel {
  let result = sort_compare_merge_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_merge_model_sum(s : SortcomparemergeModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_merge_model_mean(s : SortcomparemergeModel) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_merge_model_sum(s) / s.size.to_double() }
}

pub fn sort_compare_merge_model_scale(s : SortcomparemergeModel, f : Double) -> SortcomparemergeModel {
  let result = sort_compare_merge_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_merge_model_add(a : SortcomparemergeModel, b : SortcomparemergeModel) -> SortcomparemergeModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_merge_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_merge_model_copy(s : SortcomparemergeModel) -> SortcomparemergeModel {
  let result = sort_compare_merge_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_merge_model_fill(s : SortcomparemergeModel, v : Double) -> SortcomparemergeModel {
  let result = sort_compare_merge_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_merge_model_min(s : SortcomparemergeModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_merge_model_max(s : SortcomparemergeModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_merge_model_to_string(s : SortcomparemergeModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparemergeLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_merge_layer_make(size : Int) -> SortcomparemergeLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_merge_layer_len(s : SortcomparemergeLayer) -> Int { s.size }

pub fn sort_compare_merge_layer_get(s : SortcomparemergeLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_merge_layer_set(s : SortcomparemergeLayer, i : Int, v : Double) -> SortcomparemergeLayer {
  let result = sort_compare_merge_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_merge_layer_sum(s : SortcomparemergeLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_merge_layer_mean(s : SortcomparemergeLayer) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_merge_layer_sum(s) / s.size.to_double() }
}

pub fn sort_compare_merge_layer_scale(s : SortcomparemergeLayer, f : Double) -> SortcomparemergeLayer {
  let result = sort_compare_merge_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_merge_layer_add(a : SortcomparemergeLayer, b : SortcomparemergeLayer) -> SortcomparemergeLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_merge_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_merge_layer_copy(s : SortcomparemergeLayer) -> SortcomparemergeLayer {
  let result = sort_compare_merge_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_merge_layer_fill(s : SortcomparemergeLayer, v : Double) -> SortcomparemergeLayer {
  let result = sort_compare_merge_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_merge_layer_min(s : SortcomparemergeLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_merge_layer_max(s : SortcomparemergeLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_merge_layer_to_string(s : SortcomparemergeLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparemergeBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_merge_buffer_make(size : Int) -> SortcomparemergeBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_merge_buffer_len(s : SortcomparemergeBuffer) -> Int { s.size }

pub fn sort_compare_merge_buffer_get(s : SortcomparemergeBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_merge_buffer_set(s : SortcomparemergeBuffer, i : Int, v : Double) -> SortcomparemergeBuffer {
  let result = sort_compare_merge_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_merge_buffer_sum(s : SortcomparemergeBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_merge_buffer_mean(s : SortcomparemergeBuffer) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_merge_buffer_sum(s) / s.size.to_double() }
}

pub fn sort_compare_merge_buffer_scale(s : SortcomparemergeBuffer, f : Double) -> SortcomparemergeBuffer {
  let result = sort_compare_merge_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_merge_buffer_add(a : SortcomparemergeBuffer, b : SortcomparemergeBuffer) -> SortcomparemergeBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_merge_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_merge_buffer_copy(s : SortcomparemergeBuffer) -> SortcomparemergeBuffer {
  let result = sort_compare_merge_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_merge_buffer_fill(s : SortcomparemergeBuffer, v : Double) -> SortcomparemergeBuffer {
  let result = sort_compare_merge_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_merge_buffer_min(s : SortcomparemergeBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_merge_buffer_max(s : SortcomparemergeBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_merge_buffer_to_string(s : SortcomparemergeBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparemergeCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_merge_cursor_make(size : Int) -> SortcomparemergeCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_merge_cursor_len(s : SortcomparemergeCursor) -> Int { s.size }

pub fn sort_compare_merge_cursor_get(s : SortcomparemergeCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_merge_cursor_set(s : SortcomparemergeCursor, i : Int, v : Double) -> SortcomparemergeCursor {
  let result = sort_compare_merge_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_merge_cursor_sum(s : SortcomparemergeCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_merge_cursor_mean(s : SortcomparemergeCursor) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_merge_cursor_sum(s) / s.size.to_double() }
}

pub fn sort_compare_merge_cursor_scale(s : SortcomparemergeCursor, f : Double) -> SortcomparemergeCursor {
  let result = sort_compare_merge_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_merge_cursor_add(a : SortcomparemergeCursor, b : SortcomparemergeCursor) -> SortcomparemergeCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_merge_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_merge_cursor_copy(s : SortcomparemergeCursor) -> SortcomparemergeCursor {
  let result = sort_compare_merge_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_merge_cursor_fill(s : SortcomparemergeCursor, v : Double) -> SortcomparemergeCursor {
  let result = sort_compare_merge_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_merge_cursor_min(s : SortcomparemergeCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_merge_cursor_max(s : SortcomparemergeCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_merge_cursor_to_string(s : SortcomparemergeCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparemergeView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_merge_view_make(size : Int) -> SortcomparemergeView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_merge_view_len(s : SortcomparemergeView) -> Int { s.size }

pub fn sort_compare_merge_view_get(s : SortcomparemergeView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_merge_view_set(s : SortcomparemergeView, i : Int, v : Double) -> SortcomparemergeView {
  let result = sort_compare_merge_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_merge_view_sum(s : SortcomparemergeView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_merge_view_mean(s : SortcomparemergeView) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_merge_view_sum(s) / s.size.to_double() }
}

pub fn sort_compare_merge_view_scale(s : SortcomparemergeView, f : Double) -> SortcomparemergeView {
  let result = sort_compare_merge_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_merge_view_add(a : SortcomparemergeView, b : SortcomparemergeView) -> SortcomparemergeView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_merge_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_merge_view_copy(s : SortcomparemergeView) -> SortcomparemergeView {
  let result = sort_compare_merge_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_merge_view_fill(s : SortcomparemergeView, v : Double) -> SortcomparemergeView {
  let result = sort_compare_merge_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_merge_view_min(s : SortcomparemergeView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_merge_view_max(s : SortcomparemergeView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_merge_view_to_string(s : SortcomparemergeView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparemergeRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_merge_range_make(size : Int) -> SortcomparemergeRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_merge_range_len(s : SortcomparemergeRange) -> Int { s.size }

pub fn sort_compare_merge_range_get(s : SortcomparemergeRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_merge_range_set(s : SortcomparemergeRange, i : Int, v : Double) -> SortcomparemergeRange {
  let result = sort_compare_merge_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_merge_range_sum(s : SortcomparemergeRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_merge_range_mean(s : SortcomparemergeRange) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_merge_range_sum(s) / s.size.to_double() }
}

pub fn sort_compare_merge_range_scale(s : SortcomparemergeRange, f : Double) -> SortcomparemergeRange {
  let result = sort_compare_merge_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_merge_range_add(a : SortcomparemergeRange, b : SortcomparemergeRange) -> SortcomparemergeRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_merge_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_merge_range_copy(s : SortcomparemergeRange) -> SortcomparemergeRange {
  let result = sort_compare_merge_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_merge_range_fill(s : SortcomparemergeRange, v : Double) -> SortcomparemergeRange {
  let result = sort_compare_merge_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_merge_range_min(s : SortcomparemergeRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_merge_range_max(s : SortcomparemergeRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_merge_range_to_string(s : SortcomparemergeRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparemergeSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_merge_slice_make(size : Int) -> SortcomparemergeSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_merge_slice_len(s : SortcomparemergeSlice) -> Int { s.size }

pub fn sort_compare_merge_slice_get(s : SortcomparemergeSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_merge_slice_set(s : SortcomparemergeSlice, i : Int, v : Double) -> SortcomparemergeSlice {
  let result = sort_compare_merge_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_merge_slice_sum(s : SortcomparemergeSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_merge_slice_mean(s : SortcomparemergeSlice) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_merge_slice_sum(s) / s.size.to_double() }
}

pub fn sort_compare_merge_slice_scale(s : SortcomparemergeSlice, f : Double) -> SortcomparemergeSlice {
  let result = sort_compare_merge_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_merge_slice_add(a : SortcomparemergeSlice, b : SortcomparemergeSlice) -> SortcomparemergeSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_merge_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_merge_slice_copy(s : SortcomparemergeSlice) -> SortcomparemergeSlice {
  let result = sort_compare_merge_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_merge_slice_fill(s : SortcomparemergeSlice, v : Double) -> SortcomparemergeSlice {
  let result = sort_compare_merge_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_merge_slice_min(s : SortcomparemergeSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_merge_slice_max(s : SortcomparemergeSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_merge_slice_to_string(s : SortcomparemergeSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn sort_compare_merge_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_merge_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_merge_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_merge_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_merge_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_merge_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_merge_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_merge_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_merge_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_merge_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_merge_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_merge_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_merge_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_merge_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_merge_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_merge_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_merge_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_merge_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_merge_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_merge_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_merge_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_merge_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_merge_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_merge_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_merge_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}


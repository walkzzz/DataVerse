///===
/// extcore/sort_compare_bubble

pub(all) struct SortcomparebubblePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn sort_compare_bubble_make_point(x : Double, y : Double) -> SortcomparebubblePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn sort_compare_bubble_make_point3(x : Double, y : Double, z : Double) -> SortcomparebubblePoint {
  { x, y, z, label: 0 }
}

pub fn sort_compare_bubble_point_x(pt : SortcomparebubblePoint) -> Double { pt.x }

pub fn sort_compare_bubble_point_y(pt : SortcomparebubblePoint) -> Double { pt.y }

pub fn sort_compare_bubble_point_z(pt : SortcomparebubblePoint) -> Double { pt.z }

pub fn sort_compare_bubble_point_label(pt : SortcomparebubblePoint) -> Int { pt.label }

pub fn sort_compare_bubble_point_dist(a : SortcomparebubblePoint, b : SortcomparebubblePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  sort_compare_bubble_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn sort_compare_bubble_point_add(a : SortcomparebubblePoint, b : SortcomparebubblePoint) -> SortcomparebubblePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn sort_compare_bubble_point_sub(a : SortcomparebubblePoint, b : SortcomparebubblePoint) -> SortcomparebubblePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn sort_compare_bubble_point_scale(pt : SortcomparebubblePoint, s : Double) -> SortcomparebubblePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn sort_compare_bubble_point_dot(a : SortcomparebubblePoint, b : SortcomparebubblePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn sort_compare_bubble_point_cross(a : SortcomparebubblePoint, b : SortcomparebubblePoint) -> SortcomparebubblePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn sort_compare_bubble_point_norm(pt : SortcomparebubblePoint) -> Double {
  sort_compare_bubble_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn sort_compare_bubble_point_normalize(pt : SortcomparebubblePoint) -> SortcomparebubblePoint {
  let n = sort_compare_bubble_point_norm(pt)
  if n < 0.0000001 { pt } else { sort_compare_bubble_point_scale(pt, 1.0 / n) }
}

pub fn sort_compare_bubble_point_negate(pt : SortcomparebubblePoint) -> SortcomparebubblePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn sort_compare_bubble_point_mid(a : SortcomparebubblePoint, b : SortcomparebubblePoint) -> SortcomparebubblePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn sort_compare_bubble_point_lerp(a : SortcomparebubblePoint, b : SortcomparebubblePoint, t : Double) -> SortcomparebubblePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn sort_compare_bubble_point_to_string(pt : SortcomparebubblePoint) -> String {
  "(" + sort_compare_bubble_dbl(pt.x) + ", " + sort_compare_bubble_dbl(pt.y) + ", " + sort_compare_bubble_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct SortcomparebubbleSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn sort_compare_bubble_make_series(vals : Array[Double], name : String) -> SortcomparebubbleSeries {
  { vals, name, meta: 0 }
}

pub fn sort_compare_bubble_series_len(s : SortcomparebubbleSeries) -> Int { s.vals.length() }

pub fn sort_compare_bubble_series_sum(s : SortcomparebubbleSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn sort_compare_bubble_series_mean(s : SortcomparebubbleSeries) -> Double {
  let n = sort_compare_bubble_series_len(s)
  if n == 0 { 0.0 } else { sort_compare_bubble_series_sum(s) / n.to_double() }
}

pub fn sort_compare_bubble_series_min(s : SortcomparebubbleSeries) -> Double {
  let n = sort_compare_bubble_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn sort_compare_bubble_series_max(s : SortcomparebubbleSeries) -> Double {
  let n = sort_compare_bubble_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn sort_compare_bubble_series_range(s : SortcomparebubbleSeries) -> Double {
  sort_compare_bubble_series_max(s) - sort_compare_bubble_series_min(s)
}

pub fn sort_compare_bubble_series_var(s : SortcomparebubbleSeries) -> Double {
  let n = sort_compare_bubble_series_len(s)
  if n == 0 { 0.0 } else {
    let m = sort_compare_bubble_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn sort_compare_bubble_series_std(s : SortcomparebubbleSeries) -> Double { sort_compare_bubble_sqrt(sort_compare_bubble_series_var(s)) }

pub fn sort_compare_bubble_series_median(s : SortcomparebubbleSeries) -> Double {
  let n = sort_compare_bubble_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = sort_compare_bubble_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn sort_compare_bubble_series_scale(s : SortcomparebubbleSeries, f : Double) -> SortcomparebubbleSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = sort_compare_bubble_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn sort_compare_bubble_series_add(a : SortcomparebubbleSeries, b : SortcomparebubbleSeries) -> SortcomparebubbleSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = sort_compare_bubble_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn sort_compare_bubble_series_sub(a : SortcomparebubbleSeries, b : SortcomparebubbleSeries) -> SortcomparebubbleSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = sort_compare_bubble_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn sort_compare_bubble_series_normalize(s : SortcomparebubbleSeries) -> SortcomparebubbleSeries {
  let mn = sort_compare_bubble_series_min(s)
  let mx = sort_compare_bubble_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = sort_compare_bubble_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn sort_compare_bubble_series_cumsum(s : SortcomparebubbleSeries) -> SortcomparebubbleSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = sort_compare_bubble_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn sort_compare_bubble_series_to_string(s : SortcomparebubbleSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + sort_compare_bubble_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SortcomparebubbleMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn sort_compare_bubble_make_matrix(rows : Int, cols : Int, val : Double) -> SortcomparebubbleMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn sort_compare_bubble_matrix_identity(n : Int) -> SortcomparebubbleMatrix {
  let m = sort_compare_bubble_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn sort_compare_bubble_matrix_get(m : SortcomparebubbleMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn sort_compare_bubble_matrix_transpose(m : SortcomparebubbleMatrix) -> SortcomparebubbleMatrix {
  let result = sort_compare_bubble_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn sort_compare_bubble_matrix_add(a : SortcomparebubbleMatrix, b : SortcomparebubbleMatrix) -> SortcomparebubbleMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = sort_compare_bubble_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn sort_compare_bubble_matrix_scale(m : SortcomparebubbleMatrix, s : Double) -> SortcomparebubbleMatrix {
  let result = sort_compare_bubble_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn sort_compare_bubble_matrix_multiply(a : SortcomparebubbleMatrix, b : SortcomparebubbleMatrix) -> SortcomparebubbleMatrix {
  if a.cols != b.rows { return sort_compare_bubble_make_matrix(a.rows, b.cols, 0.0) }
  let result = sort_compare_bubble_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn sort_compare_bubble_matrix_trace(m : SortcomparebubbleMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn sort_compare_bubble_matrix_det(m : SortcomparebubbleMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn sort_compare_bubble_matrix_norm(m : SortcomparebubbleMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  sort_compare_bubble_sqrt(sum)
}

pub fn sort_compare_bubble_matrix_to_string(m : SortcomparebubbleMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + sort_compare_bubble_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct SortcomparebubbleVector {
  comps : Array[Double]
  dim : Int
}

pub fn sort_compare_bubble_make_vector(comps : Array[Double]) -> SortcomparebubbleVector {
  { comps, dim: comps.length() }
}

pub fn sort_compare_bubble_vector_zero(dim : Int) -> SortcomparebubbleVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn sort_compare_bubble_vector_add(a : SortcomparebubbleVector, b : SortcomparebubbleVector) -> SortcomparebubbleVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = sort_compare_bubble_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn sort_compare_bubble_vector_sub(a : SortcomparebubbleVector, b : SortcomparebubbleVector) -> SortcomparebubbleVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = sort_compare_bubble_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn sort_compare_bubble_vector_scale(v : SortcomparebubbleVector, s : Double) -> SortcomparebubbleVector {
  let mut result = []
  for i in 0..<v.dim { result = sort_compare_bubble_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn sort_compare_bubble_vector_dot(a : SortcomparebubbleVector, b : SortcomparebubbleVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn sort_compare_bubble_vector_norm(v : SortcomparebubbleVector) -> Double { sort_compare_bubble_sqrt(sort_compare_bubble_vector_dot(v, v)) }

pub fn sort_compare_bubble_vector_normalize(v : SortcomparebubbleVector) -> SortcomparebubbleVector {
  let n = sort_compare_bubble_vector_norm(v)
  if n < 0.0000001 { v } else { sort_compare_bubble_vector_scale(v, 1.0 / n) }
}

pub fn sort_compare_bubble_vector_dist(a : SortcomparebubbleVector, b : SortcomparebubbleVector) -> Double {
  sort_compare_bubble_vector_norm(sort_compare_bubble_vector_sub(a, b))
}

pub fn sort_compare_bubble_vector_to_string(v : SortcomparebubbleVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + sort_compare_bubble_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn sort_compare_bubble_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn sort_compare_bubble_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = sort_compare_bubble_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn sort_compare_bubble_std(data : Array[Double]) -> Double { sort_compare_bubble_sqrt(sort_compare_bubble_var(data)) }

pub fn sort_compare_bubble_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = sort_compare_bubble_mean(a); let mb = sort_compare_bubble_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn sort_compare_bubble_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = sort_compare_bubble_std(a); let sb = sort_compare_bubble_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { sort_compare_bubble_cov(a, b) / (sa * sb) }
}

pub fn sort_compare_bubble_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = sort_compare_bubble_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn sort_compare_bubble_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn sort_compare_bubble_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn sort_compare_bubble_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  sort_compare_bubble_sqrt(sort_compare_bubble_mse(pred, labels))
}

pub fn sort_compare_bubble_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + sort_compare_bubble_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn sort_compare_bubble_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = sort_compare_bubble_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn sort_compare_bubble_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn sort_compare_bubble_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn sort_compare_bubble_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = sort_compare_bubble_precision(pred, labels, pos); let r = sort_compare_bubble_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn sort_compare_bubble_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn sort_compare_bubble_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = sort_compare_bubble_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn sort_compare_bubble_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn sort_compare_bubble_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn sort_compare_bubble_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = sort_compare_bubble_gcd(a, b)
    (a / g) * b
  }
}

pub fn sort_compare_bubble_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn sort_compare_bubble_fibonacci(n : Int) -> Int {
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

pub fn sort_compare_bubble_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = sort_compare_bubble_min(data); let mx = sort_compare_bubble_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn sort_compare_bubble_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = sort_compare_bubble_mean(data); let sd = sort_compare_bubble_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn sort_compare_bubble_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn sort_compare_bubble_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn sort_compare_bubble_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn sort_compare_bubble_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn sort_compare_bubble_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn sort_compare_bubble_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn sort_compare_bubble_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn sort_compare_bubble_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn sort_compare_bubble_dbl(x : Double) -> String {
  let i = if x >= 0.0 { sort_compare_bubble_int(x) } else { -sort_compare_bubble_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { sort_compare_bubble_int(f * 1000000.0) } else { sort_compare_bubble_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn sort_compare_bubble_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn sort_compare_bubble_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct SortcomparebubbleFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_bubble_frame_make(size : Int) -> SortcomparebubbleFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_bubble_frame_len(s : SortcomparebubbleFrame) -> Int { s.size }

pub fn sort_compare_bubble_frame_get(s : SortcomparebubbleFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_bubble_frame_set(s : SortcomparebubbleFrame, i : Int, v : Double) -> SortcomparebubbleFrame {
  let result = sort_compare_bubble_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_bubble_frame_sum(s : SortcomparebubbleFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_bubble_frame_mean(s : SortcomparebubbleFrame) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_bubble_frame_sum(s) / s.size.to_double() }
}

pub fn sort_compare_bubble_frame_scale(s : SortcomparebubbleFrame, f : Double) -> SortcomparebubbleFrame {
  let result = sort_compare_bubble_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_bubble_frame_add(a : SortcomparebubbleFrame, b : SortcomparebubbleFrame) -> SortcomparebubbleFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_bubble_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_bubble_frame_copy(s : SortcomparebubbleFrame) -> SortcomparebubbleFrame {
  let result = sort_compare_bubble_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_bubble_frame_fill(s : SortcomparebubbleFrame, v : Double) -> SortcomparebubbleFrame {
  let result = sort_compare_bubble_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_bubble_frame_min(s : SortcomparebubbleFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_bubble_frame_max(s : SortcomparebubbleFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_bubble_frame_to_string(s : SortcomparebubbleFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparebubbleTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_bubble_table_make(size : Int) -> SortcomparebubbleTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_bubble_table_len(s : SortcomparebubbleTable) -> Int { s.size }

pub fn sort_compare_bubble_table_get(s : SortcomparebubbleTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_bubble_table_set(s : SortcomparebubbleTable, i : Int, v : Double) -> SortcomparebubbleTable {
  let result = sort_compare_bubble_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_bubble_table_sum(s : SortcomparebubbleTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_bubble_table_mean(s : SortcomparebubbleTable) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_bubble_table_sum(s) / s.size.to_double() }
}

pub fn sort_compare_bubble_table_scale(s : SortcomparebubbleTable, f : Double) -> SortcomparebubbleTable {
  let result = sort_compare_bubble_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_bubble_table_add(a : SortcomparebubbleTable, b : SortcomparebubbleTable) -> SortcomparebubbleTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_bubble_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_bubble_table_copy(s : SortcomparebubbleTable) -> SortcomparebubbleTable {
  let result = sort_compare_bubble_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_bubble_table_fill(s : SortcomparebubbleTable, v : Double) -> SortcomparebubbleTable {
  let result = sort_compare_bubble_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_bubble_table_min(s : SortcomparebubbleTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_bubble_table_max(s : SortcomparebubbleTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_bubble_table_to_string(s : SortcomparebubbleTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparebubbleGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_bubble_graphn_make(size : Int) -> SortcomparebubbleGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_bubble_graphn_len(s : SortcomparebubbleGraphN) -> Int { s.size }

pub fn sort_compare_bubble_graphn_get(s : SortcomparebubbleGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_bubble_graphn_set(s : SortcomparebubbleGraphN, i : Int, v : Double) -> SortcomparebubbleGraphN {
  let result = sort_compare_bubble_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_bubble_graphn_sum(s : SortcomparebubbleGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_bubble_graphn_mean(s : SortcomparebubbleGraphN) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_bubble_graphn_sum(s) / s.size.to_double() }
}

pub fn sort_compare_bubble_graphn_scale(s : SortcomparebubbleGraphN, f : Double) -> SortcomparebubbleGraphN {
  let result = sort_compare_bubble_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_bubble_graphn_add(a : SortcomparebubbleGraphN, b : SortcomparebubbleGraphN) -> SortcomparebubbleGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_bubble_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_bubble_graphn_copy(s : SortcomparebubbleGraphN) -> SortcomparebubbleGraphN {
  let result = sort_compare_bubble_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_bubble_graphn_fill(s : SortcomparebubbleGraphN, v : Double) -> SortcomparebubbleGraphN {
  let result = sort_compare_bubble_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_bubble_graphn_min(s : SortcomparebubbleGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_bubble_graphn_max(s : SortcomparebubbleGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_bubble_graphn_to_string(s : SortcomparebubbleGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparebubbleNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_bubble_node_make(size : Int) -> SortcomparebubbleNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_bubble_node_len(s : SortcomparebubbleNode) -> Int { s.size }

pub fn sort_compare_bubble_node_get(s : SortcomparebubbleNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_bubble_node_set(s : SortcomparebubbleNode, i : Int, v : Double) -> SortcomparebubbleNode {
  let result = sort_compare_bubble_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_bubble_node_sum(s : SortcomparebubbleNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_bubble_node_mean(s : SortcomparebubbleNode) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_bubble_node_sum(s) / s.size.to_double() }
}

pub fn sort_compare_bubble_node_scale(s : SortcomparebubbleNode, f : Double) -> SortcomparebubbleNode {
  let result = sort_compare_bubble_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_bubble_node_add(a : SortcomparebubbleNode, b : SortcomparebubbleNode) -> SortcomparebubbleNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_bubble_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_bubble_node_copy(s : SortcomparebubbleNode) -> SortcomparebubbleNode {
  let result = sort_compare_bubble_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_bubble_node_fill(s : SortcomparebubbleNode, v : Double) -> SortcomparebubbleNode {
  let result = sort_compare_bubble_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_bubble_node_min(s : SortcomparebubbleNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_bubble_node_max(s : SortcomparebubbleNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_bubble_node_to_string(s : SortcomparebubbleNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparebubbleEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_bubble_edge_make(size : Int) -> SortcomparebubbleEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_bubble_edge_len(s : SortcomparebubbleEdge) -> Int { s.size }

pub fn sort_compare_bubble_edge_get(s : SortcomparebubbleEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_bubble_edge_set(s : SortcomparebubbleEdge, i : Int, v : Double) -> SortcomparebubbleEdge {
  let result = sort_compare_bubble_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_bubble_edge_sum(s : SortcomparebubbleEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_bubble_edge_mean(s : SortcomparebubbleEdge) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_bubble_edge_sum(s) / s.size.to_double() }
}

pub fn sort_compare_bubble_edge_scale(s : SortcomparebubbleEdge, f : Double) -> SortcomparebubbleEdge {
  let result = sort_compare_bubble_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_bubble_edge_add(a : SortcomparebubbleEdge, b : SortcomparebubbleEdge) -> SortcomparebubbleEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_bubble_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_bubble_edge_copy(s : SortcomparebubbleEdge) -> SortcomparebubbleEdge {
  let result = sort_compare_bubble_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_bubble_edge_fill(s : SortcomparebubbleEdge, v : Double) -> SortcomparebubbleEdge {
  let result = sort_compare_bubble_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_bubble_edge_min(s : SortcomparebubbleEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_bubble_edge_max(s : SortcomparebubbleEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_bubble_edge_to_string(s : SortcomparebubbleEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparebubblePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_bubble_path_make(size : Int) -> SortcomparebubblePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_bubble_path_len(s : SortcomparebubblePath) -> Int { s.size }

pub fn sort_compare_bubble_path_get(s : SortcomparebubblePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_bubble_path_set(s : SortcomparebubblePath, i : Int, v : Double) -> SortcomparebubblePath {
  let result = sort_compare_bubble_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_bubble_path_sum(s : SortcomparebubblePath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_bubble_path_mean(s : SortcomparebubblePath) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_bubble_path_sum(s) / s.size.to_double() }
}

pub fn sort_compare_bubble_path_scale(s : SortcomparebubblePath, f : Double) -> SortcomparebubblePath {
  let result = sort_compare_bubble_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_bubble_path_add(a : SortcomparebubblePath, b : SortcomparebubblePath) -> SortcomparebubblePath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_bubble_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_bubble_path_copy(s : SortcomparebubblePath) -> SortcomparebubblePath {
  let result = sort_compare_bubble_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_bubble_path_fill(s : SortcomparebubblePath, v : Double) -> SortcomparebubblePath {
  let result = sort_compare_bubble_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_bubble_path_min(s : SortcomparebubblePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_bubble_path_max(s : SortcomparebubblePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_bubble_path_to_string(s : SortcomparebubblePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparebubbleCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_bubble_cluster_make(size : Int) -> SortcomparebubbleCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_bubble_cluster_len(s : SortcomparebubbleCluster) -> Int { s.size }

pub fn sort_compare_bubble_cluster_get(s : SortcomparebubbleCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_bubble_cluster_set(s : SortcomparebubbleCluster, i : Int, v : Double) -> SortcomparebubbleCluster {
  let result = sort_compare_bubble_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_bubble_cluster_sum(s : SortcomparebubbleCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_bubble_cluster_mean(s : SortcomparebubbleCluster) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_bubble_cluster_sum(s) / s.size.to_double() }
}

pub fn sort_compare_bubble_cluster_scale(s : SortcomparebubbleCluster, f : Double) -> SortcomparebubbleCluster {
  let result = sort_compare_bubble_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_bubble_cluster_add(a : SortcomparebubbleCluster, b : SortcomparebubbleCluster) -> SortcomparebubbleCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_bubble_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_bubble_cluster_copy(s : SortcomparebubbleCluster) -> SortcomparebubbleCluster {
  let result = sort_compare_bubble_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_bubble_cluster_fill(s : SortcomparebubbleCluster, v : Double) -> SortcomparebubbleCluster {
  let result = sort_compare_bubble_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_bubble_cluster_min(s : SortcomparebubbleCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_bubble_cluster_max(s : SortcomparebubbleCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_bubble_cluster_to_string(s : SortcomparebubbleCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparebubbleModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_bubble_model_make(size : Int) -> SortcomparebubbleModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_bubble_model_len(s : SortcomparebubbleModel) -> Int { s.size }

pub fn sort_compare_bubble_model_get(s : SortcomparebubbleModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_bubble_model_set(s : SortcomparebubbleModel, i : Int, v : Double) -> SortcomparebubbleModel {
  let result = sort_compare_bubble_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_bubble_model_sum(s : SortcomparebubbleModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_bubble_model_mean(s : SortcomparebubbleModel) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_bubble_model_sum(s) / s.size.to_double() }
}

pub fn sort_compare_bubble_model_scale(s : SortcomparebubbleModel, f : Double) -> SortcomparebubbleModel {
  let result = sort_compare_bubble_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_bubble_model_add(a : SortcomparebubbleModel, b : SortcomparebubbleModel) -> SortcomparebubbleModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_bubble_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_bubble_model_copy(s : SortcomparebubbleModel) -> SortcomparebubbleModel {
  let result = sort_compare_bubble_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_bubble_model_fill(s : SortcomparebubbleModel, v : Double) -> SortcomparebubbleModel {
  let result = sort_compare_bubble_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_bubble_model_min(s : SortcomparebubbleModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_bubble_model_max(s : SortcomparebubbleModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_bubble_model_to_string(s : SortcomparebubbleModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparebubbleLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_bubble_layer_make(size : Int) -> SortcomparebubbleLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_bubble_layer_len(s : SortcomparebubbleLayer) -> Int { s.size }

pub fn sort_compare_bubble_layer_get(s : SortcomparebubbleLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_bubble_layer_set(s : SortcomparebubbleLayer, i : Int, v : Double) -> SortcomparebubbleLayer {
  let result = sort_compare_bubble_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_bubble_layer_sum(s : SortcomparebubbleLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_bubble_layer_mean(s : SortcomparebubbleLayer) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_bubble_layer_sum(s) / s.size.to_double() }
}

pub fn sort_compare_bubble_layer_scale(s : SortcomparebubbleLayer, f : Double) -> SortcomparebubbleLayer {
  let result = sort_compare_bubble_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_bubble_layer_add(a : SortcomparebubbleLayer, b : SortcomparebubbleLayer) -> SortcomparebubbleLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_bubble_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_bubble_layer_copy(s : SortcomparebubbleLayer) -> SortcomparebubbleLayer {
  let result = sort_compare_bubble_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_bubble_layer_fill(s : SortcomparebubbleLayer, v : Double) -> SortcomparebubbleLayer {
  let result = sort_compare_bubble_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_bubble_layer_min(s : SortcomparebubbleLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_bubble_layer_max(s : SortcomparebubbleLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_bubble_layer_to_string(s : SortcomparebubbleLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparebubbleBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_bubble_buffer_make(size : Int) -> SortcomparebubbleBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_bubble_buffer_len(s : SortcomparebubbleBuffer) -> Int { s.size }

pub fn sort_compare_bubble_buffer_get(s : SortcomparebubbleBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_bubble_buffer_set(s : SortcomparebubbleBuffer, i : Int, v : Double) -> SortcomparebubbleBuffer {
  let result = sort_compare_bubble_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_bubble_buffer_sum(s : SortcomparebubbleBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_bubble_buffer_mean(s : SortcomparebubbleBuffer) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_bubble_buffer_sum(s) / s.size.to_double() }
}

pub fn sort_compare_bubble_buffer_scale(s : SortcomparebubbleBuffer, f : Double) -> SortcomparebubbleBuffer {
  let result = sort_compare_bubble_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_bubble_buffer_add(a : SortcomparebubbleBuffer, b : SortcomparebubbleBuffer) -> SortcomparebubbleBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_bubble_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_bubble_buffer_copy(s : SortcomparebubbleBuffer) -> SortcomparebubbleBuffer {
  let result = sort_compare_bubble_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_bubble_buffer_fill(s : SortcomparebubbleBuffer, v : Double) -> SortcomparebubbleBuffer {
  let result = sort_compare_bubble_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_bubble_buffer_min(s : SortcomparebubbleBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_bubble_buffer_max(s : SortcomparebubbleBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_bubble_buffer_to_string(s : SortcomparebubbleBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparebubbleCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_bubble_cursor_make(size : Int) -> SortcomparebubbleCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_bubble_cursor_len(s : SortcomparebubbleCursor) -> Int { s.size }

pub fn sort_compare_bubble_cursor_get(s : SortcomparebubbleCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_bubble_cursor_set(s : SortcomparebubbleCursor, i : Int, v : Double) -> SortcomparebubbleCursor {
  let result = sort_compare_bubble_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_bubble_cursor_sum(s : SortcomparebubbleCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_bubble_cursor_mean(s : SortcomparebubbleCursor) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_bubble_cursor_sum(s) / s.size.to_double() }
}

pub fn sort_compare_bubble_cursor_scale(s : SortcomparebubbleCursor, f : Double) -> SortcomparebubbleCursor {
  let result = sort_compare_bubble_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_bubble_cursor_add(a : SortcomparebubbleCursor, b : SortcomparebubbleCursor) -> SortcomparebubbleCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_bubble_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_bubble_cursor_copy(s : SortcomparebubbleCursor) -> SortcomparebubbleCursor {
  let result = sort_compare_bubble_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_bubble_cursor_fill(s : SortcomparebubbleCursor, v : Double) -> SortcomparebubbleCursor {
  let result = sort_compare_bubble_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_bubble_cursor_min(s : SortcomparebubbleCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_bubble_cursor_max(s : SortcomparebubbleCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_bubble_cursor_to_string(s : SortcomparebubbleCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparebubbleView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_bubble_view_make(size : Int) -> SortcomparebubbleView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_bubble_view_len(s : SortcomparebubbleView) -> Int { s.size }

pub fn sort_compare_bubble_view_get(s : SortcomparebubbleView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_bubble_view_set(s : SortcomparebubbleView, i : Int, v : Double) -> SortcomparebubbleView {
  let result = sort_compare_bubble_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_bubble_view_sum(s : SortcomparebubbleView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_bubble_view_mean(s : SortcomparebubbleView) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_bubble_view_sum(s) / s.size.to_double() }
}

pub fn sort_compare_bubble_view_scale(s : SortcomparebubbleView, f : Double) -> SortcomparebubbleView {
  let result = sort_compare_bubble_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_bubble_view_add(a : SortcomparebubbleView, b : SortcomparebubbleView) -> SortcomparebubbleView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_bubble_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_bubble_view_copy(s : SortcomparebubbleView) -> SortcomparebubbleView {
  let result = sort_compare_bubble_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_bubble_view_fill(s : SortcomparebubbleView, v : Double) -> SortcomparebubbleView {
  let result = sort_compare_bubble_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_bubble_view_min(s : SortcomparebubbleView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_bubble_view_max(s : SortcomparebubbleView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_bubble_view_to_string(s : SortcomparebubbleView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparebubbleRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_bubble_range_make(size : Int) -> SortcomparebubbleRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_bubble_range_len(s : SortcomparebubbleRange) -> Int { s.size }

pub fn sort_compare_bubble_range_get(s : SortcomparebubbleRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_bubble_range_set(s : SortcomparebubbleRange, i : Int, v : Double) -> SortcomparebubbleRange {
  let result = sort_compare_bubble_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_bubble_range_sum(s : SortcomparebubbleRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_bubble_range_mean(s : SortcomparebubbleRange) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_bubble_range_sum(s) / s.size.to_double() }
}

pub fn sort_compare_bubble_range_scale(s : SortcomparebubbleRange, f : Double) -> SortcomparebubbleRange {
  let result = sort_compare_bubble_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_bubble_range_add(a : SortcomparebubbleRange, b : SortcomparebubbleRange) -> SortcomparebubbleRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_bubble_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_bubble_range_copy(s : SortcomparebubbleRange) -> SortcomparebubbleRange {
  let result = sort_compare_bubble_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_bubble_range_fill(s : SortcomparebubbleRange, v : Double) -> SortcomparebubbleRange {
  let result = sort_compare_bubble_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_bubble_range_min(s : SortcomparebubbleRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_bubble_range_max(s : SortcomparebubbleRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_bubble_range_to_string(s : SortcomparebubbleRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparebubbleSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_bubble_slice_make(size : Int) -> SortcomparebubbleSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_bubble_slice_len(s : SortcomparebubbleSlice) -> Int { s.size }

pub fn sort_compare_bubble_slice_get(s : SortcomparebubbleSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_bubble_slice_set(s : SortcomparebubbleSlice, i : Int, v : Double) -> SortcomparebubbleSlice {
  let result = sort_compare_bubble_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_bubble_slice_sum(s : SortcomparebubbleSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_bubble_slice_mean(s : SortcomparebubbleSlice) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_bubble_slice_sum(s) / s.size.to_double() }
}

pub fn sort_compare_bubble_slice_scale(s : SortcomparebubbleSlice, f : Double) -> SortcomparebubbleSlice {
  let result = sort_compare_bubble_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_bubble_slice_add(a : SortcomparebubbleSlice, b : SortcomparebubbleSlice) -> SortcomparebubbleSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_bubble_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_bubble_slice_copy(s : SortcomparebubbleSlice) -> SortcomparebubbleSlice {
  let result = sort_compare_bubble_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_bubble_slice_fill(s : SortcomparebubbleSlice, v : Double) -> SortcomparebubbleSlice {
  let result = sort_compare_bubble_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_bubble_slice_min(s : SortcomparebubbleSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_bubble_slice_max(s : SortcomparebubbleSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_bubble_slice_to_string(s : SortcomparebubbleSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn sort_compare_bubble_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_bubble_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_bubble_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_bubble_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_bubble_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_bubble_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_bubble_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_bubble_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_bubble_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_bubble_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_bubble_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_bubble_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_bubble_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_bubble_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_bubble_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_bubble_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_bubble_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_bubble_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_bubble_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_bubble_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_bubble_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_bubble_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_bubble_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_bubble_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_compare_bubble_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}


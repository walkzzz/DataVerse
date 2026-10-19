///===
/// extcore/sort_exchange_strand

pub(all) struct SortexchangestrandPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn sort_exchange_strand_make_point(x : Double, y : Double) -> SortexchangestrandPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn sort_exchange_strand_make_point3(x : Double, y : Double, z : Double) -> SortexchangestrandPoint {
  { x, y, z, label: 0 }
}

pub fn sort_exchange_strand_point_x(pt : SortexchangestrandPoint) -> Double { pt.x }

pub fn sort_exchange_strand_point_y(pt : SortexchangestrandPoint) -> Double { pt.y }

pub fn sort_exchange_strand_point_z(pt : SortexchangestrandPoint) -> Double { pt.z }

pub fn sort_exchange_strand_point_label(pt : SortexchangestrandPoint) -> Int { pt.label }

pub fn sort_exchange_strand_point_dist(a : SortexchangestrandPoint, b : SortexchangestrandPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  sort_exchange_strand_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn sort_exchange_strand_point_add(a : SortexchangestrandPoint, b : SortexchangestrandPoint) -> SortexchangestrandPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn sort_exchange_strand_point_sub(a : SortexchangestrandPoint, b : SortexchangestrandPoint) -> SortexchangestrandPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn sort_exchange_strand_point_scale(pt : SortexchangestrandPoint, s : Double) -> SortexchangestrandPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn sort_exchange_strand_point_dot(a : SortexchangestrandPoint, b : SortexchangestrandPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn sort_exchange_strand_point_cross(a : SortexchangestrandPoint, b : SortexchangestrandPoint) -> SortexchangestrandPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn sort_exchange_strand_point_norm(pt : SortexchangestrandPoint) -> Double {
  sort_exchange_strand_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn sort_exchange_strand_point_normalize(pt : SortexchangestrandPoint) -> SortexchangestrandPoint {
  let n = sort_exchange_strand_point_norm(pt)
  if n < 0.0000001 { pt } else { sort_exchange_strand_point_scale(pt, 1.0 / n) }
}

pub fn sort_exchange_strand_point_negate(pt : SortexchangestrandPoint) -> SortexchangestrandPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn sort_exchange_strand_point_mid(a : SortexchangestrandPoint, b : SortexchangestrandPoint) -> SortexchangestrandPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn sort_exchange_strand_point_lerp(a : SortexchangestrandPoint, b : SortexchangestrandPoint, t : Double) -> SortexchangestrandPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn sort_exchange_strand_point_to_string(pt : SortexchangestrandPoint) -> String {
  "(" + sort_exchange_strand_dbl(pt.x) + ", " + sort_exchange_strand_dbl(pt.y) + ", " + sort_exchange_strand_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct SortexchangestrandSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn sort_exchange_strand_make_series(vals : Array[Double], name : String) -> SortexchangestrandSeries {
  { vals, name, meta: 0 }
}

pub fn sort_exchange_strand_series_len(s : SortexchangestrandSeries) -> Int { s.vals.length() }

pub fn sort_exchange_strand_series_sum(s : SortexchangestrandSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn sort_exchange_strand_series_mean(s : SortexchangestrandSeries) -> Double {
  let n = sort_exchange_strand_series_len(s)
  if n == 0 { 0.0 } else { sort_exchange_strand_series_sum(s) / n.to_double() }
}

pub fn sort_exchange_strand_series_min(s : SortexchangestrandSeries) -> Double {
  let n = sort_exchange_strand_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn sort_exchange_strand_series_max(s : SortexchangestrandSeries) -> Double {
  let n = sort_exchange_strand_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn sort_exchange_strand_series_range(s : SortexchangestrandSeries) -> Double {
  sort_exchange_strand_series_max(s) - sort_exchange_strand_series_min(s)
}

pub fn sort_exchange_strand_series_var(s : SortexchangestrandSeries) -> Double {
  let n = sort_exchange_strand_series_len(s)
  if n == 0 { 0.0 } else {
    let m = sort_exchange_strand_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn sort_exchange_strand_series_std(s : SortexchangestrandSeries) -> Double { sort_exchange_strand_sqrt(sort_exchange_strand_series_var(s)) }

pub fn sort_exchange_strand_series_median(s : SortexchangestrandSeries) -> Double {
  let n = sort_exchange_strand_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = sort_exchange_strand_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn sort_exchange_strand_series_scale(s : SortexchangestrandSeries, f : Double) -> SortexchangestrandSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = sort_exchange_strand_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn sort_exchange_strand_series_add(a : SortexchangestrandSeries, b : SortexchangestrandSeries) -> SortexchangestrandSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = sort_exchange_strand_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn sort_exchange_strand_series_sub(a : SortexchangestrandSeries, b : SortexchangestrandSeries) -> SortexchangestrandSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = sort_exchange_strand_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn sort_exchange_strand_series_normalize(s : SortexchangestrandSeries) -> SortexchangestrandSeries {
  let mn = sort_exchange_strand_series_min(s)
  let mx = sort_exchange_strand_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = sort_exchange_strand_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn sort_exchange_strand_series_cumsum(s : SortexchangestrandSeries) -> SortexchangestrandSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = sort_exchange_strand_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn sort_exchange_strand_series_to_string(s : SortexchangestrandSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + sort_exchange_strand_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SortexchangestrandMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn sort_exchange_strand_make_matrix(rows : Int, cols : Int, val : Double) -> SortexchangestrandMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn sort_exchange_strand_matrix_identity(n : Int) -> SortexchangestrandMatrix {
  let m = sort_exchange_strand_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn sort_exchange_strand_matrix_get(m : SortexchangestrandMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn sort_exchange_strand_matrix_transpose(m : SortexchangestrandMatrix) -> SortexchangestrandMatrix {
  let result = sort_exchange_strand_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn sort_exchange_strand_matrix_add(a : SortexchangestrandMatrix, b : SortexchangestrandMatrix) -> SortexchangestrandMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = sort_exchange_strand_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn sort_exchange_strand_matrix_scale(m : SortexchangestrandMatrix, s : Double) -> SortexchangestrandMatrix {
  let result = sort_exchange_strand_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn sort_exchange_strand_matrix_multiply(a : SortexchangestrandMatrix, b : SortexchangestrandMatrix) -> SortexchangestrandMatrix {
  if a.cols != b.rows { return sort_exchange_strand_make_matrix(a.rows, b.cols, 0.0) }
  let result = sort_exchange_strand_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn sort_exchange_strand_matrix_trace(m : SortexchangestrandMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn sort_exchange_strand_matrix_det(m : SortexchangestrandMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn sort_exchange_strand_matrix_norm(m : SortexchangestrandMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  sort_exchange_strand_sqrt(sum)
}

pub fn sort_exchange_strand_matrix_to_string(m : SortexchangestrandMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + sort_exchange_strand_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct SortexchangestrandVector {
  comps : Array[Double]
  dim : Int
}

pub fn sort_exchange_strand_make_vector(comps : Array[Double]) -> SortexchangestrandVector {
  { comps, dim: comps.length() }
}

pub fn sort_exchange_strand_vector_zero(dim : Int) -> SortexchangestrandVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn sort_exchange_strand_vector_add(a : SortexchangestrandVector, b : SortexchangestrandVector) -> SortexchangestrandVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = sort_exchange_strand_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn sort_exchange_strand_vector_sub(a : SortexchangestrandVector, b : SortexchangestrandVector) -> SortexchangestrandVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = sort_exchange_strand_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn sort_exchange_strand_vector_scale(v : SortexchangestrandVector, s : Double) -> SortexchangestrandVector {
  let mut result = []
  for i in 0..<v.dim { result = sort_exchange_strand_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn sort_exchange_strand_vector_dot(a : SortexchangestrandVector, b : SortexchangestrandVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn sort_exchange_strand_vector_norm(v : SortexchangestrandVector) -> Double { sort_exchange_strand_sqrt(sort_exchange_strand_vector_dot(v, v)) }

pub fn sort_exchange_strand_vector_normalize(v : SortexchangestrandVector) -> SortexchangestrandVector {
  let n = sort_exchange_strand_vector_norm(v)
  if n < 0.0000001 { v } else { sort_exchange_strand_vector_scale(v, 1.0 / n) }
}

pub fn sort_exchange_strand_vector_dist(a : SortexchangestrandVector, b : SortexchangestrandVector) -> Double {
  sort_exchange_strand_vector_norm(sort_exchange_strand_vector_sub(a, b))
}

pub fn sort_exchange_strand_vector_to_string(v : SortexchangestrandVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + sort_exchange_strand_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn sort_exchange_strand_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn sort_exchange_strand_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = sort_exchange_strand_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn sort_exchange_strand_std(data : Array[Double]) -> Double { sort_exchange_strand_sqrt(sort_exchange_strand_var(data)) }

pub fn sort_exchange_strand_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = sort_exchange_strand_mean(a); let mb = sort_exchange_strand_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn sort_exchange_strand_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = sort_exchange_strand_std(a); let sb = sort_exchange_strand_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { sort_exchange_strand_cov(a, b) / (sa * sb) }
}

pub fn sort_exchange_strand_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = sort_exchange_strand_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn sort_exchange_strand_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn sort_exchange_strand_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn sort_exchange_strand_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  sort_exchange_strand_sqrt(sort_exchange_strand_mse(pred, labels))
}

pub fn sort_exchange_strand_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + sort_exchange_strand_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn sort_exchange_strand_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = sort_exchange_strand_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn sort_exchange_strand_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn sort_exchange_strand_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn sort_exchange_strand_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = sort_exchange_strand_precision(pred, labels, pos); let r = sort_exchange_strand_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn sort_exchange_strand_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn sort_exchange_strand_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = sort_exchange_strand_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn sort_exchange_strand_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn sort_exchange_strand_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn sort_exchange_strand_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = sort_exchange_strand_gcd(a, b)
    (a / g) * b
  }
}

pub fn sort_exchange_strand_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn sort_exchange_strand_fibonacci(n : Int) -> Int {
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

pub fn sort_exchange_strand_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = sort_exchange_strand_min(data); let mx = sort_exchange_strand_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn sort_exchange_strand_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = sort_exchange_strand_mean(data); let sd = sort_exchange_strand_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn sort_exchange_strand_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn sort_exchange_strand_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn sort_exchange_strand_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn sort_exchange_strand_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn sort_exchange_strand_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn sort_exchange_strand_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn sort_exchange_strand_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn sort_exchange_strand_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn sort_exchange_strand_dbl(x : Double) -> String {
  let i = if x >= 0.0 { sort_exchange_strand_int(x) } else { -sort_exchange_strand_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { sort_exchange_strand_int(f * 1000000.0) } else { sort_exchange_strand_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn sort_exchange_strand_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn sort_exchange_strand_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct SortexchangestrandFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_strand_frame_make(size : Int) -> SortexchangestrandFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_strand_frame_len(s : SortexchangestrandFrame) -> Int { s.size }

pub fn sort_exchange_strand_frame_get(s : SortexchangestrandFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_strand_frame_set(s : SortexchangestrandFrame, i : Int, v : Double) -> SortexchangestrandFrame {
  let result = sort_exchange_strand_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_strand_frame_sum(s : SortexchangestrandFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_strand_frame_mean(s : SortexchangestrandFrame) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_strand_frame_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_strand_frame_scale(s : SortexchangestrandFrame, f : Double) -> SortexchangestrandFrame {
  let result = sort_exchange_strand_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_strand_frame_add(a : SortexchangestrandFrame, b : SortexchangestrandFrame) -> SortexchangestrandFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_strand_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_strand_frame_copy(s : SortexchangestrandFrame) -> SortexchangestrandFrame {
  let result = sort_exchange_strand_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_strand_frame_fill(s : SortexchangestrandFrame, v : Double) -> SortexchangestrandFrame {
  let result = sort_exchange_strand_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_strand_frame_min(s : SortexchangestrandFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_strand_frame_max(s : SortexchangestrandFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_strand_frame_to_string(s : SortexchangestrandFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangestrandTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_strand_table_make(size : Int) -> SortexchangestrandTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_strand_table_len(s : SortexchangestrandTable) -> Int { s.size }

pub fn sort_exchange_strand_table_get(s : SortexchangestrandTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_strand_table_set(s : SortexchangestrandTable, i : Int, v : Double) -> SortexchangestrandTable {
  let result = sort_exchange_strand_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_strand_table_sum(s : SortexchangestrandTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_strand_table_mean(s : SortexchangestrandTable) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_strand_table_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_strand_table_scale(s : SortexchangestrandTable, f : Double) -> SortexchangestrandTable {
  let result = sort_exchange_strand_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_strand_table_add(a : SortexchangestrandTable, b : SortexchangestrandTable) -> SortexchangestrandTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_strand_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_strand_table_copy(s : SortexchangestrandTable) -> SortexchangestrandTable {
  let result = sort_exchange_strand_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_strand_table_fill(s : SortexchangestrandTable, v : Double) -> SortexchangestrandTable {
  let result = sort_exchange_strand_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_strand_table_min(s : SortexchangestrandTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_strand_table_max(s : SortexchangestrandTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_strand_table_to_string(s : SortexchangestrandTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangestrandGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_strand_graphn_make(size : Int) -> SortexchangestrandGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_strand_graphn_len(s : SortexchangestrandGraphN) -> Int { s.size }

pub fn sort_exchange_strand_graphn_get(s : SortexchangestrandGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_strand_graphn_set(s : SortexchangestrandGraphN, i : Int, v : Double) -> SortexchangestrandGraphN {
  let result = sort_exchange_strand_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_strand_graphn_sum(s : SortexchangestrandGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_strand_graphn_mean(s : SortexchangestrandGraphN) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_strand_graphn_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_strand_graphn_scale(s : SortexchangestrandGraphN, f : Double) -> SortexchangestrandGraphN {
  let result = sort_exchange_strand_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_strand_graphn_add(a : SortexchangestrandGraphN, b : SortexchangestrandGraphN) -> SortexchangestrandGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_strand_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_strand_graphn_copy(s : SortexchangestrandGraphN) -> SortexchangestrandGraphN {
  let result = sort_exchange_strand_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_strand_graphn_fill(s : SortexchangestrandGraphN, v : Double) -> SortexchangestrandGraphN {
  let result = sort_exchange_strand_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_strand_graphn_min(s : SortexchangestrandGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_strand_graphn_max(s : SortexchangestrandGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_strand_graphn_to_string(s : SortexchangestrandGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangestrandNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_strand_node_make(size : Int) -> SortexchangestrandNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_strand_node_len(s : SortexchangestrandNode) -> Int { s.size }

pub fn sort_exchange_strand_node_get(s : SortexchangestrandNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_strand_node_set(s : SortexchangestrandNode, i : Int, v : Double) -> SortexchangestrandNode {
  let result = sort_exchange_strand_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_strand_node_sum(s : SortexchangestrandNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_strand_node_mean(s : SortexchangestrandNode) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_strand_node_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_strand_node_scale(s : SortexchangestrandNode, f : Double) -> SortexchangestrandNode {
  let result = sort_exchange_strand_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_strand_node_add(a : SortexchangestrandNode, b : SortexchangestrandNode) -> SortexchangestrandNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_strand_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_strand_node_copy(s : SortexchangestrandNode) -> SortexchangestrandNode {
  let result = sort_exchange_strand_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_strand_node_fill(s : SortexchangestrandNode, v : Double) -> SortexchangestrandNode {
  let result = sort_exchange_strand_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_strand_node_min(s : SortexchangestrandNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_strand_node_max(s : SortexchangestrandNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_strand_node_to_string(s : SortexchangestrandNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangestrandEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_strand_edge_make(size : Int) -> SortexchangestrandEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_strand_edge_len(s : SortexchangestrandEdge) -> Int { s.size }

pub fn sort_exchange_strand_edge_get(s : SortexchangestrandEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_strand_edge_set(s : SortexchangestrandEdge, i : Int, v : Double) -> SortexchangestrandEdge {
  let result = sort_exchange_strand_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_strand_edge_sum(s : SortexchangestrandEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_strand_edge_mean(s : SortexchangestrandEdge) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_strand_edge_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_strand_edge_scale(s : SortexchangestrandEdge, f : Double) -> SortexchangestrandEdge {
  let result = sort_exchange_strand_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_strand_edge_add(a : SortexchangestrandEdge, b : SortexchangestrandEdge) -> SortexchangestrandEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_strand_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_strand_edge_copy(s : SortexchangestrandEdge) -> SortexchangestrandEdge {
  let result = sort_exchange_strand_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_strand_edge_fill(s : SortexchangestrandEdge, v : Double) -> SortexchangestrandEdge {
  let result = sort_exchange_strand_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_strand_edge_min(s : SortexchangestrandEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_strand_edge_max(s : SortexchangestrandEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_strand_edge_to_string(s : SortexchangestrandEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangestrandPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_strand_path_make(size : Int) -> SortexchangestrandPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_strand_path_len(s : SortexchangestrandPath) -> Int { s.size }

pub fn sort_exchange_strand_path_get(s : SortexchangestrandPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_strand_path_set(s : SortexchangestrandPath, i : Int, v : Double) -> SortexchangestrandPath {
  let result = sort_exchange_strand_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_strand_path_sum(s : SortexchangestrandPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_strand_path_mean(s : SortexchangestrandPath) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_strand_path_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_strand_path_scale(s : SortexchangestrandPath, f : Double) -> SortexchangestrandPath {
  let result = sort_exchange_strand_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_strand_path_add(a : SortexchangestrandPath, b : SortexchangestrandPath) -> SortexchangestrandPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_strand_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_strand_path_copy(s : SortexchangestrandPath) -> SortexchangestrandPath {
  let result = sort_exchange_strand_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_strand_path_fill(s : SortexchangestrandPath, v : Double) -> SortexchangestrandPath {
  let result = sort_exchange_strand_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_strand_path_min(s : SortexchangestrandPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_strand_path_max(s : SortexchangestrandPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_strand_path_to_string(s : SortexchangestrandPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangestrandCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_strand_cluster_make(size : Int) -> SortexchangestrandCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_strand_cluster_len(s : SortexchangestrandCluster) -> Int { s.size }

pub fn sort_exchange_strand_cluster_get(s : SortexchangestrandCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_strand_cluster_set(s : SortexchangestrandCluster, i : Int, v : Double) -> SortexchangestrandCluster {
  let result = sort_exchange_strand_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_strand_cluster_sum(s : SortexchangestrandCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_strand_cluster_mean(s : SortexchangestrandCluster) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_strand_cluster_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_strand_cluster_scale(s : SortexchangestrandCluster, f : Double) -> SortexchangestrandCluster {
  let result = sort_exchange_strand_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_strand_cluster_add(a : SortexchangestrandCluster, b : SortexchangestrandCluster) -> SortexchangestrandCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_strand_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_strand_cluster_copy(s : SortexchangestrandCluster) -> SortexchangestrandCluster {
  let result = sort_exchange_strand_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_strand_cluster_fill(s : SortexchangestrandCluster, v : Double) -> SortexchangestrandCluster {
  let result = sort_exchange_strand_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_strand_cluster_min(s : SortexchangestrandCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_strand_cluster_max(s : SortexchangestrandCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_strand_cluster_to_string(s : SortexchangestrandCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangestrandModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_strand_model_make(size : Int) -> SortexchangestrandModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_strand_model_len(s : SortexchangestrandModel) -> Int { s.size }

pub fn sort_exchange_strand_model_get(s : SortexchangestrandModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_strand_model_set(s : SortexchangestrandModel, i : Int, v : Double) -> SortexchangestrandModel {
  let result = sort_exchange_strand_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_strand_model_sum(s : SortexchangestrandModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_strand_model_mean(s : SortexchangestrandModel) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_strand_model_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_strand_model_scale(s : SortexchangestrandModel, f : Double) -> SortexchangestrandModel {
  let result = sort_exchange_strand_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_strand_model_add(a : SortexchangestrandModel, b : SortexchangestrandModel) -> SortexchangestrandModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_strand_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_strand_model_copy(s : SortexchangestrandModel) -> SortexchangestrandModel {
  let result = sort_exchange_strand_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_strand_model_fill(s : SortexchangestrandModel, v : Double) -> SortexchangestrandModel {
  let result = sort_exchange_strand_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_strand_model_min(s : SortexchangestrandModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_strand_model_max(s : SortexchangestrandModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_strand_model_to_string(s : SortexchangestrandModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangestrandLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_strand_layer_make(size : Int) -> SortexchangestrandLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_strand_layer_len(s : SortexchangestrandLayer) -> Int { s.size }

pub fn sort_exchange_strand_layer_get(s : SortexchangestrandLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_strand_layer_set(s : SortexchangestrandLayer, i : Int, v : Double) -> SortexchangestrandLayer {
  let result = sort_exchange_strand_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_strand_layer_sum(s : SortexchangestrandLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_strand_layer_mean(s : SortexchangestrandLayer) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_strand_layer_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_strand_layer_scale(s : SortexchangestrandLayer, f : Double) -> SortexchangestrandLayer {
  let result = sort_exchange_strand_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_strand_layer_add(a : SortexchangestrandLayer, b : SortexchangestrandLayer) -> SortexchangestrandLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_strand_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_strand_layer_copy(s : SortexchangestrandLayer) -> SortexchangestrandLayer {
  let result = sort_exchange_strand_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_strand_layer_fill(s : SortexchangestrandLayer, v : Double) -> SortexchangestrandLayer {
  let result = sort_exchange_strand_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_strand_layer_min(s : SortexchangestrandLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_strand_layer_max(s : SortexchangestrandLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_strand_layer_to_string(s : SortexchangestrandLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangestrandBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_strand_buffer_make(size : Int) -> SortexchangestrandBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_strand_buffer_len(s : SortexchangestrandBuffer) -> Int { s.size }

pub fn sort_exchange_strand_buffer_get(s : SortexchangestrandBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_strand_buffer_set(s : SortexchangestrandBuffer, i : Int, v : Double) -> SortexchangestrandBuffer {
  let result = sort_exchange_strand_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_strand_buffer_sum(s : SortexchangestrandBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_strand_buffer_mean(s : SortexchangestrandBuffer) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_strand_buffer_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_strand_buffer_scale(s : SortexchangestrandBuffer, f : Double) -> SortexchangestrandBuffer {
  let result = sort_exchange_strand_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_strand_buffer_add(a : SortexchangestrandBuffer, b : SortexchangestrandBuffer) -> SortexchangestrandBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_strand_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_strand_buffer_copy(s : SortexchangestrandBuffer) -> SortexchangestrandBuffer {
  let result = sort_exchange_strand_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_strand_buffer_fill(s : SortexchangestrandBuffer, v : Double) -> SortexchangestrandBuffer {
  let result = sort_exchange_strand_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_strand_buffer_min(s : SortexchangestrandBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_strand_buffer_max(s : SortexchangestrandBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_strand_buffer_to_string(s : SortexchangestrandBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangestrandCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_strand_cursor_make(size : Int) -> SortexchangestrandCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_strand_cursor_len(s : SortexchangestrandCursor) -> Int { s.size }

pub fn sort_exchange_strand_cursor_get(s : SortexchangestrandCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_strand_cursor_set(s : SortexchangestrandCursor, i : Int, v : Double) -> SortexchangestrandCursor {
  let result = sort_exchange_strand_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_strand_cursor_sum(s : SortexchangestrandCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_strand_cursor_mean(s : SortexchangestrandCursor) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_strand_cursor_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_strand_cursor_scale(s : SortexchangestrandCursor, f : Double) -> SortexchangestrandCursor {
  let result = sort_exchange_strand_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_strand_cursor_add(a : SortexchangestrandCursor, b : SortexchangestrandCursor) -> SortexchangestrandCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_strand_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_strand_cursor_copy(s : SortexchangestrandCursor) -> SortexchangestrandCursor {
  let result = sort_exchange_strand_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_strand_cursor_fill(s : SortexchangestrandCursor, v : Double) -> SortexchangestrandCursor {
  let result = sort_exchange_strand_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_strand_cursor_min(s : SortexchangestrandCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_strand_cursor_max(s : SortexchangestrandCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_strand_cursor_to_string(s : SortexchangestrandCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangestrandView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_strand_view_make(size : Int) -> SortexchangestrandView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_strand_view_len(s : SortexchangestrandView) -> Int { s.size }

pub fn sort_exchange_strand_view_get(s : SortexchangestrandView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_strand_view_set(s : SortexchangestrandView, i : Int, v : Double) -> SortexchangestrandView {
  let result = sort_exchange_strand_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_strand_view_sum(s : SortexchangestrandView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_strand_view_mean(s : SortexchangestrandView) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_strand_view_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_strand_view_scale(s : SortexchangestrandView, f : Double) -> SortexchangestrandView {
  let result = sort_exchange_strand_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_strand_view_add(a : SortexchangestrandView, b : SortexchangestrandView) -> SortexchangestrandView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_strand_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_strand_view_copy(s : SortexchangestrandView) -> SortexchangestrandView {
  let result = sort_exchange_strand_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_strand_view_fill(s : SortexchangestrandView, v : Double) -> SortexchangestrandView {
  let result = sort_exchange_strand_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_strand_view_min(s : SortexchangestrandView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_strand_view_max(s : SortexchangestrandView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_strand_view_to_string(s : SortexchangestrandView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangestrandRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_strand_range_make(size : Int) -> SortexchangestrandRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_strand_range_len(s : SortexchangestrandRange) -> Int { s.size }

pub fn sort_exchange_strand_range_get(s : SortexchangestrandRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_strand_range_set(s : SortexchangestrandRange, i : Int, v : Double) -> SortexchangestrandRange {
  let result = sort_exchange_strand_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_strand_range_sum(s : SortexchangestrandRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_strand_range_mean(s : SortexchangestrandRange) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_strand_range_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_strand_range_scale(s : SortexchangestrandRange, f : Double) -> SortexchangestrandRange {
  let result = sort_exchange_strand_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_strand_range_add(a : SortexchangestrandRange, b : SortexchangestrandRange) -> SortexchangestrandRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_strand_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_strand_range_copy(s : SortexchangestrandRange) -> SortexchangestrandRange {
  let result = sort_exchange_strand_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_strand_range_fill(s : SortexchangestrandRange, v : Double) -> SortexchangestrandRange {
  let result = sort_exchange_strand_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_strand_range_min(s : SortexchangestrandRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_strand_range_max(s : SortexchangestrandRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_strand_range_to_string(s : SortexchangestrandRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangestrandSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_strand_slice_make(size : Int) -> SortexchangestrandSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_strand_slice_len(s : SortexchangestrandSlice) -> Int { s.size }

pub fn sort_exchange_strand_slice_get(s : SortexchangestrandSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_strand_slice_set(s : SortexchangestrandSlice, i : Int, v : Double) -> SortexchangestrandSlice {
  let result = sort_exchange_strand_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_strand_slice_sum(s : SortexchangestrandSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_strand_slice_mean(s : SortexchangestrandSlice) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_strand_slice_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_strand_slice_scale(s : SortexchangestrandSlice, f : Double) -> SortexchangestrandSlice {
  let result = sort_exchange_strand_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_strand_slice_add(a : SortexchangestrandSlice, b : SortexchangestrandSlice) -> SortexchangestrandSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_strand_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_strand_slice_copy(s : SortexchangestrandSlice) -> SortexchangestrandSlice {
  let result = sort_exchange_strand_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_strand_slice_fill(s : SortexchangestrandSlice, v : Double) -> SortexchangestrandSlice {
  let result = sort_exchange_strand_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_strand_slice_min(s : SortexchangestrandSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_strand_slice_max(s : SortexchangestrandSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_strand_slice_to_string(s : SortexchangestrandSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn sort_exchange_strand_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_exchange_strand_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_exchange_strand_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_exchange_strand_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_exchange_strand_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_exchange_strand_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_exchange_strand_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_exchange_strand_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_exchange_strand_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_exchange_strand_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_exchange_strand_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_exchange_strand_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_exchange_strand_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_exchange_strand_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_exchange_strand_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_exchange_strand_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_exchange_strand_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_exchange_strand_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_exchange_strand_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_exchange_strand_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_exchange_strand_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_exchange_strand_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_exchange_strand_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_exchange_strand_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_exchange_strand_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}


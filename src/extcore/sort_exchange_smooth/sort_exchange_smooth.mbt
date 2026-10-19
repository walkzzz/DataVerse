///===
/// extcore/sort_exchange_smooth

pub(all) struct SortexchangesmoothPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn sort_exchange_smooth_make_point(x : Double, y : Double) -> SortexchangesmoothPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn sort_exchange_smooth_make_point3(x : Double, y : Double, z : Double) -> SortexchangesmoothPoint {
  { x, y, z, label: 0 }
}

pub fn sort_exchange_smooth_point_x(pt : SortexchangesmoothPoint) -> Double { pt.x }

pub fn sort_exchange_smooth_point_y(pt : SortexchangesmoothPoint) -> Double { pt.y }

pub fn sort_exchange_smooth_point_z(pt : SortexchangesmoothPoint) -> Double { pt.z }

pub fn sort_exchange_smooth_point_label(pt : SortexchangesmoothPoint) -> Int { pt.label }

pub fn sort_exchange_smooth_point_dist(a : SortexchangesmoothPoint, b : SortexchangesmoothPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn sort_exchange_smooth_point_add(a : SortexchangesmoothPoint, b : SortexchangesmoothPoint) -> SortexchangesmoothPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn sort_exchange_smooth_point_sub(a : SortexchangesmoothPoint, b : SortexchangesmoothPoint) -> SortexchangesmoothPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn sort_exchange_smooth_point_scale(pt : SortexchangesmoothPoint, s : Double) -> SortexchangesmoothPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn sort_exchange_smooth_point_dot(a : SortexchangesmoothPoint, b : SortexchangesmoothPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn sort_exchange_smooth_point_cross(a : SortexchangesmoothPoint, b : SortexchangesmoothPoint) -> SortexchangesmoothPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn sort_exchange_smooth_point_norm(pt : SortexchangesmoothPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn sort_exchange_smooth_point_normalize(pt : SortexchangesmoothPoint) -> SortexchangesmoothPoint {
  let n = sort_exchange_smooth_point_norm(pt)
  if n < 0.0000001 { pt } else { sort_exchange_smooth_point_scale(pt, 1.0 / n) }
}

pub fn sort_exchange_smooth_point_negate(pt : SortexchangesmoothPoint) -> SortexchangesmoothPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn sort_exchange_smooth_point_mid(a : SortexchangesmoothPoint, b : SortexchangesmoothPoint) -> SortexchangesmoothPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn sort_exchange_smooth_point_lerp(a : SortexchangesmoothPoint, b : SortexchangesmoothPoint, t : Double) -> SortexchangesmoothPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn sort_exchange_smooth_point_to_string(pt : SortexchangesmoothPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct SortexchangesmoothSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn sort_exchange_smooth_make_series(vals : Array[Double], name : String) -> SortexchangesmoothSeries {
  { vals, name, meta: 0 }
}

pub fn sort_exchange_smooth_series_len(s : SortexchangesmoothSeries) -> Int { s.vals.length() }

pub fn sort_exchange_smooth_series_sum(s : SortexchangesmoothSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn sort_exchange_smooth_series_mean(s : SortexchangesmoothSeries) -> Double {
  let n = sort_exchange_smooth_series_len(s)
  if n == 0 { 0.0 } else { sort_exchange_smooth_series_sum(s) / n.to_double() }
}

pub fn sort_exchange_smooth_series_min(s : SortexchangesmoothSeries) -> Double {
  let n = sort_exchange_smooth_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn sort_exchange_smooth_series_max(s : SortexchangesmoothSeries) -> Double {
  let n = sort_exchange_smooth_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn sort_exchange_smooth_series_range(s : SortexchangesmoothSeries) -> Double {
  sort_exchange_smooth_series_max(s) - sort_exchange_smooth_series_min(s)
}

pub fn sort_exchange_smooth_series_var(s : SortexchangesmoothSeries) -> Double {
  let n = sort_exchange_smooth_series_len(s)
  if n == 0 { 0.0 } else {
    let m = sort_exchange_smooth_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn sort_exchange_smooth_series_std(s : SortexchangesmoothSeries) -> Double { @_common.sqrt(sort_exchange_smooth_series_var(s)) }

pub fn sort_exchange_smooth_series_median(s : SortexchangesmoothSeries) -> Double {
  let n = sort_exchange_smooth_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = sort_exchange_smooth_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn sort_exchange_smooth_series_scale(s : SortexchangesmoothSeries, f : Double) -> SortexchangesmoothSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn sort_exchange_smooth_series_add(a : SortexchangesmoothSeries, b : SortexchangesmoothSeries) -> SortexchangesmoothSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn sort_exchange_smooth_series_sub(a : SortexchangesmoothSeries, b : SortexchangesmoothSeries) -> SortexchangesmoothSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn sort_exchange_smooth_series_normalize(s : SortexchangesmoothSeries) -> SortexchangesmoothSeries {
  let mn = sort_exchange_smooth_series_min(s)
  let mx = sort_exchange_smooth_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn sort_exchange_smooth_series_cumsum(s : SortexchangesmoothSeries) -> SortexchangesmoothSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn sort_exchange_smooth_series_to_string(s : SortexchangesmoothSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SortexchangesmoothMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn sort_exchange_smooth_make_matrix(rows : Int, cols : Int, val : Double) -> SortexchangesmoothMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn sort_exchange_smooth_matrix_identity(n : Int) -> SortexchangesmoothMatrix {
  let m = sort_exchange_smooth_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn sort_exchange_smooth_matrix_get(m : SortexchangesmoothMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn sort_exchange_smooth_matrix_transpose(m : SortexchangesmoothMatrix) -> SortexchangesmoothMatrix {
  let result = sort_exchange_smooth_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn sort_exchange_smooth_matrix_add(a : SortexchangesmoothMatrix, b : SortexchangesmoothMatrix) -> SortexchangesmoothMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = sort_exchange_smooth_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn sort_exchange_smooth_matrix_scale(m : SortexchangesmoothMatrix, s : Double) -> SortexchangesmoothMatrix {
  let result = sort_exchange_smooth_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn sort_exchange_smooth_matrix_multiply(a : SortexchangesmoothMatrix, b : SortexchangesmoothMatrix) -> SortexchangesmoothMatrix {
  if a.cols != b.rows { return sort_exchange_smooth_make_matrix(a.rows, b.cols, 0.0) }
  let result = sort_exchange_smooth_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn sort_exchange_smooth_matrix_trace(m : SortexchangesmoothMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn sort_exchange_smooth_matrix_det(m : SortexchangesmoothMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn sort_exchange_smooth_matrix_norm(m : SortexchangesmoothMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn sort_exchange_smooth_matrix_to_string(m : SortexchangesmoothMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + @_common.dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct SortexchangesmoothVector {
  comps : Array[Double]
  dim : Int
}

pub fn sort_exchange_smooth_make_vector(comps : Array[Double]) -> SortexchangesmoothVector {
  { comps, dim: comps.length() }
}

pub fn sort_exchange_smooth_vector_zero(dim : Int) -> SortexchangesmoothVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn sort_exchange_smooth_vector_add(a : SortexchangesmoothVector, b : SortexchangesmoothVector) -> SortexchangesmoothVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn sort_exchange_smooth_vector_sub(a : SortexchangesmoothVector, b : SortexchangesmoothVector) -> SortexchangesmoothVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn sort_exchange_smooth_vector_scale(v : SortexchangesmoothVector, s : Double) -> SortexchangesmoothVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn sort_exchange_smooth_vector_dot(a : SortexchangesmoothVector, b : SortexchangesmoothVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn sort_exchange_smooth_vector_norm(v : SortexchangesmoothVector) -> Double { @_common.sqrt(sort_exchange_smooth_vector_dot(v, v)) }

pub fn sort_exchange_smooth_vector_normalize(v : SortexchangesmoothVector) -> SortexchangesmoothVector {
  let n = sort_exchange_smooth_vector_norm(v)
  if n < 0.0000001 { v } else { sort_exchange_smooth_vector_scale(v, 1.0 / n) }
}

pub fn sort_exchange_smooth_vector_dist(a : SortexchangesmoothVector, b : SortexchangesmoothVector) -> Double {
  sort_exchange_smooth_vector_norm(sort_exchange_smooth_vector_sub(a, b))
}

pub fn sort_exchange_smooth_vector_to_string(v : SortexchangesmoothVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn sort_exchange_smooth_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn sort_exchange_smooth_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = sort_exchange_smooth_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn sort_exchange_smooth_std(data : Array[Double]) -> Double { @_common.sqrt(sort_exchange_smooth_var(data)) }

pub fn sort_exchange_smooth_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = sort_exchange_smooth_mean(a); let mb = sort_exchange_smooth_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn sort_exchange_smooth_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = sort_exchange_smooth_std(a); let sb = sort_exchange_smooth_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { sort_exchange_smooth_cov(a, b) / (sa * sb) }
}

pub fn sort_exchange_smooth_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = sort_exchange_smooth_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn sort_exchange_smooth_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn sort_exchange_smooth_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn sort_exchange_smooth_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(sort_exchange_smooth_mse(pred, labels))
}

pub fn sort_exchange_smooth_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn sort_exchange_smooth_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = sort_exchange_smooth_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn sort_exchange_smooth_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn sort_exchange_smooth_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn sort_exchange_smooth_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = sort_exchange_smooth_precision(pred, labels, pos); let r = sort_exchange_smooth_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn sort_exchange_smooth_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn sort_exchange_smooth_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = sort_exchange_smooth_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn sort_exchange_smooth_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn sort_exchange_smooth_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn sort_exchange_smooth_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = sort_exchange_smooth_gcd(a, b)
    (a / g) * b
  }
}

pub fn sort_exchange_smooth_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn sort_exchange_smooth_fibonacci(n : Int) -> Int {
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

pub fn sort_exchange_smooth_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = sort_exchange_smooth_min(data); let mx = sort_exchange_smooth_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn sort_exchange_smooth_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = sort_exchange_smooth_mean(data); let sd = sort_exchange_smooth_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn sort_exchange_smooth_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn sort_exchange_smooth_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn sort_exchange_smooth_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn sort_exchange_smooth_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn sort_exchange_smooth_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn sort_exchange_smooth_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct SortexchangesmoothFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_smooth_frame_make(size : Int) -> SortexchangesmoothFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_smooth_frame_len(s : SortexchangesmoothFrame) -> Int { s.size }

pub fn sort_exchange_smooth_frame_get(s : SortexchangesmoothFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_smooth_frame_set(s : SortexchangesmoothFrame, i : Int, v : Double) -> SortexchangesmoothFrame {
  let result = sort_exchange_smooth_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_smooth_frame_sum(s : SortexchangesmoothFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_smooth_frame_mean(s : SortexchangesmoothFrame) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_smooth_frame_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_smooth_frame_scale(s : SortexchangesmoothFrame, f : Double) -> SortexchangesmoothFrame {
  let result = sort_exchange_smooth_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_smooth_frame_add(a : SortexchangesmoothFrame, b : SortexchangesmoothFrame) -> SortexchangesmoothFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_smooth_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_smooth_frame_copy(s : SortexchangesmoothFrame) -> SortexchangesmoothFrame {
  let result = sort_exchange_smooth_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_smooth_frame_fill(s : SortexchangesmoothFrame, v : Double) -> SortexchangesmoothFrame {
  let result = sort_exchange_smooth_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_smooth_frame_min(s : SortexchangesmoothFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_smooth_frame_max(s : SortexchangesmoothFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_smooth_frame_to_string(s : SortexchangesmoothFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangesmoothTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_smooth_table_make(size : Int) -> SortexchangesmoothTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_smooth_table_len(s : SortexchangesmoothTable) -> Int { s.size }

pub fn sort_exchange_smooth_table_get(s : SortexchangesmoothTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_smooth_table_set(s : SortexchangesmoothTable, i : Int, v : Double) -> SortexchangesmoothTable {
  let result = sort_exchange_smooth_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_smooth_table_sum(s : SortexchangesmoothTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_smooth_table_mean(s : SortexchangesmoothTable) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_smooth_table_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_smooth_table_scale(s : SortexchangesmoothTable, f : Double) -> SortexchangesmoothTable {
  let result = sort_exchange_smooth_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_smooth_table_add(a : SortexchangesmoothTable, b : SortexchangesmoothTable) -> SortexchangesmoothTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_smooth_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_smooth_table_copy(s : SortexchangesmoothTable) -> SortexchangesmoothTable {
  let result = sort_exchange_smooth_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_smooth_table_fill(s : SortexchangesmoothTable, v : Double) -> SortexchangesmoothTable {
  let result = sort_exchange_smooth_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_smooth_table_min(s : SortexchangesmoothTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_smooth_table_max(s : SortexchangesmoothTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_smooth_table_to_string(s : SortexchangesmoothTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangesmoothGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_smooth_graphn_make(size : Int) -> SortexchangesmoothGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_smooth_graphn_len(s : SortexchangesmoothGraphN) -> Int { s.size }

pub fn sort_exchange_smooth_graphn_get(s : SortexchangesmoothGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_smooth_graphn_set(s : SortexchangesmoothGraphN, i : Int, v : Double) -> SortexchangesmoothGraphN {
  let result = sort_exchange_smooth_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_smooth_graphn_sum(s : SortexchangesmoothGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_smooth_graphn_mean(s : SortexchangesmoothGraphN) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_smooth_graphn_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_smooth_graphn_scale(s : SortexchangesmoothGraphN, f : Double) -> SortexchangesmoothGraphN {
  let result = sort_exchange_smooth_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_smooth_graphn_add(a : SortexchangesmoothGraphN, b : SortexchangesmoothGraphN) -> SortexchangesmoothGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_smooth_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_smooth_graphn_copy(s : SortexchangesmoothGraphN) -> SortexchangesmoothGraphN {
  let result = sort_exchange_smooth_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_smooth_graphn_fill(s : SortexchangesmoothGraphN, v : Double) -> SortexchangesmoothGraphN {
  let result = sort_exchange_smooth_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_smooth_graphn_min(s : SortexchangesmoothGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_smooth_graphn_max(s : SortexchangesmoothGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_smooth_graphn_to_string(s : SortexchangesmoothGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangesmoothNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_smooth_node_make(size : Int) -> SortexchangesmoothNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_smooth_node_len(s : SortexchangesmoothNode) -> Int { s.size }

pub fn sort_exchange_smooth_node_get(s : SortexchangesmoothNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_smooth_node_set(s : SortexchangesmoothNode, i : Int, v : Double) -> SortexchangesmoothNode {
  let result = sort_exchange_smooth_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_smooth_node_sum(s : SortexchangesmoothNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_smooth_node_mean(s : SortexchangesmoothNode) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_smooth_node_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_smooth_node_scale(s : SortexchangesmoothNode, f : Double) -> SortexchangesmoothNode {
  let result = sort_exchange_smooth_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_smooth_node_add(a : SortexchangesmoothNode, b : SortexchangesmoothNode) -> SortexchangesmoothNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_smooth_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_smooth_node_copy(s : SortexchangesmoothNode) -> SortexchangesmoothNode {
  let result = sort_exchange_smooth_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_smooth_node_fill(s : SortexchangesmoothNode, v : Double) -> SortexchangesmoothNode {
  let result = sort_exchange_smooth_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_smooth_node_min(s : SortexchangesmoothNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_smooth_node_max(s : SortexchangesmoothNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_smooth_node_to_string(s : SortexchangesmoothNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangesmoothEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_smooth_edge_make(size : Int) -> SortexchangesmoothEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_smooth_edge_len(s : SortexchangesmoothEdge) -> Int { s.size }

pub fn sort_exchange_smooth_edge_get(s : SortexchangesmoothEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_smooth_edge_set(s : SortexchangesmoothEdge, i : Int, v : Double) -> SortexchangesmoothEdge {
  let result = sort_exchange_smooth_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_smooth_edge_sum(s : SortexchangesmoothEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_smooth_edge_mean(s : SortexchangesmoothEdge) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_smooth_edge_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_smooth_edge_scale(s : SortexchangesmoothEdge, f : Double) -> SortexchangesmoothEdge {
  let result = sort_exchange_smooth_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_smooth_edge_add(a : SortexchangesmoothEdge, b : SortexchangesmoothEdge) -> SortexchangesmoothEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_smooth_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_smooth_edge_copy(s : SortexchangesmoothEdge) -> SortexchangesmoothEdge {
  let result = sort_exchange_smooth_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_smooth_edge_fill(s : SortexchangesmoothEdge, v : Double) -> SortexchangesmoothEdge {
  let result = sort_exchange_smooth_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_smooth_edge_min(s : SortexchangesmoothEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_smooth_edge_max(s : SortexchangesmoothEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_smooth_edge_to_string(s : SortexchangesmoothEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangesmoothPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_smooth_path_make(size : Int) -> SortexchangesmoothPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_smooth_path_len(s : SortexchangesmoothPath) -> Int { s.size }

pub fn sort_exchange_smooth_path_get(s : SortexchangesmoothPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_smooth_path_set(s : SortexchangesmoothPath, i : Int, v : Double) -> SortexchangesmoothPath {
  let result = sort_exchange_smooth_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_smooth_path_sum(s : SortexchangesmoothPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_smooth_path_mean(s : SortexchangesmoothPath) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_smooth_path_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_smooth_path_scale(s : SortexchangesmoothPath, f : Double) -> SortexchangesmoothPath {
  let result = sort_exchange_smooth_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_smooth_path_add(a : SortexchangesmoothPath, b : SortexchangesmoothPath) -> SortexchangesmoothPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_smooth_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_smooth_path_copy(s : SortexchangesmoothPath) -> SortexchangesmoothPath {
  let result = sort_exchange_smooth_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_smooth_path_fill(s : SortexchangesmoothPath, v : Double) -> SortexchangesmoothPath {
  let result = sort_exchange_smooth_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_smooth_path_min(s : SortexchangesmoothPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_smooth_path_max(s : SortexchangesmoothPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_smooth_path_to_string(s : SortexchangesmoothPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangesmoothCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_smooth_cluster_make(size : Int) -> SortexchangesmoothCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_smooth_cluster_len(s : SortexchangesmoothCluster) -> Int { s.size }

pub fn sort_exchange_smooth_cluster_get(s : SortexchangesmoothCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_smooth_cluster_set(s : SortexchangesmoothCluster, i : Int, v : Double) -> SortexchangesmoothCluster {
  let result = sort_exchange_smooth_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_smooth_cluster_sum(s : SortexchangesmoothCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_smooth_cluster_mean(s : SortexchangesmoothCluster) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_smooth_cluster_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_smooth_cluster_scale(s : SortexchangesmoothCluster, f : Double) -> SortexchangesmoothCluster {
  let result = sort_exchange_smooth_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_smooth_cluster_add(a : SortexchangesmoothCluster, b : SortexchangesmoothCluster) -> SortexchangesmoothCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_smooth_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_smooth_cluster_copy(s : SortexchangesmoothCluster) -> SortexchangesmoothCluster {
  let result = sort_exchange_smooth_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_smooth_cluster_fill(s : SortexchangesmoothCluster, v : Double) -> SortexchangesmoothCluster {
  let result = sort_exchange_smooth_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_smooth_cluster_min(s : SortexchangesmoothCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_smooth_cluster_max(s : SortexchangesmoothCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_smooth_cluster_to_string(s : SortexchangesmoothCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangesmoothModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_smooth_model_make(size : Int) -> SortexchangesmoothModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_smooth_model_len(s : SortexchangesmoothModel) -> Int { s.size }

pub fn sort_exchange_smooth_model_get(s : SortexchangesmoothModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_smooth_model_set(s : SortexchangesmoothModel, i : Int, v : Double) -> SortexchangesmoothModel {
  let result = sort_exchange_smooth_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_smooth_model_sum(s : SortexchangesmoothModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_smooth_model_mean(s : SortexchangesmoothModel) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_smooth_model_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_smooth_model_scale(s : SortexchangesmoothModel, f : Double) -> SortexchangesmoothModel {
  let result = sort_exchange_smooth_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_smooth_model_add(a : SortexchangesmoothModel, b : SortexchangesmoothModel) -> SortexchangesmoothModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_smooth_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_smooth_model_copy(s : SortexchangesmoothModel) -> SortexchangesmoothModel {
  let result = sort_exchange_smooth_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_smooth_model_fill(s : SortexchangesmoothModel, v : Double) -> SortexchangesmoothModel {
  let result = sort_exchange_smooth_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_smooth_model_min(s : SortexchangesmoothModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_smooth_model_max(s : SortexchangesmoothModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_smooth_model_to_string(s : SortexchangesmoothModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangesmoothLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_smooth_layer_make(size : Int) -> SortexchangesmoothLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_smooth_layer_len(s : SortexchangesmoothLayer) -> Int { s.size }

pub fn sort_exchange_smooth_layer_get(s : SortexchangesmoothLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_smooth_layer_set(s : SortexchangesmoothLayer, i : Int, v : Double) -> SortexchangesmoothLayer {
  let result = sort_exchange_smooth_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_smooth_layer_sum(s : SortexchangesmoothLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_smooth_layer_mean(s : SortexchangesmoothLayer) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_smooth_layer_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_smooth_layer_scale(s : SortexchangesmoothLayer, f : Double) -> SortexchangesmoothLayer {
  let result = sort_exchange_smooth_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_smooth_layer_add(a : SortexchangesmoothLayer, b : SortexchangesmoothLayer) -> SortexchangesmoothLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_smooth_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_smooth_layer_copy(s : SortexchangesmoothLayer) -> SortexchangesmoothLayer {
  let result = sort_exchange_smooth_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_smooth_layer_fill(s : SortexchangesmoothLayer, v : Double) -> SortexchangesmoothLayer {
  let result = sort_exchange_smooth_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_smooth_layer_min(s : SortexchangesmoothLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_smooth_layer_max(s : SortexchangesmoothLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_smooth_layer_to_string(s : SortexchangesmoothLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangesmoothBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_smooth_buffer_make(size : Int) -> SortexchangesmoothBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_smooth_buffer_len(s : SortexchangesmoothBuffer) -> Int { s.size }

pub fn sort_exchange_smooth_buffer_get(s : SortexchangesmoothBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_smooth_buffer_set(s : SortexchangesmoothBuffer, i : Int, v : Double) -> SortexchangesmoothBuffer {
  let result = sort_exchange_smooth_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_smooth_buffer_sum(s : SortexchangesmoothBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_smooth_buffer_mean(s : SortexchangesmoothBuffer) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_smooth_buffer_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_smooth_buffer_scale(s : SortexchangesmoothBuffer, f : Double) -> SortexchangesmoothBuffer {
  let result = sort_exchange_smooth_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_smooth_buffer_add(a : SortexchangesmoothBuffer, b : SortexchangesmoothBuffer) -> SortexchangesmoothBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_smooth_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_smooth_buffer_copy(s : SortexchangesmoothBuffer) -> SortexchangesmoothBuffer {
  let result = sort_exchange_smooth_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_smooth_buffer_fill(s : SortexchangesmoothBuffer, v : Double) -> SortexchangesmoothBuffer {
  let result = sort_exchange_smooth_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_smooth_buffer_min(s : SortexchangesmoothBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_smooth_buffer_max(s : SortexchangesmoothBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_smooth_buffer_to_string(s : SortexchangesmoothBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangesmoothCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_smooth_cursor_make(size : Int) -> SortexchangesmoothCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_smooth_cursor_len(s : SortexchangesmoothCursor) -> Int { s.size }

pub fn sort_exchange_smooth_cursor_get(s : SortexchangesmoothCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_smooth_cursor_set(s : SortexchangesmoothCursor, i : Int, v : Double) -> SortexchangesmoothCursor {
  let result = sort_exchange_smooth_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_smooth_cursor_sum(s : SortexchangesmoothCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_smooth_cursor_mean(s : SortexchangesmoothCursor) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_smooth_cursor_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_smooth_cursor_scale(s : SortexchangesmoothCursor, f : Double) -> SortexchangesmoothCursor {
  let result = sort_exchange_smooth_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_smooth_cursor_add(a : SortexchangesmoothCursor, b : SortexchangesmoothCursor) -> SortexchangesmoothCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_smooth_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_smooth_cursor_copy(s : SortexchangesmoothCursor) -> SortexchangesmoothCursor {
  let result = sort_exchange_smooth_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_smooth_cursor_fill(s : SortexchangesmoothCursor, v : Double) -> SortexchangesmoothCursor {
  let result = sort_exchange_smooth_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_smooth_cursor_min(s : SortexchangesmoothCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_smooth_cursor_max(s : SortexchangesmoothCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_smooth_cursor_to_string(s : SortexchangesmoothCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangesmoothView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_smooth_view_make(size : Int) -> SortexchangesmoothView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_smooth_view_len(s : SortexchangesmoothView) -> Int { s.size }

pub fn sort_exchange_smooth_view_get(s : SortexchangesmoothView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_smooth_view_set(s : SortexchangesmoothView, i : Int, v : Double) -> SortexchangesmoothView {
  let result = sort_exchange_smooth_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_smooth_view_sum(s : SortexchangesmoothView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_smooth_view_mean(s : SortexchangesmoothView) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_smooth_view_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_smooth_view_scale(s : SortexchangesmoothView, f : Double) -> SortexchangesmoothView {
  let result = sort_exchange_smooth_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_smooth_view_add(a : SortexchangesmoothView, b : SortexchangesmoothView) -> SortexchangesmoothView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_smooth_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_smooth_view_copy(s : SortexchangesmoothView) -> SortexchangesmoothView {
  let result = sort_exchange_smooth_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_smooth_view_fill(s : SortexchangesmoothView, v : Double) -> SortexchangesmoothView {
  let result = sort_exchange_smooth_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_smooth_view_min(s : SortexchangesmoothView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_smooth_view_max(s : SortexchangesmoothView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_smooth_view_to_string(s : SortexchangesmoothView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangesmoothRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_smooth_range_make(size : Int) -> SortexchangesmoothRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_smooth_range_len(s : SortexchangesmoothRange) -> Int { s.size }

pub fn sort_exchange_smooth_range_get(s : SortexchangesmoothRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_smooth_range_set(s : SortexchangesmoothRange, i : Int, v : Double) -> SortexchangesmoothRange {
  let result = sort_exchange_smooth_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_smooth_range_sum(s : SortexchangesmoothRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_smooth_range_mean(s : SortexchangesmoothRange) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_smooth_range_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_smooth_range_scale(s : SortexchangesmoothRange, f : Double) -> SortexchangesmoothRange {
  let result = sort_exchange_smooth_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_smooth_range_add(a : SortexchangesmoothRange, b : SortexchangesmoothRange) -> SortexchangesmoothRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_smooth_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_smooth_range_copy(s : SortexchangesmoothRange) -> SortexchangesmoothRange {
  let result = sort_exchange_smooth_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_smooth_range_fill(s : SortexchangesmoothRange, v : Double) -> SortexchangesmoothRange {
  let result = sort_exchange_smooth_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_smooth_range_min(s : SortexchangesmoothRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_smooth_range_max(s : SortexchangesmoothRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_smooth_range_to_string(s : SortexchangesmoothRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangesmoothSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_smooth_slice_make(size : Int) -> SortexchangesmoothSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_smooth_slice_len(s : SortexchangesmoothSlice) -> Int { s.size }

pub fn sort_exchange_smooth_slice_get(s : SortexchangesmoothSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_smooth_slice_set(s : SortexchangesmoothSlice, i : Int, v : Double) -> SortexchangesmoothSlice {
  let result = sort_exchange_smooth_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_smooth_slice_sum(s : SortexchangesmoothSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_smooth_slice_mean(s : SortexchangesmoothSlice) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_smooth_slice_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_smooth_slice_scale(s : SortexchangesmoothSlice, f : Double) -> SortexchangesmoothSlice {
  let result = sort_exchange_smooth_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_smooth_slice_add(a : SortexchangesmoothSlice, b : SortexchangesmoothSlice) -> SortexchangesmoothSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_smooth_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_smooth_slice_copy(s : SortexchangesmoothSlice) -> SortexchangesmoothSlice {
  let result = sort_exchange_smooth_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_smooth_slice_fill(s : SortexchangesmoothSlice, v : Double) -> SortexchangesmoothSlice {
  let result = sort_exchange_smooth_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_smooth_slice_min(s : SortexchangesmoothSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_smooth_slice_max(s : SortexchangesmoothSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_smooth_slice_to_string(s : SortexchangesmoothSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


///===
/// extcore/sort_dist_proxmap

pub(all) struct SortdistproxmapPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn sort_dist_proxmap_make_point(x : Double, y : Double) -> SortdistproxmapPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn sort_dist_proxmap_make_point3(x : Double, y : Double, z : Double) -> SortdistproxmapPoint {
  { x, y, z, label: 0 }
}

pub fn sort_dist_proxmap_point_x(pt : SortdistproxmapPoint) -> Double { pt.x }

pub fn sort_dist_proxmap_point_y(pt : SortdistproxmapPoint) -> Double { pt.y }

pub fn sort_dist_proxmap_point_z(pt : SortdistproxmapPoint) -> Double { pt.z }

pub fn sort_dist_proxmap_point_label(pt : SortdistproxmapPoint) -> Int { pt.label }

pub fn sort_dist_proxmap_point_dist(a : SortdistproxmapPoint, b : SortdistproxmapPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn sort_dist_proxmap_point_add(a : SortdistproxmapPoint, b : SortdistproxmapPoint) -> SortdistproxmapPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn sort_dist_proxmap_point_sub(a : SortdistproxmapPoint, b : SortdistproxmapPoint) -> SortdistproxmapPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn sort_dist_proxmap_point_scale(pt : SortdistproxmapPoint, s : Double) -> SortdistproxmapPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn sort_dist_proxmap_point_dot(a : SortdistproxmapPoint, b : SortdistproxmapPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn sort_dist_proxmap_point_cross(a : SortdistproxmapPoint, b : SortdistproxmapPoint) -> SortdistproxmapPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn sort_dist_proxmap_point_norm(pt : SortdistproxmapPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn sort_dist_proxmap_point_normalize(pt : SortdistproxmapPoint) -> SortdistproxmapPoint {
  let n = sort_dist_proxmap_point_norm(pt)
  if n < 0.0000001 { pt } else { sort_dist_proxmap_point_scale(pt, 1.0 / n) }
}

pub fn sort_dist_proxmap_point_negate(pt : SortdistproxmapPoint) -> SortdistproxmapPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn sort_dist_proxmap_point_mid(a : SortdistproxmapPoint, b : SortdistproxmapPoint) -> SortdistproxmapPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn sort_dist_proxmap_point_lerp(a : SortdistproxmapPoint, b : SortdistproxmapPoint, t : Double) -> SortdistproxmapPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn sort_dist_proxmap_point_to_string(pt : SortdistproxmapPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct SortdistproxmapSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn sort_dist_proxmap_make_series(vals : Array[Double], name : String) -> SortdistproxmapSeries {
  { vals, name, meta: 0 }
}

pub fn sort_dist_proxmap_series_len(s : SortdistproxmapSeries) -> Int { s.vals.length() }

pub fn sort_dist_proxmap_series_sum(s : SortdistproxmapSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn sort_dist_proxmap_series_mean(s : SortdistproxmapSeries) -> Double {
  let n = sort_dist_proxmap_series_len(s)
  if n == 0 { 0.0 } else { sort_dist_proxmap_series_sum(s) / n.to_double() }
}

pub fn sort_dist_proxmap_series_min(s : SortdistproxmapSeries) -> Double {
  let n = sort_dist_proxmap_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn sort_dist_proxmap_series_max(s : SortdistproxmapSeries) -> Double {
  let n = sort_dist_proxmap_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn sort_dist_proxmap_series_range(s : SortdistproxmapSeries) -> Double {
  sort_dist_proxmap_series_max(s) - sort_dist_proxmap_series_min(s)
}

pub fn sort_dist_proxmap_series_var(s : SortdistproxmapSeries) -> Double {
  let n = sort_dist_proxmap_series_len(s)
  if n == 0 { 0.0 } else {
    let m = sort_dist_proxmap_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn sort_dist_proxmap_series_std(s : SortdistproxmapSeries) -> Double { @_common.sqrt(sort_dist_proxmap_series_var(s)) }

pub fn sort_dist_proxmap_series_median(s : SortdistproxmapSeries) -> Double {
  let n = sort_dist_proxmap_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = sort_dist_proxmap_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn sort_dist_proxmap_series_scale(s : SortdistproxmapSeries, f : Double) -> SortdistproxmapSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn sort_dist_proxmap_series_add(a : SortdistproxmapSeries, b : SortdistproxmapSeries) -> SortdistproxmapSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn sort_dist_proxmap_series_sub(a : SortdistproxmapSeries, b : SortdistproxmapSeries) -> SortdistproxmapSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn sort_dist_proxmap_series_normalize(s : SortdistproxmapSeries) -> SortdistproxmapSeries {
  let mn = sort_dist_proxmap_series_min(s)
  let mx = sort_dist_proxmap_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn sort_dist_proxmap_series_cumsum(s : SortdistproxmapSeries) -> SortdistproxmapSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn sort_dist_proxmap_series_to_string(s : SortdistproxmapSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SortdistproxmapMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn sort_dist_proxmap_make_matrix(rows : Int, cols : Int, val : Double) -> SortdistproxmapMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn sort_dist_proxmap_matrix_identity(n : Int) -> SortdistproxmapMatrix {
  let m = sort_dist_proxmap_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn sort_dist_proxmap_matrix_get(m : SortdistproxmapMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn sort_dist_proxmap_matrix_transpose(m : SortdistproxmapMatrix) -> SortdistproxmapMatrix {
  let result = sort_dist_proxmap_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn sort_dist_proxmap_matrix_add(a : SortdistproxmapMatrix, b : SortdistproxmapMatrix) -> SortdistproxmapMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = sort_dist_proxmap_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn sort_dist_proxmap_matrix_scale(m : SortdistproxmapMatrix, s : Double) -> SortdistproxmapMatrix {
  let result = sort_dist_proxmap_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn sort_dist_proxmap_matrix_multiply(a : SortdistproxmapMatrix, b : SortdistproxmapMatrix) -> SortdistproxmapMatrix {
  if a.cols != b.rows { return sort_dist_proxmap_make_matrix(a.rows, b.cols, 0.0) }
  let result = sort_dist_proxmap_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn sort_dist_proxmap_matrix_trace(m : SortdistproxmapMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn sort_dist_proxmap_matrix_det(m : SortdistproxmapMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn sort_dist_proxmap_matrix_norm(m : SortdistproxmapMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn sort_dist_proxmap_matrix_to_string(m : SortdistproxmapMatrix) -> String {
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

pub(all) struct SortdistproxmapVector {
  comps : Array[Double]
  dim : Int
}

pub fn sort_dist_proxmap_make_vector(comps : Array[Double]) -> SortdistproxmapVector {
  { comps, dim: comps.length() }
}

pub fn sort_dist_proxmap_vector_zero(dim : Int) -> SortdistproxmapVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn sort_dist_proxmap_vector_add(a : SortdistproxmapVector, b : SortdistproxmapVector) -> SortdistproxmapVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn sort_dist_proxmap_vector_sub(a : SortdistproxmapVector, b : SortdistproxmapVector) -> SortdistproxmapVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn sort_dist_proxmap_vector_scale(v : SortdistproxmapVector, s : Double) -> SortdistproxmapVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn sort_dist_proxmap_vector_dot(a : SortdistproxmapVector, b : SortdistproxmapVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn sort_dist_proxmap_vector_norm(v : SortdistproxmapVector) -> Double { @_common.sqrt(sort_dist_proxmap_vector_dot(v, v)) }

pub fn sort_dist_proxmap_vector_normalize(v : SortdistproxmapVector) -> SortdistproxmapVector {
  let n = sort_dist_proxmap_vector_norm(v)
  if n < 0.0000001 { v } else { sort_dist_proxmap_vector_scale(v, 1.0 / n) }
}

pub fn sort_dist_proxmap_vector_dist(a : SortdistproxmapVector, b : SortdistproxmapVector) -> Double {
  sort_dist_proxmap_vector_norm(sort_dist_proxmap_vector_sub(a, b))
}

pub fn sort_dist_proxmap_vector_to_string(v : SortdistproxmapVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn sort_dist_proxmap_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn sort_dist_proxmap_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = sort_dist_proxmap_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn sort_dist_proxmap_std(data : Array[Double]) -> Double { @_common.sqrt(sort_dist_proxmap_var(data)) }

pub fn sort_dist_proxmap_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = sort_dist_proxmap_mean(a); let mb = sort_dist_proxmap_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn sort_dist_proxmap_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = sort_dist_proxmap_std(a); let sb = sort_dist_proxmap_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { sort_dist_proxmap_cov(a, b) / (sa * sb) }
}

pub fn sort_dist_proxmap_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = sort_dist_proxmap_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn sort_dist_proxmap_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn sort_dist_proxmap_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn sort_dist_proxmap_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(sort_dist_proxmap_mse(pred, labels))
}

pub fn sort_dist_proxmap_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn sort_dist_proxmap_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = sort_dist_proxmap_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn sort_dist_proxmap_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn sort_dist_proxmap_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn sort_dist_proxmap_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = sort_dist_proxmap_precision(pred, labels, pos); let r = sort_dist_proxmap_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn sort_dist_proxmap_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn sort_dist_proxmap_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = sort_dist_proxmap_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn sort_dist_proxmap_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn sort_dist_proxmap_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn sort_dist_proxmap_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = sort_dist_proxmap_gcd(a, b)
    (a / g) * b
  }
}

pub fn sort_dist_proxmap_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn sort_dist_proxmap_fibonacci(n : Int) -> Int {
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

pub fn sort_dist_proxmap_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = sort_dist_proxmap_min(data); let mx = sort_dist_proxmap_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn sort_dist_proxmap_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = sort_dist_proxmap_mean(data); let sd = sort_dist_proxmap_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn sort_dist_proxmap_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn sort_dist_proxmap_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn sort_dist_proxmap_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn sort_dist_proxmap_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn sort_dist_proxmap_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn sort_dist_proxmap_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct SortdistproxmapFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_proxmap_frame_make(size : Int) -> SortdistproxmapFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_proxmap_frame_len(s : SortdistproxmapFrame) -> Int { s.size }

pub fn sort_dist_proxmap_frame_get(s : SortdistproxmapFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_proxmap_frame_set(s : SortdistproxmapFrame, i : Int, v : Double) -> SortdistproxmapFrame {
  let result = sort_dist_proxmap_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_dist_proxmap_frame_sum(s : SortdistproxmapFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_dist_proxmap_frame_mean(s : SortdistproxmapFrame) -> Double {
  if s.size == 0 { 0.0 } else { sort_dist_proxmap_frame_sum(s) / s.size.to_double() }
}

pub fn sort_dist_proxmap_frame_scale(s : SortdistproxmapFrame, f : Double) -> SortdistproxmapFrame {
  let result = sort_dist_proxmap_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_dist_proxmap_frame_add(a : SortdistproxmapFrame, b : SortdistproxmapFrame) -> SortdistproxmapFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_dist_proxmap_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_dist_proxmap_frame_copy(s : SortdistproxmapFrame) -> SortdistproxmapFrame {
  let result = sort_dist_proxmap_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_dist_proxmap_frame_fill(s : SortdistproxmapFrame, v : Double) -> SortdistproxmapFrame {
  let result = sort_dist_proxmap_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_dist_proxmap_frame_min(s : SortdistproxmapFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_proxmap_frame_max(s : SortdistproxmapFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_proxmap_frame_to_string(s : SortdistproxmapFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistproxmapTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_proxmap_table_make(size : Int) -> SortdistproxmapTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_proxmap_table_len(s : SortdistproxmapTable) -> Int { s.size }

pub fn sort_dist_proxmap_table_get(s : SortdistproxmapTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_proxmap_table_set(s : SortdistproxmapTable, i : Int, v : Double) -> SortdistproxmapTable {
  let result = sort_dist_proxmap_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_dist_proxmap_table_sum(s : SortdistproxmapTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_dist_proxmap_table_mean(s : SortdistproxmapTable) -> Double {
  if s.size == 0 { 0.0 } else { sort_dist_proxmap_table_sum(s) / s.size.to_double() }
}

pub fn sort_dist_proxmap_table_scale(s : SortdistproxmapTable, f : Double) -> SortdistproxmapTable {
  let result = sort_dist_proxmap_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_dist_proxmap_table_add(a : SortdistproxmapTable, b : SortdistproxmapTable) -> SortdistproxmapTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_dist_proxmap_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_dist_proxmap_table_copy(s : SortdistproxmapTable) -> SortdistproxmapTable {
  let result = sort_dist_proxmap_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_dist_proxmap_table_fill(s : SortdistproxmapTable, v : Double) -> SortdistproxmapTable {
  let result = sort_dist_proxmap_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_dist_proxmap_table_min(s : SortdistproxmapTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_proxmap_table_max(s : SortdistproxmapTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_proxmap_table_to_string(s : SortdistproxmapTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistproxmapGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_proxmap_graphn_make(size : Int) -> SortdistproxmapGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_proxmap_graphn_len(s : SortdistproxmapGraphN) -> Int { s.size }

pub fn sort_dist_proxmap_graphn_get(s : SortdistproxmapGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_proxmap_graphn_set(s : SortdistproxmapGraphN, i : Int, v : Double) -> SortdistproxmapGraphN {
  let result = sort_dist_proxmap_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_dist_proxmap_graphn_sum(s : SortdistproxmapGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_dist_proxmap_graphn_mean(s : SortdistproxmapGraphN) -> Double {
  if s.size == 0 { 0.0 } else { sort_dist_proxmap_graphn_sum(s) / s.size.to_double() }
}

pub fn sort_dist_proxmap_graphn_scale(s : SortdistproxmapGraphN, f : Double) -> SortdistproxmapGraphN {
  let result = sort_dist_proxmap_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_dist_proxmap_graphn_add(a : SortdistproxmapGraphN, b : SortdistproxmapGraphN) -> SortdistproxmapGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_dist_proxmap_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_dist_proxmap_graphn_copy(s : SortdistproxmapGraphN) -> SortdistproxmapGraphN {
  let result = sort_dist_proxmap_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_dist_proxmap_graphn_fill(s : SortdistproxmapGraphN, v : Double) -> SortdistproxmapGraphN {
  let result = sort_dist_proxmap_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_dist_proxmap_graphn_min(s : SortdistproxmapGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_proxmap_graphn_max(s : SortdistproxmapGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_proxmap_graphn_to_string(s : SortdistproxmapGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistproxmapNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_proxmap_node_make(size : Int) -> SortdistproxmapNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_proxmap_node_len(s : SortdistproxmapNode) -> Int { s.size }

pub fn sort_dist_proxmap_node_get(s : SortdistproxmapNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_proxmap_node_set(s : SortdistproxmapNode, i : Int, v : Double) -> SortdistproxmapNode {
  let result = sort_dist_proxmap_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_dist_proxmap_node_sum(s : SortdistproxmapNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_dist_proxmap_node_mean(s : SortdistproxmapNode) -> Double {
  if s.size == 0 { 0.0 } else { sort_dist_proxmap_node_sum(s) / s.size.to_double() }
}

pub fn sort_dist_proxmap_node_scale(s : SortdistproxmapNode, f : Double) -> SortdistproxmapNode {
  let result = sort_dist_proxmap_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_dist_proxmap_node_add(a : SortdistproxmapNode, b : SortdistproxmapNode) -> SortdistproxmapNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_dist_proxmap_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_dist_proxmap_node_copy(s : SortdistproxmapNode) -> SortdistproxmapNode {
  let result = sort_dist_proxmap_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_dist_proxmap_node_fill(s : SortdistproxmapNode, v : Double) -> SortdistproxmapNode {
  let result = sort_dist_proxmap_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_dist_proxmap_node_min(s : SortdistproxmapNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_proxmap_node_max(s : SortdistproxmapNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_proxmap_node_to_string(s : SortdistproxmapNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistproxmapEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_proxmap_edge_make(size : Int) -> SortdistproxmapEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_proxmap_edge_len(s : SortdistproxmapEdge) -> Int { s.size }

pub fn sort_dist_proxmap_edge_get(s : SortdistproxmapEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_proxmap_edge_set(s : SortdistproxmapEdge, i : Int, v : Double) -> SortdistproxmapEdge {
  let result = sort_dist_proxmap_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_dist_proxmap_edge_sum(s : SortdistproxmapEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_dist_proxmap_edge_mean(s : SortdistproxmapEdge) -> Double {
  if s.size == 0 { 0.0 } else { sort_dist_proxmap_edge_sum(s) / s.size.to_double() }
}

pub fn sort_dist_proxmap_edge_scale(s : SortdistproxmapEdge, f : Double) -> SortdistproxmapEdge {
  let result = sort_dist_proxmap_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_dist_proxmap_edge_add(a : SortdistproxmapEdge, b : SortdistproxmapEdge) -> SortdistproxmapEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_dist_proxmap_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_dist_proxmap_edge_copy(s : SortdistproxmapEdge) -> SortdistproxmapEdge {
  let result = sort_dist_proxmap_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_dist_proxmap_edge_fill(s : SortdistproxmapEdge, v : Double) -> SortdistproxmapEdge {
  let result = sort_dist_proxmap_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_dist_proxmap_edge_min(s : SortdistproxmapEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_proxmap_edge_max(s : SortdistproxmapEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_proxmap_edge_to_string(s : SortdistproxmapEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistproxmapPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_proxmap_path_make(size : Int) -> SortdistproxmapPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_proxmap_path_len(s : SortdistproxmapPath) -> Int { s.size }

pub fn sort_dist_proxmap_path_get(s : SortdistproxmapPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_proxmap_path_set(s : SortdistproxmapPath, i : Int, v : Double) -> SortdistproxmapPath {
  let result = sort_dist_proxmap_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_dist_proxmap_path_sum(s : SortdistproxmapPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_dist_proxmap_path_mean(s : SortdistproxmapPath) -> Double {
  if s.size == 0 { 0.0 } else { sort_dist_proxmap_path_sum(s) / s.size.to_double() }
}

pub fn sort_dist_proxmap_path_scale(s : SortdistproxmapPath, f : Double) -> SortdistproxmapPath {
  let result = sort_dist_proxmap_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_dist_proxmap_path_add(a : SortdistproxmapPath, b : SortdistproxmapPath) -> SortdistproxmapPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_dist_proxmap_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_dist_proxmap_path_copy(s : SortdistproxmapPath) -> SortdistproxmapPath {
  let result = sort_dist_proxmap_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_dist_proxmap_path_fill(s : SortdistproxmapPath, v : Double) -> SortdistproxmapPath {
  let result = sort_dist_proxmap_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_dist_proxmap_path_min(s : SortdistproxmapPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_proxmap_path_max(s : SortdistproxmapPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_proxmap_path_to_string(s : SortdistproxmapPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistproxmapCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_proxmap_cluster_make(size : Int) -> SortdistproxmapCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_proxmap_cluster_len(s : SortdistproxmapCluster) -> Int { s.size }

pub fn sort_dist_proxmap_cluster_get(s : SortdistproxmapCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_proxmap_cluster_set(s : SortdistproxmapCluster, i : Int, v : Double) -> SortdistproxmapCluster {
  let result = sort_dist_proxmap_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_dist_proxmap_cluster_sum(s : SortdistproxmapCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_dist_proxmap_cluster_mean(s : SortdistproxmapCluster) -> Double {
  if s.size == 0 { 0.0 } else { sort_dist_proxmap_cluster_sum(s) / s.size.to_double() }
}

pub fn sort_dist_proxmap_cluster_scale(s : SortdistproxmapCluster, f : Double) -> SortdistproxmapCluster {
  let result = sort_dist_proxmap_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_dist_proxmap_cluster_add(a : SortdistproxmapCluster, b : SortdistproxmapCluster) -> SortdistproxmapCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_dist_proxmap_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_dist_proxmap_cluster_copy(s : SortdistproxmapCluster) -> SortdistproxmapCluster {
  let result = sort_dist_proxmap_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_dist_proxmap_cluster_fill(s : SortdistproxmapCluster, v : Double) -> SortdistproxmapCluster {
  let result = sort_dist_proxmap_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_dist_proxmap_cluster_min(s : SortdistproxmapCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_proxmap_cluster_max(s : SortdistproxmapCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_proxmap_cluster_to_string(s : SortdistproxmapCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistproxmapModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_proxmap_model_make(size : Int) -> SortdistproxmapModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_proxmap_model_len(s : SortdistproxmapModel) -> Int { s.size }

pub fn sort_dist_proxmap_model_get(s : SortdistproxmapModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_proxmap_model_set(s : SortdistproxmapModel, i : Int, v : Double) -> SortdistproxmapModel {
  let result = sort_dist_proxmap_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_dist_proxmap_model_sum(s : SortdistproxmapModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_dist_proxmap_model_mean(s : SortdistproxmapModel) -> Double {
  if s.size == 0 { 0.0 } else { sort_dist_proxmap_model_sum(s) / s.size.to_double() }
}

pub fn sort_dist_proxmap_model_scale(s : SortdistproxmapModel, f : Double) -> SortdistproxmapModel {
  let result = sort_dist_proxmap_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_dist_proxmap_model_add(a : SortdistproxmapModel, b : SortdistproxmapModel) -> SortdistproxmapModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_dist_proxmap_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_dist_proxmap_model_copy(s : SortdistproxmapModel) -> SortdistproxmapModel {
  let result = sort_dist_proxmap_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_dist_proxmap_model_fill(s : SortdistproxmapModel, v : Double) -> SortdistproxmapModel {
  let result = sort_dist_proxmap_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_dist_proxmap_model_min(s : SortdistproxmapModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_proxmap_model_max(s : SortdistproxmapModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_proxmap_model_to_string(s : SortdistproxmapModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistproxmapLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_proxmap_layer_make(size : Int) -> SortdistproxmapLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_proxmap_layer_len(s : SortdistproxmapLayer) -> Int { s.size }

pub fn sort_dist_proxmap_layer_get(s : SortdistproxmapLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_proxmap_layer_set(s : SortdistproxmapLayer, i : Int, v : Double) -> SortdistproxmapLayer {
  let result = sort_dist_proxmap_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_dist_proxmap_layer_sum(s : SortdistproxmapLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_dist_proxmap_layer_mean(s : SortdistproxmapLayer) -> Double {
  if s.size == 0 { 0.0 } else { sort_dist_proxmap_layer_sum(s) / s.size.to_double() }
}

pub fn sort_dist_proxmap_layer_scale(s : SortdistproxmapLayer, f : Double) -> SortdistproxmapLayer {
  let result = sort_dist_proxmap_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_dist_proxmap_layer_add(a : SortdistproxmapLayer, b : SortdistproxmapLayer) -> SortdistproxmapLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_dist_proxmap_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_dist_proxmap_layer_copy(s : SortdistproxmapLayer) -> SortdistproxmapLayer {
  let result = sort_dist_proxmap_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_dist_proxmap_layer_fill(s : SortdistproxmapLayer, v : Double) -> SortdistproxmapLayer {
  let result = sort_dist_proxmap_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_dist_proxmap_layer_min(s : SortdistproxmapLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_proxmap_layer_max(s : SortdistproxmapLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_proxmap_layer_to_string(s : SortdistproxmapLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistproxmapBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_proxmap_buffer_make(size : Int) -> SortdistproxmapBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_proxmap_buffer_len(s : SortdistproxmapBuffer) -> Int { s.size }

pub fn sort_dist_proxmap_buffer_get(s : SortdistproxmapBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_proxmap_buffer_set(s : SortdistproxmapBuffer, i : Int, v : Double) -> SortdistproxmapBuffer {
  let result = sort_dist_proxmap_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_dist_proxmap_buffer_sum(s : SortdistproxmapBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_dist_proxmap_buffer_mean(s : SortdistproxmapBuffer) -> Double {
  if s.size == 0 { 0.0 } else { sort_dist_proxmap_buffer_sum(s) / s.size.to_double() }
}

pub fn sort_dist_proxmap_buffer_scale(s : SortdistproxmapBuffer, f : Double) -> SortdistproxmapBuffer {
  let result = sort_dist_proxmap_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_dist_proxmap_buffer_add(a : SortdistproxmapBuffer, b : SortdistproxmapBuffer) -> SortdistproxmapBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_dist_proxmap_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_dist_proxmap_buffer_copy(s : SortdistproxmapBuffer) -> SortdistproxmapBuffer {
  let result = sort_dist_proxmap_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_dist_proxmap_buffer_fill(s : SortdistproxmapBuffer, v : Double) -> SortdistproxmapBuffer {
  let result = sort_dist_proxmap_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_dist_proxmap_buffer_min(s : SortdistproxmapBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_proxmap_buffer_max(s : SortdistproxmapBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_proxmap_buffer_to_string(s : SortdistproxmapBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistproxmapCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_proxmap_cursor_make(size : Int) -> SortdistproxmapCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_proxmap_cursor_len(s : SortdistproxmapCursor) -> Int { s.size }

pub fn sort_dist_proxmap_cursor_get(s : SortdistproxmapCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_proxmap_cursor_set(s : SortdistproxmapCursor, i : Int, v : Double) -> SortdistproxmapCursor {
  let result = sort_dist_proxmap_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_dist_proxmap_cursor_sum(s : SortdistproxmapCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_dist_proxmap_cursor_mean(s : SortdistproxmapCursor) -> Double {
  if s.size == 0 { 0.0 } else { sort_dist_proxmap_cursor_sum(s) / s.size.to_double() }
}

pub fn sort_dist_proxmap_cursor_scale(s : SortdistproxmapCursor, f : Double) -> SortdistproxmapCursor {
  let result = sort_dist_proxmap_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_dist_proxmap_cursor_add(a : SortdistproxmapCursor, b : SortdistproxmapCursor) -> SortdistproxmapCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_dist_proxmap_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_dist_proxmap_cursor_copy(s : SortdistproxmapCursor) -> SortdistproxmapCursor {
  let result = sort_dist_proxmap_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_dist_proxmap_cursor_fill(s : SortdistproxmapCursor, v : Double) -> SortdistproxmapCursor {
  let result = sort_dist_proxmap_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_dist_proxmap_cursor_min(s : SortdistproxmapCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_proxmap_cursor_max(s : SortdistproxmapCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_proxmap_cursor_to_string(s : SortdistproxmapCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistproxmapView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_proxmap_view_make(size : Int) -> SortdistproxmapView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_proxmap_view_len(s : SortdistproxmapView) -> Int { s.size }

pub fn sort_dist_proxmap_view_get(s : SortdistproxmapView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_proxmap_view_set(s : SortdistproxmapView, i : Int, v : Double) -> SortdistproxmapView {
  let result = sort_dist_proxmap_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_dist_proxmap_view_sum(s : SortdistproxmapView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_dist_proxmap_view_mean(s : SortdistproxmapView) -> Double {
  if s.size == 0 { 0.0 } else { sort_dist_proxmap_view_sum(s) / s.size.to_double() }
}

pub fn sort_dist_proxmap_view_scale(s : SortdistproxmapView, f : Double) -> SortdistproxmapView {
  let result = sort_dist_proxmap_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_dist_proxmap_view_add(a : SortdistproxmapView, b : SortdistproxmapView) -> SortdistproxmapView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_dist_proxmap_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_dist_proxmap_view_copy(s : SortdistproxmapView) -> SortdistproxmapView {
  let result = sort_dist_proxmap_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_dist_proxmap_view_fill(s : SortdistproxmapView, v : Double) -> SortdistproxmapView {
  let result = sort_dist_proxmap_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_dist_proxmap_view_min(s : SortdistproxmapView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_proxmap_view_max(s : SortdistproxmapView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_proxmap_view_to_string(s : SortdistproxmapView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistproxmapRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_proxmap_range_make(size : Int) -> SortdistproxmapRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_proxmap_range_len(s : SortdistproxmapRange) -> Int { s.size }

pub fn sort_dist_proxmap_range_get(s : SortdistproxmapRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_proxmap_range_set(s : SortdistproxmapRange, i : Int, v : Double) -> SortdistproxmapRange {
  let result = sort_dist_proxmap_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_dist_proxmap_range_sum(s : SortdistproxmapRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_dist_proxmap_range_mean(s : SortdistproxmapRange) -> Double {
  if s.size == 0 { 0.0 } else { sort_dist_proxmap_range_sum(s) / s.size.to_double() }
}

pub fn sort_dist_proxmap_range_scale(s : SortdistproxmapRange, f : Double) -> SortdistproxmapRange {
  let result = sort_dist_proxmap_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_dist_proxmap_range_add(a : SortdistproxmapRange, b : SortdistproxmapRange) -> SortdistproxmapRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_dist_proxmap_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_dist_proxmap_range_copy(s : SortdistproxmapRange) -> SortdistproxmapRange {
  let result = sort_dist_proxmap_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_dist_proxmap_range_fill(s : SortdistproxmapRange, v : Double) -> SortdistproxmapRange {
  let result = sort_dist_proxmap_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_dist_proxmap_range_min(s : SortdistproxmapRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_proxmap_range_max(s : SortdistproxmapRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_proxmap_range_to_string(s : SortdistproxmapRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistproxmapSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_proxmap_slice_make(size : Int) -> SortdistproxmapSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_proxmap_slice_len(s : SortdistproxmapSlice) -> Int { s.size }

pub fn sort_dist_proxmap_slice_get(s : SortdistproxmapSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_proxmap_slice_set(s : SortdistproxmapSlice, i : Int, v : Double) -> SortdistproxmapSlice {
  let result = sort_dist_proxmap_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_dist_proxmap_slice_sum(s : SortdistproxmapSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_dist_proxmap_slice_mean(s : SortdistproxmapSlice) -> Double {
  if s.size == 0 { 0.0 } else { sort_dist_proxmap_slice_sum(s) / s.size.to_double() }
}

pub fn sort_dist_proxmap_slice_scale(s : SortdistproxmapSlice, f : Double) -> SortdistproxmapSlice {
  let result = sort_dist_proxmap_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_dist_proxmap_slice_add(a : SortdistproxmapSlice, b : SortdistproxmapSlice) -> SortdistproxmapSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_dist_proxmap_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_dist_proxmap_slice_copy(s : SortdistproxmapSlice) -> SortdistproxmapSlice {
  let result = sort_dist_proxmap_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_dist_proxmap_slice_fill(s : SortdistproxmapSlice, v : Double) -> SortdistproxmapSlice {
  let result = sort_dist_proxmap_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_dist_proxmap_slice_min(s : SortdistproxmapSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_proxmap_slice_max(s : SortdistproxmapSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_proxmap_slice_to_string(s : SortdistproxmapSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


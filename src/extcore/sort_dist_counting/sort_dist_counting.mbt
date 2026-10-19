///===
/// extcore/sort_dist_counting

pub(all) struct SortdistcountingPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn sort_dist_counting_make_point(x : Double, y : Double) -> SortdistcountingPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn sort_dist_counting_make_point3(x : Double, y : Double, z : Double) -> SortdistcountingPoint {
  { x, y, z, label: 0 }
}

pub fn sort_dist_counting_point_x(pt : SortdistcountingPoint) -> Double { pt.x }

pub fn sort_dist_counting_point_y(pt : SortdistcountingPoint) -> Double { pt.y }

pub fn sort_dist_counting_point_z(pt : SortdistcountingPoint) -> Double { pt.z }

pub fn sort_dist_counting_point_label(pt : SortdistcountingPoint) -> Int { pt.label }

pub fn sort_dist_counting_point_dist(a : SortdistcountingPoint, b : SortdistcountingPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn sort_dist_counting_point_add(a : SortdistcountingPoint, b : SortdistcountingPoint) -> SortdistcountingPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn sort_dist_counting_point_sub(a : SortdistcountingPoint, b : SortdistcountingPoint) -> SortdistcountingPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn sort_dist_counting_point_scale(pt : SortdistcountingPoint, s : Double) -> SortdistcountingPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn sort_dist_counting_point_dot(a : SortdistcountingPoint, b : SortdistcountingPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn sort_dist_counting_point_cross(a : SortdistcountingPoint, b : SortdistcountingPoint) -> SortdistcountingPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn sort_dist_counting_point_norm(pt : SortdistcountingPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn sort_dist_counting_point_normalize(pt : SortdistcountingPoint) -> SortdistcountingPoint {
  let n = sort_dist_counting_point_norm(pt)
  if n < 0.0000001 { pt } else { sort_dist_counting_point_scale(pt, 1.0 / n) }
}

pub fn sort_dist_counting_point_negate(pt : SortdistcountingPoint) -> SortdistcountingPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn sort_dist_counting_point_mid(a : SortdistcountingPoint, b : SortdistcountingPoint) -> SortdistcountingPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn sort_dist_counting_point_lerp(a : SortdistcountingPoint, b : SortdistcountingPoint, t : Double) -> SortdistcountingPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn sort_dist_counting_point_to_string(pt : SortdistcountingPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct SortdistcountingSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn sort_dist_counting_make_series(vals : Array[Double], name : String) -> SortdistcountingSeries {
  { vals, name, meta: 0 }
}

pub fn sort_dist_counting_series_len(s : SortdistcountingSeries) -> Int { s.vals.length() }

pub fn sort_dist_counting_series_sum(s : SortdistcountingSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn sort_dist_counting_series_mean(s : SortdistcountingSeries) -> Double {
  let n = sort_dist_counting_series_len(s)
  if n == 0 { 0.0 } else { sort_dist_counting_series_sum(s) / n.to_double() }
}

pub fn sort_dist_counting_series_min(s : SortdistcountingSeries) -> Double {
  let n = sort_dist_counting_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn sort_dist_counting_series_max(s : SortdistcountingSeries) -> Double {
  let n = sort_dist_counting_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn sort_dist_counting_series_range(s : SortdistcountingSeries) -> Double {
  sort_dist_counting_series_max(s) - sort_dist_counting_series_min(s)
}

pub fn sort_dist_counting_series_var(s : SortdistcountingSeries) -> Double {
  let n = sort_dist_counting_series_len(s)
  if n == 0 { 0.0 } else {
    let m = sort_dist_counting_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn sort_dist_counting_series_std(s : SortdistcountingSeries) -> Double { @_common.sqrt(sort_dist_counting_series_var(s)) }

pub fn sort_dist_counting_series_median(s : SortdistcountingSeries) -> Double {
  let n = sort_dist_counting_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = sort_dist_counting_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn sort_dist_counting_series_scale(s : SortdistcountingSeries, f : Double) -> SortdistcountingSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn sort_dist_counting_series_add(a : SortdistcountingSeries, b : SortdistcountingSeries) -> SortdistcountingSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn sort_dist_counting_series_sub(a : SortdistcountingSeries, b : SortdistcountingSeries) -> SortdistcountingSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn sort_dist_counting_series_normalize(s : SortdistcountingSeries) -> SortdistcountingSeries {
  let mn = sort_dist_counting_series_min(s)
  let mx = sort_dist_counting_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn sort_dist_counting_series_cumsum(s : SortdistcountingSeries) -> SortdistcountingSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn sort_dist_counting_series_to_string(s : SortdistcountingSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SortdistcountingMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn sort_dist_counting_make_matrix(rows : Int, cols : Int, val : Double) -> SortdistcountingMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn sort_dist_counting_matrix_identity(n : Int) -> SortdistcountingMatrix {
  let m = sort_dist_counting_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn sort_dist_counting_matrix_get(m : SortdistcountingMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn sort_dist_counting_matrix_transpose(m : SortdistcountingMatrix) -> SortdistcountingMatrix {
  let result = sort_dist_counting_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn sort_dist_counting_matrix_add(a : SortdistcountingMatrix, b : SortdistcountingMatrix) -> SortdistcountingMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = sort_dist_counting_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn sort_dist_counting_matrix_scale(m : SortdistcountingMatrix, s : Double) -> SortdistcountingMatrix {
  let result = sort_dist_counting_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn sort_dist_counting_matrix_multiply(a : SortdistcountingMatrix, b : SortdistcountingMatrix) -> SortdistcountingMatrix {
  if a.cols != b.rows { return sort_dist_counting_make_matrix(a.rows, b.cols, 0.0) }
  let result = sort_dist_counting_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn sort_dist_counting_matrix_trace(m : SortdistcountingMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn sort_dist_counting_matrix_det(m : SortdistcountingMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn sort_dist_counting_matrix_norm(m : SortdistcountingMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn sort_dist_counting_matrix_to_string(m : SortdistcountingMatrix) -> String {
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

pub(all) struct SortdistcountingVector {
  comps : Array[Double]
  dim : Int
}

pub fn sort_dist_counting_make_vector(comps : Array[Double]) -> SortdistcountingVector {
  { comps, dim: comps.length() }
}

pub fn sort_dist_counting_vector_zero(dim : Int) -> SortdistcountingVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn sort_dist_counting_vector_add(a : SortdistcountingVector, b : SortdistcountingVector) -> SortdistcountingVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn sort_dist_counting_vector_sub(a : SortdistcountingVector, b : SortdistcountingVector) -> SortdistcountingVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn sort_dist_counting_vector_scale(v : SortdistcountingVector, s : Double) -> SortdistcountingVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn sort_dist_counting_vector_dot(a : SortdistcountingVector, b : SortdistcountingVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn sort_dist_counting_vector_norm(v : SortdistcountingVector) -> Double { @_common.sqrt(sort_dist_counting_vector_dot(v, v)) }

pub fn sort_dist_counting_vector_normalize(v : SortdistcountingVector) -> SortdistcountingVector {
  let n = sort_dist_counting_vector_norm(v)
  if n < 0.0000001 { v } else { sort_dist_counting_vector_scale(v, 1.0 / n) }
}

pub fn sort_dist_counting_vector_dist(a : SortdistcountingVector, b : SortdistcountingVector) -> Double {
  sort_dist_counting_vector_norm(sort_dist_counting_vector_sub(a, b))
}

pub fn sort_dist_counting_vector_to_string(v : SortdistcountingVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn sort_dist_counting_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn sort_dist_counting_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = sort_dist_counting_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn sort_dist_counting_std(data : Array[Double]) -> Double { @_common.sqrt(sort_dist_counting_var(data)) }

pub fn sort_dist_counting_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = sort_dist_counting_mean(a); let mb = sort_dist_counting_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn sort_dist_counting_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = sort_dist_counting_std(a); let sb = sort_dist_counting_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { sort_dist_counting_cov(a, b) / (sa * sb) }
}

pub fn sort_dist_counting_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = sort_dist_counting_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn sort_dist_counting_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn sort_dist_counting_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn sort_dist_counting_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(sort_dist_counting_mse(pred, labels))
}

pub fn sort_dist_counting_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn sort_dist_counting_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = sort_dist_counting_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn sort_dist_counting_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn sort_dist_counting_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn sort_dist_counting_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = sort_dist_counting_precision(pred, labels, pos); let r = sort_dist_counting_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn sort_dist_counting_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn sort_dist_counting_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = sort_dist_counting_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn sort_dist_counting_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn sort_dist_counting_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn sort_dist_counting_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = sort_dist_counting_gcd(a, b)
    (a / g) * b
  }
}

pub fn sort_dist_counting_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn sort_dist_counting_fibonacci(n : Int) -> Int {
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

pub fn sort_dist_counting_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = sort_dist_counting_min(data); let mx = sort_dist_counting_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn sort_dist_counting_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = sort_dist_counting_mean(data); let sd = sort_dist_counting_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn sort_dist_counting_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn sort_dist_counting_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn sort_dist_counting_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn sort_dist_counting_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn sort_dist_counting_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn sort_dist_counting_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct SortdistcountingFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_counting_frame_make(size : Int) -> SortdistcountingFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_counting_frame_len(s : SortdistcountingFrame) -> Int { s.size }

pub fn sort_dist_counting_frame_get(s : SortdistcountingFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_counting_frame_set(s : SortdistcountingFrame, i : Int, v : Double) -> SortdistcountingFrame {
  let result = sort_dist_counting_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_dist_counting_frame_sum(s : SortdistcountingFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_dist_counting_frame_mean(s : SortdistcountingFrame) -> Double {
  if s.size == 0 { 0.0 } else { sort_dist_counting_frame_sum(s) / s.size.to_double() }
}

pub fn sort_dist_counting_frame_scale(s : SortdistcountingFrame, f : Double) -> SortdistcountingFrame {
  let result = sort_dist_counting_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_dist_counting_frame_add(a : SortdistcountingFrame, b : SortdistcountingFrame) -> SortdistcountingFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_dist_counting_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_dist_counting_frame_copy(s : SortdistcountingFrame) -> SortdistcountingFrame {
  let result = sort_dist_counting_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_dist_counting_frame_fill(s : SortdistcountingFrame, v : Double) -> SortdistcountingFrame {
  let result = sort_dist_counting_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_dist_counting_frame_min(s : SortdistcountingFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_counting_frame_max(s : SortdistcountingFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_counting_frame_to_string(s : SortdistcountingFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistcountingTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_counting_table_make(size : Int) -> SortdistcountingTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_counting_table_len(s : SortdistcountingTable) -> Int { s.size }

pub fn sort_dist_counting_table_get(s : SortdistcountingTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_counting_table_set(s : SortdistcountingTable, i : Int, v : Double) -> SortdistcountingTable {
  let result = sort_dist_counting_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_dist_counting_table_sum(s : SortdistcountingTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_dist_counting_table_mean(s : SortdistcountingTable) -> Double {
  if s.size == 0 { 0.0 } else { sort_dist_counting_table_sum(s) / s.size.to_double() }
}

pub fn sort_dist_counting_table_scale(s : SortdistcountingTable, f : Double) -> SortdistcountingTable {
  let result = sort_dist_counting_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_dist_counting_table_add(a : SortdistcountingTable, b : SortdistcountingTable) -> SortdistcountingTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_dist_counting_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_dist_counting_table_copy(s : SortdistcountingTable) -> SortdistcountingTable {
  let result = sort_dist_counting_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_dist_counting_table_fill(s : SortdistcountingTable, v : Double) -> SortdistcountingTable {
  let result = sort_dist_counting_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_dist_counting_table_min(s : SortdistcountingTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_counting_table_max(s : SortdistcountingTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_counting_table_to_string(s : SortdistcountingTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistcountingGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_counting_graphn_make(size : Int) -> SortdistcountingGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_counting_graphn_len(s : SortdistcountingGraphN) -> Int { s.size }

pub fn sort_dist_counting_graphn_get(s : SortdistcountingGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_counting_graphn_set(s : SortdistcountingGraphN, i : Int, v : Double) -> SortdistcountingGraphN {
  let result = sort_dist_counting_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_dist_counting_graphn_sum(s : SortdistcountingGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_dist_counting_graphn_mean(s : SortdistcountingGraphN) -> Double {
  if s.size == 0 { 0.0 } else { sort_dist_counting_graphn_sum(s) / s.size.to_double() }
}

pub fn sort_dist_counting_graphn_scale(s : SortdistcountingGraphN, f : Double) -> SortdistcountingGraphN {
  let result = sort_dist_counting_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_dist_counting_graphn_add(a : SortdistcountingGraphN, b : SortdistcountingGraphN) -> SortdistcountingGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_dist_counting_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_dist_counting_graphn_copy(s : SortdistcountingGraphN) -> SortdistcountingGraphN {
  let result = sort_dist_counting_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_dist_counting_graphn_fill(s : SortdistcountingGraphN, v : Double) -> SortdistcountingGraphN {
  let result = sort_dist_counting_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_dist_counting_graphn_min(s : SortdistcountingGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_counting_graphn_max(s : SortdistcountingGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_counting_graphn_to_string(s : SortdistcountingGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistcountingNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_counting_node_make(size : Int) -> SortdistcountingNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_counting_node_len(s : SortdistcountingNode) -> Int { s.size }

pub fn sort_dist_counting_node_get(s : SortdistcountingNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_counting_node_set(s : SortdistcountingNode, i : Int, v : Double) -> SortdistcountingNode {
  let result = sort_dist_counting_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_dist_counting_node_sum(s : SortdistcountingNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_dist_counting_node_mean(s : SortdistcountingNode) -> Double {
  if s.size == 0 { 0.0 } else { sort_dist_counting_node_sum(s) / s.size.to_double() }
}

pub fn sort_dist_counting_node_scale(s : SortdistcountingNode, f : Double) -> SortdistcountingNode {
  let result = sort_dist_counting_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_dist_counting_node_add(a : SortdistcountingNode, b : SortdistcountingNode) -> SortdistcountingNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_dist_counting_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_dist_counting_node_copy(s : SortdistcountingNode) -> SortdistcountingNode {
  let result = sort_dist_counting_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_dist_counting_node_fill(s : SortdistcountingNode, v : Double) -> SortdistcountingNode {
  let result = sort_dist_counting_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_dist_counting_node_min(s : SortdistcountingNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_counting_node_max(s : SortdistcountingNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_counting_node_to_string(s : SortdistcountingNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistcountingEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_counting_edge_make(size : Int) -> SortdistcountingEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_counting_edge_len(s : SortdistcountingEdge) -> Int { s.size }

pub fn sort_dist_counting_edge_get(s : SortdistcountingEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_counting_edge_set(s : SortdistcountingEdge, i : Int, v : Double) -> SortdistcountingEdge {
  let result = sort_dist_counting_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_dist_counting_edge_sum(s : SortdistcountingEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_dist_counting_edge_mean(s : SortdistcountingEdge) -> Double {
  if s.size == 0 { 0.0 } else { sort_dist_counting_edge_sum(s) / s.size.to_double() }
}

pub fn sort_dist_counting_edge_scale(s : SortdistcountingEdge, f : Double) -> SortdistcountingEdge {
  let result = sort_dist_counting_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_dist_counting_edge_add(a : SortdistcountingEdge, b : SortdistcountingEdge) -> SortdistcountingEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_dist_counting_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_dist_counting_edge_copy(s : SortdistcountingEdge) -> SortdistcountingEdge {
  let result = sort_dist_counting_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_dist_counting_edge_fill(s : SortdistcountingEdge, v : Double) -> SortdistcountingEdge {
  let result = sort_dist_counting_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_dist_counting_edge_min(s : SortdistcountingEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_counting_edge_max(s : SortdistcountingEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_counting_edge_to_string(s : SortdistcountingEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistcountingPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_counting_path_make(size : Int) -> SortdistcountingPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_counting_path_len(s : SortdistcountingPath) -> Int { s.size }

pub fn sort_dist_counting_path_get(s : SortdistcountingPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_counting_path_set(s : SortdistcountingPath, i : Int, v : Double) -> SortdistcountingPath {
  let result = sort_dist_counting_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_dist_counting_path_sum(s : SortdistcountingPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_dist_counting_path_mean(s : SortdistcountingPath) -> Double {
  if s.size == 0 { 0.0 } else { sort_dist_counting_path_sum(s) / s.size.to_double() }
}

pub fn sort_dist_counting_path_scale(s : SortdistcountingPath, f : Double) -> SortdistcountingPath {
  let result = sort_dist_counting_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_dist_counting_path_add(a : SortdistcountingPath, b : SortdistcountingPath) -> SortdistcountingPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_dist_counting_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_dist_counting_path_copy(s : SortdistcountingPath) -> SortdistcountingPath {
  let result = sort_dist_counting_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_dist_counting_path_fill(s : SortdistcountingPath, v : Double) -> SortdistcountingPath {
  let result = sort_dist_counting_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_dist_counting_path_min(s : SortdistcountingPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_counting_path_max(s : SortdistcountingPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_counting_path_to_string(s : SortdistcountingPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistcountingCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_counting_cluster_make(size : Int) -> SortdistcountingCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_counting_cluster_len(s : SortdistcountingCluster) -> Int { s.size }

pub fn sort_dist_counting_cluster_get(s : SortdistcountingCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_counting_cluster_set(s : SortdistcountingCluster, i : Int, v : Double) -> SortdistcountingCluster {
  let result = sort_dist_counting_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_dist_counting_cluster_sum(s : SortdistcountingCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_dist_counting_cluster_mean(s : SortdistcountingCluster) -> Double {
  if s.size == 0 { 0.0 } else { sort_dist_counting_cluster_sum(s) / s.size.to_double() }
}

pub fn sort_dist_counting_cluster_scale(s : SortdistcountingCluster, f : Double) -> SortdistcountingCluster {
  let result = sort_dist_counting_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_dist_counting_cluster_add(a : SortdistcountingCluster, b : SortdistcountingCluster) -> SortdistcountingCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_dist_counting_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_dist_counting_cluster_copy(s : SortdistcountingCluster) -> SortdistcountingCluster {
  let result = sort_dist_counting_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_dist_counting_cluster_fill(s : SortdistcountingCluster, v : Double) -> SortdistcountingCluster {
  let result = sort_dist_counting_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_dist_counting_cluster_min(s : SortdistcountingCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_counting_cluster_max(s : SortdistcountingCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_counting_cluster_to_string(s : SortdistcountingCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistcountingModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_counting_model_make(size : Int) -> SortdistcountingModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_counting_model_len(s : SortdistcountingModel) -> Int { s.size }

pub fn sort_dist_counting_model_get(s : SortdistcountingModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_counting_model_set(s : SortdistcountingModel, i : Int, v : Double) -> SortdistcountingModel {
  let result = sort_dist_counting_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_dist_counting_model_sum(s : SortdistcountingModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_dist_counting_model_mean(s : SortdistcountingModel) -> Double {
  if s.size == 0 { 0.0 } else { sort_dist_counting_model_sum(s) / s.size.to_double() }
}

pub fn sort_dist_counting_model_scale(s : SortdistcountingModel, f : Double) -> SortdistcountingModel {
  let result = sort_dist_counting_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_dist_counting_model_add(a : SortdistcountingModel, b : SortdistcountingModel) -> SortdistcountingModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_dist_counting_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_dist_counting_model_copy(s : SortdistcountingModel) -> SortdistcountingModel {
  let result = sort_dist_counting_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_dist_counting_model_fill(s : SortdistcountingModel, v : Double) -> SortdistcountingModel {
  let result = sort_dist_counting_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_dist_counting_model_min(s : SortdistcountingModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_counting_model_max(s : SortdistcountingModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_counting_model_to_string(s : SortdistcountingModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistcountingLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_counting_layer_make(size : Int) -> SortdistcountingLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_counting_layer_len(s : SortdistcountingLayer) -> Int { s.size }

pub fn sort_dist_counting_layer_get(s : SortdistcountingLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_counting_layer_set(s : SortdistcountingLayer, i : Int, v : Double) -> SortdistcountingLayer {
  let result = sort_dist_counting_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_dist_counting_layer_sum(s : SortdistcountingLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_dist_counting_layer_mean(s : SortdistcountingLayer) -> Double {
  if s.size == 0 { 0.0 } else { sort_dist_counting_layer_sum(s) / s.size.to_double() }
}

pub fn sort_dist_counting_layer_scale(s : SortdistcountingLayer, f : Double) -> SortdistcountingLayer {
  let result = sort_dist_counting_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_dist_counting_layer_add(a : SortdistcountingLayer, b : SortdistcountingLayer) -> SortdistcountingLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_dist_counting_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_dist_counting_layer_copy(s : SortdistcountingLayer) -> SortdistcountingLayer {
  let result = sort_dist_counting_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_dist_counting_layer_fill(s : SortdistcountingLayer, v : Double) -> SortdistcountingLayer {
  let result = sort_dist_counting_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_dist_counting_layer_min(s : SortdistcountingLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_counting_layer_max(s : SortdistcountingLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_counting_layer_to_string(s : SortdistcountingLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistcountingBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_counting_buffer_make(size : Int) -> SortdistcountingBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_counting_buffer_len(s : SortdistcountingBuffer) -> Int { s.size }

pub fn sort_dist_counting_buffer_get(s : SortdistcountingBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_counting_buffer_set(s : SortdistcountingBuffer, i : Int, v : Double) -> SortdistcountingBuffer {
  let result = sort_dist_counting_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_dist_counting_buffer_sum(s : SortdistcountingBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_dist_counting_buffer_mean(s : SortdistcountingBuffer) -> Double {
  if s.size == 0 { 0.0 } else { sort_dist_counting_buffer_sum(s) / s.size.to_double() }
}

pub fn sort_dist_counting_buffer_scale(s : SortdistcountingBuffer, f : Double) -> SortdistcountingBuffer {
  let result = sort_dist_counting_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_dist_counting_buffer_add(a : SortdistcountingBuffer, b : SortdistcountingBuffer) -> SortdistcountingBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_dist_counting_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_dist_counting_buffer_copy(s : SortdistcountingBuffer) -> SortdistcountingBuffer {
  let result = sort_dist_counting_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_dist_counting_buffer_fill(s : SortdistcountingBuffer, v : Double) -> SortdistcountingBuffer {
  let result = sort_dist_counting_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_dist_counting_buffer_min(s : SortdistcountingBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_counting_buffer_max(s : SortdistcountingBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_counting_buffer_to_string(s : SortdistcountingBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistcountingCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_counting_cursor_make(size : Int) -> SortdistcountingCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_counting_cursor_len(s : SortdistcountingCursor) -> Int { s.size }

pub fn sort_dist_counting_cursor_get(s : SortdistcountingCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_counting_cursor_set(s : SortdistcountingCursor, i : Int, v : Double) -> SortdistcountingCursor {
  let result = sort_dist_counting_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_dist_counting_cursor_sum(s : SortdistcountingCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_dist_counting_cursor_mean(s : SortdistcountingCursor) -> Double {
  if s.size == 0 { 0.0 } else { sort_dist_counting_cursor_sum(s) / s.size.to_double() }
}

pub fn sort_dist_counting_cursor_scale(s : SortdistcountingCursor, f : Double) -> SortdistcountingCursor {
  let result = sort_dist_counting_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_dist_counting_cursor_add(a : SortdistcountingCursor, b : SortdistcountingCursor) -> SortdistcountingCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_dist_counting_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_dist_counting_cursor_copy(s : SortdistcountingCursor) -> SortdistcountingCursor {
  let result = sort_dist_counting_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_dist_counting_cursor_fill(s : SortdistcountingCursor, v : Double) -> SortdistcountingCursor {
  let result = sort_dist_counting_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_dist_counting_cursor_min(s : SortdistcountingCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_counting_cursor_max(s : SortdistcountingCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_counting_cursor_to_string(s : SortdistcountingCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistcountingView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_counting_view_make(size : Int) -> SortdistcountingView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_counting_view_len(s : SortdistcountingView) -> Int { s.size }

pub fn sort_dist_counting_view_get(s : SortdistcountingView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_counting_view_set(s : SortdistcountingView, i : Int, v : Double) -> SortdistcountingView {
  let result = sort_dist_counting_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_dist_counting_view_sum(s : SortdistcountingView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_dist_counting_view_mean(s : SortdistcountingView) -> Double {
  if s.size == 0 { 0.0 } else { sort_dist_counting_view_sum(s) / s.size.to_double() }
}

pub fn sort_dist_counting_view_scale(s : SortdistcountingView, f : Double) -> SortdistcountingView {
  let result = sort_dist_counting_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_dist_counting_view_add(a : SortdistcountingView, b : SortdistcountingView) -> SortdistcountingView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_dist_counting_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_dist_counting_view_copy(s : SortdistcountingView) -> SortdistcountingView {
  let result = sort_dist_counting_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_dist_counting_view_fill(s : SortdistcountingView, v : Double) -> SortdistcountingView {
  let result = sort_dist_counting_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_dist_counting_view_min(s : SortdistcountingView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_counting_view_max(s : SortdistcountingView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_counting_view_to_string(s : SortdistcountingView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistcountingRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_counting_range_make(size : Int) -> SortdistcountingRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_counting_range_len(s : SortdistcountingRange) -> Int { s.size }

pub fn sort_dist_counting_range_get(s : SortdistcountingRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_counting_range_set(s : SortdistcountingRange, i : Int, v : Double) -> SortdistcountingRange {
  let result = sort_dist_counting_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_dist_counting_range_sum(s : SortdistcountingRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_dist_counting_range_mean(s : SortdistcountingRange) -> Double {
  if s.size == 0 { 0.0 } else { sort_dist_counting_range_sum(s) / s.size.to_double() }
}

pub fn sort_dist_counting_range_scale(s : SortdistcountingRange, f : Double) -> SortdistcountingRange {
  let result = sort_dist_counting_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_dist_counting_range_add(a : SortdistcountingRange, b : SortdistcountingRange) -> SortdistcountingRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_dist_counting_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_dist_counting_range_copy(s : SortdistcountingRange) -> SortdistcountingRange {
  let result = sort_dist_counting_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_dist_counting_range_fill(s : SortdistcountingRange, v : Double) -> SortdistcountingRange {
  let result = sort_dist_counting_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_dist_counting_range_min(s : SortdistcountingRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_counting_range_max(s : SortdistcountingRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_counting_range_to_string(s : SortdistcountingRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistcountingSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_counting_slice_make(size : Int) -> SortdistcountingSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_counting_slice_len(s : SortdistcountingSlice) -> Int { s.size }

pub fn sort_dist_counting_slice_get(s : SortdistcountingSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_counting_slice_set(s : SortdistcountingSlice, i : Int, v : Double) -> SortdistcountingSlice {
  let result = sort_dist_counting_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_dist_counting_slice_sum(s : SortdistcountingSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_dist_counting_slice_mean(s : SortdistcountingSlice) -> Double {
  if s.size == 0 { 0.0 } else { sort_dist_counting_slice_sum(s) / s.size.to_double() }
}

pub fn sort_dist_counting_slice_scale(s : SortdistcountingSlice, f : Double) -> SortdistcountingSlice {
  let result = sort_dist_counting_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_dist_counting_slice_add(a : SortdistcountingSlice, b : SortdistcountingSlice) -> SortdistcountingSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_dist_counting_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_dist_counting_slice_copy(s : SortdistcountingSlice) -> SortdistcountingSlice {
  let result = sort_dist_counting_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_dist_counting_slice_fill(s : SortdistcountingSlice, v : Double) -> SortdistcountingSlice {
  let result = sort_dist_counting_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_dist_counting_slice_min(s : SortdistcountingSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_counting_slice_max(s : SortdistcountingSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_counting_slice_to_string(s : SortdistcountingSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


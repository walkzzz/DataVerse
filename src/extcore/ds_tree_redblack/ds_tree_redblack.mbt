///===
/// extcore/ds_tree_redblack

pub(all) struct DstreeredblackPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_tree_redblack_make_point(x : Double, y : Double) -> DstreeredblackPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_tree_redblack_make_point3(x : Double, y : Double, z : Double) -> DstreeredblackPoint {
  { x, y, z, label: 0 }
}

pub fn ds_tree_redblack_point_x(pt : DstreeredblackPoint) -> Double { pt.x }

pub fn ds_tree_redblack_point_y(pt : DstreeredblackPoint) -> Double { pt.y }

pub fn ds_tree_redblack_point_z(pt : DstreeredblackPoint) -> Double { pt.z }

pub fn ds_tree_redblack_point_label(pt : DstreeredblackPoint) -> Int { pt.label }

pub fn ds_tree_redblack_point_dist(a : DstreeredblackPoint, b : DstreeredblackPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  ds_tree_redblack_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ds_tree_redblack_point_add(a : DstreeredblackPoint, b : DstreeredblackPoint) -> DstreeredblackPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ds_tree_redblack_point_sub(a : DstreeredblackPoint, b : DstreeredblackPoint) -> DstreeredblackPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ds_tree_redblack_point_scale(pt : DstreeredblackPoint, s : Double) -> DstreeredblackPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ds_tree_redblack_point_dot(a : DstreeredblackPoint, b : DstreeredblackPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ds_tree_redblack_point_cross(a : DstreeredblackPoint, b : DstreeredblackPoint) -> DstreeredblackPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ds_tree_redblack_point_norm(pt : DstreeredblackPoint) -> Double {
  ds_tree_redblack_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ds_tree_redblack_point_normalize(pt : DstreeredblackPoint) -> DstreeredblackPoint {
  let n = ds_tree_redblack_point_norm(pt)
  if n < 0.0000001 { pt } else { ds_tree_redblack_point_scale(pt, 1.0 / n) }
}

pub fn ds_tree_redblack_point_negate(pt : DstreeredblackPoint) -> DstreeredblackPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ds_tree_redblack_point_mid(a : DstreeredblackPoint, b : DstreeredblackPoint) -> DstreeredblackPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ds_tree_redblack_point_lerp(a : DstreeredblackPoint, b : DstreeredblackPoint, t : Double) -> DstreeredblackPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ds_tree_redblack_point_to_string(pt : DstreeredblackPoint) -> String {
  "(" + ds_tree_redblack_dbl(pt.x) + ", " + ds_tree_redblack_dbl(pt.y) + ", " + ds_tree_redblack_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DstreeredblackSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_tree_redblack_make_series(vals : Array[Double], name : String) -> DstreeredblackSeries {
  { vals, name, meta: 0 }
}

pub fn ds_tree_redblack_series_len(s : DstreeredblackSeries) -> Int { s.vals.length() }

pub fn ds_tree_redblack_series_sum(s : DstreeredblackSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn ds_tree_redblack_series_mean(s : DstreeredblackSeries) -> Double {
  let n = ds_tree_redblack_series_len(s)
  if n == 0 { 0.0 } else { ds_tree_redblack_series_sum(s) / n.to_double() }
}

pub fn ds_tree_redblack_series_min(s : DstreeredblackSeries) -> Double {
  let n = ds_tree_redblack_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn ds_tree_redblack_series_max(s : DstreeredblackSeries) -> Double {
  let n = ds_tree_redblack_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn ds_tree_redblack_series_range(s : DstreeredblackSeries) -> Double {
  ds_tree_redblack_series_max(s) - ds_tree_redblack_series_min(s)
}

pub fn ds_tree_redblack_series_var(s : DstreeredblackSeries) -> Double {
  let n = ds_tree_redblack_series_len(s)
  if n == 0 { 0.0 } else {
    let m = ds_tree_redblack_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn ds_tree_redblack_series_std(s : DstreeredblackSeries) -> Double { ds_tree_redblack_sqrt(ds_tree_redblack_series_var(s)) }

pub fn ds_tree_redblack_series_median(s : DstreeredblackSeries) -> Double {
  let n = ds_tree_redblack_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = ds_tree_redblack_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ds_tree_redblack_series_scale(s : DstreeredblackSeries, f : Double) -> DstreeredblackSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = ds_tree_redblack_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ds_tree_redblack_series_add(a : DstreeredblackSeries, b : DstreeredblackSeries) -> DstreeredblackSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = ds_tree_redblack_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ds_tree_redblack_series_sub(a : DstreeredblackSeries, b : DstreeredblackSeries) -> DstreeredblackSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = ds_tree_redblack_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ds_tree_redblack_series_normalize(s : DstreeredblackSeries) -> DstreeredblackSeries {
  let mn = ds_tree_redblack_series_min(s)
  let mx = ds_tree_redblack_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = ds_tree_redblack_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ds_tree_redblack_series_cumsum(s : DstreeredblackSeries) -> DstreeredblackSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = ds_tree_redblack_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn ds_tree_redblack_series_to_string(s : DstreeredblackSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + ds_tree_redblack_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DstreeredblackMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_tree_redblack_make_matrix(rows : Int, cols : Int, val : Double) -> DstreeredblackMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_tree_redblack_matrix_identity(n : Int) -> DstreeredblackMatrix {
  let m = ds_tree_redblack_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ds_tree_redblack_matrix_get(m : DstreeredblackMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ds_tree_redblack_matrix_transpose(m : DstreeredblackMatrix) -> DstreeredblackMatrix {
  let result = ds_tree_redblack_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ds_tree_redblack_matrix_add(a : DstreeredblackMatrix, b : DstreeredblackMatrix) -> DstreeredblackMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ds_tree_redblack_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ds_tree_redblack_matrix_scale(m : DstreeredblackMatrix, s : Double) -> DstreeredblackMatrix {
  let result = ds_tree_redblack_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ds_tree_redblack_matrix_multiply(a : DstreeredblackMatrix, b : DstreeredblackMatrix) -> DstreeredblackMatrix {
  if a.cols != b.rows { return ds_tree_redblack_make_matrix(a.rows, b.cols, 0.0) }
  let result = ds_tree_redblack_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ds_tree_redblack_matrix_trace(m : DstreeredblackMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ds_tree_redblack_matrix_det(m : DstreeredblackMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ds_tree_redblack_matrix_norm(m : DstreeredblackMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  ds_tree_redblack_sqrt(sum)
}

pub fn ds_tree_redblack_matrix_to_string(m : DstreeredblackMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + ds_tree_redblack_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct DstreeredblackVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_tree_redblack_make_vector(comps : Array[Double]) -> DstreeredblackVector {
  { comps, dim: comps.length() }
}

pub fn ds_tree_redblack_vector_zero(dim : Int) -> DstreeredblackVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ds_tree_redblack_vector_add(a : DstreeredblackVector, b : DstreeredblackVector) -> DstreeredblackVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = ds_tree_redblack_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_tree_redblack_vector_sub(a : DstreeredblackVector, b : DstreeredblackVector) -> DstreeredblackVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = ds_tree_redblack_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_tree_redblack_vector_scale(v : DstreeredblackVector, s : Double) -> DstreeredblackVector {
  let mut result = []
  for i in 0..<v.dim { result = ds_tree_redblack_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ds_tree_redblack_vector_dot(a : DstreeredblackVector, b : DstreeredblackVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ds_tree_redblack_vector_norm(v : DstreeredblackVector) -> Double { ds_tree_redblack_sqrt(ds_tree_redblack_vector_dot(v, v)) }

pub fn ds_tree_redblack_vector_normalize(v : DstreeredblackVector) -> DstreeredblackVector {
  let n = ds_tree_redblack_vector_norm(v)
  if n < 0.0000001 { v } else { ds_tree_redblack_vector_scale(v, 1.0 / n) }
}

pub fn ds_tree_redblack_vector_dist(a : DstreeredblackVector, b : DstreeredblackVector) -> Double {
  ds_tree_redblack_vector_norm(ds_tree_redblack_vector_sub(a, b))
}

pub fn ds_tree_redblack_vector_to_string(v : DstreeredblackVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + ds_tree_redblack_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_tree_redblack_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn ds_tree_redblack_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = ds_tree_redblack_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ds_tree_redblack_std(data : Array[Double]) -> Double { ds_tree_redblack_sqrt(ds_tree_redblack_var(data)) }

pub fn ds_tree_redblack_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = ds_tree_redblack_mean(a); let mb = ds_tree_redblack_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn ds_tree_redblack_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = ds_tree_redblack_std(a); let sb = ds_tree_redblack_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { ds_tree_redblack_cov(a, b) / (sa * sb) }
}

pub fn ds_tree_redblack_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = ds_tree_redblack_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ds_tree_redblack_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn ds_tree_redblack_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ds_tree_redblack_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  ds_tree_redblack_sqrt(ds_tree_redblack_mse(pred, labels))
}

pub fn ds_tree_redblack_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + ds_tree_redblack_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn ds_tree_redblack_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = ds_tree_redblack_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn ds_tree_redblack_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn ds_tree_redblack_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn ds_tree_redblack_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = ds_tree_redblack_precision(pred, labels, pos); let r = ds_tree_redblack_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn ds_tree_redblack_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn ds_tree_redblack_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = ds_tree_redblack_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn ds_tree_redblack_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn ds_tree_redblack_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn ds_tree_redblack_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = ds_tree_redblack_gcd(a, b)
    (a / g) * b
  }
}

pub fn ds_tree_redblack_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn ds_tree_redblack_fibonacci(n : Int) -> Int {
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

pub fn ds_tree_redblack_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = ds_tree_redblack_min(data); let mx = ds_tree_redblack_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn ds_tree_redblack_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = ds_tree_redblack_mean(data); let sd = ds_tree_redblack_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn ds_tree_redblack_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn ds_tree_redblack_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn ds_tree_redblack_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn ds_tree_redblack_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn ds_tree_redblack_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn ds_tree_redblack_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn ds_tree_redblack_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn ds_tree_redblack_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn ds_tree_redblack_dbl(x : Double) -> String {
  let i = if x >= 0.0 { ds_tree_redblack_int(x) } else { -ds_tree_redblack_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { ds_tree_redblack_int(f * 1000000.0) } else { ds_tree_redblack_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn ds_tree_redblack_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn ds_tree_redblack_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct DstreeredblackFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_redblack_frame_make(size : Int) -> DstreeredblackFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_redblack_frame_len(s : DstreeredblackFrame) -> Int { s.size }

pub fn ds_tree_redblack_frame_get(s : DstreeredblackFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_redblack_frame_set(s : DstreeredblackFrame, i : Int, v : Double) -> DstreeredblackFrame {
  let result = ds_tree_redblack_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_redblack_frame_sum(s : DstreeredblackFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_redblack_frame_mean(s : DstreeredblackFrame) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_redblack_frame_sum(s) / s.size.to_double() }
}

pub fn ds_tree_redblack_frame_scale(s : DstreeredblackFrame, f : Double) -> DstreeredblackFrame {
  let result = ds_tree_redblack_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_redblack_frame_add(a : DstreeredblackFrame, b : DstreeredblackFrame) -> DstreeredblackFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_redblack_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_redblack_frame_copy(s : DstreeredblackFrame) -> DstreeredblackFrame {
  let result = ds_tree_redblack_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_redblack_frame_fill(s : DstreeredblackFrame, v : Double) -> DstreeredblackFrame {
  let result = ds_tree_redblack_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_redblack_frame_min(s : DstreeredblackFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_redblack_frame_max(s : DstreeredblackFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_redblack_frame_to_string(s : DstreeredblackFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreeredblackTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_redblack_table_make(size : Int) -> DstreeredblackTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_redblack_table_len(s : DstreeredblackTable) -> Int { s.size }

pub fn ds_tree_redblack_table_get(s : DstreeredblackTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_redblack_table_set(s : DstreeredblackTable, i : Int, v : Double) -> DstreeredblackTable {
  let result = ds_tree_redblack_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_redblack_table_sum(s : DstreeredblackTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_redblack_table_mean(s : DstreeredblackTable) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_redblack_table_sum(s) / s.size.to_double() }
}

pub fn ds_tree_redblack_table_scale(s : DstreeredblackTable, f : Double) -> DstreeredblackTable {
  let result = ds_tree_redblack_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_redblack_table_add(a : DstreeredblackTable, b : DstreeredblackTable) -> DstreeredblackTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_redblack_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_redblack_table_copy(s : DstreeredblackTable) -> DstreeredblackTable {
  let result = ds_tree_redblack_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_redblack_table_fill(s : DstreeredblackTable, v : Double) -> DstreeredblackTable {
  let result = ds_tree_redblack_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_redblack_table_min(s : DstreeredblackTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_redblack_table_max(s : DstreeredblackTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_redblack_table_to_string(s : DstreeredblackTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreeredblackGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_redblack_graphn_make(size : Int) -> DstreeredblackGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_redblack_graphn_len(s : DstreeredblackGraphN) -> Int { s.size }

pub fn ds_tree_redblack_graphn_get(s : DstreeredblackGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_redblack_graphn_set(s : DstreeredblackGraphN, i : Int, v : Double) -> DstreeredblackGraphN {
  let result = ds_tree_redblack_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_redblack_graphn_sum(s : DstreeredblackGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_redblack_graphn_mean(s : DstreeredblackGraphN) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_redblack_graphn_sum(s) / s.size.to_double() }
}

pub fn ds_tree_redblack_graphn_scale(s : DstreeredblackGraphN, f : Double) -> DstreeredblackGraphN {
  let result = ds_tree_redblack_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_redblack_graphn_add(a : DstreeredblackGraphN, b : DstreeredblackGraphN) -> DstreeredblackGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_redblack_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_redblack_graphn_copy(s : DstreeredblackGraphN) -> DstreeredblackGraphN {
  let result = ds_tree_redblack_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_redblack_graphn_fill(s : DstreeredblackGraphN, v : Double) -> DstreeredblackGraphN {
  let result = ds_tree_redblack_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_redblack_graphn_min(s : DstreeredblackGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_redblack_graphn_max(s : DstreeredblackGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_redblack_graphn_to_string(s : DstreeredblackGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreeredblackNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_redblack_node_make(size : Int) -> DstreeredblackNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_redblack_node_len(s : DstreeredblackNode) -> Int { s.size }

pub fn ds_tree_redblack_node_get(s : DstreeredblackNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_redblack_node_set(s : DstreeredblackNode, i : Int, v : Double) -> DstreeredblackNode {
  let result = ds_tree_redblack_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_redblack_node_sum(s : DstreeredblackNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_redblack_node_mean(s : DstreeredblackNode) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_redblack_node_sum(s) / s.size.to_double() }
}

pub fn ds_tree_redblack_node_scale(s : DstreeredblackNode, f : Double) -> DstreeredblackNode {
  let result = ds_tree_redblack_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_redblack_node_add(a : DstreeredblackNode, b : DstreeredblackNode) -> DstreeredblackNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_redblack_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_redblack_node_copy(s : DstreeredblackNode) -> DstreeredblackNode {
  let result = ds_tree_redblack_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_redblack_node_fill(s : DstreeredblackNode, v : Double) -> DstreeredblackNode {
  let result = ds_tree_redblack_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_redblack_node_min(s : DstreeredblackNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_redblack_node_max(s : DstreeredblackNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_redblack_node_to_string(s : DstreeredblackNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreeredblackEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_redblack_edge_make(size : Int) -> DstreeredblackEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_redblack_edge_len(s : DstreeredblackEdge) -> Int { s.size }

pub fn ds_tree_redblack_edge_get(s : DstreeredblackEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_redblack_edge_set(s : DstreeredblackEdge, i : Int, v : Double) -> DstreeredblackEdge {
  let result = ds_tree_redblack_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_redblack_edge_sum(s : DstreeredblackEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_redblack_edge_mean(s : DstreeredblackEdge) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_redblack_edge_sum(s) / s.size.to_double() }
}

pub fn ds_tree_redblack_edge_scale(s : DstreeredblackEdge, f : Double) -> DstreeredblackEdge {
  let result = ds_tree_redblack_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_redblack_edge_add(a : DstreeredblackEdge, b : DstreeredblackEdge) -> DstreeredblackEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_redblack_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_redblack_edge_copy(s : DstreeredblackEdge) -> DstreeredblackEdge {
  let result = ds_tree_redblack_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_redblack_edge_fill(s : DstreeredblackEdge, v : Double) -> DstreeredblackEdge {
  let result = ds_tree_redblack_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_redblack_edge_min(s : DstreeredblackEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_redblack_edge_max(s : DstreeredblackEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_redblack_edge_to_string(s : DstreeredblackEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreeredblackPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_redblack_path_make(size : Int) -> DstreeredblackPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_redblack_path_len(s : DstreeredblackPath) -> Int { s.size }

pub fn ds_tree_redblack_path_get(s : DstreeredblackPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_redblack_path_set(s : DstreeredblackPath, i : Int, v : Double) -> DstreeredblackPath {
  let result = ds_tree_redblack_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_redblack_path_sum(s : DstreeredblackPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_redblack_path_mean(s : DstreeredblackPath) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_redblack_path_sum(s) / s.size.to_double() }
}

pub fn ds_tree_redblack_path_scale(s : DstreeredblackPath, f : Double) -> DstreeredblackPath {
  let result = ds_tree_redblack_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_redblack_path_add(a : DstreeredblackPath, b : DstreeredblackPath) -> DstreeredblackPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_redblack_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_redblack_path_copy(s : DstreeredblackPath) -> DstreeredblackPath {
  let result = ds_tree_redblack_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_redblack_path_fill(s : DstreeredblackPath, v : Double) -> DstreeredblackPath {
  let result = ds_tree_redblack_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_redblack_path_min(s : DstreeredblackPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_redblack_path_max(s : DstreeredblackPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_redblack_path_to_string(s : DstreeredblackPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreeredblackCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_redblack_cluster_make(size : Int) -> DstreeredblackCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_redblack_cluster_len(s : DstreeredblackCluster) -> Int { s.size }

pub fn ds_tree_redblack_cluster_get(s : DstreeredblackCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_redblack_cluster_set(s : DstreeredblackCluster, i : Int, v : Double) -> DstreeredblackCluster {
  let result = ds_tree_redblack_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_redblack_cluster_sum(s : DstreeredblackCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_redblack_cluster_mean(s : DstreeredblackCluster) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_redblack_cluster_sum(s) / s.size.to_double() }
}

pub fn ds_tree_redblack_cluster_scale(s : DstreeredblackCluster, f : Double) -> DstreeredblackCluster {
  let result = ds_tree_redblack_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_redblack_cluster_add(a : DstreeredblackCluster, b : DstreeredblackCluster) -> DstreeredblackCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_redblack_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_redblack_cluster_copy(s : DstreeredblackCluster) -> DstreeredblackCluster {
  let result = ds_tree_redblack_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_redblack_cluster_fill(s : DstreeredblackCluster, v : Double) -> DstreeredblackCluster {
  let result = ds_tree_redblack_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_redblack_cluster_min(s : DstreeredblackCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_redblack_cluster_max(s : DstreeredblackCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_redblack_cluster_to_string(s : DstreeredblackCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreeredblackModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_redblack_model_make(size : Int) -> DstreeredblackModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_redblack_model_len(s : DstreeredblackModel) -> Int { s.size }

pub fn ds_tree_redblack_model_get(s : DstreeredblackModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_redblack_model_set(s : DstreeredblackModel, i : Int, v : Double) -> DstreeredblackModel {
  let result = ds_tree_redblack_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_redblack_model_sum(s : DstreeredblackModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_redblack_model_mean(s : DstreeredblackModel) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_redblack_model_sum(s) / s.size.to_double() }
}

pub fn ds_tree_redblack_model_scale(s : DstreeredblackModel, f : Double) -> DstreeredblackModel {
  let result = ds_tree_redblack_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_redblack_model_add(a : DstreeredblackModel, b : DstreeredblackModel) -> DstreeredblackModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_redblack_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_redblack_model_copy(s : DstreeredblackModel) -> DstreeredblackModel {
  let result = ds_tree_redblack_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_redblack_model_fill(s : DstreeredblackModel, v : Double) -> DstreeredblackModel {
  let result = ds_tree_redblack_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_redblack_model_min(s : DstreeredblackModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_redblack_model_max(s : DstreeredblackModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_redblack_model_to_string(s : DstreeredblackModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreeredblackLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_redblack_layer_make(size : Int) -> DstreeredblackLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_redblack_layer_len(s : DstreeredblackLayer) -> Int { s.size }

pub fn ds_tree_redblack_layer_get(s : DstreeredblackLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_redblack_layer_set(s : DstreeredblackLayer, i : Int, v : Double) -> DstreeredblackLayer {
  let result = ds_tree_redblack_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_redblack_layer_sum(s : DstreeredblackLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_redblack_layer_mean(s : DstreeredblackLayer) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_redblack_layer_sum(s) / s.size.to_double() }
}

pub fn ds_tree_redblack_layer_scale(s : DstreeredblackLayer, f : Double) -> DstreeredblackLayer {
  let result = ds_tree_redblack_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_redblack_layer_add(a : DstreeredblackLayer, b : DstreeredblackLayer) -> DstreeredblackLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_redblack_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_redblack_layer_copy(s : DstreeredblackLayer) -> DstreeredblackLayer {
  let result = ds_tree_redblack_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_redblack_layer_fill(s : DstreeredblackLayer, v : Double) -> DstreeredblackLayer {
  let result = ds_tree_redblack_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_redblack_layer_min(s : DstreeredblackLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_redblack_layer_max(s : DstreeredblackLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_redblack_layer_to_string(s : DstreeredblackLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreeredblackBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_redblack_buffer_make(size : Int) -> DstreeredblackBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_redblack_buffer_len(s : DstreeredblackBuffer) -> Int { s.size }

pub fn ds_tree_redblack_buffer_get(s : DstreeredblackBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_redblack_buffer_set(s : DstreeredblackBuffer, i : Int, v : Double) -> DstreeredblackBuffer {
  let result = ds_tree_redblack_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_redblack_buffer_sum(s : DstreeredblackBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_redblack_buffer_mean(s : DstreeredblackBuffer) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_redblack_buffer_sum(s) / s.size.to_double() }
}

pub fn ds_tree_redblack_buffer_scale(s : DstreeredblackBuffer, f : Double) -> DstreeredblackBuffer {
  let result = ds_tree_redblack_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_redblack_buffer_add(a : DstreeredblackBuffer, b : DstreeredblackBuffer) -> DstreeredblackBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_redblack_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_redblack_buffer_copy(s : DstreeredblackBuffer) -> DstreeredblackBuffer {
  let result = ds_tree_redblack_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_redblack_buffer_fill(s : DstreeredblackBuffer, v : Double) -> DstreeredblackBuffer {
  let result = ds_tree_redblack_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_redblack_buffer_min(s : DstreeredblackBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_redblack_buffer_max(s : DstreeredblackBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_redblack_buffer_to_string(s : DstreeredblackBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreeredblackCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_redblack_cursor_make(size : Int) -> DstreeredblackCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_redblack_cursor_len(s : DstreeredblackCursor) -> Int { s.size }

pub fn ds_tree_redblack_cursor_get(s : DstreeredblackCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_redblack_cursor_set(s : DstreeredblackCursor, i : Int, v : Double) -> DstreeredblackCursor {
  let result = ds_tree_redblack_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_redblack_cursor_sum(s : DstreeredblackCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_redblack_cursor_mean(s : DstreeredblackCursor) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_redblack_cursor_sum(s) / s.size.to_double() }
}

pub fn ds_tree_redblack_cursor_scale(s : DstreeredblackCursor, f : Double) -> DstreeredblackCursor {
  let result = ds_tree_redblack_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_redblack_cursor_add(a : DstreeredblackCursor, b : DstreeredblackCursor) -> DstreeredblackCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_redblack_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_redblack_cursor_copy(s : DstreeredblackCursor) -> DstreeredblackCursor {
  let result = ds_tree_redblack_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_redblack_cursor_fill(s : DstreeredblackCursor, v : Double) -> DstreeredblackCursor {
  let result = ds_tree_redblack_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_redblack_cursor_min(s : DstreeredblackCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_redblack_cursor_max(s : DstreeredblackCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_redblack_cursor_to_string(s : DstreeredblackCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreeredblackView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_redblack_view_make(size : Int) -> DstreeredblackView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_redblack_view_len(s : DstreeredblackView) -> Int { s.size }

pub fn ds_tree_redblack_view_get(s : DstreeredblackView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_redblack_view_set(s : DstreeredblackView, i : Int, v : Double) -> DstreeredblackView {
  let result = ds_tree_redblack_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_redblack_view_sum(s : DstreeredblackView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_redblack_view_mean(s : DstreeredblackView) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_redblack_view_sum(s) / s.size.to_double() }
}

pub fn ds_tree_redblack_view_scale(s : DstreeredblackView, f : Double) -> DstreeredblackView {
  let result = ds_tree_redblack_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_redblack_view_add(a : DstreeredblackView, b : DstreeredblackView) -> DstreeredblackView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_redblack_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_redblack_view_copy(s : DstreeredblackView) -> DstreeredblackView {
  let result = ds_tree_redblack_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_redblack_view_fill(s : DstreeredblackView, v : Double) -> DstreeredblackView {
  let result = ds_tree_redblack_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_redblack_view_min(s : DstreeredblackView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_redblack_view_max(s : DstreeredblackView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_redblack_view_to_string(s : DstreeredblackView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreeredblackRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_redblack_range_make(size : Int) -> DstreeredblackRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_redblack_range_len(s : DstreeredblackRange) -> Int { s.size }

pub fn ds_tree_redblack_range_get(s : DstreeredblackRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_redblack_range_set(s : DstreeredblackRange, i : Int, v : Double) -> DstreeredblackRange {
  let result = ds_tree_redblack_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_redblack_range_sum(s : DstreeredblackRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_redblack_range_mean(s : DstreeredblackRange) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_redblack_range_sum(s) / s.size.to_double() }
}

pub fn ds_tree_redblack_range_scale(s : DstreeredblackRange, f : Double) -> DstreeredblackRange {
  let result = ds_tree_redblack_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_redblack_range_add(a : DstreeredblackRange, b : DstreeredblackRange) -> DstreeredblackRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_redblack_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_redblack_range_copy(s : DstreeredblackRange) -> DstreeredblackRange {
  let result = ds_tree_redblack_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_redblack_range_fill(s : DstreeredblackRange, v : Double) -> DstreeredblackRange {
  let result = ds_tree_redblack_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_redblack_range_min(s : DstreeredblackRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_redblack_range_max(s : DstreeredblackRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_redblack_range_to_string(s : DstreeredblackRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreeredblackSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_redblack_slice_make(size : Int) -> DstreeredblackSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_redblack_slice_len(s : DstreeredblackSlice) -> Int { s.size }

pub fn ds_tree_redblack_slice_get(s : DstreeredblackSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_redblack_slice_set(s : DstreeredblackSlice, i : Int, v : Double) -> DstreeredblackSlice {
  let result = ds_tree_redblack_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_redblack_slice_sum(s : DstreeredblackSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_redblack_slice_mean(s : DstreeredblackSlice) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_redblack_slice_sum(s) / s.size.to_double() }
}

pub fn ds_tree_redblack_slice_scale(s : DstreeredblackSlice, f : Double) -> DstreeredblackSlice {
  let result = ds_tree_redblack_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_redblack_slice_add(a : DstreeredblackSlice, b : DstreeredblackSlice) -> DstreeredblackSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_redblack_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_redblack_slice_copy(s : DstreeredblackSlice) -> DstreeredblackSlice {
  let result = ds_tree_redblack_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_redblack_slice_fill(s : DstreeredblackSlice, v : Double) -> DstreeredblackSlice {
  let result = ds_tree_redblack_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_redblack_slice_min(s : DstreeredblackSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_redblack_slice_max(s : DstreeredblackSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_redblack_slice_to_string(s : DstreeredblackSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn ds_tree_redblack_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_redblack_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_redblack_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_redblack_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_redblack_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_redblack_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_redblack_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_redblack_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_redblack_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_redblack_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_redblack_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_redblack_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_redblack_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_redblack_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_redblack_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_redblack_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_redblack_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_redblack_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_redblack_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_redblack_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_redblack_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_redblack_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_redblack_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_redblack_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_redblack_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}


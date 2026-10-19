///===
/// extcore/ds_tree_bst

pub(all) struct DstreebstPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_tree_bst_make_point(x : Double, y : Double) -> DstreebstPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_tree_bst_make_point3(x : Double, y : Double, z : Double) -> DstreebstPoint {
  { x, y, z, label: 0 }
}

pub fn ds_tree_bst_point_x(pt : DstreebstPoint) -> Double { pt.x }

pub fn ds_tree_bst_point_y(pt : DstreebstPoint) -> Double { pt.y }

pub fn ds_tree_bst_point_z(pt : DstreebstPoint) -> Double { pt.z }

pub fn ds_tree_bst_point_label(pt : DstreebstPoint) -> Int { pt.label }

pub fn ds_tree_bst_point_dist(a : DstreebstPoint, b : DstreebstPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  ds_tree_bst_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ds_tree_bst_point_add(a : DstreebstPoint, b : DstreebstPoint) -> DstreebstPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ds_tree_bst_point_sub(a : DstreebstPoint, b : DstreebstPoint) -> DstreebstPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ds_tree_bst_point_scale(pt : DstreebstPoint, s : Double) -> DstreebstPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ds_tree_bst_point_dot(a : DstreebstPoint, b : DstreebstPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ds_tree_bst_point_cross(a : DstreebstPoint, b : DstreebstPoint) -> DstreebstPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ds_tree_bst_point_norm(pt : DstreebstPoint) -> Double {
  ds_tree_bst_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ds_tree_bst_point_normalize(pt : DstreebstPoint) -> DstreebstPoint {
  let n = ds_tree_bst_point_norm(pt)
  if n < 0.0000001 { pt } else { ds_tree_bst_point_scale(pt, 1.0 / n) }
}

pub fn ds_tree_bst_point_negate(pt : DstreebstPoint) -> DstreebstPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ds_tree_bst_point_mid(a : DstreebstPoint, b : DstreebstPoint) -> DstreebstPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ds_tree_bst_point_lerp(a : DstreebstPoint, b : DstreebstPoint, t : Double) -> DstreebstPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ds_tree_bst_point_to_string(pt : DstreebstPoint) -> String {
  "(" + ds_tree_bst_dbl(pt.x) + ", " + ds_tree_bst_dbl(pt.y) + ", " + ds_tree_bst_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DstreebstSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_tree_bst_make_series(vals : Array[Double], name : String) -> DstreebstSeries {
  { vals, name, meta: 0 }
}

pub fn ds_tree_bst_series_len(s : DstreebstSeries) -> Int { s.vals.length() }

pub fn ds_tree_bst_series_sum(s : DstreebstSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn ds_tree_bst_series_mean(s : DstreebstSeries) -> Double {
  let n = ds_tree_bst_series_len(s)
  if n == 0 { 0.0 } else { ds_tree_bst_series_sum(s) / n.to_double() }
}

pub fn ds_tree_bst_series_min(s : DstreebstSeries) -> Double {
  let n = ds_tree_bst_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn ds_tree_bst_series_max(s : DstreebstSeries) -> Double {
  let n = ds_tree_bst_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn ds_tree_bst_series_range(s : DstreebstSeries) -> Double {
  ds_tree_bst_series_max(s) - ds_tree_bst_series_min(s)
}

pub fn ds_tree_bst_series_var(s : DstreebstSeries) -> Double {
  let n = ds_tree_bst_series_len(s)
  if n == 0 { 0.0 } else {
    let m = ds_tree_bst_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn ds_tree_bst_series_std(s : DstreebstSeries) -> Double { ds_tree_bst_sqrt(ds_tree_bst_series_var(s)) }

pub fn ds_tree_bst_series_median(s : DstreebstSeries) -> Double {
  let n = ds_tree_bst_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = ds_tree_bst_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ds_tree_bst_series_scale(s : DstreebstSeries, f : Double) -> DstreebstSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = ds_tree_bst_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ds_tree_bst_series_add(a : DstreebstSeries, b : DstreebstSeries) -> DstreebstSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = ds_tree_bst_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ds_tree_bst_series_sub(a : DstreebstSeries, b : DstreebstSeries) -> DstreebstSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = ds_tree_bst_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ds_tree_bst_series_normalize(s : DstreebstSeries) -> DstreebstSeries {
  let mn = ds_tree_bst_series_min(s)
  let mx = ds_tree_bst_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = ds_tree_bst_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ds_tree_bst_series_cumsum(s : DstreebstSeries) -> DstreebstSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = ds_tree_bst_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn ds_tree_bst_series_to_string(s : DstreebstSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + ds_tree_bst_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DstreebstMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_tree_bst_make_matrix(rows : Int, cols : Int, val : Double) -> DstreebstMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_tree_bst_matrix_identity(n : Int) -> DstreebstMatrix {
  let m = ds_tree_bst_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ds_tree_bst_matrix_get(m : DstreebstMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ds_tree_bst_matrix_transpose(m : DstreebstMatrix) -> DstreebstMatrix {
  let result = ds_tree_bst_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ds_tree_bst_matrix_add(a : DstreebstMatrix, b : DstreebstMatrix) -> DstreebstMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ds_tree_bst_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ds_tree_bst_matrix_scale(m : DstreebstMatrix, s : Double) -> DstreebstMatrix {
  let result = ds_tree_bst_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ds_tree_bst_matrix_multiply(a : DstreebstMatrix, b : DstreebstMatrix) -> DstreebstMatrix {
  if a.cols != b.rows { return ds_tree_bst_make_matrix(a.rows, b.cols, 0.0) }
  let result = ds_tree_bst_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ds_tree_bst_matrix_trace(m : DstreebstMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ds_tree_bst_matrix_det(m : DstreebstMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ds_tree_bst_matrix_norm(m : DstreebstMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  ds_tree_bst_sqrt(sum)
}

pub fn ds_tree_bst_matrix_to_string(m : DstreebstMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + ds_tree_bst_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct DstreebstVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_tree_bst_make_vector(comps : Array[Double]) -> DstreebstVector {
  { comps, dim: comps.length() }
}

pub fn ds_tree_bst_vector_zero(dim : Int) -> DstreebstVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ds_tree_bst_vector_add(a : DstreebstVector, b : DstreebstVector) -> DstreebstVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = ds_tree_bst_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_tree_bst_vector_sub(a : DstreebstVector, b : DstreebstVector) -> DstreebstVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = ds_tree_bst_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_tree_bst_vector_scale(v : DstreebstVector, s : Double) -> DstreebstVector {
  let mut result = []
  for i in 0..<v.dim { result = ds_tree_bst_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ds_tree_bst_vector_dot(a : DstreebstVector, b : DstreebstVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ds_tree_bst_vector_norm(v : DstreebstVector) -> Double { ds_tree_bst_sqrt(ds_tree_bst_vector_dot(v, v)) }

pub fn ds_tree_bst_vector_normalize(v : DstreebstVector) -> DstreebstVector {
  let n = ds_tree_bst_vector_norm(v)
  if n < 0.0000001 { v } else { ds_tree_bst_vector_scale(v, 1.0 / n) }
}

pub fn ds_tree_bst_vector_dist(a : DstreebstVector, b : DstreebstVector) -> Double {
  ds_tree_bst_vector_norm(ds_tree_bst_vector_sub(a, b))
}

pub fn ds_tree_bst_vector_to_string(v : DstreebstVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + ds_tree_bst_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_tree_bst_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn ds_tree_bst_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = ds_tree_bst_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ds_tree_bst_std(data : Array[Double]) -> Double { ds_tree_bst_sqrt(ds_tree_bst_var(data)) }

pub fn ds_tree_bst_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = ds_tree_bst_mean(a); let mb = ds_tree_bst_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn ds_tree_bst_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = ds_tree_bst_std(a); let sb = ds_tree_bst_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { ds_tree_bst_cov(a, b) / (sa * sb) }
}

pub fn ds_tree_bst_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = ds_tree_bst_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ds_tree_bst_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn ds_tree_bst_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ds_tree_bst_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  ds_tree_bst_sqrt(ds_tree_bst_mse(pred, labels))
}

pub fn ds_tree_bst_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + ds_tree_bst_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn ds_tree_bst_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = ds_tree_bst_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn ds_tree_bst_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn ds_tree_bst_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn ds_tree_bst_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = ds_tree_bst_precision(pred, labels, pos); let r = ds_tree_bst_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn ds_tree_bst_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn ds_tree_bst_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = ds_tree_bst_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn ds_tree_bst_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn ds_tree_bst_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn ds_tree_bst_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = ds_tree_bst_gcd(a, b)
    (a / g) * b
  }
}

pub fn ds_tree_bst_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn ds_tree_bst_fibonacci(n : Int) -> Int {
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

pub fn ds_tree_bst_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = ds_tree_bst_min(data); let mx = ds_tree_bst_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn ds_tree_bst_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = ds_tree_bst_mean(data); let sd = ds_tree_bst_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn ds_tree_bst_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn ds_tree_bst_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn ds_tree_bst_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn ds_tree_bst_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn ds_tree_bst_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn ds_tree_bst_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn ds_tree_bst_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn ds_tree_bst_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn ds_tree_bst_dbl(x : Double) -> String {
  let i = if x >= 0.0 { ds_tree_bst_int(x) } else { -ds_tree_bst_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { ds_tree_bst_int(f * 1000000.0) } else { ds_tree_bst_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn ds_tree_bst_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn ds_tree_bst_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct DstreebstFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_bst_frame_make(size : Int) -> DstreebstFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_bst_frame_len(s : DstreebstFrame) -> Int { s.size }

pub fn ds_tree_bst_frame_get(s : DstreebstFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_bst_frame_set(s : DstreebstFrame, i : Int, v : Double) -> DstreebstFrame {
  let result = ds_tree_bst_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_bst_frame_sum(s : DstreebstFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_bst_frame_mean(s : DstreebstFrame) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_bst_frame_sum(s) / s.size.to_double() }
}

pub fn ds_tree_bst_frame_scale(s : DstreebstFrame, f : Double) -> DstreebstFrame {
  let result = ds_tree_bst_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_bst_frame_add(a : DstreebstFrame, b : DstreebstFrame) -> DstreebstFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_bst_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_bst_frame_copy(s : DstreebstFrame) -> DstreebstFrame {
  let result = ds_tree_bst_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_bst_frame_fill(s : DstreebstFrame, v : Double) -> DstreebstFrame {
  let result = ds_tree_bst_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_bst_frame_min(s : DstreebstFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_bst_frame_max(s : DstreebstFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_bst_frame_to_string(s : DstreebstFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreebstTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_bst_table_make(size : Int) -> DstreebstTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_bst_table_len(s : DstreebstTable) -> Int { s.size }

pub fn ds_tree_bst_table_get(s : DstreebstTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_bst_table_set(s : DstreebstTable, i : Int, v : Double) -> DstreebstTable {
  let result = ds_tree_bst_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_bst_table_sum(s : DstreebstTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_bst_table_mean(s : DstreebstTable) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_bst_table_sum(s) / s.size.to_double() }
}

pub fn ds_tree_bst_table_scale(s : DstreebstTable, f : Double) -> DstreebstTable {
  let result = ds_tree_bst_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_bst_table_add(a : DstreebstTable, b : DstreebstTable) -> DstreebstTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_bst_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_bst_table_copy(s : DstreebstTable) -> DstreebstTable {
  let result = ds_tree_bst_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_bst_table_fill(s : DstreebstTable, v : Double) -> DstreebstTable {
  let result = ds_tree_bst_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_bst_table_min(s : DstreebstTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_bst_table_max(s : DstreebstTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_bst_table_to_string(s : DstreebstTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreebstGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_bst_graphn_make(size : Int) -> DstreebstGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_bst_graphn_len(s : DstreebstGraphN) -> Int { s.size }

pub fn ds_tree_bst_graphn_get(s : DstreebstGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_bst_graphn_set(s : DstreebstGraphN, i : Int, v : Double) -> DstreebstGraphN {
  let result = ds_tree_bst_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_bst_graphn_sum(s : DstreebstGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_bst_graphn_mean(s : DstreebstGraphN) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_bst_graphn_sum(s) / s.size.to_double() }
}

pub fn ds_tree_bst_graphn_scale(s : DstreebstGraphN, f : Double) -> DstreebstGraphN {
  let result = ds_tree_bst_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_bst_graphn_add(a : DstreebstGraphN, b : DstreebstGraphN) -> DstreebstGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_bst_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_bst_graphn_copy(s : DstreebstGraphN) -> DstreebstGraphN {
  let result = ds_tree_bst_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_bst_graphn_fill(s : DstreebstGraphN, v : Double) -> DstreebstGraphN {
  let result = ds_tree_bst_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_bst_graphn_min(s : DstreebstGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_bst_graphn_max(s : DstreebstGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_bst_graphn_to_string(s : DstreebstGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreebstNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_bst_node_make(size : Int) -> DstreebstNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_bst_node_len(s : DstreebstNode) -> Int { s.size }

pub fn ds_tree_bst_node_get(s : DstreebstNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_bst_node_set(s : DstreebstNode, i : Int, v : Double) -> DstreebstNode {
  let result = ds_tree_bst_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_bst_node_sum(s : DstreebstNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_bst_node_mean(s : DstreebstNode) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_bst_node_sum(s) / s.size.to_double() }
}

pub fn ds_tree_bst_node_scale(s : DstreebstNode, f : Double) -> DstreebstNode {
  let result = ds_tree_bst_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_bst_node_add(a : DstreebstNode, b : DstreebstNode) -> DstreebstNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_bst_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_bst_node_copy(s : DstreebstNode) -> DstreebstNode {
  let result = ds_tree_bst_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_bst_node_fill(s : DstreebstNode, v : Double) -> DstreebstNode {
  let result = ds_tree_bst_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_bst_node_min(s : DstreebstNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_bst_node_max(s : DstreebstNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_bst_node_to_string(s : DstreebstNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreebstEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_bst_edge_make(size : Int) -> DstreebstEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_bst_edge_len(s : DstreebstEdge) -> Int { s.size }

pub fn ds_tree_bst_edge_get(s : DstreebstEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_bst_edge_set(s : DstreebstEdge, i : Int, v : Double) -> DstreebstEdge {
  let result = ds_tree_bst_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_bst_edge_sum(s : DstreebstEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_bst_edge_mean(s : DstreebstEdge) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_bst_edge_sum(s) / s.size.to_double() }
}

pub fn ds_tree_bst_edge_scale(s : DstreebstEdge, f : Double) -> DstreebstEdge {
  let result = ds_tree_bst_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_bst_edge_add(a : DstreebstEdge, b : DstreebstEdge) -> DstreebstEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_bst_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_bst_edge_copy(s : DstreebstEdge) -> DstreebstEdge {
  let result = ds_tree_bst_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_bst_edge_fill(s : DstreebstEdge, v : Double) -> DstreebstEdge {
  let result = ds_tree_bst_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_bst_edge_min(s : DstreebstEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_bst_edge_max(s : DstreebstEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_bst_edge_to_string(s : DstreebstEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreebstPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_bst_path_make(size : Int) -> DstreebstPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_bst_path_len(s : DstreebstPath) -> Int { s.size }

pub fn ds_tree_bst_path_get(s : DstreebstPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_bst_path_set(s : DstreebstPath, i : Int, v : Double) -> DstreebstPath {
  let result = ds_tree_bst_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_bst_path_sum(s : DstreebstPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_bst_path_mean(s : DstreebstPath) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_bst_path_sum(s) / s.size.to_double() }
}

pub fn ds_tree_bst_path_scale(s : DstreebstPath, f : Double) -> DstreebstPath {
  let result = ds_tree_bst_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_bst_path_add(a : DstreebstPath, b : DstreebstPath) -> DstreebstPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_bst_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_bst_path_copy(s : DstreebstPath) -> DstreebstPath {
  let result = ds_tree_bst_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_bst_path_fill(s : DstreebstPath, v : Double) -> DstreebstPath {
  let result = ds_tree_bst_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_bst_path_min(s : DstreebstPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_bst_path_max(s : DstreebstPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_bst_path_to_string(s : DstreebstPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreebstCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_bst_cluster_make(size : Int) -> DstreebstCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_bst_cluster_len(s : DstreebstCluster) -> Int { s.size }

pub fn ds_tree_bst_cluster_get(s : DstreebstCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_bst_cluster_set(s : DstreebstCluster, i : Int, v : Double) -> DstreebstCluster {
  let result = ds_tree_bst_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_bst_cluster_sum(s : DstreebstCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_bst_cluster_mean(s : DstreebstCluster) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_bst_cluster_sum(s) / s.size.to_double() }
}

pub fn ds_tree_bst_cluster_scale(s : DstreebstCluster, f : Double) -> DstreebstCluster {
  let result = ds_tree_bst_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_bst_cluster_add(a : DstreebstCluster, b : DstreebstCluster) -> DstreebstCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_bst_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_bst_cluster_copy(s : DstreebstCluster) -> DstreebstCluster {
  let result = ds_tree_bst_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_bst_cluster_fill(s : DstreebstCluster, v : Double) -> DstreebstCluster {
  let result = ds_tree_bst_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_bst_cluster_min(s : DstreebstCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_bst_cluster_max(s : DstreebstCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_bst_cluster_to_string(s : DstreebstCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreebstModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_bst_model_make(size : Int) -> DstreebstModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_bst_model_len(s : DstreebstModel) -> Int { s.size }

pub fn ds_tree_bst_model_get(s : DstreebstModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_bst_model_set(s : DstreebstModel, i : Int, v : Double) -> DstreebstModel {
  let result = ds_tree_bst_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_bst_model_sum(s : DstreebstModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_bst_model_mean(s : DstreebstModel) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_bst_model_sum(s) / s.size.to_double() }
}

pub fn ds_tree_bst_model_scale(s : DstreebstModel, f : Double) -> DstreebstModel {
  let result = ds_tree_bst_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_bst_model_add(a : DstreebstModel, b : DstreebstModel) -> DstreebstModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_bst_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_bst_model_copy(s : DstreebstModel) -> DstreebstModel {
  let result = ds_tree_bst_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_bst_model_fill(s : DstreebstModel, v : Double) -> DstreebstModel {
  let result = ds_tree_bst_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_bst_model_min(s : DstreebstModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_bst_model_max(s : DstreebstModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_bst_model_to_string(s : DstreebstModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreebstLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_bst_layer_make(size : Int) -> DstreebstLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_bst_layer_len(s : DstreebstLayer) -> Int { s.size }

pub fn ds_tree_bst_layer_get(s : DstreebstLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_bst_layer_set(s : DstreebstLayer, i : Int, v : Double) -> DstreebstLayer {
  let result = ds_tree_bst_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_bst_layer_sum(s : DstreebstLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_bst_layer_mean(s : DstreebstLayer) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_bst_layer_sum(s) / s.size.to_double() }
}

pub fn ds_tree_bst_layer_scale(s : DstreebstLayer, f : Double) -> DstreebstLayer {
  let result = ds_tree_bst_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_bst_layer_add(a : DstreebstLayer, b : DstreebstLayer) -> DstreebstLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_bst_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_bst_layer_copy(s : DstreebstLayer) -> DstreebstLayer {
  let result = ds_tree_bst_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_bst_layer_fill(s : DstreebstLayer, v : Double) -> DstreebstLayer {
  let result = ds_tree_bst_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_bst_layer_min(s : DstreebstLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_bst_layer_max(s : DstreebstLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_bst_layer_to_string(s : DstreebstLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreebstBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_bst_buffer_make(size : Int) -> DstreebstBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_bst_buffer_len(s : DstreebstBuffer) -> Int { s.size }

pub fn ds_tree_bst_buffer_get(s : DstreebstBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_bst_buffer_set(s : DstreebstBuffer, i : Int, v : Double) -> DstreebstBuffer {
  let result = ds_tree_bst_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_bst_buffer_sum(s : DstreebstBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_bst_buffer_mean(s : DstreebstBuffer) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_bst_buffer_sum(s) / s.size.to_double() }
}

pub fn ds_tree_bst_buffer_scale(s : DstreebstBuffer, f : Double) -> DstreebstBuffer {
  let result = ds_tree_bst_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_bst_buffer_add(a : DstreebstBuffer, b : DstreebstBuffer) -> DstreebstBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_bst_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_bst_buffer_copy(s : DstreebstBuffer) -> DstreebstBuffer {
  let result = ds_tree_bst_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_bst_buffer_fill(s : DstreebstBuffer, v : Double) -> DstreebstBuffer {
  let result = ds_tree_bst_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_bst_buffer_min(s : DstreebstBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_bst_buffer_max(s : DstreebstBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_bst_buffer_to_string(s : DstreebstBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreebstCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_bst_cursor_make(size : Int) -> DstreebstCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_bst_cursor_len(s : DstreebstCursor) -> Int { s.size }

pub fn ds_tree_bst_cursor_get(s : DstreebstCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_bst_cursor_set(s : DstreebstCursor, i : Int, v : Double) -> DstreebstCursor {
  let result = ds_tree_bst_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_bst_cursor_sum(s : DstreebstCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_bst_cursor_mean(s : DstreebstCursor) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_bst_cursor_sum(s) / s.size.to_double() }
}

pub fn ds_tree_bst_cursor_scale(s : DstreebstCursor, f : Double) -> DstreebstCursor {
  let result = ds_tree_bst_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_bst_cursor_add(a : DstreebstCursor, b : DstreebstCursor) -> DstreebstCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_bst_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_bst_cursor_copy(s : DstreebstCursor) -> DstreebstCursor {
  let result = ds_tree_bst_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_bst_cursor_fill(s : DstreebstCursor, v : Double) -> DstreebstCursor {
  let result = ds_tree_bst_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_bst_cursor_min(s : DstreebstCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_bst_cursor_max(s : DstreebstCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_bst_cursor_to_string(s : DstreebstCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreebstView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_bst_view_make(size : Int) -> DstreebstView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_bst_view_len(s : DstreebstView) -> Int { s.size }

pub fn ds_tree_bst_view_get(s : DstreebstView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_bst_view_set(s : DstreebstView, i : Int, v : Double) -> DstreebstView {
  let result = ds_tree_bst_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_bst_view_sum(s : DstreebstView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_bst_view_mean(s : DstreebstView) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_bst_view_sum(s) / s.size.to_double() }
}

pub fn ds_tree_bst_view_scale(s : DstreebstView, f : Double) -> DstreebstView {
  let result = ds_tree_bst_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_bst_view_add(a : DstreebstView, b : DstreebstView) -> DstreebstView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_bst_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_bst_view_copy(s : DstreebstView) -> DstreebstView {
  let result = ds_tree_bst_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_bst_view_fill(s : DstreebstView, v : Double) -> DstreebstView {
  let result = ds_tree_bst_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_bst_view_min(s : DstreebstView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_bst_view_max(s : DstreebstView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_bst_view_to_string(s : DstreebstView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreebstRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_bst_range_make(size : Int) -> DstreebstRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_bst_range_len(s : DstreebstRange) -> Int { s.size }

pub fn ds_tree_bst_range_get(s : DstreebstRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_bst_range_set(s : DstreebstRange, i : Int, v : Double) -> DstreebstRange {
  let result = ds_tree_bst_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_bst_range_sum(s : DstreebstRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_bst_range_mean(s : DstreebstRange) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_bst_range_sum(s) / s.size.to_double() }
}

pub fn ds_tree_bst_range_scale(s : DstreebstRange, f : Double) -> DstreebstRange {
  let result = ds_tree_bst_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_bst_range_add(a : DstreebstRange, b : DstreebstRange) -> DstreebstRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_bst_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_bst_range_copy(s : DstreebstRange) -> DstreebstRange {
  let result = ds_tree_bst_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_bst_range_fill(s : DstreebstRange, v : Double) -> DstreebstRange {
  let result = ds_tree_bst_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_bst_range_min(s : DstreebstRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_bst_range_max(s : DstreebstRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_bst_range_to_string(s : DstreebstRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreebstSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_bst_slice_make(size : Int) -> DstreebstSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_bst_slice_len(s : DstreebstSlice) -> Int { s.size }

pub fn ds_tree_bst_slice_get(s : DstreebstSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_bst_slice_set(s : DstreebstSlice, i : Int, v : Double) -> DstreebstSlice {
  let result = ds_tree_bst_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_bst_slice_sum(s : DstreebstSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_bst_slice_mean(s : DstreebstSlice) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_bst_slice_sum(s) / s.size.to_double() }
}

pub fn ds_tree_bst_slice_scale(s : DstreebstSlice, f : Double) -> DstreebstSlice {
  let result = ds_tree_bst_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_bst_slice_add(a : DstreebstSlice, b : DstreebstSlice) -> DstreebstSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_bst_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_bst_slice_copy(s : DstreebstSlice) -> DstreebstSlice {
  let result = ds_tree_bst_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_bst_slice_fill(s : DstreebstSlice, v : Double) -> DstreebstSlice {
  let result = ds_tree_bst_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_bst_slice_min(s : DstreebstSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_bst_slice_max(s : DstreebstSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_bst_slice_to_string(s : DstreebstSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn ds_tree_bst_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_bst_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_bst_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_bst_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_bst_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_bst_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_bst_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_bst_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_bst_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_bst_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_bst_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_bst_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_bst_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_bst_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_bst_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_bst_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_bst_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_bst_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_bst_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_bst_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_bst_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_bst_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_bst_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_bst_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_bst_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}


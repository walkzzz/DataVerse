///===
/// extcore/ds_tree_trie

pub(all) struct DstreetriePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_tree_trie_make_point(x : Double, y : Double) -> DstreetriePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_tree_trie_make_point3(x : Double, y : Double, z : Double) -> DstreetriePoint {
  { x, y, z, label: 0 }
}

pub fn ds_tree_trie_point_x(pt : DstreetriePoint) -> Double { pt.x }

pub fn ds_tree_trie_point_y(pt : DstreetriePoint) -> Double { pt.y }

pub fn ds_tree_trie_point_z(pt : DstreetriePoint) -> Double { pt.z }

pub fn ds_tree_trie_point_label(pt : DstreetriePoint) -> Int { pt.label }

pub fn ds_tree_trie_point_dist(a : DstreetriePoint, b : DstreetriePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  ds_tree_trie_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ds_tree_trie_point_add(a : DstreetriePoint, b : DstreetriePoint) -> DstreetriePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ds_tree_trie_point_sub(a : DstreetriePoint, b : DstreetriePoint) -> DstreetriePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ds_tree_trie_point_scale(pt : DstreetriePoint, s : Double) -> DstreetriePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ds_tree_trie_point_dot(a : DstreetriePoint, b : DstreetriePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ds_tree_trie_point_cross(a : DstreetriePoint, b : DstreetriePoint) -> DstreetriePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ds_tree_trie_point_norm(pt : DstreetriePoint) -> Double {
  ds_tree_trie_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ds_tree_trie_point_normalize(pt : DstreetriePoint) -> DstreetriePoint {
  let n = ds_tree_trie_point_norm(pt)
  if n < 0.0000001 { pt } else { ds_tree_trie_point_scale(pt, 1.0 / n) }
}

pub fn ds_tree_trie_point_negate(pt : DstreetriePoint) -> DstreetriePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ds_tree_trie_point_mid(a : DstreetriePoint, b : DstreetriePoint) -> DstreetriePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ds_tree_trie_point_lerp(a : DstreetriePoint, b : DstreetriePoint, t : Double) -> DstreetriePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ds_tree_trie_point_to_string(pt : DstreetriePoint) -> String {
  "(" + ds_tree_trie_dbl(pt.x) + ", " + ds_tree_trie_dbl(pt.y) + ", " + ds_tree_trie_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DstreetrieSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_tree_trie_make_series(vals : Array[Double], name : String) -> DstreetrieSeries {
  { vals, name, meta: 0 }
}

pub fn ds_tree_trie_series_len(s : DstreetrieSeries) -> Int { s.vals.length() }

pub fn ds_tree_trie_series_sum(s : DstreetrieSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn ds_tree_trie_series_mean(s : DstreetrieSeries) -> Double {
  let n = ds_tree_trie_series_len(s)
  if n == 0 { 0.0 } else { ds_tree_trie_series_sum(s) / n.to_double() }
}

pub fn ds_tree_trie_series_min(s : DstreetrieSeries) -> Double {
  let n = ds_tree_trie_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn ds_tree_trie_series_max(s : DstreetrieSeries) -> Double {
  let n = ds_tree_trie_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn ds_tree_trie_series_range(s : DstreetrieSeries) -> Double {
  ds_tree_trie_series_max(s) - ds_tree_trie_series_min(s)
}

pub fn ds_tree_trie_series_var(s : DstreetrieSeries) -> Double {
  let n = ds_tree_trie_series_len(s)
  if n == 0 { 0.0 } else {
    let m = ds_tree_trie_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn ds_tree_trie_series_std(s : DstreetrieSeries) -> Double { ds_tree_trie_sqrt(ds_tree_trie_series_var(s)) }

pub fn ds_tree_trie_series_median(s : DstreetrieSeries) -> Double {
  let n = ds_tree_trie_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = ds_tree_trie_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ds_tree_trie_series_scale(s : DstreetrieSeries, f : Double) -> DstreetrieSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = ds_tree_trie_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ds_tree_trie_series_add(a : DstreetrieSeries, b : DstreetrieSeries) -> DstreetrieSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = ds_tree_trie_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ds_tree_trie_series_sub(a : DstreetrieSeries, b : DstreetrieSeries) -> DstreetrieSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = ds_tree_trie_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ds_tree_trie_series_normalize(s : DstreetrieSeries) -> DstreetrieSeries {
  let mn = ds_tree_trie_series_min(s)
  let mx = ds_tree_trie_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = ds_tree_trie_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ds_tree_trie_series_cumsum(s : DstreetrieSeries) -> DstreetrieSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = ds_tree_trie_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn ds_tree_trie_series_to_string(s : DstreetrieSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + ds_tree_trie_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DstreetrieMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_tree_trie_make_matrix(rows : Int, cols : Int, val : Double) -> DstreetrieMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_tree_trie_matrix_identity(n : Int) -> DstreetrieMatrix {
  let m = ds_tree_trie_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ds_tree_trie_matrix_get(m : DstreetrieMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ds_tree_trie_matrix_transpose(m : DstreetrieMatrix) -> DstreetrieMatrix {
  let result = ds_tree_trie_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ds_tree_trie_matrix_add(a : DstreetrieMatrix, b : DstreetrieMatrix) -> DstreetrieMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ds_tree_trie_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ds_tree_trie_matrix_scale(m : DstreetrieMatrix, s : Double) -> DstreetrieMatrix {
  let result = ds_tree_trie_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ds_tree_trie_matrix_multiply(a : DstreetrieMatrix, b : DstreetrieMatrix) -> DstreetrieMatrix {
  if a.cols != b.rows { return ds_tree_trie_make_matrix(a.rows, b.cols, 0.0) }
  let result = ds_tree_trie_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ds_tree_trie_matrix_trace(m : DstreetrieMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ds_tree_trie_matrix_det(m : DstreetrieMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ds_tree_trie_matrix_norm(m : DstreetrieMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  ds_tree_trie_sqrt(sum)
}

pub fn ds_tree_trie_matrix_to_string(m : DstreetrieMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + ds_tree_trie_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct DstreetrieVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_tree_trie_make_vector(comps : Array[Double]) -> DstreetrieVector {
  { comps, dim: comps.length() }
}

pub fn ds_tree_trie_vector_zero(dim : Int) -> DstreetrieVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ds_tree_trie_vector_add(a : DstreetrieVector, b : DstreetrieVector) -> DstreetrieVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = ds_tree_trie_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_tree_trie_vector_sub(a : DstreetrieVector, b : DstreetrieVector) -> DstreetrieVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = ds_tree_trie_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_tree_trie_vector_scale(v : DstreetrieVector, s : Double) -> DstreetrieVector {
  let mut result = []
  for i in 0..<v.dim { result = ds_tree_trie_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ds_tree_trie_vector_dot(a : DstreetrieVector, b : DstreetrieVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ds_tree_trie_vector_norm(v : DstreetrieVector) -> Double { ds_tree_trie_sqrt(ds_tree_trie_vector_dot(v, v)) }

pub fn ds_tree_trie_vector_normalize(v : DstreetrieVector) -> DstreetrieVector {
  let n = ds_tree_trie_vector_norm(v)
  if n < 0.0000001 { v } else { ds_tree_trie_vector_scale(v, 1.0 / n) }
}

pub fn ds_tree_trie_vector_dist(a : DstreetrieVector, b : DstreetrieVector) -> Double {
  ds_tree_trie_vector_norm(ds_tree_trie_vector_sub(a, b))
}

pub fn ds_tree_trie_vector_to_string(v : DstreetrieVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + ds_tree_trie_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_tree_trie_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn ds_tree_trie_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = ds_tree_trie_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ds_tree_trie_std(data : Array[Double]) -> Double { ds_tree_trie_sqrt(ds_tree_trie_var(data)) }

pub fn ds_tree_trie_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = ds_tree_trie_mean(a); let mb = ds_tree_trie_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn ds_tree_trie_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = ds_tree_trie_std(a); let sb = ds_tree_trie_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { ds_tree_trie_cov(a, b) / (sa * sb) }
}

pub fn ds_tree_trie_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = ds_tree_trie_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ds_tree_trie_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn ds_tree_trie_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ds_tree_trie_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  ds_tree_trie_sqrt(ds_tree_trie_mse(pred, labels))
}

pub fn ds_tree_trie_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + ds_tree_trie_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn ds_tree_trie_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = ds_tree_trie_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn ds_tree_trie_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn ds_tree_trie_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn ds_tree_trie_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = ds_tree_trie_precision(pred, labels, pos); let r = ds_tree_trie_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn ds_tree_trie_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn ds_tree_trie_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = ds_tree_trie_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn ds_tree_trie_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn ds_tree_trie_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn ds_tree_trie_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = ds_tree_trie_gcd(a, b)
    (a / g) * b
  }
}

pub fn ds_tree_trie_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn ds_tree_trie_fibonacci(n : Int) -> Int {
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

pub fn ds_tree_trie_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = ds_tree_trie_min(data); let mx = ds_tree_trie_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn ds_tree_trie_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = ds_tree_trie_mean(data); let sd = ds_tree_trie_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn ds_tree_trie_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn ds_tree_trie_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn ds_tree_trie_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn ds_tree_trie_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn ds_tree_trie_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn ds_tree_trie_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn ds_tree_trie_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn ds_tree_trie_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn ds_tree_trie_dbl(x : Double) -> String {
  let i = if x >= 0.0 { ds_tree_trie_int(x) } else { -ds_tree_trie_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { ds_tree_trie_int(f * 1000000.0) } else { ds_tree_trie_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn ds_tree_trie_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn ds_tree_trie_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct DstreetrieFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_trie_frame_make(size : Int) -> DstreetrieFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_trie_frame_len(s : DstreetrieFrame) -> Int { s.size }

pub fn ds_tree_trie_frame_get(s : DstreetrieFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_trie_frame_set(s : DstreetrieFrame, i : Int, v : Double) -> DstreetrieFrame {
  let result = ds_tree_trie_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_trie_frame_sum(s : DstreetrieFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_trie_frame_mean(s : DstreetrieFrame) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_trie_frame_sum(s) / s.size.to_double() }
}

pub fn ds_tree_trie_frame_scale(s : DstreetrieFrame, f : Double) -> DstreetrieFrame {
  let result = ds_tree_trie_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_trie_frame_add(a : DstreetrieFrame, b : DstreetrieFrame) -> DstreetrieFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_trie_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_trie_frame_copy(s : DstreetrieFrame) -> DstreetrieFrame {
  let result = ds_tree_trie_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_trie_frame_fill(s : DstreetrieFrame, v : Double) -> DstreetrieFrame {
  let result = ds_tree_trie_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_trie_frame_min(s : DstreetrieFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_trie_frame_max(s : DstreetrieFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_trie_frame_to_string(s : DstreetrieFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreetrieTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_trie_table_make(size : Int) -> DstreetrieTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_trie_table_len(s : DstreetrieTable) -> Int { s.size }

pub fn ds_tree_trie_table_get(s : DstreetrieTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_trie_table_set(s : DstreetrieTable, i : Int, v : Double) -> DstreetrieTable {
  let result = ds_tree_trie_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_trie_table_sum(s : DstreetrieTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_trie_table_mean(s : DstreetrieTable) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_trie_table_sum(s) / s.size.to_double() }
}

pub fn ds_tree_trie_table_scale(s : DstreetrieTable, f : Double) -> DstreetrieTable {
  let result = ds_tree_trie_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_trie_table_add(a : DstreetrieTable, b : DstreetrieTable) -> DstreetrieTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_trie_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_trie_table_copy(s : DstreetrieTable) -> DstreetrieTable {
  let result = ds_tree_trie_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_trie_table_fill(s : DstreetrieTable, v : Double) -> DstreetrieTable {
  let result = ds_tree_trie_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_trie_table_min(s : DstreetrieTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_trie_table_max(s : DstreetrieTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_trie_table_to_string(s : DstreetrieTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreetrieGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_trie_graphn_make(size : Int) -> DstreetrieGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_trie_graphn_len(s : DstreetrieGraphN) -> Int { s.size }

pub fn ds_tree_trie_graphn_get(s : DstreetrieGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_trie_graphn_set(s : DstreetrieGraphN, i : Int, v : Double) -> DstreetrieGraphN {
  let result = ds_tree_trie_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_trie_graphn_sum(s : DstreetrieGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_trie_graphn_mean(s : DstreetrieGraphN) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_trie_graphn_sum(s) / s.size.to_double() }
}

pub fn ds_tree_trie_graphn_scale(s : DstreetrieGraphN, f : Double) -> DstreetrieGraphN {
  let result = ds_tree_trie_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_trie_graphn_add(a : DstreetrieGraphN, b : DstreetrieGraphN) -> DstreetrieGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_trie_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_trie_graphn_copy(s : DstreetrieGraphN) -> DstreetrieGraphN {
  let result = ds_tree_trie_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_trie_graphn_fill(s : DstreetrieGraphN, v : Double) -> DstreetrieGraphN {
  let result = ds_tree_trie_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_trie_graphn_min(s : DstreetrieGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_trie_graphn_max(s : DstreetrieGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_trie_graphn_to_string(s : DstreetrieGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreetrieNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_trie_node_make(size : Int) -> DstreetrieNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_trie_node_len(s : DstreetrieNode) -> Int { s.size }

pub fn ds_tree_trie_node_get(s : DstreetrieNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_trie_node_set(s : DstreetrieNode, i : Int, v : Double) -> DstreetrieNode {
  let result = ds_tree_trie_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_trie_node_sum(s : DstreetrieNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_trie_node_mean(s : DstreetrieNode) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_trie_node_sum(s) / s.size.to_double() }
}

pub fn ds_tree_trie_node_scale(s : DstreetrieNode, f : Double) -> DstreetrieNode {
  let result = ds_tree_trie_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_trie_node_add(a : DstreetrieNode, b : DstreetrieNode) -> DstreetrieNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_trie_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_trie_node_copy(s : DstreetrieNode) -> DstreetrieNode {
  let result = ds_tree_trie_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_trie_node_fill(s : DstreetrieNode, v : Double) -> DstreetrieNode {
  let result = ds_tree_trie_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_trie_node_min(s : DstreetrieNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_trie_node_max(s : DstreetrieNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_trie_node_to_string(s : DstreetrieNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreetrieEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_trie_edge_make(size : Int) -> DstreetrieEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_trie_edge_len(s : DstreetrieEdge) -> Int { s.size }

pub fn ds_tree_trie_edge_get(s : DstreetrieEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_trie_edge_set(s : DstreetrieEdge, i : Int, v : Double) -> DstreetrieEdge {
  let result = ds_tree_trie_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_trie_edge_sum(s : DstreetrieEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_trie_edge_mean(s : DstreetrieEdge) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_trie_edge_sum(s) / s.size.to_double() }
}

pub fn ds_tree_trie_edge_scale(s : DstreetrieEdge, f : Double) -> DstreetrieEdge {
  let result = ds_tree_trie_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_trie_edge_add(a : DstreetrieEdge, b : DstreetrieEdge) -> DstreetrieEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_trie_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_trie_edge_copy(s : DstreetrieEdge) -> DstreetrieEdge {
  let result = ds_tree_trie_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_trie_edge_fill(s : DstreetrieEdge, v : Double) -> DstreetrieEdge {
  let result = ds_tree_trie_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_trie_edge_min(s : DstreetrieEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_trie_edge_max(s : DstreetrieEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_trie_edge_to_string(s : DstreetrieEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreetriePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_trie_path_make(size : Int) -> DstreetriePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_trie_path_len(s : DstreetriePath) -> Int { s.size }

pub fn ds_tree_trie_path_get(s : DstreetriePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_trie_path_set(s : DstreetriePath, i : Int, v : Double) -> DstreetriePath {
  let result = ds_tree_trie_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_trie_path_sum(s : DstreetriePath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_trie_path_mean(s : DstreetriePath) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_trie_path_sum(s) / s.size.to_double() }
}

pub fn ds_tree_trie_path_scale(s : DstreetriePath, f : Double) -> DstreetriePath {
  let result = ds_tree_trie_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_trie_path_add(a : DstreetriePath, b : DstreetriePath) -> DstreetriePath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_trie_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_trie_path_copy(s : DstreetriePath) -> DstreetriePath {
  let result = ds_tree_trie_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_trie_path_fill(s : DstreetriePath, v : Double) -> DstreetriePath {
  let result = ds_tree_trie_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_trie_path_min(s : DstreetriePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_trie_path_max(s : DstreetriePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_trie_path_to_string(s : DstreetriePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreetrieCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_trie_cluster_make(size : Int) -> DstreetrieCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_trie_cluster_len(s : DstreetrieCluster) -> Int { s.size }

pub fn ds_tree_trie_cluster_get(s : DstreetrieCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_trie_cluster_set(s : DstreetrieCluster, i : Int, v : Double) -> DstreetrieCluster {
  let result = ds_tree_trie_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_trie_cluster_sum(s : DstreetrieCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_trie_cluster_mean(s : DstreetrieCluster) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_trie_cluster_sum(s) / s.size.to_double() }
}

pub fn ds_tree_trie_cluster_scale(s : DstreetrieCluster, f : Double) -> DstreetrieCluster {
  let result = ds_tree_trie_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_trie_cluster_add(a : DstreetrieCluster, b : DstreetrieCluster) -> DstreetrieCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_trie_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_trie_cluster_copy(s : DstreetrieCluster) -> DstreetrieCluster {
  let result = ds_tree_trie_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_trie_cluster_fill(s : DstreetrieCluster, v : Double) -> DstreetrieCluster {
  let result = ds_tree_trie_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_trie_cluster_min(s : DstreetrieCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_trie_cluster_max(s : DstreetrieCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_trie_cluster_to_string(s : DstreetrieCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreetrieModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_trie_model_make(size : Int) -> DstreetrieModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_trie_model_len(s : DstreetrieModel) -> Int { s.size }

pub fn ds_tree_trie_model_get(s : DstreetrieModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_trie_model_set(s : DstreetrieModel, i : Int, v : Double) -> DstreetrieModel {
  let result = ds_tree_trie_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_trie_model_sum(s : DstreetrieModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_trie_model_mean(s : DstreetrieModel) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_trie_model_sum(s) / s.size.to_double() }
}

pub fn ds_tree_trie_model_scale(s : DstreetrieModel, f : Double) -> DstreetrieModel {
  let result = ds_tree_trie_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_trie_model_add(a : DstreetrieModel, b : DstreetrieModel) -> DstreetrieModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_trie_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_trie_model_copy(s : DstreetrieModel) -> DstreetrieModel {
  let result = ds_tree_trie_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_trie_model_fill(s : DstreetrieModel, v : Double) -> DstreetrieModel {
  let result = ds_tree_trie_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_trie_model_min(s : DstreetrieModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_trie_model_max(s : DstreetrieModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_trie_model_to_string(s : DstreetrieModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreetrieLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_trie_layer_make(size : Int) -> DstreetrieLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_trie_layer_len(s : DstreetrieLayer) -> Int { s.size }

pub fn ds_tree_trie_layer_get(s : DstreetrieLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_trie_layer_set(s : DstreetrieLayer, i : Int, v : Double) -> DstreetrieLayer {
  let result = ds_tree_trie_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_trie_layer_sum(s : DstreetrieLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_trie_layer_mean(s : DstreetrieLayer) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_trie_layer_sum(s) / s.size.to_double() }
}

pub fn ds_tree_trie_layer_scale(s : DstreetrieLayer, f : Double) -> DstreetrieLayer {
  let result = ds_tree_trie_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_trie_layer_add(a : DstreetrieLayer, b : DstreetrieLayer) -> DstreetrieLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_trie_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_trie_layer_copy(s : DstreetrieLayer) -> DstreetrieLayer {
  let result = ds_tree_trie_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_trie_layer_fill(s : DstreetrieLayer, v : Double) -> DstreetrieLayer {
  let result = ds_tree_trie_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_trie_layer_min(s : DstreetrieLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_trie_layer_max(s : DstreetrieLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_trie_layer_to_string(s : DstreetrieLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreetrieBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_trie_buffer_make(size : Int) -> DstreetrieBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_trie_buffer_len(s : DstreetrieBuffer) -> Int { s.size }

pub fn ds_tree_trie_buffer_get(s : DstreetrieBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_trie_buffer_set(s : DstreetrieBuffer, i : Int, v : Double) -> DstreetrieBuffer {
  let result = ds_tree_trie_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_trie_buffer_sum(s : DstreetrieBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_trie_buffer_mean(s : DstreetrieBuffer) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_trie_buffer_sum(s) / s.size.to_double() }
}

pub fn ds_tree_trie_buffer_scale(s : DstreetrieBuffer, f : Double) -> DstreetrieBuffer {
  let result = ds_tree_trie_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_trie_buffer_add(a : DstreetrieBuffer, b : DstreetrieBuffer) -> DstreetrieBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_trie_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_trie_buffer_copy(s : DstreetrieBuffer) -> DstreetrieBuffer {
  let result = ds_tree_trie_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_trie_buffer_fill(s : DstreetrieBuffer, v : Double) -> DstreetrieBuffer {
  let result = ds_tree_trie_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_trie_buffer_min(s : DstreetrieBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_trie_buffer_max(s : DstreetrieBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_trie_buffer_to_string(s : DstreetrieBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreetrieCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_trie_cursor_make(size : Int) -> DstreetrieCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_trie_cursor_len(s : DstreetrieCursor) -> Int { s.size }

pub fn ds_tree_trie_cursor_get(s : DstreetrieCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_trie_cursor_set(s : DstreetrieCursor, i : Int, v : Double) -> DstreetrieCursor {
  let result = ds_tree_trie_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_trie_cursor_sum(s : DstreetrieCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_trie_cursor_mean(s : DstreetrieCursor) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_trie_cursor_sum(s) / s.size.to_double() }
}

pub fn ds_tree_trie_cursor_scale(s : DstreetrieCursor, f : Double) -> DstreetrieCursor {
  let result = ds_tree_trie_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_trie_cursor_add(a : DstreetrieCursor, b : DstreetrieCursor) -> DstreetrieCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_trie_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_trie_cursor_copy(s : DstreetrieCursor) -> DstreetrieCursor {
  let result = ds_tree_trie_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_trie_cursor_fill(s : DstreetrieCursor, v : Double) -> DstreetrieCursor {
  let result = ds_tree_trie_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_trie_cursor_min(s : DstreetrieCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_trie_cursor_max(s : DstreetrieCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_trie_cursor_to_string(s : DstreetrieCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreetrieView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_trie_view_make(size : Int) -> DstreetrieView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_trie_view_len(s : DstreetrieView) -> Int { s.size }

pub fn ds_tree_trie_view_get(s : DstreetrieView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_trie_view_set(s : DstreetrieView, i : Int, v : Double) -> DstreetrieView {
  let result = ds_tree_trie_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_trie_view_sum(s : DstreetrieView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_trie_view_mean(s : DstreetrieView) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_trie_view_sum(s) / s.size.to_double() }
}

pub fn ds_tree_trie_view_scale(s : DstreetrieView, f : Double) -> DstreetrieView {
  let result = ds_tree_trie_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_trie_view_add(a : DstreetrieView, b : DstreetrieView) -> DstreetrieView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_trie_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_trie_view_copy(s : DstreetrieView) -> DstreetrieView {
  let result = ds_tree_trie_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_trie_view_fill(s : DstreetrieView, v : Double) -> DstreetrieView {
  let result = ds_tree_trie_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_trie_view_min(s : DstreetrieView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_trie_view_max(s : DstreetrieView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_trie_view_to_string(s : DstreetrieView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreetrieRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_trie_range_make(size : Int) -> DstreetrieRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_trie_range_len(s : DstreetrieRange) -> Int { s.size }

pub fn ds_tree_trie_range_get(s : DstreetrieRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_trie_range_set(s : DstreetrieRange, i : Int, v : Double) -> DstreetrieRange {
  let result = ds_tree_trie_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_trie_range_sum(s : DstreetrieRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_trie_range_mean(s : DstreetrieRange) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_trie_range_sum(s) / s.size.to_double() }
}

pub fn ds_tree_trie_range_scale(s : DstreetrieRange, f : Double) -> DstreetrieRange {
  let result = ds_tree_trie_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_trie_range_add(a : DstreetrieRange, b : DstreetrieRange) -> DstreetrieRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_trie_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_trie_range_copy(s : DstreetrieRange) -> DstreetrieRange {
  let result = ds_tree_trie_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_trie_range_fill(s : DstreetrieRange, v : Double) -> DstreetrieRange {
  let result = ds_tree_trie_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_trie_range_min(s : DstreetrieRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_trie_range_max(s : DstreetrieRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_trie_range_to_string(s : DstreetrieRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreetrieSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_trie_slice_make(size : Int) -> DstreetrieSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_trie_slice_len(s : DstreetrieSlice) -> Int { s.size }

pub fn ds_tree_trie_slice_get(s : DstreetrieSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_trie_slice_set(s : DstreetrieSlice, i : Int, v : Double) -> DstreetrieSlice {
  let result = ds_tree_trie_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_trie_slice_sum(s : DstreetrieSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_trie_slice_mean(s : DstreetrieSlice) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_trie_slice_sum(s) / s.size.to_double() }
}

pub fn ds_tree_trie_slice_scale(s : DstreetrieSlice, f : Double) -> DstreetrieSlice {
  let result = ds_tree_trie_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_trie_slice_add(a : DstreetrieSlice, b : DstreetrieSlice) -> DstreetrieSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_trie_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_trie_slice_copy(s : DstreetrieSlice) -> DstreetrieSlice {
  let result = ds_tree_trie_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_trie_slice_fill(s : DstreetrieSlice, v : Double) -> DstreetrieSlice {
  let result = ds_tree_trie_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_trie_slice_min(s : DstreetrieSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_trie_slice_max(s : DstreetrieSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_trie_slice_to_string(s : DstreetrieSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn ds_tree_trie_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_trie_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_trie_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_trie_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_trie_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_trie_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_trie_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_trie_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_trie_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_trie_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_trie_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_trie_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_trie_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_trie_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_trie_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_trie_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_trie_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_trie_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_trie_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_trie_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_trie_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_trie_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_trie_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_trie_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_trie_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}


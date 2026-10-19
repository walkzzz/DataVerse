///===
/// extcore/ds_tree_avl

pub(all) struct DstreeavlPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_tree_avl_make_point(x : Double, y : Double) -> DstreeavlPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_tree_avl_make_point3(x : Double, y : Double, z : Double) -> DstreeavlPoint {
  { x, y, z, label: 0 }
}

pub fn ds_tree_avl_point_x(pt : DstreeavlPoint) -> Double { pt.x }

pub fn ds_tree_avl_point_y(pt : DstreeavlPoint) -> Double { pt.y }

pub fn ds_tree_avl_point_z(pt : DstreeavlPoint) -> Double { pt.z }

pub fn ds_tree_avl_point_label(pt : DstreeavlPoint) -> Int { pt.label }

pub fn ds_tree_avl_point_dist(a : DstreeavlPoint, b : DstreeavlPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  ds_tree_avl_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ds_tree_avl_point_add(a : DstreeavlPoint, b : DstreeavlPoint) -> DstreeavlPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ds_tree_avl_point_sub(a : DstreeavlPoint, b : DstreeavlPoint) -> DstreeavlPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ds_tree_avl_point_scale(pt : DstreeavlPoint, s : Double) -> DstreeavlPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ds_tree_avl_point_dot(a : DstreeavlPoint, b : DstreeavlPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ds_tree_avl_point_cross(a : DstreeavlPoint, b : DstreeavlPoint) -> DstreeavlPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ds_tree_avl_point_norm(pt : DstreeavlPoint) -> Double {
  ds_tree_avl_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ds_tree_avl_point_normalize(pt : DstreeavlPoint) -> DstreeavlPoint {
  let n = ds_tree_avl_point_norm(pt)
  if n < 0.0000001 { pt } else { ds_tree_avl_point_scale(pt, 1.0 / n) }
}

pub fn ds_tree_avl_point_negate(pt : DstreeavlPoint) -> DstreeavlPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ds_tree_avl_point_mid(a : DstreeavlPoint, b : DstreeavlPoint) -> DstreeavlPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ds_tree_avl_point_lerp(a : DstreeavlPoint, b : DstreeavlPoint, t : Double) -> DstreeavlPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ds_tree_avl_point_to_string(pt : DstreeavlPoint) -> String {
  "(" + ds_tree_avl_dbl(pt.x) + ", " + ds_tree_avl_dbl(pt.y) + ", " + ds_tree_avl_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DstreeavlSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_tree_avl_make_series(vals : Array[Double], name : String) -> DstreeavlSeries {
  { vals, name, meta: 0 }
}

pub fn ds_tree_avl_series_len(s : DstreeavlSeries) -> Int { s.vals.length() }

pub fn ds_tree_avl_series_sum(s : DstreeavlSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn ds_tree_avl_series_mean(s : DstreeavlSeries) -> Double {
  let n = ds_tree_avl_series_len(s)
  if n == 0 { 0.0 } else { ds_tree_avl_series_sum(s) / n.to_double() }
}

pub fn ds_tree_avl_series_min(s : DstreeavlSeries) -> Double {
  let n = ds_tree_avl_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn ds_tree_avl_series_max(s : DstreeavlSeries) -> Double {
  let n = ds_tree_avl_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn ds_tree_avl_series_range(s : DstreeavlSeries) -> Double {
  ds_tree_avl_series_max(s) - ds_tree_avl_series_min(s)
}

pub fn ds_tree_avl_series_var(s : DstreeavlSeries) -> Double {
  let n = ds_tree_avl_series_len(s)
  if n == 0 { 0.0 } else {
    let m = ds_tree_avl_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn ds_tree_avl_series_std(s : DstreeavlSeries) -> Double { ds_tree_avl_sqrt(ds_tree_avl_series_var(s)) }

pub fn ds_tree_avl_series_median(s : DstreeavlSeries) -> Double {
  let n = ds_tree_avl_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = ds_tree_avl_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ds_tree_avl_series_scale(s : DstreeavlSeries, f : Double) -> DstreeavlSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = ds_tree_avl_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ds_tree_avl_series_add(a : DstreeavlSeries, b : DstreeavlSeries) -> DstreeavlSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = ds_tree_avl_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ds_tree_avl_series_sub(a : DstreeavlSeries, b : DstreeavlSeries) -> DstreeavlSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = ds_tree_avl_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ds_tree_avl_series_normalize(s : DstreeavlSeries) -> DstreeavlSeries {
  let mn = ds_tree_avl_series_min(s)
  let mx = ds_tree_avl_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = ds_tree_avl_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ds_tree_avl_series_cumsum(s : DstreeavlSeries) -> DstreeavlSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = ds_tree_avl_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn ds_tree_avl_series_to_string(s : DstreeavlSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + ds_tree_avl_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DstreeavlMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_tree_avl_make_matrix(rows : Int, cols : Int, val : Double) -> DstreeavlMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_tree_avl_matrix_identity(n : Int) -> DstreeavlMatrix {
  let m = ds_tree_avl_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ds_tree_avl_matrix_get(m : DstreeavlMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ds_tree_avl_matrix_transpose(m : DstreeavlMatrix) -> DstreeavlMatrix {
  let result = ds_tree_avl_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ds_tree_avl_matrix_add(a : DstreeavlMatrix, b : DstreeavlMatrix) -> DstreeavlMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ds_tree_avl_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ds_tree_avl_matrix_scale(m : DstreeavlMatrix, s : Double) -> DstreeavlMatrix {
  let result = ds_tree_avl_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ds_tree_avl_matrix_multiply(a : DstreeavlMatrix, b : DstreeavlMatrix) -> DstreeavlMatrix {
  if a.cols != b.rows { return ds_tree_avl_make_matrix(a.rows, b.cols, 0.0) }
  let result = ds_tree_avl_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ds_tree_avl_matrix_trace(m : DstreeavlMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ds_tree_avl_matrix_det(m : DstreeavlMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ds_tree_avl_matrix_norm(m : DstreeavlMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  ds_tree_avl_sqrt(sum)
}

pub fn ds_tree_avl_matrix_to_string(m : DstreeavlMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + ds_tree_avl_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct DstreeavlVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_tree_avl_make_vector(comps : Array[Double]) -> DstreeavlVector {
  { comps, dim: comps.length() }
}

pub fn ds_tree_avl_vector_zero(dim : Int) -> DstreeavlVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ds_tree_avl_vector_add(a : DstreeavlVector, b : DstreeavlVector) -> DstreeavlVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = ds_tree_avl_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_tree_avl_vector_sub(a : DstreeavlVector, b : DstreeavlVector) -> DstreeavlVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = ds_tree_avl_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_tree_avl_vector_scale(v : DstreeavlVector, s : Double) -> DstreeavlVector {
  let mut result = []
  for i in 0..<v.dim { result = ds_tree_avl_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ds_tree_avl_vector_dot(a : DstreeavlVector, b : DstreeavlVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ds_tree_avl_vector_norm(v : DstreeavlVector) -> Double { ds_tree_avl_sqrt(ds_tree_avl_vector_dot(v, v)) }

pub fn ds_tree_avl_vector_normalize(v : DstreeavlVector) -> DstreeavlVector {
  let n = ds_tree_avl_vector_norm(v)
  if n < 0.0000001 { v } else { ds_tree_avl_vector_scale(v, 1.0 / n) }
}

pub fn ds_tree_avl_vector_dist(a : DstreeavlVector, b : DstreeavlVector) -> Double {
  ds_tree_avl_vector_norm(ds_tree_avl_vector_sub(a, b))
}

pub fn ds_tree_avl_vector_to_string(v : DstreeavlVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + ds_tree_avl_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_tree_avl_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn ds_tree_avl_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = ds_tree_avl_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ds_tree_avl_std(data : Array[Double]) -> Double { ds_tree_avl_sqrt(ds_tree_avl_var(data)) }

pub fn ds_tree_avl_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = ds_tree_avl_mean(a); let mb = ds_tree_avl_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn ds_tree_avl_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = ds_tree_avl_std(a); let sb = ds_tree_avl_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { ds_tree_avl_cov(a, b) / (sa * sb) }
}

pub fn ds_tree_avl_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = ds_tree_avl_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ds_tree_avl_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn ds_tree_avl_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ds_tree_avl_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  ds_tree_avl_sqrt(ds_tree_avl_mse(pred, labels))
}

pub fn ds_tree_avl_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + ds_tree_avl_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn ds_tree_avl_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = ds_tree_avl_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn ds_tree_avl_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn ds_tree_avl_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn ds_tree_avl_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = ds_tree_avl_precision(pred, labels, pos); let r = ds_tree_avl_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn ds_tree_avl_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn ds_tree_avl_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = ds_tree_avl_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn ds_tree_avl_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn ds_tree_avl_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn ds_tree_avl_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = ds_tree_avl_gcd(a, b)
    (a / g) * b
  }
}

pub fn ds_tree_avl_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn ds_tree_avl_fibonacci(n : Int) -> Int {
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

pub fn ds_tree_avl_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = ds_tree_avl_min(data); let mx = ds_tree_avl_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn ds_tree_avl_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = ds_tree_avl_mean(data); let sd = ds_tree_avl_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn ds_tree_avl_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn ds_tree_avl_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn ds_tree_avl_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn ds_tree_avl_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn ds_tree_avl_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn ds_tree_avl_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn ds_tree_avl_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn ds_tree_avl_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn ds_tree_avl_dbl(x : Double) -> String {
  let i = if x >= 0.0 { ds_tree_avl_int(x) } else { -ds_tree_avl_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { ds_tree_avl_int(f * 1000000.0) } else { ds_tree_avl_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn ds_tree_avl_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn ds_tree_avl_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct DstreeavlFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_avl_frame_make(size : Int) -> DstreeavlFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_avl_frame_len(s : DstreeavlFrame) -> Int { s.size }

pub fn ds_tree_avl_frame_get(s : DstreeavlFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_avl_frame_set(s : DstreeavlFrame, i : Int, v : Double) -> DstreeavlFrame {
  let result = ds_tree_avl_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_avl_frame_sum(s : DstreeavlFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_avl_frame_mean(s : DstreeavlFrame) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_avl_frame_sum(s) / s.size.to_double() }
}

pub fn ds_tree_avl_frame_scale(s : DstreeavlFrame, f : Double) -> DstreeavlFrame {
  let result = ds_tree_avl_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_avl_frame_add(a : DstreeavlFrame, b : DstreeavlFrame) -> DstreeavlFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_avl_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_avl_frame_copy(s : DstreeavlFrame) -> DstreeavlFrame {
  let result = ds_tree_avl_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_avl_frame_fill(s : DstreeavlFrame, v : Double) -> DstreeavlFrame {
  let result = ds_tree_avl_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_avl_frame_min(s : DstreeavlFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_avl_frame_max(s : DstreeavlFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_avl_frame_to_string(s : DstreeavlFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreeavlTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_avl_table_make(size : Int) -> DstreeavlTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_avl_table_len(s : DstreeavlTable) -> Int { s.size }

pub fn ds_tree_avl_table_get(s : DstreeavlTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_avl_table_set(s : DstreeavlTable, i : Int, v : Double) -> DstreeavlTable {
  let result = ds_tree_avl_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_avl_table_sum(s : DstreeavlTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_avl_table_mean(s : DstreeavlTable) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_avl_table_sum(s) / s.size.to_double() }
}

pub fn ds_tree_avl_table_scale(s : DstreeavlTable, f : Double) -> DstreeavlTable {
  let result = ds_tree_avl_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_avl_table_add(a : DstreeavlTable, b : DstreeavlTable) -> DstreeavlTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_avl_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_avl_table_copy(s : DstreeavlTable) -> DstreeavlTable {
  let result = ds_tree_avl_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_avl_table_fill(s : DstreeavlTable, v : Double) -> DstreeavlTable {
  let result = ds_tree_avl_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_avl_table_min(s : DstreeavlTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_avl_table_max(s : DstreeavlTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_avl_table_to_string(s : DstreeavlTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreeavlGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_avl_graphn_make(size : Int) -> DstreeavlGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_avl_graphn_len(s : DstreeavlGraphN) -> Int { s.size }

pub fn ds_tree_avl_graphn_get(s : DstreeavlGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_avl_graphn_set(s : DstreeavlGraphN, i : Int, v : Double) -> DstreeavlGraphN {
  let result = ds_tree_avl_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_avl_graphn_sum(s : DstreeavlGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_avl_graphn_mean(s : DstreeavlGraphN) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_avl_graphn_sum(s) / s.size.to_double() }
}

pub fn ds_tree_avl_graphn_scale(s : DstreeavlGraphN, f : Double) -> DstreeavlGraphN {
  let result = ds_tree_avl_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_avl_graphn_add(a : DstreeavlGraphN, b : DstreeavlGraphN) -> DstreeavlGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_avl_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_avl_graphn_copy(s : DstreeavlGraphN) -> DstreeavlGraphN {
  let result = ds_tree_avl_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_avl_graphn_fill(s : DstreeavlGraphN, v : Double) -> DstreeavlGraphN {
  let result = ds_tree_avl_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_avl_graphn_min(s : DstreeavlGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_avl_graphn_max(s : DstreeavlGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_avl_graphn_to_string(s : DstreeavlGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreeavlNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_avl_node_make(size : Int) -> DstreeavlNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_avl_node_len(s : DstreeavlNode) -> Int { s.size }

pub fn ds_tree_avl_node_get(s : DstreeavlNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_avl_node_set(s : DstreeavlNode, i : Int, v : Double) -> DstreeavlNode {
  let result = ds_tree_avl_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_avl_node_sum(s : DstreeavlNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_avl_node_mean(s : DstreeavlNode) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_avl_node_sum(s) / s.size.to_double() }
}

pub fn ds_tree_avl_node_scale(s : DstreeavlNode, f : Double) -> DstreeavlNode {
  let result = ds_tree_avl_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_avl_node_add(a : DstreeavlNode, b : DstreeavlNode) -> DstreeavlNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_avl_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_avl_node_copy(s : DstreeavlNode) -> DstreeavlNode {
  let result = ds_tree_avl_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_avl_node_fill(s : DstreeavlNode, v : Double) -> DstreeavlNode {
  let result = ds_tree_avl_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_avl_node_min(s : DstreeavlNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_avl_node_max(s : DstreeavlNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_avl_node_to_string(s : DstreeavlNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreeavlEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_avl_edge_make(size : Int) -> DstreeavlEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_avl_edge_len(s : DstreeavlEdge) -> Int { s.size }

pub fn ds_tree_avl_edge_get(s : DstreeavlEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_avl_edge_set(s : DstreeavlEdge, i : Int, v : Double) -> DstreeavlEdge {
  let result = ds_tree_avl_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_avl_edge_sum(s : DstreeavlEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_avl_edge_mean(s : DstreeavlEdge) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_avl_edge_sum(s) / s.size.to_double() }
}

pub fn ds_tree_avl_edge_scale(s : DstreeavlEdge, f : Double) -> DstreeavlEdge {
  let result = ds_tree_avl_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_avl_edge_add(a : DstreeavlEdge, b : DstreeavlEdge) -> DstreeavlEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_avl_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_avl_edge_copy(s : DstreeavlEdge) -> DstreeavlEdge {
  let result = ds_tree_avl_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_avl_edge_fill(s : DstreeavlEdge, v : Double) -> DstreeavlEdge {
  let result = ds_tree_avl_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_avl_edge_min(s : DstreeavlEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_avl_edge_max(s : DstreeavlEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_avl_edge_to_string(s : DstreeavlEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreeavlPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_avl_path_make(size : Int) -> DstreeavlPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_avl_path_len(s : DstreeavlPath) -> Int { s.size }

pub fn ds_tree_avl_path_get(s : DstreeavlPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_avl_path_set(s : DstreeavlPath, i : Int, v : Double) -> DstreeavlPath {
  let result = ds_tree_avl_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_avl_path_sum(s : DstreeavlPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_avl_path_mean(s : DstreeavlPath) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_avl_path_sum(s) / s.size.to_double() }
}

pub fn ds_tree_avl_path_scale(s : DstreeavlPath, f : Double) -> DstreeavlPath {
  let result = ds_tree_avl_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_avl_path_add(a : DstreeavlPath, b : DstreeavlPath) -> DstreeavlPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_avl_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_avl_path_copy(s : DstreeavlPath) -> DstreeavlPath {
  let result = ds_tree_avl_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_avl_path_fill(s : DstreeavlPath, v : Double) -> DstreeavlPath {
  let result = ds_tree_avl_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_avl_path_min(s : DstreeavlPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_avl_path_max(s : DstreeavlPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_avl_path_to_string(s : DstreeavlPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreeavlCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_avl_cluster_make(size : Int) -> DstreeavlCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_avl_cluster_len(s : DstreeavlCluster) -> Int { s.size }

pub fn ds_tree_avl_cluster_get(s : DstreeavlCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_avl_cluster_set(s : DstreeavlCluster, i : Int, v : Double) -> DstreeavlCluster {
  let result = ds_tree_avl_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_avl_cluster_sum(s : DstreeavlCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_avl_cluster_mean(s : DstreeavlCluster) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_avl_cluster_sum(s) / s.size.to_double() }
}

pub fn ds_tree_avl_cluster_scale(s : DstreeavlCluster, f : Double) -> DstreeavlCluster {
  let result = ds_tree_avl_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_avl_cluster_add(a : DstreeavlCluster, b : DstreeavlCluster) -> DstreeavlCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_avl_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_avl_cluster_copy(s : DstreeavlCluster) -> DstreeavlCluster {
  let result = ds_tree_avl_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_avl_cluster_fill(s : DstreeavlCluster, v : Double) -> DstreeavlCluster {
  let result = ds_tree_avl_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_avl_cluster_min(s : DstreeavlCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_avl_cluster_max(s : DstreeavlCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_avl_cluster_to_string(s : DstreeavlCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreeavlModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_avl_model_make(size : Int) -> DstreeavlModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_avl_model_len(s : DstreeavlModel) -> Int { s.size }

pub fn ds_tree_avl_model_get(s : DstreeavlModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_avl_model_set(s : DstreeavlModel, i : Int, v : Double) -> DstreeavlModel {
  let result = ds_tree_avl_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_avl_model_sum(s : DstreeavlModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_avl_model_mean(s : DstreeavlModel) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_avl_model_sum(s) / s.size.to_double() }
}

pub fn ds_tree_avl_model_scale(s : DstreeavlModel, f : Double) -> DstreeavlModel {
  let result = ds_tree_avl_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_avl_model_add(a : DstreeavlModel, b : DstreeavlModel) -> DstreeavlModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_avl_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_avl_model_copy(s : DstreeavlModel) -> DstreeavlModel {
  let result = ds_tree_avl_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_avl_model_fill(s : DstreeavlModel, v : Double) -> DstreeavlModel {
  let result = ds_tree_avl_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_avl_model_min(s : DstreeavlModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_avl_model_max(s : DstreeavlModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_avl_model_to_string(s : DstreeavlModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreeavlLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_avl_layer_make(size : Int) -> DstreeavlLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_avl_layer_len(s : DstreeavlLayer) -> Int { s.size }

pub fn ds_tree_avl_layer_get(s : DstreeavlLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_avl_layer_set(s : DstreeavlLayer, i : Int, v : Double) -> DstreeavlLayer {
  let result = ds_tree_avl_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_avl_layer_sum(s : DstreeavlLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_avl_layer_mean(s : DstreeavlLayer) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_avl_layer_sum(s) / s.size.to_double() }
}

pub fn ds_tree_avl_layer_scale(s : DstreeavlLayer, f : Double) -> DstreeavlLayer {
  let result = ds_tree_avl_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_avl_layer_add(a : DstreeavlLayer, b : DstreeavlLayer) -> DstreeavlLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_avl_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_avl_layer_copy(s : DstreeavlLayer) -> DstreeavlLayer {
  let result = ds_tree_avl_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_avl_layer_fill(s : DstreeavlLayer, v : Double) -> DstreeavlLayer {
  let result = ds_tree_avl_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_avl_layer_min(s : DstreeavlLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_avl_layer_max(s : DstreeavlLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_avl_layer_to_string(s : DstreeavlLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreeavlBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_avl_buffer_make(size : Int) -> DstreeavlBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_avl_buffer_len(s : DstreeavlBuffer) -> Int { s.size }

pub fn ds_tree_avl_buffer_get(s : DstreeavlBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_avl_buffer_set(s : DstreeavlBuffer, i : Int, v : Double) -> DstreeavlBuffer {
  let result = ds_tree_avl_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_avl_buffer_sum(s : DstreeavlBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_avl_buffer_mean(s : DstreeavlBuffer) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_avl_buffer_sum(s) / s.size.to_double() }
}

pub fn ds_tree_avl_buffer_scale(s : DstreeavlBuffer, f : Double) -> DstreeavlBuffer {
  let result = ds_tree_avl_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_avl_buffer_add(a : DstreeavlBuffer, b : DstreeavlBuffer) -> DstreeavlBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_avl_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_avl_buffer_copy(s : DstreeavlBuffer) -> DstreeavlBuffer {
  let result = ds_tree_avl_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_avl_buffer_fill(s : DstreeavlBuffer, v : Double) -> DstreeavlBuffer {
  let result = ds_tree_avl_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_avl_buffer_min(s : DstreeavlBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_avl_buffer_max(s : DstreeavlBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_avl_buffer_to_string(s : DstreeavlBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreeavlCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_avl_cursor_make(size : Int) -> DstreeavlCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_avl_cursor_len(s : DstreeavlCursor) -> Int { s.size }

pub fn ds_tree_avl_cursor_get(s : DstreeavlCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_avl_cursor_set(s : DstreeavlCursor, i : Int, v : Double) -> DstreeavlCursor {
  let result = ds_tree_avl_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_avl_cursor_sum(s : DstreeavlCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_avl_cursor_mean(s : DstreeavlCursor) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_avl_cursor_sum(s) / s.size.to_double() }
}

pub fn ds_tree_avl_cursor_scale(s : DstreeavlCursor, f : Double) -> DstreeavlCursor {
  let result = ds_tree_avl_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_avl_cursor_add(a : DstreeavlCursor, b : DstreeavlCursor) -> DstreeavlCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_avl_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_avl_cursor_copy(s : DstreeavlCursor) -> DstreeavlCursor {
  let result = ds_tree_avl_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_avl_cursor_fill(s : DstreeavlCursor, v : Double) -> DstreeavlCursor {
  let result = ds_tree_avl_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_avl_cursor_min(s : DstreeavlCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_avl_cursor_max(s : DstreeavlCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_avl_cursor_to_string(s : DstreeavlCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreeavlView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_avl_view_make(size : Int) -> DstreeavlView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_avl_view_len(s : DstreeavlView) -> Int { s.size }

pub fn ds_tree_avl_view_get(s : DstreeavlView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_avl_view_set(s : DstreeavlView, i : Int, v : Double) -> DstreeavlView {
  let result = ds_tree_avl_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_avl_view_sum(s : DstreeavlView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_avl_view_mean(s : DstreeavlView) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_avl_view_sum(s) / s.size.to_double() }
}

pub fn ds_tree_avl_view_scale(s : DstreeavlView, f : Double) -> DstreeavlView {
  let result = ds_tree_avl_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_avl_view_add(a : DstreeavlView, b : DstreeavlView) -> DstreeavlView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_avl_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_avl_view_copy(s : DstreeavlView) -> DstreeavlView {
  let result = ds_tree_avl_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_avl_view_fill(s : DstreeavlView, v : Double) -> DstreeavlView {
  let result = ds_tree_avl_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_avl_view_min(s : DstreeavlView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_avl_view_max(s : DstreeavlView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_avl_view_to_string(s : DstreeavlView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreeavlRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_avl_range_make(size : Int) -> DstreeavlRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_avl_range_len(s : DstreeavlRange) -> Int { s.size }

pub fn ds_tree_avl_range_get(s : DstreeavlRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_avl_range_set(s : DstreeavlRange, i : Int, v : Double) -> DstreeavlRange {
  let result = ds_tree_avl_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_avl_range_sum(s : DstreeavlRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_avl_range_mean(s : DstreeavlRange) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_avl_range_sum(s) / s.size.to_double() }
}

pub fn ds_tree_avl_range_scale(s : DstreeavlRange, f : Double) -> DstreeavlRange {
  let result = ds_tree_avl_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_avl_range_add(a : DstreeavlRange, b : DstreeavlRange) -> DstreeavlRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_avl_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_avl_range_copy(s : DstreeavlRange) -> DstreeavlRange {
  let result = ds_tree_avl_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_avl_range_fill(s : DstreeavlRange, v : Double) -> DstreeavlRange {
  let result = ds_tree_avl_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_avl_range_min(s : DstreeavlRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_avl_range_max(s : DstreeavlRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_avl_range_to_string(s : DstreeavlRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreeavlSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_avl_slice_make(size : Int) -> DstreeavlSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_avl_slice_len(s : DstreeavlSlice) -> Int { s.size }

pub fn ds_tree_avl_slice_get(s : DstreeavlSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_avl_slice_set(s : DstreeavlSlice, i : Int, v : Double) -> DstreeavlSlice {
  let result = ds_tree_avl_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_avl_slice_sum(s : DstreeavlSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_avl_slice_mean(s : DstreeavlSlice) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_avl_slice_sum(s) / s.size.to_double() }
}

pub fn ds_tree_avl_slice_scale(s : DstreeavlSlice, f : Double) -> DstreeavlSlice {
  let result = ds_tree_avl_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_avl_slice_add(a : DstreeavlSlice, b : DstreeavlSlice) -> DstreeavlSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_avl_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_avl_slice_copy(s : DstreeavlSlice) -> DstreeavlSlice {
  let result = ds_tree_avl_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_avl_slice_fill(s : DstreeavlSlice, v : Double) -> DstreeavlSlice {
  let result = ds_tree_avl_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_avl_slice_min(s : DstreeavlSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_avl_slice_max(s : DstreeavlSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_avl_slice_to_string(s : DstreeavlSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn ds_tree_avl_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_avl_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_avl_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_avl_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_avl_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_avl_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_avl_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_avl_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_avl_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_avl_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_avl_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_avl_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_avl_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_avl_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_avl_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_avl_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_avl_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_avl_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_avl_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_avl_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_avl_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_avl_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_avl_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_avl_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_avl_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}


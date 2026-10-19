///===
/// extcore/ds_tree_fenwick

pub(all) struct DstreefenwickPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_tree_fenwick_make_point(x : Double, y : Double) -> DstreefenwickPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_tree_fenwick_make_point3(x : Double, y : Double, z : Double) -> DstreefenwickPoint {
  { x, y, z, label: 0 }
}

pub fn ds_tree_fenwick_point_x(pt : DstreefenwickPoint) -> Double { pt.x }

pub fn ds_tree_fenwick_point_y(pt : DstreefenwickPoint) -> Double { pt.y }

pub fn ds_tree_fenwick_point_z(pt : DstreefenwickPoint) -> Double { pt.z }

pub fn ds_tree_fenwick_point_label(pt : DstreefenwickPoint) -> Int { pt.label }

pub fn ds_tree_fenwick_point_dist(a : DstreefenwickPoint, b : DstreefenwickPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  ds_tree_fenwick_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ds_tree_fenwick_point_add(a : DstreefenwickPoint, b : DstreefenwickPoint) -> DstreefenwickPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ds_tree_fenwick_point_sub(a : DstreefenwickPoint, b : DstreefenwickPoint) -> DstreefenwickPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ds_tree_fenwick_point_scale(pt : DstreefenwickPoint, s : Double) -> DstreefenwickPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ds_tree_fenwick_point_dot(a : DstreefenwickPoint, b : DstreefenwickPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ds_tree_fenwick_point_cross(a : DstreefenwickPoint, b : DstreefenwickPoint) -> DstreefenwickPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ds_tree_fenwick_point_norm(pt : DstreefenwickPoint) -> Double {
  ds_tree_fenwick_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ds_tree_fenwick_point_normalize(pt : DstreefenwickPoint) -> DstreefenwickPoint {
  let n = ds_tree_fenwick_point_norm(pt)
  if n < 0.0000001 { pt } else { ds_tree_fenwick_point_scale(pt, 1.0 / n) }
}

pub fn ds_tree_fenwick_point_negate(pt : DstreefenwickPoint) -> DstreefenwickPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ds_tree_fenwick_point_mid(a : DstreefenwickPoint, b : DstreefenwickPoint) -> DstreefenwickPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ds_tree_fenwick_point_lerp(a : DstreefenwickPoint, b : DstreefenwickPoint, t : Double) -> DstreefenwickPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ds_tree_fenwick_point_to_string(pt : DstreefenwickPoint) -> String {
  "(" + ds_tree_fenwick_dbl(pt.x) + ", " + ds_tree_fenwick_dbl(pt.y) + ", " + ds_tree_fenwick_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DstreefenwickSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_tree_fenwick_make_series(vals : Array[Double], name : String) -> DstreefenwickSeries {
  { vals, name, meta: 0 }
}

pub fn ds_tree_fenwick_series_len(s : DstreefenwickSeries) -> Int { s.vals.length() }

pub fn ds_tree_fenwick_series_sum(s : DstreefenwickSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn ds_tree_fenwick_series_mean(s : DstreefenwickSeries) -> Double {
  let n = ds_tree_fenwick_series_len(s)
  if n == 0 { 0.0 } else { ds_tree_fenwick_series_sum(s) / n.to_double() }
}

pub fn ds_tree_fenwick_series_min(s : DstreefenwickSeries) -> Double {
  let n = ds_tree_fenwick_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn ds_tree_fenwick_series_max(s : DstreefenwickSeries) -> Double {
  let n = ds_tree_fenwick_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn ds_tree_fenwick_series_range(s : DstreefenwickSeries) -> Double {
  ds_tree_fenwick_series_max(s) - ds_tree_fenwick_series_min(s)
}

pub fn ds_tree_fenwick_series_var(s : DstreefenwickSeries) -> Double {
  let n = ds_tree_fenwick_series_len(s)
  if n == 0 { 0.0 } else {
    let m = ds_tree_fenwick_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn ds_tree_fenwick_series_std(s : DstreefenwickSeries) -> Double { ds_tree_fenwick_sqrt(ds_tree_fenwick_series_var(s)) }

pub fn ds_tree_fenwick_series_median(s : DstreefenwickSeries) -> Double {
  let n = ds_tree_fenwick_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = ds_tree_fenwick_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ds_tree_fenwick_series_scale(s : DstreefenwickSeries, f : Double) -> DstreefenwickSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = ds_tree_fenwick_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ds_tree_fenwick_series_add(a : DstreefenwickSeries, b : DstreefenwickSeries) -> DstreefenwickSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = ds_tree_fenwick_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ds_tree_fenwick_series_sub(a : DstreefenwickSeries, b : DstreefenwickSeries) -> DstreefenwickSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = ds_tree_fenwick_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ds_tree_fenwick_series_normalize(s : DstreefenwickSeries) -> DstreefenwickSeries {
  let mn = ds_tree_fenwick_series_min(s)
  let mx = ds_tree_fenwick_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = ds_tree_fenwick_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ds_tree_fenwick_series_cumsum(s : DstreefenwickSeries) -> DstreefenwickSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = ds_tree_fenwick_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn ds_tree_fenwick_series_to_string(s : DstreefenwickSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + ds_tree_fenwick_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DstreefenwickMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_tree_fenwick_make_matrix(rows : Int, cols : Int, val : Double) -> DstreefenwickMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_tree_fenwick_matrix_identity(n : Int) -> DstreefenwickMatrix {
  let m = ds_tree_fenwick_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ds_tree_fenwick_matrix_get(m : DstreefenwickMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ds_tree_fenwick_matrix_transpose(m : DstreefenwickMatrix) -> DstreefenwickMatrix {
  let result = ds_tree_fenwick_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ds_tree_fenwick_matrix_add(a : DstreefenwickMatrix, b : DstreefenwickMatrix) -> DstreefenwickMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ds_tree_fenwick_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ds_tree_fenwick_matrix_scale(m : DstreefenwickMatrix, s : Double) -> DstreefenwickMatrix {
  let result = ds_tree_fenwick_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ds_tree_fenwick_matrix_multiply(a : DstreefenwickMatrix, b : DstreefenwickMatrix) -> DstreefenwickMatrix {
  if a.cols != b.rows { return ds_tree_fenwick_make_matrix(a.rows, b.cols, 0.0) }
  let result = ds_tree_fenwick_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ds_tree_fenwick_matrix_trace(m : DstreefenwickMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ds_tree_fenwick_matrix_det(m : DstreefenwickMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ds_tree_fenwick_matrix_norm(m : DstreefenwickMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  ds_tree_fenwick_sqrt(sum)
}

pub fn ds_tree_fenwick_matrix_to_string(m : DstreefenwickMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + ds_tree_fenwick_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct DstreefenwickVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_tree_fenwick_make_vector(comps : Array[Double]) -> DstreefenwickVector {
  { comps, dim: comps.length() }
}

pub fn ds_tree_fenwick_vector_zero(dim : Int) -> DstreefenwickVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ds_tree_fenwick_vector_add(a : DstreefenwickVector, b : DstreefenwickVector) -> DstreefenwickVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = ds_tree_fenwick_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_tree_fenwick_vector_sub(a : DstreefenwickVector, b : DstreefenwickVector) -> DstreefenwickVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = ds_tree_fenwick_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_tree_fenwick_vector_scale(v : DstreefenwickVector, s : Double) -> DstreefenwickVector {
  let mut result = []
  for i in 0..<v.dim { result = ds_tree_fenwick_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ds_tree_fenwick_vector_dot(a : DstreefenwickVector, b : DstreefenwickVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ds_tree_fenwick_vector_norm(v : DstreefenwickVector) -> Double { ds_tree_fenwick_sqrt(ds_tree_fenwick_vector_dot(v, v)) }

pub fn ds_tree_fenwick_vector_normalize(v : DstreefenwickVector) -> DstreefenwickVector {
  let n = ds_tree_fenwick_vector_norm(v)
  if n < 0.0000001 { v } else { ds_tree_fenwick_vector_scale(v, 1.0 / n) }
}

pub fn ds_tree_fenwick_vector_dist(a : DstreefenwickVector, b : DstreefenwickVector) -> Double {
  ds_tree_fenwick_vector_norm(ds_tree_fenwick_vector_sub(a, b))
}

pub fn ds_tree_fenwick_vector_to_string(v : DstreefenwickVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + ds_tree_fenwick_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_tree_fenwick_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn ds_tree_fenwick_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = ds_tree_fenwick_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ds_tree_fenwick_std(data : Array[Double]) -> Double { ds_tree_fenwick_sqrt(ds_tree_fenwick_var(data)) }

pub fn ds_tree_fenwick_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = ds_tree_fenwick_mean(a); let mb = ds_tree_fenwick_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn ds_tree_fenwick_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = ds_tree_fenwick_std(a); let sb = ds_tree_fenwick_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { ds_tree_fenwick_cov(a, b) / (sa * sb) }
}

pub fn ds_tree_fenwick_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = ds_tree_fenwick_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ds_tree_fenwick_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn ds_tree_fenwick_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ds_tree_fenwick_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  ds_tree_fenwick_sqrt(ds_tree_fenwick_mse(pred, labels))
}

pub fn ds_tree_fenwick_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + ds_tree_fenwick_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn ds_tree_fenwick_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = ds_tree_fenwick_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn ds_tree_fenwick_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn ds_tree_fenwick_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn ds_tree_fenwick_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = ds_tree_fenwick_precision(pred, labels, pos); let r = ds_tree_fenwick_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn ds_tree_fenwick_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn ds_tree_fenwick_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = ds_tree_fenwick_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn ds_tree_fenwick_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn ds_tree_fenwick_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn ds_tree_fenwick_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = ds_tree_fenwick_gcd(a, b)
    (a / g) * b
  }
}

pub fn ds_tree_fenwick_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn ds_tree_fenwick_fibonacci(n : Int) -> Int {
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

pub fn ds_tree_fenwick_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = ds_tree_fenwick_min(data); let mx = ds_tree_fenwick_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn ds_tree_fenwick_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = ds_tree_fenwick_mean(data); let sd = ds_tree_fenwick_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn ds_tree_fenwick_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn ds_tree_fenwick_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn ds_tree_fenwick_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn ds_tree_fenwick_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn ds_tree_fenwick_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn ds_tree_fenwick_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn ds_tree_fenwick_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn ds_tree_fenwick_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn ds_tree_fenwick_dbl(x : Double) -> String {
  let i = if x >= 0.0 { ds_tree_fenwick_int(x) } else { -ds_tree_fenwick_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { ds_tree_fenwick_int(f * 1000000.0) } else { ds_tree_fenwick_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn ds_tree_fenwick_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn ds_tree_fenwick_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct DstreefenwickFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_fenwick_frame_make(size : Int) -> DstreefenwickFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_fenwick_frame_len(s : DstreefenwickFrame) -> Int { s.size }

pub fn ds_tree_fenwick_frame_get(s : DstreefenwickFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_fenwick_frame_set(s : DstreefenwickFrame, i : Int, v : Double) -> DstreefenwickFrame {
  let result = ds_tree_fenwick_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_fenwick_frame_sum(s : DstreefenwickFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_fenwick_frame_mean(s : DstreefenwickFrame) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_fenwick_frame_sum(s) / s.size.to_double() }
}

pub fn ds_tree_fenwick_frame_scale(s : DstreefenwickFrame, f : Double) -> DstreefenwickFrame {
  let result = ds_tree_fenwick_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_fenwick_frame_add(a : DstreefenwickFrame, b : DstreefenwickFrame) -> DstreefenwickFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_fenwick_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_fenwick_frame_copy(s : DstreefenwickFrame) -> DstreefenwickFrame {
  let result = ds_tree_fenwick_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_fenwick_frame_fill(s : DstreefenwickFrame, v : Double) -> DstreefenwickFrame {
  let result = ds_tree_fenwick_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_fenwick_frame_min(s : DstreefenwickFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_fenwick_frame_max(s : DstreefenwickFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_fenwick_frame_to_string(s : DstreefenwickFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreefenwickTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_fenwick_table_make(size : Int) -> DstreefenwickTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_fenwick_table_len(s : DstreefenwickTable) -> Int { s.size }

pub fn ds_tree_fenwick_table_get(s : DstreefenwickTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_fenwick_table_set(s : DstreefenwickTable, i : Int, v : Double) -> DstreefenwickTable {
  let result = ds_tree_fenwick_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_fenwick_table_sum(s : DstreefenwickTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_fenwick_table_mean(s : DstreefenwickTable) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_fenwick_table_sum(s) / s.size.to_double() }
}

pub fn ds_tree_fenwick_table_scale(s : DstreefenwickTable, f : Double) -> DstreefenwickTable {
  let result = ds_tree_fenwick_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_fenwick_table_add(a : DstreefenwickTable, b : DstreefenwickTable) -> DstreefenwickTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_fenwick_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_fenwick_table_copy(s : DstreefenwickTable) -> DstreefenwickTable {
  let result = ds_tree_fenwick_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_fenwick_table_fill(s : DstreefenwickTable, v : Double) -> DstreefenwickTable {
  let result = ds_tree_fenwick_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_fenwick_table_min(s : DstreefenwickTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_fenwick_table_max(s : DstreefenwickTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_fenwick_table_to_string(s : DstreefenwickTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreefenwickGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_fenwick_graphn_make(size : Int) -> DstreefenwickGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_fenwick_graphn_len(s : DstreefenwickGraphN) -> Int { s.size }

pub fn ds_tree_fenwick_graphn_get(s : DstreefenwickGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_fenwick_graphn_set(s : DstreefenwickGraphN, i : Int, v : Double) -> DstreefenwickGraphN {
  let result = ds_tree_fenwick_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_fenwick_graphn_sum(s : DstreefenwickGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_fenwick_graphn_mean(s : DstreefenwickGraphN) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_fenwick_graphn_sum(s) / s.size.to_double() }
}

pub fn ds_tree_fenwick_graphn_scale(s : DstreefenwickGraphN, f : Double) -> DstreefenwickGraphN {
  let result = ds_tree_fenwick_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_fenwick_graphn_add(a : DstreefenwickGraphN, b : DstreefenwickGraphN) -> DstreefenwickGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_fenwick_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_fenwick_graphn_copy(s : DstreefenwickGraphN) -> DstreefenwickGraphN {
  let result = ds_tree_fenwick_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_fenwick_graphn_fill(s : DstreefenwickGraphN, v : Double) -> DstreefenwickGraphN {
  let result = ds_tree_fenwick_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_fenwick_graphn_min(s : DstreefenwickGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_fenwick_graphn_max(s : DstreefenwickGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_fenwick_graphn_to_string(s : DstreefenwickGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreefenwickNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_fenwick_node_make(size : Int) -> DstreefenwickNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_fenwick_node_len(s : DstreefenwickNode) -> Int { s.size }

pub fn ds_tree_fenwick_node_get(s : DstreefenwickNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_fenwick_node_set(s : DstreefenwickNode, i : Int, v : Double) -> DstreefenwickNode {
  let result = ds_tree_fenwick_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_fenwick_node_sum(s : DstreefenwickNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_fenwick_node_mean(s : DstreefenwickNode) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_fenwick_node_sum(s) / s.size.to_double() }
}

pub fn ds_tree_fenwick_node_scale(s : DstreefenwickNode, f : Double) -> DstreefenwickNode {
  let result = ds_tree_fenwick_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_fenwick_node_add(a : DstreefenwickNode, b : DstreefenwickNode) -> DstreefenwickNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_fenwick_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_fenwick_node_copy(s : DstreefenwickNode) -> DstreefenwickNode {
  let result = ds_tree_fenwick_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_fenwick_node_fill(s : DstreefenwickNode, v : Double) -> DstreefenwickNode {
  let result = ds_tree_fenwick_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_fenwick_node_min(s : DstreefenwickNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_fenwick_node_max(s : DstreefenwickNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_fenwick_node_to_string(s : DstreefenwickNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreefenwickEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_fenwick_edge_make(size : Int) -> DstreefenwickEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_fenwick_edge_len(s : DstreefenwickEdge) -> Int { s.size }

pub fn ds_tree_fenwick_edge_get(s : DstreefenwickEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_fenwick_edge_set(s : DstreefenwickEdge, i : Int, v : Double) -> DstreefenwickEdge {
  let result = ds_tree_fenwick_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_fenwick_edge_sum(s : DstreefenwickEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_fenwick_edge_mean(s : DstreefenwickEdge) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_fenwick_edge_sum(s) / s.size.to_double() }
}

pub fn ds_tree_fenwick_edge_scale(s : DstreefenwickEdge, f : Double) -> DstreefenwickEdge {
  let result = ds_tree_fenwick_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_fenwick_edge_add(a : DstreefenwickEdge, b : DstreefenwickEdge) -> DstreefenwickEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_fenwick_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_fenwick_edge_copy(s : DstreefenwickEdge) -> DstreefenwickEdge {
  let result = ds_tree_fenwick_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_fenwick_edge_fill(s : DstreefenwickEdge, v : Double) -> DstreefenwickEdge {
  let result = ds_tree_fenwick_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_fenwick_edge_min(s : DstreefenwickEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_fenwick_edge_max(s : DstreefenwickEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_fenwick_edge_to_string(s : DstreefenwickEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreefenwickPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_fenwick_path_make(size : Int) -> DstreefenwickPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_fenwick_path_len(s : DstreefenwickPath) -> Int { s.size }

pub fn ds_tree_fenwick_path_get(s : DstreefenwickPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_fenwick_path_set(s : DstreefenwickPath, i : Int, v : Double) -> DstreefenwickPath {
  let result = ds_tree_fenwick_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_fenwick_path_sum(s : DstreefenwickPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_fenwick_path_mean(s : DstreefenwickPath) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_fenwick_path_sum(s) / s.size.to_double() }
}

pub fn ds_tree_fenwick_path_scale(s : DstreefenwickPath, f : Double) -> DstreefenwickPath {
  let result = ds_tree_fenwick_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_fenwick_path_add(a : DstreefenwickPath, b : DstreefenwickPath) -> DstreefenwickPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_fenwick_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_fenwick_path_copy(s : DstreefenwickPath) -> DstreefenwickPath {
  let result = ds_tree_fenwick_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_fenwick_path_fill(s : DstreefenwickPath, v : Double) -> DstreefenwickPath {
  let result = ds_tree_fenwick_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_fenwick_path_min(s : DstreefenwickPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_fenwick_path_max(s : DstreefenwickPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_fenwick_path_to_string(s : DstreefenwickPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreefenwickCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_fenwick_cluster_make(size : Int) -> DstreefenwickCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_fenwick_cluster_len(s : DstreefenwickCluster) -> Int { s.size }

pub fn ds_tree_fenwick_cluster_get(s : DstreefenwickCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_fenwick_cluster_set(s : DstreefenwickCluster, i : Int, v : Double) -> DstreefenwickCluster {
  let result = ds_tree_fenwick_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_fenwick_cluster_sum(s : DstreefenwickCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_fenwick_cluster_mean(s : DstreefenwickCluster) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_fenwick_cluster_sum(s) / s.size.to_double() }
}

pub fn ds_tree_fenwick_cluster_scale(s : DstreefenwickCluster, f : Double) -> DstreefenwickCluster {
  let result = ds_tree_fenwick_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_fenwick_cluster_add(a : DstreefenwickCluster, b : DstreefenwickCluster) -> DstreefenwickCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_fenwick_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_fenwick_cluster_copy(s : DstreefenwickCluster) -> DstreefenwickCluster {
  let result = ds_tree_fenwick_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_fenwick_cluster_fill(s : DstreefenwickCluster, v : Double) -> DstreefenwickCluster {
  let result = ds_tree_fenwick_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_fenwick_cluster_min(s : DstreefenwickCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_fenwick_cluster_max(s : DstreefenwickCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_fenwick_cluster_to_string(s : DstreefenwickCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreefenwickModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_fenwick_model_make(size : Int) -> DstreefenwickModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_fenwick_model_len(s : DstreefenwickModel) -> Int { s.size }

pub fn ds_tree_fenwick_model_get(s : DstreefenwickModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_fenwick_model_set(s : DstreefenwickModel, i : Int, v : Double) -> DstreefenwickModel {
  let result = ds_tree_fenwick_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_fenwick_model_sum(s : DstreefenwickModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_fenwick_model_mean(s : DstreefenwickModel) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_fenwick_model_sum(s) / s.size.to_double() }
}

pub fn ds_tree_fenwick_model_scale(s : DstreefenwickModel, f : Double) -> DstreefenwickModel {
  let result = ds_tree_fenwick_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_fenwick_model_add(a : DstreefenwickModel, b : DstreefenwickModel) -> DstreefenwickModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_fenwick_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_fenwick_model_copy(s : DstreefenwickModel) -> DstreefenwickModel {
  let result = ds_tree_fenwick_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_fenwick_model_fill(s : DstreefenwickModel, v : Double) -> DstreefenwickModel {
  let result = ds_tree_fenwick_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_fenwick_model_min(s : DstreefenwickModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_fenwick_model_max(s : DstreefenwickModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_fenwick_model_to_string(s : DstreefenwickModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreefenwickLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_fenwick_layer_make(size : Int) -> DstreefenwickLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_fenwick_layer_len(s : DstreefenwickLayer) -> Int { s.size }

pub fn ds_tree_fenwick_layer_get(s : DstreefenwickLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_fenwick_layer_set(s : DstreefenwickLayer, i : Int, v : Double) -> DstreefenwickLayer {
  let result = ds_tree_fenwick_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_fenwick_layer_sum(s : DstreefenwickLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_fenwick_layer_mean(s : DstreefenwickLayer) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_fenwick_layer_sum(s) / s.size.to_double() }
}

pub fn ds_tree_fenwick_layer_scale(s : DstreefenwickLayer, f : Double) -> DstreefenwickLayer {
  let result = ds_tree_fenwick_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_fenwick_layer_add(a : DstreefenwickLayer, b : DstreefenwickLayer) -> DstreefenwickLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_fenwick_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_fenwick_layer_copy(s : DstreefenwickLayer) -> DstreefenwickLayer {
  let result = ds_tree_fenwick_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_fenwick_layer_fill(s : DstreefenwickLayer, v : Double) -> DstreefenwickLayer {
  let result = ds_tree_fenwick_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_fenwick_layer_min(s : DstreefenwickLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_fenwick_layer_max(s : DstreefenwickLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_fenwick_layer_to_string(s : DstreefenwickLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreefenwickBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_fenwick_buffer_make(size : Int) -> DstreefenwickBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_fenwick_buffer_len(s : DstreefenwickBuffer) -> Int { s.size }

pub fn ds_tree_fenwick_buffer_get(s : DstreefenwickBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_fenwick_buffer_set(s : DstreefenwickBuffer, i : Int, v : Double) -> DstreefenwickBuffer {
  let result = ds_tree_fenwick_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_fenwick_buffer_sum(s : DstreefenwickBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_fenwick_buffer_mean(s : DstreefenwickBuffer) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_fenwick_buffer_sum(s) / s.size.to_double() }
}

pub fn ds_tree_fenwick_buffer_scale(s : DstreefenwickBuffer, f : Double) -> DstreefenwickBuffer {
  let result = ds_tree_fenwick_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_fenwick_buffer_add(a : DstreefenwickBuffer, b : DstreefenwickBuffer) -> DstreefenwickBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_fenwick_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_fenwick_buffer_copy(s : DstreefenwickBuffer) -> DstreefenwickBuffer {
  let result = ds_tree_fenwick_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_fenwick_buffer_fill(s : DstreefenwickBuffer, v : Double) -> DstreefenwickBuffer {
  let result = ds_tree_fenwick_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_fenwick_buffer_min(s : DstreefenwickBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_fenwick_buffer_max(s : DstreefenwickBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_fenwick_buffer_to_string(s : DstreefenwickBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreefenwickCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_fenwick_cursor_make(size : Int) -> DstreefenwickCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_fenwick_cursor_len(s : DstreefenwickCursor) -> Int { s.size }

pub fn ds_tree_fenwick_cursor_get(s : DstreefenwickCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_fenwick_cursor_set(s : DstreefenwickCursor, i : Int, v : Double) -> DstreefenwickCursor {
  let result = ds_tree_fenwick_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_fenwick_cursor_sum(s : DstreefenwickCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_fenwick_cursor_mean(s : DstreefenwickCursor) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_fenwick_cursor_sum(s) / s.size.to_double() }
}

pub fn ds_tree_fenwick_cursor_scale(s : DstreefenwickCursor, f : Double) -> DstreefenwickCursor {
  let result = ds_tree_fenwick_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_fenwick_cursor_add(a : DstreefenwickCursor, b : DstreefenwickCursor) -> DstreefenwickCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_fenwick_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_fenwick_cursor_copy(s : DstreefenwickCursor) -> DstreefenwickCursor {
  let result = ds_tree_fenwick_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_fenwick_cursor_fill(s : DstreefenwickCursor, v : Double) -> DstreefenwickCursor {
  let result = ds_tree_fenwick_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_fenwick_cursor_min(s : DstreefenwickCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_fenwick_cursor_max(s : DstreefenwickCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_fenwick_cursor_to_string(s : DstreefenwickCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreefenwickView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_fenwick_view_make(size : Int) -> DstreefenwickView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_fenwick_view_len(s : DstreefenwickView) -> Int { s.size }

pub fn ds_tree_fenwick_view_get(s : DstreefenwickView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_fenwick_view_set(s : DstreefenwickView, i : Int, v : Double) -> DstreefenwickView {
  let result = ds_tree_fenwick_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_fenwick_view_sum(s : DstreefenwickView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_fenwick_view_mean(s : DstreefenwickView) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_fenwick_view_sum(s) / s.size.to_double() }
}

pub fn ds_tree_fenwick_view_scale(s : DstreefenwickView, f : Double) -> DstreefenwickView {
  let result = ds_tree_fenwick_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_fenwick_view_add(a : DstreefenwickView, b : DstreefenwickView) -> DstreefenwickView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_fenwick_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_fenwick_view_copy(s : DstreefenwickView) -> DstreefenwickView {
  let result = ds_tree_fenwick_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_fenwick_view_fill(s : DstreefenwickView, v : Double) -> DstreefenwickView {
  let result = ds_tree_fenwick_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_fenwick_view_min(s : DstreefenwickView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_fenwick_view_max(s : DstreefenwickView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_fenwick_view_to_string(s : DstreefenwickView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreefenwickRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_fenwick_range_make(size : Int) -> DstreefenwickRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_fenwick_range_len(s : DstreefenwickRange) -> Int { s.size }

pub fn ds_tree_fenwick_range_get(s : DstreefenwickRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_fenwick_range_set(s : DstreefenwickRange, i : Int, v : Double) -> DstreefenwickRange {
  let result = ds_tree_fenwick_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_fenwick_range_sum(s : DstreefenwickRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_fenwick_range_mean(s : DstreefenwickRange) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_fenwick_range_sum(s) / s.size.to_double() }
}

pub fn ds_tree_fenwick_range_scale(s : DstreefenwickRange, f : Double) -> DstreefenwickRange {
  let result = ds_tree_fenwick_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_fenwick_range_add(a : DstreefenwickRange, b : DstreefenwickRange) -> DstreefenwickRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_fenwick_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_fenwick_range_copy(s : DstreefenwickRange) -> DstreefenwickRange {
  let result = ds_tree_fenwick_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_fenwick_range_fill(s : DstreefenwickRange, v : Double) -> DstreefenwickRange {
  let result = ds_tree_fenwick_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_fenwick_range_min(s : DstreefenwickRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_fenwick_range_max(s : DstreefenwickRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_fenwick_range_to_string(s : DstreefenwickRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreefenwickSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_fenwick_slice_make(size : Int) -> DstreefenwickSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_fenwick_slice_len(s : DstreefenwickSlice) -> Int { s.size }

pub fn ds_tree_fenwick_slice_get(s : DstreefenwickSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_fenwick_slice_set(s : DstreefenwickSlice, i : Int, v : Double) -> DstreefenwickSlice {
  let result = ds_tree_fenwick_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_fenwick_slice_sum(s : DstreefenwickSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_fenwick_slice_mean(s : DstreefenwickSlice) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_fenwick_slice_sum(s) / s.size.to_double() }
}

pub fn ds_tree_fenwick_slice_scale(s : DstreefenwickSlice, f : Double) -> DstreefenwickSlice {
  let result = ds_tree_fenwick_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_fenwick_slice_add(a : DstreefenwickSlice, b : DstreefenwickSlice) -> DstreefenwickSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_fenwick_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_fenwick_slice_copy(s : DstreefenwickSlice) -> DstreefenwickSlice {
  let result = ds_tree_fenwick_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_fenwick_slice_fill(s : DstreefenwickSlice, v : Double) -> DstreefenwickSlice {
  let result = ds_tree_fenwick_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_fenwick_slice_min(s : DstreefenwickSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_fenwick_slice_max(s : DstreefenwickSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_fenwick_slice_to_string(s : DstreefenwickSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn ds_tree_fenwick_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_fenwick_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_fenwick_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_fenwick_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_fenwick_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_fenwick_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_fenwick_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_fenwick_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_fenwick_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_fenwick_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_fenwick_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_fenwick_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_fenwick_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_fenwick_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_fenwick_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_fenwick_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_fenwick_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_fenwick_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_fenwick_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_fenwick_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_fenwick_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_fenwick_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_fenwick_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_fenwick_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_tree_fenwick_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}


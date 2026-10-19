///===
/// extcore/ds_hash_linear

pub(all) struct DshashlinearPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_hash_linear_make_point(x : Double, y : Double) -> DshashlinearPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_hash_linear_make_point3(x : Double, y : Double, z : Double) -> DshashlinearPoint {
  { x, y, z, label: 0 }
}

pub fn ds_hash_linear_point_x(pt : DshashlinearPoint) -> Double { pt.x }

pub fn ds_hash_linear_point_y(pt : DshashlinearPoint) -> Double { pt.y }

pub fn ds_hash_linear_point_z(pt : DshashlinearPoint) -> Double { pt.z }

pub fn ds_hash_linear_point_label(pt : DshashlinearPoint) -> Int { pt.label }

pub fn ds_hash_linear_point_dist(a : DshashlinearPoint, b : DshashlinearPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  ds_hash_linear_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ds_hash_linear_point_add(a : DshashlinearPoint, b : DshashlinearPoint) -> DshashlinearPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ds_hash_linear_point_sub(a : DshashlinearPoint, b : DshashlinearPoint) -> DshashlinearPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ds_hash_linear_point_scale(pt : DshashlinearPoint, s : Double) -> DshashlinearPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ds_hash_linear_point_dot(a : DshashlinearPoint, b : DshashlinearPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ds_hash_linear_point_cross(a : DshashlinearPoint, b : DshashlinearPoint) -> DshashlinearPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ds_hash_linear_point_norm(pt : DshashlinearPoint) -> Double {
  ds_hash_linear_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ds_hash_linear_point_normalize(pt : DshashlinearPoint) -> DshashlinearPoint {
  let n = ds_hash_linear_point_norm(pt)
  if n < 0.0000001 { pt } else { ds_hash_linear_point_scale(pt, 1.0 / n) }
}

pub fn ds_hash_linear_point_negate(pt : DshashlinearPoint) -> DshashlinearPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ds_hash_linear_point_mid(a : DshashlinearPoint, b : DshashlinearPoint) -> DshashlinearPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ds_hash_linear_point_lerp(a : DshashlinearPoint, b : DshashlinearPoint, t : Double) -> DshashlinearPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ds_hash_linear_point_to_string(pt : DshashlinearPoint) -> String {
  "(" + ds_hash_linear_dbl(pt.x) + ", " + ds_hash_linear_dbl(pt.y) + ", " + ds_hash_linear_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DshashlinearSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_hash_linear_make_series(vals : Array[Double], name : String) -> DshashlinearSeries {
  { vals, name, meta: 0 }
}

pub fn ds_hash_linear_series_len(s : DshashlinearSeries) -> Int { s.vals.length() }

pub fn ds_hash_linear_series_sum(s : DshashlinearSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn ds_hash_linear_series_mean(s : DshashlinearSeries) -> Double {
  let n = ds_hash_linear_series_len(s)
  if n == 0 { 0.0 } else { ds_hash_linear_series_sum(s) / n.to_double() }
}

pub fn ds_hash_linear_series_min(s : DshashlinearSeries) -> Double {
  let n = ds_hash_linear_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn ds_hash_linear_series_max(s : DshashlinearSeries) -> Double {
  let n = ds_hash_linear_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn ds_hash_linear_series_range(s : DshashlinearSeries) -> Double {
  ds_hash_linear_series_max(s) - ds_hash_linear_series_min(s)
}

pub fn ds_hash_linear_series_var(s : DshashlinearSeries) -> Double {
  let n = ds_hash_linear_series_len(s)
  if n == 0 { 0.0 } else {
    let m = ds_hash_linear_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn ds_hash_linear_series_std(s : DshashlinearSeries) -> Double { ds_hash_linear_sqrt(ds_hash_linear_series_var(s)) }

pub fn ds_hash_linear_series_median(s : DshashlinearSeries) -> Double {
  let n = ds_hash_linear_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = ds_hash_linear_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ds_hash_linear_series_scale(s : DshashlinearSeries, f : Double) -> DshashlinearSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = ds_hash_linear_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ds_hash_linear_series_add(a : DshashlinearSeries, b : DshashlinearSeries) -> DshashlinearSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = ds_hash_linear_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ds_hash_linear_series_sub(a : DshashlinearSeries, b : DshashlinearSeries) -> DshashlinearSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = ds_hash_linear_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ds_hash_linear_series_normalize(s : DshashlinearSeries) -> DshashlinearSeries {
  let mn = ds_hash_linear_series_min(s)
  let mx = ds_hash_linear_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = ds_hash_linear_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ds_hash_linear_series_cumsum(s : DshashlinearSeries) -> DshashlinearSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = ds_hash_linear_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn ds_hash_linear_series_to_string(s : DshashlinearSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + ds_hash_linear_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DshashlinearMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_hash_linear_make_matrix(rows : Int, cols : Int, val : Double) -> DshashlinearMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_hash_linear_matrix_identity(n : Int) -> DshashlinearMatrix {
  let m = ds_hash_linear_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ds_hash_linear_matrix_get(m : DshashlinearMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ds_hash_linear_matrix_transpose(m : DshashlinearMatrix) -> DshashlinearMatrix {
  let result = ds_hash_linear_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ds_hash_linear_matrix_add(a : DshashlinearMatrix, b : DshashlinearMatrix) -> DshashlinearMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ds_hash_linear_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ds_hash_linear_matrix_scale(m : DshashlinearMatrix, s : Double) -> DshashlinearMatrix {
  let result = ds_hash_linear_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ds_hash_linear_matrix_multiply(a : DshashlinearMatrix, b : DshashlinearMatrix) -> DshashlinearMatrix {
  if a.cols != b.rows { return ds_hash_linear_make_matrix(a.rows, b.cols, 0.0) }
  let result = ds_hash_linear_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ds_hash_linear_matrix_trace(m : DshashlinearMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ds_hash_linear_matrix_det(m : DshashlinearMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ds_hash_linear_matrix_norm(m : DshashlinearMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  ds_hash_linear_sqrt(sum)
}

pub fn ds_hash_linear_matrix_to_string(m : DshashlinearMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + ds_hash_linear_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct DshashlinearVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_hash_linear_make_vector(comps : Array[Double]) -> DshashlinearVector {
  { comps, dim: comps.length() }
}

pub fn ds_hash_linear_vector_zero(dim : Int) -> DshashlinearVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ds_hash_linear_vector_add(a : DshashlinearVector, b : DshashlinearVector) -> DshashlinearVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = ds_hash_linear_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_hash_linear_vector_sub(a : DshashlinearVector, b : DshashlinearVector) -> DshashlinearVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = ds_hash_linear_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_hash_linear_vector_scale(v : DshashlinearVector, s : Double) -> DshashlinearVector {
  let mut result = []
  for i in 0..<v.dim { result = ds_hash_linear_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ds_hash_linear_vector_dot(a : DshashlinearVector, b : DshashlinearVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ds_hash_linear_vector_norm(v : DshashlinearVector) -> Double { ds_hash_linear_sqrt(ds_hash_linear_vector_dot(v, v)) }

pub fn ds_hash_linear_vector_normalize(v : DshashlinearVector) -> DshashlinearVector {
  let n = ds_hash_linear_vector_norm(v)
  if n < 0.0000001 { v } else { ds_hash_linear_vector_scale(v, 1.0 / n) }
}

pub fn ds_hash_linear_vector_dist(a : DshashlinearVector, b : DshashlinearVector) -> Double {
  ds_hash_linear_vector_norm(ds_hash_linear_vector_sub(a, b))
}

pub fn ds_hash_linear_vector_to_string(v : DshashlinearVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + ds_hash_linear_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_hash_linear_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn ds_hash_linear_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = ds_hash_linear_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ds_hash_linear_std(data : Array[Double]) -> Double { ds_hash_linear_sqrt(ds_hash_linear_var(data)) }

pub fn ds_hash_linear_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = ds_hash_linear_mean(a); let mb = ds_hash_linear_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn ds_hash_linear_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = ds_hash_linear_std(a); let sb = ds_hash_linear_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { ds_hash_linear_cov(a, b) / (sa * sb) }
}

pub fn ds_hash_linear_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = ds_hash_linear_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ds_hash_linear_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn ds_hash_linear_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ds_hash_linear_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  ds_hash_linear_sqrt(ds_hash_linear_mse(pred, labels))
}

pub fn ds_hash_linear_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + ds_hash_linear_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn ds_hash_linear_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = ds_hash_linear_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn ds_hash_linear_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn ds_hash_linear_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn ds_hash_linear_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = ds_hash_linear_precision(pred, labels, pos); let r = ds_hash_linear_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn ds_hash_linear_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn ds_hash_linear_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = ds_hash_linear_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn ds_hash_linear_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn ds_hash_linear_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn ds_hash_linear_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = ds_hash_linear_gcd(a, b)
    (a / g) * b
  }
}

pub fn ds_hash_linear_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn ds_hash_linear_fibonacci(n : Int) -> Int {
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

pub fn ds_hash_linear_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = ds_hash_linear_min(data); let mx = ds_hash_linear_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn ds_hash_linear_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = ds_hash_linear_mean(data); let sd = ds_hash_linear_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn ds_hash_linear_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn ds_hash_linear_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn ds_hash_linear_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn ds_hash_linear_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn ds_hash_linear_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn ds_hash_linear_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn ds_hash_linear_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn ds_hash_linear_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn ds_hash_linear_dbl(x : Double) -> String {
  let i = if x >= 0.0 { ds_hash_linear_int(x) } else { -ds_hash_linear_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { ds_hash_linear_int(f * 1000000.0) } else { ds_hash_linear_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn ds_hash_linear_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn ds_hash_linear_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct DshashlinearFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_linear_frame_make(size : Int) -> DshashlinearFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_linear_frame_len(s : DshashlinearFrame) -> Int { s.size }

pub fn ds_hash_linear_frame_get(s : DshashlinearFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_linear_frame_set(s : DshashlinearFrame, i : Int, v : Double) -> DshashlinearFrame {
  let result = ds_hash_linear_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_linear_frame_sum(s : DshashlinearFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_linear_frame_mean(s : DshashlinearFrame) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_linear_frame_sum(s) / s.size.to_double() }
}

pub fn ds_hash_linear_frame_scale(s : DshashlinearFrame, f : Double) -> DshashlinearFrame {
  let result = ds_hash_linear_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_linear_frame_add(a : DshashlinearFrame, b : DshashlinearFrame) -> DshashlinearFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_linear_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_linear_frame_copy(s : DshashlinearFrame) -> DshashlinearFrame {
  let result = ds_hash_linear_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_linear_frame_fill(s : DshashlinearFrame, v : Double) -> DshashlinearFrame {
  let result = ds_hash_linear_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_linear_frame_min(s : DshashlinearFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_linear_frame_max(s : DshashlinearFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_linear_frame_to_string(s : DshashlinearFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashlinearTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_linear_table_make(size : Int) -> DshashlinearTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_linear_table_len(s : DshashlinearTable) -> Int { s.size }

pub fn ds_hash_linear_table_get(s : DshashlinearTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_linear_table_set(s : DshashlinearTable, i : Int, v : Double) -> DshashlinearTable {
  let result = ds_hash_linear_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_linear_table_sum(s : DshashlinearTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_linear_table_mean(s : DshashlinearTable) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_linear_table_sum(s) / s.size.to_double() }
}

pub fn ds_hash_linear_table_scale(s : DshashlinearTable, f : Double) -> DshashlinearTable {
  let result = ds_hash_linear_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_linear_table_add(a : DshashlinearTable, b : DshashlinearTable) -> DshashlinearTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_linear_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_linear_table_copy(s : DshashlinearTable) -> DshashlinearTable {
  let result = ds_hash_linear_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_linear_table_fill(s : DshashlinearTable, v : Double) -> DshashlinearTable {
  let result = ds_hash_linear_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_linear_table_min(s : DshashlinearTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_linear_table_max(s : DshashlinearTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_linear_table_to_string(s : DshashlinearTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashlinearGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_linear_graphn_make(size : Int) -> DshashlinearGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_linear_graphn_len(s : DshashlinearGraphN) -> Int { s.size }

pub fn ds_hash_linear_graphn_get(s : DshashlinearGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_linear_graphn_set(s : DshashlinearGraphN, i : Int, v : Double) -> DshashlinearGraphN {
  let result = ds_hash_linear_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_linear_graphn_sum(s : DshashlinearGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_linear_graphn_mean(s : DshashlinearGraphN) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_linear_graphn_sum(s) / s.size.to_double() }
}

pub fn ds_hash_linear_graphn_scale(s : DshashlinearGraphN, f : Double) -> DshashlinearGraphN {
  let result = ds_hash_linear_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_linear_graphn_add(a : DshashlinearGraphN, b : DshashlinearGraphN) -> DshashlinearGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_linear_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_linear_graphn_copy(s : DshashlinearGraphN) -> DshashlinearGraphN {
  let result = ds_hash_linear_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_linear_graphn_fill(s : DshashlinearGraphN, v : Double) -> DshashlinearGraphN {
  let result = ds_hash_linear_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_linear_graphn_min(s : DshashlinearGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_linear_graphn_max(s : DshashlinearGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_linear_graphn_to_string(s : DshashlinearGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashlinearNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_linear_node_make(size : Int) -> DshashlinearNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_linear_node_len(s : DshashlinearNode) -> Int { s.size }

pub fn ds_hash_linear_node_get(s : DshashlinearNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_linear_node_set(s : DshashlinearNode, i : Int, v : Double) -> DshashlinearNode {
  let result = ds_hash_linear_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_linear_node_sum(s : DshashlinearNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_linear_node_mean(s : DshashlinearNode) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_linear_node_sum(s) / s.size.to_double() }
}

pub fn ds_hash_linear_node_scale(s : DshashlinearNode, f : Double) -> DshashlinearNode {
  let result = ds_hash_linear_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_linear_node_add(a : DshashlinearNode, b : DshashlinearNode) -> DshashlinearNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_linear_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_linear_node_copy(s : DshashlinearNode) -> DshashlinearNode {
  let result = ds_hash_linear_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_linear_node_fill(s : DshashlinearNode, v : Double) -> DshashlinearNode {
  let result = ds_hash_linear_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_linear_node_min(s : DshashlinearNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_linear_node_max(s : DshashlinearNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_linear_node_to_string(s : DshashlinearNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashlinearEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_linear_edge_make(size : Int) -> DshashlinearEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_linear_edge_len(s : DshashlinearEdge) -> Int { s.size }

pub fn ds_hash_linear_edge_get(s : DshashlinearEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_linear_edge_set(s : DshashlinearEdge, i : Int, v : Double) -> DshashlinearEdge {
  let result = ds_hash_linear_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_linear_edge_sum(s : DshashlinearEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_linear_edge_mean(s : DshashlinearEdge) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_linear_edge_sum(s) / s.size.to_double() }
}

pub fn ds_hash_linear_edge_scale(s : DshashlinearEdge, f : Double) -> DshashlinearEdge {
  let result = ds_hash_linear_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_linear_edge_add(a : DshashlinearEdge, b : DshashlinearEdge) -> DshashlinearEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_linear_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_linear_edge_copy(s : DshashlinearEdge) -> DshashlinearEdge {
  let result = ds_hash_linear_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_linear_edge_fill(s : DshashlinearEdge, v : Double) -> DshashlinearEdge {
  let result = ds_hash_linear_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_linear_edge_min(s : DshashlinearEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_linear_edge_max(s : DshashlinearEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_linear_edge_to_string(s : DshashlinearEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashlinearPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_linear_path_make(size : Int) -> DshashlinearPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_linear_path_len(s : DshashlinearPath) -> Int { s.size }

pub fn ds_hash_linear_path_get(s : DshashlinearPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_linear_path_set(s : DshashlinearPath, i : Int, v : Double) -> DshashlinearPath {
  let result = ds_hash_linear_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_linear_path_sum(s : DshashlinearPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_linear_path_mean(s : DshashlinearPath) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_linear_path_sum(s) / s.size.to_double() }
}

pub fn ds_hash_linear_path_scale(s : DshashlinearPath, f : Double) -> DshashlinearPath {
  let result = ds_hash_linear_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_linear_path_add(a : DshashlinearPath, b : DshashlinearPath) -> DshashlinearPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_linear_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_linear_path_copy(s : DshashlinearPath) -> DshashlinearPath {
  let result = ds_hash_linear_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_linear_path_fill(s : DshashlinearPath, v : Double) -> DshashlinearPath {
  let result = ds_hash_linear_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_linear_path_min(s : DshashlinearPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_linear_path_max(s : DshashlinearPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_linear_path_to_string(s : DshashlinearPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashlinearCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_linear_cluster_make(size : Int) -> DshashlinearCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_linear_cluster_len(s : DshashlinearCluster) -> Int { s.size }

pub fn ds_hash_linear_cluster_get(s : DshashlinearCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_linear_cluster_set(s : DshashlinearCluster, i : Int, v : Double) -> DshashlinearCluster {
  let result = ds_hash_linear_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_linear_cluster_sum(s : DshashlinearCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_linear_cluster_mean(s : DshashlinearCluster) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_linear_cluster_sum(s) / s.size.to_double() }
}

pub fn ds_hash_linear_cluster_scale(s : DshashlinearCluster, f : Double) -> DshashlinearCluster {
  let result = ds_hash_linear_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_linear_cluster_add(a : DshashlinearCluster, b : DshashlinearCluster) -> DshashlinearCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_linear_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_linear_cluster_copy(s : DshashlinearCluster) -> DshashlinearCluster {
  let result = ds_hash_linear_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_linear_cluster_fill(s : DshashlinearCluster, v : Double) -> DshashlinearCluster {
  let result = ds_hash_linear_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_linear_cluster_min(s : DshashlinearCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_linear_cluster_max(s : DshashlinearCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_linear_cluster_to_string(s : DshashlinearCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashlinearModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_linear_model_make(size : Int) -> DshashlinearModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_linear_model_len(s : DshashlinearModel) -> Int { s.size }

pub fn ds_hash_linear_model_get(s : DshashlinearModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_linear_model_set(s : DshashlinearModel, i : Int, v : Double) -> DshashlinearModel {
  let result = ds_hash_linear_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_linear_model_sum(s : DshashlinearModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_linear_model_mean(s : DshashlinearModel) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_linear_model_sum(s) / s.size.to_double() }
}

pub fn ds_hash_linear_model_scale(s : DshashlinearModel, f : Double) -> DshashlinearModel {
  let result = ds_hash_linear_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_linear_model_add(a : DshashlinearModel, b : DshashlinearModel) -> DshashlinearModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_linear_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_linear_model_copy(s : DshashlinearModel) -> DshashlinearModel {
  let result = ds_hash_linear_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_linear_model_fill(s : DshashlinearModel, v : Double) -> DshashlinearModel {
  let result = ds_hash_linear_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_linear_model_min(s : DshashlinearModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_linear_model_max(s : DshashlinearModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_linear_model_to_string(s : DshashlinearModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashlinearLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_linear_layer_make(size : Int) -> DshashlinearLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_linear_layer_len(s : DshashlinearLayer) -> Int { s.size }

pub fn ds_hash_linear_layer_get(s : DshashlinearLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_linear_layer_set(s : DshashlinearLayer, i : Int, v : Double) -> DshashlinearLayer {
  let result = ds_hash_linear_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_linear_layer_sum(s : DshashlinearLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_linear_layer_mean(s : DshashlinearLayer) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_linear_layer_sum(s) / s.size.to_double() }
}

pub fn ds_hash_linear_layer_scale(s : DshashlinearLayer, f : Double) -> DshashlinearLayer {
  let result = ds_hash_linear_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_linear_layer_add(a : DshashlinearLayer, b : DshashlinearLayer) -> DshashlinearLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_linear_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_linear_layer_copy(s : DshashlinearLayer) -> DshashlinearLayer {
  let result = ds_hash_linear_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_linear_layer_fill(s : DshashlinearLayer, v : Double) -> DshashlinearLayer {
  let result = ds_hash_linear_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_linear_layer_min(s : DshashlinearLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_linear_layer_max(s : DshashlinearLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_linear_layer_to_string(s : DshashlinearLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashlinearBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_linear_buffer_make(size : Int) -> DshashlinearBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_linear_buffer_len(s : DshashlinearBuffer) -> Int { s.size }

pub fn ds_hash_linear_buffer_get(s : DshashlinearBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_linear_buffer_set(s : DshashlinearBuffer, i : Int, v : Double) -> DshashlinearBuffer {
  let result = ds_hash_linear_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_linear_buffer_sum(s : DshashlinearBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_linear_buffer_mean(s : DshashlinearBuffer) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_linear_buffer_sum(s) / s.size.to_double() }
}

pub fn ds_hash_linear_buffer_scale(s : DshashlinearBuffer, f : Double) -> DshashlinearBuffer {
  let result = ds_hash_linear_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_linear_buffer_add(a : DshashlinearBuffer, b : DshashlinearBuffer) -> DshashlinearBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_linear_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_linear_buffer_copy(s : DshashlinearBuffer) -> DshashlinearBuffer {
  let result = ds_hash_linear_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_linear_buffer_fill(s : DshashlinearBuffer, v : Double) -> DshashlinearBuffer {
  let result = ds_hash_linear_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_linear_buffer_min(s : DshashlinearBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_linear_buffer_max(s : DshashlinearBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_linear_buffer_to_string(s : DshashlinearBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashlinearCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_linear_cursor_make(size : Int) -> DshashlinearCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_linear_cursor_len(s : DshashlinearCursor) -> Int { s.size }

pub fn ds_hash_linear_cursor_get(s : DshashlinearCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_linear_cursor_set(s : DshashlinearCursor, i : Int, v : Double) -> DshashlinearCursor {
  let result = ds_hash_linear_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_linear_cursor_sum(s : DshashlinearCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_linear_cursor_mean(s : DshashlinearCursor) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_linear_cursor_sum(s) / s.size.to_double() }
}

pub fn ds_hash_linear_cursor_scale(s : DshashlinearCursor, f : Double) -> DshashlinearCursor {
  let result = ds_hash_linear_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_linear_cursor_add(a : DshashlinearCursor, b : DshashlinearCursor) -> DshashlinearCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_linear_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_linear_cursor_copy(s : DshashlinearCursor) -> DshashlinearCursor {
  let result = ds_hash_linear_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_linear_cursor_fill(s : DshashlinearCursor, v : Double) -> DshashlinearCursor {
  let result = ds_hash_linear_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_linear_cursor_min(s : DshashlinearCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_linear_cursor_max(s : DshashlinearCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_linear_cursor_to_string(s : DshashlinearCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashlinearView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_linear_view_make(size : Int) -> DshashlinearView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_linear_view_len(s : DshashlinearView) -> Int { s.size }

pub fn ds_hash_linear_view_get(s : DshashlinearView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_linear_view_set(s : DshashlinearView, i : Int, v : Double) -> DshashlinearView {
  let result = ds_hash_linear_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_linear_view_sum(s : DshashlinearView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_linear_view_mean(s : DshashlinearView) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_linear_view_sum(s) / s.size.to_double() }
}

pub fn ds_hash_linear_view_scale(s : DshashlinearView, f : Double) -> DshashlinearView {
  let result = ds_hash_linear_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_linear_view_add(a : DshashlinearView, b : DshashlinearView) -> DshashlinearView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_linear_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_linear_view_copy(s : DshashlinearView) -> DshashlinearView {
  let result = ds_hash_linear_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_linear_view_fill(s : DshashlinearView, v : Double) -> DshashlinearView {
  let result = ds_hash_linear_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_linear_view_min(s : DshashlinearView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_linear_view_max(s : DshashlinearView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_linear_view_to_string(s : DshashlinearView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashlinearRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_linear_range_make(size : Int) -> DshashlinearRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_linear_range_len(s : DshashlinearRange) -> Int { s.size }

pub fn ds_hash_linear_range_get(s : DshashlinearRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_linear_range_set(s : DshashlinearRange, i : Int, v : Double) -> DshashlinearRange {
  let result = ds_hash_linear_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_linear_range_sum(s : DshashlinearRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_linear_range_mean(s : DshashlinearRange) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_linear_range_sum(s) / s.size.to_double() }
}

pub fn ds_hash_linear_range_scale(s : DshashlinearRange, f : Double) -> DshashlinearRange {
  let result = ds_hash_linear_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_linear_range_add(a : DshashlinearRange, b : DshashlinearRange) -> DshashlinearRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_linear_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_linear_range_copy(s : DshashlinearRange) -> DshashlinearRange {
  let result = ds_hash_linear_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_linear_range_fill(s : DshashlinearRange, v : Double) -> DshashlinearRange {
  let result = ds_hash_linear_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_linear_range_min(s : DshashlinearRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_linear_range_max(s : DshashlinearRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_linear_range_to_string(s : DshashlinearRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashlinearSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_linear_slice_make(size : Int) -> DshashlinearSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_linear_slice_len(s : DshashlinearSlice) -> Int { s.size }

pub fn ds_hash_linear_slice_get(s : DshashlinearSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_linear_slice_set(s : DshashlinearSlice, i : Int, v : Double) -> DshashlinearSlice {
  let result = ds_hash_linear_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_linear_slice_sum(s : DshashlinearSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_linear_slice_mean(s : DshashlinearSlice) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_linear_slice_sum(s) / s.size.to_double() }
}

pub fn ds_hash_linear_slice_scale(s : DshashlinearSlice, f : Double) -> DshashlinearSlice {
  let result = ds_hash_linear_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_linear_slice_add(a : DshashlinearSlice, b : DshashlinearSlice) -> DshashlinearSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_linear_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_linear_slice_copy(s : DshashlinearSlice) -> DshashlinearSlice {
  let result = ds_hash_linear_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_linear_slice_fill(s : DshashlinearSlice, v : Double) -> DshashlinearSlice {
  let result = ds_hash_linear_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_linear_slice_min(s : DshashlinearSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_linear_slice_max(s : DshashlinearSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_linear_slice_to_string(s : DshashlinearSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn ds_hash_linear_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_hash_linear_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_hash_linear_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_hash_linear_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_hash_linear_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_hash_linear_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_hash_linear_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_hash_linear_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_hash_linear_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_hash_linear_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_hash_linear_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_hash_linear_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_hash_linear_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_hash_linear_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_hash_linear_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_hash_linear_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_hash_linear_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_hash_linear_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_hash_linear_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_hash_linear_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_hash_linear_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_hash_linear_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_hash_linear_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_hash_linear_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_hash_linear_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}


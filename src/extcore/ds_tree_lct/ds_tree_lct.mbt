///===
/// extcore/ds_tree_lct

pub(all) struct DstreelctPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_tree_lct_make_point(x : Double, y : Double) -> DstreelctPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_tree_lct_make_point3(x : Double, y : Double, z : Double) -> DstreelctPoint {
  { x, y, z, label: 0 }
}

pub fn ds_tree_lct_point_x(pt : DstreelctPoint) -> Double { pt.x }

pub fn ds_tree_lct_point_y(pt : DstreelctPoint) -> Double { pt.y }

pub fn ds_tree_lct_point_z(pt : DstreelctPoint) -> Double { pt.z }

pub fn ds_tree_lct_point_label(pt : DstreelctPoint) -> Int { pt.label }

pub fn ds_tree_lct_point_dist(a : DstreelctPoint, b : DstreelctPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ds_tree_lct_point_add(a : DstreelctPoint, b : DstreelctPoint) -> DstreelctPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ds_tree_lct_point_sub(a : DstreelctPoint, b : DstreelctPoint) -> DstreelctPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ds_tree_lct_point_scale(pt : DstreelctPoint, s : Double) -> DstreelctPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ds_tree_lct_point_dot(a : DstreelctPoint, b : DstreelctPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ds_tree_lct_point_cross(a : DstreelctPoint, b : DstreelctPoint) -> DstreelctPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ds_tree_lct_point_norm(pt : DstreelctPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ds_tree_lct_point_normalize(pt : DstreelctPoint) -> DstreelctPoint {
  let n = ds_tree_lct_point_norm(pt)
  if n < 0.0000001 { pt } else { ds_tree_lct_point_scale(pt, 1.0 / n) }
}

pub fn ds_tree_lct_point_negate(pt : DstreelctPoint) -> DstreelctPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ds_tree_lct_point_mid(a : DstreelctPoint, b : DstreelctPoint) -> DstreelctPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ds_tree_lct_point_lerp(a : DstreelctPoint, b : DstreelctPoint, t : Double) -> DstreelctPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ds_tree_lct_point_to_string(pt : DstreelctPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DstreelctSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_tree_lct_make_series(vals : Array[Double], name : String) -> DstreelctSeries {
  { vals, name, meta: 0 }
}

pub fn ds_tree_lct_series_len(s : DstreelctSeries) -> Int { s.vals.length() }

pub fn ds_tree_lct_series_sum(s : DstreelctSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn ds_tree_lct_series_mean(s : DstreelctSeries) -> Double {
  let n = ds_tree_lct_series_len(s)
  if n == 0 { 0.0 } else { ds_tree_lct_series_sum(s) / n.to_double() }
}

pub fn ds_tree_lct_series_min(s : DstreelctSeries) -> Double {
  let n = ds_tree_lct_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn ds_tree_lct_series_max(s : DstreelctSeries) -> Double {
  let n = ds_tree_lct_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn ds_tree_lct_series_range(s : DstreelctSeries) -> Double {
  ds_tree_lct_series_max(s) - ds_tree_lct_series_min(s)
}

pub fn ds_tree_lct_series_var(s : DstreelctSeries) -> Double {
  let n = ds_tree_lct_series_len(s)
  if n == 0 { 0.0 } else {
    let m = ds_tree_lct_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn ds_tree_lct_series_std(s : DstreelctSeries) -> Double { @_common.sqrt(ds_tree_lct_series_var(s)) }

pub fn ds_tree_lct_series_median(s : DstreelctSeries) -> Double {
  let n = ds_tree_lct_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = ds_tree_lct_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ds_tree_lct_series_scale(s : DstreelctSeries, f : Double) -> DstreelctSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ds_tree_lct_series_add(a : DstreelctSeries, b : DstreelctSeries) -> DstreelctSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ds_tree_lct_series_sub(a : DstreelctSeries, b : DstreelctSeries) -> DstreelctSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ds_tree_lct_series_normalize(s : DstreelctSeries) -> DstreelctSeries {
  let mn = ds_tree_lct_series_min(s)
  let mx = ds_tree_lct_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ds_tree_lct_series_cumsum(s : DstreelctSeries) -> DstreelctSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn ds_tree_lct_series_to_string(s : DstreelctSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DstreelctMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_tree_lct_make_matrix(rows : Int, cols : Int, val : Double) -> DstreelctMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_tree_lct_matrix_identity(n : Int) -> DstreelctMatrix {
  let m = ds_tree_lct_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ds_tree_lct_matrix_get(m : DstreelctMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ds_tree_lct_matrix_transpose(m : DstreelctMatrix) -> DstreelctMatrix {
  let result = ds_tree_lct_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ds_tree_lct_matrix_add(a : DstreelctMatrix, b : DstreelctMatrix) -> DstreelctMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ds_tree_lct_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ds_tree_lct_matrix_scale(m : DstreelctMatrix, s : Double) -> DstreelctMatrix {
  let result = ds_tree_lct_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ds_tree_lct_matrix_multiply(a : DstreelctMatrix, b : DstreelctMatrix) -> DstreelctMatrix {
  if a.cols != b.rows { return ds_tree_lct_make_matrix(a.rows, b.cols, 0.0) }
  let result = ds_tree_lct_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ds_tree_lct_matrix_trace(m : DstreelctMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ds_tree_lct_matrix_det(m : DstreelctMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ds_tree_lct_matrix_norm(m : DstreelctMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ds_tree_lct_matrix_to_string(m : DstreelctMatrix) -> String {
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

pub(all) struct DstreelctVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_tree_lct_make_vector(comps : Array[Double]) -> DstreelctVector {
  { comps, dim: comps.length() }
}

pub fn ds_tree_lct_vector_zero(dim : Int) -> DstreelctVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ds_tree_lct_vector_add(a : DstreelctVector, b : DstreelctVector) -> DstreelctVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_tree_lct_vector_sub(a : DstreelctVector, b : DstreelctVector) -> DstreelctVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_tree_lct_vector_scale(v : DstreelctVector, s : Double) -> DstreelctVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ds_tree_lct_vector_dot(a : DstreelctVector, b : DstreelctVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ds_tree_lct_vector_norm(v : DstreelctVector) -> Double { @_common.sqrt(ds_tree_lct_vector_dot(v, v)) }

pub fn ds_tree_lct_vector_normalize(v : DstreelctVector) -> DstreelctVector {
  let n = ds_tree_lct_vector_norm(v)
  if n < 0.0000001 { v } else { ds_tree_lct_vector_scale(v, 1.0 / n) }
}

pub fn ds_tree_lct_vector_dist(a : DstreelctVector, b : DstreelctVector) -> Double {
  ds_tree_lct_vector_norm(ds_tree_lct_vector_sub(a, b))
}

pub fn ds_tree_lct_vector_to_string(v : DstreelctVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_tree_lct_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn ds_tree_lct_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = ds_tree_lct_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ds_tree_lct_std(data : Array[Double]) -> Double { @_common.sqrt(ds_tree_lct_var(data)) }

pub fn ds_tree_lct_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = ds_tree_lct_mean(a); let mb = ds_tree_lct_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn ds_tree_lct_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = ds_tree_lct_std(a); let sb = ds_tree_lct_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { ds_tree_lct_cov(a, b) / (sa * sb) }
}

pub fn ds_tree_lct_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = ds_tree_lct_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ds_tree_lct_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn ds_tree_lct_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ds_tree_lct_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(ds_tree_lct_mse(pred, labels))
}

pub fn ds_tree_lct_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn ds_tree_lct_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = ds_tree_lct_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn ds_tree_lct_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn ds_tree_lct_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn ds_tree_lct_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = ds_tree_lct_precision(pred, labels, pos); let r = ds_tree_lct_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn ds_tree_lct_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn ds_tree_lct_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = ds_tree_lct_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn ds_tree_lct_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn ds_tree_lct_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn ds_tree_lct_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = ds_tree_lct_gcd(a, b)
    (a / g) * b
  }
}

pub fn ds_tree_lct_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn ds_tree_lct_fibonacci(n : Int) -> Int {
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

pub fn ds_tree_lct_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = ds_tree_lct_min(data); let mx = ds_tree_lct_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn ds_tree_lct_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = ds_tree_lct_mean(data); let sd = ds_tree_lct_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn ds_tree_lct_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn ds_tree_lct_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn ds_tree_lct_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn ds_tree_lct_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn ds_tree_lct_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn ds_tree_lct_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct DstreelctFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_lct_frame_make(size : Int) -> DstreelctFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_lct_frame_len(s : DstreelctFrame) -> Int { s.size }

pub fn ds_tree_lct_frame_get(s : DstreelctFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_lct_frame_set(s : DstreelctFrame, i : Int, v : Double) -> DstreelctFrame {
  let result = ds_tree_lct_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_lct_frame_sum(s : DstreelctFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_lct_frame_mean(s : DstreelctFrame) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_lct_frame_sum(s) / s.size.to_double() }
}

pub fn ds_tree_lct_frame_scale(s : DstreelctFrame, f : Double) -> DstreelctFrame {
  let result = ds_tree_lct_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_lct_frame_add(a : DstreelctFrame, b : DstreelctFrame) -> DstreelctFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_lct_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_lct_frame_copy(s : DstreelctFrame) -> DstreelctFrame {
  let result = ds_tree_lct_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_lct_frame_fill(s : DstreelctFrame, v : Double) -> DstreelctFrame {
  let result = ds_tree_lct_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_lct_frame_min(s : DstreelctFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_lct_frame_max(s : DstreelctFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_lct_frame_to_string(s : DstreelctFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreelctTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_lct_table_make(size : Int) -> DstreelctTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_lct_table_len(s : DstreelctTable) -> Int { s.size }

pub fn ds_tree_lct_table_get(s : DstreelctTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_lct_table_set(s : DstreelctTable, i : Int, v : Double) -> DstreelctTable {
  let result = ds_tree_lct_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_lct_table_sum(s : DstreelctTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_lct_table_mean(s : DstreelctTable) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_lct_table_sum(s) / s.size.to_double() }
}

pub fn ds_tree_lct_table_scale(s : DstreelctTable, f : Double) -> DstreelctTable {
  let result = ds_tree_lct_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_lct_table_add(a : DstreelctTable, b : DstreelctTable) -> DstreelctTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_lct_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_lct_table_copy(s : DstreelctTable) -> DstreelctTable {
  let result = ds_tree_lct_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_lct_table_fill(s : DstreelctTable, v : Double) -> DstreelctTable {
  let result = ds_tree_lct_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_lct_table_min(s : DstreelctTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_lct_table_max(s : DstreelctTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_lct_table_to_string(s : DstreelctTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreelctGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_lct_graphn_make(size : Int) -> DstreelctGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_lct_graphn_len(s : DstreelctGraphN) -> Int { s.size }

pub fn ds_tree_lct_graphn_get(s : DstreelctGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_lct_graphn_set(s : DstreelctGraphN, i : Int, v : Double) -> DstreelctGraphN {
  let result = ds_tree_lct_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_lct_graphn_sum(s : DstreelctGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_lct_graphn_mean(s : DstreelctGraphN) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_lct_graphn_sum(s) / s.size.to_double() }
}

pub fn ds_tree_lct_graphn_scale(s : DstreelctGraphN, f : Double) -> DstreelctGraphN {
  let result = ds_tree_lct_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_lct_graphn_add(a : DstreelctGraphN, b : DstreelctGraphN) -> DstreelctGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_lct_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_lct_graphn_copy(s : DstreelctGraphN) -> DstreelctGraphN {
  let result = ds_tree_lct_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_lct_graphn_fill(s : DstreelctGraphN, v : Double) -> DstreelctGraphN {
  let result = ds_tree_lct_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_lct_graphn_min(s : DstreelctGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_lct_graphn_max(s : DstreelctGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_lct_graphn_to_string(s : DstreelctGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreelctNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_lct_node_make(size : Int) -> DstreelctNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_lct_node_len(s : DstreelctNode) -> Int { s.size }

pub fn ds_tree_lct_node_get(s : DstreelctNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_lct_node_set(s : DstreelctNode, i : Int, v : Double) -> DstreelctNode {
  let result = ds_tree_lct_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_lct_node_sum(s : DstreelctNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_lct_node_mean(s : DstreelctNode) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_lct_node_sum(s) / s.size.to_double() }
}

pub fn ds_tree_lct_node_scale(s : DstreelctNode, f : Double) -> DstreelctNode {
  let result = ds_tree_lct_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_lct_node_add(a : DstreelctNode, b : DstreelctNode) -> DstreelctNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_lct_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_lct_node_copy(s : DstreelctNode) -> DstreelctNode {
  let result = ds_tree_lct_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_lct_node_fill(s : DstreelctNode, v : Double) -> DstreelctNode {
  let result = ds_tree_lct_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_lct_node_min(s : DstreelctNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_lct_node_max(s : DstreelctNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_lct_node_to_string(s : DstreelctNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreelctEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_lct_edge_make(size : Int) -> DstreelctEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_lct_edge_len(s : DstreelctEdge) -> Int { s.size }

pub fn ds_tree_lct_edge_get(s : DstreelctEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_lct_edge_set(s : DstreelctEdge, i : Int, v : Double) -> DstreelctEdge {
  let result = ds_tree_lct_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_lct_edge_sum(s : DstreelctEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_lct_edge_mean(s : DstreelctEdge) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_lct_edge_sum(s) / s.size.to_double() }
}

pub fn ds_tree_lct_edge_scale(s : DstreelctEdge, f : Double) -> DstreelctEdge {
  let result = ds_tree_lct_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_lct_edge_add(a : DstreelctEdge, b : DstreelctEdge) -> DstreelctEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_lct_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_lct_edge_copy(s : DstreelctEdge) -> DstreelctEdge {
  let result = ds_tree_lct_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_lct_edge_fill(s : DstreelctEdge, v : Double) -> DstreelctEdge {
  let result = ds_tree_lct_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_lct_edge_min(s : DstreelctEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_lct_edge_max(s : DstreelctEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_lct_edge_to_string(s : DstreelctEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreelctPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_lct_path_make(size : Int) -> DstreelctPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_lct_path_len(s : DstreelctPath) -> Int { s.size }

pub fn ds_tree_lct_path_get(s : DstreelctPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_lct_path_set(s : DstreelctPath, i : Int, v : Double) -> DstreelctPath {
  let result = ds_tree_lct_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_lct_path_sum(s : DstreelctPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_lct_path_mean(s : DstreelctPath) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_lct_path_sum(s) / s.size.to_double() }
}

pub fn ds_tree_lct_path_scale(s : DstreelctPath, f : Double) -> DstreelctPath {
  let result = ds_tree_lct_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_lct_path_add(a : DstreelctPath, b : DstreelctPath) -> DstreelctPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_lct_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_lct_path_copy(s : DstreelctPath) -> DstreelctPath {
  let result = ds_tree_lct_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_lct_path_fill(s : DstreelctPath, v : Double) -> DstreelctPath {
  let result = ds_tree_lct_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_lct_path_min(s : DstreelctPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_lct_path_max(s : DstreelctPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_lct_path_to_string(s : DstreelctPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreelctCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_lct_cluster_make(size : Int) -> DstreelctCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_lct_cluster_len(s : DstreelctCluster) -> Int { s.size }

pub fn ds_tree_lct_cluster_get(s : DstreelctCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_lct_cluster_set(s : DstreelctCluster, i : Int, v : Double) -> DstreelctCluster {
  let result = ds_tree_lct_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_lct_cluster_sum(s : DstreelctCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_lct_cluster_mean(s : DstreelctCluster) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_lct_cluster_sum(s) / s.size.to_double() }
}

pub fn ds_tree_lct_cluster_scale(s : DstreelctCluster, f : Double) -> DstreelctCluster {
  let result = ds_tree_lct_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_lct_cluster_add(a : DstreelctCluster, b : DstreelctCluster) -> DstreelctCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_lct_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_lct_cluster_copy(s : DstreelctCluster) -> DstreelctCluster {
  let result = ds_tree_lct_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_lct_cluster_fill(s : DstreelctCluster, v : Double) -> DstreelctCluster {
  let result = ds_tree_lct_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_lct_cluster_min(s : DstreelctCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_lct_cluster_max(s : DstreelctCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_lct_cluster_to_string(s : DstreelctCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreelctModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_lct_model_make(size : Int) -> DstreelctModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_lct_model_len(s : DstreelctModel) -> Int { s.size }

pub fn ds_tree_lct_model_get(s : DstreelctModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_lct_model_set(s : DstreelctModel, i : Int, v : Double) -> DstreelctModel {
  let result = ds_tree_lct_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_lct_model_sum(s : DstreelctModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_lct_model_mean(s : DstreelctModel) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_lct_model_sum(s) / s.size.to_double() }
}

pub fn ds_tree_lct_model_scale(s : DstreelctModel, f : Double) -> DstreelctModel {
  let result = ds_tree_lct_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_lct_model_add(a : DstreelctModel, b : DstreelctModel) -> DstreelctModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_lct_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_lct_model_copy(s : DstreelctModel) -> DstreelctModel {
  let result = ds_tree_lct_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_lct_model_fill(s : DstreelctModel, v : Double) -> DstreelctModel {
  let result = ds_tree_lct_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_lct_model_min(s : DstreelctModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_lct_model_max(s : DstreelctModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_lct_model_to_string(s : DstreelctModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreelctLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_lct_layer_make(size : Int) -> DstreelctLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_lct_layer_len(s : DstreelctLayer) -> Int { s.size }

pub fn ds_tree_lct_layer_get(s : DstreelctLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_lct_layer_set(s : DstreelctLayer, i : Int, v : Double) -> DstreelctLayer {
  let result = ds_tree_lct_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_lct_layer_sum(s : DstreelctLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_lct_layer_mean(s : DstreelctLayer) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_lct_layer_sum(s) / s.size.to_double() }
}

pub fn ds_tree_lct_layer_scale(s : DstreelctLayer, f : Double) -> DstreelctLayer {
  let result = ds_tree_lct_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_lct_layer_add(a : DstreelctLayer, b : DstreelctLayer) -> DstreelctLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_lct_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_lct_layer_copy(s : DstreelctLayer) -> DstreelctLayer {
  let result = ds_tree_lct_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_lct_layer_fill(s : DstreelctLayer, v : Double) -> DstreelctLayer {
  let result = ds_tree_lct_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_lct_layer_min(s : DstreelctLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_lct_layer_max(s : DstreelctLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_lct_layer_to_string(s : DstreelctLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreelctBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_lct_buffer_make(size : Int) -> DstreelctBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_lct_buffer_len(s : DstreelctBuffer) -> Int { s.size }

pub fn ds_tree_lct_buffer_get(s : DstreelctBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_lct_buffer_set(s : DstreelctBuffer, i : Int, v : Double) -> DstreelctBuffer {
  let result = ds_tree_lct_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_lct_buffer_sum(s : DstreelctBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_lct_buffer_mean(s : DstreelctBuffer) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_lct_buffer_sum(s) / s.size.to_double() }
}

pub fn ds_tree_lct_buffer_scale(s : DstreelctBuffer, f : Double) -> DstreelctBuffer {
  let result = ds_tree_lct_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_lct_buffer_add(a : DstreelctBuffer, b : DstreelctBuffer) -> DstreelctBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_lct_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_lct_buffer_copy(s : DstreelctBuffer) -> DstreelctBuffer {
  let result = ds_tree_lct_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_lct_buffer_fill(s : DstreelctBuffer, v : Double) -> DstreelctBuffer {
  let result = ds_tree_lct_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_lct_buffer_min(s : DstreelctBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_lct_buffer_max(s : DstreelctBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_lct_buffer_to_string(s : DstreelctBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreelctCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_lct_cursor_make(size : Int) -> DstreelctCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_lct_cursor_len(s : DstreelctCursor) -> Int { s.size }

pub fn ds_tree_lct_cursor_get(s : DstreelctCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_lct_cursor_set(s : DstreelctCursor, i : Int, v : Double) -> DstreelctCursor {
  let result = ds_tree_lct_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_lct_cursor_sum(s : DstreelctCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_lct_cursor_mean(s : DstreelctCursor) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_lct_cursor_sum(s) / s.size.to_double() }
}

pub fn ds_tree_lct_cursor_scale(s : DstreelctCursor, f : Double) -> DstreelctCursor {
  let result = ds_tree_lct_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_lct_cursor_add(a : DstreelctCursor, b : DstreelctCursor) -> DstreelctCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_lct_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_lct_cursor_copy(s : DstreelctCursor) -> DstreelctCursor {
  let result = ds_tree_lct_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_lct_cursor_fill(s : DstreelctCursor, v : Double) -> DstreelctCursor {
  let result = ds_tree_lct_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_lct_cursor_min(s : DstreelctCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_lct_cursor_max(s : DstreelctCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_lct_cursor_to_string(s : DstreelctCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreelctView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_lct_view_make(size : Int) -> DstreelctView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_lct_view_len(s : DstreelctView) -> Int { s.size }

pub fn ds_tree_lct_view_get(s : DstreelctView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_lct_view_set(s : DstreelctView, i : Int, v : Double) -> DstreelctView {
  let result = ds_tree_lct_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_lct_view_sum(s : DstreelctView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_lct_view_mean(s : DstreelctView) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_lct_view_sum(s) / s.size.to_double() }
}

pub fn ds_tree_lct_view_scale(s : DstreelctView, f : Double) -> DstreelctView {
  let result = ds_tree_lct_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_lct_view_add(a : DstreelctView, b : DstreelctView) -> DstreelctView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_lct_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_lct_view_copy(s : DstreelctView) -> DstreelctView {
  let result = ds_tree_lct_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_lct_view_fill(s : DstreelctView, v : Double) -> DstreelctView {
  let result = ds_tree_lct_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_lct_view_min(s : DstreelctView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_lct_view_max(s : DstreelctView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_lct_view_to_string(s : DstreelctView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreelctRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_lct_range_make(size : Int) -> DstreelctRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_lct_range_len(s : DstreelctRange) -> Int { s.size }

pub fn ds_tree_lct_range_get(s : DstreelctRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_lct_range_set(s : DstreelctRange, i : Int, v : Double) -> DstreelctRange {
  let result = ds_tree_lct_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_lct_range_sum(s : DstreelctRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_lct_range_mean(s : DstreelctRange) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_lct_range_sum(s) / s.size.to_double() }
}

pub fn ds_tree_lct_range_scale(s : DstreelctRange, f : Double) -> DstreelctRange {
  let result = ds_tree_lct_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_lct_range_add(a : DstreelctRange, b : DstreelctRange) -> DstreelctRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_lct_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_lct_range_copy(s : DstreelctRange) -> DstreelctRange {
  let result = ds_tree_lct_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_lct_range_fill(s : DstreelctRange, v : Double) -> DstreelctRange {
  let result = ds_tree_lct_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_lct_range_min(s : DstreelctRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_lct_range_max(s : DstreelctRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_lct_range_to_string(s : DstreelctRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreelctSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_lct_slice_make(size : Int) -> DstreelctSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_lct_slice_len(s : DstreelctSlice) -> Int { s.size }

pub fn ds_tree_lct_slice_get(s : DstreelctSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_lct_slice_set(s : DstreelctSlice, i : Int, v : Double) -> DstreelctSlice {
  let result = ds_tree_lct_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_lct_slice_sum(s : DstreelctSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_lct_slice_mean(s : DstreelctSlice) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_lct_slice_sum(s) / s.size.to_double() }
}

pub fn ds_tree_lct_slice_scale(s : DstreelctSlice, f : Double) -> DstreelctSlice {
  let result = ds_tree_lct_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_lct_slice_add(a : DstreelctSlice, b : DstreelctSlice) -> DstreelctSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_lct_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_lct_slice_copy(s : DstreelctSlice) -> DstreelctSlice {
  let result = ds_tree_lct_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_lct_slice_fill(s : DstreelctSlice, v : Double) -> DstreelctSlice {
  let result = ds_tree_lct_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_lct_slice_min(s : DstreelctSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_lct_slice_max(s : DstreelctSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_lct_slice_to_string(s : DstreelctSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


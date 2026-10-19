///===
/// extcore/ds_tree_suffix

pub(all) struct DstreesuffixPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_tree_suffix_make_point(x : Double, y : Double) -> DstreesuffixPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_tree_suffix_make_point3(x : Double, y : Double, z : Double) -> DstreesuffixPoint {
  { x, y, z, label: 0 }
}

pub fn ds_tree_suffix_point_x(pt : DstreesuffixPoint) -> Double { pt.x }

pub fn ds_tree_suffix_point_y(pt : DstreesuffixPoint) -> Double { pt.y }

pub fn ds_tree_suffix_point_z(pt : DstreesuffixPoint) -> Double { pt.z }

pub fn ds_tree_suffix_point_label(pt : DstreesuffixPoint) -> Int { pt.label }

pub fn ds_tree_suffix_point_dist(a : DstreesuffixPoint, b : DstreesuffixPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ds_tree_suffix_point_add(a : DstreesuffixPoint, b : DstreesuffixPoint) -> DstreesuffixPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ds_tree_suffix_point_sub(a : DstreesuffixPoint, b : DstreesuffixPoint) -> DstreesuffixPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ds_tree_suffix_point_scale(pt : DstreesuffixPoint, s : Double) -> DstreesuffixPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ds_tree_suffix_point_dot(a : DstreesuffixPoint, b : DstreesuffixPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ds_tree_suffix_point_cross(a : DstreesuffixPoint, b : DstreesuffixPoint) -> DstreesuffixPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ds_tree_suffix_point_norm(pt : DstreesuffixPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ds_tree_suffix_point_normalize(pt : DstreesuffixPoint) -> DstreesuffixPoint {
  let n = ds_tree_suffix_point_norm(pt)
  if n < 0.0000001 { pt } else { ds_tree_suffix_point_scale(pt, 1.0 / n) }
}

pub fn ds_tree_suffix_point_negate(pt : DstreesuffixPoint) -> DstreesuffixPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ds_tree_suffix_point_mid(a : DstreesuffixPoint, b : DstreesuffixPoint) -> DstreesuffixPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ds_tree_suffix_point_lerp(a : DstreesuffixPoint, b : DstreesuffixPoint, t : Double) -> DstreesuffixPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ds_tree_suffix_point_to_string(pt : DstreesuffixPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DstreesuffixSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_tree_suffix_make_series(vals : Array[Double], name : String) -> DstreesuffixSeries {
  { vals, name, meta: 0 }
}

pub fn ds_tree_suffix_series_len(s : DstreesuffixSeries) -> Int { s.vals.length() }

pub fn ds_tree_suffix_series_sum(s : DstreesuffixSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn ds_tree_suffix_series_mean(s : DstreesuffixSeries) -> Double {
  let n = ds_tree_suffix_series_len(s)
  if n == 0 { 0.0 } else { ds_tree_suffix_series_sum(s) / n.to_double() }
}

pub fn ds_tree_suffix_series_min(s : DstreesuffixSeries) -> Double {
  let n = ds_tree_suffix_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn ds_tree_suffix_series_max(s : DstreesuffixSeries) -> Double {
  let n = ds_tree_suffix_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn ds_tree_suffix_series_range(s : DstreesuffixSeries) -> Double {
  ds_tree_suffix_series_max(s) - ds_tree_suffix_series_min(s)
}

pub fn ds_tree_suffix_series_var(s : DstreesuffixSeries) -> Double {
  let n = ds_tree_suffix_series_len(s)
  if n == 0 { 0.0 } else {
    let m = ds_tree_suffix_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn ds_tree_suffix_series_std(s : DstreesuffixSeries) -> Double { @_common.sqrt(ds_tree_suffix_series_var(s)) }

pub fn ds_tree_suffix_series_median(s : DstreesuffixSeries) -> Double {
  let n = ds_tree_suffix_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = ds_tree_suffix_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ds_tree_suffix_series_scale(s : DstreesuffixSeries, f : Double) -> DstreesuffixSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ds_tree_suffix_series_add(a : DstreesuffixSeries, b : DstreesuffixSeries) -> DstreesuffixSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ds_tree_suffix_series_sub(a : DstreesuffixSeries, b : DstreesuffixSeries) -> DstreesuffixSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ds_tree_suffix_series_normalize(s : DstreesuffixSeries) -> DstreesuffixSeries {
  let mn = ds_tree_suffix_series_min(s)
  let mx = ds_tree_suffix_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ds_tree_suffix_series_cumsum(s : DstreesuffixSeries) -> DstreesuffixSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn ds_tree_suffix_series_to_string(s : DstreesuffixSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DstreesuffixMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_tree_suffix_make_matrix(rows : Int, cols : Int, val : Double) -> DstreesuffixMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_tree_suffix_matrix_identity(n : Int) -> DstreesuffixMatrix {
  let m = ds_tree_suffix_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ds_tree_suffix_matrix_get(m : DstreesuffixMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ds_tree_suffix_matrix_transpose(m : DstreesuffixMatrix) -> DstreesuffixMatrix {
  let result = ds_tree_suffix_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ds_tree_suffix_matrix_add(a : DstreesuffixMatrix, b : DstreesuffixMatrix) -> DstreesuffixMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ds_tree_suffix_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ds_tree_suffix_matrix_scale(m : DstreesuffixMatrix, s : Double) -> DstreesuffixMatrix {
  let result = ds_tree_suffix_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ds_tree_suffix_matrix_multiply(a : DstreesuffixMatrix, b : DstreesuffixMatrix) -> DstreesuffixMatrix {
  if a.cols != b.rows { return ds_tree_suffix_make_matrix(a.rows, b.cols, 0.0) }
  let result = ds_tree_suffix_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ds_tree_suffix_matrix_trace(m : DstreesuffixMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ds_tree_suffix_matrix_det(m : DstreesuffixMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ds_tree_suffix_matrix_norm(m : DstreesuffixMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ds_tree_suffix_matrix_to_string(m : DstreesuffixMatrix) -> String {
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

pub(all) struct DstreesuffixVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_tree_suffix_make_vector(comps : Array[Double]) -> DstreesuffixVector {
  { comps, dim: comps.length() }
}

pub fn ds_tree_suffix_vector_zero(dim : Int) -> DstreesuffixVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ds_tree_suffix_vector_add(a : DstreesuffixVector, b : DstreesuffixVector) -> DstreesuffixVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_tree_suffix_vector_sub(a : DstreesuffixVector, b : DstreesuffixVector) -> DstreesuffixVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_tree_suffix_vector_scale(v : DstreesuffixVector, s : Double) -> DstreesuffixVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ds_tree_suffix_vector_dot(a : DstreesuffixVector, b : DstreesuffixVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ds_tree_suffix_vector_norm(v : DstreesuffixVector) -> Double { @_common.sqrt(ds_tree_suffix_vector_dot(v, v)) }

pub fn ds_tree_suffix_vector_normalize(v : DstreesuffixVector) -> DstreesuffixVector {
  let n = ds_tree_suffix_vector_norm(v)
  if n < 0.0000001 { v } else { ds_tree_suffix_vector_scale(v, 1.0 / n) }
}

pub fn ds_tree_suffix_vector_dist(a : DstreesuffixVector, b : DstreesuffixVector) -> Double {
  ds_tree_suffix_vector_norm(ds_tree_suffix_vector_sub(a, b))
}

pub fn ds_tree_suffix_vector_to_string(v : DstreesuffixVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_tree_suffix_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn ds_tree_suffix_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = ds_tree_suffix_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ds_tree_suffix_std(data : Array[Double]) -> Double { @_common.sqrt(ds_tree_suffix_var(data)) }

pub fn ds_tree_suffix_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = ds_tree_suffix_mean(a); let mb = ds_tree_suffix_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn ds_tree_suffix_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = ds_tree_suffix_std(a); let sb = ds_tree_suffix_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { ds_tree_suffix_cov(a, b) / (sa * sb) }
}

pub fn ds_tree_suffix_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = ds_tree_suffix_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ds_tree_suffix_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn ds_tree_suffix_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ds_tree_suffix_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(ds_tree_suffix_mse(pred, labels))
}

pub fn ds_tree_suffix_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn ds_tree_suffix_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = ds_tree_suffix_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn ds_tree_suffix_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn ds_tree_suffix_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn ds_tree_suffix_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = ds_tree_suffix_precision(pred, labels, pos); let r = ds_tree_suffix_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn ds_tree_suffix_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn ds_tree_suffix_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = ds_tree_suffix_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn ds_tree_suffix_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn ds_tree_suffix_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn ds_tree_suffix_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = ds_tree_suffix_gcd(a, b)
    (a / g) * b
  }
}

pub fn ds_tree_suffix_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn ds_tree_suffix_fibonacci(n : Int) -> Int {
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

pub fn ds_tree_suffix_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = ds_tree_suffix_min(data); let mx = ds_tree_suffix_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn ds_tree_suffix_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = ds_tree_suffix_mean(data); let sd = ds_tree_suffix_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn ds_tree_suffix_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn ds_tree_suffix_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn ds_tree_suffix_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn ds_tree_suffix_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn ds_tree_suffix_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn ds_tree_suffix_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct DstreesuffixFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_suffix_frame_make(size : Int) -> DstreesuffixFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_suffix_frame_len(s : DstreesuffixFrame) -> Int { s.size }

pub fn ds_tree_suffix_frame_get(s : DstreesuffixFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_suffix_frame_set(s : DstreesuffixFrame, i : Int, v : Double) -> DstreesuffixFrame {
  let result = ds_tree_suffix_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_suffix_frame_sum(s : DstreesuffixFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_suffix_frame_mean(s : DstreesuffixFrame) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_suffix_frame_sum(s) / s.size.to_double() }
}

pub fn ds_tree_suffix_frame_scale(s : DstreesuffixFrame, f : Double) -> DstreesuffixFrame {
  let result = ds_tree_suffix_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_suffix_frame_add(a : DstreesuffixFrame, b : DstreesuffixFrame) -> DstreesuffixFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_suffix_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_suffix_frame_copy(s : DstreesuffixFrame) -> DstreesuffixFrame {
  let result = ds_tree_suffix_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_suffix_frame_fill(s : DstreesuffixFrame, v : Double) -> DstreesuffixFrame {
  let result = ds_tree_suffix_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_suffix_frame_min(s : DstreesuffixFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_suffix_frame_max(s : DstreesuffixFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_suffix_frame_to_string(s : DstreesuffixFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreesuffixTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_suffix_table_make(size : Int) -> DstreesuffixTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_suffix_table_len(s : DstreesuffixTable) -> Int { s.size }

pub fn ds_tree_suffix_table_get(s : DstreesuffixTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_suffix_table_set(s : DstreesuffixTable, i : Int, v : Double) -> DstreesuffixTable {
  let result = ds_tree_suffix_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_suffix_table_sum(s : DstreesuffixTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_suffix_table_mean(s : DstreesuffixTable) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_suffix_table_sum(s) / s.size.to_double() }
}

pub fn ds_tree_suffix_table_scale(s : DstreesuffixTable, f : Double) -> DstreesuffixTable {
  let result = ds_tree_suffix_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_suffix_table_add(a : DstreesuffixTable, b : DstreesuffixTable) -> DstreesuffixTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_suffix_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_suffix_table_copy(s : DstreesuffixTable) -> DstreesuffixTable {
  let result = ds_tree_suffix_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_suffix_table_fill(s : DstreesuffixTable, v : Double) -> DstreesuffixTable {
  let result = ds_tree_suffix_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_suffix_table_min(s : DstreesuffixTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_suffix_table_max(s : DstreesuffixTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_suffix_table_to_string(s : DstreesuffixTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreesuffixGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_suffix_graphn_make(size : Int) -> DstreesuffixGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_suffix_graphn_len(s : DstreesuffixGraphN) -> Int { s.size }

pub fn ds_tree_suffix_graphn_get(s : DstreesuffixGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_suffix_graphn_set(s : DstreesuffixGraphN, i : Int, v : Double) -> DstreesuffixGraphN {
  let result = ds_tree_suffix_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_suffix_graphn_sum(s : DstreesuffixGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_suffix_graphn_mean(s : DstreesuffixGraphN) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_suffix_graphn_sum(s) / s.size.to_double() }
}

pub fn ds_tree_suffix_graphn_scale(s : DstreesuffixGraphN, f : Double) -> DstreesuffixGraphN {
  let result = ds_tree_suffix_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_suffix_graphn_add(a : DstreesuffixGraphN, b : DstreesuffixGraphN) -> DstreesuffixGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_suffix_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_suffix_graphn_copy(s : DstreesuffixGraphN) -> DstreesuffixGraphN {
  let result = ds_tree_suffix_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_suffix_graphn_fill(s : DstreesuffixGraphN, v : Double) -> DstreesuffixGraphN {
  let result = ds_tree_suffix_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_suffix_graphn_min(s : DstreesuffixGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_suffix_graphn_max(s : DstreesuffixGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_suffix_graphn_to_string(s : DstreesuffixGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreesuffixNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_suffix_node_make(size : Int) -> DstreesuffixNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_suffix_node_len(s : DstreesuffixNode) -> Int { s.size }

pub fn ds_tree_suffix_node_get(s : DstreesuffixNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_suffix_node_set(s : DstreesuffixNode, i : Int, v : Double) -> DstreesuffixNode {
  let result = ds_tree_suffix_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_suffix_node_sum(s : DstreesuffixNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_suffix_node_mean(s : DstreesuffixNode) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_suffix_node_sum(s) / s.size.to_double() }
}

pub fn ds_tree_suffix_node_scale(s : DstreesuffixNode, f : Double) -> DstreesuffixNode {
  let result = ds_tree_suffix_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_suffix_node_add(a : DstreesuffixNode, b : DstreesuffixNode) -> DstreesuffixNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_suffix_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_suffix_node_copy(s : DstreesuffixNode) -> DstreesuffixNode {
  let result = ds_tree_suffix_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_suffix_node_fill(s : DstreesuffixNode, v : Double) -> DstreesuffixNode {
  let result = ds_tree_suffix_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_suffix_node_min(s : DstreesuffixNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_suffix_node_max(s : DstreesuffixNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_suffix_node_to_string(s : DstreesuffixNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreesuffixEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_suffix_edge_make(size : Int) -> DstreesuffixEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_suffix_edge_len(s : DstreesuffixEdge) -> Int { s.size }

pub fn ds_tree_suffix_edge_get(s : DstreesuffixEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_suffix_edge_set(s : DstreesuffixEdge, i : Int, v : Double) -> DstreesuffixEdge {
  let result = ds_tree_suffix_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_suffix_edge_sum(s : DstreesuffixEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_suffix_edge_mean(s : DstreesuffixEdge) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_suffix_edge_sum(s) / s.size.to_double() }
}

pub fn ds_tree_suffix_edge_scale(s : DstreesuffixEdge, f : Double) -> DstreesuffixEdge {
  let result = ds_tree_suffix_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_suffix_edge_add(a : DstreesuffixEdge, b : DstreesuffixEdge) -> DstreesuffixEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_suffix_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_suffix_edge_copy(s : DstreesuffixEdge) -> DstreesuffixEdge {
  let result = ds_tree_suffix_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_suffix_edge_fill(s : DstreesuffixEdge, v : Double) -> DstreesuffixEdge {
  let result = ds_tree_suffix_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_suffix_edge_min(s : DstreesuffixEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_suffix_edge_max(s : DstreesuffixEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_suffix_edge_to_string(s : DstreesuffixEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreesuffixPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_suffix_path_make(size : Int) -> DstreesuffixPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_suffix_path_len(s : DstreesuffixPath) -> Int { s.size }

pub fn ds_tree_suffix_path_get(s : DstreesuffixPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_suffix_path_set(s : DstreesuffixPath, i : Int, v : Double) -> DstreesuffixPath {
  let result = ds_tree_suffix_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_suffix_path_sum(s : DstreesuffixPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_suffix_path_mean(s : DstreesuffixPath) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_suffix_path_sum(s) / s.size.to_double() }
}

pub fn ds_tree_suffix_path_scale(s : DstreesuffixPath, f : Double) -> DstreesuffixPath {
  let result = ds_tree_suffix_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_suffix_path_add(a : DstreesuffixPath, b : DstreesuffixPath) -> DstreesuffixPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_suffix_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_suffix_path_copy(s : DstreesuffixPath) -> DstreesuffixPath {
  let result = ds_tree_suffix_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_suffix_path_fill(s : DstreesuffixPath, v : Double) -> DstreesuffixPath {
  let result = ds_tree_suffix_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_suffix_path_min(s : DstreesuffixPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_suffix_path_max(s : DstreesuffixPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_suffix_path_to_string(s : DstreesuffixPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreesuffixCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_suffix_cluster_make(size : Int) -> DstreesuffixCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_suffix_cluster_len(s : DstreesuffixCluster) -> Int { s.size }

pub fn ds_tree_suffix_cluster_get(s : DstreesuffixCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_suffix_cluster_set(s : DstreesuffixCluster, i : Int, v : Double) -> DstreesuffixCluster {
  let result = ds_tree_suffix_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_suffix_cluster_sum(s : DstreesuffixCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_suffix_cluster_mean(s : DstreesuffixCluster) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_suffix_cluster_sum(s) / s.size.to_double() }
}

pub fn ds_tree_suffix_cluster_scale(s : DstreesuffixCluster, f : Double) -> DstreesuffixCluster {
  let result = ds_tree_suffix_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_suffix_cluster_add(a : DstreesuffixCluster, b : DstreesuffixCluster) -> DstreesuffixCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_suffix_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_suffix_cluster_copy(s : DstreesuffixCluster) -> DstreesuffixCluster {
  let result = ds_tree_suffix_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_suffix_cluster_fill(s : DstreesuffixCluster, v : Double) -> DstreesuffixCluster {
  let result = ds_tree_suffix_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_suffix_cluster_min(s : DstreesuffixCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_suffix_cluster_max(s : DstreesuffixCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_suffix_cluster_to_string(s : DstreesuffixCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreesuffixModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_suffix_model_make(size : Int) -> DstreesuffixModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_suffix_model_len(s : DstreesuffixModel) -> Int { s.size }

pub fn ds_tree_suffix_model_get(s : DstreesuffixModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_suffix_model_set(s : DstreesuffixModel, i : Int, v : Double) -> DstreesuffixModel {
  let result = ds_tree_suffix_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_suffix_model_sum(s : DstreesuffixModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_suffix_model_mean(s : DstreesuffixModel) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_suffix_model_sum(s) / s.size.to_double() }
}

pub fn ds_tree_suffix_model_scale(s : DstreesuffixModel, f : Double) -> DstreesuffixModel {
  let result = ds_tree_suffix_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_suffix_model_add(a : DstreesuffixModel, b : DstreesuffixModel) -> DstreesuffixModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_suffix_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_suffix_model_copy(s : DstreesuffixModel) -> DstreesuffixModel {
  let result = ds_tree_suffix_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_suffix_model_fill(s : DstreesuffixModel, v : Double) -> DstreesuffixModel {
  let result = ds_tree_suffix_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_suffix_model_min(s : DstreesuffixModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_suffix_model_max(s : DstreesuffixModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_suffix_model_to_string(s : DstreesuffixModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreesuffixLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_suffix_layer_make(size : Int) -> DstreesuffixLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_suffix_layer_len(s : DstreesuffixLayer) -> Int { s.size }

pub fn ds_tree_suffix_layer_get(s : DstreesuffixLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_suffix_layer_set(s : DstreesuffixLayer, i : Int, v : Double) -> DstreesuffixLayer {
  let result = ds_tree_suffix_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_suffix_layer_sum(s : DstreesuffixLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_suffix_layer_mean(s : DstreesuffixLayer) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_suffix_layer_sum(s) / s.size.to_double() }
}

pub fn ds_tree_suffix_layer_scale(s : DstreesuffixLayer, f : Double) -> DstreesuffixLayer {
  let result = ds_tree_suffix_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_suffix_layer_add(a : DstreesuffixLayer, b : DstreesuffixLayer) -> DstreesuffixLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_suffix_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_suffix_layer_copy(s : DstreesuffixLayer) -> DstreesuffixLayer {
  let result = ds_tree_suffix_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_suffix_layer_fill(s : DstreesuffixLayer, v : Double) -> DstreesuffixLayer {
  let result = ds_tree_suffix_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_suffix_layer_min(s : DstreesuffixLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_suffix_layer_max(s : DstreesuffixLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_suffix_layer_to_string(s : DstreesuffixLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreesuffixBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_suffix_buffer_make(size : Int) -> DstreesuffixBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_suffix_buffer_len(s : DstreesuffixBuffer) -> Int { s.size }

pub fn ds_tree_suffix_buffer_get(s : DstreesuffixBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_suffix_buffer_set(s : DstreesuffixBuffer, i : Int, v : Double) -> DstreesuffixBuffer {
  let result = ds_tree_suffix_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_suffix_buffer_sum(s : DstreesuffixBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_suffix_buffer_mean(s : DstreesuffixBuffer) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_suffix_buffer_sum(s) / s.size.to_double() }
}

pub fn ds_tree_suffix_buffer_scale(s : DstreesuffixBuffer, f : Double) -> DstreesuffixBuffer {
  let result = ds_tree_suffix_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_suffix_buffer_add(a : DstreesuffixBuffer, b : DstreesuffixBuffer) -> DstreesuffixBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_suffix_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_suffix_buffer_copy(s : DstreesuffixBuffer) -> DstreesuffixBuffer {
  let result = ds_tree_suffix_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_suffix_buffer_fill(s : DstreesuffixBuffer, v : Double) -> DstreesuffixBuffer {
  let result = ds_tree_suffix_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_suffix_buffer_min(s : DstreesuffixBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_suffix_buffer_max(s : DstreesuffixBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_suffix_buffer_to_string(s : DstreesuffixBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreesuffixCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_suffix_cursor_make(size : Int) -> DstreesuffixCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_suffix_cursor_len(s : DstreesuffixCursor) -> Int { s.size }

pub fn ds_tree_suffix_cursor_get(s : DstreesuffixCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_suffix_cursor_set(s : DstreesuffixCursor, i : Int, v : Double) -> DstreesuffixCursor {
  let result = ds_tree_suffix_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_suffix_cursor_sum(s : DstreesuffixCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_suffix_cursor_mean(s : DstreesuffixCursor) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_suffix_cursor_sum(s) / s.size.to_double() }
}

pub fn ds_tree_suffix_cursor_scale(s : DstreesuffixCursor, f : Double) -> DstreesuffixCursor {
  let result = ds_tree_suffix_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_suffix_cursor_add(a : DstreesuffixCursor, b : DstreesuffixCursor) -> DstreesuffixCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_suffix_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_suffix_cursor_copy(s : DstreesuffixCursor) -> DstreesuffixCursor {
  let result = ds_tree_suffix_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_suffix_cursor_fill(s : DstreesuffixCursor, v : Double) -> DstreesuffixCursor {
  let result = ds_tree_suffix_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_suffix_cursor_min(s : DstreesuffixCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_suffix_cursor_max(s : DstreesuffixCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_suffix_cursor_to_string(s : DstreesuffixCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreesuffixView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_suffix_view_make(size : Int) -> DstreesuffixView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_suffix_view_len(s : DstreesuffixView) -> Int { s.size }

pub fn ds_tree_suffix_view_get(s : DstreesuffixView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_suffix_view_set(s : DstreesuffixView, i : Int, v : Double) -> DstreesuffixView {
  let result = ds_tree_suffix_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_suffix_view_sum(s : DstreesuffixView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_suffix_view_mean(s : DstreesuffixView) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_suffix_view_sum(s) / s.size.to_double() }
}

pub fn ds_tree_suffix_view_scale(s : DstreesuffixView, f : Double) -> DstreesuffixView {
  let result = ds_tree_suffix_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_suffix_view_add(a : DstreesuffixView, b : DstreesuffixView) -> DstreesuffixView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_suffix_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_suffix_view_copy(s : DstreesuffixView) -> DstreesuffixView {
  let result = ds_tree_suffix_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_suffix_view_fill(s : DstreesuffixView, v : Double) -> DstreesuffixView {
  let result = ds_tree_suffix_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_suffix_view_min(s : DstreesuffixView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_suffix_view_max(s : DstreesuffixView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_suffix_view_to_string(s : DstreesuffixView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreesuffixRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_suffix_range_make(size : Int) -> DstreesuffixRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_suffix_range_len(s : DstreesuffixRange) -> Int { s.size }

pub fn ds_tree_suffix_range_get(s : DstreesuffixRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_suffix_range_set(s : DstreesuffixRange, i : Int, v : Double) -> DstreesuffixRange {
  let result = ds_tree_suffix_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_suffix_range_sum(s : DstreesuffixRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_suffix_range_mean(s : DstreesuffixRange) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_suffix_range_sum(s) / s.size.to_double() }
}

pub fn ds_tree_suffix_range_scale(s : DstreesuffixRange, f : Double) -> DstreesuffixRange {
  let result = ds_tree_suffix_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_suffix_range_add(a : DstreesuffixRange, b : DstreesuffixRange) -> DstreesuffixRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_suffix_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_suffix_range_copy(s : DstreesuffixRange) -> DstreesuffixRange {
  let result = ds_tree_suffix_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_suffix_range_fill(s : DstreesuffixRange, v : Double) -> DstreesuffixRange {
  let result = ds_tree_suffix_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_suffix_range_min(s : DstreesuffixRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_suffix_range_max(s : DstreesuffixRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_suffix_range_to_string(s : DstreesuffixRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreesuffixSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_suffix_slice_make(size : Int) -> DstreesuffixSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_suffix_slice_len(s : DstreesuffixSlice) -> Int { s.size }

pub fn ds_tree_suffix_slice_get(s : DstreesuffixSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_suffix_slice_set(s : DstreesuffixSlice, i : Int, v : Double) -> DstreesuffixSlice {
  let result = ds_tree_suffix_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_suffix_slice_sum(s : DstreesuffixSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_suffix_slice_mean(s : DstreesuffixSlice) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_suffix_slice_sum(s) / s.size.to_double() }
}

pub fn ds_tree_suffix_slice_scale(s : DstreesuffixSlice, f : Double) -> DstreesuffixSlice {
  let result = ds_tree_suffix_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_suffix_slice_add(a : DstreesuffixSlice, b : DstreesuffixSlice) -> DstreesuffixSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_suffix_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_suffix_slice_copy(s : DstreesuffixSlice) -> DstreesuffixSlice {
  let result = ds_tree_suffix_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_suffix_slice_fill(s : DstreesuffixSlice, v : Double) -> DstreesuffixSlice {
  let result = ds_tree_suffix_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_suffix_slice_min(s : DstreesuffixSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_suffix_slice_max(s : DstreesuffixSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_suffix_slice_to_string(s : DstreesuffixSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


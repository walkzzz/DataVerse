///===
/// extcore/ds_tree_segment

pub(all) struct DstreesegmentPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_tree_segment_make_point(x : Double, y : Double) -> DstreesegmentPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_tree_segment_make_point3(x : Double, y : Double, z : Double) -> DstreesegmentPoint {
  { x, y, z, label: 0 }
}

pub fn ds_tree_segment_point_x(pt : DstreesegmentPoint) -> Double { pt.x }

pub fn ds_tree_segment_point_y(pt : DstreesegmentPoint) -> Double { pt.y }

pub fn ds_tree_segment_point_z(pt : DstreesegmentPoint) -> Double { pt.z }

pub fn ds_tree_segment_point_label(pt : DstreesegmentPoint) -> Int { pt.label }

pub fn ds_tree_segment_point_dist(a : DstreesegmentPoint, b : DstreesegmentPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ds_tree_segment_point_add(a : DstreesegmentPoint, b : DstreesegmentPoint) -> DstreesegmentPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ds_tree_segment_point_sub(a : DstreesegmentPoint, b : DstreesegmentPoint) -> DstreesegmentPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ds_tree_segment_point_scale(pt : DstreesegmentPoint, s : Double) -> DstreesegmentPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ds_tree_segment_point_dot(a : DstreesegmentPoint, b : DstreesegmentPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ds_tree_segment_point_cross(a : DstreesegmentPoint, b : DstreesegmentPoint) -> DstreesegmentPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ds_tree_segment_point_norm(pt : DstreesegmentPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ds_tree_segment_point_normalize(pt : DstreesegmentPoint) -> DstreesegmentPoint {
  let n = ds_tree_segment_point_norm(pt)
  if n < 0.0000001 { pt } else { ds_tree_segment_point_scale(pt, 1.0 / n) }
}

pub fn ds_tree_segment_point_negate(pt : DstreesegmentPoint) -> DstreesegmentPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ds_tree_segment_point_mid(a : DstreesegmentPoint, b : DstreesegmentPoint) -> DstreesegmentPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ds_tree_segment_point_lerp(a : DstreesegmentPoint, b : DstreesegmentPoint, t : Double) -> DstreesegmentPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ds_tree_segment_point_to_string(pt : DstreesegmentPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DstreesegmentSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_tree_segment_make_series(vals : Array[Double], name : String) -> DstreesegmentSeries {
  { vals, name, meta: 0 }
}

pub fn ds_tree_segment_series_len(s : DstreesegmentSeries) -> Int { s.vals.length() }

pub fn ds_tree_segment_series_sum(s : DstreesegmentSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn ds_tree_segment_series_mean(s : DstreesegmentSeries) -> Double {
  let n = ds_tree_segment_series_len(s)
  if n == 0 { 0.0 } else { ds_tree_segment_series_sum(s) / n.to_double() }
}

pub fn ds_tree_segment_series_min(s : DstreesegmentSeries) -> Double {
  let n = ds_tree_segment_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn ds_tree_segment_series_max(s : DstreesegmentSeries) -> Double {
  let n = ds_tree_segment_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn ds_tree_segment_series_range(s : DstreesegmentSeries) -> Double {
  ds_tree_segment_series_max(s) - ds_tree_segment_series_min(s)
}

pub fn ds_tree_segment_series_var(s : DstreesegmentSeries) -> Double {
  let n = ds_tree_segment_series_len(s)
  if n == 0 { 0.0 } else {
    let m = ds_tree_segment_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn ds_tree_segment_series_std(s : DstreesegmentSeries) -> Double { @_common.sqrt(ds_tree_segment_series_var(s)) }

pub fn ds_tree_segment_series_median(s : DstreesegmentSeries) -> Double {
  let n = ds_tree_segment_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = ds_tree_segment_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ds_tree_segment_series_scale(s : DstreesegmentSeries, f : Double) -> DstreesegmentSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ds_tree_segment_series_add(a : DstreesegmentSeries, b : DstreesegmentSeries) -> DstreesegmentSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ds_tree_segment_series_sub(a : DstreesegmentSeries, b : DstreesegmentSeries) -> DstreesegmentSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ds_tree_segment_series_normalize(s : DstreesegmentSeries) -> DstreesegmentSeries {
  let mn = ds_tree_segment_series_min(s)
  let mx = ds_tree_segment_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ds_tree_segment_series_cumsum(s : DstreesegmentSeries) -> DstreesegmentSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn ds_tree_segment_series_to_string(s : DstreesegmentSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DstreesegmentMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_tree_segment_make_matrix(rows : Int, cols : Int, val : Double) -> DstreesegmentMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_tree_segment_matrix_identity(n : Int) -> DstreesegmentMatrix {
  let m = ds_tree_segment_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ds_tree_segment_matrix_get(m : DstreesegmentMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ds_tree_segment_matrix_transpose(m : DstreesegmentMatrix) -> DstreesegmentMatrix {
  let result = ds_tree_segment_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ds_tree_segment_matrix_add(a : DstreesegmentMatrix, b : DstreesegmentMatrix) -> DstreesegmentMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ds_tree_segment_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ds_tree_segment_matrix_scale(m : DstreesegmentMatrix, s : Double) -> DstreesegmentMatrix {
  let result = ds_tree_segment_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ds_tree_segment_matrix_multiply(a : DstreesegmentMatrix, b : DstreesegmentMatrix) -> DstreesegmentMatrix {
  if a.cols != b.rows { return ds_tree_segment_make_matrix(a.rows, b.cols, 0.0) }
  let result = ds_tree_segment_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ds_tree_segment_matrix_trace(m : DstreesegmentMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ds_tree_segment_matrix_det(m : DstreesegmentMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ds_tree_segment_matrix_norm(m : DstreesegmentMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ds_tree_segment_matrix_to_string(m : DstreesegmentMatrix) -> String {
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

pub(all) struct DstreesegmentVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_tree_segment_make_vector(comps : Array[Double]) -> DstreesegmentVector {
  { comps, dim: comps.length() }
}

pub fn ds_tree_segment_vector_zero(dim : Int) -> DstreesegmentVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ds_tree_segment_vector_add(a : DstreesegmentVector, b : DstreesegmentVector) -> DstreesegmentVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_tree_segment_vector_sub(a : DstreesegmentVector, b : DstreesegmentVector) -> DstreesegmentVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_tree_segment_vector_scale(v : DstreesegmentVector, s : Double) -> DstreesegmentVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ds_tree_segment_vector_dot(a : DstreesegmentVector, b : DstreesegmentVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ds_tree_segment_vector_norm(v : DstreesegmentVector) -> Double { @_common.sqrt(ds_tree_segment_vector_dot(v, v)) }

pub fn ds_tree_segment_vector_normalize(v : DstreesegmentVector) -> DstreesegmentVector {
  let n = ds_tree_segment_vector_norm(v)
  if n < 0.0000001 { v } else { ds_tree_segment_vector_scale(v, 1.0 / n) }
}

pub fn ds_tree_segment_vector_dist(a : DstreesegmentVector, b : DstreesegmentVector) -> Double {
  ds_tree_segment_vector_norm(ds_tree_segment_vector_sub(a, b))
}

pub fn ds_tree_segment_vector_to_string(v : DstreesegmentVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_tree_segment_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn ds_tree_segment_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = ds_tree_segment_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ds_tree_segment_std(data : Array[Double]) -> Double { @_common.sqrt(ds_tree_segment_var(data)) }

pub fn ds_tree_segment_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = ds_tree_segment_mean(a); let mb = ds_tree_segment_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn ds_tree_segment_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = ds_tree_segment_std(a); let sb = ds_tree_segment_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { ds_tree_segment_cov(a, b) / (sa * sb) }
}

pub fn ds_tree_segment_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = ds_tree_segment_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ds_tree_segment_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn ds_tree_segment_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ds_tree_segment_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(ds_tree_segment_mse(pred, labels))
}

pub fn ds_tree_segment_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn ds_tree_segment_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = ds_tree_segment_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn ds_tree_segment_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn ds_tree_segment_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn ds_tree_segment_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = ds_tree_segment_precision(pred, labels, pos); let r = ds_tree_segment_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn ds_tree_segment_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn ds_tree_segment_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = ds_tree_segment_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn ds_tree_segment_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn ds_tree_segment_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn ds_tree_segment_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = ds_tree_segment_gcd(a, b)
    (a / g) * b
  }
}

pub fn ds_tree_segment_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn ds_tree_segment_fibonacci(n : Int) -> Int {
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

pub fn ds_tree_segment_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = ds_tree_segment_min(data); let mx = ds_tree_segment_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn ds_tree_segment_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = ds_tree_segment_mean(data); let sd = ds_tree_segment_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn ds_tree_segment_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn ds_tree_segment_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn ds_tree_segment_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn ds_tree_segment_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn ds_tree_segment_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn ds_tree_segment_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct DstreesegmentFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_segment_frame_make(size : Int) -> DstreesegmentFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_segment_frame_len(s : DstreesegmentFrame) -> Int { s.size }

pub fn ds_tree_segment_frame_get(s : DstreesegmentFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_segment_frame_set(s : DstreesegmentFrame, i : Int, v : Double) -> DstreesegmentFrame {
  let result = ds_tree_segment_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_segment_frame_sum(s : DstreesegmentFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_segment_frame_mean(s : DstreesegmentFrame) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_segment_frame_sum(s) / s.size.to_double() }
}

pub fn ds_tree_segment_frame_scale(s : DstreesegmentFrame, f : Double) -> DstreesegmentFrame {
  let result = ds_tree_segment_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_segment_frame_add(a : DstreesegmentFrame, b : DstreesegmentFrame) -> DstreesegmentFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_segment_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_segment_frame_copy(s : DstreesegmentFrame) -> DstreesegmentFrame {
  let result = ds_tree_segment_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_segment_frame_fill(s : DstreesegmentFrame, v : Double) -> DstreesegmentFrame {
  let result = ds_tree_segment_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_segment_frame_min(s : DstreesegmentFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_segment_frame_max(s : DstreesegmentFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_segment_frame_to_string(s : DstreesegmentFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreesegmentTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_segment_table_make(size : Int) -> DstreesegmentTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_segment_table_len(s : DstreesegmentTable) -> Int { s.size }

pub fn ds_tree_segment_table_get(s : DstreesegmentTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_segment_table_set(s : DstreesegmentTable, i : Int, v : Double) -> DstreesegmentTable {
  let result = ds_tree_segment_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_segment_table_sum(s : DstreesegmentTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_segment_table_mean(s : DstreesegmentTable) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_segment_table_sum(s) / s.size.to_double() }
}

pub fn ds_tree_segment_table_scale(s : DstreesegmentTable, f : Double) -> DstreesegmentTable {
  let result = ds_tree_segment_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_segment_table_add(a : DstreesegmentTable, b : DstreesegmentTable) -> DstreesegmentTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_segment_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_segment_table_copy(s : DstreesegmentTable) -> DstreesegmentTable {
  let result = ds_tree_segment_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_segment_table_fill(s : DstreesegmentTable, v : Double) -> DstreesegmentTable {
  let result = ds_tree_segment_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_segment_table_min(s : DstreesegmentTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_segment_table_max(s : DstreesegmentTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_segment_table_to_string(s : DstreesegmentTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreesegmentGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_segment_graphn_make(size : Int) -> DstreesegmentGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_segment_graphn_len(s : DstreesegmentGraphN) -> Int { s.size }

pub fn ds_tree_segment_graphn_get(s : DstreesegmentGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_segment_graphn_set(s : DstreesegmentGraphN, i : Int, v : Double) -> DstreesegmentGraphN {
  let result = ds_tree_segment_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_segment_graphn_sum(s : DstreesegmentGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_segment_graphn_mean(s : DstreesegmentGraphN) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_segment_graphn_sum(s) / s.size.to_double() }
}

pub fn ds_tree_segment_graphn_scale(s : DstreesegmentGraphN, f : Double) -> DstreesegmentGraphN {
  let result = ds_tree_segment_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_segment_graphn_add(a : DstreesegmentGraphN, b : DstreesegmentGraphN) -> DstreesegmentGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_segment_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_segment_graphn_copy(s : DstreesegmentGraphN) -> DstreesegmentGraphN {
  let result = ds_tree_segment_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_segment_graphn_fill(s : DstreesegmentGraphN, v : Double) -> DstreesegmentGraphN {
  let result = ds_tree_segment_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_segment_graphn_min(s : DstreesegmentGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_segment_graphn_max(s : DstreesegmentGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_segment_graphn_to_string(s : DstreesegmentGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreesegmentNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_segment_node_make(size : Int) -> DstreesegmentNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_segment_node_len(s : DstreesegmentNode) -> Int { s.size }

pub fn ds_tree_segment_node_get(s : DstreesegmentNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_segment_node_set(s : DstreesegmentNode, i : Int, v : Double) -> DstreesegmentNode {
  let result = ds_tree_segment_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_segment_node_sum(s : DstreesegmentNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_segment_node_mean(s : DstreesegmentNode) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_segment_node_sum(s) / s.size.to_double() }
}

pub fn ds_tree_segment_node_scale(s : DstreesegmentNode, f : Double) -> DstreesegmentNode {
  let result = ds_tree_segment_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_segment_node_add(a : DstreesegmentNode, b : DstreesegmentNode) -> DstreesegmentNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_segment_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_segment_node_copy(s : DstreesegmentNode) -> DstreesegmentNode {
  let result = ds_tree_segment_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_segment_node_fill(s : DstreesegmentNode, v : Double) -> DstreesegmentNode {
  let result = ds_tree_segment_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_segment_node_min(s : DstreesegmentNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_segment_node_max(s : DstreesegmentNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_segment_node_to_string(s : DstreesegmentNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreesegmentEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_segment_edge_make(size : Int) -> DstreesegmentEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_segment_edge_len(s : DstreesegmentEdge) -> Int { s.size }

pub fn ds_tree_segment_edge_get(s : DstreesegmentEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_segment_edge_set(s : DstreesegmentEdge, i : Int, v : Double) -> DstreesegmentEdge {
  let result = ds_tree_segment_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_segment_edge_sum(s : DstreesegmentEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_segment_edge_mean(s : DstreesegmentEdge) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_segment_edge_sum(s) / s.size.to_double() }
}

pub fn ds_tree_segment_edge_scale(s : DstreesegmentEdge, f : Double) -> DstreesegmentEdge {
  let result = ds_tree_segment_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_segment_edge_add(a : DstreesegmentEdge, b : DstreesegmentEdge) -> DstreesegmentEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_segment_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_segment_edge_copy(s : DstreesegmentEdge) -> DstreesegmentEdge {
  let result = ds_tree_segment_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_segment_edge_fill(s : DstreesegmentEdge, v : Double) -> DstreesegmentEdge {
  let result = ds_tree_segment_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_segment_edge_min(s : DstreesegmentEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_segment_edge_max(s : DstreesegmentEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_segment_edge_to_string(s : DstreesegmentEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreesegmentPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_segment_path_make(size : Int) -> DstreesegmentPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_segment_path_len(s : DstreesegmentPath) -> Int { s.size }

pub fn ds_tree_segment_path_get(s : DstreesegmentPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_segment_path_set(s : DstreesegmentPath, i : Int, v : Double) -> DstreesegmentPath {
  let result = ds_tree_segment_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_segment_path_sum(s : DstreesegmentPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_segment_path_mean(s : DstreesegmentPath) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_segment_path_sum(s) / s.size.to_double() }
}

pub fn ds_tree_segment_path_scale(s : DstreesegmentPath, f : Double) -> DstreesegmentPath {
  let result = ds_tree_segment_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_segment_path_add(a : DstreesegmentPath, b : DstreesegmentPath) -> DstreesegmentPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_segment_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_segment_path_copy(s : DstreesegmentPath) -> DstreesegmentPath {
  let result = ds_tree_segment_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_segment_path_fill(s : DstreesegmentPath, v : Double) -> DstreesegmentPath {
  let result = ds_tree_segment_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_segment_path_min(s : DstreesegmentPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_segment_path_max(s : DstreesegmentPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_segment_path_to_string(s : DstreesegmentPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreesegmentCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_segment_cluster_make(size : Int) -> DstreesegmentCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_segment_cluster_len(s : DstreesegmentCluster) -> Int { s.size }

pub fn ds_tree_segment_cluster_get(s : DstreesegmentCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_segment_cluster_set(s : DstreesegmentCluster, i : Int, v : Double) -> DstreesegmentCluster {
  let result = ds_tree_segment_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_segment_cluster_sum(s : DstreesegmentCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_segment_cluster_mean(s : DstreesegmentCluster) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_segment_cluster_sum(s) / s.size.to_double() }
}

pub fn ds_tree_segment_cluster_scale(s : DstreesegmentCluster, f : Double) -> DstreesegmentCluster {
  let result = ds_tree_segment_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_segment_cluster_add(a : DstreesegmentCluster, b : DstreesegmentCluster) -> DstreesegmentCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_segment_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_segment_cluster_copy(s : DstreesegmentCluster) -> DstreesegmentCluster {
  let result = ds_tree_segment_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_segment_cluster_fill(s : DstreesegmentCluster, v : Double) -> DstreesegmentCluster {
  let result = ds_tree_segment_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_segment_cluster_min(s : DstreesegmentCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_segment_cluster_max(s : DstreesegmentCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_segment_cluster_to_string(s : DstreesegmentCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreesegmentModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_segment_model_make(size : Int) -> DstreesegmentModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_segment_model_len(s : DstreesegmentModel) -> Int { s.size }

pub fn ds_tree_segment_model_get(s : DstreesegmentModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_segment_model_set(s : DstreesegmentModel, i : Int, v : Double) -> DstreesegmentModel {
  let result = ds_tree_segment_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_segment_model_sum(s : DstreesegmentModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_segment_model_mean(s : DstreesegmentModel) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_segment_model_sum(s) / s.size.to_double() }
}

pub fn ds_tree_segment_model_scale(s : DstreesegmentModel, f : Double) -> DstreesegmentModel {
  let result = ds_tree_segment_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_segment_model_add(a : DstreesegmentModel, b : DstreesegmentModel) -> DstreesegmentModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_segment_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_segment_model_copy(s : DstreesegmentModel) -> DstreesegmentModel {
  let result = ds_tree_segment_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_segment_model_fill(s : DstreesegmentModel, v : Double) -> DstreesegmentModel {
  let result = ds_tree_segment_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_segment_model_min(s : DstreesegmentModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_segment_model_max(s : DstreesegmentModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_segment_model_to_string(s : DstreesegmentModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreesegmentLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_segment_layer_make(size : Int) -> DstreesegmentLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_segment_layer_len(s : DstreesegmentLayer) -> Int { s.size }

pub fn ds_tree_segment_layer_get(s : DstreesegmentLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_segment_layer_set(s : DstreesegmentLayer, i : Int, v : Double) -> DstreesegmentLayer {
  let result = ds_tree_segment_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_segment_layer_sum(s : DstreesegmentLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_segment_layer_mean(s : DstreesegmentLayer) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_segment_layer_sum(s) / s.size.to_double() }
}

pub fn ds_tree_segment_layer_scale(s : DstreesegmentLayer, f : Double) -> DstreesegmentLayer {
  let result = ds_tree_segment_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_segment_layer_add(a : DstreesegmentLayer, b : DstreesegmentLayer) -> DstreesegmentLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_segment_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_segment_layer_copy(s : DstreesegmentLayer) -> DstreesegmentLayer {
  let result = ds_tree_segment_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_segment_layer_fill(s : DstreesegmentLayer, v : Double) -> DstreesegmentLayer {
  let result = ds_tree_segment_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_segment_layer_min(s : DstreesegmentLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_segment_layer_max(s : DstreesegmentLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_segment_layer_to_string(s : DstreesegmentLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreesegmentBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_segment_buffer_make(size : Int) -> DstreesegmentBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_segment_buffer_len(s : DstreesegmentBuffer) -> Int { s.size }

pub fn ds_tree_segment_buffer_get(s : DstreesegmentBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_segment_buffer_set(s : DstreesegmentBuffer, i : Int, v : Double) -> DstreesegmentBuffer {
  let result = ds_tree_segment_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_segment_buffer_sum(s : DstreesegmentBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_segment_buffer_mean(s : DstreesegmentBuffer) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_segment_buffer_sum(s) / s.size.to_double() }
}

pub fn ds_tree_segment_buffer_scale(s : DstreesegmentBuffer, f : Double) -> DstreesegmentBuffer {
  let result = ds_tree_segment_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_segment_buffer_add(a : DstreesegmentBuffer, b : DstreesegmentBuffer) -> DstreesegmentBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_segment_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_segment_buffer_copy(s : DstreesegmentBuffer) -> DstreesegmentBuffer {
  let result = ds_tree_segment_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_segment_buffer_fill(s : DstreesegmentBuffer, v : Double) -> DstreesegmentBuffer {
  let result = ds_tree_segment_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_segment_buffer_min(s : DstreesegmentBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_segment_buffer_max(s : DstreesegmentBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_segment_buffer_to_string(s : DstreesegmentBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreesegmentCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_segment_cursor_make(size : Int) -> DstreesegmentCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_segment_cursor_len(s : DstreesegmentCursor) -> Int { s.size }

pub fn ds_tree_segment_cursor_get(s : DstreesegmentCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_segment_cursor_set(s : DstreesegmentCursor, i : Int, v : Double) -> DstreesegmentCursor {
  let result = ds_tree_segment_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_segment_cursor_sum(s : DstreesegmentCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_segment_cursor_mean(s : DstreesegmentCursor) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_segment_cursor_sum(s) / s.size.to_double() }
}

pub fn ds_tree_segment_cursor_scale(s : DstreesegmentCursor, f : Double) -> DstreesegmentCursor {
  let result = ds_tree_segment_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_segment_cursor_add(a : DstreesegmentCursor, b : DstreesegmentCursor) -> DstreesegmentCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_segment_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_segment_cursor_copy(s : DstreesegmentCursor) -> DstreesegmentCursor {
  let result = ds_tree_segment_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_segment_cursor_fill(s : DstreesegmentCursor, v : Double) -> DstreesegmentCursor {
  let result = ds_tree_segment_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_segment_cursor_min(s : DstreesegmentCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_segment_cursor_max(s : DstreesegmentCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_segment_cursor_to_string(s : DstreesegmentCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreesegmentView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_segment_view_make(size : Int) -> DstreesegmentView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_segment_view_len(s : DstreesegmentView) -> Int { s.size }

pub fn ds_tree_segment_view_get(s : DstreesegmentView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_segment_view_set(s : DstreesegmentView, i : Int, v : Double) -> DstreesegmentView {
  let result = ds_tree_segment_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_segment_view_sum(s : DstreesegmentView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_segment_view_mean(s : DstreesegmentView) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_segment_view_sum(s) / s.size.to_double() }
}

pub fn ds_tree_segment_view_scale(s : DstreesegmentView, f : Double) -> DstreesegmentView {
  let result = ds_tree_segment_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_segment_view_add(a : DstreesegmentView, b : DstreesegmentView) -> DstreesegmentView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_segment_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_segment_view_copy(s : DstreesegmentView) -> DstreesegmentView {
  let result = ds_tree_segment_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_segment_view_fill(s : DstreesegmentView, v : Double) -> DstreesegmentView {
  let result = ds_tree_segment_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_segment_view_min(s : DstreesegmentView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_segment_view_max(s : DstreesegmentView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_segment_view_to_string(s : DstreesegmentView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreesegmentRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_segment_range_make(size : Int) -> DstreesegmentRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_segment_range_len(s : DstreesegmentRange) -> Int { s.size }

pub fn ds_tree_segment_range_get(s : DstreesegmentRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_segment_range_set(s : DstreesegmentRange, i : Int, v : Double) -> DstreesegmentRange {
  let result = ds_tree_segment_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_segment_range_sum(s : DstreesegmentRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_segment_range_mean(s : DstreesegmentRange) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_segment_range_sum(s) / s.size.to_double() }
}

pub fn ds_tree_segment_range_scale(s : DstreesegmentRange, f : Double) -> DstreesegmentRange {
  let result = ds_tree_segment_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_segment_range_add(a : DstreesegmentRange, b : DstreesegmentRange) -> DstreesegmentRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_segment_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_segment_range_copy(s : DstreesegmentRange) -> DstreesegmentRange {
  let result = ds_tree_segment_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_segment_range_fill(s : DstreesegmentRange, v : Double) -> DstreesegmentRange {
  let result = ds_tree_segment_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_segment_range_min(s : DstreesegmentRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_segment_range_max(s : DstreesegmentRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_segment_range_to_string(s : DstreesegmentRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreesegmentSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_segment_slice_make(size : Int) -> DstreesegmentSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_segment_slice_len(s : DstreesegmentSlice) -> Int { s.size }

pub fn ds_tree_segment_slice_get(s : DstreesegmentSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_segment_slice_set(s : DstreesegmentSlice, i : Int, v : Double) -> DstreesegmentSlice {
  let result = ds_tree_segment_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_tree_segment_slice_sum(s : DstreesegmentSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_tree_segment_slice_mean(s : DstreesegmentSlice) -> Double {
  if s.size == 0 { 0.0 } else { ds_tree_segment_slice_sum(s) / s.size.to_double() }
}

pub fn ds_tree_segment_slice_scale(s : DstreesegmentSlice, f : Double) -> DstreesegmentSlice {
  let result = ds_tree_segment_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_tree_segment_slice_add(a : DstreesegmentSlice, b : DstreesegmentSlice) -> DstreesegmentSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_tree_segment_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_tree_segment_slice_copy(s : DstreesegmentSlice) -> DstreesegmentSlice {
  let result = ds_tree_segment_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_tree_segment_slice_fill(s : DstreesegmentSlice, v : Double) -> DstreesegmentSlice {
  let result = ds_tree_segment_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_tree_segment_slice_min(s : DstreesegmentSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_segment_slice_max(s : DstreesegmentSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_tree_segment_slice_to_string(s : DstreesegmentSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


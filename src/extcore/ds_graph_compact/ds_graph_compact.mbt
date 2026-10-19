///===
/// extcore/ds_graph_compact

pub(all) struct DsgraphcompactPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_graph_compact_make_point(x : Double, y : Double) -> DsgraphcompactPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_graph_compact_make_point3(x : Double, y : Double, z : Double) -> DsgraphcompactPoint {
  { x, y, z, label: 0 }
}

pub fn ds_graph_compact_point_x(pt : DsgraphcompactPoint) -> Double { pt.x }

pub fn ds_graph_compact_point_y(pt : DsgraphcompactPoint) -> Double { pt.y }

pub fn ds_graph_compact_point_z(pt : DsgraphcompactPoint) -> Double { pt.z }

pub fn ds_graph_compact_point_label(pt : DsgraphcompactPoint) -> Int { pt.label }

pub fn ds_graph_compact_point_dist(a : DsgraphcompactPoint, b : DsgraphcompactPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  ds_graph_compact_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ds_graph_compact_point_add(a : DsgraphcompactPoint, b : DsgraphcompactPoint) -> DsgraphcompactPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ds_graph_compact_point_sub(a : DsgraphcompactPoint, b : DsgraphcompactPoint) -> DsgraphcompactPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ds_graph_compact_point_scale(pt : DsgraphcompactPoint, s : Double) -> DsgraphcompactPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ds_graph_compact_point_dot(a : DsgraphcompactPoint, b : DsgraphcompactPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ds_graph_compact_point_cross(a : DsgraphcompactPoint, b : DsgraphcompactPoint) -> DsgraphcompactPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ds_graph_compact_point_norm(pt : DsgraphcompactPoint) -> Double {
  ds_graph_compact_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ds_graph_compact_point_normalize(pt : DsgraphcompactPoint) -> DsgraphcompactPoint {
  let n = ds_graph_compact_point_norm(pt)
  if n < 0.0000001 { pt } else { ds_graph_compact_point_scale(pt, 1.0 / n) }
}

pub fn ds_graph_compact_point_negate(pt : DsgraphcompactPoint) -> DsgraphcompactPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ds_graph_compact_point_mid(a : DsgraphcompactPoint, b : DsgraphcompactPoint) -> DsgraphcompactPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ds_graph_compact_point_lerp(a : DsgraphcompactPoint, b : DsgraphcompactPoint, t : Double) -> DsgraphcompactPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ds_graph_compact_point_to_string(pt : DsgraphcompactPoint) -> String {
  "(" + ds_graph_compact_dbl(pt.x) + ", " + ds_graph_compact_dbl(pt.y) + ", " + ds_graph_compact_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DsgraphcompactSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_graph_compact_make_series(vals : Array[Double], name : String) -> DsgraphcompactSeries {
  { vals, name, meta: 0 }
}

pub fn ds_graph_compact_series_len(s : DsgraphcompactSeries) -> Int { s.vals.length() }

pub fn ds_graph_compact_series_sum(s : DsgraphcompactSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn ds_graph_compact_series_mean(s : DsgraphcompactSeries) -> Double {
  let n = ds_graph_compact_series_len(s)
  if n == 0 { 0.0 } else { ds_graph_compact_series_sum(s) / n.to_double() }
}

pub fn ds_graph_compact_series_min(s : DsgraphcompactSeries) -> Double {
  let n = ds_graph_compact_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn ds_graph_compact_series_max(s : DsgraphcompactSeries) -> Double {
  let n = ds_graph_compact_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn ds_graph_compact_series_range(s : DsgraphcompactSeries) -> Double {
  ds_graph_compact_series_max(s) - ds_graph_compact_series_min(s)
}

pub fn ds_graph_compact_series_var(s : DsgraphcompactSeries) -> Double {
  let n = ds_graph_compact_series_len(s)
  if n == 0 { 0.0 } else {
    let m = ds_graph_compact_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn ds_graph_compact_series_std(s : DsgraphcompactSeries) -> Double { ds_graph_compact_sqrt(ds_graph_compact_series_var(s)) }

pub fn ds_graph_compact_series_median(s : DsgraphcompactSeries) -> Double {
  let n = ds_graph_compact_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = ds_graph_compact_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ds_graph_compact_series_scale(s : DsgraphcompactSeries, f : Double) -> DsgraphcompactSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = ds_graph_compact_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ds_graph_compact_series_add(a : DsgraphcompactSeries, b : DsgraphcompactSeries) -> DsgraphcompactSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = ds_graph_compact_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ds_graph_compact_series_sub(a : DsgraphcompactSeries, b : DsgraphcompactSeries) -> DsgraphcompactSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = ds_graph_compact_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ds_graph_compact_series_normalize(s : DsgraphcompactSeries) -> DsgraphcompactSeries {
  let mn = ds_graph_compact_series_min(s)
  let mx = ds_graph_compact_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = ds_graph_compact_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ds_graph_compact_series_cumsum(s : DsgraphcompactSeries) -> DsgraphcompactSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = ds_graph_compact_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn ds_graph_compact_series_to_string(s : DsgraphcompactSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + ds_graph_compact_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DsgraphcompactMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_graph_compact_make_matrix(rows : Int, cols : Int, val : Double) -> DsgraphcompactMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_graph_compact_matrix_identity(n : Int) -> DsgraphcompactMatrix {
  let m = ds_graph_compact_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ds_graph_compact_matrix_get(m : DsgraphcompactMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ds_graph_compact_matrix_transpose(m : DsgraphcompactMatrix) -> DsgraphcompactMatrix {
  let result = ds_graph_compact_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ds_graph_compact_matrix_add(a : DsgraphcompactMatrix, b : DsgraphcompactMatrix) -> DsgraphcompactMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ds_graph_compact_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ds_graph_compact_matrix_scale(m : DsgraphcompactMatrix, s : Double) -> DsgraphcompactMatrix {
  let result = ds_graph_compact_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ds_graph_compact_matrix_multiply(a : DsgraphcompactMatrix, b : DsgraphcompactMatrix) -> DsgraphcompactMatrix {
  if a.cols != b.rows { return ds_graph_compact_make_matrix(a.rows, b.cols, 0.0) }
  let result = ds_graph_compact_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ds_graph_compact_matrix_trace(m : DsgraphcompactMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ds_graph_compact_matrix_det(m : DsgraphcompactMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ds_graph_compact_matrix_norm(m : DsgraphcompactMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  ds_graph_compact_sqrt(sum)
}

pub fn ds_graph_compact_matrix_to_string(m : DsgraphcompactMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + ds_graph_compact_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct DsgraphcompactVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_graph_compact_make_vector(comps : Array[Double]) -> DsgraphcompactVector {
  { comps, dim: comps.length() }
}

pub fn ds_graph_compact_vector_zero(dim : Int) -> DsgraphcompactVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ds_graph_compact_vector_add(a : DsgraphcompactVector, b : DsgraphcompactVector) -> DsgraphcompactVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = ds_graph_compact_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_graph_compact_vector_sub(a : DsgraphcompactVector, b : DsgraphcompactVector) -> DsgraphcompactVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = ds_graph_compact_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_graph_compact_vector_scale(v : DsgraphcompactVector, s : Double) -> DsgraphcompactVector {
  let mut result = []
  for i in 0..<v.dim { result = ds_graph_compact_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ds_graph_compact_vector_dot(a : DsgraphcompactVector, b : DsgraphcompactVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ds_graph_compact_vector_norm(v : DsgraphcompactVector) -> Double { ds_graph_compact_sqrt(ds_graph_compact_vector_dot(v, v)) }

pub fn ds_graph_compact_vector_normalize(v : DsgraphcompactVector) -> DsgraphcompactVector {
  let n = ds_graph_compact_vector_norm(v)
  if n < 0.0000001 { v } else { ds_graph_compact_vector_scale(v, 1.0 / n) }
}

pub fn ds_graph_compact_vector_dist(a : DsgraphcompactVector, b : DsgraphcompactVector) -> Double {
  ds_graph_compact_vector_norm(ds_graph_compact_vector_sub(a, b))
}

pub fn ds_graph_compact_vector_to_string(v : DsgraphcompactVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + ds_graph_compact_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_graph_compact_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn ds_graph_compact_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = ds_graph_compact_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ds_graph_compact_std(data : Array[Double]) -> Double { ds_graph_compact_sqrt(ds_graph_compact_var(data)) }

pub fn ds_graph_compact_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = ds_graph_compact_mean(a); let mb = ds_graph_compact_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn ds_graph_compact_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = ds_graph_compact_std(a); let sb = ds_graph_compact_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { ds_graph_compact_cov(a, b) / (sa * sb) }
}

pub fn ds_graph_compact_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = ds_graph_compact_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ds_graph_compact_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn ds_graph_compact_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ds_graph_compact_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  ds_graph_compact_sqrt(ds_graph_compact_mse(pred, labels))
}

pub fn ds_graph_compact_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + ds_graph_compact_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn ds_graph_compact_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = ds_graph_compact_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn ds_graph_compact_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn ds_graph_compact_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn ds_graph_compact_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = ds_graph_compact_precision(pred, labels, pos); let r = ds_graph_compact_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn ds_graph_compact_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn ds_graph_compact_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = ds_graph_compact_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn ds_graph_compact_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn ds_graph_compact_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn ds_graph_compact_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = ds_graph_compact_gcd(a, b)
    (a / g) * b
  }
}

pub fn ds_graph_compact_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn ds_graph_compact_fibonacci(n : Int) -> Int {
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

pub fn ds_graph_compact_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = ds_graph_compact_min(data); let mx = ds_graph_compact_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn ds_graph_compact_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = ds_graph_compact_mean(data); let sd = ds_graph_compact_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn ds_graph_compact_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn ds_graph_compact_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn ds_graph_compact_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn ds_graph_compact_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn ds_graph_compact_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn ds_graph_compact_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn ds_graph_compact_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn ds_graph_compact_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn ds_graph_compact_dbl(x : Double) -> String {
  let i = if x >= 0.0 { ds_graph_compact_int(x) } else { -ds_graph_compact_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { ds_graph_compact_int(f * 1000000.0) } else { ds_graph_compact_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn ds_graph_compact_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn ds_graph_compact_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct DsgraphcompactFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_compact_frame_make(size : Int) -> DsgraphcompactFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_compact_frame_len(s : DsgraphcompactFrame) -> Int { s.size }

pub fn ds_graph_compact_frame_get(s : DsgraphcompactFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_compact_frame_set(s : DsgraphcompactFrame, i : Int, v : Double) -> DsgraphcompactFrame {
  let result = ds_graph_compact_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_compact_frame_sum(s : DsgraphcompactFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_compact_frame_mean(s : DsgraphcompactFrame) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_compact_frame_sum(s) / s.size.to_double() }
}

pub fn ds_graph_compact_frame_scale(s : DsgraphcompactFrame, f : Double) -> DsgraphcompactFrame {
  let result = ds_graph_compact_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_compact_frame_add(a : DsgraphcompactFrame, b : DsgraphcompactFrame) -> DsgraphcompactFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_compact_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_compact_frame_copy(s : DsgraphcompactFrame) -> DsgraphcompactFrame {
  let result = ds_graph_compact_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_compact_frame_fill(s : DsgraphcompactFrame, v : Double) -> DsgraphcompactFrame {
  let result = ds_graph_compact_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_compact_frame_min(s : DsgraphcompactFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_compact_frame_max(s : DsgraphcompactFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_compact_frame_to_string(s : DsgraphcompactFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphcompactTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_compact_table_make(size : Int) -> DsgraphcompactTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_compact_table_len(s : DsgraphcompactTable) -> Int { s.size }

pub fn ds_graph_compact_table_get(s : DsgraphcompactTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_compact_table_set(s : DsgraphcompactTable, i : Int, v : Double) -> DsgraphcompactTable {
  let result = ds_graph_compact_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_compact_table_sum(s : DsgraphcompactTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_compact_table_mean(s : DsgraphcompactTable) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_compact_table_sum(s) / s.size.to_double() }
}

pub fn ds_graph_compact_table_scale(s : DsgraphcompactTable, f : Double) -> DsgraphcompactTable {
  let result = ds_graph_compact_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_compact_table_add(a : DsgraphcompactTable, b : DsgraphcompactTable) -> DsgraphcompactTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_compact_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_compact_table_copy(s : DsgraphcompactTable) -> DsgraphcompactTable {
  let result = ds_graph_compact_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_compact_table_fill(s : DsgraphcompactTable, v : Double) -> DsgraphcompactTable {
  let result = ds_graph_compact_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_compact_table_min(s : DsgraphcompactTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_compact_table_max(s : DsgraphcompactTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_compact_table_to_string(s : DsgraphcompactTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphcompactGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_compact_graphn_make(size : Int) -> DsgraphcompactGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_compact_graphn_len(s : DsgraphcompactGraphN) -> Int { s.size }

pub fn ds_graph_compact_graphn_get(s : DsgraphcompactGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_compact_graphn_set(s : DsgraphcompactGraphN, i : Int, v : Double) -> DsgraphcompactGraphN {
  let result = ds_graph_compact_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_compact_graphn_sum(s : DsgraphcompactGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_compact_graphn_mean(s : DsgraphcompactGraphN) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_compact_graphn_sum(s) / s.size.to_double() }
}

pub fn ds_graph_compact_graphn_scale(s : DsgraphcompactGraphN, f : Double) -> DsgraphcompactGraphN {
  let result = ds_graph_compact_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_compact_graphn_add(a : DsgraphcompactGraphN, b : DsgraphcompactGraphN) -> DsgraphcompactGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_compact_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_compact_graphn_copy(s : DsgraphcompactGraphN) -> DsgraphcompactGraphN {
  let result = ds_graph_compact_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_compact_graphn_fill(s : DsgraphcompactGraphN, v : Double) -> DsgraphcompactGraphN {
  let result = ds_graph_compact_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_compact_graphn_min(s : DsgraphcompactGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_compact_graphn_max(s : DsgraphcompactGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_compact_graphn_to_string(s : DsgraphcompactGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphcompactNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_compact_node_make(size : Int) -> DsgraphcompactNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_compact_node_len(s : DsgraphcompactNode) -> Int { s.size }

pub fn ds_graph_compact_node_get(s : DsgraphcompactNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_compact_node_set(s : DsgraphcompactNode, i : Int, v : Double) -> DsgraphcompactNode {
  let result = ds_graph_compact_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_compact_node_sum(s : DsgraphcompactNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_compact_node_mean(s : DsgraphcompactNode) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_compact_node_sum(s) / s.size.to_double() }
}

pub fn ds_graph_compact_node_scale(s : DsgraphcompactNode, f : Double) -> DsgraphcompactNode {
  let result = ds_graph_compact_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_compact_node_add(a : DsgraphcompactNode, b : DsgraphcompactNode) -> DsgraphcompactNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_compact_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_compact_node_copy(s : DsgraphcompactNode) -> DsgraphcompactNode {
  let result = ds_graph_compact_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_compact_node_fill(s : DsgraphcompactNode, v : Double) -> DsgraphcompactNode {
  let result = ds_graph_compact_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_compact_node_min(s : DsgraphcompactNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_compact_node_max(s : DsgraphcompactNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_compact_node_to_string(s : DsgraphcompactNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphcompactEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_compact_edge_make(size : Int) -> DsgraphcompactEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_compact_edge_len(s : DsgraphcompactEdge) -> Int { s.size }

pub fn ds_graph_compact_edge_get(s : DsgraphcompactEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_compact_edge_set(s : DsgraphcompactEdge, i : Int, v : Double) -> DsgraphcompactEdge {
  let result = ds_graph_compact_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_compact_edge_sum(s : DsgraphcompactEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_compact_edge_mean(s : DsgraphcompactEdge) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_compact_edge_sum(s) / s.size.to_double() }
}

pub fn ds_graph_compact_edge_scale(s : DsgraphcompactEdge, f : Double) -> DsgraphcompactEdge {
  let result = ds_graph_compact_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_compact_edge_add(a : DsgraphcompactEdge, b : DsgraphcompactEdge) -> DsgraphcompactEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_compact_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_compact_edge_copy(s : DsgraphcompactEdge) -> DsgraphcompactEdge {
  let result = ds_graph_compact_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_compact_edge_fill(s : DsgraphcompactEdge, v : Double) -> DsgraphcompactEdge {
  let result = ds_graph_compact_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_compact_edge_min(s : DsgraphcompactEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_compact_edge_max(s : DsgraphcompactEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_compact_edge_to_string(s : DsgraphcompactEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphcompactPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_compact_path_make(size : Int) -> DsgraphcompactPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_compact_path_len(s : DsgraphcompactPath) -> Int { s.size }

pub fn ds_graph_compact_path_get(s : DsgraphcompactPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_compact_path_set(s : DsgraphcompactPath, i : Int, v : Double) -> DsgraphcompactPath {
  let result = ds_graph_compact_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_compact_path_sum(s : DsgraphcompactPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_compact_path_mean(s : DsgraphcompactPath) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_compact_path_sum(s) / s.size.to_double() }
}

pub fn ds_graph_compact_path_scale(s : DsgraphcompactPath, f : Double) -> DsgraphcompactPath {
  let result = ds_graph_compact_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_compact_path_add(a : DsgraphcompactPath, b : DsgraphcompactPath) -> DsgraphcompactPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_compact_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_compact_path_copy(s : DsgraphcompactPath) -> DsgraphcompactPath {
  let result = ds_graph_compact_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_compact_path_fill(s : DsgraphcompactPath, v : Double) -> DsgraphcompactPath {
  let result = ds_graph_compact_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_compact_path_min(s : DsgraphcompactPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_compact_path_max(s : DsgraphcompactPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_compact_path_to_string(s : DsgraphcompactPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphcompactCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_compact_cluster_make(size : Int) -> DsgraphcompactCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_compact_cluster_len(s : DsgraphcompactCluster) -> Int { s.size }

pub fn ds_graph_compact_cluster_get(s : DsgraphcompactCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_compact_cluster_set(s : DsgraphcompactCluster, i : Int, v : Double) -> DsgraphcompactCluster {
  let result = ds_graph_compact_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_compact_cluster_sum(s : DsgraphcompactCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_compact_cluster_mean(s : DsgraphcompactCluster) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_compact_cluster_sum(s) / s.size.to_double() }
}

pub fn ds_graph_compact_cluster_scale(s : DsgraphcompactCluster, f : Double) -> DsgraphcompactCluster {
  let result = ds_graph_compact_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_compact_cluster_add(a : DsgraphcompactCluster, b : DsgraphcompactCluster) -> DsgraphcompactCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_compact_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_compact_cluster_copy(s : DsgraphcompactCluster) -> DsgraphcompactCluster {
  let result = ds_graph_compact_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_compact_cluster_fill(s : DsgraphcompactCluster, v : Double) -> DsgraphcompactCluster {
  let result = ds_graph_compact_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_compact_cluster_min(s : DsgraphcompactCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_compact_cluster_max(s : DsgraphcompactCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_compact_cluster_to_string(s : DsgraphcompactCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphcompactModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_compact_model_make(size : Int) -> DsgraphcompactModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_compact_model_len(s : DsgraphcompactModel) -> Int { s.size }

pub fn ds_graph_compact_model_get(s : DsgraphcompactModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_compact_model_set(s : DsgraphcompactModel, i : Int, v : Double) -> DsgraphcompactModel {
  let result = ds_graph_compact_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_compact_model_sum(s : DsgraphcompactModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_compact_model_mean(s : DsgraphcompactModel) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_compact_model_sum(s) / s.size.to_double() }
}

pub fn ds_graph_compact_model_scale(s : DsgraphcompactModel, f : Double) -> DsgraphcompactModel {
  let result = ds_graph_compact_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_compact_model_add(a : DsgraphcompactModel, b : DsgraphcompactModel) -> DsgraphcompactModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_compact_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_compact_model_copy(s : DsgraphcompactModel) -> DsgraphcompactModel {
  let result = ds_graph_compact_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_compact_model_fill(s : DsgraphcompactModel, v : Double) -> DsgraphcompactModel {
  let result = ds_graph_compact_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_compact_model_min(s : DsgraphcompactModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_compact_model_max(s : DsgraphcompactModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_compact_model_to_string(s : DsgraphcompactModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphcompactLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_compact_layer_make(size : Int) -> DsgraphcompactLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_compact_layer_len(s : DsgraphcompactLayer) -> Int { s.size }

pub fn ds_graph_compact_layer_get(s : DsgraphcompactLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_compact_layer_set(s : DsgraphcompactLayer, i : Int, v : Double) -> DsgraphcompactLayer {
  let result = ds_graph_compact_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_compact_layer_sum(s : DsgraphcompactLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_compact_layer_mean(s : DsgraphcompactLayer) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_compact_layer_sum(s) / s.size.to_double() }
}

pub fn ds_graph_compact_layer_scale(s : DsgraphcompactLayer, f : Double) -> DsgraphcompactLayer {
  let result = ds_graph_compact_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_compact_layer_add(a : DsgraphcompactLayer, b : DsgraphcompactLayer) -> DsgraphcompactLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_compact_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_compact_layer_copy(s : DsgraphcompactLayer) -> DsgraphcompactLayer {
  let result = ds_graph_compact_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_compact_layer_fill(s : DsgraphcompactLayer, v : Double) -> DsgraphcompactLayer {
  let result = ds_graph_compact_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_compact_layer_min(s : DsgraphcompactLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_compact_layer_max(s : DsgraphcompactLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_compact_layer_to_string(s : DsgraphcompactLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphcompactBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_compact_buffer_make(size : Int) -> DsgraphcompactBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_compact_buffer_len(s : DsgraphcompactBuffer) -> Int { s.size }

pub fn ds_graph_compact_buffer_get(s : DsgraphcompactBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_compact_buffer_set(s : DsgraphcompactBuffer, i : Int, v : Double) -> DsgraphcompactBuffer {
  let result = ds_graph_compact_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_compact_buffer_sum(s : DsgraphcompactBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_compact_buffer_mean(s : DsgraphcompactBuffer) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_compact_buffer_sum(s) / s.size.to_double() }
}

pub fn ds_graph_compact_buffer_scale(s : DsgraphcompactBuffer, f : Double) -> DsgraphcompactBuffer {
  let result = ds_graph_compact_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_compact_buffer_add(a : DsgraphcompactBuffer, b : DsgraphcompactBuffer) -> DsgraphcompactBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_compact_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_compact_buffer_copy(s : DsgraphcompactBuffer) -> DsgraphcompactBuffer {
  let result = ds_graph_compact_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_compact_buffer_fill(s : DsgraphcompactBuffer, v : Double) -> DsgraphcompactBuffer {
  let result = ds_graph_compact_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_compact_buffer_min(s : DsgraphcompactBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_compact_buffer_max(s : DsgraphcompactBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_compact_buffer_to_string(s : DsgraphcompactBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphcompactCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_compact_cursor_make(size : Int) -> DsgraphcompactCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_compact_cursor_len(s : DsgraphcompactCursor) -> Int { s.size }

pub fn ds_graph_compact_cursor_get(s : DsgraphcompactCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_compact_cursor_set(s : DsgraphcompactCursor, i : Int, v : Double) -> DsgraphcompactCursor {
  let result = ds_graph_compact_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_compact_cursor_sum(s : DsgraphcompactCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_compact_cursor_mean(s : DsgraphcompactCursor) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_compact_cursor_sum(s) / s.size.to_double() }
}

pub fn ds_graph_compact_cursor_scale(s : DsgraphcompactCursor, f : Double) -> DsgraphcompactCursor {
  let result = ds_graph_compact_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_compact_cursor_add(a : DsgraphcompactCursor, b : DsgraphcompactCursor) -> DsgraphcompactCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_compact_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_compact_cursor_copy(s : DsgraphcompactCursor) -> DsgraphcompactCursor {
  let result = ds_graph_compact_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_compact_cursor_fill(s : DsgraphcompactCursor, v : Double) -> DsgraphcompactCursor {
  let result = ds_graph_compact_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_compact_cursor_min(s : DsgraphcompactCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_compact_cursor_max(s : DsgraphcompactCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_compact_cursor_to_string(s : DsgraphcompactCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphcompactView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_compact_view_make(size : Int) -> DsgraphcompactView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_compact_view_len(s : DsgraphcompactView) -> Int { s.size }

pub fn ds_graph_compact_view_get(s : DsgraphcompactView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_compact_view_set(s : DsgraphcompactView, i : Int, v : Double) -> DsgraphcompactView {
  let result = ds_graph_compact_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_compact_view_sum(s : DsgraphcompactView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_compact_view_mean(s : DsgraphcompactView) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_compact_view_sum(s) / s.size.to_double() }
}

pub fn ds_graph_compact_view_scale(s : DsgraphcompactView, f : Double) -> DsgraphcompactView {
  let result = ds_graph_compact_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_compact_view_add(a : DsgraphcompactView, b : DsgraphcompactView) -> DsgraphcompactView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_compact_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_compact_view_copy(s : DsgraphcompactView) -> DsgraphcompactView {
  let result = ds_graph_compact_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_compact_view_fill(s : DsgraphcompactView, v : Double) -> DsgraphcompactView {
  let result = ds_graph_compact_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_compact_view_min(s : DsgraphcompactView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_compact_view_max(s : DsgraphcompactView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_compact_view_to_string(s : DsgraphcompactView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphcompactRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_compact_range_make(size : Int) -> DsgraphcompactRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_compact_range_len(s : DsgraphcompactRange) -> Int { s.size }

pub fn ds_graph_compact_range_get(s : DsgraphcompactRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_compact_range_set(s : DsgraphcompactRange, i : Int, v : Double) -> DsgraphcompactRange {
  let result = ds_graph_compact_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_compact_range_sum(s : DsgraphcompactRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_compact_range_mean(s : DsgraphcompactRange) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_compact_range_sum(s) / s.size.to_double() }
}

pub fn ds_graph_compact_range_scale(s : DsgraphcompactRange, f : Double) -> DsgraphcompactRange {
  let result = ds_graph_compact_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_compact_range_add(a : DsgraphcompactRange, b : DsgraphcompactRange) -> DsgraphcompactRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_compact_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_compact_range_copy(s : DsgraphcompactRange) -> DsgraphcompactRange {
  let result = ds_graph_compact_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_compact_range_fill(s : DsgraphcompactRange, v : Double) -> DsgraphcompactRange {
  let result = ds_graph_compact_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_compact_range_min(s : DsgraphcompactRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_compact_range_max(s : DsgraphcompactRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_compact_range_to_string(s : DsgraphcompactRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphcompactSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_compact_slice_make(size : Int) -> DsgraphcompactSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_compact_slice_len(s : DsgraphcompactSlice) -> Int { s.size }

pub fn ds_graph_compact_slice_get(s : DsgraphcompactSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_compact_slice_set(s : DsgraphcompactSlice, i : Int, v : Double) -> DsgraphcompactSlice {
  let result = ds_graph_compact_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_compact_slice_sum(s : DsgraphcompactSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_compact_slice_mean(s : DsgraphcompactSlice) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_compact_slice_sum(s) / s.size.to_double() }
}

pub fn ds_graph_compact_slice_scale(s : DsgraphcompactSlice, f : Double) -> DsgraphcompactSlice {
  let result = ds_graph_compact_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_compact_slice_add(a : DsgraphcompactSlice, b : DsgraphcompactSlice) -> DsgraphcompactSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_compact_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_compact_slice_copy(s : DsgraphcompactSlice) -> DsgraphcompactSlice {
  let result = ds_graph_compact_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_compact_slice_fill(s : DsgraphcompactSlice, v : Double) -> DsgraphcompactSlice {
  let result = ds_graph_compact_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_compact_slice_min(s : DsgraphcompactSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_compact_slice_max(s : DsgraphcompactSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_compact_slice_to_string(s : DsgraphcompactSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn ds_graph_compact_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_graph_compact_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_graph_compact_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_graph_compact_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_graph_compact_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_graph_compact_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_graph_compact_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_graph_compact_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_graph_compact_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_graph_compact_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_graph_compact_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_graph_compact_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_graph_compact_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_graph_compact_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_graph_compact_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_graph_compact_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_graph_compact_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_graph_compact_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_graph_compact_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_graph_compact_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_graph_compact_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_graph_compact_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_graph_compact_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_graph_compact_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_graph_compact_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}


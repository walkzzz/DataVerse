///===
/// extcore/timeseries_decomp_classical

pub(all) struct TimeseriesdecompclassicalPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_decomp_classical_make_point(x : Double, y : Double) -> TimeseriesdecompclassicalPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_decomp_classical_make_point3(x : Double, y : Double, z : Double) -> TimeseriesdecompclassicalPoint {
  { x, y, z, label: 0 }
}

pub fn timeseries_decomp_classical_point_x(pt : TimeseriesdecompclassicalPoint) -> Double { pt.x }

pub fn timeseries_decomp_classical_point_y(pt : TimeseriesdecompclassicalPoint) -> Double { pt.y }

pub fn timeseries_decomp_classical_point_z(pt : TimeseriesdecompclassicalPoint) -> Double { pt.z }

pub fn timeseries_decomp_classical_point_label(pt : TimeseriesdecompclassicalPoint) -> Int { pt.label }

pub fn timeseries_decomp_classical_point_dist(a : TimeseriesdecompclassicalPoint, b : TimeseriesdecompclassicalPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn timeseries_decomp_classical_point_add(a : TimeseriesdecompclassicalPoint, b : TimeseriesdecompclassicalPoint) -> TimeseriesdecompclassicalPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn timeseries_decomp_classical_point_sub(a : TimeseriesdecompclassicalPoint, b : TimeseriesdecompclassicalPoint) -> TimeseriesdecompclassicalPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn timeseries_decomp_classical_point_scale(pt : TimeseriesdecompclassicalPoint, s : Double) -> TimeseriesdecompclassicalPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn timeseries_decomp_classical_point_dot(a : TimeseriesdecompclassicalPoint, b : TimeseriesdecompclassicalPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn timeseries_decomp_classical_point_cross(a : TimeseriesdecompclassicalPoint, b : TimeseriesdecompclassicalPoint) -> TimeseriesdecompclassicalPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn timeseries_decomp_classical_point_norm(pt : TimeseriesdecompclassicalPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn timeseries_decomp_classical_point_normalize(pt : TimeseriesdecompclassicalPoint) -> TimeseriesdecompclassicalPoint {
  let n = timeseries_decomp_classical_point_norm(pt)
  if n < 0.0000001 { pt } else { timeseries_decomp_classical_point_scale(pt, 1.0 / n) }
}

pub fn timeseries_decomp_classical_point_negate(pt : TimeseriesdecompclassicalPoint) -> TimeseriesdecompclassicalPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn timeseries_decomp_classical_point_mid(a : TimeseriesdecompclassicalPoint, b : TimeseriesdecompclassicalPoint) -> TimeseriesdecompclassicalPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn timeseries_decomp_classical_point_lerp(a : TimeseriesdecompclassicalPoint, b : TimeseriesdecompclassicalPoint, t : Double) -> TimeseriesdecompclassicalPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn timeseries_decomp_classical_point_to_string(pt : TimeseriesdecompclassicalPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct TimeseriesdecompclassicalSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_decomp_classical_make_series(vals : Array[Double], name : String) -> TimeseriesdecompclassicalSeries {
  { vals, name, meta: 0 }
}

pub fn timeseries_decomp_classical_series_len(s : TimeseriesdecompclassicalSeries) -> Int { s.vals.length() }

pub fn timeseries_decomp_classical_series_sum(s : TimeseriesdecompclassicalSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn timeseries_decomp_classical_series_mean(s : TimeseriesdecompclassicalSeries) -> Double {
  let n = timeseries_decomp_classical_series_len(s)
  if n == 0 { 0.0 } else { timeseries_decomp_classical_series_sum(s) / n.to_double() }
}

pub fn timeseries_decomp_classical_series_min(s : TimeseriesdecompclassicalSeries) -> Double {
  let n = timeseries_decomp_classical_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn timeseries_decomp_classical_series_max(s : TimeseriesdecompclassicalSeries) -> Double {
  let n = timeseries_decomp_classical_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn timeseries_decomp_classical_series_range(s : TimeseriesdecompclassicalSeries) -> Double {
  timeseries_decomp_classical_series_max(s) - timeseries_decomp_classical_series_min(s)
}

pub fn timeseries_decomp_classical_series_var(s : TimeseriesdecompclassicalSeries) -> Double {
  let n = timeseries_decomp_classical_series_len(s)
  if n == 0 { 0.0 } else {
    let m = timeseries_decomp_classical_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn timeseries_decomp_classical_series_std(s : TimeseriesdecompclassicalSeries) -> Double { @_common.sqrt(timeseries_decomp_classical_series_var(s)) }

pub fn timeseries_decomp_classical_series_median(s : TimeseriesdecompclassicalSeries) -> Double {
  let n = timeseries_decomp_classical_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = timeseries_decomp_classical_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn timeseries_decomp_classical_series_scale(s : TimeseriesdecompclassicalSeries, f : Double) -> TimeseriesdecompclassicalSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn timeseries_decomp_classical_series_add(a : TimeseriesdecompclassicalSeries, b : TimeseriesdecompclassicalSeries) -> TimeseriesdecompclassicalSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn timeseries_decomp_classical_series_sub(a : TimeseriesdecompclassicalSeries, b : TimeseriesdecompclassicalSeries) -> TimeseriesdecompclassicalSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn timeseries_decomp_classical_series_normalize(s : TimeseriesdecompclassicalSeries) -> TimeseriesdecompclassicalSeries {
  let mn = timeseries_decomp_classical_series_min(s)
  let mx = timeseries_decomp_classical_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn timeseries_decomp_classical_series_cumsum(s : TimeseriesdecompclassicalSeries) -> TimeseriesdecompclassicalSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn timeseries_decomp_classical_series_to_string(s : TimeseriesdecompclassicalSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesdecompclassicalMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_decomp_classical_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriesdecompclassicalMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn timeseries_decomp_classical_matrix_identity(n : Int) -> TimeseriesdecompclassicalMatrix {
  let m = timeseries_decomp_classical_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn timeseries_decomp_classical_matrix_get(m : TimeseriesdecompclassicalMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn timeseries_decomp_classical_matrix_transpose(m : TimeseriesdecompclassicalMatrix) -> TimeseriesdecompclassicalMatrix {
  let result = timeseries_decomp_classical_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn timeseries_decomp_classical_matrix_add(a : TimeseriesdecompclassicalMatrix, b : TimeseriesdecompclassicalMatrix) -> TimeseriesdecompclassicalMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = timeseries_decomp_classical_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn timeseries_decomp_classical_matrix_scale(m : TimeseriesdecompclassicalMatrix, s : Double) -> TimeseriesdecompclassicalMatrix {
  let result = timeseries_decomp_classical_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn timeseries_decomp_classical_matrix_multiply(a : TimeseriesdecompclassicalMatrix, b : TimeseriesdecompclassicalMatrix) -> TimeseriesdecompclassicalMatrix {
  if a.cols != b.rows { return timeseries_decomp_classical_make_matrix(a.rows, b.cols, 0.0) }
  let result = timeseries_decomp_classical_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn timeseries_decomp_classical_matrix_trace(m : TimeseriesdecompclassicalMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn timeseries_decomp_classical_matrix_det(m : TimeseriesdecompclassicalMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn timeseries_decomp_classical_matrix_norm(m : TimeseriesdecompclassicalMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn timeseries_decomp_classical_matrix_to_string(m : TimeseriesdecompclassicalMatrix) -> String {
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

pub(all) struct TimeseriesdecompclassicalVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_decomp_classical_make_vector(comps : Array[Double]) -> TimeseriesdecompclassicalVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_decomp_classical_vector_zero(dim : Int) -> TimeseriesdecompclassicalVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn timeseries_decomp_classical_vector_add(a : TimeseriesdecompclassicalVector, b : TimeseriesdecompclassicalVector) -> TimeseriesdecompclassicalVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn timeseries_decomp_classical_vector_sub(a : TimeseriesdecompclassicalVector, b : TimeseriesdecompclassicalVector) -> TimeseriesdecompclassicalVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn timeseries_decomp_classical_vector_scale(v : TimeseriesdecompclassicalVector, s : Double) -> TimeseriesdecompclassicalVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn timeseries_decomp_classical_vector_dot(a : TimeseriesdecompclassicalVector, b : TimeseriesdecompclassicalVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn timeseries_decomp_classical_vector_norm(v : TimeseriesdecompclassicalVector) -> Double { @_common.sqrt(timeseries_decomp_classical_vector_dot(v, v)) }

pub fn timeseries_decomp_classical_vector_normalize(v : TimeseriesdecompclassicalVector) -> TimeseriesdecompclassicalVector {
  let n = timeseries_decomp_classical_vector_norm(v)
  if n < 0.0000001 { v } else { timeseries_decomp_classical_vector_scale(v, 1.0 / n) }
}

pub fn timeseries_decomp_classical_vector_dist(a : TimeseriesdecompclassicalVector, b : TimeseriesdecompclassicalVector) -> Double {
  timeseries_decomp_classical_vector_norm(timeseries_decomp_classical_vector_sub(a, b))
}

pub fn timeseries_decomp_classical_vector_to_string(v : TimeseriesdecompclassicalVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn timeseries_decomp_classical_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn timeseries_decomp_classical_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = timeseries_decomp_classical_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn timeseries_decomp_classical_std(data : Array[Double]) -> Double { @_common.sqrt(timeseries_decomp_classical_var(data)) }

pub fn timeseries_decomp_classical_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = timeseries_decomp_classical_mean(a); let mb = timeseries_decomp_classical_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn timeseries_decomp_classical_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = timeseries_decomp_classical_std(a); let sb = timeseries_decomp_classical_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { timeseries_decomp_classical_cov(a, b) / (sa * sb) }
}

pub fn timeseries_decomp_classical_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = timeseries_decomp_classical_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn timeseries_decomp_classical_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn timeseries_decomp_classical_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn timeseries_decomp_classical_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(timeseries_decomp_classical_mse(pred, labels))
}

pub fn timeseries_decomp_classical_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn timeseries_decomp_classical_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = timeseries_decomp_classical_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn timeseries_decomp_classical_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn timeseries_decomp_classical_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn timeseries_decomp_classical_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = timeseries_decomp_classical_precision(pred, labels, pos); let r = timeseries_decomp_classical_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn timeseries_decomp_classical_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn timeseries_decomp_classical_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = timeseries_decomp_classical_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn timeseries_decomp_classical_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn timeseries_decomp_classical_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn timeseries_decomp_classical_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = timeseries_decomp_classical_gcd(a, b)
    (a / g) * b
  }
}

pub fn timeseries_decomp_classical_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn timeseries_decomp_classical_fibonacci(n : Int) -> Int {
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

pub fn timeseries_decomp_classical_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = timeseries_decomp_classical_min(data); let mx = timeseries_decomp_classical_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn timeseries_decomp_classical_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = timeseries_decomp_classical_mean(data); let sd = timeseries_decomp_classical_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn timeseries_decomp_classical_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn timeseries_decomp_classical_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn timeseries_decomp_classical_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn timeseries_decomp_classical_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn timeseries_decomp_classical_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn timeseries_decomp_classical_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct TimeseriesdecompclassicalFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_classical_frame_make(size : Int) -> TimeseriesdecompclassicalFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_classical_frame_len(s : TimeseriesdecompclassicalFrame) -> Int { s.size }

pub fn timeseries_decomp_classical_frame_get(s : TimeseriesdecompclassicalFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_classical_frame_set(s : TimeseriesdecompclassicalFrame, i : Int, v : Double) -> TimeseriesdecompclassicalFrame {
  let result = timeseries_decomp_classical_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_classical_frame_sum(s : TimeseriesdecompclassicalFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_classical_frame_mean(s : TimeseriesdecompclassicalFrame) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_classical_frame_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_classical_frame_scale(s : TimeseriesdecompclassicalFrame, f : Double) -> TimeseriesdecompclassicalFrame {
  let result = timeseries_decomp_classical_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_classical_frame_add(a : TimeseriesdecompclassicalFrame, b : TimeseriesdecompclassicalFrame) -> TimeseriesdecompclassicalFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_classical_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_classical_frame_copy(s : TimeseriesdecompclassicalFrame) -> TimeseriesdecompclassicalFrame {
  let result = timeseries_decomp_classical_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_classical_frame_fill(s : TimeseriesdecompclassicalFrame, v : Double) -> TimeseriesdecompclassicalFrame {
  let result = timeseries_decomp_classical_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_classical_frame_min(s : TimeseriesdecompclassicalFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_classical_frame_max(s : TimeseriesdecompclassicalFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_classical_frame_to_string(s : TimeseriesdecompclassicalFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompclassicalTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_classical_table_make(size : Int) -> TimeseriesdecompclassicalTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_classical_table_len(s : TimeseriesdecompclassicalTable) -> Int { s.size }

pub fn timeseries_decomp_classical_table_get(s : TimeseriesdecompclassicalTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_classical_table_set(s : TimeseriesdecompclassicalTable, i : Int, v : Double) -> TimeseriesdecompclassicalTable {
  let result = timeseries_decomp_classical_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_classical_table_sum(s : TimeseriesdecompclassicalTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_classical_table_mean(s : TimeseriesdecompclassicalTable) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_classical_table_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_classical_table_scale(s : TimeseriesdecompclassicalTable, f : Double) -> TimeseriesdecompclassicalTable {
  let result = timeseries_decomp_classical_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_classical_table_add(a : TimeseriesdecompclassicalTable, b : TimeseriesdecompclassicalTable) -> TimeseriesdecompclassicalTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_classical_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_classical_table_copy(s : TimeseriesdecompclassicalTable) -> TimeseriesdecompclassicalTable {
  let result = timeseries_decomp_classical_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_classical_table_fill(s : TimeseriesdecompclassicalTable, v : Double) -> TimeseriesdecompclassicalTable {
  let result = timeseries_decomp_classical_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_classical_table_min(s : TimeseriesdecompclassicalTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_classical_table_max(s : TimeseriesdecompclassicalTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_classical_table_to_string(s : TimeseriesdecompclassicalTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompclassicalGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_classical_graphn_make(size : Int) -> TimeseriesdecompclassicalGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_classical_graphn_len(s : TimeseriesdecompclassicalGraphN) -> Int { s.size }

pub fn timeseries_decomp_classical_graphn_get(s : TimeseriesdecompclassicalGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_classical_graphn_set(s : TimeseriesdecompclassicalGraphN, i : Int, v : Double) -> TimeseriesdecompclassicalGraphN {
  let result = timeseries_decomp_classical_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_classical_graphn_sum(s : TimeseriesdecompclassicalGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_classical_graphn_mean(s : TimeseriesdecompclassicalGraphN) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_classical_graphn_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_classical_graphn_scale(s : TimeseriesdecompclassicalGraphN, f : Double) -> TimeseriesdecompclassicalGraphN {
  let result = timeseries_decomp_classical_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_classical_graphn_add(a : TimeseriesdecompclassicalGraphN, b : TimeseriesdecompclassicalGraphN) -> TimeseriesdecompclassicalGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_classical_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_classical_graphn_copy(s : TimeseriesdecompclassicalGraphN) -> TimeseriesdecompclassicalGraphN {
  let result = timeseries_decomp_classical_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_classical_graphn_fill(s : TimeseriesdecompclassicalGraphN, v : Double) -> TimeseriesdecompclassicalGraphN {
  let result = timeseries_decomp_classical_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_classical_graphn_min(s : TimeseriesdecompclassicalGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_classical_graphn_max(s : TimeseriesdecompclassicalGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_classical_graphn_to_string(s : TimeseriesdecompclassicalGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompclassicalNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_classical_node_make(size : Int) -> TimeseriesdecompclassicalNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_classical_node_len(s : TimeseriesdecompclassicalNode) -> Int { s.size }

pub fn timeseries_decomp_classical_node_get(s : TimeseriesdecompclassicalNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_classical_node_set(s : TimeseriesdecompclassicalNode, i : Int, v : Double) -> TimeseriesdecompclassicalNode {
  let result = timeseries_decomp_classical_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_classical_node_sum(s : TimeseriesdecompclassicalNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_classical_node_mean(s : TimeseriesdecompclassicalNode) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_classical_node_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_classical_node_scale(s : TimeseriesdecompclassicalNode, f : Double) -> TimeseriesdecompclassicalNode {
  let result = timeseries_decomp_classical_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_classical_node_add(a : TimeseriesdecompclassicalNode, b : TimeseriesdecompclassicalNode) -> TimeseriesdecompclassicalNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_classical_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_classical_node_copy(s : TimeseriesdecompclassicalNode) -> TimeseriesdecompclassicalNode {
  let result = timeseries_decomp_classical_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_classical_node_fill(s : TimeseriesdecompclassicalNode, v : Double) -> TimeseriesdecompclassicalNode {
  let result = timeseries_decomp_classical_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_classical_node_min(s : TimeseriesdecompclassicalNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_classical_node_max(s : TimeseriesdecompclassicalNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_classical_node_to_string(s : TimeseriesdecompclassicalNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompclassicalEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_classical_edge_make(size : Int) -> TimeseriesdecompclassicalEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_classical_edge_len(s : TimeseriesdecompclassicalEdge) -> Int { s.size }

pub fn timeseries_decomp_classical_edge_get(s : TimeseriesdecompclassicalEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_classical_edge_set(s : TimeseriesdecompclassicalEdge, i : Int, v : Double) -> TimeseriesdecompclassicalEdge {
  let result = timeseries_decomp_classical_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_classical_edge_sum(s : TimeseriesdecompclassicalEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_classical_edge_mean(s : TimeseriesdecompclassicalEdge) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_classical_edge_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_classical_edge_scale(s : TimeseriesdecompclassicalEdge, f : Double) -> TimeseriesdecompclassicalEdge {
  let result = timeseries_decomp_classical_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_classical_edge_add(a : TimeseriesdecompclassicalEdge, b : TimeseriesdecompclassicalEdge) -> TimeseriesdecompclassicalEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_classical_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_classical_edge_copy(s : TimeseriesdecompclassicalEdge) -> TimeseriesdecompclassicalEdge {
  let result = timeseries_decomp_classical_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_classical_edge_fill(s : TimeseriesdecompclassicalEdge, v : Double) -> TimeseriesdecompclassicalEdge {
  let result = timeseries_decomp_classical_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_classical_edge_min(s : TimeseriesdecompclassicalEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_classical_edge_max(s : TimeseriesdecompclassicalEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_classical_edge_to_string(s : TimeseriesdecompclassicalEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompclassicalPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_classical_path_make(size : Int) -> TimeseriesdecompclassicalPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_classical_path_len(s : TimeseriesdecompclassicalPath) -> Int { s.size }

pub fn timeseries_decomp_classical_path_get(s : TimeseriesdecompclassicalPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_classical_path_set(s : TimeseriesdecompclassicalPath, i : Int, v : Double) -> TimeseriesdecompclassicalPath {
  let result = timeseries_decomp_classical_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_classical_path_sum(s : TimeseriesdecompclassicalPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_classical_path_mean(s : TimeseriesdecompclassicalPath) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_classical_path_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_classical_path_scale(s : TimeseriesdecompclassicalPath, f : Double) -> TimeseriesdecompclassicalPath {
  let result = timeseries_decomp_classical_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_classical_path_add(a : TimeseriesdecompclassicalPath, b : TimeseriesdecompclassicalPath) -> TimeseriesdecompclassicalPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_classical_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_classical_path_copy(s : TimeseriesdecompclassicalPath) -> TimeseriesdecompclassicalPath {
  let result = timeseries_decomp_classical_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_classical_path_fill(s : TimeseriesdecompclassicalPath, v : Double) -> TimeseriesdecompclassicalPath {
  let result = timeseries_decomp_classical_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_classical_path_min(s : TimeseriesdecompclassicalPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_classical_path_max(s : TimeseriesdecompclassicalPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_classical_path_to_string(s : TimeseriesdecompclassicalPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompclassicalCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_classical_cluster_make(size : Int) -> TimeseriesdecompclassicalCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_classical_cluster_len(s : TimeseriesdecompclassicalCluster) -> Int { s.size }

pub fn timeseries_decomp_classical_cluster_get(s : TimeseriesdecompclassicalCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_classical_cluster_set(s : TimeseriesdecompclassicalCluster, i : Int, v : Double) -> TimeseriesdecompclassicalCluster {
  let result = timeseries_decomp_classical_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_classical_cluster_sum(s : TimeseriesdecompclassicalCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_classical_cluster_mean(s : TimeseriesdecompclassicalCluster) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_classical_cluster_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_classical_cluster_scale(s : TimeseriesdecompclassicalCluster, f : Double) -> TimeseriesdecompclassicalCluster {
  let result = timeseries_decomp_classical_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_classical_cluster_add(a : TimeseriesdecompclassicalCluster, b : TimeseriesdecompclassicalCluster) -> TimeseriesdecompclassicalCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_classical_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_classical_cluster_copy(s : TimeseriesdecompclassicalCluster) -> TimeseriesdecompclassicalCluster {
  let result = timeseries_decomp_classical_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_classical_cluster_fill(s : TimeseriesdecompclassicalCluster, v : Double) -> TimeseriesdecompclassicalCluster {
  let result = timeseries_decomp_classical_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_classical_cluster_min(s : TimeseriesdecompclassicalCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_classical_cluster_max(s : TimeseriesdecompclassicalCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_classical_cluster_to_string(s : TimeseriesdecompclassicalCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompclassicalModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_classical_model_make(size : Int) -> TimeseriesdecompclassicalModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_classical_model_len(s : TimeseriesdecompclassicalModel) -> Int { s.size }

pub fn timeseries_decomp_classical_model_get(s : TimeseriesdecompclassicalModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_classical_model_set(s : TimeseriesdecompclassicalModel, i : Int, v : Double) -> TimeseriesdecompclassicalModel {
  let result = timeseries_decomp_classical_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_classical_model_sum(s : TimeseriesdecompclassicalModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_classical_model_mean(s : TimeseriesdecompclassicalModel) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_classical_model_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_classical_model_scale(s : TimeseriesdecompclassicalModel, f : Double) -> TimeseriesdecompclassicalModel {
  let result = timeseries_decomp_classical_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_classical_model_add(a : TimeseriesdecompclassicalModel, b : TimeseriesdecompclassicalModel) -> TimeseriesdecompclassicalModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_classical_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_classical_model_copy(s : TimeseriesdecompclassicalModel) -> TimeseriesdecompclassicalModel {
  let result = timeseries_decomp_classical_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_classical_model_fill(s : TimeseriesdecompclassicalModel, v : Double) -> TimeseriesdecompclassicalModel {
  let result = timeseries_decomp_classical_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_classical_model_min(s : TimeseriesdecompclassicalModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_classical_model_max(s : TimeseriesdecompclassicalModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_classical_model_to_string(s : TimeseriesdecompclassicalModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompclassicalLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_classical_layer_make(size : Int) -> TimeseriesdecompclassicalLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_classical_layer_len(s : TimeseriesdecompclassicalLayer) -> Int { s.size }

pub fn timeseries_decomp_classical_layer_get(s : TimeseriesdecompclassicalLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_classical_layer_set(s : TimeseriesdecompclassicalLayer, i : Int, v : Double) -> TimeseriesdecompclassicalLayer {
  let result = timeseries_decomp_classical_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_classical_layer_sum(s : TimeseriesdecompclassicalLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_classical_layer_mean(s : TimeseriesdecompclassicalLayer) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_classical_layer_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_classical_layer_scale(s : TimeseriesdecompclassicalLayer, f : Double) -> TimeseriesdecompclassicalLayer {
  let result = timeseries_decomp_classical_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_classical_layer_add(a : TimeseriesdecompclassicalLayer, b : TimeseriesdecompclassicalLayer) -> TimeseriesdecompclassicalLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_classical_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_classical_layer_copy(s : TimeseriesdecompclassicalLayer) -> TimeseriesdecompclassicalLayer {
  let result = timeseries_decomp_classical_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_classical_layer_fill(s : TimeseriesdecompclassicalLayer, v : Double) -> TimeseriesdecompclassicalLayer {
  let result = timeseries_decomp_classical_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_classical_layer_min(s : TimeseriesdecompclassicalLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_classical_layer_max(s : TimeseriesdecompclassicalLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_classical_layer_to_string(s : TimeseriesdecompclassicalLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompclassicalBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_classical_buffer_make(size : Int) -> TimeseriesdecompclassicalBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_classical_buffer_len(s : TimeseriesdecompclassicalBuffer) -> Int { s.size }

pub fn timeseries_decomp_classical_buffer_get(s : TimeseriesdecompclassicalBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_classical_buffer_set(s : TimeseriesdecompclassicalBuffer, i : Int, v : Double) -> TimeseriesdecompclassicalBuffer {
  let result = timeseries_decomp_classical_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_classical_buffer_sum(s : TimeseriesdecompclassicalBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_classical_buffer_mean(s : TimeseriesdecompclassicalBuffer) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_classical_buffer_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_classical_buffer_scale(s : TimeseriesdecompclassicalBuffer, f : Double) -> TimeseriesdecompclassicalBuffer {
  let result = timeseries_decomp_classical_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_classical_buffer_add(a : TimeseriesdecompclassicalBuffer, b : TimeseriesdecompclassicalBuffer) -> TimeseriesdecompclassicalBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_classical_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_classical_buffer_copy(s : TimeseriesdecompclassicalBuffer) -> TimeseriesdecompclassicalBuffer {
  let result = timeseries_decomp_classical_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_classical_buffer_fill(s : TimeseriesdecompclassicalBuffer, v : Double) -> TimeseriesdecompclassicalBuffer {
  let result = timeseries_decomp_classical_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_classical_buffer_min(s : TimeseriesdecompclassicalBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_classical_buffer_max(s : TimeseriesdecompclassicalBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_classical_buffer_to_string(s : TimeseriesdecompclassicalBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompclassicalCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_classical_cursor_make(size : Int) -> TimeseriesdecompclassicalCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_classical_cursor_len(s : TimeseriesdecompclassicalCursor) -> Int { s.size }

pub fn timeseries_decomp_classical_cursor_get(s : TimeseriesdecompclassicalCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_classical_cursor_set(s : TimeseriesdecompclassicalCursor, i : Int, v : Double) -> TimeseriesdecompclassicalCursor {
  let result = timeseries_decomp_classical_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_classical_cursor_sum(s : TimeseriesdecompclassicalCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_classical_cursor_mean(s : TimeseriesdecompclassicalCursor) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_classical_cursor_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_classical_cursor_scale(s : TimeseriesdecompclassicalCursor, f : Double) -> TimeseriesdecompclassicalCursor {
  let result = timeseries_decomp_classical_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_classical_cursor_add(a : TimeseriesdecompclassicalCursor, b : TimeseriesdecompclassicalCursor) -> TimeseriesdecompclassicalCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_classical_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_classical_cursor_copy(s : TimeseriesdecompclassicalCursor) -> TimeseriesdecompclassicalCursor {
  let result = timeseries_decomp_classical_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_classical_cursor_fill(s : TimeseriesdecompclassicalCursor, v : Double) -> TimeseriesdecompclassicalCursor {
  let result = timeseries_decomp_classical_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_classical_cursor_min(s : TimeseriesdecompclassicalCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_classical_cursor_max(s : TimeseriesdecompclassicalCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_classical_cursor_to_string(s : TimeseriesdecompclassicalCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompclassicalView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_classical_view_make(size : Int) -> TimeseriesdecompclassicalView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_classical_view_len(s : TimeseriesdecompclassicalView) -> Int { s.size }

pub fn timeseries_decomp_classical_view_get(s : TimeseriesdecompclassicalView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_classical_view_set(s : TimeseriesdecompclassicalView, i : Int, v : Double) -> TimeseriesdecompclassicalView {
  let result = timeseries_decomp_classical_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_classical_view_sum(s : TimeseriesdecompclassicalView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_classical_view_mean(s : TimeseriesdecompclassicalView) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_classical_view_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_classical_view_scale(s : TimeseriesdecompclassicalView, f : Double) -> TimeseriesdecompclassicalView {
  let result = timeseries_decomp_classical_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_classical_view_add(a : TimeseriesdecompclassicalView, b : TimeseriesdecompclassicalView) -> TimeseriesdecompclassicalView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_classical_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_classical_view_copy(s : TimeseriesdecompclassicalView) -> TimeseriesdecompclassicalView {
  let result = timeseries_decomp_classical_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_classical_view_fill(s : TimeseriesdecompclassicalView, v : Double) -> TimeseriesdecompclassicalView {
  let result = timeseries_decomp_classical_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_classical_view_min(s : TimeseriesdecompclassicalView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_classical_view_max(s : TimeseriesdecompclassicalView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_classical_view_to_string(s : TimeseriesdecompclassicalView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompclassicalRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_classical_range_make(size : Int) -> TimeseriesdecompclassicalRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_classical_range_len(s : TimeseriesdecompclassicalRange) -> Int { s.size }

pub fn timeseries_decomp_classical_range_get(s : TimeseriesdecompclassicalRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_classical_range_set(s : TimeseriesdecompclassicalRange, i : Int, v : Double) -> TimeseriesdecompclassicalRange {
  let result = timeseries_decomp_classical_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_classical_range_sum(s : TimeseriesdecompclassicalRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_classical_range_mean(s : TimeseriesdecompclassicalRange) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_classical_range_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_classical_range_scale(s : TimeseriesdecompclassicalRange, f : Double) -> TimeseriesdecompclassicalRange {
  let result = timeseries_decomp_classical_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_classical_range_add(a : TimeseriesdecompclassicalRange, b : TimeseriesdecompclassicalRange) -> TimeseriesdecompclassicalRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_classical_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_classical_range_copy(s : TimeseriesdecompclassicalRange) -> TimeseriesdecompclassicalRange {
  let result = timeseries_decomp_classical_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_classical_range_fill(s : TimeseriesdecompclassicalRange, v : Double) -> TimeseriesdecompclassicalRange {
  let result = timeseries_decomp_classical_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_classical_range_min(s : TimeseriesdecompclassicalRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_classical_range_max(s : TimeseriesdecompclassicalRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_classical_range_to_string(s : TimeseriesdecompclassicalRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompclassicalSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_classical_slice_make(size : Int) -> TimeseriesdecompclassicalSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_classical_slice_len(s : TimeseriesdecompclassicalSlice) -> Int { s.size }

pub fn timeseries_decomp_classical_slice_get(s : TimeseriesdecompclassicalSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_classical_slice_set(s : TimeseriesdecompclassicalSlice, i : Int, v : Double) -> TimeseriesdecompclassicalSlice {
  let result = timeseries_decomp_classical_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_classical_slice_sum(s : TimeseriesdecompclassicalSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_classical_slice_mean(s : TimeseriesdecompclassicalSlice) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_classical_slice_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_classical_slice_scale(s : TimeseriesdecompclassicalSlice, f : Double) -> TimeseriesdecompclassicalSlice {
  let result = timeseries_decomp_classical_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_classical_slice_add(a : TimeseriesdecompclassicalSlice, b : TimeseriesdecompclassicalSlice) -> TimeseriesdecompclassicalSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_classical_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_classical_slice_copy(s : TimeseriesdecompclassicalSlice) -> TimeseriesdecompclassicalSlice {
  let result = timeseries_decomp_classical_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_classical_slice_fill(s : TimeseriesdecompclassicalSlice, v : Double) -> TimeseriesdecompclassicalSlice {
  let result = timeseries_decomp_classical_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_classical_slice_min(s : TimeseriesdecompclassicalSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_classical_slice_max(s : TimeseriesdecompclassicalSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_classical_slice_to_string(s : TimeseriesdecompclassicalSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


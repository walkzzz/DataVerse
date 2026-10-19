///===
/// extcore/timeseries_decomp_hp

pub(all) struct TimeseriesdecomphpPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_decomp_hp_make_point(x : Double, y : Double) -> TimeseriesdecomphpPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_decomp_hp_make_point3(x : Double, y : Double, z : Double) -> TimeseriesdecomphpPoint {
  { x, y, z, label: 0 }
}

pub fn timeseries_decomp_hp_point_x(pt : TimeseriesdecomphpPoint) -> Double { pt.x }

pub fn timeseries_decomp_hp_point_y(pt : TimeseriesdecomphpPoint) -> Double { pt.y }

pub fn timeseries_decomp_hp_point_z(pt : TimeseriesdecomphpPoint) -> Double { pt.z }

pub fn timeseries_decomp_hp_point_label(pt : TimeseriesdecomphpPoint) -> Int { pt.label }

pub fn timeseries_decomp_hp_point_dist(a : TimeseriesdecomphpPoint, b : TimeseriesdecomphpPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  timeseries_decomp_hp_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn timeseries_decomp_hp_point_add(a : TimeseriesdecomphpPoint, b : TimeseriesdecomphpPoint) -> TimeseriesdecomphpPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn timeseries_decomp_hp_point_sub(a : TimeseriesdecomphpPoint, b : TimeseriesdecomphpPoint) -> TimeseriesdecomphpPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn timeseries_decomp_hp_point_scale(pt : TimeseriesdecomphpPoint, s : Double) -> TimeseriesdecomphpPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn timeseries_decomp_hp_point_dot(a : TimeseriesdecomphpPoint, b : TimeseriesdecomphpPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn timeseries_decomp_hp_point_cross(a : TimeseriesdecomphpPoint, b : TimeseriesdecomphpPoint) -> TimeseriesdecomphpPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn timeseries_decomp_hp_point_norm(pt : TimeseriesdecomphpPoint) -> Double {
  timeseries_decomp_hp_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn timeseries_decomp_hp_point_normalize(pt : TimeseriesdecomphpPoint) -> TimeseriesdecomphpPoint {
  let n = timeseries_decomp_hp_point_norm(pt)
  if n < 0.0000001 { pt } else { timeseries_decomp_hp_point_scale(pt, 1.0 / n) }
}

pub fn timeseries_decomp_hp_point_negate(pt : TimeseriesdecomphpPoint) -> TimeseriesdecomphpPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn timeseries_decomp_hp_point_mid(a : TimeseriesdecomphpPoint, b : TimeseriesdecomphpPoint) -> TimeseriesdecomphpPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn timeseries_decomp_hp_point_lerp(a : TimeseriesdecomphpPoint, b : TimeseriesdecomphpPoint, t : Double) -> TimeseriesdecomphpPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn timeseries_decomp_hp_point_to_string(pt : TimeseriesdecomphpPoint) -> String {
  "(" + timeseries_decomp_hp_dbl(pt.x) + ", " + timeseries_decomp_hp_dbl(pt.y) + ", " + timeseries_decomp_hp_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct TimeseriesdecomphpSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_decomp_hp_make_series(vals : Array[Double], name : String) -> TimeseriesdecomphpSeries {
  { vals, name, meta: 0 }
}

pub fn timeseries_decomp_hp_series_len(s : TimeseriesdecomphpSeries) -> Int { s.vals.length() }

pub fn timeseries_decomp_hp_series_sum(s : TimeseriesdecomphpSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn timeseries_decomp_hp_series_mean(s : TimeseriesdecomphpSeries) -> Double {
  let n = timeseries_decomp_hp_series_len(s)
  if n == 0 { 0.0 } else { timeseries_decomp_hp_series_sum(s) / n.to_double() }
}

pub fn timeseries_decomp_hp_series_min(s : TimeseriesdecomphpSeries) -> Double {
  let n = timeseries_decomp_hp_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn timeseries_decomp_hp_series_max(s : TimeseriesdecomphpSeries) -> Double {
  let n = timeseries_decomp_hp_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn timeseries_decomp_hp_series_range(s : TimeseriesdecomphpSeries) -> Double {
  timeseries_decomp_hp_series_max(s) - timeseries_decomp_hp_series_min(s)
}

pub fn timeseries_decomp_hp_series_var(s : TimeseriesdecomphpSeries) -> Double {
  let n = timeseries_decomp_hp_series_len(s)
  if n == 0 { 0.0 } else {
    let m = timeseries_decomp_hp_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn timeseries_decomp_hp_series_std(s : TimeseriesdecomphpSeries) -> Double { timeseries_decomp_hp_sqrt(timeseries_decomp_hp_series_var(s)) }

pub fn timeseries_decomp_hp_series_median(s : TimeseriesdecomphpSeries) -> Double {
  let n = timeseries_decomp_hp_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = timeseries_decomp_hp_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn timeseries_decomp_hp_series_scale(s : TimeseriesdecomphpSeries, f : Double) -> TimeseriesdecomphpSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = timeseries_decomp_hp_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn timeseries_decomp_hp_series_add(a : TimeseriesdecomphpSeries, b : TimeseriesdecomphpSeries) -> TimeseriesdecomphpSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = timeseries_decomp_hp_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn timeseries_decomp_hp_series_sub(a : TimeseriesdecomphpSeries, b : TimeseriesdecomphpSeries) -> TimeseriesdecomphpSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = timeseries_decomp_hp_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn timeseries_decomp_hp_series_normalize(s : TimeseriesdecomphpSeries) -> TimeseriesdecomphpSeries {
  let mn = timeseries_decomp_hp_series_min(s)
  let mx = timeseries_decomp_hp_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = timeseries_decomp_hp_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn timeseries_decomp_hp_series_cumsum(s : TimeseriesdecomphpSeries) -> TimeseriesdecomphpSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = timeseries_decomp_hp_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn timeseries_decomp_hp_series_to_string(s : TimeseriesdecomphpSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + timeseries_decomp_hp_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesdecomphpMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_decomp_hp_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriesdecomphpMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn timeseries_decomp_hp_matrix_identity(n : Int) -> TimeseriesdecomphpMatrix {
  let m = timeseries_decomp_hp_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn timeseries_decomp_hp_matrix_get(m : TimeseriesdecomphpMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn timeseries_decomp_hp_matrix_transpose(m : TimeseriesdecomphpMatrix) -> TimeseriesdecomphpMatrix {
  let result = timeseries_decomp_hp_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn timeseries_decomp_hp_matrix_add(a : TimeseriesdecomphpMatrix, b : TimeseriesdecomphpMatrix) -> TimeseriesdecomphpMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = timeseries_decomp_hp_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn timeseries_decomp_hp_matrix_scale(m : TimeseriesdecomphpMatrix, s : Double) -> TimeseriesdecomphpMatrix {
  let result = timeseries_decomp_hp_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn timeseries_decomp_hp_matrix_multiply(a : TimeseriesdecomphpMatrix, b : TimeseriesdecomphpMatrix) -> TimeseriesdecomphpMatrix {
  if a.cols != b.rows { return timeseries_decomp_hp_make_matrix(a.rows, b.cols, 0.0) }
  let result = timeseries_decomp_hp_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn timeseries_decomp_hp_matrix_trace(m : TimeseriesdecomphpMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn timeseries_decomp_hp_matrix_det(m : TimeseriesdecomphpMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn timeseries_decomp_hp_matrix_norm(m : TimeseriesdecomphpMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  timeseries_decomp_hp_sqrt(sum)
}

pub fn timeseries_decomp_hp_matrix_to_string(m : TimeseriesdecomphpMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + timeseries_decomp_hp_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct TimeseriesdecomphpVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_decomp_hp_make_vector(comps : Array[Double]) -> TimeseriesdecomphpVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_decomp_hp_vector_zero(dim : Int) -> TimeseriesdecomphpVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn timeseries_decomp_hp_vector_add(a : TimeseriesdecomphpVector, b : TimeseriesdecomphpVector) -> TimeseriesdecomphpVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = timeseries_decomp_hp_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn timeseries_decomp_hp_vector_sub(a : TimeseriesdecomphpVector, b : TimeseriesdecomphpVector) -> TimeseriesdecomphpVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = timeseries_decomp_hp_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn timeseries_decomp_hp_vector_scale(v : TimeseriesdecomphpVector, s : Double) -> TimeseriesdecomphpVector {
  let mut result = []
  for i in 0..<v.dim { result = timeseries_decomp_hp_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn timeseries_decomp_hp_vector_dot(a : TimeseriesdecomphpVector, b : TimeseriesdecomphpVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn timeseries_decomp_hp_vector_norm(v : TimeseriesdecomphpVector) -> Double { timeseries_decomp_hp_sqrt(timeseries_decomp_hp_vector_dot(v, v)) }

pub fn timeseries_decomp_hp_vector_normalize(v : TimeseriesdecomphpVector) -> TimeseriesdecomphpVector {
  let n = timeseries_decomp_hp_vector_norm(v)
  if n < 0.0000001 { v } else { timeseries_decomp_hp_vector_scale(v, 1.0 / n) }
}

pub fn timeseries_decomp_hp_vector_dist(a : TimeseriesdecomphpVector, b : TimeseriesdecomphpVector) -> Double {
  timeseries_decomp_hp_vector_norm(timeseries_decomp_hp_vector_sub(a, b))
}

pub fn timeseries_decomp_hp_vector_to_string(v : TimeseriesdecomphpVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + timeseries_decomp_hp_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn timeseries_decomp_hp_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn timeseries_decomp_hp_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = timeseries_decomp_hp_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn timeseries_decomp_hp_std(data : Array[Double]) -> Double { timeseries_decomp_hp_sqrt(timeseries_decomp_hp_var(data)) }

pub fn timeseries_decomp_hp_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = timeseries_decomp_hp_mean(a); let mb = timeseries_decomp_hp_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn timeseries_decomp_hp_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = timeseries_decomp_hp_std(a); let sb = timeseries_decomp_hp_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { timeseries_decomp_hp_cov(a, b) / (sa * sb) }
}

pub fn timeseries_decomp_hp_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = timeseries_decomp_hp_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn timeseries_decomp_hp_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn timeseries_decomp_hp_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn timeseries_decomp_hp_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  timeseries_decomp_hp_sqrt(timeseries_decomp_hp_mse(pred, labels))
}

pub fn timeseries_decomp_hp_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + timeseries_decomp_hp_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn timeseries_decomp_hp_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = timeseries_decomp_hp_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn timeseries_decomp_hp_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn timeseries_decomp_hp_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn timeseries_decomp_hp_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = timeseries_decomp_hp_precision(pred, labels, pos); let r = timeseries_decomp_hp_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn timeseries_decomp_hp_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn timeseries_decomp_hp_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = timeseries_decomp_hp_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn timeseries_decomp_hp_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn timeseries_decomp_hp_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn timeseries_decomp_hp_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = timeseries_decomp_hp_gcd(a, b)
    (a / g) * b
  }
}

pub fn timeseries_decomp_hp_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn timeseries_decomp_hp_fibonacci(n : Int) -> Int {
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

pub fn timeseries_decomp_hp_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = timeseries_decomp_hp_min(data); let mx = timeseries_decomp_hp_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn timeseries_decomp_hp_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = timeseries_decomp_hp_mean(data); let sd = timeseries_decomp_hp_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn timeseries_decomp_hp_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn timeseries_decomp_hp_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn timeseries_decomp_hp_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn timeseries_decomp_hp_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn timeseries_decomp_hp_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn timeseries_decomp_hp_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn timeseries_decomp_hp_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn timeseries_decomp_hp_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn timeseries_decomp_hp_dbl(x : Double) -> String {
  let i = if x >= 0.0 { timeseries_decomp_hp_int(x) } else { -timeseries_decomp_hp_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { timeseries_decomp_hp_int(f * 1000000.0) } else { timeseries_decomp_hp_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn timeseries_decomp_hp_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn timeseries_decomp_hp_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct TimeseriesdecomphpFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_hp_frame_make(size : Int) -> TimeseriesdecomphpFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_hp_frame_len(s : TimeseriesdecomphpFrame) -> Int { s.size }

pub fn timeseries_decomp_hp_frame_get(s : TimeseriesdecomphpFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_hp_frame_set(s : TimeseriesdecomphpFrame, i : Int, v : Double) -> TimeseriesdecomphpFrame {
  let result = timeseries_decomp_hp_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_hp_frame_sum(s : TimeseriesdecomphpFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_hp_frame_mean(s : TimeseriesdecomphpFrame) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_hp_frame_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_hp_frame_scale(s : TimeseriesdecomphpFrame, f : Double) -> TimeseriesdecomphpFrame {
  let result = timeseries_decomp_hp_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_hp_frame_add(a : TimeseriesdecomphpFrame, b : TimeseriesdecomphpFrame) -> TimeseriesdecomphpFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_hp_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_hp_frame_copy(s : TimeseriesdecomphpFrame) -> TimeseriesdecomphpFrame {
  let result = timeseries_decomp_hp_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_hp_frame_fill(s : TimeseriesdecomphpFrame, v : Double) -> TimeseriesdecomphpFrame {
  let result = timeseries_decomp_hp_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_hp_frame_min(s : TimeseriesdecomphpFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_hp_frame_max(s : TimeseriesdecomphpFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_hp_frame_to_string(s : TimeseriesdecomphpFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecomphpTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_hp_table_make(size : Int) -> TimeseriesdecomphpTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_hp_table_len(s : TimeseriesdecomphpTable) -> Int { s.size }

pub fn timeseries_decomp_hp_table_get(s : TimeseriesdecomphpTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_hp_table_set(s : TimeseriesdecomphpTable, i : Int, v : Double) -> TimeseriesdecomphpTable {
  let result = timeseries_decomp_hp_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_hp_table_sum(s : TimeseriesdecomphpTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_hp_table_mean(s : TimeseriesdecomphpTable) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_hp_table_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_hp_table_scale(s : TimeseriesdecomphpTable, f : Double) -> TimeseriesdecomphpTable {
  let result = timeseries_decomp_hp_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_hp_table_add(a : TimeseriesdecomphpTable, b : TimeseriesdecomphpTable) -> TimeseriesdecomphpTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_hp_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_hp_table_copy(s : TimeseriesdecomphpTable) -> TimeseriesdecomphpTable {
  let result = timeseries_decomp_hp_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_hp_table_fill(s : TimeseriesdecomphpTable, v : Double) -> TimeseriesdecomphpTable {
  let result = timeseries_decomp_hp_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_hp_table_min(s : TimeseriesdecomphpTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_hp_table_max(s : TimeseriesdecomphpTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_hp_table_to_string(s : TimeseriesdecomphpTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecomphpGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_hp_graphn_make(size : Int) -> TimeseriesdecomphpGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_hp_graphn_len(s : TimeseriesdecomphpGraphN) -> Int { s.size }

pub fn timeseries_decomp_hp_graphn_get(s : TimeseriesdecomphpGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_hp_graphn_set(s : TimeseriesdecomphpGraphN, i : Int, v : Double) -> TimeseriesdecomphpGraphN {
  let result = timeseries_decomp_hp_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_hp_graphn_sum(s : TimeseriesdecomphpGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_hp_graphn_mean(s : TimeseriesdecomphpGraphN) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_hp_graphn_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_hp_graphn_scale(s : TimeseriesdecomphpGraphN, f : Double) -> TimeseriesdecomphpGraphN {
  let result = timeseries_decomp_hp_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_hp_graphn_add(a : TimeseriesdecomphpGraphN, b : TimeseriesdecomphpGraphN) -> TimeseriesdecomphpGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_hp_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_hp_graphn_copy(s : TimeseriesdecomphpGraphN) -> TimeseriesdecomphpGraphN {
  let result = timeseries_decomp_hp_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_hp_graphn_fill(s : TimeseriesdecomphpGraphN, v : Double) -> TimeseriesdecomphpGraphN {
  let result = timeseries_decomp_hp_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_hp_graphn_min(s : TimeseriesdecomphpGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_hp_graphn_max(s : TimeseriesdecomphpGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_hp_graphn_to_string(s : TimeseriesdecomphpGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecomphpNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_hp_node_make(size : Int) -> TimeseriesdecomphpNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_hp_node_len(s : TimeseriesdecomphpNode) -> Int { s.size }

pub fn timeseries_decomp_hp_node_get(s : TimeseriesdecomphpNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_hp_node_set(s : TimeseriesdecomphpNode, i : Int, v : Double) -> TimeseriesdecomphpNode {
  let result = timeseries_decomp_hp_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_hp_node_sum(s : TimeseriesdecomphpNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_hp_node_mean(s : TimeseriesdecomphpNode) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_hp_node_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_hp_node_scale(s : TimeseriesdecomphpNode, f : Double) -> TimeseriesdecomphpNode {
  let result = timeseries_decomp_hp_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_hp_node_add(a : TimeseriesdecomphpNode, b : TimeseriesdecomphpNode) -> TimeseriesdecomphpNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_hp_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_hp_node_copy(s : TimeseriesdecomphpNode) -> TimeseriesdecomphpNode {
  let result = timeseries_decomp_hp_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_hp_node_fill(s : TimeseriesdecomphpNode, v : Double) -> TimeseriesdecomphpNode {
  let result = timeseries_decomp_hp_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_hp_node_min(s : TimeseriesdecomphpNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_hp_node_max(s : TimeseriesdecomphpNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_hp_node_to_string(s : TimeseriesdecomphpNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecomphpEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_hp_edge_make(size : Int) -> TimeseriesdecomphpEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_hp_edge_len(s : TimeseriesdecomphpEdge) -> Int { s.size }

pub fn timeseries_decomp_hp_edge_get(s : TimeseriesdecomphpEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_hp_edge_set(s : TimeseriesdecomphpEdge, i : Int, v : Double) -> TimeseriesdecomphpEdge {
  let result = timeseries_decomp_hp_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_hp_edge_sum(s : TimeseriesdecomphpEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_hp_edge_mean(s : TimeseriesdecomphpEdge) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_hp_edge_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_hp_edge_scale(s : TimeseriesdecomphpEdge, f : Double) -> TimeseriesdecomphpEdge {
  let result = timeseries_decomp_hp_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_hp_edge_add(a : TimeseriesdecomphpEdge, b : TimeseriesdecomphpEdge) -> TimeseriesdecomphpEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_hp_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_hp_edge_copy(s : TimeseriesdecomphpEdge) -> TimeseriesdecomphpEdge {
  let result = timeseries_decomp_hp_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_hp_edge_fill(s : TimeseriesdecomphpEdge, v : Double) -> TimeseriesdecomphpEdge {
  let result = timeseries_decomp_hp_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_hp_edge_min(s : TimeseriesdecomphpEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_hp_edge_max(s : TimeseriesdecomphpEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_hp_edge_to_string(s : TimeseriesdecomphpEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecomphpPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_hp_path_make(size : Int) -> TimeseriesdecomphpPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_hp_path_len(s : TimeseriesdecomphpPath) -> Int { s.size }

pub fn timeseries_decomp_hp_path_get(s : TimeseriesdecomphpPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_hp_path_set(s : TimeseriesdecomphpPath, i : Int, v : Double) -> TimeseriesdecomphpPath {
  let result = timeseries_decomp_hp_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_hp_path_sum(s : TimeseriesdecomphpPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_hp_path_mean(s : TimeseriesdecomphpPath) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_hp_path_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_hp_path_scale(s : TimeseriesdecomphpPath, f : Double) -> TimeseriesdecomphpPath {
  let result = timeseries_decomp_hp_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_hp_path_add(a : TimeseriesdecomphpPath, b : TimeseriesdecomphpPath) -> TimeseriesdecomphpPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_hp_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_hp_path_copy(s : TimeseriesdecomphpPath) -> TimeseriesdecomphpPath {
  let result = timeseries_decomp_hp_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_hp_path_fill(s : TimeseriesdecomphpPath, v : Double) -> TimeseriesdecomphpPath {
  let result = timeseries_decomp_hp_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_hp_path_min(s : TimeseriesdecomphpPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_hp_path_max(s : TimeseriesdecomphpPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_hp_path_to_string(s : TimeseriesdecomphpPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecomphpCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_hp_cluster_make(size : Int) -> TimeseriesdecomphpCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_hp_cluster_len(s : TimeseriesdecomphpCluster) -> Int { s.size }

pub fn timeseries_decomp_hp_cluster_get(s : TimeseriesdecomphpCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_hp_cluster_set(s : TimeseriesdecomphpCluster, i : Int, v : Double) -> TimeseriesdecomphpCluster {
  let result = timeseries_decomp_hp_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_hp_cluster_sum(s : TimeseriesdecomphpCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_hp_cluster_mean(s : TimeseriesdecomphpCluster) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_hp_cluster_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_hp_cluster_scale(s : TimeseriesdecomphpCluster, f : Double) -> TimeseriesdecomphpCluster {
  let result = timeseries_decomp_hp_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_hp_cluster_add(a : TimeseriesdecomphpCluster, b : TimeseriesdecomphpCluster) -> TimeseriesdecomphpCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_hp_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_hp_cluster_copy(s : TimeseriesdecomphpCluster) -> TimeseriesdecomphpCluster {
  let result = timeseries_decomp_hp_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_hp_cluster_fill(s : TimeseriesdecomphpCluster, v : Double) -> TimeseriesdecomphpCluster {
  let result = timeseries_decomp_hp_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_hp_cluster_min(s : TimeseriesdecomphpCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_hp_cluster_max(s : TimeseriesdecomphpCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_hp_cluster_to_string(s : TimeseriesdecomphpCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecomphpModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_hp_model_make(size : Int) -> TimeseriesdecomphpModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_hp_model_len(s : TimeseriesdecomphpModel) -> Int { s.size }

pub fn timeseries_decomp_hp_model_get(s : TimeseriesdecomphpModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_hp_model_set(s : TimeseriesdecomphpModel, i : Int, v : Double) -> TimeseriesdecomphpModel {
  let result = timeseries_decomp_hp_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_hp_model_sum(s : TimeseriesdecomphpModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_hp_model_mean(s : TimeseriesdecomphpModel) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_hp_model_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_hp_model_scale(s : TimeseriesdecomphpModel, f : Double) -> TimeseriesdecomphpModel {
  let result = timeseries_decomp_hp_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_hp_model_add(a : TimeseriesdecomphpModel, b : TimeseriesdecomphpModel) -> TimeseriesdecomphpModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_hp_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_hp_model_copy(s : TimeseriesdecomphpModel) -> TimeseriesdecomphpModel {
  let result = timeseries_decomp_hp_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_hp_model_fill(s : TimeseriesdecomphpModel, v : Double) -> TimeseriesdecomphpModel {
  let result = timeseries_decomp_hp_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_hp_model_min(s : TimeseriesdecomphpModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_hp_model_max(s : TimeseriesdecomphpModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_hp_model_to_string(s : TimeseriesdecomphpModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecomphpLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_hp_layer_make(size : Int) -> TimeseriesdecomphpLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_hp_layer_len(s : TimeseriesdecomphpLayer) -> Int { s.size }

pub fn timeseries_decomp_hp_layer_get(s : TimeseriesdecomphpLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_hp_layer_set(s : TimeseriesdecomphpLayer, i : Int, v : Double) -> TimeseriesdecomphpLayer {
  let result = timeseries_decomp_hp_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_hp_layer_sum(s : TimeseriesdecomphpLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_hp_layer_mean(s : TimeseriesdecomphpLayer) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_hp_layer_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_hp_layer_scale(s : TimeseriesdecomphpLayer, f : Double) -> TimeseriesdecomphpLayer {
  let result = timeseries_decomp_hp_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_hp_layer_add(a : TimeseriesdecomphpLayer, b : TimeseriesdecomphpLayer) -> TimeseriesdecomphpLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_hp_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_hp_layer_copy(s : TimeseriesdecomphpLayer) -> TimeseriesdecomphpLayer {
  let result = timeseries_decomp_hp_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_hp_layer_fill(s : TimeseriesdecomphpLayer, v : Double) -> TimeseriesdecomphpLayer {
  let result = timeseries_decomp_hp_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_hp_layer_min(s : TimeseriesdecomphpLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_hp_layer_max(s : TimeseriesdecomphpLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_hp_layer_to_string(s : TimeseriesdecomphpLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecomphpBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_hp_buffer_make(size : Int) -> TimeseriesdecomphpBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_hp_buffer_len(s : TimeseriesdecomphpBuffer) -> Int { s.size }

pub fn timeseries_decomp_hp_buffer_get(s : TimeseriesdecomphpBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_hp_buffer_set(s : TimeseriesdecomphpBuffer, i : Int, v : Double) -> TimeseriesdecomphpBuffer {
  let result = timeseries_decomp_hp_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_hp_buffer_sum(s : TimeseriesdecomphpBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_hp_buffer_mean(s : TimeseriesdecomphpBuffer) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_hp_buffer_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_hp_buffer_scale(s : TimeseriesdecomphpBuffer, f : Double) -> TimeseriesdecomphpBuffer {
  let result = timeseries_decomp_hp_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_hp_buffer_add(a : TimeseriesdecomphpBuffer, b : TimeseriesdecomphpBuffer) -> TimeseriesdecomphpBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_hp_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_hp_buffer_copy(s : TimeseriesdecomphpBuffer) -> TimeseriesdecomphpBuffer {
  let result = timeseries_decomp_hp_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_hp_buffer_fill(s : TimeseriesdecomphpBuffer, v : Double) -> TimeseriesdecomphpBuffer {
  let result = timeseries_decomp_hp_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_hp_buffer_min(s : TimeseriesdecomphpBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_hp_buffer_max(s : TimeseriesdecomphpBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_hp_buffer_to_string(s : TimeseriesdecomphpBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecomphpCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_hp_cursor_make(size : Int) -> TimeseriesdecomphpCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_hp_cursor_len(s : TimeseriesdecomphpCursor) -> Int { s.size }

pub fn timeseries_decomp_hp_cursor_get(s : TimeseriesdecomphpCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_hp_cursor_set(s : TimeseriesdecomphpCursor, i : Int, v : Double) -> TimeseriesdecomphpCursor {
  let result = timeseries_decomp_hp_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_hp_cursor_sum(s : TimeseriesdecomphpCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_hp_cursor_mean(s : TimeseriesdecomphpCursor) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_hp_cursor_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_hp_cursor_scale(s : TimeseriesdecomphpCursor, f : Double) -> TimeseriesdecomphpCursor {
  let result = timeseries_decomp_hp_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_hp_cursor_add(a : TimeseriesdecomphpCursor, b : TimeseriesdecomphpCursor) -> TimeseriesdecomphpCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_hp_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_hp_cursor_copy(s : TimeseriesdecomphpCursor) -> TimeseriesdecomphpCursor {
  let result = timeseries_decomp_hp_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_hp_cursor_fill(s : TimeseriesdecomphpCursor, v : Double) -> TimeseriesdecomphpCursor {
  let result = timeseries_decomp_hp_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_hp_cursor_min(s : TimeseriesdecomphpCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_hp_cursor_max(s : TimeseriesdecomphpCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_hp_cursor_to_string(s : TimeseriesdecomphpCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecomphpView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_hp_view_make(size : Int) -> TimeseriesdecomphpView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_hp_view_len(s : TimeseriesdecomphpView) -> Int { s.size }

pub fn timeseries_decomp_hp_view_get(s : TimeseriesdecomphpView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_hp_view_set(s : TimeseriesdecomphpView, i : Int, v : Double) -> TimeseriesdecomphpView {
  let result = timeseries_decomp_hp_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_hp_view_sum(s : TimeseriesdecomphpView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_hp_view_mean(s : TimeseriesdecomphpView) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_hp_view_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_hp_view_scale(s : TimeseriesdecomphpView, f : Double) -> TimeseriesdecomphpView {
  let result = timeseries_decomp_hp_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_hp_view_add(a : TimeseriesdecomphpView, b : TimeseriesdecomphpView) -> TimeseriesdecomphpView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_hp_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_hp_view_copy(s : TimeseriesdecomphpView) -> TimeseriesdecomphpView {
  let result = timeseries_decomp_hp_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_hp_view_fill(s : TimeseriesdecomphpView, v : Double) -> TimeseriesdecomphpView {
  let result = timeseries_decomp_hp_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_hp_view_min(s : TimeseriesdecomphpView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_hp_view_max(s : TimeseriesdecomphpView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_hp_view_to_string(s : TimeseriesdecomphpView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecomphpRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_hp_range_make(size : Int) -> TimeseriesdecomphpRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_hp_range_len(s : TimeseriesdecomphpRange) -> Int { s.size }

pub fn timeseries_decomp_hp_range_get(s : TimeseriesdecomphpRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_hp_range_set(s : TimeseriesdecomphpRange, i : Int, v : Double) -> TimeseriesdecomphpRange {
  let result = timeseries_decomp_hp_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_hp_range_sum(s : TimeseriesdecomphpRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_hp_range_mean(s : TimeseriesdecomphpRange) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_hp_range_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_hp_range_scale(s : TimeseriesdecomphpRange, f : Double) -> TimeseriesdecomphpRange {
  let result = timeseries_decomp_hp_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_hp_range_add(a : TimeseriesdecomphpRange, b : TimeseriesdecomphpRange) -> TimeseriesdecomphpRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_hp_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_hp_range_copy(s : TimeseriesdecomphpRange) -> TimeseriesdecomphpRange {
  let result = timeseries_decomp_hp_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_hp_range_fill(s : TimeseriesdecomphpRange, v : Double) -> TimeseriesdecomphpRange {
  let result = timeseries_decomp_hp_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_hp_range_min(s : TimeseriesdecomphpRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_hp_range_max(s : TimeseriesdecomphpRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_hp_range_to_string(s : TimeseriesdecomphpRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecomphpSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_hp_slice_make(size : Int) -> TimeseriesdecomphpSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_hp_slice_len(s : TimeseriesdecomphpSlice) -> Int { s.size }

pub fn timeseries_decomp_hp_slice_get(s : TimeseriesdecomphpSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_hp_slice_set(s : TimeseriesdecomphpSlice, i : Int, v : Double) -> TimeseriesdecomphpSlice {
  let result = timeseries_decomp_hp_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_hp_slice_sum(s : TimeseriesdecomphpSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_hp_slice_mean(s : TimeseriesdecomphpSlice) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_hp_slice_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_hp_slice_scale(s : TimeseriesdecomphpSlice, f : Double) -> TimeseriesdecomphpSlice {
  let result = timeseries_decomp_hp_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_hp_slice_add(a : TimeseriesdecomphpSlice, b : TimeseriesdecomphpSlice) -> TimeseriesdecomphpSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_hp_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_hp_slice_copy(s : TimeseriesdecomphpSlice) -> TimeseriesdecomphpSlice {
  let result = timeseries_decomp_hp_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_hp_slice_fill(s : TimeseriesdecomphpSlice, v : Double) -> TimeseriesdecomphpSlice {
  let result = timeseries_decomp_hp_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_hp_slice_min(s : TimeseriesdecomphpSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_hp_slice_max(s : TimeseriesdecomphpSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_hp_slice_to_string(s : TimeseriesdecomphpSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn timeseries_decomp_hp_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_decomp_hp_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_decomp_hp_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_decomp_hp_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_decomp_hp_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_decomp_hp_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_decomp_hp_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_decomp_hp_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_decomp_hp_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_decomp_hp_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_decomp_hp_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_decomp_hp_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_decomp_hp_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_decomp_hp_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_decomp_hp_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_decomp_hp_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_decomp_hp_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_decomp_hp_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_decomp_hp_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_decomp_hp_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_decomp_hp_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_decomp_hp_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_decomp_hp_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_decomp_hp_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_decomp_hp_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}


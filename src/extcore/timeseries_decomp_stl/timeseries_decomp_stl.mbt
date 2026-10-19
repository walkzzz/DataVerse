///===
/// extcore/timeseries_decomp_stl

pub(all) struct TimeseriesdecompstlPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_decomp_stl_make_point(x : Double, y : Double) -> TimeseriesdecompstlPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_decomp_stl_make_point3(x : Double, y : Double, z : Double) -> TimeseriesdecompstlPoint {
  { x, y, z, label: 0 }
}

pub fn timeseries_decomp_stl_point_x(pt : TimeseriesdecompstlPoint) -> Double { pt.x }

pub fn timeseries_decomp_stl_point_y(pt : TimeseriesdecompstlPoint) -> Double { pt.y }

pub fn timeseries_decomp_stl_point_z(pt : TimeseriesdecompstlPoint) -> Double { pt.z }

pub fn timeseries_decomp_stl_point_label(pt : TimeseriesdecompstlPoint) -> Int { pt.label }

pub fn timeseries_decomp_stl_point_dist(a : TimeseriesdecompstlPoint, b : TimeseriesdecompstlPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  timeseries_decomp_stl_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn timeseries_decomp_stl_point_add(a : TimeseriesdecompstlPoint, b : TimeseriesdecompstlPoint) -> TimeseriesdecompstlPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn timeseries_decomp_stl_point_sub(a : TimeseriesdecompstlPoint, b : TimeseriesdecompstlPoint) -> TimeseriesdecompstlPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn timeseries_decomp_stl_point_scale(pt : TimeseriesdecompstlPoint, s : Double) -> TimeseriesdecompstlPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn timeseries_decomp_stl_point_dot(a : TimeseriesdecompstlPoint, b : TimeseriesdecompstlPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn timeseries_decomp_stl_point_cross(a : TimeseriesdecompstlPoint, b : TimeseriesdecompstlPoint) -> TimeseriesdecompstlPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn timeseries_decomp_stl_point_norm(pt : TimeseriesdecompstlPoint) -> Double {
  timeseries_decomp_stl_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn timeseries_decomp_stl_point_normalize(pt : TimeseriesdecompstlPoint) -> TimeseriesdecompstlPoint {
  let n = timeseries_decomp_stl_point_norm(pt)
  if n < 0.0000001 { pt } else { timeseries_decomp_stl_point_scale(pt, 1.0 / n) }
}

pub fn timeseries_decomp_stl_point_negate(pt : TimeseriesdecompstlPoint) -> TimeseriesdecompstlPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn timeseries_decomp_stl_point_mid(a : TimeseriesdecompstlPoint, b : TimeseriesdecompstlPoint) -> TimeseriesdecompstlPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn timeseries_decomp_stl_point_lerp(a : TimeseriesdecompstlPoint, b : TimeseriesdecompstlPoint, t : Double) -> TimeseriesdecompstlPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn timeseries_decomp_stl_point_to_string(pt : TimeseriesdecompstlPoint) -> String {
  "(" + timeseries_decomp_stl_dbl(pt.x) + ", " + timeseries_decomp_stl_dbl(pt.y) + ", " + timeseries_decomp_stl_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct TimeseriesdecompstlSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_decomp_stl_make_series(vals : Array[Double], name : String) -> TimeseriesdecompstlSeries {
  { vals, name, meta: 0 }
}

pub fn timeseries_decomp_stl_series_len(s : TimeseriesdecompstlSeries) -> Int { s.vals.length() }

pub fn timeseries_decomp_stl_series_sum(s : TimeseriesdecompstlSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn timeseries_decomp_stl_series_mean(s : TimeseriesdecompstlSeries) -> Double {
  let n = timeseries_decomp_stl_series_len(s)
  if n == 0 { 0.0 } else { timeseries_decomp_stl_series_sum(s) / n.to_double() }
}

pub fn timeseries_decomp_stl_series_min(s : TimeseriesdecompstlSeries) -> Double {
  let n = timeseries_decomp_stl_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn timeseries_decomp_stl_series_max(s : TimeseriesdecompstlSeries) -> Double {
  let n = timeseries_decomp_stl_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn timeseries_decomp_stl_series_range(s : TimeseriesdecompstlSeries) -> Double {
  timeseries_decomp_stl_series_max(s) - timeseries_decomp_stl_series_min(s)
}

pub fn timeseries_decomp_stl_series_var(s : TimeseriesdecompstlSeries) -> Double {
  let n = timeseries_decomp_stl_series_len(s)
  if n == 0 { 0.0 } else {
    let m = timeseries_decomp_stl_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn timeseries_decomp_stl_series_std(s : TimeseriesdecompstlSeries) -> Double { timeseries_decomp_stl_sqrt(timeseries_decomp_stl_series_var(s)) }

pub fn timeseries_decomp_stl_series_median(s : TimeseriesdecompstlSeries) -> Double {
  let n = timeseries_decomp_stl_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = timeseries_decomp_stl_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn timeseries_decomp_stl_series_scale(s : TimeseriesdecompstlSeries, f : Double) -> TimeseriesdecompstlSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = timeseries_decomp_stl_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn timeseries_decomp_stl_series_add(a : TimeseriesdecompstlSeries, b : TimeseriesdecompstlSeries) -> TimeseriesdecompstlSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = timeseries_decomp_stl_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn timeseries_decomp_stl_series_sub(a : TimeseriesdecompstlSeries, b : TimeseriesdecompstlSeries) -> TimeseriesdecompstlSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = timeseries_decomp_stl_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn timeseries_decomp_stl_series_normalize(s : TimeseriesdecompstlSeries) -> TimeseriesdecompstlSeries {
  let mn = timeseries_decomp_stl_series_min(s)
  let mx = timeseries_decomp_stl_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = timeseries_decomp_stl_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn timeseries_decomp_stl_series_cumsum(s : TimeseriesdecompstlSeries) -> TimeseriesdecompstlSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = timeseries_decomp_stl_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn timeseries_decomp_stl_series_to_string(s : TimeseriesdecompstlSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + timeseries_decomp_stl_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesdecompstlMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_decomp_stl_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriesdecompstlMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn timeseries_decomp_stl_matrix_identity(n : Int) -> TimeseriesdecompstlMatrix {
  let m = timeseries_decomp_stl_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn timeseries_decomp_stl_matrix_get(m : TimeseriesdecompstlMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn timeseries_decomp_stl_matrix_transpose(m : TimeseriesdecompstlMatrix) -> TimeseriesdecompstlMatrix {
  let result = timeseries_decomp_stl_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn timeseries_decomp_stl_matrix_add(a : TimeseriesdecompstlMatrix, b : TimeseriesdecompstlMatrix) -> TimeseriesdecompstlMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = timeseries_decomp_stl_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn timeseries_decomp_stl_matrix_scale(m : TimeseriesdecompstlMatrix, s : Double) -> TimeseriesdecompstlMatrix {
  let result = timeseries_decomp_stl_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn timeseries_decomp_stl_matrix_multiply(a : TimeseriesdecompstlMatrix, b : TimeseriesdecompstlMatrix) -> TimeseriesdecompstlMatrix {
  if a.cols != b.rows { return timeseries_decomp_stl_make_matrix(a.rows, b.cols, 0.0) }
  let result = timeseries_decomp_stl_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn timeseries_decomp_stl_matrix_trace(m : TimeseriesdecompstlMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn timeseries_decomp_stl_matrix_det(m : TimeseriesdecompstlMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn timeseries_decomp_stl_matrix_norm(m : TimeseriesdecompstlMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  timeseries_decomp_stl_sqrt(sum)
}

pub fn timeseries_decomp_stl_matrix_to_string(m : TimeseriesdecompstlMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + timeseries_decomp_stl_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct TimeseriesdecompstlVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_decomp_stl_make_vector(comps : Array[Double]) -> TimeseriesdecompstlVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_decomp_stl_vector_zero(dim : Int) -> TimeseriesdecompstlVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn timeseries_decomp_stl_vector_add(a : TimeseriesdecompstlVector, b : TimeseriesdecompstlVector) -> TimeseriesdecompstlVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = timeseries_decomp_stl_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn timeseries_decomp_stl_vector_sub(a : TimeseriesdecompstlVector, b : TimeseriesdecompstlVector) -> TimeseriesdecompstlVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = timeseries_decomp_stl_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn timeseries_decomp_stl_vector_scale(v : TimeseriesdecompstlVector, s : Double) -> TimeseriesdecompstlVector {
  let mut result = []
  for i in 0..<v.dim { result = timeseries_decomp_stl_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn timeseries_decomp_stl_vector_dot(a : TimeseriesdecompstlVector, b : TimeseriesdecompstlVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn timeseries_decomp_stl_vector_norm(v : TimeseriesdecompstlVector) -> Double { timeseries_decomp_stl_sqrt(timeseries_decomp_stl_vector_dot(v, v)) }

pub fn timeseries_decomp_stl_vector_normalize(v : TimeseriesdecompstlVector) -> TimeseriesdecompstlVector {
  let n = timeseries_decomp_stl_vector_norm(v)
  if n < 0.0000001 { v } else { timeseries_decomp_stl_vector_scale(v, 1.0 / n) }
}

pub fn timeseries_decomp_stl_vector_dist(a : TimeseriesdecompstlVector, b : TimeseriesdecompstlVector) -> Double {
  timeseries_decomp_stl_vector_norm(timeseries_decomp_stl_vector_sub(a, b))
}

pub fn timeseries_decomp_stl_vector_to_string(v : TimeseriesdecompstlVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + timeseries_decomp_stl_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn timeseries_decomp_stl_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn timeseries_decomp_stl_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = timeseries_decomp_stl_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn timeseries_decomp_stl_std(data : Array[Double]) -> Double { timeseries_decomp_stl_sqrt(timeseries_decomp_stl_var(data)) }

pub fn timeseries_decomp_stl_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = timeseries_decomp_stl_mean(a); let mb = timeseries_decomp_stl_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn timeseries_decomp_stl_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = timeseries_decomp_stl_std(a); let sb = timeseries_decomp_stl_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { timeseries_decomp_stl_cov(a, b) / (sa * sb) }
}

pub fn timeseries_decomp_stl_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = timeseries_decomp_stl_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn timeseries_decomp_stl_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn timeseries_decomp_stl_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn timeseries_decomp_stl_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  timeseries_decomp_stl_sqrt(timeseries_decomp_stl_mse(pred, labels))
}

pub fn timeseries_decomp_stl_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + timeseries_decomp_stl_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn timeseries_decomp_stl_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = timeseries_decomp_stl_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn timeseries_decomp_stl_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn timeseries_decomp_stl_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn timeseries_decomp_stl_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = timeseries_decomp_stl_precision(pred, labels, pos); let r = timeseries_decomp_stl_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn timeseries_decomp_stl_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn timeseries_decomp_stl_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = timeseries_decomp_stl_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn timeseries_decomp_stl_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn timeseries_decomp_stl_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn timeseries_decomp_stl_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = timeseries_decomp_stl_gcd(a, b)
    (a / g) * b
  }
}

pub fn timeseries_decomp_stl_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn timeseries_decomp_stl_fibonacci(n : Int) -> Int {
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

pub fn timeseries_decomp_stl_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = timeseries_decomp_stl_min(data); let mx = timeseries_decomp_stl_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn timeseries_decomp_stl_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = timeseries_decomp_stl_mean(data); let sd = timeseries_decomp_stl_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn timeseries_decomp_stl_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn timeseries_decomp_stl_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn timeseries_decomp_stl_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn timeseries_decomp_stl_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn timeseries_decomp_stl_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn timeseries_decomp_stl_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn timeseries_decomp_stl_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn timeseries_decomp_stl_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn timeseries_decomp_stl_dbl(x : Double) -> String {
  let i = if x >= 0.0 { timeseries_decomp_stl_int(x) } else { -timeseries_decomp_stl_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { timeseries_decomp_stl_int(f * 1000000.0) } else { timeseries_decomp_stl_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn timeseries_decomp_stl_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn timeseries_decomp_stl_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct TimeseriesdecompstlFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_stl_frame_make(size : Int) -> TimeseriesdecompstlFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_stl_frame_len(s : TimeseriesdecompstlFrame) -> Int { s.size }

pub fn timeseries_decomp_stl_frame_get(s : TimeseriesdecompstlFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_stl_frame_set(s : TimeseriesdecompstlFrame, i : Int, v : Double) -> TimeseriesdecompstlFrame {
  let result = timeseries_decomp_stl_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_stl_frame_sum(s : TimeseriesdecompstlFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_stl_frame_mean(s : TimeseriesdecompstlFrame) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_stl_frame_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_stl_frame_scale(s : TimeseriesdecompstlFrame, f : Double) -> TimeseriesdecompstlFrame {
  let result = timeseries_decomp_stl_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_stl_frame_add(a : TimeseriesdecompstlFrame, b : TimeseriesdecompstlFrame) -> TimeseriesdecompstlFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_stl_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_stl_frame_copy(s : TimeseriesdecompstlFrame) -> TimeseriesdecompstlFrame {
  let result = timeseries_decomp_stl_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_stl_frame_fill(s : TimeseriesdecompstlFrame, v : Double) -> TimeseriesdecompstlFrame {
  let result = timeseries_decomp_stl_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_stl_frame_min(s : TimeseriesdecompstlFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_stl_frame_max(s : TimeseriesdecompstlFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_stl_frame_to_string(s : TimeseriesdecompstlFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompstlTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_stl_table_make(size : Int) -> TimeseriesdecompstlTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_stl_table_len(s : TimeseriesdecompstlTable) -> Int { s.size }

pub fn timeseries_decomp_stl_table_get(s : TimeseriesdecompstlTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_stl_table_set(s : TimeseriesdecompstlTable, i : Int, v : Double) -> TimeseriesdecompstlTable {
  let result = timeseries_decomp_stl_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_stl_table_sum(s : TimeseriesdecompstlTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_stl_table_mean(s : TimeseriesdecompstlTable) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_stl_table_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_stl_table_scale(s : TimeseriesdecompstlTable, f : Double) -> TimeseriesdecompstlTable {
  let result = timeseries_decomp_stl_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_stl_table_add(a : TimeseriesdecompstlTable, b : TimeseriesdecompstlTable) -> TimeseriesdecompstlTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_stl_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_stl_table_copy(s : TimeseriesdecompstlTable) -> TimeseriesdecompstlTable {
  let result = timeseries_decomp_stl_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_stl_table_fill(s : TimeseriesdecompstlTable, v : Double) -> TimeseriesdecompstlTable {
  let result = timeseries_decomp_stl_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_stl_table_min(s : TimeseriesdecompstlTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_stl_table_max(s : TimeseriesdecompstlTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_stl_table_to_string(s : TimeseriesdecompstlTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompstlGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_stl_graphn_make(size : Int) -> TimeseriesdecompstlGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_stl_graphn_len(s : TimeseriesdecompstlGraphN) -> Int { s.size }

pub fn timeseries_decomp_stl_graphn_get(s : TimeseriesdecompstlGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_stl_graphn_set(s : TimeseriesdecompstlGraphN, i : Int, v : Double) -> TimeseriesdecompstlGraphN {
  let result = timeseries_decomp_stl_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_stl_graphn_sum(s : TimeseriesdecompstlGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_stl_graphn_mean(s : TimeseriesdecompstlGraphN) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_stl_graphn_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_stl_graphn_scale(s : TimeseriesdecompstlGraphN, f : Double) -> TimeseriesdecompstlGraphN {
  let result = timeseries_decomp_stl_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_stl_graphn_add(a : TimeseriesdecompstlGraphN, b : TimeseriesdecompstlGraphN) -> TimeseriesdecompstlGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_stl_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_stl_graphn_copy(s : TimeseriesdecompstlGraphN) -> TimeseriesdecompstlGraphN {
  let result = timeseries_decomp_stl_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_stl_graphn_fill(s : TimeseriesdecompstlGraphN, v : Double) -> TimeseriesdecompstlGraphN {
  let result = timeseries_decomp_stl_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_stl_graphn_min(s : TimeseriesdecompstlGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_stl_graphn_max(s : TimeseriesdecompstlGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_stl_graphn_to_string(s : TimeseriesdecompstlGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompstlNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_stl_node_make(size : Int) -> TimeseriesdecompstlNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_stl_node_len(s : TimeseriesdecompstlNode) -> Int { s.size }

pub fn timeseries_decomp_stl_node_get(s : TimeseriesdecompstlNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_stl_node_set(s : TimeseriesdecompstlNode, i : Int, v : Double) -> TimeseriesdecompstlNode {
  let result = timeseries_decomp_stl_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_stl_node_sum(s : TimeseriesdecompstlNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_stl_node_mean(s : TimeseriesdecompstlNode) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_stl_node_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_stl_node_scale(s : TimeseriesdecompstlNode, f : Double) -> TimeseriesdecompstlNode {
  let result = timeseries_decomp_stl_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_stl_node_add(a : TimeseriesdecompstlNode, b : TimeseriesdecompstlNode) -> TimeseriesdecompstlNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_stl_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_stl_node_copy(s : TimeseriesdecompstlNode) -> TimeseriesdecompstlNode {
  let result = timeseries_decomp_stl_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_stl_node_fill(s : TimeseriesdecompstlNode, v : Double) -> TimeseriesdecompstlNode {
  let result = timeseries_decomp_stl_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_stl_node_min(s : TimeseriesdecompstlNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_stl_node_max(s : TimeseriesdecompstlNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_stl_node_to_string(s : TimeseriesdecompstlNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompstlEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_stl_edge_make(size : Int) -> TimeseriesdecompstlEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_stl_edge_len(s : TimeseriesdecompstlEdge) -> Int { s.size }

pub fn timeseries_decomp_stl_edge_get(s : TimeseriesdecompstlEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_stl_edge_set(s : TimeseriesdecompstlEdge, i : Int, v : Double) -> TimeseriesdecompstlEdge {
  let result = timeseries_decomp_stl_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_stl_edge_sum(s : TimeseriesdecompstlEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_stl_edge_mean(s : TimeseriesdecompstlEdge) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_stl_edge_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_stl_edge_scale(s : TimeseriesdecompstlEdge, f : Double) -> TimeseriesdecompstlEdge {
  let result = timeseries_decomp_stl_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_stl_edge_add(a : TimeseriesdecompstlEdge, b : TimeseriesdecompstlEdge) -> TimeseriesdecompstlEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_stl_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_stl_edge_copy(s : TimeseriesdecompstlEdge) -> TimeseriesdecompstlEdge {
  let result = timeseries_decomp_stl_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_stl_edge_fill(s : TimeseriesdecompstlEdge, v : Double) -> TimeseriesdecompstlEdge {
  let result = timeseries_decomp_stl_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_stl_edge_min(s : TimeseriesdecompstlEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_stl_edge_max(s : TimeseriesdecompstlEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_stl_edge_to_string(s : TimeseriesdecompstlEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompstlPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_stl_path_make(size : Int) -> TimeseriesdecompstlPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_stl_path_len(s : TimeseriesdecompstlPath) -> Int { s.size }

pub fn timeseries_decomp_stl_path_get(s : TimeseriesdecompstlPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_stl_path_set(s : TimeseriesdecompstlPath, i : Int, v : Double) -> TimeseriesdecompstlPath {
  let result = timeseries_decomp_stl_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_stl_path_sum(s : TimeseriesdecompstlPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_stl_path_mean(s : TimeseriesdecompstlPath) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_stl_path_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_stl_path_scale(s : TimeseriesdecompstlPath, f : Double) -> TimeseriesdecompstlPath {
  let result = timeseries_decomp_stl_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_stl_path_add(a : TimeseriesdecompstlPath, b : TimeseriesdecompstlPath) -> TimeseriesdecompstlPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_stl_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_stl_path_copy(s : TimeseriesdecompstlPath) -> TimeseriesdecompstlPath {
  let result = timeseries_decomp_stl_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_stl_path_fill(s : TimeseriesdecompstlPath, v : Double) -> TimeseriesdecompstlPath {
  let result = timeseries_decomp_stl_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_stl_path_min(s : TimeseriesdecompstlPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_stl_path_max(s : TimeseriesdecompstlPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_stl_path_to_string(s : TimeseriesdecompstlPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompstlCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_stl_cluster_make(size : Int) -> TimeseriesdecompstlCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_stl_cluster_len(s : TimeseriesdecompstlCluster) -> Int { s.size }

pub fn timeseries_decomp_stl_cluster_get(s : TimeseriesdecompstlCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_stl_cluster_set(s : TimeseriesdecompstlCluster, i : Int, v : Double) -> TimeseriesdecompstlCluster {
  let result = timeseries_decomp_stl_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_stl_cluster_sum(s : TimeseriesdecompstlCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_stl_cluster_mean(s : TimeseriesdecompstlCluster) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_stl_cluster_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_stl_cluster_scale(s : TimeseriesdecompstlCluster, f : Double) -> TimeseriesdecompstlCluster {
  let result = timeseries_decomp_stl_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_stl_cluster_add(a : TimeseriesdecompstlCluster, b : TimeseriesdecompstlCluster) -> TimeseriesdecompstlCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_stl_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_stl_cluster_copy(s : TimeseriesdecompstlCluster) -> TimeseriesdecompstlCluster {
  let result = timeseries_decomp_stl_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_stl_cluster_fill(s : TimeseriesdecompstlCluster, v : Double) -> TimeseriesdecompstlCluster {
  let result = timeseries_decomp_stl_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_stl_cluster_min(s : TimeseriesdecompstlCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_stl_cluster_max(s : TimeseriesdecompstlCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_stl_cluster_to_string(s : TimeseriesdecompstlCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompstlModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_stl_model_make(size : Int) -> TimeseriesdecompstlModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_stl_model_len(s : TimeseriesdecompstlModel) -> Int { s.size }

pub fn timeseries_decomp_stl_model_get(s : TimeseriesdecompstlModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_stl_model_set(s : TimeseriesdecompstlModel, i : Int, v : Double) -> TimeseriesdecompstlModel {
  let result = timeseries_decomp_stl_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_stl_model_sum(s : TimeseriesdecompstlModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_stl_model_mean(s : TimeseriesdecompstlModel) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_stl_model_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_stl_model_scale(s : TimeseriesdecompstlModel, f : Double) -> TimeseriesdecompstlModel {
  let result = timeseries_decomp_stl_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_stl_model_add(a : TimeseriesdecompstlModel, b : TimeseriesdecompstlModel) -> TimeseriesdecompstlModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_stl_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_stl_model_copy(s : TimeseriesdecompstlModel) -> TimeseriesdecompstlModel {
  let result = timeseries_decomp_stl_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_stl_model_fill(s : TimeseriesdecompstlModel, v : Double) -> TimeseriesdecompstlModel {
  let result = timeseries_decomp_stl_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_stl_model_min(s : TimeseriesdecompstlModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_stl_model_max(s : TimeseriesdecompstlModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_stl_model_to_string(s : TimeseriesdecompstlModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompstlLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_stl_layer_make(size : Int) -> TimeseriesdecompstlLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_stl_layer_len(s : TimeseriesdecompstlLayer) -> Int { s.size }

pub fn timeseries_decomp_stl_layer_get(s : TimeseriesdecompstlLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_stl_layer_set(s : TimeseriesdecompstlLayer, i : Int, v : Double) -> TimeseriesdecompstlLayer {
  let result = timeseries_decomp_stl_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_stl_layer_sum(s : TimeseriesdecompstlLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_stl_layer_mean(s : TimeseriesdecompstlLayer) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_stl_layer_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_stl_layer_scale(s : TimeseriesdecompstlLayer, f : Double) -> TimeseriesdecompstlLayer {
  let result = timeseries_decomp_stl_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_stl_layer_add(a : TimeseriesdecompstlLayer, b : TimeseriesdecompstlLayer) -> TimeseriesdecompstlLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_stl_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_stl_layer_copy(s : TimeseriesdecompstlLayer) -> TimeseriesdecompstlLayer {
  let result = timeseries_decomp_stl_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_stl_layer_fill(s : TimeseriesdecompstlLayer, v : Double) -> TimeseriesdecompstlLayer {
  let result = timeseries_decomp_stl_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_stl_layer_min(s : TimeseriesdecompstlLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_stl_layer_max(s : TimeseriesdecompstlLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_stl_layer_to_string(s : TimeseriesdecompstlLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompstlBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_stl_buffer_make(size : Int) -> TimeseriesdecompstlBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_stl_buffer_len(s : TimeseriesdecompstlBuffer) -> Int { s.size }

pub fn timeseries_decomp_stl_buffer_get(s : TimeseriesdecompstlBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_stl_buffer_set(s : TimeseriesdecompstlBuffer, i : Int, v : Double) -> TimeseriesdecompstlBuffer {
  let result = timeseries_decomp_stl_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_stl_buffer_sum(s : TimeseriesdecompstlBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_stl_buffer_mean(s : TimeseriesdecompstlBuffer) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_stl_buffer_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_stl_buffer_scale(s : TimeseriesdecompstlBuffer, f : Double) -> TimeseriesdecompstlBuffer {
  let result = timeseries_decomp_stl_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_stl_buffer_add(a : TimeseriesdecompstlBuffer, b : TimeseriesdecompstlBuffer) -> TimeseriesdecompstlBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_stl_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_stl_buffer_copy(s : TimeseriesdecompstlBuffer) -> TimeseriesdecompstlBuffer {
  let result = timeseries_decomp_stl_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_stl_buffer_fill(s : TimeseriesdecompstlBuffer, v : Double) -> TimeseriesdecompstlBuffer {
  let result = timeseries_decomp_stl_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_stl_buffer_min(s : TimeseriesdecompstlBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_stl_buffer_max(s : TimeseriesdecompstlBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_stl_buffer_to_string(s : TimeseriesdecompstlBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompstlCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_stl_cursor_make(size : Int) -> TimeseriesdecompstlCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_stl_cursor_len(s : TimeseriesdecompstlCursor) -> Int { s.size }

pub fn timeseries_decomp_stl_cursor_get(s : TimeseriesdecompstlCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_stl_cursor_set(s : TimeseriesdecompstlCursor, i : Int, v : Double) -> TimeseriesdecompstlCursor {
  let result = timeseries_decomp_stl_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_stl_cursor_sum(s : TimeseriesdecompstlCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_stl_cursor_mean(s : TimeseriesdecompstlCursor) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_stl_cursor_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_stl_cursor_scale(s : TimeseriesdecompstlCursor, f : Double) -> TimeseriesdecompstlCursor {
  let result = timeseries_decomp_stl_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_stl_cursor_add(a : TimeseriesdecompstlCursor, b : TimeseriesdecompstlCursor) -> TimeseriesdecompstlCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_stl_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_stl_cursor_copy(s : TimeseriesdecompstlCursor) -> TimeseriesdecompstlCursor {
  let result = timeseries_decomp_stl_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_stl_cursor_fill(s : TimeseriesdecompstlCursor, v : Double) -> TimeseriesdecompstlCursor {
  let result = timeseries_decomp_stl_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_stl_cursor_min(s : TimeseriesdecompstlCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_stl_cursor_max(s : TimeseriesdecompstlCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_stl_cursor_to_string(s : TimeseriesdecompstlCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompstlView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_stl_view_make(size : Int) -> TimeseriesdecompstlView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_stl_view_len(s : TimeseriesdecompstlView) -> Int { s.size }

pub fn timeseries_decomp_stl_view_get(s : TimeseriesdecompstlView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_stl_view_set(s : TimeseriesdecompstlView, i : Int, v : Double) -> TimeseriesdecompstlView {
  let result = timeseries_decomp_stl_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_stl_view_sum(s : TimeseriesdecompstlView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_stl_view_mean(s : TimeseriesdecompstlView) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_stl_view_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_stl_view_scale(s : TimeseriesdecompstlView, f : Double) -> TimeseriesdecompstlView {
  let result = timeseries_decomp_stl_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_stl_view_add(a : TimeseriesdecompstlView, b : TimeseriesdecompstlView) -> TimeseriesdecompstlView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_stl_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_stl_view_copy(s : TimeseriesdecompstlView) -> TimeseriesdecompstlView {
  let result = timeseries_decomp_stl_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_stl_view_fill(s : TimeseriesdecompstlView, v : Double) -> TimeseriesdecompstlView {
  let result = timeseries_decomp_stl_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_stl_view_min(s : TimeseriesdecompstlView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_stl_view_max(s : TimeseriesdecompstlView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_stl_view_to_string(s : TimeseriesdecompstlView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompstlRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_stl_range_make(size : Int) -> TimeseriesdecompstlRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_stl_range_len(s : TimeseriesdecompstlRange) -> Int { s.size }

pub fn timeseries_decomp_stl_range_get(s : TimeseriesdecompstlRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_stl_range_set(s : TimeseriesdecompstlRange, i : Int, v : Double) -> TimeseriesdecompstlRange {
  let result = timeseries_decomp_stl_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_stl_range_sum(s : TimeseriesdecompstlRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_stl_range_mean(s : TimeseriesdecompstlRange) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_stl_range_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_stl_range_scale(s : TimeseriesdecompstlRange, f : Double) -> TimeseriesdecompstlRange {
  let result = timeseries_decomp_stl_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_stl_range_add(a : TimeseriesdecompstlRange, b : TimeseriesdecompstlRange) -> TimeseriesdecompstlRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_stl_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_stl_range_copy(s : TimeseriesdecompstlRange) -> TimeseriesdecompstlRange {
  let result = timeseries_decomp_stl_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_stl_range_fill(s : TimeseriesdecompstlRange, v : Double) -> TimeseriesdecompstlRange {
  let result = timeseries_decomp_stl_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_stl_range_min(s : TimeseriesdecompstlRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_stl_range_max(s : TimeseriesdecompstlRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_stl_range_to_string(s : TimeseriesdecompstlRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompstlSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_stl_slice_make(size : Int) -> TimeseriesdecompstlSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_stl_slice_len(s : TimeseriesdecompstlSlice) -> Int { s.size }

pub fn timeseries_decomp_stl_slice_get(s : TimeseriesdecompstlSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_stl_slice_set(s : TimeseriesdecompstlSlice, i : Int, v : Double) -> TimeseriesdecompstlSlice {
  let result = timeseries_decomp_stl_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_stl_slice_sum(s : TimeseriesdecompstlSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_stl_slice_mean(s : TimeseriesdecompstlSlice) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_stl_slice_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_stl_slice_scale(s : TimeseriesdecompstlSlice, f : Double) -> TimeseriesdecompstlSlice {
  let result = timeseries_decomp_stl_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_stl_slice_add(a : TimeseriesdecompstlSlice, b : TimeseriesdecompstlSlice) -> TimeseriesdecompstlSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_stl_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_stl_slice_copy(s : TimeseriesdecompstlSlice) -> TimeseriesdecompstlSlice {
  let result = timeseries_decomp_stl_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_stl_slice_fill(s : TimeseriesdecompstlSlice, v : Double) -> TimeseriesdecompstlSlice {
  let result = timeseries_decomp_stl_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_stl_slice_min(s : TimeseriesdecompstlSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_stl_slice_max(s : TimeseriesdecompstlSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_stl_slice_to_string(s : TimeseriesdecompstlSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn timeseries_decomp_stl_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_decomp_stl_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_decomp_stl_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_decomp_stl_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_decomp_stl_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_decomp_stl_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_decomp_stl_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_decomp_stl_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_decomp_stl_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_decomp_stl_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_decomp_stl_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_decomp_stl_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_decomp_stl_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_decomp_stl_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_decomp_stl_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_decomp_stl_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_decomp_stl_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_decomp_stl_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_decomp_stl_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_decomp_stl_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_decomp_stl_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_decomp_stl_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_decomp_stl_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_decomp_stl_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_decomp_stl_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}


///===
/// extcore/timeseries_decomp_emd

pub(all) struct TimeseriesdecompemdPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_decomp_emd_make_point(x : Double, y : Double) -> TimeseriesdecompemdPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_decomp_emd_make_point3(x : Double, y : Double, z : Double) -> TimeseriesdecompemdPoint {
  { x, y, z, label: 0 }
}

pub fn timeseries_decomp_emd_point_x(pt : TimeseriesdecompemdPoint) -> Double { pt.x }

pub fn timeseries_decomp_emd_point_y(pt : TimeseriesdecompemdPoint) -> Double { pt.y }

pub fn timeseries_decomp_emd_point_z(pt : TimeseriesdecompemdPoint) -> Double { pt.z }

pub fn timeseries_decomp_emd_point_label(pt : TimeseriesdecompemdPoint) -> Int { pt.label }

pub fn timeseries_decomp_emd_point_dist(a : TimeseriesdecompemdPoint, b : TimeseriesdecompemdPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  timeseries_decomp_emd_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn timeseries_decomp_emd_point_add(a : TimeseriesdecompemdPoint, b : TimeseriesdecompemdPoint) -> TimeseriesdecompemdPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn timeseries_decomp_emd_point_sub(a : TimeseriesdecompemdPoint, b : TimeseriesdecompemdPoint) -> TimeseriesdecompemdPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn timeseries_decomp_emd_point_scale(pt : TimeseriesdecompemdPoint, s : Double) -> TimeseriesdecompemdPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn timeseries_decomp_emd_point_dot(a : TimeseriesdecompemdPoint, b : TimeseriesdecompemdPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn timeseries_decomp_emd_point_cross(a : TimeseriesdecompemdPoint, b : TimeseriesdecompemdPoint) -> TimeseriesdecompemdPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn timeseries_decomp_emd_point_norm(pt : TimeseriesdecompemdPoint) -> Double {
  timeseries_decomp_emd_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn timeseries_decomp_emd_point_normalize(pt : TimeseriesdecompemdPoint) -> TimeseriesdecompemdPoint {
  let n = timeseries_decomp_emd_point_norm(pt)
  if n < 0.0000001 { pt } else { timeseries_decomp_emd_point_scale(pt, 1.0 / n) }
}

pub fn timeseries_decomp_emd_point_negate(pt : TimeseriesdecompemdPoint) -> TimeseriesdecompemdPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn timeseries_decomp_emd_point_mid(a : TimeseriesdecompemdPoint, b : TimeseriesdecompemdPoint) -> TimeseriesdecompemdPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn timeseries_decomp_emd_point_lerp(a : TimeseriesdecompemdPoint, b : TimeseriesdecompemdPoint, t : Double) -> TimeseriesdecompemdPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn timeseries_decomp_emd_point_to_string(pt : TimeseriesdecompemdPoint) -> String {
  "(" + timeseries_decomp_emd_dbl(pt.x) + ", " + timeseries_decomp_emd_dbl(pt.y) + ", " + timeseries_decomp_emd_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct TimeseriesdecompemdSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_decomp_emd_make_series(vals : Array[Double], name : String) -> TimeseriesdecompemdSeries {
  { vals, name, meta: 0 }
}

pub fn timeseries_decomp_emd_series_len(s : TimeseriesdecompemdSeries) -> Int { s.vals.length() }

pub fn timeseries_decomp_emd_series_sum(s : TimeseriesdecompemdSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn timeseries_decomp_emd_series_mean(s : TimeseriesdecompemdSeries) -> Double {
  let n = timeseries_decomp_emd_series_len(s)
  if n == 0 { 0.0 } else { timeseries_decomp_emd_series_sum(s) / n.to_double() }
}

pub fn timeseries_decomp_emd_series_min(s : TimeseriesdecompemdSeries) -> Double {
  let n = timeseries_decomp_emd_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn timeseries_decomp_emd_series_max(s : TimeseriesdecompemdSeries) -> Double {
  let n = timeseries_decomp_emd_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn timeseries_decomp_emd_series_range(s : TimeseriesdecompemdSeries) -> Double {
  timeseries_decomp_emd_series_max(s) - timeseries_decomp_emd_series_min(s)
}

pub fn timeseries_decomp_emd_series_var(s : TimeseriesdecompemdSeries) -> Double {
  let n = timeseries_decomp_emd_series_len(s)
  if n == 0 { 0.0 } else {
    let m = timeseries_decomp_emd_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn timeseries_decomp_emd_series_std(s : TimeseriesdecompemdSeries) -> Double { timeseries_decomp_emd_sqrt(timeseries_decomp_emd_series_var(s)) }

pub fn timeseries_decomp_emd_series_median(s : TimeseriesdecompemdSeries) -> Double {
  let n = timeseries_decomp_emd_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = timeseries_decomp_emd_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn timeseries_decomp_emd_series_scale(s : TimeseriesdecompemdSeries, f : Double) -> TimeseriesdecompemdSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = timeseries_decomp_emd_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn timeseries_decomp_emd_series_add(a : TimeseriesdecompemdSeries, b : TimeseriesdecompemdSeries) -> TimeseriesdecompemdSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = timeseries_decomp_emd_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn timeseries_decomp_emd_series_sub(a : TimeseriesdecompemdSeries, b : TimeseriesdecompemdSeries) -> TimeseriesdecompemdSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = timeseries_decomp_emd_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn timeseries_decomp_emd_series_normalize(s : TimeseriesdecompemdSeries) -> TimeseriesdecompemdSeries {
  let mn = timeseries_decomp_emd_series_min(s)
  let mx = timeseries_decomp_emd_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = timeseries_decomp_emd_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn timeseries_decomp_emd_series_cumsum(s : TimeseriesdecompemdSeries) -> TimeseriesdecompemdSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = timeseries_decomp_emd_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn timeseries_decomp_emd_series_to_string(s : TimeseriesdecompemdSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + timeseries_decomp_emd_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesdecompemdMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_decomp_emd_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriesdecompemdMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn timeseries_decomp_emd_matrix_identity(n : Int) -> TimeseriesdecompemdMatrix {
  let m = timeseries_decomp_emd_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn timeseries_decomp_emd_matrix_get(m : TimeseriesdecompemdMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn timeseries_decomp_emd_matrix_transpose(m : TimeseriesdecompemdMatrix) -> TimeseriesdecompemdMatrix {
  let result = timeseries_decomp_emd_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn timeseries_decomp_emd_matrix_add(a : TimeseriesdecompemdMatrix, b : TimeseriesdecompemdMatrix) -> TimeseriesdecompemdMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = timeseries_decomp_emd_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn timeseries_decomp_emd_matrix_scale(m : TimeseriesdecompemdMatrix, s : Double) -> TimeseriesdecompemdMatrix {
  let result = timeseries_decomp_emd_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn timeseries_decomp_emd_matrix_multiply(a : TimeseriesdecompemdMatrix, b : TimeseriesdecompemdMatrix) -> TimeseriesdecompemdMatrix {
  if a.cols != b.rows { return timeseries_decomp_emd_make_matrix(a.rows, b.cols, 0.0) }
  let result = timeseries_decomp_emd_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn timeseries_decomp_emd_matrix_trace(m : TimeseriesdecompemdMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn timeseries_decomp_emd_matrix_det(m : TimeseriesdecompemdMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn timeseries_decomp_emd_matrix_norm(m : TimeseriesdecompemdMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  timeseries_decomp_emd_sqrt(sum)
}

pub fn timeseries_decomp_emd_matrix_to_string(m : TimeseriesdecompemdMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + timeseries_decomp_emd_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct TimeseriesdecompemdVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_decomp_emd_make_vector(comps : Array[Double]) -> TimeseriesdecompemdVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_decomp_emd_vector_zero(dim : Int) -> TimeseriesdecompemdVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn timeseries_decomp_emd_vector_add(a : TimeseriesdecompemdVector, b : TimeseriesdecompemdVector) -> TimeseriesdecompemdVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = timeseries_decomp_emd_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn timeseries_decomp_emd_vector_sub(a : TimeseriesdecompemdVector, b : TimeseriesdecompemdVector) -> TimeseriesdecompemdVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = timeseries_decomp_emd_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn timeseries_decomp_emd_vector_scale(v : TimeseriesdecompemdVector, s : Double) -> TimeseriesdecompemdVector {
  let mut result = []
  for i in 0..<v.dim { result = timeseries_decomp_emd_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn timeseries_decomp_emd_vector_dot(a : TimeseriesdecompemdVector, b : TimeseriesdecompemdVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn timeseries_decomp_emd_vector_norm(v : TimeseriesdecompemdVector) -> Double { timeseries_decomp_emd_sqrt(timeseries_decomp_emd_vector_dot(v, v)) }

pub fn timeseries_decomp_emd_vector_normalize(v : TimeseriesdecompemdVector) -> TimeseriesdecompemdVector {
  let n = timeseries_decomp_emd_vector_norm(v)
  if n < 0.0000001 { v } else { timeseries_decomp_emd_vector_scale(v, 1.0 / n) }
}

pub fn timeseries_decomp_emd_vector_dist(a : TimeseriesdecompemdVector, b : TimeseriesdecompemdVector) -> Double {
  timeseries_decomp_emd_vector_norm(timeseries_decomp_emd_vector_sub(a, b))
}

pub fn timeseries_decomp_emd_vector_to_string(v : TimeseriesdecompemdVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + timeseries_decomp_emd_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn timeseries_decomp_emd_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn timeseries_decomp_emd_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = timeseries_decomp_emd_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn timeseries_decomp_emd_std(data : Array[Double]) -> Double { timeseries_decomp_emd_sqrt(timeseries_decomp_emd_var(data)) }

pub fn timeseries_decomp_emd_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = timeseries_decomp_emd_mean(a); let mb = timeseries_decomp_emd_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn timeseries_decomp_emd_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = timeseries_decomp_emd_std(a); let sb = timeseries_decomp_emd_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { timeseries_decomp_emd_cov(a, b) / (sa * sb) }
}

pub fn timeseries_decomp_emd_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = timeseries_decomp_emd_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn timeseries_decomp_emd_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn timeseries_decomp_emd_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn timeseries_decomp_emd_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  timeseries_decomp_emd_sqrt(timeseries_decomp_emd_mse(pred, labels))
}

pub fn timeseries_decomp_emd_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + timeseries_decomp_emd_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn timeseries_decomp_emd_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = timeseries_decomp_emd_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn timeseries_decomp_emd_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn timeseries_decomp_emd_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn timeseries_decomp_emd_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = timeseries_decomp_emd_precision(pred, labels, pos); let r = timeseries_decomp_emd_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn timeseries_decomp_emd_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn timeseries_decomp_emd_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = timeseries_decomp_emd_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn timeseries_decomp_emd_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn timeseries_decomp_emd_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn timeseries_decomp_emd_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = timeseries_decomp_emd_gcd(a, b)
    (a / g) * b
  }
}

pub fn timeseries_decomp_emd_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn timeseries_decomp_emd_fibonacci(n : Int) -> Int {
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

pub fn timeseries_decomp_emd_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = timeseries_decomp_emd_min(data); let mx = timeseries_decomp_emd_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn timeseries_decomp_emd_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = timeseries_decomp_emd_mean(data); let sd = timeseries_decomp_emd_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn timeseries_decomp_emd_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn timeseries_decomp_emd_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn timeseries_decomp_emd_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn timeseries_decomp_emd_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn timeseries_decomp_emd_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn timeseries_decomp_emd_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn timeseries_decomp_emd_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn timeseries_decomp_emd_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn timeseries_decomp_emd_dbl(x : Double) -> String {
  let i = if x >= 0.0 { timeseries_decomp_emd_int(x) } else { -timeseries_decomp_emd_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { timeseries_decomp_emd_int(f * 1000000.0) } else { timeseries_decomp_emd_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn timeseries_decomp_emd_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn timeseries_decomp_emd_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct TimeseriesdecompemdFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_emd_frame_make(size : Int) -> TimeseriesdecompemdFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_emd_frame_len(s : TimeseriesdecompemdFrame) -> Int { s.size }

pub fn timeseries_decomp_emd_frame_get(s : TimeseriesdecompemdFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_emd_frame_set(s : TimeseriesdecompemdFrame, i : Int, v : Double) -> TimeseriesdecompemdFrame {
  let result = timeseries_decomp_emd_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_emd_frame_sum(s : TimeseriesdecompemdFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_emd_frame_mean(s : TimeseriesdecompemdFrame) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_emd_frame_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_emd_frame_scale(s : TimeseriesdecompemdFrame, f : Double) -> TimeseriesdecompemdFrame {
  let result = timeseries_decomp_emd_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_emd_frame_add(a : TimeseriesdecompemdFrame, b : TimeseriesdecompemdFrame) -> TimeseriesdecompemdFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_emd_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_emd_frame_copy(s : TimeseriesdecompemdFrame) -> TimeseriesdecompemdFrame {
  let result = timeseries_decomp_emd_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_emd_frame_fill(s : TimeseriesdecompemdFrame, v : Double) -> TimeseriesdecompemdFrame {
  let result = timeseries_decomp_emd_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_emd_frame_min(s : TimeseriesdecompemdFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_emd_frame_max(s : TimeseriesdecompemdFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_emd_frame_to_string(s : TimeseriesdecompemdFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompemdTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_emd_table_make(size : Int) -> TimeseriesdecompemdTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_emd_table_len(s : TimeseriesdecompemdTable) -> Int { s.size }

pub fn timeseries_decomp_emd_table_get(s : TimeseriesdecompemdTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_emd_table_set(s : TimeseriesdecompemdTable, i : Int, v : Double) -> TimeseriesdecompemdTable {
  let result = timeseries_decomp_emd_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_emd_table_sum(s : TimeseriesdecompemdTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_emd_table_mean(s : TimeseriesdecompemdTable) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_emd_table_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_emd_table_scale(s : TimeseriesdecompemdTable, f : Double) -> TimeseriesdecompemdTable {
  let result = timeseries_decomp_emd_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_emd_table_add(a : TimeseriesdecompemdTable, b : TimeseriesdecompemdTable) -> TimeseriesdecompemdTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_emd_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_emd_table_copy(s : TimeseriesdecompemdTable) -> TimeseriesdecompemdTable {
  let result = timeseries_decomp_emd_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_emd_table_fill(s : TimeseriesdecompemdTable, v : Double) -> TimeseriesdecompemdTable {
  let result = timeseries_decomp_emd_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_emd_table_min(s : TimeseriesdecompemdTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_emd_table_max(s : TimeseriesdecompemdTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_emd_table_to_string(s : TimeseriesdecompemdTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompemdGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_emd_graphn_make(size : Int) -> TimeseriesdecompemdGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_emd_graphn_len(s : TimeseriesdecompemdGraphN) -> Int { s.size }

pub fn timeseries_decomp_emd_graphn_get(s : TimeseriesdecompemdGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_emd_graphn_set(s : TimeseriesdecompemdGraphN, i : Int, v : Double) -> TimeseriesdecompemdGraphN {
  let result = timeseries_decomp_emd_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_emd_graphn_sum(s : TimeseriesdecompemdGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_emd_graphn_mean(s : TimeseriesdecompemdGraphN) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_emd_graphn_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_emd_graphn_scale(s : TimeseriesdecompemdGraphN, f : Double) -> TimeseriesdecompemdGraphN {
  let result = timeseries_decomp_emd_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_emd_graphn_add(a : TimeseriesdecompemdGraphN, b : TimeseriesdecompemdGraphN) -> TimeseriesdecompemdGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_emd_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_emd_graphn_copy(s : TimeseriesdecompemdGraphN) -> TimeseriesdecompemdGraphN {
  let result = timeseries_decomp_emd_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_emd_graphn_fill(s : TimeseriesdecompemdGraphN, v : Double) -> TimeseriesdecompemdGraphN {
  let result = timeseries_decomp_emd_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_emd_graphn_min(s : TimeseriesdecompemdGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_emd_graphn_max(s : TimeseriesdecompemdGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_emd_graphn_to_string(s : TimeseriesdecompemdGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompemdNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_emd_node_make(size : Int) -> TimeseriesdecompemdNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_emd_node_len(s : TimeseriesdecompemdNode) -> Int { s.size }

pub fn timeseries_decomp_emd_node_get(s : TimeseriesdecompemdNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_emd_node_set(s : TimeseriesdecompemdNode, i : Int, v : Double) -> TimeseriesdecompemdNode {
  let result = timeseries_decomp_emd_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_emd_node_sum(s : TimeseriesdecompemdNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_emd_node_mean(s : TimeseriesdecompemdNode) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_emd_node_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_emd_node_scale(s : TimeseriesdecompemdNode, f : Double) -> TimeseriesdecompemdNode {
  let result = timeseries_decomp_emd_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_emd_node_add(a : TimeseriesdecompemdNode, b : TimeseriesdecompemdNode) -> TimeseriesdecompemdNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_emd_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_emd_node_copy(s : TimeseriesdecompemdNode) -> TimeseriesdecompemdNode {
  let result = timeseries_decomp_emd_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_emd_node_fill(s : TimeseriesdecompemdNode, v : Double) -> TimeseriesdecompemdNode {
  let result = timeseries_decomp_emd_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_emd_node_min(s : TimeseriesdecompemdNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_emd_node_max(s : TimeseriesdecompemdNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_emd_node_to_string(s : TimeseriesdecompemdNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompemdEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_emd_edge_make(size : Int) -> TimeseriesdecompemdEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_emd_edge_len(s : TimeseriesdecompemdEdge) -> Int { s.size }

pub fn timeseries_decomp_emd_edge_get(s : TimeseriesdecompemdEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_emd_edge_set(s : TimeseriesdecompemdEdge, i : Int, v : Double) -> TimeseriesdecompemdEdge {
  let result = timeseries_decomp_emd_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_emd_edge_sum(s : TimeseriesdecompemdEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_emd_edge_mean(s : TimeseriesdecompemdEdge) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_emd_edge_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_emd_edge_scale(s : TimeseriesdecompemdEdge, f : Double) -> TimeseriesdecompemdEdge {
  let result = timeseries_decomp_emd_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_emd_edge_add(a : TimeseriesdecompemdEdge, b : TimeseriesdecompemdEdge) -> TimeseriesdecompemdEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_emd_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_emd_edge_copy(s : TimeseriesdecompemdEdge) -> TimeseriesdecompemdEdge {
  let result = timeseries_decomp_emd_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_emd_edge_fill(s : TimeseriesdecompemdEdge, v : Double) -> TimeseriesdecompemdEdge {
  let result = timeseries_decomp_emd_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_emd_edge_min(s : TimeseriesdecompemdEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_emd_edge_max(s : TimeseriesdecompemdEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_emd_edge_to_string(s : TimeseriesdecompemdEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompemdPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_emd_path_make(size : Int) -> TimeseriesdecompemdPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_emd_path_len(s : TimeseriesdecompemdPath) -> Int { s.size }

pub fn timeseries_decomp_emd_path_get(s : TimeseriesdecompemdPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_emd_path_set(s : TimeseriesdecompemdPath, i : Int, v : Double) -> TimeseriesdecompemdPath {
  let result = timeseries_decomp_emd_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_emd_path_sum(s : TimeseriesdecompemdPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_emd_path_mean(s : TimeseriesdecompemdPath) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_emd_path_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_emd_path_scale(s : TimeseriesdecompemdPath, f : Double) -> TimeseriesdecompemdPath {
  let result = timeseries_decomp_emd_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_emd_path_add(a : TimeseriesdecompemdPath, b : TimeseriesdecompemdPath) -> TimeseriesdecompemdPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_emd_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_emd_path_copy(s : TimeseriesdecompemdPath) -> TimeseriesdecompemdPath {
  let result = timeseries_decomp_emd_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_emd_path_fill(s : TimeseriesdecompemdPath, v : Double) -> TimeseriesdecompemdPath {
  let result = timeseries_decomp_emd_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_emd_path_min(s : TimeseriesdecompemdPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_emd_path_max(s : TimeseriesdecompemdPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_emd_path_to_string(s : TimeseriesdecompemdPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompemdCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_emd_cluster_make(size : Int) -> TimeseriesdecompemdCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_emd_cluster_len(s : TimeseriesdecompemdCluster) -> Int { s.size }

pub fn timeseries_decomp_emd_cluster_get(s : TimeseriesdecompemdCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_emd_cluster_set(s : TimeseriesdecompemdCluster, i : Int, v : Double) -> TimeseriesdecompemdCluster {
  let result = timeseries_decomp_emd_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_emd_cluster_sum(s : TimeseriesdecompemdCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_emd_cluster_mean(s : TimeseriesdecompemdCluster) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_emd_cluster_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_emd_cluster_scale(s : TimeseriesdecompemdCluster, f : Double) -> TimeseriesdecompemdCluster {
  let result = timeseries_decomp_emd_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_emd_cluster_add(a : TimeseriesdecompemdCluster, b : TimeseriesdecompemdCluster) -> TimeseriesdecompemdCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_emd_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_emd_cluster_copy(s : TimeseriesdecompemdCluster) -> TimeseriesdecompemdCluster {
  let result = timeseries_decomp_emd_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_emd_cluster_fill(s : TimeseriesdecompemdCluster, v : Double) -> TimeseriesdecompemdCluster {
  let result = timeseries_decomp_emd_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_emd_cluster_min(s : TimeseriesdecompemdCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_emd_cluster_max(s : TimeseriesdecompemdCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_emd_cluster_to_string(s : TimeseriesdecompemdCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompemdModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_emd_model_make(size : Int) -> TimeseriesdecompemdModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_emd_model_len(s : TimeseriesdecompemdModel) -> Int { s.size }

pub fn timeseries_decomp_emd_model_get(s : TimeseriesdecompemdModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_emd_model_set(s : TimeseriesdecompemdModel, i : Int, v : Double) -> TimeseriesdecompemdModel {
  let result = timeseries_decomp_emd_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_emd_model_sum(s : TimeseriesdecompemdModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_emd_model_mean(s : TimeseriesdecompemdModel) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_emd_model_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_emd_model_scale(s : TimeseriesdecompemdModel, f : Double) -> TimeseriesdecompemdModel {
  let result = timeseries_decomp_emd_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_emd_model_add(a : TimeseriesdecompemdModel, b : TimeseriesdecompemdModel) -> TimeseriesdecompemdModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_emd_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_emd_model_copy(s : TimeseriesdecompemdModel) -> TimeseriesdecompemdModel {
  let result = timeseries_decomp_emd_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_emd_model_fill(s : TimeseriesdecompemdModel, v : Double) -> TimeseriesdecompemdModel {
  let result = timeseries_decomp_emd_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_emd_model_min(s : TimeseriesdecompemdModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_emd_model_max(s : TimeseriesdecompemdModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_emd_model_to_string(s : TimeseriesdecompemdModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompemdLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_emd_layer_make(size : Int) -> TimeseriesdecompemdLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_emd_layer_len(s : TimeseriesdecompemdLayer) -> Int { s.size }

pub fn timeseries_decomp_emd_layer_get(s : TimeseriesdecompemdLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_emd_layer_set(s : TimeseriesdecompemdLayer, i : Int, v : Double) -> TimeseriesdecompemdLayer {
  let result = timeseries_decomp_emd_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_emd_layer_sum(s : TimeseriesdecompemdLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_emd_layer_mean(s : TimeseriesdecompemdLayer) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_emd_layer_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_emd_layer_scale(s : TimeseriesdecompemdLayer, f : Double) -> TimeseriesdecompemdLayer {
  let result = timeseries_decomp_emd_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_emd_layer_add(a : TimeseriesdecompemdLayer, b : TimeseriesdecompemdLayer) -> TimeseriesdecompemdLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_emd_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_emd_layer_copy(s : TimeseriesdecompemdLayer) -> TimeseriesdecompemdLayer {
  let result = timeseries_decomp_emd_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_emd_layer_fill(s : TimeseriesdecompemdLayer, v : Double) -> TimeseriesdecompemdLayer {
  let result = timeseries_decomp_emd_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_emd_layer_min(s : TimeseriesdecompemdLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_emd_layer_max(s : TimeseriesdecompemdLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_emd_layer_to_string(s : TimeseriesdecompemdLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompemdBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_emd_buffer_make(size : Int) -> TimeseriesdecompemdBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_emd_buffer_len(s : TimeseriesdecompemdBuffer) -> Int { s.size }

pub fn timeseries_decomp_emd_buffer_get(s : TimeseriesdecompemdBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_emd_buffer_set(s : TimeseriesdecompemdBuffer, i : Int, v : Double) -> TimeseriesdecompemdBuffer {
  let result = timeseries_decomp_emd_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_emd_buffer_sum(s : TimeseriesdecompemdBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_emd_buffer_mean(s : TimeseriesdecompemdBuffer) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_emd_buffer_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_emd_buffer_scale(s : TimeseriesdecompemdBuffer, f : Double) -> TimeseriesdecompemdBuffer {
  let result = timeseries_decomp_emd_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_emd_buffer_add(a : TimeseriesdecompemdBuffer, b : TimeseriesdecompemdBuffer) -> TimeseriesdecompemdBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_emd_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_emd_buffer_copy(s : TimeseriesdecompemdBuffer) -> TimeseriesdecompemdBuffer {
  let result = timeseries_decomp_emd_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_emd_buffer_fill(s : TimeseriesdecompemdBuffer, v : Double) -> TimeseriesdecompemdBuffer {
  let result = timeseries_decomp_emd_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_emd_buffer_min(s : TimeseriesdecompemdBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_emd_buffer_max(s : TimeseriesdecompemdBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_emd_buffer_to_string(s : TimeseriesdecompemdBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompemdCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_emd_cursor_make(size : Int) -> TimeseriesdecompemdCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_emd_cursor_len(s : TimeseriesdecompemdCursor) -> Int { s.size }

pub fn timeseries_decomp_emd_cursor_get(s : TimeseriesdecompemdCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_emd_cursor_set(s : TimeseriesdecompemdCursor, i : Int, v : Double) -> TimeseriesdecompemdCursor {
  let result = timeseries_decomp_emd_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_emd_cursor_sum(s : TimeseriesdecompemdCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_emd_cursor_mean(s : TimeseriesdecompemdCursor) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_emd_cursor_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_emd_cursor_scale(s : TimeseriesdecompemdCursor, f : Double) -> TimeseriesdecompemdCursor {
  let result = timeseries_decomp_emd_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_emd_cursor_add(a : TimeseriesdecompemdCursor, b : TimeseriesdecompemdCursor) -> TimeseriesdecompemdCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_emd_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_emd_cursor_copy(s : TimeseriesdecompemdCursor) -> TimeseriesdecompemdCursor {
  let result = timeseries_decomp_emd_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_emd_cursor_fill(s : TimeseriesdecompemdCursor, v : Double) -> TimeseriesdecompemdCursor {
  let result = timeseries_decomp_emd_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_emd_cursor_min(s : TimeseriesdecompemdCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_emd_cursor_max(s : TimeseriesdecompemdCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_emd_cursor_to_string(s : TimeseriesdecompemdCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompemdView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_emd_view_make(size : Int) -> TimeseriesdecompemdView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_emd_view_len(s : TimeseriesdecompemdView) -> Int { s.size }

pub fn timeseries_decomp_emd_view_get(s : TimeseriesdecompemdView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_emd_view_set(s : TimeseriesdecompemdView, i : Int, v : Double) -> TimeseriesdecompemdView {
  let result = timeseries_decomp_emd_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_emd_view_sum(s : TimeseriesdecompemdView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_emd_view_mean(s : TimeseriesdecompemdView) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_emd_view_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_emd_view_scale(s : TimeseriesdecompemdView, f : Double) -> TimeseriesdecompemdView {
  let result = timeseries_decomp_emd_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_emd_view_add(a : TimeseriesdecompemdView, b : TimeseriesdecompemdView) -> TimeseriesdecompemdView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_emd_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_emd_view_copy(s : TimeseriesdecompemdView) -> TimeseriesdecompemdView {
  let result = timeseries_decomp_emd_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_emd_view_fill(s : TimeseriesdecompemdView, v : Double) -> TimeseriesdecompemdView {
  let result = timeseries_decomp_emd_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_emd_view_min(s : TimeseriesdecompemdView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_emd_view_max(s : TimeseriesdecompemdView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_emd_view_to_string(s : TimeseriesdecompemdView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompemdRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_emd_range_make(size : Int) -> TimeseriesdecompemdRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_emd_range_len(s : TimeseriesdecompemdRange) -> Int { s.size }

pub fn timeseries_decomp_emd_range_get(s : TimeseriesdecompemdRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_emd_range_set(s : TimeseriesdecompemdRange, i : Int, v : Double) -> TimeseriesdecompemdRange {
  let result = timeseries_decomp_emd_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_emd_range_sum(s : TimeseriesdecompemdRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_emd_range_mean(s : TimeseriesdecompemdRange) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_emd_range_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_emd_range_scale(s : TimeseriesdecompemdRange, f : Double) -> TimeseriesdecompemdRange {
  let result = timeseries_decomp_emd_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_emd_range_add(a : TimeseriesdecompemdRange, b : TimeseriesdecompemdRange) -> TimeseriesdecompemdRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_emd_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_emd_range_copy(s : TimeseriesdecompemdRange) -> TimeseriesdecompemdRange {
  let result = timeseries_decomp_emd_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_emd_range_fill(s : TimeseriesdecompemdRange, v : Double) -> TimeseriesdecompemdRange {
  let result = timeseries_decomp_emd_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_emd_range_min(s : TimeseriesdecompemdRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_emd_range_max(s : TimeseriesdecompemdRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_emd_range_to_string(s : TimeseriesdecompemdRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompemdSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_emd_slice_make(size : Int) -> TimeseriesdecompemdSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_emd_slice_len(s : TimeseriesdecompemdSlice) -> Int { s.size }

pub fn timeseries_decomp_emd_slice_get(s : TimeseriesdecompemdSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_emd_slice_set(s : TimeseriesdecompemdSlice, i : Int, v : Double) -> TimeseriesdecompemdSlice {
  let result = timeseries_decomp_emd_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_emd_slice_sum(s : TimeseriesdecompemdSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_emd_slice_mean(s : TimeseriesdecompemdSlice) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_emd_slice_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_emd_slice_scale(s : TimeseriesdecompemdSlice, f : Double) -> TimeseriesdecompemdSlice {
  let result = timeseries_decomp_emd_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_emd_slice_add(a : TimeseriesdecompemdSlice, b : TimeseriesdecompemdSlice) -> TimeseriesdecompemdSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_emd_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_emd_slice_copy(s : TimeseriesdecompemdSlice) -> TimeseriesdecompemdSlice {
  let result = timeseries_decomp_emd_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_emd_slice_fill(s : TimeseriesdecompemdSlice, v : Double) -> TimeseriesdecompemdSlice {
  let result = timeseries_decomp_emd_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_emd_slice_min(s : TimeseriesdecompemdSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_emd_slice_max(s : TimeseriesdecompemdSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_emd_slice_to_string(s : TimeseriesdecompemdSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn timeseries_decomp_emd_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_decomp_emd_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_decomp_emd_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_decomp_emd_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_decomp_emd_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_decomp_emd_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_decomp_emd_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_decomp_emd_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_decomp_emd_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_decomp_emd_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_decomp_emd_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_decomp_emd_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_decomp_emd_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_decomp_emd_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_decomp_emd_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_decomp_emd_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_decomp_emd_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_decomp_emd_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_decomp_emd_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_decomp_emd_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_decomp_emd_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_decomp_emd_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_decomp_emd_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_decomp_emd_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_decomp_emd_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}


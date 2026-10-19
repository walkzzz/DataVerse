///===
/// extcore/ml_ensemble_lightgbm

pub(all) struct MlensemblelightgbmPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_ensemble_lightgbm_make_point(x : Double, y : Double) -> MlensemblelightgbmPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_ensemble_lightgbm_make_point3(x : Double, y : Double, z : Double) -> MlensemblelightgbmPoint {
  { x, y, z, label: 0 }
}

pub fn ml_ensemble_lightgbm_point_x(pt : MlensemblelightgbmPoint) -> Double { pt.x }

pub fn ml_ensemble_lightgbm_point_y(pt : MlensemblelightgbmPoint) -> Double { pt.y }

pub fn ml_ensemble_lightgbm_point_z(pt : MlensemblelightgbmPoint) -> Double { pt.z }

pub fn ml_ensemble_lightgbm_point_label(pt : MlensemblelightgbmPoint) -> Int { pt.label }

pub fn ml_ensemble_lightgbm_point_dist(a : MlensemblelightgbmPoint, b : MlensemblelightgbmPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  ml_ensemble_lightgbm_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ml_ensemble_lightgbm_point_add(a : MlensemblelightgbmPoint, b : MlensemblelightgbmPoint) -> MlensemblelightgbmPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ml_ensemble_lightgbm_point_sub(a : MlensemblelightgbmPoint, b : MlensemblelightgbmPoint) -> MlensemblelightgbmPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ml_ensemble_lightgbm_point_scale(pt : MlensemblelightgbmPoint, s : Double) -> MlensemblelightgbmPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ml_ensemble_lightgbm_point_dot(a : MlensemblelightgbmPoint, b : MlensemblelightgbmPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ml_ensemble_lightgbm_point_cross(a : MlensemblelightgbmPoint, b : MlensemblelightgbmPoint) -> MlensemblelightgbmPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ml_ensemble_lightgbm_point_norm(pt : MlensemblelightgbmPoint) -> Double {
  ml_ensemble_lightgbm_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ml_ensemble_lightgbm_point_normalize(pt : MlensemblelightgbmPoint) -> MlensemblelightgbmPoint {
  let n = ml_ensemble_lightgbm_point_norm(pt)
  if n < 0.0000001 { pt } else { ml_ensemble_lightgbm_point_scale(pt, 1.0 / n) }
}

pub fn ml_ensemble_lightgbm_point_negate(pt : MlensemblelightgbmPoint) -> MlensemblelightgbmPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ml_ensemble_lightgbm_point_mid(a : MlensemblelightgbmPoint, b : MlensemblelightgbmPoint) -> MlensemblelightgbmPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ml_ensemble_lightgbm_point_lerp(a : MlensemblelightgbmPoint, b : MlensemblelightgbmPoint, t : Double) -> MlensemblelightgbmPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ml_ensemble_lightgbm_point_to_string(pt : MlensemblelightgbmPoint) -> String {
  "(" + ml_ensemble_lightgbm_dbl(pt.x) + ", " + ml_ensemble_lightgbm_dbl(pt.y) + ", " + ml_ensemble_lightgbm_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MlensemblelightgbmSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_ensemble_lightgbm_make_series(vals : Array[Double], name : String) -> MlensemblelightgbmSeries {
  { vals, name, meta: 0 }
}

pub fn ml_ensemble_lightgbm_series_len(s : MlensemblelightgbmSeries) -> Int { s.vals.length() }

pub fn ml_ensemble_lightgbm_series_sum(s : MlensemblelightgbmSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn ml_ensemble_lightgbm_series_mean(s : MlensemblelightgbmSeries) -> Double {
  let n = ml_ensemble_lightgbm_series_len(s)
  if n == 0 { 0.0 } else { ml_ensemble_lightgbm_series_sum(s) / n.to_double() }
}

pub fn ml_ensemble_lightgbm_series_min(s : MlensemblelightgbmSeries) -> Double {
  let n = ml_ensemble_lightgbm_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn ml_ensemble_lightgbm_series_max(s : MlensemblelightgbmSeries) -> Double {
  let n = ml_ensemble_lightgbm_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn ml_ensemble_lightgbm_series_range(s : MlensemblelightgbmSeries) -> Double {
  ml_ensemble_lightgbm_series_max(s) - ml_ensemble_lightgbm_series_min(s)
}

pub fn ml_ensemble_lightgbm_series_var(s : MlensemblelightgbmSeries) -> Double {
  let n = ml_ensemble_lightgbm_series_len(s)
  if n == 0 { 0.0 } else {
    let m = ml_ensemble_lightgbm_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn ml_ensemble_lightgbm_series_std(s : MlensemblelightgbmSeries) -> Double { ml_ensemble_lightgbm_sqrt(ml_ensemble_lightgbm_series_var(s)) }

pub fn ml_ensemble_lightgbm_series_median(s : MlensemblelightgbmSeries) -> Double {
  let n = ml_ensemble_lightgbm_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = ml_ensemble_lightgbm_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ml_ensemble_lightgbm_series_scale(s : MlensemblelightgbmSeries, f : Double) -> MlensemblelightgbmSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = ml_ensemble_lightgbm_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ml_ensemble_lightgbm_series_add(a : MlensemblelightgbmSeries, b : MlensemblelightgbmSeries) -> MlensemblelightgbmSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = ml_ensemble_lightgbm_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ml_ensemble_lightgbm_series_sub(a : MlensemblelightgbmSeries, b : MlensemblelightgbmSeries) -> MlensemblelightgbmSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = ml_ensemble_lightgbm_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ml_ensemble_lightgbm_series_normalize(s : MlensemblelightgbmSeries) -> MlensemblelightgbmSeries {
  let mn = ml_ensemble_lightgbm_series_min(s)
  let mx = ml_ensemble_lightgbm_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = ml_ensemble_lightgbm_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ml_ensemble_lightgbm_series_cumsum(s : MlensemblelightgbmSeries) -> MlensemblelightgbmSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = ml_ensemble_lightgbm_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn ml_ensemble_lightgbm_series_to_string(s : MlensemblelightgbmSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + ml_ensemble_lightgbm_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlensemblelightgbmMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_ensemble_lightgbm_make_matrix(rows : Int, cols : Int, val : Double) -> MlensemblelightgbmMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_ensemble_lightgbm_matrix_identity(n : Int) -> MlensemblelightgbmMatrix {
  let m = ml_ensemble_lightgbm_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ml_ensemble_lightgbm_matrix_get(m : MlensemblelightgbmMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ml_ensemble_lightgbm_matrix_transpose(m : MlensemblelightgbmMatrix) -> MlensemblelightgbmMatrix {
  let result = ml_ensemble_lightgbm_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ml_ensemble_lightgbm_matrix_add(a : MlensemblelightgbmMatrix, b : MlensemblelightgbmMatrix) -> MlensemblelightgbmMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ml_ensemble_lightgbm_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ml_ensemble_lightgbm_matrix_scale(m : MlensemblelightgbmMatrix, s : Double) -> MlensemblelightgbmMatrix {
  let result = ml_ensemble_lightgbm_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ml_ensemble_lightgbm_matrix_multiply(a : MlensemblelightgbmMatrix, b : MlensemblelightgbmMatrix) -> MlensemblelightgbmMatrix {
  if a.cols != b.rows { return ml_ensemble_lightgbm_make_matrix(a.rows, b.cols, 0.0) }
  let result = ml_ensemble_lightgbm_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ml_ensemble_lightgbm_matrix_trace(m : MlensemblelightgbmMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ml_ensemble_lightgbm_matrix_det(m : MlensemblelightgbmMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ml_ensemble_lightgbm_matrix_norm(m : MlensemblelightgbmMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  ml_ensemble_lightgbm_sqrt(sum)
}

pub fn ml_ensemble_lightgbm_matrix_to_string(m : MlensemblelightgbmMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + ml_ensemble_lightgbm_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct MlensemblelightgbmVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_ensemble_lightgbm_make_vector(comps : Array[Double]) -> MlensemblelightgbmVector {
  { comps, dim: comps.length() }
}

pub fn ml_ensemble_lightgbm_vector_zero(dim : Int) -> MlensemblelightgbmVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ml_ensemble_lightgbm_vector_add(a : MlensemblelightgbmVector, b : MlensemblelightgbmVector) -> MlensemblelightgbmVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = ml_ensemble_lightgbm_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_ensemble_lightgbm_vector_sub(a : MlensemblelightgbmVector, b : MlensemblelightgbmVector) -> MlensemblelightgbmVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = ml_ensemble_lightgbm_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_ensemble_lightgbm_vector_scale(v : MlensemblelightgbmVector, s : Double) -> MlensemblelightgbmVector {
  let mut result = []
  for i in 0..<v.dim { result = ml_ensemble_lightgbm_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ml_ensemble_lightgbm_vector_dot(a : MlensemblelightgbmVector, b : MlensemblelightgbmVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ml_ensemble_lightgbm_vector_norm(v : MlensemblelightgbmVector) -> Double { ml_ensemble_lightgbm_sqrt(ml_ensemble_lightgbm_vector_dot(v, v)) }

pub fn ml_ensemble_lightgbm_vector_normalize(v : MlensemblelightgbmVector) -> MlensemblelightgbmVector {
  let n = ml_ensemble_lightgbm_vector_norm(v)
  if n < 0.0000001 { v } else { ml_ensemble_lightgbm_vector_scale(v, 1.0 / n) }
}

pub fn ml_ensemble_lightgbm_vector_dist(a : MlensemblelightgbmVector, b : MlensemblelightgbmVector) -> Double {
  ml_ensemble_lightgbm_vector_norm(ml_ensemble_lightgbm_vector_sub(a, b))
}

pub fn ml_ensemble_lightgbm_vector_to_string(v : MlensemblelightgbmVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + ml_ensemble_lightgbm_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_ensemble_lightgbm_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn ml_ensemble_lightgbm_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = ml_ensemble_lightgbm_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ml_ensemble_lightgbm_std(data : Array[Double]) -> Double { ml_ensemble_lightgbm_sqrt(ml_ensemble_lightgbm_var(data)) }

pub fn ml_ensemble_lightgbm_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = ml_ensemble_lightgbm_mean(a); let mb = ml_ensemble_lightgbm_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn ml_ensemble_lightgbm_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = ml_ensemble_lightgbm_std(a); let sb = ml_ensemble_lightgbm_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { ml_ensemble_lightgbm_cov(a, b) / (sa * sb) }
}

pub fn ml_ensemble_lightgbm_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = ml_ensemble_lightgbm_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ml_ensemble_lightgbm_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn ml_ensemble_lightgbm_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ml_ensemble_lightgbm_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  ml_ensemble_lightgbm_sqrt(ml_ensemble_lightgbm_mse(pred, labels))
}

pub fn ml_ensemble_lightgbm_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + ml_ensemble_lightgbm_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn ml_ensemble_lightgbm_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = ml_ensemble_lightgbm_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn ml_ensemble_lightgbm_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn ml_ensemble_lightgbm_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn ml_ensemble_lightgbm_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = ml_ensemble_lightgbm_precision(pred, labels, pos); let r = ml_ensemble_lightgbm_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn ml_ensemble_lightgbm_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn ml_ensemble_lightgbm_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = ml_ensemble_lightgbm_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn ml_ensemble_lightgbm_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn ml_ensemble_lightgbm_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn ml_ensemble_lightgbm_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = ml_ensemble_lightgbm_gcd(a, b)
    (a / g) * b
  }
}

pub fn ml_ensemble_lightgbm_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn ml_ensemble_lightgbm_fibonacci(n : Int) -> Int {
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

pub fn ml_ensemble_lightgbm_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = ml_ensemble_lightgbm_min(data); let mx = ml_ensemble_lightgbm_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn ml_ensemble_lightgbm_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = ml_ensemble_lightgbm_mean(data); let sd = ml_ensemble_lightgbm_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn ml_ensemble_lightgbm_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn ml_ensemble_lightgbm_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn ml_ensemble_lightgbm_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn ml_ensemble_lightgbm_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn ml_ensemble_lightgbm_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn ml_ensemble_lightgbm_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn ml_ensemble_lightgbm_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn ml_ensemble_lightgbm_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn ml_ensemble_lightgbm_dbl(x : Double) -> String {
  let i = if x >= 0.0 { ml_ensemble_lightgbm_int(x) } else { -ml_ensemble_lightgbm_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { ml_ensemble_lightgbm_int(f * 1000000.0) } else { ml_ensemble_lightgbm_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn ml_ensemble_lightgbm_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn ml_ensemble_lightgbm_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct MlensemblelightgbmFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_lightgbm_frame_make(size : Int) -> MlensemblelightgbmFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_lightgbm_frame_len(s : MlensemblelightgbmFrame) -> Int { s.size }

pub fn ml_ensemble_lightgbm_frame_get(s : MlensemblelightgbmFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_lightgbm_frame_set(s : MlensemblelightgbmFrame, i : Int, v : Double) -> MlensemblelightgbmFrame {
  let result = ml_ensemble_lightgbm_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_lightgbm_frame_sum(s : MlensemblelightgbmFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_lightgbm_frame_mean(s : MlensemblelightgbmFrame) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_lightgbm_frame_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_lightgbm_frame_scale(s : MlensemblelightgbmFrame, f : Double) -> MlensemblelightgbmFrame {
  let result = ml_ensemble_lightgbm_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_lightgbm_frame_add(a : MlensemblelightgbmFrame, b : MlensemblelightgbmFrame) -> MlensemblelightgbmFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_lightgbm_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_lightgbm_frame_copy(s : MlensemblelightgbmFrame) -> MlensemblelightgbmFrame {
  let result = ml_ensemble_lightgbm_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_lightgbm_frame_fill(s : MlensemblelightgbmFrame, v : Double) -> MlensemblelightgbmFrame {
  let result = ml_ensemble_lightgbm_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_lightgbm_frame_min(s : MlensemblelightgbmFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_lightgbm_frame_max(s : MlensemblelightgbmFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_lightgbm_frame_to_string(s : MlensemblelightgbmFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblelightgbmTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_lightgbm_table_make(size : Int) -> MlensemblelightgbmTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_lightgbm_table_len(s : MlensemblelightgbmTable) -> Int { s.size }

pub fn ml_ensemble_lightgbm_table_get(s : MlensemblelightgbmTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_lightgbm_table_set(s : MlensemblelightgbmTable, i : Int, v : Double) -> MlensemblelightgbmTable {
  let result = ml_ensemble_lightgbm_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_lightgbm_table_sum(s : MlensemblelightgbmTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_lightgbm_table_mean(s : MlensemblelightgbmTable) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_lightgbm_table_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_lightgbm_table_scale(s : MlensemblelightgbmTable, f : Double) -> MlensemblelightgbmTable {
  let result = ml_ensemble_lightgbm_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_lightgbm_table_add(a : MlensemblelightgbmTable, b : MlensemblelightgbmTable) -> MlensemblelightgbmTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_lightgbm_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_lightgbm_table_copy(s : MlensemblelightgbmTable) -> MlensemblelightgbmTable {
  let result = ml_ensemble_lightgbm_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_lightgbm_table_fill(s : MlensemblelightgbmTable, v : Double) -> MlensemblelightgbmTable {
  let result = ml_ensemble_lightgbm_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_lightgbm_table_min(s : MlensemblelightgbmTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_lightgbm_table_max(s : MlensemblelightgbmTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_lightgbm_table_to_string(s : MlensemblelightgbmTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblelightgbmGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_lightgbm_graphn_make(size : Int) -> MlensemblelightgbmGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_lightgbm_graphn_len(s : MlensemblelightgbmGraphN) -> Int { s.size }

pub fn ml_ensemble_lightgbm_graphn_get(s : MlensemblelightgbmGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_lightgbm_graphn_set(s : MlensemblelightgbmGraphN, i : Int, v : Double) -> MlensemblelightgbmGraphN {
  let result = ml_ensemble_lightgbm_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_lightgbm_graphn_sum(s : MlensemblelightgbmGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_lightgbm_graphn_mean(s : MlensemblelightgbmGraphN) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_lightgbm_graphn_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_lightgbm_graphn_scale(s : MlensemblelightgbmGraphN, f : Double) -> MlensemblelightgbmGraphN {
  let result = ml_ensemble_lightgbm_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_lightgbm_graphn_add(a : MlensemblelightgbmGraphN, b : MlensemblelightgbmGraphN) -> MlensemblelightgbmGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_lightgbm_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_lightgbm_graphn_copy(s : MlensemblelightgbmGraphN) -> MlensemblelightgbmGraphN {
  let result = ml_ensemble_lightgbm_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_lightgbm_graphn_fill(s : MlensemblelightgbmGraphN, v : Double) -> MlensemblelightgbmGraphN {
  let result = ml_ensemble_lightgbm_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_lightgbm_graphn_min(s : MlensemblelightgbmGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_lightgbm_graphn_max(s : MlensemblelightgbmGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_lightgbm_graphn_to_string(s : MlensemblelightgbmGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblelightgbmNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_lightgbm_node_make(size : Int) -> MlensemblelightgbmNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_lightgbm_node_len(s : MlensemblelightgbmNode) -> Int { s.size }

pub fn ml_ensemble_lightgbm_node_get(s : MlensemblelightgbmNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_lightgbm_node_set(s : MlensemblelightgbmNode, i : Int, v : Double) -> MlensemblelightgbmNode {
  let result = ml_ensemble_lightgbm_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_lightgbm_node_sum(s : MlensemblelightgbmNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_lightgbm_node_mean(s : MlensemblelightgbmNode) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_lightgbm_node_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_lightgbm_node_scale(s : MlensemblelightgbmNode, f : Double) -> MlensemblelightgbmNode {
  let result = ml_ensemble_lightgbm_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_lightgbm_node_add(a : MlensemblelightgbmNode, b : MlensemblelightgbmNode) -> MlensemblelightgbmNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_lightgbm_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_lightgbm_node_copy(s : MlensemblelightgbmNode) -> MlensemblelightgbmNode {
  let result = ml_ensemble_lightgbm_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_lightgbm_node_fill(s : MlensemblelightgbmNode, v : Double) -> MlensemblelightgbmNode {
  let result = ml_ensemble_lightgbm_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_lightgbm_node_min(s : MlensemblelightgbmNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_lightgbm_node_max(s : MlensemblelightgbmNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_lightgbm_node_to_string(s : MlensemblelightgbmNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblelightgbmEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_lightgbm_edge_make(size : Int) -> MlensemblelightgbmEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_lightgbm_edge_len(s : MlensemblelightgbmEdge) -> Int { s.size }

pub fn ml_ensemble_lightgbm_edge_get(s : MlensemblelightgbmEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_lightgbm_edge_set(s : MlensemblelightgbmEdge, i : Int, v : Double) -> MlensemblelightgbmEdge {
  let result = ml_ensemble_lightgbm_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_lightgbm_edge_sum(s : MlensemblelightgbmEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_lightgbm_edge_mean(s : MlensemblelightgbmEdge) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_lightgbm_edge_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_lightgbm_edge_scale(s : MlensemblelightgbmEdge, f : Double) -> MlensemblelightgbmEdge {
  let result = ml_ensemble_lightgbm_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_lightgbm_edge_add(a : MlensemblelightgbmEdge, b : MlensemblelightgbmEdge) -> MlensemblelightgbmEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_lightgbm_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_lightgbm_edge_copy(s : MlensemblelightgbmEdge) -> MlensemblelightgbmEdge {
  let result = ml_ensemble_lightgbm_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_lightgbm_edge_fill(s : MlensemblelightgbmEdge, v : Double) -> MlensemblelightgbmEdge {
  let result = ml_ensemble_lightgbm_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_lightgbm_edge_min(s : MlensemblelightgbmEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_lightgbm_edge_max(s : MlensemblelightgbmEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_lightgbm_edge_to_string(s : MlensemblelightgbmEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblelightgbmPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_lightgbm_path_make(size : Int) -> MlensemblelightgbmPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_lightgbm_path_len(s : MlensemblelightgbmPath) -> Int { s.size }

pub fn ml_ensemble_lightgbm_path_get(s : MlensemblelightgbmPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_lightgbm_path_set(s : MlensemblelightgbmPath, i : Int, v : Double) -> MlensemblelightgbmPath {
  let result = ml_ensemble_lightgbm_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_lightgbm_path_sum(s : MlensemblelightgbmPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_lightgbm_path_mean(s : MlensemblelightgbmPath) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_lightgbm_path_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_lightgbm_path_scale(s : MlensemblelightgbmPath, f : Double) -> MlensemblelightgbmPath {
  let result = ml_ensemble_lightgbm_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_lightgbm_path_add(a : MlensemblelightgbmPath, b : MlensemblelightgbmPath) -> MlensemblelightgbmPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_lightgbm_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_lightgbm_path_copy(s : MlensemblelightgbmPath) -> MlensemblelightgbmPath {
  let result = ml_ensemble_lightgbm_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_lightgbm_path_fill(s : MlensemblelightgbmPath, v : Double) -> MlensemblelightgbmPath {
  let result = ml_ensemble_lightgbm_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_lightgbm_path_min(s : MlensemblelightgbmPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_lightgbm_path_max(s : MlensemblelightgbmPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_lightgbm_path_to_string(s : MlensemblelightgbmPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblelightgbmCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_lightgbm_cluster_make(size : Int) -> MlensemblelightgbmCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_lightgbm_cluster_len(s : MlensemblelightgbmCluster) -> Int { s.size }

pub fn ml_ensemble_lightgbm_cluster_get(s : MlensemblelightgbmCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_lightgbm_cluster_set(s : MlensemblelightgbmCluster, i : Int, v : Double) -> MlensemblelightgbmCluster {
  let result = ml_ensemble_lightgbm_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_lightgbm_cluster_sum(s : MlensemblelightgbmCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_lightgbm_cluster_mean(s : MlensemblelightgbmCluster) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_lightgbm_cluster_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_lightgbm_cluster_scale(s : MlensemblelightgbmCluster, f : Double) -> MlensemblelightgbmCluster {
  let result = ml_ensemble_lightgbm_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_lightgbm_cluster_add(a : MlensemblelightgbmCluster, b : MlensemblelightgbmCluster) -> MlensemblelightgbmCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_lightgbm_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_lightgbm_cluster_copy(s : MlensemblelightgbmCluster) -> MlensemblelightgbmCluster {
  let result = ml_ensemble_lightgbm_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_lightgbm_cluster_fill(s : MlensemblelightgbmCluster, v : Double) -> MlensemblelightgbmCluster {
  let result = ml_ensemble_lightgbm_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_lightgbm_cluster_min(s : MlensemblelightgbmCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_lightgbm_cluster_max(s : MlensemblelightgbmCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_lightgbm_cluster_to_string(s : MlensemblelightgbmCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblelightgbmModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_lightgbm_model_make(size : Int) -> MlensemblelightgbmModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_lightgbm_model_len(s : MlensemblelightgbmModel) -> Int { s.size }

pub fn ml_ensemble_lightgbm_model_get(s : MlensemblelightgbmModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_lightgbm_model_set(s : MlensemblelightgbmModel, i : Int, v : Double) -> MlensemblelightgbmModel {
  let result = ml_ensemble_lightgbm_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_lightgbm_model_sum(s : MlensemblelightgbmModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_lightgbm_model_mean(s : MlensemblelightgbmModel) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_lightgbm_model_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_lightgbm_model_scale(s : MlensemblelightgbmModel, f : Double) -> MlensemblelightgbmModel {
  let result = ml_ensemble_lightgbm_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_lightgbm_model_add(a : MlensemblelightgbmModel, b : MlensemblelightgbmModel) -> MlensemblelightgbmModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_lightgbm_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_lightgbm_model_copy(s : MlensemblelightgbmModel) -> MlensemblelightgbmModel {
  let result = ml_ensemble_lightgbm_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_lightgbm_model_fill(s : MlensemblelightgbmModel, v : Double) -> MlensemblelightgbmModel {
  let result = ml_ensemble_lightgbm_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_lightgbm_model_min(s : MlensemblelightgbmModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_lightgbm_model_max(s : MlensemblelightgbmModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_lightgbm_model_to_string(s : MlensemblelightgbmModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblelightgbmLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_lightgbm_layer_make(size : Int) -> MlensemblelightgbmLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_lightgbm_layer_len(s : MlensemblelightgbmLayer) -> Int { s.size }

pub fn ml_ensemble_lightgbm_layer_get(s : MlensemblelightgbmLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_lightgbm_layer_set(s : MlensemblelightgbmLayer, i : Int, v : Double) -> MlensemblelightgbmLayer {
  let result = ml_ensemble_lightgbm_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_lightgbm_layer_sum(s : MlensemblelightgbmLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_lightgbm_layer_mean(s : MlensemblelightgbmLayer) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_lightgbm_layer_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_lightgbm_layer_scale(s : MlensemblelightgbmLayer, f : Double) -> MlensemblelightgbmLayer {
  let result = ml_ensemble_lightgbm_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_lightgbm_layer_add(a : MlensemblelightgbmLayer, b : MlensemblelightgbmLayer) -> MlensemblelightgbmLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_lightgbm_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_lightgbm_layer_copy(s : MlensemblelightgbmLayer) -> MlensemblelightgbmLayer {
  let result = ml_ensemble_lightgbm_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_lightgbm_layer_fill(s : MlensemblelightgbmLayer, v : Double) -> MlensemblelightgbmLayer {
  let result = ml_ensemble_lightgbm_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_lightgbm_layer_min(s : MlensemblelightgbmLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_lightgbm_layer_max(s : MlensemblelightgbmLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_lightgbm_layer_to_string(s : MlensemblelightgbmLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblelightgbmBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_lightgbm_buffer_make(size : Int) -> MlensemblelightgbmBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_lightgbm_buffer_len(s : MlensemblelightgbmBuffer) -> Int { s.size }

pub fn ml_ensemble_lightgbm_buffer_get(s : MlensemblelightgbmBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_lightgbm_buffer_set(s : MlensemblelightgbmBuffer, i : Int, v : Double) -> MlensemblelightgbmBuffer {
  let result = ml_ensemble_lightgbm_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_lightgbm_buffer_sum(s : MlensemblelightgbmBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_lightgbm_buffer_mean(s : MlensemblelightgbmBuffer) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_lightgbm_buffer_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_lightgbm_buffer_scale(s : MlensemblelightgbmBuffer, f : Double) -> MlensemblelightgbmBuffer {
  let result = ml_ensemble_lightgbm_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_lightgbm_buffer_add(a : MlensemblelightgbmBuffer, b : MlensemblelightgbmBuffer) -> MlensemblelightgbmBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_lightgbm_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_lightgbm_buffer_copy(s : MlensemblelightgbmBuffer) -> MlensemblelightgbmBuffer {
  let result = ml_ensemble_lightgbm_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_lightgbm_buffer_fill(s : MlensemblelightgbmBuffer, v : Double) -> MlensemblelightgbmBuffer {
  let result = ml_ensemble_lightgbm_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_lightgbm_buffer_min(s : MlensemblelightgbmBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_lightgbm_buffer_max(s : MlensemblelightgbmBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_lightgbm_buffer_to_string(s : MlensemblelightgbmBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblelightgbmCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_lightgbm_cursor_make(size : Int) -> MlensemblelightgbmCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_lightgbm_cursor_len(s : MlensemblelightgbmCursor) -> Int { s.size }

pub fn ml_ensemble_lightgbm_cursor_get(s : MlensemblelightgbmCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_lightgbm_cursor_set(s : MlensemblelightgbmCursor, i : Int, v : Double) -> MlensemblelightgbmCursor {
  let result = ml_ensemble_lightgbm_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_lightgbm_cursor_sum(s : MlensemblelightgbmCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_lightgbm_cursor_mean(s : MlensemblelightgbmCursor) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_lightgbm_cursor_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_lightgbm_cursor_scale(s : MlensemblelightgbmCursor, f : Double) -> MlensemblelightgbmCursor {
  let result = ml_ensemble_lightgbm_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_lightgbm_cursor_add(a : MlensemblelightgbmCursor, b : MlensemblelightgbmCursor) -> MlensemblelightgbmCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_lightgbm_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_lightgbm_cursor_copy(s : MlensemblelightgbmCursor) -> MlensemblelightgbmCursor {
  let result = ml_ensemble_lightgbm_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_lightgbm_cursor_fill(s : MlensemblelightgbmCursor, v : Double) -> MlensemblelightgbmCursor {
  let result = ml_ensemble_lightgbm_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_lightgbm_cursor_min(s : MlensemblelightgbmCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_lightgbm_cursor_max(s : MlensemblelightgbmCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_lightgbm_cursor_to_string(s : MlensemblelightgbmCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblelightgbmView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_lightgbm_view_make(size : Int) -> MlensemblelightgbmView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_lightgbm_view_len(s : MlensemblelightgbmView) -> Int { s.size }

pub fn ml_ensemble_lightgbm_view_get(s : MlensemblelightgbmView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_lightgbm_view_set(s : MlensemblelightgbmView, i : Int, v : Double) -> MlensemblelightgbmView {
  let result = ml_ensemble_lightgbm_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_lightgbm_view_sum(s : MlensemblelightgbmView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_lightgbm_view_mean(s : MlensemblelightgbmView) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_lightgbm_view_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_lightgbm_view_scale(s : MlensemblelightgbmView, f : Double) -> MlensemblelightgbmView {
  let result = ml_ensemble_lightgbm_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_lightgbm_view_add(a : MlensemblelightgbmView, b : MlensemblelightgbmView) -> MlensemblelightgbmView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_lightgbm_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_lightgbm_view_copy(s : MlensemblelightgbmView) -> MlensemblelightgbmView {
  let result = ml_ensemble_lightgbm_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_lightgbm_view_fill(s : MlensemblelightgbmView, v : Double) -> MlensemblelightgbmView {
  let result = ml_ensemble_lightgbm_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_lightgbm_view_min(s : MlensemblelightgbmView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_lightgbm_view_max(s : MlensemblelightgbmView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_lightgbm_view_to_string(s : MlensemblelightgbmView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblelightgbmRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_lightgbm_range_make(size : Int) -> MlensemblelightgbmRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_lightgbm_range_len(s : MlensemblelightgbmRange) -> Int { s.size }

pub fn ml_ensemble_lightgbm_range_get(s : MlensemblelightgbmRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_lightgbm_range_set(s : MlensemblelightgbmRange, i : Int, v : Double) -> MlensemblelightgbmRange {
  let result = ml_ensemble_lightgbm_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_lightgbm_range_sum(s : MlensemblelightgbmRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_lightgbm_range_mean(s : MlensemblelightgbmRange) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_lightgbm_range_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_lightgbm_range_scale(s : MlensemblelightgbmRange, f : Double) -> MlensemblelightgbmRange {
  let result = ml_ensemble_lightgbm_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_lightgbm_range_add(a : MlensemblelightgbmRange, b : MlensemblelightgbmRange) -> MlensemblelightgbmRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_lightgbm_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_lightgbm_range_copy(s : MlensemblelightgbmRange) -> MlensemblelightgbmRange {
  let result = ml_ensemble_lightgbm_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_lightgbm_range_fill(s : MlensemblelightgbmRange, v : Double) -> MlensemblelightgbmRange {
  let result = ml_ensemble_lightgbm_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_lightgbm_range_min(s : MlensemblelightgbmRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_lightgbm_range_max(s : MlensemblelightgbmRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_lightgbm_range_to_string(s : MlensemblelightgbmRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblelightgbmSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_lightgbm_slice_make(size : Int) -> MlensemblelightgbmSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_lightgbm_slice_len(s : MlensemblelightgbmSlice) -> Int { s.size }

pub fn ml_ensemble_lightgbm_slice_get(s : MlensemblelightgbmSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_lightgbm_slice_set(s : MlensemblelightgbmSlice, i : Int, v : Double) -> MlensemblelightgbmSlice {
  let result = ml_ensemble_lightgbm_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_lightgbm_slice_sum(s : MlensemblelightgbmSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_lightgbm_slice_mean(s : MlensemblelightgbmSlice) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_lightgbm_slice_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_lightgbm_slice_scale(s : MlensemblelightgbmSlice, f : Double) -> MlensemblelightgbmSlice {
  let result = ml_ensemble_lightgbm_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_lightgbm_slice_add(a : MlensemblelightgbmSlice, b : MlensemblelightgbmSlice) -> MlensemblelightgbmSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_lightgbm_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_lightgbm_slice_copy(s : MlensemblelightgbmSlice) -> MlensemblelightgbmSlice {
  let result = ml_ensemble_lightgbm_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_lightgbm_slice_fill(s : MlensemblelightgbmSlice, v : Double) -> MlensemblelightgbmSlice {
  let result = ml_ensemble_lightgbm_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_lightgbm_slice_min(s : MlensemblelightgbmSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_lightgbm_slice_max(s : MlensemblelightgbmSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_lightgbm_slice_to_string(s : MlensemblelightgbmSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn ml_ensemble_lightgbm_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_ensemble_lightgbm_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_ensemble_lightgbm_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_ensemble_lightgbm_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_ensemble_lightgbm_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_ensemble_lightgbm_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_ensemble_lightgbm_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_ensemble_lightgbm_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_ensemble_lightgbm_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_ensemble_lightgbm_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_ensemble_lightgbm_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_ensemble_lightgbm_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_ensemble_lightgbm_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_ensemble_lightgbm_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_ensemble_lightgbm_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_ensemble_lightgbm_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_ensemble_lightgbm_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_ensemble_lightgbm_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_ensemble_lightgbm_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_ensemble_lightgbm_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_ensemble_lightgbm_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_ensemble_lightgbm_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_ensemble_lightgbm_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_ensemble_lightgbm_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_ensemble_lightgbm_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}


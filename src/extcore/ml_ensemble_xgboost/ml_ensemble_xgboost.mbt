///===
/// extcore/ml_ensemble_xgboost

pub(all) struct MlensemblexgboostPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_ensemble_xgboost_make_point(x : Double, y : Double) -> MlensemblexgboostPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_ensemble_xgboost_make_point3(x : Double, y : Double, z : Double) -> MlensemblexgboostPoint {
  { x, y, z, label: 0 }
}

pub fn ml_ensemble_xgboost_point_x(pt : MlensemblexgboostPoint) -> Double { pt.x }

pub fn ml_ensemble_xgboost_point_y(pt : MlensemblexgboostPoint) -> Double { pt.y }

pub fn ml_ensemble_xgboost_point_z(pt : MlensemblexgboostPoint) -> Double { pt.z }

pub fn ml_ensemble_xgboost_point_label(pt : MlensemblexgboostPoint) -> Int { pt.label }

pub fn ml_ensemble_xgboost_point_dist(a : MlensemblexgboostPoint, b : MlensemblexgboostPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  ml_ensemble_xgboost_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ml_ensemble_xgboost_point_add(a : MlensemblexgboostPoint, b : MlensemblexgboostPoint) -> MlensemblexgboostPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ml_ensemble_xgboost_point_sub(a : MlensemblexgboostPoint, b : MlensemblexgboostPoint) -> MlensemblexgboostPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ml_ensemble_xgboost_point_scale(pt : MlensemblexgboostPoint, s : Double) -> MlensemblexgboostPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ml_ensemble_xgboost_point_dot(a : MlensemblexgboostPoint, b : MlensemblexgboostPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ml_ensemble_xgboost_point_cross(a : MlensemblexgboostPoint, b : MlensemblexgboostPoint) -> MlensemblexgboostPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ml_ensemble_xgboost_point_norm(pt : MlensemblexgboostPoint) -> Double {
  ml_ensemble_xgboost_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ml_ensemble_xgboost_point_normalize(pt : MlensemblexgboostPoint) -> MlensemblexgboostPoint {
  let n = ml_ensemble_xgboost_point_norm(pt)
  if n < 0.0000001 { pt } else { ml_ensemble_xgboost_point_scale(pt, 1.0 / n) }
}

pub fn ml_ensemble_xgboost_point_negate(pt : MlensemblexgboostPoint) -> MlensemblexgboostPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ml_ensemble_xgboost_point_mid(a : MlensemblexgboostPoint, b : MlensemblexgboostPoint) -> MlensemblexgboostPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ml_ensemble_xgboost_point_lerp(a : MlensemblexgboostPoint, b : MlensemblexgboostPoint, t : Double) -> MlensemblexgboostPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ml_ensemble_xgboost_point_to_string(pt : MlensemblexgboostPoint) -> String {
  "(" + ml_ensemble_xgboost_dbl(pt.x) + ", " + ml_ensemble_xgboost_dbl(pt.y) + ", " + ml_ensemble_xgboost_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MlensemblexgboostSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_ensemble_xgboost_make_series(vals : Array[Double], name : String) -> MlensemblexgboostSeries {
  { vals, name, meta: 0 }
}

pub fn ml_ensemble_xgboost_series_len(s : MlensemblexgboostSeries) -> Int { s.vals.length() }

pub fn ml_ensemble_xgboost_series_sum(s : MlensemblexgboostSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn ml_ensemble_xgboost_series_mean(s : MlensemblexgboostSeries) -> Double {
  let n = ml_ensemble_xgboost_series_len(s)
  if n == 0 { 0.0 } else { ml_ensemble_xgboost_series_sum(s) / n.to_double() }
}

pub fn ml_ensemble_xgboost_series_min(s : MlensemblexgboostSeries) -> Double {
  let n = ml_ensemble_xgboost_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn ml_ensemble_xgboost_series_max(s : MlensemblexgboostSeries) -> Double {
  let n = ml_ensemble_xgboost_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn ml_ensemble_xgboost_series_range(s : MlensemblexgboostSeries) -> Double {
  ml_ensemble_xgboost_series_max(s) - ml_ensemble_xgboost_series_min(s)
}

pub fn ml_ensemble_xgboost_series_var(s : MlensemblexgboostSeries) -> Double {
  let n = ml_ensemble_xgboost_series_len(s)
  if n == 0 { 0.0 } else {
    let m = ml_ensemble_xgboost_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn ml_ensemble_xgboost_series_std(s : MlensemblexgboostSeries) -> Double { ml_ensemble_xgboost_sqrt(ml_ensemble_xgboost_series_var(s)) }

pub fn ml_ensemble_xgboost_series_median(s : MlensemblexgboostSeries) -> Double {
  let n = ml_ensemble_xgboost_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = ml_ensemble_xgboost_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ml_ensemble_xgboost_series_scale(s : MlensemblexgboostSeries, f : Double) -> MlensemblexgboostSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = ml_ensemble_xgboost_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ml_ensemble_xgboost_series_add(a : MlensemblexgboostSeries, b : MlensemblexgboostSeries) -> MlensemblexgboostSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = ml_ensemble_xgboost_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ml_ensemble_xgboost_series_sub(a : MlensemblexgboostSeries, b : MlensemblexgboostSeries) -> MlensemblexgboostSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = ml_ensemble_xgboost_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ml_ensemble_xgboost_series_normalize(s : MlensemblexgboostSeries) -> MlensemblexgboostSeries {
  let mn = ml_ensemble_xgboost_series_min(s)
  let mx = ml_ensemble_xgboost_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = ml_ensemble_xgboost_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ml_ensemble_xgboost_series_cumsum(s : MlensemblexgboostSeries) -> MlensemblexgboostSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = ml_ensemble_xgboost_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn ml_ensemble_xgboost_series_to_string(s : MlensemblexgboostSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + ml_ensemble_xgboost_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlensemblexgboostMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_ensemble_xgboost_make_matrix(rows : Int, cols : Int, val : Double) -> MlensemblexgboostMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_ensemble_xgboost_matrix_identity(n : Int) -> MlensemblexgboostMatrix {
  let m = ml_ensemble_xgboost_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ml_ensemble_xgboost_matrix_get(m : MlensemblexgboostMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ml_ensemble_xgboost_matrix_transpose(m : MlensemblexgboostMatrix) -> MlensemblexgboostMatrix {
  let result = ml_ensemble_xgboost_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ml_ensemble_xgboost_matrix_add(a : MlensemblexgboostMatrix, b : MlensemblexgboostMatrix) -> MlensemblexgboostMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ml_ensemble_xgboost_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ml_ensemble_xgboost_matrix_scale(m : MlensemblexgboostMatrix, s : Double) -> MlensemblexgboostMatrix {
  let result = ml_ensemble_xgboost_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ml_ensemble_xgboost_matrix_multiply(a : MlensemblexgboostMatrix, b : MlensemblexgboostMatrix) -> MlensemblexgboostMatrix {
  if a.cols != b.rows { return ml_ensemble_xgboost_make_matrix(a.rows, b.cols, 0.0) }
  let result = ml_ensemble_xgboost_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ml_ensemble_xgboost_matrix_trace(m : MlensemblexgboostMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ml_ensemble_xgboost_matrix_det(m : MlensemblexgboostMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ml_ensemble_xgboost_matrix_norm(m : MlensemblexgboostMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  ml_ensemble_xgboost_sqrt(sum)
}

pub fn ml_ensemble_xgboost_matrix_to_string(m : MlensemblexgboostMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + ml_ensemble_xgboost_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct MlensemblexgboostVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_ensemble_xgboost_make_vector(comps : Array[Double]) -> MlensemblexgboostVector {
  { comps, dim: comps.length() }
}

pub fn ml_ensemble_xgboost_vector_zero(dim : Int) -> MlensemblexgboostVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ml_ensemble_xgboost_vector_add(a : MlensemblexgboostVector, b : MlensemblexgboostVector) -> MlensemblexgboostVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = ml_ensemble_xgboost_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_ensemble_xgboost_vector_sub(a : MlensemblexgboostVector, b : MlensemblexgboostVector) -> MlensemblexgboostVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = ml_ensemble_xgboost_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_ensemble_xgboost_vector_scale(v : MlensemblexgboostVector, s : Double) -> MlensemblexgboostVector {
  let mut result = []
  for i in 0..<v.dim { result = ml_ensemble_xgboost_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ml_ensemble_xgboost_vector_dot(a : MlensemblexgboostVector, b : MlensemblexgboostVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ml_ensemble_xgboost_vector_norm(v : MlensemblexgboostVector) -> Double { ml_ensemble_xgboost_sqrt(ml_ensemble_xgboost_vector_dot(v, v)) }

pub fn ml_ensemble_xgboost_vector_normalize(v : MlensemblexgboostVector) -> MlensemblexgboostVector {
  let n = ml_ensemble_xgboost_vector_norm(v)
  if n < 0.0000001 { v } else { ml_ensemble_xgboost_vector_scale(v, 1.0 / n) }
}

pub fn ml_ensemble_xgboost_vector_dist(a : MlensemblexgboostVector, b : MlensemblexgboostVector) -> Double {
  ml_ensemble_xgboost_vector_norm(ml_ensemble_xgboost_vector_sub(a, b))
}

pub fn ml_ensemble_xgboost_vector_to_string(v : MlensemblexgboostVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + ml_ensemble_xgboost_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_ensemble_xgboost_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn ml_ensemble_xgboost_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = ml_ensemble_xgboost_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ml_ensemble_xgboost_std(data : Array[Double]) -> Double { ml_ensemble_xgboost_sqrt(ml_ensemble_xgboost_var(data)) }

pub fn ml_ensemble_xgboost_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = ml_ensemble_xgboost_mean(a); let mb = ml_ensemble_xgboost_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn ml_ensemble_xgboost_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = ml_ensemble_xgboost_std(a); let sb = ml_ensemble_xgboost_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { ml_ensemble_xgboost_cov(a, b) / (sa * sb) }
}

pub fn ml_ensemble_xgboost_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = ml_ensemble_xgboost_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ml_ensemble_xgboost_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn ml_ensemble_xgboost_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ml_ensemble_xgboost_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  ml_ensemble_xgboost_sqrt(ml_ensemble_xgboost_mse(pred, labels))
}

pub fn ml_ensemble_xgboost_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + ml_ensemble_xgboost_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn ml_ensemble_xgboost_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = ml_ensemble_xgboost_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn ml_ensemble_xgboost_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn ml_ensemble_xgboost_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn ml_ensemble_xgboost_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = ml_ensemble_xgboost_precision(pred, labels, pos); let r = ml_ensemble_xgboost_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn ml_ensemble_xgboost_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn ml_ensemble_xgboost_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = ml_ensemble_xgboost_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn ml_ensemble_xgboost_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn ml_ensemble_xgboost_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn ml_ensemble_xgboost_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = ml_ensemble_xgboost_gcd(a, b)
    (a / g) * b
  }
}

pub fn ml_ensemble_xgboost_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn ml_ensemble_xgboost_fibonacci(n : Int) -> Int {
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

pub fn ml_ensemble_xgboost_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = ml_ensemble_xgboost_min(data); let mx = ml_ensemble_xgboost_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn ml_ensemble_xgboost_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = ml_ensemble_xgboost_mean(data); let sd = ml_ensemble_xgboost_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn ml_ensemble_xgboost_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn ml_ensemble_xgboost_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn ml_ensemble_xgboost_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn ml_ensemble_xgboost_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn ml_ensemble_xgboost_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn ml_ensemble_xgboost_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn ml_ensemble_xgboost_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn ml_ensemble_xgboost_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn ml_ensemble_xgboost_dbl(x : Double) -> String {
  let i = if x >= 0.0 { ml_ensemble_xgboost_int(x) } else { -ml_ensemble_xgboost_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { ml_ensemble_xgboost_int(f * 1000000.0) } else { ml_ensemble_xgboost_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn ml_ensemble_xgboost_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn ml_ensemble_xgboost_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct MlensemblexgboostFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_xgboost_frame_make(size : Int) -> MlensemblexgboostFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_xgboost_frame_len(s : MlensemblexgboostFrame) -> Int { s.size }

pub fn ml_ensemble_xgboost_frame_get(s : MlensemblexgboostFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_xgboost_frame_set(s : MlensemblexgboostFrame, i : Int, v : Double) -> MlensemblexgboostFrame {
  let result = ml_ensemble_xgboost_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_xgboost_frame_sum(s : MlensemblexgboostFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_xgboost_frame_mean(s : MlensemblexgboostFrame) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_xgboost_frame_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_xgboost_frame_scale(s : MlensemblexgboostFrame, f : Double) -> MlensemblexgboostFrame {
  let result = ml_ensemble_xgboost_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_xgboost_frame_add(a : MlensemblexgboostFrame, b : MlensemblexgboostFrame) -> MlensemblexgboostFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_xgboost_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_xgboost_frame_copy(s : MlensemblexgboostFrame) -> MlensemblexgboostFrame {
  let result = ml_ensemble_xgboost_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_xgboost_frame_fill(s : MlensemblexgboostFrame, v : Double) -> MlensemblexgboostFrame {
  let result = ml_ensemble_xgboost_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_xgboost_frame_min(s : MlensemblexgboostFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_xgboost_frame_max(s : MlensemblexgboostFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_xgboost_frame_to_string(s : MlensemblexgboostFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblexgboostTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_xgboost_table_make(size : Int) -> MlensemblexgboostTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_xgboost_table_len(s : MlensemblexgboostTable) -> Int { s.size }

pub fn ml_ensemble_xgboost_table_get(s : MlensemblexgboostTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_xgboost_table_set(s : MlensemblexgboostTable, i : Int, v : Double) -> MlensemblexgboostTable {
  let result = ml_ensemble_xgboost_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_xgboost_table_sum(s : MlensemblexgboostTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_xgboost_table_mean(s : MlensemblexgboostTable) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_xgboost_table_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_xgboost_table_scale(s : MlensemblexgboostTable, f : Double) -> MlensemblexgboostTable {
  let result = ml_ensemble_xgboost_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_xgboost_table_add(a : MlensemblexgboostTable, b : MlensemblexgboostTable) -> MlensemblexgboostTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_xgboost_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_xgboost_table_copy(s : MlensemblexgboostTable) -> MlensemblexgboostTable {
  let result = ml_ensemble_xgboost_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_xgboost_table_fill(s : MlensemblexgboostTable, v : Double) -> MlensemblexgboostTable {
  let result = ml_ensemble_xgboost_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_xgboost_table_min(s : MlensemblexgboostTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_xgboost_table_max(s : MlensemblexgboostTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_xgboost_table_to_string(s : MlensemblexgboostTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblexgboostGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_xgboost_graphn_make(size : Int) -> MlensemblexgboostGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_xgboost_graphn_len(s : MlensemblexgboostGraphN) -> Int { s.size }

pub fn ml_ensemble_xgboost_graphn_get(s : MlensemblexgboostGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_xgboost_graphn_set(s : MlensemblexgboostGraphN, i : Int, v : Double) -> MlensemblexgboostGraphN {
  let result = ml_ensemble_xgboost_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_xgboost_graphn_sum(s : MlensemblexgboostGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_xgboost_graphn_mean(s : MlensemblexgboostGraphN) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_xgboost_graphn_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_xgboost_graphn_scale(s : MlensemblexgboostGraphN, f : Double) -> MlensemblexgboostGraphN {
  let result = ml_ensemble_xgboost_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_xgboost_graphn_add(a : MlensemblexgboostGraphN, b : MlensemblexgboostGraphN) -> MlensemblexgboostGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_xgboost_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_xgboost_graphn_copy(s : MlensemblexgboostGraphN) -> MlensemblexgboostGraphN {
  let result = ml_ensemble_xgboost_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_xgboost_graphn_fill(s : MlensemblexgboostGraphN, v : Double) -> MlensemblexgboostGraphN {
  let result = ml_ensemble_xgboost_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_xgboost_graphn_min(s : MlensemblexgboostGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_xgboost_graphn_max(s : MlensemblexgboostGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_xgboost_graphn_to_string(s : MlensemblexgboostGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblexgboostNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_xgboost_node_make(size : Int) -> MlensemblexgboostNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_xgboost_node_len(s : MlensemblexgboostNode) -> Int { s.size }

pub fn ml_ensemble_xgboost_node_get(s : MlensemblexgboostNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_xgboost_node_set(s : MlensemblexgboostNode, i : Int, v : Double) -> MlensemblexgboostNode {
  let result = ml_ensemble_xgboost_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_xgboost_node_sum(s : MlensemblexgboostNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_xgboost_node_mean(s : MlensemblexgboostNode) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_xgboost_node_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_xgboost_node_scale(s : MlensemblexgboostNode, f : Double) -> MlensemblexgboostNode {
  let result = ml_ensemble_xgboost_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_xgboost_node_add(a : MlensemblexgboostNode, b : MlensemblexgboostNode) -> MlensemblexgboostNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_xgboost_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_xgboost_node_copy(s : MlensemblexgboostNode) -> MlensemblexgboostNode {
  let result = ml_ensemble_xgboost_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_xgboost_node_fill(s : MlensemblexgboostNode, v : Double) -> MlensemblexgboostNode {
  let result = ml_ensemble_xgboost_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_xgboost_node_min(s : MlensemblexgboostNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_xgboost_node_max(s : MlensemblexgboostNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_xgboost_node_to_string(s : MlensemblexgboostNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblexgboostEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_xgboost_edge_make(size : Int) -> MlensemblexgboostEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_xgboost_edge_len(s : MlensemblexgboostEdge) -> Int { s.size }

pub fn ml_ensemble_xgboost_edge_get(s : MlensemblexgboostEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_xgboost_edge_set(s : MlensemblexgboostEdge, i : Int, v : Double) -> MlensemblexgboostEdge {
  let result = ml_ensemble_xgboost_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_xgboost_edge_sum(s : MlensemblexgboostEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_xgboost_edge_mean(s : MlensemblexgboostEdge) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_xgboost_edge_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_xgboost_edge_scale(s : MlensemblexgboostEdge, f : Double) -> MlensemblexgboostEdge {
  let result = ml_ensemble_xgboost_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_xgboost_edge_add(a : MlensemblexgboostEdge, b : MlensemblexgboostEdge) -> MlensemblexgboostEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_xgboost_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_xgboost_edge_copy(s : MlensemblexgboostEdge) -> MlensemblexgboostEdge {
  let result = ml_ensemble_xgboost_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_xgboost_edge_fill(s : MlensemblexgboostEdge, v : Double) -> MlensemblexgboostEdge {
  let result = ml_ensemble_xgboost_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_xgboost_edge_min(s : MlensemblexgboostEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_xgboost_edge_max(s : MlensemblexgboostEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_xgboost_edge_to_string(s : MlensemblexgboostEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblexgboostPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_xgboost_path_make(size : Int) -> MlensemblexgboostPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_xgboost_path_len(s : MlensemblexgboostPath) -> Int { s.size }

pub fn ml_ensemble_xgboost_path_get(s : MlensemblexgboostPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_xgboost_path_set(s : MlensemblexgboostPath, i : Int, v : Double) -> MlensemblexgboostPath {
  let result = ml_ensemble_xgboost_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_xgboost_path_sum(s : MlensemblexgboostPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_xgboost_path_mean(s : MlensemblexgboostPath) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_xgboost_path_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_xgboost_path_scale(s : MlensemblexgboostPath, f : Double) -> MlensemblexgboostPath {
  let result = ml_ensemble_xgboost_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_xgboost_path_add(a : MlensemblexgboostPath, b : MlensemblexgboostPath) -> MlensemblexgboostPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_xgboost_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_xgboost_path_copy(s : MlensemblexgboostPath) -> MlensemblexgboostPath {
  let result = ml_ensemble_xgboost_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_xgboost_path_fill(s : MlensemblexgboostPath, v : Double) -> MlensemblexgboostPath {
  let result = ml_ensemble_xgboost_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_xgboost_path_min(s : MlensemblexgboostPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_xgboost_path_max(s : MlensemblexgboostPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_xgboost_path_to_string(s : MlensemblexgboostPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblexgboostCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_xgboost_cluster_make(size : Int) -> MlensemblexgboostCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_xgboost_cluster_len(s : MlensemblexgboostCluster) -> Int { s.size }

pub fn ml_ensemble_xgboost_cluster_get(s : MlensemblexgboostCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_xgboost_cluster_set(s : MlensemblexgboostCluster, i : Int, v : Double) -> MlensemblexgboostCluster {
  let result = ml_ensemble_xgboost_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_xgboost_cluster_sum(s : MlensemblexgboostCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_xgboost_cluster_mean(s : MlensemblexgboostCluster) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_xgboost_cluster_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_xgboost_cluster_scale(s : MlensemblexgboostCluster, f : Double) -> MlensemblexgboostCluster {
  let result = ml_ensemble_xgboost_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_xgboost_cluster_add(a : MlensemblexgboostCluster, b : MlensemblexgboostCluster) -> MlensemblexgboostCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_xgboost_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_xgboost_cluster_copy(s : MlensemblexgboostCluster) -> MlensemblexgboostCluster {
  let result = ml_ensemble_xgboost_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_xgboost_cluster_fill(s : MlensemblexgboostCluster, v : Double) -> MlensemblexgboostCluster {
  let result = ml_ensemble_xgboost_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_xgboost_cluster_min(s : MlensemblexgboostCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_xgboost_cluster_max(s : MlensemblexgboostCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_xgboost_cluster_to_string(s : MlensemblexgboostCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblexgboostModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_xgboost_model_make(size : Int) -> MlensemblexgboostModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_xgboost_model_len(s : MlensemblexgboostModel) -> Int { s.size }

pub fn ml_ensemble_xgboost_model_get(s : MlensemblexgboostModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_xgboost_model_set(s : MlensemblexgboostModel, i : Int, v : Double) -> MlensemblexgboostModel {
  let result = ml_ensemble_xgboost_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_xgboost_model_sum(s : MlensemblexgboostModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_xgboost_model_mean(s : MlensemblexgboostModel) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_xgboost_model_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_xgboost_model_scale(s : MlensemblexgboostModel, f : Double) -> MlensemblexgboostModel {
  let result = ml_ensemble_xgboost_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_xgboost_model_add(a : MlensemblexgboostModel, b : MlensemblexgboostModel) -> MlensemblexgboostModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_xgboost_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_xgboost_model_copy(s : MlensemblexgboostModel) -> MlensemblexgboostModel {
  let result = ml_ensemble_xgboost_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_xgboost_model_fill(s : MlensemblexgboostModel, v : Double) -> MlensemblexgboostModel {
  let result = ml_ensemble_xgboost_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_xgboost_model_min(s : MlensemblexgboostModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_xgboost_model_max(s : MlensemblexgboostModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_xgboost_model_to_string(s : MlensemblexgboostModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblexgboostLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_xgboost_layer_make(size : Int) -> MlensemblexgboostLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_xgboost_layer_len(s : MlensemblexgboostLayer) -> Int { s.size }

pub fn ml_ensemble_xgboost_layer_get(s : MlensemblexgboostLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_xgboost_layer_set(s : MlensemblexgboostLayer, i : Int, v : Double) -> MlensemblexgboostLayer {
  let result = ml_ensemble_xgboost_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_xgboost_layer_sum(s : MlensemblexgboostLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_xgboost_layer_mean(s : MlensemblexgboostLayer) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_xgboost_layer_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_xgboost_layer_scale(s : MlensemblexgboostLayer, f : Double) -> MlensemblexgboostLayer {
  let result = ml_ensemble_xgboost_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_xgboost_layer_add(a : MlensemblexgboostLayer, b : MlensemblexgboostLayer) -> MlensemblexgboostLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_xgboost_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_xgboost_layer_copy(s : MlensemblexgboostLayer) -> MlensemblexgboostLayer {
  let result = ml_ensemble_xgboost_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_xgboost_layer_fill(s : MlensemblexgboostLayer, v : Double) -> MlensemblexgboostLayer {
  let result = ml_ensemble_xgboost_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_xgboost_layer_min(s : MlensemblexgboostLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_xgboost_layer_max(s : MlensemblexgboostLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_xgboost_layer_to_string(s : MlensemblexgboostLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblexgboostBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_xgboost_buffer_make(size : Int) -> MlensemblexgboostBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_xgboost_buffer_len(s : MlensemblexgboostBuffer) -> Int { s.size }

pub fn ml_ensemble_xgboost_buffer_get(s : MlensemblexgboostBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_xgboost_buffer_set(s : MlensemblexgboostBuffer, i : Int, v : Double) -> MlensemblexgboostBuffer {
  let result = ml_ensemble_xgboost_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_xgboost_buffer_sum(s : MlensemblexgboostBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_xgboost_buffer_mean(s : MlensemblexgboostBuffer) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_xgboost_buffer_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_xgboost_buffer_scale(s : MlensemblexgboostBuffer, f : Double) -> MlensemblexgboostBuffer {
  let result = ml_ensemble_xgboost_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_xgboost_buffer_add(a : MlensemblexgboostBuffer, b : MlensemblexgboostBuffer) -> MlensemblexgboostBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_xgboost_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_xgboost_buffer_copy(s : MlensemblexgboostBuffer) -> MlensemblexgboostBuffer {
  let result = ml_ensemble_xgboost_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_xgboost_buffer_fill(s : MlensemblexgboostBuffer, v : Double) -> MlensemblexgboostBuffer {
  let result = ml_ensemble_xgboost_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_xgboost_buffer_min(s : MlensemblexgboostBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_xgboost_buffer_max(s : MlensemblexgboostBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_xgboost_buffer_to_string(s : MlensemblexgboostBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblexgboostCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_xgboost_cursor_make(size : Int) -> MlensemblexgboostCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_xgboost_cursor_len(s : MlensemblexgboostCursor) -> Int { s.size }

pub fn ml_ensemble_xgboost_cursor_get(s : MlensemblexgboostCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_xgboost_cursor_set(s : MlensemblexgboostCursor, i : Int, v : Double) -> MlensemblexgboostCursor {
  let result = ml_ensemble_xgboost_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_xgboost_cursor_sum(s : MlensemblexgboostCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_xgboost_cursor_mean(s : MlensemblexgboostCursor) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_xgboost_cursor_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_xgboost_cursor_scale(s : MlensemblexgboostCursor, f : Double) -> MlensemblexgboostCursor {
  let result = ml_ensemble_xgboost_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_xgboost_cursor_add(a : MlensemblexgboostCursor, b : MlensemblexgboostCursor) -> MlensemblexgboostCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_xgboost_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_xgboost_cursor_copy(s : MlensemblexgboostCursor) -> MlensemblexgboostCursor {
  let result = ml_ensemble_xgboost_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_xgboost_cursor_fill(s : MlensemblexgboostCursor, v : Double) -> MlensemblexgboostCursor {
  let result = ml_ensemble_xgboost_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_xgboost_cursor_min(s : MlensemblexgboostCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_xgboost_cursor_max(s : MlensemblexgboostCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_xgboost_cursor_to_string(s : MlensemblexgboostCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblexgboostView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_xgboost_view_make(size : Int) -> MlensemblexgboostView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_xgboost_view_len(s : MlensemblexgboostView) -> Int { s.size }

pub fn ml_ensemble_xgboost_view_get(s : MlensemblexgboostView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_xgboost_view_set(s : MlensemblexgboostView, i : Int, v : Double) -> MlensemblexgboostView {
  let result = ml_ensemble_xgboost_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_xgboost_view_sum(s : MlensemblexgboostView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_xgboost_view_mean(s : MlensemblexgboostView) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_xgboost_view_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_xgboost_view_scale(s : MlensemblexgboostView, f : Double) -> MlensemblexgboostView {
  let result = ml_ensemble_xgboost_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_xgboost_view_add(a : MlensemblexgboostView, b : MlensemblexgboostView) -> MlensemblexgboostView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_xgboost_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_xgboost_view_copy(s : MlensemblexgboostView) -> MlensemblexgboostView {
  let result = ml_ensemble_xgboost_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_xgboost_view_fill(s : MlensemblexgboostView, v : Double) -> MlensemblexgboostView {
  let result = ml_ensemble_xgboost_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_xgboost_view_min(s : MlensemblexgboostView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_xgboost_view_max(s : MlensemblexgboostView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_xgboost_view_to_string(s : MlensemblexgboostView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblexgboostRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_xgboost_range_make(size : Int) -> MlensemblexgboostRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_xgboost_range_len(s : MlensemblexgboostRange) -> Int { s.size }

pub fn ml_ensemble_xgboost_range_get(s : MlensemblexgboostRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_xgboost_range_set(s : MlensemblexgboostRange, i : Int, v : Double) -> MlensemblexgboostRange {
  let result = ml_ensemble_xgboost_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_xgboost_range_sum(s : MlensemblexgboostRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_xgboost_range_mean(s : MlensemblexgboostRange) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_xgboost_range_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_xgboost_range_scale(s : MlensemblexgboostRange, f : Double) -> MlensemblexgboostRange {
  let result = ml_ensemble_xgboost_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_xgboost_range_add(a : MlensemblexgboostRange, b : MlensemblexgboostRange) -> MlensemblexgboostRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_xgboost_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_xgboost_range_copy(s : MlensemblexgboostRange) -> MlensemblexgboostRange {
  let result = ml_ensemble_xgboost_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_xgboost_range_fill(s : MlensemblexgboostRange, v : Double) -> MlensemblexgboostRange {
  let result = ml_ensemble_xgboost_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_xgboost_range_min(s : MlensemblexgboostRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_xgboost_range_max(s : MlensemblexgboostRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_xgboost_range_to_string(s : MlensemblexgboostRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblexgboostSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_xgboost_slice_make(size : Int) -> MlensemblexgboostSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_xgboost_slice_len(s : MlensemblexgboostSlice) -> Int { s.size }

pub fn ml_ensemble_xgboost_slice_get(s : MlensemblexgboostSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_xgboost_slice_set(s : MlensemblexgboostSlice, i : Int, v : Double) -> MlensemblexgboostSlice {
  let result = ml_ensemble_xgboost_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_xgboost_slice_sum(s : MlensemblexgboostSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_xgboost_slice_mean(s : MlensemblexgboostSlice) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_xgboost_slice_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_xgboost_slice_scale(s : MlensemblexgboostSlice, f : Double) -> MlensemblexgboostSlice {
  let result = ml_ensemble_xgboost_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_xgboost_slice_add(a : MlensemblexgboostSlice, b : MlensemblexgboostSlice) -> MlensemblexgboostSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_xgboost_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_xgboost_slice_copy(s : MlensemblexgboostSlice) -> MlensemblexgboostSlice {
  let result = ml_ensemble_xgboost_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_xgboost_slice_fill(s : MlensemblexgboostSlice, v : Double) -> MlensemblexgboostSlice {
  let result = ml_ensemble_xgboost_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_xgboost_slice_min(s : MlensemblexgboostSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_xgboost_slice_max(s : MlensemblexgboostSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_xgboost_slice_to_string(s : MlensemblexgboostSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn ml_ensemble_xgboost_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_ensemble_xgboost_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_ensemble_xgboost_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_ensemble_xgboost_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_ensemble_xgboost_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_ensemble_xgboost_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_ensemble_xgboost_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_ensemble_xgboost_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_ensemble_xgboost_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_ensemble_xgboost_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_ensemble_xgboost_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_ensemble_xgboost_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_ensemble_xgboost_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_ensemble_xgboost_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_ensemble_xgboost_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_ensemble_xgboost_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_ensemble_xgboost_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_ensemble_xgboost_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_ensemble_xgboost_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_ensemble_xgboost_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_ensemble_xgboost_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_ensemble_xgboost_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_ensemble_xgboost_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_ensemble_xgboost_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_ensemble_xgboost_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}


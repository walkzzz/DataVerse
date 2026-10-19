///===
/// extcore/ml_metric_confusion

pub(all) struct MlmetricconfusionPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_metric_confusion_make_point(x : Double, y : Double) -> MlmetricconfusionPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_metric_confusion_make_point3(x : Double, y : Double, z : Double) -> MlmetricconfusionPoint {
  { x, y, z, label: 0 }
}

pub fn ml_metric_confusion_point_x(pt : MlmetricconfusionPoint) -> Double { pt.x }

pub fn ml_metric_confusion_point_y(pt : MlmetricconfusionPoint) -> Double { pt.y }

pub fn ml_metric_confusion_point_z(pt : MlmetricconfusionPoint) -> Double { pt.z }

pub fn ml_metric_confusion_point_label(pt : MlmetricconfusionPoint) -> Int { pt.label }

pub fn ml_metric_confusion_point_dist(a : MlmetricconfusionPoint, b : MlmetricconfusionPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ml_metric_confusion_point_add(a : MlmetricconfusionPoint, b : MlmetricconfusionPoint) -> MlmetricconfusionPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ml_metric_confusion_point_sub(a : MlmetricconfusionPoint, b : MlmetricconfusionPoint) -> MlmetricconfusionPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ml_metric_confusion_point_scale(pt : MlmetricconfusionPoint, s : Double) -> MlmetricconfusionPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ml_metric_confusion_point_dot(a : MlmetricconfusionPoint, b : MlmetricconfusionPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ml_metric_confusion_point_cross(a : MlmetricconfusionPoint, b : MlmetricconfusionPoint) -> MlmetricconfusionPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ml_metric_confusion_point_norm(pt : MlmetricconfusionPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ml_metric_confusion_point_normalize(pt : MlmetricconfusionPoint) -> MlmetricconfusionPoint {
  let n = ml_metric_confusion_point_norm(pt)
  if n < 0.0000001 { pt } else { ml_metric_confusion_point_scale(pt, 1.0 / n) }
}

pub fn ml_metric_confusion_point_negate(pt : MlmetricconfusionPoint) -> MlmetricconfusionPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ml_metric_confusion_point_mid(a : MlmetricconfusionPoint, b : MlmetricconfusionPoint) -> MlmetricconfusionPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ml_metric_confusion_point_lerp(a : MlmetricconfusionPoint, b : MlmetricconfusionPoint, t : Double) -> MlmetricconfusionPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ml_metric_confusion_point_to_string(pt : MlmetricconfusionPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MlmetricconfusionSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_metric_confusion_make_series(vals : Array[Double], name : String) -> MlmetricconfusionSeries {
  { vals, name, meta: 0 }
}

pub fn ml_metric_confusion_series_len(s : MlmetricconfusionSeries) -> Int { s.vals.length() }

pub fn ml_metric_confusion_series_sum(s : MlmetricconfusionSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn ml_metric_confusion_series_mean(s : MlmetricconfusionSeries) -> Double {
  let n = ml_metric_confusion_series_len(s)
  if n == 0 { 0.0 } else { ml_metric_confusion_series_sum(s) / n.to_double() }
}

pub fn ml_metric_confusion_series_min(s : MlmetricconfusionSeries) -> Double {
  let n = ml_metric_confusion_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn ml_metric_confusion_series_max(s : MlmetricconfusionSeries) -> Double {
  let n = ml_metric_confusion_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn ml_metric_confusion_series_range(s : MlmetricconfusionSeries) -> Double {
  ml_metric_confusion_series_max(s) - ml_metric_confusion_series_min(s)
}

pub fn ml_metric_confusion_series_var(s : MlmetricconfusionSeries) -> Double {
  let n = ml_metric_confusion_series_len(s)
  if n == 0 { 0.0 } else {
    let m = ml_metric_confusion_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn ml_metric_confusion_series_std(s : MlmetricconfusionSeries) -> Double { @_common.sqrt(ml_metric_confusion_series_var(s)) }

pub fn ml_metric_confusion_series_median(s : MlmetricconfusionSeries) -> Double {
  let n = ml_metric_confusion_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = ml_metric_confusion_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ml_metric_confusion_series_scale(s : MlmetricconfusionSeries, f : Double) -> MlmetricconfusionSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ml_metric_confusion_series_add(a : MlmetricconfusionSeries, b : MlmetricconfusionSeries) -> MlmetricconfusionSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ml_metric_confusion_series_sub(a : MlmetricconfusionSeries, b : MlmetricconfusionSeries) -> MlmetricconfusionSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ml_metric_confusion_series_normalize(s : MlmetricconfusionSeries) -> MlmetricconfusionSeries {
  let mn = ml_metric_confusion_series_min(s)
  let mx = ml_metric_confusion_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ml_metric_confusion_series_cumsum(s : MlmetricconfusionSeries) -> MlmetricconfusionSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn ml_metric_confusion_series_to_string(s : MlmetricconfusionSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlmetricconfusionMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_metric_confusion_make_matrix(rows : Int, cols : Int, val : Double) -> MlmetricconfusionMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_metric_confusion_matrix_identity(n : Int) -> MlmetricconfusionMatrix {
  let m = ml_metric_confusion_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ml_metric_confusion_matrix_get(m : MlmetricconfusionMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ml_metric_confusion_matrix_transpose(m : MlmetricconfusionMatrix) -> MlmetricconfusionMatrix {
  let result = ml_metric_confusion_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ml_metric_confusion_matrix_add(a : MlmetricconfusionMatrix, b : MlmetricconfusionMatrix) -> MlmetricconfusionMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ml_metric_confusion_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ml_metric_confusion_matrix_scale(m : MlmetricconfusionMatrix, s : Double) -> MlmetricconfusionMatrix {
  let result = ml_metric_confusion_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ml_metric_confusion_matrix_multiply(a : MlmetricconfusionMatrix, b : MlmetricconfusionMatrix) -> MlmetricconfusionMatrix {
  if a.cols != b.rows { return ml_metric_confusion_make_matrix(a.rows, b.cols, 0.0) }
  let result = ml_metric_confusion_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ml_metric_confusion_matrix_trace(m : MlmetricconfusionMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ml_metric_confusion_matrix_det(m : MlmetricconfusionMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ml_metric_confusion_matrix_norm(m : MlmetricconfusionMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ml_metric_confusion_matrix_to_string(m : MlmetricconfusionMatrix) -> String {
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

pub(all) struct MlmetricconfusionVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_metric_confusion_make_vector(comps : Array[Double]) -> MlmetricconfusionVector {
  { comps, dim: comps.length() }
}

pub fn ml_metric_confusion_vector_zero(dim : Int) -> MlmetricconfusionVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ml_metric_confusion_vector_add(a : MlmetricconfusionVector, b : MlmetricconfusionVector) -> MlmetricconfusionVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_metric_confusion_vector_sub(a : MlmetricconfusionVector, b : MlmetricconfusionVector) -> MlmetricconfusionVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_metric_confusion_vector_scale(v : MlmetricconfusionVector, s : Double) -> MlmetricconfusionVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ml_metric_confusion_vector_dot(a : MlmetricconfusionVector, b : MlmetricconfusionVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ml_metric_confusion_vector_norm(v : MlmetricconfusionVector) -> Double { @_common.sqrt(ml_metric_confusion_vector_dot(v, v)) }

pub fn ml_metric_confusion_vector_normalize(v : MlmetricconfusionVector) -> MlmetricconfusionVector {
  let n = ml_metric_confusion_vector_norm(v)
  if n < 0.0000001 { v } else { ml_metric_confusion_vector_scale(v, 1.0 / n) }
}

pub fn ml_metric_confusion_vector_dist(a : MlmetricconfusionVector, b : MlmetricconfusionVector) -> Double {
  ml_metric_confusion_vector_norm(ml_metric_confusion_vector_sub(a, b))
}

pub fn ml_metric_confusion_vector_to_string(v : MlmetricconfusionVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_metric_confusion_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_metric_confusion_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_metric_confusion_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_metric_confusion_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_metric_confusion_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_metric_confusion_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_metric_confusion_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_metric_confusion_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_metric_confusion_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_metric_confusion_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_metric_confusion_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_metric_confusion_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_metric_confusion_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_metric_confusion_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_metric_confusion_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_metric_confusion_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_metric_confusion_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_metric_confusion_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_metric_confusion_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_metric_confusion_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_metric_confusion_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_metric_confusion_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_metric_confusion_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_metric_confusion_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_metric_confusion_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_metric_confusion_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_metric_confusion_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_metric_confusion_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_metric_confusion_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlmetricconfusionFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_confusion_frame_make(size : Int) -> MlmetricconfusionFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_confusion_frame_len(s : MlmetricconfusionFrame) -> Int { s.size }

pub fn ml_metric_confusion_frame_get(s : MlmetricconfusionFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_confusion_frame_set(s : MlmetricconfusionFrame, i : Int, v : Double) -> MlmetricconfusionFrame {
  let result = ml_metric_confusion_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_confusion_frame_sum(s : MlmetricconfusionFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_metric_confusion_frame_mean(s : MlmetricconfusionFrame) -> Double {
  if s.size == 0 { 0.0 } else { ml_metric_confusion_frame_sum(s) / s.size.to_double() }
}

pub fn ml_metric_confusion_frame_scale(s : MlmetricconfusionFrame, f : Double) -> MlmetricconfusionFrame {
  let result = ml_metric_confusion_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_metric_confusion_frame_add(a : MlmetricconfusionFrame, b : MlmetricconfusionFrame) -> MlmetricconfusionFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_metric_confusion_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_metric_confusion_frame_copy(s : MlmetricconfusionFrame) -> MlmetricconfusionFrame {
  let result = ml_metric_confusion_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_metric_confusion_frame_fill(s : MlmetricconfusionFrame, v : Double) -> MlmetricconfusionFrame {
  let result = ml_metric_confusion_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_metric_confusion_frame_min(s : MlmetricconfusionFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_confusion_frame_max(s : MlmetricconfusionFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_confusion_frame_to_string(s : MlmetricconfusionFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricconfusionTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_confusion_table_make(size : Int) -> MlmetricconfusionTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_confusion_table_len(s : MlmetricconfusionTable) -> Int { s.size }

pub fn ml_metric_confusion_table_get(s : MlmetricconfusionTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_confusion_table_set(s : MlmetricconfusionTable, i : Int, v : Double) -> MlmetricconfusionTable {
  let result = ml_metric_confusion_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_confusion_table_sum(s : MlmetricconfusionTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_metric_confusion_table_mean(s : MlmetricconfusionTable) -> Double {
  if s.size == 0 { 0.0 } else { ml_metric_confusion_table_sum(s) / s.size.to_double() }
}

pub fn ml_metric_confusion_table_scale(s : MlmetricconfusionTable, f : Double) -> MlmetricconfusionTable {
  let result = ml_metric_confusion_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_metric_confusion_table_add(a : MlmetricconfusionTable, b : MlmetricconfusionTable) -> MlmetricconfusionTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_metric_confusion_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_metric_confusion_table_copy(s : MlmetricconfusionTable) -> MlmetricconfusionTable {
  let result = ml_metric_confusion_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_metric_confusion_table_fill(s : MlmetricconfusionTable, v : Double) -> MlmetricconfusionTable {
  let result = ml_metric_confusion_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_metric_confusion_table_min(s : MlmetricconfusionTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_confusion_table_max(s : MlmetricconfusionTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_confusion_table_to_string(s : MlmetricconfusionTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricconfusionGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_confusion_graphn_make(size : Int) -> MlmetricconfusionGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_confusion_graphn_len(s : MlmetricconfusionGraphN) -> Int { s.size }

pub fn ml_metric_confusion_graphn_get(s : MlmetricconfusionGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_confusion_graphn_set(s : MlmetricconfusionGraphN, i : Int, v : Double) -> MlmetricconfusionGraphN {
  let result = ml_metric_confusion_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_confusion_graphn_sum(s : MlmetricconfusionGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_metric_confusion_graphn_mean(s : MlmetricconfusionGraphN) -> Double {
  if s.size == 0 { 0.0 } else { ml_metric_confusion_graphn_sum(s) / s.size.to_double() }
}

pub fn ml_metric_confusion_graphn_scale(s : MlmetricconfusionGraphN, f : Double) -> MlmetricconfusionGraphN {
  let result = ml_metric_confusion_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_metric_confusion_graphn_add(a : MlmetricconfusionGraphN, b : MlmetricconfusionGraphN) -> MlmetricconfusionGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_metric_confusion_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_metric_confusion_graphn_copy(s : MlmetricconfusionGraphN) -> MlmetricconfusionGraphN {
  let result = ml_metric_confusion_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_metric_confusion_graphn_fill(s : MlmetricconfusionGraphN, v : Double) -> MlmetricconfusionGraphN {
  let result = ml_metric_confusion_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_metric_confusion_graphn_min(s : MlmetricconfusionGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_confusion_graphn_max(s : MlmetricconfusionGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_confusion_graphn_to_string(s : MlmetricconfusionGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricconfusionNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_confusion_node_make(size : Int) -> MlmetricconfusionNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_confusion_node_len(s : MlmetricconfusionNode) -> Int { s.size }

pub fn ml_metric_confusion_node_get(s : MlmetricconfusionNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_confusion_node_set(s : MlmetricconfusionNode, i : Int, v : Double) -> MlmetricconfusionNode {
  let result = ml_metric_confusion_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_confusion_node_sum(s : MlmetricconfusionNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_metric_confusion_node_mean(s : MlmetricconfusionNode) -> Double {
  if s.size == 0 { 0.0 } else { ml_metric_confusion_node_sum(s) / s.size.to_double() }
}

pub fn ml_metric_confusion_node_scale(s : MlmetricconfusionNode, f : Double) -> MlmetricconfusionNode {
  let result = ml_metric_confusion_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_metric_confusion_node_add(a : MlmetricconfusionNode, b : MlmetricconfusionNode) -> MlmetricconfusionNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_metric_confusion_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_metric_confusion_node_copy(s : MlmetricconfusionNode) -> MlmetricconfusionNode {
  let result = ml_metric_confusion_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_metric_confusion_node_fill(s : MlmetricconfusionNode, v : Double) -> MlmetricconfusionNode {
  let result = ml_metric_confusion_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_metric_confusion_node_min(s : MlmetricconfusionNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_confusion_node_max(s : MlmetricconfusionNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_confusion_node_to_string(s : MlmetricconfusionNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricconfusionEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_confusion_edge_make(size : Int) -> MlmetricconfusionEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_confusion_edge_len(s : MlmetricconfusionEdge) -> Int { s.size }

pub fn ml_metric_confusion_edge_get(s : MlmetricconfusionEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_confusion_edge_set(s : MlmetricconfusionEdge, i : Int, v : Double) -> MlmetricconfusionEdge {
  let result = ml_metric_confusion_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_confusion_edge_sum(s : MlmetricconfusionEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_metric_confusion_edge_mean(s : MlmetricconfusionEdge) -> Double {
  if s.size == 0 { 0.0 } else { ml_metric_confusion_edge_sum(s) / s.size.to_double() }
}

pub fn ml_metric_confusion_edge_scale(s : MlmetricconfusionEdge, f : Double) -> MlmetricconfusionEdge {
  let result = ml_metric_confusion_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_metric_confusion_edge_add(a : MlmetricconfusionEdge, b : MlmetricconfusionEdge) -> MlmetricconfusionEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_metric_confusion_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_metric_confusion_edge_copy(s : MlmetricconfusionEdge) -> MlmetricconfusionEdge {
  let result = ml_metric_confusion_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_metric_confusion_edge_fill(s : MlmetricconfusionEdge, v : Double) -> MlmetricconfusionEdge {
  let result = ml_metric_confusion_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_metric_confusion_edge_min(s : MlmetricconfusionEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_confusion_edge_max(s : MlmetricconfusionEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_confusion_edge_to_string(s : MlmetricconfusionEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricconfusionPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_confusion_path_make(size : Int) -> MlmetricconfusionPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_confusion_path_len(s : MlmetricconfusionPath) -> Int { s.size }

pub fn ml_metric_confusion_path_get(s : MlmetricconfusionPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_confusion_path_set(s : MlmetricconfusionPath, i : Int, v : Double) -> MlmetricconfusionPath {
  let result = ml_metric_confusion_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_confusion_path_sum(s : MlmetricconfusionPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_metric_confusion_path_mean(s : MlmetricconfusionPath) -> Double {
  if s.size == 0 { 0.0 } else { ml_metric_confusion_path_sum(s) / s.size.to_double() }
}

pub fn ml_metric_confusion_path_scale(s : MlmetricconfusionPath, f : Double) -> MlmetricconfusionPath {
  let result = ml_metric_confusion_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_metric_confusion_path_add(a : MlmetricconfusionPath, b : MlmetricconfusionPath) -> MlmetricconfusionPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_metric_confusion_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_metric_confusion_path_copy(s : MlmetricconfusionPath) -> MlmetricconfusionPath {
  let result = ml_metric_confusion_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_metric_confusion_path_fill(s : MlmetricconfusionPath, v : Double) -> MlmetricconfusionPath {
  let result = ml_metric_confusion_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_metric_confusion_path_min(s : MlmetricconfusionPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_confusion_path_max(s : MlmetricconfusionPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_confusion_path_to_string(s : MlmetricconfusionPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricconfusionCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_confusion_cluster_make(size : Int) -> MlmetricconfusionCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_confusion_cluster_len(s : MlmetricconfusionCluster) -> Int { s.size }

pub fn ml_metric_confusion_cluster_get(s : MlmetricconfusionCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_confusion_cluster_set(s : MlmetricconfusionCluster, i : Int, v : Double) -> MlmetricconfusionCluster {
  let result = ml_metric_confusion_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_confusion_cluster_sum(s : MlmetricconfusionCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_metric_confusion_cluster_mean(s : MlmetricconfusionCluster) -> Double {
  if s.size == 0 { 0.0 } else { ml_metric_confusion_cluster_sum(s) / s.size.to_double() }
}

pub fn ml_metric_confusion_cluster_scale(s : MlmetricconfusionCluster, f : Double) -> MlmetricconfusionCluster {
  let result = ml_metric_confusion_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_metric_confusion_cluster_add(a : MlmetricconfusionCluster, b : MlmetricconfusionCluster) -> MlmetricconfusionCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_metric_confusion_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_metric_confusion_cluster_copy(s : MlmetricconfusionCluster) -> MlmetricconfusionCluster {
  let result = ml_metric_confusion_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_metric_confusion_cluster_fill(s : MlmetricconfusionCluster, v : Double) -> MlmetricconfusionCluster {
  let result = ml_metric_confusion_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_metric_confusion_cluster_min(s : MlmetricconfusionCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_confusion_cluster_max(s : MlmetricconfusionCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_confusion_cluster_to_string(s : MlmetricconfusionCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricconfusionModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_confusion_model_make(size : Int) -> MlmetricconfusionModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_confusion_model_len(s : MlmetricconfusionModel) -> Int { s.size }

pub fn ml_metric_confusion_model_get(s : MlmetricconfusionModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_confusion_model_set(s : MlmetricconfusionModel, i : Int, v : Double) -> MlmetricconfusionModel {
  let result = ml_metric_confusion_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_confusion_model_sum(s : MlmetricconfusionModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_metric_confusion_model_mean(s : MlmetricconfusionModel) -> Double {
  if s.size == 0 { 0.0 } else { ml_metric_confusion_model_sum(s) / s.size.to_double() }
}

pub fn ml_metric_confusion_model_scale(s : MlmetricconfusionModel, f : Double) -> MlmetricconfusionModel {
  let result = ml_metric_confusion_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_metric_confusion_model_add(a : MlmetricconfusionModel, b : MlmetricconfusionModel) -> MlmetricconfusionModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_metric_confusion_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_metric_confusion_model_copy(s : MlmetricconfusionModel) -> MlmetricconfusionModel {
  let result = ml_metric_confusion_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_metric_confusion_model_fill(s : MlmetricconfusionModel, v : Double) -> MlmetricconfusionModel {
  let result = ml_metric_confusion_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_metric_confusion_model_min(s : MlmetricconfusionModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_confusion_model_max(s : MlmetricconfusionModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_confusion_model_to_string(s : MlmetricconfusionModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricconfusionLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_confusion_layer_make(size : Int) -> MlmetricconfusionLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_confusion_layer_len(s : MlmetricconfusionLayer) -> Int { s.size }

pub fn ml_metric_confusion_layer_get(s : MlmetricconfusionLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_confusion_layer_set(s : MlmetricconfusionLayer, i : Int, v : Double) -> MlmetricconfusionLayer {
  let result = ml_metric_confusion_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_confusion_layer_sum(s : MlmetricconfusionLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_metric_confusion_layer_mean(s : MlmetricconfusionLayer) -> Double {
  if s.size == 0 { 0.0 } else { ml_metric_confusion_layer_sum(s) / s.size.to_double() }
}

pub fn ml_metric_confusion_layer_scale(s : MlmetricconfusionLayer, f : Double) -> MlmetricconfusionLayer {
  let result = ml_metric_confusion_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_metric_confusion_layer_add(a : MlmetricconfusionLayer, b : MlmetricconfusionLayer) -> MlmetricconfusionLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_metric_confusion_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_metric_confusion_layer_copy(s : MlmetricconfusionLayer) -> MlmetricconfusionLayer {
  let result = ml_metric_confusion_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_metric_confusion_layer_fill(s : MlmetricconfusionLayer, v : Double) -> MlmetricconfusionLayer {
  let result = ml_metric_confusion_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_metric_confusion_layer_min(s : MlmetricconfusionLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_confusion_layer_max(s : MlmetricconfusionLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_confusion_layer_to_string(s : MlmetricconfusionLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricconfusionBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_confusion_buffer_make(size : Int) -> MlmetricconfusionBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_confusion_buffer_len(s : MlmetricconfusionBuffer) -> Int { s.size }

pub fn ml_metric_confusion_buffer_get(s : MlmetricconfusionBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_confusion_buffer_set(s : MlmetricconfusionBuffer, i : Int, v : Double) -> MlmetricconfusionBuffer {
  let result = ml_metric_confusion_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_confusion_buffer_sum(s : MlmetricconfusionBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_metric_confusion_buffer_mean(s : MlmetricconfusionBuffer) -> Double {
  if s.size == 0 { 0.0 } else { ml_metric_confusion_buffer_sum(s) / s.size.to_double() }
}

pub fn ml_metric_confusion_buffer_scale(s : MlmetricconfusionBuffer, f : Double) -> MlmetricconfusionBuffer {
  let result = ml_metric_confusion_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_metric_confusion_buffer_add(a : MlmetricconfusionBuffer, b : MlmetricconfusionBuffer) -> MlmetricconfusionBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_metric_confusion_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_metric_confusion_buffer_copy(s : MlmetricconfusionBuffer) -> MlmetricconfusionBuffer {
  let result = ml_metric_confusion_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_metric_confusion_buffer_fill(s : MlmetricconfusionBuffer, v : Double) -> MlmetricconfusionBuffer {
  let result = ml_metric_confusion_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_metric_confusion_buffer_min(s : MlmetricconfusionBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_confusion_buffer_max(s : MlmetricconfusionBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_confusion_buffer_to_string(s : MlmetricconfusionBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricconfusionCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_confusion_cursor_make(size : Int) -> MlmetricconfusionCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_confusion_cursor_len(s : MlmetricconfusionCursor) -> Int { s.size }

pub fn ml_metric_confusion_cursor_get(s : MlmetricconfusionCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_confusion_cursor_set(s : MlmetricconfusionCursor, i : Int, v : Double) -> MlmetricconfusionCursor {
  let result = ml_metric_confusion_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_confusion_cursor_sum(s : MlmetricconfusionCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_metric_confusion_cursor_mean(s : MlmetricconfusionCursor) -> Double {
  if s.size == 0 { 0.0 } else { ml_metric_confusion_cursor_sum(s) / s.size.to_double() }
}

pub fn ml_metric_confusion_cursor_scale(s : MlmetricconfusionCursor, f : Double) -> MlmetricconfusionCursor {
  let result = ml_metric_confusion_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_metric_confusion_cursor_add(a : MlmetricconfusionCursor, b : MlmetricconfusionCursor) -> MlmetricconfusionCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_metric_confusion_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_metric_confusion_cursor_copy(s : MlmetricconfusionCursor) -> MlmetricconfusionCursor {
  let result = ml_metric_confusion_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_metric_confusion_cursor_fill(s : MlmetricconfusionCursor, v : Double) -> MlmetricconfusionCursor {
  let result = ml_metric_confusion_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_metric_confusion_cursor_min(s : MlmetricconfusionCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_confusion_cursor_max(s : MlmetricconfusionCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_confusion_cursor_to_string(s : MlmetricconfusionCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricconfusionView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_confusion_view_make(size : Int) -> MlmetricconfusionView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_confusion_view_len(s : MlmetricconfusionView) -> Int { s.size }

pub fn ml_metric_confusion_view_get(s : MlmetricconfusionView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_confusion_view_set(s : MlmetricconfusionView, i : Int, v : Double) -> MlmetricconfusionView {
  let result = ml_metric_confusion_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_confusion_view_sum(s : MlmetricconfusionView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_metric_confusion_view_mean(s : MlmetricconfusionView) -> Double {
  if s.size == 0 { 0.0 } else { ml_metric_confusion_view_sum(s) / s.size.to_double() }
}

pub fn ml_metric_confusion_view_scale(s : MlmetricconfusionView, f : Double) -> MlmetricconfusionView {
  let result = ml_metric_confusion_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_metric_confusion_view_add(a : MlmetricconfusionView, b : MlmetricconfusionView) -> MlmetricconfusionView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_metric_confusion_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_metric_confusion_view_copy(s : MlmetricconfusionView) -> MlmetricconfusionView {
  let result = ml_metric_confusion_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_metric_confusion_view_fill(s : MlmetricconfusionView, v : Double) -> MlmetricconfusionView {
  let result = ml_metric_confusion_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_metric_confusion_view_min(s : MlmetricconfusionView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_confusion_view_max(s : MlmetricconfusionView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_confusion_view_to_string(s : MlmetricconfusionView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricconfusionRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_confusion_range_make(size : Int) -> MlmetricconfusionRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_confusion_range_len(s : MlmetricconfusionRange) -> Int { s.size }

pub fn ml_metric_confusion_range_get(s : MlmetricconfusionRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_confusion_range_set(s : MlmetricconfusionRange, i : Int, v : Double) -> MlmetricconfusionRange {
  let result = ml_metric_confusion_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_confusion_range_sum(s : MlmetricconfusionRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_metric_confusion_range_mean(s : MlmetricconfusionRange) -> Double {
  if s.size == 0 { 0.0 } else { ml_metric_confusion_range_sum(s) / s.size.to_double() }
}

pub fn ml_metric_confusion_range_scale(s : MlmetricconfusionRange, f : Double) -> MlmetricconfusionRange {
  let result = ml_metric_confusion_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_metric_confusion_range_add(a : MlmetricconfusionRange, b : MlmetricconfusionRange) -> MlmetricconfusionRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_metric_confusion_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_metric_confusion_range_copy(s : MlmetricconfusionRange) -> MlmetricconfusionRange {
  let result = ml_metric_confusion_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_metric_confusion_range_fill(s : MlmetricconfusionRange, v : Double) -> MlmetricconfusionRange {
  let result = ml_metric_confusion_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_metric_confusion_range_min(s : MlmetricconfusionRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_confusion_range_max(s : MlmetricconfusionRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_confusion_range_to_string(s : MlmetricconfusionRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricconfusionSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_confusion_slice_make(size : Int) -> MlmetricconfusionSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_confusion_slice_len(s : MlmetricconfusionSlice) -> Int { s.size }

pub fn ml_metric_confusion_slice_get(s : MlmetricconfusionSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_confusion_slice_set(s : MlmetricconfusionSlice, i : Int, v : Double) -> MlmetricconfusionSlice {
  let result = ml_metric_confusion_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_confusion_slice_sum(s : MlmetricconfusionSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_metric_confusion_slice_mean(s : MlmetricconfusionSlice) -> Double {
  if s.size == 0 { 0.0 } else { ml_metric_confusion_slice_sum(s) / s.size.to_double() }
}

pub fn ml_metric_confusion_slice_scale(s : MlmetricconfusionSlice, f : Double) -> MlmetricconfusionSlice {
  let result = ml_metric_confusion_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_metric_confusion_slice_add(a : MlmetricconfusionSlice, b : MlmetricconfusionSlice) -> MlmetricconfusionSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_metric_confusion_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_metric_confusion_slice_copy(s : MlmetricconfusionSlice) -> MlmetricconfusionSlice {
  let result = ml_metric_confusion_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_metric_confusion_slice_fill(s : MlmetricconfusionSlice, v : Double) -> MlmetricconfusionSlice {
  let result = ml_metric_confusion_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_metric_confusion_slice_min(s : MlmetricconfusionSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_confusion_slice_max(s : MlmetricconfusionSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_confusion_slice_to_string(s : MlmetricconfusionSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


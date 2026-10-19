///===
/// extcore/ml_regress_logistic

pub(all) struct MlregresslogisticPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_regress_logistic_make_point(x : Double, y : Double) -> MlregresslogisticPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_regress_logistic_make_point3(x : Double, y : Double, z : Double) -> MlregresslogisticPoint {
  { x, y, z, label: 0 }
}

pub fn ml_regress_logistic_point_x(pt : MlregresslogisticPoint) -> Double { pt.x }

pub fn ml_regress_logistic_point_y(pt : MlregresslogisticPoint) -> Double { pt.y }

pub fn ml_regress_logistic_point_z(pt : MlregresslogisticPoint) -> Double { pt.z }

pub fn ml_regress_logistic_point_label(pt : MlregresslogisticPoint) -> Int { pt.label }

pub fn ml_regress_logistic_point_dist(a : MlregresslogisticPoint, b : MlregresslogisticPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ml_regress_logistic_point_add(a : MlregresslogisticPoint, b : MlregresslogisticPoint) -> MlregresslogisticPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ml_regress_logistic_point_sub(a : MlregresslogisticPoint, b : MlregresslogisticPoint) -> MlregresslogisticPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ml_regress_logistic_point_scale(pt : MlregresslogisticPoint, s : Double) -> MlregresslogisticPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ml_regress_logistic_point_dot(a : MlregresslogisticPoint, b : MlregresslogisticPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ml_regress_logistic_point_cross(a : MlregresslogisticPoint, b : MlregresslogisticPoint) -> MlregresslogisticPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ml_regress_logistic_point_norm(pt : MlregresslogisticPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ml_regress_logistic_point_normalize(pt : MlregresslogisticPoint) -> MlregresslogisticPoint {
  let n = ml_regress_logistic_point_norm(pt)
  if n < 0.0000001 { pt } else { ml_regress_logistic_point_scale(pt, 1.0 / n) }
}

pub fn ml_regress_logistic_point_negate(pt : MlregresslogisticPoint) -> MlregresslogisticPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ml_regress_logistic_point_mid(a : MlregresslogisticPoint, b : MlregresslogisticPoint) -> MlregresslogisticPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ml_regress_logistic_point_lerp(a : MlregresslogisticPoint, b : MlregresslogisticPoint, t : Double) -> MlregresslogisticPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ml_regress_logistic_point_to_string(pt : MlregresslogisticPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MlregresslogisticSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_regress_logistic_make_series(vals : Array[Double], name : String) -> MlregresslogisticSeries {
  { vals, name, meta: 0 }
}

pub fn ml_regress_logistic_series_len(s : MlregresslogisticSeries) -> Int { s.vals.length() }

pub fn ml_regress_logistic_series_sum(s : MlregresslogisticSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn ml_regress_logistic_series_mean(s : MlregresslogisticSeries) -> Double {
  let n = ml_regress_logistic_series_len(s)
  if n == 0 { 0.0 } else { ml_regress_logistic_series_sum(s) / n.to_double() }
}

pub fn ml_regress_logistic_series_min(s : MlregresslogisticSeries) -> Double {
  let n = ml_regress_logistic_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn ml_regress_logistic_series_max(s : MlregresslogisticSeries) -> Double {
  let n = ml_regress_logistic_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn ml_regress_logistic_series_range(s : MlregresslogisticSeries) -> Double {
  ml_regress_logistic_series_max(s) - ml_regress_logistic_series_min(s)
}

pub fn ml_regress_logistic_series_var(s : MlregresslogisticSeries) -> Double {
  let n = ml_regress_logistic_series_len(s)
  if n == 0 { 0.0 } else {
    let m = ml_regress_logistic_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn ml_regress_logistic_series_std(s : MlregresslogisticSeries) -> Double { @_common.sqrt(ml_regress_logistic_series_var(s)) }

pub fn ml_regress_logistic_series_median(s : MlregresslogisticSeries) -> Double {
  let n = ml_regress_logistic_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = ml_regress_logistic_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ml_regress_logistic_series_scale(s : MlregresslogisticSeries, f : Double) -> MlregresslogisticSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ml_regress_logistic_series_add(a : MlregresslogisticSeries, b : MlregresslogisticSeries) -> MlregresslogisticSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ml_regress_logistic_series_sub(a : MlregresslogisticSeries, b : MlregresslogisticSeries) -> MlregresslogisticSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ml_regress_logistic_series_normalize(s : MlregresslogisticSeries) -> MlregresslogisticSeries {
  let mn = ml_regress_logistic_series_min(s)
  let mx = ml_regress_logistic_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ml_regress_logistic_series_cumsum(s : MlregresslogisticSeries) -> MlregresslogisticSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn ml_regress_logistic_series_to_string(s : MlregresslogisticSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlregresslogisticMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_regress_logistic_make_matrix(rows : Int, cols : Int, val : Double) -> MlregresslogisticMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_regress_logistic_matrix_identity(n : Int) -> MlregresslogisticMatrix {
  let m = ml_regress_logistic_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ml_regress_logistic_matrix_get(m : MlregresslogisticMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ml_regress_logistic_matrix_transpose(m : MlregresslogisticMatrix) -> MlregresslogisticMatrix {
  let result = ml_regress_logistic_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ml_regress_logistic_matrix_add(a : MlregresslogisticMatrix, b : MlregresslogisticMatrix) -> MlregresslogisticMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ml_regress_logistic_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ml_regress_logistic_matrix_scale(m : MlregresslogisticMatrix, s : Double) -> MlregresslogisticMatrix {
  let result = ml_regress_logistic_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ml_regress_logistic_matrix_multiply(a : MlregresslogisticMatrix, b : MlregresslogisticMatrix) -> MlregresslogisticMatrix {
  if a.cols != b.rows { return ml_regress_logistic_make_matrix(a.rows, b.cols, 0.0) }
  let result = ml_regress_logistic_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ml_regress_logistic_matrix_trace(m : MlregresslogisticMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ml_regress_logistic_matrix_det(m : MlregresslogisticMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ml_regress_logistic_matrix_norm(m : MlregresslogisticMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ml_regress_logistic_matrix_to_string(m : MlregresslogisticMatrix) -> String {
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

pub(all) struct MlregresslogisticVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_regress_logistic_make_vector(comps : Array[Double]) -> MlregresslogisticVector {
  { comps, dim: comps.length() }
}

pub fn ml_regress_logistic_vector_zero(dim : Int) -> MlregresslogisticVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ml_regress_logistic_vector_add(a : MlregresslogisticVector, b : MlregresslogisticVector) -> MlregresslogisticVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_regress_logistic_vector_sub(a : MlregresslogisticVector, b : MlregresslogisticVector) -> MlregresslogisticVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_regress_logistic_vector_scale(v : MlregresslogisticVector, s : Double) -> MlregresslogisticVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ml_regress_logistic_vector_dot(a : MlregresslogisticVector, b : MlregresslogisticVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ml_regress_logistic_vector_norm(v : MlregresslogisticVector) -> Double { @_common.sqrt(ml_regress_logistic_vector_dot(v, v)) }

pub fn ml_regress_logistic_vector_normalize(v : MlregresslogisticVector) -> MlregresslogisticVector {
  let n = ml_regress_logistic_vector_norm(v)
  if n < 0.0000001 { v } else { ml_regress_logistic_vector_scale(v, 1.0 / n) }
}

pub fn ml_regress_logistic_vector_dist(a : MlregresslogisticVector, b : MlregresslogisticVector) -> Double {
  ml_regress_logistic_vector_norm(ml_regress_logistic_vector_sub(a, b))
}

pub fn ml_regress_logistic_vector_to_string(v : MlregresslogisticVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_regress_logistic_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_regress_logistic_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_regress_logistic_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_regress_logistic_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_regress_logistic_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_regress_logistic_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_regress_logistic_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_regress_logistic_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_regress_logistic_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_regress_logistic_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_regress_logistic_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_regress_logistic_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_regress_logistic_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_regress_logistic_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_regress_logistic_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_regress_logistic_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_regress_logistic_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_regress_logistic_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_regress_logistic_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_regress_logistic_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_regress_logistic_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_regress_logistic_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_regress_logistic_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_regress_logistic_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_regress_logistic_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_regress_logistic_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_regress_logistic_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_regress_logistic_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_regress_logistic_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlregresslogisticFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_logistic_frame_make(size : Int) -> MlregresslogisticFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_logistic_frame_len(s : MlregresslogisticFrame) -> Int { s.size }

pub fn ml_regress_logistic_frame_get(s : MlregresslogisticFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_logistic_frame_set(s : MlregresslogisticFrame, i : Int, v : Double) -> MlregresslogisticFrame {
  let result = ml_regress_logistic_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_logistic_frame_sum(s : MlregresslogisticFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_regress_logistic_frame_mean(s : MlregresslogisticFrame) -> Double {
  if s.size == 0 { 0.0 } else { ml_regress_logistic_frame_sum(s) / s.size.to_double() }
}

pub fn ml_regress_logistic_frame_scale(s : MlregresslogisticFrame, f : Double) -> MlregresslogisticFrame {
  let result = ml_regress_logistic_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_regress_logistic_frame_add(a : MlregresslogisticFrame, b : MlregresslogisticFrame) -> MlregresslogisticFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_regress_logistic_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_regress_logistic_frame_copy(s : MlregresslogisticFrame) -> MlregresslogisticFrame {
  let result = ml_regress_logistic_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_regress_logistic_frame_fill(s : MlregresslogisticFrame, v : Double) -> MlregresslogisticFrame {
  let result = ml_regress_logistic_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_regress_logistic_frame_min(s : MlregresslogisticFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_logistic_frame_max(s : MlregresslogisticFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_logistic_frame_to_string(s : MlregresslogisticFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresslogisticTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_logistic_table_make(size : Int) -> MlregresslogisticTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_logistic_table_len(s : MlregresslogisticTable) -> Int { s.size }

pub fn ml_regress_logistic_table_get(s : MlregresslogisticTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_logistic_table_set(s : MlregresslogisticTable, i : Int, v : Double) -> MlregresslogisticTable {
  let result = ml_regress_logistic_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_logistic_table_sum(s : MlregresslogisticTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_regress_logistic_table_mean(s : MlregresslogisticTable) -> Double {
  if s.size == 0 { 0.0 } else { ml_regress_logistic_table_sum(s) / s.size.to_double() }
}

pub fn ml_regress_logistic_table_scale(s : MlregresslogisticTable, f : Double) -> MlregresslogisticTable {
  let result = ml_regress_logistic_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_regress_logistic_table_add(a : MlregresslogisticTable, b : MlregresslogisticTable) -> MlregresslogisticTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_regress_logistic_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_regress_logistic_table_copy(s : MlregresslogisticTable) -> MlregresslogisticTable {
  let result = ml_regress_logistic_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_regress_logistic_table_fill(s : MlregresslogisticTable, v : Double) -> MlregresslogisticTable {
  let result = ml_regress_logistic_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_regress_logistic_table_min(s : MlregresslogisticTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_logistic_table_max(s : MlregresslogisticTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_logistic_table_to_string(s : MlregresslogisticTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresslogisticGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_logistic_graphn_make(size : Int) -> MlregresslogisticGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_logistic_graphn_len(s : MlregresslogisticGraphN) -> Int { s.size }

pub fn ml_regress_logistic_graphn_get(s : MlregresslogisticGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_logistic_graphn_set(s : MlregresslogisticGraphN, i : Int, v : Double) -> MlregresslogisticGraphN {
  let result = ml_regress_logistic_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_logistic_graphn_sum(s : MlregresslogisticGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_regress_logistic_graphn_mean(s : MlregresslogisticGraphN) -> Double {
  if s.size == 0 { 0.0 } else { ml_regress_logistic_graphn_sum(s) / s.size.to_double() }
}

pub fn ml_regress_logistic_graphn_scale(s : MlregresslogisticGraphN, f : Double) -> MlregresslogisticGraphN {
  let result = ml_regress_logistic_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_regress_logistic_graphn_add(a : MlregresslogisticGraphN, b : MlregresslogisticGraphN) -> MlregresslogisticGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_regress_logistic_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_regress_logistic_graphn_copy(s : MlregresslogisticGraphN) -> MlregresslogisticGraphN {
  let result = ml_regress_logistic_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_regress_logistic_graphn_fill(s : MlregresslogisticGraphN, v : Double) -> MlregresslogisticGraphN {
  let result = ml_regress_logistic_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_regress_logistic_graphn_min(s : MlregresslogisticGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_logistic_graphn_max(s : MlregresslogisticGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_logistic_graphn_to_string(s : MlregresslogisticGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresslogisticNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_logistic_node_make(size : Int) -> MlregresslogisticNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_logistic_node_len(s : MlregresslogisticNode) -> Int { s.size }

pub fn ml_regress_logistic_node_get(s : MlregresslogisticNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_logistic_node_set(s : MlregresslogisticNode, i : Int, v : Double) -> MlregresslogisticNode {
  let result = ml_regress_logistic_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_logistic_node_sum(s : MlregresslogisticNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_regress_logistic_node_mean(s : MlregresslogisticNode) -> Double {
  if s.size == 0 { 0.0 } else { ml_regress_logistic_node_sum(s) / s.size.to_double() }
}

pub fn ml_regress_logistic_node_scale(s : MlregresslogisticNode, f : Double) -> MlregresslogisticNode {
  let result = ml_regress_logistic_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_regress_logistic_node_add(a : MlregresslogisticNode, b : MlregresslogisticNode) -> MlregresslogisticNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_regress_logistic_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_regress_logistic_node_copy(s : MlregresslogisticNode) -> MlregresslogisticNode {
  let result = ml_regress_logistic_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_regress_logistic_node_fill(s : MlregresslogisticNode, v : Double) -> MlregresslogisticNode {
  let result = ml_regress_logistic_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_regress_logistic_node_min(s : MlregresslogisticNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_logistic_node_max(s : MlregresslogisticNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_logistic_node_to_string(s : MlregresslogisticNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresslogisticEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_logistic_edge_make(size : Int) -> MlregresslogisticEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_logistic_edge_len(s : MlregresslogisticEdge) -> Int { s.size }

pub fn ml_regress_logistic_edge_get(s : MlregresslogisticEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_logistic_edge_set(s : MlregresslogisticEdge, i : Int, v : Double) -> MlregresslogisticEdge {
  let result = ml_regress_logistic_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_logistic_edge_sum(s : MlregresslogisticEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_regress_logistic_edge_mean(s : MlregresslogisticEdge) -> Double {
  if s.size == 0 { 0.0 } else { ml_regress_logistic_edge_sum(s) / s.size.to_double() }
}

pub fn ml_regress_logistic_edge_scale(s : MlregresslogisticEdge, f : Double) -> MlregresslogisticEdge {
  let result = ml_regress_logistic_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_regress_logistic_edge_add(a : MlregresslogisticEdge, b : MlregresslogisticEdge) -> MlregresslogisticEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_regress_logistic_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_regress_logistic_edge_copy(s : MlregresslogisticEdge) -> MlregresslogisticEdge {
  let result = ml_regress_logistic_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_regress_logistic_edge_fill(s : MlregresslogisticEdge, v : Double) -> MlregresslogisticEdge {
  let result = ml_regress_logistic_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_regress_logistic_edge_min(s : MlregresslogisticEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_logistic_edge_max(s : MlregresslogisticEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_logistic_edge_to_string(s : MlregresslogisticEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresslogisticPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_logistic_path_make(size : Int) -> MlregresslogisticPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_logistic_path_len(s : MlregresslogisticPath) -> Int { s.size }

pub fn ml_regress_logistic_path_get(s : MlregresslogisticPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_logistic_path_set(s : MlregresslogisticPath, i : Int, v : Double) -> MlregresslogisticPath {
  let result = ml_regress_logistic_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_logistic_path_sum(s : MlregresslogisticPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_regress_logistic_path_mean(s : MlregresslogisticPath) -> Double {
  if s.size == 0 { 0.0 } else { ml_regress_logistic_path_sum(s) / s.size.to_double() }
}

pub fn ml_regress_logistic_path_scale(s : MlregresslogisticPath, f : Double) -> MlregresslogisticPath {
  let result = ml_regress_logistic_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_regress_logistic_path_add(a : MlregresslogisticPath, b : MlregresslogisticPath) -> MlregresslogisticPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_regress_logistic_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_regress_logistic_path_copy(s : MlregresslogisticPath) -> MlregresslogisticPath {
  let result = ml_regress_logistic_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_regress_logistic_path_fill(s : MlregresslogisticPath, v : Double) -> MlregresslogisticPath {
  let result = ml_regress_logistic_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_regress_logistic_path_min(s : MlregresslogisticPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_logistic_path_max(s : MlregresslogisticPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_logistic_path_to_string(s : MlregresslogisticPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresslogisticCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_logistic_cluster_make(size : Int) -> MlregresslogisticCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_logistic_cluster_len(s : MlregresslogisticCluster) -> Int { s.size }

pub fn ml_regress_logistic_cluster_get(s : MlregresslogisticCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_logistic_cluster_set(s : MlregresslogisticCluster, i : Int, v : Double) -> MlregresslogisticCluster {
  let result = ml_regress_logistic_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_logistic_cluster_sum(s : MlregresslogisticCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_regress_logistic_cluster_mean(s : MlregresslogisticCluster) -> Double {
  if s.size == 0 { 0.0 } else { ml_regress_logistic_cluster_sum(s) / s.size.to_double() }
}

pub fn ml_regress_logistic_cluster_scale(s : MlregresslogisticCluster, f : Double) -> MlregresslogisticCluster {
  let result = ml_regress_logistic_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_regress_logistic_cluster_add(a : MlregresslogisticCluster, b : MlregresslogisticCluster) -> MlregresslogisticCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_regress_logistic_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_regress_logistic_cluster_copy(s : MlregresslogisticCluster) -> MlregresslogisticCluster {
  let result = ml_regress_logistic_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_regress_logistic_cluster_fill(s : MlregresslogisticCluster, v : Double) -> MlregresslogisticCluster {
  let result = ml_regress_logistic_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_regress_logistic_cluster_min(s : MlregresslogisticCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_logistic_cluster_max(s : MlregresslogisticCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_logistic_cluster_to_string(s : MlregresslogisticCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresslogisticModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_logistic_model_make(size : Int) -> MlregresslogisticModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_logistic_model_len(s : MlregresslogisticModel) -> Int { s.size }

pub fn ml_regress_logistic_model_get(s : MlregresslogisticModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_logistic_model_set(s : MlregresslogisticModel, i : Int, v : Double) -> MlregresslogisticModel {
  let result = ml_regress_logistic_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_logistic_model_sum(s : MlregresslogisticModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_regress_logistic_model_mean(s : MlregresslogisticModel) -> Double {
  if s.size == 0 { 0.0 } else { ml_regress_logistic_model_sum(s) / s.size.to_double() }
}

pub fn ml_regress_logistic_model_scale(s : MlregresslogisticModel, f : Double) -> MlregresslogisticModel {
  let result = ml_regress_logistic_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_regress_logistic_model_add(a : MlregresslogisticModel, b : MlregresslogisticModel) -> MlregresslogisticModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_regress_logistic_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_regress_logistic_model_copy(s : MlregresslogisticModel) -> MlregresslogisticModel {
  let result = ml_regress_logistic_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_regress_logistic_model_fill(s : MlregresslogisticModel, v : Double) -> MlregresslogisticModel {
  let result = ml_regress_logistic_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_regress_logistic_model_min(s : MlregresslogisticModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_logistic_model_max(s : MlregresslogisticModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_logistic_model_to_string(s : MlregresslogisticModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresslogisticLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_logistic_layer_make(size : Int) -> MlregresslogisticLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_logistic_layer_len(s : MlregresslogisticLayer) -> Int { s.size }

pub fn ml_regress_logistic_layer_get(s : MlregresslogisticLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_logistic_layer_set(s : MlregresslogisticLayer, i : Int, v : Double) -> MlregresslogisticLayer {
  let result = ml_regress_logistic_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_logistic_layer_sum(s : MlregresslogisticLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_regress_logistic_layer_mean(s : MlregresslogisticLayer) -> Double {
  if s.size == 0 { 0.0 } else { ml_regress_logistic_layer_sum(s) / s.size.to_double() }
}

pub fn ml_regress_logistic_layer_scale(s : MlregresslogisticLayer, f : Double) -> MlregresslogisticLayer {
  let result = ml_regress_logistic_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_regress_logistic_layer_add(a : MlregresslogisticLayer, b : MlregresslogisticLayer) -> MlregresslogisticLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_regress_logistic_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_regress_logistic_layer_copy(s : MlregresslogisticLayer) -> MlregresslogisticLayer {
  let result = ml_regress_logistic_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_regress_logistic_layer_fill(s : MlregresslogisticLayer, v : Double) -> MlregresslogisticLayer {
  let result = ml_regress_logistic_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_regress_logistic_layer_min(s : MlregresslogisticLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_logistic_layer_max(s : MlregresslogisticLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_logistic_layer_to_string(s : MlregresslogisticLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresslogisticBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_logistic_buffer_make(size : Int) -> MlregresslogisticBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_logistic_buffer_len(s : MlregresslogisticBuffer) -> Int { s.size }

pub fn ml_regress_logistic_buffer_get(s : MlregresslogisticBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_logistic_buffer_set(s : MlregresslogisticBuffer, i : Int, v : Double) -> MlregresslogisticBuffer {
  let result = ml_regress_logistic_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_logistic_buffer_sum(s : MlregresslogisticBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_regress_logistic_buffer_mean(s : MlregresslogisticBuffer) -> Double {
  if s.size == 0 { 0.0 } else { ml_regress_logistic_buffer_sum(s) / s.size.to_double() }
}

pub fn ml_regress_logistic_buffer_scale(s : MlregresslogisticBuffer, f : Double) -> MlregresslogisticBuffer {
  let result = ml_regress_logistic_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_regress_logistic_buffer_add(a : MlregresslogisticBuffer, b : MlregresslogisticBuffer) -> MlregresslogisticBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_regress_logistic_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_regress_logistic_buffer_copy(s : MlregresslogisticBuffer) -> MlregresslogisticBuffer {
  let result = ml_regress_logistic_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_regress_logistic_buffer_fill(s : MlregresslogisticBuffer, v : Double) -> MlregresslogisticBuffer {
  let result = ml_regress_logistic_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_regress_logistic_buffer_min(s : MlregresslogisticBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_logistic_buffer_max(s : MlregresslogisticBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_logistic_buffer_to_string(s : MlregresslogisticBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresslogisticCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_logistic_cursor_make(size : Int) -> MlregresslogisticCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_logistic_cursor_len(s : MlregresslogisticCursor) -> Int { s.size }

pub fn ml_regress_logistic_cursor_get(s : MlregresslogisticCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_logistic_cursor_set(s : MlregresslogisticCursor, i : Int, v : Double) -> MlregresslogisticCursor {
  let result = ml_regress_logistic_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_logistic_cursor_sum(s : MlregresslogisticCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_regress_logistic_cursor_mean(s : MlregresslogisticCursor) -> Double {
  if s.size == 0 { 0.0 } else { ml_regress_logistic_cursor_sum(s) / s.size.to_double() }
}

pub fn ml_regress_logistic_cursor_scale(s : MlregresslogisticCursor, f : Double) -> MlregresslogisticCursor {
  let result = ml_regress_logistic_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_regress_logistic_cursor_add(a : MlregresslogisticCursor, b : MlregresslogisticCursor) -> MlregresslogisticCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_regress_logistic_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_regress_logistic_cursor_copy(s : MlregresslogisticCursor) -> MlregresslogisticCursor {
  let result = ml_regress_logistic_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_regress_logistic_cursor_fill(s : MlregresslogisticCursor, v : Double) -> MlregresslogisticCursor {
  let result = ml_regress_logistic_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_regress_logistic_cursor_min(s : MlregresslogisticCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_logistic_cursor_max(s : MlregresslogisticCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_logistic_cursor_to_string(s : MlregresslogisticCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresslogisticView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_logistic_view_make(size : Int) -> MlregresslogisticView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_logistic_view_len(s : MlregresslogisticView) -> Int { s.size }

pub fn ml_regress_logistic_view_get(s : MlregresslogisticView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_logistic_view_set(s : MlregresslogisticView, i : Int, v : Double) -> MlregresslogisticView {
  let result = ml_regress_logistic_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_logistic_view_sum(s : MlregresslogisticView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_regress_logistic_view_mean(s : MlregresslogisticView) -> Double {
  if s.size == 0 { 0.0 } else { ml_regress_logistic_view_sum(s) / s.size.to_double() }
}

pub fn ml_regress_logistic_view_scale(s : MlregresslogisticView, f : Double) -> MlregresslogisticView {
  let result = ml_regress_logistic_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_regress_logistic_view_add(a : MlregresslogisticView, b : MlregresslogisticView) -> MlregresslogisticView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_regress_logistic_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_regress_logistic_view_copy(s : MlregresslogisticView) -> MlregresslogisticView {
  let result = ml_regress_logistic_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_regress_logistic_view_fill(s : MlregresslogisticView, v : Double) -> MlregresslogisticView {
  let result = ml_regress_logistic_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_regress_logistic_view_min(s : MlregresslogisticView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_logistic_view_max(s : MlregresslogisticView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_logistic_view_to_string(s : MlregresslogisticView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresslogisticRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_logistic_range_make(size : Int) -> MlregresslogisticRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_logistic_range_len(s : MlregresslogisticRange) -> Int { s.size }

pub fn ml_regress_logistic_range_get(s : MlregresslogisticRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_logistic_range_set(s : MlregresslogisticRange, i : Int, v : Double) -> MlregresslogisticRange {
  let result = ml_regress_logistic_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_logistic_range_sum(s : MlregresslogisticRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_regress_logistic_range_mean(s : MlregresslogisticRange) -> Double {
  if s.size == 0 { 0.0 } else { ml_regress_logistic_range_sum(s) / s.size.to_double() }
}

pub fn ml_regress_logistic_range_scale(s : MlregresslogisticRange, f : Double) -> MlregresslogisticRange {
  let result = ml_regress_logistic_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_regress_logistic_range_add(a : MlregresslogisticRange, b : MlregresslogisticRange) -> MlregresslogisticRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_regress_logistic_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_regress_logistic_range_copy(s : MlregresslogisticRange) -> MlregresslogisticRange {
  let result = ml_regress_logistic_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_regress_logistic_range_fill(s : MlregresslogisticRange, v : Double) -> MlregresslogisticRange {
  let result = ml_regress_logistic_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_regress_logistic_range_min(s : MlregresslogisticRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_logistic_range_max(s : MlregresslogisticRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_logistic_range_to_string(s : MlregresslogisticRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresslogisticSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_logistic_slice_make(size : Int) -> MlregresslogisticSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_logistic_slice_len(s : MlregresslogisticSlice) -> Int { s.size }

pub fn ml_regress_logistic_slice_get(s : MlregresslogisticSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_logistic_slice_set(s : MlregresslogisticSlice, i : Int, v : Double) -> MlregresslogisticSlice {
  let result = ml_regress_logistic_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_logistic_slice_sum(s : MlregresslogisticSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_regress_logistic_slice_mean(s : MlregresslogisticSlice) -> Double {
  if s.size == 0 { 0.0 } else { ml_regress_logistic_slice_sum(s) / s.size.to_double() }
}

pub fn ml_regress_logistic_slice_scale(s : MlregresslogisticSlice, f : Double) -> MlregresslogisticSlice {
  let result = ml_regress_logistic_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_regress_logistic_slice_add(a : MlregresslogisticSlice, b : MlregresslogisticSlice) -> MlregresslogisticSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_regress_logistic_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_regress_logistic_slice_copy(s : MlregresslogisticSlice) -> MlregresslogisticSlice {
  let result = ml_regress_logistic_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_regress_logistic_slice_fill(s : MlregresslogisticSlice, v : Double) -> MlregresslogisticSlice {
  let result = ml_regress_logistic_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_regress_logistic_slice_min(s : MlregresslogisticSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_logistic_slice_max(s : MlregresslogisticSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_logistic_slice_to_string(s : MlregresslogisticSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


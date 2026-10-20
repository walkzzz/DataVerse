///===
/// extcore/ml_ensemble_adaboost

pub(all) struct MlensembleadaboostPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_ensemble_adaboost_make_point(x : Double, y : Double) -> MlensembleadaboostPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_ensemble_adaboost_make_point3(x : Double, y : Double, z : Double) -> MlensembleadaboostPoint {
  { x, y, z, label: 0 }
}

pub fn ml_ensemble_adaboost_point_x(pt : MlensembleadaboostPoint) -> Double { pt.x }

pub fn ml_ensemble_adaboost_point_y(pt : MlensembleadaboostPoint) -> Double { pt.y }

pub fn ml_ensemble_adaboost_point_z(pt : MlensembleadaboostPoint) -> Double { pt.z }

pub fn ml_ensemble_adaboost_point_label(pt : MlensembleadaboostPoint) -> Int { pt.label }

pub fn ml_ensemble_adaboost_point_dist(a : MlensembleadaboostPoint, b : MlensembleadaboostPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ml_ensemble_adaboost_point_add(a : MlensembleadaboostPoint, b : MlensembleadaboostPoint) -> MlensembleadaboostPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ml_ensemble_adaboost_point_sub(a : MlensembleadaboostPoint, b : MlensembleadaboostPoint) -> MlensembleadaboostPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ml_ensemble_adaboost_point_scale(pt : MlensembleadaboostPoint, s : Double) -> MlensembleadaboostPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ml_ensemble_adaboost_point_dot(a : MlensembleadaboostPoint, b : MlensembleadaboostPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ml_ensemble_adaboost_point_cross(a : MlensembleadaboostPoint, b : MlensembleadaboostPoint) -> MlensembleadaboostPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ml_ensemble_adaboost_point_norm(pt : MlensembleadaboostPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ml_ensemble_adaboost_point_normalize(pt : MlensembleadaboostPoint) -> MlensembleadaboostPoint {
  let n = ml_ensemble_adaboost_point_norm(pt)
  if n < 0.0000001 { pt } else { ml_ensemble_adaboost_point_scale(pt, 1.0 / n) }
}

pub fn ml_ensemble_adaboost_point_negate(pt : MlensembleadaboostPoint) -> MlensembleadaboostPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ml_ensemble_adaboost_point_mid(a : MlensembleadaboostPoint, b : MlensembleadaboostPoint) -> MlensembleadaboostPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ml_ensemble_adaboost_point_lerp(a : MlensembleadaboostPoint, b : MlensembleadaboostPoint, t : Double) -> MlensembleadaboostPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ml_ensemble_adaboost_point_to_string(pt : MlensembleadaboostPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MlensembleadaboostSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_ensemble_adaboost_make_series(vals : Array[Double], name : String) -> MlensembleadaboostSeries {
  { vals, name, meta: 0 }
}

pub fn ml_ensemble_adaboost_series_len(s : MlensembleadaboostSeries) -> Int { s.vals.length() }

pub fn ml_ensemble_adaboost_series_sum(s : MlensembleadaboostSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn ml_ensemble_adaboost_series_mean(s : MlensembleadaboostSeries) -> Double { @_common.mean(s.vals) }

pub fn ml_ensemble_adaboost_series_min(s : MlensembleadaboostSeries) -> Double { @_common.min(s.vals) }

pub fn ml_ensemble_adaboost_series_max(s : MlensembleadaboostSeries) -> Double { @_common.max(s.vals) }

pub fn ml_ensemble_adaboost_series_range(s : MlensembleadaboostSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn ml_ensemble_adaboost_series_var(s : MlensembleadaboostSeries) -> Double { @_common.variance(s.vals) }

pub fn ml_ensemble_adaboost_series_std(s : MlensembleadaboostSeries) -> Double { @_common.std(s.vals) }

pub fn ml_ensemble_adaboost_series_median(s : MlensembleadaboostSeries) -> Double { @_common.median(s.vals) }

pub fn ml_ensemble_adaboost_series_scale(s : MlensembleadaboostSeries, f : Double) -> MlensembleadaboostSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ml_ensemble_adaboost_series_add(a : MlensembleadaboostSeries, b : MlensembleadaboostSeries) -> MlensembleadaboostSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ml_ensemble_adaboost_series_sub(a : MlensembleadaboostSeries, b : MlensembleadaboostSeries) -> MlensembleadaboostSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ml_ensemble_adaboost_series_normalize(s : MlensembleadaboostSeries) -> MlensembleadaboostSeries {
  let mn = ml_ensemble_adaboost_series_min(s)
  let mx = ml_ensemble_adaboost_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ml_ensemble_adaboost_series_cumsum(s : MlensembleadaboostSeries) -> MlensembleadaboostSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn ml_ensemble_adaboost_series_to_string(s : MlensembleadaboostSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlensembleadaboostMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_ensemble_adaboost_make_matrix(rows : Int, cols : Int, val : Double) -> MlensembleadaboostMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_ensemble_adaboost_matrix_identity(n : Int) -> MlensembleadaboostMatrix {
  let m = ml_ensemble_adaboost_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ml_ensemble_adaboost_matrix_get(m : MlensembleadaboostMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ml_ensemble_adaboost_matrix_transpose(m : MlensembleadaboostMatrix) -> MlensembleadaboostMatrix {
  let result = ml_ensemble_adaboost_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ml_ensemble_adaboost_matrix_add(a : MlensembleadaboostMatrix, b : MlensembleadaboostMatrix) -> MlensembleadaboostMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ml_ensemble_adaboost_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ml_ensemble_adaboost_matrix_scale(m : MlensembleadaboostMatrix, s : Double) -> MlensembleadaboostMatrix {
  let result = ml_ensemble_adaboost_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ml_ensemble_adaboost_matrix_multiply(a : MlensembleadaboostMatrix, b : MlensembleadaboostMatrix) -> MlensembleadaboostMatrix {
  if a.cols != b.rows { return ml_ensemble_adaboost_make_matrix(a.rows, b.cols, 0.0) }
  let result = ml_ensemble_adaboost_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ml_ensemble_adaboost_matrix_trace(m : MlensembleadaboostMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ml_ensemble_adaboost_matrix_det(m : MlensembleadaboostMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ml_ensemble_adaboost_matrix_norm(m : MlensembleadaboostMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ml_ensemble_adaboost_matrix_to_string(m : MlensembleadaboostMatrix) -> String {
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

pub(all) struct MlensembleadaboostVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_ensemble_adaboost_make_vector(comps : Array[Double]) -> MlensembleadaboostVector {
  { comps, dim: comps.length() }
}

pub fn ml_ensemble_adaboost_vector_zero(dim : Int) -> MlensembleadaboostVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ml_ensemble_adaboost_vector_add(a : MlensembleadaboostVector, b : MlensembleadaboostVector) -> MlensembleadaboostVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_ensemble_adaboost_vector_sub(a : MlensembleadaboostVector, b : MlensembleadaboostVector) -> MlensembleadaboostVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_ensemble_adaboost_vector_scale(v : MlensembleadaboostVector, s : Double) -> MlensembleadaboostVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ml_ensemble_adaboost_vector_dot(a : MlensembleadaboostVector, b : MlensembleadaboostVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ml_ensemble_adaboost_vector_norm(v : MlensembleadaboostVector) -> Double { @_common.sqrt(ml_ensemble_adaboost_vector_dot(v, v)) }

pub fn ml_ensemble_adaboost_vector_normalize(v : MlensembleadaboostVector) -> MlensembleadaboostVector {
  let n = ml_ensemble_adaboost_vector_norm(v)
  if n < 0.0000001 { v } else { ml_ensemble_adaboost_vector_scale(v, 1.0 / n) }
}

pub fn ml_ensemble_adaboost_vector_dist(a : MlensembleadaboostVector, b : MlensembleadaboostVector) -> Double {
  ml_ensemble_adaboost_vector_norm(ml_ensemble_adaboost_vector_sub(a, b))
}

pub fn ml_ensemble_adaboost_vector_to_string(v : MlensembleadaboostVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_ensemble_adaboost_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_ensemble_adaboost_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_ensemble_adaboost_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_ensemble_adaboost_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_ensemble_adaboost_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_ensemble_adaboost_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_ensemble_adaboost_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_ensemble_adaboost_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_ensemble_adaboost_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_ensemble_adaboost_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_ensemble_adaboost_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_ensemble_adaboost_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_ensemble_adaboost_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_ensemble_adaboost_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_ensemble_adaboost_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_ensemble_adaboost_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_ensemble_adaboost_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_ensemble_adaboost_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_ensemble_adaboost_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_ensemble_adaboost_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_ensemble_adaboost_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_ensemble_adaboost_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_ensemble_adaboost_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_ensemble_adaboost_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_ensemble_adaboost_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_ensemble_adaboost_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_ensemble_adaboost_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_ensemble_adaboost_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_ensemble_adaboost_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlensembleadaboostFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_adaboost_frame_make(size : Int) -> MlensembleadaboostFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_adaboost_frame_len(s : MlensembleadaboostFrame) -> Int { s.size }

pub fn ml_ensemble_adaboost_frame_get(s : MlensembleadaboostFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_adaboost_frame_set(s : MlensembleadaboostFrame, i : Int, v : Double) -> MlensembleadaboostFrame {
  let result = ml_ensemble_adaboost_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_adaboost_frame_sum(s : MlensembleadaboostFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_adaboost_frame_mean(s : MlensembleadaboostFrame) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_adaboost_frame_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_adaboost_frame_scale(s : MlensembleadaboostFrame, f : Double) -> MlensembleadaboostFrame {
  let result = ml_ensemble_adaboost_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_adaboost_frame_add(a : MlensembleadaboostFrame, b : MlensembleadaboostFrame) -> MlensembleadaboostFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_adaboost_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_adaboost_frame_copy(s : MlensembleadaboostFrame) -> MlensembleadaboostFrame {
  let result = ml_ensemble_adaboost_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_adaboost_frame_fill(s : MlensembleadaboostFrame, v : Double) -> MlensembleadaboostFrame {
  let result = ml_ensemble_adaboost_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_adaboost_frame_min(s : MlensembleadaboostFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_adaboost_frame_max(s : MlensembleadaboostFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_adaboost_frame_to_string(s : MlensembleadaboostFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensembleadaboostTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_adaboost_table_make(size : Int) -> MlensembleadaboostTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_adaboost_table_len(s : MlensembleadaboostTable) -> Int { s.size }

pub fn ml_ensemble_adaboost_table_get(s : MlensembleadaboostTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_adaboost_table_set(s : MlensembleadaboostTable, i : Int, v : Double) -> MlensembleadaboostTable {
  let result = ml_ensemble_adaboost_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_adaboost_table_sum(s : MlensembleadaboostTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_adaboost_table_mean(s : MlensembleadaboostTable) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_adaboost_table_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_adaboost_table_scale(s : MlensembleadaboostTable, f : Double) -> MlensembleadaboostTable {
  let result = ml_ensemble_adaboost_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_adaboost_table_add(a : MlensembleadaboostTable, b : MlensembleadaboostTable) -> MlensembleadaboostTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_adaboost_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_adaboost_table_copy(s : MlensembleadaboostTable) -> MlensembleadaboostTable {
  let result = ml_ensemble_adaboost_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_adaboost_table_fill(s : MlensembleadaboostTable, v : Double) -> MlensembleadaboostTable {
  let result = ml_ensemble_adaboost_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_adaboost_table_min(s : MlensembleadaboostTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_adaboost_table_max(s : MlensembleadaboostTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_adaboost_table_to_string(s : MlensembleadaboostTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensembleadaboostGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_adaboost_graphn_make(size : Int) -> MlensembleadaboostGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_adaboost_graphn_len(s : MlensembleadaboostGraphN) -> Int { s.size }

pub fn ml_ensemble_adaboost_graphn_get(s : MlensembleadaboostGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_adaboost_graphn_set(s : MlensembleadaboostGraphN, i : Int, v : Double) -> MlensembleadaboostGraphN {
  let result = ml_ensemble_adaboost_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_adaboost_graphn_sum(s : MlensembleadaboostGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_adaboost_graphn_mean(s : MlensembleadaboostGraphN) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_adaboost_graphn_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_adaboost_graphn_scale(s : MlensembleadaboostGraphN, f : Double) -> MlensembleadaboostGraphN {
  let result = ml_ensemble_adaboost_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_adaboost_graphn_add(a : MlensembleadaboostGraphN, b : MlensembleadaboostGraphN) -> MlensembleadaboostGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_adaboost_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_adaboost_graphn_copy(s : MlensembleadaboostGraphN) -> MlensembleadaboostGraphN {
  let result = ml_ensemble_adaboost_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_adaboost_graphn_fill(s : MlensembleadaboostGraphN, v : Double) -> MlensembleadaboostGraphN {
  let result = ml_ensemble_adaboost_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_adaboost_graphn_min(s : MlensembleadaboostGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_adaboost_graphn_max(s : MlensembleadaboostGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_adaboost_graphn_to_string(s : MlensembleadaboostGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensembleadaboostNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_adaboost_node_make(size : Int) -> MlensembleadaboostNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_adaboost_node_len(s : MlensembleadaboostNode) -> Int { s.size }

pub fn ml_ensemble_adaboost_node_get(s : MlensembleadaboostNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_adaboost_node_set(s : MlensembleadaboostNode, i : Int, v : Double) -> MlensembleadaboostNode {
  let result = ml_ensemble_adaboost_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_adaboost_node_sum(s : MlensembleadaboostNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_adaboost_node_mean(s : MlensembleadaboostNode) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_adaboost_node_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_adaboost_node_scale(s : MlensembleadaboostNode, f : Double) -> MlensembleadaboostNode {
  let result = ml_ensemble_adaboost_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_adaboost_node_add(a : MlensembleadaboostNode, b : MlensembleadaboostNode) -> MlensembleadaboostNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_adaboost_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_adaboost_node_copy(s : MlensembleadaboostNode) -> MlensembleadaboostNode {
  let result = ml_ensemble_adaboost_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_adaboost_node_fill(s : MlensembleadaboostNode, v : Double) -> MlensembleadaboostNode {
  let result = ml_ensemble_adaboost_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_adaboost_node_min(s : MlensembleadaboostNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_adaboost_node_max(s : MlensembleadaboostNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_adaboost_node_to_string(s : MlensembleadaboostNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensembleadaboostEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_adaboost_edge_make(size : Int) -> MlensembleadaboostEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_adaboost_edge_len(s : MlensembleadaboostEdge) -> Int { s.size }

pub fn ml_ensemble_adaboost_edge_get(s : MlensembleadaboostEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_adaboost_edge_set(s : MlensembleadaboostEdge, i : Int, v : Double) -> MlensembleadaboostEdge {
  let result = ml_ensemble_adaboost_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_adaboost_edge_sum(s : MlensembleadaboostEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_adaboost_edge_mean(s : MlensembleadaboostEdge) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_adaboost_edge_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_adaboost_edge_scale(s : MlensembleadaboostEdge, f : Double) -> MlensembleadaboostEdge {
  let result = ml_ensemble_adaboost_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_adaboost_edge_add(a : MlensembleadaboostEdge, b : MlensembleadaboostEdge) -> MlensembleadaboostEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_adaboost_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_adaboost_edge_copy(s : MlensembleadaboostEdge) -> MlensembleadaboostEdge {
  let result = ml_ensemble_adaboost_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_adaboost_edge_fill(s : MlensembleadaboostEdge, v : Double) -> MlensembleadaboostEdge {
  let result = ml_ensemble_adaboost_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_adaboost_edge_min(s : MlensembleadaboostEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_adaboost_edge_max(s : MlensembleadaboostEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_adaboost_edge_to_string(s : MlensembleadaboostEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensembleadaboostPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_adaboost_path_make(size : Int) -> MlensembleadaboostPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_adaboost_path_len(s : MlensembleadaboostPath) -> Int { s.size }

pub fn ml_ensemble_adaboost_path_get(s : MlensembleadaboostPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_adaboost_path_set(s : MlensembleadaboostPath, i : Int, v : Double) -> MlensembleadaboostPath {
  let result = ml_ensemble_adaboost_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_adaboost_path_sum(s : MlensembleadaboostPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_adaboost_path_mean(s : MlensembleadaboostPath) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_adaboost_path_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_adaboost_path_scale(s : MlensembleadaboostPath, f : Double) -> MlensembleadaboostPath {
  let result = ml_ensemble_adaboost_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_adaboost_path_add(a : MlensembleadaboostPath, b : MlensembleadaboostPath) -> MlensembleadaboostPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_adaboost_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_adaboost_path_copy(s : MlensembleadaboostPath) -> MlensembleadaboostPath {
  let result = ml_ensemble_adaboost_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_adaboost_path_fill(s : MlensembleadaboostPath, v : Double) -> MlensembleadaboostPath {
  let result = ml_ensemble_adaboost_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_adaboost_path_min(s : MlensembleadaboostPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_adaboost_path_max(s : MlensembleadaboostPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_adaboost_path_to_string(s : MlensembleadaboostPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensembleadaboostCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_adaboost_cluster_make(size : Int) -> MlensembleadaboostCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_adaboost_cluster_len(s : MlensembleadaboostCluster) -> Int { s.size }

pub fn ml_ensemble_adaboost_cluster_get(s : MlensembleadaboostCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_adaboost_cluster_set(s : MlensembleadaboostCluster, i : Int, v : Double) -> MlensembleadaboostCluster {
  let result = ml_ensemble_adaboost_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_adaboost_cluster_sum(s : MlensembleadaboostCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_adaboost_cluster_mean(s : MlensembleadaboostCluster) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_adaboost_cluster_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_adaboost_cluster_scale(s : MlensembleadaboostCluster, f : Double) -> MlensembleadaboostCluster {
  let result = ml_ensemble_adaboost_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_adaboost_cluster_add(a : MlensembleadaboostCluster, b : MlensembleadaboostCluster) -> MlensembleadaboostCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_adaboost_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_adaboost_cluster_copy(s : MlensembleadaboostCluster) -> MlensembleadaboostCluster {
  let result = ml_ensemble_adaboost_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_adaboost_cluster_fill(s : MlensembleadaboostCluster, v : Double) -> MlensembleadaboostCluster {
  let result = ml_ensemble_adaboost_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_adaboost_cluster_min(s : MlensembleadaboostCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_adaboost_cluster_max(s : MlensembleadaboostCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_adaboost_cluster_to_string(s : MlensembleadaboostCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensembleadaboostModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_adaboost_model_make(size : Int) -> MlensembleadaboostModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_adaboost_model_len(s : MlensembleadaboostModel) -> Int { s.size }

pub fn ml_ensemble_adaboost_model_get(s : MlensembleadaboostModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_adaboost_model_set(s : MlensembleadaboostModel, i : Int, v : Double) -> MlensembleadaboostModel {
  let result = ml_ensemble_adaboost_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_adaboost_model_sum(s : MlensembleadaboostModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_adaboost_model_mean(s : MlensembleadaboostModel) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_adaboost_model_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_adaboost_model_scale(s : MlensembleadaboostModel, f : Double) -> MlensembleadaboostModel {
  let result = ml_ensemble_adaboost_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_adaboost_model_add(a : MlensembleadaboostModel, b : MlensembleadaboostModel) -> MlensembleadaboostModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_adaboost_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_adaboost_model_copy(s : MlensembleadaboostModel) -> MlensembleadaboostModel {
  let result = ml_ensemble_adaboost_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_adaboost_model_fill(s : MlensembleadaboostModel, v : Double) -> MlensembleadaboostModel {
  let result = ml_ensemble_adaboost_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_adaboost_model_min(s : MlensembleadaboostModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_adaboost_model_max(s : MlensembleadaboostModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_adaboost_model_to_string(s : MlensembleadaboostModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensembleadaboostLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_adaboost_layer_make(size : Int) -> MlensembleadaboostLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_adaboost_layer_len(s : MlensembleadaboostLayer) -> Int { s.size }

pub fn ml_ensemble_adaboost_layer_get(s : MlensembleadaboostLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_adaboost_layer_set(s : MlensembleadaboostLayer, i : Int, v : Double) -> MlensembleadaboostLayer {
  let result = ml_ensemble_adaboost_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_adaboost_layer_sum(s : MlensembleadaboostLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_adaboost_layer_mean(s : MlensembleadaboostLayer) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_adaboost_layer_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_adaboost_layer_scale(s : MlensembleadaboostLayer, f : Double) -> MlensembleadaboostLayer {
  let result = ml_ensemble_adaboost_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_adaboost_layer_add(a : MlensembleadaboostLayer, b : MlensembleadaboostLayer) -> MlensembleadaboostLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_adaboost_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_adaboost_layer_copy(s : MlensembleadaboostLayer) -> MlensembleadaboostLayer {
  let result = ml_ensemble_adaboost_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_adaboost_layer_fill(s : MlensembleadaboostLayer, v : Double) -> MlensembleadaboostLayer {
  let result = ml_ensemble_adaboost_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_adaboost_layer_min(s : MlensembleadaboostLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_adaboost_layer_max(s : MlensembleadaboostLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_adaboost_layer_to_string(s : MlensembleadaboostLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensembleadaboostBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_adaboost_buffer_make(size : Int) -> MlensembleadaboostBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_adaboost_buffer_len(s : MlensembleadaboostBuffer) -> Int { s.size }

pub fn ml_ensemble_adaboost_buffer_get(s : MlensembleadaboostBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_adaboost_buffer_set(s : MlensembleadaboostBuffer, i : Int, v : Double) -> MlensembleadaboostBuffer {
  let result = ml_ensemble_adaboost_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_adaboost_buffer_sum(s : MlensembleadaboostBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_adaboost_buffer_mean(s : MlensembleadaboostBuffer) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_adaboost_buffer_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_adaboost_buffer_scale(s : MlensembleadaboostBuffer, f : Double) -> MlensembleadaboostBuffer {
  let result = ml_ensemble_adaboost_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_adaboost_buffer_add(a : MlensembleadaboostBuffer, b : MlensembleadaboostBuffer) -> MlensembleadaboostBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_adaboost_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_adaboost_buffer_copy(s : MlensembleadaboostBuffer) -> MlensembleadaboostBuffer {
  let result = ml_ensemble_adaboost_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_adaboost_buffer_fill(s : MlensembleadaboostBuffer, v : Double) -> MlensembleadaboostBuffer {
  let result = ml_ensemble_adaboost_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_adaboost_buffer_min(s : MlensembleadaboostBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_adaboost_buffer_max(s : MlensembleadaboostBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_adaboost_buffer_to_string(s : MlensembleadaboostBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensembleadaboostCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_adaboost_cursor_make(size : Int) -> MlensembleadaboostCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_adaboost_cursor_len(s : MlensembleadaboostCursor) -> Int { s.size }

pub fn ml_ensemble_adaboost_cursor_get(s : MlensembleadaboostCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_adaboost_cursor_set(s : MlensembleadaboostCursor, i : Int, v : Double) -> MlensembleadaboostCursor {
  let result = ml_ensemble_adaboost_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_adaboost_cursor_sum(s : MlensembleadaboostCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_adaboost_cursor_mean(s : MlensembleadaboostCursor) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_adaboost_cursor_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_adaboost_cursor_scale(s : MlensembleadaboostCursor, f : Double) -> MlensembleadaboostCursor {
  let result = ml_ensemble_adaboost_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_adaboost_cursor_add(a : MlensembleadaboostCursor, b : MlensembleadaboostCursor) -> MlensembleadaboostCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_adaboost_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_adaboost_cursor_copy(s : MlensembleadaboostCursor) -> MlensembleadaboostCursor {
  let result = ml_ensemble_adaboost_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_adaboost_cursor_fill(s : MlensembleadaboostCursor, v : Double) -> MlensembleadaboostCursor {
  let result = ml_ensemble_adaboost_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_adaboost_cursor_min(s : MlensembleadaboostCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_adaboost_cursor_max(s : MlensembleadaboostCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_adaboost_cursor_to_string(s : MlensembleadaboostCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensembleadaboostView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_adaboost_view_make(size : Int) -> MlensembleadaboostView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_adaboost_view_len(s : MlensembleadaboostView) -> Int { s.size }

pub fn ml_ensemble_adaboost_view_get(s : MlensembleadaboostView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_adaboost_view_set(s : MlensembleadaboostView, i : Int, v : Double) -> MlensembleadaboostView {
  let result = ml_ensemble_adaboost_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_adaboost_view_sum(s : MlensembleadaboostView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_adaboost_view_mean(s : MlensembleadaboostView) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_adaboost_view_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_adaboost_view_scale(s : MlensembleadaboostView, f : Double) -> MlensembleadaboostView {
  let result = ml_ensemble_adaboost_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_adaboost_view_add(a : MlensembleadaboostView, b : MlensembleadaboostView) -> MlensembleadaboostView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_adaboost_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_adaboost_view_copy(s : MlensembleadaboostView) -> MlensembleadaboostView {
  let result = ml_ensemble_adaboost_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_adaboost_view_fill(s : MlensembleadaboostView, v : Double) -> MlensembleadaboostView {
  let result = ml_ensemble_adaboost_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_adaboost_view_min(s : MlensembleadaboostView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_adaboost_view_max(s : MlensembleadaboostView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_adaboost_view_to_string(s : MlensembleadaboostView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensembleadaboostRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_adaboost_range_make(size : Int) -> MlensembleadaboostRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_adaboost_range_len(s : MlensembleadaboostRange) -> Int { s.size }

pub fn ml_ensemble_adaboost_range_get(s : MlensembleadaboostRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_adaboost_range_set(s : MlensembleadaboostRange, i : Int, v : Double) -> MlensembleadaboostRange {
  let result = ml_ensemble_adaboost_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_adaboost_range_sum(s : MlensembleadaboostRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_adaboost_range_mean(s : MlensembleadaboostRange) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_adaboost_range_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_adaboost_range_scale(s : MlensembleadaboostRange, f : Double) -> MlensembleadaboostRange {
  let result = ml_ensemble_adaboost_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_adaboost_range_add(a : MlensembleadaboostRange, b : MlensembleadaboostRange) -> MlensembleadaboostRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_adaboost_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_adaboost_range_copy(s : MlensembleadaboostRange) -> MlensembleadaboostRange {
  let result = ml_ensemble_adaboost_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_adaboost_range_fill(s : MlensembleadaboostRange, v : Double) -> MlensembleadaboostRange {
  let result = ml_ensemble_adaboost_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_adaboost_range_min(s : MlensembleadaboostRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_adaboost_range_max(s : MlensembleadaboostRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_adaboost_range_to_string(s : MlensembleadaboostRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensembleadaboostSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_adaboost_slice_make(size : Int) -> MlensembleadaboostSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_adaboost_slice_len(s : MlensembleadaboostSlice) -> Int { s.size }

pub fn ml_ensemble_adaboost_slice_get(s : MlensembleadaboostSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_adaboost_slice_set(s : MlensembleadaboostSlice, i : Int, v : Double) -> MlensembleadaboostSlice {
  let result = ml_ensemble_adaboost_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_adaboost_slice_sum(s : MlensembleadaboostSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_adaboost_slice_mean(s : MlensembleadaboostSlice) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_adaboost_slice_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_adaboost_slice_scale(s : MlensembleadaboostSlice, f : Double) -> MlensembleadaboostSlice {
  let result = ml_ensemble_adaboost_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_adaboost_slice_add(a : MlensembleadaboostSlice, b : MlensembleadaboostSlice) -> MlensembleadaboostSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_adaboost_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_adaboost_slice_copy(s : MlensembleadaboostSlice) -> MlensembleadaboostSlice {
  let result = ml_ensemble_adaboost_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_adaboost_slice_fill(s : MlensembleadaboostSlice, v : Double) -> MlensembleadaboostSlice {
  let result = ml_ensemble_adaboost_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_adaboost_slice_min(s : MlensembleadaboostSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_adaboost_slice_max(s : MlensembleadaboostSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_adaboost_slice_to_string(s : MlensembleadaboostSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


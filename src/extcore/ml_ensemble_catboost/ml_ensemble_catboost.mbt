///===
/// extcore/ml_ensemble_catboost

pub(all) struct MlensemblecatboostPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_ensemble_catboost_make_point(x : Double, y : Double) -> MlensemblecatboostPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_ensemble_catboost_make_point3(x : Double, y : Double, z : Double) -> MlensemblecatboostPoint {
  { x, y, z, label: 0 }
}

pub fn ml_ensemble_catboost_point_x(pt : MlensemblecatboostPoint) -> Double { pt.x }

pub fn ml_ensemble_catboost_point_y(pt : MlensemblecatboostPoint) -> Double { pt.y }

pub fn ml_ensemble_catboost_point_z(pt : MlensemblecatboostPoint) -> Double { pt.z }

pub fn ml_ensemble_catboost_point_label(pt : MlensemblecatboostPoint) -> Int { pt.label }

pub fn ml_ensemble_catboost_point_dist(a : MlensemblecatboostPoint, b : MlensemblecatboostPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ml_ensemble_catboost_point_add(a : MlensemblecatboostPoint, b : MlensemblecatboostPoint) -> MlensemblecatboostPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ml_ensemble_catboost_point_sub(a : MlensemblecatboostPoint, b : MlensemblecatboostPoint) -> MlensemblecatboostPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ml_ensemble_catboost_point_scale(pt : MlensemblecatboostPoint, s : Double) -> MlensemblecatboostPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ml_ensemble_catboost_point_dot(a : MlensemblecatboostPoint, b : MlensemblecatboostPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ml_ensemble_catboost_point_cross(a : MlensemblecatboostPoint, b : MlensemblecatboostPoint) -> MlensemblecatboostPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ml_ensemble_catboost_point_norm(pt : MlensemblecatboostPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ml_ensemble_catboost_point_normalize(pt : MlensemblecatboostPoint) -> MlensemblecatboostPoint {
  let n = ml_ensemble_catboost_point_norm(pt)
  if n < 0.0000001 { pt } else { ml_ensemble_catboost_point_scale(pt, 1.0 / n) }
}

pub fn ml_ensemble_catboost_point_negate(pt : MlensemblecatboostPoint) -> MlensemblecatboostPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ml_ensemble_catboost_point_mid(a : MlensemblecatboostPoint, b : MlensemblecatboostPoint) -> MlensemblecatboostPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ml_ensemble_catboost_point_lerp(a : MlensemblecatboostPoint, b : MlensemblecatboostPoint, t : Double) -> MlensemblecatboostPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ml_ensemble_catboost_point_to_string(pt : MlensemblecatboostPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MlensemblecatboostSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_ensemble_catboost_make_series(vals : Array[Double], name : String) -> MlensemblecatboostSeries {
  { vals, name, meta: 0 }
}

pub fn ml_ensemble_catboost_series_len(s : MlensemblecatboostSeries) -> Int { s.vals.length() }

pub fn ml_ensemble_catboost_series_sum(s : MlensemblecatboostSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn ml_ensemble_catboost_series_mean(s : MlensemblecatboostSeries) -> Double {
  let n = ml_ensemble_catboost_series_len(s)
  if n == 0 { 0.0 } else { ml_ensemble_catboost_series_sum(s) / n.to_double() }
}

pub fn ml_ensemble_catboost_series_min(s : MlensemblecatboostSeries) -> Double {
  let n = ml_ensemble_catboost_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn ml_ensemble_catboost_series_max(s : MlensemblecatboostSeries) -> Double {
  let n = ml_ensemble_catboost_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn ml_ensemble_catboost_series_range(s : MlensemblecatboostSeries) -> Double {
  ml_ensemble_catboost_series_max(s) - ml_ensemble_catboost_series_min(s)
}

pub fn ml_ensemble_catboost_series_var(s : MlensemblecatboostSeries) -> Double {
  let n = ml_ensemble_catboost_series_len(s)
  if n == 0 { 0.0 } else {
    let m = ml_ensemble_catboost_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn ml_ensemble_catboost_series_std(s : MlensemblecatboostSeries) -> Double { @_common.sqrt(ml_ensemble_catboost_series_var(s)) }

pub fn ml_ensemble_catboost_series_median(s : MlensemblecatboostSeries) -> Double {
  let n = ml_ensemble_catboost_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = ml_ensemble_catboost_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ml_ensemble_catboost_series_scale(s : MlensemblecatboostSeries, f : Double) -> MlensemblecatboostSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ml_ensemble_catboost_series_add(a : MlensemblecatboostSeries, b : MlensemblecatboostSeries) -> MlensemblecatboostSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ml_ensemble_catboost_series_sub(a : MlensemblecatboostSeries, b : MlensemblecatboostSeries) -> MlensemblecatboostSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ml_ensemble_catboost_series_normalize(s : MlensemblecatboostSeries) -> MlensemblecatboostSeries {
  let mn = ml_ensemble_catboost_series_min(s)
  let mx = ml_ensemble_catboost_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ml_ensemble_catboost_series_cumsum(s : MlensemblecatboostSeries) -> MlensemblecatboostSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn ml_ensemble_catboost_series_to_string(s : MlensemblecatboostSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlensemblecatboostMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_ensemble_catboost_make_matrix(rows : Int, cols : Int, val : Double) -> MlensemblecatboostMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_ensemble_catboost_matrix_identity(n : Int) -> MlensemblecatboostMatrix {
  let m = ml_ensemble_catboost_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ml_ensemble_catboost_matrix_get(m : MlensemblecatboostMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ml_ensemble_catboost_matrix_transpose(m : MlensemblecatboostMatrix) -> MlensemblecatboostMatrix {
  let result = ml_ensemble_catboost_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ml_ensemble_catboost_matrix_add(a : MlensemblecatboostMatrix, b : MlensemblecatboostMatrix) -> MlensemblecatboostMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ml_ensemble_catboost_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ml_ensemble_catboost_matrix_scale(m : MlensemblecatboostMatrix, s : Double) -> MlensemblecatboostMatrix {
  let result = ml_ensemble_catboost_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ml_ensemble_catboost_matrix_multiply(a : MlensemblecatboostMatrix, b : MlensemblecatboostMatrix) -> MlensemblecatboostMatrix {
  if a.cols != b.rows { return ml_ensemble_catboost_make_matrix(a.rows, b.cols, 0.0) }
  let result = ml_ensemble_catboost_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ml_ensemble_catboost_matrix_trace(m : MlensemblecatboostMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ml_ensemble_catboost_matrix_det(m : MlensemblecatboostMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ml_ensemble_catboost_matrix_norm(m : MlensemblecatboostMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ml_ensemble_catboost_matrix_to_string(m : MlensemblecatboostMatrix) -> String {
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

pub(all) struct MlensemblecatboostVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_ensemble_catboost_make_vector(comps : Array[Double]) -> MlensemblecatboostVector {
  { comps, dim: comps.length() }
}

pub fn ml_ensemble_catboost_vector_zero(dim : Int) -> MlensemblecatboostVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ml_ensemble_catboost_vector_add(a : MlensemblecatboostVector, b : MlensemblecatboostVector) -> MlensemblecatboostVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_ensemble_catboost_vector_sub(a : MlensemblecatboostVector, b : MlensemblecatboostVector) -> MlensemblecatboostVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_ensemble_catboost_vector_scale(v : MlensemblecatboostVector, s : Double) -> MlensemblecatboostVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ml_ensemble_catboost_vector_dot(a : MlensemblecatboostVector, b : MlensemblecatboostVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ml_ensemble_catboost_vector_norm(v : MlensemblecatboostVector) -> Double { @_common.sqrt(ml_ensemble_catboost_vector_dot(v, v)) }

pub fn ml_ensemble_catboost_vector_normalize(v : MlensemblecatboostVector) -> MlensemblecatboostVector {
  let n = ml_ensemble_catboost_vector_norm(v)
  if n < 0.0000001 { v } else { ml_ensemble_catboost_vector_scale(v, 1.0 / n) }
}

pub fn ml_ensemble_catboost_vector_dist(a : MlensemblecatboostVector, b : MlensemblecatboostVector) -> Double {
  ml_ensemble_catboost_vector_norm(ml_ensemble_catboost_vector_sub(a, b))
}

pub fn ml_ensemble_catboost_vector_to_string(v : MlensemblecatboostVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_ensemble_catboost_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_ensemble_catboost_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_ensemble_catboost_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_ensemble_catboost_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_ensemble_catboost_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_ensemble_catboost_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_ensemble_catboost_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_ensemble_catboost_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_ensemble_catboost_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_ensemble_catboost_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_ensemble_catboost_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_ensemble_catboost_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_ensemble_catboost_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_ensemble_catboost_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_ensemble_catboost_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_ensemble_catboost_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_ensemble_catboost_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_ensemble_catboost_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_ensemble_catboost_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_ensemble_catboost_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_ensemble_catboost_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_ensemble_catboost_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_ensemble_catboost_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_ensemble_catboost_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_ensemble_catboost_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_ensemble_catboost_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_ensemble_catboost_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_ensemble_catboost_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_ensemble_catboost_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlensemblecatboostFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_catboost_frame_make(size : Int) -> MlensemblecatboostFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_catboost_frame_len(s : MlensemblecatboostFrame) -> Int { s.size }

pub fn ml_ensemble_catboost_frame_get(s : MlensemblecatboostFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_catboost_frame_set(s : MlensemblecatboostFrame, i : Int, v : Double) -> MlensemblecatboostFrame {
  let result = ml_ensemble_catboost_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_catboost_frame_sum(s : MlensemblecatboostFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_catboost_frame_mean(s : MlensemblecatboostFrame) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_catboost_frame_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_catboost_frame_scale(s : MlensemblecatboostFrame, f : Double) -> MlensemblecatboostFrame {
  let result = ml_ensemble_catboost_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_catboost_frame_add(a : MlensemblecatboostFrame, b : MlensemblecatboostFrame) -> MlensemblecatboostFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_catboost_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_catboost_frame_copy(s : MlensemblecatboostFrame) -> MlensemblecatboostFrame {
  let result = ml_ensemble_catboost_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_catboost_frame_fill(s : MlensemblecatboostFrame, v : Double) -> MlensemblecatboostFrame {
  let result = ml_ensemble_catboost_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_catboost_frame_min(s : MlensemblecatboostFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_catboost_frame_max(s : MlensemblecatboostFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_catboost_frame_to_string(s : MlensemblecatboostFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblecatboostTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_catboost_table_make(size : Int) -> MlensemblecatboostTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_catboost_table_len(s : MlensemblecatboostTable) -> Int { s.size }

pub fn ml_ensemble_catboost_table_get(s : MlensemblecatboostTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_catboost_table_set(s : MlensemblecatboostTable, i : Int, v : Double) -> MlensemblecatboostTable {
  let result = ml_ensemble_catboost_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_catboost_table_sum(s : MlensemblecatboostTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_catboost_table_mean(s : MlensemblecatboostTable) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_catboost_table_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_catboost_table_scale(s : MlensemblecatboostTable, f : Double) -> MlensemblecatboostTable {
  let result = ml_ensemble_catboost_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_catboost_table_add(a : MlensemblecatboostTable, b : MlensemblecatboostTable) -> MlensemblecatboostTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_catboost_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_catboost_table_copy(s : MlensemblecatboostTable) -> MlensemblecatboostTable {
  let result = ml_ensemble_catboost_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_catboost_table_fill(s : MlensemblecatboostTable, v : Double) -> MlensemblecatboostTable {
  let result = ml_ensemble_catboost_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_catboost_table_min(s : MlensemblecatboostTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_catboost_table_max(s : MlensemblecatboostTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_catboost_table_to_string(s : MlensemblecatboostTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblecatboostGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_catboost_graphn_make(size : Int) -> MlensemblecatboostGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_catboost_graphn_len(s : MlensemblecatboostGraphN) -> Int { s.size }

pub fn ml_ensemble_catboost_graphn_get(s : MlensemblecatboostGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_catboost_graphn_set(s : MlensemblecatboostGraphN, i : Int, v : Double) -> MlensemblecatboostGraphN {
  let result = ml_ensemble_catboost_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_catboost_graphn_sum(s : MlensemblecatboostGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_catboost_graphn_mean(s : MlensemblecatboostGraphN) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_catboost_graphn_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_catboost_graphn_scale(s : MlensemblecatboostGraphN, f : Double) -> MlensemblecatboostGraphN {
  let result = ml_ensemble_catboost_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_catboost_graphn_add(a : MlensemblecatboostGraphN, b : MlensemblecatboostGraphN) -> MlensemblecatboostGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_catboost_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_catboost_graphn_copy(s : MlensemblecatboostGraphN) -> MlensemblecatboostGraphN {
  let result = ml_ensemble_catboost_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_catboost_graphn_fill(s : MlensemblecatboostGraphN, v : Double) -> MlensemblecatboostGraphN {
  let result = ml_ensemble_catboost_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_catboost_graphn_min(s : MlensemblecatboostGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_catboost_graphn_max(s : MlensemblecatboostGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_catboost_graphn_to_string(s : MlensemblecatboostGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblecatboostNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_catboost_node_make(size : Int) -> MlensemblecatboostNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_catboost_node_len(s : MlensemblecatboostNode) -> Int { s.size }

pub fn ml_ensemble_catboost_node_get(s : MlensemblecatboostNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_catboost_node_set(s : MlensemblecatboostNode, i : Int, v : Double) -> MlensemblecatboostNode {
  let result = ml_ensemble_catboost_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_catboost_node_sum(s : MlensemblecatboostNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_catboost_node_mean(s : MlensemblecatboostNode) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_catboost_node_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_catboost_node_scale(s : MlensemblecatboostNode, f : Double) -> MlensemblecatboostNode {
  let result = ml_ensemble_catboost_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_catboost_node_add(a : MlensemblecatboostNode, b : MlensemblecatboostNode) -> MlensemblecatboostNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_catboost_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_catboost_node_copy(s : MlensemblecatboostNode) -> MlensemblecatboostNode {
  let result = ml_ensemble_catboost_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_catboost_node_fill(s : MlensemblecatboostNode, v : Double) -> MlensemblecatboostNode {
  let result = ml_ensemble_catboost_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_catboost_node_min(s : MlensemblecatboostNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_catboost_node_max(s : MlensemblecatboostNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_catboost_node_to_string(s : MlensemblecatboostNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblecatboostEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_catboost_edge_make(size : Int) -> MlensemblecatboostEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_catboost_edge_len(s : MlensemblecatboostEdge) -> Int { s.size }

pub fn ml_ensemble_catboost_edge_get(s : MlensemblecatboostEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_catboost_edge_set(s : MlensemblecatboostEdge, i : Int, v : Double) -> MlensemblecatboostEdge {
  let result = ml_ensemble_catboost_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_catboost_edge_sum(s : MlensemblecatboostEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_catboost_edge_mean(s : MlensemblecatboostEdge) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_catboost_edge_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_catboost_edge_scale(s : MlensemblecatboostEdge, f : Double) -> MlensemblecatboostEdge {
  let result = ml_ensemble_catboost_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_catboost_edge_add(a : MlensemblecatboostEdge, b : MlensemblecatboostEdge) -> MlensemblecatboostEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_catboost_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_catboost_edge_copy(s : MlensemblecatboostEdge) -> MlensemblecatboostEdge {
  let result = ml_ensemble_catboost_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_catboost_edge_fill(s : MlensemblecatboostEdge, v : Double) -> MlensemblecatboostEdge {
  let result = ml_ensemble_catboost_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_catboost_edge_min(s : MlensemblecatboostEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_catboost_edge_max(s : MlensemblecatboostEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_catboost_edge_to_string(s : MlensemblecatboostEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblecatboostPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_catboost_path_make(size : Int) -> MlensemblecatboostPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_catboost_path_len(s : MlensemblecatboostPath) -> Int { s.size }

pub fn ml_ensemble_catboost_path_get(s : MlensemblecatboostPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_catboost_path_set(s : MlensemblecatboostPath, i : Int, v : Double) -> MlensemblecatboostPath {
  let result = ml_ensemble_catboost_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_catboost_path_sum(s : MlensemblecatboostPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_catboost_path_mean(s : MlensemblecatboostPath) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_catboost_path_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_catboost_path_scale(s : MlensemblecatboostPath, f : Double) -> MlensemblecatboostPath {
  let result = ml_ensemble_catboost_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_catboost_path_add(a : MlensemblecatboostPath, b : MlensemblecatboostPath) -> MlensemblecatboostPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_catboost_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_catboost_path_copy(s : MlensemblecatboostPath) -> MlensemblecatboostPath {
  let result = ml_ensemble_catboost_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_catboost_path_fill(s : MlensemblecatboostPath, v : Double) -> MlensemblecatboostPath {
  let result = ml_ensemble_catboost_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_catboost_path_min(s : MlensemblecatboostPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_catboost_path_max(s : MlensemblecatboostPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_catboost_path_to_string(s : MlensemblecatboostPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblecatboostCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_catboost_cluster_make(size : Int) -> MlensemblecatboostCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_catboost_cluster_len(s : MlensemblecatboostCluster) -> Int { s.size }

pub fn ml_ensemble_catboost_cluster_get(s : MlensemblecatboostCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_catboost_cluster_set(s : MlensemblecatboostCluster, i : Int, v : Double) -> MlensemblecatboostCluster {
  let result = ml_ensemble_catboost_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_catboost_cluster_sum(s : MlensemblecatboostCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_catboost_cluster_mean(s : MlensemblecatboostCluster) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_catboost_cluster_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_catboost_cluster_scale(s : MlensemblecatboostCluster, f : Double) -> MlensemblecatboostCluster {
  let result = ml_ensemble_catboost_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_catboost_cluster_add(a : MlensemblecatboostCluster, b : MlensemblecatboostCluster) -> MlensemblecatboostCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_catboost_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_catboost_cluster_copy(s : MlensemblecatboostCluster) -> MlensemblecatboostCluster {
  let result = ml_ensemble_catboost_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_catboost_cluster_fill(s : MlensemblecatboostCluster, v : Double) -> MlensemblecatboostCluster {
  let result = ml_ensemble_catboost_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_catboost_cluster_min(s : MlensemblecatboostCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_catboost_cluster_max(s : MlensemblecatboostCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_catboost_cluster_to_string(s : MlensemblecatboostCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblecatboostModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_catboost_model_make(size : Int) -> MlensemblecatboostModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_catboost_model_len(s : MlensemblecatboostModel) -> Int { s.size }

pub fn ml_ensemble_catboost_model_get(s : MlensemblecatboostModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_catboost_model_set(s : MlensemblecatboostModel, i : Int, v : Double) -> MlensemblecatboostModel {
  let result = ml_ensemble_catboost_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_catboost_model_sum(s : MlensemblecatboostModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_catboost_model_mean(s : MlensemblecatboostModel) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_catboost_model_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_catboost_model_scale(s : MlensemblecatboostModel, f : Double) -> MlensemblecatboostModel {
  let result = ml_ensemble_catboost_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_catboost_model_add(a : MlensemblecatboostModel, b : MlensemblecatboostModel) -> MlensemblecatboostModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_catboost_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_catboost_model_copy(s : MlensemblecatboostModel) -> MlensemblecatboostModel {
  let result = ml_ensemble_catboost_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_catboost_model_fill(s : MlensemblecatboostModel, v : Double) -> MlensemblecatboostModel {
  let result = ml_ensemble_catboost_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_catboost_model_min(s : MlensemblecatboostModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_catboost_model_max(s : MlensemblecatboostModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_catboost_model_to_string(s : MlensemblecatboostModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblecatboostLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_catboost_layer_make(size : Int) -> MlensemblecatboostLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_catboost_layer_len(s : MlensemblecatboostLayer) -> Int { s.size }

pub fn ml_ensemble_catboost_layer_get(s : MlensemblecatboostLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_catboost_layer_set(s : MlensemblecatboostLayer, i : Int, v : Double) -> MlensemblecatboostLayer {
  let result = ml_ensemble_catboost_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_catboost_layer_sum(s : MlensemblecatboostLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_catboost_layer_mean(s : MlensemblecatboostLayer) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_catboost_layer_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_catboost_layer_scale(s : MlensemblecatboostLayer, f : Double) -> MlensemblecatboostLayer {
  let result = ml_ensemble_catboost_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_catboost_layer_add(a : MlensemblecatboostLayer, b : MlensemblecatboostLayer) -> MlensemblecatboostLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_catboost_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_catboost_layer_copy(s : MlensemblecatboostLayer) -> MlensemblecatboostLayer {
  let result = ml_ensemble_catboost_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_catboost_layer_fill(s : MlensemblecatboostLayer, v : Double) -> MlensemblecatboostLayer {
  let result = ml_ensemble_catboost_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_catboost_layer_min(s : MlensemblecatboostLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_catboost_layer_max(s : MlensemblecatboostLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_catboost_layer_to_string(s : MlensemblecatboostLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblecatboostBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_catboost_buffer_make(size : Int) -> MlensemblecatboostBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_catboost_buffer_len(s : MlensemblecatboostBuffer) -> Int { s.size }

pub fn ml_ensemble_catboost_buffer_get(s : MlensemblecatboostBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_catboost_buffer_set(s : MlensemblecatboostBuffer, i : Int, v : Double) -> MlensemblecatboostBuffer {
  let result = ml_ensemble_catboost_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_catboost_buffer_sum(s : MlensemblecatboostBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_catboost_buffer_mean(s : MlensemblecatboostBuffer) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_catboost_buffer_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_catboost_buffer_scale(s : MlensemblecatboostBuffer, f : Double) -> MlensemblecatboostBuffer {
  let result = ml_ensemble_catboost_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_catboost_buffer_add(a : MlensemblecatboostBuffer, b : MlensemblecatboostBuffer) -> MlensemblecatboostBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_catboost_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_catboost_buffer_copy(s : MlensemblecatboostBuffer) -> MlensemblecatboostBuffer {
  let result = ml_ensemble_catboost_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_catboost_buffer_fill(s : MlensemblecatboostBuffer, v : Double) -> MlensemblecatboostBuffer {
  let result = ml_ensemble_catboost_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_catboost_buffer_min(s : MlensemblecatboostBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_catboost_buffer_max(s : MlensemblecatboostBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_catboost_buffer_to_string(s : MlensemblecatboostBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblecatboostCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_catboost_cursor_make(size : Int) -> MlensemblecatboostCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_catboost_cursor_len(s : MlensemblecatboostCursor) -> Int { s.size }

pub fn ml_ensemble_catboost_cursor_get(s : MlensemblecatboostCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_catboost_cursor_set(s : MlensemblecatboostCursor, i : Int, v : Double) -> MlensemblecatboostCursor {
  let result = ml_ensemble_catboost_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_catboost_cursor_sum(s : MlensemblecatboostCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_catboost_cursor_mean(s : MlensemblecatboostCursor) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_catboost_cursor_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_catboost_cursor_scale(s : MlensemblecatboostCursor, f : Double) -> MlensemblecatboostCursor {
  let result = ml_ensemble_catboost_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_catboost_cursor_add(a : MlensemblecatboostCursor, b : MlensemblecatboostCursor) -> MlensemblecatboostCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_catboost_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_catboost_cursor_copy(s : MlensemblecatboostCursor) -> MlensemblecatboostCursor {
  let result = ml_ensemble_catboost_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_catboost_cursor_fill(s : MlensemblecatboostCursor, v : Double) -> MlensemblecatboostCursor {
  let result = ml_ensemble_catboost_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_catboost_cursor_min(s : MlensemblecatboostCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_catboost_cursor_max(s : MlensemblecatboostCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_catboost_cursor_to_string(s : MlensemblecatboostCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblecatboostView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_catboost_view_make(size : Int) -> MlensemblecatboostView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_catboost_view_len(s : MlensemblecatboostView) -> Int { s.size }

pub fn ml_ensemble_catboost_view_get(s : MlensemblecatboostView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_catboost_view_set(s : MlensemblecatboostView, i : Int, v : Double) -> MlensemblecatboostView {
  let result = ml_ensemble_catboost_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_catboost_view_sum(s : MlensemblecatboostView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_catboost_view_mean(s : MlensemblecatboostView) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_catboost_view_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_catboost_view_scale(s : MlensemblecatboostView, f : Double) -> MlensemblecatboostView {
  let result = ml_ensemble_catboost_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_catboost_view_add(a : MlensemblecatboostView, b : MlensemblecatboostView) -> MlensemblecatboostView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_catboost_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_catboost_view_copy(s : MlensemblecatboostView) -> MlensemblecatboostView {
  let result = ml_ensemble_catboost_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_catboost_view_fill(s : MlensemblecatboostView, v : Double) -> MlensemblecatboostView {
  let result = ml_ensemble_catboost_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_catboost_view_min(s : MlensemblecatboostView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_catboost_view_max(s : MlensemblecatboostView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_catboost_view_to_string(s : MlensemblecatboostView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblecatboostRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_catboost_range_make(size : Int) -> MlensemblecatboostRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_catboost_range_len(s : MlensemblecatboostRange) -> Int { s.size }

pub fn ml_ensemble_catboost_range_get(s : MlensemblecatboostRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_catboost_range_set(s : MlensemblecatboostRange, i : Int, v : Double) -> MlensemblecatboostRange {
  let result = ml_ensemble_catboost_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_catboost_range_sum(s : MlensemblecatboostRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_catboost_range_mean(s : MlensemblecatboostRange) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_catboost_range_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_catboost_range_scale(s : MlensemblecatboostRange, f : Double) -> MlensemblecatboostRange {
  let result = ml_ensemble_catboost_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_catboost_range_add(a : MlensemblecatboostRange, b : MlensemblecatboostRange) -> MlensemblecatboostRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_catboost_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_catboost_range_copy(s : MlensemblecatboostRange) -> MlensemblecatboostRange {
  let result = ml_ensemble_catboost_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_catboost_range_fill(s : MlensemblecatboostRange, v : Double) -> MlensemblecatboostRange {
  let result = ml_ensemble_catboost_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_catboost_range_min(s : MlensemblecatboostRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_catboost_range_max(s : MlensemblecatboostRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_catboost_range_to_string(s : MlensemblecatboostRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblecatboostSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_catboost_slice_make(size : Int) -> MlensemblecatboostSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_catboost_slice_len(s : MlensemblecatboostSlice) -> Int { s.size }

pub fn ml_ensemble_catboost_slice_get(s : MlensemblecatboostSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_catboost_slice_set(s : MlensemblecatboostSlice, i : Int, v : Double) -> MlensemblecatboostSlice {
  let result = ml_ensemble_catboost_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_catboost_slice_sum(s : MlensemblecatboostSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_catboost_slice_mean(s : MlensemblecatboostSlice) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_catboost_slice_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_catboost_slice_scale(s : MlensemblecatboostSlice, f : Double) -> MlensemblecatboostSlice {
  let result = ml_ensemble_catboost_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_catboost_slice_add(a : MlensemblecatboostSlice, b : MlensemblecatboostSlice) -> MlensemblecatboostSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_catboost_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_catboost_slice_copy(s : MlensemblecatboostSlice) -> MlensemblecatboostSlice {
  let result = ml_ensemble_catboost_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_catboost_slice_fill(s : MlensemblecatboostSlice, v : Double) -> MlensemblecatboostSlice {
  let result = ml_ensemble_catboost_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_catboost_slice_min(s : MlensemblecatboostSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_catboost_slice_max(s : MlensemblecatboostSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_catboost_slice_to_string(s : MlensemblecatboostSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


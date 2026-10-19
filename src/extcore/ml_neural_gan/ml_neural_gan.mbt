///===
/// extcore/ml_neural_gan

pub(all) struct MlneuralganPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_neural_gan_make_point(x : Double, y : Double) -> MlneuralganPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_neural_gan_make_point3(x : Double, y : Double, z : Double) -> MlneuralganPoint {
  { x, y, z, label: 0 }
}

pub fn ml_neural_gan_point_x(pt : MlneuralganPoint) -> Double { pt.x }

pub fn ml_neural_gan_point_y(pt : MlneuralganPoint) -> Double { pt.y }

pub fn ml_neural_gan_point_z(pt : MlneuralganPoint) -> Double { pt.z }

pub fn ml_neural_gan_point_label(pt : MlneuralganPoint) -> Int { pt.label }

pub fn ml_neural_gan_point_dist(a : MlneuralganPoint, b : MlneuralganPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ml_neural_gan_point_add(a : MlneuralganPoint, b : MlneuralganPoint) -> MlneuralganPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ml_neural_gan_point_sub(a : MlneuralganPoint, b : MlneuralganPoint) -> MlneuralganPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ml_neural_gan_point_scale(pt : MlneuralganPoint, s : Double) -> MlneuralganPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ml_neural_gan_point_dot(a : MlneuralganPoint, b : MlneuralganPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ml_neural_gan_point_cross(a : MlneuralganPoint, b : MlneuralganPoint) -> MlneuralganPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ml_neural_gan_point_norm(pt : MlneuralganPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ml_neural_gan_point_normalize(pt : MlneuralganPoint) -> MlneuralganPoint {
  let n = ml_neural_gan_point_norm(pt)
  if n < 0.0000001 { pt } else { ml_neural_gan_point_scale(pt, 1.0 / n) }
}

pub fn ml_neural_gan_point_negate(pt : MlneuralganPoint) -> MlneuralganPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ml_neural_gan_point_mid(a : MlneuralganPoint, b : MlneuralganPoint) -> MlneuralganPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ml_neural_gan_point_lerp(a : MlneuralganPoint, b : MlneuralganPoint, t : Double) -> MlneuralganPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ml_neural_gan_point_to_string(pt : MlneuralganPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MlneuralganSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_neural_gan_make_series(vals : Array[Double], name : String) -> MlneuralganSeries {
  { vals, name, meta: 0 }
}

pub fn ml_neural_gan_series_len(s : MlneuralganSeries) -> Int { s.vals.length() }

pub fn ml_neural_gan_series_sum(s : MlneuralganSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn ml_neural_gan_series_mean(s : MlneuralganSeries) -> Double {
  let n = ml_neural_gan_series_len(s)
  if n == 0 { 0.0 } else { ml_neural_gan_series_sum(s) / n.to_double() }
}

pub fn ml_neural_gan_series_min(s : MlneuralganSeries) -> Double {
  let n = ml_neural_gan_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn ml_neural_gan_series_max(s : MlneuralganSeries) -> Double {
  let n = ml_neural_gan_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn ml_neural_gan_series_range(s : MlneuralganSeries) -> Double {
  ml_neural_gan_series_max(s) - ml_neural_gan_series_min(s)
}

pub fn ml_neural_gan_series_var(s : MlneuralganSeries) -> Double {
  let n = ml_neural_gan_series_len(s)
  if n == 0 { 0.0 } else {
    let m = ml_neural_gan_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn ml_neural_gan_series_std(s : MlneuralganSeries) -> Double { @_common.sqrt(ml_neural_gan_series_var(s)) }

pub fn ml_neural_gan_series_median(s : MlneuralganSeries) -> Double {
  let n = ml_neural_gan_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = ml_neural_gan_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ml_neural_gan_series_scale(s : MlneuralganSeries, f : Double) -> MlneuralganSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ml_neural_gan_series_add(a : MlneuralganSeries, b : MlneuralganSeries) -> MlneuralganSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ml_neural_gan_series_sub(a : MlneuralganSeries, b : MlneuralganSeries) -> MlneuralganSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ml_neural_gan_series_normalize(s : MlneuralganSeries) -> MlneuralganSeries {
  let mn = ml_neural_gan_series_min(s)
  let mx = ml_neural_gan_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ml_neural_gan_series_cumsum(s : MlneuralganSeries) -> MlneuralganSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn ml_neural_gan_series_to_string(s : MlneuralganSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlneuralganMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_neural_gan_make_matrix(rows : Int, cols : Int, val : Double) -> MlneuralganMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_neural_gan_matrix_identity(n : Int) -> MlneuralganMatrix {
  let m = ml_neural_gan_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ml_neural_gan_matrix_get(m : MlneuralganMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ml_neural_gan_matrix_transpose(m : MlneuralganMatrix) -> MlneuralganMatrix {
  let result = ml_neural_gan_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ml_neural_gan_matrix_add(a : MlneuralganMatrix, b : MlneuralganMatrix) -> MlneuralganMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ml_neural_gan_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ml_neural_gan_matrix_scale(m : MlneuralganMatrix, s : Double) -> MlneuralganMatrix {
  let result = ml_neural_gan_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ml_neural_gan_matrix_multiply(a : MlneuralganMatrix, b : MlneuralganMatrix) -> MlneuralganMatrix {
  if a.cols != b.rows { return ml_neural_gan_make_matrix(a.rows, b.cols, 0.0) }
  let result = ml_neural_gan_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ml_neural_gan_matrix_trace(m : MlneuralganMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ml_neural_gan_matrix_det(m : MlneuralganMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ml_neural_gan_matrix_norm(m : MlneuralganMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ml_neural_gan_matrix_to_string(m : MlneuralganMatrix) -> String {
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

pub(all) struct MlneuralganVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_neural_gan_make_vector(comps : Array[Double]) -> MlneuralganVector {
  { comps, dim: comps.length() }
}

pub fn ml_neural_gan_vector_zero(dim : Int) -> MlneuralganVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ml_neural_gan_vector_add(a : MlneuralganVector, b : MlneuralganVector) -> MlneuralganVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_neural_gan_vector_sub(a : MlneuralganVector, b : MlneuralganVector) -> MlneuralganVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_neural_gan_vector_scale(v : MlneuralganVector, s : Double) -> MlneuralganVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ml_neural_gan_vector_dot(a : MlneuralganVector, b : MlneuralganVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ml_neural_gan_vector_norm(v : MlneuralganVector) -> Double { @_common.sqrt(ml_neural_gan_vector_dot(v, v)) }

pub fn ml_neural_gan_vector_normalize(v : MlneuralganVector) -> MlneuralganVector {
  let n = ml_neural_gan_vector_norm(v)
  if n < 0.0000001 { v } else { ml_neural_gan_vector_scale(v, 1.0 / n) }
}

pub fn ml_neural_gan_vector_dist(a : MlneuralganVector, b : MlneuralganVector) -> Double {
  ml_neural_gan_vector_norm(ml_neural_gan_vector_sub(a, b))
}

pub fn ml_neural_gan_vector_to_string(v : MlneuralganVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_neural_gan_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_neural_gan_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_neural_gan_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_neural_gan_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_neural_gan_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_neural_gan_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_neural_gan_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_neural_gan_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_neural_gan_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_neural_gan_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_neural_gan_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_neural_gan_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_neural_gan_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_neural_gan_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_neural_gan_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_neural_gan_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_neural_gan_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_neural_gan_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_neural_gan_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_neural_gan_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_neural_gan_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_neural_gan_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_neural_gan_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_neural_gan_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_neural_gan_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_neural_gan_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_neural_gan_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_neural_gan_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_neural_gan_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlneuralganFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_gan_frame_make(size : Int) -> MlneuralganFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_gan_frame_len(s : MlneuralganFrame) -> Int { s.size }

pub fn ml_neural_gan_frame_get(s : MlneuralganFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_gan_frame_set(s : MlneuralganFrame, i : Int, v : Double) -> MlneuralganFrame {
  let result = ml_neural_gan_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_neural_gan_frame_sum(s : MlneuralganFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_neural_gan_frame_mean(s : MlneuralganFrame) -> Double {
  if s.size == 0 { 0.0 } else { ml_neural_gan_frame_sum(s) / s.size.to_double() }
}

pub fn ml_neural_gan_frame_scale(s : MlneuralganFrame, f : Double) -> MlneuralganFrame {
  let result = ml_neural_gan_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_neural_gan_frame_add(a : MlneuralganFrame, b : MlneuralganFrame) -> MlneuralganFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_neural_gan_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_neural_gan_frame_copy(s : MlneuralganFrame) -> MlneuralganFrame {
  let result = ml_neural_gan_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_neural_gan_frame_fill(s : MlneuralganFrame, v : Double) -> MlneuralganFrame {
  let result = ml_neural_gan_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_neural_gan_frame_min(s : MlneuralganFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_gan_frame_max(s : MlneuralganFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_gan_frame_to_string(s : MlneuralganFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralganTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_gan_table_make(size : Int) -> MlneuralganTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_gan_table_len(s : MlneuralganTable) -> Int { s.size }

pub fn ml_neural_gan_table_get(s : MlneuralganTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_gan_table_set(s : MlneuralganTable, i : Int, v : Double) -> MlneuralganTable {
  let result = ml_neural_gan_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_neural_gan_table_sum(s : MlneuralganTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_neural_gan_table_mean(s : MlneuralganTable) -> Double {
  if s.size == 0 { 0.0 } else { ml_neural_gan_table_sum(s) / s.size.to_double() }
}

pub fn ml_neural_gan_table_scale(s : MlneuralganTable, f : Double) -> MlneuralganTable {
  let result = ml_neural_gan_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_neural_gan_table_add(a : MlneuralganTable, b : MlneuralganTable) -> MlneuralganTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_neural_gan_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_neural_gan_table_copy(s : MlneuralganTable) -> MlneuralganTable {
  let result = ml_neural_gan_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_neural_gan_table_fill(s : MlneuralganTable, v : Double) -> MlneuralganTable {
  let result = ml_neural_gan_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_neural_gan_table_min(s : MlneuralganTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_gan_table_max(s : MlneuralganTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_gan_table_to_string(s : MlneuralganTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralganGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_gan_graphn_make(size : Int) -> MlneuralganGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_gan_graphn_len(s : MlneuralganGraphN) -> Int { s.size }

pub fn ml_neural_gan_graphn_get(s : MlneuralganGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_gan_graphn_set(s : MlneuralganGraphN, i : Int, v : Double) -> MlneuralganGraphN {
  let result = ml_neural_gan_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_neural_gan_graphn_sum(s : MlneuralganGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_neural_gan_graphn_mean(s : MlneuralganGraphN) -> Double {
  if s.size == 0 { 0.0 } else { ml_neural_gan_graphn_sum(s) / s.size.to_double() }
}

pub fn ml_neural_gan_graphn_scale(s : MlneuralganGraphN, f : Double) -> MlneuralganGraphN {
  let result = ml_neural_gan_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_neural_gan_graphn_add(a : MlneuralganGraphN, b : MlneuralganGraphN) -> MlneuralganGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_neural_gan_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_neural_gan_graphn_copy(s : MlneuralganGraphN) -> MlneuralganGraphN {
  let result = ml_neural_gan_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_neural_gan_graphn_fill(s : MlneuralganGraphN, v : Double) -> MlneuralganGraphN {
  let result = ml_neural_gan_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_neural_gan_graphn_min(s : MlneuralganGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_gan_graphn_max(s : MlneuralganGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_gan_graphn_to_string(s : MlneuralganGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralganNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_gan_node_make(size : Int) -> MlneuralganNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_gan_node_len(s : MlneuralganNode) -> Int { s.size }

pub fn ml_neural_gan_node_get(s : MlneuralganNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_gan_node_set(s : MlneuralganNode, i : Int, v : Double) -> MlneuralganNode {
  let result = ml_neural_gan_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_neural_gan_node_sum(s : MlneuralganNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_neural_gan_node_mean(s : MlneuralganNode) -> Double {
  if s.size == 0 { 0.0 } else { ml_neural_gan_node_sum(s) / s.size.to_double() }
}

pub fn ml_neural_gan_node_scale(s : MlneuralganNode, f : Double) -> MlneuralganNode {
  let result = ml_neural_gan_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_neural_gan_node_add(a : MlneuralganNode, b : MlneuralganNode) -> MlneuralganNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_neural_gan_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_neural_gan_node_copy(s : MlneuralganNode) -> MlneuralganNode {
  let result = ml_neural_gan_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_neural_gan_node_fill(s : MlneuralganNode, v : Double) -> MlneuralganNode {
  let result = ml_neural_gan_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_neural_gan_node_min(s : MlneuralganNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_gan_node_max(s : MlneuralganNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_gan_node_to_string(s : MlneuralganNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralganEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_gan_edge_make(size : Int) -> MlneuralganEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_gan_edge_len(s : MlneuralganEdge) -> Int { s.size }

pub fn ml_neural_gan_edge_get(s : MlneuralganEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_gan_edge_set(s : MlneuralganEdge, i : Int, v : Double) -> MlneuralganEdge {
  let result = ml_neural_gan_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_neural_gan_edge_sum(s : MlneuralganEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_neural_gan_edge_mean(s : MlneuralganEdge) -> Double {
  if s.size == 0 { 0.0 } else { ml_neural_gan_edge_sum(s) / s.size.to_double() }
}

pub fn ml_neural_gan_edge_scale(s : MlneuralganEdge, f : Double) -> MlneuralganEdge {
  let result = ml_neural_gan_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_neural_gan_edge_add(a : MlneuralganEdge, b : MlneuralganEdge) -> MlneuralganEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_neural_gan_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_neural_gan_edge_copy(s : MlneuralganEdge) -> MlneuralganEdge {
  let result = ml_neural_gan_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_neural_gan_edge_fill(s : MlneuralganEdge, v : Double) -> MlneuralganEdge {
  let result = ml_neural_gan_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_neural_gan_edge_min(s : MlneuralganEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_gan_edge_max(s : MlneuralganEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_gan_edge_to_string(s : MlneuralganEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralganPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_gan_path_make(size : Int) -> MlneuralganPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_gan_path_len(s : MlneuralganPath) -> Int { s.size }

pub fn ml_neural_gan_path_get(s : MlneuralganPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_gan_path_set(s : MlneuralganPath, i : Int, v : Double) -> MlneuralganPath {
  let result = ml_neural_gan_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_neural_gan_path_sum(s : MlneuralganPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_neural_gan_path_mean(s : MlneuralganPath) -> Double {
  if s.size == 0 { 0.0 } else { ml_neural_gan_path_sum(s) / s.size.to_double() }
}

pub fn ml_neural_gan_path_scale(s : MlneuralganPath, f : Double) -> MlneuralganPath {
  let result = ml_neural_gan_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_neural_gan_path_add(a : MlneuralganPath, b : MlneuralganPath) -> MlneuralganPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_neural_gan_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_neural_gan_path_copy(s : MlneuralganPath) -> MlneuralganPath {
  let result = ml_neural_gan_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_neural_gan_path_fill(s : MlneuralganPath, v : Double) -> MlneuralganPath {
  let result = ml_neural_gan_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_neural_gan_path_min(s : MlneuralganPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_gan_path_max(s : MlneuralganPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_gan_path_to_string(s : MlneuralganPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralganCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_gan_cluster_make(size : Int) -> MlneuralganCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_gan_cluster_len(s : MlneuralganCluster) -> Int { s.size }

pub fn ml_neural_gan_cluster_get(s : MlneuralganCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_gan_cluster_set(s : MlneuralganCluster, i : Int, v : Double) -> MlneuralganCluster {
  let result = ml_neural_gan_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_neural_gan_cluster_sum(s : MlneuralganCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_neural_gan_cluster_mean(s : MlneuralganCluster) -> Double {
  if s.size == 0 { 0.0 } else { ml_neural_gan_cluster_sum(s) / s.size.to_double() }
}

pub fn ml_neural_gan_cluster_scale(s : MlneuralganCluster, f : Double) -> MlneuralganCluster {
  let result = ml_neural_gan_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_neural_gan_cluster_add(a : MlneuralganCluster, b : MlneuralganCluster) -> MlneuralganCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_neural_gan_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_neural_gan_cluster_copy(s : MlneuralganCluster) -> MlneuralganCluster {
  let result = ml_neural_gan_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_neural_gan_cluster_fill(s : MlneuralganCluster, v : Double) -> MlneuralganCluster {
  let result = ml_neural_gan_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_neural_gan_cluster_min(s : MlneuralganCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_gan_cluster_max(s : MlneuralganCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_gan_cluster_to_string(s : MlneuralganCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralganModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_gan_model_make(size : Int) -> MlneuralganModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_gan_model_len(s : MlneuralganModel) -> Int { s.size }

pub fn ml_neural_gan_model_get(s : MlneuralganModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_gan_model_set(s : MlneuralganModel, i : Int, v : Double) -> MlneuralganModel {
  let result = ml_neural_gan_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_neural_gan_model_sum(s : MlneuralganModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_neural_gan_model_mean(s : MlneuralganModel) -> Double {
  if s.size == 0 { 0.0 } else { ml_neural_gan_model_sum(s) / s.size.to_double() }
}

pub fn ml_neural_gan_model_scale(s : MlneuralganModel, f : Double) -> MlneuralganModel {
  let result = ml_neural_gan_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_neural_gan_model_add(a : MlneuralganModel, b : MlneuralganModel) -> MlneuralganModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_neural_gan_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_neural_gan_model_copy(s : MlneuralganModel) -> MlneuralganModel {
  let result = ml_neural_gan_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_neural_gan_model_fill(s : MlneuralganModel, v : Double) -> MlneuralganModel {
  let result = ml_neural_gan_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_neural_gan_model_min(s : MlneuralganModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_gan_model_max(s : MlneuralganModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_gan_model_to_string(s : MlneuralganModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralganLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_gan_layer_make(size : Int) -> MlneuralganLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_gan_layer_len(s : MlneuralganLayer) -> Int { s.size }

pub fn ml_neural_gan_layer_get(s : MlneuralganLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_gan_layer_set(s : MlneuralganLayer, i : Int, v : Double) -> MlneuralganLayer {
  let result = ml_neural_gan_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_neural_gan_layer_sum(s : MlneuralganLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_neural_gan_layer_mean(s : MlneuralganLayer) -> Double {
  if s.size == 0 { 0.0 } else { ml_neural_gan_layer_sum(s) / s.size.to_double() }
}

pub fn ml_neural_gan_layer_scale(s : MlneuralganLayer, f : Double) -> MlneuralganLayer {
  let result = ml_neural_gan_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_neural_gan_layer_add(a : MlneuralganLayer, b : MlneuralganLayer) -> MlneuralganLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_neural_gan_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_neural_gan_layer_copy(s : MlneuralganLayer) -> MlneuralganLayer {
  let result = ml_neural_gan_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_neural_gan_layer_fill(s : MlneuralganLayer, v : Double) -> MlneuralganLayer {
  let result = ml_neural_gan_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_neural_gan_layer_min(s : MlneuralganLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_gan_layer_max(s : MlneuralganLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_gan_layer_to_string(s : MlneuralganLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralganBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_gan_buffer_make(size : Int) -> MlneuralganBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_gan_buffer_len(s : MlneuralganBuffer) -> Int { s.size }

pub fn ml_neural_gan_buffer_get(s : MlneuralganBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_gan_buffer_set(s : MlneuralganBuffer, i : Int, v : Double) -> MlneuralganBuffer {
  let result = ml_neural_gan_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_neural_gan_buffer_sum(s : MlneuralganBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_neural_gan_buffer_mean(s : MlneuralganBuffer) -> Double {
  if s.size == 0 { 0.0 } else { ml_neural_gan_buffer_sum(s) / s.size.to_double() }
}

pub fn ml_neural_gan_buffer_scale(s : MlneuralganBuffer, f : Double) -> MlneuralganBuffer {
  let result = ml_neural_gan_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_neural_gan_buffer_add(a : MlneuralganBuffer, b : MlneuralganBuffer) -> MlneuralganBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_neural_gan_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_neural_gan_buffer_copy(s : MlneuralganBuffer) -> MlneuralganBuffer {
  let result = ml_neural_gan_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_neural_gan_buffer_fill(s : MlneuralganBuffer, v : Double) -> MlneuralganBuffer {
  let result = ml_neural_gan_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_neural_gan_buffer_min(s : MlneuralganBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_gan_buffer_max(s : MlneuralganBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_gan_buffer_to_string(s : MlneuralganBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralganCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_gan_cursor_make(size : Int) -> MlneuralganCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_gan_cursor_len(s : MlneuralganCursor) -> Int { s.size }

pub fn ml_neural_gan_cursor_get(s : MlneuralganCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_gan_cursor_set(s : MlneuralganCursor, i : Int, v : Double) -> MlneuralganCursor {
  let result = ml_neural_gan_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_neural_gan_cursor_sum(s : MlneuralganCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_neural_gan_cursor_mean(s : MlneuralganCursor) -> Double {
  if s.size == 0 { 0.0 } else { ml_neural_gan_cursor_sum(s) / s.size.to_double() }
}

pub fn ml_neural_gan_cursor_scale(s : MlneuralganCursor, f : Double) -> MlneuralganCursor {
  let result = ml_neural_gan_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_neural_gan_cursor_add(a : MlneuralganCursor, b : MlneuralganCursor) -> MlneuralganCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_neural_gan_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_neural_gan_cursor_copy(s : MlneuralganCursor) -> MlneuralganCursor {
  let result = ml_neural_gan_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_neural_gan_cursor_fill(s : MlneuralganCursor, v : Double) -> MlneuralganCursor {
  let result = ml_neural_gan_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_neural_gan_cursor_min(s : MlneuralganCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_gan_cursor_max(s : MlneuralganCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_gan_cursor_to_string(s : MlneuralganCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralganView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_gan_view_make(size : Int) -> MlneuralganView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_gan_view_len(s : MlneuralganView) -> Int { s.size }

pub fn ml_neural_gan_view_get(s : MlneuralganView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_gan_view_set(s : MlneuralganView, i : Int, v : Double) -> MlneuralganView {
  let result = ml_neural_gan_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_neural_gan_view_sum(s : MlneuralganView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_neural_gan_view_mean(s : MlneuralganView) -> Double {
  if s.size == 0 { 0.0 } else { ml_neural_gan_view_sum(s) / s.size.to_double() }
}

pub fn ml_neural_gan_view_scale(s : MlneuralganView, f : Double) -> MlneuralganView {
  let result = ml_neural_gan_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_neural_gan_view_add(a : MlneuralganView, b : MlneuralganView) -> MlneuralganView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_neural_gan_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_neural_gan_view_copy(s : MlneuralganView) -> MlneuralganView {
  let result = ml_neural_gan_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_neural_gan_view_fill(s : MlneuralganView, v : Double) -> MlneuralganView {
  let result = ml_neural_gan_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_neural_gan_view_min(s : MlneuralganView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_gan_view_max(s : MlneuralganView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_gan_view_to_string(s : MlneuralganView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralganRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_gan_range_make(size : Int) -> MlneuralganRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_gan_range_len(s : MlneuralganRange) -> Int { s.size }

pub fn ml_neural_gan_range_get(s : MlneuralganRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_gan_range_set(s : MlneuralganRange, i : Int, v : Double) -> MlneuralganRange {
  let result = ml_neural_gan_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_neural_gan_range_sum(s : MlneuralganRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_neural_gan_range_mean(s : MlneuralganRange) -> Double {
  if s.size == 0 { 0.0 } else { ml_neural_gan_range_sum(s) / s.size.to_double() }
}

pub fn ml_neural_gan_range_scale(s : MlneuralganRange, f : Double) -> MlneuralganRange {
  let result = ml_neural_gan_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_neural_gan_range_add(a : MlneuralganRange, b : MlneuralganRange) -> MlneuralganRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_neural_gan_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_neural_gan_range_copy(s : MlneuralganRange) -> MlneuralganRange {
  let result = ml_neural_gan_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_neural_gan_range_fill(s : MlneuralganRange, v : Double) -> MlneuralganRange {
  let result = ml_neural_gan_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_neural_gan_range_min(s : MlneuralganRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_gan_range_max(s : MlneuralganRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_gan_range_to_string(s : MlneuralganRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlneuralganSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_neural_gan_slice_make(size : Int) -> MlneuralganSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_neural_gan_slice_len(s : MlneuralganSlice) -> Int { s.size }

pub fn ml_neural_gan_slice_get(s : MlneuralganSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_neural_gan_slice_set(s : MlneuralganSlice, i : Int, v : Double) -> MlneuralganSlice {
  let result = ml_neural_gan_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_neural_gan_slice_sum(s : MlneuralganSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_neural_gan_slice_mean(s : MlneuralganSlice) -> Double {
  if s.size == 0 { 0.0 } else { ml_neural_gan_slice_sum(s) / s.size.to_double() }
}

pub fn ml_neural_gan_slice_scale(s : MlneuralganSlice, f : Double) -> MlneuralganSlice {
  let result = ml_neural_gan_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_neural_gan_slice_add(a : MlneuralganSlice, b : MlneuralganSlice) -> MlneuralganSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_neural_gan_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_neural_gan_slice_copy(s : MlneuralganSlice) -> MlneuralganSlice {
  let result = ml_neural_gan_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_neural_gan_slice_fill(s : MlneuralganSlice, v : Double) -> MlneuralganSlice {
  let result = ml_neural_gan_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_neural_gan_slice_min(s : MlneuralganSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_gan_slice_max(s : MlneuralganSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_neural_gan_slice_to_string(s : MlneuralganSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


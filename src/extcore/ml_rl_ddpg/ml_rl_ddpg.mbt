///===
/// extcore/ml_rl_ddpg

pub(all) struct MlrlddpgPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_rl_ddpg_make_point(x : Double, y : Double) -> MlrlddpgPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_rl_ddpg_make_point3(x : Double, y : Double, z : Double) -> MlrlddpgPoint {
  { x, y, z, label: 0 }
}

pub fn ml_rl_ddpg_point_x(pt : MlrlddpgPoint) -> Double { pt.x }

pub fn ml_rl_ddpg_point_y(pt : MlrlddpgPoint) -> Double { pt.y }

pub fn ml_rl_ddpg_point_z(pt : MlrlddpgPoint) -> Double { pt.z }

pub fn ml_rl_ddpg_point_label(pt : MlrlddpgPoint) -> Int { pt.label }

pub fn ml_rl_ddpg_point_dist(a : MlrlddpgPoint, b : MlrlddpgPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ml_rl_ddpg_point_add(a : MlrlddpgPoint, b : MlrlddpgPoint) -> MlrlddpgPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ml_rl_ddpg_point_sub(a : MlrlddpgPoint, b : MlrlddpgPoint) -> MlrlddpgPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ml_rl_ddpg_point_scale(pt : MlrlddpgPoint, s : Double) -> MlrlddpgPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ml_rl_ddpg_point_dot(a : MlrlddpgPoint, b : MlrlddpgPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ml_rl_ddpg_point_cross(a : MlrlddpgPoint, b : MlrlddpgPoint) -> MlrlddpgPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ml_rl_ddpg_point_norm(pt : MlrlddpgPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ml_rl_ddpg_point_normalize(pt : MlrlddpgPoint) -> MlrlddpgPoint {
  let n = ml_rl_ddpg_point_norm(pt)
  if n < 0.0000001 { pt } else { ml_rl_ddpg_point_scale(pt, 1.0 / n) }
}

pub fn ml_rl_ddpg_point_negate(pt : MlrlddpgPoint) -> MlrlddpgPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ml_rl_ddpg_point_mid(a : MlrlddpgPoint, b : MlrlddpgPoint) -> MlrlddpgPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ml_rl_ddpg_point_lerp(a : MlrlddpgPoint, b : MlrlddpgPoint, t : Double) -> MlrlddpgPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ml_rl_ddpg_point_to_string(pt : MlrlddpgPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MlrlddpgSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_rl_ddpg_make_series(vals : Array[Double], name : String) -> MlrlddpgSeries {
  { vals, name, meta: 0 }
}

pub fn ml_rl_ddpg_series_len(s : MlrlddpgSeries) -> Int { s.vals.length() }

pub fn ml_rl_ddpg_series_sum(s : MlrlddpgSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn ml_rl_ddpg_series_mean(s : MlrlddpgSeries) -> Double {
  let n = ml_rl_ddpg_series_len(s)
  if n == 0 { 0.0 } else { ml_rl_ddpg_series_sum(s) / n.to_double() }
}

pub fn ml_rl_ddpg_series_min(s : MlrlddpgSeries) -> Double {
  let n = ml_rl_ddpg_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn ml_rl_ddpg_series_max(s : MlrlddpgSeries) -> Double {
  let n = ml_rl_ddpg_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn ml_rl_ddpg_series_range(s : MlrlddpgSeries) -> Double {
  ml_rl_ddpg_series_max(s) - ml_rl_ddpg_series_min(s)
}

pub fn ml_rl_ddpg_series_var(s : MlrlddpgSeries) -> Double {
  let n = ml_rl_ddpg_series_len(s)
  if n == 0 { 0.0 } else {
    let m = ml_rl_ddpg_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn ml_rl_ddpg_series_std(s : MlrlddpgSeries) -> Double { @_common.sqrt(ml_rl_ddpg_series_var(s)) }

pub fn ml_rl_ddpg_series_median(s : MlrlddpgSeries) -> Double {
  let n = ml_rl_ddpg_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = ml_rl_ddpg_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ml_rl_ddpg_series_scale(s : MlrlddpgSeries, f : Double) -> MlrlddpgSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ml_rl_ddpg_series_add(a : MlrlddpgSeries, b : MlrlddpgSeries) -> MlrlddpgSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ml_rl_ddpg_series_sub(a : MlrlddpgSeries, b : MlrlddpgSeries) -> MlrlddpgSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ml_rl_ddpg_series_normalize(s : MlrlddpgSeries) -> MlrlddpgSeries {
  let mn = ml_rl_ddpg_series_min(s)
  let mx = ml_rl_ddpg_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ml_rl_ddpg_series_cumsum(s : MlrlddpgSeries) -> MlrlddpgSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn ml_rl_ddpg_series_to_string(s : MlrlddpgSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlrlddpgMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_rl_ddpg_make_matrix(rows : Int, cols : Int, val : Double) -> MlrlddpgMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_rl_ddpg_matrix_identity(n : Int) -> MlrlddpgMatrix {
  let m = ml_rl_ddpg_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ml_rl_ddpg_matrix_get(m : MlrlddpgMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ml_rl_ddpg_matrix_transpose(m : MlrlddpgMatrix) -> MlrlddpgMatrix {
  let result = ml_rl_ddpg_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ml_rl_ddpg_matrix_add(a : MlrlddpgMatrix, b : MlrlddpgMatrix) -> MlrlddpgMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ml_rl_ddpg_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ml_rl_ddpg_matrix_scale(m : MlrlddpgMatrix, s : Double) -> MlrlddpgMatrix {
  let result = ml_rl_ddpg_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ml_rl_ddpg_matrix_multiply(a : MlrlddpgMatrix, b : MlrlddpgMatrix) -> MlrlddpgMatrix {
  if a.cols != b.rows { return ml_rl_ddpg_make_matrix(a.rows, b.cols, 0.0) }
  let result = ml_rl_ddpg_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ml_rl_ddpg_matrix_trace(m : MlrlddpgMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ml_rl_ddpg_matrix_det(m : MlrlddpgMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ml_rl_ddpg_matrix_norm(m : MlrlddpgMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ml_rl_ddpg_matrix_to_string(m : MlrlddpgMatrix) -> String {
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

pub(all) struct MlrlddpgVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_rl_ddpg_make_vector(comps : Array[Double]) -> MlrlddpgVector {
  { comps, dim: comps.length() }
}

pub fn ml_rl_ddpg_vector_zero(dim : Int) -> MlrlddpgVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ml_rl_ddpg_vector_add(a : MlrlddpgVector, b : MlrlddpgVector) -> MlrlddpgVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_rl_ddpg_vector_sub(a : MlrlddpgVector, b : MlrlddpgVector) -> MlrlddpgVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_rl_ddpg_vector_scale(v : MlrlddpgVector, s : Double) -> MlrlddpgVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ml_rl_ddpg_vector_dot(a : MlrlddpgVector, b : MlrlddpgVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ml_rl_ddpg_vector_norm(v : MlrlddpgVector) -> Double { @_common.sqrt(ml_rl_ddpg_vector_dot(v, v)) }

pub fn ml_rl_ddpg_vector_normalize(v : MlrlddpgVector) -> MlrlddpgVector {
  let n = ml_rl_ddpg_vector_norm(v)
  if n < 0.0000001 { v } else { ml_rl_ddpg_vector_scale(v, 1.0 / n) }
}

pub fn ml_rl_ddpg_vector_dist(a : MlrlddpgVector, b : MlrlddpgVector) -> Double {
  ml_rl_ddpg_vector_norm(ml_rl_ddpg_vector_sub(a, b))
}

pub fn ml_rl_ddpg_vector_to_string(v : MlrlddpgVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_rl_ddpg_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_rl_ddpg_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_rl_ddpg_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_rl_ddpg_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_rl_ddpg_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_rl_ddpg_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_rl_ddpg_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_rl_ddpg_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_rl_ddpg_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_rl_ddpg_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_rl_ddpg_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_rl_ddpg_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_rl_ddpg_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_rl_ddpg_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_rl_ddpg_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_rl_ddpg_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_rl_ddpg_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_rl_ddpg_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_rl_ddpg_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_rl_ddpg_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_rl_ddpg_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_rl_ddpg_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_rl_ddpg_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_rl_ddpg_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_rl_ddpg_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_rl_ddpg_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_rl_ddpg_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_rl_ddpg_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_rl_ddpg_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlrlddpgFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_ddpg_frame_make(size : Int) -> MlrlddpgFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_ddpg_frame_len(s : MlrlddpgFrame) -> Int { s.size }

pub fn ml_rl_ddpg_frame_get(s : MlrlddpgFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_ddpg_frame_set(s : MlrlddpgFrame, i : Int, v : Double) -> MlrlddpgFrame {
  let result = ml_rl_ddpg_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_ddpg_frame_sum(s : MlrlddpgFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_rl_ddpg_frame_mean(s : MlrlddpgFrame) -> Double {
  if s.size == 0 { 0.0 } else { ml_rl_ddpg_frame_sum(s) / s.size.to_double() }
}

pub fn ml_rl_ddpg_frame_scale(s : MlrlddpgFrame, f : Double) -> MlrlddpgFrame {
  let result = ml_rl_ddpg_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_ddpg_frame_add(a : MlrlddpgFrame, b : MlrlddpgFrame) -> MlrlddpgFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_ddpg_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_ddpg_frame_copy(s : MlrlddpgFrame) -> MlrlddpgFrame {
  let result = ml_rl_ddpg_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_ddpg_frame_fill(s : MlrlddpgFrame, v : Double) -> MlrlddpgFrame {
  let result = ml_rl_ddpg_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_ddpg_frame_min(s : MlrlddpgFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_ddpg_frame_max(s : MlrlddpgFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_ddpg_frame_to_string(s : MlrlddpgFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlddpgTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_ddpg_table_make(size : Int) -> MlrlddpgTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_ddpg_table_len(s : MlrlddpgTable) -> Int { s.size }

pub fn ml_rl_ddpg_table_get(s : MlrlddpgTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_ddpg_table_set(s : MlrlddpgTable, i : Int, v : Double) -> MlrlddpgTable {
  let result = ml_rl_ddpg_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_ddpg_table_sum(s : MlrlddpgTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_rl_ddpg_table_mean(s : MlrlddpgTable) -> Double {
  if s.size == 0 { 0.0 } else { ml_rl_ddpg_table_sum(s) / s.size.to_double() }
}

pub fn ml_rl_ddpg_table_scale(s : MlrlddpgTable, f : Double) -> MlrlddpgTable {
  let result = ml_rl_ddpg_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_ddpg_table_add(a : MlrlddpgTable, b : MlrlddpgTable) -> MlrlddpgTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_ddpg_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_ddpg_table_copy(s : MlrlddpgTable) -> MlrlddpgTable {
  let result = ml_rl_ddpg_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_ddpg_table_fill(s : MlrlddpgTable, v : Double) -> MlrlddpgTable {
  let result = ml_rl_ddpg_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_ddpg_table_min(s : MlrlddpgTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_ddpg_table_max(s : MlrlddpgTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_ddpg_table_to_string(s : MlrlddpgTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlddpgGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_ddpg_graphn_make(size : Int) -> MlrlddpgGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_ddpg_graphn_len(s : MlrlddpgGraphN) -> Int { s.size }

pub fn ml_rl_ddpg_graphn_get(s : MlrlddpgGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_ddpg_graphn_set(s : MlrlddpgGraphN, i : Int, v : Double) -> MlrlddpgGraphN {
  let result = ml_rl_ddpg_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_ddpg_graphn_sum(s : MlrlddpgGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_rl_ddpg_graphn_mean(s : MlrlddpgGraphN) -> Double {
  if s.size == 0 { 0.0 } else { ml_rl_ddpg_graphn_sum(s) / s.size.to_double() }
}

pub fn ml_rl_ddpg_graphn_scale(s : MlrlddpgGraphN, f : Double) -> MlrlddpgGraphN {
  let result = ml_rl_ddpg_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_ddpg_graphn_add(a : MlrlddpgGraphN, b : MlrlddpgGraphN) -> MlrlddpgGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_ddpg_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_ddpg_graphn_copy(s : MlrlddpgGraphN) -> MlrlddpgGraphN {
  let result = ml_rl_ddpg_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_ddpg_graphn_fill(s : MlrlddpgGraphN, v : Double) -> MlrlddpgGraphN {
  let result = ml_rl_ddpg_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_ddpg_graphn_min(s : MlrlddpgGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_ddpg_graphn_max(s : MlrlddpgGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_ddpg_graphn_to_string(s : MlrlddpgGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlddpgNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_ddpg_node_make(size : Int) -> MlrlddpgNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_ddpg_node_len(s : MlrlddpgNode) -> Int { s.size }

pub fn ml_rl_ddpg_node_get(s : MlrlddpgNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_ddpg_node_set(s : MlrlddpgNode, i : Int, v : Double) -> MlrlddpgNode {
  let result = ml_rl_ddpg_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_ddpg_node_sum(s : MlrlddpgNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_rl_ddpg_node_mean(s : MlrlddpgNode) -> Double {
  if s.size == 0 { 0.0 } else { ml_rl_ddpg_node_sum(s) / s.size.to_double() }
}

pub fn ml_rl_ddpg_node_scale(s : MlrlddpgNode, f : Double) -> MlrlddpgNode {
  let result = ml_rl_ddpg_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_ddpg_node_add(a : MlrlddpgNode, b : MlrlddpgNode) -> MlrlddpgNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_ddpg_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_ddpg_node_copy(s : MlrlddpgNode) -> MlrlddpgNode {
  let result = ml_rl_ddpg_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_ddpg_node_fill(s : MlrlddpgNode, v : Double) -> MlrlddpgNode {
  let result = ml_rl_ddpg_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_ddpg_node_min(s : MlrlddpgNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_ddpg_node_max(s : MlrlddpgNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_ddpg_node_to_string(s : MlrlddpgNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlddpgEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_ddpg_edge_make(size : Int) -> MlrlddpgEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_ddpg_edge_len(s : MlrlddpgEdge) -> Int { s.size }

pub fn ml_rl_ddpg_edge_get(s : MlrlddpgEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_ddpg_edge_set(s : MlrlddpgEdge, i : Int, v : Double) -> MlrlddpgEdge {
  let result = ml_rl_ddpg_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_ddpg_edge_sum(s : MlrlddpgEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_rl_ddpg_edge_mean(s : MlrlddpgEdge) -> Double {
  if s.size == 0 { 0.0 } else { ml_rl_ddpg_edge_sum(s) / s.size.to_double() }
}

pub fn ml_rl_ddpg_edge_scale(s : MlrlddpgEdge, f : Double) -> MlrlddpgEdge {
  let result = ml_rl_ddpg_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_ddpg_edge_add(a : MlrlddpgEdge, b : MlrlddpgEdge) -> MlrlddpgEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_ddpg_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_ddpg_edge_copy(s : MlrlddpgEdge) -> MlrlddpgEdge {
  let result = ml_rl_ddpg_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_ddpg_edge_fill(s : MlrlddpgEdge, v : Double) -> MlrlddpgEdge {
  let result = ml_rl_ddpg_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_ddpg_edge_min(s : MlrlddpgEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_ddpg_edge_max(s : MlrlddpgEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_ddpg_edge_to_string(s : MlrlddpgEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlddpgPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_ddpg_path_make(size : Int) -> MlrlddpgPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_ddpg_path_len(s : MlrlddpgPath) -> Int { s.size }

pub fn ml_rl_ddpg_path_get(s : MlrlddpgPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_ddpg_path_set(s : MlrlddpgPath, i : Int, v : Double) -> MlrlddpgPath {
  let result = ml_rl_ddpg_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_ddpg_path_sum(s : MlrlddpgPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_rl_ddpg_path_mean(s : MlrlddpgPath) -> Double {
  if s.size == 0 { 0.0 } else { ml_rl_ddpg_path_sum(s) / s.size.to_double() }
}

pub fn ml_rl_ddpg_path_scale(s : MlrlddpgPath, f : Double) -> MlrlddpgPath {
  let result = ml_rl_ddpg_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_ddpg_path_add(a : MlrlddpgPath, b : MlrlddpgPath) -> MlrlddpgPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_ddpg_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_ddpg_path_copy(s : MlrlddpgPath) -> MlrlddpgPath {
  let result = ml_rl_ddpg_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_ddpg_path_fill(s : MlrlddpgPath, v : Double) -> MlrlddpgPath {
  let result = ml_rl_ddpg_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_ddpg_path_min(s : MlrlddpgPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_ddpg_path_max(s : MlrlddpgPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_ddpg_path_to_string(s : MlrlddpgPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlddpgCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_ddpg_cluster_make(size : Int) -> MlrlddpgCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_ddpg_cluster_len(s : MlrlddpgCluster) -> Int { s.size }

pub fn ml_rl_ddpg_cluster_get(s : MlrlddpgCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_ddpg_cluster_set(s : MlrlddpgCluster, i : Int, v : Double) -> MlrlddpgCluster {
  let result = ml_rl_ddpg_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_ddpg_cluster_sum(s : MlrlddpgCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_rl_ddpg_cluster_mean(s : MlrlddpgCluster) -> Double {
  if s.size == 0 { 0.0 } else { ml_rl_ddpg_cluster_sum(s) / s.size.to_double() }
}

pub fn ml_rl_ddpg_cluster_scale(s : MlrlddpgCluster, f : Double) -> MlrlddpgCluster {
  let result = ml_rl_ddpg_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_ddpg_cluster_add(a : MlrlddpgCluster, b : MlrlddpgCluster) -> MlrlddpgCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_ddpg_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_ddpg_cluster_copy(s : MlrlddpgCluster) -> MlrlddpgCluster {
  let result = ml_rl_ddpg_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_ddpg_cluster_fill(s : MlrlddpgCluster, v : Double) -> MlrlddpgCluster {
  let result = ml_rl_ddpg_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_ddpg_cluster_min(s : MlrlddpgCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_ddpg_cluster_max(s : MlrlddpgCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_ddpg_cluster_to_string(s : MlrlddpgCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlddpgModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_ddpg_model_make(size : Int) -> MlrlddpgModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_ddpg_model_len(s : MlrlddpgModel) -> Int { s.size }

pub fn ml_rl_ddpg_model_get(s : MlrlddpgModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_ddpg_model_set(s : MlrlddpgModel, i : Int, v : Double) -> MlrlddpgModel {
  let result = ml_rl_ddpg_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_ddpg_model_sum(s : MlrlddpgModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_rl_ddpg_model_mean(s : MlrlddpgModel) -> Double {
  if s.size == 0 { 0.0 } else { ml_rl_ddpg_model_sum(s) / s.size.to_double() }
}

pub fn ml_rl_ddpg_model_scale(s : MlrlddpgModel, f : Double) -> MlrlddpgModel {
  let result = ml_rl_ddpg_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_ddpg_model_add(a : MlrlddpgModel, b : MlrlddpgModel) -> MlrlddpgModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_ddpg_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_ddpg_model_copy(s : MlrlddpgModel) -> MlrlddpgModel {
  let result = ml_rl_ddpg_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_ddpg_model_fill(s : MlrlddpgModel, v : Double) -> MlrlddpgModel {
  let result = ml_rl_ddpg_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_ddpg_model_min(s : MlrlddpgModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_ddpg_model_max(s : MlrlddpgModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_ddpg_model_to_string(s : MlrlddpgModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlddpgLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_ddpg_layer_make(size : Int) -> MlrlddpgLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_ddpg_layer_len(s : MlrlddpgLayer) -> Int { s.size }

pub fn ml_rl_ddpg_layer_get(s : MlrlddpgLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_ddpg_layer_set(s : MlrlddpgLayer, i : Int, v : Double) -> MlrlddpgLayer {
  let result = ml_rl_ddpg_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_ddpg_layer_sum(s : MlrlddpgLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_rl_ddpg_layer_mean(s : MlrlddpgLayer) -> Double {
  if s.size == 0 { 0.0 } else { ml_rl_ddpg_layer_sum(s) / s.size.to_double() }
}

pub fn ml_rl_ddpg_layer_scale(s : MlrlddpgLayer, f : Double) -> MlrlddpgLayer {
  let result = ml_rl_ddpg_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_ddpg_layer_add(a : MlrlddpgLayer, b : MlrlddpgLayer) -> MlrlddpgLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_ddpg_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_ddpg_layer_copy(s : MlrlddpgLayer) -> MlrlddpgLayer {
  let result = ml_rl_ddpg_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_ddpg_layer_fill(s : MlrlddpgLayer, v : Double) -> MlrlddpgLayer {
  let result = ml_rl_ddpg_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_ddpg_layer_min(s : MlrlddpgLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_ddpg_layer_max(s : MlrlddpgLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_ddpg_layer_to_string(s : MlrlddpgLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlddpgBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_ddpg_buffer_make(size : Int) -> MlrlddpgBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_ddpg_buffer_len(s : MlrlddpgBuffer) -> Int { s.size }

pub fn ml_rl_ddpg_buffer_get(s : MlrlddpgBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_ddpg_buffer_set(s : MlrlddpgBuffer, i : Int, v : Double) -> MlrlddpgBuffer {
  let result = ml_rl_ddpg_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_ddpg_buffer_sum(s : MlrlddpgBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_rl_ddpg_buffer_mean(s : MlrlddpgBuffer) -> Double {
  if s.size == 0 { 0.0 } else { ml_rl_ddpg_buffer_sum(s) / s.size.to_double() }
}

pub fn ml_rl_ddpg_buffer_scale(s : MlrlddpgBuffer, f : Double) -> MlrlddpgBuffer {
  let result = ml_rl_ddpg_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_ddpg_buffer_add(a : MlrlddpgBuffer, b : MlrlddpgBuffer) -> MlrlddpgBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_ddpg_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_ddpg_buffer_copy(s : MlrlddpgBuffer) -> MlrlddpgBuffer {
  let result = ml_rl_ddpg_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_ddpg_buffer_fill(s : MlrlddpgBuffer, v : Double) -> MlrlddpgBuffer {
  let result = ml_rl_ddpg_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_ddpg_buffer_min(s : MlrlddpgBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_ddpg_buffer_max(s : MlrlddpgBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_ddpg_buffer_to_string(s : MlrlddpgBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlddpgCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_ddpg_cursor_make(size : Int) -> MlrlddpgCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_ddpg_cursor_len(s : MlrlddpgCursor) -> Int { s.size }

pub fn ml_rl_ddpg_cursor_get(s : MlrlddpgCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_ddpg_cursor_set(s : MlrlddpgCursor, i : Int, v : Double) -> MlrlddpgCursor {
  let result = ml_rl_ddpg_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_ddpg_cursor_sum(s : MlrlddpgCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_rl_ddpg_cursor_mean(s : MlrlddpgCursor) -> Double {
  if s.size == 0 { 0.0 } else { ml_rl_ddpg_cursor_sum(s) / s.size.to_double() }
}

pub fn ml_rl_ddpg_cursor_scale(s : MlrlddpgCursor, f : Double) -> MlrlddpgCursor {
  let result = ml_rl_ddpg_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_ddpg_cursor_add(a : MlrlddpgCursor, b : MlrlddpgCursor) -> MlrlddpgCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_ddpg_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_ddpg_cursor_copy(s : MlrlddpgCursor) -> MlrlddpgCursor {
  let result = ml_rl_ddpg_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_ddpg_cursor_fill(s : MlrlddpgCursor, v : Double) -> MlrlddpgCursor {
  let result = ml_rl_ddpg_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_ddpg_cursor_min(s : MlrlddpgCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_ddpg_cursor_max(s : MlrlddpgCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_ddpg_cursor_to_string(s : MlrlddpgCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlddpgView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_ddpg_view_make(size : Int) -> MlrlddpgView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_ddpg_view_len(s : MlrlddpgView) -> Int { s.size }

pub fn ml_rl_ddpg_view_get(s : MlrlddpgView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_ddpg_view_set(s : MlrlddpgView, i : Int, v : Double) -> MlrlddpgView {
  let result = ml_rl_ddpg_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_ddpg_view_sum(s : MlrlddpgView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_rl_ddpg_view_mean(s : MlrlddpgView) -> Double {
  if s.size == 0 { 0.0 } else { ml_rl_ddpg_view_sum(s) / s.size.to_double() }
}

pub fn ml_rl_ddpg_view_scale(s : MlrlddpgView, f : Double) -> MlrlddpgView {
  let result = ml_rl_ddpg_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_ddpg_view_add(a : MlrlddpgView, b : MlrlddpgView) -> MlrlddpgView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_ddpg_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_ddpg_view_copy(s : MlrlddpgView) -> MlrlddpgView {
  let result = ml_rl_ddpg_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_ddpg_view_fill(s : MlrlddpgView, v : Double) -> MlrlddpgView {
  let result = ml_rl_ddpg_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_ddpg_view_min(s : MlrlddpgView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_ddpg_view_max(s : MlrlddpgView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_ddpg_view_to_string(s : MlrlddpgView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlddpgRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_ddpg_range_make(size : Int) -> MlrlddpgRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_ddpg_range_len(s : MlrlddpgRange) -> Int { s.size }

pub fn ml_rl_ddpg_range_get(s : MlrlddpgRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_ddpg_range_set(s : MlrlddpgRange, i : Int, v : Double) -> MlrlddpgRange {
  let result = ml_rl_ddpg_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_ddpg_range_sum(s : MlrlddpgRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_rl_ddpg_range_mean(s : MlrlddpgRange) -> Double {
  if s.size == 0 { 0.0 } else { ml_rl_ddpg_range_sum(s) / s.size.to_double() }
}

pub fn ml_rl_ddpg_range_scale(s : MlrlddpgRange, f : Double) -> MlrlddpgRange {
  let result = ml_rl_ddpg_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_ddpg_range_add(a : MlrlddpgRange, b : MlrlddpgRange) -> MlrlddpgRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_ddpg_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_ddpg_range_copy(s : MlrlddpgRange) -> MlrlddpgRange {
  let result = ml_rl_ddpg_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_ddpg_range_fill(s : MlrlddpgRange, v : Double) -> MlrlddpgRange {
  let result = ml_rl_ddpg_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_ddpg_range_min(s : MlrlddpgRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_ddpg_range_max(s : MlrlddpgRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_ddpg_range_to_string(s : MlrlddpgRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlddpgSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_ddpg_slice_make(size : Int) -> MlrlddpgSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_ddpg_slice_len(s : MlrlddpgSlice) -> Int { s.size }

pub fn ml_rl_ddpg_slice_get(s : MlrlddpgSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_ddpg_slice_set(s : MlrlddpgSlice, i : Int, v : Double) -> MlrlddpgSlice {
  let result = ml_rl_ddpg_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_ddpg_slice_sum(s : MlrlddpgSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_rl_ddpg_slice_mean(s : MlrlddpgSlice) -> Double {
  if s.size == 0 { 0.0 } else { ml_rl_ddpg_slice_sum(s) / s.size.to_double() }
}

pub fn ml_rl_ddpg_slice_scale(s : MlrlddpgSlice, f : Double) -> MlrlddpgSlice {
  let result = ml_rl_ddpg_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_ddpg_slice_add(a : MlrlddpgSlice, b : MlrlddpgSlice) -> MlrlddpgSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_ddpg_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_ddpg_slice_copy(s : MlrlddpgSlice) -> MlrlddpgSlice {
  let result = ml_rl_ddpg_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_ddpg_slice_fill(s : MlrlddpgSlice, v : Double) -> MlrlddpgSlice {
  let result = ml_rl_ddpg_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_ddpg_slice_min(s : MlrlddpgSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_ddpg_slice_max(s : MlrlddpgSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_ddpg_slice_to_string(s : MlrlddpgSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


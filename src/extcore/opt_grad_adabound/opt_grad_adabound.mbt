///===
/// extcore/opt_grad_adabound

pub(all) struct OptgradadaboundPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn opt_grad_adabound_make_point(x : Double, y : Double) -> OptgradadaboundPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn opt_grad_adabound_make_point3(x : Double, y : Double, z : Double) -> OptgradadaboundPoint {
  { x, y, z, label: 0 }
}

pub fn opt_grad_adabound_point_x(pt : OptgradadaboundPoint) -> Double { pt.x }

pub fn opt_grad_adabound_point_y(pt : OptgradadaboundPoint) -> Double { pt.y }

pub fn opt_grad_adabound_point_z(pt : OptgradadaboundPoint) -> Double { pt.z }

pub fn opt_grad_adabound_point_label(pt : OptgradadaboundPoint) -> Int { pt.label }

pub fn opt_grad_adabound_point_dist(a : OptgradadaboundPoint, b : OptgradadaboundPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn opt_grad_adabound_point_add(a : OptgradadaboundPoint, b : OptgradadaboundPoint) -> OptgradadaboundPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn opt_grad_adabound_point_sub(a : OptgradadaboundPoint, b : OptgradadaboundPoint) -> OptgradadaboundPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn opt_grad_adabound_point_scale(pt : OptgradadaboundPoint, s : Double) -> OptgradadaboundPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn opt_grad_adabound_point_dot(a : OptgradadaboundPoint, b : OptgradadaboundPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn opt_grad_adabound_point_cross(a : OptgradadaboundPoint, b : OptgradadaboundPoint) -> OptgradadaboundPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn opt_grad_adabound_point_norm(pt : OptgradadaboundPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn opt_grad_adabound_point_normalize(pt : OptgradadaboundPoint) -> OptgradadaboundPoint {
  let n = opt_grad_adabound_point_norm(pt)
  if n < 0.0000001 { pt } else { opt_grad_adabound_point_scale(pt, 1.0 / n) }
}

pub fn opt_grad_adabound_point_negate(pt : OptgradadaboundPoint) -> OptgradadaboundPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn opt_grad_adabound_point_mid(a : OptgradadaboundPoint, b : OptgradadaboundPoint) -> OptgradadaboundPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn opt_grad_adabound_point_lerp(a : OptgradadaboundPoint, b : OptgradadaboundPoint, t : Double) -> OptgradadaboundPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn opt_grad_adabound_point_to_string(pt : OptgradadaboundPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct OptgradadaboundSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn opt_grad_adabound_make_series(vals : Array[Double], name : String) -> OptgradadaboundSeries {
  { vals, name, meta: 0 }
}

pub fn opt_grad_adabound_series_len(s : OptgradadaboundSeries) -> Int { s.vals.length() }

pub fn opt_grad_adabound_series_sum(s : OptgradadaboundSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn opt_grad_adabound_series_mean(s : OptgradadaboundSeries) -> Double { @_common.mean(s.vals) }

pub fn opt_grad_adabound_series_min(s : OptgradadaboundSeries) -> Double { @_common.min(s.vals) }

pub fn opt_grad_adabound_series_max(s : OptgradadaboundSeries) -> Double { @_common.max(s.vals) }

pub fn opt_grad_adabound_series_range(s : OptgradadaboundSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn opt_grad_adabound_series_var(s : OptgradadaboundSeries) -> Double { @_common.variance(s.vals) }

pub fn opt_grad_adabound_series_std(s : OptgradadaboundSeries) -> Double { @_common.std(s.vals) }

pub fn opt_grad_adabound_series_median(s : OptgradadaboundSeries) -> Double { @_common.median(s.vals) }

pub fn opt_grad_adabound_series_scale(s : OptgradadaboundSeries, f : Double) -> OptgradadaboundSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn opt_grad_adabound_series_add(a : OptgradadaboundSeries, b : OptgradadaboundSeries) -> OptgradadaboundSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn opt_grad_adabound_series_sub(a : OptgradadaboundSeries, b : OptgradadaboundSeries) -> OptgradadaboundSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn opt_grad_adabound_series_normalize(s : OptgradadaboundSeries) -> OptgradadaboundSeries {
  let mn = opt_grad_adabound_series_min(s)
  let mx = opt_grad_adabound_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn opt_grad_adabound_series_cumsum(s : OptgradadaboundSeries) -> OptgradadaboundSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn opt_grad_adabound_series_to_string(s : OptgradadaboundSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct OptgradadaboundMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn opt_grad_adabound_make_matrix(rows : Int, cols : Int, val : Double) -> OptgradadaboundMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn opt_grad_adabound_matrix_identity(n : Int) -> OptgradadaboundMatrix {
  let m = opt_grad_adabound_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn opt_grad_adabound_matrix_get(m : OptgradadaboundMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn opt_grad_adabound_matrix_transpose(m : OptgradadaboundMatrix) -> OptgradadaboundMatrix {
  let result = opt_grad_adabound_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn opt_grad_adabound_matrix_add(a : OptgradadaboundMatrix, b : OptgradadaboundMatrix) -> OptgradadaboundMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = opt_grad_adabound_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn opt_grad_adabound_matrix_scale(m : OptgradadaboundMatrix, s : Double) -> OptgradadaboundMatrix {
  let result = opt_grad_adabound_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn opt_grad_adabound_matrix_multiply(a : OptgradadaboundMatrix, b : OptgradadaboundMatrix) -> OptgradadaboundMatrix {
  if a.cols != b.rows { return opt_grad_adabound_make_matrix(a.rows, b.cols, 0.0) }
  let result = opt_grad_adabound_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn opt_grad_adabound_matrix_trace(m : OptgradadaboundMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn opt_grad_adabound_matrix_det(m : OptgradadaboundMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn opt_grad_adabound_matrix_norm(m : OptgradadaboundMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn opt_grad_adabound_matrix_to_string(m : OptgradadaboundMatrix) -> String {
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

pub(all) struct OptgradadaboundVector {
  comps : Array[Double]
  dim : Int
}

pub fn opt_grad_adabound_make_vector(comps : Array[Double]) -> OptgradadaboundVector {
  { comps, dim: comps.length() }
}

pub fn opt_grad_adabound_vector_zero(dim : Int) -> OptgradadaboundVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn opt_grad_adabound_vector_add(a : OptgradadaboundVector, b : OptgradadaboundVector) -> OptgradadaboundVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn opt_grad_adabound_vector_sub(a : OptgradadaboundVector, b : OptgradadaboundVector) -> OptgradadaboundVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn opt_grad_adabound_vector_scale(v : OptgradadaboundVector, s : Double) -> OptgradadaboundVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn opt_grad_adabound_vector_dot(a : OptgradadaboundVector, b : OptgradadaboundVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn opt_grad_adabound_vector_norm(v : OptgradadaboundVector) -> Double { @_common.sqrt(opt_grad_adabound_vector_dot(v, v)) }

pub fn opt_grad_adabound_vector_normalize(v : OptgradadaboundVector) -> OptgradadaboundVector {
  let n = opt_grad_adabound_vector_norm(v)
  if n < 0.0000001 { v } else { opt_grad_adabound_vector_scale(v, 1.0 / n) }
}

pub fn opt_grad_adabound_vector_dist(a : OptgradadaboundVector, b : OptgradadaboundVector) -> Double {
  opt_grad_adabound_vector_norm(opt_grad_adabound_vector_sub(a, b))
}

pub fn opt_grad_adabound_vector_to_string(v : OptgradadaboundVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn opt_grad_adabound_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn opt_grad_adabound_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn opt_grad_adabound_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn opt_grad_adabound_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn opt_grad_adabound_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn opt_grad_adabound_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn opt_grad_adabound_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn opt_grad_adabound_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn opt_grad_adabound_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn opt_grad_adabound_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn opt_grad_adabound_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn opt_grad_adabound_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn opt_grad_adabound_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn opt_grad_adabound_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn opt_grad_adabound_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn opt_grad_adabound_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn opt_grad_adabound_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn opt_grad_adabound_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn opt_grad_adabound_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn opt_grad_adabound_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn opt_grad_adabound_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn opt_grad_adabound_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn opt_grad_adabound_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn opt_grad_adabound_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn opt_grad_adabound_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn opt_grad_adabound_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn opt_grad_adabound_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn opt_grad_adabound_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn opt_grad_adabound_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct OptgradadaboundFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adabound_frame_make(size : Int) -> OptgradadaboundFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adabound_frame_len(s : OptgradadaboundFrame) -> Int { s.size }

pub fn opt_grad_adabound_frame_get(s : OptgradadaboundFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adabound_frame_set(s : OptgradadaboundFrame, i : Int, v : Double) -> OptgradadaboundFrame {
  let result = opt_grad_adabound_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_adabound_frame_sum(s : OptgradadaboundFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_adabound_frame_mean(s : OptgradadaboundFrame) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_adabound_frame_sum(s) / s.size.to_double() }
}

pub fn opt_grad_adabound_frame_scale(s : OptgradadaboundFrame, f : Double) -> OptgradadaboundFrame {
  let result = opt_grad_adabound_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_adabound_frame_add(a : OptgradadaboundFrame, b : OptgradadaboundFrame) -> OptgradadaboundFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_adabound_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_adabound_frame_copy(s : OptgradadaboundFrame) -> OptgradadaboundFrame {
  let result = opt_grad_adabound_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_adabound_frame_fill(s : OptgradadaboundFrame, v : Double) -> OptgradadaboundFrame {
  let result = opt_grad_adabound_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_adabound_frame_min(s : OptgradadaboundFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_adabound_frame_max(s : OptgradadaboundFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_adabound_frame_to_string(s : OptgradadaboundFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradadaboundTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adabound_table_make(size : Int) -> OptgradadaboundTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adabound_table_len(s : OptgradadaboundTable) -> Int { s.size }

pub fn opt_grad_adabound_table_get(s : OptgradadaboundTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adabound_table_set(s : OptgradadaboundTable, i : Int, v : Double) -> OptgradadaboundTable {
  let result = opt_grad_adabound_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_adabound_table_sum(s : OptgradadaboundTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_adabound_table_mean(s : OptgradadaboundTable) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_adabound_table_sum(s) / s.size.to_double() }
}

pub fn opt_grad_adabound_table_scale(s : OptgradadaboundTable, f : Double) -> OptgradadaboundTable {
  let result = opt_grad_adabound_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_adabound_table_add(a : OptgradadaboundTable, b : OptgradadaboundTable) -> OptgradadaboundTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_adabound_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_adabound_table_copy(s : OptgradadaboundTable) -> OptgradadaboundTable {
  let result = opt_grad_adabound_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_adabound_table_fill(s : OptgradadaboundTable, v : Double) -> OptgradadaboundTable {
  let result = opt_grad_adabound_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_adabound_table_min(s : OptgradadaboundTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_adabound_table_max(s : OptgradadaboundTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_adabound_table_to_string(s : OptgradadaboundTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradadaboundGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adabound_graphn_make(size : Int) -> OptgradadaboundGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adabound_graphn_len(s : OptgradadaboundGraphN) -> Int { s.size }

pub fn opt_grad_adabound_graphn_get(s : OptgradadaboundGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adabound_graphn_set(s : OptgradadaboundGraphN, i : Int, v : Double) -> OptgradadaboundGraphN {
  let result = opt_grad_adabound_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_adabound_graphn_sum(s : OptgradadaboundGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_adabound_graphn_mean(s : OptgradadaboundGraphN) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_adabound_graphn_sum(s) / s.size.to_double() }
}

pub fn opt_grad_adabound_graphn_scale(s : OptgradadaboundGraphN, f : Double) -> OptgradadaboundGraphN {
  let result = opt_grad_adabound_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_adabound_graphn_add(a : OptgradadaboundGraphN, b : OptgradadaboundGraphN) -> OptgradadaboundGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_adabound_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_adabound_graphn_copy(s : OptgradadaboundGraphN) -> OptgradadaboundGraphN {
  let result = opt_grad_adabound_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_adabound_graphn_fill(s : OptgradadaboundGraphN, v : Double) -> OptgradadaboundGraphN {
  let result = opt_grad_adabound_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_adabound_graphn_min(s : OptgradadaboundGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_adabound_graphn_max(s : OptgradadaboundGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_adabound_graphn_to_string(s : OptgradadaboundGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradadaboundNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adabound_node_make(size : Int) -> OptgradadaboundNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adabound_node_len(s : OptgradadaboundNode) -> Int { s.size }

pub fn opt_grad_adabound_node_get(s : OptgradadaboundNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adabound_node_set(s : OptgradadaboundNode, i : Int, v : Double) -> OptgradadaboundNode {
  let result = opt_grad_adabound_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_adabound_node_sum(s : OptgradadaboundNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_adabound_node_mean(s : OptgradadaboundNode) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_adabound_node_sum(s) / s.size.to_double() }
}

pub fn opt_grad_adabound_node_scale(s : OptgradadaboundNode, f : Double) -> OptgradadaboundNode {
  let result = opt_grad_adabound_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_adabound_node_add(a : OptgradadaboundNode, b : OptgradadaboundNode) -> OptgradadaboundNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_adabound_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_adabound_node_copy(s : OptgradadaboundNode) -> OptgradadaboundNode {
  let result = opt_grad_adabound_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_adabound_node_fill(s : OptgradadaboundNode, v : Double) -> OptgradadaboundNode {
  let result = opt_grad_adabound_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_adabound_node_min(s : OptgradadaboundNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_adabound_node_max(s : OptgradadaboundNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_adabound_node_to_string(s : OptgradadaboundNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradadaboundEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adabound_edge_make(size : Int) -> OptgradadaboundEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adabound_edge_len(s : OptgradadaboundEdge) -> Int { s.size }

pub fn opt_grad_adabound_edge_get(s : OptgradadaboundEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adabound_edge_set(s : OptgradadaboundEdge, i : Int, v : Double) -> OptgradadaboundEdge {
  let result = opt_grad_adabound_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_adabound_edge_sum(s : OptgradadaboundEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_adabound_edge_mean(s : OptgradadaboundEdge) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_adabound_edge_sum(s) / s.size.to_double() }
}

pub fn opt_grad_adabound_edge_scale(s : OptgradadaboundEdge, f : Double) -> OptgradadaboundEdge {
  let result = opt_grad_adabound_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_adabound_edge_add(a : OptgradadaboundEdge, b : OptgradadaboundEdge) -> OptgradadaboundEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_adabound_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_adabound_edge_copy(s : OptgradadaboundEdge) -> OptgradadaboundEdge {
  let result = opt_grad_adabound_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_adabound_edge_fill(s : OptgradadaboundEdge, v : Double) -> OptgradadaboundEdge {
  let result = opt_grad_adabound_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_adabound_edge_min(s : OptgradadaboundEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_adabound_edge_max(s : OptgradadaboundEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_adabound_edge_to_string(s : OptgradadaboundEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradadaboundPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adabound_path_make(size : Int) -> OptgradadaboundPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adabound_path_len(s : OptgradadaboundPath) -> Int { s.size }

pub fn opt_grad_adabound_path_get(s : OptgradadaboundPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adabound_path_set(s : OptgradadaboundPath, i : Int, v : Double) -> OptgradadaboundPath {
  let result = opt_grad_adabound_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_adabound_path_sum(s : OptgradadaboundPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_adabound_path_mean(s : OptgradadaboundPath) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_adabound_path_sum(s) / s.size.to_double() }
}

pub fn opt_grad_adabound_path_scale(s : OptgradadaboundPath, f : Double) -> OptgradadaboundPath {
  let result = opt_grad_adabound_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_adabound_path_add(a : OptgradadaboundPath, b : OptgradadaboundPath) -> OptgradadaboundPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_adabound_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_adabound_path_copy(s : OptgradadaboundPath) -> OptgradadaboundPath {
  let result = opt_grad_adabound_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_adabound_path_fill(s : OptgradadaboundPath, v : Double) -> OptgradadaboundPath {
  let result = opt_grad_adabound_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_adabound_path_min(s : OptgradadaboundPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_adabound_path_max(s : OptgradadaboundPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_adabound_path_to_string(s : OptgradadaboundPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradadaboundCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adabound_cluster_make(size : Int) -> OptgradadaboundCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adabound_cluster_len(s : OptgradadaboundCluster) -> Int { s.size }

pub fn opt_grad_adabound_cluster_get(s : OptgradadaboundCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adabound_cluster_set(s : OptgradadaboundCluster, i : Int, v : Double) -> OptgradadaboundCluster {
  let result = opt_grad_adabound_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_adabound_cluster_sum(s : OptgradadaboundCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_adabound_cluster_mean(s : OptgradadaboundCluster) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_adabound_cluster_sum(s) / s.size.to_double() }
}

pub fn opt_grad_adabound_cluster_scale(s : OptgradadaboundCluster, f : Double) -> OptgradadaboundCluster {
  let result = opt_grad_adabound_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_adabound_cluster_add(a : OptgradadaboundCluster, b : OptgradadaboundCluster) -> OptgradadaboundCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_adabound_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_adabound_cluster_copy(s : OptgradadaboundCluster) -> OptgradadaboundCluster {
  let result = opt_grad_adabound_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_adabound_cluster_fill(s : OptgradadaboundCluster, v : Double) -> OptgradadaboundCluster {
  let result = opt_grad_adabound_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_adabound_cluster_min(s : OptgradadaboundCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_adabound_cluster_max(s : OptgradadaboundCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_adabound_cluster_to_string(s : OptgradadaboundCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradadaboundModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adabound_model_make(size : Int) -> OptgradadaboundModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adabound_model_len(s : OptgradadaboundModel) -> Int { s.size }

pub fn opt_grad_adabound_model_get(s : OptgradadaboundModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adabound_model_set(s : OptgradadaboundModel, i : Int, v : Double) -> OptgradadaboundModel {
  let result = opt_grad_adabound_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_adabound_model_sum(s : OptgradadaboundModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_adabound_model_mean(s : OptgradadaboundModel) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_adabound_model_sum(s) / s.size.to_double() }
}

pub fn opt_grad_adabound_model_scale(s : OptgradadaboundModel, f : Double) -> OptgradadaboundModel {
  let result = opt_grad_adabound_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_adabound_model_add(a : OptgradadaboundModel, b : OptgradadaboundModel) -> OptgradadaboundModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_adabound_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_adabound_model_copy(s : OptgradadaboundModel) -> OptgradadaboundModel {
  let result = opt_grad_adabound_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_adabound_model_fill(s : OptgradadaboundModel, v : Double) -> OptgradadaboundModel {
  let result = opt_grad_adabound_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_adabound_model_min(s : OptgradadaboundModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_adabound_model_max(s : OptgradadaboundModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_adabound_model_to_string(s : OptgradadaboundModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradadaboundLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adabound_layer_make(size : Int) -> OptgradadaboundLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adabound_layer_len(s : OptgradadaboundLayer) -> Int { s.size }

pub fn opt_grad_adabound_layer_get(s : OptgradadaboundLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adabound_layer_set(s : OptgradadaboundLayer, i : Int, v : Double) -> OptgradadaboundLayer {
  let result = opt_grad_adabound_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_adabound_layer_sum(s : OptgradadaboundLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_adabound_layer_mean(s : OptgradadaboundLayer) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_adabound_layer_sum(s) / s.size.to_double() }
}

pub fn opt_grad_adabound_layer_scale(s : OptgradadaboundLayer, f : Double) -> OptgradadaboundLayer {
  let result = opt_grad_adabound_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_adabound_layer_add(a : OptgradadaboundLayer, b : OptgradadaboundLayer) -> OptgradadaboundLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_adabound_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_adabound_layer_copy(s : OptgradadaboundLayer) -> OptgradadaboundLayer {
  let result = opt_grad_adabound_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_adabound_layer_fill(s : OptgradadaboundLayer, v : Double) -> OptgradadaboundLayer {
  let result = opt_grad_adabound_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_adabound_layer_min(s : OptgradadaboundLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_adabound_layer_max(s : OptgradadaboundLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_adabound_layer_to_string(s : OptgradadaboundLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradadaboundBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adabound_buffer_make(size : Int) -> OptgradadaboundBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adabound_buffer_len(s : OptgradadaboundBuffer) -> Int { s.size }

pub fn opt_grad_adabound_buffer_get(s : OptgradadaboundBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adabound_buffer_set(s : OptgradadaboundBuffer, i : Int, v : Double) -> OptgradadaboundBuffer {
  let result = opt_grad_adabound_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_adabound_buffer_sum(s : OptgradadaboundBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_adabound_buffer_mean(s : OptgradadaboundBuffer) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_adabound_buffer_sum(s) / s.size.to_double() }
}

pub fn opt_grad_adabound_buffer_scale(s : OptgradadaboundBuffer, f : Double) -> OptgradadaboundBuffer {
  let result = opt_grad_adabound_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_adabound_buffer_add(a : OptgradadaboundBuffer, b : OptgradadaboundBuffer) -> OptgradadaboundBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_adabound_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_adabound_buffer_copy(s : OptgradadaboundBuffer) -> OptgradadaboundBuffer {
  let result = opt_grad_adabound_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_adabound_buffer_fill(s : OptgradadaboundBuffer, v : Double) -> OptgradadaboundBuffer {
  let result = opt_grad_adabound_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_adabound_buffer_min(s : OptgradadaboundBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_adabound_buffer_max(s : OptgradadaboundBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_adabound_buffer_to_string(s : OptgradadaboundBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradadaboundCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adabound_cursor_make(size : Int) -> OptgradadaboundCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adabound_cursor_len(s : OptgradadaboundCursor) -> Int { s.size }

pub fn opt_grad_adabound_cursor_get(s : OptgradadaboundCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adabound_cursor_set(s : OptgradadaboundCursor, i : Int, v : Double) -> OptgradadaboundCursor {
  let result = opt_grad_adabound_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_adabound_cursor_sum(s : OptgradadaboundCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_adabound_cursor_mean(s : OptgradadaboundCursor) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_adabound_cursor_sum(s) / s.size.to_double() }
}

pub fn opt_grad_adabound_cursor_scale(s : OptgradadaboundCursor, f : Double) -> OptgradadaboundCursor {
  let result = opt_grad_adabound_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_adabound_cursor_add(a : OptgradadaboundCursor, b : OptgradadaboundCursor) -> OptgradadaboundCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_adabound_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_adabound_cursor_copy(s : OptgradadaboundCursor) -> OptgradadaboundCursor {
  let result = opt_grad_adabound_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_adabound_cursor_fill(s : OptgradadaboundCursor, v : Double) -> OptgradadaboundCursor {
  let result = opt_grad_adabound_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_adabound_cursor_min(s : OptgradadaboundCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_adabound_cursor_max(s : OptgradadaboundCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_adabound_cursor_to_string(s : OptgradadaboundCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradadaboundView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adabound_view_make(size : Int) -> OptgradadaboundView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adabound_view_len(s : OptgradadaboundView) -> Int { s.size }

pub fn opt_grad_adabound_view_get(s : OptgradadaboundView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adabound_view_set(s : OptgradadaboundView, i : Int, v : Double) -> OptgradadaboundView {
  let result = opt_grad_adabound_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_adabound_view_sum(s : OptgradadaboundView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_adabound_view_mean(s : OptgradadaboundView) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_adabound_view_sum(s) / s.size.to_double() }
}

pub fn opt_grad_adabound_view_scale(s : OptgradadaboundView, f : Double) -> OptgradadaboundView {
  let result = opt_grad_adabound_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_adabound_view_add(a : OptgradadaboundView, b : OptgradadaboundView) -> OptgradadaboundView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_adabound_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_adabound_view_copy(s : OptgradadaboundView) -> OptgradadaboundView {
  let result = opt_grad_adabound_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_adabound_view_fill(s : OptgradadaboundView, v : Double) -> OptgradadaboundView {
  let result = opt_grad_adabound_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_adabound_view_min(s : OptgradadaboundView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_adabound_view_max(s : OptgradadaboundView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_adabound_view_to_string(s : OptgradadaboundView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradadaboundRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adabound_range_make(size : Int) -> OptgradadaboundRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adabound_range_len(s : OptgradadaboundRange) -> Int { s.size }

pub fn opt_grad_adabound_range_get(s : OptgradadaboundRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adabound_range_set(s : OptgradadaboundRange, i : Int, v : Double) -> OptgradadaboundRange {
  let result = opt_grad_adabound_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_adabound_range_sum(s : OptgradadaboundRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_adabound_range_mean(s : OptgradadaboundRange) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_adabound_range_sum(s) / s.size.to_double() }
}

pub fn opt_grad_adabound_range_scale(s : OptgradadaboundRange, f : Double) -> OptgradadaboundRange {
  let result = opt_grad_adabound_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_adabound_range_add(a : OptgradadaboundRange, b : OptgradadaboundRange) -> OptgradadaboundRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_adabound_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_adabound_range_copy(s : OptgradadaboundRange) -> OptgradadaboundRange {
  let result = opt_grad_adabound_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_adabound_range_fill(s : OptgradadaboundRange, v : Double) -> OptgradadaboundRange {
  let result = opt_grad_adabound_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_adabound_range_min(s : OptgradadaboundRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_adabound_range_max(s : OptgradadaboundRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_adabound_range_to_string(s : OptgradadaboundRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradadaboundSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adabound_slice_make(size : Int) -> OptgradadaboundSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adabound_slice_len(s : OptgradadaboundSlice) -> Int { s.size }

pub fn opt_grad_adabound_slice_get(s : OptgradadaboundSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adabound_slice_set(s : OptgradadaboundSlice, i : Int, v : Double) -> OptgradadaboundSlice {
  let result = opt_grad_adabound_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_adabound_slice_sum(s : OptgradadaboundSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_adabound_slice_mean(s : OptgradadaboundSlice) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_adabound_slice_sum(s) / s.size.to_double() }
}

pub fn opt_grad_adabound_slice_scale(s : OptgradadaboundSlice, f : Double) -> OptgradadaboundSlice {
  let result = opt_grad_adabound_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_adabound_slice_add(a : OptgradadaboundSlice, b : OptgradadaboundSlice) -> OptgradadaboundSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_adabound_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_adabound_slice_copy(s : OptgradadaboundSlice) -> OptgradadaboundSlice {
  let result = opt_grad_adabound_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_adabound_slice_fill(s : OptgradadaboundSlice, v : Double) -> OptgradadaboundSlice {
  let result = opt_grad_adabound_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_adabound_slice_min(s : OptgradadaboundSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_adabound_slice_max(s : OptgradadaboundSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_adabound_slice_to_string(s : OptgradadaboundSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


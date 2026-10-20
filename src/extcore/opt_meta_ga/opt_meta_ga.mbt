///===
/// extcore/opt_meta_ga

pub(all) struct OptmetagaPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn opt_meta_ga_make_point(x : Double, y : Double) -> OptmetagaPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn opt_meta_ga_make_point3(x : Double, y : Double, z : Double) -> OptmetagaPoint {
  { x, y, z, label: 0 }
}

pub fn opt_meta_ga_point_x(pt : OptmetagaPoint) -> Double { pt.x }

pub fn opt_meta_ga_point_y(pt : OptmetagaPoint) -> Double { pt.y }

pub fn opt_meta_ga_point_z(pt : OptmetagaPoint) -> Double { pt.z }

pub fn opt_meta_ga_point_label(pt : OptmetagaPoint) -> Int { pt.label }

pub fn opt_meta_ga_point_dist(a : OptmetagaPoint, b : OptmetagaPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn opt_meta_ga_point_add(a : OptmetagaPoint, b : OptmetagaPoint) -> OptmetagaPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn opt_meta_ga_point_sub(a : OptmetagaPoint, b : OptmetagaPoint) -> OptmetagaPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn opt_meta_ga_point_scale(pt : OptmetagaPoint, s : Double) -> OptmetagaPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn opt_meta_ga_point_dot(a : OptmetagaPoint, b : OptmetagaPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn opt_meta_ga_point_cross(a : OptmetagaPoint, b : OptmetagaPoint) -> OptmetagaPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn opt_meta_ga_point_norm(pt : OptmetagaPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn opt_meta_ga_point_normalize(pt : OptmetagaPoint) -> OptmetagaPoint {
  let n = opt_meta_ga_point_norm(pt)
  if n < 0.0000001 { pt } else { opt_meta_ga_point_scale(pt, 1.0 / n) }
}

pub fn opt_meta_ga_point_negate(pt : OptmetagaPoint) -> OptmetagaPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn opt_meta_ga_point_mid(a : OptmetagaPoint, b : OptmetagaPoint) -> OptmetagaPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn opt_meta_ga_point_lerp(a : OptmetagaPoint, b : OptmetagaPoint, t : Double) -> OptmetagaPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn opt_meta_ga_point_to_string(pt : OptmetagaPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct OptmetagaSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn opt_meta_ga_make_series(vals : Array[Double], name : String) -> OptmetagaSeries {
  { vals, name, meta: 0 }
}

pub fn opt_meta_ga_series_len(s : OptmetagaSeries) -> Int { s.vals.length() }

pub fn opt_meta_ga_series_sum(s : OptmetagaSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn opt_meta_ga_series_mean(s : OptmetagaSeries) -> Double { @_common.mean(s.vals) }

pub fn opt_meta_ga_series_min(s : OptmetagaSeries) -> Double { @_common.min(s.vals) }

pub fn opt_meta_ga_series_max(s : OptmetagaSeries) -> Double { @_common.max(s.vals) }

pub fn opt_meta_ga_series_range(s : OptmetagaSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn opt_meta_ga_series_var(s : OptmetagaSeries) -> Double { @_common.variance(s.vals) }

pub fn opt_meta_ga_series_std(s : OptmetagaSeries) -> Double { @_common.std(s.vals) }

pub fn opt_meta_ga_series_median(s : OptmetagaSeries) -> Double { @_common.median(s.vals) }

pub fn opt_meta_ga_series_scale(s : OptmetagaSeries, f : Double) -> OptmetagaSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn opt_meta_ga_series_add(a : OptmetagaSeries, b : OptmetagaSeries) -> OptmetagaSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn opt_meta_ga_series_sub(a : OptmetagaSeries, b : OptmetagaSeries) -> OptmetagaSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn opt_meta_ga_series_normalize(s : OptmetagaSeries) -> OptmetagaSeries {
  let mn = opt_meta_ga_series_min(s)
  let mx = opt_meta_ga_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn opt_meta_ga_series_cumsum(s : OptmetagaSeries) -> OptmetagaSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn opt_meta_ga_series_to_string(s : OptmetagaSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct OptmetagaMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn opt_meta_ga_make_matrix(rows : Int, cols : Int, val : Double) -> OptmetagaMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn opt_meta_ga_matrix_identity(n : Int) -> OptmetagaMatrix {
  let m = opt_meta_ga_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn opt_meta_ga_matrix_get(m : OptmetagaMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn opt_meta_ga_matrix_transpose(m : OptmetagaMatrix) -> OptmetagaMatrix {
  let result = opt_meta_ga_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn opt_meta_ga_matrix_add(a : OptmetagaMatrix, b : OptmetagaMatrix) -> OptmetagaMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = opt_meta_ga_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn opt_meta_ga_matrix_scale(m : OptmetagaMatrix, s : Double) -> OptmetagaMatrix {
  let result = opt_meta_ga_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn opt_meta_ga_matrix_multiply(a : OptmetagaMatrix, b : OptmetagaMatrix) -> OptmetagaMatrix {
  if a.cols != b.rows { return opt_meta_ga_make_matrix(a.rows, b.cols, 0.0) }
  let result = opt_meta_ga_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn opt_meta_ga_matrix_trace(m : OptmetagaMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn opt_meta_ga_matrix_det(m : OptmetagaMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn opt_meta_ga_matrix_norm(m : OptmetagaMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn opt_meta_ga_matrix_to_string(m : OptmetagaMatrix) -> String {
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

pub(all) struct OptmetagaVector {
  comps : Array[Double]
  dim : Int
}

pub fn opt_meta_ga_make_vector(comps : Array[Double]) -> OptmetagaVector {
  { comps, dim: comps.length() }
}

pub fn opt_meta_ga_vector_zero(dim : Int) -> OptmetagaVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn opt_meta_ga_vector_add(a : OptmetagaVector, b : OptmetagaVector) -> OptmetagaVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn opt_meta_ga_vector_sub(a : OptmetagaVector, b : OptmetagaVector) -> OptmetagaVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn opt_meta_ga_vector_scale(v : OptmetagaVector, s : Double) -> OptmetagaVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn opt_meta_ga_vector_dot(a : OptmetagaVector, b : OptmetagaVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn opt_meta_ga_vector_norm(v : OptmetagaVector) -> Double { @_common.sqrt(opt_meta_ga_vector_dot(v, v)) }

pub fn opt_meta_ga_vector_normalize(v : OptmetagaVector) -> OptmetagaVector {
  let n = opt_meta_ga_vector_norm(v)
  if n < 0.0000001 { v } else { opt_meta_ga_vector_scale(v, 1.0 / n) }
}

pub fn opt_meta_ga_vector_dist(a : OptmetagaVector, b : OptmetagaVector) -> Double {
  opt_meta_ga_vector_norm(opt_meta_ga_vector_sub(a, b))
}

pub fn opt_meta_ga_vector_to_string(v : OptmetagaVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn opt_meta_ga_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn opt_meta_ga_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn opt_meta_ga_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn opt_meta_ga_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn opt_meta_ga_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn opt_meta_ga_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn opt_meta_ga_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn opt_meta_ga_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn opt_meta_ga_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn opt_meta_ga_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn opt_meta_ga_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn opt_meta_ga_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn opt_meta_ga_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn opt_meta_ga_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn opt_meta_ga_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn opt_meta_ga_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn opt_meta_ga_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn opt_meta_ga_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn opt_meta_ga_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn opt_meta_ga_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn opt_meta_ga_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn opt_meta_ga_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn opt_meta_ga_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn opt_meta_ga_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn opt_meta_ga_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn opt_meta_ga_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn opt_meta_ga_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn opt_meta_ga_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn opt_meta_ga_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct OptmetagaFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_ga_frame_make(size : Int) -> OptmetagaFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_ga_frame_len(s : OptmetagaFrame) -> Int { s.size }

pub fn opt_meta_ga_frame_get(s : OptmetagaFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_ga_frame_set(s : OptmetagaFrame, i : Int, v : Double) -> OptmetagaFrame {
  let result = opt_meta_ga_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_ga_frame_sum(s : OptmetagaFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_ga_frame_mean(s : OptmetagaFrame) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_ga_frame_sum(s) / s.size.to_double() }
}

pub fn opt_meta_ga_frame_scale(s : OptmetagaFrame, f : Double) -> OptmetagaFrame {
  let result = opt_meta_ga_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_ga_frame_add(a : OptmetagaFrame, b : OptmetagaFrame) -> OptmetagaFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_ga_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_ga_frame_copy(s : OptmetagaFrame) -> OptmetagaFrame {
  let result = opt_meta_ga_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_ga_frame_fill(s : OptmetagaFrame, v : Double) -> OptmetagaFrame {
  let result = opt_meta_ga_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_ga_frame_min(s : OptmetagaFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_ga_frame_max(s : OptmetagaFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_ga_frame_to_string(s : OptmetagaFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetagaTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_ga_table_make(size : Int) -> OptmetagaTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_ga_table_len(s : OptmetagaTable) -> Int { s.size }

pub fn opt_meta_ga_table_get(s : OptmetagaTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_ga_table_set(s : OptmetagaTable, i : Int, v : Double) -> OptmetagaTable {
  let result = opt_meta_ga_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_ga_table_sum(s : OptmetagaTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_ga_table_mean(s : OptmetagaTable) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_ga_table_sum(s) / s.size.to_double() }
}

pub fn opt_meta_ga_table_scale(s : OptmetagaTable, f : Double) -> OptmetagaTable {
  let result = opt_meta_ga_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_ga_table_add(a : OptmetagaTable, b : OptmetagaTable) -> OptmetagaTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_ga_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_ga_table_copy(s : OptmetagaTable) -> OptmetagaTable {
  let result = opt_meta_ga_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_ga_table_fill(s : OptmetagaTable, v : Double) -> OptmetagaTable {
  let result = opt_meta_ga_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_ga_table_min(s : OptmetagaTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_ga_table_max(s : OptmetagaTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_ga_table_to_string(s : OptmetagaTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetagaGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_ga_graphn_make(size : Int) -> OptmetagaGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_ga_graphn_len(s : OptmetagaGraphN) -> Int { s.size }

pub fn opt_meta_ga_graphn_get(s : OptmetagaGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_ga_graphn_set(s : OptmetagaGraphN, i : Int, v : Double) -> OptmetagaGraphN {
  let result = opt_meta_ga_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_ga_graphn_sum(s : OptmetagaGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_ga_graphn_mean(s : OptmetagaGraphN) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_ga_graphn_sum(s) / s.size.to_double() }
}

pub fn opt_meta_ga_graphn_scale(s : OptmetagaGraphN, f : Double) -> OptmetagaGraphN {
  let result = opt_meta_ga_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_ga_graphn_add(a : OptmetagaGraphN, b : OptmetagaGraphN) -> OptmetagaGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_ga_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_ga_graphn_copy(s : OptmetagaGraphN) -> OptmetagaGraphN {
  let result = opt_meta_ga_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_ga_graphn_fill(s : OptmetagaGraphN, v : Double) -> OptmetagaGraphN {
  let result = opt_meta_ga_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_ga_graphn_min(s : OptmetagaGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_ga_graphn_max(s : OptmetagaGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_ga_graphn_to_string(s : OptmetagaGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetagaNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_ga_node_make(size : Int) -> OptmetagaNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_ga_node_len(s : OptmetagaNode) -> Int { s.size }

pub fn opt_meta_ga_node_get(s : OptmetagaNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_ga_node_set(s : OptmetagaNode, i : Int, v : Double) -> OptmetagaNode {
  let result = opt_meta_ga_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_ga_node_sum(s : OptmetagaNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_ga_node_mean(s : OptmetagaNode) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_ga_node_sum(s) / s.size.to_double() }
}

pub fn opt_meta_ga_node_scale(s : OptmetagaNode, f : Double) -> OptmetagaNode {
  let result = opt_meta_ga_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_ga_node_add(a : OptmetagaNode, b : OptmetagaNode) -> OptmetagaNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_ga_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_ga_node_copy(s : OptmetagaNode) -> OptmetagaNode {
  let result = opt_meta_ga_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_ga_node_fill(s : OptmetagaNode, v : Double) -> OptmetagaNode {
  let result = opt_meta_ga_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_ga_node_min(s : OptmetagaNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_ga_node_max(s : OptmetagaNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_ga_node_to_string(s : OptmetagaNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetagaEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_ga_edge_make(size : Int) -> OptmetagaEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_ga_edge_len(s : OptmetagaEdge) -> Int { s.size }

pub fn opt_meta_ga_edge_get(s : OptmetagaEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_ga_edge_set(s : OptmetagaEdge, i : Int, v : Double) -> OptmetagaEdge {
  let result = opt_meta_ga_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_ga_edge_sum(s : OptmetagaEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_ga_edge_mean(s : OptmetagaEdge) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_ga_edge_sum(s) / s.size.to_double() }
}

pub fn opt_meta_ga_edge_scale(s : OptmetagaEdge, f : Double) -> OptmetagaEdge {
  let result = opt_meta_ga_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_ga_edge_add(a : OptmetagaEdge, b : OptmetagaEdge) -> OptmetagaEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_ga_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_ga_edge_copy(s : OptmetagaEdge) -> OptmetagaEdge {
  let result = opt_meta_ga_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_ga_edge_fill(s : OptmetagaEdge, v : Double) -> OptmetagaEdge {
  let result = opt_meta_ga_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_ga_edge_min(s : OptmetagaEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_ga_edge_max(s : OptmetagaEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_ga_edge_to_string(s : OptmetagaEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetagaPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_ga_path_make(size : Int) -> OptmetagaPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_ga_path_len(s : OptmetagaPath) -> Int { s.size }

pub fn opt_meta_ga_path_get(s : OptmetagaPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_ga_path_set(s : OptmetagaPath, i : Int, v : Double) -> OptmetagaPath {
  let result = opt_meta_ga_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_ga_path_sum(s : OptmetagaPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_ga_path_mean(s : OptmetagaPath) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_ga_path_sum(s) / s.size.to_double() }
}

pub fn opt_meta_ga_path_scale(s : OptmetagaPath, f : Double) -> OptmetagaPath {
  let result = opt_meta_ga_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_ga_path_add(a : OptmetagaPath, b : OptmetagaPath) -> OptmetagaPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_ga_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_ga_path_copy(s : OptmetagaPath) -> OptmetagaPath {
  let result = opt_meta_ga_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_ga_path_fill(s : OptmetagaPath, v : Double) -> OptmetagaPath {
  let result = opt_meta_ga_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_ga_path_min(s : OptmetagaPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_ga_path_max(s : OptmetagaPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_ga_path_to_string(s : OptmetagaPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetagaCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_ga_cluster_make(size : Int) -> OptmetagaCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_ga_cluster_len(s : OptmetagaCluster) -> Int { s.size }

pub fn opt_meta_ga_cluster_get(s : OptmetagaCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_ga_cluster_set(s : OptmetagaCluster, i : Int, v : Double) -> OptmetagaCluster {
  let result = opt_meta_ga_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_ga_cluster_sum(s : OptmetagaCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_ga_cluster_mean(s : OptmetagaCluster) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_ga_cluster_sum(s) / s.size.to_double() }
}

pub fn opt_meta_ga_cluster_scale(s : OptmetagaCluster, f : Double) -> OptmetagaCluster {
  let result = opt_meta_ga_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_ga_cluster_add(a : OptmetagaCluster, b : OptmetagaCluster) -> OptmetagaCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_ga_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_ga_cluster_copy(s : OptmetagaCluster) -> OptmetagaCluster {
  let result = opt_meta_ga_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_ga_cluster_fill(s : OptmetagaCluster, v : Double) -> OptmetagaCluster {
  let result = opt_meta_ga_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_ga_cluster_min(s : OptmetagaCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_ga_cluster_max(s : OptmetagaCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_ga_cluster_to_string(s : OptmetagaCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetagaModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_ga_model_make(size : Int) -> OptmetagaModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_ga_model_len(s : OptmetagaModel) -> Int { s.size }

pub fn opt_meta_ga_model_get(s : OptmetagaModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_ga_model_set(s : OptmetagaModel, i : Int, v : Double) -> OptmetagaModel {
  let result = opt_meta_ga_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_ga_model_sum(s : OptmetagaModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_ga_model_mean(s : OptmetagaModel) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_ga_model_sum(s) / s.size.to_double() }
}

pub fn opt_meta_ga_model_scale(s : OptmetagaModel, f : Double) -> OptmetagaModel {
  let result = opt_meta_ga_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_ga_model_add(a : OptmetagaModel, b : OptmetagaModel) -> OptmetagaModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_ga_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_ga_model_copy(s : OptmetagaModel) -> OptmetagaModel {
  let result = opt_meta_ga_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_ga_model_fill(s : OptmetagaModel, v : Double) -> OptmetagaModel {
  let result = opt_meta_ga_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_ga_model_min(s : OptmetagaModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_ga_model_max(s : OptmetagaModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_ga_model_to_string(s : OptmetagaModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetagaLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_ga_layer_make(size : Int) -> OptmetagaLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_ga_layer_len(s : OptmetagaLayer) -> Int { s.size }

pub fn opt_meta_ga_layer_get(s : OptmetagaLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_ga_layer_set(s : OptmetagaLayer, i : Int, v : Double) -> OptmetagaLayer {
  let result = opt_meta_ga_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_ga_layer_sum(s : OptmetagaLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_ga_layer_mean(s : OptmetagaLayer) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_ga_layer_sum(s) / s.size.to_double() }
}

pub fn opt_meta_ga_layer_scale(s : OptmetagaLayer, f : Double) -> OptmetagaLayer {
  let result = opt_meta_ga_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_ga_layer_add(a : OptmetagaLayer, b : OptmetagaLayer) -> OptmetagaLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_ga_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_ga_layer_copy(s : OptmetagaLayer) -> OptmetagaLayer {
  let result = opt_meta_ga_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_ga_layer_fill(s : OptmetagaLayer, v : Double) -> OptmetagaLayer {
  let result = opt_meta_ga_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_ga_layer_min(s : OptmetagaLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_ga_layer_max(s : OptmetagaLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_ga_layer_to_string(s : OptmetagaLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetagaBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_ga_buffer_make(size : Int) -> OptmetagaBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_ga_buffer_len(s : OptmetagaBuffer) -> Int { s.size }

pub fn opt_meta_ga_buffer_get(s : OptmetagaBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_ga_buffer_set(s : OptmetagaBuffer, i : Int, v : Double) -> OptmetagaBuffer {
  let result = opt_meta_ga_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_ga_buffer_sum(s : OptmetagaBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_ga_buffer_mean(s : OptmetagaBuffer) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_ga_buffer_sum(s) / s.size.to_double() }
}

pub fn opt_meta_ga_buffer_scale(s : OptmetagaBuffer, f : Double) -> OptmetagaBuffer {
  let result = opt_meta_ga_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_ga_buffer_add(a : OptmetagaBuffer, b : OptmetagaBuffer) -> OptmetagaBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_ga_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_ga_buffer_copy(s : OptmetagaBuffer) -> OptmetagaBuffer {
  let result = opt_meta_ga_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_ga_buffer_fill(s : OptmetagaBuffer, v : Double) -> OptmetagaBuffer {
  let result = opt_meta_ga_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_ga_buffer_min(s : OptmetagaBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_ga_buffer_max(s : OptmetagaBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_ga_buffer_to_string(s : OptmetagaBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetagaCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_ga_cursor_make(size : Int) -> OptmetagaCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_ga_cursor_len(s : OptmetagaCursor) -> Int { s.size }

pub fn opt_meta_ga_cursor_get(s : OptmetagaCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_ga_cursor_set(s : OptmetagaCursor, i : Int, v : Double) -> OptmetagaCursor {
  let result = opt_meta_ga_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_ga_cursor_sum(s : OptmetagaCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_ga_cursor_mean(s : OptmetagaCursor) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_ga_cursor_sum(s) / s.size.to_double() }
}

pub fn opt_meta_ga_cursor_scale(s : OptmetagaCursor, f : Double) -> OptmetagaCursor {
  let result = opt_meta_ga_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_ga_cursor_add(a : OptmetagaCursor, b : OptmetagaCursor) -> OptmetagaCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_ga_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_ga_cursor_copy(s : OptmetagaCursor) -> OptmetagaCursor {
  let result = opt_meta_ga_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_ga_cursor_fill(s : OptmetagaCursor, v : Double) -> OptmetagaCursor {
  let result = opt_meta_ga_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_ga_cursor_min(s : OptmetagaCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_ga_cursor_max(s : OptmetagaCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_ga_cursor_to_string(s : OptmetagaCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetagaView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_ga_view_make(size : Int) -> OptmetagaView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_ga_view_len(s : OptmetagaView) -> Int { s.size }

pub fn opt_meta_ga_view_get(s : OptmetagaView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_ga_view_set(s : OptmetagaView, i : Int, v : Double) -> OptmetagaView {
  let result = opt_meta_ga_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_ga_view_sum(s : OptmetagaView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_ga_view_mean(s : OptmetagaView) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_ga_view_sum(s) / s.size.to_double() }
}

pub fn opt_meta_ga_view_scale(s : OptmetagaView, f : Double) -> OptmetagaView {
  let result = opt_meta_ga_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_ga_view_add(a : OptmetagaView, b : OptmetagaView) -> OptmetagaView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_ga_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_ga_view_copy(s : OptmetagaView) -> OptmetagaView {
  let result = opt_meta_ga_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_ga_view_fill(s : OptmetagaView, v : Double) -> OptmetagaView {
  let result = opt_meta_ga_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_ga_view_min(s : OptmetagaView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_ga_view_max(s : OptmetagaView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_ga_view_to_string(s : OptmetagaView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetagaRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_ga_range_make(size : Int) -> OptmetagaRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_ga_range_len(s : OptmetagaRange) -> Int { s.size }

pub fn opt_meta_ga_range_get(s : OptmetagaRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_ga_range_set(s : OptmetagaRange, i : Int, v : Double) -> OptmetagaRange {
  let result = opt_meta_ga_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_ga_range_sum(s : OptmetagaRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_ga_range_mean(s : OptmetagaRange) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_ga_range_sum(s) / s.size.to_double() }
}

pub fn opt_meta_ga_range_scale(s : OptmetagaRange, f : Double) -> OptmetagaRange {
  let result = opt_meta_ga_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_ga_range_add(a : OptmetagaRange, b : OptmetagaRange) -> OptmetagaRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_ga_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_ga_range_copy(s : OptmetagaRange) -> OptmetagaRange {
  let result = opt_meta_ga_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_ga_range_fill(s : OptmetagaRange, v : Double) -> OptmetagaRange {
  let result = opt_meta_ga_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_ga_range_min(s : OptmetagaRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_ga_range_max(s : OptmetagaRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_ga_range_to_string(s : OptmetagaRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetagaSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_ga_slice_make(size : Int) -> OptmetagaSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_ga_slice_len(s : OptmetagaSlice) -> Int { s.size }

pub fn opt_meta_ga_slice_get(s : OptmetagaSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_ga_slice_set(s : OptmetagaSlice, i : Int, v : Double) -> OptmetagaSlice {
  let result = opt_meta_ga_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_ga_slice_sum(s : OptmetagaSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_ga_slice_mean(s : OptmetagaSlice) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_ga_slice_sum(s) / s.size.to_double() }
}

pub fn opt_meta_ga_slice_scale(s : OptmetagaSlice, f : Double) -> OptmetagaSlice {
  let result = opt_meta_ga_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_ga_slice_add(a : OptmetagaSlice, b : OptmetagaSlice) -> OptmetagaSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_ga_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_ga_slice_copy(s : OptmetagaSlice) -> OptmetagaSlice {
  let result = opt_meta_ga_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_ga_slice_fill(s : OptmetagaSlice, v : Double) -> OptmetagaSlice {
  let result = opt_meta_ga_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_ga_slice_min(s : OptmetagaSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_ga_slice_max(s : OptmetagaSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_ga_slice_to_string(s : OptmetagaSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


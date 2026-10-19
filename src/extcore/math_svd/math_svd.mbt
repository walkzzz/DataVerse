///===
/// extcore/math_svd

pub(all) struct MathsvdPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_svd_make_point(x : Double, y : Double) -> MathsvdPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_svd_make_point3(x : Double, y : Double, z : Double) -> MathsvdPoint {
  { x, y, z, label: 0 }
}

pub fn math_svd_point_x(pt : MathsvdPoint) -> Double { pt.x }

pub fn math_svd_point_y(pt : MathsvdPoint) -> Double { pt.y }

pub fn math_svd_point_z(pt : MathsvdPoint) -> Double { pt.z }

pub fn math_svd_point_label(pt : MathsvdPoint) -> Int { pt.label }

pub fn math_svd_point_dist(a : MathsvdPoint, b : MathsvdPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn math_svd_point_add(a : MathsvdPoint, b : MathsvdPoint) -> MathsvdPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn math_svd_point_sub(a : MathsvdPoint, b : MathsvdPoint) -> MathsvdPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn math_svd_point_scale(pt : MathsvdPoint, s : Double) -> MathsvdPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn math_svd_point_dot(a : MathsvdPoint, b : MathsvdPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn math_svd_point_cross(a : MathsvdPoint, b : MathsvdPoint) -> MathsvdPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn math_svd_point_norm(pt : MathsvdPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn math_svd_point_normalize(pt : MathsvdPoint) -> MathsvdPoint {
  let n = math_svd_point_norm(pt)
  if n < 0.0000001 { pt } else { math_svd_point_scale(pt, 1.0 / n) }
}

pub fn math_svd_point_negate(pt : MathsvdPoint) -> MathsvdPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn math_svd_point_mid(a : MathsvdPoint, b : MathsvdPoint) -> MathsvdPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn math_svd_point_lerp(a : MathsvdPoint, b : MathsvdPoint, t : Double) -> MathsvdPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn math_svd_point_to_string(pt : MathsvdPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MathsvdSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_svd_make_series(vals : Array[Double], name : String) -> MathsvdSeries {
  { vals, name, meta: 0 }
}

pub fn math_svd_series_len(s : MathsvdSeries) -> Int { s.vals.length() }

pub fn math_svd_series_sum(s : MathsvdSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn math_svd_series_mean(s : MathsvdSeries) -> Double {
  let n = math_svd_series_len(s)
  if n == 0 { 0.0 } else { math_svd_series_sum(s) / n.to_double() }
}

pub fn math_svd_series_min(s : MathsvdSeries) -> Double {
  let n = math_svd_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn math_svd_series_max(s : MathsvdSeries) -> Double {
  let n = math_svd_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn math_svd_series_range(s : MathsvdSeries) -> Double {
  math_svd_series_max(s) - math_svd_series_min(s)
}

pub fn math_svd_series_var(s : MathsvdSeries) -> Double {
  let n = math_svd_series_len(s)
  if n == 0 { 0.0 } else {
    let m = math_svd_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn math_svd_series_std(s : MathsvdSeries) -> Double { @_common.sqrt(math_svd_series_var(s)) }

pub fn math_svd_series_median(s : MathsvdSeries) -> Double {
  let n = math_svd_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = math_svd_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn math_svd_series_scale(s : MathsvdSeries, f : Double) -> MathsvdSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn math_svd_series_add(a : MathsvdSeries, b : MathsvdSeries) -> MathsvdSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn math_svd_series_sub(a : MathsvdSeries, b : MathsvdSeries) -> MathsvdSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn math_svd_series_normalize(s : MathsvdSeries) -> MathsvdSeries {
  let mn = math_svd_series_min(s)
  let mx = math_svd_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn math_svd_series_cumsum(s : MathsvdSeries) -> MathsvdSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn math_svd_series_to_string(s : MathsvdSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathsvdMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_svd_make_matrix(rows : Int, cols : Int, val : Double) -> MathsvdMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_svd_matrix_identity(n : Int) -> MathsvdMatrix {
  let m = math_svd_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn math_svd_matrix_get(m : MathsvdMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn math_svd_matrix_transpose(m : MathsvdMatrix) -> MathsvdMatrix {
  let result = math_svd_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn math_svd_matrix_add(a : MathsvdMatrix, b : MathsvdMatrix) -> MathsvdMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = math_svd_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn math_svd_matrix_scale(m : MathsvdMatrix, s : Double) -> MathsvdMatrix {
  let result = math_svd_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn math_svd_matrix_multiply(a : MathsvdMatrix, b : MathsvdMatrix) -> MathsvdMatrix {
  if a.cols != b.rows { return math_svd_make_matrix(a.rows, b.cols, 0.0) }
  let result = math_svd_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn math_svd_matrix_trace(m : MathsvdMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn math_svd_matrix_det(m : MathsvdMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn math_svd_matrix_norm(m : MathsvdMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn math_svd_matrix_to_string(m : MathsvdMatrix) -> String {
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

pub(all) struct MathsvdVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_svd_make_vector(comps : Array[Double]) -> MathsvdVector {
  { comps, dim: comps.length() }
}

pub fn math_svd_vector_zero(dim : Int) -> MathsvdVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn math_svd_vector_add(a : MathsvdVector, b : MathsvdVector) -> MathsvdVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn math_svd_vector_sub(a : MathsvdVector, b : MathsvdVector) -> MathsvdVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn math_svd_vector_scale(v : MathsvdVector, s : Double) -> MathsvdVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn math_svd_vector_dot(a : MathsvdVector, b : MathsvdVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn math_svd_vector_norm(v : MathsvdVector) -> Double { @_common.sqrt(math_svd_vector_dot(v, v)) }

pub fn math_svd_vector_normalize(v : MathsvdVector) -> MathsvdVector {
  let n = math_svd_vector_norm(v)
  if n < 0.0000001 { v } else { math_svd_vector_scale(v, 1.0 / n) }
}

pub fn math_svd_vector_dist(a : MathsvdVector, b : MathsvdVector) -> Double {
  math_svd_vector_norm(math_svd_vector_sub(a, b))
}

pub fn math_svd_vector_to_string(v : MathsvdVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_svd_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn math_svd_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn math_svd_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn math_svd_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn math_svd_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn math_svd_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn math_svd_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn math_svd_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn math_svd_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn math_svd_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn math_svd_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn math_svd_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn math_svd_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn math_svd_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn math_svd_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn math_svd_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn math_svd_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn math_svd_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn math_svd_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn math_svd_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn math_svd_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn math_svd_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn math_svd_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn math_svd_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn math_svd_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn math_svd_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn math_svd_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn math_svd_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn math_svd_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MathsvdFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_svd_frame_make(size : Int) -> MathsvdFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_svd_frame_len(s : MathsvdFrame) -> Int { s.size }

pub fn math_svd_frame_get(s : MathsvdFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_svd_frame_set(s : MathsvdFrame, i : Int, v : Double) -> MathsvdFrame {
  let result = math_svd_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_svd_frame_sum(s : MathsvdFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_svd_frame_mean(s : MathsvdFrame) -> Double {
  if s.size == 0 { 0.0 } else { math_svd_frame_sum(s) / s.size.to_double() }
}

pub fn math_svd_frame_scale(s : MathsvdFrame, f : Double) -> MathsvdFrame {
  let result = math_svd_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_svd_frame_add(a : MathsvdFrame, b : MathsvdFrame) -> MathsvdFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_svd_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_svd_frame_copy(s : MathsvdFrame) -> MathsvdFrame {
  let result = math_svd_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_svd_frame_fill(s : MathsvdFrame, v : Double) -> MathsvdFrame {
  let result = math_svd_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_svd_frame_min(s : MathsvdFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_svd_frame_max(s : MathsvdFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_svd_frame_to_string(s : MathsvdFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathsvdTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_svd_table_make(size : Int) -> MathsvdTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_svd_table_len(s : MathsvdTable) -> Int { s.size }

pub fn math_svd_table_get(s : MathsvdTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_svd_table_set(s : MathsvdTable, i : Int, v : Double) -> MathsvdTable {
  let result = math_svd_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_svd_table_sum(s : MathsvdTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_svd_table_mean(s : MathsvdTable) -> Double {
  if s.size == 0 { 0.0 } else { math_svd_table_sum(s) / s.size.to_double() }
}

pub fn math_svd_table_scale(s : MathsvdTable, f : Double) -> MathsvdTable {
  let result = math_svd_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_svd_table_add(a : MathsvdTable, b : MathsvdTable) -> MathsvdTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_svd_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_svd_table_copy(s : MathsvdTable) -> MathsvdTable {
  let result = math_svd_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_svd_table_fill(s : MathsvdTable, v : Double) -> MathsvdTable {
  let result = math_svd_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_svd_table_min(s : MathsvdTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_svd_table_max(s : MathsvdTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_svd_table_to_string(s : MathsvdTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathsvdGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_svd_graphn_make(size : Int) -> MathsvdGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_svd_graphn_len(s : MathsvdGraphN) -> Int { s.size }

pub fn math_svd_graphn_get(s : MathsvdGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_svd_graphn_set(s : MathsvdGraphN, i : Int, v : Double) -> MathsvdGraphN {
  let result = math_svd_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_svd_graphn_sum(s : MathsvdGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_svd_graphn_mean(s : MathsvdGraphN) -> Double {
  if s.size == 0 { 0.0 } else { math_svd_graphn_sum(s) / s.size.to_double() }
}

pub fn math_svd_graphn_scale(s : MathsvdGraphN, f : Double) -> MathsvdGraphN {
  let result = math_svd_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_svd_graphn_add(a : MathsvdGraphN, b : MathsvdGraphN) -> MathsvdGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_svd_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_svd_graphn_copy(s : MathsvdGraphN) -> MathsvdGraphN {
  let result = math_svd_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_svd_graphn_fill(s : MathsvdGraphN, v : Double) -> MathsvdGraphN {
  let result = math_svd_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_svd_graphn_min(s : MathsvdGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_svd_graphn_max(s : MathsvdGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_svd_graphn_to_string(s : MathsvdGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathsvdNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_svd_node_make(size : Int) -> MathsvdNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_svd_node_len(s : MathsvdNode) -> Int { s.size }

pub fn math_svd_node_get(s : MathsvdNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_svd_node_set(s : MathsvdNode, i : Int, v : Double) -> MathsvdNode {
  let result = math_svd_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_svd_node_sum(s : MathsvdNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_svd_node_mean(s : MathsvdNode) -> Double {
  if s.size == 0 { 0.0 } else { math_svd_node_sum(s) / s.size.to_double() }
}

pub fn math_svd_node_scale(s : MathsvdNode, f : Double) -> MathsvdNode {
  let result = math_svd_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_svd_node_add(a : MathsvdNode, b : MathsvdNode) -> MathsvdNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_svd_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_svd_node_copy(s : MathsvdNode) -> MathsvdNode {
  let result = math_svd_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_svd_node_fill(s : MathsvdNode, v : Double) -> MathsvdNode {
  let result = math_svd_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_svd_node_min(s : MathsvdNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_svd_node_max(s : MathsvdNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_svd_node_to_string(s : MathsvdNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathsvdEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_svd_edge_make(size : Int) -> MathsvdEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_svd_edge_len(s : MathsvdEdge) -> Int { s.size }

pub fn math_svd_edge_get(s : MathsvdEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_svd_edge_set(s : MathsvdEdge, i : Int, v : Double) -> MathsvdEdge {
  let result = math_svd_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_svd_edge_sum(s : MathsvdEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_svd_edge_mean(s : MathsvdEdge) -> Double {
  if s.size == 0 { 0.0 } else { math_svd_edge_sum(s) / s.size.to_double() }
}

pub fn math_svd_edge_scale(s : MathsvdEdge, f : Double) -> MathsvdEdge {
  let result = math_svd_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_svd_edge_add(a : MathsvdEdge, b : MathsvdEdge) -> MathsvdEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_svd_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_svd_edge_copy(s : MathsvdEdge) -> MathsvdEdge {
  let result = math_svd_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_svd_edge_fill(s : MathsvdEdge, v : Double) -> MathsvdEdge {
  let result = math_svd_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_svd_edge_min(s : MathsvdEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_svd_edge_max(s : MathsvdEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_svd_edge_to_string(s : MathsvdEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathsvdPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_svd_path_make(size : Int) -> MathsvdPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_svd_path_len(s : MathsvdPath) -> Int { s.size }

pub fn math_svd_path_get(s : MathsvdPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_svd_path_set(s : MathsvdPath, i : Int, v : Double) -> MathsvdPath {
  let result = math_svd_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_svd_path_sum(s : MathsvdPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_svd_path_mean(s : MathsvdPath) -> Double {
  if s.size == 0 { 0.0 } else { math_svd_path_sum(s) / s.size.to_double() }
}

pub fn math_svd_path_scale(s : MathsvdPath, f : Double) -> MathsvdPath {
  let result = math_svd_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_svd_path_add(a : MathsvdPath, b : MathsvdPath) -> MathsvdPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_svd_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_svd_path_copy(s : MathsvdPath) -> MathsvdPath {
  let result = math_svd_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_svd_path_fill(s : MathsvdPath, v : Double) -> MathsvdPath {
  let result = math_svd_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_svd_path_min(s : MathsvdPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_svd_path_max(s : MathsvdPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_svd_path_to_string(s : MathsvdPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathsvdCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_svd_cluster_make(size : Int) -> MathsvdCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_svd_cluster_len(s : MathsvdCluster) -> Int { s.size }

pub fn math_svd_cluster_get(s : MathsvdCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_svd_cluster_set(s : MathsvdCluster, i : Int, v : Double) -> MathsvdCluster {
  let result = math_svd_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_svd_cluster_sum(s : MathsvdCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_svd_cluster_mean(s : MathsvdCluster) -> Double {
  if s.size == 0 { 0.0 } else { math_svd_cluster_sum(s) / s.size.to_double() }
}

pub fn math_svd_cluster_scale(s : MathsvdCluster, f : Double) -> MathsvdCluster {
  let result = math_svd_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_svd_cluster_add(a : MathsvdCluster, b : MathsvdCluster) -> MathsvdCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_svd_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_svd_cluster_copy(s : MathsvdCluster) -> MathsvdCluster {
  let result = math_svd_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_svd_cluster_fill(s : MathsvdCluster, v : Double) -> MathsvdCluster {
  let result = math_svd_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_svd_cluster_min(s : MathsvdCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_svd_cluster_max(s : MathsvdCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_svd_cluster_to_string(s : MathsvdCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathsvdModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_svd_model_make(size : Int) -> MathsvdModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_svd_model_len(s : MathsvdModel) -> Int { s.size }

pub fn math_svd_model_get(s : MathsvdModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_svd_model_set(s : MathsvdModel, i : Int, v : Double) -> MathsvdModel {
  let result = math_svd_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_svd_model_sum(s : MathsvdModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_svd_model_mean(s : MathsvdModel) -> Double {
  if s.size == 0 { 0.0 } else { math_svd_model_sum(s) / s.size.to_double() }
}

pub fn math_svd_model_scale(s : MathsvdModel, f : Double) -> MathsvdModel {
  let result = math_svd_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_svd_model_add(a : MathsvdModel, b : MathsvdModel) -> MathsvdModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_svd_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_svd_model_copy(s : MathsvdModel) -> MathsvdModel {
  let result = math_svd_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_svd_model_fill(s : MathsvdModel, v : Double) -> MathsvdModel {
  let result = math_svd_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_svd_model_min(s : MathsvdModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_svd_model_max(s : MathsvdModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_svd_model_to_string(s : MathsvdModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathsvdLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_svd_layer_make(size : Int) -> MathsvdLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_svd_layer_len(s : MathsvdLayer) -> Int { s.size }

pub fn math_svd_layer_get(s : MathsvdLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_svd_layer_set(s : MathsvdLayer, i : Int, v : Double) -> MathsvdLayer {
  let result = math_svd_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_svd_layer_sum(s : MathsvdLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_svd_layer_mean(s : MathsvdLayer) -> Double {
  if s.size == 0 { 0.0 } else { math_svd_layer_sum(s) / s.size.to_double() }
}

pub fn math_svd_layer_scale(s : MathsvdLayer, f : Double) -> MathsvdLayer {
  let result = math_svd_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_svd_layer_add(a : MathsvdLayer, b : MathsvdLayer) -> MathsvdLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_svd_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_svd_layer_copy(s : MathsvdLayer) -> MathsvdLayer {
  let result = math_svd_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_svd_layer_fill(s : MathsvdLayer, v : Double) -> MathsvdLayer {
  let result = math_svd_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_svd_layer_min(s : MathsvdLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_svd_layer_max(s : MathsvdLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_svd_layer_to_string(s : MathsvdLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathsvdBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_svd_buffer_make(size : Int) -> MathsvdBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_svd_buffer_len(s : MathsvdBuffer) -> Int { s.size }

pub fn math_svd_buffer_get(s : MathsvdBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_svd_buffer_set(s : MathsvdBuffer, i : Int, v : Double) -> MathsvdBuffer {
  let result = math_svd_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_svd_buffer_sum(s : MathsvdBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_svd_buffer_mean(s : MathsvdBuffer) -> Double {
  if s.size == 0 { 0.0 } else { math_svd_buffer_sum(s) / s.size.to_double() }
}

pub fn math_svd_buffer_scale(s : MathsvdBuffer, f : Double) -> MathsvdBuffer {
  let result = math_svd_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_svd_buffer_add(a : MathsvdBuffer, b : MathsvdBuffer) -> MathsvdBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_svd_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_svd_buffer_copy(s : MathsvdBuffer) -> MathsvdBuffer {
  let result = math_svd_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_svd_buffer_fill(s : MathsvdBuffer, v : Double) -> MathsvdBuffer {
  let result = math_svd_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_svd_buffer_min(s : MathsvdBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_svd_buffer_max(s : MathsvdBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_svd_buffer_to_string(s : MathsvdBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathsvdCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_svd_cursor_make(size : Int) -> MathsvdCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_svd_cursor_len(s : MathsvdCursor) -> Int { s.size }

pub fn math_svd_cursor_get(s : MathsvdCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_svd_cursor_set(s : MathsvdCursor, i : Int, v : Double) -> MathsvdCursor {
  let result = math_svd_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_svd_cursor_sum(s : MathsvdCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_svd_cursor_mean(s : MathsvdCursor) -> Double {
  if s.size == 0 { 0.0 } else { math_svd_cursor_sum(s) / s.size.to_double() }
}

pub fn math_svd_cursor_scale(s : MathsvdCursor, f : Double) -> MathsvdCursor {
  let result = math_svd_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_svd_cursor_add(a : MathsvdCursor, b : MathsvdCursor) -> MathsvdCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_svd_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_svd_cursor_copy(s : MathsvdCursor) -> MathsvdCursor {
  let result = math_svd_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_svd_cursor_fill(s : MathsvdCursor, v : Double) -> MathsvdCursor {
  let result = math_svd_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_svd_cursor_min(s : MathsvdCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_svd_cursor_max(s : MathsvdCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_svd_cursor_to_string(s : MathsvdCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathsvdView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_svd_view_make(size : Int) -> MathsvdView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_svd_view_len(s : MathsvdView) -> Int { s.size }

pub fn math_svd_view_get(s : MathsvdView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_svd_view_set(s : MathsvdView, i : Int, v : Double) -> MathsvdView {
  let result = math_svd_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_svd_view_sum(s : MathsvdView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_svd_view_mean(s : MathsvdView) -> Double {
  if s.size == 0 { 0.0 } else { math_svd_view_sum(s) / s.size.to_double() }
}

pub fn math_svd_view_scale(s : MathsvdView, f : Double) -> MathsvdView {
  let result = math_svd_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_svd_view_add(a : MathsvdView, b : MathsvdView) -> MathsvdView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_svd_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_svd_view_copy(s : MathsvdView) -> MathsvdView {
  let result = math_svd_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_svd_view_fill(s : MathsvdView, v : Double) -> MathsvdView {
  let result = math_svd_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_svd_view_min(s : MathsvdView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_svd_view_max(s : MathsvdView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_svd_view_to_string(s : MathsvdView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathsvdRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_svd_range_make(size : Int) -> MathsvdRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_svd_range_len(s : MathsvdRange) -> Int { s.size }

pub fn math_svd_range_get(s : MathsvdRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_svd_range_set(s : MathsvdRange, i : Int, v : Double) -> MathsvdRange {
  let result = math_svd_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_svd_range_sum(s : MathsvdRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_svd_range_mean(s : MathsvdRange) -> Double {
  if s.size == 0 { 0.0 } else { math_svd_range_sum(s) / s.size.to_double() }
}

pub fn math_svd_range_scale(s : MathsvdRange, f : Double) -> MathsvdRange {
  let result = math_svd_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_svd_range_add(a : MathsvdRange, b : MathsvdRange) -> MathsvdRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_svd_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_svd_range_copy(s : MathsvdRange) -> MathsvdRange {
  let result = math_svd_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_svd_range_fill(s : MathsvdRange, v : Double) -> MathsvdRange {
  let result = math_svd_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_svd_range_min(s : MathsvdRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_svd_range_max(s : MathsvdRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_svd_range_to_string(s : MathsvdRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathsvdSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_svd_slice_make(size : Int) -> MathsvdSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_svd_slice_len(s : MathsvdSlice) -> Int { s.size }

pub fn math_svd_slice_get(s : MathsvdSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_svd_slice_set(s : MathsvdSlice, i : Int, v : Double) -> MathsvdSlice {
  let result = math_svd_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_svd_slice_sum(s : MathsvdSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_svd_slice_mean(s : MathsvdSlice) -> Double {
  if s.size == 0 { 0.0 } else { math_svd_slice_sum(s) / s.size.to_double() }
}

pub fn math_svd_slice_scale(s : MathsvdSlice, f : Double) -> MathsvdSlice {
  let result = math_svd_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_svd_slice_add(a : MathsvdSlice, b : MathsvdSlice) -> MathsvdSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_svd_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_svd_slice_copy(s : MathsvdSlice) -> MathsvdSlice {
  let result = math_svd_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_svd_slice_fill(s : MathsvdSlice, v : Double) -> MathsvdSlice {
  let result = math_svd_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_svd_slice_min(s : MathsvdSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_svd_slice_max(s : MathsvdSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_svd_slice_to_string(s : MathsvdSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


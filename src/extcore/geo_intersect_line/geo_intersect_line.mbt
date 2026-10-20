///===
/// extcore/geo_intersect_line

pub(all) struct GeointersectlinePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_intersect_line_make_point(x : Double, y : Double) -> GeointersectlinePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_intersect_line_make_point3(x : Double, y : Double, z : Double) -> GeointersectlinePoint {
  { x, y, z, label: 0 }
}

pub fn geo_intersect_line_point_x(pt : GeointersectlinePoint) -> Double { pt.x }

pub fn geo_intersect_line_point_y(pt : GeointersectlinePoint) -> Double { pt.y }

pub fn geo_intersect_line_point_z(pt : GeointersectlinePoint) -> Double { pt.z }

pub fn geo_intersect_line_point_label(pt : GeointersectlinePoint) -> Int { pt.label }

pub fn geo_intersect_line_point_dist(a : GeointersectlinePoint, b : GeointersectlinePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn geo_intersect_line_point_add(a : GeointersectlinePoint, b : GeointersectlinePoint) -> GeointersectlinePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn geo_intersect_line_point_sub(a : GeointersectlinePoint, b : GeointersectlinePoint) -> GeointersectlinePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn geo_intersect_line_point_scale(pt : GeointersectlinePoint, s : Double) -> GeointersectlinePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn geo_intersect_line_point_dot(a : GeointersectlinePoint, b : GeointersectlinePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn geo_intersect_line_point_cross(a : GeointersectlinePoint, b : GeointersectlinePoint) -> GeointersectlinePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn geo_intersect_line_point_norm(pt : GeointersectlinePoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn geo_intersect_line_point_normalize(pt : GeointersectlinePoint) -> GeointersectlinePoint {
  let n = geo_intersect_line_point_norm(pt)
  if n < 0.0000001 { pt } else { geo_intersect_line_point_scale(pt, 1.0 / n) }
}

pub fn geo_intersect_line_point_negate(pt : GeointersectlinePoint) -> GeointersectlinePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn geo_intersect_line_point_mid(a : GeointersectlinePoint, b : GeointersectlinePoint) -> GeointersectlinePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn geo_intersect_line_point_lerp(a : GeointersectlinePoint, b : GeointersectlinePoint, t : Double) -> GeointersectlinePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn geo_intersect_line_point_to_string(pt : GeointersectlinePoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct GeointersectlineSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_intersect_line_make_series(vals : Array[Double], name : String) -> GeointersectlineSeries {
  { vals, name, meta: 0 }
}

pub fn geo_intersect_line_series_len(s : GeointersectlineSeries) -> Int { s.vals.length() }

pub fn geo_intersect_line_series_sum(s : GeointersectlineSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn geo_intersect_line_series_mean(s : GeointersectlineSeries) -> Double { @_common.mean(s.vals) }

pub fn geo_intersect_line_series_min(s : GeointersectlineSeries) -> Double { @_common.min(s.vals) }

pub fn geo_intersect_line_series_max(s : GeointersectlineSeries) -> Double { @_common.max(s.vals) }

pub fn geo_intersect_line_series_range(s : GeointersectlineSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn geo_intersect_line_series_var(s : GeointersectlineSeries) -> Double { @_common.variance(s.vals) }

pub fn geo_intersect_line_series_std(s : GeointersectlineSeries) -> Double { @_common.std(s.vals) }

pub fn geo_intersect_line_series_median(s : GeointersectlineSeries) -> Double { @_common.median(s.vals) }

pub fn geo_intersect_line_series_scale(s : GeointersectlineSeries, f : Double) -> GeointersectlineSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn geo_intersect_line_series_add(a : GeointersectlineSeries, b : GeointersectlineSeries) -> GeointersectlineSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn geo_intersect_line_series_sub(a : GeointersectlineSeries, b : GeointersectlineSeries) -> GeointersectlineSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn geo_intersect_line_series_normalize(s : GeointersectlineSeries) -> GeointersectlineSeries {
  let mn = geo_intersect_line_series_min(s)
  let mx = geo_intersect_line_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn geo_intersect_line_series_cumsum(s : GeointersectlineSeries) -> GeointersectlineSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn geo_intersect_line_series_to_string(s : GeointersectlineSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeointersectlineMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_intersect_line_make_matrix(rows : Int, cols : Int, val : Double) -> GeointersectlineMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn geo_intersect_line_matrix_identity(n : Int) -> GeointersectlineMatrix {
  let m = geo_intersect_line_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn geo_intersect_line_matrix_get(m : GeointersectlineMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn geo_intersect_line_matrix_transpose(m : GeointersectlineMatrix) -> GeointersectlineMatrix {
  let result = geo_intersect_line_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn geo_intersect_line_matrix_add(a : GeointersectlineMatrix, b : GeointersectlineMatrix) -> GeointersectlineMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = geo_intersect_line_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn geo_intersect_line_matrix_scale(m : GeointersectlineMatrix, s : Double) -> GeointersectlineMatrix {
  let result = geo_intersect_line_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn geo_intersect_line_matrix_multiply(a : GeointersectlineMatrix, b : GeointersectlineMatrix) -> GeointersectlineMatrix {
  if a.cols != b.rows { return geo_intersect_line_make_matrix(a.rows, b.cols, 0.0) }
  let result = geo_intersect_line_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn geo_intersect_line_matrix_trace(m : GeointersectlineMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn geo_intersect_line_matrix_det(m : GeointersectlineMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn geo_intersect_line_matrix_norm(m : GeointersectlineMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn geo_intersect_line_matrix_to_string(m : GeointersectlineMatrix) -> String {
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

pub(all) struct GeointersectlineVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_intersect_line_make_vector(comps : Array[Double]) -> GeointersectlineVector {
  { comps, dim: comps.length() }
}

pub fn geo_intersect_line_vector_zero(dim : Int) -> GeointersectlineVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn geo_intersect_line_vector_add(a : GeointersectlineVector, b : GeointersectlineVector) -> GeointersectlineVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn geo_intersect_line_vector_sub(a : GeointersectlineVector, b : GeointersectlineVector) -> GeointersectlineVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn geo_intersect_line_vector_scale(v : GeointersectlineVector, s : Double) -> GeointersectlineVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn geo_intersect_line_vector_dot(a : GeointersectlineVector, b : GeointersectlineVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn geo_intersect_line_vector_norm(v : GeointersectlineVector) -> Double { @_common.sqrt(geo_intersect_line_vector_dot(v, v)) }

pub fn geo_intersect_line_vector_normalize(v : GeointersectlineVector) -> GeointersectlineVector {
  let n = geo_intersect_line_vector_norm(v)
  if n < 0.0000001 { v } else { geo_intersect_line_vector_scale(v, 1.0 / n) }
}

pub fn geo_intersect_line_vector_dist(a : GeointersectlineVector, b : GeointersectlineVector) -> Double {
  geo_intersect_line_vector_norm(geo_intersect_line_vector_sub(a, b))
}

pub fn geo_intersect_line_vector_to_string(v : GeointersectlineVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn geo_intersect_line_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn geo_intersect_line_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn geo_intersect_line_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn geo_intersect_line_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn geo_intersect_line_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn geo_intersect_line_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn geo_intersect_line_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn geo_intersect_line_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn geo_intersect_line_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn geo_intersect_line_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn geo_intersect_line_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn geo_intersect_line_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn geo_intersect_line_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn geo_intersect_line_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn geo_intersect_line_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn geo_intersect_line_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn geo_intersect_line_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn geo_intersect_line_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn geo_intersect_line_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn geo_intersect_line_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn geo_intersect_line_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn geo_intersect_line_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn geo_intersect_line_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn geo_intersect_line_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn geo_intersect_line_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn geo_intersect_line_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn geo_intersect_line_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn geo_intersect_line_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn geo_intersect_line_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GeointersectlineFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_line_frame_make(size : Int) -> GeointersectlineFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_line_frame_len(s : GeointersectlineFrame) -> Int { s.size }

pub fn geo_intersect_line_frame_get(s : GeointersectlineFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_line_frame_set(s : GeointersectlineFrame, i : Int, v : Double) -> GeointersectlineFrame {
  let result = geo_intersect_line_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_line_frame_sum(s : GeointersectlineFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_line_frame_mean(s : GeointersectlineFrame) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_line_frame_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_line_frame_scale(s : GeointersectlineFrame, f : Double) -> GeointersectlineFrame {
  let result = geo_intersect_line_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_line_frame_add(a : GeointersectlineFrame, b : GeointersectlineFrame) -> GeointersectlineFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_line_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_line_frame_copy(s : GeointersectlineFrame) -> GeointersectlineFrame {
  let result = geo_intersect_line_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_line_frame_fill(s : GeointersectlineFrame, v : Double) -> GeointersectlineFrame {
  let result = geo_intersect_line_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_line_frame_min(s : GeointersectlineFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_line_frame_max(s : GeointersectlineFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_line_frame_to_string(s : GeointersectlineFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectlineTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_line_table_make(size : Int) -> GeointersectlineTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_line_table_len(s : GeointersectlineTable) -> Int { s.size }

pub fn geo_intersect_line_table_get(s : GeointersectlineTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_line_table_set(s : GeointersectlineTable, i : Int, v : Double) -> GeointersectlineTable {
  let result = geo_intersect_line_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_line_table_sum(s : GeointersectlineTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_line_table_mean(s : GeointersectlineTable) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_line_table_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_line_table_scale(s : GeointersectlineTable, f : Double) -> GeointersectlineTable {
  let result = geo_intersect_line_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_line_table_add(a : GeointersectlineTable, b : GeointersectlineTable) -> GeointersectlineTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_line_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_line_table_copy(s : GeointersectlineTable) -> GeointersectlineTable {
  let result = geo_intersect_line_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_line_table_fill(s : GeointersectlineTable, v : Double) -> GeointersectlineTable {
  let result = geo_intersect_line_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_line_table_min(s : GeointersectlineTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_line_table_max(s : GeointersectlineTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_line_table_to_string(s : GeointersectlineTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectlineGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_line_graphn_make(size : Int) -> GeointersectlineGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_line_graphn_len(s : GeointersectlineGraphN) -> Int { s.size }

pub fn geo_intersect_line_graphn_get(s : GeointersectlineGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_line_graphn_set(s : GeointersectlineGraphN, i : Int, v : Double) -> GeointersectlineGraphN {
  let result = geo_intersect_line_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_line_graphn_sum(s : GeointersectlineGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_line_graphn_mean(s : GeointersectlineGraphN) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_line_graphn_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_line_graphn_scale(s : GeointersectlineGraphN, f : Double) -> GeointersectlineGraphN {
  let result = geo_intersect_line_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_line_graphn_add(a : GeointersectlineGraphN, b : GeointersectlineGraphN) -> GeointersectlineGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_line_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_line_graphn_copy(s : GeointersectlineGraphN) -> GeointersectlineGraphN {
  let result = geo_intersect_line_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_line_graphn_fill(s : GeointersectlineGraphN, v : Double) -> GeointersectlineGraphN {
  let result = geo_intersect_line_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_line_graphn_min(s : GeointersectlineGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_line_graphn_max(s : GeointersectlineGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_line_graphn_to_string(s : GeointersectlineGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectlineNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_line_node_make(size : Int) -> GeointersectlineNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_line_node_len(s : GeointersectlineNode) -> Int { s.size }

pub fn geo_intersect_line_node_get(s : GeointersectlineNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_line_node_set(s : GeointersectlineNode, i : Int, v : Double) -> GeointersectlineNode {
  let result = geo_intersect_line_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_line_node_sum(s : GeointersectlineNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_line_node_mean(s : GeointersectlineNode) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_line_node_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_line_node_scale(s : GeointersectlineNode, f : Double) -> GeointersectlineNode {
  let result = geo_intersect_line_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_line_node_add(a : GeointersectlineNode, b : GeointersectlineNode) -> GeointersectlineNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_line_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_line_node_copy(s : GeointersectlineNode) -> GeointersectlineNode {
  let result = geo_intersect_line_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_line_node_fill(s : GeointersectlineNode, v : Double) -> GeointersectlineNode {
  let result = geo_intersect_line_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_line_node_min(s : GeointersectlineNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_line_node_max(s : GeointersectlineNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_line_node_to_string(s : GeointersectlineNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectlineEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_line_edge_make(size : Int) -> GeointersectlineEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_line_edge_len(s : GeointersectlineEdge) -> Int { s.size }

pub fn geo_intersect_line_edge_get(s : GeointersectlineEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_line_edge_set(s : GeointersectlineEdge, i : Int, v : Double) -> GeointersectlineEdge {
  let result = geo_intersect_line_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_line_edge_sum(s : GeointersectlineEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_line_edge_mean(s : GeointersectlineEdge) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_line_edge_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_line_edge_scale(s : GeointersectlineEdge, f : Double) -> GeointersectlineEdge {
  let result = geo_intersect_line_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_line_edge_add(a : GeointersectlineEdge, b : GeointersectlineEdge) -> GeointersectlineEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_line_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_line_edge_copy(s : GeointersectlineEdge) -> GeointersectlineEdge {
  let result = geo_intersect_line_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_line_edge_fill(s : GeointersectlineEdge, v : Double) -> GeointersectlineEdge {
  let result = geo_intersect_line_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_line_edge_min(s : GeointersectlineEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_line_edge_max(s : GeointersectlineEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_line_edge_to_string(s : GeointersectlineEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectlinePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_line_path_make(size : Int) -> GeointersectlinePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_line_path_len(s : GeointersectlinePath) -> Int { s.size }

pub fn geo_intersect_line_path_get(s : GeointersectlinePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_line_path_set(s : GeointersectlinePath, i : Int, v : Double) -> GeointersectlinePath {
  let result = geo_intersect_line_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_line_path_sum(s : GeointersectlinePath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_line_path_mean(s : GeointersectlinePath) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_line_path_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_line_path_scale(s : GeointersectlinePath, f : Double) -> GeointersectlinePath {
  let result = geo_intersect_line_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_line_path_add(a : GeointersectlinePath, b : GeointersectlinePath) -> GeointersectlinePath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_line_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_line_path_copy(s : GeointersectlinePath) -> GeointersectlinePath {
  let result = geo_intersect_line_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_line_path_fill(s : GeointersectlinePath, v : Double) -> GeointersectlinePath {
  let result = geo_intersect_line_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_line_path_min(s : GeointersectlinePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_line_path_max(s : GeointersectlinePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_line_path_to_string(s : GeointersectlinePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectlineCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_line_cluster_make(size : Int) -> GeointersectlineCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_line_cluster_len(s : GeointersectlineCluster) -> Int { s.size }

pub fn geo_intersect_line_cluster_get(s : GeointersectlineCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_line_cluster_set(s : GeointersectlineCluster, i : Int, v : Double) -> GeointersectlineCluster {
  let result = geo_intersect_line_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_line_cluster_sum(s : GeointersectlineCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_line_cluster_mean(s : GeointersectlineCluster) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_line_cluster_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_line_cluster_scale(s : GeointersectlineCluster, f : Double) -> GeointersectlineCluster {
  let result = geo_intersect_line_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_line_cluster_add(a : GeointersectlineCluster, b : GeointersectlineCluster) -> GeointersectlineCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_line_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_line_cluster_copy(s : GeointersectlineCluster) -> GeointersectlineCluster {
  let result = geo_intersect_line_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_line_cluster_fill(s : GeointersectlineCluster, v : Double) -> GeointersectlineCluster {
  let result = geo_intersect_line_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_line_cluster_min(s : GeointersectlineCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_line_cluster_max(s : GeointersectlineCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_line_cluster_to_string(s : GeointersectlineCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectlineModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_line_model_make(size : Int) -> GeointersectlineModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_line_model_len(s : GeointersectlineModel) -> Int { s.size }

pub fn geo_intersect_line_model_get(s : GeointersectlineModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_line_model_set(s : GeointersectlineModel, i : Int, v : Double) -> GeointersectlineModel {
  let result = geo_intersect_line_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_line_model_sum(s : GeointersectlineModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_line_model_mean(s : GeointersectlineModel) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_line_model_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_line_model_scale(s : GeointersectlineModel, f : Double) -> GeointersectlineModel {
  let result = geo_intersect_line_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_line_model_add(a : GeointersectlineModel, b : GeointersectlineModel) -> GeointersectlineModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_line_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_line_model_copy(s : GeointersectlineModel) -> GeointersectlineModel {
  let result = geo_intersect_line_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_line_model_fill(s : GeointersectlineModel, v : Double) -> GeointersectlineModel {
  let result = geo_intersect_line_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_line_model_min(s : GeointersectlineModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_line_model_max(s : GeointersectlineModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_line_model_to_string(s : GeointersectlineModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectlineLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_line_layer_make(size : Int) -> GeointersectlineLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_line_layer_len(s : GeointersectlineLayer) -> Int { s.size }

pub fn geo_intersect_line_layer_get(s : GeointersectlineLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_line_layer_set(s : GeointersectlineLayer, i : Int, v : Double) -> GeointersectlineLayer {
  let result = geo_intersect_line_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_line_layer_sum(s : GeointersectlineLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_line_layer_mean(s : GeointersectlineLayer) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_line_layer_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_line_layer_scale(s : GeointersectlineLayer, f : Double) -> GeointersectlineLayer {
  let result = geo_intersect_line_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_line_layer_add(a : GeointersectlineLayer, b : GeointersectlineLayer) -> GeointersectlineLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_line_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_line_layer_copy(s : GeointersectlineLayer) -> GeointersectlineLayer {
  let result = geo_intersect_line_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_line_layer_fill(s : GeointersectlineLayer, v : Double) -> GeointersectlineLayer {
  let result = geo_intersect_line_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_line_layer_min(s : GeointersectlineLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_line_layer_max(s : GeointersectlineLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_line_layer_to_string(s : GeointersectlineLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectlineBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_line_buffer_make(size : Int) -> GeointersectlineBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_line_buffer_len(s : GeointersectlineBuffer) -> Int { s.size }

pub fn geo_intersect_line_buffer_get(s : GeointersectlineBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_line_buffer_set(s : GeointersectlineBuffer, i : Int, v : Double) -> GeointersectlineBuffer {
  let result = geo_intersect_line_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_line_buffer_sum(s : GeointersectlineBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_line_buffer_mean(s : GeointersectlineBuffer) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_line_buffer_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_line_buffer_scale(s : GeointersectlineBuffer, f : Double) -> GeointersectlineBuffer {
  let result = geo_intersect_line_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_line_buffer_add(a : GeointersectlineBuffer, b : GeointersectlineBuffer) -> GeointersectlineBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_line_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_line_buffer_copy(s : GeointersectlineBuffer) -> GeointersectlineBuffer {
  let result = geo_intersect_line_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_line_buffer_fill(s : GeointersectlineBuffer, v : Double) -> GeointersectlineBuffer {
  let result = geo_intersect_line_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_line_buffer_min(s : GeointersectlineBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_line_buffer_max(s : GeointersectlineBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_line_buffer_to_string(s : GeointersectlineBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectlineCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_line_cursor_make(size : Int) -> GeointersectlineCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_line_cursor_len(s : GeointersectlineCursor) -> Int { s.size }

pub fn geo_intersect_line_cursor_get(s : GeointersectlineCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_line_cursor_set(s : GeointersectlineCursor, i : Int, v : Double) -> GeointersectlineCursor {
  let result = geo_intersect_line_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_line_cursor_sum(s : GeointersectlineCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_line_cursor_mean(s : GeointersectlineCursor) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_line_cursor_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_line_cursor_scale(s : GeointersectlineCursor, f : Double) -> GeointersectlineCursor {
  let result = geo_intersect_line_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_line_cursor_add(a : GeointersectlineCursor, b : GeointersectlineCursor) -> GeointersectlineCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_line_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_line_cursor_copy(s : GeointersectlineCursor) -> GeointersectlineCursor {
  let result = geo_intersect_line_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_line_cursor_fill(s : GeointersectlineCursor, v : Double) -> GeointersectlineCursor {
  let result = geo_intersect_line_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_line_cursor_min(s : GeointersectlineCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_line_cursor_max(s : GeointersectlineCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_line_cursor_to_string(s : GeointersectlineCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectlineView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_line_view_make(size : Int) -> GeointersectlineView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_line_view_len(s : GeointersectlineView) -> Int { s.size }

pub fn geo_intersect_line_view_get(s : GeointersectlineView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_line_view_set(s : GeointersectlineView, i : Int, v : Double) -> GeointersectlineView {
  let result = geo_intersect_line_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_line_view_sum(s : GeointersectlineView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_line_view_mean(s : GeointersectlineView) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_line_view_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_line_view_scale(s : GeointersectlineView, f : Double) -> GeointersectlineView {
  let result = geo_intersect_line_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_line_view_add(a : GeointersectlineView, b : GeointersectlineView) -> GeointersectlineView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_line_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_line_view_copy(s : GeointersectlineView) -> GeointersectlineView {
  let result = geo_intersect_line_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_line_view_fill(s : GeointersectlineView, v : Double) -> GeointersectlineView {
  let result = geo_intersect_line_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_line_view_min(s : GeointersectlineView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_line_view_max(s : GeointersectlineView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_line_view_to_string(s : GeointersectlineView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectlineRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_line_range_make(size : Int) -> GeointersectlineRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_line_range_len(s : GeointersectlineRange) -> Int { s.size }

pub fn geo_intersect_line_range_get(s : GeointersectlineRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_line_range_set(s : GeointersectlineRange, i : Int, v : Double) -> GeointersectlineRange {
  let result = geo_intersect_line_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_line_range_sum(s : GeointersectlineRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_line_range_mean(s : GeointersectlineRange) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_line_range_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_line_range_scale(s : GeointersectlineRange, f : Double) -> GeointersectlineRange {
  let result = geo_intersect_line_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_line_range_add(a : GeointersectlineRange, b : GeointersectlineRange) -> GeointersectlineRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_line_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_line_range_copy(s : GeointersectlineRange) -> GeointersectlineRange {
  let result = geo_intersect_line_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_line_range_fill(s : GeointersectlineRange, v : Double) -> GeointersectlineRange {
  let result = geo_intersect_line_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_line_range_min(s : GeointersectlineRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_line_range_max(s : GeointersectlineRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_line_range_to_string(s : GeointersectlineRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectlineSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_line_slice_make(size : Int) -> GeointersectlineSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_line_slice_len(s : GeointersectlineSlice) -> Int { s.size }

pub fn geo_intersect_line_slice_get(s : GeointersectlineSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_line_slice_set(s : GeointersectlineSlice, i : Int, v : Double) -> GeointersectlineSlice {
  let result = geo_intersect_line_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_line_slice_sum(s : GeointersectlineSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_line_slice_mean(s : GeointersectlineSlice) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_line_slice_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_line_slice_scale(s : GeointersectlineSlice, f : Double) -> GeointersectlineSlice {
  let result = geo_intersect_line_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_line_slice_add(a : GeointersectlineSlice, b : GeointersectlineSlice) -> GeointersectlineSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_line_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_line_slice_copy(s : GeointersectlineSlice) -> GeointersectlineSlice {
  let result = geo_intersect_line_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_line_slice_fill(s : GeointersectlineSlice, v : Double) -> GeointersectlineSlice {
  let result = geo_intersect_line_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_line_slice_min(s : GeointersectlineSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_line_slice_max(s : GeointersectlineSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_line_slice_to_string(s : GeointersectlineSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


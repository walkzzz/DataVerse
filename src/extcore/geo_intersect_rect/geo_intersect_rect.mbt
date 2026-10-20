///===
/// extcore/geo_intersect_rect

pub(all) struct GeointersectrectPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_intersect_rect_make_point(x : Double, y : Double) -> GeointersectrectPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_intersect_rect_make_point3(x : Double, y : Double, z : Double) -> GeointersectrectPoint {
  { x, y, z, label: 0 }
}

pub fn geo_intersect_rect_point_x(pt : GeointersectrectPoint) -> Double { pt.x }

pub fn geo_intersect_rect_point_y(pt : GeointersectrectPoint) -> Double { pt.y }

pub fn geo_intersect_rect_point_z(pt : GeointersectrectPoint) -> Double { pt.z }

pub fn geo_intersect_rect_point_label(pt : GeointersectrectPoint) -> Int { pt.label }

pub fn geo_intersect_rect_point_dist(a : GeointersectrectPoint, b : GeointersectrectPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn geo_intersect_rect_point_add(a : GeointersectrectPoint, b : GeointersectrectPoint) -> GeointersectrectPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn geo_intersect_rect_point_sub(a : GeointersectrectPoint, b : GeointersectrectPoint) -> GeointersectrectPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn geo_intersect_rect_point_scale(pt : GeointersectrectPoint, s : Double) -> GeointersectrectPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn geo_intersect_rect_point_dot(a : GeointersectrectPoint, b : GeointersectrectPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn geo_intersect_rect_point_cross(a : GeointersectrectPoint, b : GeointersectrectPoint) -> GeointersectrectPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn geo_intersect_rect_point_norm(pt : GeointersectrectPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn geo_intersect_rect_point_normalize(pt : GeointersectrectPoint) -> GeointersectrectPoint {
  let n = geo_intersect_rect_point_norm(pt)
  if n < 0.0000001 { pt } else { geo_intersect_rect_point_scale(pt, 1.0 / n) }
}

pub fn geo_intersect_rect_point_negate(pt : GeointersectrectPoint) -> GeointersectrectPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn geo_intersect_rect_point_mid(a : GeointersectrectPoint, b : GeointersectrectPoint) -> GeointersectrectPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn geo_intersect_rect_point_lerp(a : GeointersectrectPoint, b : GeointersectrectPoint, t : Double) -> GeointersectrectPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn geo_intersect_rect_point_to_string(pt : GeointersectrectPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct GeointersectrectSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_intersect_rect_make_series(vals : Array[Double], name : String) -> GeointersectrectSeries {
  { vals, name, meta: 0 }
}

pub fn geo_intersect_rect_series_len(s : GeointersectrectSeries) -> Int { s.vals.length() }

pub fn geo_intersect_rect_series_sum(s : GeointersectrectSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn geo_intersect_rect_series_mean(s : GeointersectrectSeries) -> Double { @_common.mean(s.vals) }

pub fn geo_intersect_rect_series_min(s : GeointersectrectSeries) -> Double { @_common.min(s.vals) }

pub fn geo_intersect_rect_series_max(s : GeointersectrectSeries) -> Double { @_common.max(s.vals) }

pub fn geo_intersect_rect_series_range(s : GeointersectrectSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn geo_intersect_rect_series_var(s : GeointersectrectSeries) -> Double { @_common.variance(s.vals) }

pub fn geo_intersect_rect_series_std(s : GeointersectrectSeries) -> Double { @_common.std(s.vals) }

pub fn geo_intersect_rect_series_median(s : GeointersectrectSeries) -> Double { @_common.median(s.vals) }

pub fn geo_intersect_rect_series_scale(s : GeointersectrectSeries, f : Double) -> GeointersectrectSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn geo_intersect_rect_series_add(a : GeointersectrectSeries, b : GeointersectrectSeries) -> GeointersectrectSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn geo_intersect_rect_series_sub(a : GeointersectrectSeries, b : GeointersectrectSeries) -> GeointersectrectSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn geo_intersect_rect_series_normalize(s : GeointersectrectSeries) -> GeointersectrectSeries {
  let mn = geo_intersect_rect_series_min(s)
  let mx = geo_intersect_rect_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn geo_intersect_rect_series_cumsum(s : GeointersectrectSeries) -> GeointersectrectSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn geo_intersect_rect_series_to_string(s : GeointersectrectSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeointersectrectMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_intersect_rect_make_matrix(rows : Int, cols : Int, val : Double) -> GeointersectrectMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn geo_intersect_rect_matrix_identity(n : Int) -> GeointersectrectMatrix {
  let m = geo_intersect_rect_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn geo_intersect_rect_matrix_get(m : GeointersectrectMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn geo_intersect_rect_matrix_transpose(m : GeointersectrectMatrix) -> GeointersectrectMatrix {
  let result = geo_intersect_rect_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn geo_intersect_rect_matrix_add(a : GeointersectrectMatrix, b : GeointersectrectMatrix) -> GeointersectrectMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = geo_intersect_rect_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn geo_intersect_rect_matrix_scale(m : GeointersectrectMatrix, s : Double) -> GeointersectrectMatrix {
  let result = geo_intersect_rect_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn geo_intersect_rect_matrix_multiply(a : GeointersectrectMatrix, b : GeointersectrectMatrix) -> GeointersectrectMatrix {
  if a.cols != b.rows { return geo_intersect_rect_make_matrix(a.rows, b.cols, 0.0) }
  let result = geo_intersect_rect_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn geo_intersect_rect_matrix_trace(m : GeointersectrectMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn geo_intersect_rect_matrix_det(m : GeointersectrectMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn geo_intersect_rect_matrix_norm(m : GeointersectrectMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn geo_intersect_rect_matrix_to_string(m : GeointersectrectMatrix) -> String {
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

pub(all) struct GeointersectrectVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_intersect_rect_make_vector(comps : Array[Double]) -> GeointersectrectVector {
  { comps, dim: comps.length() }
}

pub fn geo_intersect_rect_vector_zero(dim : Int) -> GeointersectrectVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn geo_intersect_rect_vector_add(a : GeointersectrectVector, b : GeointersectrectVector) -> GeointersectrectVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn geo_intersect_rect_vector_sub(a : GeointersectrectVector, b : GeointersectrectVector) -> GeointersectrectVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn geo_intersect_rect_vector_scale(v : GeointersectrectVector, s : Double) -> GeointersectrectVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn geo_intersect_rect_vector_dot(a : GeointersectrectVector, b : GeointersectrectVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn geo_intersect_rect_vector_norm(v : GeointersectrectVector) -> Double { @_common.sqrt(geo_intersect_rect_vector_dot(v, v)) }

pub fn geo_intersect_rect_vector_normalize(v : GeointersectrectVector) -> GeointersectrectVector {
  let n = geo_intersect_rect_vector_norm(v)
  if n < 0.0000001 { v } else { geo_intersect_rect_vector_scale(v, 1.0 / n) }
}

pub fn geo_intersect_rect_vector_dist(a : GeointersectrectVector, b : GeointersectrectVector) -> Double {
  geo_intersect_rect_vector_norm(geo_intersect_rect_vector_sub(a, b))
}

pub fn geo_intersect_rect_vector_to_string(v : GeointersectrectVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn geo_intersect_rect_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn geo_intersect_rect_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn geo_intersect_rect_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn geo_intersect_rect_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn geo_intersect_rect_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn geo_intersect_rect_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn geo_intersect_rect_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn geo_intersect_rect_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn geo_intersect_rect_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn geo_intersect_rect_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn geo_intersect_rect_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn geo_intersect_rect_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn geo_intersect_rect_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn geo_intersect_rect_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn geo_intersect_rect_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn geo_intersect_rect_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn geo_intersect_rect_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn geo_intersect_rect_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn geo_intersect_rect_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn geo_intersect_rect_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn geo_intersect_rect_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn geo_intersect_rect_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn geo_intersect_rect_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn geo_intersect_rect_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn geo_intersect_rect_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn geo_intersect_rect_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn geo_intersect_rect_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn geo_intersect_rect_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn geo_intersect_rect_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GeointersectrectFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_rect_frame_make(size : Int) -> GeointersectrectFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_rect_frame_len(s : GeointersectrectFrame) -> Int { s.size }

pub fn geo_intersect_rect_frame_get(s : GeointersectrectFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_rect_frame_set(s : GeointersectrectFrame, i : Int, v : Double) -> GeointersectrectFrame {
  let result = geo_intersect_rect_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_rect_frame_sum(s : GeointersectrectFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_rect_frame_mean(s : GeointersectrectFrame) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_rect_frame_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_rect_frame_scale(s : GeointersectrectFrame, f : Double) -> GeointersectrectFrame {
  let result = geo_intersect_rect_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_rect_frame_add(a : GeointersectrectFrame, b : GeointersectrectFrame) -> GeointersectrectFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_rect_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_rect_frame_copy(s : GeointersectrectFrame) -> GeointersectrectFrame {
  let result = geo_intersect_rect_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_rect_frame_fill(s : GeointersectrectFrame, v : Double) -> GeointersectrectFrame {
  let result = geo_intersect_rect_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_rect_frame_min(s : GeointersectrectFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_rect_frame_max(s : GeointersectrectFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_rect_frame_to_string(s : GeointersectrectFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectrectTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_rect_table_make(size : Int) -> GeointersectrectTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_rect_table_len(s : GeointersectrectTable) -> Int { s.size }

pub fn geo_intersect_rect_table_get(s : GeointersectrectTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_rect_table_set(s : GeointersectrectTable, i : Int, v : Double) -> GeointersectrectTable {
  let result = geo_intersect_rect_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_rect_table_sum(s : GeointersectrectTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_rect_table_mean(s : GeointersectrectTable) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_rect_table_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_rect_table_scale(s : GeointersectrectTable, f : Double) -> GeointersectrectTable {
  let result = geo_intersect_rect_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_rect_table_add(a : GeointersectrectTable, b : GeointersectrectTable) -> GeointersectrectTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_rect_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_rect_table_copy(s : GeointersectrectTable) -> GeointersectrectTable {
  let result = geo_intersect_rect_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_rect_table_fill(s : GeointersectrectTable, v : Double) -> GeointersectrectTable {
  let result = geo_intersect_rect_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_rect_table_min(s : GeointersectrectTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_rect_table_max(s : GeointersectrectTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_rect_table_to_string(s : GeointersectrectTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectrectGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_rect_graphn_make(size : Int) -> GeointersectrectGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_rect_graphn_len(s : GeointersectrectGraphN) -> Int { s.size }

pub fn geo_intersect_rect_graphn_get(s : GeointersectrectGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_rect_graphn_set(s : GeointersectrectGraphN, i : Int, v : Double) -> GeointersectrectGraphN {
  let result = geo_intersect_rect_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_rect_graphn_sum(s : GeointersectrectGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_rect_graphn_mean(s : GeointersectrectGraphN) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_rect_graphn_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_rect_graphn_scale(s : GeointersectrectGraphN, f : Double) -> GeointersectrectGraphN {
  let result = geo_intersect_rect_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_rect_graphn_add(a : GeointersectrectGraphN, b : GeointersectrectGraphN) -> GeointersectrectGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_rect_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_rect_graphn_copy(s : GeointersectrectGraphN) -> GeointersectrectGraphN {
  let result = geo_intersect_rect_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_rect_graphn_fill(s : GeointersectrectGraphN, v : Double) -> GeointersectrectGraphN {
  let result = geo_intersect_rect_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_rect_graphn_min(s : GeointersectrectGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_rect_graphn_max(s : GeointersectrectGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_rect_graphn_to_string(s : GeointersectrectGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectrectNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_rect_node_make(size : Int) -> GeointersectrectNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_rect_node_len(s : GeointersectrectNode) -> Int { s.size }

pub fn geo_intersect_rect_node_get(s : GeointersectrectNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_rect_node_set(s : GeointersectrectNode, i : Int, v : Double) -> GeointersectrectNode {
  let result = geo_intersect_rect_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_rect_node_sum(s : GeointersectrectNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_rect_node_mean(s : GeointersectrectNode) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_rect_node_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_rect_node_scale(s : GeointersectrectNode, f : Double) -> GeointersectrectNode {
  let result = geo_intersect_rect_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_rect_node_add(a : GeointersectrectNode, b : GeointersectrectNode) -> GeointersectrectNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_rect_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_rect_node_copy(s : GeointersectrectNode) -> GeointersectrectNode {
  let result = geo_intersect_rect_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_rect_node_fill(s : GeointersectrectNode, v : Double) -> GeointersectrectNode {
  let result = geo_intersect_rect_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_rect_node_min(s : GeointersectrectNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_rect_node_max(s : GeointersectrectNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_rect_node_to_string(s : GeointersectrectNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectrectEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_rect_edge_make(size : Int) -> GeointersectrectEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_rect_edge_len(s : GeointersectrectEdge) -> Int { s.size }

pub fn geo_intersect_rect_edge_get(s : GeointersectrectEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_rect_edge_set(s : GeointersectrectEdge, i : Int, v : Double) -> GeointersectrectEdge {
  let result = geo_intersect_rect_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_rect_edge_sum(s : GeointersectrectEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_rect_edge_mean(s : GeointersectrectEdge) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_rect_edge_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_rect_edge_scale(s : GeointersectrectEdge, f : Double) -> GeointersectrectEdge {
  let result = geo_intersect_rect_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_rect_edge_add(a : GeointersectrectEdge, b : GeointersectrectEdge) -> GeointersectrectEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_rect_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_rect_edge_copy(s : GeointersectrectEdge) -> GeointersectrectEdge {
  let result = geo_intersect_rect_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_rect_edge_fill(s : GeointersectrectEdge, v : Double) -> GeointersectrectEdge {
  let result = geo_intersect_rect_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_rect_edge_min(s : GeointersectrectEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_rect_edge_max(s : GeointersectrectEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_rect_edge_to_string(s : GeointersectrectEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectrectPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_rect_path_make(size : Int) -> GeointersectrectPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_rect_path_len(s : GeointersectrectPath) -> Int { s.size }

pub fn geo_intersect_rect_path_get(s : GeointersectrectPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_rect_path_set(s : GeointersectrectPath, i : Int, v : Double) -> GeointersectrectPath {
  let result = geo_intersect_rect_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_rect_path_sum(s : GeointersectrectPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_rect_path_mean(s : GeointersectrectPath) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_rect_path_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_rect_path_scale(s : GeointersectrectPath, f : Double) -> GeointersectrectPath {
  let result = geo_intersect_rect_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_rect_path_add(a : GeointersectrectPath, b : GeointersectrectPath) -> GeointersectrectPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_rect_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_rect_path_copy(s : GeointersectrectPath) -> GeointersectrectPath {
  let result = geo_intersect_rect_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_rect_path_fill(s : GeointersectrectPath, v : Double) -> GeointersectrectPath {
  let result = geo_intersect_rect_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_rect_path_min(s : GeointersectrectPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_rect_path_max(s : GeointersectrectPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_rect_path_to_string(s : GeointersectrectPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectrectCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_rect_cluster_make(size : Int) -> GeointersectrectCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_rect_cluster_len(s : GeointersectrectCluster) -> Int { s.size }

pub fn geo_intersect_rect_cluster_get(s : GeointersectrectCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_rect_cluster_set(s : GeointersectrectCluster, i : Int, v : Double) -> GeointersectrectCluster {
  let result = geo_intersect_rect_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_rect_cluster_sum(s : GeointersectrectCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_rect_cluster_mean(s : GeointersectrectCluster) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_rect_cluster_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_rect_cluster_scale(s : GeointersectrectCluster, f : Double) -> GeointersectrectCluster {
  let result = geo_intersect_rect_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_rect_cluster_add(a : GeointersectrectCluster, b : GeointersectrectCluster) -> GeointersectrectCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_rect_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_rect_cluster_copy(s : GeointersectrectCluster) -> GeointersectrectCluster {
  let result = geo_intersect_rect_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_rect_cluster_fill(s : GeointersectrectCluster, v : Double) -> GeointersectrectCluster {
  let result = geo_intersect_rect_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_rect_cluster_min(s : GeointersectrectCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_rect_cluster_max(s : GeointersectrectCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_rect_cluster_to_string(s : GeointersectrectCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectrectModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_rect_model_make(size : Int) -> GeointersectrectModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_rect_model_len(s : GeointersectrectModel) -> Int { s.size }

pub fn geo_intersect_rect_model_get(s : GeointersectrectModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_rect_model_set(s : GeointersectrectModel, i : Int, v : Double) -> GeointersectrectModel {
  let result = geo_intersect_rect_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_rect_model_sum(s : GeointersectrectModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_rect_model_mean(s : GeointersectrectModel) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_rect_model_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_rect_model_scale(s : GeointersectrectModel, f : Double) -> GeointersectrectModel {
  let result = geo_intersect_rect_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_rect_model_add(a : GeointersectrectModel, b : GeointersectrectModel) -> GeointersectrectModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_rect_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_rect_model_copy(s : GeointersectrectModel) -> GeointersectrectModel {
  let result = geo_intersect_rect_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_rect_model_fill(s : GeointersectrectModel, v : Double) -> GeointersectrectModel {
  let result = geo_intersect_rect_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_rect_model_min(s : GeointersectrectModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_rect_model_max(s : GeointersectrectModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_rect_model_to_string(s : GeointersectrectModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectrectLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_rect_layer_make(size : Int) -> GeointersectrectLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_rect_layer_len(s : GeointersectrectLayer) -> Int { s.size }

pub fn geo_intersect_rect_layer_get(s : GeointersectrectLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_rect_layer_set(s : GeointersectrectLayer, i : Int, v : Double) -> GeointersectrectLayer {
  let result = geo_intersect_rect_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_rect_layer_sum(s : GeointersectrectLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_rect_layer_mean(s : GeointersectrectLayer) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_rect_layer_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_rect_layer_scale(s : GeointersectrectLayer, f : Double) -> GeointersectrectLayer {
  let result = geo_intersect_rect_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_rect_layer_add(a : GeointersectrectLayer, b : GeointersectrectLayer) -> GeointersectrectLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_rect_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_rect_layer_copy(s : GeointersectrectLayer) -> GeointersectrectLayer {
  let result = geo_intersect_rect_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_rect_layer_fill(s : GeointersectrectLayer, v : Double) -> GeointersectrectLayer {
  let result = geo_intersect_rect_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_rect_layer_min(s : GeointersectrectLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_rect_layer_max(s : GeointersectrectLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_rect_layer_to_string(s : GeointersectrectLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectrectBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_rect_buffer_make(size : Int) -> GeointersectrectBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_rect_buffer_len(s : GeointersectrectBuffer) -> Int { s.size }

pub fn geo_intersect_rect_buffer_get(s : GeointersectrectBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_rect_buffer_set(s : GeointersectrectBuffer, i : Int, v : Double) -> GeointersectrectBuffer {
  let result = geo_intersect_rect_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_rect_buffer_sum(s : GeointersectrectBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_rect_buffer_mean(s : GeointersectrectBuffer) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_rect_buffer_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_rect_buffer_scale(s : GeointersectrectBuffer, f : Double) -> GeointersectrectBuffer {
  let result = geo_intersect_rect_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_rect_buffer_add(a : GeointersectrectBuffer, b : GeointersectrectBuffer) -> GeointersectrectBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_rect_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_rect_buffer_copy(s : GeointersectrectBuffer) -> GeointersectrectBuffer {
  let result = geo_intersect_rect_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_rect_buffer_fill(s : GeointersectrectBuffer, v : Double) -> GeointersectrectBuffer {
  let result = geo_intersect_rect_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_rect_buffer_min(s : GeointersectrectBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_rect_buffer_max(s : GeointersectrectBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_rect_buffer_to_string(s : GeointersectrectBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectrectCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_rect_cursor_make(size : Int) -> GeointersectrectCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_rect_cursor_len(s : GeointersectrectCursor) -> Int { s.size }

pub fn geo_intersect_rect_cursor_get(s : GeointersectrectCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_rect_cursor_set(s : GeointersectrectCursor, i : Int, v : Double) -> GeointersectrectCursor {
  let result = geo_intersect_rect_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_rect_cursor_sum(s : GeointersectrectCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_rect_cursor_mean(s : GeointersectrectCursor) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_rect_cursor_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_rect_cursor_scale(s : GeointersectrectCursor, f : Double) -> GeointersectrectCursor {
  let result = geo_intersect_rect_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_rect_cursor_add(a : GeointersectrectCursor, b : GeointersectrectCursor) -> GeointersectrectCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_rect_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_rect_cursor_copy(s : GeointersectrectCursor) -> GeointersectrectCursor {
  let result = geo_intersect_rect_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_rect_cursor_fill(s : GeointersectrectCursor, v : Double) -> GeointersectrectCursor {
  let result = geo_intersect_rect_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_rect_cursor_min(s : GeointersectrectCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_rect_cursor_max(s : GeointersectrectCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_rect_cursor_to_string(s : GeointersectrectCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectrectView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_rect_view_make(size : Int) -> GeointersectrectView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_rect_view_len(s : GeointersectrectView) -> Int { s.size }

pub fn geo_intersect_rect_view_get(s : GeointersectrectView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_rect_view_set(s : GeointersectrectView, i : Int, v : Double) -> GeointersectrectView {
  let result = geo_intersect_rect_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_rect_view_sum(s : GeointersectrectView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_rect_view_mean(s : GeointersectrectView) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_rect_view_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_rect_view_scale(s : GeointersectrectView, f : Double) -> GeointersectrectView {
  let result = geo_intersect_rect_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_rect_view_add(a : GeointersectrectView, b : GeointersectrectView) -> GeointersectrectView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_rect_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_rect_view_copy(s : GeointersectrectView) -> GeointersectrectView {
  let result = geo_intersect_rect_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_rect_view_fill(s : GeointersectrectView, v : Double) -> GeointersectrectView {
  let result = geo_intersect_rect_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_rect_view_min(s : GeointersectrectView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_rect_view_max(s : GeointersectrectView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_rect_view_to_string(s : GeointersectrectView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectrectRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_rect_range_make(size : Int) -> GeointersectrectRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_rect_range_len(s : GeointersectrectRange) -> Int { s.size }

pub fn geo_intersect_rect_range_get(s : GeointersectrectRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_rect_range_set(s : GeointersectrectRange, i : Int, v : Double) -> GeointersectrectRange {
  let result = geo_intersect_rect_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_rect_range_sum(s : GeointersectrectRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_rect_range_mean(s : GeointersectrectRange) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_rect_range_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_rect_range_scale(s : GeointersectrectRange, f : Double) -> GeointersectrectRange {
  let result = geo_intersect_rect_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_rect_range_add(a : GeointersectrectRange, b : GeointersectrectRange) -> GeointersectrectRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_rect_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_rect_range_copy(s : GeointersectrectRange) -> GeointersectrectRange {
  let result = geo_intersect_rect_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_rect_range_fill(s : GeointersectrectRange, v : Double) -> GeointersectrectRange {
  let result = geo_intersect_rect_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_rect_range_min(s : GeointersectrectRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_rect_range_max(s : GeointersectrectRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_rect_range_to_string(s : GeointersectrectRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectrectSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_rect_slice_make(size : Int) -> GeointersectrectSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_rect_slice_len(s : GeointersectrectSlice) -> Int { s.size }

pub fn geo_intersect_rect_slice_get(s : GeointersectrectSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_rect_slice_set(s : GeointersectrectSlice, i : Int, v : Double) -> GeointersectrectSlice {
  let result = geo_intersect_rect_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_rect_slice_sum(s : GeointersectrectSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_rect_slice_mean(s : GeointersectrectSlice) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_rect_slice_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_rect_slice_scale(s : GeointersectrectSlice, f : Double) -> GeointersectrectSlice {
  let result = geo_intersect_rect_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_rect_slice_add(a : GeointersectrectSlice, b : GeointersectrectSlice) -> GeointersectrectSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_rect_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_rect_slice_copy(s : GeointersectrectSlice) -> GeointersectrectSlice {
  let result = geo_intersect_rect_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_rect_slice_fill(s : GeointersectrectSlice, v : Double) -> GeointersectrectSlice {
  let result = geo_intersect_rect_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_rect_slice_min(s : GeointersectrectSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_rect_slice_max(s : GeointersectrectSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_rect_slice_to_string(s : GeointersectrectSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


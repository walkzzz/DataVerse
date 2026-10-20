///===
/// extcore/graph_color_dsatur

pub(all) struct GraphcolordsaturPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_color_dsatur_make_point(x : Double, y : Double) -> GraphcolordsaturPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_color_dsatur_make_point3(x : Double, y : Double, z : Double) -> GraphcolordsaturPoint {
  { x, y, z, label: 0 }
}

pub fn graph_color_dsatur_point_x(pt : GraphcolordsaturPoint) -> Double { pt.x }

pub fn graph_color_dsatur_point_y(pt : GraphcolordsaturPoint) -> Double { pt.y }

pub fn graph_color_dsatur_point_z(pt : GraphcolordsaturPoint) -> Double { pt.z }

pub fn graph_color_dsatur_point_label(pt : GraphcolordsaturPoint) -> Int { pt.label }

pub fn graph_color_dsatur_point_dist(a : GraphcolordsaturPoint, b : GraphcolordsaturPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn graph_color_dsatur_point_add(a : GraphcolordsaturPoint, b : GraphcolordsaturPoint) -> GraphcolordsaturPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn graph_color_dsatur_point_sub(a : GraphcolordsaturPoint, b : GraphcolordsaturPoint) -> GraphcolordsaturPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn graph_color_dsatur_point_scale(pt : GraphcolordsaturPoint, s : Double) -> GraphcolordsaturPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn graph_color_dsatur_point_dot(a : GraphcolordsaturPoint, b : GraphcolordsaturPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn graph_color_dsatur_point_cross(a : GraphcolordsaturPoint, b : GraphcolordsaturPoint) -> GraphcolordsaturPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn graph_color_dsatur_point_norm(pt : GraphcolordsaturPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn graph_color_dsatur_point_normalize(pt : GraphcolordsaturPoint) -> GraphcolordsaturPoint {
  let n = graph_color_dsatur_point_norm(pt)
  if n < 0.0000001 { pt } else { graph_color_dsatur_point_scale(pt, 1.0 / n) }
}

pub fn graph_color_dsatur_point_negate(pt : GraphcolordsaturPoint) -> GraphcolordsaturPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn graph_color_dsatur_point_mid(a : GraphcolordsaturPoint, b : GraphcolordsaturPoint) -> GraphcolordsaturPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn graph_color_dsatur_point_lerp(a : GraphcolordsaturPoint, b : GraphcolordsaturPoint, t : Double) -> GraphcolordsaturPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn graph_color_dsatur_point_to_string(pt : GraphcolordsaturPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct GraphcolordsaturSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_color_dsatur_make_series(vals : Array[Double], name : String) -> GraphcolordsaturSeries {
  { vals, name, meta: 0 }
}

pub fn graph_color_dsatur_series_len(s : GraphcolordsaturSeries) -> Int { s.vals.length() }

pub fn graph_color_dsatur_series_sum(s : GraphcolordsaturSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn graph_color_dsatur_series_mean(s : GraphcolordsaturSeries) -> Double { @_common.mean(s.vals) }

pub fn graph_color_dsatur_series_min(s : GraphcolordsaturSeries) -> Double { @_common.min(s.vals) }

pub fn graph_color_dsatur_series_max(s : GraphcolordsaturSeries) -> Double { @_common.max(s.vals) }

pub fn graph_color_dsatur_series_range(s : GraphcolordsaturSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn graph_color_dsatur_series_var(s : GraphcolordsaturSeries) -> Double { @_common.variance(s.vals) }

pub fn graph_color_dsatur_series_std(s : GraphcolordsaturSeries) -> Double { @_common.std(s.vals) }

pub fn graph_color_dsatur_series_median(s : GraphcolordsaturSeries) -> Double { @_common.median(s.vals) }

pub fn graph_color_dsatur_series_scale(s : GraphcolordsaturSeries, f : Double) -> GraphcolordsaturSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn graph_color_dsatur_series_add(a : GraphcolordsaturSeries, b : GraphcolordsaturSeries) -> GraphcolordsaturSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn graph_color_dsatur_series_sub(a : GraphcolordsaturSeries, b : GraphcolordsaturSeries) -> GraphcolordsaturSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn graph_color_dsatur_series_normalize(s : GraphcolordsaturSeries) -> GraphcolordsaturSeries {
  let mn = graph_color_dsatur_series_min(s)
  let mx = graph_color_dsatur_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn graph_color_dsatur_series_cumsum(s : GraphcolordsaturSeries) -> GraphcolordsaturSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn graph_color_dsatur_series_to_string(s : GraphcolordsaturSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphcolordsaturMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_color_dsatur_make_matrix(rows : Int, cols : Int, val : Double) -> GraphcolordsaturMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_color_dsatur_matrix_identity(n : Int) -> GraphcolordsaturMatrix {
  let m = graph_color_dsatur_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn graph_color_dsatur_matrix_get(m : GraphcolordsaturMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn graph_color_dsatur_matrix_transpose(m : GraphcolordsaturMatrix) -> GraphcolordsaturMatrix {
  let result = graph_color_dsatur_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn graph_color_dsatur_matrix_add(a : GraphcolordsaturMatrix, b : GraphcolordsaturMatrix) -> GraphcolordsaturMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = graph_color_dsatur_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn graph_color_dsatur_matrix_scale(m : GraphcolordsaturMatrix, s : Double) -> GraphcolordsaturMatrix {
  let result = graph_color_dsatur_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn graph_color_dsatur_matrix_multiply(a : GraphcolordsaturMatrix, b : GraphcolordsaturMatrix) -> GraphcolordsaturMatrix {
  if a.cols != b.rows { return graph_color_dsatur_make_matrix(a.rows, b.cols, 0.0) }
  let result = graph_color_dsatur_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn graph_color_dsatur_matrix_trace(m : GraphcolordsaturMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn graph_color_dsatur_matrix_det(m : GraphcolordsaturMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn graph_color_dsatur_matrix_norm(m : GraphcolordsaturMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn graph_color_dsatur_matrix_to_string(m : GraphcolordsaturMatrix) -> String {
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

pub(all) struct GraphcolordsaturVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_color_dsatur_make_vector(comps : Array[Double]) -> GraphcolordsaturVector {
  { comps, dim: comps.length() }
}

pub fn graph_color_dsatur_vector_zero(dim : Int) -> GraphcolordsaturVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn graph_color_dsatur_vector_add(a : GraphcolordsaturVector, b : GraphcolordsaturVector) -> GraphcolordsaturVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn graph_color_dsatur_vector_sub(a : GraphcolordsaturVector, b : GraphcolordsaturVector) -> GraphcolordsaturVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn graph_color_dsatur_vector_scale(v : GraphcolordsaturVector, s : Double) -> GraphcolordsaturVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn graph_color_dsatur_vector_dot(a : GraphcolordsaturVector, b : GraphcolordsaturVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn graph_color_dsatur_vector_norm(v : GraphcolordsaturVector) -> Double { @_common.sqrt(graph_color_dsatur_vector_dot(v, v)) }

pub fn graph_color_dsatur_vector_normalize(v : GraphcolordsaturVector) -> GraphcolordsaturVector {
  let n = graph_color_dsatur_vector_norm(v)
  if n < 0.0000001 { v } else { graph_color_dsatur_vector_scale(v, 1.0 / n) }
}

pub fn graph_color_dsatur_vector_dist(a : GraphcolordsaturVector, b : GraphcolordsaturVector) -> Double {
  graph_color_dsatur_vector_norm(graph_color_dsatur_vector_sub(a, b))
}

pub fn graph_color_dsatur_vector_to_string(v : GraphcolordsaturVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_color_dsatur_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn graph_color_dsatur_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn graph_color_dsatur_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn graph_color_dsatur_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn graph_color_dsatur_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn graph_color_dsatur_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn graph_color_dsatur_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn graph_color_dsatur_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn graph_color_dsatur_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn graph_color_dsatur_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn graph_color_dsatur_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn graph_color_dsatur_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn graph_color_dsatur_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn graph_color_dsatur_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn graph_color_dsatur_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn graph_color_dsatur_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn graph_color_dsatur_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn graph_color_dsatur_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn graph_color_dsatur_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn graph_color_dsatur_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn graph_color_dsatur_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn graph_color_dsatur_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn graph_color_dsatur_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn graph_color_dsatur_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn graph_color_dsatur_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn graph_color_dsatur_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn graph_color_dsatur_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn graph_color_dsatur_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn graph_color_dsatur_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GraphcolordsaturFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_dsatur_frame_make(size : Int) -> GraphcolordsaturFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_dsatur_frame_len(s : GraphcolordsaturFrame) -> Int { s.size }

pub fn graph_color_dsatur_frame_get(s : GraphcolordsaturFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_dsatur_frame_set(s : GraphcolordsaturFrame, i : Int, v : Double) -> GraphcolordsaturFrame {
  let result = graph_color_dsatur_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_dsatur_frame_sum(s : GraphcolordsaturFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_color_dsatur_frame_mean(s : GraphcolordsaturFrame) -> Double {
  if s.size == 0 { 0.0 } else { graph_color_dsatur_frame_sum(s) / s.size.to_double() }
}

pub fn graph_color_dsatur_frame_scale(s : GraphcolordsaturFrame, f : Double) -> GraphcolordsaturFrame {
  let result = graph_color_dsatur_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_dsatur_frame_add(a : GraphcolordsaturFrame, b : GraphcolordsaturFrame) -> GraphcolordsaturFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_dsatur_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_dsatur_frame_copy(s : GraphcolordsaturFrame) -> GraphcolordsaturFrame {
  let result = graph_color_dsatur_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_dsatur_frame_fill(s : GraphcolordsaturFrame, v : Double) -> GraphcolordsaturFrame {
  let result = graph_color_dsatur_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_dsatur_frame_min(s : GraphcolordsaturFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_dsatur_frame_max(s : GraphcolordsaturFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_dsatur_frame_to_string(s : GraphcolordsaturFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolordsaturTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_dsatur_table_make(size : Int) -> GraphcolordsaturTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_dsatur_table_len(s : GraphcolordsaturTable) -> Int { s.size }

pub fn graph_color_dsatur_table_get(s : GraphcolordsaturTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_dsatur_table_set(s : GraphcolordsaturTable, i : Int, v : Double) -> GraphcolordsaturTable {
  let result = graph_color_dsatur_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_dsatur_table_sum(s : GraphcolordsaturTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_color_dsatur_table_mean(s : GraphcolordsaturTable) -> Double {
  if s.size == 0 { 0.0 } else { graph_color_dsatur_table_sum(s) / s.size.to_double() }
}

pub fn graph_color_dsatur_table_scale(s : GraphcolordsaturTable, f : Double) -> GraphcolordsaturTable {
  let result = graph_color_dsatur_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_dsatur_table_add(a : GraphcolordsaturTable, b : GraphcolordsaturTable) -> GraphcolordsaturTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_dsatur_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_dsatur_table_copy(s : GraphcolordsaturTable) -> GraphcolordsaturTable {
  let result = graph_color_dsatur_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_dsatur_table_fill(s : GraphcolordsaturTable, v : Double) -> GraphcolordsaturTable {
  let result = graph_color_dsatur_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_dsatur_table_min(s : GraphcolordsaturTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_dsatur_table_max(s : GraphcolordsaturTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_dsatur_table_to_string(s : GraphcolordsaturTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolordsaturGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_dsatur_graphn_make(size : Int) -> GraphcolordsaturGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_dsatur_graphn_len(s : GraphcolordsaturGraphN) -> Int { s.size }

pub fn graph_color_dsatur_graphn_get(s : GraphcolordsaturGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_dsatur_graphn_set(s : GraphcolordsaturGraphN, i : Int, v : Double) -> GraphcolordsaturGraphN {
  let result = graph_color_dsatur_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_dsatur_graphn_sum(s : GraphcolordsaturGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_color_dsatur_graphn_mean(s : GraphcolordsaturGraphN) -> Double {
  if s.size == 0 { 0.0 } else { graph_color_dsatur_graphn_sum(s) / s.size.to_double() }
}

pub fn graph_color_dsatur_graphn_scale(s : GraphcolordsaturGraphN, f : Double) -> GraphcolordsaturGraphN {
  let result = graph_color_dsatur_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_dsatur_graphn_add(a : GraphcolordsaturGraphN, b : GraphcolordsaturGraphN) -> GraphcolordsaturGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_dsatur_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_dsatur_graphn_copy(s : GraphcolordsaturGraphN) -> GraphcolordsaturGraphN {
  let result = graph_color_dsatur_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_dsatur_graphn_fill(s : GraphcolordsaturGraphN, v : Double) -> GraphcolordsaturGraphN {
  let result = graph_color_dsatur_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_dsatur_graphn_min(s : GraphcolordsaturGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_dsatur_graphn_max(s : GraphcolordsaturGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_dsatur_graphn_to_string(s : GraphcolordsaturGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolordsaturNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_dsatur_node_make(size : Int) -> GraphcolordsaturNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_dsatur_node_len(s : GraphcolordsaturNode) -> Int { s.size }

pub fn graph_color_dsatur_node_get(s : GraphcolordsaturNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_dsatur_node_set(s : GraphcolordsaturNode, i : Int, v : Double) -> GraphcolordsaturNode {
  let result = graph_color_dsatur_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_dsatur_node_sum(s : GraphcolordsaturNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_color_dsatur_node_mean(s : GraphcolordsaturNode) -> Double {
  if s.size == 0 { 0.0 } else { graph_color_dsatur_node_sum(s) / s.size.to_double() }
}

pub fn graph_color_dsatur_node_scale(s : GraphcolordsaturNode, f : Double) -> GraphcolordsaturNode {
  let result = graph_color_dsatur_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_dsatur_node_add(a : GraphcolordsaturNode, b : GraphcolordsaturNode) -> GraphcolordsaturNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_dsatur_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_dsatur_node_copy(s : GraphcolordsaturNode) -> GraphcolordsaturNode {
  let result = graph_color_dsatur_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_dsatur_node_fill(s : GraphcolordsaturNode, v : Double) -> GraphcolordsaturNode {
  let result = graph_color_dsatur_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_dsatur_node_min(s : GraphcolordsaturNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_dsatur_node_max(s : GraphcolordsaturNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_dsatur_node_to_string(s : GraphcolordsaturNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolordsaturEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_dsatur_edge_make(size : Int) -> GraphcolordsaturEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_dsatur_edge_len(s : GraphcolordsaturEdge) -> Int { s.size }

pub fn graph_color_dsatur_edge_get(s : GraphcolordsaturEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_dsatur_edge_set(s : GraphcolordsaturEdge, i : Int, v : Double) -> GraphcolordsaturEdge {
  let result = graph_color_dsatur_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_dsatur_edge_sum(s : GraphcolordsaturEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_color_dsatur_edge_mean(s : GraphcolordsaturEdge) -> Double {
  if s.size == 0 { 0.0 } else { graph_color_dsatur_edge_sum(s) / s.size.to_double() }
}

pub fn graph_color_dsatur_edge_scale(s : GraphcolordsaturEdge, f : Double) -> GraphcolordsaturEdge {
  let result = graph_color_dsatur_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_dsatur_edge_add(a : GraphcolordsaturEdge, b : GraphcolordsaturEdge) -> GraphcolordsaturEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_dsatur_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_dsatur_edge_copy(s : GraphcolordsaturEdge) -> GraphcolordsaturEdge {
  let result = graph_color_dsatur_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_dsatur_edge_fill(s : GraphcolordsaturEdge, v : Double) -> GraphcolordsaturEdge {
  let result = graph_color_dsatur_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_dsatur_edge_min(s : GraphcolordsaturEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_dsatur_edge_max(s : GraphcolordsaturEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_dsatur_edge_to_string(s : GraphcolordsaturEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolordsaturPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_dsatur_path_make(size : Int) -> GraphcolordsaturPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_dsatur_path_len(s : GraphcolordsaturPath) -> Int { s.size }

pub fn graph_color_dsatur_path_get(s : GraphcolordsaturPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_dsatur_path_set(s : GraphcolordsaturPath, i : Int, v : Double) -> GraphcolordsaturPath {
  let result = graph_color_dsatur_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_dsatur_path_sum(s : GraphcolordsaturPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_color_dsatur_path_mean(s : GraphcolordsaturPath) -> Double {
  if s.size == 0 { 0.0 } else { graph_color_dsatur_path_sum(s) / s.size.to_double() }
}

pub fn graph_color_dsatur_path_scale(s : GraphcolordsaturPath, f : Double) -> GraphcolordsaturPath {
  let result = graph_color_dsatur_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_dsatur_path_add(a : GraphcolordsaturPath, b : GraphcolordsaturPath) -> GraphcolordsaturPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_dsatur_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_dsatur_path_copy(s : GraphcolordsaturPath) -> GraphcolordsaturPath {
  let result = graph_color_dsatur_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_dsatur_path_fill(s : GraphcolordsaturPath, v : Double) -> GraphcolordsaturPath {
  let result = graph_color_dsatur_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_dsatur_path_min(s : GraphcolordsaturPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_dsatur_path_max(s : GraphcolordsaturPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_dsatur_path_to_string(s : GraphcolordsaturPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolordsaturCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_dsatur_cluster_make(size : Int) -> GraphcolordsaturCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_dsatur_cluster_len(s : GraphcolordsaturCluster) -> Int { s.size }

pub fn graph_color_dsatur_cluster_get(s : GraphcolordsaturCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_dsatur_cluster_set(s : GraphcolordsaturCluster, i : Int, v : Double) -> GraphcolordsaturCluster {
  let result = graph_color_dsatur_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_dsatur_cluster_sum(s : GraphcolordsaturCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_color_dsatur_cluster_mean(s : GraphcolordsaturCluster) -> Double {
  if s.size == 0 { 0.0 } else { graph_color_dsatur_cluster_sum(s) / s.size.to_double() }
}

pub fn graph_color_dsatur_cluster_scale(s : GraphcolordsaturCluster, f : Double) -> GraphcolordsaturCluster {
  let result = graph_color_dsatur_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_dsatur_cluster_add(a : GraphcolordsaturCluster, b : GraphcolordsaturCluster) -> GraphcolordsaturCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_dsatur_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_dsatur_cluster_copy(s : GraphcolordsaturCluster) -> GraphcolordsaturCluster {
  let result = graph_color_dsatur_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_dsatur_cluster_fill(s : GraphcolordsaturCluster, v : Double) -> GraphcolordsaturCluster {
  let result = graph_color_dsatur_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_dsatur_cluster_min(s : GraphcolordsaturCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_dsatur_cluster_max(s : GraphcolordsaturCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_dsatur_cluster_to_string(s : GraphcolordsaturCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolordsaturModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_dsatur_model_make(size : Int) -> GraphcolordsaturModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_dsatur_model_len(s : GraphcolordsaturModel) -> Int { s.size }

pub fn graph_color_dsatur_model_get(s : GraphcolordsaturModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_dsatur_model_set(s : GraphcolordsaturModel, i : Int, v : Double) -> GraphcolordsaturModel {
  let result = graph_color_dsatur_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_dsatur_model_sum(s : GraphcolordsaturModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_color_dsatur_model_mean(s : GraphcolordsaturModel) -> Double {
  if s.size == 0 { 0.0 } else { graph_color_dsatur_model_sum(s) / s.size.to_double() }
}

pub fn graph_color_dsatur_model_scale(s : GraphcolordsaturModel, f : Double) -> GraphcolordsaturModel {
  let result = graph_color_dsatur_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_dsatur_model_add(a : GraphcolordsaturModel, b : GraphcolordsaturModel) -> GraphcolordsaturModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_dsatur_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_dsatur_model_copy(s : GraphcolordsaturModel) -> GraphcolordsaturModel {
  let result = graph_color_dsatur_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_dsatur_model_fill(s : GraphcolordsaturModel, v : Double) -> GraphcolordsaturModel {
  let result = graph_color_dsatur_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_dsatur_model_min(s : GraphcolordsaturModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_dsatur_model_max(s : GraphcolordsaturModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_dsatur_model_to_string(s : GraphcolordsaturModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolordsaturLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_dsatur_layer_make(size : Int) -> GraphcolordsaturLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_dsatur_layer_len(s : GraphcolordsaturLayer) -> Int { s.size }

pub fn graph_color_dsatur_layer_get(s : GraphcolordsaturLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_dsatur_layer_set(s : GraphcolordsaturLayer, i : Int, v : Double) -> GraphcolordsaturLayer {
  let result = graph_color_dsatur_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_dsatur_layer_sum(s : GraphcolordsaturLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_color_dsatur_layer_mean(s : GraphcolordsaturLayer) -> Double {
  if s.size == 0 { 0.0 } else { graph_color_dsatur_layer_sum(s) / s.size.to_double() }
}

pub fn graph_color_dsatur_layer_scale(s : GraphcolordsaturLayer, f : Double) -> GraphcolordsaturLayer {
  let result = graph_color_dsatur_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_dsatur_layer_add(a : GraphcolordsaturLayer, b : GraphcolordsaturLayer) -> GraphcolordsaturLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_dsatur_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_dsatur_layer_copy(s : GraphcolordsaturLayer) -> GraphcolordsaturLayer {
  let result = graph_color_dsatur_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_dsatur_layer_fill(s : GraphcolordsaturLayer, v : Double) -> GraphcolordsaturLayer {
  let result = graph_color_dsatur_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_dsatur_layer_min(s : GraphcolordsaturLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_dsatur_layer_max(s : GraphcolordsaturLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_dsatur_layer_to_string(s : GraphcolordsaturLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolordsaturBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_dsatur_buffer_make(size : Int) -> GraphcolordsaturBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_dsatur_buffer_len(s : GraphcolordsaturBuffer) -> Int { s.size }

pub fn graph_color_dsatur_buffer_get(s : GraphcolordsaturBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_dsatur_buffer_set(s : GraphcolordsaturBuffer, i : Int, v : Double) -> GraphcolordsaturBuffer {
  let result = graph_color_dsatur_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_dsatur_buffer_sum(s : GraphcolordsaturBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_color_dsatur_buffer_mean(s : GraphcolordsaturBuffer) -> Double {
  if s.size == 0 { 0.0 } else { graph_color_dsatur_buffer_sum(s) / s.size.to_double() }
}

pub fn graph_color_dsatur_buffer_scale(s : GraphcolordsaturBuffer, f : Double) -> GraphcolordsaturBuffer {
  let result = graph_color_dsatur_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_dsatur_buffer_add(a : GraphcolordsaturBuffer, b : GraphcolordsaturBuffer) -> GraphcolordsaturBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_dsatur_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_dsatur_buffer_copy(s : GraphcolordsaturBuffer) -> GraphcolordsaturBuffer {
  let result = graph_color_dsatur_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_dsatur_buffer_fill(s : GraphcolordsaturBuffer, v : Double) -> GraphcolordsaturBuffer {
  let result = graph_color_dsatur_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_dsatur_buffer_min(s : GraphcolordsaturBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_dsatur_buffer_max(s : GraphcolordsaturBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_dsatur_buffer_to_string(s : GraphcolordsaturBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolordsaturCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_dsatur_cursor_make(size : Int) -> GraphcolordsaturCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_dsatur_cursor_len(s : GraphcolordsaturCursor) -> Int { s.size }

pub fn graph_color_dsatur_cursor_get(s : GraphcolordsaturCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_dsatur_cursor_set(s : GraphcolordsaturCursor, i : Int, v : Double) -> GraphcolordsaturCursor {
  let result = graph_color_dsatur_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_dsatur_cursor_sum(s : GraphcolordsaturCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_color_dsatur_cursor_mean(s : GraphcolordsaturCursor) -> Double {
  if s.size == 0 { 0.0 } else { graph_color_dsatur_cursor_sum(s) / s.size.to_double() }
}

pub fn graph_color_dsatur_cursor_scale(s : GraphcolordsaturCursor, f : Double) -> GraphcolordsaturCursor {
  let result = graph_color_dsatur_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_dsatur_cursor_add(a : GraphcolordsaturCursor, b : GraphcolordsaturCursor) -> GraphcolordsaturCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_dsatur_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_dsatur_cursor_copy(s : GraphcolordsaturCursor) -> GraphcolordsaturCursor {
  let result = graph_color_dsatur_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_dsatur_cursor_fill(s : GraphcolordsaturCursor, v : Double) -> GraphcolordsaturCursor {
  let result = graph_color_dsatur_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_dsatur_cursor_min(s : GraphcolordsaturCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_dsatur_cursor_max(s : GraphcolordsaturCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_dsatur_cursor_to_string(s : GraphcolordsaturCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolordsaturView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_dsatur_view_make(size : Int) -> GraphcolordsaturView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_dsatur_view_len(s : GraphcolordsaturView) -> Int { s.size }

pub fn graph_color_dsatur_view_get(s : GraphcolordsaturView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_dsatur_view_set(s : GraphcolordsaturView, i : Int, v : Double) -> GraphcolordsaturView {
  let result = graph_color_dsatur_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_dsatur_view_sum(s : GraphcolordsaturView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_color_dsatur_view_mean(s : GraphcolordsaturView) -> Double {
  if s.size == 0 { 0.0 } else { graph_color_dsatur_view_sum(s) / s.size.to_double() }
}

pub fn graph_color_dsatur_view_scale(s : GraphcolordsaturView, f : Double) -> GraphcolordsaturView {
  let result = graph_color_dsatur_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_dsatur_view_add(a : GraphcolordsaturView, b : GraphcolordsaturView) -> GraphcolordsaturView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_dsatur_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_dsatur_view_copy(s : GraphcolordsaturView) -> GraphcolordsaturView {
  let result = graph_color_dsatur_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_dsatur_view_fill(s : GraphcolordsaturView, v : Double) -> GraphcolordsaturView {
  let result = graph_color_dsatur_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_dsatur_view_min(s : GraphcolordsaturView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_dsatur_view_max(s : GraphcolordsaturView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_dsatur_view_to_string(s : GraphcolordsaturView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolordsaturRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_dsatur_range_make(size : Int) -> GraphcolordsaturRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_dsatur_range_len(s : GraphcolordsaturRange) -> Int { s.size }

pub fn graph_color_dsatur_range_get(s : GraphcolordsaturRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_dsatur_range_set(s : GraphcolordsaturRange, i : Int, v : Double) -> GraphcolordsaturRange {
  let result = graph_color_dsatur_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_dsatur_range_sum(s : GraphcolordsaturRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_color_dsatur_range_mean(s : GraphcolordsaturRange) -> Double {
  if s.size == 0 { 0.0 } else { graph_color_dsatur_range_sum(s) / s.size.to_double() }
}

pub fn graph_color_dsatur_range_scale(s : GraphcolordsaturRange, f : Double) -> GraphcolordsaturRange {
  let result = graph_color_dsatur_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_dsatur_range_add(a : GraphcolordsaturRange, b : GraphcolordsaturRange) -> GraphcolordsaturRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_dsatur_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_dsatur_range_copy(s : GraphcolordsaturRange) -> GraphcolordsaturRange {
  let result = graph_color_dsatur_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_dsatur_range_fill(s : GraphcolordsaturRange, v : Double) -> GraphcolordsaturRange {
  let result = graph_color_dsatur_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_dsatur_range_min(s : GraphcolordsaturRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_dsatur_range_max(s : GraphcolordsaturRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_dsatur_range_to_string(s : GraphcolordsaturRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolordsaturSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_dsatur_slice_make(size : Int) -> GraphcolordsaturSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_dsatur_slice_len(s : GraphcolordsaturSlice) -> Int { s.size }

pub fn graph_color_dsatur_slice_get(s : GraphcolordsaturSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_dsatur_slice_set(s : GraphcolordsaturSlice, i : Int, v : Double) -> GraphcolordsaturSlice {
  let result = graph_color_dsatur_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_dsatur_slice_sum(s : GraphcolordsaturSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_color_dsatur_slice_mean(s : GraphcolordsaturSlice) -> Double {
  if s.size == 0 { 0.0 } else { graph_color_dsatur_slice_sum(s) / s.size.to_double() }
}

pub fn graph_color_dsatur_slice_scale(s : GraphcolordsaturSlice, f : Double) -> GraphcolordsaturSlice {
  let result = graph_color_dsatur_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_dsatur_slice_add(a : GraphcolordsaturSlice, b : GraphcolordsaturSlice) -> GraphcolordsaturSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_dsatur_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_dsatur_slice_copy(s : GraphcolordsaturSlice) -> GraphcolordsaturSlice {
  let result = graph_color_dsatur_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_dsatur_slice_fill(s : GraphcolordsaturSlice, v : Double) -> GraphcolordsaturSlice {
  let result = graph_color_dsatur_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_dsatur_slice_min(s : GraphcolordsaturSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_dsatur_slice_max(s : GraphcolordsaturSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_dsatur_slice_to_string(s : GraphcolordsaturSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


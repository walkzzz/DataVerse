///===
/// extcore/graph_connect_components

pub(all) struct GraphconnectcomponentsPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_connect_components_make_point(x : Double, y : Double) -> GraphconnectcomponentsPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_connect_components_make_point3(x : Double, y : Double, z : Double) -> GraphconnectcomponentsPoint {
  { x, y, z, label: 0 }
}

pub fn graph_connect_components_point_x(pt : GraphconnectcomponentsPoint) -> Double { pt.x }

pub fn graph_connect_components_point_y(pt : GraphconnectcomponentsPoint) -> Double { pt.y }

pub fn graph_connect_components_point_z(pt : GraphconnectcomponentsPoint) -> Double { pt.z }

pub fn graph_connect_components_point_label(pt : GraphconnectcomponentsPoint) -> Int { pt.label }

pub fn graph_connect_components_point_dist(a : GraphconnectcomponentsPoint, b : GraphconnectcomponentsPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn graph_connect_components_point_add(a : GraphconnectcomponentsPoint, b : GraphconnectcomponentsPoint) -> GraphconnectcomponentsPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn graph_connect_components_point_sub(a : GraphconnectcomponentsPoint, b : GraphconnectcomponentsPoint) -> GraphconnectcomponentsPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn graph_connect_components_point_scale(pt : GraphconnectcomponentsPoint, s : Double) -> GraphconnectcomponentsPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn graph_connect_components_point_dot(a : GraphconnectcomponentsPoint, b : GraphconnectcomponentsPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn graph_connect_components_point_cross(a : GraphconnectcomponentsPoint, b : GraphconnectcomponentsPoint) -> GraphconnectcomponentsPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn graph_connect_components_point_norm(pt : GraphconnectcomponentsPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn graph_connect_components_point_normalize(pt : GraphconnectcomponentsPoint) -> GraphconnectcomponentsPoint {
  let n = graph_connect_components_point_norm(pt)
  if n < 0.0000001 { pt } else { graph_connect_components_point_scale(pt, 1.0 / n) }
}

pub fn graph_connect_components_point_negate(pt : GraphconnectcomponentsPoint) -> GraphconnectcomponentsPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn graph_connect_components_point_mid(a : GraphconnectcomponentsPoint, b : GraphconnectcomponentsPoint) -> GraphconnectcomponentsPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn graph_connect_components_point_lerp(a : GraphconnectcomponentsPoint, b : GraphconnectcomponentsPoint, t : Double) -> GraphconnectcomponentsPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn graph_connect_components_point_to_string(pt : GraphconnectcomponentsPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct GraphconnectcomponentsSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_connect_components_make_series(vals : Array[Double], name : String) -> GraphconnectcomponentsSeries {
  { vals, name, meta: 0 }
}

pub fn graph_connect_components_series_len(s : GraphconnectcomponentsSeries) -> Int { s.vals.length() }

pub fn graph_connect_components_series_sum(s : GraphconnectcomponentsSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn graph_connect_components_series_mean(s : GraphconnectcomponentsSeries) -> Double { @_common.mean(s.vals) }

pub fn graph_connect_components_series_min(s : GraphconnectcomponentsSeries) -> Double { @_common.min(s.vals) }

pub fn graph_connect_components_series_max(s : GraphconnectcomponentsSeries) -> Double { @_common.max(s.vals) }

pub fn graph_connect_components_series_range(s : GraphconnectcomponentsSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn graph_connect_components_series_var(s : GraphconnectcomponentsSeries) -> Double { @_common.variance(s.vals) }

pub fn graph_connect_components_series_std(s : GraphconnectcomponentsSeries) -> Double { @_common.std(s.vals) }

pub fn graph_connect_components_series_median(s : GraphconnectcomponentsSeries) -> Double { @_common.median(s.vals) }

pub fn graph_connect_components_series_scale(s : GraphconnectcomponentsSeries, f : Double) -> GraphconnectcomponentsSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn graph_connect_components_series_add(a : GraphconnectcomponentsSeries, b : GraphconnectcomponentsSeries) -> GraphconnectcomponentsSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn graph_connect_components_series_sub(a : GraphconnectcomponentsSeries, b : GraphconnectcomponentsSeries) -> GraphconnectcomponentsSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn graph_connect_components_series_normalize(s : GraphconnectcomponentsSeries) -> GraphconnectcomponentsSeries {
  let mn = graph_connect_components_series_min(s)
  let mx = graph_connect_components_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn graph_connect_components_series_cumsum(s : GraphconnectcomponentsSeries) -> GraphconnectcomponentsSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn graph_connect_components_series_to_string(s : GraphconnectcomponentsSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphconnectcomponentsMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_connect_components_make_matrix(rows : Int, cols : Int, val : Double) -> GraphconnectcomponentsMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_connect_components_matrix_identity(n : Int) -> GraphconnectcomponentsMatrix {
  let m = graph_connect_components_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn graph_connect_components_matrix_get(m : GraphconnectcomponentsMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn graph_connect_components_matrix_transpose(m : GraphconnectcomponentsMatrix) -> GraphconnectcomponentsMatrix {
  let result = graph_connect_components_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn graph_connect_components_matrix_add(a : GraphconnectcomponentsMatrix, b : GraphconnectcomponentsMatrix) -> GraphconnectcomponentsMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = graph_connect_components_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn graph_connect_components_matrix_scale(m : GraphconnectcomponentsMatrix, s : Double) -> GraphconnectcomponentsMatrix {
  let result = graph_connect_components_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn graph_connect_components_matrix_multiply(a : GraphconnectcomponentsMatrix, b : GraphconnectcomponentsMatrix) -> GraphconnectcomponentsMatrix {
  if a.cols != b.rows { return graph_connect_components_make_matrix(a.rows, b.cols, 0.0) }
  let result = graph_connect_components_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn graph_connect_components_matrix_trace(m : GraphconnectcomponentsMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn graph_connect_components_matrix_det(m : GraphconnectcomponentsMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn graph_connect_components_matrix_norm(m : GraphconnectcomponentsMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn graph_connect_components_matrix_to_string(m : GraphconnectcomponentsMatrix) -> String {
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

pub(all) struct GraphconnectcomponentsVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_connect_components_make_vector(comps : Array[Double]) -> GraphconnectcomponentsVector {
  { comps, dim: comps.length() }
}

pub fn graph_connect_components_vector_zero(dim : Int) -> GraphconnectcomponentsVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn graph_connect_components_vector_add(a : GraphconnectcomponentsVector, b : GraphconnectcomponentsVector) -> GraphconnectcomponentsVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn graph_connect_components_vector_sub(a : GraphconnectcomponentsVector, b : GraphconnectcomponentsVector) -> GraphconnectcomponentsVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn graph_connect_components_vector_scale(v : GraphconnectcomponentsVector, s : Double) -> GraphconnectcomponentsVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn graph_connect_components_vector_dot(a : GraphconnectcomponentsVector, b : GraphconnectcomponentsVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn graph_connect_components_vector_norm(v : GraphconnectcomponentsVector) -> Double { @_common.sqrt(graph_connect_components_vector_dot(v, v)) }

pub fn graph_connect_components_vector_normalize(v : GraphconnectcomponentsVector) -> GraphconnectcomponentsVector {
  let n = graph_connect_components_vector_norm(v)
  if n < 0.0000001 { v } else { graph_connect_components_vector_scale(v, 1.0 / n) }
}

pub fn graph_connect_components_vector_dist(a : GraphconnectcomponentsVector, b : GraphconnectcomponentsVector) -> Double {
  graph_connect_components_vector_norm(graph_connect_components_vector_sub(a, b))
}

pub fn graph_connect_components_vector_to_string(v : GraphconnectcomponentsVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_connect_components_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn graph_connect_components_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn graph_connect_components_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn graph_connect_components_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn graph_connect_components_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn graph_connect_components_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn graph_connect_components_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn graph_connect_components_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn graph_connect_components_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn graph_connect_components_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn graph_connect_components_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn graph_connect_components_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn graph_connect_components_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn graph_connect_components_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn graph_connect_components_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn graph_connect_components_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn graph_connect_components_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn graph_connect_components_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn graph_connect_components_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn graph_connect_components_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn graph_connect_components_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn graph_connect_components_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn graph_connect_components_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn graph_connect_components_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn graph_connect_components_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn graph_connect_components_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn graph_connect_components_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn graph_connect_components_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn graph_connect_components_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GraphconnectcomponentsFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_components_frame_make(size : Int) -> GraphconnectcomponentsFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_components_frame_len(s : GraphconnectcomponentsFrame) -> Int { s.size }

pub fn graph_connect_components_frame_get(s : GraphconnectcomponentsFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_components_frame_set(s : GraphconnectcomponentsFrame, i : Int, v : Double) -> GraphconnectcomponentsFrame {
  let result = graph_connect_components_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_components_frame_sum(s : GraphconnectcomponentsFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_connect_components_frame_mean(s : GraphconnectcomponentsFrame) -> Double {
  if s.size == 0 { 0.0 } else { graph_connect_components_frame_sum(s) / s.size.to_double() }
}

pub fn graph_connect_components_frame_scale(s : GraphconnectcomponentsFrame, f : Double) -> GraphconnectcomponentsFrame {
  let result = graph_connect_components_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_connect_components_frame_add(a : GraphconnectcomponentsFrame, b : GraphconnectcomponentsFrame) -> GraphconnectcomponentsFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_connect_components_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_connect_components_frame_copy(s : GraphconnectcomponentsFrame) -> GraphconnectcomponentsFrame {
  let result = graph_connect_components_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_connect_components_frame_fill(s : GraphconnectcomponentsFrame, v : Double) -> GraphconnectcomponentsFrame {
  let result = graph_connect_components_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_connect_components_frame_min(s : GraphconnectcomponentsFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_components_frame_max(s : GraphconnectcomponentsFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_components_frame_to_string(s : GraphconnectcomponentsFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectcomponentsTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_components_table_make(size : Int) -> GraphconnectcomponentsTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_components_table_len(s : GraphconnectcomponentsTable) -> Int { s.size }

pub fn graph_connect_components_table_get(s : GraphconnectcomponentsTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_components_table_set(s : GraphconnectcomponentsTable, i : Int, v : Double) -> GraphconnectcomponentsTable {
  let result = graph_connect_components_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_components_table_sum(s : GraphconnectcomponentsTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_connect_components_table_mean(s : GraphconnectcomponentsTable) -> Double {
  if s.size == 0 { 0.0 } else { graph_connect_components_table_sum(s) / s.size.to_double() }
}

pub fn graph_connect_components_table_scale(s : GraphconnectcomponentsTable, f : Double) -> GraphconnectcomponentsTable {
  let result = graph_connect_components_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_connect_components_table_add(a : GraphconnectcomponentsTable, b : GraphconnectcomponentsTable) -> GraphconnectcomponentsTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_connect_components_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_connect_components_table_copy(s : GraphconnectcomponentsTable) -> GraphconnectcomponentsTable {
  let result = graph_connect_components_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_connect_components_table_fill(s : GraphconnectcomponentsTable, v : Double) -> GraphconnectcomponentsTable {
  let result = graph_connect_components_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_connect_components_table_min(s : GraphconnectcomponentsTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_components_table_max(s : GraphconnectcomponentsTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_components_table_to_string(s : GraphconnectcomponentsTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectcomponentsGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_components_graphn_make(size : Int) -> GraphconnectcomponentsGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_components_graphn_len(s : GraphconnectcomponentsGraphN) -> Int { s.size }

pub fn graph_connect_components_graphn_get(s : GraphconnectcomponentsGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_components_graphn_set(s : GraphconnectcomponentsGraphN, i : Int, v : Double) -> GraphconnectcomponentsGraphN {
  let result = graph_connect_components_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_components_graphn_sum(s : GraphconnectcomponentsGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_connect_components_graphn_mean(s : GraphconnectcomponentsGraphN) -> Double {
  if s.size == 0 { 0.0 } else { graph_connect_components_graphn_sum(s) / s.size.to_double() }
}

pub fn graph_connect_components_graphn_scale(s : GraphconnectcomponentsGraphN, f : Double) -> GraphconnectcomponentsGraphN {
  let result = graph_connect_components_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_connect_components_graphn_add(a : GraphconnectcomponentsGraphN, b : GraphconnectcomponentsGraphN) -> GraphconnectcomponentsGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_connect_components_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_connect_components_graphn_copy(s : GraphconnectcomponentsGraphN) -> GraphconnectcomponentsGraphN {
  let result = graph_connect_components_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_connect_components_graphn_fill(s : GraphconnectcomponentsGraphN, v : Double) -> GraphconnectcomponentsGraphN {
  let result = graph_connect_components_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_connect_components_graphn_min(s : GraphconnectcomponentsGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_components_graphn_max(s : GraphconnectcomponentsGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_components_graphn_to_string(s : GraphconnectcomponentsGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectcomponentsNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_components_node_make(size : Int) -> GraphconnectcomponentsNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_components_node_len(s : GraphconnectcomponentsNode) -> Int { s.size }

pub fn graph_connect_components_node_get(s : GraphconnectcomponentsNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_components_node_set(s : GraphconnectcomponentsNode, i : Int, v : Double) -> GraphconnectcomponentsNode {
  let result = graph_connect_components_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_components_node_sum(s : GraphconnectcomponentsNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_connect_components_node_mean(s : GraphconnectcomponentsNode) -> Double {
  if s.size == 0 { 0.0 } else { graph_connect_components_node_sum(s) / s.size.to_double() }
}

pub fn graph_connect_components_node_scale(s : GraphconnectcomponentsNode, f : Double) -> GraphconnectcomponentsNode {
  let result = graph_connect_components_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_connect_components_node_add(a : GraphconnectcomponentsNode, b : GraphconnectcomponentsNode) -> GraphconnectcomponentsNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_connect_components_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_connect_components_node_copy(s : GraphconnectcomponentsNode) -> GraphconnectcomponentsNode {
  let result = graph_connect_components_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_connect_components_node_fill(s : GraphconnectcomponentsNode, v : Double) -> GraphconnectcomponentsNode {
  let result = graph_connect_components_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_connect_components_node_min(s : GraphconnectcomponentsNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_components_node_max(s : GraphconnectcomponentsNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_components_node_to_string(s : GraphconnectcomponentsNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectcomponentsEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_components_edge_make(size : Int) -> GraphconnectcomponentsEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_components_edge_len(s : GraphconnectcomponentsEdge) -> Int { s.size }

pub fn graph_connect_components_edge_get(s : GraphconnectcomponentsEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_components_edge_set(s : GraphconnectcomponentsEdge, i : Int, v : Double) -> GraphconnectcomponentsEdge {
  let result = graph_connect_components_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_components_edge_sum(s : GraphconnectcomponentsEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_connect_components_edge_mean(s : GraphconnectcomponentsEdge) -> Double {
  if s.size == 0 { 0.0 } else { graph_connect_components_edge_sum(s) / s.size.to_double() }
}

pub fn graph_connect_components_edge_scale(s : GraphconnectcomponentsEdge, f : Double) -> GraphconnectcomponentsEdge {
  let result = graph_connect_components_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_connect_components_edge_add(a : GraphconnectcomponentsEdge, b : GraphconnectcomponentsEdge) -> GraphconnectcomponentsEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_connect_components_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_connect_components_edge_copy(s : GraphconnectcomponentsEdge) -> GraphconnectcomponentsEdge {
  let result = graph_connect_components_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_connect_components_edge_fill(s : GraphconnectcomponentsEdge, v : Double) -> GraphconnectcomponentsEdge {
  let result = graph_connect_components_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_connect_components_edge_min(s : GraphconnectcomponentsEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_components_edge_max(s : GraphconnectcomponentsEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_components_edge_to_string(s : GraphconnectcomponentsEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectcomponentsPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_components_path_make(size : Int) -> GraphconnectcomponentsPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_components_path_len(s : GraphconnectcomponentsPath) -> Int { s.size }

pub fn graph_connect_components_path_get(s : GraphconnectcomponentsPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_components_path_set(s : GraphconnectcomponentsPath, i : Int, v : Double) -> GraphconnectcomponentsPath {
  let result = graph_connect_components_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_components_path_sum(s : GraphconnectcomponentsPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_connect_components_path_mean(s : GraphconnectcomponentsPath) -> Double {
  if s.size == 0 { 0.0 } else { graph_connect_components_path_sum(s) / s.size.to_double() }
}

pub fn graph_connect_components_path_scale(s : GraphconnectcomponentsPath, f : Double) -> GraphconnectcomponentsPath {
  let result = graph_connect_components_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_connect_components_path_add(a : GraphconnectcomponentsPath, b : GraphconnectcomponentsPath) -> GraphconnectcomponentsPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_connect_components_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_connect_components_path_copy(s : GraphconnectcomponentsPath) -> GraphconnectcomponentsPath {
  let result = graph_connect_components_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_connect_components_path_fill(s : GraphconnectcomponentsPath, v : Double) -> GraphconnectcomponentsPath {
  let result = graph_connect_components_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_connect_components_path_min(s : GraphconnectcomponentsPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_components_path_max(s : GraphconnectcomponentsPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_components_path_to_string(s : GraphconnectcomponentsPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectcomponentsCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_components_cluster_make(size : Int) -> GraphconnectcomponentsCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_components_cluster_len(s : GraphconnectcomponentsCluster) -> Int { s.size }

pub fn graph_connect_components_cluster_get(s : GraphconnectcomponentsCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_components_cluster_set(s : GraphconnectcomponentsCluster, i : Int, v : Double) -> GraphconnectcomponentsCluster {
  let result = graph_connect_components_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_components_cluster_sum(s : GraphconnectcomponentsCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_connect_components_cluster_mean(s : GraphconnectcomponentsCluster) -> Double {
  if s.size == 0 { 0.0 } else { graph_connect_components_cluster_sum(s) / s.size.to_double() }
}

pub fn graph_connect_components_cluster_scale(s : GraphconnectcomponentsCluster, f : Double) -> GraphconnectcomponentsCluster {
  let result = graph_connect_components_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_connect_components_cluster_add(a : GraphconnectcomponentsCluster, b : GraphconnectcomponentsCluster) -> GraphconnectcomponentsCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_connect_components_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_connect_components_cluster_copy(s : GraphconnectcomponentsCluster) -> GraphconnectcomponentsCluster {
  let result = graph_connect_components_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_connect_components_cluster_fill(s : GraphconnectcomponentsCluster, v : Double) -> GraphconnectcomponentsCluster {
  let result = graph_connect_components_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_connect_components_cluster_min(s : GraphconnectcomponentsCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_components_cluster_max(s : GraphconnectcomponentsCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_components_cluster_to_string(s : GraphconnectcomponentsCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectcomponentsModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_components_model_make(size : Int) -> GraphconnectcomponentsModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_components_model_len(s : GraphconnectcomponentsModel) -> Int { s.size }

pub fn graph_connect_components_model_get(s : GraphconnectcomponentsModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_components_model_set(s : GraphconnectcomponentsModel, i : Int, v : Double) -> GraphconnectcomponentsModel {
  let result = graph_connect_components_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_components_model_sum(s : GraphconnectcomponentsModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_connect_components_model_mean(s : GraphconnectcomponentsModel) -> Double {
  if s.size == 0 { 0.0 } else { graph_connect_components_model_sum(s) / s.size.to_double() }
}

pub fn graph_connect_components_model_scale(s : GraphconnectcomponentsModel, f : Double) -> GraphconnectcomponentsModel {
  let result = graph_connect_components_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_connect_components_model_add(a : GraphconnectcomponentsModel, b : GraphconnectcomponentsModel) -> GraphconnectcomponentsModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_connect_components_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_connect_components_model_copy(s : GraphconnectcomponentsModel) -> GraphconnectcomponentsModel {
  let result = graph_connect_components_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_connect_components_model_fill(s : GraphconnectcomponentsModel, v : Double) -> GraphconnectcomponentsModel {
  let result = graph_connect_components_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_connect_components_model_min(s : GraphconnectcomponentsModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_components_model_max(s : GraphconnectcomponentsModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_components_model_to_string(s : GraphconnectcomponentsModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectcomponentsLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_components_layer_make(size : Int) -> GraphconnectcomponentsLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_components_layer_len(s : GraphconnectcomponentsLayer) -> Int { s.size }

pub fn graph_connect_components_layer_get(s : GraphconnectcomponentsLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_components_layer_set(s : GraphconnectcomponentsLayer, i : Int, v : Double) -> GraphconnectcomponentsLayer {
  let result = graph_connect_components_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_components_layer_sum(s : GraphconnectcomponentsLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_connect_components_layer_mean(s : GraphconnectcomponentsLayer) -> Double {
  if s.size == 0 { 0.0 } else { graph_connect_components_layer_sum(s) / s.size.to_double() }
}

pub fn graph_connect_components_layer_scale(s : GraphconnectcomponentsLayer, f : Double) -> GraphconnectcomponentsLayer {
  let result = graph_connect_components_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_connect_components_layer_add(a : GraphconnectcomponentsLayer, b : GraphconnectcomponentsLayer) -> GraphconnectcomponentsLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_connect_components_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_connect_components_layer_copy(s : GraphconnectcomponentsLayer) -> GraphconnectcomponentsLayer {
  let result = graph_connect_components_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_connect_components_layer_fill(s : GraphconnectcomponentsLayer, v : Double) -> GraphconnectcomponentsLayer {
  let result = graph_connect_components_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_connect_components_layer_min(s : GraphconnectcomponentsLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_components_layer_max(s : GraphconnectcomponentsLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_components_layer_to_string(s : GraphconnectcomponentsLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectcomponentsBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_components_buffer_make(size : Int) -> GraphconnectcomponentsBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_components_buffer_len(s : GraphconnectcomponentsBuffer) -> Int { s.size }

pub fn graph_connect_components_buffer_get(s : GraphconnectcomponentsBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_components_buffer_set(s : GraphconnectcomponentsBuffer, i : Int, v : Double) -> GraphconnectcomponentsBuffer {
  let result = graph_connect_components_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_components_buffer_sum(s : GraphconnectcomponentsBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_connect_components_buffer_mean(s : GraphconnectcomponentsBuffer) -> Double {
  if s.size == 0 { 0.0 } else { graph_connect_components_buffer_sum(s) / s.size.to_double() }
}

pub fn graph_connect_components_buffer_scale(s : GraphconnectcomponentsBuffer, f : Double) -> GraphconnectcomponentsBuffer {
  let result = graph_connect_components_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_connect_components_buffer_add(a : GraphconnectcomponentsBuffer, b : GraphconnectcomponentsBuffer) -> GraphconnectcomponentsBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_connect_components_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_connect_components_buffer_copy(s : GraphconnectcomponentsBuffer) -> GraphconnectcomponentsBuffer {
  let result = graph_connect_components_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_connect_components_buffer_fill(s : GraphconnectcomponentsBuffer, v : Double) -> GraphconnectcomponentsBuffer {
  let result = graph_connect_components_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_connect_components_buffer_min(s : GraphconnectcomponentsBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_components_buffer_max(s : GraphconnectcomponentsBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_components_buffer_to_string(s : GraphconnectcomponentsBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectcomponentsCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_components_cursor_make(size : Int) -> GraphconnectcomponentsCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_components_cursor_len(s : GraphconnectcomponentsCursor) -> Int { s.size }

pub fn graph_connect_components_cursor_get(s : GraphconnectcomponentsCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_components_cursor_set(s : GraphconnectcomponentsCursor, i : Int, v : Double) -> GraphconnectcomponentsCursor {
  let result = graph_connect_components_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_components_cursor_sum(s : GraphconnectcomponentsCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_connect_components_cursor_mean(s : GraphconnectcomponentsCursor) -> Double {
  if s.size == 0 { 0.0 } else { graph_connect_components_cursor_sum(s) / s.size.to_double() }
}

pub fn graph_connect_components_cursor_scale(s : GraphconnectcomponentsCursor, f : Double) -> GraphconnectcomponentsCursor {
  let result = graph_connect_components_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_connect_components_cursor_add(a : GraphconnectcomponentsCursor, b : GraphconnectcomponentsCursor) -> GraphconnectcomponentsCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_connect_components_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_connect_components_cursor_copy(s : GraphconnectcomponentsCursor) -> GraphconnectcomponentsCursor {
  let result = graph_connect_components_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_connect_components_cursor_fill(s : GraphconnectcomponentsCursor, v : Double) -> GraphconnectcomponentsCursor {
  let result = graph_connect_components_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_connect_components_cursor_min(s : GraphconnectcomponentsCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_components_cursor_max(s : GraphconnectcomponentsCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_components_cursor_to_string(s : GraphconnectcomponentsCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectcomponentsView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_components_view_make(size : Int) -> GraphconnectcomponentsView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_components_view_len(s : GraphconnectcomponentsView) -> Int { s.size }

pub fn graph_connect_components_view_get(s : GraphconnectcomponentsView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_components_view_set(s : GraphconnectcomponentsView, i : Int, v : Double) -> GraphconnectcomponentsView {
  let result = graph_connect_components_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_components_view_sum(s : GraphconnectcomponentsView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_connect_components_view_mean(s : GraphconnectcomponentsView) -> Double {
  if s.size == 0 { 0.0 } else { graph_connect_components_view_sum(s) / s.size.to_double() }
}

pub fn graph_connect_components_view_scale(s : GraphconnectcomponentsView, f : Double) -> GraphconnectcomponentsView {
  let result = graph_connect_components_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_connect_components_view_add(a : GraphconnectcomponentsView, b : GraphconnectcomponentsView) -> GraphconnectcomponentsView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_connect_components_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_connect_components_view_copy(s : GraphconnectcomponentsView) -> GraphconnectcomponentsView {
  let result = graph_connect_components_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_connect_components_view_fill(s : GraphconnectcomponentsView, v : Double) -> GraphconnectcomponentsView {
  let result = graph_connect_components_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_connect_components_view_min(s : GraphconnectcomponentsView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_components_view_max(s : GraphconnectcomponentsView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_components_view_to_string(s : GraphconnectcomponentsView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectcomponentsRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_components_range_make(size : Int) -> GraphconnectcomponentsRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_components_range_len(s : GraphconnectcomponentsRange) -> Int { s.size }

pub fn graph_connect_components_range_get(s : GraphconnectcomponentsRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_components_range_set(s : GraphconnectcomponentsRange, i : Int, v : Double) -> GraphconnectcomponentsRange {
  let result = graph_connect_components_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_components_range_sum(s : GraphconnectcomponentsRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_connect_components_range_mean(s : GraphconnectcomponentsRange) -> Double {
  if s.size == 0 { 0.0 } else { graph_connect_components_range_sum(s) / s.size.to_double() }
}

pub fn graph_connect_components_range_scale(s : GraphconnectcomponentsRange, f : Double) -> GraphconnectcomponentsRange {
  let result = graph_connect_components_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_connect_components_range_add(a : GraphconnectcomponentsRange, b : GraphconnectcomponentsRange) -> GraphconnectcomponentsRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_connect_components_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_connect_components_range_copy(s : GraphconnectcomponentsRange) -> GraphconnectcomponentsRange {
  let result = graph_connect_components_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_connect_components_range_fill(s : GraphconnectcomponentsRange, v : Double) -> GraphconnectcomponentsRange {
  let result = graph_connect_components_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_connect_components_range_min(s : GraphconnectcomponentsRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_components_range_max(s : GraphconnectcomponentsRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_components_range_to_string(s : GraphconnectcomponentsRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectcomponentsSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_components_slice_make(size : Int) -> GraphconnectcomponentsSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_components_slice_len(s : GraphconnectcomponentsSlice) -> Int { s.size }

pub fn graph_connect_components_slice_get(s : GraphconnectcomponentsSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_components_slice_set(s : GraphconnectcomponentsSlice, i : Int, v : Double) -> GraphconnectcomponentsSlice {
  let result = graph_connect_components_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_components_slice_sum(s : GraphconnectcomponentsSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_connect_components_slice_mean(s : GraphconnectcomponentsSlice) -> Double {
  if s.size == 0 { 0.0 } else { graph_connect_components_slice_sum(s) / s.size.to_double() }
}

pub fn graph_connect_components_slice_scale(s : GraphconnectcomponentsSlice, f : Double) -> GraphconnectcomponentsSlice {
  let result = graph_connect_components_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_connect_components_slice_add(a : GraphconnectcomponentsSlice, b : GraphconnectcomponentsSlice) -> GraphconnectcomponentsSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_connect_components_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_connect_components_slice_copy(s : GraphconnectcomponentsSlice) -> GraphconnectcomponentsSlice {
  let result = graph_connect_components_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_connect_components_slice_fill(s : GraphconnectcomponentsSlice, v : Double) -> GraphconnectcomponentsSlice {
  let result = graph_connect_components_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_connect_components_slice_min(s : GraphconnectcomponentsSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_components_slice_max(s : GraphconnectcomponentsSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_components_slice_to_string(s : GraphconnectcomponentsSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


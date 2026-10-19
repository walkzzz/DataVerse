///===
/// extcore/graph_flow_matching

pub(all) struct GraphflowmatchingPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_flow_matching_make_point(x : Double, y : Double) -> GraphflowmatchingPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_flow_matching_make_point3(x : Double, y : Double, z : Double) -> GraphflowmatchingPoint {
  { x, y, z, label: 0 }
}

pub fn graph_flow_matching_point_x(pt : GraphflowmatchingPoint) -> Double { pt.x }

pub fn graph_flow_matching_point_y(pt : GraphflowmatchingPoint) -> Double { pt.y }

pub fn graph_flow_matching_point_z(pt : GraphflowmatchingPoint) -> Double { pt.z }

pub fn graph_flow_matching_point_label(pt : GraphflowmatchingPoint) -> Int { pt.label }

pub fn graph_flow_matching_point_dist(a : GraphflowmatchingPoint, b : GraphflowmatchingPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn graph_flow_matching_point_add(a : GraphflowmatchingPoint, b : GraphflowmatchingPoint) -> GraphflowmatchingPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn graph_flow_matching_point_sub(a : GraphflowmatchingPoint, b : GraphflowmatchingPoint) -> GraphflowmatchingPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn graph_flow_matching_point_scale(pt : GraphflowmatchingPoint, s : Double) -> GraphflowmatchingPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn graph_flow_matching_point_dot(a : GraphflowmatchingPoint, b : GraphflowmatchingPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn graph_flow_matching_point_cross(a : GraphflowmatchingPoint, b : GraphflowmatchingPoint) -> GraphflowmatchingPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn graph_flow_matching_point_norm(pt : GraphflowmatchingPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn graph_flow_matching_point_normalize(pt : GraphflowmatchingPoint) -> GraphflowmatchingPoint {
  let n = graph_flow_matching_point_norm(pt)
  if n < 0.0000001 { pt } else { graph_flow_matching_point_scale(pt, 1.0 / n) }
}

pub fn graph_flow_matching_point_negate(pt : GraphflowmatchingPoint) -> GraphflowmatchingPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn graph_flow_matching_point_mid(a : GraphflowmatchingPoint, b : GraphflowmatchingPoint) -> GraphflowmatchingPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn graph_flow_matching_point_lerp(a : GraphflowmatchingPoint, b : GraphflowmatchingPoint, t : Double) -> GraphflowmatchingPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn graph_flow_matching_point_to_string(pt : GraphflowmatchingPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct GraphflowmatchingSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_flow_matching_make_series(vals : Array[Double], name : String) -> GraphflowmatchingSeries {
  { vals, name, meta: 0 }
}

pub fn graph_flow_matching_series_len(s : GraphflowmatchingSeries) -> Int { s.vals.length() }

pub fn graph_flow_matching_series_sum(s : GraphflowmatchingSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn graph_flow_matching_series_mean(s : GraphflowmatchingSeries) -> Double {
  let n = graph_flow_matching_series_len(s)
  if n == 0 { 0.0 } else { graph_flow_matching_series_sum(s) / n.to_double() }
}

pub fn graph_flow_matching_series_min(s : GraphflowmatchingSeries) -> Double {
  let n = graph_flow_matching_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn graph_flow_matching_series_max(s : GraphflowmatchingSeries) -> Double {
  let n = graph_flow_matching_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn graph_flow_matching_series_range(s : GraphflowmatchingSeries) -> Double {
  graph_flow_matching_series_max(s) - graph_flow_matching_series_min(s)
}

pub fn graph_flow_matching_series_var(s : GraphflowmatchingSeries) -> Double {
  let n = graph_flow_matching_series_len(s)
  if n == 0 { 0.0 } else {
    let m = graph_flow_matching_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn graph_flow_matching_series_std(s : GraphflowmatchingSeries) -> Double { @_common.sqrt(graph_flow_matching_series_var(s)) }

pub fn graph_flow_matching_series_median(s : GraphflowmatchingSeries) -> Double {
  let n = graph_flow_matching_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = graph_flow_matching_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn graph_flow_matching_series_scale(s : GraphflowmatchingSeries, f : Double) -> GraphflowmatchingSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn graph_flow_matching_series_add(a : GraphflowmatchingSeries, b : GraphflowmatchingSeries) -> GraphflowmatchingSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn graph_flow_matching_series_sub(a : GraphflowmatchingSeries, b : GraphflowmatchingSeries) -> GraphflowmatchingSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn graph_flow_matching_series_normalize(s : GraphflowmatchingSeries) -> GraphflowmatchingSeries {
  let mn = graph_flow_matching_series_min(s)
  let mx = graph_flow_matching_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn graph_flow_matching_series_cumsum(s : GraphflowmatchingSeries) -> GraphflowmatchingSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn graph_flow_matching_series_to_string(s : GraphflowmatchingSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphflowmatchingMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_flow_matching_make_matrix(rows : Int, cols : Int, val : Double) -> GraphflowmatchingMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_flow_matching_matrix_identity(n : Int) -> GraphflowmatchingMatrix {
  let m = graph_flow_matching_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn graph_flow_matching_matrix_get(m : GraphflowmatchingMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn graph_flow_matching_matrix_transpose(m : GraphflowmatchingMatrix) -> GraphflowmatchingMatrix {
  let result = graph_flow_matching_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn graph_flow_matching_matrix_add(a : GraphflowmatchingMatrix, b : GraphflowmatchingMatrix) -> GraphflowmatchingMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = graph_flow_matching_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn graph_flow_matching_matrix_scale(m : GraphflowmatchingMatrix, s : Double) -> GraphflowmatchingMatrix {
  let result = graph_flow_matching_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn graph_flow_matching_matrix_multiply(a : GraphflowmatchingMatrix, b : GraphflowmatchingMatrix) -> GraphflowmatchingMatrix {
  if a.cols != b.rows { return graph_flow_matching_make_matrix(a.rows, b.cols, 0.0) }
  let result = graph_flow_matching_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn graph_flow_matching_matrix_trace(m : GraphflowmatchingMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn graph_flow_matching_matrix_det(m : GraphflowmatchingMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn graph_flow_matching_matrix_norm(m : GraphflowmatchingMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn graph_flow_matching_matrix_to_string(m : GraphflowmatchingMatrix) -> String {
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

pub(all) struct GraphflowmatchingVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_flow_matching_make_vector(comps : Array[Double]) -> GraphflowmatchingVector {
  { comps, dim: comps.length() }
}

pub fn graph_flow_matching_vector_zero(dim : Int) -> GraphflowmatchingVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn graph_flow_matching_vector_add(a : GraphflowmatchingVector, b : GraphflowmatchingVector) -> GraphflowmatchingVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn graph_flow_matching_vector_sub(a : GraphflowmatchingVector, b : GraphflowmatchingVector) -> GraphflowmatchingVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn graph_flow_matching_vector_scale(v : GraphflowmatchingVector, s : Double) -> GraphflowmatchingVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn graph_flow_matching_vector_dot(a : GraphflowmatchingVector, b : GraphflowmatchingVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn graph_flow_matching_vector_norm(v : GraphflowmatchingVector) -> Double { @_common.sqrt(graph_flow_matching_vector_dot(v, v)) }

pub fn graph_flow_matching_vector_normalize(v : GraphflowmatchingVector) -> GraphflowmatchingVector {
  let n = graph_flow_matching_vector_norm(v)
  if n < 0.0000001 { v } else { graph_flow_matching_vector_scale(v, 1.0 / n) }
}

pub fn graph_flow_matching_vector_dist(a : GraphflowmatchingVector, b : GraphflowmatchingVector) -> Double {
  graph_flow_matching_vector_norm(graph_flow_matching_vector_sub(a, b))
}

pub fn graph_flow_matching_vector_to_string(v : GraphflowmatchingVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_flow_matching_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn graph_flow_matching_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn graph_flow_matching_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn graph_flow_matching_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn graph_flow_matching_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn graph_flow_matching_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn graph_flow_matching_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn graph_flow_matching_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn graph_flow_matching_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn graph_flow_matching_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn graph_flow_matching_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn graph_flow_matching_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn graph_flow_matching_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn graph_flow_matching_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn graph_flow_matching_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn graph_flow_matching_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn graph_flow_matching_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn graph_flow_matching_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn graph_flow_matching_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn graph_flow_matching_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn graph_flow_matching_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn graph_flow_matching_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn graph_flow_matching_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn graph_flow_matching_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn graph_flow_matching_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn graph_flow_matching_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn graph_flow_matching_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn graph_flow_matching_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn graph_flow_matching_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GraphflowmatchingFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_matching_frame_make(size : Int) -> GraphflowmatchingFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_matching_frame_len(s : GraphflowmatchingFrame) -> Int { s.size }

pub fn graph_flow_matching_frame_get(s : GraphflowmatchingFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_matching_frame_set(s : GraphflowmatchingFrame, i : Int, v : Double) -> GraphflowmatchingFrame {
  let result = graph_flow_matching_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_matching_frame_sum(s : GraphflowmatchingFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_flow_matching_frame_mean(s : GraphflowmatchingFrame) -> Double {
  if s.size == 0 { 0.0 } else { graph_flow_matching_frame_sum(s) / s.size.to_double() }
}

pub fn graph_flow_matching_frame_scale(s : GraphflowmatchingFrame, f : Double) -> GraphflowmatchingFrame {
  let result = graph_flow_matching_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_matching_frame_add(a : GraphflowmatchingFrame, b : GraphflowmatchingFrame) -> GraphflowmatchingFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_matching_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_matching_frame_copy(s : GraphflowmatchingFrame) -> GraphflowmatchingFrame {
  let result = graph_flow_matching_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_matching_frame_fill(s : GraphflowmatchingFrame, v : Double) -> GraphflowmatchingFrame {
  let result = graph_flow_matching_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_matching_frame_min(s : GraphflowmatchingFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_matching_frame_max(s : GraphflowmatchingFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_matching_frame_to_string(s : GraphflowmatchingFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowmatchingTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_matching_table_make(size : Int) -> GraphflowmatchingTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_matching_table_len(s : GraphflowmatchingTable) -> Int { s.size }

pub fn graph_flow_matching_table_get(s : GraphflowmatchingTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_matching_table_set(s : GraphflowmatchingTable, i : Int, v : Double) -> GraphflowmatchingTable {
  let result = graph_flow_matching_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_matching_table_sum(s : GraphflowmatchingTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_flow_matching_table_mean(s : GraphflowmatchingTable) -> Double {
  if s.size == 0 { 0.0 } else { graph_flow_matching_table_sum(s) / s.size.to_double() }
}

pub fn graph_flow_matching_table_scale(s : GraphflowmatchingTable, f : Double) -> GraphflowmatchingTable {
  let result = graph_flow_matching_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_matching_table_add(a : GraphflowmatchingTable, b : GraphflowmatchingTable) -> GraphflowmatchingTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_matching_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_matching_table_copy(s : GraphflowmatchingTable) -> GraphflowmatchingTable {
  let result = graph_flow_matching_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_matching_table_fill(s : GraphflowmatchingTable, v : Double) -> GraphflowmatchingTable {
  let result = graph_flow_matching_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_matching_table_min(s : GraphflowmatchingTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_matching_table_max(s : GraphflowmatchingTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_matching_table_to_string(s : GraphflowmatchingTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowmatchingGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_matching_graphn_make(size : Int) -> GraphflowmatchingGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_matching_graphn_len(s : GraphflowmatchingGraphN) -> Int { s.size }

pub fn graph_flow_matching_graphn_get(s : GraphflowmatchingGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_matching_graphn_set(s : GraphflowmatchingGraphN, i : Int, v : Double) -> GraphflowmatchingGraphN {
  let result = graph_flow_matching_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_matching_graphn_sum(s : GraphflowmatchingGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_flow_matching_graphn_mean(s : GraphflowmatchingGraphN) -> Double {
  if s.size == 0 { 0.0 } else { graph_flow_matching_graphn_sum(s) / s.size.to_double() }
}

pub fn graph_flow_matching_graphn_scale(s : GraphflowmatchingGraphN, f : Double) -> GraphflowmatchingGraphN {
  let result = graph_flow_matching_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_matching_graphn_add(a : GraphflowmatchingGraphN, b : GraphflowmatchingGraphN) -> GraphflowmatchingGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_matching_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_matching_graphn_copy(s : GraphflowmatchingGraphN) -> GraphflowmatchingGraphN {
  let result = graph_flow_matching_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_matching_graphn_fill(s : GraphflowmatchingGraphN, v : Double) -> GraphflowmatchingGraphN {
  let result = graph_flow_matching_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_matching_graphn_min(s : GraphflowmatchingGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_matching_graphn_max(s : GraphflowmatchingGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_matching_graphn_to_string(s : GraphflowmatchingGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowmatchingNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_matching_node_make(size : Int) -> GraphflowmatchingNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_matching_node_len(s : GraphflowmatchingNode) -> Int { s.size }

pub fn graph_flow_matching_node_get(s : GraphflowmatchingNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_matching_node_set(s : GraphflowmatchingNode, i : Int, v : Double) -> GraphflowmatchingNode {
  let result = graph_flow_matching_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_matching_node_sum(s : GraphflowmatchingNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_flow_matching_node_mean(s : GraphflowmatchingNode) -> Double {
  if s.size == 0 { 0.0 } else { graph_flow_matching_node_sum(s) / s.size.to_double() }
}

pub fn graph_flow_matching_node_scale(s : GraphflowmatchingNode, f : Double) -> GraphflowmatchingNode {
  let result = graph_flow_matching_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_matching_node_add(a : GraphflowmatchingNode, b : GraphflowmatchingNode) -> GraphflowmatchingNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_matching_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_matching_node_copy(s : GraphflowmatchingNode) -> GraphflowmatchingNode {
  let result = graph_flow_matching_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_matching_node_fill(s : GraphflowmatchingNode, v : Double) -> GraphflowmatchingNode {
  let result = graph_flow_matching_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_matching_node_min(s : GraphflowmatchingNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_matching_node_max(s : GraphflowmatchingNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_matching_node_to_string(s : GraphflowmatchingNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowmatchingEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_matching_edge_make(size : Int) -> GraphflowmatchingEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_matching_edge_len(s : GraphflowmatchingEdge) -> Int { s.size }

pub fn graph_flow_matching_edge_get(s : GraphflowmatchingEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_matching_edge_set(s : GraphflowmatchingEdge, i : Int, v : Double) -> GraphflowmatchingEdge {
  let result = graph_flow_matching_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_matching_edge_sum(s : GraphflowmatchingEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_flow_matching_edge_mean(s : GraphflowmatchingEdge) -> Double {
  if s.size == 0 { 0.0 } else { graph_flow_matching_edge_sum(s) / s.size.to_double() }
}

pub fn graph_flow_matching_edge_scale(s : GraphflowmatchingEdge, f : Double) -> GraphflowmatchingEdge {
  let result = graph_flow_matching_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_matching_edge_add(a : GraphflowmatchingEdge, b : GraphflowmatchingEdge) -> GraphflowmatchingEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_matching_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_matching_edge_copy(s : GraphflowmatchingEdge) -> GraphflowmatchingEdge {
  let result = graph_flow_matching_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_matching_edge_fill(s : GraphflowmatchingEdge, v : Double) -> GraphflowmatchingEdge {
  let result = graph_flow_matching_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_matching_edge_min(s : GraphflowmatchingEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_matching_edge_max(s : GraphflowmatchingEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_matching_edge_to_string(s : GraphflowmatchingEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowmatchingPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_matching_path_make(size : Int) -> GraphflowmatchingPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_matching_path_len(s : GraphflowmatchingPath) -> Int { s.size }

pub fn graph_flow_matching_path_get(s : GraphflowmatchingPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_matching_path_set(s : GraphflowmatchingPath, i : Int, v : Double) -> GraphflowmatchingPath {
  let result = graph_flow_matching_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_matching_path_sum(s : GraphflowmatchingPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_flow_matching_path_mean(s : GraphflowmatchingPath) -> Double {
  if s.size == 0 { 0.0 } else { graph_flow_matching_path_sum(s) / s.size.to_double() }
}

pub fn graph_flow_matching_path_scale(s : GraphflowmatchingPath, f : Double) -> GraphflowmatchingPath {
  let result = graph_flow_matching_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_matching_path_add(a : GraphflowmatchingPath, b : GraphflowmatchingPath) -> GraphflowmatchingPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_matching_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_matching_path_copy(s : GraphflowmatchingPath) -> GraphflowmatchingPath {
  let result = graph_flow_matching_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_matching_path_fill(s : GraphflowmatchingPath, v : Double) -> GraphflowmatchingPath {
  let result = graph_flow_matching_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_matching_path_min(s : GraphflowmatchingPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_matching_path_max(s : GraphflowmatchingPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_matching_path_to_string(s : GraphflowmatchingPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowmatchingCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_matching_cluster_make(size : Int) -> GraphflowmatchingCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_matching_cluster_len(s : GraphflowmatchingCluster) -> Int { s.size }

pub fn graph_flow_matching_cluster_get(s : GraphflowmatchingCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_matching_cluster_set(s : GraphflowmatchingCluster, i : Int, v : Double) -> GraphflowmatchingCluster {
  let result = graph_flow_matching_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_matching_cluster_sum(s : GraphflowmatchingCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_flow_matching_cluster_mean(s : GraphflowmatchingCluster) -> Double {
  if s.size == 0 { 0.0 } else { graph_flow_matching_cluster_sum(s) / s.size.to_double() }
}

pub fn graph_flow_matching_cluster_scale(s : GraphflowmatchingCluster, f : Double) -> GraphflowmatchingCluster {
  let result = graph_flow_matching_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_matching_cluster_add(a : GraphflowmatchingCluster, b : GraphflowmatchingCluster) -> GraphflowmatchingCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_matching_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_matching_cluster_copy(s : GraphflowmatchingCluster) -> GraphflowmatchingCluster {
  let result = graph_flow_matching_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_matching_cluster_fill(s : GraphflowmatchingCluster, v : Double) -> GraphflowmatchingCluster {
  let result = graph_flow_matching_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_matching_cluster_min(s : GraphflowmatchingCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_matching_cluster_max(s : GraphflowmatchingCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_matching_cluster_to_string(s : GraphflowmatchingCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowmatchingModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_matching_model_make(size : Int) -> GraphflowmatchingModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_matching_model_len(s : GraphflowmatchingModel) -> Int { s.size }

pub fn graph_flow_matching_model_get(s : GraphflowmatchingModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_matching_model_set(s : GraphflowmatchingModel, i : Int, v : Double) -> GraphflowmatchingModel {
  let result = graph_flow_matching_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_matching_model_sum(s : GraphflowmatchingModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_flow_matching_model_mean(s : GraphflowmatchingModel) -> Double {
  if s.size == 0 { 0.0 } else { graph_flow_matching_model_sum(s) / s.size.to_double() }
}

pub fn graph_flow_matching_model_scale(s : GraphflowmatchingModel, f : Double) -> GraphflowmatchingModel {
  let result = graph_flow_matching_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_matching_model_add(a : GraphflowmatchingModel, b : GraphflowmatchingModel) -> GraphflowmatchingModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_matching_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_matching_model_copy(s : GraphflowmatchingModel) -> GraphflowmatchingModel {
  let result = graph_flow_matching_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_matching_model_fill(s : GraphflowmatchingModel, v : Double) -> GraphflowmatchingModel {
  let result = graph_flow_matching_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_matching_model_min(s : GraphflowmatchingModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_matching_model_max(s : GraphflowmatchingModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_matching_model_to_string(s : GraphflowmatchingModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowmatchingLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_matching_layer_make(size : Int) -> GraphflowmatchingLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_matching_layer_len(s : GraphflowmatchingLayer) -> Int { s.size }

pub fn graph_flow_matching_layer_get(s : GraphflowmatchingLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_matching_layer_set(s : GraphflowmatchingLayer, i : Int, v : Double) -> GraphflowmatchingLayer {
  let result = graph_flow_matching_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_matching_layer_sum(s : GraphflowmatchingLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_flow_matching_layer_mean(s : GraphflowmatchingLayer) -> Double {
  if s.size == 0 { 0.0 } else { graph_flow_matching_layer_sum(s) / s.size.to_double() }
}

pub fn graph_flow_matching_layer_scale(s : GraphflowmatchingLayer, f : Double) -> GraphflowmatchingLayer {
  let result = graph_flow_matching_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_matching_layer_add(a : GraphflowmatchingLayer, b : GraphflowmatchingLayer) -> GraphflowmatchingLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_matching_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_matching_layer_copy(s : GraphflowmatchingLayer) -> GraphflowmatchingLayer {
  let result = graph_flow_matching_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_matching_layer_fill(s : GraphflowmatchingLayer, v : Double) -> GraphflowmatchingLayer {
  let result = graph_flow_matching_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_matching_layer_min(s : GraphflowmatchingLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_matching_layer_max(s : GraphflowmatchingLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_matching_layer_to_string(s : GraphflowmatchingLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowmatchingBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_matching_buffer_make(size : Int) -> GraphflowmatchingBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_matching_buffer_len(s : GraphflowmatchingBuffer) -> Int { s.size }

pub fn graph_flow_matching_buffer_get(s : GraphflowmatchingBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_matching_buffer_set(s : GraphflowmatchingBuffer, i : Int, v : Double) -> GraphflowmatchingBuffer {
  let result = graph_flow_matching_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_matching_buffer_sum(s : GraphflowmatchingBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_flow_matching_buffer_mean(s : GraphflowmatchingBuffer) -> Double {
  if s.size == 0 { 0.0 } else { graph_flow_matching_buffer_sum(s) / s.size.to_double() }
}

pub fn graph_flow_matching_buffer_scale(s : GraphflowmatchingBuffer, f : Double) -> GraphflowmatchingBuffer {
  let result = graph_flow_matching_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_matching_buffer_add(a : GraphflowmatchingBuffer, b : GraphflowmatchingBuffer) -> GraphflowmatchingBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_matching_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_matching_buffer_copy(s : GraphflowmatchingBuffer) -> GraphflowmatchingBuffer {
  let result = graph_flow_matching_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_matching_buffer_fill(s : GraphflowmatchingBuffer, v : Double) -> GraphflowmatchingBuffer {
  let result = graph_flow_matching_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_matching_buffer_min(s : GraphflowmatchingBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_matching_buffer_max(s : GraphflowmatchingBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_matching_buffer_to_string(s : GraphflowmatchingBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowmatchingCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_matching_cursor_make(size : Int) -> GraphflowmatchingCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_matching_cursor_len(s : GraphflowmatchingCursor) -> Int { s.size }

pub fn graph_flow_matching_cursor_get(s : GraphflowmatchingCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_matching_cursor_set(s : GraphflowmatchingCursor, i : Int, v : Double) -> GraphflowmatchingCursor {
  let result = graph_flow_matching_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_matching_cursor_sum(s : GraphflowmatchingCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_flow_matching_cursor_mean(s : GraphflowmatchingCursor) -> Double {
  if s.size == 0 { 0.0 } else { graph_flow_matching_cursor_sum(s) / s.size.to_double() }
}

pub fn graph_flow_matching_cursor_scale(s : GraphflowmatchingCursor, f : Double) -> GraphflowmatchingCursor {
  let result = graph_flow_matching_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_matching_cursor_add(a : GraphflowmatchingCursor, b : GraphflowmatchingCursor) -> GraphflowmatchingCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_matching_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_matching_cursor_copy(s : GraphflowmatchingCursor) -> GraphflowmatchingCursor {
  let result = graph_flow_matching_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_matching_cursor_fill(s : GraphflowmatchingCursor, v : Double) -> GraphflowmatchingCursor {
  let result = graph_flow_matching_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_matching_cursor_min(s : GraphflowmatchingCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_matching_cursor_max(s : GraphflowmatchingCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_matching_cursor_to_string(s : GraphflowmatchingCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowmatchingView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_matching_view_make(size : Int) -> GraphflowmatchingView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_matching_view_len(s : GraphflowmatchingView) -> Int { s.size }

pub fn graph_flow_matching_view_get(s : GraphflowmatchingView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_matching_view_set(s : GraphflowmatchingView, i : Int, v : Double) -> GraphflowmatchingView {
  let result = graph_flow_matching_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_matching_view_sum(s : GraphflowmatchingView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_flow_matching_view_mean(s : GraphflowmatchingView) -> Double {
  if s.size == 0 { 0.0 } else { graph_flow_matching_view_sum(s) / s.size.to_double() }
}

pub fn graph_flow_matching_view_scale(s : GraphflowmatchingView, f : Double) -> GraphflowmatchingView {
  let result = graph_flow_matching_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_matching_view_add(a : GraphflowmatchingView, b : GraphflowmatchingView) -> GraphflowmatchingView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_matching_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_matching_view_copy(s : GraphflowmatchingView) -> GraphflowmatchingView {
  let result = graph_flow_matching_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_matching_view_fill(s : GraphflowmatchingView, v : Double) -> GraphflowmatchingView {
  let result = graph_flow_matching_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_matching_view_min(s : GraphflowmatchingView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_matching_view_max(s : GraphflowmatchingView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_matching_view_to_string(s : GraphflowmatchingView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowmatchingRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_matching_range_make(size : Int) -> GraphflowmatchingRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_matching_range_len(s : GraphflowmatchingRange) -> Int { s.size }

pub fn graph_flow_matching_range_get(s : GraphflowmatchingRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_matching_range_set(s : GraphflowmatchingRange, i : Int, v : Double) -> GraphflowmatchingRange {
  let result = graph_flow_matching_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_matching_range_sum(s : GraphflowmatchingRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_flow_matching_range_mean(s : GraphflowmatchingRange) -> Double {
  if s.size == 0 { 0.0 } else { graph_flow_matching_range_sum(s) / s.size.to_double() }
}

pub fn graph_flow_matching_range_scale(s : GraphflowmatchingRange, f : Double) -> GraphflowmatchingRange {
  let result = graph_flow_matching_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_matching_range_add(a : GraphflowmatchingRange, b : GraphflowmatchingRange) -> GraphflowmatchingRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_matching_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_matching_range_copy(s : GraphflowmatchingRange) -> GraphflowmatchingRange {
  let result = graph_flow_matching_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_matching_range_fill(s : GraphflowmatchingRange, v : Double) -> GraphflowmatchingRange {
  let result = graph_flow_matching_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_matching_range_min(s : GraphflowmatchingRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_matching_range_max(s : GraphflowmatchingRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_matching_range_to_string(s : GraphflowmatchingRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowmatchingSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_matching_slice_make(size : Int) -> GraphflowmatchingSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_matching_slice_len(s : GraphflowmatchingSlice) -> Int { s.size }

pub fn graph_flow_matching_slice_get(s : GraphflowmatchingSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_matching_slice_set(s : GraphflowmatchingSlice, i : Int, v : Double) -> GraphflowmatchingSlice {
  let result = graph_flow_matching_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_matching_slice_sum(s : GraphflowmatchingSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_flow_matching_slice_mean(s : GraphflowmatchingSlice) -> Double {
  if s.size == 0 { 0.0 } else { graph_flow_matching_slice_sum(s) / s.size.to_double() }
}

pub fn graph_flow_matching_slice_scale(s : GraphflowmatchingSlice, f : Double) -> GraphflowmatchingSlice {
  let result = graph_flow_matching_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_matching_slice_add(a : GraphflowmatchingSlice, b : GraphflowmatchingSlice) -> GraphflowmatchingSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_matching_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_matching_slice_copy(s : GraphflowmatchingSlice) -> GraphflowmatchingSlice {
  let result = graph_flow_matching_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_matching_slice_fill(s : GraphflowmatchingSlice, v : Double) -> GraphflowmatchingSlice {
  let result = graph_flow_matching_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_matching_slice_min(s : GraphflowmatchingSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_matching_slice_max(s : GraphflowmatchingSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_matching_slice_to_string(s : GraphflowmatchingSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


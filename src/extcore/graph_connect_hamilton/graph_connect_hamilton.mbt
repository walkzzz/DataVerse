///===
/// extcore/graph_connect_hamilton

pub(all) struct GraphconnecthamiltonPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_connect_hamilton_make_point(x : Double, y : Double) -> GraphconnecthamiltonPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_connect_hamilton_make_point3(x : Double, y : Double, z : Double) -> GraphconnecthamiltonPoint {
  { x, y, z, label: 0 }
}

pub fn graph_connect_hamilton_point_x(pt : GraphconnecthamiltonPoint) -> Double { pt.x }

pub fn graph_connect_hamilton_point_y(pt : GraphconnecthamiltonPoint) -> Double { pt.y }

pub fn graph_connect_hamilton_point_z(pt : GraphconnecthamiltonPoint) -> Double { pt.z }

pub fn graph_connect_hamilton_point_label(pt : GraphconnecthamiltonPoint) -> Int { pt.label }

pub fn graph_connect_hamilton_point_dist(a : GraphconnecthamiltonPoint, b : GraphconnecthamiltonPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn graph_connect_hamilton_point_add(a : GraphconnecthamiltonPoint, b : GraphconnecthamiltonPoint) -> GraphconnecthamiltonPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn graph_connect_hamilton_point_sub(a : GraphconnecthamiltonPoint, b : GraphconnecthamiltonPoint) -> GraphconnecthamiltonPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn graph_connect_hamilton_point_scale(pt : GraphconnecthamiltonPoint, s : Double) -> GraphconnecthamiltonPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn graph_connect_hamilton_point_dot(a : GraphconnecthamiltonPoint, b : GraphconnecthamiltonPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn graph_connect_hamilton_point_cross(a : GraphconnecthamiltonPoint, b : GraphconnecthamiltonPoint) -> GraphconnecthamiltonPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn graph_connect_hamilton_point_norm(pt : GraphconnecthamiltonPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn graph_connect_hamilton_point_normalize(pt : GraphconnecthamiltonPoint) -> GraphconnecthamiltonPoint {
  let n = graph_connect_hamilton_point_norm(pt)
  if n < 0.0000001 { pt } else { graph_connect_hamilton_point_scale(pt, 1.0 / n) }
}

pub fn graph_connect_hamilton_point_negate(pt : GraphconnecthamiltonPoint) -> GraphconnecthamiltonPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn graph_connect_hamilton_point_mid(a : GraphconnecthamiltonPoint, b : GraphconnecthamiltonPoint) -> GraphconnecthamiltonPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn graph_connect_hamilton_point_lerp(a : GraphconnecthamiltonPoint, b : GraphconnecthamiltonPoint, t : Double) -> GraphconnecthamiltonPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn graph_connect_hamilton_point_to_string(pt : GraphconnecthamiltonPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct GraphconnecthamiltonSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_connect_hamilton_make_series(vals : Array[Double], name : String) -> GraphconnecthamiltonSeries {
  { vals, name, meta: 0 }
}

pub fn graph_connect_hamilton_series_len(s : GraphconnecthamiltonSeries) -> Int { s.vals.length() }

pub fn graph_connect_hamilton_series_sum(s : GraphconnecthamiltonSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn graph_connect_hamilton_series_mean(s : GraphconnecthamiltonSeries) -> Double {
  let n = graph_connect_hamilton_series_len(s)
  if n == 0 { 0.0 } else { graph_connect_hamilton_series_sum(s) / n.to_double() }
}

pub fn graph_connect_hamilton_series_min(s : GraphconnecthamiltonSeries) -> Double {
  let n = graph_connect_hamilton_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn graph_connect_hamilton_series_max(s : GraphconnecthamiltonSeries) -> Double {
  let n = graph_connect_hamilton_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn graph_connect_hamilton_series_range(s : GraphconnecthamiltonSeries) -> Double {
  graph_connect_hamilton_series_max(s) - graph_connect_hamilton_series_min(s)
}

pub fn graph_connect_hamilton_series_var(s : GraphconnecthamiltonSeries) -> Double {
  let n = graph_connect_hamilton_series_len(s)
  if n == 0 { 0.0 } else {
    let m = graph_connect_hamilton_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn graph_connect_hamilton_series_std(s : GraphconnecthamiltonSeries) -> Double { @_common.sqrt(graph_connect_hamilton_series_var(s)) }

pub fn graph_connect_hamilton_series_median(s : GraphconnecthamiltonSeries) -> Double {
  let n = graph_connect_hamilton_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = graph_connect_hamilton_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn graph_connect_hamilton_series_scale(s : GraphconnecthamiltonSeries, f : Double) -> GraphconnecthamiltonSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn graph_connect_hamilton_series_add(a : GraphconnecthamiltonSeries, b : GraphconnecthamiltonSeries) -> GraphconnecthamiltonSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn graph_connect_hamilton_series_sub(a : GraphconnecthamiltonSeries, b : GraphconnecthamiltonSeries) -> GraphconnecthamiltonSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn graph_connect_hamilton_series_normalize(s : GraphconnecthamiltonSeries) -> GraphconnecthamiltonSeries {
  let mn = graph_connect_hamilton_series_min(s)
  let mx = graph_connect_hamilton_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn graph_connect_hamilton_series_cumsum(s : GraphconnecthamiltonSeries) -> GraphconnecthamiltonSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn graph_connect_hamilton_series_to_string(s : GraphconnecthamiltonSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphconnecthamiltonMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_connect_hamilton_make_matrix(rows : Int, cols : Int, val : Double) -> GraphconnecthamiltonMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_connect_hamilton_matrix_identity(n : Int) -> GraphconnecthamiltonMatrix {
  let m = graph_connect_hamilton_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn graph_connect_hamilton_matrix_get(m : GraphconnecthamiltonMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn graph_connect_hamilton_matrix_transpose(m : GraphconnecthamiltonMatrix) -> GraphconnecthamiltonMatrix {
  let result = graph_connect_hamilton_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn graph_connect_hamilton_matrix_add(a : GraphconnecthamiltonMatrix, b : GraphconnecthamiltonMatrix) -> GraphconnecthamiltonMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = graph_connect_hamilton_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn graph_connect_hamilton_matrix_scale(m : GraphconnecthamiltonMatrix, s : Double) -> GraphconnecthamiltonMatrix {
  let result = graph_connect_hamilton_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn graph_connect_hamilton_matrix_multiply(a : GraphconnecthamiltonMatrix, b : GraphconnecthamiltonMatrix) -> GraphconnecthamiltonMatrix {
  if a.cols != b.rows { return graph_connect_hamilton_make_matrix(a.rows, b.cols, 0.0) }
  let result = graph_connect_hamilton_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn graph_connect_hamilton_matrix_trace(m : GraphconnecthamiltonMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn graph_connect_hamilton_matrix_det(m : GraphconnecthamiltonMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn graph_connect_hamilton_matrix_norm(m : GraphconnecthamiltonMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn graph_connect_hamilton_matrix_to_string(m : GraphconnecthamiltonMatrix) -> String {
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

pub(all) struct GraphconnecthamiltonVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_connect_hamilton_make_vector(comps : Array[Double]) -> GraphconnecthamiltonVector {
  { comps, dim: comps.length() }
}

pub fn graph_connect_hamilton_vector_zero(dim : Int) -> GraphconnecthamiltonVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn graph_connect_hamilton_vector_add(a : GraphconnecthamiltonVector, b : GraphconnecthamiltonVector) -> GraphconnecthamiltonVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn graph_connect_hamilton_vector_sub(a : GraphconnecthamiltonVector, b : GraphconnecthamiltonVector) -> GraphconnecthamiltonVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn graph_connect_hamilton_vector_scale(v : GraphconnecthamiltonVector, s : Double) -> GraphconnecthamiltonVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn graph_connect_hamilton_vector_dot(a : GraphconnecthamiltonVector, b : GraphconnecthamiltonVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn graph_connect_hamilton_vector_norm(v : GraphconnecthamiltonVector) -> Double { @_common.sqrt(graph_connect_hamilton_vector_dot(v, v)) }

pub fn graph_connect_hamilton_vector_normalize(v : GraphconnecthamiltonVector) -> GraphconnecthamiltonVector {
  let n = graph_connect_hamilton_vector_norm(v)
  if n < 0.0000001 { v } else { graph_connect_hamilton_vector_scale(v, 1.0 / n) }
}

pub fn graph_connect_hamilton_vector_dist(a : GraphconnecthamiltonVector, b : GraphconnecthamiltonVector) -> Double {
  graph_connect_hamilton_vector_norm(graph_connect_hamilton_vector_sub(a, b))
}

pub fn graph_connect_hamilton_vector_to_string(v : GraphconnecthamiltonVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_connect_hamilton_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn graph_connect_hamilton_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn graph_connect_hamilton_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn graph_connect_hamilton_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn graph_connect_hamilton_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn graph_connect_hamilton_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn graph_connect_hamilton_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn graph_connect_hamilton_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn graph_connect_hamilton_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn graph_connect_hamilton_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn graph_connect_hamilton_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn graph_connect_hamilton_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn graph_connect_hamilton_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn graph_connect_hamilton_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn graph_connect_hamilton_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn graph_connect_hamilton_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn graph_connect_hamilton_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn graph_connect_hamilton_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn graph_connect_hamilton_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn graph_connect_hamilton_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn graph_connect_hamilton_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn graph_connect_hamilton_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn graph_connect_hamilton_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn graph_connect_hamilton_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn graph_connect_hamilton_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn graph_connect_hamilton_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn graph_connect_hamilton_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn graph_connect_hamilton_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn graph_connect_hamilton_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GraphconnecthamiltonFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_hamilton_frame_make(size : Int) -> GraphconnecthamiltonFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_hamilton_frame_len(s : GraphconnecthamiltonFrame) -> Int { s.size }

pub fn graph_connect_hamilton_frame_get(s : GraphconnecthamiltonFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_hamilton_frame_set(s : GraphconnecthamiltonFrame, i : Int, v : Double) -> GraphconnecthamiltonFrame {
  let result = graph_connect_hamilton_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_hamilton_frame_sum(s : GraphconnecthamiltonFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_connect_hamilton_frame_mean(s : GraphconnecthamiltonFrame) -> Double {
  if s.size == 0 { 0.0 } else { graph_connect_hamilton_frame_sum(s) / s.size.to_double() }
}

pub fn graph_connect_hamilton_frame_scale(s : GraphconnecthamiltonFrame, f : Double) -> GraphconnecthamiltonFrame {
  let result = graph_connect_hamilton_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_connect_hamilton_frame_add(a : GraphconnecthamiltonFrame, b : GraphconnecthamiltonFrame) -> GraphconnecthamiltonFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_connect_hamilton_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_connect_hamilton_frame_copy(s : GraphconnecthamiltonFrame) -> GraphconnecthamiltonFrame {
  let result = graph_connect_hamilton_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_connect_hamilton_frame_fill(s : GraphconnecthamiltonFrame, v : Double) -> GraphconnecthamiltonFrame {
  let result = graph_connect_hamilton_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_connect_hamilton_frame_min(s : GraphconnecthamiltonFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_hamilton_frame_max(s : GraphconnecthamiltonFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_hamilton_frame_to_string(s : GraphconnecthamiltonFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnecthamiltonTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_hamilton_table_make(size : Int) -> GraphconnecthamiltonTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_hamilton_table_len(s : GraphconnecthamiltonTable) -> Int { s.size }

pub fn graph_connect_hamilton_table_get(s : GraphconnecthamiltonTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_hamilton_table_set(s : GraphconnecthamiltonTable, i : Int, v : Double) -> GraphconnecthamiltonTable {
  let result = graph_connect_hamilton_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_hamilton_table_sum(s : GraphconnecthamiltonTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_connect_hamilton_table_mean(s : GraphconnecthamiltonTable) -> Double {
  if s.size == 0 { 0.0 } else { graph_connect_hamilton_table_sum(s) / s.size.to_double() }
}

pub fn graph_connect_hamilton_table_scale(s : GraphconnecthamiltonTable, f : Double) -> GraphconnecthamiltonTable {
  let result = graph_connect_hamilton_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_connect_hamilton_table_add(a : GraphconnecthamiltonTable, b : GraphconnecthamiltonTable) -> GraphconnecthamiltonTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_connect_hamilton_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_connect_hamilton_table_copy(s : GraphconnecthamiltonTable) -> GraphconnecthamiltonTable {
  let result = graph_connect_hamilton_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_connect_hamilton_table_fill(s : GraphconnecthamiltonTable, v : Double) -> GraphconnecthamiltonTable {
  let result = graph_connect_hamilton_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_connect_hamilton_table_min(s : GraphconnecthamiltonTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_hamilton_table_max(s : GraphconnecthamiltonTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_hamilton_table_to_string(s : GraphconnecthamiltonTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnecthamiltonGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_hamilton_graphn_make(size : Int) -> GraphconnecthamiltonGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_hamilton_graphn_len(s : GraphconnecthamiltonGraphN) -> Int { s.size }

pub fn graph_connect_hamilton_graphn_get(s : GraphconnecthamiltonGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_hamilton_graphn_set(s : GraphconnecthamiltonGraphN, i : Int, v : Double) -> GraphconnecthamiltonGraphN {
  let result = graph_connect_hamilton_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_hamilton_graphn_sum(s : GraphconnecthamiltonGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_connect_hamilton_graphn_mean(s : GraphconnecthamiltonGraphN) -> Double {
  if s.size == 0 { 0.0 } else { graph_connect_hamilton_graphn_sum(s) / s.size.to_double() }
}

pub fn graph_connect_hamilton_graphn_scale(s : GraphconnecthamiltonGraphN, f : Double) -> GraphconnecthamiltonGraphN {
  let result = graph_connect_hamilton_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_connect_hamilton_graphn_add(a : GraphconnecthamiltonGraphN, b : GraphconnecthamiltonGraphN) -> GraphconnecthamiltonGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_connect_hamilton_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_connect_hamilton_graphn_copy(s : GraphconnecthamiltonGraphN) -> GraphconnecthamiltonGraphN {
  let result = graph_connect_hamilton_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_connect_hamilton_graphn_fill(s : GraphconnecthamiltonGraphN, v : Double) -> GraphconnecthamiltonGraphN {
  let result = graph_connect_hamilton_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_connect_hamilton_graphn_min(s : GraphconnecthamiltonGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_hamilton_graphn_max(s : GraphconnecthamiltonGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_hamilton_graphn_to_string(s : GraphconnecthamiltonGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnecthamiltonNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_hamilton_node_make(size : Int) -> GraphconnecthamiltonNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_hamilton_node_len(s : GraphconnecthamiltonNode) -> Int { s.size }

pub fn graph_connect_hamilton_node_get(s : GraphconnecthamiltonNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_hamilton_node_set(s : GraphconnecthamiltonNode, i : Int, v : Double) -> GraphconnecthamiltonNode {
  let result = graph_connect_hamilton_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_hamilton_node_sum(s : GraphconnecthamiltonNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_connect_hamilton_node_mean(s : GraphconnecthamiltonNode) -> Double {
  if s.size == 0 { 0.0 } else { graph_connect_hamilton_node_sum(s) / s.size.to_double() }
}

pub fn graph_connect_hamilton_node_scale(s : GraphconnecthamiltonNode, f : Double) -> GraphconnecthamiltonNode {
  let result = graph_connect_hamilton_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_connect_hamilton_node_add(a : GraphconnecthamiltonNode, b : GraphconnecthamiltonNode) -> GraphconnecthamiltonNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_connect_hamilton_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_connect_hamilton_node_copy(s : GraphconnecthamiltonNode) -> GraphconnecthamiltonNode {
  let result = graph_connect_hamilton_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_connect_hamilton_node_fill(s : GraphconnecthamiltonNode, v : Double) -> GraphconnecthamiltonNode {
  let result = graph_connect_hamilton_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_connect_hamilton_node_min(s : GraphconnecthamiltonNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_hamilton_node_max(s : GraphconnecthamiltonNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_hamilton_node_to_string(s : GraphconnecthamiltonNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnecthamiltonEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_hamilton_edge_make(size : Int) -> GraphconnecthamiltonEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_hamilton_edge_len(s : GraphconnecthamiltonEdge) -> Int { s.size }

pub fn graph_connect_hamilton_edge_get(s : GraphconnecthamiltonEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_hamilton_edge_set(s : GraphconnecthamiltonEdge, i : Int, v : Double) -> GraphconnecthamiltonEdge {
  let result = graph_connect_hamilton_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_hamilton_edge_sum(s : GraphconnecthamiltonEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_connect_hamilton_edge_mean(s : GraphconnecthamiltonEdge) -> Double {
  if s.size == 0 { 0.0 } else { graph_connect_hamilton_edge_sum(s) / s.size.to_double() }
}

pub fn graph_connect_hamilton_edge_scale(s : GraphconnecthamiltonEdge, f : Double) -> GraphconnecthamiltonEdge {
  let result = graph_connect_hamilton_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_connect_hamilton_edge_add(a : GraphconnecthamiltonEdge, b : GraphconnecthamiltonEdge) -> GraphconnecthamiltonEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_connect_hamilton_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_connect_hamilton_edge_copy(s : GraphconnecthamiltonEdge) -> GraphconnecthamiltonEdge {
  let result = graph_connect_hamilton_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_connect_hamilton_edge_fill(s : GraphconnecthamiltonEdge, v : Double) -> GraphconnecthamiltonEdge {
  let result = graph_connect_hamilton_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_connect_hamilton_edge_min(s : GraphconnecthamiltonEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_hamilton_edge_max(s : GraphconnecthamiltonEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_hamilton_edge_to_string(s : GraphconnecthamiltonEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnecthamiltonPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_hamilton_path_make(size : Int) -> GraphconnecthamiltonPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_hamilton_path_len(s : GraphconnecthamiltonPath) -> Int { s.size }

pub fn graph_connect_hamilton_path_get(s : GraphconnecthamiltonPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_hamilton_path_set(s : GraphconnecthamiltonPath, i : Int, v : Double) -> GraphconnecthamiltonPath {
  let result = graph_connect_hamilton_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_hamilton_path_sum(s : GraphconnecthamiltonPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_connect_hamilton_path_mean(s : GraphconnecthamiltonPath) -> Double {
  if s.size == 0 { 0.0 } else { graph_connect_hamilton_path_sum(s) / s.size.to_double() }
}

pub fn graph_connect_hamilton_path_scale(s : GraphconnecthamiltonPath, f : Double) -> GraphconnecthamiltonPath {
  let result = graph_connect_hamilton_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_connect_hamilton_path_add(a : GraphconnecthamiltonPath, b : GraphconnecthamiltonPath) -> GraphconnecthamiltonPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_connect_hamilton_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_connect_hamilton_path_copy(s : GraphconnecthamiltonPath) -> GraphconnecthamiltonPath {
  let result = graph_connect_hamilton_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_connect_hamilton_path_fill(s : GraphconnecthamiltonPath, v : Double) -> GraphconnecthamiltonPath {
  let result = graph_connect_hamilton_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_connect_hamilton_path_min(s : GraphconnecthamiltonPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_hamilton_path_max(s : GraphconnecthamiltonPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_hamilton_path_to_string(s : GraphconnecthamiltonPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnecthamiltonCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_hamilton_cluster_make(size : Int) -> GraphconnecthamiltonCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_hamilton_cluster_len(s : GraphconnecthamiltonCluster) -> Int { s.size }

pub fn graph_connect_hamilton_cluster_get(s : GraphconnecthamiltonCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_hamilton_cluster_set(s : GraphconnecthamiltonCluster, i : Int, v : Double) -> GraphconnecthamiltonCluster {
  let result = graph_connect_hamilton_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_hamilton_cluster_sum(s : GraphconnecthamiltonCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_connect_hamilton_cluster_mean(s : GraphconnecthamiltonCluster) -> Double {
  if s.size == 0 { 0.0 } else { graph_connect_hamilton_cluster_sum(s) / s.size.to_double() }
}

pub fn graph_connect_hamilton_cluster_scale(s : GraphconnecthamiltonCluster, f : Double) -> GraphconnecthamiltonCluster {
  let result = graph_connect_hamilton_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_connect_hamilton_cluster_add(a : GraphconnecthamiltonCluster, b : GraphconnecthamiltonCluster) -> GraphconnecthamiltonCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_connect_hamilton_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_connect_hamilton_cluster_copy(s : GraphconnecthamiltonCluster) -> GraphconnecthamiltonCluster {
  let result = graph_connect_hamilton_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_connect_hamilton_cluster_fill(s : GraphconnecthamiltonCluster, v : Double) -> GraphconnecthamiltonCluster {
  let result = graph_connect_hamilton_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_connect_hamilton_cluster_min(s : GraphconnecthamiltonCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_hamilton_cluster_max(s : GraphconnecthamiltonCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_hamilton_cluster_to_string(s : GraphconnecthamiltonCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnecthamiltonModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_hamilton_model_make(size : Int) -> GraphconnecthamiltonModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_hamilton_model_len(s : GraphconnecthamiltonModel) -> Int { s.size }

pub fn graph_connect_hamilton_model_get(s : GraphconnecthamiltonModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_hamilton_model_set(s : GraphconnecthamiltonModel, i : Int, v : Double) -> GraphconnecthamiltonModel {
  let result = graph_connect_hamilton_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_hamilton_model_sum(s : GraphconnecthamiltonModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_connect_hamilton_model_mean(s : GraphconnecthamiltonModel) -> Double {
  if s.size == 0 { 0.0 } else { graph_connect_hamilton_model_sum(s) / s.size.to_double() }
}

pub fn graph_connect_hamilton_model_scale(s : GraphconnecthamiltonModel, f : Double) -> GraphconnecthamiltonModel {
  let result = graph_connect_hamilton_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_connect_hamilton_model_add(a : GraphconnecthamiltonModel, b : GraphconnecthamiltonModel) -> GraphconnecthamiltonModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_connect_hamilton_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_connect_hamilton_model_copy(s : GraphconnecthamiltonModel) -> GraphconnecthamiltonModel {
  let result = graph_connect_hamilton_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_connect_hamilton_model_fill(s : GraphconnecthamiltonModel, v : Double) -> GraphconnecthamiltonModel {
  let result = graph_connect_hamilton_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_connect_hamilton_model_min(s : GraphconnecthamiltonModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_hamilton_model_max(s : GraphconnecthamiltonModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_hamilton_model_to_string(s : GraphconnecthamiltonModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnecthamiltonLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_hamilton_layer_make(size : Int) -> GraphconnecthamiltonLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_hamilton_layer_len(s : GraphconnecthamiltonLayer) -> Int { s.size }

pub fn graph_connect_hamilton_layer_get(s : GraphconnecthamiltonLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_hamilton_layer_set(s : GraphconnecthamiltonLayer, i : Int, v : Double) -> GraphconnecthamiltonLayer {
  let result = graph_connect_hamilton_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_hamilton_layer_sum(s : GraphconnecthamiltonLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_connect_hamilton_layer_mean(s : GraphconnecthamiltonLayer) -> Double {
  if s.size == 0 { 0.0 } else { graph_connect_hamilton_layer_sum(s) / s.size.to_double() }
}

pub fn graph_connect_hamilton_layer_scale(s : GraphconnecthamiltonLayer, f : Double) -> GraphconnecthamiltonLayer {
  let result = graph_connect_hamilton_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_connect_hamilton_layer_add(a : GraphconnecthamiltonLayer, b : GraphconnecthamiltonLayer) -> GraphconnecthamiltonLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_connect_hamilton_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_connect_hamilton_layer_copy(s : GraphconnecthamiltonLayer) -> GraphconnecthamiltonLayer {
  let result = graph_connect_hamilton_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_connect_hamilton_layer_fill(s : GraphconnecthamiltonLayer, v : Double) -> GraphconnecthamiltonLayer {
  let result = graph_connect_hamilton_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_connect_hamilton_layer_min(s : GraphconnecthamiltonLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_hamilton_layer_max(s : GraphconnecthamiltonLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_hamilton_layer_to_string(s : GraphconnecthamiltonLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnecthamiltonBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_hamilton_buffer_make(size : Int) -> GraphconnecthamiltonBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_hamilton_buffer_len(s : GraphconnecthamiltonBuffer) -> Int { s.size }

pub fn graph_connect_hamilton_buffer_get(s : GraphconnecthamiltonBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_hamilton_buffer_set(s : GraphconnecthamiltonBuffer, i : Int, v : Double) -> GraphconnecthamiltonBuffer {
  let result = graph_connect_hamilton_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_hamilton_buffer_sum(s : GraphconnecthamiltonBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_connect_hamilton_buffer_mean(s : GraphconnecthamiltonBuffer) -> Double {
  if s.size == 0 { 0.0 } else { graph_connect_hamilton_buffer_sum(s) / s.size.to_double() }
}

pub fn graph_connect_hamilton_buffer_scale(s : GraphconnecthamiltonBuffer, f : Double) -> GraphconnecthamiltonBuffer {
  let result = graph_connect_hamilton_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_connect_hamilton_buffer_add(a : GraphconnecthamiltonBuffer, b : GraphconnecthamiltonBuffer) -> GraphconnecthamiltonBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_connect_hamilton_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_connect_hamilton_buffer_copy(s : GraphconnecthamiltonBuffer) -> GraphconnecthamiltonBuffer {
  let result = graph_connect_hamilton_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_connect_hamilton_buffer_fill(s : GraphconnecthamiltonBuffer, v : Double) -> GraphconnecthamiltonBuffer {
  let result = graph_connect_hamilton_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_connect_hamilton_buffer_min(s : GraphconnecthamiltonBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_hamilton_buffer_max(s : GraphconnecthamiltonBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_hamilton_buffer_to_string(s : GraphconnecthamiltonBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnecthamiltonCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_hamilton_cursor_make(size : Int) -> GraphconnecthamiltonCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_hamilton_cursor_len(s : GraphconnecthamiltonCursor) -> Int { s.size }

pub fn graph_connect_hamilton_cursor_get(s : GraphconnecthamiltonCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_hamilton_cursor_set(s : GraphconnecthamiltonCursor, i : Int, v : Double) -> GraphconnecthamiltonCursor {
  let result = graph_connect_hamilton_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_hamilton_cursor_sum(s : GraphconnecthamiltonCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_connect_hamilton_cursor_mean(s : GraphconnecthamiltonCursor) -> Double {
  if s.size == 0 { 0.0 } else { graph_connect_hamilton_cursor_sum(s) / s.size.to_double() }
}

pub fn graph_connect_hamilton_cursor_scale(s : GraphconnecthamiltonCursor, f : Double) -> GraphconnecthamiltonCursor {
  let result = graph_connect_hamilton_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_connect_hamilton_cursor_add(a : GraphconnecthamiltonCursor, b : GraphconnecthamiltonCursor) -> GraphconnecthamiltonCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_connect_hamilton_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_connect_hamilton_cursor_copy(s : GraphconnecthamiltonCursor) -> GraphconnecthamiltonCursor {
  let result = graph_connect_hamilton_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_connect_hamilton_cursor_fill(s : GraphconnecthamiltonCursor, v : Double) -> GraphconnecthamiltonCursor {
  let result = graph_connect_hamilton_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_connect_hamilton_cursor_min(s : GraphconnecthamiltonCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_hamilton_cursor_max(s : GraphconnecthamiltonCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_hamilton_cursor_to_string(s : GraphconnecthamiltonCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnecthamiltonView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_hamilton_view_make(size : Int) -> GraphconnecthamiltonView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_hamilton_view_len(s : GraphconnecthamiltonView) -> Int { s.size }

pub fn graph_connect_hamilton_view_get(s : GraphconnecthamiltonView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_hamilton_view_set(s : GraphconnecthamiltonView, i : Int, v : Double) -> GraphconnecthamiltonView {
  let result = graph_connect_hamilton_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_hamilton_view_sum(s : GraphconnecthamiltonView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_connect_hamilton_view_mean(s : GraphconnecthamiltonView) -> Double {
  if s.size == 0 { 0.0 } else { graph_connect_hamilton_view_sum(s) / s.size.to_double() }
}

pub fn graph_connect_hamilton_view_scale(s : GraphconnecthamiltonView, f : Double) -> GraphconnecthamiltonView {
  let result = graph_connect_hamilton_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_connect_hamilton_view_add(a : GraphconnecthamiltonView, b : GraphconnecthamiltonView) -> GraphconnecthamiltonView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_connect_hamilton_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_connect_hamilton_view_copy(s : GraphconnecthamiltonView) -> GraphconnecthamiltonView {
  let result = graph_connect_hamilton_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_connect_hamilton_view_fill(s : GraphconnecthamiltonView, v : Double) -> GraphconnecthamiltonView {
  let result = graph_connect_hamilton_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_connect_hamilton_view_min(s : GraphconnecthamiltonView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_hamilton_view_max(s : GraphconnecthamiltonView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_hamilton_view_to_string(s : GraphconnecthamiltonView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnecthamiltonRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_hamilton_range_make(size : Int) -> GraphconnecthamiltonRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_hamilton_range_len(s : GraphconnecthamiltonRange) -> Int { s.size }

pub fn graph_connect_hamilton_range_get(s : GraphconnecthamiltonRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_hamilton_range_set(s : GraphconnecthamiltonRange, i : Int, v : Double) -> GraphconnecthamiltonRange {
  let result = graph_connect_hamilton_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_hamilton_range_sum(s : GraphconnecthamiltonRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_connect_hamilton_range_mean(s : GraphconnecthamiltonRange) -> Double {
  if s.size == 0 { 0.0 } else { graph_connect_hamilton_range_sum(s) / s.size.to_double() }
}

pub fn graph_connect_hamilton_range_scale(s : GraphconnecthamiltonRange, f : Double) -> GraphconnecthamiltonRange {
  let result = graph_connect_hamilton_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_connect_hamilton_range_add(a : GraphconnecthamiltonRange, b : GraphconnecthamiltonRange) -> GraphconnecthamiltonRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_connect_hamilton_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_connect_hamilton_range_copy(s : GraphconnecthamiltonRange) -> GraphconnecthamiltonRange {
  let result = graph_connect_hamilton_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_connect_hamilton_range_fill(s : GraphconnecthamiltonRange, v : Double) -> GraphconnecthamiltonRange {
  let result = graph_connect_hamilton_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_connect_hamilton_range_min(s : GraphconnecthamiltonRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_hamilton_range_max(s : GraphconnecthamiltonRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_hamilton_range_to_string(s : GraphconnecthamiltonRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnecthamiltonSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_hamilton_slice_make(size : Int) -> GraphconnecthamiltonSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_hamilton_slice_len(s : GraphconnecthamiltonSlice) -> Int { s.size }

pub fn graph_connect_hamilton_slice_get(s : GraphconnecthamiltonSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_hamilton_slice_set(s : GraphconnecthamiltonSlice, i : Int, v : Double) -> GraphconnecthamiltonSlice {
  let result = graph_connect_hamilton_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_hamilton_slice_sum(s : GraphconnecthamiltonSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_connect_hamilton_slice_mean(s : GraphconnecthamiltonSlice) -> Double {
  if s.size == 0 { 0.0 } else { graph_connect_hamilton_slice_sum(s) / s.size.to_double() }
}

pub fn graph_connect_hamilton_slice_scale(s : GraphconnecthamiltonSlice, f : Double) -> GraphconnecthamiltonSlice {
  let result = graph_connect_hamilton_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_connect_hamilton_slice_add(a : GraphconnecthamiltonSlice, b : GraphconnecthamiltonSlice) -> GraphconnecthamiltonSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_connect_hamilton_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_connect_hamilton_slice_copy(s : GraphconnecthamiltonSlice) -> GraphconnecthamiltonSlice {
  let result = graph_connect_hamilton_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_connect_hamilton_slice_fill(s : GraphconnecthamiltonSlice, v : Double) -> GraphconnecthamiltonSlice {
  let result = graph_connect_hamilton_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_connect_hamilton_slice_min(s : GraphconnecthamiltonSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_hamilton_slice_max(s : GraphconnecthamiltonSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_hamilton_slice_to_string(s : GraphconnecthamiltonSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


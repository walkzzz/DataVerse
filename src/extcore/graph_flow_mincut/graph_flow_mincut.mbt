///===
/// extcore/graph_flow_mincut

pub(all) struct GraphflowmincutPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_flow_mincut_make_point(x : Double, y : Double) -> GraphflowmincutPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_flow_mincut_make_point3(x : Double, y : Double, z : Double) -> GraphflowmincutPoint {
  { x, y, z, label: 0 }
}

pub fn graph_flow_mincut_point_x(pt : GraphflowmincutPoint) -> Double { pt.x }

pub fn graph_flow_mincut_point_y(pt : GraphflowmincutPoint) -> Double { pt.y }

pub fn graph_flow_mincut_point_z(pt : GraphflowmincutPoint) -> Double { pt.z }

pub fn graph_flow_mincut_point_label(pt : GraphflowmincutPoint) -> Int { pt.label }

pub fn graph_flow_mincut_point_dist(a : GraphflowmincutPoint, b : GraphflowmincutPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn graph_flow_mincut_point_add(a : GraphflowmincutPoint, b : GraphflowmincutPoint) -> GraphflowmincutPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn graph_flow_mincut_point_sub(a : GraphflowmincutPoint, b : GraphflowmincutPoint) -> GraphflowmincutPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn graph_flow_mincut_point_scale(pt : GraphflowmincutPoint, s : Double) -> GraphflowmincutPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn graph_flow_mincut_point_dot(a : GraphflowmincutPoint, b : GraphflowmincutPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn graph_flow_mincut_point_cross(a : GraphflowmincutPoint, b : GraphflowmincutPoint) -> GraphflowmincutPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn graph_flow_mincut_point_norm(pt : GraphflowmincutPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn graph_flow_mincut_point_normalize(pt : GraphflowmincutPoint) -> GraphflowmincutPoint {
  let n = graph_flow_mincut_point_norm(pt)
  if n < 0.0000001 { pt } else { graph_flow_mincut_point_scale(pt, 1.0 / n) }
}

pub fn graph_flow_mincut_point_negate(pt : GraphflowmincutPoint) -> GraphflowmincutPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn graph_flow_mincut_point_mid(a : GraphflowmincutPoint, b : GraphflowmincutPoint) -> GraphflowmincutPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn graph_flow_mincut_point_lerp(a : GraphflowmincutPoint, b : GraphflowmincutPoint, t : Double) -> GraphflowmincutPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn graph_flow_mincut_point_to_string(pt : GraphflowmincutPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct GraphflowmincutSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_flow_mincut_make_series(vals : Array[Double], name : String) -> GraphflowmincutSeries {
  { vals, name, meta: 0 }
}

pub fn graph_flow_mincut_series_len(s : GraphflowmincutSeries) -> Int { s.vals.length() }

pub fn graph_flow_mincut_series_sum(s : GraphflowmincutSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn graph_flow_mincut_series_mean(s : GraphflowmincutSeries) -> Double {
  let n = graph_flow_mincut_series_len(s)
  if n == 0 { 0.0 } else { graph_flow_mincut_series_sum(s) / n.to_double() }
}

pub fn graph_flow_mincut_series_min(s : GraphflowmincutSeries) -> Double {
  let n = graph_flow_mincut_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn graph_flow_mincut_series_max(s : GraphflowmincutSeries) -> Double {
  let n = graph_flow_mincut_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn graph_flow_mincut_series_range(s : GraphflowmincutSeries) -> Double {
  graph_flow_mincut_series_max(s) - graph_flow_mincut_series_min(s)
}

pub fn graph_flow_mincut_series_var(s : GraphflowmincutSeries) -> Double {
  let n = graph_flow_mincut_series_len(s)
  if n == 0 { 0.0 } else {
    let m = graph_flow_mincut_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn graph_flow_mincut_series_std(s : GraphflowmincutSeries) -> Double { @_common.sqrt(graph_flow_mincut_series_var(s)) }

pub fn graph_flow_mincut_series_median(s : GraphflowmincutSeries) -> Double {
  let n = graph_flow_mincut_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = graph_flow_mincut_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn graph_flow_mincut_series_scale(s : GraphflowmincutSeries, f : Double) -> GraphflowmincutSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn graph_flow_mincut_series_add(a : GraphflowmincutSeries, b : GraphflowmincutSeries) -> GraphflowmincutSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn graph_flow_mincut_series_sub(a : GraphflowmincutSeries, b : GraphflowmincutSeries) -> GraphflowmincutSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn graph_flow_mincut_series_normalize(s : GraphflowmincutSeries) -> GraphflowmincutSeries {
  let mn = graph_flow_mincut_series_min(s)
  let mx = graph_flow_mincut_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn graph_flow_mincut_series_cumsum(s : GraphflowmincutSeries) -> GraphflowmincutSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn graph_flow_mincut_series_to_string(s : GraphflowmincutSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphflowmincutMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_flow_mincut_make_matrix(rows : Int, cols : Int, val : Double) -> GraphflowmincutMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_flow_mincut_matrix_identity(n : Int) -> GraphflowmincutMatrix {
  let m = graph_flow_mincut_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn graph_flow_mincut_matrix_get(m : GraphflowmincutMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn graph_flow_mincut_matrix_transpose(m : GraphflowmincutMatrix) -> GraphflowmincutMatrix {
  let result = graph_flow_mincut_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn graph_flow_mincut_matrix_add(a : GraphflowmincutMatrix, b : GraphflowmincutMatrix) -> GraphflowmincutMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = graph_flow_mincut_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn graph_flow_mincut_matrix_scale(m : GraphflowmincutMatrix, s : Double) -> GraphflowmincutMatrix {
  let result = graph_flow_mincut_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn graph_flow_mincut_matrix_multiply(a : GraphflowmincutMatrix, b : GraphflowmincutMatrix) -> GraphflowmincutMatrix {
  if a.cols != b.rows { return graph_flow_mincut_make_matrix(a.rows, b.cols, 0.0) }
  let result = graph_flow_mincut_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn graph_flow_mincut_matrix_trace(m : GraphflowmincutMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn graph_flow_mincut_matrix_det(m : GraphflowmincutMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn graph_flow_mincut_matrix_norm(m : GraphflowmincutMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn graph_flow_mincut_matrix_to_string(m : GraphflowmincutMatrix) -> String {
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

pub(all) struct GraphflowmincutVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_flow_mincut_make_vector(comps : Array[Double]) -> GraphflowmincutVector {
  { comps, dim: comps.length() }
}

pub fn graph_flow_mincut_vector_zero(dim : Int) -> GraphflowmincutVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn graph_flow_mincut_vector_add(a : GraphflowmincutVector, b : GraphflowmincutVector) -> GraphflowmincutVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn graph_flow_mincut_vector_sub(a : GraphflowmincutVector, b : GraphflowmincutVector) -> GraphflowmincutVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn graph_flow_mincut_vector_scale(v : GraphflowmincutVector, s : Double) -> GraphflowmincutVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn graph_flow_mincut_vector_dot(a : GraphflowmincutVector, b : GraphflowmincutVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn graph_flow_mincut_vector_norm(v : GraphflowmincutVector) -> Double { @_common.sqrt(graph_flow_mincut_vector_dot(v, v)) }

pub fn graph_flow_mincut_vector_normalize(v : GraphflowmincutVector) -> GraphflowmincutVector {
  let n = graph_flow_mincut_vector_norm(v)
  if n < 0.0000001 { v } else { graph_flow_mincut_vector_scale(v, 1.0 / n) }
}

pub fn graph_flow_mincut_vector_dist(a : GraphflowmincutVector, b : GraphflowmincutVector) -> Double {
  graph_flow_mincut_vector_norm(graph_flow_mincut_vector_sub(a, b))
}

pub fn graph_flow_mincut_vector_to_string(v : GraphflowmincutVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_flow_mincut_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn graph_flow_mincut_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn graph_flow_mincut_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn graph_flow_mincut_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn graph_flow_mincut_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn graph_flow_mincut_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn graph_flow_mincut_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn graph_flow_mincut_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn graph_flow_mincut_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn graph_flow_mincut_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn graph_flow_mincut_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn graph_flow_mincut_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn graph_flow_mincut_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn graph_flow_mincut_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn graph_flow_mincut_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn graph_flow_mincut_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn graph_flow_mincut_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn graph_flow_mincut_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn graph_flow_mincut_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn graph_flow_mincut_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn graph_flow_mincut_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn graph_flow_mincut_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn graph_flow_mincut_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn graph_flow_mincut_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn graph_flow_mincut_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn graph_flow_mincut_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn graph_flow_mincut_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn graph_flow_mincut_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn graph_flow_mincut_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GraphflowmincutFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_mincut_frame_make(size : Int) -> GraphflowmincutFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_mincut_frame_len(s : GraphflowmincutFrame) -> Int { s.size }

pub fn graph_flow_mincut_frame_get(s : GraphflowmincutFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_mincut_frame_set(s : GraphflowmincutFrame, i : Int, v : Double) -> GraphflowmincutFrame {
  let result = graph_flow_mincut_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_mincut_frame_sum(s : GraphflowmincutFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_flow_mincut_frame_mean(s : GraphflowmincutFrame) -> Double {
  if s.size == 0 { 0.0 } else { graph_flow_mincut_frame_sum(s) / s.size.to_double() }
}

pub fn graph_flow_mincut_frame_scale(s : GraphflowmincutFrame, f : Double) -> GraphflowmincutFrame {
  let result = graph_flow_mincut_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_mincut_frame_add(a : GraphflowmincutFrame, b : GraphflowmincutFrame) -> GraphflowmincutFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_mincut_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_mincut_frame_copy(s : GraphflowmincutFrame) -> GraphflowmincutFrame {
  let result = graph_flow_mincut_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_mincut_frame_fill(s : GraphflowmincutFrame, v : Double) -> GraphflowmincutFrame {
  let result = graph_flow_mincut_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_mincut_frame_min(s : GraphflowmincutFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_mincut_frame_max(s : GraphflowmincutFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_mincut_frame_to_string(s : GraphflowmincutFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowmincutTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_mincut_table_make(size : Int) -> GraphflowmincutTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_mincut_table_len(s : GraphflowmincutTable) -> Int { s.size }

pub fn graph_flow_mincut_table_get(s : GraphflowmincutTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_mincut_table_set(s : GraphflowmincutTable, i : Int, v : Double) -> GraphflowmincutTable {
  let result = graph_flow_mincut_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_mincut_table_sum(s : GraphflowmincutTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_flow_mincut_table_mean(s : GraphflowmincutTable) -> Double {
  if s.size == 0 { 0.0 } else { graph_flow_mincut_table_sum(s) / s.size.to_double() }
}

pub fn graph_flow_mincut_table_scale(s : GraphflowmincutTable, f : Double) -> GraphflowmincutTable {
  let result = graph_flow_mincut_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_mincut_table_add(a : GraphflowmincutTable, b : GraphflowmincutTable) -> GraphflowmincutTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_mincut_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_mincut_table_copy(s : GraphflowmincutTable) -> GraphflowmincutTable {
  let result = graph_flow_mincut_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_mincut_table_fill(s : GraphflowmincutTable, v : Double) -> GraphflowmincutTable {
  let result = graph_flow_mincut_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_mincut_table_min(s : GraphflowmincutTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_mincut_table_max(s : GraphflowmincutTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_mincut_table_to_string(s : GraphflowmincutTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowmincutGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_mincut_graphn_make(size : Int) -> GraphflowmincutGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_mincut_graphn_len(s : GraphflowmincutGraphN) -> Int { s.size }

pub fn graph_flow_mincut_graphn_get(s : GraphflowmincutGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_mincut_graphn_set(s : GraphflowmincutGraphN, i : Int, v : Double) -> GraphflowmincutGraphN {
  let result = graph_flow_mincut_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_mincut_graphn_sum(s : GraphflowmincutGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_flow_mincut_graphn_mean(s : GraphflowmincutGraphN) -> Double {
  if s.size == 0 { 0.0 } else { graph_flow_mincut_graphn_sum(s) / s.size.to_double() }
}

pub fn graph_flow_mincut_graphn_scale(s : GraphflowmincutGraphN, f : Double) -> GraphflowmincutGraphN {
  let result = graph_flow_mincut_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_mincut_graphn_add(a : GraphflowmincutGraphN, b : GraphflowmincutGraphN) -> GraphflowmincutGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_mincut_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_mincut_graphn_copy(s : GraphflowmincutGraphN) -> GraphflowmincutGraphN {
  let result = graph_flow_mincut_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_mincut_graphn_fill(s : GraphflowmincutGraphN, v : Double) -> GraphflowmincutGraphN {
  let result = graph_flow_mincut_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_mincut_graphn_min(s : GraphflowmincutGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_mincut_graphn_max(s : GraphflowmincutGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_mincut_graphn_to_string(s : GraphflowmincutGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowmincutNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_mincut_node_make(size : Int) -> GraphflowmincutNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_mincut_node_len(s : GraphflowmincutNode) -> Int { s.size }

pub fn graph_flow_mincut_node_get(s : GraphflowmincutNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_mincut_node_set(s : GraphflowmincutNode, i : Int, v : Double) -> GraphflowmincutNode {
  let result = graph_flow_mincut_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_mincut_node_sum(s : GraphflowmincutNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_flow_mincut_node_mean(s : GraphflowmincutNode) -> Double {
  if s.size == 0 { 0.0 } else { graph_flow_mincut_node_sum(s) / s.size.to_double() }
}

pub fn graph_flow_mincut_node_scale(s : GraphflowmincutNode, f : Double) -> GraphflowmincutNode {
  let result = graph_flow_mincut_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_mincut_node_add(a : GraphflowmincutNode, b : GraphflowmincutNode) -> GraphflowmincutNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_mincut_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_mincut_node_copy(s : GraphflowmincutNode) -> GraphflowmincutNode {
  let result = graph_flow_mincut_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_mincut_node_fill(s : GraphflowmincutNode, v : Double) -> GraphflowmincutNode {
  let result = graph_flow_mincut_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_mincut_node_min(s : GraphflowmincutNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_mincut_node_max(s : GraphflowmincutNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_mincut_node_to_string(s : GraphflowmincutNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowmincutEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_mincut_edge_make(size : Int) -> GraphflowmincutEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_mincut_edge_len(s : GraphflowmincutEdge) -> Int { s.size }

pub fn graph_flow_mincut_edge_get(s : GraphflowmincutEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_mincut_edge_set(s : GraphflowmincutEdge, i : Int, v : Double) -> GraphflowmincutEdge {
  let result = graph_flow_mincut_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_mincut_edge_sum(s : GraphflowmincutEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_flow_mincut_edge_mean(s : GraphflowmincutEdge) -> Double {
  if s.size == 0 { 0.0 } else { graph_flow_mincut_edge_sum(s) / s.size.to_double() }
}

pub fn graph_flow_mincut_edge_scale(s : GraphflowmincutEdge, f : Double) -> GraphflowmincutEdge {
  let result = graph_flow_mincut_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_mincut_edge_add(a : GraphflowmincutEdge, b : GraphflowmincutEdge) -> GraphflowmincutEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_mincut_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_mincut_edge_copy(s : GraphflowmincutEdge) -> GraphflowmincutEdge {
  let result = graph_flow_mincut_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_mincut_edge_fill(s : GraphflowmincutEdge, v : Double) -> GraphflowmincutEdge {
  let result = graph_flow_mincut_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_mincut_edge_min(s : GraphflowmincutEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_mincut_edge_max(s : GraphflowmincutEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_mincut_edge_to_string(s : GraphflowmincutEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowmincutPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_mincut_path_make(size : Int) -> GraphflowmincutPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_mincut_path_len(s : GraphflowmincutPath) -> Int { s.size }

pub fn graph_flow_mincut_path_get(s : GraphflowmincutPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_mincut_path_set(s : GraphflowmincutPath, i : Int, v : Double) -> GraphflowmincutPath {
  let result = graph_flow_mincut_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_mincut_path_sum(s : GraphflowmincutPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_flow_mincut_path_mean(s : GraphflowmincutPath) -> Double {
  if s.size == 0 { 0.0 } else { graph_flow_mincut_path_sum(s) / s.size.to_double() }
}

pub fn graph_flow_mincut_path_scale(s : GraphflowmincutPath, f : Double) -> GraphflowmincutPath {
  let result = graph_flow_mincut_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_mincut_path_add(a : GraphflowmincutPath, b : GraphflowmincutPath) -> GraphflowmincutPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_mincut_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_mincut_path_copy(s : GraphflowmincutPath) -> GraphflowmincutPath {
  let result = graph_flow_mincut_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_mincut_path_fill(s : GraphflowmincutPath, v : Double) -> GraphflowmincutPath {
  let result = graph_flow_mincut_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_mincut_path_min(s : GraphflowmincutPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_mincut_path_max(s : GraphflowmincutPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_mincut_path_to_string(s : GraphflowmincutPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowmincutCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_mincut_cluster_make(size : Int) -> GraphflowmincutCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_mincut_cluster_len(s : GraphflowmincutCluster) -> Int { s.size }

pub fn graph_flow_mincut_cluster_get(s : GraphflowmincutCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_mincut_cluster_set(s : GraphflowmincutCluster, i : Int, v : Double) -> GraphflowmincutCluster {
  let result = graph_flow_mincut_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_mincut_cluster_sum(s : GraphflowmincutCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_flow_mincut_cluster_mean(s : GraphflowmincutCluster) -> Double {
  if s.size == 0 { 0.0 } else { graph_flow_mincut_cluster_sum(s) / s.size.to_double() }
}

pub fn graph_flow_mincut_cluster_scale(s : GraphflowmincutCluster, f : Double) -> GraphflowmincutCluster {
  let result = graph_flow_mincut_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_mincut_cluster_add(a : GraphflowmincutCluster, b : GraphflowmincutCluster) -> GraphflowmincutCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_mincut_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_mincut_cluster_copy(s : GraphflowmincutCluster) -> GraphflowmincutCluster {
  let result = graph_flow_mincut_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_mincut_cluster_fill(s : GraphflowmincutCluster, v : Double) -> GraphflowmincutCluster {
  let result = graph_flow_mincut_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_mincut_cluster_min(s : GraphflowmincutCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_mincut_cluster_max(s : GraphflowmincutCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_mincut_cluster_to_string(s : GraphflowmincutCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowmincutModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_mincut_model_make(size : Int) -> GraphflowmincutModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_mincut_model_len(s : GraphflowmincutModel) -> Int { s.size }

pub fn graph_flow_mincut_model_get(s : GraphflowmincutModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_mincut_model_set(s : GraphflowmincutModel, i : Int, v : Double) -> GraphflowmincutModel {
  let result = graph_flow_mincut_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_mincut_model_sum(s : GraphflowmincutModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_flow_mincut_model_mean(s : GraphflowmincutModel) -> Double {
  if s.size == 0 { 0.0 } else { graph_flow_mincut_model_sum(s) / s.size.to_double() }
}

pub fn graph_flow_mincut_model_scale(s : GraphflowmincutModel, f : Double) -> GraphflowmincutModel {
  let result = graph_flow_mincut_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_mincut_model_add(a : GraphflowmincutModel, b : GraphflowmincutModel) -> GraphflowmincutModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_mincut_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_mincut_model_copy(s : GraphflowmincutModel) -> GraphflowmincutModel {
  let result = graph_flow_mincut_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_mincut_model_fill(s : GraphflowmincutModel, v : Double) -> GraphflowmincutModel {
  let result = graph_flow_mincut_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_mincut_model_min(s : GraphflowmincutModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_mincut_model_max(s : GraphflowmincutModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_mincut_model_to_string(s : GraphflowmincutModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowmincutLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_mincut_layer_make(size : Int) -> GraphflowmincutLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_mincut_layer_len(s : GraphflowmincutLayer) -> Int { s.size }

pub fn graph_flow_mincut_layer_get(s : GraphflowmincutLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_mincut_layer_set(s : GraphflowmincutLayer, i : Int, v : Double) -> GraphflowmincutLayer {
  let result = graph_flow_mincut_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_mincut_layer_sum(s : GraphflowmincutLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_flow_mincut_layer_mean(s : GraphflowmincutLayer) -> Double {
  if s.size == 0 { 0.0 } else { graph_flow_mincut_layer_sum(s) / s.size.to_double() }
}

pub fn graph_flow_mincut_layer_scale(s : GraphflowmincutLayer, f : Double) -> GraphflowmincutLayer {
  let result = graph_flow_mincut_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_mincut_layer_add(a : GraphflowmincutLayer, b : GraphflowmincutLayer) -> GraphflowmincutLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_mincut_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_mincut_layer_copy(s : GraphflowmincutLayer) -> GraphflowmincutLayer {
  let result = graph_flow_mincut_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_mincut_layer_fill(s : GraphflowmincutLayer, v : Double) -> GraphflowmincutLayer {
  let result = graph_flow_mincut_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_mincut_layer_min(s : GraphflowmincutLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_mincut_layer_max(s : GraphflowmincutLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_mincut_layer_to_string(s : GraphflowmincutLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowmincutBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_mincut_buffer_make(size : Int) -> GraphflowmincutBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_mincut_buffer_len(s : GraphflowmincutBuffer) -> Int { s.size }

pub fn graph_flow_mincut_buffer_get(s : GraphflowmincutBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_mincut_buffer_set(s : GraphflowmincutBuffer, i : Int, v : Double) -> GraphflowmincutBuffer {
  let result = graph_flow_mincut_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_mincut_buffer_sum(s : GraphflowmincutBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_flow_mincut_buffer_mean(s : GraphflowmincutBuffer) -> Double {
  if s.size == 0 { 0.0 } else { graph_flow_mincut_buffer_sum(s) / s.size.to_double() }
}

pub fn graph_flow_mincut_buffer_scale(s : GraphflowmincutBuffer, f : Double) -> GraphflowmincutBuffer {
  let result = graph_flow_mincut_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_mincut_buffer_add(a : GraphflowmincutBuffer, b : GraphflowmincutBuffer) -> GraphflowmincutBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_mincut_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_mincut_buffer_copy(s : GraphflowmincutBuffer) -> GraphflowmincutBuffer {
  let result = graph_flow_mincut_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_mincut_buffer_fill(s : GraphflowmincutBuffer, v : Double) -> GraphflowmincutBuffer {
  let result = graph_flow_mincut_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_mincut_buffer_min(s : GraphflowmincutBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_mincut_buffer_max(s : GraphflowmincutBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_mincut_buffer_to_string(s : GraphflowmincutBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowmincutCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_mincut_cursor_make(size : Int) -> GraphflowmincutCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_mincut_cursor_len(s : GraphflowmincutCursor) -> Int { s.size }

pub fn graph_flow_mincut_cursor_get(s : GraphflowmincutCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_mincut_cursor_set(s : GraphflowmincutCursor, i : Int, v : Double) -> GraphflowmincutCursor {
  let result = graph_flow_mincut_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_mincut_cursor_sum(s : GraphflowmincutCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_flow_mincut_cursor_mean(s : GraphflowmincutCursor) -> Double {
  if s.size == 0 { 0.0 } else { graph_flow_mincut_cursor_sum(s) / s.size.to_double() }
}

pub fn graph_flow_mincut_cursor_scale(s : GraphflowmincutCursor, f : Double) -> GraphflowmincutCursor {
  let result = graph_flow_mincut_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_mincut_cursor_add(a : GraphflowmincutCursor, b : GraphflowmincutCursor) -> GraphflowmincutCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_mincut_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_mincut_cursor_copy(s : GraphflowmincutCursor) -> GraphflowmincutCursor {
  let result = graph_flow_mincut_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_mincut_cursor_fill(s : GraphflowmincutCursor, v : Double) -> GraphflowmincutCursor {
  let result = graph_flow_mincut_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_mincut_cursor_min(s : GraphflowmincutCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_mincut_cursor_max(s : GraphflowmincutCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_mincut_cursor_to_string(s : GraphflowmincutCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowmincutView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_mincut_view_make(size : Int) -> GraphflowmincutView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_mincut_view_len(s : GraphflowmincutView) -> Int { s.size }

pub fn graph_flow_mincut_view_get(s : GraphflowmincutView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_mincut_view_set(s : GraphflowmincutView, i : Int, v : Double) -> GraphflowmincutView {
  let result = graph_flow_mincut_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_mincut_view_sum(s : GraphflowmincutView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_flow_mincut_view_mean(s : GraphflowmincutView) -> Double {
  if s.size == 0 { 0.0 } else { graph_flow_mincut_view_sum(s) / s.size.to_double() }
}

pub fn graph_flow_mincut_view_scale(s : GraphflowmincutView, f : Double) -> GraphflowmincutView {
  let result = graph_flow_mincut_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_mincut_view_add(a : GraphflowmincutView, b : GraphflowmincutView) -> GraphflowmincutView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_mincut_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_mincut_view_copy(s : GraphflowmincutView) -> GraphflowmincutView {
  let result = graph_flow_mincut_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_mincut_view_fill(s : GraphflowmincutView, v : Double) -> GraphflowmincutView {
  let result = graph_flow_mincut_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_mincut_view_min(s : GraphflowmincutView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_mincut_view_max(s : GraphflowmincutView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_mincut_view_to_string(s : GraphflowmincutView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowmincutRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_mincut_range_make(size : Int) -> GraphflowmincutRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_mincut_range_len(s : GraphflowmincutRange) -> Int { s.size }

pub fn graph_flow_mincut_range_get(s : GraphflowmincutRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_mincut_range_set(s : GraphflowmincutRange, i : Int, v : Double) -> GraphflowmincutRange {
  let result = graph_flow_mincut_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_mincut_range_sum(s : GraphflowmincutRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_flow_mincut_range_mean(s : GraphflowmincutRange) -> Double {
  if s.size == 0 { 0.0 } else { graph_flow_mincut_range_sum(s) / s.size.to_double() }
}

pub fn graph_flow_mincut_range_scale(s : GraphflowmincutRange, f : Double) -> GraphflowmincutRange {
  let result = graph_flow_mincut_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_mincut_range_add(a : GraphflowmincutRange, b : GraphflowmincutRange) -> GraphflowmincutRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_mincut_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_mincut_range_copy(s : GraphflowmincutRange) -> GraphflowmincutRange {
  let result = graph_flow_mincut_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_mincut_range_fill(s : GraphflowmincutRange, v : Double) -> GraphflowmincutRange {
  let result = graph_flow_mincut_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_mincut_range_min(s : GraphflowmincutRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_mincut_range_max(s : GraphflowmincutRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_mincut_range_to_string(s : GraphflowmincutRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowmincutSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_mincut_slice_make(size : Int) -> GraphflowmincutSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_mincut_slice_len(s : GraphflowmincutSlice) -> Int { s.size }

pub fn graph_flow_mincut_slice_get(s : GraphflowmincutSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_mincut_slice_set(s : GraphflowmincutSlice, i : Int, v : Double) -> GraphflowmincutSlice {
  let result = graph_flow_mincut_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_mincut_slice_sum(s : GraphflowmincutSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_flow_mincut_slice_mean(s : GraphflowmincutSlice) -> Double {
  if s.size == 0 { 0.0 } else { graph_flow_mincut_slice_sum(s) / s.size.to_double() }
}

pub fn graph_flow_mincut_slice_scale(s : GraphflowmincutSlice, f : Double) -> GraphflowmincutSlice {
  let result = graph_flow_mincut_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_mincut_slice_add(a : GraphflowmincutSlice, b : GraphflowmincutSlice) -> GraphflowmincutSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_mincut_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_mincut_slice_copy(s : GraphflowmincutSlice) -> GraphflowmincutSlice {
  let result = graph_flow_mincut_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_mincut_slice_fill(s : GraphflowmincutSlice, v : Double) -> GraphflowmincutSlice {
  let result = graph_flow_mincut_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_mincut_slice_min(s : GraphflowmincutSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_mincut_slice_max(s : GraphflowmincutSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_mincut_slice_to_string(s : GraphflowmincutSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


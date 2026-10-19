///===
/// extcore/graph_flow_stable_marriage

pub(all) struct GraphflowstablemarriagePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_flow_stable_marriage_make_point(x : Double, y : Double) -> GraphflowstablemarriagePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_flow_stable_marriage_make_point3(x : Double, y : Double, z : Double) -> GraphflowstablemarriagePoint {
  { x, y, z, label: 0 }
}

pub fn graph_flow_stable_marriage_point_x(pt : GraphflowstablemarriagePoint) -> Double { pt.x }

pub fn graph_flow_stable_marriage_point_y(pt : GraphflowstablemarriagePoint) -> Double { pt.y }

pub fn graph_flow_stable_marriage_point_z(pt : GraphflowstablemarriagePoint) -> Double { pt.z }

pub fn graph_flow_stable_marriage_point_label(pt : GraphflowstablemarriagePoint) -> Int { pt.label }

pub fn graph_flow_stable_marriage_point_dist(a : GraphflowstablemarriagePoint, b : GraphflowstablemarriagePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn graph_flow_stable_marriage_point_add(a : GraphflowstablemarriagePoint, b : GraphflowstablemarriagePoint) -> GraphflowstablemarriagePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn graph_flow_stable_marriage_point_sub(a : GraphflowstablemarriagePoint, b : GraphflowstablemarriagePoint) -> GraphflowstablemarriagePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn graph_flow_stable_marriage_point_scale(pt : GraphflowstablemarriagePoint, s : Double) -> GraphflowstablemarriagePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn graph_flow_stable_marriage_point_dot(a : GraphflowstablemarriagePoint, b : GraphflowstablemarriagePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn graph_flow_stable_marriage_point_cross(a : GraphflowstablemarriagePoint, b : GraphflowstablemarriagePoint) -> GraphflowstablemarriagePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn graph_flow_stable_marriage_point_norm(pt : GraphflowstablemarriagePoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn graph_flow_stable_marriage_point_normalize(pt : GraphflowstablemarriagePoint) -> GraphflowstablemarriagePoint {
  let n = graph_flow_stable_marriage_point_norm(pt)
  if n < 0.0000001 { pt } else { graph_flow_stable_marriage_point_scale(pt, 1.0 / n) }
}

pub fn graph_flow_stable_marriage_point_negate(pt : GraphflowstablemarriagePoint) -> GraphflowstablemarriagePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn graph_flow_stable_marriage_point_mid(a : GraphflowstablemarriagePoint, b : GraphflowstablemarriagePoint) -> GraphflowstablemarriagePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn graph_flow_stable_marriage_point_lerp(a : GraphflowstablemarriagePoint, b : GraphflowstablemarriagePoint, t : Double) -> GraphflowstablemarriagePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn graph_flow_stable_marriage_point_to_string(pt : GraphflowstablemarriagePoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct GraphflowstablemarriageSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_flow_stable_marriage_make_series(vals : Array[Double], name : String) -> GraphflowstablemarriageSeries {
  { vals, name, meta: 0 }
}

pub fn graph_flow_stable_marriage_series_len(s : GraphflowstablemarriageSeries) -> Int { s.vals.length() }

pub fn graph_flow_stable_marriage_series_sum(s : GraphflowstablemarriageSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn graph_flow_stable_marriage_series_mean(s : GraphflowstablemarriageSeries) -> Double {
  let n = graph_flow_stable_marriage_series_len(s)
  if n == 0 { 0.0 } else { graph_flow_stable_marriage_series_sum(s) / n.to_double() }
}

pub fn graph_flow_stable_marriage_series_min(s : GraphflowstablemarriageSeries) -> Double {
  let n = graph_flow_stable_marriage_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn graph_flow_stable_marriage_series_max(s : GraphflowstablemarriageSeries) -> Double {
  let n = graph_flow_stable_marriage_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn graph_flow_stable_marriage_series_range(s : GraphflowstablemarriageSeries) -> Double {
  graph_flow_stable_marriage_series_max(s) - graph_flow_stable_marriage_series_min(s)
}

pub fn graph_flow_stable_marriage_series_var(s : GraphflowstablemarriageSeries) -> Double {
  let n = graph_flow_stable_marriage_series_len(s)
  if n == 0 { 0.0 } else {
    let m = graph_flow_stable_marriage_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn graph_flow_stable_marriage_series_std(s : GraphflowstablemarriageSeries) -> Double { @_common.sqrt(graph_flow_stable_marriage_series_var(s)) }

pub fn graph_flow_stable_marriage_series_median(s : GraphflowstablemarriageSeries) -> Double {
  let n = graph_flow_stable_marriage_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = graph_flow_stable_marriage_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn graph_flow_stable_marriage_series_scale(s : GraphflowstablemarriageSeries, f : Double) -> GraphflowstablemarriageSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn graph_flow_stable_marriage_series_add(a : GraphflowstablemarriageSeries, b : GraphflowstablemarriageSeries) -> GraphflowstablemarriageSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn graph_flow_stable_marriage_series_sub(a : GraphflowstablemarriageSeries, b : GraphflowstablemarriageSeries) -> GraphflowstablemarriageSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn graph_flow_stable_marriage_series_normalize(s : GraphflowstablemarriageSeries) -> GraphflowstablemarriageSeries {
  let mn = graph_flow_stable_marriage_series_min(s)
  let mx = graph_flow_stable_marriage_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn graph_flow_stable_marriage_series_cumsum(s : GraphflowstablemarriageSeries) -> GraphflowstablemarriageSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn graph_flow_stable_marriage_series_to_string(s : GraphflowstablemarriageSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphflowstablemarriageMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_flow_stable_marriage_make_matrix(rows : Int, cols : Int, val : Double) -> GraphflowstablemarriageMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_flow_stable_marriage_matrix_identity(n : Int) -> GraphflowstablemarriageMatrix {
  let m = graph_flow_stable_marriage_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn graph_flow_stable_marriage_matrix_get(m : GraphflowstablemarriageMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn graph_flow_stable_marriage_matrix_transpose(m : GraphflowstablemarriageMatrix) -> GraphflowstablemarriageMatrix {
  let result = graph_flow_stable_marriage_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn graph_flow_stable_marriage_matrix_add(a : GraphflowstablemarriageMatrix, b : GraphflowstablemarriageMatrix) -> GraphflowstablemarriageMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = graph_flow_stable_marriage_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn graph_flow_stable_marriage_matrix_scale(m : GraphflowstablemarriageMatrix, s : Double) -> GraphflowstablemarriageMatrix {
  let result = graph_flow_stable_marriage_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn graph_flow_stable_marriage_matrix_multiply(a : GraphflowstablemarriageMatrix, b : GraphflowstablemarriageMatrix) -> GraphflowstablemarriageMatrix {
  if a.cols != b.rows { return graph_flow_stable_marriage_make_matrix(a.rows, b.cols, 0.0) }
  let result = graph_flow_stable_marriage_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn graph_flow_stable_marriage_matrix_trace(m : GraphflowstablemarriageMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn graph_flow_stable_marriage_matrix_det(m : GraphflowstablemarriageMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn graph_flow_stable_marriage_matrix_norm(m : GraphflowstablemarriageMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn graph_flow_stable_marriage_matrix_to_string(m : GraphflowstablemarriageMatrix) -> String {
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

pub(all) struct GraphflowstablemarriageVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_flow_stable_marriage_make_vector(comps : Array[Double]) -> GraphflowstablemarriageVector {
  { comps, dim: comps.length() }
}

pub fn graph_flow_stable_marriage_vector_zero(dim : Int) -> GraphflowstablemarriageVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn graph_flow_stable_marriage_vector_add(a : GraphflowstablemarriageVector, b : GraphflowstablemarriageVector) -> GraphflowstablemarriageVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn graph_flow_stable_marriage_vector_sub(a : GraphflowstablemarriageVector, b : GraphflowstablemarriageVector) -> GraphflowstablemarriageVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn graph_flow_stable_marriage_vector_scale(v : GraphflowstablemarriageVector, s : Double) -> GraphflowstablemarriageVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn graph_flow_stable_marriage_vector_dot(a : GraphflowstablemarriageVector, b : GraphflowstablemarriageVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn graph_flow_stable_marriage_vector_norm(v : GraphflowstablemarriageVector) -> Double { @_common.sqrt(graph_flow_stable_marriage_vector_dot(v, v)) }

pub fn graph_flow_stable_marriage_vector_normalize(v : GraphflowstablemarriageVector) -> GraphflowstablemarriageVector {
  let n = graph_flow_stable_marriage_vector_norm(v)
  if n < 0.0000001 { v } else { graph_flow_stable_marriage_vector_scale(v, 1.0 / n) }
}

pub fn graph_flow_stable_marriage_vector_dist(a : GraphflowstablemarriageVector, b : GraphflowstablemarriageVector) -> Double {
  graph_flow_stable_marriage_vector_norm(graph_flow_stable_marriage_vector_sub(a, b))
}

pub fn graph_flow_stable_marriage_vector_to_string(v : GraphflowstablemarriageVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_flow_stable_marriage_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn graph_flow_stable_marriage_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn graph_flow_stable_marriage_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn graph_flow_stable_marriage_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn graph_flow_stable_marriage_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn graph_flow_stable_marriage_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn graph_flow_stable_marriage_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn graph_flow_stable_marriage_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn graph_flow_stable_marriage_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn graph_flow_stable_marriage_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn graph_flow_stable_marriage_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn graph_flow_stable_marriage_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn graph_flow_stable_marriage_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn graph_flow_stable_marriage_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn graph_flow_stable_marriage_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn graph_flow_stable_marriage_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn graph_flow_stable_marriage_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn graph_flow_stable_marriage_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn graph_flow_stable_marriage_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn graph_flow_stable_marriage_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn graph_flow_stable_marriage_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn graph_flow_stable_marriage_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn graph_flow_stable_marriage_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn graph_flow_stable_marriage_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn graph_flow_stable_marriage_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn graph_flow_stable_marriage_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn graph_flow_stable_marriage_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn graph_flow_stable_marriage_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn graph_flow_stable_marriage_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GraphflowstablemarriageFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_stable_marriage_frame_make(size : Int) -> GraphflowstablemarriageFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_stable_marriage_frame_len(s : GraphflowstablemarriageFrame) -> Int { s.size }

pub fn graph_flow_stable_marriage_frame_get(s : GraphflowstablemarriageFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_stable_marriage_frame_set(s : GraphflowstablemarriageFrame, i : Int, v : Double) -> GraphflowstablemarriageFrame {
  let result = graph_flow_stable_marriage_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_stable_marriage_frame_sum(s : GraphflowstablemarriageFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_flow_stable_marriage_frame_mean(s : GraphflowstablemarriageFrame) -> Double {
  if s.size == 0 { 0.0 } else { graph_flow_stable_marriage_frame_sum(s) / s.size.to_double() }
}

pub fn graph_flow_stable_marriage_frame_scale(s : GraphflowstablemarriageFrame, f : Double) -> GraphflowstablemarriageFrame {
  let result = graph_flow_stable_marriage_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_stable_marriage_frame_add(a : GraphflowstablemarriageFrame, b : GraphflowstablemarriageFrame) -> GraphflowstablemarriageFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_stable_marriage_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_stable_marriage_frame_copy(s : GraphflowstablemarriageFrame) -> GraphflowstablemarriageFrame {
  let result = graph_flow_stable_marriage_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_stable_marriage_frame_fill(s : GraphflowstablemarriageFrame, v : Double) -> GraphflowstablemarriageFrame {
  let result = graph_flow_stable_marriage_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_stable_marriage_frame_min(s : GraphflowstablemarriageFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_stable_marriage_frame_max(s : GraphflowstablemarriageFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_stable_marriage_frame_to_string(s : GraphflowstablemarriageFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowstablemarriageTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_stable_marriage_table_make(size : Int) -> GraphflowstablemarriageTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_stable_marriage_table_len(s : GraphflowstablemarriageTable) -> Int { s.size }

pub fn graph_flow_stable_marriage_table_get(s : GraphflowstablemarriageTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_stable_marriage_table_set(s : GraphflowstablemarriageTable, i : Int, v : Double) -> GraphflowstablemarriageTable {
  let result = graph_flow_stable_marriage_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_stable_marriage_table_sum(s : GraphflowstablemarriageTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_flow_stable_marriage_table_mean(s : GraphflowstablemarriageTable) -> Double {
  if s.size == 0 { 0.0 } else { graph_flow_stable_marriage_table_sum(s) / s.size.to_double() }
}

pub fn graph_flow_stable_marriage_table_scale(s : GraphflowstablemarriageTable, f : Double) -> GraphflowstablemarriageTable {
  let result = graph_flow_stable_marriage_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_stable_marriage_table_add(a : GraphflowstablemarriageTable, b : GraphflowstablemarriageTable) -> GraphflowstablemarriageTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_stable_marriage_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_stable_marriage_table_copy(s : GraphflowstablemarriageTable) -> GraphflowstablemarriageTable {
  let result = graph_flow_stable_marriage_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_stable_marriage_table_fill(s : GraphflowstablemarriageTable, v : Double) -> GraphflowstablemarriageTable {
  let result = graph_flow_stable_marriage_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_stable_marriage_table_min(s : GraphflowstablemarriageTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_stable_marriage_table_max(s : GraphflowstablemarriageTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_stable_marriage_table_to_string(s : GraphflowstablemarriageTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowstablemarriageGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_stable_marriage_graphn_make(size : Int) -> GraphflowstablemarriageGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_stable_marriage_graphn_len(s : GraphflowstablemarriageGraphN) -> Int { s.size }

pub fn graph_flow_stable_marriage_graphn_get(s : GraphflowstablemarriageGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_stable_marriage_graphn_set(s : GraphflowstablemarriageGraphN, i : Int, v : Double) -> GraphflowstablemarriageGraphN {
  let result = graph_flow_stable_marriage_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_stable_marriage_graphn_sum(s : GraphflowstablemarriageGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_flow_stable_marriage_graphn_mean(s : GraphflowstablemarriageGraphN) -> Double {
  if s.size == 0 { 0.0 } else { graph_flow_stable_marriage_graphn_sum(s) / s.size.to_double() }
}

pub fn graph_flow_stable_marriage_graphn_scale(s : GraphflowstablemarriageGraphN, f : Double) -> GraphflowstablemarriageGraphN {
  let result = graph_flow_stable_marriage_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_stable_marriage_graphn_add(a : GraphflowstablemarriageGraphN, b : GraphflowstablemarriageGraphN) -> GraphflowstablemarriageGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_stable_marriage_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_stable_marriage_graphn_copy(s : GraphflowstablemarriageGraphN) -> GraphflowstablemarriageGraphN {
  let result = graph_flow_stable_marriage_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_stable_marriage_graphn_fill(s : GraphflowstablemarriageGraphN, v : Double) -> GraphflowstablemarriageGraphN {
  let result = graph_flow_stable_marriage_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_stable_marriage_graphn_min(s : GraphflowstablemarriageGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_stable_marriage_graphn_max(s : GraphflowstablemarriageGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_stable_marriage_graphn_to_string(s : GraphflowstablemarriageGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowstablemarriageNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_stable_marriage_node_make(size : Int) -> GraphflowstablemarriageNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_stable_marriage_node_len(s : GraphflowstablemarriageNode) -> Int { s.size }

pub fn graph_flow_stable_marriage_node_get(s : GraphflowstablemarriageNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_stable_marriage_node_set(s : GraphflowstablemarriageNode, i : Int, v : Double) -> GraphflowstablemarriageNode {
  let result = graph_flow_stable_marriage_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_stable_marriage_node_sum(s : GraphflowstablemarriageNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_flow_stable_marriage_node_mean(s : GraphflowstablemarriageNode) -> Double {
  if s.size == 0 { 0.0 } else { graph_flow_stable_marriage_node_sum(s) / s.size.to_double() }
}

pub fn graph_flow_stable_marriage_node_scale(s : GraphflowstablemarriageNode, f : Double) -> GraphflowstablemarriageNode {
  let result = graph_flow_stable_marriage_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_stable_marriage_node_add(a : GraphflowstablemarriageNode, b : GraphflowstablemarriageNode) -> GraphflowstablemarriageNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_stable_marriage_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_stable_marriage_node_copy(s : GraphflowstablemarriageNode) -> GraphflowstablemarriageNode {
  let result = graph_flow_stable_marriage_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_stable_marriage_node_fill(s : GraphflowstablemarriageNode, v : Double) -> GraphflowstablemarriageNode {
  let result = graph_flow_stable_marriage_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_stable_marriage_node_min(s : GraphflowstablemarriageNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_stable_marriage_node_max(s : GraphflowstablemarriageNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_stable_marriage_node_to_string(s : GraphflowstablemarriageNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowstablemarriageEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_stable_marriage_edge_make(size : Int) -> GraphflowstablemarriageEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_stable_marriage_edge_len(s : GraphflowstablemarriageEdge) -> Int { s.size }

pub fn graph_flow_stable_marriage_edge_get(s : GraphflowstablemarriageEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_stable_marriage_edge_set(s : GraphflowstablemarriageEdge, i : Int, v : Double) -> GraphflowstablemarriageEdge {
  let result = graph_flow_stable_marriage_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_stable_marriage_edge_sum(s : GraphflowstablemarriageEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_flow_stable_marriage_edge_mean(s : GraphflowstablemarriageEdge) -> Double {
  if s.size == 0 { 0.0 } else { graph_flow_stable_marriage_edge_sum(s) / s.size.to_double() }
}

pub fn graph_flow_stable_marriage_edge_scale(s : GraphflowstablemarriageEdge, f : Double) -> GraphflowstablemarriageEdge {
  let result = graph_flow_stable_marriage_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_stable_marriage_edge_add(a : GraphflowstablemarriageEdge, b : GraphflowstablemarriageEdge) -> GraphflowstablemarriageEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_stable_marriage_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_stable_marriage_edge_copy(s : GraphflowstablemarriageEdge) -> GraphflowstablemarriageEdge {
  let result = graph_flow_stable_marriage_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_stable_marriage_edge_fill(s : GraphflowstablemarriageEdge, v : Double) -> GraphflowstablemarriageEdge {
  let result = graph_flow_stable_marriage_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_stable_marriage_edge_min(s : GraphflowstablemarriageEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_stable_marriage_edge_max(s : GraphflowstablemarriageEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_stable_marriage_edge_to_string(s : GraphflowstablemarriageEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowstablemarriagePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_stable_marriage_path_make(size : Int) -> GraphflowstablemarriagePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_stable_marriage_path_len(s : GraphflowstablemarriagePath) -> Int { s.size }

pub fn graph_flow_stable_marriage_path_get(s : GraphflowstablemarriagePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_stable_marriage_path_set(s : GraphflowstablemarriagePath, i : Int, v : Double) -> GraphflowstablemarriagePath {
  let result = graph_flow_stable_marriage_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_stable_marriage_path_sum(s : GraphflowstablemarriagePath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_flow_stable_marriage_path_mean(s : GraphflowstablemarriagePath) -> Double {
  if s.size == 0 { 0.0 } else { graph_flow_stable_marriage_path_sum(s) / s.size.to_double() }
}

pub fn graph_flow_stable_marriage_path_scale(s : GraphflowstablemarriagePath, f : Double) -> GraphflowstablemarriagePath {
  let result = graph_flow_stable_marriage_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_stable_marriage_path_add(a : GraphflowstablemarriagePath, b : GraphflowstablemarriagePath) -> GraphflowstablemarriagePath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_stable_marriage_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_stable_marriage_path_copy(s : GraphflowstablemarriagePath) -> GraphflowstablemarriagePath {
  let result = graph_flow_stable_marriage_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_stable_marriage_path_fill(s : GraphflowstablemarriagePath, v : Double) -> GraphflowstablemarriagePath {
  let result = graph_flow_stable_marriage_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_stable_marriage_path_min(s : GraphflowstablemarriagePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_stable_marriage_path_max(s : GraphflowstablemarriagePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_stable_marriage_path_to_string(s : GraphflowstablemarriagePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowstablemarriageCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_stable_marriage_cluster_make(size : Int) -> GraphflowstablemarriageCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_stable_marriage_cluster_len(s : GraphflowstablemarriageCluster) -> Int { s.size }

pub fn graph_flow_stable_marriage_cluster_get(s : GraphflowstablemarriageCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_stable_marriage_cluster_set(s : GraphflowstablemarriageCluster, i : Int, v : Double) -> GraphflowstablemarriageCluster {
  let result = graph_flow_stable_marriage_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_stable_marriage_cluster_sum(s : GraphflowstablemarriageCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_flow_stable_marriage_cluster_mean(s : GraphflowstablemarriageCluster) -> Double {
  if s.size == 0 { 0.0 } else { graph_flow_stable_marriage_cluster_sum(s) / s.size.to_double() }
}

pub fn graph_flow_stable_marriage_cluster_scale(s : GraphflowstablemarriageCluster, f : Double) -> GraphflowstablemarriageCluster {
  let result = graph_flow_stable_marriage_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_stable_marriage_cluster_add(a : GraphflowstablemarriageCluster, b : GraphflowstablemarriageCluster) -> GraphflowstablemarriageCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_stable_marriage_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_stable_marriage_cluster_copy(s : GraphflowstablemarriageCluster) -> GraphflowstablemarriageCluster {
  let result = graph_flow_stable_marriage_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_stable_marriage_cluster_fill(s : GraphflowstablemarriageCluster, v : Double) -> GraphflowstablemarriageCluster {
  let result = graph_flow_stable_marriage_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_stable_marriage_cluster_min(s : GraphflowstablemarriageCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_stable_marriage_cluster_max(s : GraphflowstablemarriageCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_stable_marriage_cluster_to_string(s : GraphflowstablemarriageCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowstablemarriageModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_stable_marriage_model_make(size : Int) -> GraphflowstablemarriageModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_stable_marriage_model_len(s : GraphflowstablemarriageModel) -> Int { s.size }

pub fn graph_flow_stable_marriage_model_get(s : GraphflowstablemarriageModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_stable_marriage_model_set(s : GraphflowstablemarriageModel, i : Int, v : Double) -> GraphflowstablemarriageModel {
  let result = graph_flow_stable_marriage_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_stable_marriage_model_sum(s : GraphflowstablemarriageModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_flow_stable_marriage_model_mean(s : GraphflowstablemarriageModel) -> Double {
  if s.size == 0 { 0.0 } else { graph_flow_stable_marriage_model_sum(s) / s.size.to_double() }
}

pub fn graph_flow_stable_marriage_model_scale(s : GraphflowstablemarriageModel, f : Double) -> GraphflowstablemarriageModel {
  let result = graph_flow_stable_marriage_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_stable_marriage_model_add(a : GraphflowstablemarriageModel, b : GraphflowstablemarriageModel) -> GraphflowstablemarriageModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_stable_marriage_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_stable_marriage_model_copy(s : GraphflowstablemarriageModel) -> GraphflowstablemarriageModel {
  let result = graph_flow_stable_marriage_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_stable_marriage_model_fill(s : GraphflowstablemarriageModel, v : Double) -> GraphflowstablemarriageModel {
  let result = graph_flow_stable_marriage_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_stable_marriage_model_min(s : GraphflowstablemarriageModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_stable_marriage_model_max(s : GraphflowstablemarriageModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_stable_marriage_model_to_string(s : GraphflowstablemarriageModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowstablemarriageLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_stable_marriage_layer_make(size : Int) -> GraphflowstablemarriageLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_stable_marriage_layer_len(s : GraphflowstablemarriageLayer) -> Int { s.size }

pub fn graph_flow_stable_marriage_layer_get(s : GraphflowstablemarriageLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_stable_marriage_layer_set(s : GraphflowstablemarriageLayer, i : Int, v : Double) -> GraphflowstablemarriageLayer {
  let result = graph_flow_stable_marriage_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_stable_marriage_layer_sum(s : GraphflowstablemarriageLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_flow_stable_marriage_layer_mean(s : GraphflowstablemarriageLayer) -> Double {
  if s.size == 0 { 0.0 } else { graph_flow_stable_marriage_layer_sum(s) / s.size.to_double() }
}

pub fn graph_flow_stable_marriage_layer_scale(s : GraphflowstablemarriageLayer, f : Double) -> GraphflowstablemarriageLayer {
  let result = graph_flow_stable_marriage_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_stable_marriage_layer_add(a : GraphflowstablemarriageLayer, b : GraphflowstablemarriageLayer) -> GraphflowstablemarriageLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_stable_marriage_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_stable_marriage_layer_copy(s : GraphflowstablemarriageLayer) -> GraphflowstablemarriageLayer {
  let result = graph_flow_stable_marriage_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_stable_marriage_layer_fill(s : GraphflowstablemarriageLayer, v : Double) -> GraphflowstablemarriageLayer {
  let result = graph_flow_stable_marriage_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_stable_marriage_layer_min(s : GraphflowstablemarriageLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_stable_marriage_layer_max(s : GraphflowstablemarriageLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_stable_marriage_layer_to_string(s : GraphflowstablemarriageLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowstablemarriageBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_stable_marriage_buffer_make(size : Int) -> GraphflowstablemarriageBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_stable_marriage_buffer_len(s : GraphflowstablemarriageBuffer) -> Int { s.size }

pub fn graph_flow_stable_marriage_buffer_get(s : GraphflowstablemarriageBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_stable_marriage_buffer_set(s : GraphflowstablemarriageBuffer, i : Int, v : Double) -> GraphflowstablemarriageBuffer {
  let result = graph_flow_stable_marriage_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_stable_marriage_buffer_sum(s : GraphflowstablemarriageBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_flow_stable_marriage_buffer_mean(s : GraphflowstablemarriageBuffer) -> Double {
  if s.size == 0 { 0.0 } else { graph_flow_stable_marriage_buffer_sum(s) / s.size.to_double() }
}

pub fn graph_flow_stable_marriage_buffer_scale(s : GraphflowstablemarriageBuffer, f : Double) -> GraphflowstablemarriageBuffer {
  let result = graph_flow_stable_marriage_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_stable_marriage_buffer_add(a : GraphflowstablemarriageBuffer, b : GraphflowstablemarriageBuffer) -> GraphflowstablemarriageBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_stable_marriage_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_stable_marriage_buffer_copy(s : GraphflowstablemarriageBuffer) -> GraphflowstablemarriageBuffer {
  let result = graph_flow_stable_marriage_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_stable_marriage_buffer_fill(s : GraphflowstablemarriageBuffer, v : Double) -> GraphflowstablemarriageBuffer {
  let result = graph_flow_stable_marriage_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_stable_marriage_buffer_min(s : GraphflowstablemarriageBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_stable_marriage_buffer_max(s : GraphflowstablemarriageBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_stable_marriage_buffer_to_string(s : GraphflowstablemarriageBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowstablemarriageCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_stable_marriage_cursor_make(size : Int) -> GraphflowstablemarriageCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_stable_marriage_cursor_len(s : GraphflowstablemarriageCursor) -> Int { s.size }

pub fn graph_flow_stable_marriage_cursor_get(s : GraphflowstablemarriageCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_stable_marriage_cursor_set(s : GraphflowstablemarriageCursor, i : Int, v : Double) -> GraphflowstablemarriageCursor {
  let result = graph_flow_stable_marriage_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_stable_marriage_cursor_sum(s : GraphflowstablemarriageCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_flow_stable_marriage_cursor_mean(s : GraphflowstablemarriageCursor) -> Double {
  if s.size == 0 { 0.0 } else { graph_flow_stable_marriage_cursor_sum(s) / s.size.to_double() }
}

pub fn graph_flow_stable_marriage_cursor_scale(s : GraphflowstablemarriageCursor, f : Double) -> GraphflowstablemarriageCursor {
  let result = graph_flow_stable_marriage_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_stable_marriage_cursor_add(a : GraphflowstablemarriageCursor, b : GraphflowstablemarriageCursor) -> GraphflowstablemarriageCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_stable_marriage_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_stable_marriage_cursor_copy(s : GraphflowstablemarriageCursor) -> GraphflowstablemarriageCursor {
  let result = graph_flow_stable_marriage_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_stable_marriage_cursor_fill(s : GraphflowstablemarriageCursor, v : Double) -> GraphflowstablemarriageCursor {
  let result = graph_flow_stable_marriage_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_stable_marriage_cursor_min(s : GraphflowstablemarriageCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_stable_marriage_cursor_max(s : GraphflowstablemarriageCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_stable_marriage_cursor_to_string(s : GraphflowstablemarriageCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowstablemarriageView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_stable_marriage_view_make(size : Int) -> GraphflowstablemarriageView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_stable_marriage_view_len(s : GraphflowstablemarriageView) -> Int { s.size }

pub fn graph_flow_stable_marriage_view_get(s : GraphflowstablemarriageView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_stable_marriage_view_set(s : GraphflowstablemarriageView, i : Int, v : Double) -> GraphflowstablemarriageView {
  let result = graph_flow_stable_marriage_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_stable_marriage_view_sum(s : GraphflowstablemarriageView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_flow_stable_marriage_view_mean(s : GraphflowstablemarriageView) -> Double {
  if s.size == 0 { 0.0 } else { graph_flow_stable_marriage_view_sum(s) / s.size.to_double() }
}

pub fn graph_flow_stable_marriage_view_scale(s : GraphflowstablemarriageView, f : Double) -> GraphflowstablemarriageView {
  let result = graph_flow_stable_marriage_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_stable_marriage_view_add(a : GraphflowstablemarriageView, b : GraphflowstablemarriageView) -> GraphflowstablemarriageView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_stable_marriage_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_stable_marriage_view_copy(s : GraphflowstablemarriageView) -> GraphflowstablemarriageView {
  let result = graph_flow_stable_marriage_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_stable_marriage_view_fill(s : GraphflowstablemarriageView, v : Double) -> GraphflowstablemarriageView {
  let result = graph_flow_stable_marriage_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_stable_marriage_view_min(s : GraphflowstablemarriageView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_stable_marriage_view_max(s : GraphflowstablemarriageView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_stable_marriage_view_to_string(s : GraphflowstablemarriageView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowstablemarriageRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_stable_marriage_range_make(size : Int) -> GraphflowstablemarriageRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_stable_marriage_range_len(s : GraphflowstablemarriageRange) -> Int { s.size }

pub fn graph_flow_stable_marriage_range_get(s : GraphflowstablemarriageRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_stable_marriage_range_set(s : GraphflowstablemarriageRange, i : Int, v : Double) -> GraphflowstablemarriageRange {
  let result = graph_flow_stable_marriage_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_stable_marriage_range_sum(s : GraphflowstablemarriageRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_flow_stable_marriage_range_mean(s : GraphflowstablemarriageRange) -> Double {
  if s.size == 0 { 0.0 } else { graph_flow_stable_marriage_range_sum(s) / s.size.to_double() }
}

pub fn graph_flow_stable_marriage_range_scale(s : GraphflowstablemarriageRange, f : Double) -> GraphflowstablemarriageRange {
  let result = graph_flow_stable_marriage_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_stable_marriage_range_add(a : GraphflowstablemarriageRange, b : GraphflowstablemarriageRange) -> GraphflowstablemarriageRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_stable_marriage_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_stable_marriage_range_copy(s : GraphflowstablemarriageRange) -> GraphflowstablemarriageRange {
  let result = graph_flow_stable_marriage_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_stable_marriage_range_fill(s : GraphflowstablemarriageRange, v : Double) -> GraphflowstablemarriageRange {
  let result = graph_flow_stable_marriage_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_stable_marriage_range_min(s : GraphflowstablemarriageRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_stable_marriage_range_max(s : GraphflowstablemarriageRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_stable_marriage_range_to_string(s : GraphflowstablemarriageRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowstablemarriageSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_stable_marriage_slice_make(size : Int) -> GraphflowstablemarriageSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_stable_marriage_slice_len(s : GraphflowstablemarriageSlice) -> Int { s.size }

pub fn graph_flow_stable_marriage_slice_get(s : GraphflowstablemarriageSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_stable_marriage_slice_set(s : GraphflowstablemarriageSlice, i : Int, v : Double) -> GraphflowstablemarriageSlice {
  let result = graph_flow_stable_marriage_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_stable_marriage_slice_sum(s : GraphflowstablemarriageSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_flow_stable_marriage_slice_mean(s : GraphflowstablemarriageSlice) -> Double {
  if s.size == 0 { 0.0 } else { graph_flow_stable_marriage_slice_sum(s) / s.size.to_double() }
}

pub fn graph_flow_stable_marriage_slice_scale(s : GraphflowstablemarriageSlice, f : Double) -> GraphflowstablemarriageSlice {
  let result = graph_flow_stable_marriage_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_stable_marriage_slice_add(a : GraphflowstablemarriageSlice, b : GraphflowstablemarriageSlice) -> GraphflowstablemarriageSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_stable_marriage_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_stable_marriage_slice_copy(s : GraphflowstablemarriageSlice) -> GraphflowstablemarriageSlice {
  let result = graph_flow_stable_marriage_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_stable_marriage_slice_fill(s : GraphflowstablemarriageSlice, v : Double) -> GraphflowstablemarriageSlice {
  let result = graph_flow_stable_marriage_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_stable_marriage_slice_min(s : GraphflowstablemarriageSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_stable_marriage_slice_max(s : GraphflowstablemarriageSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_stable_marriage_slice_to_string(s : GraphflowstablemarriageSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


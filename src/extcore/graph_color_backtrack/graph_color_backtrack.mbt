///===
/// extcore/graph_color_backtrack

pub(all) struct GraphcolorbacktrackPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_color_backtrack_make_point(x : Double, y : Double) -> GraphcolorbacktrackPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_color_backtrack_make_point3(x : Double, y : Double, z : Double) -> GraphcolorbacktrackPoint {
  { x, y, z, label: 0 }
}

pub fn graph_color_backtrack_point_x(pt : GraphcolorbacktrackPoint) -> Double { pt.x }

pub fn graph_color_backtrack_point_y(pt : GraphcolorbacktrackPoint) -> Double { pt.y }

pub fn graph_color_backtrack_point_z(pt : GraphcolorbacktrackPoint) -> Double { pt.z }

pub fn graph_color_backtrack_point_label(pt : GraphcolorbacktrackPoint) -> Int { pt.label }

pub fn graph_color_backtrack_point_dist(a : GraphcolorbacktrackPoint, b : GraphcolorbacktrackPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn graph_color_backtrack_point_add(a : GraphcolorbacktrackPoint, b : GraphcolorbacktrackPoint) -> GraphcolorbacktrackPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn graph_color_backtrack_point_sub(a : GraphcolorbacktrackPoint, b : GraphcolorbacktrackPoint) -> GraphcolorbacktrackPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn graph_color_backtrack_point_scale(pt : GraphcolorbacktrackPoint, s : Double) -> GraphcolorbacktrackPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn graph_color_backtrack_point_dot(a : GraphcolorbacktrackPoint, b : GraphcolorbacktrackPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn graph_color_backtrack_point_cross(a : GraphcolorbacktrackPoint, b : GraphcolorbacktrackPoint) -> GraphcolorbacktrackPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn graph_color_backtrack_point_norm(pt : GraphcolorbacktrackPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn graph_color_backtrack_point_normalize(pt : GraphcolorbacktrackPoint) -> GraphcolorbacktrackPoint {
  let n = graph_color_backtrack_point_norm(pt)
  if n < 0.0000001 { pt } else { graph_color_backtrack_point_scale(pt, 1.0 / n) }
}

pub fn graph_color_backtrack_point_negate(pt : GraphcolorbacktrackPoint) -> GraphcolorbacktrackPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn graph_color_backtrack_point_mid(a : GraphcolorbacktrackPoint, b : GraphcolorbacktrackPoint) -> GraphcolorbacktrackPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn graph_color_backtrack_point_lerp(a : GraphcolorbacktrackPoint, b : GraphcolorbacktrackPoint, t : Double) -> GraphcolorbacktrackPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn graph_color_backtrack_point_to_string(pt : GraphcolorbacktrackPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct GraphcolorbacktrackSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_color_backtrack_make_series(vals : Array[Double], name : String) -> GraphcolorbacktrackSeries {
  { vals, name, meta: 0 }
}

pub fn graph_color_backtrack_series_len(s : GraphcolorbacktrackSeries) -> Int { s.vals.length() }

pub fn graph_color_backtrack_series_sum(s : GraphcolorbacktrackSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn graph_color_backtrack_series_mean(s : GraphcolorbacktrackSeries) -> Double {
  let n = graph_color_backtrack_series_len(s)
  if n == 0 { 0.0 } else { graph_color_backtrack_series_sum(s) / n.to_double() }
}

pub fn graph_color_backtrack_series_min(s : GraphcolorbacktrackSeries) -> Double {
  let n = graph_color_backtrack_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn graph_color_backtrack_series_max(s : GraphcolorbacktrackSeries) -> Double {
  let n = graph_color_backtrack_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn graph_color_backtrack_series_range(s : GraphcolorbacktrackSeries) -> Double {
  graph_color_backtrack_series_max(s) - graph_color_backtrack_series_min(s)
}

pub fn graph_color_backtrack_series_var(s : GraphcolorbacktrackSeries) -> Double {
  let n = graph_color_backtrack_series_len(s)
  if n == 0 { 0.0 } else {
    let m = graph_color_backtrack_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn graph_color_backtrack_series_std(s : GraphcolorbacktrackSeries) -> Double { @_common.sqrt(graph_color_backtrack_series_var(s)) }

pub fn graph_color_backtrack_series_median(s : GraphcolorbacktrackSeries) -> Double {
  let n = graph_color_backtrack_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = graph_color_backtrack_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn graph_color_backtrack_series_scale(s : GraphcolorbacktrackSeries, f : Double) -> GraphcolorbacktrackSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn graph_color_backtrack_series_add(a : GraphcolorbacktrackSeries, b : GraphcolorbacktrackSeries) -> GraphcolorbacktrackSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn graph_color_backtrack_series_sub(a : GraphcolorbacktrackSeries, b : GraphcolorbacktrackSeries) -> GraphcolorbacktrackSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn graph_color_backtrack_series_normalize(s : GraphcolorbacktrackSeries) -> GraphcolorbacktrackSeries {
  let mn = graph_color_backtrack_series_min(s)
  let mx = graph_color_backtrack_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn graph_color_backtrack_series_cumsum(s : GraphcolorbacktrackSeries) -> GraphcolorbacktrackSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn graph_color_backtrack_series_to_string(s : GraphcolorbacktrackSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphcolorbacktrackMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_color_backtrack_make_matrix(rows : Int, cols : Int, val : Double) -> GraphcolorbacktrackMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_color_backtrack_matrix_identity(n : Int) -> GraphcolorbacktrackMatrix {
  let m = graph_color_backtrack_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn graph_color_backtrack_matrix_get(m : GraphcolorbacktrackMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn graph_color_backtrack_matrix_transpose(m : GraphcolorbacktrackMatrix) -> GraphcolorbacktrackMatrix {
  let result = graph_color_backtrack_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn graph_color_backtrack_matrix_add(a : GraphcolorbacktrackMatrix, b : GraphcolorbacktrackMatrix) -> GraphcolorbacktrackMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = graph_color_backtrack_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn graph_color_backtrack_matrix_scale(m : GraphcolorbacktrackMatrix, s : Double) -> GraphcolorbacktrackMatrix {
  let result = graph_color_backtrack_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn graph_color_backtrack_matrix_multiply(a : GraphcolorbacktrackMatrix, b : GraphcolorbacktrackMatrix) -> GraphcolorbacktrackMatrix {
  if a.cols != b.rows { return graph_color_backtrack_make_matrix(a.rows, b.cols, 0.0) }
  let result = graph_color_backtrack_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn graph_color_backtrack_matrix_trace(m : GraphcolorbacktrackMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn graph_color_backtrack_matrix_det(m : GraphcolorbacktrackMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn graph_color_backtrack_matrix_norm(m : GraphcolorbacktrackMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn graph_color_backtrack_matrix_to_string(m : GraphcolorbacktrackMatrix) -> String {
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

pub(all) struct GraphcolorbacktrackVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_color_backtrack_make_vector(comps : Array[Double]) -> GraphcolorbacktrackVector {
  { comps, dim: comps.length() }
}

pub fn graph_color_backtrack_vector_zero(dim : Int) -> GraphcolorbacktrackVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn graph_color_backtrack_vector_add(a : GraphcolorbacktrackVector, b : GraphcolorbacktrackVector) -> GraphcolorbacktrackVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn graph_color_backtrack_vector_sub(a : GraphcolorbacktrackVector, b : GraphcolorbacktrackVector) -> GraphcolorbacktrackVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn graph_color_backtrack_vector_scale(v : GraphcolorbacktrackVector, s : Double) -> GraphcolorbacktrackVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn graph_color_backtrack_vector_dot(a : GraphcolorbacktrackVector, b : GraphcolorbacktrackVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn graph_color_backtrack_vector_norm(v : GraphcolorbacktrackVector) -> Double { @_common.sqrt(graph_color_backtrack_vector_dot(v, v)) }

pub fn graph_color_backtrack_vector_normalize(v : GraphcolorbacktrackVector) -> GraphcolorbacktrackVector {
  let n = graph_color_backtrack_vector_norm(v)
  if n < 0.0000001 { v } else { graph_color_backtrack_vector_scale(v, 1.0 / n) }
}

pub fn graph_color_backtrack_vector_dist(a : GraphcolorbacktrackVector, b : GraphcolorbacktrackVector) -> Double {
  graph_color_backtrack_vector_norm(graph_color_backtrack_vector_sub(a, b))
}

pub fn graph_color_backtrack_vector_to_string(v : GraphcolorbacktrackVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_color_backtrack_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn graph_color_backtrack_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn graph_color_backtrack_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn graph_color_backtrack_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn graph_color_backtrack_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn graph_color_backtrack_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn graph_color_backtrack_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn graph_color_backtrack_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn graph_color_backtrack_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn graph_color_backtrack_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn graph_color_backtrack_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn graph_color_backtrack_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn graph_color_backtrack_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn graph_color_backtrack_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn graph_color_backtrack_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn graph_color_backtrack_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn graph_color_backtrack_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn graph_color_backtrack_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn graph_color_backtrack_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn graph_color_backtrack_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn graph_color_backtrack_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn graph_color_backtrack_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn graph_color_backtrack_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn graph_color_backtrack_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn graph_color_backtrack_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn graph_color_backtrack_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn graph_color_backtrack_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn graph_color_backtrack_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn graph_color_backtrack_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GraphcolorbacktrackFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_backtrack_frame_make(size : Int) -> GraphcolorbacktrackFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_backtrack_frame_len(s : GraphcolorbacktrackFrame) -> Int { s.size }

pub fn graph_color_backtrack_frame_get(s : GraphcolorbacktrackFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_backtrack_frame_set(s : GraphcolorbacktrackFrame, i : Int, v : Double) -> GraphcolorbacktrackFrame {
  let result = graph_color_backtrack_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_backtrack_frame_sum(s : GraphcolorbacktrackFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_color_backtrack_frame_mean(s : GraphcolorbacktrackFrame) -> Double {
  if s.size == 0 { 0.0 } else { graph_color_backtrack_frame_sum(s) / s.size.to_double() }
}

pub fn graph_color_backtrack_frame_scale(s : GraphcolorbacktrackFrame, f : Double) -> GraphcolorbacktrackFrame {
  let result = graph_color_backtrack_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_backtrack_frame_add(a : GraphcolorbacktrackFrame, b : GraphcolorbacktrackFrame) -> GraphcolorbacktrackFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_backtrack_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_backtrack_frame_copy(s : GraphcolorbacktrackFrame) -> GraphcolorbacktrackFrame {
  let result = graph_color_backtrack_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_backtrack_frame_fill(s : GraphcolorbacktrackFrame, v : Double) -> GraphcolorbacktrackFrame {
  let result = graph_color_backtrack_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_backtrack_frame_min(s : GraphcolorbacktrackFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_backtrack_frame_max(s : GraphcolorbacktrackFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_backtrack_frame_to_string(s : GraphcolorbacktrackFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorbacktrackTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_backtrack_table_make(size : Int) -> GraphcolorbacktrackTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_backtrack_table_len(s : GraphcolorbacktrackTable) -> Int { s.size }

pub fn graph_color_backtrack_table_get(s : GraphcolorbacktrackTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_backtrack_table_set(s : GraphcolorbacktrackTable, i : Int, v : Double) -> GraphcolorbacktrackTable {
  let result = graph_color_backtrack_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_backtrack_table_sum(s : GraphcolorbacktrackTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_color_backtrack_table_mean(s : GraphcolorbacktrackTable) -> Double {
  if s.size == 0 { 0.0 } else { graph_color_backtrack_table_sum(s) / s.size.to_double() }
}

pub fn graph_color_backtrack_table_scale(s : GraphcolorbacktrackTable, f : Double) -> GraphcolorbacktrackTable {
  let result = graph_color_backtrack_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_backtrack_table_add(a : GraphcolorbacktrackTable, b : GraphcolorbacktrackTable) -> GraphcolorbacktrackTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_backtrack_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_backtrack_table_copy(s : GraphcolorbacktrackTable) -> GraphcolorbacktrackTable {
  let result = graph_color_backtrack_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_backtrack_table_fill(s : GraphcolorbacktrackTable, v : Double) -> GraphcolorbacktrackTable {
  let result = graph_color_backtrack_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_backtrack_table_min(s : GraphcolorbacktrackTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_backtrack_table_max(s : GraphcolorbacktrackTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_backtrack_table_to_string(s : GraphcolorbacktrackTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorbacktrackGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_backtrack_graphn_make(size : Int) -> GraphcolorbacktrackGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_backtrack_graphn_len(s : GraphcolorbacktrackGraphN) -> Int { s.size }

pub fn graph_color_backtrack_graphn_get(s : GraphcolorbacktrackGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_backtrack_graphn_set(s : GraphcolorbacktrackGraphN, i : Int, v : Double) -> GraphcolorbacktrackGraphN {
  let result = graph_color_backtrack_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_backtrack_graphn_sum(s : GraphcolorbacktrackGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_color_backtrack_graphn_mean(s : GraphcolorbacktrackGraphN) -> Double {
  if s.size == 0 { 0.0 } else { graph_color_backtrack_graphn_sum(s) / s.size.to_double() }
}

pub fn graph_color_backtrack_graphn_scale(s : GraphcolorbacktrackGraphN, f : Double) -> GraphcolorbacktrackGraphN {
  let result = graph_color_backtrack_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_backtrack_graphn_add(a : GraphcolorbacktrackGraphN, b : GraphcolorbacktrackGraphN) -> GraphcolorbacktrackGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_backtrack_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_backtrack_graphn_copy(s : GraphcolorbacktrackGraphN) -> GraphcolorbacktrackGraphN {
  let result = graph_color_backtrack_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_backtrack_graphn_fill(s : GraphcolorbacktrackGraphN, v : Double) -> GraphcolorbacktrackGraphN {
  let result = graph_color_backtrack_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_backtrack_graphn_min(s : GraphcolorbacktrackGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_backtrack_graphn_max(s : GraphcolorbacktrackGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_backtrack_graphn_to_string(s : GraphcolorbacktrackGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorbacktrackNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_backtrack_node_make(size : Int) -> GraphcolorbacktrackNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_backtrack_node_len(s : GraphcolorbacktrackNode) -> Int { s.size }

pub fn graph_color_backtrack_node_get(s : GraphcolorbacktrackNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_backtrack_node_set(s : GraphcolorbacktrackNode, i : Int, v : Double) -> GraphcolorbacktrackNode {
  let result = graph_color_backtrack_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_backtrack_node_sum(s : GraphcolorbacktrackNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_color_backtrack_node_mean(s : GraphcolorbacktrackNode) -> Double {
  if s.size == 0 { 0.0 } else { graph_color_backtrack_node_sum(s) / s.size.to_double() }
}

pub fn graph_color_backtrack_node_scale(s : GraphcolorbacktrackNode, f : Double) -> GraphcolorbacktrackNode {
  let result = graph_color_backtrack_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_backtrack_node_add(a : GraphcolorbacktrackNode, b : GraphcolorbacktrackNode) -> GraphcolorbacktrackNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_backtrack_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_backtrack_node_copy(s : GraphcolorbacktrackNode) -> GraphcolorbacktrackNode {
  let result = graph_color_backtrack_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_backtrack_node_fill(s : GraphcolorbacktrackNode, v : Double) -> GraphcolorbacktrackNode {
  let result = graph_color_backtrack_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_backtrack_node_min(s : GraphcolorbacktrackNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_backtrack_node_max(s : GraphcolorbacktrackNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_backtrack_node_to_string(s : GraphcolorbacktrackNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorbacktrackEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_backtrack_edge_make(size : Int) -> GraphcolorbacktrackEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_backtrack_edge_len(s : GraphcolorbacktrackEdge) -> Int { s.size }

pub fn graph_color_backtrack_edge_get(s : GraphcolorbacktrackEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_backtrack_edge_set(s : GraphcolorbacktrackEdge, i : Int, v : Double) -> GraphcolorbacktrackEdge {
  let result = graph_color_backtrack_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_backtrack_edge_sum(s : GraphcolorbacktrackEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_color_backtrack_edge_mean(s : GraphcolorbacktrackEdge) -> Double {
  if s.size == 0 { 0.0 } else { graph_color_backtrack_edge_sum(s) / s.size.to_double() }
}

pub fn graph_color_backtrack_edge_scale(s : GraphcolorbacktrackEdge, f : Double) -> GraphcolorbacktrackEdge {
  let result = graph_color_backtrack_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_backtrack_edge_add(a : GraphcolorbacktrackEdge, b : GraphcolorbacktrackEdge) -> GraphcolorbacktrackEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_backtrack_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_backtrack_edge_copy(s : GraphcolorbacktrackEdge) -> GraphcolorbacktrackEdge {
  let result = graph_color_backtrack_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_backtrack_edge_fill(s : GraphcolorbacktrackEdge, v : Double) -> GraphcolorbacktrackEdge {
  let result = graph_color_backtrack_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_backtrack_edge_min(s : GraphcolorbacktrackEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_backtrack_edge_max(s : GraphcolorbacktrackEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_backtrack_edge_to_string(s : GraphcolorbacktrackEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorbacktrackPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_backtrack_path_make(size : Int) -> GraphcolorbacktrackPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_backtrack_path_len(s : GraphcolorbacktrackPath) -> Int { s.size }

pub fn graph_color_backtrack_path_get(s : GraphcolorbacktrackPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_backtrack_path_set(s : GraphcolorbacktrackPath, i : Int, v : Double) -> GraphcolorbacktrackPath {
  let result = graph_color_backtrack_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_backtrack_path_sum(s : GraphcolorbacktrackPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_color_backtrack_path_mean(s : GraphcolorbacktrackPath) -> Double {
  if s.size == 0 { 0.0 } else { graph_color_backtrack_path_sum(s) / s.size.to_double() }
}

pub fn graph_color_backtrack_path_scale(s : GraphcolorbacktrackPath, f : Double) -> GraphcolorbacktrackPath {
  let result = graph_color_backtrack_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_backtrack_path_add(a : GraphcolorbacktrackPath, b : GraphcolorbacktrackPath) -> GraphcolorbacktrackPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_backtrack_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_backtrack_path_copy(s : GraphcolorbacktrackPath) -> GraphcolorbacktrackPath {
  let result = graph_color_backtrack_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_backtrack_path_fill(s : GraphcolorbacktrackPath, v : Double) -> GraphcolorbacktrackPath {
  let result = graph_color_backtrack_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_backtrack_path_min(s : GraphcolorbacktrackPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_backtrack_path_max(s : GraphcolorbacktrackPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_backtrack_path_to_string(s : GraphcolorbacktrackPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorbacktrackCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_backtrack_cluster_make(size : Int) -> GraphcolorbacktrackCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_backtrack_cluster_len(s : GraphcolorbacktrackCluster) -> Int { s.size }

pub fn graph_color_backtrack_cluster_get(s : GraphcolorbacktrackCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_backtrack_cluster_set(s : GraphcolorbacktrackCluster, i : Int, v : Double) -> GraphcolorbacktrackCluster {
  let result = graph_color_backtrack_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_backtrack_cluster_sum(s : GraphcolorbacktrackCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_color_backtrack_cluster_mean(s : GraphcolorbacktrackCluster) -> Double {
  if s.size == 0 { 0.0 } else { graph_color_backtrack_cluster_sum(s) / s.size.to_double() }
}

pub fn graph_color_backtrack_cluster_scale(s : GraphcolorbacktrackCluster, f : Double) -> GraphcolorbacktrackCluster {
  let result = graph_color_backtrack_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_backtrack_cluster_add(a : GraphcolorbacktrackCluster, b : GraphcolorbacktrackCluster) -> GraphcolorbacktrackCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_backtrack_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_backtrack_cluster_copy(s : GraphcolorbacktrackCluster) -> GraphcolorbacktrackCluster {
  let result = graph_color_backtrack_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_backtrack_cluster_fill(s : GraphcolorbacktrackCluster, v : Double) -> GraphcolorbacktrackCluster {
  let result = graph_color_backtrack_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_backtrack_cluster_min(s : GraphcolorbacktrackCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_backtrack_cluster_max(s : GraphcolorbacktrackCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_backtrack_cluster_to_string(s : GraphcolorbacktrackCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorbacktrackModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_backtrack_model_make(size : Int) -> GraphcolorbacktrackModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_backtrack_model_len(s : GraphcolorbacktrackModel) -> Int { s.size }

pub fn graph_color_backtrack_model_get(s : GraphcolorbacktrackModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_backtrack_model_set(s : GraphcolorbacktrackModel, i : Int, v : Double) -> GraphcolorbacktrackModel {
  let result = graph_color_backtrack_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_backtrack_model_sum(s : GraphcolorbacktrackModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_color_backtrack_model_mean(s : GraphcolorbacktrackModel) -> Double {
  if s.size == 0 { 0.0 } else { graph_color_backtrack_model_sum(s) / s.size.to_double() }
}

pub fn graph_color_backtrack_model_scale(s : GraphcolorbacktrackModel, f : Double) -> GraphcolorbacktrackModel {
  let result = graph_color_backtrack_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_backtrack_model_add(a : GraphcolorbacktrackModel, b : GraphcolorbacktrackModel) -> GraphcolorbacktrackModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_backtrack_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_backtrack_model_copy(s : GraphcolorbacktrackModel) -> GraphcolorbacktrackModel {
  let result = graph_color_backtrack_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_backtrack_model_fill(s : GraphcolorbacktrackModel, v : Double) -> GraphcolorbacktrackModel {
  let result = graph_color_backtrack_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_backtrack_model_min(s : GraphcolorbacktrackModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_backtrack_model_max(s : GraphcolorbacktrackModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_backtrack_model_to_string(s : GraphcolorbacktrackModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorbacktrackLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_backtrack_layer_make(size : Int) -> GraphcolorbacktrackLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_backtrack_layer_len(s : GraphcolorbacktrackLayer) -> Int { s.size }

pub fn graph_color_backtrack_layer_get(s : GraphcolorbacktrackLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_backtrack_layer_set(s : GraphcolorbacktrackLayer, i : Int, v : Double) -> GraphcolorbacktrackLayer {
  let result = graph_color_backtrack_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_backtrack_layer_sum(s : GraphcolorbacktrackLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_color_backtrack_layer_mean(s : GraphcolorbacktrackLayer) -> Double {
  if s.size == 0 { 0.0 } else { graph_color_backtrack_layer_sum(s) / s.size.to_double() }
}

pub fn graph_color_backtrack_layer_scale(s : GraphcolorbacktrackLayer, f : Double) -> GraphcolorbacktrackLayer {
  let result = graph_color_backtrack_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_backtrack_layer_add(a : GraphcolorbacktrackLayer, b : GraphcolorbacktrackLayer) -> GraphcolorbacktrackLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_backtrack_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_backtrack_layer_copy(s : GraphcolorbacktrackLayer) -> GraphcolorbacktrackLayer {
  let result = graph_color_backtrack_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_backtrack_layer_fill(s : GraphcolorbacktrackLayer, v : Double) -> GraphcolorbacktrackLayer {
  let result = graph_color_backtrack_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_backtrack_layer_min(s : GraphcolorbacktrackLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_backtrack_layer_max(s : GraphcolorbacktrackLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_backtrack_layer_to_string(s : GraphcolorbacktrackLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorbacktrackBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_backtrack_buffer_make(size : Int) -> GraphcolorbacktrackBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_backtrack_buffer_len(s : GraphcolorbacktrackBuffer) -> Int { s.size }

pub fn graph_color_backtrack_buffer_get(s : GraphcolorbacktrackBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_backtrack_buffer_set(s : GraphcolorbacktrackBuffer, i : Int, v : Double) -> GraphcolorbacktrackBuffer {
  let result = graph_color_backtrack_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_backtrack_buffer_sum(s : GraphcolorbacktrackBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_color_backtrack_buffer_mean(s : GraphcolorbacktrackBuffer) -> Double {
  if s.size == 0 { 0.0 } else { graph_color_backtrack_buffer_sum(s) / s.size.to_double() }
}

pub fn graph_color_backtrack_buffer_scale(s : GraphcolorbacktrackBuffer, f : Double) -> GraphcolorbacktrackBuffer {
  let result = graph_color_backtrack_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_backtrack_buffer_add(a : GraphcolorbacktrackBuffer, b : GraphcolorbacktrackBuffer) -> GraphcolorbacktrackBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_backtrack_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_backtrack_buffer_copy(s : GraphcolorbacktrackBuffer) -> GraphcolorbacktrackBuffer {
  let result = graph_color_backtrack_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_backtrack_buffer_fill(s : GraphcolorbacktrackBuffer, v : Double) -> GraphcolorbacktrackBuffer {
  let result = graph_color_backtrack_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_backtrack_buffer_min(s : GraphcolorbacktrackBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_backtrack_buffer_max(s : GraphcolorbacktrackBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_backtrack_buffer_to_string(s : GraphcolorbacktrackBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorbacktrackCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_backtrack_cursor_make(size : Int) -> GraphcolorbacktrackCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_backtrack_cursor_len(s : GraphcolorbacktrackCursor) -> Int { s.size }

pub fn graph_color_backtrack_cursor_get(s : GraphcolorbacktrackCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_backtrack_cursor_set(s : GraphcolorbacktrackCursor, i : Int, v : Double) -> GraphcolorbacktrackCursor {
  let result = graph_color_backtrack_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_backtrack_cursor_sum(s : GraphcolorbacktrackCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_color_backtrack_cursor_mean(s : GraphcolorbacktrackCursor) -> Double {
  if s.size == 0 { 0.0 } else { graph_color_backtrack_cursor_sum(s) / s.size.to_double() }
}

pub fn graph_color_backtrack_cursor_scale(s : GraphcolorbacktrackCursor, f : Double) -> GraphcolorbacktrackCursor {
  let result = graph_color_backtrack_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_backtrack_cursor_add(a : GraphcolorbacktrackCursor, b : GraphcolorbacktrackCursor) -> GraphcolorbacktrackCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_backtrack_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_backtrack_cursor_copy(s : GraphcolorbacktrackCursor) -> GraphcolorbacktrackCursor {
  let result = graph_color_backtrack_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_backtrack_cursor_fill(s : GraphcolorbacktrackCursor, v : Double) -> GraphcolorbacktrackCursor {
  let result = graph_color_backtrack_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_backtrack_cursor_min(s : GraphcolorbacktrackCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_backtrack_cursor_max(s : GraphcolorbacktrackCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_backtrack_cursor_to_string(s : GraphcolorbacktrackCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorbacktrackView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_backtrack_view_make(size : Int) -> GraphcolorbacktrackView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_backtrack_view_len(s : GraphcolorbacktrackView) -> Int { s.size }

pub fn graph_color_backtrack_view_get(s : GraphcolorbacktrackView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_backtrack_view_set(s : GraphcolorbacktrackView, i : Int, v : Double) -> GraphcolorbacktrackView {
  let result = graph_color_backtrack_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_backtrack_view_sum(s : GraphcolorbacktrackView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_color_backtrack_view_mean(s : GraphcolorbacktrackView) -> Double {
  if s.size == 0 { 0.0 } else { graph_color_backtrack_view_sum(s) / s.size.to_double() }
}

pub fn graph_color_backtrack_view_scale(s : GraphcolorbacktrackView, f : Double) -> GraphcolorbacktrackView {
  let result = graph_color_backtrack_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_backtrack_view_add(a : GraphcolorbacktrackView, b : GraphcolorbacktrackView) -> GraphcolorbacktrackView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_backtrack_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_backtrack_view_copy(s : GraphcolorbacktrackView) -> GraphcolorbacktrackView {
  let result = graph_color_backtrack_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_backtrack_view_fill(s : GraphcolorbacktrackView, v : Double) -> GraphcolorbacktrackView {
  let result = graph_color_backtrack_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_backtrack_view_min(s : GraphcolorbacktrackView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_backtrack_view_max(s : GraphcolorbacktrackView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_backtrack_view_to_string(s : GraphcolorbacktrackView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorbacktrackRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_backtrack_range_make(size : Int) -> GraphcolorbacktrackRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_backtrack_range_len(s : GraphcolorbacktrackRange) -> Int { s.size }

pub fn graph_color_backtrack_range_get(s : GraphcolorbacktrackRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_backtrack_range_set(s : GraphcolorbacktrackRange, i : Int, v : Double) -> GraphcolorbacktrackRange {
  let result = graph_color_backtrack_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_backtrack_range_sum(s : GraphcolorbacktrackRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_color_backtrack_range_mean(s : GraphcolorbacktrackRange) -> Double {
  if s.size == 0 { 0.0 } else { graph_color_backtrack_range_sum(s) / s.size.to_double() }
}

pub fn graph_color_backtrack_range_scale(s : GraphcolorbacktrackRange, f : Double) -> GraphcolorbacktrackRange {
  let result = graph_color_backtrack_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_backtrack_range_add(a : GraphcolorbacktrackRange, b : GraphcolorbacktrackRange) -> GraphcolorbacktrackRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_backtrack_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_backtrack_range_copy(s : GraphcolorbacktrackRange) -> GraphcolorbacktrackRange {
  let result = graph_color_backtrack_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_backtrack_range_fill(s : GraphcolorbacktrackRange, v : Double) -> GraphcolorbacktrackRange {
  let result = graph_color_backtrack_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_backtrack_range_min(s : GraphcolorbacktrackRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_backtrack_range_max(s : GraphcolorbacktrackRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_backtrack_range_to_string(s : GraphcolorbacktrackRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorbacktrackSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_backtrack_slice_make(size : Int) -> GraphcolorbacktrackSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_backtrack_slice_len(s : GraphcolorbacktrackSlice) -> Int { s.size }

pub fn graph_color_backtrack_slice_get(s : GraphcolorbacktrackSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_backtrack_slice_set(s : GraphcolorbacktrackSlice, i : Int, v : Double) -> GraphcolorbacktrackSlice {
  let result = graph_color_backtrack_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_backtrack_slice_sum(s : GraphcolorbacktrackSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_color_backtrack_slice_mean(s : GraphcolorbacktrackSlice) -> Double {
  if s.size == 0 { 0.0 } else { graph_color_backtrack_slice_sum(s) / s.size.to_double() }
}

pub fn graph_color_backtrack_slice_scale(s : GraphcolorbacktrackSlice, f : Double) -> GraphcolorbacktrackSlice {
  let result = graph_color_backtrack_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_backtrack_slice_add(a : GraphcolorbacktrackSlice, b : GraphcolorbacktrackSlice) -> GraphcolorbacktrackSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_backtrack_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_backtrack_slice_copy(s : GraphcolorbacktrackSlice) -> GraphcolorbacktrackSlice {
  let result = graph_color_backtrack_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_backtrack_slice_fill(s : GraphcolorbacktrackSlice, v : Double) -> GraphcolorbacktrackSlice {
  let result = graph_color_backtrack_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_backtrack_slice_min(s : GraphcolorbacktrackSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_backtrack_slice_max(s : GraphcolorbacktrackSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_backtrack_slice_to_string(s : GraphcolorbacktrackSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


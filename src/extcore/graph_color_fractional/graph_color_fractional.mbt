///===
/// extcore/graph_color_fractional

pub(all) struct GraphcolorfractionalPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_color_fractional_make_point(x : Double, y : Double) -> GraphcolorfractionalPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_color_fractional_make_point3(x : Double, y : Double, z : Double) -> GraphcolorfractionalPoint {
  { x, y, z, label: 0 }
}

pub fn graph_color_fractional_point_x(pt : GraphcolorfractionalPoint) -> Double { pt.x }

pub fn graph_color_fractional_point_y(pt : GraphcolorfractionalPoint) -> Double { pt.y }

pub fn graph_color_fractional_point_z(pt : GraphcolorfractionalPoint) -> Double { pt.z }

pub fn graph_color_fractional_point_label(pt : GraphcolorfractionalPoint) -> Int { pt.label }

pub fn graph_color_fractional_point_dist(a : GraphcolorfractionalPoint, b : GraphcolorfractionalPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn graph_color_fractional_point_add(a : GraphcolorfractionalPoint, b : GraphcolorfractionalPoint) -> GraphcolorfractionalPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn graph_color_fractional_point_sub(a : GraphcolorfractionalPoint, b : GraphcolorfractionalPoint) -> GraphcolorfractionalPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn graph_color_fractional_point_scale(pt : GraphcolorfractionalPoint, s : Double) -> GraphcolorfractionalPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn graph_color_fractional_point_dot(a : GraphcolorfractionalPoint, b : GraphcolorfractionalPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn graph_color_fractional_point_cross(a : GraphcolorfractionalPoint, b : GraphcolorfractionalPoint) -> GraphcolorfractionalPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn graph_color_fractional_point_norm(pt : GraphcolorfractionalPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn graph_color_fractional_point_normalize(pt : GraphcolorfractionalPoint) -> GraphcolorfractionalPoint {
  let n = graph_color_fractional_point_norm(pt)
  if n < 0.0000001 { pt } else { graph_color_fractional_point_scale(pt, 1.0 / n) }
}

pub fn graph_color_fractional_point_negate(pt : GraphcolorfractionalPoint) -> GraphcolorfractionalPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn graph_color_fractional_point_mid(a : GraphcolorfractionalPoint, b : GraphcolorfractionalPoint) -> GraphcolorfractionalPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn graph_color_fractional_point_lerp(a : GraphcolorfractionalPoint, b : GraphcolorfractionalPoint, t : Double) -> GraphcolorfractionalPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn graph_color_fractional_point_to_string(pt : GraphcolorfractionalPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct GraphcolorfractionalSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_color_fractional_make_series(vals : Array[Double], name : String) -> GraphcolorfractionalSeries {
  { vals, name, meta: 0 }
}

pub fn graph_color_fractional_series_len(s : GraphcolorfractionalSeries) -> Int { s.vals.length() }

pub fn graph_color_fractional_series_sum(s : GraphcolorfractionalSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn graph_color_fractional_series_mean(s : GraphcolorfractionalSeries) -> Double {
  let n = graph_color_fractional_series_len(s)
  if n == 0 { 0.0 } else { graph_color_fractional_series_sum(s) / n.to_double() }
}

pub fn graph_color_fractional_series_min(s : GraphcolorfractionalSeries) -> Double {
  let n = graph_color_fractional_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn graph_color_fractional_series_max(s : GraphcolorfractionalSeries) -> Double {
  let n = graph_color_fractional_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn graph_color_fractional_series_range(s : GraphcolorfractionalSeries) -> Double {
  graph_color_fractional_series_max(s) - graph_color_fractional_series_min(s)
}

pub fn graph_color_fractional_series_var(s : GraphcolorfractionalSeries) -> Double {
  let n = graph_color_fractional_series_len(s)
  if n == 0 { 0.0 } else {
    let m = graph_color_fractional_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn graph_color_fractional_series_std(s : GraphcolorfractionalSeries) -> Double { @_common.sqrt(graph_color_fractional_series_var(s)) }

pub fn graph_color_fractional_series_median(s : GraphcolorfractionalSeries) -> Double {
  let n = graph_color_fractional_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = graph_color_fractional_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn graph_color_fractional_series_scale(s : GraphcolorfractionalSeries, f : Double) -> GraphcolorfractionalSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn graph_color_fractional_series_add(a : GraphcolorfractionalSeries, b : GraphcolorfractionalSeries) -> GraphcolorfractionalSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn graph_color_fractional_series_sub(a : GraphcolorfractionalSeries, b : GraphcolorfractionalSeries) -> GraphcolorfractionalSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn graph_color_fractional_series_normalize(s : GraphcolorfractionalSeries) -> GraphcolorfractionalSeries {
  let mn = graph_color_fractional_series_min(s)
  let mx = graph_color_fractional_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn graph_color_fractional_series_cumsum(s : GraphcolorfractionalSeries) -> GraphcolorfractionalSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn graph_color_fractional_series_to_string(s : GraphcolorfractionalSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphcolorfractionalMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_color_fractional_make_matrix(rows : Int, cols : Int, val : Double) -> GraphcolorfractionalMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_color_fractional_matrix_identity(n : Int) -> GraphcolorfractionalMatrix {
  let m = graph_color_fractional_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn graph_color_fractional_matrix_get(m : GraphcolorfractionalMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn graph_color_fractional_matrix_transpose(m : GraphcolorfractionalMatrix) -> GraphcolorfractionalMatrix {
  let result = graph_color_fractional_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn graph_color_fractional_matrix_add(a : GraphcolorfractionalMatrix, b : GraphcolorfractionalMatrix) -> GraphcolorfractionalMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = graph_color_fractional_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn graph_color_fractional_matrix_scale(m : GraphcolorfractionalMatrix, s : Double) -> GraphcolorfractionalMatrix {
  let result = graph_color_fractional_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn graph_color_fractional_matrix_multiply(a : GraphcolorfractionalMatrix, b : GraphcolorfractionalMatrix) -> GraphcolorfractionalMatrix {
  if a.cols != b.rows { return graph_color_fractional_make_matrix(a.rows, b.cols, 0.0) }
  let result = graph_color_fractional_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn graph_color_fractional_matrix_trace(m : GraphcolorfractionalMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn graph_color_fractional_matrix_det(m : GraphcolorfractionalMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn graph_color_fractional_matrix_norm(m : GraphcolorfractionalMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn graph_color_fractional_matrix_to_string(m : GraphcolorfractionalMatrix) -> String {
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

pub(all) struct GraphcolorfractionalVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_color_fractional_make_vector(comps : Array[Double]) -> GraphcolorfractionalVector {
  { comps, dim: comps.length() }
}

pub fn graph_color_fractional_vector_zero(dim : Int) -> GraphcolorfractionalVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn graph_color_fractional_vector_add(a : GraphcolorfractionalVector, b : GraphcolorfractionalVector) -> GraphcolorfractionalVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn graph_color_fractional_vector_sub(a : GraphcolorfractionalVector, b : GraphcolorfractionalVector) -> GraphcolorfractionalVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn graph_color_fractional_vector_scale(v : GraphcolorfractionalVector, s : Double) -> GraphcolorfractionalVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn graph_color_fractional_vector_dot(a : GraphcolorfractionalVector, b : GraphcolorfractionalVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn graph_color_fractional_vector_norm(v : GraphcolorfractionalVector) -> Double { @_common.sqrt(graph_color_fractional_vector_dot(v, v)) }

pub fn graph_color_fractional_vector_normalize(v : GraphcolorfractionalVector) -> GraphcolorfractionalVector {
  let n = graph_color_fractional_vector_norm(v)
  if n < 0.0000001 { v } else { graph_color_fractional_vector_scale(v, 1.0 / n) }
}

pub fn graph_color_fractional_vector_dist(a : GraphcolorfractionalVector, b : GraphcolorfractionalVector) -> Double {
  graph_color_fractional_vector_norm(graph_color_fractional_vector_sub(a, b))
}

pub fn graph_color_fractional_vector_to_string(v : GraphcolorfractionalVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_color_fractional_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn graph_color_fractional_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn graph_color_fractional_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn graph_color_fractional_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn graph_color_fractional_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn graph_color_fractional_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn graph_color_fractional_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn graph_color_fractional_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn graph_color_fractional_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn graph_color_fractional_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn graph_color_fractional_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn graph_color_fractional_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn graph_color_fractional_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn graph_color_fractional_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn graph_color_fractional_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn graph_color_fractional_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn graph_color_fractional_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn graph_color_fractional_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn graph_color_fractional_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn graph_color_fractional_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn graph_color_fractional_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn graph_color_fractional_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn graph_color_fractional_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn graph_color_fractional_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn graph_color_fractional_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn graph_color_fractional_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn graph_color_fractional_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn graph_color_fractional_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn graph_color_fractional_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GraphcolorfractionalFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_fractional_frame_make(size : Int) -> GraphcolorfractionalFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_fractional_frame_len(s : GraphcolorfractionalFrame) -> Int { s.size }

pub fn graph_color_fractional_frame_get(s : GraphcolorfractionalFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_fractional_frame_set(s : GraphcolorfractionalFrame, i : Int, v : Double) -> GraphcolorfractionalFrame {
  let result = graph_color_fractional_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_fractional_frame_sum(s : GraphcolorfractionalFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_color_fractional_frame_mean(s : GraphcolorfractionalFrame) -> Double {
  if s.size == 0 { 0.0 } else { graph_color_fractional_frame_sum(s) / s.size.to_double() }
}

pub fn graph_color_fractional_frame_scale(s : GraphcolorfractionalFrame, f : Double) -> GraphcolorfractionalFrame {
  let result = graph_color_fractional_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_fractional_frame_add(a : GraphcolorfractionalFrame, b : GraphcolorfractionalFrame) -> GraphcolorfractionalFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_fractional_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_fractional_frame_copy(s : GraphcolorfractionalFrame) -> GraphcolorfractionalFrame {
  let result = graph_color_fractional_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_fractional_frame_fill(s : GraphcolorfractionalFrame, v : Double) -> GraphcolorfractionalFrame {
  let result = graph_color_fractional_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_fractional_frame_min(s : GraphcolorfractionalFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_fractional_frame_max(s : GraphcolorfractionalFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_fractional_frame_to_string(s : GraphcolorfractionalFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorfractionalTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_fractional_table_make(size : Int) -> GraphcolorfractionalTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_fractional_table_len(s : GraphcolorfractionalTable) -> Int { s.size }

pub fn graph_color_fractional_table_get(s : GraphcolorfractionalTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_fractional_table_set(s : GraphcolorfractionalTable, i : Int, v : Double) -> GraphcolorfractionalTable {
  let result = graph_color_fractional_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_fractional_table_sum(s : GraphcolorfractionalTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_color_fractional_table_mean(s : GraphcolorfractionalTable) -> Double {
  if s.size == 0 { 0.0 } else { graph_color_fractional_table_sum(s) / s.size.to_double() }
}

pub fn graph_color_fractional_table_scale(s : GraphcolorfractionalTable, f : Double) -> GraphcolorfractionalTable {
  let result = graph_color_fractional_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_fractional_table_add(a : GraphcolorfractionalTable, b : GraphcolorfractionalTable) -> GraphcolorfractionalTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_fractional_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_fractional_table_copy(s : GraphcolorfractionalTable) -> GraphcolorfractionalTable {
  let result = graph_color_fractional_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_fractional_table_fill(s : GraphcolorfractionalTable, v : Double) -> GraphcolorfractionalTable {
  let result = graph_color_fractional_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_fractional_table_min(s : GraphcolorfractionalTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_fractional_table_max(s : GraphcolorfractionalTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_fractional_table_to_string(s : GraphcolorfractionalTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorfractionalGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_fractional_graphn_make(size : Int) -> GraphcolorfractionalGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_fractional_graphn_len(s : GraphcolorfractionalGraphN) -> Int { s.size }

pub fn graph_color_fractional_graphn_get(s : GraphcolorfractionalGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_fractional_graphn_set(s : GraphcolorfractionalGraphN, i : Int, v : Double) -> GraphcolorfractionalGraphN {
  let result = graph_color_fractional_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_fractional_graphn_sum(s : GraphcolorfractionalGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_color_fractional_graphn_mean(s : GraphcolorfractionalGraphN) -> Double {
  if s.size == 0 { 0.0 } else { graph_color_fractional_graphn_sum(s) / s.size.to_double() }
}

pub fn graph_color_fractional_graphn_scale(s : GraphcolorfractionalGraphN, f : Double) -> GraphcolorfractionalGraphN {
  let result = graph_color_fractional_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_fractional_graphn_add(a : GraphcolorfractionalGraphN, b : GraphcolorfractionalGraphN) -> GraphcolorfractionalGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_fractional_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_fractional_graphn_copy(s : GraphcolorfractionalGraphN) -> GraphcolorfractionalGraphN {
  let result = graph_color_fractional_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_fractional_graphn_fill(s : GraphcolorfractionalGraphN, v : Double) -> GraphcolorfractionalGraphN {
  let result = graph_color_fractional_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_fractional_graphn_min(s : GraphcolorfractionalGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_fractional_graphn_max(s : GraphcolorfractionalGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_fractional_graphn_to_string(s : GraphcolorfractionalGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorfractionalNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_fractional_node_make(size : Int) -> GraphcolorfractionalNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_fractional_node_len(s : GraphcolorfractionalNode) -> Int { s.size }

pub fn graph_color_fractional_node_get(s : GraphcolorfractionalNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_fractional_node_set(s : GraphcolorfractionalNode, i : Int, v : Double) -> GraphcolorfractionalNode {
  let result = graph_color_fractional_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_fractional_node_sum(s : GraphcolorfractionalNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_color_fractional_node_mean(s : GraphcolorfractionalNode) -> Double {
  if s.size == 0 { 0.0 } else { graph_color_fractional_node_sum(s) / s.size.to_double() }
}

pub fn graph_color_fractional_node_scale(s : GraphcolorfractionalNode, f : Double) -> GraphcolorfractionalNode {
  let result = graph_color_fractional_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_fractional_node_add(a : GraphcolorfractionalNode, b : GraphcolorfractionalNode) -> GraphcolorfractionalNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_fractional_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_fractional_node_copy(s : GraphcolorfractionalNode) -> GraphcolorfractionalNode {
  let result = graph_color_fractional_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_fractional_node_fill(s : GraphcolorfractionalNode, v : Double) -> GraphcolorfractionalNode {
  let result = graph_color_fractional_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_fractional_node_min(s : GraphcolorfractionalNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_fractional_node_max(s : GraphcolorfractionalNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_fractional_node_to_string(s : GraphcolorfractionalNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorfractionalEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_fractional_edge_make(size : Int) -> GraphcolorfractionalEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_fractional_edge_len(s : GraphcolorfractionalEdge) -> Int { s.size }

pub fn graph_color_fractional_edge_get(s : GraphcolorfractionalEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_fractional_edge_set(s : GraphcolorfractionalEdge, i : Int, v : Double) -> GraphcolorfractionalEdge {
  let result = graph_color_fractional_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_fractional_edge_sum(s : GraphcolorfractionalEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_color_fractional_edge_mean(s : GraphcolorfractionalEdge) -> Double {
  if s.size == 0 { 0.0 } else { graph_color_fractional_edge_sum(s) / s.size.to_double() }
}

pub fn graph_color_fractional_edge_scale(s : GraphcolorfractionalEdge, f : Double) -> GraphcolorfractionalEdge {
  let result = graph_color_fractional_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_fractional_edge_add(a : GraphcolorfractionalEdge, b : GraphcolorfractionalEdge) -> GraphcolorfractionalEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_fractional_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_fractional_edge_copy(s : GraphcolorfractionalEdge) -> GraphcolorfractionalEdge {
  let result = graph_color_fractional_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_fractional_edge_fill(s : GraphcolorfractionalEdge, v : Double) -> GraphcolorfractionalEdge {
  let result = graph_color_fractional_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_fractional_edge_min(s : GraphcolorfractionalEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_fractional_edge_max(s : GraphcolorfractionalEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_fractional_edge_to_string(s : GraphcolorfractionalEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorfractionalPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_fractional_path_make(size : Int) -> GraphcolorfractionalPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_fractional_path_len(s : GraphcolorfractionalPath) -> Int { s.size }

pub fn graph_color_fractional_path_get(s : GraphcolorfractionalPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_fractional_path_set(s : GraphcolorfractionalPath, i : Int, v : Double) -> GraphcolorfractionalPath {
  let result = graph_color_fractional_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_fractional_path_sum(s : GraphcolorfractionalPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_color_fractional_path_mean(s : GraphcolorfractionalPath) -> Double {
  if s.size == 0 { 0.0 } else { graph_color_fractional_path_sum(s) / s.size.to_double() }
}

pub fn graph_color_fractional_path_scale(s : GraphcolorfractionalPath, f : Double) -> GraphcolorfractionalPath {
  let result = graph_color_fractional_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_fractional_path_add(a : GraphcolorfractionalPath, b : GraphcolorfractionalPath) -> GraphcolorfractionalPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_fractional_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_fractional_path_copy(s : GraphcolorfractionalPath) -> GraphcolorfractionalPath {
  let result = graph_color_fractional_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_fractional_path_fill(s : GraphcolorfractionalPath, v : Double) -> GraphcolorfractionalPath {
  let result = graph_color_fractional_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_fractional_path_min(s : GraphcolorfractionalPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_fractional_path_max(s : GraphcolorfractionalPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_fractional_path_to_string(s : GraphcolorfractionalPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorfractionalCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_fractional_cluster_make(size : Int) -> GraphcolorfractionalCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_fractional_cluster_len(s : GraphcolorfractionalCluster) -> Int { s.size }

pub fn graph_color_fractional_cluster_get(s : GraphcolorfractionalCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_fractional_cluster_set(s : GraphcolorfractionalCluster, i : Int, v : Double) -> GraphcolorfractionalCluster {
  let result = graph_color_fractional_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_fractional_cluster_sum(s : GraphcolorfractionalCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_color_fractional_cluster_mean(s : GraphcolorfractionalCluster) -> Double {
  if s.size == 0 { 0.0 } else { graph_color_fractional_cluster_sum(s) / s.size.to_double() }
}

pub fn graph_color_fractional_cluster_scale(s : GraphcolorfractionalCluster, f : Double) -> GraphcolorfractionalCluster {
  let result = graph_color_fractional_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_fractional_cluster_add(a : GraphcolorfractionalCluster, b : GraphcolorfractionalCluster) -> GraphcolorfractionalCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_fractional_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_fractional_cluster_copy(s : GraphcolorfractionalCluster) -> GraphcolorfractionalCluster {
  let result = graph_color_fractional_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_fractional_cluster_fill(s : GraphcolorfractionalCluster, v : Double) -> GraphcolorfractionalCluster {
  let result = graph_color_fractional_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_fractional_cluster_min(s : GraphcolorfractionalCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_fractional_cluster_max(s : GraphcolorfractionalCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_fractional_cluster_to_string(s : GraphcolorfractionalCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorfractionalModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_fractional_model_make(size : Int) -> GraphcolorfractionalModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_fractional_model_len(s : GraphcolorfractionalModel) -> Int { s.size }

pub fn graph_color_fractional_model_get(s : GraphcolorfractionalModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_fractional_model_set(s : GraphcolorfractionalModel, i : Int, v : Double) -> GraphcolorfractionalModel {
  let result = graph_color_fractional_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_fractional_model_sum(s : GraphcolorfractionalModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_color_fractional_model_mean(s : GraphcolorfractionalModel) -> Double {
  if s.size == 0 { 0.0 } else { graph_color_fractional_model_sum(s) / s.size.to_double() }
}

pub fn graph_color_fractional_model_scale(s : GraphcolorfractionalModel, f : Double) -> GraphcolorfractionalModel {
  let result = graph_color_fractional_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_fractional_model_add(a : GraphcolorfractionalModel, b : GraphcolorfractionalModel) -> GraphcolorfractionalModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_fractional_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_fractional_model_copy(s : GraphcolorfractionalModel) -> GraphcolorfractionalModel {
  let result = graph_color_fractional_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_fractional_model_fill(s : GraphcolorfractionalModel, v : Double) -> GraphcolorfractionalModel {
  let result = graph_color_fractional_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_fractional_model_min(s : GraphcolorfractionalModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_fractional_model_max(s : GraphcolorfractionalModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_fractional_model_to_string(s : GraphcolorfractionalModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorfractionalLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_fractional_layer_make(size : Int) -> GraphcolorfractionalLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_fractional_layer_len(s : GraphcolorfractionalLayer) -> Int { s.size }

pub fn graph_color_fractional_layer_get(s : GraphcolorfractionalLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_fractional_layer_set(s : GraphcolorfractionalLayer, i : Int, v : Double) -> GraphcolorfractionalLayer {
  let result = graph_color_fractional_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_fractional_layer_sum(s : GraphcolorfractionalLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_color_fractional_layer_mean(s : GraphcolorfractionalLayer) -> Double {
  if s.size == 0 { 0.0 } else { graph_color_fractional_layer_sum(s) / s.size.to_double() }
}

pub fn graph_color_fractional_layer_scale(s : GraphcolorfractionalLayer, f : Double) -> GraphcolorfractionalLayer {
  let result = graph_color_fractional_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_fractional_layer_add(a : GraphcolorfractionalLayer, b : GraphcolorfractionalLayer) -> GraphcolorfractionalLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_fractional_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_fractional_layer_copy(s : GraphcolorfractionalLayer) -> GraphcolorfractionalLayer {
  let result = graph_color_fractional_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_fractional_layer_fill(s : GraphcolorfractionalLayer, v : Double) -> GraphcolorfractionalLayer {
  let result = graph_color_fractional_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_fractional_layer_min(s : GraphcolorfractionalLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_fractional_layer_max(s : GraphcolorfractionalLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_fractional_layer_to_string(s : GraphcolorfractionalLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorfractionalBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_fractional_buffer_make(size : Int) -> GraphcolorfractionalBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_fractional_buffer_len(s : GraphcolorfractionalBuffer) -> Int { s.size }

pub fn graph_color_fractional_buffer_get(s : GraphcolorfractionalBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_fractional_buffer_set(s : GraphcolorfractionalBuffer, i : Int, v : Double) -> GraphcolorfractionalBuffer {
  let result = graph_color_fractional_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_fractional_buffer_sum(s : GraphcolorfractionalBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_color_fractional_buffer_mean(s : GraphcolorfractionalBuffer) -> Double {
  if s.size == 0 { 0.0 } else { graph_color_fractional_buffer_sum(s) / s.size.to_double() }
}

pub fn graph_color_fractional_buffer_scale(s : GraphcolorfractionalBuffer, f : Double) -> GraphcolorfractionalBuffer {
  let result = graph_color_fractional_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_fractional_buffer_add(a : GraphcolorfractionalBuffer, b : GraphcolorfractionalBuffer) -> GraphcolorfractionalBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_fractional_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_fractional_buffer_copy(s : GraphcolorfractionalBuffer) -> GraphcolorfractionalBuffer {
  let result = graph_color_fractional_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_fractional_buffer_fill(s : GraphcolorfractionalBuffer, v : Double) -> GraphcolorfractionalBuffer {
  let result = graph_color_fractional_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_fractional_buffer_min(s : GraphcolorfractionalBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_fractional_buffer_max(s : GraphcolorfractionalBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_fractional_buffer_to_string(s : GraphcolorfractionalBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorfractionalCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_fractional_cursor_make(size : Int) -> GraphcolorfractionalCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_fractional_cursor_len(s : GraphcolorfractionalCursor) -> Int { s.size }

pub fn graph_color_fractional_cursor_get(s : GraphcolorfractionalCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_fractional_cursor_set(s : GraphcolorfractionalCursor, i : Int, v : Double) -> GraphcolorfractionalCursor {
  let result = graph_color_fractional_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_fractional_cursor_sum(s : GraphcolorfractionalCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_color_fractional_cursor_mean(s : GraphcolorfractionalCursor) -> Double {
  if s.size == 0 { 0.0 } else { graph_color_fractional_cursor_sum(s) / s.size.to_double() }
}

pub fn graph_color_fractional_cursor_scale(s : GraphcolorfractionalCursor, f : Double) -> GraphcolorfractionalCursor {
  let result = graph_color_fractional_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_fractional_cursor_add(a : GraphcolorfractionalCursor, b : GraphcolorfractionalCursor) -> GraphcolorfractionalCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_fractional_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_fractional_cursor_copy(s : GraphcolorfractionalCursor) -> GraphcolorfractionalCursor {
  let result = graph_color_fractional_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_fractional_cursor_fill(s : GraphcolorfractionalCursor, v : Double) -> GraphcolorfractionalCursor {
  let result = graph_color_fractional_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_fractional_cursor_min(s : GraphcolorfractionalCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_fractional_cursor_max(s : GraphcolorfractionalCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_fractional_cursor_to_string(s : GraphcolorfractionalCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorfractionalView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_fractional_view_make(size : Int) -> GraphcolorfractionalView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_fractional_view_len(s : GraphcolorfractionalView) -> Int { s.size }

pub fn graph_color_fractional_view_get(s : GraphcolorfractionalView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_fractional_view_set(s : GraphcolorfractionalView, i : Int, v : Double) -> GraphcolorfractionalView {
  let result = graph_color_fractional_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_fractional_view_sum(s : GraphcolorfractionalView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_color_fractional_view_mean(s : GraphcolorfractionalView) -> Double {
  if s.size == 0 { 0.0 } else { graph_color_fractional_view_sum(s) / s.size.to_double() }
}

pub fn graph_color_fractional_view_scale(s : GraphcolorfractionalView, f : Double) -> GraphcolorfractionalView {
  let result = graph_color_fractional_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_fractional_view_add(a : GraphcolorfractionalView, b : GraphcolorfractionalView) -> GraphcolorfractionalView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_fractional_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_fractional_view_copy(s : GraphcolorfractionalView) -> GraphcolorfractionalView {
  let result = graph_color_fractional_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_fractional_view_fill(s : GraphcolorfractionalView, v : Double) -> GraphcolorfractionalView {
  let result = graph_color_fractional_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_fractional_view_min(s : GraphcolorfractionalView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_fractional_view_max(s : GraphcolorfractionalView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_fractional_view_to_string(s : GraphcolorfractionalView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorfractionalRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_fractional_range_make(size : Int) -> GraphcolorfractionalRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_fractional_range_len(s : GraphcolorfractionalRange) -> Int { s.size }

pub fn graph_color_fractional_range_get(s : GraphcolorfractionalRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_fractional_range_set(s : GraphcolorfractionalRange, i : Int, v : Double) -> GraphcolorfractionalRange {
  let result = graph_color_fractional_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_fractional_range_sum(s : GraphcolorfractionalRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_color_fractional_range_mean(s : GraphcolorfractionalRange) -> Double {
  if s.size == 0 { 0.0 } else { graph_color_fractional_range_sum(s) / s.size.to_double() }
}

pub fn graph_color_fractional_range_scale(s : GraphcolorfractionalRange, f : Double) -> GraphcolorfractionalRange {
  let result = graph_color_fractional_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_fractional_range_add(a : GraphcolorfractionalRange, b : GraphcolorfractionalRange) -> GraphcolorfractionalRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_fractional_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_fractional_range_copy(s : GraphcolorfractionalRange) -> GraphcolorfractionalRange {
  let result = graph_color_fractional_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_fractional_range_fill(s : GraphcolorfractionalRange, v : Double) -> GraphcolorfractionalRange {
  let result = graph_color_fractional_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_fractional_range_min(s : GraphcolorfractionalRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_fractional_range_max(s : GraphcolorfractionalRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_fractional_range_to_string(s : GraphcolorfractionalRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorfractionalSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_fractional_slice_make(size : Int) -> GraphcolorfractionalSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_fractional_slice_len(s : GraphcolorfractionalSlice) -> Int { s.size }

pub fn graph_color_fractional_slice_get(s : GraphcolorfractionalSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_fractional_slice_set(s : GraphcolorfractionalSlice, i : Int, v : Double) -> GraphcolorfractionalSlice {
  let result = graph_color_fractional_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_fractional_slice_sum(s : GraphcolorfractionalSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_color_fractional_slice_mean(s : GraphcolorfractionalSlice) -> Double {
  if s.size == 0 { 0.0 } else { graph_color_fractional_slice_sum(s) / s.size.to_double() }
}

pub fn graph_color_fractional_slice_scale(s : GraphcolorfractionalSlice, f : Double) -> GraphcolorfractionalSlice {
  let result = graph_color_fractional_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_fractional_slice_add(a : GraphcolorfractionalSlice, b : GraphcolorfractionalSlice) -> GraphcolorfractionalSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_fractional_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_fractional_slice_copy(s : GraphcolorfractionalSlice) -> GraphcolorfractionalSlice {
  let result = graph_color_fractional_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_fractional_slice_fill(s : GraphcolorfractionalSlice, v : Double) -> GraphcolorfractionalSlice {
  let result = graph_color_fractional_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_fractional_slice_min(s : GraphcolorfractionalSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_fractional_slice_max(s : GraphcolorfractionalSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_fractional_slice_to_string(s : GraphcolorfractionalSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


///===
/// extcore/graph_search_bfs

pub(all) struct GraphsearchbfsPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_search_bfs_make_point(x : Double, y : Double) -> GraphsearchbfsPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_search_bfs_make_point3(x : Double, y : Double, z : Double) -> GraphsearchbfsPoint {
  { x, y, z, label: 0 }
}

pub fn graph_search_bfs_point_x(pt : GraphsearchbfsPoint) -> Double { pt.x }

pub fn graph_search_bfs_point_y(pt : GraphsearchbfsPoint) -> Double { pt.y }

pub fn graph_search_bfs_point_z(pt : GraphsearchbfsPoint) -> Double { pt.z }

pub fn graph_search_bfs_point_label(pt : GraphsearchbfsPoint) -> Int { pt.label }

pub fn graph_search_bfs_point_dist(a : GraphsearchbfsPoint, b : GraphsearchbfsPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn graph_search_bfs_point_add(a : GraphsearchbfsPoint, b : GraphsearchbfsPoint) -> GraphsearchbfsPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn graph_search_bfs_point_sub(a : GraphsearchbfsPoint, b : GraphsearchbfsPoint) -> GraphsearchbfsPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn graph_search_bfs_point_scale(pt : GraphsearchbfsPoint, s : Double) -> GraphsearchbfsPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn graph_search_bfs_point_dot(a : GraphsearchbfsPoint, b : GraphsearchbfsPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn graph_search_bfs_point_cross(a : GraphsearchbfsPoint, b : GraphsearchbfsPoint) -> GraphsearchbfsPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn graph_search_bfs_point_norm(pt : GraphsearchbfsPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn graph_search_bfs_point_normalize(pt : GraphsearchbfsPoint) -> GraphsearchbfsPoint {
  let n = graph_search_bfs_point_norm(pt)
  if n < 0.0000001 { pt } else { graph_search_bfs_point_scale(pt, 1.0 / n) }
}

pub fn graph_search_bfs_point_negate(pt : GraphsearchbfsPoint) -> GraphsearchbfsPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn graph_search_bfs_point_mid(a : GraphsearchbfsPoint, b : GraphsearchbfsPoint) -> GraphsearchbfsPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn graph_search_bfs_point_lerp(a : GraphsearchbfsPoint, b : GraphsearchbfsPoint, t : Double) -> GraphsearchbfsPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn graph_search_bfs_point_to_string(pt : GraphsearchbfsPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct GraphsearchbfsSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_search_bfs_make_series(vals : Array[Double], name : String) -> GraphsearchbfsSeries {
  { vals, name, meta: 0 }
}

pub fn graph_search_bfs_series_len(s : GraphsearchbfsSeries) -> Int { s.vals.length() }

pub fn graph_search_bfs_series_sum(s : GraphsearchbfsSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn graph_search_bfs_series_mean(s : GraphsearchbfsSeries) -> Double {
  let n = graph_search_bfs_series_len(s)
  if n == 0 { 0.0 } else { graph_search_bfs_series_sum(s) / n.to_double() }
}

pub fn graph_search_bfs_series_min(s : GraphsearchbfsSeries) -> Double {
  let n = graph_search_bfs_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn graph_search_bfs_series_max(s : GraphsearchbfsSeries) -> Double {
  let n = graph_search_bfs_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn graph_search_bfs_series_range(s : GraphsearchbfsSeries) -> Double {
  graph_search_bfs_series_max(s) - graph_search_bfs_series_min(s)
}

pub fn graph_search_bfs_series_var(s : GraphsearchbfsSeries) -> Double {
  let n = graph_search_bfs_series_len(s)
  if n == 0 { 0.0 } else {
    let m = graph_search_bfs_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn graph_search_bfs_series_std(s : GraphsearchbfsSeries) -> Double { @_common.sqrt(graph_search_bfs_series_var(s)) }

pub fn graph_search_bfs_series_median(s : GraphsearchbfsSeries) -> Double {
  let n = graph_search_bfs_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = graph_search_bfs_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn graph_search_bfs_series_scale(s : GraphsearchbfsSeries, f : Double) -> GraphsearchbfsSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn graph_search_bfs_series_add(a : GraphsearchbfsSeries, b : GraphsearchbfsSeries) -> GraphsearchbfsSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn graph_search_bfs_series_sub(a : GraphsearchbfsSeries, b : GraphsearchbfsSeries) -> GraphsearchbfsSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn graph_search_bfs_series_normalize(s : GraphsearchbfsSeries) -> GraphsearchbfsSeries {
  let mn = graph_search_bfs_series_min(s)
  let mx = graph_search_bfs_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn graph_search_bfs_series_cumsum(s : GraphsearchbfsSeries) -> GraphsearchbfsSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn graph_search_bfs_series_to_string(s : GraphsearchbfsSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphsearchbfsMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_search_bfs_make_matrix(rows : Int, cols : Int, val : Double) -> GraphsearchbfsMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_search_bfs_matrix_identity(n : Int) -> GraphsearchbfsMatrix {
  let m = graph_search_bfs_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn graph_search_bfs_matrix_get(m : GraphsearchbfsMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn graph_search_bfs_matrix_transpose(m : GraphsearchbfsMatrix) -> GraphsearchbfsMatrix {
  let result = graph_search_bfs_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn graph_search_bfs_matrix_add(a : GraphsearchbfsMatrix, b : GraphsearchbfsMatrix) -> GraphsearchbfsMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = graph_search_bfs_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn graph_search_bfs_matrix_scale(m : GraphsearchbfsMatrix, s : Double) -> GraphsearchbfsMatrix {
  let result = graph_search_bfs_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn graph_search_bfs_matrix_multiply(a : GraphsearchbfsMatrix, b : GraphsearchbfsMatrix) -> GraphsearchbfsMatrix {
  if a.cols != b.rows { return graph_search_bfs_make_matrix(a.rows, b.cols, 0.0) }
  let result = graph_search_bfs_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn graph_search_bfs_matrix_trace(m : GraphsearchbfsMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn graph_search_bfs_matrix_det(m : GraphsearchbfsMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn graph_search_bfs_matrix_norm(m : GraphsearchbfsMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn graph_search_bfs_matrix_to_string(m : GraphsearchbfsMatrix) -> String {
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

pub(all) struct GraphsearchbfsVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_search_bfs_make_vector(comps : Array[Double]) -> GraphsearchbfsVector {
  { comps, dim: comps.length() }
}

pub fn graph_search_bfs_vector_zero(dim : Int) -> GraphsearchbfsVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn graph_search_bfs_vector_add(a : GraphsearchbfsVector, b : GraphsearchbfsVector) -> GraphsearchbfsVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn graph_search_bfs_vector_sub(a : GraphsearchbfsVector, b : GraphsearchbfsVector) -> GraphsearchbfsVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn graph_search_bfs_vector_scale(v : GraphsearchbfsVector, s : Double) -> GraphsearchbfsVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn graph_search_bfs_vector_dot(a : GraphsearchbfsVector, b : GraphsearchbfsVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn graph_search_bfs_vector_norm(v : GraphsearchbfsVector) -> Double { @_common.sqrt(graph_search_bfs_vector_dot(v, v)) }

pub fn graph_search_bfs_vector_normalize(v : GraphsearchbfsVector) -> GraphsearchbfsVector {
  let n = graph_search_bfs_vector_norm(v)
  if n < 0.0000001 { v } else { graph_search_bfs_vector_scale(v, 1.0 / n) }
}

pub fn graph_search_bfs_vector_dist(a : GraphsearchbfsVector, b : GraphsearchbfsVector) -> Double {
  graph_search_bfs_vector_norm(graph_search_bfs_vector_sub(a, b))
}

pub fn graph_search_bfs_vector_to_string(v : GraphsearchbfsVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_search_bfs_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn graph_search_bfs_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn graph_search_bfs_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn graph_search_bfs_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn graph_search_bfs_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn graph_search_bfs_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn graph_search_bfs_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn graph_search_bfs_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn graph_search_bfs_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn graph_search_bfs_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn graph_search_bfs_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn graph_search_bfs_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn graph_search_bfs_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn graph_search_bfs_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn graph_search_bfs_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn graph_search_bfs_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn graph_search_bfs_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn graph_search_bfs_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn graph_search_bfs_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn graph_search_bfs_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn graph_search_bfs_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn graph_search_bfs_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn graph_search_bfs_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn graph_search_bfs_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn graph_search_bfs_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn graph_search_bfs_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn graph_search_bfs_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn graph_search_bfs_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn graph_search_bfs_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GraphsearchbfsFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bfs_frame_make(size : Int) -> GraphsearchbfsFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bfs_frame_len(s : GraphsearchbfsFrame) -> Int { s.size }

pub fn graph_search_bfs_frame_get(s : GraphsearchbfsFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bfs_frame_set(s : GraphsearchbfsFrame, i : Int, v : Double) -> GraphsearchbfsFrame {
  let result = graph_search_bfs_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_bfs_frame_sum(s : GraphsearchbfsFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_search_bfs_frame_mean(s : GraphsearchbfsFrame) -> Double {
  if s.size == 0 { 0.0 } else { graph_search_bfs_frame_sum(s) / s.size.to_double() }
}

pub fn graph_search_bfs_frame_scale(s : GraphsearchbfsFrame, f : Double) -> GraphsearchbfsFrame {
  let result = graph_search_bfs_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_bfs_frame_add(a : GraphsearchbfsFrame, b : GraphsearchbfsFrame) -> GraphsearchbfsFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_bfs_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_bfs_frame_copy(s : GraphsearchbfsFrame) -> GraphsearchbfsFrame {
  let result = graph_search_bfs_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_bfs_frame_fill(s : GraphsearchbfsFrame, v : Double) -> GraphsearchbfsFrame {
  let result = graph_search_bfs_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_bfs_frame_min(s : GraphsearchbfsFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_bfs_frame_max(s : GraphsearchbfsFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_bfs_frame_to_string(s : GraphsearchbfsFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchbfsTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bfs_table_make(size : Int) -> GraphsearchbfsTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bfs_table_len(s : GraphsearchbfsTable) -> Int { s.size }

pub fn graph_search_bfs_table_get(s : GraphsearchbfsTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bfs_table_set(s : GraphsearchbfsTable, i : Int, v : Double) -> GraphsearchbfsTable {
  let result = graph_search_bfs_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_bfs_table_sum(s : GraphsearchbfsTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_search_bfs_table_mean(s : GraphsearchbfsTable) -> Double {
  if s.size == 0 { 0.0 } else { graph_search_bfs_table_sum(s) / s.size.to_double() }
}

pub fn graph_search_bfs_table_scale(s : GraphsearchbfsTable, f : Double) -> GraphsearchbfsTable {
  let result = graph_search_bfs_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_bfs_table_add(a : GraphsearchbfsTable, b : GraphsearchbfsTable) -> GraphsearchbfsTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_bfs_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_bfs_table_copy(s : GraphsearchbfsTable) -> GraphsearchbfsTable {
  let result = graph_search_bfs_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_bfs_table_fill(s : GraphsearchbfsTable, v : Double) -> GraphsearchbfsTable {
  let result = graph_search_bfs_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_bfs_table_min(s : GraphsearchbfsTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_bfs_table_max(s : GraphsearchbfsTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_bfs_table_to_string(s : GraphsearchbfsTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchbfsGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bfs_graphn_make(size : Int) -> GraphsearchbfsGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bfs_graphn_len(s : GraphsearchbfsGraphN) -> Int { s.size }

pub fn graph_search_bfs_graphn_get(s : GraphsearchbfsGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bfs_graphn_set(s : GraphsearchbfsGraphN, i : Int, v : Double) -> GraphsearchbfsGraphN {
  let result = graph_search_bfs_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_bfs_graphn_sum(s : GraphsearchbfsGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_search_bfs_graphn_mean(s : GraphsearchbfsGraphN) -> Double {
  if s.size == 0 { 0.0 } else { graph_search_bfs_graphn_sum(s) / s.size.to_double() }
}

pub fn graph_search_bfs_graphn_scale(s : GraphsearchbfsGraphN, f : Double) -> GraphsearchbfsGraphN {
  let result = graph_search_bfs_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_bfs_graphn_add(a : GraphsearchbfsGraphN, b : GraphsearchbfsGraphN) -> GraphsearchbfsGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_bfs_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_bfs_graphn_copy(s : GraphsearchbfsGraphN) -> GraphsearchbfsGraphN {
  let result = graph_search_bfs_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_bfs_graphn_fill(s : GraphsearchbfsGraphN, v : Double) -> GraphsearchbfsGraphN {
  let result = graph_search_bfs_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_bfs_graphn_min(s : GraphsearchbfsGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_bfs_graphn_max(s : GraphsearchbfsGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_bfs_graphn_to_string(s : GraphsearchbfsGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchbfsNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bfs_node_make(size : Int) -> GraphsearchbfsNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bfs_node_len(s : GraphsearchbfsNode) -> Int { s.size }

pub fn graph_search_bfs_node_get(s : GraphsearchbfsNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bfs_node_set(s : GraphsearchbfsNode, i : Int, v : Double) -> GraphsearchbfsNode {
  let result = graph_search_bfs_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_bfs_node_sum(s : GraphsearchbfsNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_search_bfs_node_mean(s : GraphsearchbfsNode) -> Double {
  if s.size == 0 { 0.0 } else { graph_search_bfs_node_sum(s) / s.size.to_double() }
}

pub fn graph_search_bfs_node_scale(s : GraphsearchbfsNode, f : Double) -> GraphsearchbfsNode {
  let result = graph_search_bfs_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_bfs_node_add(a : GraphsearchbfsNode, b : GraphsearchbfsNode) -> GraphsearchbfsNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_bfs_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_bfs_node_copy(s : GraphsearchbfsNode) -> GraphsearchbfsNode {
  let result = graph_search_bfs_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_bfs_node_fill(s : GraphsearchbfsNode, v : Double) -> GraphsearchbfsNode {
  let result = graph_search_bfs_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_bfs_node_min(s : GraphsearchbfsNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_bfs_node_max(s : GraphsearchbfsNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_bfs_node_to_string(s : GraphsearchbfsNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchbfsEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bfs_edge_make(size : Int) -> GraphsearchbfsEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bfs_edge_len(s : GraphsearchbfsEdge) -> Int { s.size }

pub fn graph_search_bfs_edge_get(s : GraphsearchbfsEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bfs_edge_set(s : GraphsearchbfsEdge, i : Int, v : Double) -> GraphsearchbfsEdge {
  let result = graph_search_bfs_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_bfs_edge_sum(s : GraphsearchbfsEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_search_bfs_edge_mean(s : GraphsearchbfsEdge) -> Double {
  if s.size == 0 { 0.0 } else { graph_search_bfs_edge_sum(s) / s.size.to_double() }
}

pub fn graph_search_bfs_edge_scale(s : GraphsearchbfsEdge, f : Double) -> GraphsearchbfsEdge {
  let result = graph_search_bfs_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_bfs_edge_add(a : GraphsearchbfsEdge, b : GraphsearchbfsEdge) -> GraphsearchbfsEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_bfs_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_bfs_edge_copy(s : GraphsearchbfsEdge) -> GraphsearchbfsEdge {
  let result = graph_search_bfs_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_bfs_edge_fill(s : GraphsearchbfsEdge, v : Double) -> GraphsearchbfsEdge {
  let result = graph_search_bfs_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_bfs_edge_min(s : GraphsearchbfsEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_bfs_edge_max(s : GraphsearchbfsEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_bfs_edge_to_string(s : GraphsearchbfsEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchbfsPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bfs_path_make(size : Int) -> GraphsearchbfsPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bfs_path_len(s : GraphsearchbfsPath) -> Int { s.size }

pub fn graph_search_bfs_path_get(s : GraphsearchbfsPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bfs_path_set(s : GraphsearchbfsPath, i : Int, v : Double) -> GraphsearchbfsPath {
  let result = graph_search_bfs_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_bfs_path_sum(s : GraphsearchbfsPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_search_bfs_path_mean(s : GraphsearchbfsPath) -> Double {
  if s.size == 0 { 0.0 } else { graph_search_bfs_path_sum(s) / s.size.to_double() }
}

pub fn graph_search_bfs_path_scale(s : GraphsearchbfsPath, f : Double) -> GraphsearchbfsPath {
  let result = graph_search_bfs_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_bfs_path_add(a : GraphsearchbfsPath, b : GraphsearchbfsPath) -> GraphsearchbfsPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_bfs_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_bfs_path_copy(s : GraphsearchbfsPath) -> GraphsearchbfsPath {
  let result = graph_search_bfs_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_bfs_path_fill(s : GraphsearchbfsPath, v : Double) -> GraphsearchbfsPath {
  let result = graph_search_bfs_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_bfs_path_min(s : GraphsearchbfsPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_bfs_path_max(s : GraphsearchbfsPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_bfs_path_to_string(s : GraphsearchbfsPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchbfsCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bfs_cluster_make(size : Int) -> GraphsearchbfsCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bfs_cluster_len(s : GraphsearchbfsCluster) -> Int { s.size }

pub fn graph_search_bfs_cluster_get(s : GraphsearchbfsCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bfs_cluster_set(s : GraphsearchbfsCluster, i : Int, v : Double) -> GraphsearchbfsCluster {
  let result = graph_search_bfs_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_bfs_cluster_sum(s : GraphsearchbfsCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_search_bfs_cluster_mean(s : GraphsearchbfsCluster) -> Double {
  if s.size == 0 { 0.0 } else { graph_search_bfs_cluster_sum(s) / s.size.to_double() }
}

pub fn graph_search_bfs_cluster_scale(s : GraphsearchbfsCluster, f : Double) -> GraphsearchbfsCluster {
  let result = graph_search_bfs_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_bfs_cluster_add(a : GraphsearchbfsCluster, b : GraphsearchbfsCluster) -> GraphsearchbfsCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_bfs_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_bfs_cluster_copy(s : GraphsearchbfsCluster) -> GraphsearchbfsCluster {
  let result = graph_search_bfs_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_bfs_cluster_fill(s : GraphsearchbfsCluster, v : Double) -> GraphsearchbfsCluster {
  let result = graph_search_bfs_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_bfs_cluster_min(s : GraphsearchbfsCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_bfs_cluster_max(s : GraphsearchbfsCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_bfs_cluster_to_string(s : GraphsearchbfsCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchbfsModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bfs_model_make(size : Int) -> GraphsearchbfsModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bfs_model_len(s : GraphsearchbfsModel) -> Int { s.size }

pub fn graph_search_bfs_model_get(s : GraphsearchbfsModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bfs_model_set(s : GraphsearchbfsModel, i : Int, v : Double) -> GraphsearchbfsModel {
  let result = graph_search_bfs_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_bfs_model_sum(s : GraphsearchbfsModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_search_bfs_model_mean(s : GraphsearchbfsModel) -> Double {
  if s.size == 0 { 0.0 } else { graph_search_bfs_model_sum(s) / s.size.to_double() }
}

pub fn graph_search_bfs_model_scale(s : GraphsearchbfsModel, f : Double) -> GraphsearchbfsModel {
  let result = graph_search_bfs_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_bfs_model_add(a : GraphsearchbfsModel, b : GraphsearchbfsModel) -> GraphsearchbfsModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_bfs_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_bfs_model_copy(s : GraphsearchbfsModel) -> GraphsearchbfsModel {
  let result = graph_search_bfs_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_bfs_model_fill(s : GraphsearchbfsModel, v : Double) -> GraphsearchbfsModel {
  let result = graph_search_bfs_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_bfs_model_min(s : GraphsearchbfsModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_bfs_model_max(s : GraphsearchbfsModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_bfs_model_to_string(s : GraphsearchbfsModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchbfsLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bfs_layer_make(size : Int) -> GraphsearchbfsLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bfs_layer_len(s : GraphsearchbfsLayer) -> Int { s.size }

pub fn graph_search_bfs_layer_get(s : GraphsearchbfsLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bfs_layer_set(s : GraphsearchbfsLayer, i : Int, v : Double) -> GraphsearchbfsLayer {
  let result = graph_search_bfs_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_bfs_layer_sum(s : GraphsearchbfsLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_search_bfs_layer_mean(s : GraphsearchbfsLayer) -> Double {
  if s.size == 0 { 0.0 } else { graph_search_bfs_layer_sum(s) / s.size.to_double() }
}

pub fn graph_search_bfs_layer_scale(s : GraphsearchbfsLayer, f : Double) -> GraphsearchbfsLayer {
  let result = graph_search_bfs_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_bfs_layer_add(a : GraphsearchbfsLayer, b : GraphsearchbfsLayer) -> GraphsearchbfsLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_bfs_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_bfs_layer_copy(s : GraphsearchbfsLayer) -> GraphsearchbfsLayer {
  let result = graph_search_bfs_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_bfs_layer_fill(s : GraphsearchbfsLayer, v : Double) -> GraphsearchbfsLayer {
  let result = graph_search_bfs_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_bfs_layer_min(s : GraphsearchbfsLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_bfs_layer_max(s : GraphsearchbfsLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_bfs_layer_to_string(s : GraphsearchbfsLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchbfsBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bfs_buffer_make(size : Int) -> GraphsearchbfsBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bfs_buffer_len(s : GraphsearchbfsBuffer) -> Int { s.size }

pub fn graph_search_bfs_buffer_get(s : GraphsearchbfsBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bfs_buffer_set(s : GraphsearchbfsBuffer, i : Int, v : Double) -> GraphsearchbfsBuffer {
  let result = graph_search_bfs_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_bfs_buffer_sum(s : GraphsearchbfsBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_search_bfs_buffer_mean(s : GraphsearchbfsBuffer) -> Double {
  if s.size == 0 { 0.0 } else { graph_search_bfs_buffer_sum(s) / s.size.to_double() }
}

pub fn graph_search_bfs_buffer_scale(s : GraphsearchbfsBuffer, f : Double) -> GraphsearchbfsBuffer {
  let result = graph_search_bfs_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_bfs_buffer_add(a : GraphsearchbfsBuffer, b : GraphsearchbfsBuffer) -> GraphsearchbfsBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_bfs_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_bfs_buffer_copy(s : GraphsearchbfsBuffer) -> GraphsearchbfsBuffer {
  let result = graph_search_bfs_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_bfs_buffer_fill(s : GraphsearchbfsBuffer, v : Double) -> GraphsearchbfsBuffer {
  let result = graph_search_bfs_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_bfs_buffer_min(s : GraphsearchbfsBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_bfs_buffer_max(s : GraphsearchbfsBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_bfs_buffer_to_string(s : GraphsearchbfsBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchbfsCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bfs_cursor_make(size : Int) -> GraphsearchbfsCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bfs_cursor_len(s : GraphsearchbfsCursor) -> Int { s.size }

pub fn graph_search_bfs_cursor_get(s : GraphsearchbfsCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bfs_cursor_set(s : GraphsearchbfsCursor, i : Int, v : Double) -> GraphsearchbfsCursor {
  let result = graph_search_bfs_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_bfs_cursor_sum(s : GraphsearchbfsCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_search_bfs_cursor_mean(s : GraphsearchbfsCursor) -> Double {
  if s.size == 0 { 0.0 } else { graph_search_bfs_cursor_sum(s) / s.size.to_double() }
}

pub fn graph_search_bfs_cursor_scale(s : GraphsearchbfsCursor, f : Double) -> GraphsearchbfsCursor {
  let result = graph_search_bfs_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_bfs_cursor_add(a : GraphsearchbfsCursor, b : GraphsearchbfsCursor) -> GraphsearchbfsCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_bfs_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_bfs_cursor_copy(s : GraphsearchbfsCursor) -> GraphsearchbfsCursor {
  let result = graph_search_bfs_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_bfs_cursor_fill(s : GraphsearchbfsCursor, v : Double) -> GraphsearchbfsCursor {
  let result = graph_search_bfs_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_bfs_cursor_min(s : GraphsearchbfsCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_bfs_cursor_max(s : GraphsearchbfsCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_bfs_cursor_to_string(s : GraphsearchbfsCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchbfsView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bfs_view_make(size : Int) -> GraphsearchbfsView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bfs_view_len(s : GraphsearchbfsView) -> Int { s.size }

pub fn graph_search_bfs_view_get(s : GraphsearchbfsView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bfs_view_set(s : GraphsearchbfsView, i : Int, v : Double) -> GraphsearchbfsView {
  let result = graph_search_bfs_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_bfs_view_sum(s : GraphsearchbfsView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_search_bfs_view_mean(s : GraphsearchbfsView) -> Double {
  if s.size == 0 { 0.0 } else { graph_search_bfs_view_sum(s) / s.size.to_double() }
}

pub fn graph_search_bfs_view_scale(s : GraphsearchbfsView, f : Double) -> GraphsearchbfsView {
  let result = graph_search_bfs_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_bfs_view_add(a : GraphsearchbfsView, b : GraphsearchbfsView) -> GraphsearchbfsView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_bfs_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_bfs_view_copy(s : GraphsearchbfsView) -> GraphsearchbfsView {
  let result = graph_search_bfs_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_bfs_view_fill(s : GraphsearchbfsView, v : Double) -> GraphsearchbfsView {
  let result = graph_search_bfs_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_bfs_view_min(s : GraphsearchbfsView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_bfs_view_max(s : GraphsearchbfsView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_bfs_view_to_string(s : GraphsearchbfsView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchbfsRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bfs_range_make(size : Int) -> GraphsearchbfsRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bfs_range_len(s : GraphsearchbfsRange) -> Int { s.size }

pub fn graph_search_bfs_range_get(s : GraphsearchbfsRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bfs_range_set(s : GraphsearchbfsRange, i : Int, v : Double) -> GraphsearchbfsRange {
  let result = graph_search_bfs_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_bfs_range_sum(s : GraphsearchbfsRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_search_bfs_range_mean(s : GraphsearchbfsRange) -> Double {
  if s.size == 0 { 0.0 } else { graph_search_bfs_range_sum(s) / s.size.to_double() }
}

pub fn graph_search_bfs_range_scale(s : GraphsearchbfsRange, f : Double) -> GraphsearchbfsRange {
  let result = graph_search_bfs_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_bfs_range_add(a : GraphsearchbfsRange, b : GraphsearchbfsRange) -> GraphsearchbfsRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_bfs_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_bfs_range_copy(s : GraphsearchbfsRange) -> GraphsearchbfsRange {
  let result = graph_search_bfs_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_bfs_range_fill(s : GraphsearchbfsRange, v : Double) -> GraphsearchbfsRange {
  let result = graph_search_bfs_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_bfs_range_min(s : GraphsearchbfsRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_bfs_range_max(s : GraphsearchbfsRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_bfs_range_to_string(s : GraphsearchbfsRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchbfsSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bfs_slice_make(size : Int) -> GraphsearchbfsSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bfs_slice_len(s : GraphsearchbfsSlice) -> Int { s.size }

pub fn graph_search_bfs_slice_get(s : GraphsearchbfsSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bfs_slice_set(s : GraphsearchbfsSlice, i : Int, v : Double) -> GraphsearchbfsSlice {
  let result = graph_search_bfs_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_bfs_slice_sum(s : GraphsearchbfsSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_search_bfs_slice_mean(s : GraphsearchbfsSlice) -> Double {
  if s.size == 0 { 0.0 } else { graph_search_bfs_slice_sum(s) / s.size.to_double() }
}

pub fn graph_search_bfs_slice_scale(s : GraphsearchbfsSlice, f : Double) -> GraphsearchbfsSlice {
  let result = graph_search_bfs_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_bfs_slice_add(a : GraphsearchbfsSlice, b : GraphsearchbfsSlice) -> GraphsearchbfsSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_bfs_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_bfs_slice_copy(s : GraphsearchbfsSlice) -> GraphsearchbfsSlice {
  let result = graph_search_bfs_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_bfs_slice_fill(s : GraphsearchbfsSlice, v : Double) -> GraphsearchbfsSlice {
  let result = graph_search_bfs_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_bfs_slice_min(s : GraphsearchbfsSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_bfs_slice_max(s : GraphsearchbfsSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_bfs_slice_to_string(s : GraphsearchbfsSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


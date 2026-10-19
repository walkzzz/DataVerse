///===
/// extcore/ds_graph_adj_matrix

pub(all) struct DsgraphadjmatrixPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_graph_adj_matrix_make_point(x : Double, y : Double) -> DsgraphadjmatrixPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_graph_adj_matrix_make_point3(x : Double, y : Double, z : Double) -> DsgraphadjmatrixPoint {
  { x, y, z, label: 0 }
}

pub fn ds_graph_adj_matrix_point_x(pt : DsgraphadjmatrixPoint) -> Double { pt.x }

pub fn ds_graph_adj_matrix_point_y(pt : DsgraphadjmatrixPoint) -> Double { pt.y }

pub fn ds_graph_adj_matrix_point_z(pt : DsgraphadjmatrixPoint) -> Double { pt.z }

pub fn ds_graph_adj_matrix_point_label(pt : DsgraphadjmatrixPoint) -> Int { pt.label }

pub fn ds_graph_adj_matrix_point_dist(a : DsgraphadjmatrixPoint, b : DsgraphadjmatrixPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ds_graph_adj_matrix_point_add(a : DsgraphadjmatrixPoint, b : DsgraphadjmatrixPoint) -> DsgraphadjmatrixPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ds_graph_adj_matrix_point_sub(a : DsgraphadjmatrixPoint, b : DsgraphadjmatrixPoint) -> DsgraphadjmatrixPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ds_graph_adj_matrix_point_scale(pt : DsgraphadjmatrixPoint, s : Double) -> DsgraphadjmatrixPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ds_graph_adj_matrix_point_dot(a : DsgraphadjmatrixPoint, b : DsgraphadjmatrixPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ds_graph_adj_matrix_point_cross(a : DsgraphadjmatrixPoint, b : DsgraphadjmatrixPoint) -> DsgraphadjmatrixPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ds_graph_adj_matrix_point_norm(pt : DsgraphadjmatrixPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ds_graph_adj_matrix_point_normalize(pt : DsgraphadjmatrixPoint) -> DsgraphadjmatrixPoint {
  let n = ds_graph_adj_matrix_point_norm(pt)
  if n < 0.0000001 { pt } else { ds_graph_adj_matrix_point_scale(pt, 1.0 / n) }
}

pub fn ds_graph_adj_matrix_point_negate(pt : DsgraphadjmatrixPoint) -> DsgraphadjmatrixPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ds_graph_adj_matrix_point_mid(a : DsgraphadjmatrixPoint, b : DsgraphadjmatrixPoint) -> DsgraphadjmatrixPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ds_graph_adj_matrix_point_lerp(a : DsgraphadjmatrixPoint, b : DsgraphadjmatrixPoint, t : Double) -> DsgraphadjmatrixPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ds_graph_adj_matrix_point_to_string(pt : DsgraphadjmatrixPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DsgraphadjmatrixSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_graph_adj_matrix_make_series(vals : Array[Double], name : String) -> DsgraphadjmatrixSeries {
  { vals, name, meta: 0 }
}

pub fn ds_graph_adj_matrix_series_len(s : DsgraphadjmatrixSeries) -> Int { s.vals.length() }

pub fn ds_graph_adj_matrix_series_sum(s : DsgraphadjmatrixSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn ds_graph_adj_matrix_series_mean(s : DsgraphadjmatrixSeries) -> Double {
  let n = ds_graph_adj_matrix_series_len(s)
  if n == 0 { 0.0 } else { ds_graph_adj_matrix_series_sum(s) / n.to_double() }
}

pub fn ds_graph_adj_matrix_series_min(s : DsgraphadjmatrixSeries) -> Double {
  let n = ds_graph_adj_matrix_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn ds_graph_adj_matrix_series_max(s : DsgraphadjmatrixSeries) -> Double {
  let n = ds_graph_adj_matrix_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn ds_graph_adj_matrix_series_range(s : DsgraphadjmatrixSeries) -> Double {
  ds_graph_adj_matrix_series_max(s) - ds_graph_adj_matrix_series_min(s)
}

pub fn ds_graph_adj_matrix_series_var(s : DsgraphadjmatrixSeries) -> Double {
  let n = ds_graph_adj_matrix_series_len(s)
  if n == 0 { 0.0 } else {
    let m = ds_graph_adj_matrix_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn ds_graph_adj_matrix_series_std(s : DsgraphadjmatrixSeries) -> Double { @_common.sqrt(ds_graph_adj_matrix_series_var(s)) }

pub fn ds_graph_adj_matrix_series_median(s : DsgraphadjmatrixSeries) -> Double {
  let n = ds_graph_adj_matrix_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = ds_graph_adj_matrix_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ds_graph_adj_matrix_series_scale(s : DsgraphadjmatrixSeries, f : Double) -> DsgraphadjmatrixSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ds_graph_adj_matrix_series_add(a : DsgraphadjmatrixSeries, b : DsgraphadjmatrixSeries) -> DsgraphadjmatrixSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ds_graph_adj_matrix_series_sub(a : DsgraphadjmatrixSeries, b : DsgraphadjmatrixSeries) -> DsgraphadjmatrixSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ds_graph_adj_matrix_series_normalize(s : DsgraphadjmatrixSeries) -> DsgraphadjmatrixSeries {
  let mn = ds_graph_adj_matrix_series_min(s)
  let mx = ds_graph_adj_matrix_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ds_graph_adj_matrix_series_cumsum(s : DsgraphadjmatrixSeries) -> DsgraphadjmatrixSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn ds_graph_adj_matrix_series_to_string(s : DsgraphadjmatrixSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DsgraphadjmatrixMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_graph_adj_matrix_make_matrix(rows : Int, cols : Int, val : Double) -> DsgraphadjmatrixMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_graph_adj_matrix_matrix_identity(n : Int) -> DsgraphadjmatrixMatrix {
  let m = ds_graph_adj_matrix_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ds_graph_adj_matrix_matrix_get(m : DsgraphadjmatrixMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ds_graph_adj_matrix_matrix_transpose(m : DsgraphadjmatrixMatrix) -> DsgraphadjmatrixMatrix {
  let result = ds_graph_adj_matrix_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ds_graph_adj_matrix_matrix_add(a : DsgraphadjmatrixMatrix, b : DsgraphadjmatrixMatrix) -> DsgraphadjmatrixMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ds_graph_adj_matrix_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ds_graph_adj_matrix_matrix_scale(m : DsgraphadjmatrixMatrix, s : Double) -> DsgraphadjmatrixMatrix {
  let result = ds_graph_adj_matrix_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ds_graph_adj_matrix_matrix_multiply(a : DsgraphadjmatrixMatrix, b : DsgraphadjmatrixMatrix) -> DsgraphadjmatrixMatrix {
  if a.cols != b.rows { return ds_graph_adj_matrix_make_matrix(a.rows, b.cols, 0.0) }
  let result = ds_graph_adj_matrix_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ds_graph_adj_matrix_matrix_trace(m : DsgraphadjmatrixMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ds_graph_adj_matrix_matrix_det(m : DsgraphadjmatrixMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ds_graph_adj_matrix_matrix_norm(m : DsgraphadjmatrixMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ds_graph_adj_matrix_matrix_to_string(m : DsgraphadjmatrixMatrix) -> String {
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

pub(all) struct DsgraphadjmatrixVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_graph_adj_matrix_make_vector(comps : Array[Double]) -> DsgraphadjmatrixVector {
  { comps, dim: comps.length() }
}

pub fn ds_graph_adj_matrix_vector_zero(dim : Int) -> DsgraphadjmatrixVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ds_graph_adj_matrix_vector_add(a : DsgraphadjmatrixVector, b : DsgraphadjmatrixVector) -> DsgraphadjmatrixVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_graph_adj_matrix_vector_sub(a : DsgraphadjmatrixVector, b : DsgraphadjmatrixVector) -> DsgraphadjmatrixVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_graph_adj_matrix_vector_scale(v : DsgraphadjmatrixVector, s : Double) -> DsgraphadjmatrixVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ds_graph_adj_matrix_vector_dot(a : DsgraphadjmatrixVector, b : DsgraphadjmatrixVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ds_graph_adj_matrix_vector_norm(v : DsgraphadjmatrixVector) -> Double { @_common.sqrt(ds_graph_adj_matrix_vector_dot(v, v)) }

pub fn ds_graph_adj_matrix_vector_normalize(v : DsgraphadjmatrixVector) -> DsgraphadjmatrixVector {
  let n = ds_graph_adj_matrix_vector_norm(v)
  if n < 0.0000001 { v } else { ds_graph_adj_matrix_vector_scale(v, 1.0 / n) }
}

pub fn ds_graph_adj_matrix_vector_dist(a : DsgraphadjmatrixVector, b : DsgraphadjmatrixVector) -> Double {
  ds_graph_adj_matrix_vector_norm(ds_graph_adj_matrix_vector_sub(a, b))
}

pub fn ds_graph_adj_matrix_vector_to_string(v : DsgraphadjmatrixVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_graph_adj_matrix_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ds_graph_adj_matrix_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ds_graph_adj_matrix_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ds_graph_adj_matrix_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ds_graph_adj_matrix_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ds_graph_adj_matrix_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ds_graph_adj_matrix_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ds_graph_adj_matrix_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ds_graph_adj_matrix_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ds_graph_adj_matrix_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ds_graph_adj_matrix_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ds_graph_adj_matrix_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ds_graph_adj_matrix_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ds_graph_adj_matrix_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ds_graph_adj_matrix_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ds_graph_adj_matrix_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ds_graph_adj_matrix_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ds_graph_adj_matrix_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ds_graph_adj_matrix_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ds_graph_adj_matrix_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ds_graph_adj_matrix_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ds_graph_adj_matrix_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ds_graph_adj_matrix_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ds_graph_adj_matrix_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ds_graph_adj_matrix_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ds_graph_adj_matrix_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ds_graph_adj_matrix_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ds_graph_adj_matrix_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ds_graph_adj_matrix_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DsgraphadjmatrixFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_adj_matrix_frame_make(size : Int) -> DsgraphadjmatrixFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_adj_matrix_frame_len(s : DsgraphadjmatrixFrame) -> Int { s.size }

pub fn ds_graph_adj_matrix_frame_get(s : DsgraphadjmatrixFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_adj_matrix_frame_set(s : DsgraphadjmatrixFrame, i : Int, v : Double) -> DsgraphadjmatrixFrame {
  let result = ds_graph_adj_matrix_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_adj_matrix_frame_sum(s : DsgraphadjmatrixFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_adj_matrix_frame_mean(s : DsgraphadjmatrixFrame) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_adj_matrix_frame_sum(s) / s.size.to_double() }
}

pub fn ds_graph_adj_matrix_frame_scale(s : DsgraphadjmatrixFrame, f : Double) -> DsgraphadjmatrixFrame {
  let result = ds_graph_adj_matrix_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_adj_matrix_frame_add(a : DsgraphadjmatrixFrame, b : DsgraphadjmatrixFrame) -> DsgraphadjmatrixFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_adj_matrix_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_adj_matrix_frame_copy(s : DsgraphadjmatrixFrame) -> DsgraphadjmatrixFrame {
  let result = ds_graph_adj_matrix_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_adj_matrix_frame_fill(s : DsgraphadjmatrixFrame, v : Double) -> DsgraphadjmatrixFrame {
  let result = ds_graph_adj_matrix_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_adj_matrix_frame_min(s : DsgraphadjmatrixFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_adj_matrix_frame_max(s : DsgraphadjmatrixFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_adj_matrix_frame_to_string(s : DsgraphadjmatrixFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphadjmatrixTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_adj_matrix_table_make(size : Int) -> DsgraphadjmatrixTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_adj_matrix_table_len(s : DsgraphadjmatrixTable) -> Int { s.size }

pub fn ds_graph_adj_matrix_table_get(s : DsgraphadjmatrixTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_adj_matrix_table_set(s : DsgraphadjmatrixTable, i : Int, v : Double) -> DsgraphadjmatrixTable {
  let result = ds_graph_adj_matrix_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_adj_matrix_table_sum(s : DsgraphadjmatrixTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_adj_matrix_table_mean(s : DsgraphadjmatrixTable) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_adj_matrix_table_sum(s) / s.size.to_double() }
}

pub fn ds_graph_adj_matrix_table_scale(s : DsgraphadjmatrixTable, f : Double) -> DsgraphadjmatrixTable {
  let result = ds_graph_adj_matrix_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_adj_matrix_table_add(a : DsgraphadjmatrixTable, b : DsgraphadjmatrixTable) -> DsgraphadjmatrixTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_adj_matrix_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_adj_matrix_table_copy(s : DsgraphadjmatrixTable) -> DsgraphadjmatrixTable {
  let result = ds_graph_adj_matrix_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_adj_matrix_table_fill(s : DsgraphadjmatrixTable, v : Double) -> DsgraphadjmatrixTable {
  let result = ds_graph_adj_matrix_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_adj_matrix_table_min(s : DsgraphadjmatrixTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_adj_matrix_table_max(s : DsgraphadjmatrixTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_adj_matrix_table_to_string(s : DsgraphadjmatrixTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphadjmatrixGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_adj_matrix_graphn_make(size : Int) -> DsgraphadjmatrixGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_adj_matrix_graphn_len(s : DsgraphadjmatrixGraphN) -> Int { s.size }

pub fn ds_graph_adj_matrix_graphn_get(s : DsgraphadjmatrixGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_adj_matrix_graphn_set(s : DsgraphadjmatrixGraphN, i : Int, v : Double) -> DsgraphadjmatrixGraphN {
  let result = ds_graph_adj_matrix_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_adj_matrix_graphn_sum(s : DsgraphadjmatrixGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_adj_matrix_graphn_mean(s : DsgraphadjmatrixGraphN) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_adj_matrix_graphn_sum(s) / s.size.to_double() }
}

pub fn ds_graph_adj_matrix_graphn_scale(s : DsgraphadjmatrixGraphN, f : Double) -> DsgraphadjmatrixGraphN {
  let result = ds_graph_adj_matrix_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_adj_matrix_graphn_add(a : DsgraphadjmatrixGraphN, b : DsgraphadjmatrixGraphN) -> DsgraphadjmatrixGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_adj_matrix_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_adj_matrix_graphn_copy(s : DsgraphadjmatrixGraphN) -> DsgraphadjmatrixGraphN {
  let result = ds_graph_adj_matrix_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_adj_matrix_graphn_fill(s : DsgraphadjmatrixGraphN, v : Double) -> DsgraphadjmatrixGraphN {
  let result = ds_graph_adj_matrix_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_adj_matrix_graphn_min(s : DsgraphadjmatrixGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_adj_matrix_graphn_max(s : DsgraphadjmatrixGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_adj_matrix_graphn_to_string(s : DsgraphadjmatrixGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphadjmatrixNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_adj_matrix_node_make(size : Int) -> DsgraphadjmatrixNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_adj_matrix_node_len(s : DsgraphadjmatrixNode) -> Int { s.size }

pub fn ds_graph_adj_matrix_node_get(s : DsgraphadjmatrixNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_adj_matrix_node_set(s : DsgraphadjmatrixNode, i : Int, v : Double) -> DsgraphadjmatrixNode {
  let result = ds_graph_adj_matrix_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_adj_matrix_node_sum(s : DsgraphadjmatrixNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_adj_matrix_node_mean(s : DsgraphadjmatrixNode) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_adj_matrix_node_sum(s) / s.size.to_double() }
}

pub fn ds_graph_adj_matrix_node_scale(s : DsgraphadjmatrixNode, f : Double) -> DsgraphadjmatrixNode {
  let result = ds_graph_adj_matrix_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_adj_matrix_node_add(a : DsgraphadjmatrixNode, b : DsgraphadjmatrixNode) -> DsgraphadjmatrixNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_adj_matrix_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_adj_matrix_node_copy(s : DsgraphadjmatrixNode) -> DsgraphadjmatrixNode {
  let result = ds_graph_adj_matrix_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_adj_matrix_node_fill(s : DsgraphadjmatrixNode, v : Double) -> DsgraphadjmatrixNode {
  let result = ds_graph_adj_matrix_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_adj_matrix_node_min(s : DsgraphadjmatrixNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_adj_matrix_node_max(s : DsgraphadjmatrixNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_adj_matrix_node_to_string(s : DsgraphadjmatrixNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphadjmatrixEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_adj_matrix_edge_make(size : Int) -> DsgraphadjmatrixEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_adj_matrix_edge_len(s : DsgraphadjmatrixEdge) -> Int { s.size }

pub fn ds_graph_adj_matrix_edge_get(s : DsgraphadjmatrixEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_adj_matrix_edge_set(s : DsgraphadjmatrixEdge, i : Int, v : Double) -> DsgraphadjmatrixEdge {
  let result = ds_graph_adj_matrix_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_adj_matrix_edge_sum(s : DsgraphadjmatrixEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_adj_matrix_edge_mean(s : DsgraphadjmatrixEdge) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_adj_matrix_edge_sum(s) / s.size.to_double() }
}

pub fn ds_graph_adj_matrix_edge_scale(s : DsgraphadjmatrixEdge, f : Double) -> DsgraphadjmatrixEdge {
  let result = ds_graph_adj_matrix_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_adj_matrix_edge_add(a : DsgraphadjmatrixEdge, b : DsgraphadjmatrixEdge) -> DsgraphadjmatrixEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_adj_matrix_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_adj_matrix_edge_copy(s : DsgraphadjmatrixEdge) -> DsgraphadjmatrixEdge {
  let result = ds_graph_adj_matrix_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_adj_matrix_edge_fill(s : DsgraphadjmatrixEdge, v : Double) -> DsgraphadjmatrixEdge {
  let result = ds_graph_adj_matrix_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_adj_matrix_edge_min(s : DsgraphadjmatrixEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_adj_matrix_edge_max(s : DsgraphadjmatrixEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_adj_matrix_edge_to_string(s : DsgraphadjmatrixEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphadjmatrixPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_adj_matrix_path_make(size : Int) -> DsgraphadjmatrixPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_adj_matrix_path_len(s : DsgraphadjmatrixPath) -> Int { s.size }

pub fn ds_graph_adj_matrix_path_get(s : DsgraphadjmatrixPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_adj_matrix_path_set(s : DsgraphadjmatrixPath, i : Int, v : Double) -> DsgraphadjmatrixPath {
  let result = ds_graph_adj_matrix_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_adj_matrix_path_sum(s : DsgraphadjmatrixPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_adj_matrix_path_mean(s : DsgraphadjmatrixPath) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_adj_matrix_path_sum(s) / s.size.to_double() }
}

pub fn ds_graph_adj_matrix_path_scale(s : DsgraphadjmatrixPath, f : Double) -> DsgraphadjmatrixPath {
  let result = ds_graph_adj_matrix_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_adj_matrix_path_add(a : DsgraphadjmatrixPath, b : DsgraphadjmatrixPath) -> DsgraphadjmatrixPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_adj_matrix_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_adj_matrix_path_copy(s : DsgraphadjmatrixPath) -> DsgraphadjmatrixPath {
  let result = ds_graph_adj_matrix_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_adj_matrix_path_fill(s : DsgraphadjmatrixPath, v : Double) -> DsgraphadjmatrixPath {
  let result = ds_graph_adj_matrix_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_adj_matrix_path_min(s : DsgraphadjmatrixPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_adj_matrix_path_max(s : DsgraphadjmatrixPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_adj_matrix_path_to_string(s : DsgraphadjmatrixPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphadjmatrixCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_adj_matrix_cluster_make(size : Int) -> DsgraphadjmatrixCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_adj_matrix_cluster_len(s : DsgraphadjmatrixCluster) -> Int { s.size }

pub fn ds_graph_adj_matrix_cluster_get(s : DsgraphadjmatrixCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_adj_matrix_cluster_set(s : DsgraphadjmatrixCluster, i : Int, v : Double) -> DsgraphadjmatrixCluster {
  let result = ds_graph_adj_matrix_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_adj_matrix_cluster_sum(s : DsgraphadjmatrixCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_adj_matrix_cluster_mean(s : DsgraphadjmatrixCluster) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_adj_matrix_cluster_sum(s) / s.size.to_double() }
}

pub fn ds_graph_adj_matrix_cluster_scale(s : DsgraphadjmatrixCluster, f : Double) -> DsgraphadjmatrixCluster {
  let result = ds_graph_adj_matrix_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_adj_matrix_cluster_add(a : DsgraphadjmatrixCluster, b : DsgraphadjmatrixCluster) -> DsgraphadjmatrixCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_adj_matrix_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_adj_matrix_cluster_copy(s : DsgraphadjmatrixCluster) -> DsgraphadjmatrixCluster {
  let result = ds_graph_adj_matrix_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_adj_matrix_cluster_fill(s : DsgraphadjmatrixCluster, v : Double) -> DsgraphadjmatrixCluster {
  let result = ds_graph_adj_matrix_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_adj_matrix_cluster_min(s : DsgraphadjmatrixCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_adj_matrix_cluster_max(s : DsgraphadjmatrixCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_adj_matrix_cluster_to_string(s : DsgraphadjmatrixCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphadjmatrixModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_adj_matrix_model_make(size : Int) -> DsgraphadjmatrixModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_adj_matrix_model_len(s : DsgraphadjmatrixModel) -> Int { s.size }

pub fn ds_graph_adj_matrix_model_get(s : DsgraphadjmatrixModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_adj_matrix_model_set(s : DsgraphadjmatrixModel, i : Int, v : Double) -> DsgraphadjmatrixModel {
  let result = ds_graph_adj_matrix_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_adj_matrix_model_sum(s : DsgraphadjmatrixModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_adj_matrix_model_mean(s : DsgraphadjmatrixModel) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_adj_matrix_model_sum(s) / s.size.to_double() }
}

pub fn ds_graph_adj_matrix_model_scale(s : DsgraphadjmatrixModel, f : Double) -> DsgraphadjmatrixModel {
  let result = ds_graph_adj_matrix_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_adj_matrix_model_add(a : DsgraphadjmatrixModel, b : DsgraphadjmatrixModel) -> DsgraphadjmatrixModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_adj_matrix_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_adj_matrix_model_copy(s : DsgraphadjmatrixModel) -> DsgraphadjmatrixModel {
  let result = ds_graph_adj_matrix_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_adj_matrix_model_fill(s : DsgraphadjmatrixModel, v : Double) -> DsgraphadjmatrixModel {
  let result = ds_graph_adj_matrix_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_adj_matrix_model_min(s : DsgraphadjmatrixModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_adj_matrix_model_max(s : DsgraphadjmatrixModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_adj_matrix_model_to_string(s : DsgraphadjmatrixModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphadjmatrixLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_adj_matrix_layer_make(size : Int) -> DsgraphadjmatrixLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_adj_matrix_layer_len(s : DsgraphadjmatrixLayer) -> Int { s.size }

pub fn ds_graph_adj_matrix_layer_get(s : DsgraphadjmatrixLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_adj_matrix_layer_set(s : DsgraphadjmatrixLayer, i : Int, v : Double) -> DsgraphadjmatrixLayer {
  let result = ds_graph_adj_matrix_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_adj_matrix_layer_sum(s : DsgraphadjmatrixLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_adj_matrix_layer_mean(s : DsgraphadjmatrixLayer) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_adj_matrix_layer_sum(s) / s.size.to_double() }
}

pub fn ds_graph_adj_matrix_layer_scale(s : DsgraphadjmatrixLayer, f : Double) -> DsgraphadjmatrixLayer {
  let result = ds_graph_adj_matrix_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_adj_matrix_layer_add(a : DsgraphadjmatrixLayer, b : DsgraphadjmatrixLayer) -> DsgraphadjmatrixLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_adj_matrix_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_adj_matrix_layer_copy(s : DsgraphadjmatrixLayer) -> DsgraphadjmatrixLayer {
  let result = ds_graph_adj_matrix_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_adj_matrix_layer_fill(s : DsgraphadjmatrixLayer, v : Double) -> DsgraphadjmatrixLayer {
  let result = ds_graph_adj_matrix_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_adj_matrix_layer_min(s : DsgraphadjmatrixLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_adj_matrix_layer_max(s : DsgraphadjmatrixLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_adj_matrix_layer_to_string(s : DsgraphadjmatrixLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphadjmatrixBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_adj_matrix_buffer_make(size : Int) -> DsgraphadjmatrixBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_adj_matrix_buffer_len(s : DsgraphadjmatrixBuffer) -> Int { s.size }

pub fn ds_graph_adj_matrix_buffer_get(s : DsgraphadjmatrixBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_adj_matrix_buffer_set(s : DsgraphadjmatrixBuffer, i : Int, v : Double) -> DsgraphadjmatrixBuffer {
  let result = ds_graph_adj_matrix_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_adj_matrix_buffer_sum(s : DsgraphadjmatrixBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_adj_matrix_buffer_mean(s : DsgraphadjmatrixBuffer) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_adj_matrix_buffer_sum(s) / s.size.to_double() }
}

pub fn ds_graph_adj_matrix_buffer_scale(s : DsgraphadjmatrixBuffer, f : Double) -> DsgraphadjmatrixBuffer {
  let result = ds_graph_adj_matrix_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_adj_matrix_buffer_add(a : DsgraphadjmatrixBuffer, b : DsgraphadjmatrixBuffer) -> DsgraphadjmatrixBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_adj_matrix_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_adj_matrix_buffer_copy(s : DsgraphadjmatrixBuffer) -> DsgraphadjmatrixBuffer {
  let result = ds_graph_adj_matrix_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_adj_matrix_buffer_fill(s : DsgraphadjmatrixBuffer, v : Double) -> DsgraphadjmatrixBuffer {
  let result = ds_graph_adj_matrix_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_adj_matrix_buffer_min(s : DsgraphadjmatrixBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_adj_matrix_buffer_max(s : DsgraphadjmatrixBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_adj_matrix_buffer_to_string(s : DsgraphadjmatrixBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphadjmatrixCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_adj_matrix_cursor_make(size : Int) -> DsgraphadjmatrixCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_adj_matrix_cursor_len(s : DsgraphadjmatrixCursor) -> Int { s.size }

pub fn ds_graph_adj_matrix_cursor_get(s : DsgraphadjmatrixCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_adj_matrix_cursor_set(s : DsgraphadjmatrixCursor, i : Int, v : Double) -> DsgraphadjmatrixCursor {
  let result = ds_graph_adj_matrix_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_adj_matrix_cursor_sum(s : DsgraphadjmatrixCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_adj_matrix_cursor_mean(s : DsgraphadjmatrixCursor) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_adj_matrix_cursor_sum(s) / s.size.to_double() }
}

pub fn ds_graph_adj_matrix_cursor_scale(s : DsgraphadjmatrixCursor, f : Double) -> DsgraphadjmatrixCursor {
  let result = ds_graph_adj_matrix_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_adj_matrix_cursor_add(a : DsgraphadjmatrixCursor, b : DsgraphadjmatrixCursor) -> DsgraphadjmatrixCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_adj_matrix_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_adj_matrix_cursor_copy(s : DsgraphadjmatrixCursor) -> DsgraphadjmatrixCursor {
  let result = ds_graph_adj_matrix_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_adj_matrix_cursor_fill(s : DsgraphadjmatrixCursor, v : Double) -> DsgraphadjmatrixCursor {
  let result = ds_graph_adj_matrix_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_adj_matrix_cursor_min(s : DsgraphadjmatrixCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_adj_matrix_cursor_max(s : DsgraphadjmatrixCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_adj_matrix_cursor_to_string(s : DsgraphadjmatrixCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphadjmatrixView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_adj_matrix_view_make(size : Int) -> DsgraphadjmatrixView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_adj_matrix_view_len(s : DsgraphadjmatrixView) -> Int { s.size }

pub fn ds_graph_adj_matrix_view_get(s : DsgraphadjmatrixView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_adj_matrix_view_set(s : DsgraphadjmatrixView, i : Int, v : Double) -> DsgraphadjmatrixView {
  let result = ds_graph_adj_matrix_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_adj_matrix_view_sum(s : DsgraphadjmatrixView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_adj_matrix_view_mean(s : DsgraphadjmatrixView) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_adj_matrix_view_sum(s) / s.size.to_double() }
}

pub fn ds_graph_adj_matrix_view_scale(s : DsgraphadjmatrixView, f : Double) -> DsgraphadjmatrixView {
  let result = ds_graph_adj_matrix_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_adj_matrix_view_add(a : DsgraphadjmatrixView, b : DsgraphadjmatrixView) -> DsgraphadjmatrixView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_adj_matrix_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_adj_matrix_view_copy(s : DsgraphadjmatrixView) -> DsgraphadjmatrixView {
  let result = ds_graph_adj_matrix_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_adj_matrix_view_fill(s : DsgraphadjmatrixView, v : Double) -> DsgraphadjmatrixView {
  let result = ds_graph_adj_matrix_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_adj_matrix_view_min(s : DsgraphadjmatrixView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_adj_matrix_view_max(s : DsgraphadjmatrixView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_adj_matrix_view_to_string(s : DsgraphadjmatrixView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphadjmatrixRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_adj_matrix_range_make(size : Int) -> DsgraphadjmatrixRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_adj_matrix_range_len(s : DsgraphadjmatrixRange) -> Int { s.size }

pub fn ds_graph_adj_matrix_range_get(s : DsgraphadjmatrixRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_adj_matrix_range_set(s : DsgraphadjmatrixRange, i : Int, v : Double) -> DsgraphadjmatrixRange {
  let result = ds_graph_adj_matrix_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_adj_matrix_range_sum(s : DsgraphadjmatrixRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_adj_matrix_range_mean(s : DsgraphadjmatrixRange) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_adj_matrix_range_sum(s) / s.size.to_double() }
}

pub fn ds_graph_adj_matrix_range_scale(s : DsgraphadjmatrixRange, f : Double) -> DsgraphadjmatrixRange {
  let result = ds_graph_adj_matrix_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_adj_matrix_range_add(a : DsgraphadjmatrixRange, b : DsgraphadjmatrixRange) -> DsgraphadjmatrixRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_adj_matrix_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_adj_matrix_range_copy(s : DsgraphadjmatrixRange) -> DsgraphadjmatrixRange {
  let result = ds_graph_adj_matrix_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_adj_matrix_range_fill(s : DsgraphadjmatrixRange, v : Double) -> DsgraphadjmatrixRange {
  let result = ds_graph_adj_matrix_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_adj_matrix_range_min(s : DsgraphadjmatrixRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_adj_matrix_range_max(s : DsgraphadjmatrixRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_adj_matrix_range_to_string(s : DsgraphadjmatrixRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphadjmatrixSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_adj_matrix_slice_make(size : Int) -> DsgraphadjmatrixSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_adj_matrix_slice_len(s : DsgraphadjmatrixSlice) -> Int { s.size }

pub fn ds_graph_adj_matrix_slice_get(s : DsgraphadjmatrixSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_adj_matrix_slice_set(s : DsgraphadjmatrixSlice, i : Int, v : Double) -> DsgraphadjmatrixSlice {
  let result = ds_graph_adj_matrix_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_adj_matrix_slice_sum(s : DsgraphadjmatrixSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_adj_matrix_slice_mean(s : DsgraphadjmatrixSlice) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_adj_matrix_slice_sum(s) / s.size.to_double() }
}

pub fn ds_graph_adj_matrix_slice_scale(s : DsgraphadjmatrixSlice, f : Double) -> DsgraphadjmatrixSlice {
  let result = ds_graph_adj_matrix_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_adj_matrix_slice_add(a : DsgraphadjmatrixSlice, b : DsgraphadjmatrixSlice) -> DsgraphadjmatrixSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_adj_matrix_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_adj_matrix_slice_copy(s : DsgraphadjmatrixSlice) -> DsgraphadjmatrixSlice {
  let result = ds_graph_adj_matrix_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_adj_matrix_slice_fill(s : DsgraphadjmatrixSlice, v : Double) -> DsgraphadjmatrixSlice {
  let result = ds_graph_adj_matrix_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_adj_matrix_slice_min(s : DsgraphadjmatrixSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_adj_matrix_slice_max(s : DsgraphadjmatrixSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_adj_matrix_slice_to_string(s : DsgraphadjmatrixSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


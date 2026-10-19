///===
/// extcore/ds_graph_dynamic

pub(all) struct DsgraphdynamicPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_graph_dynamic_make_point(x : Double, y : Double) -> DsgraphdynamicPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_graph_dynamic_make_point3(x : Double, y : Double, z : Double) -> DsgraphdynamicPoint {
  { x, y, z, label: 0 }
}

pub fn ds_graph_dynamic_point_x(pt : DsgraphdynamicPoint) -> Double { pt.x }

pub fn ds_graph_dynamic_point_y(pt : DsgraphdynamicPoint) -> Double { pt.y }

pub fn ds_graph_dynamic_point_z(pt : DsgraphdynamicPoint) -> Double { pt.z }

pub fn ds_graph_dynamic_point_label(pt : DsgraphdynamicPoint) -> Int { pt.label }

pub fn ds_graph_dynamic_point_dist(a : DsgraphdynamicPoint, b : DsgraphdynamicPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ds_graph_dynamic_point_add(a : DsgraphdynamicPoint, b : DsgraphdynamicPoint) -> DsgraphdynamicPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ds_graph_dynamic_point_sub(a : DsgraphdynamicPoint, b : DsgraphdynamicPoint) -> DsgraphdynamicPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ds_graph_dynamic_point_scale(pt : DsgraphdynamicPoint, s : Double) -> DsgraphdynamicPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ds_graph_dynamic_point_dot(a : DsgraphdynamicPoint, b : DsgraphdynamicPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ds_graph_dynamic_point_cross(a : DsgraphdynamicPoint, b : DsgraphdynamicPoint) -> DsgraphdynamicPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ds_graph_dynamic_point_norm(pt : DsgraphdynamicPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ds_graph_dynamic_point_normalize(pt : DsgraphdynamicPoint) -> DsgraphdynamicPoint {
  let n = ds_graph_dynamic_point_norm(pt)
  if n < 0.0000001 { pt } else { ds_graph_dynamic_point_scale(pt, 1.0 / n) }
}

pub fn ds_graph_dynamic_point_negate(pt : DsgraphdynamicPoint) -> DsgraphdynamicPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ds_graph_dynamic_point_mid(a : DsgraphdynamicPoint, b : DsgraphdynamicPoint) -> DsgraphdynamicPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ds_graph_dynamic_point_lerp(a : DsgraphdynamicPoint, b : DsgraphdynamicPoint, t : Double) -> DsgraphdynamicPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ds_graph_dynamic_point_to_string(pt : DsgraphdynamicPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DsgraphdynamicSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_graph_dynamic_make_series(vals : Array[Double], name : String) -> DsgraphdynamicSeries {
  { vals, name, meta: 0 }
}

pub fn ds_graph_dynamic_series_len(s : DsgraphdynamicSeries) -> Int { s.vals.length() }

pub fn ds_graph_dynamic_series_sum(s : DsgraphdynamicSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn ds_graph_dynamic_series_mean(s : DsgraphdynamicSeries) -> Double {
  let n = ds_graph_dynamic_series_len(s)
  if n == 0 { 0.0 } else { ds_graph_dynamic_series_sum(s) / n.to_double() }
}

pub fn ds_graph_dynamic_series_min(s : DsgraphdynamicSeries) -> Double {
  let n = ds_graph_dynamic_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn ds_graph_dynamic_series_max(s : DsgraphdynamicSeries) -> Double {
  let n = ds_graph_dynamic_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn ds_graph_dynamic_series_range(s : DsgraphdynamicSeries) -> Double {
  ds_graph_dynamic_series_max(s) - ds_graph_dynamic_series_min(s)
}

pub fn ds_graph_dynamic_series_var(s : DsgraphdynamicSeries) -> Double {
  let n = ds_graph_dynamic_series_len(s)
  if n == 0 { 0.0 } else {
    let m = ds_graph_dynamic_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn ds_graph_dynamic_series_std(s : DsgraphdynamicSeries) -> Double { @_common.sqrt(ds_graph_dynamic_series_var(s)) }

pub fn ds_graph_dynamic_series_median(s : DsgraphdynamicSeries) -> Double {
  let n = ds_graph_dynamic_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = ds_graph_dynamic_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ds_graph_dynamic_series_scale(s : DsgraphdynamicSeries, f : Double) -> DsgraphdynamicSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ds_graph_dynamic_series_add(a : DsgraphdynamicSeries, b : DsgraphdynamicSeries) -> DsgraphdynamicSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ds_graph_dynamic_series_sub(a : DsgraphdynamicSeries, b : DsgraphdynamicSeries) -> DsgraphdynamicSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ds_graph_dynamic_series_normalize(s : DsgraphdynamicSeries) -> DsgraphdynamicSeries {
  let mn = ds_graph_dynamic_series_min(s)
  let mx = ds_graph_dynamic_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ds_graph_dynamic_series_cumsum(s : DsgraphdynamicSeries) -> DsgraphdynamicSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn ds_graph_dynamic_series_to_string(s : DsgraphdynamicSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DsgraphdynamicMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_graph_dynamic_make_matrix(rows : Int, cols : Int, val : Double) -> DsgraphdynamicMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_graph_dynamic_matrix_identity(n : Int) -> DsgraphdynamicMatrix {
  let m = ds_graph_dynamic_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ds_graph_dynamic_matrix_get(m : DsgraphdynamicMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ds_graph_dynamic_matrix_transpose(m : DsgraphdynamicMatrix) -> DsgraphdynamicMatrix {
  let result = ds_graph_dynamic_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ds_graph_dynamic_matrix_add(a : DsgraphdynamicMatrix, b : DsgraphdynamicMatrix) -> DsgraphdynamicMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ds_graph_dynamic_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ds_graph_dynamic_matrix_scale(m : DsgraphdynamicMatrix, s : Double) -> DsgraphdynamicMatrix {
  let result = ds_graph_dynamic_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ds_graph_dynamic_matrix_multiply(a : DsgraphdynamicMatrix, b : DsgraphdynamicMatrix) -> DsgraphdynamicMatrix {
  if a.cols != b.rows { return ds_graph_dynamic_make_matrix(a.rows, b.cols, 0.0) }
  let result = ds_graph_dynamic_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ds_graph_dynamic_matrix_trace(m : DsgraphdynamicMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ds_graph_dynamic_matrix_det(m : DsgraphdynamicMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ds_graph_dynamic_matrix_norm(m : DsgraphdynamicMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ds_graph_dynamic_matrix_to_string(m : DsgraphdynamicMatrix) -> String {
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

pub(all) struct DsgraphdynamicVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_graph_dynamic_make_vector(comps : Array[Double]) -> DsgraphdynamicVector {
  { comps, dim: comps.length() }
}

pub fn ds_graph_dynamic_vector_zero(dim : Int) -> DsgraphdynamicVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ds_graph_dynamic_vector_add(a : DsgraphdynamicVector, b : DsgraphdynamicVector) -> DsgraphdynamicVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_graph_dynamic_vector_sub(a : DsgraphdynamicVector, b : DsgraphdynamicVector) -> DsgraphdynamicVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_graph_dynamic_vector_scale(v : DsgraphdynamicVector, s : Double) -> DsgraphdynamicVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ds_graph_dynamic_vector_dot(a : DsgraphdynamicVector, b : DsgraphdynamicVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ds_graph_dynamic_vector_norm(v : DsgraphdynamicVector) -> Double { @_common.sqrt(ds_graph_dynamic_vector_dot(v, v)) }

pub fn ds_graph_dynamic_vector_normalize(v : DsgraphdynamicVector) -> DsgraphdynamicVector {
  let n = ds_graph_dynamic_vector_norm(v)
  if n < 0.0000001 { v } else { ds_graph_dynamic_vector_scale(v, 1.0 / n) }
}

pub fn ds_graph_dynamic_vector_dist(a : DsgraphdynamicVector, b : DsgraphdynamicVector) -> Double {
  ds_graph_dynamic_vector_norm(ds_graph_dynamic_vector_sub(a, b))
}

pub fn ds_graph_dynamic_vector_to_string(v : DsgraphdynamicVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_graph_dynamic_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ds_graph_dynamic_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ds_graph_dynamic_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ds_graph_dynamic_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ds_graph_dynamic_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ds_graph_dynamic_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ds_graph_dynamic_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ds_graph_dynamic_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ds_graph_dynamic_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ds_graph_dynamic_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ds_graph_dynamic_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ds_graph_dynamic_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ds_graph_dynamic_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ds_graph_dynamic_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ds_graph_dynamic_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ds_graph_dynamic_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ds_graph_dynamic_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ds_graph_dynamic_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ds_graph_dynamic_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ds_graph_dynamic_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ds_graph_dynamic_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ds_graph_dynamic_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ds_graph_dynamic_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ds_graph_dynamic_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ds_graph_dynamic_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ds_graph_dynamic_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ds_graph_dynamic_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ds_graph_dynamic_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ds_graph_dynamic_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DsgraphdynamicFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_dynamic_frame_make(size : Int) -> DsgraphdynamicFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_dynamic_frame_len(s : DsgraphdynamicFrame) -> Int { s.size }

pub fn ds_graph_dynamic_frame_get(s : DsgraphdynamicFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_dynamic_frame_set(s : DsgraphdynamicFrame, i : Int, v : Double) -> DsgraphdynamicFrame {
  let result = ds_graph_dynamic_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_dynamic_frame_sum(s : DsgraphdynamicFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_dynamic_frame_mean(s : DsgraphdynamicFrame) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_dynamic_frame_sum(s) / s.size.to_double() }
}

pub fn ds_graph_dynamic_frame_scale(s : DsgraphdynamicFrame, f : Double) -> DsgraphdynamicFrame {
  let result = ds_graph_dynamic_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_dynamic_frame_add(a : DsgraphdynamicFrame, b : DsgraphdynamicFrame) -> DsgraphdynamicFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_dynamic_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_dynamic_frame_copy(s : DsgraphdynamicFrame) -> DsgraphdynamicFrame {
  let result = ds_graph_dynamic_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_dynamic_frame_fill(s : DsgraphdynamicFrame, v : Double) -> DsgraphdynamicFrame {
  let result = ds_graph_dynamic_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_dynamic_frame_min(s : DsgraphdynamicFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_dynamic_frame_max(s : DsgraphdynamicFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_dynamic_frame_to_string(s : DsgraphdynamicFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphdynamicTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_dynamic_table_make(size : Int) -> DsgraphdynamicTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_dynamic_table_len(s : DsgraphdynamicTable) -> Int { s.size }

pub fn ds_graph_dynamic_table_get(s : DsgraphdynamicTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_dynamic_table_set(s : DsgraphdynamicTable, i : Int, v : Double) -> DsgraphdynamicTable {
  let result = ds_graph_dynamic_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_dynamic_table_sum(s : DsgraphdynamicTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_dynamic_table_mean(s : DsgraphdynamicTable) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_dynamic_table_sum(s) / s.size.to_double() }
}

pub fn ds_graph_dynamic_table_scale(s : DsgraphdynamicTable, f : Double) -> DsgraphdynamicTable {
  let result = ds_graph_dynamic_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_dynamic_table_add(a : DsgraphdynamicTable, b : DsgraphdynamicTable) -> DsgraphdynamicTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_dynamic_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_dynamic_table_copy(s : DsgraphdynamicTable) -> DsgraphdynamicTable {
  let result = ds_graph_dynamic_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_dynamic_table_fill(s : DsgraphdynamicTable, v : Double) -> DsgraphdynamicTable {
  let result = ds_graph_dynamic_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_dynamic_table_min(s : DsgraphdynamicTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_dynamic_table_max(s : DsgraphdynamicTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_dynamic_table_to_string(s : DsgraphdynamicTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphdynamicGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_dynamic_graphn_make(size : Int) -> DsgraphdynamicGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_dynamic_graphn_len(s : DsgraphdynamicGraphN) -> Int { s.size }

pub fn ds_graph_dynamic_graphn_get(s : DsgraphdynamicGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_dynamic_graphn_set(s : DsgraphdynamicGraphN, i : Int, v : Double) -> DsgraphdynamicGraphN {
  let result = ds_graph_dynamic_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_dynamic_graphn_sum(s : DsgraphdynamicGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_dynamic_graphn_mean(s : DsgraphdynamicGraphN) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_dynamic_graphn_sum(s) / s.size.to_double() }
}

pub fn ds_graph_dynamic_graphn_scale(s : DsgraphdynamicGraphN, f : Double) -> DsgraphdynamicGraphN {
  let result = ds_graph_dynamic_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_dynamic_graphn_add(a : DsgraphdynamicGraphN, b : DsgraphdynamicGraphN) -> DsgraphdynamicGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_dynamic_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_dynamic_graphn_copy(s : DsgraphdynamicGraphN) -> DsgraphdynamicGraphN {
  let result = ds_graph_dynamic_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_dynamic_graphn_fill(s : DsgraphdynamicGraphN, v : Double) -> DsgraphdynamicGraphN {
  let result = ds_graph_dynamic_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_dynamic_graphn_min(s : DsgraphdynamicGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_dynamic_graphn_max(s : DsgraphdynamicGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_dynamic_graphn_to_string(s : DsgraphdynamicGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphdynamicNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_dynamic_node_make(size : Int) -> DsgraphdynamicNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_dynamic_node_len(s : DsgraphdynamicNode) -> Int { s.size }

pub fn ds_graph_dynamic_node_get(s : DsgraphdynamicNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_dynamic_node_set(s : DsgraphdynamicNode, i : Int, v : Double) -> DsgraphdynamicNode {
  let result = ds_graph_dynamic_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_dynamic_node_sum(s : DsgraphdynamicNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_dynamic_node_mean(s : DsgraphdynamicNode) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_dynamic_node_sum(s) / s.size.to_double() }
}

pub fn ds_graph_dynamic_node_scale(s : DsgraphdynamicNode, f : Double) -> DsgraphdynamicNode {
  let result = ds_graph_dynamic_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_dynamic_node_add(a : DsgraphdynamicNode, b : DsgraphdynamicNode) -> DsgraphdynamicNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_dynamic_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_dynamic_node_copy(s : DsgraphdynamicNode) -> DsgraphdynamicNode {
  let result = ds_graph_dynamic_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_dynamic_node_fill(s : DsgraphdynamicNode, v : Double) -> DsgraphdynamicNode {
  let result = ds_graph_dynamic_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_dynamic_node_min(s : DsgraphdynamicNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_dynamic_node_max(s : DsgraphdynamicNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_dynamic_node_to_string(s : DsgraphdynamicNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphdynamicEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_dynamic_edge_make(size : Int) -> DsgraphdynamicEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_dynamic_edge_len(s : DsgraphdynamicEdge) -> Int { s.size }

pub fn ds_graph_dynamic_edge_get(s : DsgraphdynamicEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_dynamic_edge_set(s : DsgraphdynamicEdge, i : Int, v : Double) -> DsgraphdynamicEdge {
  let result = ds_graph_dynamic_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_dynamic_edge_sum(s : DsgraphdynamicEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_dynamic_edge_mean(s : DsgraphdynamicEdge) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_dynamic_edge_sum(s) / s.size.to_double() }
}

pub fn ds_graph_dynamic_edge_scale(s : DsgraphdynamicEdge, f : Double) -> DsgraphdynamicEdge {
  let result = ds_graph_dynamic_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_dynamic_edge_add(a : DsgraphdynamicEdge, b : DsgraphdynamicEdge) -> DsgraphdynamicEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_dynamic_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_dynamic_edge_copy(s : DsgraphdynamicEdge) -> DsgraphdynamicEdge {
  let result = ds_graph_dynamic_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_dynamic_edge_fill(s : DsgraphdynamicEdge, v : Double) -> DsgraphdynamicEdge {
  let result = ds_graph_dynamic_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_dynamic_edge_min(s : DsgraphdynamicEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_dynamic_edge_max(s : DsgraphdynamicEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_dynamic_edge_to_string(s : DsgraphdynamicEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphdynamicPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_dynamic_path_make(size : Int) -> DsgraphdynamicPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_dynamic_path_len(s : DsgraphdynamicPath) -> Int { s.size }

pub fn ds_graph_dynamic_path_get(s : DsgraphdynamicPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_dynamic_path_set(s : DsgraphdynamicPath, i : Int, v : Double) -> DsgraphdynamicPath {
  let result = ds_graph_dynamic_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_dynamic_path_sum(s : DsgraphdynamicPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_dynamic_path_mean(s : DsgraphdynamicPath) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_dynamic_path_sum(s) / s.size.to_double() }
}

pub fn ds_graph_dynamic_path_scale(s : DsgraphdynamicPath, f : Double) -> DsgraphdynamicPath {
  let result = ds_graph_dynamic_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_dynamic_path_add(a : DsgraphdynamicPath, b : DsgraphdynamicPath) -> DsgraphdynamicPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_dynamic_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_dynamic_path_copy(s : DsgraphdynamicPath) -> DsgraphdynamicPath {
  let result = ds_graph_dynamic_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_dynamic_path_fill(s : DsgraphdynamicPath, v : Double) -> DsgraphdynamicPath {
  let result = ds_graph_dynamic_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_dynamic_path_min(s : DsgraphdynamicPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_dynamic_path_max(s : DsgraphdynamicPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_dynamic_path_to_string(s : DsgraphdynamicPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphdynamicCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_dynamic_cluster_make(size : Int) -> DsgraphdynamicCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_dynamic_cluster_len(s : DsgraphdynamicCluster) -> Int { s.size }

pub fn ds_graph_dynamic_cluster_get(s : DsgraphdynamicCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_dynamic_cluster_set(s : DsgraphdynamicCluster, i : Int, v : Double) -> DsgraphdynamicCluster {
  let result = ds_graph_dynamic_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_dynamic_cluster_sum(s : DsgraphdynamicCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_dynamic_cluster_mean(s : DsgraphdynamicCluster) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_dynamic_cluster_sum(s) / s.size.to_double() }
}

pub fn ds_graph_dynamic_cluster_scale(s : DsgraphdynamicCluster, f : Double) -> DsgraphdynamicCluster {
  let result = ds_graph_dynamic_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_dynamic_cluster_add(a : DsgraphdynamicCluster, b : DsgraphdynamicCluster) -> DsgraphdynamicCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_dynamic_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_dynamic_cluster_copy(s : DsgraphdynamicCluster) -> DsgraphdynamicCluster {
  let result = ds_graph_dynamic_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_dynamic_cluster_fill(s : DsgraphdynamicCluster, v : Double) -> DsgraphdynamicCluster {
  let result = ds_graph_dynamic_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_dynamic_cluster_min(s : DsgraphdynamicCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_dynamic_cluster_max(s : DsgraphdynamicCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_dynamic_cluster_to_string(s : DsgraphdynamicCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphdynamicModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_dynamic_model_make(size : Int) -> DsgraphdynamicModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_dynamic_model_len(s : DsgraphdynamicModel) -> Int { s.size }

pub fn ds_graph_dynamic_model_get(s : DsgraphdynamicModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_dynamic_model_set(s : DsgraphdynamicModel, i : Int, v : Double) -> DsgraphdynamicModel {
  let result = ds_graph_dynamic_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_dynamic_model_sum(s : DsgraphdynamicModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_dynamic_model_mean(s : DsgraphdynamicModel) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_dynamic_model_sum(s) / s.size.to_double() }
}

pub fn ds_graph_dynamic_model_scale(s : DsgraphdynamicModel, f : Double) -> DsgraphdynamicModel {
  let result = ds_graph_dynamic_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_dynamic_model_add(a : DsgraphdynamicModel, b : DsgraphdynamicModel) -> DsgraphdynamicModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_dynamic_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_dynamic_model_copy(s : DsgraphdynamicModel) -> DsgraphdynamicModel {
  let result = ds_graph_dynamic_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_dynamic_model_fill(s : DsgraphdynamicModel, v : Double) -> DsgraphdynamicModel {
  let result = ds_graph_dynamic_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_dynamic_model_min(s : DsgraphdynamicModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_dynamic_model_max(s : DsgraphdynamicModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_dynamic_model_to_string(s : DsgraphdynamicModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphdynamicLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_dynamic_layer_make(size : Int) -> DsgraphdynamicLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_dynamic_layer_len(s : DsgraphdynamicLayer) -> Int { s.size }

pub fn ds_graph_dynamic_layer_get(s : DsgraphdynamicLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_dynamic_layer_set(s : DsgraphdynamicLayer, i : Int, v : Double) -> DsgraphdynamicLayer {
  let result = ds_graph_dynamic_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_dynamic_layer_sum(s : DsgraphdynamicLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_dynamic_layer_mean(s : DsgraphdynamicLayer) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_dynamic_layer_sum(s) / s.size.to_double() }
}

pub fn ds_graph_dynamic_layer_scale(s : DsgraphdynamicLayer, f : Double) -> DsgraphdynamicLayer {
  let result = ds_graph_dynamic_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_dynamic_layer_add(a : DsgraphdynamicLayer, b : DsgraphdynamicLayer) -> DsgraphdynamicLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_dynamic_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_dynamic_layer_copy(s : DsgraphdynamicLayer) -> DsgraphdynamicLayer {
  let result = ds_graph_dynamic_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_dynamic_layer_fill(s : DsgraphdynamicLayer, v : Double) -> DsgraphdynamicLayer {
  let result = ds_graph_dynamic_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_dynamic_layer_min(s : DsgraphdynamicLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_dynamic_layer_max(s : DsgraphdynamicLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_dynamic_layer_to_string(s : DsgraphdynamicLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphdynamicBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_dynamic_buffer_make(size : Int) -> DsgraphdynamicBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_dynamic_buffer_len(s : DsgraphdynamicBuffer) -> Int { s.size }

pub fn ds_graph_dynamic_buffer_get(s : DsgraphdynamicBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_dynamic_buffer_set(s : DsgraphdynamicBuffer, i : Int, v : Double) -> DsgraphdynamicBuffer {
  let result = ds_graph_dynamic_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_dynamic_buffer_sum(s : DsgraphdynamicBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_dynamic_buffer_mean(s : DsgraphdynamicBuffer) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_dynamic_buffer_sum(s) / s.size.to_double() }
}

pub fn ds_graph_dynamic_buffer_scale(s : DsgraphdynamicBuffer, f : Double) -> DsgraphdynamicBuffer {
  let result = ds_graph_dynamic_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_dynamic_buffer_add(a : DsgraphdynamicBuffer, b : DsgraphdynamicBuffer) -> DsgraphdynamicBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_dynamic_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_dynamic_buffer_copy(s : DsgraphdynamicBuffer) -> DsgraphdynamicBuffer {
  let result = ds_graph_dynamic_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_dynamic_buffer_fill(s : DsgraphdynamicBuffer, v : Double) -> DsgraphdynamicBuffer {
  let result = ds_graph_dynamic_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_dynamic_buffer_min(s : DsgraphdynamicBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_dynamic_buffer_max(s : DsgraphdynamicBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_dynamic_buffer_to_string(s : DsgraphdynamicBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphdynamicCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_dynamic_cursor_make(size : Int) -> DsgraphdynamicCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_dynamic_cursor_len(s : DsgraphdynamicCursor) -> Int { s.size }

pub fn ds_graph_dynamic_cursor_get(s : DsgraphdynamicCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_dynamic_cursor_set(s : DsgraphdynamicCursor, i : Int, v : Double) -> DsgraphdynamicCursor {
  let result = ds_graph_dynamic_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_dynamic_cursor_sum(s : DsgraphdynamicCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_dynamic_cursor_mean(s : DsgraphdynamicCursor) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_dynamic_cursor_sum(s) / s.size.to_double() }
}

pub fn ds_graph_dynamic_cursor_scale(s : DsgraphdynamicCursor, f : Double) -> DsgraphdynamicCursor {
  let result = ds_graph_dynamic_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_dynamic_cursor_add(a : DsgraphdynamicCursor, b : DsgraphdynamicCursor) -> DsgraphdynamicCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_dynamic_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_dynamic_cursor_copy(s : DsgraphdynamicCursor) -> DsgraphdynamicCursor {
  let result = ds_graph_dynamic_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_dynamic_cursor_fill(s : DsgraphdynamicCursor, v : Double) -> DsgraphdynamicCursor {
  let result = ds_graph_dynamic_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_dynamic_cursor_min(s : DsgraphdynamicCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_dynamic_cursor_max(s : DsgraphdynamicCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_dynamic_cursor_to_string(s : DsgraphdynamicCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphdynamicView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_dynamic_view_make(size : Int) -> DsgraphdynamicView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_dynamic_view_len(s : DsgraphdynamicView) -> Int { s.size }

pub fn ds_graph_dynamic_view_get(s : DsgraphdynamicView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_dynamic_view_set(s : DsgraphdynamicView, i : Int, v : Double) -> DsgraphdynamicView {
  let result = ds_graph_dynamic_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_dynamic_view_sum(s : DsgraphdynamicView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_dynamic_view_mean(s : DsgraphdynamicView) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_dynamic_view_sum(s) / s.size.to_double() }
}

pub fn ds_graph_dynamic_view_scale(s : DsgraphdynamicView, f : Double) -> DsgraphdynamicView {
  let result = ds_graph_dynamic_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_dynamic_view_add(a : DsgraphdynamicView, b : DsgraphdynamicView) -> DsgraphdynamicView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_dynamic_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_dynamic_view_copy(s : DsgraphdynamicView) -> DsgraphdynamicView {
  let result = ds_graph_dynamic_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_dynamic_view_fill(s : DsgraphdynamicView, v : Double) -> DsgraphdynamicView {
  let result = ds_graph_dynamic_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_dynamic_view_min(s : DsgraphdynamicView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_dynamic_view_max(s : DsgraphdynamicView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_dynamic_view_to_string(s : DsgraphdynamicView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphdynamicRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_dynamic_range_make(size : Int) -> DsgraphdynamicRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_dynamic_range_len(s : DsgraphdynamicRange) -> Int { s.size }

pub fn ds_graph_dynamic_range_get(s : DsgraphdynamicRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_dynamic_range_set(s : DsgraphdynamicRange, i : Int, v : Double) -> DsgraphdynamicRange {
  let result = ds_graph_dynamic_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_dynamic_range_sum(s : DsgraphdynamicRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_dynamic_range_mean(s : DsgraphdynamicRange) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_dynamic_range_sum(s) / s.size.to_double() }
}

pub fn ds_graph_dynamic_range_scale(s : DsgraphdynamicRange, f : Double) -> DsgraphdynamicRange {
  let result = ds_graph_dynamic_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_dynamic_range_add(a : DsgraphdynamicRange, b : DsgraphdynamicRange) -> DsgraphdynamicRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_dynamic_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_dynamic_range_copy(s : DsgraphdynamicRange) -> DsgraphdynamicRange {
  let result = ds_graph_dynamic_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_dynamic_range_fill(s : DsgraphdynamicRange, v : Double) -> DsgraphdynamicRange {
  let result = ds_graph_dynamic_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_dynamic_range_min(s : DsgraphdynamicRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_dynamic_range_max(s : DsgraphdynamicRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_dynamic_range_to_string(s : DsgraphdynamicRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphdynamicSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_dynamic_slice_make(size : Int) -> DsgraphdynamicSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_dynamic_slice_len(s : DsgraphdynamicSlice) -> Int { s.size }

pub fn ds_graph_dynamic_slice_get(s : DsgraphdynamicSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_dynamic_slice_set(s : DsgraphdynamicSlice, i : Int, v : Double) -> DsgraphdynamicSlice {
  let result = ds_graph_dynamic_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_dynamic_slice_sum(s : DsgraphdynamicSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_dynamic_slice_mean(s : DsgraphdynamicSlice) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_dynamic_slice_sum(s) / s.size.to_double() }
}

pub fn ds_graph_dynamic_slice_scale(s : DsgraphdynamicSlice, f : Double) -> DsgraphdynamicSlice {
  let result = ds_graph_dynamic_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_dynamic_slice_add(a : DsgraphdynamicSlice, b : DsgraphdynamicSlice) -> DsgraphdynamicSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_dynamic_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_dynamic_slice_copy(s : DsgraphdynamicSlice) -> DsgraphdynamicSlice {
  let result = ds_graph_dynamic_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_dynamic_slice_fill(s : DsgraphdynamicSlice, v : Double) -> DsgraphdynamicSlice {
  let result = ds_graph_dynamic_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_dynamic_slice_min(s : DsgraphdynamicSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_dynamic_slice_max(s : DsgraphdynamicSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_dynamic_slice_to_string(s : DsgraphdynamicSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


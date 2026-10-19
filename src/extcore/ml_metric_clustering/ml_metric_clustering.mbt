///===
/// extcore/ml_metric_clustering

pub(all) struct MlmetricclusteringPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_metric_clustering_make_point(x : Double, y : Double) -> MlmetricclusteringPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_metric_clustering_make_point3(x : Double, y : Double, z : Double) -> MlmetricclusteringPoint {
  { x, y, z, label: 0 }
}

pub fn ml_metric_clustering_point_x(pt : MlmetricclusteringPoint) -> Double { pt.x }

pub fn ml_metric_clustering_point_y(pt : MlmetricclusteringPoint) -> Double { pt.y }

pub fn ml_metric_clustering_point_z(pt : MlmetricclusteringPoint) -> Double { pt.z }

pub fn ml_metric_clustering_point_label(pt : MlmetricclusteringPoint) -> Int { pt.label }

pub fn ml_metric_clustering_point_dist(a : MlmetricclusteringPoint, b : MlmetricclusteringPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ml_metric_clustering_point_add(a : MlmetricclusteringPoint, b : MlmetricclusteringPoint) -> MlmetricclusteringPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ml_metric_clustering_point_sub(a : MlmetricclusteringPoint, b : MlmetricclusteringPoint) -> MlmetricclusteringPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ml_metric_clustering_point_scale(pt : MlmetricclusteringPoint, s : Double) -> MlmetricclusteringPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ml_metric_clustering_point_dot(a : MlmetricclusteringPoint, b : MlmetricclusteringPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ml_metric_clustering_point_cross(a : MlmetricclusteringPoint, b : MlmetricclusteringPoint) -> MlmetricclusteringPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ml_metric_clustering_point_norm(pt : MlmetricclusteringPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ml_metric_clustering_point_normalize(pt : MlmetricclusteringPoint) -> MlmetricclusteringPoint {
  let n = ml_metric_clustering_point_norm(pt)
  if n < 0.0000001 { pt } else { ml_metric_clustering_point_scale(pt, 1.0 / n) }
}

pub fn ml_metric_clustering_point_negate(pt : MlmetricclusteringPoint) -> MlmetricclusteringPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ml_metric_clustering_point_mid(a : MlmetricclusteringPoint, b : MlmetricclusteringPoint) -> MlmetricclusteringPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ml_metric_clustering_point_lerp(a : MlmetricclusteringPoint, b : MlmetricclusteringPoint, t : Double) -> MlmetricclusteringPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ml_metric_clustering_point_to_string(pt : MlmetricclusteringPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MlmetricclusteringSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_metric_clustering_make_series(vals : Array[Double], name : String) -> MlmetricclusteringSeries {
  { vals, name, meta: 0 }
}

pub fn ml_metric_clustering_series_len(s : MlmetricclusteringSeries) -> Int { s.vals.length() }

pub fn ml_metric_clustering_series_sum(s : MlmetricclusteringSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn ml_metric_clustering_series_mean(s : MlmetricclusteringSeries) -> Double {
  let n = ml_metric_clustering_series_len(s)
  if n == 0 { 0.0 } else { ml_metric_clustering_series_sum(s) / n.to_double() }
}

pub fn ml_metric_clustering_series_min(s : MlmetricclusteringSeries) -> Double {
  let n = ml_metric_clustering_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn ml_metric_clustering_series_max(s : MlmetricclusteringSeries) -> Double {
  let n = ml_metric_clustering_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn ml_metric_clustering_series_range(s : MlmetricclusteringSeries) -> Double {
  ml_metric_clustering_series_max(s) - ml_metric_clustering_series_min(s)
}

pub fn ml_metric_clustering_series_var(s : MlmetricclusteringSeries) -> Double {
  let n = ml_metric_clustering_series_len(s)
  if n == 0 { 0.0 } else {
    let m = ml_metric_clustering_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn ml_metric_clustering_series_std(s : MlmetricclusteringSeries) -> Double { @_common.sqrt(ml_metric_clustering_series_var(s)) }

pub fn ml_metric_clustering_series_median(s : MlmetricclusteringSeries) -> Double {
  let n = ml_metric_clustering_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = ml_metric_clustering_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ml_metric_clustering_series_scale(s : MlmetricclusteringSeries, f : Double) -> MlmetricclusteringSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ml_metric_clustering_series_add(a : MlmetricclusteringSeries, b : MlmetricclusteringSeries) -> MlmetricclusteringSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ml_metric_clustering_series_sub(a : MlmetricclusteringSeries, b : MlmetricclusteringSeries) -> MlmetricclusteringSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ml_metric_clustering_series_normalize(s : MlmetricclusteringSeries) -> MlmetricclusteringSeries {
  let mn = ml_metric_clustering_series_min(s)
  let mx = ml_metric_clustering_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ml_metric_clustering_series_cumsum(s : MlmetricclusteringSeries) -> MlmetricclusteringSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn ml_metric_clustering_series_to_string(s : MlmetricclusteringSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlmetricclusteringMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_metric_clustering_make_matrix(rows : Int, cols : Int, val : Double) -> MlmetricclusteringMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_metric_clustering_matrix_identity(n : Int) -> MlmetricclusteringMatrix {
  let m = ml_metric_clustering_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ml_metric_clustering_matrix_get(m : MlmetricclusteringMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ml_metric_clustering_matrix_transpose(m : MlmetricclusteringMatrix) -> MlmetricclusteringMatrix {
  let result = ml_metric_clustering_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ml_metric_clustering_matrix_add(a : MlmetricclusteringMatrix, b : MlmetricclusteringMatrix) -> MlmetricclusteringMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ml_metric_clustering_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ml_metric_clustering_matrix_scale(m : MlmetricclusteringMatrix, s : Double) -> MlmetricclusteringMatrix {
  let result = ml_metric_clustering_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ml_metric_clustering_matrix_multiply(a : MlmetricclusteringMatrix, b : MlmetricclusteringMatrix) -> MlmetricclusteringMatrix {
  if a.cols != b.rows { return ml_metric_clustering_make_matrix(a.rows, b.cols, 0.0) }
  let result = ml_metric_clustering_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ml_metric_clustering_matrix_trace(m : MlmetricclusteringMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ml_metric_clustering_matrix_det(m : MlmetricclusteringMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ml_metric_clustering_matrix_norm(m : MlmetricclusteringMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ml_metric_clustering_matrix_to_string(m : MlmetricclusteringMatrix) -> String {
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

pub(all) struct MlmetricclusteringVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_metric_clustering_make_vector(comps : Array[Double]) -> MlmetricclusteringVector {
  { comps, dim: comps.length() }
}

pub fn ml_metric_clustering_vector_zero(dim : Int) -> MlmetricclusteringVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ml_metric_clustering_vector_add(a : MlmetricclusteringVector, b : MlmetricclusteringVector) -> MlmetricclusteringVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_metric_clustering_vector_sub(a : MlmetricclusteringVector, b : MlmetricclusteringVector) -> MlmetricclusteringVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_metric_clustering_vector_scale(v : MlmetricclusteringVector, s : Double) -> MlmetricclusteringVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ml_metric_clustering_vector_dot(a : MlmetricclusteringVector, b : MlmetricclusteringVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ml_metric_clustering_vector_norm(v : MlmetricclusteringVector) -> Double { @_common.sqrt(ml_metric_clustering_vector_dot(v, v)) }

pub fn ml_metric_clustering_vector_normalize(v : MlmetricclusteringVector) -> MlmetricclusteringVector {
  let n = ml_metric_clustering_vector_norm(v)
  if n < 0.0000001 { v } else { ml_metric_clustering_vector_scale(v, 1.0 / n) }
}

pub fn ml_metric_clustering_vector_dist(a : MlmetricclusteringVector, b : MlmetricclusteringVector) -> Double {
  ml_metric_clustering_vector_norm(ml_metric_clustering_vector_sub(a, b))
}

pub fn ml_metric_clustering_vector_to_string(v : MlmetricclusteringVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_metric_clustering_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_metric_clustering_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_metric_clustering_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_metric_clustering_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_metric_clustering_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_metric_clustering_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_metric_clustering_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_metric_clustering_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_metric_clustering_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_metric_clustering_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_metric_clustering_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_metric_clustering_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_metric_clustering_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_metric_clustering_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_metric_clustering_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_metric_clustering_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_metric_clustering_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_metric_clustering_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_metric_clustering_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_metric_clustering_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_metric_clustering_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_metric_clustering_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_metric_clustering_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_metric_clustering_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_metric_clustering_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_metric_clustering_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_metric_clustering_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_metric_clustering_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_metric_clustering_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlmetricclusteringFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_clustering_frame_make(size : Int) -> MlmetricclusteringFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_clustering_frame_len(s : MlmetricclusteringFrame) -> Int { s.size }

pub fn ml_metric_clustering_frame_get(s : MlmetricclusteringFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_clustering_frame_set(s : MlmetricclusteringFrame, i : Int, v : Double) -> MlmetricclusteringFrame {
  let result = ml_metric_clustering_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_clustering_frame_sum(s : MlmetricclusteringFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_metric_clustering_frame_mean(s : MlmetricclusteringFrame) -> Double {
  if s.size == 0 { 0.0 } else { ml_metric_clustering_frame_sum(s) / s.size.to_double() }
}

pub fn ml_metric_clustering_frame_scale(s : MlmetricclusteringFrame, f : Double) -> MlmetricclusteringFrame {
  let result = ml_metric_clustering_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_metric_clustering_frame_add(a : MlmetricclusteringFrame, b : MlmetricclusteringFrame) -> MlmetricclusteringFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_metric_clustering_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_metric_clustering_frame_copy(s : MlmetricclusteringFrame) -> MlmetricclusteringFrame {
  let result = ml_metric_clustering_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_metric_clustering_frame_fill(s : MlmetricclusteringFrame, v : Double) -> MlmetricclusteringFrame {
  let result = ml_metric_clustering_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_metric_clustering_frame_min(s : MlmetricclusteringFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_clustering_frame_max(s : MlmetricclusteringFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_clustering_frame_to_string(s : MlmetricclusteringFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricclusteringTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_clustering_table_make(size : Int) -> MlmetricclusteringTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_clustering_table_len(s : MlmetricclusteringTable) -> Int { s.size }

pub fn ml_metric_clustering_table_get(s : MlmetricclusteringTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_clustering_table_set(s : MlmetricclusteringTable, i : Int, v : Double) -> MlmetricclusteringTable {
  let result = ml_metric_clustering_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_clustering_table_sum(s : MlmetricclusteringTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_metric_clustering_table_mean(s : MlmetricclusteringTable) -> Double {
  if s.size == 0 { 0.0 } else { ml_metric_clustering_table_sum(s) / s.size.to_double() }
}

pub fn ml_metric_clustering_table_scale(s : MlmetricclusteringTable, f : Double) -> MlmetricclusteringTable {
  let result = ml_metric_clustering_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_metric_clustering_table_add(a : MlmetricclusteringTable, b : MlmetricclusteringTable) -> MlmetricclusteringTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_metric_clustering_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_metric_clustering_table_copy(s : MlmetricclusteringTable) -> MlmetricclusteringTable {
  let result = ml_metric_clustering_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_metric_clustering_table_fill(s : MlmetricclusteringTable, v : Double) -> MlmetricclusteringTable {
  let result = ml_metric_clustering_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_metric_clustering_table_min(s : MlmetricclusteringTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_clustering_table_max(s : MlmetricclusteringTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_clustering_table_to_string(s : MlmetricclusteringTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricclusteringGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_clustering_graphn_make(size : Int) -> MlmetricclusteringGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_clustering_graphn_len(s : MlmetricclusteringGraphN) -> Int { s.size }

pub fn ml_metric_clustering_graphn_get(s : MlmetricclusteringGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_clustering_graphn_set(s : MlmetricclusteringGraphN, i : Int, v : Double) -> MlmetricclusteringGraphN {
  let result = ml_metric_clustering_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_clustering_graphn_sum(s : MlmetricclusteringGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_metric_clustering_graphn_mean(s : MlmetricclusteringGraphN) -> Double {
  if s.size == 0 { 0.0 } else { ml_metric_clustering_graphn_sum(s) / s.size.to_double() }
}

pub fn ml_metric_clustering_graphn_scale(s : MlmetricclusteringGraphN, f : Double) -> MlmetricclusteringGraphN {
  let result = ml_metric_clustering_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_metric_clustering_graphn_add(a : MlmetricclusteringGraphN, b : MlmetricclusteringGraphN) -> MlmetricclusteringGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_metric_clustering_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_metric_clustering_graphn_copy(s : MlmetricclusteringGraphN) -> MlmetricclusteringGraphN {
  let result = ml_metric_clustering_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_metric_clustering_graphn_fill(s : MlmetricclusteringGraphN, v : Double) -> MlmetricclusteringGraphN {
  let result = ml_metric_clustering_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_metric_clustering_graphn_min(s : MlmetricclusteringGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_clustering_graphn_max(s : MlmetricclusteringGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_clustering_graphn_to_string(s : MlmetricclusteringGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricclusteringNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_clustering_node_make(size : Int) -> MlmetricclusteringNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_clustering_node_len(s : MlmetricclusteringNode) -> Int { s.size }

pub fn ml_metric_clustering_node_get(s : MlmetricclusteringNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_clustering_node_set(s : MlmetricclusteringNode, i : Int, v : Double) -> MlmetricclusteringNode {
  let result = ml_metric_clustering_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_clustering_node_sum(s : MlmetricclusteringNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_metric_clustering_node_mean(s : MlmetricclusteringNode) -> Double {
  if s.size == 0 { 0.0 } else { ml_metric_clustering_node_sum(s) / s.size.to_double() }
}

pub fn ml_metric_clustering_node_scale(s : MlmetricclusteringNode, f : Double) -> MlmetricclusteringNode {
  let result = ml_metric_clustering_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_metric_clustering_node_add(a : MlmetricclusteringNode, b : MlmetricclusteringNode) -> MlmetricclusteringNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_metric_clustering_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_metric_clustering_node_copy(s : MlmetricclusteringNode) -> MlmetricclusteringNode {
  let result = ml_metric_clustering_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_metric_clustering_node_fill(s : MlmetricclusteringNode, v : Double) -> MlmetricclusteringNode {
  let result = ml_metric_clustering_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_metric_clustering_node_min(s : MlmetricclusteringNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_clustering_node_max(s : MlmetricclusteringNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_clustering_node_to_string(s : MlmetricclusteringNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricclusteringEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_clustering_edge_make(size : Int) -> MlmetricclusteringEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_clustering_edge_len(s : MlmetricclusteringEdge) -> Int { s.size }

pub fn ml_metric_clustering_edge_get(s : MlmetricclusteringEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_clustering_edge_set(s : MlmetricclusteringEdge, i : Int, v : Double) -> MlmetricclusteringEdge {
  let result = ml_metric_clustering_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_clustering_edge_sum(s : MlmetricclusteringEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_metric_clustering_edge_mean(s : MlmetricclusteringEdge) -> Double {
  if s.size == 0 { 0.0 } else { ml_metric_clustering_edge_sum(s) / s.size.to_double() }
}

pub fn ml_metric_clustering_edge_scale(s : MlmetricclusteringEdge, f : Double) -> MlmetricclusteringEdge {
  let result = ml_metric_clustering_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_metric_clustering_edge_add(a : MlmetricclusteringEdge, b : MlmetricclusteringEdge) -> MlmetricclusteringEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_metric_clustering_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_metric_clustering_edge_copy(s : MlmetricclusteringEdge) -> MlmetricclusteringEdge {
  let result = ml_metric_clustering_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_metric_clustering_edge_fill(s : MlmetricclusteringEdge, v : Double) -> MlmetricclusteringEdge {
  let result = ml_metric_clustering_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_metric_clustering_edge_min(s : MlmetricclusteringEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_clustering_edge_max(s : MlmetricclusteringEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_clustering_edge_to_string(s : MlmetricclusteringEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricclusteringPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_clustering_path_make(size : Int) -> MlmetricclusteringPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_clustering_path_len(s : MlmetricclusteringPath) -> Int { s.size }

pub fn ml_metric_clustering_path_get(s : MlmetricclusteringPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_clustering_path_set(s : MlmetricclusteringPath, i : Int, v : Double) -> MlmetricclusteringPath {
  let result = ml_metric_clustering_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_clustering_path_sum(s : MlmetricclusteringPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_metric_clustering_path_mean(s : MlmetricclusteringPath) -> Double {
  if s.size == 0 { 0.0 } else { ml_metric_clustering_path_sum(s) / s.size.to_double() }
}

pub fn ml_metric_clustering_path_scale(s : MlmetricclusteringPath, f : Double) -> MlmetricclusteringPath {
  let result = ml_metric_clustering_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_metric_clustering_path_add(a : MlmetricclusteringPath, b : MlmetricclusteringPath) -> MlmetricclusteringPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_metric_clustering_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_metric_clustering_path_copy(s : MlmetricclusteringPath) -> MlmetricclusteringPath {
  let result = ml_metric_clustering_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_metric_clustering_path_fill(s : MlmetricclusteringPath, v : Double) -> MlmetricclusteringPath {
  let result = ml_metric_clustering_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_metric_clustering_path_min(s : MlmetricclusteringPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_clustering_path_max(s : MlmetricclusteringPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_clustering_path_to_string(s : MlmetricclusteringPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricclusteringCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_clustering_cluster_make(size : Int) -> MlmetricclusteringCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_clustering_cluster_len(s : MlmetricclusteringCluster) -> Int { s.size }

pub fn ml_metric_clustering_cluster_get(s : MlmetricclusteringCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_clustering_cluster_set(s : MlmetricclusteringCluster, i : Int, v : Double) -> MlmetricclusteringCluster {
  let result = ml_metric_clustering_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_clustering_cluster_sum(s : MlmetricclusteringCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_metric_clustering_cluster_mean(s : MlmetricclusteringCluster) -> Double {
  if s.size == 0 { 0.0 } else { ml_metric_clustering_cluster_sum(s) / s.size.to_double() }
}

pub fn ml_metric_clustering_cluster_scale(s : MlmetricclusteringCluster, f : Double) -> MlmetricclusteringCluster {
  let result = ml_metric_clustering_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_metric_clustering_cluster_add(a : MlmetricclusteringCluster, b : MlmetricclusteringCluster) -> MlmetricclusteringCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_metric_clustering_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_metric_clustering_cluster_copy(s : MlmetricclusteringCluster) -> MlmetricclusteringCluster {
  let result = ml_metric_clustering_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_metric_clustering_cluster_fill(s : MlmetricclusteringCluster, v : Double) -> MlmetricclusteringCluster {
  let result = ml_metric_clustering_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_metric_clustering_cluster_min(s : MlmetricclusteringCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_clustering_cluster_max(s : MlmetricclusteringCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_clustering_cluster_to_string(s : MlmetricclusteringCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricclusteringModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_clustering_model_make(size : Int) -> MlmetricclusteringModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_clustering_model_len(s : MlmetricclusteringModel) -> Int { s.size }

pub fn ml_metric_clustering_model_get(s : MlmetricclusteringModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_clustering_model_set(s : MlmetricclusteringModel, i : Int, v : Double) -> MlmetricclusteringModel {
  let result = ml_metric_clustering_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_clustering_model_sum(s : MlmetricclusteringModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_metric_clustering_model_mean(s : MlmetricclusteringModel) -> Double {
  if s.size == 0 { 0.0 } else { ml_metric_clustering_model_sum(s) / s.size.to_double() }
}

pub fn ml_metric_clustering_model_scale(s : MlmetricclusteringModel, f : Double) -> MlmetricclusteringModel {
  let result = ml_metric_clustering_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_metric_clustering_model_add(a : MlmetricclusteringModel, b : MlmetricclusteringModel) -> MlmetricclusteringModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_metric_clustering_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_metric_clustering_model_copy(s : MlmetricclusteringModel) -> MlmetricclusteringModel {
  let result = ml_metric_clustering_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_metric_clustering_model_fill(s : MlmetricclusteringModel, v : Double) -> MlmetricclusteringModel {
  let result = ml_metric_clustering_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_metric_clustering_model_min(s : MlmetricclusteringModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_clustering_model_max(s : MlmetricclusteringModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_clustering_model_to_string(s : MlmetricclusteringModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricclusteringLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_clustering_layer_make(size : Int) -> MlmetricclusteringLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_clustering_layer_len(s : MlmetricclusteringLayer) -> Int { s.size }

pub fn ml_metric_clustering_layer_get(s : MlmetricclusteringLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_clustering_layer_set(s : MlmetricclusteringLayer, i : Int, v : Double) -> MlmetricclusteringLayer {
  let result = ml_metric_clustering_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_clustering_layer_sum(s : MlmetricclusteringLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_metric_clustering_layer_mean(s : MlmetricclusteringLayer) -> Double {
  if s.size == 0 { 0.0 } else { ml_metric_clustering_layer_sum(s) / s.size.to_double() }
}

pub fn ml_metric_clustering_layer_scale(s : MlmetricclusteringLayer, f : Double) -> MlmetricclusteringLayer {
  let result = ml_metric_clustering_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_metric_clustering_layer_add(a : MlmetricclusteringLayer, b : MlmetricclusteringLayer) -> MlmetricclusteringLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_metric_clustering_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_metric_clustering_layer_copy(s : MlmetricclusteringLayer) -> MlmetricclusteringLayer {
  let result = ml_metric_clustering_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_metric_clustering_layer_fill(s : MlmetricclusteringLayer, v : Double) -> MlmetricclusteringLayer {
  let result = ml_metric_clustering_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_metric_clustering_layer_min(s : MlmetricclusteringLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_clustering_layer_max(s : MlmetricclusteringLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_clustering_layer_to_string(s : MlmetricclusteringLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricclusteringBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_clustering_buffer_make(size : Int) -> MlmetricclusteringBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_clustering_buffer_len(s : MlmetricclusteringBuffer) -> Int { s.size }

pub fn ml_metric_clustering_buffer_get(s : MlmetricclusteringBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_clustering_buffer_set(s : MlmetricclusteringBuffer, i : Int, v : Double) -> MlmetricclusteringBuffer {
  let result = ml_metric_clustering_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_clustering_buffer_sum(s : MlmetricclusteringBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_metric_clustering_buffer_mean(s : MlmetricclusteringBuffer) -> Double {
  if s.size == 0 { 0.0 } else { ml_metric_clustering_buffer_sum(s) / s.size.to_double() }
}

pub fn ml_metric_clustering_buffer_scale(s : MlmetricclusteringBuffer, f : Double) -> MlmetricclusteringBuffer {
  let result = ml_metric_clustering_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_metric_clustering_buffer_add(a : MlmetricclusteringBuffer, b : MlmetricclusteringBuffer) -> MlmetricclusteringBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_metric_clustering_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_metric_clustering_buffer_copy(s : MlmetricclusteringBuffer) -> MlmetricclusteringBuffer {
  let result = ml_metric_clustering_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_metric_clustering_buffer_fill(s : MlmetricclusteringBuffer, v : Double) -> MlmetricclusteringBuffer {
  let result = ml_metric_clustering_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_metric_clustering_buffer_min(s : MlmetricclusteringBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_clustering_buffer_max(s : MlmetricclusteringBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_clustering_buffer_to_string(s : MlmetricclusteringBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricclusteringCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_clustering_cursor_make(size : Int) -> MlmetricclusteringCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_clustering_cursor_len(s : MlmetricclusteringCursor) -> Int { s.size }

pub fn ml_metric_clustering_cursor_get(s : MlmetricclusteringCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_clustering_cursor_set(s : MlmetricclusteringCursor, i : Int, v : Double) -> MlmetricclusteringCursor {
  let result = ml_metric_clustering_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_clustering_cursor_sum(s : MlmetricclusteringCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_metric_clustering_cursor_mean(s : MlmetricclusteringCursor) -> Double {
  if s.size == 0 { 0.0 } else { ml_metric_clustering_cursor_sum(s) / s.size.to_double() }
}

pub fn ml_metric_clustering_cursor_scale(s : MlmetricclusteringCursor, f : Double) -> MlmetricclusteringCursor {
  let result = ml_metric_clustering_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_metric_clustering_cursor_add(a : MlmetricclusteringCursor, b : MlmetricclusteringCursor) -> MlmetricclusteringCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_metric_clustering_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_metric_clustering_cursor_copy(s : MlmetricclusteringCursor) -> MlmetricclusteringCursor {
  let result = ml_metric_clustering_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_metric_clustering_cursor_fill(s : MlmetricclusteringCursor, v : Double) -> MlmetricclusteringCursor {
  let result = ml_metric_clustering_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_metric_clustering_cursor_min(s : MlmetricclusteringCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_clustering_cursor_max(s : MlmetricclusteringCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_clustering_cursor_to_string(s : MlmetricclusteringCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricclusteringView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_clustering_view_make(size : Int) -> MlmetricclusteringView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_clustering_view_len(s : MlmetricclusteringView) -> Int { s.size }

pub fn ml_metric_clustering_view_get(s : MlmetricclusteringView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_clustering_view_set(s : MlmetricclusteringView, i : Int, v : Double) -> MlmetricclusteringView {
  let result = ml_metric_clustering_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_clustering_view_sum(s : MlmetricclusteringView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_metric_clustering_view_mean(s : MlmetricclusteringView) -> Double {
  if s.size == 0 { 0.0 } else { ml_metric_clustering_view_sum(s) / s.size.to_double() }
}

pub fn ml_metric_clustering_view_scale(s : MlmetricclusteringView, f : Double) -> MlmetricclusteringView {
  let result = ml_metric_clustering_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_metric_clustering_view_add(a : MlmetricclusteringView, b : MlmetricclusteringView) -> MlmetricclusteringView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_metric_clustering_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_metric_clustering_view_copy(s : MlmetricclusteringView) -> MlmetricclusteringView {
  let result = ml_metric_clustering_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_metric_clustering_view_fill(s : MlmetricclusteringView, v : Double) -> MlmetricclusteringView {
  let result = ml_metric_clustering_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_metric_clustering_view_min(s : MlmetricclusteringView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_clustering_view_max(s : MlmetricclusteringView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_clustering_view_to_string(s : MlmetricclusteringView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricclusteringRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_clustering_range_make(size : Int) -> MlmetricclusteringRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_clustering_range_len(s : MlmetricclusteringRange) -> Int { s.size }

pub fn ml_metric_clustering_range_get(s : MlmetricclusteringRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_clustering_range_set(s : MlmetricclusteringRange, i : Int, v : Double) -> MlmetricclusteringRange {
  let result = ml_metric_clustering_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_clustering_range_sum(s : MlmetricclusteringRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_metric_clustering_range_mean(s : MlmetricclusteringRange) -> Double {
  if s.size == 0 { 0.0 } else { ml_metric_clustering_range_sum(s) / s.size.to_double() }
}

pub fn ml_metric_clustering_range_scale(s : MlmetricclusteringRange, f : Double) -> MlmetricclusteringRange {
  let result = ml_metric_clustering_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_metric_clustering_range_add(a : MlmetricclusteringRange, b : MlmetricclusteringRange) -> MlmetricclusteringRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_metric_clustering_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_metric_clustering_range_copy(s : MlmetricclusteringRange) -> MlmetricclusteringRange {
  let result = ml_metric_clustering_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_metric_clustering_range_fill(s : MlmetricclusteringRange, v : Double) -> MlmetricclusteringRange {
  let result = ml_metric_clustering_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_metric_clustering_range_min(s : MlmetricclusteringRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_clustering_range_max(s : MlmetricclusteringRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_clustering_range_to_string(s : MlmetricclusteringRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricclusteringSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_clustering_slice_make(size : Int) -> MlmetricclusteringSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_clustering_slice_len(s : MlmetricclusteringSlice) -> Int { s.size }

pub fn ml_metric_clustering_slice_get(s : MlmetricclusteringSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_clustering_slice_set(s : MlmetricclusteringSlice, i : Int, v : Double) -> MlmetricclusteringSlice {
  let result = ml_metric_clustering_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_clustering_slice_sum(s : MlmetricclusteringSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_metric_clustering_slice_mean(s : MlmetricclusteringSlice) -> Double {
  if s.size == 0 { 0.0 } else { ml_metric_clustering_slice_sum(s) / s.size.to_double() }
}

pub fn ml_metric_clustering_slice_scale(s : MlmetricclusteringSlice, f : Double) -> MlmetricclusteringSlice {
  let result = ml_metric_clustering_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_metric_clustering_slice_add(a : MlmetricclusteringSlice, b : MlmetricclusteringSlice) -> MlmetricclusteringSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_metric_clustering_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_metric_clustering_slice_copy(s : MlmetricclusteringSlice) -> MlmetricclusteringSlice {
  let result = ml_metric_clustering_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_metric_clustering_slice_fill(s : MlmetricclusteringSlice, v : Double) -> MlmetricclusteringSlice {
  let result = ml_metric_clustering_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_metric_clustering_slice_min(s : MlmetricclusteringSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_clustering_slice_max(s : MlmetricclusteringSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_clustering_slice_to_string(s : MlmetricclusteringSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


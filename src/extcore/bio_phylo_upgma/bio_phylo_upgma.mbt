///===
/// extcore/bio_phylo_upgma

pub(all) struct BiophyloupgmaPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn bio_phylo_upgma_make_point(x : Double, y : Double) -> BiophyloupgmaPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn bio_phylo_upgma_make_point3(x : Double, y : Double, z : Double) -> BiophyloupgmaPoint {
  { x, y, z, label: 0 }
}

pub fn bio_phylo_upgma_point_x(pt : BiophyloupgmaPoint) -> Double { pt.x }

pub fn bio_phylo_upgma_point_y(pt : BiophyloupgmaPoint) -> Double { pt.y }

pub fn bio_phylo_upgma_point_z(pt : BiophyloupgmaPoint) -> Double { pt.z }

pub fn bio_phylo_upgma_point_label(pt : BiophyloupgmaPoint) -> Int { pt.label }

pub fn bio_phylo_upgma_point_dist(a : BiophyloupgmaPoint, b : BiophyloupgmaPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn bio_phylo_upgma_point_add(a : BiophyloupgmaPoint, b : BiophyloupgmaPoint) -> BiophyloupgmaPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn bio_phylo_upgma_point_sub(a : BiophyloupgmaPoint, b : BiophyloupgmaPoint) -> BiophyloupgmaPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn bio_phylo_upgma_point_scale(pt : BiophyloupgmaPoint, s : Double) -> BiophyloupgmaPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn bio_phylo_upgma_point_dot(a : BiophyloupgmaPoint, b : BiophyloupgmaPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn bio_phylo_upgma_point_cross(a : BiophyloupgmaPoint, b : BiophyloupgmaPoint) -> BiophyloupgmaPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn bio_phylo_upgma_point_norm(pt : BiophyloupgmaPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn bio_phylo_upgma_point_normalize(pt : BiophyloupgmaPoint) -> BiophyloupgmaPoint {
  let n = bio_phylo_upgma_point_norm(pt)
  if n < 0.0000001 { pt } else { bio_phylo_upgma_point_scale(pt, 1.0 / n) }
}

pub fn bio_phylo_upgma_point_negate(pt : BiophyloupgmaPoint) -> BiophyloupgmaPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn bio_phylo_upgma_point_mid(a : BiophyloupgmaPoint, b : BiophyloupgmaPoint) -> BiophyloupgmaPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn bio_phylo_upgma_point_lerp(a : BiophyloupgmaPoint, b : BiophyloupgmaPoint, t : Double) -> BiophyloupgmaPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn bio_phylo_upgma_point_to_string(pt : BiophyloupgmaPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct BiophyloupgmaSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn bio_phylo_upgma_make_series(vals : Array[Double], name : String) -> BiophyloupgmaSeries {
  { vals, name, meta: 0 }
}

pub fn bio_phylo_upgma_series_len(s : BiophyloupgmaSeries) -> Int { s.vals.length() }

pub fn bio_phylo_upgma_series_sum(s : BiophyloupgmaSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn bio_phylo_upgma_series_mean(s : BiophyloupgmaSeries) -> Double {
  let n = bio_phylo_upgma_series_len(s)
  if n == 0 { 0.0 } else { bio_phylo_upgma_series_sum(s) / n.to_double() }
}

pub fn bio_phylo_upgma_series_min(s : BiophyloupgmaSeries) -> Double {
  let n = bio_phylo_upgma_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn bio_phylo_upgma_series_max(s : BiophyloupgmaSeries) -> Double {
  let n = bio_phylo_upgma_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn bio_phylo_upgma_series_range(s : BiophyloupgmaSeries) -> Double {
  bio_phylo_upgma_series_max(s) - bio_phylo_upgma_series_min(s)
}

pub fn bio_phylo_upgma_series_var(s : BiophyloupgmaSeries) -> Double {
  let n = bio_phylo_upgma_series_len(s)
  if n == 0 { 0.0 } else {
    let m = bio_phylo_upgma_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn bio_phylo_upgma_series_std(s : BiophyloupgmaSeries) -> Double { @_common.sqrt(bio_phylo_upgma_series_var(s)) }

pub fn bio_phylo_upgma_series_median(s : BiophyloupgmaSeries) -> Double {
  let n = bio_phylo_upgma_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = bio_phylo_upgma_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn bio_phylo_upgma_series_scale(s : BiophyloupgmaSeries, f : Double) -> BiophyloupgmaSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn bio_phylo_upgma_series_add(a : BiophyloupgmaSeries, b : BiophyloupgmaSeries) -> BiophyloupgmaSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn bio_phylo_upgma_series_sub(a : BiophyloupgmaSeries, b : BiophyloupgmaSeries) -> BiophyloupgmaSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn bio_phylo_upgma_series_normalize(s : BiophyloupgmaSeries) -> BiophyloupgmaSeries {
  let mn = bio_phylo_upgma_series_min(s)
  let mx = bio_phylo_upgma_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn bio_phylo_upgma_series_cumsum(s : BiophyloupgmaSeries) -> BiophyloupgmaSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn bio_phylo_upgma_series_to_string(s : BiophyloupgmaSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BiophyloupgmaMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn bio_phylo_upgma_make_matrix(rows : Int, cols : Int, val : Double) -> BiophyloupgmaMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn bio_phylo_upgma_matrix_identity(n : Int) -> BiophyloupgmaMatrix {
  let m = bio_phylo_upgma_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn bio_phylo_upgma_matrix_get(m : BiophyloupgmaMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn bio_phylo_upgma_matrix_transpose(m : BiophyloupgmaMatrix) -> BiophyloupgmaMatrix {
  let result = bio_phylo_upgma_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn bio_phylo_upgma_matrix_add(a : BiophyloupgmaMatrix, b : BiophyloupgmaMatrix) -> BiophyloupgmaMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = bio_phylo_upgma_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn bio_phylo_upgma_matrix_scale(m : BiophyloupgmaMatrix, s : Double) -> BiophyloupgmaMatrix {
  let result = bio_phylo_upgma_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn bio_phylo_upgma_matrix_multiply(a : BiophyloupgmaMatrix, b : BiophyloupgmaMatrix) -> BiophyloupgmaMatrix {
  if a.cols != b.rows { return bio_phylo_upgma_make_matrix(a.rows, b.cols, 0.0) }
  let result = bio_phylo_upgma_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn bio_phylo_upgma_matrix_trace(m : BiophyloupgmaMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn bio_phylo_upgma_matrix_det(m : BiophyloupgmaMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn bio_phylo_upgma_matrix_norm(m : BiophyloupgmaMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn bio_phylo_upgma_matrix_to_string(m : BiophyloupgmaMatrix) -> String {
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

pub(all) struct BiophyloupgmaVector {
  comps : Array[Double]
  dim : Int
}

pub fn bio_phylo_upgma_make_vector(comps : Array[Double]) -> BiophyloupgmaVector {
  { comps, dim: comps.length() }
}

pub fn bio_phylo_upgma_vector_zero(dim : Int) -> BiophyloupgmaVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn bio_phylo_upgma_vector_add(a : BiophyloupgmaVector, b : BiophyloupgmaVector) -> BiophyloupgmaVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn bio_phylo_upgma_vector_sub(a : BiophyloupgmaVector, b : BiophyloupgmaVector) -> BiophyloupgmaVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn bio_phylo_upgma_vector_scale(v : BiophyloupgmaVector, s : Double) -> BiophyloupgmaVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn bio_phylo_upgma_vector_dot(a : BiophyloupgmaVector, b : BiophyloupgmaVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn bio_phylo_upgma_vector_norm(v : BiophyloupgmaVector) -> Double { @_common.sqrt(bio_phylo_upgma_vector_dot(v, v)) }

pub fn bio_phylo_upgma_vector_normalize(v : BiophyloupgmaVector) -> BiophyloupgmaVector {
  let n = bio_phylo_upgma_vector_norm(v)
  if n < 0.0000001 { v } else { bio_phylo_upgma_vector_scale(v, 1.0 / n) }
}

pub fn bio_phylo_upgma_vector_dist(a : BiophyloupgmaVector, b : BiophyloupgmaVector) -> Double {
  bio_phylo_upgma_vector_norm(bio_phylo_upgma_vector_sub(a, b))
}

pub fn bio_phylo_upgma_vector_to_string(v : BiophyloupgmaVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn bio_phylo_upgma_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn bio_phylo_upgma_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn bio_phylo_upgma_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn bio_phylo_upgma_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn bio_phylo_upgma_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn bio_phylo_upgma_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn bio_phylo_upgma_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn bio_phylo_upgma_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn bio_phylo_upgma_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn bio_phylo_upgma_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn bio_phylo_upgma_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn bio_phylo_upgma_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn bio_phylo_upgma_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn bio_phylo_upgma_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn bio_phylo_upgma_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn bio_phylo_upgma_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn bio_phylo_upgma_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn bio_phylo_upgma_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn bio_phylo_upgma_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn bio_phylo_upgma_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn bio_phylo_upgma_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn bio_phylo_upgma_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn bio_phylo_upgma_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn bio_phylo_upgma_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn bio_phylo_upgma_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn bio_phylo_upgma_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn bio_phylo_upgma_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn bio_phylo_upgma_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn bio_phylo_upgma_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct BiophyloupgmaFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_upgma_frame_make(size : Int) -> BiophyloupgmaFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_upgma_frame_len(s : BiophyloupgmaFrame) -> Int { s.size }

pub fn bio_phylo_upgma_frame_get(s : BiophyloupgmaFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_upgma_frame_set(s : BiophyloupgmaFrame, i : Int, v : Double) -> BiophyloupgmaFrame {
  let result = bio_phylo_upgma_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_upgma_frame_sum(s : BiophyloupgmaFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_phylo_upgma_frame_mean(s : BiophyloupgmaFrame) -> Double {
  if s.size == 0 { 0.0 } else { bio_phylo_upgma_frame_sum(s) / s.size.to_double() }
}

pub fn bio_phylo_upgma_frame_scale(s : BiophyloupgmaFrame, f : Double) -> BiophyloupgmaFrame {
  let result = bio_phylo_upgma_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_upgma_frame_add(a : BiophyloupgmaFrame, b : BiophyloupgmaFrame) -> BiophyloupgmaFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_upgma_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_upgma_frame_copy(s : BiophyloupgmaFrame) -> BiophyloupgmaFrame {
  let result = bio_phylo_upgma_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_upgma_frame_fill(s : BiophyloupgmaFrame, v : Double) -> BiophyloupgmaFrame {
  let result = bio_phylo_upgma_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_upgma_frame_min(s : BiophyloupgmaFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_upgma_frame_max(s : BiophyloupgmaFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_upgma_frame_to_string(s : BiophyloupgmaFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloupgmaTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_upgma_table_make(size : Int) -> BiophyloupgmaTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_upgma_table_len(s : BiophyloupgmaTable) -> Int { s.size }

pub fn bio_phylo_upgma_table_get(s : BiophyloupgmaTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_upgma_table_set(s : BiophyloupgmaTable, i : Int, v : Double) -> BiophyloupgmaTable {
  let result = bio_phylo_upgma_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_upgma_table_sum(s : BiophyloupgmaTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_phylo_upgma_table_mean(s : BiophyloupgmaTable) -> Double {
  if s.size == 0 { 0.0 } else { bio_phylo_upgma_table_sum(s) / s.size.to_double() }
}

pub fn bio_phylo_upgma_table_scale(s : BiophyloupgmaTable, f : Double) -> BiophyloupgmaTable {
  let result = bio_phylo_upgma_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_upgma_table_add(a : BiophyloupgmaTable, b : BiophyloupgmaTable) -> BiophyloupgmaTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_upgma_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_upgma_table_copy(s : BiophyloupgmaTable) -> BiophyloupgmaTable {
  let result = bio_phylo_upgma_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_upgma_table_fill(s : BiophyloupgmaTable, v : Double) -> BiophyloupgmaTable {
  let result = bio_phylo_upgma_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_upgma_table_min(s : BiophyloupgmaTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_upgma_table_max(s : BiophyloupgmaTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_upgma_table_to_string(s : BiophyloupgmaTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloupgmaGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_upgma_graphn_make(size : Int) -> BiophyloupgmaGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_upgma_graphn_len(s : BiophyloupgmaGraphN) -> Int { s.size }

pub fn bio_phylo_upgma_graphn_get(s : BiophyloupgmaGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_upgma_graphn_set(s : BiophyloupgmaGraphN, i : Int, v : Double) -> BiophyloupgmaGraphN {
  let result = bio_phylo_upgma_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_upgma_graphn_sum(s : BiophyloupgmaGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_phylo_upgma_graphn_mean(s : BiophyloupgmaGraphN) -> Double {
  if s.size == 0 { 0.0 } else { bio_phylo_upgma_graphn_sum(s) / s.size.to_double() }
}

pub fn bio_phylo_upgma_graphn_scale(s : BiophyloupgmaGraphN, f : Double) -> BiophyloupgmaGraphN {
  let result = bio_phylo_upgma_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_upgma_graphn_add(a : BiophyloupgmaGraphN, b : BiophyloupgmaGraphN) -> BiophyloupgmaGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_upgma_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_upgma_graphn_copy(s : BiophyloupgmaGraphN) -> BiophyloupgmaGraphN {
  let result = bio_phylo_upgma_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_upgma_graphn_fill(s : BiophyloupgmaGraphN, v : Double) -> BiophyloupgmaGraphN {
  let result = bio_phylo_upgma_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_upgma_graphn_min(s : BiophyloupgmaGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_upgma_graphn_max(s : BiophyloupgmaGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_upgma_graphn_to_string(s : BiophyloupgmaGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloupgmaNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_upgma_node_make(size : Int) -> BiophyloupgmaNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_upgma_node_len(s : BiophyloupgmaNode) -> Int { s.size }

pub fn bio_phylo_upgma_node_get(s : BiophyloupgmaNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_upgma_node_set(s : BiophyloupgmaNode, i : Int, v : Double) -> BiophyloupgmaNode {
  let result = bio_phylo_upgma_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_upgma_node_sum(s : BiophyloupgmaNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_phylo_upgma_node_mean(s : BiophyloupgmaNode) -> Double {
  if s.size == 0 { 0.0 } else { bio_phylo_upgma_node_sum(s) / s.size.to_double() }
}

pub fn bio_phylo_upgma_node_scale(s : BiophyloupgmaNode, f : Double) -> BiophyloupgmaNode {
  let result = bio_phylo_upgma_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_upgma_node_add(a : BiophyloupgmaNode, b : BiophyloupgmaNode) -> BiophyloupgmaNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_upgma_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_upgma_node_copy(s : BiophyloupgmaNode) -> BiophyloupgmaNode {
  let result = bio_phylo_upgma_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_upgma_node_fill(s : BiophyloupgmaNode, v : Double) -> BiophyloupgmaNode {
  let result = bio_phylo_upgma_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_upgma_node_min(s : BiophyloupgmaNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_upgma_node_max(s : BiophyloupgmaNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_upgma_node_to_string(s : BiophyloupgmaNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloupgmaEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_upgma_edge_make(size : Int) -> BiophyloupgmaEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_upgma_edge_len(s : BiophyloupgmaEdge) -> Int { s.size }

pub fn bio_phylo_upgma_edge_get(s : BiophyloupgmaEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_upgma_edge_set(s : BiophyloupgmaEdge, i : Int, v : Double) -> BiophyloupgmaEdge {
  let result = bio_phylo_upgma_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_upgma_edge_sum(s : BiophyloupgmaEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_phylo_upgma_edge_mean(s : BiophyloupgmaEdge) -> Double {
  if s.size == 0 { 0.0 } else { bio_phylo_upgma_edge_sum(s) / s.size.to_double() }
}

pub fn bio_phylo_upgma_edge_scale(s : BiophyloupgmaEdge, f : Double) -> BiophyloupgmaEdge {
  let result = bio_phylo_upgma_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_upgma_edge_add(a : BiophyloupgmaEdge, b : BiophyloupgmaEdge) -> BiophyloupgmaEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_upgma_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_upgma_edge_copy(s : BiophyloupgmaEdge) -> BiophyloupgmaEdge {
  let result = bio_phylo_upgma_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_upgma_edge_fill(s : BiophyloupgmaEdge, v : Double) -> BiophyloupgmaEdge {
  let result = bio_phylo_upgma_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_upgma_edge_min(s : BiophyloupgmaEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_upgma_edge_max(s : BiophyloupgmaEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_upgma_edge_to_string(s : BiophyloupgmaEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloupgmaPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_upgma_path_make(size : Int) -> BiophyloupgmaPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_upgma_path_len(s : BiophyloupgmaPath) -> Int { s.size }

pub fn bio_phylo_upgma_path_get(s : BiophyloupgmaPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_upgma_path_set(s : BiophyloupgmaPath, i : Int, v : Double) -> BiophyloupgmaPath {
  let result = bio_phylo_upgma_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_upgma_path_sum(s : BiophyloupgmaPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_phylo_upgma_path_mean(s : BiophyloupgmaPath) -> Double {
  if s.size == 0 { 0.0 } else { bio_phylo_upgma_path_sum(s) / s.size.to_double() }
}

pub fn bio_phylo_upgma_path_scale(s : BiophyloupgmaPath, f : Double) -> BiophyloupgmaPath {
  let result = bio_phylo_upgma_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_upgma_path_add(a : BiophyloupgmaPath, b : BiophyloupgmaPath) -> BiophyloupgmaPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_upgma_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_upgma_path_copy(s : BiophyloupgmaPath) -> BiophyloupgmaPath {
  let result = bio_phylo_upgma_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_upgma_path_fill(s : BiophyloupgmaPath, v : Double) -> BiophyloupgmaPath {
  let result = bio_phylo_upgma_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_upgma_path_min(s : BiophyloupgmaPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_upgma_path_max(s : BiophyloupgmaPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_upgma_path_to_string(s : BiophyloupgmaPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloupgmaCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_upgma_cluster_make(size : Int) -> BiophyloupgmaCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_upgma_cluster_len(s : BiophyloupgmaCluster) -> Int { s.size }

pub fn bio_phylo_upgma_cluster_get(s : BiophyloupgmaCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_upgma_cluster_set(s : BiophyloupgmaCluster, i : Int, v : Double) -> BiophyloupgmaCluster {
  let result = bio_phylo_upgma_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_upgma_cluster_sum(s : BiophyloupgmaCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_phylo_upgma_cluster_mean(s : BiophyloupgmaCluster) -> Double {
  if s.size == 0 { 0.0 } else { bio_phylo_upgma_cluster_sum(s) / s.size.to_double() }
}

pub fn bio_phylo_upgma_cluster_scale(s : BiophyloupgmaCluster, f : Double) -> BiophyloupgmaCluster {
  let result = bio_phylo_upgma_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_upgma_cluster_add(a : BiophyloupgmaCluster, b : BiophyloupgmaCluster) -> BiophyloupgmaCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_upgma_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_upgma_cluster_copy(s : BiophyloupgmaCluster) -> BiophyloupgmaCluster {
  let result = bio_phylo_upgma_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_upgma_cluster_fill(s : BiophyloupgmaCluster, v : Double) -> BiophyloupgmaCluster {
  let result = bio_phylo_upgma_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_upgma_cluster_min(s : BiophyloupgmaCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_upgma_cluster_max(s : BiophyloupgmaCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_upgma_cluster_to_string(s : BiophyloupgmaCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloupgmaModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_upgma_model_make(size : Int) -> BiophyloupgmaModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_upgma_model_len(s : BiophyloupgmaModel) -> Int { s.size }

pub fn bio_phylo_upgma_model_get(s : BiophyloupgmaModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_upgma_model_set(s : BiophyloupgmaModel, i : Int, v : Double) -> BiophyloupgmaModel {
  let result = bio_phylo_upgma_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_upgma_model_sum(s : BiophyloupgmaModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_phylo_upgma_model_mean(s : BiophyloupgmaModel) -> Double {
  if s.size == 0 { 0.0 } else { bio_phylo_upgma_model_sum(s) / s.size.to_double() }
}

pub fn bio_phylo_upgma_model_scale(s : BiophyloupgmaModel, f : Double) -> BiophyloupgmaModel {
  let result = bio_phylo_upgma_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_upgma_model_add(a : BiophyloupgmaModel, b : BiophyloupgmaModel) -> BiophyloupgmaModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_upgma_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_upgma_model_copy(s : BiophyloupgmaModel) -> BiophyloupgmaModel {
  let result = bio_phylo_upgma_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_upgma_model_fill(s : BiophyloupgmaModel, v : Double) -> BiophyloupgmaModel {
  let result = bio_phylo_upgma_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_upgma_model_min(s : BiophyloupgmaModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_upgma_model_max(s : BiophyloupgmaModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_upgma_model_to_string(s : BiophyloupgmaModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloupgmaLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_upgma_layer_make(size : Int) -> BiophyloupgmaLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_upgma_layer_len(s : BiophyloupgmaLayer) -> Int { s.size }

pub fn bio_phylo_upgma_layer_get(s : BiophyloupgmaLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_upgma_layer_set(s : BiophyloupgmaLayer, i : Int, v : Double) -> BiophyloupgmaLayer {
  let result = bio_phylo_upgma_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_upgma_layer_sum(s : BiophyloupgmaLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_phylo_upgma_layer_mean(s : BiophyloupgmaLayer) -> Double {
  if s.size == 0 { 0.0 } else { bio_phylo_upgma_layer_sum(s) / s.size.to_double() }
}

pub fn bio_phylo_upgma_layer_scale(s : BiophyloupgmaLayer, f : Double) -> BiophyloupgmaLayer {
  let result = bio_phylo_upgma_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_upgma_layer_add(a : BiophyloupgmaLayer, b : BiophyloupgmaLayer) -> BiophyloupgmaLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_upgma_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_upgma_layer_copy(s : BiophyloupgmaLayer) -> BiophyloupgmaLayer {
  let result = bio_phylo_upgma_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_upgma_layer_fill(s : BiophyloupgmaLayer, v : Double) -> BiophyloupgmaLayer {
  let result = bio_phylo_upgma_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_upgma_layer_min(s : BiophyloupgmaLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_upgma_layer_max(s : BiophyloupgmaLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_upgma_layer_to_string(s : BiophyloupgmaLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloupgmaBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_upgma_buffer_make(size : Int) -> BiophyloupgmaBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_upgma_buffer_len(s : BiophyloupgmaBuffer) -> Int { s.size }

pub fn bio_phylo_upgma_buffer_get(s : BiophyloupgmaBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_upgma_buffer_set(s : BiophyloupgmaBuffer, i : Int, v : Double) -> BiophyloupgmaBuffer {
  let result = bio_phylo_upgma_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_upgma_buffer_sum(s : BiophyloupgmaBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_phylo_upgma_buffer_mean(s : BiophyloupgmaBuffer) -> Double {
  if s.size == 0 { 0.0 } else { bio_phylo_upgma_buffer_sum(s) / s.size.to_double() }
}

pub fn bio_phylo_upgma_buffer_scale(s : BiophyloupgmaBuffer, f : Double) -> BiophyloupgmaBuffer {
  let result = bio_phylo_upgma_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_upgma_buffer_add(a : BiophyloupgmaBuffer, b : BiophyloupgmaBuffer) -> BiophyloupgmaBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_upgma_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_upgma_buffer_copy(s : BiophyloupgmaBuffer) -> BiophyloupgmaBuffer {
  let result = bio_phylo_upgma_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_upgma_buffer_fill(s : BiophyloupgmaBuffer, v : Double) -> BiophyloupgmaBuffer {
  let result = bio_phylo_upgma_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_upgma_buffer_min(s : BiophyloupgmaBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_upgma_buffer_max(s : BiophyloupgmaBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_upgma_buffer_to_string(s : BiophyloupgmaBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloupgmaCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_upgma_cursor_make(size : Int) -> BiophyloupgmaCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_upgma_cursor_len(s : BiophyloupgmaCursor) -> Int { s.size }

pub fn bio_phylo_upgma_cursor_get(s : BiophyloupgmaCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_upgma_cursor_set(s : BiophyloupgmaCursor, i : Int, v : Double) -> BiophyloupgmaCursor {
  let result = bio_phylo_upgma_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_upgma_cursor_sum(s : BiophyloupgmaCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_phylo_upgma_cursor_mean(s : BiophyloupgmaCursor) -> Double {
  if s.size == 0 { 0.0 } else { bio_phylo_upgma_cursor_sum(s) / s.size.to_double() }
}

pub fn bio_phylo_upgma_cursor_scale(s : BiophyloupgmaCursor, f : Double) -> BiophyloupgmaCursor {
  let result = bio_phylo_upgma_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_upgma_cursor_add(a : BiophyloupgmaCursor, b : BiophyloupgmaCursor) -> BiophyloupgmaCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_upgma_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_upgma_cursor_copy(s : BiophyloupgmaCursor) -> BiophyloupgmaCursor {
  let result = bio_phylo_upgma_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_upgma_cursor_fill(s : BiophyloupgmaCursor, v : Double) -> BiophyloupgmaCursor {
  let result = bio_phylo_upgma_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_upgma_cursor_min(s : BiophyloupgmaCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_upgma_cursor_max(s : BiophyloupgmaCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_upgma_cursor_to_string(s : BiophyloupgmaCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloupgmaView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_upgma_view_make(size : Int) -> BiophyloupgmaView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_upgma_view_len(s : BiophyloupgmaView) -> Int { s.size }

pub fn bio_phylo_upgma_view_get(s : BiophyloupgmaView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_upgma_view_set(s : BiophyloupgmaView, i : Int, v : Double) -> BiophyloupgmaView {
  let result = bio_phylo_upgma_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_upgma_view_sum(s : BiophyloupgmaView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_phylo_upgma_view_mean(s : BiophyloupgmaView) -> Double {
  if s.size == 0 { 0.0 } else { bio_phylo_upgma_view_sum(s) / s.size.to_double() }
}

pub fn bio_phylo_upgma_view_scale(s : BiophyloupgmaView, f : Double) -> BiophyloupgmaView {
  let result = bio_phylo_upgma_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_upgma_view_add(a : BiophyloupgmaView, b : BiophyloupgmaView) -> BiophyloupgmaView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_upgma_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_upgma_view_copy(s : BiophyloupgmaView) -> BiophyloupgmaView {
  let result = bio_phylo_upgma_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_upgma_view_fill(s : BiophyloupgmaView, v : Double) -> BiophyloupgmaView {
  let result = bio_phylo_upgma_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_upgma_view_min(s : BiophyloupgmaView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_upgma_view_max(s : BiophyloupgmaView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_upgma_view_to_string(s : BiophyloupgmaView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloupgmaRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_upgma_range_make(size : Int) -> BiophyloupgmaRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_upgma_range_len(s : BiophyloupgmaRange) -> Int { s.size }

pub fn bio_phylo_upgma_range_get(s : BiophyloupgmaRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_upgma_range_set(s : BiophyloupgmaRange, i : Int, v : Double) -> BiophyloupgmaRange {
  let result = bio_phylo_upgma_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_upgma_range_sum(s : BiophyloupgmaRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_phylo_upgma_range_mean(s : BiophyloupgmaRange) -> Double {
  if s.size == 0 { 0.0 } else { bio_phylo_upgma_range_sum(s) / s.size.to_double() }
}

pub fn bio_phylo_upgma_range_scale(s : BiophyloupgmaRange, f : Double) -> BiophyloupgmaRange {
  let result = bio_phylo_upgma_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_upgma_range_add(a : BiophyloupgmaRange, b : BiophyloupgmaRange) -> BiophyloupgmaRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_upgma_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_upgma_range_copy(s : BiophyloupgmaRange) -> BiophyloupgmaRange {
  let result = bio_phylo_upgma_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_upgma_range_fill(s : BiophyloupgmaRange, v : Double) -> BiophyloupgmaRange {
  let result = bio_phylo_upgma_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_upgma_range_min(s : BiophyloupgmaRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_upgma_range_max(s : BiophyloupgmaRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_upgma_range_to_string(s : BiophyloupgmaRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloupgmaSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_upgma_slice_make(size : Int) -> BiophyloupgmaSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_upgma_slice_len(s : BiophyloupgmaSlice) -> Int { s.size }

pub fn bio_phylo_upgma_slice_get(s : BiophyloupgmaSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_upgma_slice_set(s : BiophyloupgmaSlice, i : Int, v : Double) -> BiophyloupgmaSlice {
  let result = bio_phylo_upgma_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_upgma_slice_sum(s : BiophyloupgmaSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_phylo_upgma_slice_mean(s : BiophyloupgmaSlice) -> Double {
  if s.size == 0 { 0.0 } else { bio_phylo_upgma_slice_sum(s) / s.size.to_double() }
}

pub fn bio_phylo_upgma_slice_scale(s : BiophyloupgmaSlice, f : Double) -> BiophyloupgmaSlice {
  let result = bio_phylo_upgma_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_upgma_slice_add(a : BiophyloupgmaSlice, b : BiophyloupgmaSlice) -> BiophyloupgmaSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_upgma_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_upgma_slice_copy(s : BiophyloupgmaSlice) -> BiophyloupgmaSlice {
  let result = bio_phylo_upgma_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_upgma_slice_fill(s : BiophyloupgmaSlice, v : Double) -> BiophyloupgmaSlice {
  let result = bio_phylo_upgma_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_upgma_slice_min(s : BiophyloupgmaSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_upgma_slice_max(s : BiophyloupgmaSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_upgma_slice_to_string(s : BiophyloupgmaSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


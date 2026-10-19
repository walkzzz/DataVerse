///===
/// extcore/bio_seq_align_consistency

pub(all) struct BioseqalignconsistencyPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn bio_seq_align_consistency_make_point(x : Double, y : Double) -> BioseqalignconsistencyPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn bio_seq_align_consistency_make_point3(x : Double, y : Double, z : Double) -> BioseqalignconsistencyPoint {
  { x, y, z, label: 0 }
}

pub fn bio_seq_align_consistency_point_x(pt : BioseqalignconsistencyPoint) -> Double { pt.x }

pub fn bio_seq_align_consistency_point_y(pt : BioseqalignconsistencyPoint) -> Double { pt.y }

pub fn bio_seq_align_consistency_point_z(pt : BioseqalignconsistencyPoint) -> Double { pt.z }

pub fn bio_seq_align_consistency_point_label(pt : BioseqalignconsistencyPoint) -> Int { pt.label }

pub fn bio_seq_align_consistency_point_dist(a : BioseqalignconsistencyPoint, b : BioseqalignconsistencyPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn bio_seq_align_consistency_point_add(a : BioseqalignconsistencyPoint, b : BioseqalignconsistencyPoint) -> BioseqalignconsistencyPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn bio_seq_align_consistency_point_sub(a : BioseqalignconsistencyPoint, b : BioseqalignconsistencyPoint) -> BioseqalignconsistencyPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn bio_seq_align_consistency_point_scale(pt : BioseqalignconsistencyPoint, s : Double) -> BioseqalignconsistencyPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn bio_seq_align_consistency_point_dot(a : BioseqalignconsistencyPoint, b : BioseqalignconsistencyPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn bio_seq_align_consistency_point_cross(a : BioseqalignconsistencyPoint, b : BioseqalignconsistencyPoint) -> BioseqalignconsistencyPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn bio_seq_align_consistency_point_norm(pt : BioseqalignconsistencyPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn bio_seq_align_consistency_point_normalize(pt : BioseqalignconsistencyPoint) -> BioseqalignconsistencyPoint {
  let n = bio_seq_align_consistency_point_norm(pt)
  if n < 0.0000001 { pt } else { bio_seq_align_consistency_point_scale(pt, 1.0 / n) }
}

pub fn bio_seq_align_consistency_point_negate(pt : BioseqalignconsistencyPoint) -> BioseqalignconsistencyPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn bio_seq_align_consistency_point_mid(a : BioseqalignconsistencyPoint, b : BioseqalignconsistencyPoint) -> BioseqalignconsistencyPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn bio_seq_align_consistency_point_lerp(a : BioseqalignconsistencyPoint, b : BioseqalignconsistencyPoint, t : Double) -> BioseqalignconsistencyPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn bio_seq_align_consistency_point_to_string(pt : BioseqalignconsistencyPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct BioseqalignconsistencySeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn bio_seq_align_consistency_make_series(vals : Array[Double], name : String) -> BioseqalignconsistencySeries {
  { vals, name, meta: 0 }
}

pub fn bio_seq_align_consistency_series_len(s : BioseqalignconsistencySeries) -> Int { s.vals.length() }

pub fn bio_seq_align_consistency_series_sum(s : BioseqalignconsistencySeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn bio_seq_align_consistency_series_mean(s : BioseqalignconsistencySeries) -> Double {
  let n = bio_seq_align_consistency_series_len(s)
  if n == 0 { 0.0 } else { bio_seq_align_consistency_series_sum(s) / n.to_double() }
}

pub fn bio_seq_align_consistency_series_min(s : BioseqalignconsistencySeries) -> Double {
  let n = bio_seq_align_consistency_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn bio_seq_align_consistency_series_max(s : BioseqalignconsistencySeries) -> Double {
  let n = bio_seq_align_consistency_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn bio_seq_align_consistency_series_range(s : BioseqalignconsistencySeries) -> Double {
  bio_seq_align_consistency_series_max(s) - bio_seq_align_consistency_series_min(s)
}

pub fn bio_seq_align_consistency_series_var(s : BioseqalignconsistencySeries) -> Double {
  let n = bio_seq_align_consistency_series_len(s)
  if n == 0 { 0.0 } else {
    let m = bio_seq_align_consistency_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn bio_seq_align_consistency_series_std(s : BioseqalignconsistencySeries) -> Double { @_common.sqrt(bio_seq_align_consistency_series_var(s)) }

pub fn bio_seq_align_consistency_series_median(s : BioseqalignconsistencySeries) -> Double {
  let n = bio_seq_align_consistency_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = bio_seq_align_consistency_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn bio_seq_align_consistency_series_scale(s : BioseqalignconsistencySeries, f : Double) -> BioseqalignconsistencySeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn bio_seq_align_consistency_series_add(a : BioseqalignconsistencySeries, b : BioseqalignconsistencySeries) -> BioseqalignconsistencySeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn bio_seq_align_consistency_series_sub(a : BioseqalignconsistencySeries, b : BioseqalignconsistencySeries) -> BioseqalignconsistencySeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn bio_seq_align_consistency_series_normalize(s : BioseqalignconsistencySeries) -> BioseqalignconsistencySeries {
  let mn = bio_seq_align_consistency_series_min(s)
  let mx = bio_seq_align_consistency_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn bio_seq_align_consistency_series_cumsum(s : BioseqalignconsistencySeries) -> BioseqalignconsistencySeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn bio_seq_align_consistency_series_to_string(s : BioseqalignconsistencySeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BioseqalignconsistencyMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn bio_seq_align_consistency_make_matrix(rows : Int, cols : Int, val : Double) -> BioseqalignconsistencyMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn bio_seq_align_consistency_matrix_identity(n : Int) -> BioseqalignconsistencyMatrix {
  let m = bio_seq_align_consistency_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn bio_seq_align_consistency_matrix_get(m : BioseqalignconsistencyMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn bio_seq_align_consistency_matrix_transpose(m : BioseqalignconsistencyMatrix) -> BioseqalignconsistencyMatrix {
  let result = bio_seq_align_consistency_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn bio_seq_align_consistency_matrix_add(a : BioseqalignconsistencyMatrix, b : BioseqalignconsistencyMatrix) -> BioseqalignconsistencyMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = bio_seq_align_consistency_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn bio_seq_align_consistency_matrix_scale(m : BioseqalignconsistencyMatrix, s : Double) -> BioseqalignconsistencyMatrix {
  let result = bio_seq_align_consistency_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn bio_seq_align_consistency_matrix_multiply(a : BioseqalignconsistencyMatrix, b : BioseqalignconsistencyMatrix) -> BioseqalignconsistencyMatrix {
  if a.cols != b.rows { return bio_seq_align_consistency_make_matrix(a.rows, b.cols, 0.0) }
  let result = bio_seq_align_consistency_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn bio_seq_align_consistency_matrix_trace(m : BioseqalignconsistencyMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn bio_seq_align_consistency_matrix_det(m : BioseqalignconsistencyMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn bio_seq_align_consistency_matrix_norm(m : BioseqalignconsistencyMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn bio_seq_align_consistency_matrix_to_string(m : BioseqalignconsistencyMatrix) -> String {
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

pub(all) struct BioseqalignconsistencyVector {
  comps : Array[Double]
  dim : Int
}

pub fn bio_seq_align_consistency_make_vector(comps : Array[Double]) -> BioseqalignconsistencyVector {
  { comps, dim: comps.length() }
}

pub fn bio_seq_align_consistency_vector_zero(dim : Int) -> BioseqalignconsistencyVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn bio_seq_align_consistency_vector_add(a : BioseqalignconsistencyVector, b : BioseqalignconsistencyVector) -> BioseqalignconsistencyVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn bio_seq_align_consistency_vector_sub(a : BioseqalignconsistencyVector, b : BioseqalignconsistencyVector) -> BioseqalignconsistencyVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn bio_seq_align_consistency_vector_scale(v : BioseqalignconsistencyVector, s : Double) -> BioseqalignconsistencyVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn bio_seq_align_consistency_vector_dot(a : BioseqalignconsistencyVector, b : BioseqalignconsistencyVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn bio_seq_align_consistency_vector_norm(v : BioseqalignconsistencyVector) -> Double { @_common.sqrt(bio_seq_align_consistency_vector_dot(v, v)) }

pub fn bio_seq_align_consistency_vector_normalize(v : BioseqalignconsistencyVector) -> BioseqalignconsistencyVector {
  let n = bio_seq_align_consistency_vector_norm(v)
  if n < 0.0000001 { v } else { bio_seq_align_consistency_vector_scale(v, 1.0 / n) }
}

pub fn bio_seq_align_consistency_vector_dist(a : BioseqalignconsistencyVector, b : BioseqalignconsistencyVector) -> Double {
  bio_seq_align_consistency_vector_norm(bio_seq_align_consistency_vector_sub(a, b))
}

pub fn bio_seq_align_consistency_vector_to_string(v : BioseqalignconsistencyVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn bio_seq_align_consistency_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn bio_seq_align_consistency_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn bio_seq_align_consistency_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn bio_seq_align_consistency_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn bio_seq_align_consistency_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn bio_seq_align_consistency_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn bio_seq_align_consistency_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn bio_seq_align_consistency_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn bio_seq_align_consistency_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn bio_seq_align_consistency_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn bio_seq_align_consistency_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn bio_seq_align_consistency_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn bio_seq_align_consistency_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn bio_seq_align_consistency_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn bio_seq_align_consistency_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn bio_seq_align_consistency_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn bio_seq_align_consistency_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn bio_seq_align_consistency_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn bio_seq_align_consistency_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn bio_seq_align_consistency_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn bio_seq_align_consistency_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn bio_seq_align_consistency_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn bio_seq_align_consistency_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn bio_seq_align_consistency_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn bio_seq_align_consistency_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn bio_seq_align_consistency_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn bio_seq_align_consistency_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn bio_seq_align_consistency_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn bio_seq_align_consistency_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct BioseqalignconsistencyFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_consistency_frame_make(size : Int) -> BioseqalignconsistencyFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_consistency_frame_len(s : BioseqalignconsistencyFrame) -> Int { s.size }

pub fn bio_seq_align_consistency_frame_get(s : BioseqalignconsistencyFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_consistency_frame_set(s : BioseqalignconsistencyFrame, i : Int, v : Double) -> BioseqalignconsistencyFrame {
  let result = bio_seq_align_consistency_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_consistency_frame_sum(s : BioseqalignconsistencyFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_align_consistency_frame_mean(s : BioseqalignconsistencyFrame) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_align_consistency_frame_sum(s) / s.size.to_double() }
}

pub fn bio_seq_align_consistency_frame_scale(s : BioseqalignconsistencyFrame, f : Double) -> BioseqalignconsistencyFrame {
  let result = bio_seq_align_consistency_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_align_consistency_frame_add(a : BioseqalignconsistencyFrame, b : BioseqalignconsistencyFrame) -> BioseqalignconsistencyFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_align_consistency_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_align_consistency_frame_copy(s : BioseqalignconsistencyFrame) -> BioseqalignconsistencyFrame {
  let result = bio_seq_align_consistency_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_align_consistency_frame_fill(s : BioseqalignconsistencyFrame, v : Double) -> BioseqalignconsistencyFrame {
  let result = bio_seq_align_consistency_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_consistency_frame_min(s : BioseqalignconsistencyFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_consistency_frame_max(s : BioseqalignconsistencyFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_consistency_frame_to_string(s : BioseqalignconsistencyFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignconsistencyTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_consistency_table_make(size : Int) -> BioseqalignconsistencyTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_consistency_table_len(s : BioseqalignconsistencyTable) -> Int { s.size }

pub fn bio_seq_align_consistency_table_get(s : BioseqalignconsistencyTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_consistency_table_set(s : BioseqalignconsistencyTable, i : Int, v : Double) -> BioseqalignconsistencyTable {
  let result = bio_seq_align_consistency_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_consistency_table_sum(s : BioseqalignconsistencyTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_align_consistency_table_mean(s : BioseqalignconsistencyTable) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_align_consistency_table_sum(s) / s.size.to_double() }
}

pub fn bio_seq_align_consistency_table_scale(s : BioseqalignconsistencyTable, f : Double) -> BioseqalignconsistencyTable {
  let result = bio_seq_align_consistency_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_align_consistency_table_add(a : BioseqalignconsistencyTable, b : BioseqalignconsistencyTable) -> BioseqalignconsistencyTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_align_consistency_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_align_consistency_table_copy(s : BioseqalignconsistencyTable) -> BioseqalignconsistencyTable {
  let result = bio_seq_align_consistency_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_align_consistency_table_fill(s : BioseqalignconsistencyTable, v : Double) -> BioseqalignconsistencyTable {
  let result = bio_seq_align_consistency_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_consistency_table_min(s : BioseqalignconsistencyTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_consistency_table_max(s : BioseqalignconsistencyTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_consistency_table_to_string(s : BioseqalignconsistencyTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignconsistencyGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_consistency_graphn_make(size : Int) -> BioseqalignconsistencyGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_consistency_graphn_len(s : BioseqalignconsistencyGraphN) -> Int { s.size }

pub fn bio_seq_align_consistency_graphn_get(s : BioseqalignconsistencyGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_consistency_graphn_set(s : BioseqalignconsistencyGraphN, i : Int, v : Double) -> BioseqalignconsistencyGraphN {
  let result = bio_seq_align_consistency_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_consistency_graphn_sum(s : BioseqalignconsistencyGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_align_consistency_graphn_mean(s : BioseqalignconsistencyGraphN) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_align_consistency_graphn_sum(s) / s.size.to_double() }
}

pub fn bio_seq_align_consistency_graphn_scale(s : BioseqalignconsistencyGraphN, f : Double) -> BioseqalignconsistencyGraphN {
  let result = bio_seq_align_consistency_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_align_consistency_graphn_add(a : BioseqalignconsistencyGraphN, b : BioseqalignconsistencyGraphN) -> BioseqalignconsistencyGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_align_consistency_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_align_consistency_graphn_copy(s : BioseqalignconsistencyGraphN) -> BioseqalignconsistencyGraphN {
  let result = bio_seq_align_consistency_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_align_consistency_graphn_fill(s : BioseqalignconsistencyGraphN, v : Double) -> BioseqalignconsistencyGraphN {
  let result = bio_seq_align_consistency_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_consistency_graphn_min(s : BioseqalignconsistencyGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_consistency_graphn_max(s : BioseqalignconsistencyGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_consistency_graphn_to_string(s : BioseqalignconsistencyGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignconsistencyNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_consistency_node_make(size : Int) -> BioseqalignconsistencyNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_consistency_node_len(s : BioseqalignconsistencyNode) -> Int { s.size }

pub fn bio_seq_align_consistency_node_get(s : BioseqalignconsistencyNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_consistency_node_set(s : BioseqalignconsistencyNode, i : Int, v : Double) -> BioseqalignconsistencyNode {
  let result = bio_seq_align_consistency_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_consistency_node_sum(s : BioseqalignconsistencyNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_align_consistency_node_mean(s : BioseqalignconsistencyNode) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_align_consistency_node_sum(s) / s.size.to_double() }
}

pub fn bio_seq_align_consistency_node_scale(s : BioseqalignconsistencyNode, f : Double) -> BioseqalignconsistencyNode {
  let result = bio_seq_align_consistency_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_align_consistency_node_add(a : BioseqalignconsistencyNode, b : BioseqalignconsistencyNode) -> BioseqalignconsistencyNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_align_consistency_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_align_consistency_node_copy(s : BioseqalignconsistencyNode) -> BioseqalignconsistencyNode {
  let result = bio_seq_align_consistency_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_align_consistency_node_fill(s : BioseqalignconsistencyNode, v : Double) -> BioseqalignconsistencyNode {
  let result = bio_seq_align_consistency_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_consistency_node_min(s : BioseqalignconsistencyNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_consistency_node_max(s : BioseqalignconsistencyNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_consistency_node_to_string(s : BioseqalignconsistencyNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignconsistencyEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_consistency_edge_make(size : Int) -> BioseqalignconsistencyEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_consistency_edge_len(s : BioseqalignconsistencyEdge) -> Int { s.size }

pub fn bio_seq_align_consistency_edge_get(s : BioseqalignconsistencyEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_consistency_edge_set(s : BioseqalignconsistencyEdge, i : Int, v : Double) -> BioseqalignconsistencyEdge {
  let result = bio_seq_align_consistency_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_consistency_edge_sum(s : BioseqalignconsistencyEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_align_consistency_edge_mean(s : BioseqalignconsistencyEdge) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_align_consistency_edge_sum(s) / s.size.to_double() }
}

pub fn bio_seq_align_consistency_edge_scale(s : BioseqalignconsistencyEdge, f : Double) -> BioseqalignconsistencyEdge {
  let result = bio_seq_align_consistency_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_align_consistency_edge_add(a : BioseqalignconsistencyEdge, b : BioseqalignconsistencyEdge) -> BioseqalignconsistencyEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_align_consistency_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_align_consistency_edge_copy(s : BioseqalignconsistencyEdge) -> BioseqalignconsistencyEdge {
  let result = bio_seq_align_consistency_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_align_consistency_edge_fill(s : BioseqalignconsistencyEdge, v : Double) -> BioseqalignconsistencyEdge {
  let result = bio_seq_align_consistency_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_consistency_edge_min(s : BioseqalignconsistencyEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_consistency_edge_max(s : BioseqalignconsistencyEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_consistency_edge_to_string(s : BioseqalignconsistencyEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignconsistencyPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_consistency_path_make(size : Int) -> BioseqalignconsistencyPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_consistency_path_len(s : BioseqalignconsistencyPath) -> Int { s.size }

pub fn bio_seq_align_consistency_path_get(s : BioseqalignconsistencyPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_consistency_path_set(s : BioseqalignconsistencyPath, i : Int, v : Double) -> BioseqalignconsistencyPath {
  let result = bio_seq_align_consistency_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_consistency_path_sum(s : BioseqalignconsistencyPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_align_consistency_path_mean(s : BioseqalignconsistencyPath) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_align_consistency_path_sum(s) / s.size.to_double() }
}

pub fn bio_seq_align_consistency_path_scale(s : BioseqalignconsistencyPath, f : Double) -> BioseqalignconsistencyPath {
  let result = bio_seq_align_consistency_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_align_consistency_path_add(a : BioseqalignconsistencyPath, b : BioseqalignconsistencyPath) -> BioseqalignconsistencyPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_align_consistency_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_align_consistency_path_copy(s : BioseqalignconsistencyPath) -> BioseqalignconsistencyPath {
  let result = bio_seq_align_consistency_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_align_consistency_path_fill(s : BioseqalignconsistencyPath, v : Double) -> BioseqalignconsistencyPath {
  let result = bio_seq_align_consistency_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_consistency_path_min(s : BioseqalignconsistencyPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_consistency_path_max(s : BioseqalignconsistencyPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_consistency_path_to_string(s : BioseqalignconsistencyPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignconsistencyCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_consistency_cluster_make(size : Int) -> BioseqalignconsistencyCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_consistency_cluster_len(s : BioseqalignconsistencyCluster) -> Int { s.size }

pub fn bio_seq_align_consistency_cluster_get(s : BioseqalignconsistencyCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_consistency_cluster_set(s : BioseqalignconsistencyCluster, i : Int, v : Double) -> BioseqalignconsistencyCluster {
  let result = bio_seq_align_consistency_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_consistency_cluster_sum(s : BioseqalignconsistencyCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_align_consistency_cluster_mean(s : BioseqalignconsistencyCluster) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_align_consistency_cluster_sum(s) / s.size.to_double() }
}

pub fn bio_seq_align_consistency_cluster_scale(s : BioseqalignconsistencyCluster, f : Double) -> BioseqalignconsistencyCluster {
  let result = bio_seq_align_consistency_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_align_consistency_cluster_add(a : BioseqalignconsistencyCluster, b : BioseqalignconsistencyCluster) -> BioseqalignconsistencyCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_align_consistency_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_align_consistency_cluster_copy(s : BioseqalignconsistencyCluster) -> BioseqalignconsistencyCluster {
  let result = bio_seq_align_consistency_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_align_consistency_cluster_fill(s : BioseqalignconsistencyCluster, v : Double) -> BioseqalignconsistencyCluster {
  let result = bio_seq_align_consistency_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_consistency_cluster_min(s : BioseqalignconsistencyCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_consistency_cluster_max(s : BioseqalignconsistencyCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_consistency_cluster_to_string(s : BioseqalignconsistencyCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignconsistencyModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_consistency_model_make(size : Int) -> BioseqalignconsistencyModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_consistency_model_len(s : BioseqalignconsistencyModel) -> Int { s.size }

pub fn bio_seq_align_consistency_model_get(s : BioseqalignconsistencyModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_consistency_model_set(s : BioseqalignconsistencyModel, i : Int, v : Double) -> BioseqalignconsistencyModel {
  let result = bio_seq_align_consistency_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_consistency_model_sum(s : BioseqalignconsistencyModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_align_consistency_model_mean(s : BioseqalignconsistencyModel) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_align_consistency_model_sum(s) / s.size.to_double() }
}

pub fn bio_seq_align_consistency_model_scale(s : BioseqalignconsistencyModel, f : Double) -> BioseqalignconsistencyModel {
  let result = bio_seq_align_consistency_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_align_consistency_model_add(a : BioseqalignconsistencyModel, b : BioseqalignconsistencyModel) -> BioseqalignconsistencyModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_align_consistency_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_align_consistency_model_copy(s : BioseqalignconsistencyModel) -> BioseqalignconsistencyModel {
  let result = bio_seq_align_consistency_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_align_consistency_model_fill(s : BioseqalignconsistencyModel, v : Double) -> BioseqalignconsistencyModel {
  let result = bio_seq_align_consistency_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_consistency_model_min(s : BioseqalignconsistencyModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_consistency_model_max(s : BioseqalignconsistencyModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_consistency_model_to_string(s : BioseqalignconsistencyModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignconsistencyLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_consistency_layer_make(size : Int) -> BioseqalignconsistencyLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_consistency_layer_len(s : BioseqalignconsistencyLayer) -> Int { s.size }

pub fn bio_seq_align_consistency_layer_get(s : BioseqalignconsistencyLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_consistency_layer_set(s : BioseqalignconsistencyLayer, i : Int, v : Double) -> BioseqalignconsistencyLayer {
  let result = bio_seq_align_consistency_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_consistency_layer_sum(s : BioseqalignconsistencyLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_align_consistency_layer_mean(s : BioseqalignconsistencyLayer) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_align_consistency_layer_sum(s) / s.size.to_double() }
}

pub fn bio_seq_align_consistency_layer_scale(s : BioseqalignconsistencyLayer, f : Double) -> BioseqalignconsistencyLayer {
  let result = bio_seq_align_consistency_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_align_consistency_layer_add(a : BioseqalignconsistencyLayer, b : BioseqalignconsistencyLayer) -> BioseqalignconsistencyLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_align_consistency_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_align_consistency_layer_copy(s : BioseqalignconsistencyLayer) -> BioseqalignconsistencyLayer {
  let result = bio_seq_align_consistency_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_align_consistency_layer_fill(s : BioseqalignconsistencyLayer, v : Double) -> BioseqalignconsistencyLayer {
  let result = bio_seq_align_consistency_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_consistency_layer_min(s : BioseqalignconsistencyLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_consistency_layer_max(s : BioseqalignconsistencyLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_consistency_layer_to_string(s : BioseqalignconsistencyLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignconsistencyBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_consistency_buffer_make(size : Int) -> BioseqalignconsistencyBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_consistency_buffer_len(s : BioseqalignconsistencyBuffer) -> Int { s.size }

pub fn bio_seq_align_consistency_buffer_get(s : BioseqalignconsistencyBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_consistency_buffer_set(s : BioseqalignconsistencyBuffer, i : Int, v : Double) -> BioseqalignconsistencyBuffer {
  let result = bio_seq_align_consistency_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_consistency_buffer_sum(s : BioseqalignconsistencyBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_align_consistency_buffer_mean(s : BioseqalignconsistencyBuffer) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_align_consistency_buffer_sum(s) / s.size.to_double() }
}

pub fn bio_seq_align_consistency_buffer_scale(s : BioseqalignconsistencyBuffer, f : Double) -> BioseqalignconsistencyBuffer {
  let result = bio_seq_align_consistency_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_align_consistency_buffer_add(a : BioseqalignconsistencyBuffer, b : BioseqalignconsistencyBuffer) -> BioseqalignconsistencyBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_align_consistency_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_align_consistency_buffer_copy(s : BioseqalignconsistencyBuffer) -> BioseqalignconsistencyBuffer {
  let result = bio_seq_align_consistency_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_align_consistency_buffer_fill(s : BioseqalignconsistencyBuffer, v : Double) -> BioseqalignconsistencyBuffer {
  let result = bio_seq_align_consistency_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_consistency_buffer_min(s : BioseqalignconsistencyBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_consistency_buffer_max(s : BioseqalignconsistencyBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_consistency_buffer_to_string(s : BioseqalignconsistencyBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignconsistencyCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_consistency_cursor_make(size : Int) -> BioseqalignconsistencyCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_consistency_cursor_len(s : BioseqalignconsistencyCursor) -> Int { s.size }

pub fn bio_seq_align_consistency_cursor_get(s : BioseqalignconsistencyCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_consistency_cursor_set(s : BioseqalignconsistencyCursor, i : Int, v : Double) -> BioseqalignconsistencyCursor {
  let result = bio_seq_align_consistency_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_consistency_cursor_sum(s : BioseqalignconsistencyCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_align_consistency_cursor_mean(s : BioseqalignconsistencyCursor) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_align_consistency_cursor_sum(s) / s.size.to_double() }
}

pub fn bio_seq_align_consistency_cursor_scale(s : BioseqalignconsistencyCursor, f : Double) -> BioseqalignconsistencyCursor {
  let result = bio_seq_align_consistency_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_align_consistency_cursor_add(a : BioseqalignconsistencyCursor, b : BioseqalignconsistencyCursor) -> BioseqalignconsistencyCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_align_consistency_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_align_consistency_cursor_copy(s : BioseqalignconsistencyCursor) -> BioseqalignconsistencyCursor {
  let result = bio_seq_align_consistency_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_align_consistency_cursor_fill(s : BioseqalignconsistencyCursor, v : Double) -> BioseqalignconsistencyCursor {
  let result = bio_seq_align_consistency_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_consistency_cursor_min(s : BioseqalignconsistencyCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_consistency_cursor_max(s : BioseqalignconsistencyCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_consistency_cursor_to_string(s : BioseqalignconsistencyCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignconsistencyView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_consistency_view_make(size : Int) -> BioseqalignconsistencyView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_consistency_view_len(s : BioseqalignconsistencyView) -> Int { s.size }

pub fn bio_seq_align_consistency_view_get(s : BioseqalignconsistencyView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_consistency_view_set(s : BioseqalignconsistencyView, i : Int, v : Double) -> BioseqalignconsistencyView {
  let result = bio_seq_align_consistency_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_consistency_view_sum(s : BioseqalignconsistencyView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_align_consistency_view_mean(s : BioseqalignconsistencyView) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_align_consistency_view_sum(s) / s.size.to_double() }
}

pub fn bio_seq_align_consistency_view_scale(s : BioseqalignconsistencyView, f : Double) -> BioseqalignconsistencyView {
  let result = bio_seq_align_consistency_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_align_consistency_view_add(a : BioseqalignconsistencyView, b : BioseqalignconsistencyView) -> BioseqalignconsistencyView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_align_consistency_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_align_consistency_view_copy(s : BioseqalignconsistencyView) -> BioseqalignconsistencyView {
  let result = bio_seq_align_consistency_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_align_consistency_view_fill(s : BioseqalignconsistencyView, v : Double) -> BioseqalignconsistencyView {
  let result = bio_seq_align_consistency_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_consistency_view_min(s : BioseqalignconsistencyView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_consistency_view_max(s : BioseqalignconsistencyView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_consistency_view_to_string(s : BioseqalignconsistencyView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignconsistencyRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_consistency_range_make(size : Int) -> BioseqalignconsistencyRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_consistency_range_len(s : BioseqalignconsistencyRange) -> Int { s.size }

pub fn bio_seq_align_consistency_range_get(s : BioseqalignconsistencyRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_consistency_range_set(s : BioseqalignconsistencyRange, i : Int, v : Double) -> BioseqalignconsistencyRange {
  let result = bio_seq_align_consistency_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_consistency_range_sum(s : BioseqalignconsistencyRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_align_consistency_range_mean(s : BioseqalignconsistencyRange) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_align_consistency_range_sum(s) / s.size.to_double() }
}

pub fn bio_seq_align_consistency_range_scale(s : BioseqalignconsistencyRange, f : Double) -> BioseqalignconsistencyRange {
  let result = bio_seq_align_consistency_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_align_consistency_range_add(a : BioseqalignconsistencyRange, b : BioseqalignconsistencyRange) -> BioseqalignconsistencyRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_align_consistency_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_align_consistency_range_copy(s : BioseqalignconsistencyRange) -> BioseqalignconsistencyRange {
  let result = bio_seq_align_consistency_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_align_consistency_range_fill(s : BioseqalignconsistencyRange, v : Double) -> BioseqalignconsistencyRange {
  let result = bio_seq_align_consistency_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_consistency_range_min(s : BioseqalignconsistencyRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_consistency_range_max(s : BioseqalignconsistencyRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_consistency_range_to_string(s : BioseqalignconsistencyRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignconsistencySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_consistency_slice_make(size : Int) -> BioseqalignconsistencySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_consistency_slice_len(s : BioseqalignconsistencySlice) -> Int { s.size }

pub fn bio_seq_align_consistency_slice_get(s : BioseqalignconsistencySlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_consistency_slice_set(s : BioseqalignconsistencySlice, i : Int, v : Double) -> BioseqalignconsistencySlice {
  let result = bio_seq_align_consistency_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_consistency_slice_sum(s : BioseqalignconsistencySlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_align_consistency_slice_mean(s : BioseqalignconsistencySlice) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_align_consistency_slice_sum(s) / s.size.to_double() }
}

pub fn bio_seq_align_consistency_slice_scale(s : BioseqalignconsistencySlice, f : Double) -> BioseqalignconsistencySlice {
  let result = bio_seq_align_consistency_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_align_consistency_slice_add(a : BioseqalignconsistencySlice, b : BioseqalignconsistencySlice) -> BioseqalignconsistencySlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_align_consistency_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_align_consistency_slice_copy(s : BioseqalignconsistencySlice) -> BioseqalignconsistencySlice {
  let result = bio_seq_align_consistency_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_align_consistency_slice_fill(s : BioseqalignconsistencySlice, v : Double) -> BioseqalignconsistencySlice {
  let result = bio_seq_align_consistency_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_consistency_slice_min(s : BioseqalignconsistencySlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_consistency_slice_max(s : BioseqalignconsistencySlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_consistency_slice_to_string(s : BioseqalignconsistencySlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


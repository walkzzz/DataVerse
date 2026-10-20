///===
/// extcore/bio_seq_align_profile

pub(all) struct BioseqalignprofilePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn bio_seq_align_profile_make_point(x : Double, y : Double) -> BioseqalignprofilePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn bio_seq_align_profile_make_point3(x : Double, y : Double, z : Double) -> BioseqalignprofilePoint {
  { x, y, z, label: 0 }
}

pub fn bio_seq_align_profile_point_x(pt : BioseqalignprofilePoint) -> Double { pt.x }

pub fn bio_seq_align_profile_point_y(pt : BioseqalignprofilePoint) -> Double { pt.y }

pub fn bio_seq_align_profile_point_z(pt : BioseqalignprofilePoint) -> Double { pt.z }

pub fn bio_seq_align_profile_point_label(pt : BioseqalignprofilePoint) -> Int { pt.label }

pub fn bio_seq_align_profile_point_dist(a : BioseqalignprofilePoint, b : BioseqalignprofilePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn bio_seq_align_profile_point_add(a : BioseqalignprofilePoint, b : BioseqalignprofilePoint) -> BioseqalignprofilePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn bio_seq_align_profile_point_sub(a : BioseqalignprofilePoint, b : BioseqalignprofilePoint) -> BioseqalignprofilePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn bio_seq_align_profile_point_scale(pt : BioseqalignprofilePoint, s : Double) -> BioseqalignprofilePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn bio_seq_align_profile_point_dot(a : BioseqalignprofilePoint, b : BioseqalignprofilePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn bio_seq_align_profile_point_cross(a : BioseqalignprofilePoint, b : BioseqalignprofilePoint) -> BioseqalignprofilePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn bio_seq_align_profile_point_norm(pt : BioseqalignprofilePoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn bio_seq_align_profile_point_normalize(pt : BioseqalignprofilePoint) -> BioseqalignprofilePoint {
  let n = bio_seq_align_profile_point_norm(pt)
  if n < 0.0000001 { pt } else { bio_seq_align_profile_point_scale(pt, 1.0 / n) }
}

pub fn bio_seq_align_profile_point_negate(pt : BioseqalignprofilePoint) -> BioseqalignprofilePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn bio_seq_align_profile_point_mid(a : BioseqalignprofilePoint, b : BioseqalignprofilePoint) -> BioseqalignprofilePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn bio_seq_align_profile_point_lerp(a : BioseqalignprofilePoint, b : BioseqalignprofilePoint, t : Double) -> BioseqalignprofilePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn bio_seq_align_profile_point_to_string(pt : BioseqalignprofilePoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct BioseqalignprofileSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn bio_seq_align_profile_make_series(vals : Array[Double], name : String) -> BioseqalignprofileSeries {
  { vals, name, meta: 0 }
}

pub fn bio_seq_align_profile_series_len(s : BioseqalignprofileSeries) -> Int { s.vals.length() }

pub fn bio_seq_align_profile_series_sum(s : BioseqalignprofileSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn bio_seq_align_profile_series_mean(s : BioseqalignprofileSeries) -> Double { @_common.mean(s.vals) }

pub fn bio_seq_align_profile_series_min(s : BioseqalignprofileSeries) -> Double { @_common.min(s.vals) }

pub fn bio_seq_align_profile_series_max(s : BioseqalignprofileSeries) -> Double { @_common.max(s.vals) }

pub fn bio_seq_align_profile_series_range(s : BioseqalignprofileSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn bio_seq_align_profile_series_var(s : BioseqalignprofileSeries) -> Double { @_common.variance(s.vals) }

pub fn bio_seq_align_profile_series_std(s : BioseqalignprofileSeries) -> Double { @_common.std(s.vals) }

pub fn bio_seq_align_profile_series_median(s : BioseqalignprofileSeries) -> Double { @_common.median(s.vals) }

pub fn bio_seq_align_profile_series_scale(s : BioseqalignprofileSeries, f : Double) -> BioseqalignprofileSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn bio_seq_align_profile_series_add(a : BioseqalignprofileSeries, b : BioseqalignprofileSeries) -> BioseqalignprofileSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn bio_seq_align_profile_series_sub(a : BioseqalignprofileSeries, b : BioseqalignprofileSeries) -> BioseqalignprofileSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn bio_seq_align_profile_series_normalize(s : BioseqalignprofileSeries) -> BioseqalignprofileSeries {
  let mn = bio_seq_align_profile_series_min(s)
  let mx = bio_seq_align_profile_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn bio_seq_align_profile_series_cumsum(s : BioseqalignprofileSeries) -> BioseqalignprofileSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn bio_seq_align_profile_series_to_string(s : BioseqalignprofileSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BioseqalignprofileMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn bio_seq_align_profile_make_matrix(rows : Int, cols : Int, val : Double) -> BioseqalignprofileMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn bio_seq_align_profile_matrix_identity(n : Int) -> BioseqalignprofileMatrix {
  let m = bio_seq_align_profile_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn bio_seq_align_profile_matrix_get(m : BioseqalignprofileMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn bio_seq_align_profile_matrix_transpose(m : BioseqalignprofileMatrix) -> BioseqalignprofileMatrix {
  let result = bio_seq_align_profile_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn bio_seq_align_profile_matrix_add(a : BioseqalignprofileMatrix, b : BioseqalignprofileMatrix) -> BioseqalignprofileMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = bio_seq_align_profile_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn bio_seq_align_profile_matrix_scale(m : BioseqalignprofileMatrix, s : Double) -> BioseqalignprofileMatrix {
  let result = bio_seq_align_profile_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn bio_seq_align_profile_matrix_multiply(a : BioseqalignprofileMatrix, b : BioseqalignprofileMatrix) -> BioseqalignprofileMatrix {
  if a.cols != b.rows { return bio_seq_align_profile_make_matrix(a.rows, b.cols, 0.0) }
  let result = bio_seq_align_profile_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn bio_seq_align_profile_matrix_trace(m : BioseqalignprofileMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn bio_seq_align_profile_matrix_det(m : BioseqalignprofileMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn bio_seq_align_profile_matrix_norm(m : BioseqalignprofileMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn bio_seq_align_profile_matrix_to_string(m : BioseqalignprofileMatrix) -> String {
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

pub(all) struct BioseqalignprofileVector {
  comps : Array[Double]
  dim : Int
}

pub fn bio_seq_align_profile_make_vector(comps : Array[Double]) -> BioseqalignprofileVector {
  { comps, dim: comps.length() }
}

pub fn bio_seq_align_profile_vector_zero(dim : Int) -> BioseqalignprofileVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn bio_seq_align_profile_vector_add(a : BioseqalignprofileVector, b : BioseqalignprofileVector) -> BioseqalignprofileVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn bio_seq_align_profile_vector_sub(a : BioseqalignprofileVector, b : BioseqalignprofileVector) -> BioseqalignprofileVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn bio_seq_align_profile_vector_scale(v : BioseqalignprofileVector, s : Double) -> BioseqalignprofileVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn bio_seq_align_profile_vector_dot(a : BioseqalignprofileVector, b : BioseqalignprofileVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn bio_seq_align_profile_vector_norm(v : BioseqalignprofileVector) -> Double { @_common.sqrt(bio_seq_align_profile_vector_dot(v, v)) }

pub fn bio_seq_align_profile_vector_normalize(v : BioseqalignprofileVector) -> BioseqalignprofileVector {
  let n = bio_seq_align_profile_vector_norm(v)
  if n < 0.0000001 { v } else { bio_seq_align_profile_vector_scale(v, 1.0 / n) }
}

pub fn bio_seq_align_profile_vector_dist(a : BioseqalignprofileVector, b : BioseqalignprofileVector) -> Double {
  bio_seq_align_profile_vector_norm(bio_seq_align_profile_vector_sub(a, b))
}

pub fn bio_seq_align_profile_vector_to_string(v : BioseqalignprofileVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn bio_seq_align_profile_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn bio_seq_align_profile_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn bio_seq_align_profile_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn bio_seq_align_profile_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn bio_seq_align_profile_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn bio_seq_align_profile_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn bio_seq_align_profile_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn bio_seq_align_profile_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn bio_seq_align_profile_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn bio_seq_align_profile_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn bio_seq_align_profile_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn bio_seq_align_profile_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn bio_seq_align_profile_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn bio_seq_align_profile_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn bio_seq_align_profile_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn bio_seq_align_profile_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn bio_seq_align_profile_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn bio_seq_align_profile_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn bio_seq_align_profile_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn bio_seq_align_profile_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn bio_seq_align_profile_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn bio_seq_align_profile_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn bio_seq_align_profile_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn bio_seq_align_profile_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn bio_seq_align_profile_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn bio_seq_align_profile_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn bio_seq_align_profile_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn bio_seq_align_profile_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn bio_seq_align_profile_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct BioseqalignprofileFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_profile_frame_make(size : Int) -> BioseqalignprofileFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_profile_frame_len(s : BioseqalignprofileFrame) -> Int { s.size }

pub fn bio_seq_align_profile_frame_get(s : BioseqalignprofileFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_profile_frame_set(s : BioseqalignprofileFrame, i : Int, v : Double) -> BioseqalignprofileFrame {
  let result = bio_seq_align_profile_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_profile_frame_sum(s : BioseqalignprofileFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_align_profile_frame_mean(s : BioseqalignprofileFrame) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_align_profile_frame_sum(s) / s.size.to_double() }
}

pub fn bio_seq_align_profile_frame_scale(s : BioseqalignprofileFrame, f : Double) -> BioseqalignprofileFrame {
  let result = bio_seq_align_profile_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_align_profile_frame_add(a : BioseqalignprofileFrame, b : BioseqalignprofileFrame) -> BioseqalignprofileFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_align_profile_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_align_profile_frame_copy(s : BioseqalignprofileFrame) -> BioseqalignprofileFrame {
  let result = bio_seq_align_profile_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_align_profile_frame_fill(s : BioseqalignprofileFrame, v : Double) -> BioseqalignprofileFrame {
  let result = bio_seq_align_profile_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_profile_frame_min(s : BioseqalignprofileFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_profile_frame_max(s : BioseqalignprofileFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_profile_frame_to_string(s : BioseqalignprofileFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignprofileTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_profile_table_make(size : Int) -> BioseqalignprofileTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_profile_table_len(s : BioseqalignprofileTable) -> Int { s.size }

pub fn bio_seq_align_profile_table_get(s : BioseqalignprofileTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_profile_table_set(s : BioseqalignprofileTable, i : Int, v : Double) -> BioseqalignprofileTable {
  let result = bio_seq_align_profile_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_profile_table_sum(s : BioseqalignprofileTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_align_profile_table_mean(s : BioseqalignprofileTable) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_align_profile_table_sum(s) / s.size.to_double() }
}

pub fn bio_seq_align_profile_table_scale(s : BioseqalignprofileTable, f : Double) -> BioseqalignprofileTable {
  let result = bio_seq_align_profile_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_align_profile_table_add(a : BioseqalignprofileTable, b : BioseqalignprofileTable) -> BioseqalignprofileTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_align_profile_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_align_profile_table_copy(s : BioseqalignprofileTable) -> BioseqalignprofileTable {
  let result = bio_seq_align_profile_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_align_profile_table_fill(s : BioseqalignprofileTable, v : Double) -> BioseqalignprofileTable {
  let result = bio_seq_align_profile_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_profile_table_min(s : BioseqalignprofileTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_profile_table_max(s : BioseqalignprofileTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_profile_table_to_string(s : BioseqalignprofileTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignprofileGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_profile_graphn_make(size : Int) -> BioseqalignprofileGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_profile_graphn_len(s : BioseqalignprofileGraphN) -> Int { s.size }

pub fn bio_seq_align_profile_graphn_get(s : BioseqalignprofileGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_profile_graphn_set(s : BioseqalignprofileGraphN, i : Int, v : Double) -> BioseqalignprofileGraphN {
  let result = bio_seq_align_profile_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_profile_graphn_sum(s : BioseqalignprofileGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_align_profile_graphn_mean(s : BioseqalignprofileGraphN) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_align_profile_graphn_sum(s) / s.size.to_double() }
}

pub fn bio_seq_align_profile_graphn_scale(s : BioseqalignprofileGraphN, f : Double) -> BioseqalignprofileGraphN {
  let result = bio_seq_align_profile_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_align_profile_graphn_add(a : BioseqalignprofileGraphN, b : BioseqalignprofileGraphN) -> BioseqalignprofileGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_align_profile_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_align_profile_graphn_copy(s : BioseqalignprofileGraphN) -> BioseqalignprofileGraphN {
  let result = bio_seq_align_profile_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_align_profile_graphn_fill(s : BioseqalignprofileGraphN, v : Double) -> BioseqalignprofileGraphN {
  let result = bio_seq_align_profile_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_profile_graphn_min(s : BioseqalignprofileGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_profile_graphn_max(s : BioseqalignprofileGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_profile_graphn_to_string(s : BioseqalignprofileGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignprofileNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_profile_node_make(size : Int) -> BioseqalignprofileNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_profile_node_len(s : BioseqalignprofileNode) -> Int { s.size }

pub fn bio_seq_align_profile_node_get(s : BioseqalignprofileNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_profile_node_set(s : BioseqalignprofileNode, i : Int, v : Double) -> BioseqalignprofileNode {
  let result = bio_seq_align_profile_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_profile_node_sum(s : BioseqalignprofileNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_align_profile_node_mean(s : BioseqalignprofileNode) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_align_profile_node_sum(s) / s.size.to_double() }
}

pub fn bio_seq_align_profile_node_scale(s : BioseqalignprofileNode, f : Double) -> BioseqalignprofileNode {
  let result = bio_seq_align_profile_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_align_profile_node_add(a : BioseqalignprofileNode, b : BioseqalignprofileNode) -> BioseqalignprofileNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_align_profile_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_align_profile_node_copy(s : BioseqalignprofileNode) -> BioseqalignprofileNode {
  let result = bio_seq_align_profile_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_align_profile_node_fill(s : BioseqalignprofileNode, v : Double) -> BioseqalignprofileNode {
  let result = bio_seq_align_profile_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_profile_node_min(s : BioseqalignprofileNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_profile_node_max(s : BioseqalignprofileNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_profile_node_to_string(s : BioseqalignprofileNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignprofileEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_profile_edge_make(size : Int) -> BioseqalignprofileEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_profile_edge_len(s : BioseqalignprofileEdge) -> Int { s.size }

pub fn bio_seq_align_profile_edge_get(s : BioseqalignprofileEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_profile_edge_set(s : BioseqalignprofileEdge, i : Int, v : Double) -> BioseqalignprofileEdge {
  let result = bio_seq_align_profile_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_profile_edge_sum(s : BioseqalignprofileEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_align_profile_edge_mean(s : BioseqalignprofileEdge) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_align_profile_edge_sum(s) / s.size.to_double() }
}

pub fn bio_seq_align_profile_edge_scale(s : BioseqalignprofileEdge, f : Double) -> BioseqalignprofileEdge {
  let result = bio_seq_align_profile_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_align_profile_edge_add(a : BioseqalignprofileEdge, b : BioseqalignprofileEdge) -> BioseqalignprofileEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_align_profile_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_align_profile_edge_copy(s : BioseqalignprofileEdge) -> BioseqalignprofileEdge {
  let result = bio_seq_align_profile_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_align_profile_edge_fill(s : BioseqalignprofileEdge, v : Double) -> BioseqalignprofileEdge {
  let result = bio_seq_align_profile_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_profile_edge_min(s : BioseqalignprofileEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_profile_edge_max(s : BioseqalignprofileEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_profile_edge_to_string(s : BioseqalignprofileEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignprofilePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_profile_path_make(size : Int) -> BioseqalignprofilePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_profile_path_len(s : BioseqalignprofilePath) -> Int { s.size }

pub fn bio_seq_align_profile_path_get(s : BioseqalignprofilePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_profile_path_set(s : BioseqalignprofilePath, i : Int, v : Double) -> BioseqalignprofilePath {
  let result = bio_seq_align_profile_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_profile_path_sum(s : BioseqalignprofilePath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_align_profile_path_mean(s : BioseqalignprofilePath) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_align_profile_path_sum(s) / s.size.to_double() }
}

pub fn bio_seq_align_profile_path_scale(s : BioseqalignprofilePath, f : Double) -> BioseqalignprofilePath {
  let result = bio_seq_align_profile_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_align_profile_path_add(a : BioseqalignprofilePath, b : BioseqalignprofilePath) -> BioseqalignprofilePath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_align_profile_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_align_profile_path_copy(s : BioseqalignprofilePath) -> BioseqalignprofilePath {
  let result = bio_seq_align_profile_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_align_profile_path_fill(s : BioseqalignprofilePath, v : Double) -> BioseqalignprofilePath {
  let result = bio_seq_align_profile_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_profile_path_min(s : BioseqalignprofilePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_profile_path_max(s : BioseqalignprofilePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_profile_path_to_string(s : BioseqalignprofilePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignprofileCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_profile_cluster_make(size : Int) -> BioseqalignprofileCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_profile_cluster_len(s : BioseqalignprofileCluster) -> Int { s.size }

pub fn bio_seq_align_profile_cluster_get(s : BioseqalignprofileCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_profile_cluster_set(s : BioseqalignprofileCluster, i : Int, v : Double) -> BioseqalignprofileCluster {
  let result = bio_seq_align_profile_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_profile_cluster_sum(s : BioseqalignprofileCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_align_profile_cluster_mean(s : BioseqalignprofileCluster) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_align_profile_cluster_sum(s) / s.size.to_double() }
}

pub fn bio_seq_align_profile_cluster_scale(s : BioseqalignprofileCluster, f : Double) -> BioseqalignprofileCluster {
  let result = bio_seq_align_profile_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_align_profile_cluster_add(a : BioseqalignprofileCluster, b : BioseqalignprofileCluster) -> BioseqalignprofileCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_align_profile_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_align_profile_cluster_copy(s : BioseqalignprofileCluster) -> BioseqalignprofileCluster {
  let result = bio_seq_align_profile_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_align_profile_cluster_fill(s : BioseqalignprofileCluster, v : Double) -> BioseqalignprofileCluster {
  let result = bio_seq_align_profile_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_profile_cluster_min(s : BioseqalignprofileCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_profile_cluster_max(s : BioseqalignprofileCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_profile_cluster_to_string(s : BioseqalignprofileCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignprofileModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_profile_model_make(size : Int) -> BioseqalignprofileModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_profile_model_len(s : BioseqalignprofileModel) -> Int { s.size }

pub fn bio_seq_align_profile_model_get(s : BioseqalignprofileModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_profile_model_set(s : BioseqalignprofileModel, i : Int, v : Double) -> BioseqalignprofileModel {
  let result = bio_seq_align_profile_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_profile_model_sum(s : BioseqalignprofileModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_align_profile_model_mean(s : BioseqalignprofileModel) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_align_profile_model_sum(s) / s.size.to_double() }
}

pub fn bio_seq_align_profile_model_scale(s : BioseqalignprofileModel, f : Double) -> BioseqalignprofileModel {
  let result = bio_seq_align_profile_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_align_profile_model_add(a : BioseqalignprofileModel, b : BioseqalignprofileModel) -> BioseqalignprofileModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_align_profile_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_align_profile_model_copy(s : BioseqalignprofileModel) -> BioseqalignprofileModel {
  let result = bio_seq_align_profile_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_align_profile_model_fill(s : BioseqalignprofileModel, v : Double) -> BioseqalignprofileModel {
  let result = bio_seq_align_profile_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_profile_model_min(s : BioseqalignprofileModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_profile_model_max(s : BioseqalignprofileModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_profile_model_to_string(s : BioseqalignprofileModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignprofileLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_profile_layer_make(size : Int) -> BioseqalignprofileLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_profile_layer_len(s : BioseqalignprofileLayer) -> Int { s.size }

pub fn bio_seq_align_profile_layer_get(s : BioseqalignprofileLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_profile_layer_set(s : BioseqalignprofileLayer, i : Int, v : Double) -> BioseqalignprofileLayer {
  let result = bio_seq_align_profile_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_profile_layer_sum(s : BioseqalignprofileLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_align_profile_layer_mean(s : BioseqalignprofileLayer) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_align_profile_layer_sum(s) / s.size.to_double() }
}

pub fn bio_seq_align_profile_layer_scale(s : BioseqalignprofileLayer, f : Double) -> BioseqalignprofileLayer {
  let result = bio_seq_align_profile_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_align_profile_layer_add(a : BioseqalignprofileLayer, b : BioseqalignprofileLayer) -> BioseqalignprofileLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_align_profile_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_align_profile_layer_copy(s : BioseqalignprofileLayer) -> BioseqalignprofileLayer {
  let result = bio_seq_align_profile_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_align_profile_layer_fill(s : BioseqalignprofileLayer, v : Double) -> BioseqalignprofileLayer {
  let result = bio_seq_align_profile_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_profile_layer_min(s : BioseqalignprofileLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_profile_layer_max(s : BioseqalignprofileLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_profile_layer_to_string(s : BioseqalignprofileLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignprofileBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_profile_buffer_make(size : Int) -> BioseqalignprofileBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_profile_buffer_len(s : BioseqalignprofileBuffer) -> Int { s.size }

pub fn bio_seq_align_profile_buffer_get(s : BioseqalignprofileBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_profile_buffer_set(s : BioseqalignprofileBuffer, i : Int, v : Double) -> BioseqalignprofileBuffer {
  let result = bio_seq_align_profile_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_profile_buffer_sum(s : BioseqalignprofileBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_align_profile_buffer_mean(s : BioseqalignprofileBuffer) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_align_profile_buffer_sum(s) / s.size.to_double() }
}

pub fn bio_seq_align_profile_buffer_scale(s : BioseqalignprofileBuffer, f : Double) -> BioseqalignprofileBuffer {
  let result = bio_seq_align_profile_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_align_profile_buffer_add(a : BioseqalignprofileBuffer, b : BioseqalignprofileBuffer) -> BioseqalignprofileBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_align_profile_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_align_profile_buffer_copy(s : BioseqalignprofileBuffer) -> BioseqalignprofileBuffer {
  let result = bio_seq_align_profile_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_align_profile_buffer_fill(s : BioseqalignprofileBuffer, v : Double) -> BioseqalignprofileBuffer {
  let result = bio_seq_align_profile_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_profile_buffer_min(s : BioseqalignprofileBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_profile_buffer_max(s : BioseqalignprofileBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_profile_buffer_to_string(s : BioseqalignprofileBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignprofileCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_profile_cursor_make(size : Int) -> BioseqalignprofileCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_profile_cursor_len(s : BioseqalignprofileCursor) -> Int { s.size }

pub fn bio_seq_align_profile_cursor_get(s : BioseqalignprofileCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_profile_cursor_set(s : BioseqalignprofileCursor, i : Int, v : Double) -> BioseqalignprofileCursor {
  let result = bio_seq_align_profile_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_profile_cursor_sum(s : BioseqalignprofileCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_align_profile_cursor_mean(s : BioseqalignprofileCursor) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_align_profile_cursor_sum(s) / s.size.to_double() }
}

pub fn bio_seq_align_profile_cursor_scale(s : BioseqalignprofileCursor, f : Double) -> BioseqalignprofileCursor {
  let result = bio_seq_align_profile_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_align_profile_cursor_add(a : BioseqalignprofileCursor, b : BioseqalignprofileCursor) -> BioseqalignprofileCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_align_profile_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_align_profile_cursor_copy(s : BioseqalignprofileCursor) -> BioseqalignprofileCursor {
  let result = bio_seq_align_profile_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_align_profile_cursor_fill(s : BioseqalignprofileCursor, v : Double) -> BioseqalignprofileCursor {
  let result = bio_seq_align_profile_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_profile_cursor_min(s : BioseqalignprofileCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_profile_cursor_max(s : BioseqalignprofileCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_profile_cursor_to_string(s : BioseqalignprofileCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignprofileView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_profile_view_make(size : Int) -> BioseqalignprofileView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_profile_view_len(s : BioseqalignprofileView) -> Int { s.size }

pub fn bio_seq_align_profile_view_get(s : BioseqalignprofileView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_profile_view_set(s : BioseqalignprofileView, i : Int, v : Double) -> BioseqalignprofileView {
  let result = bio_seq_align_profile_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_profile_view_sum(s : BioseqalignprofileView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_align_profile_view_mean(s : BioseqalignprofileView) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_align_profile_view_sum(s) / s.size.to_double() }
}

pub fn bio_seq_align_profile_view_scale(s : BioseqalignprofileView, f : Double) -> BioseqalignprofileView {
  let result = bio_seq_align_profile_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_align_profile_view_add(a : BioseqalignprofileView, b : BioseqalignprofileView) -> BioseqalignprofileView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_align_profile_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_align_profile_view_copy(s : BioseqalignprofileView) -> BioseqalignprofileView {
  let result = bio_seq_align_profile_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_align_profile_view_fill(s : BioseqalignprofileView, v : Double) -> BioseqalignprofileView {
  let result = bio_seq_align_profile_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_profile_view_min(s : BioseqalignprofileView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_profile_view_max(s : BioseqalignprofileView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_profile_view_to_string(s : BioseqalignprofileView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignprofileRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_profile_range_make(size : Int) -> BioseqalignprofileRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_profile_range_len(s : BioseqalignprofileRange) -> Int { s.size }

pub fn bio_seq_align_profile_range_get(s : BioseqalignprofileRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_profile_range_set(s : BioseqalignprofileRange, i : Int, v : Double) -> BioseqalignprofileRange {
  let result = bio_seq_align_profile_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_profile_range_sum(s : BioseqalignprofileRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_align_profile_range_mean(s : BioseqalignprofileRange) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_align_profile_range_sum(s) / s.size.to_double() }
}

pub fn bio_seq_align_profile_range_scale(s : BioseqalignprofileRange, f : Double) -> BioseqalignprofileRange {
  let result = bio_seq_align_profile_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_align_profile_range_add(a : BioseqalignprofileRange, b : BioseqalignprofileRange) -> BioseqalignprofileRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_align_profile_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_align_profile_range_copy(s : BioseqalignprofileRange) -> BioseqalignprofileRange {
  let result = bio_seq_align_profile_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_align_profile_range_fill(s : BioseqalignprofileRange, v : Double) -> BioseqalignprofileRange {
  let result = bio_seq_align_profile_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_profile_range_min(s : BioseqalignprofileRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_profile_range_max(s : BioseqalignprofileRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_profile_range_to_string(s : BioseqalignprofileRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignprofileSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_profile_slice_make(size : Int) -> BioseqalignprofileSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_profile_slice_len(s : BioseqalignprofileSlice) -> Int { s.size }

pub fn bio_seq_align_profile_slice_get(s : BioseqalignprofileSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_profile_slice_set(s : BioseqalignprofileSlice, i : Int, v : Double) -> BioseqalignprofileSlice {
  let result = bio_seq_align_profile_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_profile_slice_sum(s : BioseqalignprofileSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_align_profile_slice_mean(s : BioseqalignprofileSlice) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_align_profile_slice_sum(s) / s.size.to_double() }
}

pub fn bio_seq_align_profile_slice_scale(s : BioseqalignprofileSlice, f : Double) -> BioseqalignprofileSlice {
  let result = bio_seq_align_profile_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_align_profile_slice_add(a : BioseqalignprofileSlice, b : BioseqalignprofileSlice) -> BioseqalignprofileSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_align_profile_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_align_profile_slice_copy(s : BioseqalignprofileSlice) -> BioseqalignprofileSlice {
  let result = bio_seq_align_profile_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_align_profile_slice_fill(s : BioseqalignprofileSlice, v : Double) -> BioseqalignprofileSlice {
  let result = bio_seq_align_profile_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_profile_slice_min(s : BioseqalignprofileSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_profile_slice_max(s : BioseqalignprofileSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_profile_slice_to_string(s : BioseqalignprofileSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


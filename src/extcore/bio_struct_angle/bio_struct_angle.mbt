///===
/// extcore/bio_struct_angle

pub(all) struct BiostructanglePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn bio_struct_angle_make_point(x : Double, y : Double) -> BiostructanglePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn bio_struct_angle_make_point3(x : Double, y : Double, z : Double) -> BiostructanglePoint {
  { x, y, z, label: 0 }
}

pub fn bio_struct_angle_point_x(pt : BiostructanglePoint) -> Double { pt.x }

pub fn bio_struct_angle_point_y(pt : BiostructanglePoint) -> Double { pt.y }

pub fn bio_struct_angle_point_z(pt : BiostructanglePoint) -> Double { pt.z }

pub fn bio_struct_angle_point_label(pt : BiostructanglePoint) -> Int { pt.label }

pub fn bio_struct_angle_point_dist(a : BiostructanglePoint, b : BiostructanglePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn bio_struct_angle_point_add(a : BiostructanglePoint, b : BiostructanglePoint) -> BiostructanglePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn bio_struct_angle_point_sub(a : BiostructanglePoint, b : BiostructanglePoint) -> BiostructanglePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn bio_struct_angle_point_scale(pt : BiostructanglePoint, s : Double) -> BiostructanglePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn bio_struct_angle_point_dot(a : BiostructanglePoint, b : BiostructanglePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn bio_struct_angle_point_cross(a : BiostructanglePoint, b : BiostructanglePoint) -> BiostructanglePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn bio_struct_angle_point_norm(pt : BiostructanglePoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn bio_struct_angle_point_normalize(pt : BiostructanglePoint) -> BiostructanglePoint {
  let n = bio_struct_angle_point_norm(pt)
  if n < 0.0000001 { pt } else { bio_struct_angle_point_scale(pt, 1.0 / n) }
}

pub fn bio_struct_angle_point_negate(pt : BiostructanglePoint) -> BiostructanglePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn bio_struct_angle_point_mid(a : BiostructanglePoint, b : BiostructanglePoint) -> BiostructanglePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn bio_struct_angle_point_lerp(a : BiostructanglePoint, b : BiostructanglePoint, t : Double) -> BiostructanglePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn bio_struct_angle_point_to_string(pt : BiostructanglePoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct BiostructangleSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn bio_struct_angle_make_series(vals : Array[Double], name : String) -> BiostructangleSeries {
  { vals, name, meta: 0 }
}

pub fn bio_struct_angle_series_len(s : BiostructangleSeries) -> Int { s.vals.length() }

pub fn bio_struct_angle_series_sum(s : BiostructangleSeries) -> Double { @_common.sum(s.vals) }

pub fn bio_struct_angle_series_mean(s : BiostructangleSeries) -> Double { @_common.mean(s.vals) }

pub fn bio_struct_angle_series_min(s : BiostructangleSeries) -> Double { @_common.min(s.vals) }

pub fn bio_struct_angle_series_max(s : BiostructangleSeries) -> Double { @_common.max(s.vals) }

pub fn bio_struct_angle_series_range(s : BiostructangleSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn bio_struct_angle_series_var(s : BiostructangleSeries) -> Double { @_common.variance(s.vals) }

pub fn bio_struct_angle_series_std(s : BiostructangleSeries) -> Double { @_common.std(s.vals) }

pub fn bio_struct_angle_series_median(s : BiostructangleSeries) -> Double { @_common.median(s.vals) }

pub fn bio_struct_angle_series_scale(s : BiostructangleSeries, f : Double) -> BiostructangleSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn bio_struct_angle_series_add(a : BiostructangleSeries, b : BiostructangleSeries) -> BiostructangleSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn bio_struct_angle_series_sub(a : BiostructangleSeries, b : BiostructangleSeries) -> BiostructangleSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn bio_struct_angle_series_normalize(s : BiostructangleSeries) -> BiostructangleSeries {
  let mn = bio_struct_angle_series_min(s)
  let mx = bio_struct_angle_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn bio_struct_angle_series_cumsum(s : BiostructangleSeries) -> BiostructangleSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn bio_struct_angle_series_to_string(s : BiostructangleSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BiostructangleMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn bio_struct_angle_make_matrix(rows : Int, cols : Int, val : Double) -> BiostructangleMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn bio_struct_angle_matrix_identity(n : Int) -> BiostructangleMatrix {
  let m = bio_struct_angle_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn bio_struct_angle_matrix_get(m : BiostructangleMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn bio_struct_angle_matrix_transpose(m : BiostructangleMatrix) -> BiostructangleMatrix {
  let result = bio_struct_angle_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn bio_struct_angle_matrix_add(a : BiostructangleMatrix, b : BiostructangleMatrix) -> BiostructangleMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = bio_struct_angle_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn bio_struct_angle_matrix_scale(m : BiostructangleMatrix, s : Double) -> BiostructangleMatrix {
  let result = bio_struct_angle_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn bio_struct_angle_matrix_multiply(a : BiostructangleMatrix, b : BiostructangleMatrix) -> BiostructangleMatrix {
  if a.cols != b.rows { return bio_struct_angle_make_matrix(a.rows, b.cols, 0.0) }
  let result = bio_struct_angle_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn bio_struct_angle_matrix_trace(m : BiostructangleMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn bio_struct_angle_matrix_det(m : BiostructangleMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn bio_struct_angle_matrix_norm(m : BiostructangleMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn bio_struct_angle_matrix_to_string(m : BiostructangleMatrix) -> String {
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

pub(all) struct BiostructangleVector {
  comps : Array[Double]
  dim : Int
}

pub fn bio_struct_angle_make_vector(comps : Array[Double]) -> BiostructangleVector {
  { comps, dim: comps.length() }
}

pub fn bio_struct_angle_vector_zero(dim : Int) -> BiostructangleVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn bio_struct_angle_vector_add(a : BiostructangleVector, b : BiostructangleVector) -> BiostructangleVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn bio_struct_angle_vector_sub(a : BiostructangleVector, b : BiostructangleVector) -> BiostructangleVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn bio_struct_angle_vector_scale(v : BiostructangleVector, s : Double) -> BiostructangleVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn bio_struct_angle_vector_dot(a : BiostructangleVector, b : BiostructangleVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn bio_struct_angle_vector_norm(v : BiostructangleVector) -> Double { @_common.sqrt(bio_struct_angle_vector_dot(v, v)) }

pub fn bio_struct_angle_vector_normalize(v : BiostructangleVector) -> BiostructangleVector {
  let n = bio_struct_angle_vector_norm(v)
  if n < 0.0000001 { v } else { bio_struct_angle_vector_scale(v, 1.0 / n) }
}

pub fn bio_struct_angle_vector_dist(a : BiostructangleVector, b : BiostructangleVector) -> Double {
  bio_struct_angle_vector_norm(bio_struct_angle_vector_sub(a, b))
}

pub fn bio_struct_angle_vector_to_string(v : BiostructangleVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn bio_struct_angle_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn bio_struct_angle_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn bio_struct_angle_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn bio_struct_angle_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn bio_struct_angle_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn bio_struct_angle_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn bio_struct_angle_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn bio_struct_angle_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn bio_struct_angle_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn bio_struct_angle_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn bio_struct_angle_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn bio_struct_angle_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn bio_struct_angle_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn bio_struct_angle_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn bio_struct_angle_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn bio_struct_angle_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn bio_struct_angle_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn bio_struct_angle_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn bio_struct_angle_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn bio_struct_angle_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn bio_struct_angle_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn bio_struct_angle_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn bio_struct_angle_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn bio_struct_angle_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn bio_struct_angle_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn bio_struct_angle_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn bio_struct_angle_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn bio_struct_angle_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn bio_struct_angle_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct BiostructangleFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_angle_frame_make(size : Int) -> BiostructangleFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_angle_frame_len(s : BiostructangleFrame) -> Int { s.size }

pub fn bio_struct_angle_frame_get(s : BiostructangleFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_angle_frame_set(s : BiostructangleFrame, i : Int, v : Double) -> BiostructangleFrame {
  let result = bio_struct_angle_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_angle_frame_sum(s : BiostructangleFrame) -> Double { @_common.sum(s.data) }

pub fn bio_struct_angle_frame_mean(s : BiostructangleFrame) -> Double { @_common.mean(s.data) }

pub fn bio_struct_angle_frame_scale(s : BiostructangleFrame, f : Double) -> BiostructangleFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_angle_frame_add(a : BiostructangleFrame, b : BiostructangleFrame) -> BiostructangleFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_angle_frame_copy(s : BiostructangleFrame) -> BiostructangleFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_angle_frame_fill(s : BiostructangleFrame, v : Double) -> BiostructangleFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_angle_frame_min(s : BiostructangleFrame) -> Double { @_common.min(s.data) }

pub fn bio_struct_angle_frame_max(s : BiostructangleFrame) -> Double { @_common.max(s.data) }

pub fn bio_struct_angle_frame_to_string(s : BiostructangleFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructangleTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_angle_table_make(size : Int) -> BiostructangleTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_angle_table_len(s : BiostructangleTable) -> Int { s.size }

pub fn bio_struct_angle_table_get(s : BiostructangleTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_angle_table_set(s : BiostructangleTable, i : Int, v : Double) -> BiostructangleTable {
  let result = bio_struct_angle_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_angle_table_sum(s : BiostructangleTable) -> Double { @_common.sum(s.data) }

pub fn bio_struct_angle_table_mean(s : BiostructangleTable) -> Double { @_common.mean(s.data) }

pub fn bio_struct_angle_table_scale(s : BiostructangleTable, f : Double) -> BiostructangleTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_angle_table_add(a : BiostructangleTable, b : BiostructangleTable) -> BiostructangleTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_angle_table_copy(s : BiostructangleTable) -> BiostructangleTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_angle_table_fill(s : BiostructangleTable, v : Double) -> BiostructangleTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_angle_table_min(s : BiostructangleTable) -> Double { @_common.min(s.data) }

pub fn bio_struct_angle_table_max(s : BiostructangleTable) -> Double { @_common.max(s.data) }

pub fn bio_struct_angle_table_to_string(s : BiostructangleTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructangleGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_angle_graphn_make(size : Int) -> BiostructangleGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_angle_graphn_len(s : BiostructangleGraphN) -> Int { s.size }

pub fn bio_struct_angle_graphn_get(s : BiostructangleGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_angle_graphn_set(s : BiostructangleGraphN, i : Int, v : Double) -> BiostructangleGraphN {
  let result = bio_struct_angle_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_angle_graphn_sum(s : BiostructangleGraphN) -> Double { @_common.sum(s.data) }

pub fn bio_struct_angle_graphn_mean(s : BiostructangleGraphN) -> Double { @_common.mean(s.data) }

pub fn bio_struct_angle_graphn_scale(s : BiostructangleGraphN, f : Double) -> BiostructangleGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_angle_graphn_add(a : BiostructangleGraphN, b : BiostructangleGraphN) -> BiostructangleGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_angle_graphn_copy(s : BiostructangleGraphN) -> BiostructangleGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_angle_graphn_fill(s : BiostructangleGraphN, v : Double) -> BiostructangleGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_angle_graphn_min(s : BiostructangleGraphN) -> Double { @_common.min(s.data) }

pub fn bio_struct_angle_graphn_max(s : BiostructangleGraphN) -> Double { @_common.max(s.data) }

pub fn bio_struct_angle_graphn_to_string(s : BiostructangleGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructangleNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_angle_node_make(size : Int) -> BiostructangleNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_angle_node_len(s : BiostructangleNode) -> Int { s.size }

pub fn bio_struct_angle_node_get(s : BiostructangleNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_angle_node_set(s : BiostructangleNode, i : Int, v : Double) -> BiostructangleNode {
  let result = bio_struct_angle_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_angle_node_sum(s : BiostructangleNode) -> Double { @_common.sum(s.data) }

pub fn bio_struct_angle_node_mean(s : BiostructangleNode) -> Double { @_common.mean(s.data) }

pub fn bio_struct_angle_node_scale(s : BiostructangleNode, f : Double) -> BiostructangleNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_angle_node_add(a : BiostructangleNode, b : BiostructangleNode) -> BiostructangleNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_angle_node_copy(s : BiostructangleNode) -> BiostructangleNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_angle_node_fill(s : BiostructangleNode, v : Double) -> BiostructangleNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_angle_node_min(s : BiostructangleNode) -> Double { @_common.min(s.data) }

pub fn bio_struct_angle_node_max(s : BiostructangleNode) -> Double { @_common.max(s.data) }

pub fn bio_struct_angle_node_to_string(s : BiostructangleNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructangleEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_angle_edge_make(size : Int) -> BiostructangleEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_angle_edge_len(s : BiostructangleEdge) -> Int { s.size }

pub fn bio_struct_angle_edge_get(s : BiostructangleEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_angle_edge_set(s : BiostructangleEdge, i : Int, v : Double) -> BiostructangleEdge {
  let result = bio_struct_angle_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_angle_edge_sum(s : BiostructangleEdge) -> Double { @_common.sum(s.data) }

pub fn bio_struct_angle_edge_mean(s : BiostructangleEdge) -> Double { @_common.mean(s.data) }

pub fn bio_struct_angle_edge_scale(s : BiostructangleEdge, f : Double) -> BiostructangleEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_angle_edge_add(a : BiostructangleEdge, b : BiostructangleEdge) -> BiostructangleEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_angle_edge_copy(s : BiostructangleEdge) -> BiostructangleEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_angle_edge_fill(s : BiostructangleEdge, v : Double) -> BiostructangleEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_angle_edge_min(s : BiostructangleEdge) -> Double { @_common.min(s.data) }

pub fn bio_struct_angle_edge_max(s : BiostructangleEdge) -> Double { @_common.max(s.data) }

pub fn bio_struct_angle_edge_to_string(s : BiostructangleEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructanglePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_angle_path_make(size : Int) -> BiostructanglePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_angle_path_len(s : BiostructanglePath) -> Int { s.size }

pub fn bio_struct_angle_path_get(s : BiostructanglePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_angle_path_set(s : BiostructanglePath, i : Int, v : Double) -> BiostructanglePath {
  let result = bio_struct_angle_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_angle_path_sum(s : BiostructanglePath) -> Double { @_common.sum(s.data) }

pub fn bio_struct_angle_path_mean(s : BiostructanglePath) -> Double { @_common.mean(s.data) }

pub fn bio_struct_angle_path_scale(s : BiostructanglePath, f : Double) -> BiostructanglePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_angle_path_add(a : BiostructanglePath, b : BiostructanglePath) -> BiostructanglePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_angle_path_copy(s : BiostructanglePath) -> BiostructanglePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_angle_path_fill(s : BiostructanglePath, v : Double) -> BiostructanglePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_angle_path_min(s : BiostructanglePath) -> Double { @_common.min(s.data) }

pub fn bio_struct_angle_path_max(s : BiostructanglePath) -> Double { @_common.max(s.data) }

pub fn bio_struct_angle_path_to_string(s : BiostructanglePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructangleCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_angle_cluster_make(size : Int) -> BiostructangleCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_angle_cluster_len(s : BiostructangleCluster) -> Int { s.size }

pub fn bio_struct_angle_cluster_get(s : BiostructangleCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_angle_cluster_set(s : BiostructangleCluster, i : Int, v : Double) -> BiostructangleCluster {
  let result = bio_struct_angle_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_angle_cluster_sum(s : BiostructangleCluster) -> Double { @_common.sum(s.data) }

pub fn bio_struct_angle_cluster_mean(s : BiostructangleCluster) -> Double { @_common.mean(s.data) }

pub fn bio_struct_angle_cluster_scale(s : BiostructangleCluster, f : Double) -> BiostructangleCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_angle_cluster_add(a : BiostructangleCluster, b : BiostructangleCluster) -> BiostructangleCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_angle_cluster_copy(s : BiostructangleCluster) -> BiostructangleCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_angle_cluster_fill(s : BiostructangleCluster, v : Double) -> BiostructangleCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_angle_cluster_min(s : BiostructangleCluster) -> Double { @_common.min(s.data) }

pub fn bio_struct_angle_cluster_max(s : BiostructangleCluster) -> Double { @_common.max(s.data) }

pub fn bio_struct_angle_cluster_to_string(s : BiostructangleCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructangleModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_angle_model_make(size : Int) -> BiostructangleModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_angle_model_len(s : BiostructangleModel) -> Int { s.size }

pub fn bio_struct_angle_model_get(s : BiostructangleModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_angle_model_set(s : BiostructangleModel, i : Int, v : Double) -> BiostructangleModel {
  let result = bio_struct_angle_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_angle_model_sum(s : BiostructangleModel) -> Double { @_common.sum(s.data) }

pub fn bio_struct_angle_model_mean(s : BiostructangleModel) -> Double { @_common.mean(s.data) }

pub fn bio_struct_angle_model_scale(s : BiostructangleModel, f : Double) -> BiostructangleModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_angle_model_add(a : BiostructangleModel, b : BiostructangleModel) -> BiostructangleModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_angle_model_copy(s : BiostructangleModel) -> BiostructangleModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_angle_model_fill(s : BiostructangleModel, v : Double) -> BiostructangleModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_angle_model_min(s : BiostructangleModel) -> Double { @_common.min(s.data) }

pub fn bio_struct_angle_model_max(s : BiostructangleModel) -> Double { @_common.max(s.data) }

pub fn bio_struct_angle_model_to_string(s : BiostructangleModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructangleLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_angle_layer_make(size : Int) -> BiostructangleLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_angle_layer_len(s : BiostructangleLayer) -> Int { s.size }

pub fn bio_struct_angle_layer_get(s : BiostructangleLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_angle_layer_set(s : BiostructangleLayer, i : Int, v : Double) -> BiostructangleLayer {
  let result = bio_struct_angle_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_angle_layer_sum(s : BiostructangleLayer) -> Double { @_common.sum(s.data) }

pub fn bio_struct_angle_layer_mean(s : BiostructangleLayer) -> Double { @_common.mean(s.data) }

pub fn bio_struct_angle_layer_scale(s : BiostructangleLayer, f : Double) -> BiostructangleLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_angle_layer_add(a : BiostructangleLayer, b : BiostructangleLayer) -> BiostructangleLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_angle_layer_copy(s : BiostructangleLayer) -> BiostructangleLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_angle_layer_fill(s : BiostructangleLayer, v : Double) -> BiostructangleLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_angle_layer_min(s : BiostructangleLayer) -> Double { @_common.min(s.data) }

pub fn bio_struct_angle_layer_max(s : BiostructangleLayer) -> Double { @_common.max(s.data) }

pub fn bio_struct_angle_layer_to_string(s : BiostructangleLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructangleBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_angle_buffer_make(size : Int) -> BiostructangleBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_angle_buffer_len(s : BiostructangleBuffer) -> Int { s.size }

pub fn bio_struct_angle_buffer_get(s : BiostructangleBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_angle_buffer_set(s : BiostructangleBuffer, i : Int, v : Double) -> BiostructangleBuffer {
  let result = bio_struct_angle_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_angle_buffer_sum(s : BiostructangleBuffer) -> Double { @_common.sum(s.data) }

pub fn bio_struct_angle_buffer_mean(s : BiostructangleBuffer) -> Double { @_common.mean(s.data) }

pub fn bio_struct_angle_buffer_scale(s : BiostructangleBuffer, f : Double) -> BiostructangleBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_angle_buffer_add(a : BiostructangleBuffer, b : BiostructangleBuffer) -> BiostructangleBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_angle_buffer_copy(s : BiostructangleBuffer) -> BiostructangleBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_angle_buffer_fill(s : BiostructangleBuffer, v : Double) -> BiostructangleBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_angle_buffer_min(s : BiostructangleBuffer) -> Double { @_common.min(s.data) }

pub fn bio_struct_angle_buffer_max(s : BiostructangleBuffer) -> Double { @_common.max(s.data) }

pub fn bio_struct_angle_buffer_to_string(s : BiostructangleBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructangleCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_angle_cursor_make(size : Int) -> BiostructangleCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_angle_cursor_len(s : BiostructangleCursor) -> Int { s.size }

pub fn bio_struct_angle_cursor_get(s : BiostructangleCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_angle_cursor_set(s : BiostructangleCursor, i : Int, v : Double) -> BiostructangleCursor {
  let result = bio_struct_angle_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_angle_cursor_sum(s : BiostructangleCursor) -> Double { @_common.sum(s.data) }

pub fn bio_struct_angle_cursor_mean(s : BiostructangleCursor) -> Double { @_common.mean(s.data) }

pub fn bio_struct_angle_cursor_scale(s : BiostructangleCursor, f : Double) -> BiostructangleCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_angle_cursor_add(a : BiostructangleCursor, b : BiostructangleCursor) -> BiostructangleCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_angle_cursor_copy(s : BiostructangleCursor) -> BiostructangleCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_angle_cursor_fill(s : BiostructangleCursor, v : Double) -> BiostructangleCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_angle_cursor_min(s : BiostructangleCursor) -> Double { @_common.min(s.data) }

pub fn bio_struct_angle_cursor_max(s : BiostructangleCursor) -> Double { @_common.max(s.data) }

pub fn bio_struct_angle_cursor_to_string(s : BiostructangleCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructangleView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_angle_view_make(size : Int) -> BiostructangleView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_angle_view_len(s : BiostructangleView) -> Int { s.size }

pub fn bio_struct_angle_view_get(s : BiostructangleView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_angle_view_set(s : BiostructangleView, i : Int, v : Double) -> BiostructangleView {
  let result = bio_struct_angle_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_angle_view_sum(s : BiostructangleView) -> Double { @_common.sum(s.data) }

pub fn bio_struct_angle_view_mean(s : BiostructangleView) -> Double { @_common.mean(s.data) }

pub fn bio_struct_angle_view_scale(s : BiostructangleView, f : Double) -> BiostructangleView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_angle_view_add(a : BiostructangleView, b : BiostructangleView) -> BiostructangleView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_angle_view_copy(s : BiostructangleView) -> BiostructangleView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_angle_view_fill(s : BiostructangleView, v : Double) -> BiostructangleView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_angle_view_min(s : BiostructangleView) -> Double { @_common.min(s.data) }

pub fn bio_struct_angle_view_max(s : BiostructangleView) -> Double { @_common.max(s.data) }

pub fn bio_struct_angle_view_to_string(s : BiostructangleView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructangleRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_angle_range_make(size : Int) -> BiostructangleRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_angle_range_len(s : BiostructangleRange) -> Int { s.size }

pub fn bio_struct_angle_range_get(s : BiostructangleRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_angle_range_set(s : BiostructangleRange, i : Int, v : Double) -> BiostructangleRange {
  let result = bio_struct_angle_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_angle_range_sum(s : BiostructangleRange) -> Double { @_common.sum(s.data) }

pub fn bio_struct_angle_range_mean(s : BiostructangleRange) -> Double { @_common.mean(s.data) }

pub fn bio_struct_angle_range_scale(s : BiostructangleRange, f : Double) -> BiostructangleRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_angle_range_add(a : BiostructangleRange, b : BiostructangleRange) -> BiostructangleRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_angle_range_copy(s : BiostructangleRange) -> BiostructangleRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_angle_range_fill(s : BiostructangleRange, v : Double) -> BiostructangleRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_angle_range_min(s : BiostructangleRange) -> Double { @_common.min(s.data) }

pub fn bio_struct_angle_range_max(s : BiostructangleRange) -> Double { @_common.max(s.data) }

pub fn bio_struct_angle_range_to_string(s : BiostructangleRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructangleSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_angle_slice_make(size : Int) -> BiostructangleSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_angle_slice_len(s : BiostructangleSlice) -> Int { s.size }

pub fn bio_struct_angle_slice_get(s : BiostructangleSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_angle_slice_set(s : BiostructangleSlice, i : Int, v : Double) -> BiostructangleSlice {
  let result = bio_struct_angle_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_angle_slice_sum(s : BiostructangleSlice) -> Double { @_common.sum(s.data) }

pub fn bio_struct_angle_slice_mean(s : BiostructangleSlice) -> Double { @_common.mean(s.data) }

pub fn bio_struct_angle_slice_scale(s : BiostructangleSlice, f : Double) -> BiostructangleSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_angle_slice_add(a : BiostructangleSlice, b : BiostructangleSlice) -> BiostructangleSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_angle_slice_copy(s : BiostructangleSlice) -> BiostructangleSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_angle_slice_fill(s : BiostructangleSlice, v : Double) -> BiostructangleSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_angle_slice_min(s : BiostructangleSlice) -> Double { @_common.min(s.data) }

pub fn bio_struct_angle_slice_max(s : BiostructangleSlice) -> Double { @_common.max(s.data) }

pub fn bio_struct_angle_slice_to_string(s : BiostructangleSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


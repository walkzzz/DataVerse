///===
/// extcore/bio_struct_secondary

pub(all) struct BiostructsecondaryPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn bio_struct_secondary_make_point(x : Double, y : Double) -> BiostructsecondaryPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn bio_struct_secondary_make_point3(x : Double, y : Double, z : Double) -> BiostructsecondaryPoint {
  { x, y, z, label: 0 }
}

pub fn bio_struct_secondary_point_x(pt : BiostructsecondaryPoint) -> Double { pt.x }

pub fn bio_struct_secondary_point_y(pt : BiostructsecondaryPoint) -> Double { pt.y }

pub fn bio_struct_secondary_point_z(pt : BiostructsecondaryPoint) -> Double { pt.z }

pub fn bio_struct_secondary_point_label(pt : BiostructsecondaryPoint) -> Int { pt.label }

pub fn bio_struct_secondary_point_dist(a : BiostructsecondaryPoint, b : BiostructsecondaryPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn bio_struct_secondary_point_add(a : BiostructsecondaryPoint, b : BiostructsecondaryPoint) -> BiostructsecondaryPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn bio_struct_secondary_point_sub(a : BiostructsecondaryPoint, b : BiostructsecondaryPoint) -> BiostructsecondaryPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn bio_struct_secondary_point_scale(pt : BiostructsecondaryPoint, s : Double) -> BiostructsecondaryPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn bio_struct_secondary_point_dot(a : BiostructsecondaryPoint, b : BiostructsecondaryPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn bio_struct_secondary_point_cross(a : BiostructsecondaryPoint, b : BiostructsecondaryPoint) -> BiostructsecondaryPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn bio_struct_secondary_point_norm(pt : BiostructsecondaryPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn bio_struct_secondary_point_normalize(pt : BiostructsecondaryPoint) -> BiostructsecondaryPoint {
  let n = bio_struct_secondary_point_norm(pt)
  if n < 0.0000001 { pt } else { bio_struct_secondary_point_scale(pt, 1.0 / n) }
}

pub fn bio_struct_secondary_point_negate(pt : BiostructsecondaryPoint) -> BiostructsecondaryPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn bio_struct_secondary_point_mid(a : BiostructsecondaryPoint, b : BiostructsecondaryPoint) -> BiostructsecondaryPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn bio_struct_secondary_point_lerp(a : BiostructsecondaryPoint, b : BiostructsecondaryPoint, t : Double) -> BiostructsecondaryPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn bio_struct_secondary_point_to_string(pt : BiostructsecondaryPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct BiostructsecondarySeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn bio_struct_secondary_make_series(vals : Array[Double], name : String) -> BiostructsecondarySeries {
  { vals, name, meta: 0 }
}

pub fn bio_struct_secondary_series_len(s : BiostructsecondarySeries) -> Int { s.vals.length() }

pub fn bio_struct_secondary_series_sum(s : BiostructsecondarySeries) -> Double { @_common.sum(s.vals) }

pub fn bio_struct_secondary_series_mean(s : BiostructsecondarySeries) -> Double { @_common.mean(s.vals) }

pub fn bio_struct_secondary_series_min(s : BiostructsecondarySeries) -> Double { @_common.min(s.vals) }

pub fn bio_struct_secondary_series_max(s : BiostructsecondarySeries) -> Double { @_common.max(s.vals) }

pub fn bio_struct_secondary_series_range(s : BiostructsecondarySeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn bio_struct_secondary_series_var(s : BiostructsecondarySeries) -> Double { @_common.variance(s.vals) }

pub fn bio_struct_secondary_series_std(s : BiostructsecondarySeries) -> Double { @_common.std(s.vals) }

pub fn bio_struct_secondary_series_median(s : BiostructsecondarySeries) -> Double { @_common.median(s.vals) }

pub fn bio_struct_secondary_series_scale(s : BiostructsecondarySeries, f : Double) -> BiostructsecondarySeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn bio_struct_secondary_series_add(a : BiostructsecondarySeries, b : BiostructsecondarySeries) -> BiostructsecondarySeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn bio_struct_secondary_series_sub(a : BiostructsecondarySeries, b : BiostructsecondarySeries) -> BiostructsecondarySeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn bio_struct_secondary_series_normalize(s : BiostructsecondarySeries) -> BiostructsecondarySeries {
  let mn = bio_struct_secondary_series_min(s)
  let mx = bio_struct_secondary_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn bio_struct_secondary_series_cumsum(s : BiostructsecondarySeries) -> BiostructsecondarySeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn bio_struct_secondary_series_to_string(s : BiostructsecondarySeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BiostructsecondaryMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn bio_struct_secondary_make_matrix(rows : Int, cols : Int, val : Double) -> BiostructsecondaryMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn bio_struct_secondary_matrix_identity(n : Int) -> BiostructsecondaryMatrix {
  let m = bio_struct_secondary_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn bio_struct_secondary_matrix_get(m : BiostructsecondaryMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn bio_struct_secondary_matrix_transpose(m : BiostructsecondaryMatrix) -> BiostructsecondaryMatrix {
  let result = bio_struct_secondary_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn bio_struct_secondary_matrix_add(a : BiostructsecondaryMatrix, b : BiostructsecondaryMatrix) -> BiostructsecondaryMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = bio_struct_secondary_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn bio_struct_secondary_matrix_scale(m : BiostructsecondaryMatrix, s : Double) -> BiostructsecondaryMatrix {
  let result = bio_struct_secondary_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn bio_struct_secondary_matrix_multiply(a : BiostructsecondaryMatrix, b : BiostructsecondaryMatrix) -> BiostructsecondaryMatrix {
  if a.cols != b.rows { return bio_struct_secondary_make_matrix(a.rows, b.cols, 0.0) }
  let result = bio_struct_secondary_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn bio_struct_secondary_matrix_trace(m : BiostructsecondaryMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn bio_struct_secondary_matrix_det(m : BiostructsecondaryMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn bio_struct_secondary_matrix_norm(m : BiostructsecondaryMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn bio_struct_secondary_matrix_to_string(m : BiostructsecondaryMatrix) -> String {
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

pub(all) struct BiostructsecondaryVector {
  comps : Array[Double]
  dim : Int
}

pub fn bio_struct_secondary_make_vector(comps : Array[Double]) -> BiostructsecondaryVector {
  { comps, dim: comps.length() }
}

pub fn bio_struct_secondary_vector_zero(dim : Int) -> BiostructsecondaryVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn bio_struct_secondary_vector_add(a : BiostructsecondaryVector, b : BiostructsecondaryVector) -> BiostructsecondaryVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn bio_struct_secondary_vector_sub(a : BiostructsecondaryVector, b : BiostructsecondaryVector) -> BiostructsecondaryVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn bio_struct_secondary_vector_scale(v : BiostructsecondaryVector, s : Double) -> BiostructsecondaryVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn bio_struct_secondary_vector_dot(a : BiostructsecondaryVector, b : BiostructsecondaryVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn bio_struct_secondary_vector_norm(v : BiostructsecondaryVector) -> Double { @_common.sqrt(bio_struct_secondary_vector_dot(v, v)) }

pub fn bio_struct_secondary_vector_normalize(v : BiostructsecondaryVector) -> BiostructsecondaryVector {
  let n = bio_struct_secondary_vector_norm(v)
  if n < 0.0000001 { v } else { bio_struct_secondary_vector_scale(v, 1.0 / n) }
}

pub fn bio_struct_secondary_vector_dist(a : BiostructsecondaryVector, b : BiostructsecondaryVector) -> Double {
  bio_struct_secondary_vector_norm(bio_struct_secondary_vector_sub(a, b))
}

pub fn bio_struct_secondary_vector_to_string(v : BiostructsecondaryVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn bio_struct_secondary_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn bio_struct_secondary_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn bio_struct_secondary_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn bio_struct_secondary_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn bio_struct_secondary_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn bio_struct_secondary_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn bio_struct_secondary_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn bio_struct_secondary_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn bio_struct_secondary_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn bio_struct_secondary_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn bio_struct_secondary_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn bio_struct_secondary_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn bio_struct_secondary_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn bio_struct_secondary_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn bio_struct_secondary_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn bio_struct_secondary_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn bio_struct_secondary_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn bio_struct_secondary_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn bio_struct_secondary_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn bio_struct_secondary_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn bio_struct_secondary_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn bio_struct_secondary_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn bio_struct_secondary_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn bio_struct_secondary_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn bio_struct_secondary_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn bio_struct_secondary_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn bio_struct_secondary_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn bio_struct_secondary_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn bio_struct_secondary_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct BiostructsecondaryFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_secondary_frame_make(size : Int) -> BiostructsecondaryFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_secondary_frame_len(s : BiostructsecondaryFrame) -> Int { s.size }

pub fn bio_struct_secondary_frame_get(s : BiostructsecondaryFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_secondary_frame_set(s : BiostructsecondaryFrame, i : Int, v : Double) -> BiostructsecondaryFrame {
  let result = bio_struct_secondary_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_secondary_frame_sum(s : BiostructsecondaryFrame) -> Double { @_common.sum(s.data) }

pub fn bio_struct_secondary_frame_mean(s : BiostructsecondaryFrame) -> Double { @_common.mean(s.data) }

pub fn bio_struct_secondary_frame_scale(s : BiostructsecondaryFrame, f : Double) -> BiostructsecondaryFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_secondary_frame_add(a : BiostructsecondaryFrame, b : BiostructsecondaryFrame) -> BiostructsecondaryFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_secondary_frame_copy(s : BiostructsecondaryFrame) -> BiostructsecondaryFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_secondary_frame_fill(s : BiostructsecondaryFrame, v : Double) -> BiostructsecondaryFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_secondary_frame_min(s : BiostructsecondaryFrame) -> Double { @_common.min(s.data) }

pub fn bio_struct_secondary_frame_max(s : BiostructsecondaryFrame) -> Double { @_common.max(s.data) }

pub fn bio_struct_secondary_frame_to_string(s : BiostructsecondaryFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructsecondaryTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_secondary_table_make(size : Int) -> BiostructsecondaryTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_secondary_table_len(s : BiostructsecondaryTable) -> Int { s.size }

pub fn bio_struct_secondary_table_get(s : BiostructsecondaryTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_secondary_table_set(s : BiostructsecondaryTable, i : Int, v : Double) -> BiostructsecondaryTable {
  let result = bio_struct_secondary_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_secondary_table_sum(s : BiostructsecondaryTable) -> Double { @_common.sum(s.data) }

pub fn bio_struct_secondary_table_mean(s : BiostructsecondaryTable) -> Double { @_common.mean(s.data) }

pub fn bio_struct_secondary_table_scale(s : BiostructsecondaryTable, f : Double) -> BiostructsecondaryTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_secondary_table_add(a : BiostructsecondaryTable, b : BiostructsecondaryTable) -> BiostructsecondaryTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_secondary_table_copy(s : BiostructsecondaryTable) -> BiostructsecondaryTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_secondary_table_fill(s : BiostructsecondaryTable, v : Double) -> BiostructsecondaryTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_secondary_table_min(s : BiostructsecondaryTable) -> Double { @_common.min(s.data) }

pub fn bio_struct_secondary_table_max(s : BiostructsecondaryTable) -> Double { @_common.max(s.data) }

pub fn bio_struct_secondary_table_to_string(s : BiostructsecondaryTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructsecondaryGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_secondary_graphn_make(size : Int) -> BiostructsecondaryGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_secondary_graphn_len(s : BiostructsecondaryGraphN) -> Int { s.size }

pub fn bio_struct_secondary_graphn_get(s : BiostructsecondaryGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_secondary_graphn_set(s : BiostructsecondaryGraphN, i : Int, v : Double) -> BiostructsecondaryGraphN {
  let result = bio_struct_secondary_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_secondary_graphn_sum(s : BiostructsecondaryGraphN) -> Double { @_common.sum(s.data) }

pub fn bio_struct_secondary_graphn_mean(s : BiostructsecondaryGraphN) -> Double { @_common.mean(s.data) }

pub fn bio_struct_secondary_graphn_scale(s : BiostructsecondaryGraphN, f : Double) -> BiostructsecondaryGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_secondary_graphn_add(a : BiostructsecondaryGraphN, b : BiostructsecondaryGraphN) -> BiostructsecondaryGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_secondary_graphn_copy(s : BiostructsecondaryGraphN) -> BiostructsecondaryGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_secondary_graphn_fill(s : BiostructsecondaryGraphN, v : Double) -> BiostructsecondaryGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_secondary_graphn_min(s : BiostructsecondaryGraphN) -> Double { @_common.min(s.data) }

pub fn bio_struct_secondary_graphn_max(s : BiostructsecondaryGraphN) -> Double { @_common.max(s.data) }

pub fn bio_struct_secondary_graphn_to_string(s : BiostructsecondaryGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructsecondaryNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_secondary_node_make(size : Int) -> BiostructsecondaryNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_secondary_node_len(s : BiostructsecondaryNode) -> Int { s.size }

pub fn bio_struct_secondary_node_get(s : BiostructsecondaryNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_secondary_node_set(s : BiostructsecondaryNode, i : Int, v : Double) -> BiostructsecondaryNode {
  let result = bio_struct_secondary_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_secondary_node_sum(s : BiostructsecondaryNode) -> Double { @_common.sum(s.data) }

pub fn bio_struct_secondary_node_mean(s : BiostructsecondaryNode) -> Double { @_common.mean(s.data) }

pub fn bio_struct_secondary_node_scale(s : BiostructsecondaryNode, f : Double) -> BiostructsecondaryNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_secondary_node_add(a : BiostructsecondaryNode, b : BiostructsecondaryNode) -> BiostructsecondaryNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_secondary_node_copy(s : BiostructsecondaryNode) -> BiostructsecondaryNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_secondary_node_fill(s : BiostructsecondaryNode, v : Double) -> BiostructsecondaryNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_secondary_node_min(s : BiostructsecondaryNode) -> Double { @_common.min(s.data) }

pub fn bio_struct_secondary_node_max(s : BiostructsecondaryNode) -> Double { @_common.max(s.data) }

pub fn bio_struct_secondary_node_to_string(s : BiostructsecondaryNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructsecondaryEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_secondary_edge_make(size : Int) -> BiostructsecondaryEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_secondary_edge_len(s : BiostructsecondaryEdge) -> Int { s.size }

pub fn bio_struct_secondary_edge_get(s : BiostructsecondaryEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_secondary_edge_set(s : BiostructsecondaryEdge, i : Int, v : Double) -> BiostructsecondaryEdge {
  let result = bio_struct_secondary_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_secondary_edge_sum(s : BiostructsecondaryEdge) -> Double { @_common.sum(s.data) }

pub fn bio_struct_secondary_edge_mean(s : BiostructsecondaryEdge) -> Double { @_common.mean(s.data) }

pub fn bio_struct_secondary_edge_scale(s : BiostructsecondaryEdge, f : Double) -> BiostructsecondaryEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_secondary_edge_add(a : BiostructsecondaryEdge, b : BiostructsecondaryEdge) -> BiostructsecondaryEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_secondary_edge_copy(s : BiostructsecondaryEdge) -> BiostructsecondaryEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_secondary_edge_fill(s : BiostructsecondaryEdge, v : Double) -> BiostructsecondaryEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_secondary_edge_min(s : BiostructsecondaryEdge) -> Double { @_common.min(s.data) }

pub fn bio_struct_secondary_edge_max(s : BiostructsecondaryEdge) -> Double { @_common.max(s.data) }

pub fn bio_struct_secondary_edge_to_string(s : BiostructsecondaryEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructsecondaryPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_secondary_path_make(size : Int) -> BiostructsecondaryPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_secondary_path_len(s : BiostructsecondaryPath) -> Int { s.size }

pub fn bio_struct_secondary_path_get(s : BiostructsecondaryPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_secondary_path_set(s : BiostructsecondaryPath, i : Int, v : Double) -> BiostructsecondaryPath {
  let result = bio_struct_secondary_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_secondary_path_sum(s : BiostructsecondaryPath) -> Double { @_common.sum(s.data) }

pub fn bio_struct_secondary_path_mean(s : BiostructsecondaryPath) -> Double { @_common.mean(s.data) }

pub fn bio_struct_secondary_path_scale(s : BiostructsecondaryPath, f : Double) -> BiostructsecondaryPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_secondary_path_add(a : BiostructsecondaryPath, b : BiostructsecondaryPath) -> BiostructsecondaryPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_secondary_path_copy(s : BiostructsecondaryPath) -> BiostructsecondaryPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_secondary_path_fill(s : BiostructsecondaryPath, v : Double) -> BiostructsecondaryPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_secondary_path_min(s : BiostructsecondaryPath) -> Double { @_common.min(s.data) }

pub fn bio_struct_secondary_path_max(s : BiostructsecondaryPath) -> Double { @_common.max(s.data) }

pub fn bio_struct_secondary_path_to_string(s : BiostructsecondaryPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructsecondaryCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_secondary_cluster_make(size : Int) -> BiostructsecondaryCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_secondary_cluster_len(s : BiostructsecondaryCluster) -> Int { s.size }

pub fn bio_struct_secondary_cluster_get(s : BiostructsecondaryCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_secondary_cluster_set(s : BiostructsecondaryCluster, i : Int, v : Double) -> BiostructsecondaryCluster {
  let result = bio_struct_secondary_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_secondary_cluster_sum(s : BiostructsecondaryCluster) -> Double { @_common.sum(s.data) }

pub fn bio_struct_secondary_cluster_mean(s : BiostructsecondaryCluster) -> Double { @_common.mean(s.data) }

pub fn bio_struct_secondary_cluster_scale(s : BiostructsecondaryCluster, f : Double) -> BiostructsecondaryCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_secondary_cluster_add(a : BiostructsecondaryCluster, b : BiostructsecondaryCluster) -> BiostructsecondaryCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_secondary_cluster_copy(s : BiostructsecondaryCluster) -> BiostructsecondaryCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_secondary_cluster_fill(s : BiostructsecondaryCluster, v : Double) -> BiostructsecondaryCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_secondary_cluster_min(s : BiostructsecondaryCluster) -> Double { @_common.min(s.data) }

pub fn bio_struct_secondary_cluster_max(s : BiostructsecondaryCluster) -> Double { @_common.max(s.data) }

pub fn bio_struct_secondary_cluster_to_string(s : BiostructsecondaryCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructsecondaryModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_secondary_model_make(size : Int) -> BiostructsecondaryModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_secondary_model_len(s : BiostructsecondaryModel) -> Int { s.size }

pub fn bio_struct_secondary_model_get(s : BiostructsecondaryModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_secondary_model_set(s : BiostructsecondaryModel, i : Int, v : Double) -> BiostructsecondaryModel {
  let result = bio_struct_secondary_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_secondary_model_sum(s : BiostructsecondaryModel) -> Double { @_common.sum(s.data) }

pub fn bio_struct_secondary_model_mean(s : BiostructsecondaryModel) -> Double { @_common.mean(s.data) }

pub fn bio_struct_secondary_model_scale(s : BiostructsecondaryModel, f : Double) -> BiostructsecondaryModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_secondary_model_add(a : BiostructsecondaryModel, b : BiostructsecondaryModel) -> BiostructsecondaryModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_secondary_model_copy(s : BiostructsecondaryModel) -> BiostructsecondaryModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_secondary_model_fill(s : BiostructsecondaryModel, v : Double) -> BiostructsecondaryModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_secondary_model_min(s : BiostructsecondaryModel) -> Double { @_common.min(s.data) }

pub fn bio_struct_secondary_model_max(s : BiostructsecondaryModel) -> Double { @_common.max(s.data) }

pub fn bio_struct_secondary_model_to_string(s : BiostructsecondaryModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructsecondaryLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_secondary_layer_make(size : Int) -> BiostructsecondaryLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_secondary_layer_len(s : BiostructsecondaryLayer) -> Int { s.size }

pub fn bio_struct_secondary_layer_get(s : BiostructsecondaryLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_secondary_layer_set(s : BiostructsecondaryLayer, i : Int, v : Double) -> BiostructsecondaryLayer {
  let result = bio_struct_secondary_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_secondary_layer_sum(s : BiostructsecondaryLayer) -> Double { @_common.sum(s.data) }

pub fn bio_struct_secondary_layer_mean(s : BiostructsecondaryLayer) -> Double { @_common.mean(s.data) }

pub fn bio_struct_secondary_layer_scale(s : BiostructsecondaryLayer, f : Double) -> BiostructsecondaryLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_secondary_layer_add(a : BiostructsecondaryLayer, b : BiostructsecondaryLayer) -> BiostructsecondaryLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_secondary_layer_copy(s : BiostructsecondaryLayer) -> BiostructsecondaryLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_secondary_layer_fill(s : BiostructsecondaryLayer, v : Double) -> BiostructsecondaryLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_secondary_layer_min(s : BiostructsecondaryLayer) -> Double { @_common.min(s.data) }

pub fn bio_struct_secondary_layer_max(s : BiostructsecondaryLayer) -> Double { @_common.max(s.data) }

pub fn bio_struct_secondary_layer_to_string(s : BiostructsecondaryLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructsecondaryBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_secondary_buffer_make(size : Int) -> BiostructsecondaryBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_secondary_buffer_len(s : BiostructsecondaryBuffer) -> Int { s.size }

pub fn bio_struct_secondary_buffer_get(s : BiostructsecondaryBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_secondary_buffer_set(s : BiostructsecondaryBuffer, i : Int, v : Double) -> BiostructsecondaryBuffer {
  let result = bio_struct_secondary_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_secondary_buffer_sum(s : BiostructsecondaryBuffer) -> Double { @_common.sum(s.data) }

pub fn bio_struct_secondary_buffer_mean(s : BiostructsecondaryBuffer) -> Double { @_common.mean(s.data) }

pub fn bio_struct_secondary_buffer_scale(s : BiostructsecondaryBuffer, f : Double) -> BiostructsecondaryBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_secondary_buffer_add(a : BiostructsecondaryBuffer, b : BiostructsecondaryBuffer) -> BiostructsecondaryBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_secondary_buffer_copy(s : BiostructsecondaryBuffer) -> BiostructsecondaryBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_secondary_buffer_fill(s : BiostructsecondaryBuffer, v : Double) -> BiostructsecondaryBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_secondary_buffer_min(s : BiostructsecondaryBuffer) -> Double { @_common.min(s.data) }

pub fn bio_struct_secondary_buffer_max(s : BiostructsecondaryBuffer) -> Double { @_common.max(s.data) }

pub fn bio_struct_secondary_buffer_to_string(s : BiostructsecondaryBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructsecondaryCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_secondary_cursor_make(size : Int) -> BiostructsecondaryCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_secondary_cursor_len(s : BiostructsecondaryCursor) -> Int { s.size }

pub fn bio_struct_secondary_cursor_get(s : BiostructsecondaryCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_secondary_cursor_set(s : BiostructsecondaryCursor, i : Int, v : Double) -> BiostructsecondaryCursor {
  let result = bio_struct_secondary_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_secondary_cursor_sum(s : BiostructsecondaryCursor) -> Double { @_common.sum(s.data) }

pub fn bio_struct_secondary_cursor_mean(s : BiostructsecondaryCursor) -> Double { @_common.mean(s.data) }

pub fn bio_struct_secondary_cursor_scale(s : BiostructsecondaryCursor, f : Double) -> BiostructsecondaryCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_secondary_cursor_add(a : BiostructsecondaryCursor, b : BiostructsecondaryCursor) -> BiostructsecondaryCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_secondary_cursor_copy(s : BiostructsecondaryCursor) -> BiostructsecondaryCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_secondary_cursor_fill(s : BiostructsecondaryCursor, v : Double) -> BiostructsecondaryCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_secondary_cursor_min(s : BiostructsecondaryCursor) -> Double { @_common.min(s.data) }

pub fn bio_struct_secondary_cursor_max(s : BiostructsecondaryCursor) -> Double { @_common.max(s.data) }

pub fn bio_struct_secondary_cursor_to_string(s : BiostructsecondaryCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructsecondaryView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_secondary_view_make(size : Int) -> BiostructsecondaryView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_secondary_view_len(s : BiostructsecondaryView) -> Int { s.size }

pub fn bio_struct_secondary_view_get(s : BiostructsecondaryView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_secondary_view_set(s : BiostructsecondaryView, i : Int, v : Double) -> BiostructsecondaryView {
  let result = bio_struct_secondary_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_secondary_view_sum(s : BiostructsecondaryView) -> Double { @_common.sum(s.data) }

pub fn bio_struct_secondary_view_mean(s : BiostructsecondaryView) -> Double { @_common.mean(s.data) }

pub fn bio_struct_secondary_view_scale(s : BiostructsecondaryView, f : Double) -> BiostructsecondaryView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_secondary_view_add(a : BiostructsecondaryView, b : BiostructsecondaryView) -> BiostructsecondaryView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_secondary_view_copy(s : BiostructsecondaryView) -> BiostructsecondaryView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_secondary_view_fill(s : BiostructsecondaryView, v : Double) -> BiostructsecondaryView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_secondary_view_min(s : BiostructsecondaryView) -> Double { @_common.min(s.data) }

pub fn bio_struct_secondary_view_max(s : BiostructsecondaryView) -> Double { @_common.max(s.data) }

pub fn bio_struct_secondary_view_to_string(s : BiostructsecondaryView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructsecondaryRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_secondary_range_make(size : Int) -> BiostructsecondaryRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_secondary_range_len(s : BiostructsecondaryRange) -> Int { s.size }

pub fn bio_struct_secondary_range_get(s : BiostructsecondaryRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_secondary_range_set(s : BiostructsecondaryRange, i : Int, v : Double) -> BiostructsecondaryRange {
  let result = bio_struct_secondary_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_secondary_range_sum(s : BiostructsecondaryRange) -> Double { @_common.sum(s.data) }

pub fn bio_struct_secondary_range_mean(s : BiostructsecondaryRange) -> Double { @_common.mean(s.data) }

pub fn bio_struct_secondary_range_scale(s : BiostructsecondaryRange, f : Double) -> BiostructsecondaryRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_secondary_range_add(a : BiostructsecondaryRange, b : BiostructsecondaryRange) -> BiostructsecondaryRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_secondary_range_copy(s : BiostructsecondaryRange) -> BiostructsecondaryRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_secondary_range_fill(s : BiostructsecondaryRange, v : Double) -> BiostructsecondaryRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_secondary_range_min(s : BiostructsecondaryRange) -> Double { @_common.min(s.data) }

pub fn bio_struct_secondary_range_max(s : BiostructsecondaryRange) -> Double { @_common.max(s.data) }

pub fn bio_struct_secondary_range_to_string(s : BiostructsecondaryRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructsecondarySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_secondary_slice_make(size : Int) -> BiostructsecondarySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_secondary_slice_len(s : BiostructsecondarySlice) -> Int { s.size }

pub fn bio_struct_secondary_slice_get(s : BiostructsecondarySlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_secondary_slice_set(s : BiostructsecondarySlice, i : Int, v : Double) -> BiostructsecondarySlice {
  let result = bio_struct_secondary_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_secondary_slice_sum(s : BiostructsecondarySlice) -> Double { @_common.sum(s.data) }

pub fn bio_struct_secondary_slice_mean(s : BiostructsecondarySlice) -> Double { @_common.mean(s.data) }

pub fn bio_struct_secondary_slice_scale(s : BiostructsecondarySlice, f : Double) -> BiostructsecondarySlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_secondary_slice_add(a : BiostructsecondarySlice, b : BiostructsecondarySlice) -> BiostructsecondarySlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_secondary_slice_copy(s : BiostructsecondarySlice) -> BiostructsecondarySlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_secondary_slice_fill(s : BiostructsecondarySlice, v : Double) -> BiostructsecondarySlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_secondary_slice_min(s : BiostructsecondarySlice) -> Double { @_common.min(s.data) }

pub fn bio_struct_secondary_slice_max(s : BiostructsecondarySlice) -> Double { @_common.max(s.data) }

pub fn bio_struct_secondary_slice_to_string(s : BiostructsecondarySlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


///===
/// extcore/bio_struct_motif

pub(all) struct BiostructmotifPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn bio_struct_motif_make_point(x : Double, y : Double) -> BiostructmotifPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn bio_struct_motif_make_point3(x : Double, y : Double, z : Double) -> BiostructmotifPoint {
  { x, y, z, label: 0 }
}

pub fn bio_struct_motif_point_x(pt : BiostructmotifPoint) -> Double { pt.x }

pub fn bio_struct_motif_point_y(pt : BiostructmotifPoint) -> Double { pt.y }

pub fn bio_struct_motif_point_z(pt : BiostructmotifPoint) -> Double { pt.z }

pub fn bio_struct_motif_point_label(pt : BiostructmotifPoint) -> Int { pt.label }

pub fn bio_struct_motif_point_dist(a : BiostructmotifPoint, b : BiostructmotifPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn bio_struct_motif_point_add(a : BiostructmotifPoint, b : BiostructmotifPoint) -> BiostructmotifPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn bio_struct_motif_point_sub(a : BiostructmotifPoint, b : BiostructmotifPoint) -> BiostructmotifPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn bio_struct_motif_point_scale(pt : BiostructmotifPoint, s : Double) -> BiostructmotifPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn bio_struct_motif_point_dot(a : BiostructmotifPoint, b : BiostructmotifPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn bio_struct_motif_point_cross(a : BiostructmotifPoint, b : BiostructmotifPoint) -> BiostructmotifPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn bio_struct_motif_point_norm(pt : BiostructmotifPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn bio_struct_motif_point_normalize(pt : BiostructmotifPoint) -> BiostructmotifPoint {
  let n = bio_struct_motif_point_norm(pt)
  if n < 0.0000001 { pt } else { bio_struct_motif_point_scale(pt, 1.0 / n) }
}

pub fn bio_struct_motif_point_negate(pt : BiostructmotifPoint) -> BiostructmotifPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn bio_struct_motif_point_mid(a : BiostructmotifPoint, b : BiostructmotifPoint) -> BiostructmotifPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn bio_struct_motif_point_lerp(a : BiostructmotifPoint, b : BiostructmotifPoint, t : Double) -> BiostructmotifPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn bio_struct_motif_point_to_string(pt : BiostructmotifPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct BiostructmotifSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn bio_struct_motif_make_series(vals : Array[Double], name : String) -> BiostructmotifSeries {
  { vals, name, meta: 0 }
}

pub fn bio_struct_motif_series_len(s : BiostructmotifSeries) -> Int { s.vals.length() }

pub fn bio_struct_motif_series_sum(s : BiostructmotifSeries) -> Double { @_common.sum(s.vals) }

pub fn bio_struct_motif_series_mean(s : BiostructmotifSeries) -> Double { @_common.mean(s.vals) }

pub fn bio_struct_motif_series_min(s : BiostructmotifSeries) -> Double { @_common.min(s.vals) }

pub fn bio_struct_motif_series_max(s : BiostructmotifSeries) -> Double { @_common.max(s.vals) }

pub fn bio_struct_motif_series_range(s : BiostructmotifSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn bio_struct_motif_series_var(s : BiostructmotifSeries) -> Double { @_common.variance(s.vals) }

pub fn bio_struct_motif_series_std(s : BiostructmotifSeries) -> Double { @_common.std(s.vals) }

pub fn bio_struct_motif_series_median(s : BiostructmotifSeries) -> Double { @_common.median(s.vals) }

pub fn bio_struct_motif_series_scale(s : BiostructmotifSeries, f : Double) -> BiostructmotifSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn bio_struct_motif_series_add(a : BiostructmotifSeries, b : BiostructmotifSeries) -> BiostructmotifSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn bio_struct_motif_series_sub(a : BiostructmotifSeries, b : BiostructmotifSeries) -> BiostructmotifSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn bio_struct_motif_series_normalize(s : BiostructmotifSeries) -> BiostructmotifSeries {
  let mn = bio_struct_motif_series_min(s)
  let mx = bio_struct_motif_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn bio_struct_motif_series_cumsum(s : BiostructmotifSeries) -> BiostructmotifSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn bio_struct_motif_series_to_string(s : BiostructmotifSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BiostructmotifMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn bio_struct_motif_make_matrix(rows : Int, cols : Int, val : Double) -> BiostructmotifMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn bio_struct_motif_matrix_identity(n : Int) -> BiostructmotifMatrix {
  let m = bio_struct_motif_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn bio_struct_motif_matrix_get(m : BiostructmotifMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn bio_struct_motif_matrix_transpose(m : BiostructmotifMatrix) -> BiostructmotifMatrix {
  let result = bio_struct_motif_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn bio_struct_motif_matrix_add(a : BiostructmotifMatrix, b : BiostructmotifMatrix) -> BiostructmotifMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = bio_struct_motif_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn bio_struct_motif_matrix_scale(m : BiostructmotifMatrix, s : Double) -> BiostructmotifMatrix {
  let result = bio_struct_motif_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn bio_struct_motif_matrix_multiply(a : BiostructmotifMatrix, b : BiostructmotifMatrix) -> BiostructmotifMatrix {
  if a.cols != b.rows { return bio_struct_motif_make_matrix(a.rows, b.cols, 0.0) }
  let result = bio_struct_motif_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn bio_struct_motif_matrix_trace(m : BiostructmotifMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn bio_struct_motif_matrix_det(m : BiostructmotifMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn bio_struct_motif_matrix_norm(m : BiostructmotifMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn bio_struct_motif_matrix_to_string(m : BiostructmotifMatrix) -> String {
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

pub(all) struct BiostructmotifVector {
  comps : Array[Double]
  dim : Int
}

pub fn bio_struct_motif_make_vector(comps : Array[Double]) -> BiostructmotifVector {
  { comps, dim: comps.length() }
}

pub fn bio_struct_motif_vector_zero(dim : Int) -> BiostructmotifVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn bio_struct_motif_vector_add(a : BiostructmotifVector, b : BiostructmotifVector) -> BiostructmotifVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn bio_struct_motif_vector_sub(a : BiostructmotifVector, b : BiostructmotifVector) -> BiostructmotifVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn bio_struct_motif_vector_scale(v : BiostructmotifVector, s : Double) -> BiostructmotifVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn bio_struct_motif_vector_dot(a : BiostructmotifVector, b : BiostructmotifVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn bio_struct_motif_vector_norm(v : BiostructmotifVector) -> Double { @_common.sqrt(bio_struct_motif_vector_dot(v, v)) }

pub fn bio_struct_motif_vector_normalize(v : BiostructmotifVector) -> BiostructmotifVector {
  let n = bio_struct_motif_vector_norm(v)
  if n < 0.0000001 { v } else { bio_struct_motif_vector_scale(v, 1.0 / n) }
}

pub fn bio_struct_motif_vector_dist(a : BiostructmotifVector, b : BiostructmotifVector) -> Double {
  bio_struct_motif_vector_norm(bio_struct_motif_vector_sub(a, b))
}

pub fn bio_struct_motif_vector_to_string(v : BiostructmotifVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn bio_struct_motif_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn bio_struct_motif_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn bio_struct_motif_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn bio_struct_motif_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn bio_struct_motif_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn bio_struct_motif_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn bio_struct_motif_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn bio_struct_motif_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn bio_struct_motif_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn bio_struct_motif_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn bio_struct_motif_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn bio_struct_motif_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn bio_struct_motif_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn bio_struct_motif_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn bio_struct_motif_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn bio_struct_motif_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn bio_struct_motif_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn bio_struct_motif_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn bio_struct_motif_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn bio_struct_motif_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn bio_struct_motif_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn bio_struct_motif_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn bio_struct_motif_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn bio_struct_motif_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn bio_struct_motif_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn bio_struct_motif_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn bio_struct_motif_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn bio_struct_motif_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn bio_struct_motif_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct BiostructmotifFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_motif_frame_make(size : Int) -> BiostructmotifFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_motif_frame_len(s : BiostructmotifFrame) -> Int { s.size }

pub fn bio_struct_motif_frame_get(s : BiostructmotifFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_motif_frame_set(s : BiostructmotifFrame, i : Int, v : Double) -> BiostructmotifFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_frame_sum(s : BiostructmotifFrame) -> Double { @_common.sum(s.data) }

pub fn bio_struct_motif_frame_mean(s : BiostructmotifFrame) -> Double { @_common.mean(s.data) }

pub fn bio_struct_motif_frame_scale(s : BiostructmotifFrame, f : Double) -> BiostructmotifFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_frame_add(a : BiostructmotifFrame, b : BiostructmotifFrame) -> BiostructmotifFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_motif_frame_copy(s : BiostructmotifFrame) -> BiostructmotifFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_frame_fill(s : BiostructmotifFrame, v : Double) -> BiostructmotifFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_frame_min(s : BiostructmotifFrame) -> Double { @_common.min(s.data) }

pub fn bio_struct_motif_frame_max(s : BiostructmotifFrame) -> Double { @_common.max(s.data) }

pub fn bio_struct_motif_frame_to_string(s : BiostructmotifFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructmotifTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_motif_table_make(size : Int) -> BiostructmotifTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_motif_table_len(s : BiostructmotifTable) -> Int { s.size }

pub fn bio_struct_motif_table_get(s : BiostructmotifTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_motif_table_set(s : BiostructmotifTable, i : Int, v : Double) -> BiostructmotifTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_table_sum(s : BiostructmotifTable) -> Double { @_common.sum(s.data) }

pub fn bio_struct_motif_table_mean(s : BiostructmotifTable) -> Double { @_common.mean(s.data) }

pub fn bio_struct_motif_table_scale(s : BiostructmotifTable, f : Double) -> BiostructmotifTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_table_add(a : BiostructmotifTable, b : BiostructmotifTable) -> BiostructmotifTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_motif_table_copy(s : BiostructmotifTable) -> BiostructmotifTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_table_fill(s : BiostructmotifTable, v : Double) -> BiostructmotifTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_table_min(s : BiostructmotifTable) -> Double { @_common.min(s.data) }

pub fn bio_struct_motif_table_max(s : BiostructmotifTable) -> Double { @_common.max(s.data) }

pub fn bio_struct_motif_table_to_string(s : BiostructmotifTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructmotifGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_motif_graphn_make(size : Int) -> BiostructmotifGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_motif_graphn_len(s : BiostructmotifGraphN) -> Int { s.size }

pub fn bio_struct_motif_graphn_get(s : BiostructmotifGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_motif_graphn_set(s : BiostructmotifGraphN, i : Int, v : Double) -> BiostructmotifGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_graphn_sum(s : BiostructmotifGraphN) -> Double { @_common.sum(s.data) }

pub fn bio_struct_motif_graphn_mean(s : BiostructmotifGraphN) -> Double { @_common.mean(s.data) }

pub fn bio_struct_motif_graphn_scale(s : BiostructmotifGraphN, f : Double) -> BiostructmotifGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_graphn_add(a : BiostructmotifGraphN, b : BiostructmotifGraphN) -> BiostructmotifGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_motif_graphn_copy(s : BiostructmotifGraphN) -> BiostructmotifGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_graphn_fill(s : BiostructmotifGraphN, v : Double) -> BiostructmotifGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_graphn_min(s : BiostructmotifGraphN) -> Double { @_common.min(s.data) }

pub fn bio_struct_motif_graphn_max(s : BiostructmotifGraphN) -> Double { @_common.max(s.data) }

pub fn bio_struct_motif_graphn_to_string(s : BiostructmotifGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructmotifNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_motif_node_make(size : Int) -> BiostructmotifNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_motif_node_len(s : BiostructmotifNode) -> Int { s.size }

pub fn bio_struct_motif_node_get(s : BiostructmotifNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_motif_node_set(s : BiostructmotifNode, i : Int, v : Double) -> BiostructmotifNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_node_sum(s : BiostructmotifNode) -> Double { @_common.sum(s.data) }

pub fn bio_struct_motif_node_mean(s : BiostructmotifNode) -> Double { @_common.mean(s.data) }

pub fn bio_struct_motif_node_scale(s : BiostructmotifNode, f : Double) -> BiostructmotifNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_node_add(a : BiostructmotifNode, b : BiostructmotifNode) -> BiostructmotifNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_motif_node_copy(s : BiostructmotifNode) -> BiostructmotifNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_node_fill(s : BiostructmotifNode, v : Double) -> BiostructmotifNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_node_min(s : BiostructmotifNode) -> Double { @_common.min(s.data) }

pub fn bio_struct_motif_node_max(s : BiostructmotifNode) -> Double { @_common.max(s.data) }

pub fn bio_struct_motif_node_to_string(s : BiostructmotifNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructmotifEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_motif_edge_make(size : Int) -> BiostructmotifEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_motif_edge_len(s : BiostructmotifEdge) -> Int { s.size }

pub fn bio_struct_motif_edge_get(s : BiostructmotifEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_motif_edge_set(s : BiostructmotifEdge, i : Int, v : Double) -> BiostructmotifEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_edge_sum(s : BiostructmotifEdge) -> Double { @_common.sum(s.data) }

pub fn bio_struct_motif_edge_mean(s : BiostructmotifEdge) -> Double { @_common.mean(s.data) }

pub fn bio_struct_motif_edge_scale(s : BiostructmotifEdge, f : Double) -> BiostructmotifEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_edge_add(a : BiostructmotifEdge, b : BiostructmotifEdge) -> BiostructmotifEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_motif_edge_copy(s : BiostructmotifEdge) -> BiostructmotifEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_edge_fill(s : BiostructmotifEdge, v : Double) -> BiostructmotifEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_edge_min(s : BiostructmotifEdge) -> Double { @_common.min(s.data) }

pub fn bio_struct_motif_edge_max(s : BiostructmotifEdge) -> Double { @_common.max(s.data) }

pub fn bio_struct_motif_edge_to_string(s : BiostructmotifEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructmotifPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_motif_path_make(size : Int) -> BiostructmotifPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_motif_path_len(s : BiostructmotifPath) -> Int { s.size }

pub fn bio_struct_motif_path_get(s : BiostructmotifPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_motif_path_set(s : BiostructmotifPath, i : Int, v : Double) -> BiostructmotifPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_path_sum(s : BiostructmotifPath) -> Double { @_common.sum(s.data) }

pub fn bio_struct_motif_path_mean(s : BiostructmotifPath) -> Double { @_common.mean(s.data) }

pub fn bio_struct_motif_path_scale(s : BiostructmotifPath, f : Double) -> BiostructmotifPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_path_add(a : BiostructmotifPath, b : BiostructmotifPath) -> BiostructmotifPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_motif_path_copy(s : BiostructmotifPath) -> BiostructmotifPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_path_fill(s : BiostructmotifPath, v : Double) -> BiostructmotifPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_path_min(s : BiostructmotifPath) -> Double { @_common.min(s.data) }

pub fn bio_struct_motif_path_max(s : BiostructmotifPath) -> Double { @_common.max(s.data) }

pub fn bio_struct_motif_path_to_string(s : BiostructmotifPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructmotifCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_motif_cluster_make(size : Int) -> BiostructmotifCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_motif_cluster_len(s : BiostructmotifCluster) -> Int { s.size }

pub fn bio_struct_motif_cluster_get(s : BiostructmotifCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_motif_cluster_set(s : BiostructmotifCluster, i : Int, v : Double) -> BiostructmotifCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_cluster_sum(s : BiostructmotifCluster) -> Double { @_common.sum(s.data) }

pub fn bio_struct_motif_cluster_mean(s : BiostructmotifCluster) -> Double { @_common.mean(s.data) }

pub fn bio_struct_motif_cluster_scale(s : BiostructmotifCluster, f : Double) -> BiostructmotifCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_cluster_add(a : BiostructmotifCluster, b : BiostructmotifCluster) -> BiostructmotifCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_motif_cluster_copy(s : BiostructmotifCluster) -> BiostructmotifCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_cluster_fill(s : BiostructmotifCluster, v : Double) -> BiostructmotifCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_cluster_min(s : BiostructmotifCluster) -> Double { @_common.min(s.data) }

pub fn bio_struct_motif_cluster_max(s : BiostructmotifCluster) -> Double { @_common.max(s.data) }

pub fn bio_struct_motif_cluster_to_string(s : BiostructmotifCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructmotifModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_motif_model_make(size : Int) -> BiostructmotifModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_motif_model_len(s : BiostructmotifModel) -> Int { s.size }

pub fn bio_struct_motif_model_get(s : BiostructmotifModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_motif_model_set(s : BiostructmotifModel, i : Int, v : Double) -> BiostructmotifModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_model_sum(s : BiostructmotifModel) -> Double { @_common.sum(s.data) }

pub fn bio_struct_motif_model_mean(s : BiostructmotifModel) -> Double { @_common.mean(s.data) }

pub fn bio_struct_motif_model_scale(s : BiostructmotifModel, f : Double) -> BiostructmotifModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_model_add(a : BiostructmotifModel, b : BiostructmotifModel) -> BiostructmotifModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_motif_model_copy(s : BiostructmotifModel) -> BiostructmotifModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_model_fill(s : BiostructmotifModel, v : Double) -> BiostructmotifModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_model_min(s : BiostructmotifModel) -> Double { @_common.min(s.data) }

pub fn bio_struct_motif_model_max(s : BiostructmotifModel) -> Double { @_common.max(s.data) }

pub fn bio_struct_motif_model_to_string(s : BiostructmotifModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructmotifLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_motif_layer_make(size : Int) -> BiostructmotifLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_motif_layer_len(s : BiostructmotifLayer) -> Int { s.size }

pub fn bio_struct_motif_layer_get(s : BiostructmotifLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_motif_layer_set(s : BiostructmotifLayer, i : Int, v : Double) -> BiostructmotifLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_layer_sum(s : BiostructmotifLayer) -> Double { @_common.sum(s.data) }

pub fn bio_struct_motif_layer_mean(s : BiostructmotifLayer) -> Double { @_common.mean(s.data) }

pub fn bio_struct_motif_layer_scale(s : BiostructmotifLayer, f : Double) -> BiostructmotifLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_layer_add(a : BiostructmotifLayer, b : BiostructmotifLayer) -> BiostructmotifLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_motif_layer_copy(s : BiostructmotifLayer) -> BiostructmotifLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_layer_fill(s : BiostructmotifLayer, v : Double) -> BiostructmotifLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_layer_min(s : BiostructmotifLayer) -> Double { @_common.min(s.data) }

pub fn bio_struct_motif_layer_max(s : BiostructmotifLayer) -> Double { @_common.max(s.data) }

pub fn bio_struct_motif_layer_to_string(s : BiostructmotifLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructmotifBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_motif_buffer_make(size : Int) -> BiostructmotifBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_motif_buffer_len(s : BiostructmotifBuffer) -> Int { s.size }

pub fn bio_struct_motif_buffer_get(s : BiostructmotifBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_motif_buffer_set(s : BiostructmotifBuffer, i : Int, v : Double) -> BiostructmotifBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_buffer_sum(s : BiostructmotifBuffer) -> Double { @_common.sum(s.data) }

pub fn bio_struct_motif_buffer_mean(s : BiostructmotifBuffer) -> Double { @_common.mean(s.data) }

pub fn bio_struct_motif_buffer_scale(s : BiostructmotifBuffer, f : Double) -> BiostructmotifBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_buffer_add(a : BiostructmotifBuffer, b : BiostructmotifBuffer) -> BiostructmotifBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_motif_buffer_copy(s : BiostructmotifBuffer) -> BiostructmotifBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_buffer_fill(s : BiostructmotifBuffer, v : Double) -> BiostructmotifBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_buffer_min(s : BiostructmotifBuffer) -> Double { @_common.min(s.data) }

pub fn bio_struct_motif_buffer_max(s : BiostructmotifBuffer) -> Double { @_common.max(s.data) }

pub fn bio_struct_motif_buffer_to_string(s : BiostructmotifBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructmotifCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_motif_cursor_make(size : Int) -> BiostructmotifCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_motif_cursor_len(s : BiostructmotifCursor) -> Int { s.size }

pub fn bio_struct_motif_cursor_get(s : BiostructmotifCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_motif_cursor_set(s : BiostructmotifCursor, i : Int, v : Double) -> BiostructmotifCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_cursor_sum(s : BiostructmotifCursor) -> Double { @_common.sum(s.data) }

pub fn bio_struct_motif_cursor_mean(s : BiostructmotifCursor) -> Double { @_common.mean(s.data) }

pub fn bio_struct_motif_cursor_scale(s : BiostructmotifCursor, f : Double) -> BiostructmotifCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_cursor_add(a : BiostructmotifCursor, b : BiostructmotifCursor) -> BiostructmotifCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_motif_cursor_copy(s : BiostructmotifCursor) -> BiostructmotifCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_cursor_fill(s : BiostructmotifCursor, v : Double) -> BiostructmotifCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_cursor_min(s : BiostructmotifCursor) -> Double { @_common.min(s.data) }

pub fn bio_struct_motif_cursor_max(s : BiostructmotifCursor) -> Double { @_common.max(s.data) }

pub fn bio_struct_motif_cursor_to_string(s : BiostructmotifCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructmotifView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_motif_view_make(size : Int) -> BiostructmotifView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_motif_view_len(s : BiostructmotifView) -> Int { s.size }

pub fn bio_struct_motif_view_get(s : BiostructmotifView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_motif_view_set(s : BiostructmotifView, i : Int, v : Double) -> BiostructmotifView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_view_sum(s : BiostructmotifView) -> Double { @_common.sum(s.data) }

pub fn bio_struct_motif_view_mean(s : BiostructmotifView) -> Double { @_common.mean(s.data) }

pub fn bio_struct_motif_view_scale(s : BiostructmotifView, f : Double) -> BiostructmotifView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_view_add(a : BiostructmotifView, b : BiostructmotifView) -> BiostructmotifView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_motif_view_copy(s : BiostructmotifView) -> BiostructmotifView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_view_fill(s : BiostructmotifView, v : Double) -> BiostructmotifView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_view_min(s : BiostructmotifView) -> Double { @_common.min(s.data) }

pub fn bio_struct_motif_view_max(s : BiostructmotifView) -> Double { @_common.max(s.data) }

pub fn bio_struct_motif_view_to_string(s : BiostructmotifView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructmotifRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_motif_range_make(size : Int) -> BiostructmotifRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_motif_range_len(s : BiostructmotifRange) -> Int { s.size }

pub fn bio_struct_motif_range_get(s : BiostructmotifRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_motif_range_set(s : BiostructmotifRange, i : Int, v : Double) -> BiostructmotifRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_range_sum(s : BiostructmotifRange) -> Double { @_common.sum(s.data) }

pub fn bio_struct_motif_range_mean(s : BiostructmotifRange) -> Double { @_common.mean(s.data) }

pub fn bio_struct_motif_range_scale(s : BiostructmotifRange, f : Double) -> BiostructmotifRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_range_add(a : BiostructmotifRange, b : BiostructmotifRange) -> BiostructmotifRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_motif_range_copy(s : BiostructmotifRange) -> BiostructmotifRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_range_fill(s : BiostructmotifRange, v : Double) -> BiostructmotifRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_range_min(s : BiostructmotifRange) -> Double { @_common.min(s.data) }

pub fn bio_struct_motif_range_max(s : BiostructmotifRange) -> Double { @_common.max(s.data) }

pub fn bio_struct_motif_range_to_string(s : BiostructmotifRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructmotifSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_motif_slice_make(size : Int) -> BiostructmotifSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_motif_slice_len(s : BiostructmotifSlice) -> Int { s.size }

pub fn bio_struct_motif_slice_get(s : BiostructmotifSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_motif_slice_set(s : BiostructmotifSlice, i : Int, v : Double) -> BiostructmotifSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_slice_sum(s : BiostructmotifSlice) -> Double { @_common.sum(s.data) }

pub fn bio_struct_motif_slice_mean(s : BiostructmotifSlice) -> Double { @_common.mean(s.data) }

pub fn bio_struct_motif_slice_scale(s : BiostructmotifSlice, f : Double) -> BiostructmotifSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_slice_add(a : BiostructmotifSlice, b : BiostructmotifSlice) -> BiostructmotifSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_motif_slice_copy(s : BiostructmotifSlice) -> BiostructmotifSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_slice_fill(s : BiostructmotifSlice, v : Double) -> BiostructmotifSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_motif_slice_min(s : BiostructmotifSlice) -> Double { @_common.min(s.data) }

pub fn bio_struct_motif_slice_max(s : BiostructmotifSlice) -> Double { @_common.max(s.data) }

pub fn bio_struct_motif_slice_to_string(s : BiostructmotifSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


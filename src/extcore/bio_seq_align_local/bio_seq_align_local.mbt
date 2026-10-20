///===
/// extcore/bio_seq_align_local

pub(all) struct BioseqalignlocalPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn bio_seq_align_local_make_point(x : Double, y : Double) -> BioseqalignlocalPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn bio_seq_align_local_make_point3(x : Double, y : Double, z : Double) -> BioseqalignlocalPoint {
  { x, y, z, label: 0 }
}

pub fn bio_seq_align_local_point_x(pt : BioseqalignlocalPoint) -> Double { pt.x }

pub fn bio_seq_align_local_point_y(pt : BioseqalignlocalPoint) -> Double { pt.y }

pub fn bio_seq_align_local_point_z(pt : BioseqalignlocalPoint) -> Double { pt.z }

pub fn bio_seq_align_local_point_label(pt : BioseqalignlocalPoint) -> Int { pt.label }

pub fn bio_seq_align_local_point_dist(a : BioseqalignlocalPoint, b : BioseqalignlocalPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn bio_seq_align_local_point_add(a : BioseqalignlocalPoint, b : BioseqalignlocalPoint) -> BioseqalignlocalPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn bio_seq_align_local_point_sub(a : BioseqalignlocalPoint, b : BioseqalignlocalPoint) -> BioseqalignlocalPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn bio_seq_align_local_point_scale(pt : BioseqalignlocalPoint, s : Double) -> BioseqalignlocalPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn bio_seq_align_local_point_dot(a : BioseqalignlocalPoint, b : BioseqalignlocalPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn bio_seq_align_local_point_cross(a : BioseqalignlocalPoint, b : BioseqalignlocalPoint) -> BioseqalignlocalPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn bio_seq_align_local_point_norm(pt : BioseqalignlocalPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn bio_seq_align_local_point_normalize(pt : BioseqalignlocalPoint) -> BioseqalignlocalPoint {
  let n = bio_seq_align_local_point_norm(pt)
  if n < 0.0000001 { pt } else { bio_seq_align_local_point_scale(pt, 1.0 / n) }
}

pub fn bio_seq_align_local_point_negate(pt : BioseqalignlocalPoint) -> BioseqalignlocalPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn bio_seq_align_local_point_mid(a : BioseqalignlocalPoint, b : BioseqalignlocalPoint) -> BioseqalignlocalPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn bio_seq_align_local_point_lerp(a : BioseqalignlocalPoint, b : BioseqalignlocalPoint, t : Double) -> BioseqalignlocalPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn bio_seq_align_local_point_to_string(pt : BioseqalignlocalPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct BioseqalignlocalSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn bio_seq_align_local_make_series(vals : Array[Double], name : String) -> BioseqalignlocalSeries {
  { vals, name, meta: 0 }
}

pub fn bio_seq_align_local_series_len(s : BioseqalignlocalSeries) -> Int { s.vals.length() }

pub fn bio_seq_align_local_series_sum(s : BioseqalignlocalSeries) -> Double { @_common.sum(s.vals) }

pub fn bio_seq_align_local_series_mean(s : BioseqalignlocalSeries) -> Double { @_common.mean(s.vals) }

pub fn bio_seq_align_local_series_min(s : BioseqalignlocalSeries) -> Double { @_common.min(s.vals) }

pub fn bio_seq_align_local_series_max(s : BioseqalignlocalSeries) -> Double { @_common.max(s.vals) }

pub fn bio_seq_align_local_series_range(s : BioseqalignlocalSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn bio_seq_align_local_series_var(s : BioseqalignlocalSeries) -> Double { @_common.variance(s.vals) }

pub fn bio_seq_align_local_series_std(s : BioseqalignlocalSeries) -> Double { @_common.std(s.vals) }

pub fn bio_seq_align_local_series_median(s : BioseqalignlocalSeries) -> Double { @_common.median(s.vals) }

pub fn bio_seq_align_local_series_scale(s : BioseqalignlocalSeries, f : Double) -> BioseqalignlocalSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn bio_seq_align_local_series_add(a : BioseqalignlocalSeries, b : BioseqalignlocalSeries) -> BioseqalignlocalSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn bio_seq_align_local_series_sub(a : BioseqalignlocalSeries, b : BioseqalignlocalSeries) -> BioseqalignlocalSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn bio_seq_align_local_series_normalize(s : BioseqalignlocalSeries) -> BioseqalignlocalSeries {
  let mn = bio_seq_align_local_series_min(s)
  let mx = bio_seq_align_local_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn bio_seq_align_local_series_cumsum(s : BioseqalignlocalSeries) -> BioseqalignlocalSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn bio_seq_align_local_series_to_string(s : BioseqalignlocalSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BioseqalignlocalMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn bio_seq_align_local_make_matrix(rows : Int, cols : Int, val : Double) -> BioseqalignlocalMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn bio_seq_align_local_matrix_identity(n : Int) -> BioseqalignlocalMatrix {
  let m = bio_seq_align_local_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn bio_seq_align_local_matrix_get(m : BioseqalignlocalMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn bio_seq_align_local_matrix_transpose(m : BioseqalignlocalMatrix) -> BioseqalignlocalMatrix {
  let result = bio_seq_align_local_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn bio_seq_align_local_matrix_add(a : BioseqalignlocalMatrix, b : BioseqalignlocalMatrix) -> BioseqalignlocalMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = bio_seq_align_local_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn bio_seq_align_local_matrix_scale(m : BioseqalignlocalMatrix, s : Double) -> BioseqalignlocalMatrix {
  let result = bio_seq_align_local_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn bio_seq_align_local_matrix_multiply(a : BioseqalignlocalMatrix, b : BioseqalignlocalMatrix) -> BioseqalignlocalMatrix {
  if a.cols != b.rows { return bio_seq_align_local_make_matrix(a.rows, b.cols, 0.0) }
  let result = bio_seq_align_local_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn bio_seq_align_local_matrix_trace(m : BioseqalignlocalMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn bio_seq_align_local_matrix_det(m : BioseqalignlocalMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn bio_seq_align_local_matrix_norm(m : BioseqalignlocalMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn bio_seq_align_local_matrix_to_string(m : BioseqalignlocalMatrix) -> String {
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

pub(all) struct BioseqalignlocalVector {
  comps : Array[Double]
  dim : Int
}

pub fn bio_seq_align_local_make_vector(comps : Array[Double]) -> BioseqalignlocalVector {
  { comps, dim: comps.length() }
}

pub fn bio_seq_align_local_vector_zero(dim : Int) -> BioseqalignlocalVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn bio_seq_align_local_vector_add(a : BioseqalignlocalVector, b : BioseqalignlocalVector) -> BioseqalignlocalVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn bio_seq_align_local_vector_sub(a : BioseqalignlocalVector, b : BioseqalignlocalVector) -> BioseqalignlocalVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn bio_seq_align_local_vector_scale(v : BioseqalignlocalVector, s : Double) -> BioseqalignlocalVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn bio_seq_align_local_vector_dot(a : BioseqalignlocalVector, b : BioseqalignlocalVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn bio_seq_align_local_vector_norm(v : BioseqalignlocalVector) -> Double { @_common.sqrt(bio_seq_align_local_vector_dot(v, v)) }

pub fn bio_seq_align_local_vector_normalize(v : BioseqalignlocalVector) -> BioseqalignlocalVector {
  let n = bio_seq_align_local_vector_norm(v)
  if n < 0.0000001 { v } else { bio_seq_align_local_vector_scale(v, 1.0 / n) }
}

pub fn bio_seq_align_local_vector_dist(a : BioseqalignlocalVector, b : BioseqalignlocalVector) -> Double {
  bio_seq_align_local_vector_norm(bio_seq_align_local_vector_sub(a, b))
}

pub fn bio_seq_align_local_vector_to_string(v : BioseqalignlocalVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn bio_seq_align_local_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn bio_seq_align_local_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn bio_seq_align_local_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn bio_seq_align_local_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn bio_seq_align_local_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn bio_seq_align_local_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn bio_seq_align_local_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn bio_seq_align_local_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn bio_seq_align_local_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn bio_seq_align_local_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn bio_seq_align_local_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn bio_seq_align_local_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn bio_seq_align_local_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn bio_seq_align_local_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn bio_seq_align_local_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn bio_seq_align_local_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn bio_seq_align_local_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn bio_seq_align_local_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn bio_seq_align_local_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn bio_seq_align_local_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn bio_seq_align_local_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn bio_seq_align_local_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn bio_seq_align_local_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn bio_seq_align_local_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn bio_seq_align_local_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn bio_seq_align_local_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn bio_seq_align_local_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn bio_seq_align_local_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn bio_seq_align_local_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct BioseqalignlocalFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_local_frame_make(size : Int) -> BioseqalignlocalFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_local_frame_len(s : BioseqalignlocalFrame) -> Int { s.size }

pub fn bio_seq_align_local_frame_get(s : BioseqalignlocalFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_local_frame_set(s : BioseqalignlocalFrame, i : Int, v : Double) -> BioseqalignlocalFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_frame_sum(s : BioseqalignlocalFrame) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_local_frame_mean(s : BioseqalignlocalFrame) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_local_frame_scale(s : BioseqalignlocalFrame, f : Double) -> BioseqalignlocalFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_frame_add(a : BioseqalignlocalFrame, b : BioseqalignlocalFrame) -> BioseqalignlocalFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_local_frame_copy(s : BioseqalignlocalFrame) -> BioseqalignlocalFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_frame_fill(s : BioseqalignlocalFrame, v : Double) -> BioseqalignlocalFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_frame_min(s : BioseqalignlocalFrame) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_local_frame_max(s : BioseqalignlocalFrame) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_local_frame_to_string(s : BioseqalignlocalFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignlocalTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_local_table_make(size : Int) -> BioseqalignlocalTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_local_table_len(s : BioseqalignlocalTable) -> Int { s.size }

pub fn bio_seq_align_local_table_get(s : BioseqalignlocalTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_local_table_set(s : BioseqalignlocalTable, i : Int, v : Double) -> BioseqalignlocalTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_table_sum(s : BioseqalignlocalTable) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_local_table_mean(s : BioseqalignlocalTable) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_local_table_scale(s : BioseqalignlocalTable, f : Double) -> BioseqalignlocalTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_table_add(a : BioseqalignlocalTable, b : BioseqalignlocalTable) -> BioseqalignlocalTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_local_table_copy(s : BioseqalignlocalTable) -> BioseqalignlocalTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_table_fill(s : BioseqalignlocalTable, v : Double) -> BioseqalignlocalTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_table_min(s : BioseqalignlocalTable) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_local_table_max(s : BioseqalignlocalTable) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_local_table_to_string(s : BioseqalignlocalTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignlocalGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_local_graphn_make(size : Int) -> BioseqalignlocalGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_local_graphn_len(s : BioseqalignlocalGraphN) -> Int { s.size }

pub fn bio_seq_align_local_graphn_get(s : BioseqalignlocalGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_local_graphn_set(s : BioseqalignlocalGraphN, i : Int, v : Double) -> BioseqalignlocalGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_graphn_sum(s : BioseqalignlocalGraphN) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_local_graphn_mean(s : BioseqalignlocalGraphN) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_local_graphn_scale(s : BioseqalignlocalGraphN, f : Double) -> BioseqalignlocalGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_graphn_add(a : BioseqalignlocalGraphN, b : BioseqalignlocalGraphN) -> BioseqalignlocalGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_local_graphn_copy(s : BioseqalignlocalGraphN) -> BioseqalignlocalGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_graphn_fill(s : BioseqalignlocalGraphN, v : Double) -> BioseqalignlocalGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_graphn_min(s : BioseqalignlocalGraphN) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_local_graphn_max(s : BioseqalignlocalGraphN) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_local_graphn_to_string(s : BioseqalignlocalGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignlocalNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_local_node_make(size : Int) -> BioseqalignlocalNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_local_node_len(s : BioseqalignlocalNode) -> Int { s.size }

pub fn bio_seq_align_local_node_get(s : BioseqalignlocalNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_local_node_set(s : BioseqalignlocalNode, i : Int, v : Double) -> BioseqalignlocalNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_node_sum(s : BioseqalignlocalNode) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_local_node_mean(s : BioseqalignlocalNode) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_local_node_scale(s : BioseqalignlocalNode, f : Double) -> BioseqalignlocalNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_node_add(a : BioseqalignlocalNode, b : BioseqalignlocalNode) -> BioseqalignlocalNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_local_node_copy(s : BioseqalignlocalNode) -> BioseqalignlocalNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_node_fill(s : BioseqalignlocalNode, v : Double) -> BioseqalignlocalNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_node_min(s : BioseqalignlocalNode) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_local_node_max(s : BioseqalignlocalNode) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_local_node_to_string(s : BioseqalignlocalNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignlocalEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_local_edge_make(size : Int) -> BioseqalignlocalEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_local_edge_len(s : BioseqalignlocalEdge) -> Int { s.size }

pub fn bio_seq_align_local_edge_get(s : BioseqalignlocalEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_local_edge_set(s : BioseqalignlocalEdge, i : Int, v : Double) -> BioseqalignlocalEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_edge_sum(s : BioseqalignlocalEdge) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_local_edge_mean(s : BioseqalignlocalEdge) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_local_edge_scale(s : BioseqalignlocalEdge, f : Double) -> BioseqalignlocalEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_edge_add(a : BioseqalignlocalEdge, b : BioseqalignlocalEdge) -> BioseqalignlocalEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_local_edge_copy(s : BioseqalignlocalEdge) -> BioseqalignlocalEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_edge_fill(s : BioseqalignlocalEdge, v : Double) -> BioseqalignlocalEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_edge_min(s : BioseqalignlocalEdge) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_local_edge_max(s : BioseqalignlocalEdge) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_local_edge_to_string(s : BioseqalignlocalEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignlocalPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_local_path_make(size : Int) -> BioseqalignlocalPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_local_path_len(s : BioseqalignlocalPath) -> Int { s.size }

pub fn bio_seq_align_local_path_get(s : BioseqalignlocalPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_local_path_set(s : BioseqalignlocalPath, i : Int, v : Double) -> BioseqalignlocalPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_path_sum(s : BioseqalignlocalPath) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_local_path_mean(s : BioseqalignlocalPath) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_local_path_scale(s : BioseqalignlocalPath, f : Double) -> BioseqalignlocalPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_path_add(a : BioseqalignlocalPath, b : BioseqalignlocalPath) -> BioseqalignlocalPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_local_path_copy(s : BioseqalignlocalPath) -> BioseqalignlocalPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_path_fill(s : BioseqalignlocalPath, v : Double) -> BioseqalignlocalPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_path_min(s : BioseqalignlocalPath) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_local_path_max(s : BioseqalignlocalPath) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_local_path_to_string(s : BioseqalignlocalPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignlocalCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_local_cluster_make(size : Int) -> BioseqalignlocalCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_local_cluster_len(s : BioseqalignlocalCluster) -> Int { s.size }

pub fn bio_seq_align_local_cluster_get(s : BioseqalignlocalCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_local_cluster_set(s : BioseqalignlocalCluster, i : Int, v : Double) -> BioseqalignlocalCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_cluster_sum(s : BioseqalignlocalCluster) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_local_cluster_mean(s : BioseqalignlocalCluster) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_local_cluster_scale(s : BioseqalignlocalCluster, f : Double) -> BioseqalignlocalCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_cluster_add(a : BioseqalignlocalCluster, b : BioseqalignlocalCluster) -> BioseqalignlocalCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_local_cluster_copy(s : BioseqalignlocalCluster) -> BioseqalignlocalCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_cluster_fill(s : BioseqalignlocalCluster, v : Double) -> BioseqalignlocalCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_cluster_min(s : BioseqalignlocalCluster) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_local_cluster_max(s : BioseqalignlocalCluster) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_local_cluster_to_string(s : BioseqalignlocalCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignlocalModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_local_model_make(size : Int) -> BioseqalignlocalModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_local_model_len(s : BioseqalignlocalModel) -> Int { s.size }

pub fn bio_seq_align_local_model_get(s : BioseqalignlocalModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_local_model_set(s : BioseqalignlocalModel, i : Int, v : Double) -> BioseqalignlocalModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_model_sum(s : BioseqalignlocalModel) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_local_model_mean(s : BioseqalignlocalModel) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_local_model_scale(s : BioseqalignlocalModel, f : Double) -> BioseqalignlocalModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_model_add(a : BioseqalignlocalModel, b : BioseqalignlocalModel) -> BioseqalignlocalModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_local_model_copy(s : BioseqalignlocalModel) -> BioseqalignlocalModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_model_fill(s : BioseqalignlocalModel, v : Double) -> BioseqalignlocalModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_model_min(s : BioseqalignlocalModel) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_local_model_max(s : BioseqalignlocalModel) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_local_model_to_string(s : BioseqalignlocalModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignlocalLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_local_layer_make(size : Int) -> BioseqalignlocalLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_local_layer_len(s : BioseqalignlocalLayer) -> Int { s.size }

pub fn bio_seq_align_local_layer_get(s : BioseqalignlocalLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_local_layer_set(s : BioseqalignlocalLayer, i : Int, v : Double) -> BioseqalignlocalLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_layer_sum(s : BioseqalignlocalLayer) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_local_layer_mean(s : BioseqalignlocalLayer) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_local_layer_scale(s : BioseqalignlocalLayer, f : Double) -> BioseqalignlocalLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_layer_add(a : BioseqalignlocalLayer, b : BioseqalignlocalLayer) -> BioseqalignlocalLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_local_layer_copy(s : BioseqalignlocalLayer) -> BioseqalignlocalLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_layer_fill(s : BioseqalignlocalLayer, v : Double) -> BioseqalignlocalLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_layer_min(s : BioseqalignlocalLayer) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_local_layer_max(s : BioseqalignlocalLayer) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_local_layer_to_string(s : BioseqalignlocalLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignlocalBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_local_buffer_make(size : Int) -> BioseqalignlocalBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_local_buffer_len(s : BioseqalignlocalBuffer) -> Int { s.size }

pub fn bio_seq_align_local_buffer_get(s : BioseqalignlocalBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_local_buffer_set(s : BioseqalignlocalBuffer, i : Int, v : Double) -> BioseqalignlocalBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_buffer_sum(s : BioseqalignlocalBuffer) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_local_buffer_mean(s : BioseqalignlocalBuffer) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_local_buffer_scale(s : BioseqalignlocalBuffer, f : Double) -> BioseqalignlocalBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_buffer_add(a : BioseqalignlocalBuffer, b : BioseqalignlocalBuffer) -> BioseqalignlocalBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_local_buffer_copy(s : BioseqalignlocalBuffer) -> BioseqalignlocalBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_buffer_fill(s : BioseqalignlocalBuffer, v : Double) -> BioseqalignlocalBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_buffer_min(s : BioseqalignlocalBuffer) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_local_buffer_max(s : BioseqalignlocalBuffer) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_local_buffer_to_string(s : BioseqalignlocalBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignlocalCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_local_cursor_make(size : Int) -> BioseqalignlocalCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_local_cursor_len(s : BioseqalignlocalCursor) -> Int { s.size }

pub fn bio_seq_align_local_cursor_get(s : BioseqalignlocalCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_local_cursor_set(s : BioseqalignlocalCursor, i : Int, v : Double) -> BioseqalignlocalCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_cursor_sum(s : BioseqalignlocalCursor) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_local_cursor_mean(s : BioseqalignlocalCursor) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_local_cursor_scale(s : BioseqalignlocalCursor, f : Double) -> BioseqalignlocalCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_cursor_add(a : BioseqalignlocalCursor, b : BioseqalignlocalCursor) -> BioseqalignlocalCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_local_cursor_copy(s : BioseqalignlocalCursor) -> BioseqalignlocalCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_cursor_fill(s : BioseqalignlocalCursor, v : Double) -> BioseqalignlocalCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_cursor_min(s : BioseqalignlocalCursor) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_local_cursor_max(s : BioseqalignlocalCursor) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_local_cursor_to_string(s : BioseqalignlocalCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignlocalView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_local_view_make(size : Int) -> BioseqalignlocalView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_local_view_len(s : BioseqalignlocalView) -> Int { s.size }

pub fn bio_seq_align_local_view_get(s : BioseqalignlocalView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_local_view_set(s : BioseqalignlocalView, i : Int, v : Double) -> BioseqalignlocalView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_view_sum(s : BioseqalignlocalView) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_local_view_mean(s : BioseqalignlocalView) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_local_view_scale(s : BioseqalignlocalView, f : Double) -> BioseqalignlocalView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_view_add(a : BioseqalignlocalView, b : BioseqalignlocalView) -> BioseqalignlocalView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_local_view_copy(s : BioseqalignlocalView) -> BioseqalignlocalView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_view_fill(s : BioseqalignlocalView, v : Double) -> BioseqalignlocalView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_view_min(s : BioseqalignlocalView) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_local_view_max(s : BioseqalignlocalView) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_local_view_to_string(s : BioseqalignlocalView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignlocalRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_local_range_make(size : Int) -> BioseqalignlocalRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_local_range_len(s : BioseqalignlocalRange) -> Int { s.size }

pub fn bio_seq_align_local_range_get(s : BioseqalignlocalRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_local_range_set(s : BioseqalignlocalRange, i : Int, v : Double) -> BioseqalignlocalRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_range_sum(s : BioseqalignlocalRange) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_local_range_mean(s : BioseqalignlocalRange) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_local_range_scale(s : BioseqalignlocalRange, f : Double) -> BioseqalignlocalRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_range_add(a : BioseqalignlocalRange, b : BioseqalignlocalRange) -> BioseqalignlocalRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_local_range_copy(s : BioseqalignlocalRange) -> BioseqalignlocalRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_range_fill(s : BioseqalignlocalRange, v : Double) -> BioseqalignlocalRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_range_min(s : BioseqalignlocalRange) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_local_range_max(s : BioseqalignlocalRange) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_local_range_to_string(s : BioseqalignlocalRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignlocalSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_local_slice_make(size : Int) -> BioseqalignlocalSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_local_slice_len(s : BioseqalignlocalSlice) -> Int { s.size }

pub fn bio_seq_align_local_slice_get(s : BioseqalignlocalSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_local_slice_set(s : BioseqalignlocalSlice, i : Int, v : Double) -> BioseqalignlocalSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_slice_sum(s : BioseqalignlocalSlice) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_local_slice_mean(s : BioseqalignlocalSlice) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_local_slice_scale(s : BioseqalignlocalSlice, f : Double) -> BioseqalignlocalSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_slice_add(a : BioseqalignlocalSlice, b : BioseqalignlocalSlice) -> BioseqalignlocalSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_local_slice_copy(s : BioseqalignlocalSlice) -> BioseqalignlocalSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_slice_fill(s : BioseqalignlocalSlice, v : Double) -> BioseqalignlocalSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_slice_min(s : BioseqalignlocalSlice) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_local_slice_max(s : BioseqalignlocalSlice) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_local_slice_to_string(s : BioseqalignlocalSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


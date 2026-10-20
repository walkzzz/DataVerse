///===
/// extcore/bio_seq_align_multiple

pub(all) struct BioseqalignmultiplePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn bio_seq_align_multiple_make_point(x : Double, y : Double) -> BioseqalignmultiplePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn bio_seq_align_multiple_make_point3(x : Double, y : Double, z : Double) -> BioseqalignmultiplePoint {
  { x, y, z, label: 0 }
}

pub fn bio_seq_align_multiple_point_x(pt : BioseqalignmultiplePoint) -> Double { pt.x }

pub fn bio_seq_align_multiple_point_y(pt : BioseqalignmultiplePoint) -> Double { pt.y }

pub fn bio_seq_align_multiple_point_z(pt : BioseqalignmultiplePoint) -> Double { pt.z }

pub fn bio_seq_align_multiple_point_label(pt : BioseqalignmultiplePoint) -> Int { pt.label }

pub fn bio_seq_align_multiple_point_dist(a : BioseqalignmultiplePoint, b : BioseqalignmultiplePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn bio_seq_align_multiple_point_add(a : BioseqalignmultiplePoint, b : BioseqalignmultiplePoint) -> BioseqalignmultiplePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn bio_seq_align_multiple_point_sub(a : BioseqalignmultiplePoint, b : BioseqalignmultiplePoint) -> BioseqalignmultiplePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn bio_seq_align_multiple_point_scale(pt : BioseqalignmultiplePoint, s : Double) -> BioseqalignmultiplePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn bio_seq_align_multiple_point_dot(a : BioseqalignmultiplePoint, b : BioseqalignmultiplePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn bio_seq_align_multiple_point_cross(a : BioseqalignmultiplePoint, b : BioseqalignmultiplePoint) -> BioseqalignmultiplePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn bio_seq_align_multiple_point_norm(pt : BioseqalignmultiplePoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn bio_seq_align_multiple_point_normalize(pt : BioseqalignmultiplePoint) -> BioseqalignmultiplePoint {
  let n = bio_seq_align_multiple_point_norm(pt)
  if n < 0.0000001 { pt } else { bio_seq_align_multiple_point_scale(pt, 1.0 / n) }
}

pub fn bio_seq_align_multiple_point_negate(pt : BioseqalignmultiplePoint) -> BioseqalignmultiplePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn bio_seq_align_multiple_point_mid(a : BioseqalignmultiplePoint, b : BioseqalignmultiplePoint) -> BioseqalignmultiplePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn bio_seq_align_multiple_point_lerp(a : BioseqalignmultiplePoint, b : BioseqalignmultiplePoint, t : Double) -> BioseqalignmultiplePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn bio_seq_align_multiple_point_to_string(pt : BioseqalignmultiplePoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct BioseqalignmultipleSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn bio_seq_align_multiple_make_series(vals : Array[Double], name : String) -> BioseqalignmultipleSeries {
  { vals, name, meta: 0 }
}

pub fn bio_seq_align_multiple_series_len(s : BioseqalignmultipleSeries) -> Int { s.vals.length() }

pub fn bio_seq_align_multiple_series_sum(s : BioseqalignmultipleSeries) -> Double { @_common.sum(s.vals) }

pub fn bio_seq_align_multiple_series_mean(s : BioseqalignmultipleSeries) -> Double { @_common.mean(s.vals) }

pub fn bio_seq_align_multiple_series_min(s : BioseqalignmultipleSeries) -> Double { @_common.min(s.vals) }

pub fn bio_seq_align_multiple_series_max(s : BioseqalignmultipleSeries) -> Double { @_common.max(s.vals) }

pub fn bio_seq_align_multiple_series_range(s : BioseqalignmultipleSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn bio_seq_align_multiple_series_var(s : BioseqalignmultipleSeries) -> Double { @_common.variance(s.vals) }

pub fn bio_seq_align_multiple_series_std(s : BioseqalignmultipleSeries) -> Double { @_common.std(s.vals) }

pub fn bio_seq_align_multiple_series_median(s : BioseqalignmultipleSeries) -> Double { @_common.median(s.vals) }

pub fn bio_seq_align_multiple_series_scale(s : BioseqalignmultipleSeries, f : Double) -> BioseqalignmultipleSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn bio_seq_align_multiple_series_add(a : BioseqalignmultipleSeries, b : BioseqalignmultipleSeries) -> BioseqalignmultipleSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn bio_seq_align_multiple_series_sub(a : BioseqalignmultipleSeries, b : BioseqalignmultipleSeries) -> BioseqalignmultipleSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn bio_seq_align_multiple_series_normalize(s : BioseqalignmultipleSeries) -> BioseqalignmultipleSeries {
  let mn = bio_seq_align_multiple_series_min(s)
  let mx = bio_seq_align_multiple_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn bio_seq_align_multiple_series_cumsum(s : BioseqalignmultipleSeries) -> BioseqalignmultipleSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn bio_seq_align_multiple_series_to_string(s : BioseqalignmultipleSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BioseqalignmultipleMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn bio_seq_align_multiple_make_matrix(rows : Int, cols : Int, val : Double) -> BioseqalignmultipleMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn bio_seq_align_multiple_matrix_identity(n : Int) -> BioseqalignmultipleMatrix {
  let m = bio_seq_align_multiple_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn bio_seq_align_multiple_matrix_get(m : BioseqalignmultipleMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn bio_seq_align_multiple_matrix_transpose(m : BioseqalignmultipleMatrix) -> BioseqalignmultipleMatrix {
  let result = bio_seq_align_multiple_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn bio_seq_align_multiple_matrix_add(a : BioseqalignmultipleMatrix, b : BioseqalignmultipleMatrix) -> BioseqalignmultipleMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = bio_seq_align_multiple_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn bio_seq_align_multiple_matrix_scale(m : BioseqalignmultipleMatrix, s : Double) -> BioseqalignmultipleMatrix {
  let result = bio_seq_align_multiple_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn bio_seq_align_multiple_matrix_multiply(a : BioseqalignmultipleMatrix, b : BioseqalignmultipleMatrix) -> BioseqalignmultipleMatrix {
  if a.cols != b.rows { return bio_seq_align_multiple_make_matrix(a.rows, b.cols, 0.0) }
  let result = bio_seq_align_multiple_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn bio_seq_align_multiple_matrix_trace(m : BioseqalignmultipleMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn bio_seq_align_multiple_matrix_det(m : BioseqalignmultipleMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn bio_seq_align_multiple_matrix_norm(m : BioseqalignmultipleMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn bio_seq_align_multiple_matrix_to_string(m : BioseqalignmultipleMatrix) -> String {
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

pub(all) struct BioseqalignmultipleVector {
  comps : Array[Double]
  dim : Int
}

pub fn bio_seq_align_multiple_make_vector(comps : Array[Double]) -> BioseqalignmultipleVector {
  { comps, dim: comps.length() }
}

pub fn bio_seq_align_multiple_vector_zero(dim : Int) -> BioseqalignmultipleVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn bio_seq_align_multiple_vector_add(a : BioseqalignmultipleVector, b : BioseqalignmultipleVector) -> BioseqalignmultipleVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn bio_seq_align_multiple_vector_sub(a : BioseqalignmultipleVector, b : BioseqalignmultipleVector) -> BioseqalignmultipleVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn bio_seq_align_multiple_vector_scale(v : BioseqalignmultipleVector, s : Double) -> BioseqalignmultipleVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn bio_seq_align_multiple_vector_dot(a : BioseqalignmultipleVector, b : BioseqalignmultipleVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn bio_seq_align_multiple_vector_norm(v : BioseqalignmultipleVector) -> Double { @_common.sqrt(bio_seq_align_multiple_vector_dot(v, v)) }

pub fn bio_seq_align_multiple_vector_normalize(v : BioseqalignmultipleVector) -> BioseqalignmultipleVector {
  let n = bio_seq_align_multiple_vector_norm(v)
  if n < 0.0000001 { v } else { bio_seq_align_multiple_vector_scale(v, 1.0 / n) }
}

pub fn bio_seq_align_multiple_vector_dist(a : BioseqalignmultipleVector, b : BioseqalignmultipleVector) -> Double {
  bio_seq_align_multiple_vector_norm(bio_seq_align_multiple_vector_sub(a, b))
}

pub fn bio_seq_align_multiple_vector_to_string(v : BioseqalignmultipleVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn bio_seq_align_multiple_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn bio_seq_align_multiple_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn bio_seq_align_multiple_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn bio_seq_align_multiple_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn bio_seq_align_multiple_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn bio_seq_align_multiple_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn bio_seq_align_multiple_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn bio_seq_align_multiple_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn bio_seq_align_multiple_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn bio_seq_align_multiple_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn bio_seq_align_multiple_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn bio_seq_align_multiple_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn bio_seq_align_multiple_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn bio_seq_align_multiple_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn bio_seq_align_multiple_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn bio_seq_align_multiple_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn bio_seq_align_multiple_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn bio_seq_align_multiple_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn bio_seq_align_multiple_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn bio_seq_align_multiple_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn bio_seq_align_multiple_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn bio_seq_align_multiple_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn bio_seq_align_multiple_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn bio_seq_align_multiple_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn bio_seq_align_multiple_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn bio_seq_align_multiple_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn bio_seq_align_multiple_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn bio_seq_align_multiple_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn bio_seq_align_multiple_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct BioseqalignmultipleFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_multiple_frame_make(size : Int) -> BioseqalignmultipleFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_multiple_frame_len(s : BioseqalignmultipleFrame) -> Int { s.size }

pub fn bio_seq_align_multiple_frame_get(s : BioseqalignmultipleFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_multiple_frame_set(s : BioseqalignmultipleFrame, i : Int, v : Double) -> BioseqalignmultipleFrame {
  let result = bio_seq_align_multiple_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_multiple_frame_sum(s : BioseqalignmultipleFrame) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_multiple_frame_mean(s : BioseqalignmultipleFrame) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_multiple_frame_scale(s : BioseqalignmultipleFrame, f : Double) -> BioseqalignmultipleFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_multiple_frame_add(a : BioseqalignmultipleFrame, b : BioseqalignmultipleFrame) -> BioseqalignmultipleFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_multiple_frame_copy(s : BioseqalignmultipleFrame) -> BioseqalignmultipleFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_multiple_frame_fill(s : BioseqalignmultipleFrame, v : Double) -> BioseqalignmultipleFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_multiple_frame_min(s : BioseqalignmultipleFrame) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_multiple_frame_max(s : BioseqalignmultipleFrame) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_multiple_frame_to_string(s : BioseqalignmultipleFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignmultipleTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_multiple_table_make(size : Int) -> BioseqalignmultipleTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_multiple_table_len(s : BioseqalignmultipleTable) -> Int { s.size }

pub fn bio_seq_align_multiple_table_get(s : BioseqalignmultipleTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_multiple_table_set(s : BioseqalignmultipleTable, i : Int, v : Double) -> BioseqalignmultipleTable {
  let result = bio_seq_align_multiple_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_multiple_table_sum(s : BioseqalignmultipleTable) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_multiple_table_mean(s : BioseqalignmultipleTable) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_multiple_table_scale(s : BioseqalignmultipleTable, f : Double) -> BioseqalignmultipleTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_multiple_table_add(a : BioseqalignmultipleTable, b : BioseqalignmultipleTable) -> BioseqalignmultipleTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_multiple_table_copy(s : BioseqalignmultipleTable) -> BioseqalignmultipleTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_multiple_table_fill(s : BioseqalignmultipleTable, v : Double) -> BioseqalignmultipleTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_multiple_table_min(s : BioseqalignmultipleTable) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_multiple_table_max(s : BioseqalignmultipleTable) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_multiple_table_to_string(s : BioseqalignmultipleTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignmultipleGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_multiple_graphn_make(size : Int) -> BioseqalignmultipleGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_multiple_graphn_len(s : BioseqalignmultipleGraphN) -> Int { s.size }

pub fn bio_seq_align_multiple_graphn_get(s : BioseqalignmultipleGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_multiple_graphn_set(s : BioseqalignmultipleGraphN, i : Int, v : Double) -> BioseqalignmultipleGraphN {
  let result = bio_seq_align_multiple_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_multiple_graphn_sum(s : BioseqalignmultipleGraphN) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_multiple_graphn_mean(s : BioseqalignmultipleGraphN) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_multiple_graphn_scale(s : BioseqalignmultipleGraphN, f : Double) -> BioseqalignmultipleGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_multiple_graphn_add(a : BioseqalignmultipleGraphN, b : BioseqalignmultipleGraphN) -> BioseqalignmultipleGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_multiple_graphn_copy(s : BioseqalignmultipleGraphN) -> BioseqalignmultipleGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_multiple_graphn_fill(s : BioseqalignmultipleGraphN, v : Double) -> BioseqalignmultipleGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_multiple_graphn_min(s : BioseqalignmultipleGraphN) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_multiple_graphn_max(s : BioseqalignmultipleGraphN) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_multiple_graphn_to_string(s : BioseqalignmultipleGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignmultipleNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_multiple_node_make(size : Int) -> BioseqalignmultipleNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_multiple_node_len(s : BioseqalignmultipleNode) -> Int { s.size }

pub fn bio_seq_align_multiple_node_get(s : BioseqalignmultipleNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_multiple_node_set(s : BioseqalignmultipleNode, i : Int, v : Double) -> BioseqalignmultipleNode {
  let result = bio_seq_align_multiple_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_multiple_node_sum(s : BioseqalignmultipleNode) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_multiple_node_mean(s : BioseqalignmultipleNode) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_multiple_node_scale(s : BioseqalignmultipleNode, f : Double) -> BioseqalignmultipleNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_multiple_node_add(a : BioseqalignmultipleNode, b : BioseqalignmultipleNode) -> BioseqalignmultipleNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_multiple_node_copy(s : BioseqalignmultipleNode) -> BioseqalignmultipleNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_multiple_node_fill(s : BioseqalignmultipleNode, v : Double) -> BioseqalignmultipleNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_multiple_node_min(s : BioseqalignmultipleNode) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_multiple_node_max(s : BioseqalignmultipleNode) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_multiple_node_to_string(s : BioseqalignmultipleNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignmultipleEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_multiple_edge_make(size : Int) -> BioseqalignmultipleEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_multiple_edge_len(s : BioseqalignmultipleEdge) -> Int { s.size }

pub fn bio_seq_align_multiple_edge_get(s : BioseqalignmultipleEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_multiple_edge_set(s : BioseqalignmultipleEdge, i : Int, v : Double) -> BioseqalignmultipleEdge {
  let result = bio_seq_align_multiple_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_multiple_edge_sum(s : BioseqalignmultipleEdge) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_multiple_edge_mean(s : BioseqalignmultipleEdge) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_multiple_edge_scale(s : BioseqalignmultipleEdge, f : Double) -> BioseqalignmultipleEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_multiple_edge_add(a : BioseqalignmultipleEdge, b : BioseqalignmultipleEdge) -> BioseqalignmultipleEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_multiple_edge_copy(s : BioseqalignmultipleEdge) -> BioseqalignmultipleEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_multiple_edge_fill(s : BioseqalignmultipleEdge, v : Double) -> BioseqalignmultipleEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_multiple_edge_min(s : BioseqalignmultipleEdge) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_multiple_edge_max(s : BioseqalignmultipleEdge) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_multiple_edge_to_string(s : BioseqalignmultipleEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignmultiplePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_multiple_path_make(size : Int) -> BioseqalignmultiplePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_multiple_path_len(s : BioseqalignmultiplePath) -> Int { s.size }

pub fn bio_seq_align_multiple_path_get(s : BioseqalignmultiplePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_multiple_path_set(s : BioseqalignmultiplePath, i : Int, v : Double) -> BioseqalignmultiplePath {
  let result = bio_seq_align_multiple_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_multiple_path_sum(s : BioseqalignmultiplePath) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_multiple_path_mean(s : BioseqalignmultiplePath) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_multiple_path_scale(s : BioseqalignmultiplePath, f : Double) -> BioseqalignmultiplePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_multiple_path_add(a : BioseqalignmultiplePath, b : BioseqalignmultiplePath) -> BioseqalignmultiplePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_multiple_path_copy(s : BioseqalignmultiplePath) -> BioseqalignmultiplePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_multiple_path_fill(s : BioseqalignmultiplePath, v : Double) -> BioseqalignmultiplePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_multiple_path_min(s : BioseqalignmultiplePath) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_multiple_path_max(s : BioseqalignmultiplePath) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_multiple_path_to_string(s : BioseqalignmultiplePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignmultipleCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_multiple_cluster_make(size : Int) -> BioseqalignmultipleCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_multiple_cluster_len(s : BioseqalignmultipleCluster) -> Int { s.size }

pub fn bio_seq_align_multiple_cluster_get(s : BioseqalignmultipleCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_multiple_cluster_set(s : BioseqalignmultipleCluster, i : Int, v : Double) -> BioseqalignmultipleCluster {
  let result = bio_seq_align_multiple_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_multiple_cluster_sum(s : BioseqalignmultipleCluster) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_multiple_cluster_mean(s : BioseqalignmultipleCluster) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_multiple_cluster_scale(s : BioseqalignmultipleCluster, f : Double) -> BioseqalignmultipleCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_multiple_cluster_add(a : BioseqalignmultipleCluster, b : BioseqalignmultipleCluster) -> BioseqalignmultipleCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_multiple_cluster_copy(s : BioseqalignmultipleCluster) -> BioseqalignmultipleCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_multiple_cluster_fill(s : BioseqalignmultipleCluster, v : Double) -> BioseqalignmultipleCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_multiple_cluster_min(s : BioseqalignmultipleCluster) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_multiple_cluster_max(s : BioseqalignmultipleCluster) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_multiple_cluster_to_string(s : BioseqalignmultipleCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignmultipleModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_multiple_model_make(size : Int) -> BioseqalignmultipleModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_multiple_model_len(s : BioseqalignmultipleModel) -> Int { s.size }

pub fn bio_seq_align_multiple_model_get(s : BioseqalignmultipleModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_multiple_model_set(s : BioseqalignmultipleModel, i : Int, v : Double) -> BioseqalignmultipleModel {
  let result = bio_seq_align_multiple_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_multiple_model_sum(s : BioseqalignmultipleModel) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_multiple_model_mean(s : BioseqalignmultipleModel) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_multiple_model_scale(s : BioseqalignmultipleModel, f : Double) -> BioseqalignmultipleModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_multiple_model_add(a : BioseqalignmultipleModel, b : BioseqalignmultipleModel) -> BioseqalignmultipleModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_multiple_model_copy(s : BioseqalignmultipleModel) -> BioseqalignmultipleModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_multiple_model_fill(s : BioseqalignmultipleModel, v : Double) -> BioseqalignmultipleModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_multiple_model_min(s : BioseqalignmultipleModel) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_multiple_model_max(s : BioseqalignmultipleModel) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_multiple_model_to_string(s : BioseqalignmultipleModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignmultipleLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_multiple_layer_make(size : Int) -> BioseqalignmultipleLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_multiple_layer_len(s : BioseqalignmultipleLayer) -> Int { s.size }

pub fn bio_seq_align_multiple_layer_get(s : BioseqalignmultipleLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_multiple_layer_set(s : BioseqalignmultipleLayer, i : Int, v : Double) -> BioseqalignmultipleLayer {
  let result = bio_seq_align_multiple_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_multiple_layer_sum(s : BioseqalignmultipleLayer) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_multiple_layer_mean(s : BioseqalignmultipleLayer) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_multiple_layer_scale(s : BioseqalignmultipleLayer, f : Double) -> BioseqalignmultipleLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_multiple_layer_add(a : BioseqalignmultipleLayer, b : BioseqalignmultipleLayer) -> BioseqalignmultipleLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_multiple_layer_copy(s : BioseqalignmultipleLayer) -> BioseqalignmultipleLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_multiple_layer_fill(s : BioseqalignmultipleLayer, v : Double) -> BioseqalignmultipleLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_multiple_layer_min(s : BioseqalignmultipleLayer) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_multiple_layer_max(s : BioseqalignmultipleLayer) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_multiple_layer_to_string(s : BioseqalignmultipleLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignmultipleBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_multiple_buffer_make(size : Int) -> BioseqalignmultipleBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_multiple_buffer_len(s : BioseqalignmultipleBuffer) -> Int { s.size }

pub fn bio_seq_align_multiple_buffer_get(s : BioseqalignmultipleBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_multiple_buffer_set(s : BioseqalignmultipleBuffer, i : Int, v : Double) -> BioseqalignmultipleBuffer {
  let result = bio_seq_align_multiple_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_multiple_buffer_sum(s : BioseqalignmultipleBuffer) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_multiple_buffer_mean(s : BioseqalignmultipleBuffer) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_multiple_buffer_scale(s : BioseqalignmultipleBuffer, f : Double) -> BioseqalignmultipleBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_multiple_buffer_add(a : BioseqalignmultipleBuffer, b : BioseqalignmultipleBuffer) -> BioseqalignmultipleBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_multiple_buffer_copy(s : BioseqalignmultipleBuffer) -> BioseqalignmultipleBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_multiple_buffer_fill(s : BioseqalignmultipleBuffer, v : Double) -> BioseqalignmultipleBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_multiple_buffer_min(s : BioseqalignmultipleBuffer) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_multiple_buffer_max(s : BioseqalignmultipleBuffer) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_multiple_buffer_to_string(s : BioseqalignmultipleBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignmultipleCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_multiple_cursor_make(size : Int) -> BioseqalignmultipleCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_multiple_cursor_len(s : BioseqalignmultipleCursor) -> Int { s.size }

pub fn bio_seq_align_multiple_cursor_get(s : BioseqalignmultipleCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_multiple_cursor_set(s : BioseqalignmultipleCursor, i : Int, v : Double) -> BioseqalignmultipleCursor {
  let result = bio_seq_align_multiple_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_multiple_cursor_sum(s : BioseqalignmultipleCursor) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_multiple_cursor_mean(s : BioseqalignmultipleCursor) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_multiple_cursor_scale(s : BioseqalignmultipleCursor, f : Double) -> BioseqalignmultipleCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_multiple_cursor_add(a : BioseqalignmultipleCursor, b : BioseqalignmultipleCursor) -> BioseqalignmultipleCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_multiple_cursor_copy(s : BioseqalignmultipleCursor) -> BioseqalignmultipleCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_multiple_cursor_fill(s : BioseqalignmultipleCursor, v : Double) -> BioseqalignmultipleCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_multiple_cursor_min(s : BioseqalignmultipleCursor) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_multiple_cursor_max(s : BioseqalignmultipleCursor) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_multiple_cursor_to_string(s : BioseqalignmultipleCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignmultipleView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_multiple_view_make(size : Int) -> BioseqalignmultipleView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_multiple_view_len(s : BioseqalignmultipleView) -> Int { s.size }

pub fn bio_seq_align_multiple_view_get(s : BioseqalignmultipleView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_multiple_view_set(s : BioseqalignmultipleView, i : Int, v : Double) -> BioseqalignmultipleView {
  let result = bio_seq_align_multiple_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_multiple_view_sum(s : BioseqalignmultipleView) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_multiple_view_mean(s : BioseqalignmultipleView) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_multiple_view_scale(s : BioseqalignmultipleView, f : Double) -> BioseqalignmultipleView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_multiple_view_add(a : BioseqalignmultipleView, b : BioseqalignmultipleView) -> BioseqalignmultipleView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_multiple_view_copy(s : BioseqalignmultipleView) -> BioseqalignmultipleView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_multiple_view_fill(s : BioseqalignmultipleView, v : Double) -> BioseqalignmultipleView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_multiple_view_min(s : BioseqalignmultipleView) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_multiple_view_max(s : BioseqalignmultipleView) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_multiple_view_to_string(s : BioseqalignmultipleView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignmultipleRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_multiple_range_make(size : Int) -> BioseqalignmultipleRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_multiple_range_len(s : BioseqalignmultipleRange) -> Int { s.size }

pub fn bio_seq_align_multiple_range_get(s : BioseqalignmultipleRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_multiple_range_set(s : BioseqalignmultipleRange, i : Int, v : Double) -> BioseqalignmultipleRange {
  let result = bio_seq_align_multiple_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_multiple_range_sum(s : BioseqalignmultipleRange) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_multiple_range_mean(s : BioseqalignmultipleRange) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_multiple_range_scale(s : BioseqalignmultipleRange, f : Double) -> BioseqalignmultipleRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_multiple_range_add(a : BioseqalignmultipleRange, b : BioseqalignmultipleRange) -> BioseqalignmultipleRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_multiple_range_copy(s : BioseqalignmultipleRange) -> BioseqalignmultipleRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_multiple_range_fill(s : BioseqalignmultipleRange, v : Double) -> BioseqalignmultipleRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_multiple_range_min(s : BioseqalignmultipleRange) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_multiple_range_max(s : BioseqalignmultipleRange) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_multiple_range_to_string(s : BioseqalignmultipleRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignmultipleSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_multiple_slice_make(size : Int) -> BioseqalignmultipleSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_multiple_slice_len(s : BioseqalignmultipleSlice) -> Int { s.size }

pub fn bio_seq_align_multiple_slice_get(s : BioseqalignmultipleSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_multiple_slice_set(s : BioseqalignmultipleSlice, i : Int, v : Double) -> BioseqalignmultipleSlice {
  let result = bio_seq_align_multiple_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_multiple_slice_sum(s : BioseqalignmultipleSlice) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_multiple_slice_mean(s : BioseqalignmultipleSlice) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_multiple_slice_scale(s : BioseqalignmultipleSlice, f : Double) -> BioseqalignmultipleSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_multiple_slice_add(a : BioseqalignmultipleSlice, b : BioseqalignmultipleSlice) -> BioseqalignmultipleSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_multiple_slice_copy(s : BioseqalignmultipleSlice) -> BioseqalignmultipleSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_multiple_slice_fill(s : BioseqalignmultipleSlice, v : Double) -> BioseqalignmultipleSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_multiple_slice_min(s : BioseqalignmultipleSlice) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_multiple_slice_max(s : BioseqalignmultipleSlice) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_multiple_slice_to_string(s : BioseqalignmultipleSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


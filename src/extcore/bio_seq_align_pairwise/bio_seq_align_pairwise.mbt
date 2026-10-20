///===
/// extcore/bio_seq_align_pairwise

pub(all) struct BioseqalignpairwisePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn bio_seq_align_pairwise_make_point(x : Double, y : Double) -> BioseqalignpairwisePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn bio_seq_align_pairwise_make_point3(x : Double, y : Double, z : Double) -> BioseqalignpairwisePoint {
  { x, y, z, label: 0 }
}

pub fn bio_seq_align_pairwise_point_x(pt : BioseqalignpairwisePoint) -> Double { pt.x }

pub fn bio_seq_align_pairwise_point_y(pt : BioseqalignpairwisePoint) -> Double { pt.y }

pub fn bio_seq_align_pairwise_point_z(pt : BioseqalignpairwisePoint) -> Double { pt.z }

pub fn bio_seq_align_pairwise_point_label(pt : BioseqalignpairwisePoint) -> Int { pt.label }

pub fn bio_seq_align_pairwise_point_dist(a : BioseqalignpairwisePoint, b : BioseqalignpairwisePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn bio_seq_align_pairwise_point_add(a : BioseqalignpairwisePoint, b : BioseqalignpairwisePoint) -> BioseqalignpairwisePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn bio_seq_align_pairwise_point_sub(a : BioseqalignpairwisePoint, b : BioseqalignpairwisePoint) -> BioseqalignpairwisePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn bio_seq_align_pairwise_point_scale(pt : BioseqalignpairwisePoint, s : Double) -> BioseqalignpairwisePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn bio_seq_align_pairwise_point_dot(a : BioseqalignpairwisePoint, b : BioseqalignpairwisePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn bio_seq_align_pairwise_point_cross(a : BioseqalignpairwisePoint, b : BioseqalignpairwisePoint) -> BioseqalignpairwisePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn bio_seq_align_pairwise_point_norm(pt : BioseqalignpairwisePoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn bio_seq_align_pairwise_point_normalize(pt : BioseqalignpairwisePoint) -> BioseqalignpairwisePoint {
  let n = bio_seq_align_pairwise_point_norm(pt)
  if n < 0.0000001 { pt } else { bio_seq_align_pairwise_point_scale(pt, 1.0 / n) }
}

pub fn bio_seq_align_pairwise_point_negate(pt : BioseqalignpairwisePoint) -> BioseqalignpairwisePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn bio_seq_align_pairwise_point_mid(a : BioseqalignpairwisePoint, b : BioseqalignpairwisePoint) -> BioseqalignpairwisePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn bio_seq_align_pairwise_point_lerp(a : BioseqalignpairwisePoint, b : BioseqalignpairwisePoint, t : Double) -> BioseqalignpairwisePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn bio_seq_align_pairwise_point_to_string(pt : BioseqalignpairwisePoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct BioseqalignpairwiseSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn bio_seq_align_pairwise_make_series(vals : Array[Double], name : String) -> BioseqalignpairwiseSeries {
  { vals, name, meta: 0 }
}

pub fn bio_seq_align_pairwise_series_len(s : BioseqalignpairwiseSeries) -> Int { s.vals.length() }

pub fn bio_seq_align_pairwise_series_sum(s : BioseqalignpairwiseSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn bio_seq_align_pairwise_series_mean(s : BioseqalignpairwiseSeries) -> Double { @_common.mean(s.vals) }

pub fn bio_seq_align_pairwise_series_min(s : BioseqalignpairwiseSeries) -> Double { @_common.min(s.vals) }

pub fn bio_seq_align_pairwise_series_max(s : BioseqalignpairwiseSeries) -> Double { @_common.max(s.vals) }

pub fn bio_seq_align_pairwise_series_range(s : BioseqalignpairwiseSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn bio_seq_align_pairwise_series_var(s : BioseqalignpairwiseSeries) -> Double { @_common.variance(s.vals) }

pub fn bio_seq_align_pairwise_series_std(s : BioseqalignpairwiseSeries) -> Double { @_common.std(s.vals) }

pub fn bio_seq_align_pairwise_series_median(s : BioseqalignpairwiseSeries) -> Double { @_common.median(s.vals) }

pub fn bio_seq_align_pairwise_series_scale(s : BioseqalignpairwiseSeries, f : Double) -> BioseqalignpairwiseSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn bio_seq_align_pairwise_series_add(a : BioseqalignpairwiseSeries, b : BioseqalignpairwiseSeries) -> BioseqalignpairwiseSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn bio_seq_align_pairwise_series_sub(a : BioseqalignpairwiseSeries, b : BioseqalignpairwiseSeries) -> BioseqalignpairwiseSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn bio_seq_align_pairwise_series_normalize(s : BioseqalignpairwiseSeries) -> BioseqalignpairwiseSeries {
  let mn = bio_seq_align_pairwise_series_min(s)
  let mx = bio_seq_align_pairwise_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn bio_seq_align_pairwise_series_cumsum(s : BioseqalignpairwiseSeries) -> BioseqalignpairwiseSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn bio_seq_align_pairwise_series_to_string(s : BioseqalignpairwiseSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BioseqalignpairwiseMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn bio_seq_align_pairwise_make_matrix(rows : Int, cols : Int, val : Double) -> BioseqalignpairwiseMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn bio_seq_align_pairwise_matrix_identity(n : Int) -> BioseqalignpairwiseMatrix {
  let m = bio_seq_align_pairwise_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn bio_seq_align_pairwise_matrix_get(m : BioseqalignpairwiseMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn bio_seq_align_pairwise_matrix_transpose(m : BioseqalignpairwiseMatrix) -> BioseqalignpairwiseMatrix {
  let result = bio_seq_align_pairwise_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn bio_seq_align_pairwise_matrix_add(a : BioseqalignpairwiseMatrix, b : BioseqalignpairwiseMatrix) -> BioseqalignpairwiseMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = bio_seq_align_pairwise_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn bio_seq_align_pairwise_matrix_scale(m : BioseqalignpairwiseMatrix, s : Double) -> BioseqalignpairwiseMatrix {
  let result = bio_seq_align_pairwise_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn bio_seq_align_pairwise_matrix_multiply(a : BioseqalignpairwiseMatrix, b : BioseqalignpairwiseMatrix) -> BioseqalignpairwiseMatrix {
  if a.cols != b.rows { return bio_seq_align_pairwise_make_matrix(a.rows, b.cols, 0.0) }
  let result = bio_seq_align_pairwise_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn bio_seq_align_pairwise_matrix_trace(m : BioseqalignpairwiseMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn bio_seq_align_pairwise_matrix_det(m : BioseqalignpairwiseMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn bio_seq_align_pairwise_matrix_norm(m : BioseqalignpairwiseMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn bio_seq_align_pairwise_matrix_to_string(m : BioseqalignpairwiseMatrix) -> String {
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

pub(all) struct BioseqalignpairwiseVector {
  comps : Array[Double]
  dim : Int
}

pub fn bio_seq_align_pairwise_make_vector(comps : Array[Double]) -> BioseqalignpairwiseVector {
  { comps, dim: comps.length() }
}

pub fn bio_seq_align_pairwise_vector_zero(dim : Int) -> BioseqalignpairwiseVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn bio_seq_align_pairwise_vector_add(a : BioseqalignpairwiseVector, b : BioseqalignpairwiseVector) -> BioseqalignpairwiseVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn bio_seq_align_pairwise_vector_sub(a : BioseqalignpairwiseVector, b : BioseqalignpairwiseVector) -> BioseqalignpairwiseVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn bio_seq_align_pairwise_vector_scale(v : BioseqalignpairwiseVector, s : Double) -> BioseqalignpairwiseVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn bio_seq_align_pairwise_vector_dot(a : BioseqalignpairwiseVector, b : BioseqalignpairwiseVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn bio_seq_align_pairwise_vector_norm(v : BioseqalignpairwiseVector) -> Double { @_common.sqrt(bio_seq_align_pairwise_vector_dot(v, v)) }

pub fn bio_seq_align_pairwise_vector_normalize(v : BioseqalignpairwiseVector) -> BioseqalignpairwiseVector {
  let n = bio_seq_align_pairwise_vector_norm(v)
  if n < 0.0000001 { v } else { bio_seq_align_pairwise_vector_scale(v, 1.0 / n) }
}

pub fn bio_seq_align_pairwise_vector_dist(a : BioseqalignpairwiseVector, b : BioseqalignpairwiseVector) -> Double {
  bio_seq_align_pairwise_vector_norm(bio_seq_align_pairwise_vector_sub(a, b))
}

pub fn bio_seq_align_pairwise_vector_to_string(v : BioseqalignpairwiseVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn bio_seq_align_pairwise_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn bio_seq_align_pairwise_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn bio_seq_align_pairwise_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn bio_seq_align_pairwise_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn bio_seq_align_pairwise_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn bio_seq_align_pairwise_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn bio_seq_align_pairwise_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn bio_seq_align_pairwise_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn bio_seq_align_pairwise_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn bio_seq_align_pairwise_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn bio_seq_align_pairwise_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn bio_seq_align_pairwise_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn bio_seq_align_pairwise_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn bio_seq_align_pairwise_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn bio_seq_align_pairwise_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn bio_seq_align_pairwise_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn bio_seq_align_pairwise_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn bio_seq_align_pairwise_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn bio_seq_align_pairwise_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn bio_seq_align_pairwise_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn bio_seq_align_pairwise_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn bio_seq_align_pairwise_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn bio_seq_align_pairwise_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn bio_seq_align_pairwise_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn bio_seq_align_pairwise_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn bio_seq_align_pairwise_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn bio_seq_align_pairwise_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn bio_seq_align_pairwise_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn bio_seq_align_pairwise_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct BioseqalignpairwiseFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_pairwise_frame_make(size : Int) -> BioseqalignpairwiseFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_pairwise_frame_len(s : BioseqalignpairwiseFrame) -> Int { s.size }

pub fn bio_seq_align_pairwise_frame_get(s : BioseqalignpairwiseFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_pairwise_frame_set(s : BioseqalignpairwiseFrame, i : Int, v : Double) -> BioseqalignpairwiseFrame {
  let result = bio_seq_align_pairwise_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_pairwise_frame_sum(s : BioseqalignpairwiseFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_align_pairwise_frame_mean(s : BioseqalignpairwiseFrame) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_align_pairwise_frame_sum(s) / s.size.to_double() }
}

pub fn bio_seq_align_pairwise_frame_scale(s : BioseqalignpairwiseFrame, f : Double) -> BioseqalignpairwiseFrame {
  let result = bio_seq_align_pairwise_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_align_pairwise_frame_add(a : BioseqalignpairwiseFrame, b : BioseqalignpairwiseFrame) -> BioseqalignpairwiseFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_align_pairwise_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_align_pairwise_frame_copy(s : BioseqalignpairwiseFrame) -> BioseqalignpairwiseFrame {
  let result = bio_seq_align_pairwise_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_align_pairwise_frame_fill(s : BioseqalignpairwiseFrame, v : Double) -> BioseqalignpairwiseFrame {
  let result = bio_seq_align_pairwise_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_pairwise_frame_min(s : BioseqalignpairwiseFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_pairwise_frame_max(s : BioseqalignpairwiseFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_pairwise_frame_to_string(s : BioseqalignpairwiseFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignpairwiseTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_pairwise_table_make(size : Int) -> BioseqalignpairwiseTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_pairwise_table_len(s : BioseqalignpairwiseTable) -> Int { s.size }

pub fn bio_seq_align_pairwise_table_get(s : BioseqalignpairwiseTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_pairwise_table_set(s : BioseqalignpairwiseTable, i : Int, v : Double) -> BioseqalignpairwiseTable {
  let result = bio_seq_align_pairwise_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_pairwise_table_sum(s : BioseqalignpairwiseTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_align_pairwise_table_mean(s : BioseqalignpairwiseTable) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_align_pairwise_table_sum(s) / s.size.to_double() }
}

pub fn bio_seq_align_pairwise_table_scale(s : BioseqalignpairwiseTable, f : Double) -> BioseqalignpairwiseTable {
  let result = bio_seq_align_pairwise_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_align_pairwise_table_add(a : BioseqalignpairwiseTable, b : BioseqalignpairwiseTable) -> BioseqalignpairwiseTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_align_pairwise_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_align_pairwise_table_copy(s : BioseqalignpairwiseTable) -> BioseqalignpairwiseTable {
  let result = bio_seq_align_pairwise_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_align_pairwise_table_fill(s : BioseqalignpairwiseTable, v : Double) -> BioseqalignpairwiseTable {
  let result = bio_seq_align_pairwise_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_pairwise_table_min(s : BioseqalignpairwiseTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_pairwise_table_max(s : BioseqalignpairwiseTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_pairwise_table_to_string(s : BioseqalignpairwiseTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignpairwiseGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_pairwise_graphn_make(size : Int) -> BioseqalignpairwiseGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_pairwise_graphn_len(s : BioseqalignpairwiseGraphN) -> Int { s.size }

pub fn bio_seq_align_pairwise_graphn_get(s : BioseqalignpairwiseGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_pairwise_graphn_set(s : BioseqalignpairwiseGraphN, i : Int, v : Double) -> BioseqalignpairwiseGraphN {
  let result = bio_seq_align_pairwise_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_pairwise_graphn_sum(s : BioseqalignpairwiseGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_align_pairwise_graphn_mean(s : BioseqalignpairwiseGraphN) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_align_pairwise_graphn_sum(s) / s.size.to_double() }
}

pub fn bio_seq_align_pairwise_graphn_scale(s : BioseqalignpairwiseGraphN, f : Double) -> BioseqalignpairwiseGraphN {
  let result = bio_seq_align_pairwise_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_align_pairwise_graphn_add(a : BioseqalignpairwiseGraphN, b : BioseqalignpairwiseGraphN) -> BioseqalignpairwiseGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_align_pairwise_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_align_pairwise_graphn_copy(s : BioseqalignpairwiseGraphN) -> BioseqalignpairwiseGraphN {
  let result = bio_seq_align_pairwise_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_align_pairwise_graphn_fill(s : BioseqalignpairwiseGraphN, v : Double) -> BioseqalignpairwiseGraphN {
  let result = bio_seq_align_pairwise_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_pairwise_graphn_min(s : BioseqalignpairwiseGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_pairwise_graphn_max(s : BioseqalignpairwiseGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_pairwise_graphn_to_string(s : BioseqalignpairwiseGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignpairwiseNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_pairwise_node_make(size : Int) -> BioseqalignpairwiseNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_pairwise_node_len(s : BioseqalignpairwiseNode) -> Int { s.size }

pub fn bio_seq_align_pairwise_node_get(s : BioseqalignpairwiseNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_pairwise_node_set(s : BioseqalignpairwiseNode, i : Int, v : Double) -> BioseqalignpairwiseNode {
  let result = bio_seq_align_pairwise_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_pairwise_node_sum(s : BioseqalignpairwiseNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_align_pairwise_node_mean(s : BioseqalignpairwiseNode) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_align_pairwise_node_sum(s) / s.size.to_double() }
}

pub fn bio_seq_align_pairwise_node_scale(s : BioseqalignpairwiseNode, f : Double) -> BioseqalignpairwiseNode {
  let result = bio_seq_align_pairwise_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_align_pairwise_node_add(a : BioseqalignpairwiseNode, b : BioseqalignpairwiseNode) -> BioseqalignpairwiseNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_align_pairwise_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_align_pairwise_node_copy(s : BioseqalignpairwiseNode) -> BioseqalignpairwiseNode {
  let result = bio_seq_align_pairwise_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_align_pairwise_node_fill(s : BioseqalignpairwiseNode, v : Double) -> BioseqalignpairwiseNode {
  let result = bio_seq_align_pairwise_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_pairwise_node_min(s : BioseqalignpairwiseNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_pairwise_node_max(s : BioseqalignpairwiseNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_pairwise_node_to_string(s : BioseqalignpairwiseNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignpairwiseEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_pairwise_edge_make(size : Int) -> BioseqalignpairwiseEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_pairwise_edge_len(s : BioseqalignpairwiseEdge) -> Int { s.size }

pub fn bio_seq_align_pairwise_edge_get(s : BioseqalignpairwiseEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_pairwise_edge_set(s : BioseqalignpairwiseEdge, i : Int, v : Double) -> BioseqalignpairwiseEdge {
  let result = bio_seq_align_pairwise_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_pairwise_edge_sum(s : BioseqalignpairwiseEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_align_pairwise_edge_mean(s : BioseqalignpairwiseEdge) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_align_pairwise_edge_sum(s) / s.size.to_double() }
}

pub fn bio_seq_align_pairwise_edge_scale(s : BioseqalignpairwiseEdge, f : Double) -> BioseqalignpairwiseEdge {
  let result = bio_seq_align_pairwise_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_align_pairwise_edge_add(a : BioseqalignpairwiseEdge, b : BioseqalignpairwiseEdge) -> BioseqalignpairwiseEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_align_pairwise_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_align_pairwise_edge_copy(s : BioseqalignpairwiseEdge) -> BioseqalignpairwiseEdge {
  let result = bio_seq_align_pairwise_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_align_pairwise_edge_fill(s : BioseqalignpairwiseEdge, v : Double) -> BioseqalignpairwiseEdge {
  let result = bio_seq_align_pairwise_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_pairwise_edge_min(s : BioseqalignpairwiseEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_pairwise_edge_max(s : BioseqalignpairwiseEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_pairwise_edge_to_string(s : BioseqalignpairwiseEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignpairwisePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_pairwise_path_make(size : Int) -> BioseqalignpairwisePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_pairwise_path_len(s : BioseqalignpairwisePath) -> Int { s.size }

pub fn bio_seq_align_pairwise_path_get(s : BioseqalignpairwisePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_pairwise_path_set(s : BioseqalignpairwisePath, i : Int, v : Double) -> BioseqalignpairwisePath {
  let result = bio_seq_align_pairwise_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_pairwise_path_sum(s : BioseqalignpairwisePath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_align_pairwise_path_mean(s : BioseqalignpairwisePath) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_align_pairwise_path_sum(s) / s.size.to_double() }
}

pub fn bio_seq_align_pairwise_path_scale(s : BioseqalignpairwisePath, f : Double) -> BioseqalignpairwisePath {
  let result = bio_seq_align_pairwise_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_align_pairwise_path_add(a : BioseqalignpairwisePath, b : BioseqalignpairwisePath) -> BioseqalignpairwisePath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_align_pairwise_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_align_pairwise_path_copy(s : BioseqalignpairwisePath) -> BioseqalignpairwisePath {
  let result = bio_seq_align_pairwise_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_align_pairwise_path_fill(s : BioseqalignpairwisePath, v : Double) -> BioseqalignpairwisePath {
  let result = bio_seq_align_pairwise_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_pairwise_path_min(s : BioseqalignpairwisePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_pairwise_path_max(s : BioseqalignpairwisePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_pairwise_path_to_string(s : BioseqalignpairwisePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignpairwiseCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_pairwise_cluster_make(size : Int) -> BioseqalignpairwiseCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_pairwise_cluster_len(s : BioseqalignpairwiseCluster) -> Int { s.size }

pub fn bio_seq_align_pairwise_cluster_get(s : BioseqalignpairwiseCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_pairwise_cluster_set(s : BioseqalignpairwiseCluster, i : Int, v : Double) -> BioseqalignpairwiseCluster {
  let result = bio_seq_align_pairwise_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_pairwise_cluster_sum(s : BioseqalignpairwiseCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_align_pairwise_cluster_mean(s : BioseqalignpairwiseCluster) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_align_pairwise_cluster_sum(s) / s.size.to_double() }
}

pub fn bio_seq_align_pairwise_cluster_scale(s : BioseqalignpairwiseCluster, f : Double) -> BioseqalignpairwiseCluster {
  let result = bio_seq_align_pairwise_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_align_pairwise_cluster_add(a : BioseqalignpairwiseCluster, b : BioseqalignpairwiseCluster) -> BioseqalignpairwiseCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_align_pairwise_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_align_pairwise_cluster_copy(s : BioseqalignpairwiseCluster) -> BioseqalignpairwiseCluster {
  let result = bio_seq_align_pairwise_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_align_pairwise_cluster_fill(s : BioseqalignpairwiseCluster, v : Double) -> BioseqalignpairwiseCluster {
  let result = bio_seq_align_pairwise_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_pairwise_cluster_min(s : BioseqalignpairwiseCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_pairwise_cluster_max(s : BioseqalignpairwiseCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_pairwise_cluster_to_string(s : BioseqalignpairwiseCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignpairwiseModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_pairwise_model_make(size : Int) -> BioseqalignpairwiseModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_pairwise_model_len(s : BioseqalignpairwiseModel) -> Int { s.size }

pub fn bio_seq_align_pairwise_model_get(s : BioseqalignpairwiseModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_pairwise_model_set(s : BioseqalignpairwiseModel, i : Int, v : Double) -> BioseqalignpairwiseModel {
  let result = bio_seq_align_pairwise_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_pairwise_model_sum(s : BioseqalignpairwiseModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_align_pairwise_model_mean(s : BioseqalignpairwiseModel) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_align_pairwise_model_sum(s) / s.size.to_double() }
}

pub fn bio_seq_align_pairwise_model_scale(s : BioseqalignpairwiseModel, f : Double) -> BioseqalignpairwiseModel {
  let result = bio_seq_align_pairwise_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_align_pairwise_model_add(a : BioseqalignpairwiseModel, b : BioseqalignpairwiseModel) -> BioseqalignpairwiseModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_align_pairwise_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_align_pairwise_model_copy(s : BioseqalignpairwiseModel) -> BioseqalignpairwiseModel {
  let result = bio_seq_align_pairwise_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_align_pairwise_model_fill(s : BioseqalignpairwiseModel, v : Double) -> BioseqalignpairwiseModel {
  let result = bio_seq_align_pairwise_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_pairwise_model_min(s : BioseqalignpairwiseModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_pairwise_model_max(s : BioseqalignpairwiseModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_pairwise_model_to_string(s : BioseqalignpairwiseModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignpairwiseLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_pairwise_layer_make(size : Int) -> BioseqalignpairwiseLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_pairwise_layer_len(s : BioseqalignpairwiseLayer) -> Int { s.size }

pub fn bio_seq_align_pairwise_layer_get(s : BioseqalignpairwiseLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_pairwise_layer_set(s : BioseqalignpairwiseLayer, i : Int, v : Double) -> BioseqalignpairwiseLayer {
  let result = bio_seq_align_pairwise_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_pairwise_layer_sum(s : BioseqalignpairwiseLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_align_pairwise_layer_mean(s : BioseqalignpairwiseLayer) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_align_pairwise_layer_sum(s) / s.size.to_double() }
}

pub fn bio_seq_align_pairwise_layer_scale(s : BioseqalignpairwiseLayer, f : Double) -> BioseqalignpairwiseLayer {
  let result = bio_seq_align_pairwise_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_align_pairwise_layer_add(a : BioseqalignpairwiseLayer, b : BioseqalignpairwiseLayer) -> BioseqalignpairwiseLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_align_pairwise_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_align_pairwise_layer_copy(s : BioseqalignpairwiseLayer) -> BioseqalignpairwiseLayer {
  let result = bio_seq_align_pairwise_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_align_pairwise_layer_fill(s : BioseqalignpairwiseLayer, v : Double) -> BioseqalignpairwiseLayer {
  let result = bio_seq_align_pairwise_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_pairwise_layer_min(s : BioseqalignpairwiseLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_pairwise_layer_max(s : BioseqalignpairwiseLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_pairwise_layer_to_string(s : BioseqalignpairwiseLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignpairwiseBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_pairwise_buffer_make(size : Int) -> BioseqalignpairwiseBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_pairwise_buffer_len(s : BioseqalignpairwiseBuffer) -> Int { s.size }

pub fn bio_seq_align_pairwise_buffer_get(s : BioseqalignpairwiseBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_pairwise_buffer_set(s : BioseqalignpairwiseBuffer, i : Int, v : Double) -> BioseqalignpairwiseBuffer {
  let result = bio_seq_align_pairwise_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_pairwise_buffer_sum(s : BioseqalignpairwiseBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_align_pairwise_buffer_mean(s : BioseqalignpairwiseBuffer) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_align_pairwise_buffer_sum(s) / s.size.to_double() }
}

pub fn bio_seq_align_pairwise_buffer_scale(s : BioseqalignpairwiseBuffer, f : Double) -> BioseqalignpairwiseBuffer {
  let result = bio_seq_align_pairwise_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_align_pairwise_buffer_add(a : BioseqalignpairwiseBuffer, b : BioseqalignpairwiseBuffer) -> BioseqalignpairwiseBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_align_pairwise_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_align_pairwise_buffer_copy(s : BioseqalignpairwiseBuffer) -> BioseqalignpairwiseBuffer {
  let result = bio_seq_align_pairwise_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_align_pairwise_buffer_fill(s : BioseqalignpairwiseBuffer, v : Double) -> BioseqalignpairwiseBuffer {
  let result = bio_seq_align_pairwise_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_pairwise_buffer_min(s : BioseqalignpairwiseBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_pairwise_buffer_max(s : BioseqalignpairwiseBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_pairwise_buffer_to_string(s : BioseqalignpairwiseBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignpairwiseCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_pairwise_cursor_make(size : Int) -> BioseqalignpairwiseCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_pairwise_cursor_len(s : BioseqalignpairwiseCursor) -> Int { s.size }

pub fn bio_seq_align_pairwise_cursor_get(s : BioseqalignpairwiseCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_pairwise_cursor_set(s : BioseqalignpairwiseCursor, i : Int, v : Double) -> BioseqalignpairwiseCursor {
  let result = bio_seq_align_pairwise_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_pairwise_cursor_sum(s : BioseqalignpairwiseCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_align_pairwise_cursor_mean(s : BioseqalignpairwiseCursor) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_align_pairwise_cursor_sum(s) / s.size.to_double() }
}

pub fn bio_seq_align_pairwise_cursor_scale(s : BioseqalignpairwiseCursor, f : Double) -> BioseqalignpairwiseCursor {
  let result = bio_seq_align_pairwise_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_align_pairwise_cursor_add(a : BioseqalignpairwiseCursor, b : BioseqalignpairwiseCursor) -> BioseqalignpairwiseCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_align_pairwise_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_align_pairwise_cursor_copy(s : BioseqalignpairwiseCursor) -> BioseqalignpairwiseCursor {
  let result = bio_seq_align_pairwise_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_align_pairwise_cursor_fill(s : BioseqalignpairwiseCursor, v : Double) -> BioseqalignpairwiseCursor {
  let result = bio_seq_align_pairwise_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_pairwise_cursor_min(s : BioseqalignpairwiseCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_pairwise_cursor_max(s : BioseqalignpairwiseCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_pairwise_cursor_to_string(s : BioseqalignpairwiseCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignpairwiseView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_pairwise_view_make(size : Int) -> BioseqalignpairwiseView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_pairwise_view_len(s : BioseqalignpairwiseView) -> Int { s.size }

pub fn bio_seq_align_pairwise_view_get(s : BioseqalignpairwiseView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_pairwise_view_set(s : BioseqalignpairwiseView, i : Int, v : Double) -> BioseqalignpairwiseView {
  let result = bio_seq_align_pairwise_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_pairwise_view_sum(s : BioseqalignpairwiseView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_align_pairwise_view_mean(s : BioseqalignpairwiseView) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_align_pairwise_view_sum(s) / s.size.to_double() }
}

pub fn bio_seq_align_pairwise_view_scale(s : BioseqalignpairwiseView, f : Double) -> BioseqalignpairwiseView {
  let result = bio_seq_align_pairwise_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_align_pairwise_view_add(a : BioseqalignpairwiseView, b : BioseqalignpairwiseView) -> BioseqalignpairwiseView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_align_pairwise_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_align_pairwise_view_copy(s : BioseqalignpairwiseView) -> BioseqalignpairwiseView {
  let result = bio_seq_align_pairwise_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_align_pairwise_view_fill(s : BioseqalignpairwiseView, v : Double) -> BioseqalignpairwiseView {
  let result = bio_seq_align_pairwise_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_pairwise_view_min(s : BioseqalignpairwiseView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_pairwise_view_max(s : BioseqalignpairwiseView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_pairwise_view_to_string(s : BioseqalignpairwiseView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignpairwiseRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_pairwise_range_make(size : Int) -> BioseqalignpairwiseRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_pairwise_range_len(s : BioseqalignpairwiseRange) -> Int { s.size }

pub fn bio_seq_align_pairwise_range_get(s : BioseqalignpairwiseRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_pairwise_range_set(s : BioseqalignpairwiseRange, i : Int, v : Double) -> BioseqalignpairwiseRange {
  let result = bio_seq_align_pairwise_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_pairwise_range_sum(s : BioseqalignpairwiseRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_align_pairwise_range_mean(s : BioseqalignpairwiseRange) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_align_pairwise_range_sum(s) / s.size.to_double() }
}

pub fn bio_seq_align_pairwise_range_scale(s : BioseqalignpairwiseRange, f : Double) -> BioseqalignpairwiseRange {
  let result = bio_seq_align_pairwise_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_align_pairwise_range_add(a : BioseqalignpairwiseRange, b : BioseqalignpairwiseRange) -> BioseqalignpairwiseRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_align_pairwise_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_align_pairwise_range_copy(s : BioseqalignpairwiseRange) -> BioseqalignpairwiseRange {
  let result = bio_seq_align_pairwise_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_align_pairwise_range_fill(s : BioseqalignpairwiseRange, v : Double) -> BioseqalignpairwiseRange {
  let result = bio_seq_align_pairwise_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_pairwise_range_min(s : BioseqalignpairwiseRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_pairwise_range_max(s : BioseqalignpairwiseRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_pairwise_range_to_string(s : BioseqalignpairwiseRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignpairwiseSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_pairwise_slice_make(size : Int) -> BioseqalignpairwiseSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_pairwise_slice_len(s : BioseqalignpairwiseSlice) -> Int { s.size }

pub fn bio_seq_align_pairwise_slice_get(s : BioseqalignpairwiseSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_pairwise_slice_set(s : BioseqalignpairwiseSlice, i : Int, v : Double) -> BioseqalignpairwiseSlice {
  let result = bio_seq_align_pairwise_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_pairwise_slice_sum(s : BioseqalignpairwiseSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_align_pairwise_slice_mean(s : BioseqalignpairwiseSlice) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_align_pairwise_slice_sum(s) / s.size.to_double() }
}

pub fn bio_seq_align_pairwise_slice_scale(s : BioseqalignpairwiseSlice, f : Double) -> BioseqalignpairwiseSlice {
  let result = bio_seq_align_pairwise_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_align_pairwise_slice_add(a : BioseqalignpairwiseSlice, b : BioseqalignpairwiseSlice) -> BioseqalignpairwiseSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_align_pairwise_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_align_pairwise_slice_copy(s : BioseqalignpairwiseSlice) -> BioseqalignpairwiseSlice {
  let result = bio_seq_align_pairwise_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_align_pairwise_slice_fill(s : BioseqalignpairwiseSlice, v : Double) -> BioseqalignpairwiseSlice {
  let result = bio_seq_align_pairwise_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_pairwise_slice_min(s : BioseqalignpairwiseSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_pairwise_slice_max(s : BioseqalignpairwiseSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_pairwise_slice_to_string(s : BioseqalignpairwiseSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


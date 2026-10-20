///===
/// extcore/nlp_embed_gpt

pub(all) struct NlpembedgptPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_embed_gpt_make_point(x : Double, y : Double) -> NlpembedgptPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_embed_gpt_make_point3(x : Double, y : Double, z : Double) -> NlpembedgptPoint {
  { x, y, z, label: 0 }
}

pub fn nlp_embed_gpt_point_x(pt : NlpembedgptPoint) -> Double { pt.x }

pub fn nlp_embed_gpt_point_y(pt : NlpembedgptPoint) -> Double { pt.y }

pub fn nlp_embed_gpt_point_z(pt : NlpembedgptPoint) -> Double { pt.z }

pub fn nlp_embed_gpt_point_label(pt : NlpembedgptPoint) -> Int { pt.label }

pub fn nlp_embed_gpt_point_dist(a : NlpembedgptPoint, b : NlpembedgptPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn nlp_embed_gpt_point_add(a : NlpembedgptPoint, b : NlpembedgptPoint) -> NlpembedgptPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn nlp_embed_gpt_point_sub(a : NlpembedgptPoint, b : NlpembedgptPoint) -> NlpembedgptPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn nlp_embed_gpt_point_scale(pt : NlpembedgptPoint, s : Double) -> NlpembedgptPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn nlp_embed_gpt_point_dot(a : NlpembedgptPoint, b : NlpembedgptPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn nlp_embed_gpt_point_cross(a : NlpembedgptPoint, b : NlpembedgptPoint) -> NlpembedgptPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn nlp_embed_gpt_point_norm(pt : NlpembedgptPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn nlp_embed_gpt_point_normalize(pt : NlpembedgptPoint) -> NlpembedgptPoint {
  let n = nlp_embed_gpt_point_norm(pt)
  if n < 0.0000001 { pt } else { nlp_embed_gpt_point_scale(pt, 1.0 / n) }
}

pub fn nlp_embed_gpt_point_negate(pt : NlpembedgptPoint) -> NlpembedgptPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn nlp_embed_gpt_point_mid(a : NlpembedgptPoint, b : NlpembedgptPoint) -> NlpembedgptPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn nlp_embed_gpt_point_lerp(a : NlpembedgptPoint, b : NlpembedgptPoint, t : Double) -> NlpembedgptPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn nlp_embed_gpt_point_to_string(pt : NlpembedgptPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct NlpembedgptSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_embed_gpt_make_series(vals : Array[Double], name : String) -> NlpembedgptSeries {
  { vals, name, meta: 0 }
}

pub fn nlp_embed_gpt_series_len(s : NlpembedgptSeries) -> Int { s.vals.length() }

pub fn nlp_embed_gpt_series_sum(s : NlpembedgptSeries) -> Double { @_common.sum(s.vals) }

pub fn nlp_embed_gpt_series_mean(s : NlpembedgptSeries) -> Double { @_common.mean(s.vals) }

pub fn nlp_embed_gpt_series_min(s : NlpembedgptSeries) -> Double { @_common.min(s.vals) }

pub fn nlp_embed_gpt_series_max(s : NlpembedgptSeries) -> Double { @_common.max(s.vals) }

pub fn nlp_embed_gpt_series_range(s : NlpembedgptSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn nlp_embed_gpt_series_var(s : NlpembedgptSeries) -> Double { @_common.variance(s.vals) }

pub fn nlp_embed_gpt_series_std(s : NlpembedgptSeries) -> Double { @_common.std(s.vals) }

pub fn nlp_embed_gpt_series_median(s : NlpembedgptSeries) -> Double { @_common.median(s.vals) }

pub fn nlp_embed_gpt_series_scale(s : NlpembedgptSeries, f : Double) -> NlpembedgptSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn nlp_embed_gpt_series_add(a : NlpembedgptSeries, b : NlpembedgptSeries) -> NlpembedgptSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn nlp_embed_gpt_series_sub(a : NlpembedgptSeries, b : NlpembedgptSeries) -> NlpembedgptSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn nlp_embed_gpt_series_normalize(s : NlpembedgptSeries) -> NlpembedgptSeries {
  let mn = nlp_embed_gpt_series_min(s)
  let mx = nlp_embed_gpt_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn nlp_embed_gpt_series_cumsum(s : NlpembedgptSeries) -> NlpembedgptSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn nlp_embed_gpt_series_to_string(s : NlpembedgptSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlpembedgptMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_embed_gpt_make_matrix(rows : Int, cols : Int, val : Double) -> NlpembedgptMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn nlp_embed_gpt_matrix_identity(n : Int) -> NlpembedgptMatrix {
  let m = nlp_embed_gpt_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn nlp_embed_gpt_matrix_get(m : NlpembedgptMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn nlp_embed_gpt_matrix_transpose(m : NlpembedgptMatrix) -> NlpembedgptMatrix {
  let result = nlp_embed_gpt_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn nlp_embed_gpt_matrix_add(a : NlpembedgptMatrix, b : NlpembedgptMatrix) -> NlpembedgptMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = nlp_embed_gpt_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn nlp_embed_gpt_matrix_scale(m : NlpembedgptMatrix, s : Double) -> NlpembedgptMatrix {
  let result = nlp_embed_gpt_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn nlp_embed_gpt_matrix_multiply(a : NlpembedgptMatrix, b : NlpembedgptMatrix) -> NlpembedgptMatrix {
  if a.cols != b.rows { return nlp_embed_gpt_make_matrix(a.rows, b.cols, 0.0) }
  let result = nlp_embed_gpt_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn nlp_embed_gpt_matrix_trace(m : NlpembedgptMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn nlp_embed_gpt_matrix_det(m : NlpembedgptMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn nlp_embed_gpt_matrix_norm(m : NlpembedgptMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn nlp_embed_gpt_matrix_to_string(m : NlpembedgptMatrix) -> String {
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

pub(all) struct NlpembedgptVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_embed_gpt_make_vector(comps : Array[Double]) -> NlpembedgptVector {
  { comps, dim: comps.length() }
}

pub fn nlp_embed_gpt_vector_zero(dim : Int) -> NlpembedgptVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn nlp_embed_gpt_vector_add(a : NlpembedgptVector, b : NlpembedgptVector) -> NlpembedgptVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn nlp_embed_gpt_vector_sub(a : NlpembedgptVector, b : NlpembedgptVector) -> NlpembedgptVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn nlp_embed_gpt_vector_scale(v : NlpembedgptVector, s : Double) -> NlpembedgptVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn nlp_embed_gpt_vector_dot(a : NlpembedgptVector, b : NlpembedgptVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn nlp_embed_gpt_vector_norm(v : NlpembedgptVector) -> Double { @_common.sqrt(nlp_embed_gpt_vector_dot(v, v)) }

pub fn nlp_embed_gpt_vector_normalize(v : NlpembedgptVector) -> NlpembedgptVector {
  let n = nlp_embed_gpt_vector_norm(v)
  if n < 0.0000001 { v } else { nlp_embed_gpt_vector_scale(v, 1.0 / n) }
}

pub fn nlp_embed_gpt_vector_dist(a : NlpembedgptVector, b : NlpembedgptVector) -> Double {
  nlp_embed_gpt_vector_norm(nlp_embed_gpt_vector_sub(a, b))
}

pub fn nlp_embed_gpt_vector_to_string(v : NlpembedgptVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn nlp_embed_gpt_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn nlp_embed_gpt_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn nlp_embed_gpt_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn nlp_embed_gpt_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn nlp_embed_gpt_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn nlp_embed_gpt_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn nlp_embed_gpt_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn nlp_embed_gpt_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn nlp_embed_gpt_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn nlp_embed_gpt_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn nlp_embed_gpt_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn nlp_embed_gpt_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn nlp_embed_gpt_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn nlp_embed_gpt_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn nlp_embed_gpt_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn nlp_embed_gpt_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn nlp_embed_gpt_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn nlp_embed_gpt_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn nlp_embed_gpt_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn nlp_embed_gpt_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn nlp_embed_gpt_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn nlp_embed_gpt_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn nlp_embed_gpt_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn nlp_embed_gpt_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn nlp_embed_gpt_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn nlp_embed_gpt_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn nlp_embed_gpt_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn nlp_embed_gpt_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn nlp_embed_gpt_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NlpembedgptFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_gpt_frame_make(size : Int) -> NlpembedgptFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_gpt_frame_len(s : NlpembedgptFrame) -> Int { s.size }

pub fn nlp_embed_gpt_frame_get(s : NlpembedgptFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_gpt_frame_set(s : NlpembedgptFrame, i : Int, v : Double) -> NlpembedgptFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_frame_sum(s : NlpembedgptFrame) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_gpt_frame_mean(s : NlpembedgptFrame) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_gpt_frame_scale(s : NlpembedgptFrame, f : Double) -> NlpembedgptFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_frame_add(a : NlpembedgptFrame, b : NlpembedgptFrame) -> NlpembedgptFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_gpt_frame_copy(s : NlpembedgptFrame) -> NlpembedgptFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_frame_fill(s : NlpembedgptFrame, v : Double) -> NlpembedgptFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_frame_min(s : NlpembedgptFrame) -> Double { @_common.min(s.data) }

pub fn nlp_embed_gpt_frame_max(s : NlpembedgptFrame) -> Double { @_common.max(s.data) }

pub fn nlp_embed_gpt_frame_to_string(s : NlpembedgptFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedgptTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_gpt_table_make(size : Int) -> NlpembedgptTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_gpt_table_len(s : NlpembedgptTable) -> Int { s.size }

pub fn nlp_embed_gpt_table_get(s : NlpembedgptTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_gpt_table_set(s : NlpembedgptTable, i : Int, v : Double) -> NlpembedgptTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_table_sum(s : NlpembedgptTable) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_gpt_table_mean(s : NlpembedgptTable) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_gpt_table_scale(s : NlpembedgptTable, f : Double) -> NlpembedgptTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_table_add(a : NlpembedgptTable, b : NlpembedgptTable) -> NlpembedgptTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_gpt_table_copy(s : NlpembedgptTable) -> NlpembedgptTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_table_fill(s : NlpembedgptTable, v : Double) -> NlpembedgptTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_table_min(s : NlpembedgptTable) -> Double { @_common.min(s.data) }

pub fn nlp_embed_gpt_table_max(s : NlpembedgptTable) -> Double { @_common.max(s.data) }

pub fn nlp_embed_gpt_table_to_string(s : NlpembedgptTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedgptGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_gpt_graphn_make(size : Int) -> NlpembedgptGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_gpt_graphn_len(s : NlpembedgptGraphN) -> Int { s.size }

pub fn nlp_embed_gpt_graphn_get(s : NlpembedgptGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_gpt_graphn_set(s : NlpembedgptGraphN, i : Int, v : Double) -> NlpembedgptGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_graphn_sum(s : NlpembedgptGraphN) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_gpt_graphn_mean(s : NlpembedgptGraphN) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_gpt_graphn_scale(s : NlpembedgptGraphN, f : Double) -> NlpembedgptGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_graphn_add(a : NlpembedgptGraphN, b : NlpembedgptGraphN) -> NlpembedgptGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_gpt_graphn_copy(s : NlpembedgptGraphN) -> NlpembedgptGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_graphn_fill(s : NlpembedgptGraphN, v : Double) -> NlpembedgptGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_graphn_min(s : NlpembedgptGraphN) -> Double { @_common.min(s.data) }

pub fn nlp_embed_gpt_graphn_max(s : NlpembedgptGraphN) -> Double { @_common.max(s.data) }

pub fn nlp_embed_gpt_graphn_to_string(s : NlpembedgptGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedgptNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_gpt_node_make(size : Int) -> NlpembedgptNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_gpt_node_len(s : NlpembedgptNode) -> Int { s.size }

pub fn nlp_embed_gpt_node_get(s : NlpembedgptNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_gpt_node_set(s : NlpembedgptNode, i : Int, v : Double) -> NlpembedgptNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_node_sum(s : NlpembedgptNode) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_gpt_node_mean(s : NlpembedgptNode) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_gpt_node_scale(s : NlpembedgptNode, f : Double) -> NlpembedgptNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_node_add(a : NlpembedgptNode, b : NlpembedgptNode) -> NlpembedgptNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_gpt_node_copy(s : NlpembedgptNode) -> NlpembedgptNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_node_fill(s : NlpembedgptNode, v : Double) -> NlpembedgptNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_node_min(s : NlpembedgptNode) -> Double { @_common.min(s.data) }

pub fn nlp_embed_gpt_node_max(s : NlpembedgptNode) -> Double { @_common.max(s.data) }

pub fn nlp_embed_gpt_node_to_string(s : NlpembedgptNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedgptEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_gpt_edge_make(size : Int) -> NlpembedgptEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_gpt_edge_len(s : NlpembedgptEdge) -> Int { s.size }

pub fn nlp_embed_gpt_edge_get(s : NlpembedgptEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_gpt_edge_set(s : NlpembedgptEdge, i : Int, v : Double) -> NlpembedgptEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_edge_sum(s : NlpembedgptEdge) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_gpt_edge_mean(s : NlpembedgptEdge) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_gpt_edge_scale(s : NlpembedgptEdge, f : Double) -> NlpembedgptEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_edge_add(a : NlpembedgptEdge, b : NlpembedgptEdge) -> NlpembedgptEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_gpt_edge_copy(s : NlpembedgptEdge) -> NlpembedgptEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_edge_fill(s : NlpembedgptEdge, v : Double) -> NlpembedgptEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_edge_min(s : NlpembedgptEdge) -> Double { @_common.min(s.data) }

pub fn nlp_embed_gpt_edge_max(s : NlpembedgptEdge) -> Double { @_common.max(s.data) }

pub fn nlp_embed_gpt_edge_to_string(s : NlpembedgptEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedgptPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_gpt_path_make(size : Int) -> NlpembedgptPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_gpt_path_len(s : NlpembedgptPath) -> Int { s.size }

pub fn nlp_embed_gpt_path_get(s : NlpembedgptPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_gpt_path_set(s : NlpembedgptPath, i : Int, v : Double) -> NlpembedgptPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_path_sum(s : NlpembedgptPath) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_gpt_path_mean(s : NlpembedgptPath) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_gpt_path_scale(s : NlpembedgptPath, f : Double) -> NlpembedgptPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_path_add(a : NlpembedgptPath, b : NlpembedgptPath) -> NlpembedgptPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_gpt_path_copy(s : NlpembedgptPath) -> NlpembedgptPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_path_fill(s : NlpembedgptPath, v : Double) -> NlpembedgptPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_path_min(s : NlpembedgptPath) -> Double { @_common.min(s.data) }

pub fn nlp_embed_gpt_path_max(s : NlpembedgptPath) -> Double { @_common.max(s.data) }

pub fn nlp_embed_gpt_path_to_string(s : NlpembedgptPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedgptCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_gpt_cluster_make(size : Int) -> NlpembedgptCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_gpt_cluster_len(s : NlpembedgptCluster) -> Int { s.size }

pub fn nlp_embed_gpt_cluster_get(s : NlpembedgptCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_gpt_cluster_set(s : NlpembedgptCluster, i : Int, v : Double) -> NlpembedgptCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_cluster_sum(s : NlpembedgptCluster) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_gpt_cluster_mean(s : NlpembedgptCluster) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_gpt_cluster_scale(s : NlpembedgptCluster, f : Double) -> NlpembedgptCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_cluster_add(a : NlpembedgptCluster, b : NlpembedgptCluster) -> NlpembedgptCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_gpt_cluster_copy(s : NlpembedgptCluster) -> NlpembedgptCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_cluster_fill(s : NlpembedgptCluster, v : Double) -> NlpembedgptCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_cluster_min(s : NlpembedgptCluster) -> Double { @_common.min(s.data) }

pub fn nlp_embed_gpt_cluster_max(s : NlpembedgptCluster) -> Double { @_common.max(s.data) }

pub fn nlp_embed_gpt_cluster_to_string(s : NlpembedgptCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedgptModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_gpt_model_make(size : Int) -> NlpembedgptModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_gpt_model_len(s : NlpembedgptModel) -> Int { s.size }

pub fn nlp_embed_gpt_model_get(s : NlpembedgptModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_gpt_model_set(s : NlpembedgptModel, i : Int, v : Double) -> NlpembedgptModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_model_sum(s : NlpembedgptModel) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_gpt_model_mean(s : NlpembedgptModel) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_gpt_model_scale(s : NlpembedgptModel, f : Double) -> NlpembedgptModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_model_add(a : NlpembedgptModel, b : NlpembedgptModel) -> NlpembedgptModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_gpt_model_copy(s : NlpembedgptModel) -> NlpembedgptModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_model_fill(s : NlpembedgptModel, v : Double) -> NlpembedgptModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_model_min(s : NlpembedgptModel) -> Double { @_common.min(s.data) }

pub fn nlp_embed_gpt_model_max(s : NlpembedgptModel) -> Double { @_common.max(s.data) }

pub fn nlp_embed_gpt_model_to_string(s : NlpembedgptModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedgptLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_gpt_layer_make(size : Int) -> NlpembedgptLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_gpt_layer_len(s : NlpembedgptLayer) -> Int { s.size }

pub fn nlp_embed_gpt_layer_get(s : NlpembedgptLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_gpt_layer_set(s : NlpembedgptLayer, i : Int, v : Double) -> NlpembedgptLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_layer_sum(s : NlpembedgptLayer) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_gpt_layer_mean(s : NlpembedgptLayer) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_gpt_layer_scale(s : NlpembedgptLayer, f : Double) -> NlpembedgptLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_layer_add(a : NlpembedgptLayer, b : NlpembedgptLayer) -> NlpembedgptLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_gpt_layer_copy(s : NlpembedgptLayer) -> NlpembedgptLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_layer_fill(s : NlpembedgptLayer, v : Double) -> NlpembedgptLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_layer_min(s : NlpembedgptLayer) -> Double { @_common.min(s.data) }

pub fn nlp_embed_gpt_layer_max(s : NlpembedgptLayer) -> Double { @_common.max(s.data) }

pub fn nlp_embed_gpt_layer_to_string(s : NlpembedgptLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedgptBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_gpt_buffer_make(size : Int) -> NlpembedgptBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_gpt_buffer_len(s : NlpembedgptBuffer) -> Int { s.size }

pub fn nlp_embed_gpt_buffer_get(s : NlpembedgptBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_gpt_buffer_set(s : NlpembedgptBuffer, i : Int, v : Double) -> NlpembedgptBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_buffer_sum(s : NlpembedgptBuffer) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_gpt_buffer_mean(s : NlpembedgptBuffer) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_gpt_buffer_scale(s : NlpembedgptBuffer, f : Double) -> NlpembedgptBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_buffer_add(a : NlpembedgptBuffer, b : NlpembedgptBuffer) -> NlpembedgptBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_gpt_buffer_copy(s : NlpembedgptBuffer) -> NlpembedgptBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_buffer_fill(s : NlpembedgptBuffer, v : Double) -> NlpembedgptBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_buffer_min(s : NlpembedgptBuffer) -> Double { @_common.min(s.data) }

pub fn nlp_embed_gpt_buffer_max(s : NlpembedgptBuffer) -> Double { @_common.max(s.data) }

pub fn nlp_embed_gpt_buffer_to_string(s : NlpembedgptBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedgptCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_gpt_cursor_make(size : Int) -> NlpembedgptCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_gpt_cursor_len(s : NlpembedgptCursor) -> Int { s.size }

pub fn nlp_embed_gpt_cursor_get(s : NlpembedgptCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_gpt_cursor_set(s : NlpembedgptCursor, i : Int, v : Double) -> NlpembedgptCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_cursor_sum(s : NlpembedgptCursor) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_gpt_cursor_mean(s : NlpembedgptCursor) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_gpt_cursor_scale(s : NlpembedgptCursor, f : Double) -> NlpembedgptCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_cursor_add(a : NlpembedgptCursor, b : NlpembedgptCursor) -> NlpembedgptCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_gpt_cursor_copy(s : NlpembedgptCursor) -> NlpembedgptCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_cursor_fill(s : NlpembedgptCursor, v : Double) -> NlpembedgptCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_cursor_min(s : NlpembedgptCursor) -> Double { @_common.min(s.data) }

pub fn nlp_embed_gpt_cursor_max(s : NlpembedgptCursor) -> Double { @_common.max(s.data) }

pub fn nlp_embed_gpt_cursor_to_string(s : NlpembedgptCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedgptView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_gpt_view_make(size : Int) -> NlpembedgptView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_gpt_view_len(s : NlpembedgptView) -> Int { s.size }

pub fn nlp_embed_gpt_view_get(s : NlpembedgptView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_gpt_view_set(s : NlpembedgptView, i : Int, v : Double) -> NlpembedgptView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_view_sum(s : NlpembedgptView) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_gpt_view_mean(s : NlpembedgptView) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_gpt_view_scale(s : NlpembedgptView, f : Double) -> NlpembedgptView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_view_add(a : NlpembedgptView, b : NlpembedgptView) -> NlpembedgptView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_gpt_view_copy(s : NlpembedgptView) -> NlpembedgptView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_view_fill(s : NlpembedgptView, v : Double) -> NlpembedgptView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_view_min(s : NlpembedgptView) -> Double { @_common.min(s.data) }

pub fn nlp_embed_gpt_view_max(s : NlpembedgptView) -> Double { @_common.max(s.data) }

pub fn nlp_embed_gpt_view_to_string(s : NlpembedgptView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedgptRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_gpt_range_make(size : Int) -> NlpembedgptRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_gpt_range_len(s : NlpembedgptRange) -> Int { s.size }

pub fn nlp_embed_gpt_range_get(s : NlpembedgptRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_gpt_range_set(s : NlpembedgptRange, i : Int, v : Double) -> NlpembedgptRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_range_sum(s : NlpembedgptRange) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_gpt_range_mean(s : NlpembedgptRange) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_gpt_range_scale(s : NlpembedgptRange, f : Double) -> NlpembedgptRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_range_add(a : NlpembedgptRange, b : NlpembedgptRange) -> NlpembedgptRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_gpt_range_copy(s : NlpembedgptRange) -> NlpembedgptRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_range_fill(s : NlpembedgptRange, v : Double) -> NlpembedgptRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_range_min(s : NlpembedgptRange) -> Double { @_common.min(s.data) }

pub fn nlp_embed_gpt_range_max(s : NlpembedgptRange) -> Double { @_common.max(s.data) }

pub fn nlp_embed_gpt_range_to_string(s : NlpembedgptRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedgptSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_gpt_slice_make(size : Int) -> NlpembedgptSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_gpt_slice_len(s : NlpembedgptSlice) -> Int { s.size }

pub fn nlp_embed_gpt_slice_get(s : NlpembedgptSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_gpt_slice_set(s : NlpembedgptSlice, i : Int, v : Double) -> NlpembedgptSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_slice_sum(s : NlpembedgptSlice) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_gpt_slice_mean(s : NlpembedgptSlice) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_gpt_slice_scale(s : NlpembedgptSlice, f : Double) -> NlpembedgptSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_slice_add(a : NlpembedgptSlice, b : NlpembedgptSlice) -> NlpembedgptSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_gpt_slice_copy(s : NlpembedgptSlice) -> NlpembedgptSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_slice_fill(s : NlpembedgptSlice, v : Double) -> NlpembedgptSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_slice_min(s : NlpembedgptSlice) -> Double { @_common.min(s.data) }

pub fn nlp_embed_gpt_slice_max(s : NlpembedgptSlice) -> Double { @_common.max(s.data) }

pub fn nlp_embed_gpt_slice_to_string(s : NlpembedgptSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


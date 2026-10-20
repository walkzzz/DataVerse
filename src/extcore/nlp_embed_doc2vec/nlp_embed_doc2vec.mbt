///===
/// extcore/nlp_embed_doc2vec

pub(all) struct Nlpembeddoc2vecPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_embed_doc2vec_make_point(x : Double, y : Double) -> Nlpembeddoc2vecPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_embed_doc2vec_make_point3(x : Double, y : Double, z : Double) -> Nlpembeddoc2vecPoint {
  { x, y, z, label: 0 }
}

pub fn nlp_embed_doc2vec_point_x(pt : Nlpembeddoc2vecPoint) -> Double { pt.x }

pub fn nlp_embed_doc2vec_point_y(pt : Nlpembeddoc2vecPoint) -> Double { pt.y }

pub fn nlp_embed_doc2vec_point_z(pt : Nlpembeddoc2vecPoint) -> Double { pt.z }

pub fn nlp_embed_doc2vec_point_label(pt : Nlpembeddoc2vecPoint) -> Int { pt.label }

pub fn nlp_embed_doc2vec_point_dist(a : Nlpembeddoc2vecPoint, b : Nlpembeddoc2vecPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn nlp_embed_doc2vec_point_add(a : Nlpembeddoc2vecPoint, b : Nlpembeddoc2vecPoint) -> Nlpembeddoc2vecPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn nlp_embed_doc2vec_point_sub(a : Nlpembeddoc2vecPoint, b : Nlpembeddoc2vecPoint) -> Nlpembeddoc2vecPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn nlp_embed_doc2vec_point_scale(pt : Nlpembeddoc2vecPoint, s : Double) -> Nlpembeddoc2vecPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn nlp_embed_doc2vec_point_dot(a : Nlpembeddoc2vecPoint, b : Nlpembeddoc2vecPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn nlp_embed_doc2vec_point_cross(a : Nlpembeddoc2vecPoint, b : Nlpembeddoc2vecPoint) -> Nlpembeddoc2vecPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn nlp_embed_doc2vec_point_norm(pt : Nlpembeddoc2vecPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn nlp_embed_doc2vec_point_normalize(pt : Nlpembeddoc2vecPoint) -> Nlpembeddoc2vecPoint {
  let n = nlp_embed_doc2vec_point_norm(pt)
  if n < 0.0000001 { pt } else { nlp_embed_doc2vec_point_scale(pt, 1.0 / n) }
}

pub fn nlp_embed_doc2vec_point_negate(pt : Nlpembeddoc2vecPoint) -> Nlpembeddoc2vecPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn nlp_embed_doc2vec_point_mid(a : Nlpembeddoc2vecPoint, b : Nlpembeddoc2vecPoint) -> Nlpembeddoc2vecPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn nlp_embed_doc2vec_point_lerp(a : Nlpembeddoc2vecPoint, b : Nlpembeddoc2vecPoint, t : Double) -> Nlpembeddoc2vecPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn nlp_embed_doc2vec_point_to_string(pt : Nlpembeddoc2vecPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct Nlpembeddoc2vecSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_embed_doc2vec_make_series(vals : Array[Double], name : String) -> Nlpembeddoc2vecSeries {
  { vals, name, meta: 0 }
}

pub fn nlp_embed_doc2vec_series_len(s : Nlpembeddoc2vecSeries) -> Int { s.vals.length() }

pub fn nlp_embed_doc2vec_series_sum(s : Nlpembeddoc2vecSeries) -> Double { @_common.sum(s.vals) }

pub fn nlp_embed_doc2vec_series_mean(s : Nlpembeddoc2vecSeries) -> Double { @_common.mean(s.vals) }

pub fn nlp_embed_doc2vec_series_min(s : Nlpembeddoc2vecSeries) -> Double { @_common.min(s.vals) }

pub fn nlp_embed_doc2vec_series_max(s : Nlpembeddoc2vecSeries) -> Double { @_common.max(s.vals) }

pub fn nlp_embed_doc2vec_series_range(s : Nlpembeddoc2vecSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn nlp_embed_doc2vec_series_var(s : Nlpembeddoc2vecSeries) -> Double { @_common.variance(s.vals) }

pub fn nlp_embed_doc2vec_series_std(s : Nlpembeddoc2vecSeries) -> Double { @_common.std(s.vals) }

pub fn nlp_embed_doc2vec_series_median(s : Nlpembeddoc2vecSeries) -> Double { @_common.median(s.vals) }

pub fn nlp_embed_doc2vec_series_scale(s : Nlpembeddoc2vecSeries, f : Double) -> Nlpembeddoc2vecSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn nlp_embed_doc2vec_series_add(a : Nlpembeddoc2vecSeries, b : Nlpembeddoc2vecSeries) -> Nlpembeddoc2vecSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn nlp_embed_doc2vec_series_sub(a : Nlpembeddoc2vecSeries, b : Nlpembeddoc2vecSeries) -> Nlpembeddoc2vecSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn nlp_embed_doc2vec_series_normalize(s : Nlpembeddoc2vecSeries) -> Nlpembeddoc2vecSeries {
  let mn = nlp_embed_doc2vec_series_min(s)
  let mx = nlp_embed_doc2vec_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn nlp_embed_doc2vec_series_cumsum(s : Nlpembeddoc2vecSeries) -> Nlpembeddoc2vecSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn nlp_embed_doc2vec_series_to_string(s : Nlpembeddoc2vecSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct Nlpembeddoc2vecMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_embed_doc2vec_make_matrix(rows : Int, cols : Int, val : Double) -> Nlpembeddoc2vecMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn nlp_embed_doc2vec_matrix_identity(n : Int) -> Nlpembeddoc2vecMatrix {
  let m = nlp_embed_doc2vec_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn nlp_embed_doc2vec_matrix_get(m : Nlpembeddoc2vecMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn nlp_embed_doc2vec_matrix_transpose(m : Nlpembeddoc2vecMatrix) -> Nlpembeddoc2vecMatrix {
  let result = nlp_embed_doc2vec_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn nlp_embed_doc2vec_matrix_add(a : Nlpembeddoc2vecMatrix, b : Nlpembeddoc2vecMatrix) -> Nlpembeddoc2vecMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = nlp_embed_doc2vec_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn nlp_embed_doc2vec_matrix_scale(m : Nlpembeddoc2vecMatrix, s : Double) -> Nlpembeddoc2vecMatrix {
  let result = nlp_embed_doc2vec_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn nlp_embed_doc2vec_matrix_multiply(a : Nlpembeddoc2vecMatrix, b : Nlpembeddoc2vecMatrix) -> Nlpembeddoc2vecMatrix {
  if a.cols != b.rows { return nlp_embed_doc2vec_make_matrix(a.rows, b.cols, 0.0) }
  let result = nlp_embed_doc2vec_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn nlp_embed_doc2vec_matrix_trace(m : Nlpembeddoc2vecMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn nlp_embed_doc2vec_matrix_det(m : Nlpembeddoc2vecMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn nlp_embed_doc2vec_matrix_norm(m : Nlpembeddoc2vecMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn nlp_embed_doc2vec_matrix_to_string(m : Nlpembeddoc2vecMatrix) -> String {
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

pub(all) struct Nlpembeddoc2vecVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_embed_doc2vec_make_vector(comps : Array[Double]) -> Nlpembeddoc2vecVector {
  { comps, dim: comps.length() }
}

pub fn nlp_embed_doc2vec_vector_zero(dim : Int) -> Nlpembeddoc2vecVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn nlp_embed_doc2vec_vector_add(a : Nlpembeddoc2vecVector, b : Nlpembeddoc2vecVector) -> Nlpembeddoc2vecVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn nlp_embed_doc2vec_vector_sub(a : Nlpembeddoc2vecVector, b : Nlpembeddoc2vecVector) -> Nlpembeddoc2vecVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn nlp_embed_doc2vec_vector_scale(v : Nlpembeddoc2vecVector, s : Double) -> Nlpembeddoc2vecVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn nlp_embed_doc2vec_vector_dot(a : Nlpembeddoc2vecVector, b : Nlpembeddoc2vecVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn nlp_embed_doc2vec_vector_norm(v : Nlpembeddoc2vecVector) -> Double { @_common.sqrt(nlp_embed_doc2vec_vector_dot(v, v)) }

pub fn nlp_embed_doc2vec_vector_normalize(v : Nlpembeddoc2vecVector) -> Nlpembeddoc2vecVector {
  let n = nlp_embed_doc2vec_vector_norm(v)
  if n < 0.0000001 { v } else { nlp_embed_doc2vec_vector_scale(v, 1.0 / n) }
}

pub fn nlp_embed_doc2vec_vector_dist(a : Nlpembeddoc2vecVector, b : Nlpembeddoc2vecVector) -> Double {
  nlp_embed_doc2vec_vector_norm(nlp_embed_doc2vec_vector_sub(a, b))
}

pub fn nlp_embed_doc2vec_vector_to_string(v : Nlpembeddoc2vecVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn nlp_embed_doc2vec_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn nlp_embed_doc2vec_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn nlp_embed_doc2vec_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn nlp_embed_doc2vec_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn nlp_embed_doc2vec_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn nlp_embed_doc2vec_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn nlp_embed_doc2vec_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn nlp_embed_doc2vec_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn nlp_embed_doc2vec_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn nlp_embed_doc2vec_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn nlp_embed_doc2vec_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn nlp_embed_doc2vec_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn nlp_embed_doc2vec_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn nlp_embed_doc2vec_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn nlp_embed_doc2vec_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn nlp_embed_doc2vec_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn nlp_embed_doc2vec_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn nlp_embed_doc2vec_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn nlp_embed_doc2vec_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn nlp_embed_doc2vec_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn nlp_embed_doc2vec_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn nlp_embed_doc2vec_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn nlp_embed_doc2vec_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn nlp_embed_doc2vec_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn nlp_embed_doc2vec_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn nlp_embed_doc2vec_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn nlp_embed_doc2vec_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn nlp_embed_doc2vec_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn nlp_embed_doc2vec_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct Nlpembeddoc2vecFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_doc2vec_frame_make(size : Int) -> Nlpembeddoc2vecFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_doc2vec_frame_len(s : Nlpembeddoc2vecFrame) -> Int { s.size }

pub fn nlp_embed_doc2vec_frame_get(s : Nlpembeddoc2vecFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_doc2vec_frame_set(s : Nlpembeddoc2vecFrame, i : Int, v : Double) -> Nlpembeddoc2vecFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_frame_sum(s : Nlpembeddoc2vecFrame) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_doc2vec_frame_mean(s : Nlpembeddoc2vecFrame) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_doc2vec_frame_scale(s : Nlpembeddoc2vecFrame, f : Double) -> Nlpembeddoc2vecFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_frame_add(a : Nlpembeddoc2vecFrame, b : Nlpembeddoc2vecFrame) -> Nlpembeddoc2vecFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_doc2vec_frame_copy(s : Nlpembeddoc2vecFrame) -> Nlpembeddoc2vecFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_frame_fill(s : Nlpembeddoc2vecFrame, v : Double) -> Nlpembeddoc2vecFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_frame_min(s : Nlpembeddoc2vecFrame) -> Double { @_common.min(s.data) }

pub fn nlp_embed_doc2vec_frame_max(s : Nlpembeddoc2vecFrame) -> Double { @_common.max(s.data) }

pub fn nlp_embed_doc2vec_frame_to_string(s : Nlpembeddoc2vecFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Nlpembeddoc2vecTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_doc2vec_table_make(size : Int) -> Nlpembeddoc2vecTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_doc2vec_table_len(s : Nlpembeddoc2vecTable) -> Int { s.size }

pub fn nlp_embed_doc2vec_table_get(s : Nlpembeddoc2vecTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_doc2vec_table_set(s : Nlpembeddoc2vecTable, i : Int, v : Double) -> Nlpembeddoc2vecTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_table_sum(s : Nlpembeddoc2vecTable) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_doc2vec_table_mean(s : Nlpembeddoc2vecTable) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_doc2vec_table_scale(s : Nlpembeddoc2vecTable, f : Double) -> Nlpembeddoc2vecTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_table_add(a : Nlpembeddoc2vecTable, b : Nlpembeddoc2vecTable) -> Nlpembeddoc2vecTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_doc2vec_table_copy(s : Nlpembeddoc2vecTable) -> Nlpembeddoc2vecTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_table_fill(s : Nlpembeddoc2vecTable, v : Double) -> Nlpembeddoc2vecTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_table_min(s : Nlpembeddoc2vecTable) -> Double { @_common.min(s.data) }

pub fn nlp_embed_doc2vec_table_max(s : Nlpembeddoc2vecTable) -> Double { @_common.max(s.data) }

pub fn nlp_embed_doc2vec_table_to_string(s : Nlpembeddoc2vecTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Nlpembeddoc2vecGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_doc2vec_graphn_make(size : Int) -> Nlpembeddoc2vecGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_doc2vec_graphn_len(s : Nlpembeddoc2vecGraphN) -> Int { s.size }

pub fn nlp_embed_doc2vec_graphn_get(s : Nlpembeddoc2vecGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_doc2vec_graphn_set(s : Nlpembeddoc2vecGraphN, i : Int, v : Double) -> Nlpembeddoc2vecGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_graphn_sum(s : Nlpembeddoc2vecGraphN) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_doc2vec_graphn_mean(s : Nlpembeddoc2vecGraphN) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_doc2vec_graphn_scale(s : Nlpembeddoc2vecGraphN, f : Double) -> Nlpembeddoc2vecGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_graphn_add(a : Nlpembeddoc2vecGraphN, b : Nlpembeddoc2vecGraphN) -> Nlpembeddoc2vecGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_doc2vec_graphn_copy(s : Nlpembeddoc2vecGraphN) -> Nlpembeddoc2vecGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_graphn_fill(s : Nlpembeddoc2vecGraphN, v : Double) -> Nlpembeddoc2vecGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_graphn_min(s : Nlpembeddoc2vecGraphN) -> Double { @_common.min(s.data) }

pub fn nlp_embed_doc2vec_graphn_max(s : Nlpembeddoc2vecGraphN) -> Double { @_common.max(s.data) }

pub fn nlp_embed_doc2vec_graphn_to_string(s : Nlpembeddoc2vecGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Nlpembeddoc2vecNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_doc2vec_node_make(size : Int) -> Nlpembeddoc2vecNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_doc2vec_node_len(s : Nlpembeddoc2vecNode) -> Int { s.size }

pub fn nlp_embed_doc2vec_node_get(s : Nlpembeddoc2vecNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_doc2vec_node_set(s : Nlpembeddoc2vecNode, i : Int, v : Double) -> Nlpembeddoc2vecNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_node_sum(s : Nlpembeddoc2vecNode) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_doc2vec_node_mean(s : Nlpembeddoc2vecNode) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_doc2vec_node_scale(s : Nlpembeddoc2vecNode, f : Double) -> Nlpembeddoc2vecNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_node_add(a : Nlpembeddoc2vecNode, b : Nlpembeddoc2vecNode) -> Nlpembeddoc2vecNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_doc2vec_node_copy(s : Nlpembeddoc2vecNode) -> Nlpembeddoc2vecNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_node_fill(s : Nlpembeddoc2vecNode, v : Double) -> Nlpembeddoc2vecNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_node_min(s : Nlpembeddoc2vecNode) -> Double { @_common.min(s.data) }

pub fn nlp_embed_doc2vec_node_max(s : Nlpembeddoc2vecNode) -> Double { @_common.max(s.data) }

pub fn nlp_embed_doc2vec_node_to_string(s : Nlpembeddoc2vecNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Nlpembeddoc2vecEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_doc2vec_edge_make(size : Int) -> Nlpembeddoc2vecEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_doc2vec_edge_len(s : Nlpembeddoc2vecEdge) -> Int { s.size }

pub fn nlp_embed_doc2vec_edge_get(s : Nlpembeddoc2vecEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_doc2vec_edge_set(s : Nlpembeddoc2vecEdge, i : Int, v : Double) -> Nlpembeddoc2vecEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_edge_sum(s : Nlpembeddoc2vecEdge) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_doc2vec_edge_mean(s : Nlpembeddoc2vecEdge) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_doc2vec_edge_scale(s : Nlpembeddoc2vecEdge, f : Double) -> Nlpembeddoc2vecEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_edge_add(a : Nlpembeddoc2vecEdge, b : Nlpembeddoc2vecEdge) -> Nlpembeddoc2vecEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_doc2vec_edge_copy(s : Nlpembeddoc2vecEdge) -> Nlpembeddoc2vecEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_edge_fill(s : Nlpembeddoc2vecEdge, v : Double) -> Nlpembeddoc2vecEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_edge_min(s : Nlpembeddoc2vecEdge) -> Double { @_common.min(s.data) }

pub fn nlp_embed_doc2vec_edge_max(s : Nlpembeddoc2vecEdge) -> Double { @_common.max(s.data) }

pub fn nlp_embed_doc2vec_edge_to_string(s : Nlpembeddoc2vecEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Nlpembeddoc2vecPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_doc2vec_path_make(size : Int) -> Nlpembeddoc2vecPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_doc2vec_path_len(s : Nlpembeddoc2vecPath) -> Int { s.size }

pub fn nlp_embed_doc2vec_path_get(s : Nlpembeddoc2vecPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_doc2vec_path_set(s : Nlpembeddoc2vecPath, i : Int, v : Double) -> Nlpembeddoc2vecPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_path_sum(s : Nlpembeddoc2vecPath) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_doc2vec_path_mean(s : Nlpembeddoc2vecPath) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_doc2vec_path_scale(s : Nlpembeddoc2vecPath, f : Double) -> Nlpembeddoc2vecPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_path_add(a : Nlpembeddoc2vecPath, b : Nlpembeddoc2vecPath) -> Nlpembeddoc2vecPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_doc2vec_path_copy(s : Nlpembeddoc2vecPath) -> Nlpembeddoc2vecPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_path_fill(s : Nlpembeddoc2vecPath, v : Double) -> Nlpembeddoc2vecPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_path_min(s : Nlpembeddoc2vecPath) -> Double { @_common.min(s.data) }

pub fn nlp_embed_doc2vec_path_max(s : Nlpembeddoc2vecPath) -> Double { @_common.max(s.data) }

pub fn nlp_embed_doc2vec_path_to_string(s : Nlpembeddoc2vecPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Nlpembeddoc2vecCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_doc2vec_cluster_make(size : Int) -> Nlpembeddoc2vecCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_doc2vec_cluster_len(s : Nlpembeddoc2vecCluster) -> Int { s.size }

pub fn nlp_embed_doc2vec_cluster_get(s : Nlpembeddoc2vecCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_doc2vec_cluster_set(s : Nlpembeddoc2vecCluster, i : Int, v : Double) -> Nlpembeddoc2vecCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_cluster_sum(s : Nlpembeddoc2vecCluster) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_doc2vec_cluster_mean(s : Nlpembeddoc2vecCluster) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_doc2vec_cluster_scale(s : Nlpembeddoc2vecCluster, f : Double) -> Nlpembeddoc2vecCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_cluster_add(a : Nlpembeddoc2vecCluster, b : Nlpembeddoc2vecCluster) -> Nlpembeddoc2vecCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_doc2vec_cluster_copy(s : Nlpembeddoc2vecCluster) -> Nlpembeddoc2vecCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_cluster_fill(s : Nlpembeddoc2vecCluster, v : Double) -> Nlpembeddoc2vecCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_cluster_min(s : Nlpembeddoc2vecCluster) -> Double { @_common.min(s.data) }

pub fn nlp_embed_doc2vec_cluster_max(s : Nlpembeddoc2vecCluster) -> Double { @_common.max(s.data) }

pub fn nlp_embed_doc2vec_cluster_to_string(s : Nlpembeddoc2vecCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Nlpembeddoc2vecModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_doc2vec_model_make(size : Int) -> Nlpembeddoc2vecModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_doc2vec_model_len(s : Nlpembeddoc2vecModel) -> Int { s.size }

pub fn nlp_embed_doc2vec_model_get(s : Nlpembeddoc2vecModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_doc2vec_model_set(s : Nlpembeddoc2vecModel, i : Int, v : Double) -> Nlpembeddoc2vecModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_model_sum(s : Nlpembeddoc2vecModel) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_doc2vec_model_mean(s : Nlpembeddoc2vecModel) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_doc2vec_model_scale(s : Nlpembeddoc2vecModel, f : Double) -> Nlpembeddoc2vecModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_model_add(a : Nlpembeddoc2vecModel, b : Nlpembeddoc2vecModel) -> Nlpembeddoc2vecModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_doc2vec_model_copy(s : Nlpembeddoc2vecModel) -> Nlpembeddoc2vecModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_model_fill(s : Nlpembeddoc2vecModel, v : Double) -> Nlpembeddoc2vecModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_model_min(s : Nlpembeddoc2vecModel) -> Double { @_common.min(s.data) }

pub fn nlp_embed_doc2vec_model_max(s : Nlpembeddoc2vecModel) -> Double { @_common.max(s.data) }

pub fn nlp_embed_doc2vec_model_to_string(s : Nlpembeddoc2vecModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Nlpembeddoc2vecLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_doc2vec_layer_make(size : Int) -> Nlpembeddoc2vecLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_doc2vec_layer_len(s : Nlpembeddoc2vecLayer) -> Int { s.size }

pub fn nlp_embed_doc2vec_layer_get(s : Nlpembeddoc2vecLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_doc2vec_layer_set(s : Nlpembeddoc2vecLayer, i : Int, v : Double) -> Nlpembeddoc2vecLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_layer_sum(s : Nlpembeddoc2vecLayer) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_doc2vec_layer_mean(s : Nlpembeddoc2vecLayer) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_doc2vec_layer_scale(s : Nlpembeddoc2vecLayer, f : Double) -> Nlpembeddoc2vecLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_layer_add(a : Nlpembeddoc2vecLayer, b : Nlpembeddoc2vecLayer) -> Nlpembeddoc2vecLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_doc2vec_layer_copy(s : Nlpembeddoc2vecLayer) -> Nlpembeddoc2vecLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_layer_fill(s : Nlpembeddoc2vecLayer, v : Double) -> Nlpembeddoc2vecLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_layer_min(s : Nlpembeddoc2vecLayer) -> Double { @_common.min(s.data) }

pub fn nlp_embed_doc2vec_layer_max(s : Nlpembeddoc2vecLayer) -> Double { @_common.max(s.data) }

pub fn nlp_embed_doc2vec_layer_to_string(s : Nlpembeddoc2vecLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Nlpembeddoc2vecBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_doc2vec_buffer_make(size : Int) -> Nlpembeddoc2vecBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_doc2vec_buffer_len(s : Nlpembeddoc2vecBuffer) -> Int { s.size }

pub fn nlp_embed_doc2vec_buffer_get(s : Nlpembeddoc2vecBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_doc2vec_buffer_set(s : Nlpembeddoc2vecBuffer, i : Int, v : Double) -> Nlpembeddoc2vecBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_buffer_sum(s : Nlpembeddoc2vecBuffer) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_doc2vec_buffer_mean(s : Nlpembeddoc2vecBuffer) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_doc2vec_buffer_scale(s : Nlpembeddoc2vecBuffer, f : Double) -> Nlpembeddoc2vecBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_buffer_add(a : Nlpembeddoc2vecBuffer, b : Nlpembeddoc2vecBuffer) -> Nlpembeddoc2vecBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_doc2vec_buffer_copy(s : Nlpembeddoc2vecBuffer) -> Nlpembeddoc2vecBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_buffer_fill(s : Nlpembeddoc2vecBuffer, v : Double) -> Nlpembeddoc2vecBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_buffer_min(s : Nlpembeddoc2vecBuffer) -> Double { @_common.min(s.data) }

pub fn nlp_embed_doc2vec_buffer_max(s : Nlpembeddoc2vecBuffer) -> Double { @_common.max(s.data) }

pub fn nlp_embed_doc2vec_buffer_to_string(s : Nlpembeddoc2vecBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Nlpembeddoc2vecCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_doc2vec_cursor_make(size : Int) -> Nlpembeddoc2vecCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_doc2vec_cursor_len(s : Nlpembeddoc2vecCursor) -> Int { s.size }

pub fn nlp_embed_doc2vec_cursor_get(s : Nlpembeddoc2vecCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_doc2vec_cursor_set(s : Nlpembeddoc2vecCursor, i : Int, v : Double) -> Nlpembeddoc2vecCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_cursor_sum(s : Nlpembeddoc2vecCursor) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_doc2vec_cursor_mean(s : Nlpembeddoc2vecCursor) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_doc2vec_cursor_scale(s : Nlpembeddoc2vecCursor, f : Double) -> Nlpembeddoc2vecCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_cursor_add(a : Nlpembeddoc2vecCursor, b : Nlpembeddoc2vecCursor) -> Nlpembeddoc2vecCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_doc2vec_cursor_copy(s : Nlpembeddoc2vecCursor) -> Nlpembeddoc2vecCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_cursor_fill(s : Nlpembeddoc2vecCursor, v : Double) -> Nlpembeddoc2vecCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_cursor_min(s : Nlpembeddoc2vecCursor) -> Double { @_common.min(s.data) }

pub fn nlp_embed_doc2vec_cursor_max(s : Nlpembeddoc2vecCursor) -> Double { @_common.max(s.data) }

pub fn nlp_embed_doc2vec_cursor_to_string(s : Nlpembeddoc2vecCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Nlpembeddoc2vecView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_doc2vec_view_make(size : Int) -> Nlpembeddoc2vecView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_doc2vec_view_len(s : Nlpembeddoc2vecView) -> Int { s.size }

pub fn nlp_embed_doc2vec_view_get(s : Nlpembeddoc2vecView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_doc2vec_view_set(s : Nlpembeddoc2vecView, i : Int, v : Double) -> Nlpembeddoc2vecView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_view_sum(s : Nlpembeddoc2vecView) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_doc2vec_view_mean(s : Nlpembeddoc2vecView) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_doc2vec_view_scale(s : Nlpembeddoc2vecView, f : Double) -> Nlpembeddoc2vecView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_view_add(a : Nlpembeddoc2vecView, b : Nlpembeddoc2vecView) -> Nlpembeddoc2vecView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_doc2vec_view_copy(s : Nlpembeddoc2vecView) -> Nlpembeddoc2vecView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_view_fill(s : Nlpembeddoc2vecView, v : Double) -> Nlpembeddoc2vecView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_view_min(s : Nlpembeddoc2vecView) -> Double { @_common.min(s.data) }

pub fn nlp_embed_doc2vec_view_max(s : Nlpembeddoc2vecView) -> Double { @_common.max(s.data) }

pub fn nlp_embed_doc2vec_view_to_string(s : Nlpembeddoc2vecView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Nlpembeddoc2vecRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_doc2vec_range_make(size : Int) -> Nlpembeddoc2vecRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_doc2vec_range_len(s : Nlpembeddoc2vecRange) -> Int { s.size }

pub fn nlp_embed_doc2vec_range_get(s : Nlpembeddoc2vecRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_doc2vec_range_set(s : Nlpembeddoc2vecRange, i : Int, v : Double) -> Nlpembeddoc2vecRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_range_sum(s : Nlpembeddoc2vecRange) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_doc2vec_range_mean(s : Nlpembeddoc2vecRange) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_doc2vec_range_scale(s : Nlpembeddoc2vecRange, f : Double) -> Nlpembeddoc2vecRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_range_add(a : Nlpembeddoc2vecRange, b : Nlpembeddoc2vecRange) -> Nlpembeddoc2vecRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_doc2vec_range_copy(s : Nlpembeddoc2vecRange) -> Nlpembeddoc2vecRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_range_fill(s : Nlpembeddoc2vecRange, v : Double) -> Nlpembeddoc2vecRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_range_min(s : Nlpembeddoc2vecRange) -> Double { @_common.min(s.data) }

pub fn nlp_embed_doc2vec_range_max(s : Nlpembeddoc2vecRange) -> Double { @_common.max(s.data) }

pub fn nlp_embed_doc2vec_range_to_string(s : Nlpembeddoc2vecRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Nlpembeddoc2vecSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_doc2vec_slice_make(size : Int) -> Nlpembeddoc2vecSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_doc2vec_slice_len(s : Nlpembeddoc2vecSlice) -> Int { s.size }

pub fn nlp_embed_doc2vec_slice_get(s : Nlpembeddoc2vecSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_doc2vec_slice_set(s : Nlpembeddoc2vecSlice, i : Int, v : Double) -> Nlpembeddoc2vecSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_slice_sum(s : Nlpembeddoc2vecSlice) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_doc2vec_slice_mean(s : Nlpembeddoc2vecSlice) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_doc2vec_slice_scale(s : Nlpembeddoc2vecSlice, f : Double) -> Nlpembeddoc2vecSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_slice_add(a : Nlpembeddoc2vecSlice, b : Nlpembeddoc2vecSlice) -> Nlpembeddoc2vecSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_doc2vec_slice_copy(s : Nlpembeddoc2vecSlice) -> Nlpembeddoc2vecSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_slice_fill(s : Nlpembeddoc2vecSlice, v : Double) -> Nlpembeddoc2vecSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_slice_min(s : Nlpembeddoc2vecSlice) -> Double { @_common.min(s.data) }

pub fn nlp_embed_doc2vec_slice_max(s : Nlpembeddoc2vecSlice) -> Double { @_common.max(s.data) }

pub fn nlp_embed_doc2vec_slice_to_string(s : Nlpembeddoc2vecSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


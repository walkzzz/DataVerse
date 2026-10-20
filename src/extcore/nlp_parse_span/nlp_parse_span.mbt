///===
/// extcore/nlp_parse_span

pub(all) struct NlpparsespanPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_parse_span_make_point(x : Double, y : Double) -> NlpparsespanPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_parse_span_make_point3(x : Double, y : Double, z : Double) -> NlpparsespanPoint {
  { x, y, z, label: 0 }
}

pub fn nlp_parse_span_point_x(pt : NlpparsespanPoint) -> Double { pt.x }

pub fn nlp_parse_span_point_y(pt : NlpparsespanPoint) -> Double { pt.y }

pub fn nlp_parse_span_point_z(pt : NlpparsespanPoint) -> Double { pt.z }

pub fn nlp_parse_span_point_label(pt : NlpparsespanPoint) -> Int { pt.label }

pub fn nlp_parse_span_point_dist(a : NlpparsespanPoint, b : NlpparsespanPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn nlp_parse_span_point_add(a : NlpparsespanPoint, b : NlpparsespanPoint) -> NlpparsespanPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn nlp_parse_span_point_sub(a : NlpparsespanPoint, b : NlpparsespanPoint) -> NlpparsespanPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn nlp_parse_span_point_scale(pt : NlpparsespanPoint, s : Double) -> NlpparsespanPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn nlp_parse_span_point_dot(a : NlpparsespanPoint, b : NlpparsespanPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn nlp_parse_span_point_cross(a : NlpparsespanPoint, b : NlpparsespanPoint) -> NlpparsespanPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn nlp_parse_span_point_norm(pt : NlpparsespanPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn nlp_parse_span_point_normalize(pt : NlpparsespanPoint) -> NlpparsespanPoint {
  let n = nlp_parse_span_point_norm(pt)
  if n < 0.0000001 { pt } else { nlp_parse_span_point_scale(pt, 1.0 / n) }
}

pub fn nlp_parse_span_point_negate(pt : NlpparsespanPoint) -> NlpparsespanPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn nlp_parse_span_point_mid(a : NlpparsespanPoint, b : NlpparsespanPoint) -> NlpparsespanPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn nlp_parse_span_point_lerp(a : NlpparsespanPoint, b : NlpparsespanPoint, t : Double) -> NlpparsespanPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn nlp_parse_span_point_to_string(pt : NlpparsespanPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct NlpparsespanSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_parse_span_make_series(vals : Array[Double], name : String) -> NlpparsespanSeries {
  { vals, name, meta: 0 }
}

pub fn nlp_parse_span_series_len(s : NlpparsespanSeries) -> Int { s.vals.length() }

pub fn nlp_parse_span_series_sum(s : NlpparsespanSeries) -> Double { @_common.sum(s.vals) }

pub fn nlp_parse_span_series_mean(s : NlpparsespanSeries) -> Double { @_common.mean(s.vals) }

pub fn nlp_parse_span_series_min(s : NlpparsespanSeries) -> Double { @_common.min(s.vals) }

pub fn nlp_parse_span_series_max(s : NlpparsespanSeries) -> Double { @_common.max(s.vals) }

pub fn nlp_parse_span_series_range(s : NlpparsespanSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn nlp_parse_span_series_var(s : NlpparsespanSeries) -> Double { @_common.variance(s.vals) }

pub fn nlp_parse_span_series_std(s : NlpparsespanSeries) -> Double { @_common.std(s.vals) }

pub fn nlp_parse_span_series_median(s : NlpparsespanSeries) -> Double { @_common.median(s.vals) }

pub fn nlp_parse_span_series_scale(s : NlpparsespanSeries, f : Double) -> NlpparsespanSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn nlp_parse_span_series_add(a : NlpparsespanSeries, b : NlpparsespanSeries) -> NlpparsespanSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn nlp_parse_span_series_sub(a : NlpparsespanSeries, b : NlpparsespanSeries) -> NlpparsespanSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn nlp_parse_span_series_normalize(s : NlpparsespanSeries) -> NlpparsespanSeries {
  let mn = nlp_parse_span_series_min(s)
  let mx = nlp_parse_span_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn nlp_parse_span_series_cumsum(s : NlpparsespanSeries) -> NlpparsespanSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn nlp_parse_span_series_to_string(s : NlpparsespanSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlpparsespanMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_parse_span_make_matrix(rows : Int, cols : Int, val : Double) -> NlpparsespanMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn nlp_parse_span_matrix_identity(n : Int) -> NlpparsespanMatrix {
  let m = nlp_parse_span_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn nlp_parse_span_matrix_get(m : NlpparsespanMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn nlp_parse_span_matrix_transpose(m : NlpparsespanMatrix) -> NlpparsespanMatrix {
  let result = nlp_parse_span_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn nlp_parse_span_matrix_add(a : NlpparsespanMatrix, b : NlpparsespanMatrix) -> NlpparsespanMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = nlp_parse_span_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn nlp_parse_span_matrix_scale(m : NlpparsespanMatrix, s : Double) -> NlpparsespanMatrix {
  let result = nlp_parse_span_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn nlp_parse_span_matrix_multiply(a : NlpparsespanMatrix, b : NlpparsespanMatrix) -> NlpparsespanMatrix {
  if a.cols != b.rows { return nlp_parse_span_make_matrix(a.rows, b.cols, 0.0) }
  let result = nlp_parse_span_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn nlp_parse_span_matrix_trace(m : NlpparsespanMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn nlp_parse_span_matrix_det(m : NlpparsespanMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn nlp_parse_span_matrix_norm(m : NlpparsespanMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn nlp_parse_span_matrix_to_string(m : NlpparsespanMatrix) -> String {
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

pub(all) struct NlpparsespanVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_parse_span_make_vector(comps : Array[Double]) -> NlpparsespanVector {
  { comps, dim: comps.length() }
}

pub fn nlp_parse_span_vector_zero(dim : Int) -> NlpparsespanVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn nlp_parse_span_vector_add(a : NlpparsespanVector, b : NlpparsespanVector) -> NlpparsespanVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn nlp_parse_span_vector_sub(a : NlpparsespanVector, b : NlpparsespanVector) -> NlpparsespanVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn nlp_parse_span_vector_scale(v : NlpparsespanVector, s : Double) -> NlpparsespanVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn nlp_parse_span_vector_dot(a : NlpparsespanVector, b : NlpparsespanVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn nlp_parse_span_vector_norm(v : NlpparsespanVector) -> Double { @_common.sqrt(nlp_parse_span_vector_dot(v, v)) }

pub fn nlp_parse_span_vector_normalize(v : NlpparsespanVector) -> NlpparsespanVector {
  let n = nlp_parse_span_vector_norm(v)
  if n < 0.0000001 { v } else { nlp_parse_span_vector_scale(v, 1.0 / n) }
}

pub fn nlp_parse_span_vector_dist(a : NlpparsespanVector, b : NlpparsespanVector) -> Double {
  nlp_parse_span_vector_norm(nlp_parse_span_vector_sub(a, b))
}

pub fn nlp_parse_span_vector_to_string(v : NlpparsespanVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn nlp_parse_span_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn nlp_parse_span_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn nlp_parse_span_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn nlp_parse_span_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn nlp_parse_span_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn nlp_parse_span_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn nlp_parse_span_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn nlp_parse_span_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn nlp_parse_span_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn nlp_parse_span_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn nlp_parse_span_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn nlp_parse_span_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn nlp_parse_span_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn nlp_parse_span_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn nlp_parse_span_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn nlp_parse_span_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn nlp_parse_span_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn nlp_parse_span_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn nlp_parse_span_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn nlp_parse_span_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn nlp_parse_span_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn nlp_parse_span_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn nlp_parse_span_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn nlp_parse_span_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn nlp_parse_span_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn nlp_parse_span_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn nlp_parse_span_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn nlp_parse_span_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn nlp_parse_span_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NlpparsespanFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_span_frame_make(size : Int) -> NlpparsespanFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_span_frame_len(s : NlpparsespanFrame) -> Int { s.size }

pub fn nlp_parse_span_frame_get(s : NlpparsespanFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_span_frame_set(s : NlpparsespanFrame, i : Int, v : Double) -> NlpparsespanFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_span_frame_sum(s : NlpparsespanFrame) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_span_frame_mean(s : NlpparsespanFrame) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_span_frame_scale(s : NlpparsespanFrame, f : Double) -> NlpparsespanFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_span_frame_add(a : NlpparsespanFrame, b : NlpparsespanFrame) -> NlpparsespanFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_span_frame_copy(s : NlpparsespanFrame) -> NlpparsespanFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_span_frame_fill(s : NlpparsespanFrame, v : Double) -> NlpparsespanFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_span_frame_min(s : NlpparsespanFrame) -> Double { @_common.min(s.data) }

pub fn nlp_parse_span_frame_max(s : NlpparsespanFrame) -> Double { @_common.max(s.data) }

pub fn nlp_parse_span_frame_to_string(s : NlpparsespanFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsespanTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_span_table_make(size : Int) -> NlpparsespanTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_span_table_len(s : NlpparsespanTable) -> Int { s.size }

pub fn nlp_parse_span_table_get(s : NlpparsespanTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_span_table_set(s : NlpparsespanTable, i : Int, v : Double) -> NlpparsespanTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_span_table_sum(s : NlpparsespanTable) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_span_table_mean(s : NlpparsespanTable) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_span_table_scale(s : NlpparsespanTable, f : Double) -> NlpparsespanTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_span_table_add(a : NlpparsespanTable, b : NlpparsespanTable) -> NlpparsespanTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_span_table_copy(s : NlpparsespanTable) -> NlpparsespanTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_span_table_fill(s : NlpparsespanTable, v : Double) -> NlpparsespanTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_span_table_min(s : NlpparsespanTable) -> Double { @_common.min(s.data) }

pub fn nlp_parse_span_table_max(s : NlpparsespanTable) -> Double { @_common.max(s.data) }

pub fn nlp_parse_span_table_to_string(s : NlpparsespanTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsespanGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_span_graphn_make(size : Int) -> NlpparsespanGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_span_graphn_len(s : NlpparsespanGraphN) -> Int { s.size }

pub fn nlp_parse_span_graphn_get(s : NlpparsespanGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_span_graphn_set(s : NlpparsespanGraphN, i : Int, v : Double) -> NlpparsespanGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_span_graphn_sum(s : NlpparsespanGraphN) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_span_graphn_mean(s : NlpparsespanGraphN) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_span_graphn_scale(s : NlpparsespanGraphN, f : Double) -> NlpparsespanGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_span_graphn_add(a : NlpparsespanGraphN, b : NlpparsespanGraphN) -> NlpparsespanGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_span_graphn_copy(s : NlpparsespanGraphN) -> NlpparsespanGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_span_graphn_fill(s : NlpparsespanGraphN, v : Double) -> NlpparsespanGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_span_graphn_min(s : NlpparsespanGraphN) -> Double { @_common.min(s.data) }

pub fn nlp_parse_span_graphn_max(s : NlpparsespanGraphN) -> Double { @_common.max(s.data) }

pub fn nlp_parse_span_graphn_to_string(s : NlpparsespanGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsespanNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_span_node_make(size : Int) -> NlpparsespanNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_span_node_len(s : NlpparsespanNode) -> Int { s.size }

pub fn nlp_parse_span_node_get(s : NlpparsespanNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_span_node_set(s : NlpparsespanNode, i : Int, v : Double) -> NlpparsespanNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_span_node_sum(s : NlpparsespanNode) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_span_node_mean(s : NlpparsespanNode) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_span_node_scale(s : NlpparsespanNode, f : Double) -> NlpparsespanNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_span_node_add(a : NlpparsespanNode, b : NlpparsespanNode) -> NlpparsespanNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_span_node_copy(s : NlpparsespanNode) -> NlpparsespanNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_span_node_fill(s : NlpparsespanNode, v : Double) -> NlpparsespanNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_span_node_min(s : NlpparsespanNode) -> Double { @_common.min(s.data) }

pub fn nlp_parse_span_node_max(s : NlpparsespanNode) -> Double { @_common.max(s.data) }

pub fn nlp_parse_span_node_to_string(s : NlpparsespanNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsespanEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_span_edge_make(size : Int) -> NlpparsespanEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_span_edge_len(s : NlpparsespanEdge) -> Int { s.size }

pub fn nlp_parse_span_edge_get(s : NlpparsespanEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_span_edge_set(s : NlpparsespanEdge, i : Int, v : Double) -> NlpparsespanEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_span_edge_sum(s : NlpparsespanEdge) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_span_edge_mean(s : NlpparsespanEdge) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_span_edge_scale(s : NlpparsespanEdge, f : Double) -> NlpparsespanEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_span_edge_add(a : NlpparsespanEdge, b : NlpparsespanEdge) -> NlpparsespanEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_span_edge_copy(s : NlpparsespanEdge) -> NlpparsespanEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_span_edge_fill(s : NlpparsespanEdge, v : Double) -> NlpparsespanEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_span_edge_min(s : NlpparsespanEdge) -> Double { @_common.min(s.data) }

pub fn nlp_parse_span_edge_max(s : NlpparsespanEdge) -> Double { @_common.max(s.data) }

pub fn nlp_parse_span_edge_to_string(s : NlpparsespanEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsespanPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_span_path_make(size : Int) -> NlpparsespanPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_span_path_len(s : NlpparsespanPath) -> Int { s.size }

pub fn nlp_parse_span_path_get(s : NlpparsespanPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_span_path_set(s : NlpparsespanPath, i : Int, v : Double) -> NlpparsespanPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_span_path_sum(s : NlpparsespanPath) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_span_path_mean(s : NlpparsespanPath) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_span_path_scale(s : NlpparsespanPath, f : Double) -> NlpparsespanPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_span_path_add(a : NlpparsespanPath, b : NlpparsespanPath) -> NlpparsespanPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_span_path_copy(s : NlpparsespanPath) -> NlpparsespanPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_span_path_fill(s : NlpparsespanPath, v : Double) -> NlpparsespanPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_span_path_min(s : NlpparsespanPath) -> Double { @_common.min(s.data) }

pub fn nlp_parse_span_path_max(s : NlpparsespanPath) -> Double { @_common.max(s.data) }

pub fn nlp_parse_span_path_to_string(s : NlpparsespanPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsespanCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_span_cluster_make(size : Int) -> NlpparsespanCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_span_cluster_len(s : NlpparsespanCluster) -> Int { s.size }

pub fn nlp_parse_span_cluster_get(s : NlpparsespanCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_span_cluster_set(s : NlpparsespanCluster, i : Int, v : Double) -> NlpparsespanCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_span_cluster_sum(s : NlpparsespanCluster) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_span_cluster_mean(s : NlpparsespanCluster) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_span_cluster_scale(s : NlpparsespanCluster, f : Double) -> NlpparsespanCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_span_cluster_add(a : NlpparsespanCluster, b : NlpparsespanCluster) -> NlpparsespanCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_span_cluster_copy(s : NlpparsespanCluster) -> NlpparsespanCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_span_cluster_fill(s : NlpparsespanCluster, v : Double) -> NlpparsespanCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_span_cluster_min(s : NlpparsespanCluster) -> Double { @_common.min(s.data) }

pub fn nlp_parse_span_cluster_max(s : NlpparsespanCluster) -> Double { @_common.max(s.data) }

pub fn nlp_parse_span_cluster_to_string(s : NlpparsespanCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsespanModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_span_model_make(size : Int) -> NlpparsespanModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_span_model_len(s : NlpparsespanModel) -> Int { s.size }

pub fn nlp_parse_span_model_get(s : NlpparsespanModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_span_model_set(s : NlpparsespanModel, i : Int, v : Double) -> NlpparsespanModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_span_model_sum(s : NlpparsespanModel) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_span_model_mean(s : NlpparsespanModel) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_span_model_scale(s : NlpparsespanModel, f : Double) -> NlpparsespanModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_span_model_add(a : NlpparsespanModel, b : NlpparsespanModel) -> NlpparsespanModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_span_model_copy(s : NlpparsespanModel) -> NlpparsespanModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_span_model_fill(s : NlpparsespanModel, v : Double) -> NlpparsespanModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_span_model_min(s : NlpparsespanModel) -> Double { @_common.min(s.data) }

pub fn nlp_parse_span_model_max(s : NlpparsespanModel) -> Double { @_common.max(s.data) }

pub fn nlp_parse_span_model_to_string(s : NlpparsespanModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsespanLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_span_layer_make(size : Int) -> NlpparsespanLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_span_layer_len(s : NlpparsespanLayer) -> Int { s.size }

pub fn nlp_parse_span_layer_get(s : NlpparsespanLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_span_layer_set(s : NlpparsespanLayer, i : Int, v : Double) -> NlpparsespanLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_span_layer_sum(s : NlpparsespanLayer) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_span_layer_mean(s : NlpparsespanLayer) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_span_layer_scale(s : NlpparsespanLayer, f : Double) -> NlpparsespanLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_span_layer_add(a : NlpparsespanLayer, b : NlpparsespanLayer) -> NlpparsespanLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_span_layer_copy(s : NlpparsespanLayer) -> NlpparsespanLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_span_layer_fill(s : NlpparsespanLayer, v : Double) -> NlpparsespanLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_span_layer_min(s : NlpparsespanLayer) -> Double { @_common.min(s.data) }

pub fn nlp_parse_span_layer_max(s : NlpparsespanLayer) -> Double { @_common.max(s.data) }

pub fn nlp_parse_span_layer_to_string(s : NlpparsespanLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsespanBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_span_buffer_make(size : Int) -> NlpparsespanBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_span_buffer_len(s : NlpparsespanBuffer) -> Int { s.size }

pub fn nlp_parse_span_buffer_get(s : NlpparsespanBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_span_buffer_set(s : NlpparsespanBuffer, i : Int, v : Double) -> NlpparsespanBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_span_buffer_sum(s : NlpparsespanBuffer) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_span_buffer_mean(s : NlpparsespanBuffer) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_span_buffer_scale(s : NlpparsespanBuffer, f : Double) -> NlpparsespanBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_span_buffer_add(a : NlpparsespanBuffer, b : NlpparsespanBuffer) -> NlpparsespanBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_span_buffer_copy(s : NlpparsespanBuffer) -> NlpparsespanBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_span_buffer_fill(s : NlpparsespanBuffer, v : Double) -> NlpparsespanBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_span_buffer_min(s : NlpparsespanBuffer) -> Double { @_common.min(s.data) }

pub fn nlp_parse_span_buffer_max(s : NlpparsespanBuffer) -> Double { @_common.max(s.data) }

pub fn nlp_parse_span_buffer_to_string(s : NlpparsespanBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsespanCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_span_cursor_make(size : Int) -> NlpparsespanCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_span_cursor_len(s : NlpparsespanCursor) -> Int { s.size }

pub fn nlp_parse_span_cursor_get(s : NlpparsespanCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_span_cursor_set(s : NlpparsespanCursor, i : Int, v : Double) -> NlpparsespanCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_span_cursor_sum(s : NlpparsespanCursor) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_span_cursor_mean(s : NlpparsespanCursor) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_span_cursor_scale(s : NlpparsespanCursor, f : Double) -> NlpparsespanCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_span_cursor_add(a : NlpparsespanCursor, b : NlpparsespanCursor) -> NlpparsespanCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_span_cursor_copy(s : NlpparsespanCursor) -> NlpparsespanCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_span_cursor_fill(s : NlpparsespanCursor, v : Double) -> NlpparsespanCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_span_cursor_min(s : NlpparsespanCursor) -> Double { @_common.min(s.data) }

pub fn nlp_parse_span_cursor_max(s : NlpparsespanCursor) -> Double { @_common.max(s.data) }

pub fn nlp_parse_span_cursor_to_string(s : NlpparsespanCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsespanView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_span_view_make(size : Int) -> NlpparsespanView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_span_view_len(s : NlpparsespanView) -> Int { s.size }

pub fn nlp_parse_span_view_get(s : NlpparsespanView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_span_view_set(s : NlpparsespanView, i : Int, v : Double) -> NlpparsespanView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_span_view_sum(s : NlpparsespanView) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_span_view_mean(s : NlpparsespanView) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_span_view_scale(s : NlpparsespanView, f : Double) -> NlpparsespanView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_span_view_add(a : NlpparsespanView, b : NlpparsespanView) -> NlpparsespanView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_span_view_copy(s : NlpparsespanView) -> NlpparsespanView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_span_view_fill(s : NlpparsespanView, v : Double) -> NlpparsespanView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_span_view_min(s : NlpparsespanView) -> Double { @_common.min(s.data) }

pub fn nlp_parse_span_view_max(s : NlpparsespanView) -> Double { @_common.max(s.data) }

pub fn nlp_parse_span_view_to_string(s : NlpparsespanView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsespanRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_span_range_make(size : Int) -> NlpparsespanRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_span_range_len(s : NlpparsespanRange) -> Int { s.size }

pub fn nlp_parse_span_range_get(s : NlpparsespanRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_span_range_set(s : NlpparsespanRange, i : Int, v : Double) -> NlpparsespanRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_span_range_sum(s : NlpparsespanRange) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_span_range_mean(s : NlpparsespanRange) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_span_range_scale(s : NlpparsespanRange, f : Double) -> NlpparsespanRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_span_range_add(a : NlpparsespanRange, b : NlpparsespanRange) -> NlpparsespanRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_span_range_copy(s : NlpparsespanRange) -> NlpparsespanRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_span_range_fill(s : NlpparsespanRange, v : Double) -> NlpparsespanRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_span_range_min(s : NlpparsespanRange) -> Double { @_common.min(s.data) }

pub fn nlp_parse_span_range_max(s : NlpparsespanRange) -> Double { @_common.max(s.data) }

pub fn nlp_parse_span_range_to_string(s : NlpparsespanRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsespanSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_span_slice_make(size : Int) -> NlpparsespanSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_span_slice_len(s : NlpparsespanSlice) -> Int { s.size }

pub fn nlp_parse_span_slice_get(s : NlpparsespanSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_span_slice_set(s : NlpparsespanSlice, i : Int, v : Double) -> NlpparsespanSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_span_slice_sum(s : NlpparsespanSlice) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_span_slice_mean(s : NlpparsespanSlice) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_span_slice_scale(s : NlpparsespanSlice, f : Double) -> NlpparsespanSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_span_slice_add(a : NlpparsespanSlice, b : NlpparsespanSlice) -> NlpparsespanSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_span_slice_copy(s : NlpparsespanSlice) -> NlpparsespanSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_span_slice_fill(s : NlpparsespanSlice, v : Double) -> NlpparsespanSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_span_slice_min(s : NlpparsespanSlice) -> Double { @_common.min(s.data) }

pub fn nlp_parse_span_slice_max(s : NlpparsespanSlice) -> Double { @_common.max(s.data) }

pub fn nlp_parse_span_slice_to_string(s : NlpparsespanSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


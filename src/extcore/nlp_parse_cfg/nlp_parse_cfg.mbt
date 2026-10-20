///===
/// extcore/nlp_parse_cfg

pub(all) struct NlpparsecfgPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_parse_cfg_make_point(x : Double, y : Double) -> NlpparsecfgPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_parse_cfg_make_point3(x : Double, y : Double, z : Double) -> NlpparsecfgPoint {
  { x, y, z, label: 0 }
}

pub fn nlp_parse_cfg_point_x(pt : NlpparsecfgPoint) -> Double { pt.x }

pub fn nlp_parse_cfg_point_y(pt : NlpparsecfgPoint) -> Double { pt.y }

pub fn nlp_parse_cfg_point_z(pt : NlpparsecfgPoint) -> Double { pt.z }

pub fn nlp_parse_cfg_point_label(pt : NlpparsecfgPoint) -> Int { pt.label }

pub fn nlp_parse_cfg_point_dist(a : NlpparsecfgPoint, b : NlpparsecfgPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn nlp_parse_cfg_point_add(a : NlpparsecfgPoint, b : NlpparsecfgPoint) -> NlpparsecfgPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn nlp_parse_cfg_point_sub(a : NlpparsecfgPoint, b : NlpparsecfgPoint) -> NlpparsecfgPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn nlp_parse_cfg_point_scale(pt : NlpparsecfgPoint, s : Double) -> NlpparsecfgPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn nlp_parse_cfg_point_dot(a : NlpparsecfgPoint, b : NlpparsecfgPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn nlp_parse_cfg_point_cross(a : NlpparsecfgPoint, b : NlpparsecfgPoint) -> NlpparsecfgPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn nlp_parse_cfg_point_norm(pt : NlpparsecfgPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn nlp_parse_cfg_point_normalize(pt : NlpparsecfgPoint) -> NlpparsecfgPoint {
  let n = nlp_parse_cfg_point_norm(pt)
  if n < 0.0000001 { pt } else { nlp_parse_cfg_point_scale(pt, 1.0 / n) }
}

pub fn nlp_parse_cfg_point_negate(pt : NlpparsecfgPoint) -> NlpparsecfgPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn nlp_parse_cfg_point_mid(a : NlpparsecfgPoint, b : NlpparsecfgPoint) -> NlpparsecfgPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn nlp_parse_cfg_point_lerp(a : NlpparsecfgPoint, b : NlpparsecfgPoint, t : Double) -> NlpparsecfgPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn nlp_parse_cfg_point_to_string(pt : NlpparsecfgPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct NlpparsecfgSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_parse_cfg_make_series(vals : Array[Double], name : String) -> NlpparsecfgSeries {
  { vals, name, meta: 0 }
}

pub fn nlp_parse_cfg_series_len(s : NlpparsecfgSeries) -> Int { s.vals.length() }

pub fn nlp_parse_cfg_series_sum(s : NlpparsecfgSeries) -> Double { @_common.sum(s.vals) }

pub fn nlp_parse_cfg_series_mean(s : NlpparsecfgSeries) -> Double { @_common.mean(s.vals) }

pub fn nlp_parse_cfg_series_min(s : NlpparsecfgSeries) -> Double { @_common.min(s.vals) }

pub fn nlp_parse_cfg_series_max(s : NlpparsecfgSeries) -> Double { @_common.max(s.vals) }

pub fn nlp_parse_cfg_series_range(s : NlpparsecfgSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn nlp_parse_cfg_series_var(s : NlpparsecfgSeries) -> Double { @_common.variance(s.vals) }

pub fn nlp_parse_cfg_series_std(s : NlpparsecfgSeries) -> Double { @_common.std(s.vals) }

pub fn nlp_parse_cfg_series_median(s : NlpparsecfgSeries) -> Double { @_common.median(s.vals) }

pub fn nlp_parse_cfg_series_scale(s : NlpparsecfgSeries, f : Double) -> NlpparsecfgSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn nlp_parse_cfg_series_add(a : NlpparsecfgSeries, b : NlpparsecfgSeries) -> NlpparsecfgSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn nlp_parse_cfg_series_sub(a : NlpparsecfgSeries, b : NlpparsecfgSeries) -> NlpparsecfgSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn nlp_parse_cfg_series_normalize(s : NlpparsecfgSeries) -> NlpparsecfgSeries {
  let mn = nlp_parse_cfg_series_min(s)
  let mx = nlp_parse_cfg_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn nlp_parse_cfg_series_cumsum(s : NlpparsecfgSeries) -> NlpparsecfgSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn nlp_parse_cfg_series_to_string(s : NlpparsecfgSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlpparsecfgMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_parse_cfg_make_matrix(rows : Int, cols : Int, val : Double) -> NlpparsecfgMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn nlp_parse_cfg_matrix_identity(n : Int) -> NlpparsecfgMatrix {
  let m = nlp_parse_cfg_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn nlp_parse_cfg_matrix_get(m : NlpparsecfgMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn nlp_parse_cfg_matrix_transpose(m : NlpparsecfgMatrix) -> NlpparsecfgMatrix {
  let result = nlp_parse_cfg_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn nlp_parse_cfg_matrix_add(a : NlpparsecfgMatrix, b : NlpparsecfgMatrix) -> NlpparsecfgMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = nlp_parse_cfg_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn nlp_parse_cfg_matrix_scale(m : NlpparsecfgMatrix, s : Double) -> NlpparsecfgMatrix {
  let result = nlp_parse_cfg_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn nlp_parse_cfg_matrix_multiply(a : NlpparsecfgMatrix, b : NlpparsecfgMatrix) -> NlpparsecfgMatrix {
  if a.cols != b.rows { return nlp_parse_cfg_make_matrix(a.rows, b.cols, 0.0) }
  let result = nlp_parse_cfg_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn nlp_parse_cfg_matrix_trace(m : NlpparsecfgMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn nlp_parse_cfg_matrix_det(m : NlpparsecfgMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn nlp_parse_cfg_matrix_norm(m : NlpparsecfgMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn nlp_parse_cfg_matrix_to_string(m : NlpparsecfgMatrix) -> String {
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

pub(all) struct NlpparsecfgVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_parse_cfg_make_vector(comps : Array[Double]) -> NlpparsecfgVector {
  { comps, dim: comps.length() }
}

pub fn nlp_parse_cfg_vector_zero(dim : Int) -> NlpparsecfgVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn nlp_parse_cfg_vector_add(a : NlpparsecfgVector, b : NlpparsecfgVector) -> NlpparsecfgVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn nlp_parse_cfg_vector_sub(a : NlpparsecfgVector, b : NlpparsecfgVector) -> NlpparsecfgVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn nlp_parse_cfg_vector_scale(v : NlpparsecfgVector, s : Double) -> NlpparsecfgVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn nlp_parse_cfg_vector_dot(a : NlpparsecfgVector, b : NlpparsecfgVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn nlp_parse_cfg_vector_norm(v : NlpparsecfgVector) -> Double { @_common.sqrt(nlp_parse_cfg_vector_dot(v, v)) }

pub fn nlp_parse_cfg_vector_normalize(v : NlpparsecfgVector) -> NlpparsecfgVector {
  let n = nlp_parse_cfg_vector_norm(v)
  if n < 0.0000001 { v } else { nlp_parse_cfg_vector_scale(v, 1.0 / n) }
}

pub fn nlp_parse_cfg_vector_dist(a : NlpparsecfgVector, b : NlpparsecfgVector) -> Double {
  nlp_parse_cfg_vector_norm(nlp_parse_cfg_vector_sub(a, b))
}

pub fn nlp_parse_cfg_vector_to_string(v : NlpparsecfgVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn nlp_parse_cfg_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn nlp_parse_cfg_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn nlp_parse_cfg_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn nlp_parse_cfg_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn nlp_parse_cfg_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn nlp_parse_cfg_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn nlp_parse_cfg_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn nlp_parse_cfg_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn nlp_parse_cfg_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn nlp_parse_cfg_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn nlp_parse_cfg_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn nlp_parse_cfg_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn nlp_parse_cfg_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn nlp_parse_cfg_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn nlp_parse_cfg_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn nlp_parse_cfg_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn nlp_parse_cfg_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn nlp_parse_cfg_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn nlp_parse_cfg_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn nlp_parse_cfg_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn nlp_parse_cfg_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn nlp_parse_cfg_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn nlp_parse_cfg_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn nlp_parse_cfg_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn nlp_parse_cfg_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn nlp_parse_cfg_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn nlp_parse_cfg_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn nlp_parse_cfg_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn nlp_parse_cfg_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NlpparsecfgFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_cfg_frame_make(size : Int) -> NlpparsecfgFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_cfg_frame_len(s : NlpparsecfgFrame) -> Int { s.size }

pub fn nlp_parse_cfg_frame_get(s : NlpparsecfgFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_cfg_frame_set(s : NlpparsecfgFrame, i : Int, v : Double) -> NlpparsecfgFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_frame_sum(s : NlpparsecfgFrame) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_cfg_frame_mean(s : NlpparsecfgFrame) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_cfg_frame_scale(s : NlpparsecfgFrame, f : Double) -> NlpparsecfgFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_frame_add(a : NlpparsecfgFrame, b : NlpparsecfgFrame) -> NlpparsecfgFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_cfg_frame_copy(s : NlpparsecfgFrame) -> NlpparsecfgFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_frame_fill(s : NlpparsecfgFrame, v : Double) -> NlpparsecfgFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_frame_min(s : NlpparsecfgFrame) -> Double { @_common.min(s.data) }

pub fn nlp_parse_cfg_frame_max(s : NlpparsecfgFrame) -> Double { @_common.max(s.data) }

pub fn nlp_parse_cfg_frame_to_string(s : NlpparsecfgFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsecfgTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_cfg_table_make(size : Int) -> NlpparsecfgTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_cfg_table_len(s : NlpparsecfgTable) -> Int { s.size }

pub fn nlp_parse_cfg_table_get(s : NlpparsecfgTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_cfg_table_set(s : NlpparsecfgTable, i : Int, v : Double) -> NlpparsecfgTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_table_sum(s : NlpparsecfgTable) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_cfg_table_mean(s : NlpparsecfgTable) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_cfg_table_scale(s : NlpparsecfgTable, f : Double) -> NlpparsecfgTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_table_add(a : NlpparsecfgTable, b : NlpparsecfgTable) -> NlpparsecfgTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_cfg_table_copy(s : NlpparsecfgTable) -> NlpparsecfgTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_table_fill(s : NlpparsecfgTable, v : Double) -> NlpparsecfgTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_table_min(s : NlpparsecfgTable) -> Double { @_common.min(s.data) }

pub fn nlp_parse_cfg_table_max(s : NlpparsecfgTable) -> Double { @_common.max(s.data) }

pub fn nlp_parse_cfg_table_to_string(s : NlpparsecfgTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsecfgGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_cfg_graphn_make(size : Int) -> NlpparsecfgGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_cfg_graphn_len(s : NlpparsecfgGraphN) -> Int { s.size }

pub fn nlp_parse_cfg_graphn_get(s : NlpparsecfgGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_cfg_graphn_set(s : NlpparsecfgGraphN, i : Int, v : Double) -> NlpparsecfgGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_graphn_sum(s : NlpparsecfgGraphN) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_cfg_graphn_mean(s : NlpparsecfgGraphN) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_cfg_graphn_scale(s : NlpparsecfgGraphN, f : Double) -> NlpparsecfgGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_graphn_add(a : NlpparsecfgGraphN, b : NlpparsecfgGraphN) -> NlpparsecfgGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_cfg_graphn_copy(s : NlpparsecfgGraphN) -> NlpparsecfgGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_graphn_fill(s : NlpparsecfgGraphN, v : Double) -> NlpparsecfgGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_graphn_min(s : NlpparsecfgGraphN) -> Double { @_common.min(s.data) }

pub fn nlp_parse_cfg_graphn_max(s : NlpparsecfgGraphN) -> Double { @_common.max(s.data) }

pub fn nlp_parse_cfg_graphn_to_string(s : NlpparsecfgGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsecfgNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_cfg_node_make(size : Int) -> NlpparsecfgNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_cfg_node_len(s : NlpparsecfgNode) -> Int { s.size }

pub fn nlp_parse_cfg_node_get(s : NlpparsecfgNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_cfg_node_set(s : NlpparsecfgNode, i : Int, v : Double) -> NlpparsecfgNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_node_sum(s : NlpparsecfgNode) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_cfg_node_mean(s : NlpparsecfgNode) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_cfg_node_scale(s : NlpparsecfgNode, f : Double) -> NlpparsecfgNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_node_add(a : NlpparsecfgNode, b : NlpparsecfgNode) -> NlpparsecfgNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_cfg_node_copy(s : NlpparsecfgNode) -> NlpparsecfgNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_node_fill(s : NlpparsecfgNode, v : Double) -> NlpparsecfgNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_node_min(s : NlpparsecfgNode) -> Double { @_common.min(s.data) }

pub fn nlp_parse_cfg_node_max(s : NlpparsecfgNode) -> Double { @_common.max(s.data) }

pub fn nlp_parse_cfg_node_to_string(s : NlpparsecfgNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsecfgEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_cfg_edge_make(size : Int) -> NlpparsecfgEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_cfg_edge_len(s : NlpparsecfgEdge) -> Int { s.size }

pub fn nlp_parse_cfg_edge_get(s : NlpparsecfgEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_cfg_edge_set(s : NlpparsecfgEdge, i : Int, v : Double) -> NlpparsecfgEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_edge_sum(s : NlpparsecfgEdge) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_cfg_edge_mean(s : NlpparsecfgEdge) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_cfg_edge_scale(s : NlpparsecfgEdge, f : Double) -> NlpparsecfgEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_edge_add(a : NlpparsecfgEdge, b : NlpparsecfgEdge) -> NlpparsecfgEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_cfg_edge_copy(s : NlpparsecfgEdge) -> NlpparsecfgEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_edge_fill(s : NlpparsecfgEdge, v : Double) -> NlpparsecfgEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_edge_min(s : NlpparsecfgEdge) -> Double { @_common.min(s.data) }

pub fn nlp_parse_cfg_edge_max(s : NlpparsecfgEdge) -> Double { @_common.max(s.data) }

pub fn nlp_parse_cfg_edge_to_string(s : NlpparsecfgEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsecfgPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_cfg_path_make(size : Int) -> NlpparsecfgPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_cfg_path_len(s : NlpparsecfgPath) -> Int { s.size }

pub fn nlp_parse_cfg_path_get(s : NlpparsecfgPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_cfg_path_set(s : NlpparsecfgPath, i : Int, v : Double) -> NlpparsecfgPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_path_sum(s : NlpparsecfgPath) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_cfg_path_mean(s : NlpparsecfgPath) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_cfg_path_scale(s : NlpparsecfgPath, f : Double) -> NlpparsecfgPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_path_add(a : NlpparsecfgPath, b : NlpparsecfgPath) -> NlpparsecfgPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_cfg_path_copy(s : NlpparsecfgPath) -> NlpparsecfgPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_path_fill(s : NlpparsecfgPath, v : Double) -> NlpparsecfgPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_path_min(s : NlpparsecfgPath) -> Double { @_common.min(s.data) }

pub fn nlp_parse_cfg_path_max(s : NlpparsecfgPath) -> Double { @_common.max(s.data) }

pub fn nlp_parse_cfg_path_to_string(s : NlpparsecfgPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsecfgCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_cfg_cluster_make(size : Int) -> NlpparsecfgCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_cfg_cluster_len(s : NlpparsecfgCluster) -> Int { s.size }

pub fn nlp_parse_cfg_cluster_get(s : NlpparsecfgCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_cfg_cluster_set(s : NlpparsecfgCluster, i : Int, v : Double) -> NlpparsecfgCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_cluster_sum(s : NlpparsecfgCluster) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_cfg_cluster_mean(s : NlpparsecfgCluster) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_cfg_cluster_scale(s : NlpparsecfgCluster, f : Double) -> NlpparsecfgCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_cluster_add(a : NlpparsecfgCluster, b : NlpparsecfgCluster) -> NlpparsecfgCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_cfg_cluster_copy(s : NlpparsecfgCluster) -> NlpparsecfgCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_cluster_fill(s : NlpparsecfgCluster, v : Double) -> NlpparsecfgCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_cluster_min(s : NlpparsecfgCluster) -> Double { @_common.min(s.data) }

pub fn nlp_parse_cfg_cluster_max(s : NlpparsecfgCluster) -> Double { @_common.max(s.data) }

pub fn nlp_parse_cfg_cluster_to_string(s : NlpparsecfgCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsecfgModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_cfg_model_make(size : Int) -> NlpparsecfgModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_cfg_model_len(s : NlpparsecfgModel) -> Int { s.size }

pub fn nlp_parse_cfg_model_get(s : NlpparsecfgModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_cfg_model_set(s : NlpparsecfgModel, i : Int, v : Double) -> NlpparsecfgModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_model_sum(s : NlpparsecfgModel) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_cfg_model_mean(s : NlpparsecfgModel) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_cfg_model_scale(s : NlpparsecfgModel, f : Double) -> NlpparsecfgModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_model_add(a : NlpparsecfgModel, b : NlpparsecfgModel) -> NlpparsecfgModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_cfg_model_copy(s : NlpparsecfgModel) -> NlpparsecfgModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_model_fill(s : NlpparsecfgModel, v : Double) -> NlpparsecfgModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_model_min(s : NlpparsecfgModel) -> Double { @_common.min(s.data) }

pub fn nlp_parse_cfg_model_max(s : NlpparsecfgModel) -> Double { @_common.max(s.data) }

pub fn nlp_parse_cfg_model_to_string(s : NlpparsecfgModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsecfgLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_cfg_layer_make(size : Int) -> NlpparsecfgLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_cfg_layer_len(s : NlpparsecfgLayer) -> Int { s.size }

pub fn nlp_parse_cfg_layer_get(s : NlpparsecfgLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_cfg_layer_set(s : NlpparsecfgLayer, i : Int, v : Double) -> NlpparsecfgLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_layer_sum(s : NlpparsecfgLayer) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_cfg_layer_mean(s : NlpparsecfgLayer) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_cfg_layer_scale(s : NlpparsecfgLayer, f : Double) -> NlpparsecfgLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_layer_add(a : NlpparsecfgLayer, b : NlpparsecfgLayer) -> NlpparsecfgLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_cfg_layer_copy(s : NlpparsecfgLayer) -> NlpparsecfgLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_layer_fill(s : NlpparsecfgLayer, v : Double) -> NlpparsecfgLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_layer_min(s : NlpparsecfgLayer) -> Double { @_common.min(s.data) }

pub fn nlp_parse_cfg_layer_max(s : NlpparsecfgLayer) -> Double { @_common.max(s.data) }

pub fn nlp_parse_cfg_layer_to_string(s : NlpparsecfgLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsecfgBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_cfg_buffer_make(size : Int) -> NlpparsecfgBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_cfg_buffer_len(s : NlpparsecfgBuffer) -> Int { s.size }

pub fn nlp_parse_cfg_buffer_get(s : NlpparsecfgBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_cfg_buffer_set(s : NlpparsecfgBuffer, i : Int, v : Double) -> NlpparsecfgBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_buffer_sum(s : NlpparsecfgBuffer) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_cfg_buffer_mean(s : NlpparsecfgBuffer) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_cfg_buffer_scale(s : NlpparsecfgBuffer, f : Double) -> NlpparsecfgBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_buffer_add(a : NlpparsecfgBuffer, b : NlpparsecfgBuffer) -> NlpparsecfgBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_cfg_buffer_copy(s : NlpparsecfgBuffer) -> NlpparsecfgBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_buffer_fill(s : NlpparsecfgBuffer, v : Double) -> NlpparsecfgBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_buffer_min(s : NlpparsecfgBuffer) -> Double { @_common.min(s.data) }

pub fn nlp_parse_cfg_buffer_max(s : NlpparsecfgBuffer) -> Double { @_common.max(s.data) }

pub fn nlp_parse_cfg_buffer_to_string(s : NlpparsecfgBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsecfgCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_cfg_cursor_make(size : Int) -> NlpparsecfgCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_cfg_cursor_len(s : NlpparsecfgCursor) -> Int { s.size }

pub fn nlp_parse_cfg_cursor_get(s : NlpparsecfgCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_cfg_cursor_set(s : NlpparsecfgCursor, i : Int, v : Double) -> NlpparsecfgCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_cursor_sum(s : NlpparsecfgCursor) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_cfg_cursor_mean(s : NlpparsecfgCursor) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_cfg_cursor_scale(s : NlpparsecfgCursor, f : Double) -> NlpparsecfgCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_cursor_add(a : NlpparsecfgCursor, b : NlpparsecfgCursor) -> NlpparsecfgCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_cfg_cursor_copy(s : NlpparsecfgCursor) -> NlpparsecfgCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_cursor_fill(s : NlpparsecfgCursor, v : Double) -> NlpparsecfgCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_cursor_min(s : NlpparsecfgCursor) -> Double { @_common.min(s.data) }

pub fn nlp_parse_cfg_cursor_max(s : NlpparsecfgCursor) -> Double { @_common.max(s.data) }

pub fn nlp_parse_cfg_cursor_to_string(s : NlpparsecfgCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsecfgView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_cfg_view_make(size : Int) -> NlpparsecfgView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_cfg_view_len(s : NlpparsecfgView) -> Int { s.size }

pub fn nlp_parse_cfg_view_get(s : NlpparsecfgView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_cfg_view_set(s : NlpparsecfgView, i : Int, v : Double) -> NlpparsecfgView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_view_sum(s : NlpparsecfgView) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_cfg_view_mean(s : NlpparsecfgView) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_cfg_view_scale(s : NlpparsecfgView, f : Double) -> NlpparsecfgView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_view_add(a : NlpparsecfgView, b : NlpparsecfgView) -> NlpparsecfgView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_cfg_view_copy(s : NlpparsecfgView) -> NlpparsecfgView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_view_fill(s : NlpparsecfgView, v : Double) -> NlpparsecfgView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_view_min(s : NlpparsecfgView) -> Double { @_common.min(s.data) }

pub fn nlp_parse_cfg_view_max(s : NlpparsecfgView) -> Double { @_common.max(s.data) }

pub fn nlp_parse_cfg_view_to_string(s : NlpparsecfgView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsecfgRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_cfg_range_make(size : Int) -> NlpparsecfgRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_cfg_range_len(s : NlpparsecfgRange) -> Int { s.size }

pub fn nlp_parse_cfg_range_get(s : NlpparsecfgRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_cfg_range_set(s : NlpparsecfgRange, i : Int, v : Double) -> NlpparsecfgRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_range_sum(s : NlpparsecfgRange) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_cfg_range_mean(s : NlpparsecfgRange) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_cfg_range_scale(s : NlpparsecfgRange, f : Double) -> NlpparsecfgRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_range_add(a : NlpparsecfgRange, b : NlpparsecfgRange) -> NlpparsecfgRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_cfg_range_copy(s : NlpparsecfgRange) -> NlpparsecfgRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_range_fill(s : NlpparsecfgRange, v : Double) -> NlpparsecfgRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_range_min(s : NlpparsecfgRange) -> Double { @_common.min(s.data) }

pub fn nlp_parse_cfg_range_max(s : NlpparsecfgRange) -> Double { @_common.max(s.data) }

pub fn nlp_parse_cfg_range_to_string(s : NlpparsecfgRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsecfgSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_cfg_slice_make(size : Int) -> NlpparsecfgSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_cfg_slice_len(s : NlpparsecfgSlice) -> Int { s.size }

pub fn nlp_parse_cfg_slice_get(s : NlpparsecfgSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_cfg_slice_set(s : NlpparsecfgSlice, i : Int, v : Double) -> NlpparsecfgSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_slice_sum(s : NlpparsecfgSlice) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_cfg_slice_mean(s : NlpparsecfgSlice) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_cfg_slice_scale(s : NlpparsecfgSlice, f : Double) -> NlpparsecfgSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_slice_add(a : NlpparsecfgSlice, b : NlpparsecfgSlice) -> NlpparsecfgSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_parse_cfg_slice_copy(s : NlpparsecfgSlice) -> NlpparsecfgSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_slice_fill(s : NlpparsecfgSlice, v : Double) -> NlpparsecfgSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_parse_cfg_slice_min(s : NlpparsecfgSlice) -> Double { @_common.min(s.data) }

pub fn nlp_parse_cfg_slice_max(s : NlpparsecfgSlice) -> Double { @_common.max(s.data) }

pub fn nlp_parse_cfg_slice_to_string(s : NlpparsecfgSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


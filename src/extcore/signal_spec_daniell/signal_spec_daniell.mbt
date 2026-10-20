///===
/// extcore/signal_spec_daniell

pub(all) struct SignalspecdaniellPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_spec_daniell_make_point(x : Double, y : Double) -> SignalspecdaniellPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_spec_daniell_make_point3(x : Double, y : Double, z : Double) -> SignalspecdaniellPoint {
  { x, y, z, label: 0 }
}

pub fn signal_spec_daniell_point_x(pt : SignalspecdaniellPoint) -> Double { pt.x }

pub fn signal_spec_daniell_point_y(pt : SignalspecdaniellPoint) -> Double { pt.y }

pub fn signal_spec_daniell_point_z(pt : SignalspecdaniellPoint) -> Double { pt.z }

pub fn signal_spec_daniell_point_label(pt : SignalspecdaniellPoint) -> Int { pt.label }

pub fn signal_spec_daniell_point_dist(a : SignalspecdaniellPoint, b : SignalspecdaniellPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn signal_spec_daniell_point_add(a : SignalspecdaniellPoint, b : SignalspecdaniellPoint) -> SignalspecdaniellPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn signal_spec_daniell_point_sub(a : SignalspecdaniellPoint, b : SignalspecdaniellPoint) -> SignalspecdaniellPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn signal_spec_daniell_point_scale(pt : SignalspecdaniellPoint, s : Double) -> SignalspecdaniellPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn signal_spec_daniell_point_dot(a : SignalspecdaniellPoint, b : SignalspecdaniellPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn signal_spec_daniell_point_cross(a : SignalspecdaniellPoint, b : SignalspecdaniellPoint) -> SignalspecdaniellPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn signal_spec_daniell_point_norm(pt : SignalspecdaniellPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn signal_spec_daniell_point_normalize(pt : SignalspecdaniellPoint) -> SignalspecdaniellPoint {
  let n = signal_spec_daniell_point_norm(pt)
  if n < 0.0000001 { pt } else { signal_spec_daniell_point_scale(pt, 1.0 / n) }
}

pub fn signal_spec_daniell_point_negate(pt : SignalspecdaniellPoint) -> SignalspecdaniellPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn signal_spec_daniell_point_mid(a : SignalspecdaniellPoint, b : SignalspecdaniellPoint) -> SignalspecdaniellPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn signal_spec_daniell_point_lerp(a : SignalspecdaniellPoint, b : SignalspecdaniellPoint, t : Double) -> SignalspecdaniellPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn signal_spec_daniell_point_to_string(pt : SignalspecdaniellPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct SignalspecdaniellSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_spec_daniell_make_series(vals : Array[Double], name : String) -> SignalspecdaniellSeries {
  { vals, name, meta: 0 }
}

pub fn signal_spec_daniell_series_len(s : SignalspecdaniellSeries) -> Int { s.vals.length() }

pub fn signal_spec_daniell_series_sum(s : SignalspecdaniellSeries) -> Double { @_common.sum(s.vals) }

pub fn signal_spec_daniell_series_mean(s : SignalspecdaniellSeries) -> Double { @_common.mean(s.vals) }

pub fn signal_spec_daniell_series_min(s : SignalspecdaniellSeries) -> Double { @_common.min(s.vals) }

pub fn signal_spec_daniell_series_max(s : SignalspecdaniellSeries) -> Double { @_common.max(s.vals) }

pub fn signal_spec_daniell_series_range(s : SignalspecdaniellSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn signal_spec_daniell_series_var(s : SignalspecdaniellSeries) -> Double { @_common.variance(s.vals) }

pub fn signal_spec_daniell_series_std(s : SignalspecdaniellSeries) -> Double { @_common.std(s.vals) }

pub fn signal_spec_daniell_series_median(s : SignalspecdaniellSeries) -> Double { @_common.median(s.vals) }

pub fn signal_spec_daniell_series_scale(s : SignalspecdaniellSeries, f : Double) -> SignalspecdaniellSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn signal_spec_daniell_series_add(a : SignalspecdaniellSeries, b : SignalspecdaniellSeries) -> SignalspecdaniellSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn signal_spec_daniell_series_sub(a : SignalspecdaniellSeries, b : SignalspecdaniellSeries) -> SignalspecdaniellSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn signal_spec_daniell_series_normalize(s : SignalspecdaniellSeries) -> SignalspecdaniellSeries {
  let mn = signal_spec_daniell_series_min(s)
  let mx = signal_spec_daniell_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn signal_spec_daniell_series_cumsum(s : SignalspecdaniellSeries) -> SignalspecdaniellSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn signal_spec_daniell_series_to_string(s : SignalspecdaniellSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignalspecdaniellMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_spec_daniell_make_matrix(rows : Int, cols : Int, val : Double) -> SignalspecdaniellMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn signal_spec_daniell_matrix_identity(n : Int) -> SignalspecdaniellMatrix {
  let m = signal_spec_daniell_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn signal_spec_daniell_matrix_get(m : SignalspecdaniellMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn signal_spec_daniell_matrix_transpose(m : SignalspecdaniellMatrix) -> SignalspecdaniellMatrix {
  let result = signal_spec_daniell_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn signal_spec_daniell_matrix_add(a : SignalspecdaniellMatrix, b : SignalspecdaniellMatrix) -> SignalspecdaniellMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = signal_spec_daniell_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn signal_spec_daniell_matrix_scale(m : SignalspecdaniellMatrix, s : Double) -> SignalspecdaniellMatrix {
  let result = signal_spec_daniell_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn signal_spec_daniell_matrix_multiply(a : SignalspecdaniellMatrix, b : SignalspecdaniellMatrix) -> SignalspecdaniellMatrix {
  if a.cols != b.rows { return signal_spec_daniell_make_matrix(a.rows, b.cols, 0.0) }
  let result = signal_spec_daniell_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn signal_spec_daniell_matrix_trace(m : SignalspecdaniellMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn signal_spec_daniell_matrix_det(m : SignalspecdaniellMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn signal_spec_daniell_matrix_norm(m : SignalspecdaniellMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn signal_spec_daniell_matrix_to_string(m : SignalspecdaniellMatrix) -> String {
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

pub(all) struct SignalspecdaniellVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_spec_daniell_make_vector(comps : Array[Double]) -> SignalspecdaniellVector {
  { comps, dim: comps.length() }
}

pub fn signal_spec_daniell_vector_zero(dim : Int) -> SignalspecdaniellVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn signal_spec_daniell_vector_add(a : SignalspecdaniellVector, b : SignalspecdaniellVector) -> SignalspecdaniellVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn signal_spec_daniell_vector_sub(a : SignalspecdaniellVector, b : SignalspecdaniellVector) -> SignalspecdaniellVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn signal_spec_daniell_vector_scale(v : SignalspecdaniellVector, s : Double) -> SignalspecdaniellVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn signal_spec_daniell_vector_dot(a : SignalspecdaniellVector, b : SignalspecdaniellVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn signal_spec_daniell_vector_norm(v : SignalspecdaniellVector) -> Double { @_common.sqrt(signal_spec_daniell_vector_dot(v, v)) }

pub fn signal_spec_daniell_vector_normalize(v : SignalspecdaniellVector) -> SignalspecdaniellVector {
  let n = signal_spec_daniell_vector_norm(v)
  if n < 0.0000001 { v } else { signal_spec_daniell_vector_scale(v, 1.0 / n) }
}

pub fn signal_spec_daniell_vector_dist(a : SignalspecdaniellVector, b : SignalspecdaniellVector) -> Double {
  signal_spec_daniell_vector_norm(signal_spec_daniell_vector_sub(a, b))
}

pub fn signal_spec_daniell_vector_to_string(v : SignalspecdaniellVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn signal_spec_daniell_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn signal_spec_daniell_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn signal_spec_daniell_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn signal_spec_daniell_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn signal_spec_daniell_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn signal_spec_daniell_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn signal_spec_daniell_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn signal_spec_daniell_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn signal_spec_daniell_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn signal_spec_daniell_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn signal_spec_daniell_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn signal_spec_daniell_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn signal_spec_daniell_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn signal_spec_daniell_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn signal_spec_daniell_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn signal_spec_daniell_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn signal_spec_daniell_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn signal_spec_daniell_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn signal_spec_daniell_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn signal_spec_daniell_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn signal_spec_daniell_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn signal_spec_daniell_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn signal_spec_daniell_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn signal_spec_daniell_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn signal_spec_daniell_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn signal_spec_daniell_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn signal_spec_daniell_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn signal_spec_daniell_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn signal_spec_daniell_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SignalspecdaniellFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_daniell_frame_make(size : Int) -> SignalspecdaniellFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_daniell_frame_len(s : SignalspecdaniellFrame) -> Int { s.size }

pub fn signal_spec_daniell_frame_get(s : SignalspecdaniellFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_daniell_frame_set(s : SignalspecdaniellFrame, i : Int, v : Double) -> SignalspecdaniellFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_frame_sum(s : SignalspecdaniellFrame) -> Double { @_common.sum(s.data) }

pub fn signal_spec_daniell_frame_mean(s : SignalspecdaniellFrame) -> Double { @_common.mean(s.data) }

pub fn signal_spec_daniell_frame_scale(s : SignalspecdaniellFrame, f : Double) -> SignalspecdaniellFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_frame_add(a : SignalspecdaniellFrame, b : SignalspecdaniellFrame) -> SignalspecdaniellFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_daniell_frame_copy(s : SignalspecdaniellFrame) -> SignalspecdaniellFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_frame_fill(s : SignalspecdaniellFrame, v : Double) -> SignalspecdaniellFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_frame_min(s : SignalspecdaniellFrame) -> Double { @_common.min(s.data) }

pub fn signal_spec_daniell_frame_max(s : SignalspecdaniellFrame) -> Double { @_common.max(s.data) }

pub fn signal_spec_daniell_frame_to_string(s : SignalspecdaniellFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecdaniellTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_daniell_table_make(size : Int) -> SignalspecdaniellTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_daniell_table_len(s : SignalspecdaniellTable) -> Int { s.size }

pub fn signal_spec_daniell_table_get(s : SignalspecdaniellTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_daniell_table_set(s : SignalspecdaniellTable, i : Int, v : Double) -> SignalspecdaniellTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_table_sum(s : SignalspecdaniellTable) -> Double { @_common.sum(s.data) }

pub fn signal_spec_daniell_table_mean(s : SignalspecdaniellTable) -> Double { @_common.mean(s.data) }

pub fn signal_spec_daniell_table_scale(s : SignalspecdaniellTable, f : Double) -> SignalspecdaniellTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_table_add(a : SignalspecdaniellTable, b : SignalspecdaniellTable) -> SignalspecdaniellTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_daniell_table_copy(s : SignalspecdaniellTable) -> SignalspecdaniellTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_table_fill(s : SignalspecdaniellTable, v : Double) -> SignalspecdaniellTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_table_min(s : SignalspecdaniellTable) -> Double { @_common.min(s.data) }

pub fn signal_spec_daniell_table_max(s : SignalspecdaniellTable) -> Double { @_common.max(s.data) }

pub fn signal_spec_daniell_table_to_string(s : SignalspecdaniellTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecdaniellGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_daniell_graphn_make(size : Int) -> SignalspecdaniellGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_daniell_graphn_len(s : SignalspecdaniellGraphN) -> Int { s.size }

pub fn signal_spec_daniell_graphn_get(s : SignalspecdaniellGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_daniell_graphn_set(s : SignalspecdaniellGraphN, i : Int, v : Double) -> SignalspecdaniellGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_graphn_sum(s : SignalspecdaniellGraphN) -> Double { @_common.sum(s.data) }

pub fn signal_spec_daniell_graphn_mean(s : SignalspecdaniellGraphN) -> Double { @_common.mean(s.data) }

pub fn signal_spec_daniell_graphn_scale(s : SignalspecdaniellGraphN, f : Double) -> SignalspecdaniellGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_graphn_add(a : SignalspecdaniellGraphN, b : SignalspecdaniellGraphN) -> SignalspecdaniellGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_daniell_graphn_copy(s : SignalspecdaniellGraphN) -> SignalspecdaniellGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_graphn_fill(s : SignalspecdaniellGraphN, v : Double) -> SignalspecdaniellGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_graphn_min(s : SignalspecdaniellGraphN) -> Double { @_common.min(s.data) }

pub fn signal_spec_daniell_graphn_max(s : SignalspecdaniellGraphN) -> Double { @_common.max(s.data) }

pub fn signal_spec_daniell_graphn_to_string(s : SignalspecdaniellGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecdaniellNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_daniell_node_make(size : Int) -> SignalspecdaniellNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_daniell_node_len(s : SignalspecdaniellNode) -> Int { s.size }

pub fn signal_spec_daniell_node_get(s : SignalspecdaniellNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_daniell_node_set(s : SignalspecdaniellNode, i : Int, v : Double) -> SignalspecdaniellNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_node_sum(s : SignalspecdaniellNode) -> Double { @_common.sum(s.data) }

pub fn signal_spec_daniell_node_mean(s : SignalspecdaniellNode) -> Double { @_common.mean(s.data) }

pub fn signal_spec_daniell_node_scale(s : SignalspecdaniellNode, f : Double) -> SignalspecdaniellNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_node_add(a : SignalspecdaniellNode, b : SignalspecdaniellNode) -> SignalspecdaniellNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_daniell_node_copy(s : SignalspecdaniellNode) -> SignalspecdaniellNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_node_fill(s : SignalspecdaniellNode, v : Double) -> SignalspecdaniellNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_node_min(s : SignalspecdaniellNode) -> Double { @_common.min(s.data) }

pub fn signal_spec_daniell_node_max(s : SignalspecdaniellNode) -> Double { @_common.max(s.data) }

pub fn signal_spec_daniell_node_to_string(s : SignalspecdaniellNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecdaniellEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_daniell_edge_make(size : Int) -> SignalspecdaniellEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_daniell_edge_len(s : SignalspecdaniellEdge) -> Int { s.size }

pub fn signal_spec_daniell_edge_get(s : SignalspecdaniellEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_daniell_edge_set(s : SignalspecdaniellEdge, i : Int, v : Double) -> SignalspecdaniellEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_edge_sum(s : SignalspecdaniellEdge) -> Double { @_common.sum(s.data) }

pub fn signal_spec_daniell_edge_mean(s : SignalspecdaniellEdge) -> Double { @_common.mean(s.data) }

pub fn signal_spec_daniell_edge_scale(s : SignalspecdaniellEdge, f : Double) -> SignalspecdaniellEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_edge_add(a : SignalspecdaniellEdge, b : SignalspecdaniellEdge) -> SignalspecdaniellEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_daniell_edge_copy(s : SignalspecdaniellEdge) -> SignalspecdaniellEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_edge_fill(s : SignalspecdaniellEdge, v : Double) -> SignalspecdaniellEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_edge_min(s : SignalspecdaniellEdge) -> Double { @_common.min(s.data) }

pub fn signal_spec_daniell_edge_max(s : SignalspecdaniellEdge) -> Double { @_common.max(s.data) }

pub fn signal_spec_daniell_edge_to_string(s : SignalspecdaniellEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecdaniellPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_daniell_path_make(size : Int) -> SignalspecdaniellPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_daniell_path_len(s : SignalspecdaniellPath) -> Int { s.size }

pub fn signal_spec_daniell_path_get(s : SignalspecdaniellPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_daniell_path_set(s : SignalspecdaniellPath, i : Int, v : Double) -> SignalspecdaniellPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_path_sum(s : SignalspecdaniellPath) -> Double { @_common.sum(s.data) }

pub fn signal_spec_daniell_path_mean(s : SignalspecdaniellPath) -> Double { @_common.mean(s.data) }

pub fn signal_spec_daniell_path_scale(s : SignalspecdaniellPath, f : Double) -> SignalspecdaniellPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_path_add(a : SignalspecdaniellPath, b : SignalspecdaniellPath) -> SignalspecdaniellPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_daniell_path_copy(s : SignalspecdaniellPath) -> SignalspecdaniellPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_path_fill(s : SignalspecdaniellPath, v : Double) -> SignalspecdaniellPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_path_min(s : SignalspecdaniellPath) -> Double { @_common.min(s.data) }

pub fn signal_spec_daniell_path_max(s : SignalspecdaniellPath) -> Double { @_common.max(s.data) }

pub fn signal_spec_daniell_path_to_string(s : SignalspecdaniellPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecdaniellCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_daniell_cluster_make(size : Int) -> SignalspecdaniellCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_daniell_cluster_len(s : SignalspecdaniellCluster) -> Int { s.size }

pub fn signal_spec_daniell_cluster_get(s : SignalspecdaniellCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_daniell_cluster_set(s : SignalspecdaniellCluster, i : Int, v : Double) -> SignalspecdaniellCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_cluster_sum(s : SignalspecdaniellCluster) -> Double { @_common.sum(s.data) }

pub fn signal_spec_daniell_cluster_mean(s : SignalspecdaniellCluster) -> Double { @_common.mean(s.data) }

pub fn signal_spec_daniell_cluster_scale(s : SignalspecdaniellCluster, f : Double) -> SignalspecdaniellCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_cluster_add(a : SignalspecdaniellCluster, b : SignalspecdaniellCluster) -> SignalspecdaniellCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_daniell_cluster_copy(s : SignalspecdaniellCluster) -> SignalspecdaniellCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_cluster_fill(s : SignalspecdaniellCluster, v : Double) -> SignalspecdaniellCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_cluster_min(s : SignalspecdaniellCluster) -> Double { @_common.min(s.data) }

pub fn signal_spec_daniell_cluster_max(s : SignalspecdaniellCluster) -> Double { @_common.max(s.data) }

pub fn signal_spec_daniell_cluster_to_string(s : SignalspecdaniellCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecdaniellModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_daniell_model_make(size : Int) -> SignalspecdaniellModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_daniell_model_len(s : SignalspecdaniellModel) -> Int { s.size }

pub fn signal_spec_daniell_model_get(s : SignalspecdaniellModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_daniell_model_set(s : SignalspecdaniellModel, i : Int, v : Double) -> SignalspecdaniellModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_model_sum(s : SignalspecdaniellModel) -> Double { @_common.sum(s.data) }

pub fn signal_spec_daniell_model_mean(s : SignalspecdaniellModel) -> Double { @_common.mean(s.data) }

pub fn signal_spec_daniell_model_scale(s : SignalspecdaniellModel, f : Double) -> SignalspecdaniellModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_model_add(a : SignalspecdaniellModel, b : SignalspecdaniellModel) -> SignalspecdaniellModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_daniell_model_copy(s : SignalspecdaniellModel) -> SignalspecdaniellModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_model_fill(s : SignalspecdaniellModel, v : Double) -> SignalspecdaniellModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_model_min(s : SignalspecdaniellModel) -> Double { @_common.min(s.data) }

pub fn signal_spec_daniell_model_max(s : SignalspecdaniellModel) -> Double { @_common.max(s.data) }

pub fn signal_spec_daniell_model_to_string(s : SignalspecdaniellModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecdaniellLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_daniell_layer_make(size : Int) -> SignalspecdaniellLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_daniell_layer_len(s : SignalspecdaniellLayer) -> Int { s.size }

pub fn signal_spec_daniell_layer_get(s : SignalspecdaniellLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_daniell_layer_set(s : SignalspecdaniellLayer, i : Int, v : Double) -> SignalspecdaniellLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_layer_sum(s : SignalspecdaniellLayer) -> Double { @_common.sum(s.data) }

pub fn signal_spec_daniell_layer_mean(s : SignalspecdaniellLayer) -> Double { @_common.mean(s.data) }

pub fn signal_spec_daniell_layer_scale(s : SignalspecdaniellLayer, f : Double) -> SignalspecdaniellLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_layer_add(a : SignalspecdaniellLayer, b : SignalspecdaniellLayer) -> SignalspecdaniellLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_daniell_layer_copy(s : SignalspecdaniellLayer) -> SignalspecdaniellLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_layer_fill(s : SignalspecdaniellLayer, v : Double) -> SignalspecdaniellLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_layer_min(s : SignalspecdaniellLayer) -> Double { @_common.min(s.data) }

pub fn signal_spec_daniell_layer_max(s : SignalspecdaniellLayer) -> Double { @_common.max(s.data) }

pub fn signal_spec_daniell_layer_to_string(s : SignalspecdaniellLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecdaniellBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_daniell_buffer_make(size : Int) -> SignalspecdaniellBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_daniell_buffer_len(s : SignalspecdaniellBuffer) -> Int { s.size }

pub fn signal_spec_daniell_buffer_get(s : SignalspecdaniellBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_daniell_buffer_set(s : SignalspecdaniellBuffer, i : Int, v : Double) -> SignalspecdaniellBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_buffer_sum(s : SignalspecdaniellBuffer) -> Double { @_common.sum(s.data) }

pub fn signal_spec_daniell_buffer_mean(s : SignalspecdaniellBuffer) -> Double { @_common.mean(s.data) }

pub fn signal_spec_daniell_buffer_scale(s : SignalspecdaniellBuffer, f : Double) -> SignalspecdaniellBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_buffer_add(a : SignalspecdaniellBuffer, b : SignalspecdaniellBuffer) -> SignalspecdaniellBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_daniell_buffer_copy(s : SignalspecdaniellBuffer) -> SignalspecdaniellBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_buffer_fill(s : SignalspecdaniellBuffer, v : Double) -> SignalspecdaniellBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_buffer_min(s : SignalspecdaniellBuffer) -> Double { @_common.min(s.data) }

pub fn signal_spec_daniell_buffer_max(s : SignalspecdaniellBuffer) -> Double { @_common.max(s.data) }

pub fn signal_spec_daniell_buffer_to_string(s : SignalspecdaniellBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecdaniellCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_daniell_cursor_make(size : Int) -> SignalspecdaniellCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_daniell_cursor_len(s : SignalspecdaniellCursor) -> Int { s.size }

pub fn signal_spec_daniell_cursor_get(s : SignalspecdaniellCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_daniell_cursor_set(s : SignalspecdaniellCursor, i : Int, v : Double) -> SignalspecdaniellCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_cursor_sum(s : SignalspecdaniellCursor) -> Double { @_common.sum(s.data) }

pub fn signal_spec_daniell_cursor_mean(s : SignalspecdaniellCursor) -> Double { @_common.mean(s.data) }

pub fn signal_spec_daniell_cursor_scale(s : SignalspecdaniellCursor, f : Double) -> SignalspecdaniellCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_cursor_add(a : SignalspecdaniellCursor, b : SignalspecdaniellCursor) -> SignalspecdaniellCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_daniell_cursor_copy(s : SignalspecdaniellCursor) -> SignalspecdaniellCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_cursor_fill(s : SignalspecdaniellCursor, v : Double) -> SignalspecdaniellCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_cursor_min(s : SignalspecdaniellCursor) -> Double { @_common.min(s.data) }

pub fn signal_spec_daniell_cursor_max(s : SignalspecdaniellCursor) -> Double { @_common.max(s.data) }

pub fn signal_spec_daniell_cursor_to_string(s : SignalspecdaniellCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecdaniellView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_daniell_view_make(size : Int) -> SignalspecdaniellView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_daniell_view_len(s : SignalspecdaniellView) -> Int { s.size }

pub fn signal_spec_daniell_view_get(s : SignalspecdaniellView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_daniell_view_set(s : SignalspecdaniellView, i : Int, v : Double) -> SignalspecdaniellView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_view_sum(s : SignalspecdaniellView) -> Double { @_common.sum(s.data) }

pub fn signal_spec_daniell_view_mean(s : SignalspecdaniellView) -> Double { @_common.mean(s.data) }

pub fn signal_spec_daniell_view_scale(s : SignalspecdaniellView, f : Double) -> SignalspecdaniellView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_view_add(a : SignalspecdaniellView, b : SignalspecdaniellView) -> SignalspecdaniellView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_daniell_view_copy(s : SignalspecdaniellView) -> SignalspecdaniellView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_view_fill(s : SignalspecdaniellView, v : Double) -> SignalspecdaniellView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_view_min(s : SignalspecdaniellView) -> Double { @_common.min(s.data) }

pub fn signal_spec_daniell_view_max(s : SignalspecdaniellView) -> Double { @_common.max(s.data) }

pub fn signal_spec_daniell_view_to_string(s : SignalspecdaniellView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecdaniellRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_daniell_range_make(size : Int) -> SignalspecdaniellRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_daniell_range_len(s : SignalspecdaniellRange) -> Int { s.size }

pub fn signal_spec_daniell_range_get(s : SignalspecdaniellRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_daniell_range_set(s : SignalspecdaniellRange, i : Int, v : Double) -> SignalspecdaniellRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_range_sum(s : SignalspecdaniellRange) -> Double { @_common.sum(s.data) }

pub fn signal_spec_daniell_range_mean(s : SignalspecdaniellRange) -> Double { @_common.mean(s.data) }

pub fn signal_spec_daniell_range_scale(s : SignalspecdaniellRange, f : Double) -> SignalspecdaniellRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_range_add(a : SignalspecdaniellRange, b : SignalspecdaniellRange) -> SignalspecdaniellRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_daniell_range_copy(s : SignalspecdaniellRange) -> SignalspecdaniellRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_range_fill(s : SignalspecdaniellRange, v : Double) -> SignalspecdaniellRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_range_min(s : SignalspecdaniellRange) -> Double { @_common.min(s.data) }

pub fn signal_spec_daniell_range_max(s : SignalspecdaniellRange) -> Double { @_common.max(s.data) }

pub fn signal_spec_daniell_range_to_string(s : SignalspecdaniellRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecdaniellSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_daniell_slice_make(size : Int) -> SignalspecdaniellSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_daniell_slice_len(s : SignalspecdaniellSlice) -> Int { s.size }

pub fn signal_spec_daniell_slice_get(s : SignalspecdaniellSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_daniell_slice_set(s : SignalspecdaniellSlice, i : Int, v : Double) -> SignalspecdaniellSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_slice_sum(s : SignalspecdaniellSlice) -> Double { @_common.sum(s.data) }

pub fn signal_spec_daniell_slice_mean(s : SignalspecdaniellSlice) -> Double { @_common.mean(s.data) }

pub fn signal_spec_daniell_slice_scale(s : SignalspecdaniellSlice, f : Double) -> SignalspecdaniellSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_slice_add(a : SignalspecdaniellSlice, b : SignalspecdaniellSlice) -> SignalspecdaniellSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_daniell_slice_copy(s : SignalspecdaniellSlice) -> SignalspecdaniellSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_slice_fill(s : SignalspecdaniellSlice, v : Double) -> SignalspecdaniellSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_daniell_slice_min(s : SignalspecdaniellSlice) -> Double { @_common.min(s.data) }

pub fn signal_spec_daniell_slice_max(s : SignalspecdaniellSlice) -> Double { @_common.max(s.data) }

pub fn signal_spec_daniell_slice_to_string(s : SignalspecdaniellSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


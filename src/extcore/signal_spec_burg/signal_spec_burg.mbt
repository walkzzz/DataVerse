///===
/// extcore/signal_spec_burg

pub(all) struct SignalspecburgPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_spec_burg_make_point(x : Double, y : Double) -> SignalspecburgPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_spec_burg_make_point3(x : Double, y : Double, z : Double) -> SignalspecburgPoint {
  { x, y, z, label: 0 }
}

pub fn signal_spec_burg_point_x(pt : SignalspecburgPoint) -> Double { pt.x }

pub fn signal_spec_burg_point_y(pt : SignalspecburgPoint) -> Double { pt.y }

pub fn signal_spec_burg_point_z(pt : SignalspecburgPoint) -> Double { pt.z }

pub fn signal_spec_burg_point_label(pt : SignalspecburgPoint) -> Int { pt.label }

pub fn signal_spec_burg_point_dist(a : SignalspecburgPoint, b : SignalspecburgPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn signal_spec_burg_point_add(a : SignalspecburgPoint, b : SignalspecburgPoint) -> SignalspecburgPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn signal_spec_burg_point_sub(a : SignalspecburgPoint, b : SignalspecburgPoint) -> SignalspecburgPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn signal_spec_burg_point_scale(pt : SignalspecburgPoint, s : Double) -> SignalspecburgPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn signal_spec_burg_point_dot(a : SignalspecburgPoint, b : SignalspecburgPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn signal_spec_burg_point_cross(a : SignalspecburgPoint, b : SignalspecburgPoint) -> SignalspecburgPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn signal_spec_burg_point_norm(pt : SignalspecburgPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn signal_spec_burg_point_normalize(pt : SignalspecburgPoint) -> SignalspecburgPoint {
  let n = signal_spec_burg_point_norm(pt)
  if n < 0.0000001 { pt } else { signal_spec_burg_point_scale(pt, 1.0 / n) }
}

pub fn signal_spec_burg_point_negate(pt : SignalspecburgPoint) -> SignalspecburgPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn signal_spec_burg_point_mid(a : SignalspecburgPoint, b : SignalspecburgPoint) -> SignalspecburgPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn signal_spec_burg_point_lerp(a : SignalspecburgPoint, b : SignalspecburgPoint, t : Double) -> SignalspecburgPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn signal_spec_burg_point_to_string(pt : SignalspecburgPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct SignalspecburgSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_spec_burg_make_series(vals : Array[Double], name : String) -> SignalspecburgSeries {
  { vals, name, meta: 0 }
}

pub fn signal_spec_burg_series_len(s : SignalspecburgSeries) -> Int { s.vals.length() }

pub fn signal_spec_burg_series_sum(s : SignalspecburgSeries) -> Double { @_common.sum(s.vals) }

pub fn signal_spec_burg_series_mean(s : SignalspecburgSeries) -> Double { @_common.mean(s.vals) }

pub fn signal_spec_burg_series_min(s : SignalspecburgSeries) -> Double { @_common.min(s.vals) }

pub fn signal_spec_burg_series_max(s : SignalspecburgSeries) -> Double { @_common.max(s.vals) }

pub fn signal_spec_burg_series_range(s : SignalspecburgSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn signal_spec_burg_series_var(s : SignalspecburgSeries) -> Double { @_common.variance(s.vals) }

pub fn signal_spec_burg_series_std(s : SignalspecburgSeries) -> Double { @_common.std(s.vals) }

pub fn signal_spec_burg_series_median(s : SignalspecburgSeries) -> Double { @_common.median(s.vals) }

pub fn signal_spec_burg_series_scale(s : SignalspecburgSeries, f : Double) -> SignalspecburgSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn signal_spec_burg_series_add(a : SignalspecburgSeries, b : SignalspecburgSeries) -> SignalspecburgSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn signal_spec_burg_series_sub(a : SignalspecburgSeries, b : SignalspecburgSeries) -> SignalspecburgSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn signal_spec_burg_series_normalize(s : SignalspecburgSeries) -> SignalspecburgSeries {
  let mn = signal_spec_burg_series_min(s)
  let mx = signal_spec_burg_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn signal_spec_burg_series_cumsum(s : SignalspecburgSeries) -> SignalspecburgSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn signal_spec_burg_series_to_string(s : SignalspecburgSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignalspecburgMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_spec_burg_make_matrix(rows : Int, cols : Int, val : Double) -> SignalspecburgMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn signal_spec_burg_matrix_identity(n : Int) -> SignalspecburgMatrix {
  let m = signal_spec_burg_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn signal_spec_burg_matrix_get(m : SignalspecburgMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn signal_spec_burg_matrix_transpose(m : SignalspecburgMatrix) -> SignalspecburgMatrix {
  let result = signal_spec_burg_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn signal_spec_burg_matrix_add(a : SignalspecburgMatrix, b : SignalspecburgMatrix) -> SignalspecburgMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = signal_spec_burg_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn signal_spec_burg_matrix_scale(m : SignalspecburgMatrix, s : Double) -> SignalspecburgMatrix {
  let result = signal_spec_burg_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn signal_spec_burg_matrix_multiply(a : SignalspecburgMatrix, b : SignalspecburgMatrix) -> SignalspecburgMatrix {
  if a.cols != b.rows { return signal_spec_burg_make_matrix(a.rows, b.cols, 0.0) }
  let result = signal_spec_burg_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn signal_spec_burg_matrix_trace(m : SignalspecburgMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn signal_spec_burg_matrix_det(m : SignalspecburgMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn signal_spec_burg_matrix_norm(m : SignalspecburgMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn signal_spec_burg_matrix_to_string(m : SignalspecburgMatrix) -> String {
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

pub(all) struct SignalspecburgVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_spec_burg_make_vector(comps : Array[Double]) -> SignalspecburgVector {
  { comps, dim: comps.length() }
}

pub fn signal_spec_burg_vector_zero(dim : Int) -> SignalspecburgVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn signal_spec_burg_vector_add(a : SignalspecburgVector, b : SignalspecburgVector) -> SignalspecburgVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn signal_spec_burg_vector_sub(a : SignalspecburgVector, b : SignalspecburgVector) -> SignalspecburgVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn signal_spec_burg_vector_scale(v : SignalspecburgVector, s : Double) -> SignalspecburgVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn signal_spec_burg_vector_dot(a : SignalspecburgVector, b : SignalspecburgVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn signal_spec_burg_vector_norm(v : SignalspecburgVector) -> Double { @_common.sqrt(signal_spec_burg_vector_dot(v, v)) }

pub fn signal_spec_burg_vector_normalize(v : SignalspecburgVector) -> SignalspecburgVector {
  let n = signal_spec_burg_vector_norm(v)
  if n < 0.0000001 { v } else { signal_spec_burg_vector_scale(v, 1.0 / n) }
}

pub fn signal_spec_burg_vector_dist(a : SignalspecburgVector, b : SignalspecburgVector) -> Double {
  signal_spec_burg_vector_norm(signal_spec_burg_vector_sub(a, b))
}

pub fn signal_spec_burg_vector_to_string(v : SignalspecburgVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn signal_spec_burg_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn signal_spec_burg_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn signal_spec_burg_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn signal_spec_burg_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn signal_spec_burg_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn signal_spec_burg_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn signal_spec_burg_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn signal_spec_burg_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn signal_spec_burg_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn signal_spec_burg_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn signal_spec_burg_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn signal_spec_burg_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn signal_spec_burg_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn signal_spec_burg_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn signal_spec_burg_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn signal_spec_burg_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn signal_spec_burg_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn signal_spec_burg_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn signal_spec_burg_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn signal_spec_burg_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn signal_spec_burg_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn signal_spec_burg_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn signal_spec_burg_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn signal_spec_burg_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn signal_spec_burg_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn signal_spec_burg_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn signal_spec_burg_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn signal_spec_burg_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn signal_spec_burg_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SignalspecburgFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_burg_frame_make(size : Int) -> SignalspecburgFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_burg_frame_len(s : SignalspecburgFrame) -> Int { s.size }

pub fn signal_spec_burg_frame_get(s : SignalspecburgFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_burg_frame_set(s : SignalspecburgFrame, i : Int, v : Double) -> SignalspecburgFrame {
  let result = signal_spec_burg_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_burg_frame_sum(s : SignalspecburgFrame) -> Double { @_common.sum(s.data) }

pub fn signal_spec_burg_frame_mean(s : SignalspecburgFrame) -> Double { @_common.mean(s.data) }

pub fn signal_spec_burg_frame_scale(s : SignalspecburgFrame, f : Double) -> SignalspecburgFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_burg_frame_add(a : SignalspecburgFrame, b : SignalspecburgFrame) -> SignalspecburgFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_burg_frame_copy(s : SignalspecburgFrame) -> SignalspecburgFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_burg_frame_fill(s : SignalspecburgFrame, v : Double) -> SignalspecburgFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_burg_frame_min(s : SignalspecburgFrame) -> Double { @_common.min(s.data) }

pub fn signal_spec_burg_frame_max(s : SignalspecburgFrame) -> Double { @_common.max(s.data) }

pub fn signal_spec_burg_frame_to_string(s : SignalspecburgFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecburgTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_burg_table_make(size : Int) -> SignalspecburgTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_burg_table_len(s : SignalspecburgTable) -> Int { s.size }

pub fn signal_spec_burg_table_get(s : SignalspecburgTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_burg_table_set(s : SignalspecburgTable, i : Int, v : Double) -> SignalspecburgTable {
  let result = signal_spec_burg_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_burg_table_sum(s : SignalspecburgTable) -> Double { @_common.sum(s.data) }

pub fn signal_spec_burg_table_mean(s : SignalspecburgTable) -> Double { @_common.mean(s.data) }

pub fn signal_spec_burg_table_scale(s : SignalspecburgTable, f : Double) -> SignalspecburgTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_burg_table_add(a : SignalspecburgTable, b : SignalspecburgTable) -> SignalspecburgTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_burg_table_copy(s : SignalspecburgTable) -> SignalspecburgTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_burg_table_fill(s : SignalspecburgTable, v : Double) -> SignalspecburgTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_burg_table_min(s : SignalspecburgTable) -> Double { @_common.min(s.data) }

pub fn signal_spec_burg_table_max(s : SignalspecburgTable) -> Double { @_common.max(s.data) }

pub fn signal_spec_burg_table_to_string(s : SignalspecburgTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecburgGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_burg_graphn_make(size : Int) -> SignalspecburgGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_burg_graphn_len(s : SignalspecburgGraphN) -> Int { s.size }

pub fn signal_spec_burg_graphn_get(s : SignalspecburgGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_burg_graphn_set(s : SignalspecburgGraphN, i : Int, v : Double) -> SignalspecburgGraphN {
  let result = signal_spec_burg_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_burg_graphn_sum(s : SignalspecburgGraphN) -> Double { @_common.sum(s.data) }

pub fn signal_spec_burg_graphn_mean(s : SignalspecburgGraphN) -> Double { @_common.mean(s.data) }

pub fn signal_spec_burg_graphn_scale(s : SignalspecburgGraphN, f : Double) -> SignalspecburgGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_burg_graphn_add(a : SignalspecburgGraphN, b : SignalspecburgGraphN) -> SignalspecburgGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_burg_graphn_copy(s : SignalspecburgGraphN) -> SignalspecburgGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_burg_graphn_fill(s : SignalspecburgGraphN, v : Double) -> SignalspecburgGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_burg_graphn_min(s : SignalspecburgGraphN) -> Double { @_common.min(s.data) }

pub fn signal_spec_burg_graphn_max(s : SignalspecburgGraphN) -> Double { @_common.max(s.data) }

pub fn signal_spec_burg_graphn_to_string(s : SignalspecburgGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecburgNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_burg_node_make(size : Int) -> SignalspecburgNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_burg_node_len(s : SignalspecburgNode) -> Int { s.size }

pub fn signal_spec_burg_node_get(s : SignalspecburgNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_burg_node_set(s : SignalspecburgNode, i : Int, v : Double) -> SignalspecburgNode {
  let result = signal_spec_burg_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_burg_node_sum(s : SignalspecburgNode) -> Double { @_common.sum(s.data) }

pub fn signal_spec_burg_node_mean(s : SignalspecburgNode) -> Double { @_common.mean(s.data) }

pub fn signal_spec_burg_node_scale(s : SignalspecburgNode, f : Double) -> SignalspecburgNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_burg_node_add(a : SignalspecburgNode, b : SignalspecburgNode) -> SignalspecburgNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_burg_node_copy(s : SignalspecburgNode) -> SignalspecburgNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_burg_node_fill(s : SignalspecburgNode, v : Double) -> SignalspecburgNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_burg_node_min(s : SignalspecburgNode) -> Double { @_common.min(s.data) }

pub fn signal_spec_burg_node_max(s : SignalspecburgNode) -> Double { @_common.max(s.data) }

pub fn signal_spec_burg_node_to_string(s : SignalspecburgNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecburgEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_burg_edge_make(size : Int) -> SignalspecburgEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_burg_edge_len(s : SignalspecburgEdge) -> Int { s.size }

pub fn signal_spec_burg_edge_get(s : SignalspecburgEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_burg_edge_set(s : SignalspecburgEdge, i : Int, v : Double) -> SignalspecburgEdge {
  let result = signal_spec_burg_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_burg_edge_sum(s : SignalspecburgEdge) -> Double { @_common.sum(s.data) }

pub fn signal_spec_burg_edge_mean(s : SignalspecburgEdge) -> Double { @_common.mean(s.data) }

pub fn signal_spec_burg_edge_scale(s : SignalspecburgEdge, f : Double) -> SignalspecburgEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_burg_edge_add(a : SignalspecburgEdge, b : SignalspecburgEdge) -> SignalspecburgEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_burg_edge_copy(s : SignalspecburgEdge) -> SignalspecburgEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_burg_edge_fill(s : SignalspecburgEdge, v : Double) -> SignalspecburgEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_burg_edge_min(s : SignalspecburgEdge) -> Double { @_common.min(s.data) }

pub fn signal_spec_burg_edge_max(s : SignalspecburgEdge) -> Double { @_common.max(s.data) }

pub fn signal_spec_burg_edge_to_string(s : SignalspecburgEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecburgPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_burg_path_make(size : Int) -> SignalspecburgPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_burg_path_len(s : SignalspecburgPath) -> Int { s.size }

pub fn signal_spec_burg_path_get(s : SignalspecburgPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_burg_path_set(s : SignalspecburgPath, i : Int, v : Double) -> SignalspecburgPath {
  let result = signal_spec_burg_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_burg_path_sum(s : SignalspecburgPath) -> Double { @_common.sum(s.data) }

pub fn signal_spec_burg_path_mean(s : SignalspecburgPath) -> Double { @_common.mean(s.data) }

pub fn signal_spec_burg_path_scale(s : SignalspecburgPath, f : Double) -> SignalspecburgPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_burg_path_add(a : SignalspecburgPath, b : SignalspecburgPath) -> SignalspecburgPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_burg_path_copy(s : SignalspecburgPath) -> SignalspecburgPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_burg_path_fill(s : SignalspecburgPath, v : Double) -> SignalspecburgPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_burg_path_min(s : SignalspecburgPath) -> Double { @_common.min(s.data) }

pub fn signal_spec_burg_path_max(s : SignalspecburgPath) -> Double { @_common.max(s.data) }

pub fn signal_spec_burg_path_to_string(s : SignalspecburgPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecburgCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_burg_cluster_make(size : Int) -> SignalspecburgCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_burg_cluster_len(s : SignalspecburgCluster) -> Int { s.size }

pub fn signal_spec_burg_cluster_get(s : SignalspecburgCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_burg_cluster_set(s : SignalspecburgCluster, i : Int, v : Double) -> SignalspecburgCluster {
  let result = signal_spec_burg_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_burg_cluster_sum(s : SignalspecburgCluster) -> Double { @_common.sum(s.data) }

pub fn signal_spec_burg_cluster_mean(s : SignalspecburgCluster) -> Double { @_common.mean(s.data) }

pub fn signal_spec_burg_cluster_scale(s : SignalspecburgCluster, f : Double) -> SignalspecburgCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_burg_cluster_add(a : SignalspecburgCluster, b : SignalspecburgCluster) -> SignalspecburgCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_burg_cluster_copy(s : SignalspecburgCluster) -> SignalspecburgCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_burg_cluster_fill(s : SignalspecburgCluster, v : Double) -> SignalspecburgCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_burg_cluster_min(s : SignalspecburgCluster) -> Double { @_common.min(s.data) }

pub fn signal_spec_burg_cluster_max(s : SignalspecburgCluster) -> Double { @_common.max(s.data) }

pub fn signal_spec_burg_cluster_to_string(s : SignalspecburgCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecburgModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_burg_model_make(size : Int) -> SignalspecburgModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_burg_model_len(s : SignalspecburgModel) -> Int { s.size }

pub fn signal_spec_burg_model_get(s : SignalspecburgModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_burg_model_set(s : SignalspecburgModel, i : Int, v : Double) -> SignalspecburgModel {
  let result = signal_spec_burg_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_burg_model_sum(s : SignalspecburgModel) -> Double { @_common.sum(s.data) }

pub fn signal_spec_burg_model_mean(s : SignalspecburgModel) -> Double { @_common.mean(s.data) }

pub fn signal_spec_burg_model_scale(s : SignalspecburgModel, f : Double) -> SignalspecburgModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_burg_model_add(a : SignalspecburgModel, b : SignalspecburgModel) -> SignalspecburgModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_burg_model_copy(s : SignalspecburgModel) -> SignalspecburgModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_burg_model_fill(s : SignalspecburgModel, v : Double) -> SignalspecburgModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_burg_model_min(s : SignalspecburgModel) -> Double { @_common.min(s.data) }

pub fn signal_spec_burg_model_max(s : SignalspecburgModel) -> Double { @_common.max(s.data) }

pub fn signal_spec_burg_model_to_string(s : SignalspecburgModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecburgLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_burg_layer_make(size : Int) -> SignalspecburgLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_burg_layer_len(s : SignalspecburgLayer) -> Int { s.size }

pub fn signal_spec_burg_layer_get(s : SignalspecburgLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_burg_layer_set(s : SignalspecburgLayer, i : Int, v : Double) -> SignalspecburgLayer {
  let result = signal_spec_burg_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_burg_layer_sum(s : SignalspecburgLayer) -> Double { @_common.sum(s.data) }

pub fn signal_spec_burg_layer_mean(s : SignalspecburgLayer) -> Double { @_common.mean(s.data) }

pub fn signal_spec_burg_layer_scale(s : SignalspecburgLayer, f : Double) -> SignalspecburgLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_burg_layer_add(a : SignalspecburgLayer, b : SignalspecburgLayer) -> SignalspecburgLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_burg_layer_copy(s : SignalspecburgLayer) -> SignalspecburgLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_burg_layer_fill(s : SignalspecburgLayer, v : Double) -> SignalspecburgLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_burg_layer_min(s : SignalspecburgLayer) -> Double { @_common.min(s.data) }

pub fn signal_spec_burg_layer_max(s : SignalspecburgLayer) -> Double { @_common.max(s.data) }

pub fn signal_spec_burg_layer_to_string(s : SignalspecburgLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecburgBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_burg_buffer_make(size : Int) -> SignalspecburgBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_burg_buffer_len(s : SignalspecburgBuffer) -> Int { s.size }

pub fn signal_spec_burg_buffer_get(s : SignalspecburgBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_burg_buffer_set(s : SignalspecburgBuffer, i : Int, v : Double) -> SignalspecburgBuffer {
  let result = signal_spec_burg_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_burg_buffer_sum(s : SignalspecburgBuffer) -> Double { @_common.sum(s.data) }

pub fn signal_spec_burg_buffer_mean(s : SignalspecburgBuffer) -> Double { @_common.mean(s.data) }

pub fn signal_spec_burg_buffer_scale(s : SignalspecburgBuffer, f : Double) -> SignalspecburgBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_burg_buffer_add(a : SignalspecburgBuffer, b : SignalspecburgBuffer) -> SignalspecburgBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_burg_buffer_copy(s : SignalspecburgBuffer) -> SignalspecburgBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_burg_buffer_fill(s : SignalspecburgBuffer, v : Double) -> SignalspecburgBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_burg_buffer_min(s : SignalspecburgBuffer) -> Double { @_common.min(s.data) }

pub fn signal_spec_burg_buffer_max(s : SignalspecburgBuffer) -> Double { @_common.max(s.data) }

pub fn signal_spec_burg_buffer_to_string(s : SignalspecburgBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecburgCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_burg_cursor_make(size : Int) -> SignalspecburgCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_burg_cursor_len(s : SignalspecburgCursor) -> Int { s.size }

pub fn signal_spec_burg_cursor_get(s : SignalspecburgCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_burg_cursor_set(s : SignalspecburgCursor, i : Int, v : Double) -> SignalspecburgCursor {
  let result = signal_spec_burg_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_burg_cursor_sum(s : SignalspecburgCursor) -> Double { @_common.sum(s.data) }

pub fn signal_spec_burg_cursor_mean(s : SignalspecburgCursor) -> Double { @_common.mean(s.data) }

pub fn signal_spec_burg_cursor_scale(s : SignalspecburgCursor, f : Double) -> SignalspecburgCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_burg_cursor_add(a : SignalspecburgCursor, b : SignalspecburgCursor) -> SignalspecburgCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_burg_cursor_copy(s : SignalspecburgCursor) -> SignalspecburgCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_burg_cursor_fill(s : SignalspecburgCursor, v : Double) -> SignalspecburgCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_burg_cursor_min(s : SignalspecburgCursor) -> Double { @_common.min(s.data) }

pub fn signal_spec_burg_cursor_max(s : SignalspecburgCursor) -> Double { @_common.max(s.data) }

pub fn signal_spec_burg_cursor_to_string(s : SignalspecburgCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecburgView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_burg_view_make(size : Int) -> SignalspecburgView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_burg_view_len(s : SignalspecburgView) -> Int { s.size }

pub fn signal_spec_burg_view_get(s : SignalspecburgView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_burg_view_set(s : SignalspecburgView, i : Int, v : Double) -> SignalspecburgView {
  let result = signal_spec_burg_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_burg_view_sum(s : SignalspecburgView) -> Double { @_common.sum(s.data) }

pub fn signal_spec_burg_view_mean(s : SignalspecburgView) -> Double { @_common.mean(s.data) }

pub fn signal_spec_burg_view_scale(s : SignalspecburgView, f : Double) -> SignalspecburgView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_burg_view_add(a : SignalspecburgView, b : SignalspecburgView) -> SignalspecburgView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_burg_view_copy(s : SignalspecburgView) -> SignalspecburgView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_burg_view_fill(s : SignalspecburgView, v : Double) -> SignalspecburgView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_burg_view_min(s : SignalspecburgView) -> Double { @_common.min(s.data) }

pub fn signal_spec_burg_view_max(s : SignalspecburgView) -> Double { @_common.max(s.data) }

pub fn signal_spec_burg_view_to_string(s : SignalspecburgView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecburgRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_burg_range_make(size : Int) -> SignalspecburgRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_burg_range_len(s : SignalspecburgRange) -> Int { s.size }

pub fn signal_spec_burg_range_get(s : SignalspecburgRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_burg_range_set(s : SignalspecburgRange, i : Int, v : Double) -> SignalspecburgRange {
  let result = signal_spec_burg_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_burg_range_sum(s : SignalspecburgRange) -> Double { @_common.sum(s.data) }

pub fn signal_spec_burg_range_mean(s : SignalspecburgRange) -> Double { @_common.mean(s.data) }

pub fn signal_spec_burg_range_scale(s : SignalspecburgRange, f : Double) -> SignalspecburgRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_burg_range_add(a : SignalspecburgRange, b : SignalspecburgRange) -> SignalspecburgRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_burg_range_copy(s : SignalspecburgRange) -> SignalspecburgRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_burg_range_fill(s : SignalspecburgRange, v : Double) -> SignalspecburgRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_burg_range_min(s : SignalspecburgRange) -> Double { @_common.min(s.data) }

pub fn signal_spec_burg_range_max(s : SignalspecburgRange) -> Double { @_common.max(s.data) }

pub fn signal_spec_burg_range_to_string(s : SignalspecburgRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecburgSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_burg_slice_make(size : Int) -> SignalspecburgSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_burg_slice_len(s : SignalspecburgSlice) -> Int { s.size }

pub fn signal_spec_burg_slice_get(s : SignalspecburgSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_burg_slice_set(s : SignalspecburgSlice, i : Int, v : Double) -> SignalspecburgSlice {
  let result = signal_spec_burg_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_burg_slice_sum(s : SignalspecburgSlice) -> Double { @_common.sum(s.data) }

pub fn signal_spec_burg_slice_mean(s : SignalspecburgSlice) -> Double { @_common.mean(s.data) }

pub fn signal_spec_burg_slice_scale(s : SignalspecburgSlice, f : Double) -> SignalspecburgSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_burg_slice_add(a : SignalspecburgSlice, b : SignalspecburgSlice) -> SignalspecburgSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_burg_slice_copy(s : SignalspecburgSlice) -> SignalspecburgSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_burg_slice_fill(s : SignalspecburgSlice, v : Double) -> SignalspecburgSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_burg_slice_min(s : SignalspecburgSlice) -> Double { @_common.min(s.data) }

pub fn signal_spec_burg_slice_max(s : SignalspecburgSlice) -> Double { @_common.max(s.data) }

pub fn signal_spec_burg_slice_to_string(s : SignalspecburgSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


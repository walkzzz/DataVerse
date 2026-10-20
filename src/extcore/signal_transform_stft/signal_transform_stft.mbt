///===
/// extcore/signal_transform_stft

pub(all) struct SignaltransformstftPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_transform_stft_make_point(x : Double, y : Double) -> SignaltransformstftPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_transform_stft_make_point3(x : Double, y : Double, z : Double) -> SignaltransformstftPoint {
  { x, y, z, label: 0 }
}

pub fn signal_transform_stft_point_x(pt : SignaltransformstftPoint) -> Double { pt.x }

pub fn signal_transform_stft_point_y(pt : SignaltransformstftPoint) -> Double { pt.y }

pub fn signal_transform_stft_point_z(pt : SignaltransformstftPoint) -> Double { pt.z }

pub fn signal_transform_stft_point_label(pt : SignaltransformstftPoint) -> Int { pt.label }

pub fn signal_transform_stft_point_dist(a : SignaltransformstftPoint, b : SignaltransformstftPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn signal_transform_stft_point_add(a : SignaltransformstftPoint, b : SignaltransformstftPoint) -> SignaltransformstftPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn signal_transform_stft_point_sub(a : SignaltransformstftPoint, b : SignaltransformstftPoint) -> SignaltransformstftPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn signal_transform_stft_point_scale(pt : SignaltransformstftPoint, s : Double) -> SignaltransformstftPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn signal_transform_stft_point_dot(a : SignaltransformstftPoint, b : SignaltransformstftPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn signal_transform_stft_point_cross(a : SignaltransformstftPoint, b : SignaltransformstftPoint) -> SignaltransformstftPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn signal_transform_stft_point_norm(pt : SignaltransformstftPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn signal_transform_stft_point_normalize(pt : SignaltransformstftPoint) -> SignaltransformstftPoint {
  let n = signal_transform_stft_point_norm(pt)
  if n < 0.0000001 { pt } else { signal_transform_stft_point_scale(pt, 1.0 / n) }
}

pub fn signal_transform_stft_point_negate(pt : SignaltransformstftPoint) -> SignaltransformstftPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn signal_transform_stft_point_mid(a : SignaltransformstftPoint, b : SignaltransformstftPoint) -> SignaltransformstftPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn signal_transform_stft_point_lerp(a : SignaltransformstftPoint, b : SignaltransformstftPoint, t : Double) -> SignaltransformstftPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn signal_transform_stft_point_to_string(pt : SignaltransformstftPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct SignaltransformstftSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_transform_stft_make_series(vals : Array[Double], name : String) -> SignaltransformstftSeries {
  { vals, name, meta: 0 }
}

pub fn signal_transform_stft_series_len(s : SignaltransformstftSeries) -> Int { s.vals.length() }

pub fn signal_transform_stft_series_sum(s : SignaltransformstftSeries) -> Double { @_common.sum(s.vals) }

pub fn signal_transform_stft_series_mean(s : SignaltransformstftSeries) -> Double { @_common.mean(s.vals) }

pub fn signal_transform_stft_series_min(s : SignaltransformstftSeries) -> Double { @_common.min(s.vals) }

pub fn signal_transform_stft_series_max(s : SignaltransformstftSeries) -> Double { @_common.max(s.vals) }

pub fn signal_transform_stft_series_range(s : SignaltransformstftSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn signal_transform_stft_series_var(s : SignaltransformstftSeries) -> Double { @_common.variance(s.vals) }

pub fn signal_transform_stft_series_std(s : SignaltransformstftSeries) -> Double { @_common.std(s.vals) }

pub fn signal_transform_stft_series_median(s : SignaltransformstftSeries) -> Double { @_common.median(s.vals) }

pub fn signal_transform_stft_series_scale(s : SignaltransformstftSeries, f : Double) -> SignaltransformstftSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn signal_transform_stft_series_add(a : SignaltransformstftSeries, b : SignaltransformstftSeries) -> SignaltransformstftSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn signal_transform_stft_series_sub(a : SignaltransformstftSeries, b : SignaltransformstftSeries) -> SignaltransformstftSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn signal_transform_stft_series_normalize(s : SignaltransformstftSeries) -> SignaltransformstftSeries {
  let mn = signal_transform_stft_series_min(s)
  let mx = signal_transform_stft_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn signal_transform_stft_series_cumsum(s : SignaltransformstftSeries) -> SignaltransformstftSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn signal_transform_stft_series_to_string(s : SignaltransformstftSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignaltransformstftMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_transform_stft_make_matrix(rows : Int, cols : Int, val : Double) -> SignaltransformstftMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn signal_transform_stft_matrix_identity(n : Int) -> SignaltransformstftMatrix {
  let m = signal_transform_stft_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn signal_transform_stft_matrix_get(m : SignaltransformstftMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn signal_transform_stft_matrix_transpose(m : SignaltransformstftMatrix) -> SignaltransformstftMatrix {
  let result = signal_transform_stft_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn signal_transform_stft_matrix_add(a : SignaltransformstftMatrix, b : SignaltransformstftMatrix) -> SignaltransformstftMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = signal_transform_stft_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn signal_transform_stft_matrix_scale(m : SignaltransformstftMatrix, s : Double) -> SignaltransformstftMatrix {
  let result = signal_transform_stft_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn signal_transform_stft_matrix_multiply(a : SignaltransformstftMatrix, b : SignaltransformstftMatrix) -> SignaltransformstftMatrix {
  if a.cols != b.rows { return signal_transform_stft_make_matrix(a.rows, b.cols, 0.0) }
  let result = signal_transform_stft_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn signal_transform_stft_matrix_trace(m : SignaltransformstftMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn signal_transform_stft_matrix_det(m : SignaltransformstftMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn signal_transform_stft_matrix_norm(m : SignaltransformstftMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn signal_transform_stft_matrix_to_string(m : SignaltransformstftMatrix) -> String {
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

pub(all) struct SignaltransformstftVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_transform_stft_make_vector(comps : Array[Double]) -> SignaltransformstftVector {
  { comps, dim: comps.length() }
}

pub fn signal_transform_stft_vector_zero(dim : Int) -> SignaltransformstftVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn signal_transform_stft_vector_add(a : SignaltransformstftVector, b : SignaltransformstftVector) -> SignaltransformstftVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn signal_transform_stft_vector_sub(a : SignaltransformstftVector, b : SignaltransformstftVector) -> SignaltransformstftVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn signal_transform_stft_vector_scale(v : SignaltransformstftVector, s : Double) -> SignaltransformstftVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn signal_transform_stft_vector_dot(a : SignaltransformstftVector, b : SignaltransformstftVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn signal_transform_stft_vector_norm(v : SignaltransformstftVector) -> Double { @_common.sqrt(signal_transform_stft_vector_dot(v, v)) }

pub fn signal_transform_stft_vector_normalize(v : SignaltransformstftVector) -> SignaltransformstftVector {
  let n = signal_transform_stft_vector_norm(v)
  if n < 0.0000001 { v } else { signal_transform_stft_vector_scale(v, 1.0 / n) }
}

pub fn signal_transform_stft_vector_dist(a : SignaltransformstftVector, b : SignaltransformstftVector) -> Double {
  signal_transform_stft_vector_norm(signal_transform_stft_vector_sub(a, b))
}

pub fn signal_transform_stft_vector_to_string(v : SignaltransformstftVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn signal_transform_stft_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn signal_transform_stft_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn signal_transform_stft_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn signal_transform_stft_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn signal_transform_stft_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn signal_transform_stft_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn signal_transform_stft_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn signal_transform_stft_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn signal_transform_stft_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn signal_transform_stft_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn signal_transform_stft_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn signal_transform_stft_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn signal_transform_stft_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn signal_transform_stft_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn signal_transform_stft_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn signal_transform_stft_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn signal_transform_stft_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn signal_transform_stft_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn signal_transform_stft_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn signal_transform_stft_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn signal_transform_stft_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn signal_transform_stft_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn signal_transform_stft_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn signal_transform_stft_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn signal_transform_stft_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn signal_transform_stft_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn signal_transform_stft_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn signal_transform_stft_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn signal_transform_stft_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SignaltransformstftFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_stft_frame_make(size : Int) -> SignaltransformstftFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_stft_frame_len(s : SignaltransformstftFrame) -> Int { s.size }

pub fn signal_transform_stft_frame_get(s : SignaltransformstftFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_stft_frame_set(s : SignaltransformstftFrame, i : Int, v : Double) -> SignaltransformstftFrame {
  let result = signal_transform_stft_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_stft_frame_sum(s : SignaltransformstftFrame) -> Double { @_common.sum(s.data) }

pub fn signal_transform_stft_frame_mean(s : SignaltransformstftFrame) -> Double { @_common.mean(s.data) }

pub fn signal_transform_stft_frame_scale(s : SignaltransformstftFrame, f : Double) -> SignaltransformstftFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_stft_frame_add(a : SignaltransformstftFrame, b : SignaltransformstftFrame) -> SignaltransformstftFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_stft_frame_copy(s : SignaltransformstftFrame) -> SignaltransformstftFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_stft_frame_fill(s : SignaltransformstftFrame, v : Double) -> SignaltransformstftFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_stft_frame_min(s : SignaltransformstftFrame) -> Double { @_common.min(s.data) }

pub fn signal_transform_stft_frame_max(s : SignaltransformstftFrame) -> Double { @_common.max(s.data) }

pub fn signal_transform_stft_frame_to_string(s : SignaltransformstftFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformstftTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_stft_table_make(size : Int) -> SignaltransformstftTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_stft_table_len(s : SignaltransformstftTable) -> Int { s.size }

pub fn signal_transform_stft_table_get(s : SignaltransformstftTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_stft_table_set(s : SignaltransformstftTable, i : Int, v : Double) -> SignaltransformstftTable {
  let result = signal_transform_stft_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_stft_table_sum(s : SignaltransformstftTable) -> Double { @_common.sum(s.data) }

pub fn signal_transform_stft_table_mean(s : SignaltransformstftTable) -> Double { @_common.mean(s.data) }

pub fn signal_transform_stft_table_scale(s : SignaltransformstftTable, f : Double) -> SignaltransformstftTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_stft_table_add(a : SignaltransformstftTable, b : SignaltransformstftTable) -> SignaltransformstftTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_stft_table_copy(s : SignaltransformstftTable) -> SignaltransformstftTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_stft_table_fill(s : SignaltransformstftTable, v : Double) -> SignaltransformstftTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_stft_table_min(s : SignaltransformstftTable) -> Double { @_common.min(s.data) }

pub fn signal_transform_stft_table_max(s : SignaltransformstftTable) -> Double { @_common.max(s.data) }

pub fn signal_transform_stft_table_to_string(s : SignaltransformstftTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformstftGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_stft_graphn_make(size : Int) -> SignaltransformstftGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_stft_graphn_len(s : SignaltransformstftGraphN) -> Int { s.size }

pub fn signal_transform_stft_graphn_get(s : SignaltransformstftGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_stft_graphn_set(s : SignaltransformstftGraphN, i : Int, v : Double) -> SignaltransformstftGraphN {
  let result = signal_transform_stft_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_stft_graphn_sum(s : SignaltransformstftGraphN) -> Double { @_common.sum(s.data) }

pub fn signal_transform_stft_graphn_mean(s : SignaltransformstftGraphN) -> Double { @_common.mean(s.data) }

pub fn signal_transform_stft_graphn_scale(s : SignaltransformstftGraphN, f : Double) -> SignaltransformstftGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_stft_graphn_add(a : SignaltransformstftGraphN, b : SignaltransformstftGraphN) -> SignaltransformstftGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_stft_graphn_copy(s : SignaltransformstftGraphN) -> SignaltransformstftGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_stft_graphn_fill(s : SignaltransformstftGraphN, v : Double) -> SignaltransformstftGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_stft_graphn_min(s : SignaltransformstftGraphN) -> Double { @_common.min(s.data) }

pub fn signal_transform_stft_graphn_max(s : SignaltransformstftGraphN) -> Double { @_common.max(s.data) }

pub fn signal_transform_stft_graphn_to_string(s : SignaltransformstftGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformstftNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_stft_node_make(size : Int) -> SignaltransformstftNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_stft_node_len(s : SignaltransformstftNode) -> Int { s.size }

pub fn signal_transform_stft_node_get(s : SignaltransformstftNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_stft_node_set(s : SignaltransformstftNode, i : Int, v : Double) -> SignaltransformstftNode {
  let result = signal_transform_stft_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_stft_node_sum(s : SignaltransformstftNode) -> Double { @_common.sum(s.data) }

pub fn signal_transform_stft_node_mean(s : SignaltransformstftNode) -> Double { @_common.mean(s.data) }

pub fn signal_transform_stft_node_scale(s : SignaltransformstftNode, f : Double) -> SignaltransformstftNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_stft_node_add(a : SignaltransformstftNode, b : SignaltransformstftNode) -> SignaltransformstftNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_stft_node_copy(s : SignaltransformstftNode) -> SignaltransformstftNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_stft_node_fill(s : SignaltransformstftNode, v : Double) -> SignaltransformstftNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_stft_node_min(s : SignaltransformstftNode) -> Double { @_common.min(s.data) }

pub fn signal_transform_stft_node_max(s : SignaltransformstftNode) -> Double { @_common.max(s.data) }

pub fn signal_transform_stft_node_to_string(s : SignaltransformstftNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformstftEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_stft_edge_make(size : Int) -> SignaltransformstftEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_stft_edge_len(s : SignaltransformstftEdge) -> Int { s.size }

pub fn signal_transform_stft_edge_get(s : SignaltransformstftEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_stft_edge_set(s : SignaltransformstftEdge, i : Int, v : Double) -> SignaltransformstftEdge {
  let result = signal_transform_stft_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_stft_edge_sum(s : SignaltransformstftEdge) -> Double { @_common.sum(s.data) }

pub fn signal_transform_stft_edge_mean(s : SignaltransformstftEdge) -> Double { @_common.mean(s.data) }

pub fn signal_transform_stft_edge_scale(s : SignaltransformstftEdge, f : Double) -> SignaltransformstftEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_stft_edge_add(a : SignaltransformstftEdge, b : SignaltransformstftEdge) -> SignaltransformstftEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_stft_edge_copy(s : SignaltransformstftEdge) -> SignaltransformstftEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_stft_edge_fill(s : SignaltransformstftEdge, v : Double) -> SignaltransformstftEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_stft_edge_min(s : SignaltransformstftEdge) -> Double { @_common.min(s.data) }

pub fn signal_transform_stft_edge_max(s : SignaltransformstftEdge) -> Double { @_common.max(s.data) }

pub fn signal_transform_stft_edge_to_string(s : SignaltransformstftEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformstftPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_stft_path_make(size : Int) -> SignaltransformstftPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_stft_path_len(s : SignaltransformstftPath) -> Int { s.size }

pub fn signal_transform_stft_path_get(s : SignaltransformstftPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_stft_path_set(s : SignaltransformstftPath, i : Int, v : Double) -> SignaltransformstftPath {
  let result = signal_transform_stft_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_stft_path_sum(s : SignaltransformstftPath) -> Double { @_common.sum(s.data) }

pub fn signal_transform_stft_path_mean(s : SignaltransformstftPath) -> Double { @_common.mean(s.data) }

pub fn signal_transform_stft_path_scale(s : SignaltransformstftPath, f : Double) -> SignaltransformstftPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_stft_path_add(a : SignaltransformstftPath, b : SignaltransformstftPath) -> SignaltransformstftPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_stft_path_copy(s : SignaltransformstftPath) -> SignaltransformstftPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_stft_path_fill(s : SignaltransformstftPath, v : Double) -> SignaltransformstftPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_stft_path_min(s : SignaltransformstftPath) -> Double { @_common.min(s.data) }

pub fn signal_transform_stft_path_max(s : SignaltransformstftPath) -> Double { @_common.max(s.data) }

pub fn signal_transform_stft_path_to_string(s : SignaltransformstftPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformstftCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_stft_cluster_make(size : Int) -> SignaltransformstftCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_stft_cluster_len(s : SignaltransformstftCluster) -> Int { s.size }

pub fn signal_transform_stft_cluster_get(s : SignaltransformstftCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_stft_cluster_set(s : SignaltransformstftCluster, i : Int, v : Double) -> SignaltransformstftCluster {
  let result = signal_transform_stft_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_stft_cluster_sum(s : SignaltransformstftCluster) -> Double { @_common.sum(s.data) }

pub fn signal_transform_stft_cluster_mean(s : SignaltransformstftCluster) -> Double { @_common.mean(s.data) }

pub fn signal_transform_stft_cluster_scale(s : SignaltransformstftCluster, f : Double) -> SignaltransformstftCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_stft_cluster_add(a : SignaltransformstftCluster, b : SignaltransformstftCluster) -> SignaltransformstftCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_stft_cluster_copy(s : SignaltransformstftCluster) -> SignaltransformstftCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_stft_cluster_fill(s : SignaltransformstftCluster, v : Double) -> SignaltransformstftCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_stft_cluster_min(s : SignaltransformstftCluster) -> Double { @_common.min(s.data) }

pub fn signal_transform_stft_cluster_max(s : SignaltransformstftCluster) -> Double { @_common.max(s.data) }

pub fn signal_transform_stft_cluster_to_string(s : SignaltransformstftCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformstftModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_stft_model_make(size : Int) -> SignaltransformstftModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_stft_model_len(s : SignaltransformstftModel) -> Int { s.size }

pub fn signal_transform_stft_model_get(s : SignaltransformstftModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_stft_model_set(s : SignaltransformstftModel, i : Int, v : Double) -> SignaltransformstftModel {
  let result = signal_transform_stft_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_stft_model_sum(s : SignaltransformstftModel) -> Double { @_common.sum(s.data) }

pub fn signal_transform_stft_model_mean(s : SignaltransformstftModel) -> Double { @_common.mean(s.data) }

pub fn signal_transform_stft_model_scale(s : SignaltransformstftModel, f : Double) -> SignaltransformstftModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_stft_model_add(a : SignaltransformstftModel, b : SignaltransformstftModel) -> SignaltransformstftModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_stft_model_copy(s : SignaltransformstftModel) -> SignaltransformstftModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_stft_model_fill(s : SignaltransformstftModel, v : Double) -> SignaltransformstftModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_stft_model_min(s : SignaltransformstftModel) -> Double { @_common.min(s.data) }

pub fn signal_transform_stft_model_max(s : SignaltransformstftModel) -> Double { @_common.max(s.data) }

pub fn signal_transform_stft_model_to_string(s : SignaltransformstftModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformstftLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_stft_layer_make(size : Int) -> SignaltransformstftLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_stft_layer_len(s : SignaltransformstftLayer) -> Int { s.size }

pub fn signal_transform_stft_layer_get(s : SignaltransformstftLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_stft_layer_set(s : SignaltransformstftLayer, i : Int, v : Double) -> SignaltransformstftLayer {
  let result = signal_transform_stft_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_stft_layer_sum(s : SignaltransformstftLayer) -> Double { @_common.sum(s.data) }

pub fn signal_transform_stft_layer_mean(s : SignaltransformstftLayer) -> Double { @_common.mean(s.data) }

pub fn signal_transform_stft_layer_scale(s : SignaltransformstftLayer, f : Double) -> SignaltransformstftLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_stft_layer_add(a : SignaltransformstftLayer, b : SignaltransformstftLayer) -> SignaltransformstftLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_stft_layer_copy(s : SignaltransformstftLayer) -> SignaltransformstftLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_stft_layer_fill(s : SignaltransformstftLayer, v : Double) -> SignaltransformstftLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_stft_layer_min(s : SignaltransformstftLayer) -> Double { @_common.min(s.data) }

pub fn signal_transform_stft_layer_max(s : SignaltransformstftLayer) -> Double { @_common.max(s.data) }

pub fn signal_transform_stft_layer_to_string(s : SignaltransformstftLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformstftBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_stft_buffer_make(size : Int) -> SignaltransformstftBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_stft_buffer_len(s : SignaltransformstftBuffer) -> Int { s.size }

pub fn signal_transform_stft_buffer_get(s : SignaltransformstftBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_stft_buffer_set(s : SignaltransformstftBuffer, i : Int, v : Double) -> SignaltransformstftBuffer {
  let result = signal_transform_stft_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_stft_buffer_sum(s : SignaltransformstftBuffer) -> Double { @_common.sum(s.data) }

pub fn signal_transform_stft_buffer_mean(s : SignaltransformstftBuffer) -> Double { @_common.mean(s.data) }

pub fn signal_transform_stft_buffer_scale(s : SignaltransformstftBuffer, f : Double) -> SignaltransformstftBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_stft_buffer_add(a : SignaltransformstftBuffer, b : SignaltransformstftBuffer) -> SignaltransformstftBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_stft_buffer_copy(s : SignaltransformstftBuffer) -> SignaltransformstftBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_stft_buffer_fill(s : SignaltransformstftBuffer, v : Double) -> SignaltransformstftBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_stft_buffer_min(s : SignaltransformstftBuffer) -> Double { @_common.min(s.data) }

pub fn signal_transform_stft_buffer_max(s : SignaltransformstftBuffer) -> Double { @_common.max(s.data) }

pub fn signal_transform_stft_buffer_to_string(s : SignaltransformstftBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformstftCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_stft_cursor_make(size : Int) -> SignaltransformstftCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_stft_cursor_len(s : SignaltransformstftCursor) -> Int { s.size }

pub fn signal_transform_stft_cursor_get(s : SignaltransformstftCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_stft_cursor_set(s : SignaltransformstftCursor, i : Int, v : Double) -> SignaltransformstftCursor {
  let result = signal_transform_stft_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_stft_cursor_sum(s : SignaltransformstftCursor) -> Double { @_common.sum(s.data) }

pub fn signal_transform_stft_cursor_mean(s : SignaltransformstftCursor) -> Double { @_common.mean(s.data) }

pub fn signal_transform_stft_cursor_scale(s : SignaltransformstftCursor, f : Double) -> SignaltransformstftCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_stft_cursor_add(a : SignaltransformstftCursor, b : SignaltransformstftCursor) -> SignaltransformstftCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_stft_cursor_copy(s : SignaltransformstftCursor) -> SignaltransformstftCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_stft_cursor_fill(s : SignaltransformstftCursor, v : Double) -> SignaltransformstftCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_stft_cursor_min(s : SignaltransformstftCursor) -> Double { @_common.min(s.data) }

pub fn signal_transform_stft_cursor_max(s : SignaltransformstftCursor) -> Double { @_common.max(s.data) }

pub fn signal_transform_stft_cursor_to_string(s : SignaltransformstftCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformstftView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_stft_view_make(size : Int) -> SignaltransformstftView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_stft_view_len(s : SignaltransformstftView) -> Int { s.size }

pub fn signal_transform_stft_view_get(s : SignaltransformstftView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_stft_view_set(s : SignaltransformstftView, i : Int, v : Double) -> SignaltransformstftView {
  let result = signal_transform_stft_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_stft_view_sum(s : SignaltransformstftView) -> Double { @_common.sum(s.data) }

pub fn signal_transform_stft_view_mean(s : SignaltransformstftView) -> Double { @_common.mean(s.data) }

pub fn signal_transform_stft_view_scale(s : SignaltransformstftView, f : Double) -> SignaltransformstftView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_stft_view_add(a : SignaltransformstftView, b : SignaltransformstftView) -> SignaltransformstftView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_stft_view_copy(s : SignaltransformstftView) -> SignaltransformstftView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_stft_view_fill(s : SignaltransformstftView, v : Double) -> SignaltransformstftView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_stft_view_min(s : SignaltransformstftView) -> Double { @_common.min(s.data) }

pub fn signal_transform_stft_view_max(s : SignaltransformstftView) -> Double { @_common.max(s.data) }

pub fn signal_transform_stft_view_to_string(s : SignaltransformstftView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformstftRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_stft_range_make(size : Int) -> SignaltransformstftRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_stft_range_len(s : SignaltransformstftRange) -> Int { s.size }

pub fn signal_transform_stft_range_get(s : SignaltransformstftRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_stft_range_set(s : SignaltransformstftRange, i : Int, v : Double) -> SignaltransformstftRange {
  let result = signal_transform_stft_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_stft_range_sum(s : SignaltransformstftRange) -> Double { @_common.sum(s.data) }

pub fn signal_transform_stft_range_mean(s : SignaltransformstftRange) -> Double { @_common.mean(s.data) }

pub fn signal_transform_stft_range_scale(s : SignaltransformstftRange, f : Double) -> SignaltransformstftRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_stft_range_add(a : SignaltransformstftRange, b : SignaltransformstftRange) -> SignaltransformstftRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_stft_range_copy(s : SignaltransformstftRange) -> SignaltransformstftRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_stft_range_fill(s : SignaltransformstftRange, v : Double) -> SignaltransformstftRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_stft_range_min(s : SignaltransformstftRange) -> Double { @_common.min(s.data) }

pub fn signal_transform_stft_range_max(s : SignaltransformstftRange) -> Double { @_common.max(s.data) }

pub fn signal_transform_stft_range_to_string(s : SignaltransformstftRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformstftSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_stft_slice_make(size : Int) -> SignaltransformstftSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_stft_slice_len(s : SignaltransformstftSlice) -> Int { s.size }

pub fn signal_transform_stft_slice_get(s : SignaltransformstftSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_stft_slice_set(s : SignaltransformstftSlice, i : Int, v : Double) -> SignaltransformstftSlice {
  let result = signal_transform_stft_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_stft_slice_sum(s : SignaltransformstftSlice) -> Double { @_common.sum(s.data) }

pub fn signal_transform_stft_slice_mean(s : SignaltransformstftSlice) -> Double { @_common.mean(s.data) }

pub fn signal_transform_stft_slice_scale(s : SignaltransformstftSlice, f : Double) -> SignaltransformstftSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_stft_slice_add(a : SignaltransformstftSlice, b : SignaltransformstftSlice) -> SignaltransformstftSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_stft_slice_copy(s : SignaltransformstftSlice) -> SignaltransformstftSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_stft_slice_fill(s : SignaltransformstftSlice, v : Double) -> SignaltransformstftSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_stft_slice_min(s : SignaltransformstftSlice) -> Double { @_common.min(s.data) }

pub fn signal_transform_stft_slice_max(s : SignaltransformstftSlice) -> Double { @_common.max(s.data) }

pub fn signal_transform_stft_slice_to_string(s : SignaltransformstftSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


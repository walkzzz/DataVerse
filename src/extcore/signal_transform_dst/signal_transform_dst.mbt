///===
/// extcore/signal_transform_dst

pub(all) struct SignaltransformdstPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_transform_dst_make_point(x : Double, y : Double) -> SignaltransformdstPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_transform_dst_make_point3(x : Double, y : Double, z : Double) -> SignaltransformdstPoint {
  { x, y, z, label: 0 }
}

pub fn signal_transform_dst_point_x(pt : SignaltransformdstPoint) -> Double { pt.x }

pub fn signal_transform_dst_point_y(pt : SignaltransformdstPoint) -> Double { pt.y }

pub fn signal_transform_dst_point_z(pt : SignaltransformdstPoint) -> Double { pt.z }

pub fn signal_transform_dst_point_label(pt : SignaltransformdstPoint) -> Int { pt.label }

pub fn signal_transform_dst_point_dist(a : SignaltransformdstPoint, b : SignaltransformdstPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn signal_transform_dst_point_add(a : SignaltransformdstPoint, b : SignaltransformdstPoint) -> SignaltransformdstPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn signal_transform_dst_point_sub(a : SignaltransformdstPoint, b : SignaltransformdstPoint) -> SignaltransformdstPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn signal_transform_dst_point_scale(pt : SignaltransformdstPoint, s : Double) -> SignaltransformdstPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn signal_transform_dst_point_dot(a : SignaltransformdstPoint, b : SignaltransformdstPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn signal_transform_dst_point_cross(a : SignaltransformdstPoint, b : SignaltransformdstPoint) -> SignaltransformdstPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn signal_transform_dst_point_norm(pt : SignaltransformdstPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn signal_transform_dst_point_normalize(pt : SignaltransformdstPoint) -> SignaltransformdstPoint {
  let n = signal_transform_dst_point_norm(pt)
  if n < 0.0000001 { pt } else { signal_transform_dst_point_scale(pt, 1.0 / n) }
}

pub fn signal_transform_dst_point_negate(pt : SignaltransformdstPoint) -> SignaltransformdstPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn signal_transform_dst_point_mid(a : SignaltransformdstPoint, b : SignaltransformdstPoint) -> SignaltransformdstPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn signal_transform_dst_point_lerp(a : SignaltransformdstPoint, b : SignaltransformdstPoint, t : Double) -> SignaltransformdstPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn signal_transform_dst_point_to_string(pt : SignaltransformdstPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct SignaltransformdstSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_transform_dst_make_series(vals : Array[Double], name : String) -> SignaltransformdstSeries {
  { vals, name, meta: 0 }
}

pub fn signal_transform_dst_series_len(s : SignaltransformdstSeries) -> Int { s.vals.length() }

pub fn signal_transform_dst_series_sum(s : SignaltransformdstSeries) -> Double { @_common.sum(s.vals) }

pub fn signal_transform_dst_series_mean(s : SignaltransformdstSeries) -> Double { @_common.mean(s.vals) }

pub fn signal_transform_dst_series_min(s : SignaltransformdstSeries) -> Double { @_common.min(s.vals) }

pub fn signal_transform_dst_series_max(s : SignaltransformdstSeries) -> Double { @_common.max(s.vals) }

pub fn signal_transform_dst_series_range(s : SignaltransformdstSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn signal_transform_dst_series_var(s : SignaltransformdstSeries) -> Double { @_common.variance(s.vals) }

pub fn signal_transform_dst_series_std(s : SignaltransformdstSeries) -> Double { @_common.std(s.vals) }

pub fn signal_transform_dst_series_median(s : SignaltransformdstSeries) -> Double { @_common.median(s.vals) }

pub fn signal_transform_dst_series_scale(s : SignaltransformdstSeries, f : Double) -> SignaltransformdstSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn signal_transform_dst_series_add(a : SignaltransformdstSeries, b : SignaltransformdstSeries) -> SignaltransformdstSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn signal_transform_dst_series_sub(a : SignaltransformdstSeries, b : SignaltransformdstSeries) -> SignaltransformdstSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn signal_transform_dst_series_normalize(s : SignaltransformdstSeries) -> SignaltransformdstSeries {
  let mn = signal_transform_dst_series_min(s)
  let mx = signal_transform_dst_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn signal_transform_dst_series_cumsum(s : SignaltransformdstSeries) -> SignaltransformdstSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn signal_transform_dst_series_to_string(s : SignaltransformdstSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignaltransformdstMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_transform_dst_make_matrix(rows : Int, cols : Int, val : Double) -> SignaltransformdstMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn signal_transform_dst_matrix_identity(n : Int) -> SignaltransformdstMatrix {
  let m = signal_transform_dst_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn signal_transform_dst_matrix_get(m : SignaltransformdstMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn signal_transform_dst_matrix_transpose(m : SignaltransformdstMatrix) -> SignaltransformdstMatrix {
  let result = signal_transform_dst_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn signal_transform_dst_matrix_add(a : SignaltransformdstMatrix, b : SignaltransformdstMatrix) -> SignaltransformdstMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = signal_transform_dst_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn signal_transform_dst_matrix_scale(m : SignaltransformdstMatrix, s : Double) -> SignaltransformdstMatrix {
  let result = signal_transform_dst_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn signal_transform_dst_matrix_multiply(a : SignaltransformdstMatrix, b : SignaltransformdstMatrix) -> SignaltransformdstMatrix {
  if a.cols != b.rows { return signal_transform_dst_make_matrix(a.rows, b.cols, 0.0) }
  let result = signal_transform_dst_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn signal_transform_dst_matrix_trace(m : SignaltransformdstMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn signal_transform_dst_matrix_det(m : SignaltransformdstMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn signal_transform_dst_matrix_norm(m : SignaltransformdstMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn signal_transform_dst_matrix_to_string(m : SignaltransformdstMatrix) -> String {
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

pub(all) struct SignaltransformdstVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_transform_dst_make_vector(comps : Array[Double]) -> SignaltransformdstVector {
  { comps, dim: comps.length() }
}

pub fn signal_transform_dst_vector_zero(dim : Int) -> SignaltransformdstVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn signal_transform_dst_vector_add(a : SignaltransformdstVector, b : SignaltransformdstVector) -> SignaltransformdstVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn signal_transform_dst_vector_sub(a : SignaltransformdstVector, b : SignaltransformdstVector) -> SignaltransformdstVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn signal_transform_dst_vector_scale(v : SignaltransformdstVector, s : Double) -> SignaltransformdstVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn signal_transform_dst_vector_dot(a : SignaltransformdstVector, b : SignaltransformdstVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn signal_transform_dst_vector_norm(v : SignaltransformdstVector) -> Double { @_common.sqrt(signal_transform_dst_vector_dot(v, v)) }

pub fn signal_transform_dst_vector_normalize(v : SignaltransformdstVector) -> SignaltransformdstVector {
  let n = signal_transform_dst_vector_norm(v)
  if n < 0.0000001 { v } else { signal_transform_dst_vector_scale(v, 1.0 / n) }
}

pub fn signal_transform_dst_vector_dist(a : SignaltransformdstVector, b : SignaltransformdstVector) -> Double {
  signal_transform_dst_vector_norm(signal_transform_dst_vector_sub(a, b))
}

pub fn signal_transform_dst_vector_to_string(v : SignaltransformdstVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn signal_transform_dst_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn signal_transform_dst_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn signal_transform_dst_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn signal_transform_dst_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn signal_transform_dst_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn signal_transform_dst_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn signal_transform_dst_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn signal_transform_dst_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn signal_transform_dst_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn signal_transform_dst_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn signal_transform_dst_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn signal_transform_dst_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn signal_transform_dst_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn signal_transform_dst_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn signal_transform_dst_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn signal_transform_dst_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn signal_transform_dst_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn signal_transform_dst_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn signal_transform_dst_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn signal_transform_dst_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn signal_transform_dst_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn signal_transform_dst_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn signal_transform_dst_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn signal_transform_dst_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn signal_transform_dst_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn signal_transform_dst_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn signal_transform_dst_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn signal_transform_dst_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn signal_transform_dst_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SignaltransformdstFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dst_frame_make(size : Int) -> SignaltransformdstFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_dst_frame_len(s : SignaltransformdstFrame) -> Int { s.size }

pub fn signal_transform_dst_frame_get(s : SignaltransformdstFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_dst_frame_set(s : SignaltransformdstFrame, i : Int, v : Double) -> SignaltransformdstFrame {
  let result = signal_transform_dst_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_dst_frame_sum(s : SignaltransformdstFrame) -> Double { @_common.sum(s.data) }

pub fn signal_transform_dst_frame_mean(s : SignaltransformdstFrame) -> Double { @_common.mean(s.data) }

pub fn signal_transform_dst_frame_scale(s : SignaltransformdstFrame, f : Double) -> SignaltransformdstFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_dst_frame_add(a : SignaltransformdstFrame, b : SignaltransformdstFrame) -> SignaltransformdstFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_dst_frame_copy(s : SignaltransformdstFrame) -> SignaltransformdstFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_dst_frame_fill(s : SignaltransformdstFrame, v : Double) -> SignaltransformdstFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_dst_frame_min(s : SignaltransformdstFrame) -> Double { @_common.min(s.data) }

pub fn signal_transform_dst_frame_max(s : SignaltransformdstFrame) -> Double { @_common.max(s.data) }

pub fn signal_transform_dst_frame_to_string(s : SignaltransformdstFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformdstTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dst_table_make(size : Int) -> SignaltransformdstTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_dst_table_len(s : SignaltransformdstTable) -> Int { s.size }

pub fn signal_transform_dst_table_get(s : SignaltransformdstTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_dst_table_set(s : SignaltransformdstTable, i : Int, v : Double) -> SignaltransformdstTable {
  let result = signal_transform_dst_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_dst_table_sum(s : SignaltransformdstTable) -> Double { @_common.sum(s.data) }

pub fn signal_transform_dst_table_mean(s : SignaltransformdstTable) -> Double { @_common.mean(s.data) }

pub fn signal_transform_dst_table_scale(s : SignaltransformdstTable, f : Double) -> SignaltransformdstTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_dst_table_add(a : SignaltransformdstTable, b : SignaltransformdstTable) -> SignaltransformdstTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_dst_table_copy(s : SignaltransformdstTable) -> SignaltransformdstTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_dst_table_fill(s : SignaltransformdstTable, v : Double) -> SignaltransformdstTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_dst_table_min(s : SignaltransformdstTable) -> Double { @_common.min(s.data) }

pub fn signal_transform_dst_table_max(s : SignaltransformdstTable) -> Double { @_common.max(s.data) }

pub fn signal_transform_dst_table_to_string(s : SignaltransformdstTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformdstGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dst_graphn_make(size : Int) -> SignaltransformdstGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_dst_graphn_len(s : SignaltransformdstGraphN) -> Int { s.size }

pub fn signal_transform_dst_graphn_get(s : SignaltransformdstGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_dst_graphn_set(s : SignaltransformdstGraphN, i : Int, v : Double) -> SignaltransformdstGraphN {
  let result = signal_transform_dst_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_dst_graphn_sum(s : SignaltransformdstGraphN) -> Double { @_common.sum(s.data) }

pub fn signal_transform_dst_graphn_mean(s : SignaltransformdstGraphN) -> Double { @_common.mean(s.data) }

pub fn signal_transform_dst_graphn_scale(s : SignaltransformdstGraphN, f : Double) -> SignaltransformdstGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_dst_graphn_add(a : SignaltransformdstGraphN, b : SignaltransformdstGraphN) -> SignaltransformdstGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_dst_graphn_copy(s : SignaltransformdstGraphN) -> SignaltransformdstGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_dst_graphn_fill(s : SignaltransformdstGraphN, v : Double) -> SignaltransformdstGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_dst_graphn_min(s : SignaltransformdstGraphN) -> Double { @_common.min(s.data) }

pub fn signal_transform_dst_graphn_max(s : SignaltransformdstGraphN) -> Double { @_common.max(s.data) }

pub fn signal_transform_dst_graphn_to_string(s : SignaltransformdstGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformdstNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dst_node_make(size : Int) -> SignaltransformdstNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_dst_node_len(s : SignaltransformdstNode) -> Int { s.size }

pub fn signal_transform_dst_node_get(s : SignaltransformdstNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_dst_node_set(s : SignaltransformdstNode, i : Int, v : Double) -> SignaltransformdstNode {
  let result = signal_transform_dst_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_dst_node_sum(s : SignaltransformdstNode) -> Double { @_common.sum(s.data) }

pub fn signal_transform_dst_node_mean(s : SignaltransformdstNode) -> Double { @_common.mean(s.data) }

pub fn signal_transform_dst_node_scale(s : SignaltransformdstNode, f : Double) -> SignaltransformdstNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_dst_node_add(a : SignaltransformdstNode, b : SignaltransformdstNode) -> SignaltransformdstNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_dst_node_copy(s : SignaltransformdstNode) -> SignaltransformdstNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_dst_node_fill(s : SignaltransformdstNode, v : Double) -> SignaltransformdstNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_dst_node_min(s : SignaltransformdstNode) -> Double { @_common.min(s.data) }

pub fn signal_transform_dst_node_max(s : SignaltransformdstNode) -> Double { @_common.max(s.data) }

pub fn signal_transform_dst_node_to_string(s : SignaltransformdstNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformdstEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dst_edge_make(size : Int) -> SignaltransformdstEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_dst_edge_len(s : SignaltransformdstEdge) -> Int { s.size }

pub fn signal_transform_dst_edge_get(s : SignaltransformdstEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_dst_edge_set(s : SignaltransformdstEdge, i : Int, v : Double) -> SignaltransformdstEdge {
  let result = signal_transform_dst_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_dst_edge_sum(s : SignaltransformdstEdge) -> Double { @_common.sum(s.data) }

pub fn signal_transform_dst_edge_mean(s : SignaltransformdstEdge) -> Double { @_common.mean(s.data) }

pub fn signal_transform_dst_edge_scale(s : SignaltransformdstEdge, f : Double) -> SignaltransformdstEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_dst_edge_add(a : SignaltransformdstEdge, b : SignaltransformdstEdge) -> SignaltransformdstEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_dst_edge_copy(s : SignaltransformdstEdge) -> SignaltransformdstEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_dst_edge_fill(s : SignaltransformdstEdge, v : Double) -> SignaltransformdstEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_dst_edge_min(s : SignaltransformdstEdge) -> Double { @_common.min(s.data) }

pub fn signal_transform_dst_edge_max(s : SignaltransformdstEdge) -> Double { @_common.max(s.data) }

pub fn signal_transform_dst_edge_to_string(s : SignaltransformdstEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformdstPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dst_path_make(size : Int) -> SignaltransformdstPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_dst_path_len(s : SignaltransformdstPath) -> Int { s.size }

pub fn signal_transform_dst_path_get(s : SignaltransformdstPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_dst_path_set(s : SignaltransformdstPath, i : Int, v : Double) -> SignaltransformdstPath {
  let result = signal_transform_dst_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_dst_path_sum(s : SignaltransformdstPath) -> Double { @_common.sum(s.data) }

pub fn signal_transform_dst_path_mean(s : SignaltransformdstPath) -> Double { @_common.mean(s.data) }

pub fn signal_transform_dst_path_scale(s : SignaltransformdstPath, f : Double) -> SignaltransformdstPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_dst_path_add(a : SignaltransformdstPath, b : SignaltransformdstPath) -> SignaltransformdstPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_dst_path_copy(s : SignaltransformdstPath) -> SignaltransformdstPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_dst_path_fill(s : SignaltransformdstPath, v : Double) -> SignaltransformdstPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_dst_path_min(s : SignaltransformdstPath) -> Double { @_common.min(s.data) }

pub fn signal_transform_dst_path_max(s : SignaltransformdstPath) -> Double { @_common.max(s.data) }

pub fn signal_transform_dst_path_to_string(s : SignaltransformdstPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformdstCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dst_cluster_make(size : Int) -> SignaltransformdstCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_dst_cluster_len(s : SignaltransformdstCluster) -> Int { s.size }

pub fn signal_transform_dst_cluster_get(s : SignaltransformdstCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_dst_cluster_set(s : SignaltransformdstCluster, i : Int, v : Double) -> SignaltransformdstCluster {
  let result = signal_transform_dst_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_dst_cluster_sum(s : SignaltransformdstCluster) -> Double { @_common.sum(s.data) }

pub fn signal_transform_dst_cluster_mean(s : SignaltransformdstCluster) -> Double { @_common.mean(s.data) }

pub fn signal_transform_dst_cluster_scale(s : SignaltransformdstCluster, f : Double) -> SignaltransformdstCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_dst_cluster_add(a : SignaltransformdstCluster, b : SignaltransformdstCluster) -> SignaltransformdstCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_dst_cluster_copy(s : SignaltransformdstCluster) -> SignaltransformdstCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_dst_cluster_fill(s : SignaltransformdstCluster, v : Double) -> SignaltransformdstCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_dst_cluster_min(s : SignaltransformdstCluster) -> Double { @_common.min(s.data) }

pub fn signal_transform_dst_cluster_max(s : SignaltransformdstCluster) -> Double { @_common.max(s.data) }

pub fn signal_transform_dst_cluster_to_string(s : SignaltransformdstCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformdstModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dst_model_make(size : Int) -> SignaltransformdstModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_dst_model_len(s : SignaltransformdstModel) -> Int { s.size }

pub fn signal_transform_dst_model_get(s : SignaltransformdstModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_dst_model_set(s : SignaltransformdstModel, i : Int, v : Double) -> SignaltransformdstModel {
  let result = signal_transform_dst_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_dst_model_sum(s : SignaltransformdstModel) -> Double { @_common.sum(s.data) }

pub fn signal_transform_dst_model_mean(s : SignaltransformdstModel) -> Double { @_common.mean(s.data) }

pub fn signal_transform_dst_model_scale(s : SignaltransformdstModel, f : Double) -> SignaltransformdstModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_dst_model_add(a : SignaltransformdstModel, b : SignaltransformdstModel) -> SignaltransformdstModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_dst_model_copy(s : SignaltransformdstModel) -> SignaltransformdstModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_dst_model_fill(s : SignaltransformdstModel, v : Double) -> SignaltransformdstModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_dst_model_min(s : SignaltransformdstModel) -> Double { @_common.min(s.data) }

pub fn signal_transform_dst_model_max(s : SignaltransformdstModel) -> Double { @_common.max(s.data) }

pub fn signal_transform_dst_model_to_string(s : SignaltransformdstModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformdstLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dst_layer_make(size : Int) -> SignaltransformdstLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_dst_layer_len(s : SignaltransformdstLayer) -> Int { s.size }

pub fn signal_transform_dst_layer_get(s : SignaltransformdstLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_dst_layer_set(s : SignaltransformdstLayer, i : Int, v : Double) -> SignaltransformdstLayer {
  let result = signal_transform_dst_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_dst_layer_sum(s : SignaltransformdstLayer) -> Double { @_common.sum(s.data) }

pub fn signal_transform_dst_layer_mean(s : SignaltransformdstLayer) -> Double { @_common.mean(s.data) }

pub fn signal_transform_dst_layer_scale(s : SignaltransformdstLayer, f : Double) -> SignaltransformdstLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_dst_layer_add(a : SignaltransformdstLayer, b : SignaltransformdstLayer) -> SignaltransformdstLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_dst_layer_copy(s : SignaltransformdstLayer) -> SignaltransformdstLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_dst_layer_fill(s : SignaltransformdstLayer, v : Double) -> SignaltransformdstLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_dst_layer_min(s : SignaltransformdstLayer) -> Double { @_common.min(s.data) }

pub fn signal_transform_dst_layer_max(s : SignaltransformdstLayer) -> Double { @_common.max(s.data) }

pub fn signal_transform_dst_layer_to_string(s : SignaltransformdstLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformdstBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dst_buffer_make(size : Int) -> SignaltransformdstBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_dst_buffer_len(s : SignaltransformdstBuffer) -> Int { s.size }

pub fn signal_transform_dst_buffer_get(s : SignaltransformdstBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_dst_buffer_set(s : SignaltransformdstBuffer, i : Int, v : Double) -> SignaltransformdstBuffer {
  let result = signal_transform_dst_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_dst_buffer_sum(s : SignaltransformdstBuffer) -> Double { @_common.sum(s.data) }

pub fn signal_transform_dst_buffer_mean(s : SignaltransformdstBuffer) -> Double { @_common.mean(s.data) }

pub fn signal_transform_dst_buffer_scale(s : SignaltransformdstBuffer, f : Double) -> SignaltransformdstBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_dst_buffer_add(a : SignaltransformdstBuffer, b : SignaltransformdstBuffer) -> SignaltransformdstBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_dst_buffer_copy(s : SignaltransformdstBuffer) -> SignaltransformdstBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_dst_buffer_fill(s : SignaltransformdstBuffer, v : Double) -> SignaltransformdstBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_dst_buffer_min(s : SignaltransformdstBuffer) -> Double { @_common.min(s.data) }

pub fn signal_transform_dst_buffer_max(s : SignaltransformdstBuffer) -> Double { @_common.max(s.data) }

pub fn signal_transform_dst_buffer_to_string(s : SignaltransformdstBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformdstCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dst_cursor_make(size : Int) -> SignaltransformdstCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_dst_cursor_len(s : SignaltransformdstCursor) -> Int { s.size }

pub fn signal_transform_dst_cursor_get(s : SignaltransformdstCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_dst_cursor_set(s : SignaltransformdstCursor, i : Int, v : Double) -> SignaltransformdstCursor {
  let result = signal_transform_dst_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_dst_cursor_sum(s : SignaltransformdstCursor) -> Double { @_common.sum(s.data) }

pub fn signal_transform_dst_cursor_mean(s : SignaltransformdstCursor) -> Double { @_common.mean(s.data) }

pub fn signal_transform_dst_cursor_scale(s : SignaltransformdstCursor, f : Double) -> SignaltransformdstCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_dst_cursor_add(a : SignaltransformdstCursor, b : SignaltransformdstCursor) -> SignaltransformdstCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_dst_cursor_copy(s : SignaltransformdstCursor) -> SignaltransformdstCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_dst_cursor_fill(s : SignaltransformdstCursor, v : Double) -> SignaltransformdstCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_dst_cursor_min(s : SignaltransformdstCursor) -> Double { @_common.min(s.data) }

pub fn signal_transform_dst_cursor_max(s : SignaltransformdstCursor) -> Double { @_common.max(s.data) }

pub fn signal_transform_dst_cursor_to_string(s : SignaltransformdstCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformdstView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dst_view_make(size : Int) -> SignaltransformdstView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_dst_view_len(s : SignaltransformdstView) -> Int { s.size }

pub fn signal_transform_dst_view_get(s : SignaltransformdstView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_dst_view_set(s : SignaltransformdstView, i : Int, v : Double) -> SignaltransformdstView {
  let result = signal_transform_dst_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_dst_view_sum(s : SignaltransformdstView) -> Double { @_common.sum(s.data) }

pub fn signal_transform_dst_view_mean(s : SignaltransformdstView) -> Double { @_common.mean(s.data) }

pub fn signal_transform_dst_view_scale(s : SignaltransformdstView, f : Double) -> SignaltransformdstView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_dst_view_add(a : SignaltransformdstView, b : SignaltransformdstView) -> SignaltransformdstView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_dst_view_copy(s : SignaltransformdstView) -> SignaltransformdstView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_dst_view_fill(s : SignaltransformdstView, v : Double) -> SignaltransformdstView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_dst_view_min(s : SignaltransformdstView) -> Double { @_common.min(s.data) }

pub fn signal_transform_dst_view_max(s : SignaltransformdstView) -> Double { @_common.max(s.data) }

pub fn signal_transform_dst_view_to_string(s : SignaltransformdstView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformdstRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dst_range_make(size : Int) -> SignaltransformdstRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_dst_range_len(s : SignaltransformdstRange) -> Int { s.size }

pub fn signal_transform_dst_range_get(s : SignaltransformdstRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_dst_range_set(s : SignaltransformdstRange, i : Int, v : Double) -> SignaltransformdstRange {
  let result = signal_transform_dst_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_dst_range_sum(s : SignaltransformdstRange) -> Double { @_common.sum(s.data) }

pub fn signal_transform_dst_range_mean(s : SignaltransformdstRange) -> Double { @_common.mean(s.data) }

pub fn signal_transform_dst_range_scale(s : SignaltransformdstRange, f : Double) -> SignaltransformdstRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_dst_range_add(a : SignaltransformdstRange, b : SignaltransformdstRange) -> SignaltransformdstRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_dst_range_copy(s : SignaltransformdstRange) -> SignaltransformdstRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_dst_range_fill(s : SignaltransformdstRange, v : Double) -> SignaltransformdstRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_dst_range_min(s : SignaltransformdstRange) -> Double { @_common.min(s.data) }

pub fn signal_transform_dst_range_max(s : SignaltransformdstRange) -> Double { @_common.max(s.data) }

pub fn signal_transform_dst_range_to_string(s : SignaltransformdstRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformdstSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dst_slice_make(size : Int) -> SignaltransformdstSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_dst_slice_len(s : SignaltransformdstSlice) -> Int { s.size }

pub fn signal_transform_dst_slice_get(s : SignaltransformdstSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_dst_slice_set(s : SignaltransformdstSlice, i : Int, v : Double) -> SignaltransformdstSlice {
  let result = signal_transform_dst_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_transform_dst_slice_sum(s : SignaltransformdstSlice) -> Double { @_common.sum(s.data) }

pub fn signal_transform_dst_slice_mean(s : SignaltransformdstSlice) -> Double { @_common.mean(s.data) }

pub fn signal_transform_dst_slice_scale(s : SignaltransformdstSlice, f : Double) -> SignaltransformdstSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_dst_slice_add(a : SignaltransformdstSlice, b : SignaltransformdstSlice) -> SignaltransformdstSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_dst_slice_copy(s : SignaltransformdstSlice) -> SignaltransformdstSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_dst_slice_fill(s : SignaltransformdstSlice, v : Double) -> SignaltransformdstSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_dst_slice_min(s : SignaltransformdstSlice) -> Double { @_common.min(s.data) }

pub fn signal_transform_dst_slice_max(s : SignaltransformdstSlice) -> Double { @_common.max(s.data) }

pub fn signal_transform_dst_slice_to_string(s : SignaltransformdstSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


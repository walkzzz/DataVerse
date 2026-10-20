///===
/// extcore/signal_spec_bartlett

pub(all) struct SignalspecbartlettPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_spec_bartlett_make_point(x : Double, y : Double) -> SignalspecbartlettPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_spec_bartlett_make_point3(x : Double, y : Double, z : Double) -> SignalspecbartlettPoint {
  { x, y, z, label: 0 }
}

pub fn signal_spec_bartlett_point_x(pt : SignalspecbartlettPoint) -> Double { pt.x }

pub fn signal_spec_bartlett_point_y(pt : SignalspecbartlettPoint) -> Double { pt.y }

pub fn signal_spec_bartlett_point_z(pt : SignalspecbartlettPoint) -> Double { pt.z }

pub fn signal_spec_bartlett_point_label(pt : SignalspecbartlettPoint) -> Int { pt.label }

pub fn signal_spec_bartlett_point_dist(a : SignalspecbartlettPoint, b : SignalspecbartlettPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn signal_spec_bartlett_point_add(a : SignalspecbartlettPoint, b : SignalspecbartlettPoint) -> SignalspecbartlettPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn signal_spec_bartlett_point_sub(a : SignalspecbartlettPoint, b : SignalspecbartlettPoint) -> SignalspecbartlettPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn signal_spec_bartlett_point_scale(pt : SignalspecbartlettPoint, s : Double) -> SignalspecbartlettPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn signal_spec_bartlett_point_dot(a : SignalspecbartlettPoint, b : SignalspecbartlettPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn signal_spec_bartlett_point_cross(a : SignalspecbartlettPoint, b : SignalspecbartlettPoint) -> SignalspecbartlettPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn signal_spec_bartlett_point_norm(pt : SignalspecbartlettPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn signal_spec_bartlett_point_normalize(pt : SignalspecbartlettPoint) -> SignalspecbartlettPoint {
  let n = signal_spec_bartlett_point_norm(pt)
  if n < 0.0000001 { pt } else { signal_spec_bartlett_point_scale(pt, 1.0 / n) }
}

pub fn signal_spec_bartlett_point_negate(pt : SignalspecbartlettPoint) -> SignalspecbartlettPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn signal_spec_bartlett_point_mid(a : SignalspecbartlettPoint, b : SignalspecbartlettPoint) -> SignalspecbartlettPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn signal_spec_bartlett_point_lerp(a : SignalspecbartlettPoint, b : SignalspecbartlettPoint, t : Double) -> SignalspecbartlettPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn signal_spec_bartlett_point_to_string(pt : SignalspecbartlettPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct SignalspecbartlettSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_spec_bartlett_make_series(vals : Array[Double], name : String) -> SignalspecbartlettSeries {
  { vals, name, meta: 0 }
}

pub fn signal_spec_bartlett_series_len(s : SignalspecbartlettSeries) -> Int { s.vals.length() }

pub fn signal_spec_bartlett_series_sum(s : SignalspecbartlettSeries) -> Double { @_common.sum(s.vals) }

pub fn signal_spec_bartlett_series_mean(s : SignalspecbartlettSeries) -> Double { @_common.mean(s.vals) }

pub fn signal_spec_bartlett_series_min(s : SignalspecbartlettSeries) -> Double { @_common.min(s.vals) }

pub fn signal_spec_bartlett_series_max(s : SignalspecbartlettSeries) -> Double { @_common.max(s.vals) }

pub fn signal_spec_bartlett_series_range(s : SignalspecbartlettSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn signal_spec_bartlett_series_var(s : SignalspecbartlettSeries) -> Double { @_common.variance(s.vals) }

pub fn signal_spec_bartlett_series_std(s : SignalspecbartlettSeries) -> Double { @_common.std(s.vals) }

pub fn signal_spec_bartlett_series_median(s : SignalspecbartlettSeries) -> Double { @_common.median(s.vals) }

pub fn signal_spec_bartlett_series_scale(s : SignalspecbartlettSeries, f : Double) -> SignalspecbartlettSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn signal_spec_bartlett_series_add(a : SignalspecbartlettSeries, b : SignalspecbartlettSeries) -> SignalspecbartlettSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn signal_spec_bartlett_series_sub(a : SignalspecbartlettSeries, b : SignalspecbartlettSeries) -> SignalspecbartlettSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn signal_spec_bartlett_series_normalize(s : SignalspecbartlettSeries) -> SignalspecbartlettSeries {
  let mn = signal_spec_bartlett_series_min(s)
  let mx = signal_spec_bartlett_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn signal_spec_bartlett_series_cumsum(s : SignalspecbartlettSeries) -> SignalspecbartlettSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn signal_spec_bartlett_series_to_string(s : SignalspecbartlettSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignalspecbartlettMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_spec_bartlett_make_matrix(rows : Int, cols : Int, val : Double) -> SignalspecbartlettMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn signal_spec_bartlett_matrix_identity(n : Int) -> SignalspecbartlettMatrix {
  let m = signal_spec_bartlett_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn signal_spec_bartlett_matrix_get(m : SignalspecbartlettMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn signal_spec_bartlett_matrix_transpose(m : SignalspecbartlettMatrix) -> SignalspecbartlettMatrix {
  let result = signal_spec_bartlett_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn signal_spec_bartlett_matrix_add(a : SignalspecbartlettMatrix, b : SignalspecbartlettMatrix) -> SignalspecbartlettMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = signal_spec_bartlett_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn signal_spec_bartlett_matrix_scale(m : SignalspecbartlettMatrix, s : Double) -> SignalspecbartlettMatrix {
  let result = signal_spec_bartlett_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn signal_spec_bartlett_matrix_multiply(a : SignalspecbartlettMatrix, b : SignalspecbartlettMatrix) -> SignalspecbartlettMatrix {
  if a.cols != b.rows { return signal_spec_bartlett_make_matrix(a.rows, b.cols, 0.0) }
  let result = signal_spec_bartlett_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn signal_spec_bartlett_matrix_trace(m : SignalspecbartlettMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn signal_spec_bartlett_matrix_det(m : SignalspecbartlettMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn signal_spec_bartlett_matrix_norm(m : SignalspecbartlettMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn signal_spec_bartlett_matrix_to_string(m : SignalspecbartlettMatrix) -> String {
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

pub(all) struct SignalspecbartlettVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_spec_bartlett_make_vector(comps : Array[Double]) -> SignalspecbartlettVector {
  { comps, dim: comps.length() }
}

pub fn signal_spec_bartlett_vector_zero(dim : Int) -> SignalspecbartlettVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn signal_spec_bartlett_vector_add(a : SignalspecbartlettVector, b : SignalspecbartlettVector) -> SignalspecbartlettVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn signal_spec_bartlett_vector_sub(a : SignalspecbartlettVector, b : SignalspecbartlettVector) -> SignalspecbartlettVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn signal_spec_bartlett_vector_scale(v : SignalspecbartlettVector, s : Double) -> SignalspecbartlettVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn signal_spec_bartlett_vector_dot(a : SignalspecbartlettVector, b : SignalspecbartlettVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn signal_spec_bartlett_vector_norm(v : SignalspecbartlettVector) -> Double { @_common.sqrt(signal_spec_bartlett_vector_dot(v, v)) }

pub fn signal_spec_bartlett_vector_normalize(v : SignalspecbartlettVector) -> SignalspecbartlettVector {
  let n = signal_spec_bartlett_vector_norm(v)
  if n < 0.0000001 { v } else { signal_spec_bartlett_vector_scale(v, 1.0 / n) }
}

pub fn signal_spec_bartlett_vector_dist(a : SignalspecbartlettVector, b : SignalspecbartlettVector) -> Double {
  signal_spec_bartlett_vector_norm(signal_spec_bartlett_vector_sub(a, b))
}

pub fn signal_spec_bartlett_vector_to_string(v : SignalspecbartlettVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn signal_spec_bartlett_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn signal_spec_bartlett_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn signal_spec_bartlett_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn signal_spec_bartlett_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn signal_spec_bartlett_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn signal_spec_bartlett_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn signal_spec_bartlett_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn signal_spec_bartlett_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn signal_spec_bartlett_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn signal_spec_bartlett_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn signal_spec_bartlett_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn signal_spec_bartlett_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn signal_spec_bartlett_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn signal_spec_bartlett_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn signal_spec_bartlett_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn signal_spec_bartlett_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn signal_spec_bartlett_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn signal_spec_bartlett_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn signal_spec_bartlett_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn signal_spec_bartlett_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn signal_spec_bartlett_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn signal_spec_bartlett_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn signal_spec_bartlett_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn signal_spec_bartlett_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn signal_spec_bartlett_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn signal_spec_bartlett_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn signal_spec_bartlett_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn signal_spec_bartlett_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn signal_spec_bartlett_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SignalspecbartlettFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_bartlett_frame_make(size : Int) -> SignalspecbartlettFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_bartlett_frame_len(s : SignalspecbartlettFrame) -> Int { s.size }

pub fn signal_spec_bartlett_frame_get(s : SignalspecbartlettFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_bartlett_frame_set(s : SignalspecbartlettFrame, i : Int, v : Double) -> SignalspecbartlettFrame {
  let result = signal_spec_bartlett_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_bartlett_frame_sum(s : SignalspecbartlettFrame) -> Double { @_common.sum(s.data) }

pub fn signal_spec_bartlett_frame_mean(s : SignalspecbartlettFrame) -> Double { @_common.mean(s.data) }

pub fn signal_spec_bartlett_frame_scale(s : SignalspecbartlettFrame, f : Double) -> SignalspecbartlettFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_bartlett_frame_add(a : SignalspecbartlettFrame, b : SignalspecbartlettFrame) -> SignalspecbartlettFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_bartlett_frame_copy(s : SignalspecbartlettFrame) -> SignalspecbartlettFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_bartlett_frame_fill(s : SignalspecbartlettFrame, v : Double) -> SignalspecbartlettFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_bartlett_frame_min(s : SignalspecbartlettFrame) -> Double { @_common.min(s.data) }

pub fn signal_spec_bartlett_frame_max(s : SignalspecbartlettFrame) -> Double { @_common.max(s.data) }

pub fn signal_spec_bartlett_frame_to_string(s : SignalspecbartlettFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecbartlettTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_bartlett_table_make(size : Int) -> SignalspecbartlettTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_bartlett_table_len(s : SignalspecbartlettTable) -> Int { s.size }

pub fn signal_spec_bartlett_table_get(s : SignalspecbartlettTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_bartlett_table_set(s : SignalspecbartlettTable, i : Int, v : Double) -> SignalspecbartlettTable {
  let result = signal_spec_bartlett_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_bartlett_table_sum(s : SignalspecbartlettTable) -> Double { @_common.sum(s.data) }

pub fn signal_spec_bartlett_table_mean(s : SignalspecbartlettTable) -> Double { @_common.mean(s.data) }

pub fn signal_spec_bartlett_table_scale(s : SignalspecbartlettTable, f : Double) -> SignalspecbartlettTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_bartlett_table_add(a : SignalspecbartlettTable, b : SignalspecbartlettTable) -> SignalspecbartlettTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_bartlett_table_copy(s : SignalspecbartlettTable) -> SignalspecbartlettTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_bartlett_table_fill(s : SignalspecbartlettTable, v : Double) -> SignalspecbartlettTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_bartlett_table_min(s : SignalspecbartlettTable) -> Double { @_common.min(s.data) }

pub fn signal_spec_bartlett_table_max(s : SignalspecbartlettTable) -> Double { @_common.max(s.data) }

pub fn signal_spec_bartlett_table_to_string(s : SignalspecbartlettTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecbartlettGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_bartlett_graphn_make(size : Int) -> SignalspecbartlettGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_bartlett_graphn_len(s : SignalspecbartlettGraphN) -> Int { s.size }

pub fn signal_spec_bartlett_graphn_get(s : SignalspecbartlettGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_bartlett_graphn_set(s : SignalspecbartlettGraphN, i : Int, v : Double) -> SignalspecbartlettGraphN {
  let result = signal_spec_bartlett_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_bartlett_graphn_sum(s : SignalspecbartlettGraphN) -> Double { @_common.sum(s.data) }

pub fn signal_spec_bartlett_graphn_mean(s : SignalspecbartlettGraphN) -> Double { @_common.mean(s.data) }

pub fn signal_spec_bartlett_graphn_scale(s : SignalspecbartlettGraphN, f : Double) -> SignalspecbartlettGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_bartlett_graphn_add(a : SignalspecbartlettGraphN, b : SignalspecbartlettGraphN) -> SignalspecbartlettGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_bartlett_graphn_copy(s : SignalspecbartlettGraphN) -> SignalspecbartlettGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_bartlett_graphn_fill(s : SignalspecbartlettGraphN, v : Double) -> SignalspecbartlettGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_bartlett_graphn_min(s : SignalspecbartlettGraphN) -> Double { @_common.min(s.data) }

pub fn signal_spec_bartlett_graphn_max(s : SignalspecbartlettGraphN) -> Double { @_common.max(s.data) }

pub fn signal_spec_bartlett_graphn_to_string(s : SignalspecbartlettGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecbartlettNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_bartlett_node_make(size : Int) -> SignalspecbartlettNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_bartlett_node_len(s : SignalspecbartlettNode) -> Int { s.size }

pub fn signal_spec_bartlett_node_get(s : SignalspecbartlettNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_bartlett_node_set(s : SignalspecbartlettNode, i : Int, v : Double) -> SignalspecbartlettNode {
  let result = signal_spec_bartlett_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_bartlett_node_sum(s : SignalspecbartlettNode) -> Double { @_common.sum(s.data) }

pub fn signal_spec_bartlett_node_mean(s : SignalspecbartlettNode) -> Double { @_common.mean(s.data) }

pub fn signal_spec_bartlett_node_scale(s : SignalspecbartlettNode, f : Double) -> SignalspecbartlettNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_bartlett_node_add(a : SignalspecbartlettNode, b : SignalspecbartlettNode) -> SignalspecbartlettNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_bartlett_node_copy(s : SignalspecbartlettNode) -> SignalspecbartlettNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_bartlett_node_fill(s : SignalspecbartlettNode, v : Double) -> SignalspecbartlettNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_bartlett_node_min(s : SignalspecbartlettNode) -> Double { @_common.min(s.data) }

pub fn signal_spec_bartlett_node_max(s : SignalspecbartlettNode) -> Double { @_common.max(s.data) }

pub fn signal_spec_bartlett_node_to_string(s : SignalspecbartlettNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecbartlettEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_bartlett_edge_make(size : Int) -> SignalspecbartlettEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_bartlett_edge_len(s : SignalspecbartlettEdge) -> Int { s.size }

pub fn signal_spec_bartlett_edge_get(s : SignalspecbartlettEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_bartlett_edge_set(s : SignalspecbartlettEdge, i : Int, v : Double) -> SignalspecbartlettEdge {
  let result = signal_spec_bartlett_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_bartlett_edge_sum(s : SignalspecbartlettEdge) -> Double { @_common.sum(s.data) }

pub fn signal_spec_bartlett_edge_mean(s : SignalspecbartlettEdge) -> Double { @_common.mean(s.data) }

pub fn signal_spec_bartlett_edge_scale(s : SignalspecbartlettEdge, f : Double) -> SignalspecbartlettEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_bartlett_edge_add(a : SignalspecbartlettEdge, b : SignalspecbartlettEdge) -> SignalspecbartlettEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_bartlett_edge_copy(s : SignalspecbartlettEdge) -> SignalspecbartlettEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_bartlett_edge_fill(s : SignalspecbartlettEdge, v : Double) -> SignalspecbartlettEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_bartlett_edge_min(s : SignalspecbartlettEdge) -> Double { @_common.min(s.data) }

pub fn signal_spec_bartlett_edge_max(s : SignalspecbartlettEdge) -> Double { @_common.max(s.data) }

pub fn signal_spec_bartlett_edge_to_string(s : SignalspecbartlettEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecbartlettPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_bartlett_path_make(size : Int) -> SignalspecbartlettPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_bartlett_path_len(s : SignalspecbartlettPath) -> Int { s.size }

pub fn signal_spec_bartlett_path_get(s : SignalspecbartlettPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_bartlett_path_set(s : SignalspecbartlettPath, i : Int, v : Double) -> SignalspecbartlettPath {
  let result = signal_spec_bartlett_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_bartlett_path_sum(s : SignalspecbartlettPath) -> Double { @_common.sum(s.data) }

pub fn signal_spec_bartlett_path_mean(s : SignalspecbartlettPath) -> Double { @_common.mean(s.data) }

pub fn signal_spec_bartlett_path_scale(s : SignalspecbartlettPath, f : Double) -> SignalspecbartlettPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_bartlett_path_add(a : SignalspecbartlettPath, b : SignalspecbartlettPath) -> SignalspecbartlettPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_bartlett_path_copy(s : SignalspecbartlettPath) -> SignalspecbartlettPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_bartlett_path_fill(s : SignalspecbartlettPath, v : Double) -> SignalspecbartlettPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_bartlett_path_min(s : SignalspecbartlettPath) -> Double { @_common.min(s.data) }

pub fn signal_spec_bartlett_path_max(s : SignalspecbartlettPath) -> Double { @_common.max(s.data) }

pub fn signal_spec_bartlett_path_to_string(s : SignalspecbartlettPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecbartlettCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_bartlett_cluster_make(size : Int) -> SignalspecbartlettCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_bartlett_cluster_len(s : SignalspecbartlettCluster) -> Int { s.size }

pub fn signal_spec_bartlett_cluster_get(s : SignalspecbartlettCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_bartlett_cluster_set(s : SignalspecbartlettCluster, i : Int, v : Double) -> SignalspecbartlettCluster {
  let result = signal_spec_bartlett_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_bartlett_cluster_sum(s : SignalspecbartlettCluster) -> Double { @_common.sum(s.data) }

pub fn signal_spec_bartlett_cluster_mean(s : SignalspecbartlettCluster) -> Double { @_common.mean(s.data) }

pub fn signal_spec_bartlett_cluster_scale(s : SignalspecbartlettCluster, f : Double) -> SignalspecbartlettCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_bartlett_cluster_add(a : SignalspecbartlettCluster, b : SignalspecbartlettCluster) -> SignalspecbartlettCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_bartlett_cluster_copy(s : SignalspecbartlettCluster) -> SignalspecbartlettCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_bartlett_cluster_fill(s : SignalspecbartlettCluster, v : Double) -> SignalspecbartlettCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_bartlett_cluster_min(s : SignalspecbartlettCluster) -> Double { @_common.min(s.data) }

pub fn signal_spec_bartlett_cluster_max(s : SignalspecbartlettCluster) -> Double { @_common.max(s.data) }

pub fn signal_spec_bartlett_cluster_to_string(s : SignalspecbartlettCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecbartlettModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_bartlett_model_make(size : Int) -> SignalspecbartlettModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_bartlett_model_len(s : SignalspecbartlettModel) -> Int { s.size }

pub fn signal_spec_bartlett_model_get(s : SignalspecbartlettModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_bartlett_model_set(s : SignalspecbartlettModel, i : Int, v : Double) -> SignalspecbartlettModel {
  let result = signal_spec_bartlett_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_bartlett_model_sum(s : SignalspecbartlettModel) -> Double { @_common.sum(s.data) }

pub fn signal_spec_bartlett_model_mean(s : SignalspecbartlettModel) -> Double { @_common.mean(s.data) }

pub fn signal_spec_bartlett_model_scale(s : SignalspecbartlettModel, f : Double) -> SignalspecbartlettModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_bartlett_model_add(a : SignalspecbartlettModel, b : SignalspecbartlettModel) -> SignalspecbartlettModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_bartlett_model_copy(s : SignalspecbartlettModel) -> SignalspecbartlettModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_bartlett_model_fill(s : SignalspecbartlettModel, v : Double) -> SignalspecbartlettModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_bartlett_model_min(s : SignalspecbartlettModel) -> Double { @_common.min(s.data) }

pub fn signal_spec_bartlett_model_max(s : SignalspecbartlettModel) -> Double { @_common.max(s.data) }

pub fn signal_spec_bartlett_model_to_string(s : SignalspecbartlettModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecbartlettLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_bartlett_layer_make(size : Int) -> SignalspecbartlettLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_bartlett_layer_len(s : SignalspecbartlettLayer) -> Int { s.size }

pub fn signal_spec_bartlett_layer_get(s : SignalspecbartlettLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_bartlett_layer_set(s : SignalspecbartlettLayer, i : Int, v : Double) -> SignalspecbartlettLayer {
  let result = signal_spec_bartlett_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_bartlett_layer_sum(s : SignalspecbartlettLayer) -> Double { @_common.sum(s.data) }

pub fn signal_spec_bartlett_layer_mean(s : SignalspecbartlettLayer) -> Double { @_common.mean(s.data) }

pub fn signal_spec_bartlett_layer_scale(s : SignalspecbartlettLayer, f : Double) -> SignalspecbartlettLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_bartlett_layer_add(a : SignalspecbartlettLayer, b : SignalspecbartlettLayer) -> SignalspecbartlettLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_bartlett_layer_copy(s : SignalspecbartlettLayer) -> SignalspecbartlettLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_bartlett_layer_fill(s : SignalspecbartlettLayer, v : Double) -> SignalspecbartlettLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_bartlett_layer_min(s : SignalspecbartlettLayer) -> Double { @_common.min(s.data) }

pub fn signal_spec_bartlett_layer_max(s : SignalspecbartlettLayer) -> Double { @_common.max(s.data) }

pub fn signal_spec_bartlett_layer_to_string(s : SignalspecbartlettLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecbartlettBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_bartlett_buffer_make(size : Int) -> SignalspecbartlettBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_bartlett_buffer_len(s : SignalspecbartlettBuffer) -> Int { s.size }

pub fn signal_spec_bartlett_buffer_get(s : SignalspecbartlettBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_bartlett_buffer_set(s : SignalspecbartlettBuffer, i : Int, v : Double) -> SignalspecbartlettBuffer {
  let result = signal_spec_bartlett_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_bartlett_buffer_sum(s : SignalspecbartlettBuffer) -> Double { @_common.sum(s.data) }

pub fn signal_spec_bartlett_buffer_mean(s : SignalspecbartlettBuffer) -> Double { @_common.mean(s.data) }

pub fn signal_spec_bartlett_buffer_scale(s : SignalspecbartlettBuffer, f : Double) -> SignalspecbartlettBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_bartlett_buffer_add(a : SignalspecbartlettBuffer, b : SignalspecbartlettBuffer) -> SignalspecbartlettBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_bartlett_buffer_copy(s : SignalspecbartlettBuffer) -> SignalspecbartlettBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_bartlett_buffer_fill(s : SignalspecbartlettBuffer, v : Double) -> SignalspecbartlettBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_bartlett_buffer_min(s : SignalspecbartlettBuffer) -> Double { @_common.min(s.data) }

pub fn signal_spec_bartlett_buffer_max(s : SignalspecbartlettBuffer) -> Double { @_common.max(s.data) }

pub fn signal_spec_bartlett_buffer_to_string(s : SignalspecbartlettBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecbartlettCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_bartlett_cursor_make(size : Int) -> SignalspecbartlettCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_bartlett_cursor_len(s : SignalspecbartlettCursor) -> Int { s.size }

pub fn signal_spec_bartlett_cursor_get(s : SignalspecbartlettCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_bartlett_cursor_set(s : SignalspecbartlettCursor, i : Int, v : Double) -> SignalspecbartlettCursor {
  let result = signal_spec_bartlett_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_bartlett_cursor_sum(s : SignalspecbartlettCursor) -> Double { @_common.sum(s.data) }

pub fn signal_spec_bartlett_cursor_mean(s : SignalspecbartlettCursor) -> Double { @_common.mean(s.data) }

pub fn signal_spec_bartlett_cursor_scale(s : SignalspecbartlettCursor, f : Double) -> SignalspecbartlettCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_bartlett_cursor_add(a : SignalspecbartlettCursor, b : SignalspecbartlettCursor) -> SignalspecbartlettCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_bartlett_cursor_copy(s : SignalspecbartlettCursor) -> SignalspecbartlettCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_bartlett_cursor_fill(s : SignalspecbartlettCursor, v : Double) -> SignalspecbartlettCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_bartlett_cursor_min(s : SignalspecbartlettCursor) -> Double { @_common.min(s.data) }

pub fn signal_spec_bartlett_cursor_max(s : SignalspecbartlettCursor) -> Double { @_common.max(s.data) }

pub fn signal_spec_bartlett_cursor_to_string(s : SignalspecbartlettCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecbartlettView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_bartlett_view_make(size : Int) -> SignalspecbartlettView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_bartlett_view_len(s : SignalspecbartlettView) -> Int { s.size }

pub fn signal_spec_bartlett_view_get(s : SignalspecbartlettView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_bartlett_view_set(s : SignalspecbartlettView, i : Int, v : Double) -> SignalspecbartlettView {
  let result = signal_spec_bartlett_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_bartlett_view_sum(s : SignalspecbartlettView) -> Double { @_common.sum(s.data) }

pub fn signal_spec_bartlett_view_mean(s : SignalspecbartlettView) -> Double { @_common.mean(s.data) }

pub fn signal_spec_bartlett_view_scale(s : SignalspecbartlettView, f : Double) -> SignalspecbartlettView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_bartlett_view_add(a : SignalspecbartlettView, b : SignalspecbartlettView) -> SignalspecbartlettView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_bartlett_view_copy(s : SignalspecbartlettView) -> SignalspecbartlettView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_bartlett_view_fill(s : SignalspecbartlettView, v : Double) -> SignalspecbartlettView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_bartlett_view_min(s : SignalspecbartlettView) -> Double { @_common.min(s.data) }

pub fn signal_spec_bartlett_view_max(s : SignalspecbartlettView) -> Double { @_common.max(s.data) }

pub fn signal_spec_bartlett_view_to_string(s : SignalspecbartlettView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecbartlettRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_bartlett_range_make(size : Int) -> SignalspecbartlettRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_bartlett_range_len(s : SignalspecbartlettRange) -> Int { s.size }

pub fn signal_spec_bartlett_range_get(s : SignalspecbartlettRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_bartlett_range_set(s : SignalspecbartlettRange, i : Int, v : Double) -> SignalspecbartlettRange {
  let result = signal_spec_bartlett_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_bartlett_range_sum(s : SignalspecbartlettRange) -> Double { @_common.sum(s.data) }

pub fn signal_spec_bartlett_range_mean(s : SignalspecbartlettRange) -> Double { @_common.mean(s.data) }

pub fn signal_spec_bartlett_range_scale(s : SignalspecbartlettRange, f : Double) -> SignalspecbartlettRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_bartlett_range_add(a : SignalspecbartlettRange, b : SignalspecbartlettRange) -> SignalspecbartlettRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_bartlett_range_copy(s : SignalspecbartlettRange) -> SignalspecbartlettRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_bartlett_range_fill(s : SignalspecbartlettRange, v : Double) -> SignalspecbartlettRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_bartlett_range_min(s : SignalspecbartlettRange) -> Double { @_common.min(s.data) }

pub fn signal_spec_bartlett_range_max(s : SignalspecbartlettRange) -> Double { @_common.max(s.data) }

pub fn signal_spec_bartlett_range_to_string(s : SignalspecbartlettRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecbartlettSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_bartlett_slice_make(size : Int) -> SignalspecbartlettSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_bartlett_slice_len(s : SignalspecbartlettSlice) -> Int { s.size }

pub fn signal_spec_bartlett_slice_get(s : SignalspecbartlettSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_bartlett_slice_set(s : SignalspecbartlettSlice, i : Int, v : Double) -> SignalspecbartlettSlice {
  let result = signal_spec_bartlett_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_bartlett_slice_sum(s : SignalspecbartlettSlice) -> Double { @_common.sum(s.data) }

pub fn signal_spec_bartlett_slice_mean(s : SignalspecbartlettSlice) -> Double { @_common.mean(s.data) }

pub fn signal_spec_bartlett_slice_scale(s : SignalspecbartlettSlice, f : Double) -> SignalspecbartlettSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_bartlett_slice_add(a : SignalspecbartlettSlice, b : SignalspecbartlettSlice) -> SignalspecbartlettSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_bartlett_slice_copy(s : SignalspecbartlettSlice) -> SignalspecbartlettSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_bartlett_slice_fill(s : SignalspecbartlettSlice, v : Double) -> SignalspecbartlettSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_bartlett_slice_min(s : SignalspecbartlettSlice) -> Double { @_common.min(s.data) }

pub fn signal_spec_bartlett_slice_max(s : SignalspecbartlettSlice) -> Double { @_common.max(s.data) }

pub fn signal_spec_bartlett_slice_to_string(s : SignalspecbartlettSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


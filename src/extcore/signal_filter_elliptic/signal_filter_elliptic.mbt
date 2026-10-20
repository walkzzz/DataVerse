///===
/// extcore/signal_filter_elliptic

pub(all) struct SignalfilterellipticPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_filter_elliptic_make_point(x : Double, y : Double) -> SignalfilterellipticPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_filter_elliptic_make_point3(x : Double, y : Double, z : Double) -> SignalfilterellipticPoint {
  { x, y, z, label: 0 }
}

pub fn signal_filter_elliptic_point_x(pt : SignalfilterellipticPoint) -> Double { pt.x }

pub fn signal_filter_elliptic_point_y(pt : SignalfilterellipticPoint) -> Double { pt.y }

pub fn signal_filter_elliptic_point_z(pt : SignalfilterellipticPoint) -> Double { pt.z }

pub fn signal_filter_elliptic_point_label(pt : SignalfilterellipticPoint) -> Int { pt.label }

pub fn signal_filter_elliptic_point_dist(a : SignalfilterellipticPoint, b : SignalfilterellipticPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn signal_filter_elliptic_point_add(a : SignalfilterellipticPoint, b : SignalfilterellipticPoint) -> SignalfilterellipticPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn signal_filter_elliptic_point_sub(a : SignalfilterellipticPoint, b : SignalfilterellipticPoint) -> SignalfilterellipticPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn signal_filter_elliptic_point_scale(pt : SignalfilterellipticPoint, s : Double) -> SignalfilterellipticPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn signal_filter_elliptic_point_dot(a : SignalfilterellipticPoint, b : SignalfilterellipticPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn signal_filter_elliptic_point_cross(a : SignalfilterellipticPoint, b : SignalfilterellipticPoint) -> SignalfilterellipticPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn signal_filter_elliptic_point_norm(pt : SignalfilterellipticPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn signal_filter_elliptic_point_normalize(pt : SignalfilterellipticPoint) -> SignalfilterellipticPoint {
  let n = signal_filter_elliptic_point_norm(pt)
  if n < 0.0000001 { pt } else { signal_filter_elliptic_point_scale(pt, 1.0 / n) }
}

pub fn signal_filter_elliptic_point_negate(pt : SignalfilterellipticPoint) -> SignalfilterellipticPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn signal_filter_elliptic_point_mid(a : SignalfilterellipticPoint, b : SignalfilterellipticPoint) -> SignalfilterellipticPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn signal_filter_elliptic_point_lerp(a : SignalfilterellipticPoint, b : SignalfilterellipticPoint, t : Double) -> SignalfilterellipticPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn signal_filter_elliptic_point_to_string(pt : SignalfilterellipticPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct SignalfilterellipticSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_filter_elliptic_make_series(vals : Array[Double], name : String) -> SignalfilterellipticSeries {
  { vals, name, meta: 0 }
}

pub fn signal_filter_elliptic_series_len(s : SignalfilterellipticSeries) -> Int { s.vals.length() }

pub fn signal_filter_elliptic_series_sum(s : SignalfilterellipticSeries) -> Double { @_common.sum(s.vals) }

pub fn signal_filter_elliptic_series_mean(s : SignalfilterellipticSeries) -> Double { @_common.mean(s.vals) }

pub fn signal_filter_elliptic_series_min(s : SignalfilterellipticSeries) -> Double { @_common.min(s.vals) }

pub fn signal_filter_elliptic_series_max(s : SignalfilterellipticSeries) -> Double { @_common.max(s.vals) }

pub fn signal_filter_elliptic_series_range(s : SignalfilterellipticSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn signal_filter_elliptic_series_var(s : SignalfilterellipticSeries) -> Double { @_common.variance(s.vals) }

pub fn signal_filter_elliptic_series_std(s : SignalfilterellipticSeries) -> Double { @_common.std(s.vals) }

pub fn signal_filter_elliptic_series_median(s : SignalfilterellipticSeries) -> Double { @_common.median(s.vals) }

pub fn signal_filter_elliptic_series_scale(s : SignalfilterellipticSeries, f : Double) -> SignalfilterellipticSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn signal_filter_elliptic_series_add(a : SignalfilterellipticSeries, b : SignalfilterellipticSeries) -> SignalfilterellipticSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn signal_filter_elliptic_series_sub(a : SignalfilterellipticSeries, b : SignalfilterellipticSeries) -> SignalfilterellipticSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn signal_filter_elliptic_series_normalize(s : SignalfilterellipticSeries) -> SignalfilterellipticSeries {
  let mn = signal_filter_elliptic_series_min(s)
  let mx = signal_filter_elliptic_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn signal_filter_elliptic_series_cumsum(s : SignalfilterellipticSeries) -> SignalfilterellipticSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn signal_filter_elliptic_series_to_string(s : SignalfilterellipticSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignalfilterellipticMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_filter_elliptic_make_matrix(rows : Int, cols : Int, val : Double) -> SignalfilterellipticMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn signal_filter_elliptic_matrix_identity(n : Int) -> SignalfilterellipticMatrix {
  let m = signal_filter_elliptic_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn signal_filter_elliptic_matrix_get(m : SignalfilterellipticMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn signal_filter_elliptic_matrix_transpose(m : SignalfilterellipticMatrix) -> SignalfilterellipticMatrix {
  let result = signal_filter_elliptic_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn signal_filter_elliptic_matrix_add(a : SignalfilterellipticMatrix, b : SignalfilterellipticMatrix) -> SignalfilterellipticMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = signal_filter_elliptic_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn signal_filter_elliptic_matrix_scale(m : SignalfilterellipticMatrix, s : Double) -> SignalfilterellipticMatrix {
  let result = signal_filter_elliptic_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn signal_filter_elliptic_matrix_multiply(a : SignalfilterellipticMatrix, b : SignalfilterellipticMatrix) -> SignalfilterellipticMatrix {
  if a.cols != b.rows { return signal_filter_elliptic_make_matrix(a.rows, b.cols, 0.0) }
  let result = signal_filter_elliptic_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn signal_filter_elliptic_matrix_trace(m : SignalfilterellipticMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn signal_filter_elliptic_matrix_det(m : SignalfilterellipticMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn signal_filter_elliptic_matrix_norm(m : SignalfilterellipticMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn signal_filter_elliptic_matrix_to_string(m : SignalfilterellipticMatrix) -> String {
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

pub(all) struct SignalfilterellipticVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_filter_elliptic_make_vector(comps : Array[Double]) -> SignalfilterellipticVector {
  { comps, dim: comps.length() }
}

pub fn signal_filter_elliptic_vector_zero(dim : Int) -> SignalfilterellipticVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn signal_filter_elliptic_vector_add(a : SignalfilterellipticVector, b : SignalfilterellipticVector) -> SignalfilterellipticVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn signal_filter_elliptic_vector_sub(a : SignalfilterellipticVector, b : SignalfilterellipticVector) -> SignalfilterellipticVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn signal_filter_elliptic_vector_scale(v : SignalfilterellipticVector, s : Double) -> SignalfilterellipticVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn signal_filter_elliptic_vector_dot(a : SignalfilterellipticVector, b : SignalfilterellipticVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn signal_filter_elliptic_vector_norm(v : SignalfilterellipticVector) -> Double { @_common.sqrt(signal_filter_elliptic_vector_dot(v, v)) }

pub fn signal_filter_elliptic_vector_normalize(v : SignalfilterellipticVector) -> SignalfilterellipticVector {
  let n = signal_filter_elliptic_vector_norm(v)
  if n < 0.0000001 { v } else { signal_filter_elliptic_vector_scale(v, 1.0 / n) }
}

pub fn signal_filter_elliptic_vector_dist(a : SignalfilterellipticVector, b : SignalfilterellipticVector) -> Double {
  signal_filter_elliptic_vector_norm(signal_filter_elliptic_vector_sub(a, b))
}

pub fn signal_filter_elliptic_vector_to_string(v : SignalfilterellipticVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn signal_filter_elliptic_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn signal_filter_elliptic_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn signal_filter_elliptic_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn signal_filter_elliptic_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn signal_filter_elliptic_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn signal_filter_elliptic_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn signal_filter_elliptic_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn signal_filter_elliptic_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn signal_filter_elliptic_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn signal_filter_elliptic_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn signal_filter_elliptic_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn signal_filter_elliptic_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn signal_filter_elliptic_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn signal_filter_elliptic_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn signal_filter_elliptic_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn signal_filter_elliptic_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn signal_filter_elliptic_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn signal_filter_elliptic_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn signal_filter_elliptic_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn signal_filter_elliptic_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn signal_filter_elliptic_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn signal_filter_elliptic_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn signal_filter_elliptic_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn signal_filter_elliptic_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn signal_filter_elliptic_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn signal_filter_elliptic_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn signal_filter_elliptic_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn signal_filter_elliptic_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn signal_filter_elliptic_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SignalfilterellipticFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_elliptic_frame_make(size : Int) -> SignalfilterellipticFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_elliptic_frame_len(s : SignalfilterellipticFrame) -> Int { s.size }

pub fn signal_filter_elliptic_frame_get(s : SignalfilterellipticFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_elliptic_frame_set(s : SignalfilterellipticFrame, i : Int, v : Double) -> SignalfilterellipticFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_frame_sum(s : SignalfilterellipticFrame) -> Double { @_common.sum(s.data) }

pub fn signal_filter_elliptic_frame_mean(s : SignalfilterellipticFrame) -> Double { @_common.mean(s.data) }

pub fn signal_filter_elliptic_frame_scale(s : SignalfilterellipticFrame, f : Double) -> SignalfilterellipticFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_frame_add(a : SignalfilterellipticFrame, b : SignalfilterellipticFrame) -> SignalfilterellipticFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_elliptic_frame_copy(s : SignalfilterellipticFrame) -> SignalfilterellipticFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_frame_fill(s : SignalfilterellipticFrame, v : Double) -> SignalfilterellipticFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_frame_min(s : SignalfilterellipticFrame) -> Double { @_common.min(s.data) }

pub fn signal_filter_elliptic_frame_max(s : SignalfilterellipticFrame) -> Double { @_common.max(s.data) }

pub fn signal_filter_elliptic_frame_to_string(s : SignalfilterellipticFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterellipticTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_elliptic_table_make(size : Int) -> SignalfilterellipticTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_elliptic_table_len(s : SignalfilterellipticTable) -> Int { s.size }

pub fn signal_filter_elliptic_table_get(s : SignalfilterellipticTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_elliptic_table_set(s : SignalfilterellipticTable, i : Int, v : Double) -> SignalfilterellipticTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_table_sum(s : SignalfilterellipticTable) -> Double { @_common.sum(s.data) }

pub fn signal_filter_elliptic_table_mean(s : SignalfilterellipticTable) -> Double { @_common.mean(s.data) }

pub fn signal_filter_elliptic_table_scale(s : SignalfilterellipticTable, f : Double) -> SignalfilterellipticTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_table_add(a : SignalfilterellipticTable, b : SignalfilterellipticTable) -> SignalfilterellipticTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_elliptic_table_copy(s : SignalfilterellipticTable) -> SignalfilterellipticTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_table_fill(s : SignalfilterellipticTable, v : Double) -> SignalfilterellipticTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_table_min(s : SignalfilterellipticTable) -> Double { @_common.min(s.data) }

pub fn signal_filter_elliptic_table_max(s : SignalfilterellipticTable) -> Double { @_common.max(s.data) }

pub fn signal_filter_elliptic_table_to_string(s : SignalfilterellipticTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterellipticGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_elliptic_graphn_make(size : Int) -> SignalfilterellipticGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_elliptic_graphn_len(s : SignalfilterellipticGraphN) -> Int { s.size }

pub fn signal_filter_elliptic_graphn_get(s : SignalfilterellipticGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_elliptic_graphn_set(s : SignalfilterellipticGraphN, i : Int, v : Double) -> SignalfilterellipticGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_graphn_sum(s : SignalfilterellipticGraphN) -> Double { @_common.sum(s.data) }

pub fn signal_filter_elliptic_graphn_mean(s : SignalfilterellipticGraphN) -> Double { @_common.mean(s.data) }

pub fn signal_filter_elliptic_graphn_scale(s : SignalfilterellipticGraphN, f : Double) -> SignalfilterellipticGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_graphn_add(a : SignalfilterellipticGraphN, b : SignalfilterellipticGraphN) -> SignalfilterellipticGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_elliptic_graphn_copy(s : SignalfilterellipticGraphN) -> SignalfilterellipticGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_graphn_fill(s : SignalfilterellipticGraphN, v : Double) -> SignalfilterellipticGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_graphn_min(s : SignalfilterellipticGraphN) -> Double { @_common.min(s.data) }

pub fn signal_filter_elliptic_graphn_max(s : SignalfilterellipticGraphN) -> Double { @_common.max(s.data) }

pub fn signal_filter_elliptic_graphn_to_string(s : SignalfilterellipticGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterellipticNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_elliptic_node_make(size : Int) -> SignalfilterellipticNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_elliptic_node_len(s : SignalfilterellipticNode) -> Int { s.size }

pub fn signal_filter_elliptic_node_get(s : SignalfilterellipticNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_elliptic_node_set(s : SignalfilterellipticNode, i : Int, v : Double) -> SignalfilterellipticNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_node_sum(s : SignalfilterellipticNode) -> Double { @_common.sum(s.data) }

pub fn signal_filter_elliptic_node_mean(s : SignalfilterellipticNode) -> Double { @_common.mean(s.data) }

pub fn signal_filter_elliptic_node_scale(s : SignalfilterellipticNode, f : Double) -> SignalfilterellipticNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_node_add(a : SignalfilterellipticNode, b : SignalfilterellipticNode) -> SignalfilterellipticNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_elliptic_node_copy(s : SignalfilterellipticNode) -> SignalfilterellipticNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_node_fill(s : SignalfilterellipticNode, v : Double) -> SignalfilterellipticNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_node_min(s : SignalfilterellipticNode) -> Double { @_common.min(s.data) }

pub fn signal_filter_elliptic_node_max(s : SignalfilterellipticNode) -> Double { @_common.max(s.data) }

pub fn signal_filter_elliptic_node_to_string(s : SignalfilterellipticNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterellipticEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_elliptic_edge_make(size : Int) -> SignalfilterellipticEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_elliptic_edge_len(s : SignalfilterellipticEdge) -> Int { s.size }

pub fn signal_filter_elliptic_edge_get(s : SignalfilterellipticEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_elliptic_edge_set(s : SignalfilterellipticEdge, i : Int, v : Double) -> SignalfilterellipticEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_edge_sum(s : SignalfilterellipticEdge) -> Double { @_common.sum(s.data) }

pub fn signal_filter_elliptic_edge_mean(s : SignalfilterellipticEdge) -> Double { @_common.mean(s.data) }

pub fn signal_filter_elliptic_edge_scale(s : SignalfilterellipticEdge, f : Double) -> SignalfilterellipticEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_edge_add(a : SignalfilterellipticEdge, b : SignalfilterellipticEdge) -> SignalfilterellipticEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_elliptic_edge_copy(s : SignalfilterellipticEdge) -> SignalfilterellipticEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_edge_fill(s : SignalfilterellipticEdge, v : Double) -> SignalfilterellipticEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_edge_min(s : SignalfilterellipticEdge) -> Double { @_common.min(s.data) }

pub fn signal_filter_elliptic_edge_max(s : SignalfilterellipticEdge) -> Double { @_common.max(s.data) }

pub fn signal_filter_elliptic_edge_to_string(s : SignalfilterellipticEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterellipticPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_elliptic_path_make(size : Int) -> SignalfilterellipticPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_elliptic_path_len(s : SignalfilterellipticPath) -> Int { s.size }

pub fn signal_filter_elliptic_path_get(s : SignalfilterellipticPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_elliptic_path_set(s : SignalfilterellipticPath, i : Int, v : Double) -> SignalfilterellipticPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_path_sum(s : SignalfilterellipticPath) -> Double { @_common.sum(s.data) }

pub fn signal_filter_elliptic_path_mean(s : SignalfilterellipticPath) -> Double { @_common.mean(s.data) }

pub fn signal_filter_elliptic_path_scale(s : SignalfilterellipticPath, f : Double) -> SignalfilterellipticPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_path_add(a : SignalfilterellipticPath, b : SignalfilterellipticPath) -> SignalfilterellipticPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_elliptic_path_copy(s : SignalfilterellipticPath) -> SignalfilterellipticPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_path_fill(s : SignalfilterellipticPath, v : Double) -> SignalfilterellipticPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_path_min(s : SignalfilterellipticPath) -> Double { @_common.min(s.data) }

pub fn signal_filter_elliptic_path_max(s : SignalfilterellipticPath) -> Double { @_common.max(s.data) }

pub fn signal_filter_elliptic_path_to_string(s : SignalfilterellipticPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterellipticCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_elliptic_cluster_make(size : Int) -> SignalfilterellipticCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_elliptic_cluster_len(s : SignalfilterellipticCluster) -> Int { s.size }

pub fn signal_filter_elliptic_cluster_get(s : SignalfilterellipticCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_elliptic_cluster_set(s : SignalfilterellipticCluster, i : Int, v : Double) -> SignalfilterellipticCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_cluster_sum(s : SignalfilterellipticCluster) -> Double { @_common.sum(s.data) }

pub fn signal_filter_elliptic_cluster_mean(s : SignalfilterellipticCluster) -> Double { @_common.mean(s.data) }

pub fn signal_filter_elliptic_cluster_scale(s : SignalfilterellipticCluster, f : Double) -> SignalfilterellipticCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_cluster_add(a : SignalfilterellipticCluster, b : SignalfilterellipticCluster) -> SignalfilterellipticCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_elliptic_cluster_copy(s : SignalfilterellipticCluster) -> SignalfilterellipticCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_cluster_fill(s : SignalfilterellipticCluster, v : Double) -> SignalfilterellipticCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_cluster_min(s : SignalfilterellipticCluster) -> Double { @_common.min(s.data) }

pub fn signal_filter_elliptic_cluster_max(s : SignalfilterellipticCluster) -> Double { @_common.max(s.data) }

pub fn signal_filter_elliptic_cluster_to_string(s : SignalfilterellipticCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterellipticModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_elliptic_model_make(size : Int) -> SignalfilterellipticModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_elliptic_model_len(s : SignalfilterellipticModel) -> Int { s.size }

pub fn signal_filter_elliptic_model_get(s : SignalfilterellipticModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_elliptic_model_set(s : SignalfilterellipticModel, i : Int, v : Double) -> SignalfilterellipticModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_model_sum(s : SignalfilterellipticModel) -> Double { @_common.sum(s.data) }

pub fn signal_filter_elliptic_model_mean(s : SignalfilterellipticModel) -> Double { @_common.mean(s.data) }

pub fn signal_filter_elliptic_model_scale(s : SignalfilterellipticModel, f : Double) -> SignalfilterellipticModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_model_add(a : SignalfilterellipticModel, b : SignalfilterellipticModel) -> SignalfilterellipticModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_elliptic_model_copy(s : SignalfilterellipticModel) -> SignalfilterellipticModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_model_fill(s : SignalfilterellipticModel, v : Double) -> SignalfilterellipticModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_model_min(s : SignalfilterellipticModel) -> Double { @_common.min(s.data) }

pub fn signal_filter_elliptic_model_max(s : SignalfilterellipticModel) -> Double { @_common.max(s.data) }

pub fn signal_filter_elliptic_model_to_string(s : SignalfilterellipticModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterellipticLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_elliptic_layer_make(size : Int) -> SignalfilterellipticLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_elliptic_layer_len(s : SignalfilterellipticLayer) -> Int { s.size }

pub fn signal_filter_elliptic_layer_get(s : SignalfilterellipticLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_elliptic_layer_set(s : SignalfilterellipticLayer, i : Int, v : Double) -> SignalfilterellipticLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_layer_sum(s : SignalfilterellipticLayer) -> Double { @_common.sum(s.data) }

pub fn signal_filter_elliptic_layer_mean(s : SignalfilterellipticLayer) -> Double { @_common.mean(s.data) }

pub fn signal_filter_elliptic_layer_scale(s : SignalfilterellipticLayer, f : Double) -> SignalfilterellipticLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_layer_add(a : SignalfilterellipticLayer, b : SignalfilterellipticLayer) -> SignalfilterellipticLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_elliptic_layer_copy(s : SignalfilterellipticLayer) -> SignalfilterellipticLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_layer_fill(s : SignalfilterellipticLayer, v : Double) -> SignalfilterellipticLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_layer_min(s : SignalfilterellipticLayer) -> Double { @_common.min(s.data) }

pub fn signal_filter_elliptic_layer_max(s : SignalfilterellipticLayer) -> Double { @_common.max(s.data) }

pub fn signal_filter_elliptic_layer_to_string(s : SignalfilterellipticLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterellipticBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_elliptic_buffer_make(size : Int) -> SignalfilterellipticBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_elliptic_buffer_len(s : SignalfilterellipticBuffer) -> Int { s.size }

pub fn signal_filter_elliptic_buffer_get(s : SignalfilterellipticBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_elliptic_buffer_set(s : SignalfilterellipticBuffer, i : Int, v : Double) -> SignalfilterellipticBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_buffer_sum(s : SignalfilterellipticBuffer) -> Double { @_common.sum(s.data) }

pub fn signal_filter_elliptic_buffer_mean(s : SignalfilterellipticBuffer) -> Double { @_common.mean(s.data) }

pub fn signal_filter_elliptic_buffer_scale(s : SignalfilterellipticBuffer, f : Double) -> SignalfilterellipticBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_buffer_add(a : SignalfilterellipticBuffer, b : SignalfilterellipticBuffer) -> SignalfilterellipticBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_elliptic_buffer_copy(s : SignalfilterellipticBuffer) -> SignalfilterellipticBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_buffer_fill(s : SignalfilterellipticBuffer, v : Double) -> SignalfilterellipticBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_buffer_min(s : SignalfilterellipticBuffer) -> Double { @_common.min(s.data) }

pub fn signal_filter_elliptic_buffer_max(s : SignalfilterellipticBuffer) -> Double { @_common.max(s.data) }

pub fn signal_filter_elliptic_buffer_to_string(s : SignalfilterellipticBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterellipticCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_elliptic_cursor_make(size : Int) -> SignalfilterellipticCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_elliptic_cursor_len(s : SignalfilterellipticCursor) -> Int { s.size }

pub fn signal_filter_elliptic_cursor_get(s : SignalfilterellipticCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_elliptic_cursor_set(s : SignalfilterellipticCursor, i : Int, v : Double) -> SignalfilterellipticCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_cursor_sum(s : SignalfilterellipticCursor) -> Double { @_common.sum(s.data) }

pub fn signal_filter_elliptic_cursor_mean(s : SignalfilterellipticCursor) -> Double { @_common.mean(s.data) }

pub fn signal_filter_elliptic_cursor_scale(s : SignalfilterellipticCursor, f : Double) -> SignalfilterellipticCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_cursor_add(a : SignalfilterellipticCursor, b : SignalfilterellipticCursor) -> SignalfilterellipticCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_elliptic_cursor_copy(s : SignalfilterellipticCursor) -> SignalfilterellipticCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_cursor_fill(s : SignalfilterellipticCursor, v : Double) -> SignalfilterellipticCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_cursor_min(s : SignalfilterellipticCursor) -> Double { @_common.min(s.data) }

pub fn signal_filter_elliptic_cursor_max(s : SignalfilterellipticCursor) -> Double { @_common.max(s.data) }

pub fn signal_filter_elliptic_cursor_to_string(s : SignalfilterellipticCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterellipticView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_elliptic_view_make(size : Int) -> SignalfilterellipticView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_elliptic_view_len(s : SignalfilterellipticView) -> Int { s.size }

pub fn signal_filter_elliptic_view_get(s : SignalfilterellipticView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_elliptic_view_set(s : SignalfilterellipticView, i : Int, v : Double) -> SignalfilterellipticView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_view_sum(s : SignalfilterellipticView) -> Double { @_common.sum(s.data) }

pub fn signal_filter_elliptic_view_mean(s : SignalfilterellipticView) -> Double { @_common.mean(s.data) }

pub fn signal_filter_elliptic_view_scale(s : SignalfilterellipticView, f : Double) -> SignalfilterellipticView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_view_add(a : SignalfilterellipticView, b : SignalfilterellipticView) -> SignalfilterellipticView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_elliptic_view_copy(s : SignalfilterellipticView) -> SignalfilterellipticView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_view_fill(s : SignalfilterellipticView, v : Double) -> SignalfilterellipticView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_view_min(s : SignalfilterellipticView) -> Double { @_common.min(s.data) }

pub fn signal_filter_elliptic_view_max(s : SignalfilterellipticView) -> Double { @_common.max(s.data) }

pub fn signal_filter_elliptic_view_to_string(s : SignalfilterellipticView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterellipticRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_elliptic_range_make(size : Int) -> SignalfilterellipticRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_elliptic_range_len(s : SignalfilterellipticRange) -> Int { s.size }

pub fn signal_filter_elliptic_range_get(s : SignalfilterellipticRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_elliptic_range_set(s : SignalfilterellipticRange, i : Int, v : Double) -> SignalfilterellipticRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_range_sum(s : SignalfilterellipticRange) -> Double { @_common.sum(s.data) }

pub fn signal_filter_elliptic_range_mean(s : SignalfilterellipticRange) -> Double { @_common.mean(s.data) }

pub fn signal_filter_elliptic_range_scale(s : SignalfilterellipticRange, f : Double) -> SignalfilterellipticRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_range_add(a : SignalfilterellipticRange, b : SignalfilterellipticRange) -> SignalfilterellipticRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_elliptic_range_copy(s : SignalfilterellipticRange) -> SignalfilterellipticRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_range_fill(s : SignalfilterellipticRange, v : Double) -> SignalfilterellipticRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_range_min(s : SignalfilterellipticRange) -> Double { @_common.min(s.data) }

pub fn signal_filter_elliptic_range_max(s : SignalfilterellipticRange) -> Double { @_common.max(s.data) }

pub fn signal_filter_elliptic_range_to_string(s : SignalfilterellipticRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterellipticSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_elliptic_slice_make(size : Int) -> SignalfilterellipticSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_elliptic_slice_len(s : SignalfilterellipticSlice) -> Int { s.size }

pub fn signal_filter_elliptic_slice_get(s : SignalfilterellipticSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_elliptic_slice_set(s : SignalfilterellipticSlice, i : Int, v : Double) -> SignalfilterellipticSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_slice_sum(s : SignalfilterellipticSlice) -> Double { @_common.sum(s.data) }

pub fn signal_filter_elliptic_slice_mean(s : SignalfilterellipticSlice) -> Double { @_common.mean(s.data) }

pub fn signal_filter_elliptic_slice_scale(s : SignalfilterellipticSlice, f : Double) -> SignalfilterellipticSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_slice_add(a : SignalfilterellipticSlice, b : SignalfilterellipticSlice) -> SignalfilterellipticSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_elliptic_slice_copy(s : SignalfilterellipticSlice) -> SignalfilterellipticSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_slice_fill(s : SignalfilterellipticSlice, v : Double) -> SignalfilterellipticSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_elliptic_slice_min(s : SignalfilterellipticSlice) -> Double { @_common.min(s.data) }

pub fn signal_filter_elliptic_slice_max(s : SignalfilterellipticSlice) -> Double { @_common.max(s.data) }

pub fn signal_filter_elliptic_slice_to_string(s : SignalfilterellipticSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


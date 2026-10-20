///===
/// extcore/opt_grad_amsgrad

pub(all) struct OptgradamsgradPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn opt_grad_amsgrad_make_point(x : Double, y : Double) -> OptgradamsgradPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn opt_grad_amsgrad_make_point3(x : Double, y : Double, z : Double) -> OptgradamsgradPoint {
  { x, y, z, label: 0 }
}

pub fn opt_grad_amsgrad_point_x(pt : OptgradamsgradPoint) -> Double { pt.x }

pub fn opt_grad_amsgrad_point_y(pt : OptgradamsgradPoint) -> Double { pt.y }

pub fn opt_grad_amsgrad_point_z(pt : OptgradamsgradPoint) -> Double { pt.z }

pub fn opt_grad_amsgrad_point_label(pt : OptgradamsgradPoint) -> Int { pt.label }

pub fn opt_grad_amsgrad_point_dist(a : OptgradamsgradPoint, b : OptgradamsgradPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn opt_grad_amsgrad_point_add(a : OptgradamsgradPoint, b : OptgradamsgradPoint) -> OptgradamsgradPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn opt_grad_amsgrad_point_sub(a : OptgradamsgradPoint, b : OptgradamsgradPoint) -> OptgradamsgradPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn opt_grad_amsgrad_point_scale(pt : OptgradamsgradPoint, s : Double) -> OptgradamsgradPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn opt_grad_amsgrad_point_dot(a : OptgradamsgradPoint, b : OptgradamsgradPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn opt_grad_amsgrad_point_cross(a : OptgradamsgradPoint, b : OptgradamsgradPoint) -> OptgradamsgradPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn opt_grad_amsgrad_point_norm(pt : OptgradamsgradPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn opt_grad_amsgrad_point_normalize(pt : OptgradamsgradPoint) -> OptgradamsgradPoint {
  let n = opt_grad_amsgrad_point_norm(pt)
  if n < 0.0000001 { pt } else { opt_grad_amsgrad_point_scale(pt, 1.0 / n) }
}

pub fn opt_grad_amsgrad_point_negate(pt : OptgradamsgradPoint) -> OptgradamsgradPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn opt_grad_amsgrad_point_mid(a : OptgradamsgradPoint, b : OptgradamsgradPoint) -> OptgradamsgradPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn opt_grad_amsgrad_point_lerp(a : OptgradamsgradPoint, b : OptgradamsgradPoint, t : Double) -> OptgradamsgradPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn opt_grad_amsgrad_point_to_string(pt : OptgradamsgradPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct OptgradamsgradSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn opt_grad_amsgrad_make_series(vals : Array[Double], name : String) -> OptgradamsgradSeries {
  { vals, name, meta: 0 }
}

pub fn opt_grad_amsgrad_series_len(s : OptgradamsgradSeries) -> Int { s.vals.length() }

pub fn opt_grad_amsgrad_series_sum(s : OptgradamsgradSeries) -> Double { @_common.sum(s.vals) }

pub fn opt_grad_amsgrad_series_mean(s : OptgradamsgradSeries) -> Double { @_common.mean(s.vals) }

pub fn opt_grad_amsgrad_series_min(s : OptgradamsgradSeries) -> Double { @_common.min(s.vals) }

pub fn opt_grad_amsgrad_series_max(s : OptgradamsgradSeries) -> Double { @_common.max(s.vals) }

pub fn opt_grad_amsgrad_series_range(s : OptgradamsgradSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn opt_grad_amsgrad_series_var(s : OptgradamsgradSeries) -> Double { @_common.variance(s.vals) }

pub fn opt_grad_amsgrad_series_std(s : OptgradamsgradSeries) -> Double { @_common.std(s.vals) }

pub fn opt_grad_amsgrad_series_median(s : OptgradamsgradSeries) -> Double { @_common.median(s.vals) }

pub fn opt_grad_amsgrad_series_scale(s : OptgradamsgradSeries, f : Double) -> OptgradamsgradSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn opt_grad_amsgrad_series_add(a : OptgradamsgradSeries, b : OptgradamsgradSeries) -> OptgradamsgradSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn opt_grad_amsgrad_series_sub(a : OptgradamsgradSeries, b : OptgradamsgradSeries) -> OptgradamsgradSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn opt_grad_amsgrad_series_normalize(s : OptgradamsgradSeries) -> OptgradamsgradSeries {
  let mn = opt_grad_amsgrad_series_min(s)
  let mx = opt_grad_amsgrad_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn opt_grad_amsgrad_series_cumsum(s : OptgradamsgradSeries) -> OptgradamsgradSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn opt_grad_amsgrad_series_to_string(s : OptgradamsgradSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct OptgradamsgradMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn opt_grad_amsgrad_make_matrix(rows : Int, cols : Int, val : Double) -> OptgradamsgradMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn opt_grad_amsgrad_matrix_identity(n : Int) -> OptgradamsgradMatrix {
  let m = opt_grad_amsgrad_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn opt_grad_amsgrad_matrix_get(m : OptgradamsgradMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn opt_grad_amsgrad_matrix_transpose(m : OptgradamsgradMatrix) -> OptgradamsgradMatrix {
  let result = opt_grad_amsgrad_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn opt_grad_amsgrad_matrix_add(a : OptgradamsgradMatrix, b : OptgradamsgradMatrix) -> OptgradamsgradMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = opt_grad_amsgrad_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn opt_grad_amsgrad_matrix_scale(m : OptgradamsgradMatrix, s : Double) -> OptgradamsgradMatrix {
  let result = opt_grad_amsgrad_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn opt_grad_amsgrad_matrix_multiply(a : OptgradamsgradMatrix, b : OptgradamsgradMatrix) -> OptgradamsgradMatrix {
  if a.cols != b.rows { return opt_grad_amsgrad_make_matrix(a.rows, b.cols, 0.0) }
  let result = opt_grad_amsgrad_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn opt_grad_amsgrad_matrix_trace(m : OptgradamsgradMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn opt_grad_amsgrad_matrix_det(m : OptgradamsgradMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn opt_grad_amsgrad_matrix_norm(m : OptgradamsgradMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn opt_grad_amsgrad_matrix_to_string(m : OptgradamsgradMatrix) -> String {
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

pub(all) struct OptgradamsgradVector {
  comps : Array[Double]
  dim : Int
}

pub fn opt_grad_amsgrad_make_vector(comps : Array[Double]) -> OptgradamsgradVector {
  { comps, dim: comps.length() }
}

pub fn opt_grad_amsgrad_vector_zero(dim : Int) -> OptgradamsgradVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn opt_grad_amsgrad_vector_add(a : OptgradamsgradVector, b : OptgradamsgradVector) -> OptgradamsgradVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn opt_grad_amsgrad_vector_sub(a : OptgradamsgradVector, b : OptgradamsgradVector) -> OptgradamsgradVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn opt_grad_amsgrad_vector_scale(v : OptgradamsgradVector, s : Double) -> OptgradamsgradVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn opt_grad_amsgrad_vector_dot(a : OptgradamsgradVector, b : OptgradamsgradVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn opt_grad_amsgrad_vector_norm(v : OptgradamsgradVector) -> Double { @_common.sqrt(opt_grad_amsgrad_vector_dot(v, v)) }

pub fn opt_grad_amsgrad_vector_normalize(v : OptgradamsgradVector) -> OptgradamsgradVector {
  let n = opt_grad_amsgrad_vector_norm(v)
  if n < 0.0000001 { v } else { opt_grad_amsgrad_vector_scale(v, 1.0 / n) }
}

pub fn opt_grad_amsgrad_vector_dist(a : OptgradamsgradVector, b : OptgradamsgradVector) -> Double {
  opt_grad_amsgrad_vector_norm(opt_grad_amsgrad_vector_sub(a, b))
}

pub fn opt_grad_amsgrad_vector_to_string(v : OptgradamsgradVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn opt_grad_amsgrad_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn opt_grad_amsgrad_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn opt_grad_amsgrad_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn opt_grad_amsgrad_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn opt_grad_amsgrad_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn opt_grad_amsgrad_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn opt_grad_amsgrad_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn opt_grad_amsgrad_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn opt_grad_amsgrad_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn opt_grad_amsgrad_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn opt_grad_amsgrad_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn opt_grad_amsgrad_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn opt_grad_amsgrad_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn opt_grad_amsgrad_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn opt_grad_amsgrad_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn opt_grad_amsgrad_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn opt_grad_amsgrad_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn opt_grad_amsgrad_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn opt_grad_amsgrad_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn opt_grad_amsgrad_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn opt_grad_amsgrad_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn opt_grad_amsgrad_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn opt_grad_amsgrad_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn opt_grad_amsgrad_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn opt_grad_amsgrad_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn opt_grad_amsgrad_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn opt_grad_amsgrad_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn opt_grad_amsgrad_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn opt_grad_amsgrad_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct OptgradamsgradFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_amsgrad_frame_make(size : Int) -> OptgradamsgradFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_amsgrad_frame_len(s : OptgradamsgradFrame) -> Int { s.size }

pub fn opt_grad_amsgrad_frame_get(s : OptgradamsgradFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_amsgrad_frame_set(s : OptgradamsgradFrame, i : Int, v : Double) -> OptgradamsgradFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_frame_sum(s : OptgradamsgradFrame) -> Double { @_common.sum(s.data) }

pub fn opt_grad_amsgrad_frame_mean(s : OptgradamsgradFrame) -> Double { @_common.mean(s.data) }

pub fn opt_grad_amsgrad_frame_scale(s : OptgradamsgradFrame, f : Double) -> OptgradamsgradFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_frame_add(a : OptgradamsgradFrame, b : OptgradamsgradFrame) -> OptgradamsgradFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_amsgrad_frame_copy(s : OptgradamsgradFrame) -> OptgradamsgradFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_frame_fill(s : OptgradamsgradFrame, v : Double) -> OptgradamsgradFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_frame_min(s : OptgradamsgradFrame) -> Double { @_common.min(s.data) }

pub fn opt_grad_amsgrad_frame_max(s : OptgradamsgradFrame) -> Double { @_common.max(s.data) }

pub fn opt_grad_amsgrad_frame_to_string(s : OptgradamsgradFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradamsgradTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_amsgrad_table_make(size : Int) -> OptgradamsgradTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_amsgrad_table_len(s : OptgradamsgradTable) -> Int { s.size }

pub fn opt_grad_amsgrad_table_get(s : OptgradamsgradTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_amsgrad_table_set(s : OptgradamsgradTable, i : Int, v : Double) -> OptgradamsgradTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_table_sum(s : OptgradamsgradTable) -> Double { @_common.sum(s.data) }

pub fn opt_grad_amsgrad_table_mean(s : OptgradamsgradTable) -> Double { @_common.mean(s.data) }

pub fn opt_grad_amsgrad_table_scale(s : OptgradamsgradTable, f : Double) -> OptgradamsgradTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_table_add(a : OptgradamsgradTable, b : OptgradamsgradTable) -> OptgradamsgradTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_amsgrad_table_copy(s : OptgradamsgradTable) -> OptgradamsgradTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_table_fill(s : OptgradamsgradTable, v : Double) -> OptgradamsgradTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_table_min(s : OptgradamsgradTable) -> Double { @_common.min(s.data) }

pub fn opt_grad_amsgrad_table_max(s : OptgradamsgradTable) -> Double { @_common.max(s.data) }

pub fn opt_grad_amsgrad_table_to_string(s : OptgradamsgradTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradamsgradGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_amsgrad_graphn_make(size : Int) -> OptgradamsgradGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_amsgrad_graphn_len(s : OptgradamsgradGraphN) -> Int { s.size }

pub fn opt_grad_amsgrad_graphn_get(s : OptgradamsgradGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_amsgrad_graphn_set(s : OptgradamsgradGraphN, i : Int, v : Double) -> OptgradamsgradGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_graphn_sum(s : OptgradamsgradGraphN) -> Double { @_common.sum(s.data) }

pub fn opt_grad_amsgrad_graphn_mean(s : OptgradamsgradGraphN) -> Double { @_common.mean(s.data) }

pub fn opt_grad_amsgrad_graphn_scale(s : OptgradamsgradGraphN, f : Double) -> OptgradamsgradGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_graphn_add(a : OptgradamsgradGraphN, b : OptgradamsgradGraphN) -> OptgradamsgradGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_amsgrad_graphn_copy(s : OptgradamsgradGraphN) -> OptgradamsgradGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_graphn_fill(s : OptgradamsgradGraphN, v : Double) -> OptgradamsgradGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_graphn_min(s : OptgradamsgradGraphN) -> Double { @_common.min(s.data) }

pub fn opt_grad_amsgrad_graphn_max(s : OptgradamsgradGraphN) -> Double { @_common.max(s.data) }

pub fn opt_grad_amsgrad_graphn_to_string(s : OptgradamsgradGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradamsgradNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_amsgrad_node_make(size : Int) -> OptgradamsgradNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_amsgrad_node_len(s : OptgradamsgradNode) -> Int { s.size }

pub fn opt_grad_amsgrad_node_get(s : OptgradamsgradNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_amsgrad_node_set(s : OptgradamsgradNode, i : Int, v : Double) -> OptgradamsgradNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_node_sum(s : OptgradamsgradNode) -> Double { @_common.sum(s.data) }

pub fn opt_grad_amsgrad_node_mean(s : OptgradamsgradNode) -> Double { @_common.mean(s.data) }

pub fn opt_grad_amsgrad_node_scale(s : OptgradamsgradNode, f : Double) -> OptgradamsgradNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_node_add(a : OptgradamsgradNode, b : OptgradamsgradNode) -> OptgradamsgradNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_amsgrad_node_copy(s : OptgradamsgradNode) -> OptgradamsgradNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_node_fill(s : OptgradamsgradNode, v : Double) -> OptgradamsgradNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_node_min(s : OptgradamsgradNode) -> Double { @_common.min(s.data) }

pub fn opt_grad_amsgrad_node_max(s : OptgradamsgradNode) -> Double { @_common.max(s.data) }

pub fn opt_grad_amsgrad_node_to_string(s : OptgradamsgradNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradamsgradEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_amsgrad_edge_make(size : Int) -> OptgradamsgradEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_amsgrad_edge_len(s : OptgradamsgradEdge) -> Int { s.size }

pub fn opt_grad_amsgrad_edge_get(s : OptgradamsgradEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_amsgrad_edge_set(s : OptgradamsgradEdge, i : Int, v : Double) -> OptgradamsgradEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_edge_sum(s : OptgradamsgradEdge) -> Double { @_common.sum(s.data) }

pub fn opt_grad_amsgrad_edge_mean(s : OptgradamsgradEdge) -> Double { @_common.mean(s.data) }

pub fn opt_grad_amsgrad_edge_scale(s : OptgradamsgradEdge, f : Double) -> OptgradamsgradEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_edge_add(a : OptgradamsgradEdge, b : OptgradamsgradEdge) -> OptgradamsgradEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_amsgrad_edge_copy(s : OptgradamsgradEdge) -> OptgradamsgradEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_edge_fill(s : OptgradamsgradEdge, v : Double) -> OptgradamsgradEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_edge_min(s : OptgradamsgradEdge) -> Double { @_common.min(s.data) }

pub fn opt_grad_amsgrad_edge_max(s : OptgradamsgradEdge) -> Double { @_common.max(s.data) }

pub fn opt_grad_amsgrad_edge_to_string(s : OptgradamsgradEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradamsgradPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_amsgrad_path_make(size : Int) -> OptgradamsgradPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_amsgrad_path_len(s : OptgradamsgradPath) -> Int { s.size }

pub fn opt_grad_amsgrad_path_get(s : OptgradamsgradPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_amsgrad_path_set(s : OptgradamsgradPath, i : Int, v : Double) -> OptgradamsgradPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_path_sum(s : OptgradamsgradPath) -> Double { @_common.sum(s.data) }

pub fn opt_grad_amsgrad_path_mean(s : OptgradamsgradPath) -> Double { @_common.mean(s.data) }

pub fn opt_grad_amsgrad_path_scale(s : OptgradamsgradPath, f : Double) -> OptgradamsgradPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_path_add(a : OptgradamsgradPath, b : OptgradamsgradPath) -> OptgradamsgradPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_amsgrad_path_copy(s : OptgradamsgradPath) -> OptgradamsgradPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_path_fill(s : OptgradamsgradPath, v : Double) -> OptgradamsgradPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_path_min(s : OptgradamsgradPath) -> Double { @_common.min(s.data) }

pub fn opt_grad_amsgrad_path_max(s : OptgradamsgradPath) -> Double { @_common.max(s.data) }

pub fn opt_grad_amsgrad_path_to_string(s : OptgradamsgradPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradamsgradCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_amsgrad_cluster_make(size : Int) -> OptgradamsgradCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_amsgrad_cluster_len(s : OptgradamsgradCluster) -> Int { s.size }

pub fn opt_grad_amsgrad_cluster_get(s : OptgradamsgradCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_amsgrad_cluster_set(s : OptgradamsgradCluster, i : Int, v : Double) -> OptgradamsgradCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_cluster_sum(s : OptgradamsgradCluster) -> Double { @_common.sum(s.data) }

pub fn opt_grad_amsgrad_cluster_mean(s : OptgradamsgradCluster) -> Double { @_common.mean(s.data) }

pub fn opt_grad_amsgrad_cluster_scale(s : OptgradamsgradCluster, f : Double) -> OptgradamsgradCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_cluster_add(a : OptgradamsgradCluster, b : OptgradamsgradCluster) -> OptgradamsgradCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_amsgrad_cluster_copy(s : OptgradamsgradCluster) -> OptgradamsgradCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_cluster_fill(s : OptgradamsgradCluster, v : Double) -> OptgradamsgradCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_cluster_min(s : OptgradamsgradCluster) -> Double { @_common.min(s.data) }

pub fn opt_grad_amsgrad_cluster_max(s : OptgradamsgradCluster) -> Double { @_common.max(s.data) }

pub fn opt_grad_amsgrad_cluster_to_string(s : OptgradamsgradCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradamsgradModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_amsgrad_model_make(size : Int) -> OptgradamsgradModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_amsgrad_model_len(s : OptgradamsgradModel) -> Int { s.size }

pub fn opt_grad_amsgrad_model_get(s : OptgradamsgradModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_amsgrad_model_set(s : OptgradamsgradModel, i : Int, v : Double) -> OptgradamsgradModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_model_sum(s : OptgradamsgradModel) -> Double { @_common.sum(s.data) }

pub fn opt_grad_amsgrad_model_mean(s : OptgradamsgradModel) -> Double { @_common.mean(s.data) }

pub fn opt_grad_amsgrad_model_scale(s : OptgradamsgradModel, f : Double) -> OptgradamsgradModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_model_add(a : OptgradamsgradModel, b : OptgradamsgradModel) -> OptgradamsgradModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_amsgrad_model_copy(s : OptgradamsgradModel) -> OptgradamsgradModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_model_fill(s : OptgradamsgradModel, v : Double) -> OptgradamsgradModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_model_min(s : OptgradamsgradModel) -> Double { @_common.min(s.data) }

pub fn opt_grad_amsgrad_model_max(s : OptgradamsgradModel) -> Double { @_common.max(s.data) }

pub fn opt_grad_amsgrad_model_to_string(s : OptgradamsgradModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradamsgradLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_amsgrad_layer_make(size : Int) -> OptgradamsgradLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_amsgrad_layer_len(s : OptgradamsgradLayer) -> Int { s.size }

pub fn opt_grad_amsgrad_layer_get(s : OptgradamsgradLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_amsgrad_layer_set(s : OptgradamsgradLayer, i : Int, v : Double) -> OptgradamsgradLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_layer_sum(s : OptgradamsgradLayer) -> Double { @_common.sum(s.data) }

pub fn opt_grad_amsgrad_layer_mean(s : OptgradamsgradLayer) -> Double { @_common.mean(s.data) }

pub fn opt_grad_amsgrad_layer_scale(s : OptgradamsgradLayer, f : Double) -> OptgradamsgradLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_layer_add(a : OptgradamsgradLayer, b : OptgradamsgradLayer) -> OptgradamsgradLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_amsgrad_layer_copy(s : OptgradamsgradLayer) -> OptgradamsgradLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_layer_fill(s : OptgradamsgradLayer, v : Double) -> OptgradamsgradLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_layer_min(s : OptgradamsgradLayer) -> Double { @_common.min(s.data) }

pub fn opt_grad_amsgrad_layer_max(s : OptgradamsgradLayer) -> Double { @_common.max(s.data) }

pub fn opt_grad_amsgrad_layer_to_string(s : OptgradamsgradLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradamsgradBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_amsgrad_buffer_make(size : Int) -> OptgradamsgradBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_amsgrad_buffer_len(s : OptgradamsgradBuffer) -> Int { s.size }

pub fn opt_grad_amsgrad_buffer_get(s : OptgradamsgradBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_amsgrad_buffer_set(s : OptgradamsgradBuffer, i : Int, v : Double) -> OptgradamsgradBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_buffer_sum(s : OptgradamsgradBuffer) -> Double { @_common.sum(s.data) }

pub fn opt_grad_amsgrad_buffer_mean(s : OptgradamsgradBuffer) -> Double { @_common.mean(s.data) }

pub fn opt_grad_amsgrad_buffer_scale(s : OptgradamsgradBuffer, f : Double) -> OptgradamsgradBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_buffer_add(a : OptgradamsgradBuffer, b : OptgradamsgradBuffer) -> OptgradamsgradBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_amsgrad_buffer_copy(s : OptgradamsgradBuffer) -> OptgradamsgradBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_buffer_fill(s : OptgradamsgradBuffer, v : Double) -> OptgradamsgradBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_buffer_min(s : OptgradamsgradBuffer) -> Double { @_common.min(s.data) }

pub fn opt_grad_amsgrad_buffer_max(s : OptgradamsgradBuffer) -> Double { @_common.max(s.data) }

pub fn opt_grad_amsgrad_buffer_to_string(s : OptgradamsgradBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradamsgradCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_amsgrad_cursor_make(size : Int) -> OptgradamsgradCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_amsgrad_cursor_len(s : OptgradamsgradCursor) -> Int { s.size }

pub fn opt_grad_amsgrad_cursor_get(s : OptgradamsgradCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_amsgrad_cursor_set(s : OptgradamsgradCursor, i : Int, v : Double) -> OptgradamsgradCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_cursor_sum(s : OptgradamsgradCursor) -> Double { @_common.sum(s.data) }

pub fn opt_grad_amsgrad_cursor_mean(s : OptgradamsgradCursor) -> Double { @_common.mean(s.data) }

pub fn opt_grad_amsgrad_cursor_scale(s : OptgradamsgradCursor, f : Double) -> OptgradamsgradCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_cursor_add(a : OptgradamsgradCursor, b : OptgradamsgradCursor) -> OptgradamsgradCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_amsgrad_cursor_copy(s : OptgradamsgradCursor) -> OptgradamsgradCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_cursor_fill(s : OptgradamsgradCursor, v : Double) -> OptgradamsgradCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_cursor_min(s : OptgradamsgradCursor) -> Double { @_common.min(s.data) }

pub fn opt_grad_amsgrad_cursor_max(s : OptgradamsgradCursor) -> Double { @_common.max(s.data) }

pub fn opt_grad_amsgrad_cursor_to_string(s : OptgradamsgradCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradamsgradView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_amsgrad_view_make(size : Int) -> OptgradamsgradView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_amsgrad_view_len(s : OptgradamsgradView) -> Int { s.size }

pub fn opt_grad_amsgrad_view_get(s : OptgradamsgradView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_amsgrad_view_set(s : OptgradamsgradView, i : Int, v : Double) -> OptgradamsgradView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_view_sum(s : OptgradamsgradView) -> Double { @_common.sum(s.data) }

pub fn opt_grad_amsgrad_view_mean(s : OptgradamsgradView) -> Double { @_common.mean(s.data) }

pub fn opt_grad_amsgrad_view_scale(s : OptgradamsgradView, f : Double) -> OptgradamsgradView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_view_add(a : OptgradamsgradView, b : OptgradamsgradView) -> OptgradamsgradView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_amsgrad_view_copy(s : OptgradamsgradView) -> OptgradamsgradView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_view_fill(s : OptgradamsgradView, v : Double) -> OptgradamsgradView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_view_min(s : OptgradamsgradView) -> Double { @_common.min(s.data) }

pub fn opt_grad_amsgrad_view_max(s : OptgradamsgradView) -> Double { @_common.max(s.data) }

pub fn opt_grad_amsgrad_view_to_string(s : OptgradamsgradView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradamsgradRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_amsgrad_range_make(size : Int) -> OptgradamsgradRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_amsgrad_range_len(s : OptgradamsgradRange) -> Int { s.size }

pub fn opt_grad_amsgrad_range_get(s : OptgradamsgradRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_amsgrad_range_set(s : OptgradamsgradRange, i : Int, v : Double) -> OptgradamsgradRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_range_sum(s : OptgradamsgradRange) -> Double { @_common.sum(s.data) }

pub fn opt_grad_amsgrad_range_mean(s : OptgradamsgradRange) -> Double { @_common.mean(s.data) }

pub fn opt_grad_amsgrad_range_scale(s : OptgradamsgradRange, f : Double) -> OptgradamsgradRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_range_add(a : OptgradamsgradRange, b : OptgradamsgradRange) -> OptgradamsgradRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_amsgrad_range_copy(s : OptgradamsgradRange) -> OptgradamsgradRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_range_fill(s : OptgradamsgradRange, v : Double) -> OptgradamsgradRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_range_min(s : OptgradamsgradRange) -> Double { @_common.min(s.data) }

pub fn opt_grad_amsgrad_range_max(s : OptgradamsgradRange) -> Double { @_common.max(s.data) }

pub fn opt_grad_amsgrad_range_to_string(s : OptgradamsgradRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradamsgradSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_amsgrad_slice_make(size : Int) -> OptgradamsgradSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_amsgrad_slice_len(s : OptgradamsgradSlice) -> Int { s.size }

pub fn opt_grad_amsgrad_slice_get(s : OptgradamsgradSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_amsgrad_slice_set(s : OptgradamsgradSlice, i : Int, v : Double) -> OptgradamsgradSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_slice_sum(s : OptgradamsgradSlice) -> Double { @_common.sum(s.data) }

pub fn opt_grad_amsgrad_slice_mean(s : OptgradamsgradSlice) -> Double { @_common.mean(s.data) }

pub fn opt_grad_amsgrad_slice_scale(s : OptgradamsgradSlice, f : Double) -> OptgradamsgradSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_slice_add(a : OptgradamsgradSlice, b : OptgradamsgradSlice) -> OptgradamsgradSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_amsgrad_slice_copy(s : OptgradamsgradSlice) -> OptgradamsgradSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_slice_fill(s : OptgradamsgradSlice, v : Double) -> OptgradamsgradSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_amsgrad_slice_min(s : OptgradamsgradSlice) -> Double { @_common.min(s.data) }

pub fn opt_grad_amsgrad_slice_max(s : OptgradamsgradSlice) -> Double { @_common.max(s.data) }

pub fn opt_grad_amsgrad_slice_to_string(s : OptgradamsgradSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


///===
/// extcore/opt_grad_nadam

pub(all) struct OptgradnadamPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn opt_grad_nadam_make_point(x : Double, y : Double) -> OptgradnadamPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn opt_grad_nadam_make_point3(x : Double, y : Double, z : Double) -> OptgradnadamPoint {
  { x, y, z, label: 0 }
}

pub fn opt_grad_nadam_point_x(pt : OptgradnadamPoint) -> Double { pt.x }

pub fn opt_grad_nadam_point_y(pt : OptgradnadamPoint) -> Double { pt.y }

pub fn opt_grad_nadam_point_z(pt : OptgradnadamPoint) -> Double { pt.z }

pub fn opt_grad_nadam_point_label(pt : OptgradnadamPoint) -> Int { pt.label }

pub fn opt_grad_nadam_point_dist(a : OptgradnadamPoint, b : OptgradnadamPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn opt_grad_nadam_point_add(a : OptgradnadamPoint, b : OptgradnadamPoint) -> OptgradnadamPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn opt_grad_nadam_point_sub(a : OptgradnadamPoint, b : OptgradnadamPoint) -> OptgradnadamPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn opt_grad_nadam_point_scale(pt : OptgradnadamPoint, s : Double) -> OptgradnadamPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn opt_grad_nadam_point_dot(a : OptgradnadamPoint, b : OptgradnadamPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn opt_grad_nadam_point_cross(a : OptgradnadamPoint, b : OptgradnadamPoint) -> OptgradnadamPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn opt_grad_nadam_point_norm(pt : OptgradnadamPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn opt_grad_nadam_point_normalize(pt : OptgradnadamPoint) -> OptgradnadamPoint {
  let n = opt_grad_nadam_point_norm(pt)
  if n < 0.0000001 { pt } else { opt_grad_nadam_point_scale(pt, 1.0 / n) }
}

pub fn opt_grad_nadam_point_negate(pt : OptgradnadamPoint) -> OptgradnadamPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn opt_grad_nadam_point_mid(a : OptgradnadamPoint, b : OptgradnadamPoint) -> OptgradnadamPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn opt_grad_nadam_point_lerp(a : OptgradnadamPoint, b : OptgradnadamPoint, t : Double) -> OptgradnadamPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn opt_grad_nadam_point_to_string(pt : OptgradnadamPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct OptgradnadamSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn opt_grad_nadam_make_series(vals : Array[Double], name : String) -> OptgradnadamSeries {
  { vals, name, meta: 0 }
}

pub fn opt_grad_nadam_series_len(s : OptgradnadamSeries) -> Int { s.vals.length() }

pub fn opt_grad_nadam_series_sum(s : OptgradnadamSeries) -> Double { @_common.sum(s.vals) }

pub fn opt_grad_nadam_series_mean(s : OptgradnadamSeries) -> Double { @_common.mean(s.vals) }

pub fn opt_grad_nadam_series_min(s : OptgradnadamSeries) -> Double { @_common.min(s.vals) }

pub fn opt_grad_nadam_series_max(s : OptgradnadamSeries) -> Double { @_common.max(s.vals) }

pub fn opt_grad_nadam_series_range(s : OptgradnadamSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn opt_grad_nadam_series_var(s : OptgradnadamSeries) -> Double { @_common.variance(s.vals) }

pub fn opt_grad_nadam_series_std(s : OptgradnadamSeries) -> Double { @_common.std(s.vals) }

pub fn opt_grad_nadam_series_median(s : OptgradnadamSeries) -> Double { @_common.median(s.vals) }

pub fn opt_grad_nadam_series_scale(s : OptgradnadamSeries, f : Double) -> OptgradnadamSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn opt_grad_nadam_series_add(a : OptgradnadamSeries, b : OptgradnadamSeries) -> OptgradnadamSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn opt_grad_nadam_series_sub(a : OptgradnadamSeries, b : OptgradnadamSeries) -> OptgradnadamSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn opt_grad_nadam_series_normalize(s : OptgradnadamSeries) -> OptgradnadamSeries {
  let mn = opt_grad_nadam_series_min(s)
  let mx = opt_grad_nadam_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn opt_grad_nadam_series_cumsum(s : OptgradnadamSeries) -> OptgradnadamSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn opt_grad_nadam_series_to_string(s : OptgradnadamSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct OptgradnadamMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn opt_grad_nadam_make_matrix(rows : Int, cols : Int, val : Double) -> OptgradnadamMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn opt_grad_nadam_matrix_identity(n : Int) -> OptgradnadamMatrix {
  let m = opt_grad_nadam_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn opt_grad_nadam_matrix_get(m : OptgradnadamMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn opt_grad_nadam_matrix_transpose(m : OptgradnadamMatrix) -> OptgradnadamMatrix {
  let result = opt_grad_nadam_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn opt_grad_nadam_matrix_add(a : OptgradnadamMatrix, b : OptgradnadamMatrix) -> OptgradnadamMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = opt_grad_nadam_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn opt_grad_nadam_matrix_scale(m : OptgradnadamMatrix, s : Double) -> OptgradnadamMatrix {
  let result = opt_grad_nadam_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn opt_grad_nadam_matrix_multiply(a : OptgradnadamMatrix, b : OptgradnadamMatrix) -> OptgradnadamMatrix {
  if a.cols != b.rows { return opt_grad_nadam_make_matrix(a.rows, b.cols, 0.0) }
  let result = opt_grad_nadam_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn opt_grad_nadam_matrix_trace(m : OptgradnadamMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn opt_grad_nadam_matrix_det(m : OptgradnadamMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn opt_grad_nadam_matrix_norm(m : OptgradnadamMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn opt_grad_nadam_matrix_to_string(m : OptgradnadamMatrix) -> String {
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

pub(all) struct OptgradnadamVector {
  comps : Array[Double]
  dim : Int
}

pub fn opt_grad_nadam_make_vector(comps : Array[Double]) -> OptgradnadamVector {
  { comps, dim: comps.length() }
}

pub fn opt_grad_nadam_vector_zero(dim : Int) -> OptgradnadamVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn opt_grad_nadam_vector_add(a : OptgradnadamVector, b : OptgradnadamVector) -> OptgradnadamVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn opt_grad_nadam_vector_sub(a : OptgradnadamVector, b : OptgradnadamVector) -> OptgradnadamVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn opt_grad_nadam_vector_scale(v : OptgradnadamVector, s : Double) -> OptgradnadamVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn opt_grad_nadam_vector_dot(a : OptgradnadamVector, b : OptgradnadamVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn opt_grad_nadam_vector_norm(v : OptgradnadamVector) -> Double { @_common.sqrt(opt_grad_nadam_vector_dot(v, v)) }

pub fn opt_grad_nadam_vector_normalize(v : OptgradnadamVector) -> OptgradnadamVector {
  let n = opt_grad_nadam_vector_norm(v)
  if n < 0.0000001 { v } else { opt_grad_nadam_vector_scale(v, 1.0 / n) }
}

pub fn opt_grad_nadam_vector_dist(a : OptgradnadamVector, b : OptgradnadamVector) -> Double {
  opt_grad_nadam_vector_norm(opt_grad_nadam_vector_sub(a, b))
}

pub fn opt_grad_nadam_vector_to_string(v : OptgradnadamVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn opt_grad_nadam_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn opt_grad_nadam_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn opt_grad_nadam_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn opt_grad_nadam_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn opt_grad_nadam_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn opt_grad_nadam_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn opt_grad_nadam_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn opt_grad_nadam_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn opt_grad_nadam_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn opt_grad_nadam_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn opt_grad_nadam_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn opt_grad_nadam_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn opt_grad_nadam_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn opt_grad_nadam_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn opt_grad_nadam_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn opt_grad_nadam_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn opt_grad_nadam_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn opt_grad_nadam_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn opt_grad_nadam_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn opt_grad_nadam_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn opt_grad_nadam_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn opt_grad_nadam_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn opt_grad_nadam_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn opt_grad_nadam_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn opt_grad_nadam_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn opt_grad_nadam_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn opt_grad_nadam_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn opt_grad_nadam_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn opt_grad_nadam_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct OptgradnadamFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_nadam_frame_make(size : Int) -> OptgradnadamFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_nadam_frame_len(s : OptgradnadamFrame) -> Int { s.size }

pub fn opt_grad_nadam_frame_get(s : OptgradnadamFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_nadam_frame_set(s : OptgradnadamFrame, i : Int, v : Double) -> OptgradnadamFrame {
  let result = opt_grad_nadam_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_nadam_frame_sum(s : OptgradnadamFrame) -> Double { @_common.sum(s.data) }

pub fn opt_grad_nadam_frame_mean(s : OptgradnadamFrame) -> Double { @_common.mean(s.data) }

pub fn opt_grad_nadam_frame_scale(s : OptgradnadamFrame, f : Double) -> OptgradnadamFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_nadam_frame_add(a : OptgradnadamFrame, b : OptgradnadamFrame) -> OptgradnadamFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_nadam_frame_copy(s : OptgradnadamFrame) -> OptgradnadamFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_nadam_frame_fill(s : OptgradnadamFrame, v : Double) -> OptgradnadamFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_nadam_frame_min(s : OptgradnadamFrame) -> Double { @_common.min(s.data) }

pub fn opt_grad_nadam_frame_max(s : OptgradnadamFrame) -> Double { @_common.max(s.data) }

pub fn opt_grad_nadam_frame_to_string(s : OptgradnadamFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradnadamTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_nadam_table_make(size : Int) -> OptgradnadamTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_nadam_table_len(s : OptgradnadamTable) -> Int { s.size }

pub fn opt_grad_nadam_table_get(s : OptgradnadamTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_nadam_table_set(s : OptgradnadamTable, i : Int, v : Double) -> OptgradnadamTable {
  let result = opt_grad_nadam_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_nadam_table_sum(s : OptgradnadamTable) -> Double { @_common.sum(s.data) }

pub fn opt_grad_nadam_table_mean(s : OptgradnadamTable) -> Double { @_common.mean(s.data) }

pub fn opt_grad_nadam_table_scale(s : OptgradnadamTable, f : Double) -> OptgradnadamTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_nadam_table_add(a : OptgradnadamTable, b : OptgradnadamTable) -> OptgradnadamTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_nadam_table_copy(s : OptgradnadamTable) -> OptgradnadamTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_nadam_table_fill(s : OptgradnadamTable, v : Double) -> OptgradnadamTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_nadam_table_min(s : OptgradnadamTable) -> Double { @_common.min(s.data) }

pub fn opt_grad_nadam_table_max(s : OptgradnadamTable) -> Double { @_common.max(s.data) }

pub fn opt_grad_nadam_table_to_string(s : OptgradnadamTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradnadamGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_nadam_graphn_make(size : Int) -> OptgradnadamGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_nadam_graphn_len(s : OptgradnadamGraphN) -> Int { s.size }

pub fn opt_grad_nadam_graphn_get(s : OptgradnadamGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_nadam_graphn_set(s : OptgradnadamGraphN, i : Int, v : Double) -> OptgradnadamGraphN {
  let result = opt_grad_nadam_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_nadam_graphn_sum(s : OptgradnadamGraphN) -> Double { @_common.sum(s.data) }

pub fn opt_grad_nadam_graphn_mean(s : OptgradnadamGraphN) -> Double { @_common.mean(s.data) }

pub fn opt_grad_nadam_graphn_scale(s : OptgradnadamGraphN, f : Double) -> OptgradnadamGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_nadam_graphn_add(a : OptgradnadamGraphN, b : OptgradnadamGraphN) -> OptgradnadamGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_nadam_graphn_copy(s : OptgradnadamGraphN) -> OptgradnadamGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_nadam_graphn_fill(s : OptgradnadamGraphN, v : Double) -> OptgradnadamGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_nadam_graphn_min(s : OptgradnadamGraphN) -> Double { @_common.min(s.data) }

pub fn opt_grad_nadam_graphn_max(s : OptgradnadamGraphN) -> Double { @_common.max(s.data) }

pub fn opt_grad_nadam_graphn_to_string(s : OptgradnadamGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradnadamNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_nadam_node_make(size : Int) -> OptgradnadamNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_nadam_node_len(s : OptgradnadamNode) -> Int { s.size }

pub fn opt_grad_nadam_node_get(s : OptgradnadamNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_nadam_node_set(s : OptgradnadamNode, i : Int, v : Double) -> OptgradnadamNode {
  let result = opt_grad_nadam_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_nadam_node_sum(s : OptgradnadamNode) -> Double { @_common.sum(s.data) }

pub fn opt_grad_nadam_node_mean(s : OptgradnadamNode) -> Double { @_common.mean(s.data) }

pub fn opt_grad_nadam_node_scale(s : OptgradnadamNode, f : Double) -> OptgradnadamNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_nadam_node_add(a : OptgradnadamNode, b : OptgradnadamNode) -> OptgradnadamNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_nadam_node_copy(s : OptgradnadamNode) -> OptgradnadamNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_nadam_node_fill(s : OptgradnadamNode, v : Double) -> OptgradnadamNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_nadam_node_min(s : OptgradnadamNode) -> Double { @_common.min(s.data) }

pub fn opt_grad_nadam_node_max(s : OptgradnadamNode) -> Double { @_common.max(s.data) }

pub fn opt_grad_nadam_node_to_string(s : OptgradnadamNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradnadamEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_nadam_edge_make(size : Int) -> OptgradnadamEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_nadam_edge_len(s : OptgradnadamEdge) -> Int { s.size }

pub fn opt_grad_nadam_edge_get(s : OptgradnadamEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_nadam_edge_set(s : OptgradnadamEdge, i : Int, v : Double) -> OptgradnadamEdge {
  let result = opt_grad_nadam_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_nadam_edge_sum(s : OptgradnadamEdge) -> Double { @_common.sum(s.data) }

pub fn opt_grad_nadam_edge_mean(s : OptgradnadamEdge) -> Double { @_common.mean(s.data) }

pub fn opt_grad_nadam_edge_scale(s : OptgradnadamEdge, f : Double) -> OptgradnadamEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_nadam_edge_add(a : OptgradnadamEdge, b : OptgradnadamEdge) -> OptgradnadamEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_nadam_edge_copy(s : OptgradnadamEdge) -> OptgradnadamEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_nadam_edge_fill(s : OptgradnadamEdge, v : Double) -> OptgradnadamEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_nadam_edge_min(s : OptgradnadamEdge) -> Double { @_common.min(s.data) }

pub fn opt_grad_nadam_edge_max(s : OptgradnadamEdge) -> Double { @_common.max(s.data) }

pub fn opt_grad_nadam_edge_to_string(s : OptgradnadamEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradnadamPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_nadam_path_make(size : Int) -> OptgradnadamPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_nadam_path_len(s : OptgradnadamPath) -> Int { s.size }

pub fn opt_grad_nadam_path_get(s : OptgradnadamPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_nadam_path_set(s : OptgradnadamPath, i : Int, v : Double) -> OptgradnadamPath {
  let result = opt_grad_nadam_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_nadam_path_sum(s : OptgradnadamPath) -> Double { @_common.sum(s.data) }

pub fn opt_grad_nadam_path_mean(s : OptgradnadamPath) -> Double { @_common.mean(s.data) }

pub fn opt_grad_nadam_path_scale(s : OptgradnadamPath, f : Double) -> OptgradnadamPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_nadam_path_add(a : OptgradnadamPath, b : OptgradnadamPath) -> OptgradnadamPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_nadam_path_copy(s : OptgradnadamPath) -> OptgradnadamPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_nadam_path_fill(s : OptgradnadamPath, v : Double) -> OptgradnadamPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_nadam_path_min(s : OptgradnadamPath) -> Double { @_common.min(s.data) }

pub fn opt_grad_nadam_path_max(s : OptgradnadamPath) -> Double { @_common.max(s.data) }

pub fn opt_grad_nadam_path_to_string(s : OptgradnadamPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradnadamCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_nadam_cluster_make(size : Int) -> OptgradnadamCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_nadam_cluster_len(s : OptgradnadamCluster) -> Int { s.size }

pub fn opt_grad_nadam_cluster_get(s : OptgradnadamCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_nadam_cluster_set(s : OptgradnadamCluster, i : Int, v : Double) -> OptgradnadamCluster {
  let result = opt_grad_nadam_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_nadam_cluster_sum(s : OptgradnadamCluster) -> Double { @_common.sum(s.data) }

pub fn opt_grad_nadam_cluster_mean(s : OptgradnadamCluster) -> Double { @_common.mean(s.data) }

pub fn opt_grad_nadam_cluster_scale(s : OptgradnadamCluster, f : Double) -> OptgradnadamCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_nadam_cluster_add(a : OptgradnadamCluster, b : OptgradnadamCluster) -> OptgradnadamCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_nadam_cluster_copy(s : OptgradnadamCluster) -> OptgradnadamCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_nadam_cluster_fill(s : OptgradnadamCluster, v : Double) -> OptgradnadamCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_nadam_cluster_min(s : OptgradnadamCluster) -> Double { @_common.min(s.data) }

pub fn opt_grad_nadam_cluster_max(s : OptgradnadamCluster) -> Double { @_common.max(s.data) }

pub fn opt_grad_nadam_cluster_to_string(s : OptgradnadamCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradnadamModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_nadam_model_make(size : Int) -> OptgradnadamModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_nadam_model_len(s : OptgradnadamModel) -> Int { s.size }

pub fn opt_grad_nadam_model_get(s : OptgradnadamModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_nadam_model_set(s : OptgradnadamModel, i : Int, v : Double) -> OptgradnadamModel {
  let result = opt_grad_nadam_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_nadam_model_sum(s : OptgradnadamModel) -> Double { @_common.sum(s.data) }

pub fn opt_grad_nadam_model_mean(s : OptgradnadamModel) -> Double { @_common.mean(s.data) }

pub fn opt_grad_nadam_model_scale(s : OptgradnadamModel, f : Double) -> OptgradnadamModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_nadam_model_add(a : OptgradnadamModel, b : OptgradnadamModel) -> OptgradnadamModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_nadam_model_copy(s : OptgradnadamModel) -> OptgradnadamModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_nadam_model_fill(s : OptgradnadamModel, v : Double) -> OptgradnadamModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_nadam_model_min(s : OptgradnadamModel) -> Double { @_common.min(s.data) }

pub fn opt_grad_nadam_model_max(s : OptgradnadamModel) -> Double { @_common.max(s.data) }

pub fn opt_grad_nadam_model_to_string(s : OptgradnadamModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradnadamLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_nadam_layer_make(size : Int) -> OptgradnadamLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_nadam_layer_len(s : OptgradnadamLayer) -> Int { s.size }

pub fn opt_grad_nadam_layer_get(s : OptgradnadamLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_nadam_layer_set(s : OptgradnadamLayer, i : Int, v : Double) -> OptgradnadamLayer {
  let result = opt_grad_nadam_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_nadam_layer_sum(s : OptgradnadamLayer) -> Double { @_common.sum(s.data) }

pub fn opt_grad_nadam_layer_mean(s : OptgradnadamLayer) -> Double { @_common.mean(s.data) }

pub fn opt_grad_nadam_layer_scale(s : OptgradnadamLayer, f : Double) -> OptgradnadamLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_nadam_layer_add(a : OptgradnadamLayer, b : OptgradnadamLayer) -> OptgradnadamLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_nadam_layer_copy(s : OptgradnadamLayer) -> OptgradnadamLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_nadam_layer_fill(s : OptgradnadamLayer, v : Double) -> OptgradnadamLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_nadam_layer_min(s : OptgradnadamLayer) -> Double { @_common.min(s.data) }

pub fn opt_grad_nadam_layer_max(s : OptgradnadamLayer) -> Double { @_common.max(s.data) }

pub fn opt_grad_nadam_layer_to_string(s : OptgradnadamLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradnadamBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_nadam_buffer_make(size : Int) -> OptgradnadamBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_nadam_buffer_len(s : OptgradnadamBuffer) -> Int { s.size }

pub fn opt_grad_nadam_buffer_get(s : OptgradnadamBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_nadam_buffer_set(s : OptgradnadamBuffer, i : Int, v : Double) -> OptgradnadamBuffer {
  let result = opt_grad_nadam_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_nadam_buffer_sum(s : OptgradnadamBuffer) -> Double { @_common.sum(s.data) }

pub fn opt_grad_nadam_buffer_mean(s : OptgradnadamBuffer) -> Double { @_common.mean(s.data) }

pub fn opt_grad_nadam_buffer_scale(s : OptgradnadamBuffer, f : Double) -> OptgradnadamBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_nadam_buffer_add(a : OptgradnadamBuffer, b : OptgradnadamBuffer) -> OptgradnadamBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_nadam_buffer_copy(s : OptgradnadamBuffer) -> OptgradnadamBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_nadam_buffer_fill(s : OptgradnadamBuffer, v : Double) -> OptgradnadamBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_nadam_buffer_min(s : OptgradnadamBuffer) -> Double { @_common.min(s.data) }

pub fn opt_grad_nadam_buffer_max(s : OptgradnadamBuffer) -> Double { @_common.max(s.data) }

pub fn opt_grad_nadam_buffer_to_string(s : OptgradnadamBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradnadamCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_nadam_cursor_make(size : Int) -> OptgradnadamCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_nadam_cursor_len(s : OptgradnadamCursor) -> Int { s.size }

pub fn opt_grad_nadam_cursor_get(s : OptgradnadamCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_nadam_cursor_set(s : OptgradnadamCursor, i : Int, v : Double) -> OptgradnadamCursor {
  let result = opt_grad_nadam_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_nadam_cursor_sum(s : OptgradnadamCursor) -> Double { @_common.sum(s.data) }

pub fn opt_grad_nadam_cursor_mean(s : OptgradnadamCursor) -> Double { @_common.mean(s.data) }

pub fn opt_grad_nadam_cursor_scale(s : OptgradnadamCursor, f : Double) -> OptgradnadamCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_nadam_cursor_add(a : OptgradnadamCursor, b : OptgradnadamCursor) -> OptgradnadamCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_nadam_cursor_copy(s : OptgradnadamCursor) -> OptgradnadamCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_nadam_cursor_fill(s : OptgradnadamCursor, v : Double) -> OptgradnadamCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_nadam_cursor_min(s : OptgradnadamCursor) -> Double { @_common.min(s.data) }

pub fn opt_grad_nadam_cursor_max(s : OptgradnadamCursor) -> Double { @_common.max(s.data) }

pub fn opt_grad_nadam_cursor_to_string(s : OptgradnadamCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradnadamView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_nadam_view_make(size : Int) -> OptgradnadamView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_nadam_view_len(s : OptgradnadamView) -> Int { s.size }

pub fn opt_grad_nadam_view_get(s : OptgradnadamView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_nadam_view_set(s : OptgradnadamView, i : Int, v : Double) -> OptgradnadamView {
  let result = opt_grad_nadam_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_nadam_view_sum(s : OptgradnadamView) -> Double { @_common.sum(s.data) }

pub fn opt_grad_nadam_view_mean(s : OptgradnadamView) -> Double { @_common.mean(s.data) }

pub fn opt_grad_nadam_view_scale(s : OptgradnadamView, f : Double) -> OptgradnadamView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_nadam_view_add(a : OptgradnadamView, b : OptgradnadamView) -> OptgradnadamView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_nadam_view_copy(s : OptgradnadamView) -> OptgradnadamView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_nadam_view_fill(s : OptgradnadamView, v : Double) -> OptgradnadamView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_nadam_view_min(s : OptgradnadamView) -> Double { @_common.min(s.data) }

pub fn opt_grad_nadam_view_max(s : OptgradnadamView) -> Double { @_common.max(s.data) }

pub fn opt_grad_nadam_view_to_string(s : OptgradnadamView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradnadamRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_nadam_range_make(size : Int) -> OptgradnadamRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_nadam_range_len(s : OptgradnadamRange) -> Int { s.size }

pub fn opt_grad_nadam_range_get(s : OptgradnadamRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_nadam_range_set(s : OptgradnadamRange, i : Int, v : Double) -> OptgradnadamRange {
  let result = opt_grad_nadam_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_nadam_range_sum(s : OptgradnadamRange) -> Double { @_common.sum(s.data) }

pub fn opt_grad_nadam_range_mean(s : OptgradnadamRange) -> Double { @_common.mean(s.data) }

pub fn opt_grad_nadam_range_scale(s : OptgradnadamRange, f : Double) -> OptgradnadamRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_nadam_range_add(a : OptgradnadamRange, b : OptgradnadamRange) -> OptgradnadamRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_nadam_range_copy(s : OptgradnadamRange) -> OptgradnadamRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_nadam_range_fill(s : OptgradnadamRange, v : Double) -> OptgradnadamRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_nadam_range_min(s : OptgradnadamRange) -> Double { @_common.min(s.data) }

pub fn opt_grad_nadam_range_max(s : OptgradnadamRange) -> Double { @_common.max(s.data) }

pub fn opt_grad_nadam_range_to_string(s : OptgradnadamRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradnadamSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_nadam_slice_make(size : Int) -> OptgradnadamSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_nadam_slice_len(s : OptgradnadamSlice) -> Int { s.size }

pub fn opt_grad_nadam_slice_get(s : OptgradnadamSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_nadam_slice_set(s : OptgradnadamSlice, i : Int, v : Double) -> OptgradnadamSlice {
  let result = opt_grad_nadam_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_nadam_slice_sum(s : OptgradnadamSlice) -> Double { @_common.sum(s.data) }

pub fn opt_grad_nadam_slice_mean(s : OptgradnadamSlice) -> Double { @_common.mean(s.data) }

pub fn opt_grad_nadam_slice_scale(s : OptgradnadamSlice, f : Double) -> OptgradnadamSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_nadam_slice_add(a : OptgradnadamSlice, b : OptgradnadamSlice) -> OptgradnadamSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_nadam_slice_copy(s : OptgradnadamSlice) -> OptgradnadamSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_nadam_slice_fill(s : OptgradnadamSlice, v : Double) -> OptgradnadamSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_nadam_slice_min(s : OptgradnadamSlice) -> Double { @_common.min(s.data) }

pub fn opt_grad_nadam_slice_max(s : OptgradnadamSlice) -> Double { @_common.max(s.data) }

pub fn opt_grad_nadam_slice_to_string(s : OptgradnadamSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


///===
/// extcore/geo_dist_manhattan

pub(all) struct GeodistmanhattanPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_dist_manhattan_make_point(x : Double, y : Double) -> GeodistmanhattanPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_dist_manhattan_make_point3(x : Double, y : Double, z : Double) -> GeodistmanhattanPoint {
  { x, y, z, label: 0 }
}

pub fn geo_dist_manhattan_point_x(pt : GeodistmanhattanPoint) -> Double { pt.x }

pub fn geo_dist_manhattan_point_y(pt : GeodistmanhattanPoint) -> Double { pt.y }

pub fn geo_dist_manhattan_point_z(pt : GeodistmanhattanPoint) -> Double { pt.z }

pub fn geo_dist_manhattan_point_label(pt : GeodistmanhattanPoint) -> Int { pt.label }

pub fn geo_dist_manhattan_point_dist(a : GeodistmanhattanPoint, b : GeodistmanhattanPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn geo_dist_manhattan_point_add(a : GeodistmanhattanPoint, b : GeodistmanhattanPoint) -> GeodistmanhattanPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn geo_dist_manhattan_point_sub(a : GeodistmanhattanPoint, b : GeodistmanhattanPoint) -> GeodistmanhattanPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn geo_dist_manhattan_point_scale(pt : GeodistmanhattanPoint, s : Double) -> GeodistmanhattanPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn geo_dist_manhattan_point_dot(a : GeodistmanhattanPoint, b : GeodistmanhattanPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn geo_dist_manhattan_point_cross(a : GeodistmanhattanPoint, b : GeodistmanhattanPoint) -> GeodistmanhattanPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn geo_dist_manhattan_point_norm(pt : GeodistmanhattanPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn geo_dist_manhattan_point_normalize(pt : GeodistmanhattanPoint) -> GeodistmanhattanPoint {
  let n = geo_dist_manhattan_point_norm(pt)
  if n < 0.0000001 { pt } else { geo_dist_manhattan_point_scale(pt, 1.0 / n) }
}

pub fn geo_dist_manhattan_point_negate(pt : GeodistmanhattanPoint) -> GeodistmanhattanPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn geo_dist_manhattan_point_mid(a : GeodistmanhattanPoint, b : GeodistmanhattanPoint) -> GeodistmanhattanPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn geo_dist_manhattan_point_lerp(a : GeodistmanhattanPoint, b : GeodistmanhattanPoint, t : Double) -> GeodistmanhattanPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn geo_dist_manhattan_point_to_string(pt : GeodistmanhattanPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct GeodistmanhattanSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_dist_manhattan_make_series(vals : Array[Double], name : String) -> GeodistmanhattanSeries {
  { vals, name, meta: 0 }
}

pub fn geo_dist_manhattan_series_len(s : GeodistmanhattanSeries) -> Int { s.vals.length() }

pub fn geo_dist_manhattan_series_sum(s : GeodistmanhattanSeries) -> Double { @_common.sum(s.vals) }

pub fn geo_dist_manhattan_series_mean(s : GeodistmanhattanSeries) -> Double { @_common.mean(s.vals) }

pub fn geo_dist_manhattan_series_min(s : GeodistmanhattanSeries) -> Double { @_common.min(s.vals) }

pub fn geo_dist_manhattan_series_max(s : GeodistmanhattanSeries) -> Double { @_common.max(s.vals) }

pub fn geo_dist_manhattan_series_range(s : GeodistmanhattanSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn geo_dist_manhattan_series_var(s : GeodistmanhattanSeries) -> Double { @_common.variance(s.vals) }

pub fn geo_dist_manhattan_series_std(s : GeodistmanhattanSeries) -> Double { @_common.std(s.vals) }

pub fn geo_dist_manhattan_series_median(s : GeodistmanhattanSeries) -> Double { @_common.median(s.vals) }

pub fn geo_dist_manhattan_series_scale(s : GeodistmanhattanSeries, f : Double) -> GeodistmanhattanSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn geo_dist_manhattan_series_add(a : GeodistmanhattanSeries, b : GeodistmanhattanSeries) -> GeodistmanhattanSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn geo_dist_manhattan_series_sub(a : GeodistmanhattanSeries, b : GeodistmanhattanSeries) -> GeodistmanhattanSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn geo_dist_manhattan_series_normalize(s : GeodistmanhattanSeries) -> GeodistmanhattanSeries {
  let mn = geo_dist_manhattan_series_min(s)
  let mx = geo_dist_manhattan_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn geo_dist_manhattan_series_cumsum(s : GeodistmanhattanSeries) -> GeodistmanhattanSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn geo_dist_manhattan_series_to_string(s : GeodistmanhattanSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeodistmanhattanMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_dist_manhattan_make_matrix(rows : Int, cols : Int, val : Double) -> GeodistmanhattanMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn geo_dist_manhattan_matrix_identity(n : Int) -> GeodistmanhattanMatrix {
  let m = geo_dist_manhattan_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn geo_dist_manhattan_matrix_get(m : GeodistmanhattanMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn geo_dist_manhattan_matrix_transpose(m : GeodistmanhattanMatrix) -> GeodistmanhattanMatrix {
  let result = geo_dist_manhattan_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn geo_dist_manhattan_matrix_add(a : GeodistmanhattanMatrix, b : GeodistmanhattanMatrix) -> GeodistmanhattanMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = geo_dist_manhattan_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn geo_dist_manhattan_matrix_scale(m : GeodistmanhattanMatrix, s : Double) -> GeodistmanhattanMatrix {
  let result = geo_dist_manhattan_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn geo_dist_manhattan_matrix_multiply(a : GeodistmanhattanMatrix, b : GeodistmanhattanMatrix) -> GeodistmanhattanMatrix {
  if a.cols != b.rows { return geo_dist_manhattan_make_matrix(a.rows, b.cols, 0.0) }
  let result = geo_dist_manhattan_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn geo_dist_manhattan_matrix_trace(m : GeodistmanhattanMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn geo_dist_manhattan_matrix_det(m : GeodistmanhattanMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn geo_dist_manhattan_matrix_norm(m : GeodistmanhattanMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn geo_dist_manhattan_matrix_to_string(m : GeodistmanhattanMatrix) -> String {
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

pub(all) struct GeodistmanhattanVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_dist_manhattan_make_vector(comps : Array[Double]) -> GeodistmanhattanVector {
  { comps, dim: comps.length() }
}

pub fn geo_dist_manhattan_vector_zero(dim : Int) -> GeodistmanhattanVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn geo_dist_manhattan_vector_add(a : GeodistmanhattanVector, b : GeodistmanhattanVector) -> GeodistmanhattanVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn geo_dist_manhattan_vector_sub(a : GeodistmanhattanVector, b : GeodistmanhattanVector) -> GeodistmanhattanVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn geo_dist_manhattan_vector_scale(v : GeodistmanhattanVector, s : Double) -> GeodistmanhattanVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn geo_dist_manhattan_vector_dot(a : GeodistmanhattanVector, b : GeodistmanhattanVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn geo_dist_manhattan_vector_norm(v : GeodistmanhattanVector) -> Double { @_common.sqrt(geo_dist_manhattan_vector_dot(v, v)) }

pub fn geo_dist_manhattan_vector_normalize(v : GeodistmanhattanVector) -> GeodistmanhattanVector {
  let n = geo_dist_manhattan_vector_norm(v)
  if n < 0.0000001 { v } else { geo_dist_manhattan_vector_scale(v, 1.0 / n) }
}

pub fn geo_dist_manhattan_vector_dist(a : GeodistmanhattanVector, b : GeodistmanhattanVector) -> Double {
  geo_dist_manhattan_vector_norm(geo_dist_manhattan_vector_sub(a, b))
}

pub fn geo_dist_manhattan_vector_to_string(v : GeodistmanhattanVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn geo_dist_manhattan_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn geo_dist_manhattan_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn geo_dist_manhattan_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn geo_dist_manhattan_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn geo_dist_manhattan_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn geo_dist_manhattan_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn geo_dist_manhattan_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn geo_dist_manhattan_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn geo_dist_manhattan_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn geo_dist_manhattan_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn geo_dist_manhattan_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn geo_dist_manhattan_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn geo_dist_manhattan_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn geo_dist_manhattan_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn geo_dist_manhattan_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn geo_dist_manhattan_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn geo_dist_manhattan_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn geo_dist_manhattan_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn geo_dist_manhattan_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn geo_dist_manhattan_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn geo_dist_manhattan_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn geo_dist_manhattan_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn geo_dist_manhattan_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn geo_dist_manhattan_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn geo_dist_manhattan_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn geo_dist_manhattan_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn geo_dist_manhattan_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn geo_dist_manhattan_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn geo_dist_manhattan_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GeodistmanhattanFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_manhattan_frame_make(size : Int) -> GeodistmanhattanFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_manhattan_frame_len(s : GeodistmanhattanFrame) -> Int { s.size }

pub fn geo_dist_manhattan_frame_get(s : GeodistmanhattanFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_manhattan_frame_set(s : GeodistmanhattanFrame, i : Int, v : Double) -> GeodistmanhattanFrame {
  let result = geo_dist_manhattan_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_manhattan_frame_sum(s : GeodistmanhattanFrame) -> Double { @_common.sum(s.data) }

pub fn geo_dist_manhattan_frame_mean(s : GeodistmanhattanFrame) -> Double { @_common.mean(s.data) }

pub fn geo_dist_manhattan_frame_scale(s : GeodistmanhattanFrame, f : Double) -> GeodistmanhattanFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_manhattan_frame_add(a : GeodistmanhattanFrame, b : GeodistmanhattanFrame) -> GeodistmanhattanFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_manhattan_frame_copy(s : GeodistmanhattanFrame) -> GeodistmanhattanFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_manhattan_frame_fill(s : GeodistmanhattanFrame, v : Double) -> GeodistmanhattanFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_manhattan_frame_min(s : GeodistmanhattanFrame) -> Double { @_common.min(s.data) }

pub fn geo_dist_manhattan_frame_max(s : GeodistmanhattanFrame) -> Double { @_common.max(s.data) }

pub fn geo_dist_manhattan_frame_to_string(s : GeodistmanhattanFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistmanhattanTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_manhattan_table_make(size : Int) -> GeodistmanhattanTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_manhattan_table_len(s : GeodistmanhattanTable) -> Int { s.size }

pub fn geo_dist_manhattan_table_get(s : GeodistmanhattanTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_manhattan_table_set(s : GeodistmanhattanTable, i : Int, v : Double) -> GeodistmanhattanTable {
  let result = geo_dist_manhattan_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_manhattan_table_sum(s : GeodistmanhattanTable) -> Double { @_common.sum(s.data) }

pub fn geo_dist_manhattan_table_mean(s : GeodistmanhattanTable) -> Double { @_common.mean(s.data) }

pub fn geo_dist_manhattan_table_scale(s : GeodistmanhattanTable, f : Double) -> GeodistmanhattanTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_manhattan_table_add(a : GeodistmanhattanTable, b : GeodistmanhattanTable) -> GeodistmanhattanTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_manhattan_table_copy(s : GeodistmanhattanTable) -> GeodistmanhattanTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_manhattan_table_fill(s : GeodistmanhattanTable, v : Double) -> GeodistmanhattanTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_manhattan_table_min(s : GeodistmanhattanTable) -> Double { @_common.min(s.data) }

pub fn geo_dist_manhattan_table_max(s : GeodistmanhattanTable) -> Double { @_common.max(s.data) }

pub fn geo_dist_manhattan_table_to_string(s : GeodistmanhattanTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistmanhattanGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_manhattan_graphn_make(size : Int) -> GeodistmanhattanGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_manhattan_graphn_len(s : GeodistmanhattanGraphN) -> Int { s.size }

pub fn geo_dist_manhattan_graphn_get(s : GeodistmanhattanGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_manhattan_graphn_set(s : GeodistmanhattanGraphN, i : Int, v : Double) -> GeodistmanhattanGraphN {
  let result = geo_dist_manhattan_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_manhattan_graphn_sum(s : GeodistmanhattanGraphN) -> Double { @_common.sum(s.data) }

pub fn geo_dist_manhattan_graphn_mean(s : GeodistmanhattanGraphN) -> Double { @_common.mean(s.data) }

pub fn geo_dist_manhattan_graphn_scale(s : GeodistmanhattanGraphN, f : Double) -> GeodistmanhattanGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_manhattan_graphn_add(a : GeodistmanhattanGraphN, b : GeodistmanhattanGraphN) -> GeodistmanhattanGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_manhattan_graphn_copy(s : GeodistmanhattanGraphN) -> GeodistmanhattanGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_manhattan_graphn_fill(s : GeodistmanhattanGraphN, v : Double) -> GeodistmanhattanGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_manhattan_graphn_min(s : GeodistmanhattanGraphN) -> Double { @_common.min(s.data) }

pub fn geo_dist_manhattan_graphn_max(s : GeodistmanhattanGraphN) -> Double { @_common.max(s.data) }

pub fn geo_dist_manhattan_graphn_to_string(s : GeodistmanhattanGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistmanhattanNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_manhattan_node_make(size : Int) -> GeodistmanhattanNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_manhattan_node_len(s : GeodistmanhattanNode) -> Int { s.size }

pub fn geo_dist_manhattan_node_get(s : GeodistmanhattanNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_manhattan_node_set(s : GeodistmanhattanNode, i : Int, v : Double) -> GeodistmanhattanNode {
  let result = geo_dist_manhattan_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_manhattan_node_sum(s : GeodistmanhattanNode) -> Double { @_common.sum(s.data) }

pub fn geo_dist_manhattan_node_mean(s : GeodistmanhattanNode) -> Double { @_common.mean(s.data) }

pub fn geo_dist_manhattan_node_scale(s : GeodistmanhattanNode, f : Double) -> GeodistmanhattanNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_manhattan_node_add(a : GeodistmanhattanNode, b : GeodistmanhattanNode) -> GeodistmanhattanNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_manhattan_node_copy(s : GeodistmanhattanNode) -> GeodistmanhattanNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_manhattan_node_fill(s : GeodistmanhattanNode, v : Double) -> GeodistmanhattanNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_manhattan_node_min(s : GeodistmanhattanNode) -> Double { @_common.min(s.data) }

pub fn geo_dist_manhattan_node_max(s : GeodistmanhattanNode) -> Double { @_common.max(s.data) }

pub fn geo_dist_manhattan_node_to_string(s : GeodistmanhattanNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistmanhattanEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_manhattan_edge_make(size : Int) -> GeodistmanhattanEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_manhattan_edge_len(s : GeodistmanhattanEdge) -> Int { s.size }

pub fn geo_dist_manhattan_edge_get(s : GeodistmanhattanEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_manhattan_edge_set(s : GeodistmanhattanEdge, i : Int, v : Double) -> GeodistmanhattanEdge {
  let result = geo_dist_manhattan_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_manhattan_edge_sum(s : GeodistmanhattanEdge) -> Double { @_common.sum(s.data) }

pub fn geo_dist_manhattan_edge_mean(s : GeodistmanhattanEdge) -> Double { @_common.mean(s.data) }

pub fn geo_dist_manhattan_edge_scale(s : GeodistmanhattanEdge, f : Double) -> GeodistmanhattanEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_manhattan_edge_add(a : GeodistmanhattanEdge, b : GeodistmanhattanEdge) -> GeodistmanhattanEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_manhattan_edge_copy(s : GeodistmanhattanEdge) -> GeodistmanhattanEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_manhattan_edge_fill(s : GeodistmanhattanEdge, v : Double) -> GeodistmanhattanEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_manhattan_edge_min(s : GeodistmanhattanEdge) -> Double { @_common.min(s.data) }

pub fn geo_dist_manhattan_edge_max(s : GeodistmanhattanEdge) -> Double { @_common.max(s.data) }

pub fn geo_dist_manhattan_edge_to_string(s : GeodistmanhattanEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistmanhattanPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_manhattan_path_make(size : Int) -> GeodistmanhattanPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_manhattan_path_len(s : GeodistmanhattanPath) -> Int { s.size }

pub fn geo_dist_manhattan_path_get(s : GeodistmanhattanPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_manhattan_path_set(s : GeodistmanhattanPath, i : Int, v : Double) -> GeodistmanhattanPath {
  let result = geo_dist_manhattan_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_manhattan_path_sum(s : GeodistmanhattanPath) -> Double { @_common.sum(s.data) }

pub fn geo_dist_manhattan_path_mean(s : GeodistmanhattanPath) -> Double { @_common.mean(s.data) }

pub fn geo_dist_manhattan_path_scale(s : GeodistmanhattanPath, f : Double) -> GeodistmanhattanPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_manhattan_path_add(a : GeodistmanhattanPath, b : GeodistmanhattanPath) -> GeodistmanhattanPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_manhattan_path_copy(s : GeodistmanhattanPath) -> GeodistmanhattanPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_manhattan_path_fill(s : GeodistmanhattanPath, v : Double) -> GeodistmanhattanPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_manhattan_path_min(s : GeodistmanhattanPath) -> Double { @_common.min(s.data) }

pub fn geo_dist_manhattan_path_max(s : GeodistmanhattanPath) -> Double { @_common.max(s.data) }

pub fn geo_dist_manhattan_path_to_string(s : GeodistmanhattanPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistmanhattanCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_manhattan_cluster_make(size : Int) -> GeodistmanhattanCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_manhattan_cluster_len(s : GeodistmanhattanCluster) -> Int { s.size }

pub fn geo_dist_manhattan_cluster_get(s : GeodistmanhattanCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_manhattan_cluster_set(s : GeodistmanhattanCluster, i : Int, v : Double) -> GeodistmanhattanCluster {
  let result = geo_dist_manhattan_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_manhattan_cluster_sum(s : GeodistmanhattanCluster) -> Double { @_common.sum(s.data) }

pub fn geo_dist_manhattan_cluster_mean(s : GeodistmanhattanCluster) -> Double { @_common.mean(s.data) }

pub fn geo_dist_manhattan_cluster_scale(s : GeodistmanhattanCluster, f : Double) -> GeodistmanhattanCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_manhattan_cluster_add(a : GeodistmanhattanCluster, b : GeodistmanhattanCluster) -> GeodistmanhattanCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_manhattan_cluster_copy(s : GeodistmanhattanCluster) -> GeodistmanhattanCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_manhattan_cluster_fill(s : GeodistmanhattanCluster, v : Double) -> GeodistmanhattanCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_manhattan_cluster_min(s : GeodistmanhattanCluster) -> Double { @_common.min(s.data) }

pub fn geo_dist_manhattan_cluster_max(s : GeodistmanhattanCluster) -> Double { @_common.max(s.data) }

pub fn geo_dist_manhattan_cluster_to_string(s : GeodistmanhattanCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistmanhattanModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_manhattan_model_make(size : Int) -> GeodistmanhattanModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_manhattan_model_len(s : GeodistmanhattanModel) -> Int { s.size }

pub fn geo_dist_manhattan_model_get(s : GeodistmanhattanModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_manhattan_model_set(s : GeodistmanhattanModel, i : Int, v : Double) -> GeodistmanhattanModel {
  let result = geo_dist_manhattan_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_manhattan_model_sum(s : GeodistmanhattanModel) -> Double { @_common.sum(s.data) }

pub fn geo_dist_manhattan_model_mean(s : GeodistmanhattanModel) -> Double { @_common.mean(s.data) }

pub fn geo_dist_manhattan_model_scale(s : GeodistmanhattanModel, f : Double) -> GeodistmanhattanModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_manhattan_model_add(a : GeodistmanhattanModel, b : GeodistmanhattanModel) -> GeodistmanhattanModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_manhattan_model_copy(s : GeodistmanhattanModel) -> GeodistmanhattanModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_manhattan_model_fill(s : GeodistmanhattanModel, v : Double) -> GeodistmanhattanModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_manhattan_model_min(s : GeodistmanhattanModel) -> Double { @_common.min(s.data) }

pub fn geo_dist_manhattan_model_max(s : GeodistmanhattanModel) -> Double { @_common.max(s.data) }

pub fn geo_dist_manhattan_model_to_string(s : GeodistmanhattanModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistmanhattanLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_manhattan_layer_make(size : Int) -> GeodistmanhattanLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_manhattan_layer_len(s : GeodistmanhattanLayer) -> Int { s.size }

pub fn geo_dist_manhattan_layer_get(s : GeodistmanhattanLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_manhattan_layer_set(s : GeodistmanhattanLayer, i : Int, v : Double) -> GeodistmanhattanLayer {
  let result = geo_dist_manhattan_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_manhattan_layer_sum(s : GeodistmanhattanLayer) -> Double { @_common.sum(s.data) }

pub fn geo_dist_manhattan_layer_mean(s : GeodistmanhattanLayer) -> Double { @_common.mean(s.data) }

pub fn geo_dist_manhattan_layer_scale(s : GeodistmanhattanLayer, f : Double) -> GeodistmanhattanLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_manhattan_layer_add(a : GeodistmanhattanLayer, b : GeodistmanhattanLayer) -> GeodistmanhattanLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_manhattan_layer_copy(s : GeodistmanhattanLayer) -> GeodistmanhattanLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_manhattan_layer_fill(s : GeodistmanhattanLayer, v : Double) -> GeodistmanhattanLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_manhattan_layer_min(s : GeodistmanhattanLayer) -> Double { @_common.min(s.data) }

pub fn geo_dist_manhattan_layer_max(s : GeodistmanhattanLayer) -> Double { @_common.max(s.data) }

pub fn geo_dist_manhattan_layer_to_string(s : GeodistmanhattanLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistmanhattanBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_manhattan_buffer_make(size : Int) -> GeodistmanhattanBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_manhattan_buffer_len(s : GeodistmanhattanBuffer) -> Int { s.size }

pub fn geo_dist_manhattan_buffer_get(s : GeodistmanhattanBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_manhattan_buffer_set(s : GeodistmanhattanBuffer, i : Int, v : Double) -> GeodistmanhattanBuffer {
  let result = geo_dist_manhattan_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_manhattan_buffer_sum(s : GeodistmanhattanBuffer) -> Double { @_common.sum(s.data) }

pub fn geo_dist_manhattan_buffer_mean(s : GeodistmanhattanBuffer) -> Double { @_common.mean(s.data) }

pub fn geo_dist_manhattan_buffer_scale(s : GeodistmanhattanBuffer, f : Double) -> GeodistmanhattanBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_manhattan_buffer_add(a : GeodistmanhattanBuffer, b : GeodistmanhattanBuffer) -> GeodistmanhattanBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_manhattan_buffer_copy(s : GeodistmanhattanBuffer) -> GeodistmanhattanBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_manhattan_buffer_fill(s : GeodistmanhattanBuffer, v : Double) -> GeodistmanhattanBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_manhattan_buffer_min(s : GeodistmanhattanBuffer) -> Double { @_common.min(s.data) }

pub fn geo_dist_manhattan_buffer_max(s : GeodistmanhattanBuffer) -> Double { @_common.max(s.data) }

pub fn geo_dist_manhattan_buffer_to_string(s : GeodistmanhattanBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistmanhattanCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_manhattan_cursor_make(size : Int) -> GeodistmanhattanCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_manhattan_cursor_len(s : GeodistmanhattanCursor) -> Int { s.size }

pub fn geo_dist_manhattan_cursor_get(s : GeodistmanhattanCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_manhattan_cursor_set(s : GeodistmanhattanCursor, i : Int, v : Double) -> GeodistmanhattanCursor {
  let result = geo_dist_manhattan_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_manhattan_cursor_sum(s : GeodistmanhattanCursor) -> Double { @_common.sum(s.data) }

pub fn geo_dist_manhattan_cursor_mean(s : GeodistmanhattanCursor) -> Double { @_common.mean(s.data) }

pub fn geo_dist_manhattan_cursor_scale(s : GeodistmanhattanCursor, f : Double) -> GeodistmanhattanCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_manhattan_cursor_add(a : GeodistmanhattanCursor, b : GeodistmanhattanCursor) -> GeodistmanhattanCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_manhattan_cursor_copy(s : GeodistmanhattanCursor) -> GeodistmanhattanCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_manhattan_cursor_fill(s : GeodistmanhattanCursor, v : Double) -> GeodistmanhattanCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_manhattan_cursor_min(s : GeodistmanhattanCursor) -> Double { @_common.min(s.data) }

pub fn geo_dist_manhattan_cursor_max(s : GeodistmanhattanCursor) -> Double { @_common.max(s.data) }

pub fn geo_dist_manhattan_cursor_to_string(s : GeodistmanhattanCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistmanhattanView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_manhattan_view_make(size : Int) -> GeodistmanhattanView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_manhattan_view_len(s : GeodistmanhattanView) -> Int { s.size }

pub fn geo_dist_manhattan_view_get(s : GeodistmanhattanView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_manhattan_view_set(s : GeodistmanhattanView, i : Int, v : Double) -> GeodistmanhattanView {
  let result = geo_dist_manhattan_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_manhattan_view_sum(s : GeodistmanhattanView) -> Double { @_common.sum(s.data) }

pub fn geo_dist_manhattan_view_mean(s : GeodistmanhattanView) -> Double { @_common.mean(s.data) }

pub fn geo_dist_manhattan_view_scale(s : GeodistmanhattanView, f : Double) -> GeodistmanhattanView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_manhattan_view_add(a : GeodistmanhattanView, b : GeodistmanhattanView) -> GeodistmanhattanView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_manhattan_view_copy(s : GeodistmanhattanView) -> GeodistmanhattanView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_manhattan_view_fill(s : GeodistmanhattanView, v : Double) -> GeodistmanhattanView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_manhattan_view_min(s : GeodistmanhattanView) -> Double { @_common.min(s.data) }

pub fn geo_dist_manhattan_view_max(s : GeodistmanhattanView) -> Double { @_common.max(s.data) }

pub fn geo_dist_manhattan_view_to_string(s : GeodistmanhattanView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistmanhattanRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_manhattan_range_make(size : Int) -> GeodistmanhattanRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_manhattan_range_len(s : GeodistmanhattanRange) -> Int { s.size }

pub fn geo_dist_manhattan_range_get(s : GeodistmanhattanRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_manhattan_range_set(s : GeodistmanhattanRange, i : Int, v : Double) -> GeodistmanhattanRange {
  let result = geo_dist_manhattan_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_manhattan_range_sum(s : GeodistmanhattanRange) -> Double { @_common.sum(s.data) }

pub fn geo_dist_manhattan_range_mean(s : GeodistmanhattanRange) -> Double { @_common.mean(s.data) }

pub fn geo_dist_manhattan_range_scale(s : GeodistmanhattanRange, f : Double) -> GeodistmanhattanRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_manhattan_range_add(a : GeodistmanhattanRange, b : GeodistmanhattanRange) -> GeodistmanhattanRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_manhattan_range_copy(s : GeodistmanhattanRange) -> GeodistmanhattanRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_manhattan_range_fill(s : GeodistmanhattanRange, v : Double) -> GeodistmanhattanRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_manhattan_range_min(s : GeodistmanhattanRange) -> Double { @_common.min(s.data) }

pub fn geo_dist_manhattan_range_max(s : GeodistmanhattanRange) -> Double { @_common.max(s.data) }

pub fn geo_dist_manhattan_range_to_string(s : GeodistmanhattanRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistmanhattanSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_manhattan_slice_make(size : Int) -> GeodistmanhattanSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_manhattan_slice_len(s : GeodistmanhattanSlice) -> Int { s.size }

pub fn geo_dist_manhattan_slice_get(s : GeodistmanhattanSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_manhattan_slice_set(s : GeodistmanhattanSlice, i : Int, v : Double) -> GeodistmanhattanSlice {
  let result = geo_dist_manhattan_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_manhattan_slice_sum(s : GeodistmanhattanSlice) -> Double { @_common.sum(s.data) }

pub fn geo_dist_manhattan_slice_mean(s : GeodistmanhattanSlice) -> Double { @_common.mean(s.data) }

pub fn geo_dist_manhattan_slice_scale(s : GeodistmanhattanSlice, f : Double) -> GeodistmanhattanSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_manhattan_slice_add(a : GeodistmanhattanSlice, b : GeodistmanhattanSlice) -> GeodistmanhattanSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_manhattan_slice_copy(s : GeodistmanhattanSlice) -> GeodistmanhattanSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_manhattan_slice_fill(s : GeodistmanhattanSlice, v : Double) -> GeodistmanhattanSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_manhattan_slice_min(s : GeodistmanhattanSlice) -> Double { @_common.min(s.data) }

pub fn geo_dist_manhattan_slice_max(s : GeodistmanhattanSlice) -> Double { @_common.max(s.data) }

pub fn geo_dist_manhattan_slice_to_string(s : GeodistmanhattanSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


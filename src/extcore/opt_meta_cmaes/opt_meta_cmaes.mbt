///===
/// extcore/opt_meta_cmaes

pub(all) struct OptmetacmaesPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn opt_meta_cmaes_make_point(x : Double, y : Double) -> OptmetacmaesPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn opt_meta_cmaes_make_point3(x : Double, y : Double, z : Double) -> OptmetacmaesPoint {
  { x, y, z, label: 0 }
}

pub fn opt_meta_cmaes_point_x(pt : OptmetacmaesPoint) -> Double { pt.x }

pub fn opt_meta_cmaes_point_y(pt : OptmetacmaesPoint) -> Double { pt.y }

pub fn opt_meta_cmaes_point_z(pt : OptmetacmaesPoint) -> Double { pt.z }

pub fn opt_meta_cmaes_point_label(pt : OptmetacmaesPoint) -> Int { pt.label }

pub fn opt_meta_cmaes_point_dist(a : OptmetacmaesPoint, b : OptmetacmaesPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn opt_meta_cmaes_point_add(a : OptmetacmaesPoint, b : OptmetacmaesPoint) -> OptmetacmaesPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn opt_meta_cmaes_point_sub(a : OptmetacmaesPoint, b : OptmetacmaesPoint) -> OptmetacmaesPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn opt_meta_cmaes_point_scale(pt : OptmetacmaesPoint, s : Double) -> OptmetacmaesPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn opt_meta_cmaes_point_dot(a : OptmetacmaesPoint, b : OptmetacmaesPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn opt_meta_cmaes_point_cross(a : OptmetacmaesPoint, b : OptmetacmaesPoint) -> OptmetacmaesPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn opt_meta_cmaes_point_norm(pt : OptmetacmaesPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn opt_meta_cmaes_point_normalize(pt : OptmetacmaesPoint) -> OptmetacmaesPoint {
  let n = opt_meta_cmaes_point_norm(pt)
  if n < 0.0000001 { pt } else { opt_meta_cmaes_point_scale(pt, 1.0 / n) }
}

pub fn opt_meta_cmaes_point_negate(pt : OptmetacmaesPoint) -> OptmetacmaesPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn opt_meta_cmaes_point_mid(a : OptmetacmaesPoint, b : OptmetacmaesPoint) -> OptmetacmaesPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn opt_meta_cmaes_point_lerp(a : OptmetacmaesPoint, b : OptmetacmaesPoint, t : Double) -> OptmetacmaesPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn opt_meta_cmaes_point_to_string(pt : OptmetacmaesPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct OptmetacmaesSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn opt_meta_cmaes_make_series(vals : Array[Double], name : String) -> OptmetacmaesSeries {
  { vals, name, meta: 0 }
}

pub fn opt_meta_cmaes_series_len(s : OptmetacmaesSeries) -> Int { s.vals.length() }

pub fn opt_meta_cmaes_series_sum(s : OptmetacmaesSeries) -> Double { @_common.sum(s.vals) }

pub fn opt_meta_cmaes_series_mean(s : OptmetacmaesSeries) -> Double { @_common.mean(s.vals) }

pub fn opt_meta_cmaes_series_min(s : OptmetacmaesSeries) -> Double { @_common.min(s.vals) }

pub fn opt_meta_cmaes_series_max(s : OptmetacmaesSeries) -> Double { @_common.max(s.vals) }

pub fn opt_meta_cmaes_series_range(s : OptmetacmaesSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn opt_meta_cmaes_series_var(s : OptmetacmaesSeries) -> Double { @_common.variance(s.vals) }

pub fn opt_meta_cmaes_series_std(s : OptmetacmaesSeries) -> Double { @_common.std(s.vals) }

pub fn opt_meta_cmaes_series_median(s : OptmetacmaesSeries) -> Double { @_common.median(s.vals) }

pub fn opt_meta_cmaes_series_scale(s : OptmetacmaesSeries, f : Double) -> OptmetacmaesSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn opt_meta_cmaes_series_add(a : OptmetacmaesSeries, b : OptmetacmaesSeries) -> OptmetacmaesSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn opt_meta_cmaes_series_sub(a : OptmetacmaesSeries, b : OptmetacmaesSeries) -> OptmetacmaesSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn opt_meta_cmaes_series_normalize(s : OptmetacmaesSeries) -> OptmetacmaesSeries {
  let mn = opt_meta_cmaes_series_min(s)
  let mx = opt_meta_cmaes_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn opt_meta_cmaes_series_cumsum(s : OptmetacmaesSeries) -> OptmetacmaesSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn opt_meta_cmaes_series_to_string(s : OptmetacmaesSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct OptmetacmaesMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn opt_meta_cmaes_make_matrix(rows : Int, cols : Int, val : Double) -> OptmetacmaesMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn opt_meta_cmaes_matrix_identity(n : Int) -> OptmetacmaesMatrix {
  let m = opt_meta_cmaes_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn opt_meta_cmaes_matrix_get(m : OptmetacmaesMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn opt_meta_cmaes_matrix_transpose(m : OptmetacmaesMatrix) -> OptmetacmaesMatrix {
  let result = opt_meta_cmaes_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn opt_meta_cmaes_matrix_add(a : OptmetacmaesMatrix, b : OptmetacmaesMatrix) -> OptmetacmaesMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = opt_meta_cmaes_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn opt_meta_cmaes_matrix_scale(m : OptmetacmaesMatrix, s : Double) -> OptmetacmaesMatrix {
  let result = opt_meta_cmaes_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn opt_meta_cmaes_matrix_multiply(a : OptmetacmaesMatrix, b : OptmetacmaesMatrix) -> OptmetacmaesMatrix {
  if a.cols != b.rows { return opt_meta_cmaes_make_matrix(a.rows, b.cols, 0.0) }
  let result = opt_meta_cmaes_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn opt_meta_cmaes_matrix_trace(m : OptmetacmaesMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn opt_meta_cmaes_matrix_det(m : OptmetacmaesMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn opt_meta_cmaes_matrix_norm(m : OptmetacmaesMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn opt_meta_cmaes_matrix_to_string(m : OptmetacmaesMatrix) -> String {
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

pub(all) struct OptmetacmaesVector {
  comps : Array[Double]
  dim : Int
}

pub fn opt_meta_cmaes_make_vector(comps : Array[Double]) -> OptmetacmaesVector {
  { comps, dim: comps.length() }
}

pub fn opt_meta_cmaes_vector_zero(dim : Int) -> OptmetacmaesVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn opt_meta_cmaes_vector_add(a : OptmetacmaesVector, b : OptmetacmaesVector) -> OptmetacmaesVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn opt_meta_cmaes_vector_sub(a : OptmetacmaesVector, b : OptmetacmaesVector) -> OptmetacmaesVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn opt_meta_cmaes_vector_scale(v : OptmetacmaesVector, s : Double) -> OptmetacmaesVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn opt_meta_cmaes_vector_dot(a : OptmetacmaesVector, b : OptmetacmaesVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn opt_meta_cmaes_vector_norm(v : OptmetacmaesVector) -> Double { @_common.sqrt(opt_meta_cmaes_vector_dot(v, v)) }

pub fn opt_meta_cmaes_vector_normalize(v : OptmetacmaesVector) -> OptmetacmaesVector {
  let n = opt_meta_cmaes_vector_norm(v)
  if n < 0.0000001 { v } else { opt_meta_cmaes_vector_scale(v, 1.0 / n) }
}

pub fn opt_meta_cmaes_vector_dist(a : OptmetacmaesVector, b : OptmetacmaesVector) -> Double {
  opt_meta_cmaes_vector_norm(opt_meta_cmaes_vector_sub(a, b))
}

pub fn opt_meta_cmaes_vector_to_string(v : OptmetacmaesVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn opt_meta_cmaes_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn opt_meta_cmaes_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn opt_meta_cmaes_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn opt_meta_cmaes_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn opt_meta_cmaes_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn opt_meta_cmaes_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn opt_meta_cmaes_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn opt_meta_cmaes_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn opt_meta_cmaes_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn opt_meta_cmaes_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn opt_meta_cmaes_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn opt_meta_cmaes_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn opt_meta_cmaes_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn opt_meta_cmaes_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn opt_meta_cmaes_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn opt_meta_cmaes_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn opt_meta_cmaes_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn opt_meta_cmaes_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn opt_meta_cmaes_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn opt_meta_cmaes_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn opt_meta_cmaes_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn opt_meta_cmaes_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn opt_meta_cmaes_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn opt_meta_cmaes_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn opt_meta_cmaes_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn opt_meta_cmaes_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn opt_meta_cmaes_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn opt_meta_cmaes_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn opt_meta_cmaes_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct OptmetacmaesFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_cmaes_frame_make(size : Int) -> OptmetacmaesFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_cmaes_frame_len(s : OptmetacmaesFrame) -> Int { s.size }

pub fn opt_meta_cmaes_frame_get(s : OptmetacmaesFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_cmaes_frame_set(s : OptmetacmaesFrame, i : Int, v : Double) -> OptmetacmaesFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_frame_sum(s : OptmetacmaesFrame) -> Double { @_common.sum(s.data) }

pub fn opt_meta_cmaes_frame_mean(s : OptmetacmaesFrame) -> Double { @_common.mean(s.data) }

pub fn opt_meta_cmaes_frame_scale(s : OptmetacmaesFrame, f : Double) -> OptmetacmaesFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_frame_add(a : OptmetacmaesFrame, b : OptmetacmaesFrame) -> OptmetacmaesFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_cmaes_frame_copy(s : OptmetacmaesFrame) -> OptmetacmaesFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_frame_fill(s : OptmetacmaesFrame, v : Double) -> OptmetacmaesFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_frame_min(s : OptmetacmaesFrame) -> Double { @_common.min(s.data) }

pub fn opt_meta_cmaes_frame_max(s : OptmetacmaesFrame) -> Double { @_common.max(s.data) }

pub fn opt_meta_cmaes_frame_to_string(s : OptmetacmaesFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetacmaesTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_cmaes_table_make(size : Int) -> OptmetacmaesTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_cmaes_table_len(s : OptmetacmaesTable) -> Int { s.size }

pub fn opt_meta_cmaes_table_get(s : OptmetacmaesTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_cmaes_table_set(s : OptmetacmaesTable, i : Int, v : Double) -> OptmetacmaesTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_table_sum(s : OptmetacmaesTable) -> Double { @_common.sum(s.data) }

pub fn opt_meta_cmaes_table_mean(s : OptmetacmaesTable) -> Double { @_common.mean(s.data) }

pub fn opt_meta_cmaes_table_scale(s : OptmetacmaesTable, f : Double) -> OptmetacmaesTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_table_add(a : OptmetacmaesTable, b : OptmetacmaesTable) -> OptmetacmaesTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_cmaes_table_copy(s : OptmetacmaesTable) -> OptmetacmaesTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_table_fill(s : OptmetacmaesTable, v : Double) -> OptmetacmaesTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_table_min(s : OptmetacmaesTable) -> Double { @_common.min(s.data) }

pub fn opt_meta_cmaes_table_max(s : OptmetacmaesTable) -> Double { @_common.max(s.data) }

pub fn opt_meta_cmaes_table_to_string(s : OptmetacmaesTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetacmaesGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_cmaes_graphn_make(size : Int) -> OptmetacmaesGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_cmaes_graphn_len(s : OptmetacmaesGraphN) -> Int { s.size }

pub fn opt_meta_cmaes_graphn_get(s : OptmetacmaesGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_cmaes_graphn_set(s : OptmetacmaesGraphN, i : Int, v : Double) -> OptmetacmaesGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_graphn_sum(s : OptmetacmaesGraphN) -> Double { @_common.sum(s.data) }

pub fn opt_meta_cmaes_graphn_mean(s : OptmetacmaesGraphN) -> Double { @_common.mean(s.data) }

pub fn opt_meta_cmaes_graphn_scale(s : OptmetacmaesGraphN, f : Double) -> OptmetacmaesGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_graphn_add(a : OptmetacmaesGraphN, b : OptmetacmaesGraphN) -> OptmetacmaesGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_cmaes_graphn_copy(s : OptmetacmaesGraphN) -> OptmetacmaesGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_graphn_fill(s : OptmetacmaesGraphN, v : Double) -> OptmetacmaesGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_graphn_min(s : OptmetacmaesGraphN) -> Double { @_common.min(s.data) }

pub fn opt_meta_cmaes_graphn_max(s : OptmetacmaesGraphN) -> Double { @_common.max(s.data) }

pub fn opt_meta_cmaes_graphn_to_string(s : OptmetacmaesGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetacmaesNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_cmaes_node_make(size : Int) -> OptmetacmaesNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_cmaes_node_len(s : OptmetacmaesNode) -> Int { s.size }

pub fn opt_meta_cmaes_node_get(s : OptmetacmaesNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_cmaes_node_set(s : OptmetacmaesNode, i : Int, v : Double) -> OptmetacmaesNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_node_sum(s : OptmetacmaesNode) -> Double { @_common.sum(s.data) }

pub fn opt_meta_cmaes_node_mean(s : OptmetacmaesNode) -> Double { @_common.mean(s.data) }

pub fn opt_meta_cmaes_node_scale(s : OptmetacmaesNode, f : Double) -> OptmetacmaesNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_node_add(a : OptmetacmaesNode, b : OptmetacmaesNode) -> OptmetacmaesNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_cmaes_node_copy(s : OptmetacmaesNode) -> OptmetacmaesNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_node_fill(s : OptmetacmaesNode, v : Double) -> OptmetacmaesNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_node_min(s : OptmetacmaesNode) -> Double { @_common.min(s.data) }

pub fn opt_meta_cmaes_node_max(s : OptmetacmaesNode) -> Double { @_common.max(s.data) }

pub fn opt_meta_cmaes_node_to_string(s : OptmetacmaesNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetacmaesEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_cmaes_edge_make(size : Int) -> OptmetacmaesEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_cmaes_edge_len(s : OptmetacmaesEdge) -> Int { s.size }

pub fn opt_meta_cmaes_edge_get(s : OptmetacmaesEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_cmaes_edge_set(s : OptmetacmaesEdge, i : Int, v : Double) -> OptmetacmaesEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_edge_sum(s : OptmetacmaesEdge) -> Double { @_common.sum(s.data) }

pub fn opt_meta_cmaes_edge_mean(s : OptmetacmaesEdge) -> Double { @_common.mean(s.data) }

pub fn opt_meta_cmaes_edge_scale(s : OptmetacmaesEdge, f : Double) -> OptmetacmaesEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_edge_add(a : OptmetacmaesEdge, b : OptmetacmaesEdge) -> OptmetacmaesEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_cmaes_edge_copy(s : OptmetacmaesEdge) -> OptmetacmaesEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_edge_fill(s : OptmetacmaesEdge, v : Double) -> OptmetacmaesEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_edge_min(s : OptmetacmaesEdge) -> Double { @_common.min(s.data) }

pub fn opt_meta_cmaes_edge_max(s : OptmetacmaesEdge) -> Double { @_common.max(s.data) }

pub fn opt_meta_cmaes_edge_to_string(s : OptmetacmaesEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetacmaesPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_cmaes_path_make(size : Int) -> OptmetacmaesPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_cmaes_path_len(s : OptmetacmaesPath) -> Int { s.size }

pub fn opt_meta_cmaes_path_get(s : OptmetacmaesPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_cmaes_path_set(s : OptmetacmaesPath, i : Int, v : Double) -> OptmetacmaesPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_path_sum(s : OptmetacmaesPath) -> Double { @_common.sum(s.data) }

pub fn opt_meta_cmaes_path_mean(s : OptmetacmaesPath) -> Double { @_common.mean(s.data) }

pub fn opt_meta_cmaes_path_scale(s : OptmetacmaesPath, f : Double) -> OptmetacmaesPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_path_add(a : OptmetacmaesPath, b : OptmetacmaesPath) -> OptmetacmaesPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_cmaes_path_copy(s : OptmetacmaesPath) -> OptmetacmaesPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_path_fill(s : OptmetacmaesPath, v : Double) -> OptmetacmaesPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_path_min(s : OptmetacmaesPath) -> Double { @_common.min(s.data) }

pub fn opt_meta_cmaes_path_max(s : OptmetacmaesPath) -> Double { @_common.max(s.data) }

pub fn opt_meta_cmaes_path_to_string(s : OptmetacmaesPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetacmaesCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_cmaes_cluster_make(size : Int) -> OptmetacmaesCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_cmaes_cluster_len(s : OptmetacmaesCluster) -> Int { s.size }

pub fn opt_meta_cmaes_cluster_get(s : OptmetacmaesCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_cmaes_cluster_set(s : OptmetacmaesCluster, i : Int, v : Double) -> OptmetacmaesCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_cluster_sum(s : OptmetacmaesCluster) -> Double { @_common.sum(s.data) }

pub fn opt_meta_cmaes_cluster_mean(s : OptmetacmaesCluster) -> Double { @_common.mean(s.data) }

pub fn opt_meta_cmaes_cluster_scale(s : OptmetacmaesCluster, f : Double) -> OptmetacmaesCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_cluster_add(a : OptmetacmaesCluster, b : OptmetacmaesCluster) -> OptmetacmaesCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_cmaes_cluster_copy(s : OptmetacmaesCluster) -> OptmetacmaesCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_cluster_fill(s : OptmetacmaesCluster, v : Double) -> OptmetacmaesCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_cluster_min(s : OptmetacmaesCluster) -> Double { @_common.min(s.data) }

pub fn opt_meta_cmaes_cluster_max(s : OptmetacmaesCluster) -> Double { @_common.max(s.data) }

pub fn opt_meta_cmaes_cluster_to_string(s : OptmetacmaesCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetacmaesModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_cmaes_model_make(size : Int) -> OptmetacmaesModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_cmaes_model_len(s : OptmetacmaesModel) -> Int { s.size }

pub fn opt_meta_cmaes_model_get(s : OptmetacmaesModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_cmaes_model_set(s : OptmetacmaesModel, i : Int, v : Double) -> OptmetacmaesModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_model_sum(s : OptmetacmaesModel) -> Double { @_common.sum(s.data) }

pub fn opt_meta_cmaes_model_mean(s : OptmetacmaesModel) -> Double { @_common.mean(s.data) }

pub fn opt_meta_cmaes_model_scale(s : OptmetacmaesModel, f : Double) -> OptmetacmaesModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_model_add(a : OptmetacmaesModel, b : OptmetacmaesModel) -> OptmetacmaesModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_cmaes_model_copy(s : OptmetacmaesModel) -> OptmetacmaesModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_model_fill(s : OptmetacmaesModel, v : Double) -> OptmetacmaesModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_model_min(s : OptmetacmaesModel) -> Double { @_common.min(s.data) }

pub fn opt_meta_cmaes_model_max(s : OptmetacmaesModel) -> Double { @_common.max(s.data) }

pub fn opt_meta_cmaes_model_to_string(s : OptmetacmaesModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetacmaesLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_cmaes_layer_make(size : Int) -> OptmetacmaesLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_cmaes_layer_len(s : OptmetacmaesLayer) -> Int { s.size }

pub fn opt_meta_cmaes_layer_get(s : OptmetacmaesLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_cmaes_layer_set(s : OptmetacmaesLayer, i : Int, v : Double) -> OptmetacmaesLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_layer_sum(s : OptmetacmaesLayer) -> Double { @_common.sum(s.data) }

pub fn opt_meta_cmaes_layer_mean(s : OptmetacmaesLayer) -> Double { @_common.mean(s.data) }

pub fn opt_meta_cmaes_layer_scale(s : OptmetacmaesLayer, f : Double) -> OptmetacmaesLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_layer_add(a : OptmetacmaesLayer, b : OptmetacmaesLayer) -> OptmetacmaesLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_cmaes_layer_copy(s : OptmetacmaesLayer) -> OptmetacmaesLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_layer_fill(s : OptmetacmaesLayer, v : Double) -> OptmetacmaesLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_layer_min(s : OptmetacmaesLayer) -> Double { @_common.min(s.data) }

pub fn opt_meta_cmaes_layer_max(s : OptmetacmaesLayer) -> Double { @_common.max(s.data) }

pub fn opt_meta_cmaes_layer_to_string(s : OptmetacmaesLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetacmaesBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_cmaes_buffer_make(size : Int) -> OptmetacmaesBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_cmaes_buffer_len(s : OptmetacmaesBuffer) -> Int { s.size }

pub fn opt_meta_cmaes_buffer_get(s : OptmetacmaesBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_cmaes_buffer_set(s : OptmetacmaesBuffer, i : Int, v : Double) -> OptmetacmaesBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_buffer_sum(s : OptmetacmaesBuffer) -> Double { @_common.sum(s.data) }

pub fn opt_meta_cmaes_buffer_mean(s : OptmetacmaesBuffer) -> Double { @_common.mean(s.data) }

pub fn opt_meta_cmaes_buffer_scale(s : OptmetacmaesBuffer, f : Double) -> OptmetacmaesBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_buffer_add(a : OptmetacmaesBuffer, b : OptmetacmaesBuffer) -> OptmetacmaesBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_cmaes_buffer_copy(s : OptmetacmaesBuffer) -> OptmetacmaesBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_buffer_fill(s : OptmetacmaesBuffer, v : Double) -> OptmetacmaesBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_buffer_min(s : OptmetacmaesBuffer) -> Double { @_common.min(s.data) }

pub fn opt_meta_cmaes_buffer_max(s : OptmetacmaesBuffer) -> Double { @_common.max(s.data) }

pub fn opt_meta_cmaes_buffer_to_string(s : OptmetacmaesBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetacmaesCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_cmaes_cursor_make(size : Int) -> OptmetacmaesCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_cmaes_cursor_len(s : OptmetacmaesCursor) -> Int { s.size }

pub fn opt_meta_cmaes_cursor_get(s : OptmetacmaesCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_cmaes_cursor_set(s : OptmetacmaesCursor, i : Int, v : Double) -> OptmetacmaesCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_cursor_sum(s : OptmetacmaesCursor) -> Double { @_common.sum(s.data) }

pub fn opt_meta_cmaes_cursor_mean(s : OptmetacmaesCursor) -> Double { @_common.mean(s.data) }

pub fn opt_meta_cmaes_cursor_scale(s : OptmetacmaesCursor, f : Double) -> OptmetacmaesCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_cursor_add(a : OptmetacmaesCursor, b : OptmetacmaesCursor) -> OptmetacmaesCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_cmaes_cursor_copy(s : OptmetacmaesCursor) -> OptmetacmaesCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_cursor_fill(s : OptmetacmaesCursor, v : Double) -> OptmetacmaesCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_cursor_min(s : OptmetacmaesCursor) -> Double { @_common.min(s.data) }

pub fn opt_meta_cmaes_cursor_max(s : OptmetacmaesCursor) -> Double { @_common.max(s.data) }

pub fn opt_meta_cmaes_cursor_to_string(s : OptmetacmaesCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetacmaesView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_cmaes_view_make(size : Int) -> OptmetacmaesView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_cmaes_view_len(s : OptmetacmaesView) -> Int { s.size }

pub fn opt_meta_cmaes_view_get(s : OptmetacmaesView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_cmaes_view_set(s : OptmetacmaesView, i : Int, v : Double) -> OptmetacmaesView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_view_sum(s : OptmetacmaesView) -> Double { @_common.sum(s.data) }

pub fn opt_meta_cmaes_view_mean(s : OptmetacmaesView) -> Double { @_common.mean(s.data) }

pub fn opt_meta_cmaes_view_scale(s : OptmetacmaesView, f : Double) -> OptmetacmaesView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_view_add(a : OptmetacmaesView, b : OptmetacmaesView) -> OptmetacmaesView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_cmaes_view_copy(s : OptmetacmaesView) -> OptmetacmaesView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_view_fill(s : OptmetacmaesView, v : Double) -> OptmetacmaesView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_view_min(s : OptmetacmaesView) -> Double { @_common.min(s.data) }

pub fn opt_meta_cmaes_view_max(s : OptmetacmaesView) -> Double { @_common.max(s.data) }

pub fn opt_meta_cmaes_view_to_string(s : OptmetacmaesView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetacmaesRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_cmaes_range_make(size : Int) -> OptmetacmaesRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_cmaes_range_len(s : OptmetacmaesRange) -> Int { s.size }

pub fn opt_meta_cmaes_range_get(s : OptmetacmaesRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_cmaes_range_set(s : OptmetacmaesRange, i : Int, v : Double) -> OptmetacmaesRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_range_sum(s : OptmetacmaesRange) -> Double { @_common.sum(s.data) }

pub fn opt_meta_cmaes_range_mean(s : OptmetacmaesRange) -> Double { @_common.mean(s.data) }

pub fn opt_meta_cmaes_range_scale(s : OptmetacmaesRange, f : Double) -> OptmetacmaesRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_range_add(a : OptmetacmaesRange, b : OptmetacmaesRange) -> OptmetacmaesRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_cmaes_range_copy(s : OptmetacmaesRange) -> OptmetacmaesRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_range_fill(s : OptmetacmaesRange, v : Double) -> OptmetacmaesRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_range_min(s : OptmetacmaesRange) -> Double { @_common.min(s.data) }

pub fn opt_meta_cmaes_range_max(s : OptmetacmaesRange) -> Double { @_common.max(s.data) }

pub fn opt_meta_cmaes_range_to_string(s : OptmetacmaesRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetacmaesSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_cmaes_slice_make(size : Int) -> OptmetacmaesSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_cmaes_slice_len(s : OptmetacmaesSlice) -> Int { s.size }

pub fn opt_meta_cmaes_slice_get(s : OptmetacmaesSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_cmaes_slice_set(s : OptmetacmaesSlice, i : Int, v : Double) -> OptmetacmaesSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_slice_sum(s : OptmetacmaesSlice) -> Double { @_common.sum(s.data) }

pub fn opt_meta_cmaes_slice_mean(s : OptmetacmaesSlice) -> Double { @_common.mean(s.data) }

pub fn opt_meta_cmaes_slice_scale(s : OptmetacmaesSlice, f : Double) -> OptmetacmaesSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_slice_add(a : OptmetacmaesSlice, b : OptmetacmaesSlice) -> OptmetacmaesSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_cmaes_slice_copy(s : OptmetacmaesSlice) -> OptmetacmaesSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_slice_fill(s : OptmetacmaesSlice, v : Double) -> OptmetacmaesSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_cmaes_slice_min(s : OptmetacmaesSlice) -> Double { @_common.min(s.data) }

pub fn opt_meta_cmaes_slice_max(s : OptmetacmaesSlice) -> Double { @_common.max(s.data) }

pub fn opt_meta_cmaes_slice_to_string(s : OptmetacmaesSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


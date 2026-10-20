///===
/// extcore/timeseries_sarima

pub(all) struct TimeseriessarimaPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_sarima_make_point(x : Double, y : Double) -> TimeseriessarimaPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_sarima_make_point3(x : Double, y : Double, z : Double) -> TimeseriessarimaPoint {
  { x, y, z, label: 0 }
}

pub fn timeseries_sarima_point_x(pt : TimeseriessarimaPoint) -> Double { pt.x }

pub fn timeseries_sarima_point_y(pt : TimeseriessarimaPoint) -> Double { pt.y }

pub fn timeseries_sarima_point_z(pt : TimeseriessarimaPoint) -> Double { pt.z }

pub fn timeseries_sarima_point_label(pt : TimeseriessarimaPoint) -> Int { pt.label }

pub fn timeseries_sarima_point_dist(a : TimeseriessarimaPoint, b : TimeseriessarimaPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn timeseries_sarima_point_add(a : TimeseriessarimaPoint, b : TimeseriessarimaPoint) -> TimeseriessarimaPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn timeseries_sarima_point_sub(a : TimeseriessarimaPoint, b : TimeseriessarimaPoint) -> TimeseriessarimaPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn timeseries_sarima_point_scale(pt : TimeseriessarimaPoint, s : Double) -> TimeseriessarimaPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn timeseries_sarima_point_dot(a : TimeseriessarimaPoint, b : TimeseriessarimaPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn timeseries_sarima_point_cross(a : TimeseriessarimaPoint, b : TimeseriessarimaPoint) -> TimeseriessarimaPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn timeseries_sarima_point_norm(pt : TimeseriessarimaPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn timeseries_sarima_point_normalize(pt : TimeseriessarimaPoint) -> TimeseriessarimaPoint {
  let n = timeseries_sarima_point_norm(pt)
  if n < 0.0000001 { pt } else { timeseries_sarima_point_scale(pt, 1.0 / n) }
}

pub fn timeseries_sarima_point_negate(pt : TimeseriessarimaPoint) -> TimeseriessarimaPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn timeseries_sarima_point_mid(a : TimeseriessarimaPoint, b : TimeseriessarimaPoint) -> TimeseriessarimaPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn timeseries_sarima_point_lerp(a : TimeseriessarimaPoint, b : TimeseriessarimaPoint, t : Double) -> TimeseriessarimaPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn timeseries_sarima_point_to_string(pt : TimeseriessarimaPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct TimeseriessarimaSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_sarima_make_series(vals : Array[Double], name : String) -> TimeseriessarimaSeries {
  { vals, name, meta: 0 }
}

pub fn timeseries_sarima_series_len(s : TimeseriessarimaSeries) -> Int { s.vals.length() }

pub fn timeseries_sarima_series_sum(s : TimeseriessarimaSeries) -> Double { @_common.sum(s.vals) }

pub fn timeseries_sarima_series_mean(s : TimeseriessarimaSeries) -> Double { @_common.mean(s.vals) }

pub fn timeseries_sarima_series_min(s : TimeseriessarimaSeries) -> Double { @_common.min(s.vals) }

pub fn timeseries_sarima_series_max(s : TimeseriessarimaSeries) -> Double { @_common.max(s.vals) }

pub fn timeseries_sarima_series_range(s : TimeseriessarimaSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn timeseries_sarima_series_var(s : TimeseriessarimaSeries) -> Double { @_common.variance(s.vals) }

pub fn timeseries_sarima_series_std(s : TimeseriessarimaSeries) -> Double { @_common.std(s.vals) }

pub fn timeseries_sarima_series_median(s : TimeseriessarimaSeries) -> Double { @_common.median(s.vals) }

pub fn timeseries_sarima_series_scale(s : TimeseriessarimaSeries, f : Double) -> TimeseriessarimaSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn timeseries_sarima_series_add(a : TimeseriessarimaSeries, b : TimeseriessarimaSeries) -> TimeseriessarimaSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn timeseries_sarima_series_sub(a : TimeseriessarimaSeries, b : TimeseriessarimaSeries) -> TimeseriessarimaSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn timeseries_sarima_series_normalize(s : TimeseriessarimaSeries) -> TimeseriessarimaSeries {
  let mn = timeseries_sarima_series_min(s)
  let mx = timeseries_sarima_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn timeseries_sarima_series_cumsum(s : TimeseriessarimaSeries) -> TimeseriessarimaSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn timeseries_sarima_series_to_string(s : TimeseriessarimaSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriessarimaMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_sarima_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriessarimaMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn timeseries_sarima_matrix_identity(n : Int) -> TimeseriessarimaMatrix {
  let m = timeseries_sarima_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn timeseries_sarima_matrix_get(m : TimeseriessarimaMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn timeseries_sarima_matrix_transpose(m : TimeseriessarimaMatrix) -> TimeseriessarimaMatrix {
  let result = timeseries_sarima_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn timeseries_sarima_matrix_add(a : TimeseriessarimaMatrix, b : TimeseriessarimaMatrix) -> TimeseriessarimaMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = timeseries_sarima_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn timeseries_sarima_matrix_scale(m : TimeseriessarimaMatrix, s : Double) -> TimeseriessarimaMatrix {
  let result = timeseries_sarima_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn timeseries_sarima_matrix_multiply(a : TimeseriessarimaMatrix, b : TimeseriessarimaMatrix) -> TimeseriessarimaMatrix {
  if a.cols != b.rows { return timeseries_sarima_make_matrix(a.rows, b.cols, 0.0) }
  let result = timeseries_sarima_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn timeseries_sarima_matrix_trace(m : TimeseriessarimaMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn timeseries_sarima_matrix_det(m : TimeseriessarimaMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn timeseries_sarima_matrix_norm(m : TimeseriessarimaMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn timeseries_sarima_matrix_to_string(m : TimeseriessarimaMatrix) -> String {
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

pub(all) struct TimeseriessarimaVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_sarima_make_vector(comps : Array[Double]) -> TimeseriessarimaVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_sarima_vector_zero(dim : Int) -> TimeseriessarimaVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn timeseries_sarima_vector_add(a : TimeseriessarimaVector, b : TimeseriessarimaVector) -> TimeseriessarimaVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn timeseries_sarima_vector_sub(a : TimeseriessarimaVector, b : TimeseriessarimaVector) -> TimeseriessarimaVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn timeseries_sarima_vector_scale(v : TimeseriessarimaVector, s : Double) -> TimeseriessarimaVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn timeseries_sarima_vector_dot(a : TimeseriessarimaVector, b : TimeseriessarimaVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn timeseries_sarima_vector_norm(v : TimeseriessarimaVector) -> Double { @_common.sqrt(timeseries_sarima_vector_dot(v, v)) }

pub fn timeseries_sarima_vector_normalize(v : TimeseriessarimaVector) -> TimeseriessarimaVector {
  let n = timeseries_sarima_vector_norm(v)
  if n < 0.0000001 { v } else { timeseries_sarima_vector_scale(v, 1.0 / n) }
}

pub fn timeseries_sarima_vector_dist(a : TimeseriessarimaVector, b : TimeseriessarimaVector) -> Double {
  timeseries_sarima_vector_norm(timeseries_sarima_vector_sub(a, b))
}

pub fn timeseries_sarima_vector_to_string(v : TimeseriessarimaVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn timeseries_sarima_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn timeseries_sarima_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn timeseries_sarima_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn timeseries_sarima_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn timeseries_sarima_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn timeseries_sarima_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn timeseries_sarima_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn timeseries_sarima_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn timeseries_sarima_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn timeseries_sarima_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn timeseries_sarima_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn timeseries_sarima_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn timeseries_sarima_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn timeseries_sarima_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn timeseries_sarima_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn timeseries_sarima_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn timeseries_sarima_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn timeseries_sarima_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn timeseries_sarima_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn timeseries_sarima_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn timeseries_sarima_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn timeseries_sarima_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn timeseries_sarima_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn timeseries_sarima_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn timeseries_sarima_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn timeseries_sarima_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn timeseries_sarima_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn timeseries_sarima_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn timeseries_sarima_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct TimeseriessarimaFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_sarima_frame_make(size : Int) -> TimeseriessarimaFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_sarima_frame_len(s : TimeseriessarimaFrame) -> Int { s.size }

pub fn timeseries_sarima_frame_get(s : TimeseriessarimaFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_sarima_frame_set(s : TimeseriessarimaFrame, i : Int, v : Double) -> TimeseriessarimaFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_frame_sum(s : TimeseriessarimaFrame) -> Double { @_common.sum(s.data) }

pub fn timeseries_sarima_frame_mean(s : TimeseriessarimaFrame) -> Double { @_common.mean(s.data) }

pub fn timeseries_sarima_frame_scale(s : TimeseriessarimaFrame, f : Double) -> TimeseriessarimaFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_frame_add(a : TimeseriessarimaFrame, b : TimeseriessarimaFrame) -> TimeseriessarimaFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_sarima_frame_copy(s : TimeseriessarimaFrame) -> TimeseriessarimaFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_frame_fill(s : TimeseriessarimaFrame, v : Double) -> TimeseriessarimaFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_frame_min(s : TimeseriessarimaFrame) -> Double { @_common.min(s.data) }

pub fn timeseries_sarima_frame_max(s : TimeseriessarimaFrame) -> Double { @_common.max(s.data) }

pub fn timeseries_sarima_frame_to_string(s : TimeseriessarimaFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriessarimaTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_sarima_table_make(size : Int) -> TimeseriessarimaTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_sarima_table_len(s : TimeseriessarimaTable) -> Int { s.size }

pub fn timeseries_sarima_table_get(s : TimeseriessarimaTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_sarima_table_set(s : TimeseriessarimaTable, i : Int, v : Double) -> TimeseriessarimaTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_table_sum(s : TimeseriessarimaTable) -> Double { @_common.sum(s.data) }

pub fn timeseries_sarima_table_mean(s : TimeseriessarimaTable) -> Double { @_common.mean(s.data) }

pub fn timeseries_sarima_table_scale(s : TimeseriessarimaTable, f : Double) -> TimeseriessarimaTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_table_add(a : TimeseriessarimaTable, b : TimeseriessarimaTable) -> TimeseriessarimaTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_sarima_table_copy(s : TimeseriessarimaTable) -> TimeseriessarimaTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_table_fill(s : TimeseriessarimaTable, v : Double) -> TimeseriessarimaTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_table_min(s : TimeseriessarimaTable) -> Double { @_common.min(s.data) }

pub fn timeseries_sarima_table_max(s : TimeseriessarimaTable) -> Double { @_common.max(s.data) }

pub fn timeseries_sarima_table_to_string(s : TimeseriessarimaTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriessarimaGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_sarima_graphn_make(size : Int) -> TimeseriessarimaGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_sarima_graphn_len(s : TimeseriessarimaGraphN) -> Int { s.size }

pub fn timeseries_sarima_graphn_get(s : TimeseriessarimaGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_sarima_graphn_set(s : TimeseriessarimaGraphN, i : Int, v : Double) -> TimeseriessarimaGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_graphn_sum(s : TimeseriessarimaGraphN) -> Double { @_common.sum(s.data) }

pub fn timeseries_sarima_graphn_mean(s : TimeseriessarimaGraphN) -> Double { @_common.mean(s.data) }

pub fn timeseries_sarima_graphn_scale(s : TimeseriessarimaGraphN, f : Double) -> TimeseriessarimaGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_graphn_add(a : TimeseriessarimaGraphN, b : TimeseriessarimaGraphN) -> TimeseriessarimaGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_sarima_graphn_copy(s : TimeseriessarimaGraphN) -> TimeseriessarimaGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_graphn_fill(s : TimeseriessarimaGraphN, v : Double) -> TimeseriessarimaGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_graphn_min(s : TimeseriessarimaGraphN) -> Double { @_common.min(s.data) }

pub fn timeseries_sarima_graphn_max(s : TimeseriessarimaGraphN) -> Double { @_common.max(s.data) }

pub fn timeseries_sarima_graphn_to_string(s : TimeseriessarimaGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriessarimaNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_sarima_node_make(size : Int) -> TimeseriessarimaNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_sarima_node_len(s : TimeseriessarimaNode) -> Int { s.size }

pub fn timeseries_sarima_node_get(s : TimeseriessarimaNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_sarima_node_set(s : TimeseriessarimaNode, i : Int, v : Double) -> TimeseriessarimaNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_node_sum(s : TimeseriessarimaNode) -> Double { @_common.sum(s.data) }

pub fn timeseries_sarima_node_mean(s : TimeseriessarimaNode) -> Double { @_common.mean(s.data) }

pub fn timeseries_sarima_node_scale(s : TimeseriessarimaNode, f : Double) -> TimeseriessarimaNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_node_add(a : TimeseriessarimaNode, b : TimeseriessarimaNode) -> TimeseriessarimaNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_sarima_node_copy(s : TimeseriessarimaNode) -> TimeseriessarimaNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_node_fill(s : TimeseriessarimaNode, v : Double) -> TimeseriessarimaNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_node_min(s : TimeseriessarimaNode) -> Double { @_common.min(s.data) }

pub fn timeseries_sarima_node_max(s : TimeseriessarimaNode) -> Double { @_common.max(s.data) }

pub fn timeseries_sarima_node_to_string(s : TimeseriessarimaNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriessarimaEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_sarima_edge_make(size : Int) -> TimeseriessarimaEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_sarima_edge_len(s : TimeseriessarimaEdge) -> Int { s.size }

pub fn timeseries_sarima_edge_get(s : TimeseriessarimaEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_sarima_edge_set(s : TimeseriessarimaEdge, i : Int, v : Double) -> TimeseriessarimaEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_edge_sum(s : TimeseriessarimaEdge) -> Double { @_common.sum(s.data) }

pub fn timeseries_sarima_edge_mean(s : TimeseriessarimaEdge) -> Double { @_common.mean(s.data) }

pub fn timeseries_sarima_edge_scale(s : TimeseriessarimaEdge, f : Double) -> TimeseriessarimaEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_edge_add(a : TimeseriessarimaEdge, b : TimeseriessarimaEdge) -> TimeseriessarimaEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_sarima_edge_copy(s : TimeseriessarimaEdge) -> TimeseriessarimaEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_edge_fill(s : TimeseriessarimaEdge, v : Double) -> TimeseriessarimaEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_edge_min(s : TimeseriessarimaEdge) -> Double { @_common.min(s.data) }

pub fn timeseries_sarima_edge_max(s : TimeseriessarimaEdge) -> Double { @_common.max(s.data) }

pub fn timeseries_sarima_edge_to_string(s : TimeseriessarimaEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriessarimaPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_sarima_path_make(size : Int) -> TimeseriessarimaPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_sarima_path_len(s : TimeseriessarimaPath) -> Int { s.size }

pub fn timeseries_sarima_path_get(s : TimeseriessarimaPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_sarima_path_set(s : TimeseriessarimaPath, i : Int, v : Double) -> TimeseriessarimaPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_path_sum(s : TimeseriessarimaPath) -> Double { @_common.sum(s.data) }

pub fn timeseries_sarima_path_mean(s : TimeseriessarimaPath) -> Double { @_common.mean(s.data) }

pub fn timeseries_sarima_path_scale(s : TimeseriessarimaPath, f : Double) -> TimeseriessarimaPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_path_add(a : TimeseriessarimaPath, b : TimeseriessarimaPath) -> TimeseriessarimaPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_sarima_path_copy(s : TimeseriessarimaPath) -> TimeseriessarimaPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_path_fill(s : TimeseriessarimaPath, v : Double) -> TimeseriessarimaPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_path_min(s : TimeseriessarimaPath) -> Double { @_common.min(s.data) }

pub fn timeseries_sarima_path_max(s : TimeseriessarimaPath) -> Double { @_common.max(s.data) }

pub fn timeseries_sarima_path_to_string(s : TimeseriessarimaPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriessarimaCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_sarima_cluster_make(size : Int) -> TimeseriessarimaCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_sarima_cluster_len(s : TimeseriessarimaCluster) -> Int { s.size }

pub fn timeseries_sarima_cluster_get(s : TimeseriessarimaCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_sarima_cluster_set(s : TimeseriessarimaCluster, i : Int, v : Double) -> TimeseriessarimaCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_cluster_sum(s : TimeseriessarimaCluster) -> Double { @_common.sum(s.data) }

pub fn timeseries_sarima_cluster_mean(s : TimeseriessarimaCluster) -> Double { @_common.mean(s.data) }

pub fn timeseries_sarima_cluster_scale(s : TimeseriessarimaCluster, f : Double) -> TimeseriessarimaCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_cluster_add(a : TimeseriessarimaCluster, b : TimeseriessarimaCluster) -> TimeseriessarimaCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_sarima_cluster_copy(s : TimeseriessarimaCluster) -> TimeseriessarimaCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_cluster_fill(s : TimeseriessarimaCluster, v : Double) -> TimeseriessarimaCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_cluster_min(s : TimeseriessarimaCluster) -> Double { @_common.min(s.data) }

pub fn timeseries_sarima_cluster_max(s : TimeseriessarimaCluster) -> Double { @_common.max(s.data) }

pub fn timeseries_sarima_cluster_to_string(s : TimeseriessarimaCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriessarimaModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_sarima_model_make(size : Int) -> TimeseriessarimaModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_sarima_model_len(s : TimeseriessarimaModel) -> Int { s.size }

pub fn timeseries_sarima_model_get(s : TimeseriessarimaModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_sarima_model_set(s : TimeseriessarimaModel, i : Int, v : Double) -> TimeseriessarimaModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_model_sum(s : TimeseriessarimaModel) -> Double { @_common.sum(s.data) }

pub fn timeseries_sarima_model_mean(s : TimeseriessarimaModel) -> Double { @_common.mean(s.data) }

pub fn timeseries_sarima_model_scale(s : TimeseriessarimaModel, f : Double) -> TimeseriessarimaModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_model_add(a : TimeseriessarimaModel, b : TimeseriessarimaModel) -> TimeseriessarimaModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_sarima_model_copy(s : TimeseriessarimaModel) -> TimeseriessarimaModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_model_fill(s : TimeseriessarimaModel, v : Double) -> TimeseriessarimaModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_model_min(s : TimeseriessarimaModel) -> Double { @_common.min(s.data) }

pub fn timeseries_sarima_model_max(s : TimeseriessarimaModel) -> Double { @_common.max(s.data) }

pub fn timeseries_sarima_model_to_string(s : TimeseriessarimaModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriessarimaLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_sarima_layer_make(size : Int) -> TimeseriessarimaLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_sarima_layer_len(s : TimeseriessarimaLayer) -> Int { s.size }

pub fn timeseries_sarima_layer_get(s : TimeseriessarimaLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_sarima_layer_set(s : TimeseriessarimaLayer, i : Int, v : Double) -> TimeseriessarimaLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_layer_sum(s : TimeseriessarimaLayer) -> Double { @_common.sum(s.data) }

pub fn timeseries_sarima_layer_mean(s : TimeseriessarimaLayer) -> Double { @_common.mean(s.data) }

pub fn timeseries_sarima_layer_scale(s : TimeseriessarimaLayer, f : Double) -> TimeseriessarimaLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_layer_add(a : TimeseriessarimaLayer, b : TimeseriessarimaLayer) -> TimeseriessarimaLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_sarima_layer_copy(s : TimeseriessarimaLayer) -> TimeseriessarimaLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_layer_fill(s : TimeseriessarimaLayer, v : Double) -> TimeseriessarimaLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_layer_min(s : TimeseriessarimaLayer) -> Double { @_common.min(s.data) }

pub fn timeseries_sarima_layer_max(s : TimeseriessarimaLayer) -> Double { @_common.max(s.data) }

pub fn timeseries_sarima_layer_to_string(s : TimeseriessarimaLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriessarimaBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_sarima_buffer_make(size : Int) -> TimeseriessarimaBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_sarima_buffer_len(s : TimeseriessarimaBuffer) -> Int { s.size }

pub fn timeseries_sarima_buffer_get(s : TimeseriessarimaBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_sarima_buffer_set(s : TimeseriessarimaBuffer, i : Int, v : Double) -> TimeseriessarimaBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_buffer_sum(s : TimeseriessarimaBuffer) -> Double { @_common.sum(s.data) }

pub fn timeseries_sarima_buffer_mean(s : TimeseriessarimaBuffer) -> Double { @_common.mean(s.data) }

pub fn timeseries_sarima_buffer_scale(s : TimeseriessarimaBuffer, f : Double) -> TimeseriessarimaBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_buffer_add(a : TimeseriessarimaBuffer, b : TimeseriessarimaBuffer) -> TimeseriessarimaBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_sarima_buffer_copy(s : TimeseriessarimaBuffer) -> TimeseriessarimaBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_buffer_fill(s : TimeseriessarimaBuffer, v : Double) -> TimeseriessarimaBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_buffer_min(s : TimeseriessarimaBuffer) -> Double { @_common.min(s.data) }

pub fn timeseries_sarima_buffer_max(s : TimeseriessarimaBuffer) -> Double { @_common.max(s.data) }

pub fn timeseries_sarima_buffer_to_string(s : TimeseriessarimaBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriessarimaCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_sarima_cursor_make(size : Int) -> TimeseriessarimaCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_sarima_cursor_len(s : TimeseriessarimaCursor) -> Int { s.size }

pub fn timeseries_sarima_cursor_get(s : TimeseriessarimaCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_sarima_cursor_set(s : TimeseriessarimaCursor, i : Int, v : Double) -> TimeseriessarimaCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_cursor_sum(s : TimeseriessarimaCursor) -> Double { @_common.sum(s.data) }

pub fn timeseries_sarima_cursor_mean(s : TimeseriessarimaCursor) -> Double { @_common.mean(s.data) }

pub fn timeseries_sarima_cursor_scale(s : TimeseriessarimaCursor, f : Double) -> TimeseriessarimaCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_cursor_add(a : TimeseriessarimaCursor, b : TimeseriessarimaCursor) -> TimeseriessarimaCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_sarima_cursor_copy(s : TimeseriessarimaCursor) -> TimeseriessarimaCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_cursor_fill(s : TimeseriessarimaCursor, v : Double) -> TimeseriessarimaCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_cursor_min(s : TimeseriessarimaCursor) -> Double { @_common.min(s.data) }

pub fn timeseries_sarima_cursor_max(s : TimeseriessarimaCursor) -> Double { @_common.max(s.data) }

pub fn timeseries_sarima_cursor_to_string(s : TimeseriessarimaCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriessarimaView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_sarima_view_make(size : Int) -> TimeseriessarimaView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_sarima_view_len(s : TimeseriessarimaView) -> Int { s.size }

pub fn timeseries_sarima_view_get(s : TimeseriessarimaView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_sarima_view_set(s : TimeseriessarimaView, i : Int, v : Double) -> TimeseriessarimaView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_view_sum(s : TimeseriessarimaView) -> Double { @_common.sum(s.data) }

pub fn timeseries_sarima_view_mean(s : TimeseriessarimaView) -> Double { @_common.mean(s.data) }

pub fn timeseries_sarima_view_scale(s : TimeseriessarimaView, f : Double) -> TimeseriessarimaView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_view_add(a : TimeseriessarimaView, b : TimeseriessarimaView) -> TimeseriessarimaView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_sarima_view_copy(s : TimeseriessarimaView) -> TimeseriessarimaView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_view_fill(s : TimeseriessarimaView, v : Double) -> TimeseriessarimaView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_view_min(s : TimeseriessarimaView) -> Double { @_common.min(s.data) }

pub fn timeseries_sarima_view_max(s : TimeseriessarimaView) -> Double { @_common.max(s.data) }

pub fn timeseries_sarima_view_to_string(s : TimeseriessarimaView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriessarimaRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_sarima_range_make(size : Int) -> TimeseriessarimaRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_sarima_range_len(s : TimeseriessarimaRange) -> Int { s.size }

pub fn timeseries_sarima_range_get(s : TimeseriessarimaRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_sarima_range_set(s : TimeseriessarimaRange, i : Int, v : Double) -> TimeseriessarimaRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_range_sum(s : TimeseriessarimaRange) -> Double { @_common.sum(s.data) }

pub fn timeseries_sarima_range_mean(s : TimeseriessarimaRange) -> Double { @_common.mean(s.data) }

pub fn timeseries_sarima_range_scale(s : TimeseriessarimaRange, f : Double) -> TimeseriessarimaRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_range_add(a : TimeseriessarimaRange, b : TimeseriessarimaRange) -> TimeseriessarimaRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_sarima_range_copy(s : TimeseriessarimaRange) -> TimeseriessarimaRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_range_fill(s : TimeseriessarimaRange, v : Double) -> TimeseriessarimaRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_range_min(s : TimeseriessarimaRange) -> Double { @_common.min(s.data) }

pub fn timeseries_sarima_range_max(s : TimeseriessarimaRange) -> Double { @_common.max(s.data) }

pub fn timeseries_sarima_range_to_string(s : TimeseriessarimaRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriessarimaSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_sarima_slice_make(size : Int) -> TimeseriessarimaSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_sarima_slice_len(s : TimeseriessarimaSlice) -> Int { s.size }

pub fn timeseries_sarima_slice_get(s : TimeseriessarimaSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_sarima_slice_set(s : TimeseriessarimaSlice, i : Int, v : Double) -> TimeseriessarimaSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_slice_sum(s : TimeseriessarimaSlice) -> Double { @_common.sum(s.data) }

pub fn timeseries_sarima_slice_mean(s : TimeseriessarimaSlice) -> Double { @_common.mean(s.data) }

pub fn timeseries_sarima_slice_scale(s : TimeseriessarimaSlice, f : Double) -> TimeseriessarimaSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_slice_add(a : TimeseriessarimaSlice, b : TimeseriessarimaSlice) -> TimeseriessarimaSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_sarima_slice_copy(s : TimeseriessarimaSlice) -> TimeseriessarimaSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_slice_fill(s : TimeseriessarimaSlice, v : Double) -> TimeseriessarimaSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_sarima_slice_min(s : TimeseriessarimaSlice) -> Double { @_common.min(s.data) }

pub fn timeseries_sarima_slice_max(s : TimeseriessarimaSlice) -> Double { @_common.max(s.data) }

pub fn timeseries_sarima_slice_to_string(s : TimeseriessarimaSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

